Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264405AbUGBNCF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264405AbUGBNCF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 09:02:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264500AbUGBNCF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 09:02:05 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:54146 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264501AbUGBNBn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 09:01:43 -0400
Date: Fri, 2 Jul 2004 18:41:18 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: linux-aio@kvack.org, linux-kernel@vger.kernel.org
Cc: linux-osdl@osdl.org
Subject: Re: [PATCH 2/22] use_mm fix (helps AIO hangs on 4:4 split)
Message-ID: <20040702131118.GB4374@in.ibm.com>
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

As Christoph Hellwig pointed out, though the problem originally
surfaced as hangs with retry and 4G-4G, the fixes here are generic
and apply irrespective of 4:4.

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Lab, India

--------------------------------------------
From: Suparna Bhattacharya <suparna@in.ibm.com>

This patch appears to fix the hangs seen with AIO and 4G-4G for me.  It
ensures that the indirect versions of copy_xxx_user are used during aio
retries running in worker thread context (i.e.  access aio issuer's
user-space instead of kernel-space).


 fs/aio.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletion(-)

--- aio/fs/aio.c	2004-06-17 10:58:34.596512112 -0700
+++ 4g4g-aio-hang-fix/fs/aio.c	2004-06-17 12:29:35.380346784 -0700
@@ -795,18 +795,23 @@ static inline void aio_run_iocbs(struct 
  * aio_kick_handler:
  * 	Work queue handler triggered to process pending
  * 	retries on an ioctx. Takes on the aio issuer's
- * 	mm context before running the iocbs.
+ *	mm context before running the iocbs, so that
+ *	copy_xxx_user operates on the issuer's address
+ *      space.
  * Run on aiod's context.
  */
 static void aio_kick_handler(void *data)
 {
 	struct kioctx *ctx = data;
+	mm_segment_t oldfs = get_fs();
 
+	set_fs(USER_DS);
 	use_mm(ctx->mm);
 	spin_lock_irq(&ctx->ctx_lock);
 	__aio_run_iocbs(ctx);
  	unuse_mm(ctx->mm);
 	spin_unlock_irq(&ctx->ctx_lock);
+	set_fs(oldfs);
 }
  
 
