Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129595AbQLRWRr>; Mon, 18 Dec 2000 17:17:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129747AbQLRWRh>; Mon, 18 Dec 2000 17:17:37 -0500
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:9743 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S129595AbQLRWRZ>; Mon, 18 Dec 2000 17:17:25 -0500
Date: Mon, 18 Dec 2000 22:46:17 +0100 (CET)
From: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
Reply-To: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
To: Rik van Riel <riel@conectiva.com.br>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Pavel Machek <pavel@suse.cz>,
        Chris Lattner <sabre@nondot.org>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: ANNOUNCE: Linux Kernel ORB: kORBit
In-Reply-To: <Pine.LNX.4.21.0012181825180.2595-100000@duckman.distro.conectiva>
Message-ID: <Pine.LNX.3.96.1001218215008.1190A-100000@artax.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Dec 2000, Rik van Riel wrote:

> On Sat, 16 Dec 2000, Mikulas Patocka wrote:
> 
> > > Not unless your driver is broken.
> > 
> > ok_to_allocate:
> > 		******* INTERRUPT ********
> >         spin_lock_irqsave(&page_alloc_lock, flags);
> >         /* if it's not a dma request, try non-dma first */
> >         if (!(gfp_mask & __GFP_DMA))
> >                 RMQUEUE_TYPE(order, 0);
> >         RMQUEUE_TYPE(order, 1);
> >         spin_unlock_irqrestore(&page_alloc_lock, flags);
> > 
> > nopage:
> >         return 0;
> > }
> 
> Now read the code carefully and see how allocations can
> end up here ... and when they can't...

GFP_ATOMIC allocations can eat all memory in 2.2. There are no free pages. 
Now process wants to allocate page with GFP_KERNEL or GFP_USER. It calls
try_to_free_pages.  try_to_free_pages succeeds and frees few pages.
Interrupt is received and eats pages that were just freed. RMQUEUE fails.
get_free_page returns zero. Process is shot.

> > Deadlock in getblk, if memory is full of dirty file mapped pages. 
> 
> Wrong. Getblk won't deadlock, it will just sleep and another
> thread will continue later on. Killing processes will (in 2.4)
> only happen when you run out of swap ... 2.4 will simply have
> its processes loop in alloc_pages() until memory is available.

I'm talking about 2.2. getblk will sleep until some memory becomes
available. And some memory can be available only if getblk succeeds.

> > You actually do not need network flood to kill your box. Just imagine that
> > kpiod is swapping files out too slowly, free memory is going lower and
> > lower, every process screaming with "VM: do_try_to_free_pages failed" and
> > the system is aproaching instant death.
> 
> Umm?  Can you explain how this could happen?

Imagine that kpiod is slow. try_to_swap_out returns 1 and pretends it
freed something but it didn't. It just passed request to kpiod. There are
no pages to be freed by shrink_mmap. do_try_to_swap_out calls swap_out
several times, then returns. And this repeats again and again.

There are two possible ends:

-swap_out unmaps everything and fails (all pages are pending on kpiod
queue), try_to_free_pages fails, process is shot

-as try_to_free_pages is pretending that it freed something, free memory
is going lower and lower; finally it reaches zero - see above

Mikulas




-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
