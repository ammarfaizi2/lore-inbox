Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261776AbTI3XXK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 19:23:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261787AbTI3XXK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 19:23:10 -0400
Received: from fw.osdl.org ([65.172.181.6]:60815 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261776AbTI3XXF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 19:23:05 -0400
Subject: [PATCH 2.6.0-test6-mm1] aio ref count in io_submit_one
From: Daniel McNeil <daniel@osdl.org>
To: Suparna Bhattacharya <suparna@in.ibm.com>, Andrew Morton <akpm@osdl.org>
Cc: "linux-aio@kvack.org" <linux-aio@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030930040020.GA3435@in.ibm.com>
References: <1064596018.1950.10.camel@ibm-c.pdx.osdl.net>
	 <1064620762.2115.29.camel@ibm-c.pdx.osdl.net>
	 <20030929040935.GA3637@in.ibm.com> <20030929131057.GA4630@in.ibm.com>
	 <1064876358.23108.41.camel@ibm-c.pdx.osdl.net>
	 <20030930040020.GA3435@in.ibm.com>
Content-Type: multipart/mixed; boundary="=-CRXfrQWoEnwHgMkbkpHp"
Organization: 
Message-Id: <1064964169.1922.16.camel@ibm-c.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 30 Sep 2003 16:22:49 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-CRXfrQWoEnwHgMkbkpHp
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Andrew and Suparna,

Here is a patch to hold an extra reference count on the AIO request iocb
while it is being submitted and then drop it ref before returning.
This prevents the race I was seeing with AIO O_DIRECT tests on ext3
where the aio_complete() was freeing the iocb while it was still
be referenced by the AIO submit code path.  I've run this on my
2-proc box with CONFIG_DEBUG_PAGEALLOC on and I no longer hit
the oops.  The other option is to change the AIO code to never
reference the iocb after it has been submitted, but that seems more
error prone.  This patch is a very small change. I am surprised we have
not seen this race before. 

Thoughts?

Daniel



--=-CRXfrQWoEnwHgMkbkpHp
Content-Disposition: attachment; filename=2.6.0-test6-mm1.aio_ref_count.patch
Content-Type: text/plain; name=2.6.0-test6-mm1.aio_ref_count.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- linux-2.6.0-test6-mm1/fs/aio.c	2003-09-30 14:47:51.000000000 -0700
+++ linux-2.6.0-test6-mm1.aio/fs/aio.c	2003-09-30 16:03:08.702783397 -0700
@@ -1490,7 +1490,14 @@ int io_submit_one(struct kioctx *ctx, st
 		goto out_put_req;
 
 	spin_lock_irq(&ctx->ctx_lock);
+	/*
+	 * Hold an extra reference while submitting the i/o.
+	 * This prevents races between the aio code path referencing the
+	 * req (after submitting it) and aio_complete() freeing the req.
+	 */
+	req->ki_users++;		/* grab extra reference */
 	ret = aio_run_iocb(req);
+	(void)__aio_put_req(ctx, req);	/* drop the extra reference */	
 	spin_unlock_irq(&ctx->ctx_lock);
 
 	if (-EIOCBRETRY == ret)

--=-CRXfrQWoEnwHgMkbkpHp--

