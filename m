Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1750798AbWFEIu7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750798AbWFEIu7 (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 04:50:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750804AbWFEIu7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 04:50:59 -0400
Received: from gate.crashing.org ([63.228.1.57]:18390 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1750798AbWFEIu6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 04:50:58 -0400
Subject: Re: [RFC][PATCH] request_irq(...,SA_BOOTMEM);
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu, tglx@linutronix.de,
        torvalds@osdl.org
In-Reply-To: <20060605012405.ac17f918.akpm@osdl.org>
References: <1149486009.8543.42.camel@localhost.localdomain>
	 <1149491309.8543.54.camel@localhost.localdomain>
	 <20060605003127.fc1ea37a.akpm@osdl.org>
	 <1149493691.8543.57.camel@localhost.localdomain>
	 <20060605012405.ac17f918.akpm@osdl.org>
Content-Type: text/plain
Date: Mon, 05 Jun 2006 18:49:36 +1000
Message-Id: <1149497376.8543.65.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

\
> Yes, there are a few sleeping locks taken in
> kmem_cache_init()->kmem_cache_init(), for example.
> 
> They would normally generate might_sleep() warnings, but __might_sleep()
> suppresses that early in boot, for this very reason.
> 
> It's all a bit sleazy, "knowing" that these locks won't be contended, so
> it's safe to do apparently-unsafe things.  We haven't even started the
> other CPUs yet.
> 
> For something like kmem_cache_init() we could, I suppose, pass in a
> dont-take-any-locks flag.  But for a fastpath thing (if there are any such
> cases) that wouldn't be an option.
> 
> All very unpleasant.

It is, but I think it's ok to assume that we won't contention that early
during boot. I mean, irqs are disabled not because we are in an atomic
section but bcs we just have never enabled them yet :) 

> And yes, the mutex code will (with debug enabled) unconditionally enable
> interrupts.  ppc64 tends to oops when this happens, in the timer handler
> (so it'll be intermittent...)

I tend to say that any code that hard-enables interrupts is looking for
trouble (mostly for that very reason of init stuff).

The thing is, to talk to the PIC, we need generally quite a bit of stuff
up, like page tables for ioremap etc... and thus because of that, as I
said, archs carry horrible hacks all over the place.

We can't just local_irq_enable() and setup the PIC later because the PIC
may have been left in a crap state by the BIOS (or whatever else we boot
from like kexec/kdump).

Thus it's a matter of

 - making sure we have some sanity with irq enabling/disabling
(basically not hard-enabling, always doing save/restore)
 - making sure our very zealous runtime checks don't trigger on
"interrupts have never been enabled yet" :)

I think the above is a small price to pay for all the added sanity of
having an allocator earlier and removing all of the crap archs carry
around to have ioremap working very early.

Ok, not _all_ of it because archs took bad habits and setup_arch() tends
to be full of stuff needing to tap the hardware as well, but heh, let's
clean things one step at a time. Once we have done that, we can/should
probably split setup_arch() (before allocator etc... setup) and
init_arch() after. That way, all the code that need to atually probe
hardware can be moved there (on ppc, that's also where we need to
discover PCI bridges so we can get the legacy ISA stuff etc....) 

I can already foresee vast amounts of cleanups in the ppc code (and
getting rid of bootmem allocations in lots of places) with such
things :)

> But looking at
> work-around-ppc64-bootup-bug-by-making-mutex-debugging-save-restore-irqs.patch
> I realise I don't understand it.  We only go into the irq-enabling code in
> the case of contention, and there cannot be contention in this case?

I'll have a look, possibly not before tomorrow though.

Ben.



