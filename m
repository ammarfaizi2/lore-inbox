Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267522AbUIGIJS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267522AbUIGIJS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 04:09:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267708AbUIGIJS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 04:09:18 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:38854 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S267522AbUIGIDe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 04:03:34 -0400
Date: Tue, 7 Sep 2004 10:02:27 +0200
From: Jens Axboe <axboe@suse.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, kernel@kolivas.org
Subject: [PATCH] CFQ iosched v2
Message-ID: <20040907080227.GG6323@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here is the next incarnation of the CFQ io scheduler, so far known as
CFQ v2 locally. It attempts to address some of the limitations of the
original CFQ io scheduler (hence forth known as CFQ v1). Some of the
problems with CFQ v1 are:

- It does accounting for the lifetime of the cfq_queue, which is setup
  and torn down for the time when a process has io in flight. For a fork
  heavy work load (such as a kernel compile, for instance), new
  processes can effectively starve io of running processes. This is in
  part due to the fact that CFQ v1 gives preference to a new processes
  to get better latency numbers. Removing that heuristic is not an
  option exactly because of that.

- It makes no attempts to address inter-cfq_queue fairness.

- It makes no attempt to limit upper latency bound of a single request.

- It only provides per-tgid grouping. You need to change the source to
  group on a different criteria.

- It uses a mempool for the cfq_queues. Theoretically this could
  deadlock if io bound processes never exit.

- The may_queue() logic can be unfair since it fluctuates quickly, thus
  leaving processes sleeping while new processes are allowed to allocate
  a request.

CFQ v2 attempts to fix these issues. It uses the process io_context
logic to maintain a cfq_queue lifetime of the duration of the process
(and its io). This means we can now be a lot more clever in deciding
which process is allowed to queue or dispatch io to the device. The
cfq_io_context is per-process per-queue, this is an extension to what AS
currently does in that we truly do have a unique per-process identifier
for io grouping. Busy queues are sorted by service time used, sub sorted
by in_flight requests. Queues that have no io in flight are also
preferred at dispatch time.

Accounting is done on completion time of a request, or with a fixed cost
for tagged command queueing. Requests are fifo'ed like with deadline, to
make sure that a single request doesn't stay in the io scheduler for
ages.

Process grouping is selectable at runtime. I provide 4 grouping
criterias: process group, thread group id, user id, and group id.

As usual, settings are sysfs tweakable in /sys/block/<dev>/queue/iosched

axboe@apu:[.]s/block/hda/queue/iosched $ ls
back_seek_max      fifo_batch_expire  find_best_crq  queued
back_seek_penalty  fifo_expire_async  key_type       show_status
clear_elapsed      fifo_expire_sync   quantum        tagged

In order, each of these settings control:

back_seek_max
back_seek_penalty:
	Useful logic stolen from AS that allow small backwards seeks in
	the io stream if we deem them useful. CFQ uses a strict
	ascending elevator otherwise. _max controls the maximum allowed
	backwards seek, defaulting to 16MiB. _penalty denotes how
	expensive we account a backwards seek compared to a forward
	seek. Default is 2, meaning it's twice as expensive.

clear_elapsed:
	Really a debug switch, will go away in the future. It clears the
	maximum values for completion and dispatch time, shown in
	show_status.

fifo_batch_expire
fifo_batch_async
fifo_batch_sync:
	The settings for the expiry fifo. batch_expire is how often we
	allow the fifo expire to control which request to select.
	Default is 125ms. _async is the deadline for async requests
	(typically writes), _sync is the deadline for sync requests
	(reads and sync writes). Defaults are, respectively, 5 seconds
	and 0.5 seconds.

key_type:
	The grouping key. Can be set to pgid, tgid, uid, or gid. The
	current value is shown bracketed:

	axboe@apu:[.]s/block/hda/queue/iosched $ cat key_type 
	[pgid] tgid uid gid

	Default is tgid. To set, simply echo any of the 4 words into the
	file.

quantum:
	The amount of requests we select for dispatch when the driver
	asks for work to do and the current pending list is empty.
	Default is 4.

queued:
	The minimum amount of requests a group is allowed to queue.
	Default is 8.

show_status:
	Debug output showing the current state of the queues.

tagged:
	Set this to 1 if the device is using tagged command queueing.
	This cannot be reliably detected by CFQ yet, since most drivers
	don't use the block layer (well it could, by looking at number
	of requests being between dispatch and completion. but not
	completely reliably). Default is 0.

The patch is a little big, but works reliably here on my laptop. There
are a number of other changes and fixes in there (like converting to
hlist for hashes). The code is commented a lot better, CFQ v1 has
basically no comments (reflecting that it was writting in one go, no
touched or tuned much since then). This is of course only done to
increase the AAF, akpm acceptance factor. Since I'm on the road, I
cannot provide any really good numbers of CFQ v1 compared to v2, maybe
someone will help me out there.

Patch is against 2.6.9-rc1-bk (as of 20040906), probably applies fine to
2.6.9-rc1 vanilla or latest -mm.

Signed-off-by: Jens Axboe <axboe@suse.de>

===== drivers/block/as-iosched.c 1.38 vs edited =====
--- 1.38/drivers/block/as-iosched.c	2004-05-10 13:25:52 +02:00
+++ edited/drivers/block/as-iosched.c	2004-08-31 22:52:23 +02:00
@@ -1828,14 +1828,14 @@
 
 static int as_may_queue(request_queue_t *q, int rw)
 {
-	int ret = 0;
+	int ret = ELV_MQUEUE_MAY;
 	struct as_data *ad = q->elevator.elevator_data;
 	struct io_context *ioc;
 	if (ad->antic_status == ANTIC_WAIT_REQ ||
 			ad->antic_status == ANTIC_WAIT_NEXT) {
 		ioc = as_get_io_context();
 		if (ad->io_context == ioc)
-			ret = 1;
+			ret = ELV_MQUEUE_MUST;
 		put_io_context(ioc);
 	}
 
===== drivers/block/cfq-iosched.c 1.8 vs edited =====
--- 1.8/drivers/block/cfq-iosched.c	2004-07-14 11:47:10 +02:00
+++ edited/drivers/block/cfq-iosched.c	2004-09-06 23:09:25 +02:00
@@ -22,96 +22,214 @@
 #include <linux/rbtree.h>
 #include <linux/mempool.h>
 
+#undef CFQ_DEBUG
+
+#ifdef CFQ_DEBUG
+#define dprintk(fmt, args...) printk(KERN_ERR "cfq: " fmt, ##args)
+#else
+#define dprintk(fmt, args...)
+#endif
+
+static unsigned long max_elapsed_crq;
+static unsigned long max_elapsed_dispatch;
+
 /*
  * tunables
  */
-static int cfq_quantum = 4;
-static int cfq_queued = 8;
+static int cfq_quantum = 4;		/* max queue in one round of service */
+static int cfq_queued = 8;		/* minimum rq allocate limit per-queue*/
+static int cfq_service = HZ;		/* period over which service is avg */
+static int cfq_fifo_expire_r = HZ / 2;	/* fifo timeout for sync requests */
+static int cfq_fifo_expire_w = 5 * HZ;	/* fifo timeout for async requests */
+static int cfq_fifo_rate = HZ / 8;	/* fifo expiry rate */
+static int cfq_back_max = 16 * 1024;	/* maximum backwards seek, in KiB */
+static int cfq_back_penalty = 2;	/* penalty of a backwards seek */
 
+/*
+ * for the hash of cfqq inside the cfqd
+ */
 #define CFQ_QHASH_SHIFT		6
 #define CFQ_QHASH_ENTRIES	(1 << CFQ_QHASH_SHIFT)
-#define list_entry_qhash(entry)	list_entry((entry), struct cfq_queue, cfq_hash)
+#define list_entry_qhash(entry)	hlist_entry((entry), struct cfq_queue, cfq_hash)
 
-#define CFQ_MHASH_SHIFT		8
+/*
+ * for the hash of crq inside the cfqq
+ */
+#define CFQ_MHASH_SHIFT		6
 #define CFQ_MHASH_BLOCK(sec)	((sec) >> 3)
 #define CFQ_MHASH_ENTRIES	(1 << CFQ_MHASH_SHIFT)
-#define CFQ_MHASH_FN(sec)	(hash_long(CFQ_MHASH_BLOCK((sec)),CFQ_MHASH_SHIFT))
-#define ON_MHASH(crq)		!list_empty(&(crq)->hash)
+#define CFQ_MHASH_FN(sec)	hash_long(CFQ_MHASH_BLOCK(sec), CFQ_MHASH_SHIFT)
 #define rq_hash_key(rq)		((rq)->sector + (rq)->nr_sectors)
-#define list_entry_hash(ptr)	list_entry((ptr), struct cfq_rq, hash)
+#define list_entry_hash(ptr)	hlist_entry((ptr), struct cfq_rq, hash)
 
 #define list_entry_cfqq(ptr)	list_entry((ptr), struct cfq_queue, cfq_list)
 
-#define RQ_DATA(rq)		((struct cfq_rq *) (rq)->elevator_private)
+#define RQ_DATA(rq)		(rq)->elevator_private
+
+/*
+ * rb-tree defines
+ */
+#define RB_NONE			(2)
+#define RB_EMPTY(node)		((node)->rb_node == NULL)
+#define RB_CLEAR_COLOR(node)	(node)->rb_color = RB_NONE
+#define RB_CLEAR(node)		do {	\
+	(node)->rb_parent = NULL;	\
+	RB_CLEAR_COLOR((node));		\
+	(node)->rb_right = NULL;	\
+	(node)->rb_left = NULL;		\
+} while (0)
+#define RB_CLEAR_ROOT(root)	((root)->rb_node = NULL)
+#define ON_RB(node)		((node)->rb_color != RB_NONE)
+#define rb_entry_crq(node)	rb_entry((node), struct cfq_rq, rb_node)
+#define rq_rb_key(rq)		(rq)->sector
+
+/*
+ * sort key types and names
+ */
+enum {
+	CFQ_KEY_PGID,
+	CFQ_KEY_TGID,
+	CFQ_KEY_UID,
+	CFQ_KEY_GID,
+	CFQ_KEY_LAST,
+};
+
+static char *cfq_key_types[] = { "pgid", "tgid", "uid", "gid", NULL };
+
+/*
+ * spare queue
+ */
+#define CFQ_KEY_SPARE		(~0UL)
 
 static kmem_cache_t *crq_pool;
 static kmem_cache_t *cfq_pool;
-static mempool_t *cfq_mpool;
+static kmem_cache_t *cfq_ioc_pool;
 
 struct cfq_data {
 	struct list_head rr_list;
-	struct list_head *dispatch;
-	struct list_head *cfq_hash;
+	struct list_head empty_list;
 
-	struct list_head *crq_hash;
+	struct hlist_head *cfq_hash;
+	struct hlist_head *crq_hash;
 
+	/* queues on rr_list (ie they have pending requests */
 	unsigned int busy_queues;
+
 	unsigned int max_queued;
 
+	int key_type;
+
 	mempool_t *crq_pool;
 
 	request_queue_t *queue;
 
+	sector_t last_sector;
+
 	/*
-	 * tunables
+	 * tunables, see top of file
 	 */
 	unsigned int cfq_quantum;
 	unsigned int cfq_queued;
+	unsigned int cfq_tagged;
+	unsigned int cfq_fifo_expire_r;
+	unsigned int cfq_fifo_expire_w;
+	unsigned int cfq_fifo_batch_expire;
+	unsigned int cfq_back_penalty;
+	unsigned int cfq_back_max;
+	unsigned int find_best_crq;
 };
 
 struct cfq_queue {
-	struct list_head cfq_hash;
+	/* reference count */
+	atomic_t ref;
+	/* parent cfq_data */
+	struct cfq_data *cfqd;
+	/* hash of mergeable requests */
+	struct hlist_node cfq_hash;
+	/* hash key */
+	unsigned long key;
+	/* whether queue is on rr (or empty) list */
+	int on_rr;
+	/* on either rr or empty list of cfqd */
 	struct list_head cfq_list;
+	/* sorted list of pending requests */
 	struct rb_root sort_list;
-	int pid;
+	/* if fifo isn't expired, next request to serve */
+	struct cfq_rq *next_crq;
+	/* requests queued in sort_list */
 	int queued[2];
-#if 0
-	/*
-	 * with a simple addition like this, we can do io priorities. almost.
-	 * does need a split request free list, too.
-	 */
-	int io_prio
+	/* currently allocated requests */
+	int allocated[2];
+	/* fifo list of requests in sort_list */
+	struct list_head fifo[2];
+	/* last time fifo expired */
+	unsigned long last_fifo_expire;
+
+	int key_type;
+
+	unsigned long service_start;
+	unsigned long service_used;
+
+	/* number of requests that have been handed to the driver */
+	int in_flight;
+	/* number of currently allocated requests */
+	int alloc_limit[2];
+
+#ifdef CFQ_DEBUG
+	char name[16];
 #endif
 };
 
 struct cfq_rq {
 	struct rb_node rb_node;
 	sector_t rb_key;
-
 	struct request *request;
+	struct hlist_node hash;
 
 	struct cfq_queue *cfq_queue;
+	struct cfq_io_context *io_context;
+
+	unsigned long service_start;
+	unsigned long queue_start;
 
-	struct list_head hash;
+	unsigned int in_flight : 1;
+	unsigned int accounted : 1;
+	unsigned int is_sync   : 1;
 };
 
-static void cfq_put_queue(struct cfq_data *cfqd, struct cfq_queue *cfqq);
-static struct cfq_queue *cfq_find_cfq_hash(struct cfq_data *cfqd, int pid);
-static void cfq_dispatch_sort(struct cfq_data *cfqd, struct cfq_queue *cfqq,
-			      struct cfq_rq *crq);
+static struct cfq_queue *cfq_find_cfq_hash(struct cfq_data *, unsigned long);
+static void cfq_dispatch_sort(request_queue_t *, struct cfq_rq *);
+static void cfq_update_next_crq(struct cfq_rq *);
 
 /*
- * lots of deadline iosched dupes, can be abstracted later...
+ * what the fairness is based on (ie how processes are grouped and
+ * differentiated)
  */
-static inline void __cfq_del_crq_hash(struct cfq_rq *crq)
+static inline unsigned long
+cfq_hash_key(struct cfq_data *cfqd, struct task_struct *tsk)
 {
-	list_del_init(&crq->hash);
+	/*
+	 * optimize this so that ->key_type is the offset into the struct
+	 */
+	switch (cfqd->key_type) {
+		case CFQ_KEY_PGID:
+			return process_group(tsk);
+		default:
+		case CFQ_KEY_TGID:
+			return tsk->tgid;
+		case CFQ_KEY_UID:
+			return tsk->uid;
+		case CFQ_KEY_GID:
+			return tsk->gid;
+	}
 }
 
+/*
+ * lots of deadline iosched dupes, can be abstracted later...
+ */
 static inline void cfq_del_crq_hash(struct cfq_rq *crq)
 {
-	if (ON_MHASH(crq))
-		__cfq_del_crq_hash(crq);
+	hlist_del_init(&crq->hash);
 }
 
 static void cfq_remove_merge_hints(request_queue_t *q, struct cfq_rq *crq)
@@ -120,32 +238,32 @@
 
 	if (q->last_merge == crq->request)
 		q->last_merge = NULL;
+
+	cfq_update_next_crq(crq);
 }
 
 static inline void cfq_add_crq_hash(struct cfq_data *cfqd, struct cfq_rq *crq)
 {
-	struct request *rq = crq->request;
+	const int hash_idx = CFQ_MHASH_FN(rq_hash_key(crq->request));
 
-	BUG_ON(ON_MHASH(crq));
+	BUG_ON(!hlist_unhashed(&crq->hash));
 
-	list_add(&crq->hash, &cfqd->crq_hash[CFQ_MHASH_FN(rq_hash_key(rq))]);
+	hlist_add_head(&crq->hash, &cfqd->crq_hash[hash_idx]);
 }
 
 static struct request *cfq_find_rq_hash(struct cfq_data *cfqd, sector_t offset)
 {
-	struct list_head *hash_list = &cfqd->crq_hash[CFQ_MHASH_FN(offset)];
-	struct list_head *entry, *next = hash_list->next;
+	struct hlist_head *hash_list = &cfqd->crq_hash[CFQ_MHASH_FN(offset)];
+	struct hlist_node *entry, *next;
 
-	while ((entry = next) != hash_list) {
+	hlist_for_each_safe(entry, next, hash_list) {
 		struct cfq_rq *crq = list_entry_hash(entry);
 		struct request *__rq = crq->request;
 
-		next = entry->next;
-
-		BUG_ON(!ON_MHASH(crq));
+		BUG_ON(hlist_unhashed(&crq->hash));
 
 		if (!rq_mergeable(__rq)) {
-			__cfq_del_crq_hash(crq);
+			cfq_del_crq_hash(crq);
 			continue;
 		}
 
@@ -157,29 +275,234 @@
 }
 
 /*
- * rb tree support functions
+ * Lifted from AS - choose which of crq1 and crq2 that is best served now.
+ * We choose the request that is closest to the head right now. Distance
+ * behind the head are penalized and only allowed to a certain extent.
  */
-#define RB_NONE		(2)
-#define RB_EMPTY(node)	((node)->rb_node == NULL)
-#define RB_CLEAR(node)	((node)->rb_color = RB_NONE)
-#define RB_CLEAR_ROOT(root)	((root)->rb_node = NULL)
-#define ON_RB(node)	((node)->rb_color != RB_NONE)
-#define rb_entry_crq(node)	rb_entry((node), struct cfq_rq, rb_node)
-#define rq_rb_key(rq)		(rq)->sector
+static struct cfq_rq *
+cfq_choose_req(struct cfq_data *cfqd, struct cfq_rq *crq1, struct cfq_rq *crq2)
+{
+	sector_t last, s1, s2, d1 = 0, d2 = 0;
+	int r1_wrap = 0, r2_wrap = 0;	/* requests are behind the disk head */
+	unsigned long back_max;
+
+	if (crq1 == NULL || crq1 == crq2)
+		return crq2;
+	if (crq2 == NULL)
+		return crq1;
+
+	s1 = crq1->request->sector;
+	s2 = crq2->request->sector;
+
+	last = cfqd->last_sector;
+
+#if 0
+	if (!list_empty(&cfqd->queue->queue_head)) {
+		struct list_head *entry = &cfqd->queue->queue_head;
+		unsigned long distance = ~0UL;
+		struct request *rq;
+
+		while ((entry = entry->prev) != &cfqd->queue->queue_head) {
+			rq = list_entry_rq(entry);
+
+			if (blk_barrier_rq(rq))
+				break;
+	
+			if (distance < abs(s1 - rq->sector + rq->nr_sectors)) {
+				distance = abs(s1 - rq->sector +rq->nr_sectors);
+				last = rq->sector + rq->nr_sectors;
+			}
+			if (distance < abs(s2 - rq->sector + rq->nr_sectors)) {
+				distance = abs(s2 - rq->sector +rq->nr_sectors);
+				last = rq->sector + rq->nr_sectors;
+			}
+		}
+	}
+#endif
+
+	/*
+	 * by definition, 1KiB is 2 sectors
+	 */
+	back_max = cfqd->cfq_back_max * 2;
+
+	/*
+	 * Strict one way elevator _except_ in the case where we allow
+	 * short backward seeks which are biased as twice the cost of a
+	 * similar forward seek.
+	 */
+	if (s1 >= last)
+		d1 = s1 - last;
+	else if (s1 + back_max >= last)
+		d1 = (last - s1) * cfqd->cfq_back_penalty;
+	else
+		r1_wrap = 1;
+
+	if (s2 >= last)
+		d2 = s2 - last;
+	else if (s2 + back_max >= last)
+		d2 = (last - s2) * cfqd->cfq_back_penalty;
+	else
+		r2_wrap = 1;
+
+	/* Found required data */
+	if (!r1_wrap && r2_wrap)
+		return crq1;
+	else if (!r2_wrap && r1_wrap)
+		return crq2;
+	else if (r1_wrap && r2_wrap) {
+		/* both behind the head */
+		if (s1 <= s2)
+			return crq1;
+		else
+			return crq2;
+	}
+
+	/* Both requests in front of the head */
+	if (d1 < d2)
+		return crq1;
+	else if (d2 < d1)
+		return crq2;
+	else {
+		if (s1 >= s2)
+			return crq1;
+		else
+			return crq2;
+	}
+}
+
+/*
+ * would be nice to take fifo expire time into account as well
+ */
+static struct cfq_rq *
+cfq_find_next_crq(struct cfq_data *cfqd, struct cfq_queue *cfqq,
+		  struct cfq_rq *last)
+{
+	struct cfq_rq *crq_next = NULL, *crq_prev = NULL;
+	struct rb_node *rbnext, *rbprev;
+
+	if (!ON_RB(&last->rb_node))
+		return NULL;
+
+	if ((rbnext = rb_next(&last->rb_node)) == NULL)
+		rbnext = rb_first(&cfqq->sort_list);
+
+	rbprev = rb_prev(&last->rb_node);
+
+	if (rbprev)
+		crq_prev = rb_entry_crq(rbprev);
+	if (rbnext)
+		crq_next = rb_entry_crq(rbnext);
+
+	return cfq_choose_req(cfqd, crq_next, crq_prev);
+}
+
+static void cfq_update_next_crq(struct cfq_rq *crq)
+{
+	struct cfq_queue *cfqq = crq->cfq_queue;
+
+	if (cfqq->next_crq == crq)
+		cfqq->next_crq = cfq_find_next_crq(cfqq->cfqd, cfqq, crq);
+}
+
+static inline void
+cfq_sort_rr_list(struct cfq_queue *cfqq)
+{
+	struct list_head *entry = &cfqq->cfqd->rr_list;
+
+	list_del(&cfqq->cfq_list);
+
+	/*
+	 * sort by our mean service_used, sub-sort by in-flight requests
+	 */
+	while ((entry = entry->prev) != &cfqq->cfqd->rr_list) {
+		struct cfq_queue *__cfqq = list_entry_cfqq(entry);
+
+		if (cfqq->service_used > __cfqq->service_used)
+			break;
+		else if (cfqq->service_used == __cfqq->service_used) {
+			struct list_head *prv;
+
+			while ((prv = entry->prev) != &cfqq->cfqd->rr_list) {
+				__cfqq = list_entry_cfqq(prv);
+
+				WARN_ON(__cfqq->service_used > cfqq->service_used);
+				if (cfqq->service_used != __cfqq->service_used)
+					break;
+				if (cfqq->in_flight > __cfqq->in_flight)
+					break;
+
+				entry = prv;
+			}
+		}
+	}
 
-static inline void cfq_del_crq_rb(struct cfq_queue *cfqq, struct cfq_rq *crq)
+	list_add(&cfqq->cfq_list, entry);
+}
+
+/*
+ * add to busy list of queues for service, trying to be fair in ordering
+ * the pending list according to requests serviced
+ */
+static inline void
+cfq_add_cfqq_rr(struct cfq_data *cfqd, struct cfq_queue *cfqq)
+{
+	BUG_ON(cfqq->on_rr);
+
+	/*
+	 * it's currently on the empty list
+	 */
+	cfq_sort_rr_list(cfqq);
+	cfqq->on_rr = 1;
+	cfqd->busy_queues++;
+
+	/*
+	 * if the queue is on the empty_list, service_start was the time
+	 * where it was deleted from the rr_list.
+	 */
+	if (time_after(jiffies, cfqq->service_start + cfq_service))
+		cfqq->service_used >>= 3;
+}
+
+static inline void
+cfq_del_cfqq_rr(struct cfq_data *cfqd, struct cfq_queue *cfqq)
 {
+	list_move(&cfqq->cfq_list, &cfqd->empty_list);
+	cfqq->on_rr = 0;
+	cfqq->service_start = jiffies;
+
+	BUG_ON(!cfqd->busy_queues);
+	cfqd->busy_queues--;
+}
+
+/*
+ * rb tree support functions
+ */
+static inline void cfq_del_crq_rb(struct cfq_rq *crq)
+{
+	struct cfq_queue *cfqq = crq->cfq_queue;
+
 	if (ON_RB(&crq->rb_node)) {
-		cfqq->queued[rq_data_dir(crq->request)]--;
+		struct cfq_data *cfqd = cfqq->cfqd;
+
+		BUG_ON(!cfqq->queued[crq->is_sync]);
+
+		cfq_update_next_crq(crq);
+
+		cfqq->queued[crq->is_sync]--;
 		rb_erase(&crq->rb_node, &cfqq->sort_list);
-		crq->cfq_queue = NULL;
+		RB_CLEAR_COLOR(&crq->rb_node);
+
+		if (RB_EMPTY(&cfqq->sort_list) && cfqq->on_rr) {
+			dprintk("moving 0x%p empty_list\n", cfqq);
+			cfq_del_cfqq_rr(cfqd, cfqq);
+		}
 	}
 }
 
 static struct cfq_rq *
-__cfq_add_crq_rb(struct cfq_queue *cfqq, struct cfq_rq *crq)
+__cfq_add_crq_rb(struct cfq_rq *crq)
 {
-	struct rb_node **p = &cfqq->sort_list.rb_node;
+	struct rb_node **p = &crq->cfq_queue->sort_list.rb_node;
 	struct rb_node *parent = NULL;
 	struct cfq_rq *__crq;
 
@@ -199,30 +522,53 @@
 	return NULL;
 }
 
-static void
-cfq_add_crq_rb(struct cfq_data *cfqd, struct cfq_queue *cfqq,struct cfq_rq *crq)
+static void cfq_add_crq_rb(struct cfq_rq *crq)
 {
+	struct cfq_queue *cfqq = crq->cfq_queue;
+	struct cfq_data *cfqd = cfqq->cfqd;
 	struct request *rq = crq->request;
 	struct cfq_rq *__alias;
 
 	crq->rb_key = rq_rb_key(rq);
-	cfqq->queued[rq_data_dir(rq)]++;
-retry:
-	__alias = __cfq_add_crq_rb(cfqq, crq);
-	if (!__alias) {
-		rb_insert_color(&crq->rb_node, &cfqq->sort_list);
-		crq->cfq_queue = cfqq;
-		return;
+	cfqq->queued[crq->is_sync]++;
+
+	/*
+	 * looks a little odd, but the first insert might return an alias.
+	 * if that happens, put the alias on the dispatch list
+	 */
+	while ((__alias = __cfq_add_crq_rb(crq)) != NULL)
+		cfq_dispatch_sort(cfqd->queue, __alias);
+
+	rb_insert_color(&crq->rb_node, &cfqq->sort_list);
+
+	if (!cfqq->on_rr) {
+		cfq_add_cfqq_rr(cfqd, cfqq);
+		dprintk("moving to rr list %d\n", cfqd->busy_queues);
+	} else
+		dprintk("already on rr list %d\n", cfqd->busy_queues);
+
+	/*
+	 * check if this request is a better next-serve candidate
+	 */
+	cfqq->next_crq = cfq_choose_req(cfqd, cfqq->next_crq, crq);
+}
+
+static inline void
+cfq_reposition_crq_rb(struct cfq_queue *cfqq, struct cfq_rq *crq)
+{
+	if (ON_RB(&crq->rb_node)) {
+		rb_erase(&crq->rb_node, &cfqq->sort_list);
+		cfqq->queued[crq->is_sync]--;
 	}
 
-	cfq_dispatch_sort(cfqd, cfqq, __alias);
-	goto retry;
+	cfq_add_crq_rb(crq);
 }
 
 static struct request *
 cfq_find_rq_rb(struct cfq_data *cfqd, sector_t sector)
 {
-	struct cfq_queue *cfqq = cfq_find_cfq_hash(cfqd, current->tgid);
+	const unsigned long key = cfq_hash_key(cfqd, current);
+	struct cfq_queue *cfqq = cfq_find_cfq_hash(cfqd, key);
 	struct rb_node *n;
 
 	if (!cfqq)
@@ -246,21 +592,16 @@
 
 static void cfq_remove_request(request_queue_t *q, struct request *rq)
 {
-	struct cfq_data *cfqd = q->elevator.elevator_data;
 	struct cfq_rq *crq = RQ_DATA(rq);
 
-	if (crq) {
-		struct cfq_queue *cfqq = crq->cfq_queue;
+	dprintk("removing 0x%p\n", rq);
 
+	if (crq) {
 		cfq_remove_merge_hints(q, crq);
 		list_del_init(&rq->queuelist);
 
-		if (cfqq) {
-			cfq_del_crq_rb(cfqq, crq);
-
-			if (RB_EMPTY(&cfqq->sort_list))
-				cfq_put_queue(cfqd, cfqq);
-		}
+		if (crq->cfq_queue)
+			cfq_del_crq_rb(crq);
 	}
 }
 
@@ -314,92 +655,228 @@
 	if (ON_RB(&crq->rb_node) && (rq_rb_key(req) != crq->rb_key)) {
 		struct cfq_queue *cfqq = crq->cfq_queue;
 
-		cfq_del_crq_rb(cfqq, crq);
-		cfq_add_crq_rb(cfqd, cfqq, crq);
+		cfq_update_next_crq(crq);
+		cfq_reposition_crq_rb(cfqq, crq);
 	}
 
 	q->last_merge = req;
 }
 
 static void
-cfq_merged_requests(request_queue_t *q, struct request *req,
+cfq_merged_requests(request_queue_t *q, struct request *rq,
 		    struct request *next)
 {
-	cfq_merged_request(q, req);
+	struct cfq_rq *crq = RQ_DATA(rq);
+	struct cfq_rq *cnext = RQ_DATA(next);
+
+	cfq_merged_request(q, rq);
+
+	if (!list_empty(&rq->queuelist) && !list_empty(&next->queuelist)) {
+		if (time_before(cnext->queue_start, crq->queue_start)) {
+			list_move(&rq->queuelist, &next->queuelist);
+			crq->queue_start = cnext->queue_start;
+		}
+	}
+
+	cfq_update_next_crq(cnext);
 	cfq_remove_request(q, next);
 }
 
-static void
-cfq_dispatch_sort(struct cfq_data *cfqd, struct cfq_queue *cfqq,
-		  struct cfq_rq *crq)
+/*
+ * we dispatch cfqd->cfq_quantum requests in total from the rr_list queues,
+ * this function sector sorts the selected request to minimize seeks. we start
+ * at cfqd->last_sector, not 0.
+ */
+static void cfq_dispatch_sort(request_queue_t *q, struct cfq_rq *crq)
 {
-	struct list_head *head = cfqd->dispatch, *entry = head;
+	struct cfq_data *cfqd = q->elevator.elevator_data;
+	struct cfq_queue *cfqq = crq->cfq_queue;
+	struct list_head *head = &q->queue_head, *entry = head;
 	struct request *__rq;
+	sector_t last;
 
-	cfq_del_crq_rb(cfqq, crq);
-	cfq_remove_merge_hints(cfqd->queue, crq);
+	cfq_del_crq_rb(crq);
+	cfq_remove_merge_hints(q, crq);
+	list_del(&crq->request->queuelist);
 
-	if (!list_empty(head)) {
-		__rq = list_entry_rq(head->next);
+	last = cfqd->last_sector;
+	while ((entry = entry->prev) != head) {
+		__rq = list_entry_rq(entry);
+
+		if (blk_barrier_rq(crq->request))
+			break;
+		if (!blk_fs_request(crq->request))
+			break;
 
-		if (crq->request->sector < __rq->sector) {
-			entry = head->prev;
-			goto link;
+		if (crq->request->sector > __rq->sector)
+			break;
+		if (__rq->sector > last && crq->request->sector < last) {
+			last = crq->request->sector;
+			break;
 		}
 	}
 
-	while ((entry = entry->prev) != head) {
-		__rq = list_entry_rq(entry);
+	cfqd->last_sector = last;
+	crq->in_flight = 1;
+	cfqq->in_flight++;
+	list_add(&crq->request->queuelist, entry);
+}
 
-		if (crq->request->sector <= __rq->sector)
-			break;
+/*
+ * return expired entry, or NULL to just start from scratch in rbtree
+ */
+static inline struct cfq_rq *cfq_check_fifo(struct cfq_queue *cfqq)
+{
+	struct cfq_data *cfqd = cfqq->cfqd;
+	const int reads = !list_empty(&cfqq->fifo[0]);
+	const int writes = !list_empty(&cfqq->fifo[1]);
+	struct cfq_rq *crq;
+
+	if (jiffies - cfqq->last_fifo_expire < cfqd->cfq_fifo_batch_expire)
+		return NULL;
+
+	crq = RQ_DATA(list_entry(cfqq->fifo[0].next, struct request, queuelist));
+	if (reads && time_after(jiffies, crq->queue_start + cfqd->cfq_fifo_expire_r)) {
+		cfqq->last_fifo_expire = jiffies;
+		return crq;
 	}
 
-link:
-	list_add_tail(&crq->request->queuelist, entry);
+	crq = RQ_DATA(list_entry(cfqq->fifo[1].next, struct request, queuelist));
+	if (writes && time_after(jiffies, crq->queue_start + cfqd->cfq_fifo_expire_w)) {
+		cfqq->last_fifo_expire = jiffies;
+		return crq;
+	}
+
+	return NULL;
 }
 
+/*
+ * dispatch a single request from given queue
+ */
 static inline void
-__cfq_dispatch_requests(request_queue_t *q, struct cfq_data *cfqd,
-			struct cfq_queue *cfqq)
+cfq_dispatch_request(request_queue_t *q, struct cfq_data *cfqd,
+		     struct cfq_queue *cfqq)
 {
-	struct cfq_rq *crq = rb_entry_crq(rb_first(&cfqq->sort_list));
+	struct cfq_rq *crq;
 
-	cfq_dispatch_sort(cfqd, cfqq, crq);
+	/*
+	 * follow expired path, else get first next available
+	 */
+	if ((crq = cfq_check_fifo(cfqq)) == NULL) {
+		if (cfqd->find_best_crq)
+			crq = cfqq->next_crq;
+		else
+			crq = rb_entry_crq(rb_first(&cfqq->sort_list));
+	}
+
+	cfqd->last_sector = crq->request->sector + crq->request->nr_sectors;
+
+	/*
+	 * finally, insert request into driver list
+	 */
+	cfq_dispatch_sort(q, crq);
 }
 
-static int cfq_dispatch_requests(request_queue_t *q, struct cfq_data *cfqd)
+static int cfq_dispatch_requests(request_queue_t *q, int max_dispatch)
 {
+	struct cfq_data *cfqd = q->elevator.elevator_data;
 	struct cfq_queue *cfqq;
 	struct list_head *entry, *tmp;
-	int ret, queued, good_queues;
+	int queued, busy_queues, first_round;
 
 	if (list_empty(&cfqd->rr_list))
 		return 0;
 
-	queued = ret = 0;
+	queued = 0;
+	first_round = 1;
 restart:
-	good_queues = 0;
+	busy_queues = 0;
 	list_for_each_safe(entry, tmp, &cfqd->rr_list) {
-		cfqq = list_entry_cfqq(cfqd->rr_list.next);
+		cfqq = list_entry_cfqq(entry);
 
 		BUG_ON(RB_EMPTY(&cfqq->sort_list));
 
-		__cfq_dispatch_requests(q, cfqd, cfqq);
+		/*
+		 * first round of queueing, only select from queues that
+		 * don't already have io in-flight
+		 */
+		if (first_round && cfqq->in_flight)
+			continue;
 
-		if (RB_EMPTY(&cfqq->sort_list))
-			cfq_put_queue(cfqd, cfqq);
-		else
-			good_queues++;
+		cfq_dispatch_request(q, cfqd, cfqq);
+
+		if (!RB_EMPTY(&cfqq->sort_list))
+			busy_queues++;
 
 		queued++;
-		ret = 1;
 	}
 
-	if ((queued < cfqd->cfq_quantum) && good_queues)
+	if ((queued < max_dispatch) && (busy_queues || first_round)) {
+		first_round = 0;
 		goto restart;
+	}
 
-	return ret;
+	return queued;
+}
+
+static inline void cfq_account_dispatch(struct cfq_rq *crq)
+{
+	struct cfq_queue *cfqq = crq->cfq_queue;
+	unsigned long elapsed = jiffies - crq->queue_start;
+
+	/*
+	 * accounted bit is necessary since some drivers will call
+	 * elv_next_request() many times for the same request (eg ide)
+	 */
+	if (crq->accounted)
+		return;
+
+	/*
+	 * on drives with tagged command queueing, command turn-around time
+	 * doesn't necessarily reflect the time spent processing this very
+	 * command inside the drive. so do the accounting differently there,
+	 * by just sorting on the number of requests
+	 */
+	if (cfqq->cfqd->cfq_tagged) {
+		if (time_after(jiffies, cfqq->service_start + cfq_service)) {
+			cfqq->service_start = jiffies;
+			cfqq->service_used /= 10;
+		}
+
+		cfqq->service_used++;
+	}
+
+	if (elapsed > max_elapsed_dispatch)
+		max_elapsed_dispatch = elapsed;
+
+	crq->accounted = 1;
+	crq->service_start = jiffies;
+}
+
+static inline void
+cfq_account_completion(struct cfq_queue *cfqq, struct cfq_rq *crq)
+{
+	unsigned long start_val = cfqq->service_used;
+
+	if (!cfqq->cfqd->cfq_tagged) {
+		unsigned long duration = jiffies - crq->service_start;
+
+		if (time_after(jiffies, cfqq->service_start + cfq_service)) {
+			cfqq->service_start = jiffies;
+			cfqq->service_used >>= 3;
+		}
+
+		cfqq->service_used += duration;
+
+		if (duration > max_elapsed_crq)
+			max_elapsed_crq = duration;
+	}
+
+	/*
+	 * make sure list stays properly sorted, but only do so if necessary
+	 */
+	if (cfqq->on_rr && cfqq->service_used != start_val)
+		cfq_sort_rr_list(cfqq);
 }
 
 static struct request *cfq_next_request(request_queue_t *q)
@@ -407,100 +884,309 @@
 	struct cfq_data *cfqd = q->elevator.elevator_data;
 	struct request *rq;
 
-	if (!list_empty(cfqd->dispatch)) {
+	if (!list_empty(&q->queue_head)) {
 		struct cfq_rq *crq;
 dispatch:
-		rq = list_entry_rq(cfqd->dispatch->next);
+		rq = list_entry_rq(q->queue_head.next);
 
-		crq = RQ_DATA(rq);
-		if (crq)
+		if ((crq = RQ_DATA(rq)) != NULL) {
 			cfq_remove_merge_hints(q, crq);
+			cfq_account_dispatch(crq);
+		}
 
 		return rq;
 	}
 
-	if (cfq_dispatch_requests(q, cfqd))
+	if (cfq_dispatch_requests(q, cfqd->cfq_quantum))
 		goto dispatch;
 
 	return NULL;
 }
 
+/*
+ * task holds one reference to the queue, dropped when task exits. each crq
+ * in-flight on this queue also holds a reference, dropped when crq is freed.
+ *
+ * queue lock must be held here.
+ */
+static void cfq_put_queue(struct cfq_queue *cfqq)
+{
+	BUG_ON(!atomic_read(&cfqq->ref));
+
+	dprintk("cfq_put_queue 0x%p, ref\n", atomic_read(&cfqq->ref));
+
+	if (!atomic_dec_and_test(&cfqq->ref))
+		return;
+
+	dprintk("killing queue 0x%p/%s\n", cfqq, cfqq->name);
+
+	BUG_ON(rb_first(&cfqq->sort_list));
+	BUG_ON(cfqq->on_rr);
+
+	/*
+	 * it's on the empty list and still hashed
+	 */
+	list_del(&cfqq->cfq_list);
+	hlist_del(&cfqq->cfq_hash);
+	kmem_cache_free(cfq_pool, cfqq);
+}
+
 static inline struct cfq_queue *
-__cfq_find_cfq_hash(struct cfq_data *cfqd, int pid, const int hashval)
+__cfq_find_cfq_hash(struct cfq_data *cfqd, unsigned long key, const int hashval)
 {
-	struct list_head *hash_list = &cfqd->cfq_hash[hashval];
-	struct list_head *entry;
+	struct hlist_head *hash_list = &cfqd->cfq_hash[hashval];
+	struct hlist_node *entry, *next;
 
-	list_for_each(entry, hash_list) {
+	hlist_for_each_safe(entry, next, hash_list) {
 		struct cfq_queue *__cfqq = list_entry_qhash(entry);
 
-		if (__cfqq->pid == pid)
+		if (__cfqq->key == key)
 			return __cfqq;
 	}
 
 	return NULL;
 }
 
-static struct cfq_queue *cfq_find_cfq_hash(struct cfq_data *cfqd, int pid)
+static struct cfq_queue *
+cfq_find_cfq_hash(struct cfq_data *cfqd, unsigned long key)
 {
-	const int hashval = hash_long(current->tgid, CFQ_QHASH_SHIFT);
+	return __cfq_find_cfq_hash(cfqd, key, hash_long(key, CFQ_QHASH_SHIFT));
+}
+
+static inline void
+cfq_rehash_cfqq(struct cfq_data *cfqd, struct cfq_queue **cfqq,
+		struct cfq_io_context *cic)
+{
+	unsigned long hashkey = cfq_hash_key(cfqd, current);
+	unsigned long hashval = hash_long(hashkey, CFQ_QHASH_SHIFT);
+	struct cfq_queue *__cfqq;
+	unsigned long flags;
+
+	spin_lock_irqsave(cfqd->queue->queue_lock, flags);
+
+	hlist_del(&(*cfqq)->cfq_hash);
+
+	__cfqq = __cfq_find_cfq_hash(cfqd, hashkey, hashval);
+	if (!__cfqq || __cfqq == *cfqq) {
+		__cfqq = *cfqq;
+		hlist_add_head(&__cfqq->cfq_hash, &cfqd->cfq_hash[hashval]);
+		__cfqq->key_type = cfqd->key_type;
+	} else {
+		atomic_inc(&__cfqq->ref);
+		cic->cfqq = __cfqq;
+		cfq_put_queue(*cfqq);
+		*cfqq = __cfqq;
+	}
 
-	return __cfq_find_cfq_hash(cfqd, pid, hashval);
+	cic->cfqq = __cfqq;
+	spin_unlock_irqrestore(cfqd->queue->queue_lock, flags);
 }
 
-static void cfq_put_queue(struct cfq_data *cfqd, struct cfq_queue *cfqq)
+static void cfq_free_io_context(struct cfq_io_context *cic)
 {
-	cfqd->busy_queues--;
-	list_del(&cfqq->cfq_list);
-	list_del(&cfqq->cfq_hash);
-	mempool_free(cfqq, cfq_mpool);
+	kmem_cache_free(cfq_ioc_pool, cic);
+}
+
+/*
+ * locking hierarchy is: io_context lock -> queue locks
+ */
+static void cfq_exit_io_context(struct cfq_io_context *cic)
+{
+	struct cfq_queue *cfqq = cic->cfqq;
+	struct list_head *entry = &cic->list;
+	request_queue_t *q;
+	unsigned long flags;
+
+	/*
+	 * put the reference this task is holding to the various queues
+	 */
+	spin_lock_irqsave(&cic->ioc->lock, flags);
+	while ((entry = cic->list.next) != &cic->list) {
+		struct cfq_io_context *__cic;
+
+		__cic = list_entry(entry, struct cfq_io_context, list);
+		list_del(entry);
+
+		q = __cic->cfqq->cfqd->queue;
+		spin_lock(q->queue_lock);
+		cfq_put_queue(__cic->cfqq);
+		spin_unlock(q->queue_lock);
+	}
+
+	q = cfqq->cfqd->queue;
+	spin_lock(q->queue_lock);
+	cfq_put_queue(cfqq);
+	spin_unlock(q->queue_lock);
+
+	cic->cfqq = NULL;
+	spin_unlock_irqrestore(&cic->ioc->lock, flags);
+}
+
+static struct cfq_io_context *cfq_alloc_io_context(int gfp_flags)
+{
+	struct cfq_io_context *cic = kmem_cache_alloc(cfq_ioc_pool, gfp_flags);
+
+	if (cic) {
+		cic->dtor = cfq_free_io_context;
+		cic->exit = cfq_exit_io_context;
+		INIT_LIST_HEAD(&cic->list);
+		cic->cfqq = NULL;
+	}
+
+	return cic;
+}
+
+/*
+ * Setup general io context and cfq io context. There can be several cfq
+ * io contexts per general io context, if this process is doing io to more
+ * than one device managed by cfq. Note that caller is holding a reference to
+ * cfqq, so we don't need to worry about it disappearing
+ */
+static struct cfq_io_context *
+cfq_get_io_context(struct cfq_queue **cfqq, int gfp_flags)
+{
+	struct cfq_data *cfqd = (*cfqq)->cfqd;
+	struct cfq_queue *__cfqq = *cfqq;
+	struct cfq_io_context *cic;
+	struct io_context *ioc;
+
+	might_sleep_if(gfp_flags & __GFP_WAIT);
+
+	ioc = get_io_context(gfp_flags);
+	if (!ioc)
+		return NULL;
+
+	if ((cic = ioc->cic) == NULL) {
+		cic = cfq_alloc_io_context(gfp_flags);
+
+		if (cic == NULL)
+			goto err;
+
+		ioc->cic = cic;
+		cic->ioc = ioc;
+		cic->cfqq = __cfqq;
+		atomic_inc(&__cfqq->ref);
+	} else {
+		struct cfq_io_context *__cic;
+		unsigned long flags;
+
+		/*
+		 * since the first cic on the list is actually the head
+		 * itself, need to check this here or we'll duplicate an
+		 * cic per ioc for no reason
+		 */
+		if (cic->cfqq == __cfqq)
+			goto out;
+
+		/*
+		 * cic exists, check if we already are there. linear search
+		 * should be ok here, the list will usually not be more than
+		 * 1 or a few entries long
+		 */
+		spin_lock_irqsave(&ioc->lock, flags);
+		list_for_each_entry(__cic, &cic->list, list) {
+			/*
+			 * this process is already holding a reference to
+			 * this queue, so no need to get one more
+			 */
+			if (__cic->cfqq == __cfqq) {
+				cic = __cic;
+				spin_unlock_irqrestore(&ioc->lock, flags);
+				goto out;
+			}
+		}
+		spin_unlock_irqrestore(&ioc->lock, flags);
+
+		/*
+		 * nope, process doesn't have a cic assoicated with this
+		 * cfqq yet. get a new one and add to list
+		 */
+		__cic = cfq_alloc_io_context(gfp_flags);
+		if (__cic == NULL)
+			goto err;
+
+		__cic->ioc = ioc;
+		__cic->cfqq = __cfqq;
+		atomic_inc(&__cfqq->ref);
+		spin_lock_irqsave(&ioc->lock, flags);
+		list_add(&__cic->list, &cic->list);
+		spin_unlock_irqrestore(&ioc->lock, flags);
+
+		cic = __cic;
+		*cfqq = __cfqq;
+	}
+
+out:
+	/*
+	 * if key_type has been changed on the fly, we lazily rehash
+	 * each queue at lookup time
+	 */
+	if ((*cfqq)->key_type != cfqd->key_type)
+		cfq_rehash_cfqq(cfqd, cfqq, cic);
+
+	return cic;
+err:
+	put_io_context(ioc);
+	return NULL;
 }
 
-static struct cfq_queue *__cfq_get_queue(struct cfq_data *cfqd, int pid,
-					 int gfp_mask)
+static struct cfq_queue *
+__cfq_get_queue(struct cfq_data *cfqd, unsigned long key, int gfp_mask)
 {
-	const int hashval = hash_long(current->tgid, CFQ_QHASH_SHIFT);
+	const int hashval = hash_long(key, CFQ_QHASH_SHIFT);
 	struct cfq_queue *cfqq, *new_cfqq = NULL;
-	request_queue_t *q = cfqd->queue;
 
 retry:
-	cfqq = __cfq_find_cfq_hash(cfqd, pid, hashval);
+	cfqq = __cfq_find_cfq_hash(cfqd, key, hashval);
 
 	if (!cfqq) {
 		if (new_cfqq) {
 			cfqq = new_cfqq;
 			new_cfqq = NULL;
 		} else if (gfp_mask & __GFP_WAIT) {
-			spin_unlock_irq(q->queue_lock);
-			new_cfqq = mempool_alloc(cfq_mpool, gfp_mask);
-			spin_lock_irq(q->queue_lock);
+			spin_unlock_irq(cfqd->queue->queue_lock);
+			new_cfqq = kmem_cache_alloc(cfq_pool, gfp_mask);
+			spin_lock_irq(cfqd->queue->queue_lock);
 			goto retry;
 		} else
-			return NULL;
+			goto out;
+
+		memset(cfqq, 0, sizeof(*cfqq));
 
-		INIT_LIST_HEAD(&cfqq->cfq_hash);
+		INIT_HLIST_NODE(&cfqq->cfq_hash);
 		INIT_LIST_HEAD(&cfqq->cfq_list);
 		RB_CLEAR_ROOT(&cfqq->sort_list);
+		INIT_LIST_HEAD(&cfqq->fifo[0]);
+		INIT_LIST_HEAD(&cfqq->fifo[1]);
 
-		cfqq->pid = pid;
-		cfqq->queued[0] = cfqq->queued[1] = 0;
-		list_add(&cfqq->cfq_hash, &cfqd->cfq_hash[hashval]);
+		cfqq->key = key;
+		hlist_add_head(&cfqq->cfq_hash, &cfqd->cfq_hash[hashval]);
+		atomic_set(&cfqq->ref, 0);
+		cfqq->cfqd = cfqd;
+#ifdef CFQ_DEBUG
+		strncpy(cfqq->name, current->comm, sizeof(cfqq->name)-1);
+#endif
+		dprintk("cfqq set up for 0x%p/%s\n", cfqq, cfqq->name);
+		cfqq->key_type = cfqd->key_type;
 	}
 
 	if (new_cfqq)
-		mempool_free(new_cfqq, cfq_mpool);
+		kmem_cache_free(cfq_pool, new_cfqq);
 
+	atomic_inc(&cfqq->ref);
+out:
+	WARN_ON((gfp_mask & __GFP_WAIT) && !cfqq);
 	return cfqq;
 }
 
-static struct cfq_queue *cfq_get_queue(struct cfq_data *cfqd, int pid,
-				       int gfp_mask)
+static struct cfq_queue *
+cfq_get_queue(struct cfq_data *cfqd, unsigned long key, int gfp_mask)
 {
 	request_queue_t *q = cfqd->queue;
 	struct cfq_queue *cfqq;
 
 	spin_lock_irq(q->queue_lock);
-	cfqq = __cfq_get_queue(cfqd, pid, gfp_mask);
+	cfqq = __cfq_get_queue(cfqd, key, gfp_mask);
 	spin_unlock_irq(q->queue_lock);
 
 	return cfqq;
@@ -508,24 +1194,14 @@
 
 static void cfq_enqueue(struct cfq_data *cfqd, struct cfq_rq *crq)
 {
-	struct cfq_queue *cfqq;
+	crq->is_sync = 0;
+	if (rq_data_dir(crq->request) == READ || current->flags & PF_SYNCWRITE)
+		crq->is_sync = 1;
 
-	cfqq = __cfq_get_queue(cfqd, current->tgid, GFP_ATOMIC);
-	if (cfqq) {
-		cfq_add_crq_rb(cfqd, cfqq, crq);
+	cfq_add_crq_rb(crq);
+	crq->queue_start = jiffies;
 
-		if (list_empty(&cfqq->cfq_list)) {
-			list_add(&cfqq->cfq_list, &cfqd->rr_list);
-			cfqd->busy_queues++;
-		}
-	} else {
-		/*
-		 * should can only happen if the request wasn't allocated
-		 * through blk_alloc_request(), eg stack requests from ide-cd
-		 * (those should be removed) _and_ we are in OOM.
-		 */
-		list_add_tail(&crq->request->queuelist, cfqd->dispatch);
-	}
+	list_add_tail(&crq->request->queuelist, &crq->cfq_queue->fifo[crq->is_sync]);
 }
 
 static void
@@ -536,14 +1212,17 @@
 
 	switch (where) {
 		case ELEVATOR_INSERT_BACK:
-			while (cfq_dispatch_requests(q, cfqd))
+			dprintk("adding back 0x%p\n", rq);
+			while (cfq_dispatch_requests(q, cfqd->cfq_quantum))
 				;
-			list_add_tail(&rq->queuelist, cfqd->dispatch);
+			list_add_tail(&rq->queuelist, &q->queue_head);
 			break;
 		case ELEVATOR_INSERT_FRONT:
-			list_add(&rq->queuelist, cfqd->dispatch);
+			dprintk("adding front 0x%p\n", rq);
+			list_add(&rq->queuelist, &q->queue_head);
 			break;
 		case ELEVATOR_INSERT_SORT:
+			dprintk("adding sort 0x%p\n", rq);
 			BUG_ON(!blk_fs_request(rq));
 			cfq_enqueue(cfqd, crq);
 			break;
@@ -564,10 +1243,25 @@
 {
 	struct cfq_data *cfqd = q->elevator.elevator_data;
 
-	if (list_empty(cfqd->dispatch) && list_empty(&cfqd->rr_list))
-		return 1;
+	return list_empty(&q->queue_head) && list_empty(&cfqd->rr_list);
+}
+
+static void cfq_completed_request(request_queue_t *q, struct request *rq)
+{
+	struct cfq_rq *crq = RQ_DATA(rq);
+
+	if (unlikely(!blk_fs_request(rq)))
+		return;
+
+	if (crq->in_flight) {
+		struct cfq_queue *cfqq = crq->cfq_queue;
+
+		WARN_ON(!cfqq->in_flight);
+		cfqq->in_flight--;
+
+		cfq_account_completion(cfqq, crq);
+	}
 
-	return 0;
 }
 
 static struct request *
@@ -598,90 +1292,158 @@
 {
 	struct cfq_data *cfqd = q->elevator.elevator_data;
 	struct cfq_queue *cfqq;
-	int ret = 1;
+	int ret = ELV_MQUEUE_MAY;
 
-	if (!cfqd->busy_queues)
-		goto out;
+	if (current->flags & PF_MEMALLOC)
+		return ELV_MQUEUE_MAY;
 
-	cfqq = cfq_find_cfq_hash(cfqd, current->tgid);
+	cfqq = cfq_find_cfq_hash(cfqd, cfq_hash_key(cfqd, current));
 	if (cfqq) {
-		int limit = (q->nr_requests - cfqd->cfq_queued) / cfqd->busy_queues;
+		int limit = cfqd->max_queued;
+
+		if (cfqq->allocated[rw] < cfqd->cfq_queued)
+			return ELV_MQUEUE_MUST;
+
+		if (cfqd->busy_queues)
+			limit = q->nr_requests / cfqd->busy_queues;
 
-		if (limit < 3)
-			limit = 3;
+		if (limit < cfqd->cfq_queued)
+			limit = cfqd->cfq_queued;
 		else if (limit > cfqd->max_queued)
 			limit = cfqd->max_queued;
 
-		if (cfqq->queued[rw] > limit)
-			ret = 0;
+		if (cfqq->allocated[rw] >= limit) {
+			if (limit > cfqq->alloc_limit[rw])
+				cfqq->alloc_limit[rw] = limit;
+
+			ret = ELV_MQUEUE_NO;
+		}
 	}
-out:
+
 	return ret;
 }
 
+static void cfq_check_waiters(request_queue_t *q, struct cfq_queue *cfqq)
+{
+	struct request_list *rl = &q->rq;
+	const int write = waitqueue_active(&rl->wait[WRITE]);
+	const int read = waitqueue_active(&rl->wait[READ]);
+
+	if (read && cfqq->allocated[READ] < cfqq->alloc_limit[READ])
+		wake_up(&rl->wait[READ]);
+	if (write && cfqq->allocated[WRITE] < cfqq->alloc_limit[WRITE])
+		wake_up(&rl->wait[WRITE]);
+}
+
+/*
+ * queue lock held here
+ */
 static void cfq_put_request(request_queue_t *q, struct request *rq)
 {
 	struct cfq_data *cfqd = q->elevator.elevator_data;
 	struct cfq_rq *crq = RQ_DATA(rq);
-	struct request_list *rl;
-	int other_rw;
+	const int rw = rq_data_dir(rq);
 
 	if (crq) {
+		struct cfq_queue *cfqq = crq->cfq_queue;
+
 		BUG_ON(q->last_merge == rq);
-		BUG_ON(ON_MHASH(crq));
+		BUG_ON(!hlist_unhashed(&crq->hash));
+
+		if (crq->io_context)
+			put_io_context(crq->io_context->ioc);
 
 		mempool_free(crq, cfqd->crq_pool);
 		rq->elevator_private = NULL;
-	}
 
-	/*
-	 * work-around for may_queue "bug": if a read gets issued and refused
-	 * to queue because writes ate all the allowed slots and no other
-	 * reads are pending for this queue, it could get stuck infinitely
-	 * since freed_request() only checks the waitqueue for writes when
-	 * freeing them. or vice versa for a single write vs many reads.
-	 * so check here whether "the other" data direction might be able
-	 * to queue and wake them
-	 */
-	rl = &q->rq;
-	other_rw = rq_data_dir(rq) ^ 1;
-	if (rl->count[other_rw] <= q->nr_requests) {
+		BUG_ON(!cfqq->allocated[rw]);
+		cfqq->allocated[rw]--;
+
 		smp_mb();
-		if (waitqueue_active(&rl->wait[other_rw]))
-			wake_up(&rl->wait[other_rw]);
+		cfq_check_waiters(q, cfqq);
+		cfq_put_queue(cfqq);
 	}
 }
 
+/*
+ * Allocate cfq data structures associated with this request. A queue and
+ */
 static int cfq_set_request(request_queue_t *q, struct request *rq, int gfp_mask)
 {
 	struct cfq_data *cfqd = q->elevator.elevator_data;
+	struct cfq_io_context *cic;
+	const int rw = rq_data_dir(rq);
 	struct cfq_queue *cfqq;
 	struct cfq_rq *crq;
+	unsigned long flags;
+
+	might_sleep_if(gfp_mask & __GFP_WAIT);
+
+	spin_lock_irqsave(q->queue_lock, flags);
+
+	cfqq = __cfq_get_queue(cfqd, cfq_hash_key(cfqd, current), gfp_mask);
+	if (!cfqq) {
+#if 0
+		cfqq = cfq_get_queue(cfqd, CFQ_KEY_SPARE, gfp_mask);
+		printk("%s: got spare queue\n", current->comm);
+#else
+		goto out_lock;
+#endif
+	}
+
+	if (cfqq->allocated[rw] >= cfqd->max_queued)
+		goto out_lock;
+
+	spin_unlock_irqrestore(q->queue_lock, flags);
 
 	/*
-	 * prepare a queue up front, so cfq_enqueue() doesn't have to
+	 * if hashing type has changed, the cfq_queue might change here. we
+	 * don't bother rechecking ->allocated since it should be a rare
+	 * event
 	 */
-	cfqq = cfq_get_queue(cfqd, current->tgid, gfp_mask);
-	if (!cfqq)
-		return 1;
+	cic = cfq_get_io_context(&cfqq, gfp_mask);
+	if (!cic)
+		goto err;
 
 	crq = mempool_alloc(cfqd->crq_pool, gfp_mask);
 	if (crq) {
-		memset(crq, 0, sizeof(*crq));
 		RB_CLEAR(&crq->rb_node);
+		crq->rb_key = 0;
 		crq->request = rq;
-		crq->cfq_queue = NULL;
-		INIT_LIST_HEAD(&crq->hash);
+		INIT_HLIST_NODE(&crq->hash);
+		crq->cfq_queue = cfqq;
+		crq->io_context = cic;
+		crq->service_start = crq->queue_start = 0;
+		crq->in_flight = crq->accounted = crq->is_sync = 0;
 		rq->elevator_private = crq;
+		cfqq->allocated[rw]++;
+		cfqq->alloc_limit[rw] = 0;
 		return 0;
 	}
 
+	put_io_context(cic->ioc);
+err:
+	spin_lock_irqsave(q->queue_lock, flags);
+	cfq_put_queue(cfqq);
+out_lock:
+	spin_unlock_irqrestore(q->queue_lock, flags);
 	return 1;
 }
 
 static void cfq_exit(request_queue_t *q, elevator_t *e)
 {
 	struct cfq_data *cfqd = e->elevator_data;
+	struct cfq_queue *cfqq;
+
+	/*
+	 * kill spare queue, getting it means we have two refences to it.
+	 * drop both
+	 */
+	spin_lock_irq(q->queue_lock);
+	cfqq = __cfq_get_queue(cfqd, CFQ_KEY_SPARE, GFP_ATOMIC);
+	cfq_put_queue(cfqq);
+	cfq_put_queue(cfqq);
+	spin_unlock_irq(q->queue_lock);
 
 	e->elevator_data = NULL;
 	mempool_destroy(cfqd->crq_pool);
@@ -693,6 +1455,7 @@
 static int cfq_init(request_queue_t *q, elevator_t *e)
 {
 	struct cfq_data *cfqd;
+	struct cfq_queue *cfqq;
 	int i;
 
 	cfqd = kmalloc(sizeof(*cfqd), GFP_KERNEL);
@@ -701,12 +1464,13 @@
 
 	memset(cfqd, 0, sizeof(*cfqd));
 	INIT_LIST_HEAD(&cfqd->rr_list);
+	INIT_LIST_HEAD(&cfqd->empty_list);
 
-	cfqd->crq_hash = kmalloc(sizeof(struct list_head) * CFQ_MHASH_ENTRIES, GFP_KERNEL);
+	cfqd->crq_hash = kmalloc(sizeof(struct hlist_head) * CFQ_MHASH_ENTRIES, GFP_KERNEL);
 	if (!cfqd->crq_hash)
 		goto out_crqhash;
 
-	cfqd->cfq_hash = kmalloc(sizeof(struct list_head) * CFQ_QHASH_ENTRIES, GFP_KERNEL);
+	cfqd->cfq_hash = kmalloc(sizeof(struct hlist_head) * CFQ_QHASH_ENTRIES, GFP_KERNEL);
 	if (!cfqd->cfq_hash)
 		goto out_cfqhash;
 
@@ -715,25 +1479,42 @@
 		goto out_crqpool;
 
 	for (i = 0; i < CFQ_MHASH_ENTRIES; i++)
-		INIT_LIST_HEAD(&cfqd->crq_hash[i]);
+		INIT_HLIST_HEAD(&cfqd->crq_hash[i]);
 	for (i = 0; i < CFQ_QHASH_ENTRIES; i++)
-		INIT_LIST_HEAD(&cfqd->cfq_hash[i]);
+		INIT_HLIST_HEAD(&cfqd->cfq_hash[i]);
 
-	cfqd->dispatch = &q->queue_head;
 	e->elevator_data = cfqd;
 	cfqd->queue = q;
 
 	/*
+	 * setup spare failure queue
+	 */
+	cfqq = cfq_get_queue(cfqd, CFQ_KEY_SPARE, GFP_KERNEL);
+	if (!cfqq)
+		goto out_spare;
+
+	/*
 	 * just set it to some high value, we want anyone to be able to queue
 	 * some requests. fairness is handled differently
 	 */
-	cfqd->max_queued = q->nr_requests;
-	q->nr_requests = 8192;
+	q->nr_requests = 1024;
+	cfqd->max_queued = q->nr_requests / 16;
+	q->nr_batching = cfq_queued;
+	cfqd->key_type = CFQ_KEY_TGID;
+	cfqd->find_best_crq = 1;
 
 	cfqd->cfq_queued = cfq_queued;
 	cfqd->cfq_quantum = cfq_quantum;
+	cfqd->cfq_fifo_expire_r = cfq_fifo_expire_r;
+	cfqd->cfq_fifo_expire_w = cfq_fifo_expire_w;
+	cfqd->cfq_fifo_batch_expire = cfq_fifo_rate;
+	cfqd->cfq_back_max = cfq_back_max;
+	cfqd->cfq_back_penalty = cfq_back_penalty;
 
+	dprintk("cfq on queue 0x%p\n", q);
 	return 0;
+out_spare:
+	mempool_destroy(cfqd->crq_pool);
 out_crqpool:
 	kfree(cfqd->cfq_hash);
 out_cfqhash:
@@ -747,20 +1528,18 @@
 {
 	crq_pool = kmem_cache_create("crq_pool", sizeof(struct cfq_rq), 0, 0,
 					NULL, NULL);
-
 	if (!crq_pool)
 		panic("cfq_iosched: can't init crq pool\n");
 
 	cfq_pool = kmem_cache_create("cfq_pool", sizeof(struct cfq_queue), 0, 0,
 					NULL, NULL);
-
 	if (!cfq_pool)
 		panic("cfq_iosched: can't init cfq pool\n");
 
-	cfq_mpool = mempool_create(64, mempool_alloc_slab, mempool_free_slab, cfq_pool);
-
-	if (!cfq_mpool)
-		panic("cfq_iosched: can't init cfq mpool\n");
+	cfq_ioc_pool = kmem_cache_create("cfq_ioc_pool",
+			sizeof(struct cfq_io_context), 0, 0, NULL, NULL);
+	if (!cfq_ioc_pool)
+		panic("cfq_iosched: can't init ioc pool\n");
 
 	return 0;
 }
@@ -791,6 +1570,83 @@
 	return count;
 }
 
+static ssize_t
+cfq_clear_elapsed(struct cfq_data *cfqd, const char *page, size_t count)
+{
+	max_elapsed_dispatch = max_elapsed_crq = 0;
+	return count;
+}
+
+static ssize_t
+cfq_set_key_type(struct cfq_data *cfqd, const char *page, size_t count)
+{
+	spin_lock_irq(cfqd->queue->queue_lock);
+	if (!strncmp(page, "pgid", 4))
+		cfqd->key_type = CFQ_KEY_PGID;
+	else if (!strncmp(page, "tgid", 4))
+		cfqd->key_type = CFQ_KEY_TGID;
+	else if (!strncmp(page, "uid", 3))
+		cfqd->key_type = CFQ_KEY_UID;
+	else if (!strncmp(page, "gid", 3))
+		cfqd->key_type = CFQ_KEY_GID;
+	spin_unlock_irq(cfqd->queue->queue_lock);
+	return count;
+}
+
+static ssize_t
+cfq_read_key_type(struct cfq_data *cfqd, char *page)
+{
+	ssize_t len = 0;
+	int i;
+
+	for (i = CFQ_KEY_PGID; i < CFQ_KEY_LAST; i++) {
+		if (cfqd->key_type == i)
+			len += sprintf(page+len, "[%s] ", cfq_key_types[i]);
+		else
+			len += sprintf(page+len, "%s ", cfq_key_types[i]);
+	}
+	len += sprintf(page+len, "\n");
+	return len;
+}
+
+static ssize_t
+cfq_status_show(struct cfq_data *cfqd, char *page)
+{
+	struct list_head *entry;
+	struct cfq_queue *cfqq;
+	ssize_t len;
+	int i = 0, queues;
+
+	len = sprintf(page, "Busy queues: %u\n", cfqd->busy_queues);
+	len += sprintf(page+len, "key type: %s\n", cfq_key_types[cfqd->key_type]);
+	len += sprintf(page+len, "last sector: %Lu\n", (u64) cfqd->last_sector);
+	len += sprintf(page+len, "max time in iosched: %lu\n", max_elapsed_dispatch);
+	len += sprintf(page+len, "max completion time: %lu\n", max_elapsed_crq);
+
+	len += sprintf(page+len, "Busy queue list:\n");
+	spin_lock_irq(cfqd->queue->queue_lock);
+	list_for_each(entry, &cfqd->rr_list) {
+		i++;
+		cfqq = list_entry_cfqq(entry);
+		len += sprintf(page+len, "  cfqq: key=%lu alloc=%d/%d, queued=%d/%d, last_fifo=%lu, service_used=%lu\n", cfqq->key, cfqq->allocated[0], cfqq->allocated[1], cfqq->queued[0], cfqq->queued[1], cfqq->last_fifo_expire, cfqq->service_used);
+	}
+	len += sprintf(page+len, "  busy queues total: %d\n", i);
+	queues = i;
+	
+	len += sprintf(page+len, "Empty queue list:\n");
+	i = 0;
+	list_for_each(entry, &cfqd->empty_list) {
+		i++;
+		cfqq = list_entry_cfqq(entry);
+		len += sprintf(page+len, "  cfqq: key=%lu alloc=%d/%d, queued=%d/%d, last_fifo=%lu, service_used=%lu\n", cfqq->key, cfqq->allocated[0], cfqq->allocated[1], cfqq->queued[0], cfqq->queued[1], cfqq->last_fifo_expire, cfqq->service_used);
+	}
+	len += sprintf(page+len, "  empty queues total: %d\n", i);
+	queues += i;
+	len += sprintf(page+len, "Total queues: %d\n", queues);
+	spin_unlock_irq(cfqd->queue->queue_lock);
+	return len;
+}
+
 #define SHOW_FUNCTION(__FUNC, __VAR)					\
 static ssize_t __FUNC(struct cfq_data *cfqd, char *page)		\
 {									\
@@ -798,6 +1654,13 @@
 }
 SHOW_FUNCTION(cfq_quantum_show, cfqd->cfq_quantum);
 SHOW_FUNCTION(cfq_queued_show, cfqd->cfq_queued);
+SHOW_FUNCTION(cfq_tagged_show, cfqd->cfq_tagged);
+SHOW_FUNCTION(cfq_fifo_expire_r_show, cfqd->cfq_fifo_expire_r);
+SHOW_FUNCTION(cfq_fifo_expire_w_show, cfqd->cfq_fifo_expire_w);
+SHOW_FUNCTION(cfq_fifo_batch_expire_show, cfqd->cfq_fifo_batch_expire);
+SHOW_FUNCTION(cfq_find_best_show, cfqd->find_best_crq);
+SHOW_FUNCTION(cfq_back_max_show, cfqd->cfq_back_max);
+SHOW_FUNCTION(cfq_back_penalty_show, cfqd->cfq_back_penalty);
 #undef SHOW_FUNCTION
 
 #define STORE_FUNCTION(__FUNC, __PTR, MIN, MAX)				\
@@ -810,8 +1673,15 @@
 		*(__PTR) = (MAX);					\
 	return ret;							\
 }
-STORE_FUNCTION(cfq_quantum_store, &cfqd->cfq_quantum, 1, INT_MAX);
-STORE_FUNCTION(cfq_queued_store, &cfqd->cfq_queued, 1, INT_MAX);
+STORE_FUNCTION(cfq_quantum_store, &cfqd->cfq_quantum, 1, UINT_MAX);
+STORE_FUNCTION(cfq_queued_store, &cfqd->cfq_queued, 1, UINT_MAX);
+STORE_FUNCTION(cfq_tagged_store, &cfqd->cfq_tagged, 0, 1);
+STORE_FUNCTION(cfq_fifo_expire_r_store, &cfqd->cfq_fifo_expire_r, 1, UINT_MAX);
+STORE_FUNCTION(cfq_fifo_expire_w_store, &cfqd->cfq_fifo_expire_w, 1, UINT_MAX);
+STORE_FUNCTION(cfq_fifo_batch_expire_store, &cfqd->cfq_fifo_batch_expire, 0, UINT_MAX);
+STORE_FUNCTION(cfq_find_best_store, &cfqd->find_best_crq, 0, 1);
+STORE_FUNCTION(cfq_back_max_store, &cfqd->cfq_back_max, 0, UINT_MAX);
+STORE_FUNCTION(cfq_back_penalty_store, &cfqd->cfq_back_penalty, 1, UINT_MAX);
 #undef STORE_FUNCTION
 
 static struct cfq_fs_entry cfq_quantum_entry = {
@@ -824,10 +1694,68 @@
 	.show = cfq_queued_show,
 	.store = cfq_queued_store,
 };
+static struct cfq_fs_entry cfq_tagged_entry = {
+	.attr = {.name = "tagged", .mode = S_IRUGO | S_IWUSR },
+	.show = cfq_tagged_show,
+	.store = cfq_tagged_store,
+};
+static struct cfq_fs_entry cfq_fifo_expire_r_entry = {
+	.attr = {.name = "fifo_expire_sync", .mode = S_IRUGO | S_IWUSR },
+	.show = cfq_fifo_expire_r_show,
+	.store = cfq_fifo_expire_r_store,
+};
+static struct cfq_fs_entry cfq_fifo_expire_w_entry = {
+	.attr = {.name = "fifo_expire_async", .mode = S_IRUGO | S_IWUSR },
+	.show = cfq_fifo_expire_w_show,
+	.store = cfq_fifo_expire_w_store,
+};
+static struct cfq_fs_entry cfq_fifo_batch_expire_entry = {
+	.attr = {.name = "fifo_batch_expire", .mode = S_IRUGO | S_IWUSR },
+	.show = cfq_fifo_batch_expire_show,
+	.store = cfq_fifo_batch_expire_store,
+};
+static struct cfq_fs_entry cfq_find_best_entry = {
+	.attr = {.name = "find_best_crq", .mode = S_IRUGO | S_IWUSR },
+	.show = cfq_find_best_show,
+	.store = cfq_find_best_store,
+};
+static struct cfq_fs_entry cfq_back_max_entry = {
+	.attr = {.name = "back_seek_max", .mode = S_IRUGO | S_IWUSR },
+	.show = cfq_back_max_show,
+	.store = cfq_back_max_store,
+};
+static struct cfq_fs_entry cfq_back_penalty_entry = {
+	.attr = {.name = "back_seek_penalty", .mode = S_IRUGO | S_IWUSR },
+	.show = cfq_back_penalty_show,
+	.store = cfq_back_penalty_store,
+};
+static struct cfq_fs_entry cfq_clear_elapsed_entry = {
+	.attr = {.name = "clear_elapsed", .mode = S_IWUSR },
+	.store = cfq_clear_elapsed,
+};
+static struct cfq_fs_entry cfq_misc_entry = {
+	.attr = {.name = "show_status", .mode = S_IRUGO },
+	.show = cfq_status_show,
+};
+static struct cfq_fs_entry cfq_key_type_entry = {
+	.attr = {.name = "key_type", .mode = S_IRUGO | S_IWUSR },
+	.show = cfq_read_key_type,
+	.store = cfq_set_key_type,
+};
 
 static struct attribute *default_attrs[] = {
 	&cfq_quantum_entry.attr,
 	&cfq_queued_entry.attr,
+	&cfq_tagged_entry.attr,
+	&cfq_fifo_expire_r_entry.attr,
+	&cfq_fifo_expire_w_entry.attr,
+	&cfq_fifo_batch_expire_entry.attr,
+	&cfq_key_type_entry.attr,
+	&cfq_find_best_entry.attr,
+	&cfq_back_max_entry.attr,
+	&cfq_back_penalty_entry.attr,
+	&cfq_clear_elapsed_entry.attr,
+	&cfq_misc_entry.attr,
 	NULL,
 };
 
@@ -878,6 +1806,7 @@
 	.elevator_add_req_fn =		cfq_insert_request,
 	.elevator_remove_req_fn =	cfq_remove_request,
 	.elevator_queue_empty_fn =	cfq_queue_empty,
+	.elevator_completed_req_fn =	cfq_completed_request,
 	.elevator_former_req_fn =	cfq_former_request,
 	.elevator_latter_req_fn =	cfq_latter_request,
 	.elevator_set_req_fn =		cfq_set_request,
===== drivers/block/elevator.c 1.58 vs edited =====
--- 1.58/drivers/block/elevator.c	2004-06-29 16:44:49 +02:00
+++ edited/drivers/block/elevator.c	2004-08-31 11:32:13 +02:00
@@ -346,7 +346,7 @@
 	if (e->elevator_may_queue_fn)
 		return e->elevator_may_queue_fn(q, rw);
 
-	return 0;
+	return ELV_MQUEUE_MAY;
 }
 
 void elv_completed_request(request_queue_t *q, struct request *rq)
===== drivers/block/ll_rw_blk.c 1.270 vs edited =====
--- 1.270/drivers/block/ll_rw_blk.c	2004-08-27 08:31:38 +02:00
+++ edited/drivers/block/ll_rw_blk.c	2004-09-03 23:22:48 +02:00
@@ -243,6 +243,7 @@
 	blk_queue_hardsect_size(q, 512);
 	blk_queue_dma_alignment(q, 511);
 	blk_queue_congestion_threshold(q);
+	q->nr_batching = BLK_BATCH_REQ;
 
 	q->unplug_thresh = 4;		/* hmm */
 	q->unplug_delay = (3 * HZ) / 1000;	/* 3 milliseconds */
@@ -1554,8 +1561,10 @@
 	/*
 	 * all done
 	 */
-	if (!elevator_init(q, chosen_elevator))
+	if (!elevator_init(q, chosen_elevator)) {
+		blk_queue_congestion_threshold(q);
 		return q;
+	}
 
 	blk_cleanup_queue(q);
 out_init:
@@ -1583,13 +1592,20 @@
 	mempool_free(rq, q->rq.rq_pool);
 }
 
-static inline struct request *blk_alloc_request(request_queue_t *q,int gfp_mask)
+static inline struct request *blk_alloc_request(request_queue_t *q, int rw,
+						int gfp_mask)
 {
 	struct request *rq = mempool_alloc(q->rq.rq_pool, gfp_mask);
 
 	if (!rq)
 		return NULL;
 
+	/*
+	 * first three bits are identical in rq->flags and bio->bi_rw,
+	 * see bio.h and blkdev.h
+	 */
+	rq->flags = rw;
+
 	if (!elv_set_request(q, rq, gfp_mask))
 		return rq;
 
@@ -1601,7 +1617,7 @@
  * ioc_batching returns true if the ioc is a valid batching request and
  * should be given priority access to a request.
  */
-static inline int ioc_batching(struct io_context *ioc)
+static inline int ioc_batching(request_queue_t *q, struct io_context *ioc)
 {
 	if (!ioc)
 		return 0;
@@ -1611,7 +1627,7 @@
 	 * even if the batch times out, otherwise we could theoretically
 	 * lose wakeups.
 	 */
-	return ioc->nr_batch_requests == BLK_BATCH_REQ ||
+	return ioc->nr_batch_requests == q->nr_batching ||
 		(ioc->nr_batch_requests > 0
 		&& time_before(jiffies, ioc->last_waited + BLK_BATCH_TIME));
 }
@@ -1622,12 +1638,12 @@
  * is the behaviour we want though - once it gets a wakeup it should be given
  * a nice run.
  */
-void ioc_set_batching(struct io_context *ioc)
+void ioc_set_batching(request_queue_t *q, struct io_context *ioc)
 {
-	if (!ioc || ioc_batching(ioc))
+	if (!ioc || ioc_batching(q, ioc))
 		return;
 
-	ioc->nr_batch_requests = BLK_BATCH_REQ;
+	ioc->nr_batch_requests = q->nr_batching;
 	ioc->last_waited = jiffies;
 }
 
@@ -1643,10 +1659,10 @@
 	if (rl->count[rw] < queue_congestion_off_threshold(q))
 		clear_queue_congested(q, rw);
 	if (rl->count[rw]+1 <= q->nr_requests) {
+		smp_mb();
 		if (waitqueue_active(&rl->wait[rw]))
 			wake_up(&rl->wait[rw]);
-		if (!waitqueue_active(&rl->wait[rw]))
-			blk_clear_queue_full(q, rw);
+		blk_clear_queue_full(q, rw);
 	}
 }
 
@@ -1669,13 +1685,22 @@
 		 * will be blocked.
 		 */
 		if (!blk_queue_full(q, rw)) {
-			ioc_set_batching(ioc);
+			ioc_set_batching(q, ioc);
 			blk_set_queue_full(q, rw);
 		}
 	}
 
-	if (blk_queue_full(q, rw)
-			&& !ioc_batching(ioc) && !elv_may_queue(q, rw)) {
+	switch (elv_may_queue(q, rw)) {
+		case ELV_MQUEUE_NO:
+			spin_unlock_irq(q->queue_lock);
+			goto out;
+		case ELV_MQUEUE_MAY:
+			break;
+		case ELV_MQUEUE_MUST:
+			goto get_rq;
+	}
+
+	if (blk_queue_full(q, rw) && !ioc_batching(q, ioc)) {
 		/*
 		 * The queue is full and the allocating process is not a
 		 * "batcher", and not exempted by the IO scheduler
@@ -1684,12 +1709,15 @@
 		goto out;
 	}
 
+get_rq:
 	rl->count[rw]++;
+#if 0
 	if (rl->count[rw] >= queue_congestion_on_threshold(q))
 		set_queue_congested(q, rw);
+#endif
 	spin_unlock_irq(q->queue_lock);
 
-	rq = blk_alloc_request(q, gfp_mask);
+	rq = blk_alloc_request(q, rw, gfp_mask);
 	if (!rq) {
 		/*
 		 * Allocation failed presumably due to memory. Undo anything
@@ -1704,17 +1732,11 @@
 		goto out;
 	}
 
-	if (ioc_batching(ioc))
+	if (ioc_batching(q, ioc))
 		ioc->nr_batch_requests--;
 	
 	INIT_LIST_HEAD(&rq->queuelist);
 
-	/*
-	 * first three bits are identical in rq->flags and bio->bi_rw,
-	 * see bio.h and blkdev.h
-	 */
-	rq->flags = rw;
-
 	rq->errors = 0;
 	rq->rq_status = RQ_ACTIVE;
 	rq->bio = rq->biotail = NULL;
@@ -1763,7 +1785,7 @@
 			 * See ioc_batching, ioc_set_batching
 			 */
 			ioc = get_io_context(GFP_NOIO);
-			ioc_set_batching(ioc);
+			ioc_set_batching(q, ioc);
 			put_io_context(ioc);
 		}
 		finish_wait(&rl->wait[rw], &wait);
@@ -3051,6 +3073,9 @@
 	if (atomic_dec_and_test(&ioc->refcount)) {
 		if (ioc->aic && ioc->aic->dtor)
 			ioc->aic->dtor(ioc->aic);
+		if (ioc->cic && ioc->cic->dtor)
+			ioc->cic->dtor(ioc->cic);
+
 		kmem_cache_free(iocontext_cachep, ioc);
 	}
 }
@@ -3063,14 +3088,15 @@
 
 	local_irq_save(flags);
 	ioc = current->io_context;
-	if (ioc) {
-		if (ioc->aic && ioc->aic->exit)
-			ioc->aic->exit(ioc->aic);
-		put_io_context(ioc);
-		current->io_context = NULL;
-	} else
-		WARN_ON(1);
+	current->io_context = NULL;
 	local_irq_restore(flags);
+
+	if (ioc->aic && ioc->aic->exit)
+		ioc->aic->exit(ioc->aic);
+	if (ioc->cic && ioc->cic->exit)
+		ioc->cic->exit(ioc->cic);
+
+	put_io_context(ioc);
 }
 
 /*
@@ -3089,20 +3115,39 @@
 
 	local_irq_save(flags);
 	ret = tsk->io_context;
-	if (ret == NULL) {
-		ret = kmem_cache_alloc(iocontext_cachep, GFP_ATOMIC);
-		if (ret) {
-			atomic_set(&ret->refcount, 1);
-			ret->pid = tsk->pid;
-			ret->last_waited = jiffies; /* doesn't matter... */
-			ret->nr_batch_requests = 0; /* because this is 0 */
-			ret->aic = NULL;
+	if (ret)
+		goto out;
+
+	local_irq_restore(flags);
+
+	ret = kmem_cache_alloc(iocontext_cachep, gfp_flags);
+	if (ret) {
+		atomic_set(&ret->refcount, 1);
+		ret->pid = tsk->pid;
+		ret->last_waited = jiffies; /* doesn't matter... */
+		ret->nr_batch_requests = 0; /* because this is 0 */
+		ret->aic = NULL;
+		ret->cic = NULL;
+		spin_lock_init(&ret->lock);
+
+		local_irq_save(flags);
+
+		/*
+		 * very unlikely, someone raced with us in setting up the task
+		 * io context. free new context and just grab a reference.
+		 */
+		if (!tsk->io_context)
 			tsk->io_context = ret;
+		else {
+			kmem_cache_free(iocontext_cachep, ret);
+			ret = tsk->io_context;
 		}
-	}
-	if (ret)
+			
+out:
 		atomic_inc(&ret->refcount);
-	local_irq_restore(flags);
+		local_irq_restore(flags);
+	}
+
 	return ret;
 }
 
===== include/linux/blkdev.h 1.151 vs edited =====
--- 1.151/include/linux/blkdev.h	2004-08-23 10:14:45 +02:00
+++ edited/include/linux/blkdev.h	2004-08-31 14:44:26 +02:00
@@ -52,6 +52,20 @@
 	sector_t seek_mean;
 };
 
+struct cfq_queue;
+struct cfq_io_context {
+	void (*dtor)(struct cfq_io_context *);
+	void (*exit)(struct cfq_io_context *);
+
+	struct io_context *ioc;
+
+	/*
+	 * circular list of cfq_io_contexts belonging to a process io context
+	 */
+	struct list_head list;
+	struct cfq_queue *cfqq;
+};
+
 /*
  * This is the per-process I/O subsystem state.  It is refcounted and
  * kmalloc'ed. Currently all fields are modified in process io context
@@ -67,7 +81,10 @@
 	unsigned long last_waited; /* Time last woken after wait for request */
 	int nr_batch_requests;     /* Number of requests left in the batch */
 
+	spinlock_t lock;
+
 	struct as_io_context *aic;
+	struct cfq_io_context *cic;
 };
 
 void put_io_context(struct io_context *ioc);
@@ -342,6 +359,7 @@
 	unsigned long		nr_requests;	/* Max # of requests */
 	unsigned int		nr_congestion_on;
 	unsigned int		nr_congestion_off;
+	unsigned int		nr_batching;
 
 	unsigned short		max_sectors;
 	unsigned short		max_phys_segments;
===== include/linux/elevator.h 1.31 vs edited =====
--- 1.31/include/linux/elevator.h	2004-04-12 19:55:20 +02:00
+++ edited/include/linux/elevator.h	2004-09-02 16:50:50 +02:00
@@ -118,5 +119,14 @@
 #define ELEVATOR_INSERT_FRONT	1
 #define ELEVATOR_INSERT_BACK	2
 #define ELEVATOR_INSERT_SORT	3
+
+/*
+ * return values from elevator_may_queue_fn
+ */
+enum {
+	ELV_MQUEUE_MAY,
+	ELV_MQUEUE_NO,
+	ELV_MQUEUE_MUST,
+};
 
 #endif

-- 
Jens Axboe

