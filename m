Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261517AbUCUXvs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Mar 2004 18:51:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261516AbUCUXvr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Mar 2004 18:51:47 -0500
Received: from fw.osdl.org ([65.172.181.6]:9693 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261517AbUCUXvm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Mar 2004 18:51:42 -0500
Date: Sun, 21 Mar 2004 15:51:31 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
cc: Russell King <rmk+lkml@arm.linux.org.uk>,
       David Woodhouse <dwmw2@infradead.org>,
       Christoph Hellwig <hch@infradead.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Andrew Morton <akpm@osdl.org>, Andrea Arcangeli <andrea@suse.de>,
       linux-kernel@vger.kernel.org
Subject: Re: can device drivers return non-ram via vm_ops->nopage?
In-Reply-To: <405E23A5.7080903@pobox.com>
Message-ID: <Pine.LNX.4.58.0403211542051.1106@ppc970.osdl.org>
References: <20040320121345.2a80e6a0.akpm@osdl.org> <20040320205053.GJ2045@holomorphy.com>
 <20040320222639.K6726@flint.arm.linux.org.uk> <20040320224500.GP2045@holomorphy.com>
 <1079901914.17681.317.camel@imladris.demon.co.uk> <20040321204931.A11519@infradead.org>
 <1079902670.17681.324.camel@imladris.demon.co.uk>
 <Pine.LNX.4.58.0403211349340.1106@ppc970.osdl.org> <20040321222327.D26708@flint.arm.linux.org.uk>
 <405E1859.5030906@pobox.com> <20040321225117.F26708@flint.arm.linux.org.uk>
 <Pine.LNX.4.58.0403211504550.1106@ppc970.osdl.org> <405E23A5.7080903@pobox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 21 Mar 2004, Jeff Garzik wrote:
> 
> That would be nice, though the reason I avoided remap_page_range() in 
> via82cxxx_audio is that it discourages S/G.  Because remap_page_range() 
> is easier and more portable, several drivers allocate one-big-area and 
> then create an S/G list describing individual portions of that area.

Note that there is really two different kinds of IO memory:
 - real IO-mapped memory on the other side of a bus
 - real RAM which is on the CPU side of the bus, but that has additionally 
   been "mapped" some way as to be visible from devices.

The second kind is what you seem to be talking about, and it actually
_does_ have a "struct page" associated with it, and as such you can
happily return it from "nopage()". It's just that you had better be sure
that you find the page properly. Just doing a "virt_to_page()" doesn't do
it - you have to make sure to undo the mapping that was done for DMA
reasons.

So the minimal fix for any misuses would be to just have a
"dma_map_to_page()" reverse mapping for "dma_alloc_coherent()". For x86,
that's just the same thing as "virt_to_page()". For others, you have to
look more carefully at undoing whatever mapping the iommu has been set up
for.

That might be the minimal fix, since it would basically involve:
 - change whatever offensive "virt_to_page()" calls into 
   "dma_map_to_page()".
 - implement "dma_map_to_page()" for all architectures.

Would that make people happy?

(Architectures that have cache coherency issues will obviously also have 
to set cache disable bits in the vma information, that's they broken 
architecture problem)

		Linus
