Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263020AbUGBQgZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263020AbUGBQgZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 12:36:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264649AbUGBQgZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 12:36:25 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:59550 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263020AbUGBQfM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 12:35:12 -0400
Date: Fri, 2 Jul 2004 22:14:37 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: linux-aio@kvack.org, linux-kernel@vger.kernel.org
Cc: linux-osdl@osdl.org
Subject: Re: [PATCH 22/22] Fix stalls with the AIO context switch patch
Message-ID: <20040702164437.GL3450@in.ibm.com>
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
> 
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
> FS AIO read
> [5] aio-wait-page.patch
> [6] aio-fs_read.patch
> [7] aio-upfront-readahead.patch
> 
> AIO for pipes
> [8] aio-cancel-fix.patch
> [9] aio-read-immediate.patch
> [10] aio-pipe.patch
> [11] aio-context-switch.patch
> 
> Concurrent O_SYNC write speedups using radix-tree walks
> [12] writepages-range.patch
> [13] fix-writeback-range.patch
> [14] fix-writepages-range.patch
> [15] fdatawrite-range.patch
> [16] O_SYNC-speedup.patch
> 
> AIO O_SYNC write
> [17] aio-wait_on_page_writeback_range.patch
> [18] aio-O_SYNC.patch
> [19] O_SYNC-write-fix.patch
> 
> AIO poll
> [20] aio-poll.patch
> 
> Infrastructure fixes
> [21] aio-putioctx-flushworkqueue.patch
> [22] aio-context-stall.patch
> 

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Lab, India
------------------------------------------------------

From:  Chris Mason

 aio.c |   39 +++++++++++++++++++++++++++++++++++----
 1 files changed, 35 insertions(+), 4 deletions(-)


--- aio/fs/aio.c	2004-06-21 13:35:34.024355464 -0700
+++ aio-context-stall/fs/aio.c	2004-06-21 13:50:59.246700288 -0700
@@ -367,6 +367,7 @@ void fastcall __put_ioctx(struct kioctx 
 	if (unlikely(ctx->reqs_active))
 		BUG();
 
+	cancel_delayed_work(&ctx->wq);
 	flush_workqueue(aio_wq);
 	aio_free_ring(ctx);
 	mmdrop(ctx->mm);
@@ -788,6 +789,22 @@ static int __aio_run_iocbs(struct kioctx
 	return 0;
 }
 
+static void aio_queue_work(struct kioctx * ctx)
+{
+	unsigned long timeout;
+	/* 
+	 * if someone is waiting, get the work started right
+	 * away, otherwise, use a longer delay
+	 */
+	smp_mb();
+	if (waitqueue_active(&ctx->wait))
+		timeout = 1;
+	else
+		timeout = HZ/10;
+	queue_delayed_work(aio_wq, &ctx->wq, timeout);
+}
+
+
 /*
  * aio_run_iocbs:
  * 	Process all pending retries queued on the ioctx
@@ -804,8 +821,18 @@ static inline void aio_run_iocbs(struct 
 	requeue = __aio_run_iocbs(ctx);
 	spin_unlock_irq(&ctx->ctx_lock);
 	if (requeue)
-		queue_work(aio_wq, &ctx->wq);
+		aio_queue_work(ctx);
+}
 
+/*
+ * just like aio_run_iocbs, but keeps running them until
+ * the list stays empty
+ */
+static inline void aio_run_all_iocbs(struct kioctx *ctx)
+{
+	spin_lock_irq(&ctx->ctx_lock);
+	while( __aio_run_iocbs(ctx));
+	spin_unlock_irq(&ctx->ctx_lock);
 }
  
 /*
@@ -830,6 +857,9 @@ static void aio_kick_handler(void *data)
  	unuse_mm(ctx->mm);
 	spin_unlock_irq(&ctx->ctx_lock);
 	set_fs(oldfs);
+	/*
+	 * we're in a worker thread already, don't use queue_delayed_work,
+	 */
 	if (requeue)
 		queue_work(aio_wq, &ctx->wq);
 }
@@ -852,7 +882,7 @@ void queue_kicked_iocb(struct kiocb *ioc
 	run = __queue_kicked_iocb(iocb);
 	spin_unlock_irqrestore(&ctx->ctx_lock, flags);
 	if (run) {
-		queue_delayed_work(aio_wq, &ctx->wq, HZ/10);
+		aio_queue_work(ctx);
 		aio_wakeups++;
 	}
 }
@@ -1119,7 +1149,7 @@ retry:
 	/* racey check, but it gets redone */
 	if (!retry && unlikely(!list_empty(&ctx->run_list))) {
 		retry = 1;
-		aio_run_iocbs(ctx);
+		aio_run_all_iocbs(ctx);
 		goto retry;
 	}
 
@@ -1522,7 +1552,8 @@ int fastcall io_submit_one(struct kioctx
 
 	spin_lock_irq(&ctx->ctx_lock);
 	list_add_tail(&req->ki_run_list, &ctx->run_list);
-	__aio_run_iocbs(ctx);
+	/* drain the run list */
+	while(__aio_run_iocbs(ctx));
 	spin_unlock_irq(&ctx->ctx_lock);
 	aio_put_req(req);	/* drop extra ref to req */
 	return 0;
