Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261903AbTIBNXa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 09:23:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262273AbTIBNXa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 09:23:30 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:63623 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261903AbTIBNWZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 09:22:25 -0400
Date: Tue, 2 Sep 2003 15:21:57 +0200
From: Jens Axboe <axboe@suse.de>
To: Bongani Hlope <bonganilinux@mweb.co.za>
Cc: linux-kernel@vger.kernel.org
Subject: Re: CFQ scheduler leaves task in D state
Message-ID: <20030902132157.GG872@suse.de>
References: <E19tufw-0008QV-00@laibach.mweb.co.za> <20030902054824.GK30058@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030902054824.GK30058@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 02 2003, Jens Axboe wrote:
> On Mon, Sep 01 2003, Bongani Hlope wrote:
> > Hi
> > 
> > I tried the CFQ scheduler patch you posted on top of 2.6.0-test4-mm3-1, 
> > including the O19int patch from Con Kolivas and I got the attached stacktrace.
> 
> Thanks Bongani, I reproduced this problem yesterday. I'll post an update
> later today. There appears to be a missing last_merge clear somewhere,
> odd.

This should be better, delete the one I sent an hour ago.

===== drivers/block/cfq-iosched.c 1.1 vs edited =====
--- 1.1/drivers/block/cfq-iosched.c	Fri Aug 29 10:12:50 2003
+++ edited/drivers/block/cfq-iosched.c	Tue Sep  2 15:20:05 2003
@@ -149,15 +149,17 @@
 /*
  * rb tree support functions
  */
-#define RB_EMPTY(root)	((root)->rb_node == NULL)
-#define RB_CLEAR(root)	((root)->rb_node = NULL)
-#define ON_RB(crq)	((crq)->cfq_queue != NULL)
+#define RB_NONE		(2)
+#define RB_EMPTY(node)	((node)->rb_node == NULL)
+#define RB_CLEAR(node)	((node)->rb_color = RB_NONE)
+#define RB_CLEAR_ROOT(root)	((root)->rb_node = NULL)
+#define ON_RB(node)	((node)->rb_color != RB_NONE)
 #define rb_entry_crq(node)	rb_entry((node), struct cfq_rq, rb_node)
 #define rq_rb_key(rq)		(rq)->sector
 
 static inline void cfq_del_crq_rb(struct cfq_queue *cfqq, struct cfq_rq *crq)
 {
-	if (ON_RB(crq)) {
+	if (ON_RB(&crq->rb_node)) {
 		cfqq->queued[rq_data_dir(crq->request)]--;
 		rb_erase(&crq->rb_node, &cfqq->sort_list);
 		crq->cfq_queue = NULL;
@@ -194,13 +196,12 @@
 	struct cfq_rq *__alias;
 
 	crq->rb_key = rq_rb_key(rq);
-
+	cfqq->queued[rq_data_dir(rq)]++;
 retry:
 	__alias = __cfq_add_crq_rb(cfqq, crq);
 	if (!__alias) {
 		rb_insert_color(&crq->rb_node, &cfqq->sort_list);
 		crq->cfq_queue = cfqq;
-		cfqq->queued[rq_data_dir(rq)]++;
 		return;
 	}
 
@@ -301,7 +302,7 @@
 	cfq_del_crq_hash(crq);
 	cfq_add_crq_hash(cfqd, crq);
 
-	if (ON_RB(crq) && rq_rb_key(req) != crq->rb_key) {
+	if (ON_RB(&crq->rb_node) && (rq_rb_key(req) != crq->rb_key)) {
 		struct cfq_queue *cfqq = crq->cfq_queue;
 
 		cfq_del_crq_rb(cfqq, crq);
@@ -345,17 +346,17 @@
 }
 
 static inline void
-__cfq_dispatch_requests(struct cfq_data *cfqd, struct cfq_queue *cfqq)
+__cfq_dispatch_requests(request_queue_t *q, struct cfq_data *cfqd,
+			struct cfq_queue *cfqq)
 {
-	struct cfq_rq *crq;
-
-	crq = rb_entry_crq(rb_first(&cfqq->sort_list));
+	struct cfq_rq *crq = rb_entry_crq(rb_first(&cfqq->sort_list));
 
 	cfq_del_crq_rb(cfqq, crq);
+	cfq_remove_merge_hints(q, crq);
 	cfq_dispatch_sort(cfqd->dispatch, crq);
 }
 
-static int cfq_dispatch_requests(struct cfq_data *cfqd)
+static int cfq_dispatch_requests(request_queue_t *q, struct cfq_data *cfqd)
 {
 	struct cfq_queue *cfqq;
 	struct list_head *entry, *tmp;
@@ -372,7 +373,7 @@
 
 		BUG_ON(RB_EMPTY(&cfqq->sort_list));
 
-		__cfq_dispatch_requests(cfqd, cfqq);
+		__cfq_dispatch_requests(q, cfqd, cfqq);
 
 		if (RB_EMPTY(&cfqq->sort_list))
 			cfq_put_queue(cfqd, cfqq);
@@ -399,17 +400,15 @@
 dispatch:
 		rq = list_entry_rq(cfqd->dispatch->next);
 
-		if (q->last_merge == &rq->queuelist)
-			q->last_merge = NULL;
-
+		BUG_ON(q->last_merge == &rq->queuelist);
 		crq = RQ_DATA(rq);
 		if (crq)
-			cfq_del_crq_hash(crq);
+			BUG_ON(ON_MHASH(crq));
 
 		return rq;
 	}
 
-	if (cfq_dispatch_requests(cfqd))
+	if (cfq_dispatch_requests(q, cfqd))
 		goto dispatch;
 
 	return NULL;
@@ -456,7 +455,7 @@
 
 		INIT_LIST_HEAD(&cfqq->cfq_hash);
 		INIT_LIST_HEAD(&cfqq->cfq_list);
-		RB_CLEAR(&cfqq->sort_list);
+		RB_CLEAR_ROOT(&cfqq->sort_list);
 
 		cfqq->pid = pid;
 		cfqq->queued[0] = cfqq->queued[1] = 0;
@@ -552,10 +551,9 @@
 	if (!cfqq)
 		goto out;
 
-	if (cfqq->queued[rw] < cfq_queued)
-		goto out;
-
 	limit = (q->nr_requests - cfq_queued) / cfqd->busy_queues;
+	if (limit < 3)
+		limit = 3;
 	if (cfqq->queued[rw] > limit)
 		ret = 0;
 
@@ -583,6 +581,7 @@
 	struct cfq_rq *crq = mempool_alloc(cfqd->crq_pool, gfp_mask);
 
 	if (crq) {
+		RB_CLEAR(&crq->rb_node);
 		crq->request = rq;
 		crq->cfq_queue = NULL;
 		INIT_LIST_HEAD(&crq->hash);

-- 
Jens Axboe

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
On Tue, Sep 02 2003, Jens Axboe wrote:
> On Mon, Sep 01 2003, Bongani Hlope wrote:
> > Hi
> > 
> > I tried the CFQ scheduler patch you posted on top of 2.6.0-test4-mm3-1, 
> > including the O19int patch from Con Kolivas and I got the attached stacktrace.
> 
> Thanks Bongani, I reproduced this problem yesterday. I'll post an update
> later today. There appears to be a missing last_merge clear somewhere,
> odd.

This should be better, delete the one I sent an hour ago.

===== drivers/block/cfq-iosched.c 1.1 vs edited =====
--- 1.1/drivers/block/cfq-iosched.c	Fri Aug 29 10:12:50 2003
+++ edited/drivers/block/cfq-iosched.c	Tue Sep  2 15:20:05 2003
@@ -149,15 +149,17 @@
 /*
  * rb tree support functions
  */
-#define RB_EMPTY(root)	((root)->rb_node == NULL)
-#define RB_CLEAR(root)	((root)->rb_node = NULL)
-#define ON_RB(crq)	((crq)->cfq_queue != NULL)
+#define RB_NONE		(2)
+#define RB_EMPTY(node)	((node)->rb_node == NULL)
+#define RB_CLEAR(node)	((node)->rb_color = RB_NONE)
+#define RB_CLEAR_ROOT(root)	((root)->rb_node = NULL)
+#define ON_RB(node)	((node)->rb_color != RB_NONE)
 #define rb_entry_crq(node)	rb_entry((node), struct cfq_rq, rb_node)
 #define rq_rb_key(rq)		(rq)->sector
 
 static inline void cfq_del_crq_rb(struct cfq_queue *cfqq, struct cfq_rq *crq)
 {
-	if (ON_RB(crq)) {
+	if (ON_RB(&crq->rb_node)) {
 		cfqq->queued[rq_data_dir(crq->request)]--;
 		rb_erase(&crq->rb_node, &cfqq->sort_list);
 		crq->cfq_queue = NULL;
@@ -194,13 +196,12 @@
 	struct cfq_rq *__alias;
 
 	crq->rb_key = rq_rb_key(rq);
-
+	cfqq->queued[rq_data_dir(rq)]++;
 retry:
 	__alias = __cfq_add_crq_rb(cfqq, crq);
 	if (!__alias) {
 		rb_insert_color(&crq->rb_node, &cfqq->sort_list);
 		crq->cfq_queue = cfqq;
-		cfqq->queued[rq_data_dir(rq)]++;
 		return;
 	}
 
@@ -301,7 +302,7 @@
 	cfq_del_crq_hash(crq);
 	cfq_add_crq_hash(cfqd, crq);
 
-	if (ON_RB(crq) && rq_rb_key(req) != crq->rb_key) {
+	if (ON_RB(&crq->rb_node) && (rq_rb_key(req) != crq->rb_key)) {
 		struct cfq_queue *cfqq = crq->cfq_queue;
 
 		cfq_del_crq_rb(cfqq, crq);
@@ -345,17 +346,17 @@
 }
 
 static inline void
-__cfq_dispatch_requests(struct cfq_data *cfqd, struct cfq_queue *cfqq)
+__cfq_dispatch_requests(request_queue_t *q, struct cfq_data *cfqd,
+			struct cfq_queue *cfqq)
 {
-	struct cfq_rq *crq;
-
-	crq = rb_entry_crq(rb_first(&cfqq->sort_list));
+	struct cfq_rq *crq = rb_entry_crq(rb_first(&cfqq->sort_list));
 
 	cfq_del_crq_rb(cfqq, crq);
+	cfq_remove_merge_hints(q, crq);
 	cfq_dispatch_sort(cfqd->dispatch, crq);
 }
 
-static int cfq_dispatch_requests(struct cfq_data *cfqd)
+static int cfq_dispatch_requests(request_queue_t *q, struct cfq_data *cfqd)
 {
 	struct cfq_queue *cfqq;
 	struct list_head *entry, *tmp;
@@ -372,7 +373,7 @@
 
 		BUG_ON(RB_EMPTY(&cfqq->sort_list));
 
-		__cfq_dispatch_requests(cfqd, cfqq);
+		__cfq_dispatch_requests(q, cfqd, cfqq);
 
 		if (RB_EMPTY(&cfqq->sort_list))
 			cfq_put_queue(cfqd, cfqq);
@@ -399,17 +400,15 @@
 dispatch:
 		rq = list_entry_rq(cfqd->dispatch->next);
 
-		if (q->last_merge == &rq->queuelist)
-			q->last_merge = NULL;
-
+		BUG_ON(q->last_merge == &rq->queuelist);
 		crq = RQ_DATA(rq);
 		if (crq)
-			cfq_del_crq_hash(crq);
+			BUG_ON(ON_MHASH(crq));
 
 		return rq;
 	}
 
-	if (cfq_dispatch_requests(cfqd))
+	if (cfq_dispatch_requests(q, cfqd))
 		goto dispatch;
 
 	return NULL;
@@ -456,7 +455,7 @@
 
 		INIT_LIST_HEAD(&cfqq->cfq_hash);
 		INIT_LIST_HEAD(&cfqq->cfq_list);
-		RB_CLEAR(&cfqq->sort_list);
+		RB_CLEAR_ROOT(&cfqq->sort_list);
 
 		cfqq->pid = pid;
 		cfqq->queued[0] = cfqq->queued[1] = 0;
@@ -552,10 +551,9 @@
 	if (!cfqq)
 		goto out;
 
-	if (cfqq->queued[rw] < cfq_queued)
-		goto out;
-
 	limit = (q->nr_requests - cfq_queued) / cfqd->busy_queues;
+	if (limit < 3)
+		limit = 3;
 	if (cfqq->queued[rw] > limit)
 		ret = 0;
 
@@ -583,6 +581,7 @@
 	struct cfq_rq *crq = mempool_alloc(cfqd->crq_pool, gfp_mask);
 
 	if (crq) {
+		RB_CLEAR(&crq->rb_node);
 		crq->request = rq;
 		crq->cfq_queue = NULL;
 		INIT_LIST_HEAD(&crq->hash);

-- 
Jens Axboe

