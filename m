Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265169AbSL0UHm>; Fri, 27 Dec 2002 15:07:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265171AbSL0UHl>; Fri, 27 Dec 2002 15:07:41 -0500
Received: from mta6.snfc21.pbi.net ([206.13.28.240]:63150 "EHLO
	mta6.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S265169AbSL0UHj>; Fri, 27 Dec 2002 15:07:39 -0500
Date: Fri, 27 Dec 2002 12:21:54 -0800
From: David Brownell <david-b@pacbell.net>
Subject: Re: [RFT][PATCH] generic device DMA implementation
To: James Bottomley <James.Bottomley@SteelEye.com>,
       linux-kernel@vger.kernel.org
Message-id: <3E0CB662.2010009@pacbell.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en, fr
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020513
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think you saw that patch to let the new 2.5.53 generic dma code
replace one of the two indirections USB needs.  Here are some of
the key open issues I'm thinking of:

- DMA mapping calls still return no errors; so BUG() out instead?

   Consider systems where DMA-able memory is limited (like SA-1111,
   to 1 MByte); clearly it should be possible for these calls to
   fail, when they can't allocate a bounce buffer.  Or (see below)
   when an invalid argument is provided to a dma mapping call.

   Fix by defining fault returns for the current signatures,
   starting with the api specs:

     * dma_map_sg() returns negative errno (or zero?) when it
       fails.  (Those are illegal sglist lengths.)

     * dma_map_single() returns an arch-specific value, like
       DMA_ADDR_INVALID, when it fails.  (DaveM's suggestion,
       from a while back; it's seemingly arch-specific.)

   Yes, the PCI dma calls would benefit from those bugfixes too.

- Implementation-wise, I'm rather surprised that the generic
   version doesn't just add new bus driver methods rather than
   still insisting everything be PCI underneath.

   It's not clear to me how I'd make, for example, a USB device
   or interface work with dma_map_sg() ... those "generic" calls
   are going to fail (except on x86, where all memory is DMA-able)
   since USB != PCI. Even when usb_buffer_map_sg() would succeed.
   (The second indirection:  the usb controller hardware does the
   mapping, not the device or hcd.  That's usually PCI.)

   Hmm, I suppose there'd need to be a default implementation
   of the mapping operations (for all non-pci busses) that'd
   fail cleanly ... :)

- There's no analogue to pci_pool, and there's nothing like
   "kmalloc" (likely built from N dma-coherent pools).

   That forces drivers to write and maintain memory allocators,
   is a waste of energy as well as being bug-prone.  So in that
   sense this API isn't a complete functional replacement of
   the current PCI (has pools, ~= kmem_cache_t) or USB (with
   simpler buffer_alloc ~= kmalloc) APIs for dma.

- The API says drivers "must" satisfy dma_get_cache_alignment(),
   yet both implementations, asm-{i386,generic}/dma-mapping.h,
   ignore that rule.

   Are you certain of that rule, for all cache coherency models?
   I thought only some machines (with dma-incoherent caches) had
   that as a hard constraint.  (Otherwise it's a soft one:  even
   if there's cacheline contention, the hardware won't lose data
   when drivers use memory barriers correctly.)

   I expect that combination is likely to be problematic, since the
   previous rule has been (wrongly?) that kmalloc or kmem_cache
   memory is fine for DMA mappings, no size restrictions.  Yet for
   one example on x86 dma_get_cache_alignment() returns 128 bytes,
   but kmalloc has several smaller pool sizes ... and lately will
   align to L1_CACHE_BYTES (wasting memory on small allocs?) even
   when that's smaller than L1_CACHE_MAX (in the new dma calls).

   All the more reason to have a drop-in kmalloc alternative for
   dma-aware code to use, handling such details transparently!

- Isn't arch/i386/kernel/pci-dma.c handling DMA masks wrong?
   It's passing GFP_DMA in cases where GFP_HIGHMEM is correct ...

I'm glad to see progress on making DMA more generic, thanks!

- Dave










