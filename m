Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261358AbUFWVvv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261358AbUFWVvv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 17:51:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261169AbUFWVtv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 17:49:51 -0400
Received: from zero.aec.at ([193.170.194.10]:12807 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S261763AbUFWVqf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 17:46:35 -0400
To: Terence Ripperda <tripperda@nvidia.com>
cc: discuss@x86-64.org, tiwai@suse.de, linux-kernel@vger.kernel.org
Subject: Re: 32-bit dma allocations on 64-bit platforms
References: <2akPm-16l-65@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
In-Reply-To: <2akPm-16l-65@gated-at.bofh.it> (Terence Ripperda's message of
 "Wed, 23 Jun 2004 20:40:16 +0200")
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.2 (gnu/linux)
Date: Wed, 23 Jun 2004 23:46:31 +0200
Message-ID: <m38yee6j7s.fsf@averell.firstfloor.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Terence Ripperda <tripperda@nvidia.com> writes:

[sending again with linux-kernel in cc]

> I'm working on cleaning up some of our dma allocation code to properly allocate 32-bit physical pages for dma on 64-bit platforms. I think our first pass at supporting em64t is sub-par. I'd like to fix that by using the correct kernel interfaces.

I get from this that your hardware cannot DMA to >32bit.
>
> the physical addressing of memory allocations seems to boil down to the behavior of GFP_DMA and GFP_NORMAL. but there seems to be some disconnect between what these mean for each architecture and what various drivers expect them to mean.
>
> based on each architecture's paging_init routines, the zones look like this:
>
>                 x86:         ia64:      x86_64:
> ZONE_DMA:       < 16M        < ~4G      < 16M
> ZONE_NORMAL:    16M - ~1G    > ~4G      > 16M
> ZONE_HIMEM:     1G+
>
> an example of this disconnect is vmalloc_32. this function is obviously intended to allocate 32-bit addresses (this was specifically mentioned in a comment in 2.4.x header files). but vmalloc_32 is an inline routine that calls __vmalloc(GFP_KERNEL). based on the above zone descriptions, this will do the correct thing for x86, but not for ia64 or x86_64. on ia64, a driver could just use GFP_DMA for the desired behavior, but this doesn't work well for x86_64.
>
> AMD's x86_64 provides remapping > 32-bit pages through the iommu, but obviously Intel's em64t provides no such ability. based on the above zonings, these leaves us with the options of either relying on the swiotlb interfaces for dma, or relying on the isa memory for dma.
>
> the last day or two, I've been experimenting with using the pci_alloc_consistent interface, which uses the later (note attached patch to fix an apparent memory leak in the x86_64 pci_alloc_consistent). unfortunately, this provides very little dma-able memory. In theory, up to 16 Megs, but in practice I'm only getting about 5 1/2 Megs.
>
> I was rather surprised by these limitations on allocating 32-bit addresses. I checked through the dri and bttv drivers, to see if they had dealt with these issues, and they did not appear to have done so. has anyone tested these drivers on ia64/x86_64/em64t platforms w/ 4+ Gigs of memory?
>
> are these limitations on allocating 32-bit addresses intentional and known? is there anything we can do to help improve this situation? help work on development?

First vmalloc_32 is a rather broken interface and should imho
just be removed. The function name just gives promises that cannot
be kept. It was always quite bogus. Please don't use it.

The situation on EM64T is very unfortunate I agree. There was a reason
we asked AMD to add an IOMMU and it's quite bad that the Intel chipset
people ignored that wisdom and put us into this compatibility mess.

Failing that it would be best if the other PCI DMA hardware
could just address enough memory, but that's less realistic
than just fixing the chipset. 

The x86-64 port had decided early to keep the 16MB GFP_DMA zone
to get maximum driver compatibility and because the AMD IOMMU gave
us an nice alternative over bounce buffering.

In theory I'm not totally against enlarging GFP_DMA a bit on x86-64.
It would just be difficult to find a good value. The problem is that
that there may be existing drivers that rely on the 16MB limit, and it
would not be very nice to break them. We got rid of a lot of them by
disallowing CONFIG_ISA, but there may be some left. So before doing
this it would need a full driver tree audit to check any device

The most prominent example used to be the floppy driver, but the
current floppy driver seems to use some other way to get around this.

There seem to be quite some sound chipsets with DMA limits < 32bit;
e.g. 29 bits seems to be quite common, but I see several 24bit PCI ones 
too. 

I must say I'm somewhat reluctant to break an working in tree driver.
Especially for the sake of an out of tree binary driver. Arguably the
problem is probably not limited to you, but it's quite possible that
even the in tree DRI drivers have it, so it would be still worth to
fix it. 

I see two somewhat realistic ways to handle this: 

- We enlarge GFP_DMA and find some way to do double buffering
for these sound drivers (it would need an PCI-DMA API extension
that always calls swiotlb for this) 
For sound that's not too bad, because they are relatively slow.
It would require to reserve bootmem memory early for the bounces, 
but I guess requiring the user to pass a special boot time parameter
for these devices would be reasonable.

If yes someone would need to do this work. 
Also the question would be how large to make GFP_DMA
Ideally it should not be too big, so that e.g. 29bit devices don't
require the bounce buffering. 

- We introduce multiple GFP_DMA zones and keep 16MB GFP_DMA 
and GFP_BIGDMA or somesuch for larger DMA.

The VM should be able to handle this, but it may still require
some tuning. It would need some generic changes, but not too bad.
Still would need a decision on how big GFP_BIGDMA should be. 
I suspect 4GB would be too big again.

Comments?

-Andi


