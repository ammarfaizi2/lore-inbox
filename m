Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129324AbQLPAxa>; Fri, 15 Dec 2000 19:53:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130109AbQLPAxU>; Fri, 15 Dec 2000 19:53:20 -0500
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:59663 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S129718AbQLPAxD>; Fri, 15 Dec 2000 19:53:03 -0500
Date: Sat, 16 Dec 2000 01:19:27 +0100 (CET)
From: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
Reply-To: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Pavel Machek <pavel@suse.cz>, Chris Lattner <sabre@nondot.org>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: ANNOUNCE: Linux Kernel ORB: kORBit
In-Reply-To: <E1473CJ-0001w7-00@the-village.bc.nu>
Message-ID: <Pine.LNX.3.96.1001216000116.27376A-100000@artax.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I guess that when you mmap large files over nfs and write to them, you get
> > similar problems.
> > 
> > > Oh, and try to eat atomic memory by ping -f kORBit-ized box.
> > 
> > When linux is out of atomic memory, it will die anyway.
> 
> Not unless your driver is broken.

ok_to_allocate:
		******* INTERRUPT ********
        spin_lock_irqsave(&page_alloc_lock, flags);
        /* if it's not a dma request, try non-dma first */
        if (!(gfp_mask & __GFP_DMA))
                RMQUEUE_TYPE(order, 0);
        RMQUEUE_TYPE(order, 1);
        spin_unlock_irqrestore(&page_alloc_lock, flags);

nopage:
        return 0;
}

When interrupt comes here and eats page just freed by try_to_free_pages(),
GFP_KERNEL allocation will fail => The kernel goes crazy, shoots
processes, returns -ENOMEM to calls, maybe damages its structures. 
Deadlock in getblk, if memory is full of dirty file mapped pages. 

You actually do not need network flood to kill your box. Just imagine that
kpiod is swapping files out too slowly, free memory is going lower and
lower, every process screaming with "VM: do_try_to_free_pages failed" and
the system is aproaching instant death.


Besides, __get_free_pages just encourages people to write broken drivers
because it tries to hide allocation bugs. If there would be something like

if (current->flags & PF_MEMALLOC && !in_interrupt()) panic("swapper fscked up!");

you would see how many parts of system are "broken".

Mikulas



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
