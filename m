Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264358AbUGBNEt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264358AbUGBNEt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 09:04:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264414AbUGBNEt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 09:04:49 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:60881 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S264358AbUGBNEq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 09:04:46 -0400
Date: Fri, 2 Jul 2004 18:44:20 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: linux-aio@kvack.org, linux-kernel@vger.kernel.org
Cc: linux-osdl@osdl.org
Subject: Re: [PATCH 3/22] Refcounting fixes
Message-ID: <20040702131420.GC4374@in.ibm.com>
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

Refcounting fixes from Daniel McNeil.

Regards
Suparna
-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Lab, India


From: Daniel McNeil <daniel@osdl.org>

Here is the patch for AIO retry to hold an extra ref count.  The patch is
small, but I wanted to make sure it was safe.

I spent time looking over the retry code and this patch looks ok to me.  It
is potentially calling put_ioctx() while holding ctx->ctx_lock, I do not
think that will cause any problems.  This should never be the last reference
on the ioctx anyway, since the loop is checking list_empty(&ctx->run_list). 
The first ref is taken in sys_io_setup() and last removed in io_destroy(). 
It also looks like holding ctx->ctx_lock prevents any races between any
retries and an io_destroy() which would try to cancel all iocbs.

I've tested this on my 2-proc by coping a raw partitions and copying ext3
files using using AIO and O_DIRECT, O_SYNC, and both.


 fs/aio.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

--- aio/fs/aio.c	2004-06-17 12:37:49.946161352 -0700
+++ aio-retry-elevated-refcount/fs/aio.c	2004-06-17 13:12:07.795320728 -0700
@@ -764,14 +764,19 @@ out:
 static void __aio_run_iocbs(struct kioctx *ctx)
 {
 	struct kiocb *iocb;
-	ssize_t ret;
 	int count = 0;
 
 	while (!list_empty(&ctx->run_list)) {
 		iocb = list_entry(ctx->run_list.next, struct kiocb,
 			ki_run_list);
 		list_del(&iocb->ki_run_list);
-		ret = aio_run_iocb(iocb);
+		/*
+		 * Hold an extra reference while retrying i/o.
+		 */
+		iocb->ki_users++;       /* grab extra reference */
+		aio_run_iocb(iocb);
+		if (__aio_put_req(ctx, iocb))  /* drop extra ref */
+			put_ioctx(ctx);
 		count++;
  	}
 	aio_run++;
