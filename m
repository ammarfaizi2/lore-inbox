Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313867AbSG3HyE>; Tue, 30 Jul 2002 03:54:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314835AbSG3HyE>; Tue, 30 Jul 2002 03:54:04 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:29574 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S313867AbSG3Hx4>;
	Tue, 30 Jul 2002 03:53:56 -0400
Date: Tue, 30 Jul 2002 09:57:38 +0200
From: Jens Axboe <axboe@suse.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@zip.com.au>
Subject: Re: [PATCH] block/elevator updates + deadline i/o scheduler
Message-ID: <20020730095738.G4445@suse.de>
References: <20020726120248.GI14839@suse.de> <3D419583.DFE940DA@zip.com.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="VS++wcV0S1rZb1Fb"
Content-Disposition: inline
In-Reply-To: <3D419583.DFE940DA@zip.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--VS++wcV0S1rZb1Fb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

An updated version of the deadline i/o scheduler against 2.5.29 is now
available. Changes since last version:

features:

o 'fifo_batch' meant "move this number of entries to dispatch queue" in
the previous version, now it means "move entries to dispatch queue at
this max cost". It is complimented by 'seek_cost' which is a simple
measure of transfer-time vs seek-time cost. If a request X+1 is
contigous to request X, then it is accounted at cost '1'. If not, it's
accounted at cost 'seek_cost'.

o Doing numbers on q->last_merge hits in the linus elevator showed
impressive amount of hits even when lots of threads where banging the
queue at the same time. So add q->last_merge hints to this scheduler
too.

fixes:

o remember to actually register e->merge_cleanup so the merge cleanup
parts works. This caused us to miss out on a number of back merges.

o use wli's hash_long() as the merge hash. gets good distribution on
various benchmark runs and is fast, very nice :-)

o various cleanups

So no serious bug found (ie crashes or data corruption issues). Again,
mainly tested on SCSI, briefly tested on IDE as well. Due to better
design of the i/o scheduler interface in 2.5 in general, integrity
testing on IDE isn't nearly as important as it was in 2.4 for instance.
So I consider the patch stable for general use right now.

elv-queue_head-misc-2
	various block- and i/o scheduler interface updates. needs to be
	applied first.

deadline-iosched-7
	the deadline i/o scheduler.

Find them on kernel.org as well of course. Testing welcome!

-- 
Jens Axboe


--VS++wcV0S1rZb1Fb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=deadline-iosched-7

diff -urN -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.5.29/drivers/block/Makefile linux/drivers/block/Makefile
--- /opt/kernel/linux-2.5.29/drivers/block/Makefile	Wed Jul 24 23:03:31 2002
+++ linux/drivers/block/Makefile	Fri Jul 26 11:05:00 2002
@@ -10,7 +10,7 @@
 
 export-objs	:= elevator.o ll_rw_blk.o blkpg.o loop.o DAC960.o genhd.o block_ioctl.o
 
-obj-y	:= elevator.o ll_rw_blk.o blkpg.o genhd.o block_ioctl.o
+obj-y	:= elevator.o ll_rw_blk.o blkpg.o genhd.o block_ioctl.o deadline-iosched.o
 
 obj-$(CONFIG_MAC_FLOPPY)	+= swim3.o
 obj-$(CONFIG_BLK_DEV_FD)	+= floppy.o
diff -urN -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.5.29/drivers/block/deadline-iosched.c linux/drivers/block/deadline-iosched.c
--- /opt/kernel/linux-2.5.29/drivers/block/deadline-iosched.c	Thu Jan  1 01:00:00 1970
+++ linux/drivers/block/deadline-iosched.c	Tue Jul 30 09:40:49 2002
@@ -0,0 +1,490 @@
+/*
+ *  linux/drivers/block/deadline-iosched.c
+ *
+ *  Deadline i/o scheduler.
+ *
+ *  Copyright (C) 2002 Jens Axboe <axboe@suse.de>
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
+
+/*
+ * feel free to try other values :-). *_expire values are the timeouts
+ * for reads and writes, our goal is to start a request "around" the time
+ * when it expires. fifo_batch is how many steps along the sorted list we
+ * will take when the front fifo request expires.
+ */
+static int read_expire = HZ;
+static int write_expire = 10 * HZ;
+static int fifo_batch = 80;
+static int seek_cost = 20;
+
+static const int deadline_hash_shift = 6;
+#define DL_HASH_BLOCK(sec)	((sec) >> 3)
+#define DL_HASH_FN(sec)		(hash_long(DL_HASH_BLOCK((sec)), deadline_hash_shift))
+#define DL_HASH_ENTRIES		(1 << deadline_hash_shift)
+
+#define DL_INVALIDATE_HASH(dd)				\
+	do {						\
+		if (!++(dd)->hash_valid_count)		\
+			(dd)->hash_valid_count = 1;	\
+	} while (0)
+
+struct deadline_data {
+	struct list_head sort_list;
+	struct list_head fifo_list[2];
+	struct list_head *hash;
+	sector_t last_sector;
+	unsigned long hash_valid_count;
+
+	/*
+	 * settings that change how the i/o scheduler behaves
+	 */
+	unsigned int fifo_batch;
+	unsigned long fifo_expire[2];
+	unsigned int seek_cost;
+};
+
+struct deadline_rq {
+	struct list_head fifo;
+	struct list_head hash;
+	unsigned long hash_valid_count;
+	struct request *request;
+	unsigned long expires;
+};
+
+static kmem_cache_t *drq_pool;
+
+#define RQ_DATA(rq)		((struct deadline_rq *) (rq)->elevator_private)
+
+static inline void deadline_move_to_dispatch(request_queue_t *q,
+					     struct request *rq)
+{
+	struct deadline_rq *drq = RQ_DATA(rq);
+
+	list_move_tail(&rq->queuelist, &q->queue_head);
+	list_del_init(&drq->fifo);
+}
+
+#define ON_HASH(drq)	(drq)->hash_valid_count
+static inline void deadline_del_rq_hash(struct deadline_rq *drq)
+{
+	if (ON_HASH(drq)) {
+		drq->hash_valid_count = 0;
+		list_del_init(&drq->hash);
+	}
+}
+
+static inline void deadline_add_rq_hash(struct deadline_data *dd,
+					struct deadline_rq *drq)
+{
+	struct request *rq = drq->request;
+
+	BUG_ON(ON_HASH(drq));
+
+	drq->hash_valid_count = dd->hash_valid_count;
+	list_add(&drq->hash, &dd->hash[DL_HASH_FN(rq->sector +rq->nr_sectors)]);
+}
+
+#define list_entry_hash(ptr)	list_entry((ptr), struct deadline_rq, hash)
+static struct request *deadline_find_hash(struct deadline_data *dd,
+					  sector_t offset)
+{
+	struct list_head *hash_list = &dd->hash[DL_HASH_FN(offset)];
+	struct list_head *entry, *next = hash_list->next;
+	struct deadline_rq *drq;
+	struct request *rq = NULL;
+
+	while ((entry = next) != hash_list) {
+		next = entry->next;
+		drq = list_entry_hash(entry);
+
+		BUG_ON(!drq->hash_valid_count);
+
+		if (!rq_mergeable(drq->request)
+		    || drq->hash_valid_count != dd->hash_valid_count) {
+			deadline_del_rq_hash(drq);
+			continue;
+		}
+
+		if (drq->request->sector + drq->request->nr_sectors == offset) {
+			rq = drq->request;
+			break;
+		}
+	}
+
+	return rq;
+}
+
+static int deadline_merge(request_queue_t *q, struct request **req,
+			  struct bio *bio)
+{
+	struct deadline_data *dd = q->elevator.elevator_data;
+	struct list_head *entry = &dd->sort_list;
+	struct request *__rq;
+	int ret = ELEVATOR_NO_MERGE;
+
+	/*
+	 * try last_merge to avoid going to hash
+	 */
+	if ((ret = elv_try_last_merge(q, req, bio)))
+		goto out;
+
+	/*
+	 * see if the merge hash can satisfy a back merge
+	 */
+	if ((__rq = deadline_find_hash(dd, bio->bi_sector))) {
+		if (elv_rq_merge_ok(__rq, bio)) {
+			if (__rq->sector + __rq->nr_sectors == bio->bi_sector) {
+				*req = __rq;
+				q->last_merge = &__rq->queuelist;
+				ret = ELEVATOR_BACK_MERGE;
+				goto out;
+			}
+		}
+	}
+
+	while ((entry = entry->prev) != &dd->sort_list) {
+		__rq = list_entry_rq(entry);
+
+		BUG_ON(__rq->flags & REQ_STARTED);
+		BUG_ON(__rq->flags & REQ_BARRIER);
+
+		if (!(__rq->flags & REQ_CMD))
+			continue;
+
+		if (!*req && bio_rq_in_between(bio, __rq, &dd->sort_list))
+			*req = __rq;
+
+		if (elv_rq_merge_ok(__rq, bio)) {
+			if (__rq->sector - bio_sectors(bio) == bio->bi_sector) {
+				*req = __rq;
+				q->last_merge = &__rq->queuelist;
+				ret = ELEVATOR_FRONT_MERGE;
+				break;
+			} else if (__rq->sector + __rq->nr_sectors == bio->bi_sector)
+				printk("deadline_merge: back merge hit on list\n");
+		}
+	}
+
+out:
+	return ret;
+}
+
+static void deadline_merge_cleanup(request_queue_t *q, struct request *req,
+				   int count)
+{
+	struct deadline_data *dd = q->elevator.elevator_data;
+	struct deadline_rq *drq = RQ_DATA(req);
+
+	deadline_del_rq_hash(drq);
+	deadline_add_rq_hash(dd, drq);
+}
+
+#define ON_FIFO(drq)	!list_empty(&(drq)->fifo)
+static void deadline_merge_request(request_queue_t *q, struct request *req,
+				   struct request *next)
+{
+	struct deadline_rq *drq = RQ_DATA(req);
+	struct deadline_rq *dnext = RQ_DATA(next);
+
+	BUG_ON(!drq);
+	BUG_ON(!dnext);
+
+	deadline_merge_cleanup(q, req, 0);
+
+	/*
+	 * if dnext expires before drq, assign it's expire time to drq
+	 * and move into dnext position (dnext will be deleted) in fifo
+	 */
+	if (ON_FIFO(drq) && ON_FIFO(dnext)) {
+		if (time_before(dnext->expires, drq->expires)) {
+			list_move(&drq->fifo, &dnext->fifo);
+			drq->expires = dnext->expires;
+		}
+	}
+}
+
+#define list_entry_fifo(ptr)	list_entry((ptr), struct deadline_rq, fifo)
+static int deadline_check_fifo(request_queue_t *q, int ddir)
+{
+	struct deadline_data *dd = q->elevator.elevator_data;
+	struct list_head *fifo_list = &dd->fifo_list[ddir];
+	struct deadline_rq *drq;
+	struct request *rq;
+	sector_t last_sec;
+	int batch_count;
+
+	if (list_empty(fifo_list))
+		return 0;
+
+	drq = list_entry_fifo(fifo_list->next);
+	if (time_before(jiffies, drq->expires))
+		return 0;
+
+	rq = drq->request;
+	batch_count = dd->fifo_batch;
+	last_sec = dd->last_sector;
+	do {
+		struct list_head *nxt = rq->queuelist.next;
+
+		/*
+		 * take it off the sort and fifo list, move
+		 * to dispatch queue
+		 */
+		deadline_move_to_dispatch(q, rq);
+
+		if (rq->sector == last_sec)
+			batch_count--;
+		else
+			batch_count -= dd->seek_cost;
+
+		if (nxt == &dd->sort_list)
+			break;
+
+		last_sec = rq->sector + rq->nr_sectors;
+		rq = list_entry_rq(nxt);
+	} while (batch_count > 0);
+
+	/*
+	 * should be entries there now, at least 1
+	 */
+	return 1;
+}
+
+static struct request *deadline_next_request(request_queue_t *q)
+{
+	struct deadline_data *dd = q->elevator.elevator_data;
+	struct request *rq;
+
+	/*
+	 * if still requests on the dispatch queue, just grab the first one
+	 */
+	if (!list_empty(&q->queue_head)) {
+dispatch:
+		rq = list_entry_rq(q->queue_head.next);
+		dd->last_sector = rq->sector + rq->nr_sectors;
+		return rq;
+	}
+
+	/*
+	 * decide whether to just grab first from sorted list, or move a
+	 * batch from the expire list. if it has expired, move 'batch'
+	 * entries to dispatch queue
+	 */
+	if (deadline_check_fifo(q, READ))
+		goto dispatch;
+	if (deadline_check_fifo(q, WRITE))
+		goto dispatch;
+
+	if (!list_empty(&dd->sort_list)) {
+		deadline_move_to_dispatch(q, list_entry_rq(dd->sort_list.next));
+		goto dispatch;
+	}
+
+	return NULL;
+}
+
+static void deadline_add_request(request_queue_t *q, struct request *rq, struct list_head *insert_here)
+{
+	struct deadline_data *dd = q->elevator.elevator_data;
+	struct deadline_rq *drq;
+
+	/*
+	 * insert barriers directly into the back of the dispatch queue,
+	 * don't use the sorted or fifo list for those
+	 */
+	if (unlikely(rq->flags & REQ_BARRIER)) {
+		DL_INVALIDATE_HASH(dd);
+		list_add_tail(&rq->queuelist, &q->queue_head);
+		q->last_merge = NULL;
+		return;
+	}
+
+	/*
+	 * add to sort list
+	 */
+	if (!insert_here)
+		insert_here = dd->sort_list.prev;
+
+	list_add(&rq->queuelist, insert_here);
+
+	if (unlikely(!(rq->flags & REQ_CMD)))
+		return;
+
+	/*
+	 * set expire time and add to fifo list
+	 */
+	drq = RQ_DATA(rq);
+	drq->expires = jiffies + dd->fifo_expire[rq_data_dir(rq)];
+	list_add_tail(&drq->fifo, &dd->fifo_list[rq_data_dir(rq)]);
+
+	if (rq_mergeable(rq))
+		deadline_add_rq_hash(dd, drq);
+
+	if (!q->last_merge)
+		q->last_merge = &rq->queuelist;
+}
+
+static void deadline_remove_request(request_queue_t *q, struct request *rq)
+{
+	struct deadline_rq *drq = RQ_DATA(rq);
+
+	if (drq) {
+		list_del_init(&drq->fifo);
+		deadline_del_rq_hash(drq);
+	}
+}
+
+static int deadline_queue_empty(request_queue_t *q)
+{
+	struct deadline_data *dd = q->elevator.elevator_data;
+
+	if (!list_empty(&q->queue_head) || !list_empty(&dd->sort_list))
+		return 0;
+
+	BUG_ON(!list_empty(&dd->fifo_list[READ]));
+	BUG_ON(!list_empty(&dd->fifo_list[WRITE]));
+	return 1;
+}
+
+static struct list_head *deadline_get_sort_head(request_queue_t *q,
+						struct request *rq)
+{
+	struct deadline_data *dd = q->elevator.elevator_data;
+
+	return &dd->sort_list;
+}
+
+static void deadline_exit(request_queue_t *q, elevator_t *e)
+{
+	struct deadline_data *dd = e->elevator_data;
+	struct deadline_rq *drq;
+	struct request *rq;
+	int i;
+
+	BUG_ON(!list_empty(&dd->fifo_list[READ]));
+	BUG_ON(!list_empty(&dd->fifo_list[WRITE]));
+	BUG_ON(!list_empty(&dd->sort_list));
+
+	for (i = 0; i < 2; i++) {
+		struct request_list *rl = &q->rq[i];
+		struct list_head *entry = &rl->free;
+
+		if (list_empty(&rl->free))
+			continue;
+	
+		while ((entry = entry->next) != &rl->free) {
+			rq = list_entry_rq(entry);
+
+			if ((drq = RQ_DATA(rq)) == NULL)
+				continue;
+
+			rq->elevator_private = NULL;
+			kmem_cache_free(drq_pool, drq);
+		}
+	}
+
+	kfree(dd->hash);
+	kfree(dd);
+}
+
+static int deadline_init(request_queue_t *q, elevator_t *e)
+{
+	struct deadline_data *dd;
+	struct deadline_rq *drq;
+	struct request *rq;
+	int i, ret = 0;
+
+	if (!drq_pool)
+		return -ENOMEM;
+
+	dd = kmalloc(sizeof(*dd), GFP_KERNEL);
+	if (!dd)
+		return -ENOMEM;
+	memset(dd, 0, sizeof(*dd));
+
+	dd->hash = kmalloc(sizeof(struct list_head)*DL_HASH_ENTRIES,GFP_KERNEL);
+	if (!dd->hash) {
+		kfree(dd);
+		return -ENOMEM;
+	}
+
+	for (i = 0; i < DL_HASH_ENTRIES; i++)
+		INIT_LIST_HEAD(&dd->hash[i]);
+
+	INIT_LIST_HEAD(&dd->fifo_list[READ]);
+	INIT_LIST_HEAD(&dd->fifo_list[WRITE]);
+	INIT_LIST_HEAD(&dd->sort_list);
+	dd->fifo_batch = fifo_batch;
+	dd->fifo_expire[READ] = read_expire;
+	dd->fifo_expire[WRITE] = write_expire;
+	dd->seek_cost = seek_cost;
+	dd->hash_valid_count = 1;
+	e->elevator_data = dd;
+
+	for (i = 0; i < 2; i++) {
+		struct request_list *rl = &q->rq[i];
+		struct list_head *entry = &rl->free;
+
+		if (list_empty(&rl->free))
+			continue;
+	
+		while ((entry = entry->next) != &rl->free) {
+			rq = list_entry_rq(entry);
+
+			drq = kmem_cache_alloc(drq_pool, GFP_KERNEL);
+			if (!drq) {
+				ret = -ENOMEM;
+				break;
+			}
+
+			memset(drq, 0, sizeof(*drq));
+			INIT_LIST_HEAD(&drq->fifo);
+			INIT_LIST_HEAD(&drq->hash);
+			drq->request = rq;
+			rq->elevator_private = drq;
+		}
+	}
+
+	if (ret)
+		deadline_exit(q, e);
+
+	return ret;
+}
+
+static int __init deadline_slab_setup(void)
+{
+	drq_pool = kmem_cache_create("deadline_drq", sizeof(struct deadline_rq),
+				     0, SLAB_HWCACHE_ALIGN, NULL, NULL);
+
+	if (!drq_pool)
+		panic("deadline: can't init slab pool\n");
+
+	return 0;
+}
+
+module_init(deadline_slab_setup);
+
+elevator_t iosched_deadline = {
+	.elevator_merge_fn = 		deadline_merge,
+	.elevator_merge_cleanup_fn =	deadline_merge_cleanup,
+	.elevator_merge_req_fn =	deadline_merge_request,
+	.elevator_next_req_fn =		deadline_next_request,
+	.elevator_add_req_fn =		deadline_add_request,
+	.elevator_remove_req_fn =	deadline_remove_request,
+	.elevator_queue_empty_fn =	deadline_queue_empty,
+	.elevator_get_sort_head_fn =	deadline_get_sort_head,
+	.elevator_init_fn =		deadline_init,
+	.elevator_exit_fn =		deadline_exit,
+};
diff -urN -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.5.29/drivers/block/ll_rw_blk.c linux/drivers/block/ll_rw_blk.c
--- /opt/kernel/linux-2.5.29/drivers/block/ll_rw_blk.c	Tue Jul 30 09:04:57 2002
+++ linux/drivers/block/ll_rw_blk.c	Mon Jul 29 21:15:27 2002
@@ -1114,7 +1114,11 @@
 	if (blk_init_free_list(q))
 		return -ENOMEM;
 
+#if 1
+	if ((ret = elevator_init(q, &q->elevator, iosched_deadline))) {
+#else
 	if ((ret = elevator_init(q, &q->elevator, elevator_linus))) {
+#endif
 		blk_cleanup_queue(q);
 		return ret;
 	}
@@ -2072,8 +2072,8 @@
 	queue_nr_requests = (total_ram >> 8) & ~15;	/* One per quarter-megabyte */
 	if (queue_nr_requests < 32)
 		queue_nr_requests = 32;
-	if (queue_nr_requests > 256)
-		queue_nr_requests = 256;
+	if (queue_nr_requests > 768)
+		queue_nr_requests = 768;
 
 	/*
 	 * Batch frees according to queue length
diff -urN -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.5.29/include/linux/elevator.h linux/include/linux/elevator.h
--- /opt/kernel/linux-2.5.29/include/linux/elevator.h	Fri Jul 26 14:01:22 2002
+++ linux/include/linux/elevator.h	Tue Jul 30 09:15:00 2002
@@ -59,6 +63,12 @@
 #define elv_linus_sequence(rq)	((long)(rq)->elevator_private)
 
 /*
+ * deadline i/o scheduler. uses request time outs to prevent indefinite
+ * starvation
+ */
+extern elevator_t iosched_deadline;
+
+/*
  * use the /proc/iosched interface, all the below is history ->
  */
 typedef struct blkelv_ioctl_arg_s {

--VS++wcV0S1rZb1Fb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=elv-queue_head-misc-2

diff -urN -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.5.29/drivers/block/elevator.c linux/drivers/block/elevator.c
--- /opt/kernel/linux-2.5.29/drivers/block/elevator.c	Fri Jul 26 14:01:22 2002
+++ linux/drivers/block/elevator.c	Tue Jul 30 09:11:53 2002
@@ -220,7 +220,8 @@
 	}
 }
 
-void elevator_linus_merge_req(struct request *req, struct request *next)
+void elevator_linus_merge_req(request_queue_t *q, struct request *req,
+			      struct request *next)
 {
 	if (elv_linus_sequence(next) < elv_linus_sequence(req))
 		elv_linus_sequence(req) = elv_linus_sequence(next);
@@ -232,6 +233,9 @@
 	elevator_t *e = &q->elevator;
 	int lat = 0, *latency = e->elevator_data;
 
+	if (!insert_here)
+		insert_here = q->queue_head.prev;
+
 	if (!(rq->flags & REQ_BARRIER))
 		lat = latency[rq_data_dir(rq)];
 
@@ -318,7 +322,7 @@
 
 struct request *elevator_noop_next_request(request_queue_t *q)
 {
-	if (!blk_queue_empty(q))
+	if (!list_empty(&q->queue_head))
 		return list_entry_rq(q->queue_head.next);
 
 	return NULL;
@@ -376,7 +380,7 @@
 	elevator_t *e = &q->elevator;
 
 	if (e->elevator_merge_req_fn)
-		e->elevator_merge_req_fn(rq, next);
+		e->elevator_merge_req_fn(q, rq, next);
 }
 
 /*
@@ -433,6 +437,27 @@
 		e->elevator_remove_req_fn(q, rq);
 }
 
+int elv_queue_empty(request_queue_t *q)
+{
+	elevator_t *e = &q->elevator;
+
+	if (e->elevator_queue_empty_fn)
+		return e->elevator_queue_empty_fn(q);
+
+	return list_empty(&q->queue_head);
+}
+
+inline struct list_head *elv_get_sort_head(request_queue_t *q,
+					   struct request *rq)
+{
+	elevator_t *e = &q->elevator;
+
+	if (e->elevator_get_sort_head_fn)
+		return e->elevator_get_sort_head_fn(q, rq);
+
+	return &q->queue_head;
+}
+
 elevator_t elevator_linus = {
 	elevator_merge_fn:		elevator_linus_merge,
 	elevator_merge_cleanup_fn:	elevator_linus_merge_cleanup,
diff -urN -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.5.29/drivers/block/ll_rw_blk.c linux/drivers/block/ll_rw_blk.c
--- /opt/kernel/linux-2.5.29/drivers/block/ll_rw_blk.c	Tue Jul 30 09:04:57 2002
+++ linux/drivers/block/ll_rw_blk.c	Mon Jul 29 21:15:27 2002
@@ -1388,7 +1392,6 @@
 
 	if (rq_data_dir(req) != rq_data_dir(next)
 	    || !kdev_same(req->rq_dev, next->rq_dev)
-	    || req->nr_sectors + next->nr_sectors > q->max_sectors
 	    || next->waiting || next->special)
 		return;
 
@@ -1399,15 +1402,14 @@
 	 * counts here.
 	 */
 	if (q->merge_requests_fn(q, req, next)) {
-		elv_merge_requests(q, req, next);
-
-		blkdev_dequeue_request(next);
-
 		req->biotail->bi_next = next->bio;
 		req->biotail = next->biotail;
 
 		req->nr_sectors = req->hard_nr_sectors += next->hard_nr_sectors;
 
+		elv_merge_requests(q, req, next);
+
+		blkdev_dequeue_request(next);
 		blk_put_request(next);
 	}
 }
@@ -1415,16 +1417,18 @@
 static inline void attempt_back_merge(request_queue_t *q, struct request *rq)
 {
 	struct list_head *next = rq->queuelist.next;
+	struct list_head *sort_head = elv_get_sort_head(q, rq);
 
-	if (next != &q->queue_head)
+	if (next != sort_head)
 		attempt_merge(q, rq, list_entry_rq(next));
 }
 
 static inline void attempt_front_merge(request_queue_t *q, struct request *rq)
 {
 	struct list_head *prev = rq->queuelist.prev;
+	struct list_head *sort_head = elv_get_sort_head(q, rq);
 
-	if (prev != &q->queue_head)
+	if (prev != sort_head)
 		attempt_merge(q, list_entry_rq(prev), rq);
 }
 
@@ -1484,7 +1488,7 @@
 	spin_lock_irq(q->queue_lock);
 again:
 	req = NULL;
-	insert_here = q->queue_head.prev;
+	insert_here = NULL;
 
 	if (blk_queue_empty(q)) {
 		blk_plug_device(q);
@@ -1502,11 +1506,10 @@
 				break;
 			}
 
-			elv_merge_cleanup(q, req, nr_sectors);
-
 			req->biotail->bi_next = bio;
 			req->biotail = bio;
 			req->nr_sectors = req->hard_nr_sectors += nr_sectors;
+			elv_merge_cleanup(q, req, nr_sectors);
 			drive_stat_acct(req, nr_sectors, 0);
 			attempt_back_merge(q, req);
 			goto out;
@@ -1518,8 +1521,6 @@
 				break;
 			}
 
-			elv_merge_cleanup(q, req, nr_sectors);
-
 			bio->bi_next = req->bio;
 			req->bio = bio;
 			/*
@@ -1532,6 +1533,7 @@
 			req->hard_cur_sectors = cur_nr_sectors;
 			req->sector = req->hard_sector = sector;
 			req->nr_sectors = req->hard_nr_sectors += nr_sectors;
+			elv_merge_cleanup(q, req, nr_sectors);
 			drive_stat_acct(req, nr_sectors, 0);
 			attempt_front_merge(q, req);
 			goto out;
@@ -1600,9 +1602,7 @@
 	req->buffer = bio_data(bio);	/* see ->buffer comment above */
 	req->waiting = NULL;
 	req->bio = req->biotail = bio;
-	if (bio->bi_bdev)
-		req->rq_dev = to_kdev_t(bio->bi_bdev->bd_dev);
-	else	req->rq_dev = NODEV;
+	req->rq_dev = to_kdev_t(bio->bi_bdev->bd_dev);
 	add_request(q, req, insert_here);
 out:
 	if (freereq)
diff -urN -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.5.29/include/linux/elevator.h linux/include/linux/elevator.h
--- /opt/kernel/linux-2.5.29/include/linux/elevator.h	Fri Jul 26 14:01:22 2002
+++ linux/include/linux/elevator.h	Tue Jul 30 09:02:22 2002
@@ -6,13 +6,14 @@
 
 typedef void (elevator_merge_cleanup_fn) (request_queue_t *, struct request *, int);
 
-typedef void (elevator_merge_req_fn) (struct request *, struct request *);
+typedef void (elevator_merge_req_fn) (request_queue_t *, struct request *, struct request *);
 
 typedef struct request *(elevator_next_req_fn) (request_queue_t *);
 
 typedef void (elevator_add_req_fn) (request_queue_t *, struct request *, struct list_head *);
 typedef int (elevator_queue_empty_fn) (request_queue_t *);
 typedef void (elevator_remove_req_fn) (request_queue_t *, struct request *);
+typedef struct list_head *(elevator_get_sort_head_fn) (request_queue_t *, struct request *);
 
 typedef int (elevator_init_fn) (request_queue_t *, elevator_t *);
 typedef void (elevator_exit_fn) (request_queue_t *, elevator_t *);
@@ -28,6 +29,7 @@
 	elevator_remove_req_fn *elevator_remove_req_fn;
 
 	elevator_queue_empty_fn *elevator_queue_empty_fn;
+	elevator_get_sort_head_fn *elevator_get_sort_head_fn;
 
 	elevator_init_fn *elevator_init_fn;
 	elevator_exit_fn *elevator_exit_fn;
@@ -45,6 +47,8 @@
 extern void elv_merge_requests(request_queue_t *, struct request *,
 			       struct request *);
 extern void elv_remove_request(request_queue_t *, struct request *);
+extern int elv_queue_empty(request_queue_t *);
+extern inline struct list_head *elv_get_sort_head(request_queue_t *, struct request *);
 
 /*
  * noop I/O scheduler. always merges, always inserts new request at tail
@@ -72,6 +82,10 @@
 
 extern int elevator_init(request_queue_t *, elevator_t *, elevator_t);
 extern void elevator_exit(request_queue_t *, elevator_t *);
+extern inline int bio_rq_in_between(struct bio *, struct request *, struct list_head *);
+extern inline int elv_rq_merge_ok(struct request *, struct bio *);
+extern inline int elv_try_merge(struct request *, struct bio *);
+extern inline int elv_try_last_merge(request_queue_t *, struct request **, struct bio *);
 
 /*
  * Return values from elevator merger
@@ -80,10 +94,4 @@
 #define ELEVATOR_FRONT_MERGE	1
 #define ELEVATOR_BACK_MERGE	2
 
-/*
- * will change once we move to a more complex data structure than a simple
- * list for pending requests
- */
-#define elv_queue_empty(q)	list_empty(&(q)->queue_head)
-
 #endif

--VS++wcV0S1rZb1Fb--
