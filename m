Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267328AbTBKI5S>; Tue, 11 Feb 2003 03:57:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267329AbTBKI5S>; Tue, 11 Feb 2003 03:57:18 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:2277 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S267328AbTBKI5I>;
	Tue, 11 Feb 2003 03:57:08 -0500
Date: Tue, 11 Feb 2003 10:06:44 +0100
From: Jens Axboe <axboe@suse.de>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, conman@kolivas.net
Subject: CFQ disk scheduler (was Re: [PATCH] SFQ disk scheduler)
Message-ID: <20030211090644.GI26018@suse.de>
References: <20030210145001.GT12828@suse.de> <20030210151144.GT31401@dualathlon.random> <20030210152226.GV12828@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030210152226.GV12828@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

In the nature of taking this concept to the extreme, here's a CFQ disk
scheduler (it should be obvious by now, that I'm simply making up a TLA
as I see fit :-), or Complete Fair Queueing. It never suffers from queue
collisions.

So how does it work? As with SFQ, a hash of busy queues is maintained.
If a queue for a given queue doesn't exist, one is simply allocated. The
actual queueing of requests works like the SFQ scheduler I sent out
yesterday, with little twist: we try to put at least cfq_quantum number
of requests on the dispatch queue. If only a small number of processes
are waiting for io, then this significantly helps throughput by
minimizing the time spent between finishing one request and starting a
new one.

Other changes/fixes from SFQ:

- Leave request mergeable even while on the dispatch list, to make the
  merge window as big as possible.

- The dispatch_sort() would sometimes not order requests correctly.

- Various small fixes.

Interestingly, dbench results show little variance between runs with
this CFQ scheduler. Another point of interesting to folks may be that it
would be trivial to add process io priorities on top of CFQ (or SFQ for
that matter, but I consider CFQ to be the superiour scheduler).

If you play with this, let me know how it fares. Patch is against
2.5.60.

===== drivers/block/Makefile 1.14 vs edited =====
--- 1.14/drivers/block/Makefile	Mon Feb  3 23:19:36 2003
+++ edited/drivers/block/Makefile	Tue Feb 11 09:35:55 2003
@@ -8,7 +8,8 @@
 # In the future, some of these should be built conditionally.
 #
 
-obj-y	:= elevator.o ll_rw_blk.o ioctl.o genhd.o scsi_ioctl.o deadline-iosched.o
+obj-y	:= elevator.o ll_rw_blk.o ioctl.o genhd.o scsi_ioctl.o \
+	    deadline-iosched.o cfq-iosched.o
 
 obj-$(CONFIG_MAC_FLOPPY)	+= swim3.o
 obj-$(CONFIG_BLK_DEV_FD)	+= floppy.o
===== drivers/block/ll_rw_blk.c 1.149 vs edited =====
--- 1.149/drivers/block/ll_rw_blk.c	Thu Feb  6 05:04:17 2003
+++ edited/drivers/block/ll_rw_blk.c	Tue Feb 11 10:01:44 2003
@@ -1279,7 +1279,7 @@
 	if (blk_init_free_list(q))
 		return -ENOMEM;
 
-	if ((ret = elevator_init(q, &iosched_deadline))) {
+	if ((ret = elevator_init(q, &iosched_cfq))) {
 		blk_cleanup_queue(q);
 		return ret;
 	}
===== include/linux/elevator.h 1.18 vs edited =====
--- 1.18/include/linux/elevator.h	Sun Jan 12 15:10:40 2003
+++ edited/include/linux/elevator.h	Tue Feb 11 09:36:11 2003
@@ -73,6 +73,8 @@
  */
 extern elevator_t iosched_deadline;
 
+extern elevator_t iosched_cfq;
+
 extern int elevator_init(request_queue_t *, elevator_t *);
 extern void elevator_exit(request_queue_t *);
 extern inline int bio_rq_in_between(struct bio *, struct request *, struct list_head *);
--- /dev/null	2003-01-19 21:08:59.000000000 +0100
+++ linux-2.5-sfq/drivers/block/cfq-iosched.c	2003-02-11 10:01:21.000000000 +0100
@@ -0,0 +1,619 @@
+/*
+ *  linux/drivers/block/cfq-iosched.c
+ *
+ *  CFQ, or complete fairness queueing, disk scheduler.
+ *
+ *  Based on ideas from a previously unfinished io
+ *  scheduler (round robin per-process disk scheduling) and Andrea Arcangeli.
+ *
+ *  Copyright (C) 2003 Jens Axboe <axboe@suse.de>
+ */
+#include <linux/kernel.h>
+#include <linux/fs.h>
+#include <linux/blkdev.h>
+#include <linux/elevator.h>
+#include <linux/bio.h>
+#include <linux/blk.h>
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/init.h>
+#include <linux/compiler.h>
+#include <linux/hash.h>
+#include <linux/rbtree.h>
+#include <linux/mempool.h>
+
+/*
+ * tunables
+ */
+static int cfq_quantum = 8;
+
+#define CFQ_QHASH_SHIFT		6
+#define CFQ_QHASH_ENTRIES	(1 << CFQ_QHASH_SHIFT)
+#define list_entry_qhash(entry)	list_entry((entry), struct cfq_queue, cfq_hash)
+
+#define CFQ_MHASH_SHIFT		8
+#define CFQ_MHASH_BLOCK(sec)	((sec) >> 3)
+#define CFQ_MHASH_ENTRIES	(1 << CFQ_MHASH_SHIFT)
+#define CFQ_MHASH_FN(sec)	(hash_long(CFQ_MHASH_BLOCK((sec)),CFQ_MHASH_SHIFT))
+#define ON_MHASH(crq)		!list_empty(&(crq)->hash)
+#define rq_hash_key(rq)		((rq)->sector + (rq)->nr_sectors)
+#define list_entry_hash(ptr)	list_entry((ptr), struct cfq_rq, hash)
+
+#define list_entry_cfqq(ptr)	list_entry((ptr), struct cfq_queue, cfq_list)
+
+#define RQ_DATA(rq)		((struct cfq_rq *) (rq)->elevator_private)
+
+static kmem_cache_t *crq_pool;
+static kmem_cache_t *cfq_pool;
+static mempool_t *cfq_mpool;
+
+struct cfq_queue {
+	struct list_head cfq_hash;
+	struct list_head cfq_list;
+	struct rb_root sort_list;
+	int pid;
+#if 0
+	/*
+	 * with a simple addition like this, we can do io priorities. almost.
+	 * does need a split request free list, too.
+	 */
+	int io_prio
+#endif
+};
+
+struct cfq_data {
+	struct list_head rr_list;
+	struct list_head *dispatch;
+	struct list_head *cfq_hash;
+
+	struct list_head *crq_hash;
+
+	unsigned long random_seed;
+};
+
+struct cfq_rq {
+	struct rb_node rb_node;
+	sector_t rb_key;
+
+	struct request *request;
+
+	struct cfq_queue *cfq_queue;
+
+	struct list_head hash;
+};
+
+static void cfq_put_queue(struct cfq_queue *cfqq);
+
+/*
+ * lots of deadline iosched dupes, can be abstracted later...
+ */
+static inline void __cfq_del_crq_hash(struct cfq_rq *crq)
+{
+	list_del_init(&crq->hash);
+}
+
+static inline void cfq_del_crq_hash(struct cfq_rq *crq)
+{
+	if (ON_MHASH(crq))
+		__cfq_del_crq_hash(crq);
+}
+
+static inline void cfq_add_crq_hash(struct cfq_data *cfqd, struct cfq_rq *crq)
+{
+	struct request *rq = crq->request;
+
+	BUG_ON(ON_MHASH(crq));
+
+	list_add(&crq->hash, &cfqd->crq_hash[CFQ_MHASH_FN(rq_hash_key(rq))]);
+}
+
+static struct request *cfq_find_crq_hash(struct cfq_data *cfqd, sector_t offset)
+{
+	struct list_head *hash_list = &cfqd->crq_hash[CFQ_MHASH_FN(offset)];
+	struct list_head *entry, *next = hash_list->next;
+
+	while ((entry = next) != hash_list) {
+		struct cfq_rq *crq = list_entry_hash(entry);
+		struct request *__rq = crq->request;
+
+		next = entry->next;
+		
+		BUG_ON(!ON_MHASH(crq));
+
+		if (!rq_mergeable(__rq)) {
+			__cfq_del_crq_hash(crq);
+			continue;
+		}
+
+		if (rq_hash_key(__rq) == offset)
+			return __rq;
+	}
+
+	return NULL;
+}
+
+/*
+ * rb tree support functions
+ */
+#define RB_EMPTY(root)	((root)->rb_node == NULL)
+#define RB_CLEAR(root)	((root)->rb_node = NULL)
+#define ON_RB(crq)	((crq)->cfq_queue != NULL)
+#define rb_entry_crq(node)	rb_entry((node), struct cfq_rq, rb_node)
+#define rq_rb_key(rq)		(rq)->sector
+
+static struct cfq_rq *
+__cfq_add_crq_rb(struct cfq_queue *cfqq, struct cfq_rq *crq)
+{
+	struct rb_node **p = &cfqq->sort_list.rb_node;
+	struct rb_node *parent = NULL;
+	struct cfq_rq *__crq;
+
+	while (*p) {
+		parent = *p;
+		__crq = rb_entry_crq(parent);
+
+		if (crq->rb_key < __crq->rb_key)
+			p = &(*p)->rb_left;
+		else if (crq->rb_key > __crq->rb_key)
+			p = &(*p)->rb_right;
+		else
+			return __crq;
+	}
+
+	rb_link_node(&crq->rb_node, parent, p);
+	return 0;
+}
+
+static int cfq_add_crq_rb(struct cfq_queue *cfqq, struct cfq_rq *crq)
+{
+	struct cfq_rq *__alias;
+
+	crq->rb_key = rq_rb_key(crq->request);
+
+	__alias = __cfq_add_crq_rb(cfqq, crq);
+	if (!__alias) {
+		rb_insert_color(&crq->rb_node, &cfqq->sort_list);
+		crq->cfq_queue = cfqq;
+		return 0;
+	}
+
+	list_add(&crq->request->queuelist, &__alias->request->queuelist);
+	return 1;
+}
+
+static inline void cfq_del_crq_rb(struct cfq_queue *cfqq, struct cfq_rq *crq)
+{
+	if (ON_RB(crq)) {
+		rb_erase(&crq->rb_node, &cfqq->sort_list);
+		crq->cfq_queue = NULL;
+	}
+}
+
+static void cfq_remove_request(request_queue_t *q, struct request *rq)
+{
+	struct cfq_rq *crq = RQ_DATA(rq);
+
+	if (crq) {
+		struct cfq_queue *cfqq = crq->cfq_queue;
+
+		cfq_del_crq_hash(crq);
+
+		if (cfqq) {
+			cfq_del_crq_rb(cfqq, crq);
+
+			if (RB_EMPTY(&cfqq->sort_list))
+				cfq_put_queue(cfqq);
+		}
+	}
+
+	if (&rq->queuelist == q->last_merge)
+		q->last_merge = NULL;
+
+	list_del_init(&rq->queuelist);
+}
+
+static int
+cfq_merge(request_queue_t *q, struct list_head **insert, struct bio *bio)
+{
+	struct cfq_data *cfqd = q->elevator.elevator_data;
+	struct request *__rq;
+	int ret;
+
+	ret = elv_try_last_merge(q, bio);
+	if (ret != ELEVATOR_NO_MERGE) {
+		__rq = list_entry_rq(q->last_merge);
+		goto out_insert;
+	}
+
+	__rq = cfq_find_crq_hash(cfqd, bio->bi_sector);
+	if (__rq) {
+		BUG_ON(__rq->sector + __rq->nr_sectors != bio->bi_sector);
+
+		if (elv_rq_merge_ok(__rq, bio)) {
+			ret = ELEVATOR_BACK_MERGE;
+			goto out;
+		}
+	}
+
+	return ELEVATOR_NO_MERGE;
+out:
+	q->last_merge = &__rq->queuelist;
+out_insert:
+	*insert = &__rq->queuelist;
+	return ret;
+}
+
+static void cfq_merged_request(request_queue_t *q, struct request *req)
+{
+	struct cfq_data *cfqd = q->elevator.elevator_data;
+	struct cfq_rq *crq = RQ_DATA(req);
+	int non_merge = 0;
+
+	cfq_del_crq_hash(crq);
+	cfq_add_crq_hash(cfqd, crq);
+
+	if (ON_RB(crq) && rq_rb_key(req) != crq->rb_key) {
+		struct cfq_queue *cfqq = crq->cfq_queue;
+
+		cfq_del_crq_rb(cfqq, crq);
+		non_merge = cfq_add_crq_rb(cfqq, crq);
+	}
+
+	if (!non_merge)
+		q->last_merge = &req->queuelist;
+}
+
+static void
+cfq_merged_requests(request_queue_t *q, struct request *req,
+		    struct request *next)
+{
+	cfq_merged_request(q, req);
+	cfq_remove_request(q, next);
+}
+
+static void cfq_dispatch_sort(struct list_head *head, struct cfq_rq *crq)
+{
+	struct list_head *entry = head;
+	struct request *__rq;
+
+	if (!list_empty(head)) {
+		__rq = list_entry_rq(head->next);
+
+		if (crq->request->sector < __rq->sector) {
+			entry = head->prev;
+			goto link;
+		}
+	}
+
+	while ((entry = entry->prev) != head) {
+		__rq = list_entry_rq(entry);
+
+		if (crq->request->sector <= __rq->sector)
+			break;
+	}
+
+link:
+	list_add_tail(&crq->request->queuelist, entry);
+}
+
+static inline void
+__cfq_dispatch_requests(struct cfq_data *cfqd, struct cfq_queue *cfqq)
+{
+	struct cfq_rq *crq;
+
+	crq = rb_entry_crq(rb_first(&cfqq->sort_list));
+
+	cfq_del_crq_rb(cfqq, crq);
+	cfq_dispatch_sort(cfqd->dispatch, crq);
+}
+
+static int cfq_dispatch_requests(struct cfq_data *cfqd)
+{
+	struct cfq_queue *cfqq;
+	struct list_head *entry, *tmp;
+	int ret, queued, good_queues;
+
+	if (list_empty(&cfqd->rr_list))
+		return 0;
+
+	queued = ret = 0;
+restart:
+	good_queues = 0;
+	list_for_each_safe(entry, tmp, &cfqd->rr_list) {
+		cfqq = list_entry_cfqq(cfqd->rr_list.next);
+
+		BUG_ON(RB_EMPTY(&cfqq->sort_list));
+
+		__cfq_dispatch_requests(cfqd, cfqq);
+
+		if (RB_EMPTY(&cfqq->sort_list))
+			cfq_put_queue(cfqq);
+		else
+			good_queues++;
+
+		queued++;
+		ret = 1;
+	}
+
+	if ((queued < cfq_quantum) && good_queues)
+		goto restart;
+
+	return ret;
+}
+
+static struct request *cfq_next_request(request_queue_t *q)
+{
+	struct cfq_data *cfqd = q->elevator.elevator_data;
+	struct request *rq;
+
+	if (!list_empty(cfqd->dispatch)) {
+		struct cfq_rq *crq;
+dispatch:
+		rq = list_entry_rq(cfqd->dispatch->next);
+
+		if (q->last_merge == &rq->queuelist)
+			q->last_merge = NULL;
+
+		crq = RQ_DATA(rq);
+		if (crq)
+			cfq_del_crq_hash(crq);
+
+		return rq;
+	}
+
+	if (cfq_dispatch_requests(cfqd))
+		goto dispatch;
+
+	return NULL;
+}
+
+static struct cfq_queue *
+cfq_find_cfq_hash(struct cfq_data *cfqd, int pid, const int hashval)
+{
+	struct list_head *hash_list = &cfqd->cfq_hash[hashval];
+	struct list_head *entry;
+
+	list_for_each(entry, hash_list) {
+		struct cfq_queue *__cfqq = list_entry_qhash(entry);
+
+		if (__cfqq->pid == pid)
+			return __cfqq;
+	}
+
+	return NULL;
+}
+
+static void cfq_put_queue(struct cfq_queue *cfqq)
+{
+	list_del(&cfqq->cfq_list);
+	list_del(&cfqq->cfq_hash);
+	mempool_free(cfqq, cfq_mpool);
+}
+
+static struct cfq_queue *cfq_get_queue(struct cfq_data *cfqd, int pid)
+{
+	const int hashval = hash_long(current->pid, CFQ_QHASH_SHIFT);
+	struct cfq_queue *cfqq = cfq_find_cfq_hash(cfqd, pid, hashval);
+
+	if (!cfqq) {
+		cfqq = mempool_alloc(cfq_mpool, GFP_NOIO);
+
+		INIT_LIST_HEAD(&cfqq->cfq_hash);
+		INIT_LIST_HEAD(&cfqq->cfq_list);
+		RB_CLEAR(&cfqq->sort_list);
+
+		cfqq->pid = pid;
+		list_add(&cfqq->cfq_hash, &cfqd->cfq_hash[hashval]);
+	}
+
+	return cfqq;
+}
+
+static void cfq_enqueue(struct cfq_data *cfqd, struct cfq_rq *crq)
+{
+	struct cfq_queue *cfqq;
+
+	cfqq = cfq_get_queue(cfqd, current->pid);
+
+	if (unlikely(cfq_add_crq_rb(cfqq, crq)))
+		return;
+
+	if (list_empty(&cfqq->cfq_list))
+		list_add(&cfqq->cfq_list, &cfqd->rr_list);
+}
+
+static void
+cfq_insert_request(request_queue_t *q, struct request *rq,
+		   struct list_head *insert_here)
+{
+	struct cfq_data *cfqd = q->elevator.elevator_data;
+	struct cfq_rq *crq = RQ_DATA(rq);
+
+	if (unlikely(!blk_fs_request(rq))) {
+		if (!insert_here)
+			insert_here = cfqd->dispatch->prev;
+
+		list_add(&rq->queuelist, insert_here);
+		return;
+	}
+
+	if (rq_mergeable(rq)) {
+		cfq_add_crq_hash(cfqd, crq);
+
+		if (!q->last_merge)
+			q->last_merge = &rq->queuelist;
+	}
+
+	cfq_enqueue(cfqd, crq);
+}
+
+static int cfq_queue_empty(request_queue_t *q)
+{
+	struct cfq_data *cfqd = q->elevator.elevator_data;
+
+	if (list_empty(cfqd->dispatch) && list_empty(&cfqd->rr_list))
+		return 1;
+
+	return 0;
+}
+
+static struct request *
+cfq_former_request(request_queue_t *q, struct request *rq)
+{
+	struct cfq_rq *crq = RQ_DATA(rq);
+	struct rb_node *rbprev = rb_prev(&crq->rb_node);
+
+	if (rbprev)
+		return rb_entry_crq(rbprev)->request;
+
+	return NULL;
+}
+
+static struct request *
+cfq_latter_request(request_queue_t *q, struct request *rq)
+{
+	struct cfq_rq *crq = RQ_DATA(rq);
+	struct rb_node *rbnext = rb_next(&crq->rb_node);
+
+	if (rbnext)
+		return rb_entry_crq(rbnext)->request;
+
+	return NULL;
+}
+
+static void cfq_exit(request_queue_t *q, elevator_t *e)
+{
+	struct cfq_data *cfqd = e->elevator_data;
+	struct cfq_rq *crq;
+	struct request *rq;
+	int i;
+
+	for (i = READ; i <= WRITE; i++) {
+		struct request_list *rl = &q->rq[i];
+		struct list_head *entry;
+
+		list_for_each(entry, &rl->free) {
+			rq = list_entry_rq(entry);
+
+			crq = RQ_DATA(rq);
+			if (!crq)
+				continue;
+
+			rq->elevator_private = NULL;
+			kmem_cache_free(crq_pool, crq);
+		}
+	}
+
+	e->elevator_data = NULL;
+	kfree(cfqd->crq_hash);
+	kfree(cfqd->cfq_hash);
+	kfree(cfqd);
+}
+
+static void *slab_pool_alloc(int gfp_mask, void *data)
+{
+	return kmem_cache_alloc(data, gfp_mask);
+}
+
+static void slab_pool_free(void *ptr, void *data)
+{
+	kmem_cache_free(data, ptr);
+}
+
+static int cfq_init(request_queue_t *q, elevator_t *e)
+{
+	struct cfq_data *cfqd;
+	struct request *rq;
+	struct cfq_rq *crq;
+	int i, ret = 0;
+
+	cfqd = kmalloc(sizeof(*cfqd), GFP_KERNEL);
+	if (!cfqd)
+		return -ENOMEM;
+
+	memset(cfqd, 0, sizeof(*cfqd));
+	INIT_LIST_HEAD(&cfqd->rr_list);
+
+	cfqd->crq_hash = kmalloc(sizeof(struct list_head) * CFQ_MHASH_ENTRIES, GFP_KERNEL);
+	if (!cfqd->crq_hash)
+		goto out_crqhash;
+
+	cfqd->cfq_hash = kmalloc(sizeof(struct list_head) * CFQ_QHASH_ENTRIES, GFP_KERNEL);
+	if (!cfqd->cfq_hash)
+		goto out_cfqhash;
+
+	for (i = 0; i < CFQ_MHASH_ENTRIES; i++)
+		INIT_LIST_HEAD(&cfqd->crq_hash[i]);
+	for (i = 0; i < CFQ_QHASH_ENTRIES; i++)
+		INIT_LIST_HEAD(&cfqd->cfq_hash[i]);
+
+	for (i = READ; i <= WRITE; i++) {
+		struct request_list *rl = &q->rq[i];
+		struct list_head *entry;
+
+		list_for_each(entry, &rl->free) {
+			rq = list_entry_rq(entry);
+
+			crq = kmem_cache_alloc(crq_pool, GFP_KERNEL);
+			if (!crq) {
+				ret = -ENOMEM;
+				break;
+			}
+
+			memset(crq, 0, sizeof(*crq));
+			INIT_LIST_HEAD(&crq->hash);
+			crq->request = rq;
+			rq->elevator_private = crq;
+		}
+	}
+
+	cfqd->dispatch = &q->queue_head;
+	e->elevator_data = cfqd;
+	return ret;
+out_cfqhash:
+	kfree(cfqd->crq_hash);
+out_crqhash:
+	kfree(cfqd);
+	return -ENOMEM;
+}
+
+static int __init cfq_slab_setup(void)
+{
+	crq_pool = kmem_cache_create("crq_pool", sizeof(struct cfq_rq), 0, 0,
+					NULL, NULL);
+
+	if (!crq_pool)
+		panic("cfq_iosched: can't init crq pool\n");
+
+	cfq_pool = kmem_cache_create("cfq_pool", sizeof(struct cfq_queue), 0, 0,
+					NULL, NULL);
+
+	if (!cfq_pool)
+		panic("cfq_iosched: can't init cfq pool\n");
+
+	cfq_mpool = mempool_create(64, slab_pool_alloc, slab_pool_free, cfq_pool);
+
+	if (!cfq_mpool)
+		panic("cfq_iosched: can't init cfq mpool\n");
+
+	return 0;
+}
+
+subsys_initcall(cfq_slab_setup);
+
+elevator_t iosched_cfq = {
+	.elevator_merge_fn = 		cfq_merge,
+	.elevator_merged_fn =		cfq_merged_request,
+	.elevator_merge_req_fn =	cfq_merged_requests,
+	.elevator_next_req_fn =		cfq_next_request,
+	.elevator_add_req_fn =		cfq_insert_request,
+	.elevator_remove_req_fn =	cfq_remove_request,
+	.elevator_queue_empty_fn =	cfq_queue_empty,
+	.elevator_former_req_fn =	cfq_former_request,
+	.elevator_latter_req_fn =	cfq_latter_request,
+	.elevator_init_fn =		cfq_init,
+	.elevator_exit_fn =		cfq_exit,
+};
+
+EXPORT_SYMBOL(iosched_cfq);

-- 
Jens Axboe

