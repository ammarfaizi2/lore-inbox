Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422777AbWJaGB6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422777AbWJaGB6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 01:01:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161629AbWJaGBW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 01:01:22 -0500
Received: from ns1.suse.de ([195.135.220.2]:17125 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1161626AbWJaGBO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 01:01:14 -0500
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Tue, 31 Oct 2006 17:01:08 +1100
Message-Id: <1061031060108.5095@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: "Raz Ben-Jehuda(caro)" <raziebe@gmail.com>
Subject: [PATCH 005 of 6] md: Allow reads that have bypassed the cache to be retried on failure.
References: <20061031164814.4884.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


If a bypass-the-cache read fails, we simply try again through
the cache.  If it fails again it will trigger normal recovery
precedures.

cc:  "Raz Ben-Jehuda(caro)" <raziebe@gmail.com>
Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./drivers/md/raid5.c         |  150 ++++++++++++++++++++++++++++++++++++++++++-
 ./include/linux/raid/raid5.h |    3 
 2 files changed, 150 insertions(+), 3 deletions(-)

diff .prev/drivers/md/raid5.c ./drivers/md/raid5.c
--- .prev/drivers/md/raid5.c	2006-10-31 16:41:51.000000000 +1100
+++ ./drivers/md/raid5.c	2006-10-31 16:42:30.000000000 +1100
@@ -134,6 +134,8 @@ static void __release_stripe(raid5_conf_
 			if (!test_bit(STRIPE_EXPANDING, &sh->state)) {
 				list_add_tail(&sh->lru, &conf->inactive_list);
 				wake_up(&conf->wait_for_stripe);
+				if (conf->retry_read_aligned)
+					md_wakeup_thread(conf->mddev->thread);
 			}
 		}
 	}
@@ -2645,18 +2647,74 @@ static int in_chunk_boundary(mddev_t *md
 }
 
 /*
+ *  add bio to the retry LIFO  ( in O(1) ... we are in interrupt )
+ *  later sampled by raid5d.
+ */
+static void add_bio_to_retry(struct bio *bi,raid5_conf_t *conf)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&conf->device_lock, flags);
+
+	bi->bi_next = conf->retry_read_aligned;
+	conf->retry_read_aligned = bi;
+
+	spin_unlock_irqrestore(&conf->device_lock, flags);
+	md_wakeup_thread(conf->mddev->thread);
+}
+
+
+static struct bio *remove_bio_from_retry(raid5_conf_t *conf)
+{
+	struct bio *bi;
+
+	bi = conf->retry_read_aligned;
+	if (bi) {
+		conf->retry_read_aligned = NULL;
+		return bi;
+	}
+	bi = conf->retry_read_aligned_list;
+	if(bi) {
+		conf->retry_read_aligned = bi->bi_next;
+		bi->bi_next = NULL;
+		bi->bi_phys_segments = 1; /* biased count of active stripes */
+		bi->bi_hw_segments = 0; /* count of processed stripes */
+	}
+
+	return bi;
+}
+
+
+/*
  *  The "raid5_align_endio" should check if the read succeeded and if it
  *  did, call bio_endio on the original bio (having bio_put the new bio
  *  first).
  *  If the read failed..
  */
-int raid5_align_endio(struct bio *bi, unsigned int bytes , int error)
+int raid5_align_endio(struct bio *bi, unsigned int bytes, int error)
 {
 	struct bio* raid_bi  = bi->bi_private;
+	mddev_t *mddev;
+	raid5_conf_t *conf;
+
 	if (bi->bi_size)
 		return 1;
 	bio_put(bi);
-	bio_endio(raid_bi, bytes, error);
+
+	mddev = raid_bi->bi_bdev->bd_disk->queue->queuedata;
+	conf = mddev_to_conf(mddev);
+
+	if (!error && test_bit(BIO_UPTODATE, &bi->bi_flags)) {
+		bio_endio(raid_bi, bytes, 0);
+		if (atomic_dec_and_test(&conf->active_aligned_reads))
+			wake_up(&conf->wait_for_stripe);
+		return 0;
+	}
+
+
+	PRINTK("raid5_align_endio : io error...handing IO for a retry\n");
+
+	add_bio_to_retry(raid_bi, conf);
 	return 0;
 }
 
@@ -2702,6 +2760,14 @@ static int chunk_aligned_read(request_qu
 		align_bi->bi_bdev =  rdev->bdev;
 		atomic_inc(&rdev->nr_pending);
 		rcu_read_unlock();
+
+		spin_lock_irq(&conf->device_lock);
+		wait_event_lock_irq(conf->wait_for_stripe,
+				    conf->quiesce == 0,
+				    conf->device_lock, /* nothing */);
+		atomic_inc(&conf->active_aligned_reads);
+		spin_unlock_irq(&conf->device_lock);
+
 		generic_make_request(align_bi);
 		return 1;
 	} else {
@@ -3050,6 +3116,71 @@ static inline sector_t sync_request(mdde
 	return STRIPE_SECTORS;
 }
 
+static int  retry_aligned_read(raid5_conf_t *conf, struct bio *raid_bio)
+{
+	/* We may not be able to submit a whole bio at once as there
+	 * may not be enough stripe_heads available.
+	 * We cannot pre-allocate enough stripe_heads as we may need
+	 * more than exist in the cache (if we allow ever large chunks).
+	 * So we do one stripe head at a time and record in
+	 * ->bi_hw_segments how many have been done.
+	 *
+	 * We *know* that this entire raid_bio is in one chunk, so
+	 * it will be only one 'dd_idx' and only need one call to raid5_compute_sector.
+	 */
+	struct stripe_head *sh;
+	int dd_idx, pd_idx;
+	sector_t sector, logical_sector, last_sector;
+	int scnt = 0;
+	int remaining;
+	int handled = 0;
+
+	logical_sector = raid_bio->bi_sector & ~((sector_t)STRIPE_SECTORS-1);
+	sector = raid5_compute_sector(	logical_sector,
+					conf->raid_disks,
+					conf->raid_disks-1,
+					&dd_idx,
+					&pd_idx,
+					conf);
+	last_sector = raid_bio->bi_sector + (raid_bio->bi_size>>9);
+
+	for (; logical_sector < last_sector; logical_sector += STRIPE_SECTORS) {
+
+		if (scnt < raid_bio->bi_hw_segments)
+			/* already done this stripe */
+			continue;
+
+		sh = get_active_stripe(conf, sector, conf->raid_disks, pd_idx, 1);
+
+		if (!sh) {
+			/* failed to get a stripe - must wait */
+			raid_bio->bi_hw_segments = scnt;
+			conf->retry_read_aligned = raid_bio;
+			return handled;
+		}
+
+		set_bit(R5_ReadError, &sh->dev[dd_idx].flags);
+		add_stripe_bio(sh, raid_bio, dd_idx, 0);
+		handle_stripe(sh, NULL);
+		release_stripe(sh);
+		handled++;
+	}
+	spin_lock_irq(&conf->device_lock);
+	remaining = --raid_bio->bi_phys_segments;
+	spin_unlock_irq(&conf->device_lock);
+	if (remaining == 0) {
+		int bytes = raid_bio->bi_size;
+
+		raid_bio->bi_size = 0;
+		raid_bio->bi_end_io(raid_bio, bytes, 0);
+	}
+	if (atomic_dec_and_test(&conf->active_aligned_reads))
+		wake_up(&conf->wait_for_stripe);
+	return handled;
+}
+
+
+
 /*
  * This is our raid5 kernel thread.
  *
@@ -3071,6 +3202,7 @@ static void raid5d (mddev_t *mddev)
 	spin_lock_irq(&conf->device_lock);
 	while (1) {
 		struct list_head *first;
+		struct bio *bio;
 
 		if (conf->seq_flush != conf->seq_write) {
 			int seq = conf->seq_flush;
@@ -3087,6 +3219,16 @@ static void raid5d (mddev_t *mddev)
 		    !list_empty(&conf->delayed_list))
 			raid5_activate_delayed(conf);
 
+		while ((bio = remove_bio_from_retry(conf))) {
+			int ok;
+			spin_unlock_irq(&conf->device_lock);
+			ok = retry_aligned_read(conf, bio);
+			spin_lock_irq(&conf->device_lock);
+			if (!ok)
+				break;
+			handled++;
+		}
+
 		if (list_empty(&conf->handle_list))
 			break;
 
@@ -3274,6 +3416,7 @@ static int run(mddev_t *mddev)
 	INIT_LIST_HEAD(&conf->inactive_list);
 	atomic_set(&conf->active_stripes, 0);
 	atomic_set(&conf->preread_active_stripes, 0);
+	atomic_set(&conf->active_aligned_reads, 0);
 
 	PRINTK("raid5: run(%s) called.\n", mdname(mddev));
 
@@ -3796,7 +3939,8 @@ static void raid5_quiesce(mddev_t *mddev
 		spin_lock_irq(&conf->device_lock);
 		conf->quiesce = 1;
 		wait_event_lock_irq(conf->wait_for_stripe,
-				    atomic_read(&conf->active_stripes) == 0,
+				    atomic_read(&conf->active_stripes) == 0 &&
+				    atomic_read(&conf->active_aligned_reads) == 0,
 				    conf->device_lock, /* nothing */);
 		spin_unlock_irq(&conf->device_lock);
 		break;

diff .prev/include/linux/raid/raid5.h ./include/linux/raid/raid5.h
--- .prev/include/linux/raid/raid5.h	2006-10-31 16:40:56.000000000 +1100
+++ ./include/linux/raid/raid5.h	2006-10-31 16:42:30.000000000 +1100
@@ -227,7 +227,10 @@ struct raid5_private_data {
 	struct list_head	handle_list; /* stripes needing handling */
 	struct list_head	delayed_list; /* stripes that have plugged requests */
 	struct list_head	bitmap_list; /* stripes delaying awaiting bitmap update */
+	struct bio		*retry_read_aligned; /* currently retrying aligned bios   */
+	struct bio		*retry_read_aligned_list; /* aligned bios retry list  */
 	atomic_t		preread_active_stripes; /* stripes with scheduled io */
+	atomic_t		active_aligned_reads;
 
 	atomic_t		reshape_stripes; /* stripes with pending writes for reshape */
 	/* unfortunately we need two cache names as we temporarily have
