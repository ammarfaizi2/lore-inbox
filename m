Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314448AbSDFNMG>; Sat, 6 Apr 2002 08:12:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314451AbSDFNMF>; Sat, 6 Apr 2002 08:12:05 -0500
Received: from hera.cwi.nl ([192.16.191.8]:60293 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S314448AbSDFNMC>;
	Sat, 6 Apr 2002 08:12:02 -0500
From: Andries.Brouwer@cwi.nl
Date: Sat, 6 Apr 2002 13:11:47 GMT
Message-Id: <UTC200204061311.NAA534767.aeb@cwi.nl>
To: torvalds@transmeta.com
Subject: [PATCH] size_in_bytes - resend
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A resend.

[The past year I have submitted this patch a number of times.
It is a step on the road to removal of the arrays.
It also solves other things, like the fact that Linux
is unable to read the last sector of a disk or partition
with an odd number of sectors. Last month or so you asked
for a shorter version of the patch, only abstracting all
accesses to blk_size[major][minor]. This is the second
submission of such a shorter version.]

------------------------------------------------------------
diff -u --recursive --new-file ../linux-2.5.8-pre2/linux/drivers/block/blkpg.c ./linux/drivers/block/blkpg.c
--- ../linux-2.5.8-pre2/linux/drivers/block/blkpg.c	Sun Apr  7 12:33:30 2002
+++ ./linux/drivers/block/blkpg.c	Sun Apr  7 12:45:50 2002
@@ -213,7 +213,6 @@
 int blk_ioctl(struct block_device *bdev, unsigned int cmd, unsigned long arg)
 {
 	request_queue_t *q;
-	struct gendisk *g;
 	u64 ullval = 0;
 	int intval;
 	unsigned short usval;
@@ -252,20 +251,18 @@
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
diff -u --recursive --new-file ../linux-2.5.8-pre2/linux/drivers/block/ll_rw_blk.c ./linux/drivers/block/ll_rw_blk.c
--- ../linux-2.5.8-pre2/linux/drivers/block/ll_rw_blk.c	Mon Mar 18 21:37:05 2002
+++ ./linux/drivers/block/ll_rw_blk.c	Sun Apr  7 12:45:50 2002
@@ -62,7 +62,7 @@
 
 /*
  * blk_size contains the size of all block-devices in units of 1024 byte
- * sectors:
+ * blocks:
  *
  * blk_size[MAJOR][MINOR]
  *
@@ -1274,32 +1274,27 @@
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
diff -u --recursive --new-file ../linux-2.5.8-pre2/linux/drivers/block/loop.c ./linux/drivers/block/loop.c
--- ../linux-2.5.8-pre2/linux/drivers/block/loop.c	Sun Apr  7 12:33:30 2002
+++ ./linux/drivers/block/loop.c	Sun Apr  7 12:45:50 2002
@@ -154,14 +154,20 @@
 
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
diff -u --recursive --new-file ../linux-2.5.8-pre2/linux/drivers/block/rd.c ./linux/drivers/block/rd.c
--- ../linux-2.5.8-pre2/linux/drivers/block/rd.c	Sun Apr  7 12:33:30 2002
+++ ./linux/drivers/block/rd.c	Sun Apr  7 12:47:21 2002
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
 			error = blk_ioctl(inode->i_bdev, cmd, arg);
-	};
+	}
 out:
 	return error;
 }
@@ -419,11 +413,10 @@
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
@@ -450,7 +443,8 @@
 			       &rd_bd_op, NULL);
 
 	for (i = 0; i < NUM_RAMDISKS; i++)
-		register_disk(NULL, mk_kdev(MAJOR_NR,i), 1, &rd_bd_op, rd_size<<1);
+		register_disk(NULL, mk_kdev(MAJOR_NR,i), 1, &rd_bd_op,
+			      rd_size<<1);
 
 #ifdef CONFIG_BLK_DEV_INITRD
 	/* We ought to separate initrd operations here */
@@ -459,10 +453,10 @@
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
diff -u --recursive --new-file ../linux-2.5.8-pre2/linux/drivers/char/raw.c ./linux/drivers/char/raw.c
--- ../linux-2.5.8-pre2/linux/drivers/char/raw.c	Sun Apr  7 12:33:30 2002
+++ ./linux/drivers/char/raw.c	Sun Apr  7 12:45:50 2002
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
diff -u --recursive --new-file ../linux-2.5.8-pre2/linux/drivers/md/md.c ./linux/drivers/md/md.c
--- ../linux-2.5.8-pre2/linux/drivers/md/md.c	Sun Apr  7 12:33:30 2002
+++ ./linux/drivers/md/md.c	Sun Apr  7 12:45:50 2002
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
@@ -1106,12 +1103,11 @@
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
diff -u --recursive --new-file ../linux-2.5.8-pre2/linux/drivers/mtd/devices/blkmtd.c ./linux/drivers/mtd/devices/blkmtd.c
--- ../linux-2.5.8-pre2/linux/drivers/mtd/devices/blkmtd.c	Sun Apr  7 12:33:30 2002
+++ ./linux/drivers/mtd/devices/blkmtd.c	Sun Apr  7 12:45:50 2002
@@ -67,7 +67,6 @@
 /* Default erase size in K, always make it a multiple of PAGE_SIZE */
 #define CONFIG_MTD_BLKDEV_ERASESIZE 128
 #define VERSION "1.7"
-extern int *blk_size[];
 
 /* Info for the block device */
 typedef struct mtd_raw_dev_data_s {
@@ -1062,7 +1061,7 @@
 
   int maj, min;
   int i, blocksize, blocksize_bits;
-  loff_t size = 0;
+  loff_t size;
   int readonly = 0;
   int erase_size = CONFIG_MTD_BLKDEV_ERASESIZE;
   kdev_t rdev;
@@ -1143,14 +1142,8 @@
     i >>= 1;
   }
 
-  if(count) {
-    size = count;
-  } else {
-    if (blk_size[maj]) {
-      size = ((loff_t) blk_size[maj][min] << BLOCK_SIZE_BITS) >> blocksize_bits;
-    }
-  }
-  size *= blocksize;
+  size = (count ? count*blocksize : blkdev_size_in_bytes(rdev));
+
   DEBUG(1, "blkmtd: size = %ld\n", (long int)size);
 
   if(size == 0) {
diff -u --recursive --new-file ../linux-2.5.8-pre2/linux/drivers/s390/block/xpram.c ./linux/drivers/s390/block/xpram.c
--- ../linux-2.5.8-pre2/linux/drivers/s390/block/xpram.c	Sun Apr  7 12:33:31 2002
+++ ./linux/drivers/s390/block/xpram.c	Sun Apr  7 12:45:50 2002
@@ -1045,7 +1045,7 @@
 		for (i=0; i < xpram_devs; i++) 
 			if (xpram_sizes[i] == 0) xpram_sizes[i] = mem_auto;
 	}
-	blk_size[major]=xpram_sizes;
+	blk_size[major] = xpram_sizes;
 
 	xpram_offsets = kmalloc(xpram_devs * sizeof(int), GFP_KERNEL);
 	if (!xpram_offsets) {
diff -u --recursive --new-file ../linux-2.5.8-pre2/linux/drivers/scsi/scsi.c ./linux/drivers/scsi/scsi.c
--- ../linux-2.5.8-pre2/linux/drivers/scsi/scsi.c	Mon Mar 18 21:37:16 2002
+++ ./linux/drivers/scsi/scsi.c	Sun Apr  7 13:57:46 2002
@@ -2387,7 +2387,7 @@
 				       kdevname(SCpnt->request.rq_dev),
 				       SCpnt->request.sector,
 				       SCpnt->request.nr_sectors,
-				       SCpnt->request.current_nr_sectors,
+				       (long)SCpnt->request.current_nr_sectors,
 				       SCpnt->request.rq_status,
 				       SCpnt->use_sg,
 
diff -u --recursive --new-file ../linux-2.5.8-pre2/linux/drivers/scsi/sd.c ./linux/drivers/scsi/sd.c
--- ../linux-2.5.8-pre2/linux/drivers/scsi/sd.c	Mon Mar 18 21:37:08 2002
+++ ./linux/drivers/scsi/sd.c	Sun Apr  7 14:00:02 2002
@@ -373,7 +373,7 @@
 
 	SCSI_LOG_HLQUEUE(2, printk("%s : %s %d/%ld 512 byte blocks.\n",
 				   nbuff,
-		   (SCpnt->request.cmd == WRITE) ? "writing" : "reading",
+		   (rq_data_dir(&SCpnt->request) == WRITE) ? "writing" : "reading",
 				 this_count, SCpnt->request.nr_sectors));
 
 	SCpnt->cmnd[1] = (SCpnt->device->scsi_level <= SCSI_2) ?
diff -u --recursive --new-file ../linux-2.5.8-pre2/linux/fs/affs/super.c ./linux/fs/affs/super.c
--- ../linux-2.5.8-pre2/linux/fs/affs/super.c	Sun Apr  7 12:33:32 2002
+++ ./linux/fs/affs/super.c	Sun Apr  7 12:45:50 2002
@@ -29,7 +29,6 @@
 #include <asm/system.h>
 #include <asm/uaccess.h>
 
-extern int *blk_size[];
 extern struct timezone sys_tz;
 
 static int affs_statfs(struct super_block *sb, struct statfs *buf);
@@ -321,7 +320,7 @@
 	 */
 
 	size = sb->s_bdev->bd_inode->i_size >> 9;
-	pr_debug("AFFS: initial blksize=%d, blocks=%d\n", 512, blocks);
+	pr_debug("AFFS: initial blocksize=%d, #blocks=%d\n", 512, size);
 
 	affs_set_blocksize(sb, PAGE_SIZE);
 	/* Try to find root block. Its location depends on the block size. */
diff -u --recursive --new-file ../linux-2.5.8-pre2/linux/fs/block_dev.c ./linux/fs/block_dev.c
--- ../linux-2.5.8-pre2/linux/fs/block_dev.c	Sun Apr  7 12:33:32 2002
+++ ./linux/fs/block_dev.c	Sun Apr  7 12:45:50 2002
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
diff -u --recursive --new-file ../linux-2.5.8-pre2/linux/fs/cramfs/inode.c ./linux/fs/cramfs/inode.c
--- ../linux-2.5.8-pre2/linux/fs/cramfs/inode.c	Mon Mar 18 21:37:03 2002
+++ ./linux/fs/cramfs/inode.c	Sun Apr  7 12:56:21 2002
@@ -112,8 +112,6 @@
 	struct buffer_head * read_array[BLKS_PER_BUF];
 	unsigned i, blocknr, buffer, unread;
 	unsigned long devsize;
-	unsigned int major, minor;
-
 	char *data;
 
 	if (!len)
@@ -136,12 +134,9 @@
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
diff -u --recursive --new-file ../linux-2.5.8-pre2/linux/include/linux/blkdev.h ./linux/include/linux/blkdev.h
--- ../linux-2.5.8-pre2/linux/include/linux/blkdev.h	Mon Mar 18 21:37:08 2002
+++ ./linux/include/linux/blkdev.h	Sun Apr  7 15:00:17 2002
@@ -313,7 +313,7 @@
 extern void blk_dump_rq_flags(struct request *, char *);
 extern void generic_unplug_device(void *);
 
-extern int * blk_size[MAX_BLKDEV];
+extern int * blk_size[MAX_BLKDEV];	/* in units of 1024 bytes */
 extern int * blksize_size[MAX_BLKDEV];
 
 #define MAX_PHYS_SEGMENTS 128
@@ -353,6 +353,7 @@
 #define blk_finished_io(nsects)	do { } while (0)
 #define blk_started_io(nsects)	do { } while (0)
 
+/* assumes size > 256 */
 extern inline unsigned int blksize_bits(unsigned int size)
 {
 	unsigned int bits = 8;
@@ -376,6 +377,20 @@
 	return retval;
 }
 
+extern inline loff_t blkdev_size_in_bytes(kdev_t dev)
+{
+#if 0
+	if (blk_size_in_bytes[major(dev)])
+		return blk_size_in_bytes[major(dev)][minor(dev)];
+	else
+#endif
+	if (blk_size[major(dev)])
+		return (loff_t) blk_size[major(dev)][minor(dev)]
+			<< BLOCK_SIZE_BITS;
+	else
+		return 0;
+}
+
 typedef struct {struct page *v;} Sector;
 
 unsigned char *read_dev_sector(struct block_device *, unsigned long, Sector *);
