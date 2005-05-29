Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261237AbVE2EeC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261237AbVE2EeC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 May 2005 00:34:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261245AbVE2Ed7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 May 2005 00:33:59 -0400
Received: from wproxy.gmail.com ([64.233.184.198]:14344 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261237AbVE2EYA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 May 2005 00:24:00 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:user-agent:content-type:references:in-reply-to:subject:message-id:date;
        b=nzBKyOaLeiUSpoEkkPDbjAn0wFqZmLF8678/+Aa8Qye1pqUqh4bOGJJz4ezjQ3YloSkaY6g8XARcfHgXou7vvRbueiPVdPRHvnxmHL0RK8wWsa/1qoBnUSwgIilJQziVhtnULtSbs7Db1cjohg/+wOW3kyZZn+Kx/7xC+UH52aE=
From: Tejun Heo <htejun@gmail.com>
To: axboe@suse.de, James.Bottomley@steeleye.com, bzolnier@gmail.com,
       jgarzik@pobox.com
Cc: linux-kernel@vger.kernel.org
User-Agent: lksp 0.3
Content-Type: text/plain; charset=US-ASCII
References: <20050529042034.5FF4CF1C@htj.dyndns.org>
In-Reply-To: <20050529042034.5FF4CF1C@htj.dyndns.org>
Subject: Re: [PATCH Linux 2.6.12-rc5-mm1 06/06] blk: debug messages
Message-ID: <20050529042034.C835550B@htj.dyndns.org>
Date: Sun, 29 May 2005 13:23:48 +0900 (KST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

06_blk_flush_reimplementation_debug_messages.patch

	These are debug messages I've used.  If you are interested how
	it works...

Signed-off-by: Tejun Heo <htejun@gmail.com>

 elevator.c  |    3 +++
 ll_rw_blk.c |   36 ++++++++++++++++++++++++++++++++++--
 2 files changed, 37 insertions(+), 2 deletions(-)

Index: blk-fixes/drivers/block/elevator.c
===================================================================
--- blk-fixes.orig/drivers/block/elevator.c	2005-05-29 13:20:31.000000000 +0900
+++ blk-fixes/drivers/block/elevator.c	2005-05-29 13:20:32.000000000 +0900
@@ -37,6 +37,8 @@
 
 #include <asm/uaccess.h>
 
+#define pd(fmt, args...) 	printk("[%-21s]: " fmt, __FUNCTION__ , ##args);
+
 static DEFINE_SPINLOCK(elv_list_lock);
 static LIST_HEAD(elv_list);
 
@@ -55,6 +57,7 @@ static inline void elv_dec_inflight(requ
 	 * kick the queue in the ass to start the flush sequence.
 	 */
 	if (q->flush_seq == QUEUE_FLUSH_DRAIN && q->in_flight == 0) {
+		pd("-> FLUSH_PRE\n");
 		q->flush_seq = QUEUE_FLUSH_PRE;
 		q->request_fn(q);
 	}
Index: blk-fixes/drivers/block/ll_rw_blk.c
===================================================================
--- blk-fixes.orig/drivers/block/ll_rw_blk.c	2005-05-29 13:20:31.000000000 +0900
+++ blk-fixes/drivers/block/ll_rw_blk.c	2005-05-29 13:20:32.000000000 +0900
@@ -30,6 +30,8 @@
 #include <linux/writeback.h>
 #include <linux/blkdev.h>
 
+#define pd(fmt, args...) 	printk("[%-21s]: " fmt, __FUNCTION__ , ##args);
+
 /*
  * for max sense size
  */
@@ -352,6 +354,7 @@ static void blk_finish_flush(request_que
 	struct request *rq = q->bar_rq;
 	struct bio *bio = q->bar_bio;
 
+	pd("ENTER, -> FLUSH_NONE, error=%d\n", error);
 	q->flush_seq = QUEUE_FLUSH_NONE;
 	q->bar_rq = NULL;
 	q->bar_bio = NULL;
@@ -382,9 +385,11 @@ static void blk_pre_flush_end_io(struct 
 	request_queue_t *q = flush_rq->q;
 	struct request *rq = q->bar_rq;
 
+	pd("ENTER\n");
 	switch (error) {
 	case 0:
 		q->flush_seq = QUEUE_FLUSH_BAR;
+		pd("-> FLUSH_BAR\n");
 		elv_requeue_request(q, rq);
 		break;
 
@@ -399,6 +404,7 @@ static void blk_pre_flush_end_io(struct 
 
 static void blk_post_flush_end_io(struct request *flush_rq, int error)
 {
+	pd("ENTER\n");
 	blk_finish_flush(flush_rq->q, error);
 }
 
@@ -406,12 +412,20 @@ struct request *blk_start_pre_flush(requ
 {
 	struct request *flush_rq = q->flush_rq;
 
+	pd("ENTER\n");
+	struct bio *bio;
+	for (bio = rq->bio; bio; bio = bio->bi_next)
+		pd("BIO %p %llu %u\n",
+		   bio, (unsigned long long)bio->bi_sector, bio->bi_size);
+
 	/*
 	 * prepare_flush returns 0 if no flush is needed, just perform
 	 * the original barrier request in that case.
 	 */
-	if (!blk_prep_flush(q, flush_rq, rq->rq_disk))
+	if (!blk_prep_flush(q, flush_rq, rq->rq_disk)) {
+		pd("Oh well, prep says it's unnecessary\n");
 		return rq;
+	}
 
 	blkdev_dequeue_request(rq);
 	q->bar_rq = rq;
@@ -425,9 +439,11 @@ struct request *blk_start_pre_flush(requ
 
 	if (q->in_flight == 0) {
 		q->flush_seq = QUEUE_FLUSH_PRE;
+		pd("-> FLUSH_PRE\n");
 		return flush_rq;
 	} else {
 		q->flush_seq = QUEUE_FLUSH_DRAIN;
+		pd("-> FLUSH_DRAIN, in_flight=%d\n", q->in_flight);
 		return NULL;
 	}
 }
@@ -436,13 +452,18 @@ static void blk_start_post_flush(request
 {
 	struct request *flush_rq = q->flush_rq;
 
+	pd("ENTER\n");
+
 	if (blk_prep_flush(q, flush_rq, q->bar_rq->rq_disk)) {
+		pd("-> FLUSH_POST\n");
 		flush_rq->end_io = blk_post_flush_end_io;
 		q->flush_seq = QUEUE_FLUSH_POST;
 		__elv_add_request(q, flush_rq, ELEVATOR_INSERT_FRONT, 0);
 		q->request_fn(q);	/* is this necessary? - tj */
-	} else
+	} else {
+		pd("wow, unnecessary?\n");
 		blk_finish_flush(q, 0);
+	}
 }
 
 int blk_do_barrier(request_queue_t *q, struct request **rqp)
@@ -453,6 +474,7 @@ int blk_do_barrier(request_queue_t *q, s
 	switch (q->ordered) {
 	case QUEUE_ORDERED_NONE:
 		if (is_barrier) {
+			pd("ORDERED_NONE, seen barrier\n");
 			/*
 			 * This can happen when the queue switches to
 			 * ORDERED_NONE while this request is on it.
@@ -473,6 +495,7 @@ int blk_do_barrier(request_queue_t *q, s
 			break;
 		case QUEUE_FLUSH_DRAIN:
 			*rqp = NULL;
+			pd("draining... deferring %p\n", rq);
 			break;
 		default:
 			/*
@@ -481,11 +504,14 @@ int blk_do_barrier(request_queue_t *q, s
 			 */
 			if (rq != q->flush_rq && rq != q->bar_rq)
 				*rqp = NULL;
+			pd("flush_seq == %d, %p->%p\n", q->flush_seq, rq, *rqp);
 			break;
 		}
 		return 1;
 
 	case QUEUE_ORDERED_TAG:
+		if (is_barrier)
+			pd("ORDERED_TAG, seen barrier\n");
 		return 1;
 
 	default:
@@ -512,6 +538,9 @@ static int flush_dry_bio_endio(struct bi
 	bio->bi_sector -= (q->bi_size >> 9);
 	q->bi_size = 0;
 
+	pd("%p %llu %u\n",
+	   bio, (unsigned long long)bio->bi_sector, bio->bi_size);
+
 	return 0;
 }
 
@@ -525,6 +554,7 @@ static inline int blk_flush_bio_endio(st
 	if (q->flush_seq != QUEUE_FLUSH_BAR || q->bar_rq != rq)
 		return 0;
 
+	pd("q->flush_error=%d error=%d\n", q->flush_error, error);
 	/*
 	 * Okay, this is the barrier request in progress, dry finish it.
 	 */
@@ -551,6 +581,7 @@ static inline int blk_flush_end_request(
 	if (q->flush_seq != QUEUE_FLUSH_BAR || q->bar_rq != rq)
 		return 0;
 
+	pd("q->flush_error=%d\n", q->flush_error);
 	if (!q->flush_error)
 		blk_start_post_flush(q);
 	else
@@ -2601,6 +2632,7 @@ static int __make_request(request_queue_
 
 	barrier = bio_barrier(bio);
 	if (unlikely(barrier) && (q->ordered == QUEUE_ORDERED_NONE)) {
+		pd("ORDERED_NONE, seen barrier\n");
 		err = -EOPNOTSUPP;
 		goto end_io;
 	}

