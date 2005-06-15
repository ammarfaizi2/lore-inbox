Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261517AbVFOOc2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261517AbVFOOc2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 10:32:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261488AbVFOOb1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 10:31:27 -0400
Received: from extgw-uk.mips.com ([62.254.210.129]:58130 "EHLO
	bacchus.net.dhis.org") by vger.kernel.org with ESMTP
	id S261487AbVFOOaZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 10:30:25 -0400
Date: Wed, 15 Jun 2005 15:27:17 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Finn Thain <fthain@telegraphics.com.au>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Jeff Garzik <jgarzik@pobox.com>,
       Linux/m68k <linux-m68k@vger.kernel.org>,
       Linux/m68k on Mac <linux-mac68k@mac.linux-m68k.org>,
       Linux MIPS <linux-mips@vger.kernel.org>,
       Linux kernel <linux-kernel@vger.kernel.org>,
       Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: Re: [PATCH] Jazzsonic driver updates
Message-ID: <20050615142717.GD9411@linux-mips.org>
References: <200503070210.j272ARii023023@hera.kernel.org> <Pine.LNX.4.62.0503221807160.20753@numbat.sonytel.be> <20050323100139.GB8813@linux-mips.org> <Pine.LNX.4.61.0506121454410.1470@loopy.telegraphics.com.au> <20050615114158.GA9411@linux-mips.org> <Pine.LNX.4.61.0506152220460.22046@loopy.telegraphics.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0506152220460.22046@loopy.telegraphics.com.au>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 16, 2005 at 12:02:33AM +1000, Finn Thain wrote:

> > The Jazz DMA hardware is an MMU that translates virtual DMA to physical 
> > addresses.  It's virtual DMA address space is 16MB in size, it's page 
> > size is 4kB.  That's a set of capabilities that nicely translates into 
> > the DMA API.
> 
> I gather that someone has already put this hardware under the control of 
> the generic DMA API?

That's being worked on.

> > > Would I be right to say that vdma_{alloc,free}() can be changed to 
> > > dma_{,un}map_single? The other Jazz specific routine that sonic uses 
> > > is vdma_log2phys, and I don't know if that has a better alternative.
> > 
> > The use of that call should simply be eleminated entirely.  DMA API
> > functions such as dma_alloc_coherent or dma_map_single will return a
> > dma_handle which along with the virtual address returned is everything
> > ever needed to program a DMA engine.
> 
> The sonic chip stores packets inside a "receive resource area" at a 
> physical address that depends on the packets it previously stored there. 
> 
> So the chip determines that address and the driver has to convert it from 
> a physical to a virtual address with KSEG1ADDR(vdma_log2phys(x)), in order 
> to memcpy the received packet.

Wrong.  The Sonic only does DMA to DMA addresses which will be translated
to physical addresses by the IOMMU.  That is it never ever deals with
physical addresses directly.

When transmitting or receiving a buffer it has to be mapped into the
DMA controller's address space first, for example through dma_map_single.

As the result you will obtain a DMA address which you will feed to the
Sonic or put into a rx or tx ring, whatever.  And you need to remember it
in the driver private data, just like the virtual address of the buffer
or the struct sk_buff pointer.  So all you need is to look at your private
data to find that virtual address you need for memcpy.

tg3 is a reasonable example of a driver - albeit not a simple one.

> >From what code I've looked at, and from what you've told me, I'm guessing 
> that bus_to_virt() won't cut it here (?)

bus_to_virt and virt_to_bus are shooting offences these days, no less.

  Ralf
