Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291473AbSBHIrW>; Fri, 8 Feb 2002 03:47:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291474AbSBHIrN>; Fri, 8 Feb 2002 03:47:13 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:15 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S291473AbSBHIrD>;
	Fri, 8 Feb 2002 03:47:03 -0500
Message-ID: <3C639060.A68A42CA@zip.com.au>
Date: Fri, 08 Feb 2002 00:46:24 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18-pre7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rik van Riel <riel@conectiva.com.br>,
        William Lee Irwin III <wli@holomorphy.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: [patch] get_request starvation fix
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's a patch which addresses the get_request starvation problem.

The problem we're experiencing is that when the request queue is
exhausted, processes go to sleep until the request queue has refilled
to the batch_nr_requests level.  But already-running tasks can simply
whizz in and steal free requests, thus preventing the sleeping tasks
from getting woken.

Some instrumentation illustrates this clearly.  All testing was on
ext2.  In a `dbench 64' run on stock 2.4.18-pre9, the maximum sleep
duration in __get_request_wait() was 37 seconds, and it's being very
unfair.  Look at this section of the trace:

Feb  7 21:59:06 mnm kernel: dbench[883] wakes after 442ms
Feb  7 21:59:06 mnm kernel: dbench[877] wakes after 442ms
Feb  7 21:59:06 mnm kernel: dbench[868] wakes after 441ms
Feb  7 21:59:06 mnm kernel: kupdated[7] wakes after 11587ms
Feb  7 21:59:06 mnm kernel: dbench[914] wakes after 574ms
Feb  7 21:59:06 mnm kernel: dbench[873] wakes after 2618ms
Feb  7 21:59:06 mnm kernel: dbench[927] wakes after 755ms
Feb  7 21:59:06 mnm kernel: dbench[873] wakes after 263ms
Feb  7 21:59:06 mnm kernel: dbench[924] wakes after 838ms
Feb  7 21:59:06 mnm kernel: dbench[924] wakes after 134ms
Feb  7 21:59:06 mnm kernel: dbench[871] wakes after 18688ms
Feb  7 21:59:06 mnm kernel: dbench[908] wakes after 3245ms
Feb  7 21:59:06 mnm kernel: dbench[895] wakes after 974ms
Feb  7 21:59:06 mnm kernel: dbench[878] wakes after 27401ms
Feb  7 21:59:06 mnm kernel: dbench[895] wakes after 278ms
Feb  7 21:59:06 mnm kernel: dbench[904] wakes after 278ms

With the patch applied, the maximum sleep duration was eight seconds,
but when this was happening, *all* tasks were sleeping for similar
durations:

Feb  7 23:55:40 mnm kernel: dbench[948] wakes after 3978ms
Feb  7 23:55:40 mnm kernel: dbench[935] wakes after 3439ms
Feb  7 23:55:41 mnm kernel: dbench[955] wakes after 2998ms
Feb  7 23:55:41 mnm kernel: dbench[965] wakes after 2847ms
Feb  7 23:55:41 mnm kernel: dbench[994] wakes after 3032ms
Feb  7 23:55:41 mnm kernel: dbench[969] wakes after 2652ms
Feb  7 23:55:41 mnm kernel: dbench[956] wakes after 2197ms
Feb  7 23:55:41 mnm kernel: dbench[993] wakes after 1589ms
Feb  7 23:55:41 mnm kernel: dbench[990] wakes after 1590ms
Feb  7 23:55:41 mnm kernel: dbench[939] wakes after 1585ms
Feb  7 23:55:41 mnm kernel: kupdated[7] wakes after 1555ms
Feb  7 23:55:41 mnm kernel: dbench[976] wakes after 1787ms
Feb  7 23:55:41 mnm kernel: dbench[997] wakes after 1653ms
Feb  7 23:55:41 mnm kernel: dbench[961] wakes after 1891ms
Feb  7 23:55:42 mnm kernel: dbench[966] wakes after 1967ms
Feb  7 23:55:42 mnm kernel: dbench[936] wakes after 1339ms
Feb  7 23:55:42 mnm kernel: dbench[965] wakes after 1216ms
Feb  7 23:55:42 mnm kernel: kjournald[9] wakes after 1253ms
Feb  7 23:55:42 mnm kernel: dbench[990] wakes after 879ms
Feb  7 23:55:42 mnm kernel: kupdated[7] wakes after 849ms
Feb  7 23:55:42 mnm kernel: dbench[959] wakes after 343ms
Feb  7 23:55:42 mnm kernel: dbench[936] wakes after 343ms
Feb  7 23:55:42 mnm kernel: dbench[964] wakes after 492ms
Feb  7 23:55:42 mnm kernel: dbench[966] wakes after 648ms
Feb  7 23:55:42 mnm kernel: kupdated[7] wakes after 413ms
Feb  7 23:55:42 mnm kernel: dbench[988] wakes after 344ms



The actual algorithm I chose is described in the patch.  It is
noteworthy that the wakeup strategy has changed from wake-all to
wake-one, which should save a few cycles.  The number of context
switches during the entire dbench 64 run fell from 57,000 to
29,000.

Interestingly, dbench runtimes are still very inconsistent, and
many clients still exit quite early in the run.  Beats me.

Rik, this patch will conflict with read-latency2 in the init code. 
Easily fixable.  I haven't tested with the larger request queue, but I
suggest that we want to keep the 1024 requests, a high-water mark of
queue_nr_requests/4 and a low-water mark of queue_nr_requests/8.  I'll
do more testing tomorrow.

Also, you noted the other day that a LILO run *never* terminated when
there was a dbench running.  This is in fact not due to request
starvation.  It's due to livelock in invalidate_bdev(), which is called
via ioctl(BLKFLSBUF) by LILO.  invalidate_bdev() will never terminate
as long as another task is generating locked buffers against the
device.


--- linux-2.4.18-pre9/drivers/block/ll_rw_blk.c	Thu Feb  7 13:04:11 2002
+++ linux-akpm/drivers/block/ll_rw_blk.c	Fri Feb  8 00:33:01 2002
@@ -118,10 +118,15 @@ int * max_readahead[MAX_BLKDEV];
 int * max_sectors[MAX_BLKDEV];
 
 /*
- * How many reqeusts do we allocate per queue,
- * and how many do we "batch" on freeing them?
+ * The total number of requests in each queue.
  */
-static int queue_nr_requests, batch_requests;
+static int queue_nr_requests;
+
+/*
+ * low- and high-water marks for the queues.
+ */
+static int batch_requests_low;
+static int batch_requests_high;
 
 static inline int get_max_sectors(kdev_t dev)
 {
@@ -418,9 +423,9 @@ void blk_init_queue(request_queue_t * q,
 #define blkdev_free_rq(list) list_entry((list)->next, struct request, queue);
 /*
  * Get a free request. io_request_lock must be held and interrupts
- * disabled on the way in.
+ * disabled on the way in.  Returns NULL if there are no free requests.
  */
-static inline struct request *get_request(request_queue_t *q, int rw)
+static struct request *get_request(request_queue_t *q, int rw)
 {
 	struct request *rq = NULL;
 	struct request_list *rl = q->rq + rw;
@@ -438,18 +443,81 @@ static inline struct request *get_reques
 }
 
 /*
- * No available requests for this queue, unplug the device.
+ * Here's the request allocation design:
+ *
+ * 1: Blocking on request exhaustion is a key part of I/O throttling.
+ * 
+ * 2: We want to be `fair' to all requesters.  We must avoid starvation, and
+ *    attempt to ensure that all requesters sleep for a similar duration.  Hence
+ *    no stealing requests when there are other processes waiting.
+ * 
+ * 3: We also wish to support `batching' of requests.  So when a process is
+ *    woken, we want to allow it to allocate a decent number of requests
+ *    before it blocks again, so they can be nicely merged (this only really
+ *    matters if the process happens to be adding requests near the head of
+ *    the queue).
+ * 
+ * 4: We want to avoid scheduling storms.  This isn't really important, because
+ *    the system will be I/O bound anyway.  But it's easy.
+ * 
+ *    There is tension between requirements 2 and 3.  Once a task has woken,
+ *    we don't want to allow it to sleep as soon as it takes its second request.
+ *    But we don't want currently-running tasks to steal all the requests
+ *    from the sleepers.  We handle this with high- and low- water marks and
+ *    with the assumption that request taking is much, much faster than
+ *    request freeing.
+ * 
+ * So here's what we do:
+ * 
+ *    a) A READA requester fails if free_requests < batch_requests_high
+ * 
+ *       We don't want READA requests to prevent sleepers from ever
+ *       waking.
+ * 
+ *  When a process wants a new request:
+ * 
+ *    b) If someone else is waiting on requests and free_requests < low_water,
+ *       the requester sleeps in FIFO manner.
+ * 
+ *    c) If low_water < free_requests < high_water, the caller is immediately
+ *       granted a new request.
+ * 
+ *    d) If nobody is waiting on requests, the caller gets given a request,
+ *       if there are any available.  Otherwise the caller sleeps.
+ * 
+ *  When a request is released:
+ * 
+ *    e) If free_requests < low_water, do nothing.
+ * 
+ *    f) If free_requests > high_water, wake up a single waiter.
+ * 
+ *   The net effect is that when a process is woken at the high-water mark,
+ *   it will be able to take approximately (high-water - low-water) requests
+ *   before blocking again (at the tail of the queue).
+ * 
+ *   This all assumes that the rate of taking requests is much, much higher
+ *   than the rate of releasing them.  Which is very true.
+ *
+ * -akpm, Feb 2002.
  */
+#undef REQTIMING
 static struct request *__get_request_wait(request_queue_t *q, int rw)
 {
 	register struct request *rq;
 	DECLARE_WAITQUEUE(wait, current);
 
+#ifdef REQTIMING
+	struct timeval tv1, tv2;
+	unsigned long long t1, t2;
+	unsigned long t;
+	do_gettimeofday(&tv1);
+#endif
+
 	generic_unplug_device(q);
-	add_wait_queue(&q->wait_for_request, &wait);
+	add_wait_queue_exclusive(&q->wait_for_request, &wait);
 	do {
 		set_current_state(TASK_UNINTERRUPTIBLE);
-		if (q->rq[rw].count < batch_requests)
+		if (q->rq[rw].count < batch_requests_low)
 			schedule();
 		spin_lock_irq(&io_request_lock);
 		rq = get_request(q,rw);
@@ -457,19 +525,20 @@ static struct request *__get_request_wai
 	} while (rq == NULL);
 	remove_wait_queue(&q->wait_for_request, &wait);
 	current->state = TASK_RUNNING;
-	return rq;
-}
 
-static inline struct request *get_request_wait(request_queue_t *q, int rw)
-{
-	register struct request *rq;
-
-	spin_lock_irq(&io_request_lock);
-	rq = get_request(q, rw);
-	spin_unlock_irq(&io_request_lock);
-	if (rq)
-		return rq;
-	return __get_request_wait(q, rw);
+#ifdef REQTIMING
+	do_gettimeofday(&tv2);
+	t1 = tv1.tv_sec;
+	t1 *= 1000000;
+	t1 += tv1.tv_usec;
+	t2 = tv2.tv_sec;
+	t2 *= 1000000;
+	t2 += tv2.tv_usec;
+	t = t2 - t1;
+	printk("%s[%d] wakes after %ldms\n", current->comm,
+			current->pid, t / 1000);
+#endif
+	return rq;
 }
 
 /* RO fail safe mechanism */
@@ -546,7 +615,7 @@ static inline void add_request(request_q
 /*
  * Must be called with io_request_lock held and interrupts disabled
  */
-inline void blkdev_release_request(struct request *req)
+void blkdev_release_request(struct request *req)
 {
 	request_queue_t *q = req->q;
 	int rw = req->cmd;
@@ -560,7 +629,8 @@ inline void blkdev_release_request(struc
 	 */
 	if (q) {
 		list_add(&req->queue, &q->rq[rw].free);
-		if (++q->rq[rw].count >= batch_requests && waitqueue_active(&q->wait_for_request))
+		if (++q->rq[rw].count >= batch_requests_high &&
+				waitqueue_active(&q->wait_for_request))
 			wake_up(&q->wait_for_request);
 	}
 }
@@ -742,22 +812,41 @@ again:
 			BUG();
 	}
 		
-	/*
-	 * Grab a free request from the freelist - if that is empty, check
-	 * if we are doing read ahead and abort instead of blocking for
-	 * a free slot.
-	 */
 get_rq:
 	if (freereq) {
 		req = freereq;
 		freereq = NULL;
-	} else if ((req = get_request(q, rw)) == NULL) {
-		spin_unlock_irq(&io_request_lock);
-		if (rw_ahead)
-			goto end_io;
-
-		freereq = __get_request_wait(q, rw);
-		goto again;
+	} else {
+		/*
+		 * See description above __get_request_wait()
+		 */
+		if (rw_ahead) {
+			if (q->rq[rw].count < batch_requests_high) {
+				spin_unlock_irq(&io_request_lock);
+				goto end_io;
+			}
+			req = get_request(q, rw);
+			if (req == NULL)
+				BUG();
+		} else {
+			if (waitqueue_active(&q->wait_for_request)) {
+				if (q->rq[rw].count < batch_requests_low) {
+					spin_unlock_irq(&io_request_lock);
+					freereq = __get_request_wait(q, rw);
+					goto again;
+				}
+				req = get_request(q, rw);
+				if (req == NULL)
+					BUG();
+			} else {
+				req = get_request(q, rw);
+				if (req == NULL) {
+					spin_unlock_irq(&io_request_lock);
+					freereq = __get_request_wait(q, rw);
+					goto again;
+				}
+			}
+		}
 	}
 
 /* fill up the request-info, and add it to the queue */
@@ -1124,8 +1213,10 @@ int __init blk_dev_init(void)
 	/*
 	 * Batch frees according to queue length
 	 */
-	batch_requests = queue_nr_requests/4;
-	printk("block: %d slots per queue, batch=%d\n", queue_nr_requests, batch_requests);
+	batch_requests_high = queue_nr_requests / 4;
+	batch_requests_low = batch_requests_high / 2;
+	printk("block: %d slots per queue, batch_low=%d, batch_high=%d\n",
+		queue_nr_requests, batch_requests_low, batch_requests_high);
 
 #ifdef CONFIG_AMIGA_Z2RAM
 	z2_init();
