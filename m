Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263605AbUC3LLE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 06:11:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263603AbUC3LLE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 06:11:04 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:17863 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S263602AbUC3LKP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 06:10:15 -0500
Date: Tue, 30 Mar 2004 13:09:28 +0200
From: Jens Axboe <axboe@suse.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Andrea Arcangeli <andrea@suse.de>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       William Lee Irwin III <wli@holomorphy.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, linux-ide@vger.kernel.org,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] speed up SATA
Message-ID: <20040330110928.GR24370@suse.de>
References: <4066021A.20308@pobox.com> <200403282030.11743.bzolnier@elka.pw.edu.pl> <20040328183010.GQ24370@suse.de> <200403282045.07246.bzolnier@elka.pw.edu.pl> <406720A7.1050501@pobox.com> <20040329005502.GG3039@dualathlon.random> <40679FE3.3080007@pobox.com> <20040329130410.GH3039@dualathlon.random> <40687CF0.3040206@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40687CF0.3040206@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 29 2004, Jeff Garzik wrote:
> Andrea Arcangeli wrote:
> >Once you change the API too, then you can set the hardwre limit in your
> >driver and relay on the highlevel blkdev code to find the optimal runtime
> >dma size for bulk I/O, but today it's your driver that is enforcing a
> >runtime bulk dma size, not the maximim limit of the controller, and so
> >you should code your patch accordingly.
> 
> This magic 512k or 1M limit has nothing to do with SATA.  It's a magic 
> number whose definition is "we don't want PATA or SATA or SCSI disks 
> doing larger requests than this for latency, VM, and similar reasons."
> 
> That definition belongs outside the low-level SATA driver.
> 
> This 512k/1M value is sure to change over time, which involves 
> needlessly plugging the same value into multiple places.  And when such 
> changes occurs, you must be careful not to exceed hardware- and 
> errata-based limits -- of which there is no distinction in the code.
> 
> I think the length of this discussion alone clearly implies that the 
> low-level driver should not be responsible for selecting this value, if 
> nothing else ;-)

Here's a quickly done patch that attempts to adjust the value based on a
previous range of completed requests. It changes ->max_sectors to be a
hardware limit, adding ->optimal_sectors to be our max issued io target.
It is split on READ and WRITE. The target is to keep request execution
time under BLK_IORATE_TARGET, which is 50ms in this patch. read-ahead
max window is kept within a single request in size.

So this is pretty half-assed, but it gets the point across. Things that
should be looked at (meaning - should be done, but I didn't want to
waste time on them now):

- I added the hook to see how many in-drive queued requests you have, so
  there's the possibility to add tcq knowledge as well.

- The optimal_sectors calculation is just an average of previous maximum
  with current maximum. The scheme has a number of break down points,
  for instance writes starving reads will give you a bad read execution
  time, further limiting ->optimal_sectors[READ]

- HZ == 1000 is hardcoded

- bdi->ra_pages setting is just best effort, there's no attempt made to
  synchronize this with the issuer. Would require too much effort for
  probably zero real gain.

===== drivers/block/elevator.c 1.53 vs edited =====
--- 1.53/drivers/block/elevator.c	Mon Jan 19 07:38:36 2004
+++ edited/drivers/block/elevator.c	Tue Mar 30 12:59:57 2004
@@ -150,6 +150,15 @@
 void elv_requeue_request(request_queue_t *q, struct request *rq)
 {
 	/*
+	 * it already went through dequeue, we need to decrement the
+	 * in_flight count again
+	 */
+	if (blk_account_rq(rq)) {
+		WARN_ON(q->in_flight == 0);
+		q->in_flight--;
+	}
+
+	/*
 	 * if iosched has an explicit requeue hook, then use that. otherwise
 	 * just put the request at the front of the queue
 	 */
@@ -221,6 +230,9 @@
 		}
 	}
 
+	if (rq)
+		rq->issue_time = jiffies;
+
 	return rq;
 }
 
@@ -229,6 +241,21 @@
 	elevator_t *e = &q->elevator;
 
 	/*
+	 * the time frame between a request being removed from the lists
+	 * and to it is freed is accounted as io that is in progress at
+	 * the driver side. note that we only account requests that the
+	 * driver has seen (REQ_STARTED set), to avoid false accounting
+	 * for request-request merges
+	 */
+	if (blk_account_rq(rq)) {
+		q->in_flight++;
+#if 0
+		q->max_in_flight = max(q->in_flight, q->max_in_flight);
+#endif
+		WARN_ON(q->in_flight > 2 * q->nr_requests);
+	}
+
+	/*
 	 * the main clearing point for q->last_merge is on retrieval of
 	 * request by driver (it calls elv_next_request()), but it _can_
 	 * also happen here if a request is added to the queue but later
@@ -316,6 +343,14 @@
 void elv_completed_request(request_queue_t *q, struct request *rq)
 {
 	elevator_t *e = &q->elevator;
+
+	/*
+	 * request is released from the driver, io must be done
+	 */
+	if (blk_account_rq(rq)) {
+		WARN_ON(q->in_flight == 0);
+		q->in_flight--;
+	}
 
 	if (e->elevator_completed_req_fn)
 		e->elevator_completed_req_fn(q, rq);
===== drivers/block/ll_rw_blk.c 1.237 vs edited =====
--- 1.237/drivers/block/ll_rw_blk.c	Tue Mar 16 11:29:58 2004
+++ edited/drivers/block/ll_rw_blk.c	Tue Mar 30 12:58:51 2004
@@ -313,7 +313,7 @@
  *    Enables a low level driver to set an upper limit on the size of
  *    received requests.
  **/
-void blk_queue_max_sectors(request_queue_t *q, unsigned short max_sectors)
+void blk_queue_max_sectors(request_queue_t *q, unsigned int max_sectors)
 {
 	if ((max_sectors << 9) < PAGE_CACHE_SIZE) {
 		max_sectors = 1 << (PAGE_CACHE_SHIFT - 9);
@@ -321,6 +321,14 @@
 	}
 
 	q->max_sectors = max_sectors;
+
+	/*
+	 * use a max of 1MB as a starting point
+	 */
+	q->optimal_sectors[READ] = max_sectors;
+	if (q->optimal_sectors[READ] > 2048)
+		q->optimal_sectors[READ] = 2048;
+	q->optimal_sectors[WRITE] = q->optimal_sectors[READ];
 }
 
 EXPORT_SYMBOL(blk_queue_max_sectors);
@@ -1018,10 +1026,12 @@
 	return 1;
 }
 
-static int ll_back_merge_fn(request_queue_t *q, struct request *req, 
+static int ll_back_merge_fn(request_queue_t *q, struct request *req,
 			    struct bio *bio)
 {
-	if (req->nr_sectors + bio_sectors(bio) > q->max_sectors) {
+	const int rw = rq_data_dir(req);
+
+	if (req->nr_sectors + bio_sectors(bio) > q->optimal_sectors[rw]) {
 		req->flags |= REQ_NOMERGE;
 		q->last_merge = NULL;
 		return 0;
@@ -1033,10 +1043,12 @@
 	return ll_new_hw_segment(q, req, bio);
 }
 
-static int ll_front_merge_fn(request_queue_t *q, struct request *req, 
+static int ll_front_merge_fn(request_queue_t *q, struct request *req,
 			     struct bio *bio)
 {
-	if (req->nr_sectors + bio_sectors(bio) > q->max_sectors) {
+	const int rw = rq_data_dir(req);
+
+	if (req->nr_sectors + bio_sectors(bio) > q->optimal_sectors[rw]) {
 		req->flags |= REQ_NOMERGE;
 		q->last_merge = NULL;
 		return 0;
@@ -1053,6 +1065,7 @@
 {
 	int total_phys_segments = req->nr_phys_segments +next->nr_phys_segments;
 	int total_hw_segments = req->nr_hw_segments + next->nr_hw_segments;
+	const int rw = rq_data_dir(req);
 
 	/*
 	 * First check if the either of the requests are re-queued
@@ -1064,7 +1077,7 @@
 	/*
 	 * Will it become to large?
 	 */
-	if ((req->nr_sectors + next->nr_sectors) > q->max_sectors)
+	if ((req->nr_sectors + next->nr_sectors) > q->optimal_sectors[rw])
 		return 0;
 
 	total_phys_segments = req->nr_phys_segments + next->nr_phys_segments;
@@ -2312,9 +2325,9 @@
 		__blk_put_request(q, freereq);
 
 	if (blk_queue_plugged(q)) {
-		int nr_queued = q->rq.count[READ] + q->rq.count[WRITE];
+		int nrq = q->rq.count[READ] + q->rq.count[WRITE] - q->in_flight;
 
-		if (nr_queued == q->unplug_thresh)
+		if (nrq == q->unplug_thresh)
 			__generic_unplug_device(q);
 	}
 	spin_unlock_irq(q->queue_lock);
@@ -2575,6 +2588,74 @@
 	rq->nr_hw_segments = nr_hw_segs;
 }
 
+#define BLK_IORATE_SAMPLES	(512)
+#define BLK_IORATE_ALIGNMASK	(7)	/* 4kb alignment */
+#define BLK_IORATE_TARGET	(50)	/* 50ms latency */
+#define BLK_IORATE_ALIGN(x)	(x) = (((x) + BLK_IORATE_ALIGNMASK) & ~BLK_IORATE_ALIGNMASK)
+
+static inline void blk_calc_stream_rate(struct request *rq, int nbytes)
+{
+	request_queue_t *q = rq->q;
+	unsigned int iorate, max_sectors;
+	unsigned long duration;
+	struct blk_iorate *ior;
+	int rw;
+
+	if (!blk_fs_request(rq))
+		return;
+	if (unlikely(!q))
+		return;
+
+	rw = rq_data_dir(rq);
+	ior = &q->iorates[rw];
+	duration = jiffies - rq->issue_time;
+
+	ior->io_rate_samples++;
+	if (!(ior->io_rate_samples & (BLK_IORATE_SAMPLES - 1))) {
+		ior->io_rate_samples = 0;
+		ior->best_io_rate = 0;
+	}
+			
+	duration = max(jiffies - rq->start_time, 1UL);
+	iorate = nbytes / duration;
+	if (iorate > ior->best_io_rate)
+		ior->best_io_rate = iorate;
+
+	/*
+	 * average old optimal sectors with best data rate
+	 */
+	if (!ior->io_rate_samples) {
+		struct backing_dev_info *bdi = &q->backing_dev_info;
+		int ra_sec = bdi->ra_pages << (PAGE_CACHE_SHIFT - 9);
+		int ra_sec_max = VM_MAX_READAHEAD << 9;
+
+		max_sectors = (ior->best_io_rate * BLK_IORATE_TARGET) >> 9;
+		q->optimal_sectors[rw] = (q->optimal_sectors[rw] + max_sectors) / 2;
+		BLK_IORATE_ALIGN(q->optimal_sectors[rw]);
+
+		/*
+		 * don't exceed the hardware limit
+		 */
+		if (q->optimal_sectors[rw] > q->max_sectors)
+			q->optimal_sectors[rw] = q->max_sectors;
+
+		/*
+		 * let read-ahead be optimal io size aligned, and no more than
+		 * a single request
+		 */
+		if (rw == READ) {
+			if (ra_sec > q->optimal_sectors[READ])
+				ra_sec = q->optimal_sectors[READ];
+			if (ra_sec > ra_sec_max)
+				ra_sec = ra_sec_max;
+
+			bdi->ra_pages = ra_sec >> (PAGE_CACHE_SHIFT - 9);
+		}
+
+		printk("%s: %s optimal sectors %u (ra %lu)\n", rq->rq_disk->disk_name, rw == WRITE ? "WRITE" : "READ", q->optimal_sectors[rw], bdi->ra_pages);
+	}
+}
+
 void blk_recalc_rq_sectors(struct request *rq, int nsect)
 {
 	if (blk_fs_request(rq)) {
@@ -2628,7 +2709,8 @@
 			printk("end_request: I/O error, dev %s, sector %llu\n",
 				req->rq_disk ? req->rq_disk->disk_name : "?",
 				(unsigned long long)req->sector);
-	}
+	} else
+		blk_calc_stream_rate(req, nr_bytes);
 
 	total_bytes = bio_nbytes = 0;
 	while ((bio = req->bio)) {
===== include/linux/blkdev.h 1.138 vs edited =====
--- 1.138/include/linux/blkdev.h	Fri Mar 12 10:33:07 2004
+++ edited/include/linux/blkdev.h	Tue Mar 30 13:00:51 2004
@@ -122,6 +122,7 @@
 	struct gendisk *rq_disk;
 	int errors;
 	unsigned long start_time;
+	unsigned long issue_time;
 
 	/* Number of scatter-gather DMA addr+len pairs after
 	 * physical address coalescing is performed.
@@ -267,6 +268,11 @@
 	atomic_t refcnt;		/* map can be shared */
 };
 
+struct blk_iorate {
+	unsigned int		io_rate_samples;
+	unsigned int		best_io_rate;
+};
+
 struct request_queue
 {
 	/*
@@ -337,11 +343,12 @@
 	 */
 	unsigned long		nr_requests;	/* Max # of requests */
 
-	unsigned short		max_sectors;
 	unsigned short		max_phys_segments;
 	unsigned short		max_hw_segments;
 	unsigned short		hardsect_size;
 	unsigned int		max_segment_size;
+	unsigned int		max_sectors;
+	unsigned int		optimal_sectors[2];
 
 	unsigned long		seg_boundary_mask;
 	unsigned int		dma_alignment;
@@ -350,6 +357,10 @@
 
 	atomic_t		refcnt;
 
+	unsigned short		in_flight;
+
+	struct blk_iorate	iorates[2];
+
 	/*
 	 * sg stuff
 	 */
@@ -378,6 +389,9 @@
 #define blk_fs_request(rq)	((rq)->flags & REQ_CMD)
 #define blk_pc_request(rq)	((rq)->flags & REQ_BLOCK_PC)
 #define blk_noretry_request(rq)	((rq)->flags & REQ_FAILFAST)
+#define blk_rq_started(rq)	((rq)->flags & REQ_STARTED)
+
+#define blk_account_rq(rq)	(blk_rq_started(rq) && blk_fs_request(rq))
 
 #define blk_pm_suspend_request(rq)	((rq)->flags & REQ_PM_SUSPEND)
 #define blk_pm_resume_request(rq)	((rq)->flags & REQ_PM_RESUME)
@@ -558,7 +572,7 @@
 extern void blk_cleanup_queue(request_queue_t *);
 extern void blk_queue_make_request(request_queue_t *, make_request_fn *);
 extern void blk_queue_bounce_limit(request_queue_t *, u64);
-extern void blk_queue_max_sectors(request_queue_t *, unsigned short);
+extern void blk_queue_max_sectors(request_queue_t *, unsigned int);
 extern void blk_queue_max_phys_segments(request_queue_t *, unsigned short);
 extern void blk_queue_max_hw_segments(request_queue_t *, unsigned short);
 extern void blk_queue_max_segment_size(request_queue_t *, unsigned int);

-- 
Jens Axboe

