Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264522AbUGBNR5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264522AbUGBNR5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 09:17:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264519AbUGBNRS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 09:17:18 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:45304 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S264540AbUGBNQm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 09:16:42 -0400
Date: Fri, 2 Jul 2004 18:56:18 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: linux-aio@kvack.org, linux-kernel@vger.kernel.org
Cc: linux-osdl@osdl.org
Subject: Re: [PATCH 11/22] Reduce AIO worker context switches 
Message-ID: <20040702132618.GK4374@in.ibm.com>
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

Should also apply aio-context-stall (later in the patchset)

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Lab, India
-----------------------------------------------


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


 aio.c |   18 ++++++++++++------
 1 files changed, 12 insertions(+), 6 deletions(-)

--- aio/fs/aio.c	2004-06-18 09:48:00.712363848 -0700
+++ aio-context-switch.patch/fs/aio.c	2004-06-18 10:01:52.963842392 -0700
@@ -851,7 +851,7 @@ void queue_kicked_iocb(struct kiocb *ioc
 	run = __queue_kicked_iocb(iocb);
 	spin_unlock_irqrestore(&ctx->ctx_lock, flags);
 	if (run) {
-		queue_work(aio_wq, &ctx->wq);
+		queue_delayed_work(aio_wq, &ctx->wq, HZ/10);
 		aio_wakeups++;
 	}
 }
@@ -1079,13 +1079,14 @@ static int read_events(struct kioctx *ct
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
@@ -1114,6 +1115,13 @@ static int read_events(struct kioctx *ct
 
 	/* End fast path */
 
+	/* racey check, but it gets redone */
+	if (!retry && unlikely(!list_empty(&ctx->run_list))) {
+		retry = 1;
+		aio_run_iocbs(ctx);
+		goto retry;
+	}
+
 	init_timeout(&to);
 	if (timeout) {
 		struct timespec	ts;
@@ -1505,11 +1513,9 @@ int fastcall io_submit_one(struct kioctx
 		goto out_put_req;
 
 	spin_lock_irq(&ctx->ctx_lock);
-	ret = aio_run_iocb(req);
+	list_add_tail(&req->ki_run_list, &ctx->run_list);
+	__aio_run_iocbs(ctx);
 	spin_unlock_irq(&ctx->ctx_lock);
-
-	if (-EIOCBRETRY == ret)
-		queue_work(aio_wq, &ctx->wq);
 	aio_put_req(req);	/* drop extra ref to req */
 	return 0;
 
