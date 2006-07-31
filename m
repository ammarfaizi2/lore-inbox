Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964825AbWGaHcg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964825AbWGaHcg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 03:32:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964819AbWGaHce
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 03:32:34 -0400
Received: from mx1.suse.de ([195.135.220.2]:24267 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S964820AbWGaHc2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 03:32:28 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Mon, 31 Jul 2006 17:32:18 +1000
Message-Id: <1060731073218.24482@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 005 of 9] md: Replace magic numbers in sb_dirty with well defined bit flags
References: <20060731172842.24323.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Instead of magic numbers (0,1,2,3) in sb_dirty, we have
some flags instead:
MD_CHANGE_DEVS
   Some device state has changed requiring superblock update
   on all devices.
MD_CHANGE_CLEAN
   The array has transitions from 'clean' to 'dirty' or back,
   requiring a superblock update on active devices, but possibly
   not on spares
MD_CHANGE_PENDING
   A superblock update is underway.  

We wait for an update to complete by waiting for all flags to
be clear.  A flag can be set at any time, even during an update,
without risk that the change will be lost.

Stop exporting md_update_sb - isn't needed.


Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./drivers/md/md.c           |   68 +++++++++++++++++++++++---------------------
 ./drivers/md/multipath.c    |    3 -
 ./drivers/md/raid1.c        |    2 -
 ./drivers/md/raid10.c       |    2 -
 ./drivers/md/raid5.c        |    8 ++---
 ./include/linux/raid/md.h   |    1 
 ./include/linux/raid/md_k.h |    6 +++
 7 files changed, 49 insertions(+), 41 deletions(-)

diff .prev/drivers/md/md.c ./drivers/md/md.c
--- .prev/drivers/md/md.c	2006-07-31 17:23:57.000000000 +1000
+++ ./drivers/md/md.c	2006-07-31 17:24:34.000000000 +1000
@@ -1587,7 +1587,7 @@ static void sync_sbs(mddev_t * mddev, in
 	}
 }
 
-void md_update_sb(mddev_t * mddev)
+static void md_update_sb(mddev_t * mddev, int force_change)
 {
 	int err;
 	struct list_head *tmp;
@@ -1597,18 +1597,25 @@ void md_update_sb(mddev_t * mddev)
 
 repeat:
 	spin_lock_irq(&mddev->write_lock);
-	sync_req = mddev->in_sync;
-	mddev->utime = get_seconds();
-	if (mddev->sb_dirty == 3)
+
+	set_bit(MD_CHANGE_PENDING, &mddev->flags);
+	if (test_and_clear_bit(MD_CHANGE_DEVS, &mddev->flags))
+		force_change = 1;
+	if (test_and_clear_bit(MD_CHANGE_CLEAN, &mddev->flags))
 		/* just a clean<-> dirty transition, possibly leave spares alone,
 		 * though if events isn't the right even/odd, we will have to do
 		 * spares after all
 		 */
 		nospares = 1;
+	if (force_change)
+		nospares = 0;
+
+	sync_req = mddev->in_sync;
+	mddev->utime = get_seconds();
 
 	/* If this is just a dirty<->clean transition, and the array is clean
 	 * and 'events' is odd, we can roll back to the previous clean state */
-	if (mddev->sb_dirty == 3
+	if (nospares
 	    && (mddev->in_sync && mddev->recovery_cp == MaxSector)
 	    && (mddev->events & 1))
 		mddev->events--;
@@ -1639,7 +1646,6 @@ repeat:
 		MD_BUG();
 		mddev->events --;
 	}
-	mddev->sb_dirty = 2;
 	sync_sbs(mddev, nospares);
 
 	/*
@@ -1647,7 +1653,7 @@ repeat:
 	 * nonpersistent superblocks
 	 */
 	if (!mddev->persistent) {
-		mddev->sb_dirty = 0;
+		clear_bit(MD_CHANGE_PENDING, &mddev->flags);
 		spin_unlock_irq(&mddev->write_lock);
 		wake_up(&mddev->sb_wait);
 		return;
@@ -1684,20 +1690,20 @@ repeat:
 			break;
 	}
 	md_super_wait(mddev);
-	/* if there was a failure, sb_dirty was set to 1, and we re-write super */
+	/* if there was a failure, MD_CHANGE_DEVS was set, and we re-write super */
 
 	spin_lock_irq(&mddev->write_lock);
-	if (mddev->in_sync != sync_req|| mddev->sb_dirty == 1) {
+	if (mddev->in_sync != sync_req ||
+	    test_bit(MD_CHANGE_DEVS, &mddev->flags)) {
 		/* have to write it out again */
 		spin_unlock_irq(&mddev->write_lock);
 		goto repeat;
 	}
-	mddev->sb_dirty = 0;
+	clear_bit(MD_CHANGE_PENDING, &mddev->flags);
 	spin_unlock_irq(&mddev->write_lock);
 	wake_up(&mddev->sb_wait);
 
 }
-EXPORT_SYMBOL_GPL(md_update_sb);
 
 /* words written to sysfs files may, or my not, be \n terminated.
  * We want to accept with case. For this we use cmd_match.
@@ -1770,7 +1776,7 @@ state_store(mdk_rdev_t *rdev, const char
 		else {
 			mddev_t *mddev = rdev->mddev;
 			kick_rdev_from_array(rdev);
-			md_update_sb(mddev);
+			md_update_sb(mddev, 1);
 			md_new_event(mddev);
 			err = 0;
 		}
@@ -2413,7 +2419,7 @@ array_state_store(mddev_t *mddev, const 
 			spin_lock_irq(&mddev->write_lock);
 			if (atomic_read(&mddev->writes_pending) == 0) {
 				mddev->in_sync = 1;
-				mddev->sb_dirty = 1;
+				set_bit(MD_CHANGE_CLEAN, &mddev->flags);
 			}
 			spin_unlock_irq(&mddev->write_lock);
 		} else {
@@ -2425,7 +2431,7 @@ array_state_store(mddev_t *mddev, const 
 	case active:
 		if (mddev->pers) {
 			restart_array(mddev);
-			mddev->sb_dirty = 0;
+			clear_bit(MD_CHANGE_CLEAN, &mddev->flags);
 			wake_up(&mddev->sb_wait);
 			err = 0;
 		} else {
@@ -2530,7 +2536,7 @@ size_store(mddev_t *mddev, const char *b
 
 	if (mddev->pers) {
 		err = update_size(mddev, size);
-		md_update_sb(mddev);
+		md_update_sb(mddev, 1);
 	} else {
 		if (mddev->size == 0 ||
 		    mddev->size > size)
@@ -3098,8 +3104,8 @@ static int do_md_run(mddev_t * mddev)
 	
 	set_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
 	
-	if (mddev->sb_dirty)
-		md_update_sb(mddev);
+	if (mddev->flags)
+		md_update_sb(mddev, 0);
 
 	set_capacity(disk, mddev->array_size<<1);
 
@@ -3262,10 +3268,10 @@ static int do_md_stop(mddev_t * mddev, i
 			if (mddev->ro)
 				mddev->ro = 0;
 		}
-		if (!mddev->in_sync || mddev->sb_dirty) {
+		if (!mddev->in_sync || mddev->flags) {
 			/* mark array as shutdown cleanly */
 			mddev->in_sync = 1;
-			md_update_sb(mddev);
+			md_update_sb(mddev, 1);
 		}
 		if (mode == 1)
 			set_disk_ro(disk, 1);
@@ -3734,7 +3740,7 @@ static int hot_remove_disk(mddev_t * mdd
 		goto busy;
 
 	kick_rdev_from_array(rdev);
-	md_update_sb(mddev);
+	md_update_sb(mddev, 1);
 	md_new_event(mddev);
 
 	return 0;
@@ -3811,7 +3817,7 @@ static int hot_add_disk(mddev_t * mddev,
 
 	rdev->raid_disk = -1;
 
-	md_update_sb(mddev);
+	md_update_sb(mddev, 1);
 
 	/*
 	 * Kick recovery, maybe this spare has to be added to the
@@ -3942,7 +3948,8 @@ static int set_array_info(mddev_t * mdde
 
 	mddev->max_disks     = MD_SB_DISKS;
 
-	mddev->sb_dirty      = 1;
+	mddev->flags         = 0;
+	set_bit(MD_CHANGE_DEVS, &mddev->flags);
 
 	mddev->default_bitmap_offset = MD_SB_BYTES >> 9;
 	mddev->bitmap_offset = 0;
@@ -4111,7 +4118,7 @@ static int update_array_info(mddev_t *md
 			mddev->bitmap_offset = 0;
 		}
 	}
-	md_update_sb(mddev);
+	md_update_sb(mddev, 1);
 	return rv;
 }
 
@@ -4947,12 +4954,12 @@ void md_write_start(mddev_t *mddev, stru
 		spin_lock_irq(&mddev->write_lock);
 		if (mddev->in_sync) {
 			mddev->in_sync = 0;
-			mddev->sb_dirty = 3;
+			set_bit(MD_CHANGE_CLEAN, &mddev->flags);
 			md_wakeup_thread(mddev->thread);
 		}
 		spin_unlock_irq(&mddev->write_lock);
 	}
-	wait_event(mddev->sb_wait, mddev->sb_dirty==0);
+	wait_event(mddev->sb_wait, mddev->flags==0);
 }
 
 void md_write_end(mddev_t *mddev)
@@ -5222,7 +5229,6 @@ void md_do_sync(mddev_t *mddev)
 				    !test_bit(In_sync, &rdev->flags) &&
 				    rdev->recovery_offset < mddev->curr_resync)
 					rdev->recovery_offset = mddev->curr_resync;
-			mddev->sb_dirty = 1;
 		}
 	}
 
@@ -5279,7 +5285,7 @@ void md_check_recovery(mddev_t *mddev)
 	}
 
 	if ( ! (
-		mddev->sb_dirty ||
+		mddev->flags ||
 		test_bit(MD_RECOVERY_NEEDED, &mddev->recovery) ||
 		test_bit(MD_RECOVERY_DONE, &mddev->recovery) ||
 		(mddev->safemode == 1) ||
@@ -5295,14 +5301,14 @@ void md_check_recovery(mddev_t *mddev)
 		if (mddev->safemode && !atomic_read(&mddev->writes_pending) &&
 		    !mddev->in_sync && mddev->recovery_cp == MaxSector) {
 			mddev->in_sync = 1;
-			mddev->sb_dirty = 3;
+			set_bit(MD_CHANGE_CLEAN, &mddev->flags);
 		}
 		if (mddev->safemode == 1)
 			mddev->safemode = 0;
 		spin_unlock_irq(&mddev->write_lock);
 
-		if (mddev->sb_dirty)
-			md_update_sb(mddev);
+		if (mddev->flags)
+			md_update_sb(mddev, 0);
 
 
 		if (test_bit(MD_RECOVERY_RUNNING, &mddev->recovery) &&
@@ -5321,7 +5327,7 @@ void md_check_recovery(mddev_t *mddev)
 				/* activate any spares */
 				mddev->pers->spare_active(mddev);
 			}
-			md_update_sb(mddev);
+			md_update_sb(mddev, 1);
 
 			/* if array is no-longer degraded, then any saved_raid_disk
 			 * information must be scrapped

diff .prev/drivers/md/multipath.c ./drivers/md/multipath.c
--- .prev/drivers/md/multipath.c	2006-07-31 17:23:57.000000000 +1000
+++ ./drivers/md/multipath.c	2006-07-31 17:24:34.000000000 +1000
@@ -253,7 +253,7 @@ static void multipath_error (mddev_t *md
 			char b[BDEVNAME_SIZE];
 			clear_bit(In_sync, &rdev->flags);
 			set_bit(Faulty, &rdev->flags);
-			mddev->sb_dirty = 1;
+			set_bit(MD_CHANGE_DEVS, &mddev->flags);
 			conf->working_disks--;
 			printk(KERN_ALERT "multipath: IO failure on %s,"
 				" disabling IO path. \n	Operation continuing"
@@ -470,7 +470,6 @@ static int multipath_run (mddev_t *mddev
 	}
 
 	conf->raid_disks = mddev->raid_disks;
-	mddev->sb_dirty = 1;
 	conf->mddev = mddev;
 	spin_lock_init(&conf->device_lock);
 	INIT_LIST_HEAD(&conf->retry_list);

diff .prev/drivers/md/raid1.c ./drivers/md/raid1.c
--- .prev/drivers/md/raid1.c	2006-07-31 17:24:24.000000000 +1000
+++ ./drivers/md/raid1.c	2006-07-31 17:24:34.000000000 +1000
@@ -966,7 +966,7 @@ static void error(mddev_t *mddev, mdk_rd
 	}
 	clear_bit(In_sync, &rdev->flags);
 	set_bit(Faulty, &rdev->flags);
-	mddev->sb_dirty = 1;
+	set_bit(MD_CHANGE_DEVS, &mddev->flags);
 	printk(KERN_ALERT "raid1: Disk failure on %s, disabling device. \n"
 		"	Operation continuing on %d devices\n",
 		bdevname(rdev->bdev,b), conf->working_disks);

diff .prev/drivers/md/raid10.c ./drivers/md/raid10.c
--- .prev/drivers/md/raid10.c	2006-07-31 17:24:34.000000000 +1000
+++ ./drivers/md/raid10.c	2006-07-31 17:24:34.000000000 +1000
@@ -960,7 +960,7 @@ static void error(mddev_t *mddev, mdk_rd
 	}
 	clear_bit(In_sync, &rdev->flags);
 	set_bit(Faulty, &rdev->flags);
-	mddev->sb_dirty = 1;
+	set_bit(MD_CHANGE_DEVS, &mddev->flags);
 	printk(KERN_ALERT "raid10: Disk failure on %s, disabling device. \n"
 		"	Operation continuing on %d devices\n",
 		bdevname(rdev->bdev,b), conf->working_disks);

diff .prev/drivers/md/raid5.c ./drivers/md/raid5.c
--- .prev/drivers/md/raid5.c	2006-07-31 17:23:57.000000000 +1000
+++ ./drivers/md/raid5.c	2006-07-31 17:24:34.000000000 +1000
@@ -696,7 +696,7 @@ static void error(mddev_t *mddev, mdk_rd
 	PRINTK("raid5: error called\n");
 
 	if (!test_bit(Faulty, &rdev->flags)) {
-		mddev->sb_dirty = 1;
+		set_bit(MD_CHANGE_DEVS, &mddev->flags);
 		if (test_bit(In_sync, &rdev->flags)) {
 			conf->working_disks--;
 			mddev->degraded++;
@@ -2781,9 +2781,9 @@ static sector_t reshape_request(mddev_t 
 		wait_event(conf->wait_for_overlap,
 			   atomic_read(&conf->reshape_stripes)==0);
 		mddev->reshape_position = conf->expand_progress;
-		mddev->sb_dirty = 1;
+		set_bit(MD_CHANGE_DEVS, &mddev->flags);
 		md_wakeup_thread(mddev->thread);
-		wait_event(mddev->sb_wait, mddev->sb_dirty == 0 ||
+		wait_event(mddev->sb_wait, mddev->flags == 0 ||
 			   kthread_should_stop());
 		spin_lock_irq(&conf->device_lock);
 		conf->expand_lo = mddev->reshape_position;
@@ -3605,7 +3605,7 @@ static int raid5_start_reshape(mddev_t *
 	mddev->degraded = (conf->raid_disks - conf->previous_raid_disks) - added_devices;
 	mddev->raid_disks = conf->raid_disks;
 	mddev->reshape_position = 0;
-	mddev->sb_dirty = 1;
+	set_bit(MD_CHANGE_DEVS, &mddev->flags);
 
 	clear_bit(MD_RECOVERY_SYNC, &mddev->recovery);
 	clear_bit(MD_RECOVERY_CHECK, &mddev->recovery);

diff .prev/include/linux/raid/md.h ./include/linux/raid/md.h
--- .prev/include/linux/raid/md.h	2006-07-31 17:23:57.000000000 +1000
+++ ./include/linux/raid/md.h	2006-07-31 17:24:34.000000000 +1000
@@ -93,7 +93,6 @@ extern int sync_page_io(struct block_dev
 extern void md_do_sync(mddev_t *mddev);
 extern void md_new_event(mddev_t *mddev);
 
-extern void md_update_sb(mddev_t * mddev);
 
 #endif 
 

diff .prev/include/linux/raid/md_k.h ./include/linux/raid/md_k.h
--- .prev/include/linux/raid/md_k.h	2006-07-31 17:23:57.000000000 +1000
+++ ./include/linux/raid/md_k.h	2006-07-31 17:24:34.000000000 +1000
@@ -114,7 +114,11 @@ struct mddev_s
 	dev_t				unit;
 	int				md_minor;
 	struct list_head 		disks;
-	int				sb_dirty;
+	unsigned long			flags;
+#define MD_CHANGE_DEVS	0	/* Some device status has changed */
+#define MD_CHANGE_CLEAN 1	/* transition to or from 'clean' */
+#define MD_CHANGE_PENDING 2	/* superblock update in progress */
+
 	int				ro;
 
 	struct gendisk			*gendisk;
