Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265091AbUGGMjZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265091AbUGGMjZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 08:39:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265089AbUGGMjZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 08:39:25 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:29375 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S265091AbUGGMjV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 08:39:21 -0400
Date: Wed, 7 Jul 2004 14:39:10 +0200
From: Jens Axboe <axboe@suse.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Arjan Van de Ven <arjanv@redhat.com>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] cfq: bad allocation
Message-ID: <20040707123910.GB10342@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Arjan (sensibly) put a might_sleep() in mempool_alloc() and it caught a
bad cfq usage, pretty embarassaing actually. This patch should fix it
up.

Signed-off-by: Jens Axboe <axboe@suse.de>

--- /opt/kernel/linux-2.6.7-mm6/drivers/block/cfq-iosched.c	2004-07-07 10:33:29.000000000 +0200
+++ linux-2.6.7-mm6/drivers/block/cfq-iosched.c	2004-07-07 14:37:19.546229784 +0200
@@ -456,21 +456,23 @@
 	mempool_free(cfqq, cfq_mpool);
 }
 
-static struct cfq_queue *cfq_get_queue(struct cfq_data *cfqd, int pid)
+static struct cfq_queue *cfq_get_queue(struct cfq_data *cfqd, int pid, int mask)
 {
 	const int hashval = hash_long(current->tgid, CFQ_QHASH_SHIFT);
 	struct cfq_queue *cfqq = __cfq_find_cfq_hash(cfqd, pid, hashval);
 
 	if (!cfqq) {
-		cfqq = mempool_alloc(cfq_mpool, GFP_NOIO);
+		cfqq = mempool_alloc(cfq_mpool, mask);
 
-		INIT_LIST_HEAD(&cfqq->cfq_hash);
-		INIT_LIST_HEAD(&cfqq->cfq_list);
-		RB_CLEAR_ROOT(&cfqq->sort_list);
-
-		cfqq->pid = pid;
-		cfqq->queued[0] = cfqq->queued[1] = 0;
-		list_add(&cfqq->cfq_hash, &cfqd->cfq_hash[hashval]);
+		if (cfqq) {
+			INIT_LIST_HEAD(&cfqq->cfq_hash);
+			INIT_LIST_HEAD(&cfqq->cfq_list);
+			RB_CLEAR_ROOT(&cfqq->sort_list);
+
+			cfqq->pid = pid;
+			cfqq->queued[0] = cfqq->queued[1] = 0;
+			list_add(&cfqq->cfq_hash, &cfqd->cfq_hash[hashval]);
+		}
 	}
 
 	return cfqq;
@@ -478,15 +480,22 @@
 
 static void cfq_enqueue(struct cfq_data *cfqd, struct cfq_rq *crq)
 {
-	struct cfq_queue *cfqq;
-
-	cfqq = cfq_get_queue(cfqd, current->tgid);
+	struct cfq_queue *cfqq = cfq_get_queue(cfqd, current->tgid, GFP_ATOMIC);
 
-	cfq_add_crq_rb(cfqd, cfqq, crq);
+	if (cfqq) {
+		cfq_add_crq_rb(cfqd, cfqq, crq);
 
-	if (list_empty(&cfqq->cfq_list)) {
-		list_add(&cfqq->cfq_list, &cfqd->rr_list);
-		cfqd->busy_queues++;
+		if (list_empty(&cfqq->cfq_list)) {
+			list_add(&cfqq->cfq_list, &cfqd->rr_list);
+			cfqd->busy_queues++;
+		}
+	} else {
+		/*
+		 * should can only happen if the request wasn't allocated
+		 * through blk_alloc_request(), eg stack requests from ide-cd
+		 * (those should be removed) _and_ we are in OOM.
+		 */
+		list_add_tail(&crq->request->queuelist, cfqd->dispatch);
 	}
 }
 
@@ -617,8 +626,17 @@
 static int cfq_set_request(request_queue_t *q, struct request *rq, int gfp_mask)
 {
 	struct cfq_data *cfqd = q->elevator.elevator_data;
-	struct cfq_rq *crq = mempool_alloc(cfqd->crq_pool, gfp_mask);
+	struct cfq_queue *cfqq;
+	struct cfq_rq *crq;
+
+	/*
+	 * prepare a queue up front, so cfq_enqueue() doesn't have to
+	 */
+	cfqq = cfq_get_queue(cfqd, current->tgid, gfp_mask);
+	if (!cfqq)
+		return 1;
 
+	crq = mempool_alloc(cfqd->crq_pool, gfp_mask);
 	if (crq) {
 		RB_CLEAR(&crq->rb_node);
 		crq->request = rq;

-- 
Jens Axboe

