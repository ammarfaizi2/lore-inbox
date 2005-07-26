Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261751AbVGZN1P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261751AbVGZN1P (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 09:27:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261772AbVGZN1O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 09:27:14 -0400
Received: from wproxy.gmail.com ([64.233.184.203]:29668 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261751AbVGZN1N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 09:27:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=G2TeqZPkzkoWjzuvlM3E2azFyKPvOTw4Af8F/GapJfQIo/VZTlIFTkbJbnII2A/5Hz2OohgJsolcqCfSgQswuYeIa3ur0UF2Te+xOBsDTc9oNqrCknA5K/xKmNJ90kXeQlp8lwyKE1Qi61z08Q2TnEU5ZrscXctgP8lH3ODkH1w=
Date: Tue, 26 Jul 2005 22:27:06 +0900
From: Tejun Heo <htejun@gmail.com>
To: axboe@suse.de, linux-kernel@vger.kernel.org
Subject: [PATCH linux-2.6-block:master] block: fix cfq_find_next_crq
Message-ID: <20050726132706.GC23916@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Hi,

 In cfq_find_next_crq(), when determining rbnext, if
rb_next(&last->rb_node) is NULL, rb_first() is used without checking
if it equals last.  If it equals last, rbnext should be NULL not last.
This bug is masked by duplicate calls to cfq_find_next_crq which ends
up clearing cfqq->next_crq as, on the second call, last isn't on rb
tree.

 This patch fixes cfq_find_next_crq() and removes extra calls to
cfq_update_next_crq().

Signed-off-by: Tejun Heo <htejun@gmail.com>

Index: blk-fixes/drivers/block/cfq-iosched.c
===================================================================
--- blk-fixes.orig/drivers/block/cfq-iosched.c	2005-07-26 14:35:41.000000000 +0900
+++ blk-fixes/drivers/block/cfq-iosched.c	2005-07-26 14:43:14.000000000 +0900
@@ -195,7 +195,6 @@ struct cfq_rq {
 
 static struct cfq_queue *cfq_find_cfq_hash(struct cfq_data *, unsigned long);
 static void cfq_dispatch_sort(request_queue_t *, struct cfq_rq *);
-static void cfq_update_next_crq(struct cfq_rq *);
 static void cfq_put_cfqd(struct cfq_data *cfqd);
 
 /*
@@ -235,8 +234,6 @@ static void cfq_remove_merge_hints(reque
 
 	if (q->last_merge == crq->request)
 		q->last_merge = NULL;
-
-	cfq_update_next_crq(crq);
 }
 
 static inline void cfq_add_crq_hash(struct cfq_data *cfqd, struct cfq_rq *crq)
@@ -380,8 +377,11 @@ cfq_find_next_crq(struct cfq_data *cfqd,
 	if (!ON_RB(&last->rb_node))
 		return NULL;
 
-	if ((rbnext = rb_next(&last->rb_node)) == NULL)
+	if ((rbnext = rb_next(&last->rb_node)) == NULL) {
 		rbnext = rb_first(&cfqq->sort_list);
+		if (rbnext == &last->rb_node)
+			rbnext = NULL;
+	}
 
 	rbprev = rb_prev(&last->rb_node);
 
@@ -721,7 +721,6 @@ cfq_merged_requests(request_queue_t *q, 
 		}
 	}
 
-	cfq_update_next_crq(cnext);
 	cfq_remove_request(q, next);
 }
 

