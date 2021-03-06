if   [ -f ../ssland.py ]; then cd .. ; fi

[ ! -f ssland.py ] && { echo "Please run this script on SSLand directory." >&2; exit 1; }
# [ ! $EUID = 0 ] && { echo "The root privilege is required. Aborting." >&2; exit 1; }

(python -V 2>&1 | grep -Pq ' (2\.[7]|3\.)') || {
    >&2 echo "Python (>=2.7) not found. Aborting."
    exit 1
}
(>/dev/null 2>&1 type pip) || {
    >&2 echo "Python pip not found. Aborting."
    exit 1
}

(>/dev/null 2>&1 type ssserver) || {
    >&2 echo "ssserver is not found. Aborting."
    exit 1
}

(>/dev/null 2>&1 python -c "from shadowsocks import daemon") || {
    >&2 echo "ssserver installed, but not Python version. Aborting."
    exit 1
}

confirm () {
    read -p "${1:-Are you sure?} [y/N] " response
    case $response in
        [yY]*) true;;
        *) false;;
    esac
}

read2 () {
    read -p "$1 [ default: $2 ] = " xi
    echo ${xi:-$2}
}
