Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261928AbTCYLMu>; Tue, 25 Mar 2003 06:12:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261908AbTCYLMu>; Tue, 25 Mar 2003 06:12:50 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:46224 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S261924AbTCYLME>;
	Tue, 25 Mar 2003 06:12:04 -0500
Date: Tue, 25 Mar 2003 12:23:07 +0100
From: Jens Axboe <axboe@suse.de>
To: Andrew Morton <akpm@digeo.com>
Cc: dougg@torque.net, pbadari@us.ibm.com, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: [patch for playing] 2.5.65 patch to support > 256 disks
Message-ID: <20030325112307.GT2371@suse.de>
References: <200303211056.04060.pbadari@us.ibm.com> <3E7C4251.4010406@torque.net> <20030322030419.1451f00b.akpm@digeo.com> <3E7C4D05.2030500@torque.net> <20030322040550.0b8baeec.akpm@digeo.com> <20030325105629.GS2371@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030325105629.GS2371@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 25 2003, Jens Axboe wrote:
> Here's a patch that makes the request allocation (and io scheduler
> private data) dynamic, with upper and lower bounds of 4 and 256
> respectively. The numbers are a bit random - the 4 will allow us to make
> progress, but it might be a smidgen too low. Perhaps 8 would be good.
> 256 is twice as much as before, but that should be alright as long as
> the io scheduler copes. BLKDEV_MAX_RQ and BLKDEV_MIN_RQ control these
> two variables.
> 
> We loose the old batching functionality, for now. I can resurrect that
> if needed. It's a rough fit with the mempool, it doesn't _quite_ fit our
> needs here. I'll probably end up doing a specialised block pool scheme
> for this.
> 
> Hasn't been tested all that much, it boots though :-)

Here's a version with better lock handling. We drop the queue_lock for
most parts of __make_request(), except the actual io scheduler calls.

Patch is against 2.5.66-BK as of today.

 drivers/block/deadline-iosched.c |   86 ++++++-------
 drivers/block/elevator.c         |   18 ++
 drivers/block/ll_rw_blk.c        |  245 ++++++++++++---------------------------
 include/linux/blkdev.h           |   12 +
 include/linux/elevator.h         |    7 +
 5 files changed, 154 insertions(+), 214 deletions(-)

===== drivers/block/deadline-iosched.c 1.17 vs edited =====
--- 1.17/drivers/block/deadline-iosched.c	Fri Mar 14 16:55:04 2003
+++ edited/drivers/block/deadline-iosched.c	Tue Mar 25 11:05:37 2003
@@ -71,6 +71,8 @@
 	int fifo_batch;
 	int writes_starved;
 	int front_merges;
+
+	mempool_t *drq_pool;
 };
 
 /*
@@ -673,28 +675,11 @@
 static void deadline_exit(request_queue_t *q, elevator_t *e)
 {
 	struct deadline_data *dd = e->elevator_data;
-	struct deadline_rq *drq;
-	struct request *rq;
-	int i;
 
 	BUG_ON(!list_empty(&dd->fifo_list[READ]));
 	BUG_ON(!list_empty(&dd->fifo_list[WRITE]));
 
-	for (i = READ; i <= WRITE; i++) {
-		struct request_list *rl = &q->rq[i];
-		struct list_head *entry;
-
-		list_for_each(entry, &rl->free) {
-			rq = list_entry_rq(entry);
-
-			if ((drq = RQ_DATA(rq)) == NULL)
-				continue;
-
-			rq->elevator_private = NULL;
-			kmem_cache_free(drq_pool, drq);
-		}
-	}
-
+	mempool_destroy(dd->drq_pool);
 	kfree(dd->hash);
 	kfree(dd);
 }
@@ -706,9 +691,7 @@
 static int deadline_init(request_queue_t *q, elevator_t *e)
 {
 	struct deadline_data *dd;
-	struct deadline_rq *drq;
-	struct request *rq;
-	int i, ret = 0;
+	int i;
 
 	if (!drq_pool)
 		return -ENOMEM;
@@ -724,6 +707,13 @@
 		return -ENOMEM;
 	}
 
+	dd->drq_pool = mempool_create(BLKDEV_MIN_RQ, mempool_alloc_slab, mempool_free_slab, drq_pool);
+	if (!dd->drq_pool) {
+		kfree(dd->hash);
+		kfree(dd);
+		return -ENOMEM;
+	}
+
 	for (i = 0; i < DL_HASH_ENTRIES; i++)
 		INIT_LIST_HEAD(&dd->hash[i]);
 
@@ -739,33 +729,41 @@
 	dd->front_merges = 1;
 	dd->fifo_batch = fifo_batch;
 	e->elevator_data = dd;
+	return 0;
+}
 
-	for (i = READ; i <= WRITE; i++) {
-		struct request_list *rl = &q->rq[i];
-		struct list_head *entry;
-
-		list_for_each(entry, &rl->free) {
-			rq = list_entry_rq(entry);
-
-			drq = kmem_cache_alloc(drq_pool, GFP_KERNEL);
-			if (!drq) {
-				ret = -ENOMEM;
-				break;
-			}
+static void deadline_put_request(request_queue_t *q, struct request *rq)
+{
+	struct deadline_data *dd = q->elevator.elevator_data;
+	struct deadline_rq *drq = RQ_DATA(rq);
 
-			memset(drq, 0, sizeof(*drq));
-			INIT_LIST_HEAD(&drq->fifo);
-			INIT_LIST_HEAD(&drq->hash);
-			RB_CLEAR(&drq->rb_node);
-			drq->request = rq;
-			rq->elevator_private = drq;
-		}
+	if (drq) {
+		mempool_free(drq, dd->drq_pool);
+		rq->elevator_private = NULL;
 	}
+}
+
+static int
+deadline_set_request(request_queue_t *q, struct request *rq, int gfp_mask)
+{
+	struct deadline_data *dd = q->elevator.elevator_data;
+	struct deadline_rq *drq;
 
-	if (ret)
-		deadline_exit(q, e);
+	drq = mempool_alloc(dd->drq_pool, gfp_mask);
+	if (drq) {
+		RB_CLEAR(&drq->rb_node);
+		drq->request = rq;
 
-	return ret;
+		INIT_LIST_HEAD(&drq->hash);
+		drq->hash_valid_count = 0;
+
+		INIT_LIST_HEAD(&drq->fifo);
+
+		rq->elevator_private = drq;
+		return 0;
+	}
+
+	return 1;
 }
 
 /*
@@ -916,6 +914,8 @@
 	.elevator_queue_empty_fn =	deadline_queue_empty,
 	.elevator_former_req_fn =	deadline_former_request,
 	.elevator_latter_req_fn =	deadline_latter_request,
+	.elevator_set_req_fn =		deadline_set_request,
+	.elevator_put_req_fn = 		deadline_put_request,
 	.elevator_init_fn =		deadline_init,
 	.elevator_exit_fn =		deadline_exit,
 
===== drivers/block/elevator.c 1.40 vs edited =====
--- 1.40/drivers/block/elevator.c	Sun Feb 16 12:32:35 2003
+++ edited/drivers/block/elevator.c	Tue Mar 25 11:04:01 2003
@@ -408,6 +408,24 @@
 	return NULL;
 }
 
+int elv_set_request(request_queue_t *q, struct request *rq, int gfp_mask)
+{
+	elevator_t *e = &q->elevator;
+
+	if (e->elevator_set_req_fn)
+		return e->elevator_set_req_fn(q, rq, gfp_mask);
+
+	return 0;
+}
+
+void elv_put_request(request_queue_t *q, struct request *rq)
+{
+	elevator_t *e = &q->elevator;
+
+	if (e->elevator_put_req_fn)
+		e->elevator_put_req_fn(q, rq);
+}
+
 int elv_register_queue(struct gendisk *disk)
 {
 	request_queue_t *q = disk->queue;
===== drivers/block/ll_rw_blk.c 1.161 vs edited =====
--- 1.161/drivers/block/ll_rw_blk.c	Mon Mar 24 02:56:03 2003
+++ edited/drivers/block/ll_rw_blk.c	Tue Mar 25 12:20:16 2003
@@ -48,12 +48,6 @@
  */
 static int queue_nr_requests;
 
-/*
- * How many free requests must be available before we wake a process which
- * is waiting for a request?
- */
-static int batch_requests;
-
 unsigned long blk_max_low_pfn, blk_max_pfn;
 int blk_nohighio = 0;
 
@@ -1118,26 +1112,6 @@
 	spin_unlock_irq(&blk_plug_lock);
 }
 
-static int __blk_cleanup_queue(struct request_list *list)
-{
-	struct list_head *head = &list->free;
-	struct request *rq;
-	int i = 0;
-
-	while (!list_empty(head)) {
-		rq = list_entry(head->next, struct request, queuelist);
-		list_del_init(&rq->queuelist);
-		kmem_cache_free(request_cachep, rq);
-		i++;
-	}
-
-	if (i != list->count)
-		printk("request list leak!\n");
-
-	list->count = 0;
-	return i;
-}
-
 /**
  * blk_cleanup_queue: - release a &request_queue_t when it is no longer needed
  * @q:    the request queue to be released
@@ -1154,18 +1128,14 @@
  **/
 void blk_cleanup_queue(request_queue_t * q)
 {
-	int count = (queue_nr_requests*2);
+	struct request_list *rl = &q->rq;
 
 	elevator_exit(q);
 
-	count -= __blk_cleanup_queue(&q->rq[READ]);
-	count -= __blk_cleanup_queue(&q->rq[WRITE]);
-
 	del_timer_sync(&q->unplug_timer);
 	flush_scheduled_work();
 
-	if (count)
-		printk("blk_cleanup_queue: leaked requests (%d)\n", count);
+	mempool_destroy(rl->rq_pool);
 
 	if (blk_queue_tagged(q))
 		blk_queue_free_tags(q);
@@ -1175,42 +1145,17 @@
 
 static int blk_init_free_list(request_queue_t *q)
 {
-	struct request_list *rl;
-	struct request *rq;
-	int i;
+	struct request_list *rl = &q->rq;
 
-	INIT_LIST_HEAD(&q->rq[READ].free);
-	INIT_LIST_HEAD(&q->rq[WRITE].free);
-	q->rq[READ].count = 0;
-	q->rq[WRITE].count = 0;
+	rl->count[READ] = BLKDEV_MAX_RQ;
+	rl->count[WRITE] = BLKDEV_MAX_RQ;
 
-	/*
-	 * Divide requests in half between read and write
-	 */
-	rl = &q->rq[READ];
-	for (i = 0; i < (queue_nr_requests*2); i++) {
-		rq = kmem_cache_alloc(request_cachep, SLAB_KERNEL);
-		if (!rq)
-			goto nomem;
-
-		/*
-		 * half way through, switch to WRITE list
-		 */
-		if (i == queue_nr_requests)
-			rl = &q->rq[WRITE];
+	rl->rq_pool = mempool_create(BLKDEV_MIN_RQ, mempool_alloc_slab, mempool_free_slab, request_cachep);
 
-		memset(rq, 0, sizeof(struct request));
-		rq->rq_status = RQ_INACTIVE;
-		list_add(&rq->queuelist, &rl->free);
-		rl->count++;
-	}
+	if (!rl->rq_pool)
+		return -ENOMEM;
 
-	init_waitqueue_head(&q->rq[READ].wait);
-	init_waitqueue_head(&q->rq[WRITE].wait);
 	return 0;
-nomem:
-	blk_cleanup_queue(q);
-	return 1;
 }
 
 static int __make_request(request_queue_t *, struct bio *);
@@ -1277,34 +1222,62 @@
 	return 0;
 }
 
+static inline void blk_free_request(request_queue_t *q, struct request *rq)
+{
+	elv_put_request(q, rq);
+	mempool_free(rq, q->rq.rq_pool);
+}
+
+static inline struct request *blk_alloc_request(request_queue_t *q,int gfp_mask)
+{
+	struct request *rq = mempool_alloc(q->rq.rq_pool, gfp_mask);
+
+	if (rq) {
+		if (!elv_set_request(q, rq, gfp_mask))
+			return rq;
+
+		mempool_free(rq, q->rq.rq_pool);
+	}
+
+	return NULL;
+}
+
 #define blkdev_free_rq(list) list_entry((list)->next, struct request, queuelist)
 /*
- * Get a free request. queue lock must be held and interrupts
- * disabled on the way in.
+ * Get a free request, queue_lock must not be held
  */
-static struct request *get_request(request_queue_t *q, int rw)
+static struct request *get_request(request_queue_t *q, int rw, int gfp_mask)
 {
 	struct request *rq = NULL;
-	struct request_list *rl = q->rq + rw;
+	struct request_list *rl = &q->rq;
 
-	if (!list_empty(&rl->free)) {
-		rq = blkdev_free_rq(&rl->free);
-		list_del_init(&rq->queuelist);
-		rq->ref_count = 1;
-		rl->count--;
-		if (rl->count < queue_congestion_on_threshold())
+	/*
+	 * known racy, ok though
+	 */
+	if (!rl->count[rw])
+		return NULL;
+
+	rq = blk_alloc_request(q, gfp_mask);
+	if (rq) {
+		spin_lock_irq(q->queue_lock);
+		rl->count[rw]--;
+		if (rl->count[rw] < queue_congestion_on_threshold())
 			set_queue_congested(q, rw);
+		spin_unlock_irq(q->queue_lock);
+
+		INIT_LIST_HEAD(&rq->queuelist);
 		rq->flags = 0;
-		rq->rq_status = RQ_ACTIVE;
 		rq->errors = 0;
-		rq->special = NULL;
-		rq->buffer = NULL;
-		rq->data = NULL;
-		rq->sense = NULL;
-		rq->waiting = NULL;
+		rq->rq_status = RQ_ACTIVE;
 		rq->bio = rq->biotail = NULL;
+		rq->buffer = NULL;
+		rq->ref_count = 1;
 		rq->q = q;
 		rq->rl = rl;
+		rq->special = NULL;
+		rq->data = NULL;
+		rq->waiting = NULL;
+		rq->sense = NULL;
 	}
 
 	return rq;
@@ -1316,7 +1289,7 @@
 static struct request *get_request_wait(request_queue_t *q, int rw)
 {
 	DEFINE_WAIT(wait);
-	struct request_list *rl = &q->rq[rw];
+	struct request_list *rl = &q->rq;
 	struct request *rq;
 
 	spin_lock_prefetch(q->queue_lock);
@@ -1325,64 +1298,24 @@
 	do {
 		int block = 0;
 
-		prepare_to_wait_exclusive(&rl->wait, &wait,
-					TASK_UNINTERRUPTIBLE);
 		spin_lock_irq(q->queue_lock);
-		if (!rl->count)
+		if (!rl->count[rw])
 			block = 1;
 		spin_unlock_irq(q->queue_lock);
 
 		if (block)
 			io_schedule();
-		finish_wait(&rl->wait, &wait);
 
-		spin_lock_irq(q->queue_lock);
-		rq = get_request(q, rw);
-		spin_unlock_irq(q->queue_lock);
+		rq = get_request(q, rw, GFP_NOIO);
 	} while (rq == NULL);
 	return rq;
 }
 
 struct request *blk_get_request(request_queue_t *q, int rw, int gfp_mask)
 {
-	struct request *rq;
-
-	BUG_ON(rw != READ && rw != WRITE);
-
-	spin_lock_irq(q->queue_lock);
-	rq = get_request(q, rw);
-	spin_unlock_irq(q->queue_lock);
-
-	if (!rq && (gfp_mask & __GFP_WAIT))
-		rq = get_request_wait(q, rw);
-
-	if (rq) {
-		rq->flags = 0;
-		rq->buffer = NULL;
-		rq->bio = rq->biotail = NULL;
-		rq->waiting = NULL;
-	}
-	return rq;
-}
-
-/*
- * Non-locking blk_get_request variant, for special requests from drivers.
- */
-struct request *__blk_get_request(request_queue_t *q, int rw)
-{
-	struct request *rq;
-
 	BUG_ON(rw != READ && rw != WRITE);
 
-	rq = get_request(q, rw);
-
-	if (rq) {
-		rq->flags = 0;
-		rq->buffer = NULL;
-		rq->bio = rq->biotail = NULL;
-		rq->waiting = NULL;
-	}
-	return rq;
+	return get_request(q, rw, gfp_mask);
 }
 
 /**
@@ -1499,6 +1432,9 @@
 	disk->stamp_idle = now;
 }
 
+/*
+ * queue lock must be held
+ */
 void __blk_put_request(request_queue_t *q, struct request *req)
 {
 	struct request_list *rl = req->rl;
@@ -1508,34 +1444,26 @@
 	if (unlikely(!q))
 		return;
 
-	req->rq_status = RQ_INACTIVE;
-	req->q = NULL;
-	req->rl = NULL;
-
 	/*
 	 * Request may not have originated from ll_rw_blk. if not,
 	 * it didn't come out of our reserved rq pools
 	 */
 	if (rl) {
-		int rw = 0;
+		int rw = rq_data_dir(req);
 
 		BUG_ON(!list_empty(&req->queuelist));
 
-		list_add(&req->queuelist, &rl->free);
+		blk_free_request(q, req);
 
-		if (rl == &q->rq[WRITE])
-			rw = WRITE;
-		else if (rl == &q->rq[READ])
-			rw = READ;
-		else
-			BUG();
-
-		rl->count++;
-		if (rl->count >= queue_congestion_off_threshold())
+		rl->count[rw]++;
+		if (rl->count[rw] >= queue_congestion_off_threshold())
 			clear_queue_congested(q, rw);
-		if (rl->count >= batch_requests && waitqueue_active(&rl->wait))
-			wake_up(&rl->wait);
 	}
+
+	req->rq_status = RQ_INACTIVE;
+	req->q = NULL;
+	req->rl = NULL;
+	req->elevator_private = NULL;
 }
 
 void blk_put_request(struct request *req)
@@ -1694,9 +1622,9 @@
 
 	barrier = test_bit(BIO_RW_BARRIER, &bio->bi_rw);
 
-	spin_lock_irq(q->queue_lock);
 again:
 	insert_here = NULL;
+	spin_lock_irq(q->queue_lock);
 
 	if (blk_queue_empty(q)) {
 		blk_plug_device(q);
@@ -1769,12 +1697,12 @@
 	 * a free slot.
 	 */
 get_rq:
+	spin_unlock_irq(q->queue_lock);
+
 	if (freereq) {
 		req = freereq;
 		freereq = NULL;
-	} else if ((req = get_request(q, rw)) == NULL) {
-		spin_unlock_irq(q->queue_lock);
-
+	} else if ((req = get_request(q, rw, GFP_NOIO)) == NULL) {
 		/*
 		 * READA bit set
 		 */
@@ -1782,7 +1710,6 @@
 			goto end_io;
 
 		freereq = get_request_wait(q, rw);
-		spin_lock_irq(q->queue_lock);
 		goto again;
 	}
 
@@ -1809,19 +1736,20 @@
 	req->bio = req->biotail = bio;
 	req->rq_disk = bio->bi_bdev->bd_disk;
 	req->start_time = jiffies;
+
+	spin_lock_irq(q->queue_lock);
 	add_request(q, req, insert_here);
 out:
 	if (freereq)
 		__blk_put_request(q, freereq);
 
 	if (blk_queue_plugged(q)) {
-		int nr_queued = (queue_nr_requests - q->rq[0].count) +
-				(queue_nr_requests - q->rq[1].count);
+		int nr_queued = (queue_nr_requests - q->rq.count[0]) +
+				(queue_nr_requests - q->rq.count[1]);
 		if (nr_queued == q->unplug_thresh)
 			__generic_unplug_device(q);
 	}
 	spin_unlock_irq(q->queue_lock);
-
 	return 0;
 
 end_io:
@@ -2183,7 +2111,6 @@
 
 int __init blk_dev_init(void)
 {
-	int total_ram = nr_free_pages() << (PAGE_SHIFT - 10);
 	int i;
 
 	request_cachep = kmem_cache_create("blkdev_requests",
@@ -2191,24 +2118,11 @@
 	if (!request_cachep)
 		panic("Can't create request pool slab cache\n");
 
-	/*
-	 * Free request slots per queue.  One per quarter-megabyte.
-	 * We use this many requests for reads, and this many for writes.
-	 */
-	queue_nr_requests = (total_ram >> 9) & ~7;
-	if (queue_nr_requests < 16)
-		queue_nr_requests = 16;
-	if (queue_nr_requests > 128)
-		queue_nr_requests = 128;
-
-	batch_requests = queue_nr_requests / 8;
-	if (batch_requests > 8)
-		batch_requests = 8;
+	queue_nr_requests = BLKDEV_MAX_RQ;
 
 	printk("block request queues:\n");
-	printk(" %d requests per read queue\n", queue_nr_requests);
-	printk(" %d requests per write queue\n", queue_nr_requests);
-	printk(" %d requests per batch\n", batch_requests);
+	printk(" %d/%d requests per read queue\n", BLKDEV_MIN_RQ, queue_nr_requests);
+	printk(" %d/%d requests per write queue\n", BLKDEV_MIN_RQ, queue_nr_requests);
 	printk(" enter congestion at %d\n", queue_congestion_on_threshold());
 	printk(" exit congestion at %d\n", queue_congestion_off_threshold());
 
@@ -2250,7 +2164,6 @@
 EXPORT_SYMBOL(blk_phys_contig_segment);
 EXPORT_SYMBOL(blk_hw_contig_segment);
 EXPORT_SYMBOL(blk_get_request);
-EXPORT_SYMBOL(__blk_get_request);
 EXPORT_SYMBOL(blk_put_request);
 EXPORT_SYMBOL(blk_insert_request);
 
===== include/linux/blkdev.h 1.98 vs edited =====
--- 1.98/include/linux/blkdev.h	Tue Feb 18 11:29:00 2003
+++ edited/include/linux/blkdev.h	Tue Mar 25 12:12:20 2003
@@ -10,6 +10,7 @@
 #include <linux/pagemap.h>
 #include <linux/backing-dev.h>
 #include <linux/wait.h>
+#include <linux/mempool.h>
 
 #include <asm/scatterlist.h>
 
@@ -18,10 +19,12 @@
 struct elevator_s;
 typedef struct elevator_s elevator_t;
 
+#define BLKDEV_MIN_RQ	4
+#define BLKDEV_MAX_RQ	256
+
 struct request_list {
-	unsigned int count;
-	struct list_head free;
-	wait_queue_head_t wait;
+	int count[2];
+	mempool_t *rq_pool;
 };
 
 /*
@@ -180,7 +183,7 @@
 	/*
 	 * the queue request freelist, one for reads and one for writes
 	 */
-	struct request_list	rq[2];
+	struct request_list	rq;
 
 	request_fn_proc		*request_fn;
 	merge_request_fn	*back_merge_fn;
@@ -330,7 +333,6 @@
 extern void blk_attempt_remerge(request_queue_t *, struct request *);
 extern void __blk_attempt_remerge(request_queue_t *, struct request *);
 extern struct request *blk_get_request(request_queue_t *, int, int);
-extern struct request *__blk_get_request(request_queue_t *, int);
 extern void blk_put_request(struct request *);
 extern void blk_insert_request(request_queue_t *, struct request *, int, void *);
 extern void blk_plug_device(request_queue_t *);
===== include/linux/elevator.h 1.18 vs edited =====
--- 1.18/include/linux/elevator.h	Sun Jan 12 15:10:40 2003
+++ edited/include/linux/elevator.h	Tue Mar 25 11:03:42 2003
@@ -15,6 +15,8 @@
 typedef void (elevator_remove_req_fn) (request_queue_t *, struct request *);
 typedef struct request *(elevator_request_list_fn) (request_queue_t *, struct request *);
 typedef struct list_head *(elevator_get_sort_head_fn) (request_queue_t *, struct request *);
+typedef int (elevator_set_req_fn) (request_queue_t *, struct request *, int);
+typedef void (elevator_put_req_fn) (request_queue_t *, struct request *);
 
 typedef int (elevator_init_fn) (request_queue_t *, elevator_t *);
 typedef void (elevator_exit_fn) (request_queue_t *, elevator_t *);
@@ -34,6 +36,9 @@
 	elevator_request_list_fn *elevator_former_req_fn;
 	elevator_request_list_fn *elevator_latter_req_fn;
 
+	elevator_set_req_fn *elevator_set_req_fn;
+	elevator_put_req_fn *elevator_put_req_fn;
+
 	elevator_init_fn *elevator_init_fn;
 	elevator_exit_fn *elevator_exit_fn;
 
@@ -58,6 +63,8 @@
 extern struct request *elv_latter_request(request_queue_t *, struct request *);
 extern int elv_register_queue(struct gendisk *);
 extern void elv_unregister_queue(struct gendisk *);
+extern int elv_set_request(request_queue_t *, struct request *, int);
+extern void elv_put_request(request_queue_t *, struct request *);
 
 #define __elv_add_request_pos(q, rq, pos)	\
 	(q)->elevator.elevator_add_req_fn((q), (rq), (pos))

-- 
Jens Axboe

