Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265229AbSJaNhM>; Thu, 31 Oct 2002 08:37:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265228AbSJaNhL>; Thu, 31 Oct 2002 08:37:11 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:62388 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S265225AbSJaNgu>;
	Thu, 31 Oct 2002 08:36:50 -0500
Date: Thu, 31 Oct 2002 14:43:15 +0100
From: Jens Axboe <axboe@suse.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [patch] deadline-ioscheduler rb-tree sort
Message-ID: <20021031134315.GC6549@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is something I whipped together the other day for testing the over
head of the O(N) insert scan that the deadline io scheduler does. So
instead of using a plain linked list, I adapted it to use an rb tree
since that was already available with the generic implementation in the
kernel.

Results are quite promising, overhead is down a lot. I'm not pushing
this for inclusion, just sending it out so others can test etc. Patch is
against 2.5.45.

===== drivers/block/ll_rw_blk.c 1.135 vs edited =====
--- 1.135/drivers/block/ll_rw_blk.c	Mon Oct 28 20:57:59 2002
+++ edited/drivers/block/ll_rw_blk.c	Thu Oct 31 14:31:09 2002
@@ -2175,8 +2183,8 @@
 	queue_nr_requests = (total_ram >> 9) & ~7;
 	if (queue_nr_requests < 16)
 		queue_nr_requests = 16;
-	if (queue_nr_requests > 128)
-		queue_nr_requests = 128;
+	if (queue_nr_requests > 512)
+		queue_nr_requests = 512;
 
 	batch_requests = queue_nr_requests / 8;
 	if (batch_requests > 8)
===== drivers/block/deadline-iosched.c 1.9 vs edited =====
--- 1.9/drivers/block/deadline-iosched.c	Tue Oct 29 12:19:59 2002
+++ edited/drivers/block/deadline-iosched.c	Thu Oct 31 10:48:09 2002
@@ -17,6 +17,7 @@
 #include <linux/init.h>
 #include <linux/compiler.h>
 #include <linux/hash.h>
+#include <linux/rbtree.h>
 
 /*
  * feel free to try other values :-). read_expire value is the timeout for
@@ -33,7 +34,7 @@
  */
 static int writes_starved = 2;
 
-static const int deadline_hash_shift = 8;
+static const int deadline_hash_shift = 10;
 #define DL_HASH_BLOCK(sec)	((sec) >> 3)
 #define DL_HASH_FN(sec)		(hash_long(DL_HASH_BLOCK((sec)), deadline_hash_shift))
 #define DL_HASH_ENTRIES		(1 << deadline_hash_shift)
@@ -48,19 +49,20 @@
 	/*
 	 * run time data
 	 */
-	struct list_head sort_list[2];	/* sorted listed */
+	struct rb_root rb_list[2];
 	struct list_head read_fifo;	/* fifo list */
 	struct list_head *dispatch;	/* driver dispatch queue */
 	struct list_head *hash;		/* request hash */
 	sector_t last_sector;		/* last sector sent to drive */
 	unsigned long hash_valid_count;	/* barrier hash count */
 	unsigned int starved;		/* writes starved */
+	unsigned int rb_entries;
 
 	/*
 	 * settings that change how the i/o scheduler behaves
 	 */
 	unsigned int fifo_batch;
-	unsigned long read_expire;
+	unsigned int read_expire;
 	unsigned int seek_cost;
 	unsigned int writes_starved;
 };
@@ -69,10 +71,24 @@
  * pre-request data.
  */
 struct deadline_rq {
-	struct list_head fifo;
+	/*
+	 * rbtree index, key is the starting offset
+	 */
+	struct rb_node rb_node;
+	sector_t rb_key;
+
+	struct request *request;
+
+	/*
+	 * request hash, key is the ending offset (for back merge lookup)
+	 */
 	struct list_head hash;
 	unsigned long hash_valid_count;
-	struct request *request;
+
+	/*
+	 * expire fifo
+	 */
+	struct list_head fifo;
 	unsigned long expires;
 };
 
@@ -81,23 +97,23 @@
 #define RQ_DATA(rq)	((struct deadline_rq *) (rq)->elevator_private)
 
 /*
- * rq hash
+ * the back merge hash support functions
  */
-static inline void __deadline_del_rq_hash(struct deadline_rq *drq)
+static inline void __deadline_hash_del(struct deadline_rq *drq)
 {
 	drq->hash_valid_count = 0;
 	list_del_init(&drq->hash);
 }
 
 #define ON_HASH(drq)	(drq)->hash_valid_count
-static inline void deadline_del_rq_hash(struct deadline_rq *drq)
+static inline void deadline_hash_del(struct deadline_rq *drq)
 {
 	if (ON_HASH(drq))
-		__deadline_del_rq_hash(drq);
+		__deadline_hash_del(drq);
 }
 
 static inline void
-deadline_add_rq_hash(struct deadline_data *dd, struct deadline_rq *drq)
+deadline_hash_add(struct deadline_data *dd, struct deadline_rq *drq)
 {
 	struct request *rq = drq->request;
 
@@ -109,33 +125,30 @@
 
 #define list_entry_hash(ptr)	list_entry((ptr), struct deadline_rq, hash)
 static struct request *
-deadline_find_hash(struct deadline_data *dd, sector_t offset)
+deadline_hash_find(struct deadline_data *dd, sector_t offset)
 {
 	struct list_head *hash_list = &dd->hash[DL_HASH_FN(offset)];
 	struct list_head *entry, *next = hash_list->next;
-	struct deadline_rq *drq;
-	struct request *rq = NULL;
 
 	while ((entry = next) != hash_list) {
+		struct deadline_rq *drq = list_entry_hash(entry);
+		struct request *__rq = drq->request;
+
 		next = entry->next;
 		
-		drq = list_entry_hash(entry);
-
 		BUG_ON(!drq->hash_valid_count);
 
-		if (!rq_mergeable(drq->request)
+		if (!rq_mergeable(__rq)
 		    || drq->hash_valid_count != dd->hash_valid_count) {
-			__deadline_del_rq_hash(drq);
+			__deadline_hash_del(drq);
 			continue;
 		}
 
-		if (drq->request->sector + drq->request->nr_sectors == offset) {
-			rq = drq->request;
-			break;
-		}
+		if (__rq->sector + __rq->nr_sectors == offset)
+			return __rq;
 	}
 
-	return rq;
+	return NULL;
 }
 
 static sector_t deadline_get_last_sector(struct deadline_data *dd)
@@ -154,86 +167,135 @@
 	return last_sec;
 }
 
+/*
+ * rb tree support functions
+ */
+#define RB_NONE		(2)
+#define RB_EMPTY(root)	((root)->rb_node == NULL)
+#define ON_RB(node)	((node)->rb_color != RB_NONE)
+#define RB_CLEAR(node)	((node)->rb_color = RB_NONE)
+#define deadline_rb_entry(node)	rb_entry((node), struct deadline_rq, rb_node)
+#define DRQ_RB_ROOT(dd, drq)	(&(dd)->rb_list[rq_data_dir((drq)->request)])
+
+static inline int
+__deadline_rb_add(struct deadline_data *dd, struct deadline_rq *drq)
+{
+	struct rb_node **p = &DRQ_RB_ROOT(dd, drq)->rb_node;
+	struct rb_node *parent = NULL;
+	struct deadline_rq *__drq;
+
+	while (*p) {
+		parent = *p;
+		__drq = deadline_rb_entry(parent);
+
+		if (drq->rb_key < __drq->rb_key)
+			p = &(*p)->rb_left;
+		else if (drq->rb_key > __drq->rb_key)
+			p = &(*p)->rb_right;
+		else
+			return 1;
+	}
+
+	rb_link_node(&drq->rb_node, parent, p);
+	return 0;
+}
+
+static void deadline_rb_add(struct deadline_data *dd, struct deadline_rq *drq)
+{
+	drq->rb_key = drq->request->sector;
+
+	if (!__deadline_rb_add(dd, drq)) {
+		rb_insert_color(&drq->rb_node, DRQ_RB_ROOT(dd, drq));
+		dd->rb_entries++;
+		return;
+	}
+
+	/*
+	 * this cannot happen
+	 */
+	blk_dump_rq_flags(drq->request, "deadline_rb_add alias");
+	list_add_tail(&drq->request->queuelist, dd->dispatch);
+}
+
+static inline void
+deadline_rb_del(struct deadline_data *dd, struct deadline_rq *drq)
+{
+	if (ON_RB(&drq->rb_node)) {
+		rb_erase(&drq->rb_node, DRQ_RB_ROOT(dd, drq));
+		RB_CLEAR(&drq->rb_node);
+		dd->rb_entries--;
+		BUG_ON(dd->rb_entries < 0);
+	}
+}
+
+static struct request *
+deadline_rb_find(struct deadline_data *dd, sector_t sector, int data_dir)
+{
+	struct rb_node *n = dd->rb_list[data_dir].rb_node;
+	struct deadline_rq *drq;
+
+	while (n) {
+		drq = deadline_rb_entry(n);
+
+		if (sector < drq->rb_key)
+			n = n->rb_left;
+		else if (sector > drq->rb_key)
+			n = n->rb_right;
+		else
+			return drq->request;
+	}
+
+	return NULL;
+}
+
 static int
 deadline_merge(request_queue_t *q, struct list_head **insert, struct bio *bio)
 {
 	struct deadline_data *dd = q->elevator.elevator_data;
-	const int data_dir = bio_data_dir(bio);
-	struct list_head *entry, *sort_list;
-	struct request *__rq;
 	int ret = ELEVATOR_NO_MERGE;
+	struct request *__rq;
 
 	/*
 	 * try last_merge to avoid going to hash
 	 */
 	ret = elv_try_last_merge(q, bio);
 	if (ret != ELEVATOR_NO_MERGE) {
-		*insert = q->last_merge;
+		__rq = list_entry_rq(q->last_merge);
 		goto out;
 	}
 
 	/*
 	 * see if the merge hash can satisfy a back merge
 	 */
-	if ((__rq = deadline_find_hash(dd, bio->bi_sector))) {
+	if ((__rq = deadline_hash_find(dd, bio->bi_sector))) {
 		BUG_ON(__rq->sector + __rq->nr_sectors != bio->bi_sector);
 
 		if (elv_rq_merge_ok(__rq, bio)) {
-			*insert = &__rq->queuelist;
 			ret = ELEVATOR_BACK_MERGE;
 			goto out;
 		}
 	}
 
 	/*
-	 * scan list from back to find insertion point.
+	 * probably not worth the extra overhead
 	 */
-	entry = sort_list = &dd->sort_list[data_dir];
-	while ((entry = entry->prev) != sort_list) {
-		__rq = list_entry_rq(entry);
-
-		BUG_ON(__rq->flags & REQ_STARTED);
-
-		if (!(__rq->flags & REQ_CMD))
-			continue;
+	__rq = deadline_rb_find(dd, bio->bi_sector + bio_sectors(bio), bio_data_dir(bio));
+	if (__rq) {
+		BUG_ON(bio->bi_sector + bio_sectors(bio) != __rq->sector);
 
-		/*
-		 * it's not necessary to break here, and in fact it could make
-		 * us loose a front merge. emperical evidence shows this to
-		 * be a big waste of cycles though, so quit scanning
-		 */
-		if (!*insert && bio_rq_in_between(bio, __rq, sort_list)) {
-			*insert = &__rq->queuelist;
-			break;
-		}
-
-		if (__rq->flags & REQ_BARRIER)
-			break;
-
-		/*
-		 * checking for a front merge, hash will miss those
-		 */
-		if (__rq->sector - bio_sectors(bio) == bio->bi_sector) {
-			ret = elv_try_merge(__rq, bio);
-			if (ret != ELEVATOR_NO_MERGE) {
-				*insert = &__rq->queuelist;
-				break;
-			}
+		if (elv_rq_merge_ok(__rq, bio)) {
+			ret = ELEVATOR_FRONT_MERGE;
+			goto out;
 		}
 	}
 
-	/*
-	 * no insertion point found, check the very front
-	 */
-	if (!*insert && !list_empty(sort_list)) {
-		__rq = list_entry_rq(sort_list->next);
-
-		if (bio->bi_sector + bio_sectors(bio) < __rq->sector &&
-		    bio->bi_sector > deadline_get_last_sector(dd))
-			*insert = sort_list;
+	*insert = NULL;
+out:
+	if (ret != ELEVATOR_NO_MERGE) {
+		*insert = &__rq->queuelist;
+		q->last_merge = &__rq->queuelist;
 	}
 
-out:
 	return ret;
 }
 
@@ -242,8 +304,16 @@
 	struct deadline_data *dd = q->elevator.elevator_data;
 	struct deadline_rq *drq = RQ_DATA(req);
 
-	deadline_del_rq_hash(drq);
-	deadline_add_rq_hash(dd, drq);
+	deadline_hash_del(drq);
+	deadline_hash_add(dd, drq);
+
+	/*
+	 * the merge was a front merge, we need to reposition request
+	 */
+	if (req->sector != drq->rb_key) {
+		deadline_rb_del(dd, drq);
+		deadline_rb_add(dd, drq);
+	}
 
 	q->last_merge = &req->queuelist;
 }
@@ -258,8 +328,13 @@
 	BUG_ON(!drq);
 	BUG_ON(!dnext);
 
-	deadline_del_rq_hash(drq);
-	deadline_add_rq_hash(dd, drq);
+	deadline_hash_del(drq);
+	deadline_hash_add(dd, drq);
+
+	if (req->sector != drq->rb_key) {
+		deadline_rb_del(dd, drq);
+		deadline_rb_add(dd, drq);
+	}
 
 	/*
 	 * if dnext expires before drq, assign it's expire time to drq
@@ -274,16 +349,16 @@
 }
 
 /*
- * move request from sort list to dispatch queue. maybe remove from rq hash
- * here too?
+ * move request from sort list to dispatch queue.
  */
 static inline void
 deadline_move_to_dispatch(struct deadline_data *dd, struct request *rq)
 {
 	struct deadline_rq *drq = RQ_DATA(rq);
 
-	list_move_tail(&rq->queuelist, dd->dispatch);
+	deadline_rb_del(dd, drq);
 	list_del_init(&drq->fifo);
+	list_add_tail(&rq->queuelist, dd->dispatch);
 }
 
 /*
@@ -291,12 +366,12 @@
  */
 static void deadline_move_requests(struct deadline_data *dd, struct request *rq)
 {
-	struct list_head *sort_head = &dd->sort_list[rq_data_dir(rq)];
 	sector_t last_sec = deadline_get_last_sector(dd);
 	int batch_count = dd->fifo_batch;
+	struct deadline_rq *drq = RQ_DATA(rq);
 
 	do {
-		struct list_head *nxt = rq->queuelist.next;
+		struct rb_node *rbnext = rb_next(&drq->rb_node);
 		int this_rq_cost;
 
 		/*
@@ -308,7 +383,7 @@
 		/*
 		 * if this is the last entry, don't bother doing accounting
 		 */
-		if (nxt == sort_head)
+		if (rbnext == NULL)
 			break;
 
 		this_rq_cost = dd->seek_cost;
@@ -320,7 +395,8 @@
 			break;
 
 		last_sec = rq->sector + rq->nr_sectors;
-		rq = list_entry_rq(nxt);
+		drq = deadline_rb_entry(rbnext);
+		rq = drq->request;
 	} while (1);
 }
 
@@ -343,25 +419,11 @@
 	return 0;
 }
 
-static struct request *deadline_next_request(request_queue_t *q)
+static int deadline_dispatch_requests(struct deadline_data *dd)
 {
-	struct deadline_data *dd = q->elevator.elevator_data;
+	const int writes = !RB_EMPTY(&dd->rb_list[WRITE]);
 	struct deadline_rq *drq;
-	struct list_head *nxt;
-	struct request *rq;
-	int writes;
-
-	/*
-	 * if still requests on the dispatch queue, just grab the first one
-	 */
-	if (!list_empty(&q->queue_head)) {
-dispatch:
-		rq = list_entry_rq(q->queue_head.next);
-		dd->last_sector = rq->sector + rq->nr_sectors;
-		return rq;
-	}
-
-	writes = !list_empty(&dd->sort_list[WRITE]);
+	int ret = 0;
 
 	/*
 	 * if we have expired entries on the fifo list, move some to dispatch
@@ -370,19 +432,20 @@
 		if (writes && (dd->starved++ >= dd->writes_starved))
 			goto dispatch_writes;
 
-		nxt = dd->read_fifo.next;
-		drq = list_entry_fifo(nxt);
+		drq = list_entry_fifo(dd->read_fifo.next);
 		deadline_move_requests(dd, drq->request);
-		goto dispatch;
+		ret = 1;
+		goto out;
 	}
 
-	if (!list_empty(&dd->sort_list[READ])) {
+	if (!RB_EMPTY(&dd->rb_list[READ])) {
 		if (writes && (dd->starved++ >= dd->writes_starved))
 			goto dispatch_writes;
 
-		nxt = dd->sort_list[READ].next;
-		deadline_move_requests(dd, list_entry_rq(nxt));
-		goto dispatch;
+		drq = deadline_rb_entry(rb_first(&dd->rb_list[READ]));
+		deadline_move_requests(dd, drq->request);
+		ret = 1;
+		goto out;
 	}
 
 	/*
@@ -391,14 +454,41 @@
 	 */
 	if (writes) {
 dispatch_writes:
-		nxt = dd->sort_list[WRITE].next;
-		deadline_move_requests(dd, list_entry_rq(nxt));
+		drq = deadline_rb_entry(rb_first(&dd->rb_list[WRITE]));
+		deadline_move_requests(dd, drq->request);
 		dd->starved = 0;
-		goto dispatch;
+		ret = 1;
 	}
 
-	BUG_ON(!list_empty(&dd->sort_list[READ]));
-	BUG_ON(writes);
+out:
+	return ret;
+}
+
+static struct request *deadline_next_request(request_queue_t *q)
+{
+	struct deadline_data *dd = q->elevator.elevator_data;
+	struct request *rq;
+
+	/*
+	 * if there are still requests on the dispatch queue, grab the first one
+	 */
+	if (!list_empty(&q->queue_head)) {
+dispatch:
+		rq = list_entry_rq(q->queue_head.next);
+		dd->last_sector = rq->sector + rq->nr_sectors;
+		return rq;
+	}
+
+	if (deadline_dispatch_requests(dd))
+		goto dispatch;
+
+	/*
+	 * if we have entries on the read or write sorted list, its a bug
+	 * if deadline_dispatch_requests() didn't move any
+	 */
+	BUG_ON(!RB_EMPTY(&dd->rb_list[READ]));
+	BUG_ON(!RB_EMPTY(&dd->rb_list[WRITE]));
+
 	return NULL;
 }
 
@@ -409,28 +499,23 @@
 	struct deadline_rq *drq = RQ_DATA(rq);
 	const int data_dir = rq_data_dir(rq);
 
-	/*
-	 * flush hash on barrier insert, as not to allow merges before a
-	 * barrier.
-	 */
 	if (unlikely(rq->flags & REQ_BARRIER)) {
 		DL_INVALIDATE_HASH(dd);
 		q->last_merge = NULL;
 	}
 
-	/*
-	 * add to sort list
-	 */
-	if (!insert_here)
-		insert_here = dd->sort_list[data_dir].prev;
+	if (unlikely(!(rq->flags & REQ_CMD))) {
+		if (!insert_here)
+			insert_here = dd->dispatch->prev;
 
-	list_add(&rq->queuelist, insert_here);
-
-	if (unlikely(!(rq->flags & REQ_CMD)))
+		list_add(&rq->queuelist, insert_here);
 		return;
+	}
+
+	deadline_rb_add(dd, drq);
 
 	if (rq_mergeable(rq)) {
-		deadline_add_rq_hash(dd, drq);
+		deadline_hash_add(dd, drq);
 
 		if (!q->last_merge)
 			q->last_merge = &rq->queuelist;
@@ -443,15 +528,27 @@
 		drq->expires = jiffies + dd->read_expire;
 		list_add_tail(&drq->fifo, &dd->read_fifo);
 	}
+
+	/*
+	 * heuristic to offload the time spent moving entries interrupt
+	 * context. this happens when a driver queues a new request(s) from
+	 * its isr
+	 */
+#if 0
+	if (dd->rb_entries >= 8)
+		deadline_dispatch_requests(dd);
+#endif
 }
 
 static void deadline_remove_request(request_queue_t *q, struct request *rq)
 {
+	struct deadline_data *dd = q->elevator.elevator_data;
 	struct deadline_rq *drq = RQ_DATA(rq);
 
 	if (drq) {
 		list_del_init(&drq->fifo);
-		deadline_del_rq_hash(drq);
+		deadline_hash_del(drq);
+		deadline_rb_del(dd, drq);
 	}
 }
 
@@ -459,8 +556,8 @@
 {
 	struct deadline_data *dd = q->elevator.elevator_data;
 
-	if (!list_empty(&dd->sort_list[WRITE]) ||
-	    !list_empty(&dd->sort_list[READ]) ||
+	if (!RB_EMPTY(&dd->rb_list[WRITE]) ||
+	    !RB_EMPTY(&dd->rb_list[READ]) ||
 	    !list_empty(&q->queue_head))
 		return 0;
 
@@ -473,7 +570,7 @@
 {
 	struct deadline_data *dd = q->elevator.elevator_data;
 
-	return &dd->sort_list[rq_data_dir(rq)];
+	return dd->dispatch;
 }
 
 static void deadline_exit(request_queue_t *q, elevator_t *e)
@@ -484,8 +581,8 @@
 	int i;
 
 	BUG_ON(!list_empty(&dd->read_fifo));
-	BUG_ON(!list_empty(&dd->sort_list[READ]));
-	BUG_ON(!list_empty(&dd->sort_list[WRITE]));
+	BUG_ON(!RB_EMPTY(&dd->rb_list[READ]));
+	BUG_ON(!RB_EMPTY(&dd->rb_list[WRITE]));
 
 	for (i = READ; i <= WRITE; i++) {
 		struct request_list *rl = &q->rq[i];
@@ -538,8 +635,8 @@
 		INIT_LIST_HEAD(&dd->hash[i]);
 
 	INIT_LIST_HEAD(&dd->read_fifo);
-	INIT_LIST_HEAD(&dd->sort_list[READ]);
-	INIT_LIST_HEAD(&dd->sort_list[WRITE]);
+	dd->rb_list[READ] = RB_ROOT;
+	dd->rb_list[WRITE] = RB_ROOT;
 	dd->dispatch = &q->queue_head;
 	dd->fifo_batch = fifo_batch;
 	dd->read_expire = read_expire;
@@ -567,6 +664,7 @@
 			memset(drq, 0, sizeof(*drq));
 			INIT_LIST_HEAD(&drq->fifo);
 			INIT_LIST_HEAD(&drq->hash);
+			RB_CLEAR(&drq->rb_node);
 			drq->request = rq;
 			rq->elevator_private = drq;
 		}


-- 
Jens Axboe

