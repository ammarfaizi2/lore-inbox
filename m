Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264788AbSL0VcK>; Fri, 27 Dec 2002 16:32:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264790AbSL0VcK>; Fri, 27 Dec 2002 16:32:10 -0500
Received: from host194.steeleye.com ([66.206.164.34]:8 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S264788AbSL0VcJ>; Fri, 27 Dec 2002 16:32:09 -0500
Message-Id: <200212272140.gBRLeMW03698@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: David Brownell <david-b@pacbell.net>
cc: James Bottomley <James.Bottomley@SteelEye.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFT][PATCH] generic device DMA implementation 
In-Reply-To: Message from David Brownell <david-b@pacbell.net> 
   of "Fri, 27 Dec 2002 12:21:54 PST." <3E0CB662.2010009@pacbell.net> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 27 Dec 2002 15:40:21 -0600
From: James Bottomley <James.Bottomley@steeleye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

david-b@pacbell.net said:
> - Implementation-wise, I'm rather surprised that the generic
>    version doesn't just add new bus driver methods rather than
>    still insisting everything be PCI underneath. 

You mean dma-mapping.h in asm-generic?  The reason for that is to provide an 
implementation that functions now for non x86 (and non-parisc) archs without 
having to write specific code for them all.  Since all the other arch's now 
function in terms of the pci_ API, that was the only way of sliding the dma_ 
API in without breaking them all.

Bus driver methods have been advocated before, but it's not clear to me that 
they should be exposed in the *generic* API.

>    It's not clear to me how I'd make, for example, a USB device
>    or interface work with dma_map_sg() ... those "generic" calls
>    are going to fail (except on x86, where all memory is DMA-able)
>    since USB != PCI.

Actually, they should work on parisc out of the box as well because of the way 
its DMA implementation is built in terms of the generic dma_ API.

As far as implementing this generically, just adding a case for the 
usb_bus_type in asm-generic/dma-mapping.h will probably get you where you need 
to be. (the asm-generic is, after all, only intended as a stopgap.  Fully 
coherent platforms with no IOMMUs will probably take the x86 route to 
implementing the dma_ API, platforms with IOMMUs will probably (eventually) do 
similar things to parisc).


>    (The second indirection:  the usb controller hardware does the
>    mapping, not the device or hcd.  That's usually PCI.) 

Could you clarify this a little.  I tend to think of "mapping" as something 
done by the IO MMU managing the bus.  I think you mean that the usb controller 
will mark a region of memory to be accessed by the device.  If such a region 
were also "mapped" by an IOMMU, it would be done outside the control of the 
USB controller, correct? (the IOMMU would translate between the address the 
processor sees and the address the USB controller thinks it's responding to)

Is the problem actually that the USB controller needs to be able to allocate 
coherent memory in a range much more narrowly defined than the current 
dma_mask allows?

> - There's no analogue to pci_pool, and there's nothing like
>    "kmalloc" (likely built from N dma-coherent pools). 

I didn't want to build another memory pool re-implementation.  The mempool API 
seems to me to be flexible enough for this, is there some reason it won't work?

I did consider wrappering mempool to make it easier, but I couldn't really 
find a simplifying wrapper that wouldn't lose flexibility.

James


