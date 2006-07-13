Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932428AbWGMMog@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932428AbWGMMog (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 08:44:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932517AbWGMMoP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 08:44:15 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:30767 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932428AbWGMMoE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 08:44:04 -0400
From: Jens Axboe <axboe@suse.de>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@suse.de>
Subject: [PATCH] 12/15 cfq-iosched: remove the crq flag functions/variable
Date: Thu, 13 Jul 2006 14:46:35 +0200
Message-Id: <11527947983541-git-send-email-axboe@suse.de>
X-Mailer: git-send-email 1.4.1.ged0e0
In-Reply-To: <11527947982769-git-send-email-axboe@suse.de>
References: <11527947982769-git-send-email-axboe@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There's just one flag currently (SYNC), and that one can be grabbed from
the request.

Signed-off-by: Jens Axboe <axboe@suse.de>
---
 block/cfq-iosched.c |   58 ++++++++++++++-------------------------------------
 1 files changed, 16 insertions(+), 42 deletions(-)

diff --git a/block/cfq-iosched.c b/block/cfq-iosched.c
index 3770c27..c97e387 100644
--- a/block/cfq-iosched.c
+++ b/block/cfq-iosched.c
@@ -182,8 +182,6 @@ struct cfq_rq {
 
 	struct cfq_queue *cfq_queue;
 	struct cfq_io_context *io_context;
-
-	unsigned int crq_flags;
 };
 
 enum cfqq_state_flags {
@@ -221,27 +219,6 @@ CFQ_CFQQ_FNS(idle_window);
 CFQ_CFQQ_FNS(prio_changed);
 #undef CFQ_CFQQ_FNS
 
-enum cfq_rq_state_flags {
-	CFQ_CRQ_FLAG_is_sync = 0,
-};
-
-#define CFQ_CRQ_FNS(name)						\
-static inline void cfq_mark_crq_##name(struct cfq_rq *crq)		\
-{									\
-	crq->crq_flags |= (1 << CFQ_CRQ_FLAG_##name);			\
-}									\
-static inline void cfq_clear_crq_##name(struct cfq_rq *crq)		\
-{									\
-	crq->crq_flags &= ~(1 << CFQ_CRQ_FLAG_##name);			\
-}									\
-static inline int cfq_crq_##name(const struct cfq_rq *crq)		\
-{									\
-	return (crq->crq_flags & (1 << CFQ_CRQ_FLAG_##name)) != 0;	\
-}
-
-CFQ_CRQ_FNS(is_sync);
-#undef CFQ_CRQ_FNS
-
 static struct cfq_queue *cfq_find_cfq_hash(struct cfq_data *, unsigned int, unsigned short);
 static void cfq_dispatch_insert(request_queue_t *, struct cfq_rq *);
 static struct cfq_queue *cfq_get_queue(struct cfq_data *cfqd, unsigned int key, struct task_struct *tsk, gfp_t gfp_mask);
@@ -290,9 +267,9 @@ #define CFQ_RQ2_WRAP	0x02 /* request 2 w
 	if (crq2 == NULL)
 		return crq1;
 
-	if (cfq_crq_is_sync(crq1) && !cfq_crq_is_sync(crq2))
+	if (rq_is_sync(crq1->request) && !rq_is_sync(crq2->request))
 		return crq1;
-	else if (cfq_crq_is_sync(crq2) && !cfq_crq_is_sync(crq1))
+	else if (rq_is_sync(crq2->request) && !rq_is_sync(crq1->request))
 		return crq2;
 
 	s1 = crq1->request->sector;
@@ -477,7 +454,7 @@ static inline void cfq_del_crq_rb(struct
 {
 	struct cfq_queue *cfqq = crq->cfq_queue;
 	struct cfq_data *cfqd = cfqq->cfqd;
-	const int sync = cfq_crq_is_sync(crq);
+	const int sync = rq_is_sync(crq->request);
 
 	BUG_ON(!cfqq->queued[sync]);
 	cfqq->queued[sync]--;
@@ -495,7 +472,7 @@ static void cfq_add_crq_rb(struct cfq_rq
 	struct request *rq = crq->request;
 	struct request *__alias;
 
-	cfqq->queued[cfq_crq_is_sync(crq)]++;
+	cfqq->queued[rq_is_sync(rq)]++;
 
 	/*
 	 * looks a little odd, but the first insert might return an alias.
@@ -508,8 +485,10 @@ static void cfq_add_crq_rb(struct cfq_rq
 static inline void
 cfq_reposition_crq_rb(struct cfq_queue *cfqq, struct cfq_rq *crq)
 {
-	elv_rb_del(&cfqq->sort_list, crq->request);
-	cfqq->queued[cfq_crq_is_sync(crq)]--;
+	struct request *rq = crq->request;
+
+	elv_rb_del(&cfqq->sort_list, rq);
+	cfqq->queued[rq_is_sync(rq)]--;
 	cfq_add_crq_rb(crq);
 }
 
@@ -814,11 +793,11 @@ static void cfq_dispatch_insert(request_
 {
 	struct cfq_data *cfqd = q->elevator->elevator_data;
 	struct cfq_queue *cfqq = crq->cfq_queue;
-	struct request *rq;
+	struct request *rq = crq->request;
 
-	cfq_remove_request(crq->request);
-	cfqq->on_dispatch[cfq_crq_is_sync(crq)]++;
-	elv_dispatch_sort(q, crq->request);
+	cfq_remove_request(rq);
+	cfqq->on_dispatch[rq_is_sync(rq)]++;
+	elv_dispatch_sort(q, rq);
 
 	rq = list_entry(q->queue_head.prev, struct request, queuelist);
 	cfqd->last_sector = rq->sector + rq->nr_sectors;
@@ -1585,7 +1564,7 @@ cfq_should_preempt(struct cfq_data *cfqd
 	 */
 	if (new_cfqq->slice_left < cfqd->cfq_slice_idle)
 		return 0;
-	if (cfq_crq_is_sync(crq) && !cfq_cfqq_sync(cfqq))
+	if (rq_is_sync(crq->request) && !cfq_cfqq_sync(cfqq))
 		return 1;
 
 	return 0;
@@ -1634,7 +1613,7 @@ cfq_crq_enqueued(struct cfq_data *cfqd, 
 	struct cfq_io_context *cic = crq->io_context;
 
 	/*
-	 * check if this request is a better next-serve candidate
+	 * check if this request is a better next-serve candidate)) {
 	 */
 	cfqq->next_crq = cfq_choose_req(cfqd, cfqq->next_crq, crq);
 	BUG_ON(!cfqq->next_crq);
@@ -1643,7 +1622,7 @@ cfq_crq_enqueued(struct cfq_data *cfqd, 
 	 * we never wait for an async request and we don't allow preemption
 	 * of an async request. so just return early
 	 */
-	if (!cfq_crq_is_sync(crq)) {
+	if (!rq_is_sync(crq->request)) {
 		/*
 		 * sync process issued an async request, if it's waiting
 		 * then expire it and kick rq handling.
@@ -1709,7 +1688,7 @@ static void cfq_completed_request(reques
 	struct cfq_rq *crq = RQ_DATA(rq);
 	struct cfq_queue *cfqq = crq->cfq_queue;
 	struct cfq_data *cfqd = cfqq->cfqd;
-	const int sync = cfq_crq_is_sync(crq);
+	const int sync = rq_is_sync(rq);
 	unsigned long now;
 
 	now = jiffies;
@@ -1905,11 +1884,6 @@ cfq_set_request(request_queue_t *q, stru
 		crq->cfq_queue = cfqq;
 		crq->io_context = cic;
 
-		if (is_sync)
-			cfq_mark_crq_is_sync(crq);
-		else
-			cfq_clear_crq_is_sync(crq);
-
 		rq->elevator_private = crq;
 		return 0;
 	}
-- 
1.4.1.ged0e0

