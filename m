Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265355AbSL1BPj>; Fri, 27 Dec 2002 20:15:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265361AbSL1BPj>; Fri, 27 Dec 2002 20:15:39 -0500
Received: from mta5.snfc21.pbi.net ([206.13.28.241]:39913 "EHLO
	mta5.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S265355AbSL1BPi>; Fri, 27 Dec 2002 20:15:38 -0500
Date: Fri, 27 Dec 2002 17:29:54 -0800
From: David Brownell <david-b@pacbell.net>
Subject: Re: [RFT][PATCH] generic device DMA implementation
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: linux-kernel@vger.kernel.org
Message-id: <3E0CFE92.7060902@pacbell.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en, fr
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020513
References: <200212272140.gBRLeMW03698@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley wrote:
> david-b@pacbell.net said:
> 
>>- Implementation-wise, I'm rather surprised that the generic
>>   version doesn't just add new bus driver methods rather than
>>   still insisting everything be PCI underneath. 
> 
> 
> You mean dma-mapping.h in asm-generic?  ..

Yes.  As noted, it can't work for USB directly.  And your
suggestion of more "... else if (bus is USB) ... else  ... "
logic (#including each bus type's headers?) bothers me.


> Bus driver methods have been advocated before, but it's not clear to me that 
> they should be exposed in the *generic* API.

Isn't the goal to make sure that for every kind of "struct device *"
it should be possible to use those dma_*() calls, without BUGging
out.  If that's not true ... then why were they defined?

That's certainly the notion I was talking about when this "generic
dma" API notion came up this summer [1].  (That discussion led to
the USB DMA APIs, and then the usb_sg_* calls that let usb-storage
queue scatterlists directly to disk:  performance wins, including
DaveM's "USB keyboards don't allocate IOMMU pages", but structures
looking ahead to having real generic DMA calls.)


>>   It's not clear to me how I'd make, for example, a USB device
>>   or interface work with dma_map_sg() ... those "generic" calls
>>   are going to fail (except on x86, where all memory is DMA-able)
>>   since USB != PCI.
> 
> 
> Actually, they should work on parisc out of the box as well because of the way 
> its DMA implementation is built in terms of the generic dma_ API.

Most of us haven't seen your PARISC code, it's not in Linus' tree.  :)

>>   (The second indirection:  the usb controller hardware does the
>>   mapping, not the device or hcd.  That's usually PCI.) 
> 
> 
> Could you clarify this a little.

Actually, make that "hardware-specific code".

The USB controller is what does the DMA.  But USB device drivers don't
talk to USB controllers, at least not directly.  Instead they talk to a
"struct usb_interface *", or a "struct usb_device *" ... those are more
or less software proxies for the real devices with usbcore and some
HCD turning proxy i/o requests into USB controller operations.

The indirection is getting from the USB device (or interface) to the
object representing the USB controller.  All USB calls need that, at
least for host-side APIs, since the controller driver is multiplexing
up to almost 4000 I/O channels.  (127 devices * 31 endpoints, max; and
of course typical usage is more like dozens of channels.)


> Is the problem actually that the USB controller needs to be able to allocate 
> coherent memory in a range much more narrowly defined than the current 
> dma_mask allows?

Nope, it's just an indirection issue.  Even on a PCI based system, the "struct
device" used by a USB driver (likely usb_interface->dev) will never be a USB
controller.  Since it's the USB controller actually doing the I/O something
needs to use that controller to do the DMA mapping(s).

So any generic DMA logic needs to be able to drill down a level or so before
doing DMA mappings (or allocations) for a USB "struct device *".

- Dave

[1] http://marc.theaimsgroup.com/?l=linux-kernel&m=102389137402497&w=2


