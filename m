Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965404AbVKIRSK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965404AbVKIRSK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 12:18:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932608AbVKIRSI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 12:18:08 -0500
Received: from zproxy.gmail.com ([64.233.162.203]:36455 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932742AbVKIRSF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 12:18:05 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=DJyxyQZj26p3yRJFh3tmYBvpDA3YjXCNj8eynp0I+qPVoxx6Xld4kcedXTliolhnwi1Jbl9iP7YwnBC6tlutPYQC2KX9jK1wrow6+r+GorpAUN8cZO83VCYsei7DJaMlmVMToSUGcUA/azauLp9Jdpy3zTuqo39xdMIySYtdpfw=
Date: Thu, 10 Nov 2005 02:17:58 +0900
From: Tejun Heo <htejun@gmail.com>
To: axboe@suse.de, linux-kernel@vger.kernel.org
Subject: [PATCH] blk: cfq forced dispatching fix
Message-ID: <20051109171758.GC24115@htj.dyndns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

cfq forced dispatching might not return all requests on the queue.
This bug can hang elevator switchinig and corrupt request ordering
during flush sequence.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

Jens, I implemented a separate code path for forced dispatching as it
seemed too complex/error-prone to handle forced case in normal
dispatch path.  How do you like this approach?

diff --git a/block/cfq-iosched.c b/block/cfq-iosched.c
--- a/block/cfq-iosched.c
+++ b/block/cfq-iosched.c
@@ -999,7 +999,7 @@ cfq_prio_to_maxrq(struct cfq_data *cfqd,
 /*
  * get next queue for service
  */
-static struct cfq_queue *cfq_select_queue(struct cfq_data *cfqd, int force)
+static struct cfq_queue *cfq_select_queue(struct cfq_data *cfqd)
 {
 	unsigned long now = jiffies;
 	struct cfq_queue *cfqq;
@@ -1023,7 +1023,7 @@ static struct cfq_queue *cfq_select_queu
 	 */
 	if (!RB_EMPTY(&cfqq->sort_list))
 		goto keep_queue;
-	else if (!force && cfq_cfqq_class_sync(cfqq) &&
+	else if (cfq_cfqq_class_sync(cfqq) &&
 		 time_before(now, cfqq->slice_end)) {
 		if (cfq_arm_slice_timer(cfqd, cfqq))
 			return NULL;
@@ -1092,6 +1092,42 @@ __cfq_dispatch_requests(struct cfq_data 
 }
 
 static int
+cfq_forced_dispatch_cfqqs(struct list_head *list)
+{
+	int dispatched = 0;
+	struct cfq_queue *cfqq, *next;
+	struct cfq_rq *crq;
+
+	list_for_each_entry_safe(cfqq, next, list, cfq_list) {
+		while ((crq = cfqq->next_crq)) {
+			cfq_dispatch_insert(cfqq->cfqd->queue, crq);
+			dispatched++;
+		}
+		BUG_ON(!list_empty(&cfqq->fifo));
+	}
+	return dispatched;
+}
+
+static int
+cfq_forced_dispatch(struct cfq_data *cfqd)
+{
+	int i, dispatched = 0;
+
+	for (i = 0; i < CFQ_PRIO_LISTS; i++)
+		dispatched += cfq_forced_dispatch_cfqqs(&cfqd->rr_list[i]);
+
+	dispatched += cfq_forced_dispatch_cfqqs(&cfqd->busy_rr);
+	dispatched += cfq_forced_dispatch_cfqqs(&cfqd->cur_rr);
+	dispatched += cfq_forced_dispatch_cfqqs(&cfqd->idle_rr);
+
+	cfq_slice_expired(cfqd, 0);
+
+	BUG_ON(cfqd->busy_queues);
+
+	return dispatched;
+}
+
+static int
 cfq_dispatch_requests(request_queue_t *q, int force)
 {
 	struct cfq_data *cfqd = q->elevator->elevator_data;
@@ -1100,7 +1136,10 @@ cfq_dispatch_requests(request_queue_t *q
 	if (!cfqd->busy_queues)
 		return 0;
 
-	cfqq = cfq_select_queue(cfqd, force);
+	if (unlikely(force))
+		return cfq_forced_dispatch(cfqd);
+
+	cfqq = cfq_select_queue(cfqd);
 	if (cfqq) {
 		int max_dispatch;
 
@@ -1115,12 +1154,9 @@ cfq_dispatch_requests(request_queue_t *q
 		cfq_clear_cfqq_wait_request(cfqq);
 		del_timer(&cfqd->idle_slice_timer);
 
-		if (!force) {
-			max_dispatch = cfqd->cfq_quantum;
-			if (cfq_class_idle(cfqq))
-				max_dispatch = 1;
-		} else
-			max_dispatch = INT_MAX;
+		max_dispatch = cfqd->cfq_quantum;
+		if (cfq_class_idle(cfqq))
+			max_dispatch = 1;
 
 		return __cfq_dispatch_requests(cfqd, cfqq, max_dispatch);
 	}
