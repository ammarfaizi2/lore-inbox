Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276489AbRI2Mim>; Sat, 29 Sep 2001 08:38:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276490AbRI2Mie>; Sat, 29 Sep 2001 08:38:34 -0400
Received: from mta06-svc.ntlworld.com ([62.253.162.46]:2953 "EHLO
	mta06-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id <S276489AbRI2Mi1>; Sat, 29 Sep 2001 08:38:27 -0400
Date: Sat, 29 Sep 2001 13:38:53 +0100
From: "Dr. David Alan Gilbert" <gilbertd@treblig.org>
To: alan@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: -ac option for scripts/patch-kernel
Message-ID: <20010929133853.J365@tardis>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="17pEHd4RhPHOinZp"
Content-Disposition: inline
User-Agent: Mutt/1.3.22i
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/2.4.9-ac10 (alpha)
X-Uptime: 13:33:59 up 16:46,  5 users,  load average: 0.59, 0.94, 0.90
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--17pEHd4RhPHOinZp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,
  Please find attached a replacement for linux/scripts/patch-kernel
(The diff was larger than the file)

  It adds a -ac option, so you can do

	patch-kernel . .. 2.4.9 -ac

	For example on a 2.4.x source tree and upgrade it to 2.4.9 and apply the
latest ac patch in the patch directory.

  or

	patch-kernel . .. 2.4.9 -ac14

	To use the -ac14 patch instead of the latest

	or

	patch-kernel . .. -ac

	To upgrade to the latest Linus kernel and then apply the latest -ac patch
for it.

  I've given it a reasonably heavy test, but would welcome suggestions/comments.

One known issue is that:

  patch-kernel . .. -ac 2.4.9

  Is invalid and is not warned about (the base kernel version must be $3)

I also fixed a case where the stop version was checked too late.

Enjoy,

Dave

 ---------------- Have a happy GNU millennium! ----------------------   
/ Dr. David Alan Gilbert    | Running GNU/Linux on Alpha,68K| Happy  \ 
\ gro.gilbert @ treblig.org | MIPS,x86,ARM, SPARC and HP-PA | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

--17pEHd4RhPHOinZp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-kernel

#! /bin/sh
# Script to apply kernel patches.
#   usage: patch-kernel [ sourcedir [ patchdir [ stopversion ] [ -acxx ] ] ]
#     The source directory defaults to /usr/src/linux, and the patch
#     directory defaults to the current directory.
# e.g.
#   scripts/patch-kernel . ..
#      Update the kernel tree in the current directory using patches in the
#      directory above to the latest Linus kernel
#   scripts/patch-kernel . .. -ac
#      Get the latest Linux kernel and patch it with the latest ac patch
#   scripts/patch-kernel . .. 2.4.9
#      Gets standard kernel 2.4.9
#   scripts/patch-kernel . .. 2.4.9 -ac
#      Gets 2.4.9 with latest ac patches
#   scripts/patch-kernel . .. 2.4.9 -ac11
#      Gets 2.4.9 with ac patch ac11
#   Note: It uses the patches relative to the Linus kernels, not the
#   ac to ac relative patches
#
# It determines the current kernel version from the top-level Makefile.
# It then looks for patches for the next sublevel in the patch directory.
# This is applied using "patch -p1 -s" from within the kernel directory.
# A check is then made for "*.rej" files to see if the patch was
# successful.  If it is, then all of the "*.orig" files are removed.
#
#       Nick Holloway <Nick.Holloway@alfie.demon.co.uk>, 2nd January 1995.
#
# Added support for handling multiple types of compression. What includes
# gzip, bzip, bzip2, zip, compress, and plaintext. 
#
#       Adam Sulmicki <adam@cfar.umd.edu>, 1st January 1997.
#
# Added ability to stop at a given version number
# Put the full version number (i.e. 2.3.31) as the last parameter
#       Dave Gilbert <linux@treblig.org>, 11th December 1999.

# Fixed previous patch so that if we are already at the correct version
# not to patch up.
#
# Added -ac option, use -ac or -ac9 (say) to stop at a particular version
#       Dave Gilbert <linux@treblig.org>, 29th September 2001.

# Set directories from arguments, or use defaults.
sourcedir=${1-/usr/src/linux}
patchdir=${2-.}
stopvers=${3-imnotaversion}

# See if we have any -ac options
for PARM in $*
do
  case $PARM in
	  -ac*)
		  gotac=$PARM;

	esac;
done

# ---------------------------------------------------------------------------
# Find a file, first parameter is basename of file
# it tries many compression mechanisms and sets variables to say how to get it
function findFile {
  filebase=$1;

  if [ -r ${filebase}.gz ]; then
		ext=".gz"
		name="gzip"
		uncomp="gunzip -dc"
  elif [ -r ${filebase}.bz  ]; then
		ext=".bz"
    name="bzip"
		uncomp="bunzip -dc"
  elif [ -r ${filebase}.bz2 ]; then
		ext=".bz2"
		name="bzip2"
		uncomp="bunzip2 -dc"
  elif [ -r ${filebase}.zip ]; then
		ext=".zip"
		name="zip"
		uncomp="unzip -d"
  elif [ -r ${filebase}.Z ]; then
		ext=".Z"
		name="uncompress"
		uncomp="uncompress -c"
  elif [ -r ${filebase} ]; then
		ext=""
		name="plaintext"
		uncomp="cat"
  else
	  return 1;
	fi

  return 0;
}

# ---------------------------------------------------------------------------
# Apply a patch and check it goes in cleanly
# First param is patch name (e.g. patch-2.4.9-ac5) - without path or extension

function applyPatch {
  echo -n "Applying $1 (${name})... "
  if $uncomp ${patchdir}/$1${ext} | patch -p1 -s -N -E -d $sourcedir
  then
    echo "done."
  else
    echo "failed.  Clean up yourself."
    return 1;
  fi
  if [ "`find $sourcedir/ '(' -name '*.rej' -o -name '.*.rej' ')' -print`" ]
  then
    echo "Aborting.  Reject files found."
    return 1;
  fi
  # Remove backup files
  find $sourcedir/ '(' -name '*.orig' -o -name '.*.orig' ')' -exec rm -f {} \;
 
  return 0;
}

# set current VERSION, PATCHLEVEL, SUBLEVEL, EXTERVERSION
eval `sed -n -e 's/^\([A-Z]*\) = \([0-9]*\)$/\1=\2/p' -e 's/^\([A-Z]*\) = \(-[-a-z0-9]*\)$/\1=\2/p' $sourcedir/Makefile`
if [ -z "$VERSION" -o -z "$PATCHLEVEL" -o -z "$SUBLEVEL" ]
then
    echo "unable to determine current kernel version" >&2
    exit 1
fi

echo "Current kernel version is $VERSION.$PATCHLEVEL.$SUBLEVEL${EXTRAVERSION}"

if [ x$EXTRAVERSION != "x" ]
then
  echo "I'm sorry but patch-kernel can't work with a kernel source tree that is not a base version"
	exit 1;
fi

while :
do
    CURRENTFULLVERSION="$VERSION.$PATCHLEVEL.$SUBLEVEL"
    if [ $stopvers = $CURRENTFULLVERSION ]
    then
        echo "Stoping at $CURRENTFULLVERSION base as requested."
        break
    fi

    SUBLEVEL=`expr $SUBLEVEL + 1`
    FULLVERSION="$VERSION.$PATCHLEVEL.$SUBLEVEL"

    patch=patch-$FULLVERSION

		# See if the file exists and find extension
		findFile $patchdir/${patch} || break

    # Apply the patch and check all is OK
    applyPatch $patch || break
done

if [ x$gotac != x ]; then
  # Out great user wants the -ac patches
	# They could have done -ac (get latest) or -acxx where xx=version they want
	if [ $gotac == "-ac" ]
	then
	  # They want the latest version
		HIGHESTPATCH=0
		for PATCHNAMES in $patchdir/patch-${CURRENTFULLVERSION}-ac*\.*
		do
			ACVALUE=`echo $PATCHNAMES | sed -e 's/^.*patch-[0-9.]*-ac\([0-9]*\).*/\1/'`
			# Check it is actually a recognised patch type
			findFile $patchdir/patch-${CURRENTFULLVERSION}-ac${ACVALUE} || break

		  if [ $ACVALUE -gt $HIGHESTPATCH ]
			then
			  HIGHESTPATCH=$ACVALUE
		  fi
		done

		if [ $HIGHESTPATCH -ne 0 ]
		then
			findFile $patchdir/patch-${CURRENTFULLVERSION}-ac${HIGHESTPATCH} || break
			applyPatch patch-${CURRENTFULLVERSION}-ac${HIGHESTPATCH}
		else
		  echo "No ac patches found"
		fi
	else
	  # They want an exact version
		findFile $patchdir/patch-${CURRENTFULLVERSION}${gotac} || {
		  echo "Sorry, I couldn't find the $gotac patch for $CURRENTFULLVERSION.  Hohum."
			exit 1
		}
		applyPatch patch-${CURRENTFULLVERSION}${gotac}
	fi
fi


--17pEHd4RhPHOinZp--
