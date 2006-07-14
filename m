Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161006AbWGNJjK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161006AbWGNJjK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 05:39:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964813AbWGNJjK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 05:39:10 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:58429 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S964810AbWGNJjJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 05:39:09 -0400
From: Jens Axboe <axboe@suse.de>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@suse.de>
Subject: [PATCH 2/3] Remove struct request_list from struct request
Date: Fri, 14 Jul 2006 11:41:55 +0200
Message-Id: <11528701162802-git-send-email-axboe@suse.de>
X-Mailer: git-send-email 1.4.1.ged0e0
In-Reply-To: <11528701161633-git-send-email-axboe@suse.de>
References: <11528701161633-git-send-email-axboe@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It is always identical to &q->rq, and we only use it for detecting
whether this request came out of our mempool or not. So replace it
with an additional ->flags bit flag.

Signed-off-by: Jens Axboe <axboe@suse.de>
---
 block/ll_rw_blk.c      |   10 ++--------
 include/linux/blkdev.h |    3 ++-
 2 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/block/ll_rw_blk.c b/block/ll_rw_blk.c
index 0ed0e83..06b1fec 100644
--- a/block/ll_rw_blk.c
+++ b/block/ll_rw_blk.c
@@ -452,7 +452,6 @@ static void queue_flush(request_queue_t 
 	rq->elevator_private = NULL;
 	rq->elevator_private2 = NULL;
 	rq->rq_disk = q->bar_rq.rq_disk;
-	rq->rl = NULL;
 	rq->end_io = end_io;
 	q->prepare_flush_fn(q, rq);
 
@@ -478,7 +477,6 @@ static inline struct request *start_orde
 	rq->flags |= q->ordered & QUEUE_ORDERED_FUA ? REQ_FUA : 0;
 	rq->elevator_private = NULL;
 	rq->elevator_private2 = NULL;
-	rq->rl = NULL;
 	init_request_from_bio(rq, q->orig_bar_rq->bio);
 	rq->end_io = bar_end_io;
 
@@ -1984,7 +1982,7 @@ blk_alloc_request(request_queue_t *q, in
 	 * first three bits are identical in rq->flags and bio->bi_rw,
 	 * see bio.h and blkdev.h
 	 */
-	rq->flags = rw;
+	rq->flags = rw | REQ_ALLOCED;
 
 	if (priv) {
 		if (unlikely(elv_set_request(q, rq, bio, gfp_mask))) {
@@ -2162,7 +2160,6 @@ rq_starved:
 		ioc->nr_batch_requests--;
 	
 	rq_init(q, rq);
-	rq->rl = rl;
 
 	blk_add_trace_generic(q, bio, rw, BLK_TA_GETRQ);
 out:
@@ -2646,8 +2643,6 @@ EXPORT_SYMBOL_GPL(disk_round_stats);
  */
 void __blk_put_request(request_queue_t *q, struct request *req)
 {
-	struct request_list *rl = req->rl;
-
 	if (unlikely(!q))
 		return;
 	if (unlikely(--req->ref_count))
@@ -2656,13 +2651,12 @@ void __blk_put_request(request_queue_t *
 	elv_completed_request(q, req);
 
 	req->rq_status = RQ_INACTIVE;
-	req->rl = NULL;
 
 	/*
 	 * Request may not have originated from ll_rw_blk. if not,
 	 * it didn't come out of our reserved rq pools
 	 */
-	if (rl) {
+	if (req->flags & REQ_ALLOCED) {
 		int rw = rq_data_dir(req);
 		int priv = req->flags & REQ_ELVPRIV;
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 575d3e8..1370687 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -183,7 +183,6 @@ struct request {
 
 	int ref_count;
 	request_queue_t *q;
-	struct request_list *rl;
 
 	void *special;
 	char *buffer;
@@ -244,6 +243,7 @@ enum rq_flag_bits {
 	__REQ_PM_SHUTDOWN,	/* shutdown request */
 	__REQ_ORDERED_COLOR,	/* is before or after barrier */
 	__REQ_RW_SYNC,		/* request is sync (O_DIRECT) */
+	__REQ_ALLOCED,		/* request came from our alloc pool */
 	__REQ_NR_BITS,		/* stops here */
 };
 
@@ -274,6 +274,7 @@ #define REQ_PM_RESUME	(1 << __REQ_PM_RES
 #define REQ_PM_SHUTDOWN	(1 << __REQ_PM_SHUTDOWN)
 #define REQ_ORDERED_COLOR	(1 << __REQ_ORDERED_COLOR)
 #define REQ_RW_SYNC	(1 << __REQ_RW_SYNC)
+#define REQ_ALLOCED	(1 << __REQ_ALLOCED)
 
 /*
  * State information carried for REQ_PM_SUSPEND and REQ_PM_RESUME
-- 
1.4.1.ged0e0

