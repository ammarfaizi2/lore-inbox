Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268385AbTBNOJq>; Fri, 14 Feb 2003 09:09:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268390AbTBNOJq>; Fri, 14 Feb 2003 09:09:46 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:51888 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S268385AbTBNOJc>;
	Fri, 14 Feb 2003 09:09:32 -0500
Date: Fri, 14 Feb 2003 15:19:19 +0100
From: Jens Axboe <axboe@suse.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] CFQ scheduler, #2
Message-ID: <20030214141919.GK879@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The version posted the other day did fair queueing of requests between
processes, but it did not help to provide fair request allocation. This
version does that too, results are rather remarkable. In addition, the
following changes were made:

- Fix lost request problem with rbtree aliasing. The default io
  scheduler in 2.5.60 has the same bug, a fix has been sent separetely
  to Linus that addresses this.

- Add front merging.

- Missing queue_lock grab in get_request_wait() before checking request
  list count. Again, a generic kernel bug. A patch will be sent to Linus
  to address that as well.

Obligatory contest results.

no_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.60              2   31      177.4   0       0.0     1.00
2.5.60-cfq-fr2      1   31      177.4   0       0.0     1.00
2.5.60-mm1          2   32      171.9   0       0.0     1.00
cacherun:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.60              2   29      182.8   0       0.0     0.94
2.5.60-cfq-fr2      1   29      182.8   0       0.0     0.94
2.5.60-mm1          2   29      186.2   0       0.0     0.91
process_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.60              2   38      142.1   12      47.4    1.23
2.5.60-cfq-fr2      1   43      123.3   20      67.4    1.39
2.5.60-mm1          2   38      142.1   13      50.0    1.19
ctar_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.60              2   38      147.4   0       0.0     1.23
2.5.60-cfq-fr2      1   37      151.4   0       0.0     1.19
2.5.60-mm1          2   36      155.6   0       0.0     1.12
xtar_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.60              2   40      140.0   0       2.5     1.29
2.5.60-cfq-fr2      1   37      148.6   0       2.6     1.19
2.5.60-mm1          2   39      143.6   0       2.6     1.22
io_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.60              2   93      61.3    2       14.0    3.00
2.5.60-cfq-fr2      1   73      76.7    1       9.8     2.35
2.5.60-mm1          2   82      69.5    1       9.8     2.56
read_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.60              2   40      140.0   0       5.0     1.29
2.5.60-cfq-fr2      1   40      140.0   0       5.0     1.29
2.5.60-mm1          2   38      147.4   0       2.6     1.19
list_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.60              2   35      157.1   0       8.6     1.13
2.5.60-cfq-fr2      1   35      160.0   0       11.4    1.13
2.5.60-mm1          2   34      164.7   0       8.8     1.06
mem_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.60              2   50      116.0   75      10.0    1.61
2.5.60-cfq-fr2      1   57      100.0   81      8.8     1.84
2.5.60-mm1          2   52      113.5   77      9.4     1.62
dbench_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.60              2   36      155.6   12693   27.8    1.16
2.5.60-mm1          2   35      160.0   12486   28.6    1.09


Patch is against 2.5.60-BK.

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
===== drivers/block/elevator.c 1.37 vs edited =====
--- 1.37/drivers/block/elevator.c	Tue Jan 14 23:59:43 2003
+++ edited/drivers/block/elevator.c	Fri Feb 14 14:08:15 2003
@@ -408,6 +408,16 @@
 	return NULL;
 }
 
+int elv_may_queue(request_queue_t *q, int rw)
+{
+	elevator_t *e = &q->elevator;
+
+	if (e->elevator_may_queue_fn)
+		return e->elevator_may_queue_fn(q, rw);
+
+	return 1;
+}
+
 int elv_register_queue(struct gendisk *disk)
 {
 	request_queue_t *q = disk->queue;
===== drivers/block/ll_rw_blk.c 1.151 vs edited =====
--- 1.151/drivers/block/ll_rw_blk.c	Thu Feb 13 05:02:43 2003
+++ edited/drivers/block/ll_rw_blk.c	Fri Feb 14 14:56:45 2003
@@ -45,7 +45,7 @@
  * Number of requests per queue.  This many for reads and for writes (twice
  * this number, total).
  */
-static int queue_nr_requests;
+int queue_nr_requests;
 
 /*
  * How many free requests must be available before we wake a process which
@@ -1283,7 +1283,7 @@
 	if (blk_init_free_list(q))
 		return -ENOMEM;
 
-	if ((ret = elevator_init(q, &iosched_deadline))) {
+	if ((ret = elevator_init(q, &iosched_cfq))) {
 		blk_cleanup_queue(q);
 		return ret;
 	}
@@ -1320,7 +1320,7 @@
 	struct request *rq = NULL;
 	struct request_list *rl = q->rq + rw;
 
-	if (!list_empty(&rl->free)) {
+	if (!list_empty(&rl->free) && elv_may_queue(q, rw)) {
 		rq = blkdev_free_rq(&rl->free);
 		list_del_init(&rq->queuelist);
 		rq->ref_count = 1;
@@ -1358,11 +1358,19 @@
 
 	generic_unplug_device(q);
 	do {
+		int block = 0;
+
 		prepare_to_wait_exclusive(&rl->wait, &wait,
 					TASK_UNINTERRUPTIBLE);
-		if (!rl->count)
+		spin_lock_irq(q->queue_lock);
+		if (!rl->count || !elv_may_queue(q, rw))
+			block = 1;
+		spin_unlock_irq(q->queue_lock);
+
+		if (block)
 			io_schedule();
 		finish_wait(&rl->wait, &wait);
+
 		spin_lock_irq(q->queue_lock);
 		rq = get_request(q, rw);
 		spin_unlock_irq(q->queue_lock);
===== include/linux/elevator.h 1.18 vs edited =====
--- 1.18/include/linux/elevator.h	Sun Jan 12 15:10:40 2003
+++ edited/include/linux/elevator.h	Fri Feb 14 14:07:45 2003
@@ -15,6 +15,7 @@
 typedef void (elevator_remove_req_fn) (request_queue_t *, struct request *);
 typedef struct request *(elevator_request_list_fn) (request_queue_t *, struct request *);
 typedef struct list_head *(elevator_get_sort_head_fn) (request_queue_t *, struct request *);
+typedef int (elevator_may_queue_fn) (request_queue_t *, int);
 
 typedef int (elevator_init_fn) (request_queue_t *, elevator_t *);
 typedef void (elevator_exit_fn) (request_queue_t *, elevator_t *);
@@ -34,6 +35,8 @@
 	elevator_request_list_fn *elevator_former_req_fn;
 	elevator_request_list_fn *elevator_latter_req_fn;
 
+	elevator_may_queue_fn *elevator_may_queue_fn;
+
 	elevator_init_fn *elevator_init_fn;
 	elevator_exit_fn *elevator_exit_fn;
 
@@ -58,6 +61,7 @@
 extern struct request *elv_latter_request(request_queue_t *, struct request *);
 extern int elv_register_queue(struct gendisk *);
 extern void elv_unregister_queue(struct gendisk *);
+extern int elv_may_queue(request_queue_t *, int);
 
 #define __elv_add_request_pos(q, rq, pos)	\
 	(q)->elevator.elevator_add_req_fn((q), (rq), (pos))
@@ -72,6 +76,8 @@
  * starvation
  */
 extern elevator_t iosched_deadline;
+
+extern elevator_t iosched_cfq;
 
 extern int elevator_init(request_queue_t *, elevator_t *);
 extern void elevator_exit(request_queue_t *);
--- /dev/null	2003-01-19 21:08:59.000000000 +0100
+++ linux-2.5-sfq/drivers/block/cfq-iosched.c	2003-02-14 15:06:05.000000000 +0100
@@ -0,0 +1,699 @@
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
+static int cfq_quantum = 4;
+static int cfq_queued = 8;
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
+	int queued[2];
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
+	int busy_queues;
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
+static void cfq_put_queue(struct cfq_data *cfqd, struct cfq_queue *cfqq);
+static struct cfq_queue *cfq_find_cfq_hash(struct cfq_data *cfqd, int pid);
+static void cfq_dispatch_sort(struct list_head *head, struct cfq_rq *crq);
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
+static struct request *cfq_find_rq_hash(struct cfq_data *cfqd, sector_t offset)
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
+static inline void cfq_del_crq_rb(struct cfq_queue *cfqq, struct cfq_rq *crq)
+{
+	if (ON_RB(crq)) {
+		rb_erase(&crq->rb_node, &cfqq->sort_list);
+		crq->cfq_queue = NULL;
+	}
+}
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
+static void
+cfq_add_crq_rb(struct cfq_data *cfqd, struct cfq_queue *cfqq,struct cfq_rq *crq)
+{
+	struct request *rq = crq->request;
+	struct cfq_rq *__alias;
+
+	crq->rb_key = rq_rb_key(rq);
+
+retry:
+	__alias = __cfq_add_crq_rb(cfqq, crq);
+	if (!__alias) {
+		rb_insert_color(&crq->rb_node, &cfqq->sort_list);
+		crq->cfq_queue = cfqq;
+		cfqq->queued[rq_data_dir(rq)]++;
+		return;
+	}
+
+	cfq_del_crq_rb(cfqq, __alias);
+	cfq_dispatch_sort(cfqd->dispatch, __alias);
+	goto retry;
+}
+
+static struct request *
+cfq_find_rq_rb(struct cfq_data *cfqd, sector_t sector)
+{
+	struct cfq_queue *cfqq = cfq_find_cfq_hash(cfqd, current->pid);
+	struct rb_node *n;
+
+	if (!cfqq)
+		goto out;
+
+	n = cfqq->sort_list.rb_node;
+	while (n) {
+		struct cfq_rq *crq = rb_entry_crq(n);
+
+		if (sector < crq->rb_key)
+			n = n->rb_left;
+		else if (sector > crq->rb_key)
+			n = n->rb_right;
+		else
+			return crq->request;
+	}
+
+out:
+	return NULL;
+}
+
+static void cfq_remove_request(request_queue_t *q, struct request *rq)
+{
+	struct cfq_data *cfqd = q->elevator.elevator_data;
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
+				cfq_put_queue(cfqd, cfqq);
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
+	__rq = cfq_find_rq_hash(cfqd, bio->bi_sector);
+	if (__rq) {
+		BUG_ON(__rq->sector + __rq->nr_sectors != bio->bi_sector);
+
+		if (elv_rq_merge_ok(__rq, bio)) {
+			ret = ELEVATOR_BACK_MERGE;
+			goto out;
+		}
+	}
+
+	__rq = cfq_find_rq_rb(cfqd, bio->bi_sector + bio_sectors(bio));
+	if (__rq) {
+		if (elv_rq_merge_ok(__rq, bio)) {
+			ret = ELEVATOR_FRONT_MERGE;
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
+
+	cfq_del_crq_hash(crq);
+	cfq_add_crq_hash(cfqd, crq);
+
+	if (ON_RB(crq) && rq_rb_key(req) != crq->rb_key) {
+		struct cfq_queue *cfqq = crq->cfq_queue;
+
+		cfq_del_crq_rb(cfqq, crq);
+		cfq_add_crq_rb(cfqd, cfqq, crq);
+	}
+
+	q->last_merge = &req->queuelist;
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
+			cfq_put_queue(cfqd, cfqq);
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
+static inline struct cfq_queue *
+__cfq_find_cfq_hash(struct cfq_data *cfqd, int pid, const int hashval)
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
+static struct cfq_queue *cfq_find_cfq_hash(struct cfq_data *cfqd, int pid)
+{
+	const int hashval = hash_long(current->pid, CFQ_QHASH_SHIFT);
+
+	return __cfq_find_cfq_hash(cfqd, pid, hashval);
+}
+
+static void cfq_put_queue(struct cfq_data *cfqd, struct cfq_queue *cfqq)
+{
+	cfqd->busy_queues--;
+	list_del(&cfqq->cfq_list);
+	list_del(&cfqq->cfq_hash);
+	mempool_free(cfqq, cfq_mpool);
+}
+
+static struct cfq_queue *cfq_get_queue(struct cfq_data *cfqd, int pid)
+{
+	const int hashval = hash_long(current->pid, CFQ_QHASH_SHIFT);
+	struct cfq_queue *cfqq = __cfq_find_cfq_hash(cfqd, pid, hashval);
+
+	if (!cfqq) {
+		cfqq = mempool_alloc(cfq_mpool, GFP_NOIO);
+
+		INIT_LIST_HEAD(&cfqq->cfq_hash);
+		INIT_LIST_HEAD(&cfqq->cfq_list);
+		RB_CLEAR(&cfqq->sort_list);
+
+		cfqq->pid = pid;
+		cfqq->queued[0] = cfqq->queued[1] = 0;
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
+	cfq_add_crq_rb(cfqd, cfqq, crq);
+
+	if (list_empty(&cfqq->cfq_list)) {
+		list_add(&cfqq->cfq_list, &cfqd->rr_list);
+		cfqd->busy_queues++;
+	}
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
+extern int queue_nr_requests;
+
+static int cfq_may_queue(request_queue_t *q, int rw)
+{
+	struct cfq_data *cfqd = q->elevator.elevator_data;
+	struct cfq_queue *cfqq;
+	int limit, ret = 1;
+
+	if (!cfqd->busy_queues)
+		goto out;
+
+	cfqq = cfq_find_cfq_hash(cfqd, current->pid);
+	if (!cfqq)
+		goto out;
+
+	if (cfqq->queued[rw] < cfq_queued)
+		goto out;
+
+	limit = (queue_nr_requests - cfq_queued) / cfqd->busy_queues;
+	if (cfqq->queued[rw] > limit)
+		ret = 0;
+
+out:
+	return ret;
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
+	.elevator_may_queue_fn =	cfq_may_queue,
+	.elevator_init_fn =		cfq_init,
+	.elevator_exit_fn =		cfq_exit,
+};
+
+EXPORT_SYMBOL(iosched_cfq);

-- 
Jens Axboe

