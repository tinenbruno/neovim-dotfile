call plug#begin('~/.local/share/nvim/plugged')

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Language Agnostic Plugs
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CamelCase and snake_case motions
Plug 'bkad/CamelCaseMotion'
" Automatically closing pair stuff
Plug 'cohama/lexima.vim'
" Heuristically set indent settings
Plug 'tpope/vim-sleuth'

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" Use Ack to search all files
Plug 'mileszs/ack.vim'
" Async run programs
Plug 'neomake/neomake'
" Test running
Plug 'janko-m/vim-test'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Python Plug
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

Plug 'davidhalter/jedi-vim'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Ruby Plug
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

Plug 'vim-ruby/vim-ruby'
" Rails support (:A, :R, :Rmigration, :Rextract)
Plug 'tpope/vim-rails', { 'for': ['ruby'] }
" Bundler support (plays nicely with tpope/gem-ctags)
Plug 'tpope/vim-bundler', { 'for': ['ruby'] }
" Auto insert end when applyable
Plug 'tpope/vim-endwise'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Elixir Plug
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Syntax highlighting and filetype detection
Plug 'elixir-editors/vim-elixir'

" Completion and doc lookup
" Plug 'slashmili/alchemist.vim'

" Mix formatter
Plug 'mhinz/vim-mix-format'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => HTML Plug
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

Plug 'rstacruz/sparkup', { 'rtp': 'vim' }

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Themes Plug
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'reewr/vim-monokai-phoenix'
Plug 'cocopon/iceberg.vim'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Vim interface improvement Plugs
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

Plug 'ctrlpvim/ctrlp.vim'
" Lightline (simple status line)
Plug 'itchyny/lightline.vim'
" Buffers tabline
Plug 'ap/vim-buftabline'
" Nerd tree
Plug 'scrooloose/nerdtree'
" Git Nerd tree
Plug 'Xuyuanp/nerdtree-git-plugin'
" Editor Config
Plug 'editorconfig/editorconfig-vim'

" Intelligent buffer closing
Plug 'mhinz/vim-sayonara', { 'on': 'Sayonara' }

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Vim LSP
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'prabirshrestha/async.vim'

Plug 'prabirshrestha/vim-lsp'

Plug 'prabirshrestha/asyncomplete.vim'

call plug#end()

if has('termguicolors')
  set termguicolors
endif

filetype plugin indent on

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" when indenting with '>', use 2 spaces width
" Be smart when using tabs ;)
set smarttab
set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Always show current position
set ruler

" Height of the command bar
set cmdheight=1

" A buffer becomes hidden when it is abandoned
set hid

" Show matching brackets when text indicator is over them
set showmatch 
" How many tenths of a second to blink when matching brackets
set mat=2

set nu

set cursorline   " highlight current line

set noshowmode

let g:lightline = {
  \ 'colorscheme': 'solarized',
  \ 'component_function': {
  \    'filename': 'LightLineFilename'
  \ } 
  \ }
function! LightLineFilename()
  return expand('%')
endfunction
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
set noswapfile

if has('nvim')
  let g:loaded_python_provider=1                        " Disable python 2 interface
  let g:python_host_skip_check=1                        " Skip python 2 host check
  let g:python3_host_prog='/usr/bin/python'             " Set python 3 host program
  set inccommand=nosplit                                " Live preview of substitutes and other similar commands
endif

""""""""""""""""""""""""""""""
" => Status line
""""""""""""""""""""""""""""""
" Always show the status line
set laststatus=2

" Format the status line
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l\ \ Column:\ %c

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remap VIM 0 to first non-blank character
map 0 ^

" Move a line of text using ALT+[jk] or Command+[jk] on mac
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

if has("mac") || has("macunix")
  nmap <D-j> <M-j>
  nmap <D-k> <M-k>
  vmap <D-j> <M-j>
  vmap <D-k> <M-k>
endif

" Delete trailing white space on save, useful for Python and CoffeeScript ;)
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
autocmd BufWrite *.py :call DeleteTrailingWS()
autocmd BufWrite *.coffee :call DeleteTrailingWS()

" Quick save and close buffer
nnoremap ,w :w<CR>
nnoremap <silent> ,c :Sayonara!<CR>
nnoremap <silent> ,q :Sayonara<CR>

" Intelligent windows resizing using ctrl + arrow keys
nnoremap <silent> <C-Right> :call utils#intelligentVerticalResize('right')<CR>
nnoremap <silent> <C-Left> :call utils#intelligentVerticalResize('left')<CR>
nnoremap <silent> <C-Up> :resize +1<CR>
nnoremap <silent> <C-Down> :resize -1<CR>

" Buffers navigation and management
nnoremap <silent> + :bn<CR>
nnoremap <silent> _ :bp<CR>

" Use CamelCaseMotion instead of default motions
map <silent> w <Plug>CamelCaseMotion_w
map <silent> b <Plug>CamelCaseMotion_b
map <silent> e <Plug>CamelCaseMotion_e
map <silent> ge <Plug>CamelCaseMotion_ge
sunmap w
sunmap b
sunmap e
sunmap ge

function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    endif
    return ''
endfunction


colorscheme iceberg 

" autocmd vimenter * NERDTree

map <C-n> :NERDTreeToggle<CR>

nnoremap ; :

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Nerdtree settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:NERDTreeMinimalUI=1
let g:NERDTreeWinSize=30
let g:NERDTreeAutoDeleteBuffer=1
let g:NERDTreeShowHidden=1
let g:NERDTreeHighlightCursorline=0
let g:NERDTreeRespectWildIgnore=1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Deoplete settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:deoplete#enable_at_startup=1
let g:deoplete#enable_refresh_always=0
let g:deoplete#enable_smart_case=1
let g:deoplete#file#enable_buffer_path=1

let g:deoplete#sources={}
let g:deoplete#sources._    = ['around', 'buffer', 'file', 'ultisnips']
let g:deoplete#sources.ruby = ['around', 'buffer', 'member', 'file', 'ultisnips']
let g:deoplete#sources.vim  = ['around', 'buffer', 'member', 'file', 'ultisnips']
let g:deoplete#sources['javascript.jsx'] = ['around', 'buffer', 'file', 'ultisnips', 'ternjs']
let g:deoplete#sources.css  = ['around', 'buffer', 'member', 'file', 'omni', 'ultisnips']
let g:deoplete#sources.scss = ['around', 'buffer', 'member', 'file', 'omni', 'ultisnips']
let g:deoplete#sources.html = ['around', 'buffer', 'member', 'file', 'omni', 'ultisnips']

" Insert <TAB> or select next match
inoremap <silent> <expr> <Tab> utils#tabComplete()

" Manually trigger tag autocomplete
inoremap <silent> <expr> <C-]> utils#manualTagComplete()

" <C-h>, <BS>: close popup and delete backword char
inoremap <expr><C-h> deoplete#mappings#smart_close_popup()."\<C-h>"
inoremap <expr><BS> deoplete#mappings#smart_close_popup()."\<C-h>"

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Neomake settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call neomake#configure#automake('w')

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Vim Test settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let test#strategy = "neovim"
nmap <silent> <leader>t :TestNearest<CR>
nmap <silent> <leader>T :TestFile<CR>
nmap <silent> <leader>a :TestSuite<CR>
nmap <silent> <leader>l :TestLast<CR>
nmap <silent> <leader>g :TestVisit<CR>
let g:ackprg = 'ag --nogroup --nocolor --column'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Vim Elixir LSP
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup elixir_lsp
  au!
  au User lsp_setup call lsp#register_server({
    \ 'name': 'elixir-ls',
    \ 'cmd': {server_info->[&shell, &shellcmdflag, 'env ERL_LIBS=/home/bruno/vim_libs/elixir-ls/lsp mix elixir_ls.language_server']},
    \ 'whitelist': ['elixir', 'eelixir'],
    \ })
augroup END

let g:lsp_signs_enabled = 1
let g:lsp_diagnostics_echo_cursor = 1

" Auto format on saving Elixir
let g:mix_format_on_save = 1
