Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316471AbSEWM3y>; Thu, 23 May 2002 08:29:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316476AbSEWM2O>; Thu, 23 May 2002 08:28:14 -0400
Received: from imladris.infradead.org ([194.205.184.45]:41226 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S316486AbSEWM06>; Thu, 23 May 2002 08:26:58 -0400
Date: Thu, 23 May 2002 13:26:55 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] include buffer_head.h in actual users instead of fs.h (5/10)
Message-ID: <20020523132655.F24361@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Include buffer_head.h directly in the file in drivers/ that need it
(9 files).  Note that most of this uses are layering violations that I
will address later.


--- 1.31/drivers/block/blkpg.c	Sun May 19 13:49:48 2002
+++ edited/drivers/block/blkpg.c	Thu May 23 13:18:36 2002
@@ -36,6 +36,7 @@
 #include <linux/genhd.h>
 #include <linux/module.h>               /* for EXPORT_SYMBOL */
 #include <linux/backing-dev.h>
+#include <linux/buffer_head.h>
 
 #include <asm/uaccess.h>
 
--- 1.24/drivers/block/floppy.c	Wed May 22 23:43:55 2002
+++ edited/drivers/block/floppy.c	Thu May 23 13:21:57 2002
@@ -174,6 +174,7 @@
 #include <linux/init.h>
 #include <linux/devfs_fs_kernel.h>
 #include <linux/device.h>
+#include <linux/buffer_head.h>		/* for invalidate_buffers() */
 
 /*
  * PS/2 floppies have much slower step rates than regular floppies.
@@ -3793,6 +3794,7 @@
 	if (old_dev != -1 && old_dev != minor(inode->i_rdev)) {
 		if (buffer_drive == drive)
 			buffer_track = -1;
+		/* umm, invalidate_buffers() in ->open??  --hch */
 		invalidate_buffers(mk_kdev(FLOPPY_MAJOR,old_dev));
 	}
 
--- 1.69/drivers/block/ll_rw_blk.c	Wed May 22 00:01:44 2002
+++ edited/drivers/block/ll_rw_blk.c	Thu May 23 13:18:37 2002
@@ -25,6 +25,7 @@
 #include <linux/bootmem.h>
 #include <linux/completion.h>
 #include <linux/compiler.h>
+#include <linux/buffer_head.h>
 #include <scsi/scsi.h>
 #include <linux/backing-dev.h>
 
--- 1.44/drivers/block/loop.c	Mon May  6 13:39:11 2002
+++ edited/drivers/block/loop.c	Thu May 23 13:20:55 2002
@@ -73,6 +73,7 @@
 #include <linux/slab.h>
 #include <linux/loop.h>
 #include <linux/suspend.h>
+#include <linux/buffer_head.h>		/* for invalidate_bdev() */
 
 #include <asm/uaccess.h>
 
--- 1.37/drivers/block/rd.c	Wed May 22 15:22:22 2002
+++ edited/drivers/block/rd.c	Thu May 23 13:18:38 2002
@@ -48,6 +48,7 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/devfs_fs_kernel.h>
+#include <linux/buffer_head.h>		/* for invalidate_bdev() */
 #include <asm/uaccess.h>
 
 /*
--- 1.12/drivers/char/sysrq.c	Fri May  3 02:08:35 2002
+++ edited/drivers/char/sysrq.c	Thu May 23 13:20:18 2002
@@ -28,6 +28,7 @@
 #include <linux/smp_lock.h>
 #include <linux/module.h>
 #include <linux/suspend.h>
+#include <linux/buffer_head.h>		/* for fsync_bdev()/wakeup_bdflush() */
 
 #include <linux/spinlock.h>
 
--- 1.54/drivers/ide/ide-disk.c	Sun May 19 21:03:17 2002
+++ edited/drivers/ide/ide-disk.c	Thu May 23 13:19:51 2002
@@ -28,6 +28,7 @@
 #include <linux/delay.h>
 #include <linux/ide.h>
 #include <linux/suspend.h>
+#include <linux/buffer_head.h>		/* for invalidate_bdev() */
 
 #include <asm/byteorder.h>
 #include <asm/irq.h>
@@ -392,6 +393,7 @@
 	if (drive->removable && !drive->usage) {
 		struct ata_taskfile args;
 
+		/* XXX I don't think this is up to the lowlevel drivers..  --hch */
 		invalidate_bdev(inode->i_bdev, 0);
 
 		memset(&args, 0, sizeof(args));
--- 1.7/drivers/scsi/scsicam.c	Tue Apr 30 22:58:02 2002
+++ edited/drivers/scsi/scsicam.c	Thu May 23 13:18:39 2002
@@ -16,6 +16,7 @@
 #include <linux/genhd.h>
 #include <linux/kernel.h>
 #include <linux/blk.h>
+#include <linux/buffer_head.h>
 #include <asm/unaligned.h>
 #include "scsi.h"
 #include "hosts.h"
--- 1.12/drivers/scsi/sr_ioctl.c	Thu Mar  7 19:32:49 2002
+++ edited/drivers/scsi/sr_ioctl.c	Thu May 23 13:18:39 2002
@@ -5,6 +5,7 @@
 #include <asm/uaccess.h>
 #include <linux/errno.h>
 #include <linux/string.h>
+#include <linux/buffer_head.h>		/* for invalidate_buffers() */
 
 #include <linux/blk.h>
 #include <linux/blkpg.h>
