Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264055AbSIVNQc>; Sun, 22 Sep 2002 09:16:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264058AbSIVNQc>; Sun, 22 Sep 2002 09:16:32 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:5071 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S264055AbSIVNQb>;
	Sun, 22 Sep 2002 09:16:31 -0400
Date: Sun, 22 Sep 2002 09:21:40 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Adrian Bunk <bunk@fs.tum.de>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.38
In-Reply-To: <Pine.NEB.4.44.0209221444040.18211-100000@mimas.fachschaften.tu-muenchen.de>
Message-ID: <Pine.GSO.4.21.0209220918130.22740-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 22 Sep 2002, Adrian Bunk wrote:

> On Sat, 21 Sep 2002, Linus Torvalds wrote:
> 
> >...
> > Alexander Viro <viro@math.psu.edu>:
> >   o gendisk for pcd, cdu31a, cm206, mcd, mcdx, sbpcd, jsflash, mtdblock_ro,
> >     pf, swim3, loop, aztcd, gscd, optcd, sjcd, sonycd, stram, rd, nbd, xpram,
> >     acorn floppy, swim_iop
> >...
> 
> 
> Below are the trivial fixes for some typos introduced by these changes:
[snip]

Thanks.  Other fixes: typos in partitions/check.c, block/floppy.c and
acorn/block/fd1772.c + replacement of #define with inline in block/floppy.c
(fd_eject()).

diff -urN C38-0/fs/partitions/check.c C38-fix/fs/partitions/check.c
--- C38-0/fs/partitions/check.c	Sun Sep 22 01:08:03 2002
+++ C38-fix/fs/partitions/check.c	Sun Sep 22 04:02:19 2002
@@ -362,7 +362,7 @@
 		pos = devfs_generate_path(dev->disk_de, rname+3, sizeof(rname)-3);
 		if (pos >= 0) {
 			strncpy(rname + pos, "../", 3);
-			devfs_mk_symlink(devfs_handle, vname,
+			devfs_mk_symlink(cdroms, vname,
 					 DEVFS_FL_DEFAULT,
 					 rname + pos, &slave, NULL);
 			devfs_auto_unregister(dev->de, slave);
diff -urN C38-tapeblock/drivers/block/floppy.c C38-current/drivers/block/floppy.c
--- C38-tapeblock/drivers/block/floppy.c	Sun Sep 22 01:08:02 2002
+++ C38-current/drivers/block/floppy.c	Sun Sep 22 06:38:34 2002
@@ -600,7 +600,10 @@
 					 * expressed in units of 512 bytes */
 
 #ifndef fd_eject
-#define fd_eject(x) -EINVAL
+static inline int fd_eject(int drive)
+{
+	return -EINVAL;
+}
 #endif
 
 #ifdef DEBUGT
@@ -4556,7 +4559,7 @@
 
 void cleanup_module(void)
 {
-	int i;
+	int drive;
 		
 	unregister_sys_device(&device_floppy);
 	devfs_unregister (devfs_handle);
diff -urN C38-pd_cleanup/drivers/acorn/block/fd1772.c C38-acorn_fix/drivers/acorn/block/fd1772.c
--- C38-pd_cleanup/drivers/acorn/block/fd1772.c	Sun Sep 22 01:08:02 2002
+++ C38-acorn_fix/drivers/acorn/block/fd1772.c	Sun Sep 22 08:45:24 2002
@@ -1542,7 +1542,7 @@
 static struct gendisk *floppy_find(int minor)
 {
 	int drive = minor & 3;
-	if ((minor>> 2) > NUM_DISK_TYPES || minor >= FD_MAX_UNITS)
+	if ((minor>> 2) > NUM_DISK_TYPES || drive >= FD_MAX_UNITS)
 		return NULL;
 	return &disks[drive];
 }

