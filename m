Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932204AbWH0Xtm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932204AbWH0Xtm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Aug 2006 19:49:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932297AbWH0Xtl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Aug 2006 19:49:41 -0400
Received: from ns1.suse.de ([195.135.220.2]:11922 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932204AbWH0Xtf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Aug 2006 19:49:35 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Mon, 28 Aug 2006 09:49:33 +1000
Message-Id: <1060827234933.32501@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 004 of 4] md: Improve locking around error handling
References: <20060828092849.21292.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: NeilBrown <neilb@suse.de>

The error handling routines don't use proper locking, and so two concurrent
errors could trigger a problem.

So:
  - use test-and-set and test-and-clear to synchonise
    the In_sync bits with the ->degraded count
  - use the spinlock to protect updates to the
    degraded count (could use an atomic_t but that
    would be a bigger change in code, and isn't
    really justified)
  - remove un-necessary locking in raid5

Signed-off-by: Neil Brown <neilb@suse.de>
---

 drivers/md/raid1.c  |   16 +++++++++++-----
 drivers/md/raid10.c |   12 ++++++++----
 drivers/md/raid5.c  |   20 ++++++++++++--------
 3 files changed, 31 insertions(+), 17 deletions(-)

Index: mm-quilt/drivers/md/raid1.c
===================================================================
--- mm-quilt.orig/drivers/md/raid1.c	2006-08-28 09:43:39.000000000 +1000
+++ mm-quilt/drivers/md/raid1.c	2006-08-28 09:43:44.000000000 +1000
@@ -959,14 +959,16 @@ static void error(mddev_t *mddev, mdk_rd
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
@@ -1022,9 +1024,11 @@ static int raid1_spare_active(mddev_t *m
 		mdk_rdev_t *rdev = conf->mirrors[i].rdev;
 		if (rdev
 		    && !test_bit(Faulty, &rdev->flags)
-		    && !test_bit(In_sync, &rdev->flags)) {
+		    && !test_and_set_bit(In_sync, &rdev->flags)) {
+			unsigned long flags;
+			spin_lock_irqsave(&conf->device_lock, flags);
 			mddev->degraded--;
-			set_bit(In_sync, &rdev->flags);
+			spin_unlock_irqrestore(&conf->device_lock, flags);
 		}
 	}
 
@@ -2048,7 +2052,7 @@ static int raid1_reshape(mddev_t *mddev)
 	mirror_info_t *newmirrors;
 	conf_t *conf = mddev_to_conf(mddev);
 	int cnt, raid_disks;
-
+	unsigned long flags;
 	int d, d2;
 
 	/* Cannot change chunk_size, layout, or level */
@@ -2107,7 +2111,9 @@ static int raid1_reshape(mddev_t *mddev)
 	kfree(conf->poolinfo);
 	conf->poolinfo = newpoolinfo;
 
+	spin_lock_irqsave(&conf->device_lock, flags);
 	mddev->degraded += (raid_disks - conf->raid_disks);
+	spin_unlock_irqrestore(&conf->device_lock, flags);
 	conf->raid_disks = mddev->raid_disks = raid_disks;
 	mddev->delta_disks = 0;
 
Index: mm-quilt/drivers/md/raid10.c
===================================================================
--- mm-quilt.orig/drivers/md/raid10.c	2006-08-28 09:43:37.000000000 +1000
+++ mm-quilt/drivers/md/raid10.c	2006-08-28 09:43:44.000000000 +1000
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
 
Index: mm-quilt/drivers/md/raid5.c
===================================================================
--- mm-quilt.orig/drivers/md/raid5.c	2006-08-28 09:43:27.000000000 +1000
+++ mm-quilt/drivers/md/raid5.c	2006-08-28 09:43:44.000000000 +1000
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
