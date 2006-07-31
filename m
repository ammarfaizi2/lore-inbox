Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964819AbWGaHdG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964819AbWGaHdG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 03:33:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964822AbWGaHc6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 03:32:58 -0400
Received: from ns1.suse.de ([195.135.220.2]:35019 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S964819AbWGaHcw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 03:32:52 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Mon, 31 Jul 2006 17:32:44 +1000
Message-Id: <1060731073244.24518@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 008 of 9] md: Remove working_disks from raid1 state data
References: <20060731172842.24323.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


It is equivalent to conf->raid_disks - conf->mddev->degraded.

Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./drivers/md/raid1.c         |   28 ++++++++++++----------------
 ./include/linux/raid/raid1.h |    1 -
 2 files changed, 12 insertions(+), 17 deletions(-)

diff .prev/drivers/md/raid1.c ./drivers/md/raid1.c
--- .prev/drivers/md/raid1.c	2006-07-31 17:24:34.000000000 +1000
+++ ./drivers/md/raid1.c	2006-07-31 17:24:36.000000000 +1000
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
 	for (i = 0; i < conf->raid_disks; i++)
 		seq_printf(seq, "%s",
 			      conf->mirrors[i].rdev &&
@@ -950,7 +950,7 @@ static void error(mddev_t *mddev, mdk_rd
 	 * else mark the drive as failed
 	 */
 	if (test_bit(In_sync, &rdev->flags)
-	    && conf->working_disks == 1)
+	    && (conf->raid_disks - mddev->degraded) == 1)
 		/*
 		 * Don't fail the drive, act as though we were just a
 		 * normal single drive
@@ -958,7 +958,6 @@ static void error(mddev_t *mddev, mdk_rd
 		return;
 	if (test_bit(In_sync, &rdev->flags)) {
 		mddev->degraded++;
-		conf->working_disks--;
 		/*
 		 * if recovery is running, make sure it aborts.
 		 */
@@ -969,7 +968,7 @@ static void error(mddev_t *mddev, mdk_rd
 	set_bit(MD_CHANGE_DEVS, &mddev->flags);
 	printk(KERN_ALERT "raid1: Disk failure on %s, disabling device. \n"
 		"	Operation continuing on %d devices\n",
-		bdevname(rdev->bdev,b), conf->working_disks);
+		bdevname(rdev->bdev,b), conf->raid_disks - mddev->degraded);
 }
 
 static void print_conf(conf_t *conf)
@@ -982,7 +981,7 @@ static void print_conf(conf_t *conf)
 		printk("(!conf)\n");
 		return;
 	}
-	printk(" --- wd:%d rd:%d\n", conf->working_disks,
+	printk(" --- wd:%d rd:%d\n", conf->raid_disks - conf->mddev->degraded,
 		conf->raid_disks);
 
 	for (i = 0; i < conf->raid_disks; i++) {
@@ -1019,7 +1018,6 @@ static int raid1_spare_active(mddev_t *m
 		if (tmp->rdev 
 		    && !test_bit(Faulty, &tmp->rdev->flags)
 		    && !test_bit(In_sync, &tmp->rdev->flags)) {
-			conf->working_disks++;
 			mddev->degraded--;
 			set_bit(In_sync, &tmp->rdev->flags);
 		}
@@ -1887,15 +1885,11 @@ static int run(mddev_t *mddev)
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
@@ -1903,11 +1897,6 @@ static int run(mddev_t *mddev)
 	bio_list_init(&conf->pending_bio_list);
 	bio_list_init(&conf->flushing_bio_list);
 
-	if (!conf->working_disks) {
-		printk(KERN_ERR "raid1: no operational mirrors for %s\n",
-			mdname(mddev));
-		goto out_free_conf;
-	}
 
 	mddev->degraded = 0;
 	for (i = 0; i < conf->raid_disks; i++) {
@@ -1920,6 +1909,13 @@ static int run(mddev_t *mddev)
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

diff .prev/include/linux/raid/raid1.h ./include/linux/raid/raid1.h
--- .prev/include/linux/raid/raid1.h	2006-07-31 17:23:55.000000000 +1000
+++ ./include/linux/raid/raid1.h	2006-07-31 17:24:36.000000000 +1000
@@ -30,7 +30,6 @@ struct r1_private_data_s {
 	mddev_t			*mddev;
 	mirror_info_t		*mirrors;
 	int			raid_disks;
-	int			working_disks;
 	int			last_used;
 	sector_t		next_seq_sect;
 	spinlock_t		device_lock;
