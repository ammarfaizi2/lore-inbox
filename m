Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261385AbULXKMz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261385AbULXKMz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Dec 2004 05:12:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261388AbULXKMz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Dec 2004 05:12:55 -0500
Received: from pfepb.post.tele.dk ([195.41.46.236]:48227 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S261385AbULXKMt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Dec 2004 05:12:49 -0500
Date: Fri, 24 Dec 2004 11:07:13 +0100
From: Jens Axboe <axboe@suse.de>
To: Shailabh Nagar <nagar@watson.ibm.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: noop insert
Message-ID: <20041224100711.GA2100@suse.de>
References: <41CAEBD4.8030609@watson.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41CAEBD4.8030609@watson.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 23 2004, Shailabh Nagar wrote:
> In noop-iosched.c (2.6.10-rc2),
> 
> void elevator_noop_add_request(request_queue_t *q, struct request *rq,
> 			       int where)
> {
> 	struct list_head *insert = q->queue_head.prev;
> 
> 	if (where == ELEVATOR_INSERT_FRONT)
> 		insert = &q->queue_head;
> 
> 	list_add_tail(&rq->queuelist, &q->queue_head);
> <snip>
> 
> shouldn't the insertion happen at insert instead of q->queue_head ?

Yeah, it looks broken. This is easier to read and correct :-)

===== drivers/block/noop-iosched.c 1.4 vs edited =====
--- 1.4/drivers/block/noop-iosched.c	2004-10-19 11:40:17 +02:00
+++ edited/drivers/block/noop-iosched.c	2004-12-24 11:06:18 +01:00
@@ -59,12 +59,10 @@
 void elevator_noop_add_request(request_queue_t *q, struct request *rq,
 			       int where)
 {
-	struct list_head *insert = q->queue_head.prev;
-
 	if (where == ELEVATOR_INSERT_FRONT)
-		insert = &q->queue_head;
-
-	list_add_tail(&rq->queuelist, &q->queue_head);
+		list_add(&rq->queuelist, &q->queue_head);
+	else
+		list_add_tail(&rq->queuelist, &q->queue_head);
 
 	/*
 	 * new merges must not precede this barrier

Signed-off-by: Jens Axboe <axboe@suse.de>

-- 
Jens Axboe

