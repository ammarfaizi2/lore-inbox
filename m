Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315370AbSGEE4C>; Fri, 5 Jul 2002 00:56:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315372AbSGEE4B>; Fri, 5 Jul 2002 00:56:01 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:21651 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S315370AbSGEEzs>;
	Fri, 5 Jul 2002 00:55:48 -0400
Date: Fri, 5 Jul 2002 00:58:22 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] raid ->diskop() splitup
Message-ID: <Pine.GSO.4.21.0207050054480.14718-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	* ->diskop() split into individual methods; prototypes cleaned
up.  In particular, handling of hot_add_disk() gets mdk_rdev_t * of
the component we are adding as an argument instead of playing the games
with major/minor.  Code cleaned up.

diff -urN C24-0/drivers/md/md.c C24-current/drivers/md/md.c
--- C24-0/drivers/md/md.c	Mon Jun 24 23:41:24 2002
+++ C24-current/drivers/md/md.c	Sat Jun 29 15:08:20 2002
@@ -1741,8 +1741,7 @@
 			md_unregister_thread(mddev->sync_thread);
 			mddev->sync_thread = NULL;
 			if (mddev->spare) {
-				mddev->pers->diskop(mddev, &mddev->spare,
-						    DISKOP_SPARE_INACTIVE);
+				mddev->pers->spare_inactive(mddev);
 				mddev->spare = NULL;
 			}
 		}
@@ -2250,7 +2249,7 @@
 	printk(KERN_INFO "md: trying to remove %s from md%d ... \n",
 		partition_name(dev), mdidx(mddev));
 
-	if (!mddev->pers->diskop) {
+	if (!mddev->pers->hot_remove_disk) {
 		printk(KERN_WARNING "md%d: personality does not support diskops!\n",
 		       mdidx(mddev));
 		return -EINVAL;
@@ -2274,7 +2273,7 @@
 		return -EINVAL;
 	}
 
-	err = mddev->pers->diskop(mddev, &disk, DISKOP_HOT_REMOVE_DISK);
+	err = mddev->pers->hot_remove_disk(mddev, disk->number);
 	if (err == -EBUSY) {
 		MD_BUG();
 		goto busy;
@@ -2308,7 +2307,7 @@
 	printk(KERN_INFO "md: trying to hot-add %s to md%d ... \n",
 		partition_name(dev), mdidx(mddev));
 
-	if (!mddev->pers->diskop) {
+	if (!mddev->pers->hot_add_disk) {
 		printk(KERN_WARNING "md%d: personality does not support diskops!\n",
 		       mdidx(mddev));
 		return -EINVAL;
@@ -2388,7 +2387,7 @@
 	disk->major = major(dev);
 	disk->minor = minor(dev);
 
-	if (mddev->pers->diskop(mddev, &disk, DISKOP_HOT_ADD_DISK)) {
+	if (mddev->pers->hot_add_disk(mddev, disk, rdev)) {
 		MD_BUG();
 		err = -EINVAL;
 		goto abort_unbind_export;
@@ -3370,7 +3369,7 @@
 
 	ITERATE_MDDEV(mddev,tmp) if (mddev_lock(mddev)==0) {
 		sb = mddev->sb;
-		if (!sb || !mddev->pers || !mddev->pers->diskop || mddev->ro)
+		if (!sb || !mddev->pers || mddev->ro)
 			goto unlock;
 		if (mddev->recovery_running > 0)
 			/* resync/recovery still happening */
@@ -3384,16 +3383,19 @@
 				 * If we were doing a reconstruction,
 				 * we need to retrieve the spare
 				 */
+				if (!mddev->pers->spare_inactive)
+					goto unlock;
 				if (mddev->spare) {
-					mddev->pers->diskop(mddev, &mddev->spare,
-							    DISKOP_SPARE_INACTIVE);
+					mddev->pers->spare_inactive(mddev);
 					mddev->spare = NULL;
 				}
 			} else {
+				if (!mddev->pers->spare_active)
+					goto unlock;
 				/* success...*/
 				if (mddev->spare) {
-					mddev->pers->diskop(mddev, &mddev->spare,
-							    DISKOP_SPARE_ACTIVE);
+					mddev->pers->spare_active(mddev,
+								&mddev->spare);
 					mark_disk_sync(mddev->spare);
 					mark_disk_active(mddev->spare);
 					sb->active_disks++;
@@ -3432,12 +3434,13 @@
 			if (!mddev->sync_thread) {
 				printk(KERN_ERR "md%d: could not start resync thread...\n", mdidx(mddev));
 				if (mddev->spare)
-					mddev->pers->diskop(mddev, &mddev->spare, DISKOP_SPARE_INACTIVE);
+					mddev->pers->spare_inactive(mddev);
 				mddev->spare = NULL;
 				mddev->recovery_running = 0;
 			} else {
 				if (mddev->spare)
-					mddev->pers->diskop(mddev, &mddev->spare, DISKOP_SPARE_WRITE);
+					mddev->pers->spare_write(mddev,
+						mddev->spare->number);
 				mddev->recovery_running = 1;
 				md_wakeup_thread(mddev->sync_thread);
 			}
diff -urN C24-0/drivers/md/multipath.c C24-current/drivers/md/multipath.c
--- C24-0/drivers/md/multipath.c	Mon Jun 24 23:41:24 2002
+++ C24-current/drivers/md/multipath.c	Sat Jun 29 15:06:46 2002
@@ -55,9 +55,8 @@
 static spinlock_t retry_list_lock = SPIN_LOCK_UNLOCKED;
 struct multipath_bh *multipath_retry_list = NULL, **multipath_retry_tail;
 
-static int multipath_diskop(mddev_t *mddev, mdp_disk_t **d, int state);
-
-
+static int multipath_spare_write(mddev_t *, int);
+static int multipath_spare_active(mddev_t *mddev, mdp_disk_t **d);
 
 static struct multipath_bh *multipath_alloc_mpbh(multipath_conf_t *conf)
 {
@@ -366,11 +365,11 @@
 
 			spare = get_spare(mddev);
 			if (spare) {
-				err = multipath_diskop(mddev, &spare, DISKOP_SPARE_WRITE);
+				err = multipath_spare_write(mddev, spare->number);
 				printk("got DISKOP_SPARE_WRITE err: %d. (spare_faulty(): %d)\n", err, disk_faulty(spare));
 			}
 			if (!err && !disk_faulty(spare)) {
-				multipath_diskop(mddev, &spare, DISKOP_SPARE_ACTIVE);
+				multipath_spare_active(mddev, &spare);
 				mark_disk_sync(spare);
 				mark_disk_active(spare);
 				sb->active_disks++;
@@ -410,255 +409,238 @@
 	}
 }
 
-static int multipath_diskop(mddev_t *mddev, mdp_disk_t **d, int state)
+/*
+ * Find the spare disk ... (can only be in the 'high' area of the array)
+ */
+static struct multipath_info *find_spare(mddev_t *mddev, int number)
 {
-	int err = 0;
-	int i, failed_disk=-1, spare_disk=-1, removed_disk=-1, added_disk=-1;
 	multipath_conf_t *conf = mddev->private;
-	struct multipath_info *tmp, *sdisk, *fdisk, *rdisk, *adisk;
-	mdp_super_t *sb = mddev->sb;
-	mdp_disk_t *failed_desc, *spare_desc, *added_desc;
-	mdk_rdev_t *spare_rdev, *failed_rdev;
-	struct block_device *bdev;
+	int i;
+	for (i = conf->raid_disks; i < MD_SB_DISKS; i++) {
+		struct multipath_info *p = conf->multipaths + i;
+		if (p->spare && p->number == number)
+			return p;
+	}
+	return NULL;
+}
+
+static int multipath_spare_inactive(mddev_t *mddev)
+{
+	multipath_conf_t *conf = mddev->private;
+	struct multipath_info *p;
+	int err = 0;
 
 	print_multipath_conf(conf);
 	spin_lock_irq(&conf->device_lock);
-	/*
-	 * find the disk ...
-	 */
-	switch (state) {
-
-	case DISKOP_SPARE_ACTIVE:
-
-		/*
-		 * Find the failed disk within the MULTIPATH configuration ...
-		 * (this can only be in the first conf->working_disks part)
-		 */
-		for (i = 0; i < conf->raid_disks; i++) {
-			tmp = conf->multipaths + i;
-			if ((!tmp->operational && !tmp->spare) ||
-					!tmp->used_slot) {
-				failed_disk = i;
-				break;
-			}
-		}
-		/*
-		 * When we activate a spare disk we _must_ have a disk in
-		 * the lower (active) part of the array to replace. 
-		 */
-		if ((failed_disk == -1) || (failed_disk >= conf->raid_disks)) {
-			MD_BUG();
-			err = 1;
-			goto abort;
-		}
-		/* fall through */
-
-	case DISKOP_SPARE_WRITE:
-	case DISKOP_SPARE_INACTIVE:
+	p = find_spare(mddev, mddev->spare->number);
+	if (p) {
+		p->operational = 0;
+	} else {
+		MD_BUG();
+		err = 1;
+	}
+	spin_unlock_irq(&conf->device_lock);
 
-		/*
-		 * Find the spare disk ... (can only be in the 'high'
-		 * area of the array)
-		 */
-		for (i = conf->raid_disks; i < MD_SB_DISKS; i++) {
-			tmp = conf->multipaths + i;
-			if (tmp->spare && tmp->number == (*d)->number) {
-				spare_disk = i;
-				break;
-			}
-		}
-		if (spare_disk == -1) {
-			MD_BUG();
-			err = 1;
-			goto abort;
-		}
-		break;
+	print_multipath_conf(conf);
+	return err;
+}
 
-	case DISKOP_HOT_REMOVE_DISK:
+static int multipath_spare_write(mddev_t *mddev, int number)
+{
+	multipath_conf_t *conf = mddev->private;
+	struct multipath_info *p;
+	int err = 0;
 
-		for (i = 0; i < MD_SB_DISKS; i++) {
-			tmp = conf->multipaths + i;
-			if (tmp->used_slot && (tmp->number == (*d)->number)) {
-				if (tmp->operational) {
-					printk(KERN_ERR "hot-remove-disk, slot %d is identified to be the requested disk (number %d), but is still operational!\n", i, (*d)->number);
-					err = -EBUSY;
-					goto abort;
-				}
-				removed_disk = i;
-				break;
-			}
-		}
-		if (removed_disk == -1) {
-			MD_BUG();
-			err = 1;
-			goto abort;
-		}
-		break;
+	print_multipath_conf(conf);
+	spin_lock_irq(&conf->device_lock);
+	p = find_spare(mddev, number);
+	if (p) {
+		p->operational = 1;
+	} else {
+		MD_BUG();
+		err = 1;
+	}
+	spin_unlock_irq(&conf->device_lock);
 
-	case DISKOP_HOT_ADD_DISK:
+	print_multipath_conf(conf);
+	return err;
+}
 
-		for (i = conf->raid_disks; i < MD_SB_DISKS; i++) {
-			tmp = conf->multipaths + i;
-			if (!tmp->used_slot) {
-				added_disk = i;
-				break;
-			}
-		}
-		if (added_disk == -1) {
-			MD_BUG();
-			err = 1;
-			goto abort;
-		}
-		break;
-	}
+static int multipath_spare_active(mddev_t *mddev, mdp_disk_t **d)
+{
+	int err = 0;
+	int i, failed_disk=-1, spare_disk=-1;
+	multipath_conf_t *conf = mddev->private;
+	struct multipath_info *tmp, *sdisk, *fdisk;
+	mdp_super_t *sb = mddev->sb;
+	mdp_disk_t *failed_desc, *spare_desc;
+	mdk_rdev_t *spare_rdev, *failed_rdev;
 
-	switch (state) {
+	print_multipath_conf(conf);
+	spin_lock_irq(&conf->device_lock);
 	/*
-	 * Switch the spare disk to write-only mode:
+	 * Find the failed disk within the MULTIPATH configuration ...
+	 * (this can only be in the first conf->working_disks part)
 	 */
-	case DISKOP_SPARE_WRITE:
-		sdisk = conf->multipaths + spare_disk;
-		sdisk->operational = 1;
-		break;
+	for (i = 0; i < conf->raid_disks; i++) {
+		tmp = conf->multipaths + i;
+		if ((!tmp->operational && !tmp->spare) ||
+				!tmp->used_slot) {
+			failed_disk = i;
+			break;
+		}
+	}
 	/*
-	 * Deactivate a spare disk:
+	 * When we activate a spare disk we _must_ have a disk in
+	 * the lower (active) part of the array to replace. 
 	 */
-	case DISKOP_SPARE_INACTIVE:
-		sdisk = conf->multipaths + spare_disk;
-		sdisk->operational = 0;
-		break;
+	if (failed_disk == -1) {
+		MD_BUG();
+		err = 1;
+		goto abort;
+	}
 	/*
-	 * Activate (mark read-write) the (now sync) spare disk,
-	 * which means we switch it's 'raid position' (->raid_disk)
-	 * with the failed disk. (only the first 'conf->nr_disks'
-	 * slots are used for 'real' disks and we must preserve this
-	 * property)
+	 * Find the spare disk ... (can only be in the 'high'
+	 * area of the array)
 	 */
-	case DISKOP_SPARE_ACTIVE:
-		sdisk = conf->multipaths + spare_disk;
-		fdisk = conf->multipaths + failed_disk;
+	for (i = conf->raid_disks; i < MD_SB_DISKS; i++) {
+		tmp = conf->multipaths + i;
+		if (tmp->spare && tmp->number == (*d)->number) {
+			spare_disk = i;
+			break;
+		}
+	}
+	if (spare_disk == -1) {
+		MD_BUG();
+		err = 1;
+		goto abort;
+	}
 
-		spare_desc = &sb->disks[sdisk->number];
-		failed_desc = &sb->disks[fdisk->number];
+	sdisk = conf->multipaths + spare_disk;
+	fdisk = conf->multipaths + failed_disk;
 
-		if (spare_desc != *d) {
-			MD_BUG();
-			err = 1;
-			goto abort;
-		}
+	spare_desc = &sb->disks[sdisk->number];
+	failed_desc = &sb->disks[fdisk->number];
 
-		if (spare_desc->raid_disk != sdisk->raid_disk) {
-			MD_BUG();
-			err = 1;
-			goto abort;
-		}
-			
-		if (sdisk->raid_disk != spare_disk) {
-			MD_BUG();
-			err = 1;
-			goto abort;
-		}
+	if (spare_desc != *d || spare_desc->raid_disk != sdisk->raid_disk ||
+	    sdisk->raid_disk != spare_disk || fdisk->raid_disk != failed_disk ||
+	    failed_desc->raid_disk != fdisk->raid_disk) {
+		MD_BUG();
+		err = 1;
+		goto abort;
+	}
 
-		if (failed_desc->raid_disk != fdisk->raid_disk) {
-			MD_BUG();
-			err = 1;
-			goto abort;
-		}
+	/*
+	 * do the switch finally
+	 */
+	spare_rdev = find_rdev_nr(mddev, spare_desc->number);
+	failed_rdev = find_rdev_nr(mddev, failed_desc->number);
+	xchg_values(spare_rdev->desc_nr, failed_rdev->desc_nr);
+	spare_rdev->alias_device = 0;
+	failed_rdev->alias_device = 1;
 
-		if (fdisk->raid_disk != failed_disk) {
-			MD_BUG();
-			err = 1;
-			goto abort;
-		}
+	xchg_values(*spare_desc, *failed_desc);
+	xchg_values(*fdisk, *sdisk);
 
-		/*
-		 * do the switch finally
-		 */
-		spare_rdev = find_rdev_nr(mddev, spare_desc->number);
-		failed_rdev = find_rdev_nr(mddev, failed_desc->number);
-		xchg_values(spare_rdev->desc_nr, failed_rdev->desc_nr);
-		spare_rdev->alias_device = 0;
-		failed_rdev->alias_device = 1;
+	/*
+	 * (careful, 'failed' and 'spare' are switched from now on)
+	 *
+	 * we want to preserve linear numbering and we want to
+	 * give the proper raid_disk number to the now activated
+	 * disk. (this means we switch back these values)
+	 */
 
-		xchg_values(*spare_desc, *failed_desc);
-		xchg_values(*fdisk, *sdisk);
+	xchg_values(spare_desc->raid_disk, failed_desc->raid_disk);
+	xchg_values(sdisk->raid_disk, fdisk->raid_disk);
+	xchg_values(spare_desc->number, failed_desc->number);
+	xchg_values(sdisk->number, fdisk->number);
 
-		/*
-		 * (careful, 'failed' and 'spare' are switched from now on)
-		 *
-		 * we want to preserve linear numbering and we want to
-		 * give the proper raid_disk number to the now activated
-		 * disk. (this means we switch back these values)
-		 */
-	
-		xchg_values(spare_desc->raid_disk, failed_desc->raid_disk);
-		xchg_values(sdisk->raid_disk, fdisk->raid_disk);
-		xchg_values(spare_desc->number, failed_desc->number);
-		xchg_values(sdisk->number, fdisk->number);
+	*d = failed_desc;
 
-		*d = failed_desc;
+	if (!sdisk->bdev)
+		sdisk->used_slot = 0;
+	/*
+	 * this really activates the spare.
+	 */
+	fdisk->spare = 0;
 
-		if (!sdisk->bdev)
-			sdisk->used_slot = 0;
-		/*
-		 * this really activates the spare.
-		 */
-		fdisk->spare = 0;
+	/*
+	 * if we activate a spare, we definitely replace a
+	 * non-operational disk slot in the 'low' area of
+	 * the disk array.
+	 */
 
-		/*
-		 * if we activate a spare, we definitely replace a
-		 * non-operational disk slot in the 'low' area of
-		 * the disk array.
-		 */
+	conf->working_disks++;
+abort:
+	spin_unlock_irq(&conf->device_lock);
 
-		conf->working_disks++;
+	print_multipath_conf(conf);
+	return err;
+}
 
-		break;
+static int multipath_add_disk(mddev_t *mddev, mdp_disk_t *added_desc,
+	mdk_rdev_t *rdev)
+{
+	multipath_conf_t *conf = mddev->private;
+	int err = 1;
+	int i;
 
-	case DISKOP_HOT_REMOVE_DISK:
-		rdisk = conf->multipaths + removed_disk;
+	print_multipath_conf(conf);
+	spin_lock_irq(&conf->device_lock);
+	for (i = conf->raid_disks; i < MD_SB_DISKS; i++) {
+		struct multipath_info *p = conf->multipaths + i;
+		if (!p->used_slot) {
+			if (added_desc->number != i)
+				break;
+			p->number = added_desc->number;
+			p->raid_disk = added_desc->raid_disk;
+			p->dev = rdev->dev;
+			p->bdev = rdev->bdev;
+			p->operational = 0;
+			p->spare = 1;
+			p->used_slot = 1;
+			conf->nr_disks++;
+			err = 0;
+			break;
+		}
+	}
+	if (err)
+		MD_BUG();
+	spin_unlock_irq(&conf->device_lock);
 
-		if (rdisk->spare && (removed_disk < conf->raid_disks)) {
-			MD_BUG();	
-			err = 1;
-			goto abort;
-		}
-		bdev = rdisk->bdev;
-		rdisk->dev = NODEV;
-		rdisk->bdev = NULL;
-		rdisk->used_slot = 0;
-		conf->nr_disks--;
-		bdput(bdev);
-		break;
-
-	case DISKOP_HOT_ADD_DISK:
-		adisk = conf->multipaths + added_disk;
-		added_desc = *d;
-
-		if (added_disk != added_desc->number) {
-			MD_BUG();	
-			err = 1;
-			goto abort;
-		}
-
-		adisk->number = added_desc->number;
-		adisk->raid_disk = added_desc->raid_disk;
-		adisk->dev = mk_kdev(added_desc->major,added_desc->minor);
-		/* it will be held open by rdev */
-		adisk->bdev = bdget(kdev_t_to_nr(adisk->dev));
-
-		adisk->operational = 0;
-		adisk->spare = 1;
-		adisk->used_slot = 1;
-		conf->nr_disks++;
+	print_multipath_conf(conf);
+	return err;
+}
 
-		break;
+static int multipath_remove_disk(mddev_t *mddev, int number)
+{
+	multipath_conf_t *conf = mddev->private;
+	int err = 1;
+	int i;
 
-	default:
-		MD_BUG();
-		err = 1;
-		goto abort;
+	print_multipath_conf(conf);
+	spin_lock_irq(&conf->device_lock);
+
+	for (i = 0; i < MD_SB_DISKS; i++) {
+		struct multipath_info *p = conf->multipaths + i;
+		if (p->used_slot && (p->number == number)) {
+			if (p->operational) {
+				printk(KERN_ERR "hot-remove-disk, slot %d is identified to be the requested disk (number %d), but is still operational!\n", i, number);
+				err = -EBUSY;
+				goto abort;
+			}
+			if (p->spare && i < conf->raid_disks)
+				break;
+			p->dev = NODEV;
+			p->bdev = NULL;
+			p->used_slot = 0;
+			conf->nr_disks--;
+			err = 0;
+			break;
+		}
 	}
+	if (err)
+		MD_BUG();
 abort:
 	spin_unlock_irq(&conf->device_lock);
 
@@ -666,7 +648,6 @@
 	return err;
 }
 
-
 #define IO_ERROR KERN_ALERT \
 "multipath: %s: unrecoverable IO read error for block %lu\n"
 
@@ -1074,7 +1055,11 @@
 	stop:		multipath_stop,
 	status:		multipath_status,
 	error_handler:	multipath_error,
-	diskop:		multipath_diskop,
+	hot_add_disk:	multipath_add_disk,
+	hot_remove_disk:multipath_remove_disk,
+	spare_inactive:	multipath_spare_inactive,
+	spare_active:	multipath_spare_active,
+	spare_write:	multipath_spare_write,
 };
 
 static int __init multipath_init (void)
diff -urN C24-0/drivers/md/raid1.c C24-current/drivers/md/raid1.c
--- C24-0/drivers/md/raid1.c	Mon Jun 24 23:41:24 2002
+++ C24-current/drivers/md/raid1.c	Sat Jun 29 15:06:03 2002
@@ -658,263 +658,244 @@
 	conf->r1buf_pool = NULL;
 }
 
-static int diskop(mddev_t *mddev, mdp_disk_t **d, int state)
+static mirror_info_t *find_spare(mddev_t *mddev, int number)
+{
+	conf_t *conf = mddev->private;
+	int i;
+	for (i = conf->raid_disks; i < MD_SB_DISKS; i++) {
+		mirror_info_t *p = conf->mirrors + i;
+		if (p->spare && p->number == number)
+			return p;
+	}
+	return NULL;
+}
+
+static int raid1_spare_active(mddev_t *mddev, mdp_disk_t **d)
 {
 	int err = 0;
-	int i, failed_disk = -1, spare_disk = -1, removed_disk = -1, added_disk = -1;
+	int i, failed_disk = -1, spare_disk = -1;
 	conf_t *conf = mddev->private;
-	mirror_info_t *tmp, *sdisk, *fdisk, *rdisk, *adisk;
+	mirror_info_t *tmp, *sdisk, *fdisk;
 	mdp_super_t *sb = mddev->sb;
-	mdp_disk_t *failed_desc, *spare_desc, *added_desc;
+	mdp_disk_t *failed_desc, *spare_desc;
 	mdk_rdev_t *spare_rdev, *failed_rdev;
-	struct block_device *bdev;
 
 	print_conf(conf);
 	spin_lock_irq(&conf->device_lock);
 	/*
-	 * find the disk ...
+	 * Find the failed disk within the RAID1 configuration ...
+	 * (this can only be in the first conf->working_disks part)
 	 */
-	switch (state) {
-
-	case DISKOP_SPARE_ACTIVE:
-
-		/*
-		 * Find the failed disk within the RAID1 configuration ...
-		 * (this can only be in the first conf->working_disks part)
-		 */
-		for (i = 0; i < conf->raid_disks; i++) {
-			tmp = conf->mirrors + i;
-			if ((!tmp->operational && !tmp->spare) ||
-					!tmp->used_slot) {
-				failed_disk = i;
-				break;
-			}
-		}
-		/*
-		 * When we activate a spare disk we _must_ have a disk in
-		 * the lower (active) part of the array to replace.
-		 */
-		if ((failed_disk == -1) || (failed_disk >= conf->raid_disks)) {
-			MD_BUG();
-			err = 1;
-			goto abort;
-		}
-		/* fall through */
-
-	case DISKOP_SPARE_WRITE:
-	case DISKOP_SPARE_INACTIVE:
-
-		/*
-		 * Find the spare disk ... (can only be in the 'high'
-		 * area of the array)
-		 */
-		for (i = conf->raid_disks; i < MD_SB_DISKS; i++) {
-			tmp = conf->mirrors + i;
-			if (tmp->spare && tmp->number == (*d)->number) {
-				spare_disk = i;
-				break;
-			}
-		}
-		if (spare_disk == -1) {
-			MD_BUG();
-			err = 1;
-			goto abort;
-		}
-		break;
-
-	case DISKOP_HOT_REMOVE_DISK:
-
-		for (i = 0; i < MD_SB_DISKS; i++) {
-			tmp = conf->mirrors + i;
-			if (tmp->used_slot && (tmp->number == (*d)->number)) {
-				if (tmp->operational) {
-					err = -EBUSY;
-					goto abort;
-				}
-				removed_disk = i;
-				break;
-			}
-		}
-		if (removed_disk == -1) {
-			MD_BUG();
-			err = 1;
-			goto abort;
-		}
-		break;
-
-	case DISKOP_HOT_ADD_DISK:
-
-		for (i = conf->raid_disks; i < MD_SB_DISKS; i++) {
-			tmp = conf->mirrors + i;
-			if (!tmp->used_slot) {
-				added_disk = i;
-				break;
-			}
-		}
-		if (added_disk == -1) {
-			MD_BUG();
-			err = 1;
-			goto abort;
+	for (i = 0; i < conf->raid_disks; i++) {
+		tmp = conf->mirrors + i;
+		if ((!tmp->operational && !tmp->spare) ||
+				!tmp->used_slot) {
+			failed_disk = i;
+			break;
 		}
-		break;
 	}
-
-	switch (state) {
-	/*
-	 * Switch the spare disk to write-only mode:
-	 */
-	case DISKOP_SPARE_WRITE:
-		sdisk = conf->mirrors + spare_disk;
-		sdisk->operational = 1;
-		sdisk->write_only = 1;
-		break;
 	/*
-	 * Deactivate a spare disk:
+	 * When we activate a spare disk we _must_ have a disk in
+	 * the lower (active) part of the array to replace.
 	 */
-	case DISKOP_SPARE_INACTIVE:
-		sdisk = conf->mirrors + spare_disk;
-		sdisk->operational = 0;
-		sdisk->write_only = 0;
-		break;
+	if (failed_disk == -1) {
+		MD_BUG();
+		err = 1;
+		goto abort;
+	}
 	/*
-	 * Activate (mark read-write) the (now sync) spare disk,
-	 * which means we switch it's 'raid position' (->raid_disk)
-	 * with the failed disk. (only the first 'conf->nr_disks'
-	 * slots are used for 'real' disks and we must preserve this
-	 * property)
+	 * Find the spare disk ... (can only be in the 'high'
+	 * area of the array)
 	 */
-	case DISKOP_SPARE_ACTIVE:
-		sdisk = conf->mirrors + spare_disk;
-		fdisk = conf->mirrors + failed_disk;
+	for (i = conf->raid_disks; i < MD_SB_DISKS; i++) {
+		tmp = conf->mirrors + i;
+		if (tmp->spare && tmp->number == (*d)->number) {
+			spare_disk = i;
+			break;
+		}
+	}
+	if (spare_disk == -1) {
+		MD_BUG();
+		err = 1;
+		goto abort;
+	}
 
-		spare_desc = &sb->disks[sdisk->number];
-		failed_desc = &sb->disks[fdisk->number];
+	sdisk = conf->mirrors + spare_disk;
+	fdisk = conf->mirrors + failed_disk;
 
-		if (spare_desc != *d) {
-			MD_BUG();
-			err = 1;
-			goto abort;
-		}
+	spare_desc = &sb->disks[sdisk->number];
+	failed_desc = &sb->disks[fdisk->number];
 
-		if (spare_desc->raid_disk != sdisk->raid_disk) {
-			MD_BUG();
-			err = 1;
-			goto abort;
-		}
+	if (spare_desc != *d || spare_desc->raid_disk != sdisk->raid_disk ||
+	    sdisk->raid_disk != spare_disk || fdisk->raid_disk != failed_disk ||
+	    failed_desc->raid_disk != fdisk->raid_disk) {
+		MD_BUG();
+		err = 1;
+		goto abort;
+	}
 
-		if (sdisk->raid_disk != spare_disk) {
-			MD_BUG();
-			err = 1;
-			goto abort;
-		}
+	/*
+	 * do the switch finally
+	 */
+	spare_rdev = find_rdev_nr(mddev, spare_desc->number);
+	failed_rdev = find_rdev_nr(mddev, failed_desc->number);
 
-		if (failed_desc->raid_disk != fdisk->raid_disk) {
-			MD_BUG();
-			err = 1;
-			goto abort;
-		}
+	/*
+	 * There must be a spare_rdev, but there may not be a
+	 * failed_rdev. That slot might be empty...
+	 */
+	spare_rdev->desc_nr = failed_desc->number;
+	if (failed_rdev)
+		failed_rdev->desc_nr = spare_desc->number;
 
-		if (fdisk->raid_disk != failed_disk) {
-			MD_BUG();
-			err = 1;
-			goto abort;
-		}
+	xchg_values(*spare_desc, *failed_desc);
+	xchg_values(*fdisk, *sdisk);
 
-		/*
-		 * do the switch finally
-		 */
-		spare_rdev = find_rdev_nr(mddev, spare_desc->number);
-		failed_rdev = find_rdev_nr(mddev, failed_desc->number);
+	/*
+	 * (careful, 'failed' and 'spare' are switched from now on)
+	 *
+	 * we want to preserve linear numbering and we want to
+	 * give the proper raid_disk number to the now activated
+	 * disk. (this means we switch back these values)
+	 */
+	xchg_values(spare_desc->raid_disk, failed_desc->raid_disk);
+	xchg_values(sdisk->raid_disk, fdisk->raid_disk);
+	xchg_values(spare_desc->number, failed_desc->number);
+	xchg_values(sdisk->number, fdisk->number);
 
-		/*
-		 * There must be a spare_rdev, but there may not be a
-		 * failed_rdev. That slot might be empty...
-		 */
-		spare_rdev->desc_nr = failed_desc->number;
-		if (failed_rdev)
-			failed_rdev->desc_nr = spare_desc->number;
+	*d = failed_desc;
 
-		xchg_values(*spare_desc, *failed_desc);
-		xchg_values(*fdisk, *sdisk);
+	if (!sdisk->bdev)
+		sdisk->used_slot = 0;
+	/*
+	 * this really activates the spare.
+	 */
+	fdisk->spare = 0;
+	fdisk->write_only = 0;
 
-		/*
-		 * (careful, 'failed' and 'spare' are switched from now on)
-		 *
-		 * we want to preserve linear numbering and we want to
-		 * give the proper raid_disk number to the now activated
-		 * disk. (this means we switch back these values)
-		 */
-		xchg_values(spare_desc->raid_disk, failed_desc->raid_disk);
-		xchg_values(sdisk->raid_disk, fdisk->raid_disk);
-		xchg_values(spare_desc->number, failed_desc->number);
-		xchg_values(sdisk->number, fdisk->number);
+	/*
+	 * if we activate a spare, we definitely replace a
+	 * non-operational disk slot in the 'low' area of
+	 * the disk array.
+	 */
 
-		*d = failed_desc;
+	conf->working_disks++;
+abort:
+	spin_unlock_irq(&conf->device_lock);
 
-		if (!sdisk->bdev)
-			sdisk->used_slot = 0;
-		/*
-		 * this really activates the spare.
-		 */
-		fdisk->spare = 0;
-		fdisk->write_only = 0;
+	print_conf(conf);
+	return err;
+}
 
-		/*
-		 * if we activate a spare, we definitely replace a
-		 * non-operational disk slot in the 'low' area of
-		 * the disk array.
-		 */
+static int raid1_spare_inactive(mddev_t *mddev)
+{
+	conf_t *conf = mddev->private;
+	mirror_info_t *p;
+	int err = 0;
 
-		conf->working_disks++;
+	print_conf(conf);
+	spin_lock_irq(&conf->device_lock);
+	p = find_spare(mddev, mddev->spare->number);
+	if (p) {
+		p->operational = 0;
+		p->write_only = 0;
+	} else {
+		MD_BUG();
+		err = 1;
+	}
+	spin_unlock_irq(&conf->device_lock);
+	print_conf(conf);
+	return err;
+}
 
-		break;
+static int raid1_spare_write(mddev_t *mddev, int number)
+{
+	conf_t *conf = mddev->private;
+	mirror_info_t *p;
+	int err = 0;
 
-	case DISKOP_HOT_REMOVE_DISK:
-		rdisk = conf->mirrors + removed_disk;
+	print_conf(conf);
+	spin_lock_irq(&conf->device_lock);
+	p = find_spare(mddev, number);
+	if (p) {
+		p->operational = 1;
+		p->write_only = 1;
+	} else {
+		MD_BUG();
+		err = 1;
+	}
+	spin_unlock_irq(&conf->device_lock);
+	print_conf(conf);
+	return err;
+}
 
-		if (rdisk->spare && (removed_disk < conf->raid_disks)) {
-			MD_BUG();
-			err = 1;
-			goto abort;
-		}
-		bdev = rdisk->bdev;
-		rdisk->dev = NODEV;
-		rdisk->bdev = NULL;
-		rdisk->used_slot = 0;
-		conf->nr_disks--;
-		bdput(bdev);
-		break;
-
-	case DISKOP_HOT_ADD_DISK:
-		adisk = conf->mirrors + added_disk;
-		added_desc = *d;
+static int raid1_add_disk(mddev_t *mddev, mdp_disk_t *added_desc,
+	mdk_rdev_t *rdev)
+{
+	conf_t *conf = mddev->private;
+	int err = 1;
+	int i;
 
-		if (added_disk != added_desc->number) {
-			MD_BUG();
-			err = 1;
-			goto abort;
+	print_conf(conf);
+	spin_lock_irq(&conf->device_lock);
+	/*
+	 * find the disk ...
+	 */
+	for (i = conf->raid_disks; i < MD_SB_DISKS; i++) {
+		mirror_info_t *p = conf->mirrors + i;
+		if (!p->used_slot) {
+			if (added_desc->number != i)
+				break;
+			p->number = added_desc->number;
+			p->raid_disk = added_desc->raid_disk;
+			p->dev = rdev->dev;
+			/* it will be held open by rdev */
+			p->bdev = rdev->bdev;
+			p->operational = 0;
+			p->write_only = 0;
+			p->spare = 1;
+			p->used_slot = 1;
+			p->head_position = 0;
+			conf->nr_disks++;
+			err = 0;
+			break;
 		}
+	}
+	if (err)
+		MD_BUG();
+	spin_unlock_irq(&conf->device_lock);
 
-		adisk->number = added_desc->number;
-		adisk->raid_disk = added_desc->raid_disk;
-		adisk->dev = mk_kdev(added_desc->major, added_desc->minor);
-		/* it will be held open by rdev */
-		adisk->bdev = bdget(kdev_t_to_nr(adisk->dev));
-
-		adisk->operational = 0;
-		adisk->write_only = 0;
-		adisk->spare = 1;
-		adisk->used_slot = 1;
-		adisk->head_position = 0;
-		conf->nr_disks++;
+	print_conf(conf);
+	return err;
+}
 
-		break;
+static int raid1_remove_disk(mddev_t *mddev, int number)
+{
+	conf_t *conf = mddev->private;
+	int err = 1;
+	int i;
 
-	default:
-		MD_BUG();
-		err = 1;
-		goto abort;
+	print_conf(conf);
+	spin_lock_irq(&conf->device_lock);
+	for (i = 0; i < MD_SB_DISKS; i++) {
+		mirror_info_t *p = conf->mirrors + i;
+		if (p->used_slot && (p->number == number)) {
+			if (p->operational) {
+				err = -EBUSY;
+				goto abort;
+			}
+			if (p->spare && (i < conf->raid_disks))
+				break;
+			p->dev = NODEV;
+			p->bdev = NULL;
+			p->used_slot = 0;
+			conf->nr_disks--;
+			err = 0;
+			break;
+		}
 	}
+	if (err)
+		MD_BUG();
 abort:
 	spin_unlock_irq(&conf->device_lock);
 
@@ -922,7 +903,6 @@
 	return err;
 }
 
-
 #define IO_ERROR KERN_ALERT \
 "raid1: %s: unrecoverable I/O read error for block %lu\n"
 
@@ -1495,7 +1475,11 @@
 	stop:		stop,
 	status:		status,
 	error_handler:	error,
-	diskop:		diskop,
+	hot_add_disk:	raid1_add_disk,
+	hot_remove_disk:raid1_remove_disk,
+	spare_write:	raid1_spare_write,
+	spare_inactive:	raid1_spare_inactive,
+	spare_active:	raid1_spare_active,
 	sync_request:	sync_request
 };
 
diff -urN C24-0/drivers/md/raid5.c C24-current/drivers/md/raid5.c
--- C24-0/drivers/md/raid5.c	Mon Jun 24 23:41:24 2002
+++ C24-current/drivers/md/raid5.c	Sat Jun 29 15:06:32 2002
@@ -1694,281 +1694,247 @@
 	}
 }
 
-static int diskop(mddev_t *mddev, mdp_disk_t **d, int state)
+static struct disk_info *find_spare(mddev_t *mddev, int number)
+{
+	raid5_conf_t *conf = mddev->private;
+	int i;
+	for (i = conf->raid_disks; i < MD_SB_DISKS; i++) {
+		struct disk_info *p = conf->disks + i;
+		if (p->spare && p->number == number)
+			return p;
+	}
+	return NULL;
+}
+
+static int raid5_spare_active(mddev_t *mddev, mdp_disk_t **d)
 {
 	int err = 0;
-	int i, failed_disk=-1, spare_disk=-1, removed_disk=-1, added_disk=-1;
+	int i, failed_disk=-1, spare_disk=-1;
 	raid5_conf_t *conf = mddev->private;
-	struct disk_info *tmp, *sdisk, *fdisk, *rdisk, *adisk;
+	struct disk_info *tmp, *sdisk, *fdisk;
 	mdp_super_t *sb = mddev->sb;
-	mdp_disk_t *failed_desc, *spare_desc, *added_desc;
+	mdp_disk_t *failed_desc, *spare_desc;
 	mdk_rdev_t *spare_rdev, *failed_rdev;
 
 	print_raid5_conf(conf);
 	spin_lock_irq(&conf->device_lock);
+	for (i = 0; i < conf->raid_disks; i++) {
+		tmp = conf->disks + i;
+		if ((!tmp->operational && !tmp->spare) ||
+				!tmp->used_slot) {
+			failed_disk = i;
+			break;
+		}
+	}
+	if (failed_disk == -1) {
+		MD_BUG();
+		err = 1;
+		goto abort;
+	}
 	/*
-	 * find the disk ...
+	 * Find the spare disk ... (can only be in the 'high'
+	 * area of the array)
 	 */
-	switch (state) {
-
-	case DISKOP_SPARE_ACTIVE:
-
-		/*
-		 * Find the failed disk within the RAID5 configuration ...
-		 * (this can only be in the first conf->raid_disks part)
-		 */
-		for (i = 0; i < conf->raid_disks; i++) {
-			tmp = conf->disks + i;
-			if ((!tmp->operational && !tmp->spare) ||
-					!tmp->used_slot) {
-				failed_disk = i;
-				break;
-			}
+	for (i = conf->raid_disks; i < MD_SB_DISKS; i++) {
+		tmp = conf->disks + i;
+		if (tmp->spare && tmp->number == (*d)->number) {
+			spare_disk = i;
+			break;
 		}
-		/*
-		 * When we activate a spare disk we _must_ have a disk in
-		 * the lower (active) part of the array to replace.
-		 */
-		if ((failed_disk == -1) || (failed_disk >= conf->raid_disks)) {
-			MD_BUG();
-			err = 1;
-			goto abort;
-		}
-		/* fall through */
-
-	case DISKOP_SPARE_WRITE:
-	case DISKOP_SPARE_INACTIVE:
-
-		/*
-		 * Find the spare disk ... (can only be in the 'high'
-		 * area of the array)
-		 */
-		for (i = conf->raid_disks; i < MD_SB_DISKS; i++) {
-			tmp = conf->disks + i;
-			if (tmp->spare && tmp->number == (*d)->number) {
-				spare_disk = i;
-				break;
-			}
-		}
-		if (spare_disk == -1) {
-			MD_BUG();
-			err = 1;
-			goto abort;
-		}
-		break;
-
-	case DISKOP_HOT_REMOVE_DISK:
+	}
+	if (spare_disk == -1) {
+		MD_BUG();
+		err = 1;
+		goto abort;
+	}
 
-		for (i = 0; i < MD_SB_DISKS; i++) {
-			tmp = conf->disks + i;
-			if (tmp->used_slot && (tmp->number == (*d)->number)) {
-				if (tmp->operational) {
-					err = -EBUSY;
-					goto abort;
-				}
-				removed_disk = i;
-				break;
-			}
-		}
-		if (removed_disk == -1) {
-			MD_BUG();
-			err = 1;
-			goto abort;
-		}
-		break;
+	if (!conf->spare) {
+		MD_BUG();
+		err = 1;
+		goto abort;
+	}
+	sdisk = conf->disks + spare_disk;
+	fdisk = conf->disks + failed_disk;
 
-	case DISKOP_HOT_ADD_DISK:
+	spare_desc = &sb->disks[sdisk->number];
+	failed_desc = &sb->disks[fdisk->number];
 
-		for (i = conf->raid_disks; i < MD_SB_DISKS; i++) {
-			tmp = conf->disks + i;
-			if (!tmp->used_slot) {
-				added_disk = i;
-				break;
-			}
-		}
-		if (added_disk == -1) {
-			MD_BUG();
-			err = 1;
-			goto abort;
-		}
-		break;
+	if (spare_desc != *d || spare_desc->raid_disk != sdisk->raid_disk ||
+	    sdisk->raid_disk != spare_disk || fdisk->raid_disk != failed_disk ||
+	    failed_desc->raid_disk != fdisk->raid_disk) {
+		MD_BUG();
+		err = 1;
+		goto abort;
 	}
 
-	switch (state) {
 	/*
-	 * Switch the spare disk to write-only mode:
+	 * do the switch finally
 	 */
-	case DISKOP_SPARE_WRITE:
-		if (conf->spare) {
-			MD_BUG();
-			err = 1;
-			goto abort;
-		}
-		sdisk = conf->disks + spare_disk;
-		sdisk->operational = 1;
-		sdisk->write_only = 1;
-		conf->spare = sdisk;
-		break;
-	/*
-	 * Deactivate a spare disk:
+	spare_rdev = find_rdev_nr(mddev, spare_desc->number);
+	failed_rdev = find_rdev_nr(mddev, failed_desc->number);
+
+	/* There must be a spare_rdev, but there may not be a
+	 * failed_rdev.  That slot might be empty...
 	 */
-	case DISKOP_SPARE_INACTIVE:
-		sdisk = conf->disks + spare_disk;
-		sdisk->operational = 0;
-		sdisk->write_only = 0;
-		/*
-		 * Was the spare being resynced?
-		 */
-		if (conf->spare == sdisk)
-			conf->spare = NULL;
-		break;
+	spare_rdev->desc_nr = failed_desc->number;
+	if (failed_rdev)
+		failed_rdev->desc_nr = spare_desc->number;
+	
+	xchg_values(*spare_desc, *failed_desc);
+	xchg_values(*fdisk, *sdisk);
+
 	/*
-	 * Activate (mark read-write) the (now sync) spare disk,
-	 * which means we switch it's 'raid position' (->raid_disk)
-	 * with the failed disk. (only the first 'conf->raid_disks'
-	 * slots are used for 'real' disks and we must preserve this
-	 * property)
+	 * (careful, 'failed' and 'spare' are switched from now on)
+	 *
+	 * we want to preserve linear numbering and we want to
+	 * give the proper raid_disk number to the now activated
+	 * disk. (this means we switch back these values)
 	 */
-	case DISKOP_SPARE_ACTIVE:
-		if (!conf->spare) {
-			MD_BUG();
-			err = 1;
-			goto abort;
-		}
-		sdisk = conf->disks + spare_disk;
-		fdisk = conf->disks + failed_disk;
 
-		spare_desc = &sb->disks[sdisk->number];
-		failed_desc = &sb->disks[fdisk->number];
+	xchg_values(spare_desc->raid_disk, failed_desc->raid_disk);
+	xchg_values(sdisk->raid_disk, fdisk->raid_disk);
+	xchg_values(spare_desc->number, failed_desc->number);
+	xchg_values(sdisk->number, fdisk->number);
 
-		if (spare_desc != *d) {
-			MD_BUG();
-			err = 1;
-			goto abort;
-		}
-
-		if (spare_desc->raid_disk != sdisk->raid_disk) {
-			MD_BUG();
-			err = 1;
-			goto abort;
-		}
-			
-		if (sdisk->raid_disk != spare_disk) {
-			MD_BUG();
-			err = 1;
-			goto abort;
-		}
+	*d = failed_desc;
 
-		if (failed_desc->raid_disk != fdisk->raid_disk) {
-			MD_BUG();
-			err = 1;
-			goto abort;
-		}
+	if (!sdisk->bdev)
+		sdisk->used_slot = 0;
 
-		if (fdisk->raid_disk != failed_disk) {
-			MD_BUG();
-			err = 1;
-			goto abort;
-		}
+	/*
+	 * this really activates the spare.
+	 */
+	fdisk->spare = 0;
+	fdisk->write_only = 0;
 
-		/*
-		 * do the switch finally
-		 */
-		spare_rdev = find_rdev_nr(mddev, spare_desc->number);
-		failed_rdev = find_rdev_nr(mddev, failed_desc->number);
-
-		/* There must be a spare_rdev, but there may not be a
-		 * failed_rdev.  That slot might be empty...
-		 */
-		spare_rdev->desc_nr = failed_desc->number;
-		if (failed_rdev)
-			failed_rdev->desc_nr = spare_desc->number;
-		
-		xchg_values(*spare_desc, *failed_desc);
-		xchg_values(*fdisk, *sdisk);
-
-		/*
-		 * (careful, 'failed' and 'spare' are switched from now on)
-		 *
-		 * we want to preserve linear numbering and we want to
-		 * give the proper raid_disk number to the now activated
-		 * disk. (this means we switch back these values)
-		 */
-	
-		xchg_values(spare_desc->raid_disk, failed_desc->raid_disk);
-		xchg_values(sdisk->raid_disk, fdisk->raid_disk);
-		xchg_values(spare_desc->number, failed_desc->number);
-		xchg_values(sdisk->number, fdisk->number);
-
-		*d = failed_desc;
-
-		if (!sdisk->bdev)
-			sdisk->used_slot = 0;
-
-		/*
-		 * this really activates the spare.
-		 */
-		fdisk->spare = 0;
-		fdisk->write_only = 0;
-
-		/*
-		 * if we activate a spare, we definitely replace a
-		 * non-operational disk slot in the 'low' area of
-		 * the disk array.
-		 */
-		conf->failed_disks--;
-		conf->working_disks++;
-		conf->spare = NULL;
-
-		break;
-
-	case DISKOP_HOT_REMOVE_DISK:
-		rdisk = conf->disks + removed_disk;
-
-		if (rdisk->spare && (removed_disk < conf->raid_disks)) {
-			MD_BUG();	
-			err = 1;
-			goto abort;
-		}
-		rdisk->bdev = NULL;
-		rdisk->used_slot = 0;
+	/*
+	 * if we activate a spare, we definitely replace a
+	 * non-operational disk slot in the 'low' area of
+	 * the disk array.
+	 */
+	conf->failed_disks--;
+	conf->working_disks++;
+	conf->spare = NULL;
+abort:
+	spin_unlock_irq(&conf->device_lock);
+	print_raid5_conf(conf);
+	return err;
+}
 
-		break;
+static int raid5_spare_inactive(mddev_t *mddev)
+{
+	raid5_conf_t *conf = mddev->private;
+	struct disk_info *p;
+	int err = 0;
 
-	case DISKOP_HOT_ADD_DISK:
-		adisk = conf->disks + added_disk;
-		added_desc = *d;
-
-		if (added_disk != added_desc->number) {
-			MD_BUG();	
-			err = 1;
-			goto abort;
-		}
+	print_raid5_conf(conf);
+	spin_lock_irq(&conf->device_lock);
+	p = find_spare(mddev, mddev->spare->number);
+	if (p) {
+		p->operational = 0;
+		p->write_only = 0;
+		if (conf->spare == p)
+			conf->spare = NULL;
+	} else {
+		MD_BUG();
+		err = 1;
+	}
+	spin_unlock_irq(&conf->device_lock);
+	print_raid5_conf(conf);
+	return err;
+}
 
-		adisk->number = added_desc->number;
-		adisk->raid_disk = added_desc->raid_disk;
-		/* it will be held open by rdev */
-		adisk->bdev = bdget(MKDEV(added_desc->major,added_desc->minor));
+static int raid5_spare_write(mddev_t *mddev, int number)
+{
+	raid5_conf_t *conf = mddev->private;
+	struct disk_info *p;
+	int err = 0;
 
-		adisk->operational = 0;
-		adisk->write_only = 0;
-		adisk->spare = 1;
-		adisk->used_slot = 1;
+	print_raid5_conf(conf);
+	spin_lock_irq(&conf->device_lock);
+	p = find_spare(mddev, number);
+	if (p && !conf->spare) {
+		p->operational = 1;
+		p->write_only = 1;
+		conf->spare = p;
+	} else {
+		MD_BUG();
+		err = 1;
+	}
+	spin_unlock_irq(&conf->device_lock);
+	print_raid5_conf(conf);
+	return err;
+}
 
+static int raid5_remove_disk(mddev_t *mddev, int number)
+{
+	raid5_conf_t *conf = mddev->private;
+	int err = 1;
+	int i;
 
-		break;
+	print_raid5_conf(conf);
+	spin_lock_irq(&conf->device_lock);
 
-	default:
-		MD_BUG();	
-		err = 1;
-		goto abort;
+	for (i = 0; i < MD_SB_DISKS; i++) {
+		struct disk_info *p = conf->disks + i;
+		if (p->used_slot && p->number == number) {
+			if (p->operational) {
+				err = -EBUSY;
+				goto abort;
+			}
+			if (p->spare && i < conf->raid_disks)
+				break;
+			p->bdev = NULL;
+			p->used_slot = 0;
+			err = 0;
+			break;
+		}
 	}
+	if (err)
+		MD_BUG();
 abort:
 	spin_unlock_irq(&conf->device_lock);
 	print_raid5_conf(conf);
 	return err;
 }
 
+static int raid5_add_disk(mddev_t *mddev, mdp_disk_t *added_desc,
+	mdk_rdev_t *rdev)
+{
+	raid5_conf_t *conf = mddev->private;
+	int err = 1;
+	int i;
+
+	print_raid5_conf(conf);
+	spin_lock_irq(&conf->device_lock);
+	/*
+	 * find the disk ...
+	 */
+
+	for (i = conf->raid_disks; i < MD_SB_DISKS; i++) {
+		struct disk_info *p = conf->disks + i;
+		if (!p->used_slot) {
+			if (added_desc->number != i)
+				break;
+			p->number = added_desc->number;
+			p->raid_disk = added_desc->raid_disk;
+			/* it will be held open by rdev */
+			p->bdev = rdev->bdev;
+			p->operational = 0;
+			p->write_only = 0;
+			p->spare = 1;
+			p->used_slot = 1;
+			err = 0;
+			break;
+		}
+	}
+	if (err)
+		MD_BUG();
+	spin_unlock_irq(&conf->device_lock);
+	print_raid5_conf(conf);
+	return err;
+}
+
 static mdk_personality_t raid5_personality=
 {
 	name:		"raid5",
@@ -1977,7 +1943,11 @@
 	stop:		stop,
 	status:		status,
 	error_handler:	error,
-	diskop:		diskop,
+	hot_add_disk:	raid5_add_disk,
+	hot_remove_disk:raid5_remove_disk,
+	spare_write:	raid5_spare_write,
+	spare_inactive:	raid5_spare_inactive,
+	spare_active:	raid5_spare_active,
 	sync_request:	sync_request
 };
 
diff -urN C24-0/fs/partitions/check.c C24-current/fs/partitions/check.c
--- C24-0/fs/partitions/check.c	Thu Jun 20 13:37:25 2002
+++ C24-current/fs/partitions/check.c	Sat Jun 29 15:10:52 2002
@@ -13,14 +13,9 @@
  *  Added needed MAJORS for new pairs, {hdi,hdj}, {hdk,hdl}
  */
 
-#include <linux/config.h>
+#include <linux/init.h>
 #include <linux/fs.h>
-#include <linux/genhd.h>
-#include <linux/kernel.h>
-#include <linux/major.h>
 #include <linux/blk.h>
-#include <linux/init.h>
-#include <linux/raid/md.h>
 #include <linux/buffer_head.h>	/* for invalidate_bdev() */
 
 #include "check.h"
diff -urN C24-0/include/linux/raid/md_k.h C24-current/include/linux/raid/md_k.h
--- C24-0/include/linux/raid/md_k.h	Mon Jun 24 23:41:24 2002
+++ C24-current/include/linux/raid/md_k.h	Sat Jun 29 15:05:18 2002
@@ -160,16 +160,6 @@
 	int desc_nr;			/* descriptor index in the superblock */
 };
 
-
-/*
- * disk operations in a working array:
- */
-#define DISKOP_SPARE_INACTIVE	0
-#define DISKOP_SPARE_WRITE	1
-#define DISKOP_SPARE_ACTIVE	2
-#define DISKOP_HOT_REMOVE_DISK	3
-#define DISKOP_HOT_ADD_DISK	4
-
 typedef struct mdk_personality_s mdk_personality_t;
 
 struct mddev_s
@@ -214,18 +204,11 @@
 	int (*stop)(mddev_t *mddev);
 	int (*status)(char *page, mddev_t *mddev);
 	int (*error_handler)(mddev_t *mddev, struct block_device *bdev);
-
-/*
- * Some personalities (RAID-1, RAID-5) can have disks hot-added and
- * hot-removed. Hot removal is different from failure. (failure marks
- * a disk inactive, but the disk is still part of the array) The interface
- * to such operations is the 'pers->diskop()' function, can be NULL.
- *
- * the diskop function can change the pointer pointing to the incoming
- * descriptor, but must do so very carefully. (currently only
- * SPARE_ACTIVE expects such a change)
- */
-	int (*diskop) (mddev_t *mddev, mdp_disk_t **descriptor, int state);
+	int (*hot_add_disk) (mddev_t *mddev, mdp_disk_t *descriptor, mdk_rdev_t *rdev);
+	int (*hot_remove_disk) (mddev_t *mddev, int number);
+	int (*spare_write) (mddev_t *mddev, int number);
+	int (*spare_inactive) (mddev_t *mddev);
+	int (*spare_active) (mddev_t *mddev, mdp_disk_t **descriptor);
 	int (*sync_request)(mddev_t *mddev, sector_t sector_nr, int go_faster);
 };
 

