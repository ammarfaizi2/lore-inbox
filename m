Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262114AbTEJJIR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 May 2003 05:08:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263695AbTEJJIR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 May 2003 05:08:17 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:8321 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262114AbTEJJID (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 May 2003 05:08:03 -0400
Date: Sat, 10 May 2003 11:20:41 +0200
From: Jens Axboe <axboe@suse.de>
To: Shane Shrybman <shrybman@sympatico.ca>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@digeo.com>
Subject: Re: Can't find CDR device in -mm only
Message-ID: <20030510092041.GN812@suse.de>
References: <1052537820.2441.113.camel@mars.goatskin.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="GvXjxJ+pjyke8COw"
Content-Disposition: inline
In-Reply-To: <1052537820.2441.113.camel@mars.goatskin.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--GvXjxJ+pjyke8COw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 09 2003, Shane Shrybman wrote:
> Hi,
> 
> The problem first appeared in 2.5.68-mm3 and is not in mainline 2.5.69.
> It is present in all -mm releases since.

Curious. Looking at patches between .68-mm2 and -mm3 reveals nothing
major, in fact the only thing touching anything in that area seems to be
the dynamic request allocation patch. Could you try 2.5.69 with the
attached patch to verify that it still works (or doesn't)? There might
be a small offset in deadline-iosched.c, should be nothing to worry
about.

-- 
Jens Axboe


--GvXjxJ+pjyke8COw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=rq-dyn

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1084  -> 1.1085 
#	include/linux/elevator.h	1.19    -> 1.20   
#	drivers/block/ll_rw_blk.c	1.168   -> 1.169  
#	include/linux/blkdev.h	1.102   -> 1.103  
#	drivers/block/elevator.c	1.40    -> 1.41   
#	drivers/block/deadline-iosched.c	1.18    -> 1.19   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/05/09	axboe@smithers.home.kernel.dk	1.1085
# This patch adds dynamic allocation of request structures. Right now we
# are reserving 256 requests per initialized queue, which adds up to quite
# a lot of memory for even a modest number of queues. For the quoted 4000
# disk systems, it's a disaster.
# 
# Instead, we mempool 4 requests per queue and put an upper limit on the
# number of requests that we will put in-flight as well. I've kept the 128
# read/write max in-flight limit for now. It is trivial to experiement
# with larger queue sizes now, but I want to change one thing at the time
# (the truncate scenario doesn't look all that good with a huge number of
# requests, for instance).
# 
# Patch has been in -mm for a while, I'm running it here against stock 2.5
# as well. Additionally, it actually kills quite a bit of code as well
# --------------------------------------------
#
diff -Nru a/drivers/block/deadline-iosched.c b/drivers/block/deadline-iosched.c
--- a/drivers/block/deadline-iosched.c	Fri May  9 09:36:46 2003
+++ b/drivers/block/deadline-iosched.c	Fri May  9 09:36:46 2003
@@ -71,6 +71,8 @@
 	int fifo_batch;
 	int writes_starved;
 	int front_merges;
+
+	mempool_t *drq_pool;
 };
 
 /*
@@ -690,28 +692,11 @@
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
@@ -723,9 +708,7 @@
 static int deadline_init(request_queue_t *q, elevator_t *e)
 {
 	struct deadline_data *dd;
-	struct deadline_rq *drq;
-	struct request *rq;
-	int i, ret = 0;
+	int i;
 
 	if (!drq_pool)
 		return -ENOMEM;
@@ -741,6 +724,13 @@
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
 
@@ -756,33 +746,41 @@
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
@@ -933,6 +931,8 @@
 	.elevator_queue_empty_fn =	deadline_queue_empty,
 	.elevator_former_req_fn =	deadline_former_request,
 	.elevator_latter_req_fn =	deadline_latter_request,
+	.elevator_set_req_fn =		deadline_set_request,
+	.elevator_put_req_fn = 		deadline_put_request,
 	.elevator_init_fn =		deadline_init,
 	.elevator_exit_fn =		deadline_exit,
 
diff -Nru a/drivers/block/elevator.c b/drivers/block/elevator.c
--- a/drivers/block/elevator.c	Fri May  9 09:36:45 2003
+++ b/drivers/block/elevator.c	Fri May  9 09:36:46 2003
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
diff -Nru a/drivers/block/ll_rw_blk.c b/drivers/block/ll_rw_blk.c
--- a/drivers/block/ll_rw_blk.c	Fri May  9 09:36:45 2003
+++ b/drivers/block/ll_rw_blk.c	Fri May  9 09:36:45 2003
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
@@ -1179,42 +1149,16 @@
 
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
+	rl->count[READ] = rl->count[WRITE] = 0;
 
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
@@ -1276,41 +1220,79 @@
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
+	if (rl->count[rw] == BLKDEV_MAX_RQ) {
+		spin_unlock_irq(q->queue_lock);
+		goto out;
 	}
+	rl->count[rw]++;
+	if ((BLKDEV_MAX_RQ - rl->count[rw]) < queue_congestion_on_threshold())
+		set_queue_congested(q, rw);
+	spin_unlock_irq(q->queue_lock);
 
+	rq = blk_alloc_request(q, gfp_mask);
+	if (!rq) {
+		spin_lock_irq(q->queue_lock);
+		rl->count[rw]--;
+		if ((BLKDEV_MAX_RQ - rl->count[rw]) >= queue_congestion_off_threshold())
+                        clear_queue_congested(q, rw);
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
 
@@ -1319,31 +1301,16 @@
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
-
-		prepare_to_wait_exclusive(&rl->wait, &wait,
-					TASK_UNINTERRUPTIBLE);
-		spin_lock_irq(q->queue_lock);
-		if (!rl->count)
-			block = 1;
-		spin_unlock_irq(q->queue_lock);
+		rq = get_request(q, rw, GFP_NOIO);
 
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
 
@@ -1353,39 +1320,11 @@
 
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
 
@@ -1503,14 +1442,17 @@
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
@@ -1521,24 +1463,15 @@
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
+		rl->count[rw]--;
+		if ((BLKDEV_MAX_RQ - rl->count[rw]) >= queue_congestion_off_threshold())
 			clear_queue_congested(q, rw);
-		if (rl->count >= batch_requests && waitqueue_active(&rl->wait))
-			wake_up(&rl->wait);
 	}
 }
 
@@ -1605,24 +1538,23 @@
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
@@ -1698,9 +1630,9 @@
 
 	barrier = test_bit(BIO_RW_BARRIER, &bio->bi_rw);
 
-	spin_lock_irq(q->queue_lock);
 again:
 	insert_here = NULL;
+	spin_lock_irq(q->queue_lock);
 
 	if (elv_queue_empty(q)) {
 		blk_plug_device(q);
@@ -1776,17 +1708,17 @@
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
 
@@ -1813,14 +1745,15 @@
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
+		int nr_queued = q->rq.count[0] + q->rq.count[1];
+
 		if (nr_queued == q->unplug_thresh)
 			__generic_unplug_device(q);
 	}
@@ -2213,7 +2146,6 @@
 
 int __init blk_dev_init(void)
 {
-	int total_ram = nr_free_pages() << (PAGE_SHIFT - 10);
 	int i;
 
 	request_cachep = kmem_cache_create("blkdev_requests",
@@ -2221,24 +2153,11 @@
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
 
@@ -2281,7 +2200,6 @@
 EXPORT_SYMBOL(blk_phys_contig_segment);
 EXPORT_SYMBOL(blk_hw_contig_segment);
 EXPORT_SYMBOL(blk_get_request);
-EXPORT_SYMBOL(__blk_get_request);
 EXPORT_SYMBOL(blk_put_request);
 EXPORT_SYMBOL(blk_insert_request);
 
diff -Nru a/include/linux/blkdev.h b/include/linux/blkdev.h
--- a/include/linux/blkdev.h	Fri May  9 09:36:45 2003
+++ b/include/linux/blkdev.h	Fri May  9 09:36:45 2003
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
+#define BLKDEV_MAX_RQ	128
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
diff -Nru a/include/linux/elevator.h b/include/linux/elevator.h
--- a/include/linux/elevator.h	Fri May  9 09:36:45 2003
+++ b/include/linux/elevator.h	Fri May  9 09:36:45 2003
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
 
@@ -59,6 +64,8 @@
 extern struct request *elv_latter_request(request_queue_t *, struct request *);
 extern int elv_register_queue(struct gendisk *);
 extern void elv_unregister_queue(struct gendisk *);
+extern int elv_set_request(request_queue_t *, struct request *, int);
+extern void elv_put_request(request_queue_t *, struct request *);
 
 #define __elv_add_request_pos(q, rq, pos)	\
 	(q)->elevator.elevator_add_req_fn((q), (rq), (pos))

--GvXjxJ+pjyke8COw--
