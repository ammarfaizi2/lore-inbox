Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264983AbRGAEx4>; Sun, 1 Jul 2001 00:53:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264976AbRGAExp>; Sun, 1 Jul 2001 00:53:45 -0400
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:1735 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S264972AbRGAEx1>; Sun, 1 Jul 2001 00:53:27 -0400
Date: Sun, 1 Jul 2001 00:53:25 -0400 (EDT)
From: Ben LaHaise <bcrl@redhat.com>
X-X-Sender: <bcrl@toomuch.toronto.redhat.com>
To: <linux-fsdevel@vger.kernel.org>
cc: <linux-kernel@vger.kernel.org>
Subject: [RFC][PATCH] first cut 64 bit block support
Message-ID: <Pine.LNX.4.33.0107010040540.3950-100000@toomuch.toronto.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey folks,

Below is the first cut at making the block size limit configurable to 64
bits on x86, as well as always 64 bits on 64 bit machines.  The audit
isn't complete yet, but a good chunk of it is done.

Filesystem           1k-blocks      Used Available Use% Mounted on
/dev/md1             7508125768        20 7476280496   1% /mnt/3

This is a 7TB ext2 filesystem on 4KB blocks.  The 7TB /dev/md1 consists of
7x 1TB sparse files on loop devices raid0'd together.  The current patch
does not have the fixes in the SCSI layer or IDE driver yet; expect the
SCSI fixes in the next version, although I'll need a tester.  The
following should be 64 bit clean now: nbd, loop, raid0, raid1, raid5.

Ugly bits: I had to add libgcc.a to satisfy the need for 64 bit division.
Yeah, it sucks, but RAID needs some more massaging before I can remove the
64 bit division completely.  This will be fixed.

Copies of this and later versions of the patch are available at
http://people.redhat.com/bcrl/lb/ and http://www.kvack.org/~blah/lb/ .
Please forward any bug fixes or comments to me.  Cheers,

		-ben

::::v2.4.6-pre8-largeblock4.diff::::
diff -ur /md0/kernels/2.4/v2.4.6-pre8/arch/i386/Makefile lb-2.4.6-pre8/arch/i386/Makefile
--- /md0/kernels/2.4/v2.4.6-pre8/arch/i386/Makefile	Thu May  3 11:22:07 2001
+++ lb-2.4.6-pre8/arch/i386/Makefile	Sun Jul  1 00:35:25 2001
@@ -92,6 +92,7 @@

 CORE_FILES := arch/i386/kernel/kernel.o arch/i386/mm/mm.o $(CORE_FILES)
 LIBS := $(TOPDIR)/arch/i386/lib/lib.a $(LIBS) $(TOPDIR)/arch/i386/lib/lib.a
+LIBS += $(shell gcc -print-libgcc-file-name)

 ifdef CONFIG_MATH_EMULATION
 SUBDIRS += arch/i386/math-emu
diff -ur /md0/kernels/2.4/v2.4.6-pre8/arch/i386/config.in lb-2.4.6-pre8/arch/i386/config.in
--- /md0/kernels/2.4/v2.4.6-pre8/arch/i386/config.in	Sat Jun 30 14:04:26 2001
+++ lb-2.4.6-pre8/arch/i386/config.in	Sat Jun 30 15:37:37 2001
@@ -185,6 +185,7 @@
 mainmenu_option next_comment
 comment 'General setup'

+bool '64 bit block device support' CONFIG_BLKOFF_LONGLONG
 bool 'Networking support' CONFIG_NET
 bool 'SGI Visual Workstation support' CONFIG_VISWS
 if [ "$CONFIG_VISWS" = "y" ]; then
diff -ur /md0/kernels/2.4/v2.4.6-pre8/drivers/block/floppy.c lb-2.4.6-pre8/drivers/block/floppy.c
--- /md0/kernels/2.4/v2.4.6-pre8/drivers/block/floppy.c	Mon Feb 26 10:20:05 2001
+++ lb-2.4.6-pre8/drivers/block/floppy.c	Sat Jun 30 16:23:07 2001
@@ -468,7 +468,7 @@
  */
 static struct floppy_struct user_params[N_DRIVE];

-static int floppy_sizes[256];
+static blkoff_t floppy_sizes[256];
 static int floppy_blocksizes[256];

 /*
@@ -2640,8 +2640,8 @@

 	max_sector = _floppy->sect * _floppy->head;

-	TRACK = CURRENT->sector / max_sector;
-	sector_t = CURRENT->sector % max_sector;
+	TRACK = (int)(CURRENT->sector) / max_sector;
+	sector_t = (int)(CURRENT->sector) % max_sector;
 	if (_floppy->track && TRACK >= _floppy->track) {
 		if (CURRENT->current_nr_sectors & 1) {
 			current_count_sectors = 1;
@@ -2982,7 +2982,7 @@

 	if (usage_count == 0) {
 		printk("warning: usage count=0, CURRENT=%p exiting\n", CURRENT);
-		printk("sect=%ld cmd=%d\n", CURRENT->sector, CURRENT->cmd);
+		printk("sect=%" BLKOFF_FMT " cmd=%d\n", CURRENT->sector, CURRENT->cmd);
 		return;
 	}
 	if (fdc_busy){
diff -ur /md0/kernels/2.4/v2.4.6-pre8/drivers/block/ll_rw_blk.c lb-2.4.6-pre8/drivers/block/ll_rw_blk.c
--- /md0/kernels/2.4/v2.4.6-pre8/drivers/block/ll_rw_blk.c	Sat Jun 30 14:04:27 2001
+++ lb-2.4.6-pre8/drivers/block/ll_rw_blk.c	Sat Jun 30 15:38:40 2001
@@ -82,7 +82,7 @@
  *
  * if (!blk_size[MAJOR]) then no minor size checking is done.
  */
-int * blk_size[MAX_BLKDEV];
+blkoff_t *blk_size[MAX_BLKDEV];

 /*
  * blksize_size contains the size of all block-devices:
@@ -667,7 +667,8 @@
 static int __make_request(request_queue_t * q, int rw,
 				  struct buffer_head * bh)
 {
-	unsigned int sector, count;
+	blkoff_t sector;
+	unsigned count;
 	int max_segments = MAX_SEGMENTS;
 	struct request * req, *freereq = NULL;
 	int rw_ahead, max_sectors, el_ret;
@@ -859,7 +860,7 @@
 void generic_make_request (int rw, struct buffer_head * bh)
 {
 	int major = MAJOR(bh->b_rdev);
-	int minorsize = 0;
+	blkoff_t minorsize = 0;
 	request_queue_t *q;

 	if (!bh->b_end_io)
@@ -869,8 +870,8 @@
 	if (blk_size[major])
 		minorsize = blk_size[major][MINOR(bh->b_rdev)];
 	if (minorsize) {
-		unsigned long maxsector = (minorsize << 1) + 1;
-		unsigned long sector = bh->b_rsector;
+		blkoff_t maxsector = (minorsize << 1) + 1;
+		blkoff_t sector = bh->b_rsector;
 		unsigned int count = bh->b_size >> 9;

 		if (maxsector < count || maxsector - count < sector) {
@@ -881,8 +882,9 @@
 			   without checking the size of the device, e.g.,
 			   when mounting a device. */
 			printk(KERN_INFO
-			       "attempt to access beyond end of device\n");
-			printk(KERN_INFO "%s: rw=%d, want=%ld, limit=%d\n",
+			       "attempt to access beyond end of device\n"
+			       KERN_INFO "%s: rw=%d, want=%" BLKOFF_FMT
+			       ", limit=%" BLKOFF_FMT "\n",
 			       kdevname(bh->b_rdev), rw,
 			       (sector + count)>>1, minorsize);

@@ -905,7 +907,7 @@
 		if (!q) {
 			printk(KERN_ERR
 			       "generic_make_request: Trying to access "
-			       "nonexistent block-device %s (%ld)\n",
+			       "nonexistent block-device %s (%" BLKOFF_FMT ")\n",
 			       kdevname(bh->b_rdev), bh->b_rsector);
 			buffer_IO_error(bh);
 			break;
@@ -1114,7 +1116,7 @@

 	req->errors = 0;
 	if (!uptodate)
-		printk("end_request: I/O error, dev %s (%s), sector %lu\n",
+		printk("end_request: I/O error, dev %s (%s), sector %" BLKOFF_FMT "\n",
 			kdevname(req->rq_dev), name, req->sector);

 	if ((bh = req->bh) != NULL) {
diff -ur /md0/kernels/2.4/v2.4.6-pre8/drivers/block/loop.c lb-2.4.6-pre8/drivers/block/loop.c
--- /md0/kernels/2.4/v2.4.6-pre8/drivers/block/loop.c	Sat Jun 30 14:04:27 2001
+++ lb-2.4.6-pre8/drivers/block/loop.c	Sat Jun 30 23:41:37 2001
@@ -76,7 +76,7 @@

 static int max_loop = 8;
 static struct loop_device *loop_dev;
-static int *loop_sizes;
+static blkoff_t *loop_sizes;
 static int *loop_blksizes;
 static devfs_handle_t devfs_handle;      /*  For the directory */

@@ -84,7 +84,7 @@
  * Transfer functions
  */
 static int transfer_none(struct loop_device *lo, int cmd, char *raw_buf,
-			 char *loop_buf, int size, int real_block)
+			 char *loop_buf, int size, blkoff_t real_block)
 {
 	if (cmd == READ)
 		memcpy(loop_buf, raw_buf, size);
@@ -95,7 +95,7 @@
 }

 static int transfer_xor(struct loop_device *lo, int cmd, char *raw_buf,
-			char *loop_buf, int size, int real_block)
+			char *loop_buf, int size, blkoff_t real_block)
 {
 	char	*in, *out, *key;
 	int	i, keysize;
@@ -147,7 +147,7 @@

 #define MAX_DISK_SIZE 1024*1024*1024

-static int compute_loop_size(struct loop_device *lo, struct dentry * lo_dentry, kdev_t lodev)
+static blkoff_t compute_loop_size(struct loop_device *lo, struct dentry * lo_dentry, kdev_t lodev)
 {
 	if (S_ISREG(lo_dentry->d_inode->i_mode))
 		return (lo_dentry->d_inode->i_size - lo->lo_offset) >> BLOCK_SIZE_BITS;
@@ -172,7 +172,7 @@
 	struct address_space_operations *aops = mapping->a_ops;
 	struct page *page;
 	char *kaddr, *data;
-	unsigned long index;
+	blkoff_t index;
 	unsigned size, offset;
 	int len;

@@ -181,7 +181,7 @@
 	len = bh->b_size;
 	data = bh->b_data;
 	while (len > 0) {
-		int IV = index * (PAGE_CACHE_SIZE/bsize) + offset/bsize;
+		blkoff_t IV = index * (PAGE_CACHE_SIZE/bsize) + offset/bsize;
 		size = PAGE_CACHE_SIZE - offset;
 		if (size > len)
 			size = len;
@@ -209,7 +209,7 @@
 	return 0;

 write_fail:
-	printk(KERN_ERR "loop: transfer error block %ld\n", index);
+	printk(KERN_ERR "loop: transfer error block %"BLKOFF_FMT"\n", index);
 	ClearPageUptodate(page);
 	kunmap(page);
 unlock:
@@ -232,7 +232,7 @@
 	unsigned long count = desc->count;
 	struct lo_read_data *p = (struct lo_read_data*)desc->buf;
 	struct loop_device *lo = p->lo;
-	int IV = page->index * (PAGE_CACHE_SIZE/p->bsize) + offset/p->bsize;
+	blkoff_t IV = (blkoff_t)page->index * (PAGE_CACHE_SIZE/p->bsize) + offset/p->bsize;

 	if (size > count)
 		size = count;
@@ -283,15 +283,27 @@

 	return bs;
 }
+static inline int loop_get_shift(struct loop_device *lo)
+{
+	int size = loop_get_bs(lo);
+	int i = 0;
+
+	while (size) {
+		i++;
+		size >>= 1;
+	}
+	return i;
+}

 static inline unsigned long loop_get_iv(struct loop_device *lo,
-					unsigned long sector)
+					blkoff_t sector)
 {
 	int bs = loop_get_bs(lo);
+	int shift = loop_get_shift(lo);
 	unsigned long offset, IV;

-	IV = sector / (bs >> 9) + lo->lo_offset / bs;
-	offset = ((sector % (bs >> 9)) << 9) + lo->lo_offset % bs;
+	IV = (sector >> (bs - 9)) + (lo->lo_offset >> shift);
+	offset = (sector & (bs - 1) & ~511) + (lo->lo_offset & (bs - 1));
 	if (offset >= bs)
 		IV++;

@@ -983,7 +995,7 @@
 	if (!loop_dev)
 		return -ENOMEM;

-	loop_sizes = kmalloc(max_loop * sizeof(int), GFP_KERNEL);
+	loop_sizes = kmalloc(max_loop * sizeof(blkoff_t), GFP_KERNEL);
 	if (!loop_sizes)
 		goto out_sizes;

@@ -1003,7 +1015,7 @@
 		spin_lock_init(&lo->lo_lock);
 	}

-	memset(loop_sizes, 0, max_loop * sizeof(int));
+	memset(loop_sizes, 0, max_loop * sizeof(blkoff_t));
 	memset(loop_blksizes, 0, max_loop * sizeof(int));
 	blk_size[MAJOR_NR] = loop_sizes;
 	blksize_size[MAJOR_NR] = loop_blksizes;
diff -ur /md0/kernels/2.4/v2.4.6-pre8/drivers/block/nbd.c lb-2.4.6-pre8/drivers/block/nbd.c
--- /md0/kernels/2.4/v2.4.6-pre8/drivers/block/nbd.c	Sat Jun 30 14:04:27 2001
+++ lb-2.4.6-pre8/drivers/block/nbd.c	Sat Jun 30 14:22:13 2001
@@ -56,7 +56,7 @@

 static int nbd_blksizes[MAX_NBD];
 static int nbd_blksize_bits[MAX_NBD];
-static int nbd_sizes[MAX_NBD];
+static blkoff_t nbd_sizes[MAX_NBD];
 static u64 nbd_bytesizes[MAX_NBD];

 static struct nbd_device nbd_dev[MAX_NBD];
diff -ur /md0/kernels/2.4/v2.4.6-pre8/drivers/ide/ide-cd.c lb-2.4.6-pre8/drivers/ide/ide-cd.c
--- /md0/kernels/2.4/v2.4.6-pre8/drivers/ide/ide-cd.c	Fri May 25 22:48:09 2001
+++ lb-2.4.6-pre8/drivers/ide/ide-cd.c	Sat Jun 30 15:40:14 2001
@@ -1060,7 +1060,7 @@
 	   paranoid and check. */
 	if (rq->current_nr_sectors < (rq->bh->b_size >> SECTOR_BITS) &&
 	    (rq->sector % SECTORS_PER_FRAME) != 0) {
-		printk ("%s: cdrom_read_from_buffer: buffer botch (%ld)\n",
+		printk ("%s: cdrom_read_from_buffer: buffer botch (%" BLKOFF_FMT ")\n",
 			drive->name, rq->sector);
 		cdrom_end_request (0, drive);
 		return -1;
diff -ur /md0/kernels/2.4/v2.4.6-pre8/drivers/ide/ide-probe.c lb-2.4.6-pre8/drivers/ide/ide-probe.c
--- /md0/kernels/2.4/v2.4.6-pre8/drivers/ide/ide-probe.c	Thu Apr  5 11:53:40 2001
+++ lb-2.4.6-pre8/drivers/ide/ide-probe.c	Sat Jun 30 20:42:28 2001
@@ -759,7 +759,7 @@
 	}
 	minors    = units * (1<<PARTN_BITS);
 	gd        = kmalloc (sizeof(struct gendisk), GFP_KERNEL);
-	gd->sizes = kmalloc (minors * sizeof(int), GFP_KERNEL);
+	gd->sizes = kmalloc (minors * sizeof(blkoff_t), GFP_KERNEL);
 	gd->part  = kmalloc (minors * sizeof(struct hd_struct), GFP_KERNEL);
 	bs        = kmalloc (minors*sizeof(int), GFP_KERNEL);
 	max_sect  = kmalloc (minors*sizeof(int), GFP_KERNEL);
diff -ur /md0/kernels/2.4/v2.4.6-pre8/drivers/ide/ide.c lb-2.4.6-pre8/drivers/ide/ide.c
--- /md0/kernels/2.4/v2.4.6-pre8/drivers/ide/ide.c	Fri May 25 22:48:09 2001
+++ lb-2.4.6-pre8/drivers/ide/ide.c	Sat Jun 30 15:39:44 2001
@@ -881,7 +881,7 @@
 					  IN_BYTE(IDE_SECTOR_REG));
 				}
 				if (HWGROUP(drive)->rq)
-					printk(", sector=%ld", HWGROUP(drive)->rq->sector);
+					printk(", sector=%" BLKOFF_FMT, HWGROUP(drive)->rq->sector);
 			}
 		}
 #endif	/* FANCY_STATUS_DUMPS */
diff -ur /md0/kernels/2.4/v2.4.6-pre8/drivers/md/linear.c lb-2.4.6-pre8/drivers/md/linear.c
--- /md0/kernels/2.4/v2.4.6-pre8/drivers/md/linear.c	Mon Feb 26 10:20:07 2001
+++ lb-2.4.6-pre8/drivers/md/linear.c	Sat Jun 30 16:26:55 2001
@@ -125,15 +125,14 @@
         linear_conf_t *conf = mddev_to_conf(mddev);
         struct linear_hash *hash;
         dev_info_t *tmp_dev;
-        long block;
+        blkoff_t block;

 	block = bh->b_rsector >> 1;
 	hash = conf->hash_table + (block / conf->smallest->size);

 	if (block >= (hash->dev0->size + hash->dev0->offset)) {
 		if (!hash->dev1) {
-			printk ("linear_make_request : hash->dev1==NULL for block %ld\n",
-						block);
+			printk ("linear_make_request : hash->dev1==NULL for block %"BLKOFF_FMT"\n", block);
 			buffer_IO_error(bh);
 			return 0;
 		}
@@ -143,7 +142,7 @@

 	if (block >= (tmp_dev->size + tmp_dev->offset)
 				|| block < tmp_dev->offset) {
-		printk ("linear_make_request: Block %ld out of bounds on dev %s size %ld offset %ld\n", block, kdevname(tmp_dev->dev), tmp_dev->size, tmp_dev->offset);
+		printk ("linear_make_request: Block %" BLKOFF_FMT " out of bounds on dev %s size %"BLKOFF_FMT" offset %"BLKOFF_FMT"\n", block, kdevname(tmp_dev->dev), tmp_dev->size, tmp_dev->offset);
 		buffer_IO_error(bh);
 		return 0;
 	}
diff -ur /md0/kernels/2.4/v2.4.6-pre8/drivers/md/lvm.c lb-2.4.6-pre8/drivers/md/lvm.c
--- /md0/kernels/2.4/v2.4.6-pre8/drivers/md/lvm.c	Thu May  3 11:22:10 2001
+++ lb-2.4.6-pre8/drivers/md/lvm.c	Sat Jun 30 14:56:20 2001
@@ -1068,7 +1068,7 @@
 static int lvm_user_bmap(struct inode *inode, struct lv_bmap *user_result)
 {
 	struct buffer_head bh;
-	unsigned long block;
+	blkoff_t block;
 	int err;

 	if (get_user(block, &user_result->lv_block))
@@ -1481,8 +1481,8 @@
 	ulong index;
 	ulong pe_start;
 	ulong size = bh->b_size >> 9;
-	ulong rsector_tmp = bh->b_rsector;
-	ulong rsector_sav;
+	blkoff_t rsector_tmp = bh->b_rsector;
+	blkoff_t rsector_sav;
 	kdev_t rdev_tmp = bh->b_rdev;
 	kdev_t rdev_sav;
 	vg_t *vg_this = vg[VG_BLK(minor)];
@@ -1504,8 +1504,8 @@
 		return -1;
 	}

-	P_MAP("%s - lvm_map minor:%d  *rdev: %02d:%02d  *rsector: %lu  "
-	      "size:%lu\n",
+	P_MAP("%s - lvm_map minor:%d  *rdev: %02d:%02d  *rsector: %" BLKOFF_FMT
+	      "   size:%lu\n",
 	      lvm_name, minor,
 	      MAJOR(rdev_tmp),
 	      MINOR(rdev_tmp),
diff -ur /md0/kernels/2.4/v2.4.6-pre8/drivers/md/md.c lb-2.4.6-pre8/drivers/md/md.c
--- /md0/kernels/2.4/v2.4.6-pre8/drivers/md/md.c	Sat Jun 30 14:04:27 2001
+++ lb-2.4.6-pre8/drivers/md/md.c	Sat Jun 30 21:34:30 2001
@@ -112,7 +112,7 @@
 static int md_maxreadahead[MAX_MD_DEVS];
 static mdk_thread_t *md_recovery_thread;

-int md_size[MAX_MD_DEVS];
+blkoff_t md_size[MAX_MD_DEVS];

 extern struct block_device_operations md_fops;
 static devfs_handle_t devfs_handle;
@@ -803,7 +803,7 @@

 static void print_rdev(mdk_rdev_t *rdev)
 {
-	printk("md: rdev %s: O:%s, SZ:%08ld F:%d DN:%d ",
+	printk("md: rdev %s: O:%s, SZ:%08"BLKOFF_FMT" F:%d DN:%d ",
 		partition_name(rdev->dev), partition_name(rdev->old_dev),
 		rdev->size, rdev->faulty, rdev->desc_nr);
 	if (rdev->sb) {
@@ -912,7 +912,7 @@
 {
 	struct buffer_head *bh;
 	kdev_t dev;
-	unsigned long sb_offset, size;
+	blkoff_t sb_offset, size;
 	mdp_super_t *sb;

 	if (!rdev->sb) {
@@ -931,7 +931,7 @@
 	dev = rdev->dev;
 	sb_offset = calc_dev_sboffset(dev, rdev->mddev, 1);
 	if (rdev->sb_offset != sb_offset) {
-		printk("%s's sb offset has changed from %ld to %ld, skipping\n", partition_name(dev), rdev->sb_offset, sb_offset);
+		printk("%s's sb offset has changed from %"BLKOFF_FMT" to %"BLKOFF_FMT", skipping\n", partition_name(dev), rdev->sb_offset, sb_offset);
 		goto skip;
 	}
 	/*
@@ -941,11 +941,11 @@
 	 */
 	size = calc_dev_size(dev, rdev->mddev, 1);
 	if (size != rdev->size) {
-		printk("%s's size has changed from %ld to %ld since import, skipping\n", partition_name(dev), rdev->size, size);
+		printk("%s's size has changed from %"BLKOFF_FMT" to %"BLKOFF_FMT" since import, skipping\n", partition_name(dev), rdev->size, size);
 		goto skip;
 	}

-	printk("(write) %s's sb offset: %ld\n", partition_name(dev), sb_offset);
+	printk("(write) %s's sb offset: %"BLKOFF_FMT"\n", partition_name(dev), sb_offset);
 	fsync_dev(dev);
 	set_blocksize(dev, MD_SB_BYTES);
 	bh = getblk(dev, sb_offset / MD_SB_BLOCKS, MD_SB_BYTES);
@@ -1485,7 +1485,7 @@
 		rdev->size = calc_dev_size(rdev->dev, mddev, persistent);
 		if (rdev->size < sb->chunk_size / 1024) {
 			printk (KERN_WARNING
-				"md: Dev %s smaller than chunk_size: %ldk < %dk\n",
+				"md: Dev %s smaller than chunk_size: %"BLKOFF_FMT"k < %dk\n",
 				partition_name(rdev->dev),
 				rdev->size, sb->chunk_size / 1024);
 			return -EINVAL;
@@ -2508,10 +2508,27 @@
 				err = -EINVAL;
 				goto abort;
 			}
+			if ((long)md_hd_struct[minor].nr_sects !=
+			    md_hd_struct[minor].nr_sects) {
+				err = -EOVERFLOW;
+				goto abort;
+			}
 			err = md_put_user(md_hd_struct[minor].nr_sects,
 						(long *) arg);
 			goto done;

+		case BLKGETSIZE64:   /* Return device size */
+		{
+			long long val = md_hd_struct[minor].nr_sects;
+			if (!arg) {
+				err = -EINVAL;
+				goto abort;
+			}
+			err = 0;
+			if (copy_to_user((void *)arg, &val, sizeof val))
+				err = -EFAULT;
+			goto done;
+		}
 		case BLKFLSBUF:
 			fsync_dev(dev);
 			invalidate_buffers(dev);
@@ -3051,7 +3068,8 @@
 static int md_status_read_proc(char *page, char **start, off_t off,
 			int count, int *eof, void *data)
 {
-	int sz = 0, j, size;
+	blkoff_t size;
+	int sz = 0, j;
 	struct md_list_head *tmp, *tmp2;
 	mdk_rdev_t *rdev;
 	mddev_t *mddev;
@@ -3092,10 +3110,10 @@

 		if (mddev->nb_dev) {
 			if (mddev->pers)
-				sz += sprintf(page + sz, "\n      %d blocks",
+				sz += sprintf(page + sz, "\n      %" BLKOFF_FMT " blocks",
 						 md_size[mdidx(mddev)]);
 			else
-				sz += sprintf(page + sz, "\n      %d blocks", size);
+				sz += sprintf(page + sz, "\n      %" BLKOFF_FMT " blocks", size);
 		}

 		if (!mddev->pers) {
@@ -3226,8 +3244,9 @@
 int md_do_sync(mddev_t *mddev, mdp_disk_t *spare)
 {
 	mddev_t *mddev2;
-	unsigned int max_sectors, currspeed,
-		j, window, err, serialize;
+	blkoff_t max_sectors, j;
+	unsigned int currspeed,
+		window, err, serialize;
 	kdev_t read_disk = mddev_to_kdev(mddev);
 	unsigned long mark[SYNC_MARKS];
 	unsigned long mark_cnt[SYNC_MARKS];
@@ -3288,7 +3307,7 @@
 	 * Tune reconstruction:
 	 */
 	window = MAX_READAHEAD*(PAGE_SIZE/512);
-	printk(KERN_INFO "md: using %dk window, over a total of %d blocks.\n",window/2,max_sectors/2);
+	printk(KERN_INFO "md: using %dk window, over a total of %" BLKOFF_FMT " blocks.\n",window/2,max_sectors/2);

 	atomic_set(&mddev->recovery_active, 0);
 	init_waitqueue_head(&mddev->recovery_wait);
@@ -3306,6 +3325,7 @@
 		j += sectors;
 		mddev->curr_resync = j;

+		/* README: Uhhh, is this right?  last_check is always 0 here */
 		if (last_check + window > j)
 			continue;

diff -ur /md0/kernels/2.4/v2.4.6-pre8/drivers/md/raid0.c lb-2.4.6-pre8/drivers/md/raid0.c
--- /md0/kernels/2.4/v2.4.6-pre8/drivers/md/raid0.c	Sat Jun 30 14:04:27 2001
+++ lb-2.4.6-pre8/drivers/md/raid0.c	Sat Jun 30 23:47:30 2001
@@ -41,7 +41,7 @@
 		printk("raid0: looking at %s\n", partition_name(rdev1->dev));
 		c = 0;
 		ITERATE_RDEV_ORDERED(mddev,rdev2,j2) {
-			printk("raid0:   comparing %s(%ld) with %s(%ld)\n", partition_name(rdev1->dev), rdev1->size, partition_name(rdev2->dev), rdev2->size);
+			printk("raid0:   comparing %s(%"BLKOFF_FMT") with %s(%"BLKOFF_FMT")\n", partition_name(rdev1->dev), rdev1->size, partition_name(rdev2->dev), rdev2->size);
 			if (rdev2 == rdev1) {
 				printk("raid0:   END\n");
 				break;
@@ -95,7 +95,7 @@
 				c++;
 				if (!smallest || (rdev->size <smallest->size)) {
 					smallest = rdev;
-					printk("  (%ld) is smallest!.\n", rdev->size);
+					printk("  (%"BLKOFF_FMT") is smallest!.\n", rdev->size);
 				}
 			} else
 				printk(" nope.\n");
@@ -103,7 +103,7 @@

 		zone->nb_dev = c;
 		zone->size = (smallest->size - current_offset) * c;
-		printk("raid0: zone->nb_dev: %d, size: %ld\n",zone->nb_dev,zone->size);
+		printk("raid0: zone->nb_dev: %d, size: %"BLKOFF_FMT"\n",zone->nb_dev,zone->size);

 		if (!conf->smallest || (zone->size < conf->smallest->size))
 			conf->smallest = zone;
@@ -138,8 +138,8 @@
 	if (create_strip_zones (mddev))
 		goto out_free_conf;

-	printk("raid0 : md_size is %d blocks.\n", md_size[mdidx(mddev)]);
-	printk("raid0 : conf->smallest->size is %ld blocks.\n", conf->smallest->size);
+	printk("raid0 : md_size is %" BLKOFF_FMT " blocks.\n", md_size[mdidx(mddev)]);
+	printk("raid0 : conf->smallest->size is %" BLKOFF_FMT " blocks.\n", conf->smallest->size);
 	nb_zone = md_size[mdidx(mddev)]/conf->smallest->size +
 			(md_size[mdidx(mddev)] % conf->smallest->size ? 1 : 0);
 	printk("raid0 : nb_zone is %ld.\n", nb_zone);
@@ -231,7 +231,8 @@
 	struct raid0_hash *hash;
 	struct strip_zone *zone;
 	mdk_rdev_t *tmp_dev;
-	unsigned long chunk, block, rsect;
+	blkoff_t chunk;
+	blkoff_t block, rsect;

 	chunk_size = mddev->param.chunk_size >> 10;
 	chunksize_bits = ffz(~chunk_size);
@@ -239,7 +240,7 @@
 	hash = conf->hash_table + block / conf->smallest->size;

 	/* Sanity check */
-	if (chunk_size < (block % chunk_size) + (bh->b_size >> 10))
+	if (chunk_size < (block & (chunk_size-1)) + (bh->b_size >> 10))
 		goto bad_map;

 	if (!hash)
@@ -274,16 +275,16 @@
 	return 1;

 bad_map:
-	printk ("raid0_make_request bug: can't convert block across chunks or bigger than %dk %ld %d\n", chunk_size, bh->b_rsector, bh->b_size >> 10);
+	printk ("raid0_make_request bug: can't convert block across chunks or bigger than %dk %"BLKOFF_FMT" %d\n", chunk_size, bh->b_rsector, bh->b_size >> 10);
 	goto outerr;
 bad_hash:
-	printk("raid0_make_request bug: hash==NULL for block %ld\n", block);
+	printk("raid0_make_request bug: hash==NULL for block %"BLKOFF_FMT"\n", block);
 	goto outerr;
 bad_zone0:
-	printk ("raid0_make_request bug: hash->zone0==NULL for block %ld\n", block);
+	printk ("raid0_make_request bug: hash->zone0==NULL for block %"BLKOFF_FMT"\n", block);
 	goto outerr;
 bad_zone1:
-	printk ("raid0_make_request bug: hash->zone1==NULL for block %ld\n", block);
+	printk ("raid0_make_request bug: hash->zone1==NULL for block %"BLKOFF_FMT"\n", block);
  outerr:
 	buffer_IO_error(bh);
 	return 0;
diff -ur /md0/kernels/2.4/v2.4.6-pre8/drivers/md/raid1.c lb-2.4.6-pre8/drivers/md/raid1.c
--- /md0/kernels/2.4/v2.4.6-pre8/drivers/md/raid1.c	Sat Jun 30 14:04:27 2001
+++ lb-2.4.6-pre8/drivers/md/raid1.c	Sat Jun 30 23:48:47 2001
@@ -335,7 +335,7 @@
 }


-static void inline io_request_done(unsigned long sector, raid1_conf_t *conf, int phase)
+static void inline io_request_done(blkoff_t sector, raid1_conf_t *conf, int phase)
 {
 	unsigned long flags;
 	spin_lock_irqsave(&conf->segment_lock, flags);
@@ -417,7 +417,7 @@
 		/*
 		 * oops, read error:
 		 */
-		printk(KERN_ERR "raid1: %s: rescheduling block %lu\n",
+		printk(KERN_ERR "raid1: %s: rescheduling block %"BLKOFF_FMT"\n",
 			 partition_name(bh->b_dev), bh->b_blocknr);
 		raid1_reschedule_retry(r1_bh);
 		return;
@@ -450,10 +450,10 @@
 {
 	int new_disk = conf->last_used;
 	const int sectors = bh->b_size >> 9;
-	const unsigned long this_sector = bh->b_rsector;
+	const blkoff_t this_sector = bh->b_rsector;
 	int disk = new_disk;
-	unsigned long new_distance;
-	unsigned long current_distance;
+	blkoff_t new_distance;
+	blkoff_t current_distance;

 	/*
 	 * Check if it is sane at all to balance
@@ -510,9 +510,9 @@

 		goto rb_out;
 	}
-
-	current_distance = abs(this_sector -
-				conf->mirrors[disk].head_position);
+	current_distance = (this_sector > conf->mirrors[disk].head_position) ?
+			this_sector - conf->mirrors[disk].head_position :
+			conf->mirrors[disk].head_position - this_sector;

 	/* Find the disk which is closest */

@@ -525,8 +525,9 @@
 				(!conf->mirrors[disk].operational))
 			continue;

-		new_distance = abs(this_sector -
-					conf->mirrors[disk].head_position);
+		new_distance = (this_sector > conf->mirrors[disk].head_position) ?
+			this_sector - conf->mirrors[disk].head_position :
+			conf->mirrors[disk].head_position - this_sector;

 		if (new_distance < current_distance) {
 			conf->sect_count = 0;
@@ -1088,10 +1089,10 @@


 #define IO_ERROR KERN_ALERT \
-"raid1: %s: unrecoverable I/O read error for block %lu\n"
+"raid1: %s: unrecoverable I/O read error for block %"BLKOFF_FMT"\n"

 #define REDIRECT_SECTOR KERN_ERR \
-"raid1: %s: redirecting sector %lu to another mirror\n"
+"raid1: %s: redirecting sector %"BLKOFF_FMT" to another mirror\n"

 /*
  * This is a kernel thread which:
@@ -1304,7 +1305,7 @@
  * issue suitable write requests
  */

-static int raid1_sync_request (mddev_t *mddev, unsigned long sector_nr)
+static int raid1_sync_request (mddev_t *mddev, blkoff_t sector_nr)
 {
 	raid1_conf_t *conf = mddev_to_conf(mddev);
 	struct mirror_info *mirror;
@@ -1312,7 +1313,7 @@
 	struct buffer_head *bh;
 	int bsize;
 	int disk;
-	int block_nr;
+	blkoff_t block_nr;

 	spin_lock_irq(&conf->segment_lock);
 	if (!sector_nr) {
diff -ur /md0/kernels/2.4/v2.4.6-pre8/drivers/md/raid5.c lb-2.4.6-pre8/drivers/md/raid5.c
--- /md0/kernels/2.4/v2.4.6-pre8/drivers/md/raid5.c	Sat Jun 30 14:04:27 2001
+++ lb-2.4.6-pre8/drivers/md/raid5.c	Sat Jun 30 16:04:05 2001
@@ -204,7 +204,7 @@
 	for (i=disks; i--; ) {
 		if (sh->bh_read[i] || sh->bh_write[i] || sh->bh_written[i] ||
 		    buffer_locked(sh->bh_cache[i])) {
-			printk("sector=%lx i=%d %p %p %p %d\n",
+			printk("sector=%"BLKOFF_FMT" i=%d %p %p %p %d\n",
 			       sh->sector, i, sh->bh_read[i],
 			       sh->bh_write[i], sh->bh_written[i],
 			       buffer_locked(sh->bh_cache[i]));
@@ -464,7 +464,7 @@
 {
 	raid5_conf_t *conf = sh->raid_conf;
 	struct buffer_head *bh = sh->bh_cache[i];
-	unsigned long block = sh->sector / (sh->size >> 9);
+	blkoff_t block = sh->sector / (sh->size >> 9);

 	init_buffer(bh, raid5_end_read_request, sh);
 	bh->b_dev       = conf->disks[i].dev;
@@ -539,7 +539,7 @@
  * Input: a 'big' sector number,
  * Output: index of the data and parity disk, and the sector # in them.
  */
-static unsigned long raid5_compute_sector(unsigned long r_sector, unsigned int raid_disks,
+static unsigned long raid5_compute_sector(blkoff_t r_sector, unsigned int raid_disks,
 			unsigned int data_disks, unsigned int * dd_idx,
 			unsigned int * pd_idx, raid5_conf_t *conf)
 {
@@ -607,12 +607,12 @@
 {
 	raid5_conf_t *conf = sh->raid_conf;
 	int raid_disks = conf->raid_disks, data_disks = raid_disks - 1;
-	unsigned long new_sector = sh->sector, check;
+	blkoff_t new_sector = sh->sector, check;
 	int sectors_per_chunk = conf->chunk_size >> 9;
-	unsigned long stripe = new_sector / sectors_per_chunk;
+	blkoff_t stripe = new_sector / sectors_per_chunk;
 	int chunk_offset = new_sector % sectors_per_chunk;
 	int chunk_number, dummy1, dummy2, dd_idx = i;
-	unsigned long r_sector, blocknr;
+	blkoff_t r_sector, blocknr;

 	switch (conf->algorithm) {
 		case ALGORITHM_LEFT_ASYMMETRIC:
@@ -670,7 +670,7 @@
 		if (buffer_uptodate(bh))
 			bh_ptr[count++] = bh;
 		else
-			printk("compute_block() %d, stripe %lu, %d not present\n", dd_idx, sh->sector, i);
+			printk("compute_block() %d, stripe %"BLKOFF_FMT", %d not present\n", dd_idx, sh->sector, i);

 		check_xor();
 	}
@@ -781,7 +781,7 @@
 	else
 		bhp = &sh->bh_write[dd_idx];
 	while (*bhp) {
-		printk(KERN_NOTICE "raid5: multiple %d requests for sector %ld\n", rw, sh->sector);
+		printk(KERN_NOTICE "raid5: multiple %d requests for sector %"BLKOFF_FMT"\n", rw, sh->sector);
 		bhp = & (*bhp)->b_reqnext;
 	}
 	*bhp = bh;
@@ -1236,18 +1236,18 @@
 	return correct_size;
 }

-static int raid5_sync_request (mddev_t *mddev, unsigned long sector_nr)
+static int raid5_sync_request (mddev_t *mddev, blkoff_t sector_nr)
 {
 	raid5_conf_t *conf = (raid5_conf_t *) mddev->private;
 	struct stripe_head *sh;
 	int sectors_per_chunk = conf->chunk_size >> 9;
-	unsigned long stripe = sector_nr/sectors_per_chunk;
+	blkoff_t stripe = sector_nr/sectors_per_chunk;
 	int chunk_offset = sector_nr % sectors_per_chunk;
 	int dd_idx, pd_idx;
-	unsigned long first_sector;
+	blkoff_t first_sector;
 	int raid_disks = conf->raid_disks;
 	int data_disks = raid_disks-1;
-	int redone = 0;
+	blkoff_t redone = 0;
 	int bufsize;

 	sh = get_active_stripe(conf, sector_nr, 0, 0);
diff -ur /md0/kernels/2.4/v2.4.6-pre8/drivers/scsi/scsi_lib.c lb-2.4.6-pre8/drivers/scsi/scsi_lib.c
--- /md0/kernels/2.4/v2.4.6-pre8/drivers/scsi/scsi_lib.c	Fri May 25 22:48:09 2001
+++ lb-2.4.6-pre8/drivers/scsi/scsi_lib.c	Sat Jun 30 16:07:29 2001
@@ -369,7 +369,7 @@
 	req = &SCpnt->request;
 	req->errors = 0;
 	if (!uptodate) {
-		printk(" I/O error: dev %s, sector %lu\n",
+		printk(" I/O error: dev %s, sector %"BLKOFF_FMT"\n",
 		       kdevname(req->rq_dev), req->sector);
 	}
 	do {
diff -ur /md0/kernels/2.4/v2.4.6-pre8/drivers/scsi/sd.c lb-2.4.6-pre8/drivers/scsi/sd.c
--- /md0/kernels/2.4/v2.4.6-pre8/drivers/scsi/sd.c	Sat Jun 30 14:04:27 2001
+++ lb-2.4.6-pre8/drivers/scsi/sd.c	Sat Jun 30 14:22:13 2001
@@ -81,7 +81,7 @@
 struct hd_struct *sd;

 static Scsi_Disk *rscsi_disks;
-static int *sd_sizes;
+static blkoff_t *sd_sizes;
 static int *sd_blocksizes;
 static int *sd_hardsizes;	/* Hardware sector size */

@@ -1050,10 +1050,11 @@
 	memset(rscsi_disks, 0, sd_template.dev_max * sizeof(Scsi_Disk));

 	/* for every (necessary) major: */
-	sd_sizes = kmalloc((sd_template.dev_max << 4) * sizeof(int), GFP_ATOMIC);
+	/* FIXME: GFP_ATOMIC???  Someone please pass the pipe... */
+	sd_sizes = kmalloc((sd_template.dev_max << 4) * sizeof(blkoff_t), GFP_ATOMIC);
 	if (!sd_sizes)
 		goto cleanup_disks;
-	memset(sd_sizes, 0, (sd_template.dev_max << 4) * sizeof(int));
+	memset(sd_sizes, 0, (sd_template.dev_max << 4) * sizeof(blkoff_t));

 	sd_blocksizes = kmalloc((sd_template.dev_max << 4) * sizeof(int), GFP_ATOMIC);
 	if (!sd_blocksizes)
diff -ur /md0/kernels/2.4/v2.4.6-pre8/drivers/scsi/sr.c lb-2.4.6-pre8/drivers/scsi/sr.c
--- /md0/kernels/2.4/v2.4.6-pre8/drivers/scsi/sr.c	Fri May 25 22:48:09 2001
+++ lb-2.4.6-pre8/drivers/scsi/sr.c	Sat Jun 30 22:00:58 2001
@@ -85,7 +85,7 @@
 };

 Scsi_CD *scsi_CDs;
-static int *sr_sizes;
+static blkoff_t *sr_sizes;

 static int *sr_blocksizes;

@@ -766,10 +766,10 @@
 		goto cleanup_devfs;
 	memset(scsi_CDs, 0, sr_template.dev_max * sizeof(Scsi_CD));

-	sr_sizes = kmalloc(sr_template.dev_max * sizeof(int), GFP_ATOMIC);
+	sr_sizes = kmalloc(sr_template.dev_max * sizeof(blkoff_t), GFP_ATOMIC);
 	if (!sr_sizes)
 		goto cleanup_cds;
-	memset(sr_sizes, 0, sr_template.dev_max * sizeof(int));
+	memset(sr_sizes, 0, sr_template.dev_max * sizeof(blkoff_t));

 	sr_blocksizes = kmalloc(sr_template.dev_max * sizeof(int), GFP_ATOMIC);
 	if (!sr_blocksizes)
diff -ur /md0/kernels/2.4/v2.4.6-pre8/fs/adfs/adfs.h lb-2.4.6-pre8/fs/adfs/adfs.h
--- /md0/kernels/2.4/v2.4.6-pre8/fs/adfs/adfs.h	Mon Sep 18 18:14:06 2000
+++ lb-2.4.6-pre8/fs/adfs/adfs.h	Sat Jun 30 15:27:18 2001
@@ -66,7 +66,7 @@

 /* Inode stuff */
 #if LINUX_VERSION_CODE >= KERNEL_VERSION(2,3,0)
-int adfs_get_block(struct inode *inode, long block,
+int adfs_get_block(struct inode *inode, blkoff_t block,
 		   struct buffer_head *bh, int create);
 #else
 int adfs_bmap(struct inode *inode, int block);
diff -ur /md0/kernels/2.4/v2.4.6-pre8/fs/adfs/inode.c lb-2.4.6-pre8/fs/adfs/inode.c
--- /md0/kernels/2.4/v2.4.6-pre8/fs/adfs/inode.c	Fri Dec 29 17:07:57 2000
+++ lb-2.4.6-pre8/fs/adfs/inode.c	Sat Jun 30 15:25:32 2001
@@ -25,7 +25,7 @@
  * not support creation of new blocks, so we return -EIO for this case.
  */
 int
-adfs_get_block(struct inode *inode, long block, struct buffer_head *bh, int create)
+adfs_get_block(struct inode *inode, blkoff_t block, struct buffer_head *bh, int create)
 {
 	if (block < 0)
 		goto abort_negative;
diff -ur /md0/kernels/2.4/v2.4.6-pre8/fs/affs/file.c lb-2.4.6-pre8/fs/affs/file.c
--- /md0/kernels/2.4/v2.4.6-pre8/fs/affs/file.c	Sat Jun 30 14:04:27 2001
+++ lb-2.4.6-pre8/fs/affs/file.c	Sat Jun 30 15:28:09 2001
@@ -38,7 +38,6 @@
 static struct buffer_head *affs_alloc_extblock(struct inode *inode, struct buffer_head *bh, u32 ext);
 static inline struct buffer_head *affs_get_extblock(struct inode *inode, u32 ext);
 static struct buffer_head *affs_get_extblock_slow(struct inode *inode, u32 ext);
-static int affs_get_block(struct inode *inode, long block, struct buffer_head *bh_result, int create);

 static ssize_t affs_file_write(struct file *filp, const char *buf, size_t count, loff_t *ppos);
 static int affs_file_open(struct inode *inode, struct file *filp);
@@ -331,7 +330,7 @@
 }

 static int
-affs_get_block(struct inode *inode, long block, struct buffer_head *bh_result, int create)
+affs_get_block(struct inode *inode, blkoff_t block, struct buffer_head *bh_result, int create)
 {
 	struct super_block	*sb = inode->i_sb;
 	struct buffer_head	*ext_bh;
diff -ur /md0/kernels/2.4/v2.4.6-pre8/fs/affs/super.c lb-2.4.6-pre8/fs/affs/super.c
--- /md0/kernels/2.4/v2.4.6-pre8/fs/affs/super.c	Thu May  3 11:22:16 2001
+++ lb-2.4.6-pre8/fs/affs/super.c	Sat Jun 30 14:22:13 2001
@@ -29,7 +29,6 @@
 #include <asm/system.h>
 #include <asm/uaccess.h>

-extern int *blk_size[];
 extern struct timezone sys_tz;

 static int affs_statfs(struct super_block *sb, struct statfs *buf);
diff -ur /md0/kernels/2.4/v2.4.6-pre8/fs/bfs/file.c lb-2.4.6-pre8/fs/bfs/file.c
--- /md0/kernels/2.4/v2.4.6-pre8/fs/bfs/file.c	Mon Dec  4 22:02:45 2000
+++ lb-2.4.6-pre8/fs/bfs/file.c	Sat Jun 30 15:26:50 2001
@@ -53,7 +53,7 @@
 	return 0;
 }

-static int bfs_get_block(struct inode * inode, long block,
+static int bfs_get_block(struct inode * inode, blkoff_t block,
 	struct buffer_head * bh_result, int create)
 {
 	long phys;
diff -ur /md0/kernels/2.4/v2.4.6-pre8/fs/block_dev.c lb-2.4.6-pre8/fs/block_dev.c
--- /md0/kernels/2.4/v2.4.6-pre8/fs/block_dev.c	Sat Jun 30 14:04:27 2001
+++ lb-2.4.6-pre8/fs/block_dev.c	Sat Jun 30 15:01:36 2001
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

@@ -28,15 +26,15 @@
 {
 	struct inode * inode = filp->f_dentry->d_inode;
 	ssize_t blocksize, blocksize_bits, i, buffercount, write_error;
-	ssize_t block, blocks;
+	ssize_t blocks;
 	loff_t offset;
 	ssize_t chars;
 	ssize_t written, retval;
 	struct buffer_head * bhlist[NBUF];
-	size_t size;
 	kdev_t dev = inode->i_rdev;
 	struct buffer_head * bh, *bufferlist[NBUF];
 	register char * p;
+	blkoff_t block, size;

 	if (is_read_only(dev))
 		return -EPERM;
@@ -57,7 +55,7 @@
 	offset = *ppos & (blocksize-1);

 	if (blk_size[MAJOR(dev)])
-		size = ((loff_t) blk_size[MAJOR(dev)][MINOR(dev)] << BLOCK_SIZE_BITS) >> blocksize_bits;
+		size = ((unsigned long long) blk_size[MAJOR(dev)][MINOR(dev)] << BLOCK_SIZE_BITS) >> blocksize_bits;
 	else
 		size = INT_MAX;
 	while (count>0) {
@@ -177,7 +175,6 @@
 ssize_t block_read(struct file * filp, char * buf, size_t count, loff_t *ppos)
 {
 	struct inode * inode = filp->f_dentry->d_inode;
-	size_t block;
 	loff_t offset;
 	ssize_t blocksize;
 	ssize_t blocksize_bits, i;
@@ -190,6 +187,7 @@
 	loff_t size;
 	kdev_t dev;
 	ssize_t read;
+	blkoff_t block;

 	dev = inode->i_rdev;
 	blocksize = BLOCK_SIZE;
diff -ur /md0/kernels/2.4/v2.4.6-pre8/fs/buffer.c lb-2.4.6-pre8/fs/buffer.c
--- /md0/kernels/2.4/v2.4.6-pre8/fs/buffer.c	Sat Jun 30 14:04:27 2001
+++ lb-2.4.6-pre8/fs/buffer.c	Sat Jun 30 14:22:13 2001
@@ -531,7 +531,7 @@
  * will force it bad). This shouldn't really happen currently, but
  * the code is ready.
  */
-static inline struct buffer_head * __get_hash_table(kdev_t dev, int block, int size)
+static inline struct buffer_head * __get_hash_table(kdev_t dev, blkoff_t block, int size)
 {
 	struct buffer_head *bh = hash(dev, block);

@@ -546,7 +546,7 @@
 	return bh;
 }

-struct buffer_head * get_hash_table(kdev_t dev, int block, int size)
+struct buffer_head * get_hash_table(kdev_t dev, blkoff_t block, int size)
 {
 	struct buffer_head *bh;

@@ -665,7 +665,6 @@

 void set_blocksize(kdev_t dev, int size)
 {
-	extern int *blksize_size[];
 	int i, nlist, slept;
 	struct buffer_head * bh, * bh_next;

@@ -712,7 +711,7 @@
 			if (!atomic_read(&bh->b_count)) {
 				if (buffer_dirty(bh))
 					printk(KERN_WARNING
-					       "set_blocksize: dev %s buffer_dirty %lu size %hu\n",
+					       "set_blocksize: dev %s buffer_dirty %" BLKOFF_FMT " size %hu\n",
 					       kdevname(dev), bh->b_blocknr, bh->b_size);
 				remove_inode_queue(bh);
 				__remove_from_queues(bh);
@@ -723,7 +722,7 @@
 				clear_bit(BH_Uptodate, &bh->b_state);
 				printk(KERN_WARNING
 				       "set_blocksize: "
-				       "b_count %d, dev %s, block %lu, from %p\n",
+				       "b_count %d, dev %s, block %" BLKOFF_FMT ", from %p\n",
 				       atomic_read(&bh->b_count), bdevname(bh->b_dev),
 				       bh->b_blocknr, __builtin_return_address(0));
 			}
@@ -970,7 +969,7 @@
  * 14.02.92: changed it to sync dirty buffers a bit: better performance
  * when the filesystem starts to get full of dirty blocks (I hope).
  */
-struct buffer_head * getblk(kdev_t dev, int block, int size)
+struct buffer_head * getblk(kdev_t dev, blkoff_t block, int size)
 {
 	struct buffer_head * bh;
 	int isize;
@@ -1155,7 +1154,7 @@
  * bread() reads a specified block and returns the buffer that contains
  * it. It returns NULL if the block was unreadable.
  */
-struct buffer_head * bread(kdev_t dev, int block, int size)
+struct buffer_head * bread(kdev_t dev, blkoff_t block, int size)
 {
 	struct buffer_head * bh;

@@ -1659,7 +1658,7 @@
 int block_read_full_page(struct page *page, get_block_t *get_block)
 {
 	struct inode *inode = page->mapping->host;
-	unsigned long iblock, lblock;
+	blkoff_t iblock, lblock;
 	struct buffer_head *bh, *head, *arr[MAX_BUF_PER_PAGE];
 	unsigned int blocksize, blocks;
 	int nr, i;
@@ -1672,7 +1671,7 @@
 	head = page->buffers;

 	blocks = PAGE_CACHE_SIZE >> inode->i_sb->s_blocksize_bits;
-	iblock = page->index << (PAGE_CACHE_SHIFT - inode->i_sb->s_blocksize_bits);
+	iblock = (blkoff_t)page->index << (PAGE_CACHE_SHIFT - inode->i_sb->s_blocksize_bits);
 	lblock = (inode->i_size+blocksize-1) >> inode->i_sb->s_blocksize_bits;
 	bh = head;
 	nr = 0;
@@ -1949,7 +1948,7 @@
 	goto done;
 }

-int generic_block_bmap(struct address_space *mapping, long block, get_block_t *get_block)
+blkoff_t generic_block_bmap(struct address_space *mapping, blkoff_t block, get_block_t *get_block)
 {
 	struct buffer_head tmp;
 	struct inode *inode = mapping->host;
@@ -2033,7 +2032,7 @@
 	int		pageind;
 	int		bhind;
 	int		offset;
-	unsigned long	blocknr;
+	blkoff_t	blocknr;
 	struct kiobuf *	iobuf = NULL;
 	struct page *	map;
 	struct buffer_head *tmp, **bhs = NULL;
@@ -2147,7 +2146,7 @@
  * FIXME: we need a swapper_inode->get_block function to remove
  *        some of the bmap kludges and interface ugliness here.
  */
-int brw_page(int rw, struct page *page, kdev_t dev, int b[], int size)
+int brw_page(int rw, struct page *page, kdev_t dev, blkoff_t b[], int size)
 {
 	struct buffer_head *head, *bh;

diff -ur /md0/kernels/2.4/v2.4.6-pre8/fs/efs/file.c lb-2.4.6-pre8/fs/efs/file.c
--- /md0/kernels/2.4/v2.4.6-pre8/fs/efs/file.c	Sat Feb 26 23:33:05 2000
+++ lb-2.4.6-pre8/fs/efs/file.c	Sat Jun 30 14:22:13 2001
@@ -8,7 +8,7 @@

 #include <linux/efs_fs.h>

-int efs_get_block(struct inode *inode, long iblock,
+int efs_get_block(struct inode *inode, blkoff_t iblock,
 		  struct buffer_head *bh_result, int create)
 {
 	int error = -EROFS;
diff -ur /md0/kernels/2.4/v2.4.6-pre8/fs/ext2/inode.c lb-2.4.6-pre8/fs/ext2/inode.c
--- /md0/kernels/2.4/v2.4.6-pre8/fs/ext2/inode.c	Sat Jun 30 14:04:27 2001
+++ lb-2.4.6-pre8/fs/ext2/inode.c	Sat Jun 30 14:22:13 2001
@@ -503,7 +503,7 @@
  * reachable from inode.
  */

-static int ext2_get_block(struct inode *inode, long iblock, struct buffer_head *bh_result, int create)
+static int ext2_get_block(struct inode *inode, blkoff_t iblock, struct buffer_head *bh_result, int create)
 {
 	int err = -EIO;
 	int offsets[4];
diff -ur /md0/kernels/2.4/v2.4.6-pre8/fs/fat/file.c lb-2.4.6-pre8/fs/fat/file.c
--- /md0/kernels/2.4/v2.4.6-pre8/fs/fat/file.c	Fri May 25 22:48:09 2001
+++ lb-2.4.6-pre8/fs/fat/file.c	Sat Jun 30 14:22:13 2001
@@ -54,7 +54,7 @@
 }


-int fat_get_block(struct inode *inode, long iblock, struct buffer_head *bh_result, int create)
+int fat_get_block(struct inode *inode, blkoff_t iblock, struct buffer_head *bh_result, int create)
 {
 	struct super_block *sb = inode->i_sb;
 	unsigned long phys;
diff -ur /md0/kernels/2.4/v2.4.6-pre8/fs/freevxfs/vxfs_subr.c lb-2.4.6-pre8/fs/freevxfs/vxfs_subr.c
--- /md0/kernels/2.4/v2.4.6-pre8/fs/freevxfs/vxfs_subr.c	Fri May 25 22:48:09 2001
+++ lb-2.4.6-pre8/fs/freevxfs/vxfs_subr.c	Sat Jun 30 14:22:13 2001
@@ -134,7 +134,7 @@
  *   Zero on success, else a negativ error code (-EIO).
  */
 static int
-vxfs_getblk(struct inode *ip, long iblock,
+vxfs_getblk(struct inode *ip, blkoff_t iblock,
 	    struct buffer_head *bp, int create)
 {
 	daddr_t			pblock;
diff -ur /md0/kernels/2.4/v2.4.6-pre8/fs/hfs/file.c lb-2.4.6-pre8/fs/hfs/file.c
--- /md0/kernels/2.4/v2.4.6-pre8/fs/hfs/file.c	Mon Feb 26 10:20:13 2001
+++ lb-2.4.6-pre8/fs/hfs/file.c	Sat Jun 30 14:22:13 2001
@@ -106,7 +106,7 @@
  * block number.  This function just calls hfs_extent_map() to do the
  * real work and then stuffs the appropriate info into the buffer_head.
  */
-int hfs_get_block(struct inode *inode, long iblock, struct buffer_head *bh_result, int create)
+int hfs_get_block(struct inode *inode, blkoff_t iblock, struct buffer_head *bh_result, int create)
 {
 	unsigned long phys;

diff -ur /md0/kernels/2.4/v2.4.6-pre8/fs/hfs/hfs.h lb-2.4.6-pre8/fs/hfs/hfs.h
--- /md0/kernels/2.4/v2.4.6-pre8/fs/hfs/hfs.h	Sat Jun 30 15:20:48 2001
+++ lb-2.4.6-pre8/fs/hfs/hfs.h	Sat Jun 30 18:03:31 2001
@@ -495,7 +495,7 @@
 extern void hfs_extent_free(struct hfs_fork *);

 /* file.c */
-extern int hfs_get_block(struct inode *, long, struct buffer_head *, int);
+extern int hfs_get_block(struct inode *, blkoff_t, struct buffer_head *, int);

 /* mdb.c */
 extern struct hfs_mdb *hfs_mdb_get(hfs_sysmdb, int, hfs_s32);
diff -ur /md0/kernels/2.4/v2.4.6-pre8/fs/hpfs/file.c lb-2.4.6-pre8/fs/hpfs/file.c
--- /md0/kernels/2.4/v2.4.6-pre8/fs/hpfs/file.c	Fri Dec 29 17:07:57 2000
+++ lb-2.4.6-pre8/fs/hpfs/file.c	Sat Jun 30 14:22:13 2001
@@ -66,7 +66,7 @@
 	hpfs_write_inode(i);
 }

-int hpfs_get_block(struct inode *inode, long iblock, struct buffer_head *bh_result, int create)
+int hpfs_get_block(struct inode *inode, blkoff_t iblock, struct buffer_head *bh_result, int create)
 {
 	secno s;
 	s = hpfs_bmap(inode, iblock);
diff -ur /md0/kernels/2.4/v2.4.6-pre8/fs/isofs/inode.c lb-2.4.6-pre8/fs/isofs/inode.c
--- /md0/kernels/2.4/v2.4.6-pre8/fs/isofs/inode.c	Thu May  3 11:22:16 2001
+++ lb-2.4.6-pre8/fs/isofs/inode.c	Sat Jun 30 16:09:03 2001
@@ -876,7 +876,7 @@
 /* Life is simpler than for other filesystem since we never
  * have to create a new block, only find an existing one.
  */
-static int isofs_get_block(struct inode *inode, long iblock,
+static int isofs_get_block(struct inode *inode, blkoff_t iblock,
 		    struct buffer_head *bh_result, int create)
 {
 	unsigned long b_off;
@@ -951,18 +951,18 @@
 	goto abort;

 abort_beyond_end:
-	printk("isofs_get_block: block >= EOF (%ld, %ld)\n",
+	printk("isofs_get_block: block >= EOF (%"BLKOFF_FMT", %ld)\n",
 	       iblock, (unsigned long) inode->i_size);
 	goto abort;

 abort_too_many_sections:
 	printk("isofs_get_block: More than 100 file sections ?!?, aborting...\n");
-	printk("isofs_get_block: ino=%lu block=%ld firstext=%u sect_size=%u nextino=%lu\n",
+	printk("isofs_get_block: ino=%lu block=%" BLKOFF_FMT " firstext=%u sect_size=%u nextino=%lu\n",
 	       inode->i_ino, iblock, firstext, (unsigned) sect_size, nextino);
 	goto abort;
 }

-static int isofs_bmap(struct inode *inode, int block)
+static blkoff_t isofs_bmap(struct inode *inode, blkoff_t block)
 {
 	struct buffer_head dummy;
 	int error;
diff -ur /md0/kernels/2.4/v2.4.6-pre8/fs/minix/inode.c lb-2.4.6-pre8/fs/minix/inode.c
--- /md0/kernels/2.4/v2.4.6-pre8/fs/minix/inode.c	Thu May  3 11:22:16 2001
+++ lb-2.4.6-pre8/fs/minix/inode.c	Sat Jun 30 15:24:05 2001
@@ -350,7 +350,7 @@
 	return 0;
 }

-static int minix_get_block(struct inode *inode, long block,
+static int minix_get_block(struct inode *inode, blkoff_t block,
 		    struct buffer_head *bh_result, int create)
 {
 	if (INODE_VERSION(inode) == MINIX_V1)
diff -ur /md0/kernels/2.4/v2.4.6-pre8/fs/minix/itree_common.c lb-2.4.6-pre8/fs/minix/itree_common.c
--- /md0/kernels/2.4/v2.4.6-pre8/fs/minix/itree_common.c	Sat Jun 30 14:04:27 2001
+++ lb-2.4.6-pre8/fs/minix/itree_common.c	Sat Jun 30 14:22:13 2001
@@ -140,7 +140,7 @@
 	return -EAGAIN;
 }

-static inline int get_block(struct inode * inode, long block,
+static inline int get_block(struct inode * inode, blkoff_t block,
 			struct buffer_head *bh_result, int create)
 {
 	int err = -EIO;
diff -ur /md0/kernels/2.4/v2.4.6-pre8/fs/partitions/check.c lb-2.4.6-pre8/fs/partitions/check.c
--- /md0/kernels/2.4/v2.4.6-pre8/fs/partitions/check.c	Sat Jun 30 14:04:27 2001
+++ lb-2.4.6-pre8/fs/partitions/check.c	Sat Jun 30 14:22:13 2001
@@ -33,8 +33,6 @@
 #include "ibm.h"
 #include "ultrix.h"

-extern int *blk_size[];
-
 struct gendisk *gendisk_head;
 int warn_no_part = 1; /*This is ugly: should make genhd removable media aware*/

@@ -250,7 +248,7 @@
 				char buf[64];

 				len += sprintf(page + len,
-					       "%4d  %4d %10d %s\n",
+					       "%4d  %4d %10" BLKOFF_FMT " %s\n",
 					       dsk->major, n, dsk->sizes[n],
 					       disk_name(dsk, n, buf));
 				if (len < offset)
diff -ur /md0/kernels/2.4/v2.4.6-pre8/fs/qnx4/inode.c lb-2.4.6-pre8/fs/qnx4/inode.c
--- /md0/kernels/2.4/v2.4.6-pre8/fs/qnx4/inode.c	Thu May  3 11:22:17 2001
+++ lb-2.4.6-pre8/fs/qnx4/inode.c	Sat Jun 30 14:22:13 2001
@@ -204,7 +204,7 @@
 	return NULL;
 }

-int qnx4_get_block( struct inode *inode, long iblock, struct buffer_head *bh, int create )
+int qnx4_get_block( struct inode *inode, blkoff_t iblock, struct buffer_head *bh, int create )
 {
 	unsigned long phys;

diff -ur /md0/kernels/2.4/v2.4.6-pre8/fs/reiserfs/inode.c lb-2.4.6-pre8/fs/reiserfs/inode.c
--- /md0/kernels/2.4/v2.4.6-pre8/fs/reiserfs/inode.c	Sat Jun 30 14:04:27 2001
+++ lb-2.4.6-pre8/fs/reiserfs/inode.c	Sat Jun 30 15:32:52 2001
@@ -438,7 +438,7 @@

 // this is called to create file map. So, _get_block_create_0 will not
 // read direct item
-int reiserfs_bmap (struct inode * inode, long block,
+int reiserfs_bmap (struct inode * inode, blkoff_t block,
 		   struct buffer_head * bh_result, int create)
 {
     if (!file_capable (inode, block))
@@ -468,7 +468,7 @@
 ** don't want to send create == GET_BLOCK_NO_HOLE to reiserfs_get_block,
 ** don't use this function.
 */
-static int reiserfs_get_block_create_0 (struct inode * inode, long block,
+static int reiserfs_get_block_create_0 (struct inode * inode, blkoff_t block,
 			struct buffer_head * bh_result, int create) {
     return reiserfs_get_block(inode, block, bh_result, GET_BLOCK_NO_HOLE) ;
 }
@@ -559,7 +559,7 @@
 // determine which parts are derivative, if any, understanding that
 // there are only so many ways to code to a given interface.
 //
-int reiserfs_get_block (struct inode * inode, long block,
+int reiserfs_get_block (struct inode * inode, blkoff_t block,
 			struct buffer_head * bh_result, int create)
 {
     int repeat, retval;
diff -ur /md0/kernels/2.4/v2.4.6-pre8/fs/sysv/inode.c lb-2.4.6-pre8/fs/sysv/inode.c
--- /md0/kernels/2.4/v2.4.6-pre8/fs/sysv/inode.c	Sat Jun 30 14:04:27 2001
+++ lb-2.4.6-pre8/fs/sysv/inode.c	Sat Jun 30 14:22:13 2001
@@ -787,7 +787,7 @@
 	return result;
 }

-static int sysv_get_block(struct inode *inode, long iblock, struct buffer_head *bh_result, int create)
+static int sysv_get_block(struct inode *inode, blkoff_t iblock, struct buffer_head *bh_result, int create)
 {
 	struct super_block *sb;
 	int ret, err, new;
diff -ur /md0/kernels/2.4/v2.4.6-pre8/fs/udf/inode.c lb-2.4.6-pre8/fs/udf/inode.c
--- /md0/kernels/2.4/v2.4.6-pre8/fs/udf/inode.c	Sat Jun 30 14:04:27 2001
+++ lb-2.4.6-pre8/fs/udf/inode.c	Sat Jun 30 14:22:13 2001
@@ -56,7 +56,7 @@
 static void udf_update_extents(struct inode *,
 	long_ad [EXTENT_MERGE_SIZE], int, int,
 	lb_addr, Uint32, struct buffer_head **);
-static int udf_get_block(struct inode *, long, struct buffer_head *, int);
+static int udf_get_block(struct inode *, blkoff_t, struct buffer_head *, int);

 /*
  * udf_put_inode
@@ -311,7 +311,7 @@
 	return dbh;
 }

-static int udf_get_block(struct inode *inode, long block, struct buffer_head *bh_result, int create)
+static int udf_get_block(struct inode *inode, blkoff_t block, struct buffer_head *bh_result, int create)
 {
 	int err, new;
 	struct buffer_head *bh;
diff -ur /md0/kernels/2.4/v2.4.6-pre8/include/linux/blkdev.h lb-2.4.6-pre8/include/linux/blkdev.h
--- /md0/kernels/2.4/v2.4.6-pre8/include/linux/blkdev.h	Mon Jun 18 22:03:03 2001
+++ lb-2.4.6-pre8/include/linux/blkdev.h	Sun Jul  1 00:35:58 2001
@@ -1,6 +1,9 @@
 #ifndef _LINUX_BLKDEV_H
 #define _LINUX_BLKDEV_H

+#ifndef _LINUX_TYPES_H
+#include <linux/types.h>
+#endif
 #include <linux/major.h>
 #include <linux/sched.h>
 #include <linux/genhd.h>
@@ -33,9 +36,10 @@
 	kdev_t rq_dev;
 	int cmd;		/* READ or WRITE */
 	int errors;
-	unsigned long sector;
+	blkoff_t sector;
+	blkoff_t hard_sector;
 	unsigned long nr_sectors;
-	unsigned long hard_sector, hard_nr_sectors;
+	unsigned long hard_nr_sectors;
 	unsigned int nr_segments;
 	unsigned int nr_hw_segments;
 	unsigned long current_nr_sectors;
@@ -164,7 +168,7 @@
 extern void blk_queue_make_request(request_queue_t *, make_request_fn *);
 extern void generic_unplug_device(void *);

-extern int * blk_size[MAX_BLKDEV];
+extern blkoff_t * blk_size[MAX_BLKDEV];

 extern int * blksize_size[MAX_BLKDEV];

diff -ur /md0/kernels/2.4/v2.4.6-pre8/include/linux/fs.h lb-2.4.6-pre8/include/linux/fs.h
--- /md0/kernels/2.4/v2.4.6-pre8/include/linux/fs.h	Sat Jun 30 14:04:28 2001
+++ lb-2.4.6-pre8/include/linux/fs.h	Sun Jul  1 00:35:46 2001
@@ -188,6 +188,7 @@
 /* This was here just to show that the number is taken -
    probably all these _IO(0x12,*) ioctls should be moved to blkpg.h. */
 #endif
+#define BLKGETSIZE64 _IO(0x12,109)	/* return device size */


 #define BMAP_IOCTL 1		/* obsolete - kept for compatibility */
@@ -235,7 +236,7 @@
 struct buffer_head {
 	/* First cache line: */
 	struct buffer_head *b_next;	/* Hash queue list */
-	unsigned long b_blocknr;	/* block number */
+	blkoff_t b_blocknr;		/* block number */
 	unsigned short b_size;		/* block size */
 	unsigned short b_list;		/* List that this buffer appears */
 	kdev_t b_dev;			/* device (B_FREE = free) */
@@ -256,7 +257,7 @@
 	void (*b_end_io)(struct buffer_head *bh, int uptodate); /* I/O completion */
  	void *b_private;		/* reserved for b_end_io */

-	unsigned long b_rsector;	/* Real buffer location on disk */
+	blkoff_t b_rsector;		/* Real buffer location on disk */
 	wait_queue_head_t b_wait;

 	struct inode *	     b_inode;
@@ -1283,8 +1284,8 @@
 extern struct file * get_empty_filp(void);
 extern void file_move(struct file *f, struct list_head *list);
 extern void file_moveto(struct file *new, struct file *old);
-extern struct buffer_head * get_hash_table(kdev_t, int, int);
-extern struct buffer_head * getblk(kdev_t, int, int);
+extern struct buffer_head * get_hash_table(kdev_t, blkoff_t, int);
+extern struct buffer_head * getblk(kdev_t, blkoff_t, int);
 extern void ll_rw_block(int, int, struct buffer_head * bh[]);
 extern void submit_bh(int, struct buffer_head *);
 extern int is_read_only(kdev_t);
@@ -1301,12 +1302,12 @@
 		__bforget(buf);
 }
 extern void set_blocksize(kdev_t, int);
-extern struct buffer_head * bread(kdev_t, int, int);
+extern struct buffer_head * bread(kdev_t, blkoff_t, int);
 extern void wakeup_bdflush(int wait);

-extern int brw_page(int, struct page *, kdev_t, int [], int);
+extern int brw_page(int, struct page *, kdev_t, blkoff_t [], int);

-typedef int (get_block_t)(struct inode*,long,struct buffer_head*,int);
+typedef int (get_block_t)(struct inode*,blkoff_t,struct buffer_head*,int);

 /* Generic buffer handling for block filesystems.. */
 extern int block_flushpage(struct page *, unsigned long);
@@ -1318,7 +1319,7 @@
 				unsigned long *);
 extern int block_sync_page(struct page *);

-int generic_block_bmap(struct address_space *, long, get_block_t *);
+blkoff_t generic_block_bmap(struct address_space *, blkoff_t, get_block_t *);
 int generic_commit_write(struct file *, struct page *, unsigned, unsigned);
 int block_truncate_page(struct address_space *, loff_t, get_block_t *);

diff -ur /md0/kernels/2.4/v2.4.6-pre8/include/linux/genhd.h lb-2.4.6-pre8/include/linux/genhd.h
--- /md0/kernels/2.4/v2.4.6-pre8/include/linux/genhd.h	Mon Jun 18 22:03:03 2001
+++ lb-2.4.6-pre8/include/linux/genhd.h	Sun Jul  1 00:35:58 2001
@@ -48,8 +48,8 @@
 #  include <linux/devfs_fs_kernel.h>

 struct hd_struct {
-	long start_sect;
-	long nr_sects;
+	blkoff_t start_sect;
+	blkoff_t nr_sects;
 	devfs_handle_t de;              /* primary (master) devfs entry  */
 };

@@ -63,7 +63,7 @@
 	int max_p;			/* maximum partitions per device */

 	struct hd_struct *part;		/* [indexed by minor] */
-	int *sizes;			/* [idem], device size in blocks */
+	blkoff_t *sizes;		/* [idem], device size in blocks */
 	int nr_real;			/* number of real devices */

 	void *real_devices;		/* internal use */
diff -ur /md0/kernels/2.4/v2.4.6-pre8/include/linux/loop.h lb-2.4.6-pre8/include/linux/loop.h
--- /md0/kernels/2.4/v2.4.6-pre8/include/linux/loop.h	Thu Apr  5 11:53:45 2001
+++ lb-2.4.6-pre8/include/linux/loop.h	Sat Jun 30 23:40:35 2001
@@ -28,13 +28,13 @@
 	int		lo_number;
 	int		lo_refcnt;
 	kdev_t		lo_device;
-	int		lo_offset;
+	loff_t		lo_offset;
 	int		lo_encrypt_type;
 	int		lo_encrypt_key_size;
 	int		lo_flags;
 	int		(*transfer)(struct loop_device *, int cmd,
 				    char *raw_buf, char *loop_buf, int size,
-				    int real_block);
+				    blkoff_t real_block);
 	char		lo_name[LO_NAME_SIZE];
 	char		lo_encrypt_key[LO_KEY_SIZE];
 	__u32           lo_init[2];
@@ -98,7 +98,7 @@
 	dev_t		lo_device; 	/* ioctl r/o */
 	unsigned long	lo_inode; 	/* ioctl r/o */
 	dev_t		lo_rdevice; 	/* ioctl r/o */
-	int		lo_offset;
+	loff_t		lo_offset;
 	int		lo_encrypt_type;
 	int		lo_encrypt_key_size; 	/* ioctl w/o */
 	int		lo_flags;	/* ioctl r/o */
@@ -128,7 +128,7 @@
 struct loop_func_table {
 	int number; 	/* filter type */
 	int (*transfer)(struct loop_device *lo, int cmd, char *raw_buf,
-			char *loop_buf, int size, int real_block);
+			char *loop_buf, int size, blkoff_t real_block);
 	int (*init)(struct loop_device *, struct loop_info *);
 	/* release is called from loop_unregister_transfer or clr_fd */
 	int (*release)(struct loop_device *);
diff -ur /md0/kernels/2.4/v2.4.6-pre8/include/linux/msdos_fs.h lb-2.4.6-pre8/include/linux/msdos_fs.h
--- /md0/kernels/2.4/v2.4.6-pre8/include/linux/msdos_fs.h	Sat Jun 30 15:18:45 2001
+++ lb-2.4.6-pre8/include/linux/msdos_fs.h	Sat Jun 30 18:02:53 2001
@@ -241,7 +241,7 @@
 /* inode.c */
 extern void fat_hash_init(void);
 extern int fat_bmap(struct inode *inode,int block);
-extern int fat_get_block(struct inode *, long, struct buffer_head *, int);
+extern int fat_get_block(struct inode *, blkoff_t, struct buffer_head *, int);
 extern int fat_notify_change(struct dentry *, struct iattr *);
 extern void fat_clear_inode(struct inode *inode);
 extern void fat_delete_inode(struct inode *inode);
diff -ur /md0/kernels/2.4/v2.4.6-pre8/include/linux/qnx4_fs.h lb-2.4.6-pre8/include/linux/qnx4_fs.h
--- /md0/kernels/2.4/v2.4.6-pre8/include/linux/qnx4_fs.h	Thu Jun 29 18:53:42 2000
+++ lb-2.4.6-pre8/include/linux/qnx4_fs.h	Sat Jun 30 15:24:47 2001
@@ -118,7 +118,7 @@
 extern int qnx4_rmdir(struct inode *dir, struct dentry *dentry);
 extern int qnx4_sync_file(struct file *file, struct dentry *dentry, int);
 extern int qnx4_sync_inode(struct inode *inode);
-extern int qnx4_get_block(struct inode *inode, long iblock, struct buffer_head *bh, int create);
+extern int qnx4_get_block(struct inode *inode, blkoff_t iblock, struct buffer_head *bh, int create);

 #endif				/* __KERNEL__ */

diff -ur /md0/kernels/2.4/v2.4.6-pre8/include/linux/raid/linear.h lb-2.4.6-pre8/include/linux/raid/linear.h
--- /md0/kernels/2.4/v2.4.6-pre8/include/linux/raid/linear.h	Tue Jun 19 13:32:19 2001
+++ lb-2.4.6-pre8/include/linux/raid/linear.h	Sun Jul  1 00:36:41 2001
@@ -5,8 +5,8 @@

 struct dev_info {
 	kdev_t		dev;
-	unsigned long	size;
-	unsigned long	offset;
+	blkoff_t	size;
+	blkoff_t	offset;
 };

 typedef struct dev_info dev_info_t;
diff -ur /md0/kernels/2.4/v2.4.6-pre8/include/linux/raid/md.h lb-2.4.6-pre8/include/linux/raid/md.h
--- /md0/kernels/2.4/v2.4.6-pre8/include/linux/raid/md.h	Sat Jun 30 02:27:33 2001
+++ lb-2.4.6-pre8/include/linux/raid/md.h	Sun Jul  1 00:35:59 2001
@@ -58,7 +58,7 @@
 #define MD_MINOR_VERSION                90
 #define MD_PATCHLEVEL_VERSION           0

-extern int md_size[MAX_MD_DEVS];
+extern blkoff_t md_size[MAX_MD_DEVS];
 extern struct hd_struct md_hd_struct[MAX_MD_DEVS];

 extern void add_mddev_mapping (mddev_t *mddev, kdev_t dev, void *data);
diff -ur /md0/kernels/2.4/v2.4.6-pre8/include/linux/raid/md_k.h lb-2.4.6-pre8/include/linux/raid/md_k.h
--- /md0/kernels/2.4/v2.4.6-pre8/include/linux/raid/md_k.h	Fri May 25 22:48:10 2001
+++ lb-2.4.6-pre8/include/linux/raid/md_k.h	Sat Jun 30 14:22:13 2001
@@ -162,14 +162,14 @@

 	kdev_t dev;			/* Device number */
 	kdev_t old_dev;			/*  "" when it was last imported */
-	unsigned long size;		/* Device size (in blocks) */
+	blkoff_t size;		/* Device size (in blocks) */
 	mddev_t *mddev;			/* RAID array if running */
 	unsigned long last_events;	/* IO event timestamp */

 	struct block_device *bdev;	/* block device handle */

 	mdp_super_t *sb;
-	unsigned long sb_offset;
+	blkoff_t sb_offset;

 	int faulty;			/* if faulty do not issue IO requests */
 	int desc_nr;			/* descriptor index in the superblock */
@@ -237,7 +237,7 @@

 	int (*stop_resync)(mddev_t *mddev);
 	int (*restart_resync)(mddev_t *mddev);
-	int (*sync_request)(mddev_t *mddev, unsigned long block_nr);
+	int (*sync_request)(mddev_t *mddev, blkoff_t block_nr);
 };


diff -ur /md0/kernels/2.4/v2.4.6-pre8/include/linux/raid/raid0.h lb-2.4.6-pre8/include/linux/raid/raid0.h
--- /md0/kernels/2.4/v2.4.6-pre8/include/linux/raid/raid0.h	Tue Jun 19 13:32:19 2001
+++ lb-2.4.6-pre8/include/linux/raid/raid0.h	Sun Jul  1 00:36:41 2001
@@ -5,9 +5,9 @@

 struct strip_zone
 {
-	unsigned long zone_offset;	/* Zone offset in md_dev */
-	unsigned long dev_offset;	/* Zone offset in real dev */
-	unsigned long size;		/* Zone size */
+	blkoff_t zone_offset;	/* Zone offset in md_dev */
+	blkoff_t dev_offset;	/* Zone offset in real dev */
+	blkoff_t size;		/* Zone size */
 	int nb_dev;			/* # of devices attached to the zone */
 	mdk_rdev_t *dev[MD_SB_DISKS]; /* Devices attached to the zone */
 };
diff -ur /md0/kernels/2.4/v2.4.6-pre8/include/linux/raid/raid1.h lb-2.4.6-pre8/include/linux/raid/raid1.h
--- /md0/kernels/2.4/v2.4.6-pre8/include/linux/raid/raid1.h	Tue Jun 19 13:32:19 2001
+++ lb-2.4.6-pre8/include/linux/raid/raid1.h	Sun Jul  1 00:36:41 2001
@@ -7,8 +7,8 @@
 	int		number;
 	int		raid_disk;
 	kdev_t		dev;
-	int		sect_limit;
-	int		head_position;
+	blkoff_t	sect_limit;
+	blkoff_t	head_position;

 	/*
 	 * State bits:
@@ -27,7 +27,7 @@
 	int			raid_disks;
 	int			working_disks;
 	int			last_used;
-	unsigned long		next_sect;
+	blkoff_t		next_sect;
 	int			sect_count;
 	mdk_thread_t		*thread, *resync_thread;
 	int			resync_mirrors;
@@ -47,7 +47,7 @@
 	md_wait_queue_head_t	wait_buffer;

 	/* for use when syncing mirrors: */
-	unsigned long	start_active, start_ready,
+	blkoff_t	start_active, start_ready,
 		start_pending, start_future;
 	int	cnt_done, cnt_active, cnt_ready,
 		cnt_pending, cnt_future;
diff -ur /md0/kernels/2.4/v2.4.6-pre8/include/linux/raid/raid5.h lb-2.4.6-pre8/include/linux/raid/raid5.h
--- /md0/kernels/2.4/v2.4.6-pre8/include/linux/raid/raid5.h	Sat Jun 30 14:04:28 2001
+++ lb-2.4.6-pre8/include/linux/raid/raid5.h	Sun Jul  1 00:36:44 2001
@@ -133,7 +133,7 @@
 	struct buffer_head	*bh_write[MD_SB_DISKS];	/* write request buffers of the MD device */
 	struct buffer_head	*bh_written[MD_SB_DISKS]; /* write request buffers of the MD device that have been scheduled for write */
 	struct page		*bh_page[MD_SB_DISKS];	/* saved bh_cache[n]->b_page when reading around the cache */
-	unsigned long		sector;			/* sector of this row */
+	blkoff_t		sector;			/* sector of this row */
 	int			size;			/* buffers size */
 	int			pd_idx;			/* parity disk index */
 	unsigned long		state;			/* state flags */
diff -ur /md0/kernels/2.4/v2.4.6-pre8/include/linux/reiserfs_fs.h lb-2.4.6-pre8/include/linux/reiserfs_fs.h
--- /md0/kernels/2.4/v2.4.6-pre8/include/linux/reiserfs_fs.h	Sat Jun 30 15:28:41 2001
+++ lb-2.4.6-pre8/include/linux/reiserfs_fs.h	Sat Jun 30 18:03:54 2001
@@ -1797,7 +1797,7 @@
 			       loff_t offset, int type, int length, int entry_count);
 /*void store_key (struct key * key);
 void forget_key (struct key * key);*/
-int reiserfs_get_block (struct inode * inode, long block,
+int reiserfs_get_block (struct inode * inode, blkoff_t block,
 			struct buffer_head * bh_result, int create);
 struct inode * reiserfs_iget (struct super_block * s, struct cpu_key * key);
 void reiserfs_read_inode (struct inode * inode) ;
diff -ur /md0/kernels/2.4/v2.4.6-pre8/include/linux/types.h lb-2.4.6-pre8/include/linux/types.h
--- /md0/kernels/2.4/v2.4.6-pre8/include/linux/types.h	Tue Jun 19 00:54:47 2001
+++ lb-2.4.6-pre8/include/linux/types.h	Sat Jun 30 15:37:56 2001
@@ -3,6 +3,14 @@

 #ifdef	__KERNEL__
 #include <linux/config.h>
+
+#if defined(CONFIG_BLKOFF_LONGLONG)
+#define BLKOFF_FMT	"Lu"
+typedef unsigned long long	blkoff_t;
+#else
+#define BLKOFF_FMT	"lu"
+typedef unsigned long		blkoff_t;
+#endif
 #endif

 #include <linux/posix_types.h>
diff -ur /md0/kernels/2.4/v2.4.6-pre8/mm/page_io.c lb-2.4.6-pre8/mm/page_io.c
--- /md0/kernels/2.4/v2.4.6-pre8/mm/page_io.c	Thu May  3 11:22:20 2001
+++ lb-2.4.6-pre8/mm/page_io.c	Sat Jun 30 14:22:13 2001
@@ -36,7 +36,7 @@
 static int rw_swap_page_base(int rw, swp_entry_t entry, struct page *page)
 {
 	unsigned long offset;
-	int zones[PAGE_SIZE/512];
+	blkoff_t zones[PAGE_SIZE/512];
 	int zones_used;
 	kdev_t dev = 0;
 	int block_size;

