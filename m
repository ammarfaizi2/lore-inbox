Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261277AbUBTSf2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 13:35:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261257AbUBTSfT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 13:35:19 -0500
Received: from fw.osdl.org ([65.172.181.6]:45450 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261266AbUBTSeO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 13:34:14 -0500
Date: Fri, 20 Feb 2004 10:39:19 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Hollis Blanchard <hollisb@us.ibm.com>
cc: "David S. Miller" <davem@redhat.com>, akpm@osdl.org, greg@kroah.com,
       linux-kernel@vger.kernel.org,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [BK PATCH] USB update for 2.6.3
In-Reply-To: <CBEF20EA-63D0-11D8-AE86-000A95A0560C@us.ibm.com>
Message-ID: <Pine.LNX.4.58.0402201030060.2533@ppc970.osdl.org>
References: <20040220012802.GA16523@kroah.com> <Pine.LNX.4.58.0402192156240.2244@ppc970.osdl.org>
 <1077256996.20789.1091.camel@gaston> <Pine.LNX.4.58.0402192221560.2244@ppc970.osdl.org>
 <1077258504.20781.1121.camel@gaston> <Pine.LNX.4.58.0402192243170.14296@ppc970.osdl.org>
 <1077259375.20787.1141.camel@gaston> <Pine.LNX.4.58.0402192257190.1107@ppc970.osdl.org>
 <20040219230407.063ef209.davem@redhat.com> <1077261041.20787.1181.camel@gaston>
 <20040219233214.56f5b0ce.davem@redhat.com> <Pine.LNX.4.58.0402200714270.1107@ppc970.osdl.org>
 <CBEF20EA-63D0-11D8-AE86-000A95A0560C@us.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 20 Feb 2004, Hollis Blanchard wrote:
> 
> And USB, when it creates its bus_type, does this:
> 	int usb_dma_supported(struct device *dev, u64 mask) {
> 		usb_dev *usbdev = to_usb_device(dev);
> 		return usbdev->root_hub->controller->bus->dma_supported(controller, u64 mask)
> 	}

So? The above has absolutely nothing to do with "dma_alloc_coherent()". 
Also, it is wrong. It is not necessarily guaranteed that the device that 
is the host controller ha sanythign to do with the "bus->dma_supported" 
thing.

The point is, that DMA is always _always_ done on the host controller. 
Trying to make things look any different is silly and wrong.

THE ABOVE CODE IS CRAP!

The correct thing to do is

	int usb_dma_supported(struct usb_dev *dev, u64 mask)
	{
		struct device *host = dev->root_hub->controller;
		return dma_supported(host);
	}

and anything else is FUNDAMENTALLY WRONG!

Imagine, for example, that the bus is a PCI bus, but the USB host 
controller has a bug in that it only supports 24-bit DMA. Asking for what 
the bus of the host controller supports is non-sensical, and has 
absolutely zero to do with that the actual host device supports.

See?

(That actual bug is totally irrelevant, though. The _fundamnetal_ bug is
in your way of thinking. For one thing, if you have a function called
"usb_dma_xxx()", then it takes a _USB_ device, not a generic device.  
Because the function clearly doesn't even WORK with a generic device, it
only works with a "struct usb_dev". So don't "lie" about things like that
in your interfaces and confuse the issue).

			Linus
