Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268762AbUI3Hbw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268762AbUI3Hbw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 03:31:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268537AbUI3Hbv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 03:31:51 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:54971 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S269063AbUI3HaU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 03:30:20 -0400
Date: Thu, 30 Sep 2004 09:27:42 +0200
From: Jens Axboe <axboe@suse.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Werner Almesberger <wa@almesberger.net>
Subject: [PATCH] modular and switchable io schedulers
Message-ID: <20040930072741.GB2288@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This should be the final version of the patch, Changes since last:

- Correct the logic for checking whether a given elevator choice was
  valid (search happened to soon).

- Fix a few locking problems.

- Fix blk_wait_queue_drain() for multiple wakeups (Jon Corbet)

- Fix a problem in case of failure in switching to new io scheduler

- Add priorities to printks (Werner Almesberger)

Patch is against 2.6.9-rc3, I'll submit it once 2.6.9 is finalized.
Additionally, Andrew has one for his -mm tree. For a description of this
patch, see http://lwn.net/Articles/102976/

Signed-off-by: Jens Axboe <axboe@suse.de>

===== drivers/block/Kconfig.iosched 1.3 vs edited =====
--- 1.3/drivers/block/Kconfig.iosched	2004-04-12 19:55:20 +02:00
+++ edited/drivers/block/Kconfig.iosched	2004-09-30 09:11:36 +02:00
@@ -1,5 +1,5 @@
 config IOSCHED_NOOP
-	bool "No-op I/O scheduler" if EMBEDDED
+	tristate "No-op I/O scheduler"
 	default y
 	---help---
 	  The no-op I/O scheduler is a minimal scheduler that does basic merging
@@ -9,7 +9,7 @@
 	  the kernel.
 
 config IOSCHED_AS
-	bool "Anticipatory I/O scheduler" if EMBEDDED
+	tristate "Anticipatory I/O scheduler"
 	default y
 	---help---
 	  The anticipatory I/O scheduler is the default disk scheduler. It is
@@ -18,7 +18,7 @@
 	  slower in some cases especially some database loads.
 
 config IOSCHED_DEADLINE
-	bool "Deadline I/O scheduler" if EMBEDDED
+	tristate "Deadline I/O scheduler"
 	default y
 	---help---
 	  The deadline I/O scheduler is simple and compact, and is often as
@@ -28,7 +28,7 @@
 	  anticipatory I/O scheduler and so is a good choice.
 
 config IOSCHED_CFQ
-	bool "CFQ I/O scheduler" if EMBEDDED
+	tristate "CFQ I/O scheduler"
 	default y
 	---help---
 	  The CFQ I/O scheduler tries to distribute bandwidth equally
===== drivers/block/as-iosched.c 1.38 vs edited =====
--- 1.38/drivers/block/as-iosched.c	2004-05-10 13:25:52 +02:00
+++ edited/drivers/block/as-iosched.c	2004-09-30 09:11:36 +02:00
@@ -614,7 +614,7 @@
 static void as_antic_timeout(unsigned long data)
 {
 	struct request_queue *q = (struct request_queue *)data;
-	struct as_data *ad = q->elevator.elevator_data;
+	struct as_data *ad = q->elevator->elevator_data;
 	unsigned long flags;
 
 	spin_lock_irqsave(q->queue_lock, flags);
@@ -945,7 +945,7 @@
  */
 static void as_completed_request(request_queue_t *q, struct request *rq)
 {
-	struct as_data *ad = q->elevator.elevator_data;
+	struct as_data *ad = q->elevator->elevator_data;
 	struct as_rq *arq = RQ_DATA(rq);
 
 	WARN_ON(!list_empty(&rq->queuelist));
@@ -1030,7 +1030,7 @@
 {
 	struct as_rq *arq = RQ_DATA(rq);
 	const int data_dir = arq->is_sync;
-	struct as_data *ad = q->elevator.elevator_data;
+	struct as_data *ad = q->elevator->elevator_data;
 
 	WARN_ON(arq->state != AS_RQ_QUEUED);
 
@@ -1361,7 +1361,7 @@
 
 static struct request *as_next_request(request_queue_t *q)
 {
-	struct as_data *ad = q->elevator.elevator_data;
+	struct as_data *ad = q->elevator->elevator_data;
 	struct request *rq = NULL;
 
 	/*
@@ -1469,7 +1469,7 @@
  */
 static void as_requeue_request(request_queue_t *q, struct request *rq)
 {
-	struct as_data *ad = q->elevator.elevator_data;
+	struct as_data *ad = q->elevator->elevator_data;
 	struct as_rq *arq = RQ_DATA(rq);
 
 	if (arq) {
@@ -1509,7 +1509,7 @@
 static void
 as_insert_request(request_queue_t *q, struct request *rq, int where)
 {
-	struct as_data *ad = q->elevator.elevator_data;
+	struct as_data *ad = q->elevator->elevator_data;
 	struct as_rq *arq = RQ_DATA(rq);
 
 	if (arq) {
@@ -1562,7 +1562,7 @@
  */
 static int as_queue_empty(request_queue_t *q)
 {
-	struct as_data *ad = q->elevator.elevator_data;
+	struct as_data *ad = q->elevator->elevator_data;
 
 	if (!list_empty(&ad->fifo_list[REQ_ASYNC])
 		|| !list_empty(&ad->fifo_list[REQ_SYNC])
@@ -1601,7 +1601,7 @@
 static int
 as_merge(request_queue_t *q, struct request **req, struct bio *bio)
 {
-	struct as_data *ad = q->elevator.elevator_data;
+	struct as_data *ad = q->elevator->elevator_data;
 	sector_t rb_key = bio->bi_sector + bio_sectors(bio);
 	struct request *__rq;
 	int ret;
@@ -1656,7 +1656,7 @@
 
 static void as_merged_request(request_queue_t *q, struct request *req)
 {
-	struct as_data *ad = q->elevator.elevator_data;
+	struct as_data *ad = q->elevator->elevator_data;
 	struct as_rq *arq = RQ_DATA(req);
 
 	/*
@@ -1701,7 +1701,7 @@
 as_merged_requests(request_queue_t *q, struct request *req,
 			 struct request *next)
 {
-	struct as_data *ad = q->elevator.elevator_data;
+	struct as_data *ad = q->elevator->elevator_data;
 	struct as_rq *arq = RQ_DATA(req);
 	struct as_rq *anext = RQ_DATA(next);
 
@@ -1788,7 +1788,7 @@
 
 static void as_put_request(request_queue_t *q, struct request *rq)
 {
-	struct as_data *ad = q->elevator.elevator_data;
+	struct as_data *ad = q->elevator->elevator_data;
 	struct as_rq *arq = RQ_DATA(rq);
 
 	if (!arq) {
@@ -1807,7 +1807,7 @@
 
 static int as_set_request(request_queue_t *q, struct request *rq, int gfp_mask)
 {
-	struct as_data *ad = q->elevator.elevator_data;
+	struct as_data *ad = q->elevator->elevator_data;
 	struct as_rq *arq = mempool_alloc(ad->arq_pool, gfp_mask);
 
 	if (arq) {
@@ -1829,7 +1829,7 @@
 static int as_may_queue(request_queue_t *q, int rw)
 {
 	int ret = 0;
-	struct as_data *ad = q->elevator.elevator_data;
+	struct as_data *ad = q->elevator->elevator_data;
 	struct io_context *ioc;
 	if (ad->antic_status == ANTIC_WAIT_REQ ||
 			ad->antic_status == ANTIC_WAIT_NEXT) {
@@ -1842,7 +1842,7 @@
 	return ret;
 }
 
-static void as_exit(request_queue_t *q, elevator_t *e)
+static void as_exit_queue(elevator_t *e)
 {
 	struct as_data *ad = e->elevator_data;
 
@@ -1862,7 +1862,7 @@
  * initialize elevator private data (as_data), and alloc a arq for
  * each request on the free lists
  */
-static int as_init(request_queue_t *q, elevator_t *e)
+static int as_init_queue(request_queue_t *q, elevator_t *e)
 {
 	struct as_data *ad;
 	int i;
@@ -2070,39 +2070,64 @@
 	.default_attrs	= default_attrs,
 };
 
-static int __init as_slab_setup(void)
+static struct elevator_type iosched_as = {
+	.ops = {
+		.elevator_merge_fn = 		as_merge,
+		.elevator_merged_fn =		as_merged_request,
+		.elevator_merge_req_fn =	as_merged_requests,
+		.elevator_next_req_fn =		as_next_request,
+		.elevator_add_req_fn =		as_insert_request,
+		.elevator_remove_req_fn =	as_remove_request,
+		.elevator_requeue_req_fn = 	as_requeue_request,
+		.elevator_queue_empty_fn =	as_queue_empty,
+		.elevator_completed_req_fn =	as_completed_request,
+		.elevator_former_req_fn =	as_former_request,
+		.elevator_latter_req_fn =	as_latter_request,
+		.elevator_set_req_fn =		as_set_request,
+		.elevator_put_req_fn =		as_put_request,
+		.elevator_may_queue_fn =	as_may_queue,
+		.elevator_init_fn =		as_init_queue,
+		.elevator_exit_fn =		as_exit_queue,
+	},
+
+	.elevator_ktype = &as_ktype,
+	.elevator_name = "anticipatory",
+	.elevator_owner = THIS_MODULE,
+};
+
+int as_init(void)
 {
+	int ret;
+
 	arq_pool = kmem_cache_create("as_arq", sizeof(struct as_rq),
 				     0, 0, NULL, NULL);
-
 	if (!arq_pool)
-		panic("as: can't init slab pool\n");
+		return -ENOMEM;
 
-	return 0;
-}
+	ret = elv_register(&iosched_as);
+	if (!ret) {
+		/*
+		 * don't allow AS to get unregistered, since we would have
+		 * to browse all tasks in the system and release their
+		 * as_io_context first
+		 */
+		__module_get(THIS_MODULE);
+		return 0;
+	}
 
-subsys_initcall(as_slab_setup);
+	kmem_cache_destroy(arq_pool);
+	return ret;
+}
 
-elevator_t iosched_as = {
-	.elevator_merge_fn = 		as_merge,
-	.elevator_merged_fn =		as_merged_request,
-	.elevator_merge_req_fn =	as_merged_requests,
-	.elevator_next_req_fn =		as_next_request,
-	.elevator_add_req_fn =		as_insert_request,
-	.elevator_remove_req_fn =	as_remove_request,
-	.elevator_requeue_req_fn = 	as_requeue_request,
-	.elevator_queue_empty_fn =	as_queue_empty,
-	.elevator_completed_req_fn =	as_completed_request,
-	.elevator_former_req_fn =	as_former_request,
-	.elevator_latter_req_fn =	as_latter_request,
-	.elevator_set_req_fn =		as_set_request,
-	.elevator_put_req_fn =		as_put_request,
-	.elevator_may_queue_fn =	as_may_queue,
-	.elevator_init_fn =		as_init,
-	.elevator_exit_fn =		as_exit,
+void as_exit(void)
+{
+	kmem_cache_destroy(arq_pool);
+	elv_unregister(&iosched_as);
+}
 
-	.elevator_ktype =		&as_ktype,
-	.elevator_name =		"anticipatory",
-};
+module_init(as_init);
+module_exit(as_exit);
 
-EXPORT_SYMBOL(iosched_as);
+MODULE_AUTHOR("Nick Piggin");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("anticipatory IO scheduler");
===== drivers/block/cfq-iosched.c 1.8 vs edited =====
--- 1.8/drivers/block/cfq-iosched.c	2004-07-14 11:47:10 +02:00
+++ edited/drivers/block/cfq-iosched.c	2004-09-30 09:11:36 +02:00
@@ -246,7 +246,7 @@
 
 static void cfq_remove_request(request_queue_t *q, struct request *rq)
 {
-	struct cfq_data *cfqd = q->elevator.elevator_data;
+	struct cfq_data *cfqd = q->elevator->elevator_data;
 	struct cfq_rq *crq = RQ_DATA(rq);
 
 	if (crq) {
@@ -267,7 +267,7 @@
 static int
 cfq_merge(request_queue_t *q, struct request **req, struct bio *bio)
 {
-	struct cfq_data *cfqd = q->elevator.elevator_data;
+	struct cfq_data *cfqd = q->elevator->elevator_data;
 	struct request *__rq;
 	int ret;
 
@@ -305,7 +305,7 @@
 
 static void cfq_merged_request(request_queue_t *q, struct request *req)
 {
-	struct cfq_data *cfqd = q->elevator.elevator_data;
+	struct cfq_data *cfqd = q->elevator->elevator_data;
 	struct cfq_rq *crq = RQ_DATA(req);
 
 	cfq_del_crq_hash(crq);
@@ -404,7 +404,7 @@
 
 static struct request *cfq_next_request(request_queue_t *q)
 {
-	struct cfq_data *cfqd = q->elevator.elevator_data;
+	struct cfq_data *cfqd = q->elevator->elevator_data;
 	struct request *rq;
 
 	if (!list_empty(cfqd->dispatch)) {
@@ -531,7 +531,7 @@
 static void
 cfq_insert_request(request_queue_t *q, struct request *rq, int where)
 {
-	struct cfq_data *cfqd = q->elevator.elevator_data;
+	struct cfq_data *cfqd = q->elevator->elevator_data;
 	struct cfq_rq *crq = RQ_DATA(rq);
 
 	switch (where) {
@@ -562,7 +562,7 @@
 
 static int cfq_queue_empty(request_queue_t *q)
 {
-	struct cfq_data *cfqd = q->elevator.elevator_data;
+	struct cfq_data *cfqd = q->elevator->elevator_data;
 
 	if (list_empty(cfqd->dispatch) && list_empty(&cfqd->rr_list))
 		return 1;
@@ -596,7 +596,7 @@
 
 static int cfq_may_queue(request_queue_t *q, int rw)
 {
-	struct cfq_data *cfqd = q->elevator.elevator_data;
+	struct cfq_data *cfqd = q->elevator->elevator_data;
 	struct cfq_queue *cfqq;
 	int ret = 1;
 
@@ -621,7 +621,7 @@
 
 static void cfq_put_request(request_queue_t *q, struct request *rq)
 {
-	struct cfq_data *cfqd = q->elevator.elevator_data;
+	struct cfq_data *cfqd = q->elevator->elevator_data;
 	struct cfq_rq *crq = RQ_DATA(rq);
 	struct request_list *rl;
 	int other_rw;
@@ -654,7 +654,7 @@
 
 static int cfq_set_request(request_queue_t *q, struct request *rq, int gfp_mask)
 {
-	struct cfq_data *cfqd = q->elevator.elevator_data;
+	struct cfq_data *cfqd = q->elevator->elevator_data;
 	struct cfq_queue *cfqq;
 	struct cfq_rq *crq;
 
@@ -679,7 +679,7 @@
 	return 1;
 }
 
-static void cfq_exit(request_queue_t *q, elevator_t *e)
+static void cfq_exit_queue(elevator_t *e)
 {
 	struct cfq_data *cfqd = e->elevator_data;
 
@@ -690,7 +690,7 @@
 	kfree(cfqd);
 }
 
-static int cfq_init(request_queue_t *q, elevator_t *e)
+static int cfq_init_queue(request_queue_t *q, elevator_t *e)
 {
 	struct cfq_data *cfqd;
 	int i;
@@ -732,7 +732,6 @@
 
 	cfqd->cfq_queued = cfq_queued;
 	cfqd->cfq_quantum = cfq_quantum;
-
 	return 0;
 out_crqpool:
 	kfree(cfqd->cfq_hash);
@@ -743,30 +742,38 @@
 	return -ENOMEM;
 }
 
-static int __init cfq_slab_setup(void)
+static void cfq_slab_kill(void)
+{
+	if (crq_pool)
+		kmem_cache_destroy(crq_pool);
+	if (cfq_mpool)
+		mempool_destroy(cfq_mpool);
+	if (cfq_pool)
+		kmem_cache_destroy(cfq_pool);
+}	
+
+static int cfq_slab_setup(void)
 {
 	crq_pool = kmem_cache_create("crq_pool", sizeof(struct cfq_rq), 0, 0,
 					NULL, NULL);
-
 	if (!crq_pool)
-		panic("cfq_iosched: can't init crq pool\n");
+		goto fail;
 
 	cfq_pool = kmem_cache_create("cfq_pool", sizeof(struct cfq_queue), 0, 0,
 					NULL, NULL);
-
 	if (!cfq_pool)
-		panic("cfq_iosched: can't init cfq pool\n");
+		goto fail;
 
 	cfq_mpool = mempool_create(64, mempool_alloc_slab, mempool_free_slab, cfq_pool);
-
 	if (!cfq_mpool)
-		panic("cfq_iosched: can't init cfq mpool\n");
+		goto fail;
 
 	return 0;
+fail:
+	cfq_slab_kill();
+	return -ENOMEM;
 }
 
-subsys_initcall(cfq_slab_setup);
-
 /*
  * sysfs parts below -->
  */
@@ -868,23 +875,51 @@
 	.default_attrs	= default_attrs,
 };
 
-elevator_t iosched_cfq = {
-	.elevator_name =		"cfq",
-	.elevator_ktype =		&cfq_ktype,
-	.elevator_merge_fn = 		cfq_merge,
-	.elevator_merged_fn =		cfq_merged_request,
-	.elevator_merge_req_fn =	cfq_merged_requests,
-	.elevator_next_req_fn =		cfq_next_request,
-	.elevator_add_req_fn =		cfq_insert_request,
-	.elevator_remove_req_fn =	cfq_remove_request,
-	.elevator_queue_empty_fn =	cfq_queue_empty,
-	.elevator_former_req_fn =	cfq_former_request,
-	.elevator_latter_req_fn =	cfq_latter_request,
-	.elevator_set_req_fn =		cfq_set_request,
-	.elevator_put_req_fn =		cfq_put_request,
-	.elevator_may_queue_fn =	cfq_may_queue,
-	.elevator_init_fn =		cfq_init,
-	.elevator_exit_fn =		cfq_exit,
+static struct elevator_type iosched_cfq = {
+	.ops = {
+		.elevator_merge_fn = 		cfq_merge,
+		.elevator_merged_fn =		cfq_merged_request,
+		.elevator_merge_req_fn =	cfq_merged_requests,
+		.elevator_next_req_fn =		cfq_next_request,
+		.elevator_add_req_fn =		cfq_insert_request,
+		.elevator_remove_req_fn =	cfq_remove_request,
+		.elevator_queue_empty_fn =	cfq_queue_empty,
+		.elevator_former_req_fn =	cfq_former_request,
+		.elevator_latter_req_fn =	cfq_latter_request,
+		.elevator_set_req_fn =		cfq_set_request,
+		.elevator_put_req_fn =		cfq_put_request,
+		.elevator_may_queue_fn =	cfq_may_queue,
+		.elevator_init_fn =		cfq_init_queue,
+		.elevator_exit_fn =		cfq_exit_queue,
+	},
+	.elevator_ktype = &cfq_ktype,
+	.elevator_name = "cfq",
+	.elevator_owner = THIS_MODULE,
 };
 
-EXPORT_SYMBOL(iosched_cfq);
+int cfq_init(void)
+{
+	int ret;
+
+	if (cfq_slab_setup())
+		return -ENOMEM;
+
+	ret = elv_register(&iosched_cfq);
+	if (ret)
+		cfq_slab_kill();
+
+	return ret;
+}
+
+void cfq_exit(void)
+{
+	cfq_slab_kill();
+	elv_unregister(&iosched_cfq);
+}
+
+module_init(cfq_init);
+module_exit(cfq_exit);
+
+MODULE_AUTHOR("Jens Axboe");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Completely Fair Queueing IO scheduler");
===== drivers/block/deadline-iosched.c 1.29 vs edited =====
--- 1.29/drivers/block/deadline-iosched.c	2004-06-30 07:57:35 +02:00
+++ edited/drivers/block/deadline-iosched.c	2004-09-30 09:11:36 +02:00
@@ -289,7 +289,7 @@
 static inline void
 deadline_add_request(struct request_queue *q, struct request *rq)
 {
-	struct deadline_data *dd = q->elevator.elevator_data;
+	struct deadline_data *dd = q->elevator->elevator_data;
 	struct deadline_rq *drq = RQ_DATA(rq);
 
 	const int data_dir = rq_data_dir(drq->request);
@@ -317,7 +317,7 @@
 	struct deadline_rq *drq = RQ_DATA(rq);
 
 	if (drq) {
-		struct deadline_data *dd = q->elevator.elevator_data;
+		struct deadline_data *dd = q->elevator->elevator_data;
 
 		list_del_init(&drq->fifo);
 		deadline_remove_merge_hints(q, drq);
@@ -328,7 +328,7 @@
 static int
 deadline_merge(request_queue_t *q, struct request **req, struct bio *bio)
 {
-	struct deadline_data *dd = q->elevator.elevator_data;
+	struct deadline_data *dd = q->elevator->elevator_data;
 	struct request *__rq;
 	int ret;
 
@@ -383,7 +383,7 @@
 
 static void deadline_merged_request(request_queue_t *q, struct request *req)
 {
-	struct deadline_data *dd = q->elevator.elevator_data;
+	struct deadline_data *dd = q->elevator->elevator_data;
 	struct deadline_rq *drq = RQ_DATA(req);
 
 	/*
@@ -407,7 +407,7 @@
 deadline_merged_requests(request_queue_t *q, struct request *req,
 			 struct request *next)
 {
-	struct deadline_data *dd = q->elevator.elevator_data;
+	struct deadline_data *dd = q->elevator->elevator_data;
 	struct deadline_rq *drq = RQ_DATA(req);
 	struct deadline_rq *dnext = RQ_DATA(next);
 
@@ -604,7 +604,7 @@
 
 static struct request *deadline_next_request(request_queue_t *q)
 {
-	struct deadline_data *dd = q->elevator.elevator_data;
+	struct deadline_data *dd = q->elevator->elevator_data;
 	struct request *rq;
 
 	/*
@@ -625,7 +625,7 @@
 static void
 deadline_insert_request(request_queue_t *q, struct request *rq, int where)
 {
-	struct deadline_data *dd = q->elevator.elevator_data;
+	struct deadline_data *dd = q->elevator->elevator_data;
 
 	/* barriers must flush the reorder queue */
 	if (unlikely(rq->flags & (REQ_SOFTBARRIER | REQ_HARDBARRIER)
@@ -653,7 +653,7 @@
 
 static int deadline_queue_empty(request_queue_t *q)
 {
-	struct deadline_data *dd = q->elevator.elevator_data;
+	struct deadline_data *dd = q->elevator->elevator_data;
 
 	if (!list_empty(&dd->fifo_list[WRITE])
 	    || !list_empty(&dd->fifo_list[READ])
@@ -687,7 +687,7 @@
 	return NULL;
 }
 
-static void deadline_exit(request_queue_t *q, elevator_t *e)
+static void deadline_exit_queue(elevator_t *e)
 {
 	struct deadline_data *dd = e->elevator_data;
 
@@ -703,7 +703,7 @@
  * initialize elevator private data (deadline_data), and alloc a drq for
  * each request on the free lists
  */
-static int deadline_init(request_queue_t *q, elevator_t *e)
+static int deadline_init_queue(request_queue_t *q, elevator_t *e)
 {
 	struct deadline_data *dd;
 	int i;
@@ -748,7 +748,7 @@
 
 static void deadline_put_request(request_queue_t *q, struct request *rq)
 {
-	struct deadline_data *dd = q->elevator.elevator_data;
+	struct deadline_data *dd = q->elevator->elevator_data;
 	struct deadline_rq *drq = RQ_DATA(rq);
 
 	if (drq) {
@@ -760,7 +760,7 @@
 static int
 deadline_set_request(request_queue_t *q, struct request *rq, int gfp_mask)
 {
-	struct deadline_data *dd = q->elevator.elevator_data;
+	struct deadline_data *dd = q->elevator->elevator_data;
 	struct deadline_rq *drq;
 
 	drq = mempool_alloc(dd->drq_pool, gfp_mask);
@@ -906,36 +906,54 @@
 	.default_attrs	= default_attrs,
 };
 
-static int __init deadline_slab_setup(void)
+static struct elevator_type iosched_deadline = {
+	.ops = {
+		.elevator_merge_fn = 		deadline_merge,
+		.elevator_merged_fn =		deadline_merged_request,
+		.elevator_merge_req_fn =	deadline_merged_requests,
+		.elevator_next_req_fn =		deadline_next_request,
+		.elevator_add_req_fn =		deadline_insert_request,
+		.elevator_remove_req_fn =	deadline_remove_request,
+		.elevator_queue_empty_fn =	deadline_queue_empty,
+		.elevator_former_req_fn =	deadline_former_request,
+		.elevator_latter_req_fn =	deadline_latter_request,
+		.elevator_set_req_fn =		deadline_set_request,
+		.elevator_put_req_fn = 		deadline_put_request,
+		.elevator_init_fn =		deadline_init_queue,
+		.elevator_exit_fn =		deadline_exit_queue,
+	},
+
+	.elevator_ktype = &deadline_ktype,
+	.elevator_name = "deadline",
+	.elevator_owner = THIS_MODULE,
+};
+
+int deadline_init(void)
 {
+	int ret;
+
 	drq_pool = kmem_cache_create("deadline_drq", sizeof(struct deadline_rq),
 				     0, 0, NULL, NULL);
 
 	if (!drq_pool)
-		panic("deadline: can't init slab pool\n");
+		return -ENOMEM;
 
-	return 0;
-}
+	ret = elv_register(&iosched_deadline);
+	if (ret)
+		kmem_cache_destroy(drq_pool);
 
-subsys_initcall(deadline_slab_setup);
+	return ret;
+}
 
-elevator_t iosched_deadline = {
-	.elevator_merge_fn = 		deadline_merge,
-	.elevator_merged_fn =		deadline_merged_request,
-	.elevator_merge_req_fn =	deadline_merged_requests,
-	.elevator_next_req_fn =		deadline_next_request,
-	.elevator_add_req_fn =		deadline_insert_request,
-	.elevator_remove_req_fn =	deadline_remove_request,
-	.elevator_queue_empty_fn =	deadline_queue_empty,
-	.elevator_former_req_fn =	deadline_former_request,
-	.elevator_latter_req_fn =	deadline_latter_request,
-	.elevator_set_req_fn =		deadline_set_request,
-	.elevator_put_req_fn = 		deadline_put_request,
-	.elevator_init_fn =		deadline_init,
-	.elevator_exit_fn =		deadline_exit,
+void deadline_exit(void)
+{
+	kmem_cache_destroy(drq_pool);
+	elv_unregister(&iosched_deadline);
+}
 
-	.elevator_ktype =		&deadline_ktype,
-	.elevator_name =		"deadline",
-};
+module_init(deadline_init);
+module_exit(deadline_exit);
 
-EXPORT_SYMBOL(iosched_deadline);
+MODULE_AUTHOR("Jens Axboe");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("deadline IO scheduler");
===== drivers/block/elevator.c 1.58 vs edited =====
--- 1.58/drivers/block/elevator.c	2004-06-29 16:44:49 +02:00
+++ edited/drivers/block/elevator.c	2004-09-30 09:19:23 +02:00
@@ -37,6 +37,9 @@
 
 #include <asm/uaccess.h>
 
+static spinlock_t elv_list_lock = SPIN_LOCK_UNLOCKED;
+static LIST_HEAD(elv_list);
+
 /*
  * can we safely merge with this request?
  */
@@ -60,6 +63,7 @@
 
 	return 0;
 }
+EXPORT_SYMBOL(elv_rq_merge_ok);
 
 inline int elv_try_merge(struct request *__rq, struct bio *bio)
 {
@@ -77,6 +81,7 @@
 
 	return ret;
 }
+EXPORT_SYMBOL(elv_try_merge);
 
 inline int elv_try_last_merge(request_queue_t *q, struct bio *bio)
 {
@@ -85,31 +90,122 @@
 
 	return ELEVATOR_NO_MERGE;
 }
+EXPORT_SYMBOL(elv_try_last_merge);
 
-/*
- * general block -> elevator interface starts here
- */
-int elevator_init(request_queue_t *q, elevator_t *type)
+struct elevator_type *elevator_find(const char *name)
 {
-	elevator_t *e = &q->elevator;
+	struct elevator_type *e = NULL;
+	struct list_head *entry;
+
+	spin_lock_irq(&elv_list_lock);
+	list_for_each(entry, &elv_list) {
+		struct elevator_type *__e;
+
+		__e = list_entry(entry, struct elevator_type, list);
 
-	memcpy(e, type, sizeof(*e));
+		if (!strcmp(__e->elevator_name, name)) {
+			e = __e;
+			break;
+		}
+	}
+	spin_unlock_irq(&elv_list_lock);
+
+	return e;
+}
+
+static int elevator_attach(request_queue_t *q, struct elevator_type *e,
+			   struct elevator_queue *eq)
+{
+	int ret = 0;
+
+	if (!try_module_get(e->elevator_owner))
+		return -EINVAL;
+
+	memset(eq, 0, sizeof(*eq));
+	eq->ops = &e->ops;
+	eq->elevator_type = e;
 
 	INIT_LIST_HEAD(&q->queue_head);
 	q->last_merge = NULL;
+	q->elevator = eq;
+
+	if (eq->ops->elevator_init_fn)
+		ret = eq->ops->elevator_init_fn(q, eq);
+
+	return ret;
+}
+
+static char chosen_elevator[16];
 
-	if (e->elevator_init_fn)
-		return e->elevator_init_fn(q, e);
+static void elevator_setup_default(void)
+{
+	/*
+	 * check if default is set and exists
+	 */
+	if (chosen_elevator[0]) {
+		if (elevator_find(chosen_elevator))
+			return;
+		printk(KERN_ERR "elevator: %s is not a valid choice\n",
+			chosen_elevator);
+	}
+
+#if defined(CONFIG_IOSCHED_AS)
+	strcpy(chosen_elevator, "anticipatory");
+#elif defined(CONFIG_IOSCHED_DEADLINE)
+	strcpy(chosen_elevator, "deadline");
+#elif defined(CONFIG_IOSCHED_CFQ)
+	strcpy(chosen_elevator, "cfq");
+#elif defined(CONFIG_IOSCHED_NOOP)
+	strcpy(chosen_elevator, "noop");
+#else
+#error "You must build at least 1 IO scheduler into the kernel"
+#endif
+	printk(KERN_INFO "elevator: using %s as default io scheduler\n",
+		chosen_elevator);
+}
 
+static int __init elevator_setup(char *str)
+{
+	strncpy(chosen_elevator, str, sizeof(chosen_elevator) - 1);
 	return 0;
 }
 
-void elevator_exit(request_queue_t *q)
+__setup("elevator=", elevator_setup);
+
+int elevator_init(request_queue_t *q, char *name)
 {
-	elevator_t *e = &q->elevator;
+	struct elevator_type *e = NULL;
+	struct elevator_queue *eq;
+	int ret = 0;
+
+	elevator_setup_default();
+
+	if (!name)
+		name = chosen_elevator;
 
-	if (e->elevator_exit_fn)
-		e->elevator_exit_fn(q, e);
+	e = elevator_find(name);
+	if (!e)
+		return -EINVAL;
+
+	eq = kmalloc(sizeof(struct elevator_queue), GFP_KERNEL);
+	if (!eq)
+		return -ENOMEM;
+
+	ret = elevator_attach(q, e, eq);
+	if (ret)
+		kfree(eq);
+
+	return ret;
+}
+
+void elevator_exit(elevator_t *e)
+{
+	if (e->ops->elevator_exit_fn)
+		e->ops->elevator_exit_fn(e);
+
+	module_put(e->elevator_type->elevator_owner);
+	e->elevator_type = NULL;
+	kfree(e);
 }
 
 int elevator_global_init(void)
@@ -119,32 +215,32 @@
 
 int elv_merge(request_queue_t *q, struct request **req, struct bio *bio)
 {
-	elevator_t *e = &q->elevator;
+	elevator_t *e = q->elevator;
 
-	if (e->elevator_merge_fn)
-		return e->elevator_merge_fn(q, req, bio);
+	if (e->ops->elevator_merge_fn)
+		return e->ops->elevator_merge_fn(q, req, bio);
 
 	return ELEVATOR_NO_MERGE;
 }
 
 void elv_merged_request(request_queue_t *q, struct request *rq)
 {
-	elevator_t *e = &q->elevator;
+	elevator_t *e = q->elevator;
 
-	if (e->elevator_merged_fn)
-		e->elevator_merged_fn(q, rq);
+	if (e->ops->elevator_merged_fn)
+		e->ops->elevator_merged_fn(q, rq);
 }
 
 void elv_merge_requests(request_queue_t *q, struct request *rq,
 			     struct request *next)
 {
-	elevator_t *e = &q->elevator;
+	elevator_t *e = q->elevator;
 
 	if (q->last_merge == next)
 		q->last_merge = NULL;
 
-	if (e->elevator_merge_req_fn)
-		e->elevator_merge_req_fn(q, rq, next);
+	if (e->ops->elevator_merge_req_fn)
+		e->ops->elevator_merge_req_fn(q, rq, next);
 }
 
 void elv_requeue_request(request_queue_t *q, struct request *rq)
@@ -160,8 +256,8 @@
 	 * if iosched has an explicit requeue hook, then use that. otherwise
 	 * just put the request at the front of the queue
 	 */
-	if (q->elevator.elevator_requeue_req_fn)
-		q->elevator.elevator_requeue_req_fn(q, rq);
+	if (q->elevator->ops->elevator_requeue_req_fn)
+		q->elevator->ops->elevator_requeue_req_fn(q, rq);
 	else
 		__elv_add_request(q, rq, ELEVATOR_INSERT_FRONT, 0);
 }
@@ -180,7 +276,7 @@
 		blk_plug_device(q);
 
 	rq->q = q;
-	q->elevator.elevator_add_req_fn(q, rq, where);
+	q->elevator->ops->elevator_add_req_fn(q, rq, where);
 
 	if (blk_queue_plugged(q)) {
 		int nrq = q->rq.count[READ] + q->rq.count[WRITE] - q->in_flight;
@@ -203,7 +299,7 @@
 
 static inline struct request *__elv_next_request(request_queue_t *q)
 {
-	return q->elevator.elevator_next_req_fn(q);
+	return q->elevator->ops->elevator_next_req_fn(q);
 }
 
 struct request *elv_next_request(request_queue_t *q)
@@ -242,7 +338,7 @@
 			end_that_request_chunk(rq, 0, nr_bytes);
 			end_that_request_last(rq);
 		} else {
-			printk("%s: bad return=%d\n", __FUNCTION__, ret);
+			printk(KERN_ERR "%s: bad return=%d\n",__FUNCTION__,ret);
 			break;
 		}
 	}
@@ -252,7 +348,7 @@
 
 void elv_remove_request(request_queue_t *q, struct request *rq)
 {
-	elevator_t *e = &q->elevator;
+	elevator_t *e = q->elevator;
 
 	/*
 	 * the time frame between a request being removed from the lists
@@ -274,16 +370,16 @@
 	if (rq == q->last_merge)
 		q->last_merge = NULL;
 
-	if (e->elevator_remove_req_fn)
-		e->elevator_remove_req_fn(q, rq);
+	if (e->ops->elevator_remove_req_fn)
+		e->ops->elevator_remove_req_fn(q, rq);
 }
 
 int elv_queue_empty(request_queue_t *q)
 {
-	elevator_t *e = &q->elevator;
+	elevator_t *e = q->elevator;
 
-	if (e->elevator_queue_empty_fn)
-		return e->elevator_queue_empty_fn(q);
+	if (e->ops->elevator_queue_empty_fn)
+		return e->ops->elevator_queue_empty_fn(q);
 
 	return list_empty(&q->queue_head);
 }
@@ -292,10 +388,10 @@
 {
 	struct list_head *next;
 
-	elevator_t *e = &q->elevator;
+	elevator_t *e = q->elevator;
 
-	if (e->elevator_latter_req_fn)
-		return e->elevator_latter_req_fn(q, rq);
+	if (e->ops->elevator_latter_req_fn)
+		return e->ops->elevator_latter_req_fn(q, rq);
 
 	next = rq->queuelist.next;
 	if (next != &q->queue_head && next != &rq->queuelist)
@@ -308,10 +404,10 @@
 {
 	struct list_head *prev;
 
-	elevator_t *e = &q->elevator;
+	elevator_t *e = q->elevator;
 
-	if (e->elevator_former_req_fn)
-		return e->elevator_former_req_fn(q, rq);
+	if (e->ops->elevator_former_req_fn)
+		return e->ops->elevator_former_req_fn(q, rq);
 
 	prev = rq->queuelist.prev;
 	if (prev != &q->queue_head && prev != &rq->queuelist)
@@ -322,10 +418,10 @@
 
 int elv_set_request(request_queue_t *q, struct request *rq, int gfp_mask)
 {
-	elevator_t *e = &q->elevator;
+	elevator_t *e = q->elevator;
 
-	if (e->elevator_set_req_fn)
-		return e->elevator_set_req_fn(q, rq, gfp_mask);
+	if (e->ops->elevator_set_req_fn)
+		return e->ops->elevator_set_req_fn(q, rq, gfp_mask);
 
 	rq->elevator_private = NULL;
 	return 0;
@@ -333,25 +429,25 @@
 
 void elv_put_request(request_queue_t *q, struct request *rq)
 {
-	elevator_t *e = &q->elevator;
+	elevator_t *e = q->elevator;
 
-	if (e->elevator_put_req_fn)
-		e->elevator_put_req_fn(q, rq);
+	if (e->ops->elevator_put_req_fn)
+		e->ops->elevator_put_req_fn(q, rq);
 }
 
 int elv_may_queue(request_queue_t *q, int rw)
 {
-	elevator_t *e = &q->elevator;
+	elevator_t *e = q->elevator;
 
-	if (e->elevator_may_queue_fn)
-		return e->elevator_may_queue_fn(q, rw);
+	if (e->ops->elevator_may_queue_fn)
+		return e->ops->elevator_may_queue_fn(q, rw);
 
 	return 0;
 }
 
 void elv_completed_request(request_queue_t *q, struct request *rq)
 {
-	elevator_t *e = &q->elevator;
+	elevator_t *e = q->elevator;
 
 	/*
 	 * request is released from the driver, io must be done
@@ -359,22 +455,20 @@
 	if (blk_account_rq(rq))
 		q->in_flight--;
 
-	if (e->elevator_completed_req_fn)
-		e->elevator_completed_req_fn(q, rq);
+	if (e->ops->elevator_completed_req_fn)
+		e->ops->elevator_completed_req_fn(q, rq);
 }
 
 int elv_register_queue(struct request_queue *q)
 {
-	elevator_t *e;
-
-	e = &q->elevator;
+	elevator_t *e = q->elevator;
 
 	e->kobj.parent = kobject_get(&q->kobj);
 	if (!e->kobj.parent)
 		return -EBUSY;
 
 	snprintf(e->kobj.name, KOBJ_NAME_LEN, "%s", "iosched");
-	e->kobj.ktype = e->elevator_ktype;
+	e->kobj.ktype = e->elevator_type->elevator_ktype;
 
 	return kobject_register(&e->kobj);
 }
@@ -382,10 +476,130 @@
 void elv_unregister_queue(struct request_queue *q)
 {
 	if (q) {
-		elevator_t * e = &q->elevator;
+		elevator_t *e = q->elevator;
 		kobject_unregister(&e->kobj);
 		kobject_put(&q->kobj);
 	}
+}
+
+int elv_register(struct elevator_type *e)
+{
+	if (elevator_find(e->elevator_name))
+		BUG();
+
+	spin_lock_irq(&elv_list_lock);
+	list_add_tail(&e->list, &elv_list);
+	spin_unlock_irq(&elv_list_lock);
+
+	printk(KERN_INFO "io scheduler %s registered\n", e->elevator_name);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(elv_register);
+
+void elv_unregister(struct elevator_type *e)
+{
+	spin_lock_irq(&elv_list_lock);
+	list_del_init(&e->list);
+	spin_unlock_irq(&elv_list_lock);
+}
+EXPORT_SYMBOL_GPL(elv_unregister);
+
+/*
+ * switch to new_e io scheduler. be careful not to introduce deadlocks -
+ * we don't free the old io scheduler, before we have allocated what we
+ * need for the new one. this way we have a chance of going back to the old
+ * one, if the new one fails init for some reason
+ */
+static void elevator_switch(request_queue_t *q, struct elevator_type *new_e)
+{
+	elevator_t *e = kmalloc(sizeof(elevator_t), GFP_KERNEL);
+	elevator_t *old_elevator;
+
+	if (!e) {
+		printk(KERN_ERR "elevator: out of memory\n");
+		return;
+	}
+
+	blk_wait_queue_drained(q);
+
+	/*
+	 * unregister old elevator data
+	 */
+	elv_unregister_queue(q);
+	old_elevator = q->elevator;
+
+	/*
+	 * attach and start new elevator
+	 */
+	if (elevator_attach(q, new_e, e))
+		goto fail;
+
+	if (elv_register_queue(q))
+		goto fail_register;
+
+	/*
+	 * finally exit old elevator and start queue again
+	 */
+	elevator_exit(old_elevator);
+	blk_finish_queue_drain(q);
+	return;
+
+fail_register:
+	/*
+	 * switch failed, exit the new io scheduler and reattach the old
+	 * one again (along with re-adding the sysfs dir)
+	 */
+	elevator_exit(e);
+fail:
+	q->elevator = old_elevator;
+	elv_register_queue(q);
+	blk_finish_queue_drain(q);
+	printk(KERN_ERR "elevator: switch to %s failed\n",new_e->elevator_name);
+}
+
+ssize_t elv_iosched_store(request_queue_t *q, const char *name, size_t count)
+{
+	char elevator_name[ELV_NAME_MAX];
+	struct elevator_type *e;
+
+	memset(elevator_name, 0, sizeof(elevator_name));
+	strncpy(elevator_name, name, sizeof(elevator_name));
+
+	if (elevator_name[strlen(elevator_name) - 1] == '\n')
+		elevator_name[strlen(elevator_name) - 1] = '\0';
+
+	e = elevator_find(elevator_name);
+	if (!e) {
+		printk(KERN_WARNING "elevator: type %s not found\n",
+			elevator_name);
+		return count;
+	}
+
+	elevator_switch(q, e);
+	return count;
+}
+
+ssize_t elv_iosched_show(request_queue_t *q, char *name)
+{
+	elevator_t *e = q->elevator;
+	struct elevator_type *elv = e->elevator_type;
+	struct list_head *entry;
+	int len = 0;
+
+	spin_lock_irq(q->queue_lock);
+	list_for_each(entry, &elv_list) {
+		struct elevator_type *__e;
+
+		__e = list_entry(entry, struct elevator_type, list);
+		if (!strcmp(elv->elevator_name, __e->elevator_name))
+			len += sprintf(name+len, "[%s] ", elv->elevator_name);
+		else
+			len += sprintf(name+len, "%s ", __e->elevator_name);
+	}
+	spin_unlock_irq(q->queue_lock);
+
+	len += sprintf(len+name, "\n");
+	return len;
 }
 
 module_init(elevator_global_init);
===== drivers/block/ll_rw_blk.c 1.271 vs edited =====
--- 1.271/drivers/block/ll_rw_blk.c	2004-09-14 02:23:21 +02:00
+++ edited/drivers/block/ll_rw_blk.c	2004-09-30 09:14:36 +02:00
@@ -1395,7 +1395,8 @@
 	if (!atomic_dec_and_test(&q->refcnt))
 		return;
 
-	elevator_exit(q);
+	if (q->elevator)
+		elevator_exit(q->elevator);
 
 	del_timer_sync(&q->unplug_timer);
 	kblockd_flush();
@@ -1418,6 +1419,7 @@
 	rl->count[READ] = rl->count[WRITE] = 0;
 	init_waitqueue_head(&rl->wait[READ]);
 	init_waitqueue_head(&rl->wait[WRITE]);
+	init_waitqueue_head(&rl->drain);
 
 	rl->rq_pool = mempool_create(BLKDEV_MIN_RQ, mempool_alloc_slab, mempool_free_slab, request_cachep);
 
@@ -1429,45 +1431,6 @@
 
 static int __make_request(request_queue_t *, struct bio *);
 
-static elevator_t *chosen_elevator =
-#if defined(CONFIG_IOSCHED_AS)
-	&iosched_as;
-#elif defined(CONFIG_IOSCHED_DEADLINE)
-	&iosched_deadline;
-#elif defined(CONFIG_IOSCHED_CFQ)
-	&iosched_cfq;
-#elif defined(CONFIG_IOSCHED_NOOP)
-	&elevator_noop;
-#else
-	NULL;
-#error "You must have at least 1 I/O scheduler selected"
-#endif
-
-#if defined(CONFIG_IOSCHED_AS) || defined(CONFIG_IOSCHED_DEADLINE) || defined (CONFIG_IOSCHED_NOOP)
-static int __init elevator_setup(char *str)
-{
-#ifdef CONFIG_IOSCHED_DEADLINE
-	if (!strcmp(str, "deadline"))
-		chosen_elevator = &iosched_deadline;
-#endif
-#ifdef CONFIG_IOSCHED_AS
-	if (!strcmp(str, "as"))
-		chosen_elevator = &iosched_as;
-#endif
-#ifdef CONFIG_IOSCHED_CFQ
-	if (!strcmp(str, "cfq"))
-		chosen_elevator = &iosched_cfq;
-#endif
-#ifdef CONFIG_IOSCHED_NOOP
-	if (!strcmp(str, "noop"))
-		chosen_elevator = &elevator_noop;
-#endif
-	return 1;
-}
-
-__setup("elevator=", elevator_setup);
-#endif /* CONFIG_IOSCHED_AS || CONFIG_IOSCHED_DEADLINE || CONFIG_IOSCHED_NOOP */
-
 request_queue_t *blk_alloc_queue(int gfp_mask)
 {
 	request_queue_t *q = kmem_cache_alloc(requestq_cachep, gfp_mask);
@@ -1520,21 +1483,14 @@
  **/
 request_queue_t *blk_init_queue(request_fn_proc *rfn, spinlock_t *lock)
 {
-	request_queue_t *q;
-	static int printed;
+	request_queue_t *q = blk_alloc_queue(GFP_KERNEL);
 
-	q = blk_alloc_queue(GFP_KERNEL);
 	if (!q)
 		return NULL;
 
 	if (blk_init_free_list(q))
 		goto out_init;
 
-	if (!printed) {
-		printed = 1;
-		printk("Using %s io scheduler\n", chosen_elevator->elevator_name);
-	}
-
 	q->request_fn		= rfn;
 	q->back_merge_fn       	= ll_back_merge_fn;
 	q->front_merge_fn      	= ll_front_merge_fn;
@@ -1555,7 +1511,7 @@
 	/*
 	 * all done
 	 */
-	if (!elevator_init(q, chosen_elevator))
+	if (!elevator_init(q, NULL))
 		return q;
 
 	blk_cleanup_queue(q);
@@ -1649,6 +1605,9 @@
 		if (!waitqueue_active(&rl->wait[rw]))
 			blk_clear_queue_full(q, rw);
 	}
+	if (unlikely(waitqueue_active(&rl->drain)) &&
+	    !rl->count[READ] && !rl->count[WRITE])
+		wake_up(&rl->drain);
 }
 
 #define blkdev_free_rq(list) list_entry((list)->next, struct request, queuelist)
@@ -1661,6 +1620,9 @@
 	struct request_list *rl = &q->rq;
 	struct io_context *ioc = get_io_context(gfp_mask);
 
+	if (unlikely(test_bit(QUEUE_FLAG_DRAIN, &q->queue_flags)))
+		return NULL;
+
 	spin_lock_irq(q->queue_lock);
 	if (rl->count[rw]+1 >= q->nr_requests) {
 		/*
@@ -2506,6 +2468,70 @@
 	}
 }
 
+void blk_finish_queue_drain(request_queue_t *q)
+{
+	struct request_list *rl = &q->rq;
+
+	clear_bit(QUEUE_FLAG_DRAIN, &q->queue_flags);
+	wake_up(&rl->wait[0]);
+	wake_up(&rl->wait[1]);
+	wake_up(&rl->drain);
+}
+
+/*
+ * We rely on the fact that only requests allocated through blk_alloc_request()
+ * have io scheduler private data structures associated with them. Any other
+ * type of request (allocated on stack or through kmalloc()) should not go
+ * to the io scheduler core, but be attached to the queue head instead.
+ */
+void blk_wait_queue_drained(request_queue_t *q)
+{
+	struct request_list *rl = &q->rq;
+	DEFINE_WAIT(wait);
+
+	spin_lock_irq(q->queue_lock);
+	set_bit(QUEUE_FLAG_DRAIN, &q->queue_flags);
+
+	while (rl->count[READ] || rl->count[WRITE]) {
+		prepare_to_wait(&rl->drain, &wait, TASK_UNINTERRUPTIBLE);
+
+		if (rl->count[READ] || rl->count[WRITE]) {
+			__generic_unplug_device(q);
+			spin_unlock_irq(q->queue_lock);
+			io_schedule();
+			spin_lock_irq(q->queue_lock);
+		}
+
+		finish_wait(&rl->drain, &wait);
+	}
+
+	spin_unlock_irq(q->queue_lock);
+}
+
+/*
+ * block waiting for the io scheduler being started again.
+ */
+static inline void block_wait_queue_running(request_queue_t *q)
+{
+	DEFINE_WAIT(wait);
+
+	while (test_bit(QUEUE_FLAG_DRAIN, &q->queue_flags)) {
+		struct request_list *rl = &q->rq;
+
+		prepare_to_wait_exclusive(&rl->drain, &wait,
+				TASK_UNINTERRUPTIBLE);
+
+		/*
+		 * re-check the condition. avoids using prepare_to_wait()
+		 * in the fast path (queue is running)
+		 */
+		if (test_bit(QUEUE_FLAG_DRAIN, &q->queue_flags))
+			io_schedule();
+
+		finish_wait(&rl->drain, &wait);
+	}
+}
+
 /**
  * generic_make_request: hand a buffer to its device driver for I/O
  * @bio:  The bio describing the location in memory and on the device.
@@ -2595,6 +2621,8 @@
 		if (test_bit(QUEUE_FLAG_DEAD, &q->queue_flags))
 			goto end_io;
 
+		block_wait_queue_running(q);
+
 		/*
 		 * If this device has partitions, remap block n
 		 * of partition p to block n+start(p) of the disk.
@@ -3018,6 +3046,7 @@
 {
 	flush_workqueue(kblockd_workqueue);
 }
+EXPORT_SYMBOL(kblockd_flush);
 
 int __init blk_dev_init(void)
 {
@@ -3036,6 +3065,7 @@
 
 	blk_max_low_pfn = max_low_pfn;
 	blk_max_pfn = max_pfn;
+
 	return 0;
 }
 
@@ -3055,6 +3085,7 @@
 		kmem_cache_free(iocontext_cachep, ioc);
 	}
 }
+EXPORT_SYMBOL(put_io_context);
 
 /* Called by the exitting task */
 void exit_io_context(void)
@@ -3106,6 +3137,7 @@
 	local_irq_restore(flags);
 	return ret;
 }
+EXPORT_SYMBOL(get_io_context);
 
 void copy_io_context(struct io_context **pdst, struct io_context **psrc)
 {
@@ -3119,6 +3151,7 @@
 		*pdst = src;
 	}
 }
+EXPORT_SYMBOL(copy_io_context);
 
 void swap_io_context(struct io_context **ioc1, struct io_context **ioc2)
 {
@@ -3127,7 +3160,7 @@
 	*ioc1 = *ioc2;
 	*ioc2 = temp;
 }
-
+EXPORT_SYMBOL(swap_io_context);
 
 /*
  * sysfs parts below
@@ -3285,11 +3318,18 @@
 	.show = queue_max_hw_sectors_show,
 };
 
+static struct queue_sysfs_entry queue_iosched_entry = {
+	.attr = {.name = "scheduler", .mode = S_IRUGO | S_IWUSR },
+	.show = elv_iosched_show,
+	.store = elv_iosched_store,
+};
+
 static struct attribute *default_attrs[] = {
 	&queue_requests_entry.attr,
 	&queue_ra_entry.attr,
 	&queue_max_hw_sectors_entry.attr,
 	&queue_max_sectors_entry.attr,
+	&queue_iosched_entry.attr,
 	NULL,
 };
 
===== drivers/block/noop-iosched.c 1.3 vs edited =====
--- 1.3/drivers/block/noop-iosched.c	2003-09-08 21:25:35 +02:00
+++ edited/drivers/block/noop-iosched.c	2004-09-30 09:11:37 +02:00
@@ -83,12 +83,31 @@
 	return NULL;
 }
 
-elevator_t elevator_noop = {
-	.elevator_merge_fn		= elevator_noop_merge,
-	.elevator_merge_req_fn		= elevator_noop_merge_requests,
-	.elevator_next_req_fn		= elevator_noop_next_request,
-	.elevator_add_req_fn		= elevator_noop_add_request,
-	.elevator_name			= "noop",
+static struct elevator_type elevator_noop = {
+	.ops = {
+		.elevator_merge_fn		= elevator_noop_merge,
+		.elevator_merge_req_fn		= elevator_noop_merge_requests,
+		.elevator_next_req_fn		= elevator_noop_next_request,
+		.elevator_add_req_fn		= elevator_noop_add_request,
+	},
+	.elevator_name = "noop",
+	.elevator_owner = THIS_MODULE,
 };
 
-EXPORT_SYMBOL(elevator_noop);
+int noop_init(void)
+{
+	return elv_register(&elevator_noop);
+}
+
+void noop_exit(void)
+{
+	elv_unregister(&elevator_noop);
+}
+
+module_init(noop_init);
+module_exit(noop_exit);
+
+
+MODULE_AUTHOR("Jens Axboe");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("No-op IO scheduler");
===== drivers/s390/block/dasd.c 1.77 vs edited =====
--- 1.77/drivers/s390/block/dasd.c	2004-07-07 04:32:22 +02:00
+++ edited/drivers/s390/block/dasd.c	2004-09-30 09:11:37 +02:00
@@ -1595,8 +1595,8 @@
 
 	device->request_queue->queuedata = device;
 #if 0
-	elevator_exit(device->request_queue);
-	rc = elevator_init(device->request_queue, &elevator_noop);
+	elevator_exit(device->request_queue->elevator);
+	rc = elevator_init(device->request_queue, "noop");
 	if (rc) {
 		blk_cleanup_queue(device->request_queue);
 		return rc;
===== drivers/s390/char/tape_block.c 1.12 vs edited =====
--- 1.12/drivers/s390/char/tape_block.c	2004-06-13 05:52:29 +02:00
+++ edited/drivers/s390/char/tape_block.c	2004-09-30 09:11:37 +02:00
@@ -225,8 +225,8 @@
 	if (!blkdat->request_queue)
 		return -ENOMEM;
 
-	elevator_exit(blkdat->request_queue);
-	rc = elevator_init(blkdat->request_queue, &elevator_noop);
+	elevator_exit(blkdat->request_queue->elevator);
+	rc = elevator_init(blkdat->request_queue, "noop");
 	if (rc)
 		goto cleanup_queue;
 
===== include/linux/blkdev.h 1.152 vs edited =====
--- 1.152/include/linux/blkdev.h	2004-09-14 02:23:21 +02:00
+++ edited/include/linux/blkdev.h	2004-09-30 09:11:37 +02:00
@@ -19,8 +19,8 @@
 
 struct request_queue;
 typedef struct request_queue request_queue_t;
-struct elevator_s;
-typedef struct elevator_s elevator_t;
+struct elevator_queue;
+typedef struct elevator_queue elevator_t;
 struct request_pm_state;
 
 #define BLKDEV_MIN_RQ	4
@@ -80,6 +80,7 @@
 	int count[2];
 	mempool_t *rq_pool;
 	wait_queue_head_t wait[2];
+	wait_queue_head_t drain;
 };
 
 #define BLK_MAX_CDB	16
@@ -279,7 +280,7 @@
 	 */
 	struct list_head	queue_head;
 	struct request		*last_merge;
-	elevator_t		elevator;
+	elevator_t		*elevator;
 
 	/*
 	 * the queue request freelist, one for reads and one for writes
@@ -381,6 +382,7 @@
 #define QUEUE_FLAG_REENTER	6	/* Re-entrancy avoidance */
 #define QUEUE_FLAG_PLUGGED	7	/* queue is plugged */
 #define QUEUE_FLAG_ORDERED	8	/* supports ordered writes */
+#define QUEUE_FLAG_DRAIN	9	/* draining queue for sched switch */
 
 #define blk_queue_plugged(q)	test_bit(QUEUE_FLAG_PLUGGED, &(q)->queue_flags)
 #define blk_queue_tagged(q)	test_bit(QUEUE_FLAG_QUEUED, &(q)->queue_flags)
@@ -617,6 +619,8 @@
 extern void generic_unplug_device(request_queue_t *);
 extern void __generic_unplug_device(request_queue_t *);
 extern long nr_blockdev_pages(void);
+extern void blk_wait_queue_drained(request_queue_t *);
+extern void blk_finish_queue_drain(request_queue_t *);
 
 int blk_get_queue(request_queue_t *);
 request_queue_t *blk_alloc_queue(int);
===== include/linux/elevator.h 1.31 vs edited =====
--- 1.31/include/linux/elevator.h	2004-04-12 19:55:20 +02:00
+++ edited/include/linux/elevator.h	2004-09-30 09:11:37 +02:00
@@ -22,9 +22,9 @@
 typedef void (elevator_put_req_fn) (request_queue_t *, struct request *);
 
 typedef int (elevator_init_fn) (request_queue_t *, elevator_t *);
-typedef void (elevator_exit_fn) (request_queue_t *, elevator_t *);
+typedef void (elevator_exit_fn) (elevator_t *);
 
-struct elevator_s
+struct elevator_ops
 {
 	elevator_merge_fn *elevator_merge_fn;
 	elevator_merged_fn *elevator_merged_fn;
@@ -48,12 +48,32 @@
 
 	elevator_init_fn *elevator_init_fn;
 	elevator_exit_fn *elevator_exit_fn;
+};
 
-	void *elevator_data;
+#define ELV_NAME_MAX	(16)
 
-	struct kobject kobj;
+/*
+ * identifies an elevator type, such as AS or deadline
+ */
+struct elevator_type
+{
+	struct list_head list;
+	struct elevator_ops ops;
+	struct elevator_type *elevator_type;
 	struct kobj_type *elevator_ktype;
-	const char *elevator_name;
+	char elevator_name[ELV_NAME_MAX];
+	struct module *elevator_owner;
+};
+
+/*
+ * each queue has an elevator_queue assoicated with it
+ */
+struct elevator_queue
+{
+	struct elevator_ops *ops;
+	void *elevator_data;
+	struct kobject kobj;
+	struct elevator_type *elevator_type;
 };
 
 /*
@@ -79,28 +99,19 @@
 extern void elv_put_request(request_queue_t *, struct request *);
 
 /*
- * noop I/O scheduler. always merges, always inserts new request at tail
- */
-extern elevator_t elevator_noop;
-
-/*
- * deadline i/o scheduler. uses request time outs to prevent indefinite
- * starvation
- */
-extern elevator_t iosched_deadline;
-
-/*
- * anticipatory I/O scheduler
+ * io scheduler registration
  */
-extern elevator_t iosched_as;
+extern int elv_register(struct elevator_type *);
+extern void elv_unregister(struct elevator_type *);
 
 /*
- * completely fair queueing I/O scheduler
+ * io scheduler sysfs switching
  */
-extern elevator_t iosched_cfq;
+extern ssize_t elv_iosched_show(request_queue_t *, char *);
+extern ssize_t elv_iosched_store(request_queue_t *, const char *, size_t);
 
-extern int elevator_init(request_queue_t *, elevator_t *);
-extern void elevator_exit(request_queue_t *);
+extern int elevator_init(request_queue_t *, char *);
+extern void elevator_exit(elevator_t *);
 extern int elv_rq_merge_ok(struct request *, struct bio *);
 extern int elv_try_merge(struct request *, struct bio *);
 extern int elv_try_last_merge(request_queue_t *, struct bio *);

-- 
Jens Axboe

