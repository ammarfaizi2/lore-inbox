Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292399AbSBPQK0>; Sat, 16 Feb 2002 11:10:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292405AbSBPQKS>; Sat, 16 Feb 2002 11:10:18 -0500
Received: from hera.cwi.nl ([192.16.191.8]:38119 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S292404AbSBPQJ4>;
	Sat, 16 Feb 2002 11:09:56 -0500
From: Andries.Brouwer@cwi.nl
Date: Sat, 16 Feb 2002 16:09:51 GMT
Message-Id: <UTC200202161609.QAA31164.aeb@cwi.nl>
To: torvalds@transmeta.com
Subject: [PATCH] size-in-bytes
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just rediffed the size-in-bytes patch against 2.5.5pre1.
The result is found at ftp.kernel.org
(under 02-2.5.5pre1-sizeinbytes-bsd), and below.

Comment:
Disk and partition size is kept several places, sometimes
in sectors (of 512 bytes), sometimes in blocks (of 1024 bytes).
This is ugly, one finds a lot of shifting left and right, as in
	limit = (size << BLOCK_SIZE_BITS) >> sector_bits;
and inconvenient (some places where one really needs info
in sectors only info in blocks is available; strange kludges
are needed to access the last sector of the disk, as needed for EFI),
and insufficient (disk manufacturers say we'll have 2+TB disks
three years from now, and 2+TB RAIDs exist today).

The patch below introduces the routine blkdev_size_in_bytes()
that provides device size in a loff_t. Today that is done via
the array blk_size_in_bytes[] that is to replace the array blk_size[].
Of course the array is to disappear again. Whatever one might have
planned for blk_size[] also applies to blk_size_in_bytes[].
(For me it is a field in the structure pointed at by a kdev_t.)

Thrown in is a BSD partition handling fix.

Andries


diff -u --recursive --new-file ../linux-2.5.5pre1/linux/drivers/block/blkpg.c ./linux/drivers/block/blkpg.c
--- ../linux-2.5.5pre1/linux/drivers/block/blkpg.c	Thu Feb 14 02:11:01 2002
+++ ./linux/drivers/block/blkpg.c	Thu Feb 14 03:44:45 2002
@@ -203,7 +203,6 @@
 int blk_ioctl(kdev_t dev, unsigned int cmd, unsigned long arg)
 {
 	request_queue_t *q;
-	struct gendisk *g;
 	u64 ullval = 0;
 	int intval, *iptr;
 	unsigned short usval;
@@ -268,20 +267,18 @@
 			return 0;
 
 		case BLKSSZGET:
-			/* get block device sector size as needed e.g. by fdisk */
+			/* get block device hardware sector size */
 			intval = get_hardsect_size(dev);
 			return put_user(intval, (int *) arg);
 
 		case BLKGETSIZE:
+			/* size in sectors, works up to 2 TB */
+			ullval = blkdev_size_in_bytes(dev);
+			return put_user((unsigned long)(ullval >> 9), (unsigned long *) arg);
 		case BLKGETSIZE64:
-			g = get_gendisk(dev);
-			if (g)
-				ullval = g->part[minor(dev)].nr_sects;
-
-			if (cmd == BLKGETSIZE)
-				return put_user((unsigned long)ullval, (unsigned long *)arg);
-			else
-				return put_user((u64)ullval << 9 , (u64 *)arg);
+			/* size in bytes */
+			ullval = blkdev_size_in_bytes(dev);
+			return put_user(ullval, (u64 *) arg);
 #if 0
 		case BLKRRPART: /* Re-read partition tables */
 			if (!capable(CAP_SYS_ADMIN)) 
diff -u --recursive --new-file ../linux-2.5.5pre1/linux/drivers/block/ll_rw_blk.c ./linux/drivers/block/ll_rw_blk.c
--- ../linux-2.5.5pre1/linux/drivers/block/ll_rw_blk.c	Thu Feb 14 02:11:44 2002
+++ ./linux/drivers/block/ll_rw_blk.c	Thu Feb 14 02:49:02 2002
@@ -66,7 +66,7 @@
 
 /*
  * blk_size contains the size of all block-devices in units of 1024 byte
- * sectors:
+ * blocks; it is obsoleted by blk_size_in_bytes
  *
  * blk_size[MAJOR][MINOR]
  *
@@ -75,6 +75,17 @@
 int * blk_size[MAX_BLKDEV];
 
 /*
+ * blk_size_in_bytes contains the size of all block-devices in bytes
+ * (blk_size has too low a resolution, since we really need the size
+ * in 512 byte sectors, and fails on devices > 2 TB)
+ *
+ * blk_size_in_bytes[MAJOR][MINOR]
+ *
+ * if (!blk_size_in_bytes[MAJOR]) then no minor size checking is done.
+ */
+loff_t * blk_size_in_bytes[MAX_BLKDEV];
+
+/*
  * blksize_size contains the size of all block-devices:
  *
  * blksize_size[MAJOR][MINOR]
@@ -1283,32 +1294,27 @@
  * */
 void generic_make_request(struct bio *bio)
 {
-	int major = major(bio->bi_dev);
-	int minor = minor(bio->bi_dev);
 	request_queue_t *q;
-	sector_t minorsize = 0;
+	sector_t maxsector;
 	int ret, nr_sectors = bio_sectors(bio);
 
 	/* Test device or partition size, when known. */
-	if (blk_size[major])
-		minorsize = blk_size[major][minor];
-	if (minorsize) {
-		unsigned long maxsector = (minorsize << 1) + 1;
-		unsigned long sector = bio->bi_sector;
-
-		if (maxsector < nr_sectors || maxsector - nr_sectors < sector) {
-			if (blk_size[major][minor]) {
-				
-				/* This may well happen - the kernel calls
-				 * bread() without checking the size of the
-				 * device, e.g., when mounting a device. */
-				printk(KERN_INFO
-				       "attempt to access beyond end of device\n");
-				printk(KERN_INFO "%s: rw=%ld, want=%ld, limit=%Lu\n",
-				       kdevname(bio->bi_dev), bio->bi_rw,
-				       (sector + nr_sectors)>>1,
-				       (long long) blk_size[major][minor]);
-			}
+	maxsector = (blkdev_size_in_bytes(bio->bi_dev) >> 9);
+	if (maxsector) {
+		sector_t sector = bio->bi_sector;
+
+		if (maxsector < nr_sectors ||
+		    maxsector - nr_sectors < sector) {
+			/* This may well happen - the kernel calls
+			 * bread() without checking the size of the
+			 * device, e.g., when mounting a device. */
+			printk(KERN_INFO
+			       "attempt to access beyond end of device\n");
+			printk(KERN_INFO "%s: rw=%ld, want=%ld, limit=%Lu\n",
+			       kdevname(bio->bi_dev), bio->bi_rw,
+			       sector + nr_sectors,
+			       (long long) maxsector);
+
 			set_bit(BIO_EOF, &bio->bi_flags);
 			goto end_io;
 		}
diff -u --recursive --new-file ../linux-2.5.5pre1/linux/drivers/block/loop.c ./linux/drivers/block/loop.c
--- ../linux-2.5.5pre1/linux/drivers/block/loop.c	Thu Feb 14 02:11:44 2002
+++ ./linux/drivers/block/loop.c	Thu Feb 14 02:49:02 2002
@@ -151,14 +151,20 @@
 
 #define MAX_DISK_SIZE 1024*1024*1024
 
-static unsigned long compute_loop_size(struct loop_device *lo, struct dentry * lo_dentry, kdev_t lodev)
+static unsigned long
+compute_loop_size(struct loop_device *lo,
+		  struct dentry * lo_dentry, kdev_t lodev)
 {
-	if (S_ISREG(lo_dentry->d_inode->i_mode))
-		return (lo_dentry->d_inode->i_size - lo->lo_offset) >> BLOCK_SIZE_BITS;
-	if (blk_size[major(lodev)])
-		return blk_size[major(lodev)][minor(lodev)] -
-                                (lo->lo_offset >> BLOCK_SIZE_BITS);
-	return MAX_DISK_SIZE;
+	loff_t size = 0;
+
+	if (S_ISREG(lo_dentry->d_inode->i_mode)) {
+		size = lo_dentry->d_inode->i_size;
+	} else {
+		size = blkdev_size_in_bytes(lodev);
+		if (size == 0)
+			return MAX_DISK_SIZE;
+	}
+	return (size - lo->lo_offset) >> BLOCK_SIZE_BITS;
 }
 
 static void figure_loop_size(struct loop_device *lo)
diff -u --recursive --new-file ../linux-2.5.5pre1/linux/drivers/block/rd.c ./linux/drivers/block/rd.c
--- ../linux-2.5.5pre1/linux/drivers/block/rd.c	Thu Feb 14 02:08:52 2002
+++ ./linux/drivers/block/rd.c	Thu Feb 14 02:49:02 2002
@@ -300,19 +300,13 @@
 			}
 			up(&inode->i_bdev->bd_sem);
 			break;
-         	case BLKGETSIZE:   /* Return device size */
-			if (!arg)
-				break;
-			error = put_user(rd_kbsize[minor] << 1, (unsigned long *) arg);
-			break;
+         	case BLKGETSIZE:
          	case BLKGETSIZE64:
-			error = put_user((u64)rd_kbsize[minor]<<10, (u64*)arg);
-			break;
 		case BLKROSET:
 		case BLKROGET:
 		case BLKSSZGET:
 			error = blk_ioctl(inode->i_rdev, cmd, arg);
-	};
+	}
 out:
 	return error;
 }
@@ -418,11 +412,10 @@
 /* This is the registration and initialization section of the RAM disk driver */
 static int __init rd_init (void)
 {
-	int		i;
+	int i;
 
 	if (rd_blocksize > PAGE_SIZE || rd_blocksize < 512 ||
-	    (rd_blocksize & (rd_blocksize-1)))
-	{
+	    (rd_blocksize & (rd_blocksize-1))) {
 		printk("RAMDISK: wrong blocksize %d, reverting to defaults\n",
 		       rd_blocksize);
 		rd_blocksize = BLOCK_SIZE;
@@ -449,7 +442,8 @@
 			       &rd_bd_op, NULL);
 
 	for (i = 0; i < NUM_RAMDISKS; i++)
-		register_disk(NULL, mk_kdev(MAJOR_NR,i), 1, &rd_bd_op, rd_size<<1);
+		register_disk(NULL, mk_kdev(MAJOR_NR,i), 1, &rd_bd_op,
+			      rd_size<<1);
 
 #ifdef CONFIG_BLK_DEV_INITRD
 	/* We ought to separate initrd operations here */
@@ -458,10 +452,10 @@
 			INITRD_MINOR, S_IFBLK | S_IRUSR, &rd_bd_op, NULL);
 #endif
 
-	blksize_size[MAJOR_NR] = rd_blocksizes;		/* Avoid set_blocksize() check */
-	blk_size[MAJOR_NR] = rd_kbsize;			/* Size of the RAM disk in kB  */
+	blksize_size[MAJOR_NR] = rd_blocksizes;	/* Avoid set_blocksize() check */
+	blk_size[MAJOR_NR] = rd_kbsize;		/* Size of the RAM disk in kB  */
 
-		/* rd_size is given in kB */
+	/* rd_size is given in kB */
 	printk("RAMDISK driver initialized: "
 	       "%d RAM disks of %dK size %d blocksize\n",
 	       NUM_RAMDISKS, rd_size, rd_blocksize);
diff -u --recursive --new-file ../linux-2.5.5pre1/linux/drivers/char/raw.c ./linux/drivers/char/raw.c
--- ../linux-2.5.5pre1/linux/drivers/char/raw.c	Thu Feb 14 02:08:56 2002
+++ ./linux/drivers/char/raw.c	Thu Feb 14 02:49:02 2002
@@ -289,11 +289,10 @@
 	dev = to_kdev_t(raw_devices[minor].binding->bd_dev);
 	sector_size = raw_devices[minor].sector_size;
 	sector_bits = raw_devices[minor].sector_bits;
-	sector_mask = sector_size- 1;
-	
-	if (blk_size[major(dev)])
-		limit = (((loff_t) blk_size[major(dev)][minor(dev)]) << BLOCK_SIZE_BITS) >> sector_bits;
-	else
+	sector_mask = sector_size - 1;
+
+	limit = blkdev_size_in_bytes(dev) >> sector_bits;
+	if (!limit)
 		limit = INT_MAX;
 	dprintk ("rw_raw_dev: dev %d:%d (+%d)\n",
 		 major(dev), minor(dev), limit);
diff -u --recursive --new-file ../linux-2.5.5pre1/linux/drivers/ide/ide-probe.c ./linux/drivers/ide/ide-probe.c
--- ../linux-2.5.5pre1/linux/drivers/ide/ide-probe.c	Thu Feb 14 02:10:05 2002
+++ ./linux/drivers/ide/ide-probe.c	Thu Feb 14 02:49:02 2002
@@ -790,6 +790,7 @@
 	struct gendisk *gd;
 	unsigned int unit, units, minors;
 	int *bs, *max_ra;
+	loff_t *byteszs;
 	extern devfs_handle_t ide_devfs_handle;
 
 #if 1
@@ -818,10 +819,14 @@
 	max_ra    = kmalloc (minors*sizeof(int), GFP_KERNEL);
 	if (!max_ra)
 		goto err_kmalloc_max_ra;
+	byteszs   = kmalloc(minors * sizeof(loff_t), GFP_KERNEL);
+	if (!byteszs)
+		goto err_kmalloc_byteszs;
 
 	memset(gd->part, 0, minors * sizeof(struct hd_struct));
 
 	/* cdroms and msdos f/s are examples of non-1024 blocksizes */
+	blk_size_in_bytes[hwif->major] = byteszs;
 	blksize_size[hwif->major] = bs;
 	max_readahead[hwif->major] = max_ra;
 	for (unit = 0; unit < minors; ++unit) {
@@ -875,6 +880,8 @@
 	}
 	return;
 
+err_kmalloc_byteszs:
+	kfree(max_ra);
 err_kmalloc_max_ra:
 	kfree(bs);
 err_kmalloc_bs:
diff -u --recursive --new-file ../linux-2.5.5pre1/linux/drivers/ide/ide.c ./linux/drivers/ide/ide.c
--- ../linux-2.5.5pre1/linux/drivers/ide/ide.c	Thu Feb 14 02:11:05 2002
+++ ./linux/drivers/ide/ide.c	Thu Feb 14 02:49:02 2002
@@ -2125,6 +2125,7 @@
 	 * Remove us from the kernel's knowledge
 	 */
 	unregister_blkdev(hwif->major, hwif->name);
+	kfree(blk_size_in_bytes[hwif->major]);
 	kfree(blksize_size[hwif->major]);
 	kfree(max_readahead[hwif->major]);
 	blk_dev[hwif->major].data = NULL;
diff -u --recursive --new-file ../linux-2.5.5pre1/linux/drivers/md/md.c ./linux/drivers/md/md.c
--- ../linux-2.5.5pre1/linux/drivers/md/md.c	Thu Feb 14 02:10:10 2002
+++ ./linux/drivers/md/md.c	Thu Feb 14 02:49:02 2002
@@ -283,10 +283,7 @@
 static unsigned int calc_dev_sboffset(kdev_t dev, mddev_t *mddev,
 						int persistent)
 {
-	unsigned int size = 0;
-
-	if (blk_size[major(dev)])
-		size = blk_size[major(dev)][minor(dev)];
+	unsigned int size = (blkdev_size_in_bytes(dev) >> BLOCK_SIZE_BITS);
 	if (persistent)
 		size = MD_NEW_SIZE_BLOCKS(size);
 	return size;
@@ -1105,12 +1102,11 @@
 	rdev->desc_nr = -1;
 	rdev->faulty = 0;
 
-	size = 0;
-	if (blk_size[major(newdev)])
-		size = blk_size[major(newdev)][minor(newdev)];
+	size = (blkdev_size_in_bytes(newdev) >> BLOCK_SIZE_BITS);
 	if (!size) {
-		printk(KERN_WARNING "md: %s has zero size, marking faulty!\n",
-				partition_name(newdev));
+		printk(KERN_WARNING
+		       "md: %s has zero or unknown size, marking faulty!\n",
+		       partition_name(newdev));
 		err = -EINVAL;
 		goto abort_free;
 	}
diff -u --recursive --new-file ../linux-2.5.5pre1/linux/drivers/mtd/devices/blkmtd.c ./linux/drivers/mtd/devices/blkmtd.c
--- ../linux-2.5.5pre1/linux/drivers/mtd/devices/blkmtd.c	Thu Feb 14 02:11:44 2002
+++ ./linux/drivers/mtd/devices/blkmtd.c	Thu Feb 14 02:49:02 2002
@@ -62,7 +62,6 @@
 /* Default erase size in K, always make it a multiple of PAGE_SIZE */
 #define CONFIG_MTD_BLKDEV_ERASESIZE 128
 #define VERSION "1.1"
-extern int *blk_size[];
 
 /* Info for the block device */
 typedef struct mtd_raw_dev_data_s {
@@ -848,7 +847,7 @@
   mtd_raw_dev_data_t *rawdevice = NULL;
   int maj, min;
   int i, blocksize, blocksize_bits;
-  loff_t size = 0;
+  loff_t size;
   int readonly = 0;
   int erase_size = CONFIG_MTD_BLKDEV_ERASESIZE;
   kdev_t rdev;
@@ -911,13 +910,8 @@
     i >>= 1;
   }
 
-  if(count) {
-    size = count;
-  } else {
-    if (blk_size[maj]) {
-      size = ((loff_t) blk_size[maj][min] << BLOCK_SIZE_BITS) >> blocksize_bits;
-    }
-  }
+  size = (count ? count : (blkdev_size_in_bytes(rdev) >> blocksize_bits));
+
   total_sectors = size;
   size *= blocksize;
   totalsize = size;
diff -u --recursive --new-file ../linux-2.5.5pre1/linux/drivers/s390/block/xpram.c ./linux/drivers/s390/block/xpram.c
--- ../linux-2.5.5pre1/linux/drivers/s390/block/xpram.c	Thu Feb 14 02:09:07 2002
+++ ./linux/drivers/s390/block/xpram.c	Thu Feb 14 02:49:02 2002
@@ -1065,7 +1065,7 @@
 		for (i=0; i < xpram_devs; i++) 
 			if (xpram_sizes[i] == 0) xpram_sizes[i] = mem_auto;
 	}
-	blk_size[major]=xpram_sizes;
+	blk_size[major] = xpram_sizes;
 
 	xpram_offsets = kmalloc(xpram_devs * sizeof(int), GFP_KERNEL);
 	if (!xpram_offsets) {
diff -u --recursive --new-file ../linux-2.5.5pre1/linux/drivers/usb/storage/dpcm.c ./linux/drivers/usb/storage/dpcm.c
--- ../linux-2.5.5pre1/linux/drivers/usb/storage/dpcm.c	Mon Jul 30 06:11:50 2001
+++ ./linux/drivers/usb/storage/dpcm.c	Thu Feb 14 02:49:02 2002
@@ -43,8 +43,6 @@
  */
 int dpcm_transport(Scsi_Cmnd *srb, struct us_data *us)
 {
-  int ret;
-
   if(srb == NULL)
     return USB_STOR_TRANSPORT_ERROR;
 
@@ -60,6 +58,8 @@
 
 #ifdef CONFIG_USB_STORAGE_SDDR09
   case 1:
+  {
+    int ret;
 
     /*
      * LUN 1 corresponds to the SmartMedia card reader.
@@ -73,6 +73,7 @@
     srb->lun = 1; us->srb->lun = 1;
 
     return ret;
+  }
 #endif
 
   default:
diff -u --recursive --new-file ../linux-2.5.5pre1/linux/fs/affs/super.c ./linux/fs/affs/super.c
--- ../linux-2.5.5pre1/linux/fs/affs/super.c	Thu Feb 14 02:11:16 2002
+++ ./linux/fs/affs/super.c	Thu Feb 14 02:49:02 2002
@@ -29,7 +29,6 @@
 #include <asm/system.h>
 #include <asm/uaccess.h>
 
-extern int *blk_size[];
 extern struct timezone sys_tz;
 
 static int affs_statfs(struct super_block *sb, struct statfs *buf);
@@ -308,7 +307,7 @@
 	 */
 
 	size = sb->s_bdev->bd_inode->i_size >> 9;
-	pr_debug("AFFS: initial blksize=%d, blocks=%d\n", 512, blocks);
+	pr_debug("AFFS: initial blocksize=%d, #blocks=%d\n", 512, size);
 
 	affs_set_blocksize(sb, PAGE_SIZE);
 	/* Try to find root block. Its location depends on the block size. */
diff -u --recursive --new-file ../linux-2.5.5pre1/linux/fs/block_dev.c ./linux/fs/block_dev.c
--- ../linux-2.5.5pre1/linux/fs/block_dev.c	Thu Feb 14 02:11:17 2002
+++ ./linux/fs/block_dev.c	Thu Feb 14 02:49:02 2002
@@ -27,33 +27,22 @@
 static unsigned long max_block(kdev_t dev)
 {
 	unsigned int retval = ~0U;
-	int major = major(dev);
+	loff_t sz = blkdev_size_in_bytes(dev);
 
-	if (blk_size[major]) {
-		int minor = minor(dev);
-		unsigned int blocks = blk_size[major][minor];
-		if (blocks) {
-			unsigned int size = block_size(dev);
-			unsigned int sizebits = blksize_bits(size);
-			blocks += (size-1) >> BLOCK_SIZE_BITS;
-			retval = blocks << (BLOCK_SIZE_BITS - sizebits);
-			if (sizebits > BLOCK_SIZE_BITS)
-				retval = blocks >> (sizebits - BLOCK_SIZE_BITS);
-		}
+	if (sz) {
+		unsigned int size = block_size(dev);
+		unsigned int sizebits = blksize_bits(size);
+		retval = (sz >> sizebits);
 	}
 	return retval;
 }
 
 static loff_t blkdev_size(kdev_t dev)
 {
-	unsigned int blocks = ~0U;
-	int major = major(dev);
-
-	if (blk_size[major]) {
-		int minor = minor(dev);
-		blocks = blk_size[major][minor];
-	}
-	return (loff_t) blocks << BLOCK_SIZE_BITS;
+	loff_t sz = blkdev_size_in_bytes(dev);
+	if (sz)
+		return sz;
+	return ~0ULL;
 }
 
 /* Kill _all_ buffers, dirty or not.. */
diff -u --recursive --new-file ../linux-2.5.5pre1/linux/fs/cramfs/inode.c ./linux/fs/cramfs/inode.c
--- ../linux-2.5.5pre1/linux/fs/cramfs/inode.c	Thu Feb 14 02:12:12 2002
+++ ./linux/fs/cramfs/inode.c	Thu Feb 14 02:49:02 2002
@@ -116,8 +116,6 @@
 	struct buffer_head * read_array[BLKS_PER_BUF];
 	unsigned i, blocknr, buffer, unread;
 	unsigned long devsize;
-	unsigned int major, minor;
-	
 	char *data;
 
 	if (!len)
@@ -140,12 +138,9 @@
 		return read_buffers[i] + blk_offset;
 	}
 
-	devsize = ~0UL;
-	major = major(sb->s_dev);
-	minor = minor(sb->s_dev);
-
-	if (blk_size[major])
-		devsize = blk_size[major][minor] >> 2;
+	devsize = blkdev_size_in_bytes(sb->s_dev) >> 12;
+	if (!devsize)
+		devsize = ~0UL;
 
 	/* Ok, read in BLKS_PER_BUF pages completely first. */
 	unread = 0;
diff -u --recursive --new-file ../linux-2.5.5pre1/linux/fs/partitions/check.c ./linux/fs/partitions/check.c
--- ../linux-2.5.5pre1/linux/fs/partitions/check.c	Thu Feb 14 02:09:28 2002
+++ ./linux/fs/partitions/check.c	Thu Feb 14 02:49:02 2002
@@ -416,9 +416,19 @@
 		for (i = first_minor; i < end_minor; i++)
 			g->sizes[i] = g->part[i].nr_sects >> (BLOCK_SIZE_BITS - 9);
 	}
+
+	/*
+	 * In case the device provided an array blk_size_in_bytes[], fill it.
+	 */
+	if (g->sizes != NULL && blk_size_in_bytes[g->major] != NULL) {
+		for (i = first_minor; i < end_minor; i++)
+			blk_size_in_bytes[g->major][i] =
+				((loff_t) g->part[i].nr_sects << 9);
+	}
 }
 
-unsigned char *read_dev_sector(struct block_device *bdev, unsigned long n, Sector *p)
+unsigned char *
+read_dev_sector(struct block_device *bdev, unsigned long n, Sector *p)
 {
 	struct address_space *mapping = bdev->bd_inode->i_mapping;
 	int sect = PAGE_CACHE_SIZE / 512;
@@ -480,3 +490,28 @@
 
 	return 0;
 }
+
+/*
+ * Make sure that a proposed subpartition is strictly contained inside
+ * the parent partition.  If all is well, call add_gd_partition().
+ */
+int
+check_and_add_subpartition(struct gendisk *hd, int super_minor, int minor,
+			   int sub_start, int sub_size)
+{
+	int start = hd->part[super_minor].start_sect;
+	int size = hd->part[super_minor].nr_sects;
+
+	if (start == sub_start && size == sub_size) {
+		/* full parent partition, we have it already */
+		return 0;
+	}
+
+	if (start <= sub_start && start+size >= sub_start+sub_size) {
+		add_gd_partition(hd, minor, sub_start, sub_size);
+		return 1;
+	}
+
+	printk("bad subpartition - ignored\n");
+	return 0;
+}
diff -u --recursive --new-file ../linux-2.5.5pre1/linux/fs/partitions/check.h ./linux/fs/partitions/check.h
--- ../linux-2.5.5pre1/linux/fs/partitions/check.h	Thu Feb 14 02:09:28 2002
+++ ./linux/fs/partitions/check.h	Sun Feb 17 16:05:10 2002
@@ -7,4 +7,10 @@
  */
 void add_gd_partition(struct gendisk *hd, int minor, int start, int size);
 
+/*
+ * check_and_add_subpartition does the same for subpartitions
+ */
+int check_and_add_subpartition(struct gendisk *hd, int super_minor,
+			       int minor, int sub_start, int sub_size);
+
 extern int warn_no_part;
diff -u --recursive --new-file ../linux-2.5.5pre1/linux/fs/partitions/ldm.c ./linux/fs/partitions/ldm.c
--- ../linux-2.5.5pre1/linux/fs/partitions/ldm.c	Thu Feb 14 02:08:16 2002
+++ ./linux/fs/partitions/ldm.c	Thu Feb 14 02:49:02 2002
@@ -941,9 +941,10 @@
  * validate_patition_table - check whether @dev is a dynamic disk
  * @dev:	device to test
  *
- * Check whether @dev is a dynamic disk by looking for an MS-DOS-style partition
- * table with one or more entries of type 0x42 (the former Secure File System
- * (Landis) partition type, now recycled by Microsoft for dynamic disks) in it.
+ * Check whether @dev is a dynamic disk by looking for an MS-DOS-style
+ * partition table with one or more entries of type 0x42 (the former
+ * Secure File System partition type, now recycled by Microsoft for
+ * dynamic disks) in it.
  * If this succeeds we assume we have a dynamic disk, and not otherwise.
  *
  * Return 1 if @dev is a dynamic disk, 0 if not and -1 on error.
diff -u --recursive --new-file ../linux-2.5.5pre1/linux/fs/partitions/msdos.c ./linux/fs/partitions/msdos.c
--- ../linux-2.5.5pre1/linux/fs/partitions/msdos.c	Thu Feb 14 02:10:31 2002
+++ ./linux/fs/partitions/msdos.c	Thu Feb 14 02:49:03 2002
@@ -261,50 +261,6 @@
 }
 
 #ifdef CONFIG_BSD_DISKLABEL
-static void
-check_and_add_bsd_partition(struct gendisk *hd, struct bsd_partition *bsd_p,
-	int minor, int *current_minor)
-{
-	struct hd_struct *lin_p;
-		/* check relative position of partitions.  */
-	for (lin_p = hd->part + 1 + minor;
-	     lin_p - hd->part - minor < *current_minor; lin_p++) {
-			/* no relationship -> try again */
-		if (lin_p->start_sect + lin_p->nr_sects <= le32_to_cpu(bsd_p->p_offset) ||
-		    lin_p->start_sect >= le32_to_cpu(bsd_p->p_offset) + le32_to_cpu(bsd_p->p_size))
-			continue;	
-			/* equal -> no need to add */
-		if (lin_p->start_sect == le32_to_cpu(bsd_p->p_offset) && 
-			lin_p->nr_sects == le32_to_cpu(bsd_p->p_size)) 
-			return;
-			/* bsd living within dos partition */
-		if (lin_p->start_sect <= le32_to_cpu(bsd_p->p_offset) && lin_p->start_sect 
-			+ lin_p->nr_sects >= le32_to_cpu(bsd_p->p_offset) + le32_to_cpu(bsd_p->p_size)) {
-#ifdef DEBUG_BSD_DISKLABEL
-			printk("w: %d %ld+%ld,%d+%d", 
-				lin_p - hd->part, 
-				lin_p->start_sect, lin_p->nr_sects, 
-				le32_to_cpu(bsd_p->p_offset),
-				le32_to_cpu(bsd_p->p_size));
-#endif
-			break;
-		}
-	 /* ouch: bsd and linux overlap. Don't even try for that partition */
-#ifdef DEBUG_BSD_DISKLABEL
-		printk("???: %d %ld+%ld,%d+%d",
-			lin_p - hd->part, lin_p->start_sect, lin_p->nr_sects,
-			le32_to_cpu(bsd_p->p_offset), le32_to_cpu(bsd_p->p_size));
-#endif
-		printk("???");
-		return;
-	} /* if the bsd partition is not currently known to linux, we end
-	   * up here 
-	   */
-	add_gd_partition(hd, *current_minor, le32_to_cpu(bsd_p->p_offset),
-			 le32_to_cpu(bsd_p->p_size));
-	(*current_minor)++;
-}
-
 /* 
  * Create devices for BSD partitions listed in a disklabel, under a
  * dos-like partition. See extended_partition() for more information.
@@ -326,16 +282,22 @@
 		put_dev_sector(sect);
 		return;
 	}
-	printk(" %s: <%s", partition_name(hd, minor, buf), name);
+	printk(" %s: <%s:", partition_name(hd, minor, buf), name);
 
 	if (le16_to_cpu(l->d_npartitions) < max_partitions)
 		max_partitions = le16_to_cpu(l->d_npartitions);
-	for (p = l->d_partitions; p - l->d_partitions <  max_partitions; p++) {
+	for (p = l->d_partitions; p - l->d_partitions < max_partitions; p++) {
+		int bsd_start, bsd_size;
+
 		if ((*current_minor & mask) == 0)
 			break;
 		if (p->p_fstype == BSD_FS_UNUSED) 
 			continue;
-		check_and_add_bsd_partition(hd, p, minor, current_minor);
+		bsd_start = le32_to_cpu(p->p_offset);
+		bsd_size = le32_to_cpu(p->p_size);
+		if (check_and_add_subpartition(hd, minor, *current_minor,
+					       bsd_start, bsd_size))
+			(*current_minor)++;
 	}
 	put_dev_sector(sect);
 	printk(" >\n");
diff -u --recursive --new-file ../linux-2.5.5pre1/linux/include/linux/blkdev.h ./linux/include/linux/blkdev.h
--- ../linux-2.5.5pre1/linux/include/linux/blkdev.h	Thu Feb 14 02:10:39 2002
+++ ./linux/include/linux/blkdev.h	Sun Feb 17 16:01:09 2002
@@ -313,7 +313,8 @@
 extern void blk_dump_rq_flags(struct request *, char *);
 extern void generic_unplug_device(void *);
 
-extern int * blk_size[MAX_BLKDEV];
+extern int * blk_size[MAX_BLKDEV];	/* in units of 1024 bytes */
+extern loff_t * blk_size_in_bytes[MAX_BLKDEV];
 
 extern int * blksize_size[MAX_BLKDEV];
 
@@ -336,9 +337,7 @@
 extern inline void blk_clear(int major)
 {
 	blk_size[major] = NULL;
-#if 0
 	blk_size_in_bytes[major] = NULL;
-#endif
 	blksize_size[major] = NULL;
 	max_readahead[major] = NULL;
 	read_ahead[major] = 0;
@@ -358,6 +357,7 @@
 #define blk_finished_io(nsects)	do { } while (0)
 #define blk_started_io(nsects)	do { } while (0)
 
+/* assumes size > 256 */
 extern inline unsigned int blksize_bits(unsigned int size)
 {
 	unsigned int bits = 8;
@@ -381,6 +381,17 @@
 	return retval;
 }
 
+extern inline loff_t blkdev_size_in_bytes(kdev_t dev)
+{
+	if (blk_size_in_bytes[major(dev)])
+		return blk_size_in_bytes[major(dev)][minor(dev)];
+	else if (blk_size[major(dev)])
+		return (loff_t) blk_size[major(dev)][minor(dev)]
+			<< BLOCK_SIZE_BITS;
+	else
+		return 0;
+}
+
 typedef struct {struct page *v;} Sector;
 
 unsigned char *read_dev_sector(struct block_device *, unsigned long, Sector *);
diff -u --recursive --new-file ../linux-2.5.5pre1/linux/kernel/ksyms.c ./linux/kernel/ksyms.c
--- ../linux-2.5.5pre1/linux/kernel/ksyms.c	Thu Feb 14 02:12:22 2002
+++ ./linux/kernel/ksyms.c	Thu Feb 14 02:49:03 2002
@@ -307,6 +307,7 @@
 /* block device driver support */
 EXPORT_SYMBOL(blksize_size);
 EXPORT_SYMBOL(blk_size);
+EXPORT_SYMBOL(blk_size_in_bytes);
 EXPORT_SYMBOL(blk_dev);
 EXPORT_SYMBOL(is_read_only);
 EXPORT_SYMBOL(set_device_ro);
