Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751247AbWAQG4j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751247AbWAQG4j (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 01:56:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751244AbWAQG4j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 01:56:39 -0500
Received: from ns1.suse.de ([195.135.220.2]:61868 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751237AbWAQG4h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 01:56:37 -0500
From: NeilBrown <neilb@suse.de>
To: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 17 Jan 2006 17:56:30 +1100
Message-Id: <1060117065630.27869@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: "Steinar H. Gunderson" <sgunderson@bigfoot.com>
Subject: [PATCH 004 of 5] md: Core of raid5 resize process
References: <20060117174531.27739.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch provides the core of the resize/expand process.

sync_request notices if a 'reshape' is happening and acts accordingly.

It allocated new stripe_heads for the next chunk-wide-stripe in the
target geometry, marking them STRIPE_EXPANDING.
Then it finds which stripe heads in the old geometry can provide data
needed by these and marks them STRIPE_EXPAND_SOURCE.  This causes
stripe_handle to read all blocks on those stripes.
Once all blocks on a STRIPE_EXPAND_SOURCE stripe_head are read, and that
are needed are copied into the corresponding STRIPE_EXPANDING stripe_head.
Once a STRIPE_EXPANDING stripe_head is full, it is marks STRIPE_EXPAND_READY
and then is  written out and released.


Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./drivers/md/raid5.c         |  189 +++++++++++++++++++++++++++++++++++++------
 ./include/linux/raid/md_k.h  |    4 
 ./include/linux/raid/raid5.h |    4 
 3 files changed, 173 insertions(+), 24 deletions(-)

diff ./drivers/md/raid5.c~current~ ./drivers/md/raid5.c
--- ./drivers/md/raid5.c~current~	2006-01-17 17:35:36.000000000 +1100
+++ ./drivers/md/raid5.c	2006-01-17 17:38:47.000000000 +1100
@@ -93,11 +93,13 @@ static void __release_stripe(raid5_conf_
 				if (atomic_read(&conf->preread_active_stripes) < IO_THRESHOLD)
 					md_wakeup_thread(conf->mddev->thread);
 			}
-			list_add_tail(&sh->lru, &conf->inactive_list);
 			atomic_dec(&conf->active_stripes);
-			if (!conf->inactive_blocked ||
-			    atomic_read(&conf->active_stripes) < (conf->max_nr_stripes*3/4))
-				wake_up(&conf->wait_for_stripe);
+			if (!test_bit(STRIPE_EXPANDING, &sh->state)) {
+				list_add_tail(&sh->lru, &conf->inactive_list);
+				if (!conf->inactive_blocked ||
+				    atomic_read(&conf->active_stripes) < (conf->max_nr_stripes*3/4))
+					wake_up(&conf->wait_for_stripe);
+			}
 		}
 	}
 }
@@ -273,9 +275,8 @@ static struct stripe_head *get_active_st
 			} else {
 				if (!test_bit(STRIPE_HANDLE, &sh->state))
 					atomic_inc(&conf->active_stripes);
-				if (list_empty(&sh->lru))
-					BUG();
-				list_del_init(&sh->lru);
+				if (!list_empty(&sh->lru))
+					list_del_init(&sh->lru);
 			}
 		}
 	} while (sh == NULL);
@@ -1019,6 +1020,18 @@ static int add_stripe_bio(struct stripe_
 	return 0;
 }
 
+int stripe_to_pdidx(sector_t stripe, raid5_conf_t *conf, int disks)
+{
+	int sectors_per_chunk = conf->chunk_size >> 9;
+	sector_t x = stripe;
+	int pd_idx, dd_idx;
+	int chunk_offset = sector_div(x, sectors_per_chunk);
+	stripe = x;
+	raid5_compute_sector(stripe*(disks-1)*sectors_per_chunk
+			     + chunk_offset, disks, disks-1, &dd_idx, &pd_idx, conf);
+	return pd_idx;
+}
+
 
 /*
  * handle_stripe - do things to a stripe.
@@ -1045,7 +1058,7 @@ static void handle_stripe(struct stripe_
 	struct bio *return_bi= NULL;
 	struct bio *bi;
 	int i;
-	int syncing;
+	int syncing, expanding, expanded;
 	int locked=0, uptodate=0, to_read=0, to_write=0, failed=0, written=0;
 	int non_overwrite = 0;
 	int failed_num=0;
@@ -1060,6 +1073,8 @@ static void handle_stripe(struct stripe_
 	clear_bit(STRIPE_DELAYED, &sh->state);
 
 	syncing = test_bit(STRIPE_SYNCING, &sh->state);
+	expanding = test_bit(STRIPE_EXPAND_SOURCE, &sh->state);
+	expanded = test_bit(STRIPE_EXPAND_READY, &sh->state);
 	/* Now to look around and see what can be done */
 
 	rcu_read_lock();
@@ -1252,13 +1267,14 @@ static void handle_stripe(struct stripe_
 	 * parity, or to satisfy requests
 	 * or to load a block that is being partially written.
 	 */
-	if (to_read || non_overwrite || (syncing && (uptodate < disks))) {
+	if (to_read || non_overwrite || (syncing && (uptodate < disks)) || expanding) {
 		for (i=disks; i--;) {
 			dev = &sh->dev[i];
 			if (!test_bit(R5_LOCKED, &dev->flags) && !test_bit(R5_UPTODATE, &dev->flags) &&
 			    (dev->toread ||
 			     (dev->towrite && !test_bit(R5_OVERWRITE, &dev->flags)) ||
 			     syncing ||
+			     expanding ||
 			     (failed && (sh->dev[failed_num].toread ||
 					 (sh->dev[failed_num].towrite && !test_bit(R5_OVERWRITE, &sh->dev[failed_num].flags))))
 				    )
@@ -1448,13 +1464,76 @@ static void handle_stripe(struct stripe_
 			set_bit(R5_Wantwrite, &dev->flags);
 			set_bit(R5_ReWrite, &dev->flags);
 			set_bit(R5_LOCKED, &dev->flags);
+			locked++;
 		} else {
 			/* let's read it back */
 			set_bit(R5_Wantread, &dev->flags);
 			set_bit(R5_LOCKED, &dev->flags);
+			locked++;
 		}
 	}
 
+	if (expanded) {
+		/* Need to write out all blocks after computing parity */
+		sh->disks = conf->raid_disks;
+		sh->pd_idx = stripe_to_pdidx(sh->sector, conf, conf->raid_disks);
+		compute_parity(sh, RECONSTRUCT_WRITE);
+		for (i= conf->raid_disks; i--;) {
+			set_bit(R5_LOCKED, &sh->dev[i].flags);
+			locked++;
+			set_bit(R5_Wantwrite, &sh->dev[i].flags);
+		}
+		clear_bit(STRIPE_EXPAND_READY, &sh->state);
+		clear_bit(STRIPE_EXPANDING, &sh->state);
+		wake_up(&conf->wait_for_overlap);
+		/* FIXME this shouldn't be called until the writes complete */
+		md_done_sync(conf->mddev, STRIPE_SECTORS, 1);
+	}
+
+	if (expanding && locked == 0) {
+		/* We have read all the blocks in this stripe and now we need to
+		 * copy some of them into a target stripe for expand.
+		 */
+		clear_bit(STRIPE_EXPAND_SOURCE, &sh->state);
+		for (i=0; i< sh->disks; i++)
+			if (i != sh->pd_idx) {
+				int dd_idx, pd_idx, j;
+				struct stripe_head *sh2;
+
+				sector_t bn = compute_blocknr(sh, i);
+				sector_t s = raid5_compute_sector(bn, conf->raid_disks,
+								  conf->raid_disks-1,
+								  &dd_idx, &pd_idx, conf);
+				sh2 = get_active_stripe(conf, s, conf->raid_disks, pd_idx, 1);
+				if (sh2 == NULL)
+					/* so far only the early blocks of this stripe
+					 * have been requested.  When later blocks
+					 * get requested, we will try again
+					 */
+					continue;
+				if(!test_bit(STRIPE_EXPANDING, &sh2->state) ||
+				   test_bit(R5_Expanded, &sh2->dev[dd_idx].flags)) {
+					/* must have already done this block */
+					release_stripe(sh2);
+					continue;
+				}
+				memcpy(page_address(sh2->dev[dd_idx].page),
+				       page_address(sh->dev[i].page),
+				       STRIPE_SIZE);
+				set_bit(R5_Expanded, &sh2->dev[dd_idx].flags);
+				set_bit(R5_UPTODATE, &sh2->dev[dd_idx].flags);
+				for (j=0; j<conf->raid_disks; j++)
+					if (j != sh2->pd_idx &&
+					    !test_bit(R5_Expanded, &sh2->dev[j].flags))
+						break;
+				if (j == conf->raid_disks) {
+					set_bit(STRIPE_EXPAND_READY, &sh2->state);
+					set_bit(STRIPE_HANDLE, &sh2->state);
+				}
+				release_stripe(sh2);
+			}
+	}
+
 	spin_unlock(&sh->lock);
 
 	while ((bi=return_bi)) {
@@ -1493,7 +1572,7 @@ static void handle_stripe(struct stripe_
 		rcu_read_unlock();
  
 		if (rdev) {
-			if (syncing)
+			if (syncing || expanding || expanded)
 				md_sync_acct(rdev->bdev, STRIPE_SECTORS);
 
 			bi->bi_bdev = rdev->bdev;
@@ -1724,12 +1803,8 @@ static sector_t sync_request(mddev_t *md
 {
 	raid5_conf_t *conf = (raid5_conf_t *) mddev->private;
 	struct stripe_head *sh;
-	int sectors_per_chunk = conf->chunk_size >> 9;
-	sector_t x;
-	unsigned long stripe;
-	int chunk_offset;
-	int dd_idx, pd_idx;
-	sector_t first_sector;
+	int pd_idx;
+	sector_t first_sector, last_sector;
 	int raid_disks = conf->raid_disks;
 	int data_disks = raid_disks-1;
 	sector_t max_sector = mddev->size << 1;
@@ -1748,6 +1823,80 @@ static sector_t sync_request(mddev_t *md
 
 		return 0;
 	}
+
+	if (test_bit(MD_RECOVERY_RESHAPE, &mddev->recovery)) {
+		/* reshaping is quite different to recovery/resync so it is
+		 * handled quite separately ... here.
+		 *
+		 * On each call to sync_request, we gather one chunk worth of
+		 * destination stripes and flag them as expanding.
+		 * Then we find all the source stripes and request reads.
+		 * As the reads complete, handle_stripe will copy the data
+		 * into the destination stripe and release that stripe.
+		 */
+		int i;
+		int dd_idx;
+		for (i=0; i < conf->chunk_size/512; i+= STRIPE_SECTORS) {
+			int j;
+			int skipped = 0;
+			pd_idx = stripe_to_pdidx(sector_nr+i, conf, conf->raid_disks);
+			sh = get_active_stripe(conf, sector_nr+i,
+					       conf->raid_disks, pd_idx, 0);
+			set_bit(STRIPE_EXPANDING, &sh->state);
+			/* If any of this stripe is beyond the end of the old
+			 * array, then we need to zero those blocks
+			 */
+			for (j=sh->disks; j--;) {
+				sector_t s;
+				if (j == sh->pd_idx)
+					continue;
+				s = compute_blocknr(sh, j);
+				if (s < (mddev->array_size<<1)) {
+					skipped = 1;
+					continue;
+				}
+				memset(page_address(sh->dev[j].page), 0, STRIPE_SIZE);
+				set_bit(R5_Expanded, &sh->dev[j].flags);
+				set_bit(R5_UPTODATE, &sh->dev[j].flags);
+			}
+			if (!skipped) {
+				set_bit(STRIPE_EXPAND_READY, &sh->state);
+				set_bit(STRIPE_HANDLE, &sh->state);
+			}
+			release_stripe(sh);
+		}
+		spin_lock_irq(&conf->device_lock);
+		conf->expand_progress = (sector_nr + i)*(conf->raid_disks-1);
+		spin_unlock_irq(&conf->device_lock);
+		/* Ok, those stripe are ready. We can start scheduling
+		 * reads on the source stripes.
+		 * The source stripes are determined by mapping the first and last
+		 * block on the destination stripes.
+		 */
+		raid_disks = conf->previous_raid_disks;
+		data_disks = raid_disks - 1;
+		first_sector =
+			raid5_compute_sector(sector_nr*(conf->raid_disks-1),
+					     raid_disks, data_disks,
+					     &dd_idx, &pd_idx, conf);
+		last_sector =
+			raid5_compute_sector((sector_nr+conf->chunk_size/512)
+					       *(conf->raid_disks-1) -1,
+					     raid_disks, data_disks,
+					     &dd_idx, &pd_idx, conf);
+		if (last_sector >= (mddev->size<<1))
+			last_sector = (mddev->size<<1)-1;
+		while (first_sector <= last_sector) {
+			pd_idx = stripe_to_pdidx(first_sector, conf, conf->previous_raid_disks);
+			sh = get_active_stripe(conf, first_sector,
+					       conf->previous_raid_disks, pd_idx, 0);
+			set_bit(STRIPE_EXPAND_SOURCE, &sh->state);
+			set_bit(STRIPE_HANDLE, &sh->state);
+			release_stripe(sh);
+			first_sector += STRIPE_SECTORS;
+		}
+		return conf->chunk_size>>9;
+	}
 	/* if there is 1 or more failed drives and we are trying
 	 * to resync, then assert that we are finished, because there is
 	 * nothing we can do.
@@ -1766,13 +1915,7 @@ static sector_t sync_request(mddev_t *md
 		return sync_blocks * STRIPE_SECTORS; /* keep things rounded to whole stripes */
 	}
 
-	x = sector_nr;
-	chunk_offset = sector_div(x, sectors_per_chunk);
-	stripe = x;
-	BUG_ON(x != stripe);
-
-	first_sector = raid5_compute_sector((sector_t)stripe*data_disks*sectors_per_chunk
-		+ chunk_offset, raid_disks, data_disks, &dd_idx, &pd_idx, conf);
+	pd_idx = stripe_to_pdidx(sector_nr, conf, raid_disks);
 	sh = get_active_stripe(conf, sector_nr, raid_disks, pd_idx, 1);
 	if (sh == NULL) {
 		sh = get_active_stripe(conf, sector_nr, raid_disks, pd_idx, 0);

diff ./include/linux/raid/md_k.h~current~ ./include/linux/raid/md_k.h
--- ./include/linux/raid/md_k.h~current~	2006-01-17 17:33:05.000000000 +1100
+++ ./include/linux/raid/md_k.h	2006-01-17 17:38:47.000000000 +1100
@@ -157,6 +157,9 @@ struct mddev_s
 	 * DONE:     thread is done and is waiting to be reaped
 	 * REQUEST:  user-space has requested a sync (used with SYNC)
 	 * CHECK:    user-space request for for check-only, no repair
+	 * RESHAPE:  A reshape is happening
+	 *
+	 * If neither SYNC or RESHAPE are set, then it is a recovery.
 	 */
 #define	MD_RECOVERY_RUNNING	0
 #define	MD_RECOVERY_SYNC	1
@@ -166,6 +169,7 @@ struct mddev_s
 #define	MD_RECOVERY_NEEDED	5
 #define	MD_RECOVERY_REQUESTED	6
 #define	MD_RECOVERY_CHECK	7
+#define MD_RECOVERY_RESHAPE	8
 	unsigned long			recovery;
 
 	int				in_sync;	/* know to not need resync */

diff ./include/linux/raid/raid5.h~current~ ./include/linux/raid/raid5.h
--- ./include/linux/raid/raid5.h~current~	2006-01-17 17:35:36.000000000 +1100
+++ ./include/linux/raid/raid5.h	2006-01-17 17:38:47.000000000 +1100
@@ -157,6 +157,7 @@ struct stripe_head {
 #define	R5_ReadError	8	/* seen a read error here recently */
 #define	R5_ReWrite	9	/* have tried to over-write the readerror */
 
+#define	R5_Expanded	10	/* This block now has post-expand data */
 /*
  * Write method
  */
@@ -176,7 +177,8 @@ struct stripe_head {
 #define	STRIPE_DEGRADED		7
 #define	STRIPE_BIT_DELAY	8
 #define	STRIPE_EXPANDING	9
-
+#define	STRIPE_EXPAND_SOURCE	10
+#define	STRIPE_EXPAND_READY	11
 /*
  * Plugging:
  *
