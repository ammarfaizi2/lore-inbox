Return-Path: <linux-kernel-owner+w=401wt.eu-S1423001AbWLUSBt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423001AbWLUSBt (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 13:01:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423002AbWLUSBs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 13:01:48 -0500
Received: from mga01.intel.com ([192.55.52.88]:7464 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423001AbWLUSBs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 13:01:48 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.12,200,1165219200"; 
   d="scan'208"; a="180452591:sNHT24490315304"
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: <jmoyer@redhat.com>
Cc: "'Andrew Morton'" <akpm@osdl.org>, <linux-aio@kvack.org>,
       "'Trond Myklebust'" <trond.myklebust@fys.uio.no>,
       "'xb'" <xavier.bru@bull.net>, "'Zach Brown'" <zach.brown@oracle.com>,
       <linux-kernel@vger.kernel.org>, "Paul E. McKenney" <paulmck@us.ibm.com>
Subject: RE: [patch] aio: fix buggy put_ioctx call in aio_complete
Date: Thu, 21 Dec 2006 10:00:57 -0800
Message-ID: <000701c7252a$07e598d0$fe80030a@amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
Thread-Index: AcclJeGjUMDIwhXURpeNOaJ/3KRuKAAALDJg
In-Reply-To: <m3odpxxidf.fsf@redhat.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jmoyer@redhat.com wrote on Thursday, December 21, 2006 9:35 AM
> kenneth.w.chen> Take ioctx_lock is one part, the other part is to move
> kenneth.w.chen> 	spin_unlock_irqrestore(&ctx->ctx_lock, flags);
> kenneth.w.chen> in aio_complete all the way down to the end of the
> kenneth.w.chen> function, after wakeup and put_ioctx.  But then the ref
> kenneth.w.chen> counting on ioctx in aio_complete path is Meaningless,
> kenneth.w.chen> which is the thing I'm trying to remove.
> 
> OK, right.  But are we simply papering over the real problem?  Earlier in
> this thread, you stated:
> 
> > flush_workqueue() is not allowed to be called in the softirq context.
> > However, aio_complete() called from I/O interrupt can potentially call
> > put_ioctx with last ref count on ioctx and trigger a bug warning.  It
> > is simply incorrect to perform ioctx freeing from aio_complete.
> 
> But how do we end up with the last reference to the ioctx in the aio
> completion path?  That's a question I haven't seen answered.


It is explained in this posting, A race between io_destroy and aio_complete:
http://groups.google.com/group/linux.kernel/msg/d2ba7d73aca1dd0c?&hl=en

Trond spotted a bug in that posting.  The correct way of locking is to
move the spin_unlock_irqrestore in aio_complete all the way down instead
of calling aio_put_req at the end.  Like this:


--- ./fs/aio.c.orig	2006-12-21 08:08:14.000000000 -0800
+++ ./fs/aio.c	2006-12-21 08:14:27.000000000 -0800
@@ -298,17 +298,23 @@ static void wait_for_all_aios(struct kio
 	struct task_struct *tsk = current;
 	DECLARE_WAITQUEUE(wait, tsk);
 
+	spin_lock_irq(&ctx->ctx_lock);
 	if (!ctx->reqs_active)
-		return;
+		goto out;
 
 	add_wait_queue(&ctx->wait, &wait);
 	set_task_state(tsk, TASK_UNINTERRUPTIBLE);
 	while (ctx->reqs_active) {
+		spin_unlock_irq(&ctx->ctx_lock);
 		schedule();
 		set_task_state(tsk, TASK_UNINTERRUPTIBLE);
+		spin_lock_irq(&ctx->ctx_lock);
 	}
 	__set_task_state(tsk, TASK_RUNNING);
 	remove_wait_queue(&ctx->wait, &wait);
+
+out:
+	spin_unlock_irq(&ctx->ctx_lock);
 }
 
 /* wait_on_sync_kiocb:
@@ -424,7 +430,6 @@ static struct kiocb fastcall *__aio_get_
 	ring = kmap_atomic(ctx->ring_info.ring_pages[0], KM_USER0);
 	if (ctx->reqs_active < aio_ring_avail(&ctx->ring_info, ring)) {
 		list_add(&req->ki_list, &ctx->active_reqs);
-		get_ioctx(ctx);
 		ctx->reqs_active++;
 		okay = 1;
 	}
@@ -536,8 +541,6 @@ int fastcall aio_put_req(struct kiocb *r
 	spin_lock_irq(&ctx->ctx_lock);
 	ret = __aio_put_req(ctx, req);
 	spin_unlock_irq(&ctx->ctx_lock);
-	if (ret)
-		put_ioctx(ctx);
 	return ret;
 }
 
@@ -782,8 +785,7 @@ static int __aio_run_iocbs(struct kioctx
 		 */
 		iocb->ki_users++;       /* grab extra reference */
 		aio_run_iocb(iocb);
-		if (__aio_put_req(ctx, iocb))  /* drop extra ref */
-			put_ioctx(ctx);
+		__aio_put_req(ctx, iocb);
  	}
 	if (!list_empty(&ctx->run_list))
 		return 1;
@@ -998,14 +1000,10 @@ put_rq:
 	/* everything turned out well, dispose of the aiocb. */
 	ret = __aio_put_req(ctx, iocb);
 
-	spin_unlock_irqrestore(&ctx->ctx_lock, flags);
-
 	if (waitqueue_active(&ctx->wait))
 		wake_up(&ctx->wait);
 
-	if (ret)
-		put_ioctx(ctx);
-
+	spin_unlock_irqrestore(&ctx->ctx_lock, flags);
 	return ret;
 }
 
