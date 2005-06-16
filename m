Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261753AbVFPFGk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261753AbVFPFGk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Jun 2005 01:06:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261752AbVFPFEz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Jun 2005 01:04:55 -0400
Received: from wproxy.gmail.com ([64.233.184.193]:62224 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261747AbVFPE5N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Jun 2005 00:57:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:user-agent:content-type:references:in-reply-to:subject:message-id:date;
        b=Fw1hbiPKjDcR2iet8VR/gzEABB60kNB8LYF6Gl5q57TBz1IZNLl+hn2y7Hxtz4hFCD+gJpY6RD1DX1fvcIPLKWMpenWM2J8eXLuTqmchBB6q1YAbJK05eALoCYFptAA6UOCFaN8gWzRBhfl4WCzEjrfhwT265t0k3t8VdlBF8Pw=
From: Tejun Heo <htejun@gmail.com>
To: axboe@suse.de
Cc: linux-kernel@vger.kernel.org
User-Agent: lksp 0.3
Content-Type: text/plain; charset=US-ASCII
References: <20050616045540.E3E4D48B@htj.dyndns.org>
In-Reply-To: <20050616045540.E3E4D48B@htj.dyndns.org>
Subject: Re: [PATCH Linux 2.6.12-rc6-mm1 06/06] blk: remove last_merge handling from cfq iosched
Message-ID: <20050616045540.15DD0703@htj.dyndns.org>
Date: Thu, 16 Jun 2005 13:57:09 +0900 (KST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

06_blk_last_merge_consolidation_cfq.patch

	Remove last_merge handling from cfq iosched

Signed-off-by: Tejun Heo <htejun@gmail.com>

 cfq-iosched.c |   22 ++++------------------
 1 files changed, 4 insertions(+), 18 deletions(-)

Index: blk-fixes/drivers/block/cfq-iosched.c
===================================================================
--- blk-fixes.orig/drivers/block/cfq-iosched.c	2005-06-16 13:55:38.000000000 +0900
+++ blk-fixes/drivers/block/cfq-iosched.c	2005-06-16 13:55:39.000000000 +0900
@@ -598,28 +598,20 @@ cfq_merge(request_queue_t *q, struct req
 	struct request *__rq;
 	int ret;
 
-	ret = elv_try_last_merge(q, bio);
-	if (ret != ELEVATOR_NO_MERGE) {
-		__rq = q->last_merge;
-		goto out_insert;
-	}
-
 	__rq = cfq_find_rq_hash(cfqd, bio->bi_sector);
 	if (__rq && elv_rq_merge_ok(__rq, bio)) {
 		ret = ELEVATOR_BACK_MERGE;
-		goto out;
+		goto found;
 	}
 
 	__rq = cfq_find_rq_rb(cfqd, bio->bi_sector + bio_sectors(bio));
 	if (__rq && elv_rq_merge_ok(__rq, bio)) {
 		ret = ELEVATOR_FRONT_MERGE;
-		goto out;
+		goto found;
 	}
 
 	return ELEVATOR_NO_MERGE;
-out:
-	q->last_merge = __rq;
-out_insert:
+ found:
 	*req = __rq;
 	return ret;
 }
@@ -638,8 +630,6 @@ static void cfq_merged_request(request_q
 		cfq_update_next_crq(crq);
 		cfq_reposition_crq_rb(cfqq, crq);
 	}
-
-	q->last_merge = req;
 }
 
 static void
@@ -1544,13 +1534,9 @@ static void cfq_insert_request(request_q
 
 	list_add_tail(&rq->queuelist, &cfqq->fifo);
 
-	if (rq_mergeable(rq)) {
+	if (rq_mergeable(rq))
 		cfq_add_crq_hash(cfqd, crq);
 
-		if (!cfqd->queue->last_merge)
-			cfqd->queue->last_merge = rq;
-	}
-
 	cfq_crq_enqueued(cfqd, cfqq, crq);
 }
 

