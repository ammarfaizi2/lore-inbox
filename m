Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315372AbSGEFCX>; Fri, 5 Jul 2002 01:02:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315379AbSGEFCW>; Fri, 5 Jul 2002 01:02:22 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:53917 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S315372AbSGEFCT>;
	Fri, 5 Jul 2002 01:02:19 -0400
Date: Fri, 5 Jul 2002 01:04:53 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] md_import_device() cleanup
Message-ID: <Pine.GSO.4.21.0207050103360.14718-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	* md_import_device() returns resulting rdev or ERR_PTR(error)
instead of returning 0 or error an letting caller find rdev.

diff -urN C24-0/drivers/md/md.c C24-current/drivers/md/md.c
--- C24-0/drivers/md/md.c	Sat Jun 29 16:18:42 2002
+++ C24-current/drivers/md/md.c	Sat Jun 29 17:01:06 2002
@@ -1001,19 +1001,19 @@
  *
  * a faulty rdev _never_ has rdev->sb set.
  */
-static int md_import_device(kdev_t newdev, int on_disk)
+static mdk_rdev_t *md_import_device(kdev_t newdev, int on_disk)
 {
 	int err;
 	mdk_rdev_t *rdev;
 	unsigned int size;
 
 	if (find_rdev_all(newdev))
-		return -EEXIST;
+		return ERR_PTR(-EEXIST);
 
 	rdev = (mdk_rdev_t *) kmalloc(sizeof(*rdev), GFP_KERNEL);
 	if (!rdev) {
 		printk(KERN_ERR "md: could not alloc mem for %s!\n", partition_name(newdev));
-		return -ENOMEM;
+		return ERR_PTR(-ENOMEM);
 	}
 	memset(rdev, 0, sizeof(*rdev));
 
@@ -1066,7 +1066,7 @@
 
 	if (rdev->faulty && rdev->sb)
 		free_disk_sb(rdev);
-	return 0;
+	return rdev;
 
 abort_free:
 	if (rdev->sb) {
@@ -1075,7 +1075,7 @@
 		free_disk_sb(rdev);
 	}
 	kfree(rdev);
-	return err;
+	return ERR_PTR(err);
 }
 
 /*
@@ -1950,16 +1950,12 @@
 	mdp_super_t *sb = NULL;
 	mdk_rdev_t *start_rdev = NULL, *rdev;
 
-	if (md_import_device(startdev, 1)) {
+	start_rdev = md_import_device(startdev, 1);
+	if (IS_ERR(start_rdev)) {
 		printk(KERN_WARNING "md: could not import %s!\n", partition_name(startdev));
 		goto abort;
 	}
 
-	start_rdev = find_rdev_all(startdev);
-	if (!start_rdev) {
-		MD_BUG();
-		goto abort;
-	}
 	if (start_rdev->faulty) {
 		printk(KERN_WARNING "md: can not autostart based on faulty %s!\n",
 						partition_name(startdev));
@@ -1988,16 +1984,12 @@
 			continue;
 		if (kdev_same(dev, startdev))
 			continue;
-		if (md_import_device(dev, 1)) {
+		rdev = md_import_device(dev, 1);
+		if (IS_ERR(rdev)) {
 			printk(KERN_WARNING "md: could not import %s, trying to run array nevertheless.\n",
 			       partition_name(dev));
 			continue;
 		}
-		rdev = find_rdev_all(dev);
-		if (!rdev) {
-			MD_BUG();
-			goto abort;
-		}
 		list_add(&rdev->pending, &pending_raid_disks);
 	}
 
@@ -2107,7 +2099,7 @@
 
 static int add_new_disk(mddev_t * mddev, mdu_disk_info_t *info)
 {
-	int err, size, persistent;
+	int size, persistent;
 	mdk_rdev_t *rdev;
 	unsigned int nr;
 	kdev_t dev;
@@ -2120,14 +2112,9 @@
 	}
 	if (!mddev->sb) {
 		/* expecting a device which has a superblock */
-		err = md_import_device(dev, 1);
-		if (err) {
-			printk(KERN_WARNING "md: md_import_device returned %d\n", err);
-			return -EINVAL;
-		}
-		rdev = find_rdev_all(dev);
-		if (!rdev) {
-			MD_BUG();
+		rdev = md_import_device(dev, 1);
+		if (IS_ERR(rdev)) {
+			printk(KERN_WARNING "md: md_import_device returned %ld\n", PTR_ERR(rdev));
 			return -EINVAL;
 		}
 		if (!list_empty(&mddev->disks)) {
@@ -2164,17 +2151,11 @@
 	SET_SB(state);
 
 	if (!(info->state & (1<<MD_DISK_FAULTY))) {
-		err = md_import_device (dev, 0);
-		if (err) {
-			printk(KERN_WARNING "md: error, md_import_device() returned %d\n", err);
+		rdev = md_import_device (dev, 0);
+		if (IS_ERR(rdev)) {
+			printk(KERN_WARNING "md: error, md_import_device() returned %ld\n", PTR_ERR(rdev));
 			return -EINVAL;
 		}
-		rdev = find_rdev_all(dev);
-		if (!rdev) {
-			MD_BUG();
-			return -EINVAL;
-		}
-
 		rdev->old_dev = dev;
 		rdev->desc_nr = info->number;
 
@@ -2317,17 +2298,11 @@
 	if (rdev)
 		return -EBUSY;
 
-	err = md_import_device (dev, 0);
-	if (err) {
-		printk(KERN_WARNING "md: error, md_import_device() returned %d\n", err);
-		return -EINVAL;
-	}
-	rdev = find_rdev_all(dev);
-	if (!rdev) {
-		MD_BUG();
+	rdev = md_import_device (dev, 0);
+	if (IS_ERR(rdev)) {
+		printk(KERN_WARNING "md: error, md_import_device() returned %ld\n", PTR_ERR(rdev));
 		return -EINVAL;
 	}
-
 	persistent = !mddev->sb->not_persistent;
 	size = calc_dev_size(rdev, mddev, persistent);
 
@@ -3594,17 +3569,10 @@
 	for (i = 0; i < dev_cnt; i++) {
 		kdev_t dev = detected_devices[i];
 
-		if (md_import_device(dev,1)) {
+		rdev = md_import_device(dev,1);
+		if (IS_ERR(rdev)) {
 			printk(KERN_ALERT "md: could not import %s!\n",
 				partition_name(dev));
-			continue;
-		}
-		/*
-		 * Sanity checks:
-		 */
-		rdev = find_rdev_all(dev);
-		if (!rdev) {
-			MD_BUG();
 			continue;
 		}
 		if (rdev->faulty) {

