Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751428AbVKIV13@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751428AbVKIV13 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 16:27:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751405AbVKIV12
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 16:27:28 -0500
Received: from kanga.kvack.org ([66.96.29.28]:56237 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S1751428AbVKIV12 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 16:27:28 -0500
Date: Wed, 9 Nov 2005 16:25:15 -0500
From: Benjamin LaHaise <bcrl@kvack.org>
To: Zach Brown <zach.brown@oracle.com>
Cc: linux-aio@kvack.org, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 3/3] aio: make ctx ref debugging depend on DEBUG
Message-ID: <20051109212515.GJ14452@kvack.org>
References: <20051109211758.25027.78199.sendpatchset@volauvent.pdx.zabbo.net> <20051109211808.25027.75305.sendpatchset@volauvent.pdx.zabbo.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051109211808.25027.75305.sendpatchset@volauvent.pdx.zabbo.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

NAK.  There's now no way for code outside aio.c to use the reference counting 
on iocbs, which is needed in other code.

		-ben

On Wed, Nov 09, 2005 at 01:15:16PM -0800, Zach Brown wrote:
> aio: make ctx ref debugging depend on DEBUG
> 
> Formalize ctx refcount debugging by putting it in legible inline functions and
> making it conditional on DEBUG.  In doing so a bug is also fixed where the
> decref debugging was testing the ref count after dropping its reference,
> opening a race with another thread that might free.
> 
>   Signed-off-by: Zach Brown <zach.brown@oracle.com>
> ---
> 
>  fs/aio.c            |   65 +++++++++++++++++++++++++++++-----------------------
>  include/linux/aio.h |    4 ---
>  2 files changed, 37 insertions(+), 32 deletions(-)
> 
> Index: 2.6.14-mm1-aio-cleanups/fs/aio.c
> ===================================================================
> --- 2.6.14-mm1-aio-cleanups.orig/fs/aio.c	2005-11-09 11:48:27.394115109 -0800
> +++ 2.6.14-mm1-aio-cleanups/fs/aio.c	2005-11-09 11:52:30.663874807 -0800
> @@ -37,8 +37,10 @@
>  
>  #if DEBUG > 1
>  #define dprintk		printk
> +#define AIO_DEBUG_BUG_ON BUG_ON
>  #else
>  #define dprintk(x...)	do { ; } while (0)
> +#define AIO_DEBUG_BUG_ON(x...) do { ; } while (0)
>  #endif
>  
>  /*------ sysctl variables----*/
> @@ -171,6 +173,40 @@
>  	return 0;
>  }
>  
> +static inline void get_ioctx(struct kioctx *ctx)
> +{
> +	AIO_DEBUG_BUG_ON(atomic_read(&ctx->users) <= 0);
> +	atomic_inc(&ctx->users);
> +}
> +
> +static void __put_ioctx(struct kioctx *ctx)
> +{
> +	unsigned nr_events = ctx->max_reqs;
> +
> +	BUG_ON(ctx->reqs_active);
> +
> +	cancel_delayed_work(&ctx->wq);
> +	flush_workqueue(aio_wq);
> +	aio_free_ring(ctx);
> +	mmdrop(ctx->mm);
> +	ctx->mm = NULL;
> +	pr_debug("__put_ioctx: freeing %p\n", ctx);
> +	kmem_cache_free(kioctx_cachep, ctx);
> +
> +	if (nr_events) {
> +		spin_lock(&aio_nr_lock);
> +		BUG_ON(aio_nr - nr_events > aio_nr);
> +		aio_nr -= nr_events;
> +		spin_unlock(&aio_nr_lock);
> +	}
> +}
> +
> +static inline void put_ioctx(struct kioctx *ctx)
> +{
> +	AIO_DEBUG_BUG_ON(atomic_read(&ctx->users) == 0);
> +	if (atomic_dec_and_test(&ctx->users))
> +		__put_ioctx(ctx);
> +}
>  
>  /* aio_ring_event: returns a pointer to the event at the given index from
>   * kmap_atomic(, km).  Release the pointer with put_aio_ring_event();
> @@ -255,7 +291,7 @@
>  	return ctx;
>  
>  out_cleanup:
> -	__put_ioctx(ctx);
> +	put_ioctx(ctx);
>  	return ERR_PTR(-EAGAIN);
>  
>  out_freectx:
> @@ -360,33 +396,6 @@
>  	}
>  }
>  
> -/* __put_ioctx
> - *	Called when the last user of an aio context has gone away,
> - *	and the struct needs to be freed.
> - */
> -void fastcall __put_ioctx(struct kioctx *ctx)
> -{
> -	unsigned nr_events = ctx->max_reqs;
> -
> -	if (unlikely(ctx->reqs_active))
> -		BUG();
> -
> -	cancel_delayed_work(&ctx->wq);
> -	flush_workqueue(aio_wq);
> -	aio_free_ring(ctx);
> -	mmdrop(ctx->mm);
> -	ctx->mm = NULL;
> -	pr_debug("__put_ioctx: freeing %p\n", ctx);
> -	kmem_cache_free(kioctx_cachep, ctx);
> -
> -	if (nr_events) {
> -		spin_lock(&aio_nr_lock);
> -		BUG_ON(aio_nr - nr_events > aio_nr);
> -		aio_nr -= nr_events;
> -		spin_unlock(&aio_nr_lock);
> -	}
> -}
> -
>  /* aio_get_req
>   *	Allocate a slot for an aio request.  Increments the users count
>   * of the kioctx so that the kioctx stays around until all requests are
> Index: 2.6.14-mm1-aio-cleanups/include/linux/aio.h
> ===================================================================
> --- 2.6.14-mm1-aio-cleanups.orig/include/linux/aio.h	2005-11-09 11:48:22.848483645 -0800
> +++ 2.6.14-mm1-aio-cleanups/include/linux/aio.h	2005-11-09 11:48:31.907756204 -0800
> @@ -198,7 +198,6 @@
>  extern int FASTCALL(aio_put_req(struct kiocb *iocb));
>  extern void FASTCALL(kick_iocb(struct kiocb *iocb));
>  extern int FASTCALL(aio_complete(struct kiocb *iocb, long res, long res2));
> -extern void FASTCALL(__put_ioctx(struct kioctx *ctx));
>  struct mm_struct;
>  extern void FASTCALL(exit_aio(struct mm_struct *mm));
>  extern struct kioctx *lookup_ioctx(unsigned long ctx_id);
> @@ -210,9 +209,6 @@
>  int FASTCALL(io_submit_one(struct kioctx *ctx, struct iocb __user *user_iocb,
>  				  struct iocb *iocb));
>  
> -#define get_ioctx(kioctx)	do { if (unlikely(atomic_read(&(kioctx)->users) <= 0)) BUG(); atomic_inc(&(kioctx)->users); } while (0)
> -#define put_ioctx(kioctx)	do { if (unlikely(atomic_dec_and_test(&(kioctx)->users))) __put_ioctx(kioctx); else if (unlikely(atomic_read(&(kioctx)->users) < 0)) BUG(); } while (0)
> -
>  #define in_aio() !is_sync_wait(current->io_wait)
>  /* may be used for debugging */
>  #define warn_if_async()							\

-- 
"Time is what keeps everything from happening all at once." -- John Wheeler
