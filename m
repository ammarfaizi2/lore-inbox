Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263934AbTKGWEL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Nov 2003 17:04:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263914AbTKGWED
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Nov 2003 17:04:03 -0500
Received: from mail-01.iinet.net.au ([203.59.3.33]:10953 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S264088AbTKGLc0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Nov 2003 06:32:26 -0500
Message-ID: <3FAB82A2.4070907@cyberone.com.au>
Date: Fri, 07 Nov 2003 22:31:46 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: "Prakash K. Cheemplavam" <prakashpublic@gmx.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.9test9-mm1 and DAO ATAPI cd-burning corrupt
References: <20031106130030.GC1145@suse.de> <3FAA4737.3060906@cyberone.com.au> <20031106130553.GD1145@suse.de> <3FAA4880.8090600@cyberone.com.au> <20031106131141.GE1145@suse.de> <3FAA4D48.6040709@gmx.de> <20031106133136.GA477@suse.de> <3FAA5043.8060907@gmx.de> <20031106134713.GA798@suse.de> <3FAA5397.6010702@gmx.de> <20031106135134.GA1194@suse.de> <3FAA5CCB.5030902@gmx.de> <3FAB0754.2040209@cyberone.com.au> <3FAB7F94.7050504@gmx.de>
In-Reply-To: <3FAB7F94.7050504@gmx.de>
Content-Type: multipart/mixed;
 boundary="------------010300060506060501050109"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010300060506060501050109
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit



Prakash K. Cheemplavam wrote:

> Nick Piggin wrote:
>
>>
>>
>> Prakash K. Cheemplavam wrote:
>>
>>> Ok, I found the bugger: It *IS* the sheduler. I tried 
>>> elevator=deadline and all stuttering went away. Before I was using 
>>> as. mm1 used default sheduler (as I think) and ther eno probs. So 
>>> the (updated?) as sheduler in mm2 has a problem...
>>
>>
>>
>>
>> Weird. I have a few new AS patches in mm2 so its probably them. I can't
>> see why they'd be causing you to lose interrupts though. Could you try
>> this patch please.
>
>
> So i tried the patch, but it didn't help. I cannot feel any 
> difference. Here are the vstats. First for dealine and second fro 
> patched as. Please keep in mind that (at the end of the stat) I 
> fiddled a bit around with the kernel sources while doing the burn. 
> Intersting would be the start of the erasing and start of burning. 
> There as gives serious stuttering.



OK thanks. Please try this patch then. Thank you.


--------------010300060506060501050109
Content-Type: text/plain;
 name="as-revert.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="as-revert.patch"

 linux-2.6-npiggin/drivers/block/as-iosched.c |  320 +++++++++------------------
 1 files changed, 109 insertions(+), 211 deletions(-)

diff -puN drivers/block/as-iosched.c~as-revert drivers/block/as-iosched.c
--- linux-2.6/drivers/block/as-iosched.c~as-revert	2003-11-07 22:26:43.000000000 +1100
+++ linux-2.6-npiggin/drivers/block/as-iosched.c	2003-11-07 22:28:59.000000000 +1100
@@ -70,7 +70,6 @@
 /* Bits in as_io_context.state */
 enum as_io_states {
 	AS_TASK_RUNNING=0,	/* Process has not exitted */
-	AS_TASK_IOSTARTED,	/* Process has started some IO */
 	AS_TASK_IORUNNING,	/* Process has completed some IO */
 };
 
@@ -100,14 +99,6 @@ struct as_data {
 	sector_t last_sector[2];	/* last REQ_SYNC & REQ_ASYNC sectors */
 	struct list_head *dispatch;	/* driver dispatch queue */
 	struct list_head *hash;		/* request hash */
-
-	unsigned long exit_prob;	/* probability a task will exit while
-					   being waited on */
-	unsigned long new_ttime_total; 	/* mean thinktime on new proc */
-	unsigned long new_ttime_mean;
-	u64 new_seek_total;		/* mean seek on new proc */
-	sector_t new_seek_mean;
-
 	unsigned long current_batch_expires;
 	unsigned long last_check_fifo[2];
 	int changed_batch;		/* 1: waiting for old batch to end */
@@ -145,10 +136,6 @@ enum arq_state {
 				   scheduler */
 	AS_RQ_DISPATCHED,	/* On the dispatch list. It belongs to the
 				   driver now */
-	AS_RQ_PRESCHED,		/* Debug poisoning for requests being used */
-	AS_RQ_REMOVED,
-	AS_RQ_MERGED,
-	AS_RQ_POSTSCHED,	/* when they shouldn't be */
 };
 
 struct as_rq {
@@ -195,7 +182,6 @@ static void free_as_io_context(struct as
 /* Called when the task exits */
 static void exit_as_io_context(struct as_io_context *aic)
 {
-	WARN_ON(!test_bit(AS_TASK_RUNNING, &aic->state));
 	clear_bit(AS_TASK_RUNNING, &aic->state);
 }
 
@@ -618,15 +604,8 @@ static void as_antic_timeout(unsigned lo
 	spin_lock_irqsave(q->queue_lock, flags);
 	if (ad->antic_status == ANTIC_WAIT_REQ
 			|| ad->antic_status == ANTIC_WAIT_NEXT) {
-		struct as_io_context *aic = ad->io_context->aic;
-
 		ad->antic_status = ANTIC_FINISHED;
 		kblockd_schedule_work(&ad->antic_work);
-
-		if (aic->ttime_samples == 0) {
-			/* process anticipated on has exitted or timed out*/
-			ad->exit_prob = (7*ad->exit_prob + 256)/8;
-		}
 	}
 	spin_unlock_irqrestore(q->queue_lock, flags);
 }
@@ -640,7 +619,7 @@ static int as_close_req(struct as_data *
 	unsigned long delay;	/* milliseconds */
 	sector_t last = ad->last_sector[ad->batch_data_dir];
 	sector_t next = arq->request->sector;
-	sector_t delta; /* acceptable close offset (in sectors) */
+	sector_t delta;	/* acceptable close offset (in sectors) */
 
 	if (ad->antic_status == ANTIC_OFF || !ad->ioc_finished)
 		delay = 0;
@@ -657,7 +636,6 @@ static int as_close_req(struct as_data *
 	return (last - (delta>>1) <= next) && (next <= last + delta);
 }
 
-static void as_update_thinktime(struct as_data *ad, struct as_io_context *aic, unsigned long ttime);
 /*
  * as_can_break_anticipation returns true if we have been anticipating this
  * request.
@@ -675,27 +653,9 @@ static int as_can_break_anticipation(str
 {
 	struct io_context *ioc;
 	struct as_io_context *aic;
-	sector_t s;
-
-	ioc = ad->io_context;
-	BUG_ON(!ioc);
-
-	if (arq && ioc == arq->io_context) {
-		/* request from same process */
-		return 1;
-	}
 
 	if (arq && arq->is_sync == REQ_SYNC && as_close_req(ad, arq)) {
 		/* close request */
-		struct as_io_context *aic = ioc->aic;
-		if (aic) {
-			unsigned long thinktime;
-			spin_lock(&aic->lock);
-			thinktime = jiffies - aic->last_end_request;
-			aic->last_end_request = jiffies;
-			as_update_thinktime(ad, aic, thinktime);
-			spin_unlock(&aic->lock);
-		}
 		return 1;
 	}
 
@@ -707,14 +667,20 @@ static int as_can_break_anticipation(str
 		return 1;
 	}
 
+	ioc = ad->io_context;
+	BUG_ON(!ioc);
+
+	if (arq && ioc == arq->io_context) {
+		/* request from same process */
+		return 1;
+	}
+
 	aic = ioc->aic;
 	if (!aic)
 		return 0;
 
 	if (!test_bit(AS_TASK_RUNNING, &aic->state)) {
 		/* process anticipated on has exitted */
-		if (aic->ttime_samples == 0)
-			ad->exit_prob = (7*ad->exit_prob + 256)/8;
 		return 1;
 	}
 
@@ -728,36 +694,27 @@ static int as_can_break_anticipation(str
 		return 1;
 	}
 
-	if (aic->ttime_samples == 0) {
-		if (ad->new_ttime_mean > ad->antic_expire)
-			return 1;
-		if (ad->exit_prob > 128)
-			return 1;
-	} else if (aic->ttime_mean > ad->antic_expire) {
-		/* the process thinks too much between requests */
+	if (aic->seek_samples == 0 || aic->ttime_samples == 0) {
+		/*
+		 * Process has just started IO. Don't anticipate.
+		 * TODO! Must fix this up.
+		 */
 		return 1;
 	}
 
-	if (!arq)
-		return 0;
-
-	if (ad->last_sector[REQ_SYNC] < arq->request->sector)
-		s = arq->request->sector - ad->last_sector[REQ_SYNC];
-	else
-		s = ad->last_sector[REQ_SYNC] - arq->request->sector;
+	if (aic->ttime_mean > ad->antic_expire) {
+		/* the process thinks too much between requests */
+		return 1;
+	}
 
-	if (aic->seek_samples == 0) {
-		/*
-		 * Process has just started IO. Use past statistics to
-		 * guage success possibility
-		 */
-		if (ad->new_seek_mean/2 > s) {
-			/* this request is better than what we're expecting */
-			return 1;
-		}
+	if (arq && aic->seek_samples) {
+		sector_t s;
+		if (ad->last_sector[REQ_SYNC] < arq->request->sector)
+			s = arq->request->sector - ad->last_sector[REQ_SYNC];
+		else
+			s = ad->last_sector[REQ_SYNC] - arq->request->sector;
 
-	} else {
-		if (aic->seek_mean/2 > s) {
+		if (aic->seek_mean > (s>>1)) {
 			/* this request is better than what we're expecting */
 			return 1;
 		}
@@ -802,51 +759,12 @@ static int as_can_anticipate(struct as_d
 	return 1;
 }
 
-static void as_update_thinktime(struct as_data *ad, struct as_io_context *aic, unsigned long ttime)
-{
-	/* fixed point: 1.0 == 1<<8 */
-	if (aic->ttime_samples == 0) {
-		ad->new_ttime_total = (7*ad->new_ttime_total + 256*ttime) / 8;
-		ad->new_ttime_mean = ad->new_ttime_total / 256;
-
-		ad->exit_prob = (7*ad->exit_prob)/8;
-	}
-	aic->ttime_samples = (7*aic->ttime_samples + 256) / 8;
-	aic->ttime_total = (7*aic->ttime_total + 256*ttime) / 8;
-	aic->ttime_mean = (aic->ttime_total + 128) / aic->ttime_samples;
-}
-
-static void as_update_seekdist(struct as_data *ad, struct as_io_context *aic, sector_t sdist)
-{
-	u64 total;
-
-	if (aic->seek_samples == 0) {
-		ad->new_seek_total = (7*ad->new_seek_total + 256*(u64)sdist)/8;
-		ad->new_seek_mean = ad->new_seek_total / 256;
-	}
-
-	/*
-	 * Don't allow the seek distance to get too large from the
-	 * odd fragment, pagein, etc
-	 */
-	if (aic->seek_samples <= 60) /* second&third seek */
-		sdist = min(sdist, (aic->seek_mean * 4) + 2*1024*1024);
-	else
-		sdist = min(sdist, (aic->seek_mean * 4)	+ 2*1024*64);
-
-	aic->seek_samples = (7*aic->seek_samples + 256) / 8;
-	aic->seek_total = (7*aic->seek_total + (u64)256*sdist) / 8;
-	total = aic->seek_total + (aic->seek_samples/2);
-	do_div(total, aic->seek_samples);
-	aic->seek_mean = (sector_t)total;
-}
-
 /*
  * as_update_iohist keeps a decaying histogram of IO thinktimes, and
  * updates @aic->ttime_mean based on that. It is called when a new
  * request is queued.
  */
-static void as_update_iohist(struct as_data *ad, struct as_io_context *aic, struct request *rq)
+static void as_update_iohist(struct as_io_context *aic, struct request *rq)
 {
 	struct as_rq *arq = RQ_DATA(rq);
 	int data_dir = arq->is_sync;
@@ -857,29 +775,60 @@ static void as_update_iohist(struct as_d
 		return;
 
 	if (data_dir == REQ_SYNC) {
-		unsigned long in_flight = atomic_read(&aic->nr_queued)
-					+ atomic_read(&aic->nr_dispatched);
 		spin_lock(&aic->lock);
-		if (test_bit(AS_TASK_IORUNNING, &aic->state) ||
-			test_bit(AS_TASK_IOSTARTED, &aic->state)) {
+
+		if (test_bit(AS_TASK_IORUNNING, &aic->state)
+				&& !atomic_read(&aic->nr_queued)
+				&& !atomic_read(&aic->nr_dispatched)) {
 			/* Calculate read -> read thinktime */
-			if (test_bit(AS_TASK_IORUNNING, &aic->state)
-							&& in_flight == 0) {
-				thinktime = jiffies - aic->last_end_request;
-				thinktime = min(thinktime, MAX_THINKTIME-1);
-			} else
-				thinktime = 0;
-			as_update_thinktime(ad, aic, thinktime);
-
-			/* Calculate read -> read seek distance */
-			if (aic->last_request_pos < rq->sector)
-				seek_dist = rq->sector - aic->last_request_pos;
-			else
-				seek_dist = aic->last_request_pos - rq->sector;
-			as_update_seekdist(ad, aic, seek_dist);
-		}
+			thinktime = jiffies - aic->last_end_request;
+			thinktime = min(thinktime, MAX_THINKTIME-1);
+			/* fixed point: 1.0 == 1<<8 */
+			aic->ttime_samples += 256;
+			aic->ttime_total += 256*thinktime;
+			if (aic->ttime_samples)
+				/* fixed point factor is cancelled here */
+				aic->ttime_mean = (aic->ttime_total + 128)
+							/ aic->ttime_samples;
+			aic->ttime_samples = (aic->ttime_samples>>1)
+						+ (aic->ttime_samples>>2);
+			aic->ttime_total = (aic->ttime_total>>1)
+						+ (aic->ttime_total>>2);
+		}
+
+		/* Calculate read -> read seek distance */
+		if (!aic->seek_samples)
+			seek_dist = 0;
+		else if (aic->last_request_pos < rq->sector)
+			seek_dist = rq->sector - aic->last_request_pos;
+		else
+			seek_dist = aic->last_request_pos - rq->sector;
+
 		aic->last_request_pos = rq->sector + rq->nr_sectors;
-		set_bit(AS_TASK_IOSTARTED, &aic->state);
+
+		/*
+		 * Don't allow the seek distance to get too large from the
+		 * odd fragment, pagein, etc
+		 */
+		if (aic->seek_samples < 400) /* second&third seek */
+			seek_dist = min(seek_dist, (aic->seek_mean * 4)
+							+ 2*1024*1024);
+		else
+			seek_dist = min(seek_dist, (aic->seek_mean * 4)
+							+ 2*1024*64);
+
+		aic->seek_samples += 256;
+		aic->seek_total += (u64)256*seek_dist;
+		if (aic->seek_samples) {
+			u64 total = aic->seek_total + (aic->seek_samples>>1);
+			do_div(total, aic->seek_samples);
+			aic->seek_mean = (sector_t)total;
+		}
+		aic->seek_samples = (aic->seek_samples>>1)
+					+ (aic->seek_samples>>2);
+		aic->seek_total = (aic->seek_total>>1)
+					+ (aic->seek_total>>2);
+
 		spin_unlock(&aic->lock);
 	}
 }
@@ -944,22 +893,12 @@ static void as_completed_request(request
 {
 	struct as_data *ad = q->elevator.elevator_data;
 	struct as_rq *arq = RQ_DATA(rq);
+	struct as_io_context *aic;
 
 	WARN_ON(!list_empty(&rq->queuelist));
 
-	if (arq->state == AS_RQ_PRESCHED) {
-		WARN_ON(arq->io_context);
-		goto out;
-	}
-
-	if (arq->state == AS_RQ_MERGED)
-		goto out_ioc;
-
-	if (arq->state != AS_RQ_REMOVED) {
-		printk("arq->state %d\n", arq->state);
-		WARN_ON(1);
-		goto out;
-	}
+	if (unlikely(arq->state != AS_RQ_DISPATCHED))
+		return;
 
 	if (!blk_fs_request(rq))
 		return;
@@ -989,7 +928,10 @@ static void as_completed_request(request
 		ad->new_batch = 0;
 	}
 
-	if (ad->io_context == arq->io_context && ad->io_context) {
+	if (!arq->io_context)
+		return;
+
+	if (ad->io_context == arq->io_context) {
 		ad->antic_start = jiffies;
 		ad->ioc_finished = 1;
 		if (ad->antic_status == ANTIC_WAIT_REQ) {
@@ -1001,23 +943,18 @@ static void as_completed_request(request
 		}
 	}
 
-out_ioc:
-	if (!arq->io_context)
-		goto out;
+	aic = arq->io_context->aic;
+	if (!aic)
+		return;
 
+	spin_lock(&aic->lock);
 	if (arq->is_sync == REQ_SYNC) {
-		struct as_io_context *aic = arq->io_context->aic;
-		if (aic) {
-			spin_lock(&aic->lock);
-			set_bit(AS_TASK_IORUNNING, &aic->state);
-			aic->last_end_request = jiffies;
-			spin_unlock(&aic->lock);
-		}
+		set_bit(AS_TASK_IORUNNING, &aic->state);
+		aic->last_end_request = jiffies;
 	}
+	spin_unlock(&aic->lock);
 
 	put_io_context(arq->io_context);
-out:
-	arq->state = AS_RQ_POSTSCHED;
 }
 
 /*
@@ -1086,14 +1023,14 @@ static void as_remove_request(request_qu
 	struct as_rq *arq = RQ_DATA(rq);
 
 	if (unlikely(arq->state == AS_RQ_NEW))
-		goto out;
+		return;
+
+	if (!arq) {
+		WARN_ON(1);
+		return;
+	}
 
 	if (ON_RB(&arq->rb_node)) {
-		if (arq->state != AS_RQ_QUEUED) {
-			printk("arq->state %d\n", arq->state);
-			WARN_ON(1);
-			goto out;
-		}
 		/*
 		 * We'll lose the aliased request(s) here. I don't think this
 		 * will ever happen, but if it does, hopefully someone will
@@ -1101,16 +1038,8 @@ static void as_remove_request(request_qu
 		 */
 		WARN_ON(!list_empty(&rq->queuelist));
 		as_remove_queued_request(q, rq);
-	} else {
-		if (arq->state != AS_RQ_DISPATCHED) {
-			printk("arq->state %d\n", arq->state);
-			WARN_ON(1);
-			goto out;
-		}
+	} else
 		as_remove_dispatched_request(q, rq);
-	}
-out:
-	arq->state = AS_RQ_REMOVED;
 }
 
 /*
@@ -1288,9 +1217,9 @@ static int as_dispatch_request(struct as
 			 */
 			goto dispatch_writes;
 
-		if (ad->batch_data_dir == REQ_ASYNC) {
+ 		if (ad->batch_data_dir == REQ_ASYNC) {
 			WARN_ON(ad->new_batch);
-			ad->changed_batch = 1;
+ 			ad->changed_batch = 1;
 		}
 		ad->batch_data_dir = REQ_SYNC;
 		arq = list_entry_fifo(ad->fifo_list[ad->batch_data_dir].next);
@@ -1306,8 +1235,8 @@ static int as_dispatch_request(struct as
 dispatch_writes:
 		BUG_ON(RB_EMPTY(&ad->sort_list[REQ_ASYNC]));
 
-		if (ad->batch_data_dir == REQ_SYNC) {
-			ad->changed_batch = 1;
+ 		if (ad->batch_data_dir == REQ_SYNC) {
+ 			ad->changed_batch = 1;
 
 			/*
 			 * new_batch might be 1 when the queue runs out of
@@ -1350,6 +1279,8 @@ fifo_expired:
 			ad->new_batch = 1;
 
 		ad->changed_batch = 0;
+
+//		arq->request->flags |= REQ_SOFTBARRIER;
 	}
 
 	/*
@@ -1426,8 +1357,8 @@ static void as_add_request(struct as_dat
 	arq->io_context = as_get_io_context();
 
 	if (arq->io_context) {
-		as_update_iohist(ad, arq->io_context->aic, arq->request);
 		atomic_inc(&arq->io_context->aic->nr_queued);
+		as_update_iohist(arq->io_context->aic, arq->request);
 	}
 
 	alias = as_add_arq_rb(ad, arq);
@@ -1474,11 +1405,6 @@ static void as_requeue_request(request_q
 	struct as_rq *arq = RQ_DATA(rq);
 
 	if (arq) {
-		if (arq->state != AS_RQ_REMOVED) {
-			printk("arq->state %d\n", arq->state);
-			WARN_ON(1);
-		}
-
 		arq->state = AS_RQ_DISPATCHED;
 		if (arq->io_context && arq->io_context->aic)
 			atomic_inc(&arq->io_context->aic->nr_dispatched);
@@ -1498,18 +1424,12 @@ as_insert_request(request_queue_t *q, st
 	struct as_data *ad = q->elevator.elevator_data;
 	struct as_rq *arq = RQ_DATA(rq);
 
-	if (arq) {
-		if (arq->state != AS_RQ_PRESCHED) {
-			printk("arq->state: %d\n", arq->state);
-			WARN_ON(1);
-		}
-		arq->state = AS_RQ_NEW;
-	}
-
+#if 0
 	/* barriers must flush the reorder queue */
 	if (unlikely(rq->flags & (REQ_SOFTBARRIER | REQ_HARDBARRIER)
 			&& where == ELEVATOR_INSERT_SORT))
 		where = ELEVATOR_INSERT_BACK;
+#endif
 
 	switch (where) {
 		case ELEVATOR_INSERT_BACK:
@@ -1744,8 +1664,7 @@ as_merged_requests(request_queue_t *q, s
 	 * kill knowledge of next, this one is a goner
 	 */
 	as_remove_queued_request(q, next);
-
-	anext->state = AS_RQ_MERGED;
+	put_io_context(anext->io_context);
 }
 
 /*
@@ -1778,11 +1697,6 @@ static void as_put_request(request_queue
 		return;
 	}
 
-	if (arq->state != AS_RQ_POSTSCHED) {
-		printk("arq->state %d\n", arq->state);
-		WARN_ON(1);
-	}
-
 	mempool_free(arq, ad->arq_pool);
 	rq->elevator_private = NULL;
 }
@@ -1796,7 +1710,7 @@ static int as_set_request(request_queue_
 		memset(arq, 0, sizeof(*arq));
 		RB_CLEAR(&arq->rb_node);
 		arq->request = rq;
-		arq->state = AS_RQ_PRESCHED;
+		arq->state = AS_RQ_NEW;
 		arq->io_context = NULL;
 		INIT_LIST_HEAD(&arq->hash);
 		arq->on_hash = 0;
@@ -1933,17 +1847,6 @@ as_var_store(unsigned long *var, const c
 	return count;
 }
 
-static ssize_t as_est_show(struct as_data *ad, char *page)
-{
-	int pos = 0;
-
-	pos += sprintf(page+pos, "%lu %% exit probability\n", 100*ad->exit_prob/256);
-	pos += sprintf(page+pos, "%lu ms new thinktime\n", ad->new_ttime_mean);
-	pos += sprintf(page+pos, "%llu sectors new seek distance\n", (unsigned long long)ad->new_seek_mean);
-
-	return pos;
-}
-
 #define SHOW_FUNCTION(__FUNC, __VAR)					\
 static ssize_t __FUNC(struct as_data *ad, char *page)		\
 {									\
@@ -1975,10 +1878,6 @@ STORE_FUNCTION(as_write_batchexpire_stor
 			&ad->batch_expire[REQ_ASYNC], 0, INT_MAX);
 #undef STORE_FUNCTION
 
-static struct as_fs_entry as_est_entry = {
-	.attr = {.name = "est_time", .mode = S_IRUGO },
-	.show = as_est_show,
-};
 static struct as_fs_entry as_readexpire_entry = {
 	.attr = {.name = "read_expire", .mode = S_IRUGO | S_IWUSR },
 	.show = as_readexpire_show,
@@ -2006,7 +1905,6 @@ static struct as_fs_entry as_write_batch
 };
 
 static struct attribute *default_attrs[] = {
-	&as_est_entry.attr,
 	&as_readexpire_entry.attr,
 	&as_writeexpire_entry.attr,
 	&as_anticexpire_entry.attr,

_

--------------010300060506060501050109--

