Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964838AbWGaHdq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964838AbWGaHdq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 03:33:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964833AbWGaHdH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 03:33:07 -0400
Received: from cantor2.suse.de ([195.135.220.15]:36014 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964830AbWGaHdB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 03:33:01 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Mon, 31 Jul 2006 17:32:52 +1000
Message-Id: <1060731073252.24530@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 009 of 9] md: Improve locking around error handling.
References: <20060731172842.24323.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The error handling routines don't use proper locking, and
so two concurrent errors could trigger a problem.
So:
  - use test-and-set and test-and-clear to synchonise
    the In_sync bits with the ->degraded count
  - use the spinlock to protect updates to the
    degraded count (could use an atomic_t but that
    would be a bigger change in code, and isn't
    really justified)
  - remove un-necessary locking in raid5
Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./drivers/md/raid1.c  |   16 +++++++++++-----
 ./drivers/md/raid10.c |   12 ++++++++----
 ./drivers/md/raid5.c  |   20 ++++++++++++--------
 3 files changed, 31 insertions(+), 17 deletions(-)

diff .prev/drivers/md/raid1.c ./drivers/md/raid1.c
--- .prev/drivers/md/raid1.c	2006-07-31 17:24:36.000000000 +1000
+++ ./drivers/md/raid1.c	2006-07-31 17:24:36.000000000 +1000
@@ -956,14 +956,16 @@ static void error(mddev_t *mddev, mdk_rd
 		 * normal single drive
 		 */
 		return;
-	if (test_bit(In_sync, &rdev->flags)) {
+	if (test_and_clear_bit(In_sync, &rdev->flags)) {
+		unsigned long flags;
+		spin_lock_irqsave(&conf->device_lock, flags);
 		mddev->degraded++;
+		spin_unlock_irqrestore(&conf->device_lock, flags);
 		/*
 		 * if recovery is running, make sure it aborts.
 		 */
 		set_bit(MD_RECOVERY_ERR, &mddev->recovery);
 	}
-	clear_bit(In_sync, &rdev->flags);
 	set_bit(Faulty, &rdev->flags);
 	set_bit(MD_CHANGE_DEVS, &mddev->flags);
 	printk(KERN_ALERT "raid1: Disk failure on %s, disabling device. \n"
@@ -1017,9 +1019,11 @@ static int raid1_spare_active(mddev_t *m
 		tmp = conf->mirrors + i;
 		if (tmp->rdev 
 		    && !test_bit(Faulty, &tmp->rdev->flags)
-		    && !test_bit(In_sync, &tmp->rdev->flags)) {
+		    && !test_and_set_bit(In_sync, &tmp->rdev->flags)) {
+			unsigned long flags;
+			spin_lock_irqsave(&conf->device_lock, flags);
 			mddev->degraded--;
-			set_bit(In_sync, &tmp->rdev->flags);
+			spin_unlock_irqrestore(&conf->device_lock, flags);
 		}
 	}
 
@@ -2034,7 +2038,7 @@ static int raid1_reshape(mddev_t *mddev)
 	mirror_info_t *newmirrors;
 	conf_t *conf = mddev_to_conf(mddev);
 	int cnt, raid_disks;
-
+	unsigned long flags;
 	int d, d2;
 
 	/* Cannot change chunk_size, layout, or level */
@@ -2093,7 +2097,9 @@ static int raid1_reshape(mddev_t *mddev)
 	kfree(conf->poolinfo);
 	conf->poolinfo = newpoolinfo;
 
+	spin_lock_irqsave(&conf->device_lock, flags);
 	mddev->degraded += (raid_disks - conf->raid_disks);
+	spin_unlock_irqrestore(&conf->device_lock, flags);
 	conf->raid_disks = mddev->raid_disks = raid_disks;
 	mddev->delta_disks = 0;
 

diff .prev/drivers/md/raid10.c ./drivers/md/raid10.c
--- .prev/drivers/md/raid10.c	2006-07-31 17:24:35.000000000 +1000
+++ ./drivers/md/raid10.c	2006-07-31 17:24:36.000000000 +1000
@@ -950,14 +950,16 @@ static void error(mddev_t *mddev, mdk_rd
 		 * really dead" tests...
 		 */
 		return;
-	if (test_bit(In_sync, &rdev->flags)) {
+	if (test_and_clear_bit(In_sync, &rdev->flags)) {
+		unsigned long flags;
+		spin_lock_irqsave(&conf->device_lock, flags);
 		mddev->degraded++;
+		spin_unlock_irqrestore(&conf->device_lock, flags);
 		/*
 		 * if recovery is running, make sure it aborts.
 		 */
 		set_bit(MD_RECOVERY_ERR, &mddev->recovery);
 	}
-	clear_bit(In_sync, &rdev->flags);
 	set_bit(Faulty, &rdev->flags);
 	set_bit(MD_CHANGE_DEVS, &mddev->flags);
 	printk(KERN_ALERT "raid10: Disk failure on %s, disabling device. \n"
@@ -1033,9 +1035,11 @@ static int raid10_spare_active(mddev_t *
 		tmp = conf->mirrors + i;
 		if (tmp->rdev
 		    && !test_bit(Faulty, &tmp->rdev->flags)
-		    && !test_bit(In_sync, &tmp->rdev->flags)) {
+		    && !test_and_set_bit(In_sync, &tmp->rdev->flags)) {
+			unsigned long flags;
+			spin_lock_irqsave(&conf->device_lock, flags);
 			mddev->degraded--;
-			set_bit(In_sync, &tmp->rdev->flags);
+			spin_unlock_irqrestore(&conf->device_lock, flags);
 		}
 	}
 

diff .prev/drivers/md/raid5.c ./drivers/md/raid5.c
--- .prev/drivers/md/raid5.c	2006-07-31 17:24:35.000000000 +1000
+++ ./drivers/md/raid5.c	2006-07-31 17:24:36.000000000 +1000
@@ -636,7 +636,6 @@ static int raid5_end_write_request (stru
  	struct stripe_head *sh = bi->bi_private;
 	raid5_conf_t *conf = sh->raid_conf;
 	int disks = sh->disks, i;
-	unsigned long flags;
 	int uptodate = test_bit(BIO_UPTODATE, &bi->bi_flags);
 
 	if (bi->bi_size)
@@ -654,7 +653,6 @@ static int raid5_end_write_request (stru
 		return 0;
 	}
 
-	spin_lock_irqsave(&conf->device_lock, flags);
 	if (!uptodate)
 		md_error(conf->mddev, conf->disks[i].rdev);
 
@@ -662,8 +660,7 @@ static int raid5_end_write_request (stru
 	
 	clear_bit(R5_LOCKED, &sh->dev[i].flags);
 	set_bit(STRIPE_HANDLE, &sh->state);
-	__release_stripe(conf, sh);
-	spin_unlock_irqrestore(&conf->device_lock, flags);
+	release_stripe(sh);
 	return 0;
 }
 
@@ -697,9 +694,11 @@ static void error(mddev_t *mddev, mdk_rd
 
 	if (!test_bit(Faulty, &rdev->flags)) {
 		set_bit(MD_CHANGE_DEVS, &mddev->flags);
-		if (test_bit(In_sync, &rdev->flags)) {
+		if (test_and_clear_bit(In_sync, &rdev->flags)) {
+			unsigned long flags;
+			spin_lock_irqsave(&conf->device_lock, flags);
 			mddev->degraded++;
-			clear_bit(In_sync, &rdev->flags);
+			spin_unlock_irqrestore(&conf->device_lock, flags);
 			/*
 			 * if recovery was running, make sure it aborts.
 			 */
@@ -3419,9 +3418,11 @@ static int raid5_spare_active(mddev_t *m
 		tmp = conf->disks + i;
 		if (tmp->rdev
 		    && !test_bit(Faulty, &tmp->rdev->flags)
-		    && !test_bit(In_sync, &tmp->rdev->flags)) {
+		    && !test_and_set_bit(In_sync, &tmp->rdev->flags)) {
+			unsigned long flags;
+			spin_lock_irqsave(&conf->device_lock, flags);
 			mddev->degraded--;
-			set_bit(In_sync, &tmp->rdev->flags);
+			spin_unlock_irqrestore(&conf->device_lock, flags);
 		}
 	}
 	print_raid5_conf(conf);
@@ -3557,6 +3558,7 @@ static int raid5_start_reshape(mddev_t *
 	struct list_head *rtmp;
 	int spares = 0;
 	int added_devices = 0;
+	unsigned long flags;
 
 	if (mddev->degraded ||
 	    test_bit(MD_RECOVERY_RUNNING, &mddev->recovery))
@@ -3598,7 +3600,9 @@ static int raid5_start_reshape(mddev_t *
 				break;
 		}
 
+	spin_lock_irqsave(&conf->device_lock, flags);
 	mddev->degraded = (conf->raid_disks - conf->previous_raid_disks) - added_devices;
+	spin_unlock_irqrestore(&conf->device_lock, flags);
 	mddev->raid_disks = conf->raid_disks;
 	mddev->reshape_position = 0;
 	set_bit(MD_CHANGE_DEVS, &mddev->flags);
