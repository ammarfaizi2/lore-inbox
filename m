Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265961AbTL3Ug3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 15:36:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265965AbTL3Ug3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 15:36:29 -0500
Received: from bbned23-32-100.dsl.hccnet.nl ([80.100.32.23]:41361 "EHLO
	fw-loc.vanvergehaald.nl") by vger.kernel.org with ESMTP
	id S265961AbTL3UgM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 15:36:12 -0500
Date: Tue, 30 Dec 2003 21:36:05 +0100
From: Toon van der Pas <toon@hout.vanvergehaald.nl>
To: Branko <brankob@avtomatika.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Fw: LVM2 on Gentoo-Dual Opteron/Amd64 system troubles...
Message-ID: <20031230203605.GE8426@hout.vanvergehaald.nl>
References: <007401c3cee2$80edba60$0a03a8c0@brane>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="GID0FwUMdk1T2AWN"
Content-Disposition: inline
In-Reply-To: <007401c3cee2$80edba60$0a03a8c0@brane>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--GID0FwUMdk1T2AWN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 30, 2003 at 03:37:51PM +0100, Branko wrote:
> 
> I guess I'm asking if:
> 
> -anyone else has similar machine with 3Ware RAID card and root on LV and how
> did he accomplish this ?
> 
> -how does one make initrd with LVM ? I had to scavenge script from LVM1,
> without much success...

I have an HP Proliant DL360 G3 running Gentoo with 2.6-test9 kernel
running here. It's two internal driver are configured in a harware
RAID 1 mirrored volume. The whole volume is under the control of
LVM2 with device-mapper. The machine boots off this volume.

I took the lvmcreate_initdr from LVM1 and adapted it for LVM2.
I'll attach it to this message. No guarantees of course...
I don't even remember what I changed exactly.
If you wanna know, run a diff against the original LVM1 script.

By the way: this machine has LILO for a bootloader.
LILO didn't work because it didn't know shit about device-mapper.
Luckily I found somebody on the device-mapper developer list
who maintained a patch for LILO. See my entry in bugzilla:
http://bugs.gentoo.org/show_bug.cgi?id=33873
I included the patch in the bug report.

Lots of success and fun, and a happy new year.
Regards,
Toon.
-- 
"The more difficult a decision is to make,
 the less it matters what you decide."
                    -- Eugene Kleiner

--GID0FwUMdk1T2AWN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=lvmcreate_initrd

#!/bin/sh
#
#  Copyright (C) 1997 - 2000  Heinz Mauelshagen, Sistina Software
#
#  June 1999
#  December 1999
#  January 2000
#  January 2001
#
#  LVM is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 2, or (at your option)
#  any later version.
#
#  LVM is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with LVM; see the file COPYING.  If not, write to
#  the Free Software Foundation, 59 Temple Place - Suite 330,
#  Boston, MA 02111-1307, USA.
#

#
# Changelog
#
#   16/11/1999 - corrected -N type with mke2fs
#   19/12/1999 - use correct ramdisk size
#                strip shared library to save space
#   04/01/2000 - support /proc mount, because lvm_dir_cache now uses it
#   12/02/2001 - always create enough inodes in ramdisk for dev files
#   [AED]      - check all INITRDFILES for library dependencies
#              - make commands quiet and avoid redirecting errors to /dev/null
#              - use cleanup function for all errors, interrupts, normal exit
#   12/02/2001 - copy and strip shared libraries before putting on ramdisk
#   [AED]      - allow specification of /dev directory (in case of devfs)
#              - calculate ramdisk size from libraries, devices, INITRDFILES
#              - add verbose progress messages
#              - copy actual executables if we are using wrapper scripts
#   12/02/2001 - support monolithic kernels
#   14/02/2001 - add usage and command-line switches. Lots of other changes
#              - from Andreas Dilger
#   05/04/2001 - Ignore errors from depmod because we might be a monolithic
#                kernel
#   10/31/2001 - Added devfs support
#


cmd=`basename $0`

TMPMNT=/tmp/mnt.$$
TMPLIB=/tmp/lib.$$
USEMOD=1

PATH=/bin:/sbin:/usr/bin:/usr/sbin:$PATH

usage () {
	echo "Create an initial ramdisk image for LVM root filesystem"
	echo "$cmd: [-h] [-i] [-M] [-v] [-V] [kernel version]"
	echo "      -h|--help     print this usage message"
	echo "      -i|--iop      specify LVM IOP version to use"
	echo "      -M|--nomod    do not set up module support in initrd"
	echo "      -D|--devfs    force use of devfs"
	echo "      -v|--verbose  verbose progress messages"
	echo "      -V|--version  print script version and exit"
}

verbose () {
   [ "$VERBOSE" ] && echo "`echo $cmd | tr '[a-z0-9/_]' ' '` -- $1" || true
}

cleanup () {
  [ "`mount | grep $DEVRAM`" ] && verbose "unmounting $DEVRAM" && umount $DEVRAM
  [ -f $DEVRAM ] && verbose "removing $DEVRAM" && rm $DEVRAM
  [ -d $TMPMNT ] && verbose "removing $TMPMNT" && rmdir $TMPMNT
  [ -d $TMPLIB ] && verbose "removing $TMPLIB" && rm -r $TMPLIB
  verbose "exit with code $1"
  exit $1
}

trap "
  verbose 'Caught interrupt'
  echo 'Bye bye...'
  cleanup 1
" 1 2 3 15


create_fstab () {
   if [ $DEV ]; then
      cat << FSTAB > $TMPMNT/etc/fstab
/dev/ram	/		ext2	defaults	0   0
none		/proc		proc	defaults	0   0
FSTAB
   else
      cat << FSTAB > $TMPMNT/etc/fstab
/dev/ram	/		ext2	defaults	0   0
none		/proc		proc	defaults	0   0
devfs		/dev/		devfs	defaults	0   0
FSTAB
   fi
   chmod 644 $TMPMNT/etc/fstab
}

create_linuxrc () {
   echo "#!/bin/sh" > $TMPMNT/linuxrc
   [ "$LVMMOD" ] && echo "/sbin/modprobe $LVMMOD" >> $TMPMNT/linuxrc
   cat << LINUXRC >> $TMPMNT/linuxrc
/bin/mount /proc
/sbin/vgscan
/sbin/vgchange -a y
/bin/umount /proc
LINUXRC
   chmod 555 $TMPMNT/linuxrc
}

#
# Main
#
echo "Logical Volume Manager 1.0.7 by Heinz Mauelshagen  28/03/2003"

VERSION=`uname -r`

while [ $# -gt 0 ]; do
   case $1 in
   -h|--help) usage; exit 0;;
   -i|--iop) IOP=$2; shift;;
   -M|--nomod) USEMOD="";;
   -D|--devfs) DEV="";;
   -V|--version) exit 0;;
   -d|-v|--debug|--verbose) VERBOSE="y";;
   [2-9].[0-9]*.[0-9]*) VERSION=$1;;
   *) echo "$cmd -- invalid option '$1'"; usage; exit 0;;
   esac
   shift
done

INITRD=${INITRD:-"/boot/initrd-lvm-$VERSION.gz"}
MODULES=/lib/modules/$VERSION
DEVRAM=/tmp/initrd.$$
DEV=${DEV-"/dev"}

echo "$cmd -- make LVM initial ram disk $INITRD"
echo ""

# Try to see if we have devfsd running. At this point $DEV is either
# "/dev" (no devfs) or "" (devfs). If it is, reset $DEV.
if [ "$DEV" = "/dev" ] && [ -a /dev/.devfsd ]; then
	verbose "devfsd running, assuming -D."
	DEV=""
fi

# The size of the ramdisk is automatically calculated unless this is set
#INITRDSIZE=
INITRDFILES="/sbin/vgchange /sbin/vgscan /sbin/lvm /bin/bash /bin/mount /bin/umount /bin/sh /bin/rm"

if [ "$USEMOD" ]; then
   # Check for an LVM module, otherwise it must be compiled into the kernel
   if [ -r $MODULES/kernel/drivers/md/lvm-mod.o ]; then
      LVMMOD="lvm-mod"
      INITRDFILES="$INITRDFILES $MODULES/kernel/drivers/md/$LVMMOD.o"
   elif [ -r $MODULES/block/lvm-mod.o ]; then
      LVMMOD="lvm-mod"
      INITRDFILES="$INITRDFILES $MODULES/block/$LVMMOD.o"
   elif [ -r $MODULES/block/lvm.o ]; then
      LVMMOD="lvm"
      INITRDFILES="$INITRDFILES $MODULES/block/$LVMMOD.o"
   fi

   if [ -x "/sbin/modprobe" ]; then
      INITRDFILES="$INITRDFILES /sbin/modprobe"
   elif [ "$LVMMOD" ]; then
      echo "$cmd -- have $LVMMOD but not /sbin/modprobe."
      cleanup 1
   fi
   if [ -x "/sbin/insmod" ]; then
      INITRDFILES="$INITRDFILES /sbin/insmod"
   elif [ "$LVMMOD" ]; then
      echo "$cmd -- have $LVMMOD but not /sbin/insmod."
      cleanup 1
   fi
   if [ -r "$MODULES/modules.dep" ]; then
      INITRDFILES="$INITRDFILES $MODULES/modules.dep"
   fi
fi

# If we have LVM wrapper scripts in /sbin, we need to fix this by including
# the actual executables into the initrd as well.
if [ -x /sbin/lvmiopversion ]; then
   # Use the IOP version, if specified.  Otherwise, if we are building for
   # the current kernel or there is only one IOP version installed, use it.
   if [ "$IOP" ]; then
      IOP="/lib/lvm-iop$IOP"
   elif [ "$VERSION" = "`uname -r`" ]; then
      IOP="/lib/lvm-iop`lvmiopversion`"
   elif [ `ls -d /lib/lvm-iop* | wc -w` -eq 1 ]; then
      IOP="`ls -d /lib/lvm-iop*`"
   fi
   for FILE in $INITRDFILES; do
   case $FILE in
   /sbin/vg*|/sbin/lv*|/sbin/pv*)
      if [ "`file $FILE 2> /dev/null | grep script`" ]; then
         verbose "$FILE is a wrapper script, resolving."
         if [ -z "$IOP" ]; then
            echo "$cmd -- need to set LVM IOP for kernel $VERSION with '-i'."
            cleanup 1
         fi
         NEWFILE="$IOP/`basename $FILE`"
	 if [ -x $NEWFILE ]; then
	    INITRDFILES="$INITRDFILES $NEWFILE"
         else
	    echo "$cmd -- can't find $NEWFILE, your initrd may not work."
	 fi
      fi ;;
   esac
   done
   INITRDFILES="$INITRDFILES /sbin/lvmiopversion"
fi

# Figure out which shared libraries we actually need in our initrd
echo "$cmd -- finding required shared libraries"
verbose "INITRDFILES: `echo $INITRDFILES`"
SHLIBS=`ldd $INITRDFILES 2>/dev/null | awk '{if (/=>/) { print $3 }}' | sort -u`
if [ $? -ne 0 ]; then
   echo "$cmd -- ERROR figuring out needed shared libraries"
   exit 1
fi

verbose "need: `echo $SHLIBS`"

# Copy shared libraries to a temp directory before stripping, so that we don't
# run out of room on the ramdisk while stripping the libraries.
echo "$cmd -- stripping shared libraries"
mkdir $TMPLIB
for LIB in $SHLIBS; do
   verbose "copy $LIB to $TMPLIB$LIB"
   mkdir -p `dirname $TMPLIB$LIB`
   cp $LIB $TMPLIB$LIB
   if [ $? -ne 0 ]; then
      echo "$cmd -- ERROR copying shared library $LIB to ram disk"
      cleanup 1
   fi
   verbose "strip $TMPLIB$LIB"
   strip $TMPLIB$LIB
   if [ $? -ne 0 ]; then
      echo "$cmd -- ERROR stripping shared library $LIB"
      cleanup 1
   fi
done

# Calculate the number of inodes needed, and the size of the ramdisk image.
# Don't forget that inodes take up space too, as does the filesystem metadata.
echo "$cmd -- calculating initrd filesystem parameters"
verbose "counting files in: $DEV $TMPLIB \$INITRDFILES"
NUMINO="`find $DEV $TMPLIB $INITRDFILES | wc -w`"
verbose "minimum: $NUMINO inodes + filesystem reserved inodes"
NUMINO=`expr $NUMINO + 64`
if [ -z "$INITRDSIZE" ]; then
   echo "$cmd -- calculating loopback file size"
   verbose "finding size of: $DEV $TMPLIB \$INITRDFILES"
   INITRDSIZE="`du -ck $DEV $TMPLIB $INITRDFILES | tail -1 | cut -f 1`"
   verbose "minimum: $INITRDSIZE kB for files + inodes + filesystem metadata"
   INITRDSIZE=`expr $INITRDSIZE + $NUMINO / 8 + 512`  # enough for ext2 fs + a bit
fi

echo "$cmd -- making loopback file ($INITRDSIZE kB)"
verbose "using $DEVRAM as a temporary loopback file"
dd if=/dev/zero of=$DEVRAM count=$INITRDSIZE bs=1024 > /dev/null 2>&1
if [ $? -ne 0 ]; then
   echo "$cmd -- ERROR creating loopback file"
   cleanup 1
fi

# Ext2 can only have 8 * blocksize inodes per group, so we may need to
# increase the number of groups created if there are lots of inodes.
if [ $NUMINO -gt $INITRDSIZE ]; then
   if [ $NUMINO -gt 8192 ]; then
      verbose "too many inodes for one group - need to create more groups"
      BPG=`expr $INITRDSIZE \* 8192 / $NUMINO`
      INODE_OPT="-g `expr $BPG + 8 - $BPG % 8` -N $NUMINO"
   else
      INODE_OPT="-N $NUMINO"
   fi
else
   INODE_OPT="-i `expr $INITRDSIZE \* 1024 / $NUMINO`"
fi

echo "$cmd -- making ram disk filesystem ($NUMINO inodes)"
verbose "mke2fs -F -m0 -L LVM-$VERSION $INODE_OPT $DEVRAM $INITRDSIZE"
[ "$VERBOSE" ] && OPT_Q="" || OPT_Q="-q"
mke2fs $OPT_Q -F -m0 -L LVM-$VERSION $INODE_OPT $DEVRAM $INITRDSIZE
if [ $? -ne 0 ]; then
   echo "$cmd -- ERROR making ram disk filesystem"
   echo "$cmd -- ERROR you need to use mke2fs >= 1.14 or increase INITRDSIZE"
   cleanup 1
fi

verbose "creating mountpoint $TMPMNT"
mkdir $TMPMNT
if [ $? -ne 0 ]; then
   echo "$cmd -- ERROR making $TMPMNT"
   cleanup 1
fi

echo "$cmd -- mounting ram disk filesystem"
verbose "mount -o loop $DEVRAM $TMPMNT"
mount -oloop $DEVRAM $TMPMNT
if [ $? -ne 0 ]; then
   echo "$cmd -- ERROR mounting $DEVRAM on $TMPMNT"
   cleanup 1
fi

verbose "creating /etc /proc /lib in $TMPMNT"
mkdir $TMPMNT/etc $TMPMNT/proc $TMPMNT/lib $TMPMNT/dev
if [ $? -ne 0 ]; then
   echo "$cmd -- ERROR creating directories in $TMPMNT"
   cleanup 1
fi
verbose "removing $TMPMNT/lost+found"
rmdir $TMPMNT/lost+found

if [ "$USEMOD" ]; then
   #
   # create new modules configuration to avoid kmod complaining
   # about nonexsisting modules.
   #
   MODCONF=/etc/modules.conf
   [ ! -r $MODCONF -a -r /etc/conf.modules ] && MODCONF=/etc/conf.modules
   echo "$cmd -- creating new $MODCONF"
   verbose "all block and char modules will be turned off"
   MAJ=0
   while [ $MAJ -lt 256 ]; do
      echo "alias block-major-$MAJ	off"
      echo "alias char-major-$MAJ	off"
      MAJ=`expr $MAJ + 1`
   done > $TMPMNT/$MODCONF


   # to ensure, that modprobe doesn complain about timestamps
   echo "$cmd -- creating new modules.dep"
   depmod -a $VERSION
   if [ $? -ne 0 ]; then
      echo "$cmd -- ERROR running depmod"
      cleanup 1
   fi
fi

# copy necessary files to ram disk
[ "$VERBOSE" ] && OPT_Q="-v" || OPT_Q="--quiet"

if [ $DEV ]; then
   echo "$cmd -- copying device files to ram disk"
   verbose "find $DEV | cpio -pdm $TMPMNT"
   (cd $DEV; find . | cpio -pdm $OPT_Q $TMPMNT/dev)
   if [ $? -ne 0 ]; then
      echo "$cmd -- ERROR cpio to ram disk"
      cleanup 1
   fi
fi

echo "$cmd -- copying initrd files to ram disk"
verbose "find \$INITRDFILES | cpio -pdm $OPT_Q $TMPMNT"
find $INITRDFILES | cpio -pdm $OPT_Q $TMPMNT
if [ $? -ne 0 ]; then
   echo "$cmd -- ERROR cpio to ram disk"
   cleanup 1
fi

echo "$cmd -- copying shared libraries to ram disk"
verbose "find $TMPLIB | cpio -pdm $OPT_Q $TMPMNT"
(cd $TMPLIB; find * | cpio -pdm $OPT_Q $TMPMNT)
if [ $? -ne 0 ]; then
   echo "$cmd -- ERROR copying shared libraries to ram disk"
   cleanup 1
fi

echo "$cmd -- creating new /linuxrc"
create_linuxrc
if [ $? -ne 0 ]; then
   echo "$cmd -- ERROR creating linuxrc"
   cleanup
   exit 1
fi

echo "$cmd -- creating new /etc/fstab"
create_fstab
if [ $? -ne 0 ]; then
   echo "$cmd -- ERROR creating /etc/fstab"
   cleanup 1
fi

echo "$cmd -- ummounting ram disk"
umount $DEVRAM
if [ $? -ne 0 ]; then
   echo "$cmd -- ERROR umounting $DEVRAM"
   cleanup 1
fi

echo "$cmd -- creating compressed initrd $INITRD"
verbose "dd if=$DEVRAM bs=1k count=$INITRDSIZE | gzip -9"
dd if=$DEVRAM bs=1k count=$INITRDSIZE 2>/dev/null | gzip -9 > $INITRD
if [ $? -ne 0 ]; then
   echo "$cmd -- ERROR creating $INITRD"
   cleanup 1
fi

cleanup 0

--GID0FwUMdk1T2AWN--
