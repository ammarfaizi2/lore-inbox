Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315925AbSHOSbw>; Thu, 15 Aug 2002 14:31:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315946AbSHOSbw>; Thu, 15 Aug 2002 14:31:52 -0400
Received: from mnh-1-06.mv.com ([207.22.10.38]:31749 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S315925AbSHOSbu>;
	Thu, 15 Aug 2002 14:31:50 -0400
Message-Id: <200208151938.OAA02692@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: Linus Torvalds <torvalds@transmeta.com>, viro@math.psu.edu
cc: linux-kernel@vger.kernel.org, Jeff Dike <jdike@karaya.com>
Subject: [PATCH] Eliminate root_dev_names - part 1 of 2
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 15 Aug 2002 14:38:30 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch changes all instances of get_gendisk to get_gendisk_by_kdev_t.

The following patch, which actually removes the root_dev_names array,
introduces get_gendisk_by_name, so this keeps the naming somewhat consistent.

				Jeff

diff -Naur um-31/drivers/block/blkpg.c um/drivers/block/blkpg.c
--- um-31/drivers/block/blkpg.c	Mon Aug 12 22:29:47 2002
+++ um/drivers/block/blkpg.c	Thu Aug 15 11:02:29 2002
@@ -83,7 +83,7 @@
 		return -EINVAL;
 
 	/* find the drive major */
-	g = get_gendisk(dev);
+	g = get_gendisk_by_kdev_t(dev);
 	if (!g)
 		return -ENXIO;
 	part = g->part + minor(dev) - g->first_minor;
@@ -132,7 +132,7 @@
 	int holder;
 
 	/* find the drive major */
-	g = get_gendisk(dev);
+	g = get_gendisk_by_kdev_t(dev);
 	if (!g)
 		return -ENXIO;
 	part = g->part + minor(dev) - g->first_minor;
diff -Naur um-31/drivers/block/genhd.c um/drivers/block/genhd.c
--- um-31/drivers/block/genhd.c	Mon Aug 12 22:29:47 2002
+++ um/drivers/block/genhd.c	Thu Aug 15 11:21:47 2002
@@ -94,14 +94,14 @@
 
 
 /**
- * get_gendisk - get partitioning information for a given device
+ * get_gendisk_by_kdev_t - get partitioning information for a given device
  * @dev: device to get partitioning information for
  *
  * This function gets the structure containing partitioning
  * information for the given device @dev.
  */
 struct gendisk *
-get_gendisk(kdev_t dev)
+get_gendisk_by_kdev_t(kdev_t dev)
 {
 	struct gendisk *gp = NULL;
 	int major = major(dev);
@@ -122,7 +122,7 @@
 	return NULL;
 }
 
-EXPORT_SYMBOL(get_gendisk);
+EXPORT_SYMBOL(get_gendisk_by_kdev_t);
 
 #ifdef CONFIG_PROC_FS
 /* iterator */
diff -Naur um-31/drivers/ide/hptraid.c um/drivers/ide/hptraid.c
--- um-31/drivers/ide/hptraid.c	Sat Jul 27 21:52:34 2002
+++ um/drivers/ide/hptraid.c	Thu Aug 15 11:02:29 2002
@@ -306,7 +306,7 @@
 	/* now blank the /proc/partitions table for the wrong partition table,
 	   so that scripts don't accidentally mount it and crash the kernel */
 	/* XXX: the 0 is an utter hack  --hch */
-	gd = get_gendisk(mk_kdev(major, 0));
+	gd = get_gendisk_by_kdev_t(mk_kdev(major, 0));
 	if (gd != NULL) {
 		int j;
 		for (j = 1 + (minor << gd->minor_shift);
diff -Naur um-31/drivers/md/md.c um/drivers/md/md.c
--- um-31/drivers/md/md.c	Thu Aug  1 20:40:54 2002
+++ um/drivers/md/md.c	Thu Aug 15 11:02:28 2002
@@ -294,7 +294,7 @@
 	/*
 	 * ok, add this new device name to the list
 	 */
-	hd = get_gendisk (dev);
+	hd = get_gendisk_by_kdev_t (dev);
 	dname->name = NULL;
 	if (hd)
 		dname->name = disk_name (hd, minor(dev), dname->namebuf);
diff -Naur um-31/fs/block_dev.c um/fs/block_dev.c
--- um-31/fs/block_dev.c	Mon Aug 12 22:29:51 2002
+++ um/fs/block_dev.c	Thu Aug 15 11:02:31 2002
@@ -516,7 +516,7 @@
 	if (invalidate_device(dev, 0))
 		printk("VFS: busy inodes on changed media.\n");
 
-	disk = get_gendisk(dev);
+	disk = get_gendisk_by_kdev_t(dev);
 	part = disk->part + minor(dev) - disk->first_minor;
 	if (bdops->revalidate)
 		bdops->revalidate(dev);
@@ -531,7 +531,7 @@
 	down(&bdev->bd_sem);
 	res = check_disk_change(bdev);
 	if (bdev->bd_invalidated && !bdev->bd_part_count) {
-		struct gendisk *g = get_gendisk(to_kdev_t(bdev->bd_dev));
+		struct gendisk *g = get_gendisk_by_kdev_t(to_kdev_t(bdev->bd_dev));
 		struct hd_struct *part;
 		part = g->part + MINOR(bdev->bd_dev) - g->first_minor;
 		bdev->bd_invalidated = 0;
@@ -599,7 +599,7 @@
 	}
 	if (!bdev->bd_contains) {
 		unsigned minor = minor(dev);
-		struct gendisk *g = get_gendisk(dev);
+		struct gendisk *g = get_gendisk_by_kdev_t(dev);
 		bdev->bd_contains = bdev;
 		if (g) {
 			int shift = g->minor_shift;
@@ -618,7 +618,7 @@
 		}
 	}
 	if (bdev->bd_contains == bdev) {
-		struct gendisk *g = get_gendisk(dev);
+		struct gendisk *g = get_gendisk_by_kdev_t(dev);
 		if (bdev->bd_op->open) {
 			ret = bdev->bd_op->open(inode, file);
 			if (ret)
@@ -659,7 +659,7 @@
 		down(&bdev->bd_contains->bd_sem);
 		bdev->bd_contains->bd_part_count++;
 		if (!bdev->bd_openers) {
-			struct gendisk *g = get_gendisk(dev);
+			struct gendisk *g = get_gendisk_by_kdev_t(dev);
 			struct hd_struct *p;
 			p = g->part + minor(dev) - g->first_minor;
 			inode->i_data.backing_dev_info =
@@ -788,7 +788,7 @@
 static int blkdev_reread_part(struct block_device *bdev)
 {
 	kdev_t dev = to_kdev_t(bdev->bd_dev);
-	struct gendisk *disk = get_gendisk(dev);
+	struct gendisk *disk = get_gendisk_by_kdev_t(dev);
 	struct hd_struct *part;
 	int res;
 
diff -Naur um-31/fs/partitions/check.c um/fs/partitions/check.c
--- um-31/fs/partitions/check.c	Mon Aug 12 22:29:52 2002
+++ um/fs/partitions/check.c	Thu Aug 15 11:02:30 2002
@@ -462,7 +462,7 @@
 void grok_partitions(kdev_t dev, long size)
 {
 	struct block_device *bdev;
-	struct gendisk *g = get_gendisk(dev);
+	struct gendisk *g = get_gendisk_by_kdev_t(dev);
 	struct hd_struct *p;
 
 	if (!g)
@@ -516,7 +516,7 @@
 	int p, major, minor, minor0, max_p, res;
 	struct hd_struct *part;
 
-	g = get_gendisk(dev);
+	g = get_gendisk_by_kdev_t(dev);
 	if (g == NULL)
 		return -EINVAL;
 
diff -Naur um-31/include/linux/genhd.h um/include/linux/genhd.h
--- um-31/include/linux/genhd.h	Thu Aug  1 20:41:00 2002
+++ um/include/linux/genhd.h	Thu Aug 15 11:02:30 2002
@@ -89,7 +89,7 @@
 /* drivers/block/genhd.c */
 extern void add_gendisk(struct gendisk *gp);
 extern void del_gendisk(struct gendisk *gp);
-extern struct gendisk *get_gendisk(kdev_t dev);
+extern struct gendisk *get_gendisk_by_kdev_t(kdev_t dev);
 static inline unsigned long get_start_sect(struct block_device *bdev)
 {
 	return bdev->bd_offset;
@@ -250,7 +250,7 @@
 
 static inline unsigned int disk_index (kdev_t dev)
 {
-	struct gendisk *g = get_gendisk(dev);
+	struct gendisk *g = get_gendisk_by_kdev_t(dev);
 	return g ? (minor(dev) >> g->minor_shift) : 0;
 }
 

