Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262771AbTJUKTs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 06:19:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262772AbTJUKTs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 06:19:48 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:40926 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262771AbTJUKTo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 06:19:44 -0400
Date: Tue, 21 Oct 2003 15:55:14 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: akpm@osdl.org
Cc: linux-aio@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH][2.6-mm] Avoid flushing AIO workqueue on cancel/exit
Message-ID: <20031021102514.GA4217@in.ibm.com>
Reply-To: suparna@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When streaming AIO requests are in progress on multiple
io context's, flushing the AIO workqueue on i/o cancellation
or process exit could potentially end up waiting for a 
long time as fresh requests from other active ioctx's keep 
getting queued up. I haven't run into this in practice, 
but it looks like a problem.

Instead, this patch increments the ioctx reference count
before queueing up a retry, ensuring that the ioctx 
doesn't go away until the workqueue handler is done with
processing the ioctx and releases its reference to it.
Note: This does mean that exit_mmap can happen before the 
last reference to the ioctx is gone, but only after all 
iocbs have completed using the caller's mm.

Regards
Suparna

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Labs, India

diffstat aio-undo-flushworkqueue.patch

 aio.c |   28 ++++++++++++----------------
 1 files changed, 12 insertions(+), 16 deletions(-)

diff -urp linux-2.6.0-test6-mm4/fs/aio.c 260t6mm4/fs/aio.c
--- linux-2.6.0-test6-mm4/fs/aio.c	Tue Oct 21 19:20:50 2003
+++ 260t6mm4/fs/aio.c	Tue Oct 21 19:09:26 2003
@@ -63,6 +63,12 @@ LIST_HEAD(fput_head);
 
 static void aio_kick_handler(void *);
 
+static inline void queue_ctx_work(struct kioctx *ctx)
+{
+	get_ioctx(ctx);
+	queue_work(aio_wq, &ctx->wq);
+}
+
 /* aio_setup
  *	Creates the slab caches used by the aio routines, panic on
  *	failure as this is done early during the boot sequence.
@@ -349,15 +355,9 @@ void exit_aio(struct mm_struct *mm)
 		aio_cancel_all(ctx);
 
 		wait_for_all_aios(ctx);
-		/*
-		 * this is an overkill, but ensures we don't leave
-		 * the ctx on the aio_wq
-		 */
-		flush_workqueue(aio_wq);
 
 		if (1 != atomic_read(&ctx->users))
-			printk(KERN_DEBUG
-				"exit_aio:ioctx still alive: %d %d %d\n",
+			pr_debug("exit_aio:ioctx still alive: %d %d %d\n",
 				atomic_read(&ctx->users), ctx->dead,
 				ctx->reqs_active);
 		put_ioctx(ctx);
@@ -807,7 +812,7 @@ static inline void aio_run_iocbs(struct 
 	requeue = __aio_run_iocbs(ctx);
 	spin_unlock_irq(&ctx->ctx_lock);
 	if (requeue)
-		queue_work(aio_wq, &ctx->wq);
+		queue_ctx_work(ctx);
 }
 
 /*
@@ -833,7 +838,8 @@ static void aio_kick_handler(void *data)
 	spin_unlock_irq(&ctx->ctx_lock);
 	set_fs(oldfs);
 	if (requeue)
-		queue_work(aio_wq, &ctx->wq);
+		queue_ctx_work(ctx);
+	put_ioctx(ctx);
 }
 
 
@@ -854,7 +860,7 @@ void queue_kicked_iocb(struct kiocb *ioc
 	run = __queue_kicked_iocb(iocb);
 	spin_unlock_irqrestore(&ctx->ctx_lock, flags);
 	if (run) {
-		queue_work(aio_wq, &ctx->wq);
+		queue_ctx_work(ctx);
 		aio_wakeups++;
 	}
 }
@@ -1201,11 +1207,6 @@ static void io_destroy(struct kioctx *io
 
 	aio_cancel_all(ioctx);
 	wait_for_all_aios(ioctx);
-	/*
-	 * this is an overkill, but ensures we don't leave
-	 * the ctx on the aio_wq
-	 */
-	flush_workqueue(aio_wq);
 	put_ioctx(ioctx);	/* once for the lookup */
 }
 
@@ -1524,7 +1525,7 @@ int io_submit_one(struct kioctx *ctx, st
 	spin_unlock_irq(&ctx->ctx_lock);
 
 	if (-EIOCBRETRY == ret)
-		queue_work(aio_wq, &ctx->wq);
+		queue_ctx_work(ctx);
 
 	if (need_putctx)
 		put_ioctx(ctx);
