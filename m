Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750712AbVKQJMJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750712AbVKQJMJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 04:12:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750715AbVKQJMI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 04:12:08 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:5128 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1750712AbVKQJL5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 04:11:57 -0500
Date: Thu, 17 Nov 2005 10:13:09 +0100
From: Jens Axboe <axboe@suse.de>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: IOMMU and scatterlist limits
Message-ID: <20051117091308.GZ7787@suse.de>
References: <437C40AE.2020309@drzeus.cx> <20051117085432.GY7787@suse.de> <437C4728.9060205@drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <437C4728.9060205@drzeus.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17 2005, Pierre Ossman wrote:
> Jens Axboe wrote:
> > On Thu, Nov 17 2005, Pierre Ossman wrote:
> >   
> >> I'm writing a PCI driver for the first time and I'm trying to wrap my
> >> head around the DMA mappings in that world. I've done a ISA driver which
> >> uses DMA, but this is a bit more complex and the documentation doesn't
> >> explain everything.
> >>
> >> What I'm particularly confused about is how the IOMMU should be handled
> >> with regard to scatterlist limits. My hardware cannot handle
> >> scatterlists, only a single DMA address. But from what I understand the
> >>     
> >
> > What kind of hardware can't handle scatter gather?
> >
> >   
> 
> I'd figure most hardware? DMA is handled by writing the start address
> into one register and a size into another. Being able to set several
> addr/len pairs seems highly advanced to me. :)

Must be a pretty nice rock you are living behind, since it's apparently
kept you there for a long time :-)

Sane hardware will accept an sg list directly. Are you sure you are
reading the specifications for that hardware correctly?

> >> IOMMU can be very similar to a normal "CPU" MMU. So it should be able to
> >> aggregate pages that are non-continuous in physical memory into one
> >> single block in bus memory. Now the question is what do I set
> >> nr_phys_segments and nr_hw_segments to? Of course the code also needs to
> >> handle systems without an IOMMU.
> >>     
> >
> > nr_hw_segments is how many segments your driver will see once dma
> > mapping is complete (and the IOMMU has done its tricks), so you want to
> > set that to 1 if the hardware can't handle an sg list.
> >
> >   
> 
> And nr_phys_segments? I haven't really grasped the relation between the
> two. Is this the number of segments handed to the IOMMU? If so, then I
> would need to know how many it can handle (and set it to one if there is
> no IOMMU).

nr_phys_segments is basically just to cap the segments somewhere, since
the driver needs to store it before getting it dma mapped to a (perhaps)
smaller number of segments. So yes, it's the number of 'real' segments
before dma mapping.

> > That'll work irregardless of whether there's an IOMMU there or not. Note
> > that the mere existence of an IOMMU will _not_ save your performance on
> > this hardware, you need one with good virtual merging support to get
> > larger transfers.
> >
> >   
> 
> I thought the IOMMU could do the merging through its mapping tables? The
> way I understood it, sg support in the device was just to avoid wasting
> resources on the IOMMU by using fewer mappings (which would assume the
> IOMMU is segment based, not page based).

Depends on the IOMMU. Some IOMMUs just help you with address remapping
for high addresses. The way I see it, with just 1 segment you need to be
pretty damn picky with your hardware about what platform you use it on
or risk losing 50% performance or so.

-- 
Jens Axboe

