Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266613AbUFWTTl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266613AbUFWTTl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 15:19:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266615AbUFWTTl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 15:19:41 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:42970 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266613AbUFWTTj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 15:19:39 -0400
Message-ID: <40D9D7BA.7020702@pobox.com>
Date: Wed, 23 Jun 2004 15:19:22 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Terence Ripperda <tripperda@nvidia.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 32-bit dma allocations on 64-bit platforms
References: <20040623183535.GV827@hygelac>
In-Reply-To: <20040623183535.GV827@hygelac>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Terence Ripperda wrote:

Fix your word wrap.


> I'm working on cleaning up some of our dma allocation code to properly allocate 32-bit physical pages for dma on 64-bit platforms. I think our first pass at supporting em64t is sub-par. I'd like to fix that by using the correct kernel interfaces.
> 
>>From our early efforts in supporting AMD's x86_64, we've used the pci_map_sg/pci_map_single interface for remapping > 32-bit physical addresses through the system's IOMMU. Since Intel's em64t does not provide an IOMMU, the kernel falls back to a swiotlb to implement these interfaces. For our first pass at supporting em64t, we tried to work with the swiotlb, but this works very poorly.

swiotlb was a dumb idea when it hit ia64, and it's now been propagated 
to x86-64 :(


> We should have gone back and reviewed how we use the kernel interfaces and followed DMA-API.txt and DMA-mapping.txt. We're now working on using these interfaces (mainly pci_alloc_consistent). but we're still running into some general shortcomings of these interfaces. the main problem is the ability to allocate enough 32-bit addressable memory.
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

FWIW, note that there are two main considerations:

Higher-level layers (block, net) provide bounce buffers when needed, as 
you don't want to do that purely with iommu.

Once you have bounce buffers properly allocated by <something> (swiotlb? 
  special DRM bounce buffer allocator?), you then pci_map the bounce 
buffers.


> the last day or two, I've been experimenting with using the pci_alloc_consistent interface, which uses the later (note attached patch to fix an apparent memory leak in the x86_64 pci_alloc_consistent). unfortunately, this provides very little dma-able memory. In theory, up to 16 Megs, but in practice I'm only getting about 5 1/2 Megs.
> 
> I was rather surprised by these limitations on allocating 32-bit addresses. I checked through the dri and bttv drivers, to see if they had dealt with these issues, and they did not appear to have done so. has anyone tested these drivers on ia64/x86_64/em64t platforms w/ 4+ Gigs of memory?
> 
> are these limitations on allocating 32-bit addresses intentional and known? is there anything we can do to help improve this situation? help work on development?

Sounds like you're not setting the PCI DMA mask properly, or perhaps 
passing NULL rather than a struct pci_dev to the PCI DMA API?

	Jeff


