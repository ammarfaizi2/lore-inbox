Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267656AbUBTGsK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 01:48:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267667AbUBTGsJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 01:48:09 -0500
Received: from gate.crashing.org ([63.228.1.57]:48809 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S267656AbUBTGrm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 01:47:42 -0500
Subject: Re: [BK PATCH] USB update for 2.6.3
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>,
       Linux-USB <linux-usb-devel@lists.sourceforge.net>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0402192243170.14296@ppc970.osdl.org>
References: <20040220012802.GA16523@kroah.com>
	 <Pine.LNX.4.58.0402192156240.2244@ppc970.osdl.org>
	 <1077256996.20789.1091.camel@gaston>
	 <Pine.LNX.4.58.0402192221560.2244@ppc970.osdl.org>
	 <1077258504.20781.1121.camel@gaston>
	 <Pine.LNX.4.58.0402192243170.14296@ppc970.osdl.org>
Content-Type: text/plain
Message-Id: <1077259375.20787.1141.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 20 Feb 2004 17:42:56 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Well, we do. The pcibios_xxx routines get called for all PCI devices 
> during discovery, and that's when you'd fill them in.

But what about USB or FireWire devices ? In theory, I'd like to see
the driver for those not have to bother about beeing hosted by a PCI
device or whatever else (there are typically non-PCI OHCI USBs on
embedded platform, faking a pci_dev is becoming painful).

So it would actually make sense to be able to pass whatever struct
device we are on, and have a real inheritance of the DMA functions
going down the bus, don't you think ? 

> Anyway, I found the bug - the "asm-generic/dma-mapping.h" compatibility 
> macros _do_ work, but the EHCI controller driver doesn't actually include 
> that header file. Oops.

Heh.

> > We should have a way, when creating a device, to fill it properly, like
> > 
> > platform_device_setup(struct device *new_dev, struct device *parent)
> 
> No no. That wouldn't work AT ALL, since the whole point is that you need 
> to know what the device is - ie you need to fill in the information when 
> you get the "struct pci_dev *" (because different buses would most likely 
> have different behaviour, and could have different requirements for DMA 
> mapping etc). 

And ? Where is the problem ? By default, you inherit from the parent
and that's just fine. The platform sets the ops for the root PCIs and
everybody below that inherit from them, same goes for VIO. If at one
level in the hierarchy, there is a "brake" (a bridge to a different
kind of bus that has additional restrictions), then the above routine
can "know" this via the new_dev bus type and setup appropriate mapping
functions.

> So the platform code that actually knows what the device is (pcibios_xxx 
> for PCI devices) would fill in the platform pointer.

Hrm... and we keep it empty for USB, FireWire, etc... or we add
platform_usb_xxxx, platform_ieee1394_* etc... for all those cases ?

> Anyway, I got it all working with the trivial patch..
> 
> ===== drivers/usb/host/ehci-hcd.c 1.67 vs edited =====
> --- 1.67/drivers/usb/host/ehci-hcd.c    Wed Feb 11 03:42:39 2004
> +++ edited/drivers/usb/host/ehci-hcd.c  Thu Feb 19 22:42:53 2004
> @@ -41,6 +41,7 @@
>  #include <linux/reboot.h>
>  #include <linux/usb.h>
>  #include <linux/moduleparam.h>
> +#include <linux/dma-mapping.h>
>  
>  #include "../core/hcd.h"
>  
> 
> so this works for now, even though it's really really ugly (and it _will_
> BUG() out if anybody ever passes a non-PCI-related "struct device" to the
> thing).
> 
> Let's see if it boots too. So far it's only compiled successfully ;)
> 
> 		Linus
-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>

