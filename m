Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261860AbTDBHb7>; Wed, 2 Apr 2003 02:31:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262000AbTDBHb7>; Wed, 2 Apr 2003 02:31:59 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:2945 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S261860AbTDBHbl>;
	Wed, 2 Apr 2003 02:31:41 -0500
Date: Wed, 2 Apr 2003 09:42:27 +0200
From: Jens Axboe <axboe@suse.de>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: Con Kolivas <kernel@kolivas.org>, Andrew Morton <akpm@digeo.com>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [BENCHMARK] 2.5.66-mm2 with contest
Message-ID: <20030402074227.GH901@suse.de>
References: <200304021324.10799.kernel@kolivas.org> <3E8A6227.7080209@cyberone.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E8A6227.7080209@cyberone.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 02 2003, Nick Piggin wrote:
> Con Kolivas wrote:
> 
> >Big rise in ctar_load and io_load. Drop in read_load.
> >(All uniprocessor with IDE and AS elevator). AS tweaks? No obvious 
> >scheduler tweak result changes.
> >
> Thanks Con,
> I'm a bit busy now, but next week I'll work something out for it.
> It is most likely to be as-queue_notready-cleanup.patch. I'll
> wait until after Jens ports his dynamic requests stuff over to
> mm before I go further.

It is ported, I sent Andrew the patch yesterday. I'm attaching it here
as well.

diff -ur -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.5.66-mm2/drivers/block/as-iosched.c linux-2.5.66-mm2/drivers/block/as-iosched.c
--- /opt/kernel/linux-2.5.66-mm2/drivers/block/as-iosched.c	2003-04-01 12:51:18.000000000 +0200
+++ linux-2.5.66-mm2/drivers/block/as-iosched.c	2003-04-01 13:25:27.520429192 +0200
@@ -117,6 +117,7 @@
 	unsigned long current_batch_expires;
 	unsigned long last_check_fifo[2];
 	int batch_data_dir;		/* current/last batch READ or WRITE */
+	mempool_t *arq_pool;
 
 	int antic_status;
 	unsigned long antic_start;	/* jiffies: when it started */
@@ -1461,12 +1462,42 @@
 	spin_unlock_irqrestore(q->queue_lock, flags);
 }
 
+static void as_put_request(request_queue_t *q, struct request *rq)
+{
+	struct as_data *ad = q->elevator.elevator_data;
+	struct as_rq *arq = RQ_DATA(rq);
+
+	if (arq) {
+		mempool_free(arq, ad->arq_pool);
+		rq->elevator_private = NULL;
+	}
+}
+
+static int as_set_request(request_queue_t *q, struct request *rq, int gfp_mask)
+{
+	struct as_data *ad = q->elevator.elevator_data;
+	struct as_rq *arq = mempool_alloc(ad->arq_pool, gfp_mask);
+
+	if (arq) {
+		RB_CLEAR(&arq->rb_node);
+		arq->request = rq;
+
+		arq->as_io_context = NULL;
+		INIT_LIST_HEAD(&arq->hash);
+		arq->hash_valid_count = 0;
+
+		INIT_LIST_HEAD(&arq->fifo);
+
+		rq->elevator_private = arq;
+		return 0;
+	}
+
+	return 1;
+}
+
 static void as_exit(request_queue_t *q, elevator_t *e)
 {
 	struct as_data *ad = e->elevator_data;
-	struct as_rq *arq;
-	struct request *rq;
-	int i;
 
 	del_timer_sync(&ad->antic_timer);
 	kblockd_flush();
@@ -1474,21 +1505,7 @@
 	BUG_ON(!list_empty(&ad->fifo_list[READ]));
 	BUG_ON(!list_empty(&ad->fifo_list[WRITE]));
 
-	for (i = READ; i <= WRITE; i++) {
-		struct request_list *rl = &q->rq[i];
-		struct list_head *entry;
-
-		list_for_each(entry, &rl->free) {
-			rq = list_entry_rq(entry);
-
-			if ((arq = RQ_DATA(rq)) == NULL)
-				continue;
-
-			rq->elevator_private = NULL;
-			kmem_cache_free(arq_pool, arq);
-		}
-	}
-
+	mempool_destroy(ad->arq_pool);
 	put_as_io_context(&ad->as_io_context);
 	kfree(ad->hash);
 	kfree(ad);
@@ -1501,9 +1518,7 @@
 static int as_init(request_queue_t *q, elevator_t *e)
 {
 	struct as_data *ad;
-	struct as_rq *arq;
-	struct request *rq;
-	int i, ret = 0;
+	int i;
 
 	if (!arq_pool)
 		return -ENOMEM;
@@ -1521,6 +1536,13 @@
 		return -ENOMEM;
 	}
 
+	ad->arq_pool = mempool_create(BLKDEV_MIN_RQ, mempool_alloc_slab, mempool_free_slab, arq_pool);
+	if (!ad->arq_pool) {
+		kfree(ad->hash);
+		kfree(ad);
+		return -ENOMEM;
+	}
+
 	/* anticipatory scheduling helpers */
 	ad->antic_timer.function = as_antic_timeout;
 	ad->antic_timer.data = (unsigned long)q;
@@ -1544,33 +1566,7 @@
 	e->elevator_data = ad;
 
 	ad->current_batch_expires = jiffies + ad->batch_expire[READ];
-
-	for (i = READ; i <= WRITE; i++) {
-		struct request_list *rl = &q->rq[i];
-		struct list_head *entry;
-
-		list_for_each(entry, &rl->free) {
-			rq = list_entry_rq(entry);
-
-			arq = kmem_cache_alloc(arq_pool, GFP_KERNEL);
-			if (!arq) {
-				ret = -ENOMEM;
-				break;
-			}
-
-			memset(arq, 0, sizeof(*arq));
-			INIT_LIST_HEAD(&arq->fifo);
-			INIT_LIST_HEAD(&arq->hash);
-			RB_CLEAR(&arq->rb_node);
-			arq->request = rq;
-			rq->elevator_private = arq;
-		}
-	}
-
-	if (ret)
-		as_exit(q, e);
-
-	return ret;
+	return 0;
 }
 
 /*
@@ -1723,6 +1719,8 @@
 	.elevator_queue_empty_fn =	as_queue_notready,
 	.elevator_former_req_fn =	as_former_request,
 	.elevator_latter_req_fn =	as_latter_request,
+	.elevator_set_req_fn =		as_set_request,
+	.elevator_put_req_fn =		as_put_request,
 	.elevator_init_fn =		as_init,
 	.elevator_exit_fn =		as_exit,
 
diff -ur -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.5.66-mm2/drivers/block/cfq-iosched.c linux-2.5.66-mm2/drivers/block/cfq-iosched.c
--- /opt/kernel/linux-2.5.66-mm2/drivers/block/cfq-iosched.c	2003-04-01 12:51:18.000000000 +0200
+++ linux-2.5.66-mm2/drivers/block/cfq-iosched.c	2003-04-01 13:26:42.304060352 +0200
@@ -73,7 +73,7 @@
 
 	int busy_queues;
 
-	unsigned long random_seed;
+	mempool_t *crq_pool;
 };
 
 struct cfq_rq {
@@ -562,51 +562,48 @@
 	return ret;
 }
 
-static void cfq_exit(request_queue_t *q, elevator_t *e)
+static void cfq_put_request(request_queue_t *q, struct request *rq)
 {
-	struct cfq_data *cfqd = e->elevator_data;
-	struct cfq_rq *crq;
-	struct request *rq;
-	int i;
-
-	for (i = READ; i <= WRITE; i++) {
-		struct request_list *rl = &q->rq[i];
-		struct list_head *entry;
-
-		list_for_each(entry, &rl->free) {
-			rq = list_entry_rq(entry);
-
-			crq = RQ_DATA(rq);
-			if (!crq)
-				continue;
+	struct cfq_data *cfqd = q->elevator.elevator_data;
+	struct cfq_rq *crq = RQ_DATA(rq);
 
-			rq->elevator_private = NULL;
-			kmem_cache_free(crq_pool, crq);
-		}
+	if (crq) {
+		mempool_free(crq, cfqd->crq_pool);
+		rq->elevator_private = NULL;
 	}
-
-	e->elevator_data = NULL;
-	kfree(cfqd->crq_hash);
-	kfree(cfqd->cfq_hash);
-	kfree(cfqd);
 }
 
-static void *slab_pool_alloc(int gfp_mask, void *data)
+static int cfq_set_request(request_queue_t *q, struct request *rq, int gfp_mask)
 {
-	return kmem_cache_alloc(data, gfp_mask);
+	struct cfq_data *cfqd = q->elevator.elevator_data;
+	struct cfq_rq *crq = mempool_alloc(cfqd->crq_pool, gfp_mask);
+
+	if (crq) {
+		crq->request = rq;
+		crq->cfq_queue = NULL;
+		INIT_LIST_HEAD(&crq->hash);
+		rq->elevator_private = crq;
+		return 0;
+	}
+
+	return 1;
 }
 
-static void slab_pool_free(void *ptr, void *data)
+static void cfq_exit(request_queue_t *q, elevator_t *e)
 {
-	kmem_cache_free(data, ptr);
+	struct cfq_data *cfqd = e->elevator_data;
+
+	e->elevator_data = NULL;
+	mempool_destroy(cfqd->crq_pool);
+	kfree(cfqd->crq_hash);
+	kfree(cfqd->cfq_hash);
+	kfree(cfqd);
 }
 
 static int cfq_init(request_queue_t *q, elevator_t *e)
 {
 	struct cfq_data *cfqd;
-	struct request *rq;
-	struct cfq_rq *crq;
-	int i, ret = 0;
+	int i;
 
 	cfqd = kmalloc(sizeof(*cfqd), GFP_KERNEL);
 	if (!cfqd)
@@ -623,34 +620,20 @@
 	if (!cfqd->cfq_hash)
 		goto out_cfqhash;
 
+	cfqd->crq_pool = mempool_create(BLKDEV_MIN_RQ, mempool_alloc_slab, mempool_free_slab, crq_pool);
+	if (!cfqd->crq_pool)
+		goto out_crqpool;
+
 	for (i = 0; i < CFQ_MHASH_ENTRIES; i++)
 		INIT_LIST_HEAD(&cfqd->crq_hash[i]);
 	for (i = 0; i < CFQ_QHASH_ENTRIES; i++)
 		INIT_LIST_HEAD(&cfqd->cfq_hash[i]);
 
-	for (i = READ; i <= WRITE; i++) {
-		struct request_list *rl = &q->rq[i];
-		struct list_head *entry;
-
-		list_for_each(entry, &rl->free) {
-			rq = list_entry_rq(entry);
-
-			crq = kmem_cache_alloc(crq_pool, GFP_KERNEL);
-			if (!crq) {
-				ret = -ENOMEM;
-				break;
-			}
-
-			memset(crq, 0, sizeof(*crq));
-			INIT_LIST_HEAD(&crq->hash);
-			crq->request = rq;
-			rq->elevator_private = crq;
-		}
-	}
-
 	cfqd->dispatch = &q->queue_head;
 	e->elevator_data = cfqd;
-	return ret;
+	return 0;
+out_crqpool:
+	kfree(cfqd->cfq_hash);
 out_cfqhash:
 	kfree(cfqd->crq_hash);
 out_crqhash:
@@ -672,7 +655,7 @@
 	if (!cfq_pool)
 		panic("cfq_iosched: can't init cfq pool\n");
 
-	cfq_mpool = mempool_create(64, slab_pool_alloc, slab_pool_free, cfq_pool);
+	cfq_mpool = mempool_create(64, mempool_alloc_slab, mempool_free_slab, cfq_pool);
 
 	if (!cfq_mpool)
 		panic("cfq_iosched: can't init cfq mpool\n");
@@ -692,6 +675,8 @@
 	.elevator_queue_empty_fn =	cfq_queue_empty,
 	.elevator_former_req_fn =	cfq_former_request,
 	.elevator_latter_req_fn =	cfq_latter_request,
+	.elevator_set_req_fn =		cfq_set_request,
+	.elevator_put_req_fn =		cfq_put_request,
 	.elevator_may_queue_fn =	cfq_may_queue,
 	.elevator_init_fn =		cfq_init,
 	.elevator_exit_fn =		cfq_exit,
diff -ur -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.5.66-mm2/drivers/block/deadline-iosched.c linux-2.5.66-mm2/drivers/block/deadline-iosched.c
--- /opt/kernel/linux-2.5.66-mm2/drivers/block/deadline-iosched.c	2003-03-24 23:01:16.000000000 +0100
+++ linux-2.5.66-mm2/drivers/block/deadline-iosched.c	2003-04-01 13:18:43.027921400 +0200
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
 
@@ -739,33 +746,40 @@
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
+	struct deadline_rq *drq = mempool_alloc(dd->drq_pool, gfp_mask);
 
-	return ret;
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
@@ -916,6 +930,8 @@
 	.elevator_queue_empty_fn =	deadline_queue_empty,
 	.elevator_former_req_fn =	deadline_former_request,
 	.elevator_latter_req_fn =	deadline_latter_request,
+	.elevator_set_req_fn =		deadline_set_request,
+	.elevator_put_req_fn = 		deadline_put_request,
 	.elevator_init_fn =		deadline_init,
 	.elevator_exit_fn =		deadline_exit,
 
diff -ur -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.5.66-mm2/drivers/block/elevator.c linux-2.5.66-mm2/drivers/block/elevator.c
--- /opt/kernel/linux-2.5.66-mm2/drivers/block/elevator.c	2003-04-01 12:51:18.000000000 +0200
+++ linux-2.5.66-mm2/drivers/block/elevator.c	2003-04-01 12:57:02.258668384 +0200
@@ -418,6 +418,25 @@
 	return 1;
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
diff -ur -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.5.66-mm2/drivers/block/ll_rw_blk.c linux-2.5.66-mm2/drivers/block/ll_rw_blk.c
--- /opt/kernel/linux-2.5.66-mm2/drivers/block/ll_rw_blk.c	2003-04-01 12:51:18.000000000 +0200
+++ linux-2.5.66-mm2/drivers/block/ll_rw_blk.c	2003-04-01 13:14:33.792810896 +0200
@@ -48,12 +48,6 @@
  */
 int queue_nr_requests;
 
-/*
- * How many free requests must be available before we wake a process which
- * is waiting for a request?
- */
-static int batch_requests;
-
 unsigned long blk_max_low_pfn, blk_max_pfn;
 int blk_nohighio = 0;
 
@@ -424,7 +418,7 @@
 {
 	struct blk_queue_tag *bqt = q->queue_tags;
 
-	if(unlikely(bqt == NULL || bqt->max_depth < tag))
+	if (unlikely(bqt == NULL || bqt->max_depth < tag))
 		return NULL;
 
 	return bqt->tag_index[tag];
@@ -1123,26 +1117,6 @@
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
@@ -1159,18 +1133,14 @@
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
 	kblockd_flush();
 
-	if (count)
-		printk("blk_cleanup_queue: leaked requests (%d)\n", count);
+	mempool_destroy(rl->rq_pool);
 
 	if (blk_queue_tagged(q))
 		blk_queue_free_tags(q);
@@ -1180,42 +1150,17 @@
 
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
@@ -1303,111 +1250,92 @@
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
  * Get a free request. queue lock must be held and interrupts
  * disabled on the way in.
  */
-static struct request *get_request(request_queue_t *q, int rw)
+static struct request *get_request(request_queue_t *q, int rw, int gfp_mask)
 {
 	struct request *rq = NULL;
-	struct request_list *rl = q->rq + rw;
+	struct request_list *rl = &q->rq;
 
-	if (!list_empty(&rl->free) && elv_may_queue(q, rw)) {
-		rq = blkdev_free_rq(&rl->free);
-		list_del_init(&rq->queuelist);
-		rq->ref_count = 1;
-		rl->count--;
-		if (rl->count < queue_congestion_on_threshold())
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
 }
-
 /*
  * No available requests for this queue, unplug the device.
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
-		if (!rl->count || !elv_may_queue(q, rw))
-			block = 1;
-		spin_unlock_irq(q->queue_lock);
+		rq = get_request(q, rw, GFP_NOIO);
 
-		if (block)
-			io_schedule();
-		finish_wait(&rl->wait, &wait);
+		if (!rq)
+			blk_congestion_wait(WRITE, HZ / 50);
+	} while (!rq);
 
-		spin_lock_irq(q->queue_lock);
-		rq = get_request(q, rw);
-		spin_unlock_irq(q->queue_lock);
-	} while (rq == NULL);
 	return rq;
 }
-
 struct request *blk_get_request(request_queue_t *q, int rw, int gfp_mask)
 {
 	struct request *rq;
 
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
 
@@ -1525,6 +1453,9 @@
 	disk->stamp_idle = now;
 }
 
+/*
+ * queue lock must be held
+ */
 void __blk_put_request(request_queue_t *q, struct request *req)
 {
 	struct request_list *rl = req->rl;
@@ -1543,24 +1474,15 @@
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
 
@@ -1720,9 +1642,9 @@
 
 	barrier = test_bit(BIO_RW_BARRIER, &bio->bi_rw);
 
-	spin_lock_irq(q->queue_lock);
 again:
 	insert_here = NULL;
+	spin_lock_irq(q->queue_lock);
 
 	if (blk_queue_empty(q)) {
 		blk_plug_device(q);
@@ -1795,12 +1717,11 @@
 	 * a free slot.
 	 */
 get_rq:
+	spin_unlock_irq(q->queue_lock);
 	if (freereq) {
 		req = freereq;
 		freereq = NULL;
-	} else if ((req = get_request(q, rw)) == NULL) {
-		spin_unlock_irq(q->queue_lock);
-
+	} else if ((req = get_request(q, rw, GFP_ATOMIC)) == NULL) {
 		/*
 		 * READA bit set
 		 */
@@ -1808,7 +1729,6 @@
 			goto end_io;
 
 		freereq = get_request_wait(q, rw);
-		spin_lock_irq(q->queue_lock);
 		goto again;
 	}
 
@@ -1835,14 +1755,16 @@
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
@@ -2219,7 +2141,6 @@
 
 int __init blk_dev_init(void)
 {
-	int total_ram = nr_free_pages() << (PAGE_SHIFT - 10);
 	int i;
 
 	kblockd_workqueue = create_workqueue("kblockd");
@@ -2231,24 +2152,11 @@
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
 
@@ -2290,7 +2198,6 @@
 EXPORT_SYMBOL(blk_phys_contig_segment);
 EXPORT_SYMBOL(blk_hw_contig_segment);
 EXPORT_SYMBOL(blk_get_request);
-EXPORT_SYMBOL(__blk_get_request);
 EXPORT_SYMBOL(blk_put_request);
 EXPORT_SYMBOL(blk_insert_request);
 
diff -ur -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.5.66-mm2/include/linux/blkdev.h linux-2.5.66-mm2/include/linux/blkdev.h
--- /opt/kernel/linux-2.5.66-mm2/include/linux/blkdev.h	2003-04-01 12:51:19.000000000 +0200
+++ linux-2.5.66-mm2/include/linux/blkdev.h	2003-04-01 13:09:26.777484320 +0200
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
@@ -330,7 +333,6 @@
 extern void blk_attempt_remerge(request_queue_t *, struct request *);
 extern void __blk_attempt_remerge(request_queue_t *, struct request *);
 extern struct request *blk_get_request(request_queue_t *, int, int);
-extern struct request *__blk_get_request(request_queue_t *, int);
 extern void blk_put_request(struct request *);
 extern void blk_insert_request(request_queue_t *, struct request *, int, void *);
 extern void blk_plug_device(request_queue_t *);
diff -ur -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.5.66-mm2/include/linux/elevator.h linux-2.5.66-mm2/include/linux/elevator.h
--- /opt/kernel/linux-2.5.66-mm2/include/linux/elevator.h	2003-04-01 12:51:19.000000000 +0200
+++ linux-2.5.66-mm2/include/linux/elevator.h	2003-04-01 12:56:59.120145512 +0200
@@ -16,6 +16,8 @@
 typedef struct request *(elevator_request_list_fn) (request_queue_t *, struct request *);
 typedef struct list_head *(elevator_get_sort_head_fn) (request_queue_t *, struct request *);
 typedef int (elevator_may_queue_fn) (request_queue_t *, int);
+typedef int (elevator_set_req_fn) (request_queue_t *, struct request *, int);
+typedef void (elevator_put_req_fn) (request_queue_t *, struct request *);
 
 typedef int (elevator_init_fn) (request_queue_t *, elevator_t *);
 typedef void (elevator_exit_fn) (request_queue_t *, elevator_t *);
@@ -35,6 +37,9 @@
 	elevator_request_list_fn *elevator_former_req_fn;
 	elevator_request_list_fn *elevator_latter_req_fn;
 
+	elevator_set_req_fn *elevator_set_req_fn;
+	elevator_put_req_fn *elevator_put_req_fn;
+
 	elevator_may_queue_fn *elevator_may_queue_fn;
 
 	elevator_init_fn *elevator_init_fn;
@@ -62,6 +67,8 @@
 extern int elv_register_queue(struct gendisk *);
 extern void elv_unregister_queue(struct gendisk *);
 extern int elv_may_queue(request_queue_t *, int);
+extern int elv_set_request(request_queue_t *, struct request *, int);
+extern void elv_put_request(request_queue_t *, struct request *);
 
 #define __elv_add_request_pos(q, rq, pos)	\
 	(q)->elevator.elevator_add_req_fn((q), (rq), (pos))

-- 
Jens Axboe

