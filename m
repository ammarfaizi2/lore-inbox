Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261558AbUCVAYQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Mar 2004 19:24:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261567AbUCVAYQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Mar 2004 19:24:16 -0500
Received: from holomorphy.com ([207.189.100.168]:2190 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261558AbUCVAYL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Mar 2004 19:24:11 -0500
Date: Sun, 21 Mar 2004 16:23:49 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: rmk@arm.linux.org.uk, Linus Torvalds <torvalds@osdl.org>,
       Jeff Garzik <jgarzik@pobox.com>, David Woodhouse <dwmw2@infradead.org>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: can device drivers return non-ram via vm_ops->nopage?
Message-ID: <20040322002349.GZ2045@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	rmk@arm.linux.org.uk, Linus Torvalds <torvalds@osdl.org>,
	Jeff Garzik <jgarzik@pobox.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>, Andrea Arcangeli <andrea@suse.de>,
	linux-kernel@vger.kernel.org
References: <20040320224500.GP2045@holomorphy.com> <1079901914.17681.317.camel@imladris.demon.co.uk> <20040321204931.A11519@infradead.org> <1079902670.17681.324.camel@imladris.demon.co.uk> <Pine.LNX.4.58.0403211349340.1106@ppc970.osdl.org> <20040321222327.D26708@flint.arm.linux.org.uk> <405E1859.5030906@pobox.com> <20040321225117.F26708@flint.arm.linux.org.uk> <Pine.LNX.4.58.0403211504550.1106@ppc970.osdl.org> <20040321234515.G26708@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040321234515.G26708@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 21, 2004 at 11:45:15PM +0000, Russell King wrote:
> Ok, splitting hairs, for the coherent contiguous case, what about:
> int dma_coherent_map(struct vm_area_struct *vma, void *cpu_addr,
> 		     dma_addr_t dma_addr, size_t size);
> and x86 would be:
> #define dma_coherent_map(vma,cpu_addr,dma_addr,size)	\
> 	remap_page_range(vma, vma->vm_start, __pa(cpu_addr), \
> 			 size, vma->vm_page_prot)
> This then leaves the PCI BAR case and the DMA coherent SG buffer case,
> though neither of those fall within my personal problem space at present.

Can we get an offset into the area as one of the args? Then scatter/gather
should be trivially constructible (via iteration) from the interface.
Maybe something like:

struct dma_scatterlist {
        dma_addr_t dma_addr;            /* DMA address */
        void *cpu_addr;                 /* cpu address */
        unsigned long length;           /* in units of pages */
};

int dma_mmap_coherent_sg(struct dma_scatterlist *sglist,
                        int nr_sglist_elements,     /* length of sglist */
                        struct vm_area_struct *vma, /* for address space */
                        unsigned long address,      /* user virtual address */
                        unsigned long offset,       /* offset (in pages) */
                        unsigned long nr_pages);    /* length (in pages) */

int dma_munmap_coherent_sg(struct dma_scatterlist *sglist,
                        int nr_sglist_elements,     /* length of sglist */
                        struct vm_area_struct *vma, /* for address space */
                        unsigned long address,      /* user virtual address */
                        unsigned long offset,       /* offset (in pages) */
                        unsigned long nr_pages);    /* length (in pages) */

int dma_alloc_coherent_sg(struct dma_scatterlist **sglist,
                        unsigned long length);      /* length in pages */

int dma_free_coherent_sg(struct dma_scatterlist **sglist,
                        unsigned long length);      /* length in pages */

Would be useful? And these in turn would drive the dma_alloc_coherent()
and helpers like:

int dma_mmap_coherent(struct vm_area_struct *vma,
                        unsigned long address,
                        dma_addr_t dma_addr,            /* DMA address */
                        void *cpu_addr,                 /* cpu address */
                        unsigned long nr_pages);        /* length (in pages) */

int dma_munmap_coherent(struct vm_area_struct *vma,
                        unsigned long address,
                        dma_addr_t dma_addr,            /* DMA address */
                        void *cpu_addr,                 /* cpu address */
                        unsigned long nr_pages);        /* length (in pages) */

Does any of this sound like it's on the right track API-wise?

My thought on attacking the scatter/gather issue is basically centered
around "they're going to try to do it anyway, and if they don't have
something there to do it for them, they'll get it wrong."


-- wli
