Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264229AbUBTG6Y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 01:58:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267055AbUBTG6Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 01:58:24 -0500
Received: from fw.osdl.org ([65.172.181.6]:137 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264229AbUBTG6W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 01:58:22 -0500
Date: Thu, 19 Feb 2004 23:03:31 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>,
       Linux-USB <linux-usb-devel@lists.sourceforge.net>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BK PATCH] USB update for 2.6.3
In-Reply-To: <1077259375.20787.1141.camel@gaston>
Message-ID: <Pine.LNX.4.58.0402192257190.1107@ppc970.osdl.org>
References: <20040220012802.GA16523@kroah.com>  <Pine.LNX.4.58.0402192156240.2244@ppc970.osdl.org>
  <1077256996.20789.1091.camel@gaston>  <Pine.LNX.4.58.0402192221560.2244@ppc970.osdl.org>
  <1077258504.20781.1121.camel@gaston>  <Pine.LNX.4.58.0402192243170.14296@ppc970.osdl.org>
 <1077259375.20787.1141.camel@gaston>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 20 Feb 2004, Benjamin Herrenschmidt wrote:
> 
> > Well, we do. The pcibios_xxx routines get called for all PCI devices 
> > during discovery, and that's when you'd fill them in.
> 
> But what about USB or FireWire devices ? In theory, I'd like to see
> the driver for those not have to bother about beeing hosted by a PCI
> device or whatever else (there are typically non-PCI OHCI USBs on
> embedded platform, faking a pci_dev is becoming painful).

Well, a USB device can't actually do DMA, so .. (it's only the USB _host_ 
that does DMA, and while those aren't always PCI, they normally are).

Basically, we only care about host devices, since anything else is going 
to be talked to through a driver and is thus not even platform-dependent 
any more. See what I'm saying? 

So we'd only have hust buses here: either PCI or ISA or something like 
that (NuBus, VME, EISA, Microchannel.. You get the idea).

And host buses - pretty much by definition - are scanned by the host. So 
all those buses tend to have host fixups. In the case of PCI, it's the 
"pcibios_xxx()" macros that are the host fixups. Most other buses tend to 
be _so_ host-centric that they don't have anything _but_ the host 
environment (ie things like the embedded buses used by ARM chips etc).

> So it would actually make sense to be able to pass whatever struct
> device we are on, and have a real inheritance of the DMA functions
> going down the bus, don't you think ? 

Only for devices on host buses. 

> > No no. That wouldn't work AT ALL, since the whole point is that you need 
> > to know what the device is - ie you need to fill in the information when 
> > you get the "struct pci_dev *" (because different buses would most likely 
> > have different behaviour, and could have different requirements for DMA 
> > mapping etc). 
> 
> And ? Where is the problem ? By default, you inherit from the parent
> and that's just fine.

Yes, as long as you set up the "root" of the bus, and then just inherit 
the pointer, you should be ok and not need to do anything further. I 
agree.

(And btw, yes, it all booted, so PPC64 is happy again. I pushed out the 
one-liner fix).

		Linus
