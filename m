Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136309AbRD1BbM>; Fri, 27 Apr 2001 21:31:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136311AbRD1BbE>; Fri, 27 Apr 2001 21:31:04 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:19372 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S136309AbRD1Ba4>;
	Fri, 27 Apr 2001 21:30:56 -0400
Date: Fri, 27 Apr 2001 21:30:54 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cleanup for fixing get_super() races
In-Reply-To: <Pine.GSO.4.21.0104272117440.21109-100000@weyl.math.psu.edu>
Message-ID: <Pine.GSO.4.21.0104272127390.21109-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 27 Apr 2001, Alexander Viro wrote:

> Fine with me. Actually in _all_ cases execept cdrom.c it's preceded by
> either sync_dev() or fsync_dev(). What do you think about pulling that
> into the same function? Actually, that's what I've done in namespace
> patch (name being invalidate_dev(), BTW ;-) The only problem I see
> here is the argument telling whether we want sync or fsync (or nothing).
> OTOH, I seriously suspect that we ought replace all sync_dev() cases
> with fsync_dev() anyway... Your opinion?
> 								Al

PS: last time I've separated that part of patch was a couple months
ago. See if something similar to the variant below would be OK with
you (I'll rediff it):

diff -urN S2/drivers/acorn/block/mfmhd.c S2-s_lock-1/drivers/acorn/block/mfmhd.c
--- S2/drivers/acorn/block/mfmhd.c	Fri Oct 27 01:35:47 2000
+++ S2-s_lock-1/drivers/acorn/block/mfmhd.c	Thu Feb 22 07:00:38 2001
@@ -1486,13 +1486,8 @@
 	for (i = maxp - 1; i >= 0; i--) {
 		int minor = start + i;
 		kdev_t devi = MKDEV(MAJOR_NR, minor);
-		struct super_block *sb = get_super(devi);
-
-		sync_dev (devi);
-		if (sb)
-			invalidate_inodes (sb);
-		invalidate_buffers (devi);
 
+		invalidate_dev(devi, 1);
 		mfm_gendisk.part[minor].start_sect = 0;
 		mfm_gendisk.part[minor].nr_sects = 0;
 	}
diff -urN S2/drivers/block/DAC960.c S2-s_lock-1/drivers/block/DAC960.c
--- S2/drivers/block/DAC960.c	Thu Feb 22 06:22:36 2001
+++ S2-s_lock-1/drivers/block/DAC960.c	Thu Feb 22 07:00:38 2001
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
+	  invalidate_dev(Device, 1);
 	  /*
 	    Clear existing partition sizes.
 	  */
diff -urN S2/drivers/block/acsi.c S2-s_lock-1/drivers/block/acsi.c
--- S2/drivers/block/acsi.c	Thu Feb 22 06:22:36 2001
+++ S2-s_lock-1/drivers/block/acsi.c	Thu Feb 22 07:00:39 2001
@@ -1887,12 +1887,7 @@
 	for( i = max_p - 1; i >= 0 ; i-- ) {
 		if (gdev->part[start + i].nr_sects != 0) {
 			kdev_t devp = MKDEV(MAJOR_NR, start + i);
-			struct super_block *sb = get_super(devp);
-
-			fsync_dev(devp);
-			if (sb)
-				invalidate_inodes(sb);
-			invalidate_buffers(devp);
+			invalidate_dev(devp, 2);
 			gdev->part[start + i].nr_sects = 0;
 		}
 		gdev->part[start+i].start_sect = 0;
diff -urN S2/drivers/block/amiflop.c S2-s_lock-1/drivers/block/amiflop.c
--- S2/drivers/block/amiflop.c	Sun Oct  1 22:35:15 2000
+++ S2-s_lock-1/drivers/block/amiflop.c	Thu Feb 22 07:00:39 2001
@@ -1490,7 +1490,6 @@
 {
 	int drive = inode->i_rdev & 3;
 	static struct floppy_struct getprm;
-	struct super_block * sb;
 
 	switch(cmd){
 	case HDIO_GETGEO:
@@ -1540,10 +1539,7 @@
 		break;
 	case FDFMTEND:
 		floppy_off(drive);
-		sb = get_super(inode->i_rdev);
-		if (sb)
-			invalidate_inodes(sb);
-		invalidate_buffers(inode->i_rdev);
+		invalidate_dev(inode->i_rdev, 0);
 		break;
 	case FDGETPRM:
 		memset((void *)&getprm, 0, sizeof (getprm));
@@ -1677,9 +1673,6 @@
 
 static int floppy_release(struct inode * inode, struct file * filp)
 {
-#ifdef DEBUG
-	struct super_block * sb;
-#endif
 	int drive = MINOR(inode->i_rdev) & 3;
 
 	if (unit[drive].dirty == 1) {
diff -urN S2/drivers/block/blkpg.c S2-s_lock-1/drivers/block/blkpg.c
--- S2/drivers/block/blkpg.c	Fri Oct 27 01:35:47 2000
+++ S2-s_lock-1/drivers/block/blkpg.c	Thu Feb 22 07:00:39 2001
@@ -157,8 +157,7 @@
 
 	/* partition in use? Incomplete check for now. */
 	devp = MKDEV(MAJOR(dev), minor);
-	if (get_super(devp) ||		/* mounted? */
-	    is_swap_partition(devp))
+	if (is_mounted(devp) || is_swap_partition(devp))
 		return -EBUSY;
 
 	/* all seems OK */
diff -urN S2/drivers/block/cciss.c S2-s_lock-1/drivers/block/cciss.c
--- S2/drivers/block/cciss.c	Thu Feb 22 06:22:36 2001
+++ S2-s_lock-1/drivers/block/cciss.c	Thu Feb 22 07:00:39 2001
@@ -693,10 +693,7 @@
         for(i=max_p; i>=0; i--) {
                 int minor = start+i;
                 kdev_t devi = MKDEV(MAJOR_NR + ctlr, minor);
-                struct super_block *sb = get_super(devi);
-                sync_dev(devi);
-                if (sb) invalidate_inodes(sb);
-                invalidate_buffers(devi);
+		invalidate_dev(devi, 1);
                 gdev->part[minor].start_sect = 0;
                 gdev->part[minor].nr_sects = 0;
 
diff -urN S2/drivers/block/cpqarray.c S2-s_lock-1/drivers/block/cpqarray.c
--- S2/drivers/block/cpqarray.c	Thu Feb 22 06:22:36 2001
+++ S2-s_lock-1/drivers/block/cpqarray.c	Thu Feb 22 07:00:39 2001
@@ -1577,10 +1577,7 @@
 	for(i=max_p; i>=0; i--) {
 		int minor = start+i;
 		kdev_t devi = MKDEV(MAJOR_NR + ctlr, minor);
-		struct super_block *sb = get_super(devi);
-		sync_dev(devi);
-		if (sb) invalidate_inodes(sb);
-		invalidate_buffers(devi);
+		invalidate_dev(devi, 1);
 		gdev->part[minor].start_sect = 0;	
 		gdev->part[minor].nr_sects = 0;	
 
diff -urN S2/drivers/block/paride/pd.c S2-s_lock-1/drivers/block/paride/pd.c
--- S2/drivers/block/paride/pd.c	Thu Feb 22 06:22:36 2001
+++ S2-s_lock-1/drivers/block/paride/pd.c	Thu Feb 22 07:00:39 2001
@@ -591,8 +591,6 @@
         long flags;
         kdev_t devp;
 
-	struct super_block *sb;
-
         unit = DEVICE_NR(dev);
         if ((unit >= PD_UNITS) || (!PD.present)) return -ENODEV;
 
@@ -608,12 +606,7 @@
         for (p=(PD_PARTNS-1);p>=0;p--) {
 		minor = p + unit*PD_PARTNS;
                 devp = MKDEV(MAJOR_NR, minor);
-                fsync_dev(devp);
-
-                sb = get_super(devp);
-                if (sb) invalidate_inodes(sb);
-
-                invalidate_buffers(devp);
+		invalidate_dev(devp, 2);
                 pd_hd[minor].start_sect = 0;
                 pd_hd[minor].nr_sects = 0;
         }
diff -urN S2/drivers/block/ps2esdi.c S2-s_lock-1/drivers/block/ps2esdi.c
--- S2/drivers/block/ps2esdi.c	Fri Oct 27 01:35:47 2000
+++ S2-s_lock-1/drivers/block/ps2esdi.c	Thu Feb 22 07:00:39 2001
@@ -1180,12 +1180,7 @@
 	     partition >= 0; partition--) {
 		int minor = (start | partition);
 		kdev_t devp = MKDEV(MAJOR_NR, minor);
-		struct super_block * sb = get_super(devp);
-		
-		sync_dev(devp);
-		if (sb)
-			invalidate_inodes(sb);
-		invalidate_buffers(devp);
+		invalidate_dev(devp, 1);
 		ps2esdi_gendisk.part[start + partition].start_sect = 0;
 		ps2esdi_gendisk.part[start + partition].nr_sects = 0;
 	}
diff -urN S2/drivers/block/xd.c S2-s_lock-1/drivers/block/xd.c
--- S2/drivers/block/xd.c	Thu Feb 22 06:22:36 2001
+++ S2-s_lock-1/drivers/block/xd.c	Thu Feb 22 07:00:39 2001
@@ -402,12 +402,7 @@
 	for (partition = xd_gendisk.max_p - 1; partition >= 0; partition--) {
 		int minor = (start | partition);
 		kdev_t devp = MKDEV(MAJOR_NR, minor);
-		struct super_block * sb = get_super(devp);
-		
-		sync_dev(devp);
-		if (sb)
-			invalidate_inodes(sb);
-		invalidate_buffers(devp);
+		invalidate_dev(devp, 1);
 		xd_gendisk.part[minor].start_sect = 0;
 		xd_gendisk.part[minor].nr_sects = 0;
 	};
diff -urN S2/drivers/char/raw.c S2-s_lock-1/drivers/char/raw.c
--- S2/drivers/char/raw.c	Sun Oct  1 22:35:15 2000
+++ S2-s_lock-1/drivers/char/raw.c	Thu Feb 22 07:00:39 2001
@@ -103,7 +103,7 @@
 	 */
 	
 	sector_size = 512;
-	if (get_super(rdev) != NULL) {
+	if (is_mounted(rdev)) {
 		if (blksize_size[MAJOR(rdev)])
 			sector_size = blksize_size[MAJOR(rdev)][MINOR(rdev)];
 	} else {
diff -urN S2/drivers/char/sysrq.c S2-s_lock-1/drivers/char/sysrq.c
--- S2/drivers/char/sysrq.c	Thu Feb 22 06:22:37 2001
+++ S2-s_lock-1/drivers/char/sysrq.c	Thu Feb 22 07:00:39 2001
@@ -28,7 +28,6 @@
 
 extern void wakeup_bdflush(int);
 extern void reset_vc(unsigned int);
-extern struct list_head super_blocks;
 
 /* Whether we react on sysrq keys or just ignore them */
 int sysrq_enabled = 1;
diff -urN S2/drivers/i2o/i2o_block.c S2-s_lock-1/drivers/i2o/i2o_block.c
--- S2/drivers/i2o/i2o_block.c	Thu Feb 22 06:22:37 2001
+++ S2-s_lock-1/drivers/i2o/i2o_block.c	Thu Feb 22 07:00:40 2001
@@ -893,12 +893,7 @@
 	{
 		int m = minor+i;
 		kdev_t d = MKDEV(MAJOR_NR, m);
-		struct super_block *sb = get_super(d);
-		
-		sync_dev(d);
-		if(sb)
-			invalidate_inodes(sb);
-		invalidate_buffers(d);
+		invalidate_dev(d, 1);
 		i2ob_gendisk.part[m].start_sect = 0;
 		i2ob_gendisk.part[m].nr_sects = 0;
 	}
diff -urN S2/drivers/ide/hd.c S2-s_lock-1/drivers/ide/hd.c
--- S2/drivers/ide/hd.c	Thu Feb 22 06:22:37 2001
+++ S2-s_lock-1/drivers/ide/hd.c	Thu Feb 22 07:00:40 2001
@@ -893,12 +893,7 @@
 	for (i=max_p - 1; i >=0 ; i--) {
 		int minor = start + i;
 		kdev_t devi = MKDEV(MAJOR_NR, minor);
-		struct super_block *sb = get_super(devi); 
-
-		sync_dev(devi);
-		if (sb)
-			invalidate_inodes(sb);
-		invalidate_buffers(devi);
+		invalidate_dev(devi, 1);
 		gdev->part[minor].start_sect = 0;
 		gdev->part[minor].nr_sects = 0;
 	}
diff -urN S2/drivers/ide/ide.c S2-s_lock-1/drivers/ide/ide.c
--- S2/drivers/ide/ide.c	Thu Feb 22 06:22:37 2001
+++ S2-s_lock-1/drivers/ide/ide.c	Thu Feb 22 07:00:40 2001
@@ -1761,11 +1761,7 @@
 	for (p = 0; p < (1<<PARTN_BITS); ++p) {
 		if (drive->part[p].nr_sects > 0) {
 			kdev_t devp = MKDEV(major, minor+p);
-			struct super_block * sb = get_super(devp);
-			fsync_dev          (devp);
-			if (sb)
-				invalidate_inodes(sb);
-			invalidate_buffers (devp);
+			invalidate_dev(devp, 2);
 			set_blocksize(devp, 1024);
 		}
 		drive->part[p].start_sect = 0;
@@ -1982,9 +1978,7 @@
 		for (p = 0; p < (1<<PARTN_BITS); ++p) {
 			if (drive->part[p].nr_sects > 0) {
 				kdev_t devp = MKDEV(hwif->major, minor+p);
-				struct super_block * sb = get_super(devp);
-				if (sb) invalidate_inodes(sb);
-				invalidate_buffers (devp);
+				invalidate_dev(devp, 0);
 			}
 		}
 #ifdef CONFIG_PROC_FS
diff -urN S2/drivers/md/md.c S2-s_lock-1/drivers/md/md.c
--- S2/drivers/md/md.c	Thu Feb 22 06:22:38 2001
+++ S2-s_lock-1/drivers/md/md.c	Thu Feb 22 07:00:40 2001
@@ -1092,7 +1092,7 @@
 	}
 	memset(rdev, 0, sizeof(*rdev));
 
-	if (get_super(newdev)) {
+	if (is_mounted(newdev)) {
 		printk("md: can not import %s, has active inodes!\n",
 			partition_name(newdev));
 		err = -EBUSY;
@@ -1730,7 +1730,7 @@
  	}
  
  	/* this shouldn't be needed as above would have fired */
-	if (!ro && get_super(dev)) {
+	if (!ro && is_mounted(dev)) {
 		printk (STILL_MOUNTED, mdidx(mddev));
 		OUT(-EBUSY);
 	}
diff -urN S2/drivers/mtd/ftl.c S2-s_lock-1/drivers/mtd/ftl.c
--- S2/drivers/mtd/ftl.c	Thu Feb 22 06:22:40 2001
+++ S2-s_lock-1/drivers/mtd/ftl.c	Thu Feb 22 07:00:40 2001
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
+    invalidate_dev(inode->i_rdev, 2);
 
     /* Wait for any pending erase operations to complete */
     if (part->mtd->sync)
diff -urN S2/drivers/mtd/mtdblock.c S2-s_lock-1/drivers/mtd/mtdblock.c
--- S2/drivers/mtd/mtdblock.c	Thu Feb 22 06:22:40 2001
+++ S2-s_lock-1/drivers/mtd/mtdblock.c	Thu Feb 22 07:00:40 2001
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
+	invalidate_dev(inode->i_rdev, 2);
 
 	dev = MINOR(inode->i_rdev);
 	mtdblk = mtdblks[dev];
diff -urN S2/drivers/mtd/nftl.c S2-s_lock-1/drivers/mtd/nftl.c
--- S2/drivers/mtd/nftl.c	Thu Feb 22 06:22:40 2001
+++ S2-s_lock-1/drivers/mtd/nftl.c	Thu Feb 22 07:00:40 2001
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
+	invalidate_dev(inode->i_rdev, 2);
 
 	if (thisNFTL->mtd->sync)
 		thisNFTL->mtd->sync(thisNFTL->mtd);
diff -urN S2/drivers/scsi/sd.c S2-s_lock-1/drivers/scsi/sd.c
--- S2/drivers/scsi/sd.c	Thu Feb 22 06:22:47 2001
+++ S2-s_lock-1/drivers/scsi/sd.c	Thu Feb 22 07:00:40 2001
@@ -1262,11 +1262,7 @@
 	for (i = max_p - 1; i >= 0; i--) {
 		int index = start + i;
 		kdev_t devi = MKDEV_SD_PARTITION(index);
-		struct super_block *sb = get_super(devi);
-		sync_dev(devi);
-		if (sb)
-			invalidate_inodes(sb);
-		invalidate_buffers(devi);
+		invalidate_dev(devi, 1);
 		sd_gendisks->part[index].start_sect = 0;
 		sd_gendisks->part[index].nr_sects = 0;
 		/*
@@ -1315,11 +1311,7 @@
 			for (j = max_p - 1; j >= 0; j--) {
 				int index = start + j;
 				kdev_t devi = MKDEV_SD_PARTITION(index);
-				struct super_block *sb = get_super(devi);
-				sync_dev(devi);
-				if (sb)
-					invalidate_inodes(sb);
-				invalidate_buffers(devi);
+				invalidate_dev(devi, 1);
 				sd_gendisks->part[index].start_sect = 0;
 				sd_gendisks->part[index].nr_sects = 0;
 				sd_sizes[index] = 0;
diff -urN S2/drivers/scsi/sr.c S2-s_lock-1/drivers/scsi/sr.c
--- S2/drivers/scsi/sr.c	Thu Feb 22 06:22:47 2001
+++ S2-s_lock-1/drivers/scsi/sr.c	Thu Feb 22 07:00:40 2001
@@ -870,15 +870,11 @@
 	for (cpnt = scsi_CDs, i = 0; i < sr_template.dev_max; i++, cpnt++)
 		if (cpnt->device == SDp) {
 			kdev_t devi = MKDEV(MAJOR_NR, i);
-			struct super_block *sb = get_super(devi);
-
 			/*
 			 * Since the cdrom is read-only, no need to sync the device.
 			 * We should be kind to our buffer cache, however.
 			 */
-			if (sb)
-				invalidate_inodes(sb);
-			invalidate_buffers(devi);
+			invalidate_dev(devi, 0);
 
 			/*
 			 * Reset things back to a sane state so that one can re-load a new
diff -urN S2/fs/buffer.c S2-s_lock-1/fs/buffer.c
--- S2/fs/buffer.c	Thu Feb 22 06:22:55 2001
+++ S2-s_lock-1/fs/buffer.c	Thu Feb 22 07:00:40 2001
@@ -680,6 +680,19 @@
 		goto retry;
 }
 
+void invalidate_dev(kdev_t dev, int sync_flag)
+{
+	struct super_block *sb = get_super(dev);
+	if (sync_flag == 1)
+		sync_dev(dev);
+	else if (sync_flag == 2)
+		fsync_dev(dev);
+	if (sb) {
+		invalidate_inodes(sb);
+	}
+	invalidate_buffers(dev);
+}
+
 void set_blocksize(kdev_t dev, int size)
 {
 	extern int *blksize_size[];
diff -urN S2/include/linux/fs.h S2-s_lock-1/include/linux/fs.h
--- S2/include/linux/fs.h	Thu Feb 22 06:23:04 2001
+++ S2-s_lock-1/include/linux/fs.h	Thu Feb 22 07:00:40 2001
@@ -1093,6 +1093,7 @@
 extern void write_inode_now(struct inode *, int);
 extern void sync_dev(kdev_t);
 extern int fsync_dev(kdev_t);
+extern void invalidate_dev(kdev_t, int);
 extern int fsync_inode_buffers(struct inode *);
 extern int osync_inode_buffers(struct inode *);
 extern int inode_has_buffers(struct inode *);
@@ -1289,6 +1290,14 @@
 extern struct super_block *get_super(kdev_t);
 struct super_block *get_empty_super(void);
 extern void put_super(kdev_t);
+static inline int is_mounted(kdev_t dev)
+{
+	struct super_block *sb = get_super(dev);
+	if (sb) {
+		return 1;
+	}
+	return 0;
+}
 unsigned long generate_cluster(kdev_t, int b[], int);
 unsigned long generate_cluster_swab32(kdev_t, int b[], int);
 extern kdev_t ROOT_DEV;
diff -urN S2/kernel/ksyms.c S2-s_lock-1/kernel/ksyms.c
--- S2/kernel/ksyms.c	Thu Feb 22 06:23:05 2001
+++ S2-s_lock-1/kernel/ksyms.c	Thu Feb 22 07:00:40 2001
@@ -129,6 +129,7 @@
 EXPORT_SYMBOL(get_fs_type);
 EXPORT_SYMBOL(get_super);
 EXPORT_SYMBOL(get_empty_super);
+EXPORT_SYMBOL(invalidate_dev);
 EXPORT_SYMBOL(getname);
 EXPORT_SYMBOL(names_cachep);
 EXPORT_SYMBOL(fput);

