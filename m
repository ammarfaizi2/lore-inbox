Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262023AbSKHNw6>; Fri, 8 Nov 2002 08:52:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262033AbSKHNw6>; Fri, 8 Nov 2002 08:52:58 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:3285 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S262023AbSKHNwX>;
	Fri, 8 Nov 2002 08:52:23 -0500
Date: Fri, 8 Nov 2002 14:58:49 +0100
From: Jens Axboe <axboe@suse.de>
To: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@digeo.com>
Subject: Re: 2.5.46: ide-cd cdrecord success report
Message-ID: <20021108135849.GZ32005@suse.de>
References: <32851.62.65.205.175.1036691341.squirrel@webmail.starman.ee> <20021107180709.GB18866@www.kroptech.com> <32894.62.65.205.175.1036692849.squirrel@webmail.starman.ee> <20021108015316.GA1041@www.kroptech.com> <3DCB1D09.EE25507D@digeo.com> <20021108024905.GA10246@www.kroptech.com> <20021108080558.GR32005@suse.de> <20021108111428.F628@nightmaster.csn.tu-chemnitz.de> <20021108114318.GX32005@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021108114318.GX32005@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 08 2002, Jens Axboe wrote:
> > Would you like to make it tunable from user space somehow?
> 
> Yes of course, that has been the plan all along. I'm in fact doing that
> right now.

Here's a patch that includes that feature, puts the tunables in sysfs
(so you obviously need that mounted). In

/sys/block/<disk>/iosched

you will find (for the deadline scheduler):

bart:/sys/block # ls hda/iosched/
.  ..  fifo_batch  front_merges  read_expire  seek_cost  writes_starved

This patch also has the deadline rbtree changes. Since it's just a
prototype, I didn't bother extracting the bits.

Pat, there are a few bugs in sysfs writeable files. Al discovered that
sysfs_write_file doesn't return -EINVAL if not ->store is defined, which
means that user apps will repeatedly call write() for an unwriteable
file because it keeps returning 0. Irk. In addition, permission checks
are buggy as well. Try adding a file with just S_IRUGO. Opening such a
beast for writing will succeed just fine. I'm guessing not a whole lot
of writeable sysfs files exist yet? :-)

===== drivers/block/deadline-iosched.c 1.11 vs edited =====
--- 1.11/drivers/block/deadline-iosched.c	Fri Nov  8 10:01:37 2002
+++ edited/drivers/block/deadline-iosched.c	Fri Nov  8 14:51:05 2002
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
@@ -48,7 +49,7 @@
 	/*
 	 * run time data
 	 */
-	struct list_head sort_list[2];	/* sorted listed */
+	struct rb_root rb_list[2];
 	struct list_head read_fifo;	/* fifo list */
 	struct list_head *dispatch;	/* driver dispatch queue */
 	struct list_head *hash;		/* request hash */
@@ -60,19 +61,34 @@
 	 * settings that change how the i/o scheduler behaves
 	 */
 	unsigned int fifo_batch;
-	unsigned long read_expire;
+	unsigned int read_expire;
 	unsigned int seek_cost;
 	unsigned int writes_starved;
+	unsigned int front_merges;
 };
 
 /*
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
-		BUG_ON(!drq->hash_valid_count);
+		BUG_ON(!ON_HASH(drq));
 
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
 	struct request *__rq;
-	int ret = ELEVATOR_NO_MERGE;
+	int ret;
 
 	/*
 	 * try last_merge to avoid going to hash
 	 */
 	ret = elv_try_last_merge(q, bio);
 	if (ret != ELEVATOR_NO_MERGE) {
-		*insert = q->last_merge;
-		goto out;
+		__rq = list_entry_rq(q->last_merge);
+		goto out_insert;
 	}
 
 	/*
 	 * see if the merge hash can satisfy a back merge
 	 */
-	if ((__rq = deadline_find_hash(dd, bio->bi_sector))) {
+	__rq = deadline_hash_find(dd, bio->bi_sector);
+	if (__rq) {
 		BUG_ON(__rq->sector + __rq->nr_sectors != bio->bi_sector);
 
 		if (elv_rq_merge_ok(__rq, bio)) {
-			*insert = &__rq->queuelist;
 			ret = ELEVATOR_BACK_MERGE;
 			goto out;
 		}
 	}
 
 	/*
-	 * scan list from back to find insertion point.
+	 * check for front merge
 	 */
-	entry = sort_list = &dd->sort_list[data_dir];
-	while ((entry = entry->prev) != sort_list) {
-		__rq = list_entry_rq(entry);
+	if (dd->front_merges) {
+		sector_t rb_key = bio->bi_sector + bio_sectors(bio);
 
-		BUG_ON(__rq->flags & REQ_STARTED);
-
-		if (!(__rq->flags & REQ_CMD))
-			continue;
-
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
-		if (__rq->flags & (REQ_SOFTBARRIER | REQ_HARDBARRIER))
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
+		__rq = deadline_rb_find(dd, rb_key, bio_data_dir(bio));
+		if (__rq) {
+			BUG_ON(rb_key != __rq->sector);
+
+			if (elv_rq_merge_ok(__rq, bio)) {
+				ret = ELEVATOR_FRONT_MERGE;
+				goto out;
 			}
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
-	}
-
+	return ELEVATOR_NO_MERGE;
 out:
+	q->last_merge = &__rq->queuelist;
+out_insert:
+	*insert = &__rq->queuelist;
 	return ret;
 }
 
@@ -242,8 +304,19 @@
 	struct deadline_data *dd = q->elevator.elevator_data;
 	struct deadline_rq *drq = RQ_DATA(req);
 
-	deadline_del_rq_hash(drq);
-	deadline_add_rq_hash(dd, drq);
+	/*
+	 * hash always needs to be repositioned, key is end sector
+	 */
+	deadline_hash_del(drq);
+	deadline_hash_add(dd, drq);
+
+	/*
+	 * if the merge was a front merge, we need to reposition request
+	 */
+	if (req->sector != drq->rb_key) {
+		deadline_rb_del(dd, drq);
+		deadline_rb_add(dd, drq);
+	}
 
 	q->last_merge = &req->queuelist;
 }
@@ -258,11 +331,16 @@
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
-	 * if dnext expires before drq, assign it's expire time to drq
+	 * if dnext expires before drq, assign its expire time to drq
 	 * and move into dnext position (dnext will be deleted) in fifo
 	 */
 	if (!list_empty(&drq->fifo) && !list_empty(&dnext->fifo)) {
@@ -274,53 +352,56 @@
 }
 
 /*
- * move request from sort list to dispatch queue. maybe remove from rq hash
- * here too?
+ * move request from sort list to dispatch queue.
  */
 static inline void
-deadline_move_to_dispatch(struct deadline_data *dd, struct request *rq)
+deadline_move_to_dispatch(struct deadline_data *dd, struct deadline_rq *drq)
 {
-	struct deadline_rq *drq = RQ_DATA(rq);
-
-	list_move_tail(&rq->queuelist, dd->dispatch);
+	deadline_rb_del(dd, drq);
 	list_del_init(&drq->fifo);
+	list_add_tail(&drq->request->queuelist, dd->dispatch);
 }
 
 /*
- * move along sort list and move entries to dispatch queue, starting from rq
+ * move along sort list and move entries to dispatch queue, starting from drq
  */
-static void deadline_move_requests(struct deadline_data *dd, struct request *rq)
+static void deadline_move_requests(struct deadline_data *dd, struct deadline_rq *drq)
 {
-	struct list_head *sort_head = &dd->sort_list[rq_data_dir(rq)];
 	sector_t last_sec = deadline_get_last_sector(dd);
 	int batch_count = dd->fifo_batch;
 
 	do {
-		struct list_head *nxt = rq->queuelist.next;
+		struct rb_node *rbnext = rb_next(&drq->rb_node);
+		struct deadline_rq *dnext = NULL;
+		struct request *__rq;
 		int this_rq_cost;
 
+		if (rbnext)
+			dnext = deadline_rb_entry(rbnext);
+
 		/*
 		 * take it off the sort and fifo list, move
 		 * to dispatch queue
 		 */
-		deadline_move_to_dispatch(dd, rq);
+		deadline_move_to_dispatch(dd, drq);
 
 		/*
 		 * if this is the last entry, don't bother doing accounting
 		 */
-		if (nxt == sort_head)
+		if (dnext == NULL)
 			break;
 
+		__rq = drq->request;
 		this_rq_cost = dd->seek_cost;
-		if (rq->sector == last_sec)
-			this_rq_cost = (rq->nr_sectors + 255) >> 8;
+		if (__rq->sector == last_sec)
+			this_rq_cost = (__rq->nr_sectors + 255) >> 8;
 
 		batch_count -= this_rq_cost;
 		if (batch_count <= 0)
 			break;
 
-		last_sec = rq->sector + rq->nr_sectors;
-		rq = list_entry_rq(nxt);
+		last_sec = __rq->sector + __rq->nr_sectors;
+		drq = dnext;
 	} while (1);
 }
 
@@ -343,25 +424,10 @@
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
 
 	/*
 	 * if we have expired entries on the fifo list, move some to dispatch
@@ -370,19 +436,18 @@
 		if (writes && (dd->starved++ >= dd->writes_starved))
 			goto dispatch_writes;
 
-		nxt = dd->read_fifo.next;
-		drq = list_entry_fifo(nxt);
-		deadline_move_requests(dd, drq->request);
-		goto dispatch;
+		drq = list_entry_fifo(dd->read_fifo.next);
+dispatch_requests:
+		deadline_move_requests(dd, drq);
+		return 1;
 	}
 
-	if (!list_empty(&dd->sort_list[READ])) {
+	if (!RB_EMPTY(&dd->rb_list[READ])) {
 		if (writes && (dd->starved++ >= dd->writes_starved))
 			goto dispatch_writes;
 
-		nxt = dd->sort_list[READ].next;
-		deadline_move_requests(dd, list_entry_rq(nxt));
-		goto dispatch;
+		drq = deadline_rb_entry(rb_first(&dd->rb_list[READ]));
+		goto dispatch_requests;
 	}
 
 	/*
@@ -391,14 +456,40 @@
 	 */
 	if (writes) {
 dispatch_writes:
-		nxt = dd->sort_list[WRITE].next;
-		deadline_move_requests(dd, list_entry_rq(nxt));
 		dd->starved = 0;
-		goto dispatch;
+
+		drq = deadline_rb_entry(rb_first(&dd->rb_list[WRITE]));
+		goto dispatch_requests;
+	}
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
+	 * if there are still requests on the dispatch queue, grab the first one
+	 */
+	if (!list_empty(dd->dispatch)) {
+dispatch:
+		rq = list_entry_rq(dd->dispatch->next);
+		dd->last_sector = rq->sector + rq->nr_sectors;
+		return rq;
 	}
 
-	BUG_ON(!list_empty(&dd->sort_list[READ]));
-	BUG_ON(writes);
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
 
@@ -409,32 +500,28 @@
 	struct deadline_rq *drq = RQ_DATA(rq);
 	const int data_dir = rq_data_dir(rq);
 
-	/*
-	 * flush hash on barrier insert, as not to allow merges before a
-	 * barrier.
-	 */
 	if (unlikely(rq->flags & REQ_HARDBARRIER)) {
 		DL_INVALIDATE_HASH(dd);
 		q->last_merge = NULL;
 	}
 
-	/*
-	 * add to sort list
-	 */
-	if (!insert_here)
-		insert_here = dd->sort_list[data_dir].prev;
-
-	list_add(&rq->queuelist, insert_here);
+	if (unlikely(!(rq->flags & REQ_CMD))) {
+		if (!insert_here)
+			insert_here = dd->dispatch->prev;
 
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
-	}
+	} else
+		blk_dump_rq_flags(rq, "not mergeable");
 
 	if (data_dir == READ) {
 		/*
@@ -450,8 +537,11 @@
 	struct deadline_rq *drq = RQ_DATA(rq);
 
 	if (drq) {
+		struct deadline_data *dd = q->elevator.elevator_data;
+
 		list_del_init(&drq->fifo);
-		deadline_del_rq_hash(drq);
+		deadline_hash_del(drq);
+		deadline_rb_del(dd, drq);
 	}
 }
 
@@ -459,9 +549,9 @@
 {
 	struct deadline_data *dd = q->elevator.elevator_data;
 
-	if (!list_empty(&dd->sort_list[WRITE]) ||
-	    !list_empty(&dd->sort_list[READ]) ||
-	    !list_empty(&q->queue_head))
+	if (!RB_EMPTY(&dd->rb_list[WRITE]) ||
+	    !RB_EMPTY(&dd->rb_list[READ]) ||
+	    !list_empty(dd->dispatch))
 		return 0;
 
 	BUG_ON(!list_empty(&dd->read_fifo));
@@ -473,7 +563,7 @@
 {
 	struct deadline_data *dd = q->elevator.elevator_data;
 
-	return &dd->sort_list[rq_data_dir(rq)];
+	return dd->dispatch;
 }
 
 static void deadline_exit(request_queue_t *q, elevator_t *e)
@@ -484,8 +574,8 @@
 	int i;
 
 	BUG_ON(!list_empty(&dd->read_fifo));
-	BUG_ON(!list_empty(&dd->sort_list[READ]));
-	BUG_ON(!list_empty(&dd->sort_list[WRITE]));
+	BUG_ON(!RB_EMPTY(&dd->rb_list[READ]));
+	BUG_ON(!RB_EMPTY(&dd->rb_list[WRITE]));
 
 	for (i = READ; i <= WRITE; i++) {
 		struct request_list *rl = &q->rq[i];
@@ -538,14 +628,15 @@
 		INIT_LIST_HEAD(&dd->hash[i]);
 
 	INIT_LIST_HEAD(&dd->read_fifo);
-	INIT_LIST_HEAD(&dd->sort_list[READ]);
-	INIT_LIST_HEAD(&dd->sort_list[WRITE]);
+	dd->rb_list[READ] = RB_ROOT;
+	dd->rb_list[WRITE] = RB_ROOT;
 	dd->dispatch = &q->queue_head;
 	dd->fifo_batch = fifo_batch;
 	dd->read_expire = read_expire;
 	dd->seek_cost = seek_cost;
 	dd->hash_valid_count = 1;
 	dd->writes_starved = writes_starved;
+	dd->front_merges = 1;
 	e->elevator_data = dd;
 
 	for (i = READ; i <= WRITE; i++) {
@@ -567,6 +658,7 @@
 			memset(drq, 0, sizeof(*drq));
 			INIT_LIST_HEAD(&drq->fifo);
 			INIT_LIST_HEAD(&drq->hash);
+			RB_CLEAR(&drq->rb_node);
 			drq->request = rq;
 			rq->elevator_private = drq;
 		}
@@ -578,6 +670,139 @@
 	return ret;
 }
 
+struct deadline_fs_entry {
+	struct attribute attr;
+	ssize_t (*show)(elevator_t *, char *, size_t, loff_t);
+	ssize_t (*store)(elevator_t *, const char *, size_t, loff_t);
+};
+
+static ssize_t
+deadline_var_show(unsigned int var, char *page, size_t count, loff_t off)
+{
+	if (off)
+		return 0;
+
+	return sprintf(page, "%d\n", var);
+}
+
+static ssize_t
+deadline_var_store(unsigned int *var, const char *page, size_t count,loff_t off)
+{
+	char *p = (char *) page;
+
+	if (off)
+		return 0;
+
+	*var = simple_strtoul(p, &p, 10);
+	return count;
+}
+
+#define SHOW_FUNCTION(__FUNC, __VAR)					\
+static ssize_t __FUNC(elevator_t *e, char *page, size_t cnt, loff_t off) \
+{									\
+	struct deadline_data *dd = (e)->elevator_data;			\
+	return deadline_var_show(__VAR, (page), (cnt), (off));		\
+}
+
+SHOW_FUNCTION(deadline_fifo_show, dd->fifo_batch);
+SHOW_FUNCTION(deadline_readexpire_show, dd->read_expire);
+SHOW_FUNCTION(deadline_seekcost_show, dd->seek_cost);
+SHOW_FUNCTION(deadline_writesstarved_show, dd->writes_starved);
+SHOW_FUNCTION(deadline_frontmerges_show, dd->front_merges);
+#undef SHOW_FUNCTION
+
+#define STORE_FUNCTION(__FUNC, __VAR)					\
+static ssize_t __FUNC(elevator_t *e, const char *page, size_t cnt, loff_t off) \
+{									\
+	struct deadline_data *dd = (e)->elevator_data;			\
+	return deadline_var_store(__VAR, (page), (cnt), (off));		\
+}
+
+STORE_FUNCTION(deadline_fifo_store, &dd->fifo_batch);
+STORE_FUNCTION(deadline_readexpire_store, &dd->read_expire);
+STORE_FUNCTION(deadline_seekcost_store, &dd->seek_cost);
+STORE_FUNCTION(deadline_writesstarved_store, &dd->writes_starved);
+STORE_FUNCTION(deadline_frontmerges_store, &dd->front_merges);
+#undef STORE_FUNCTION
+
+static struct deadline_fs_entry deadline_fifo_entry = {
+	.attr = {.name = "fifo_batch", .mode = S_IRUGO | S_IWUSR },
+	.show = deadline_fifo_show,
+	.store = deadline_fifo_store,
+};
+static struct deadline_fs_entry deadline_readexpire_entry = {
+	.attr = {.name = "read_expire", .mode = S_IRUGO | S_IWUSR },
+	.show = deadline_readexpire_show,
+	.store = deadline_readexpire_store,
+};
+static struct deadline_fs_entry deadline_seekcost_entry = {
+	.attr = {.name = "seek_cost", .mode = S_IRUGO | S_IWUSR },
+	.show = deadline_seekcost_show,
+	.store = deadline_seekcost_store,
+};
+static struct deadline_fs_entry deadline_writesstarved_entry = {
+	.attr = {.name = "writes_starved", .mode = S_IRUGO | S_IWUSR },
+	.show = deadline_writesstarved_show,
+	.store = deadline_writesstarved_store,
+};
+static struct deadline_fs_entry deadline_frontmerges_entry = {
+	.attr = {.name = "front_merges", .mode = S_IRUGO | S_IWUSR },
+	.show = deadline_frontmerges_show,
+	.store = deadline_frontmerges_store,
+};
+
+static struct attribute *default_attrs[] = {
+	&deadline_fifo_entry.attr,
+	&deadline_readexpire_entry.attr,
+	&deadline_seekcost_entry.attr,
+	&deadline_writesstarved_entry.attr,
+	&deadline_frontmerges_entry.attr,
+	NULL,
+};
+
+static ssize_t deadline_attr_show(struct kobject *kobj, struct attribute *attr,
+				  char *page, size_t count, loff_t off)
+{
+	elevator_t *e = container_of(kobj, elevator_t, kobj);
+	struct deadline_fs_entry *entry = container_of(attr, struct deadline_fs_entry, attr);
+
+	if (!entry->show)
+		return 0;
+
+	return entry->show(e, page, count, off);
+}
+
+static ssize_t deadline_attr_store(struct kobject *kobj, struct attribute *attr,
+				   const char *page, size_t count, loff_t off)
+{
+	elevator_t *e = container_of(kobj, elevator_t, kobj);
+	struct deadline_fs_entry *entry = container_of(attr, struct deadline_fs_entry, attr);
+
+	if (!entry->store)
+		return -EINVAL;
+
+	return entry->store(e, page, count, off);
+}
+
+static struct sysfs_ops deadline_sysfs_ops = {
+	.show	= &deadline_attr_show,
+	.store	= &deadline_attr_store,
+};
+
+extern struct subsystem block_subsys;
+
+struct subsystem deadline_subsys = {
+	.parent		= &block_subsys,
+	.sysfs_ops	= &deadline_sysfs_ops,
+	.default_attrs	= default_attrs,
+};
+
+static void deadline_register_fs(elevator_t *e)
+{
+	e->kobj.subsys = &deadline_subsys;
+	kobject_register(&e->kobj);
+}
+
 static int __init deadline_slab_setup(void)
 {
 	drq_pool = kmem_cache_create("deadline_drq", sizeof(struct deadline_rq),
@@ -586,6 +811,7 @@
 	if (!drq_pool)
 		panic("deadline: can't init slab pool\n");
 
+	subsystem_register(&deadline_subsys);
 	return 0;
 }
 
@@ -600,6 +826,7 @@
 	.elevator_remove_req_fn =	deadline_remove_request,
 	.elevator_queue_empty_fn =	deadline_queue_empty,
 	.elevator_get_sort_head_fn =	deadline_get_sort_head,
+	.elevator_register_fs_fn =	deadline_register_fs,
 	.elevator_init_fn =		deadline_init,
 	.elevator_exit_fn =		deadline_exit,
 };
===== drivers/block/elevator.c 1.35 vs edited =====
--- 1.35/drivers/block/elevator.c	Fri Nov  8 09:57:28 2002
+++ edited/drivers/block/elevator.c	Fri Nov  8 14:17:31 2002
@@ -381,6 +381,19 @@
 	return &q->queue_head;
 }
 
+void elv_register_fs(struct gendisk *disk)
+{
+	request_queue_t *q = disk->queue;
+	elevator_t *e = &q->elevator;
+
+	kobject_init(&e->kobj);
+	snprintf(e->kobj.name, KOBJ_NAME_LEN, "%s", "iosched");
+	e->kobj.parent = &disk->kobj;
+
+	if (e->elevator_register_fs_fn)
+		e->elevator_register_fs_fn(e);
+}
+
 elevator_t elevator_noop = {
 	.elevator_merge_fn		= elevator_noop_merge,
 	.elevator_next_req_fn		= elevator_noop_next_request,
===== drivers/block/genhd.c 1.58 vs edited =====
--- 1.58/drivers/block/genhd.c	Mon Oct 21 09:53:07 2002
+++ edited/drivers/block/genhd.c	Fri Nov  8 12:56:16 2002
@@ -119,6 +119,7 @@
 	blk_register_region(MKDEV(disk->major, disk->first_minor), disk->minors,
 			NULL, exact_match, exact_lock, disk);
 	register_disk(disk);
+	elv_register_fs(disk);
 }
 
 EXPORT_SYMBOL(add_disk);
===== drivers/block/ll_rw_blk.c 1.139 vs edited =====
--- 1.139/drivers/block/ll_rw_blk.c	Fri Nov  8 09:57:28 2002
+++ edited/drivers/block/ll_rw_blk.c	Fri Nov  8 14:57:56 2002
@@ -73,7 +73,7 @@
 {
 	int ret;
 
-	ret = queue_nr_requests / 4 - 1;
+	ret = queue_nr_requests / 8 - 1;
 	if (ret < 0)
 		ret = 1;
 	return ret;
@@ -86,7 +86,7 @@
 {
 	int ret;
 
-	ret = queue_nr_requests / 4 + 1;
+	ret = queue_nr_requests / 8 + 1;
 	if (ret > queue_nr_requests)
 		ret = queue_nr_requests;
 	return ret;
@@ -700,31 +700,22 @@
 	seg_size = nr_phys_segs = nr_hw_segs = 0;
 	bio_for_each_segment(bv, bio, i) {
 		if (bvprv && cluster) {
-			int phys, seg;
-
-			if (seg_size + bv->bv_len > q->max_segment_size) {
-				nr_phys_segs++;
+			if (seg_size + bv->bv_len > q->max_segment_size)
 				goto new_segment;
-			}
-
-			phys = BIOVEC_PHYS_MERGEABLE(bvprv, bv);
-			seg = BIOVEC_SEG_BOUNDARY(q, bvprv, bv);
-			if (!phys || !seg)
-				nr_phys_segs++;
-			if (!seg)
+			if (!BIOVEC_PHYS_MERGEABLE(bvprv, bv))
 				goto new_segment;
-
-			if (!BIOVEC_VIRT_MERGEABLE(bvprv, bv))
+			if (!BIOVEC_SEG_BOUNDARY(q, bvprv, bv))
 				goto new_segment;
 
 			seg_size += bv->bv_len;
 			bvprv = bv;
 			continue;
-		} else {
-			nr_phys_segs++;
 		}
 new_segment:
-		nr_hw_segs++;
+		if (!bvprv || !BIOVEC_VIRT_MERGEABLE(bvprv, bv))
+			nr_hw_segs++;
+
+		nr_phys_segs++;
 		bvprv = bv;
 		seg_size = bv->bv_len;
 	}
@@ -1621,7 +1612,7 @@
 	struct list_head *next = rq->queuelist.next;
 	struct list_head *sort_head = elv_get_sort_head(q, rq);
 
-	if (next != sort_head)
+	if (next != sort_head && next != &rq->queuelist)
 		attempt_merge(q, rq, list_entry_rq(next));
 }
 
@@ -1630,7 +1621,7 @@
 	struct list_head *prev = rq->queuelist.prev;
 	struct list_head *sort_head = elv_get_sort_head(q, rq);
 
-	if (prev != sort_head)
+	if (prev != sort_head && prev != &rq->queuelist)
 		attempt_merge(q, list_entry_rq(prev), rq);
 }
 
@@ -2180,8 +2171,8 @@
 	queue_nr_requests = (total_ram >> 9) & ~7;
 	if (queue_nr_requests < 16)
 		queue_nr_requests = 16;
-	if (queue_nr_requests > 128)
-		queue_nr_requests = 128;
+	if (queue_nr_requests > 1024)
+		queue_nr_requests = 1024;
 
 	batch_requests = queue_nr_requests / 8;
 	if (batch_requests > 8)
===== fs/sysfs/inode.c 1.59 vs edited =====
--- 1.59/fs/sysfs/inode.c	Wed Oct 30 21:27:35 2002
+++ edited/fs/sysfs/inode.c	Fri Nov  8 14:33:59 2002
@@ -243,7 +243,7 @@
 	if (kobj && kobj->subsys)
 		ops = kobj->subsys->sysfs_ops;
 	if (!ops || !ops->store)
-		return 0;
+		return -EINVAL;
 
 	page = (char *)__get_free_page(GFP_KERNEL);
 	if (!page)
===== include/linux/elevator.h 1.17 vs edited =====
--- 1.17/include/linux/elevator.h	Mon Oct 28 18:51:57 2002
+++ edited/include/linux/elevator.h	Fri Nov  8 13:45:30 2002
@@ -18,6 +18,8 @@
 typedef int (elevator_init_fn) (request_queue_t *, elevator_t *);
 typedef void (elevator_exit_fn) (request_queue_t *, elevator_t *);
 
+typedef void (elevator_register_fs_fn) (elevator_t *);
+
 struct elevator_s
 {
 	elevator_merge_fn *elevator_merge_fn;
@@ -34,7 +36,11 @@
 	elevator_init_fn *elevator_init_fn;
 	elevator_exit_fn *elevator_exit_fn;
 
+	elevator_register_fs_fn *elevator_register_fs_fn;
+
 	void *elevator_data;
+
+	struct kobject kobj;
 };
 
 /*
@@ -49,6 +55,7 @@
 extern void elv_remove_request(request_queue_t *, struct request *);
 extern int elv_queue_empty(request_queue_t *);
 extern inline struct list_head *elv_get_sort_head(request_queue_t *, struct request *);
+extern void elv_register_fs(struct gendisk *);
 
 #define __elv_add_request_pos(q, rq, pos)	\
 	(q)->elevator.elevator_add_req_fn((q), (rq), (pos))


-- 
Jens Axboe

