Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261541AbULFPsK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261541AbULFPsK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 10:48:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261543AbULFPsK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 10:48:10 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:41382 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261541AbULFPqQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 10:46:16 -0500
Date: Mon, 6 Dec 2004 16:45:37 +0100
From: Jens Axboe <axboe@suse.de>
To: =?iso-8859-1?Q?S=F8ren?= Lott <soren3@gmail.com>
Cc: "Prakash K. Cheemplavam" <prakashkc@gmx.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, helge.hafting@hist.no
Subject: Re: [PATCH] Time sliced CFQ #3
Message-ID: <20041206154537.GE10498@suse.de>
References: <20041204104921.GC10449@suse.de> <41B426D4.6080506@gmx.de> <20041206093517.GJ10498@suse.de> <41B45134.4040005@gmx.de> <20041206132749.GX10498@suse.de> <aa3a70450412060601552decbd@mail.gmail.com> <20041206150140.GD10498@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20041206150140.GD10498@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 06 2004, Jens Axboe wrote:
> On Mon, Dec 06 2004, Søren Lott wrote:
> > On Mon, 6 Dec 2004 14:27:50 +0100, Jens Axboe <axboe@suse.de> wrote:
> > > http://www.kernel.org/pub/linux/kernel/people/axboe/patches/v2.6/2.6.10-rc3/cfq-time-slices-6.gz
> > > 
> > 
> > would be possible get a patch against -mm4 ?
> 
> Sure, in fact I will move development to -mm instead.

Here is one. Changes:

- Port to 2.6.10-rc2-mm4

- Change the 'is task running or about to run' to a much better sched.c
  helper from Ingo.

- Kill PF_SYNCWRITE, rely on WRITE_SYNC instead.

 drivers/block/as-iosched.c  |    3 
 drivers/block/cfq-iosched.c |  706 ++++++++++++++++++++++++++++----------------
 drivers/block/ll_rw_blk.c   |   20 -
 fs/buffer.c                 |    4 
 fs/fs-writeback.c           |    2 
 fs/mpage.c                  |   31 +
 include/linux/blkdev.h      |    5 
 include/linux/sched.h       |    4 
 kernel/sched.c              |   37 ++
 9 files changed, 525 insertions(+), 287 deletions(-)

diff -urP -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.6.10-rc2-mm4/drivers/block/as-iosched.c linux-2.6.10-rc2-mm4/drivers/block/as-iosched.c
--- /opt/kernel/linux-2.6.10-rc2-mm4/drivers/block/as-iosched.c	2004-12-06 16:07:50.000000000 +0100
+++ linux-2.6.10-rc2-mm4/drivers/block/as-iosched.c	2004-12-06 16:11:27.000000000 +0100
@@ -1415,8 +1415,7 @@
 	struct as_rq *alias;
 	int data_dir;
 
-	if (rq_data_dir(arq->request) == READ
-			|| current->flags&PF_SYNCWRITE)
+	if (rq_data_dir(arq->request) == READ || blk_rq_sync(arq->request))
 		arq->is_sync = 1;
 	else
 		arq->is_sync = 0;
diff -urP -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.6.10-rc2-mm4/drivers/block/cfq-iosched.c linux-2.6.10-rc2-mm4/drivers/block/cfq-iosched.c
--- /opt/kernel/linux-2.6.10-rc2-mm4/drivers/block/cfq-iosched.c	2004-12-06 16:07:50.000000000 +0100
+++ linux-2.6.10-rc2-mm4/drivers/block/cfq-iosched.c	2004-12-06 16:36:46.854550611 +0100
@@ -22,21 +22,24 @@
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
 
+static int cfq_slice_sync = HZ / 10;
+static int cfq_slice_async = HZ / 25;
+static int cfq_slice_async_rq = 128;
+static int cfq_slice_idle = HZ / 249;
+
+static int cfq_max_depth = 4;
+
 /*
  * for the hash of cfqq inside the cfqd
  */
@@ -55,6 +58,7 @@
 #define list_entry_hash(ptr)	hlist_entry((ptr), struct cfq_rq, hash)
 
 #define list_entry_cfqq(ptr)	list_entry((ptr), struct cfq_queue, cfq_list)
+#define list_entry_fifo(ptr)	list_entry((ptr), struct request, queuelist)
 
 #define RQ_DATA(rq)		(rq)->elevator_private
 
@@ -76,22 +80,18 @@
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
@@ -103,6 +103,8 @@
 static kmem_cache_t *cfq_ioc_pool;
 
 struct cfq_data {
+	atomic_t ref;
+
 	struct list_head rr_list;
 	struct list_head empty_list;
 
@@ -114,8 +116,6 @@
 
 	unsigned int max_queued;
 
-	atomic_t ref;
-
 	int key_type;
 
 	mempool_t *crq_pool;
@@ -127,6 +127,14 @@
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
@@ -137,8 +145,10 @@
 	unsigned int cfq_back_penalty;
 	unsigned int cfq_back_max;
 	unsigned int find_best_crq;
-
-	unsigned int cfq_tagged;
+	unsigned int cfq_slice[2];
+	unsigned int cfq_slice_async_rq;
+	unsigned int cfq_slice_idle;
+	unsigned int cfq_max_depth;
 };
 
 struct cfq_queue {
@@ -150,8 +160,6 @@
 	struct hlist_node cfq_hash;
 	/* hash key */
 	unsigned long key;
-	/* whether queue is on rr (or empty) list */
-	int on_rr;
 	/* on either rr or empty list of cfqd */
 	struct list_head cfq_list;
 	/* sorted list of pending requests */
@@ -169,15 +177,19 @@
 
 	int key_type;
 
-	unsigned long service_start;
-	unsigned long service_used;
-
-	unsigned int max_rate;
+	unsigned long slice_start;
+	unsigned long slice_end;
+	unsigned long service_last;
 
 	/* number of requests that have been handed to the driver */
 	int in_flight;
-	/* number of currently allocated requests */
-	int alloc_limit[2];
+
+	/* whether queue is on rr (or empty) list */
+	unsigned int on_rr : 1;
+	/* idle slice, waiting for new request submission */
+	unsigned int wait_request : 1;
+	/* idle slice, request added, now waiting to dispatch it */
+	unsigned int must_dispatch : 1;
 };
 
 struct cfq_rq {
@@ -195,7 +207,6 @@
 	unsigned int in_flight : 1;
 	unsigned int accounted : 1;
 	unsigned int is_sync   : 1;
-	unsigned int is_write  : 1;
 };
 
 static struct cfq_queue *cfq_find_cfq_hash(struct cfq_data *, unsigned long);
@@ -219,6 +230,8 @@
 		default:
 		case CFQ_KEY_TGID:
 			return tsk->tgid;
+		case CFQ_KEY_PID:
+			return tsk->pid;
 		case CFQ_KEY_UID:
 			return tsk->uid;
 		case CFQ_KEY_GID:
@@ -406,67 +419,22 @@
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
@@ -479,16 +447,12 @@
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
@@ -512,10 +476,10 @@
 		struct cfq_data *cfqd = cfqq->cfqd;
 
 		BUG_ON(!cfqq->queued[crq->is_sync]);
+		cfqq->queued[crq->is_sync]--;
 
 		cfq_update_next_crq(crq);
 
-		cfqq->queued[crq->is_sync]--;
 		rb_erase(&crq->rb_node, &cfqq->sort_list);
 		RB_CLEAR_COLOR(&crq->rb_node);
 
@@ -619,17 +583,13 @@
 {
 	struct cfq_rq *crq = RQ_DATA(rq);
 
-	if (crq) {
+	if (crq && crq->accounted) {
 		struct cfq_queue *cfqq = crq->cfq_queue;
 
-		if (cfqq->cfqd->cfq_tagged) {
-			cfqq->service_used--;
-			cfq_sort_rr_list(cfqq, 0);
-		}
-
 		crq->accounted = 0;
 		cfqq->cfqd->rq_in_driver--;
 	}
+
 	list_add(&rq->queuelist, &q->queue_head);
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
 
@@ -723,6 +681,121 @@
 	cfq_remove_request(q, next);
 }
 
+static inline void cfq_set_active_queue(struct cfq_data *cfqd)
+{
+	struct cfq_queue *cfqq = NULL;
+
+	if (!list_empty(&cfqd->rr_list)) {
+		cfqq = list_entry_cfqq(cfqd->rr_list.next);
+
+		cfqq->slice_start = jiffies;
+		cfqq->slice_end = 0;
+		cfqq->wait_request = 0;
+	}
+
+	cfqd->active_queue = cfqq;
+}
+
+/*
+ * current cfqq expired its slice (or was too idle), select new one
+ */
+static inline void cfq_slice_expired(struct cfq_data *cfqd)
+{
+	struct cfq_queue *cfqq = cfqd->active_queue;
+
+	if (cfqq) {
+		if (cfqq->wait_request)
+			del_timer(&cfqd->timer);
+
+		cfqq->service_last = jiffies;
+		cfqq->must_dispatch = 0;
+		cfqq->wait_request = 0;
+
+		if (cfqq->on_rr)
+			cfq_resort_rr_list(cfqq);
+
+		cfqd->active_queue = NULL;
+	}
+
+	cfqd->dispatch_slice = 0;
+}
+
+static int cfq_arm_slice_timer(struct cfq_data *cfqd, struct cfq_queue *cfqq,
+			       struct cfq_io_context *cic)
+{
+	WARN_ON(!RB_EMPTY(&cfqq->sort_list));
+
+	cfqq->wait_request = 1;
+
+	if (!cfqd->cfq_slice_idle)
+		return 0;
+
+	/*
+	 * don't arm a slice timer if we don't expect the task to run
+	 * after the slice has ended
+	 */
+	if (cic) {
+		unsigned long sched_time;
+
+		if (!cic->ioc->task)
+			return 0;
+
+		sched_time = task_will_schedule_at(cic->ioc->task);
+		if (sched_time && time_after(sched_time, cfqq->slice_end))
+			return 0;
+	}
+
+	if (!timer_pending(&cfqd->timer)) {
+		unsigned long now = jiffies, slice_left;
+
+		slice_left = cfqq->slice_end - now - 1;
+		cfqd->timer.expires = now + min(cfqd->cfq_slice_idle, (unsigned int)slice_left);
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
+	unsigned long now = jiffies;
+
+	cfqq = cfqd->active_queue;
+	if (!cfqq)
+		goto new_queue;
+
+	if (cfqq->must_dispatch)
+		goto must_queue;
+
+	/*
+	 * slice has expired
+	 */
+	if (time_after(jiffies, cfqq->slice_end))
+		goto new_queue;
+
+	/*
+	 * if queue has requests, dispatch one. if not, check if
+	 * enough slice is left to wait for one
+	 */
+must_queue:
+	if (!RB_EMPTY(&cfqq->sort_list))
+		goto keep_queue;
+	else if (time_before(now, cfqq->slice_end)) {
+		if (cfq_arm_slice_timer(cfqd, cfqq, NULL))
+			return NULL;
+	}
+
+new_queue:
+	cfq_slice_expired(cfqd);
+	cfq_set_active_queue(cfqd);
+keep_queue:
+	return cfqd->active_queue;
+}
+
 /*
  * we dispatch cfqd->cfq_quantum requests in total from the rr_list queues,
  * this function sector sorts the selected request to minimize seeks. we start
@@ -741,9 +814,7 @@
 	list_del(&crq->request->queuelist);
 
 	last = cfqd->last_sector;
-	while ((entry = entry->prev) != head) {
-		__rq = list_entry_rq(entry);
-
+	list_for_each_entry_reverse(__rq, head, queuelist) {
 		if (blk_barrier_rq(crq->request))
 			break;
 		if (!blk_fs_request(crq->request))
@@ -777,95 +848,104 @@
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
+	int dispatched = 0, sync = 0;
+
+	BUG_ON(RB_EMPTY(&cfqq->sort_list));
+
+	do {
+		struct cfq_rq *crq;
+
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
+		sync += crq->is_sync;
+
+		if (RB_EMPTY(&cfqq->sort_list))
+			break;
+
+	} while (dispatched < max_dispatch);
 
 	/*
-	 * follow expired path, else get first next available
+	 * if slice end isn't set yet, set it. if at least one request was
+	 * sync, use the sync time slice value
 	 */
-	if ((crq = cfq_check_fifo(cfqq)) == NULL) {
-		if (cfqd->find_best_crq)
-			crq = cfqq->next_crq;
-		else
-			crq = rb_entry_crq(rb_first(&cfqq->sort_list));
-	}
-
-	cfqd->last_sector = crq->request->sector + crq->request->nr_sectors;
+	if (!cfqq->slice_end)
+		cfqq->slice_end = cfqd->cfq_slice[!!sync] + jiffies;
 
 	/*
-	 * finally, insert request into driver list
+	 * expire an async queue immediately if it has used up its slice
 	 */
-	cfq_dispatch_sort(q, crq);
+	if (!sync && cfqd->dispatch_slice >= cfqd->cfq_slice_async_rq)
+		cfq_slice_expired(cfqd);
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
+	cfqq = cfq_select_queue(cfqd);
+	if (cfqq) {
+		cfqq->wait_request = 0;
+		cfqq->must_dispatch = 0;
+		del_timer(&cfqd->timer);
+		return __cfq_dispatch_requests(cfqd, cfqq, max_dispatch);
 	}
 
-	return queued;
+	return 0;
 }
 
 static inline void cfq_account_dispatch(struct cfq_rq *crq)
 {
 	struct cfq_queue *cfqq = crq->cfq_queue;
 	struct cfq_data *cfqd = cfqq->cfqd;
-	unsigned long now, elapsed;
+
+	if (unlikely(!blk_fs_request(crq->request)))
+		return;
 
 	/*
 	 * accounted bit is necessary since some drivers will call
@@ -874,37 +954,9 @@
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
@@ -912,24 +964,24 @@
 {
 	struct cfq_data *cfqd = cfqq->cfqd;
 
-	WARN_ON(!cfqd->rq_in_driver);
-	cfqd->rq_in_driver--;
-
-	if (!cfqd->cfq_tagged) {
-		unsigned long now = jiffies;
-		unsigned long duration = now - crq->service_start;
-
-		if (time_after(now, cfqq->service_start + cfq_service)) {
-			cfqq->service_start = now;
-			cfqq->service_used >>= 3;
-		}
+	if (crq->accounted) {
+		WARN_ON(!cfqd->rq_in_driver);
+		cfqd->rq_in_driver--;
+	}
 
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
+	 * this is still the active queue. if we have nothing to do and no
+	 * more pending requests in flight, wait for a new sync request if
+	 * this request was sync itself
+	 */
+	if (RB_EMPTY(&cfqq->sort_list) && crq->is_sync && !cfqq->in_flight)
+		cfq_arm_slice_timer(cfqd, cfqq, crq->io_context);
 }
 
 static struct request *cfq_next_request(request_queue_t *q)
@@ -937,6 +989,9 @@
 	struct cfq_data *cfqd = q->elevator->elevator_data;
 	struct request *rq;
 
+	if (cfqd->rq_in_driver >= cfqd->cfq_max_depth)
+		return NULL;
+
 	if (!list_empty(&q->queue_head)) {
 		struct cfq_rq *crq;
 dispatch:
@@ -964,6 +1019,8 @@
  */
 static void cfq_put_queue(struct cfq_queue *cfqq)
 {
+	struct cfq_data *cfqd = cfqq->cfqd;
+
 	BUG_ON(!atomic_read(&cfqq->ref));
 
 	if (!atomic_dec_and_test(&cfqq->ref))
@@ -972,6 +1029,9 @@
 	BUG_ON(rb_first(&cfqq->sort_list));
 	BUG_ON(cfqq->on_rr);
 
+	if (unlikely(cfqd->active_queue == cfqq))
+		cfqd->active_queue = NULL;
+
 	cfq_put_cfqd(cfqq->cfqd);
 
 	/*
@@ -1033,6 +1093,18 @@
 	spin_unlock_irqrestore(cfqd->queue->queue_lock, flags);
 }
 
+static void cfq_queue_remove(struct cfq_queue *cfqq)
+{
+	struct cfq_data *cfqd = cfqq->cfqd;
+
+	/*
+	 * don't waste time waiting for the timer to expire for
+	 * a dead process
+	 */
+	if (cfqq == cfqd->active_queue && del_timer(&cfqd->timer))
+		kblockd_schedule_work(&cfqd->unplug_work);
+}
+
 static void cfq_free_io_context(struct cfq_io_context *cic)
 {
 	kmem_cache_free(cfq_ioc_pool, cic);
@@ -1044,6 +1116,7 @@
 static void cfq_exit_io_context(struct cfq_io_context *cic)
 {
 	struct cfq_queue *cfqq = cic->cfqq;
+	struct cfq_data *cfqd = cfqq->cfqd;
 	struct list_head *entry = &cic->list;
 	request_queue_t *q;
 	unsigned long flags;
@@ -1060,12 +1133,14 @@
 
 		q = __cic->cfqq->cfqd->queue;
 		spin_lock(q->queue_lock);
+		cfq_queue_remove(__cic->cfqq);
 		cfq_put_queue(__cic->cfqq);
 		spin_unlock(q->queue_lock);
 	}
 
-	q = cfqq->cfqd->queue;
+	q = cfqd->queue;
 	spin_lock(q->queue_lock);
+	cfq_queue_remove(cfqq);
 	cfq_put_queue(cfqq);
 	spin_unlock(q->queue_lock);
 
@@ -1117,6 +1192,7 @@
 		cic->ioc = ioc;
 		cic->cfqq = __cfqq;
 		atomic_inc(&__cfqq->ref);
+		atomic_inc(&cfqd->ref);
 	} else {
 		struct cfq_io_context *__cic;
 		unsigned long flags;
@@ -1159,10 +1235,10 @@
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
@@ -1199,8 +1275,11 @@
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
 
@@ -1216,7 +1295,7 @@
 		cfqq->cfqd = cfqd;
 		atomic_inc(&cfqd->ref);
 		cfqq->key_type = cfqd->key_type;
-		cfqq->service_start = ~0UL;
+		cfqq->service_last = 0;
 	}
 
 	if (new_cfqq)
@@ -1243,14 +1322,31 @@
 
 static void cfq_enqueue(struct cfq_data *cfqd, struct cfq_rq *crq)
 {
-	crq->is_sync = 0;
-	if (rq_data_dir(crq->request) == READ || current->flags & PF_SYNCWRITE)
-		crq->is_sync = 1;
+	struct cfq_queue *cfqq = crq->cfq_queue;
+	struct request *rq = crq->request;
+
+	crq->is_sync = rq_data_dir(rq) == READ || blk_rq_sync(rq);
 
 	cfq_add_crq_rb(crq);
 	crq->queue_start = jiffies;
 
-	list_add_tail(&crq->request->queuelist, &crq->cfq_queue->fifo[crq->is_sync]);
+	list_add_tail(&rq->queuelist, &cfqq->fifo[crq->is_sync]);
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
+
+		if (!blk_queue_plugged(q))
+			q->request_fn(q);
+		else
+			__generic_unplug_device(q);
+	}
 }
 
 static void
@@ -1339,32 +1435,31 @@
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
+	if (unlikely(!cfqq))
+		return ELV_MQUEUE_MAY;
 
-		if (limit < cfqd->cfq_queued)
-			limit = cfqd->cfq_queued;
-		else if (limit > cfqd->max_queued)
-			limit = cfqd->max_queued;
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
 
-		if (cfqq->allocated[rw] >= limit) {
-			if (limit > cfqq->alloc_limit[rw])
-				cfqq->alloc_limit[rw] = limit;
-
-			ret = ELV_MQUEUE_NO;
-		}
-	}
+	if (cfqq->allocated[rw] >= limit)
+		ret = ELV_MQUEUE_NO;
 
 	return ret;
 }
@@ -1372,12 +1467,13 @@
 static void cfq_check_waiters(request_queue_t *q, struct cfq_queue *cfqq)
 {
 	struct request_list *rl = &q->rq;
-	const int write = waitqueue_active(&rl->wait[WRITE]);
-	const int read = waitqueue_active(&rl->wait[READ]);
+	const int writes = waitqueue_active(&rl->wait[WRITE]);
+	const int reads = waitqueue_active(&rl->wait[READ]);
+	struct cfq_data *cfqd = q->elevator->elevator_data;
 
-	if (read && cfqq->allocated[READ] < cfqq->alloc_limit[READ])
+	if (reads && cfqq->allocated[READ] < cfqd->max_queued)
 		wake_up(&rl->wait[READ]);
-	if (write && cfqq->allocated[WRITE] < cfqq->alloc_limit[WRITE])
+	if (writes && cfqq->allocated[WRITE] < cfqd->max_queued)
 		wake_up(&rl->wait[WRITE]);
 }
 
@@ -1391,16 +1487,17 @@
 
 	if (crq) {
 		struct cfq_queue *cfqq = crq->cfq_queue;
+		const int rw = rq_data_dir(rq);
 
 		BUG_ON(q->last_merge == rq);
 		BUG_ON(!hlist_unhashed(&crq->hash));
 
+		BUG_ON(!cfqq->allocated[rw]);
+		cfqq->allocated[rw]--;
+
 		if (crq->io_context)
 			put_io_context(crq->io_context->ioc);
 
-		BUG_ON(!cfqq->allocated[crq->is_write]);
-		cfqq->allocated[crq->is_write]--;
-
 		mempool_free(crq, cfqd->crq_pool);
 		rq->elevator_private = NULL;
 
@@ -1470,9 +1567,7 @@
 		crq->io_context = cic;
 		crq->service_start = crq->queue_start = 0;
 		crq->in_flight = crq->accounted = crq->is_sync = 0;
-		crq->is_write = rw;
 		rq->elevator_private = crq;
-		cfqq->alloc_limit[rw] = 0;
 		return 0;
 	}
 
@@ -1486,6 +1581,44 @@
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
+		if (time_after(jiffies, cfqq->slice_end))
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
@@ -1494,6 +1627,8 @@
 	if (!atomic_dec_and_test(&cfqd->ref))
 		return;
 
+	blk_sync_queue(q);
+
 	/*
 	 * kill spare queue, getting it means we have two refences to it.
 	 * drop both
@@ -1502,6 +1637,11 @@
 	cfqq = __cfq_get_queue(cfqd, CFQ_KEY_SPARE, GFP_ATOMIC);
 	cfq_put_queue(cfqq);
 	cfq_put_queue(cfqq);
+
+	/*
+	 * restore ->nr_requests
+	 */
+	q->nr_requests = BLKDEV_MAX_RQ;
 	spin_unlock_irq(q->queue_lock);
 
 	blk_put_queue(q);
@@ -1565,10 +1705,17 @@
 	 * some requests. fairness is handled differently
 	 */
 	q->nr_requests = 1024;
-	cfqd->max_queued = q->nr_requests / 16;
+	cfqd->max_queued = q->nr_requests / 8;
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
@@ -1578,6 +1725,11 @@
 	cfqd->cfq_fifo_batch_expire = cfq_fifo_rate;
 	cfqd->cfq_back_max = cfq_back_max;
 	cfqd->cfq_back_penalty = cfq_back_penalty;
+	cfqd->cfq_slice[0] = cfq_slice_async;
+	cfqd->cfq_slice[1] = cfq_slice_sync;
+	cfqd->cfq_slice_async_rq = cfq_slice_async_rq;
+	cfqd->cfq_slice_idle = cfq_slice_idle;
+	cfqd->cfq_max_depth = cfq_max_depth;
 
 	return 0;
 out_spare:
@@ -1624,7 +1776,6 @@
 	return -ENOMEM;
 }
 
-
 /*
  * sysfs parts below -->
  */
@@ -1650,13 +1801,6 @@
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
@@ -1664,6 +1808,8 @@
 		cfqd->key_type = CFQ_KEY_PGID;
 	else if (!strncmp(page, "tgid", 4))
 		cfqd->key_type = CFQ_KEY_TGID;
+	else if (!strncmp(page, "pid", 3))
+		cfqd->key_type = CFQ_KEY_PID;
 	else if (!strncmp(page, "uid", 3))
 		cfqd->key_type = CFQ_KEY_UID;
 	else if (!strncmp(page, "gid", 3))
@@ -1704,6 +1850,11 @@
 SHOW_FUNCTION(cfq_find_best_show, cfqd->find_best_crq, 0);
 SHOW_FUNCTION(cfq_back_max_show, cfqd->cfq_back_max, 0);
 SHOW_FUNCTION(cfq_back_penalty_show, cfqd->cfq_back_penalty, 0);
+SHOW_FUNCTION(cfq_slice_idle_show, cfqd->cfq_slice_idle, 1);
+SHOW_FUNCTION(cfq_slice_sync_show, cfqd->cfq_slice[1], 1);
+SHOW_FUNCTION(cfq_slice_async_show, cfqd->cfq_slice[0], 1);
+SHOW_FUNCTION(cfq_slice_async_rq_show, cfqd->cfq_slice_async_rq, 0);
+SHOW_FUNCTION(cfq_max_depth_show, cfqd->cfq_max_depth, 0);
 #undef SHOW_FUNCTION
 
 #define STORE_FUNCTION(__FUNC, __PTR, MIN, MAX, __CONV)			\
@@ -1729,6 +1880,11 @@
 STORE_FUNCTION(cfq_find_best_store, &cfqd->find_best_crq, 0, 1, 0);
 STORE_FUNCTION(cfq_back_max_store, &cfqd->cfq_back_max, 0, UINT_MAX, 0);
 STORE_FUNCTION(cfq_back_penalty_store, &cfqd->cfq_back_penalty, 1, UINT_MAX, 0);
+STORE_FUNCTION(cfq_slice_idle_store, &cfqd->cfq_slice_idle, 0, UINT_MAX, 1);
+STORE_FUNCTION(cfq_slice_sync_store, &cfqd->cfq_slice[1], 1, UINT_MAX, 1);
+STORE_FUNCTION(cfq_slice_async_store, &cfqd->cfq_slice[0], 1, UINT_MAX, 1);
+STORE_FUNCTION(cfq_slice_async_rq_store, &cfqd->cfq_slice_async_rq, 1, UINT_MAX, 0);
+STORE_FUNCTION(cfq_max_depth_store, &cfqd->cfq_max_depth, 2, UINT_MAX, 0);
 #undef STORE_FUNCTION
 
 static struct cfq_fs_entry cfq_quantum_entry = {
@@ -1771,15 +1927,36 @@
 	.show = cfq_back_penalty_show,
 	.store = cfq_back_penalty_store,
 };
-static struct cfq_fs_entry cfq_clear_elapsed_entry = {
-	.attr = {.name = "clear_elapsed", .mode = S_IWUSR },
-	.store = cfq_clear_elapsed,
+static struct cfq_fs_entry cfq_slice_sync_entry = {
+	.attr = {.name = "slice_sync", .mode = S_IRUGO | S_IWUSR },
+	.show = cfq_slice_sync_show,
+	.store = cfq_slice_sync_store,
+};
+static struct cfq_fs_entry cfq_slice_async_entry = {
+	.attr = {.name = "slice_async", .mode = S_IRUGO | S_IWUSR },
+	.show = cfq_slice_async_show,
+	.store = cfq_slice_async_store,
+};
+static struct cfq_fs_entry cfq_slice_async_rq_entry = {
+	.attr = {.name = "slice_async_rq", .mode = S_IRUGO | S_IWUSR },
+	.show = cfq_slice_async_rq_show,
+	.store = cfq_slice_async_rq_store,
+};
+static struct cfq_fs_entry cfq_slice_idle_entry = {
+	.attr = {.name = "slice_idle", .mode = S_IRUGO | S_IWUSR },
+	.show = cfq_slice_idle_show,
+	.store = cfq_slice_idle_store,
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
@@ -1791,7 +1968,11 @@
 	&cfq_find_best_entry.attr,
 	&cfq_back_max_entry.attr,
 	&cfq_back_penalty_entry.attr,
-	&cfq_clear_elapsed_entry.attr,
+	&cfq_slice_sync_entry.attr,
+	&cfq_slice_async_entry.attr,
+	&cfq_slice_async_rq_entry.attr,
+	&cfq_slice_idle_entry.attr,
+	&cfq_max_depth_entry.attr,
 	NULL,
 };
 
@@ -1856,7 +2037,7 @@
 	.elevator_owner =	THIS_MODULE,
 };
 
-int cfq_init(void)
+static int __init cfq_init(void)
 {
 	int ret;
 
@@ -1864,17 +2045,34 @@
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
+	} while_each_thread(g, p);
+
+	read_unlock_irqrestore(&tasklist_lock, flags);
+
 	cfq_slab_kill();
 	elv_unregister(&iosched_cfq);
 }
diff -urP -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.6.10-rc2-mm4/drivers/block/ll_rw_blk.c linux-2.6.10-rc2-mm4/drivers/block/ll_rw_blk.c
--- /opt/kernel/linux-2.6.10-rc2-mm4/drivers/block/ll_rw_blk.c	2004-12-06 16:07:50.000000000 +0100
+++ linux-2.6.10-rc2-mm4/drivers/block/ll_rw_blk.c	2004-12-06 16:11:27.000000000 +0100
@@ -1257,11 +1257,7 @@
 	if (!blk_remove_plug(q))
 		return;
 
-	/*
-	 * was plugged, fire request_fn if queue has stuff to do
-	 */
-	if (elv_next_request(q))
-		q->request_fn(q);
+	q->request_fn(q);
 }
 EXPORT_SYMBOL(__generic_unplug_device);
 
@@ -2153,7 +2149,6 @@
 		return;
 
 	req->rq_status = RQ_INACTIVE;
-	req->q = NULL;
 	req->rl = NULL;
 
 	/*
@@ -2447,6 +2442,9 @@
 	if (barrier)
 		req->flags |= (REQ_HARDBARRIER | REQ_NOMERGE);
 
+	if (bio_sync(bio))
+		req->flags |= REQ_SYNCHRONOUS;
+
 	req->errors = 0;
 	req->hard_sector = req->sector = sector;
 	req->hard_nr_sectors = req->nr_sectors = nr_sectors;
@@ -2503,6 +2501,7 @@
 {
 	struct request_list *rl = &q->rq;
 	struct request *rq;
+	int requeued = 0;
 
 	spin_lock_irq(q->queue_lock);
 	clear_bit(QUEUE_FLAG_DRAIN, &q->queue_flags);
@@ -2511,9 +2510,13 @@
 		rq = list_entry_rq(q->drain_list.next);
 
 		list_del_init(&rq->queuelist);
-		__elv_add_request(q, rq, ELEVATOR_INSERT_BACK, 1);
+		elv_requeue_request(q, rq);
+		requeued++;
 	}
 
+	if (requeued)
+		q->request_fn(q);
+
 	spin_unlock_irq(q->queue_lock);
 
 	wake_up(&rl->wait[0]);
@@ -3070,6 +3073,7 @@
 	local_irq_save(flags);
 	ioc = current->io_context;
 	current->io_context = NULL;
+	ioc->task = NULL;
 	local_irq_restore(flags);
 
 	if (ioc->aic && ioc->aic->exit)
@@ -3104,7 +3108,7 @@
 	ret = kmem_cache_alloc(iocontext_cachep, gfp_flags);
 	if (ret) {
 		atomic_set(&ret->refcount, 1);
-		ret->pid = tsk->pid;
+		ret->task = current;
 		ret->last_waited = jiffies; /* doesn't matter... */
 		ret->nr_batch_requests = 0; /* because this is 0 */
 		ret->aic = NULL;
diff -urP -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.6.10-rc2-mm4/fs/buffer.c linux-2.6.10-rc2-mm4/fs/buffer.c
--- /opt/kernel/linux-2.6.10-rc2-mm4/fs/buffer.c	2004-12-06 16:08:06.000000000 +0100
+++ linux-2.6.10-rc2-mm4/fs/buffer.c	2004-12-06 16:11:16.000000000 +0100
@@ -347,7 +347,6 @@
 		goto out_putf;
 	}
 
-	current->flags |= PF_SYNCWRITE;
 	ret = filemap_fdatawrite(mapping);
 
 	/*
@@ -362,7 +361,6 @@
 	err = filemap_fdatawait(mapping);
 	if (!ret)
 		ret = err;
-	current->flags &= ~PF_SYNCWRITE;
 
 out_putf:
 	fput(file);
@@ -387,7 +385,6 @@
 
 	mapping = file->f_mapping;
 
-	current->flags |= PF_SYNCWRITE;
 	ret = filemap_fdatawrite(mapping);
 	down(&mapping->host->i_sem);
 	err = file->f_op->fsync(file, file->f_dentry, 1);
@@ -397,7 +394,6 @@
 	err = filemap_fdatawait(mapping);
 	if (!ret)
 		ret = err;
-	current->flags &= ~PF_SYNCWRITE;
 
 out_putf:
 	fput(file);
diff -urP -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.6.10-rc2-mm4/fs/fs-writeback.c linux-2.6.10-rc2-mm4/fs/fs-writeback.c
--- /opt/kernel/linux-2.6.10-rc2-mm4/fs/fs-writeback.c	2004-12-06 16:08:06.000000000 +0100
+++ linux-2.6.10-rc2-mm4/fs/fs-writeback.c	2004-12-06 16:11:27.000000000 +0100
@@ -630,7 +630,6 @@
 	int need_write_inode_now = 0;
 	int err2;
 
-	current->flags |= PF_SYNCWRITE;
 	if (what & OSYNC_DATA)
 		err = filemap_fdatawrite(mapping);
 	if (what & (OSYNC_METADATA|OSYNC_DATA)) {
@@ -643,7 +642,6 @@
 		if (!err)
 			err = err2;
 	}
-	current->flags &= ~PF_SYNCWRITE;
 
 	spin_lock(&inode_lock);
 	if ((inode->i_state & I_DIRTY) &&
diff -urP -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.6.10-rc2-mm4/fs/mpage.c linux-2.6.10-rc2-mm4/fs/mpage.c
--- /opt/kernel/linux-2.6.10-rc2-mm4/fs/mpage.c	2004-12-06 16:08:06.000000000 +0100
+++ linux-2.6.10-rc2-mm4/fs/mpage.c	2004-12-06 16:11:27.000000000 +0100
@@ -87,11 +87,16 @@
 	return 0;
 }
 
-struct bio *mpage_bio_submit(int rw, struct bio *bio)
+struct bio *
+mpage_bio_submit(int rw, struct bio *bio, struct writeback_control *wbc)
 {
 	bio->bi_end_io = mpage_end_io_read;
-	if (rw == WRITE)
+	if (rw == WRITE) {
+		if (wbc->sync_mode == WB_SYNC_ALL)
+			rw = WRITE_SYNC;
+
 		bio->bi_end_io = mpage_end_io_write;
+	}
 	submit_bio(rw, bio);
 	return NULL;
 }
@@ -285,7 +290,7 @@
 	 * This page will go to BIO.  Do we need to send this BIO off first?
 	 */
 	if (bio && (*last_block_in_bio != blocks[0] - 1))
-		bio = mpage_bio_submit(READ, bio);
+		bio = mpage_bio_submit(READ, bio, NULL);
 
 alloc_new:
 	if (bio == NULL) {
@@ -298,12 +303,12 @@
 
 	length = first_hole << blkbits;
 	if (bio_add_page(bio, page, length, 0) < length) {
-		bio = mpage_bio_submit(READ, bio);
+		bio = mpage_bio_submit(READ, bio, NULL);
 		goto alloc_new;
 	}
 
 	if (buffer_boundary(&bh) || (first_hole != blocks_per_page))
-		bio = mpage_bio_submit(READ, bio);
+		bio = mpage_bio_submit(READ, bio, NULL);
 	else
 		*last_block_in_bio = blocks[blocks_per_page - 1];
 out:
@@ -311,7 +316,7 @@
 
 confused:
 	if (bio)
-		bio = mpage_bio_submit(READ, bio);
+		bio = mpage_bio_submit(READ, bio, NULL);
 	if (!PageUptodate(page))
 	        block_read_full_page(page, get_block);
 	else
@@ -348,7 +353,7 @@
 	pagevec_lru_add(&lru_pvec);
 	BUG_ON(!list_empty(pages));
 	if (bio)
-		mpage_bio_submit(READ, bio);
+		mpage_bio_submit(READ, bio, NULL);
 	return 0;
 }
 EXPORT_SYMBOL(mpage_readpages);
@@ -364,7 +369,7 @@
 	bio = do_mpage_readpage(bio, page, 1,
 			&last_block_in_bio, get_block);
 	if (bio)
-		mpage_bio_submit(READ, bio);
+		mpage_bio_submit(READ, bio, NULL);
 	return 0;
 }
 EXPORT_SYMBOL(mpage_readpage);
@@ -517,7 +522,7 @@
 	 * This page will go to BIO.  Do we need to send this BIO off first?
 	 */
 	if (bio && *last_block_in_bio != blocks[0] - 1)
-		bio = mpage_bio_submit(WRITE, bio);
+		bio = mpage_bio_submit(WRITE, bio, wbc);
 
 alloc_new:
 	if (bio == NULL) {
@@ -534,7 +539,7 @@
 	 */
 	length = first_unmapped << blkbits;
 	if (bio_add_page(bio, page, length, 0) < length) {
-		bio = mpage_bio_submit(WRITE, bio);
+		bio = mpage_bio_submit(WRITE, bio, wbc);
 		goto alloc_new;
 	}
 
@@ -567,7 +572,7 @@
 	set_page_writeback(page);
 	unlock_page(page);
 	if (boundary || (first_unmapped != blocks_per_page)) {
-		bio = mpage_bio_submit(WRITE, bio);
+		bio = mpage_bio_submit(WRITE, bio, wbc);
 		if (boundary_block) {
 			write_boundary_block(boundary_bdev,
 					boundary_block, 1 << blkbits);
@@ -579,7 +584,7 @@
 
 confused:
 	if (bio)
-		bio = mpage_bio_submit(WRITE, bio);
+		bio = mpage_bio_submit(WRITE, bio, wbc);
 	*ret = page->mapping->a_ops->writepage(page, wbc);
 	/*
 	 * The caller has a ref on the inode, so *mapping is stable
@@ -731,7 +736,7 @@
 	if (!is_range)
 		mapping->writeback_index = index;
 	if (bio)
-		mpage_bio_submit(WRITE, bio);
+		mpage_bio_submit(WRITE, bio, wbc);
 	return ret;
 }
 EXPORT_SYMBOL(mpage_writepages);
diff -urP -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.6.10-rc2-mm4/include/linux/blkdev.h linux-2.6.10-rc2-mm4/include/linux/blkdev.h
--- /opt/kernel/linux-2.6.10-rc2-mm4/include/linux/blkdev.h	2004-12-06 16:07:55.000000000 +0100
+++ linux-2.6.10-rc2-mm4/include/linux/blkdev.h	2004-12-06 16:11:27.000000000 +0100
@@ -73,7 +73,7 @@
  */
 struct io_context {
 	atomic_t refcount;
-	pid_t pid;
+	struct task_struct *task;
 
 	/*
 	 * For request batching
@@ -209,6 +209,7 @@
 	__REQ_PM_SHUTDOWN,	/* shutdown request */
 	__REQ_BAR_PREFLUSH,	/* barrier pre-flush done */
 	__REQ_BAR_POSTFLUSH,	/* barrier post-flush */
+	__REQ_SYNCHRONOUS,	/* sync request */
 	__REQ_NR_BITS,		/* stops here */
 };
 
@@ -236,6 +237,7 @@
 #define REQ_PM_SHUTDOWN	(1 << __REQ_PM_SHUTDOWN)
 #define REQ_BAR_PREFLUSH	(1 << __REQ_BAR_PREFLUSH)
 #define REQ_BAR_POSTFLUSH	(1 << __REQ_BAR_POSTFLUSH)
+#define REQ_SYNCHRONOUS	(1 << __REQ_SYNCHRONOUS)
 
 /*
  * State information carried for REQ_PM_SUSPEND and REQ_PM_RESUME
@@ -406,6 +408,7 @@
 #define blk_pc_request(rq)	((rq)->flags & REQ_BLOCK_PC)
 #define blk_noretry_request(rq)	((rq)->flags & REQ_FAILFAST)
 #define blk_rq_started(rq)	((rq)->flags & REQ_STARTED)
+#define blk_rq_sync(rq)		((rq)->flags & REQ_SYNCHRONOUS)
 
 #define blk_account_rq(rq)	(blk_rq_started(rq) && blk_fs_request(rq))
 
diff -urP -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.6.10-rc2-mm4/include/linux/sched.h linux-2.6.10-rc2-mm4/include/linux/sched.h
--- /opt/kernel/linux-2.6.10-rc2-mm4/include/linux/sched.h	2004-12-06 16:07:55.000000000 +0100
+++ linux-2.6.10-rc2-mm4/include/linux/sched.h	2004-12-06 16:11:27.000000000 +0100
@@ -724,8 +724,7 @@
 #define PF_KSWAPD	0x00040000	/* I am kswapd */
 #define PF_SWAPOFF	0x00080000	/* I am in swapoff */
 #define PF_LESS_THROTTLE 0x00100000	/* Throttle me less: I clean memory */
-#define PF_SYNCWRITE	0x00200000	/* I am doing a sync write */
-#define PF_BORROWED_MM	0x00400000	/* I am a kthread doing use_mm */
+#define PF_BORROWED_MM	0x00200000	/* I am a kthread doing use_mm */
 
 #ifdef CONFIG_SMP
 extern int set_cpus_allowed(task_t *p, cpumask_t new_mask);
@@ -753,6 +752,7 @@
 extern int task_nice(const task_t *p);
 extern int task_curr(const task_t *p);
 extern int idle_cpu(int cpu);
+extern unsigned long task_will_schedule_at(const task_t *p);
 
 void yield(void);
 
diff -urP -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.6.10-rc2-mm4/kernel/sched.c linux-2.6.10-rc2-mm4/kernel/sched.c
--- /opt/kernel/linux-2.6.10-rc2-mm4/kernel/sched.c	2004-12-06 16:08:12.000000000 +0100
+++ linux-2.6.10-rc2-mm4/kernel/sched.c	2004-12-06 16:11:27.000000000 +0100
@@ -580,7 +580,7 @@
 static void dequeue_task(struct task_struct *p, prio_array_t *array)
 {
 	array->nr_active--;
-	list_del(&p->run_list);
+	list_del_init(&p->run_list);
 	if (list_empty(array->queue + p->prio))
 		__clear_bit(p->prio, array->bitmap);
 }
@@ -823,6 +823,41 @@
 	return cpu_curr(task_cpu(p)) == p;
 }
 
+/**
+ * task_will_schedule_at - in how many ticks will the task run, most likely
+ * @p: the task in question
+ */
+unsigned long task_will_schedule_at(const task_t *p)
+{
+	/*
+	 * Task is executing right now
+	 */
+	if (task_curr(p))
+		return 0;
+
+	/*
+	 * Task is not executing but on a runqueue - try to guess
+	 * how much time it will take for it to run again, but using
+	 * the current task's remaining ticks. This is not accurate,
+	 * but a good guess. (We use the min() to avoid the small race
+	 * that is due to us dereferencing the current task without
+	 * locking)
+	 */
+	if (p->array)
+		return min(cpu_curr(task_cpu(p))->time_slice,
+					(unsigned int)MAX_SLEEP_AVG);
+
+	/*
+	 * for blocked tasks, return half of the average sleep time.
+	 * (because this is the average sleep-time we'll see if we
+	 * sample the period randomly.)
+	 */
+	return NS_TO_JIFFIES(p->sleep_avg) / 2;
+}
+
+EXPORT_SYMBOL_GPL(task_will_schedule_at);
+
+
 #ifdef CONFIG_SMP
 enum request_type {
 	REQ_MOVE_TASK,



-- 
Jens Axboe

