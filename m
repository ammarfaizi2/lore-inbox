Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267286AbTABWAo>; Thu, 2 Jan 2003 17:00:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267279AbTABWAJ>; Thu, 2 Jan 2003 17:00:09 -0500
Received: from h-64-105-35-183.SNVACAID.covad.net ([64.105.35.183]:14737 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S267286AbTABV7X>; Thu, 2 Jan 2003 16:59:23 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Thu, 2 Jan 2003 14:07:46 -0800
Message-Id: <200301022207.OAA00803@adam.yggdrasil.com>
To: david-b@pacbell.net
Subject: Re: [PATCH] generic device DMA (dma_pool update)
Cc: akpm@digeo.com, James.Bottomley@steeleye.com, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Note that this "add gfp flags to dma_alloc_coherent()" issue is a tangent
>to the dma_pool topic ... it's a different "generic device DMA" issue.

	I think we understand each other, but let's walk through
the three level of it: mempool_alloc, {dma,pci}_pool_alloc, and
{dma,pci}_alloc_consistent.

	We agree that mempool_alloc should take gfp_flags so that
it can fail rather than block on optional IO such as read-aheads.

	Whether pci_pool_alloc (which does not guarantee a reserve of
memory) should continue to take gfp_flags is not something we were
discussing, but is an interesting question for the future.  I see
that pci_pool_alloc is only called with GFP_ATOMIC in two places:

	uhci_alloc_td in drivers/usb/host/uhci-hcd.c
	alloc_safe_buffer in arch/arm/mach-sa1100/sa1111-pcibuf.c

	The use in uhci_alloc_td means that USB IO can fail under
memory load.  Conceivably, swapping could even deadlock this way.
uhci_alloc_td should be going through a mempool which individual
drivers should expand and shrink as they are added and removed so that
transfers that are sent with GFP_KERNEL will be guaranteed not to fail
for lack of memory (and gfp_flags should be passed down so that it
will be possible to abort transfers like read-aheads rather than
blocking, but that's not essential).

	The pci_pool_alloc  in sa1111-buf.c is more interesting.
alloc_safe_buffer is used to implement an unusual version of
pci_map_single.  It is unclear to me whether this approach is optimal.
I'll look into this more.

	Anyhow, the question that we actually were talking about is
whether dma_alloc_consistent should take gfp_flags.  So far, the only
potential example that I'm aware of is that the question of whether the
call to pci_pool_alloc in sa1111-pcibuf.c needs.to call down to
{pci,dma}_alloc_consistent with GFP_ATOMIC.  It's something that I
just noticed and will look into.


>We already have the pci_pool allocator that knows how to cope (timeout and
>retry) with the awkward semantics of pci_alloc_consistent() ...

	pci_pool_alloc currently implments mempool's GFP_KERNEL
semantics (block indefinitely, never fail), but, unlike mempool, it
does not guarantee a minimum memory allocation, so there is no way
to guarantee that it will ever return.  It can hang if there is
insufficient memory.  It looks like you cannot even control-C out
of it.

	By the way, since you call pci_alloc_consistent's GFP_KERNEL
semantics "awkward", are you saying that you think it should wait
indefinitely for memory to become available?

>likewise,
>we can tell that those semantics are problematic, both because they need
>that kind of workaround and because they complicate reusing "better"
>allocator code (like mm/slab.c) on top of the DMA page allocators.

	Maybe it's irrelevant, but I don't understand what you mean by
"better" here.


>> 	Let me clarify or revise my request.  By "show me or invent an
>> example" I mean describe a case where this would be used, as in
>> specific hardware devices that Linux has trouble supporting right now,
>> or specific programs that can't be run efficiently under Linux, etc.

>That doesn't really strike me as a reasonable revision, since that
>wasn't an issue an improved dma_alloc_coherent() syntax was intended
>to address directly.

	It is always reasonable to ask for an example of where a
requested change would be used, as in specific hardware devices that
Linux has trouble supporting right now, or specific programs that
can't be run efficiently under Linux, or some other real external
benefit, because that is the purpose of software.  This applies to
every byte of code in Linux.

	Don't start by positing some situation in the middle of a
call graph.  Instead, I'm asking you to show an example starting
at the top of the call graph.  What *actual* use will cause this
parameter to be useful in reality?  By what external metric
will users benefit?

	I'll look into the sa1111-pcibuf.c case.  That's the only
potential example that I've seen so far.


>To the extent that it's reasonable, you should also be considering
>this corresponding issue:  ways that removing gfp_flags from the
>corresponding generic memory allocator, __get_free_pages(), would be
>improving those characteristics of Linux.  (IMO, it wouldn't.)

	There are other users of __get_free_pages.  If it turns out
that there is no true use for gfp_mask in dma_alloc_consistent then it
might be worth exploring in the future, but we don't have to decide to
eliminate gfp_mask from __get_free_pages just to decide not to add it
to dma_alloc_consistent.


>> 	I have trouble understanding why, for example, a USB hard
>> disk driver would want anything more than a fixed size pool of
>> transfer descriptors.  At some point you know that you've queued
>> enough IO so that the driver can be confident that it will be
>> called again before that queue is completely emptied.

>For better or worse, that's not how it works today and it's not
>likely to change in the 2.5 kernels.  "Transfer Descriptors" are
>resources inside host controller drivers (bus drivers), allocated
>dynamically (GFP_KERNEL in many cases, normally using a pci_pool)
>when USB device drivers (like usb-storage) submit requests (URBs).

>They are invisible to usb device drivers, except implicitly as
>another reason that submitting an urb might trigger -ENOMEM.

	It might not be trivial to fix that but it would be
straightforward to do so.  In the future, submit_urb(...GFP_KERNEL)
should be guaranteed never to fail with -ENOMEM (see my comments
about uhci_alloc_td above on how to fix this).

	This existing straighforwardly fixable bug does not justify
changing the DMA API just to encrust it further.  Users will be better
off if we fix the bug (it will be able to swap reliably on USB disks,
or at least they'll be closer to it if there are other bugs in the
way).

	In practice, I think that if we just added one, maybe two,
URB's by default for every endpoint when a device is added, that
that would be enough to guarantee that would reduce the number of
drivers that needed to reserve more URB's than that to few or none.

>And for that matter, the usb-storage driver doesn't "fire and
>forget" as you described; that'd be a network driver model.
>The storage driver needs to block till its request completes.

	That only makes it easier to calculate the number of
URB's that need to be guaranteed to be available.

	By the way, as far as I can tell, usb_stor_msg_common in
drivers/usb/storage/transport.c only waits for the urb to be
transferred, not for the operation to complete.


>> 	Also, your use of the term GFP_KERNEL is potentially
>> ambiguous.  In some cases GFP_KERNEL seems to mean "wait indifinitely
>> until memory is available; never fail."  In other cases it means
>> "perhaps wait a second or two if memory is unavailable, but fail if
>> memory is not available by then."

>Hmm, I was unaware that anyone expected GFP_KERNEL (or rather,
>__GFP_WAIT) to guarantee that memory was always returned.  It's
>not called __GFP_NEVERFAIL, after all.

	mempool_alloc does.  That's the point of it.  You calculate
how many objects you need in order to guarantee no deadlocks and
reserve that number in advance (the initial reservation can fail).

>I've always seen such fault returns documented as unrelated to
>allocator parameters ...

	By design, mempool_alloc(GFP_KERNEL) never fails (although
mempool_alloc(GFP_ATOMIC) can).

	By the way, pci_pool_alloc(GFP_KERNEL) also never returns
failure, but I consider that a bug as I explained above.

>and treated callers that break on fault
>returns as buggy, regardless of GFP_* parameters in use.

	It is not a bug for mempool_alloc(GFP_KERNEL) callers to assume
success upon return.  It is a wasete of kernel footprint for them to
check for failure.

>A
>random sample of kernel docs agrees with me on that:  both
>in Documentation/* (like the i2c stuff) or the O'Reilly book
>on device drivers.

	mempool really needs a file in Documentation/.  The only reference
to it there is in linux-2.5.54/Documentation/block/biodoc.txt, line 663 ff:
| This makes use of Ingo Molnar's mempool implementation, which enables
| subsystems like bio to maintain their own reserve memory pools for guaranteed
| deadlock-free allocations during extreme VM load. [...]

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
