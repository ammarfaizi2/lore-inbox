Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750804AbWGKJGE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750804AbWGKJGE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 05:06:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750806AbWGKJGE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 05:06:04 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:53014 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1750805AbWGKJGA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 05:06:00 -0400
Date: Tue, 11 Jul 2006 11:08:39 +0200
From: Jens Axboe <axboe@suse.de>
To: linux-kernel@vger.kernel.org
Cc: nickpiggin@yahoo.com.au
Subject: [PATCH] Consolidate the request merging
Message-ID: <20060711090838.GU5210@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Right now, every IO scheduler implements its own backmerging (except for
noop, which does no merging). That results in duplicated code for
essentially the same operation, which is never a good thing. This patch
moves the backmerging out of the io schedulers and into the elevator
core. We save 1.6kb of text and as a bonus get backmerging for noop as
well. Win-win!

Notes:

- I dropped the "move hot entries to front" logic. It's never been
  proven good, and some research indicates that it's a bad idea. I doubt
  it matters in real life, so lets just cut that away.

- Next it might be a good idea to move the rb sorting into the elevator
  core as well. We could save some more kernel text, but more
  importantly it gets us one step closer to dropping deadline_rq from
  the deadline scheduler.

Please gives this patch a test spin!

 block/as-iosched.c       |  125 ---------------------------------------------
 block/cfq-iosched.c      |   66 ------------------------
 block/deadline-iosched.c |  128 -----------------------------------------------
 block/elevator.c         |  101 +++++++++++++++++++++++++++++++++++--
 block/ll_rw_blk.c        |    2 
 include/linux/blkdev.h   |    2 
 include/linux/elevator.h |    1 
 7 files changed, 105 insertions(+), 320 deletions(-)

diff --git a/block/as-iosched.c b/block/as-iosched.c
index 5da56d4..4e6e3bf 100644
--- a/block/as-iosched.c
+++ b/block/as-iosched.c
@@ -14,7 +14,6 @@ #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/init.h>
 #include <linux/compiler.h>
-#include <linux/hash.h>
 #include <linux/rbtree.h>
 #include <linux/interrupt.h>
 
@@ -95,7 +94,6 @@ struct as_data {
 
 	struct as_rq *next_arq[2];	/* next in sort order */
 	sector_t last_sector[2];	/* last REQ_SYNC & REQ_ASYNC sectors */
-	struct hlist_head *hash;	/* request hash */
 
 	unsigned long exit_prob;	/* probability a task will exit while
 					   being waited on */
@@ -162,11 +160,6 @@ struct as_rq {
 	struct io_context *io_context;	/* The submitting task */
 
 	/*
-	 * request hash, key is the ending offset (for back merge lookup)
-	 */
-	struct hlist_node hash;
-
-	/*
 	 * expire fifo
 	 */
 	struct list_head fifo;
@@ -273,77 +266,6 @@ static void as_put_io_context(struct as_
 }
 
 /*
- * the back merge hash support functions
- */
-static const int as_hash_shift = 6;
-#define AS_HASH_BLOCK(sec)	((sec) >> 3)
-#define AS_HASH_FN(sec)		(hash_long(AS_HASH_BLOCK((sec)), as_hash_shift))
-#define AS_HASH_ENTRIES		(1 << as_hash_shift)
-#define rq_hash_key(rq)		((rq)->sector + (rq)->nr_sectors)
-
-static inline void __as_del_arq_hash(struct as_rq *arq)
-{
-	hlist_del_init(&arq->hash);
-}
-
-static inline void as_del_arq_hash(struct as_rq *arq)
-{
-	if (!hlist_unhashed(&arq->hash))
-		__as_del_arq_hash(arq);
-}
-
-static void as_add_arq_hash(struct as_data *ad, struct as_rq *arq)
-{
-	struct request *rq = arq->request;
-
-	BUG_ON(!hlist_unhashed(&arq->hash));
-
-	hlist_add_head(&arq->hash, &ad->hash[AS_HASH_FN(rq_hash_key(rq))]);
-}
-
-/*
- * move hot entry to front of chain
- */
-static inline void as_hot_arq_hash(struct as_data *ad, struct as_rq *arq)
-{
-	struct request *rq = arq->request;
-	struct hlist_head *head = &ad->hash[AS_HASH_FN(rq_hash_key(rq))];
-
-	if (hlist_unhashed(&arq->hash)) {
-		WARN_ON(1);
-		return;
-	}
-
-	if (&arq->hash != head->first) {
-		hlist_del(&arq->hash);
-		hlist_add_head(&arq->hash, head);
-	}
-}
-
-static struct request *as_find_arq_hash(struct as_data *ad, sector_t offset)
-{
-	struct hlist_head *hash_list = &ad->hash[AS_HASH_FN(offset)];
-	struct hlist_node *entry, *next;
-	struct as_rq *arq;
-
-	hlist_for_each_entry_safe(arq, entry, next, hash_list, hash) {
-		struct request *__rq = arq->request;
-
-		BUG_ON(hlist_unhashed(&arq->hash));
-
-		if (!rq_mergeable(__rq)) {
-			as_del_arq_hash(arq);
-			continue;
-		}
-
-		if (rq_hash_key(__rq) == offset)
-			return __rq;
-	}
-
-	return NULL;
-}
-
-/*
  * rb tree support functions
  */
 #define rb_entry_arq(node)	rb_entry((node), struct as_rq, rb_node)
@@ -1060,7 +982,6 @@ static void as_remove_queued_request(req
 		ad->next_arq[data_dir] = as_find_next_arq(ad, arq);
 
 	list_del_init(&arq->fifo);
-	as_del_arq_hash(arq);
 	as_del_arq_rb(ad, arq);
 }
 
@@ -1349,8 +1270,6 @@ static void as_add_request(request_queue
 	}
 
 	as_add_arq_rb(ad, arq);
-	if (rq_mergeable(arq->request))
-		as_add_arq_hash(ad, arq);
 
 	/*
 	 * set expire time (only used for reads) and add to fifo list
@@ -1431,19 +1350,6 @@ as_merge(request_queue_t *q, struct requ
 	int ret;
 
 	/*
-	 * see if the merge hash can satisfy a back merge
-	 */
-	__rq = as_find_arq_hash(ad, bio->bi_sector);
-	if (__rq) {
-		BUG_ON(__rq->sector + __rq->nr_sectors != bio->bi_sector);
-
-		if (elv_rq_merge_ok(__rq, bio)) {
-			ret = ELEVATOR_BACK_MERGE;
-			goto out;
-		}
-	}
-
-	/*
 	 * check for front merge
 	 */
 	__rq = as_find_arq_rb(ad, rb_key, bio_data_dir(bio));
@@ -1458,10 +1364,6 @@ as_merge(request_queue_t *q, struct requ
 
 	return ELEVATOR_NO_MERGE;
 out:
-	if (ret) {
-		if (rq_mergeable(__rq))
-			as_hot_arq_hash(ad, RQ_DATA(__rq));
-	}
 	*req = __rq;
 	return ret;
 }
@@ -1472,12 +1374,6 @@ static void as_merged_request(request_qu
 	struct as_rq *arq = RQ_DATA(req);
 
 	/*
-	 * hash always needs to be repositioned, key is end sector
-	 */
-	as_del_arq_hash(arq);
-	as_add_arq_hash(ad, arq);
-
-	/*
 	 * if the merge was a front merge, we need to reposition request
 	 */
 	if (rq_rb_key(req) != arq->rb_key) {
@@ -1501,13 +1397,6 @@ static void as_merged_requests(request_q
 	BUG_ON(!arq);
 	BUG_ON(!anext);
 
-	/*
-	 * reposition arq (this is the merged request) in hash, and in rbtree
-	 * in case of a front merge
-	 */
-	as_del_arq_hash(arq);
-	as_add_arq_hash(ad, arq);
-
 	if (rq_rb_key(req) != arq->rb_key) {
 		as_del_arq_rb(ad, arq);
 		as_add_arq_rb(ad, arq);
@@ -1591,7 +1480,6 @@ static int as_set_request(request_queue_
 		arq->request = rq;
 		arq->state = AS_RQ_PRESCHED;
 		arq->io_context = NULL;
-		INIT_HLIST_NODE(&arq->hash);
 		INIT_LIST_HEAD(&arq->fifo);
 		rq->elevator_private = arq;
 		return 0;
@@ -1628,7 +1516,6 @@ static void as_exit_queue(elevator_t *e)
 
 	mempool_destroy(ad->arq_pool);
 	put_io_context(ad->io_context);
-	kfree(ad->hash);
 	kfree(ad);
 }
 
@@ -1639,7 +1526,6 @@ static void as_exit_queue(elevator_t *e)
 static void *as_init_queue(request_queue_t *q, elevator_t *e)
 {
 	struct as_data *ad;
-	int i;
 
 	if (!arq_pool)
 		return NULL;
@@ -1651,17 +1537,9 @@ static void *as_init_queue(request_queue
 
 	ad->q = q; /* Identify what queue the data belongs to */
 
-	ad->hash = kmalloc_node(sizeof(struct hlist_head)*AS_HASH_ENTRIES,
-				GFP_KERNEL, q->node);
-	if (!ad->hash) {
-		kfree(ad);
-		return NULL;
-	}
-
 	ad->arq_pool = mempool_create_node(BLKDEV_MIN_RQ, mempool_alloc_slab,
 				mempool_free_slab, arq_pool, q->node);
 	if (!ad->arq_pool) {
-		kfree(ad->hash);
 		kfree(ad);
 		return NULL;
 	}
@@ -1672,9 +1550,6 @@ static void *as_init_queue(request_queue
 	init_timer(&ad->antic_timer);
 	INIT_WORK(&ad->antic_work, as_work_handler, q);
 
-	for (i = 0; i < AS_HASH_ENTRIES; i++)
-		INIT_HLIST_HEAD(&ad->hash[i]);
-
 	INIT_LIST_HEAD(&ad->fifo_list[REQ_SYNC]);
 	INIT_LIST_HEAD(&ad->fifo_list[REQ_ASYNC]);
 	ad->sort_list[REQ_SYNC] = RB_ROOT;
diff --git a/block/cfq-iosched.c b/block/cfq-iosched.c
index 102ebc2..5b73ef7 100644
--- a/block/cfq-iosched.c
+++ b/block/cfq-iosched.c
@@ -112,11 +112,6 @@ struct cfq_data {
 	 */
 	struct hlist_head *cfq_hash;
 
-	/*
-	 * global crq hash for all queues
-	 */
-	struct hlist_head *crq_hash;
-
 	mempool_t *crq_pool;
 
 	int rq_in_driver;
@@ -272,42 +267,6 @@ static void cfq_dispatch_insert(request_
 static struct cfq_queue *cfq_get_queue(struct cfq_data *cfqd, unsigned int key, struct task_struct *tsk, gfp_t gfp_mask);
 
 /*
- * lots of deadline iosched dupes, can be abstracted later...
- */
-static inline void cfq_del_crq_hash(struct cfq_rq *crq)
-{
-	hlist_del_init(&crq->hash);
-}
-
-static inline void cfq_add_crq_hash(struct cfq_data *cfqd, struct cfq_rq *crq)
-{
-	const int hash_idx = CFQ_MHASH_FN(rq_hash_key(crq->request));
-
-	hlist_add_head(&crq->hash, &cfqd->crq_hash[hash_idx]);
-}
-
-static struct request *cfq_find_rq_hash(struct cfq_data *cfqd, sector_t offset)
-{
-	struct hlist_head *hash_list = &cfqd->crq_hash[CFQ_MHASH_FN(offset)];
-	struct hlist_node *entry, *next;
-
-	hlist_for_each_safe(entry, next, hash_list) {
-		struct cfq_rq *crq = list_entry_hash(entry);
-		struct request *__rq = crq->request;
-
-		if (!rq_mergeable(__rq)) {
-			cfq_del_crq_hash(crq);
-			continue;
-		}
-
-		if (rq_hash_key(__rq) == offset)
-			return __rq;
-	}
-
-	return NULL;
-}
-
-/*
  * scheduler run of queue, if there are requests pending and no one in the
  * driver that will restart queueing
  */
@@ -677,7 +636,6 @@ static void cfq_remove_request(struct re
 
 	list_del_init(&rq->queuelist);
 	cfq_del_crq_rb(crq);
-	cfq_del_crq_hash(crq);
 }
 
 static int
@@ -687,12 +645,6 @@ cfq_merge(request_queue_t *q, struct req
 	struct request *__rq;
 	int ret;
 
-	__rq = cfq_find_rq_hash(cfqd, bio->bi_sector);
-	if (__rq && elv_rq_merge_ok(__rq, bio)) {
-		ret = ELEVATOR_BACK_MERGE;
-		goto out;
-	}
-
 	__rq = cfq_find_rq_fmerge(cfqd, bio);
 	if (__rq && elv_rq_merge_ok(__rq, bio)) {
 		ret = ELEVATOR_FRONT_MERGE;
@@ -707,12 +659,8 @@ out:
 
 static void cfq_merged_request(request_queue_t *q, struct request *req)
 {
-	struct cfq_data *cfqd = q->elevator->elevator_data;
 	struct cfq_rq *crq = RQ_DATA(req);
 
-	cfq_del_crq_hash(crq);
-	cfq_add_crq_hash(cfqd, crq);
-
 	if (rq_rb_key(req) != crq->rb_key) {
 		struct cfq_queue *cfqq = crq->cfq_queue;
 
@@ -1825,9 +1773,6 @@ static void cfq_insert_request(request_q
 
 	list_add_tail(&rq->queuelist, &cfqq->fifo);
 
-	if (rq_mergeable(rq))
-		cfq_add_crq_hash(cfqd, crq);
-
 	cfq_crq_enqueued(cfqd, cfqq, crq);
 }
 
@@ -2221,7 +2166,6 @@ static void cfq_exit_queue(elevator_t *e
 	cfq_shutdown_timer_wq(cfqd);
 
 	mempool_destroy(cfqd->crq_pool);
-	kfree(cfqd->crq_hash);
 	kfree(cfqd->cfq_hash);
 	kfree(cfqd);
 }
@@ -2246,20 +2190,14 @@ static void *cfq_init_queue(request_queu
 	INIT_LIST_HEAD(&cfqd->empty_list);
 	INIT_LIST_HEAD(&cfqd->cic_list);
 
-	cfqd->crq_hash = kmalloc(sizeof(struct hlist_head) * CFQ_MHASH_ENTRIES, GFP_KERNEL);
-	if (!cfqd->crq_hash)
-		goto out_crqhash;
-
 	cfqd->cfq_hash = kmalloc(sizeof(struct hlist_head) * CFQ_QHASH_ENTRIES, GFP_KERNEL);
 	if (!cfqd->cfq_hash)
-		goto out_cfqhash;
+		goto out_crqhash;
 
 	cfqd->crq_pool = mempool_create_slab_pool(BLKDEV_MIN_RQ, crq_pool);
 	if (!cfqd->crq_pool)
 		goto out_crqpool;
 
-	for (i = 0; i < CFQ_MHASH_ENTRIES; i++)
-		INIT_HLIST_HEAD(&cfqd->crq_hash[i]);
 	for (i = 0; i < CFQ_QHASH_ENTRIES; i++)
 		INIT_HLIST_HEAD(&cfqd->cfq_hash[i]);
 
@@ -2289,8 +2227,6 @@ static void *cfq_init_queue(request_queu
 	return cfqd;
 out_crqpool:
 	kfree(cfqd->cfq_hash);
-out_cfqhash:
-	kfree(cfqd->crq_hash);
 out_crqhash:
 	kfree(cfqd);
 	return NULL;
diff --git a/block/deadline-iosched.c b/block/deadline-iosched.c
index c7ca9f0..b66e820 100644
--- a/block/deadline-iosched.c
+++ b/block/deadline-iosched.c
@@ -12,7 +12,6 @@ #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/init.h>
 #include <linux/compiler.h>
-#include <linux/hash.h>
 #include <linux/rbtree.h>
 
 /*
@@ -24,13 +23,6 @@ static const int writes_starved = 2;    
 static const int fifo_batch = 16;       /* # of sequential requests treated as one
 				     by the above parameters. For throughput. */
 
-static const int deadline_hash_shift = 5;
-#define DL_HASH_BLOCK(sec)	((sec) >> 3)
-#define DL_HASH_FN(sec)		(hash_long(DL_HASH_BLOCK((sec)), deadline_hash_shift))
-#define DL_HASH_ENTRIES		(1 << deadline_hash_shift)
-#define rq_hash_key(rq)		((rq)->sector + (rq)->nr_sectors)
-#define ON_HASH(drq)		(!hlist_unhashed(&(drq)->hash))
-
 struct deadline_data {
 	/*
 	 * run time data
@@ -46,7 +38,6 @@ struct deadline_data {
 	 * next in sort order. read, write or both are NULL
 	 */
 	struct deadline_rq *next_drq[2];
-	struct hlist_head *hash;	/* request hash */
 	unsigned int batching;		/* number of sequential requests made */
 	sector_t last_sector;		/* head position */
 	unsigned int starved;		/* times reads have starved writes */
@@ -75,11 +66,6 @@ struct deadline_rq {
 	struct request *request;
 
 	/*
-	 * request hash, key is the ending offset (for back merge lookup)
-	 */
-	struct hlist_node hash;
-
-	/*
 	 * expire fifo
 	 */
 	struct list_head fifo;
@@ -93,69 +79,6 @@ static kmem_cache_t *drq_pool;
 #define RQ_DATA(rq)	((struct deadline_rq *) (rq)->elevator_private)
 
 /*
- * the back merge hash support functions
- */
-static inline void __deadline_del_drq_hash(struct deadline_rq *drq)
-{
-	hlist_del_init(&drq->hash);
-}
-
-static inline void deadline_del_drq_hash(struct deadline_rq *drq)
-{
-	if (ON_HASH(drq))
-		__deadline_del_drq_hash(drq);
-}
-
-static inline void
-deadline_add_drq_hash(struct deadline_data *dd, struct deadline_rq *drq)
-{
-	struct request *rq = drq->request;
-
-	BUG_ON(ON_HASH(drq));
-
-	hlist_add_head(&drq->hash, &dd->hash[DL_HASH_FN(rq_hash_key(rq))]);
-}
-
-/*
- * move hot entry to front of chain
- */
-static inline void
-deadline_hot_drq_hash(struct deadline_data *dd, struct deadline_rq *drq)
-{
-	struct request *rq = drq->request;
-	struct hlist_head *head = &dd->hash[DL_HASH_FN(rq_hash_key(rq))];
-
-	if (ON_HASH(drq) && &drq->hash != head->first) {
-		hlist_del(&drq->hash);
-		hlist_add_head(&drq->hash, head);
-	}
-}
-
-static struct request *
-deadline_find_drq_hash(struct deadline_data *dd, sector_t offset)
-{
-	struct hlist_head *hash_list = &dd->hash[DL_HASH_FN(offset)];
-	struct hlist_node *entry, *next;
-	struct deadline_rq *drq;
-
-	hlist_for_each_entry_safe(drq, entry, next, hash_list, hash) {
-		struct request *__rq = drq->request;
-
-		BUG_ON(!ON_HASH(drq));
-
-		if (!rq_mergeable(__rq)) {
-			__deadline_del_drq_hash(drq);
-			continue;
-		}
-
-		if (rq_hash_key(__rq) == offset)
-			return __rq;
-	}
-
-	return NULL;
-}
-
-/*
  * rb tree support functions
  */
 #define rb_entry_drq(node)	rb_entry((node), struct deadline_rq, rb_node)
@@ -267,22 +190,19 @@ deadline_add_request(struct request_queu
 {
 	struct deadline_data *dd = q->elevator->elevator_data;
 	struct deadline_rq *drq = RQ_DATA(rq);
-
 	const int data_dir = rq_data_dir(drq->request);
 
 	deadline_add_drq_rb(dd, drq);
+
 	/*
 	 * set expire time (only used for reads) and add to fifo list
 	 */
 	drq->expires = jiffies + dd->fifo_expire[data_dir];
 	list_add_tail(&drq->fifo, &dd->fifo_list[data_dir]);
-
-	if (rq_mergeable(rq))
-		deadline_add_drq_hash(dd, drq);
 }
 
 /*
- * remove rq from rbtree, fifo, and hash
+ * remove rq from rbtree and fifo.
  */
 static void deadline_remove_request(request_queue_t *q, struct request *rq)
 {
@@ -291,7 +211,6 @@ static void deadline_remove_request(requ
 
 	list_del_init(&drq->fifo);
 	deadline_del_drq_rb(dd, drq);
-	deadline_del_drq_hash(drq);
 }
 
 static int
@@ -302,19 +221,6 @@ deadline_merge(request_queue_t *q, struc
 	int ret;
 
 	/*
-	 * see if the merge hash can satisfy a back merge
-	 */
-	__rq = deadline_find_drq_hash(dd, bio->bi_sector);
-	if (__rq) {
-		BUG_ON(__rq->sector + __rq->nr_sectors != bio->bi_sector);
-
-		if (elv_rq_merge_ok(__rq, bio)) {
-			ret = ELEVATOR_BACK_MERGE;
-			goto out;
-		}
-	}
-
-	/*
 	 * check for front merge
 	 */
 	if (dd->front_merges) {
@@ -333,8 +239,6 @@ deadline_merge(request_queue_t *q, struc
 
 	return ELEVATOR_NO_MERGE;
 out:
-	if (ret)
-		deadline_hot_drq_hash(dd, RQ_DATA(__rq));
 	*req = __rq;
 	return ret;
 }
@@ -345,12 +249,6 @@ static void deadline_merged_request(requ
 	struct deadline_rq *drq = RQ_DATA(req);
 
 	/*
-	 * hash always needs to be repositioned, key is end sector
-	 */
-	deadline_del_drq_hash(drq);
-	deadline_add_drq_hash(dd, drq);
-
-	/*
 	 * if the merge was a front merge, we need to reposition request
 	 */
 	if (rq_rb_key(req) != drq->rb_key) {
@@ -370,13 +268,6 @@ deadline_merged_requests(request_queue_t
 	BUG_ON(!drq);
 	BUG_ON(!dnext);
 
-	/*
-	 * reposition drq (this is the merged request) in hash, and in rbtree
-	 * in case of a front merge
-	 */
-	deadline_del_drq_hash(drq);
-	deadline_add_drq_hash(dd, drq);
-
 	if (rq_rb_key(req) != drq->rb_key) {
 		deadline_del_drq_rb(dd, drq);
 		deadline_add_drq_rb(dd, drq);
@@ -594,7 +485,6 @@ static void deadline_exit_queue(elevator
 	BUG_ON(!list_empty(&dd->fifo_list[WRITE]));
 
 	mempool_destroy(dd->drq_pool);
-	kfree(dd->hash);
 	kfree(dd);
 }
 
@@ -605,7 +495,6 @@ static void deadline_exit_queue(elevator
 static void *deadline_init_queue(request_queue_t *q, elevator_t *e)
 {
 	struct deadline_data *dd;
-	int i;
 
 	if (!drq_pool)
 		return NULL;
@@ -615,24 +504,13 @@ static void *deadline_init_queue(request
 		return NULL;
 	memset(dd, 0, sizeof(*dd));
 
-	dd->hash = kmalloc_node(sizeof(struct hlist_head)*DL_HASH_ENTRIES,
-				GFP_KERNEL, q->node);
-	if (!dd->hash) {
-		kfree(dd);
-		return NULL;
-	}
-
 	dd->drq_pool = mempool_create_node(BLKDEV_MIN_RQ, mempool_alloc_slab,
 					mempool_free_slab, drq_pool, q->node);
 	if (!dd->drq_pool) {
-		kfree(dd->hash);
 		kfree(dd);
 		return NULL;
 	}
 
-	for (i = 0; i < DL_HASH_ENTRIES; i++)
-		INIT_HLIST_HEAD(&dd->hash[i]);
-
 	INIT_LIST_HEAD(&dd->fifo_list[READ]);
 	INIT_LIST_HEAD(&dd->fifo_list[WRITE]);
 	dd->sort_list[READ] = RB_ROOT;
@@ -667,8 +545,6 @@ deadline_set_request(request_queue_t *q,
 		RB_CLEAR_NODE(&drq->rb_node);
 		drq->request = rq;
 
-		INIT_HLIST_NODE(&drq->hash);
-
 		INIT_LIST_HEAD(&drq->fifo);
 
 		rq->elevator_private = drq;
diff --git a/block/elevator.c b/block/elevator.c
index bc7baee..3df5ee1 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -33,6 +33,7 @@ #include <linux/init.h>
 #include <linux/compiler.h>
 #include <linux/delay.h>
 #include <linux/blktrace_api.h>
+#include <linux/hash.h>
 
 #include <asm/uaccess.h>
 
@@ -40,6 +41,16 @@ static DEFINE_SPINLOCK(elv_list_lock);
 static LIST_HEAD(elv_list);
 
 /*
+ * Merge hash stuff.
+ */
+static const int elv_hash_shift = 6;
+#define ELV_HASH_BLOCK(sec)	((sec) >> 3)
+#define ELV_HASH_FN(sec)	(hash_long(ELV_HASH_BLOCK((sec)), elv_hash_shift))
+#define ELV_HASH_ENTRIES	(1 << elv_hash_shift)
+#define rq_hash_key(rq)		((rq)->sector + (rq)->nr_sectors)
+#define ELV_ON_HASH(rq)		(!hlist_unhashed(&(rq)->hash))
+
+/*
  * can we safely merge with this request?
  */
 inline int elv_rq_merge_ok(struct request *rq, struct bio *bio)
@@ -179,7 +190,7 @@ int elevator_init(request_queue_t *q, ch
 {
 	struct elevator_type *e = NULL;
 	struct elevator_queue *eq;
-	int ret = 0;
+	int ret = 0, i;
 	void *data;
 
 	INIT_LIST_HEAD(&q->queue_head);
@@ -202,9 +213,20 @@ int elevator_init(request_queue_t *q, ch
 	if (!eq)
 		return -ENOMEM;
 
+	eq->hash = kmalloc_node(sizeof(struct hlist_head) * ELV_HASH_ENTRIES,
+				GFP_KERNEL, q->node);
+	if (!eq->hash) {
+		kobject_put(&eq->kobj);
+		return -ENOMEM;
+	}
+
+	for (i = 0; i < ELV_HASH_ENTRIES; i++)
+		INIT_HLIST_HEAD(&eq->hash[i]);
+
 	data = elevator_init_queue(q, eq);
 	if (!data) {
 		kobject_put(&eq->kobj);
+		kfree(eq->hash);
 		return -ENOMEM;
 	}
 
@@ -218,11 +240,59 @@ void elevator_exit(elevator_t *e)
 	if (e->ops->elevator_exit_fn)
 		e->ops->elevator_exit_fn(e);
 	e->ops = NULL;
+	kfree(e->hash);
 	mutex_unlock(&e->sysfs_lock);
 
 	kobject_put(&e->kobj);
 }
 
+static inline void __elv_rqhash_del(struct request *rq)
+{
+	hlist_del_init(&rq->hash);
+}
+
+static void elv_rqhash_del(request_queue_t *q, struct request *rq)
+{
+	if (ELV_ON_HASH(rq))
+		__elv_rqhash_del(rq);
+}
+
+static void elv_rqhash_add(request_queue_t *q, struct request *rq)
+{
+	elevator_t *e = q->elevator;
+
+	BUG_ON(ELV_ON_HASH(rq));
+	hlist_add_head(&rq->hash, &e->hash[ELV_HASH_FN(rq_hash_key(rq))]);
+}
+
+static void elv_rqhash_reposition(request_queue_t *q, struct request *rq)
+{
+	__elv_rqhash_del(rq);
+	elv_rqhash_add(q, rq);
+}
+
+static struct request *elv_rqhash_find(request_queue_t *q, sector_t offset)
+{
+	elevator_t *e = q->elevator;
+	struct hlist_head *hash_list = &e->hash[ELV_HASH_FN(offset)];
+	struct hlist_node *entry, *next;
+	struct request *rq;
+
+	hlist_for_each_entry_safe(rq, entry, next, hash_list, hash) {
+		BUG_ON(!ELV_ON_HASH(rq));
+
+		if (unlikely(!rq_mergeable(rq))) {
+			__elv_rqhash_del(rq);
+			continue;
+		}
+
+		if (rq_hash_key(rq) == offset)
+			return rq;
+	}
+
+	return NULL;
+}
+
 /*
  * Insert rq into dispatch queue of q.  Queue lock must be held on
  * entry.  If sort != 0, rq is sort-inserted; otherwise, rq will be
@@ -235,6 +305,9 @@ void elv_dispatch_sort(request_queue_t *
 
 	if (q->last_merge == rq)
 		q->last_merge = NULL;
+
+	elv_rqhash_del(q, rq);
+
 	q->nr_sorted--;
 
 	boundary = q->end_sector;
@@ -263,6 +336,9 @@ int elv_merge(request_queue_t *q, struct
 	elevator_t *e = q->elevator;
 	int ret;
 
+	/*
+	 * First try one-hit cache.
+	 */
 	if (q->last_merge) {
 		ret = elv_try_merge(q->last_merge, bio);
 		if (ret != ELEVATOR_NO_MERGE) {
@@ -271,6 +347,13 @@ int elv_merge(request_queue_t *q, struct
 		}
 	}
 
+	/*
+	 * See if our hash lookup can find a potential backmerge.
+	 */
+	*req = elv_rqhash_find(q, bio->bi_sector);
+	if (*req && elv_rq_merge_ok(*req, bio))
+		return ELEVATOR_BACK_MERGE;
+
 	if (e->ops->elevator_merge_fn)
 		return e->ops->elevator_merge_fn(q, req, bio);
 
@@ -284,6 +367,8 @@ void elv_merged_request(request_queue_t 
 	if (e->ops->elevator_merged_fn)
 		e->ops->elevator_merged_fn(q, rq);
 
+	elv_rqhash_reposition(q, rq);
+
 	q->last_merge = rq;
 }
 
@@ -294,8 +379,11 @@ void elv_merge_requests(request_queue_t 
 
 	if (e->ops->elevator_merge_req_fn)
 		e->ops->elevator_merge_req_fn(q, rq, next);
-	q->nr_sorted--;
 
+	elv_rqhash_reposition(q, rq);
+	elv_rqhash_del(q, next);
+
+	q->nr_sorted--;
 	q->last_merge = rq;
 }
 
@@ -371,8 +459,12 @@ void elv_insert(request_queue_t *q, stru
 		BUG_ON(!blk_fs_request(rq));
 		rq->flags |= REQ_SORTED;
 		q->nr_sorted++;
-		if (q->last_merge == NULL && rq_mergeable(rq))
-			q->last_merge = rq;
+		if (rq_mergeable(rq)) {
+			elv_rqhash_add(q, rq);
+			if (!q->last_merge)
+				q->last_merge = rq;
+		}
+
 		/*
 		 * Some ioscheds (cfq) run q->request_fn directly, so
 		 * rq cannot be accessed after calling
@@ -557,6 +649,7 @@ struct request *elv_next_request(request
 void elv_dequeue_request(request_queue_t *q, struct request *rq)
 {
 	BUG_ON(list_empty(&rq->queuelist));
+	BUG_ON(ELV_ON_HASH(rq));
 
 	list_del_init(&rq->queuelist);
 
diff --git a/block/ll_rw_blk.c b/block/ll_rw_blk.c
index 61d6b3c..84c7b1c 100644
--- a/block/ll_rw_blk.c
+++ b/block/ll_rw_blk.c
@@ -281,6 +281,7 @@ static inline void rq_init(request_queue
 {
 	INIT_LIST_HEAD(&rq->queuelist);
 	INIT_LIST_HEAD(&rq->donelist);
+	INIT_HLIST_NODE(&rq->hash);
 
 	rq->errors = 0;
 	rq->rq_status = RQ_ACTIVE;
@@ -2665,6 +2666,7 @@ void __blk_put_request(request_queue_t *
 		int priv = req->flags & REQ_ELVPRIV;
 
 		BUG_ON(!list_empty(&req->queuelist));
+		BUG_ON(!hlist_unhashed(&req->hash));
 
 		blk_free_request(q, req);
 		freed_request(q, rw, priv);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index aafe827..fc8b59e 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -148,6 +148,8 @@ struct request {
 	struct bio *bio;
 	struct bio *biotail;
 
+	struct hlist_node hash;	/* merge hash */
+
 	void *elevator_private;
 	void *completion_data;
 
diff --git a/include/linux/elevator.h b/include/linux/elevator.h
index 1713ace..8f4a599 100644
--- a/include/linux/elevator.h
+++ b/include/linux/elevator.h
@@ -82,6 +82,7 @@ struct elevator_queue
 	struct kobject kobj;
 	struct elevator_type *elevator_type;
 	struct mutex sysfs_lock;
+	struct hlist_head *hash;
 };
 
 /*


-- 
Jens Axboe

