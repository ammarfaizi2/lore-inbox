Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267070AbTB0XEH>; Thu, 27 Feb 2003 18:04:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267153AbTB0XEH>; Thu, 27 Feb 2003 18:04:07 -0500
Received: from h-64-105-35-241.SNVACAID.covad.net ([64.105.35.241]:46797 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S267070AbTB0XEE>; Thu, 27 Feb 2003 18:04:04 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Thu, 27 Feb 2003 15:13:41 -0800
Message-Id: <200302272313.PAA11724@baldur.yggdrasil.com>
To: akpm@digeo.com
Subject: Re: Patch: 2.5.62 devfs shrink
Cc: alistair@devzero.co.uk, cloos@jhcloos.com, elenstev@mesatop.com,
       jordan.breeding@attbi.com, linux-kernel@vger.kernel.org,
       maneesh@in.ibm.com, scole@lanl.gov, solarce@fallingsnow.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Feb 2003, Andrew Morton wrote, about my devfs code shrink:
>Adam, could you please provide a description of the incompatibilities between
>this implementation and the present one?  For both kernel and userspace.

	OK.  Here is a first draft of what I plan to put in
linux/Documentation/filesystems/devfs/small-devfs.  Corrections and
comments are welcome.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."


---------------------------CUT HERE----------------------------------

This document describes the differences between Richard Gooch's
original devfs and my "small" devfs.

This new devfs replaces the internal devfs file system with one
derived from ramfs, a reduction of more than 2400 lines of source
code, although file systems based on ramfs rely on the 345 line
file fs/libfs.c.


User level differences:

1. devfsd replaced by devfs_helper

	devfs_helper implements a subset of devfsd functionality.
devfsd is not a deamon.  Instead, the new devfs invokes devfs_helper
with argument for each event.  The new devfs currently only calls
devfs_helper for "LOOKUP" and "REGISTER" events.  devfs_helper
uses the existing /etc/devfsd.conf file and supports devfsd's regular
expression matching.  Like devfsd, devfs_helper is optional.  It is
available from the following FTP directory.

	ftp://ftp.yggdrasil.com/pub/dist/device_control/devfs/


2. Old device names not automatically installed.

   Unlike devfsd, devfs_helper does not install old "compatible"
   device names.  This keeps devfs_helper small, which is particularly
   important since devfs_helper is invoked repeatedly.

   If you want to install a bunch of alternate device
   names (such as /dev/hda1 for /dev/ide/host0/bus0/target0/lun0/part1),
   you can do this at boot time after /dev has been mounted.  For
   example, you could maintain a tree of device nodes to overlay
   on /dev in, say /dev.overlay, and then add something like the
   following to a boot script:

	( cd /dev.overlay && tar cf - ) | ( cd /dev && tar xfp - )

   Note that you should not use "cp" or even "cp -a" for this
   operation, as that "cp" will always try to open devices and
   read from them.

   If you want to save the current /dev every time you shut your
   system down, you could add a line like the following to a
   halt script:

	( cd /dev && tar cf - ) | ( cd /dev.overlay && tar xfp - )

   Note that if you want to support booting both with and without
   devfs, a simpler approach might be to convert your non-devfs
   system to use devfs-style names, at least for the devices that
   are needed for booting (/dev/vc/0, /dev/vc/1... for virtual
   consoles, /dev/discs/disc0/disc for the first whole hard disk,
   /dev/discs/discs0/part1 for the first partition of the first
   disk, /dev/floppy/0).


3. Future: DEVFS_MOUNT and "devfs=nomount" may disappear.

   The option to have the kernel automatically mount /dev may
   disappear in the future.  As with old devfs, you can already
   eliminate this feature by not defining DEVFS_MOUNT.  If you
   do this, the kernel will not be able to open /dev/console
   before invoking /sbin/init.  Eliminating DEVFS_MOUNT shrinks
   the kernel, allowing this functionality to be provided by
   user level programs (which don't necessarily remain resident
   in memory and which may want to do something different anyhow).
   The init program can do something like the following untested
   code to mount /dev and open /dev/console:

	mount("", "/dev", "devfs", 0, NULL);
	close(0); close(1); close(2);	/* Just to make sure. */
	open("/dev/console", O_RDONLY); /* This will return fd 0. */
	open("/dev/console", O_WRONLY); /* This will return fd 1. */
	dup2(1, 2);			/* stderr = stdout. */


4. Partition table support now matches non-devfs systems (i.e., no
   automatic partition table rereading, which was causing problems).

	The old devfs would automatically reread partition tables
at various times.  This was a functional difference with non-devfs
systems, and made it nearly impossible to use drivers that returned
incorrect "media changed" information such as with CompactFlash cards
on systems that used user level partition reading programs like partx
to keep the kernel small.  Basically, the old devfs would make the
kernel forget CompactFlash partition tables on nearly every operation.
This misfeature is removed in smalldevfs.  smalldevfs systems now
handle partition tables just like non-devfs systems.


Kernel differences:

5. "ops" argument to devfs_register is temporarily ignored

	If you are using devfs to register a character or block
device, you should not notice any difference.  The difference is that
the ops argument to devfs_register is currently ignored.  So, for the
time being, access to all devices still go through major and minor
device numbers.  Eventually, I would like to restore the functionality
of potentially eliminating major and minor device numbers, but, for
now, this functionality is temporarily gone.

	Because this functionality is gone, you can only register
character or block devices to get device-like behavior.  The only
users of this functionality were a couple of interfaces that
duplicated /proc interfaces.  They were removed from the kernel
recently anyhow.

	In the future, I hope to restore this functionality in a way
that will allow even more device support code to removed (or
"configured out") as a result than under the old devfs.  So, please
continue to pass the character or block device operations pointer to
devfs_register, even if devfs_register is currently not using it.


5a. devfs_only() always returns 0

	devfs_only() is supposed to return 1 on systems that always
use the ops field in devfs_register and therefore do not need to
reference devices by number.  Because of #2, devfs_only() currently
always return 0.  This should change in the future, so please do not
delete code that tests devfs_only().  The compiler will optimize out
the unnecessary code in the meantime.


Adam J. Richter
adam@yggdrasil.com
