Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964817AbWGaHdE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964817AbWGaHdE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 03:33:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964829AbWGaHdA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 03:33:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:34222 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964807AbWGaHco (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 03:32:44 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Mon, 31 Jul 2006 17:32:36 +1000
Message-Id: <1060731073236.24506@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 007 of 9] md: Remove 'working_disks' from raid10 state
References: <20060731172842.24323.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


It isn't needed as mddev->degraded contains equivalent info.
Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./drivers/md/raid10.c         |   12 ++++--------
 ./include/linux/raid/raid10.h |    1 -
 2 files changed, 4 insertions(+), 9 deletions(-)

diff .prev/drivers/md/raid10.c ./drivers/md/raid10.c
--- .prev/drivers/md/raid10.c	2006-07-31 17:24:34.000000000 +1000
+++ ./drivers/md/raid10.c	2006-07-31 17:24:35.000000000 +1000
@@ -921,7 +921,7 @@ static void status(struct seq_file *seq,
 			seq_printf(seq, " %d far-copies", conf->far_copies);
 	}
 	seq_printf(seq, " [%d/%d] [", conf->raid_disks,
-						conf->working_disks);
+					conf->raid_disks - mddev->degraded);
 	for (i = 0; i < conf->raid_disks; i++)
 		seq_printf(seq, "%s",
 			      conf->mirrors[i].rdev &&
@@ -941,7 +941,7 @@ static void error(mddev_t *mddev, mdk_rd
 	 * else mark the drive as failed
 	 */
 	if (test_bit(In_sync, &rdev->flags)
-	    && conf->working_disks == 1)
+	    && conf->raid_disks-mddev->degraded == 1)
 		/*
 		 * Don't fail the drive, just return an IO error.
 		 * The test should really be more sophisticated than
@@ -952,7 +952,6 @@ static void error(mddev_t *mddev, mdk_rd
 		return;
 	if (test_bit(In_sync, &rdev->flags)) {
 		mddev->degraded++;
-		conf->working_disks--;
 		/*
 		 * if recovery is running, make sure it aborts.
 		 */
@@ -963,7 +962,7 @@ static void error(mddev_t *mddev, mdk_rd
 	set_bit(MD_CHANGE_DEVS, &mddev->flags);
 	printk(KERN_ALERT "raid10: Disk failure on %s, disabling device. \n"
 		"	Operation continuing on %d devices\n",
-		bdevname(rdev->bdev,b), conf->working_disks);
+		bdevname(rdev->bdev,b), conf->raid_disks - mddev->degraded);
 }
 
 static void print_conf(conf_t *conf)
@@ -976,7 +975,7 @@ static void print_conf(conf_t *conf)
 		printk("(!conf)\n");
 		return;
 	}
-	printk(" --- wd:%d rd:%d\n", conf->working_disks,
+	printk(" --- wd:%d rd:%d\n", conf->raid_disks - conf->mddev->degraded,
 		conf->raid_disks);
 
 	for (i = 0; i < conf->raid_disks; i++) {
@@ -1035,7 +1034,6 @@ static int raid10_spare_active(mddev_t *
 		if (tmp->rdev
 		    && !test_bit(Faulty, &tmp->rdev->flags)
 		    && !test_bit(In_sync, &tmp->rdev->flags)) {
-			conf->working_disks++;
 			mddev->degraded--;
 			set_bit(In_sync, &tmp->rdev->flags);
 		}
@@ -2035,8 +2033,6 @@ static int run(mddev_t *mddev)
 			mddev->queue->max_sectors = (PAGE_SIZE>>9);
 
 		disk->head_position = 0;
-		if (!test_bit(Faulty, &rdev->flags) && test_bit(In_sync, &rdev->flags))
-			conf->working_disks++;
 	}
 	conf->raid_disks = mddev->raid_disks;
 	conf->mddev = mddev;

diff .prev/include/linux/raid/raid10.h ./include/linux/raid/raid10.h
--- .prev/include/linux/raid/raid10.h	2006-07-31 17:23:56.000000000 +1000
+++ ./include/linux/raid/raid10.h	2006-07-31 17:24:35.000000000 +1000
@@ -16,7 +16,6 @@ struct r10_private_data_s {
 	mddev_t			*mddev;
 	mirror_info_t		*mirrors;
 	int			raid_disks;
-	int			working_disks;
 	spinlock_t		device_lock;
 
 	/* geometry */
