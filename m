Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311025AbSEaAKT>; Thu, 30 May 2002 20:10:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311752AbSEaAKS>; Thu, 30 May 2002 20:10:18 -0400
Received: from harpo.it.uu.se ([130.238.12.34]:54230 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S311025AbSEaAKR>;
	Thu, 30 May 2002 20:10:17 -0400
Date: Fri, 31 May 2002 02:10:17 +0200 (MET DST)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200205310010.CAA16956@harpo.it.uu.se>
To: linux-kernel@vger.kernel.org
Subject: [PATCH][2.5.19] fix broken floppy driver, take 3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's a 3rd version of the patch to fix the floppy driver which
got broken in the 2.5.13-2.5.19 block dev changes.
This version fixes the following remaining problems in 2.5.19:
1. error from generic_unplug_device, due to the queue being NULL
   (new problem since 2.5.18)
   -> fixed by initialising the queue early in floppy_open()
2. data corruption on I/O
   -> fixed (seemingly) by ensuring that the bdev block size equals
      the hardsect/queue block size; the fix is now local to
      floppy.c and does not touch anything else
3. memory corruption on module unload because the floppy device
   (Mochel's drivers/base/ stuff) wasn't unregistered (caused a
   kernel hang just before reboot for me)
   -> fixed by only registering at the end of floppy_init(), and
      unregister in cleanup_module()

/Mikael

diff -ruN linux-2.5.19/drivers/block/floppy.c linux-2.5.19.fix-floppy/drivers/block/floppy.c
--- linux-2.5.19/drivers/block/floppy.c	Thu May 30 17:51:50 2002
+++ linux-2.5.19.fix-floppy/drivers/block/floppy.c	Fri May 31 01:09:52 2002
@@ -3700,6 +3700,10 @@
 		UDRS->fd_ref = 0;
 	}
 	floppy_release_irq_and_dma();
+
+	/* undo ++bd_openers in floppy_open() */
+	--inode->i_bdev->bd_openers;
+
 	return 0;
 }
 
@@ -3792,6 +3796,35 @@
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
+	 * Workarounds:
+	 * 1. bdev->bd_queue is initialised here.
+	 * 2. a) Set bdev block size equal to the hardsect/queue size;
+	 *    this seems to cure the data corruption problem.
+	 *    b) ++bdev->bd_openers to bypass do_open()'s block size
+	 *    change. floppy_release() does a --bdev->bd_openers.
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
+		++bdev->bd_openers;
+	}
+
 	/* Allow ioctls if we have write-permissions even if read-only open.
 	 * Needed so that programs such as fdrawcmd still can work on write
 	 * protected disks */
@@ -4229,8 +4262,6 @@
 {
 	int i,unit,drive;
 
-	register_sys_device(&device_floppy);
-
 	raw_cmd = NULL;
 
 	devfs_handle = devfs_mk_dir (NULL, "floppy", NULL);
@@ -4354,6 +4385,9 @@
 			register_disk(NULL, mk_kdev(MAJOR_NR,TOMINOR(drive)+i*4),
 					1, &floppy_fops, 0);
 	}
+
+	register_sys_device(&device_floppy);
+
 	return have_no_fdc;
 }
 
@@ -4536,6 +4570,7 @@
 {
 	int dummy;
 		
+	unregister_sys_device(&device_floppy);
 	devfs_unregister (devfs_handle);
 	devfs_unregister_blkdev(MAJOR_NR, "fd");
 
