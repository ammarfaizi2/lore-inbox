Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261606AbULBNKJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261606AbULBNKJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 08:10:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261605AbULBNKJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 08:10:09 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:17843 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261607AbULBNF1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 08:05:27 -0500
Date: Thu, 2 Dec 2004 14:04:57 +0100
From: Jens Axboe <axboe@suse.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Time sliced CFQ io scheduler
Message-ID: <20041202130457.GC10458@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Some time ago I pondered modifying CFQ to do fairness based on slices of
disk time. It appeared to be a minor modification, but with some nice
bonus points:

- It scales nicely with CPU scheduler slices, making io priorities a
  zinch to implement.

- It has the possibility to equal the anticipatory scheduler for
  multiple processes competing for disk bandwidth

So I implemented it and ran some tests, the results are pretty
astonishing. A note on the testcases - read_files and write_files. They
either read or write a number of files sequentially or randomly, each
file has io being done to it by a specific process. IO bypasses the page
cache by using O_DIRECT. Runtime is capped at 30 seconds for each test.
Each test case was run on deadline, as, and new cfq. Drive used was an
IDE drive (results similar for SCSI), fs used was ext2.

Scroll past results for the executive summary.

Case 1: read_files, sequential, bs=4k
-------------------------------------

Scheduler: deadline

Clients   Max bwidth   Min bdwidth   Agg bdwidth   Max latency
   1        19837         19837         19837        22msec
   2         2116          2114          4230        22msec
   4          361           360          1444        41msec
   8          150           149          1201       111msec

Note: bandwidth quickly becomes seek bound as clients are added.

Scheduler: as

Clients   Max bwidth   Min bdwidth   Agg bdwidth   Max latency
   1        19480         19480         19480        30msec
   2         9250          9189         18434       261msec
   4         4513          4469         17970       488msec
   8         2238          2157         17581       934msec

Note: as maintains good aggregate bandwidth as clients are added, while
still being fair between clients. Latency rises quickly.

Schedule: cfq

Clients   Max bwidth   Min bdwidth   Agg bdwidth   Max latency
   1        19433         19433         19433         9msec
   2         8686          8628         17312        90msec
   4         4507          4471         17963       254msec
   8         2181          2104         17134       578msec

Note: cfq performs close to as. Aggregate bandwidth doesn't suffer with
added clients, inter-client latency and throughput excellent. Latency
half that of as.


Case 2: read_files, random, bs=64k
-------------------------------------

Scheduler: deadline

Clients   Max bwidth   Min bdwidth   Agg bdwidth   Max latency
   1         7042          7042          7042        20msec
   2         3052          3051          6103        28msec
   4         1560          1498          6124       101msec
   8          802           581          5487       231msec

Scheduler: as

Clients   Max bwidth   Min bdwidth   Agg bdwidth   Max latency
   1         7041          7041          7041        18msec
   2         4616          2298          6912       270msec
   4         3190           928          6901       360msec
   8         1524           645          6765       636msec

Note: Aggregate bandwidth remains good, has big problems with
inter-client fairness.

Scheduler: cfq

Clients   Max bwidth   Min bdwidth   Agg bdwidth   Max latency
   1         7027          7027          7027        19msec
   2         3429          3413          6841       107msec
   4         1718          1700          6844       282msec
   8          875           827          6795       627msec

Note: Aggregate bandwidth remains good and basically identical to as,
ditto for the latencies where cfq is a little better though.
inter-client fairness very good.


Case 3: write_files, sequential, bs=4k
-------------------------------------

Scheduler: deadline

Clients   Max bwidth   Min bdwidth   Agg bdwidth   Max latency
   1        13406         13406         13406        21msec
   2         1553          1551          3104       171msec
   4          690           689          2759       116msec
   8          329           318          2604       106msec

Note: Aggregate bandwidth quickly drops with number of clients. Latency
is good.

Scheduler: as

Clients   Max bwidth   Min bdwidth   Agg bdwidth   Max latency
   1        13330         13330         13330        21msec
   2         2694          2694          5388        77msec
   4         1754            17          4988       762msec
   8          638           342          3866       848msec

Note: Aggregate bandwidth better than deadline, but still not very good.
Latency not good. inter-client horrible.

Scheduler: cfq

Clients   Max bwidth   Min bdwidth   Agg bdwidth   Max latency
   1        13267         13267         13267        30msec
   2         6352          6150         12459       239msec
   4         3230          2945         12524       289msec
   8         1640          1640         12564       599msec

Note: Aggregate bandwidth remains high with added clients
ditto for the latencies where cfq is a little better though.
inter-client fairness very good.


Case 4: write_files, random, bs=4k
-------------------------------------

Scheduler: deadline

Clients   Max bwidth   Min bdwidth   Agg bdwidth   Max latency
   1         6749          6749          6749       112msec
   2         1299          1277          2574       813msec
   4          432           418          1715       227msec
   8          291           247          2147      1723msec

Note: Same again for deadline - aggregate bandwidth really drops with
adding clients, but at least client fairness is good.

Scheduler: as

Clients   Max bwidth   Min bdwidth   Agg bdwidth   Max latency
   1         4110          4110          4110       114msec
   2          815           809          1623       631msec
   4          482           349          1760       606msec
   8          476           111          2863       752msec

Note: Does generally worse than deadline and has fairness issues.

Scheduler: cfq

Clients   Max bwidth   Min bdwidth   Agg bdwidth   Max latency
   1         4493          4493          4493       129msec
   2         1710          1513          3216       321msec
   4          521           482          2002       476msec
   8          938           877          7210       927msec


Good results for such a quick hack, I'm generally surprised how well it
does without any tuning. The results above use the default settings for
cfq slices: 83ms slice time with allowed 4ms idle period (queues are
preempted if they exceed this idle time). With the disk time slices,
aggregate performance bandwidth stays close to real disk performance
even with many clients.

Patch against BK-current as of today.

===== drivers/block/cfq-iosched.c 1.15 vs edited =====
--- 1.15/drivers/block/cfq-iosched.c	2004-11-30 07:56:58 +01:00
+++ edited/drivers/block/cfq-iosched.c	2004-12-02 14:03:56 +01:00
@@ -22,21 +22,22 @@
 #include <linux/rbtree.h>
 #include <linux/mempool.h>
 
-static unsigned long max_elapsed_crq;
-static unsigned long max_elapsed_dispatch;
-
 /*
  * tunables
  */
 static int cfq_quantum = 4;		/* max queue in one round of service */
 static int cfq_queued = 8;		/* minimum rq allocate limit per-queue*/
-static int cfq_service = HZ;		/* period over which service is avg */
 static int cfq_fifo_expire_r = HZ / 2;	/* fifo timeout for sync requests */
 static int cfq_fifo_expire_w = 5 * HZ;	/* fifo timeout for async requests */
 static int cfq_fifo_rate = HZ / 8;	/* fifo expiry rate */
 static int cfq_back_max = 16 * 1024;	/* maximum backwards seek, in KiB */
 static int cfq_back_penalty = 2;	/* penalty of a backwards seek */
 
+static int cfq_slice = HZ / 12;
+static int cfq_idle = HZ / 249;
+
+static int cfq_max_depth = 4;
+
 /*
  * for the hash of cfqq inside the cfqd
  */
@@ -55,6 +56,7 @@
 #define list_entry_hash(ptr)	hlist_entry((ptr), struct cfq_rq, hash)
 
 #define list_entry_cfqq(ptr)	list_entry((ptr), struct cfq_queue, cfq_list)
+#define list_entry_fifo(ptr)	list_entry((ptr), struct request, queuelist)
 
 #define RQ_DATA(rq)		(rq)->elevator_private
 
@@ -76,22 +78,18 @@
 #define rq_rb_key(rq)		(rq)->sector
 
 /*
- * threshold for switching off non-tag accounting
- */
-#define CFQ_MAX_TAG		(4)
-
-/*
  * sort key types and names
  */
 enum {
 	CFQ_KEY_PGID,
 	CFQ_KEY_TGID,
+	CFQ_KEY_PID,
 	CFQ_KEY_UID,
 	CFQ_KEY_GID,
 	CFQ_KEY_LAST,
 };
 
-static char *cfq_key_types[] = { "pgid", "tgid", "uid", "gid", NULL };
+static char *cfq_key_types[] = { "pgid", "tgid", "pid", "uid", "gid", NULL };
 
 /*
  * spare queue
@@ -103,6 +101,8 @@
 static kmem_cache_t *cfq_ioc_pool;
 
 struct cfq_data {
+	atomic_t ref;
+
 	struct list_head rr_list;
 	struct list_head empty_list;
 
@@ -114,8 +114,6 @@
 
 	unsigned int max_queued;
 
-	atomic_t ref;
-
 	int key_type;
 
 	mempool_t *crq_pool;
@@ -127,6 +125,14 @@
 	int rq_in_driver;
 
 	/*
+	 * schedule slice state info
+	 */
+	struct timer_list timer;
+	struct work_struct unplug_work;
+	struct cfq_queue *active_queue;
+	unsigned int dispatch_slice;
+
+	/*
 	 * tunables, see top of file
 	 */
 	unsigned int cfq_quantum;
@@ -137,8 +143,9 @@
 	unsigned int cfq_back_penalty;
 	unsigned int cfq_back_max;
 	unsigned int find_best_crq;
-
-	unsigned int cfq_tagged;
+	unsigned int cfq_slice;
+	unsigned int cfq_idle;
+	unsigned int cfq_max_depth;
 };
 
 struct cfq_queue {
@@ -150,8 +157,6 @@
 	struct hlist_node cfq_hash;
 	/* hash key */
 	unsigned long key;
-	/* whether queue is on rr (or empty) list */
-	int on_rr;
 	/* on either rr or empty list of cfqd */
 	struct list_head cfq_list;
 	/* sorted list of pending requests */
@@ -169,15 +174,22 @@
 
 	int key_type;
 
-	unsigned long service_start;
+	unsigned long slice_start;
 	unsigned long service_used;
+	unsigned long service_rq;
+	unsigned long service_last;
 
-	unsigned int max_rate;
+	/* whether queue is on rr (or empty) list */
+	unsigned int on_rr : 1;
+	unsigned int wait_request : 1;
+	unsigned int must_dispatch : 1;
 
 	/* number of requests that have been handed to the driver */
 	int in_flight;
 	/* number of currently allocated requests */
 	int alloc_limit[2];
+	/* last rq was sync */
+	char name[16];
 };
 
 struct cfq_rq {
@@ -219,6 +231,8 @@
 		default:
 		case CFQ_KEY_TGID:
 			return tsk->tgid;
+		case CFQ_KEY_PID:
+			return tsk->pid;
 		case CFQ_KEY_UID:
 			return tsk->uid;
 		case CFQ_KEY_GID:
@@ -309,7 +323,7 @@
 
 			if (blk_barrier_rq(rq))
 				break;
-
+	
 			if (distance < abs(s1 - rq->sector + rq->nr_sectors)) {
 				distance = abs(s1 - rq->sector +rq->nr_sectors);
 				last = rq->sector + rq->nr_sectors;
@@ -406,67 +420,22 @@
 		cfqq->next_crq = cfq_find_next_crq(cfqq->cfqd, cfqq, crq);
 }
 
-static int cfq_check_sort_rr_list(struct cfq_queue *cfqq)
-{
-	struct list_head *head = &cfqq->cfqd->rr_list;
-	struct list_head *next, *prev;
-
-	/*
-	 * list might still be ordered
-	 */
-	next = cfqq->cfq_list.next;
-	if (next != head) {
-		struct cfq_queue *cnext = list_entry_cfqq(next);
-
-		if (cfqq->service_used > cnext->service_used)
-			return 1;
-	}
-
-	prev = cfqq->cfq_list.prev;
-	if (prev != head) {
-		struct cfq_queue *cprev = list_entry_cfqq(prev);
-
-		if (cfqq->service_used < cprev->service_used)
-			return 1;
-	}
-
-	return 0;
-}
-
-static void cfq_sort_rr_list(struct cfq_queue *cfqq, int new_queue)
+static void cfq_resort_rr_list(struct cfq_queue *cfqq)
 {
 	struct list_head *entry = &cfqq->cfqd->rr_list;
 
-	if (!cfqq->on_rr)
-		return;
-	if (!new_queue && !cfq_check_sort_rr_list(cfqq))
-		return;
-
 	list_del(&cfqq->cfq_list);
 
 	/*
-	 * sort by our mean service_used, sub-sort by in-flight requests
+	 * sort by when queue was last serviced
 	 */
 	while ((entry = entry->prev) != &cfqq->cfqd->rr_list) {
 		struct cfq_queue *__cfqq = list_entry_cfqq(entry);
 
-		if (cfqq->service_used > __cfqq->service_used)
+		if (!__cfqq->service_last)
+			break;
+		if (time_before(__cfqq->service_last, cfqq->service_last))
 			break;
-		else if (cfqq->service_used == __cfqq->service_used) {
-			struct list_head *prv;
-
-			while ((prv = entry->prev) != &cfqq->cfqd->rr_list) {
-				__cfqq = list_entry_cfqq(prv);
-
-				WARN_ON(__cfqq->service_used > cfqq->service_used);
-				if (cfqq->service_used != __cfqq->service_used)
-					break;
-				if (cfqq->in_flight > __cfqq->in_flight)
-					break;
-
-				entry = prv;
-			}
-		}
 	}
 
 	list_add(&cfqq->cfq_list, entry);
@@ -479,16 +448,12 @@
 static inline void
 cfq_add_cfqq_rr(struct cfq_data *cfqd, struct cfq_queue *cfqq)
 {
-	/*
-	 * it's currently on the empty list
-	 */
-	cfqq->on_rr = 1;
-	cfqd->busy_queues++;
+	BUG_ON(cfqq->on_rr);
 
-	if (time_after(jiffies, cfqq->service_start + cfq_service))
-		cfqq->service_used >>= 3;
+	cfqd->busy_queues++;
+	cfqq->on_rr = 1;
 
-	cfq_sort_rr_list(cfqq, 1);
+	cfq_resort_rr_list(cfqq);
 }
 
 static inline void
@@ -512,10 +477,10 @@
 		struct cfq_data *cfqd = cfqq->cfqd;
 
 		BUG_ON(!cfqq->queued[crq->is_sync]);
+		cfqq->queued[crq->is_sync]--;
 
 		cfq_update_next_crq(crq);
 
-		cfqq->queued[crq->is_sync]--;
 		rb_erase(&crq->rb_node, &cfqq->sort_list);
 		RB_CLEAR_COLOR(&crq->rb_node);
 
@@ -622,11 +587,6 @@
 	if (crq) {
 		struct cfq_queue *cfqq = crq->cfq_queue;
 
-		if (cfqq->cfqd->cfq_tagged) {
-			cfqq->service_used--;
-			cfq_sort_rr_list(cfqq, 0);
-		}
-
 		crq->accounted = 0;
 		cfqq->cfqd->rq_in_driver--;
 	}
@@ -640,9 +600,7 @@
 	if (crq) {
 		cfq_remove_merge_hints(q, crq);
 		list_del_init(&rq->queuelist);
-
-		if (crq->cfq_queue)
-			cfq_del_crq_rb(crq);
+		cfq_del_crq_rb(crq);
 	}
 }
 
@@ -724,6 +682,101 @@
 }
 
 /*
+ * current cfqq expired its slice (or was too idle), select new one
+ */
+static inline void cfq_slice_expired(struct cfq_data *cfqd)
+{
+	struct cfq_queue *cfqq = cfqd->active_queue;
+	unsigned long now = jiffies;
+
+	if (cfqq) {
+		if (cfqq->wait_request)
+			del_timer(&cfqd->timer);
+
+		cfqq->service_used += now - cfqq->slice_start;
+		cfqq->service_rq += cfqd->dispatch_slice;
+		cfqq->service_last = now;
+		cfqq->must_dispatch = 0;
+
+		if (cfqq->on_rr)
+			cfq_resort_rr_list(cfqq);
+
+		cfqq = NULL;
+	}
+
+	if (!list_empty(&cfqd->rr_list)) {
+		cfqq = list_entry_cfqq(cfqd->rr_list.next);
+
+		cfqq->slice_start = now;
+		cfqq->wait_request = 0;
+	}
+
+	cfqd->active_queue = cfqq;
+	cfqd->dispatch_slice = 0;
+}
+
+static int cfq_arm_slice_timer(struct cfq_data *cfqd, struct cfq_queue *cfqq)
+{
+	WARN_ON(!RB_EMPTY(&cfqq->sort_list));
+
+	cfqq->wait_request = 1;
+
+	if (!cfqd->cfq_idle)
+		return 0;
+
+	if (!timer_pending(&cfqd->timer)) {
+		unsigned long now = jiffies, slice_left;
+
+		slice_left = cfqd->cfq_slice - (now - cfqq->slice_start);
+		cfqd->timer.expires = now + min(cfqd->cfq_idle,(unsigned int)slice_left);
+		add_timer(&cfqd->timer);
+	}
+
+	return 1;
+}
+
+/*
+ * get next queue for service
+ */
+static struct cfq_queue *cfq_select_queue(struct cfq_data *cfqd)
+{
+	struct cfq_queue *cfqq = cfqd->active_queue;
+	unsigned long slice_used;
+
+	cfqq = cfqd->active_queue;
+	if (!cfqq)
+		goto new_queue;
+
+	slice_used = jiffies - cfqq->slice_start;
+
+	if (cfqq->must_dispatch)
+		goto must_queue;
+
+	/*
+	 * slice has expired
+	 */
+	if (slice_used >= cfqd->cfq_slice)
+		goto new_queue;
+
+	/*
+	 * if queue has requests, dispatch one. if not, check if
+	 * enough slice is left to wait for one
+	 */
+must_queue:
+	if (!RB_EMPTY(&cfqq->sort_list))
+		goto keep_queue;
+	else if (cfqd->cfq_slice - slice_used >= cfqd->cfq_idle) {
+		if (cfq_arm_slice_timer(cfqd, cfqq))
+			return NULL;
+	}
+
+new_queue:
+	cfq_slice_expired(cfqd);
+keep_queue:
+	return cfqd->active_queue;
+}
+
+/*
  * we dispatch cfqd->cfq_quantum requests in total from the rr_list queues,
  * this function sector sorts the selected request to minimize seeks. we start
  * at cfqd->last_sector, not 0.
@@ -741,9 +794,7 @@
 	list_del(&crq->request->queuelist);
 
 	last = cfqd->last_sector;
-	while ((entry = entry->prev) != head) {
-		__rq = list_entry_rq(entry);
-
+	list_for_each_entry_reverse(__rq, head, queuelist) {
 		if (blk_barrier_rq(crq->request))
 			break;
 		if (!blk_fs_request(crq->request))
@@ -777,95 +828,86 @@
 	if (time_before(now, cfqq->last_fifo_expire + cfqd->cfq_fifo_batch_expire))
 		return NULL;
 
-	crq = RQ_DATA(list_entry(cfqq->fifo[0].next, struct request, queuelist));
-	if (reads && time_after(now, crq->queue_start + cfqd->cfq_fifo_expire_r)) {
-		cfqq->last_fifo_expire = now;
-		return crq;
+	if (reads) {
+		crq = RQ_DATA(list_entry_fifo(cfqq->fifo[READ].next));
+		if (time_after(now, crq->queue_start + cfqd->cfq_fifo_expire_r)) {
+			cfqq->last_fifo_expire = now;
+			return crq;
+		}
 	}
 
-	crq = RQ_DATA(list_entry(cfqq->fifo[1].next, struct request, queuelist));
-	if (writes && time_after(now, crq->queue_start + cfqd->cfq_fifo_expire_w)) {
-		cfqq->last_fifo_expire = now;
-		return crq;
+	if (writes) {
+		crq = RQ_DATA(list_entry_fifo(cfqq->fifo[WRITE].next));
+		if (time_after(now, crq->queue_start + cfqd->cfq_fifo_expire_w)) {
+			cfqq->last_fifo_expire = now;
+			return crq;
+		}
 	}
 
 	return NULL;
 }
 
-/*
- * dispatch a single request from given queue
- */
-static inline void
-cfq_dispatch_request(request_queue_t *q, struct cfq_data *cfqd,
-		     struct cfq_queue *cfqq)
+static int
+__cfq_dispatch_requests(struct cfq_data *cfqd, struct cfq_queue *cfqq,
+			int max_dispatch)
 {
-	struct cfq_rq *crq;
+	int dispatched = 0;
 
-	/*
-	 * follow expired path, else get first next available
-	 */
-	if ((crq = cfq_check_fifo(cfqq)) == NULL) {
-		if (cfqd->find_best_crq)
-			crq = cfqq->next_crq;
-		else
-			crq = rb_entry_crq(rb_first(&cfqq->sort_list));
-	}
+	BUG_ON(RB_EMPTY(&cfqq->sort_list));
 
-	cfqd->last_sector = crq->request->sector + crq->request->nr_sectors;
+	do {
+		struct cfq_rq *crq;
 
-	/*
-	 * finally, insert request into driver list
-	 */
-	cfq_dispatch_sort(q, crq);
+		/*
+		 * follow expired path, else get first next available
+		 */
+		if ((crq = cfq_check_fifo(cfqq)) == NULL) {
+			if (cfqd->find_best_crq)
+				crq = cfqq->next_crq;
+			else
+				crq = rb_entry_crq(rb_first(&cfqq->sort_list));
+		}
+
+		cfqd->last_sector = crq->request->sector + crq->request->nr_sectors;
+
+		/*
+		 * finally, insert request into driver list
+		 */
+		cfq_dispatch_sort(cfqd->queue, crq);
+
+		cfqd->dispatch_slice++;
+		dispatched++;
+
+		if (RB_EMPTY(&cfqq->sort_list))
+			break;
+
+	} while (dispatched < max_dispatch);
+
+	return dispatched;
 }
 
 static int cfq_dispatch_requests(request_queue_t *q, int max_dispatch)
 {
 	struct cfq_data *cfqd = q->elevator->elevator_data;
 	struct cfq_queue *cfqq;
-	struct list_head *entry, *tmp;
-	int queued, busy_queues, first_round;
 
 	if (list_empty(&cfqd->rr_list))
 		return 0;
 
-	queued = 0;
-	first_round = 1;
-restart:
-	busy_queues = 0;
-	list_for_each_safe(entry, tmp, &cfqd->rr_list) {
-		cfqq = list_entry_cfqq(entry);
-
-		BUG_ON(RB_EMPTY(&cfqq->sort_list));
-
-		/*
-		 * first round of queueing, only select from queues that
-		 * don't already have io in-flight
-		 */
-		if (first_round && cfqq->in_flight)
-			continue;
-
-		cfq_dispatch_request(q, cfqd, cfqq);
-
-		if (!RB_EMPTY(&cfqq->sort_list))
-			busy_queues++;
-
-		queued++;
-	}
-
-	if ((queued < max_dispatch) && (busy_queues || first_round)) {
-		first_round = 0;
-		goto restart;
-	}
+	cfqq = cfq_select_queue(cfqd);
+	if (!cfqq)
+		return 0;
 
-	return queued;
+	cfqq->wait_request = 0;
+	cfqq->must_dispatch = 0;
+	del_timer(&cfqd->timer);
+	return __cfq_dispatch_requests(cfqd, cfqq, max_dispatch);
 }
 
 static inline void cfq_account_dispatch(struct cfq_rq *crq)
 {
 	struct cfq_queue *cfqq = crq->cfq_queue;
 	struct cfq_data *cfqd = cfqq->cfqd;
-	unsigned long now, elapsed;
 
 	/*
 	 * accounted bit is necessary since some drivers will call
@@ -874,62 +916,34 @@
 	if (crq->accounted)
 		return;
 
-	now = jiffies;
-	if (cfqq->service_start == ~0UL)
-		cfqq->service_start = now;
-
-	/*
-	 * on drives with tagged command queueing, command turn-around time
-	 * doesn't necessarily reflect the time spent processing this very
-	 * command inside the drive. so do the accounting differently there,
-	 * by just sorting on the number of requests
-	 */
-	if (cfqd->cfq_tagged) {
-		if (time_after(now, cfqq->service_start + cfq_service)) {
-			cfqq->service_start = now;
-			cfqq->service_used /= 10;
-		}
-
-		cfqq->service_used++;
-		cfq_sort_rr_list(cfqq, 0);
-	}
-
-	elapsed = now - crq->queue_start;
-	if (elapsed > max_elapsed_dispatch)
-		max_elapsed_dispatch = elapsed;
-
 	crq->accounted = 1;
-	crq->service_start = now;
-
-	if (++cfqd->rq_in_driver >= CFQ_MAX_TAG && !cfqd->cfq_tagged) {
-		cfqq->cfqd->cfq_tagged = 1;
-		printk("cfq: depth %d reached, tagging now on\n", CFQ_MAX_TAG);
-	}
+	crq->service_start = jiffies;
+	cfqd->rq_in_driver++;
 }
 
 static inline void
 cfq_account_completion(struct cfq_queue *cfqq, struct cfq_rq *crq)
 {
 	struct cfq_data *cfqd = cfqq->cfqd;
+	unsigned long now = jiffies;
 
 	WARN_ON(!cfqd->rq_in_driver);
 	cfqd->rq_in_driver--;
 
-	if (!cfqd->cfq_tagged) {
-		unsigned long now = jiffies;
-		unsigned long duration = now - crq->service_start;
-
-		if (time_after(now, cfqq->service_start + cfq_service)) {
-			cfqq->service_start = now;
-			cfqq->service_used >>= 3;
-		}
+	cfqq->service_used += now - crq->service_start;
 
-		cfqq->service_used += duration;
-		cfq_sort_rr_list(cfqq, 0);
+	/*
+	 * queue was preempted while this request was servicing
+	 */
+	if (cfqd->active_queue != cfqq)
+		return;
 
-		if (duration > max_elapsed_crq)
-			max_elapsed_crq = duration;
-	}
+	/*
+	 * no requests. if last request was a sync request, wait for
+	 * a new one.
+	 */
+	if (RB_EMPTY(&cfqq->sort_list) && crq->is_sync)
+		cfq_arm_slice_timer(cfqd, cfqq);
 }
 
 static struct request *cfq_next_request(request_queue_t *q)
@@ -937,6 +951,9 @@
 	struct cfq_data *cfqd = q->elevator->elevator_data;
 	struct request *rq;
 
+	if (cfqd->rq_in_driver >= cfqd->cfq_max_depth)
+		return NULL;
+
 	if (!list_empty(&q->queue_head)) {
 		struct cfq_rq *crq;
 dispatch:
@@ -964,6 +981,8 @@
  */
 static void cfq_put_queue(struct cfq_queue *cfqq)
 {
+	struct cfq_data *cfqd = cfqq->cfqd;
+
 	BUG_ON(!atomic_read(&cfqq->ref));
 
 	if (!atomic_dec_and_test(&cfqq->ref))
@@ -972,6 +991,9 @@
 	BUG_ON(rb_first(&cfqq->sort_list));
 	BUG_ON(cfqq->on_rr);
 
+	if (unlikely(cfqd->active_queue == cfqq))
+		cfqd->active_queue = NULL;
+
 	cfq_put_cfqd(cfqq->cfqd);
 
 	/*
@@ -1117,6 +1139,7 @@
 		cic->ioc = ioc;
 		cic->cfqq = __cfqq;
 		atomic_inc(&__cfqq->ref);
+		atomic_inc(&cfqd->ref);
 	} else {
 		struct cfq_io_context *__cic;
 		unsigned long flags;
@@ -1159,10 +1182,10 @@
 		__cic->ioc = ioc;
 		__cic->cfqq = __cfqq;
 		atomic_inc(&__cfqq->ref);
+		atomic_inc(&cfqd->ref);
 		spin_lock_irqsave(&ioc->lock, flags);
 		list_add(&__cic->list, &cic->list);
 		spin_unlock_irqrestore(&ioc->lock, flags);
-
 		cic = __cic;
 		*cfqq = __cfqq;
 	}
@@ -1199,8 +1222,11 @@
 			new_cfqq = kmem_cache_alloc(cfq_pool, gfp_mask);
 			spin_lock_irq(cfqd->queue->queue_lock);
 			goto retry;
-		} else
-			goto out;
+		} else {
+			cfqq = kmem_cache_alloc(cfq_pool, gfp_mask);
+			if (!cfqq)
+				goto out;
+		}
 
 		memset(cfqq, 0, sizeof(*cfqq));
 
@@ -1216,7 +1242,8 @@
 		cfqq->cfqd = cfqd;
 		atomic_inc(&cfqd->ref);
 		cfqq->key_type = cfqd->key_type;
-		cfqq->service_start = ~0UL;
+		cfqq->service_last = 0;
+		strncpy(cfqq->name, current->comm, sizeof(cfqq->name) - 1);
 	}
 
 	if (new_cfqq)
@@ -1243,14 +1270,27 @@
 
 static void cfq_enqueue(struct cfq_data *cfqd, struct cfq_rq *crq)
 {
-	crq->is_sync = 0;
-	if (rq_data_dir(crq->request) == READ || current->flags & PF_SYNCWRITE)
-		crq->is_sync = 1;
+	struct cfq_queue *cfqq = crq->cfq_queue;
+	struct request *rq = crq->request;
+
+	crq->is_sync = rq_data_dir(rq) == READ || current->flags & PF_SYNCWRITE;
 
 	cfq_add_crq_rb(crq);
 	crq->queue_start = jiffies;
 
-	list_add_tail(&crq->request->queuelist, &crq->cfq_queue->fifo[crq->is_sync]);
+	list_add_tail(&rq->queuelist, &crq->cfq_queue->fifo[crq->is_sync]);
+
+	/*
+	 * if we are waiting for a request for this queue, let it rip
+	 * immediately and flag that we must not expire this queue just now
+	 */
+	if (cfqq->wait_request && cfqq == cfqd->active_queue) {
+		request_queue_t *q = cfqd->queue;
+
+		cfqq->must_dispatch = 1;
+		del_timer(&cfqd->timer);
+		q->request_fn(q);
+	}
 }
 
 static void
@@ -1339,31 +1379,34 @@
 	struct cfq_data *cfqd = q->elevator->elevator_data;
 	struct cfq_queue *cfqq;
 	int ret = ELV_MQUEUE_MAY;
+	int limit;
 
 	if (current->flags & PF_MEMALLOC)
 		return ELV_MQUEUE_MAY;
 
 	cfqq = cfq_find_cfq_hash(cfqd, cfq_hash_key(cfqd, current));
-	if (cfqq) {
-		int limit = cfqd->max_queued;
-
-		if (cfqq->allocated[rw] < cfqd->cfq_queued)
-			return ELV_MQUEUE_MUST;
-
-		if (cfqd->busy_queues)
-			limit = q->nr_requests / cfqd->busy_queues;
-
-		if (limit < cfqd->cfq_queued)
-			limit = cfqd->cfq_queued;
-		else if (limit > cfqd->max_queued)
-			limit = cfqd->max_queued;
+	if (unlikely(!cfqq))
+		return ELV_MQUEUE_MAY;
 
-		if (cfqq->allocated[rw] >= limit) {
-			if (limit > cfqq->alloc_limit[rw])
-				cfqq->alloc_limit[rw] = limit;
+	if (cfqq->allocated[rw] < cfqd->cfq_queued)
+		return ELV_MQUEUE_MUST;
+	if (cfqq->wait_request)
+		return ELV_MQUEUE_MUST;
+
+	limit = cfqd->max_queued;
+	if (cfqd->busy_queues)
+		limit = q->nr_requests / cfqd->busy_queues;
+
+	if (limit < cfqd->cfq_queued)
+		limit = cfqd->cfq_queued;
+	else if (limit > cfqd->max_queued)
+		limit = cfqd->max_queued;
+
+	if (cfqq->allocated[rw] >= limit) {
+		if (limit > cfqq->alloc_limit[rw])
+			cfqq->alloc_limit[rw] = limit;
 
-			ret = ELV_MQUEUE_NO;
-		}
+		ret = ELV_MQUEUE_NO;
 	}
 
 	return ret;
@@ -1395,12 +1438,12 @@
 		BUG_ON(q->last_merge == rq);
 		BUG_ON(!hlist_unhashed(&crq->hash));
 
-		if (crq->io_context)
-			put_io_context(crq->io_context->ioc);
-
 		BUG_ON(!cfqq->allocated[crq->is_write]);
 		cfqq->allocated[crq->is_write]--;
 
+		if (crq->io_context)
+			put_io_context(crq->io_context->ioc);
+
 		mempool_free(crq, cfqd->crq_pool);
 		rq->elevator_private = NULL;
 
@@ -1473,6 +1516,7 @@
 		crq->is_write = rw;
 		rq->elevator_private = crq;
 		cfqq->alloc_limit[rw] = 0;
+		smp_mb();
 		return 0;
 	}
 
@@ -1486,6 +1530,44 @@
 	return 1;
 }
 
+static void cfq_kick_queue(void *data)
+{
+	request_queue_t *q = data;
+
+	blk_run_queue(q);
+}
+
+static void cfq_schedule_timer(unsigned long data)
+{
+	struct cfq_data *cfqd = (struct cfq_data *) data;
+	struct cfq_queue *cfqq;
+	unsigned long flags;
+
+	spin_lock_irqsave(cfqd->queue->queue_lock, flags);
+
+	if ((cfqq = cfqd->active_queue) != NULL) {
+		/*
+		 * expired
+		 */
+		if (time_after(jiffies, cfqq->slice_start + cfqd->cfq_slice))
+			goto out;
+
+		/*
+		 * not expired and it has a request pending, let it dispatch
+		 */
+		if (!RB_EMPTY(&cfqq->sort_list)) {
+			cfqq->must_dispatch = 1;
+			goto out_cont;
+		}
+	} 
+
+out:
+	cfq_slice_expired(cfqd);
+out_cont:
+	spin_unlock_irqrestore(cfqd->queue->queue_lock, flags);
+	kblockd_schedule_work(&cfqd->unplug_work);
+}
+
 static void cfq_put_cfqd(struct cfq_data *cfqd)
 {
 	request_queue_t *q = cfqd->queue;
@@ -1494,6 +1576,8 @@
 	if (!atomic_dec_and_test(&cfqd->ref))
 		return;
 
+	blk_sync_queue(q);
+
 	/*
 	 * kill spare queue, getting it means we have two refences to it.
 	 * drop both
@@ -1567,8 +1651,15 @@
 	q->nr_requests = 1024;
 	cfqd->max_queued = q->nr_requests / 16;
 	q->nr_batching = cfq_queued;
-	cfqd->key_type = CFQ_KEY_TGID;
+	cfqd->key_type = CFQ_KEY_PID;
 	cfqd->find_best_crq = 1;
+
+	init_timer(&cfqd->timer);
+	cfqd->timer.function = cfq_schedule_timer;
+	cfqd->timer.data = (unsigned long) cfqd;
+
+	INIT_WORK(&cfqd->unplug_work, cfq_kick_queue, q);
+
 	atomic_set(&cfqd->ref, 1);
 
 	cfqd->cfq_queued = cfq_queued;
@@ -1578,6 +1669,9 @@
 	cfqd->cfq_fifo_batch_expire = cfq_fifo_rate;
 	cfqd->cfq_back_max = cfq_back_max;
 	cfqd->cfq_back_penalty = cfq_back_penalty;
+	cfqd->cfq_slice = cfq_slice;
+	cfqd->cfq_idle = cfq_idle;
+	cfqd->cfq_max_depth = cfq_max_depth;
 
 	return 0;
 out_spare:
@@ -1624,7 +1718,6 @@
 	return -ENOMEM;
 }
 
-
 /*
  * sysfs parts below -->
  */
@@ -1650,13 +1743,6 @@
 }
 
 static ssize_t
-cfq_clear_elapsed(struct cfq_data *cfqd, const char *page, size_t count)
-{
-	max_elapsed_dispatch = max_elapsed_crq = 0;
-	return count;
-}
-
-static ssize_t
 cfq_set_key_type(struct cfq_data *cfqd, const char *page, size_t count)
 {
 	spin_lock_irq(cfqd->queue->queue_lock);
@@ -1664,6 +1750,8 @@
 		cfqd->key_type = CFQ_KEY_PGID;
 	else if (!strncmp(page, "tgid", 4))
 		cfqd->key_type = CFQ_KEY_TGID;
+	else if (!strncmp(page, "pid", 3))
+		cfqd->key_type = CFQ_KEY_PID;
 	else if (!strncmp(page, "uid", 3))
 		cfqd->key_type = CFQ_KEY_UID;
 	else if (!strncmp(page, "gid", 3))
@@ -1688,6 +1776,52 @@
 	return len;
 }
 
+static ssize_t
+cfq_status_show(struct cfq_data *cfqd, char *page)
+{
+	struct list_head *entry;
+	struct cfq_queue *cfqq;
+	ssize_t len;
+	int i = 0, queues;
+
+	len = sprintf(page, "Busy queues: %u\n", cfqd->busy_queues);
+	len += sprintf(page+len, "key type: %s\n",
+				cfq_key_types[cfqd->key_type]);
+	len += sprintf(page+len, "last sector: %Lu\n",
+				(unsigned long long)cfqd->last_sector);
+
+	len += sprintf(page+len, "Busy queue list:\n");
+	spin_lock_irq(cfqd->queue->queue_lock);
+	list_for_each(entry, &cfqd->rr_list) {
+		i++;
+		cfqq = list_entry_cfqq(entry);
+		len += sprintf(page+len, "  cfqq: key=%lu alloc=%d/%d, "
+			"queued=%d/%d, service=%lu/%lu\n",
+			cfqq->key, cfqq->allocated[0], cfqq->allocated[1],
+			cfqq->queued[0], cfqq->queued[1], cfqq->service_used,
+			cfqq->service_rq);
+	}
+	len += sprintf(page+len, "  busy queues total: %d\n", i);
+	queues = i;
+	
+	len += sprintf(page+len, "Empty queue list:\n");
+	i = 0;
+	list_for_each(entry, &cfqd->empty_list) {
+		i++;
+		cfqq = list_entry_cfqq(entry);
+		len += sprintf(page+len, "  cfqq: key=%lu alloc=%d/%d, "
+			"queued=%d/%d, service=%lu/%lu\n",
+			cfqq->key, cfqq->allocated[0], cfqq->allocated[1],
+			cfqq->queued[0], cfqq->queued[1], cfqq->service_used,
+			cfqq->service_rq);
+	}
+	len += sprintf(page+len, "  empty queues total: %d\n", i);
+	queues += i;
+	len += sprintf(page+len, "Total queues: %d\n", queues);
+	spin_unlock_irq(cfqd->queue->queue_lock);
+	return len;
+}
+
 #define SHOW_FUNCTION(__FUNC, __VAR, __CONV)				\
 static ssize_t __FUNC(struct cfq_data *cfqd, char *page)		\
 {									\
@@ -1704,6 +1838,9 @@
 SHOW_FUNCTION(cfq_find_best_show, cfqd->find_best_crq, 0);
 SHOW_FUNCTION(cfq_back_max_show, cfqd->cfq_back_max, 0);
 SHOW_FUNCTION(cfq_back_penalty_show, cfqd->cfq_back_penalty, 0);
+SHOW_FUNCTION(cfq_idle_show, cfqd->cfq_idle, 1);
+SHOW_FUNCTION(cfq_slice_show, cfqd->cfq_slice, 1);
+SHOW_FUNCTION(cfq_max_depth_show, cfqd->cfq_max_depth, 0);
 #undef SHOW_FUNCTION
 
 #define STORE_FUNCTION(__FUNC, __PTR, MIN, MAX, __CONV)			\
@@ -1729,6 +1866,9 @@
 STORE_FUNCTION(cfq_find_best_store, &cfqd->find_best_crq, 0, 1, 0);
 STORE_FUNCTION(cfq_back_max_store, &cfqd->cfq_back_max, 0, UINT_MAX, 0);
 STORE_FUNCTION(cfq_back_penalty_store, &cfqd->cfq_back_penalty, 1, UINT_MAX, 0);
+STORE_FUNCTION(cfq_idle_store, &cfqd->cfq_idle, 0, cfqd->cfq_slice/2, 1);
+STORE_FUNCTION(cfq_slice_store, &cfqd->cfq_slice, 1, UINT_MAX, 1);
+STORE_FUNCTION(cfq_max_depth_store, &cfqd->cfq_max_depth, 2, UINT_MAX, 0);
 #undef STORE_FUNCTION
 
 static struct cfq_fs_entry cfq_quantum_entry = {
@@ -1771,15 +1911,30 @@
 	.show = cfq_back_penalty_show,
 	.store = cfq_back_penalty_store,
 };
-static struct cfq_fs_entry cfq_clear_elapsed_entry = {
-	.attr = {.name = "clear_elapsed", .mode = S_IWUSR },
-	.store = cfq_clear_elapsed,
+static struct cfq_fs_entry cfq_slice_entry = {
+	.attr = {.name = "slice", .mode = S_IRUGO | S_IWUSR },
+	.show = cfq_slice_show,
+	.store = cfq_slice_store,
+};
+static struct cfq_fs_entry cfq_idle_entry = {
+	.attr = {.name = "idle", .mode = S_IRUGO | S_IWUSR },
+	.show = cfq_idle_show,
+	.store = cfq_idle_store,
+};
+static struct cfq_fs_entry cfq_misc_entry = {
+	.attr = {.name = "show_status", .mode = S_IRUGO },
+	.show = cfq_status_show,
 };
 static struct cfq_fs_entry cfq_key_type_entry = {
 	.attr = {.name = "key_type", .mode = S_IRUGO | S_IWUSR },
 	.show = cfq_read_key_type,
 	.store = cfq_set_key_type,
 };
+static struct cfq_fs_entry cfq_max_depth_entry = {
+	.attr = {.name = "max_depth", .mode = S_IRUGO | S_IWUSR },
+	.show = cfq_max_depth_show,
+	.store = cfq_max_depth_store,
+};
 
 static struct attribute *default_attrs[] = {
 	&cfq_quantum_entry.attr,
@@ -1791,7 +1946,10 @@
 	&cfq_find_best_entry.attr,
 	&cfq_back_max_entry.attr,
 	&cfq_back_penalty_entry.attr,
-	&cfq_clear_elapsed_entry.attr,
+	&cfq_misc_entry.attr,
+	&cfq_slice_entry.attr,
+	&cfq_idle_entry.attr,
+	&cfq_max_depth_entry.attr,
 	NULL,
 };
 
@@ -1856,7 +2014,7 @@
 	.elevator_owner =	THIS_MODULE,
 };
 
-int cfq_init(void)
+static int __init cfq_init(void)
 {
 	int ret;
 
@@ -1864,17 +2022,35 @@
 		return -ENOMEM;
 
 	ret = elv_register(&iosched_cfq);
-	if (!ret) {
-		__module_get(THIS_MODULE);
-		return 0;
-	}
+	if (ret)
+		cfq_slab_kill();
 
-	cfq_slab_kill();
 	return ret;
 }
 
 static void __exit cfq_exit(void)
 {
+	struct task_struct *g, *p;
+	unsigned long flags;
+
+	read_lock_irqsave(&tasklist_lock, flags);
+
+	/*
+	 * iterate each process in the system, removing our io_context
+	 */
+	do_each_thread(g, p) {
+		struct io_context *ioc = p->io_context;
+
+		if (ioc && ioc->cic) {
+			ioc->cic->exit(ioc->cic);
+			cfq_free_io_context(ioc->cic);
+			ioc->cic = NULL;
+		}
+
+	} while_each_thread(g, p);
+
+	read_unlock_irqrestore(&tasklist_lock, flags);
+
 	cfq_slab_kill();
 	elv_unregister(&iosched_cfq);
 }


-- 
Jens Axboe

