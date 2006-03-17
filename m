Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750828AbWCQEuF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750828AbWCQEuF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 23:50:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752521AbWCQEuA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 23:50:00 -0500
Received: from ns.suse.de ([195.135.220.2]:53481 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1752517AbWCQEth (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 23:49:37 -0500
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Fri, 17 Mar 2006 15:48:19 +1100
Message-Id: <1060317044819.16220@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 011 of 13] md: Split reshape handler in check_reshape and start_reshape.
References: <20060317154017.15880.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


check_reshape checks validity and does things that can be done
instantly - like adding devices to raid1.
start_reshape initiates a restriping process to convert the whole array.


Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./drivers/md/md.c           |   10 ++++---
 ./drivers/md/raid1.c        |   19 +++++++++++--
 ./drivers/md/raid5.c        |   60 ++++++++++++++++++++++++--------------------
 ./include/linux/raid/md_k.h |    3 +-
 4 files changed, 58 insertions(+), 34 deletions(-)

diff ./drivers/md/md.c~current~ ./drivers/md/md.c
--- ./drivers/md/md.c~current~	2006-03-17 11:48:58.000000000 +1100
+++ ./drivers/md/md.c	2006-03-17 11:48:59.000000000 +1100
@@ -2589,7 +2589,7 @@ static int do_md_run(mddev_t * mddev)
 	strlcpy(mddev->clevel, pers->name, sizeof(mddev->clevel));
 
 	if (mddev->reshape_position != MaxSector &&
-	    pers->reshape == NULL) {
+	    pers->start_reshape == NULL) {
 		/* This personality cannot handle reshaping... */
 		mddev->pers = NULL;
 		module_put(pers->owner);
@@ -3551,14 +3551,16 @@ static int update_raid_disks(mddev_t *md
 {
 	int rv;
 	/* change the number of raid disks */
-	if (mddev->pers->reshape == NULL)
+	if (mddev->pers->check_reshape == NULL)
 		return -EINVAL;
 	if (raid_disks <= 0 ||
 	    raid_disks >= mddev->max_disks)
 		return -EINVAL;
-	if (mddev->sync_thread)
+	if (mddev->sync_thread || mddev->reshape_position != MaxSector)
 		return -EBUSY;
-	rv = mddev->pers->reshape(mddev, raid_disks);
+	mddev->delta_disks = raid_disks - mddev->raid_disks;
+
+	rv = mddev->pers->check_reshape(mddev);
 	return rv;
 }
 

diff ./drivers/md/raid1.c~current~ ./drivers/md/raid1.c
--- ./drivers/md/raid1.c~current~	2006-03-17 11:48:58.000000000 +1100
+++ ./drivers/md/raid1.c	2006-03-17 11:48:59.000000000 +1100
@@ -1976,7 +1976,7 @@ static int raid1_resize(mddev_t *mddev, 
 	return 0;
 }
 
-static int raid1_reshape(mddev_t *mddev, int raid_disks)
+static int raid1_reshape(mddev_t *mddev)
 {
 	/* We need to:
 	 * 1/ resize the r1bio_pool
@@ -1993,10 +1993,22 @@ static int raid1_reshape(mddev_t *mddev,
 	struct pool_info *newpoolinfo;
 	mirror_info_t *newmirrors;
 	conf_t *conf = mddev_to_conf(mddev);
-	int cnt;
+	int cnt, raid_disks;
 
 	int d, d2;
 
+	/* Cannot change chunk_size, layout, or level */
+	if (mddev->chunk_size != mddev->new_chunk ||
+	    mddev->layout != mddev->new_layout ||
+	    mddev->level != mddev->new_level) {
+		mddev->new_chunk = mddev->chunk_size;
+		mddev->new_layout = mddev->layout;
+		mddev->new_level = mddev->level;
+		return -EINVAL;
+	}
+
+	raid_disks = mddev->raid_disks + mddev->delta_disks;
+
 	if (raid_disks < conf->raid_disks) {
 		cnt=0;
 		for (d= 0; d < conf->raid_disks; d++)
@@ -2043,6 +2055,7 @@ static int raid1_reshape(mddev_t *mddev,
 
 	mddev->degraded += (raid_disks - conf->raid_disks);
 	conf->raid_disks = mddev->raid_disks = raid_disks;
+	mddev->delta_disks = 0;
 
 	conf->last_used = 0; /* just make sure it is in-range */
 	lower_barrier(conf);
@@ -2084,7 +2097,7 @@ static struct mdk_personality raid1_pers
 	.spare_active	= raid1_spare_active,
 	.sync_request	= sync_request,
 	.resize		= raid1_resize,
-	.reshape	= raid1_reshape,
+	.check_reshape	= raid1_reshape,
 	.quiesce	= raid1_quiesce,
 };
 

diff ./drivers/md/raid5.c~current~ ./drivers/md/raid5.c
--- ./drivers/md/raid5.c~current~	2006-03-17 11:48:58.000000000 +1100
+++ ./drivers/md/raid5.c	2006-03-17 11:48:59.000000000 +1100
@@ -2574,21 +2574,15 @@ static int raid5_resize(mddev_t *mddev, 
 	return 0;
 }
 
-static int raid5_reshape(mddev_t *mddev, int raid_disks)
+static int raid5_check_reshape(mddev_t *mddev)
 {
 	raid5_conf_t *conf = mddev_to_conf(mddev);
 	int err;
-	mdk_rdev_t *rdev;
-	struct list_head *rtmp;
-	int spares = 0;
-	int added_devices = 0;
 
-	if (mddev->degraded ||
-	    test_bit(MD_RECOVERY_RUNNING, &mddev->recovery))
-		return -EBUSY;
-	if (conf->raid_disks > raid_disks)
-		return -EINVAL; /* Cannot shrink array yet */
-	if (conf->raid_disks == raid_disks)
+	if (mddev->delta_disks < 0 ||
+	    mddev->new_level != mddev->level)
+		return -EINVAL; /* Cannot shrink array or change level yet */
+	if (mddev->delta_disks == 0)
 		return 0; /* nothing to do */
 
 	/* Can only proceed if there are plenty of stripe_heads.
@@ -2599,30 +2593,48 @@ static int raid5_reshape(mddev_t *mddev,
 	 * If the chunk size is greater, user-space should request more
 	 * stripe_heads first.
 	 */
-	if ((mddev->chunk_size / STRIPE_SIZE) * 4 > conf->max_nr_stripes) {
+	if ((mddev->chunk_size / STRIPE_SIZE) * 4 > conf->max_nr_stripes ||
+	    (mddev->new_chunk / STRIPE_SIZE) * 4 > conf->max_nr_stripes) {
 		printk(KERN_WARNING "raid5: reshape: not enough stripes.  Needed %lu\n",
 		       (mddev->chunk_size / STRIPE_SIZE)*4);
 		return -ENOSPC;
 	}
 
+	err = resize_stripes(conf, conf->raid_disks + mddev->delta_disks);
+	if (err)
+		return err;
+
+	/* looks like we might be able to manage this */
+	return 0;
+}
+
+static int raid5_start_reshape(mddev_t *mddev)
+{
+	raid5_conf_t *conf = mddev_to_conf(mddev);
+	mdk_rdev_t *rdev;
+	struct list_head *rtmp;
+	int spares = 0;
+	int added_devices = 0;
+
+	if (mddev->degraded ||
+	    test_bit(MD_RECOVERY_RUNNING, &mddev->recovery))
+		return -EBUSY;
+
 	ITERATE_RDEV(mddev, rdev, rtmp)
 		if (rdev->raid_disk < 0 &&
 		    !test_bit(Faulty, &rdev->flags))
 			spares++;
-	if (conf->raid_disks + spares < raid_disks-1)
+
+	if (spares < mddev->delta_disks-1)
 		/* Not enough devices even to make a degraded array
 		 * of that size
 		 */
 		return -EINVAL;
 
-	err = resize_stripes(conf, raid_disks);
-	if (err)
-		return err;
-
 	atomic_set(&conf->reshape_stripes, 0);
 	spin_lock_irq(&conf->device_lock);
 	conf->previous_raid_disks = conf->raid_disks;
-	conf->raid_disks = raid_disks;
+	conf->raid_disks += mddev->delta_disks;
 	conf->expand_progress = 0;
 	conf->expand_lo = 0;
 	spin_unlock_irq(&conf->device_lock);
@@ -2644,12 +2656,8 @@ static int raid5_reshape(mddev_t *mddev,
 				break;
 		}
 
-	mddev->degraded = (raid_disks - conf->previous_raid_disks) - added_devices;
-	mddev->new_chunk = mddev->chunk_size;
-	mddev->new_layout = mddev->layout;
-	mddev->new_level = mddev->level;
-	mddev->raid_disks = raid_disks;
-	mddev->delta_disks = raid_disks - conf->previous_raid_disks;
+	mddev->degraded = (conf->raid_disks - conf->previous_raid_disks) - added_devices;
+	mddev->raid_disks = conf->raid_disks;
 	mddev->reshape_position = 0;
 	mddev->sb_dirty = 1;
 
@@ -2663,7 +2671,6 @@ static int raid5_reshape(mddev_t *mddev,
 		mddev->recovery = 0;
 		spin_lock_irq(&conf->device_lock);
 		mddev->raid_disks = conf->raid_disks = conf->previous_raid_disks;
-		mddev->delta_disks = 0;
 		conf->expand_progress = MaxSector;
 		spin_unlock_irq(&conf->device_lock);
 		return -EAGAIN;
@@ -2735,7 +2742,8 @@ static struct mdk_personality raid5_pers
 	.sync_request	= sync_request,
 	.resize		= raid5_resize,
 #if CONFIG_MD_RAID5_RESHAPE
-	.reshape	= raid5_reshape,
+	.check_reshape	= raid5_check_reshape,
+	.start_reshape	= raid5_start_reshape,
 #endif
 	.quiesce	= raid5_quiesce,
 };

diff ./include/linux/raid/md_k.h~current~ ./include/linux/raid/md_k.h
--- ./include/linux/raid/md_k.h~current~	2006-03-17 11:48:58.000000000 +1100
+++ ./include/linux/raid/md_k.h	2006-03-17 11:48:59.000000000 +1100
@@ -261,7 +261,8 @@ struct mdk_personality
 	int (*spare_active) (mddev_t *mddev);
 	sector_t (*sync_request)(mddev_t *mddev, sector_t sector_nr, int *skipped, int go_faster);
 	int (*resize) (mddev_t *mddev, sector_t sectors);
-	int (*reshape) (mddev_t *mddev, int raid_disks);
+	int (*check_reshape) (mddev_t *mddev);
+	int (*start_reshape) (mddev_t *mddev);
 	int (*reconfig) (mddev_t *mddev, int layout, int chunk_size);
 	/* quiesce moves between quiescence states
 	 * 0 - fully active
