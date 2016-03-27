
[[ -s "$HOME/.profile" ]] && source "$HOME/.profile" # Load the default .profile

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi

source /Users/szymonwlochowski/otb.sh

export PATH=/usr/local/bin:$PATH
export CC=gcc

export RUBY_GC_MALLOC_LIMIT=1000000000
### 2.0 down
export RUBY_FREE_MIN=500000
export RUBY_HEAP_MIN_SLOTS=40000

### 2.0 up
export RUBY_GC_HEAP_FREE_SLOTS=500000
export RUBY_GC_HEAP_INIT_SLOTS=40000

test -f ~/.bashrc && source ~/.bashrc

if [[ -n "$PS1" ]] ; then

export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
export HISTCONTROL=ignoreboth

shopt -s histappend
shopt -s checkwinsize

case "$TERM" in
  xterm-color) color_prompt=yes;;
esac

force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
  color_prompt=yes
    else
  color_prompt=
    fi
fi

parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/[\1]/'
}

source ~/.bash_colors

function parse_ruby_version {
 ruby -v | cut -d " " -f2
}

PS1="$COLOR_RED\u $COLOR_YELLOW<\$(parse_ruby_version)> $COLOR_WHITE\$(parse_git_branch)$COLOR_WHITE $COLOR_LIGHT_BLUE\W$COLOR_WHITE > "
case `id -u` in
  0) PS1="${PS1}\n# \[\033[0m\]";;
  *) PS1="${PS1}\n$ \[\033[0m\]";;
esac

unset color_prompt force_color_prompt

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    eval "`dircolors -b`"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias grep='grep --color=auto'
fi

fi