Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261743AbTD3Iw0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 04:52:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261710AbTD3Iw0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 04:52:26 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:65154 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261743AbTD3IwF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 04:52:05 -0400
Date: Wed, 30 Apr 2003 11:04:25 +0200
From: Jens Axboe <axboe@suse.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Nick Piggin <piggin@cyberone.com.au>, suparna@in.ibm.com
Subject: [PATCH] rq-dyn, dynamic request allocation
Message-ID: <20030430090424.GK1012@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

An updated revision of the dynamic request allocation patch. Changes
since last version:

- Updated to latest 2.5-BK
- unplug race fix, courtesy of Nick. get_request() also looks nicer now.

 drivers/block/deadline-iosched.c |  105 +++++++------
 drivers/block/elevator.c         |   19 ++
 drivers/block/ll_rw_blk.c        |  308 ++++++++++++++-------------------------
 include/linux/blkdev.h           |   12 -
 include/linux/elevator.h         |    7 
 5 files changed, 208 insertions(+), 243 deletions(-)

===== drivers/block/deadline-iosched.c 1.17 vs edited =====
--- 1.17/drivers/block/deadline-iosched.c	Fri Mar 14 16:55:04 2003
+++ edited/drivers/block/deadline-iosched.c	Wed Apr  9 14:49:23 2003
@@ -28,7 +28,7 @@
 static int fifo_batch = 16;       /* # of sequential requests treated as one
 				     by the above parameters. For throughput. */
 
-static const int deadline_hash_shift = 10;
+static const int deadline_hash_shift = 5;
 #define DL_HASH_BLOCK(sec)	((sec) >> 3)
 #define DL_HASH_FN(sec)		(hash_long(DL_HASH_BLOCK((sec)), deadline_hash_shift))
 #define DL_HASH_ENTRIES		(1 << deadline_hash_shift)
@@ -71,6 +71,8 @@
 	int fifo_batch;
 	int writes_starved;
 	int front_merges;
+
+	mempool_t *drq_pool;
 };
 
 /*
@@ -130,6 +132,21 @@
 	list_add(&drq->hash, &dd->hash[DL_HASH_FN(rq_hash_key(rq))]);
 }
 
+/*
+ * move hot entry to front of chain
+ */
+static inline void
+deadline_hot_drq_hash(struct deadline_data *dd, struct deadline_rq *drq)
+{
+	struct request *rq = drq->request;
+	struct list_head *head = &dd->hash[DL_HASH_FN(rq_hash_key(rq))];
+
+	if (ON_HASH(drq) && drq->hash.prev != head) {
+		list_del(&drq->hash);
+		list_add(&drq->hash, head);
+	}
+}
+
 static struct request *
 deadline_find_drq_hash(struct deadline_data *dd, sector_t offset)
 {
@@ -353,6 +370,8 @@
 out:
 	q->last_merge = &__rq->queuelist;
 out_insert:
+	if (ret)
+		deadline_hot_drq_hash(dd, RQ_DATA(__rq));
 	*insert = &__rq->queuelist;
 	return ret;
 }
@@ -673,28 +692,11 @@
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
@@ -706,9 +708,7 @@
 static int deadline_init(request_queue_t *q, elevator_t *e)
 {
 	struct deadline_data *dd;
-	struct deadline_rq *drq;
-	struct request *rq;
-	int i, ret = 0;
+	int i;
 
 	if (!drq_pool)
 		return -ENOMEM;
@@ -724,6 +724,13 @@
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
 
@@ -739,33 +746,41 @@
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
 
-	if (ret)
-		deadline_exit(q, e);
+static int
+deadline_set_request(request_queue_t *q, struct request *rq, int gfp_mask)
+{
+	struct deadline_data *dd = q->elevator.elevator_data;
+	struct deadline_rq *drq;
 
-	return ret;
+	drq = mempool_alloc(dd->drq_pool, gfp_mask);
+	if (drq) {
+		RB_CLEAR(&drq->rb_node);
+		drq->request = rq;
+
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
@@ -916,6 +931,8 @@
 	.elevator_queue_empty_fn =	deadline_queue_empty,
 	.elevator_former_req_fn =	deadline_former_request,
 	.elevator_latter_req_fn =	deadline_latter_request,
+	.elevator_set_req_fn =		deadline_set_request,
+	.elevator_put_req_fn = 		deadline_put_request,
 	.elevator_init_fn =		deadline_init,
 	.elevator_exit_fn =		deadline_exit,
 
===== drivers/block/elevator.c 1.40 vs edited =====
--- 1.40/drivers/block/elevator.c	Sun Feb 16 12:32:35 2003
+++ edited/drivers/block/elevator.c	Wed Apr  9 14:49:26 2003
@@ -408,6 +408,25 @@
 	return NULL;
 }
 
+int elv_set_request(request_queue_t *q, struct request *rq, int gfp_mask)
+{
+	elevator_t *e = &q->elevator;
+
+	if (e->elevator_set_req_fn)
+		return e->elevator_set_req_fn(q, rq, gfp_mask);
+
+	rq->elevator_private = NULL;
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
===== drivers/block/ll_rw_blk.c 1.168 vs edited =====
--- 1.168/drivers/block/ll_rw_blk.c	Thu Apr 24 12:23:09 2003
+++ edited/drivers/block/ll_rw_blk.c	Wed Apr 30 11:01:48 2003
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
 
@@ -419,7 +413,7 @@
 {
 	struct blk_queue_tag *bqt = q->queue_tags;
 
-	if(unlikely(bqt == NULL || bqt->max_depth < tag))
+	if (unlikely(bqt == NULL || bqt->max_depth < tag))
 		return NULL;
 
 	return bqt->tag_index[tag];
@@ -1122,26 +1116,6 @@
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
@@ -1158,18 +1132,14 @@
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
@@ -1179,42 +1149,17 @@
 
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
+	rl->rq_pool = mempool_create(BLKDEV_MIN_RQ, mempool_alloc_slab, mempool_free_slab, request_cachep);
 
-		/*
-		 * half way through, switch to WRITE list
-		 */
-		if (i == queue_nr_requests)
-			rl = &q->rq[WRITE];
-
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
@@ -1276,41 +1221,80 @@
 	blk_queue_max_hw_segments(q, MAX_HW_SEGMENTS);
 	blk_queue_max_phys_segments(q, MAX_PHYS_SEGMENTS);
 
-	INIT_LIST_HEAD(&q->plug_list);
-
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
+	if (!rq)
+		return NULL;
+
+	if (!elv_set_request(q, rq, gfp_mask))
+		return rq;
+
+	mempool_free(rq, q->rq.rq_pool);
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
-			set_queue_congested(q, rw);
-		rq->flags = 0;
-		rq->rq_status = RQ_ACTIVE;
-		rq->errors = 0;
-		rq->special = NULL;
-		rq->buffer = NULL;
-		rq->data = NULL;
-		rq->sense = NULL;
-		rq->waiting = NULL;
-		rq->bio = rq->biotail = NULL;
-		rq->q = q;
-		rq->rl = rl;
+	spin_lock_irq(q->queue_lock);
+	BUG_ON(rl->count[rw] < 0);
+	if (rl->count[rw] == 0) {
+		spin_unlock_irq(q->queue_lock);
+		goto out;
 	}
+	rl->count[rw]--;
+	if (rl->count[rw] < queue_congestion_on_threshold())
+		set_queue_congested(q, rw);
+	spin_unlock_irq(q->queue_lock);
 
+	rq = blk_alloc_request(q, gfp_mask);
+	if (!rq) {
+		spin_lock_irq(q->queue_lock);
+		rl->count[rw]++;
+		if (rl->count[rw] >= queue_congestion_off_threshold())
+			clear_queue_congested(q, rw);
+		spin_unlock_irq(q->queue_lock);
+		goto out;
+	}
+	
+	INIT_LIST_HEAD(&rq->queuelist);
+
+	/*
+	 * first three bits are identical in rq->flags and bio->bi_rw,
+	 * see bio.h and blkdev.h
+	 */
+	rq->flags = rw;
+
+	rq->errors = 0;
+	rq->rq_status = RQ_ACTIVE;
+	rq->bio = rq->biotail = NULL;
+	rq->buffer = NULL;
+	rq->ref_count = 1;
+	rq->q = q;
+	rq->rl = rl;
+	rq->waiting = NULL;
+	rq->special = NULL;
+	rq->data = NULL;
+	rq->sense = NULL;
+
+out:
 	return rq;
 }
 
@@ -1319,31 +1303,16 @@
  */
 static struct request *get_request_wait(request_queue_t *q, int rw)
 {
-	DEFINE_WAIT(wait);
-	struct request_list *rl = &q->rq[rw];
 	struct request *rq;
 
-	spin_lock_prefetch(q->queue_lock);
-
 	generic_unplug_device(q);
 	do {
-		int block = 0;
+		rq = get_request(q, rw, GFP_NOIO);
 
-		prepare_to_wait_exclusive(&rl->wait, &wait,
-					TASK_UNINTERRUPTIBLE);
-		spin_lock_irq(q->queue_lock);
-		if (!rl->count)
-			block = 1;
-		spin_unlock_irq(q->queue_lock);
-
-		if (block)
-			io_schedule();
-		finish_wait(&rl->wait, &wait);
+		if (!rq)
+			blk_congestion_wait(rw, HZ / 50);
+	} while (!rq);
 
-		spin_lock_irq(q->queue_lock);
-		rq = get_request(q, rw);
-		spin_unlock_irq(q->queue_lock);
-	} while (rq == NULL);
 	return rq;
 }
 
@@ -1353,39 +1322,11 @@
 
 	BUG_ON(rw != READ && rw != WRITE);
 
-	spin_lock_irq(q->queue_lock);
-	rq = get_request(q, rw);
-	spin_unlock_irq(q->queue_lock);
+	rq = get_request(q, rw, gfp_mask);
 
 	if (!rq && (gfp_mask & __GFP_WAIT))
 		rq = get_request_wait(q, rw);
 
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
-	BUG_ON(rw != READ && rw != WRITE);
-
-	rq = get_request(q, rw);
-
-	if (rq) {
-		rq->flags = 0;
-		rq->buffer = NULL;
-		rq->bio = rq->biotail = NULL;
-		rq->waiting = NULL;
-	}
 	return rq;
 }
 
@@ -1503,14 +1444,17 @@
 	disk->stamp_idle = now;
 }
 
+/*
+ * queue lock must be held
+ */
 void __blk_put_request(request_queue_t *q, struct request *req)
 {
 	struct request_list *rl = req->rl;
 
-	if (unlikely(--req->ref_count))
-		return;
 	if (unlikely(!q))
 		return;
+	if (unlikely(--req->ref_count))
+		return;
 
 	req->rq_status = RQ_INACTIVE;
 	req->q = NULL;
@@ -1521,24 +1465,15 @@
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
 }
 
@@ -1605,24 +1540,23 @@
 	 * will have updated segment counts, update sector
 	 * counts here.
 	 */
-	if (q->merge_requests_fn(q, req, next)) {
-		req->biotail->bi_next = next->bio;
-		req->biotail = next->biotail;
+	if (!q->merge_requests_fn(q, req, next))
+		return 0;
 
-		req->nr_sectors = req->hard_nr_sectors += next->hard_nr_sectors;
+	req->biotail->bi_next = next->bio;
+	req->biotail = next->biotail;
 
-		elv_merge_requests(q, req, next);
+	req->nr_sectors = req->hard_nr_sectors += next->hard_nr_sectors;
 
-		if (req->rq_disk) {
-			disk_round_stats(req->rq_disk);
-			disk_stat_dec(req->rq_disk, in_flight);
-		}
+	elv_merge_requests(q, req, next);
 
-		__blk_put_request(q, next);
-		return 1;
+	if (req->rq_disk) {
+		disk_round_stats(req->rq_disk);
+		disk_stat_dec(req->rq_disk, in_flight);
 	}
 
-	return 0;
+	__blk_put_request(q, next);
+	return 1;
 }
 
 static inline int attempt_back_merge(request_queue_t *q, struct request *rq)
@@ -1698,9 +1632,9 @@
 
 	barrier = test_bit(BIO_RW_BARRIER, &bio->bi_rw);
 
-	spin_lock_irq(q->queue_lock);
 again:
 	insert_here = NULL;
+	spin_lock_irq(q->queue_lock);
 
 	if (elv_queue_empty(q)) {
 		blk_plug_device(q);
@@ -1776,17 +1710,17 @@
 	if (freereq) {
 		req = freereq;
 		freereq = NULL;
-	} else if ((req = get_request(q, rw)) == NULL) {
+	} else {
 		spin_unlock_irq(q->queue_lock);
-
-		/*
-		 * READA bit set
-		 */
-		if (bio_flagged(bio, BIO_RW_AHEAD))
-			goto end_io;
-
-		freereq = get_request_wait(q, rw);
-		spin_lock_irq(q->queue_lock);
+		if ((freereq = get_request(q, rw, GFP_ATOMIC)) == NULL) {
+			/*
+			 * READA bit set
+			 */
+			if (bio_flagged(bio, BIO_RW_AHEAD))
+				goto end_io;
+	
+			freereq = get_request_wait(q, rw);
+		}
 		goto again;
 	}
 
@@ -1813,14 +1747,15 @@
 	req->bio = req->biotail = bio;
 	req->rq_disk = bio->bi_bdev->bd_disk;
 	req->start_time = jiffies;
+
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
@@ -2213,7 +2148,6 @@
 
 int __init blk_dev_init(void)
 {
-	int total_ram = nr_free_pages() << (PAGE_SHIFT - 10);
 	int i;
 
 	request_cachep = kmem_cache_create("blkdev_requests",
@@ -2221,24 +2155,11 @@
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
 
@@ -2281,7 +2202,6 @@
 EXPORT_SYMBOL(blk_phys_contig_segment);
 EXPORT_SYMBOL(blk_hw_contig_segment);
 EXPORT_SYMBOL(blk_get_request);
-EXPORT_SYMBOL(__blk_get_request);
 EXPORT_SYMBOL(blk_put_request);
 EXPORT_SYMBOL(blk_insert_request);
 
===== include/linux/blkdev.h 1.101 vs edited =====
--- 1.101/include/linux/blkdev.h	Thu Apr 24 12:23:09 2003
+++ edited/include/linux/blkdev.h	Wed Apr 30 10:53:52 2003
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
+#define BLKDEV_MAX_RQ	1024
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
@@ -329,7 +332,6 @@
 extern void blk_attempt_remerge(request_queue_t *, struct request *);
 extern void __blk_attempt_remerge(request_queue_t *, struct request *);
 extern struct request *blk_get_request(request_queue_t *, int, int);
-extern struct request *__blk_get_request(request_queue_t *, int);
 extern void blk_put_request(struct request *);
 extern void blk_insert_request(request_queue_t *, struct request *, int, void *);
 extern void blk_plug_device(request_queue_t *);
===== include/linux/elevator.h 1.18 vs edited =====
--- 1.18/include/linux/elevator.h	Sun Jan 12 15:10:40 2003
+++ edited/include/linux/elevator.h	Wed Apr  2 12:03:34 2003
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

