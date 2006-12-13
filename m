Return-Path: <linux-kernel-owner+w=401wt.eu-S1750833AbWLMUoy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750833AbWLMUoy (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 15:44:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750822AbWLMUoy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 15:44:54 -0500
Received: from [198.186.3.68] ([198.186.3.68]:41557 "EHLO mx.pathscale.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1750838AbWLMUox (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 15:44:53 -0500
X-Greylist: delayed 2005 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Dec 2006 15:44:53 EST
Subject: Re: IB: Add DMA mapping functions to allow device drivers to
	interpose
From: Ralph Campbell <ralph.campbell@qlogic.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Roland Dreier <rolandd@cisco.com>
In-Reply-To: <20061212234720.700f3cea.akpm@osdl.org>
References: <200612130359.kBD3xjWp028210@hera.kernel.org>
	 <20061212234720.700f3cea.akpm@osdl.org>
Content-Type: text/plain
Organization: QLogic
Date: Wed, 13 Dec 2006 12:11:27 -0800
Message-Id: <1166040687.14800.384.camel@brick.pathscale.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-12-12 at 23:47 -0800, Andrew Morton wrote:
> On Wed, 13 Dec 2006 03:59:45 GMT
> Linux Kernel Mailing List <linux-kernel@vger.kernel.org> wrote:
> 
> >     IB: Add DMA mapping functions to allow device drivers to interpose
> >     
> >     The QLogic InfiniPath HCAs use programmed I/O instead of HW DMA.
> >     This patch allows a verbs device driver to interpose on DMA mapping
> >     function calls in order to avoid relying on bus_to_virt() and
> >     phys_to_virt() to undo the mappings created by dma_map_single(),
> >     dma_map_sg(), etc.
> >     
> >     Signed-off-by: Ralph Campbell <ralph.campbell@qlogic.com>
> >     Signed-off-by: Roland Dreier <rolandd@cisco.com>
> 
> include/rdma/ib_verbs.h: In function 'ib_dma_alloc_coherent':
> include/rdma/ib_verbs.h:1635: warning: passing argument 3 of 'dma_alloc_coherent' from incompatible pointer type
> In file included from drivers/infiniband/hw/mthca/mthca_provider.h:41,
>                  from drivers/infiniband/hw/mthca/mthca_dev.h:53,
>                  from drivers/infiniband/hw/mthca/mthca_main.c:44:
> include/rdma/ib_verbs.h: In function 'ib_dma_alloc_coherent':
> include/rdma/ib_verbs.h:1635: warning: passing argument 3 of 'dma_alloc_coherent' from incompatible pointer type
> 
> 
> That u64 needs to become a dma_addr_t.  That means that
> ib_dma_mapping_ops.alloc_coherent() and ib_dma_mapping_ops.free_coherent() are
> wrong as well.
> 
> > +struct ib_dma_mapping_ops {
> > ...
> > +	void		*(*alloc_coherent)(struct ib_device *dev,
> > +					   size_t size,
> > +					   u64 *dma_handle,
> > +					   gfp_t flag);
> > +	void		(*free_coherent)(struct ib_device *dev,
> > +					 size_t size, void *cpu_addr,
> > +					 u64 dma_handle);
> > +};
> 
> I'd have picked this up if it had been in git-infiniband for even a couple
> of days.  I'm assuming this all got slammed into mainline because of the
> merge window thing.
> 
> I cannot find these patches on the kernel mailing list.  I cannot find the
> pull request anywhere.
> 
> > +static inline u64 ib_dma_map_single(struct ib_device *dev,
> > +				    void *cpu_addr, size_t size,
> > +				    enum dma_data_direction direction)
> 
> no, dma_map_single() returns a dma_addr_t.

ib_dma_map_single() allows the ib_ipath device driver to interpose
on IOMMU allocations and not do them by returning the kernel
virtual address as the "DMA address".  I started with dma_addr_t
but it was pointed out to me that sparc64 defines dma_addr_t
as u32. This would cause addresses to be truncated.
Also, I chose u64 because the return value from ib_dma_*() is
stored in the ib_sge.addr field which is u64.

My preference would be to change the offending uses of dma_addr_t
to u64.  Do you have a better solution?

