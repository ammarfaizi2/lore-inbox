Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133061AbRD3JsF>; Mon, 30 Apr 2001 05:48:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132558AbRD3Jr4>; Mon, 30 Apr 2001 05:47:56 -0400
Received: from [195.63.194.11] ([195.63.194.11]:42246 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S133061AbRD3Jrj>; Mon, 30 Apr 2001 05:47:39 -0400
Message-ID: <3AED31DA.6E8529A2@evision-ventures.com>
Date: Mon, 30 Apr 2001 11:35:22 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.17-14 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org, alan@redhat.com
Subject: PATCH 2.4.4 some fixes for the usage of blksize_size and others
Content-Type: multipart/mixed;
 boundary="------------D04A8929B3F41BABF9A79794"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------D04A8929B3F41BABF9A79794
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

The attached patch does the following:

1. Streamlining the usage of the blksize_size[] array by 
introducing a function get_blksize_size(),
similiar in spirit to get_hardsect_size().
It's all inline, so no API will change.

2. Clarification of comments about the underlying arrays in ll_rw_blk.c

3. Removal of functions, which where already serving precisely the same
purpose as get_blksize_size(). Those where:

loop_get_bs(), lvm_get_blksize() and device_bsize() in raid code.

4. Fixing a thinko in actual raw.c device code. The code there had
serious chances to interferre with already mounted filesystems.

5. Fixing the reiserfs to user get_hardsect_size() as the measure for
minimal
block size allowed for the access to a particular device, in the same
way
*ALL* other filesystems already do, instead of looking at the 
blksize_size[], which is only giving the most desirable chunk 
size for access to the FS iff set before, which isn't allways the case.

6. Spotting an abuse inside of the LVM header, introduced by the AS/390
people,
which seem to be the most confused about the difference between
blksize_size 
and hardsect_size anyway.

7. Well, adding some misspellings and bad english grammar to the
kernel's
comments...

I have added my personal tag, where I think someone looking at
the code could need some possible contact for further hand-holding.

Please apply, it's all for the better :-).
--------------D04A8929B3F41BABF9A79794
Content-Type: text/plain; charset=us-ascii;
 name="blksize_size.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="blksize_size.diff"

diff -urN linux/drivers/block/ll_rw_blk.c new/drivers/block/ll_rw_blk.c
--- linux/drivers/block/ll_rw_blk.c	Thu Apr 12 21:15:52 2001
+++ new/drivers/block/ll_rw_blk.c	Mon Apr 30 23:16:03 2001
@@ -85,25 +85,21 @@
 int * blk_size[MAX_BLKDEV];
 
 /*
- * blksize_size contains the size of all block-devices:
+ * blksize_size contains the block size of all block-devices:
  *
  * blksize_size[MAJOR][MINOR]
  *
- * if (!blksize_size[MAJOR]) then 1024 bytes is assumed.
+ * Access to this array should happen through the get_blksize_size() function.
+ * If (!blksize_size[MAJOR]) then 1024 bytes is assumed.
  */
 int * blksize_size[MAX_BLKDEV];
 
 /*
  * hardsect_size contains the size of the hardware sector of a device.
  *
- * hardsect_size[MAJOR][MINOR]
- *
- * if (!hardsect_size[MAJOR])
- *		then 512 bytes is assumed.
- * else
- *		sector_size is hardsect_size[MAJOR][MINOR]
- * This is currently set by some scsi devices and read by the msdos fs driver.
- * Other uses may appear later.
+ * Access to this array should happen through the get_hardsect_size() function.
+ * The default value is assumed to be 512 unless specified differently by the
+ * corresponding low-level driver.
  */
 int * hardsect_size[MAX_BLKDEV];
 
@@ -992,22 +988,14 @@
 
 void ll_rw_block(int rw, int nr, struct buffer_head * bhs[])
 {
-	unsigned int major;
-	int correct_size;
+	ssize_t correct_size;
 	int i;
 
 	if (!nr)
 		return;
 
-	major = MAJOR(bhs[0]->b_dev);
-
 	/* Determine correct block size for this device. */
-	correct_size = BLOCK_SIZE;
-	if (blksize_size[major]) {
-		i = blksize_size[major][MINOR(bhs[0]->b_dev)];
-		if (i)
-			correct_size = i;
-	}
+	correct_size = get_blksize_size(bhs[0]->b_dev);
 
 	/* Verify requested block sizes. */
 	for (i = 0; i < nr; i++) {
diff -urN linux/drivers/block/loop.c new/drivers/block/loop.c
--- linux/drivers/block/loop.c	Thu Apr 12 04:05:14 2001
+++ new/drivers/block/loop.c	Mon Apr 30 23:30:17 2001
@@ -272,22 +272,10 @@
 	return desc.error;
 }
 
-static inline int loop_get_bs(struct loop_device *lo)
-{
-	int bs = 0;
-
-	if (blksize_size[MAJOR(lo->lo_device)])
-		bs = blksize_size[MAJOR(lo->lo_device)][MINOR(lo->lo_device)];
-	if (!bs)
-		bs = BLOCK_SIZE;	
-
-	return bs;
-}
-
 static inline unsigned long loop_get_iv(struct loop_device *lo,
 					unsigned long sector)
 {
-	int bs = loop_get_bs(lo);
+	int bs = get_blksize_size(lo->lo_device);
 	unsigned long offset, IV;
 
 	IV = sector / (bs >> 9) + lo->lo_offset / bs;
@@ -306,9 +294,9 @@
 	pos = ((loff_t) bh->b_rsector << 9) + lo->lo_offset;
 
 	if (rw == WRITE)
-		ret = lo_send(lo, bh, loop_get_bs(lo), pos);
+		ret = lo_send(lo, bh, get_blksize_size(lo->lo_device), pos);
 	else
-		ret = lo_receive(lo, bh, loop_get_bs(lo), pos);
+		ret = lo_receive(lo, bh, get_blksize_size(lo->lo_device), pos);
 
 	return ret;
 }
@@ -650,12 +638,7 @@
 	lo->old_gfp_mask = inode->i_mapping->gfp_mask;
 	inode->i_mapping->gfp_mask = GFP_BUFFER;
 
-	bs = 0;
-	if (blksize_size[MAJOR(inode->i_rdev)])
-		bs = blksize_size[MAJOR(inode->i_rdev)][MINOR(inode->i_rdev)];
-	if (!bs)
-		bs = BLOCK_SIZE;
-
+	bs = get_blksize_size(inode->i_rdev);
 	set_blocksize(dev, bs);
 
 	lo->lo_bh = lo->lo_bhtail = NULL;
diff -urN linux/drivers/char/raw.c new/drivers/char/raw.c
--- linux/drivers/char/raw.c	Fri Apr 27 23:23:25 2001
+++ new/drivers/char/raw.c	Mon Apr 30 22:57:20 2001
@@ -124,22 +124,25 @@
 		return err;
 	}
 
-	
-	/* 
-	 * Don't interfere with mounted devices: we cannot safely set
-	 * the blocksize on a device which is already mounted.  
+	/*
+	 * 29.04.2001 Martin Dalecki:
+	 *
+	 * The original comment here was saying:
+	 *
+	 * "Don't interfere with mounted devices: we cannot safely set the
+	 * blocksize on a device which is already mounted."
+	 *
+	 * However the code below was setting happily the blocksize
+	 * disregarding the previous check. I have fixed this, however I'm
+	 * quite sure, that the statement above isn't right and we should be
+	 * able to remove the first arm of the branch below entierly.
 	 */
-	
-	sector_size = 512;
 	if (get_super(rdev) != NULL) {
-		if (blksize_size[MAJOR(rdev)])
-			sector_size = blksize_size[MAJOR(rdev)][MINOR(rdev)];
+		sector_size = get_blksize_size(rdev);
 	} else {
-		if (hardsect_size[MAJOR(rdev)])
-			sector_size = hardsect_size[MAJOR(rdev)][MINOR(rdev)];
+		sector_size = get_hardsect_size(rdev);
+		set_blocksize(rdev, sector_size);
 	}
-
-	set_blocksize(rdev, sector_size);
 	raw_devices[minor].sector_size = sector_size;
 
 	for (sector_bits = 0; !(sector_size & 1); )
@@ -148,7 +151,7 @@
 
  out:
 	up(&raw_devices[minor].mutex);
-	
+
 	return err;
 }
 
diff -urN linux/drivers/md/lvm-snap.c new/drivers/md/lvm-snap.c
--- linux/drivers/md/lvm-snap.c	Fri Apr 27 23:23:25 2001
+++ new/drivers/md/lvm-snap.c	Mon Apr 30 23:27:40 2001
@@ -172,20 +172,6 @@
 		blocks[i] = start++;
 }
 
-inline int lvm_get_blksize(kdev_t dev)
-{
-	int correct_size = BLOCK_SIZE, i, major;
-
-	major = MAJOR(dev);
-	if (blksize_size[major])
-	{
-		i = blksize_size[major][MINOR(dev)];
-		if (i)
-			correct_size = i;
-	}
-	return correct_size;
-}
-
 #ifdef DEBUG_SNAPSHOT
 static inline void invalidate_snap_cache(unsigned long start, unsigned long nr,
 					 kdev_t dev)
@@ -218,7 +204,7 @@
 
 	if (is == 0) return;
 	is--;
-        blksize_snap = lvm_get_blksize(lv_snap->lv_block_exception[is].rdev_new);
+        blksize_snap = get_blksize_size(lv_snap->lv_block_exception[is].rdev_new);
         is -= is % (blksize_snap / sizeof(lv_COW_table_disk_t));
 
 	memset(lv_COW_table, 0, blksize_snap);
@@ -262,7 +248,7 @@
 	snap_phys_dev = lv_snap->lv_block_exception[idx].rdev_new;
 	snap_pe_start = lv_snap->lv_block_exception[idx - (idx % COW_entries_per_pe)].rsector_new - lv_snap->lv_chunk_size;
 
-	blksize_snap = lvm_get_blksize(snap_phys_dev);
+	blksize_snap = get_blksize_size(snap_phys_dev);
 
         COW_entries_per_block = blksize_snap / sizeof(lv_COW_table_disk_t);
         idx_COW_table = idx % COW_entries_per_pe % COW_entries_per_block;
@@ -307,7 +293,7 @@
 			idx++;
 			snap_phys_dev = lv_snap->lv_block_exception[idx].rdev_new;
 			snap_pe_start = lv_snap->lv_block_exception[idx - (idx % COW_entries_per_pe)].rsector_new - lv_snap->lv_chunk_size;
-			blksize_snap = lvm_get_blksize(snap_phys_dev);
+			blksize_snap = get_blksize_size(snap_phys_dev);
 			iobuf->blocks[0] = snap_pe_start >> (blksize_snap >> 10);
 		} else iobuf->blocks[0]++;
 
@@ -384,8 +370,8 @@
 
 	iobuf = lv_snap->lv_iobuf;
 
-	blksize_org = lvm_get_blksize(org_phys_dev);
-	blksize_snap = lvm_get_blksize(snap_phys_dev);
+	blksize_org = get_blksize_size(org_phys_dev);
+	blksize_snap = get_blksize_size(snap_phys_dev);
 	max_blksize = max(blksize_org, blksize_snap);
 	min_blksize = min(blksize_org, blksize_snap);
 	max_sectors = KIO_MAX_SECTORS * (min_blksize>>9);
diff -urN linux/drivers/md/lvm-snap.h new/drivers/md/lvm-snap.h
--- linux/drivers/md/lvm-snap.h	Mon Jan 29 01:11:20 2001
+++ new/drivers/md/lvm-snap.h	Mon Apr 30 23:26:28 2001
@@ -32,7 +32,6 @@
 #define LVM_SNAP_H
 
 /* external snapshot calls */
-extern inline int lvm_get_blksize(kdev_t);
 extern int lvm_snapshot_alloc(lv_t *);
 extern void lvm_snapshot_fill_COW_page(vg_t *, lv_t *);
 extern int lvm_snapshot_COW(kdev_t, ulong, ulong, ulong, lv_t *);
diff -urN linux/drivers/md/lvm.c new/drivers/md/lvm.c
--- linux/drivers/md/lvm.c	Sat Apr 21 19:37:16 2001
+++ new/drivers/md/lvm.c	Mon Apr 30 23:31:56 2001
@@ -1077,7 +1077,7 @@
 	memset(&bh,0,sizeof bh);
 	bh.b_rsector = block;
 	bh.b_dev = bh.b_rdev = inode->i_dev;
-	bh.b_size = lvm_get_blksize(bh.b_dev);
+	bh.b_size = get_blksize_size(bh.b_dev);
 	if ((err=lvm_map(&bh, READ)) < 0)  {
 		printk("lvm map failed: %d\n", err);
 		return -EINVAL;
diff -urN linux/drivers/md/raid5.c new/drivers/md/raid5.c
--- linux/drivers/md/raid5.c	Fri Feb  9 20:30:23 2001
+++ new/drivers/md/raid5.c	Mon Apr 30 23:22:58 2001
@@ -1136,23 +1136,6 @@
 	return 0;
 }
 
-/*
- * Determine correct block size for this device.
- */
-unsigned int device_bsize (kdev_t dev)
-{
-	unsigned int i, correct_size;
-
-	correct_size = BLOCK_SIZE;
-	if (blksize_size[MAJOR(dev)]) {
-		i = blksize_size[MAJOR(dev)][MINOR(dev)];
-		if (i)
-			correct_size = i;
-	}
-
-	return correct_size;
-}
-
 static int raid5_sync_request (mddev_t *mddev, unsigned long block_nr)
 {
 	raid5_conf_t *conf = (raid5_conf_t *) mddev->private;
diff -urN linux/drivers/s390/char/tape34xx.c new/drivers/s390/char/tape34xx.c
--- linux/drivers/s390/char/tape34xx.c	Thu Apr 12 04:02:28 2001
+++ new/drivers/s390/char/tape34xx.c	Mon Apr 30 22:36:57 2001
@@ -1369,7 +1369,8 @@
 	ccw_req_t *cqr;
 	ccw1_t *ccw;
 	__u8 *data;
-	int s2b = blksize_size[tapeblock_major][tape->blk_minor]/hardsect_size[tapeblock_major][tape->blk_minor];
+	int s2b = blksize_size[tapeblock_major][tape->blk_minor]
+		/ get_hardsect_size(MKDEV(tapeblock_major,tape->blk_minor));
 	int realcount;
 	int size,bhct = 0;
 	struct buffer_head* bh;
@@ -1388,7 +1389,7 @@
 	}
 	data[0] = 0x01;
 	data[1] = data[2] = data[3] = 0x00;
-	realcount=req->sector/s2b;
+	realcount=req->sector / s2b;
 	if (((tape34xx_disc_data_t *) tape->discdata)->modeset_byte & 0x08)	// IDRC on
 
 		data[1] = data[1] | 0x80;
diff -urN linux/fs/block_dev.c new/fs/block_dev.c
--- linux/fs/block_dev.c	Fri Feb  9 20:29:44 2001
+++ new/fs/block_dev.c	Mon Apr 30 23:03:27 2001
@@ -14,12 +14,10 @@
 #include <linux/major.h>
 #include <linux/devfs_fs_kernel.h>
 #include <linux/smp_lock.h>
+#include <linux/blkdev.h>
 
 #include <asm/uaccess.h>
 
-extern int *blk_size[];
-extern int *blksize_size[];
-
 #define MAX_BUF_PER_PAGE (PAGE_SIZE / 512)
 #define NBUF 64
 
@@ -42,10 +40,8 @@
 		return -EPERM;
 
 	written = write_error = buffercount = 0;
-	blocksize = BLOCK_SIZE;
-	if (blksize_size[MAJOR(dev)] && blksize_size[MAJOR(dev)][MINOR(dev)])
-		blocksize = blksize_size[MAJOR(dev)][MINOR(dev)];
 
+	blocksize = get_blksize_size(dev);
 	i = blocksize;
 	blocksize_bits = 0;
 	while(i != 1) {
@@ -182,9 +178,7 @@
 	ssize_t read;
 
 	dev = inode->i_rdev;
-	blocksize = BLOCK_SIZE;
-	if (blksize_size[MAJOR(dev)] && blksize_size[MAJOR(dev)][MINOR(dev)])
-		blocksize = blksize_size[MAJOR(dev)][MINOR(dev)];
+	blocksize = get_blksize_size(dev);
 	i = blocksize;
 	blocksize_bits = 0;
 	while (i != 1) {
diff -urN linux/fs/buffer.c new/fs/buffer.c
--- linux/fs/buffer.c	Fri Apr 27 23:23:25 2001
+++ new/fs/buffer.c	Mon Apr 30 23:47:21 2001
@@ -687,6 +687,13 @@
 	if (!blksize_size[MAJOR(dev)])
 		return;
 
+	/* 29/04/2001 Marcin Dalecki <dalecki@evision.ag>:
+	 *
+	 * The assumption that the size may not by lower then 512 is
+	 * conflicting with the assumption in partitions/check.c that the block
+	 * size may assume 256 bytes.
+	 */
+
 	/* Size must be a power of two, and between 512 and PAGE_SIZE */
 	if (size > PAGE_SIZE || size < 512 || (size & (size-1)))
 		panic("Invalid blocksize passed to set_blocksize");
diff -urN linux/fs/partitions/check.c new/fs/partitions/check.c
--- linux/fs/partitions/check.c	Sat Feb 17 01:02:37 2001
+++ new/fs/partitions/check.c	Mon Apr 30 23:37:50 2001
@@ -34,7 +34,6 @@
 #include "ultrix.h"
 
 extern void device_init(void);
-extern int *blk_size[];
 extern void rd_load(void);
 extern void initrd_load(void);
 
@@ -200,20 +199,13 @@
 	int ret = 1024;
 
 	/*
-	 * See whether the low-level driver has given us a minumum blocksize.
-	 * If so, check to see whether it is larger than the default of 1024.
-	 */
-	if (!blksize_size[MAJOR(dev)])
-		return ret;
-
-	/*
 	 * Check for certain special power of two sizes that we allow.
 	 * With anything larger than 1024, we must force the blocksize up to
 	 * the natural blocksize for the device so that we don't have to try
 	 * and read partial sectors.  Anything smaller should be just fine.
 	 */
 
-	switch (blksize_size[MAJOR(dev)][MINOR(dev)]) {
+	switch (get_blksize_size(dev)) {
 		case 2048:
 			ret = 2048;
 			break;
diff -urN linux/fs/partitions/ibm.c new/fs/partitions/ibm.c
--- linux/fs/partitions/ibm.c	Sat Apr 14 05:26:07 2001
+++ new/fs/partitions/ibm.c	Mon Apr 30 23:45:16 2001
@@ -125,12 +125,10 @@
 		return 0;
 	}
 	genhd_dasd_fillgeo(dev,&geo);
-	blocksize = hardsect_size[MAJOR(dev)][MINOR(dev)];
-	if ( blocksize <= 0 ) {
-		return 0;
-	}
 
-	set_blocksize(dev, blocksize);  /* OUCH !! */
+	blocksize = get_hardsect_size(dev);
+	set_blocksize(dev, blocksize);
+
 	if ( ( bh = bread( dev, geo.start, blocksize) ) != NULL ) {
 		strncpy ( type,bh -> b_data + 0, 4);
 		strncpy ( name,bh -> b_data + 4, 6);
diff -urN linux/fs/reiserfs/super.c new/fs/reiserfs/super.c
--- linux/fs/reiserfs/super.c	Fri Apr 27 23:18:08 2001
+++ new/fs/reiserfs/super.c	Mon Apr 30 23:53:17 2001
@@ -1,7 +1,8 @@
 /*
  * Copyright 2000 by Hans Reiser, licensing governed by reiserfs/README
  *
- * Trivial changes by Alan Cox to add the LFS fixes
+ * Trivial changes by Alan Cox to add the LFS fixes.
+ * Trivial change by Marcin Dalecki.
  *
  * Trivial Changes:
  * Rights granted to Hans Reiser to redistribute under other terms providing
@@ -21,6 +22,7 @@
 #include <linux/smp_lock.h>
 #include <linux/locks.h>
 #include <linux/init.h>
+#include <linux/blkdev.h>
 
 #else
 
@@ -681,7 +683,6 @@
     struct inode *root_inode;
     kdev_t dev = s->s_dev;
     int j;
-    extern int *blksize_size[];
     struct reiserfs_transaction_handle th ;
     int old_format = 0;
     unsigned long blocks;
@@ -696,17 +697,22 @@
     }
 
     if (blocks) {
-  	printk("reserfs: resize option for remount only\n");
+	printk("reserfs: resize option for remount only\n");
 	return NULL;
-    }	
+    }
 
-    if (blksize_size[MAJOR(dev)] && blksize_size[MAJOR(dev)][MINOR(dev)] != 0) {
-	/* as blocksize is set for partition we use it */
-	size = blksize_size[MAJOR(dev)][MINOR(dev)];
-    } else {
+    /*
+     * 29/04/2001 Marcin Dalecki <dalecki@evision.ag>:
+     *
+     * See what the current blocksize for the device is, and use that as the
+     * blocksize.  Otherwise (or if the blocksize is smaller than the default)
+     * use the default.  This is important for devices that have a hardware
+     * sectorsize that is larger than the default.
+     */
+    size = get_hardsect_size(dev);
+    if (size < BLOCK_SIZE)
 	size = BLOCK_SIZE;
-	set_blocksize (s->s_dev, BLOCK_SIZE);
-    }
+    set_blocksize (s->s_dev, BLOCK_SIZE);
 
     /* read block (64-th 1k block), which can contain reiserfs super block */
     if (read_super_block (s, size)) {
diff -urN linux/include/linux/blkdev.h new/include/linux/blkdev.h
--- linux/include/linux/blkdev.h	Sat Apr 28 00:48:49 2001
+++ new/include/linux/blkdev.h	Mon Apr 30 22:43:51 2001
@@ -198,11 +198,18 @@
 
 static inline int get_hardsect_size(kdev_t dev)
 {
-	extern int *hardsect_size[];
 	if (hardsect_size[MAJOR(dev)] != NULL)
 		return hardsect_size[MAJOR(dev)][MINOR(dev)];
 	else
 		return 512;
+}
+
+static inline int get_blksize_size(kdev_t dev)
+{
+	if (blksize_size[MAJOR(dev)] != NULL)
+		return blksize_size[MAJOR(dev)][MINOR(dev)];
+	else
+		return 1024;
 }
 
 #define blk_finished_io(nsects)				\
diff -urN linux/include/linux/lvm.h new/include/linux/lvm.h
--- linux/include/linux/lvm.h	Sat Feb 17 01:06:17 2001
+++ new/include/linux/lvm.h	Mon Apr 30 23:47:08 2001
@@ -113,6 +113,20 @@
 #error Bad include/linux/major.h - LVM MAJOR undefined
 #endif
 
+/* 29/04/2001 Marcin Dalecki <dalecki@evision.ag>:
+ *
+ * The following games on the definition of the BLOCK_SIZE are asking for
+ * trouble for two reasons:
+ *
+ * 1. This is conflicting with the unconditional definition in fs.h
+ *
+ * 2. There are many places in the kernel, where this values is implicitly
+ * assumed to be equal to 1024 bytes.
+ *
+ * Anybody responsible for AS/390 this should resolve this as soon as possible.
+ * Remove this CRAP! Contact me plase if you need some support.
+ */
+
 #ifdef	BLOCK_SIZE
 #undef	BLOCK_SIZE
 #endif

--------------D04A8929B3F41BABF9A79794--

