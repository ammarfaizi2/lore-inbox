Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269070AbUIXXhm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269070AbUIXXhm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 19:37:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269073AbUIXXhl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 19:37:41 -0400
Received: from mtagate1.uk.ibm.com ([195.212.29.134]:8888 "EHLO
	mtagate1.uk.ibm.com") by vger.kernel.org with ESMTP id S269070AbUIXXgK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 19:36:10 -0400
Message-ID: <4154AF5A.9050706@watson.ibm.com>
Date: Fri, 24 Sep 2004 19:35:54 -0400
From: Shailabh Nagar <nagar@watson.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: ckrm-tech <ckrm-tech@lists.sourceforge.net>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH][0/1] port iopriorities to CFQ for 2.6.8.1
Content-Type: multipart/mixed;
 boundary="------------010109090905000309030502"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010109090905000309030502
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Here is a patch that adds I/O priorities to the CFQ I/O scheduler in 
2.6.8.1. Its a forward port of the version Jens had posted a while 
back (http://www.ussg.iu.edu/hypermail/linux/kernel/0311.1/0024.html)

The patch sustains 2 diskhogs running at different I/O priorities for 
over 10 minutes and pounding on an IDE disk.

The patch was developed to continue CKRM's I/O scheduler work. Since 
this scheduler is needed for CKRM, any feedback from testing will be 
much appreciated. Please cc: ckrm-tech@lists.sf.net.

A subsequent patch will export per-priority level statistics of 
interest but is not required for correct functioning of this patch.

-- Shailabh








--------------010109090905000309030502
Content-Type: text/plain;
 name="cfq-addprio.2681.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cfq-addprio.2681.patch"

diff -Nru a/arch/i386/kernel/entry.S b/arch/i386/kernel/entry.S
--- a/arch/i386/kernel/entry.S	Fri Sep 24 18:58:47 2004
+++ b/arch/i386/kernel/entry.S	Fri Sep 24 18:58:47 2004
@@ -886,5 +886,7 @@
 	.long sys_mq_notify
 	.long sys_mq_getsetattr
 	.long sys_ni_syscall		/* reserved for kexec */
+	.long sys_ioprio_set
+	.long sys_ioprio_get		/* 285 */
 
 syscall_table_size=(.-sys_call_table)
diff -Nru a/arch/ppc/kernel/misc.S b/arch/ppc/kernel/misc.S
--- a/arch/ppc/kernel/misc.S	Fri Sep 24 18:58:47 2004
+++ b/arch/ppc/kernel/misc.S	Fri Sep 24 18:58:47 2004
@@ -1450,3 +1450,5 @@
 	.long sys_mq_notify
 	.long sys_mq_getsetattr
 	.long sys_ni_syscall		/* 268 reserved for sys_kexec_load */
+	.long sys_ioprio_set
+	.long sys_ioprio_get		
diff -Nru a/drivers/block/cfq-iosched.c b/drivers/block/cfq-iosched.c
--- a/drivers/block/cfq-iosched.c	Fri Sep 24 18:58:47 2004
+++ b/drivers/block/cfq-iosched.c	Fri Sep 24 18:58:47 2004
@@ -6,6 +6,18 @@
  *  Based on ideas from a previously unfinished io
  *  scheduler (round robin per-process disk scheduling) and Andrea Arcangeli.
  *
+ *  IO priorities are supported, from 0% to 100% in 5% increments. Both of
+ *  those values have special meaning - 0% class is allowed to do io if
+ *  noone else wants to use the disk. 100% is considered real-time io, and
+ *  always get priority. Default process io rate is 95%. In absence of other
+ *  io, a class may consume 100% disk bandwidth regardless. Withing a class,
+ *  bandwidth is distributed equally among the citizens.
+ *
+ * TODO:
+ *	- cfq_select_requests() needs some work for 5-95% io
+ *	- barriers not supported
+ *	- export grace periods in ms, not jiffies
+ *
  *  Copyright (C) 2003 Jens Axboe <axboe@suse.de>
  */
 #include <linux/kernel.h>
@@ -22,77 +34,136 @@
 #include <linux/rbtree.h>
 #include <linux/mempool.h>
 
+#if IOPRIO_NR > BITS_PER_LONG
+#error Cannot support this many io priority levels
+#endif
+
 /*
  * tunables
  */
-static int cfq_quantum = 4;
-static int cfq_queued = 8;
+static int cfq_quantum = 6;
+static int cfq_quantum_io = 256;
+static int cfq_idle_quantum = 1;
+static int cfq_idle_quantum_io = 64;
+static int cfq_queued = 4;
+static int cfq_grace_rt = HZ / 100 ?: 1;
+static int cfq_grace_idle = HZ / 10;
 
 #define CFQ_QHASH_SHIFT		6
 #define CFQ_QHASH_ENTRIES	(1 << CFQ_QHASH_SHIFT)
-#define list_entry_qhash(entry)	list_entry((entry), struct cfq_queue, cfq_hash)
+#define list_entry_qhash(entry)	hlist_entry((entry), struct cfq_queue, cfq_hash)
 
 #define CFQ_MHASH_SHIFT		8
 #define CFQ_MHASH_BLOCK(sec)	((sec) >> 3)
 #define CFQ_MHASH_ENTRIES	(1 << CFQ_MHASH_SHIFT)
 #define CFQ_MHASH_FN(sec)	(hash_long(CFQ_MHASH_BLOCK((sec)),CFQ_MHASH_SHIFT))
-#define ON_MHASH(crq)		!list_empty(&(crq)->hash)
 #define rq_hash_key(rq)		((rq)->sector + (rq)->nr_sectors)
-#define list_entry_hash(ptr)	list_entry((ptr), struct cfq_rq, hash)
+#define list_entry_hash(ptr)	hlist_entry((ptr), struct cfq_rq, hash)
 
 #define list_entry_cfqq(ptr)	list_entry((ptr), struct cfq_queue, cfq_list)
+#define list_entry_prio(ptr)	list_entry((ptr), struct cfq_rq, prio_list)
+
+#define cfq_account_io(crq)	\
+	((crq)->ioprio != IOPRIO_IDLE && (crq)->ioprio != IOPRIO_RT)
+
+/*
+ * defines how we distribute bandwidth (can be tgid, uid, etc)
+ */
+#define cfq_hash_key(current)	((current)->tgid)
+
+/*
+ * move to io_context
+ */
+#define cfq_ioprio(current)	((current)->ioprio)
 
-#define RQ_DATA(rq)		((struct cfq_rq *) (rq)->elevator_private)
+#define CFQ_WAIT_RT	0
+#define CFQ_WAIT_NORM	1
 
 static kmem_cache_t *crq_pool;
 static kmem_cache_t *cfq_pool;
 static mempool_t *cfq_mpool;
 
+/*
+ * defines an io priority level
+ */
+struct io_prio_data {
+	struct list_head rr_list;
+	int busy_queues;
+	int busy_rq;
+	unsigned long busy_sectors;
+	struct list_head prio_list;
+	int last_rq;
+	int last_sectors;
+};
+
+/*
+ * per-request queue structure
+ */
 struct cfq_data {
 	struct list_head rr_list;
 	struct list_head *dispatch;
-	struct list_head *cfq_hash;
+	struct hlist_head *cfq_hash;
+	struct hlist_head *crq_hash;
+	mempool_t *crq_pool;
 
-	struct list_head *crq_hash;
+	struct io_prio_data cid[IOPRIO_NR];
 
-	unsigned int busy_queues;
-	unsigned int max_queued;
+	/*
+	 * total number of busy queues and requests
+	 */
+	int busy_rq;
+	int busy_queues;
+	unsigned long busy_sectors;
 
-	mempool_t *crq_pool;
 
 	request_queue_t *queue;
+	unsigned long rq_starved_mask;
+
+	/*
+	 * grace period handling
+	 */
+	struct timer_list timer;
+	unsigned long wait_end;
+	unsigned long flags;
+	struct work_struct work;
 
 	/*
 	 * tunables
 	 */
 	unsigned int cfq_quantum;
+	unsigned int cfq_quantum_io;
+	unsigned int cfq_idle_quantum;
+	unsigned int cfq_idle_quantum_io;
 	unsigned int cfq_queued;
+	unsigned int cfq_grace_rt;
+	unsigned int cfq_grace_idle;
 };
 
+/*
+ * per-class structure
+ */
 struct cfq_queue {
-	struct list_head cfq_hash;
 	struct list_head cfq_list;
+	struct hlist_node cfq_hash;
+	int hash_key;
 	struct rb_root sort_list;
-	int pid;
 	int queued[2];
-#if 0
-	/*
-	 * with a simple addition like this, we can do io priorities. almost.
-	 * does need a split request free list, too.
-	 */
-	int io_prio
-#endif
+	int ioprio;
 };
 
+/*
+ * per-request structure
+ */
 struct cfq_rq {
+	struct cfq_queue *cfq_queue;
 	struct rb_node rb_node;
+	struct hlist_node hash;
 	sector_t rb_key;
 
 	struct request *request;
-
-	struct cfq_queue *cfq_queue;
-
-	struct list_head hash;
+	struct list_head prio_list;
+	unsigned long nr_sectors;
+	int ioprio;
 };
 
 static void cfq_put_queue(struct cfq_data *cfqd, struct cfq_queue *cfqq);
@@ -103,18 +174,13 @@
 /*
  * lots of deadline iosched dupes, can be abstracted later...
  */
-static inline void __cfq_del_crq_hash(struct cfq_rq *crq)
-{
-	list_del_init(&crq->hash);
-}
-
 static inline void cfq_del_crq_hash(struct cfq_rq *crq)
 {
-	if (ON_MHASH(crq))
-		__cfq_del_crq_hash(crq);
+	hlist_del_init(&crq->hash);
 }
 
-static void cfq_remove_merge_hints(request_queue_t *q, struct cfq_rq *crq)
+static inline void
+cfq_remove_merge_hints(request_queue_t *q, struct cfq_rq *crq)
 {
 	cfq_del_crq_hash(crq);
 
@@ -125,27 +191,26 @@
 static inline void cfq_add_crq_hash(struct cfq_data *cfqd, struct cfq_rq *crq)
 {
 	struct request *rq = crq->request;
+	const int hash_idx = CFQ_MHASH_FN(rq_hash_key(rq));
 
-	BUG_ON(ON_MHASH(crq));
-
-	list_add(&crq->hash, &cfqd->crq_hash[CFQ_MHASH_FN(rq_hash_key(rq))]);
+	BUG_ON(!hlist_unhashed(&crq->hash));
+ 
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
 
@@ -159,20 +224,25 @@
 /*
  * rb tree support functions
  */
-#define RB_NONE		(2)
-#define RB_EMPTY(node)	((node)->rb_node == NULL)
-#define RB_CLEAR(node)	((node)->rb_color = RB_NONE)
-#define RB_CLEAR_ROOT(root)	((root)->rb_node = NULL)
-#define ON_RB(node)	((node)->rb_color != RB_NONE)
+#define RB_EMPTY(node)		((node)->rb_node == NULL)
 #define rb_entry_crq(node)	rb_entry((node), struct cfq_rq, rb_node)
 #define rq_rb_key(rq)		(rq)->sector
 
-static inline void cfq_del_crq_rb(struct cfq_queue *cfqq, struct cfq_rq *crq)
+static void
+cfq_del_crq_rb(struct cfq_data *cfqd, struct cfq_queue *cfqq,struct cfq_rq *crq)
 {
-	if (ON_RB(&crq->rb_node)) {
+	if (crq->cfq_queue) {
+		crq->cfq_queue = NULL;
+
+		if (cfq_account_io(crq)) {
+			cfqd->busy_rq--;
+			cfqd->busy_sectors -= crq->nr_sectors;
+			cfqd->cid[crq->ioprio].busy_rq--;
+			cfqd->cid[crq->ioprio].busy_sectors -= crq->nr_sectors;
+		}
+
 		cfqq->queued[rq_data_dir(crq->request)]--;
 		rb_erase(&crq->rb_node, &cfqq->sort_list);
-		crq->cfq_queue = NULL;
 	}
 }
 
@@ -205,12 +275,19 @@
 	struct request *rq = crq->request;
 	struct cfq_rq *__alias;
 
-	crq->rb_key = rq_rb_key(rq);
+
 	cfqq->queued[rq_data_dir(rq)]++;
+	if (cfq_account_io(crq)) {
+		cfqd->busy_rq++;
+		cfqd->busy_sectors += crq->nr_sectors;
+		cfqd->cid[crq->ioprio].busy_rq++;
+		cfqd->cid[crq->ioprio].busy_sectors += crq->nr_sectors;
+	}
 retry:
 	__alias = __cfq_add_crq_rb(cfqq, crq);
 	if (!__alias) {
 		rb_insert_color(&crq->rb_node, &cfqq->sort_list);
+		crq->rb_key = rq_rb_key(rq);
 		crq->cfq_queue = cfqq;
 		return;
 	}
@@ -222,7 +299,7 @@
 static struct request *
 cfq_find_rq_rb(struct cfq_data *cfqd, sector_t sector)
 {
-	struct cfq_queue *cfqq = cfq_find_cfq_hash(cfqd, current->tgid);
+	struct cfq_queue *cfqq = cfq_find_cfq_hash(cfqd, cfq_hash_key(current));
 	struct rb_node *n;
 
 	if (!cfqq)
@@ -247,16 +324,31 @@
 static void cfq_remove_request(request_queue_t *q, struct request *rq)
 {
 	struct cfq_data *cfqd = q->elevator.elevator_data;
-	struct cfq_rq *crq = RQ_DATA(rq);
+	struct cfq_rq *crq = RQ_ELV_DATA(rq);
 
 	if (crq) {
-		struct cfq_queue *cfqq = crq->cfq_queue;
 
 		cfq_remove_merge_hints(q, crq);
+		list_del_init(&crq->prio_list);
 		list_del_init(&rq->queuelist);
 
-		if (cfqq) {
-			cfq_del_crq_rb(cfqq, crq);
+		/*
+		 * set a grace period timer to allow realtime io to make real
+		 * progress, if we release an rt request. for normal request,
+		 * set timer so idle io doesn't interfere with other io
+		 */
+		if (crq->ioprio == IOPRIO_RT) {
+			set_bit(CFQ_WAIT_RT, &cfqd->flags);
+			cfqd->wait_end = jiffies + cfqd->cfq_grace_rt;
+		} else if (crq->ioprio != IOPRIO_IDLE) {
+			set_bit(CFQ_WAIT_NORM, &cfqd->flags);
+			cfqd->wait_end = jiffies + cfqd->cfq_grace_idle;
+		}
+
+		if (crq->cfq_queue) {
+			struct cfq_queue *cfqq = crq->cfq_queue;
+
+			cfq_del_crq_rb(cfqd, cfqq, crq);
 
 			if (RB_EMPTY(&cfqq->sort_list))
 				cfq_put_queue(cfqd, cfqq);
@@ -306,18 +398,23 @@
 static void cfq_merged_request(request_queue_t *q, struct request *req)
 {
 	struct cfq_data *cfqd = q->elevator.elevator_data;
-	struct cfq_rq *crq = RQ_DATA(req);
+	struct cfq_rq *crq = RQ_ELV_DATA(req);
 
 	cfq_del_crq_hash(crq);
 	cfq_add_crq_hash(cfqd, crq);
 
-	if (ON_RB(&crq->rb_node) && (rq_rb_key(req) != crq->rb_key)) {
+	if (crq->cfq_queue && (rq_rb_key(req) != crq->rb_key)) {
 		struct cfq_queue *cfqq = crq->cfq_queue;
 
-		cfq_del_crq_rb(cfqq, crq);
+		cfq_del_crq_rb(cfqd, cfqq, crq);
 		cfq_add_crq_rb(cfqd, cfqq, crq);
 	}
 
+	cfqd->busy_sectors += req->hard_nr_sectors - crq->nr_sectors;
+	cfqd->cid[crq->ioprio].busy_sectors += 
+		req->hard_nr_sectors - crq->nr_sectors;
+	crq->nr_sectors = req->hard_nr_sectors;
+
 	q->last_merge = req;
 }
 
@@ -329,6 +426,9 @@
 	cfq_remove_request(q, next);
 }
 
+/*
+ * sort into dispatch list, in optimal ascending order
+ */
 static void
 cfq_dispatch_sort(struct cfq_data *cfqd, struct cfq_queue *cfqq,
 		  struct cfq_rq *crq)
@@ -336,7 +436,7 @@
 	struct list_head *head = cfqd->dispatch, *entry = head;
 	struct request *__rq;
 
-	cfq_del_crq_rb(cfqq, crq);
+	cfq_del_crq_rb(cfqd, cfqq, crq);
 	cfq_remove_merge_hints(cfqd->queue, crq);
 
 	if (!list_empty(head)) {
@@ -359,47 +459,160 @@
 	list_add_tail(&crq->request->queuelist, entry);
 }
 
-static inline void
+/*
+ * remove from io scheduler core and put on dispatch list for service
+ */
+static inline int
 __cfq_dispatch_requests(request_queue_t *q, struct cfq_data *cfqd,
 			struct cfq_queue *cfqq)
 {
-	struct cfq_rq *crq = rb_entry_crq(rb_first(&cfqq->sort_list));
+	struct cfq_rq *crq;
 
+	crq = rb_entry_crq(rb_first(&cfqq->sort_list));
 	cfq_dispatch_sort(cfqd, cfqq, crq);
+
+	/*
+	 * technically, for IOPRIO_RT we don't need to add it to the list.
+	 */
+	list_add_tail(&crq->prio_list, &cfqd->cid[cfqq->ioprio].prio_list);
+	return crq->nr_sectors;
 }
 
-static int cfq_dispatch_requests(request_queue_t *q, struct cfq_data *cfqd)
+static int
+cfq_dispatch_requests(request_queue_t *q, int prio, int max_rq, int max_sectors)
 {
-	struct cfq_queue *cfqq;
-	struct list_head *entry, *tmp;
-	int ret, queued, good_queues;
-
-	if (list_empty(&cfqd->rr_list))
-		return 0;
+	struct cfq_data *cfqd = q->elevator.elevator_data;
+	struct list_head *plist = &cfqd->cid[prio].rr_list;
+	struct list_head *entry, *nxt;
+	int q_rq, q_io;
 
-	queued = ret = 0;
-restart:
-	good_queues = 0;
-	list_for_each_safe(entry, tmp, &cfqd->rr_list) {
-		cfqq = list_entry_cfqq(cfqd->rr_list.next);
+	/*
+	 * for each queue at this prio level, dispatch a request
+	 */
+	q_rq = q_io = 0;
+	list_for_each_safe(entry, nxt, plist) {
+		struct cfq_queue *cfqq = list_entry_cfqq(entry);
 
 		BUG_ON(RB_EMPTY(&cfqq->sort_list));
 
-		__cfq_dispatch_requests(q, cfqd, cfqq);
+		q_io += __cfq_dispatch_requests(q, cfqd, cfqq);
+		q_rq++;
 
 		if (RB_EMPTY(&cfqq->sort_list))
 			cfq_put_queue(cfqd, cfqq);
-		else
-			good_queues++;
+		/*
+		 * if we hit the queue limit, put the string of serviced
+		 * queues at the back of the pending list
+		 */
+		if (q_io >= max_sectors || q_rq >= max_rq) {
+			struct list_head *prv = nxt->prev;
 
-		queued++;
-		ret = 1;
+			if (prv != plist) {
+				list_del(plist);
+				list_add(plist, prv);
+			}
+			break;
+		}
 	}
 
-	if ((queued < cfqd->cfq_quantum) && good_queues)
-		goto restart;
+	cfqd->cid[prio].last_rq = q_rq;
+	cfqd->cid[prio].last_sectors = q_io;
+	return q_rq;
+}
 
-	return ret;
+/*
+ * try to move some requests to the dispatch list. return 0 on success
+ */
+static int cfq_select_requests(request_queue_t *q, struct cfq_data *cfqd)
+{
+	int queued, busy_rq, busy_sectors, i;
+
+	/*
+	 * if there's any realtime io, only schedule that
+	 */
+	if (cfq_dispatch_requests(q, IOPRIO_RT, cfqd->cfq_quantum, cfqd->cfq_quantum_io))
+		return 1;
+
+	/*
+	 * if RT io was last serviced and grace time hasn't expired,
+	 * arm the timer to restart queueing if no other RT io has been
+	 * submitted in the mean time
+	 */
+	if (test_bit(CFQ_WAIT_RT, &cfqd->flags)) {
+		if (time_before(jiffies, cfqd->wait_end)) {
+			mod_timer(&cfqd->timer, cfqd->wait_end);
+			return 0;
+		}
+		clear_bit(CFQ_WAIT_RT, &cfqd->flags);
+	}
+
+	/*
+	 * for each priority level, calculate number of requests we
+	 * are allowed to put into service.
+	 */
+	queued = 0;
+	busy_rq = cfqd->busy_rq;
+	busy_sectors = cfqd->busy_sectors;
+	for (i = IOPRIO_RT - 1; i > IOPRIO_IDLE; i--) {
+		const int o_rq = busy_rq - cfqd->cid[i].busy_rq;
+		const int o_sectors = busy_sectors - cfqd->cid[i].busy_sectors;
+		int q_rq = cfqd->cfq_quantum * (i + 1) / IOPRIO_NR;
+		int q_io = cfqd->cfq_quantum_io * (i + 1) / IOPRIO_NR;
+
+		/*
+		 * no need to keep iterating the list, if there are no
+		 * requests pending anymore
+		 */
+		if (!cfqd->busy_rq)
+			break;
+
+		/*
+		 * find out how many requests and sectors we are allowed to
+		 * service
+		 */
+		if (o_rq)
+			q_rq = o_sectors * (i + 1) / IOPRIO_NR;
+		if (q_rq > cfqd->cfq_quantum)
+			q_rq = cfqd->cfq_quantum;
+
+		if (o_sectors)
+			q_io = o_sectors * (i + 1) / IOPRIO_NR;
+		if (q_io > cfqd->cfq_quantum_io)
+			q_io = cfqd->cfq_quantum_io;
+
+		/*
+		 * average with last dispatched for fairness
+		 */
+		if (cfqd->cid[i].last_rq != -1)
+			q_rq = (cfqd->cid[i].last_rq + q_rq) / 2;
+		if (cfqd->cid[i].last_sectors != -1)
+			q_io = (cfqd->cid[i].last_sectors + q_io) / 2;
+
+		queued += cfq_dispatch_requests(q, i, q_rq, q_io);
+	}
+
+	if (queued)
+		return 1;
+
+	/*
+	 * only allow dispatch of idle io, if the queue has been idle from
+	 * servicing RT or normal io for the grace period
+	 */
+	if (test_bit(CFQ_WAIT_NORM, &cfqd->flags)) {
+		if (time_before(jiffies, cfqd->wait_end)) {
+			mod_timer(&cfqd->timer, cfqd->wait_end);
+			return 0;
+		}
+		clear_bit(CFQ_WAIT_NORM, &cfqd->flags);
+	}
+
+	/*
+	 * if we found nothing to do, allow idle io to be serviced
+	 */
+	if (cfq_dispatch_requests(q, IOPRIO_IDLE, cfqd->cfq_idle_quantum, cfqd->cfq_idle_quantum_io))
+		return 1;
+
+	return 0;
 }
 
 static struct request *cfq_next_request(request_queue_t *q)
@@ -410,61 +623,81 @@
 	if (!list_empty(cfqd->dispatch)) {
 		struct cfq_rq *crq;
 dispatch:
+		/*
+		 * end grace period, we are servicing a request
+		 */
+		del_timer(&cfqd->timer);
+		clear_bit(CFQ_WAIT_RT, &cfqd->flags);
+		clear_bit(CFQ_WAIT_NORM, &cfqd->flags);
+
+		BUG_ON(list_empty(cfqd->dispatch));
 		rq = list_entry_rq(cfqd->dispatch->next);
 
-		crq = RQ_DATA(rq);
-		if (crq)
-			cfq_remove_merge_hints(q, crq);
+		BUG_ON(q->last_merge == rq);
+		crq = RQ_ELV_DATA(rq);
+		if (crq) {
+			BUG_ON(!hlist_unhashed(&crq->hash));
+			list_del_init(&crq->prio_list);
+		}
 
 		return rq;
 	}
 
-	if (cfq_dispatch_requests(q, cfqd))
+	/*
+	 * we moved requests to dispatch list, go back end serve one
+	 */
+	if (cfq_select_requests(q, cfqd))
 		goto dispatch;
 
 	return NULL;
 }
 
 static inline struct cfq_queue *
-__cfq_find_cfq_hash(struct cfq_data *cfqd, int pid, const int hashval)
+__cfq_find_cfq_hash(struct cfq_data *cfqd, int hashkey, const int hashval)
 {
-	struct list_head *hash_list = &cfqd->cfq_hash[hashval];
-	struct list_head *entry;
+	struct hlist_head *hash_list = &cfqd->cfq_hash[hashval];
+	struct hlist_node *entry;
 
-	list_for_each(entry, hash_list) {
+	hlist_for_each(entry, hash_list) {
 		struct cfq_queue *__cfqq = list_entry_qhash(entry);
 
-		if (__cfqq->pid == pid)
+		if (__cfqq->hash_key == hashkey)
 			return __cfqq;
 	}
 
 	return NULL;
 }
 
-static struct cfq_queue *cfq_find_cfq_hash(struct cfq_data *cfqd, int pid)
+
+static struct cfq_queue *cfq_find_cfq_hash(struct cfq_data *cfqd, int hashkey)
 {
-	const int hashval = hash_long(current->tgid, CFQ_QHASH_SHIFT);
+	const int hashval = hash_long(hashkey, CFQ_QHASH_SHIFT);
 
-	return __cfq_find_cfq_hash(cfqd, pid, hashval);
+	return __cfq_find_cfq_hash(cfqd, hashkey, hashval);
 }
 
 static void cfq_put_queue(struct cfq_data *cfqd, struct cfq_queue *cfqq)
 {
 	cfqd->busy_queues--;
+	WARN_ON(cfqd->busy_queues < 0);
+
+	cfqd->cid[cfqq->ioprio].busy_queues--;
+	WARN_ON(cfqd->cid[cfqq->ioprio].busy_queues < 0);
+
 	list_del(&cfqq->cfq_list);
-	list_del(&cfqq->cfq_hash);
+	hlist_del(&cfqq->cfq_hash);
 	mempool_free(cfqq, cfq_mpool);
 }
 
-static struct cfq_queue *__cfq_get_queue(struct cfq_data *cfqd, int pid,
+static struct cfq_queue *__cfq_get_queue(struct cfq_data *cfqd, int hashkey,
 					 int gfp_mask)
 {
-	const int hashval = hash_long(current->tgid, CFQ_QHASH_SHIFT);
+	const int hashval = hash_long(hashkey, CFQ_QHASH_SHIFT);
 	struct cfq_queue *cfqq, *new_cfqq = NULL;
 	request_queue_t *q = cfqd->queue;
 
 retry:
-	cfqq = __cfq_find_cfq_hash(cfqd, pid, hashval);
+	cfqq = __cfq_find_cfq_hash(cfqd, hashkey, hashval);
 
 	if (!cfqq) {
 		if (new_cfqq) {
@@ -478,13 +711,12 @@
 		} else
 			return NULL;
 
-		INIT_LIST_HEAD(&cfqq->cfq_hash);
+		memset(cfqq, 0, sizeof(*cfqq));
+		INIT_HLIST_NODE(&cfqq->cfq_hash);
 		INIT_LIST_HEAD(&cfqq->cfq_list);
-		RB_CLEAR_ROOT(&cfqq->sort_list);
-
-		cfqq->pid = pid;
-		cfqq->queued[0] = cfqq->queued[1] = 0;
-		list_add(&cfqq->cfq_hash, &cfqd->cfq_hash[hashval]);
+		cfqq->hash_key = cfq_hash_key(current);
+		cfqq->ioprio = cfq_ioprio(current);
+		hlist_add_head(&cfqq->cfq_hash, &cfqd->cfq_hash[hashval]);
 	}
 
 	if (new_cfqq)
@@ -493,31 +725,60 @@
 	return cfqq;
 }
 
-static struct cfq_queue *cfq_get_queue(struct cfq_data *cfqd, int pid,
+static struct cfq_queue *cfq_get_queue(struct cfq_data *cfqd, int hashkey,
 				       int gfp_mask)
 {
 	request_queue_t *q = cfqd->queue;
 	struct cfq_queue *cfqq;
 
 	spin_lock_irq(q->queue_lock);
-	cfqq = __cfq_get_queue(cfqd, pid, gfp_mask);
+	cfqq = __cfq_get_queue(cfqd, hashkey, gfp_mask);
 	spin_unlock_irq(q->queue_lock);
 
 	return cfqq;
 }
 
-static void cfq_enqueue(struct cfq_data *cfqd, struct cfq_rq *crq)
+static void
+__cfq_enqueue(request_queue_t *q, struct cfq_data *cfqd, struct cfq_rq *crq)
 {
+	const int prio = crq->ioprio;
 	struct cfq_queue *cfqq;
 
-	cfqq = __cfq_get_queue(cfqd, current->tgid, GFP_ATOMIC);
+	cfqq = __cfq_get_queue(cfqd, cfq_hash_key(current), GFP_ATOMIC);
 	if (cfqq) {
+
+		/*
+		 * not too good...
+		 */
+		if (prio > cfqq->ioprio) {
+			printk("prio hash collision %d %d\n", 
+			       prio, cfqq->ioprio);
+			if (!list_empty(&cfqq->cfq_list)) {
+				cfqd->cid[cfqq->ioprio].busy_queues--;
+				WARN_ON(cfqd->cid[cfqq->ioprio].busy_queues<0);
+				cfqd->cid[prio].busy_queues++;
+				list_move_tail(&cfqq->cfq_list, 
+					       &cfqd->cid[prio].rr_list);
+			}
+			cfqq->ioprio = prio;
+		}
+
 		cfq_add_crq_rb(cfqd, cfqq, crq);
 
 		if (list_empty(&cfqq->cfq_list)) {
-			list_add(&cfqq->cfq_list, &cfqd->rr_list);
+			list_add_tail(&cfqq->cfq_list, 
+				      &cfqd->cid[prio].rr_list);
+			cfqd->cid[prio].busy_queues++;
 			cfqd->busy_queues++;
 		}
+
+		if (rq_mergeable(crq->request)) {
+			cfq_add_crq_hash(cfqd, crq);
+			
+			if (!q->last_merge)
+				q->last_merge = crq->request;
+		}
+
 	} else {
 		/*
 		 * should can only happen if the request wasn't allocated
@@ -528,16 +789,57 @@
 	}
 }
 
+static void cfq_reenqueue(request_queue_t *q, struct cfq_data *cfqd, int prio)
+{
+	struct list_head *prio_list = &cfqd->cid[prio].prio_list;
+	struct list_head *entry, *tmp;
+
+	list_for_each_safe(entry, tmp, prio_list) {
+		struct cfq_rq *crq = list_entry_prio(entry);
+
+		list_del_init(entry);
+		list_del_init(&crq->request->queuelist);
+		__cfq_enqueue(q, cfqd, crq);
+	}
+}
+
+static void
+cfq_enqueue(request_queue_t *q, struct cfq_data *cfqd, struct cfq_rq *crq)
+{
+	const int prio = cfq_ioprio(current);
+
+	crq->ioprio = prio;
+	crq->nr_sectors = crq->request->hard_nr_sectors;
+	__cfq_enqueue(q, cfqd, crq);
+
+	if (prio == IOPRIO_RT) {
+		int i;
+
+		/*
+		 * realtime io gets priority, move all other io back
+		 */
+		for (i = IOPRIO_IDLE; i < IOPRIO_RT; i++)
+			cfq_reenqueue(q, cfqd, i);
+	} else if (prio != IOPRIO_IDLE) {
+		/*
+		 * check if we need to move idle io back into queue
+		 */
+		cfq_reenqueue(q, cfqd, IOPRIO_IDLE);
+	}
+}
+
 static void
 cfq_insert_request(request_queue_t *q, struct request *rq, int where)
 {
 	struct cfq_data *cfqd = q->elevator.elevator_data;
-	struct cfq_rq *crq = RQ_DATA(rq);
+	struct cfq_rq *crq = RQ_ELV_DATA(rq);
 
 	switch (where) {
 		case ELEVATOR_INSERT_BACK:
+#if 0
 			while (cfq_dispatch_requests(q, cfqd))
 				;
+#endif
 			list_add_tail(&rq->queuelist, cfqd->dispatch);
 			break;
 		case ELEVATOR_INSERT_FRONT:
@@ -545,26 +847,20 @@
 			break;
 		case ELEVATOR_INSERT_SORT:
 			BUG_ON(!blk_fs_request(rq));
-			cfq_enqueue(cfqd, crq);
+			cfq_enqueue(q, cfqd, crq);
 			break;
 		default:
-			printk("%s: bad insert point %d\n", __FUNCTION__,where);
+			printk("%s: bad insert point %d\n", 
+			       __FUNCTION__,where);
 			return;
 	}
-
-	if (rq_mergeable(rq)) {
-		cfq_add_crq_hash(cfqd, crq);
-
-		if (!q->last_merge)
-			q->last_merge = rq;
-	}
 }
 
 static int cfq_queue_empty(request_queue_t *q)
 {
 	struct cfq_data *cfqd = q->elevator.elevator_data;
 
-	if (list_empty(cfqd->dispatch) && list_empty(&cfqd->rr_list))
+	if (list_empty(cfqd->dispatch) && !cfqd->busy_queues)
 		return 1;
 
 	return 0;
@@ -573,7 +869,7 @@
 static struct request *
 cfq_former_request(request_queue_t *q, struct request *rq)
 {
-	struct cfq_rq *crq = RQ_DATA(rq);
+	struct cfq_rq *crq = RQ_ELV_DATA(rq);
 	struct rb_node *rbprev = rb_prev(&crq->rb_node);
 
 	if (rbprev)
@@ -585,7 +881,7 @@
 static struct request *
 cfq_latter_request(request_queue_t *q, struct request *rq)
 {
-	struct cfq_rq *crq = RQ_DATA(rq);
+	struct cfq_rq *crq = RQ_ELV_DATA(rq);
 	struct rb_node *rbnext = rb_next(&crq->rb_node);
 
 	if (rbnext)
@@ -594,27 +890,46 @@
 	return NULL;
 }
 
+static void cfq_queue_congested(request_queue_t *q)
+{
+	struct cfq_data *cfqd = q->elevator.elevator_data;
+
+	set_bit(cfq_ioprio(current), &cfqd->rq_starved_mask);
+}
+
 static int cfq_may_queue(request_queue_t *q, int rw)
 {
 	struct cfq_data *cfqd = q->elevator.elevator_data;
 	struct cfq_queue *cfqq;
-	int ret = 1;
+	const int prio = cfq_ioprio(current);
+	int limit, ret = 1;
 
 	if (!cfqd->busy_queues)
 		goto out;
 
-	cfqq = cfq_find_cfq_hash(cfqd, current->tgid);
-	if (cfqq) {
-		int limit = (q->nr_requests - cfqd->cfq_queued) / cfqd->busy_queues;
+	cfqq = cfq_find_cfq_hash(cfqd, cfq_hash_key(current));
+	if (!cfqq)
+		goto out;
 
-		if (limit < 3)
-			limit = 3;
-		else if (limit > cfqd->max_queued)
-			limit = cfqd->max_queued;
+	cfqq = cfq_find_cfq_hash(cfqd, cfq_hash_key(current));
+	if (!cfqq)
+		goto out;
 
-		if (cfqq->queued[rw] > limit)
-			ret = 0;
-	}
+	/*
+	 * if higher or equal prio io is sleeping waiting for a request, don't
+	 * allow this one to allocate one. as long as ll_rw_blk does fifo
+	 * waitqueue wakeups this should work...
+	 */
+	if (cfqd->rq_starved_mask & ~((1 << prio) - 1))
+		goto out;
+
+	if (cfqq->queued[rw] < cfqd->cfq_queued || !cfqd->cid[prio].busy_queues)
+		goto out;
+
+	limit = q->nr_requests * (prio + 1) / IOPRIO_NR;
+	limit /= cfqd->cid[prio].busy_queues;
+	if (cfqq->queued[rw] > limit)
+		ret = 0;
 out:
 	return ret;
 }
@@ -622,13 +937,13 @@
 static void cfq_put_request(request_queue_t *q, struct request *rq)
 {
 	struct cfq_data *cfqd = q->elevator.elevator_data;
-	struct cfq_rq *crq = RQ_DATA(rq);
+	struct cfq_rq *crq = RQ_ELV_DATA(rq);
 	struct request_list *rl;
 	int other_rw;
 
 	if (crq) {
 		BUG_ON(q->last_merge == rq);
-		BUG_ON(ON_MHASH(crq));
+		BUG_ON(!hlist_unhashed(&crq->hash));
 
 		mempool_free(crq, cfqd->crq_pool);
 		rq->elevator_private = NULL;
@@ -661,17 +976,21 @@
 	/*
 	 * prepare a queue up front, so cfq_enqueue() doesn't have to
 	 */
-	cfqq = cfq_get_queue(cfqd, current->tgid, gfp_mask);
+	cfqq = cfq_get_queue(cfqd, cfq_hash_key(current), gfp_mask);
 	if (!cfqq)
 		return 1;
 
 	crq = mempool_alloc(cfqd->crq_pool, gfp_mask);
 	if (crq) {
+		/*
+		 * process now has one request
+		 */
+		clear_bit(cfq_ioprio(current), &cfqd->rq_starved_mask);
+
 		memset(crq, 0, sizeof(*crq));
-		RB_CLEAR(&crq->rb_node);
 		crq->request = rq;
-		crq->cfq_queue = NULL;
-		INIT_LIST_HEAD(&crq->hash);
+		INIT_HLIST_NODE(&crq->hash);
+		INIT_LIST_HEAD(&crq->prio_list);
 		rq->elevator_private = crq;
 		return 0;
 	}
@@ -690,6 +1009,26 @@
 	kfree(cfqd);
 }
 
+static void cfq_timer(unsigned long data)
+{
+	struct cfq_data *cfqd = (struct cfq_data *) data;
+
+	clear_bit(CFQ_WAIT_RT, &cfqd->flags);
+	clear_bit(CFQ_WAIT_NORM, &cfqd->flags);
+	kblockd_schedule_work(&cfqd->work);
+}
+
+static void cfq_work(void *data)
+{
+	request_queue_t *q = data;
+	unsigned long flags;
+
+	spin_lock_irqsave(q->queue_lock, flags);
+	if (cfq_next_request(q))
+		q->request_fn(q);
+	spin_unlock_irqrestore(q->queue_lock, flags);
+}
+
 static int cfq_init(request_queue_t *q, elevator_t *e)
 {
 	struct cfq_data *cfqd;
@@ -700,39 +1039,55 @@
 		return -ENOMEM;
 
 	memset(cfqd, 0, sizeof(*cfqd));
-	INIT_LIST_HEAD(&cfqd->rr_list);
+	init_timer(&cfqd->timer);
+	cfqd->timer.function = cfq_timer;
+	cfqd->timer.data = (unsigned long) cfqd;
 
-	cfqd->crq_hash = kmalloc(sizeof(struct list_head) * CFQ_MHASH_ENTRIES, GFP_KERNEL);
+	INIT_WORK(&cfqd->work, cfq_work, q);
+
+	for (i = 0; i < IOPRIO_NR; i++) {
+		struct io_prio_data *cid = &cfqd->cid[i];
+
+		INIT_LIST_HEAD(&cid->rr_list);
+		INIT_LIST_HEAD(&cid->prio_list);
+		cid->last_rq = -1;
+		cid->last_sectors = -1;
+	}
+
+	cfqd->crq_hash = kmalloc(sizeof(struct hlist_head) * CFQ_MHASH_ENTRIES,
+				 GFP_KERNEL);
 	if (!cfqd->crq_hash)
 		goto out_crqhash;
 
-	cfqd->cfq_hash = kmalloc(sizeof(struct list_head) * CFQ_QHASH_ENTRIES, GFP_KERNEL);
+	cfqd->cfq_hash = kmalloc(sizeof(struct hlist_head) * CFQ_QHASH_ENTRIES,
+				 GFP_KERNEL);
 	if (!cfqd->cfq_hash)
 		goto out_cfqhash;
 
-	cfqd->crq_pool = mempool_create(BLKDEV_MIN_RQ, mempool_alloc_slab, mempool_free_slab, crq_pool);
+	cfqd->crq_pool = mempool_create(BLKDEV_MIN_RQ, mempool_alloc_slab, 
+					mempool_free_slab, crq_pool);
 	if (!cfqd->crq_pool)
 		goto out_crqpool;
 
 	for (i = 0; i < CFQ_MHASH_ENTRIES; i++)
-		INIT_LIST_HEAD(&cfqd->crq_hash[i]);
+		INIT_HLIST_HEAD(&cfqd->crq_hash[i]);
 	for (i = 0; i < CFQ_QHASH_ENTRIES; i++)
-		INIT_LIST_HEAD(&cfqd->cfq_hash[i]);
+		INIT_HLIST_HEAD(&cfqd->cfq_hash[i]);
+
+	cfqd->cfq_queued = cfq_queued;
+	cfqd->cfq_quantum = cfq_quantum;
+	cfqd->cfq_quantum_io = cfq_quantum_io;
+	cfqd->cfq_idle_quantum = cfq_idle_quantum;
+	cfqd->cfq_idle_quantum_io = cfq_idle_quantum_io;
+	cfqd->cfq_grace_rt = cfq_grace_rt;
+	cfqd->cfq_grace_idle = cfq_grace_idle;
+
+	q->nr_requests <<= 2;
 
 	cfqd->dispatch = &q->queue_head;
 	e->elevator_data = cfqd;
 	cfqd->queue = q;
 
-	/*
-	 * just set it to some high value, we want anyone to be able to queue
-	 * some requests. fairness is handled differently
-	 */
-	cfqd->max_queued = q->nr_requests;
-	q->nr_requests = 8192;
-
-	cfqd->cfq_queued = cfq_queued;
-	cfqd->cfq_quantum = cfq_quantum;
-
 	return 0;
 out_crqpool:
 	kfree(cfqd->cfq_hash);
@@ -797,7 +1152,12 @@
 	return cfq_var_show(__VAR, (page));				\
 }
 SHOW_FUNCTION(cfq_quantum_show, cfqd->cfq_quantum);
+SHOW_FUNCTION(cfq_quantum_io_show, cfqd->cfq_quantum_io);
+SHOW_FUNCTION(cfq_idle_quantum_show, cfqd->cfq_idle_quantum);
+SHOW_FUNCTION(cfq_idle_quantum_io_show, cfqd->cfq_idle_quantum_io);
 SHOW_FUNCTION(cfq_queued_show, cfqd->cfq_queued);
+SHOW_FUNCTION(cfq_grace_rt_show, cfqd->cfq_grace_rt);
+SHOW_FUNCTION(cfq_grace_idle_show, cfqd->cfq_grace_idle);
 #undef SHOW_FUNCTION
 
 #define STORE_FUNCTION(__FUNC, __PTR, MIN, MAX)				\
@@ -811,7 +1171,12 @@
 	return ret;							\
 }
 STORE_FUNCTION(cfq_quantum_store, &cfqd->cfq_quantum, 1, INT_MAX);
+STORE_FUNCTION(cfq_quantum_io_store, &cfqd->cfq_quantum_io, 4, INT_MAX);
+STORE_FUNCTION(cfq_idle_quantum_store, &cfqd->cfq_idle_quantum, 1, INT_MAX);
+STORE_FUNCTION(cfq_idle_quantum_io_store, &cfqd->cfq_idle_quantum_io, 4, INT_MAX);
 STORE_FUNCTION(cfq_queued_store, &cfqd->cfq_queued, 1, INT_MAX);
+STORE_FUNCTION(cfq_grace_rt_store, &cfqd->cfq_grace_rt, 0, INT_MAX);
+STORE_FUNCTION(cfq_grace_idle_store, &cfqd->cfq_grace_idle, 0, INT_MAX);
 #undef STORE_FUNCTION
 
 static struct cfq_fs_entry cfq_quantum_entry = {
@@ -819,15 +1184,45 @@
 	.show = cfq_quantum_show,
 	.store = cfq_quantum_store,
 };
+static struct cfq_fs_entry cfq_quantum_io_entry = {
+	.attr = {.name = "quantum_io", .mode = S_IRUGO | S_IWUSR },
+	.show = cfq_quantum_io_show,
+	.store = cfq_quantum_io_store,
+};
+static struct cfq_fs_entry cfq_idle_quantum_entry = {
+	.attr = {.name = "idle_quantum", .mode = S_IRUGO | S_IWUSR },
+	.show = cfq_idle_quantum_show,
+	.store = cfq_idle_quantum_store,
+};
+static struct cfq_fs_entry cfq_idle_quantum_io_entry = {
+	.attr = {.name = "idle_quantum_io", .mode = S_IRUGO | S_IWUSR },
+	.show = cfq_idle_quantum_io_show,
+	.store = cfq_idle_quantum_io_store,
+};
 static struct cfq_fs_entry cfq_queued_entry = {
 	.attr = {.name = "queued", .mode = S_IRUGO | S_IWUSR },
 	.show = cfq_queued_show,
 	.store = cfq_queued_store,
 };
+static struct cfq_fs_entry cfq_grace_rt_entry = {
+	.attr = {.name = "grace_rt", .mode = S_IRUGO | S_IWUSR },
+	.show = cfq_grace_rt_show,
+	.store = cfq_grace_rt_store,
+};
+static struct cfq_fs_entry cfq_grace_idle_entry = {
+	.attr = {.name = "grace_idle", .mode = S_IRUGO | S_IWUSR },
+	.show = cfq_grace_idle_show,
+	.store = cfq_grace_idle_store,
+};
 
 static struct attribute *default_attrs[] = {
 	&cfq_quantum_entry.attr,
+	&cfq_quantum_io_entry.attr,
+	&cfq_idle_quantum_entry.attr,
+	&cfq_idle_quantum_io_entry.attr,
 	&cfq_queued_entry.attr,
+	&cfq_grace_rt_entry.attr,
+	&cfq_grace_idle_entry.attr,
 	NULL,
 };
 
@@ -883,6 +1278,7 @@
 	.elevator_set_req_fn =		cfq_set_request,
 	.elevator_put_req_fn =		cfq_put_request,
 	.elevator_may_queue_fn =	cfq_may_queue,
+	.elevator_set_congested_fn =	cfq_queue_congested,
 	.elevator_init_fn =		cfq_init,
 	.elevator_exit_fn =		cfq_exit,
 };
diff -Nru a/drivers/block/elevator.c b/drivers/block/elevator.c
--- a/drivers/block/elevator.c	Fri Sep 24 18:58:47 2004
+++ b/drivers/block/elevator.c	Fri Sep 24 18:58:47 2004
@@ -339,6 +339,14 @@
 		e->elevator_put_req_fn(q, rq);
 }
 
+void elv_set_congested(request_queue_t *q)
+{
+	elevator_t *e = &q->elevator;
+
+	if (e->elevator_set_congested_fn)
+		e->elevator_set_congested_fn(q);
+}
+
 int elv_may_queue(request_queue_t *q, int rw)
 {
 	elevator_t *e = &q->elevator;
@@ -346,7 +354,7 @@
 	if (e->elevator_may_queue_fn)
 		return e->elevator_may_queue_fn(q, rw);
 
-	return 0;
+	return 1;
 }
 
 void elv_completed_request(request_queue_t *q, struct request *rq)
diff -Nru a/drivers/block/ll_rw_blk.c b/drivers/block/ll_rw_blk.c
--- a/drivers/block/ll_rw_blk.c	Fri Sep 24 18:58:47 2004
+++ b/drivers/block/ll_rw_blk.c	Fri Sep 24 18:58:47 2004
@@ -1594,6 +1594,10 @@
 	struct io_context *ioc = get_io_context(gfp_mask);
 
 	spin_lock_irq(q->queue_lock);
+
+	if (!elv_may_queue(q, rw))
+		goto out_lock;
+
 	if (rl->count[rw]+1 >= q->nr_requests) {
 		/*
 		 * The queue will fill after this allocation, so set it as
@@ -1607,15 +1611,12 @@
 		}
 	}
 
-	if (blk_queue_full(q, rw)
-			&& !ioc_batching(ioc) && !elv_may_queue(q, rw)) {
-		/*
-		 * The queue is full and the allocating process is not a
-		 * "batcher", and not exempted by the IO scheduler
-		 */
-		spin_unlock_irq(q->queue_lock);
-		goto out;
-	}
+	/*
+	 * The queue is full and the allocating process is not a
+	 * "batcher", and not exempted by the IO scheduler
+	 */
+	if (blk_queue_full(q, rw) && !ioc_batching(ioc))
+		goto out_lock;
 
 	rl->count[rw]++;
 	if (rl->count[rw] >= queue_congestion_on_threshold(q))
@@ -1633,8 +1634,7 @@
 		 */
 		spin_lock_irq(q->queue_lock);
 		freed_request(q, rw);
-		spin_unlock_irq(q->queue_lock);
-		goto out;
+		goto out_lock;
 	}
 
 	if (ioc_batching(ioc))
@@ -1664,6 +1664,11 @@
 out:
 	put_io_context(ioc);
 	return rq;
+out_lock:
+	if (!rq)
+		elv_set_congested(q);
+	spin_unlock_irq(q->queue_lock);
+	goto out;
 }
 
 /*
@@ -3167,3 +3172,21 @@
 		kobject_put(&disk->kobj);
 	}
 }
+
+asmlinkage int sys_ioprio_set(int ioprio)
+{
+	if (ioprio < IOPRIO_IDLE || ioprio > IOPRIO_RT)
+		return -EINVAL;
+	if (ioprio == IOPRIO_RT && !capable(CAP_SYS_ADMIN))
+		return -EACCES;
+
+	printk("%s: set ioprio %d\n", current->comm, ioprio);
+	current->ioprio = ioprio;
+	return 0;
+}
+
+asmlinkage int sys_ioprio_get(void)
+{
+	return current->ioprio;
+}
+
diff -Nru a/include/asm-i386/unistd.h b/include/asm-i386/unistd.h
--- a/include/asm-i386/unistd.h	Fri Sep 24 18:58:47 2004
+++ b/include/asm-i386/unistd.h	Fri Sep 24 18:58:47 2004
@@ -289,8 +289,10 @@
 #define __NR_mq_notify		(__NR_mq_open+4)
 #define __NR_mq_getsetattr	(__NR_mq_open+5)
 #define __NR_sys_kexec_load	283
+#define __NR_ioprio_set		284
+#define __NR_ioprio_get		285
 
-#define NR_syscalls 284
+#define NR_syscalls 286
 
 /* user-visible error numbers are in the range -1 - -124: see <asm-i386/errno.h> */
 
diff -Nru a/include/asm-ppc/unistd.h b/include/asm-ppc/unistd.h
--- a/include/asm-ppc/unistd.h	Fri Sep 24 18:58:47 2004
+++ b/include/asm-ppc/unistd.h	Fri Sep 24 18:58:47 2004
@@ -273,8 +273,10 @@
 #define __NR_mq_notify		266
 #define __NR_mq_getsetattr	267
 #define __NR_kexec_load		268
+#define __NR_ioprio_set		269
+#define __NR_ioprio_get		270
 
-#define __NR_syscalls		269
+#define __NR_syscalls		271
 
 #define __NR(n)	#n
 
diff -Nru a/include/asm-x86_64/unistd.h b/include/asm-x86_64/unistd.h
--- a/include/asm-x86_64/unistd.h	Fri Sep 24 18:58:47 2004
+++ b/include/asm-x86_64/unistd.h	Fri Sep 24 18:58:47 2004
@@ -554,8 +554,12 @@
 __SYSCALL(__NR_mq_getsetattr, sys_mq_getsetattr)
 #define __NR_kexec_load 	246
 __SYSCALL(__NR_kexec_load, sys_ni_syscall)
+#define __NR_ioprio_set		247
+__SYSCALL(__NR_ioprio_set, sys_ioprio_set);
+#define __NR_ioprio_get		248
+__SYSCALL(__NR_ioprio_get, sys_ioprio_get);
 
-#define __NR_syscall_max __NR_kexec_load
+#define __NR_syscall_max __NR_ioprio_get
 #ifndef __NO_STUBS
 
 /* user-visible error numbers are in the range -1 - -4095 */
diff -Nru a/include/linux/elevator.h b/include/linux/elevator.h
--- a/include/linux/elevator.h	Fri Sep 24 18:58:47 2004
+++ b/include/linux/elevator.h	Fri Sep 24 18:58:47 2004
@@ -17,6 +17,7 @@
 typedef struct request *(elevator_request_list_fn) (request_queue_t *, struct request *);
 typedef void (elevator_completed_req_fn) (request_queue_t *, struct request *);
 typedef int (elevator_may_queue_fn) (request_queue_t *, int);
+typedef void (elevator_set_congested_fn) (request_queue_t *);
 
 typedef int (elevator_set_req_fn) (request_queue_t *, struct request *, int);
 typedef void (elevator_put_req_fn) (request_queue_t *, struct request *);
@@ -45,6 +46,7 @@
 	elevator_put_req_fn *elevator_put_req_fn;
 
 	elevator_may_queue_fn *elevator_may_queue_fn;
+	elevator_set_congested_fn *elevator_set_congested_fn;
 
 	elevator_init_fn *elevator_init_fn;
 	elevator_exit_fn *elevator_exit_fn;
@@ -74,6 +76,7 @@
 extern int elv_register_queue(request_queue_t *q);
 extern void elv_unregister_queue(request_queue_t *q);
 extern int elv_may_queue(request_queue_t *, int);
+extern void elv_set_congested(request_queue_t *);
 extern void elv_completed_request(request_queue_t *, struct request *);
 extern int elv_set_request(request_queue_t *, struct request *, int);
 extern void elv_put_request(request_queue_t *, struct request *);
@@ -118,5 +121,7 @@
 #define ELEVATOR_INSERT_FRONT	1
 #define ELEVATOR_INSERT_BACK	2
 #define ELEVATOR_INSERT_SORT	3
+
+#define RQ_ELV_DATA(rq)		(rq)->elevator_private
 
 #endif
diff -Nru a/include/linux/fs.h b/include/linux/fs.h
--- a/include/linux/fs.h	Fri Sep 24 18:58:47 2004
+++ b/include/linux/fs.h	Fri Sep 24 18:58:47 2004
@@ -1570,5 +1570,17 @@
 { }
 #endif	/* CONFIG_SECURITY */
 
+/* io priorities */
+
+#define IOPRIO_NR      21
+
+#define IOPRIO_IDLE	0
+#define IOPRIO_NORM	10
+#define IOPRIO_RT	20
+
+asmlinkage int sys_ioprio_set(int ioprio);
+asmlinkage int sys_ioprio_get(void);
+
+
 #endif /* __KERNEL__ */
 #endif /* _LINUX_FS_H */
diff -Nru a/include/linux/init_task.h b/include/linux/init_task.h
--- a/include/linux/init_task.h	Fri Sep 24 18:58:47 2004
+++ b/include/linux/init_task.h	Fri Sep 24 18:58:47 2004
@@ -112,6 +112,7 @@
 	.proc_lock	= SPIN_LOCK_UNLOCKED,				\
 	.switch_lock	= SPIN_LOCK_UNLOCKED,				\
 	.journal_info	= NULL,						\
+	.ioprio		= IOPRIO_NORM,					\
 }
 
 
diff -Nru a/include/linux/sched.h b/include/linux/sched.h
--- a/include/linux/sched.h	Fri Sep 24 18:58:47 2004
+++ b/include/linux/sched.h	Fri Sep 24 18:58:47 2004
@@ -520,6 +520,8 @@
 
 	struct io_context *io_context;
 
+	int ioprio;
+
 	unsigned long ptrace_message;
 	siginfo_t *last_siginfo; /* For ptrace use.  */
 
diff -Nru a/kernel/fork.c b/kernel/fork.c
--- a/kernel/fork.c	Fri Sep 24 18:58:47 2004
+++ b/kernel/fork.c	Fri Sep 24 18:58:47 2004
@@ -1092,6 +1092,7 @@
 	} else
 		link_pid(p, p->pids + PIDTYPE_TGID, &p->group_leader->pids[PIDTYPE_TGID].pid);
 
+	p->ioprio = current->ioprio;
 	nr_threads++;
 	write_unlock_irq(&tasklist_lock);
 	retval = 0;

--------------010109090905000309030502--
