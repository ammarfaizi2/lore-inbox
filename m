Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262139AbVEXQke@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262139AbVEXQke (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 12:40:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262140AbVEXQht
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 12:37:49 -0400
Received: from wproxy.gmail.com ([64.233.184.193]:54477 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262164AbVEXQfb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 12:35:31 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:user-agent:content-type:references:in-reply-to:subject:message-id:date;
        b=GyWZr1y96KTA0QmXDfNClNats5okMRvmi9QKCoqOq4Ofj4TWyVGkKuEYPHmKJ7R5FHeD8CExtjSPnh+F7FqVhAVFpAOWX2+5OpLg2YQT7PkT88m6XhON/DsHVbzJD5GA5YKCMtBvWPTsRA8GloI859R5zxbGdtQxIShXToDLgck=
From: Tejun Heo <htejun@gmail.com>
To: axboe@suse.de
Cc: linux-kernel@vger.kernel.org
User-Agent: lksp 0.3
Content-Type: text/plain; charset=US-ASCII
References: <20050524163518.0DA61D6C@htj.dyndns.org>
In-Reply-To: <20050524163518.0DA61D6C@htj.dyndns.org>
Subject: Re: [PATCH Linux 2.6.12-rc4-mm2 01/03] cfq: cfq ELEVATOR_INSERT_BACK fix
Message-ID: <20050524163518.B14862D0@htj.dyndns.org>
Date: Wed, 25 May 2005 01:35:24 +0900 (KST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

01_cfq_INSERT_BACK_fix.patch

	When inserting INSERT_BACK request, cfq_insert_request() calls
	cfq_dispatch_requests() repetitively until it returns zero
	indicating no request is dispatched.  This used to flush all
	the requests in the queue to the dispatch queue but, with idle
	slice implemented, the current active queue may decide to wait
	for new request using slice_timer.  When this happens, 0 is
	returned from cfq_dispatch_requests() even when other cfqq's
	have pending requests.  This breaks INSRET_BACK semantics.

	This patch adds @force argument which, when set to non-zero,
	disables idle_slice, and uses the argument when flushing
	cfqq's for INSERT_BACK.  While at it, use INT_MAX instead of
	cfq_quantum when flushing cfqq's, as we're gonna dump all the
	requests and using cfq_quantum does nothing but adding
	unnecessary iterations.

Signed-off-by: Tejun Heo <htejun@gmail.com>

 cfq-iosched.c |   14 ++++++++------
 1 files changed, 8 insertions(+), 6 deletions(-)

Index: blk-fixes/drivers/block/cfq-iosched.c
===================================================================
--- blk-fixes.orig/drivers/block/cfq-iosched.c	2005-05-25 01:35:16.000000000 +0900
+++ blk-fixes/drivers/block/cfq-iosched.c	2005-05-25 01:35:16.000000000 +0900
@@ -991,7 +991,7 @@ cfq_prio_to_maxrq(struct cfq_data *cfqd,
 /*
  * get next queue for service
  */
-static struct cfq_queue *cfq_select_queue(struct cfq_data *cfqd)
+static struct cfq_queue *cfq_select_queue(struct cfq_data *cfqd, int force)
 {
 	unsigned long now = jiffies;
 	struct cfq_queue *cfqq;
@@ -1012,7 +1012,8 @@ static struct cfq_queue *cfq_select_queu
 	 */
 	if (!RB_EMPTY(&cfqq->sort_list))
 		goto keep_queue;
-	else if (cfq_cfqq_sync(cfqq) && time_before(now, cfqq->slice_end)) {
+	else if (!force && cfq_cfqq_sync(cfqq) &&
+		 time_before(now, cfqq->slice_end)) {
 		if (cfq_arm_slice_timer(cfqd, cfqq))
 			return NULL;
 	}
@@ -1078,7 +1079,8 @@ __cfq_dispatch_requests(struct cfq_data 
 	return dispatched;
 }
 
-static int cfq_dispatch_requests(request_queue_t *q, int max_dispatch)
+static int
+cfq_dispatch_requests(request_queue_t *q, int max_dispatch, int force)
 {
 	struct cfq_data *cfqd = q->elevator->elevator_data;
 	struct cfq_queue *cfqq;
@@ -1086,7 +1088,7 @@ static int cfq_dispatch_requests(request
 	if (!cfqd->busy_queues)
 		return 0;
 
-	cfqq = cfq_select_queue(cfqd);
+	cfqq = cfq_select_queue(cfqd, force);
 	if (cfqq) {
 		cfqq->wait_request = 0;
 		cfqq->must_dispatch = 0;
@@ -1172,7 +1174,7 @@ dispatch:
 		return rq;
 	}
 
-	if (cfq_dispatch_requests(q, cfqd->cfq_quantum))
+	if (cfq_dispatch_requests(q, cfqd->cfq_quantum, 0))
 		goto dispatch;
 
 	return NULL;
@@ -1707,7 +1709,7 @@ cfq_insert_request(request_queue_t *q, s
 
 	switch (where) {
 		case ELEVATOR_INSERT_BACK:
-			while (cfq_dispatch_requests(q, cfqd->cfq_quantum))
+			while (cfq_dispatch_requests(q, INT_MAX, 1))
 				;
 			list_add_tail(&rq->queuelist, &q->queue_head);
 			break;

