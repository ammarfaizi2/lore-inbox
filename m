Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261451AbUIOGpn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261451AbUIOGpn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 02:45:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261602AbUIOGpn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 02:45:43 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:50097 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261451AbUIOGpH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 02:45:07 -0400
Date: Wed, 15 Sep 2004 08:43:28 +0200
From: Jens Axboe <axboe@suse.de>
To: Norberto Bensa <norberto+linux-kernel@bensa.ath.cx>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Badness in cfq_sort_rr_list at drivers/block/cfq-iosched.c:428
Message-ID: <20040915064327.GE2304@suse.de>
References: <200409150235.18367.norberto+linux-kernel@bensa.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200409150235.18367.norberto+linux-kernel@bensa.ath.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 15 2004, Norberto Bensa wrote:
> Hello,
> 
> Kernel is 2.6.9-rc1-mm5. I just found this on dmesg. Not sure what the box was 
> doing at that time:
> 
> Badness in cfq_sort_rr_list at drivers/block/cfq-iosched.c:428
>  [<c01e3674>] cfq_add_crq_rb+0xe2/0x144
>  [<c01e4215>] cfq_enqueue+0x33/0x5f
>  [<c01e42ad>] cfq_insert_request+0x6c/0xe3
>  [<c01de2d2>] __elv_add_request+0x3f/0x79
>  [<c01e0940>] __make_request+0x402/0x449

It's harmless. I've sent this incremental patch to Andrew that fixes
this error and some others.

This update:

- Removes some debugging code and the dprintk() stuff

- Detects when tagging is used or not, defines a threshold of
  CFQ_MAX_TAG (default: 4) for when we change from non-tagged to tagged
  operations. This affects accounting.

- Fix a bug where the rr_list was sorted badly. Also make sure we always
  keep it sorted, and add some logic to detect when to resort. This
  could trigger a harmless WARN_ON at line 428.

- Don't set ->service_start when queue is removed from rr_list, this
  could starve a queue if it was quickly readded to the rr_list again.
  In that case, we never would hit the 1 second interval for aging the
  service_used down.

- Cache jiffies in some function instead of re-reading it 2-3 times.

You can fold this in with the cfq-v2 patch if you want.

Signed-off-by: Jens Axboe <axboe@suse.de>

--- drivers/block/cfq-iosched.c~	2004-09-13 20:06:30.425042983 +0200
+++ drivers/block/cfq-iosched.c	2004-09-13 20:14:33.934118844 +0200
@@ -22,14 +22,6 @@
 #include <linux/rbtree.h>
 #include <linux/mempool.h>
 
-#undef CFQ_DEBUG
-
-#ifdef CFQ_DEBUG
-#define dprintk(fmt, args...) printk(KERN_ERR "cfq: " fmt, ##args)
-#else
-#define dprintk(fmt, args...)
-#endif
-
 static unsigned long max_elapsed_crq;
 static unsigned long max_elapsed_dispatch;
 
@@ -84,6 +76,11 @@
 #define rq_rb_key(rq)		(rq)->sector
 
 /*
+ * threshold for switching off non-tag accounting
+ */
+#define CFQ_MAX_TAG		(4)
+
+/*
  * sort key types and names
  */
 enum {
@@ -125,18 +122,21 @@
 
 	sector_t last_sector;
 
+	int rq_in_driver;
+
 	/*
 	 * tunables, see top of file
 	 */
 	unsigned int cfq_quantum;
 	unsigned int cfq_queued;
-	unsigned int cfq_tagged;
 	unsigned int cfq_fifo_expire_r;
 	unsigned int cfq_fifo_expire_w;
 	unsigned int cfq_fifo_batch_expire;
 	unsigned int cfq_back_penalty;
 	unsigned int cfq_back_max;
 	unsigned int find_best_crq;
+
+	unsigned int cfq_tagged;
 };
 
 struct cfq_queue {
@@ -170,14 +170,12 @@
 	unsigned long service_start;
 	unsigned long service_used;
 
+	unsigned int max_rate;
+
 	/* number of requests that have been handed to the driver */
 	int in_flight;
 	/* number of currently allocated requests */
 	int alloc_limit[2];
-
-#ifdef CFQ_DEBUG
-	char name[16];
-#endif
 };
 
 struct cfq_rq {
@@ -307,7 +305,7 @@
 
 			if (blk_barrier_rq(rq))
 				break;
-
+	
 			if (distance < abs(s1 - rq->sector + rq->nr_sectors)) {
 				distance = abs(s1 - rq->sector +rq->nr_sectors);
 				last = rq->sector + rq->nr_sectors;
@@ -404,11 +402,42 @@
 		cfqq->next_crq = cfq_find_next_crq(cfqq->cfqd, cfqq, crq);
 }
 
-static inline void
-cfq_sort_rr_list(struct cfq_queue *cfqq)
+static int cfq_check_sort_rr_list(struct cfq_queue *cfqq)
+{
+	struct list_head *head = &cfqq->cfqd->rr_list;
+	struct list_head *next, *prev;
+
+	/*
+	 * list might still be ordered
+	 */
+	next = cfqq->cfq_list.next;
+	if (next != head) {
+		struct cfq_queue *cnext = list_entry_cfqq(next);
+
+		if (cfqq->service_used > cnext->service_used)
+			return 1;
+	}
+
+	prev = cfqq->cfq_list.prev;
+	if (prev != head) {
+		struct cfq_queue *cprev = list_entry_cfqq(prev);
+
+		if (cfqq->service_used < cprev->service_used)
+			return 1;
+	}
+
+	return 0;
+}
+
+static void cfq_sort_rr_list(struct cfq_queue *cfqq, int new_queue)
 {
 	struct list_head *entry = &cfqq->cfqd->rr_list;
 
+	if (!cfqq->on_rr)
+		return;
+	if (!new_queue && !cfq_check_sort_rr_list(cfqq))
+		return;
+
 	list_del(&cfqq->cfq_list);
 
 	/*
@@ -446,21 +475,16 @@
 static inline void
 cfq_add_cfqq_rr(struct cfq_data *cfqd, struct cfq_queue *cfqq)
 {
-	BUG_ON(cfqq->on_rr);
-
 	/*
 	 * it's currently on the empty list
 	 */
-	cfq_sort_rr_list(cfqq);
 	cfqq->on_rr = 1;
 	cfqd->busy_queues++;
 
-	/*
-	 * if the queue is on the empty_list, service_start was the time
-	 * where it was deleted from the rr_list.
-	 */
 	if (time_after(jiffies, cfqq->service_start + cfq_service))
 		cfqq->service_used >>= 3;
+
+	cfq_sort_rr_list(cfqq, 1);
 }
 
 static inline void
@@ -468,7 +492,6 @@
 {
 	list_move(&cfqq->cfq_list, &cfqd->empty_list);
 	cfqq->on_rr = 0;
-	cfqq->service_start = jiffies;
 
 	BUG_ON(!cfqd->busy_queues);
 	cfqd->busy_queues--;
@@ -492,10 +515,8 @@
 		rb_erase(&crq->rb_node, &cfqq->sort_list);
 		RB_CLEAR_COLOR(&crq->rb_node);
 
-		if (RB_EMPTY(&cfqq->sort_list) && cfqq->on_rr) {
-			dprintk("moving 0x%p empty_list\n", cfqq);
+		if (RB_EMPTY(&cfqq->sort_list) && cfqq->on_rr)
 			cfq_del_cfqq_rr(cfqd, cfqq);
-		}
 	}
 }
 
@@ -541,11 +562,8 @@
 
 	rb_insert_color(&crq->rb_node, &cfqq->sort_list);
 
-	if (!cfqq->on_rr) {
+	if (!cfqq->on_rr)
 		cfq_add_cfqq_rr(cfqd, cfqq);
-		dprintk("moving to rr list %d\n", cfqd->busy_queues);
-	} else
-		dprintk("already on rr list %d\n", cfqd->busy_queues);
 
 	/*
 	 * check if this request is a better next-serve candidate
@@ -590,11 +608,30 @@
 	return NULL;
 }
 
-static void cfq_remove_request(request_queue_t *q, struct request *rq)
+/*
+ * make sure the service time gets corrected on reissue of this request
+ */
+static void cfq_requeue_request(request_queue_t *q, struct request *rq)
 {
 	struct cfq_rq *crq = RQ_DATA(rq);
 
-	dprintk("removing 0x%p\n", rq);
+	if (crq) {
+		struct cfq_queue *cfqq = crq->cfq_queue;
+
+		if (cfqq->cfqd->cfq_tagged) {
+			cfqq->service_used--;
+			cfq_sort_rr_list(cfqq, 0);
+		}
+
+		crq->accounted = 0;
+		cfqq->cfqd->rq_in_driver--;
+	}
+	list_add(&rq->queuelist, &q->queue_head);
+}
+
+static void cfq_remove_request(request_queue_t *q, struct request *rq)
+{
+	struct cfq_rq *crq = RQ_DATA(rq);
 
 	if (crq) {
 		cfq_remove_merge_hints(q, crq);
@@ -730,20 +767,21 @@
 	struct cfq_data *cfqd = cfqq->cfqd;
 	const int reads = !list_empty(&cfqq->fifo[0]);
 	const int writes = !list_empty(&cfqq->fifo[1]);
+	unsigned long now = jiffies;
 	struct cfq_rq *crq;
 
-	if (jiffies - cfqq->last_fifo_expire < cfqd->cfq_fifo_batch_expire)
+	if (time_before(now, cfqq->last_fifo_expire + cfqd->cfq_fifo_batch_expire))
 		return NULL;
 
 	crq = RQ_DATA(list_entry(cfqq->fifo[0].next, struct request, queuelist));
-	if (reads && time_after(jiffies, crq->queue_start + cfqd->cfq_fifo_expire_r)) {
-		cfqq->last_fifo_expire = jiffies;
+	if (reads && time_after(now, crq->queue_start + cfqd->cfq_fifo_expire_r)) {
+		cfqq->last_fifo_expire = now;
 		return crq;
 	}
 
 	crq = RQ_DATA(list_entry(cfqq->fifo[1].next, struct request, queuelist));
-	if (writes && time_after(jiffies, crq->queue_start + cfqd->cfq_fifo_expire_w)) {
-		cfqq->last_fifo_expire = jiffies;
+	if (writes && time_after(now, crq->queue_start + cfqd->cfq_fifo_expire_w)) {
+		cfqq->last_fifo_expire = now;
 		return crq;
 	}
 
@@ -822,7 +860,8 @@
 static inline void cfq_account_dispatch(struct cfq_rq *crq)
 {
 	struct cfq_queue *cfqq = crq->cfq_queue;
-	unsigned long elapsed = jiffies - crq->queue_start;
+	struct cfq_data *cfqd = cfqq->cfqd;
+	unsigned long now, elapsed;
 
 	/*
 	 * accounted bit is necessary since some drivers will call
@@ -831,52 +870,62 @@
 	if (crq->accounted)
 		return;
 
+	now = jiffies;
+	if (cfqq->service_start == ~0UL)
+		cfqq->service_start = now;
+
 	/*
 	 * on drives with tagged command queueing, command turn-around time
 	 * doesn't necessarily reflect the time spent processing this very
 	 * command inside the drive. so do the accounting differently there,
 	 * by just sorting on the number of requests
 	 */
-	if (cfqq->cfqd->cfq_tagged) {
-		if (time_after(jiffies, cfqq->service_start + cfq_service)) {
-			cfqq->service_start = jiffies;
+	if (cfqd->cfq_tagged) {
+		if (time_after(now, cfqq->service_start + cfq_service)) {
+			cfqq->service_start = now;
 			cfqq->service_used /= 10;
 		}
 
 		cfqq->service_used++;
+		cfq_sort_rr_list(cfqq, 0);
 	}
 
+	elapsed = now - crq->queue_start;
 	if (elapsed > max_elapsed_dispatch)
 		max_elapsed_dispatch = elapsed;
 
 	crq->accounted = 1;
-	crq->service_start = jiffies;
+	crq->service_start = now;
+
+	if (++cfqd->rq_in_driver >= CFQ_MAX_TAG && !cfqd->cfq_tagged) {
+		cfqq->cfqd->cfq_tagged = 1;
+		printk("cfq: depth %d reached, tagging now on\n", CFQ_MAX_TAG);
+	}
 }
 
 static inline void
 cfq_account_completion(struct cfq_queue *cfqq, struct cfq_rq *crq)
 {
-	unsigned long start_val = cfqq->service_used;
+	struct cfq_data *cfqd = cfqq->cfqd;
+
+	WARN_ON(!cfqd->rq_in_driver);
+	cfqd->rq_in_driver--;
 
-	if (!cfqq->cfqd->cfq_tagged) {
-		unsigned long duration = jiffies - crq->service_start;
+	if (!cfqd->cfq_tagged) {
+		unsigned long now = jiffies;
+		unsigned long duration = now - crq->service_start;
 
-		if (time_after(jiffies, cfqq->service_start + cfq_service)) {
-			cfqq->service_start = jiffies;
+		if (time_after(now, cfqq->service_start + cfq_service)) {
+			cfqq->service_start = now;
 			cfqq->service_used >>= 3;
 		}
 
 		cfqq->service_used += duration;
+		cfq_sort_rr_list(cfqq, 0);
 
 		if (duration > max_elapsed_crq)
 			max_elapsed_crq = duration;
 	}
-
-	/*
-	 * make sure list stays properly sorted, but only do so if necessary
-	 */
-	if (cfqq->on_rr && cfqq->service_used != start_val)
-		cfq_sort_rr_list(cfqq);
 }
 
 static struct request *cfq_next_request(request_queue_t *q)
@@ -913,13 +962,9 @@
 {
 	BUG_ON(!atomic_read(&cfqq->ref));
 
-	dprintk("cfq_put_queue 0x%p, ref\n", atomic_read(&cfqq->ref));
-
 	if (!atomic_dec_and_test(&cfqq->ref))
 		return;
 
-	dprintk("killing queue 0x%p/%s\n", cfqq, cfqq->name);
-
 	BUG_ON(rb_first(&cfqq->sort_list));
 	BUG_ON(cfqq->on_rr);
 
@@ -1163,11 +1208,8 @@
 		hlist_add_head(&cfqq->cfq_hash, &cfqd->cfq_hash[hashval]);
 		atomic_set(&cfqq->ref, 0);
 		cfqq->cfqd = cfqd;
-#ifdef CFQ_DEBUG
-		strncpy(cfqq->name, current->comm, sizeof(cfqq->name)-1);
-#endif
-		dprintk("cfqq set up for 0x%p/%s\n", cfqq, cfqq->name);
 		cfqq->key_type = cfqd->key_type;
+		cfqq->service_start = ~0UL;
 	}
 
 	if (new_cfqq)
@@ -1212,17 +1254,14 @@
 
 	switch (where) {
 		case ELEVATOR_INSERT_BACK:
-			dprintk("adding back 0x%p\n", rq);
 			while (cfq_dispatch_requests(q, cfqd->cfq_quantum))
 				;
 			list_add_tail(&rq->queuelist, &q->queue_head);
 			break;
 		case ELEVATOR_INSERT_FRONT:
-			dprintk("adding front 0x%p\n", rq);
 			list_add(&rq->queuelist, &q->queue_head);
 			break;
 		case ELEVATOR_INSERT_SORT:
-			dprintk("adding sort 0x%p\n", rq);
 			BUG_ON(!blk_fs_request(rq));
 			cfq_enqueue(cfqd, crq);
 			break;
@@ -1511,7 +1599,6 @@
 	cfqd->cfq_back_max = cfq_back_max;
 	cfqd->cfq_back_penalty = cfq_back_penalty;
 
-	dprintk("cfq on queue 0x%p\n", q);
 	return 0;
 out_spare:
 	mempool_destroy(cfqd->crq_pool);
@@ -1632,7 +1719,7 @@
 	}
 	len += sprintf(page+len, "  busy queues total: %d\n", i);
 	queues = i;
-
+	
 	len += sprintf(page+len, "Empty queue list:\n");
 	i = 0;
 	list_for_each(entry, &cfqd->empty_list) {
@@ -1654,7 +1741,6 @@
 }
 SHOW_FUNCTION(cfq_quantum_show, cfqd->cfq_quantum);
 SHOW_FUNCTION(cfq_queued_show, cfqd->cfq_queued);
-SHOW_FUNCTION(cfq_tagged_show, cfqd->cfq_tagged);
 SHOW_FUNCTION(cfq_fifo_expire_r_show, cfqd->cfq_fifo_expire_r);
 SHOW_FUNCTION(cfq_fifo_expire_w_show, cfqd->cfq_fifo_expire_w);
 SHOW_FUNCTION(cfq_fifo_batch_expire_show, cfqd->cfq_fifo_batch_expire);
@@ -1675,7 +1761,6 @@
 }
 STORE_FUNCTION(cfq_quantum_store, &cfqd->cfq_quantum, 1, UINT_MAX);
 STORE_FUNCTION(cfq_queued_store, &cfqd->cfq_queued, 1, UINT_MAX);
-STORE_FUNCTION(cfq_tagged_store, &cfqd->cfq_tagged, 0, 1);
 STORE_FUNCTION(cfq_fifo_expire_r_store, &cfqd->cfq_fifo_expire_r, 1, UINT_MAX);
 STORE_FUNCTION(cfq_fifo_expire_w_store, &cfqd->cfq_fifo_expire_w, 1, UINT_MAX);
 STORE_FUNCTION(cfq_fifo_batch_expire_store, &cfqd->cfq_fifo_batch_expire, 0, UINT_MAX);
@@ -1694,11 +1779,6 @@
 	.show = cfq_queued_show,
 	.store = cfq_queued_store,
 };
-static struct cfq_fs_entry cfq_tagged_entry = {
-	.attr = {.name = "tagged", .mode = S_IRUGO | S_IWUSR },
-	.show = cfq_tagged_show,
-	.store = cfq_tagged_store,
-};
 static struct cfq_fs_entry cfq_fifo_expire_r_entry = {
 	.attr = {.name = "fifo_expire_sync", .mode = S_IRUGO | S_IWUSR },
 	.show = cfq_fifo_expire_r_show,
@@ -1746,7 +1826,6 @@
 static struct attribute *default_attrs[] = {
 	&cfq_quantum_entry.attr,
 	&cfq_queued_entry.attr,
-	&cfq_tagged_entry.attr,
 	&cfq_fifo_expire_r_entry.attr,
 	&cfq_fifo_expire_w_entry.attr,
 	&cfq_fifo_batch_expire_entry.attr,
@@ -1805,6 +1884,7 @@
 	.elevator_next_req_fn =		cfq_next_request,
 	.elevator_add_req_fn =		cfq_insert_request,
 	.elevator_remove_req_fn =	cfq_remove_request,
+	.elevator_requeue_req_fn =	cfq_requeue_request,
 	.elevator_queue_empty_fn =	cfq_queue_empty,
 	.elevator_completed_req_fn =	cfq_completed_request,
 	.elevator_former_req_fn =	cfq_former_request,

-- 
Jens Axboe

