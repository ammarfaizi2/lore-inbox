Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136294AbRD1ArT>; Fri, 27 Apr 2001 20:47:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136284AbRD1ArK>; Fri, 27 Apr 2001 20:47:10 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:21742 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S136294AbRD1Aq6>;
	Fri, 27 Apr 2001 20:46:58 -0400
Date: Fri, 27 Apr 2001 20:46:56 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] cleanup for fixing get_super() races
Message-ID: <Pine.GSO.4.21.0104272043490.21109-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A lot of drivers does the following:
	sb = get_super(dev);
	if (sb)
		invalidate_inodes(sb);
Each of these places is an oopsable race with umount. We can't fix them
without touching a lot of drivers. However, we can make the future fix
easier if we put the above into a helper function. Patch below does that.
Results:
	* simpler code in drivers
	* drivers don't care about the superblocks and their handling
	* when we will add refcounting for superblocks we will not need
	  to touch every block driver out there.
Patch is absolutely straightforward - function added to inode.c, declared
in fs.h and exported; instances of the body replaced with calls.

Please, apply it.
								Al

diff -urN S4-pre8/drivers/acorn/block/mfmhd.c S4-pre8-ream_inodes/drivers/acorn/block/mfmhd.c
--- S4-pre8/drivers/acorn/block/mfmhd.c	Fri Feb 16 18:37:01 2001
+++ S4-pre8-ream_inodes/drivers/acorn/block/mfmhd.c	Fri Apr 27 20:16:01 2001
@@ -1486,11 +1486,9 @@
 	for (i = maxp - 1; i >= 0; i--) {
 		int minor = start + i;
 		kdev_t devi = MKDEV(MAJOR_NR, minor);
-		struct super_block *sb = get_super(devi);
 
 		sync_dev (devi);
-		if (sb)
-			invalidate_inodes (sb);
+		ream_inodes(devi);
 		invalidate_buffers (devi);
 
 		mfm_gendisk.part[minor].start_sect = 0;
diff -urN S4-pre8/drivers/block/DAC960.c S4-pre8-ream_inodes/drivers/block/DAC960.c
--- S4-pre8/drivers/block/DAC960.c	Thu Feb 22 06:46:26 2001
+++ S4-pre8-ream_inodes/drivers/block/DAC960.c	Fri Apr 27 20:16:31 2001
@@ -5134,15 +5134,13 @@
 						      PartitionNumber);
 	  int MinorNumber = DAC960_MinorNumber(LogicalDriveNumber,
 					       PartitionNumber);
-	  SuperBlock_T *SuperBlock = get_super(Device);
 	  if (Controller->GenericDiskInfo.part[MinorNumber].nr_sects == 0)
 	    continue;
 	  /*
 	    Flush all changes and invalidate buffered state.
 	  */
 	  sync_dev(Device);
-	  if (SuperBlock != NULL)
-	    invalidate_inodes(SuperBlock);
+	  ream_inodes(Device);
 	  invalidate_buffers(Device);
 	  /*
 	    Clear existing partition sizes.
diff -urN S4-pre8/drivers/block/acsi.c S4-pre8-ream_inodes/drivers/block/acsi.c
--- S4-pre8/drivers/block/acsi.c	Fri Feb 16 22:53:03 2001
+++ S4-pre8-ream_inodes/drivers/block/acsi.c	Fri Apr 27 20:16:48 2001
@@ -1887,11 +1887,9 @@
 	for( i = max_p - 1; i >= 0 ; i-- ) {
 		if (gdev->part[start + i].nr_sects != 0) {
 			kdev_t devp = MKDEV(MAJOR_NR, start + i);
-			struct super_block *sb = get_super(devp);
 
 			fsync_dev(devp);
-			if (sb)
-				invalidate_inodes(sb);
+			ream_inodes(devp);
 			invalidate_buffers(devp);
 			gdev->part[start + i].nr_sects = 0;
 		}
diff -urN S4-pre8/drivers/block/amiflop.c S4-pre8-ream_inodes/drivers/block/amiflop.c
--- S4-pre8/drivers/block/amiflop.c	Fri Feb 16 18:59:20 2001
+++ S4-pre8-ream_inodes/drivers/block/amiflop.c	Fri Apr 27 20:17:09 2001
@@ -1540,9 +1540,7 @@
 		break;
 	case FDFMTEND:
 		floppy_off(drive);
-		sb = get_super(inode->i_rdev);
-		if (sb)
-			invalidate_inodes(sb);
+		ream_inodes(inode->i_rdev);
 		invalidate_buffers(inode->i_rdev);
 		break;
 	case FDGETPRM:
diff -urN S4-pre8/drivers/block/cciss.c S4-pre8-ream_inodes/drivers/block/cciss.c
--- S4-pre8/drivers/block/cciss.c	Fri Apr 27 06:20:56 2001
+++ S4-pre8-ream_inodes/drivers/block/cciss.c	Fri Apr 27 20:17:30 2001
@@ -694,9 +694,8 @@
         for(i=max_p; i>=0; i--) {
                 int minor = start+i;
                 kdev_t devi = MKDEV(MAJOR_NR + ctlr, minor);
-                struct super_block *sb = get_super(devi);
                 sync_dev(devi);
-                if (sb) invalidate_inodes(sb);
+                ream_inodes(devi);
                 invalidate_buffers(devi);
                 gdev->part[minor].start_sect = 0;
                 gdev->part[minor].nr_sects = 0;
diff -urN S4-pre8/drivers/block/cpqarray.c S4-pre8-ream_inodes/drivers/block/cpqarray.c
--- S4-pre8/drivers/block/cpqarray.c	Fri Feb 16 22:56:28 2001
+++ S4-pre8-ream_inodes/drivers/block/cpqarray.c	Fri Apr 27 20:17:42 2001
@@ -1577,9 +1577,8 @@
 	for(i=max_p; i>=0; i--) {
 		int minor = start+i;
 		kdev_t devi = MKDEV(MAJOR_NR + ctlr, minor);
-		struct super_block *sb = get_super(devi);
 		sync_dev(devi);
-		if (sb) invalidate_inodes(sb);
+		ream_inodes(devi);
 		invalidate_buffers(devi);
 		gdev->part[minor].start_sect = 0;	
 		gdev->part[minor].nr_sects = 0;	
diff -urN S4-pre8/drivers/block/paride/pd.c S4-pre8-ream_inodes/drivers/block/paride/pd.c
--- S4-pre8/drivers/block/paride/pd.c	Fri Feb 16 22:50:44 2001
+++ S4-pre8-ream_inodes/drivers/block/paride/pd.c	Fri Apr 27 20:18:36 2001
@@ -591,8 +591,6 @@
         long flags;
         kdev_t devp;
 
-	struct super_block *sb;
-
         unit = DEVICE_NR(dev);
         if ((unit >= PD_UNITS) || (!PD.present)) return -ENODEV;
 
@@ -609,10 +607,7 @@
 		minor = p + unit*PD_PARTNS;
                 devp = MKDEV(MAJOR_NR, minor);
                 fsync_dev(devp);
-
-                sb = get_super(devp);
-                if (sb) invalidate_inodes(sb);
-
+                ream_inodes(devp);
                 invalidate_buffers(devp);
                 pd_hd[minor].start_sect = 0;
                 pd_hd[minor].nr_sects = 0;
diff -urN S4-pre8/drivers/block/ps2esdi.c S4-pre8-ream_inodes/drivers/block/ps2esdi.c
--- S4-pre8/drivers/block/ps2esdi.c	Fri Apr 27 06:20:56 2001
+++ S4-pre8-ream_inodes/drivers/block/ps2esdi.c	Fri Apr 27 20:17:57 2001
@@ -1146,11 +1146,9 @@
 	     partition >= 0; partition--) {
 		int minor = (start | partition);
 		kdev_t devp = MKDEV(MAJOR_NR, minor);
-		struct super_block * sb = get_super(devp);
 		
 		sync_dev(devp);
-		if (sb)
-			invalidate_inodes(sb);
+		ream_inodes(devp);
 		invalidate_buffers(devp);
 		ps2esdi_gendisk.part[start + partition].start_sect = 0;
 		ps2esdi_gendisk.part[start + partition].nr_sects = 0;
diff -urN S4-pre8/drivers/block/xd.c S4-pre8-ream_inodes/drivers/block/xd.c
--- S4-pre8/drivers/block/xd.c	Thu Feb 22 06:46:25 2001
+++ S4-pre8-ream_inodes/drivers/block/xd.c	Fri Apr 27 20:18:13 2001
@@ -402,11 +402,9 @@
 	for (partition = xd_gendisk.max_p - 1; partition >= 0; partition--) {
 		int minor = (start | partition);
 		kdev_t devp = MKDEV(MAJOR_NR, minor);
-		struct super_block * sb = get_super(devp);
 		
 		sync_dev(devp);
-		if (sb)
-			invalidate_inodes(sb);
+		ream_inodes(devp);
 		invalidate_buffers(devp);
 		xd_gendisk.part[minor].start_sect = 0;
 		xd_gendisk.part[minor].nr_sects = 0;
diff -urN S4-pre8/drivers/i2o/i2o_block.c S4-pre8-ream_inodes/drivers/i2o/i2o_block.c
--- S4-pre8/drivers/i2o/i2o_block.c	Fri Feb 16 22:53:46 2001
+++ S4-pre8-ream_inodes/drivers/i2o/i2o_block.c	Fri Apr 27 20:18:51 2001
@@ -893,11 +893,9 @@
 	{
 		int m = minor+i;
 		kdev_t d = MKDEV(MAJOR_NR, m);
-		struct super_block *sb = get_super(d);
 		
 		sync_dev(d);
-		if(sb)
-			invalidate_inodes(sb);
+		ream_inodes(d);
 		invalidate_buffers(d);
 		i2ob_gendisk.part[m].start_sect = 0;
 		i2ob_gendisk.part[m].nr_sects = 0;
diff -urN S4-pre8/drivers/ide/hd.c S4-pre8-ream_inodes/drivers/ide/hd.c
--- S4-pre8/drivers/ide/hd.c	Thu Feb 22 06:47:01 2001
+++ S4-pre8-ream_inodes/drivers/ide/hd.c	Fri Apr 27 20:19:06 2001
@@ -893,11 +893,9 @@
 	for (i=max_p - 1; i >=0 ; i--) {
 		int minor = start + i;
 		kdev_t devi = MKDEV(MAJOR_NR, minor);
-		struct super_block *sb = get_super(devi); 
 
 		sync_dev(devi);
-		if (sb)
-			invalidate_inodes(sb);
+		ream_inodes(devi);
 		invalidate_buffers(devi);
 		gdev->part[minor].start_sect = 0;
 		gdev->part[minor].nr_sects = 0;
diff -urN S4-pre8/drivers/ide/ide.c S4-pre8-ream_inodes/drivers/ide/ide.c
--- S4-pre8/drivers/ide/ide.c	Fri Apr 27 06:20:57 2001
+++ S4-pre8-ream_inodes/drivers/ide/ide.c	Fri Apr 27 20:19:43 2001
@@ -1762,11 +1762,9 @@
 	for (p = 0; p < (1<<PARTN_BITS); ++p) {
 		if (drive->part[p].nr_sects > 0) {
 			kdev_t devp = MKDEV(major, minor+p);
-			struct super_block * sb = get_super(devp);
-			fsync_dev          (devp);
-			if (sb)
-				invalidate_inodes(sb);
-			invalidate_buffers (devp);
+			fsync_dev(devp);
+			ream_inodes(devp);
+			invalidate_buffers(devp);
 			set_blocksize(devp, 1024);
 		}
 		drive->part[p].start_sect = 0;
@@ -1983,8 +1981,7 @@
 		for (p = 0; p < (1<<PARTN_BITS); ++p) {
 			if (drive->part[p].nr_sects > 0) {
 				kdev_t devp = MKDEV(hwif->major, minor+p);
-				struct super_block * sb = get_super(devp);
-				if (sb) invalidate_inodes(sb);
+				ream_inodes(devp);
 				invalidate_buffers (devp);
 			}
 		}
diff -urN S4-pre8/drivers/mtd/ftl.c S4-pre8-ream_inodes/drivers/mtd/ftl.c
--- S4-pre8/drivers/mtd/ftl.c	Fri Feb 16 22:53:55 2001
+++ S4-pre8-ream_inodes/drivers/mtd/ftl.c	Fri Apr 27 20:20:19 2001
@@ -915,9 +915,6 @@
 
 static release_t ftl_close(struct inode *inode, struct file *file)
 {
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,2,0)
-    struct super_block *sb = get_super(inode->i_rdev);
-#endif
     int minor = MINOR(inode->i_rdev);
     partition_t *part = myparts[minor >> 4];
     int i;
@@ -926,9 +923,7 @@
 
     /* Flush all writes */
     fsync_dev(inode->i_rdev);
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,2,0)
-    if (sb) invalidate_inodes(sb);
-#endif
+    ream_inodes(inode->i_rdev);
     invalidate_buffers(inode->i_rdev);
 
     /* Wait for any pending erase operations to complete */
diff -urN S4-pre8/drivers/mtd/mtdblock.c S4-pre8-ream_inodes/drivers/mtd/mtdblock.c
--- S4-pre8/drivers/mtd/mtdblock.c	Fri Feb 16 22:53:55 2001
+++ S4-pre8-ream_inodes/drivers/mtd/mtdblock.c	Fri Apr 27 20:20:37 2001
@@ -355,18 +355,13 @@
 {
 	int dev;
 	struct mtdblk_dev *mtdblk;
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,2,0)
-	struct super_block * sb = get_super(inode->i_rdev);
-#endif
    	DEBUG(MTD_DEBUG_LEVEL1, "mtdblock_release\n");
 
 	if (inode == NULL)
 		release_return(-ENODEV);
    
 	fsync_dev(inode->i_rdev);
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,2,0)
-	if (sb) invalidate_inodes(sb);
-#endif
+	ream_inodes(inode->i_rdev);
 	invalidate_buffers(inode->i_rdev);
 
 	dev = MINOR(inode->i_rdev);
diff -urN S4-pre8/drivers/mtd/nftl.c S4-pre8-ream_inodes/drivers/mtd/nftl.c
--- S4-pre8/drivers/mtd/nftl.c	Fri Feb 16 22:53:55 2001
+++ S4-pre8-ream_inodes/drivers/mtd/nftl.c	Fri Apr 27 20:20:55 2001
@@ -997,7 +997,6 @@
 
 static int nftl_release(struct inode *inode, struct file *fp)
 {
-	struct super_block *sb = get_super(inode->i_rdev);
 	struct NFTLrecord *thisNFTL;
 
 	thisNFTL = NFTLs[MINOR(inode->i_rdev) / 16];
@@ -1005,8 +1004,7 @@
 	DEBUG(MTD_DEBUG_LEVEL2, "NFTL_release\n");
 
 	fsync_dev(inode->i_rdev);
-	if (sb)
-		invalidate_inodes(sb);
+	ream_inodes(inode->i_rdev);
 	invalidate_buffers(inode->i_rdev);
 
 	if (thisNFTL->mtd->sync)
diff -urN S4-pre8/drivers/scsi/sd.c S4-pre8-ream_inodes/drivers/scsi/sd.c
--- S4-pre8/drivers/scsi/sd.c	Fri Feb 16 22:48:36 2001
+++ S4-pre8-ream_inodes/drivers/scsi/sd.c	Fri Apr 27 20:21:19 2001
@@ -1262,10 +1262,8 @@
 	for (i = max_p - 1; i >= 0; i--) {
 		int index = start + i;
 		kdev_t devi = MKDEV_SD_PARTITION(index);
-		struct super_block *sb = get_super(devi);
 		sync_dev(devi);
-		if (sb)
-			invalidate_inodes(sb);
+		ream_inodes(devi);
 		invalidate_buffers(devi);
 		sd_gendisks->part[index].start_sect = 0;
 		sd_gendisks->part[index].nr_sects = 0;
@@ -1315,10 +1313,8 @@
 			for (j = max_p - 1; j >= 0; j--) {
 				int index = start + j;
 				kdev_t devi = MKDEV_SD_PARTITION(index);
-				struct super_block *sb = get_super(devi);
 				sync_dev(devi);
-				if (sb)
-					invalidate_inodes(sb);
+				ream_inodes(devi);
 				invalidate_buffers(devi);
 				sd_gendisks->part[index].start_sect = 0;
 				sd_gendisks->part[index].nr_sects = 0;
diff -urN S4-pre8/drivers/scsi/sr.c S4-pre8-ream_inodes/drivers/scsi/sr.c
--- S4-pre8/drivers/scsi/sr.c	Thu Feb 22 06:46:36 2001
+++ S4-pre8-ream_inodes/drivers/scsi/sr.c	Fri Apr 27 20:21:37 2001
@@ -870,14 +870,12 @@
 	for (cpnt = scsi_CDs, i = 0; i < sr_template.dev_max; i++, cpnt++)
 		if (cpnt->device == SDp) {
 			kdev_t devi = MKDEV(MAJOR_NR, i);
-			struct super_block *sb = get_super(devi);
 
 			/*
 			 * Since the cdrom is read-only, no need to sync the device.
 			 * We should be kind to our buffer cache, however.
 			 */
-			if (sb)
-				invalidate_inodes(sb);
+			ream_inodes(devi);
 			invalidate_buffers(devi);
 
 			/*
diff -urN S4-pre8/fs/block_dev.c S4-pre8-ream_inodes/fs/block_dev.c
--- S4-pre8/fs/block_dev.c	Fri Feb 16 22:52:03 2001
+++ S4-pre8-ream_inodes/fs/block_dev.c	Fri Apr 27 20:22:09 2001
@@ -576,8 +576,7 @@
 	printk(KERN_DEBUG "VFS: Disk change detected on device %s\n",
 		bdevname(dev));
 
-	sb = get_super(dev);
-	if (sb && invalidate_inodes(sb))
+	if (ream_inodes(dev))
 		printk("VFS: busy inodes on changed media.\n");
 
 	destroy_buffers(dev);
diff -urN S4-pre8/fs/devfs/base.c S4-pre8-ream_inodes/fs/devfs/base.c
--- S4-pre8/fs/devfs/base.c	Fri Apr 27 06:21:01 2001
+++ S4-pre8-ream_inodes/fs/devfs/base.c	Fri Apr 27 20:23:23 2001
@@ -2156,7 +2156,6 @@
     int tmp;
     kdev_t dev = MKDEV (de->u.fcb.u.device.major, de->u.fcb.u.device.minor);
     struct block_device_operations *bdops = de->u.fcb.ops;
-    struct super_block * sb;
     extern int warn_no_part;
 
     if ( !S_ISBLK (de->mode) ) return 0;
@@ -2165,8 +2164,7 @@
     if ( !bdops->check_media_change (dev) ) return 0;
     printk ( KERN_DEBUG "VFS: Disk change detected on device %s\n",
 	     kdevname (dev) );
-    sb = get_super (dev);
-    if ( sb && invalidate_inodes (sb) )
+    if (ream_inodes(dev))
 	printk("VFS: busy inodes on changed media..\n");
     invalidate_buffers (dev);
     /*  Ugly hack to disable messages about unable to read partition table  */
diff -urN S4-pre8/fs/inode.c S4-pre8-ream_inodes/fs/inode.c
--- S4-pre8/fs/inode.c	Fri Apr 27 06:21:01 2001
+++ S4-pre8-ream_inodes/fs/inode.c	Fri Apr 27 20:22:42 2001
@@ -523,6 +523,23 @@
 
 	return busy;
 }
+ 
+/**
+ *	ream_inodes	- discard the inodes on a device if it's mounted
+ *	@dev: device number
+ *
+ *	Equivalent of invalidate_inodes, but done by device number.
+ */
+
+int ream_inodes(kdev_t dev)
+{
+	struct super_block *sb = get_super(dev);
+	int res;
+	if (sb)
+		res = invalidate_inodes(sb);
+	return res;
+}
+
 
 /*
  * This is called with the inode lock held. It searches
diff -urN S4-pre8/include/linux/fs.h S4-pre8-ream_inodes/include/linux/fs.h
--- S4-pre8/include/linux/fs.h	Fri Apr 27 06:21:03 2001
+++ S4-pre8-ream_inodes/include/linux/fs.h	Fri Apr 27 20:23:49 2001
@@ -1084,6 +1084,7 @@
 extern void balance_dirty(kdev_t);
 extern int check_disk_change(kdev_t);
 extern int invalidate_inodes(struct super_block *);
+extern int ream_inodes(kdev_t);
 extern void invalidate_inode_pages(struct inode *);
 extern void invalidate_inode_buffers(struct inode *);
 #define invalidate_buffers(dev)	__invalidate_buffers((dev), 0)
diff -urN S4-pre8/kernel/ksyms.c S4-pre8-ream_inodes/kernel/ksyms.c
--- S4-pre8/kernel/ksyms.c	Fri Apr 27 06:21:04 2001
+++ S4-pre8-ream_inodes/kernel/ksyms.c	Fri Apr 27 20:24:06 2001
@@ -174,6 +174,7 @@
 EXPORT_SYMBOL(check_disk_change);
 EXPORT_SYMBOL(__invalidate_buffers);
 EXPORT_SYMBOL(invalidate_inodes);
+EXPORT_SYMBOL(ream_inodes);
 EXPORT_SYMBOL(invalidate_inode_pages);
 EXPORT_SYMBOL(truncate_inode_pages);
 EXPORT_SYMBOL(fsync_dev);

