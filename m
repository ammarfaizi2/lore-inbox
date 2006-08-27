Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932277AbWH0Xtv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932277AbWH0Xtv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Aug 2006 19:49:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932310AbWH0Xts
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Aug 2006 19:49:48 -0400
Received: from ns2.suse.de ([195.135.220.15]:5248 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932277AbWH0Xta (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Aug 2006 19:49:30 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Mon, 28 Aug 2006 09:49:27 +1000
Message-Id: <1060827234927.32490@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 003 of 4] md: Remove working_disks from raid1 state data
References: <20060828092849.21292.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: NeilBrown <neilb@suse.de>

It is equivalent to conf->raid_disks - conf->mddev->degraded.

Signed-off-by: Neil Brown <neilb@suse.de>
---

 drivers/md/raid1.c         |   28 ++++++++++++----------------
 include/linux/raid/raid1.h |    1 -
 2 files changed, 12 insertions(+), 17 deletions(-)

Index: mm-quilt/drivers/md/raid1.c
===================================================================
--- mm-quilt.orig/drivers/md/raid1.c	2006-08-28 09:43:14.000000000 +1000
+++ mm-quilt/drivers/md/raid1.c	2006-08-28 09:43:39.000000000 +1000
@@ -271,7 +271,7 @@ static int raid1_end_read_request(struct
 	 */
 	update_head_pos(mirror, r1_bio);
 
-	if (uptodate || conf->working_disks <= 1) {
+	if (uptodate || (conf->raid_disks - conf->mddev->degraded) <= 1) {
 		/*
 		 * Set R1BIO_Uptodate in our master bio, so that
 		 * we will return a good error code for to the higher
@@ -929,7 +929,7 @@ static void status(struct seq_file *seq,
 	int i;
 
 	seq_printf(seq, " [%d/%d] [", conf->raid_disks,
-						conf->working_disks);
+		   conf->raid_disks - mddev->degraded);
 	rcu_read_lock();
 	for (i = 0; i < conf->raid_disks; i++) {
 		mdk_rdev_t *rdev = rcu_dereference(conf->mirrors[i].rdev);
@@ -953,7 +953,7 @@ static void error(mddev_t *mddev, mdk_rd
 	 * else mark the drive as failed
 	 */
 	if (test_bit(In_sync, &rdev->flags)
-	    && conf->working_disks == 1)
+	    && (conf->raid_disks - mddev->degraded) == 1)
 		/*
 		 * Don't fail the drive, act as though we were just a
 		 * normal single drive
@@ -961,7 +961,6 @@ static void error(mddev_t *mddev, mdk_rd
 		return;
 	if (test_bit(In_sync, &rdev->flags)) {
 		mddev->degraded++;
-		conf->working_disks--;
 		/*
 		 * if recovery is running, make sure it aborts.
 		 */
@@ -972,7 +971,7 @@ static void error(mddev_t *mddev, mdk_rd
 	set_bit(MD_CHANGE_DEVS, &mddev->flags);
 	printk(KERN_ALERT "raid1: Disk failure on %s, disabling device. \n"
 		"	Operation continuing on %d devices\n",
-		bdevname(rdev->bdev,b), conf->working_disks);
+		bdevname(rdev->bdev,b), conf->raid_disks - mddev->degraded);
 }
 
 static void print_conf(conf_t *conf)
@@ -984,7 +983,7 @@ static void print_conf(conf_t *conf)
 		printk("(!conf)\n");
 		return;
 	}
-	printk(" --- wd:%d rd:%d\n", conf->working_disks,
+	printk(" --- wd:%d rd:%d\n", conf->raid_disks - conf->mddev->degraded,
 		conf->raid_disks);
 
 	rcu_read_lock();
@@ -1024,7 +1023,6 @@ static int raid1_spare_active(mddev_t *m
 		if (rdev
 		    && !test_bit(Faulty, &rdev->flags)
 		    && !test_bit(In_sync, &rdev->flags)) {
-			conf->working_disks++;
 			mddev->degraded--;
 			set_bit(In_sync, &rdev->flags);
 		}
@@ -1901,15 +1899,11 @@ static int run(mddev_t *mddev)
 			blk_queue_max_sectors(mddev->queue, PAGE_SIZE>>9);
 
 		disk->head_position = 0;
-		if (!test_bit(Faulty, &rdev->flags) && test_bit(In_sync, &rdev->flags))
-			conf->working_disks++;
 	}
 	conf->raid_disks = mddev->raid_disks;
 	conf->mddev = mddev;
 	spin_lock_init(&conf->device_lock);
 	INIT_LIST_HEAD(&conf->retry_list);
-	if (conf->working_disks == 1)
-		mddev->recovery_cp = MaxSector;
 
 	spin_lock_init(&conf->resync_lock);
 	init_waitqueue_head(&conf->wait_barrier);
@@ -1917,11 +1911,6 @@ static int run(mddev_t *mddev)
 	bio_list_init(&conf->pending_bio_list);
 	bio_list_init(&conf->flushing_bio_list);
 
-	if (!conf->working_disks) {
-		printk(KERN_ERR "raid1: no operational mirrors for %s\n",
-			mdname(mddev));
-		goto out_free_conf;
-	}
 
 	mddev->degraded = 0;
 	for (i = 0; i < conf->raid_disks; i++) {
@@ -1934,6 +1923,13 @@ static int run(mddev_t *mddev)
 			mddev->degraded++;
 		}
 	}
+	if (mddev->degraded == conf->raid_disks) {
+		printk(KERN_ERR "raid1: no operational mirrors for %s\n",
+			mdname(mddev));
+		goto out_free_conf;
+	}
+	if (conf->raid_disks - mddev->degraded == 1)
+		mddev->recovery_cp = MaxSector;
 
 	/*
 	 * find the first working one and use it as a starting point
Index: mm-quilt/include/linux/raid/raid1.h
===================================================================
--- mm-quilt.orig/include/linux/raid/raid1.h	2006-08-28 09:41:37.000000000 +1000
+++ mm-quilt/include/linux/raid/raid1.h	2006-08-28 09:43:39.000000000 +1000
@@ -30,7 +30,6 @@ struct r1_private_data_s {
 	mddev_t			*mddev;
 	mirror_info_t		*mirrors;
 	int			raid_disks;
-	int			working_disks;
 	int			last_used;
 	sector_t		next_seq_sect;
 	spinlock_t		device_lock;
