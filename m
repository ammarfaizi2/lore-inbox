Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265955AbUFXQQs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265955AbUFXQQs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 12:16:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265970AbUFXQQs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 12:16:48 -0400
Received: from cantor.suse.de ([195.135.220.2]:5839 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S265955AbUFXQQl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 12:16:41 -0400
Date: Thu, 24 Jun 2004 18:15:40 +0200
From: Andi Kleen <ak@suse.de>
To: Terence Ripperda <tripperda@nvidia.com>
Cc: Andi Kleen <ak@muc.de>, discuss@x86-64.org, tiwai@suse.de,
       linux-kernel@vger.kernel.org, andrea@suse.de
Subject: Re: [discuss] Re: 32-bit dma allocations on 64-bit platforms
Message-ID: <20040624161539.GC8085@wotan.suse.de>
References: <20040623234644.GC38425@colin2.muc.de> <20040624154429.GC8014@hygelac>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040624154429.GC8014@hygelac>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 24, 2004 at 10:44:29AM -0500, Terence Ripperda wrote:
> On Wed, Jun 23, 2004 at 04:46:44PM -0700, ak@muc.de wrote:
> > pci_alloc_consistent is limited to 16MB, but so far nobody has really
> > complained about that. If that should be a real issue we can make
> > it allocate from the swiotlb pool, which is usually 64MB (and can
> > be made bigger at boot time) 
> 
> In all of the cases I've seen, it defaults to 4M. in swiotlb.c,
> io_tlb_nslabs defaults to 1024, * PAGE_SIZE == 4194304.

Oops, that should be probably fixed. I think it was 64MB 
at some point ... 

4MB is definitely far too small.

> probably the biggest problem is that the size is way too small for our
> needs (more on our memory usage shortly). this is compounded by the
> the swiotlb code throwing a kernel panic when it can't allocate
> memory. and if the panic doesn't halt the machine, the routine returns
> a random value off the stack as the dma_addr_t.

That sounds like a bug too. pci_map_sg should return 0 when it overflows. 
The gart iommu code will do that.  I'll take a look, need to convince
the IA64 people of any changes though (I just reused their code) 

Newer pci_map_single also got a "bad_dma_adress" magic return value
to check for this, but some also just panic.

> also, the proper usage of using the bounce buffers and calling 
> pci_dma_sync_* would be a performance killer for us. we stream a
> considerable amount of data to the gpu per second (on the order of
> 100s of Megs a second), so having to do an additional memcpy would
> reduce performance considerably, in some cases between 30-50%.

Understood.

> finally, our driver already uses a considerable amount of memory. by
> definition, the swiotlb interface doubles that memory usage. if our
> driver used swiotlb correctly (as in didn't know about swiotlb and
> always called pci_dma_sync_*), we'd lock down the physical addresses
> opengl writes to, since they're normally used directly for dma, plus
> the pages allocated from the swiotlb would be locked down (currently
> we manually do this, but if swiotlb is supposed to be transparent to
> the driver and used for dma, I assume it must already be locked down,
> perhaps by definition of being bootmem?). this means not only is the

It's allocated once at boot and never freed or increased.
(the reason is that these functions must all work inside 
spinlocks and cannot sleep, and you cannot do anything serious
to the VM with that constraint) - arguably it would have been
much nicer to pass them a GFP flag and do sleeping for bounce
memory and GFP_KERNEL allocations etc.instead of the dumb
panics on overflow. Maybe something for 2.7.

> in this case, it almost would make more sense to treat the bootmem
> allocated for swiotlb as a pool of 32-bit memory that can be directly
> allocated from, rather than as bounce buffers. I don't know that this
> would be an acceptable interface though.

Ok, that was one of my proposals too (using it for pci_alloc_consistent).

But again it would only help if the memory requirements are relatively
moderate.

> but if we could come up with reasonable solutions to these problems,
> this may work.
> 
> > drawback is that the swiotlb pool is not unified with the rest of the
> > VM, so tying up too much memory there is quite unfriendly.
> > e.g. if you you can use up 1GB then i wouldn't consider this suitable,
> > for 128MB max it may be possible.
> 
> I checked with our opengl developers on this. by default, we allocate
> ~64k for X's push buffer and ~1M per opengl client for their push
> buffer. on quadro/workstation parts, we allocate 20M for the first
> opengl client, then ~1M per client after that.

Oh, that sounds quite moderate. Ok, then we probably don't need the 
GFP_BIGDMA zone just for you. Great.

> 
> in addition to the push buffer, there is a lot of data that apps dump
> to the push buffer. this includes textures, vertex buffers, display
> lists, etc. the amount of memory used for this varies greatly from app
> to app. the 20M listed above includes the push buffer and memory for
> these buffers (I think workstation apps tend to push a lot more
> pre-processed vertex data to the gpu).


Overall it sounds more like you need 128MB though - especially
since we cannot give everything to you, but also still need
some memory for SATA and other devices with limited addressing
capability (fortunately they slowly get fixed now) 

I would prefer if the default value would work for most users
because any special options are a very high support load.
Do you think 64MB (minus other users so maybe 30-40MB in practice)  
would be still sufficient to give reasonable performance without
hickups?

> 
> note that most agp apertures these days are in the 128M - 1024M range,
> and there are times that we exhaust that memory on the low end. I

Yes, I have the same problem with the IOMMU. The IOMMU makes it 
actually worse, because it reserves half of the aperture
(so you may get only 64MB IOMMU/AGP aperture in the worst case)

But it can be increased in the BIOS and the kernel has code
to get a larger aperture too)

> think our driver is greedy when trying to allocate memory for
> performance reasons, but has good fallback cases. so being somewhat
> limited on resources isn't too bad, just so long as the kernel doesn't
> panic instead of falling the memory allocation.

Agreed, the panics should be made optional at least. I will
take a look at doing this for swiotlb too. I like
them as options though because for debugging it's better to get
a clear panic than a weird malfunction.

> also remember future growth. PCI-E has something like 20/24 lanes that
> can be split among multiple PCI-E slots. Alienware has already
> announced multi-card products, and it's likely multi-card products
> will be more readily available on PCI-E, since the slots should have
> equivalent bandwidth (unlike AGP+PCI).
> 
> nvidia has also had workstation parts in the past with 2 gpus and a
> bridge chip. each of these gpus ran twinview, so each card drove 4
> monitors. these were pci cards, and some crazy vendors had 4+ of these
> cards in a machine driving many monitors. this just pushes the memory
> requirements up in special circumstances.

But why didn't you implement addressing capability for >32bit
in your hardware then? I imagine the memory requirements won't 
stop at 4GB (or rather 2-3GB because not all phys mapping
space below 4GB can be dedicated to graphics) 

It sounds a bit weird to have such extreme requirements and then
cripple the hardware like this.

Anyways - for such extreme applications i think it's perfectly
reasonable to require the user to pass special boot options and
tie up much memory.

-Andi

