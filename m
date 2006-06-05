Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S932437AbWFEHKD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932437AbWFEHKD (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 03:10:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932441AbWFEHKD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 03:10:03 -0400
Received: from gate.crashing.org ([63.228.1.57]:19925 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S932437AbWFEHKB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 03:10:01 -0400
Subject: Re: [RFC][PATCH] request_irq(...,SA_BOOTMEM);
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <1149486009.8543.42.camel@localhost.localdomain>
References: <1149486009.8543.42.camel@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 05 Jun 2006 17:08:29 +1000
Message-Id: <1149491309.8543.54.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-06-05 at 15:40 +1000, Benjamin Herrenschmidt wrote:
> In various places, architectures need to request interrupts early during
> boot. Before slab is initialized typically. We used to have all sorts of
> arch hacks to do so, which ended up being turned into something like:

 ..../.... (skip workaround based on bootmem)

Hrm... I'm running into more problems with some of my powerpc irq
cleanups related to slab not being initialized.

Why do we do it so late ? I don't see any reason. A bunch of stuff like
init_IRQ(), time_init() etc...end up being called without a working slab
(not even GFP_ATOMIC). Damn, even console_init().

What are the fundamental reasons, if any, why we initialize the slab so
late ? Would it be possible to have the slab fallback to bootmem or some
crap like that early during boot (though that may be an issue for things
trying to free blocks) ?

For example, in my big irq rework for powerpc, I need to clean up the
virtual to physical irq mapping for which we are using a radix tree.
Right now, we kludge around in the pseries code to use that radix tree
late (that is to setup the cascaded interrupt from an arch_initcall),
but that's becoming a bigger issue as I'm trying to push some of that
stuff into a nice common remapping layer (we need that for cell too
among others). That's just an example of a low level utility (radix
trees) we can't use because it relies on the slab.

Another example is that things like init_IRQ(), time_init(),
console_init() etc.. need to be able to do ioremap. How many hacks are
archs cluttered with to be able to do ioremap before mem_init ? It
varies from hacks in pte_alloc_kernel() to use bootmem, to the use of
bolted hash entries on ppc64, etc....

Maybe we should have a look at pushing some things later into the boot
process that have no reason anymore to be done that early... And even if
not, a consistent memory allocator is something that I would really
consider as a very basic service that should be up before pretty much
everything else. It's not like the slab was relying on hardware to be up
or anything fancy... it doesn't even rely on vmalloc() to be available
nor the MMU in any consistent state outside of having the linear mapping
up (which I think all archs have at this point in time anyway).

I'm sure there is a subtle sneaky dependency, I would suspect something
to do with the scheduler and/or the cpumask/numa infos, whatever, but I
think we should really consider solving that.

Bootmem is a hack. It may be good enough for very-early-boot type
allocations, but them, I mean really really early (and even then, heh,
powerpc has it's own allocator that works even before bootmem is up). 

Cheers,
Ben.

