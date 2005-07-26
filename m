Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261794AbVGZOTE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261794AbVGZOTE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 10:19:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261790AbVGZOTE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 10:19:04 -0400
Received: from rproxy.gmail.com ([64.233.170.206]:19744 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261794AbVGZOTA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 10:19:00 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=NtdjET+Uhc7Hsp7VrFUKik3C+wgDXEmcbslmrq1FNVTtYhw3rEqIR1Xq+piWdhKjasUDsl8HmfYTqYipF/SKLqECcDo+Ili0W5UgdQsSHTjIzqqGaRxxTMN79X7hLs1JYlX3844VH3qUYzimPxMZDzRpBIDebJiDEgcxm/VsekY=
Date: Tue, 26 Jul 2005 23:18:55 +0900
From: Tejun Heo <htejun@gmail.com>
To: axboe@suse.de, linux-kernel@vger.kernel.org
Subject: [PATCH linux-2.6-block:master] reimplement elevator switch
Message-ID: <20050726141855.GA4698@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Hello, Jens.

 This patch reimplements elevator switch.  This patch assumes generic
dispatch queue patchset is applied.

 * Each request is tagged with REQ_ELVPRIV flag if it has its elevator
   private data set.
 * Requests which doesn't have REQ_ELVPRIV flag set never enter
   iosched.  They are always directly back inserted to dispatch queue.
   Of course, elevator_put_req_fn is called only for requests which
   have its REQ_ELVPRIV set.
 * Request queue maintains the current number of requests which have
   its elevator data set (elevator_set_req_fn called) in
   q->rq->elvpriv.
 * If a request queue has QUEUE_FLAG_BYPASS set, elevator private data
   is not allocated for new requests.

 To switch to another iosched, we set QUEUE_FLAG_BYPASS and wait until
elvpriv goes to zero; then, we attach the new iosched and clears
QUEUE_FLAG_BYPASS.  New implementation is much simpler and main code
paths are less cluttered, IMHO.

Signed-off-by: Tejun Heo <htejun@gmail.com>

Index: blk-fixes/drivers/block/elevator.c
===================================================================
--- blk-fixes.orig/drivers/block/elevator.c	2005-07-26 15:33:54.000000000 +0900
+++ blk-fixes/drivers/block/elevator.c	2005-07-26 15:34:00.000000000 +0900
@@ -34,6 +34,7 @@
 #include <linux/slab.h>
 #include <linux/init.h>
 #include <linux/compiler.h>
+#include <linux/delay.h>
 
 #include <asm/uaccess.h>
 
@@ -135,13 +136,7 @@ static int elevator_attach(request_queue
 	memset(eq, 0, sizeof(*eq));
 	eq->ops = &e->ops;
 	eq->elevator_type = e;
-
-	INIT_LIST_HEAD(&q->queue_head);
-	q->last_merge = NULL;
 	q->elevator = eq;
-	q->last_sector = 0;
-	q->boundary_rq = NULL;
-	q->max_back_kb = 0;
 
 	if (eq->ops->elevator_init_fn)
 		ret = eq->ops->elevator_init_fn(q, eq);
@@ -190,6 +185,12 @@ int elevator_init(request_queue_t *q, ch
 	struct elevator_queue *eq;
 	int ret = 0;
 
+	INIT_LIST_HEAD(&q->queue_head);
+	q->last_merge = NULL;
+	q->last_sector = 0;
+	q->boundary_rq = NULL;
+	q->max_back_kb = 0;
+
 	elevator_setup_default();
 
 	if (!name)
@@ -353,23 +354,14 @@ void __elv_add_request(request_queue_t *
 			q->last_sector = rq_last_sector(rq);
 			q->boundary_rq = rq;
 		}
-	}
+	} else if (!(rq->flags & REQ_ELVPRIV) && where == ELEVATOR_INSERT_SORT)
+		where = ELEVATOR_INSERT_BACK;
 
 	if (plug)
 		blk_plug_device(q);
 
 	rq->q = q;
 
-	if (unlikely(test_bit(QUEUE_FLAG_DRAIN, &q->queue_flags))) {
-		/*
-		 * if drain is set, store the request "locally". when the drain
-		 * is finished, the requests will be handed ordered to the io
-		 * scheduler
-		 */
-		list_add_tail(&rq->queuelist, &q->drain_list);
-		return;
-	}
-
 	switch (where) {
 	case ELEVATOR_INSERT_FRONT:
 		rq->flags |= REQ_SOFTBARRIER;
@@ -675,25 +667,36 @@ EXPORT_SYMBOL_GPL(elv_unregister);
  * switch to new_e io scheduler. be careful not to introduce deadlocks -
  * we don't free the old io scheduler, before we have allocated what we
  * need for the new one. this way we have a chance of going back to the old
- * one, if the new one fails init for some reason. we also do an intermediate
- * switch to noop to ensure safety with stack-allocated requests, since they
- * don't originate from the block layer allocator. noop is safe here, because
- * it never needs to touch the elevator itself for completion events. DRAIN
- * flags will make sure we don't touch it for additions either.
+ * one, if the new one fails init for some reason.
  */
 static void elevator_switch(request_queue_t *q, struct elevator_type *new_e)
 {
-	elevator_t *e = kmalloc(sizeof(elevator_t), GFP_KERNEL);
-	struct elevator_type *noop_elevator = NULL;
-	elevator_t *old_elevator;
+	elevator_t *old_elevator, *e;
 
+	/*
+	 * Allocate new elevator
+	 */
+	e = kmalloc(sizeof(elevator_t), GFP_KERNEL);
 	if (!e)
 		goto error;
 
 	/*
-	 * first step, drain requests from the block freelist
+	 * Turn on BYPASS and drain all requests w/ elevator private data
 	 */
-	blk_wait_queue_drained(q, 0);
+	spin_lock_irq(q->queue_lock);
+
+	set_bit(QUEUE_FLAG_BYPASS, &q->queue_flags);
+
+	while (q->elevator->ops->elevator_dispatch_fn(q, 1))
+		;
+
+	while (q->rq.elvpriv) {
+		spin_unlock_irq(q->queue_lock);
+		msleep(100);
+		spin_lock_irq(q->queue_lock);
+	}
+
+	spin_unlock_irq(q->queue_lock);
 
 	/*
 	 * unregister old elevator data
@@ -702,18 +705,6 @@ static void elevator_switch(request_queu
 	old_elevator = q->elevator;
 
 	/*
- 	 * next step, switch to noop since it uses no private rq structures
-	 * and doesn't allocate any memory for anything. then wait for any
-	 * non-fs requests in-flight
- 	 */
-	noop_elevator = elevator_get("noop");
-	spin_lock_irq(q->queue_lock);
-	elevator_attach(q, noop_elevator, e);
-	spin_unlock_irq(q->queue_lock);
-
-	blk_wait_queue_drained(q, 1);
-
-	/*
 	 * attach and start new elevator
 	 */
 	if (elevator_attach(q, new_e, e))
@@ -723,11 +714,10 @@ static void elevator_switch(request_queu
 		goto fail_register;
 
 	/*
-	 * finally exit old elevator and start queue again
+	 * finally exit old elevator and turn off BYPASS.
 	 */
 	elevator_exit(old_elevator);
-	blk_finish_queue_drain(q);
-	elevator_put(noop_elevator);
+	clear_bit(QUEUE_FLAG_BYPASS, &q->queue_flags);
 	return;
 
 fail_register:
@@ -736,13 +726,13 @@ fail_register:
 	 * one again (along with re-adding the sysfs dir)
 	 */
 	elevator_exit(e);
+	e = NULL;
 fail:
 	q->elevator = old_elevator;
 	elv_register_queue(q);
-	blk_finish_queue_drain(q);
+	clear_bit(QUEUE_FLAG_BYPASS, &q->queue_flags);
+	kfree(e);
 error:
-	if (noop_elevator)
-		elevator_put(noop_elevator);
 	elevator_put(new_e);
 	printk(KERN_ERR "elevator: switch to %s failed\n",new_e->elevator_name);
 }
Index: blk-fixes/drivers/block/ll_rw_blk.c
===================================================================
--- blk-fixes.orig/drivers/block/ll_rw_blk.c	2005-07-26 15:26:40.000000000 +0900
+++ blk-fixes/drivers/block/ll_rw_blk.c	2005-07-26 15:34:00.000000000 +0900
@@ -261,8 +261,6 @@ void blk_queue_make_request(request_queu
 	blk_queue_bounce_limit(q, BLK_BOUNCE_HIGH);
 
 	blk_queue_activity_fn(q, NULL, NULL);
-
-	INIT_LIST_HEAD(&q->drain_list);
 }
 
 EXPORT_SYMBOL(blk_queue_make_request);
@@ -1046,6 +1044,7 @@ static char *rq_flags[] = {
 	"REQ_STARTED",
 	"REQ_DONTPREP",
 	"REQ_QUEUED",
+	"REQ_ELVPRIV",
 	"REQ_PC",
 	"REQ_BLOCK_PC",
 	"REQ_SENSE",
@@ -1644,9 +1643,9 @@ static int blk_init_free_list(request_qu
 
 	rl->count[READ] = rl->count[WRITE] = 0;
 	rl->starved[READ] = rl->starved[WRITE] = 0;
+	rl->elvpriv = 0;
 	init_waitqueue_head(&rl->wait[READ]);
 	init_waitqueue_head(&rl->wait[WRITE]);
-	init_waitqueue_head(&rl->drain);
 
 	rl->rq_pool = mempool_create(BLKDEV_MIN_RQ, mempool_alloc_slab, mempool_free_slab, request_cachep);
 
@@ -1774,12 +1773,13 @@ EXPORT_SYMBOL(blk_get_queue);
 
 static inline void blk_free_request(request_queue_t *q, struct request *rq)
 {
-	elv_put_request(q, rq);
+	if (rq->flags & REQ_ELVPRIV)
+		elv_put_request(q, rq);
 	mempool_free(rq, q->rq.rq_pool);
 }
 
 static inline struct request *blk_alloc_request(request_queue_t *q, int rw,
-						int gfp_mask)
+						int priv, int gfp_mask)
 {
 	struct request *rq = mempool_alloc(q->rq.rq_pool, gfp_mask);
 
@@ -1792,11 +1792,15 @@ static inline struct request *blk_alloc_
 	 */
 	rq->flags = rw;
 
-	if (!elv_set_request(q, rq, gfp_mask))
-		return rq;
+	if (priv) {
+		if (unlikely(elv_set_request(q, rq, gfp_mask))) {
+			mempool_free(rq, q->rq.rq_pool);
+			return NULL;
+		}
+		rq->flags |= REQ_ELVPRIV;
+	}
 
-	mempool_free(rq, q->rq.rq_pool);
-	return NULL;
+	return rq;
 }
 
 /*
@@ -1853,22 +1857,18 @@ static void __freed_request(request_queu
  * A request has just been released.  Account for it, update the full and
  * congestion status, wake up any waiters.   Called under q->queue_lock.
  */
-static void freed_request(request_queue_t *q, int rw)
+static void freed_request(request_queue_t *q, int rw, int priv)
 {
 	struct request_list *rl = &q->rq;
 
 	rl->count[rw]--;
+	if (priv)
+		rl->elvpriv--;
 
 	__freed_request(q, rw);
 
 	if (unlikely(rl->starved[rw ^ 1]))
 		__freed_request(q, rw ^ 1);
-
-	if (!rl->count[READ] && !rl->count[WRITE]) {
-		smp_mb();
-		if (unlikely(waitqueue_active(&rl->drain)))
-			wake_up(&rl->drain);
-	}
 }
 
 #define blkdev_free_rq(list) list_entry((list)->next, struct request, queuelist)
@@ -1880,9 +1880,7 @@ static struct request *get_request(reque
 	struct request *rq = NULL;
 	struct request_list *rl = &q->rq;
 	struct io_context *ioc = get_io_context(gfp_mask);
-
-	if (unlikely(test_bit(QUEUE_FLAG_DRAIN, &q->queue_flags)))
-		goto out;
+	int priv;
 
 	spin_lock_irq(q->queue_lock);
 	if (rl->count[rw]+1 >= q->nr_requests) {
@@ -1921,9 +1919,14 @@ get_rq:
 	rl->starved[rw] = 0;
 	if (rl->count[rw] >= queue_congestion_on_threshold(q))
 		set_queue_congested(q, rw);
+
+	priv = !test_bit(QUEUE_FLAG_BYPASS, &q->queue_flags);
+	if (priv)
+		rl->elvpriv++;
+
 	spin_unlock_irq(q->queue_lock);
 
-	rq = blk_alloc_request(q, rw, gfp_mask);
+	rq = blk_alloc_request(q, rw, priv, gfp_mask);
 	if (!rq) {
 		/*
 		 * Allocation failed presumably due to memory. Undo anything
@@ -1933,7 +1936,7 @@ get_rq:
 		 * wait queue, but this is pretty rare.
 		 */
 		spin_lock_irq(q->queue_lock);
-		freed_request(q, rw);
+		freed_request(q, rw, priv);
 
 		/*
 		 * in the very unlikely event that allocation failed and no
@@ -2385,11 +2388,12 @@ static void __blk_put_request(request_qu
 	 */
 	if (rl) {
 		int rw = rq_data_dir(req);
+		int priv = req->flags & REQ_ELVPRIV;
 
 		BUG_ON(!list_empty(&req->queuelist));
 
 		blk_free_request(q, req);
-		freed_request(q, rw);
+		freed_request(q, rw, priv);
 	}
 }
 
@@ -2740,92 +2744,6 @@ static inline void blk_partition_remap(s
 	}
 }
 
-void blk_finish_queue_drain(request_queue_t *q)
-{
-	struct request_list *rl = &q->rq;
-	struct request *rq;
-
-	spin_lock_irq(q->queue_lock);
-	clear_bit(QUEUE_FLAG_DRAIN, &q->queue_flags);
-
-	while (!list_empty(&q->drain_list)) {
-		rq = list_entry_rq(q->drain_list.next);
-
-		list_del_init(&rq->queuelist);
-		__elv_add_request(q, rq, ELEVATOR_INSERT_BACK, 1);
-	}
-
-	spin_unlock_irq(q->queue_lock);
-
-	wake_up(&rl->wait[0]);
-	wake_up(&rl->wait[1]);
-	wake_up(&rl->drain);
-}
-
-static int wait_drain(request_queue_t *q, struct request_list *rl, int dispatch)
-{
-	int wait = rl->count[READ] + rl->count[WRITE];
-
-	if (dispatch)
-		wait += !list_empty(&q->queue_head);
-
-	return wait;
-}
-
-/*
- * We rely on the fact that only requests allocated through blk_alloc_request()
- * have io scheduler private data structures associated with them. Any other
- * type of request (allocated on stack or through kmalloc()) should not go
- * to the io scheduler core, but be attached to the queue head instead.
- */
-void blk_wait_queue_drained(request_queue_t *q, int wait_dispatch)
-{
-	struct request_list *rl = &q->rq;
-	DEFINE_WAIT(wait);
-
-	spin_lock_irq(q->queue_lock);
-	set_bit(QUEUE_FLAG_DRAIN, &q->queue_flags);
-
-	while (wait_drain(q, rl, wait_dispatch)) {
-		prepare_to_wait(&rl->drain, &wait, TASK_UNINTERRUPTIBLE);
-
-		if (wait_drain(q, rl, wait_dispatch)) {
-			__generic_unplug_device(q);
-			spin_unlock_irq(q->queue_lock);
-			io_schedule();
-			spin_lock_irq(q->queue_lock);
-		}
-
-		finish_wait(&rl->drain, &wait);
-	}
-
-	spin_unlock_irq(q->queue_lock);
-}
-
-/*
- * block waiting for the io scheduler being started again.
- */
-static inline void block_wait_queue_running(request_queue_t *q)
-{
-	DEFINE_WAIT(wait);
-
-	while (test_bit(QUEUE_FLAG_DRAIN, &q->queue_flags)) {
-		struct request_list *rl = &q->rq;
-
-		prepare_to_wait_exclusive(&rl->drain, &wait,
-				TASK_UNINTERRUPTIBLE);
-
-		/*
-		 * re-check the condition. avoids using prepare_to_wait()
-		 * in the fast path (queue is running)
-		 */
-		if (test_bit(QUEUE_FLAG_DRAIN, &q->queue_flags))
-			io_schedule();
-
-		finish_wait(&rl->drain, &wait);
-	}
-}
-
 static void handle_bad_sector(struct bio *bio)
 {
 	char b[BDEVNAME_SIZE];
@@ -2921,8 +2839,6 @@ end_io:
 		if (test_bit(QUEUE_FLAG_DEAD, &q->queue_flags))
 			goto end_io;
 
-		block_wait_queue_running(q);
-
 		/*
 		 * If this device has partitions, remap block n
 		 * of partition p to block n+start(p) of the disk.
Index: blk-fixes/include/linux/blkdev.h
===================================================================
--- blk-fixes.orig/include/linux/blkdev.h	2005-07-26 15:32:19.000000000 +0900
+++ blk-fixes/include/linux/blkdev.h	2005-07-26 15:34:00.000000000 +0900
@@ -99,9 +99,9 @@ typedef void (rq_end_io_fn)(struct reque
 struct request_list {
 	int count[2];
 	int starved[2];
+	int elvpriv;
 	mempool_t *rq_pool;
 	wait_queue_head_t wait[2];
-	wait_queue_head_t drain;
 };
 
 #define BLK_MAX_CDB	16
@@ -201,6 +201,7 @@ enum rq_flag_bits {
 	__REQ_STARTED,		/* drive already may have started this one */
 	__REQ_DONTPREP,		/* don't call prep for this one */
 	__REQ_QUEUED,		/* uses queueing */
+	__REQ_ELVPRIV,		/* elevator private data attached */
 	/*
 	 * for ATA/ATAPI devices
 	 */
@@ -234,6 +235,7 @@ enum rq_flag_bits {
 #define REQ_STARTED	(1 << __REQ_STARTED)
 #define REQ_DONTPREP	(1 << __REQ_DONTPREP)
 #define REQ_QUEUED	(1 << __REQ_QUEUED)
+#define REQ_ELVPRIV	(1 << __REQ_ELVPRIV)
 #define REQ_PC		(1 << __REQ_PC)
 #define REQ_BLOCK_PC	(1 << __REQ_BLOCK_PC)
 #define REQ_SENSE	(1 << __REQ_SENSE)
@@ -406,8 +408,6 @@ struct request_queue
 	unsigned int		sg_timeout;
 	unsigned int		sg_reserved_size;
 
-	struct list_head	drain_list;
-
 	/*
 	 * reserved for flush operations
 	 */
@@ -435,7 +435,7 @@ enum {
 #define QUEUE_FLAG_DEAD		5	/* queue being torn down */
 #define QUEUE_FLAG_REENTER	6	/* Re-entrancy avoidance */
 #define QUEUE_FLAG_PLUGGED	7	/* queue is plugged */
-#define QUEUE_FLAG_DRAIN	8	/* draining queue for sched switch */
+#define QUEUE_FLAG_BYPASS	8	/* don't use elevator, just do FIFO */
 #define QUEUE_FLAG_FLUSH	9	/* doing barrier flush sequence */
 
 #define blk_queue_plugged(q)	test_bit(QUEUE_FLAG_PLUGGED, &(q)->queue_flags)
@@ -647,8 +647,6 @@ extern void blk_dump_rq_flags(struct req
 extern void generic_unplug_device(request_queue_t *);
 extern void __generic_unplug_device(request_queue_t *);
 extern long nr_blockdev_pages(void);
-extern void blk_wait_queue_drained(request_queue_t *, int);
-extern void blk_finish_queue_drain(request_queue_t *);
 
 int blk_get_queue(request_queue_t *);
 request_queue_t *blk_alloc_queue(int);
