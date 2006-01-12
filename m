Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030388AbWALLSz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030388AbWALLSz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 06:18:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030392AbWALLSz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 06:18:55 -0500
Received: from wproxy.gmail.com ([64.233.184.196]:46674 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030388AbWALLSy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 06:18:54 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=uPgfM3mIcFSUHR9OUsoAHtVY1Z7JAjdgy8yzYpvc6IQTvkRhsEmVCA7SpAOYhVIgG1zM79ZL5aB6RULKS6Rb+eofdvQocLSKSSoHVLx4Uo68VvD106CZ6QciuiGuApnjeRXi00ndbZl/a/aWzjsidb8an/cNhaVS9NU/zkiZHqs=
Date: Thu, 12 Jan 2006 20:18:46 +0900
From: Tejun Heo <htejun@gmail.com>
To: Reuben Farrelly <reuben-lkml@reub.net>
Cc: Jens Axboe <axboe@suse.de>, Andrew Morton <akpm@osdl.org>, neilb@suse.de,
       mingo@elte.hu, linux-kernel@vger.kernel.org,
       Jeff Garzik <jgarzik@pobox.com>
Subject: Re: 2.6.15-mm2
Message-ID: <20060112111846.GA19976@htj.dyndns.org>
References: <20060111115616.GE3389@suse.de> <43C518BC.5090903@reub.net> <20060111145201.GS3389@suse.de> <20060111145504.GT3389@suse.de> <43C55B31.5000201@reub.net> <20060111194517.GE5373@suse.de> <20060111195349.GF5373@suse.de> <43C5D1CA.7000400@reub.net> <20060112080051.GA22783@htj.dyndns.org> <43C61598.7050004@reub.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43C61598.7050004@reub.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2006 at 09:38:48PM +1300, Reuben Farrelly wrote:
[--snip--]
> [start_ordered       ] f7e8a708 -> c1b028fc,c1b029a4,c1b02a4c infl=1
> [start_ordered       ] f74b0e00 0 48869571 8 8 1 1 c1ba9000
> [start_ordered       ] BIO f74b0e00 48869571 4096
> [start_ordered       ] ordered=31 in_flight=1
> [blk_do_ordered      ] start_ordered f7e8a708->00000000
> [blk_do_ordered      ] seq=02 f74ccd98->f74ccd98
> [blk_do_ordered      ] seq=02 f74ccd98->f74ccd98
> [blk_do_ordered      ] seq=02 c1b028fc->00000000
> [blk_do_ordered      ] seq=02 c1b028fc->00000000
> [blk_do_ordered      ] seq=02 c1b028fc->00000000

Yeap, this one is the offending one.  0xf74ccd98 got requeued in front
of pre-flush while draining and when it finished it didn't complete
draining thus hanging the queue.  It seems like it's some kind of
special request which probably fails and got retried.  Are you using
SMART or something which issues special commands to drives?

> [start_ordered       ] c1b53660 -> c1b021c4,c1b0226c,c1b02314 infl=1
> [start_ordered       ] f7e58d80 0 68436682 8 8 1 1 c1bbd000
> [start_ordered       ] BIO f7e58d80 68436682 4096
> [start_ordered       ] ordered=31 in_flight=1
> [blk_do_ordered      ] start_ordered c1b53660->00000000
> [blk_ordered_complete_seq] ordseq=01 seq=02 orderr=0 error=0
> [blk_do_ordered      ] seq=04 c1b021c4->c1b021c4
> [elv_next_request    ] c1b021c4 (pre)
> [blk_do_ordered      ] seq=04 c1b0226c->00000000
> [blk_do_ordered      ] seq=04 c1b0226c->00000000
> [end_that_request_last] !ELVPRIV c1b021c4 02002318
> [blk_ordered_complete_seq] ordseq=03 seq=04 orderr=0 error=0
> [blk_do_ordered      ] seq=08 c1b0226c->c1b0226c
> [elv_next_request    ] c1b0226c (bar)
> [blk_do_ordered      ] seq=08 c1b02314->00000000
> [ordered_bio_endio   ] q->orderr=0 error=0
> [flush_dry_bio_endio ] BIO f7e58d80 68436682 4096
> [end_that_request_last] !ELVPRIV c1b0226c 000003d9
> [blk_ordered_complete_seq] ordseq=07 seq=08 orderr=0 error=0
> [blk_do_ordered      ] seq=10 c1b02314->c1b02314
> [elv_next_request    ] c1b02314 (post)
> [end_that_request_last] !ELVPRIV c1b02314 02002318
> [blk_ordered_complete_seq] ordseq=0f seq=10 orderr=0 error=0
> [blk_ordered_complete_seq] sequence complete
> 

Can you please try the following debug patch.  I've added a few more
debug messages to make things clearer.

diff --git a/block/elevator.c b/block/elevator.c
index 1b5b5d9..a0075aa 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -37,6 +37,9 @@
 
 #include <asm/uaccess.h>
 
+#define pd(fmt, args...) printk("[%02d %-24s] "fmt, q->id, __FUNCTION__ , ##args)
+#define pd0(fmt, args...) printk("[na %-24s] "fmt, __FUNCTION__ , ##args)
+
 static DEFINE_SPINLOCK(elv_list_lock);
 static LIST_HEAD(elv_list);
 
@@ -296,6 +299,9 @@ void elv_requeue_request(request_queue_t
 	 * it already went through dequeue, we need to decrement the
 	 * in_flight count again
 	 */
+	if (q->ordseq)
+		pd("ordseq=%02x requeueing %p (flags=0x%lx) infl=%u\n",
+		   q->ordseq, rq, rq->flags, q->in_flight);
 	if (blk_account_rq(rq)) {
 		q->in_flight--;
 		if (blk_sorted_rq(rq) && e->ops->elevator_deactivate_req_fn)
@@ -351,8 +357,10 @@ void __elv_add_request(request_queue_t *
 			q->end_sector = rq_end_sector(rq);
 			q->boundary_rq = rq;
 		}
-	} else if (!(rq->flags & REQ_ELVPRIV) && where == ELEVATOR_INSERT_SORT)
+	} else if (!(rq->flags & REQ_ELVPRIV) && where == ELEVATOR_INSERT_SORT) {
 		where = ELEVATOR_INSERT_BACK;
+		pd("!ELVPRIV %p %08lx inserting back\n", rq, rq->flags);
+	}
 
 	if (plug)
 		blk_plug_device(q);
@@ -528,6 +536,11 @@ struct request *elv_next_request(request
 		}
 	}
 
+	if (rq && (rq == &q->pre_flush_rq || rq == &q->post_flush_rq ||
+		   rq == &q->bar_rq))
+		pd("%p (%s)\n", rq,
+		   rq == &q->pre_flush_rq ?
+			"pre" : (rq == &q->post_flush_rq ? "post" : "bar"));
 	return rq;
 }
 
@@ -623,6 +636,9 @@ void elv_completed_request(request_queue
 		 * Check if the queue is waiting for fs requests to be
 		 * drained for flush sequence.
 		 */
+		if (q->ordseq)
+			pd("seq=%02x rq=%p (flags=0x%lx) infl=%u\n",
+			   q->ordseq, rq, rq->flags, q->in_flight);
 		if (q->ordseq && q->in_flight == 0 &&
 		    blk_ordered_cur_seq(q) == QUEUE_ORDSEQ_DRAIN &&
 		    blk_ordered_req_seq(first_rq) > QUEUE_ORDSEQ_DRAIN) {
@@ -632,7 +648,9 @@ void elv_completed_request(request_queue
 
 		if (blk_sorted_rq(rq) && e->ops->elevator_completed_req_fn)
 			e->ops->elevator_completed_req_fn(q, rq);
-	}
+	} else if (q->ordseq)
+		pd("seq=%02x unacc %p (flags=0x%lx) infl=%u\n",
+		   q->ordseq, rq, rq->flags, q->in_flight);
 }
 
 int elv_register_queue(struct request_queue *q)
diff --git a/block/ll_rw_blk.c b/block/ll_rw_blk.c
index ec27dda..494fe39 100644
--- a/block/ll_rw_blk.c
+++ b/block/ll_rw_blk.c
@@ -28,6 +28,9 @@
 #include <linux/writeback.h>
 #include <linux/blktrace_api.h>
 
+#define pd(fmt, args...) printk("[%02d %-24s] "fmt, q->id, __FUNCTION__ , ##args)
+#define pd0(fmt, args...) printk("[na %-24s] "fmt, __FUNCTION__ , ##args)
+
 /*
  * for max sense size
  */
@@ -303,6 +306,8 @@ static inline void rq_init(request_queue
 int blk_queue_ordered(request_queue_t *q, unsigned ordered,
 		      prepare_flush_fn *prepare_flush_fn)
 {
+	pd("%x->%x, ordseq=%x\n", q->next_ordered, ordered, q->ordseq);
+
 	if (ordered & (QUEUE_ORDERED_PREFLUSH | QUEUE_ORDERED_POSTFLUSH) &&
 	    prepare_flush_fn == NULL) {
 		printk(KERN_ERR "blk_queue_ordered: prepare_flush_fn required\n");
@@ -380,6 +385,9 @@ void blk_ordered_complete_seq(request_qu
 	struct request *rq;
 	int uptodate;
 
+	pd("ordseq=%02x seq=%02x orderr=%d error=%d\n",
+	   q->ordseq, seq, q->orderr, error);
+
 	if (error && !q->orderr)
 		q->orderr = error;
 
@@ -392,6 +400,7 @@ void blk_ordered_complete_seq(request_qu
 	/*
 	 * Okay, sequence complete.
 	 */
+	pd("sequence complete\n");
 	rq = q->orig_bar_rq;
 	uptodate = q->orderr ? q->orderr : 1;
 
@@ -446,6 +455,18 @@ static void queue_flush(request_queue_t 
 static inline struct request *start_ordered(request_queue_t *q,
 					    struct request *rq)
 {
+	pd("%p -> %p,%p,%p ordcolor=%d infl=%u \n",
+	   rq, &q->pre_flush_rq, &q->bar_rq, &q->post_flush_rq,
+	   q->ordcolor, q->in_flight);
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
 	q->ordered = q->next_ordered;
@@ -484,6 +505,7 @@ static inline struct request *start_orde
 	} else
 		q->ordseq |= QUEUE_ORDSEQ_PREFLUSH;
 
+	pd("ordered=%x in_flight=%u\n", q->ordered, q->in_flight);
 	if ((q->ordered & QUEUE_ORDERED_TAG) || q->in_flight == 0)
 		q->ordseq |= QUEUE_ORDSEQ_DRAIN;
 	else
@@ -503,8 +525,10 @@ int blk_do_ordered(request_queue_t *q, s
 
 		if (q->next_ordered != QUEUE_ORDERED_NONE) {
 			*rqp = start_ordered(q, rq);
+			pd("start_ordered %p->%p\n", rq, *rqp);
 			return 1;
 		} else {
+			pd("ORDERED_NONE, seen barrier\n");
 			/*
 			 * This can happen when the queue switches to
 			 * ORDERED_NONE while this request is on it.
@@ -521,6 +545,8 @@ int blk_do_ordered(request_queue_t *q, s
 	if (q->ordered & QUEUE_ORDERED_TAG) {
 		if (is_barrier && rq != &q->bar_rq)
 			*rqp = NULL;
+		pd("seq=%02x %p->%p (flag=0x%lx)\n",
+		   blk_ordered_cur_seq(q), rq, *rqp, *rqp ? (*rqp)->flags : 0);
 		return 1;
 	}
 
@@ -544,6 +570,8 @@ int blk_do_ordered(request_queue_t *q, s
 	     rq == &q->post_flush_rq))
 		*rqp = NULL;
 
+	pd("seq=%02x %p->%p (flags=0x%lx)\n",
+	   blk_ordered_cur_seq(q), rq, *rqp, *rqp ? (*rqp)->flags : 0);
 	return 1;
 }
 
@@ -576,6 +604,8 @@ static int flush_dry_bio_endio(struct bi
 	bio->bi_sector -= (q->bi_size >> 9);
 	q->bi_size = 0;
 
+	pd0("BIO %p %llu %u\n",
+	    bio, (unsigned long long)bio->bi_sector, bio->bi_size);
 	return 0;
 }
 
@@ -589,6 +619,7 @@ static inline int ordered_bio_endio(stru
 	if (&q->bar_rq != rq)
 		return 0;
 
+	pd("q->orderr=%d error=%d\n", q->orderr, error);
 	/*
 	 * Okay, this is the barrier request in progress, dry finish it.
 	 */
@@ -1858,6 +1889,11 @@ blk_init_queue_node(request_fn_proc *rfn
 	if (!q)
 		return NULL;
 
+	{
+		static int qid;
+		q->id = qid++;
+	}
+
 	q->node = node_id;
 	if (blk_init_free_list(q))
 		goto out_init;
@@ -2008,6 +2044,8 @@ static void freed_request(request_queue_
 	rl->count[rw]--;
 	if (priv)
 		rl->elvpriv--;
+	else
+		pd("!priv, count=%u,%u elvpriv=%u\n", rl->count[0], rl->count[1], rl->elvpriv);
 
 	__freed_request(q, rw);
 
@@ -2074,6 +2112,8 @@ static struct request *get_request(reque
 	priv = !test_bit(QUEUE_FLAG_ELVSWITCH, &q->queue_flags);
 	if (priv)
 		rl->elvpriv++;
+	else
+		pd("!priv, count=%u,%u elvpriv=%u\n", rl->count[0], rl->count[1], rl->elvpriv);
 
 	spin_unlock_irq(q->queue_lock);
 
@@ -2839,6 +2879,7 @@ static int __make_request(request_queue_
 
 	barrier = bio_barrier(bio);
 	if (unlikely(barrier) && (q->next_ordered == QUEUE_ORDERED_NONE)) {
+		pd("ORDERED_NONE, seen barrier\n");
 		err = -EOPNOTSUPP;
 		goto end_io;
 	}
@@ -3394,6 +3435,9 @@ void end_that_request_last(struct reques
 	if (end_io_error(uptodate))
 		error = !uptodate ? -EIO : uptodate;
 
+	if (!(req->flags & REQ_ELVPRIV))
+		pd0("!ELVPRIV %p %08lx\n", req, req->flags);
+
 	if (unlikely(laptop_mode) && blk_fs_request(req))
 		laptop_io_completion();
 
diff --git a/drivers/scsi/sata_sil24.c b/drivers/scsi/sata_sil24.c
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 991a5ca..e7a5df1 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -427,6 +427,8 @@ struct request_queue
 	struct request		*orig_bar_rq;
 	unsigned int		bi_size;
 	struct blk_trace	*blk_trace;
+
+	int id;
 };
 
 #define RQ_INACTIVE		(-1)
