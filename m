Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264575AbRFPANK>; Fri, 15 Jun 2001 20:13:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264577AbRFPANB>; Fri, 15 Jun 2001 20:13:01 -0400
Received: from hera.cwi.nl ([192.16.191.8]:17866 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S264575AbRFPAMm>;
	Fri, 15 Jun 2001 20:12:42 -0400
Date: Sat, 16 Jun 2001 02:12:40 +0200 (MET DST)
From: Andries.Brouwer@cwi.nl
Message-Id: <UTC200106160012.CAA307306.aeb@vlet.cwi.nl>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] blkdev_size_in_bytes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

People want to read the last sector on a disk, but our present
code does not easily allow that, since size checking is done
in units of 1024 bytes, not in units of 512 bytes.

We have seen very ugly solutions ("add an ioctl to read the last sector")
and very kludgy solutions ("create a partition that starts at an odd sector,
just before the end of the disk").

In reality of course we just want to have finer grainer information
and do the checking right.

Below an example.

[blk_size can be replaced by blk_size_in_bytes once all drivers
have been adapted; here I only did the ide part]

[By the way, this presupposes the presence of the BLKGETBSZ/BLKSETBSZ
ioctls. We have seen several versions of that patch already.
My current version can be found on ftp.kernel.org under people/aeb.]

Andries

------------------------------------------------------------------
diff -u --recursive --new-file ../linux-2.4.6-pre3a/linux/drivers/block/blkpg.c ./linux/drivers/block/blkpg.c
--- ../linux-2.4.6-pre3a/linux/drivers/block/blkpg.c	Sat Jun 16 00:16:08 2001
+++ ./linux/drivers/block/blkpg.c	Sat Jun 16 00:43:37 2001
@@ -207,6 +207,7 @@
 int blk_ioctl(kdev_t dev, unsigned int cmd, unsigned long arg)
 {
 	int intval;
+	long longval;
 
 	switch (cmd) {
 		case BLKROSET:
@@ -242,21 +243,14 @@
 			return 0;
 
 		case BLKSSZGET:
-			/* get block device sector size as needed e.g. by fdisk */
+			/* get block device hardware sector size */
 			intval = get_hardsect_size(dev);
 			return put_user(intval, (int *) arg);
 
-#if 0
 		case BLKGETSIZE:
-			/* Today get_gendisk() requires a linear scan;
-			   add this when dev has pointer type. */
-			g = get_gendisk(dev);
-			if (!g)
-				longval = 0;
-			else
-				longval = g->part[MINOR(dev)].nr_sects;
+			/* get block device size in 512-byte sectors */
+			longval = (blkdev_size_in_bytes(dev) >> 9);
 			return put_user(longval, (long *) arg);
-#endif
 #if 0
 		case BLKRRPART: /* Re-read partition tables */
 			if (!capable(CAP_SYS_ADMIN)) 
diff -u --recursive --new-file ../linux-2.4.6-pre3a/linux/drivers/block/ll_rw_blk.c ./linux/drivers/block/ll_rw_blk.c
--- ../linux-2.4.6-pre3a/linux/drivers/block/ll_rw_blk.c	Sat Jun 16 00:16:02 2001
+++ ./linux/drivers/block/ll_rw_blk.c	Sat Jun 16 00:38:04 2001
@@ -76,7 +76,7 @@
 
 /*
  * blk_size contains the size of all block-devices in units of 1024 byte
- * sectors:
+ * blocks; it is obsoleted by blk_size_in_bytes
  *
  * blk_size[MAJOR][MINOR]
  *
@@ -85,6 +85,17 @@
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
@@ -858,35 +869,29 @@
  * */
 void generic_make_request (int rw, struct buffer_head * bh)
 {
-	int major = MAJOR(bh->b_rdev);
-	int minorsize = 0;
+	unsigned long maxsector;
 	request_queue_t *q;
 
 	if (!bh->b_end_io)
 		BUG();
 
 	/* Test device size, when known. */
-	if (blk_size[major])
-		minorsize = blk_size[major][MINOR(bh->b_rdev)];
-	if (minorsize) {
-		unsigned long maxsector = (minorsize << 1) + 1;
+	maxsector = (blkdev_size_in_bytes(bh->b_rdev) >> 9);
+	if (maxsector) {
 		unsigned long sector = bh->b_rsector;
 		unsigned int count = bh->b_size >> 9;
 
 		if (maxsector < count || maxsector - count < sector) {
-			/* Yecch */
-			bh->b_state &= (1 << BH_Lock) | (1 << BH_Mapped);
-
 			/* This may well happen - the kernel calls bread()
 			   without checking the size of the device, e.g.,
 			   when mounting a device. */
 			printk(KERN_INFO
 			       "attempt to access beyond end of device\n");
-			printk(KERN_INFO "%s: rw=%d, want=%ld, limit=%d\n",
+			printk(KERN_INFO "%s: rw=%d, want=%ld, limit=%ld\n",
 			       kdevname(bh->b_rdev), rw,
-			       (sector + count)>>1, minorsize);
+			       (sector + count)>>1, maxsector>>1);
 
-			/* Yecch again */
+			bh->b_state &= (1 << BH_Lock) | (1 << BH_Mapped);
 			bh->b_end_io(bh, 0);
 			return;
 		}
diff -u --recursive --new-file ../linux-2.4.6-pre3a/linux/drivers/block/loop.c ./linux/drivers/block/loop.c
--- ../linux-2.4.6-pre3a/linux/drivers/block/loop.c	Sat Jun 16 00:16:02 2001
+++ ./linux/drivers/block/loop.c	Sat Jun 16 00:38:04 2001
@@ -147,14 +147,22 @@
 
 #define MAX_DISK_SIZE 1024*1024*1024
 
-static int compute_loop_size(struct loop_device *lo, struct dentry * lo_dentry, kdev_t lodev)
+static int compute_loop_size(struct loop_device *lo,
+			     struct dentry * lo_dentry, kdev_t lodev)
 {
-	if (S_ISREG(lo_dentry->d_inode->i_mode))
-		return (lo_dentry->d_inode->i_size - lo->lo_offset) >> BLOCK_SIZE_BITS;
-	if (blk_size[MAJOR(lodev)])
-		return blk_size[MAJOR(lodev)][MINOR(lodev)] -
-                                (lo->lo_offset >> BLOCK_SIZE_BITS);
-	return MAX_DISK_SIZE;
+	loff_t size = 0;
+	int ok;
+
+	if (S_ISREG(lo_dentry->d_inode->i_mode)) {
+		size = lo_dentry->d_inode->i_size;
+		ok = 1;
+	} else {
+		size = blkdev_size_in_bytes(lodev);
+		ok = (size != 0);
+	}
+
+	return ok ? ((size - lo->lo_offset) >> BLOCK_SIZE_BITS)
+		  : MAX_DISK_SIZE;
 }
 
 static void figure_loop_size(struct loop_device *lo)
diff -u --recursive --new-file ../linux-2.4.6-pre3a/linux/drivers/block/rd.c ./linux/drivers/block/rd.c
--- ../linux-2.4.6-pre3a/linux/drivers/block/rd.c	Fri Feb  9 20:30:22 2001
+++ ./linux/drivers/block/rd.c	Sat Jun 16 01:45:16 2001
@@ -265,10 +265,7 @@
 			rd_blocksizes[minor] = 0;
 			break;
 
-         	case BLKGETSIZE:   /* Return device size */
-			if (!arg)  return -EINVAL;
-			return put_user(rd_kbsize[minor] << 1, (long *) arg);
-
+         	case BLKGETSIZE:
 		case BLKROSET:
 		case BLKROGET:
 		case BLKSSZGET:
@@ -276,7 +273,7 @@
 
 		default:
 			return -EINVAL;
-	};
+	}
 
 	return 0;
 }
@@ -567,9 +564,9 @@
 	mm_segment_t fs;
 	kdev_t ram_device;
 	int nblocks, i;
+	unsigned int devblocks;
 	char *buf;
 	unsigned short rotate = 0;
-	unsigned short devblocks = 0;
 	char rotator[4] = { '|' , '/' , '-' , '\\' };
 
 	ram_device = MKDEV(MAJOR_NR, unit);
@@ -639,8 +636,7 @@
 		goto done;
 	}
 
-	if (blk_size[MAJOR(device)])
-		devblocks = blk_size[MAJOR(device)][MINOR(device)];
+	devblocks = (blkdev_size_in_bytes(device) >> BLOCK_SIZE_BITS);
 
 #ifdef CONFIG_BLK_DEV_INITRD
 	if (MAJOR(device) == MAJOR_NR && MINOR(device) == INITRD_MINOR)
diff -u --recursive --new-file ../linux-2.4.6-pre3a/linux/drivers/char/raw.c ./linux/drivers/char/raw.c
--- ../linux-2.4.6-pre3a/linux/drivers/char/raw.c	Sun May 20 20:34:05 2001
+++ ./linux/drivers/char/raw.c	Sat Jun 16 00:38:04 2001
@@ -317,10 +317,9 @@
 	sector_bits = raw_devices[minor].sector_bits;
 	sector_mask = sector_size- 1;
 	max_sectors = KIO_MAX_SECTORS >> (sector_bits - 9);
-	
-	if (blk_size[MAJOR(dev)])
-		limit = (((loff_t) blk_size[MAJOR(dev)][MINOR(dev)]) << BLOCK_SIZE_BITS) >> sector_bits;
-	else
+
+	limit = (blkdev_size_in_bytes(dev) >> sector_bits);
+	if (!limit)
 		limit = INT_MAX;
 	dprintk ("rw_raw_dev: dev %d:%d (+%d)\n",
 		 MAJOR(dev), MINOR(dev), limit);
diff -u --recursive --new-file ../linux-2.4.6-pre3a/linux/drivers/ide/ide-probe.c ./linux/drivers/ide/ide-probe.c
--- ../linux-2.4.6-pre3a/linux/drivers/ide/ide-probe.c	Sun Mar 18 18:25:02 2001
+++ ./linux/drivers/ide/ide-probe.c	Sat Jun 16 00:38:04 2001
@@ -750,6 +750,7 @@
 	struct gendisk *gd, **gdp;
 	unsigned int unit, units, minors;
 	int *bs, *max_sect, *max_ra;
+	loff_t *byteszs;
 	extern devfs_handle_t ide_devfs_handle;
 
 	/* figure out maximum drive number on the interface */
@@ -764,10 +765,12 @@
 	bs        = kmalloc (minors*sizeof(int), GFP_KERNEL);
 	max_sect  = kmalloc (minors*sizeof(int), GFP_KERNEL);
 	max_ra    = kmalloc (minors*sizeof(int), GFP_KERNEL);
+	byteszs   = kmalloc (minors*sizeof(loff_t), GFP_KERNEL);
 
 	memset(gd->part, 0, minors * sizeof(struct hd_struct));
 
 	/* cdroms and msdos f/s are examples of non-1024 blocksizes */
+	blk_size_in_bytes[hwif->major] = byteszs;
 	blksize_size[hwif->major] = bs;
 	max_sectors[hwif->major] = max_sect;
 	max_readahead[hwif->major] = max_ra;
diff -u --recursive --new-file ../linux-2.4.6-pre3a/linux/drivers/ide/ide.c ./linux/drivers/ide/ide.c
--- ../linux-2.4.6-pre3a/linux/drivers/ide/ide.c	Sat Jun 16 00:16:08 2001
+++ ./linux/drivers/ide/ide.c	Sat Jun 16 00:43:37 2001
@@ -2056,11 +2056,13 @@
 	 * Remove us from the kernel's knowledge
 	 */
 	unregister_blkdev(hwif->major, hwif->name);
+	kfree(blk_size_in_bytes[hwif->major]);
 	kfree(blksize_size[hwif->major]);
 	kfree(max_sectors[hwif->major]);
 	kfree(max_readahead[hwif->major]);
 	blk_dev[hwif->major].data = NULL;
 	blk_dev[hwif->major].queue = NULL;
+	blk_size_in_bytes[hwif->major] = NULL;
 	blksize_size[hwif->major] = NULL;
 	for (gdp = &gendisk_head; *gdp; gdp = &((*gdp)->next))
 		if (*gdp == hwif->gd)
diff -u --recursive --new-file ../linux-2.4.6-pre3a/linux/drivers/md/md.c ./linux/drivers/md/md.c
--- ../linux-2.4.6-pre3a/linux/drivers/md/md.c	Sat Jun 16 00:16:08 2001
+++ ./linux/drivers/md/md.c	Sat Jun 16 00:43:37 2001
@@ -300,10 +300,9 @@
 static unsigned int calc_dev_sboffset (kdev_t dev, mddev_t *mddev,
 						int persistent)
 {
-	unsigned int size = 0;
+	unsigned int size;
 
-	if (blk_size[MAJOR(dev)])
-		size = blk_size[MAJOR(dev)][MINOR(dev)];
+	size = (blkdev_size_in_bytes(dev) >> BLOCK_SIZE_BITS);
 	if (persistent)
 		size = MD_NEW_SIZE_BLOCKS(size);
 	return size;
@@ -1119,11 +1118,9 @@
 	rdev->desc_nr = -1;
 	rdev->faulty = 0;
 
-	size = 0;
-	if (blk_size[MAJOR(newdev)])
-		size = blk_size[MAJOR(newdev)][MINOR(newdev)];
+	size = (blkdev_size_in_bytes(dev) >> BLOCK_SIZE_BITS);
 	if (!size) {
-		printk("md: %s has zero size, marking faulty!\n",
+		printk("md: %s has zero or unknown size, marking faulty!\n",
 				partition_name(newdev));
 		err = -EINVAL;
 		goto abort_free;
diff -u --recursive --new-file ../linux-2.4.6-pre3a/linux/drivers/s390/block/dasd.c ./linux/drivers/s390/block/dasd.c
--- ../linux-2.4.6-pre3a/linux/drivers/s390/block/dasd.c	Tue May 15 10:29:34 2001
+++ ./linux/drivers/s390/block/dasd.c	Sat Jun 16 00:38:04 2001
@@ -2013,13 +2013,6 @@
 		data);
 #endif
 	switch (no) {
-	case BLKGETSIZE:{	/* Return device size */
-			long blocks = blk_size[MAJOR (inp->i_rdev)][MINOR (inp->i_rdev)] << 1;
-			rc = copy_to_user ((long *) data, &blocks, sizeof (long));
-			if (rc)
-				rc = -EFAULT;
-			break;
-		}
 	case BLKRRPART:{
                         if (!capable(CAP_SYS_ADMIN)) {
                             rc = -EACCES;
@@ -2043,7 +2036,8 @@
 				rc = -EFAULT;
 			break;
 		}
-#if (LINUX_VERSION_CODE > KERNEL_VERSION(2,3,98))
+
+	case BLKGETSIZE:
         case BLKSSZGET:
         case BLKROSET:
         case BLKROGET:
@@ -2055,37 +2049,7 @@
         case BLKELVSET:
                 return blk_ioctl(inp->i_rdev, no, data);
                 break;
-#else
-        case BLKRASET:
-                if(!capable(CAP_SYS_ADMIN))
-                        return -EACCES;
-                if(!dev || arg > 0xff)
-                        return -EINVAL;
-                read_ahead[MAJOR(dev)] = arg;
-                rc = 0;
-                break;
-        case BLKRAGET:
-                if (!arg)
-                        return -EINVAL;
-                rc = put_user(read_ahead[MAJOR(dev)], (long *) arg);
-                break;
-        case BLKSSZGET: {
-            /* Block size of media */
-            rc = copy_to_user((int *)data,
-                              &blksize_size[MAJOR(device->kdev)]
-                              [MINOR(device->kdev)],
-                              sizeof(int)) ? -EFAULT : 0;
-        }
-        RO_IOCTLS (inp->i_rdev, data);
-	case BLKFLSBUF:{
-                if (!capable(CAP_SYS_ADMIN)) 
-                        return -EACCES;
-                fsync_dev(inp->i_rdev);
-                invalidate_buffers(inp->i_rdev);
-                rc = 0;
-                break;
-        }
-#endif				/* LINUX_IS_24 */
+
 	case BIODASDRSID:{
 			rc = copy_to_user ((void *) data,
 					   &(device->devinfo.sid_data),
diff -u --recursive --new-file ../linux-2.4.6-pre3a/linux/drivers/usb/storage/dpcm.c ./linux/drivers/usb/storage/dpcm.c
--- ../linux-2.4.6-pre3a/linux/drivers/usb/storage/dpcm.c	Sat Apr 28 20:28:08 2001
+++ ./linux/drivers/usb/storage/dpcm.c	Sat Jun 16 00:38:04 2001
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
+   {
+    int ret;
 
     /*
      * LUN 1 corresponds to the SmartMedia card reader.
@@ -73,6 +73,7 @@
     srb->lun = 1; us->srb->lun = 1;
 
     return ret;
+   }
 #endif
 
   default:
diff -u --recursive --new-file ../linux-2.4.6-pre3a/linux/fs/affs/super.c ./linux/fs/affs/super.c
--- ../linux-2.4.6-pre3a/linux/fs/affs/super.c	Fri Apr 20 07:57:06 2001
+++ ./linux/fs/affs/super.c	Sat Jun 16 00:38:04 2001
@@ -29,7 +29,6 @@
 #include <asm/system.h>
 #include <asm/uaccess.h>
 
-extern int *blk_size[];
 extern struct timezone sys_tz;
 
 static int affs_statfs(struct super_block *sb, struct statfs *buf);
@@ -226,7 +225,7 @@
 	struct inode		*root_inode = NULL;
 	kdev_t			 dev = sb->s_dev;
 	s32			 root_block;
-	int			 blocks, size, blocksize;
+	int			 size, blocksize;
 	u32			 chksum;
 	int			 num_bm;
 	int			 i, j;
@@ -262,13 +261,12 @@
 	 * blocks, we will have to change it.
 	 */
 
-	blocks = blk_size[MAJOR(dev)] ? blk_size[MAJOR(dev)][MINOR(dev)] : 0;
-	if (!blocks) {
+	size = (blkdev_size_in_bytes(dev) >> 9);
+	if (!size) {
 		printk(KERN_ERR "AFFS: Could not determine device size\n");
 		goto out_error;
 	}
-	size = (BLOCK_SIZE / 512) * blocks;
-	pr_debug("AFFS: initial blksize=%d, blocks=%d\n", 512, blocks);
+	pr_debug("AFFS: initial blocksize=%d, #blocks=%d\n", 512, blocks);
 
 #warning
 	affs_set_blocksize(sb, PAGE_SIZE);
diff -u --recursive --new-file ../linux-2.4.6-pre3a/linux/fs/block_dev.c ./linux/fs/block_dev.c
--- ../linux-2.4.6-pre3a/linux/fs/block_dev.c	Sat Jun 16 00:16:04 2001
+++ ./linux/fs/block_dev.c	Sat Jun 16 00:38:04 2001
@@ -12,14 +12,12 @@
 #include <linux/slab.h>
 #include <linux/kmod.h>
 #include <linux/major.h>
+#include <linux/blkdev.h>
 #include <linux/devfs_fs_kernel.h>
 #include <linux/smp_lock.h>
 
 #include <asm/uaccess.h>
 
-extern int *blk_size[];
-extern int *blksize_size[];
-
 #define MAX_BUF_PER_PAGE (PAGE_SIZE / 512)
 #define NBUF 64
 
@@ -56,18 +54,16 @@
 	block = *ppos >> blocksize_bits;
 	offset = *ppos & (blocksize-1);
 
-	if (blk_size[MAJOR(dev)])
-		size = ((loff_t) blk_size[MAJOR(dev)][MINOR(dev)] << BLOCK_SIZE_BITS) >> blocksize_bits;
-	else
-		size = INT_MAX;
+	size = (blkdev_size_in_bytes(dev) >> blocksize_bits);
+
 	while (count>0) {
-		if (block >= size) {
+		if (size && block >= size) {
 			retval = -ENOSPC;
 			goto cleanup;
 		}
 		chars = blocksize - offset;
 		if (chars > count)
-			chars=count;
+			chars = count;
 
 #if 0
 		/* get the buffer head */
@@ -90,12 +86,10 @@
 			goto cleanup;
 		}
 
-		if (!buffer_uptodate(bh))
-		{
+		if (!buffer_uptodate(bh)) {
 		  if (chars == blocksize)
 		    wait_on_buffer(bh);
-		  else
-		  {
+		  else {
 		    bhlist[0] = bh;
 		    if (!filp->f_reada || !read_ahead[MAJOR(dev)]) {
 		      /* We do this to force the read of a single buffer */
@@ -103,14 +97,15 @@
 		    } else {
 		      /* Read-ahead before write */
 		      blocks = read_ahead[MAJOR(dev)] / (blocksize >> 9) / 2;
-		      if (block + blocks > size) blocks = size - block;
-		      if (blocks > NBUF) blocks=NBUF;
-		      if (!blocks) blocks = 1;
-		      for(i=1; i<blocks; i++)
-		      {
+		      if (size && block + blocks > size)
+			      blocks = size - block;
+		      if (blocks > NBUF)
+			      blocks=NBUF;
+		      if (!blocks)
+			      blocks = 1;
+		      for(i=1; i<blocks; i++) {
 		        bhlist[i] = getblk (dev, block+i, blocksize);
-		        if (!bhlist[i])
-			{
+		        if (!bhlist[i]) {
 			  while(i >= 0) brelse(bhlist[i--]);
 			  retval = -EIO;
 			  goto cleanup;
@@ -125,8 +120,8 @@
 			  retval = -EIO;
 			  goto cleanup;
 		    }
-		  };
-		};
+		  }
+		}
 #endif
 		block++;
 		p = offset + bh->b_data;
@@ -178,7 +173,7 @@
 {
 	struct inode * inode = filp->f_dentry->d_inode;
 	size_t block;
-	loff_t offset;
+	loff_t size, offset;
 	ssize_t blocksize;
 	ssize_t blocksize_bits, i;
 	size_t blocks, rblocks, left;
@@ -187,7 +182,6 @@
 	struct buffer_head * buflist[NBUF];
 	struct buffer_head * bhreq[NBUF];
 	unsigned int chars;
-	loff_t size;
 	kdev_t dev;
 	ssize_t read;
 
@@ -203,23 +197,17 @@
 	}
 
 	offset = *ppos;
-	if (blk_size[MAJOR(dev)])
-		size = (loff_t) blk_size[MAJOR(dev)][MINOR(dev)] << BLOCK_SIZE_BITS;
-	else
-		size = (loff_t) INT_MAX << BLOCK_SIZE_BITS;
-
-	if (offset > size)
-		left = 0;
-	/* size - offset might not fit into left, so check explicitly. */
-	else if (size - offset > INT_MAX)
-		left = INT_MAX;
-	else
-		left = size - offset;
-	if (left > count)
-		left = count;
+	left = count;
+	size = blkdev_size_in_bytes(dev);
+	if (size) {
+		if (size < offset)
+			left = 0;
+		else if (size - offset < left)
+			left = size - offset;
+	}
 	if (left <= 0)
 		return 0;
-	read = 0;
+
 	block = offset >> blocksize_bits;
 	offset &= blocksize-1;
 	size >>= blocksize_bits;
@@ -248,6 +236,7 @@
 	   This routine is optimized to make maximum use of the various
 	   buffers and caches. */
 
+	read = 0;
 	do {
 		bhrequest = 0;
 		uptodate = 1;
@@ -314,7 +303,7 @@
 		brelse(*bhe);
 		if (++bhe == &buflist[NBUF])
 			bhe = buflist;
-	};
+	}
 	if (!read)
 		return -EIO;
 	filp->f_reada = 1;
@@ -334,9 +323,7 @@
 	switch (origin) {
 		case 2:
 			dev = file->f_dentry->d_inode->i_rdev;
-			if (blk_size[MAJOR(dev)])
-				offset += (loff_t) blk_size[MAJOR(dev)][MINOR(dev)] << BLOCK_SIZE_BITS;
-			/* else?  return -EINVAL? */
+			offset += blkdev_size_in_bytes(dev);
 			break;
 		case 1:
 			offset += file->f_pos;
diff -u --recursive --new-file ../linux-2.4.6-pre3a/linux/fs/partitions/check.c ./linux/fs/partitions/check.c
--- ../linux-2.4.6-pre3a/linux/fs/partitions/check.c	Sat Jun 16 00:16:04 2001
+++ ./linux/fs/partitions/check.c	Sat Jun 16 00:38:04 2001
@@ -33,8 +33,6 @@
 #include "ibm.h"
 #include "ultrix.h"
 
-extern int *blk_size[];
-
 struct gendisk *gendisk_head;
 int warn_no_part = 1; /*This is ugly: should make genhd removable media aware*/
 
@@ -408,7 +406,8 @@
 	grok_partitions(gdev, MINOR(dev)>>gdev->minor_shift, minors, size);
 }
 
-void grok_partitions(struct gendisk *dev, int drive, unsigned minors, long size)
+void grok_partitions(struct gendisk *dev, int drive, unsigned minors,
+		     long size)
 {
 	int i;
 	int first_minor	= drive << dev->minor_shift;
@@ -418,6 +417,7 @@
 		blk_size[dev->major] = NULL;
 
 	dev->part[first_minor].nr_sects = size;
+
 	/* No such device or no minors to use for partitions */
 	if (!size || minors == 1)
 		return;
@@ -430,7 +430,16 @@
  	 */
 	if (dev->sizes != NULL) {	/* optional safeguard in ll_rw_blk.c */
 		for (i = first_minor; i < end_minor; i++)
-			dev->sizes[i] = dev->part[i].nr_sects >> (BLOCK_SIZE_BITS - 9);
+			dev->sizes[i] =
+				dev->part[i].nr_sects >> (BLOCK_SIZE_BITS - 9);
 		blk_size[dev->major] = dev->sizes;
+	}
+	/*
+	 * In case the device provided an array blk_size_in_bytes[], fill it.
+	 */
+	if (dev->sizes != NULL && blk_size_in_bytes[dev->major] != NULL) {
+		for (i = first_minor; i < end_minor; i++)
+			blk_size_in_bytes[dev->major][i] =
+				((loff_t) dev->part[i].nr_sects << 9);
 	}
 }
diff -u --recursive --new-file ../linux-2.4.6-pre3a/linux/include/linux/blkdev.h ./linux/include/linux/blkdev.h
--- ../linux-2.4.6-pre3a/linux/include/linux/blkdev.h	Sat May 26 03:01:40 2001
+++ ./linux/include/linux/blkdev.h	Sat Jun 16 00:50:54 2001
@@ -164,7 +164,8 @@
 extern void blk_queue_make_request(request_queue_t *, make_request_fn *);
 extern void generic_unplug_device(void *);
 
-extern int * blk_size[MAX_BLKDEV];
+extern int * blk_size[MAX_BLKDEV];	/* in units of 1024 bytes */
+extern loff_t * blk_size_in_bytes[MAX_BLKDEV];
 
 extern int * blksize_size[MAX_BLKDEV];
 
@@ -203,6 +204,17 @@
 		return hardsect_size[MAJOR(dev)][MINOR(dev)];
 	else
 		return 512;
+}
+
+static inline loff_t blkdev_size_in_bytes(kdev_t dev)
+{
+	if (blk_size_in_bytes[MAJOR(dev)])
+		return blk_size_in_bytes[MAJOR(dev)][MINOR(dev)];
+	else if (blk_size[MAJOR(dev)])
+		return (loff_t) blk_size[MAJOR(dev)][MINOR(dev)]
+			<< BLOCK_SIZE_BITS;
+	else
+		return 0;
 }
 
 #define blk_finished_io(nsects)				\
diff -u --recursive --new-file ../linux-2.4.6-pre3a/linux/kernel/ksyms.c ./linux/kernel/ksyms.c
--- ../linux-2.4.6-pre3a/linux/kernel/ksyms.c	Sat Jun 16 00:16:08 2001
+++ ./linux/kernel/ksyms.c	Sat Jun 16 00:38:04 2001
@@ -284,6 +284,7 @@
 EXPORT_SYMBOL(blksize_size);
 EXPORT_SYMBOL(hardsect_size);
 EXPORT_SYMBOL(blk_size);
+EXPORT_SYMBOL(blk_size_in_bytes);
 EXPORT_SYMBOL(blk_dev);
 EXPORT_SYMBOL(is_read_only);
 EXPORT_SYMBOL(set_device_ro);
diff -u --recursive --new-file ../linux-2.4.6-pre3a/linux/mm/swapfile.c ./linux/mm/swapfile.c
--- ../linux-2.4.6-pre3a/linux/mm/swapfile.c	Sat Jun 16 00:16:08 2001
+++ ./linux/mm/swapfile.c	Sat Jun 16 00:38:04 2001
@@ -10,7 +10,7 @@
 #include <linux/kernel_stat.h>
 #include <linux/swap.h>
 #include <linux/swapctl.h>
-#include <linux/blkdev.h> /* for blk_size */
+#include <linux/blkdev.h>
 #include <linux/vmalloc.h>
 #include <linux/pagemap.h>
 #include <linux/shm.h>
@@ -626,11 +626,14 @@
 		error = blkdev_get(bdev, FMODE_READ|FMODE_WRITE, 0, BDEV_SWAP);
 		if (error)
 			goto bad_swap_2;
-		set_blocksize(dev, PAGE_SIZE);
+
 		error = -ENODEV;
-		if (!dev || (blk_size[MAJOR(dev)] &&
-		     !blk_size[MAJOR(dev)][MINOR(dev)]))
+		if (!dev)
+			goto bad_swap;
+		swapfilesize = (blkdev_size_in_bytes(dev) >> PAGE_SHIFT);
+		if (swapfilesize == 0)
 			goto bad_swap;
+
 		error = -EBUSY;
 		for (i = 0 ; i < nr_swapfiles ; i++) {
 			if (i == type)
@@ -638,10 +641,8 @@
 			if (dev == swap_info[i].swap_device)
 				goto bad_swap;
 		}
-		swapfilesize = 0;
-		if (blk_size[MAJOR(dev)])
-			swapfilesize = blk_size[MAJOR(dev)][MINOR(dev)]
-				>> (PAGE_SHIFT - 10);
+
+		set_blocksize(dev, PAGE_SIZE);
 	} else if (S_ISREG(swap_inode->i_mode)) {
 		error = -EBUSY;
 		for (i = 0 ; i < nr_swapfiles ; i++) {
