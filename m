Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262522AbTJAUvx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 16:51:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262525AbTJAUvx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 16:51:53 -0400
Received: from fw.osdl.org ([65.172.181.6]:48060 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262522AbTJAUvv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 16:51:51 -0400
Subject: [PATCH 2.6.0-test6-mm1] aio ref count in io_submit_one updated
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
Content-Type: multipart/mixed; boundary="=-w35UmDByRJ79ns4quFko"
Organization: 
Message-Id: <1065041501.1939.7.camel@ibm-c.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 01 Oct 2003 13:51:41 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-w35UmDByRJ79ns4quFko
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, 2003-10-01 at 01:46, Suparna Bhattacharya wrote:

> I haven't looked very closely, but am just wondering why you ignore 
> the return value of __aio_put_req here - are you sure there is no 
> potential memory leakage (could be missing a put_ioctx) as a result ? 


You are right.  I didn't look closely enough.  I thought the only
difference between aio_put_req() and __aio_put_req() was the lock
already being help.  I missed the put_ioctx().  So here is the
updated patch.  This also runs on my 2-proc with CONFIG_DEBUG_PAGEALLOC
without oops'ing.

I'm still looking at the retry case and I will send out a patch for
that when I'm done.

Thanks,

Daniel



--=-w35UmDByRJ79ns4quFko
Content-Disposition: attachment; filename=2.6.0-test6-mm1.aio_ref_count.patch
Content-Type: text/plain; name=2.6.0-test6-mm1.aio_ref_count.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- linux-2.6.0-test6-mm1/fs/aio.c	2003-09-30 14:47:51.000000000 -0700
+++ linux-2.6.0-test6-mm1.aio/fs/aio.c	2003-10-01 13:42:25.091744710 -0700
@@ -1431,6 +1431,7 @@ int io_submit_one(struct kioctx *ctx, st
 	struct kiocb *req;
 	struct file *file;
 	ssize_t ret;
+	int need_putctx;
 
 	/* enforce forwards compatibility on users */
 	if (unlikely(iocb->aio_reserved1 || iocb->aio_reserved2 ||
@@ -1490,16 +1491,26 @@ int io_submit_one(struct kioctx *ctx, st
 		goto out_put_req;
 
 	spin_lock_irq(&ctx->ctx_lock);
+	/*
+	 * Hold an extra reference while submitting the i/o.
+	 * This prevents races between the aio code path referencing the
+	 * req (after submitting it) and aio_complete() freeing the req.
+	 */
+	req->ki_users++;			/* grab extra reference */
 	ret = aio_run_iocb(req);
+	need_putctx = __aio_put_req(ctx, req);	/* drop the extra reference */	
 	spin_unlock_irq(&ctx->ctx_lock);
 
 	if (-EIOCBRETRY == ret)
 		queue_work(aio_wq, &ctx->wq);
 
+	if (need_putctx)
+		put_ioctx(ctx);
+
 	return 0;
 
 out_put_req:
-	aio_put_req(req);
+	(void)aio_put_req(req);
 	return ret;
 }
 

--=-w35UmDByRJ79ns4quFko--

