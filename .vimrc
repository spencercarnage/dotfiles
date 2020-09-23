set nocompatible " Required for Vundle
filetype off " Required for Vundle

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Vundle plugins go here

" Ale
" show previer window cursor is on line with problem; need this before
" installing
let g:ale_cursor_detail = 0

Plugin 'dense-analysis/ale'
" Plugin 'sdeleon28/ale'

Plugin 'editorconfig/editorconfig-vim'
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'
Plugin 'scrooloose/nerdtree'
Plugin 'vim-airline/vim-airline'
Plugin 'leafgarland/typescript-vim'
Plugin 'Quramy/tsuquyomi'
Plugin 'mxw/vim-jsx'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-repeat'
Plugin 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plugin 'junegunn/fzf.vim'
Plugin 'ycm-core/YouCompleteMe'

" All of your Plugins must be added before the following line
call vundle#end()         " required for Vundle
filetype plugin indent on " required for Vundle

set swapfile
set dir=~/.vim/.tmp

" Syntax
syntax enable " enable syntax processing

" Spaces & Tabs
set tabstop=2       " number of visual spaces per TAB
set softtabstop=2   " number of spaces in TAB when editing
set expandtab       " TABs are spaces
set shiftwidth=2    " shift+>

" Display tabs as '>-...'
set list
set listchars=tab:>-

" JavaScript (tab width 2 chr, wrap at 79th)
autocmd FileType javascript set sw=2
autocmd FileType javascript set ts=2
autocmd FileType javascript set sts=2
autocmd FileType javascript set textwidth=119

" High light the column that breaks 80 characters
highlight ColorColumn ctermbg=magenta
call matchadd('Colorcolumn', '\%81v', 100)

" UI Layout
set number " show line numbers
set showcmd " show command in bottom bar
set cursorline " highlight current line
set wildmenu " visual autocomplete for command menu

" redraw only when we need to
set lazyredraw

" highlight matching [{()}]
set showmatch

" Search
set ignorecase " case-insensitive search
set hlsearch
set incsearch " search as characters are entered
set hlsearch " highlight matches
"" clear last search highlighting
map <Space> :noh<cr>

" Folding
set foldenable " enable folding
set foldlevelstart=10 " open most folds by default
set foldnestmax=10 " 10 nested fold max
nnoremap <leader><space> za
set foldmethod=indent " fold based on indent level

" Line Shortcuts
" move vertically by visual line
nnoremap j gj
nnoremap k gk

" move to beginning/end of line
nnoremap B ^
nnoremap E $

" $/^ doesn't do anything
nnoremap $ <nop>
nnoremap ^ <nop>

" highlight last inserted text
nnoremap gV `[v`]

" leader is comma
let mapleader=","

" jj for escape
inoremap jj <esc>

" Leader Shortcuts
" edit vimrc/zshrc and load vimrc bindings
nnoremap <leader>ev :e $MYVIMRC<CR>
nnoremap <leader>ez :e ~/.zshrc<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>

" save session
nnoremap <leader>s :mksession<CR>

" open ag.vim
nnoremap <leader>a :Ag

set runtimepath^=~/.vim/bundle/ag

" Buffers
" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1

" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'

" This allows buffers to be hidden if you've modified a buffer.
" This is almost a must if you wish to use buffers in this way.
set hidden

" To open a new empty buffer
" This replaces :tabnew which I used to bind to this mapping
nmap <leader>T :enew<cr>

" Move to the next buffer
nmap <leader>l :bnext<CR>

" Move to the previous buffer
nmap <leader>h :bprevious<CR>

" Close the current buffer and move to the previous one
" This replicates the idea of closing a tab
nmap <leader>bq :bp <BAR> bd #<CR>

" Show all open buffers and their status
nmap <leader>bl :ls<CR>

" fzf stuff
set rtp+=/usr/local/opt/fzf
nmap ; :Buffers<CR>
nmap <Leader>t :Files<CR>
nmap <Leader>r :Tags<CR>

"  Backups
set backup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set backupskip=/tmp/*,/private/tmp/*
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set writebackup
set backupcopy=yes

" JSX highlighting for .js files
let g:jsx_ext_required = 0

" Enable HTML/CSS highlighting in JS files
let g:javascript_enable_domhtmlcss=1

" ALE
autocmd FileType javascript let g:ale_linters = {
\ 'javascript': glob('.eslintrc*', '.;') != '' ? [ 'eslint' ] : [ 'standard' ],
\ 'typescript': ['tsserver', 'tslint']
\}

let g:ale_fixers = {
\ '*': ['remove_trailing_lines', 'trim_whitespace'],
\ 'typescript': ['prettier']
\}

let g:ale_fix_on_save = 1
let g:ale_open_list = 1
highlight clear ALEErrorSign " otherwise uses error bg color
highlight clear ALEWarningSign " otherwise uses error bg color
let g:ale_sign_error = 'X'
let g:ale_sign_warning = '?'
let g:ale_statusline_format = ['X %d', '? %d', '']
let g:ale_echo_msg_format = '%linter%: %s'

nnoremap <leader>an :ALENextWrap<cr>
nnoremap <leader>ap :ALEPreviousWrap<cr>

let g:ycm_autoclose_preview_wuindow_after_completion = 1

let g:ycm_filter_diagnostics = {
\ "javascript": {
\   "regex": ["ts file"],
\ }
\}

" Set filetype for typescript
autocmd BufNewFile,BufRead *.ts setlocal filetype=typescript

" NERDTree
" open nerdtree if no file specified when opening vim
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" open directory in nerdtree if opening a directory
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif

" open nerdtree with Ctrl+n
map <C-n> :NERDTreeToggle<CR>

" close nerdtree if open and closing all files
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" show dot files
let NERDTreeShowHidden = 1


let g:indentLine_fileTypeExcluded=['help']
let g:indentLine_bufNameExcluded = ['NERDTree.*']

" editconfig works well with vim-fugitive
let g:EditorConfig_exclude_patterns = ['fugitive://.*']

set showmode

" Colors
colorscheme badwolf
