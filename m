Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265176AbTGCRyY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 13:54:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265172AbTGCRyY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 13:54:24 -0400
Received: from 69-55-72-144.ppp.netsville.net ([69.55.72.144]:12969 "EHLO
	tiny.suse.com") by vger.kernel.org with ESMTP id S265219AbTGCRxg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 13:53:36 -0400
Subject: Re: Status of the IO scheduler fixes for 2.4
From: Chris Mason <mason@suse.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: lkml <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Andrea Arcangeli <andrea@suse.de>, Nick Piggin <piggin@cyberone.com.au>
In-Reply-To: <Pine.LNX.4.55L.0307021927370.12077@freak.distro.conectiva>
References: <Pine.LNX.4.55L.0307021923260.12077@freak.distro.conectiva>
	 <Pine.LNX.4.55L.0307021927370.12077@freak.distro.conectiva>
Content-Type: multipart/mixed; boundary="=-ynLPb4PWRj5gEDg9gFnk"
Organization: 
Message-Id: <1057255632.20903.1198.camel@tiny.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 03 Jul 2003 14:07:14 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ynLPb4PWRj5gEDg9gFnk
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, 2003-07-02 at 18:28, Marcelo Tosatti wrote:
> On Wed, 2 Jul 2003, Marcelo Tosatti wrote:
> 
> >
> > Hello people,
> >
> > What is the status of the IO scheduler fixes for increased fairness for
> > 2.4 ?
> >
> > I haven't had time to read and think about everything you guys discussed,
> > so a brief summary would be very helpful for me.

Ok, based on mail from Andrea, it seems like reusing the existing
elvtune ioctl is the way to go for now.  The patch below uses
max_bomb_segments for two things.

1) the number of sectors allowed on a given request queue before new io
triggers an unplug (q->max_queue_sectors)

2) to enable or disable q->full checks.  If max_bomb_segments is odd, it
means the q->full checks are on, even means they are off.

The ioctl code on the kernel side is setup to allow this:

elvtune -b 1 /dev/xxx 
elvtune -b 0 /dev/xxx

For just switching q->full on and off without changing
q->max_queue_sectors.

elvtune -b 8192 /dev/xxx will get you the current default behavior (4MB
in flight, q->full checks off)

-chris

--=-ynLPb4PWRj5gEDg9gFnk
Content-Disposition: attachment; filename=io-stalls-9.diff
Content-Type: text/plain; name=io-stalls-9.diff; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

diff -Nru a/drivers/block/blkpg.c b/drivers/block/blkpg.c
--- a/drivers/block/blkpg.c	Thu Jul  3 14:02:50 2003
+++ b/drivers/block/blkpg.c	Thu Jul  3 14:02:50 2003
@@ -261,10 +261,10 @@
 			return blkpg_ioctl(dev, (struct blkpg_ioctl_arg *) arg);
 			
 		case BLKELVGET:
-			return blkelvget_ioctl(&blk_get_queue(dev)->elevator,
+			return blkelvget_ioctl(blk_get_queue(dev),
 					       (blkelv_ioctl_arg_t *) arg);
 		case BLKELVSET:
-			return blkelvset_ioctl(&blk_get_queue(dev)->elevator,
+			return blkelvset_ioctl(blk_get_queue(dev),
 					       (blkelv_ioctl_arg_t *) arg);
 
 		case BLKBSZGET:
diff -Nru a/drivers/block/elevator.c b/drivers/block/elevator.c
--- a/drivers/block/elevator.c	Thu Jul  3 14:02:50 2003
+++ b/drivers/block/elevator.c	Thu Jul  3 14:02:50 2003
@@ -180,23 +180,28 @@
 
 void elevator_noop_merge_req(struct request *req, struct request *next) {}
 
-int blkelvget_ioctl(elevator_t * elevator, blkelv_ioctl_arg_t * arg)
+int blkelvget_ioctl(request_queue_t *q, blkelv_ioctl_arg_t * arg)
 {
+	elevator_t *elevator = &q->elevator;
 	blkelv_ioctl_arg_t output;
 
 	output.queue_ID			= elevator->queue_ID;
 	output.read_latency		= elevator->read_latency;
 	output.write_latency		= elevator->write_latency;
-	output.max_bomb_segments	= 0;
-
+	output.max_bomb_segments	= q->max_queue_sectors;
+	if (q->low_latency)
+		output.max_bomb_segments |= MAX_BOMB_LATENCY_MASK;	
+	else
+		output.max_bomb_segments &= ~MAX_BOMB_LATENCY_MASK;	
 	if (copy_to_user(arg, &output, sizeof(blkelv_ioctl_arg_t)))
 		return -EFAULT;
 
 	return 0;
 }
 
-int blkelvset_ioctl(elevator_t * elevator, const blkelv_ioctl_arg_t * arg)
+int blkelvset_ioctl(request_queue_t *q, const blkelv_ioctl_arg_t * arg)
 {
+	elevator_t *elevator = &q->elevator;
 	blkelv_ioctl_arg_t input;
 
 	if (copy_from_user(&input, arg, sizeof(blkelv_ioctl_arg_t)))
@@ -206,9 +211,19 @@
 		return -EINVAL;
 	if (input.write_latency < 0)
 		return -EINVAL;
+	if (input.max_bomb_segments < 0)
+		return -EINVAL;
 
 	elevator->read_latency		= input.read_latency;
 	elevator->write_latency		= input.write_latency;
+	q->low_latency = input.max_bomb_segments & MAX_BOMB_LATENCY_MASK ? 1:0;
+	printk("queue %d: low latency mode is now %s\n", elevator->queue_ID, 
+		q->low_latency ? "on" : "off");
+	input.max_bomb_segments &= ~MAX_BOMB_LATENCY_MASK;
+	if (input.max_bomb_segments)
+		q->max_queue_sectors = input.max_bomb_segments;
+	printk("queue %d: max queue sectors is now %d\n", elevator->queue_ID, 
+		q->max_queue_sectors);
 	return 0;
 }
 
diff -Nru a/drivers/block/ll_rw_blk.c b/drivers/block/ll_rw_blk.c
--- a/drivers/block/ll_rw_blk.c	Thu Jul  3 14:02:50 2003
+++ b/drivers/block/ll_rw_blk.c	Thu Jul  3 14:02:50 2003
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
@@ -360,8 +379,22 @@
 {
 	if (q->plugged) {
 		q->plugged = 0;
-		if (!list_empty(&q->queue_head))
+		if (!list_empty(&q->queue_head)) {
+
+			/* we don't want merges later on to come in 
+			 * and significantly increase the amount of
+			 * work during an unplug, it can lead to high
+			 * latencies while some poor waiter tries to
+			 * run an ever increasing chunk of io.
+			 * This does lower throughput some though.
+			 */
+			if (q->low_latency) {
+				struct request *rq;
+				rq = blkdev_entry_prev_request(&q->queue_head),
+				rq->elevator_sequence = 0;
+			}
 			q->request_fn(q);
+		}
 	}
 }
 
@@ -389,7 +422,7 @@
  *
  * Returns the (new) number of requests which the queue has available.
  */
-int blk_grow_request_list(request_queue_t *q, int nr_requests)
+int blk_grow_request_list(request_queue_t *q, int nr_requests, int max_queue_sectors)
 {
 	unsigned long flags;
 	/* Several broken drivers assume that this function doesn't sleep,
@@ -399,21 +432,34 @@
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
@@ -422,23 +468,27 @@
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
 
@@ -491,6 +541,10 @@
 	q->plug_tq.routine	= &generic_unplug_device;
 	q->plug_tq.data		= q;
 	q->plugged        	= 0;
+	q->full			= 0;
+	q->can_throttle		= 0;
+	q->low_latency		= 0;
+
 	/*
 	 * These booleans describe the queue properties.  We set the
 	 * default (and most common) values here.  Other drivers can
@@ -508,12 +562,13 @@
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
@@ -521,35 +576,47 @@
 		rq->cmd = rw;
 		rq->special = NULL;
 		rq->q = q;
-	}
-
+	} else if (q->low_latency)
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
@@ -561,50 +628,67 @@
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
 {
 	register struct request *rq;
 	DECLARE_WAITQUEUE(wait, current);
+	int oversized;
+
+	add_wait_queue_exclusive(&q->wait_for_requests, &wait);
 
-	add_wait_queue(&q->wait_for_requests[rw], &wait);
 	do {
 		set_current_state(TASK_UNINTERRUPTIBLE);
-		generic_unplug_device(q);
-		if (q->rq[rw].count == 0)
-			schedule();
 		spin_lock_irq(&io_request_lock);
-		rq = get_request(q, rw);
+		oversized = blk_oversized_queue(q);
+		if (q->full || oversized) {
+			if (oversized)
+				__generic_unplug_device(q);
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
@@ -818,7 +902,6 @@
 void blkdev_release_request(struct request *req)
 {
 	request_queue_t *q = req->q;
-	int rw = req->cmd;
 
 	req->rq_status = RQ_INACTIVE;
 	req->q = NULL;
@@ -828,9 +911,19 @@
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
 
@@ -908,6 +1001,7 @@
 	struct list_head *head, *insert_here;
 	int latency;
 	elevator_t *elevator = &q->elevator;
+	int should_wake = 0;
 
 	count = bh->b_size >> 9;
 	sector = bh->b_rsector;
@@ -948,7 +1042,6 @@
 	 */
 	max_sectors = get_max_sectors(bh->b_rdev);
 
-again:
 	req = NULL;
 	head = &q->queue_head;
 	/*
@@ -957,7 +1050,9 @@
 	 */
 	spin_lock_irq(&io_request_lock);
 
+again:
 	insert_here = head->prev;
+
 	if (list_empty(head)) {
 		q->plug_device_fn(q, bh->b_rdev); /* is atomic */
 		goto get_rq;
@@ -976,6 +1071,7 @@
 			req->bhtail = bh;
 			req->nr_sectors = req->hard_nr_sectors += count;
 			blk_started_io(count);
+			blk_started_sectors(req, count);
 			drive_stat_acct(req->rq_dev, req->cmd, count, 0);
 			req_new_io(req, 1, count);
 			attempt_back_merge(q, req, max_sectors, max_segments);
@@ -998,6 +1094,7 @@
 			req->sector = req->hard_sector = sector;
 			req->nr_sectors = req->hard_nr_sectors += count;
 			blk_started_io(count);
+			blk_started_sectors(req, count);
 			drive_stat_acct(req->rq_dev, req->cmd, count, 0);
 			req_new_io(req, 1, count);
 			attempt_front_merge(q, head, req, max_sectors, max_segments);
@@ -1030,7 +1127,7 @@
 		 * See description above __get_request_wait()
 		 */
 		if (rw_ahead) {
-			if (q->rq[rw].count < q->batch_requests) {
+			if (q->rq.count < q->batch_requests || blk_oversized_queue_batch(q)) {
 				spin_unlock_irq(&io_request_lock);
 				goto end_io;
 			}
@@ -1042,6 +1139,9 @@
 			if (req == NULL) {
 				spin_unlock_irq(&io_request_lock);
 				freereq = __get_request_wait(q, rw);
+				head = &q->queue_head;
+				spin_lock_irq(&io_request_lock);
+				should_wake = 1;
 				goto again;
 			}
 		}
@@ -1064,10 +1164,13 @@
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
@@ -1196,8 +1299,15 @@
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
@@ -1350,6 +1460,7 @@
 	if ((bh = req->bh) != NULL) {
 		nsect = bh->b_size >> 9;
 		blk_finished_io(nsect);
+		blk_finished_sectors(req, nsect);
 		req->bh = bh->b_reqnext;
 		bh->b_reqnext = NULL;
 		bh->b_end_io(bh, uptodate);
@@ -1509,6 +1620,7 @@
 EXPORT_SYMBOL(blk_get_queue);
 EXPORT_SYMBOL(blk_cleanup_queue);
 EXPORT_SYMBOL(blk_queue_headactive);
+EXPORT_SYMBOL(blk_queue_throttle_sectors);
 EXPORT_SYMBOL(blk_queue_make_request);
 EXPORT_SYMBOL(generic_make_request);
 EXPORT_SYMBOL(blkdev_release_request);
diff -Nru a/drivers/ide/ide-probe.c b/drivers/ide/ide-probe.c
--- a/drivers/ide/ide-probe.c	Thu Jul  3 14:02:50 2003
+++ b/drivers/ide/ide-probe.c	Thu Jul  3 14:02:50 2003
@@ -971,6 +971,7 @@
 
 	q->queuedata = HWGROUP(drive);
 	blk_init_queue(q, do_ide_request);
+	blk_queue_throttle_sectors(q, 1);
 }
 
 #undef __IRQ_HELL_SPIN
diff -Nru a/drivers/scsi/scsi.c b/drivers/scsi/scsi.c
--- a/drivers/scsi/scsi.c	Thu Jul  3 14:02:50 2003
+++ b/drivers/scsi/scsi.c	Thu Jul  3 14:02:50 2003
@@ -197,6 +197,7 @@
 
 	blk_init_queue(q, scsi_request_fn);
 	blk_queue_headactive(q, 0);
+	blk_queue_throttle_sectors(q, 1);
 	q->queuedata = (void *) SDpnt;
 }
 
diff -Nru a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
--- a/drivers/scsi/scsi_lib.c	Thu Jul  3 14:02:50 2003
+++ b/drivers/scsi/scsi_lib.c	Thu Jul  3 14:02:50 2003
@@ -378,6 +378,7 @@
 		if ((bh = req->bh) != NULL) {
 			nsect = bh->b_size >> 9;
 			blk_finished_io(nsect);
+			blk_finished_sectors(req, nsect);
 			req->bh = bh->b_reqnext;
 			bh->b_reqnext = NULL;
 			sectors -= nsect;
diff -Nru a/fs/buffer.c b/fs/buffer.c
--- a/fs/buffer.c	Thu Jul  3 14:02:50 2003
+++ b/fs/buffer.c	Thu Jul  3 14:02:50 2003
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
@@ -1516,6 +1529,9 @@
 
 	/* Done - end_buffer_io_async will unlock */
 	SetPageUptodate(page);
+
+	wakeup_page_waiters(page);
+
 	return 0;
 
 out:
@@ -1547,6 +1563,7 @@
 	} while (bh != head);
 	if (need_unlock)
 		UnlockPage(page);
+	wakeup_page_waiters(page);
 	return err;
 }
 
@@ -1774,6 +1791,8 @@
 		else
 			submit_bh(READ, bh);
 	}
+
+	wakeup_page_waiters(page);
 	
 	return 0;
 }
@@ -2400,6 +2419,7 @@
 		submit_bh(rw, bh);
 		bh = next;
 	} while (bh != head);
+	wakeup_page_waiters(page);
 	return 0;
 }
 
diff -Nru a/fs/reiserfs/inode.c b/fs/reiserfs/inode.c
--- a/fs/reiserfs/inode.c	Thu Jul  3 14:02:50 2003
+++ b/fs/reiserfs/inode.c	Thu Jul  3 14:02:50 2003
@@ -2048,6 +2048,7 @@
     */
     if (nr) {
         submit_bh_for_writepage(arr, nr) ;
+	wakeup_page_waiters(page);
     } else {
         UnlockPage(page) ;
     }
diff -Nru a/include/linux/blkdev.h b/include/linux/blkdev.h
--- a/include/linux/blkdev.h	Thu Jul  3 14:02:50 2003
+++ b/include/linux/blkdev.h	Thu Jul  3 14:02:50 2003
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
@@ -118,13 +127,34 @@
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
+	 * help keep the sectors in flight to a reasonable value
+	 */
+	int			can_throttle:1;
+
+	/*
+	 * Boolean that indicates the queue should prefer low
+	 * latency over throughput.  This enables the q->full checks
+	 */
+	int			low_latency:1;
 
 	unsigned long		bounce_pfn;
 
@@ -137,7 +167,7 @@
 	/*
 	 * Tasks wait here for free read and write requests
 	 */
-	wait_queue_head_t	wait_for_requests[2];
+	wait_queue_head_t	wait_for_requests;
 };
 
 #define blk_queue_plugged(q)	(q)->plugged
@@ -221,10 +251,11 @@
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
@@ -243,6 +274,8 @@
 
 #define MAX_SEGMENTS 128
 #define MAX_SECTORS 255
+#define MAX_QUEUE_SECTORS (4 << (20 - 9)) /* 4 mbytes when full sized */
+#define MAX_NR_REQUESTS 1024 /* 1024k when in 512 units, normally min is 1M in 1k units */
 
 #define PageAlignSize(size) (((size) + PAGE_SIZE -1) & PAGE_MASK)
 
@@ -268,8 +301,50 @@
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
+
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
 
 static inline unsigned int blksize_bits(unsigned int size)
 {
diff -Nru a/include/linux/elevator.h b/include/linux/elevator.h
--- a/include/linux/elevator.h	Thu Jul  3 14:02:50 2003
+++ b/include/linux/elevator.h	Thu Jul  3 14:02:50 2003
@@ -35,14 +35,19 @@
 	int queue_ID;
 	int read_latency;
 	int write_latency;
+/*
+ * (max_bomb_segments & MAX_BOMB_LATENCY_MASK) == 1 indicates low latency
+ * mode.  We're using any odd number to indicate low latency is on.
+ */
+#define MAX_BOMB_LATENCY_MASK 1
 	int max_bomb_segments;
 } blkelv_ioctl_arg_t;
 
 #define BLKELVGET   _IOR(0x12,106,sizeof(blkelv_ioctl_arg_t))
 #define BLKELVSET   _IOW(0x12,107,sizeof(blkelv_ioctl_arg_t))
 
-extern int blkelvget_ioctl(elevator_t *, blkelv_ioctl_arg_t *);
-extern int blkelvset_ioctl(elevator_t *, const blkelv_ioctl_arg_t *);
+extern int blkelvget_ioctl(request_queue_t *, blkelv_ioctl_arg_t *);
+extern int blkelvset_ioctl(request_queue_t *, const blkelv_ioctl_arg_t *);
 
 extern void elevator_init(elevator_t *, elevator_t);
 
@@ -80,7 +85,7 @@
 	return latency;
 }
 
-#define ELV_LINUS_SEEK_COST	16
+#define ELV_LINUS_SEEK_COST	1
 
 #define ELEVATOR_NOOP							\
 ((elevator_t) {								\
@@ -93,8 +98,8 @@
 
 #define ELEVATOR_LINUS							\
 ((elevator_t) {								\
-	2048,				/* read passovers */		\
-	8192,				/* write passovers */		\
+	128,				/* read passovers */		\
+	512,				/* write passovers */		\
 									\
 	elevator_linus_merge,		/* elevator_merge_fn */		\
 	elevator_linus_merge_req,	/* elevator_merge_req_fn */	\
diff -Nru a/include/linux/pagemap.h b/include/linux/pagemap.h
--- a/include/linux/pagemap.h	Thu Jul  3 14:02:50 2003
+++ b/include/linux/pagemap.h	Thu Jul  3 14:02:50 2003
@@ -97,6 +97,8 @@
 		___wait_on_page(page);
 }
 
+extern void FASTCALL(wakeup_page_waiters(struct page * page));
+
 /*
  * Returns locked page at given index in given cache, creating it if needed.
  */
diff -Nru a/kernel/ksyms.c b/kernel/ksyms.c
--- a/kernel/ksyms.c	Thu Jul  3 14:02:50 2003
+++ b/kernel/ksyms.c	Thu Jul  3 14:02:50 2003
@@ -296,6 +296,7 @@
 EXPORT_SYMBOL(filemap_fdatawait);
 EXPORT_SYMBOL(lock_page);
 EXPORT_SYMBOL(unlock_page);
+EXPORT_SYMBOL(wakeup_page_waiters);
 
 /* device registration */
 EXPORT_SYMBOL(register_chrdev);
diff -Nru a/mm/filemap.c b/mm/filemap.c
--- a/mm/filemap.c	Thu Jul  3 14:02:50 2003
+++ b/mm/filemap.c	Thu Jul  3 14:02:50 2003
@@ -810,6 +810,20 @@
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

--=-ynLPb4PWRj5gEDg9gFnk--

