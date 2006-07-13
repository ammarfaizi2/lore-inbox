Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932330AbWGMMq0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932330AbWGMMq0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 08:46:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932481AbWGMMqY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 08:46:24 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:35119 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932330AbWGMMoG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 08:44:06 -0400
From: Jens Axboe <axboe@suse.de>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@suse.de>
Subject: [PATCH] 10/15 as-iosched: remove arq->is_sync member
Date: Thu, 13 Jul 2006 14:46:33 +0200
Message-Id: <11527947981715-git-send-email-axboe@suse.de>
X-Mailer: git-send-email 1.4.1.ged0e0
In-Reply-To: <11527947982769-git-send-email-axboe@suse.de>
References: <11527947982769-git-send-email-axboe@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We can track this in struct request.

Signed-off-by: Jens Axboe <axboe@suse.de>
---
 block/as-iosched.c     |   36 ++++++++++++++----------------------
 include/linux/blkdev.h |    5 +++++
 2 files changed, 19 insertions(+), 22 deletions(-)

diff --git a/block/as-iosched.c b/block/as-iosched.c
index 13d8d91..3fbb56d 100644
--- a/block/as-iosched.c
+++ b/block/as-iosched.c
@@ -151,7 +151,6 @@ struct as_rq {
 
 	struct io_context *io_context;	/* The submitting task */
 
-	unsigned int is_sync;
 	enum arq_state state;
 };
 
@@ -241,7 +240,7 @@ static void as_put_io_context(struct as_
 
 	aic = arq->io_context->aic;
 
-	if (arq->is_sync == REQ_SYNC && aic) {
+	if (rq_is_sync(arq->request) && aic) {
 		spin_lock(&aic->lock);
 		set_bit(AS_TASK_IORUNNING, &aic->state);
 		aic->last_end_request = jiffies;
@@ -254,14 +253,13 @@ static void as_put_io_context(struct as_
 /*
  * rb tree support functions
  */
-#define ARQ_RB_ROOT(ad, arq)	(&(ad)->sort_list[(arq)->is_sync])
+#define RQ_RB_ROOT(ad, rq)	(&(ad)->sort_list[rq_is_sync((rq))])
 
 static void as_add_arq_rb(struct as_data *ad, struct request *rq)
 {
-	struct as_rq *arq = RQ_DATA(rq);
 	struct request *alias;
 
-	while ((unlikely(alias = elv_rb_add(ARQ_RB_ROOT(ad, arq), rq)))) {
+	while ((unlikely(alias = elv_rb_add(RQ_RB_ROOT(ad, rq), rq)))) {
 		as_move_to_dispatch(ad, RQ_DATA(alias));
 		as_antic_stop(ad);
 	}
@@ -269,7 +267,7 @@ static void as_add_arq_rb(struct as_data
 
 static inline void as_del_arq_rb(struct as_data *ad, struct request *rq)
 {
-	elv_rb_del(ARQ_RB_ROOT(ad, RQ_DATA(rq)), rq);
+	elv_rb_del(RQ_RB_ROOT(ad, rq), rq);
 }
 
 /*
@@ -300,13 +298,13 @@ as_choose_req(struct as_data *ad, struct
 	if (arq2 == NULL)
 		return arq1;
 
-	data_dir = arq1->is_sync;
+	data_dir = rq_is_sync(arq1->request);
 
 	last = ad->last_sector[data_dir];
 	s1 = arq1->request->sector;
 	s2 = arq2->request->sector;
 
-	BUG_ON(data_dir != arq2->is_sync);
+	BUG_ON(data_dir != rq_is_sync(arq2->request));
 
 	/*
 	 * Strict one way elevator _except_ in the case where we allow
@@ -377,7 +375,7 @@ static struct as_rq *as_find_next_arq(st
 	if (rbnext)
 		next = RQ_DATA(rb_entry_rq(rbnext));
 	else {
-		const int data_dir = arq->is_sync;
+		const int data_dir = rq_is_sync(last);
 
 		rbnext = rb_first(&ad->sort_list[data_dir]);
 		if (rbnext && rbnext != &last->rb_node)
@@ -538,8 +536,7 @@ static void as_update_seekdist(struct as
 static void as_update_iohist(struct as_data *ad, struct as_io_context *aic,
 				struct request *rq)
 {
-	struct as_rq *arq = RQ_DATA(rq);
-	int data_dir = arq->is_sync;
+	int data_dir = rq_is_sync(rq);
 	unsigned long thinktime = 0;
 	sector_t seek_dist;
 
@@ -674,7 +671,7 @@ static int as_can_break_anticipation(str
 		return 1;
 	}
 
-	if (arq && arq->is_sync == REQ_SYNC && as_close_req(ad, aic, arq)) {
+	if (arq && rq_is_sync(arq->request) && as_close_req(ad, aic, arq)) {
 		/*
 		 * Found a close request that is not one of ours.
 		 *
@@ -758,7 +755,7 @@ static int as_can_anticipate(struct as_d
  */
 static void as_update_arq(struct as_data *ad, struct as_rq *arq)
 {
-	const int data_dir = arq->is_sync;
+	const int data_dir = rq_is_sync(arq->request);
 
 	/* keep the next_arq cache up to date */
 	ad->next_arq[data_dir] = as_choose_req(ad, arq, ad->next_arq[data_dir]);
@@ -835,7 +832,7 @@ static void as_completed_request(request
 	 * actually serviced. This should help devices with big TCQ windows
 	 * and writeback caches
 	 */
-	if (ad->new_batch && ad->batch_data_dir == arq->is_sync) {
+	if (ad->new_batch && ad->batch_data_dir == rq_is_sync(rq)) {
 		update_write_batch(ad);
 		ad->current_batch_expires = jiffies +
 				ad->batch_expire[REQ_SYNC];
@@ -868,7 +865,7 @@ out:
 static void as_remove_queued_request(request_queue_t *q, struct request *rq)
 {
 	struct as_rq *arq = RQ_DATA(rq);
-	const int data_dir = arq->is_sync;
+	const int data_dir = rq_is_sync(rq);
 	struct as_data *ad = q->elevator->elevator_data;
 
 	WARN_ON(arq->state != AS_RQ_QUEUED);
@@ -941,7 +938,7 @@ static inline int as_batch_expired(struc
 static void as_move_to_dispatch(struct as_data *ad, struct as_rq *arq)
 {
 	struct request *rq = arq->request;
-	const int data_dir = arq->is_sync;
+	const int data_dir = rq_is_sync(rq);
 
 	BUG_ON(RB_EMPTY_NODE(&rq->rb_node));
 
@@ -1156,12 +1153,7 @@ static void as_add_request(request_queue
 
 	arq->state = AS_RQ_NEW;
 
-	if (rq_data_dir(arq->request) == READ
-			|| (arq->request->flags & REQ_RW_SYNC))
-		arq->is_sync = 1;
-	else
-		arq->is_sync = 0;
-	data_dir = arq->is_sync;
+	data_dir = rq_is_sync(rq);
 
 	arq->io_context = as_get_io_context();
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index e296719..78808a0 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -513,6 +513,11 @@ #define list_entry_rq(ptr)	list_entry((p
 
 #define rq_data_dir(rq)		((rq)->flags & 1)
 
+/*
+ * We regard a request as sync, if it's a READ or a SYNC write.
+ */
+#define rq_is_sync(rq)		(rq_data_dir((rq)) == READ || (rq)->flags & REQ_RW_SYNC)
+
 static inline int blk_queue_full(struct request_queue *q, int rw)
 {
 	if (rw == READ)
-- 
1.4.1.ged0e0

