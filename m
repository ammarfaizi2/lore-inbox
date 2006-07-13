Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932515AbWGMMqI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932515AbWGMMqI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 08:46:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932458AbWGMMoH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 08:44:07 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:26159 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751494AbWGMMoC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 08:44:02 -0400
From: Jens Axboe <axboe@suse.de>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@suse.de>
Subject: [PATCH] 3/15 elevator: abstract out the rbtree sort handling
Date: Thu, 13 Jul 2006 14:46:26 +0200
Message-Id: <1152794798226-git-send-email-axboe@suse.de>
X-Mailer: git-send-email 1.4.1.ged0e0
In-Reply-To: <11527947982769-git-send-email-axboe@suse.de>
References: <11527947982769-git-send-email-axboe@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The rbtree sort/lookup/reposition logic is mostly duplicated in
cfq/deadline/as, so move it to the elevator core. The io schedulers
still provide the actual rb root, as we don't want to impose any sort
of specific handling on the schedulers.

Introduce the helpers and rb_node in struct request to help migrate the
IO schedulers.

Signed-off-by: Jens Axboe <axboe@suse.de>
---
 block/elevator.c         |  123 +++++++++++++++++++++++++++++++++++++++++-----
 block/ll_rw_blk.c        |    7 +--
 include/linux/blkdev.h   |    1 
 include/linux/elevator.h |   18 ++++++-
 4 files changed, 130 insertions(+), 19 deletions(-)

diff --git a/block/elevator.c b/block/elevator.c
index 3e40530..9cd2805 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -239,6 +239,8 @@ int elevator_init(request_queue_t *q, ch
 	return ret;
 }
 
+EXPORT_SYMBOL(elevator_init);
+
 void elevator_exit(elevator_t *e)
 {
 	mutex_lock(&e->sysfs_lock);
@@ -250,6 +252,8 @@ void elevator_exit(elevator_t *e)
 	kobject_put(&e->kobj);
 }
 
+EXPORT_SYMBOL(elevator_exit);
+
 static inline void __elv_rqhash_del(struct request *rq)
 {
 	hlist_del_init(&rq->hash);
@@ -298,9 +302,68 @@ static struct request *elv_rqhash_find(r
 }
 
 /*
+ * RB-tree support functions for inserting/lookup/removal of requests
+ * in a sorted RB tree.
+ */
+struct request *elv_rb_add(struct rb_root *root, struct request *rq)
+{
+	struct rb_node **p = &root->rb_node;
+	struct rb_node *parent = NULL;
+	struct request *__rq;
+
+	while (*p) {
+		parent = *p;
+		__rq = rb_entry(parent, struct request, rb_node);
+
+		if (rq->sector < __rq->sector)
+			p = &(*p)->rb_left;
+		else if (rq->sector > __rq->sector)
+			p = &(*p)->rb_right;
+		else
+			return __rq;
+	}
+
+	rb_link_node(&rq->rb_node, parent, p);
+	rb_insert_color(&rq->rb_node, root);
+	return NULL;
+}
+
+EXPORT_SYMBOL(elv_rb_add);
+
+void elv_rb_del(struct rb_root *root, struct request *rq)
+{
+	BUG_ON(RB_EMPTY_NODE(&rq->rb_node));
+	rb_erase(&rq->rb_node, root);
+	RB_CLEAR_NODE(&rq->rb_node);
+}
+
+EXPORT_SYMBOL(elv_rb_del);
+
+struct request *elv_rb_find(struct rb_root *root, sector_t sector)
+{
+	struct rb_node *n = root->rb_node;
+	struct request *rq;
+
+	while (n) {
+		rq = rb_entry(n, struct request, rb_node);
+
+		if (sector < rq->sector)
+			n = n->rb_left;
+		else if (sector > rq->sector)
+			n = n->rb_right;
+		else
+			return rq;
+	}
+
+	return NULL;
+}
+
+EXPORT_SYMBOL(elv_rb_find);
+
+/*
  * Insert rq into dispatch queue of q.  Queue lock must be held on
- * entry.  If sort != 0, rq is sort-inserted; otherwise, rq will be
- * appended to the dispatch queue.  To be used by specific elevators.
+ * entry.  rq is sort insted into the dispatch queue. To be used by
+ * specific elevators.
  */
 void elv_dispatch_sort(request_queue_t *q, struct request *rq)
 {
@@ -335,8 +398,12 @@ void elv_dispatch_sort(request_queue_t *
 	list_add(&rq->queuelist, entry);
 }
 
+EXPORT_SYMBOL(elv_dispatch_sort);
+
 /*
- * This should be in elevator.h, but that requires pulling in rq and q
+ * Insert rq into dispatch queue of q.  Queue lock must be held on
+ * entry.  rq is added to the back of the dispatch queue. To be used by
+ * specific elevators.
  */
 void elv_dispatch_add_tail(struct request_queue *q, struct request *rq)
 {
@@ -352,6 +419,8 @@ void elv_dispatch_add_tail(struct reques
 	list_add_tail(&rq->queuelist, &q->queue_head);
 }
 
+EXPORT_SYMBOL(elv_dispatch_add_tail);
+
 int elv_merge(request_queue_t *q, struct request **req, struct bio *bio)
 {
 	elevator_t *e = q->elevator;
@@ -384,14 +453,15 @@ int elv_merge(request_queue_t *q, struct
 	return ELEVATOR_NO_MERGE;
 }
 
-void elv_merged_request(request_queue_t *q, struct request *rq)
+void elv_merged_request(request_queue_t *q, struct request *rq, int type)
 {
 	elevator_t *e = q->elevator;
 
 	if (e->ops->elevator_merged_fn)
-		e->ops->elevator_merged_fn(q, rq);
+		e->ops->elevator_merged_fn(q, rq, type);
 
-	elv_rqhash_reposition(q, rq);
+	if (type == ELEVATOR_BACK_MERGE)
+		elv_rqhash_reposition(q, rq);
 
 	q->last_merge = rq;
 }
@@ -577,6 +647,8 @@ void __elv_add_request(request_queue_t *
 	elv_insert(q, rq, where);
 }
 
+EXPORT_SYMBOL(__elv_add_request);
+
 void elv_add_request(request_queue_t *q, struct request *rq, int where,
 		     int plug)
 {
@@ -587,6 +659,8 @@ void elv_add_request(request_queue_t *q,
 	spin_unlock_irqrestore(q->queue_lock, flags);
 }
 
+EXPORT_SYMBOL(elv_add_request);
+
 static inline struct request *__elv_next_request(request_queue_t *q)
 {
 	struct request *rq;
@@ -670,6 +744,8 @@ struct request *elv_next_request(request
 	return rq;
 }
 
+EXPORT_SYMBOL(elv_next_request);
+
 void elv_dequeue_request(request_queue_t *q, struct request *rq)
 {
 	BUG_ON(list_empty(&rq->queuelist));
@@ -686,6 +762,8 @@ void elv_dequeue_request(request_queue_t
 		q->in_flight++;
 }
 
+EXPORT_SYMBOL(elv_dequeue_request);
+
 int elv_queue_empty(request_queue_t *q)
 {
 	elevator_t *e = q->elevator;
@@ -699,6 +777,8 @@ int elv_queue_empty(request_queue_t *q)
 	return 1;
 }
 
+EXPORT_SYMBOL(elv_queue_empty);
+
 struct request *elv_latter_request(request_queue_t *q, struct request *rq)
 {
 	elevator_t *e = q->elevator;
@@ -1024,11 +1104,26 @@ ssize_t elv_iosched_show(request_queue_t
 	return len;
 }
 
-EXPORT_SYMBOL(elv_dispatch_sort);
-EXPORT_SYMBOL(elv_add_request);
-EXPORT_SYMBOL(__elv_add_request);
-EXPORT_SYMBOL(elv_next_request);
-EXPORT_SYMBOL(elv_dequeue_request);
-EXPORT_SYMBOL(elv_queue_empty);
-EXPORT_SYMBOL(elevator_exit);
-EXPORT_SYMBOL(elevator_init);
+struct request *elv_rb_former_request(request_queue_t *q, struct request *rq)
+{
+	struct rb_node *rbprev = rb_prev(&rq->rb_node);
+
+	if (rbprev)
+		return rb_entry_rq(rbprev);
+
+	return NULL;
+}
+
+EXPORT_SYMBOL(elv_rb_former_request);
+
+struct request *elv_rb_latter_request(request_queue_t *q, struct request *rq)
+{
+	struct rb_node *rbnext = rb_next(&rq->rb_node);
+
+	if (rbnext)
+		return rb_entry_rq(rbnext);
+
+	return NULL;
+}
+
+EXPORT_SYMBOL(elv_rb_latter_request);
diff --git a/block/ll_rw_blk.c b/block/ll_rw_blk.c
index 84c7b1c..08c1615 100644
--- a/block/ll_rw_blk.c
+++ b/block/ll_rw_blk.c
@@ -281,11 +281,12 @@ static inline void rq_init(request_queue
 {
 	INIT_LIST_HEAD(&rq->queuelist);
 	INIT_LIST_HEAD(&rq->donelist);
-	INIT_HLIST_NODE(&rq->hash);
 
 	rq->errors = 0;
 	rq->rq_status = RQ_ACTIVE;
 	rq->bio = rq->biotail = NULL;
+	INIT_HLIST_NODE(&rq->hash);
+	RB_CLEAR_NODE(&rq->rb_node);
 	rq->ioprio = 0;
 	rq->buffer = NULL;
 	rq->ref_count = 1;
@@ -2896,7 +2897,7 @@ static int __make_request(request_queue_
 			req->ioprio = ioprio_best(req->ioprio, prio);
 			drive_stat_acct(req, nr_sectors, 0);
 			if (!attempt_back_merge(q, req))
-				elv_merged_request(q, req);
+				elv_merged_request(q, req, el_ret);
 			goto out;
 
 		case ELEVATOR_FRONT_MERGE:
@@ -2923,7 +2924,7 @@ static int __make_request(request_queue_
 			req->ioprio = ioprio_best(req->ioprio, prio);
 			drive_stat_acct(req, nr_sectors, 0);
 			if (!attempt_front_merge(q, req))
-				elv_merged_request(q, req);
+				elv_merged_request(q, req, el_ret);
 			goto out;
 
 		/* ELV_NO_MERGE: elevator says don't/can't merge. */
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 9b23cbe..e296719 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -149,6 +149,7 @@ struct request {
 	struct bio *biotail;
 
 	struct hlist_node hash;	/* merge hash */
+	struct rb_node rb_node;	/* sort/lookup */
 
 	void *elevator_private;
 	void *completion_data;
diff --git a/include/linux/elevator.h b/include/linux/elevator.h
index 2c270e9..95b2a04 100644
--- a/include/linux/elevator.h
+++ b/include/linux/elevator.h
@@ -6,7 +6,7 @@ typedef int (elevator_merge_fn) (request
 
 typedef void (elevator_merge_req_fn) (request_queue_t *, struct request *, struct request *);
 
-typedef void (elevator_merged_fn) (request_queue_t *, struct request *);
+typedef void (elevator_merged_fn) (request_queue_t *, struct request *, int);
 
 typedef int (elevator_dispatch_fn) (request_queue_t *, int);
 
@@ -96,7 +96,7 @@ extern void elv_insert(request_queue_t *
 extern int elv_merge(request_queue_t *, struct request **, struct bio *);
 extern void elv_merge_requests(request_queue_t *, struct request *,
 			       struct request *);
-extern void elv_merged_request(request_queue_t *, struct request *);
+extern void elv_merged_request(request_queue_t *, struct request *, int);
 extern void elv_dequeue_request(request_queue_t *, struct request *);
 extern void elv_requeue_request(request_queue_t *, struct request *);
 extern int elv_queue_empty(request_queue_t *);
@@ -127,6 +127,19 @@ extern void elevator_exit(elevator_t *);
 extern int elv_rq_merge_ok(struct request *, struct bio *);
 
 /*
+ * Helper functions.
+ */
+extern struct request *elv_rb_former_request(request_queue_t *, struct request *);
+extern struct request *elv_rb_latter_request(request_queue_t *, struct request *);
+
+/*
+ * rb support functions.
+ */
+extern struct request *elv_rb_add(struct rb_root *, struct request *);
+extern void elv_rb_del(struct rb_root *, struct request *);
+extern struct request *elv_rb_find(struct rb_root *, sector_t);
+
+/*
  * Return values from elevator merger
  */
 #define ELEVATOR_NO_MERGE	0
@@ -151,5 +164,6 @@ enum {
 };
 
 #define rq_end_sector(rq)	((rq)->sector + (rq)->nr_sectors)
+#define rb_entry_rq(node)	rb_entry((node), struct request, rb_node)
 
 #endif
-- 
1.4.1.ged0e0

