Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261193AbTJCVTY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Oct 2003 17:19:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261214AbTJCVTY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Oct 2003 17:19:24 -0400
Received: from fw.osdl.org ([65.172.181.6]:8397 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261193AbTJCVTV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Oct 2003 17:19:21 -0400
Subject: PATCH 2.6.0-test6-mm2] aio ref count during retry
From: Daniel McNeil <daniel@osdl.org>
To: Suparna Bhattacharya <suparna@in.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, "linux-aio@kvack.org" <linux-aio@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20031001084639.GA4188@in.ibm.com>
References: <1064596018.1950.10.camel@ibm-c.pdx.osdl.net>
	 <1064620762.2115.29.camel@ibm-c.pdx.osdl.net>
	 <20030929040935.GA3637@in.ibm.com> <20030929131057.GA4630@in.ibm.com>
	 <1064876358.23108.41.camel@ibm-c.pdx.osdl.net>
	 <20030930040020.GA3435@in.ibm.com>
	 <1064964169.1922.16.camel@ibm-c.pdx.osdl.net>
	 <20031001084639.GA4188@in.ibm.com>
Content-Type: multipart/mixed; boundary="=-jFRfvoTYzA7UqpuMwHmx"
Organization: 
Message-Id: <1065215946.1862.164.camel@ibm-c.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 03 Oct 2003 14:19:06 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-jFRfvoTYzA7UqpuMwHmx
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, 2003-10-01 at 01:46, Suparna Bhattacharya wrote:
> Although this isn't a problem with retry-based AIO (where we always
> call aio_complete() from the calling routine, so should never see
> the iocb going away underneath us), if we do add the ref count 
> increment, we should probably try to do it for both the initial
> submission and subsequent retries --- just in case we have code
> (in future) that uses a combination of retries and aio completion
> from interrupt context.
> 
> Regards
> Suparna

Andrew and Suparna,


Here is the patch for AIO retry to hold an extra ref count.
The patch is small, but I wanted to make sure it was safe.
I spent time looking over the retry code and this patch looks
ok to me.  It is potentially calling put_ioctx() while holding
ctx->ctx_lock, I do not think that will cause any problems.
This should never be the last reference on the ioctx anyway,
since the loop is checking list_empty(&ctx->run_list).  The
first ref is taken in sys_io_setup() and last removed in
io_destroy(). It also looks like holding ctx->ctx_lock prevents
any races between any retries and an io_destroy() which would
try to cancel all iocbs.

I've tested this on my 2-proc by coping a raw partitions and
copying ext3 files using using AIO and O_DIRECT, O_SYNC, and both.

Thoughts?

Daniel

--=-jFRfvoTYzA7UqpuMwHmx
Content-Disposition: attachment; filename=2.6.0-test6-mm2.aio_retry_ref_count.patch
Content-Type: text/plain; name=2.6.0-test6-mm2.aio_retry_ref_count.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- linux-2.6.0-test6-mm2/fs/aio.c	2003-10-03 10:45:39.000000000 -0700
+++ linux-2.6.0-test6-mm2.aio/fs/aio.c	2003-10-03 11:26:26.894495149 -0700
@@ -771,12 +771,20 @@ static void __aio_run_iocbs(struct kioct
 	struct kiocb *iocb;
 	ssize_t ret;
 	int count = 0;
+	int need_putctx;
 
 	while (!list_empty(&ctx->run_list)) {
 		iocb = list_entry(ctx->run_list.next, struct kiocb,
 			ki_run_list);
 		list_del(&iocb->ki_run_list);
+		/*
+		 * Hold an extra reference while retrying i/o.
+		 */
+		iocb->ki_users++;	/* grab extra reference */
 		ret = aio_run_iocb(iocb);
+		need_putctx = __aio_put_req(ctx, iocb);  /* drop extra ref */
+		if (need_putctx)
+			put_ioctx(ctx);
 		count++;
 	}
 	aio_run++;

--=-jFRfvoTYzA7UqpuMwHmx--

