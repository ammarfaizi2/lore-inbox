Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316454AbSEUALg>; Mon, 20 May 2002 20:11:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316455AbSEUALf>; Mon, 20 May 2002 20:11:35 -0400
Received: from imladris.infradead.org ([194.205.184.45]:30470 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S316454AbSEUALT>; Mon, 20 May 2002 20:11:19 -0400
Date: Tue, 21 May 2002 01:11:08 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] push down inclusion of buffer_head.h into users
Message-ID: <20020521011108.A22488@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020520190033.A414@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 20, 2002 at 07:00:33PM +0100, Christoph Hellwig wrote:
> Now that fs.h grow due to the lock.h removal let's reduce it's overhead
> again:  Instead of penalizing ever user of fs.h with the overhead of the
> buffer head interface let it's users include it directly.
> 
> This also shows nicely which parts of the core kernel still depend on the
> buffer head interface, and allows that to be cleaned up properly.
> 
> Please drop me a note if you have a reason to not include it as it is
> painfull to update due to the number of files touched.

Updated to the latest BK tree, UP compilation failures fixed.
Please include.

===== drivers/block/blkpg.c 1.31 vs edited =====
--- 1.31/drivers/block/blkpg.c	Sun May 19 13:49:48 2002
+++ edited/drivers/block/blkpg.c	Tue May 21 01:46:38 2002
@@ -36,6 +36,7 @@
 #include <linux/genhd.h>
 #include <linux/module.h>               /* for EXPORT_SYMBOL */
 #include <linux/backing-dev.h>
+#include <linux/buffer_head.h>
 
 #include <asm/uaccess.h>
 
===== drivers/block/floppy.c 1.22 vs edited =====
--- 1.22/drivers/block/floppy.c	Mon May 20 20:59:05 2002
+++ edited/drivers/block/floppy.c	Tue May 21 01:46:39 2002
@@ -173,6 +173,7 @@
 #include <linux/interrupt.h>
 #include <linux/init.h>
 #include <linux/devfs_fs_kernel.h>
+#include <linux/buffer_head.h>		/* for invalidate_buffers() */
 
 /*
  * PS/2 floppies have much slower step rates than regular floppies.
@@ -3791,6 +3792,7 @@
 	if (old_dev != -1 && old_dev != minor(inode->i_rdev)) {
 		if (buffer_drive == drive)
 			buffer_track = -1;
+		/* umm, invalidate_buffers() in ->open?? */
 		invalidate_buffers(mk_kdev(FLOPPY_MAJOR,old_dev));
 	}
 
===== drivers/block/ll_rw_blk.c 1.67 vs edited =====
--- 1.67/drivers/block/ll_rw_blk.c	Mon May 20 15:34:06 2002
+++ edited/drivers/block/ll_rw_blk.c	Tue May 21 01:46:39 2002
@@ -25,6 +25,7 @@
 #include <linux/bootmem.h>
 #include <linux/completion.h>
 #include <linux/compiler.h>
+#include <linux/buffer_head.h>
 #include <scsi/scsi.h>
 #include <linux/backing-dev.h>
 
===== drivers/block/loop.c 1.43 vs edited =====
--- 1.43/drivers/block/loop.c	Tue Apr 30 22:58:44 2002
+++ edited/drivers/block/loop.c	Tue May 21 01:46:39 2002
@@ -71,6 +71,7 @@
 #include <linux/smp_lock.h>
 #include <linux/swap.h>
 #include <linux/slab.h>
+#include <linux/buffer_head.h>		/* for invalidate_bdev() */
 
 #include <asm/uaccess.h>
 
===== drivers/block/rd.c 1.36 vs edited =====
--- 1.36/drivers/block/rd.c	Sun May 19 23:57:20 2002
+++ edited/drivers/block/rd.c	Tue May 21 01:46:40 2002
@@ -48,6 +48,7 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/devfs_fs_kernel.h>
+#include <linux/buffer_head.h>		/* for invalidate_bdev() */
 #include <asm/uaccess.h>
 
 /*
===== drivers/char/sysrq.c 1.11 vs edited =====
--- 1.11/drivers/char/sysrq.c	Mon Mar 11 12:44:18 2002
+++ edited/drivers/char/sysrq.c	Tue May 21 01:46:40 2002
@@ -27,6 +27,7 @@
 #include <linux/quotaops.h>
 #include <linux/smp_lock.h>
 #include <linux/module.h>
+#include <linux/buffer_head.h>		/* for fsync_bdev()/wakeup_bdflush() */
 
 #include <linux/spinlock.h>
 
===== drivers/ide/ide-disk.c 1.53 vs edited =====
--- 1.53/drivers/ide/ide-disk.c	Mon May 13 23:26:11 2002
+++ edited/drivers/ide/ide-disk.c	Tue May 21 01:46:40 2002
@@ -27,6 +27,7 @@
 #include <linux/slab.h>
 #include <linux/delay.h>
 #include <linux/ide.h>
+#include <linux/buffer_head.h>		/* for invalidate_bdev() */
 
 #include <asm/byteorder.h>
 #include <asm/irq.h>
@@ -391,6 +392,7 @@
 	if (drive->removable && !drive->usage) {
 		struct ata_taskfile args;
 
+		/* XXX I don't think this is up to the lowlevel drivers..  --hch */
 		invalidate_bdev(inode->i_bdev, 0);
 
 		memset(&args, 0, sizeof(args));
===== drivers/scsi/scsicam.c 1.7 vs edited =====
--- 1.7/drivers/scsi/scsicam.c	Tue Apr 30 22:58:02 2002
+++ edited/drivers/scsi/scsicam.c	Tue May 21 01:46:40 2002
@@ -16,6 +16,7 @@
 #include <linux/genhd.h>
 #include <linux/kernel.h>
 #include <linux/blk.h>
+#include <linux/buffer_head.h>
 #include <asm/unaligned.h>
 #include "scsi.h"
 #include "hosts.h"
===== drivers/scsi/sr_ioctl.c 1.12 vs edited =====
--- 1.12/drivers/scsi/sr_ioctl.c	Thu Mar  7 19:32:49 2002
+++ edited/drivers/scsi/sr_ioctl.c	Tue May 21 01:46:40 2002
@@ -5,6 +5,7 @@
 #include <asm/uaccess.h>
 #include <linux/errno.h>
 #include <linux/string.h>
+#include <linux/buffer_head.h>		/* for invalidate_buffers() */
 
 #include <linux/blk.h>
 #include <linux/blkpg.h>
===== fs/block_dev.c 1.57 vs edited =====
--- 1.57/fs/block_dev.c	Mon May 20 15:40:08 2002
+++ edited/fs/block_dev.c	Tue May 21 01:46:41 2002
@@ -19,6 +19,7 @@
 #include <linux/blkdev.h>
 #include <linux/module.h>
 #include <linux/blkpg.h>
+#include <linux/buffer_head.h>
 
 #include <asm/uaccess.h>
 
===== fs/buffer.c 1.102 vs edited =====
--- 1.102/fs/buffer.c	Mon May 20 15:40:11 2002
+++ edited/fs/buffer.c	Tue May 21 01:46:41 2002
@@ -32,6 +32,7 @@
 #include <linux/writeback.h>
 #include <linux/mempool.h>
 #include <linux/hash.h>
+#include <linux/buffer_head.h>
 #include <asm/bitops.h>
 
 #define BH_ENTRY(list) list_entry((list), struct buffer_head, b_assoc_buffers)
===== fs/fs-writeback.c 1.9 vs edited =====
--- 1.9/fs/fs-writeback.c	Sun May 19 13:49:49 2002
+++ edited/fs/fs-writeback.c	Tue May 21 01:46:41 2002
@@ -20,6 +20,7 @@
 #include <linux/mm.h>
 #include <linux/writeback.h>
 #include <linux/backing-dev.h>
+#include <linux/buffer_head.h>
 
 /**
  *	__mark_inode_dirty -	internal function
===== fs/inode.c 1.57 vs edited =====
--- 1.57/fs/inode.c	Mon May 20 18:35:29 2002
+++ edited/fs/inode.c	Tue May 21 01:46:41 2002
@@ -14,6 +14,16 @@
 #include <linux/writeback.h>
 #include <linux/module.h>
 #include <linux/backing-dev.h>
+/*
+ * This is needed for the following functions:
+ *  - inode_has_buffers
+ *  - invalidate_inode_buffers
+ *  - fsync_bdev
+ *  - invalidate_bdev
+ *
+ * FIXME: remove all knowledge of the buffer layer from this file
+ */
+#include <linux/buffer_head.h>
 
 /*
  * New inode.c implementation.
===== fs/super.c 1.72 vs edited =====
--- 1.72/fs/super.c	Mon May 20 15:40:13 2002
+++ edited/fs/super.c	Tue May 21 01:46:42 2002
@@ -27,6 +27,7 @@
 #include <linux/acct.h>
 #include <linux/blkdev.h>
 #include <linux/quotaops.h>
+#include <linux/buffer_head.h>		/* for fsync_super() */
 #include <asm/uaccess.h>
 
 void get_filesystem(struct file_system_type *fs);
===== fs/adfs/adfs.h 1.3 vs edited =====
--- 1.3/fs/adfs/adfs.h	Mon May 13 01:14:41 2002
+++ edited/fs/adfs/adfs.h	Tue May 21 01:46:42 2002
@@ -14,6 +14,8 @@
 
 #include "dir_f.h"
 
+struct buffer_head;
+
 /*
  * Directory handling
  */
===== fs/adfs/dir.c 1.6 vs edited =====
--- 1.6/fs/adfs/dir.c	Mon May 13 01:14:41 2002
+++ edited/fs/adfs/dir.c	Tue May 21 01:46:42 2002
@@ -18,6 +18,7 @@
 #include <linux/stat.h>
 #include <linux/spinlock.h>
 #include <linux/smp_lock.h>
+#include <linux/buffer_head.h>		/* for file_fsync() */
 
 #include "adfs.h"
 
===== fs/adfs/dir_f.c 1.4 vs edited =====
--- 1.4/fs/adfs/dir_f.c	Mon Feb 25 19:35:33 2002
+++ edited/fs/adfs/dir_f.c	Tue May 21 01:46:42 2002
@@ -16,6 +16,7 @@
 #include <linux/time.h>
 #include <linux/stat.h>
 #include <linux/spinlock.h>
+#include <linux/buffer_head.h>
 
 #include "adfs.h"
 #include "dir_f.h"
===== fs/adfs/dir_fplus.c 1.4 vs edited =====
--- 1.4/fs/adfs/dir_fplus.c	Mon Feb 25 19:35:33 2002
+++ edited/fs/adfs/dir_fplus.c	Tue May 21 01:46:43 2002
@@ -14,6 +14,7 @@
 #include <linux/time.h>
 #include <linux/stat.h>
 #include <linux/spinlock.h>
+#include <linux/buffer_head.h>
 
 #include "adfs.h"
 #include "dir_fplus.h"
===== fs/adfs/file.c 1.3 vs edited =====
--- 1.3/fs/adfs/file.c	Sat Feb  9 04:10:55 2002
+++ edited/fs/adfs/file.c	Tue May 21 01:46:43 2002
@@ -25,6 +25,7 @@
 #include <linux/fcntl.h>
 #include <linux/time.h>
 #include <linux/stat.h>
+#include <linux/buffer_head.h>		/* for file_fsync() */
 
 #include "adfs.h"
 
===== fs/adfs/inode.c 1.11 vs edited =====
--- 1.11/fs/adfs/inode.c	Mon May 20 15:34:22 2002
+++ edited/fs/adfs/inode.c	Tue May 21 01:46:43 2002
@@ -17,7 +17,7 @@
 #include <linux/mm.h>
 #include <linux/smp_lock.h>
 #include <linux/module.h>
-
+#include <linux/buffer_head.h>
 
 #include "adfs.h"
 
===== fs/adfs/map.c 1.3 vs edited =====
--- 1.3/fs/adfs/map.c	Mon May 13 01:14:41 2002
+++ edited/fs/adfs/map.c	Tue May 21 01:46:43 2002
@@ -12,6 +12,7 @@
 #include <linux/fs.h>
 #include <linux/adfs_fs.h>
 #include <linux/spinlock.h>
+#include <linux/buffer_head.h>
 
 #include <asm/unaligned.h>
 
===== fs/adfs/super.c 1.15 vs edited =====
--- 1.15/fs/adfs/super.c	Mon May 20 15:34:24 2002
+++ edited/fs/adfs/super.c	Tue May 21 01:46:43 2002
@@ -17,6 +17,7 @@
 #include <linux/stat.h>
 #include <linux/string.h>
 #include <linux/init.h>
+#include <linux/buffer_head.h>
 
 #include <asm/bitops.h>
 #include <asm/uaccess.h>
===== fs/affs/amigaffs.c 1.12 vs edited =====
--- 1.12/fs/affs/amigaffs.c	Mon May 20 15:34:27 2002
+++ edited/fs/affs/amigaffs.c	Tue May 21 01:46:43 2002
@@ -15,6 +15,7 @@
 #include <linux/string.h>
 #include <linux/mm.h>
 #include <linux/amigaffs.h>
+#include <linux/buffer_head.h>
 
 extern struct timezone sys_tz;
 
===== fs/affs/bitmap.c 1.9 vs edited =====
--- 1.9/fs/affs/bitmap.c	Mon May 20 15:34:29 2002
+++ edited/fs/affs/bitmap.c	Tue May 21 01:46:44 2002
@@ -15,6 +15,7 @@
 #include <linux/string.h>
 #include <linux/bitops.h>
 #include <linux/amigaffs.h>
+#include <linux/buffer_head.h>
 
 /* This is, of course, shamelessly stolen from fs/minix */
 
===== fs/affs/dir.c 1.8 vs edited =====
--- 1.8/fs/affs/dir.c	Wed Apr 24 17:50:15 2002
+++ edited/fs/affs/dir.c	Tue May 21 01:46:44 2002
@@ -23,6 +23,7 @@
 #include <linux/mm.h>
 #include <linux/amigaffs.h>
 #include <linux/smp_lock.h>
+#include <linux/buffer_head.h>
 
 static int affs_readdir(struct file *, void *, filldir_t);
 
===== fs/affs/file.c 1.18 vs edited =====
--- 1.18/fs/affs/file.c	Mon May 20 15:34:32 2002
+++ edited/fs/affs/file.c	Tue May 21 01:46:44 2002
@@ -28,6 +28,7 @@
 #include <linux/amigaffs.h>
 #include <linux/mm.h>
 #include <linux/pagemap.h>
+#include <linux/buffer_head.h>
 
 #if PAGE_SIZE < 4096
 #error PAGE_SIZE must be at least 4096
===== fs/affs/inode.c 1.14 vs edited =====
--- 1.14/fs/affs/inode.c	Mon May 20 15:34:34 2002
+++ edited/fs/affs/inode.c	Tue May 21 01:46:44 2002
@@ -26,6 +26,7 @@
 #include <linux/blkdev.h>
 #include <linux/init.h>
 #include <linux/smp_lock.h>
+#include <linux/buffer_head.h>
 #include <asm/system.h>
 #include <asm/uaccess.h>
 #include <linux/module.h>
===== fs/affs/namei.c 1.17 vs edited =====
--- 1.17/fs/affs/namei.c	Mon May 20 15:34:36 2002
+++ edited/fs/affs/namei.c	Tue May 21 01:46:44 2002
@@ -16,6 +16,7 @@
 #include <linux/fcntl.h>
 #include <linux/amigaffs.h>
 #include <linux/smp_lock.h>
+#include <linux/buffer_head.h>
 #include <asm/uaccess.h>
 
 #include <linux/errno.h>
===== fs/affs/super.c 1.24 vs edited =====
--- 1.24/fs/affs/super.c	Mon May 20 15:34:39 2002
+++ edited/fs/affs/super.c	Tue May 21 01:46:44 2002
@@ -26,6 +26,7 @@
 #include <linux/blkdev.h>
 #include <linux/init.h>
 #include <linux/smp_lock.h>
+#include <linux/buffer_head.h>
 #include <asm/system.h>
 #include <asm/uaccess.h>
 
===== fs/affs/symlink.c 1.4 vs edited =====
--- 1.4/fs/affs/symlink.c	Tue Apr 30 00:18:35 2002
+++ edited/fs/affs/symlink.c	Tue May 21 01:46:44 2002
@@ -15,6 +15,7 @@
 #include <linux/amigaffs.h>
 #include <linux/pagemap.h>
 #include <linux/smp_lock.h>
+#include <linux/buffer_head.h>
 
 static int affs_symlink_readpage(struct file *file, struct page *page)
 {
===== fs/bfs/dir.c 1.15 vs edited =====
--- 1.15/fs/bfs/dir.c	Mon May 20 15:34:46 2002
+++ edited/fs/bfs/dir.c	Tue May 21 02:14:31 2002
@@ -8,6 +8,8 @@
 #include <linux/string.h>
 #include <linux/bfs_fs.h>
 #include <linux/smp_lock.h>
+#include <linux/buffer_head.h>
+#include <linux/sched.h>
 
 #include "bfs_defs.h"
 
===== fs/bfs/file.c 1.7 vs edited =====
--- 1.7/fs/bfs/file.c	Mon May 20 15:34:48 2002
+++ edited/fs/bfs/file.c	Tue May 21 01:46:45 2002
@@ -7,6 +7,7 @@
 #include <linux/fs.h>
 #include <linux/bfs_fs.h>
 #include <linux/smp_lock.h>
+#include <linux/buffer_head.h>
 #include "bfs_defs.h"
 
 #undef DEBUG
===== fs/bfs/inode.c 1.14 vs edited =====
--- 1.14/fs/bfs/inode.c	Mon May 20 15:34:50 2002
+++ edited/fs/bfs/inode.c	Tue May 21 01:46:45 2002
@@ -11,6 +11,7 @@
 #include <linux/init.h>
 #include <linux/bfs_fs.h>
 #include <linux/smp_lock.h>
+#include <linux/buffer_head.h>
 
 #include <asm/uaccess.h>
 
===== fs/cramfs/inode.c 1.21 vs edited =====
--- 1.21/fs/cramfs/inode.c	Mon May 20 15:35:10 2002
+++ edited/fs/cramfs/inode.c	Tue May 21 01:46:45 2002
@@ -21,6 +21,7 @@
 #include <linux/smp_lock.h>
 #include <linux/slab.h>
 #include <linux/cramfs_fs_sb.h>
+#include <linux/buffer_head.h>
 #include <asm/semaphore.h>
 
 #include <asm/uaccess.h>
===== fs/efs/dir.c 1.3 vs edited =====
--- 1.3/fs/efs/dir.c	Wed Apr 24 17:50:15 2002
+++ edited/fs/efs/dir.c	Tue May 21 01:46:45 2002
@@ -4,6 +4,7 @@
  * Copyright (c) 1999 Al Smith
  */
 
+#include <linux/buffer_head.h>
 #include <linux/efs_fs.h>
 #include <linux/smp_lock.h>
 
===== fs/efs/file.c 1.3 vs edited =====
--- 1.3/fs/efs/file.c	Tue Feb  5 16:23:03 2002
+++ edited/fs/efs/file.c	Tue May 21 01:46:45 2002
@@ -6,6 +6,7 @@
  * Portions derived from work (c) 1995,1996 Christian Vogelgsang.
  */
 
+#include <linux/buffer_head.h>
 #include <linux/efs_fs.h>
 
 int efs_get_block(struct inode *inode, sector_t iblock,
===== fs/efs/inode.c 1.4 vs edited =====
--- 1.4/fs/efs/inode.c	Sat Feb  9 04:10:55 2002
+++ edited/fs/efs/inode.c	Tue May 21 01:46:46 2002
@@ -9,6 +9,7 @@
 
 #include <linux/efs_fs.h>
 #include <linux/efs_fs_sb.h>
+#include <linux/buffer_head.h>
 #include <linux/module.h>
 #include <linux/fs.h>
 
===== fs/efs/namei.c 1.3 vs edited =====
--- 1.3/fs/efs/namei.c	Tue Feb 12 00:45:56 2002
+++ edited/fs/efs/namei.c	Tue May 21 01:46:46 2002
@@ -6,6 +6,7 @@
  * Portions derived from work (c) 1995,1996 Christian Vogelgsang.
  */
 
+#include <linux/buffer_head.h>
 #include <linux/string.h>
 #include <linux/efs_fs.h>
 #include <linux/smp_lock.h>
===== fs/efs/super.c 1.10 vs edited =====
--- 1.10/fs/efs/super.c	Mon May 20 15:35:18 2002
+++ edited/fs/efs/super.c	Tue May 21 01:46:46 2002
@@ -12,6 +12,7 @@
 #include <linux/efs_vh.h>
 #include <linux/efs_fs_sb.h>
 #include <linux/slab.h>
+#include <linux/buffer_head.h>
 
 static struct super_block *efs_get_sb(struct file_system_type *fs_type,
 	int flags, char *dev_name, void *data)
===== fs/efs/symlink.c 1.3 vs edited =====
--- 1.3/fs/efs/symlink.c	Tue Apr 30 00:18:35 2002
+++ edited/fs/efs/symlink.c	Tue May 21 01:46:46 2002
@@ -9,6 +9,7 @@
 #include <linux/string.h>
 #include <linux/efs_fs.h>
 #include <linux/pagemap.h>
+#include <linux/buffer_head.h>
 #include <linux/smp_lock.h>
 
 static int efs_symlink_readpage(struct file *file, struct page *page)
===== fs/ext2/balloc.c 1.19 vs edited =====
--- 1.19/fs/ext2/balloc.c	Mon May 20 20:56:05 2002
+++ edited/fs/ext2/balloc.c	Tue May 21 01:47:49 2002
@@ -15,6 +15,7 @@
 #include "ext2.h"
 #include <linux/quotaops.h>
 #include <linux/sched.h>
+#include <linux/buffer_head.h>
 
 /*
  * balloc.c contains the blocks allocation and deallocation routines
===== fs/ext2/bitmap.c 1.2 vs edited =====
--- 1.2/fs/ext2/bitmap.c	Tue Feb  5 16:24:38 2002
+++ edited/fs/ext2/bitmap.c	Tue May 21 01:46:46 2002
@@ -7,7 +7,7 @@
  * Universite Pierre et Marie Curie (Paris VI)
  */
 
-#include "ext2.h"
+#include <linux/buffer_head.h>
 
 static int nibblemap[] = {4, 3, 3, 2, 3, 2, 2, 1, 3, 2, 2, 1, 2, 1, 1, 0};
 
===== fs/ext2/fsync.c 1.7 vs edited =====
--- 1.7/fs/ext2/fsync.c	Mon May 20 15:35:24 2002
+++ edited/fs/ext2/fsync.c	Tue May 21 01:46:47 2002
@@ -24,6 +24,7 @@
 
 #include "ext2.h"
 #include <linux/smp_lock.h>
+#include <linux/buffer_head.h>		/* for fsync_inode_buffers() */
 
 
 /*
===== fs/ext2/ialloc.c 1.16 vs edited =====
--- 1.16/fs/ext2/ialloc.c	Mon May 20 20:56:05 2002
+++ edited/fs/ext2/ialloc.c	Tue May 21 01:47:40 2002
@@ -16,6 +16,7 @@
 #include "ext2.h"
 #include <linux/quotaops.h>
 #include <linux/sched.h>
+#include <linux/buffer_head.h>
 
 
 /*
===== fs/ext2/inode.c 1.31 vs edited =====
--- 1.31/fs/ext2/inode.c	Mon May 20 15:49:47 2002
+++ edited/fs/ext2/inode.c	Tue May 21 01:46:47 2002
@@ -29,6 +29,7 @@
 #include <linux/pagemap.h>
 #include <linux/quotaops.h>
 #include <linux/module.h>
+#include <linux/buffer_head.h>
 
 MODULE_AUTHOR("Remy Card and others");
 MODULE_DESCRIPTION("Second Extended Filesystem");
===== fs/ext2/namei.c 1.11 vs edited =====
--- 1.11/fs/ext2/namei.c	Tue Apr 16 07:17:06 2002
+++ edited/fs/ext2/namei.c	Tue May 21 01:46:47 2002
@@ -31,6 +31,7 @@
 
 #include "ext2.h"
 #include <linux/pagemap.h>
+#include <linux/buffer_head.h>		/* for block_symlink() */
 
 /*
  * Couple of helper functions - make the code slightly cleaner.
===== fs/ext2/super.c 1.24 vs edited =====
--- 1.24/fs/ext2/super.c	Mon May 20 15:35:32 2002
+++ edited/fs/ext2/super.c	Tue May 21 01:46:47 2002
@@ -24,6 +24,7 @@
 #include <linux/init.h>
 #include <linux/blkdev.h>
 #include <linux/random.h>
+#include <linux/buffer_head.h>
 #include <linux/smp_lock.h>
 #include <asm/uaccess.h>
 
===== fs/ext3/balloc.c 1.5 vs edited =====
--- 1.5/fs/ext3/balloc.c	Mon May 20 15:35:35 2002
+++ edited/fs/ext3/balloc.c	Tue May 21 01:46:48 2002
@@ -18,6 +18,7 @@
 #include <linux/ext3_fs.h>
 #include <linux/ext3_jbd.h>
 #include <linux/quotaops.h>
+#include <linux/buffer_head.h>
 
 /*
  * balloc.c contains the blocks allocation and deallocation routines
===== fs/ext3/bitmap.c 1.1 vs edited =====
--- 1.1/fs/ext3/bitmap.c	Tue Feb  5 21:32:38 2002
+++ edited/fs/ext3/bitmap.c	Tue May 21 01:46:48 2002
@@ -7,7 +7,7 @@
  * Universite Pierre et Marie Curie (Paris VI)
  */
 
-#include <linux/fs.h>
+#include <linux/buffer_head.h>
 
 
 static int nibblemap[] = {4, 3, 3, 2, 3, 2, 2, 1, 3, 2, 2, 1, 2, 1, 1, 0};
===== fs/ext3/dir.c 1.2 vs edited =====
--- 1.2/fs/ext3/dir.c	Wed Apr 24 18:10:07 2002
+++ edited/fs/ext3/dir.c	Tue May 21 01:46:48 2002
@@ -21,6 +21,7 @@
 #include <linux/fs.h>
 #include <linux/jbd.h>
 #include <linux/ext3_fs.h>
+#include <linux/buffer_head.h>
 #include <linux/smp_lock.h>
 
 static unsigned char ext3_filetype_table[] = {
===== fs/ext3/ialloc.c 1.9 vs edited =====
--- 1.9/fs/ext3/ialloc.c	Mon May 20 15:35:39 2002
+++ edited/fs/ext3/ialloc.c	Tue May 21 01:46:48 2002
@@ -20,6 +20,7 @@
 #include <linux/stat.h>
 #include <linux/string.h>
 #include <linux/quotaops.h>
+#include <linux/buffer_head.h>
 
 #include <asm/bitops.h>
 #include <asm/byteorder.h>
===== fs/ext3/inode.c 1.19 vs edited =====
--- 1.19/fs/ext3/inode.c	Mon May 20 15:50:43 2002
+++ edited/fs/ext3/inode.c	Tue May 21 01:46:48 2002
@@ -32,6 +32,7 @@
 #include <linux/pagemap.h>
 #include <linux/quotaops.h>
 #include <linux/string.h>
+#include <linux/buffer_head.h>
 
 /*
  * SEARCH_FROM_ZERO forces each block allocation to search from the start
===== fs/ext3/namei.c 1.14 vs edited =====
--- 1.14/fs/ext3/namei.c	Mon May 20 15:35:44 2002
+++ edited/fs/ext3/namei.c	Tue May 21 01:46:48 2002
@@ -27,6 +27,7 @@
 #include <linux/stat.h>
 #include <linux/string.h>
 #include <linux/quotaops.h>
+#include <linux/buffer_head.h>
 #include <linux/smp_lock.h>
 
 
===== fs/ext3/super.c 1.21 vs edited =====
--- 1.21/fs/ext3/super.c	Mon May 20 15:35:46 2002
+++ edited/fs/ext3/super.c	Tue May 21 01:46:49 2002
@@ -28,6 +28,7 @@
 #include <linux/init.h>
 #include <linux/blkdev.h>
 #include <linux/smp_lock.h>
+#include <linux/buffer_head.h>
 #include <asm/uaccess.h>
 
 #ifdef CONFIG_JBD_DEBUG
===== fs/fat/buffer.c 1.7 vs edited =====
--- 1.7/fs/fat/buffer.c	Mon Apr 29 18:51:06 2002
+++ edited/fs/fat/buffer.c	Tue May 21 01:46:49 2002
@@ -8,6 +8,7 @@
 #include <linux/fs.h>
 #include <linux/msdos_fs.h>
 #include <linux/fat_cvf.h>
+#include <linux/buffer_head.h>
 
 struct buffer_head *fat_bread(struct super_block *sb, int block)
 {
===== fs/fat/cache.c 1.14 vs edited =====
--- 1.14/fs/fat/cache.c	Thu Apr 25 03:45:38 2002
+++ edited/fs/fat/cache.c	Tue May 21 01:46:49 2002
@@ -11,6 +11,7 @@
 #include <linux/fs.h>
 #include <linux/msdos_fs.h>
 #include <linux/fat_cvf.h>
+#include <linux/buffer_head.h>
 
 #if 0
 #  define PRINTK(x) printk x
===== fs/fat/cvf.c 1.3 vs edited =====
--- 1.3/fs/fat/cvf.c	Tue Feb  5 16:24:44 2002
+++ edited/fs/fat/cvf.c	Tue May 21 01:46:49 2002
@@ -13,6 +13,7 @@
 #include <linux/msdos_fs_sb.h>
 #include <linux/fat_cvf.h>
 #include <linux/config.h>
+#include <linux/buffer_head.h>
 #ifdef CONFIG_KMOD
 #include <linux/kmod.h>
 #endif
===== fs/fat/dir.c 1.11 vs edited =====
--- 1.11/fs/fat/dir.c	Fri May 17 23:17:59 2002
+++ edited/fs/fat/dir.c	Tue May 21 01:46:49 2002
@@ -18,6 +18,7 @@
 #include <linux/msdos_fs.h>
 #include <linux/dirent.h>
 #include <linux/smp_lock.h>
+#include <linux/buffer_head.h>
 
 #include <asm/uaccess.h>
 
===== fs/fat/file.c 1.13 vs edited =====
--- 1.13/fs/fat/file.c	Mon May 20 15:35:48 2002
+++ edited/fs/fat/file.c	Tue May 21 01:46:49 2002
@@ -10,6 +10,7 @@
 #include <linux/msdos_fs.h>
 #include <linux/fat_cvf.h>
 #include <linux/smp_lock.h>
+#include <linux/buffer_head.h>
 
 #define PRINTK(x)
 #define Printk(x) printk x
===== fs/fat/inode.c 1.39 vs edited =====
--- 1.39/fs/fat/inode.c	Mon May 20 16:06:31 2002
+++ edited/fs/fat/inode.c	Tue May 21 01:46:50 2002
@@ -17,6 +17,7 @@
 #include <linux/msdos_fs.h>
 #include <linux/fat_cvf.h>
 #include <linux/pagemap.h>
+#include <linux/buffer_head.h>
 
 //#include <asm/uaccess.h>
 #include <asm/unaligned.h>
===== fs/fat/misc.c 1.9 vs edited =====
--- 1.9/fs/fat/misc.c	Thu Apr 25 03:45:38 2002
+++ edited/fs/fat/misc.c	Tue May 21 01:46:50 2002
@@ -8,6 +8,7 @@
 
 #include <linux/fs.h>
 #include <linux/msdos_fs.h>
+#include <linux/buffer_head.h>
 
 #if 0
 #  define PRINTK(x)	printk x
===== fs/freevxfs/vxfs_bmap.c 1.7 vs edited =====
--- 1.7/fs/freevxfs/vxfs_bmap.c	Tue Feb  5 16:23:15 2002
+++ edited/fs/freevxfs/vxfs_bmap.c	Tue May 21 01:46:50 2002
@@ -33,6 +33,7 @@
  * Veritas filesystem driver - filesystem to disk block mapping.
  */
 #include <linux/fs.h>
+#include <linux/buffer_head.h>
 #include <linux/kernel.h>
 
 #include "vxfs.h"
===== fs/freevxfs/vxfs_fshead.c 1.4 vs edited =====
--- 1.4/fs/freevxfs/vxfs_fshead.c	Tue Feb  5 16:23:15 2002
+++ edited/fs/freevxfs/vxfs_fshead.c	Tue May 21 01:46:50 2002
@@ -33,6 +33,7 @@
  * Veritas filesystem driver - fileset header routines.
  */
 #include <linux/fs.h>
+#include <linux/buffer_head.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
 
===== fs/freevxfs/vxfs_inode.c 1.8 vs edited =====
--- 1.8/fs/freevxfs/vxfs_inode.c	Tue Feb  5 16:23:15 2002
+++ edited/fs/freevxfs/vxfs_inode.c	Tue May 21 01:46:50 2002
@@ -33,6 +33,7 @@
  * Veritas filesystem driver - inode routines.
  */
 #include <linux/fs.h>
+#include <linux/buffer_head.h>
 #include <linux/pagemap.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
===== fs/freevxfs/vxfs_olt.c 1.4 vs edited =====
--- 1.4/fs/freevxfs/vxfs_olt.c	Tue Feb  5 16:23:15 2002
+++ edited/fs/freevxfs/vxfs_olt.c	Tue May 21 01:46:50 2002
@@ -33,6 +33,7 @@
  * Veritas filesystem driver - object location table support.
  */
 #include <linux/fs.h>
+#include <linux/buffer_head.h>
 #include <linux/kernel.h>
 
 #include "vxfs.h"
===== fs/freevxfs/vxfs_subr.c 1.8 vs edited =====
--- 1.8/fs/freevxfs/vxfs_subr.c	Tue Apr 30 00:18:54 2002
+++ edited/fs/freevxfs/vxfs_subr.c	Tue May 21 01:46:50 2002
@@ -33,6 +33,7 @@
  * Veritas filesystem driver - shared subroutines.
  */
 #include <linux/fs.h>
+#include <linux/buffer_head.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/pagemap.h>
===== fs/freevxfs/vxfs_super.c 1.8 vs edited =====
--- 1.8/fs/freevxfs/vxfs_super.c	Fri Mar  8 20:00:27 2002
+++ edited/fs/freevxfs/vxfs_super.c	Tue May 21 01:46:51 2002
@@ -37,6 +37,7 @@
 
 #include <linux/blkdev.h>
 #include <linux/fs.h>
+#include <linux/buffer_head.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/stat.h>
===== fs/hfs/file.c 1.11 vs edited =====
--- 1.11/fs/hfs/file.c	Mon Apr 29 18:51:06 2002
+++ edited/fs/hfs/file.c	Tue May 21 01:46:51 2002
@@ -20,6 +20,7 @@
 #include <linux/hfs_fs_sb.h>
 #include <linux/hfs_fs_i.h>
 #include <linux/hfs_fs.h>
+#include <linux/buffer_head.h>
 #include <linux/smp_lock.h>
 
 /*================ Forward declarations ================*/
===== fs/hpfs/alloc.c 1.1 vs edited =====
--- 1.1/fs/hpfs/alloc.c	Tue Feb  5 18:39:38 2002
+++ edited/fs/hpfs/alloc.c	Tue May 21 01:46:51 2002
@@ -6,6 +6,7 @@
  *  HPFS bitmap operations
  */
 
+#include <linux/buffer_head.h>
 #include "hpfs_fn.h"
 
 /*
===== fs/hpfs/anode.c 1.3 vs edited =====
--- 1.3/fs/hpfs/anode.c	Tue Feb  5 16:24:38 2002
+++ edited/fs/hpfs/anode.c	Tue May 21 01:46:51 2002
@@ -6,6 +6,7 @@
  *  handling HPFS anode tree that contains file allocation info
  */
 
+#include <linux/buffer_head.h>
 #include "hpfs_fn.h"
 
 /* Find a sector in allocation tree */
===== fs/hpfs/buffer.c 1.5 vs edited =====
--- 1.5/fs/hpfs/buffer.c	Mon Apr 29 18:51:06 2002
+++ edited/fs/hpfs/buffer.c	Tue May 21 01:46:51 2002
@@ -6,6 +6,7 @@
  *  general buffer i/o
  */
 
+#include <linux/buffer_head.h>
 #include <linux/string.h>
 #include "hpfs_fn.h"
 
===== fs/hpfs/dir.c 1.7 vs edited =====
--- 1.7/fs/hpfs/dir.c	Wed Apr 24 17:50:15 2002
+++ edited/fs/hpfs/dir.c	Tue May 21 01:46:51 2002
@@ -7,6 +7,7 @@
  */
 
 #include "hpfs_fn.h"
+#include <linux/buffer_head.h>
 #include <linux/time.h>
 #include <linux/smp_lock.h>
 
===== fs/hpfs/dnode.c 1.2 vs edited =====
--- 1.2/fs/hpfs/dnode.c	Tue Feb  5 16:24:38 2002
+++ edited/fs/hpfs/dnode.c	Tue May 21 01:46:52 2002
@@ -6,6 +6,7 @@
  *  handling directory dnode tree - adding, deleteing & searching for dirents
  */
 
+#include <linux/buffer_head.h>
 #include "hpfs_fn.h"
 
 static loff_t get_pos(struct dnode *d, struct hpfs_dirent *fde)
===== fs/hpfs/ea.c 1.3 vs edited =====
--- 1.3/fs/hpfs/ea.c	Sat Mar  2 12:53:22 2002
+++ edited/fs/hpfs/ea.c	Tue May 21 01:46:52 2002
@@ -6,6 +6,7 @@
  *  handling extended attributes
  */
 
+#include <linux/buffer_head.h>
 #include <linux/string.h>
 #include "hpfs_fn.h"
 
===== fs/hpfs/file.c 1.9 vs edited =====
--- 1.9/fs/hpfs/file.c	Mon May 20 16:54:41 2002
+++ edited/fs/hpfs/file.c	Tue May 21 01:46:52 2002
@@ -6,6 +6,7 @@
  *  file VFS functions
  */
 
+#include <linux/buffer_head.h>
 #include <linux/string.h>
 #include <linux/time.h>
 #include <linux/smp_lock.h>
===== fs/hpfs/hpfs_fn.h 1.7 vs edited =====
--- 1.7/fs/hpfs/hpfs_fn.h	Mon May 20 16:24:01 2002
+++ edited/fs/hpfs/hpfs_fn.h	Tue May 21 02:34:28 2002
@@ -9,6 +9,7 @@
 //#define DBG
 //#define DEBUG_LOCKS
 
+#include <linux/buffer_head.h>
 #include <linux/fs.h>
 #include <linux/hpfs_fs.h>
 #include <linux/hpfs_fs_i.h>
===== fs/hpfs/inode.c 1.9 vs edited =====
--- 1.9/fs/hpfs/inode.c	Mon May 20 17:01:05 2002
+++ edited/fs/hpfs/inode.c	Tue May 21 01:46:53 2002
@@ -9,6 +9,7 @@
 #include <linux/fs.h>
 #include <linux/time.h>
 #include <linux/smp_lock.h>
+#include <linux/buffer_head.h>
 #include "hpfs_fn.h"
 
 static struct file_operations hpfs_file_ops =
===== fs/hpfs/map.c 1.1 vs edited =====
--- 1.1/fs/hpfs/map.c	Tue Feb  5 18:39:38 2002
+++ edited/fs/hpfs/map.c	Tue May 21 01:46:53 2002
@@ -6,6 +6,7 @@
  *  mapping structures to memory with some minimal checks
  */
 
+#include <linux/buffer_head.h>
 #include "hpfs_fn.h"
 
 unsigned *hpfs_map_dnode_bitmap(struct super_block *s, struct quad_buffer_head *qbh)
===== fs/hpfs/namei.c 1.13 vs edited =====
--- 1.13/fs/hpfs/namei.c	Mon May 20 16:55:37 2002
+++ edited/fs/hpfs/namei.c	Tue May 21 01:46:53 2002
@@ -8,6 +8,7 @@
 
 #include <linux/pagemap.h>
 #include <linux/string.h>
+#include <linux/buffer_head.h>
 #include "hpfs_fn.h"
 
 int hpfs_mkdir(struct inode *dir, struct dentry *dentry, int mode)
===== fs/hpfs/super.c 1.13 vs edited =====
--- 1.13/fs/hpfs/super.c	Wed Mar 13 21:21:39 2002
+++ edited/fs/hpfs/super.c	Tue May 21 01:46:53 2002
@@ -6,6 +6,7 @@
  *  mounting, unmounting, error handling
  */
 
+#include <linux/buffer_head.h>
 #include <linux/string.h>
 #include "hpfs_fn.h"
 #include <linux/module.h>
===== fs/isofs/compress.c 1.9 vs edited =====
--- 1.9/fs/isofs/compress.c	Mon May 20 15:37:01 2002
+++ edited/fs/isofs/compress.c	Tue May 21 01:46:53 2002
@@ -36,6 +36,7 @@
 #include <linux/blkdev.h>
 #include <linux/vmalloc.h>
 #include <linux/zlib.h>
+#include <linux/buffer_head.h>
 
 #include <asm/system.h>
 #include <asm/uaccess.h>
===== fs/isofs/dir.c 1.8 vs edited =====
--- 1.8/fs/isofs/dir.c	Mon May 20 15:37:03 2002
+++ edited/fs/isofs/dir.c	Tue May 21 01:46:53 2002
@@ -21,6 +21,7 @@
 #include <linux/time.h>
 #include <linux/config.h>
 #include <linux/smp_lock.h>
+#include <linux/buffer_head.h>
 
 #include <asm/uaccess.h>
 
===== fs/isofs/inode.c 1.21 vs edited =====
--- 1.21/fs/isofs/inode.c	Mon May 20 15:37:05 2002
+++ edited/fs/isofs/inode.c	Tue May 21 01:46:53 2002
@@ -27,6 +27,7 @@
 #include <linux/ctype.h>
 #include <linux/smp_lock.h>
 #include <linux/blkdev.h>
+#include <linux/buffer_head.h>
 
 #include <asm/system.h>
 #include <asm/uaccess.h>
===== fs/isofs/namei.c 1.8 vs edited =====
--- 1.8/fs/isofs/namei.c	Sat Mar 16 01:32:28 2002
+++ edited/fs/isofs/namei.c	Tue May 21 01:46:54 2002
@@ -16,6 +16,7 @@
 #include <linux/errno.h>
 #include <linux/config.h>	/* Joliet? */
 #include <linux/smp_lock.h>
+#include <linux/buffer_head.h>
 
 #include <asm/uaccess.h>
 
===== fs/isofs/rock.c 1.11 vs edited =====
--- 1.11/fs/isofs/rock.c	Tue Apr 30 00:18:35 2002
+++ edited/fs/isofs/rock.c	Tue May 21 01:46:54 2002
@@ -14,6 +14,7 @@
 #include <linux/slab.h>
 #include <linux/pagemap.h>
 #include <linux/smp_lock.h>
+#include <linux/buffer_head.h>
 
 #include "rock.h"
 
===== fs/jffs/intrep.h 1.3 vs edited =====
--- 1.3/fs/jffs/intrep.h	Tue Feb  5 08:49:33 2002
+++ edited/fs/jffs/intrep.h	Tue May 21 01:46:54 2002
@@ -85,7 +85,4 @@
 void jffs_print_hash_table(struct jffs_control *c);
 void jffs_print_tree(struct jffs_file *first_file, int indent);
 
-struct buffer_head *jffs_get_write_buffer(kdev_t dev, int block);
-void jffs_put_write_buffer(struct buffer_head *bh);
-
 #endif /* __LINUX_JFFS_INTREP_H__  */
===== fs/jfs/inode.c 1.5 vs edited =====
--- 1.5/fs/jfs/inode.c	Mon May 20 15:40:18 2002
+++ edited/fs/jfs/inode.c	Tue May 21 01:46:54 2002
@@ -17,6 +17,7 @@
  */
 
 #include <linux/fs.h>
+#include <linux/buffer_head.h>
 #include "jfs_incore.h"
 #include "jfs_filsys.h"
 #include "jfs_imap.h"
===== fs/jfs/jfs_logmgr.c 1.14 vs edited =====
--- 1.14/fs/jfs/jfs_logmgr.c	Mon May 20 15:40:25 2002
+++ edited/fs/jfs/jfs_logmgr.c	Tue May 21 01:46:54 2002
@@ -63,6 +63,7 @@
 #include <linux/interrupt.h>
 #include <linux/smp_lock.h>
 #include <linux/completion.h>
+#include <linux/buffer_head.h>		/* for sync_blockdev() */
 #include "jfs_incore.h"
 #include "jfs_filsys.h"
 #include "jfs_metapage.h"
===== fs/jfs/jfs_metapage.c 1.9 vs edited =====
--- 1.9/fs/jfs/jfs_metapage.c	Mon Apr 29 18:51:06 2002
+++ edited/fs/jfs/jfs_metapage.c	Tue May 21 01:46:54 2002
@@ -18,6 +18,7 @@
 
 #include <linux/fs.h>
 #include <linux/init.h>
+#include <linux/buffer_head.h>
 #include "jfs_incore.h"
 #include "jfs_filsys.h"
 #include "jfs_metapage.h"
===== fs/minix/bitmap.c 1.9 vs edited =====
--- 1.9/fs/minix/bitmap.c	Wed Mar 20 08:41:14 2002
+++ edited/fs/minix/bitmap.c	Tue May 21 01:46:55 2002
@@ -13,6 +13,7 @@
 
 #include "minix.h"
 #include <linux/smp_lock.h>
+#include <linux/buffer_head.h>
 #include <asm/bitops.h>
 
 static int nibblemap[] = { 4,3,3,2,3,2,2,1,3,2,2,1,2,1,1,0 };
===== fs/minix/file.c 1.7 vs edited =====
--- 1.7/fs/minix/file.c	Sun May 19 13:49:46 2002
+++ edited/fs/minix/file.c	Tue May 21 01:46:55 2002
@@ -6,6 +6,7 @@
  *  minix regular file handling primitives
  */
 
+#include <linux/buffer_head.h>		/* for fsync_inode_buffers() */
 #include "minix.h"
 
 /*
===== fs/minix/inode.c 1.23 vs edited =====
--- 1.23/fs/minix/inode.c	Mon May 20 15:37:34 2002
+++ edited/fs/minix/inode.c	Tue May 21 01:46:55 2002
@@ -11,6 +11,7 @@
 
 #include <linux/module.h>
 #include "minix.h"
+#include <linux/buffer_head.h>
 #include <linux/slab.h>
 #include <linux/init.h>
 #include <linux/highuid.h>
===== fs/minix/itree_v1.c 1.7 vs edited =====
--- 1.7/fs/minix/itree_v1.c	Mon May 20 15:37:40 2002
+++ edited/fs/minix/itree_v1.c	Tue May 21 01:46:55 2002
@@ -1,3 +1,4 @@
+#include <linux/buffer_head.h>
 #include "minix.h"
 
 enum {DEPTH = 3, DIRECT = 7};	/* Only double indirect */
===== fs/minix/itree_v2.c 1.7 vs edited =====
--- 1.7/fs/minix/itree_v2.c	Mon May 20 15:37:43 2002
+++ edited/fs/minix/itree_v2.c	Tue May 21 01:46:55 2002
@@ -1,3 +1,4 @@
+#include <linux/buffer_head.h>
 #include "minix.h"
 
 enum {DIRECT = 7, DEPTH = 4};	/* Have triple indirect */
===== fs/minix/namei.c 1.10 vs edited =====
--- 1.10/fs/minix/namei.c	Wed Mar 20 05:30:40 2002
+++ edited/fs/minix/namei.c	Tue May 21 01:46:55 2002
@@ -4,6 +4,7 @@
  *  Copyright (C) 1991, 1992  Linus Torvalds
  */
 
+#include <linux/buffer_head.h>	/* for block_symlink() */
 #include "minix.h"
 
 static inline void inc_count(struct inode *inode)
===== fs/msdos/namei.c 1.21 vs edited =====
--- 1.21/fs/msdos/namei.c	Tue May  7 06:35:29 2002
+++ edited/fs/msdos/namei.c	Tue May 21 01:46:55 2002
@@ -9,6 +9,7 @@
 #include <linux/module.h>
 
 #include <linux/time.h>
+#include <linux/buffer_head.h>
 #include <linux/msdos_fs.h>
 #include <linux/smp_lock.h>
 
===== fs/ntfs/aops.c 1.70 vs edited =====
--- 1.70/fs/ntfs/aops.c	Mon May 20 15:38:18 2002
+++ edited/fs/ntfs/aops.c	Tue May 21 01:46:56 2002
@@ -25,6 +25,7 @@
 #include <linux/mm.h>
 #include <linux/pagemap.h>
 #include <linux/swap.h>
+#include <linux/buffer_head.h>
 
 #include "ntfs.h"
 
===== fs/ntfs/attrib.c 1.74 vs edited =====
--- 1.74/fs/ntfs/attrib.c	Wed Apr 24 02:40:01 2002
+++ edited/fs/ntfs/attrib.c	Tue May 21 01:46:56 2002
@@ -20,6 +20,7 @@
  * Foundation,Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 
+#include <linux/buffer_head.h>
 #include "ntfs.h"
 
 /* Temporary helper functions -- might become macros */
===== fs/ntfs/compress.c 1.41 vs edited =====
--- 1.41/fs/ntfs/compress.c	Mon May 20 15:38:20 2002
+++ edited/fs/ntfs/compress.c	Tue May 21 01:46:56 2002
@@ -22,6 +22,7 @@
  */
 
 #include <linux/fs.h>
+#include <linux/buffer_head.h>
 
 #include "ntfs.h"
 
===== fs/ntfs/inode.c 1.80 vs edited =====
--- 1.80/fs/ntfs/inode.c	Wed May  1 21:22:13 2002
+++ edited/fs/ntfs/inode.c	Tue May 21 01:46:56 2002
@@ -20,6 +20,7 @@
  */
 
 #include <linux/pagemap.h>
+#include <linux/buffer_head.h>
 
 #include "ntfs.h"
 
===== fs/ntfs/super.c 1.100 vs edited =====
--- 1.100/fs/ntfs/super.c	Mon May 20 15:38:24 2002
+++ edited/fs/ntfs/super.c	Tue May 21 01:46:56 2002
@@ -26,6 +26,7 @@
 #include <linux/spinlock.h>
 #include <linux/blkdev.h>	/* For bdev_hardsect_size(). */
 #include <linux/backing-dev.h>
+#include <linux/buffer_head.h>
 
 #include "ntfs.h"
 #include "sysctl.h"
===== fs/partitions/check.c 1.22 vs edited =====
--- 1.22/fs/partitions/check.c	Wed May  1 00:07:04 2002
+++ edited/fs/partitions/check.c	Tue May 21 01:46:57 2002
@@ -21,6 +21,7 @@
 #include <linux/blk.h>
 #include <linux/init.h>
 #include <linux/raid/md.h>
+#include <linux/buffer_head.h>	/* for invalidate_bdev() */
 
 #include "check.h"
 
===== fs/partitions/msdos.c 1.11 vs edited =====
--- 1.11/fs/partitions/msdos.c	Wed Apr 24 22:00:33 2002
+++ edited/fs/partitions/msdos.c	Tue May 21 01:46:57 2002
@@ -26,6 +26,7 @@
 #include <linux/major.h>
 #include <linux/string.h>
 #include <linux/blk.h>
+#include <linux/buffer_head.h>		/* for invalidate_bdev() */
 
 #ifdef CONFIG_BLK_DEV_IDE
 #include <linux/ide.h>	/* IDE xlate */
===== fs/qnx4/bitmap.c 1.5 vs edited =====
--- 1.5/fs/qnx4/bitmap.c	Wed Mar 13 21:06:39 2002
+++ edited/fs/qnx4/bitmap.c	Tue May 21 01:46:58 2002
@@ -20,6 +20,7 @@
 #include <linux/stat.h>
 #include <linux/kernel.h>
 #include <linux/string.h>
+#include <linux/buffer_head.h>
 
 #include <asm/bitops.h>
 
===== fs/qnx4/dir.c 1.4 vs edited =====
--- 1.4/fs/qnx4/dir.c	Wed Apr 24 17:50:15 2002
+++ edited/fs/qnx4/dir.c	Tue May 21 01:46:58 2002
@@ -18,6 +18,7 @@
 #include <linux/qnx4_fs.h>
 #include <linux/stat.h>
 #include <linux/smp_lock.h>
+#include <linux/buffer_head.h>
 
 
 static int qnx4_readdir(struct file *filp, void *dirent, filldir_t filldir)
===== fs/qnx4/fsync.c 1.6 vs edited =====
--- 1.6/fs/qnx4/fsync.c	Mon May 20 15:38:30 2002
+++ edited/fs/qnx4/fsync.c	Tue May 21 01:46:58 2002
@@ -16,6 +16,7 @@
 #include <linux/stat.h>
 #include <linux/fcntl.h>
 #include <linux/smp_lock.h>
+#include <linux/buffer_head.h>
 
 #include <linux/fs.h>
 #include <linux/qnx4_fs.h>
===== fs/qnx4/inode.c 1.18 vs edited =====
--- 1.18/fs/qnx4/inode.c	Mon May 20 17:07:51 2002
+++ edited/fs/qnx4/inode.c	Tue May 21 01:46:58 2002
@@ -24,6 +24,7 @@
 #include <linux/highuid.h>
 #include <linux/smp_lock.h>
 #include <linux/pagemap.h>
+#include <linux/buffer_head.h>
 
 #include <asm/uaccess.h>
 
===== fs/qnx4/namei.c 1.7 vs edited =====
--- 1.7/fs/qnx4/namei.c	Thu Feb 14 11:30:17 2002
+++ edited/fs/qnx4/namei.c	Tue May 21 01:46:58 2002
@@ -22,6 +22,7 @@
 #include <linux/fcntl.h>
 #include <linux/errno.h>
 #include <linux/smp_lock.h>
+#include <linux/buffer_head.h>
 
 
 /*
===== fs/ramfs/inode.c 1.17 vs edited =====
--- 1.17/fs/ramfs/inode.c	Mon May 20 15:38:36 2002
+++ edited/fs/ramfs/inode.c	Tue May 21 01:46:58 2002
@@ -29,6 +29,7 @@
 #include <linux/init.h>
 #include <linux/string.h>
 #include <linux/smp_lock.h>
+#include <linux/buffer_head.h>		/* for block_symlink() */
 
 #include <asm/uaccess.h>
 
===== fs/reiserfs/bitmap.c 1.16 vs edited =====
--- 1.16/fs/reiserfs/bitmap.c	Mon May 20 15:38:38 2002
+++ edited/fs/reiserfs/bitmap.c	Tue May 21 01:46:58 2002
@@ -7,6 +7,7 @@
 #include <linux/reiserfs_fs.h>
 #include <asm/bitops.h>
 #include <linux/list.h>
+#include <linux/buffer_head.h>
 
 #ifdef CONFIG_REISERFS_CHECK
 
===== fs/reiserfs/buffer2.c 1.12 vs edited =====
--- 1.12/fs/reiserfs/buffer2.c	Mon May 20 15:38:41 2002
+++ edited/fs/reiserfs/buffer2.c	Tue May 21 01:46:59 2002
@@ -7,6 +7,7 @@
 #include <linux/reiserfs_fs.h>
 #include <linux/smp_lock.h>
 #include <linux/kernel_stat.h>
+#include <linux/buffer_head.h>
 
 /*
  *  wait_buffer_until_released
===== fs/reiserfs/dir.c 1.14 vs edited =====
--- 1.14/fs/reiserfs/dir.c	Wed Apr 24 17:50:15 2002
+++ edited/fs/reiserfs/dir.c	Tue May 21 01:46:59 2002
@@ -9,6 +9,7 @@
 #include <linux/reiserfs_fs.h>
 #include <linux/stat.h>
 #include <linux/smp_lock.h>
+#include <linux/buffer_head.h>
 #include <asm/uaccess.h>
 
 extern struct key  MIN_KEY;
===== fs/reiserfs/do_balan.c 1.13 vs edited =====
--- 1.13/fs/reiserfs/do_balan.c	Mon Apr 29 18:51:06 2002
+++ edited/fs/reiserfs/do_balan.c	Tue May 21 01:46:59 2002
@@ -20,6 +20,7 @@
 #include <asm/uaccess.h>
 #include <linux/time.h>
 #include <linux/reiserfs_fs.h>
+#include <linux/buffer_head.h>
 
 #ifdef CONFIG_REISERFS_CHECK
 
===== fs/reiserfs/fix_node.c 1.21 vs edited =====
--- 1.21/fs/reiserfs/fix_node.c	Mon May 20 15:38:44 2002
+++ edited/fs/reiserfs/fix_node.c	Tue May 21 01:46:59 2002
@@ -39,6 +39,7 @@
 #include <linux/time.h>
 #include <linux/string.h>
 #include <linux/reiserfs_fs.h>
+#include <linux/buffer_head.h>
 
 
 /* To make any changes in the tree we find a node, that contains item
===== fs/reiserfs/ibalance.c 1.9 vs edited =====
--- 1.9/fs/reiserfs/ibalance.c	Wed Mar 27 20:38:22 2002
+++ edited/fs/reiserfs/ibalance.c	Tue May 21 01:46:59 2002
@@ -7,6 +7,7 @@
 #include <linux/string.h>
 #include <linux/time.h>
 #include <linux/reiserfs_fs.h>
+#include <linux/buffer_head.h>
 
 /* this is one and only function that is used outside (do_balance.c) */
 int	balance_internal (
===== fs/reiserfs/inode.c 1.58 vs edited =====
--- 1.58/fs/reiserfs/inode.c	Mon May 20 17:06:22 2002
+++ edited/fs/reiserfs/inode.c	Tue May 21 01:46:59 2002
@@ -9,6 +9,7 @@
 #include <linux/pagemap.h>
 #include <asm/uaccess.h>
 #include <asm/unaligned.h>
+#include <linux/buffer_head.h>
 
 /* args for the create parameter of reiserfs_get_block */
 #define GET_BLOCK_NO_CREATE 0 /* don't create new blocks or convert tails */
===== fs/reiserfs/journal.c 1.40 vs edited =====
--- 1.40/fs/reiserfs/journal.c	Mon May 20 15:38:54 2002
+++ edited/fs/reiserfs/journal.c	Tue May 21 01:47:00 2002
@@ -57,6 +57,7 @@
 #include <linux/stat.h>
 #include <linux/string.h>
 #include <linux/smp_lock.h>
+#include <linux/buffer_head.h>
 
 /* the number of mounted filesystems.  This is used to decide when to
 ** start and kill the commit thread
===== fs/reiserfs/lbalance.c 1.8 vs edited =====
--- 1.8/fs/reiserfs/lbalance.c	Sat Feb  9 04:10:55 2002
+++ edited/fs/reiserfs/lbalance.c	Tue May 21 01:47:00 2002
@@ -7,6 +7,7 @@
 #include <linux/string.h>
 #include <linux/time.h>
 #include <linux/reiserfs_fs.h>
+#include <linux/buffer_head.h>
 
 /* these are used in do_balance.c */
 
===== fs/reiserfs/prints.c 1.16 vs edited =====
--- 1.16/fs/reiserfs/prints.c	Tue Apr 30 00:18:28 2002
+++ edited/fs/reiserfs/prints.c	Tue May 21 01:47:00 2002
@@ -7,6 +7,7 @@
 #include <linux/fs.h>
 #include <linux/reiserfs_fs.h>
 #include <linux/string.h>
+#include <linux/buffer_head.h>
 
 #include <stdarg.h>
 
===== fs/reiserfs/resize.c 1.7 vs edited =====
--- 1.7/fs/reiserfs/resize.c	Mon May 20 15:39:01 2002
+++ edited/fs/reiserfs/resize.c	Tue May 21 01:47:00 2002
@@ -14,6 +14,7 @@
 #include <linux/errno.h>
 #include <linux/reiserfs_fs.h>
 #include <linux/reiserfs_fs_sb.h>
+#include <linux/buffer_head.h>
 
 int reiserfs_resize (struct super_block * s, unsigned long block_count_new)
 {
===== fs/reiserfs/stree.c 1.28 vs edited =====
--- 1.28/fs/reiserfs/stree.c	Mon May 20 15:39:03 2002
+++ edited/fs/reiserfs/stree.c	Tue May 21 01:47:00 2002
@@ -59,6 +59,7 @@
 #include <linux/pagemap.h>
 #include <linux/reiserfs_fs.h>
 #include <linux/smp_lock.h>
+#include <linux/buffer_head.h>
 
 /* Does the buffer contain a disk block which is in the tree. */
 inline int B_IS_IN_TREE (const struct buffer_head * p_s_bh)
===== fs/reiserfs/super.c 1.41 vs edited =====
--- 1.41/fs/reiserfs/super.c	Mon May 20 15:39:05 2002
+++ edited/fs/reiserfs/super.c	Tue May 21 01:47:01 2002
@@ -19,6 +19,7 @@
 #include <linux/smp_lock.h>
 #include <linux/init.h>
 #include <linux/blkdev.h>
+#include <linux/buffer_head.h>
 
 #define REISERFS_OLD_BLOCKSIZE 4096
 #define REISERFS_SUPER_MAGIC_STRING_OFFSET_NJ 20
===== fs/reiserfs/tail_conversion.c 1.20 vs edited =====
--- 1.20/fs/reiserfs/tail_conversion.c	Mon May 20 15:39:07 2002
+++ edited/fs/reiserfs/tail_conversion.c	Tue May 21 01:47:01 2002
@@ -5,6 +5,7 @@
 #include <linux/config.h>
 #include <linux/time.h>
 #include <linux/pagemap.h>
+#include <linux/buffer_head.h>
 #include <linux/reiserfs_fs.h>
 
 /* access to tail : when one is going to read tail it must make sure, that is not running.
===== fs/romfs/inode.c 1.19 vs edited =====
--- 1.19/fs/romfs/inode.c	Mon May 20 17:05:58 2002
+++ edited/fs/romfs/inode.c	Tue May 21 01:47:01 2002
@@ -73,6 +73,7 @@
 #include <linux/init.h>
 #include <linux/pagemap.h>
 #include <linux/smp_lock.h>
+#include <linux/buffer_head.h>
 
 #include <asm/uaccess.h>
 
===== fs/sysv/balloc.c 1.8 vs edited =====
--- 1.8/fs/sysv/balloc.c	Mon May 20 15:39:18 2002
+++ edited/fs/sysv/balloc.c	Tue May 21 01:47:01 2002
@@ -19,6 +19,7 @@
  *  This file contains code for allocating/freeing blocks.
  */
 
+#include <linux/buffer_head.h>
 #include "sysv.h"
 
 /* We don't trust the value of
===== fs/sysv/ialloc.c 1.10 vs edited =====
--- 1.10/fs/sysv/ialloc.c	Mon May 20 16:07:13 2002
+++ edited/fs/sysv/ialloc.c	Tue May 21 01:47:01 2002
@@ -24,6 +24,7 @@
 #include <linux/sched.h>
 #include <linux/stat.h>
 #include <linux/string.h>
+#include <linux/buffer_head.h>
 #include "sysv.h"
 
 /* We don't trust the value of
===== fs/sysv/inode.c 1.20 vs edited =====
--- 1.20/fs/sysv/inode.c	Mon May 20 15:39:22 2002
+++ edited/fs/sysv/inode.c	Tue May 21 01:47:01 2002
@@ -25,6 +25,7 @@
 #include <linux/highuid.h>
 #include <linux/slab.h>
 #include <linux/init.h>
+#include <linux/buffer_head.h>
 #include <asm/byteorder.h>
 #include "sysv.h"
 
===== fs/sysv/itree.c 1.11 vs edited =====
--- 1.11/fs/sysv/itree.c	Mon May 20 15:39:26 2002
+++ edited/fs/sysv/itree.c	Tue May 21 01:47:02 2002
@@ -5,6 +5,7 @@
  *  AV, Sep--Dec 2000
  */
 
+#include <linux/buffer_head.h>
 #include "sysv.h"
 
 enum {DIRECT = 10, DEPTH = 4};	/* Have triple indirect */
===== fs/sysv/super.c 1.15 vs edited =====
--- 1.15/fs/sysv/super.c	Fri Apr 19 17:34:33 2002
+++ edited/fs/sysv/super.c	Tue May 21 01:47:02 2002
@@ -23,6 +23,7 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/slab.h>
+#include <linux/buffer_head.h>
 #include "sysv.h"
 
 /*
===== fs/sysv/sysv.h 1.1 vs edited =====
--- 1.1/fs/sysv/sysv.h	Wed Apr  3 15:50:40 2002
+++ edited/fs/sysv/sysv.h	Tue May 21 02:39:58 2002
@@ -1,7 +1,7 @@
 #ifndef _SYSV_H
 #define _SYSV_H
 
-#include <linux/fs.h>
+#include <linux/buffer_head.h>
 #include <linux/sysv_fs.h>
 
 /*
===== fs/udf/balloc.c 1.8 vs edited =====
--- 1.8/fs/udf/balloc.c	Mon May 20 15:39:29 2002
+++ edited/fs/udf/balloc.c	Tue May 21 01:47:02 2002
@@ -27,6 +27,7 @@
 #include "udfdecl.h"
 
 #include <linux/quotaops.h>
+#include <linux/buffer_head.h>
 #include <asm/bitops.h>
 
 #include "udf_i.h"
===== fs/udf/dir.c 1.8 vs edited =====
--- 1.8/fs/udf/dir.c	Wed Apr 24 17:50:15 2002
+++ edited/fs/udf/dir.c	Tue May 21 01:47:03 2002
@@ -36,6 +36,7 @@
 #include <linux/mm.h>
 #include <linux/slab.h>
 #include <linux/smp_lock.h>
+#include <linux/buffer_head.h>
 
 #include "udf_i.h"
 #include "udf_sb.h"
===== fs/udf/directory.c 1.4 vs edited =====
--- 1.4/fs/udf/directory.c	Wed Mar 13 00:56:21 2002
+++ edited/fs/udf/directory.c	Tue May 21 01:47:03 2002
@@ -20,6 +20,7 @@
 
 #include <linux/fs.h>
 #include <linux/string.h>
+#include <linux/buffer_head.h>
 
 uint8_t * udf_filead_read(struct inode *dir, uint8_t *tmpad, uint8_t ad_size,
 	lb_addr fe_loc, int *pos, int *offset, struct buffer_head **bh, int *error)
===== fs/udf/file.c 1.9 vs edited =====
--- 1.9/fs/udf/file.c	Mon May 20 16:56:47 2002
+++ edited/fs/udf/file.c	Tue May 21 01:47:03 2002
@@ -39,6 +39,7 @@
 #include <linux/errno.h>
 #include <linux/smp_lock.h>
 #include <linux/pagemap.h>
+#include <linux/buffer_head.h>
 
 #include "udf_i.h"
 #include "udf_sb.h"
===== fs/udf/ialloc.c 1.8 vs edited =====
--- 1.8/fs/udf/ialloc.c	Mon May 20 15:39:35 2002
+++ edited/fs/udf/ialloc.c	Tue May 21 02:50:45 2002
@@ -27,6 +27,7 @@
 #include <linux/fs.h>
 #include <linux/quotaops.h>
 #include <linux/udf_fs.h>
+#include <linux/sched.h>
 
 #include "udf_i.h"
 #include "udf_sb.h"
===== fs/udf/inode.c 1.20 vs edited =====
--- 1.20/fs/udf/inode.c	Mon May 20 16:56:21 2002
+++ edited/fs/udf/inode.c	Tue May 21 01:47:03 2002
@@ -38,6 +38,7 @@
 #include <linux/smp_lock.h>
 #include <linux/module.h>
 #include <linux/pagemap.h>
+#include <linux/buffer_head.h>
 
 #include "udf_i.h"
 #include "udf_sb.h"
===== fs/udf/misc.c 1.4 vs edited =====
--- 1.4/fs/udf/misc.c	Wed Mar 13 00:56:22 2002
+++ edited/fs/udf/misc.c	Tue May 21 01:47:03 2002
@@ -29,6 +29,7 @@
 #include <linux/fs.h>
 #include <linux/string.h>
 #include <linux/udf_fs.h>
+#include <linux/buffer_head.h>
 
 #include "udf_i.h"
 #include "udf_sb.h"
===== fs/udf/namei.c 1.19 vs edited =====
--- 1.19/fs/udf/namei.c	Mon May 20 15:39:42 2002
+++ edited/fs/udf/namei.c	Tue May 21 01:47:03 2002
@@ -34,6 +34,7 @@
 #include <linux/slab.h>
 #include <linux/quotaops.h>
 #include <linux/smp_lock.h>
+#include <linux/buffer_head.h>
 
 static inline int udf_match(int len, const char * const name, struct qstr *qs)
 {
===== fs/udf/partition.c 1.6 vs edited =====
--- 1.6/fs/udf/partition.c	Wed Mar 13 00:56:22 2002
+++ edited/fs/udf/partition.c	Tue May 21 01:47:03 2002
@@ -31,6 +31,7 @@
 #include <linux/string.h>
 #include <linux/udf_fs.h>
 #include <linux/slab.h>
+#include <linux/buffer_head.h>
 
 inline uint32_t udf_get_pblock(struct super_block *sb, uint32_t block, uint16_t partition, uint32_t offset)
 {
===== fs/udf/super.c 1.22 vs edited =====
--- 1.22/fs/udf/super.c	Mon May 20 15:39:44 2002
+++ edited/fs/udf/super.c	Tue May 21 01:47:04 2002
@@ -55,6 +55,7 @@
 #include <linux/cdrom.h>
 #include <linux/nls.h>
 #include <linux/smp_lock.h>
+#include <linux/buffer_head.h>
 #include <asm/byteorder.h>
 
 #include <linux/udf_fs.h>
===== fs/udf/symlink.c 1.7 vs edited =====
--- 1.7/fs/udf/symlink.c	Tue Apr 30 00:18:35 2002
+++ edited/fs/udf/symlink.c	Tue May 21 01:47:04 2002
@@ -35,6 +35,7 @@
 #include <linux/slab.h>
 #include <linux/pagemap.h>
 #include <linux/smp_lock.h>
+#include <linux/buffer_head.h>
 #include "udf_i.h"
 
 static void udf_pc_to_char(char *from, int fromlen, char *to)
===== fs/udf/truncate.c 1.5 vs edited =====
--- 1.5/fs/udf/truncate.c	Wed Mar 13 00:56:22 2002
+++ edited/fs/udf/truncate.c	Tue May 21 01:47:04 2002
@@ -28,6 +28,7 @@
 #include <linux/fs.h>
 #include <linux/mm.h>
 #include <linux/udf_fs.h>
+#include <linux/buffer_head.h>
 
 #include "udf_i.h"
 #include "udf_sb.h"
===== fs/udf/udfdecl.h 1.8 vs edited =====
--- 1.8/fs/udf/udfdecl.h	Sat Mar 16 02:16:39 2002
+++ edited/fs/udf/udfdecl.h	Tue May 21 02:40:08 2002
@@ -10,6 +10,7 @@
 #include <linux/types.h>
 #include <linux/udf_fs_i.h>
 #include <linux/udf_fs_sb.h>
+#include <linux/buffer_head.h>
 
 #ifndef LINUX_VERSION_CODE
 #include <linux/version.h>
===== fs/ufs/balloc.c 1.12 vs edited =====
--- 1.12/fs/ufs/balloc.c	Mon May 20 15:39:46 2002
+++ edited/fs/ufs/balloc.c	Tue May 21 02:13:57 2002
@@ -12,6 +12,8 @@
 #include <linux/time.h>
 #include <linux/string.h>
 #include <linux/quotaops.h>
+#include <linux/buffer_head.h>
+#include <linux/sched.h>
 #include <asm/bitops.h>
 #include <asm/byteorder.h>
 
===== fs/ufs/dir.c 1.7 vs edited =====
--- 1.7/fs/ufs/dir.c	Mon May 20 15:39:50 2002
+++ edited/fs/ufs/dir.c	Tue May 21 02:51:07 2002
@@ -17,6 +17,8 @@
 #include <linux/fs.h>
 #include <linux/ufs_fs.h>
 #include <linux/smp_lock.h>
+#include <linux/buffer_head.h>
+#include <linux/sched.h>
 
 #include "swab.h"
 #include "util.h"
===== fs/ufs/ialloc.c 1.7 vs edited =====
--- 1.7/fs/ufs/ialloc.c	Mon May 20 15:39:55 2002
+++ edited/fs/ufs/ialloc.c	Tue May 21 02:14:52 2002
@@ -26,6 +26,8 @@
 #include <linux/stat.h>
 #include <linux/string.h>
 #include <linux/quotaops.h>
+#include <linux/buffer_head.h>
+#include <linux/sched.h>
 #include <asm/bitops.h>
 #include <asm/byteorder.h>
 
===== fs/ufs/inode.c 1.11 vs edited =====
--- 1.11/fs/ufs/inode.c	Mon May 20 15:39:56 2002
+++ edited/fs/ufs/inode.c	Tue May 21 01:47:05 2002
@@ -36,6 +36,7 @@
 #include <linux/string.h>
 #include <linux/mm.h>
 #include <linux/smp_lock.h>
+#include <linux/buffer_head.h>
 
 #include "swab.h"
 #include "util.h"
===== fs/ufs/namei.c 1.13 vs edited =====
--- 1.13/fs/ufs/namei.c	Fri Feb 15 01:56:13 2002
+++ edited/fs/ufs/namei.c	Tue May 21 01:47:05 2002
@@ -28,6 +28,7 @@
 #include <linux/fs.h>
 #include <linux/ufs_fs.h>
 #include <linux/smp_lock.h>
+#include <linux/buffer_head.h>
 
 #undef UFS_NAMEI_DEBUG
 
===== fs/ufs/super.c 1.21 vs edited =====
--- 1.21/fs/ufs/super.c	Mon May 20 15:39:59 2002
+++ edited/fs/ufs/super.c	Tue May 21 01:47:05 2002
@@ -80,6 +80,7 @@
 #include <linux/blkdev.h>
 #include <linux/init.h>
 #include <linux/smp_lock.h>
+#include <linux/buffer_head.h>
 
 #include "swab.h"
 #include "util.h"
===== fs/ufs/truncate.c 1.11 vs edited =====
--- 1.11/fs/ufs/truncate.c	Mon May 20 15:40:01 2002
+++ edited/fs/ufs/truncate.c	Tue May 21 02:51:17 2002
@@ -37,6 +37,8 @@
 #include <linux/stat.h>
 #include <linux/string.h>
 #include <linux/smp_lock.h>
+#include <linux/buffer_head.h>
+#include <linux/sched.h>
 
 #include "swab.h"
 #include "util.h"
===== fs/ufs/util.c 1.8 vs edited =====
--- 1.8/fs/ufs/util.c	Mon May 20 15:40:03 2002
+++ edited/fs/ufs/util.c	Tue May 21 01:47:05 2002
@@ -9,6 +9,7 @@
 #include <linux/string.h>
 #include <linux/slab.h>
 #include <linux/ufs_fs.h>
+#include <linux/buffer_head.h>
 
 #include "swab.h"
 #include "util.h"
===== fs/ufs/util.h 1.5 vs edited =====
--- 1.5/fs/ufs/util.h	Tue Feb  5 16:22:35 2002
+++ edited/fs/ufs/util.h	Tue May 21 02:40:44 2002
@@ -6,6 +6,7 @@
  * Charles University, Faculty of Mathematics and Physics
  */
 
+#include <linux/buffer_head.h>
 #include <linux/fs.h>
 #include "swab.h"
 
===== fs/vfat/namei.c 1.20 vs edited =====
--- 1.20/fs/vfat/namei.c	Tue May  7 06:35:29 2002
+++ edited/fs/vfat/namei.c	Tue May 21 01:47:06 2002
@@ -22,6 +22,7 @@
 #include <linux/ctype.h>
 #include <linux/slab.h>
 #include <linux/smp_lock.h>
+#include <linux/buffer_head.h>
 
 #define DEBUG_LEVEL 0
 #if (DEBUG_LEVEL >= 1)
===== include/linux/amigaffs.h 1.10 vs edited =====
--- 1.10/include/linux/amigaffs.h	Mon May 20 16:22:37 2002
+++ edited/include/linux/amigaffs.h	Tue May 21 02:32:41 2002
@@ -2,7 +2,7 @@
 #define AMIGAFFS_H
 
 #include <linux/types.h>
-
+#include <linux/buffer_head.h>
 #include <asm/byteorder.h>
 
 /* AmigaOS allows file names with up to 30 characters length.
===== include/linux/buffer_head.h 1.9 vs edited =====
--- 1.9/include/linux/buffer_head.h	Sun May 19 13:49:49 2002
+++ edited/include/linux/buffer_head.h	Tue May 21 02:17:05 2002
@@ -4,8 +4,13 @@
  * Everything to do with buffer_heads.
  */
 
-#ifndef BUFFER_FLAGS_H
-#define BUFFER_FLAGS_H
+#ifndef _LINUX_BUFFER_HEAD_H
+#define _LINUX_BUFFER_HEAD_H
+
+#include <linux/types.h>
+#include <linux/fs.h>
+#include <asm/atomic.h>
+
 
 enum bh_state_bits {
 	BH_Uptodate,	/* Contains valid data */
@@ -138,7 +143,6 @@
  */
 
 void FASTCALL(mark_buffer_dirty(struct buffer_head *bh));
-void buffer_init(void);
 void init_buffer(struct buffer_head *, bh_end_io_t *, void *);
 void set_bh_page(struct buffer_head *bh,
 		struct page *page, unsigned long offset);
@@ -297,4 +301,4 @@
 void __buffer_error(char *file, int line);
 #define buffer_error() __buffer_error(__FILE__, __LINE__)
 
-#endif		/* BUFFER_FLAGS_H */
+#endif /* _LINUX_BUFFER_HEAD_H */
===== include/linux/fs.h 1.117 vs edited =====
--- 1.117/include/linux/fs.h	Mon May 20 15:43:51 2002
+++ edited/include/linux/fs.h	Tue May 21 02:16:22 2002
@@ -1324,8 +1324,5 @@
 	return res;
 }
 
-#include <linux/buffer_head.h>
-
 #endif /* __KERNEL__ */
-
 #endif /* _LINUX_FS_H */
===== include/linux/hfs_sysdep.h 1.6 vs edited =====
--- 1.6/include/linux/hfs_sysdep.h	Mon May 20 16:54:06 2002
+++ edited/include/linux/hfs_sysdep.h	Tue May 21 02:33:52 2002
@@ -21,6 +21,7 @@
 #include <linux/types.h>
 #include <linux/fs.h>
 #include <linux/sched.h>
+#include <linux/buffer_head.h>
 
 #include <asm/byteorder.h>
 #include <asm/unaligned.h>
===== include/linux/highmem.h 1.14 vs edited =====
--- 1.14/include/linux/highmem.h	Mon Mar 25 10:51:55 2002
+++ edited/include/linux/highmem.h	Tue May 21 02:16:22 2002
@@ -18,16 +18,6 @@
 extern void create_bounce(unsigned long pfn, int gfp, struct bio **bio_orig);
 extern void check_highmem_ptes(void);
 
-static inline char *bh_kmap(struct buffer_head *bh)
-{
-	return kmap(bh->b_page) + bh_offset(bh);
-}
-
-static inline void bh_kunmap(struct buffer_head *bh)
-{
-	kunmap(bh->b_page);
-}
-
 /*
  * remember to add offset! and never ever reenable interrupts between a
  * bio_kmap_irq and bio_kunmap_irq!!
===== include/linux/jbd.h 1.6 vs edited =====
--- 1.6/include/linux/jbd.h	Sun May 19 13:50:46 2002
+++ edited/include/linux/jbd.h	Tue May 21 02:23:14 2002
@@ -25,6 +25,7 @@
 #define jfs_debug jbd_debug
 #else
 
+#include <linux/buffer_head.h>
 #include <linux/journal-head.h>
 #include <linux/stddef.h>
 #include <asm/semaphore.h>
===== include/linux/msdos_fs.h 1.14 vs edited =====
--- 1.14/include/linux/msdos_fs.h	Thu Apr 25 03:38:44 2002
+++ edited/include/linux/msdos_fs.h	Tue May 21 02:33:31 2002
@@ -4,6 +4,7 @@
 /*
  * The MS-DOS filesystem constants/structures
  */
+#include <linux/buffer_head.h>
 #include <asm/byteorder.h>
 
 #define SECTOR_SIZE	512		/* sector size (bytes) */
===== include/linux/reiserfs_fs.h 1.29 vs edited =====
--- 1.29/include/linux/reiserfs_fs.h	Mon May 20 18:25:46 2002
+++ edited/include/linux/reiserfs_fs.h	Tue May 21 02:38:21 2002
@@ -20,6 +20,7 @@
 #include <asm/unaligned.h>
 #include <linux/bitops.h>
 #include <linux/proc_fs.h>
+#include <linux/buffer_head.h>
 #include <linux/reiserfs_fs_i.h>
 #include <linux/reiserfs_fs_sb.h>
 #endif
===== init/main.c 1.45 vs edited =====
--- 1.45/init/main.c	Tue Apr 30 00:18:31 2002
+++ edited/init/main.c	Tue May 21 01:47:08 2002
@@ -68,6 +68,7 @@
 extern void sbus_init(void);
 extern void sysctl_init(void);
 extern void signals_init(void);
+extern void buffer_init(void);
 
 extern void radix_tree_init(void);
 extern void free_initmem(void);
===== kernel/ksyms.c 1.87 vs edited =====
--- 1.87/kernel/ksyms.c	Mon May 20 15:40:50 2002
+++ edited/kernel/ksyms.c	Tue May 21 01:47:08 2002
@@ -47,6 +47,7 @@
 #include <linux/completion.h>
 #include <linux/seq_file.h>
 #include <linux/binfmts.h>
+#include <linux/buffer_head.h>
 #include <asm/checksum.h>
 
 #if defined(CONFIG_PROC_FS)
===== mm/filemap.c 1.91 vs edited =====
--- 1.91/mm/filemap.c	Sun May 19 13:49:50 2002
+++ edited/mm/filemap.c	Tue May 21 01:47:09 2002
@@ -20,6 +20,16 @@
 #include <linux/iobuf.h>
 #include <linux/hash.h>
 #include <linux/writeback.h>
+/*
+ * This is needed for the following functions:
+ *  - try_to_release_page
+ *  - block_flushpage
+ *  - page_has_buffers
+ *  - generic_osync_inode
+ *
+ * FIXME: remove all knowledge of the buffer layer from this file
+ */
+#include <linux/buffer_head.h>
 
 #include <asm/uaccess.h>
 #include <asm/mman.h>
===== mm/mempool.c 1.6 vs edited =====
--- 1.6/mm/mempool.c	Sat Apr 27 01:55:07 2002
+++ edited/mm/mempool.c	Tue May 21 01:47:09 2002
@@ -12,6 +12,7 @@
 #include <linux/slab.h>
 #include <linux/module.h>
 #include <linux/mempool.h>
+#include <linux/buffer_head.h>		/* for wakeup_bdflush() */
 
 static void add_element(mempool_t *pool, void *element)
 {
===== mm/page-writeback.c 1.16 vs edited =====
--- 1.16/mm/page-writeback.c	Sun May 19 13:49:50 2002
+++ edited/mm/page-writeback.c	Tue May 21 01:47:09 2002
@@ -479,7 +479,10 @@
  *
  * For now, we treat swapper_space specially.  It doesn't use the normal
  * block a_ops.
+ *
+ * FIXME: this should move over to fs/buffer.c - buffer_heads have no business in mm/
  */
+#include <linux/buffer_head.h>
 int __set_page_dirty_buffers(struct page *page)
 {
 	struct address_space * const mapping = page->mapping;
===== mm/page_io.c 1.14 vs edited =====
--- 1.14/mm/page_io.c	Mon May 20 15:49:11 2002
+++ edited/mm/page_io.c	Tue May 21 01:47:09 2002
@@ -15,6 +15,7 @@
 #include <linux/pagemap.h>
 #include <linux/swap.h>
 #include <linux/swapctl.h>
+#include <linux/buffer_head.h>		/* for brw_page() */
 
 #include <asm/pgtable.h>
 
===== mm/swap_state.c 1.24 vs edited =====
--- 1.24/mm/swap_state.c	Sun May 19 13:49:48 2002
+++ edited/mm/swap_state.c	Tue May 21 01:47:09 2002
@@ -14,6 +14,7 @@
 #include <linux/init.h>
 #include <linux/pagemap.h>
 #include <linux/smp_lock.h>
+#include <linux/buffer_head.h>	/* for block_sync_page()/block_flushpage() */
 
 #include <asm/pgtable.h>
 
===== mm/swapfile.c 1.44 vs edited =====
--- 1.44/mm/swapfile.c	Sun May 19 13:49:46 2002
+++ edited/mm/swapfile.c	Tue May 21 01:47:09 2002
@@ -15,7 +15,7 @@
 #include <linux/pagemap.h>
 #include <linux/shm.h>
 #include <linux/blkdev.h>
-#include <linux/compiler.h>
+#include <linux/buffer_head.h>		/* for block_flushpage() */
 
 #include <asm/pgtable.h>
 
===== mm/vmscan.c 1.70 vs edited =====
--- 1.70/mm/vmscan.c	Sun May 19 13:49:50 2002
+++ edited/mm/vmscan.c	Tue May 21 01:47:09 2002
@@ -23,6 +23,7 @@
 #include <linux/file.h>
 #include <linux/writeback.h>
 #include <linux/compiler.h>
+#include <linux/buffer_head.h>		/* for try_to_release_page() */
 
 #include <asm/pgalloc.h>
 #include <asm/tlbflush.h>
