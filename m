Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315388AbSGEE6n>; Fri, 5 Jul 2002 00:58:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315414AbSGEE6m>; Fri, 5 Jul 2002 00:58:42 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:13719 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S315388AbSGEE6e>;
	Fri, 5 Jul 2002 00:58:34 -0400
Date: Fri, 5 Jul 2002 01:01:08 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] raid kdev_t cleanups - part 2
Message-ID: <Pine.GSO.4.21.0207050058540.14718-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	(this should go after ->diskop patch)
	* a bunch of callers of partition_name() are calling
bdev_partition_name(),
	* the last users of raid1 and multipath ->dev are gone; so are
the fields in question.

diff -urN C24-0/drivers/md/multipath.c C24-current/drivers/md/multipath.c
--- C24-0/drivers/md/multipath.c	Sat Jun 29 16:18:42 2002
+++ C24-current/drivers/md/multipath.c	Sat Jun 29 16:38:06 2002
@@ -312,7 +312,7 @@
 	mddev->sb_dirty = 1;
 	md_wakeup_thread(conf->thread);
 	conf->working_disks--;
-	printk (DISK_FAILED, partition_name (multipath->dev),
+	printk (DISK_FAILED, bdev_partition_name (multipath->bdev),
 				 conf->working_disks);
 }
 
@@ -405,7 +405,7 @@
 			printk(" disk%d, s:%d, o:%d, n:%d rd:%d us:%d dev:%s\n",
 				i, tmp->spare,tmp->operational,
 				tmp->number,tmp->raid_disk,tmp->used_slot,
-				partition_name(tmp->dev));
+				bdev_partition_name(tmp->bdev));
 	}
 }
 
@@ -594,7 +594,6 @@
 				break;
 			p->number = added_desc->number;
 			p->raid_disk = added_desc->raid_disk;
-			p->dev = rdev->dev;
 			p->bdev = rdev->bdev;
 			p->operational = 0;
 			p->spare = 1;
@@ -631,7 +630,6 @@
 			}
 			if (p->spare && i < conf->raid_disks)
 				break;
-			p->dev = NODEV;
 			p->bdev = NULL;
 			p->used_slot = 0;
 			conf->nr_disks--;
@@ -853,7 +851,7 @@
 		if (rdev->faulty) {
 			/* this is a "should never happen" case and if it */
 			/* ever does happen, a continue; won't help */
-			printk(ERRORS, partition_name(rdev->dev));
+			printk(ERRORS, bdev_partition_name(rdev->bdev));
 			continue;
 		} else {
 			/* this is a "should never happen" case and if it */
@@ -873,7 +871,7 @@
 		disk = conf->multipaths + disk_idx;
 
 		if (!disk_sync(desc))
-			printk(NOT_IN_SYNC, partition_name(rdev->dev));
+			printk(NOT_IN_SYNC, bdev_partition_name(rdev->bdev));
 
 		/*
 		 * Mark all disks as spare to start with, then pick our
@@ -882,7 +880,6 @@
 		 */
 		disk->number = desc->number;
 		disk->raid_disk = desc->raid_disk;
-		disk->dev = rdev->dev;
 		disk->bdev = rdev->bdev;
 		atomic_inc(&rdev->bdev->bd_count);
 		disk->operational = 0;
@@ -892,7 +889,7 @@
 
 		if (disk_active(desc)) {
 			if(!conf->working_disks) {
-				printk(OPERATIONAL, partition_name(rdev->dev),
+				printk(OPERATIONAL, bdev_partition_name(rdev->bdev),
  					desc->raid_disk);
 				disk->operational = 1;
 				disk->spare = 0;
@@ -909,7 +906,7 @@
 	if(!conf->working_disks && num_rdevs) {
 		desc = &sb->disks[def_rdev->desc_nr];
 		disk = conf->multipaths + desc->raid_disk;
-		printk(OPERATIONAL, partition_name(def_rdev->dev),
+		printk(OPERATIONAL, bdev_partition_name(def_rdev->bdev),
 			disk->raid_disk);
 		disk->operational = 1;
 		disk->spare = 0;
diff -urN C24-0/drivers/md/raid1.c C24-current/drivers/md/raid1.c
--- C24-0/drivers/md/raid1.c	Sat Jun 29 16:18:42 2002
+++ C24-current/drivers/md/raid1.c	Sat Jun 29 16:36:14 2002
@@ -589,7 +589,7 @@
 	md_wakeup_thread(conf->thread);
 	if (!mirror->write_only)
 		conf->working_disks--;
-	printk(DISK_FAILED, partition_name(mirror->dev), conf->working_disks);
+	printk(DISK_FAILED, bdev_partition_name(mirror->bdev), conf->working_disks);
 }
 
 static int error(mddev_t *mddev, struct block_device *bdev)
@@ -640,7 +640,7 @@
 		printk(" disk %d, s:%d, o:%d, n:%d rd:%d us:%d dev:%s\n",
 			i, tmp->spare, tmp->operational,
 			tmp->number, tmp->raid_disk, tmp->used_slot,
-			partition_name(tmp->dev));
+			bdev_partition_name(tmp->bdev));
 	}
 }
 
@@ -848,7 +848,6 @@
 				break;
 			p->number = added_desc->number;
 			p->raid_disk = added_desc->raid_disk;
-			p->dev = rdev->dev;
 			/* it will be held open by rdev */
 			p->bdev = rdev->bdev;
 			p->operational = 0;
@@ -886,7 +885,6 @@
 			}
 			if (p->spare && (i < conf->raid_disks))
 				break;
-			p->dev = NODEV;
 			p->bdev = NULL;
 			p->used_slot = 0;
 			conf->nr_disks--;
@@ -1284,7 +1282,7 @@
 
 	ITERATE_RDEV(mddev, rdev, tmp) {
 		if (rdev->faulty) {
-			printk(ERRORS, partition_name(rdev->dev));
+			printk(ERRORS, bdev_partition_name(rdev->bdev));
 		} else {
 			if (!rdev->sb) {
 				MD_BUG();
@@ -1302,7 +1300,6 @@
 		if (disk_faulty(descriptor)) {
 			disk->number = descriptor->number;
 			disk->raid_disk = disk_idx;
-			disk->dev = rdev->dev;
 			disk->bdev = rdev->bdev;
 			atomic_inc(&rdev->bdev->bd_count);
 			disk->operational = 0;
@@ -1315,27 +1312,26 @@
 		if (disk_active(descriptor)) {
 			if (!disk_sync(descriptor)) {
 				printk(NOT_IN_SYNC,
-					partition_name(rdev->dev));
+					bdev_partition_name(rdev->bdev));
 				continue;
 			}
 			if ((descriptor->number > MD_SB_DISKS) ||
 					(disk_idx > sb->raid_disks)) {
 
 				printk(INCONSISTENT,
-					partition_name(rdev->dev));
+					bdev_partition_name(rdev->bdev));
 				continue;
 			}
 			if (disk->operational) {
 				printk(ALREADY_RUNNING,
-					partition_name(rdev->dev),
+					bdev_partition_name(rdev->bdev),
 					disk_idx);
 				continue;
 			}
-			printk(OPERATIONAL, partition_name(rdev->dev),
+			printk(OPERATIONAL, bdev_partition_name(rdev->bdev),
 					disk_idx);
 			disk->number = descriptor->number;
 			disk->raid_disk = disk_idx;
-			disk->dev = rdev->dev;
 			disk->bdev = rdev->bdev;
 			atomic_inc(&rdev->bdev->bd_count);
 			disk->operational = 1;
@@ -1348,10 +1344,9 @@
 		/*
 		 * Must be a spare disk ..
 		 */
-			printk(SPARE, partition_name(rdev->dev));
+			printk(SPARE, bdev_partition_name(rdev->bdev));
 			disk->number = descriptor->number;
 			disk->raid_disk = disk_idx;
-			disk->dev = rdev->dev;
 			disk->bdev = rdev->bdev;
 			atomic_inc(&rdev->bdev->bd_count);
 			disk->operational = 0;
@@ -1385,7 +1380,6 @@
 				!disk->used_slot) {
 			disk->number = descriptor->number;
 			disk->raid_disk = disk_idx;
-			disk->dev = NODEV;
 			disk->bdev = NULL;
 			disk->operational = 0;
 			disk->write_only = 0;
diff -urN C24-0/drivers/md/raid5.c C24-current/drivers/md/raid5.c
--- C24-0/drivers/md/raid5.c	Sat Jun 29 16:18:42 2002
+++ C24-current/drivers/md/raid5.c	Sat Jun 29 16:49:52 2002
@@ -441,7 +441,6 @@
 
 static int error(mddev_t *mddev, struct block_device *bdev)
 {
-	kdev_t dev = to_kdev_t(bdev->bd_dev);
 	raid5_conf_t *conf = (raid5_conf_t *) mddev->private;
 	mdp_super_t *sb = mddev->sb;
 	struct disk_info *disk;
@@ -467,7 +466,7 @@
 			printk (KERN_ALERT
 				"raid5: Disk failure on %s, disabling device."
 				" Operation continuing on %d devices\n",
-				partition_name (dev), conf->working_disks);
+				bdev_partition_name(bdev), conf->working_disks);
 		}
 		return 0;
 	}
@@ -479,7 +478,7 @@
 		if (disk->bdev == bdev) {
 			printk (KERN_ALERT
 				"raid5: Disk failure on spare %s\n",
-				partition_name (dev));
+				bdev_partition_name (bdev));
 			if (!conf->spare->operational) {
 				/* probably a SET_DISK_FAULTY ioctl */
 				return -EIO;
@@ -1429,7 +1428,7 @@
 		disk = conf->disks + raid_disk;
 
 		if (disk_faulty(desc)) {
-			printk(KERN_ERR "raid5: disabled device %s (errors detected)\n", partition_name(rdev->dev));
+			printk(KERN_ERR "raid5: disabled device %s (errors detected)\n", bdev_partition_name(rdev->bdev));
 			if (!rdev->faulty) {
 				MD_BUG();
 				goto abort;
@@ -1446,19 +1445,19 @@
 		}
 		if (disk_active(desc)) {
 			if (!disk_sync(desc)) {
-				printk(KERN_ERR "raid5: disabled device %s (not in sync)\n", partition_name(rdev->dev));
+				printk(KERN_ERR "raid5: disabled device %s (not in sync)\n", bdev_partition_name(rdev->bdev));
 				MD_BUG();
 				goto abort;
 			}
 			if (raid_disk > sb->raid_disks) {
-				printk(KERN_ERR "raid5: disabled device %s (inconsistent descriptor)\n", partition_name(rdev->dev));
+				printk(KERN_ERR "raid5: disabled device %s (inconsistent descriptor)\n", bdev_partition_name(rdev->bdev));
 				continue;
 			}
 			if (disk->operational) {
-				printk(KERN_ERR "raid5: disabled device %s (device %d already operational)\n", partition_name(rdev->dev), raid_disk);
+				printk(KERN_ERR "raid5: disabled device %s (device %d already operational)\n", bdev_partition_name(rdev->bdev), raid_disk);
 				continue;
 			}
-			printk(KERN_INFO "raid5: device %s operational as raid disk %d\n", partition_name(rdev->dev), raid_disk);
+			printk(KERN_INFO "raid5: device %s operational as raid disk %d\n", bdev_partition_name(rdev->bdev), raid_disk);
 	
 			disk->number = desc->number;
 			disk->raid_disk = raid_disk;
@@ -1471,7 +1470,7 @@
 			/*
 			 * Must be a spare disk ..
 			 */
-			printk(KERN_INFO "raid5: spare disk %s\n", partition_name(rdev->dev));
+			printk(KERN_INFO "raid5: spare disk %s\n", bdev_partition_name(rdev->bdev));
 			disk->number = desc->number;
 			disk->raid_disk = raid_disk;
 			disk->bdev = rdev->bdev;
@@ -1688,9 +1687,7 @@
 		printk(" disk %d, s:%d, o:%d, n:%d rd:%d us:%d dev:%s\n",
 			i, tmp->spare,tmp->operational,
 			tmp->number,tmp->raid_disk,tmp->used_slot,
-			partition_name(tmp->bdev ?
-					to_kdev_t(tmp->bdev->bd_dev):
-					NODEV));
+			bdev_partition_name(tmp->bdev));
 	}
 }
 
diff -urN C24-0/include/linux/raid/md.h C24-current/include/linux/raid/md.h
--- C24-0/include/linux/raid/md.h	Mon Jun 24 23:41:24 2002
+++ C24-current/include/linux/raid/md.h	Sat Jun 29 16:41:48 2002
@@ -66,7 +66,7 @@
 extern char * partition_name (kdev_t dev);
 extern inline char * bdev_partition_name (struct block_device *bdev)
 {
-	return partition_name(to_kdev_t(bdev->bd_dev));
+	return partition_name(bdev ? to_kdev_t(bdev->bd_dev) : NODEV);
 }
 extern int register_md_personality (int p_num, mdk_personality_t *p);
 extern int unregister_md_personality (int p_num);
diff -urN C24-0/include/linux/raid/multipath.h C24-current/include/linux/raid/multipath.h
--- C24-0/include/linux/raid/multipath.h	Mon Apr 29 08:06:41 2002
+++ C24-current/include/linux/raid/multipath.h	Sat Jun 29 16:38:21 2002
@@ -6,7 +6,6 @@
 struct multipath_info {
 	int		number;
 	int		raid_disk;
-	kdev_t		dev;
 	struct block_device *bdev;
 
 	/*
diff -urN C24-0/include/linux/raid/raid1.h C24-current/include/linux/raid/raid1.h
--- C24-0/include/linux/raid/raid1.h	Thu Jun 20 13:37:25 2002
+++ C24-current/include/linux/raid/raid1.h	Sat Jun 29 16:36:24 2002
@@ -8,7 +8,6 @@
 struct mirror_info {
 	int		number;
 	int		raid_disk;
-	kdev_t		dev;
 	struct block_device *bdev;
 	sector_t	head_position;
 	atomic_t	nr_pending;

