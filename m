Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265938AbUGEESf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265938AbUGEESf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jul 2004 00:18:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265940AbUGEESe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jul 2004 00:18:34 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:63459 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S265938AbUGEESW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jul 2004 00:18:22 -0400
Date: Fri, 2 Jul 2004 22:12:16 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: linux-aio@kvack.org, linux-kernel@vger.kernel.org
Cc: linux-osdl@osdl.org
Subject: Re: [PATCH 21/22] fix: flush workqueue on put_ioctx
Message-ID: <20040702164216.GK3450@in.ibm.com>
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

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Lab, India
------------------------------------------------------

From: Chris Mason

While testing fsaio here, I hit an oops in kick_iocb because iocb->mm
was null.  This was right as the program was exiting.

With the patch below, I wasn't able to reproduce, it makes sure we flush
the workqueue every time __put_ioctx gets called.


 aio.c |    6 +-----
 1 files changed, 1 insertion(+), 5 deletions(-)

--- aio/fs/aio.c	2004-06-21 11:09:50.143627384 -0700
+++ aio-putioctx-flushworkqueue/fs/aio.c  2004-06-21 11:12:55.359470296 -0700
@@ -367,6 +367,7 @@ void fastcall __put_ioctx(struct kioctx 
 	if (unlikely(ctx->reqs_active))
 		BUG();
 
+	flush_workqueue(aio_wq);
 	aio_free_ring(ctx);
 	mmdrop(ctx->mm);
 	ctx->mm = NULL;
@@ -1205,11 +1206,6 @@ static void io_destroy(struct kioctx *io
 
 	aio_cancel_all(ioctx);
 	wait_for_all_aios(ioctx);
-	/*
-	 * this is an overkill, but ensures we don't leave
-	 * the ctx on the aio_wq
-	 */
-	flush_workqueue(aio_wq);
 	put_ioctx(ioctx);	/* once for the lookup */
 }
 
