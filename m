Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751349AbWALP36@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751349AbWALP36 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 10:29:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751320AbWALP35
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 10:29:57 -0500
Received: from zproxy.gmail.com ([64.233.162.198]:18307 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751205AbWALP34 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 10:29:56 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=mvwfkILDjYXN+gXdNlfjTkwKaL46p5Q45odx5s4dfgjqCLkiFy7HX1dFfeZoYsW7/EVbpD7dCtWVarHcI0GxYsLgg9yL1M6hXSRqjuNoUtyEttOWnFy2xbbZp6PL9asnJCYgm/Yh9h4kr0pROsYGWlUdcBw1F94SsogYAfL9cDU=
Date: Fri, 13 Jan 2006 00:29:49 +0900
From: Tejun Heo <htejun@gmail.com>
To: axboe@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] blk: fix possible queue stall in blk_do_ordered
Message-ID: <20060112152949.GA9855@htj.dyndns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Previously, if a fs request which was being drained failed and got
requeued, blk_do_ordered() didn't allow it to be reissued, which
causes queue stall.  This patch makes blk_do_ordered() use the
sequence of each request to determine whether a request can be issued
or not.  This fixes the bug and simplifies code.

Signed-off-by: Tejun Heo <htejun@gmail.com>

--

Jens, this fix is not very urgent.  The bug is not likely to be
triggered easily.  I think pushing this to -mm first would be better.

Thanks.

Signed-off-by: Tejun Heo <htejun@gmail.com>

diff --git a/block/ll_rw_blk.c b/block/ll_rw_blk.c
index ec27dda..701808e 100644
--- a/block/ll_rw_blk.c
+++ b/block/ll_rw_blk.c
@@ -494,7 +494,7 @@ static inline struct request *start_orde
 
 int blk_do_ordered(request_queue_t *q, struct request **rqp)
 {
-	struct request *rq = *rqp, *allowed_rq;
+	struct request *rq = *rqp;
 	int is_barrier = blk_fs_request(rq) && blk_barrier_rq(rq);
 
 	if (!q->ordseq) {
@@ -518,32 +518,26 @@ int blk_do_ordered(request_queue_t *q, s
 		}
 	}
 
+	/*
+	 * Ordered sequence in progress
+	 */
+
+	/* Special requests are not subject to ordering rules. */
+	if (!blk_fs_request(rq) &&
+	    rq != &q->pre_flush_rq && rq != &q->post_flush_rq)
+		return 1;
+
 	if (q->ordered & QUEUE_ORDERED_TAG) {
+		/* Ordered by tag.  Blocking the next barrier is enough. */
 		if (is_barrier && rq != &q->bar_rq)
 			*rqp = NULL;
-		return 1;
+	} else {
+		/* Ordered by draining.  Wait for turn. */
+		WARN_ON(blk_ordered_req_seq(rq) < blk_ordered_cur_seq(q));
+		if (blk_ordered_req_seq(rq) > blk_ordered_cur_seq(q))
+			*rqp = NULL;
 	}
 
-	switch (blk_ordered_cur_seq(q)) {
-	case QUEUE_ORDSEQ_PREFLUSH:
-		allowed_rq = &q->pre_flush_rq;
-		break;
-	case QUEUE_ORDSEQ_BAR:
-		allowed_rq = &q->bar_rq;
-		break;
-	case QUEUE_ORDSEQ_POSTFLUSH:
-		allowed_rq = &q->post_flush_rq;
-		break;
-	default:
-		allowed_rq = NULL;
-		break;
-	}
-
-	if (rq != allowed_rq &&
-	    (blk_fs_request(rq) || rq == &q->pre_flush_rq ||
-	     rq == &q->post_flush_rq))
-		*rqp = NULL;
-
 	return 1;
 }
 
