Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284917AbRLXOEZ>; Mon, 24 Dec 2001 09:04:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284916AbRLXOEP>; Mon, 24 Dec 2001 09:04:15 -0500
Received: from fepz.post.tele.dk ([195.41.46.133]:46269 "EHLO
	fepZ.post.tele.dk") by vger.kernel.org with ESMTP
	id <S284917AbRLXODw>; Mon, 24 Dec 2001 09:03:52 -0500
Date: Mon, 24 Dec 2001 15:03:40 +0100
From: Jens Axboe <axboe@suse.de>
To: really mason_at_soo_dot_com <lnx-kern@Sophia.soo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.2-pre1 oddness under X
Message-ID: <20011224150340.B593@suse.de>
In-Reply-To: <20011223144800.A22538@Sophia.soo.com> <Pine.LNX.4.33.0112231457070.5312-100000@coffee.psychology.mcmaster.ca> <20011223160419.A22752@Sophia.soo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="LSp5EJdfMPwZcMS1"
Content-Disposition: inline
In-Reply-To: <20011223160419.A22752@Sophia.soo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--LSp5EJdfMPwZcMS1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Dec 23 2001, really mason_at_soo_dot_com wrote:
> The funny thing still is that i get this error regardless
> of whether i overclock, underclock, or leave as is using
> kernel 2.5.2-pre1, when i start X:
> 
> Inconsistency detected by ld.so: dynamic-link.h: 62: elf_get_dynamic_info: Assertion `! "bad dynamic tag"' failed!
> 
> X eventually starts, minus the Sawfish window manager.

Very good to have a test case that is easy triggerable. Could you please
try with this patch applied? Check dmesg for any kernel messages or
oopses, thanks. Also, send me your .config.

> Everything's fine from kernel version 2.5.1 down.  If it
> is indeed disk corruption of some kind, i guess i better 
> run an older kernel and fsck.

Yes that would be a good idea.

-- 
Jens Axboe


--LSp5EJdfMPwZcMS1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=bio-252p1-2

diff -ur -X exclude /opt/kernel/linux-2.5.2-pre1/drivers/block/elevator.c linux/drivers/block/elevator.c
--- /opt/kernel/linux-2.5.2-pre1/drivers/block/elevator.c	Sun Dec 23 17:11:54 2001
+++ linux/drivers/block/elevator.c	Sun Dec 23 15:53:07 2001
@@ -124,21 +124,21 @@
 inline int elv_try_merge(struct request *__rq, struct bio *bio)
 {
 	unsigned int count = bio_sectors(bio);
-
-	if (!elv_rq_merge_ok(__rq, bio))
-		return ELEVATOR_NO_MERGE;
+	int ret = ELEVATOR_NO_MERGE;
 
 	/*
 	 * we can merge and sequence is ok, check if it's possible
 	 */
-	if (__rq->sector + __rq->nr_sectors == bio->bi_sector) {
-		return ELEVATOR_BACK_MERGE;
-	} else if (__rq->sector - count == bio->bi_sector) {
-		__rq->elevator_sequence -= count;
-		return ELEVATOR_FRONT_MERGE;
+	if (elv_rq_merge_ok(__rq, bio)) {
+		if (__rq->sector + __rq->nr_sectors == bio->bi_sector) {
+			ret = ELEVATOR_BACK_MERGE;
+		} else if (__rq->sector - count == bio->bi_sector) {
+			__rq->elevator_sequence -= count;
+			ret = ELEVATOR_FRONT_MERGE;
+		}
 	}
 
-	return ELEVATOR_NO_MERGE;
+	return ret;
 }
 
 int elevator_linus_merge(request_queue_t *q, struct request **req,
@@ -172,15 +172,17 @@
 		 */
 		if (__rq->elevator_sequence-- <= 0)
 			break;
+
 		if (__rq->flags & (REQ_BARRIER | REQ_STARTED))
 			break;
 		if (!(__rq->flags & REQ_CMD))
 			continue;
-		if (__rq->elevator_sequence < 0)
-			break;
 
 		if (!*req && bio_rq_in_between(bio, __rq, &q->queue_head))
 			*req = __rq;
+
+		if (__rq->elevator_sequence < bio_sectors(bio))
+			break;
 
 		if ((ret = elv_try_merge(__rq, bio))) {
 			*req = __rq;
diff -ur -X exclude /opt/kernel/linux-2.5.2-pre1/drivers/block/ll_rw_blk.c linux/drivers/block/ll_rw_blk.c
--- /opt/kernel/linux-2.5.2-pre1/drivers/block/ll_rw_blk.c	Sun Dec 23 17:11:54 2001
+++ linux/drivers/block/ll_rw_blk.c	Mon Dec 24 14:50:46 2001
@@ -155,6 +155,11 @@
 	blk_queue_max_sectors(q, MAX_SECTORS);
 	blk_queue_hardsect_size(q, 512);
 
+	/*
+	 * by default assume old behaviour and bounce for any highmem page
+	 */
+	blk_queue_bounce_limit(q, BLK_BOUNCE_HIGH);
+
 	init_waitqueue_head(&q->queue_wait);
 }
 
@@ -603,9 +608,6 @@
 		return 0;
 
 	/* Merge is OK... */
-	if (q->last_merge == &next->queuelist)
-		q->last_merge = NULL;
-
 	req->nr_phys_segments = total_phys_segments;
 	req->nr_hw_segments = total_hw_segments;
 	return 1;
@@ -812,12 +814,8 @@
 	q->plug_tq.data		= q;
 	q->queue_flags		= (1 << QUEUE_FLAG_CLUSTER);
 	q->queue_lock		= lock;
+	q->last_merge		= NULL;
 	
-	/*
-	 * by default assume old behaviour and bounce for any highmem page
-	 */
-	blk_queue_bounce_limit(q, BLK_BOUNCE_HIGH);
-
 	blk_queue_segment_boundary(q, 0xffffffff);
 
 	blk_queue_make_request(q, __make_request);
@@ -886,6 +884,12 @@
 	if (!rq && (gfp_mask & __GFP_WAIT))
 		rq = get_request_wait(q, rw);
 
+	if (rq) {
+		rq->flags = 0;
+		rq->buffer = NULL;
+		rq->bio = rq->biotail = NULL;
+		rq->waiting = NULL;
+	}
 	return rq;
 }
 
@@ -953,10 +977,15 @@
 	/*
 	 * debug stuff...
 	 */
-	if (insert_here == &q->queue_head) {
-		struct request *__rq = __elv_next_request(q);
+	if (insert_here->next != &q->queue_head) {
+		struct request *__rq = list_entry_rq(insert_here->next);
 
+#if 0
 		BUG_ON(__rq && (__rq->flags & REQ_STARTED));
+#else
+		if (__rq->flags & REQ_STARTED)
+			printk("add_request: irk, next is started\n");
+#endif
 	}
 
 	/*
@@ -972,11 +1001,15 @@
 void blkdev_release_request(struct request *req)
 {
 	struct request_list *rl = req->rl;
+	request_queue_t *q = req->q;
 
 	req->rq_status = RQ_INACTIVE;
 	req->q = NULL;
 	req->rl = NULL;
 
+	if (q && q->last_merge == &req->queuelist)
+		q->last_merge = NULL;
+
 	/*
 	 * Request may not have originated from ll_rw_blk. if not,
 	 * it didn't come out of our reserved rq pools
@@ -1571,21 +1604,23 @@
 
 inline void blk_recalc_rq_sectors(struct request *rq, int nsect)
 {
-	rq->hard_sector += nsect;
-	rq->hard_nr_sectors -= nsect;
-	rq->sector = rq->hard_sector;
-	rq->nr_sectors = rq->hard_nr_sectors;
+	if (rq->flags & REQ_CMD) {
+		rq->hard_sector += nsect;
+		rq->hard_nr_sectors -= nsect;
+		rq->sector = rq->hard_sector;
+		rq->nr_sectors = rq->hard_nr_sectors;
 
-	rq->current_nr_sectors = bio_iovec(rq->bio)->bv_len >> 9;
-	rq->hard_cur_sectors = rq->current_nr_sectors;
+		rq->current_nr_sectors = bio_iovec(rq->bio)->bv_len >> 9;
+		rq->hard_cur_sectors = rq->current_nr_sectors;
 
-	/*
-	 * if total number of sectors is less than the first segment
-	 * size, something has gone terribly wrong
-	 */
-	if (rq->nr_sectors < rq->current_nr_sectors) {
-		printk("blk: request botched\n");
-		rq->nr_sectors = rq->current_nr_sectors;
+		/*
+		 * if total number of sectors is less than the first segment
+		 * size, something has gone terribly wrong
+		 */
+		if (rq->nr_sectors < rq->current_nr_sectors) {
+			printk("blk: request botched\n");
+			rq->nr_sectors = rq->current_nr_sectors;
+		}
 	}
 }
 
diff -ur -X exclude /opt/kernel/linux-2.5.2-pre1/include/linux/blkdev.h linux/include/linux/blkdev.h
--- /opt/kernel/linux-2.5.2-pre1/include/linux/blkdev.h	Sun Dec 23 17:11:55 2001
+++ linux/include/linux/blkdev.h	Sun Dec 23 17:15:02 2001
@@ -196,8 +196,7 @@
 #define RQ_SCSI_DISCONNECTING	0xffe0
 
 #define QUEUE_FLAG_PLUGGED	0	/* queue is plugged */
-#define QUEUE_FLAG_NOSPLIT	1	/* can process bio over several goes */
-#define QUEUE_FLAG_CLUSTER	2	/* cluster several segments into 1 */
+#define QUEUE_FLAG_CLUSTER	1	/* cluster several segments into 1 */
 
 #define blk_queue_plugged(q)	test_bit(QUEUE_FLAG_PLUGGED, &(q)->queue_flags)
 #define blk_mark_plugged(q)	set_bit(QUEUE_FLAG_PLUGGED, &(q)->queue_flags)
diff -ur -X exclude /opt/kernel/linux-2.5.2-pre1/mm/highmem.c linux/mm/highmem.c
--- /opt/kernel/linux-2.5.2-pre1/mm/highmem.c	Sun Dec 23 17:11:56 2001
+++ linux/mm/highmem.c	Mon Dec 24 13:59:21 2001
@@ -25,7 +25,9 @@
 
 static void *page_pool_alloc(int gfp_mask, void *data)
 {
-	return alloc_page(gfp_mask);
+	int gfp = gfp_mask | (int) data;
+
+	return alloc_page(gfp);
 }
 
 static void page_pool_free(void *page, void *data)
@@ -252,7 +254,7 @@
 	if (isa_page_pool)
 		return 0;
 
-	isa_page_pool = mempool_create(ISA_POOL_SIZE, page_pool_alloc, page_pool_free, NULL);
+	isa_page_pool = mempool_create(ISA_POOL_SIZE, page_pool_alloc, page_pool_free, (void *) __GFP_DMA);
 	if (!isa_page_pool)
 		BUG();
 
@@ -272,7 +274,7 @@
 	int i;
 
 	__bio_for_each_segment(tovec, to, i, 0) {
-		fromvec = &from->bi_io_vec[i];
+		fromvec = from->bi_io_vec + i;
 
 		/*
 		 * not bounced
@@ -301,7 +303,7 @@
 	 * free up bounce indirect pages used
 	 */
 	__bio_for_each_segment(bvec, bio, i, 0) {
-		org_vec = &bio_orig->bi_io_vec[i];
+		org_vec = bio_orig->bi_io_vec + i;
 		if (bvec->bv_page == org_vec->bv_page)
 			continue;
 
@@ -394,7 +397,7 @@
 		if (!bio)
 			bio = bio_alloc(bio_gfp, (*bio_orig)->bi_vcnt);
 
-		to = &bio->bi_io_vec[i];
+		to = bio->bi_io_vec + i;
 
 		to->bv_page = mempool_alloc(pool, gfp);
 		to->bv_len = from->bv_len;

--LSp5EJdfMPwZcMS1--
