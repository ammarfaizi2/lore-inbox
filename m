Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267478AbUHEEfM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267478AbUHEEfM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 00:35:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267481AbUHEEfM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 00:35:12 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:47248 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S267478AbUHEEeL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 00:34:11 -0400
Date: Thu, 5 Aug 2004 10:13:40 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: akpm@osdl.org
Cc: linux-aio@kvack.org, linux-kernel@vger.kernel.org, mason@suse.com
Subject: Re: [PATCH 3/3] AIO workqueue context switch reduction
Message-ID: <20040805044340.GB4044@in.ibm.com>
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
> 
> [3] aio-context-switch.patch
>   AIO: Context switch reduction for retries (Chris Mason)
>   AIO: Fix IO stalls with context switch reduction changes
> 	(Chris Mason)
> 

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Lab, India

-------------------------------------------------------

From: Chris Mason

I compared the 2.6 pipetest results with the 2.4 suse kernel, and 2.6
was roughly 40% slower.  During the pipetest run, 2.6 generates ~600,000
context switches per second while 2.4 generates 30 or so.
                                                                                
aio-context-switch (attached) has a few changes that reduces our context
switch rate, and bring performance back up to 2.4 levels.  These have
only really been tested against pipetest, they might make other
workloads worse.
                                                                                
The basic theory behind the patch is that it is better for the userland
process to call run_iocbs than it is to schedule away and let the worker
thread do it.
                                                                                
1) on io_submit, use run_iocbs instead of run_iocb
2) on io_getevents, call run_iocbs if no events were available.
3) don't let two procs call run_iocbs for the same context at the same
time.  They just end up bouncing on spinlocks.
                                                                                
The first three optimizations got me down to 360,000 context switches
per second, and they help build a little structure to allow optimization
#4, which uses queue_delayed_work(HZ/10) instead of queue_work.
                                                                                
That brings down the number of context switches to 2.4 levels.

On Tue, 2004-02-24 at 13:32, Suparna Bhattacharya wrote:
> On more thought ...
> The aio-splice-runlist patch runs counter-purpose to some of
> your optimizations. I put that one in to avoid starvation when
> multiple ioctx's are in use. But it means that ctx->running
> doesn't ensure that it will process the new request we just put on
> the run-list.

The ctx->running optimization probably isn't critical.  It should be
enough to call run_iocbs from io_submit_one and getevents, which will
help make sure the process does its own retries whenever possible.
                                                                                
Doing the run_iocbs from getevents is what makes the queue_delayed_work
possible, since someone waiting on an event won't have to wait the extra
HZ/10 for the worker thread to schedule in.

Wow, 15% slower with ctx->running removed, but the number of context
switches is stays nice and low.  We can play with ctx->running
variations later, here's a patch without them.  It should be easier to
apply with the rest of your code.

DESC
AIO: Fix IO stalls with context switch reduction changes
EDESC
From:  Chris Mason

Here's another attempt.  You will still need the cancel_delayed_work()
incremental from last week.  This patch makes two basic changes:

queue work with a timeout of 1 jiffie when someone is waiting for events
to complete, use a longer timeout when there are no waiters.  This keeps
the context switch rate nice and low during pipetest (30 switches per
second instead of 2000), but should reduce stalling when there are
waiters.

Adds aio_run_all_iocbs so that normal processes can run all the pending
retries on the run list.  This allows worker threads to keep using list
splicing, but regular procs get to run the list until it stays empty. 
The end result should be less work for the worker threads.

I was able to trigger short stalls (1sec) with aio-stress, and with the
current patch they are gone.  Could be wishful thinking on my part
though, please let me know how this works for you.

-chris



 linux-2.6.8-rc3-suparna/fs/aio.c |   51 +++++++++++++++++++++++++++++++++------
 1 files changed, 44 insertions(+), 7 deletions(-)

diff -puN fs/aio.c~aio-context-switch fs/aio.c
--- linux-2.6.8-rc3/fs/aio.c~aio-context-switch	2004-08-04 14:31:35.000000000 +0530
+++ linux-2.6.8-rc3-suparna/fs/aio.c	2004-08-04 14:31:35.000000000 +0530
@@ -368,6 +368,7 @@ void fastcall __put_ioctx(struct kioctx 
 	if (unlikely(ctx->reqs_active))
 		BUG();
 
+	cancel_delayed_work(&ctx->wq);
 	flush_workqueue(aio_wq);
 	aio_free_ring(ctx);
 	mmdrop(ctx->mm);
@@ -795,6 +796,22 @@ static int __aio_run_iocbs(struct kioctx
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
@@ -811,8 +828,18 @@ static inline void aio_run_iocbs(struct 
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
@@ -837,6 +864,9 @@ static void aio_kick_handler(void *data)
  	unuse_mm(ctx->mm);
 	spin_unlock_irq(&ctx->ctx_lock);
 	set_fs(oldfs);
+	/*
+	 * we're in a worker thread already, don't use queue_delayed_work,
+	 */
 	if (requeue)
 		queue_work(aio_wq, &ctx->wq);
 }
@@ -859,7 +889,7 @@ void queue_kicked_iocb(struct kiocb *ioc
 	run = __queue_kicked_iocb(iocb);
 	spin_unlock_irqrestore(&ctx->ctx_lock, flags);
 	if (run) {
-		queue_work(aio_wq, &ctx->wq);
+		aio_queue_work(ctx);
 		aio_wakeups++;
 	}
 }
@@ -1088,13 +1118,14 @@ static int read_events(struct kioctx *ct
 	struct io_event		ent;
 	struct timeout		to;
 	int 			event_loop = 0; /* testing only */
+	int			retry = 0;
 
 	/* needed to zero any padding within an entry (there shouldn't be 
 	 * any, but C is fun!
 	 */
 	memset(&ent, 0, sizeof(ent));
+retry:
 	ret = 0;
-
 	while (likely(i < nr)) {
 		ret = aio_read_evt(ctx, &ent);
 		if (unlikely(ret <= 0))
@@ -1123,6 +1154,13 @@ static int read_events(struct kioctx *ct
 
 	/* End fast path */
 
+	/* racey check, but it gets redone */
+	if (!retry && unlikely(!list_empty(&ctx->run_list))) {
+		retry = 1;
+		aio_run_all_iocbs(ctx);
+		goto retry;
+	}
+
 	init_timeout(&to);
 	if (timeout) {
 		struct timespec	ts;
@@ -1503,11 +1541,10 @@ int fastcall io_submit_one(struct kioctx
 		goto out_put_req;
 
 	spin_lock_irq(&ctx->ctx_lock);
-	ret = aio_run_iocb(req);
+	list_add_tail(&req->ki_run_list, &ctx->run_list);
+	/* drain the run list */
+	while(__aio_run_iocbs(ctx));
 	spin_unlock_irq(&ctx->ctx_lock);
-
-	if (-EIOCBRETRY == ret)
-		queue_work(aio_wq, &ctx->wq);
 	aio_put_req(req);	/* drop extra ref to req */
 	return 0;
 

_
