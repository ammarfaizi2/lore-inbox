Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262574AbUFWXqt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262574AbUFWXqt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 19:46:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262730AbUFWXqt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 19:46:49 -0400
Received: from colin2.muc.de ([193.149.48.15]:62724 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S262574AbUFWXqp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 19:46:45 -0400
Date: 24 Jun 2004 01:46:44 +0200
Date: Thu, 24 Jun 2004 01:46:44 +0200
From: Andi Kleen <ak@muc.de>
To: Terence Ripperda <tripperda@nvidia.com>
Cc: Andi Kleen <ak@muc.de>, discuss@x86-64.org, tiwai@suse.de,
       linux-kernel@vger.kernel.org, andrea@suse.de
Subject: Re: 32-bit dma allocations on 64-bit platforms
Message-ID: <20040623234644.GC38425@colin2.muc.de>
References: <m3acyu6pwd.fsf@averell.firstfloor.org> <20040623213643.GB32456@hygelac>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040623213643.GB32456@hygelac>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 23, 2004 at 04:36:43PM -0500, Terence Ripperda wrote:
> > The x86-64 port had decided early to keep the 16MB GFP_DMA zone
> > to get maximum driver compatibility and because the AMD IOMMU gave
> > us an nice alternative over bounce buffering.
> 
> that was a very understandable decision. and I do agree that using the
> AMD IOMMU is a very nice architecture. it is unfortunate to have to deal
> with this on EM64T. Will AMD's pci-express chipsets still maintain an
> IOMMU, even if it's not needed for AGP anymore? (probably not public
> information, I'll check via my channels).

The IOMMU is actually implemented in the in CPU northbridge on K8 so yes. 
I hope they'll keep it in future CPUs too. 

> 
> > I must say I'm somewhat reluctant to break an working in tree driver.
> > Especially for the sake of an out of tree binary driver. Arguably the
> > problem is probably not limited to you, but it's quite possible that
> > even the in tree DRI drivers have it, so it would be still worth to
> > fix it.
> 
> agreed. I completely understand that there is no desire to modify the
> core kernel to help our driver. that's one of the reasons I looked through
> the other drivers, as I suspect that this is a problem for many drivers. I
> only looked through the code for each briefly, but didn't see anything to
> handle this. I suspect it's more of a case that the drivers have not been
> stress tested on an x86_64 machine w/ 4+ G of memory.

We usually handle it using the swiotlb, which works.

pci_alloc_consistent is limited to 16MB, but so far nobody has really
complained about that. If that should be a real issue we can make
it allocate from the swiotlb pool, which is usually 64MB (and can
be made bigger at boot time) 

Would that work for you too BTW ? How much memory do you expect
to need?

drawback is that the swiotlb pool is not unified with the rest of the VM,
so tying up too much memory there is quite unfriendly.
e.g. if you you can use up 1GB then i wouldn't consider this suitable,
for 128MB max it may be possible.



> > I see two somewhat realistic ways to handle this:
> 
> either of those approaches sounds good. keeping compatibility with older
> devices/drivers is certainly a good thing.
> 
> can the core kernel handle multiple new zones? I haven't looked at the
> code, but the zones seem to always be ZONE_DMA and ZONE_NORMAL, with some
> architectures adding ZONE_HIMEM at the end. if you add a ZONE_DMA_32 (or
> whatever) between ZONE_DMA and ZONE_NORMAL, will the core vm code be able
> to handle that? I guess one could argue if it can't yet, it should be able
> to, then each architecture could create as many zones as they wanted.

Sure, we create multiple zones on NUMA systems (even on x86-64). Each
node has one zone. But they're all ZONE_NORMAL. And the first node 
has two zones, one ZONE_DMA and one ZONE_NORMAL
(actually the others have a ZONE_DMA too, but it's empty) 

Multiple ZONE_DMA zones would be a novelty, but may be doable
(I have not checked all the implications of this, but I don't immediately
see any show stopper, maybe someone like Andrea can correct me on that). 
It will probably be a bit intrusive patch though. 

> 
> another brainstorm: instead of counting on just a large-grained zone and
> call to __get_free_pages() returning an allocation within a given
> bit-range, perhaps there could be large-grained zones, with a fine-grained
> hint used to look for a subset within the zone. for example, there could be
> a DMA32 zone, but a mask w/ 24- or 29- bits enabled could be used to scan
> the DMA32 zone for a valid address. (don't know how well that fits into the
> current architecture).

Not very well. Or rather the allocation would not be O(1) anymore
because you would need to  scan the queues. That could be still
tolerable, but when there are no pages you have to call the VM
and then teach try_to_free_pages and friends that you are only
interested in pages in some mask. And that would probably get 
quite nasty. I did something like this in 2.4 for an old prototype
of the NUMA API, but it never worked very well and also was quite ugly.

Multiple zones are probably better.

One of the reasons we rejected this early when the x86-64 port was
designed was that the VM had quite bad zone balancing problems
at that time. It should be better now though, or at least the NUMA
setup works reasonably well. But NUMA zones tend to be a lot bigger
than DMA zones and don't show all the corner cases.

-Andi
