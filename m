Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266179AbSL1Qpj>; Sat, 28 Dec 2002 11:45:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266210AbSL1Qpi>; Sat, 28 Dec 2002 11:45:38 -0500
Received: from mta5.snfc21.pbi.net ([206.13.28.241]:36074 "EHLO
	mta5.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S266179AbSL1Qph>; Sat, 28 Dec 2002 11:45:37 -0500
Date: Sat, 28 Dec 2002 08:59:56 -0800
From: David Brownell <david-b@pacbell.net>
Subject: Re: [RFT][PATCH] generic device DMA implementation
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: James.bottomley@steeleye.com, linux-kernel@vger.kernel.org,
       manfred@colorfulllife.com
Message-id: <3E0DD88C.5080708@pacbell.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en, fr
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020513
References: <200212281541.HAA00512@baldur.yggdrasil.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

>>>>Isn't the goal to make sure that for every kind of "struct device *"
>                                         ^^^^^
>>>>it should be possible to use those dma_*() calls, without BUGging
>>>>out.
>>That sounds like a "yes", not a "no" ... except for devices on busses
>                                           ^^^^^^
> 	Then it's not "every", which was your question.  I guess I need
> to understand better how to interpret your questions.

My bad ... I meant "every" kind of device doing memory mapped I/O, which
is all that had been mentioned so far.  This needs to work on more than
just the "platform bus"; "layered busses" shouldn't need special casing,
they are just as common.  You had mentioned SCSI busses; USB, FireWire,
and others also exist.  (Though I confess I still don't like BUG() as a
way to fail much of anything!)

That's likely a better way to present one of my points:  if it's "generic",
then it must work on more than just the lowest level platform bus.


>>that don't have do memory mapped I/O.  It's what I described:  dma_*()
>>calls being used with struct device, without BUGging out.
> 
> 
> 	Let's see if we agree.  The behavior I expect is:
> 
> 	addr = dma_malloc(&some_usb_device->dev,size, &dma_addr,DMA_CONSISTENT)
> 	     ===> BUG()

That's not consistent with what I thought what you said.  USB devices
use memory mapped I/O, so this should work.  (And using BUG instead
of returning null still seems wrong...)

However, we could agree that some kind of dma_malloc() should exist !!


> 	addr = dma_malloc(host_dev(some_usb_device), &dma_addr, DMA_CONSISTENT)
> 	     ===> some consistent memory (or NULL).
> 
> where host_dev would be something like:
> 
> struct device *host_dev(struct usb_device *usbdev)
> {
> 	struct usb_hcd *hcd = usbdev->bus->hcpriv;
> 	return &hcd->pdev->device; /* actually, this would become &hcd->dev */
> }

Please look at the 2.5.53 tree with my "usbcore dma updates (and doc)"
patch, which Greg has now merged and submitted to Linus.

The pre-existing USB DMA API syntax did not change, so it looks only
"something" like what you wrote there.

- Dave



