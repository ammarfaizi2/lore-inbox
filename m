Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316136AbSETRB5>; Mon, 20 May 2002 13:01:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316143AbSETRB4>; Mon, 20 May 2002 13:01:56 -0400
Received: from harpo.it.uu.se ([130.238.12.34]:18838 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S316136AbSETRBx>;
	Mon, 20 May 2002 13:01:53 -0400
Date: Mon, 20 May 2002 19:01:52 +0200 (MET DST)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200205201701.TAA04143@harpo.it.uu.se>
To: viro@math.psu.edu
Subject: [RFC] possible fix for broken floppy driver since 2.5.13
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since 2.5.13 I've been unable to use drivers/block/floppy.c.
There were two symptoms: /dev/fd0 was read-only until after
the first read, and writes wrote currupt data to the media.

The patch below against 2.5.16 fixes these problems for me:

- The read-only problem was caused by a getblk() call in
  floppy_revalidate() which had been commented out (2.5.13
  did away with getblk() altogether.) This call is necessary,
  so the patch reintroduces a private getblk() in floppy.c.

- The data corruption on writes was caused by new code in
  fs/block_dev.c:do_open() which changed the block size after
  the call to bdev->bd_op->open().
  Disabling this change to bdev->bd_block_size fixed the
  data corruption. I don't know what this code was trying to do,
  but my system works fine without it.

  I did some tracing of the "struct request*"'s delivered to
  the floppy driver, and with vanilla 2.5.16 the parameters
  (all the '*sectors*' fields) looked very very different from
  what 2.5.12 passed to the driver.

Al: You did the block dev changes for 2.5.13 -- care to comment?

/Mikael

diff -ruN linux-2.5.16/drivers/block/floppy.c linux-2.5.16.fix-floppy/drivers/block/floppy.c
--- linux-2.5.16/drivers/block/floppy.c	Fri May 10 01:50:08 2002
+++ linux-2.5.16.fix-floppy/drivers/block/floppy.c	Mon May 20 17:36:20 2002
@@ -3852,6 +3852,25 @@
 	return 0;
 }
 
+static struct buffer_head *floppy_getblk0(kdev_t dev)
+{
+	struct block_device *bdev;
+	struct buffer_head *bh;
+	int size;
+
+	bdev = bdget(kdev_t_to_nr(dev));
+	if (!bdev) {
+		printk("No block device for %s\n", __bdevname(dev));
+		BUG();
+	}
+	size = bdev->bd_block_size;
+	if (!size)
+		size = 1024;
+	bh = __getblk(bdev, 0, size);
+	atomic_dec(&bdev->bd_count);
+	return bh;
+}
+
 /* revalidate the floppy disk, i.e. trigger format autodetection by reading
  * the bootblock (block 0). "Autodetection" is also needed to check whether
  * there is a disk in the drive at all... Thus we also do it for fixed
@@ -3859,7 +3878,6 @@
 static int floppy_revalidate(kdev_t dev)
 {
 #define NO_GEOM (!current_type[drive] && !TYPE(dev))
-	struct buffer_head * bh;
 	int drive=DRIVE(dev);
 	int cf;
 
@@ -3886,29 +3904,18 @@
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
+			struct buffer_head *bh = floppy_getblk0(dev);
+			if (!bh) {
 				process_fd_request();
 				return -ENXIO;
 			}
-			if (bh && !buffer_uptodate(bh))
+			if (!buffer_uptodate(bh))
 				ll_rw_block(READ, 1, &bh);
 			process_fd_request();
 			wait_on_buffer(bh);
 			brelse(bh);
 			return 0;
-#endif
-			process_fd_request();
-			return 0;
 		}
 		if (cf)
 			poll_drive(0, FD_RAW_NEED_DISK);
diff -ruN linux-2.5.16/fs/block_dev.c linux-2.5.16.fix-floppy/fs/block_dev.c
--- linux-2.5.16/fs/block_dev.c	Mon May  6 13:05:05 2002
+++ linux-2.5.16.fix-floppy/fs/block_dev.c	Mon May 20 17:27:55 2002
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
