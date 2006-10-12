Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751339AbWJLXyr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751339AbWJLXyr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 19:54:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751342AbWJLXyr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 19:54:47 -0400
Received: from mga01.intel.com ([192.55.52.88]:56388 "EHLO mga01.intel.com")
	by vger.kernel.org with ESMTP id S1751339AbWJLXyq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 19:54:46 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,301,1157353200"; 
   d="scan'208"; a="3367086:sNHT17869032"
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Zach Brown'" <zach.brown@oracle.com>,
       "'Suparna Bhattacharya'" <suparna@in.ibm.com>,
       "Lahaise, Benjamin C" <benjamin.c.lahaise@intel.com>
Cc: <linux-kernel@vger.kernel.org>, "'linux-aio'" <linux-aio@kvack.org>
Subject: [patch] remove redundant kioctx->users ref count
Date: Thu, 12 Oct 2006 16:54:46 -0700
Message-ID: <000201c6ee59$cba3fda0$db34030a@amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
Thread-Index: AcbuWcuGJWzd6r0TQwq7P0qcNUVr7w==
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In the ioctx destroy path, both exit_aio and io_destroy calls
wait_for_all_aios().  And in that function, it won't return until
there are no outstanding kiocb, tracked by ctx->reqs_active.  So
the ref counting on kioctx for every individual kiocb is overly
excessive.  We know we won't perform last put_ioctx when releasing
Kiocb. This should clear out the cache line conflict mentioned in
earlier post.


Signed-off-by: Ken Chen <kenneth.w.chen@intel.com>


diff -Nurp linux-2.6.18/fs/aio.c linux-2.6.18.ken/fs/aio.c
--- linux-2.6.18/fs/aio.c	2006-09-19 20:42:06.000000000 -0700
+++ linux-2.6.18.ken/fs/aio.c	2006-10-12 13:33:09.000000000 -0700
@@ -423,7 +422,6 @@ static struct kiocb fastcall *__aio_get_
 	ring = kmap_atomic(ctx->ring_info.ring_pages[0], KM_USER0);
 	if (ctx->reqs_active < aio_ring_avail(&ctx->ring_info, ring)) {
 		list_add(&req->ki_list, &ctx->active_reqs);
-		get_ioctx(ctx);
 		ctx->reqs_active++;
 		okay = 1;
 	}
@@ -534,8 +532,6 @@ int fastcall aio_put_req(struct kiocb *r
 	spin_lock_irq(&ctx->ctx_lock);
 	ret = __aio_put_req(ctx, req);
 	spin_unlock_irq(&ctx->ctx_lock);
-	if (ret)
-		put_ioctx(ctx);
 	return ret;
 }
 
@@ -791,8 +787,7 @@ static int __aio_run_iocbs(struct kioctx
 		 */
 		iocb->ki_users++;       /* grab extra reference */
 		aio_run_iocb(iocb);
-		if (__aio_put_req(ctx, iocb))  /* drop extra ref */
-			put_ioctx(ctx);
+		__aio_put_req(ctx, iocb);
  	}
 	if (!list_empty(&ctx->run_list))
 		return 1;
@@ -1015,9 +1010,6 @@ put_rq:
 	if (waitqueue_active(&ctx->wait))
 		wake_up(&ctx->wait);
 
-	if (ret)
-		put_ioctx(ctx);
-
 	return ret;
 }
 


