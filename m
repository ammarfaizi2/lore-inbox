Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261400AbUBTWsC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 17:48:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261381AbUBTWsB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 17:48:01 -0500
Received: from gate.crashing.org ([63.228.1.57]:40875 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261400AbUBTWqL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 17:46:11 -0500
Subject: Re: [linux-usb-devel] Re: [BK PATCH] USB update for 2.6.3
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Hollis Blanchard <hollisb@us.ibm.com>,
       "David S. Miller" <davem@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Greg KH <greg@kroah.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Linux-USB <linux-usb-devel@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.58.0402201128240.1101@ppc970.osdl.org>
References: <20040220012802.GA16523@kroah.com>
	 <Pine.LNX.4.58.0402192156240.2244@ppc970.osdl.org>
	 <1077256996.20789.1091.camel@gaston>
	 <Pine.LNX.4.58.0402192221560.2244@ppc970.osdl.org>
	 <1077258504.20781.1121.camel@gaston>
	 <Pine.LNX.4.58.0402192243170.14296@ppc970.osdl.org>
	 <1077259375.20787.1141.camel@gaston>
	 <Pine.LNX.4.58.0402192257190.1107@ppc970.osdl.org>
	 <20040219230407.063ef209.davem@redhat.com>
	 <1077261041.20787.1181.camel@gaston>
	 <20040219233214.56f5b0ce.davem@redhat.com>
	 <Pine.LNX.4.58.0402200714270.1107@ppc970.osdl.org>
	 <CBEF20EA-63D0-11D8-AE86-000A95A0560C@us.ibm.com>
	 <Pine.LNX.4.58.0402201030060.2533@ppc970.osdl.org>
	 <CB199764-63D9-11D8-AE86-000A95A0560C@us.ibm.com>
	 <Pine.LNX.4.58.0402201128240.1101@ppc970.osdl.org>
Content-Type: text/plain
Message-Id: <1077316822.9625.4.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 21 Feb 2004 09:40:23 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-02-21 at 06:32, Linus Torvalds wrote:
> On Fri, 20 Feb 2004, Hollis Blanchard wrote:
> > 
> > Well, I was picturing all those *_dma_supported() functions as being 
> > plugged into (new) fields in struct bus_type:
> > 	struct bus_type {
> > 		...
> > 		int (*dma_supported)(struct device *dev, u64 mask);
> > 	}
> 
> Ok, that would work. It might even be a good idea (not just DMA-related) 
> to make sure that everything you can portably "do" with a device would 
> show up as device operations. Right now it's not very well specified, and 
> there's obviously a lot of confusion.

Yes, which is why I don't agree with Hollis about having that in
bus_type, but rather in the device itself and inherit from the
parents by default ;) (Hrm... did I repeat myself ?)

The bus_type was is pretty useless for things like USB, and we
may have several controllers of the same bus with different
caracteristics (an on-chip OHCI and a PCI EHCI comes to mind)

Hrm... reading your last sentence, it seems you don't want people
to pass the struct device of the USB device but the host one instead,
fair enough...

> > If your *_dma_supported functions only take usb_dev, pci_dev, etc, then 
> > you end up with code like asm-generic/dma-mapping.h:
> 
> I agree, that is horrible. On the other hand, some architectures don't 
> need any indirection or any conditionals at all, since they know that they 
> only have one type of DMA. 
> 
> Making the device operations explicit would be good, though, and would 
> match how we do things in general. It's a fairly big change at this point, 
> but if somebody is willing to put the effort into the cleanup, then I'm 
> all for it.
> 
> I'd still ask that people don't do DMA on non-host devices. I'd rather 
> have a USB "struct device" just return "DMA not supported", to make sure 
> that everybody asks the right chip.
> 


