Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261393AbUCDBln (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 20:41:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261396AbUCDBln
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 20:41:43 -0500
Received: from ozlabs.org ([203.10.76.45]:15768 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261393AbUCDBlT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 20:41:19 -0500
Subject: Re: [ANNOUNCE] kpatchup 0.02 kernel patching script
From: Rusty Russell <rusty@rustcorp.com.au>
To: Matt Mackall <mpm@selenic.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040303022444.GA3883@waste.org>
References: <20040303022444.GA3883@waste.org>
Content-Type: multipart/mixed; boundary="=-a7pe36WBGo9chcFxZf9p"
Message-Id: <1078364436.849.0.camel@bach>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 04 Mar 2004 12:40:36 +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-a7pe36WBGo9chcFxZf9p
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, 2004-03-03 at 13:24, Matt Mackall wrote: 
> This is the first release of kpatchup, a script for managing switching
> between kernel releases via patches with some smarts:

Hi Matt!

Please find below my grab_kernel, latest-kernel-version and lkvercmp
scripts, in case they are useful for you to merge.  Kinda
rough, like any unexposed code...

Rusty


-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell

--=-a7pe36WBGo9chcFxZf9p
Content-Disposition: attachment; filename=lkvercmp
Content-Type: text/x-sh; name=lkvercmp; charset=iso-8859-1
Content-Transfer-Encoding: 7bit

#! /bin/sh
# Compare multiple kernel versions

# Return more recent of two kernel versions.
if [ $# -eq 0 ]; then
    echo Usage: $0 kernelversion kernelversion ... >&2
    echo Returns greatest of the versions. >&2
    exit 1
fi

unknown()
{
    # Does a -dj kernel come before a -ac kernel?  Or a Linus kernel?
    # Undefined.
    echo Can\'t compare extension \'"$1"\'. >&2
    exit 1
}

firstpart()
{
    echo $1 | sed 's/[-.].*//'
}

lastpart()
{
    echo $1 | sed 's/.*[-.]//'
}

trimlastpart()
{
    echo $1 | sed 's/[-.][^-.]*$//'
}

trimfirstpart()
{
    echo $1 | sed 's/^[^-.]*[-.]//'
}

letters()
{
    echo $1 | tr -d '[0-9]'
}

numbers()
{
    echo $1 | tr -dc '[0-9]'
}

if [ $# -eq 1 ]; then
    echo "$1"
    exit 0
fi

if [ $# -gt 2 ]; then
    FIRST=$1
    shift
    set -- $FIRST $($0 "$@")
fi

VER1=$1
VER2=$2

# Vanity kernels (at end): handle 2.6.3-mm2 vs 2.6.3-rc1-mm3 by comparing
# base first.
TAIL1=$(lastpart $VER1)
TAIL2=$(lastpart $VER2)
if [ x"$(letters $TAIL1)" = x"$(letters $TAIL2)" ]; then
    case "$TAIL1" in
    bk*|rc*|pre*) : ;;
    *)
	BASE1=$(trimlastpart $VER1)
	BASE2=$(trimlastpart $VER2)
	if [ x"$BASE1" = x"$BASE2" ]; then
	    if [ $(numbers $TAIL1) -gt $(numbers $TAIL2) ]; then
		echo $1
	    else
		echo $2
	    fi
	else
	    if [ x$(lkvercmp $BASE1 $BASE2) = x$BASE1 ]; then
		echo $1
	    else
		echo $2
	    fi
	fi
	exit
	;;
   esac
fi

while true; do
    PART1=$(firstpart $VER1)
    PART2=$(firstpart $VER2)
    VER1=$(trimfirstpart $VER1)
    VER2=$(trimfirstpart $VER2)

    PART1LETTERS=$(letters $PART1)
    PART2LETTERS=$(letters $PART2)
    PART1NUMBERS=$(numbers $PART1)
    PART2NUMBERS=$(numbers $PART2)

    if [ "$PART1LETTERS" = "$PART2LETTERS" ]; then
	if [ "$PART1NUMBERS" = "$PART2NUMBERS" ]; then
	    continue;
	else
	    if [ "$PART1NUMBERS" -gt "$PART2NUMBERS" ]; then
		echo $1; exit
	    else
		echo $2; exit
	    fi
        fi
    fi

    case x"$PART1LETTERS" in
    xbk)
        # bk snapshots come after (ie. 2.6.1-bk1 is > 2.6.1).
	# So this always wins.
	case x"$PART2LETTERS" in
	x|xrc|xpre) echo $1; exit;;
	esac
	unknown $PART2LETTERS;;
    x)
	# Final beats everything except bk.
	case x"$PART2LETTERS" in
	xbk) echo $2; exit;;
	xrc|xpre) echo $1; exit;;
	esac
	unknown $PART2LETTERS;;
    xrc)
	# Only a final or bk can win.
	case x"$PART2LETTERS" in
        x|xbk) echo $2; exit;;
	xpre) echo $1; exit;;
        esac
	unknown $PART2LETTERS;;
    xpre)
        # Final, bk or rc can win.
	case x"$PART2LETTERS" in
        x|xbk|xrc) echo $2; exit;;
	xpre) echo $1; exit;;
        esac
	unknown $PART2LETTERS;;
    *)
	unknown $PART1LETTERS;;
    esac
done

--=-a7pe36WBGo9chcFxZf9p
Content-Disposition: attachment; filename=latest-kernel-version
Content-Type: text/x-sh; name=latest-kernel-version; charset=iso-8859-1
Content-Transfer-Encoding: 7bit

#! /bin/sh -e
# Latest kernel version of this vintage.

KERNELDIR=~/devel/kernel

# Return the latest kernel versions.
get_kernel_vers()
{
#     if [ x"$GK_KERNS" = x ]; then
# 	GK_KERNS=$(finger @finger.kernel.org | tail +2 | cut -s -d: -f2- | sed 's/[ 	]*//')
#     fi
    if [ x"$GK_KERNS" = x ]; then
	GK_KERNS=$(lynx -width=500 -dump http://www.kernel.org/kdist/finger_banner | tail +2 | cut -s -d: -f2- | sed 's/[ 	]*//')
    fi
    if [ x"$GK_KERNS" = x ]; then
	echo Failed to get kernel list from kernel.org >&2
	exit 1
    fi
    # Vanity are there too: only take recognized patches.
    # Ignore 2.4-bk versions: I don't know where they're coming from 8(
    echo "$GK_KERNS" # | egrep -- "$1|-rc|-bk|-pre|^[0-9]*\.[0-9]*\.[0-9]*\$" | grep -v '2\.4\.[0-9]*-bk[0-9]*'
}


PROBE=0
if [ x"$1" = x--probe ]; then
    PROBE=1
    shift
fi

case "$1" in --*)
    echo "Usage: $0 [--probe] [kernel-base-version]" >&2
    echo "Returns the latest version on the system, or with --probe," >&2
    echo "returns the latest version on network." >&2
    exit 1
    ;;
esac

if [ $# -eq 0 ]; then set .; fi

if [ $PROBE = 1 ]; then
    CANDIDATES=$(get_kernel_vers)
else
    CANDIDATES=$(cd $KERNELDIR && ls -d linux-* | fgrep -v '.tmp' | grep -v -- '-ppc' | sed 's/^linux-//')
fi

for w; do
    case "$w" in
	# By default, ignore any vanity kernels.
	.) FILTER="^[0-9.]*(-rc[0-9]*|-bk[0-9]*|-pre[0-9]*)*\$";;
	# eg -mm.
	-*) FILTER="^[0-9.]*(-rc[0-9]*|-bk[0-9]*|-pre[0-9]*)*$w[0-9]*\$";;
	# eg. 2.4
	*) FILTER="^$w[0-9.]*(-rc[0-9]*|-bk[0-9]*|-pre[0-9]*)*\$";;
    esac

    lkvercmp $(echo "$CANDIDATES" | egrep -- "$FILTER")
done



--=-a7pe36WBGo9chcFxZf9p
Content-Disposition: attachment; filename=grab-kernel
Content-Type: text/x-sh; name=grab-kernel; charset=iso-8859-1
Content-Transfer-Encoding: 7bit

#! /bin/sh -e
# Script to grab a given kernel version (stolen from Virtual Anton).

barf()
{
    echo "$@" >&2
    exit 1
}

PATCHDIR=~/devel/kernel/kernel-patches
MIRRORS="rsync://kernel::kernel http://kernel.linux.pacific.net.au/linux/kernel/ rsync://master.kernel.org:/pub/linux/kernel"
#MIRRORS="rsync.planetmirror.com::ftp.kernel.org/pub/linux/kernel master.kernel.org:/pub/linux/kernel"

# Takes destination directory, and filename, tries each mirror.
get_file()
{
    get_file_dir=$1
    get_file_name=$2

    # Patch there already?
    if [ -f "$get_file_dir"/"$(basename "$get_file_name")" ]; then
	echo " Already have patch..."
	return 0
    fi

    for get_file_server in $MIRRORS; do
	echo Trying $get_file_server...
	case $get_file_server in
	rsync://*) get_file_s=`echo $get_file_server | cut -c9-`;
		  rsync $get_file_s/$get_file_name $get_file_dir && return 0
		  ;;
	http://*) get_file_s=`echo $get_file_server | cut -c8-`;
		wget -O $get_file_dir/`basename $get_file_name` $get_file_s/$get_file_name && return 0
		# Leaves a zero-len file on failure 8(
		rm -f $get_file_dir/`basename $get_file_name`
		;;
	esac
    done
    return 1
}

if [ $# -ne 2 ]; then
    echo Usage: $0 version kerneldir >&2
    exit 1
fi

VERSION=$1
KDIR=$2

if [ -d $KDIR/linux-$VERSION ]; then exit 0; fi
MAJOR=`echo $VERSION | cut -d. -f1-2`

# Given vanity kernel name, major version, and previous version, produce pathname
vanity_source()
{
    case "$1" in
    *-ac*)
	echo people/alan/linux-$2/$3/patch-$1.bz2;;
    *-dj*)
	echo people/davej/patches/$2/$3/patch-$1.bz2;;
    *-mm*)
	echo people/akpm/patches/$2/$3/$1/$1.bz2;;
    *)
	barf "Unknown kernel series $1";;
    esac
}

# Given base name, new name and patch, do patch application.
apply_patch()
{
    rm -rf $KDIR/.linux-$2
    cp -al $KDIR/linux-$1 $KDIR/.linux-$2 ||
	    barf "Couldn't clone $1 dir"
    bunzip2 -t $3 || barf "Corrupt patch $3"
    bzcat $3 | patch -s -d $KDIR/.linux-$2 -p1 ||
	    barf "Problem patching new kernel $2"
    mv $KDIR/.linux-$2 $KDIR/linux-$2
}

echo Grabbing $VERSION
case "$VERSION" in
    # Bitkeeper snapshot
    *-bk*)
	if [ -d $KDIR/linux-$VERSION ]; then exit 0; fi

	PREVIOUS=`echo "$VERSION" | sed 's/-bk.*//'`
	$0 "$PREVIOUS" $KDIR || barf "Couldn't get $PREVIOUS to build $VERSION"

	# Grab patch
	get_file $PATCHDIR v$MAJOR/snapshots/patch-$VERSION.bz2  || barf "Couldn't get v$MAJOR/snapshots/patch-$VERSION.bz2"
	apply_patch $PREVIOUS $VERSION $PATCHDIR/patch-$VERSION.bz2
	;;

    # Various vanity patches
    *-mm[0-9]*|*-ac[0-9]*|*-dj[0-9]*)
	# First make sure we have base tree
	BASE_KERNEL=`echo "$VERSION" | sed -e 's/-[a-z][a-z][0-9]*$//'`
	$0 "$BASE_KERNEL" $KDIR	||
	    barf "Couldn't get $BASE_KERNEL to build $VERSION"
	VANITY=`vanity_source $VERSION $MAJOR $BASE_KERNEL`
	get_file $PATCHDIR $VANITY ||
		barf "Couldn't fetch $VANITY"

	apply_patch $BASE_KERNEL $VERSION $PATCHDIR/`basename $VANITY`
	;;

    # *-pre*: This refers to the Linus or Marcelo pre-patches.
    *-pre*|*-rc*)
	# Linus or Marcelo pre-patch.
	if [ -d $KDIR/linux-$VERSION ]; then exit 0; fi

	PREVIOUS=`echo "$VERSION" | sed 's/-\(pre\|rc\).*//'`
	LAST_VER=`echo "$PREVIOUS" | cut -d. -f3`
	PREVIOUS=`echo "$PREVIOUS" | cut -d. -f1,2`.`expr $LAST_VER - 1 || true`
	$0 "$PREVIOUS" $KDIR || barf "Couldn't get $PREVIOUS to build $VERSION"

	# Grab patch
	get_file $PATCHDIR v$MAJOR/testing/patch-$VERSION.bz2 ||
	    get_file $PATCHDIR v$MAJOR/testing/old/patch-$VERSION.bz2 ||
	    barf "Couldn't get v$MAJOR/testing/patch-$VERSION.bz2"
	apply_patch $PREVIOUS $VERSION $PATCHDIR/patch-$VERSION.bz2
	;;

    # Linus 2.6.0 test patch.
    2.6.0-test*)
	VER=`echo "$VERSION" | sed 's/.*test//'`
	PREVIOUS=2.6.0-test`expr $VER - 1 || true`

	if [ $PREVIOUS = 2.6.0-test0 ]; then
	    PREVIOUS=2.5.75
	fi

	$0 "$PREVIOUS" $KDIR || barf "Couldn't get $PREVIOUS to build $VERSION"

	# Grab patch
	get_file $PATCHDIR v$MAJOR/patch-$VERSION.bz2 ||
	    get_file $PATCHDIR v$MAJOR/old/patch-$VERSION.bz2 ||
	    barf "Couldn't get v$MAJOR/patch-$VERSION.bz2"
	apply_patch $PREVIOUS $VERSION $PATCHDIR/patch-$VERSION.bz2
	;;

    2.6.0)
	PREVIOUS=2.6.0-test11

	$0 "$PREVIOUS" $KDIR || barf "Couldn't get $PREVIOUS to build $VERSION"

	# Grab patch
	get_file $PATCHDIR v$MAJOR/patch-$VERSION.bz2 ||
	    get_file $PATCHDIR v$MAJOR/old/patch-$VERSION.bz2 ||
	    barf "Couldn't get v$MAJOR/patch-$VERSION.bz2"
	apply_patch $PREVIOUS $VERSION $PATCHDIR/patch-$VERSION.bz2
	;;

    # *.0: This refers to the base of the Linus kernels, fetched whole.
    *.0)
	# Linus' root of all trees.
	get_file $PATCHDIR v$MAJOR/linux-$VERSION.tar.bz2 || barf "Couldn't get  v$MAJOR/linux-$VERSION.tar.bz2"
	bzcat $PATCHDIR/linux-$VERSION.tar.bz2 | (cd $KDIR && tar xf -) ||
	    barf "Problem unpacking linux-$VERSION.tar.bz2"
	mv $KDIR/linux $KDIR/linux-$VERSION
	;;

    #   [1-9].*.*: This refers to the any other Linus kernel.
    [1-9].*.*[0-9])
	# Linus standard ?
	if [ -d $KDIR/linux-$VERSION ]; then exit 0; fi

	LAST_VER=`echo "$VERSION" | cut -d. -f3`
	PREVIOUS=`echo "$VERSION" | cut -d. -f1,2`.`expr $LAST_VER - 1 || true`
	$0 "$PREVIOUS" $KDIR || barf "Couldn't get $PREVIOUS to build $VERSION"

	# Grab patch
	get_file $PATCHDIR v$MAJOR/patch-$VERSION.bz2 || barf "Couldn't get v$MAJOR/patch-$VERSION.bz2"
	trap "rm -rf $KDIR/.linux-$VERSION" 0
	apply_patch $PREVIOUS $VERSION $PATCHDIR/patch-$VERSION.bz2
	;;
    *)
	barf "Unknown kernel version $VERSION"
	;;
esac

--=-a7pe36WBGo9chcFxZf9p--

