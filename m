Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261479AbUCUXpm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Mar 2004 18:45:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261517AbUCUXpl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Mar 2004 18:45:41 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:29714 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261479AbUCUXpb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Mar 2004 18:45:31 -0500
Date: Sun, 21 Mar 2004 23:45:15 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, David Woodhouse <dwmw2@infradead.org>,
       Christoph Hellwig <hch@infradead.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Andrew Morton <akpm@osdl.org>, Andrea Arcangeli <andrea@suse.de>,
       linux-kernel@vger.kernel.org
Subject: Re: can device drivers return non-ram via vm_ops->nopage?
Message-ID: <20040321234515.G26708@flint.arm.linux.org.uk>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Jeff Garzik <jgarzik@pobox.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Christoph Hellwig <hch@infradead.org>,
	William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, Andrea Arcangeli <andrea@suse.de>,
	linux-kernel@vger.kernel.org
References: <20040320222639.K6726@flint.arm.linux.org.uk> <20040320224500.GP2045@holomorphy.com> <1079901914.17681.317.camel@imladris.demon.co.uk> <20040321204931.A11519@infradead.org> <1079902670.17681.324.camel@imladris.demon.co.uk> <Pine.LNX.4.58.0403211349340.1106@ppc970.osdl.org> <20040321222327.D26708@flint.arm.linux.org.uk> <405E1859.5030906@pobox.com> <20040321225117.F26708@flint.arm.linux.org.uk> <Pine.LNX.4.58.0403211504550.1106@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.58.0403211504550.1106@ppc970.osdl.org>; from torvalds@osdl.org on Sun, Mar 21, 2004 at 03:11:58PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 21, 2004 at 03:11:58PM -0800, Linus Torvalds wrote:
> On Sun, 21 Mar 2004, Russell King wrote:
> > Remember that we're fond of telling driver writers to use scatter gather
> > lists rather than grabbing one large contiguous memory chunk...  So
> > they did exactly as we told them.  Using pci_alloc_consistent and/or
> > dma_alloc_coherent and built their own scatter lists.
> 
> I do think that we should introduce a "map_dma_coherent()" thing, which 
> basically takes a list of pages that have been allocated by 
> dma_alloc_coherent(), and remaps them into user space. How hard can that 
> be?
> 
> In fact, on a lot of architectures (well, at least x86, and likely
> anything else that doesn't use any IOTLB and just allocates a chunk of
> physical memory), I think the "map_dma_coherent()" thing should basically
> just become a "remap_page_range()". Ie something like
> 
> 	#define map_dma_coherent(vma, vaddr, len) \
> 		remap_page_range(vma, vma->vm_start, __pa(vaddr), len, vma->vm_page_prot)
> 
> for the simple case.

Ok, splitting hairs, for the coherent contiguous case, what about:

int dma_coherent_map(struct vm_area_struct *vma, void *cpu_addr,
		     dma_addr_t dma_addr, size_t size);

and x86 would be:

#define dma_coherent_map(vma,cpu_addr,dma_addr,size)	\
	remap_page_range(vma, vma->vm_start, __pa(cpu_addr), \
			 size, vma->vm_page_prot)

This then leaves the PCI BAR case and the DMA coherent SG buffer case,
though neither of those fall within my personal problem space at present.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
