Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753482AbWKMJoV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753482AbWKMJoV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 04:44:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754351AbWKMJoV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 04:44:21 -0500
Received: from cantor2.suse.de ([195.135.220.15]:5763 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1753482AbWKMJoE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 04:44:04 -0500
From: Neil Brown <neilb@suse.de>
To: Jurriaan <thunder7@xs4all.nl>, linux-kernel@vger.kernel.org
Date: Mon, 13 Nov 2006 20:43:54 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17752.15962.816035.80638@cse.unsw.edu.au>
Subject: Re: trouble with mounting a 1.5 TB raid6 volume in 2.6.19-rc5-mm1
In-Reply-To: message from Neil Brown on Monday November 13
References: <20061111183835.GA3801@amd64.of.nowhere>
	<17751.64583.924110.954687@cse.unsw.edu.au>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday November 13, neilb@suse.de wrote:
> 
> Can you try reverting this patch (patch -p1 -R) ?
> 

Yes, I'm confident that reverting that patch will fix your problem.
I actually found a number of errors while tracking this down :-(

The following patch makes everything happy for me, but I'll be
revising it and splitting it up before submitting it (Andrew: please
don't just grab it from here :-)

I'd be happy for you to test it, but I understand if you would rather
not.

Thanks again for the report.

NeilBrown



Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./drivers/md/raid5.c |   43 ++++++++++++++++++++++++-------------------
 1 file changed, 24 insertions(+), 19 deletions(-)

diff .prev/drivers/md/raid5.c ./drivers/md/raid5.c
--- .prev/drivers/md/raid5.c	2006-11-13 20:40:52.000000000 +1100
+++ ./drivers/md/raid5.c	2006-11-13 20:41:06.000000000 +1100
@@ -719,7 +719,7 @@ static void error(mddev_t *mddev, mdk_rd
  * Output: index of the data and parity disk, and the sector # in them.
  */
 static sector_t raid5_compute_sector(sector_t r_sector, unsigned int raid_disks,
-			unsigned int data_disks, unsigned int * dd_idx,
+			unsigned int * dd_idx,
 			unsigned int * pd_idx, raid5_conf_t *conf)
 {
 	long stripe;
@@ -727,6 +727,7 @@ static sector_t raid5_compute_sector(sec
 	unsigned int chunk_offset;
 	sector_t new_sector;
 	int sectors_per_chunk = conf->chunk_size >> 9;
+	int data_disks = raid_disks - conf->max_degraded;
 
 	/* First compute the information on this sector */
 
@@ -891,7 +892,8 @@ static sector_t compute_blocknr(struct s
 	chunk_number = stripe * data_disks + i;
 	r_sector = (sector_t)chunk_number * sectors_per_chunk + chunk_offset;
 
-	check = raid5_compute_sector (r_sector, raid_disks, data_disks, &dummy1, &dummy2, conf);
+	check = raid5_compute_sector (r_sector, raid_disks,
+				      &dummy1, &dummy2, conf);
 	if (check != sh->sector || dummy1 != dd_idx || dummy2 != sh->pd_idx) {
 		printk(KERN_ERR "compute_blocknr: map not correct\n");
 		return 0;
@@ -1355,8 +1357,9 @@ static int stripe_to_pdidx(sector_t stri
 	int pd_idx, dd_idx;
 	int chunk_offset = sector_div(stripe, sectors_per_chunk);
 
-	raid5_compute_sector(stripe*(disks-1)*sectors_per_chunk
-			     + chunk_offset, disks, disks-1, &dd_idx, &pd_idx, conf);
+	raid5_compute_sector(stripe*(disks - conf->max_degraded)
+			     *sectors_per_chunk + chunk_offset,
+			     disks, &dd_idx, &pd_idx, conf);
 	return pd_idx;
 }
 
@@ -1827,7 +1830,6 @@ static void handle_stripe5(struct stripe
 
 				sector_t bn = compute_blocknr(sh, i);
 				sector_t s = raid5_compute_sector(bn, conf->raid_disks,
-								  conf->raid_disks-1,
 								  &dd_idx, &pd_idx, conf);
 				sh2 = get_active_stripe(conf, s, conf->raid_disks, pd_idx, 1);
 				if (sh2 == NULL)
@@ -2656,8 +2658,8 @@ static void add_bio_to_retry(struct bio 
 
 	spin_lock_irqsave(&conf->device_lock, flags);
 
-	bi->bi_next = conf->retry_read_aligned;
-	conf->retry_read_aligned = bi;
+	bi->bi_next = conf->retry_read_aligned_list;
+	conf->retry_read_aligned_list = bi;
 
 	spin_unlock_irqrestore(&conf->device_lock, flags);
 	md_wakeup_thread(conf->mddev->thread);
@@ -2696,6 +2698,8 @@ int raid5_align_endio(struct bio *bi, un
 	struct bio* raid_bi  = bi->bi_private;
 	mddev_t *mddev;
 	raid5_conf_t *conf;
+	int dd_idx, pd_idx;
+	int uptodate = test_bit(BIO_UPTODATE, &bi->bi_flags);
 
 	if (bi->bi_size)
 		return 1;
@@ -2704,7 +2708,11 @@ int raid5_align_endio(struct bio *bi, un
 	mddev = raid_bi->bi_bdev->bd_disk->queue->queuedata;
 	conf = mddev_to_conf(mddev);
 
-	if (!error && test_bit(BIO_UPTODATE, &bi->bi_flags)) {
+	raid5_compute_sector(raid_bi->bi_sector, conf->raid_disks,
+			     &dd_idx, &pd_idx, conf);
+	rdev_dec_pending(conf->disks[dd_idx].rdev, conf->mddev);
+
+	if (!error && uptodate) {
 		bio_endio(raid_bi, bytes, 0);
 		if (atomic_dec_and_test(&conf->active_aligned_reads))
 			wake_up(&conf->wait_for_stripe);
@@ -2723,7 +2731,6 @@ static int chunk_aligned_read(request_qu
 	mddev_t *mddev = q->queuedata;
 	raid5_conf_t *conf = mddev_to_conf(mddev);
 	const unsigned int raid_disks = conf->raid_disks;
-	const unsigned int data_disks = raid_disks - 1;
 	unsigned int dd_idx, pd_idx;
 	struct bio* align_bi;
 	mdk_rdev_t *rdev;
@@ -2749,7 +2756,6 @@ static int chunk_aligned_read(request_qu
 	 */
 	align_bi->bi_sector =  raid5_compute_sector(raid_bio->bi_sector,
 					raid_disks,
-					data_disks,
 					&dd_idx,
 					&pd_idx,
 					conf);
@@ -2757,9 +2763,11 @@ static int chunk_aligned_read(request_qu
 	rcu_read_lock();
 	rdev = rcu_dereference(conf->disks[dd_idx].rdev);
 	if (rdev && test_bit(In_sync, &rdev->flags)) {
-		align_bi->bi_bdev =  rdev->bdev;
 		atomic_inc(&rdev->nr_pending);
 		rcu_read_unlock();
+		align_bi->bi_bdev =  rdev->bdev;
+		align_bi->bi_sector += rdev->data_offset;
+		align_bi->bi_flags &= ~(1 << BIO_SEG_VALID);
 
 		spin_lock_irq(&conf->device_lock);
 		wait_event_lock_irq(conf->wait_for_stripe,
@@ -2772,6 +2780,7 @@ static int chunk_aligned_read(request_qu
 		return 1;
 	} else {
 		rcu_read_unlock();
+		bio_put(align_bi);
 		return 0;
 	}
 }
@@ -2810,7 +2819,7 @@ static int make_request(request_queue_t 
 
 	for (;logical_sector < last_sector; logical_sector += STRIPE_SECTORS) {
 		DEFINE_WAIT(w);
-		int disks, data_disks;
+		int disks;
 
 	retry:
 		prepare_to_wait(&conf->wait_for_overlap, &w, TASK_UNINTERRUPTIBLE);
@@ -2838,9 +2847,8 @@ static int make_request(request_queue_t 
 			}
 			spin_unlock_irq(&conf->device_lock);
 		}
-		data_disks = disks - conf->max_degraded;
 
- 		new_sector = raid5_compute_sector(logical_sector, disks, data_disks,
+ 		new_sector = raid5_compute_sector(logical_sector, disks,
 						  &dd_idx, &pd_idx, conf);
 		PRINTK("raid5: make_request, sector %llu logical %llu\n",
 			(unsigned long long)new_sector, 
@@ -2931,7 +2939,6 @@ static sector_t reshape_request(mddev_t 
 	int pd_idx;
 	sector_t first_sector, last_sector;
 	int raid_disks;
-	int data_disks;
 	int i;
 	int dd_idx;
 	sector_t writepos, safepos, gap;
@@ -3015,15 +3022,14 @@ static sector_t reshape_request(mddev_t 
 	 * block on the destination stripes.
 	 */
 	raid_disks = conf->previous_raid_disks;
-	data_disks = raid_disks - 1;
 	first_sector =
 		raid5_compute_sector(sector_nr*(conf->raid_disks-1),
-				     raid_disks, data_disks,
+				     raid_disks,
 				     &dd_idx, &pd_idx, conf);
 	last_sector =
 		raid5_compute_sector((sector_nr+conf->chunk_size/512)
 				     *(conf->raid_disks-1) -1,
-				     raid_disks, data_disks,
+				     raid_disks,
 				     &dd_idx, &pd_idx, conf);
 	if (last_sector >= (mddev->size<<1))
 		last_sector = (mddev->size<<1)-1;
@@ -3143,7 +3149,6 @@ static int  retry_aligned_read(raid5_con
 	logical_sector = raid_bio->bi_sector & ~((sector_t)STRIPE_SECTORS-1);
 	sector = raid5_compute_sector(	logical_sector,
 					conf->raid_disks,
-					conf->raid_disks-1,
 					&dd_idx,
 					&pd_idx,
 					conf);
