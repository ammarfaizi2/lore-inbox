Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265746AbUFXPrq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265746AbUFXPrq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 11:47:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265749AbUFXPrq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 11:47:46 -0400
Received: from hqemgate00.nvidia.com ([216.228.112.144]:528 "EHLO
	hqemgate00.nvidia.com") by vger.kernel.org with ESMTP
	id S265746AbUFXPrf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 11:47:35 -0400
Date: Thu, 24 Jun 2004 10:44:29 -0500
From: Terence Ripperda <tripperda@nvidia.com>
To: Andi Kleen <ak@muc.de>
Cc: Terence Ripperda <tripperda@nvidia.com>, discuss@x86-64.org, tiwai@suse.de,
       linux-kernel@vger.kernel.org, andrea@suse.de
Subject: Re: 32-bit dma allocations on 64-bit platforms
Message-ID: <20040624154429.GC8014@hygelac>
Reply-To: Terence Ripperda <tripperda@nvidia.com>
References: <20040623234644.GC38425@colin2.muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040623234644.GC38425@colin2.muc.de>
User-Agent: Mutt/1.4i
X-Accept-Language: en
X-Operating-System: Linux hrothgar 2.4.23
X-OriginalArrivalTime: 24 Jun 2004 15:47:29.0743 (UTC) FILETIME=[8E529DF0:01C45A02]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 23, 2004 at 04:46:44PM -0700, ak@muc.de wrote:
> pci_alloc_consistent is limited to 16MB, but so far nobody has really
> complained about that. If that should be a real issue we can make
> it allocate from the swiotlb pool, which is usually 64MB (and can
> be made bigger at boot time) 

In all of the cases I've seen, it defaults to 4M. in swiotlb.c,
io_tlb_nslabs defaults to 1024, * PAGE_SIZE == 4194304.


> Would that work for you too BTW ? How much memory do you expect
> to need?

potentially. our currently pending release uses pci_map_sg, which
relies on swiotlb for em64t systems. it "works", but we have some ugly
hacks and were hoping to get away from using it (at least in it's
current form).

here's some of the problems we encountered:

probably the biggest problem is that the size is way too small for our
needs (more on our memory usage shortly). this is compounded by the
the swiotlb code throwing a kernel panic when it can't allocate
memory. and if the panic doesn't halt the machine, the routine returns
a random value off the stack as the dma_addr_t.

for this reason, we have an ugly hack that notices that swiotlb is
enabled (just checks if swiotlb is set) and prints a warning to the user
to bump up the size of the swiotlb to 16384, or 64M.

also, the proper usage of using the bounce buffers and calling 
pci_dma_sync_* would be a performance killer for us. we stream a
considerable amount of data to the gpu per second (on the order of
100s of Megs a second), so having to do an additional memcpy would
reduce performance considerably, in some cases between 30-50%.

for this reason, we detect when the dma_addr != phys_addr, and map the
dma_addr directly to opengl to avoid the copy. I know this is ugly,
and that's one of the things I'd really like to get away from.

finally, our driver already uses a considerable amount of memory. by
definition, the swiotlb interface doubles that memory usage. if our
driver used swiotlb correctly (as in didn't know about swiotlb and
always called pci_dma_sync_*), we'd lock down the physical addresses
opengl writes to, since they're normally used directly for dma, plus
the pages allocated from the swiotlb would be locked down (currently
we manually do this, but if swiotlb is supposed to be transparent to
the driver and used for dma, I assume it must already be locked down,
perhaps by definition of being bootmem?). this means not only is the
memory usage double, but it's all locked down and unpageable.

in this case, it almost would make more sense to treat the bootmem
allocated for swiotlb as a pool of 32-bit memory that can be directly
allocated from, rather than as bounce buffers. I don't know that this
would be an acceptable interface though.

but if we could come up with reasonable solutions to these problems,
this may work.

> drawback is that the swiotlb pool is not unified with the rest of the
> VM, so tying up too much memory there is quite unfriendly.
> e.g. if you you can use up 1GB then i wouldn't consider this suitable,
> for 128MB max it may be possible.

I checked with our opengl developers on this. by default, we allocate
~64k for X's push buffer and ~1M per opengl client for their push
buffer. on quadro/workstation parts, we allocate 20M for the first
opengl client, then ~1M per client after that.

in addition to the push buffer, there is a lot of data that apps dump
to the push buffer. this includes textures, vertex buffers, display
lists, etc. the amount of memory used for this varies greatly from app
to app. the 20M listed above includes the push buffer and memory for
these buffers (I think workstation apps tend to push a lot more
pre-processed vertex data to the gpu).

note that most agp apertures these days are in the 128M - 1024M range,
and there are times that we exhaust that memory on the low end. I
think our driver is greedy when trying to allocate memory for
performance reasons, but has good fallback cases. so being somewhat
limited on resources isn't too bad, just so long as the kernel doesn't
panic instead of falling the memory allocation.

I would think that 64M or 128M would be good. a nice feature of
swiotlb is the ability to tune it at boot. so if a workstation user
found they really did need more memory for performance, they could
tweak that value up for themselves.

also remember future growth. PCI-E has something like 20/24 lanes that
can be split among multiple PCI-E slots. Alienware has already
announced multi-card products, and it's likely multi-card products
will be more readily available on PCI-E, since the slots should have
equivalent bandwidth (unlike AGP+PCI).

nvidia has also had workstation parts in the past with 2 gpus and a
bridge chip. each of these gpus ran twinview, so each card drove 4
monitors. these were pci cards, and some crazy vendors had 4+ of these
cards in a machine driving many monitors. this just pushes the memory
requirements up in special circumstances.

Thanks,
Terence
