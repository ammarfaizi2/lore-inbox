Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261449AbUCUXNP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Mar 2004 18:13:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261460AbUCUXNO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Mar 2004 18:13:14 -0500
Received: from fw.osdl.org ([65.172.181.6]:28867 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261449AbUCUXNJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Mar 2004 18:13:09 -0500
Date: Sun, 21 Mar 2004 15:11:58 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
cc: Jeff Garzik <jgarzik@pobox.com>, David Woodhouse <dwmw2@infradead.org>,
       Christoph Hellwig <hch@infradead.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Andrew Morton <akpm@osdl.org>, Andrea Arcangeli <andrea@suse.de>,
       linux-kernel@vger.kernel.org
Subject: Re: can device drivers return non-ram via vm_ops->nopage?
In-Reply-To: <20040321225117.F26708@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.58.0403211504550.1106@ppc970.osdl.org>
References: <20040320121345.2a80e6a0.akpm@osdl.org> <20040320205053.GJ2045@holomorphy.com>
 <20040320222639.K6726@flint.arm.linux.org.uk> <20040320224500.GP2045@holomorphy.com>
 <1079901914.17681.317.camel@imladris.demon.co.uk> <20040321204931.A11519@infradead.org>
 <1079902670.17681.324.camel@imladris.demon.co.uk>
 <Pine.LNX.4.58.0403211349340.1106@ppc970.osdl.org> <20040321222327.D26708@flint.arm.linux.org.uk>
 <405E1859.5030906@pobox.com> <20040321225117.F26708@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 21 Mar 2004, Russell King wrote:
> 
> Remember that we're fond of telling driver writers to use scatter gather
> lists rather than grabbing one large contiguous memory chunk...  So
> they did exactly as we told them.  Using pci_alloc_consistent and/or
> dma_alloc_coherent and built their own scatter lists.

I do think that we should introduce a "map_dma_coherent()" thing, which 
basically takes a list of pages that have been allocated by 
dma_alloc_coherent(), and remaps them into user space. How hard can that 
be?

In fact, on a lot of architectures (well, at least x86, and likely
anything else that doesn't use any IOTLB and just allocates a chunk of
physical memory), I think the "map_dma_coherent()" thing should basically
just become a "remap_page_range()". Ie something like

	#define map_dma_coherent(vma, vaddr, len) \
		remap_page_range(vma, vma->vm_start, __pa(vaddr), len, vma->vm_page_prot)

for the simple case.

Ehh?

		Linus
