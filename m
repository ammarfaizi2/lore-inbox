Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261181AbVE1UIT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261181AbVE1UIT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 May 2005 16:08:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261180AbVE1UIT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 May 2005 16:08:19 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:19466 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261181AbVE1UIL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 May 2005 16:08:11 -0400
Date: Sat, 28 May 2005 21:08:00 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, ralf@linux-mips.org,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>
Subject: Re: [RFC] Changing pci_iounmap to take 'bar' argument
Message-ID: <20050528210759.A10904@flint.arm.linux.org.uk>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	ralf@linux-mips.org,
	Linux Kernel list <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>
References: <1117080454.9076.25.camel@gaston> <Pine.LNX.4.58.0505252121290.2307@ppc970.osdl.org> <1117081633.9076.35.camel@gaston> <1117081814.9076.38.camel@gaston> <1117083357.9076.49.camel@gaston> <Pine.LNX.4.58.0505260813510.2307@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.58.0505260813510.2307@ppc970.osdl.org>; from torvalds@osdl.org on Thu, May 26, 2005 at 08:21:07AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 26, 2005 at 08:21:07AM -0700, Linus Torvalds wrote:
> 
> 
> On Thu, 26 May 2005, Benjamin Herrenschmidt wrote:
> > 
> > 	foo = pci_iomap(dev, bar, pci_resource_len(dev, bar));
> 
> Btw, this kind of code should be just
> 
> 	foo = pci_iomap(dev, bar, 0);
> 
> because the third argument is _not_ a length, it's a _maximum_ length we 
> need to map, with zero meaning "everything" (as does ~0ul, of course, but 
> zero is obviously easier).
> 
> The only people who want to use non-zero are things like frame-buffers
> that might have hundreds of megabytes of memory, but the kernel only needs
> to map the actual thing visible on the screen.

Note also that framebuffer drivers may also wish to map a bar from a
specific offset and length.  Eg, CyberPro has one BAR which is something
like 16MB large, with the framebuffer in the low addresses and the
registers at 8MB in.  (poor example I know.)

I believe the IXP folk have issues similar to this though, but more
extreme.

> Yeah. It shouldn't be a problem on 64-bit architectures, and even on 
> 32-bit ones the IO-port range really _should_ be fairly small, and a small 
> amount of special casing should hopefully fix it.
> 
> A lot of architectures end up having to separate PIO and MMIO anyway,
> which is - together with hysterical raisins, of course - why the existing
> interfaces just assumed that was possible.

Maybe the interface is just wrong.  Maybe it should be:

struct map {
	void __iomem *cpu;
	/* whatever platform data is required */
};

	err = pci_iomap(dev, bar, size, &map);
...
	pci_iounmap(&map);

The reason I suggest this is that we've had problems with the PCI DMA API -
remember that driver people whinged about having to store the dma_addr_t
cookie and we introduced the following crap:

#define DECLARE_PCI_UNMAP_ADDR(ADDR_NAME)       dma_addr_t ADDR_NAME;
#define DECLARE_PCI_UNMAP_LEN(LEN_NAME)         __u32 LEN_NAME;
#define pci_unmap_addr(PTR, ADDR_NAME)          ((PTR)->ADDR_NAME)
#define pci_unmap_addr_set(PTR, ADDR_NAME, VAL) (((PTR)->ADDR_NAME) = (VAL))
#define pci_unmap_len(PTR, LEN_NAME)            ((PTR)->LEN_NAME)
#define pci_unmap_len_set(PTR, LEN_NAME, VAL)   (((PTR)->LEN_NAME) = (VAL))

Let's not make this same mistake again!  (just like we unknowingly
repeated it for the new DMA API... which should have contained the
returned cookies - the platform specific data which may be just the
CPU address for trivial x86 cases - inside a structure with macros
for accessing them.  Magically all the above mess vanishes.)


-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
