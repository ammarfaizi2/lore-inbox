Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265932AbUGEES1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265932AbUGEES1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jul 2004 00:18:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265943AbUGEES1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jul 2004 00:18:27 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:2293 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S265932AbUGEESW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jul 2004 00:18:22 -0400
Date: Fri, 2 Jul 2004 18:45:28 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: linux-aio@kvack.org, linux-kernel@vger.kernel.org
Cc: linux-osdl@osdl.org
Subject: Re: [PATCH 4/22] Splice ioctx runlist for fairness
Message-ID: <20040702131528.GD4374@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <20040702130030.GA4256@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040702130030.GA4256@in.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 02, 2004 at 06:30:30PM +0530, Suparna Bhattacharya wrote:
> The patchset contains modifications and fixes to the AIO core
> to support the full retry model, an implementation of AIO
> support for buffered filesystem AIO reads and O_SYNC writes
> (the latter courtesy O_SYNC speedup changes from Andrew Morton),
> an implementation of AIO reads and writes to pipes (from
> Chris Mason) and AIO poll (again from Chris Mason).
> 
> Full retry infrastructure and fixes
> [1] aio-retry.patch
> [2] 4g4g-aio-hang-fix.patch
> [3] aio-retry-elevated-refcount.patch
> [4] aio-splice-runlist.patch
> 
-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Lab, India

From: Suparna Bhattacharya <suparna@in.ibm.com>

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
recreate it consistently, but may be worth trying out.


 aio.c |   26 ++++++++++++++++++++------
 1 files changed, 20 insertions(+), 6 deletions(-)

--- linux-2.6.7/fs/aio.c	2004-06-23 15:42:43.791869120 -0700
+++ aio/fs/aio.c	2004-06-23 15:43:58.833461064 -0700
@@ -761,13 +761,15 @@ out:
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
@@ -780,6 +782,9 @@ static void __aio_run_iocbs(struct kioct
 		count++;
  	}
 	aio_run++;
+	if (!list_empty(&ctx->run_list))
+		return 1;
+	return 0;
 }
 
 /*
@@ -791,9 +796,15 @@ static void __aio_run_iocbs(struct kioct
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
@@ -809,14 +820,17 @@ static void aio_kick_handler(void *data)
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
  
 
