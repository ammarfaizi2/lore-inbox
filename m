Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275052AbTHMOWB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 10:22:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275059AbTHMOWB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 10:22:01 -0400
Received: from mail.suse.de ([213.95.15.193]:20498 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S275052AbTHMOV6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 10:21:58 -0400
Date: Wed, 13 Aug 2003 16:20:55 +0200
From: Andi Kleen <ak@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andi Kleen <ak@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test3-mm1: scheduling while atomic (ext3?)
Message-ID: <20030813142055.GC9179@wotan.suse.de>
References: <20030813014746.412660ae.akpm@osdl.org.suse.lists.linux.kernel> <20030813091958.GA30746@gates.of.nowhere.suse.lists.linux.kernel> <20030813025542.32429718.akpm@osdl.org.suse.lists.linux.kernel> <1060772769.8009.4.camel@localhost.localdomain.suse.lists.linux.kernel> <20030813042544.5064b3f4.akpm@osdl.org.suse.lists.linux.kernel> <1060774803.8008.24.camel@localhost.localdomain.suse.lists.linux.kernel> <p7365l17o70.fsf@oldwotan.suse.de> <1060778924.8008.39.camel@localhost.localdomain> <20030813131457.GD32290@wotan.suse.de> <1060783794.8008.62.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1060783794.8008.62.camel@dhcp23.swansea.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 13, 2003 at 03:09:55PM +0100, Alan Cox wrote:
> On Mer, 2003-08-13 at 14:14, Andi Kleen wrote:
> > hw prefetch has nothing to do with how the linux kernel uses prefetch.
> > It's only using it for data structures that cannot be handled by
> > the auto prefetcher.
> > 
> > [except the broken 3dnow! copy that was never enabled]
> 
> Not broken in 2.4, although the 2.4-ac kernel uses movntq instead for
> Athlon as it is faster than mmx_memcpy, which we use for Cyrix/VIA/IDT
> processors where it is a win.

movntq for a memcpy? That ise a very bad idea. It wins in micro benchmarks,
but the destination is pushed out of cache and the next code accessing
the destination will suffer badly from the cache misses. All the NT
stuff is basically useless in the kernel because it only helps with data
sets significantly bigger than your cache, and we usually only deal
with 4K chunks of everything.

[I did the same mistake early on Opteron/x86-64 for copy_page, but later 
fixed it]

> > My AMD manual lists it as part of 3dnow. If an CPU advertises 3dnow!
> > but doesn't have the instruction it's broken.
> 
> My AMD docs list it as part of the AMD extended 3dnow. The original
> 3dnow as done by AMD/Cyrix does not have it

The x86-64 manuals lists it as part of the 3dnow feature set.

The K6 has it, right?
Is there a "more original" 3dnow that what has been in the K6?
 
> > I would consider the MII broken then. setup should clear the 3dnow
> > bit.
> 
> "Mummy it doesnt work like I personally have decreed it shall lets break
> it and screw all the users". Thats the Dan Bernstein school of charm

It doesn't work like the AMD instruction reference manual describes it.

> theory of software development.

Being a bit touchy from the heat today ? @)

Of course it should be fixed, but the fix as it is a bug workaround
doesn't have to be very fast. So it would be ok to just clear the 3dnow bit.
But then to handle the K6 case (which is interesting, I didn't know) too it
would be probably better to define a separate bit. 


> > The problem is that it doesn't include K8 and K8
> > has prefetchw too (alternative currently only allows a single 
> > bit, not a bitmask). Better is to either clear 3dnow on the MII
> > or define a new pseudo bit that defines working and useful 
> > prefetchw
> 
> We want a pseudobit - otherwise we'll break other code that checks
> 3dnow is present properly.

Ok. I will do that when I'm back next week unless someone beats me
to it ;-)

> > If you really want 3 way alternative you can just define a macro
> > for it. The basic data structure supports it - the macro
> > just needs to have two .altinstructions records and two replacement codes. 
> > But I have my doubt it is worth it for this case.
> 
> prefetching is a big win on older Athlon because the CPU is fast and the
> chipset/ram sucks hugely relative to it

Hmm ok. So it probably needs an alternative3().

It's not hard to do, just a bit ugly because the macro will have a lot of
arguments.


> > Nope, no misalignment. All it does is to just handle the exception
> > using __ex_table and jumps to the next instruction.
> 
> If you misalign the instruction you don't seem to get the exception on
> Athlon, dunno about the Opteron errata or if the opteron errata bites in
> 32bit. If it does I guess we should clear mmx, xmm for Opteron by your
> arguments ;)

I didn't know about the misalignment bit. Interesting. Misalignment to
what boundary?

But is it slower than an aligned execution? If yes I would prefer my 
solution because it keeps the fast path as fast as possible.

-Andi
