Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261740AbVFPE7M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261740AbVFPE7M (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Jun 2005 00:59:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261739AbVFPE7L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Jun 2005 00:59:11 -0400
Received: from wproxy.gmail.com ([64.233.184.197]:2324 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261742AbVFPE4x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Jun 2005 00:56:53 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:user-agent:content-type:references:in-reply-to:subject:message-id:date;
        b=ne0GnxqS3CGrc+Hadljw5p5BSVVTdwTREeOZjJkvtkdrtv5BKjx1uDok8rMDWiV94jzMCpObgrsmF1f78eiGK5Zavoi/mmnd/9Gz3it6lbvcDvkkcPfTHgAWUT0TVcpIVXn3FDaEDxyFiKgrHKQnj4rzf2N251smw8pafOkKOpY=
From: Tejun Heo <htejun@gmail.com>
To: axboe@suse.de
Cc: linux-kernel@vger.kernel.org
User-Agent: lksp 0.3
Content-Type: text/plain; charset=US-ASCII
References: <20050616045540.E3E4D48B@htj.dyndns.org>
In-Reply-To: <20050616045540.E3E4D48B@htj.dyndns.org>
Subject: Re: [PATCH Linux 2.6.12-rc6-mm1 02/06] blk: update noop iosched to use generic dispatch queue
Message-ID: <20050616045540.A21C5144@htj.dyndns.org>
Date: Thu, 16 Jun 2005 13:56:48 +0900 (KST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

02_blk_dispatch_queue_noop.patch

	Update noop iosched to use generic dispatch queue

Signed-off-by: Tejun Heo <htejun@gmail.com>

 noop-iosched.c |   17 +++++------------
 1 files changed, 5 insertions(+), 12 deletions(-)

Index: blk-fixes/drivers/block/noop-iosched.c
===================================================================
--- blk-fixes.orig/drivers/block/noop-iosched.c	2005-06-16 13:55:36.000000000 +0900
+++ blk-fixes/drivers/block/noop-iosched.c	2005-06-16 13:55:38.000000000 +0900
@@ -28,13 +28,9 @@ static void elevator_noop_merge_requests
 	list_del_init(&next->queuelist);
 }
 
-static void elevator_noop_add_request(request_queue_t *q, struct request *rq,
-				      int where)
+static void elevator_noop_add_request(request_queue_t *q, struct request *rq)
 {
-	if (where == ELEVATOR_INSERT_FRONT)
-		list_add(&rq->queuelist, &q->queue_head);
-	else
-		list_add_tail(&rq->queuelist, &q->queue_head);
+	elv_dispatch_insert(q, rq, 0);
 
 	/*
 	 * new merges must not precede this barrier
@@ -45,19 +41,16 @@ static void elevator_noop_add_request(re
 		q->last_merge = rq;
 }
 
-static struct request *elevator_noop_next_request(request_queue_t *q)
+static int elevator_noop_dispatch(request_queue_t *q, int force)
 {
-	if (!list_empty(&q->queue_head))
-		return list_entry_rq(q->queue_head.next);
-
-	return NULL;
+	return 0;
 }
 
 static struct elevator_type elevator_noop = {
 	.ops = {
 		.elevator_merge_fn		= elevator_noop_merge,
 		.elevator_merge_req_fn		= elevator_noop_merge_requests,
-		.elevator_next_req_fn		= elevator_noop_next_request,
+		.elevator_dispatch_fn		= elevator_noop_dispatch,
 		.elevator_add_req_fn		= elevator_noop_add_request,
 	},
 	.elevator_name = "noop",

