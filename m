Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264010AbSL1Pc7>; Sat, 28 Dec 2002 10:32:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264647AbSL1Pc7>; Sat, 28 Dec 2002 10:32:59 -0500
Received: from h-64-105-35-45.SNVACAID.covad.net ([64.105.35.45]:43904 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S264010AbSL1Pcy>; Sat, 28 Dec 2002 10:32:54 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Sat, 28 Dec 2002 07:41:04 -0800
Message-Id: <200212281541.HAA00512@baldur.yggdrasil.com>
To: david-b@pacbell.net
Subject: Re: [RFT][PATCH] generic device DMA implementation
Cc: James.bottomley@steeleye.com, linux-kernel@vger.kernel.org,
       manfred@colorfulllife.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Brownell wrote:
>Adam J. Richter wrote:
>> At 2002-12-28 1:29:54 GMT, David Brownell wrote:
>> 
>>>Isn't the goal to make sure that for every kind of "struct device *"
                                        ^^^^^
>>>it should be possible to use those dma_*() calls, without BUGging
>>>out.
>> 
>> 	No.
>> 
>>>If that's not true ... then why were they defined?
>> 
>> 	So that other memory mapped busses such as ISA and sbus
>> can use them.

>That sounds like a "yes", not a "no" ... except for devices on busses
                                          ^^^^^^
	Then it's not "every", which was your question.  I guess I need
to understand better how to interpret your questions.

>that don't have do memory mapped I/O.  It's what I described:  dma_*()
>calls being used with struct device, without BUGging out.

	Let's see if we agree.  The behavior I expect is:

	addr = dma_malloc(&some_usb_device->dev,size, &dma_addr,DMA_CONSISTENT)
	     ===> BUG()

	addr = dma_malloc(host_dev(some_usb_device), &dma_addr, DMA_CONSISTENT)
	     ===> some consistent memory (or NULL).

where host_dev would be something like:

struct device *host_dev(struct usb_device *usbdev)
{
	struct usb_hcd *hcd = usbdev->bus->hcpriv;
	return &hcd->pdev->device; /* actually, this would become &hcd->dev */
}


>> 	USB devices should do DMA operations with respect to their USB
>> host adapters, typically a PCI device.  For example, imagine a machine
>> with two USB controllers on different bus instances.

>USB already does that ... you write as if it didn't.

	I wasn't aware of it.  I've looked up the code now.  Thanks
for the pointer.  With generic DMA operations, we can delete most of
drivers/bus/usb/core/buffer.c, specifically
hcd_buffer_{alloc,free,{,un}map{,_sg},dmasync,sync_sg}, and their
method pointers in struct usb_operations in drivers/usb/core/hcd.[ch]
without introducing PCI dependency.

	I hope this clarifies things.  Please let me know if you think
we still disagree on something.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
