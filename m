Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318750AbSHBIQU>; Fri, 2 Aug 2002 04:16:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318751AbSHBIQU>; Fri, 2 Aug 2002 04:16:20 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:231 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S318750AbSHBIQO>;
	Fri, 2 Aug 2002 04:16:14 -0400
Date: Fri, 2 Aug 2002 10:16:16 +0200
From: Jens Axboe <axboe@suse.de>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>
Subject: Re: [PATCH] block/elevator updates + deadline i/o scheduler
Message-ID: <20020802081616.GA1055@suse.de>
References: <20020801085152.GC1096@suse.de> <Pine.LNX.3.96.1020801141845.15133B-100000@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="vkogqOf2sHV7VnPd"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.3.96.1020801141845.15133B-100000@gatekeeper.tmr.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 01 2002, Bill Davidsen wrote:
> On Thu, 1 Aug 2002, Jens Axboe wrote:
> 
> > On Tue, Jul 30 2002, Bill Davidsen wrote:
> 
> > > Now a request, if someone is running a database app and tests this I'd
> > > love to see the results. I expect things like LMbench to show more threads
> > > ending at the same time, but will it help a reall app?
> > 
> > Note that the deadline i/o scheduler only considers deadlines on
> > individual requests so far, so there's no real guarentee that process X,
> > Y, and Z will receive equal share of the bandwidth. This is something
> > I'm thinking about, though.
> 
> I'm not sure that equal bandwidth and deadline are compatible, some
> processes may need more bandwidth to meet deadlines. I'm not unhappy about
> that, it's the reads waiting in a flood of write or vice-versa that
> occasionally make an app really rot.

Correct, that's _exactly_ the case that made me attempt this type of io
scheduler. The current scheduler does well wrt optimizing for
throughput.

> > My testing does seem to indicate that the deadline scheduler is fairer
> > than the linus scheduler, but ymmv.
> > 
> > > I bet it was tested briefly on IDE, my last use of IDE a week or so ago
> > > lasted until I did "make dep" and the output went all over every attached
> > > drive :-( Still, nice to know it will work if IDE makes it into 2.5.
> > 
> > :/
> > 
> > I'll say that 2.5.29 IDE did work fine for the testing I did with the
> > deadline scheduler, at least it survived a dbench 64 (that's about the
> > testing it got).
> 
> Hum, looks as if I should plan to retest with 29 and the deadline patches.
> My personal test is a program doing one read/sec while making CD images
> (mkisofs) on a machine with large memory. It tends to build the whole
> 700MB in memory and then bdflush decides it should be written and the read
> latency totally goes to hell. I will say most of this can be tuned out at
> some small cost to total performance (thanks Andrea).

You are most welcome to test of course, I would very much like you to do
just that. 2.5.30 is out now and has the elv-queue* patch included which
included the necessary base changes for applying deadline-iosched, so
it's even easier now. I've attached the latest deadline-iosched-8 for
you.

-- 
Jens Axboe


--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=deadline-iosched-8

diff -urN -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.5.30/drivers/block/deadline-iosched.c linux/drivers/block/deadline-iosched.c
--- /opt/kernel/linux-2.5.30/drivers/block/deadline-iosched.c	1970-01-01 01:00:00.000000000 +0100
+++ linux/drivers/block/deadline-iosched.c	2002-07-31 12:56:33.000000000 +0200
@@ -0,0 +1,514 @@
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
+static const int deadline_hash_shift = 8;
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
+	struct list_head sort_list;	/* sorted listed */
+	struct list_head fifo_list[2];	/* fifo list */
+	struct list_head *dispatch;	/* driver dispatch queue */
+	struct list_head *hash;		/* request hash */
+	sector_t last_sector;		/* last sector sent to drive */
+	unsigned long hash_valid_count;	/* barrier hash count */
+	int fifo_check;			/* check this fifo list first */
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
+static inline void
+deadline_move_to_dispatch(struct deadline_data *dd, struct request *rq)
+{
+	struct deadline_rq *drq = RQ_DATA(rq);
+
+	list_move_tail(&rq->queuelist, dd->dispatch);
+	list_del_init(&drq->fifo);
+}
+
+static inline void __deadline_del_rq_hash(struct deadline_rq *drq)
+{
+	drq->hash_valid_count = 0;
+	list_del_init(&drq->hash);
+}
+
+#define ON_HASH(drq)	(drq)->hash_valid_count
+static inline void deadline_del_rq_hash(struct deadline_rq *drq)
+{
+	if (ON_HASH(drq))
+		__deadline_del_rq_hash(drq);
+}
+
+static inline void
+deadline_add_rq_hash(struct deadline_data *dd, struct deadline_rq *drq)
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
+static struct request *
+deadline_find_hash(struct deadline_data *dd, sector_t offset)
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
+			__deadline_del_rq_hash(drq);
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
+static int
+deadline_merge(request_queue_t *q, struct request **req, struct bio *bio)
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
+		BUG_ON(__rq->sector + __rq->nr_sectors != bio->bi_sector);
+
+		if (elv_rq_merge_ok(__rq, bio)) {
+			*req = __rq;
+			q->last_merge = &__rq->queuelist;
+			ret = ELEVATOR_BACK_MERGE;
+			goto out;
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
+		if (__rq->sector - bio_sectors(bio) == bio->bi_sector) {
+			if ((ret = elv_try_merge(__rq, bio))) {
+				*req = __rq;
+				q->last_merge = &__rq->queuelist;
+				break;
+			}
+		}
+	}
+
+out:
+	return ret;
+}
+
+static void
+deadline_merge_cleanup(request_queue_t *q, struct request *req, int count)
+{
+	struct deadline_data *dd = q->elevator.elevator_data;
+	struct deadline_rq *drq = RQ_DATA(req);
+
+	deadline_del_rq_hash(drq);
+	deadline_add_rq_hash(dd, drq);
+}
+
+#define ON_FIFO(drq)	!list_empty(&(drq)->fifo)
+static void
+deadline_merge_request(request_queue_t *q, struct request *req, struct request *next)
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
+static int
+deadline_check_fifo(struct deadline_data *dd, struct list_head *fifo_list)
+{
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
+		deadline_move_to_dispatch(dd, rq);
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
+static inline int deadline_check_fifos(struct deadline_data *dd)
+{
+	/*
+	 * check current list, flip if entries were moved
+	 */
+	if (deadline_check_fifo(dd, &dd->fifo_list[dd->fifo_check])) {
+		dd->fifo_check ^= 1;
+		return 1;
+	}
+
+	/*
+	 * check alternate list, leave current list if entries were moved
+	 */
+	if (deadline_check_fifo(dd, &dd->fifo_list[dd->fifo_check ^ 1]))
+		return 1;
+
+	return 0;
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
+	if (deadline_check_fifos(dd))
+		goto dispatch;
+
+	if (!list_empty(&dd->sort_list)) {
+		deadline_move_to_dispatch(dd,list_entry_rq(dd->sort_list.next));
+		goto dispatch;
+	}
+
+	return NULL;
+}
+
+static void
+deadline_add_request(request_queue_t *q, struct request *rq, struct list_head *insert_here)
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
+static struct list_head *
+deadline_get_sort_head(request_queue_t *q, struct request *rq)
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
+	dd->dispatch = &q->queue_head;
+	dd->fifo_batch = fifo_batch;
+	dd->fifo_expire[READ] = read_expire;
+	dd->fifo_expire[WRITE] = write_expire;
+	dd->seek_cost = seek_cost;
+	dd->hash_valid_count = 1;
+	dd->fifo_check = READ;
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
+EXPORT_SYMBOL(iosched_deadline);
diff -urN -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.5.30/drivers/block/ll_rw_blk.c linux/drivers/block/ll_rw_blk.c
--- /opt/kernel/linux-2.5.30/drivers/block/ll_rw_blk.c	2002-08-01 23:16:07.000000000 +0200
+++ linux/drivers/block/ll_rw_blk.c	2002-08-02 09:21:44.000000000 +0200
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
@@ -2071,8 +2075,8 @@
 	queue_nr_requests = (total_ram >> 8) & ~15;	/* One per quarter-megabyte */
 	if (queue_nr_requests < 32)
 		queue_nr_requests = 32;
-	if (queue_nr_requests > 256)
-		queue_nr_requests = 256;
+	if (queue_nr_requests > 768)
+		queue_nr_requests = 768;
 
 	/*
 	 * Batch frees according to queue length
diff -urN -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.5.30/include/linux/elevator.h linux/include/linux/elevator.h
--- /opt/kernel/linux-2.5.30/include/linux/elevator.h	2002-08-01 23:16:03.000000000 +0200
+++ linux/include/linux/elevator.h	2002-07-30 09:15:00.000000000 +0200
@@ -63,6 +63,12 @@
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

--vkogqOf2sHV7VnPd--
