Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292315AbSBPHdf>; Sat, 16 Feb 2002 02:33:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292319AbSBPHd0>; Sat, 16 Feb 2002 02:33:26 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:20493 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S292315AbSBPHdW>;
	Sat, 16 Feb 2002 02:33:22 -0500
Message-ID: <3C6E0B09.30983B1A@zip.com.au>
Date: Fri, 15 Feb 2002 23:32:25 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-rc1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo@conectiva.com.br>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] get_request starvation fix
In-Reply-To: <3C69A196.B7325DC2@zip.com.au> <Pine.LNX.4.21.0202151515020.23069-100000@freak.distro.conectiva>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti wrote:
> 
> ...
> It seems the real gain (in latency) is caused by the FIFO behaviour.

Well there is no net gain in latency.  What we've gained is *fairness*,
so the worst-case latency is improved.  And yes, it's the FIFO behaviour
which provides that.   And it is the exclusive wait which reduces the context
switch rate by 50%.

> That is, removing this hunk (against __get_request_wait())
> 
> -               if (q->rq[rw].count < batch_requests)
> +               if (q->rq[rw].count == 0)
>                         schedule();
> 
> Would not make _much_ difference latency-wise. I'm I right or missing
> something ?

Well the code which is presently in -rc1 is quite pointless.  We
perform the above test a couple of microseconds after determining
that there are zero free requests.  So the test you've illustrated
will *always* be true.  The test for zero is the right thing to
do - it's just normal waitqueue handling.  It's just a little
obfuscated by the implicit test-for-zero in get_request().

However, contrary to my earlier guess, the request batching does
make a measurable difference.  Changing the code so that we wake up
a sleeper as soon as any request is freed costs maybe 30%
on `dbench 64'.

> Anyway, I would like to have the patch cleaned up for 2.4.19-pre (remove
> the instrumentation stuff _and_ make it clear on the documentation that
> READA requests are not being used in practice).

READA is used in a few filesystems for directory readahead.  (And since
dir-in-pagecache, ext2 is no longer performing directory readhead.  Bad.)

I came >this< close to killing READA altogether.  I believe it's a
misfeature.  If we're under intense seek pressure, the very, very _last_
thing we want to do is to create more seeks by not performing readahead.
But given that the misfeature only applies to creation of new requests,
and that block-contiguous readahead will still work OK, it's not too
serious.  Plus it's a stable kernel :)





--- linux-2.4.18-rc1/include/linux/blkdev.h	Mon Nov 26 11:52:07 2001
+++ linux-akpm/include/linux/blkdev.h	Fri Feb 15 23:06:04 2002
@@ -119,9 +119,9 @@ struct request_queue
 	spinlock_t		queue_lock;
 
 	/*
-	 * Tasks wait here for free request
+	 * Tasks wait here for free read and write requests
 	 */
-	wait_queue_head_t	wait_for_request;
+	wait_queue_head_t	wait_for_requests[2];
 };
 
 struct blk_dev_struct {
--- linux-2.4.18-rc1/drivers/block/ll_rw_blk.c	Wed Feb 13 12:59:09 2002
+++ linux-akpm/drivers/block/ll_rw_blk.c	Fri Feb 15 23:09:17 2002
@@ -118,10 +118,14 @@ int * max_readahead[MAX_BLKDEV];
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
+ * The threshold around which we make wakeup decisions
+ */
+static int batch_requests;
 
 static inline int get_max_sectors(kdev_t dev)
 {
@@ -352,7 +356,8 @@ static void blk_init_free_list(request_q
 		q->rq[i&1].count++;
 	}
 
-	init_waitqueue_head(&q->wait_for_request);
+	init_waitqueue_head(&q->wait_for_requests[0]);
+	init_waitqueue_head(&q->wait_for_requests[1]);
 	spin_lock_init(&q->queue_lock);
 }
 
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
@@ -438,40 +443,84 @@ static inline struct request *get_reques
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
+ *    from the sleepers.  We handle this with wakeup hysteresis around
+ *    0 .. batch_requests and with the assumption that request taking is much,
+ *    much faster than request freeing.
+ * 
+ * So here's what we do:
+ * 
+ *    a) A READA requester fails if free_requests < batch_requests
+ * 
+ *       We don't want READA requests to prevent sleepers from ever
+ *       waking.  Note that READA is used extremely rarely - a few
+ *       filesystems use it for directory readahead.
+ * 
+ *  When a process wants a new request:
+ * 
+ *    b) If free_requests == 0, the requester sleeps in FIFO manner.
+ * 
+ *    b) If 0 <  free_requests < batch_requests and there are waiters,
+ *       we still take a request non-blockingly.  This provides batching.
+ *
+ *    c) If free_requests >= batch_requests, the caller is immediately
+ *       granted a new request.
+ * 
+ *  When a request is released:
+ * 
+ *    d) If free_requests < batch_requests, do nothing.
+ * 
+ *    f) If free_requests >= batch_requests, wake up a single waiter.
+ * 
+ *   The net effect is that when a process is woken at the batch_requests level,
+ *   it will be able to take approximately (batch_requests) requests before
+ *   blocking again (at the tail of the queue).
+ * 
+ *   This all assumes that the rate of taking requests is much, much higher
+ *   than the rate of releasing them.  Which is very true.
+ *
+ * -akpm, Feb 2002.
  */
+
 static struct request *__get_request_wait(request_queue_t *q, int rw)
 {
 	register struct request *rq;
 	DECLARE_WAITQUEUE(wait, current);
 
 	generic_unplug_device(q);
-	add_wait_queue(&q->wait_for_request, &wait);
+	add_wait_queue_exclusive(&q->wait_for_requests[rw], &wait);
 	do {
 		set_current_state(TASK_UNINTERRUPTIBLE);
-		if (q->rq[rw].count < batch_requests)
+		if (q->rq[rw].count == 0)
 			schedule();
 		spin_lock_irq(&io_request_lock);
 		rq = get_request(q,rw);
 		spin_unlock_irq(&io_request_lock);
 	} while (rq == NULL);
-	remove_wait_queue(&q->wait_for_request, &wait);
+	remove_wait_queue(&q->wait_for_requests[rw], &wait);
 	current->state = TASK_RUNNING;
 	return rq;
 }
 
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
-}
-
 /* RO fail safe mechanism */
 
 static long ro_bits[MAX_BLKDEV][8];
@@ -546,7 +595,7 @@ static inline void add_request(request_q
 /*
  * Must be called with io_request_lock held and interrupts disabled
  */
-inline void blkdev_release_request(struct request *req)
+void blkdev_release_request(struct request *req)
 {
 	request_queue_t *q = req->q;
 	int rw = req->cmd;
@@ -560,8 +609,9 @@ inline void blkdev_release_request(struc
 	 */
 	if (q) {
 		list_add(&req->queue, &q->rq[rw].free);
-		if (++q->rq[rw].count >= batch_requests && waitqueue_active(&q->wait_for_request))
-			wake_up(&q->wait_for_request);
+		if (++q->rq[rw].count >= batch_requests &&
+				waitqueue_active(&q->wait_for_requests[rw]))
+			wake_up(&q->wait_for_requests[rw]);
 	}
 }
 
@@ -742,22 +792,30 @@ again:
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
+			if (q->rq[rw].count < batch_requests) {
+				spin_unlock_irq(&io_request_lock);
+				goto end_io;
+			}
+			req = get_request(q, rw);
+			if (req == NULL)
+				BUG();
+		} else {
+			req = get_request(q, rw);
+			if (req == NULL) {
+				spin_unlock_irq(&io_request_lock);
+				freereq = __get_request_wait(q, rw);
+				goto again;
+			}
+		}
 	}
 
 /* fill up the request-info, and add it to the queue */


-
