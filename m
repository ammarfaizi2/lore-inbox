Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264466AbTH2IQ4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 04:16:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264378AbTH2IQ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 04:16:28 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:59860 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S264464AbTH2IPw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 04:15:52 -0400
Date: Fri, 29 Aug 2003 10:15:39 +0200
From: Jens Axboe <axboe@suse.de>
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Lovechild@foolclan.com
Subject: [PATCH] 2.6.0-test4 CFQ io scheduler
Message-ID: <20030829081539.GA28216@suse.de>
References: <1062078948.17363.4.camel@pilot.stavtrup-st.dk> <20030828194743.GH16684@suse.de> <1062107920.665.0.camel@teapot.felipe-alfaro.com> <20030829065932.GL16684@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030829065932.GL16684@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 29 2003, Jens Axboe wrote:
> On Thu, Aug 28 2003, Felipe Alfaro Solana wrote:
> > On Thu, 2003-08-28 at 21:47, Jens Axboe wrote:
> > 
> > > It shouldn't be too hard to adapt the latest version from before -mm
> > > dropped it and adapting to the current kernels. If you want to give that
> > > a go, I'd be happy to help you out.
> > 
> > Why don't you post a patch against 2.6.0-test4 or 2.6.0-test4-mm1 on
> > LKML? I would like to start using CFQ again :-)
> 
> Heh, did you not read the email? :)
> 
> I'll see if I get squeeze it in today, stay tuned.

Alright, here's a version for 2.6.0-test4. It builds, it survived a 128
client dbench on SMP. And that's all the testing I did, so be careful.

You need to boot with elevator=cfq to activate it.

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1291  -> 1.1292 
#	include/linux/elevator.h	1.27    -> 1.28   
#	drivers/block/Kconfig.iosched	1.2     -> 1.3    
#	drivers/block/ll_rw_blk.c	1.206   -> 1.207  
#	drivers/block/Makefile	1.21    -> 1.22   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/08/29	axboe@smithers.home.kernel.dk	1.1292
# CFQ I/O scheduler
# --------------------------------------------
#
diff -Nru a/drivers/block/Kconfig.iosched b/drivers/block/Kconfig.iosched
--- a/drivers/block/Kconfig.iosched	Fri Aug 29 10:14:28 2003
+++ b/drivers/block/Kconfig.iosched	Fri Aug 29 10:14:28 2003
@@ -27,3 +27,10 @@
 	  a disk at any one time, its behaviour is almost identical to the
 	  anticipatory I/O scheduler and so is a good choice.
 
+config IOSCHED_CFQ
+	bool "CFQ I/O scheduler" if EMBEDDED
+	default y
+	---help---
+	  The CFQ I/O scheduler tries to distribute bandwidth equally
+	  among all processes in the system. It should provide a fair
+	  working environment, suitable for desktop systems.
diff -Nru a/drivers/block/Makefile b/drivers/block/Makefile
--- a/drivers/block/Makefile	Fri Aug 29 10:14:28 2003
+++ b/drivers/block/Makefile	Fri Aug 29 10:14:28 2003
@@ -18,6 +18,7 @@
 obj-$(CONFIG_IOSCHED_NOOP)	+= noop-iosched.o
 obj-$(CONFIG_IOSCHED_AS)	+= as-iosched.o
 obj-$(CONFIG_IOSCHED_DEADLINE)	+= deadline-iosched.o
+obj-$(CONFIG_IOSCHED_CFQ)	+= cfq-iosched.o
 obj-$(CONFIG_MAC_FLOPPY)	+= swim3.o
 obj-$(CONFIG_BLK_DEV_FD)	+= floppy.o
 obj-$(CONFIG_BLK_DEV_FD98)	+= floppy98.o
diff -Nru a/drivers/block/ll_rw_blk.c b/drivers/block/ll_rw_blk.c
--- a/drivers/block/ll_rw_blk.c	Fri Aug 29 10:14:28 2003
+++ b/drivers/block/ll_rw_blk.c	Fri Aug 29 10:14:28 2003
@@ -1231,6 +1231,8 @@
 	&iosched_as;
 #elif defined(CONFIG_IOSCHED_DEADLINE)
 	&iosched_deadline;
+#elif defined(CONFIG_IOSCHED_CFQ)
+	&iosched_cfq;
 #elif defined(CONFIG_IOSCHED_NOOP)
 	&elevator_noop;
 #else
@@ -1248,6 +1250,10 @@
 #ifdef CONFIG_IOSCHED_AS
 	if (!strcmp(str, "as"))
 		chosen_elevator = &iosched_as;
+#endif
+#ifdef CONFIG_IOSCHED_CFQ
+	if (!strcmp(str, "cfq"))
+		chosen_elevator = &iosched_cfq;
 #endif
 #ifdef CONFIG_IOSCHED_NOOP
 	if (!strcmp(str, "noop"))
diff -Nru a/include/linux/elevator.h b/include/linux/elevator.h
--- a/include/linux/elevator.h	Fri Aug 29 10:14:28 2003
+++ b/include/linux/elevator.h	Fri Aug 29 10:14:28 2003
@@ -98,6 +98,11 @@
  */
 extern elevator_t iosched_as;
 
+/*
+ * completely fair queueing I/O scheduler
+ */
+extern elevator_t iosched_cfq;
+
 extern int elevator_init(request_queue_t *, elevator_t *);
 extern void elevator_exit(request_queue_t *);
 extern inline int elv_rq_merge_ok(struct request *, struct bio *);
diff -Nru a/drivers/block/cfq-iosched.c b/drivers/block/cfq-iosched.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/drivers/block/cfq-iosched.c	Fri Aug 29 10:14:15 2003
@@ -0,0 +1,690 @@
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
+	mempool_t *crq_pool;
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
+static void cfq_remove_merge_hints(request_queue_t *q, struct cfq_rq *crq)
+{
+	cfq_del_crq_hash(crq);
+
+	if (q->last_merge == &crq->request->queuelist)
+		q->last_merge = NULL;
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
+		cfqq->queued[rq_data_dir(crq->request)]--;
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
+		cfq_remove_merge_hints(q, crq);
+		list_del_init(&rq->queuelist);
+
+		if (cfqq) {
+			cfq_del_crq_rb(cfqq, crq);
+
+			if (RB_EMPTY(&cfqq->sort_list))
+				cfq_put_queue(cfqd, cfqq);
+		}
+	}
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
+	limit = (q->nr_requests - cfq_queued) / cfqd->busy_queues;
+	if (cfqq->queued[rw] > limit)
+		ret = 0;
+
+out:
+	return ret;
+}
+
+static void cfq_put_request(request_queue_t *q, struct request *rq)
+{
+	struct cfq_data *cfqd = q->elevator.elevator_data;
+	struct cfq_rq *crq = RQ_DATA(rq);
+
+	if (crq) {
+		BUG_ON(q->last_merge == &rq->queuelist);
+		BUG_ON(ON_MHASH(crq));
+
+		mempool_free(crq, cfqd->crq_pool);
+		rq->elevator_private = NULL;
+	}
+}
+
+static int cfq_set_request(request_queue_t *q, struct request *rq, int gfp_mask)
+{
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
+}
+
+static void cfq_exit(request_queue_t *q, elevator_t *e)
+{
+	struct cfq_data *cfqd = e->elevator_data;
+
+	e->elevator_data = NULL;
+	mempool_destroy(cfqd->crq_pool);
+	kfree(cfqd->crq_hash);
+	kfree(cfqd->cfq_hash);
+	kfree(cfqd);
+}
+
+static int cfq_init(request_queue_t *q, elevator_t *e)
+{
+	struct cfq_data *cfqd;
+	int i;
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
+	cfqd->crq_pool = mempool_create(BLKDEV_MIN_RQ, mempool_alloc_slab, mempool_free_slab, crq_pool);
+	if (!cfqd->crq_pool)
+		goto out_crqpool;
+
+	for (i = 0; i < CFQ_MHASH_ENTRIES; i++)
+		INIT_LIST_HEAD(&cfqd->crq_hash[i]);
+	for (i = 0; i < CFQ_QHASH_ENTRIES; i++)
+		INIT_LIST_HEAD(&cfqd->cfq_hash[i]);
+
+	cfqd->dispatch = &q->queue_head;
+	e->elevator_data = cfqd;
+	return 0;
+out_crqpool:
+	kfree(cfqd->cfq_hash);
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
+	cfq_mpool = mempool_create(64, mempool_alloc_slab, mempool_free_slab, cfq_pool);
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
+	.elevator_name =		"cfq",
+	.elevator_merge_fn = 		cfq_merge,
+	.elevator_merged_fn =		cfq_merged_request,
+	.elevator_merge_req_fn =	cfq_merged_requests,
+	.elevator_next_req_fn =		cfq_next_request,
+	.elevator_add_req_fn =		cfq_insert_request,
+	.elevator_remove_req_fn =	cfq_remove_request,
+	.elevator_queue_empty_fn =	cfq_queue_empty,
+	.elevator_former_req_fn =	cfq_former_request,
+	.elevator_latter_req_fn =	cfq_latter_request,
+	.elevator_set_req_fn =		cfq_set_request,
+	.elevator_put_req_fn =		cfq_put_request,
+	.elevator_may_queue_fn =	cfq_may_queue,
+	.elevator_init_fn =		cfq_init,
+	.elevator_exit_fn =		cfq_exit,
+};
+
+EXPORT_SYMBOL(iosched_cfq);

-- 
Jens Axboe

