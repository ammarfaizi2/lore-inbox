Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261427AbTBJOkv>; Mon, 10 Feb 2003 09:40:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261518AbTBJOkv>; Mon, 10 Feb 2003 09:40:51 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:23533 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S261427AbTBJOka>;
	Mon, 10 Feb 2003 09:40:30 -0500
Date: Mon, 10 Feb 2003 15:50:01 +0100
From: Jens Axboe <axboe@suse.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrea Arcangeli <andrea@suse.de>
Subject: [PATCH] SFQ disk scheduler
Message-ID: <20030210145001.GT12828@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here's a simple stochastic fairness queueing disk scheduler, for current
2.5.59-BK. It has known limitations right now, mainly because I didn't
bother making it complete. But it should suffice for some rudimentary
testing, at least.

I'm not going to go into great detail about how it works, see Andrea's
initial post of the paper referenced. This version may not be completely
true to the SFQ concept, but should be close enough I think. It divides
traffic into a fixed number of buckets (64 per default), and perturbs
the hash every 5 seconds (hash shamelessly borrowed from networking atm,
see comment).

To avoid too many disk seeks, when it's time to dispatch requests to the
driver, we round robin all non-empty buckets and grab a single request
from each. These requests are sorted into the dispatch queue.

For performance reasons, io scheduler request merging is still a
per-queue function (and not per-bucket).

In closing, let me stress that this version has not really been tested
all that much. It passes simple SCSI and IDE testing, should work on any
hardware basically.

===== drivers/block/Makefile 1.14 vs edited =====
--- 1.14/drivers/block/Makefile	Mon Feb  3 23:19:36 2003
+++ edited/drivers/block/Makefile	Mon Feb 10 11:16:07 2003
@@ -8,7 +8,8 @@
 # In the future, some of these should be built conditionally.
 #
 
-obj-y	:= elevator.o ll_rw_blk.o ioctl.o genhd.o scsi_ioctl.o deadline-iosched.o
+obj-y	:= elevator.o ll_rw_blk.o ioctl.o genhd.o scsi_ioctl.o \
+	    deadline-iosched.o sfq-iosched.o
 
 obj-$(CONFIG_MAC_FLOPPY)	+= swim3.o
 obj-$(CONFIG_BLK_DEV_FD)	+= floppy.o
===== drivers/block/ll_rw_blk.c 1.149 vs edited =====
--- 1.149/drivers/block/ll_rw_blk.c	Thu Feb  6 05:04:17 2003
+++ edited/drivers/block/ll_rw_blk.c	Mon Feb 10 15:34:36 2003
@@ -1279,7 +1279,8 @@
 	if (blk_init_free_list(q))
 		return -ENOMEM;
 
-	if ((ret = elevator_init(q, &iosched_deadline))) {
+	//if ((ret = elevator_init(q, &iosched_deadline))) {
+	if ((ret = elevator_init(q, &iosched_sfq))) {
 		blk_cleanup_queue(q);
 		return ret;
 	}
===== include/linux/elevator.h 1.18 vs edited =====
--- 1.18/include/linux/elevator.h	Sun Jan 12 15:10:40 2003
+++ edited/include/linux/elevator.h	Mon Feb 10 11:24:22 2003
@@ -73,6 +73,8 @@
  */
 extern elevator_t iosched_deadline;
 
+extern elevator_t iosched_sfq;
+
 extern int elevator_init(request_queue_t *, elevator_t *);
 extern void elevator_exit(request_queue_t *);
 extern inline int bio_rq_in_between(struct bio *, struct request *, struct list_head *);
--- /dev/null	2003-01-19 21:08:59.000000000 +0100
+++ linux-2.5-sfq/drivers/block/sfq-iosched.c	2003-02-10 15:47:37.000000000 +0100
@@ -0,0 +1,525 @@
+/*
+ *  linux/drivers/block/sfq-iosched.c
+ *
+ *  Stochastic fairness queueing disk scheduler, or at least something
+ *  resembling it. Based on ideas from a previously unfinished io
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
+
+static int perturb_duration = 5 * HZ;
+
+#define SFQ_QUEUE_SHIFT		6
+#define SFQ_NR_QUEUES		(1 << SFQ_QUEUE_SHIFT)
+
+#define SFQ_HASH_SHIFT		8
+#define SFQ_HASH_BLOCK(sec)	((sec) >> 3)
+#define SFQ_HASH_ENTRIES	(1 << SFQ_HASH_SHIFT)
+#define SFQ_HASH_FN(sec)	(hash_long(SFQ_HASH_BLOCK((sec)),SFQ_HASH_SHIFT))
+#define ON_HASH(srq)		!list_empty(&(srq)->hash)
+#define rq_hash_key(rq)		((rq)->sector + (rq)->nr_sectors)
+#define list_entry_hash(ptr)	list_entry((ptr), struct sfq_rq, hash)
+
+#define RQ_DATA(rq)		((struct sfq_rq *) (rq)->elevator_private)
+
+static kmem_cache_t *srq_pool;
+
+struct sfq_queue {
+	struct list_head sfq_list;
+	struct rb_root sort_list;
+};
+
+struct sfq_data {
+	struct list_head rr_list;
+	struct list_head *dispatch;
+	struct sfq_queue sfq_queues[SFQ_NR_QUEUES];
+
+	struct list_head *hash;
+
+	int perturbation;
+	unsigned long perturb_period;
+	unsigned long random_seed;
+};
+
+struct sfq_rq {
+	struct rb_node rb_node;
+	sector_t rb_key;
+
+	struct request *request;
+
+	struct sfq_queue *sfq_queue;
+
+	struct list_head hash;
+};
+
+/*
+ * lots of deadline iosched dupes, can be abstracted later...
+ */
+static inline void __sfq_del_srq_hash(struct sfq_rq *srq)
+{
+	list_del_init(&srq->hash);
+}
+
+static inline void sfq_del_srq_hash(struct sfq_rq *srq)
+{
+	if (ON_HASH(srq))
+		__sfq_del_srq_hash(srq);
+}
+
+static inline void sfq_add_srq_hash(struct sfq_data *sfqd, struct sfq_rq *srq)
+{
+	struct request *rq = srq->request;
+
+	BUG_ON(ON_HASH(srq));
+
+	list_add(&srq->hash, &sfqd->hash[SFQ_HASH_FN(rq_hash_key(rq))]);
+}
+
+static struct request *sfq_find_srq_hash(struct sfq_data *sfqd, sector_t offset)
+{
+	struct list_head *hash_list = &sfqd->hash[SFQ_HASH_FN(offset)];
+	struct list_head *entry, *next = hash_list->next;
+
+	while ((entry = next) != hash_list) {
+		struct sfq_rq *srq = list_entry_hash(entry);
+		struct request *__rq = srq->request;
+
+		next = entry->next;
+		
+		BUG_ON(!ON_HASH(srq));
+
+		if (!rq_mergeable(__rq)) {
+			__sfq_del_srq_hash(srq);
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
+#define RB_NONE		(2)
+#define RB_EMPTY(root)	((root)->rb_node == NULL)
+#define ON_RB(srq)	((srq)->sfq_queue != NULL)
+#define RB_CLEAR(node)	((node)->rb_color = RB_NONE)
+#define rb_entry_srq(node)	rb_entry((node), struct sfq_rq, rb_node)
+#define rq_rb_key(rq)		(rq)->sector
+
+static struct sfq_rq *
+__sfq_add_srq_rb(struct sfq_queue *sfqq, struct sfq_rq *srq)
+{
+	struct rb_node **p = &sfqq->sort_list.rb_node;
+	struct rb_node *parent = NULL;
+	struct sfq_rq *__srq;
+
+	while (*p) {
+		parent = *p;
+		__srq = rb_entry_srq(parent);
+
+		if (srq->rb_key < __srq->rb_key)
+			p = &(*p)->rb_left;
+		else if (srq->rb_key > __srq->rb_key)
+			p = &(*p)->rb_right;
+		else
+			return __srq;
+	}
+
+	rb_link_node(&srq->rb_node, parent, p);
+	return 0;
+}
+
+static int sfq_add_srq_rb(struct sfq_queue *sfqq, struct sfq_rq *srq)
+{
+	struct sfq_rq *__alias;
+
+	srq->rb_key = rq_rb_key(srq->request);
+
+	__alias = __sfq_add_srq_rb(sfqq, srq);
+	if (!__alias) {
+		rb_insert_color(&srq->rb_node, &sfqq->sort_list);
+		srq->sfq_queue = sfqq;
+		return 0;
+	}
+
+	list_add(&srq->request->queuelist, &__alias->request->queuelist);
+	return 1;
+}
+
+static inline void sfq_del_srq_rb(struct sfq_queue *sfqq, struct sfq_rq *srq)
+{
+	if (ON_RB(srq)) {
+		rb_erase(&srq->rb_node, &sfqq->sort_list);
+		RB_CLEAR(&srq->rb_node);
+		srq->sfq_queue = NULL;
+	}
+}
+
+static void sfq_remove_request(request_queue_t *q, struct request *rq)
+{
+	struct sfq_rq *srq = RQ_DATA(rq);
+
+	if (srq) {
+		sfq_del_srq_hash(srq);
+		sfq_del_srq_rb(srq->sfq_queue, srq);
+	}
+
+	if (&rq->queuelist == q->last_merge)
+		q->last_merge = NULL;
+
+	list_del_init(&rq->queuelist);
+}
+
+static int
+sfq_merge(request_queue_t *q, struct list_head **insert, struct bio *bio)
+{
+	struct sfq_data *sfqd = q->elevator.elevator_data;
+	struct request *__rq;
+	int ret;
+
+	ret = elv_try_last_merge(q, bio);
+	if (ret != ELEVATOR_NO_MERGE) {
+		__rq = list_entry_rq(q->last_merge);
+		goto out_insert;
+	}
+
+	__rq = sfq_find_srq_hash(sfqd, bio->bi_sector);
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
+static void sfq_merged_request(request_queue_t *q, struct request *req)
+{
+	struct sfq_data *sfqd = q->elevator.elevator_data;
+	struct sfq_rq *srq = RQ_DATA(req);
+
+	sfq_del_srq_hash(srq);
+	sfq_add_srq_hash(sfqd, srq);
+
+	if (rq_rb_key(req) != srq->rb_key) {
+		struct sfq_queue *sfqq = srq->sfq_queue;
+
+		sfq_del_srq_rb(sfqq, srq);
+		sfq_add_srq_rb(sfqq, srq);
+	}
+
+	q->last_merge = &req->queuelist;
+}
+
+static void
+sfq_merged_requests(request_queue_t *q, struct request *req,
+		    struct request *next)
+{
+	sfq_merged_request(q, req);
+	sfq_remove_request(q, next);
+}
+
+static void sfq_dispatch_sort(struct list_head *head, struct sfq_rq *srq)
+{
+	struct list_head *entry = head;
+	struct request *__rq;
+
+	while ((entry = entry->prev) != head) {
+		__rq = list_entry_rq(entry);
+
+		if (srq->request->sector <= __rq->sector)
+			break;
+	}
+
+	list_add_tail(&srq->request->queuelist, entry);
+}
+
+#define list_entry_sfqq(ptr)	list_entry((ptr), struct sfq_queue, sfq_list)
+
+static int sfq_dispatch_requests(struct sfq_data *sfqd)
+{
+	struct sfq_queue *sfqq;
+	struct list_head *entry, *tmp;
+	struct sfq_rq *srq;
+	int ret = 0;
+
+	if (list_empty(&sfqd->rr_list))
+		return 0;
+
+	list_for_each_safe(entry, tmp, &sfqd->rr_list) {
+		sfqq = list_entry_sfqq(sfqd->rr_list.next);
+
+		if (RB_EMPTY(&sfqq->sort_list)) {
+			list_del_init(&sfqq->sfq_list);
+			continue;
+		}
+
+		srq = rb_entry_srq(rb_first(&sfqq->sort_list));
+
+		sfq_remove_request(srq->request->q, srq->request);
+
+		if (RB_EMPTY(&sfqq->sort_list))
+			list_del_init(&sfqq->sfq_list);
+
+		sfq_dispatch_sort(sfqd->dispatch, srq);
+		ret = 1;
+	}
+
+	return ret;
+}
+
+static struct request *sfq_next_request(request_queue_t *q)
+{
+	struct sfq_data *sfqd = q->elevator.elevator_data;
+	struct request *rq;
+
+	if (!list_empty(sfqd->dispatch)) {
+dispatch:
+		rq = list_entry_rq(sfqd->dispatch->next);
+		return rq;
+	}
+
+	if (sfq_dispatch_requests(sfqd))
+		goto dispatch;
+
+	return NULL;
+}
+
+/*
+ * hashing stuff below stolen from networking, no idea yet how well it
+ * works for this purpose...
+ */
+static inline unsigned long sfq_random(struct sfq_data *sfqd)
+{
+	sfqd->random_seed = sfqd->random_seed * 69069L + 1;
+
+	return sfqd->random_seed ^ jiffies;
+}
+
+static inline unsigned long
+sfq_hash(struct sfq_data *sfqd, unsigned short pid, unsigned long mm)
+{
+	int pert = sfqd->perturbation;
+
+	pid ^= (mm << pert) ^ (mm >> (0x1f - pert));
+	pid ^= pid >> 10;
+
+	return pid & (SFQ_NR_QUEUES - 1);
+}
+
+static void sfq_enqueue(struct sfq_data *sfqd, struct sfq_rq *srq)
+{
+	struct sfq_queue *sfqq;
+
+	if (time_after(jiffies, sfqd->perturb_period)) {
+		sfqd->perturbation = sfq_random(sfqd) & 0x1f;
+		sfqd->perturb_period = jiffies + perturb_duration;
+	}
+
+	sfqq = &sfqd->sfq_queues[sfq_hash(sfqd, current->pid, (unsigned long) current->mm)];
+
+	sfq_add_srq_rb(sfqq, srq);
+
+	if (list_empty(&sfqq->sfq_list))
+		list_add(&sfqq->sfq_list, &sfqd->rr_list);
+}
+
+static void
+sfq_insert_request(request_queue_t *q, struct request *rq,
+		   struct list_head *insert_here)
+{
+	struct sfq_data *sfqd = q->elevator.elevator_data;
+	struct sfq_rq *srq = RQ_DATA(rq);
+
+	if (unlikely(!blk_fs_request(rq))) {
+		if (!insert_here)
+			insert_here = sfqd->dispatch->prev;
+
+		list_add(&rq->queuelist, insert_here);
+		return;
+	}
+
+	if (rq_mergeable(rq)) {
+		sfq_add_srq_hash(sfqd, srq);
+
+		if (!q->last_merge)
+			q->last_merge = &rq->queuelist;
+	}
+
+	sfq_enqueue(sfqd, srq);
+}
+
+static int sfq_queue_empty(request_queue_t *q)
+{
+	struct sfq_data *sfqd = q->elevator.elevator_data;
+
+	if (list_empty(sfqd->dispatch) && list_empty(&sfqd->rr_list))
+		return 1;
+
+	return 0;
+}
+
+static struct request *
+sfq_former_request(request_queue_t *q, struct request *rq)
+{
+	struct sfq_rq *srq = RQ_DATA(rq);
+	struct rb_node *rbprev = rb_prev(&srq->rb_node);
+
+	if (rbprev)
+		return rb_entry_srq(rbprev)->request;
+
+	return NULL;
+}
+
+static struct request *
+sfq_latter_request(request_queue_t *q, struct request *rq)
+{
+	struct sfq_rq *srq = RQ_DATA(rq);
+	struct rb_node *rbnext = rb_next(&srq->rb_node);
+
+	if (rbnext)
+		return rb_entry_srq(rbnext)->request;
+
+	return NULL;
+}
+
+
+static void sfq_exit(request_queue_t *q, elevator_t *e)
+{
+	struct sfq_data *sfqd = e->elevator_data;
+	struct sfq_rq *srq;
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
+			if ((srq = RQ_DATA(rq)) == NULL)
+				continue;
+
+			rq->elevator_private = NULL;
+			kmem_cache_free(srq_pool, srq);
+		}
+	}
+
+	e->elevator_data = NULL;
+	kfree(sfqd->hash);
+	kfree(sfqd);
+}
+
+static int sfq_init(request_queue_t *q, elevator_t *e)
+{
+	struct sfq_data *sfqd;
+	struct sfq_queue *sfqq;
+	struct request *rq;
+	struct sfq_rq *srq;
+	int i, ret = 0;
+
+	sfqd = kmalloc(sizeof(*sfqd), GFP_KERNEL);
+	if (!sfqd)
+		return -ENOMEM;
+
+	memset(sfqd, 0, sizeof(*sfqd));
+	INIT_LIST_HEAD(&sfqd->rr_list);
+
+	sfqd->hash = kmalloc(sizeof(struct list_head) * SFQ_HASH_ENTRIES, GFP_KERNEL);
+	if (!sfqd->hash) {
+		kfree(sfqd);
+		return -ENOMEM;
+	}
+
+	for (i = 0; i < SFQ_HASH_ENTRIES; i++)
+		INIT_LIST_HEAD(&sfqd->hash[i]);
+
+	for (i = 0; i < SFQ_NR_QUEUES; i++) {
+		sfqq = &sfqd->sfq_queues[i];
+
+		INIT_LIST_HEAD(&sfqq->sfq_list);
+		sfqq->sort_list = RB_ROOT;
+	}
+
+	for (i = READ; i <= WRITE; i++) {
+		struct request_list *rl = &q->rq[i];
+		struct list_head *entry;
+
+		list_for_each(entry, &rl->free) {
+			rq = list_entry_rq(entry);
+
+			srq = kmem_cache_alloc(srq_pool, GFP_KERNEL);
+			if (!srq) {
+				ret = -ENOMEM;
+				break;
+			}
+
+			memset(srq, 0, sizeof(*srq));
+			INIT_LIST_HEAD(&srq->hash);
+			RB_CLEAR(&srq->rb_node);
+			srq->request = rq;
+			rq->elevator_private = srq;
+		}
+	}
+
+	sfqd->perturb_period = jiffies + perturb_duration;
+	sfqd->dispatch = &q->queue_head;
+	e->elevator_data = sfqd;
+	return ret;
+}
+
+static int __init sfq_slab_setup(void)
+{
+	srq_pool = kmem_cache_create("srq_pool", sizeof(struct sfq_rq), 0, 0,
+					NULL, NULL);
+
+	if (!srq_pool)
+		panic("sfq_iosched: can't init slab pool\n");
+
+	return 0;
+}
+
+subsys_initcall(sfq_slab_setup);
+
+elevator_t iosched_sfq = {
+	.elevator_merge_fn = 		sfq_merge,
+	.elevator_merged_fn =		sfq_merged_request,
+	.elevator_merge_req_fn =	sfq_merged_requests,
+	.elevator_next_req_fn =		sfq_next_request,
+	.elevator_add_req_fn =		sfq_insert_request,
+	.elevator_remove_req_fn =	sfq_remove_request,
+	.elevator_queue_empty_fn =	sfq_queue_empty,
+	.elevator_former_req_fn =	sfq_former_request,
+	.elevator_latter_req_fn =	sfq_latter_request,
+	.elevator_init_fn =		sfq_init,
+	.elevator_exit_fn =		sfq_exit,
+};
+
+EXPORT_SYMBOL(iosched_sfq);

-- 
Jens Axboe

