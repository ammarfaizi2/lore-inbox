Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261519AbUCVADN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Mar 2004 19:03:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261528AbUCVADN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Mar 2004 19:03:13 -0500
Received: from imladris.demon.co.uk ([193.237.130.41]:39320 "EHLO
	baythorne.infradead.org") by vger.kernel.org with ESMTP
	id S261519AbUCVADL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Mar 2004 19:03:11 -0500
Subject: Re: can device drivers return non-ram via vm_ops->nopage?
From: David Woodhouse <dwmw2@infradead.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, Russell King <rmk+lkml@arm.linux.org.uk>,
       Christoph Hellwig <hch@infradead.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Andrew Morton <akpm@osdl.org>, Andrea Arcangeli <andrea@suse.de>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58.0403211542051.1106@ppc970.osdl.org>
References: <20040320121345.2a80e6a0.akpm@osdl.org>
	 <20040320205053.GJ2045@holomorphy.com>
	 <20040320222639.K6726@flint.arm.linux.org.uk>
	 <20040320224500.GP2045@holomorphy.com>
	 <1079901914.17681.317.camel@imladris.demon.co.uk>
	 <20040321204931.A11519@infradead.org>
	 <1079902670.17681.324.camel@imladris.demon.co.uk>
	 <Pine.LNX.4.58.0403211349340.1106@ppc970.osdl.org>
	 <20040321222327.D26708@flint.arm.linux.org.uk> <405E1859.5030906@pobox.com>
	 <20040321225117.F26708@flint.arm.linux.org.uk>
	 <Pine.LNX.4.58.0403211504550.1106@ppc970.osdl.org>
	 <405E23A5.7080903@pobox.com>
	 <Pine.LNX.4.58.0403211542051.1106@ppc970.osdl.org>
Content-Type: text/plain
Message-Id: <1079913775.17681.499.camel@imladris.demon.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-8.dwmw2.2) 
Date: Mon, 22 Mar 2004 00:02:55 +0000
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by baythorne.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-03-21 at 15:51 -0800, Linus Torvalds wrote:
> Note that there is really two different kinds of IO memory:
>  - real IO-mapped memory on the other side of a bus
>  - real RAM which is on the CPU side of the bus, but that has additionally 
>    been "mapped" some way as to be visible from devices.
> 
> The second kind is what you seem to be talking about,

 <...>

> So the minimal fix for any misuses would be to just have a
> "dma_map_to_page()" reverse mapping for "dma_alloc_coherent()". For x86,
> that's just the same thing as "virt_to_page()". For others, you have to
> look more carefully at undoing whatever mapping the iommu has been set up
> for.

You are assuming that dma_alloc_coherent() will always return memory of
that second kind -- host-side RAM, not PCI-side. That hasn't previously
been a requirement, and there are machines out there on which it makes a
lot more sense for dma_alloc_coherent() to use some SRAM which happens
to be hanging off the I/O bus than it does to use host RAM.

Doing dma_map_to_pfn() instead of dma_map_to_page() would work. That
means you can't use nopage() for mappings of dma_coherent memory. That's
fine though.

> Would that make people happy?

No. It'd be OK if you make it dma_map_to_pfn() instead of
dma_map_to_page() though. As discussed, that means you can't use
nopage() for mappings of dma_coherent memory. That's fine though.

I think it would be better to provide arch-specific functions for
mapping dma_coherent allocations and SG lists. On most architectures we
can just do it with virt_to_page() and nopage() and it'll be OK. On
others we can do the right thing as appropriate.

-- 
dwmw2


