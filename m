Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280410AbRLHN0w>; Sat, 8 Dec 2001 08:26:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280467AbRLHN0q>; Sat, 8 Dec 2001 08:26:46 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:27303 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S280426AbRLHN0b>;
	Sat, 8 Dec 2001 08:26:31 -0500
Date: Sat, 8 Dec 2001 08:26:27 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: linux-kernel@vger.kernel.org
cc: Linus Torvalds <torvalds@transmeta.com>
Subject: [CFT][PATCH] next bunch of cleanups - initrd and friends
Message-ID: <Pine.GSO.4.21.0112080759240.7302-100000@binet.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Folks, next series of cleanups is on ftp.math.psu.edu/pub/viro/K*
Contents:
	* fix for do_mount -> mount fsckup in mount_root()
	* various local cleanups in do_mounts.c - it's still messy as hell,
but it's getting slightly better.
	* initrd-related logics partially moved to do_mounts.c
	* black magic in rd_load_image() is gone.  No fake struct file,
no fake struct dentry, just open()/read()/write()/close() for IO.


It works here on all setups I could think of (ones involving floppy
require module_init(floppy_init) in drivers/block/floppy.c).

Please, help with testing and review.  It's a gradual massage (11 chunks
in that series) and it's not complete - there will be more.  All steps
are pretty small, so verifying correctness shouldn't be hard (well, modulo
the fact that code being massaged is a festering pile of ifdefs; some of
them go to hell, but we still have too much of that mess, so more cleanups
will follow).

If I see no complaints it goes to Linus for next pre-release...

Contents of chunks:
	K0 - fix for mount_root() bug.
	K1 - rd_load_image() had lost its second argument (all callers passed
the same value).  It returns 1 or 0 in case of success and failure resp. and
leaves setting ROOT_DEV and ROOT_DEV_NAME to callers.  rd_load_secondary()
used to have a bug - it used to set ROOT_DEV_NAME to "rd/0" while setting
ROOT_DEV to ram1.  Fixed.
	K2 - initrd_load() moved to do_mounts.c and setting ROOT_DEV{,_NAME}
is taken to its caller.
	K3 - initrd handling (change_root() call, etc.) had been pulled into
the only branch in prepare_namespace() that could trigger it.
	K4 - new helper - mount_block_root().  Part of mount_root() that
gets the list of fs types and loops over them, trying to mount.  mount_root()
uses it now.
	K5 - initrd handling is taken into separate function.  Fixed old
bug - if we ask for initrd and loading initrd fails (i.e. we don't recognize
the contents) we used to mount final root read-write since root_mountflags
was changed early and not restored.
	K6 - change_root() megred into handle_initrd() and cleaned up.  In
particular, ioctl_by_bdev() is not used anymore - we simply open and call
ioctl(2).  Black magic with renaming vfsmount is gone.
	K7 - new helper - mount_nfs_root().  mount_root() calls it now.
Slight ifdefectomy done.
	K8 - rd_load() and rd_load_secondary() moved to do_mounts.c.  Ditto
for rd_load_disk().  Calls of rd_load{,_secondary} expanded, functions
themselves are gone.
	K9 - we maintain correct device node in /dev/root, setting it whenever
we change ROOT_DEV.
	K10 - rd_load_image() gets device names instead of device numbers
now.  As the result, black magic with accessing devices is gone - we use
normal IO mechanisms.  Cosmetical cleanups done in do_mounts.c (when function
contains 3 instances of MKDEV(RAMDISK_MAJOR, 0) it's a clear sign that there
is a local variable wanting to happen).

