Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312447AbSEVVTX>; Wed, 22 May 2002 17:19:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312558AbSEVVTW>; Wed, 22 May 2002 17:19:22 -0400
Received: from harpo.it.uu.se ([130.238.12.34]:13755 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S312447AbSEVVTU>;
	Wed, 22 May 2002 17:19:20 -0400
Date: Wed, 22 May 2002 23:19:20 +0200 (MET DST)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200205222119.XAA26658@harpo.it.uu.se>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] possible fix for broken floppy driver, take 2
Cc: viro@math.psu.edu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is an updated patch for the floppy driver which got broken in
2.5.13. "read block 0 on ->revalidate()" is now implemented through
the bio interface, following a suggestion by Christoph Hellwig.

I still cannot explain why block_dev.c's ->bd_block_size change
caused data corruption, but removing that code fixes the floppy
driver and doesn't seem to cause any problems on my test box.

/Mikael

diff -ruN linux-2.5.17/drivers/block/floppy.c linux-2.5.17.fix-floppy-v2/drivers/block/floppy.c
--- linux-2.5.17/drivers/block/floppy.c	Wed May 22 14:50:44 2002
+++ linux-2.5.17.fix-floppy-v2/drivers/block/floppy.c	Wed May 22 21:43:55 2002
@@ -242,6 +242,7 @@
 #include <linux/blk.h>
 #include <linux/blkpg.h>
 #include <linux/cdrom.h> /* for the compatibility eject ioctl */
+#include <linux/completion.h>
 
 #ifndef fd_get_dma_residue
 #define fd_get_dma_residue() get_dma_residue(FLOPPY_DMA)
@@ -3852,6 +3853,74 @@
 	return 0;
 }
 
+/*
+ * This implements "read block 0" for floppy_revalidate().
+ * Needed for format autodetection, checking whether there is
+ * a disk in the drive, and whether that disk is writable.
+ */
+
+static void floppy_rb0_complete(struct bio *bio)
+{
+	complete((struct completion*)bio->bi_private);
+}
+
+static int __floppy_read_block_0(struct block_device *bdev)
+{
+	struct bio bio;
+	struct bio_vec bio_vec;
+	struct completion complete;
+	struct page *page;
+	size_t size;
+
+	page = alloc_page(GFP_NOIO);
+	if (!page) {
+		process_fd_request();
+		return -ENOMEM;
+	}
+
+	size = bdev->bd_block_size;
+	if (!size)
+		size = 1024;
+
+	bio_init(&bio);
+	bio.bi_io_vec = &bio_vec;
+	bio_vec.bv_page = page;
+	bio_vec.bv_len = size;
+	bio_vec.bv_offset = 0;
+	bio.bi_vcnt = 1;
+	bio.bi_idx = 0;
+	bio.bi_size = size;
+	bio.bi_bdev = bdev;
+	bio.bi_sector = 0;
+	init_completion(&complete);
+	bio.bi_private = &complete;
+	bio.bi_end_io = floppy_rb0_complete;
+
+	submit_bio(READ, &bio);
+	run_task_queue(&tq_disk);
+	process_fd_request();
+	wait_for_completion(&complete);
+
+	__free_page(page);
+
+	return 0;
+}
+
+static int floppy_read_block_0(kdev_t dev)
+{
+	struct block_device *bdev;
+	int ret;
+
+	bdev = bdget(kdev_t_to_nr(dev));
+	if (!bdev) {
+		printk("No block device for %s\n", __bdevname(dev));
+		BUG();
+	}
+	ret = __floppy_read_block_0(bdev);
+	atomic_dec(&bdev->bd_count);
+	return ret;
+}
+
 /* revalidate the floppy disk, i.e. trigger format autodetection by reading
  * the bootblock (block 0). "Autodetection" is also needed to check whether
  * there is a disk in the drive at all... Thus we also do it for fixed
@@ -3859,9 +3928,6 @@
 static int floppy_revalidate(kdev_t dev)
 {
 #define NO_GEOM (!current_type[drive] && !TYPE(dev))
-#if 0
-	struct buffer_head * bh;
-#endif
 	int drive=DRIVE(dev);
 	int cf;
 
@@ -3888,29 +3954,8 @@
 		if (cf)
 			UDRS->generation++;
 		if (NO_GEOM){
-#if 0
-	/*
-	 * What the devil is going on here?  We are not guaranteed to do
-	 * any IO and ENXIO case is nothing but ENOMEM in disguise - it
-	 * happens if and only if buffer cache is out of memory.  WTF?
-	 */
 			/* auto-sensing */
-			int size = floppy_blocksizes[minor(dev)];
-			if (!size)
-				size = 1024;
-			if (!(bh = getblk(dev,0,size))){
-				process_fd_request();
-				return -ENXIO;
-			}
-			if (bh && !buffer_uptodate(bh))
-				ll_rw_block(READ, 1, &bh);
-			process_fd_request();
-			wait_on_buffer(bh);
-			brelse(bh);
-			return 0;
-#endif
-			process_fd_request();
-			return 0;
+			return floppy_read_block_0(dev);
 		}
 		if (cf)
 			poll_drive(0, FD_RAW_NEED_DISK);
diff -ruN linux-2.5.17/fs/block_dev.c linux-2.5.17.fix-floppy-v2/fs/block_dev.c
--- linux-2.5.17/fs/block_dev.c	Wed May 22 14:50:44 2002
+++ linux-2.5.17.fix-floppy-v2/fs/block_dev.c	Wed May 22 21:43:52 2002
@@ -606,16 +606,7 @@
 			goto out2;
 	}
 	bdev->bd_inode->i_size = blkdev_size(dev);
-	if (!bdev->bd_openers) {
-		unsigned bsize = bdev_hardsect_size(bdev);
-		while (bsize < PAGE_CACHE_SIZE) {
-			if (bdev->bd_inode->i_size & bsize)
-				break;
-			bsize <<= 1;
-		}
-		bdev->bd_block_size = bsize;
-		bdev->bd_inode->i_blkbits = blksize_bits(bsize);
-	}
+	bdev->bd_inode->i_blkbits = blksize_bits(block_size(bdev));
 	bdev->bd_openers++;
 	unlock_kernel();
 	up(&bdev->bd_sem);
