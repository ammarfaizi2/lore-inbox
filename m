Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267408AbTACGAJ>; Fri, 3 Jan 2003 01:00:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267412AbTACGAJ>; Fri, 3 Jan 2003 01:00:09 -0500
Received: from mta5.snfc21.pbi.net ([206.13.28.241]:62350 "EHLO
	mta5.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S267408AbTACGAE>; Fri, 3 Jan 2003 01:00:04 -0500
Date: Thu, 02 Jan 2003 22:11:53 -0800
From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] generic device DMA (dma_pool update)
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: akpm@digeo.com, James.Bottomley@steeleye.com, linux-kernel@vger.kernel.org
Message-id: <3E1529A9.307@pacbell.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en, fr
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020513
References: <200301022207.OAA00803@adam.yggdrasil.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adam J. Richter wrote:
>>Note that this "add gfp flags to dma_alloc_coherent()" issue is a tangent
>>to the dma_pool topic ... it's a different "generic device DMA" issue.
> 
> 
> 	I think we understand each other, but let's walk through
> the three level of it: mempool_alloc, {dma,pci}_pool_alloc, and
> {dma,pci}_alloc_consistent.
> 
> 	We agree that mempool_alloc should take gfp_flags so that
> it can fail rather than block on optional IO such as read-aheads.

I can imagine code using mempool to implement the __GFP_HIGH "use
emergency pools" behavior.  In the case of USB that'd mean more or
less that GFP_ATOMIC allocations, and many usb-storage paths, might
want to initialize such emergency pools ... freeing into them, or
allocating from them when __GFP_HIGH is specified.


> 	Whether pci_pool_alloc (which does not guarantee a reserve of
> memory) should continue to take gfp_flags is not something we were
> discussing, but is an interesting question for the future.  I see
> that pci_pool_alloc is only called with GFP_ATOMIC in two places:
> 
> 	uhci_alloc_td in drivers/usb/host/uhci-hcd.c
> 	alloc_safe_buffer in arch/arm/mach-sa1100/sa1111-pcibuf.c

And SLAB_* elsewhere, per spec ... :)  There are other places it gets
called, even with SLAB_ATOMIC.  Plus, things like HID and usblp buffer
alloc will be passing down SLAB_KERNEL ... without __GFP_HIGH, so the
allocator clearly shouldn't tap emergency reserves then.

The gfp_flags parameter is a good example of something that shouldn't
be discarded except when it's unavoidable. (Like "I have to hold that
spinlock during this allocation" forcing GFP_ATOMIC.)


> 	The use in uhci_alloc_td means that USB IO can fail under
> memory load.  Conceivably, swapping could even deadlock this way.

That's not new, or just because of UHCI.  There's per-request
allocation happening, and the APIs don't support pre-allocation
of most anything.  Maybe 2.7 should change that.

The LK 2.5 USB calls (not 2.4) will pass gfp_flags down from callers,
with the net effect that many allocations respect __GFP_HIGH, and maybe
even __GFP_WAIT.  Clearly uhci-hcd doesn't; ehci-hcd does, and ohci-hcd
could, with a small patch (longstanding minor peeve).


The problem is that at the next layer down, when pci_pool runs out of
its preallocated pages, it's got to talk to pci_alloc_consistent().

THAT forces pci_pool to discard gfp_flags; the lower levels are
stuck using GFP_ATOMIC.  There lies potential lossage:  it enables
emergency allocations (on x86, this can fragment a zone, and it'd
stay that way since pci_pool won't free pages) when it'd be better
to just block for a moment, or maybe even just fail.  Portably
supporting graceful degradation just isn't in the cards.

Which is why it'd be better if dma_alloc_coherent() took gfp_flags.
That way any allocator layered on top of it won't do dumb things
like that, when the whole stack on top of it is saying "don't!!".



> 	By the way, since you call pci_alloc_consistent's GFP_KERNEL
> semantics "awkward", are you saying that you think it should wait
> indefinitely for memory to become available?

You mean change its semantics so it can't be used in non-sleeping
contexts any more?  No. I didn't like James' notion to change them
so this call _had_ to be used in non-sleeping contexts, either.

The point is that dma_alloc_coherent() shouldn't be making the same
mistake of _precluding_ implementations from implementing __GFP_WAIT,
which might be appropriate, or distinguishing normal allocations from
those that are __GFP_HIGH priority.  (And so on.)

The "awkward" aspect is that pci_alloc_consistent() implementations
may only use GFP_ATOMIC, regardless of whether the caller has better
knowledge of the true restrictions.



> 	It is always reasonable to ask for an example of where a
> requested change would be used, as in specific hardware devices that
> Linux has trouble supporting right now, or specific programs that
> can't be run efficiently under Linux, or some other real external
> benefit, because that is the purpose of software.  This applies to
> every byte of code in Linux.

Then there are basic characteristics that don't work well when
taken out of context.  The context here is that higher level code
is telling lower levels some important things in gfp_flags, but
there's this darn lossy API in between, discarding that information.

Sort of like thinking the shortest difference between two cities
in California involves McLean, Virginia:  that makes no sense.

So:  this is something that a shiny new API introduced a week or
so ago can/should fix ASAP (IMO).  There's no impact on an installed
base, and implementations can reasonably ignore all the gfp_flags
that are really quality-of-service hints ... they have ignored
such information so far, but future code could be smarter.

- Dave


