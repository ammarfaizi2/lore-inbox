Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264873AbTFYSwy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 14:52:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265025AbTFYSwx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 14:52:53 -0400
Received: from 216-42-72-146.ppp.netsville.net ([216.42.72.146]:46215 "EHLO
	tiny.suse.com") by vger.kernel.org with ESMTP id S264873AbTFYSvP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 14:51:15 -0400
Subject: Re: [PATCH] io stalls
From: Chris Mason <mason@suse.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Nick Piggin <piggin@cyberone.com.au>,
       Marc-Christian Petersen <m.c.p@wolk-project.de>,
       Jens Axboe <axboe@suse.de>, Marcelo Tosatti <marcelo@conectiva.com.br>,
       Georg Nikodym <georgn@somanetworks.com>,
       lkml <linux-kernel@vger.kernel.org>,
       Matthias Mueller <matthias.mueller@rz.uni-karlsruhe.de>
In-Reply-To: <20030612024608.GE1415@dualathlon.random>
References: <1055296630.23697.195.camel@tiny.suse.com>
	 <20030611021030.GQ26270@dualathlon.random>
	 <1055353360.23697.235.camel@tiny.suse.com>
	 <20030611181217.GX26270@dualathlon.random>
	 <1055356032.24111.240.camel@tiny.suse.com>
	 <20030611183503.GY26270@dualathlon.random> <3EE7D1AA.30701@cyberone.com.au>
	 <20030612012951.GG1500@dualathlon.random>
	 <1055384547.24111.322.camel@tiny.suse.com> <3EE7E876.80808@cyberone.com.au>
	 <20030612024608.GE1415@dualathlon.random>
Content-Type: multipart/mixed; boundary="=-dsiFzHBRiC/AmwfTw+sI"
Organization: 
Message-Id: <1056567822.10097.133.camel@tiny.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 25 Jun 2003 15:03:43 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-dsiFzHBRiC/AmwfTw+sI
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hello all,

[ short version, the patch attached should fix io latencies in 2.4.21. 
Please review and/or give it a try ]
 
My last set of patches was directed at reducing the latencies in
__get_request_wait, which really helped reduce stalls when you had lots
of io to one device and balance_dirty() was causing pauses while you
tried to do io to other devices.

But, a streaming write could still starve reads to the same device,
mostly because the read would have to send down any huge merged writes
that were before it in the queue.

Andrea's kernel has a fix for this too, he limits the total number of
sectors that can be in the request queue at any given time.  But, his
patches change blk_finished_io, both in the arguments it takes and the
side effects of calling it.  I don't think we can merge his current form
without breaking external drivers.

So, I added a can_throttle flag to the queue struct, drivers can enable
it if they are going to call the new blk_started_sectors and
blk_finished_sectors funcs any time they call blk_{started,finished}_io,
and these do all the -aa style sector throttling.

There were a few other small changes to Andrea's patch, he wasn't
setting q->full when get_request decided there were too many sectors in
flight.  This resulted in large latencies in __get_request_wait.  He was
also unconditionally clearing q->full in blkdev_release_request, my code
only clears q->full when all the waiters are gone.

I changed generic_unplug_device to zero the elevator_sequence field of
the last request on the queue.  This means there won't be any merges
with requests pending once an unplug is done, and helps limit the number
of sectors that need to be sent down during the run_task_queue(&tq_disk)
in wait_on_buffer.

I lowered the -aa default limit on sectors in flight from 4MB to 2MB. 
We probably want an elvtune for it, large arrays with writeback cache
should be able to tolerate larger values.

There's still a little work left to do, this patch enables sector
throttling for scsi and IDE.  cciss, DAC960 and cpqarray need
modification too (99% done already in -aa).  No sense in doing that
until after the bulk of the patch is reviewed though.

As before, most of the code here is from Andrea and Nick, I've just
wrapped a lot of duct tape around it and done some tweaking.  The
primary pieces are:

fix-pausing (andrea, corner cases where wakeups are missed)
elevator-low-latency (andrea, limit sectors in flight)
queue_full (Nick, fairness in __get_request_wait)

I've removed my latency stats for __get_request_wait in hopes of making
it a better merging candidate.

-chris


--=-dsiFzHBRiC/AmwfTw+sI
Content-Disposition: attachment; filename=io-stalls-7.diff
Content-Type: text/plain; name=io-stalls-7.diff; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

diff -urN --exclude '*.orig' --exclude '*.rej' parent/drivers/block/ll_rw_blk.c comp/drivers/block/ll_rw_blk.c
--- parent/drivers/block/ll_rw_blk.c	2003-06-25 14:12:09.000000000 -0400
+++ comp/drivers/block/ll_rw_blk.c	2003-06-25 14:11:56.000000000 -0400
@@ -176,11 +176,12 @@
 {
 	int count = q->nr_requests;
 
-	count -= __blk_cleanup_queue(&q->rq[READ]);
-	count -= __blk_cleanup_queue(&q->rq[WRITE]);
+	count -= __blk_cleanup_queue(&q->rq);
 
 	if (count)
 		printk("blk_cleanup_queue: leaked requests (%d)\n", count);
+	if (atomic_read(&q->nr_sectors))
+		printk("blk_cleanup_queue: leaked sectors (%d)\n", atomic_read(&q->nr_sectors));
 
 	memset(q, 0, sizeof(*q));
 }
@@ -215,6 +216,24 @@
 }
 
 /**
+ * blk_queue_throttle_sectors - indicates you will call sector throttling funcs
+ * @q:       The queue which this applies to.
+ * @active:  A flag indication if you want sector throttling on
+ *
+ * Description:
+ * The sector throttling code allows us to put a limit on the number of
+ * sectors pending io to the disk at a given time, sending @active nonzero
+ * indicates you will call blk_started_sectors and blk_finished_sectors in
+ * addition to calling blk_started_io and blk_finished_io in order to
+ * keep track of the number of sectors in flight.
+ **/
+ 
+void blk_queue_throttle_sectors(request_queue_t * q, int active)
+{
+	q->can_throttle = active;
+}
+
+/**
  * blk_queue_make_request - define an alternate make_request function for a device
  * @q:  the request queue for the device to be affected
  * @mfn: the alternate make_request function
@@ -360,8 +379,20 @@
 {
 	if (q->plugged) {
 		q->plugged = 0;
-		if (!list_empty(&q->queue_head))
+		if (!list_empty(&q->queue_head)) {
+			struct request *rq;
+
+			/* we don't want merges later on to come in 
+			 * and significantly increase the amount of
+			 * work during an unplug, it can lead to high
+			 * latencies while some poor waiter tries to
+			 * run an ever increasing chunk of io.
+			 * This does lower throughput some though.
+			 */
+			rq = blkdev_entry_prev_request(&q->queue_head),
+			rq->elevator_sequence = 0;
 			q->request_fn(q);
+		}
 	}
 }
 
@@ -389,7 +420,7 @@
  *
  * Returns the (new) number of requests which the queue has available.
  */
-int blk_grow_request_list(request_queue_t *q, int nr_requests)
+int blk_grow_request_list(request_queue_t *q, int nr_requests, int max_queue_sectors)
 {
 	unsigned long flags;
 	/* Several broken drivers assume that this function doesn't sleep,
@@ -399,21 +430,34 @@
 	spin_lock_irqsave(&io_request_lock, flags);
 	while (q->nr_requests < nr_requests) {
 		struct request *rq;
-		int rw;
 
 		rq = kmem_cache_alloc(request_cachep, SLAB_ATOMIC);
 		if (rq == NULL)
 			break;
 		memset(rq, 0, sizeof(*rq));
 		rq->rq_status = RQ_INACTIVE;
-		rw = q->nr_requests & 1;
-		list_add(&rq->queue, &q->rq[rw].free);
-		q->rq[rw].count++;
+ 		list_add(&rq->queue, &q->rq.free);
+ 		q->rq.count++;
+
 		q->nr_requests++;
 	}
+
+ 	/*
+ 	 * Wakeup waiters after both one quarter of the
+ 	 * max-in-fligh queue and one quarter of the requests
+ 	 * are available again.
+ 	 */
+
 	q->batch_requests = q->nr_requests / 4;
 	if (q->batch_requests > 32)
 		q->batch_requests = 32;
+ 	q->batch_sectors = max_queue_sectors / 4;
+ 
+ 	q->max_queue_sectors = max_queue_sectors;
+ 
+ 	BUG_ON(!q->batch_sectors);
+ 	atomic_set(&q->nr_sectors, 0);
+
 	spin_unlock_irqrestore(&io_request_lock, flags);
 	return q->nr_requests;
 }
@@ -422,23 +466,27 @@
 {
 	struct sysinfo si;
 	int megs;		/* Total memory, in megabytes */
-	int nr_requests;
-
-	INIT_LIST_HEAD(&q->rq[READ].free);
-	INIT_LIST_HEAD(&q->rq[WRITE].free);
-	q->rq[READ].count = 0;
-	q->rq[WRITE].count = 0;
+ 	int nr_requests, max_queue_sectors = MAX_QUEUE_SECTORS;
+  
+ 	INIT_LIST_HEAD(&q->rq.free);
+	q->rq.count = 0;
 	q->nr_requests = 0;
 
 	si_meminfo(&si);
 	megs = si.totalram >> (20 - PAGE_SHIFT);
-	nr_requests = 128;
-	if (megs < 32)
-		nr_requests /= 2;
-	blk_grow_request_list(q, nr_requests);
+ 	nr_requests = MAX_NR_REQUESTS;
+ 	if (megs < 30) {
+  		nr_requests /= 2;
+ 		max_queue_sectors /= 2;
+ 	}
+ 	/* notice early if anybody screwed the defaults */
+ 	BUG_ON(!nr_requests);
+ 	BUG_ON(!max_queue_sectors);
+ 
+ 	blk_grow_request_list(q, nr_requests, max_queue_sectors);
+
+ 	init_waitqueue_head(&q->wait_for_requests);
 
-	init_waitqueue_head(&q->wait_for_requests[0]);
-	init_waitqueue_head(&q->wait_for_requests[1]);
 	spin_lock_init(&q->queue_lock);
 }
 
@@ -491,6 +539,9 @@
 	q->plug_tq.routine	= &generic_unplug_device;
 	q->plug_tq.data		= q;
 	q->plugged        	= 0;
+	q->full			= 0;
+	q->can_throttle		= 0;
+
 	/*
 	 * These booleans describe the queue properties.  We set the
 	 * default (and most common) values here.  Other drivers can
@@ -508,12 +559,13 @@
  * Get a free request. io_request_lock must be held and interrupts
  * disabled on the way in.  Returns NULL if there are no free requests.
  */
-static struct request *get_request(request_queue_t *q, int rw)
+static struct request *__get_request(request_queue_t *q, int rw)
 {
 	struct request *rq = NULL;
-	struct request_list *rl = q->rq + rw;
+	struct request_list *rl;
 
-	if (!list_empty(&rl->free)) {
+	rl = &q->rq;
+	if (!list_empty(&rl->free) && !blk_oversized_queue(q)) {
 		rq = blkdev_free_rq(&rl->free);
 		list_del(&rq->queue);
 		rl->count--;
@@ -521,35 +573,47 @@
 		rq->cmd = rw;
 		rq->special = NULL;
 		rq->q = q;
-	}
-
+	} else
+		q->full = 1;
 	return rq;
 }
 
 /*
- * Here's the request allocation design:
+ * get a free request, honoring the queue_full condition
+ */
+static inline struct request *get_request(request_queue_t *q, int rw)
+{
+	if (q->full)
+		return NULL;
+	return __get_request(q, rw);
+}
+
+/* 
+ * helper func to do memory barriers and wakeups when we finally decide
+ * to clear the queue full condition
+ */
+static inline void clear_full_and_wake(request_queue_t *q)
+{
+	q->full = 0;
+	mb();
+	if (waitqueue_active(&q->wait_for_requests))
+		wake_up(&q->wait_for_requests);
+}
+
+/*
+ * Here's the request allocation design, low latency version:
  *
  * 1: Blocking on request exhaustion is a key part of I/O throttling.
  * 
  * 2: We want to be `fair' to all requesters.  We must avoid starvation, and
  *    attempt to ensure that all requesters sleep for a similar duration.  Hence
  *    no stealing requests when there are other processes waiting.
- * 
- * 3: We also wish to support `batching' of requests.  So when a process is
- *    woken, we want to allow it to allocate a decent number of requests
- *    before it blocks again, so they can be nicely merged (this only really
- *    matters if the process happens to be adding requests near the head of
- *    the queue).
- * 
- * 4: We want to avoid scheduling storms.  This isn't really important, because
- *    the system will be I/O bound anyway.  But it's easy.
- * 
- *    There is tension between requirements 2 and 3.  Once a task has woken,
- *    we don't want to allow it to sleep as soon as it takes its second request.
- *    But we don't want currently-running tasks to steal all the requests
- *    from the sleepers.  We handle this with wakeup hysteresis around
- *    0 .. batch_requests and with the assumption that request taking is much,
- *    much faster than request freeing.
+ *
+ * There used to be more here, attempting to allow a process to send in a
+ * number of requests once it has woken up.  But, there's no way to 
+ * tell if a process has just been woken up, or if it is a new process
+ * coming in to steal requests from the waiters.  So, we give up and force
+ * everyone to wait fairly.
  * 
  * So here's what we do:
  * 
@@ -561,28 +625,23 @@
  * 
  *  When a process wants a new request:
  * 
- *    b) If free_requests == 0, the requester sleeps in FIFO manner.
- * 
- *    b) If 0 <  free_requests < batch_requests and there are waiters,
- *       we still take a request non-blockingly.  This provides batching.
- *
- *    c) If free_requests >= batch_requests, the caller is immediately
- *       granted a new request.
+ *    b) If free_requests == 0, the requester sleeps in FIFO manner, and
+ *       the queue full condition is set.  The full condition is not
+ *       cleared until there are no longer any waiters.  Once the full
+ *       condition is set, all new io must wait, hopefully for a very
+ *       short period of time.
  * 
  *  When a request is released:
  * 
- *    d) If free_requests < batch_requests, do nothing.
- * 
- *    f) If free_requests >= batch_requests, wake up a single waiter.
+ *    c) If free_requests < batch_requests, do nothing.
  * 
- *   The net effect is that when a process is woken at the batch_requests level,
- *   it will be able to take approximately (batch_requests) requests before
- *   blocking again (at the tail of the queue).
- * 
- *   This all assumes that the rate of taking requests is much, much higher
- *   than the rate of releasing them.  Which is very true.
+ *    d) If free_requests >= batch_requests, wake up a single waiter.
  *
- * -akpm, Feb 2002.
+ *   As each waiter gets a request, he wakes another waiter.  We do this
+ *   to prevent a race where an unplug might get run before a request makes
+ *   it's way onto the queue.  The result is a cascade of wakeups, so delaying
+ *   the initial wakeup until we've got batch_requests available helps avoid
+ *   wakeups where there aren't any requests available yet.
  */
 
 static struct request *__get_request_wait(request_queue_t *q, int rw)
@@ -590,21 +649,40 @@
 	register struct request *rq;
 	DECLARE_WAITQUEUE(wait, current);
 
-	add_wait_queue(&q->wait_for_requests[rw], &wait);
+	add_wait_queue_exclusive(&q->wait_for_requests, &wait);
+
 	do {
 		set_current_state(TASK_UNINTERRUPTIBLE);
-		generic_unplug_device(q);
-		if (q->rq[rw].count == 0)
-			schedule();
 		spin_lock_irq(&io_request_lock);
-		rq = get_request(q, rw);
+		if (q->full || blk_oversized_queue(q)) {
+			__generic_unplug_device(q);
+			spin_unlock_irq(&io_request_lock);
+			schedule();
+			spin_lock_irq(&io_request_lock);
+		}
+		rq = __get_request(q, rw);
 		spin_unlock_irq(&io_request_lock);
 	} while (rq == NULL);
-	remove_wait_queue(&q->wait_for_requests[rw], &wait);
+	remove_wait_queue(&q->wait_for_requests, &wait);
 	current->state = TASK_RUNNING;
+
+	if (!waitqueue_active(&q->wait_for_requests))
+		clear_full_and_wake(q);
+
 	return rq;
 }
 
+static void get_request_wait_wakeup(request_queue_t *q, int rw)
+{
+	/*
+	 * avoid losing an unplug if a second __get_request_wait did the
+	 * generic_unplug_device while our __get_request_wait was running
+	 * w/o the queue_lock held and w/ our request out of the queue.
+	 */	
+	if (waitqueue_active(&q->wait_for_requests))
+		wake_up(&q->wait_for_requests);
+}
+
 /* RO fail safe mechanism */
 
 static long ro_bits[MAX_BLKDEV][8];
@@ -818,7 +896,6 @@
 void blkdev_release_request(struct request *req)
 {
 	request_queue_t *q = req->q;
-	int rw = req->cmd;
 
 	req->rq_status = RQ_INACTIVE;
 	req->q = NULL;
@@ -828,9 +905,19 @@
 	 * assume it has free buffers and check waiters
 	 */
 	if (q) {
-		list_add(&req->queue, &q->rq[rw].free);
-		if (++q->rq[rw].count >= q->batch_requests)
-			wake_up(&q->wait_for_requests[rw]);
+		int oversized_batch = 0;
+
+		if (q->can_throttle)
+			oversized_batch = blk_oversized_queue_batch(q);
+		q->rq.count++;
+		list_add(&req->queue, &q->rq.free);
+		if (q->rq.count >= q->batch_requests && !oversized_batch) {
+			smp_mb();
+			if (waitqueue_active(&q->wait_for_requests))
+				wake_up(&q->wait_for_requests);
+			else
+				clear_full_and_wake(q);
+		}
 	}
 }
 
@@ -908,6 +995,7 @@
 	struct list_head *head, *insert_here;
 	int latency;
 	elevator_t *elevator = &q->elevator;
+	int should_wake = 0;
 
 	count = bh->b_size >> 9;
 	sector = bh->b_rsector;
@@ -948,7 +1036,6 @@
 	 */
 	max_sectors = get_max_sectors(bh->b_rdev);
 
-again:
 	req = NULL;
 	head = &q->queue_head;
 	/*
@@ -957,7 +1044,9 @@
 	 */
 	spin_lock_irq(&io_request_lock);
 
+again:
 	insert_here = head->prev;
+
 	if (list_empty(head)) {
 		q->plug_device_fn(q, bh->b_rdev); /* is atomic */
 		goto get_rq;
@@ -976,6 +1065,7 @@
 			req->bhtail = bh;
 			req->nr_sectors = req->hard_nr_sectors += count;
 			blk_started_io(count);
+			blk_started_sectors(req, count);
 			drive_stat_acct(req->rq_dev, req->cmd, count, 0);
 			req_new_io(req, 1, count);
 			attempt_back_merge(q, req, max_sectors, max_segments);
@@ -998,6 +1088,7 @@
 			req->sector = req->hard_sector = sector;
 			req->nr_sectors = req->hard_nr_sectors += count;
 			blk_started_io(count);
+			blk_started_sectors(req, count);
 			drive_stat_acct(req->rq_dev, req->cmd, count, 0);
 			req_new_io(req, 1, count);
 			attempt_front_merge(q, head, req, max_sectors, max_segments);
@@ -1030,7 +1121,7 @@
 		 * See description above __get_request_wait()
 		 */
 		if (rw_ahead) {
-			if (q->rq[rw].count < q->batch_requests) {
+			if (q->rq.count < q->batch_requests || blk_oversized_queue_batch(q)) {
 				spin_unlock_irq(&io_request_lock);
 				goto end_io;
 			}
@@ -1042,6 +1133,9 @@
 			if (req == NULL) {
 				spin_unlock_irq(&io_request_lock);
 				freereq = __get_request_wait(q, rw);
+				head = &q->queue_head;
+				spin_lock_irq(&io_request_lock);
+				should_wake = 1;
 				goto again;
 			}
 		}
@@ -1064,10 +1158,13 @@
 	req->start_time = jiffies;
 	req_new_io(req, 0, count);
 	blk_started_io(count);
+	blk_started_sectors(req, count);
 	add_request(q, req, insert_here);
 out:
 	if (freereq)
 		blkdev_release_request(freereq);
+	if (should_wake)
+		get_request_wait_wakeup(q, rw);
 	spin_unlock_irq(&io_request_lock);
 	return 0;
 end_io:
@@ -1196,8 +1293,15 @@
 	bh->b_rdev = bh->b_dev;
 	bh->b_rsector = bh->b_blocknr * count;
 
+	get_bh(bh);
 	generic_make_request(rw, bh);
 
+	/* fix race condition with wait_on_buffer() */
+	smp_mb(); /* spin_unlock may have inclusive semantics */
+	if (waitqueue_active(&bh->b_wait))
+		wake_up(&bh->b_wait);
+
+	put_bh(bh);
 	switch (rw) {
 		case WRITE:
 			kstat.pgpgout += count;
@@ -1350,6 +1454,7 @@
 	if ((bh = req->bh) != NULL) {
 		nsect = bh->b_size >> 9;
 		blk_finished_io(nsect);
+		blk_finished_sectors(req, nsect);
 		req->bh = bh->b_reqnext;
 		bh->b_reqnext = NULL;
 		bh->b_end_io(bh, uptodate);
@@ -1509,6 +1614,7 @@
 EXPORT_SYMBOL(blk_get_queue);
 EXPORT_SYMBOL(blk_cleanup_queue);
 EXPORT_SYMBOL(blk_queue_headactive);
+EXPORT_SYMBOL(blk_queue_throttle_sectors);
 EXPORT_SYMBOL(blk_queue_make_request);
 EXPORT_SYMBOL(generic_make_request);
 EXPORT_SYMBOL(blkdev_release_request);
diff -urN --exclude '*.orig' --exclude '*.rej' parent/drivers/ide/ide-probe.c comp/drivers/ide/ide-probe.c
--- parent/drivers/ide/ide-probe.c	2003-06-25 14:12:09.000000000 -0400
+++ comp/drivers/ide/ide-probe.c	2003-06-25 14:11:55.000000000 -0400
@@ -971,6 +971,7 @@
 
 	q->queuedata = HWGROUP(drive);
 	blk_init_queue(q, do_ide_request);
+	blk_queue_throttle_sectors(q, 1);
 }
 
 #undef __IRQ_HELL_SPIN
diff -urN --exclude '*.orig' --exclude '*.rej' parent/drivers/scsi/scsi.c comp/drivers/scsi/scsi.c
--- parent/drivers/scsi/scsi.c	2003-06-25 14:12:09.000000000 -0400
+++ comp/drivers/scsi/scsi.c	2003-06-25 14:11:55.000000000 -0400
@@ -197,6 +197,7 @@
 
 	blk_init_queue(q, scsi_request_fn);
 	blk_queue_headactive(q, 0);
+	blk_queue_throttle_sectors(q, 1);
 	q->queuedata = (void *) SDpnt;
 }
 
diff -urN --exclude '*.orig' --exclude '*.rej' parent/drivers/scsi/scsi_lib.c comp/drivers/scsi/scsi_lib.c
--- parent/drivers/scsi/scsi_lib.c	2003-06-25 14:12:09.000000000 -0400
+++ comp/drivers/scsi/scsi_lib.c	2003-06-25 14:11:55.000000000 -0400
@@ -378,6 +378,7 @@
 		if ((bh = req->bh) != NULL) {
 			nsect = bh->b_size >> 9;
 			blk_finished_io(nsect);
+			blk_finished_sectors(req, nsect);
 			req->bh = bh->b_reqnext;
 			bh->b_reqnext = NULL;
 			sectors -= nsect;
diff -urN --exclude '*.orig' --exclude '*.rej' parent/fs/buffer.c comp/fs/buffer.c
--- parent/fs/buffer.c	2003-06-25 14:12:09.000000000 -0400
+++ comp/fs/buffer.c	2003-06-25 14:11:53.000000000 -0400
@@ -153,10 +153,23 @@
 	get_bh(bh);
 	add_wait_queue(&bh->b_wait, &wait);
 	do {
-		run_task_queue(&tq_disk);
 		set_task_state(tsk, TASK_UNINTERRUPTIBLE);
 		if (!buffer_locked(bh))
 			break;
+		/*
+		 * We must read tq_disk in TQ_ACTIVE after the
+		 * add_wait_queue effect is visible to other cpus.
+		 * We could unplug some line above it wouldn't matter
+		 * but we can't do that right after add_wait_queue
+		 * without an smp_mb() in between because spin_unlock
+		 * has inclusive semantics.
+		 * Doing it here is the most efficient place so we
+		 * don't do a suprious unplug if we get a racy
+		 * wakeup that make buffer_locked to return 0, and
+		 * doing it here avoids an explicit smp_mb() we
+		 * rely on the implicit one in set_task_state.
+		 */
+		run_task_queue(&tq_disk);
 		schedule();
 	} while (buffer_locked(bh));
 	tsk->state = TASK_RUNNING;
@@ -1523,6 +1536,9 @@
 
 	/* Done - end_buffer_io_async will unlock */
 	SetPageUptodate(page);
+
+	wakeup_page_waiters(page);
+
 	return 0;
 
 out:
@@ -1554,6 +1570,7 @@
 	} while (bh != head);
 	if (need_unlock)
 		UnlockPage(page);
+	wakeup_page_waiters(page);
 	return err;
 }
 
@@ -1781,6 +1798,8 @@
 		else
 			submit_bh(READ, bh);
 	}
+
+	wakeup_page_waiters(page);
 	
 	return 0;
 }
@@ -2394,6 +2413,7 @@
 		submit_bh(rw, bh);
 		bh = next;
 	} while (bh != head);
+	wakeup_page_waiters(page);
 	return 0;
 }
 
diff -urN --exclude '*.orig' --exclude '*.rej' parent/fs/reiserfs/inode.c comp/fs/reiserfs/inode.c
--- parent/fs/reiserfs/inode.c	2003-06-25 14:12:09.000000000 -0400
+++ comp/fs/reiserfs/inode.c	2003-06-25 14:11:53.000000000 -0400
@@ -2209,6 +2209,7 @@
     */
     if (nr) {
         submit_bh_for_writepage(arr, nr) ;
+	wakeup_page_waiters(page);
     } else {
         UnlockPage(page) ;
     }
diff -urN --exclude '*.orig' --exclude '*.rej' parent/include/linux/blkdev.h comp/include/linux/blkdev.h
--- parent/include/linux/blkdev.h	2003-06-25 14:12:09.000000000 -0400
+++ comp/include/linux/blkdev.h	2003-06-25 14:11:56.000000000 -0400
@@ -64,12 +64,6 @@
 typedef void (plug_device_fn) (request_queue_t *q, kdev_t device);
 typedef void (unplug_device_fn) (void *q);
 
-/*
- * Default nr free requests per queue, ll_rw_blk will scale it down
- * according to available RAM at init time
- */
-#define QUEUE_NR_REQUESTS	8192
-
 struct request_list {
 	unsigned int count;
 	struct list_head free;
@@ -80,7 +74,7 @@
 	/*
 	 * the queue request freelist, one for reads and one for writes
 	 */
-	struct request_list	rq[2];
+	struct request_list	rq;
 
 	/*
 	 * The total number of requests on each queue
@@ -93,6 +87,21 @@
 	int batch_requests;
 
 	/*
+	 * The total number of 512byte blocks on each queue
+	 */
+	atomic_t nr_sectors;
+
+	/*
+	 * Batching threshold for sleep/wakeup decisions
+	 */
+	int batch_sectors;
+
+	/*
+	 * The max number of 512byte blocks on each queue
+	 */
+	int max_queue_sectors;
+
+	/*
 	 * Together with queue_head for cacheline sharing
 	 */
 	struct list_head	queue_head;
@@ -118,13 +127,28 @@
 	/*
 	 * Boolean that indicates whether this queue is plugged or not.
 	 */
-	char			plugged;
+	int			plugged:1;
 
 	/*
 	 * Boolean that indicates whether current_request is active or
 	 * not.
 	 */
-	char			head_active;
+	int			head_active:1;
+
+	/*
+	 * Booleans that indicate whether the queue's free requests have
+	 * been exhausted and is waiting to drop below the batch_requests
+	 * threshold
+	 */
+	int			full:1;
+	
+	/*
+	 * Boolean that indicates you will use blk_started_sectors
+	 * and blk_finished_sectors in addition to blk_started_io
+	 * and blk_finished_io.  It enables the throttling code to 
+	 * help keep the size of the in sectors to a reasonable number
+	 */
+	int			can_throttle:1;
 
 	unsigned long		bounce_pfn;
 
@@ -137,7 +161,7 @@
 	/*
 	 * Tasks wait here for free read and write requests
 	 */
-	wait_queue_head_t	wait_for_requests[2];
+	wait_queue_head_t	wait_for_requests;
 };
 
 #define blk_queue_plugged(q)	(q)->plugged
@@ -217,14 +241,16 @@
 extern void generic_make_request(int rw, struct buffer_head * bh);
 extern inline request_queue_t *blk_get_queue(kdev_t dev);
 extern void blkdev_release_request(struct request *);
+extern void blk_print_stats(kdev_t dev);
 
 /*
  * Access functions for manipulating queue properties
  */
-extern int blk_grow_request_list(request_queue_t *q, int nr_requests);
+extern int blk_grow_request_list(request_queue_t *q, int nr_requests, int max_queue_sectors);
 extern void blk_init_queue(request_queue_t *, request_fn_proc *);
 extern void blk_cleanup_queue(request_queue_t *);
 extern void blk_queue_headactive(request_queue_t *, int);
+extern void blk_queue_throttle_sectors(request_queue_t *, int);
 extern void blk_queue_make_request(request_queue_t *, make_request_fn *);
 extern void generic_unplug_device(void *);
 extern inline int blk_seg_merge_ok(struct buffer_head *, struct buffer_head *);
@@ -243,6 +269,8 @@
 
 #define MAX_SEGMENTS 128
 #define MAX_SECTORS 255
+#define MAX_QUEUE_SECTORS (2 << (20 - 9)) /* 2 mbytes when full sized */
+#define MAX_NR_REQUESTS 1024 /* 1024k when in 512 units, normally min is 1M in 1k units */
 
 #define PageAlignSize(size) (((size) + PAGE_SIZE -1) & PAGE_MASK)
 
@@ -268,9 +296,51 @@
 	return retval;
 }
 
+static inline int blk_oversized_queue(request_queue_t * q)
+{
+	if (q->can_throttle)
+		return atomic_read(&q->nr_sectors) > q->max_queue_sectors;
+	return q->rq.count == 0;
+}
+
+static inline int blk_oversized_queue_batch(request_queue_t * q)
+{
+	return atomic_read(&q->nr_sectors) > q->max_queue_sectors - q->batch_sectors;
+}
+
 #define blk_finished_io(nsects)	do { } while (0)
 #define blk_started_io(nsects)	do { } while (0)
 
+static inline void blk_started_sectors(struct request *rq, int count)
+{
+	request_queue_t *q = rq->q;
+	if (q && q->can_throttle) {
+		atomic_add(count, &q->nr_sectors);
+		if (atomic_read(&q->nr_sectors) < 0) {
+			printk("nr_sectors is %d\n", atomic_read(&q->nr_sectors));
+			BUG();
+		}
+	}
+}
+
+static inline void blk_finished_sectors(struct request *rq, int count)
+{
+	request_queue_t *q = rq->q;
+	if (q && q->can_throttle) {
+		atomic_sub(count, &q->nr_sectors);
+		
+		smp_mb();
+		if (q->rq.count >= q->batch_requests && !blk_oversized_queue_batch(q)) {
+			if (waitqueue_active(&q->wait_for_requests))
+				wake_up(&q->wait_for_requests);
+		}
+		if (atomic_read(&q->nr_sectors) < 0) {
+			printk("nr_sectors is %d\n", atomic_read(&q->nr_sectors));
+			BUG();
+		}
+	}
+}
+
 static inline unsigned int blksize_bits(unsigned int size)
 {
 	unsigned int bits = 8;
diff -urN --exclude '*.orig' --exclude '*.rej' parent/include/linux/elevator.h comp/include/linux/elevator.h
--- parent/include/linux/elevator.h	2003-06-25 14:12:09.000000000 -0400
+++ comp/include/linux/elevator.h	2003-06-25 14:11:55.000000000 -0400
@@ -80,7 +80,7 @@
 	return latency;
 }
 
-#define ELV_LINUS_SEEK_COST	16
+#define ELV_LINUS_SEEK_COST	1
 
 #define ELEVATOR_NOOP							\
 ((elevator_t) {								\
@@ -93,8 +93,8 @@
 
 #define ELEVATOR_LINUS							\
 ((elevator_t) {								\
-	2048,				/* read passovers */		\
-	8192,				/* write passovers */		\
+	128,				/* read passovers */		\
+	512,				/* write passovers */		\
 									\
 	elevator_linus_merge,		/* elevator_merge_fn */		\
 	elevator_linus_merge_req,	/* elevator_merge_req_fn */	\
diff -urN --exclude '*.orig' --exclude '*.rej' parent/include/linux/pagemap.h comp/include/linux/pagemap.h
--- parent/include/linux/pagemap.h	2003-06-25 14:12:09.000000000 -0400
+++ comp/include/linux/pagemap.h	2003-06-25 14:11:53.000000000 -0400
@@ -97,6 +97,8 @@
 		___wait_on_page(page);
 }
 
+extern void FASTCALL(wakeup_page_waiters(struct page * page));
+
 /*
  * Returns locked page at given index in given cache, creating it if needed.
  */
diff -urN --exclude '*.orig' --exclude '*.rej' parent/kernel/ksyms.c comp/kernel/ksyms.c
--- parent/kernel/ksyms.c	2003-06-25 14:12:09.000000000 -0400
+++ comp/kernel/ksyms.c	2003-06-25 14:11:53.000000000 -0400
@@ -296,6 +296,7 @@
 EXPORT_SYMBOL(filemap_fdatawait);
 EXPORT_SYMBOL(lock_page);
 EXPORT_SYMBOL(unlock_page);
+EXPORT_SYMBOL(wakeup_page_waiters);
 
 /* device registration */
 EXPORT_SYMBOL(register_chrdev);
diff -urN --exclude '*.orig' --exclude '*.rej' parent/mm/filemap.c comp/mm/filemap.c
--- parent/mm/filemap.c	2003-06-25 14:12:09.000000000 -0400
+++ comp/mm/filemap.c	2003-06-25 14:11:53.000000000 -0400
@@ -812,6 +812,20 @@
 	return &wait[hash];
 }
 
+/*
+ * This must be called after every submit_bh with end_io
+ * callbacks that would result into the blkdev layer waking
+ * up the page after a queue unplug.
+ */
+void wakeup_page_waiters(struct page * page)
+{
+	wait_queue_head_t * head;
+
+	head = page_waitqueue(page);
+	if (waitqueue_active(head))
+		wake_up(head);
+}
+
 /* 
  * Wait for a page to get unlocked.
  *

--=-dsiFzHBRiC/AmwfTw+sI--

