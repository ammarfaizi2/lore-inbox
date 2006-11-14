Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933247AbWKNAWv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933247AbWKNAWv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 19:22:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933245AbWKNAWu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 19:22:50 -0500
Received: from ns1.suse.de ([195.135.220.2]:33945 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S933244AbWKNAWq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 19:22:46 -0500
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Tue, 14 Nov 2006 11:22:41 +1100
Message-Id: <1061114002241.31180@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 003 of 4] md: Misc fixes for aligned-read handling.
References: <20061114111600.31061.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


1/ When aligned requests fail (read error) they need to be retried 
   via the normal method (stripe cache).  As we cannot be sure that
   we can process a single read in one go (we may not be able to
   allocate all the stripes needed) we store a bio-being-retried
   and a list of bioes-that-still-need-to-be-retried.
   When find a bio that needs to be retried, we should add it to 
   the list, not to single-bio...

2/ The cloned bio is being used-after-free (to test BIO_UPTODATE).

3/ We forgot to add rdev->data_offset when submitting
   a bio for aligned-read
4/ clone_bio calls blk_recount_segments and then we change bi_bdev,
   so we need to invalidate the segment counts.

5/ We were never incrementing 'scnt' when resubmitting failed
   aligned requests.

Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./drivers/md/raid5.c |   14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff .prev/drivers/md/raid5.c ./drivers/md/raid5.c
--- .prev/drivers/md/raid5.c	2006-11-14 10:34:17.000000000 +1100
+++ ./drivers/md/raid5.c	2006-11-14 10:34:33.000000000 +1100
@@ -2658,8 +2658,8 @@ static void add_bio_to_retry(struct bio 
 
 	spin_lock_irqsave(&conf->device_lock, flags);
 
-	bi->bi_next = conf->retry_read_aligned;
-	conf->retry_read_aligned = bi;
+	bi->bi_next = conf->retry_read_aligned_list;
+	conf->retry_read_aligned_list = bi;
 
 	spin_unlock_irqrestore(&conf->device_lock, flags);
 	md_wakeup_thread(conf->mddev->thread);
@@ -2698,6 +2698,7 @@ static int raid5_align_endio(struct bio 
 	struct bio* raid_bi  = bi->bi_private;
 	mddev_t *mddev;
 	raid5_conf_t *conf;
+	int uptodate = test_bit(BIO_UPTODATE, &bi->bi_flags);
 
 	if (bi->bi_size)
 		return 1;
@@ -2706,7 +2707,7 @@ static int raid5_align_endio(struct bio 
 	mddev = raid_bi->bi_bdev->bd_disk->queue->queuedata;
 	conf = mddev_to_conf(mddev);
 
-	if (!error && test_bit(BIO_UPTODATE, &bi->bi_flags)) {
+	if (!error && uptodate) {
 		bio_endio(raid_bi, bytes, 0);
 		if (atomic_dec_and_test(&conf->active_aligned_reads))
 			wake_up(&conf->wait_for_stripe);
@@ -2759,9 +2760,11 @@ static int chunk_aligned_read(request_qu
 	rcu_read_lock();
 	rdev = rcu_dereference(conf->disks[dd_idx].rdev);
 	if (rdev && test_bit(In_sync, &rdev->flags)) {
-		align_bi->bi_bdev =  rdev->bdev;
 		atomic_inc(&rdev->nr_pending);
 		rcu_read_unlock();
+		align_bi->bi_bdev =  rdev->bdev;
+		align_bi->bi_flags &= ~(1 << BIO_SEG_VALID);
+		align_bi->bi_sector += rdev->data_offset;
 
 		spin_lock_irq(&conf->device_lock);
 		wait_event_lock_irq(conf->wait_for_stripe,
@@ -3151,7 +3154,8 @@ static int  retry_aligned_read(raid5_con
 					conf);
 	last_sector = raid_bio->bi_sector + (raid_bio->bi_size>>9);
 
-	for (; logical_sector < last_sector; logical_sector += STRIPE_SECTORS) {
+	for (; logical_sector < last_sector;
+	     logical_sector += STRIPE_SECTORS, scnt++) {
 
 		if (scnt < raid_bio->bi_hw_segments)
 			/* already done this stripe */
