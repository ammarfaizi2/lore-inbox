Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261510AbULNNjh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261510AbULNNjh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 08:39:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261509AbULNNjf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 08:39:35 -0500
Received: from main.gmane.org ([80.91.229.2]:22439 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261511AbULNNjW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 08:39:22 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Ed L Cashin <ecashin@coraid.com>
Subject: Re: [PATCH] ATA over Ethernet driver for 2.6.9 (with changes)
Date: Tue, 14 Dec 2004 08:39:16 -0500
Message-ID: <87mzwhov7f.fsf@coraid.com>
References: <87k6rmuqu4.fsf@coraid.com> <20041213201941.GC3399@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: adsl-34-230-221.asm.bellsouth.net
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
Cancel-Lock: sha1:x7hnV+5Pyyl9zaILCbIxNFnr8g4=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe <axboe@suse.de> writes:

> On Mon, Dec 13 2004, Ed L Cashin wrote:
>>   * use mempool allocation in make_request_fn
>
> It's not good enough, if cannot use a higher allocation priority
> that GFP_NOIO here - basically guarantee that your allocation will
> not block on further io. Currently you have the very same deadlock
> as before, the mempool does not help you since you call into the
> allocator and deadlock before ever blocking on the mempool.

Do you mean that with GFP_KERNEL we may still deadlock on line 199 of
the snippet below (from mm/mempool.c)?  That alloc pointer points to
mempool_alloc_slab, which gets called with __GFP_WAIT turned off.  The
kmem_cache allocator doesn't get called with the allocation priority
we specify in our make_request_fn, so we won't block there.

   190	void * mempool_alloc(mempool_t *pool, int gfp_mask)
   191	{
   192		void *element;
   193		unsigned long flags;
   194		DEFINE_WAIT(wait);
   195		int gfp_nowait = gfp_mask & ~(__GFP_WAIT | __GFP_IO);
   196	
   197		might_sleep_if(gfp_mask & __GFP_WAIT);
   198	repeat_alloc:
   199		element = pool->alloc(gfp_nowait|__GFP_NOWARN, pool->pool_data);
   200		if (likely(element != NULL))
   201			return element;
   202	

If we block later on the pool, that's because there are 16 objects in
use, which means that mempool_free is going to get called 16 times as
I/O completes, so I/O is throttled and forward progress is guaranteed.
Otherwise, how does the mempool mechanism help in preventing deadlock?

It looks like we can simply change GFP_KERNEL to GFP_IO in our
make_request_fn, but I'd also like to understand why that's necessary
when there's a dedicated pre-allocated pool per aoe device.

-- 
  Ed L Cashin <ecashin@coraid.com>

