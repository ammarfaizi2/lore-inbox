Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752036AbWCHDzV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752036AbWCHDzV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 22:55:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752032AbWCHDzV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 22:55:21 -0500
Received: from smtp.osdl.org ([65.172.181.4]:964 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750737AbWCHDzU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 22:55:20 -0500
Date: Tue, 7 Mar 2006 19:54:46 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Paul Mackerras <paulus@samba.org>
cc: David Howells <dhowells@redhat.com>, akpm@osdl.org,
       linux-arch@vger.kernel.org, bcrl@linux.intel.com, matthew@wil.cx,
       linux-kernel@vger.kernel.org, mingo@redhat.com,
       linuxppc64-dev@ozlabs.org, jblunck@suse.de
Subject: Re: Memory barriers and spin_unlock safety
In-Reply-To: <17422.19865.635112.820824@cargo.ozlabs.ibm.com>
Message-ID: <Pine.LNX.4.64.0603071930530.32577@g5.osdl.org>
References: <32518.1141401780@warthog.cambridge.redhat.com>
 <Pine.LNX.4.64.0603030823200.22647@g5.osdl.org> <17417.29375.87604.537434@cargo.ozlabs.ibm.com>
 <Pine.LNX.4.64.0603040914160.22647@g5.osdl.org> <17422.19865.635112.820824@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 8 Mar 2006, Paul Mackerras wrote:
>
> Linus Torvalds writes:
> 
> > So the rules from the PC side (and like it or not, they end up being 
> > what all the drivers are tested with) are:
> > 
> >  - regular stores are ordered by write barriers
> 
> I thought regular stores were always ordered anyway?

For the hw, yes. For the compiler no.

So you actually do end up needing write barriers even on x86. It won't 
compile to any actual _instruction_, but it will be a compiler barrier (ie 
it just ends up being an empty inline asm that "modifies" memory).

So forgetting the wmb() is a bug even on x86, unless you happen to program 
in assembly.

Of course, the x86 hw semantics _do_ mean that forgetting it is less 
likely to cause problems, just because the compiler re-ordering is fairly 
unlikely most of the time.

> >  - PIO stores are always synchronous
> 
> By synchronous, do you mean ordered with respect to all other accesses
> (regular memory, MMIO, prefetchable MMIO, PIO)?

Close, yes. HOWEVER, it's only really ordered wrt the "innermost" bus. I 
don't think PCI bridges are supposed to post PIO writes, but a x86 CPU 
basically won't stall for them forever. I _think_ they'll wait for it to 
hit that external bus, though.

So it's totally serializing in the sense that all preceding reads have 
completed and all preceding writes have hit the cache-coherency point, but 
you don't necessarily know when the write itself will hit the device (the 
write will return before that necessarily happens).

> In other words, if I store a value in regular memory, then do an
> outb() to a device, and the device does a DMA read to the location I
> just stored to, is the device guaranteed to see the value I just
> stored (assuming no other later store to the location)?

Yes, assuming that the DMA read is in respose to (ie causally related to) 
the write.

> >  - MMIO stores are ordered by IO semantics
> > 	- PCI ordering must be honored:
> > 	  * write combining is only allowed on PCI memory resources
> > 	    that are marked prefetchable. If your host bridge does write 
> > 	    combining in general, it's not a "host bridge", it's a "host 
> > 	    disaster".
> 
> Presumably the host bridge doesn't know what sort of PCI resource is
> mapped at a given address, so that information (whether the resource
> is prefetchable) must come from the CPU, which would get it from the
> TLB entry or an MTRR entry - is that right?

Correct. Although it could of course be a map in the host bridge itself, 
not on the CPU.

If the host bridge doesn't know, then the host bridge had better not 
combine or the CPU had better tell it not to combine, using something like 
a "sync" instruction that causes bus traffic. Either of those approaches 
is likely a performance disaster, so you do want to have the CPU and/or 
hostbridge do this all automatically for you.

Which is what the PC world does.

> Or is there some gentleman's agreement between the host bridge and the
> BIOS that certain address ranges are only used for certain types of
> PCI memory resources?

Not that I know. I _think_ all of the PC world just depends on the CPU 
doing the write combining, and the CPU knows thanks to MTRR's and page 
tables. But I could well imagine that there is some situation where the 
logic is further out.

> What ordering is there between stores to regular memory and stores to
> non-prefetchable MMIO?

Non-prefetchable MMIO will be in-order on x86 wrt regular memory (unless 
you use one of the non-temporal stores).

To get out-of-order stores you have to use a special MTRR setting (mtrr 
type "WC" for "write combining").

Or possibly non-temporal writes to an uncached area. I don't think we do.

> If a store to regular memory can be performed before a store to MMIO,
> does a wmb() suffice to enforce an ordering, or do you have to use
> mmiowb()?

On x86, MMIO normally doesn't need memory barriers either for the normal 
case (see above). We don't even need the compiler barrier, because we use 
a "volatile" pointer for that, telling the compiler to keep its hands off.

> Do PCs ever use write-through caching on prefetchable MMIO resources?

Basically only for frame buffers, with MTRR rules (and while write-through 
is an option, normally you'd use "write-combining", which doesn't cache at 
all, but write combines in the write buffers and writes the combined 
results out to the bus - there's usually something like four or eight 
write buffers of up to a cacheline in size for combining).

Yeah, I realize this can be awkward. PC's actually get good performance 
(ie they normally can easily fill the bus bandwidth) _and_ the sw doesn't 
even need to do anything. That's what you get from several decades of hw 
tweaking with a fixed - or almost-fixed - software base.

I _like_ PC's. Almost every other architecture decided to be lazy in hw, 
and put the onus on the software to tell it what was right. The PC 
platform hardware competition didn't allow for the "let's recompile the 
software" approach, so the hardware does it all for you. Very well too.

It does make it somewhat hard for other platforms. 

		Linus
