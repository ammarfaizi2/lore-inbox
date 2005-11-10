Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751003AbVKJOXy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751003AbVKJOXy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 09:23:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751006AbVKJOXy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 09:23:54 -0500
Received: from wproxy.gmail.com ([64.233.184.195]:22050 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751000AbVKJOXx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 09:23:53 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=KTwQO+DaC+/KGXtLe7/2IiVEnzz6qMmoqzvLTEEqHQrNDSu80KnHLiAFyxl2pkJ1zH1V0PGfMwVzxRmzfIZ0NxbKApF2ZHmG62pWTx0fXMoWhKBIJHMtYlIULpUxRIfgYJyolKDdgPaPem4kdcKpXDpwaigqZeNUFwXz11602SE=
Date: Thu, 10 Nov 2005 23:23:47 +0900
From: Tejun Heo <htejun@gmail.com>
To: axboe@suse.de, linux-kernel@vger.kernel.org
Subject: [PATCH] blk: elv_latter/former_request update
Message-ID: <20051110142347.GC26030@htj.dyndns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With generic dispatch queue update, implicit former/latter request
handling using rq->queuelist.prev/next doesn't work as expected
anymore.  Also, the only iosched dependent on this feature was
noop-iosched and it has been reimplemented to have its own
latter/former methods.  This patch removes implicit former/latter
handling.

Signed-off-by: Tejun Heo <htejun@gmail.com>

diff --git a/block/elevator.c b/block/elevator.c
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -540,33 +540,19 @@ int elv_queue_empty(request_queue_t *q)
 
 struct request *elv_latter_request(request_queue_t *q, struct request *rq)
 {
-	struct list_head *next;
-
 	elevator_t *e = q->elevator;
 
 	if (e->ops->elevator_latter_req_fn)
 		return e->ops->elevator_latter_req_fn(q, rq);
-
-	next = rq->queuelist.next;
-	if (next != &q->queue_head && next != &rq->queuelist)
-		return list_entry_rq(next);
-
 	return NULL;
 }
 
 struct request *elv_former_request(request_queue_t *q, struct request *rq)
 {
-	struct list_head *prev;
-
 	elevator_t *e = q->elevator;
 
 	if (e->ops->elevator_former_req_fn)
 		return e->ops->elevator_former_req_fn(q, rq);
-
-	prev = rq->queuelist.prev;
-	if (prev != &q->queue_head && prev != &rq->queuelist)
-		return list_entry_rq(prev);
-
 	return NULL;
 }
 
