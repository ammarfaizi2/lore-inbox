Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267185AbSLEBzJ>; Wed, 4 Dec 2002 20:55:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267186AbSLEBzJ>; Wed, 4 Dec 2002 20:55:09 -0500
Received: from host194.steeleye.com ([66.206.164.34]:8970 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S267185AbSLEBzE>; Wed, 4 Dec 2002 20:55:04 -0500
Message-Id: <200212050202.gB522U505445@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: "Adam J. Richter" <adam@yggdrasil.com>
cc: James.Bottomley@SteelEye.com, davem@redhat.com, jgarzik@pobox.com,
       linux-kernel@vger.kernel.org, miles@gnu.org
Subject: Re: [RFC] generic device DMA implementation 
In-Reply-To: Message from "Adam J. Richter" <adam@yggdrasil.com> 
   of "Wed, 04 Dec 2002 16:43:11 PST." <200212050043.QAA03207@adam.yggdrasil.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 04 Dec 2002 20:02:30 -0600
From: James Bottomley <James.Bottomley@steeleye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

adam@yggdrasil.com said:
> 	As you know, I posted a similar patch that created a new field in
> struct bus_type, as Miles Bader suggested just now, although only for
> {alloc,free}_consistent.  if the bus-specific variation can be
> confined to some smaller part of these routines or eliminated, then
> I'm all in favor of skipping the extra indirection and going with your
> approach.  It will be interesting to see if your model allows most of
> the sbus_ and pci_ DMA mapping routines in sparc to be merged.  I
> suspect that you will have to adopt some kind of convention, such as
> that device->parent->driver_private will have a common meaning for pci
> and sbus device on that platform. 

I did prototype something like this, using a field called dma_accessors that 
was basically a platform opaque set of function pointers.

I ultimately came to the conclusion that these functions couldn't be per 
bus_type, they had to be per bus instance.  Finally, it just seemed easier to 
load this information into the platform_data field of the generic device and 
let the implementation handle it instead of exposing it explicitly in the 
model.

> 	Can you please define the "consistency" argument to these two
> routines as a bit mask?  There are probably other kinds of memory
> inconsistency a driver might be able to accomodate in the future (CPU
> read caching, CPU writeback, incosistency across mulitple CPU's if the
> driver knows that it is only going to run on one CPU).  I think 0
> should be the "most consistent" kind of memory.  That way, DMA memory
> allocators could ignore bits that they don't know about, as those bits
> would only advertise extra capabilities of a driver.  I think this
> extensibility is more useful than the debugging value of
> DMA_CONFORMANCE_NONE. 

I'd rather hide the range of possible memory types from the drivers.  I think 
all a driver needs to know is that the memory is fully consistent, or it isn't 
(and if it isn't, the driver has to put the full syncs in, the implementation 
decides if they really correspond to anything).

By and large, most drivers just want to specify CONFORMANCE_CONSISTENT, so 
that they don't have to bother with the sync points.

> 	Also something that could be added later is a bus_type.mem_mapped
> flag so that these DMA routines could do:

> 		BUG_ON(!dev->bus.mem_mapped);

> 	...to catch attempts to allocate memory for devices that are not
> mapped.  Alternatively, we could have a struct mem_device that embeds
> a struct device and represents only those types of devices that can be
> mapped into memory. 

I'm dubious about efforts to unify io space and memory space.  I think the 
semantics are just too different.  However, if someone else wants to lead the 
charge...

> 	P.S., Did you miss a patch for include/linux/device.h adding
> device.dma_mask, or is that change already queued for 2.5.51? 

I think that's queued somewhere in Patrick Mochel's pile for inclusion.

James


