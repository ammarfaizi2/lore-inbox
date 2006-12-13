Return-Path: <linux-kernel-owner+w=401wt.eu-S932613AbWLMHsM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932613AbWLMHsM (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 02:48:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932614AbWLMHsM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 02:48:12 -0500
Received: from smtp.osdl.org ([65.172.181.25]:33053 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932613AbWLMHsL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 02:48:11 -0500
Date: Tue, 12 Dec 2006 23:47:20 -0800
From: Andrew Morton <akpm@osdl.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Ralph Campbell <ralph.campbell@qlogic.com>,
       Roland Dreier <rolandd@cisco.com>
Subject: Re: IB: Add DMA mapping functions to allow device drivers to
 interpose
Message-Id: <20061212234720.700f3cea.akpm@osdl.org>
In-Reply-To: <200612130359.kBD3xjWp028210@hera.kernel.org>
References: <200612130359.kBD3xjWp028210@hera.kernel.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Dec 2006 03:59:45 GMT
Linux Kernel Mailing List <linux-kernel@vger.kernel.org> wrote:

>     IB: Add DMA mapping functions to allow device drivers to interpose
>     
>     The QLogic InfiniPath HCAs use programmed I/O instead of HW DMA.
>     This patch allows a verbs device driver to interpose on DMA mapping
>     function calls in order to avoid relying on bus_to_virt() and
>     phys_to_virt() to undo the mappings created by dma_map_single(),
>     dma_map_sg(), etc.
>     
>     Signed-off-by: Ralph Campbell <ralph.campbell@qlogic.com>
>     Signed-off-by: Roland Dreier <rolandd@cisco.com>

include/rdma/ib_verbs.h: In function 'ib_dma_alloc_coherent':
include/rdma/ib_verbs.h:1635: warning: passing argument 3 of 'dma_alloc_coherent' from incompatible pointer type
In file included from drivers/infiniband/hw/mthca/mthca_provider.h:41,
                 from drivers/infiniband/hw/mthca/mthca_dev.h:53,
                 from drivers/infiniband/hw/mthca/mthca_main.c:44:
include/rdma/ib_verbs.h: In function 'ib_dma_alloc_coherent':
include/rdma/ib_verbs.h:1635: warning: passing argument 3 of 'dma_alloc_coherent' from incompatible pointer type


That u64 needs to become a dma_addr_t.  That means that
ib_dma_mapping_ops.alloc_coherent() and ib_dma_mapping_ops.free_coherent() are
wrong as well.

> +struct ib_dma_mapping_ops {
> ...
> +	void		*(*alloc_coherent)(struct ib_device *dev,
> +					   size_t size,
> +					   u64 *dma_handle,
> +					   gfp_t flag);
> +	void		(*free_coherent)(struct ib_device *dev,
> +					 size_t size, void *cpu_addr,
> +					 u64 dma_handle);
> +};

I'd have picked this up if it had been in git-infiniband for even a couple
of days.  I'm assuming this all got slammed into mainline because of the
merge window thing.

I cannot find these patches on the kernel mailing list.  I cannot find the
pull request anywhere.

> +static inline u64 ib_dma_map_single(struct ib_device *dev,
> +				    void *cpu_addr, size_t size,
> +				    enum dma_data_direction direction)

no, dma_map_single() returns a dma_addr_t.


