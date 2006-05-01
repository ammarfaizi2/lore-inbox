Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751250AbWEAFcj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751250AbWEAFcj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 01:32:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750872AbWEAFcC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 01:32:02 -0400
Received: from ns.suse.de ([195.135.220.2]:21162 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750953AbWEAFbL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 01:31:11 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Mon, 1 May 2006 15:31:05 +1000
Message-Id: <1060501053105.23033@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 011 of 11] md: Split reshape portion of raid5 sync_request into a separate function.
References: <20060501152229.18367.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


... as raid5 sync_request is WAY too big.

Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./drivers/md/raid5.c |  244 ++++++++++++++++++++++++++-------------------------
 1 file changed, 127 insertions(+), 117 deletions(-)

diff ./drivers/md/raid5.c~current~ ./drivers/md/raid5.c
--- ./drivers/md/raid5.c~current~	2006-05-01 15:12:34.000000000 +1000
+++ ./drivers/md/raid5.c	2006-05-01 15:13:41.000000000 +1000
@@ -2696,13 +2696,136 @@ static int make_request(request_queue_t 
 	return 0;
 }
 
-/* FIXME go_faster isn't used */
-static sector_t sync_request(mddev_t *mddev, sector_t sector_nr, int *skipped, int go_faster)
+static sector_t reshape_request(mddev_t *mddev, sector_t sector_nr, int *skipped)
 {
+	/* reshaping is quite different to recovery/resync so it is
+	 * handled quite separately ... here.
+	 *
+	 * On each call to sync_request, we gather one chunk worth of
+	 * destination stripes and flag them as expanding.
+	 * Then we find all the source stripes and request reads.
+	 * As the reads complete, handle_stripe will copy the data
+	 * into the destination stripe and release that stripe.
+	 */
 	raid5_conf_t *conf = (raid5_conf_t *) mddev->private;
 	struct stripe_head *sh;
 	int pd_idx;
 	sector_t first_sector, last_sector;
+	int raid_disks;
+	int data_disks;
+	int i;
+	int dd_idx;
+	sector_t writepos, safepos, gap;
+
+	if (sector_nr == 0 &&
+	    conf->expand_progress != 0) {
+		/* restarting in the middle, skip the initial sectors */
+		sector_nr = conf->expand_progress;
+		sector_div(sector_nr, conf->raid_disks-1);
+		*skipped = 1;
+		return sector_nr;
+	}
+
+	/* we update the metadata when there is more than 3Meg
+	 * in the block range (that is rather arbitrary, should
+	 * probably be time based) or when the data about to be
+	 * copied would over-write the source of the data at
+	 * the front of the range.
+	 * i.e. one new_stripe forward from expand_progress new_maps
+	 * to after where expand_lo old_maps to
+	 */
+	writepos = conf->expand_progress +
+		conf->chunk_size/512*(conf->raid_disks-1);
+	sector_div(writepos, conf->raid_disks-1);
+	safepos = conf->expand_lo;
+	sector_div(safepos, conf->previous_raid_disks-1);
+	gap = conf->expand_progress - conf->expand_lo;
+
+	if (writepos >= safepos ||
+	    gap > (conf->raid_disks-1)*3000*2 /*3Meg*/) {
+		/* Cannot proceed until we've updated the superblock... */
+		wait_event(conf->wait_for_overlap,
+			   atomic_read(&conf->reshape_stripes)==0);
+		mddev->reshape_position = conf->expand_progress;
+		mddev->sb_dirty = 1;
+		md_wakeup_thread(mddev->thread);
+		wait_event(mddev->sb_wait, mddev->sb_dirty == 0 ||
+			   kthread_should_stop());
+		spin_lock_irq(&conf->device_lock);
+		conf->expand_lo = mddev->reshape_position;
+		spin_unlock_irq(&conf->device_lock);
+		wake_up(&conf->wait_for_overlap);
+	}
+
+	for (i=0; i < conf->chunk_size/512; i+= STRIPE_SECTORS) {
+		int j;
+		int skipped = 0;
+		pd_idx = stripe_to_pdidx(sector_nr+i, conf, conf->raid_disks);
+		sh = get_active_stripe(conf, sector_nr+i,
+				       conf->raid_disks, pd_idx, 0);
+		set_bit(STRIPE_EXPANDING, &sh->state);
+		atomic_inc(&conf->reshape_stripes);
+		/* If any of this stripe is beyond the end of the old
+		 * array, then we need to zero those blocks
+		 */
+		for (j=sh->disks; j--;) {
+			sector_t s;
+			if (j == sh->pd_idx)
+				continue;
+			s = compute_blocknr(sh, j);
+			if (s < (mddev->array_size<<1)) {
+				skipped = 1;
+				continue;
+			}
+			memset(page_address(sh->dev[j].page), 0, STRIPE_SIZE);
+			set_bit(R5_Expanded, &sh->dev[j].flags);
+			set_bit(R5_UPTODATE, &sh->dev[j].flags);
+		}
+		if (!skipped) {
+			set_bit(STRIPE_EXPAND_READY, &sh->state);
+			set_bit(STRIPE_HANDLE, &sh->state);
+		}
+		release_stripe(sh);
+	}
+	spin_lock_irq(&conf->device_lock);
+	conf->expand_progress = (sector_nr + i)*(conf->raid_disks-1);
+	spin_unlock_irq(&conf->device_lock);
+	/* Ok, those stripe are ready. We can start scheduling
+	 * reads on the source stripes.
+	 * The source stripes are determined by mapping the first and last
+	 * block on the destination stripes.
+	 */
+	raid_disks = conf->previous_raid_disks;
+	data_disks = raid_disks - 1;
+	first_sector =
+		raid5_compute_sector(sector_nr*(conf->raid_disks-1),
+				     raid_disks, data_disks,
+				     &dd_idx, &pd_idx, conf);
+	last_sector =
+		raid5_compute_sector((sector_nr+conf->chunk_size/512)
+				     *(conf->raid_disks-1) -1,
+				     raid_disks, data_disks,
+				     &dd_idx, &pd_idx, conf);
+	if (last_sector >= (mddev->size<<1))
+		last_sector = (mddev->size<<1)-1;
+	while (first_sector <= last_sector) {
+		pd_idx = stripe_to_pdidx(first_sector, conf, conf->previous_raid_disks);
+		sh = get_active_stripe(conf, first_sector,
+				       conf->previous_raid_disks, pd_idx, 0);
+		set_bit(STRIPE_EXPAND_SOURCE, &sh->state);
+		set_bit(STRIPE_HANDLE, &sh->state);
+		release_stripe(sh);
+		first_sector += STRIPE_SECTORS;
+	}
+	return conf->chunk_size>>9;
+}
+
+/* FIXME go_faster isn't used */
+static inline sector_t sync_request(mddev_t *mddev, sector_t sector_nr, int *skipped, int go_faster)
+{
+	raid5_conf_t *conf = (raid5_conf_t *) mddev->private;
+	struct stripe_head *sh;
+	int pd_idx;
 	int raid_disks = conf->raid_disks;
 	int data_disks = raid_disks - conf->max_degraded;
 	sector_t max_sector = mddev->size << 1;
@@ -2728,122 +2851,9 @@ static sector_t sync_request(mddev_t *md
 		return 0;
 	}
 
-	if (test_bit(MD_RECOVERY_RESHAPE, &mddev->recovery)) {
-		/* reshaping is quite different to recovery/resync so it is
-		 * handled quite separately ... here.
-		 *
-		 * On each call to sync_request, we gather one chunk worth of
-		 * destination stripes and flag them as expanding.
-		 * Then we find all the source stripes and request reads.
-		 * As the reads complete, handle_stripe will copy the data
-		 * into the destination stripe and release that stripe.
-		 */
-		int i;
-		int dd_idx;
-		sector_t writepos, safepos, gap;
-
-		if (sector_nr == 0 &&
-		    conf->expand_progress != 0) {
-			/* restarting in the middle, skip the initial sectors */
-			sector_nr = conf->expand_progress;
-			sector_div(sector_nr, conf->raid_disks-1);
-			*skipped = 1;
-			return sector_nr;
-		}
+	if (test_bit(MD_RECOVERY_RESHAPE, &mddev->recovery))
+		return reshape_request(mddev, sector_nr, skipped);
 
-		/* we update the metadata when there is more than 3Meg
-		 * in the block range (that is rather arbitrary, should
-		 * probably be time based) or when the data about to be
-		 * copied would over-write the source of the data at
-		 * the front of the range.
-		 * i.e. one new_stripe forward from expand_progress new_maps
-		 * to after where expand_lo old_maps to
-		 */
-		writepos = conf->expand_progress +
-			conf->chunk_size/512*(conf->raid_disks-1);
-		sector_div(writepos, conf->raid_disks-1);
-		safepos = conf->expand_lo;
-		sector_div(safepos, conf->previous_raid_disks-1);
-		gap = conf->expand_progress - conf->expand_lo;
-
-		if (writepos >= safepos ||
-		    gap > (conf->raid_disks-1)*3000*2 /*3Meg*/) {
-			/* Cannot proceed until we've updated the superblock... */
-			wait_event(conf->wait_for_overlap,
-				   atomic_read(&conf->reshape_stripes)==0);
-			mddev->reshape_position = conf->expand_progress;
-			mddev->sb_dirty = 1;
-			md_wakeup_thread(mddev->thread);
-			wait_event(mddev->sb_wait, mddev->sb_dirty == 0 ||
-				   kthread_should_stop());
-			spin_lock_irq(&conf->device_lock);
-			conf->expand_lo = mddev->reshape_position;
-			spin_unlock_irq(&conf->device_lock);
-			wake_up(&conf->wait_for_overlap);
-		}
-
-		for (i=0; i < conf->chunk_size/512; i+= STRIPE_SECTORS) {
-			int j;
-			int skipped = 0;
-			pd_idx = stripe_to_pdidx(sector_nr+i, conf, conf->raid_disks);
-			sh = get_active_stripe(conf, sector_nr+i,
-					       conf->raid_disks, pd_idx, 0);
-			set_bit(STRIPE_EXPANDING, &sh->state);
-			atomic_inc(&conf->reshape_stripes);
-			/* If any of this stripe is beyond the end of the old
-			 * array, then we need to zero those blocks
-			 */
-			for (j=sh->disks; j--;) {
-				sector_t s;
-				if (j == sh->pd_idx)
-					continue;
-				s = compute_blocknr(sh, j);
-				if (s < (mddev->array_size<<1)) {
-					skipped = 1;
-					continue;
-				}
-				memset(page_address(sh->dev[j].page), 0, STRIPE_SIZE);
-				set_bit(R5_Expanded, &sh->dev[j].flags);
-				set_bit(R5_UPTODATE, &sh->dev[j].flags);
-			}
-			if (!skipped) {
-				set_bit(STRIPE_EXPAND_READY, &sh->state);
-				set_bit(STRIPE_HANDLE, &sh->state);
-			}
-			release_stripe(sh);
-		}
-		spin_lock_irq(&conf->device_lock);
-		conf->expand_progress = (sector_nr + i)*(conf->raid_disks-1);
-		spin_unlock_irq(&conf->device_lock);
-		/* Ok, those stripe are ready. We can start scheduling
-		 * reads on the source stripes.
-		 * The source stripes are determined by mapping the first and last
-		 * block on the destination stripes.
-		 */
-		raid_disks = conf->previous_raid_disks;
-		data_disks = raid_disks - 1;
-		first_sector =
-			raid5_compute_sector(sector_nr*(conf->raid_disks-1),
-					     raid_disks, data_disks,
-					     &dd_idx, &pd_idx, conf);
-		last_sector =
-			raid5_compute_sector((sector_nr+conf->chunk_size/512)
-					       *(conf->raid_disks-1) -1,
-					     raid_disks, data_disks,
-					     &dd_idx, &pd_idx, conf);
-		if (last_sector >= (mddev->size<<1))
-			last_sector = (mddev->size<<1)-1;
-		while (first_sector <= last_sector) {
-			pd_idx = stripe_to_pdidx(first_sector, conf, conf->previous_raid_disks);
-			sh = get_active_stripe(conf, first_sector,
-					       conf->previous_raid_disks, pd_idx, 0);
-			set_bit(STRIPE_EXPAND_SOURCE, &sh->state);
-			set_bit(STRIPE_HANDLE, &sh->state);
-			release_stripe(sh);
-			first_sector += STRIPE_SECTORS;
-		}
-		return conf->chunk_size>>9;
-	}
 	/* if there is too many failed drives and we are trying
 	 * to resync, then assert that we are finished, because there is
 	 * nothing we can do.
