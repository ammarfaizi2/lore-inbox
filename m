Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261512AbULNNwv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261512AbULNNwv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 08:52:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261515AbULNNwp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 08:52:45 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:12683 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261514AbULNNwa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 08:52:30 -0500
Date: Tue, 14 Dec 2004 14:52:27 +0100
From: Jens Axboe <axboe@suse.de>
To: Ed L Cashin <ecashin@coraid.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ATA over Ethernet driver for 2.6.9 (with changes)
Message-ID: <20041214135226.GH3157@suse.de>
References: <87k6rmuqu4.fsf@coraid.com> <20041213201941.GC3399@suse.de> <87mzwhov7f.fsf@coraid.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87mzwhov7f.fsf@coraid.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


(don't trim cc lists, please)

On Tue, Dec 14 2004, Ed L Cashin wrote:
> Jens Axboe <axboe@suse.de> writes:
> 
> > On Mon, Dec 13 2004, Ed L Cashin wrote:
> >>   * use mempool allocation in make_request_fn
> >
> > It's not good enough, if cannot use a higher allocation priority
> > that GFP_NOIO here - basically guarantee that your allocation will
> > not block on further io. Currently you have the very same deadlock
> > as before, the mempool does not help you since you call into the
> > allocator and deadlock before ever blocking on the mempool.
> 
> Do you mean that with GFP_KERNEL we may still deadlock on line 199 of
> the snippet below (from mm/mempool.c)?  That alloc pointer points to
> mempool_alloc_slab, which gets called with __GFP_WAIT turned off.  The
> kmem_cache allocator doesn't get called with the allocation priority
> we specify in our make_request_fn, so we won't block there.
> 
>    190	void * mempool_alloc(mempool_t *pool, int gfp_mask)
>    191	{
>    192		void *element;
>    193		unsigned long flags;
>    194		DEFINE_WAIT(wait);
>    195		int gfp_nowait = gfp_mask & ~(__GFP_WAIT | __GFP_IO);
>    196	
>    197		might_sleep_if(gfp_mask & __GFP_WAIT);
>    198	repeat_alloc:
>    199		element = pool->alloc(gfp_nowait|__GFP_NOWARN, pool->pool_data);
>    200		if (likely(element != NULL))
>    201			return element;
>    202	

No, line 199 is safe. But you risk deadlocking at line 210 because you
call the page allocator with GFP_KERNEL at that point (which includes
__GFP_IO and __GFP_FS).

> If we block later on the pool, that's because there are 16 objects in
> use, which means that mempool_free is going to get called 16 times as
> I/O completes, so I/O is throttled and forward progress is guaranteed.
> Otherwise, how does the mempool mechanism help in preventing deadlock?

Doesn't matter, since you are already deadlocked on the ->alloc call. If
you have IO set in the gfp_mask, you could reenter your own driver,
which will call ->alloc, which will reenter... And then you hang.

> It looks like we can simply change GFP_KERNEL to GFP_IO in our
> make_request_fn, but I'd also like to understand why that's necessary
> when there's a dedicated pre-allocated pool per aoe device.

No, you need to use GFP_NOIO. You can block on the mempool itself,
because the objects you allocate from there have a finite life time.
They will be freed once some io completes. But you cannot block on other
IO, because that might be up to you do to.

So the safe mask simply __GFP_WAIT - it allows blocking waiting for your
mempool to refill, nothing more.

-- 
Jens Axboe

