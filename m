Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313571AbSGYNXr>; Thu, 25 Jul 2002 09:23:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313477AbSGYNXr>; Thu, 25 Jul 2002 09:23:47 -0400
Received: from harpo.it.uu.se ([130.238.12.34]:64156 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S313638AbSGYNXJ>;
	Thu, 25 Jul 2002 09:23:09 -0400
Date: Thu, 25 Jul 2002 15:26:19 +0200 (MET DST)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200207251326.PAA25534@harpo.it.uu.se>
To: linux-kernel@vger.kernel.org
Subject: [PATCH][2.5.28] broken floppy driver workarounds, take 4
Cc: davej@suse.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's the 4th version of my patch to "fix" the floppy driver which
got broken by the 2.5.13-2.5.19 and 2.5.28 block dev changes.

In 2.5.28 there was a change in fs/block_dev.c which set the
floppy block dev's size to 0, and this causes ENOSPC errors on writes
to the floppy dev. This 4th version of the patch adds a workaround
for this problem.

Partial VFS access _may_ work now. I created an ext2 fs on /dev/fd0
under 2.5.28+this patch, and it fsck'd ok under both 2.5.28 and
2.4.19rc3. However, when I attempted to put lilo on that floppy
the kernel oopsed with a "buffer layer error at buffer.c:403", so
things are still not quite right.

/Mikael

diff -ruN linux-2.5.28/drivers/block/floppy.c linux-2.5.28.fix-floppy/drivers/block/floppy.c
--- linux-2.5.28/drivers/block/floppy.c	Thu Jul 25 01:27:30 2002
+++ linux-2.5.28.fix-floppy/drivers/block/floppy.c	Thu Jul 25 14:33:49 2002
@@ -3699,6 +3699,10 @@
 		UDRS->fd_ref = 0;
 	}
 	floppy_release_irq_and_dma();
+
+	/* undo ++bd_openers in floppy_open() */
+	--inode->i_bdev->bd_openers;
+
 	return 0;
 }
 
@@ -3791,6 +3795,43 @@
 		invalidate_buffers(mk_kdev(FLOPPY_MAJOR,old_dev));
 	}
 
+	/* Problems:
+	 * 1. floppy_open() triggers a call to submit_bio(), but
+	 *    bdev->bd_queue may be NULL since it is not set up until
+	 *    after floppy_open() has returned. Prior to 2.5.18, NULL
+	 *    queues were initialised when needed.
+	 * 2. fs/block_dev.c:do_open() changes bdev's block size
+	 *    after floppy_open() has returned. For some reason, this
+	 *    causes data corruption durings writes.
+	 * 3. fs/block_dev.c:do_open() sets bdev->bd_inode->i_size to 0
+	 *    after floppy_open() has returned. This cases ENOSPC errors
+	 *    on writes.
+	 * Workarounds:
+	 * 1. bdev->bd_queue is initialised here.
+	 * 2. Set bdev block size equal to the hardsect/queue size.
+	 *    This seems to cure the data corruption problem for raw
+	 *    accesses. VFS accesses to mounted floppies still cause
+	 *    data corruption for unknown reasons.
+	 * 3. Set i_size to 1.44M and bd_offset to 0.
+	 * 2&3. ++bdev->bd_openers to bypass do_open()'s changes.
+	 *    floppy_release() does a --bdev->bd_openers.
+	 */
+	{
+		struct block_device *bdev = inode->i_bdev;
+		kdev_t dev = inode->i_rdev;
+		struct blk_dev_struct *p = blk_dev + major(dev);
+
+		if (p->queue)
+			bdev->bd_queue = p->queue(dev);
+		else
+			bdev->bd_queue = &p->request_queue;
+		bdev->bd_block_size = bdev_hardsect_size(bdev);
+		bdev->bd_inode->i_blkbits = blksize_bits(block_size(bdev));
+		bdev->bd_offset = 0;
+		bdev->bd_inode->i_size = 1440 * 1024;
+		++bdev->bd_openers;
+	}
+
 	/* Allow ioctls if we have write-permissions even if read-only open.
 	 * Needed so that programs such as fdrawcmd still can work on write
 	 * protected disks */
@@ -4228,8 +4269,6 @@
 {
 	int i,unit,drive;
 
-	register_sys_device(&device_floppy);
-
 	raw_cmd = NULL;
 
 	devfs_handle = devfs_mk_dir (NULL, "floppy", NULL);
@@ -4356,6 +4395,9 @@
 			register_disk(NULL, mk_kdev(MAJOR_NR,TOMINOR(drive)+i*4),
 					1, &floppy_fops, 0);
 	}
+
+	register_sys_device(&device_floppy);
+
 	return have_no_fdc;
 }
 
@@ -4538,6 +4580,7 @@
 {
 	int dummy;
 		
+	unregister_sys_device(&device_floppy);
 	devfs_unregister (devfs_handle);
 	devfs_unregister_blkdev(MAJOR_NR, "fd");
 
