Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262058AbUB2P0U (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Feb 2004 10:26:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262057AbUB2P0U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Feb 2004 10:26:20 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:22792 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262058AbUB2P0R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Feb 2004 10:26:17 -0500
Date: Sun, 29 Feb 2004 15:26:13 +0000
From: Russell King <rmk+alsa@arm.linux.org.uk>
To: Jaroslav Kysela <perex@suse.cz>
Cc: Alsa Devel list <alsa-devel@lists.sourceforge.net>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [Alsa-devel] 2.6.4-rc1: ALSA makes invalid assumptions about memory types
Message-ID: <20040229152613.A9081@flint.arm.linux.org.uk>
Mail-Followup-To: Jaroslav Kysela <perex@suse.cz>,
	Alsa Devel list <alsa-devel@lists.sourceforge.net>,
	LKML <linux-kernel@vger.kernel.org>
References: <20040229122234.B28963@flint.arm.linux.org.uk> <Pine.LNX.4.58.0402291338520.1880@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.58.0402291338520.1880@pnote.perex-int.cz>; from perex@suse.cz on Sun, Feb 29, 2004 at 01:48:52PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 29, 2004 at 01:48:52PM +0100, Jaroslav Kysela wrote:
> On Sun, 29 Feb 2004, Russell King wrote:
> >    I believe this needs discussing with the DMA API authors on LKML since
> >    AFAIK the kernel currently doesn't have a clear API to translate memory
> >    returned by either pci_alloc_consistent() or dma_alloc_coherent() back
> >    to it's consituent struct page pointers.
> 
> We can do some #ifdef hacks in our code, of course, but a function 
> doing this abstraction in kernel for given architecture would be much 
> better of course.

I've been thinking about something like:

struct page *dma_map_to_page(struct device *dev, void *cpu_addr,
			     dma_addr_t dma_addr, int page_offset);

Where:
- dev is the struct device which was passed to dma_alloc_coherent()
- cpu_addr is the address returned from dma_alloc_coherent()
- dma_addr is the DMA address returned from dma_alloc_coherent()
- page_offset is the offset into the mapping.

This allows an architecture to define the above as a macro.  If the
architecture is coherent (ie, as x86 is), then they only need to do
this in their asm/dma-mapping.h header:

#define dma_map_to_page(dev,cpu,dma,off) virt_to_page((cpu) + (off) << PAGE_SHIFT)

This reflects essentially what we have today in snd_pcm_mmap_data_nopage().

However, in the non-coherent case, this becomes very much architecture
dependent, and an architecture probably wants to translate either the
DMA address or CPU address to a struct page by some method.

> >    The way architectures mark their mappings uncacheable and/or only
> >    writecombining is architecture specific... see drivers/video/fbmem.c
> >    as an example.
> 
> It's real mess. I think that this setup should be moved to linux/arch 
> tree, too.

I think we just need to make sure that architectures define
pgprot_writecombine() and pgprot_uncached(), like ARM and ia64 both
do.

> > 2) PCM mmap control/status mappings
> > 
> >    These suffer from a similar cache coherency problem - you can not
> >    assume that two different mappings of the same page will not alias
> >    in the CPUs caches.
> > 
> >    In my case on ARM, not only must the user space mappings of these
> >    structures be marked uncacheable, but also the kernel space mappings
> >    of the same to ensure that accesses via both mappings always return
> >    up to date information.
> > 
> >    I have hacks in my tree which work around this using ARM specific
> >    functionality, but this is very much architecture specific at the
> >    moment, and I suspect requires a new kernel API for creating memory
> >    (it's similar to the DMA case above.)
> 
> It's same problem. We need that a function in kernel API will do this 
> for us to avoid #ifdefs for all architectures.

I think for the moment we'll leave this issue alone for now (and I'll
put up with the hacks.)  Once we've sorted (1) out, we should have a
better idea how to sort (2).

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
