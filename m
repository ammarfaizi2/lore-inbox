Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267633AbUBTBRS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 20:17:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267651AbUBTBRQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 20:17:16 -0500
Received: from mail-05.iinet.net.au ([203.59.3.37]:32230 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S267650AbUBTBPg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 20:15:36 -0500
Message-ID: <40355F03.9030207@cyberone.com.au>
Date: Fri, 20 Feb 2004 12:12:35 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Miquel van Smoorenburg <miquels@cistron.nl>
CC: Jens Axboe <axboe@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-lvm@sistina.com, linux-kernel@vger.kernel.org,
       thornber@redhat.com
Subject: [PATCH] per process request limits (was Re: IO scheduler, queue depth,
 nr_requests)
References: <20040216133047.GA9330@suse.de> <20040217145716.GE30438@traveler.cistron.net> <20040218235243.GA30621@drinkel.cistron.nl> <20040218172622.52914567.akpm@osdl.org> <20040219021159.GE30621@drinkel.cistron.nl> <20040218182628.7eb63d57.akpm@osdl.org> <20040219101519.GG30621@drinkel.cistron.nl> <20040219101915.GJ27190@suse.de> <20040219205907.GE32263@drinkel.cistron.nl> <40353E30.6000105@cyberone.com.au> <20040219235303.GI32263@drinkel.cistron.nl>
In-Reply-To: <20040219235303.GI32263@drinkel.cistron.nl>
Content-Type: multipart/mixed;
 boundary="------------040509070901040301010909"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040509070901040301010909
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi Miquel,
Can you see if this patch helps you?

Even with this patch, it might still be a good idea to allow
pdflush to disregard the limits...

Nick


--------------040509070901040301010909
Content-Type: text/plain;
 name="blk-per-process-rqlim.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="blk-per-process-rqlim.patch"

 linux-2.6-npiggin/drivers/block/ll_rw_blk.c |  113 ++++++++--------------------
 linux-2.6-npiggin/include/linux/blkdev.h    |    8 -
 2 files changed, 36 insertions(+), 85 deletions(-)

diff -puN include/linux/blkdev.h~blk-per-process-rqlim include/linux/blkdev.h
--- linux-2.6/include/linux/blkdev.h~blk-per-process-rqlim	2004-02-20 09:53:22.000000000 +1100
+++ linux-2.6-npiggin/include/linux/blkdev.h	2004-02-20 10:12:04.000000000 +1100
@@ -25,6 +25,7 @@ struct request_pm_state;
 
 #define BLKDEV_MIN_RQ	4
 #define BLKDEV_MAX_RQ	128	/* Default maximum */
+#define BLKDEV_MIN_PROC_RQ	64
 
 /*
  * This is the per-process anticipatory I/O scheduler state.
@@ -61,11 +62,7 @@ struct io_context {
 	atomic_t refcount;
 	pid_t pid;
 
-	/*
-	 * For request batching
-	 */
-	unsigned long last_waited; /* Time last woken after wait for request */
-	int nr_batch_requests;     /* Number of requests left in the batch */
+	unsigned int nr_requests;	/* Outstanding requests */
 
 	struct as_io_context *aic;
 };
@@ -141,6 +138,7 @@ struct request {
 	int ref_count;
 	request_queue_t *q;
 	struct request_list *rl;
+	struct io_context *ioc;
 
 	struct completion *waiting;
 	void *special;
diff -puN drivers/block/ll_rw_blk.c~blk-per-process-rqlim drivers/block/ll_rw_blk.c
--- linux-2.6/drivers/block/ll_rw_blk.c~blk-per-process-rqlim	2004-02-20 09:53:25.000000000 +1100
+++ linux-2.6-npiggin/drivers/block/ll_rw_blk.c	2004-02-20 10:40:43.000000000 +1100
@@ -55,12 +55,6 @@ unsigned long blk_max_low_pfn, blk_max_p
 EXPORT_SYMBOL(blk_max_low_pfn);
 EXPORT_SYMBOL(blk_max_pfn);
 
-/* Amount of time in which a process may batch requests */
-#define BLK_BATCH_TIME	(HZ/50UL)
-
-/* Number of requests a "batching" process may submit */
-#define BLK_BATCH_REQ	32
-
 /*
  * Return the threshold (number of used requests) at which the queue is
  * considered to be congested.  It include a little hysteresis to keep the
@@ -1495,57 +1489,27 @@ static inline struct request *blk_alloc_
 }
 
 /*
- * ioc_batching returns true if the ioc is a valid batching request and
- * should be given priority access to a request.
- */
-static inline int ioc_batching(struct io_context *ioc)
-{
-	if (!ioc)
-		return 0;
-
-	/*
-	 * Make sure the process is able to allocate at least 1 request
-	 * even if the batch times out, otherwise we could theoretically
-	 * lose wakeups.
-	 */
-	return ioc->nr_batch_requests == BLK_BATCH_REQ ||
-		(ioc->nr_batch_requests > 0
-		&& time_before(jiffies, ioc->last_waited + BLK_BATCH_TIME));
-}
-
-/*
- * ioc_set_batching sets ioc to be a new "batcher" if it is not one. This
- * will cause the process to be a "batcher" on all queues in the system. This
- * is the behaviour we want though - once it gets a wakeup it should be given
- * a nice run.
- */
-void ioc_set_batching(struct io_context *ioc)
-{
-	if (!ioc || ioc_batching(ioc))
-		return;
-
-	ioc->nr_batch_requests = BLK_BATCH_REQ;
-	ioc->last_waited = jiffies;
-}
-
-/*
  * A request has just been released.  Account for it, update the full and
  * congestion status, wake up any waiters.   Called under q->queue_lock.
  */
-static void freed_request(request_queue_t *q, int rw)
+static void freed_request(request_queue_t *q, struct io_context *ioc, int rw)
 {
 	struct request_list *rl = &q->rq;
 
+	ioc->nr_requests--;
 	rl->count[rw]--;
 	if (rl->count[rw] < queue_congestion_off_threshold(q))
 		clear_queue_congested(q, rw);
 	if (rl->count[rw]+1 <= q->nr_requests) {
-		smp_mb();
-		if (waitqueue_active(&rl->wait[rw]))
-			wake_up(&rl->wait[rw]);
 		if (!waitqueue_active(&rl->wait[rw]))
 			blk_clear_queue_full(q, rw);
 	}
+
+	if (rl->count[rw]-31 <= q->nr_requests
+			|| ioc->nr_requests <= BLKDEV_MIN_PROC_RQ - 32) {
+		if (waitqueue_active(&rl->wait[rw]))
+			wake_up(&rl->wait[rw]);
+	}
 }
 
 #define blkdev_free_rq(list) list_entry((list)->next, struct request, queuelist)
@@ -1556,32 +1520,34 @@ static struct request *get_request(reque
 {
 	struct request *rq = NULL;
 	struct request_list *rl = &q->rq;
-	struct io_context *ioc = get_io_context(gfp_mask);
+	struct io_context *ioc;
 
 	spin_lock_irq(q->queue_lock);
 	if (rl->count[rw]+1 >= q->nr_requests) {
 		/*
 		 * The queue will fill after this allocation, so set it as
-		 * full, and mark this process as "batching". This process
-		 * will be allowed to complete a batch of requests, others
-		 * will be blocked.
+		 * full.
 		 */
-		if (!blk_queue_full(q, rw)) {
-			ioc_set_batching(ioc);
+		if (!blk_queue_full(q, rw))
 			blk_set_queue_full(q, rw);
-		}
 	}
 
+	ioc = get_io_context(gfp_mask);
+	if (unlikely(ioc == NULL))
+		goto out;
+
 	if (blk_queue_full(q, rw)
-			&& !ioc_batching(ioc) && !elv_may_queue(q, rw)) {
+			&& ioc->nr_requests >= BLKDEV_MIN_PROC_RQ
+			&& !elv_may_queue(q, rw)) {
 		/*
-		 * The queue is full and the allocating process is not a
-		 * "batcher", and not exempted by the IO scheduler
+		 * The queue is full and the allocating process is over
+		 * it's limit, and not exempted by the IO scheduler
 		 */
 		spin_unlock_irq(q->queue_lock);
-		goto out;
+		goto out_ioc;
 	}
 
+	ioc->nr_requests++;
 	rl->count[rw]++;
 	if (rl->count[rw] >= queue_congestion_on_threshold(q))
 		set_queue_congested(q, rw);
@@ -1597,14 +1563,11 @@ static struct request *get_request(reque
 		 * wait queue, but this is pretty rare.
 		 */
 		spin_lock_irq(q->queue_lock);
-		freed_request(q, rw);
+		freed_request(q, ioc, rw);
 		spin_unlock_irq(q->queue_lock);
-		goto out;
+		goto out_ioc;
 	}
 
-	if (ioc_batching(ioc))
-		ioc->nr_batch_requests--;
-	
 	INIT_LIST_HEAD(&rq->queuelist);
 
 	/*
@@ -1620,13 +1583,15 @@ static struct request *get_request(reque
 	rq->ref_count = 1;
 	rq->q = q;
 	rq->rl = rl;
+	rq->ioc = ioc;
 	rq->waiting = NULL;
 	rq->special = NULL;
 	rq->data = NULL;
 	rq->sense = NULL;
 
-out:
+out_ioc:
 	put_io_context(ioc);
+out:
 	return rq;
 }
 
@@ -1644,25 +1609,12 @@ static struct request *get_request_wait(
 		struct request_list *rl = &q->rq;
 
 		prepare_to_wait_exclusive(&rl->wait[rw], &wait,
-				TASK_UNINTERRUPTIBLE);
+						TASK_UNINTERRUPTIBLE);
 
 		rq = get_request(q, rw, GFP_NOIO);
-
-		if (!rq) {
-			struct io_context *ioc;
-
+		if (!rq)
 			io_schedule();
 
-			/*
-			 * After sleeping, we become a "batching" process and
-			 * will be able to allocate at least one request, and
-			 * up to a big batch of them for a small period time.
-			 * See ioc_batching, ioc_set_batching
-			 */
-			ioc = get_io_context(GFP_NOIO);
-			ioc_set_batching(ioc);
-			put_io_context(ioc);
-		}
 		finish_wait(&rl->wait[rw], &wait);
 	} while (!rq);
 
@@ -1854,6 +1806,7 @@ void __blk_put_request(request_queue_t *
 	 * it didn't come out of our reserved rq pools
 	 */
 	if (rl) {
+		struct io_context *ioc = req->ioc;
 		int rw = rq_data_dir(req);
 
 		elv_completed_request(q, req);
@@ -1861,7 +1814,8 @@ void __blk_put_request(request_queue_t *
 		BUG_ON(!list_empty(&req->queuelist));
 
 		blk_free_request(q, req);
-		freed_request(q, rw);
+		freed_request(q, ioc, rw);
+		put_io_context(ioc);
 	}
 }
 
@@ -2721,7 +2675,7 @@ int __init blk_dev_init(void)
  */
 void put_io_context(struct io_context *ioc)
 {
-	if (ioc == NULL)
+	if (unlikely(ioc == NULL))
 		return;
 
 	BUG_ON(atomic_read(&ioc->refcount) == 0);
@@ -2772,8 +2726,7 @@ struct io_context *get_io_context(int gf
 		if (ret) {
 			atomic_set(&ret->refcount, 1);
 			ret->pid = tsk->pid;
-			ret->last_waited = jiffies; /* doesn't matter... */
-			ret->nr_batch_requests = 0; /* because this is 0 */
+			ret->nr_requests = 0;
 			ret->aic = NULL;
 			tsk->io_context = ret;
 		}

_

--------------040509070901040301010909--
