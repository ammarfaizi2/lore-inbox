Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261747AbVFPFHw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261747AbVFPFHw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Jun 2005 01:07:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261750AbVFPFEd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Jun 2005 01:04:33 -0400
Received: from wproxy.gmail.com ([64.233.184.205]:59924 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261746AbVFPE5I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Jun 2005 00:57:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:user-agent:content-type:references:in-reply-to:subject:message-id:date;
        b=rg8uGqgRIhZEmw1K2w9dxgT02m8i1xzDhE83L0d992W3oo3EjL6v5OKlk6n4UBLxK2OBfQFk0C8kYvwTN6ysW/0dN198GTU2hifLf03lWxiznlYHNJ7vg5FsC9tthTUnBGseIj94lQuURcWj9QGXoW0gW5GkyLcnYvd8ejApBHE=
From: Tejun Heo <htejun@gmail.com>
To: axboe@suse.de
Cc: linux-kernel@vger.kernel.org
User-Agent: lksp 0.3
Content-Type: text/plain; charset=US-ASCII
References: <20050616045540.E3E4D48B@htj.dyndns.org>
In-Reply-To: <20050616045540.E3E4D48B@htj.dyndns.org>
Subject: Re: [PATCH Linux 2.6.12-rc6-mm1 05/06] blk: remove last_merge handling from noop iosched
Message-ID: <20050616045540.947E3AD5@htj.dyndns.org>
Date: Thu, 16 Jun 2005 13:57:04 +0900 (KST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

05_blk_last_merge_consolidation_noop.patch

	Remove last_merge handling from noop iosched.  This change
	removes merging capability of noop iosched.

Signed-off-by: Tejun Heo <htejun@gmail.com>

 noop-iosched.c |   31 -------------------------------
 1 files changed, 31 deletions(-)

Index: blk-fixes/drivers/block/noop-iosched.c
===================================================================
--- blk-fixes.orig/drivers/block/noop-iosched.c	2005-06-16 13:55:38.000000000 +0900
+++ blk-fixes/drivers/block/noop-iosched.c	2005-06-16 13:55:38.000000000 +0900
@@ -7,38 +7,9 @@
 #include <linux/module.h>
 #include <linux/init.h>
 
-/*
- * See if we can find a request that this buffer can be coalesced with.
- */
-static int elevator_noop_merge(request_queue_t *q, struct request **req,
-			       struct bio *bio)
-{
-	int ret;
-
-	ret = elv_try_last_merge(q, bio);
-	if (ret != ELEVATOR_NO_MERGE)
-		*req = q->last_merge;
-
-	return ret;
-}
-
-static void elevator_noop_merge_requests(request_queue_t *q, struct request *req,
-					 struct request *next)
-{
-	list_del_init(&next->queuelist);
-}
-
 static void elevator_noop_add_request(request_queue_t *q, struct request *rq)
 {
 	elv_dispatch_insert(q, rq, 0);
-
-	/*
-	 * new merges must not precede this barrier
-	 */
-	if (rq->flags & REQ_HARDBARRIER)
-		q->last_merge = NULL;
-	else if (!q->last_merge)
-		q->last_merge = rq;
 }
 
 static int elevator_noop_dispatch(request_queue_t *q, int force)
@@ -48,8 +19,6 @@ static int elevator_noop_dispatch(reques
 
 static struct elevator_type elevator_noop = {
 	.ops = {
-		.elevator_merge_fn		= elevator_noop_merge,
-		.elevator_merge_req_fn		= elevator_noop_merge_requests,
 		.elevator_dispatch_fn		= elevator_noop_dispatch,
 		.elevator_add_req_fn		= elevator_noop_add_request,
 	},

