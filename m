Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265597AbTFRWnu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 18:43:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265584AbTFRWn0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 18:43:26 -0400
Received: from palrel13.hp.com ([156.153.255.238]:28308 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S265597AbTFRWmo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 18:42:44 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16112.60959.588900.824473@napali.hpl.hp.com>
Date: Wed, 18 Jun 2003 15:56:31 -0700
To: neilb@cse.unsw.edu.au
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       davidm@napali.hpl.hp.com
Subject: make NFS work with 64KB page-size
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

NFS currently bugs out on kernels with a page size of 64KB.  The
reason is a mismatch between RPCSVC_MAXPAGES and a calculation in
svc_init_buffer().  I'm not entirely certain which calculation is the
right one, but if I understand the code correctly, RPCSVC_MAXPAGES is
right and svc_init_buffer() is wrong.  The patch below fixes the
latter.

If the patch looks right, could you make sure it finds its way into
Linus' tree?

Thanks,

	--david

===== net/sunrpc/svc.c 1.20 vs edited =====
--- 1.20/net/sunrpc/svc.c	Fri Feb  7 12:25:20 2003
+++ edited/net/sunrpc/svc.c	Wed Jun 18 15:02:19 2003
@@ -111,7 +111,7 @@
 static int
 svc_init_buffer(struct svc_rqst *rqstp, unsigned int size)
 {
-	int pages = 2 + (size+ PAGE_SIZE -1) / PAGE_SIZE;
+	int pages = 1 + (size+ PAGE_SIZE -1) / PAGE_SIZE;
 	int arghi;
 	
 	rqstp->rq_argused = 0;
