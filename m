Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267477AbUHEEc0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267477AbUHEEc0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 00:32:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267478AbUHEEc0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 00:32:26 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:24521 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S267477AbUHEEcO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 00:32:14 -0400
Date: Thu, 5 Aug 2004 10:11:44 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: akpm@osdl.org
Cc: linux-aio@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] AIO Splice runlist for fairness across io contexts
Message-ID: <20040805044144.GA4044@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <20040805043301.GA3532@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040805043301.GA3532@in.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 05, 2004 at 10:03:01AM +0530, Suparna Bhattacharya wrote:
> [2] aio-splice-runlist.patch
>   AIO: Splice runlist to be fairer across multiple io contexts
> 

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Lab, India

---------------------------------------------------

This patch tries be a little fairer across multiple io contexts in handling
retries, helping make sure progress happens uniformly across different io
contexts (especially if they are acting on independent queues).

It splices the ioctx runlist before processing it in __aio_run_iocbs.  If
new iocbs get added to the ctx in meantime, it queues a fresh workqueue
entry instead of handling them righaway, so that other ioctxs' retries get
a chance to be processed before the newer entries in the queue.

This might make a difference in a situation where retries are getting
queued very fast on one ioctx, while the workqueue entry for another ioctx
is stuck behind it.  I've only seen this occasionally earlier and can't
recreate it consistently, but may be worth including anyway.



 linux-2.6.8-rc3-suparna/fs/aio.c |   26 ++++++++++++++++++++------
 1 files changed, 20 insertions(+), 6 deletions(-)

diff -puN fs/aio.c~aio-splice-runlist fs/aio.c
--- linux-2.6.8-rc3/fs/aio.c~aio-splice-runlist	2004-08-04 14:31:29.000000000 +0530
+++ linux-2.6.8-rc3-suparna/fs/aio.c	2004-08-04 14:31:29.000000000 +0530
@@ -769,13 +769,15 @@ out:
  * Assumes it is operating within the aio issuer's mm
  * context. Expects to be called with ctx->ctx_lock held
  */
-static void __aio_run_iocbs(struct kioctx *ctx)
+static int __aio_run_iocbs(struct kioctx *ctx)
 {
 	struct kiocb *iocb;
 	int count = 0;
+	LIST_HEAD(run_list);
 
-	while (!list_empty(&ctx->run_list)) {
-		iocb = list_entry(ctx->run_list.next, struct kiocb,
+	list_splice_init(&ctx->run_list, &run_list);
+	while (!list_empty(&run_list)) {
+		iocb = list_entry(run_list.next, struct kiocb,
 			ki_run_list);
 		list_del(&iocb->ki_run_list);
 		/*
@@ -788,6 +790,9 @@ static void __aio_run_iocbs(struct kioct
 		count++;
  	}
 	aio_run++;
+	if (!list_empty(&ctx->run_list))
+		return 1;
+	return 0;
 }
 
 /*
@@ -799,9 +804,15 @@ static void __aio_run_iocbs(struct kioct
  */
 static inline void aio_run_iocbs(struct kioctx *ctx)
 {
+	int requeue;
+
 	spin_lock_irq(&ctx->ctx_lock);
-	__aio_run_iocbs(ctx);
- 	spin_unlock_irq(&ctx->ctx_lock);
+
+	requeue = __aio_run_iocbs(ctx);
+	spin_unlock_irq(&ctx->ctx_lock);
+	if (requeue)
+		queue_work(aio_wq, &ctx->wq);
+
 }
 
 /*
@@ -817,14 +828,17 @@ static void aio_kick_handler(void *data)
 {
 	struct kioctx *ctx = data;
 	mm_segment_t oldfs = get_fs();
+	int requeue;
 
 	set_fs(USER_DS);
 	use_mm(ctx->mm);
 	spin_lock_irq(&ctx->ctx_lock);
-	__aio_run_iocbs(ctx);
+	requeue =__aio_run_iocbs(ctx);
  	unuse_mm(ctx->mm);
 	spin_unlock_irq(&ctx->ctx_lock);
 	set_fs(oldfs);
+	if (requeue)
+		queue_work(aio_wq, &ctx->wq);
 }
 
 

_
