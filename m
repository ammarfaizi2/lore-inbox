Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750715AbVKQJho@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750715AbVKQJho (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 04:37:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750717AbVKQJho
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 04:37:44 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:42557 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1750715AbVKQJho (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 04:37:44 -0500
Date: Thu, 17 Nov 2005 10:38:48 +0100
From: Jens Axboe <axboe@suse.de>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: IOMMU and scatterlist limits
Message-ID: <20051117093848.GA7787@suse.de>
References: <437C40AE.2020309@drzeus.cx> <20051117085432.GY7787@suse.de> <437C4728.9060205@drzeus.cx> <20051117091308.GZ7787@suse.de> <437C4D14.1030101@drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <437C4D14.1030101@drzeus.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17 2005, Pierre Ossman wrote:
> Jens Axboe wrote:
> > On Thu, Nov 17 2005, Pierre Ossman wrote:
> >   
> >> Jens Axboe wrote:
> >>     
> >>>     
> >>>       
> >>> What kind of hardware can't handle scatter gather?
> >>>
> >>>   
> >>>       
> >> I'd figure most hardware? DMA is handled by writing the start address
> >> into one register and a size into another. Being able to set several
> >> addr/len pairs seems highly advanced to me. :)
> >>     
> >
> > Must be a pretty nice rock you are living behind, since it's apparently
> > kept you there for a long time :-)
> >
> >   
> 
> The driver support is simply too good in Linux so I haven't had the need
> for writing a PCI driver until now. ;)

;-)

> > Sane hardware will accept an sg list directly. Are you sure you are
> > reading the specifications for that hardware correctly?
> >
> >   
> 
> Specifications? Such luxury. This driver is based on googling and
> reverse engineering. Any requests for specifications have so far been
> put in the round filing cabinet.
> 
> What I know is that I have the registers:
> 
> * System address (32 bit)
> * Block size (16 bit)
> * Block count (16 bit)

Sounds like a pretty simple device, then. Any device engineered for any
kind of at least half serious performance would accept more than just a
address/length tupple.

> >From what I've seen these are written to once. So I'm having a hard time
> believing these support more than one segment.
> 
> >>>   
> >>>       
> >> And nr_phys_segments? I haven't really grasped the relation between the
> >> two. Is this the number of segments handed to the IOMMU? If so, then I
> >> would need to know how many it can handle (and set it to one if there is
> >> no IOMMU).
> >>     
> >
> > nr_phys_segments is basically just to cap the segments somewhere, since
> > the driver needs to store it before getting it dma mapped to a (perhaps)
> > smaller number of segments. So yes, it's the number of 'real' segments
> > before dma mapping.
> >
> >   
> 
> So from a driver point of view, this is just a matter of memory usage?
> In that case, what is a good value? =)

Yep. A good value depends on how big a transfer you can support anyways
and how fast the device is. And how much you potentially gain by doing
larger transfers as compared to small. The block layer default is 128
segments, but that's probably too big for you. Something like 16 should
still give you at least 64kb transfers.

> Since there is no guarantee this will be mapped down to one segment
> (that the hardware can accept), is it expected that the driver iterates
> over the entire list or can I mark only the first segment as completed
> and wait for the request to be reissued? (this is a MMC driver, which
> behaves like the block layer)

Ah MMC, that explains a few things :-)

It's quite legal (and possible) to partially handle a given request, you
are not obliged to handle a request as a single unit. See how other
block drivers have an end request handling function ala:

void my_end_request(struct hw_struct *hw, struct request *rq,
                    int nbytes, int uptodate)
{
        ...

        if (!end_that_request_chunk(rq, uptodate, nbytes)) {
                blkdev_dequeue_request(rq);
                end_that_request_last(rq);
        }

        ...
}

elv_next_request() will keep giving you the same request until you have
dequeued and ended it, so you don't have to keep track of the 'current'
request. end_that_request_*() will make sure the request state is sane
after each call as well, so you can treat the request as a new one every
time. Doing partial requests is not harder than doing full requests.

> >>> That'll work irregardless of whether there's an IOMMU there or not. Note
> >>> that the mere existence of an IOMMU will _not_ save your performance on
> >>> this hardware, you need one with good virtual merging support to get
> >>> larger transfers.
> >>>
> >>>   
> >>>       
> >> I thought the IOMMU could do the merging through its mapping tables? The
> >> way I understood it, sg support in the device was just to avoid wasting
> >> resources on the IOMMU by using fewer mappings (which would assume the
> >> IOMMU is segment based, not page based).
> >>     
> >
> > Depends on the IOMMU. Some IOMMUs just help you with address remapping
> > for high addresses. The way I see it, with just 1 segment you need to be
> > pretty damn picky with your hardware about what platform you use it on
> > or risk losing 50% performance or so.
> >
> >   
> 
> Ok. Being a block device, the segments are usually rather large so the
> overhead of setting up many DMA transfers shouldn't be that terrible.

The segments will typically be paged size, so could be worse. It all
depends on what your command overhead is like whether it hurts
performance a lot or not.

-- 
Jens Axboe

