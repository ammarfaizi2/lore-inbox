Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030263AbWAXAmv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030263AbWAXAmv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 19:42:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030261AbWAXAmX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 19:42:23 -0500
Received: from ns1.suse.de ([195.135.220.2]:53643 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1030255AbWAXAl2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 19:41:28 -0500
From: NeilBrown <neilb@suse.de>
To: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 24 Jan 2006 11:41:22 +1100
Message-Id: <1060124004122.5107@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Subject: [PATCH 007 of 7] md: Only checkpoint expansion progress occasionally.
References: <20060124112626.4447.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Instead of checkpointing at each stripe, only checkpoint
when a new write would overwrite uncheckpointed data.
Block any write to the uncheckpointed area.
Arbitrarily checkpoint every 3Meg.


Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./drivers/md/raid5.c         |   53 ++++++++++++++++++++++++++++++++++---------
 ./include/linux/raid/raid5.h |    3 ++
 2 files changed, 45 insertions(+), 11 deletions(-)

diff ./drivers/md/raid5.c~current~ ./drivers/md/raid5.c
--- ./drivers/md/raid5.c~current~	2006-01-24 11:19:21.000000000 +1100
+++ ./drivers/md/raid5.c	2006-01-24 11:26:16.000000000 +1100
@@ -1748,8 +1748,9 @@ static int make_request(request_queue_t 
 	for (;logical_sector < last_sector; logical_sector += STRIPE_SECTORS) {
 		DEFINE_WAIT(w);
 		int disks;
-		
+
 	retry:
+		prepare_to_wait(&conf->wait_for_overlap, &w, TASK_UNINTERRUPTIBLE);
 		if (likely(conf->expand_progress == MaxSector))
 			disks = conf->raid_disks;
 		else {
@@ -1757,6 +1758,13 @@ static int make_request(request_queue_t 
 			disks = conf->raid_disks;
 			if (logical_sector >= conf->expand_progress)
 				disks = conf->previous_raid_disks;
+			else {
+				if (logical_sector >= conf->expand_lo) {
+					spin_unlock_irq(&conf->device_lock);
+					schedule();
+					goto retry;
+				}
+			}
 			spin_unlock_irq(&conf->device_lock);
 		}
  		new_sector = raid5_compute_sector(logical_sector, disks, disks - 1,
@@ -1765,7 +1773,6 @@ static int make_request(request_queue_t 
 			(unsigned long long)new_sector, 
 			(unsigned long long)logical_sector);
 
-		prepare_to_wait(&conf->wait_for_overlap, &w, TASK_UNINTERRUPTIBLE);
 		sh = get_active_stripe(conf, new_sector, disks, pd_idx, (bi->bi_rw&RWA_MASK));
 		if (sh) {
 			if (unlikely(conf->expand_progress != MaxSector)) {
@@ -1863,6 +1870,7 @@ static sector_t sync_request(mddev_t *md
 		 */
 		int i;
 		int dd_idx;
+		sector_t writepos, safepos, gap;
 
 		if (sector_nr == 0 &&
 		    conf->expand_progress != 0) {
@@ -1873,15 +1881,36 @@ static sector_t sync_request(mddev_t *md
 			return sector_nr;
 		}
 
-		/* Cannot proceed until we've updated the superblock... */
-		wait_event(conf->wait_for_overlap,
-			   atomic_read(&conf->reshape_stripes)==0);
-		mddev->reshape_position = conf->expand_progress;
-
-		mddev->sb_dirty = 1;
-		md_wakeup_thread(mddev->thread);
-		wait_event(mddev->sb_wait, mddev->sb_dirty == 0 ||
-			kthread_should_stop());
+		/* we update the metadata when there is more than 3Meg
+		 * in the block range (that is rather arbitrary, should
+		 * probably be time based) or when the data about to be
+		 * copied would over-write the source of the data at
+		 * the front of the range.
+		 * i.e. one new_stripe forward from expand_progress new_maps
+		 * to after where expand_lo old_maps to
+		 */
+		writepos = conf->expand_progress +
+			conf->chunk_size/512*(conf->raid_disks-1);
+		sector_div(writepos, conf->raid_disks-1);
+		safepos = conf->expand_lo;
+		sector_div(safepos, conf->previous_raid_disks-1);
+		gap = conf->expand_progress - conf->expand_lo;
+
+		if (writepos >= safepos ||
+		    gap > (conf->raid_disks-1)*3000*2 /*3Meg*/) {
+			/* Cannot proceed until we've updated the superblock... */
+			wait_event(conf->wait_for_overlap,
+				   atomic_read(&conf->reshape_stripes)==0);
+			mddev->reshape_position = conf->expand_progress;
+			mddev->sb_dirty = 1;
+			md_wakeup_thread(mddev->thread);
+			wait_event(mddev->sb_wait, mddev->sb_dirty == 0 ||
+				   kthread_should_stop());
+			spin_lock_irq(&conf->device_lock);
+			conf->expand_lo = mddev->reshape_position;
+			spin_unlock_irq(&conf->device_lock);
+			wake_up(&conf->wait_for_overlap);
+		}
 
 		for (i=0; i < conf->chunk_size/512; i+= STRIPE_SECTORS) {
 			int j;
@@ -2312,6 +2341,7 @@ static int run(mddev_t *mddev)
 
 	if (conf->expand_progress != MaxSector) {
 		printk("...ok start reshape thread\n");
+		conf->expand_lo = conf->expand_progress;
 		atomic_set(&conf->reshape_stripes, 0);
 		clear_bit(MD_RECOVERY_SYNC, &mddev->recovery);
 		clear_bit(MD_RECOVERY_CHECK, &mddev->recovery);
@@ -2599,6 +2629,7 @@ static int raid5_reshape(mddev_t *mddev,
 	conf->previous_raid_disks = conf->raid_disks;
 	conf->raid_disks = raid_disks;
 	conf->expand_progress = 0;
+	conf->expand_lo = 0;
 	spin_unlock_irq(&conf->device_lock);
 
 	/* Add some new drives, as many as will fit.

diff ./include/linux/raid/raid5.h~current~ ./include/linux/raid/raid5.h
--- ./include/linux/raid/raid5.h~current~	2006-01-24 11:19:21.000000000 +1100
+++ ./include/linux/raid/raid5.h	2006-01-24 11:26:16.000000000 +1100
@@ -217,6 +217,9 @@ struct raid5_private_data {
 
 	/* used during an expand */
 	sector_t		expand_progress;	/* MaxSector when no expand happening */
+	sector_t		expand_lo; /* from here up to expand_progress it out-of-bounds
+					    * as we haven't flushed the metadata yet
+					    */
 	int			previous_raid_disks;
 
 	struct list_head	handle_list; /* stripes needing handling */
