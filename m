Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317676AbSGZL7v>; Fri, 26 Jul 2002 07:59:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317678AbSGZL7v>; Fri, 26 Jul 2002 07:59:51 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:15488 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S317676AbSGZL7m>;
	Fri, 26 Jul 2002 07:59:42 -0400
Date: Fri, 26 Jul 2002 14:02:48 +0200
From: Jens Axboe <axboe@suse.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] block/elevator updates + deadline i/o scheduler
Message-ID: <20020726120248.GI14839@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="uAKRQypu60I7Lcqm"
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

The 2nd version of the deadline i/o scheduler is ready for some testing.
First patch make various changes to the elevator/block layer, that are
needed for the new i/o scheduler. Most of these are just correcting
assumptions about q->queue_head being the i/o scheduler sort list. In
detail:

o elevator_merge_requests_fn takes queue argument as well

o __make_request() inits insert_here to NULL instead of
  q->queue_head.prev, which means that the i/o schedulers must
  explicitly check for this condition now.

o incorporate elv_queue_empty(), it was just a place holder before

o add elv_get_sort_head(). it returns the sort head of the elevator for
  a given request. attempt_{back,front}_merge uses it to determine
  whether a request is valid or not. Maybe attempt_{back,front}_merge
  should just be killed, I doubt they have much relevance with the wake
  up batching.

o call the merge_cleanup functions of the elevator _after_ the merge has
  been done, not before. This way the elevator functions get the new
  state of the request, which is the most interesting.

o Kill extra nr_sectors check in ll_merge_requests_fn()

o bi_bi_bdev is always set in __make_request(), so kill check.

Once that is out of the way, we can plop the new i/o scheduler in. It's
not really ready for inclusion yet, due to a few 'issues':

o Barrier requests are not handled properly right now. This isn't a
  problem in the current kernel, but could be in the future.

o hard coded values

o hash probably needs a bit of work :-)

That said, how does it work? Well, the current Linux i/o schedulers use
q->queue_head as the main queue for both dispatch, sorting, and merging.
Pending requests are on that queue until the driver takes them off by
doing

	rq = elv_next_request(q);
	blkdev_dequeue_request(rq);
	/* now dispatch to hardware */

The layout of the deadline i/o scheduler is roughly:

	[1]       [2]
         |         |
         |         |
         |         |
         ====[3]====
              |
              |
              |
              |
             [4]

where [1] is the regular ascendingly sorted pending list of requests,
[2] is a fifo list (well really two lists, one for reads and one for
writes) of pending requests which each have an expire time assigned, [3]
is the elv_next_request() worker, and [4] is the dispatch queue
(q->queue_head again). When a request enters the i/o scheduler, it is
sorted into the [1] list, assigned an expire time, and sorted into the
fifo list [2] (the fifo list is really two lists, one for reads and one
for writes).

[1] is the main list where we serve requests from. If a request deadline
gets exceeded, we move a number of entries (known as the 'fifo_batch'
count) from the sorted list starting from the expired entry onto the
dispatch queue. This makes sure that we at least attempt to start an
expired request immediately, but don't completely fall back to FCFS i/o
scheduling (well set fifo_batch == 1, and you will get FCFS with an
appropriately low expire time).

So the tunables in this i/o scheduler are:

o READ fifo_expire. Attemt to start a READ before this time. Set to 1
  second in the patch.

o WRITE fifo_expire. Ditto for writes. Set to 8 seconds in the patch.

o fifo_batch. See above explanation. Set to 8 in the patch.

I was too lazy to make them run time changable in this version, so you
have to edit deadline-iosched.c to set them.

This version also includes a request merge hash. On back merging a bio
into an existing request, we can potentially save a queue scan by just
finding the rq in the hash. This is similar in idea to the bio hash that
was in the first 2.5.1-pre patches, only works on a request instead (ie
isn't broken like the bio version :-). I resurrected this idea when
Bartlomiej brought it up last week. I only added a back merge hash,
since previous expirements showed that 90% or more merge hits are back
merge hits. We will still check front merges, but only doing the scan
itself. I should do new statistics on this :-)

Finally, I've done some testing on it. No testing on whether this really
works well in real life (that's what I want testers to do), and no
testing on benchmark performance changes etc. What I have done is
beat-up testing, making sure it works without corrupting your data. I'm
fairly confident that does. Most testing was on SCSI (naturally),
however IDE has also been tested briefly.

On to the patches (I'm loosing track of this email). Both are attached.

elv-queue_head-misc-1
	elevator/block misc changes mentioned. This has gone to Linus
	for 2.5.28 inclusion

deadline-iosched-5
	the deadline i/o scheduler

-- 
Jens Axboe


--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=elv-queue_head-misc-1

diff -urN -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.5.28/drivers/block/elevator.c linux/drivers/block/elevator.c
--- /opt/kernel/linux-2.5.28/drivers/block/elevator.c	Wed Jul 24 23:03:30 2002
+++ linux/drivers/block/elevator.c	Fri Jul 26 11:05:00 2002
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
diff -urN -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.5.28/drivers/block/ll_rw_blk.c linux/drivers/block/ll_rw_blk.c
--- /opt/kernel/linux-2.5.28/drivers/block/ll_rw_blk.c	Wed Jul 24 23:03:20 2002
+++ linux/drivers/block/ll_rw_blk.c	Fri Jul 26 12:25:14 2002
@@ -1350,7 +1354,6 @@
 
 	if (rq_data_dir(req) != rq_data_dir(next)
 	    || !kdev_same(req->rq_dev, next->rq_dev)
-	    || req->nr_sectors + next->nr_sectors > q->max_sectors
 	    || next->waiting || next->special)
 		return;
 
@@ -1361,15 +1364,14 @@
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
 		blkdev_release_request(next);
 	}
 }
@@ -1377,16 +1379,18 @@
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
 
@@ -1446,7 +1450,7 @@
 	spin_lock_irq(q->queue_lock);
 again:
 	req = NULL;
-	insert_here = q->queue_head.prev;
+	insert_here = NULL;
 
 	if (blk_queue_empty(q)) {
 		blk_plug_device(q);
@@ -1464,11 +1468,10 @@
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
@@ -1480,8 +1483,6 @@
 				break;
 			}
 
-			elv_merge_cleanup(q, req, nr_sectors);
-
 			bio->bi_next = req->bio;
 			req->bio = bio;
 			/*
@@ -1494,6 +1495,7 @@
 			req->hard_cur_sectors = cur_nr_sectors;
 			req->sector = req->hard_sector = sector;
 			req->nr_sectors = req->hard_nr_sectors += nr_sectors;
+			elv_merge_cleanup(q, req, nr_sectors);
 			drive_stat_acct(req, nr_sectors, 0);
 			attempt_front_merge(q, req);
 			goto out;
@@ -1562,9 +1564,7 @@
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
diff -urN -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.5.28/include/linux/elevator.h linux/include/linux/elevator.h
--- /opt/kernel/linux-2.5.28/include/linux/elevator.h	Wed Jul 24 23:03:18 2002
+++ linux/include/linux/elevator.h	Fri Jul 26 11:10:58 2002
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
@@ -72,6 +82,9 @@
 
 extern int elevator_init(request_queue_t *, elevator_t *, elevator_t);
 extern void elevator_exit(request_queue_t *, elevator_t *);
+extern inline int bio_rq_in_between(struct bio *, struct request *, struct list_head *);
+extern inline int elv_rq_merge_ok(struct request *, struct bio *);
+extern inline int elv_try_merge(struct request *, struct bio *);
 
 /*
  * Return values from elevator merger

--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=deadline-iosched-5

diff -urN -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.5.28/drivers/block/Makefile linux/drivers/block/Makefile
--- /opt/kernel/linux-2.5.28/drivers/block/Makefile	Wed Jul 24 23:03:31 2002
+++ linux/drivers/block/Makefile	Fri Jul 26 11:05:00 2002
@@ -10,7 +10,7 @@
 
 export-objs	:= elevator.o ll_rw_blk.o blkpg.o loop.o DAC960.o genhd.o block_ioctl.o
 
-obj-y	:= elevator.o ll_rw_blk.o blkpg.o genhd.o block_ioctl.o
+obj-y	:= elevator.o ll_rw_blk.o blkpg.o genhd.o block_ioctl.o deadline-iosched.o
 
 obj-$(CONFIG_MAC_FLOPPY)	+= swim3.o
 obj-$(CONFIG_BLK_DEV_FD)	+= floppy.o
diff -urN -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.5.28/drivers/block/deadline-iosched.c linux/drivers/block/deadline-iosched.c
--- /opt/kernel/linux-2.5.28/drivers/block/deadline-iosched.c	Thu Jan  1 01:00:00 1970
+++ linux/drivers/block/deadline-iosched.c	Fri Jul 26 13:34:52 2002
@@ -0,0 +1,430 @@
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
+
+/*
+ * feel free to try other values :-). *_expire values are the timeouts
+ * for reads and writes, our goal is to start a request "around" the time
+ * when it expires. fifo_batch is how many steps along the sorted list we
+ * will take when the front fifo request expires.
+ */
+static int read_expire = HZ;
+static int write_expire = 8 * HZ;
+static int fifo_batch = 8;
+
+static const int deadline_hash_shift = 6;
+#define DL_HASH_MASK	((1 << deadline_hash_shift) - 1)
+#define DL_HASH_FN(sec)	(((sec) >> 3) & DL_HASH_MASK)
+#define DL_HASH_ENTRIES	(1 << deadline_hash_shift)
+
+struct deadline_data {
+	struct list_head sort_list;
+	struct list_head fifo_list[2];
+	struct list_head *hash;
+	unsigned int fifo_batch;
+	unsigned long fifo_expire[2];
+};
+
+struct deadline_rq {
+	struct list_head fifo;
+	struct list_head hash;
+	struct request *request;
+	unsigned long expires;
+};
+
+static kmem_cache_t *drq_pool;
+
+#define RQ_DATA(rq)		((struct deadline_rq *) (rq)->elevator_private)
+
+inline void deadline_move_to_dispatch(request_queue_t *q, struct request *rq)
+{
+	struct deadline_rq *drq = RQ_DATA(rq);
+
+	list_move_tail(&rq->queuelist, &q->queue_head);
+	list_del_init(&drq->fifo);
+}
+
+#define list_entry_hash(ptr)	list_entry((ptr), struct deadline_rq, hash)
+struct request *deadline_find_hash(struct deadline_data *dd, sector_t offset)
+{
+	struct list_head *hash_list = &dd->hash[DL_HASH_FN(offset)];
+	struct list_head *entry = hash_list;
+	struct deadline_rq *drq;
+	struct request *rq = NULL;
+
+	while ((entry = entry->next) != hash_list) {
+		drq = list_entry_hash(entry);
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
+#define ON_HASH(drq)	!list_empty(&(drq)->hash)
+inline void deadline_del_rq_hash(struct deadline_rq *drq)
+{
+	if (ON_HASH(drq))
+		list_del_init(&drq->hash);
+}
+
+inline void deadline_add_rq_hash(struct deadline_data *dd,
+				 struct deadline_rq *drq)
+{
+	struct request *rq = drq->request;
+
+	BUG_ON(ON_HASH(drq));
+
+	list_add(&drq->hash, &dd->hash[DL_HASH_FN(rq->sector +rq->nr_sectors)]);
+}
+
+int deadline_merge(request_queue_t *q, struct request **req, struct bio *bio)
+{
+	struct deadline_data *dd = q->elevator.elevator_data;
+	struct list_head *entry = &dd->sort_list;
+	struct request *__rq;
+	int ret = ELEVATOR_NO_MERGE;
+
+	/*
+	 * see if the merge hash can satisfy a back merge
+	 */
+	if ((__rq = deadline_find_hash(dd, bio->bi_sector))) {
+		if (elv_rq_merge_ok(__rq, bio)) {
+			if (__rq->sector + __rq->nr_sectors == bio->bi_sector) {
+				*req = __rq;
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
+				ret = ELEVATOR_FRONT_MERGE;
+				break;
+			}
+		}
+	}
+
+out:
+	return ret;
+}
+
+void deadline_merge_cleanup(request_queue_t *q, struct request *req, int count)
+{
+	struct deadline_data *dd = q->elevator.elevator_data;
+	struct deadline_rq *drq = RQ_DATA(req);
+
+	deadline_del_rq_hash(drq);
+	deadline_add_rq_hash(dd, drq);
+}
+
+#define ON_FIFO(drq)	!list_empty(&(drq)->fifo)
+void deadline_merge_request(request_queue_t *q, struct request *req,
+			    struct request *next)
+{
+	struct deadline_data *dd = q->elevator.elevator_data;
+	struct deadline_rq *drq = RQ_DATA(req);
+	struct deadline_rq *dnext = RQ_DATA(next);
+
+	BUG_ON(!drq);
+	BUG_ON(!dnext);
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
+
+	deadline_del_rq_hash(drq);
+	deadline_add_rq_hash(dd, drq);
+}
+
+#define list_entry_fifo(ptr)	list_entry((ptr), struct deadline_rq, fifo)
+int deadline_check_fifo(request_queue_t *q, int ddir)
+{
+	struct deadline_data *dd = q->elevator.elevator_data;
+	struct list_head *fifo_list = &dd->fifo_list[ddir];
+	struct deadline_rq *drq;
+	struct request *rq;
+	int entries;
+
+	if (list_empty(fifo_list))
+		return 0;
+
+	drq = list_entry_fifo(fifo_list->next);
+	if (time_before(jiffies, drq->expires))
+		return 0;
+
+	rq = drq->request;
+	entries = dd->fifo_batch;
+	while (entries--) {
+		struct list_head *nxt = rq->queuelist.next;
+
+		/*
+		 * take it off the sort and fifo list, move
+		 * to dispatch queue
+		 */
+		deadline_move_to_dispatch(q, rq);
+
+		if (nxt == &dd->sort_list)
+			break;
+
+		rq = list_entry_rq(nxt);
+	}
+
+	/*
+	 * should be entries there now, at least 1
+	 */
+	return 1;
+}
+
+struct request *deadline_next_request(request_queue_t *q)
+{
+	struct deadline_data *dd = q->elevator.elevator_data;
+
+	/*
+	 * if still requests on the dispatch queue, just grab the first one
+	 */
+	if (!list_empty(&q->queue_head))
+dispatch:
+		return list_entry_rq(q->queue_head.next);
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
+void deadline_add_request(request_queue_t *q, struct request *rq, struct list_head *insert_here)
+{
+	struct deadline_data *dd = q->elevator.elevator_data;
+	struct deadline_rq *drq;
+
+	/*
+	 * insert barriers directly into the back of the dispatch queue,
+	 * don't use the sorted or fifo list for those
+	 */
+	if (unlikely(rq->flags & REQ_BARRIER)) {
+		list_add_tail(&rq->queuelist, &q->queue_head);
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
+}
+
+void deadline_remove_request(request_queue_t *q, struct request *rq)
+{
+	struct deadline_rq *drq = RQ_DATA(rq);
+
+	if (drq) {
+		list_del_init(&drq->fifo);
+		deadline_del_rq_hash(drq);
+	}
+}
+
+int deadline_queue_empty(request_queue_t *q)
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
+struct list_head *deadline_get_sort_head(request_queue_t *q, struct request *rq)
+{
+	struct deadline_data *dd = q->elevator.elevator_data;
+
+	return &dd->sort_list;
+}
+
+void deadline_exit(request_queue_t *q, elevator_t *e)
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
+int deadline_init(request_queue_t *q, elevator_t *e)
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
+			INIT_LIST_HEAD(&drq->fifo);
+			INIT_LIST_HEAD(&drq->hash);
+			drq->request = rq;
+			drq->expires = 0;
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
+int __init deadline_slab_setup(void)
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
+	.elevator_merge_req_fn =	deadline_merge_request,
+	.elevator_next_req_fn =		deadline_next_request,
+	.elevator_add_req_fn =		deadline_add_request,
+	.elevator_remove_req_fn =	deadline_remove_request,
+	.elevator_queue_empty_fn =	deadline_queue_empty,
+	.elevator_get_sort_head_fn =	deadline_get_sort_head,
+	.elevator_init_fn =		deadline_init,
+	.elevator_exit_fn =		deadline_exit,
+};
diff -urN -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.5.28/drivers/block/ll_rw_blk.c linux/drivers/block/ll_rw_blk.c
--- /opt/kernel/linux-2.5.28/drivers/block/ll_rw_blk.c	Wed Jul 24 23:03:20 2002
+++ linux/drivers/block/ll_rw_blk.c	Fri Jul 26 12:25:14 2002
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
@@ -2034,8 +2034,8 @@
 	queue_nr_requests = (total_ram >> 8) & ~15;	/* One per quarter-megabyte */
 	if (queue_nr_requests < 32)
 		queue_nr_requests = 32;
-	if (queue_nr_requests > 256)
-		queue_nr_requests = 256;
+	if (queue_nr_requests > 768)
+		queue_nr_requests = 768;
 
 	/*
 	 * Batch frees according to queue length
diff -urN -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.5.28/include/linux/elevator.h linux/include/linux/elevator.h
--- /opt/kernel/linux-2.5.28/include/linux/elevator.h	Wed Jul 24 23:03:18 2002
+++ linux/include/linux/elevator.h	Fri Jul 26 11:10:58 2002
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

--uAKRQypu60I7Lcqm--
