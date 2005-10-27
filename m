Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751578AbVJ0UIL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751578AbVJ0UIL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 16:08:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751580AbVJ0UIL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 16:08:11 -0400
Received: from hera.kernel.org ([140.211.167.34]:15756 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1751578AbVJ0UIJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 16:08:09 -0400
Date: Thu, 27 Oct 2005 13:01:42 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Magnus Damm <magnus.damm@gmail.com>
Cc: Christoph Lameter <clameter@sgi.com>, akpm@osdl.org,
       Mike Kravetz <kravetz@us.ibm.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: [PATCH 0/4] Swap migration V3: Overview
Message-ID: <20051027150142.GE13500@logos.cnet>
References: <20051020225935.19761.57434.sendpatchset@schroedinger.engr.sgi.com> <aec7e5c30510201857r7cf9d337wce9a4017064adcf@mail.gmail.com> <20051022005050.GA27317@logos.cnet> <aec7e5c30510230550j66d6e37fg505fd6041dca9bee@mail.gmail.com> <20051024074418.GC2016@logos.cnet> <aec7e5c30510250437h6c300066s14e39a0c91be772c@mail.gmail.com> <20051025143741.GA6604@logos.cnet> <aec7e5c30510260004p5a3b07a9v28ae67b2982f1945@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aec7e5c30510260004p5a3b07a9v28ae67b2982f1945@mail.gmail.com>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Magnus!

On Wed, Oct 26, 2005 at 04:04:18PM +0900, Magnus Damm wrote:
> Hi again Marcelo,
> 
> On 10/25/05, Marcelo Tosatti <marcelo.tosatti@cyclades.com> wrote:
> > On Tue, Oct 25, 2005 at 08:37:52PM +0900, Magnus Damm wrote:
> > > DMA: each page has been scanned ~37 times
> > > Normal: each page has been scanned ~15 times
> > > HighMem: each page has been scanned ~18 times

Can you verify if there are GFP_DMA allocations happening on this box?

A search for GFP_DMA in the current v2.6 tree shows mostly older network
drivers, older sound drivers, and SCSI (which needs to cope with older
ISA cards).

Ah, now I remember an interesting fact. balance_pgdat(), while
doing reclaim zone iteration in the DMA->highmem direction, uses
SWAP_CLUSTER_MAX (32) as the number of pages to reclaim for every zone,
independently of zone size.

Thats clearly unfair when you think that the ratio between normal/dma
zone sizes is much higher than the ratio of normal/dma _freed pages_
(needs to be confirmed with real numbers). Only the amount of pages to
scan (sc->nr_to_scan) is relative to zone size.

While playing with ARC (http://www.linux-mm.org/AdvancedPageReplacement)
ideas earlier this year I noticed that the reclaim work on the DMA
zone was excessive (which, I thought at the time, was entirely due to
modified shrink_zone logic). The fair approach would be to have the
number of pages to reclaim also relative to zone size.

sc->nr_to_reclaim = (zone->present_pages * sc->swap_cluster_max) /
                                total_memory;

Which worked very well under said situation, having the reclaim work
back to apparent fairness. Maybe you can try something similar with a
stock kernel?

Full patch can be found at
http://marc.theaimsgroup.com/?l=linux-mm&m=112387857203221&w=2

However I did not notice the issue with vanilla at the time, a quick
look at its numbers seemed to exhibit fair behaviour (your numbers
disagree though).

The benchmark I was using: dbench. Not very much of a meaningful test.

Ah, I had split up the "pgfree" counter exported in /proc/vmstat to be
per-zone so I could see the differences (you could enhance your tscanned
patch to count for freed pages).

Another useful number in this game which is not available at the moment
AFAIK is relative pressure (number of allocations divided by zone size).

> > > So if your user space page happens to be allocated from the DMA zone,
> > > it looks like it is more probable that it will be paged out sooner
> > > than if it was allocated from another zone. And this is on a half year
> > > old P4 system.
> >
> > Well the higher relative pressure on a specific zone is a fact you have
> > to live with.
> 
> Yes, and even if the DMA zone was removed we still would have the same
> issue with highmem vs lowmem.

Yep.

> > Even with a global LRU you're going to suffer from the same issue once
> > you've got different relative pressure on different zones.
> 
> Yep, the per-node LRU will not even out the pressure. But my main
> concern is rather the side effect of the pressure difference than the
> pressure difference itself.
> 
> The side effect is that the "wrong" pages may be paged out in a
> per-zone LRU compared to a per-node LRU. This may or may not be a big
> deal for performance.
> 
> > Thats the reason for the mechanisms which attempt to avoid allocating
> > from the lower precious zones (lowmem_reserve and the allocation
> > fallback logic).
> 
> Exactly. But will this logic always work well? With some memory
> configurations the normal zone might be smaller than the DMA zone. And
> the same applies for highmem vs normal zone.

It should - but I'm not sure really.

Andrea, Andrew, Nick et all have been doing most of the tuning in 2.6.

> I'm not sure, but doesn't the size of the zones somehow relate to the
> memory pressure?

Yep. Ratio between number of allocations to a given zone versus zone size
can be though of as "relative pressure".

Smaller the zone, higher the pressure.

> > > > > There are probably not that many drivers using the DMA zone on a
> > > > > modern PC, so instead of bringing performance penalty on the entire
> > > > > system I think it would be nicer to punish the evil hardware instead.
> > > >
> > > > Agreed - the 16MB DMA zone is silly. Would love to see it go away...
> > >
> > > But is the DMA zone itself evil, or just that we have one LRU per zone...?
> >
> > I agree that per-zone LRU complicates global page aging (you simply don't have
> > global aging).
> >
> > But how to deal with restricted allocation requirements otherwise?
> > Scanning several GB's worth of pages looking for pages in a specific
> > small range can't be very promising.
> 
> I'm not sure exactly how much of the buddy allocator design that
> currently is used by the kernel, but I suspect that 99.9% of all
> allocations are 0-order. So it probably makes sense to optimize for
> such a case.
> 
> Maybe it is possible to scrap the zones and instead use:
> 
> 0-order pages without restrictions (common case):
> Free pages in the node are chained together and either kept on one
> list (64 bit system or 32 bit system without highmem) or on two lists;
> one for lowmem and one for highmem. Maybe per cpu lists should be used
> on top of this too.
> 
> Other pages (>0-order, special requirements):
> Each node has a bitmap where pages belonging to the node are
> represented by one bit each. Each bit is used to determine if the
> per-page status. A value of 0 means that the page is used/reserved,
> and a 1 means that the page is either free or allocated somehow but it
> is possible migrate or page out the data.
> 
> So a page marked as 1 may be on the 0-order list, in use on some LRU,
> or maybe even migratable SLAB.
> 
> The functions in linux/bitmap.h or asm/bitops.h are then used to scan
> through the bitmap to find contiguous pages within a certain range of
> pages. This allows us to fulfill all sorts of funky requirements such
> as alignment or "within N address bits".
> 
> The allocator should of course prefer free pages over "used but
> migratable", but if no free pages exist to fulfill the requirement,
> page migration is used to empty the contiguous range.
> 
> The drawback of the idea above is of course the overhead (both memory
> and cpu) introduced by the bitmap. But the allocator above may be more
> successful for N-order allocations than the buddy allocator since the
> pages doesn't have to be aligned. The allocator will probably be even
> more successful if page migration is used too.
> 
> And then you have a per-node LRU on top of the above. =)

Yep, sounds feasible.

An interesting test on x86 would be to have all ZONE_NORMAL pages in
ZONE_DMA (which is what arches with no accessability limitation do).
That way we could see the impact of managing the 16MB ZONE_DMA.

I like the idea of penalizing the 16MB limited users in favour of
increasing global aging efficiency as you suggest.

After all such hardware will become more ancient and rare as time moves.
