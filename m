Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315358AbSGEEvo>; Fri, 5 Jul 2002 00:51:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315370AbSGEEvn>; Fri, 5 Jul 2002 00:51:43 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:30092 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S315358AbSGEEvk>;
	Fri, 5 Jul 2002 00:51:40 -0400
Date: Fri, 5 Jul 2002 00:54:14 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] raid kdev_t cleanups (part 1)
Message-ID: <Pine.GSO.4.21.0207050049460.14718-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	* ->error_handler() switched to struct block_device *.
	* md_sync_acct() switched to struct block_device *.
	* raid5 struct disk_info ->dev is gone - we use ->bdev everywhere.
	* bunch of kdev_same() when we have corresponding struct block_device *
and can simply compare them is removed from drivers/md/*.c

diff -urN C24-0/drivers/md/md.c C24-current/drivers/md/md.c
--- C24-0/drivers/md/md.c	Mon Jun 24 18:45:44 2002
+++ C24-current/drivers/md/md.c	Mon Jun 24 19:40:04 2002
@@ -2924,7 +2924,7 @@
 	if (!rrdev || rrdev->faulty)
 		return 0;
 	if (!mddev->pers->error_handler
-			|| mddev->pers->error_handler(mddev,rdev) <= 0) {
+			|| mddev->pers->error_handler(mddev,bdev) <= 0) {
 		rrdev->faulty = 1;
 	} else
 		return 1;
@@ -3136,8 +3136,9 @@
 }
 
 static unsigned int sync_io[DK_MAX_MAJOR][DK_MAX_DISK];
-void md_sync_acct(kdev_t dev, unsigned long nr_sectors)
+void md_sync_acct(struct block_device *bdev, unsigned long nr_sectors)
 {
+	kdev_t dev = to_kdev_t(bdev->bd_dev);
 	unsigned int major = major(dev);
 	unsigned int index;
 
diff -urN C24-0/drivers/md/multipath.c C24-current/drivers/md/multipath.c
--- C24-0/drivers/md/multipath.c	Thu Jun 20 13:37:24 2002
+++ C24-current/drivers/md/multipath.c	Mon Jun 24 19:37:14 2002
@@ -320,7 +320,7 @@
 /*
  * Careful, this can execute in IRQ contexts as well!
  */
-static int multipath_error (mddev_t *mddev, kdev_t dev)
+static int multipath_error (mddev_t *mddev, struct block_device *bdev)
 {
 	multipath_conf_t *conf = mddev_to_conf(mddev);
 	struct multipath_info * multipaths = conf->multipaths;
@@ -345,7 +345,7 @@
 		 * which has just failed.
 		 */
 		for (i = 0; i < disks; i++) {
-			if (kdev_same(multipaths[i].dev, dev) && !multipaths[i].operational)
+			if (multipaths[i].bdev == bdev && !multipaths[i].operational)
 				return 0;
 		}
 		printk (LAST_DISK);
@@ -354,7 +354,7 @@
 		 * Mark disk as unusable
 		 */
 		for (i = 0; i < disks; i++) {
-			if (kdev_same(multipaths[i].dev,dev) && multipaths[i].operational) {
+			if (multipaths[i].bdev == bdev && multipaths[i].operational) {
 				mark_disk_bad(mddev, i);
 				break;
 			}
diff -urN C24-0/drivers/md/raid1.c C24-current/drivers/md/raid1.c
--- C24-0/drivers/md/raid1.c	Thu Jun 20 13:37:24 2002
+++ C24-current/drivers/md/raid1.c	Mon Jun 24 19:40:22 2002
@@ -592,7 +592,7 @@
 	printk(DISK_FAILED, partition_name(mirror->dev), conf->working_disks);
 }
 
-static int error(mddev_t *mddev, kdev_t dev)
+static int error(mddev_t *mddev, struct block_device *bdev)
 {
 	conf_t *conf = mddev_to_conf(mddev);
 	mirror_info_t * mirrors = conf->mirrors;
@@ -607,7 +607,7 @@
 	 * else mark the drive as failed
 	 */
 	for (i = 0; i < disks; i++)
-		if (kdev_same(mirrors[i].dev, dev) && mirrors[i].operational)
+		if (mirrors[i].bdev == bdev && mirrors[i].operational)
 			break;
 	if (i == disks)
 		return 0;
@@ -1045,7 +1045,7 @@
 		if (!mbio)
 			continue;
 
-		md_sync_acct(to_kdev_t(mbio->bi_bdev->bd_dev), mbio->bi_size >> 9);
+		md_sync_acct(mbio->bi_bdev, mbio->bi_size >> 9);
 		generic_make_request(mbio);
 		atomic_inc(&conf->mirrors[i].nr_pending);
 	}
@@ -1217,7 +1217,7 @@
 		BUG();
 	r1_bio->read_bio = read_bio;
 
-	md_sync_acct(to_kdev_t(read_bio->bi_bdev->bd_dev), nr_sectors);
+	md_sync_acct(read_bio->bi_bdev, nr_sectors);
 
 	generic_make_request(read_bio);
 	atomic_inc(&conf->mirrors[conf->last_used].nr_pending);
diff -urN C24-0/drivers/md/raid5.c C24-current/drivers/md/raid5.c
--- C24-0/drivers/md/raid5.c	Thu Jun 20 13:37:24 2002
+++ C24-current/drivers/md/raid5.c	Mon Jun 24 19:47:45 2002
@@ -439,8 +439,9 @@
 		dev->sector = compute_blocknr(sh, i);
 }
 
-static int error (mddev_t *mddev, kdev_t dev)
+static int error(mddev_t *mddev, struct block_device *bdev)
 {
+	kdev_t dev = to_kdev_t(bdev->bd_dev);
 	raid5_conf_t *conf = (raid5_conf_t *) mddev->private;
 	mdp_super_t *sb = mddev->sb;
 	struct disk_info *disk;
@@ -449,33 +450,33 @@
 	PRINTK("raid5: error called\n");
 
 	for (i = 0, disk = conf->disks; i < conf->raid_disks; i++, disk++) {
-		if (kdev_same(disk->dev, dev)) {
-			if (disk->operational) {
-				disk->operational = 0;
-				mark_disk_faulty(sb->disks+disk->number);
-				mark_disk_nonsync(sb->disks+disk->number);
-				mark_disk_inactive(sb->disks+disk->number);
-				sb->active_disks--;
-				sb->working_disks--;
-				sb->failed_disks++;
-				mddev->sb_dirty = 1;
-				conf->working_disks--;
-				conf->failed_disks++;
-				md_wakeup_thread(conf->thread);
-				printk (KERN_ALERT
-					"raid5: Disk failure on %s, disabling device."
-					" Operation continuing on %d devices\n",
-					partition_name (dev), conf->working_disks);
-			}
-			return 0;
+		if (disk->bdev != bdev)
+			continue;
+		if (disk->operational) {
+			disk->operational = 0;
+			mark_disk_faulty(sb->disks+disk->number);
+			mark_disk_nonsync(sb->disks+disk->number);
+			mark_disk_inactive(sb->disks+disk->number);
+			sb->active_disks--;
+			sb->working_disks--;
+			sb->failed_disks++;
+			mddev->sb_dirty = 1;
+			conf->working_disks--;
+			conf->failed_disks++;
+			md_wakeup_thread(conf->thread);
+			printk (KERN_ALERT
+				"raid5: Disk failure on %s, disabling device."
+				" Operation continuing on %d devices\n",
+				partition_name (dev), conf->working_disks);
 		}
+		return 0;
 	}
 	/*
 	 * handle errors in spares (during reconstruction)
 	 */
 	if (conf->spare) {
 		disk = conf->spare;
-		if (kdev_same(disk->dev, dev)) {
+		if (disk->bdev == bdev) {
 			printk (KERN_ALERT
 				"raid5: Disk failure on spare %s\n",
 				partition_name (dev));
@@ -1017,7 +1018,7 @@
 					locked++;
 					PRINTK("Reading block %d (sync=%d)\n", i, syncing);
 					if (syncing)
-						md_sync_acct(conf->disks[i].dev, STRIPE_SECTORS);
+						md_sync_acct(conf->disks[i].bdev, STRIPE_SECTORS);
 				}
 			}
 		}
@@ -1156,9 +1157,9 @@
 			locked++;
 			set_bit(STRIPE_INSYNC, &sh->state);
 			if (conf->disks[failed_num].operational)
-				md_sync_acct(conf->disks[failed_num].dev, STRIPE_SECTORS);
+				md_sync_acct(conf->disks[failed_num].bdev, STRIPE_SECTORS);
 			else if ((spare=conf->spare))
-				md_sync_acct(spare->dev, STRIPE_SECTORS);
+				md_sync_acct(spare->bdev, STRIPE_SECTORS);
 
 		}
 	}
@@ -1435,7 +1436,6 @@
 			}
 			disk->number = desc->number;
 			disk->raid_disk = raid_disk;
-			disk->dev = rdev->dev;
 			disk->bdev = rdev->bdev;
 
 			disk->operational = 0;
@@ -1462,7 +1462,6 @@
 	
 			disk->number = desc->number;
 			disk->raid_disk = raid_disk;
-			disk->dev = rdev->dev;
 			disk->bdev = rdev->bdev;
 			disk->operational = 1;
 			disk->used_slot = 1;
@@ -1475,7 +1474,6 @@
 			printk(KERN_INFO "raid5: spare disk %s\n", partition_name(rdev->dev));
 			disk->number = desc->number;
 			disk->raid_disk = raid_disk;
-			disk->dev = rdev->dev;
 			disk->bdev = rdev->bdev;
 
 			disk->operational = 0;
@@ -1495,7 +1493,6 @@
 
 			disk->number = desc->number;
 			disk->raid_disk = raid_disk;
-			disk->dev = NODEV;
 			disk->bdev = NULL;
 
 			disk->operational = 0;
@@ -1691,7 +1688,9 @@
 		printk(" disk %d, s:%d, o:%d, n:%d rd:%d us:%d dev:%s\n",
 			i, tmp->spare,tmp->operational,
 			tmp->number,tmp->raid_disk,tmp->used_slot,
-			partition_name(tmp->dev));
+			partition_name(tmp->bdev ?
+					to_kdev_t(tmp->bdev->bd_dev):
+					NODEV));
 	}
 }
 
@@ -1903,7 +1902,7 @@
 
 		*d = failed_desc;
 
-		if (kdev_none(sdisk->dev))
+		if (!sdisk->bdev)
 			sdisk->used_slot = 0;
 
 		/*
@@ -1931,7 +1930,6 @@
 			err = 1;
 			goto abort;
 		}
-		rdisk->dev = NODEV;
 		rdisk->bdev = NULL;
 		rdisk->used_slot = 0;
 
@@ -1949,9 +1947,8 @@
 
 		adisk->number = added_desc->number;
 		adisk->raid_disk = added_desc->raid_disk;
-		adisk->dev = mk_kdev(added_desc->major,added_desc->minor);
 		/* it will be held open by rdev */
-		adisk->bdev = bdget(kdev_t_to_nr(adisk->dev));
+		adisk->bdev = bdget(MKDEV(added_desc->major,added_desc->minor));
 
 		adisk->operational = 0;
 		adisk->write_only = 0;
diff -urN C24-0/include/linux/raid/md.h C24-current/include/linux/raid/md.h
--- C24-0/include/linux/raid/md.h	Thu Jun 20 13:37:25 2002
+++ C24-current/include/linux/raid/md.h	Mon Jun 24 19:40:51 2002
@@ -77,7 +77,7 @@
 extern void md_interrupt_thread (mdk_thread_t *thread);
 extern void md_update_sb (mddev_t *mddev);
 extern void md_done_sync(mddev_t *mddev, int blocks, int ok);
-extern void md_sync_acct(kdev_t dev, unsigned long nr_sectors);
+extern void md_sync_acct(struct block_device *bdev, unsigned long nr_sectors);
 extern int md_error (mddev_t *mddev, struct block_device *bdev);
 extern int md_run_setup(void);
 
diff -urN C24-0/include/linux/raid/md_k.h C24-current/include/linux/raid/md_k.h
--- C24-0/include/linux/raid/md_k.h	Thu Jun 20 13:37:25 2002
+++ C24-current/include/linux/raid/md_k.h	Mon Jun 24 19:21:34 2002
@@ -213,7 +213,7 @@
 	int (*run)(mddev_t *mddev);
 	int (*stop)(mddev_t *mddev);
 	int (*status)(char *page, mddev_t *mddev);
-	int (*error_handler)(mddev_t *mddev, kdev_t dev);
+	int (*error_handler)(mddev_t *mddev, struct block_device *bdev);
 
 /*
  * Some personalities (RAID-1, RAID-5) can have disks hot-added and
diff -urN C24-0/include/linux/raid/raid5.h C24-current/include/linux/raid/raid5.h
--- C24-0/include/linux/raid/raid5.h	Thu Jun 20 13:37:25 2002
+++ C24-current/include/linux/raid/raid5.h	Mon Jun 24 19:48:06 2002
@@ -192,7 +192,6 @@
  
 
 struct disk_info {
-	kdev_t	dev;
 	struct block_device *bdev;
 	int	operational;
 	int	number;

