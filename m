Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263459AbUCTQPv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 11:15:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263460AbUCTQPv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 11:15:51 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:43536 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263459AbUCTQPm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 11:15:42 -0500
Date: Sat, 20 Mar 2004 16:15:38 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Andrea Arcangeli <andrea@suse.de>
Cc: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: can device drivers return non-ram via vm_ops->nopage?
Message-ID: <20040320161538.C6726@flint.arm.linux.org.uk>
Mail-Followup-To: Andrea Arcangeli <andrea@suse.de>,
	William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
	Linus Torvalds <torvalds@osdl.org>
References: <20040320133025.GH9009@dualathlon.random> <20040320144022.GC2045@holomorphy.com> <20040320150621.GO9009@dualathlon.random> <20040320154419.A6726@flint.arm.linux.org.uk> <20040320155739.GQ9009@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040320155739.GQ9009@dualathlon.random>; from andrea@suse.de on Sat, Mar 20, 2004 at 04:57:39PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 20, 2004 at 04:57:39PM +0100, Andrea Arcangeli wrote:
> > One of my current projects is fixing this crap in ALSA.
> 
> Do you agree it should be fixed by returning a PFN from ->nopage?

No.  How would you return the PFN from a remapped page?  It's far
easier to provide an interface which returns the struct page* for
the underlying pages, thusly:

static struct page *
dma_coherent_to_page(struct device *dev, void *cpu_addr,
		     dma_addr_t handle, unsigned int offset)

And this is precisely what I would be working on if I weren't writing
this mail. 8)

Take a moment to think about the problem.  We've allocated some memory
for coherent DMA via the dma_alloc_coherent() interface.  At some point,
we've had to get a struct page* in this allocator.  However, the
allocator has had to do some architecture defined operations to provide
coherent memory.

Only the architecture can translate the results from dma_alloc_coherent()
back to a struct page* - which it needs to be able to do if
dma_free_coherent() is going to work.

Therefore, what we need to do to solve the ALSA problem is require all
architectures to provide dma_coherent_to_page() and make ALSA use that.

(A related problem is that some architectures need pgprot_dmacoherent()
to modify the page protections so that the user space mapping is also
DMA-coherent.  However, that discussion should be the subject of a
new thread.)

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
