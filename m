Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932327AbWGMMss@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932327AbWGMMss (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 08:48:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932450AbWGMMss
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 08:48:48 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:31023 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932327AbWGMMoE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 08:44:04 -0400
From: Jens Axboe <axboe@suse.de>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@suse.de>
Subject: [PATCH] 9/15 as-iosched: reuse rq for fifo
Date: Thu, 13 Jul 2006 14:46:32 +0200
Message-Id: <11527947982246-git-send-email-axboe@suse.de>
X-Mailer: git-send-email 1.4.1.ged0e0
In-Reply-To: <11527947982769-git-send-email-axboe@suse.de>
References: <11527947982769-git-send-email-axboe@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Saves some space in arq.

Signed-off-by: Jens Axboe <axboe@suse.de>
---
 block/as-iosched.c |   34 ++++++++++++----------------------
 1 files changed, 12 insertions(+), 22 deletions(-)

diff --git a/block/as-iosched.c b/block/as-iosched.c
index 413a944..13d8d91 100644
--- a/block/as-iosched.c
+++ b/block/as-iosched.c
@@ -131,8 +131,6 @@ struct as_data {
 	unsigned long antic_expire;
 };
 
-#define list_entry_fifo(ptr)	list_entry((ptr), struct as_rq, fifo)
-
 /*
  * per-request data.
  */
@@ -153,12 +151,6 @@ struct as_rq {
 
 	struct io_context *io_context;	/* The submitting task */
 
-	/*
-	 * expire fifo
-	 */
-	struct list_head fifo;
-	unsigned long expires;
-
 	unsigned int is_sync;
 	enum arq_state state;
 };
@@ -893,7 +885,7 @@ static void as_remove_queued_request(req
 	if (ad->next_arq[data_dir] == arq)
 		ad->next_arq[data_dir] = as_find_next_arq(ad, arq);
 
-	list_del_init(&arq->fifo);
+	rq_fifo_clear(rq);
 	as_del_arq_rb(ad, rq);
 }
 
@@ -907,7 +899,7 @@ static void as_remove_queued_request(req
  */
 static int as_fifo_expired(struct as_data *ad, int adir)
 {
-	struct as_rq *arq;
+	struct request *rq;
 	long delta_jif;
 
 	delta_jif = jiffies - ad->last_check_fifo[adir];
@@ -921,9 +913,9 @@ static int as_fifo_expired(struct as_dat
 	if (list_empty(&ad->fifo_list[adir]))
 		return 0;
 
-	arq = list_entry_fifo(ad->fifo_list[adir].next);
+	rq = rq_entry_fifo(ad->fifo_list[adir].next);
 
-	return time_after(jiffies, arq->expires);
+	return time_after(jiffies, rq_fifo_time(rq));
 }
 
 /*
@@ -1087,7 +1079,7 @@ static int as_dispatch_request(request_q
 			ad->changed_batch = 1;
 		}
 		ad->batch_data_dir = REQ_SYNC;
-		arq = list_entry_fifo(ad->fifo_list[ad->batch_data_dir].next);
+		arq = RQ_DATA(rq_entry_fifo(ad->fifo_list[REQ_SYNC].next));
 		ad->last_check_fifo[ad->batch_data_dir] = jiffies;
 		goto dispatch_request;
 	}
@@ -1127,8 +1119,7 @@ dispatch_request:
 
 	if (as_fifo_expired(ad, ad->batch_data_dir)) {
 fifo_expired:
-		arq = list_entry_fifo(ad->fifo_list[ad->batch_data_dir].next);
-		BUG_ON(arq == NULL);
+		arq = RQ_DATA(rq_entry_fifo(ad->fifo_list[ad->batch_data_dir].next));
 	}
 
 	if (ad->changed_batch) {
@@ -1184,8 +1175,8 @@ static void as_add_request(request_queue
 	/*
 	 * set expire time (only used for reads) and add to fifo list
 	 */
-	arq->expires = jiffies + ad->fifo_expire[data_dir];
-	list_add_tail(&arq->fifo, &ad->fifo_list[data_dir]);
+	rq_set_fifo_time(rq, jiffies + ad->fifo_expire[data_dir]);
+	list_add_tail(&rq->queuelist, &ad->fifo_list[data_dir]);
 
 	as_update_arq(ad, arq); /* keep state machine up to date */
 	arq->state = AS_RQ_QUEUED;
@@ -1275,10 +1266,10 @@ static void as_merged_requests(request_q
 	 * if anext expires before arq, assign its expire time to arq
 	 * and move into anext position (anext will be deleted) in fifo
 	 */
-	if (!list_empty(&arq->fifo) && !list_empty(&anext->fifo)) {
-		if (time_before(anext->expires, arq->expires)) {
-			list_move(&arq->fifo, &anext->fifo);
-			arq->expires = anext->expires;
+	if (!list_empty(&req->queuelist) && !list_empty(&next->queuelist)) {
+		if (time_before(rq_fifo_time(next), rq_fifo_time(req))) {
+			list_move(&req->queuelist, &next->queuelist);
+			rq_set_fifo_time(req, rq_fifo_time(next));
 			/*
 			 * Don't copy here but swap, because when anext is
 			 * removed below, it must contain the unused context
@@ -1348,7 +1339,6 @@ static int as_set_request(request_queue_
 		arq->request = rq;
 		arq->state = AS_RQ_PRESCHED;
 		arq->io_context = NULL;
-		INIT_LIST_HEAD(&arq->fifo);
 		rq->elevator_private = arq;
 		return 0;
 	}
-- 
1.4.1.ged0e0

