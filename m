Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264502AbUGBNMX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264502AbUGBNMX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 09:12:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264500AbUGBNMV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 09:12:21 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:48024 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264524AbUGBNLG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 09:11:06 -0400
Date: Fri, 2 Jul 2004 18:50:40 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: linux-aio@kvack.org, linux-kernel@vger.kernel.org
Cc: linux-osdl@osdl.org
Subject: Re: [PATCH 8/22] AIO cancellation fix
Message-ID: <20040702132040.GH4374@in.ibm.com>
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
> Its been a while since I last posted the retry based AIO patches
> that I've been accumulating. Janet Morgan recently brought
> the whole patchset up-to to 2.6.7.
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

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Lab, India

-----------------------------------

From: Chris Mason <mason@suse.com>

Fix for sys_io_cancel to work properly with retries when a cancel
method is specified for an iocb. Needed with pipe AIO support. 

There's a bug in my aio cancel patch, aio_complete still makes an event
for cancelled iocbs.  If nobody asks for this event, we effectively leak
space in the event ring buffer.  I've attached a new aio_cancel patch
that just skips the event creation for canceled iocbs.


 aio.c |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletion(-)

--- aio/fs/aio.c	2004-06-18 06:10:37.941166456 -0700
+++ aio-cancel-fix/fs/aio.c	2004-06-18 09:24:28.905991040 -0700
@@ -932,6 +932,13 @@ int fastcall aio_complete(struct kiocb *
 	if (iocb->ki_run_list.prev && !list_empty(&iocb->ki_run_list))
 		list_del_init(&iocb->ki_run_list);
 
+	/*
+	 * cancelled requests don't get events, userland was given one
+	 * when the event got cancelled.
+	 */ 
+	if (kiocbIsCancelled(iocb))
+		goto put_rq;
+
 	ring = kmap_atomic(info->ring_pages[0], KM_IRQ1);
 
 	tail = info->tail;
@@ -964,7 +971,7 @@ int fastcall aio_complete(struct kiocb *
 		iocb->ki_retried,
 		iocb->ki_nbytes - iocb->ki_left, iocb->ki_nbytes,
 		iocb->ki_kicked, iocb->ki_queued, aio_run, aio_wakeups);
-
+put_rq:
 	/* everything turned out well, dispose of the aiocb. */
 	ret = __aio_put_req(ctx, iocb);
 
@@ -1611,6 +1618,7 @@ asmlinkage long sys_io_cancel(aio_contex
 	if (kiocb && kiocb->ki_cancel) {
 		cancel = kiocb->ki_cancel;
 		kiocb->ki_users ++;
+		kiocbSetCancelled(kiocb);
 	} else
 		cancel = NULL;
 	spin_unlock_irq(&ctx->ctx_lock);
