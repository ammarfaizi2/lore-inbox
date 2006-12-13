Return-Path: <linux-kernel-owner+w=401wt.eu-S1751058AbWLMVWm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751058AbWLMVWm (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 16:22:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751067AbWLMVWm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 16:22:42 -0500
Received: from [198.186.3.68] ([198.186.3.68]:42286 "EHLO mx.pathscale.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751056AbWLMVWl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 16:22:41 -0500
Subject: Re: IB: Add DMA mapping functions to allow device drivers to
	interpose
From: Ralph Campbell <ralph.campbell@qlogic.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Roland Dreier <rolandd@cisco.com>
In-Reply-To: <20061213123043.9de95cc4.akpm@osdl.org>
References: <200612130359.kBD3xjWp028210@hera.kernel.org>
	 <20061212234720.700f3cea.akpm@osdl.org>
	 <1166040687.14800.384.camel@brick.pathscale.com>
	 <20061213123043.9de95cc4.akpm@osdl.org>
Content-Type: text/plain
Organization: QLogic
Date: Wed, 13 Dec 2006 13:22:40 -0800
Message-Id: <1166044960.14800.425.camel@brick.pathscale.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-12-13 at 12:30 -0800, Andrew Morton wrote:
> On Wed, 13 Dec 2006 12:11:27 -0800
> Ralph Campbell <ralph.campbell@qlogic.com> wrote:
snip.
> > My preference would be to change the offending uses of dma_addr_t
> > to u64.  Do you have a better solution?
> 
> We should be able to use dma_addr_t for this?  Is it not the case that the
> values we're dealing with here _are_ DMA addresses?  I think a more complete
> description of the problem we're trying to solve here would help.
> 
> I'm not sure what the problem is with sparc64 - perhaps its dma_addr_t
> really is a "cookie" and isn't a physical bus address?  But you want a value
> which is really a physical bus address?  Dunno.
> 
> Perhaps dma64_addr_t can be used here.

The fundamental problem is that ib_get_dma_mr() returns a
pointer representing a memory region for all of physical memory
and the IB interface consumer is expected to call dma_map_single()
to get a dma_addr_t to pass to the HCA driver with the memory
region pointer.

For an HCA like Mellanox, the dma_addr_t really is a DMA address
which the hardware uses to DMA data from the chip to memory.

The ib_ipath HCA driver does not generally use DMA addresses.
The hardware does DMA the receive packet to a ring of buffers
but the receive interrupt handler then has to copy the data
from the receive buffer to the address specified by the
ib_post_recv() function.  This means the driver needs a
kernel virtual address instead of the memory region + DMA address
that is passed by ib_post_recv().

The ib_dma_*() functions were added to allow the ib_ipath
driver to interpose on the dma_*() functions so that a
kernel virtual address can be returned instead of allocating
an IOMMU DMA address.  Without the interposing functions,
there is no way for the ib_ipath driver to convert the IOMMU
address back into a kernel virtual address since it never
sees the original inputs used to allocate the IOMMU address.

I don't want to make ib_dma_map_single() return a dma_addr_t
cookie and use it to lookup the kernel virtual address since
this is a performance critical code path in the receive
interrupt handler and the "cookie" needs to be a byte address
which can be offset within a page.

The secondary problem is that on sparc64, dma_addr_t is a
u32 so if ib_dma_map_single() returns a void * cast to dma_addr_t,
it is truncated.  We might be able to convince the sparc64
maintainers to make dma_addr_t u64 but dma64_addr_t won't
work because that is specific to sparc64.  The type has
to be architecture neutral.


