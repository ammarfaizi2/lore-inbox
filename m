Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262315AbTIEIbi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 04:31:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262319AbTIEIbi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 04:31:38 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:8320 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262315AbTIEIbU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 04:31:20 -0400
Date: Fri, 5 Sep 2003 10:31:06 +0200
From: Jens Axboe <axboe@suse.de>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix IO hangs
Message-ID: <20030905083106.GC6658@suse.de>
References: <3F5833BA.5090909@cyberone.com.au> <20030905070426.GP840@suse.de> <3F583861.6070109@cyberone.com.au> <20030905071852.GQ840@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030905071852.GQ840@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 05 2003, Jens Axboe wrote:
> > Jens, if insert_here is dead, there is no point to passing back a hint
> > because it can't get back to the elevator anyway.
> > 
> > I'd very much like to kill insert_here and be done with it. If another
> > io scheduler comes along with a good use for it then the writers can
> > come up with an elegant solution ;) Hey, if they know a NO_MERGE return
> > means an insert will soon happen under the same lock, they could keep
> > it cached privately.
> 
> Agree, lets just kill it off.

Here's the patch that kills it and its associated logic off completely.
Nick, I'm not too sure what the logic was for stopping anticipation in
as_insert_request() (the insert_here tests were somewhat convoluted :),
I've added what I think makes most sense: stop anticipating if someone
puts a request at the head of the dispatch list.

It also makes the *_insert_request strategies much easier to follow,
imo.

===== drivers/block/as-iosched.c 1.16 vs edited =====
--- 1.16/drivers/block/as-iosched.c	Thu Sep  4 08:40:09 2003
+++ edited/drivers/block/as-iosched.c	Fri Sep  5 10:16:42 2003
@@ -255,7 +255,7 @@
 {
 	as_del_arq_hash(arq);
 
-	if (q->last_merge == &arq->request->queuelist)
+	if (q->last_merge == arq->request)
 		q->last_merge = NULL;
 }
 
@@ -1347,50 +1347,42 @@
 }
 
 static void
-as_insert_request(request_queue_t *q, struct request *rq,
-			struct list_head *insert_here)
+as_insert_request(request_queue_t *q, struct request *rq, int where)
 {
 	struct as_data *ad = q->elevator.elevator_data;
 	struct as_rq *arq = RQ_DATA(rq);
 
-	if (unlikely(rq->flags & (REQ_HARDBARRIER|REQ_SOFTBARRIER))) {
+	if (unlikely(rq->flags & (REQ_HARDBARRIER|REQ_SOFTBARRIER)))
 		q->last_merge = NULL;
 
-		if (insert_here != ad->dispatch) {
+	switch (where) {
+		case ELEVATOR_INSERT_BACK:
 			while (ad->next_arq[REQ_SYNC])
 				as_move_to_dispatch(ad, ad->next_arq[REQ_SYNC]);
 
 			while (ad->next_arq[REQ_ASYNC])
 				as_move_to_dispatch(ad, ad->next_arq[REQ_ASYNC]);
-		}
-
-		if (!insert_here)
-			insert_here = ad->dispatch->prev;
-	}
-
-	if (unlikely(!blk_fs_request(rq))) {
-		if (!insert_here)
-			insert_here = ad->dispatch;
-	}
-
-	if (insert_here) {
-		list_add(&rq->queuelist, insert_here);
-
-		/* Stop anticipating - let this request get through */
-		if (list_empty(ad->dispatch))
+			list_add_tail(&rq->queuelist, ad->dispatch);
+			break;
+		case ELEVATOR_INSERT_FRONT:
+			list_add(&rq->queuelist, ad->dispatch);
 			as_antic_stop(ad);
-
-		return;
+			break;
+		case ELEVATOR_INSERT_SORT:
+			BUG_ON(!blk_fs_request(rq));
+			as_add_request(ad, arq);
+			break;
+		default:
+			printk("%s: bad insert point %d\n", __FUNCTION__,where);
+			return;
 	}
 
 	if (rq_mergeable(rq)) {
 		as_add_arq_hash(ad, arq);
 
 		if (!q->last_merge)
-			q->last_merge = &rq->queuelist;
+			q->last_merge = rq;
 	}
-
-	as_add_request(ad, arq);
 }
 
 /*
@@ -1438,7 +1430,7 @@
 }
 
 static int
-as_merge(request_queue_t *q, struct list_head **insert, struct bio *bio)
+as_merge(request_queue_t *q, struct request **req, struct bio *bio)
 {
 	struct as_data *ad = q->elevator.elevator_data;
 	sector_t rb_key = bio->bi_sector + bio_sectors(bio);
@@ -1450,7 +1442,7 @@
 	 */
 	ret = elv_try_last_merge(q, bio);
 	if (ret != ELEVATOR_NO_MERGE) {
-		__rq = list_entry_rq(q->last_merge);
+		__rq = q->last_merge;
 		goto out_insert;
 	}
 
@@ -1482,11 +1474,11 @@
 
 	return ELEVATOR_NO_MERGE;
 out:
-	q->last_merge = &__rq->queuelist;
+	q->last_merge = __rq;
 out_insert:
 	if (ret)
 		as_hot_arq_hash(ad, RQ_DATA(__rq));
-	*insert = &__rq->queuelist;
+	*req = __rq;
 	return ret;
 }
 
@@ -1514,7 +1506,7 @@
 		 */
 	}
 
-	q->last_merge = &req->queuelist;
+	q->last_merge = req;
 }
 
 static void
===== drivers/block/deadline-iosched.c 1.24 vs edited =====
--- 1.24/drivers/block/deadline-iosched.c	Thu Sep  4 08:40:09 2003
+++ edited/drivers/block/deadline-iosched.c	Fri Sep  5 10:27:56 2003
@@ -125,7 +125,7 @@
 {
 	deadline_del_drq_hash(drq);
 
-	if (q->last_merge == &drq->request->queuelist)
+	if (q->last_merge == drq->request)
 		q->last_merge = NULL;
 }
 
@@ -324,7 +324,7 @@
 }
 
 static int
-deadline_merge(request_queue_t *q, struct list_head **insert, struct bio *bio)
+deadline_merge(request_queue_t *q, struct request **req, struct bio *bio)
 {
 	struct deadline_data *dd = q->elevator.elevator_data;
 	struct request *__rq;
@@ -335,7 +335,7 @@
 	 */
 	ret = elv_try_last_merge(q, bio);
 	if (ret != ELEVATOR_NO_MERGE) {
-		__rq = list_entry_rq(q->last_merge);
+		__rq = q->last_merge;
 		goto out_insert;
 	}
 
@@ -371,11 +371,11 @@
 
 	return ELEVATOR_NO_MERGE;
 out:
-	q->last_merge = &__rq->queuelist;
+	q->last_merge = __rq;
 out_insert:
 	if (ret)
 		deadline_hot_drq_hash(dd, RQ_DATA(__rq));
-	*insert = &__rq->queuelist;
+	*req = __rq;
 	return ret;
 }
 
@@ -398,7 +398,7 @@
 		deadline_add_drq_rb(dd, drq);
 	}
 
-	q->last_merge = &req->queuelist;
+	q->last_merge = req;
 }
 
 static void
@@ -621,43 +621,40 @@
 }
 
 static void
-deadline_insert_request(request_queue_t *q, struct request *rq,
-			struct list_head *insert_here)
+deadline_insert_request(request_queue_t *q, struct request *rq, int where)
 {
 	struct deadline_data *dd = q->elevator.elevator_data;
 	struct deadline_rq *drq = RQ_DATA(rq);
 
-	if (unlikely(rq->flags & (REQ_HARDBARRIER|REQ_SOFTBARRIER))) {
+	if (unlikely(rq->flags & (REQ_HARDBARRIER | REQ_SOFTBARRIER))) {
 		DL_INVALIDATE_HASH(dd);
 		q->last_merge = NULL;
+	}
 
-		if (insert_here != dd->dispatch) {
+	switch (where) {
+		case ELEVATOR_INSERT_BACK:
 			while (deadline_dispatch_requests(dd))
 				;
-		}
-
-		if (!insert_here)
-			insert_here = dd->dispatch->prev;
-	}
-
-	if (unlikely(!blk_fs_request(rq))) {
-		if (!insert_here)
-			insert_here = dd->dispatch;
-	}
-
-	if (insert_here) {
-		list_add(&rq->queuelist, insert_here);
-		return;
+			list_add_tail(&rq->queuelist, dd->dispatch);
+			break;
+		case ELEVATOR_INSERT_FRONT:
+			list_add(&rq->queuelist, dd->dispatch);
+			break;
+		case ELEVATOR_INSERT_SORT:
+			BUG_ON(!blk_fs_request(rq));
+			deadline_add_request(dd, drq);
+			break;
+		default:
+			printk("%s: bad insert point %d\n", __FUNCTION__,where);
+			return;
 	}
 
 	if (rq_mergeable(rq)) {
 		deadline_add_drq_hash(dd, drq);
 
 		if (!q->last_merge)
-			q->last_merge = &rq->queuelist;
+			q->last_merge = rq;
 	}
-
-	deadline_add_request(dd, drq);
 }
 
 static int deadline_queue_empty(request_queue_t *q)
===== drivers/block/elevator.c 1.51 vs edited =====
--- 1.51/drivers/block/elevator.c	Thu Sep  4 08:40:09 2003
+++ edited/drivers/block/elevator.c	Fri Sep  5 10:13:05 2003
@@ -81,7 +81,7 @@
 inline int elv_try_last_merge(request_queue_t *q, struct bio *bio)
 {
 	if (q->last_merge)
-		return elv_try_merge(list_entry_rq(q->last_merge), bio);
+		return elv_try_merge(q->last_merge, bio);
 
 	return ELEVATOR_NO_MERGE;
 }
@@ -117,12 +117,12 @@
 	return 0;
 }
 
-int elv_merge(request_queue_t *q, struct list_head **entry, struct bio *bio)
+int elv_merge(request_queue_t *q, struct request **req, struct bio *bio)
 {
 	elevator_t *e = &q->elevator;
 
 	if (e->elevator_merge_fn)
-		return e->elevator_merge_fn(q, entry, bio);
+		return e->elevator_merge_fn(q, req, bio);
 
 	return ELEVATOR_NO_MERGE;
 }
@@ -140,7 +140,7 @@
 {
 	elevator_t *e = &q->elevator;
 
-	if (q->last_merge == &next->queuelist)
+	if (q->last_merge == next)
 		q->last_merge = NULL;
 
 	if (e->elevator_merge_req_fn)
@@ -156,29 +156,25 @@
 	if (q->elevator.elevator_requeue_req_fn)
 		q->elevator.elevator_requeue_req_fn(q, rq);
 	else
-		__elv_add_request(q, rq, 0, 0);
+		__elv_add_request(q, rq, ELEVATOR_INSERT_FRONT, 0);
 }
 
-void __elv_add_request(request_queue_t *q, struct request *rq, int at_end,
+void __elv_add_request(request_queue_t *q, struct request *rq, int where,
 		       int plug)
 {
-	struct list_head *insert = NULL;
-
-	if (!at_end)
-		insert = &q->queue_head;
 	if (plug)
 		blk_plug_device(q);
 
-	q->elevator.elevator_add_req_fn(q, rq, insert);
+	q->elevator.elevator_add_req_fn(q, rq, where);
 }
 
-void elv_add_request(request_queue_t *q, struct request *rq, int at_end,
+void elv_add_request(request_queue_t *q, struct request *rq, int where,
 		     int plug)
 {
 	unsigned long flags;
 
 	spin_lock_irqsave(q->queue_lock, flags);
-	__elv_add_request(q, rq, at_end, plug);
+	__elv_add_request(q, rq, where, plug);
 	spin_unlock_irqrestore(q->queue_lock, flags);
 }
 
@@ -200,7 +196,7 @@
 		 */
 		rq->flags |= REQ_STARTED;
 
-		if (&rq->queuelist == q->last_merge)
+		if (rq == q->last_merge)
 			q->last_merge = NULL;
 
 		if ((rq->flags & REQ_DONTPREP) || !q->prep_rq_fn)
@@ -238,7 +234,7 @@
 	 * deleted without ever being given to driver (merged with another
 	 * request).
 	 */
-	if (&rq->queuelist == q->last_merge)
+	if (rq == q->last_merge)
 		q->last_merge = NULL;
 
 	if (e->elevator_remove_req_fn)
===== drivers/block/ll_rw_blk.c 1.210 vs edited =====
--- 1.210/drivers/block/ll_rw_blk.c	Fri Sep  5 08:46:30 2003
+++ edited/drivers/block/ll_rw_blk.c	Fri Sep  5 09:46:39 2003
@@ -703,7 +703,7 @@
 			blk_queue_end_tag(q, rq);
 
 		rq->flags &= ~REQ_STARTED;
-		__elv_add_request(q, rq, 0, 0);
+		__elv_add_request(q, rq, ELEVATOR_INSERT_BACK, 0);
 	}
 }
 
@@ -1638,11 +1638,16 @@
 	if(reinsert) {
 		blk_requeue_request(q, rq);
 	} else {
+		int where = ELEVATOR_INSERT_BACK;
+
+		if (at_head)
+			where = ELEVATOR_INSERT_FRONT;
+
 		if (blk_rq_tagged(rq))
 			blk_queue_end_tag(q, rq);
 
 		drive_stat_acct(rq, rq->nr_sectors, 1);
-		__elv_add_request(q, rq, !at_head, 0);
+		__elv_add_request(q, rq, where, 0);
 	}
 	q->request_fn(q);
 	spin_unlock_irqrestore(q->queue_lock, flags);
@@ -1675,8 +1680,7 @@
  * queue lock is held and interrupts disabled, as we muck with the
  * request queue list.
  */
-static inline void add_request(request_queue_t * q, struct request * req,
-			       struct list_head *insert_here)
+static inline void add_request(request_queue_t * q, struct request * req)
 {
 	drive_stat_acct(req, req->nr_sectors, 1);
 
@@ -1687,7 +1691,7 @@
 	 * elevator indicated where it wants this request to be
 	 * inserted at elevator_merge time
 	 */
-	__elv_add_request_pos(q, req, insert_here);
+	__elv_add_request(q, req, ELEVATOR_INSERT_SORT, 0);
 }
  
 /*
@@ -1886,7 +1890,6 @@
 {
 	struct request *req, *freereq = NULL;
 	int el_ret, rw, nr_sectors, cur_nr_sectors, barrier, ra;
-	struct list_head *insert_here;
 	sector_t sector;
 
 	sector = bio->bi_sector;
@@ -1909,7 +1912,6 @@
 	ra = bio->bi_rw & (1 << BIO_RW_AHEAD);
 
 again:
-	insert_here = NULL;
 	spin_lock_irq(q->queue_lock);
 
 	if (elv_queue_empty(q)) {
@@ -1919,17 +1921,13 @@
 	if (barrier)
 		goto get_rq;
 
-	el_ret = elv_merge(q, &insert_here, bio);
+	el_ret = elv_merge(q, &req, bio);
 	switch (el_ret) {
 		case ELEVATOR_BACK_MERGE:
-			req = list_entry_rq(insert_here);
-
 			BUG_ON(!rq_mergeable(req));
 
-			if (!q->back_merge_fn(q, req, bio)) {
-				insert_here = &req->queuelist;
+			if (!q->back_merge_fn(q, req, bio))
 				break;
-			}
 
 			req->biotail->bi_next = bio;
 			req->biotail = bio;
@@ -1940,14 +1938,10 @@
 			goto out;
 
 		case ELEVATOR_FRONT_MERGE:
-			req = list_entry_rq(insert_here);
-
 			BUG_ON(!rq_mergeable(req));
 
-			if (!q->front_merge_fn(q, req, bio)) {
-				insert_here = req->queuelist.prev;
+			if (!q->front_merge_fn(q, req, bio))
 				break;
-			}
 
 			bio->bi_next = req->bio;
 			req->cbio = req->bio = bio;
@@ -2035,7 +2029,7 @@
 	req->rq_disk = bio->bi_bdev->bd_disk;
 	req->start_time = jiffies;
 
-	add_request(q, req, insert_here);
+	add_request(q, req);
 out:
 	if (freereq)
 		__blk_put_request(q, freereq);
===== drivers/block/noop-iosched.c 1.1 vs edited =====
--- 1.1/drivers/block/noop-iosched.c	Fri Aug 15 03:16:57 2003
+++ edited/drivers/block/noop-iosched.c	Fri Sep  5 09:51:43 2003
@@ -17,17 +17,15 @@
 /*
  * See if we can find a request that this buffer can be coalesced with.
  */
-int elevator_noop_merge(request_queue_t *q, struct list_head **insert,
+int elevator_noop_merge(request_queue_t *q, struct request **req,
 			struct bio *bio)
 {
 	struct list_head *entry = &q->queue_head;
 	struct request *__rq;
 	int ret;
 
-	if ((ret = elv_try_last_merge(q, bio))) {
-		*insert = q->last_merge;
+	if ((ret = elv_try_last_merge(q, bio)))
 		return ret;
-	}
 
 	while ((entry = entry->prev) != &q->queue_head) {
 		__rq = list_entry_rq(entry);
@@ -41,8 +39,8 @@
 			continue;
 
 		if ((ret = elv_try_merge(__rq, bio))) {
-			*insert = &__rq->queuelist;
-			q->last_merge = &__rq->queuelist;
+			*req = __rq;
+			q->last_merge = __rq;
 			return ret;
 		}
 	}
@@ -57,8 +55,13 @@
 }
 
 void elevator_noop_add_request(request_queue_t *q, struct request *rq,
-			       struct list_head *insert_here)
+			       int where)
 {
+	struct list_head *insert = q->queue_head.prev;
+
+	if (where == ELEVATOR_INSERT_FRONT)
+		insert = &q->queue_head;
+
 	list_add_tail(&rq->queuelist, &q->queue_head);
 
 	/*
@@ -67,7 +70,7 @@
 	if (rq->flags & REQ_HARDBARRIER)
 		q->last_merge = NULL;
 	else if (!q->last_merge)
-		q->last_merge = &rq->queuelist;
+		q->last_merge = rq;
 }
 
 struct request *elevator_noop_next_request(request_queue_t *q)
===== drivers/block/scsi_ioctl.c 1.33 vs edited =====
--- 1.33/drivers/block/scsi_ioctl.c	Mon Sep  1 21:24:06 2003
+++ edited/drivers/block/scsi_ioctl.c	Fri Sep  5 10:22:31 2003
@@ -68,7 +68,7 @@
 
 	rq->flags |= REQ_NOMERGE;
 	rq->waiting = &wait;
-	elv_add_request(q, rq, 1, 1);
+	elv_add_request(q, rq, ELEVATOR_INSERT_BACK, 1);
 	generic_unplug_device(q);
 	wait_for_completion(&wait);
 
===== drivers/ide/ide-io.c 1.18 vs edited =====
--- 1.18/drivers/ide/ide-io.c	Mon Aug 25 00:33:30 2003
+++ edited/drivers/ide/ide-io.c	Fri Sep  5 10:25:31 2003
@@ -1387,7 +1387,7 @@
 	unsigned long flags;
 	ide_hwgroup_t *hwgroup = HWGROUP(drive);
 	DECLARE_COMPLETION(wait);
-	int insert_end = 1, err;
+	int where = ELEVATOR_INSERT_BACK, err;
 	int must_wait = (action == ide_wait || action == ide_head_wait);
 
 #ifdef CONFIG_BLK_DEV_PDC4030
@@ -1419,10 +1419,10 @@
 	spin_lock_irqsave(&ide_lock, flags);
 	if (action == ide_preempt || action == ide_head_wait) {
 		hwgroup->rq = NULL;
-		insert_end = 0;
+		where = ELEVATOR_INSERT_FRONT;
 		rq->flags |= REQ_PREEMPT;
 	}
-	__elv_add_request(drive->queue, rq, insert_end, 0);
+	__elv_add_request(drive->queue, rq, where, 0);
 	ide_do_request(hwgroup, IDE_NO_IRQ);
 	spin_unlock_irqrestore(&ide_lock, flags);
 
===== include/linux/blkdev.h 1.125 vs edited =====
--- 1.125/include/linux/blkdev.h	Thu Sep  4 08:40:13 2003
+++ edited/include/linux/blkdev.h	Fri Sep  5 09:49:43 2003
@@ -270,7 +270,7 @@
 	 * Together with queue_head for cacheline sharing
 	 */
 	struct list_head	queue_head;
-	struct list_head	*last_merge;
+	struct request		*last_merge;
 	elevator_t		elevator;
 
 	/*
===== include/linux/elevator.h 1.28 vs edited =====
--- 1.28/include/linux/elevator.h	Fri Aug 29 10:10:36 2003
+++ edited/include/linux/elevator.h	Fri Sep  5 09:49:02 2003
@@ -1,7 +1,7 @@
 #ifndef _LINUX_ELEVATOR_H
 #define _LINUX_ELEVATOR_H
 
-typedef int (elevator_merge_fn) (request_queue_t *, struct list_head **,
+typedef int (elevator_merge_fn) (request_queue_t *, struct request **,
 				 struct bio *);
 
 typedef void (elevator_merge_req_fn) (request_queue_t *, struct request *, struct request *);
@@ -10,7 +10,7 @@
 
 typedef struct request *(elevator_next_req_fn) (request_queue_t *);
 
-typedef void (elevator_add_req_fn) (request_queue_t *, struct request *, struct list_head *);
+typedef void (elevator_add_req_fn) (request_queue_t *, struct request *, int);
 typedef int (elevator_queue_empty_fn) (request_queue_t *);
 typedef void (elevator_remove_req_fn) (request_queue_t *, struct request *);
 typedef void (elevator_requeue_req_fn) (request_queue_t *, struct request *);
@@ -62,7 +62,7 @@
  */
 extern void elv_add_request(request_queue_t *, struct request *, int, int);
 extern void __elv_add_request(request_queue_t *, struct request *, int, int);
-extern int elv_merge(request_queue_t *, struct list_head **, struct bio *);
+extern int elv_merge(request_queue_t *, struct request **, struct bio *);
 extern void elv_merge_requests(request_queue_t *, struct request *,
 			       struct request *);
 extern void elv_merged_request(request_queue_t *, struct request *);
@@ -79,9 +79,6 @@
 extern int elv_set_request(request_queue_t *, struct request *, int);
 extern void elv_put_request(request_queue_t *, struct request *);
 
-#define __elv_add_request_pos(q, rq, pos)	\
-	(q)->elevator.elevator_add_req_fn((q), (rq), (pos))
-
 /*
  * noop I/O scheduler. always merges, always inserts new request at tail
  */
@@ -115,5 +112,12 @@
 #define ELEVATOR_NO_MERGE	0
 #define ELEVATOR_FRONT_MERGE	1
 #define ELEVATOR_BACK_MERGE	2
+
+/*
+ * Insertion selection
+ */
+#define ELEVATOR_INSERT_FRONT	1
+#define ELEVATOR_INSERT_BACK	2
+#define ELEVATOR_INSERT_SORT	3
 
 #endif

-- 
Jens Axboe

