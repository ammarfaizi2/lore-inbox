Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129477AbQLRVBX>; Mon, 18 Dec 2000 16:01:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129391AbQLRVBP>; Mon, 18 Dec 2000 16:01:15 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:4342 "EHLO
	brutus.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S129477AbQLRVA7>; Mon, 18 Dec 2000 16:00:59 -0500
Date: Mon, 18 Dec 2000 18:29:24 -0200 (BRDT)
From: Rik van Riel <riel@conectiva.com.br>
To: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Pavel Machek <pavel@suse.cz>,
        Chris Lattner <sabre@nondot.org>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: ANNOUNCE: Linux Kernel ORB: kORBit
In-Reply-To: <Pine.LNX.3.96.1001216000116.27376A-100000@artax.karlin.mff.cuni.cz>
Message-ID: <Pine.LNX.4.21.0012181825180.2595-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Dec 2000, Mikulas Patocka wrote:

> > Not unless your driver is broken.
> 
> ok_to_allocate:
> 		******* INTERRUPT ********
>         spin_lock_irqsave(&page_alloc_lock, flags);
>         /* if it's not a dma request, try non-dma first */
>         if (!(gfp_mask & __GFP_DMA))
>                 RMQUEUE_TYPE(order, 0);
>         RMQUEUE_TYPE(order, 1);
>         spin_unlock_irqrestore(&page_alloc_lock, flags);
> 
> nopage:
>         return 0;
> }

Now read the code carefully and see how allocations can
end up here ... and when they can't...

> When interrupt comes here and eats page just freed by try_to_free_pages(),
> GFP_KERNEL allocation will fail => The kernel goes crazy, shoots
> processes, returns -ENOMEM to calls, maybe damages its structures. 
> Deadlock in getblk, if memory is full of dirty file mapped pages. 

Wrong. Getblk won't deadlock, it will just sleep and another
thread will continue later on. Killing processes will (in 2.4)
only happen when you run out of swap ... 2.4 will simply have
its processes loop in alloc_pages() until memory is available.

The "maybe damages its structures" is a sure indication of
you having a very vivid imagination ;)

> You actually do not need network flood to kill your box. Just imagine that
> kpiod is swapping files out too slowly, free memory is going lower and
> lower, every process screaming with "VM: do_try_to_free_pages failed" and
> the system is aproaching instant death.

Umm?  Can you explain how this could happen?

> Besides, __get_free_pages just encourages people to write broken
> drivers because it tries to hide allocation bugs. If there would
> be something like
> 
> if (current->flags & PF_MEMALLOC && !in_interrupt())
> panic("swapper fscked up!");

We have something a little bit like this in 2.4, though
it's just a printk and it doesn't print a backtrace. Now
that you mention it, though, printing a backtrace may be
a nice debugging option for missed higher-order allocations ;)

(but only useful if you get unreasonable amounts of them)

regards,

Rik
--
Hollywood goes for world dumbination,
	Trailer at 11.

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
