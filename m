Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263464AbUCTQYq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 11:24:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263467AbUCTQYq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 11:24:46 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:56277
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S263464AbUCTQYn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 11:24:43 -0500
Date: Sat, 20 Mar 2004 17:25:34 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: can device drivers return non-ram via vm_ops->nopage?
Message-ID: <20040320162534.GU9009@dualathlon.random>
References: <20040320133025.GH9009@dualathlon.random> <20040320144022.GC2045@holomorphy.com> <20040320150621.GO9009@dualathlon.random> <20040320154419.A6726@flint.arm.linux.org.uk> <20040320155739.GQ9009@dualathlon.random> <20040320161538.C6726@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040320161538.C6726@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 20, 2004 at 04:15:38PM +0000, Russell King wrote:
> On Sat, Mar 20, 2004 at 04:57:39PM +0100, Andrea Arcangeli wrote:
> > > One of my current projects is fixing this crap in ALSA.
> > 
> > Do you agree it should be fixed by returning a PFN from ->nopage?
> 
> No.  How would you return the PFN from a remapped page?  It's far
> easier to provide an interface which returns the struct page* for
> the underlying pages, thusly:
> 
> static struct page *
> dma_coherent_to_page(struct device *dev, void *cpu_addr,
> 		     dma_addr_t handle, unsigned int offset)
> 
> And this is precisely what I would be working on if I weren't writing
> this mail. 8)
> 
> Take a moment to think about the problem.  We've allocated some memory
> for coherent DMA via the dma_alloc_coherent() interface.  At some point,

they're using MMIO pci space or it wouldn't catch my BUG_ON on x86.

The whole point is that it is non ram, if it would be ram, x86 couldn't
notice the virt_to_page, since the page_t would be in the range of the
mem_map_t and pfn_valid would be happy with it.

If it was dma_alloc_coherent it would return ram I think, not non-ram.

> we've had to get a struct page* in this allocator.  However, the
> allocator has had to do some architecture defined operations to provide
> coherent memory.
> 
> Only the architecture can translate the results from dma_alloc_coherent()
> back to a struct page* - which it needs to be able to do if
> dma_free_coherent() is going to work.
> 
> Therefore, what we need to do to solve the ALSA problem is require all
> architectures to provide dma_coherent_to_page() and make ALSA use that.

will this dma_coherent_to_page be allowed to run on a non-ram page?
It's pretty ugly to use page_t for non-ram. one can always convert with
a mul or div with sizeof(page_t) though. My point is that if you want to
allow stuff to deal with non-ram you must never have this stuff work
with page_t but it should work with pfn instead.
