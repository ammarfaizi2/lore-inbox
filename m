Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263497AbTLOKjR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 05:39:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263496AbTLOKjR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 05:39:17 -0500
Received: from ltgp.iram.es ([150.214.224.138]:20352 "EHLO ltgp.iram.es")
	by vger.kernel.org with ESMTP id S263497AbTLOKjO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 05:39:14 -0500
From: Gabriel Paubert <paubert@iram.es>
Date: Mon, 15 Dec 2003 11:31:43 +0100
To: Vladimir Kondratiev <vladimir.kondratiev@intel.com>
Cc: linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>,
       Alan Cox <alan@redhat.com>, Marcelo Tosatti <marcelo@conectiva.com.br>,
       Martin Mares <mj@ucw.cz>, zaitcev@redhat.com, hch@infradead.org
Subject: Re: PCI Express support for 2.4 kernel
Message-ID: <20031215103142.GA8735@iram.es>
References: <3FDCC171.9070902@intel.com> <3FDCCC12.20808@pobox.com> <3FDD8691.80206@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FDD8691.80206@intel.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi, 
	
On Mon, Dec 15, 2003 at 12:01:53PM +0200, Vladimir Kondratiev wrote:
> >>+/**
> >>+ * Initializes PCI Express method for config space access.
> >>+ * + * There is no standard method to recognize presence of PCI 
> >>Express,
> >>+ * thus we will assume it is PCI-E, and rely on sanity check to
> >>+ * deassert PCI-E presense. If PCI-E not present,
> >>+ * there is no physical RAM on RRBAR address, and we should read
> >>+ * something like 0xff.
> >>+ * + * Creates mapping for whole 256M area.
> >>+ * + * @return 1 if OK, 0 if error
> >>+ */
> >>+static int pci_express_init(void)
> >>+{
> >>+  /* TODO: check PCI-Ex presense */
> >
> >
> >Um, this sounds critical.  We should not merge this patch until this 
> >'TODO' is complete, in my opinion.
> 
> As I explained in comment to function, it is not really critical. The 
> problem is, there is no generic way (or I don't know it) to recognize 
> PCI-E. One suggest to go over all devices and see whether PCI-E 
> capability present for at least one of them. I don't think it is good 
> way to do. Sanity check do pretty good job here. If it is not PCI-E 
> platform, this address in physical memory will not be connected to 
> anything real. You will get 0xff's.

Or a machine check on some architectures which make you know that 
they don't like a bus cycle which terminates on a master abort.

> Agree. Fixed, except 1-st "+", since virtual addres may be not aligned 
> on 256M boundary

The major problem I see is that using up 256 Mb of kernel virtual address 
space for accessing PCI config space is gross. Besides that it won't
work for 32 bit machines with 768 Mb of RAM or more.

I believe that it would be better to use kmap/kunmap like tricks, especially 
for something which is relatively infrequent. You could even reserve
a fixmap entry for this and keep somewhere a pointer to the PTE, which 
would be modified on every config space access (config space access was
already properly serialized last time I looked, I believe that all you need 
is a TLB flush after the PTE is updated).

I have no strong opinion on how to handle 64 bit archs.

> 
> >Further, PCI posting:  a writeb() / writew() / writel() will not be 
> >flushed immediately to the processor.  The CPU and/or PCI bridge may 
> >post (delay/combine) such writes.  I do not think this is a desireable 
> >effect, for PCI config register accesses.
> >
> Good point. Fixed.

Here I'm somehwat lost. Writes to uncacheable RAM will be in program 
order and never combined. The bridge itself should not post writes to 
config space. So it's a matter of pushing the write to the processor
bus, a PCI read looks very heavy for this. Isn't there a more
lightweight solution ?

	Regards,
	Gabriel

