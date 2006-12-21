Return-Path: <linux-kernel-owner+w=401wt.eu-S1422694AbWLUEHg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422694AbWLUEHg (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 23:07:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422698AbWLUEHf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 23:07:35 -0500
Received: from smtp.osdl.org ([65.172.181.25]:36007 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422694AbWLUEHe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 23:07:34 -0500
Date: Wed, 20 Dec 2006 20:05:35 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       "linux-aio@kvack.org" <linux-aio@kvack.org>
Cc: "'Trond Myklebust'" <trond.myklebust@fys.uio.no>,
       "'xb'" <xavier.bru@bull.net>, "'Zach Brown'" <zach.brown@oracle.com>,
       <linux-kernel@vger.kernel.org>, "Paul E. McKenney" <paulmck@us.ibm.com>
Subject: Re: [patch] aio: fix buggy put_ioctx call in aio_complete
Message-Id: <20061220200535.211a3dda.akpm@osdl.org>
In-Reply-To: <000001c723b7$89257830$e834030a@amr.corp.intel.com>
References: <000001c723b7$89257830$e834030a@amr.corp.intel.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Dec 2006 13:49:18 -0800
"Chen, Kenneth W" <kenneth.w.chen@intel.com> wrote:

> Regarding to a bug report on:
> http://marc.theaimsgroup.com/?l=linux-kernel&m=116599593200888&w=2
> 
> flush_workqueue() is not allowed to be called in the softirq context.
> However, aio_complete() called from I/O interrupt can potentially call
> put_ioctx with last ref count on ioctx and trigger a bug warning.  It
> is simply incorrect to perform ioctx freeing from aio_complete.
> 
> This patch removes all duplicate ref counting for each kiocb as
> reqs_active already used as a request ref count for each active ioctx.
> This also ensures that buggy call to flush_workqueue() in softirq
> context is eliminated. wait_for_all_aios currently will wait on last
> active kiocb.  However, it is racy.  This patch also tighten it up
> by utilizing rcu synchronization mechanism to ensure no further
> reference to ioctx before put_ioctx function is run.
> 

hrm, maybe.  Does this count as "abuse of the RCU interfaces".  Or "reuse"?

> 
> 
> --- ./fs/aio.c.orig	2006-12-19 08:35:01.000000000 -0800
> +++ ./fs/aio.c	2006-12-19 08:46:34.000000000 -0800
> @@ -308,6 +308,7 @@ static void wait_for_all_aios(struct kio
>  		set_task_state(tsk, TASK_UNINTERRUPTIBLE);
>  	}
>  	__set_task_state(tsk, TASK_RUNNING);
> +	synchronize_rcu();
>  	remove_wait_queue(&ctx->wait, &wait);
>  }

argh.  Pity the poor fresh-faced wannabe kernel developer who stumbles
across a stray synchronize_rcu() in the AIO code and wonders what the hell
that's doing there.

Please, this needs good commenting.   More than zero, anyway.

> @@ -425,7 +426,6 @@ static struct kiocb fastcall *__aio_get_
>  	ring = kmap_atomic(ctx->ring_info.ring_pages[0], KM_USER0);
>  	if (ctx->reqs_active < aio_ring_avail(&ctx->ring_info, ring)) {
>  		list_add(&req->ki_list, &ctx->active_reqs);
> -		get_ioctx(ctx);
>  		ctx->reqs_active++;
>  		okay = 1;
>  	}
> @@ -538,8 +538,6 @@ int fastcall aio_put_req(struct kiocb *r
>  	spin_lock_irq(&ctx->ctx_lock);
>  	ret = __aio_put_req(ctx, req);
>  	spin_unlock_irq(&ctx->ctx_lock);
> -	if (ret)
> -		put_ioctx(ctx);
>  	return ret;
>  }
>  
> @@ -795,8 +793,7 @@ static int __aio_run_iocbs(struct kioctx
>  		 */
>  		iocb->ki_users++;       /* grab extra reference */
>  		aio_run_iocb(iocb);
> -		if (__aio_put_req(ctx, iocb))  /* drop extra ref */
> -			put_ioctx(ctx);
> +		__aio_put_req(ctx, iocb);
>   	}
>  	if (!list_empty(&ctx->run_list))
>  		return 1;
> @@ -1012,6 +1009,7 @@ int fastcall aio_complete(struct kiocb *
>  		iocb->ki_nbytes - iocb->ki_left, iocb->ki_nbytes);
>  put_rq:
>  	/* everything turned out well, dispose of the aiocb. */
> +	rcu_read_lock();
>  	ret = __aio_put_req(ctx, iocb);
>  
>  	spin_unlock_irqrestore(&ctx->ctx_lock, flags);
> @@ -1019,9 +1017,7 @@ put_rq:
>  	if (waitqueue_active(&ctx->wait))
>  		wake_up(&ctx->wait);
>  
> -	if (ret)
> -		put_ioctx(ctx);
> -
> +	rcu_read_unlock();
>  	return ret;
>  }
>  
