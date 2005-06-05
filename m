Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261471AbVFEGRe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261471AbVFEGRe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Jun 2005 02:17:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261493AbVFEGQW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Jun 2005 02:16:22 -0400
Received: from wproxy.gmail.com ([64.233.184.206]:4850 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261471AbVFEF5z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Jun 2005 01:57:55 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:user-agent:content-type:references:in-reply-to:subject:message-id:date;
        b=HzXsFesfRVHGHKcrjFsUu9J4gKVEzZMm+2e+EgI6MWaku0cgCW5/LFJoTqUP4JxgVwJSOUNb8qtN8T1/zHcXvOGYlwft2W/Lx9Eftt7wMERHqYo2EUayp81zvNa2TKMg/TclAC5qjKSGRpW8CjFMn91zL2Q+/B/lCFAGJHSYCs8=
From: Tejun Heo <htejun@gmail.com>
To: axboe@suse.de, James.Bottomley@steeleye.com, bzolnier@gmail.com,
       jgarzik@pobox.com
Cc: linux-kernel@vger.kernel.org
User-Agent: lksp 0.3
Content-Type: text/plain; charset=US-ASCII
References: <20050605055337.6301E65A@htj.dyndns.org>
In-Reply-To: <20050605055337.6301E65A@htj.dyndns.org>
Subject: Re: [PATCH Linux 2.6.12-rc5-mm2 09/09] blk: debug messages
Message-ID: <20050605055337.77D353DA@htj.dyndns.org>
Date: Sun,  5 Jun 2005 14:57:50 +0900 (KST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

09_blk_ordered_reimpl_debug_msgs.patch

	Theses are debug message I've been using.  If you wanna see
	what's going on...

Signed-off-by: Tejun Heo <htejun@gmail.com>

 elevator.c  |    7 +++++++
 ll_rw_blk.c |   31 ++++++++++++++++++++++++++++++-
 2 files changed, 37 insertions(+), 1 deletion(-)

Index: blk-fixes/drivers/block/elevator.c
===================================================================
--- blk-fixes.orig/drivers/block/elevator.c	2005-06-05 14:53:34.000000000 +0900
+++ blk-fixes/drivers/block/elevator.c	2005-06-05 14:53:36.000000000 +0900
@@ -37,6 +37,8 @@
 
 #include <asm/uaccess.h>
 
+#define pd(fmt, args...) 	printk("[%-24s]: " fmt, __FUNCTION__ , ##args);
+
 /*
  * XXX HACK XXX Before entering elevator callbacks, we temporailiy
  * turn off REQ_CMD of proxy barrier request so that elevators don't
@@ -436,6 +438,11 @@ struct request *elv_next_request(request
 		}
 	}
 
+	if (rq && (rq == q->pre_flush_rq || rq == q->post_flush_rq ||
+		   rq == q->bar_rq))
+		pd("%p (%s)\n", rq,
+		   rq == q->pre_flush_rq ?
+			"pre" : (rq == q->post_flush_rq ? "post" : "bar"));
 	return rq;
 }
 
Index: blk-fixes/drivers/block/ll_rw_blk.c
===================================================================
--- blk-fixes.orig/drivers/block/ll_rw_blk.c	2005-06-05 14:53:34.000000000 +0900
+++ blk-fixes/drivers/block/ll_rw_blk.c	2005-06-05 14:53:36.000000000 +0900
@@ -30,6 +30,8 @@
 #include <linux/writeback.h>
 #include <linux/blkdev.h>
 
+#define pd(fmt, args...) 	printk("[%-24s]: " fmt, __FUNCTION__ , ##args);
+
 /*
  * for max sense size
  */
@@ -300,6 +302,9 @@ static int __blk_queue_ordered(request_q
 	unsigned ordered_flags;
 	int ret = 0;
 
+	pd("%x->%x, ordseq=%x, next_ordered=%x\n", q->ordered, ordered,
+	   q->ordseq, q->next_ordered);
+
 	might_sleep_if(gfp_mask & __GFP_WAIT);
 
 	ordered_flags = ordered & QUEUE_ORDERED_FLAGS;
@@ -484,6 +489,9 @@ void blk_ordered_complete_seq(request_qu
 	struct request *rq;
 	int uptodate, changed = 0;
 
+	pd("ordseq=%02x seq=%02x orderr=%d error=%d\n",
+	   q->ordseq, seq, q->orderr, error);
+
 	if (error && !q->orderr)
 		ordered_set_error(q, seq, error);
 
@@ -496,6 +504,7 @@ void blk_ordered_complete_seq(request_qu
 	/*
 	 * Okay, sequence complete.
 	 */
+	pd("sequence complete\n");
 	rq = q->orig_bar_rq;
 	uptodate = q->orderr ? q->orderr : 1;
 
@@ -559,6 +568,17 @@ static void queue_flush(request_queue_t 
 static inline struct request *start_ordered(request_queue_t *q,
 					    struct request *rq)
 {
+	pd("%p -> %p,%p,%p infl=%u\n",
+	   rq, q->pre_flush_rq, q->bar_rq, q->post_flush_rq, q->in_flight);
+	pd("%p %d %llu %lu %u %u %u %p\n", rq->bio, rq->errors,
+	   (unsigned long long)rq->hard_sector, rq->hard_nr_sectors,
+	   rq->current_nr_sectors, rq->nr_phys_segments, rq->nr_hw_segments,
+	   rq->buffer);
+	struct bio *bio;
+	for (bio = rq->bio; bio; bio = bio->bi_next)
+		pd("BIO %p %llu %u\n",
+		   bio, (unsigned long long)bio->bi_sector, bio->bi_size);
+
 	q->bi_size = 0;
 	q->orderr = 0;
 	q->ordseq |= QUEUE_ORDSEQ_STARTED;
@@ -596,6 +616,7 @@ static inline struct request *start_orde
 	} else
 		q->ordseq |= QUEUE_ORDSEQ_PREFLUSH;
 
+	pd("ordered=%x in_flight=%u\n", q->ordered, q->in_flight);
 	if ((q->ordered & QUEUE_ORDERED_TAG) || q->in_flight == 0)
 		q->ordseq |= QUEUE_ORDSEQ_DRAIN;
 	else
@@ -615,8 +636,10 @@ int blk_do_ordered(request_queue_t *q, s
 
 		if (q->ordered != QUEUE_ORDERED_NONE) {
 			*rqp = start_ordered(q, rq);
+			pd("start_ordered %p->%p\n", rq, *rqp);
 			return 1;
 		} else {
+			pd("ORDERED_NONE, seen barrier\n");
 			/*
 			 * This can happen when the queue switches to
 			 * ORDERED_NONE while this request is on it.
@@ -633,6 +656,7 @@ int blk_do_ordered(request_queue_t *q, s
 	if (q->ordered & QUEUE_ORDERED_TAG) {
 		if (blk_fs_request(rq) && rq != q->bar_rq)
 			*rqp = NULL;
+		pd("seq=%02x %p->%p\n", blk_ordered_cur_seq(q), rq, *rqp);
 		return 1;
 	}
 
@@ -654,7 +678,7 @@ int blk_do_ordered(request_queue_t *q, s
 	if (rq != allowed_rq && (blk_fs_request(rq) || rq == q->pre_flush_rq ||
 				 rq == q->post_flush_rq))
 		*rqp = NULL;
-
+	pd("seq=%02x %p->%p\n", blk_ordered_cur_seq(q), rq, *rqp);
 	return 1;
 }
 
@@ -687,6 +711,9 @@ static int flush_dry_bio_endio(struct bi
 	bio->bi_sector -= (q->bi_size >> 9);
 	q->bi_size = 0;
 
+	pd("BIO %p %llu %u\n",
+	   bio, (unsigned long long)bio->bi_sector, bio->bi_size);
+
 	return 0;
 }
 
@@ -700,6 +727,7 @@ static inline int ordered_bio_endio(stru
 	if (q->bar_rq != rq)
 		return 0;
 
+	pd("q->orderr=%d error=%d\n", q->orderr, error);
 	/*
 	 * Okay, this is the barrier request in progress, dry finish it.
 	 */
@@ -2791,6 +2819,7 @@ static int __make_request(request_queue_
 
 	barrier = bio_barrier(bio);
 	if (unlikely(barrier) && (q->ordered == QUEUE_ORDERED_NONE)) {
+		pd("ORDERED_NONE, seen barrier\n");
 		err = -EOPNOTSUPP;
 		goto end_io;
 	}

