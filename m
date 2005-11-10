Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750949AbVKJOSA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750949AbVKJOSA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 09:18:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750953AbVKJOSA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 09:18:00 -0500
Received: from xproxy.gmail.com ([66.249.82.199]:29909 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750949AbVKJOR7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 09:17:59 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=id0mH308ui2z2N0lgyV/sEw7fsc0ZMLexqh8wp1I2YBb0KFyK77EFlP8VJ84rROXGFC3H6DjnfouoRTgl7pqq53sBClRvGfx5TFfuYb1NFxknEIU5TzAds1anKhfeaDvGLGWOR3tsXd27bkt0KT4V2paOBBAejs8wOoYlHFKQcM=
Date: Thu, 10 Nov 2005 23:17:51 +0900
From: Tejun Heo <htejun@gmail.com>
To: axboe@suse.de, linux-kernel@vger.kernel.org
Subject: [PATCH] noop-iosched: reimplementation
Message-ID: <20051110141751.GB26030@htj.dyndns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The original implementation directly used dispatch queue.  As new
generic dispatch queue imposes stricter rules over ioscheds and
dispatch queue usage, this direct use becomes somewhat problematic.
This patch reimplements noop-iosched such that it complies to generic
iosched model better.  Request merging with q->last_merge and
rq->queuelist.prev/next work again now.

Signed-off-by: Tejun Heo <htejun@gmail.com>

--

Jens, this one also received several hours of testing which involves a
lot of request merging, but it might still be a better idea to wait
for the next release.  Oh... Are we still in the merging window for
2.6.15?  If so, this one can go in, I guess.

diff --git a/block/noop-iosched.c b/block/noop-iosched.c
--- a/block/noop-iosched.c
+++ b/block/noop-iosched.c
@@ -7,21 +7,94 @@
 #include <linux/module.h>
 #include <linux/init.h>
 
-static void elevator_noop_add_request(request_queue_t *q, struct request *rq)
+struct noop_data {
+	struct list_head queue;
+};
+
+static void noop_merged_requests(request_queue_t *q, struct request *rq,
+				 struct request *next)
+{
+	list_del_init(&next->queuelist);
+}
+
+static int noop_dispatch(request_queue_t *q, int force)
+{
+	struct noop_data *nd = q->elevator->elevator_data;
+
+	if (!list_empty(&nd->queue)) {
+		struct request *rq;
+		rq = list_entry(nd->queue.next, struct request, queuelist);
+		list_del_init(&rq->queuelist);
+		elv_dispatch_sort(q, rq);
+		return 1;
+	}
+	return 0;
+}
+
+static void noop_add_request(request_queue_t *q, struct request *rq)
+{
+	struct noop_data *nd = q->elevator->elevator_data;
+
+	list_add_tail(&rq->queuelist, &nd->queue);
+}
+
+static int noop_queue_empty(request_queue_t *q)
 {
-	rq->flags |= REQ_NOMERGE;
-	elv_dispatch_add_tail(q, rq);
+	struct noop_data *nd = q->elevator->elevator_data;
+
+	return list_empty(&nd->queue);
+}
+
+static struct request *
+noop_former_request(request_queue_t *q, struct request *rq)
+{
+	struct noop_data *nd = q->elevator->elevator_data;
+
+	if (rq->queuelist.prev == &nd->queue)
+		return NULL;
+	return list_entry(rq->queuelist.prev, struct request, queuelist);
+}
+
+static struct request *
+noop_latter_request(request_queue_t *q, struct request *rq)
+{
+	struct noop_data *nd = q->elevator->elevator_data;
+
+	if (rq->queuelist.next == &nd->queue)
+		return NULL;
+	return list_entry(rq->queuelist.next, struct request, queuelist);
 }
 
-static int elevator_noop_dispatch(request_queue_t *q, int force)
+static int noop_init_queue(request_queue_t *q, elevator_t *e)
 {
+	struct noop_data *nd;
+
+	nd = kmalloc(sizeof(*nd), GFP_KERNEL);
+	if (!nd)
+		return -ENOMEM;
+	INIT_LIST_HEAD(&nd->queue);
+	e->elevator_data = nd;
 	return 0;
 }
 
+static void noop_exit_queue(elevator_t *e)
+{
+	struct noop_data *nd = e->elevator_data;
+
+	BUG_ON(!list_empty(&nd->queue));
+	kfree(nd);
+}
+
 static struct elevator_type elevator_noop = {
 	.ops = {
-		.elevator_dispatch_fn		= elevator_noop_dispatch,
-		.elevator_add_req_fn		= elevator_noop_add_request,
+		.elevator_merge_req_fn		= noop_merged_requests,
+		.elevator_dispatch_fn		= noop_dispatch,
+		.elevator_add_req_fn		= noop_add_request,
+		.elevator_queue_empty_fn	= noop_queue_empty,
+		.elevator_former_req_fn		= noop_former_request,
+		.elevator_latter_req_fn		= noop_latter_request,
+		.elevator_init_fn		= noop_init_queue,
+		.elevator_exit_fn		= noop_exit_queue,
 	},
 	.elevator_name = "noop",
 	.elevator_owner = THIS_MODULE,
