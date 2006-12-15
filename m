Return-Path: <linux-kernel-owner+w=401wt.eu-S1752165AbWLOOB2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752165AbWLOOB2 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 09:01:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752163AbWLOOB2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 09:01:28 -0500
Received: from pat.uio.no ([129.240.10.15]:51357 "EHLO pat.uio.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752164AbWLOOB1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 09:01:27 -0500
Subject: RE: 2.6.18.4: flush_workqueue calls mutex_lock in interrupt
	environment
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: "'Andrew Morton'" <akpm@osdl.org>, linux-aio@kvack.org,
       "'xb'" <xavier.bru@bull.net>, linux-kernel@vger.kernel.org,
       "'Zach Brown'" <zach.brown@oracle.com>
In-Reply-To: <1166190561.5761.12.camel@lade.trondhjem.org>
References: <000001c72013$2a1a90c0$b481030a@amr.corp.intel.com>
	 <1166190561.5761.12.camel@lade.trondhjem.org>
Content-Type: text/plain
Date: Fri, 15 Dec 2006 09:01:13 -0500
Message-Id: <1166191273.5761.18.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-5.0, required=12.0, autolearn=no, UIO_MAIL_IS_INTERNAL=-5)
X-UiO-SPAM-Test: UIO-GREYLIST 69.241.229.183 spam_score -49 maxlevel 200 minaction 2 bait 0 blacklist 0 greylist 1 ratelimit 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-12-15 at 08:49 -0500, Trond Myklebust wrote:
> On Thu, 2006-12-14 at 22:35 -0800, Chen, Kenneth W wrote:
> > Chen, Kenneth wrote on Thursday, December 14, 2006 5:59 PM
> > > > It seems utterly insane to have aio_complete() flush a workqueue. That
> > > > function has to be called from a number of different environments,
> > > > including non-sleep tolerant environments.
> > > > 
> > > > For instance it means that directIO on NFS will now cause the rpciod
> > > > workqueues to call flush_workqueue(aio_wq), thus slowing down all RPC
> > > > activity.
> > > 
> > > The bug appears to be somewhere else, somehow the ref count on ioctx is
> > > all messed up.
> > > 
> > > In aio_complete, __put_ioctx() should not be invoked because ref count
> > > on ioctx is supposedly more than 2, aio_complete decrement it once and
> > > should return without invoking the free function.
> 
> This makes absolutely no sense whatsoever. If the refcount is 'always
> supposedo to be more than 2' then why would you need a refcount at all
> in aio_complete?
> 
> > > The real freeing ioctx should be coming from exit_aio() or io_destroy(),
> > > in which case both wait until no further pending AIO request via
> > > wait_for_all_aios().
> > 
> > Ah, I think I see the bug: it must be a race between io_destroy() and
> > aio_complete().  A possible scenario:
> > 
> > cpu0                               cpu1
> > io_destroy                         aio_complete
> >   wait_for_all_aios {                __aio_put_req
> >      ...                                 ctx->reqs_active--;
> >      if (!ctx->reqs_active)
> >         return;
> >   }
> >   ...
> >   put_ioctx(ioctx)
> > 
> >                                      put_ioctx(ctx);
> >                                         bam! Bug trigger!
> > 
> > AIO finished on cpu1 and while in the middle of aio_complete, cpu0 starts
> > io_destroy sequence, sees no pending AIO, went ahead decrement the ref
> > count on ioctx.  At a later point in aio_complete, the put_ioctx decrement
> > last ref count and calls the ioctx freeing function and there it triggered
> > the bug warning.
> > 
> > A simple fix would be to access ctx->reqs_active inside ctx spin lock in wait_for_all_aios().  At the mean time, I would like to
> > remove ref counting
> > for each iocb because we already performing ref count using reqs_active. This
> > would also prevent similar buggy code in the future.
> > 
> > 
> > Signed-off-by: Ken Chen <kenneth.w.chen@intel.com>
> > 
> > --- ./fs/aio.c.orig	2006-11-29 13:57:37.000000000 -0800
> > +++ ./fs/aio.c	2006-12-14 20:45:14.000000000 -0800
> > @@ -298,17 +298,23 @@ static void wait_for_all_aios(struct kio
> >  	struct task_struct *tsk = current;
> >  	DECLARE_WAITQUEUE(wait, tsk);
> >  
> > +	spin_lock_irq(&ctx->ctx_lock);
> >  	if (!ctx->reqs_active)
> > -		return;
> > +		goto out;
> >  
> >  	add_wait_queue(&ctx->wait, &wait);
> >  	set_task_state(tsk, TASK_UNINTERRUPTIBLE);
> >  	while (ctx->reqs_active) {
> > +		spin_unlock_irq(&ctx->ctx_lock);
> >  		schedule();
> >  		set_task_state(tsk, TASK_UNINTERRUPTIBLE);
> > +		spin_lock_irq(&ctx->ctx_lock);
> >  	}
> >  	__set_task_state(tsk, TASK_RUNNING);
> >  	remove_wait_queue(&ctx->wait, &wait);
> > +
> > +out:
> > +	spin_unlock_irq(&ctx->ctx_lock);
> >  }
> >  
> >  /* wait_on_sync_kiocb:
> > @@ -425,7 +431,6 @@ static struct kiocb fastcall *__aio_get_
> >  	ring = kmap_atomic(ctx->ring_info.ring_pages[0], KM_USER0);
> >  	if (ctx->reqs_active < aio_ring_avail(&ctx->ring_info, ring)) {
> >  		list_add(&req->ki_list, &ctx->active_reqs);
> > -		get_ioctx(ctx);
> >  		ctx->reqs_active++;
> >  		okay = 1;
> >  	}
> > @@ -538,8 +543,6 @@ int fastcall aio_put_req(struct kiocb *r
> >  	spin_lock_irq(&ctx->ctx_lock);
> >  	ret = __aio_put_req(ctx, req);
> >  	spin_unlock_irq(&ctx->ctx_lock);
> > -	if (ret)
> > -		put_ioctx(ctx);
> >  	return ret;
> >  }
> >  
> > @@ -795,8 +798,7 @@ static int __aio_run_iocbs(struct kioctx
> >  		 */
> >  		iocb->ki_users++;       /* grab extra reference */
> >  		aio_run_iocb(iocb);
> > -		if (__aio_put_req(ctx, iocb))  /* drop extra ref */
> > -			put_ioctx(ctx);
> > +		__aio_put_req(ctx, iocb);
> >   	}
> >  	if (!list_empty(&ctx->run_list))
> >  		return 1;
> > @@ -942,7 +944,6 @@ int fastcall aio_complete(struct kiocb *
> >  	struct io_event	*event;
> >  	unsigned long	flags;
> >  	unsigned long	tail;
> > -	int		ret;
> >  
> >  	/*
> >  	 * Special case handling for sync iocbs:
> > @@ -1011,18 +1012,12 @@ int fastcall aio_complete(struct kiocb *
> >  	pr_debug("%ld retries: %zd of %zd\n", iocb->ki_retried,
> >  		iocb->ki_nbytes - iocb->ki_left, iocb->ki_nbytes);
> >  put_rq:
> > -	/* everything turned out well, dispose of the aiocb. */
> > -	ret = __aio_put_req(ctx, iocb);
> > -
> >  	spin_unlock_irqrestore(&ctx->ctx_lock, flags);
> >  
> >  	if (waitqueue_active(&ctx->wait))
> >  		wake_up(&ctx->wait);
> >  
> > -	if (ret)
> > -		put_ioctx(ctx);
> > -
> > -	return ret;
> > +	return aio_put_req(iocb);
> >  }
> 
> New race: You are now calling wake_up(&ctx->wait) before you've called
> aio_put_req(). You also still have the exact same race as before since
> aio_put_req() also calls put_ioctx() if ret != 0...

Oops. Missed the fact that you are removed the put_ioctx from
aio_put_req, but the first sentence is still true. If you try to wake up
wait_for_all_aios before you've changed the condition it is waiting for,
then it may end up hanging forever.

Why not fix this by having the context freed via an RCU callback? That
way you can protect the combined call to aio_put_req() +
wake_up(ctx->wait) using a simple preempt_off/preempt_on, and all is
good.

Trond

