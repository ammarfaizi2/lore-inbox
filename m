Return-Path: <linux-kernel-owner+w=401wt.eu-S932967AbWLSV7k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932967AbWLSV7k (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 16:59:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932990AbWLSV7k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 16:59:40 -0500
Received: from mga03.intel.com ([143.182.124.21]:2197 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932967AbWLSV7j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 16:59:39 -0500
X-Greylist: delayed 618 seconds by postgrey-1.27 at vger.kernel.org; Tue, 19 Dec 2006 16:59:39 EST
X-ExtLoop1: 1
X-IronPort-AV: i="4.12,188,1165219200"; 
   d="scan'208"; a="160302308:sNHT671634481"
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Andrew Morton'" <akpm@osdl.org>,
       "'Trond Myklebust'" <trond.myklebust@fys.uio.no>,
       "'xb'" <xavier.bru@bull.net>, "'Zach Brown'" <zach.brown@oracle.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: [patch] aio: fix buggy put_ioctx call in aio_complete
Date: Tue, 19 Dec 2006 13:49:18 -0800
Message-ID: <000001c723b7$89257830$e834030a@amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
Thread-Index: Accjt4jdpQPFdUhzTnyMev/W6wKZCw==
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Regarding to a bug report on:
http://marc.theaimsgroup.com/?l=linux-kernel&m=116599593200888&w=2

flush_workqueue() is not allowed to be called in the softirq context.
However, aio_complete() called from I/O interrupt can potentially call
put_ioctx with last ref count on ioctx and trigger a bug warning.  It
is simply incorrect to perform ioctx freeing from aio_complete.

This patch removes all duplicate ref counting for each kiocb as
reqs_active already used as a request ref count for each active ioctx.
This also ensures that buggy call to flush_workqueue() in softirq
context is eliminated. wait_for_all_aios currently will wait on last
active kiocb.  However, it is racy.  This patch also tighten it up
by utilizing rcu synchronization mechanism to ensure no further
reference to ioctx before put_ioctx function is run.


Signed-off-by: Ken Chen <kenneth.w.chen@intel.com>


--- ./fs/aio.c.orig	2006-12-19 08:35:01.000000000 -0800
+++ ./fs/aio.c	2006-12-19 08:46:34.000000000 -0800
@@ -308,6 +308,7 @@ static void wait_for_all_aios(struct kio
 		set_task_state(tsk, TASK_UNINTERRUPTIBLE);
 	}
 	__set_task_state(tsk, TASK_RUNNING);
+	synchronize_rcu();
 	remove_wait_queue(&ctx->wait, &wait);
 }
 
@@ -425,7 +426,6 @@ static struct kiocb fastcall *__aio_get_
 	ring = kmap_atomic(ctx->ring_info.ring_pages[0], KM_USER0);
 	if (ctx->reqs_active < aio_ring_avail(&ctx->ring_info, ring)) {
 		list_add(&req->ki_list, &ctx->active_reqs);
-		get_ioctx(ctx);
 		ctx->reqs_active++;
 		okay = 1;
 	}
@@ -538,8 +538,6 @@ int fastcall aio_put_req(struct kiocb *r
 	spin_lock_irq(&ctx->ctx_lock);
 	ret = __aio_put_req(ctx, req);
 	spin_unlock_irq(&ctx->ctx_lock);
-	if (ret)
-		put_ioctx(ctx);
 	return ret;
 }
 
@@ -795,8 +793,7 @@ static int __aio_run_iocbs(struct kioctx
 		 */
 		iocb->ki_users++;       /* grab extra reference */
 		aio_run_iocb(iocb);
-		if (__aio_put_req(ctx, iocb))  /* drop extra ref */
-			put_ioctx(ctx);
+		__aio_put_req(ctx, iocb);
  	}
 	if (!list_empty(&ctx->run_list))
 		return 1;
@@ -1012,6 +1009,7 @@ int fastcall aio_complete(struct kiocb *
 		iocb->ki_nbytes - iocb->ki_left, iocb->ki_nbytes);
 put_rq:
 	/* everything turned out well, dispose of the aiocb. */
+	rcu_read_lock();
 	ret = __aio_put_req(ctx, iocb);
 
 	spin_unlock_irqrestore(&ctx->ctx_lock, flags);
@@ -1019,9 +1017,7 @@ put_rq:
 	if (waitqueue_active(&ctx->wait))
 		wake_up(&ctx->wait);
 
-	if (ret)
-		put_ioctx(ctx);
-
+	rcu_read_unlock();
 	return ret;
 }
 
