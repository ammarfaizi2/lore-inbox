Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261456AbVFOOC4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261456AbVFOOC4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 10:02:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261445AbVFOOCz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 10:02:55 -0400
Received: from loopy.telegraphics.com.au ([202.45.126.152]:16856 "EHLO
	loopy.telegraphics.com.au") by vger.kernel.org with ESMTP
	id S261442AbVFOOCg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 10:02:36 -0400
Date: Thu, 16 Jun 2005 00:02:33 +1000 (EST)
From: Finn Thain <fthain@telegraphics.com.au>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Jeff Garzik <jgarzik@pobox.com>,
       Linux/m68k <linux-m68k@vger.kernel.org>,
       Linux/m68k on Mac <linux-mac68k@mac.linux-m68k.org>,
       Linux MIPS <linux-mips@vger.kernel.org>,
       Linux kernel <linux-kernel@vger.kernel.org>,
       Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: Re: [PATCH] Jazzsonic driver updates
In-Reply-To: <20050615114158.GA9411@linux-mips.org>
Message-ID: <Pine.LNX.4.61.0506152220460.22046@loopy.telegraphics.com.au>
References: <200503070210.j272ARii023023@hera.kernel.org>
 <Pine.LNX.4.62.0503221807160.20753@numbat.sonytel.be> <20050323100139.GB8813@linux-mips.org>
 <Pine.LNX.4.61.0506121454410.1470@loopy.telegraphics.com.au>
 <20050615114158.GA9411@linux-mips.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 15 Jun 2005, Ralf Baechle wrote:

> On Sun, Jun 12, 2005 at 04:05:30PM +1000, Finn Thain wrote:
> 
> > > Oh funny.  vdma_alloc() was created 10 years ago as an internal API 
> > > for the Jazz machines.  Didn't realize m68k had cloned it :-)  If 
> > > anything it seems this should be converted to the modern DMA API.
> > 
> > I've just started merging my Mac sonic work into 2.6.12-rc6. m68k 
> > doesn't yet implement the modern DMA API, but it is easy to fake it 
> > for a while for macsonic.c.

Roman Zippel has since posted an implementation of that API for m68k, BTW. 
So I'll use that for macsonic, and possibly the driver core as well if I 
can figure out how to do this with jazzsonic.

> > So I don't mind converting macsonic, jazzsonic and the shared sonic 
> > driver core to the new API.
> > 
> > But, I knowing nothing about the Jazz DMA controller. I need some help 
> > from the MIPS people:
> 
> It's a while since I last touched that machine, so remember this is from 
> 10 year old memory ...
> 
> The Jazz DMA hardware is an MMU that translates virtual DMA to physical 
> addresses.  It's virtual DMA address space is 16MB in size, it's page 
> size is 4kB.  That's a set of capabilities that nicely translates into 
> the DMA API.

I gather that someone has already put this hardware under the control of 
the generic DMA API?

> > Would I be right to say that vdma_{alloc,free}() can be changed to 
> > dma_{,un}map_single? The other Jazz specific routine that sonic uses 
> > is vdma_log2phys, and I don't know if that has a better alternative.
> 
> The use of that call should simply be eleminated entirely.  DMA API
> functions such as dma_alloc_coherent or dma_map_single will return a
> dma_handle which along with the virtual address returned is everything
> ever needed to program a DMA engine.

The sonic chip stores packets inside a "receive resource area" at a 
physical address that depends on the packets it previously stored there. 

So the chip determines that address and the driver has to convert it from 
a physical to a virtual address with KSEG1ADDR(vdma_log2phys(x)), in order 
to memcpy the received packet.

>From what code I've looked at, and from what you've told me, I'm guessing 
that bus_to_virt() won't cut it here (?)

-f


> 
>   Ralf
> 
