Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135259AbRD1Pej>; Sat, 28 Apr 2001 11:34:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135293AbRD1PeV>; Sat, 28 Apr 2001 11:34:21 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:48587 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S135259AbRD1PeQ>;
	Sat, 28 Apr 2001 11:34:16 -0400
Date: Sat, 28 Apr 2001 11:34:15 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] (2 of 2) cleanup for fixing get_super() races
In-Reply-To: <Pine.GSO.4.21.0104272154260.21109-100000@weyl.math.psu.edu>
Message-ID: <Pine.GSO.4.21.0104281133150.23302-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

... and here's the promised second variant
								Al

diff -urN S4/drivers/acorn/block/mfmhd.c S4-invalidate_device-2/drivers/acorn/block/mfmhd.c
--- S4/drivers/acorn/block/mfmhd.c	Fri Feb 16 18:37:01 2001
+++ S4-invalidate_device-2/drivers/acorn/block/mfmhd.c	Sat Apr 28 11:21:29 2001
@@ -1485,14 +1485,7 @@
 
 	for (i = maxp - 1; i >= 0; i--) {
 		int minor = start + i;
-		kdev_t devi = MKDEV(MAJOR_NR, minor);
-		struct super_block *sb = get_super(devi);
-
-		sync_dev (devi);
-		if (sb)
-			invalidate_inodes (sb);
-		invalidate_buffers (devi);
-
+		invalidate_device (MKDEV(MAJOR_NR, minor), 1);
 		mfm_gendisk.part[minor].start_sect = 0;
 		mfm_gendisk.part[minor].nr_sects = 0;
 	}
diff -urN S4/drivers/block/DAC960.c S4-invalidate_device-2/drivers/block/DAC960.c
--- S4/drivers/block/DAC960.c	Thu Feb 22 06:46:26 2001
+++ S4-invalidate_device-2/drivers/block/DAC960.c	Sat Apr 28 11:15:09 2001
@@ -5134,16 +5134,12 @@
 						      PartitionNumber);
 	  int MinorNumber = DAC960_MinorNumber(LogicalDriveNumber,
 					       PartitionNumber);
-	  SuperBlock_T *SuperBlock = get_super(Device);
 	  if (Controller->GenericDiskInfo.part[MinorNumber].nr_sects == 0)
 	    continue;
 	  /*
 	    Flush all changes and invalidate buffered state.
 	  */
-	  sync_dev(Device);
-	  if (SuperBlock != NULL)
-	    invalidate_inodes(SuperBlock);
-	  invalidate_buffers(Device);
+	  invalidate_device(Device, 1);
 	  /*
 	    Clear existing partition sizes.
 	  */
diff -urN S4/drivers/block/acsi.c S4-invalidate_device-2/drivers/block/acsi.c
--- S4/drivers/block/acsi.c	Fri Feb 16 22:53:03 2001
+++ S4-invalidate_device-2/drivers/block/acsi.c	Sat Apr 28 11:22:09 2001
@@ -1886,13 +1886,7 @@
 
 	for( i = max_p - 1; i >= 0 ; i-- ) {
 		if (gdev->part[start + i].nr_sects != 0) {
-			kdev_t devp = MKDEV(MAJOR_NR, start + i);
-			struct super_block *sb = get_super(devp);
-
-			fsync_dev(devp);
-			if (sb)
-				invalidate_inodes(sb);
-			invalidate_buffers(devp);
+			invalidate_device(MKDEV(MAJOR_NR, start + i), 1);
 			gdev->part[start + i].nr_sects = 0;
 		}
 		gdev->part[start+i].start_sect = 0;
diff -urN S4/drivers/block/amiflop.c S4-invalidate_device-2/drivers/block/amiflop.c
--- S4/drivers/block/amiflop.c	Fri Feb 16 18:59:20 2001
+++ S4-invalidate_device-2/drivers/block/amiflop.c	Sat Apr 28 11:15:26 2001
@@ -1540,10 +1540,7 @@
 		break;
 	case FDFMTEND:
 		floppy_off(drive);
-		sb = get_super(inode->i_rdev);
-		if (sb)
-			invalidate_inodes(sb);
-		invalidate_buffers(inode->i_rdev);
+		invalidate_device(inode->i_rdev, 0);
 		break;
 	case FDGETPRM:
 		memset((void *)&getprm, 0, sizeof (getprm));
diff -urN S4/drivers/block/cciss.c S4-invalidate_device-2/drivers/block/cciss.c
--- S4/drivers/block/cciss.c	Sat Apr 28 02:12:49 2001
+++ S4-invalidate_device-2/drivers/block/cciss.c	Sat Apr 28 11:22:44 2001
@@ -693,11 +693,7 @@
 
         for(i=max_p; i>=0; i--) {
                 int minor = start+i;
-                kdev_t devi = MKDEV(MAJOR_NR + ctlr, minor);
-                struct super_block *sb = get_super(devi);
-                sync_dev(devi);
-                if (sb) invalidate_inodes(sb);
-                invalidate_buffers(devi);
+                invalidate_device(MKDEV(MAJOR_NR + ctlr, minor), 1);
                 gdev->part[minor].start_sect = 0;
                 gdev->part[minor].nr_sects = 0;
 
diff -urN S4/drivers/block/cpqarray.c S4-invalidate_device-2/drivers/block/cpqarray.c
--- S4/drivers/block/cpqarray.c	Fri Feb 16 22:56:28 2001
+++ S4-invalidate_device-2/drivers/block/cpqarray.c	Sat Apr 28 11:23:05 2001
@@ -1576,11 +1576,7 @@
 
 	for(i=max_p; i>=0; i--) {
 		int minor = start+i;
-		kdev_t devi = MKDEV(MAJOR_NR + ctlr, minor);
-		struct super_block *sb = get_super(devi);
-		sync_dev(devi);
-		if (sb) invalidate_inodes(sb);
-		invalidate_buffers(devi);
+		invalidate_device(MKDEV(MAJOR_NR + ctlr, minor), 1);
 		gdev->part[minor].start_sect = 0;	
 		gdev->part[minor].nr_sects = 0;	
 
diff -urN S4/drivers/block/paride/pd.c S4-invalidate_device-2/drivers/block/paride/pd.c
--- S4/drivers/block/paride/pd.c	Fri Feb 16 22:50:44 2001
+++ S4-invalidate_device-2/drivers/block/paride/pd.c	Sat Apr 28 11:24:52 2001
@@ -589,9 +589,6 @@
 
 {       int p, unit, minor;
         long flags;
-        kdev_t devp;
-
-	struct super_block *sb;
 
         unit = DEVICE_NR(dev);
         if ((unit >= PD_UNITS) || (!PD.present)) return -ENODEV;
@@ -607,13 +604,7 @@
 
         for (p=(PD_PARTNS-1);p>=0;p--) {
 		minor = p + unit*PD_PARTNS;
-                devp = MKDEV(MAJOR_NR, minor);
-                fsync_dev(devp);
-
-                sb = get_super(devp);
-                if (sb) invalidate_inodes(sb);
-
-                invalidate_buffers(devp);
+                invalidate_device(MKDEV(MAJOR_NR, minor), 1);
                 pd_hd[minor].start_sect = 0;
                 pd_hd[minor].nr_sects = 0;
         }
diff -urN S4/drivers/block/ps2esdi.c S4-invalidate_device-2/drivers/block/ps2esdi.c
--- S4/drivers/block/ps2esdi.c	Sat Apr 28 02:12:49 2001
+++ S4-invalidate_device-2/drivers/block/ps2esdi.c	Sat Apr 28 11:23:49 2001
@@ -1145,15 +1145,9 @@
 	for (partition = ps2esdi_gendisk.max_p - 1;
 	     partition >= 0; partition--) {
 		int minor = (start | partition);
-		kdev_t devp = MKDEV(MAJOR_NR, minor);
-		struct super_block * sb = get_super(devp);
-		
-		sync_dev(devp);
-		if (sb)
-			invalidate_inodes(sb);
-		invalidate_buffers(devp);
-		ps2esdi_gendisk.part[start + partition].start_sect = 0;
-		ps2esdi_gendisk.part[start + partition].nr_sects = 0;
+		invalidate_device(MKDEV(MAJOR_NR, minor), 1);
+		ps2esdi_gendisk.part[minor].start_sect = 0;
+		ps2esdi_gendisk.part[minor].nr_sects = 0;
 	}
 
 	grok_partitions(&ps2esdi_gendisk, target, 1<<6, 
diff -urN S4/drivers/block/xd.c S4-invalidate_device-2/drivers/block/xd.c
--- S4/drivers/block/xd.c	Thu Feb 22 06:46:25 2001
+++ S4-invalidate_device-2/drivers/block/xd.c	Sat Apr 28 11:24:10 2001
@@ -401,13 +401,7 @@
 
 	for (partition = xd_gendisk.max_p - 1; partition >= 0; partition--) {
 		int minor = (start | partition);
-		kdev_t devp = MKDEV(MAJOR_NR, minor);
-		struct super_block * sb = get_super(devp);
-		
-		sync_dev(devp);
-		if (sb)
-			invalidate_inodes(sb);
-		invalidate_buffers(devp);
+		invalidate_device(MKDEV(MAJOR_NR, minor), 1);
 		xd_gendisk.part[minor].start_sect = 0;
 		xd_gendisk.part[minor].nr_sects = 0;
 	};
@@ -1163,16 +1157,6 @@
 	int partition,dev,start;
 
 	devfs_unregister_blkdev(MAJOR_NR, "xd");
-	for (dev = 0; dev < xd_drives; dev++) {
-		start = dev << xd_gendisk.minor_shift; 
-		for (partition = xd_gendisk.max_p - 1; partition >= 0; partition--) {
-			int minor = (start | partition);
-			kdev_t devp = MKDEV(MAJOR_NR, minor);
-			start = dev << xd_gendisk.minor_shift; 
-			sync_dev(devp);
-			invalidate_buffers(devp);
-		}
-	}
 	xd_done();
 	devfs_unregister (devfs_handle);
 	if (xd_drives) {
diff -urN S4/drivers/i2o/i2o_block.c S4-invalidate_device-2/drivers/i2o/i2o_block.c
--- S4/drivers/i2o/i2o_block.c	Fri Feb 16 22:53:46 2001
+++ S4-invalidate_device-2/drivers/i2o/i2o_block.c	Sat Apr 28 11:25:12 2001
@@ -892,13 +892,7 @@
 	for( i = 15; i>=0 ; i--)
 	{
 		int m = minor+i;
-		kdev_t d = MKDEV(MAJOR_NR, m);
-		struct super_block *sb = get_super(d);
-		
-		sync_dev(d);
-		if(sb)
-			invalidate_inodes(sb);
-		invalidate_buffers(d);
+		invalidate_device(MKDEV(MAJOR_NR, m), 1);
 		i2ob_gendisk.part[m].start_sect = 0;
 		i2ob_gendisk.part[m].nr_sects = 0;
 	}
diff -urN S4/drivers/ide/hd.c S4-invalidate_device-2/drivers/ide/hd.c
--- S4/drivers/ide/hd.c	Thu Feb 22 06:47:01 2001
+++ S4-invalidate_device-2/drivers/ide/hd.c	Sat Apr 28 11:25:33 2001
@@ -892,13 +892,7 @@
 
 	for (i=max_p - 1; i >=0 ; i--) {
 		int minor = start + i;
-		kdev_t devi = MKDEV(MAJOR_NR, minor);
-		struct super_block *sb = get_super(devi); 
-
-		sync_dev(devi);
-		if (sb)
-			invalidate_inodes(sb);
-		invalidate_buffers(devi);
+		invalidate_device(MKDEV(MAJOR_NR, minor), 1);
 		gdev->part[minor].start_sect = 0;
 		gdev->part[minor].nr_sects = 0;
 	}
diff -urN S4/drivers/ide/ide.c S4-invalidate_device-2/drivers/ide/ide.c
--- S4/drivers/ide/ide.c	Sat Apr 28 02:12:50 2001
+++ S4-invalidate_device-2/drivers/ide/ide.c	Sat Apr 28 11:17:04 2001
@@ -1762,11 +1762,7 @@
 	for (p = 0; p < (1<<PARTN_BITS); ++p) {
 		if (drive->part[p].nr_sects > 0) {
 			kdev_t devp = MKDEV(major, minor+p);
-			struct super_block * sb = get_super(devp);
-			fsync_dev          (devp);
-			if (sb)
-				invalidate_inodes(sb);
-			invalidate_buffers (devp);
+			invalidate_device(devp, 1);
 			set_blocksize(devp, 1024);
 		}
 		drive->part[p].start_sect = 0;
@@ -1983,9 +1979,7 @@
 		for (p = 0; p < (1<<PARTN_BITS); ++p) {
 			if (drive->part[p].nr_sects > 0) {
 				kdev_t devp = MKDEV(hwif->major, minor+p);
-				struct super_block * sb = get_super(devp);
-				if (sb) invalidate_inodes(sb);
-				invalidate_buffers (devp);
+				invalidate_device(devp, 0);
 			}
 		}
 #ifdef CONFIG_PROC_FS
diff -urN S4/drivers/mtd/ftl.c S4-invalidate_device-2/drivers/mtd/ftl.c
--- S4/drivers/mtd/ftl.c	Fri Feb 16 22:53:55 2001
+++ S4-invalidate_device-2/drivers/mtd/ftl.c	Sat Apr 28 11:17:11 2001
@@ -915,9 +915,6 @@
 
 static release_t ftl_close(struct inode *inode, struct file *file)
 {
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,2,0)
-    struct super_block *sb = get_super(inode->i_rdev);
-#endif
     int minor = MINOR(inode->i_rdev);
     partition_t *part = myparts[minor >> 4];
     int i;
@@ -925,11 +922,7 @@
     DEBUG(0, "ftl_cs: ftl_close(%d)\n", minor);
 
     /* Flush all writes */
-    fsync_dev(inode->i_rdev);
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,2,0)
-    if (sb) invalidate_inodes(sb);
-#endif
-    invalidate_buffers(inode->i_rdev);
+    invalidate_device(inode->i_rdev, 1);
 
     /* Wait for any pending erase operations to complete */
     if (part->mtd->sync)
diff -urN S4/drivers/mtd/mtdblock.c S4-invalidate_device-2/drivers/mtd/mtdblock.c
--- S4/drivers/mtd/mtdblock.c	Fri Feb 16 22:53:55 2001
+++ S4-invalidate_device-2/drivers/mtd/mtdblock.c	Sat Apr 28 11:17:18 2001
@@ -355,19 +355,12 @@
 {
 	int dev;
 	struct mtdblk_dev *mtdblk;
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,2,0)
-	struct super_block * sb = get_super(inode->i_rdev);
-#endif
    	DEBUG(MTD_DEBUG_LEVEL1, "mtdblock_release\n");
 
 	if (inode == NULL)
 		release_return(-ENODEV);
    
-	fsync_dev(inode->i_rdev);
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,2,0)
-	if (sb) invalidate_inodes(sb);
-#endif
-	invalidate_buffers(inode->i_rdev);
+	invalidate_device(inode->i_rdev, 1);
 
 	dev = MINOR(inode->i_rdev);
 	mtdblk = mtdblks[dev];
diff -urN S4/drivers/mtd/nftl.c S4-invalidate_device-2/drivers/mtd/nftl.c
--- S4/drivers/mtd/nftl.c	Fri Feb 16 22:53:55 2001
+++ S4-invalidate_device-2/drivers/mtd/nftl.c	Sat Apr 28 11:17:24 2001
@@ -997,17 +997,13 @@
 
 static int nftl_release(struct inode *inode, struct file *fp)
 {
-	struct super_block *sb = get_super(inode->i_rdev);
 	struct NFTLrecord *thisNFTL;
 
 	thisNFTL = NFTLs[MINOR(inode->i_rdev) / 16];
 
 	DEBUG(MTD_DEBUG_LEVEL2, "NFTL_release\n");
 
-	fsync_dev(inode->i_rdev);
-	if (sb)
-		invalidate_inodes(sb);
-	invalidate_buffers(inode->i_rdev);
+	invalidate_device(inode->i_rdev, 1);
 
 	if (thisNFTL->mtd->sync)
 		thisNFTL->mtd->sync(thisNFTL->mtd);
diff -urN S4/drivers/scsi/sd.c S4-invalidate_device-2/drivers/scsi/sd.c
--- S4/drivers/scsi/sd.c	Fri Feb 16 22:48:36 2001
+++ S4-invalidate_device-2/drivers/scsi/sd.c	Sat Apr 28 11:27:18 2001
@@ -1261,12 +1261,7 @@
 
 	for (i = max_p - 1; i >= 0; i--) {
 		int index = start + i;
-		kdev_t devi = MKDEV_SD_PARTITION(index);
-		struct super_block *sb = get_super(devi);
-		sync_dev(devi);
-		if (sb)
-			invalidate_inodes(sb);
-		invalidate_buffers(devi);
+		invalidate_device(MKDEV_SD_PARTITION(index), 1);
 		sd_gendisks->part[index].start_sect = 0;
 		sd_gendisks->part[index].nr_sects = 0;
 		/*
@@ -1314,12 +1309,7 @@
 
 			for (j = max_p - 1; j >= 0; j--) {
 				int index = start + j;
-				kdev_t devi = MKDEV_SD_PARTITION(index);
-				struct super_block *sb = get_super(devi);
-				sync_dev(devi);
-				if (sb)
-					invalidate_inodes(sb);
-				invalidate_buffers(devi);
+				invalidate_device(MKDEV_SD_PARTITION(index), 1);
 				sd_gendisks->part[index].start_sect = 0;
 				sd_gendisks->part[index].nr_sects = 0;
 				sd_sizes[index] = 0;
diff -urN S4/drivers/scsi/sr.c S4-invalidate_device-2/drivers/scsi/sr.c
--- S4/drivers/scsi/sr.c	Thu Feb 22 06:46:36 2001
+++ S4-invalidate_device-2/drivers/scsi/sr.c	Sat Apr 28 11:27:42 2001
@@ -869,16 +869,11 @@
 
 	for (cpnt = scsi_CDs, i = 0; i < sr_template.dev_max; i++, cpnt++)
 		if (cpnt->device == SDp) {
-			kdev_t devi = MKDEV(MAJOR_NR, i);
-			struct super_block *sb = get_super(devi);
-
 			/*
 			 * Since the cdrom is read-only, no need to sync the device.
 			 * We should be kind to our buffer cache, however.
 			 */
-			if (sb)
-				invalidate_inodes(sb);
-			invalidate_buffers(devi);
+			invalidate_device(MKDEV(MAJOR_NR, i), 0);
 
 			/*
 			 * Reset things back to a sane state so that one can re-load a new
diff -urN S4/fs/block_dev.c S4-invalidate_device-2/fs/block_dev.c
--- S4/fs/block_dev.c	Fri Feb 16 22:52:03 2001
+++ S4-invalidate_device-2/fs/block_dev.c	Sat Apr 28 11:17:57 2001
@@ -576,11 +576,8 @@
 	printk(KERN_DEBUG "VFS: Disk change detected on device %s\n",
 		bdevname(dev));
 
-	sb = get_super(dev);
-	if (sb && invalidate_inodes(sb))
+	if (invalidate_device(dev, 0))
 		printk("VFS: busy inodes on changed media.\n");
-
-	destroy_buffers(dev);
 
 	if (bdops->revalidate)
 		bdops->revalidate(dev);
diff -urN S4/fs/devfs/base.c S4-invalidate_device-2/fs/devfs/base.c
--- S4/fs/devfs/base.c	Sat Apr 28 02:12:56 2001
+++ S4-invalidate_device-2/fs/devfs/base.c	Sat Apr 28 11:18:27 2001
@@ -2156,7 +2156,6 @@
     int tmp;
     kdev_t dev = MKDEV (de->u.fcb.u.device.major, de->u.fcb.u.device.minor);
     struct block_device_operations *bdops = de->u.fcb.ops;
-    struct super_block * sb;
     extern int warn_no_part;
 
     if ( !S_ISBLK (de->mode) ) return 0;
@@ -2165,10 +2164,8 @@
     if ( !bdops->check_media_change (dev) ) return 0;
     printk ( KERN_DEBUG "VFS: Disk change detected on device %s\n",
 	     kdevname (dev) );
-    sb = get_super (dev);
-    if ( sb && invalidate_inodes (sb) )
+    if (invalidate_device(dev, 0))
 	printk("VFS: busy inodes on changed media..\n");
-    invalidate_buffers (dev);
     /*  Ugly hack to disable messages about unable to read partition table  */
     tmp = warn_no_part;
     warn_no_part = 0;
diff -urN S4/fs/inode.c S4-invalidate_device-2/fs/inode.c
--- S4/fs/inode.c	Sat Apr 28 02:12:56 2001
+++ S4-invalidate_device-2/fs/inode.c	Sat Apr 28 11:18:22 2001
@@ -591,6 +591,19 @@
 
 	return busy;
 }
+ 
+int invalidate_device(kdev_t dev, int do_sync)
+{
+	struct super_block *sb = get_super(dev);
+	int res;
+	if (do_sync)
+		fsync_dev(dev);
+	if (sb)
+		res = invalidate_inodes(sb);
+	invalidate_buffers(dev);
+	return res;
+}
+
 
 /*
  * This is called with the inode lock held. It searches
diff -urN S4/include/linux/fs.h S4-invalidate_device-2/include/linux/fs.h
--- S4/include/linux/fs.h	Sat Apr 28 02:12:59 2001
+++ S4-invalidate_device-2/include/linux/fs.h	Sat Apr 28 11:18:34 2001
@@ -1086,6 +1086,7 @@
 extern void balance_dirty(kdev_t);
 extern int check_disk_change(kdev_t);
 extern int invalidate_inodes(struct super_block *);
+extern int invalidate_device(kdev_t, int);
 extern void invalidate_inode_pages(struct inode *);
 extern void invalidate_inode_buffers(struct inode *);
 #define invalidate_buffers(dev)	__invalidate_buffers((dev), 0)
diff -urN S4/kernel/ksyms.c S4-invalidate_device-2/kernel/ksyms.c
--- S4/kernel/ksyms.c	Sat Apr 28 02:12:59 2001
+++ S4-invalidate_device-2/kernel/ksyms.c	Sat Apr 28 11:13:05 2001
@@ -174,6 +174,7 @@
 EXPORT_SYMBOL(check_disk_change);
 EXPORT_SYMBOL(__invalidate_buffers);
 EXPORT_SYMBOL(invalidate_inodes);
+EXPORT_SYMBOL(invalidate_device);
 EXPORT_SYMBOL(invalidate_inode_pages);
 EXPORT_SYMBOL(truncate_inode_pages);
 EXPORT_SYMBOL(fsync_dev);


