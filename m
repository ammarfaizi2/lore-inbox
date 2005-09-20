Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965091AbVITTTb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965091AbVITTTb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 15:19:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965092AbVITTTb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 15:19:31 -0400
Received: from fmr20.intel.com ([134.134.136.19]:41398 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S965091AbVITTTa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 15:19:30 -0400
Date: Tue, 20 Sep 2005 15:13:29 -0400
From: Benjamin LaHaise <bcrl@linux.intel.com>
To: =?iso-8859-1?Q?S=E9bastien_Dugu=E9?= <sebastien.dugue@bull.net>
Cc: linux-aio@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [AIO] aio-2.6.13-rc6-B1
Message-ID: <20050920191329.GA6579@linux.intel.com>
References: <20050817184406.GA24961@linux.intel.com> <1127211790.2051.9.camel@frecb000686>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1127211790.2051.9.camel@frecb000686>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 20, 2005 at 12:23:10PM +0200, Sébastien Dugué wrote:
>   what's the point of calling wake_up_locked(&sem->wait) in 
> aio_down_wait? We're already in a wakeup path and end up
> calling __wake_up_common recursively.

That's necessary to kick the next semaphore op in the list.  The 
list_del_init() right above that makes sure that we don't recurse 
and run the routine again.

>   I think it may be one of the cause of my kernel hanging at the
> very beginning.
> 
>   When I remove this call things go further but at some point a
> semaphore wait queue gets thrashed and __wake_up_common tries to
> call an invalid callback function.

This patch from Zach might make a difference.  Let me know if it changes 
the symptoms at all.  Sorry if it doesn't apply cleanly, as it is against 
a base kernel.  Basically, we could sleep while holding ctx_lock, which 
does Bad Things(tm) on SMP systems.

		-ben


Index: 2.6.13-git12-lock-kiocb/fs/aio.c
===================================================================
--- 2.6.13-git12-lock-kiocb.orig/fs/aio.c
+++ 2.6.13-git12-lock-kiocb/fs/aio.c
@@ -398,7 +398,7 @@ static struct kiocb fastcall *__aio_get_
 	if (unlikely(!req))
 		return NULL;
 
-	req->ki_flags = 1 << KIF_LOCKED;
+	req->ki_flags = 0;
 	req->ki_users = 2;
 	req->ki_key = 0;
 	req->ki_ctx = ctx;
@@ -717,6 +717,8 @@ static ssize_t aio_run_iocb(struct kiocb
 	iocb->ki_run_list.next = iocb->ki_run_list.prev = NULL;
 	spin_unlock_irq(&ctx->ctx_lock);
 
+	lock_kiocb(iocb);
+
 	/* Quit retrying if the i/o has been cancelled */
 	if (kiocbIsCancelled(iocb)) {
 		ret = -EINTR;
@@ -781,6 +783,7 @@ out:
 			aio_queue_work(ctx);
 		}
 	}
+	unlock_kiocb(iocb);
 	return ret;
 }
 
@@ -805,9 +808,7 @@ static int __aio_run_iocbs(struct kioctx
 		 * Hold an extra reference while retrying i/o.
 		 */
 		iocb->ki_users++;       /* grab extra reference */
-		lock_kiocb(iocb);
 		aio_run_iocb(iocb);
-		unlock_kiocb(iocb);
 		if (__aio_put_req(ctx, iocb))  /* drop extra ref */
 			put_ioctx(ctx);
  	}
@@ -1549,7 +1550,6 @@ int fastcall io_submit_one(struct kioctx
 
 	spin_lock_irq(&ctx->ctx_lock);
 	aio_run_iocb(req);
-	unlock_kiocb(req);
 	if (!list_empty(&ctx->run_list)) {
 		/* drain the run list */
 		while (__aio_run_iocbs(ctx))
