Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267615AbUBTGml (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 01:42:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267656AbUBTGml
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 01:42:41 -0500
Received: from fw.osdl.org ([65.172.181.6]:52973 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267615AbUBTGmh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 01:42:37 -0500
Date: Thu, 19 Feb 2004 22:47:46 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>,
       Linux-USB <linux-usb-devel@lists.sourceforge.net>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BK PATCH] USB update for 2.6.3
In-Reply-To: <1077258504.20781.1121.camel@gaston>
Message-ID: <Pine.LNX.4.58.0402192243170.14296@ppc970.osdl.org>
References: <20040220012802.GA16523@kroah.com>  <Pine.LNX.4.58.0402192156240.2244@ppc970.osdl.org>
  <1077256996.20789.1091.camel@gaston>  <Pine.LNX.4.58.0402192221560.2244@ppc970.osdl.org>
 <1077258504.20781.1121.camel@gaston>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 20 Feb 2004, Benjamin Herrenschmidt wrote:
> 
> Yes, but we don't have a hook for actually filling this pointer, do we ?

Well, we do. The pcibios_xxx routines get called for all PCI devices 
during discovery, and that's when you'd fill them in.

Anyway, I found the bug - the "asm-generic/dma-mapping.h" compatibility 
macros _do_ work, but the EHCI controller driver doesn't actually include 
that header file. Oops.

> We should have a way, when creating a device, to fill it properly, like
> 
> platform_device_setup(struct device *new_dev, struct device *parent)

No no. That wouldn't work AT ALL, since the whole point is that you need 
to know what the device is - ie you need to fill in the information when 
you get the "struct pci_dev *" (because different buses would most likely 
have different behaviour, and could have different requirements for DMA 
mapping etc). 

So the platform code that actually knows what the device is (pcibios_xxx 
for PCI devices) would fill in the platform pointer.

Anyway, I got it all working with the trivial patch..

===== drivers/usb/host/ehci-hcd.c 1.67 vs edited =====
--- 1.67/drivers/usb/host/ehci-hcd.c    Wed Feb 11 03:42:39 2004
+++ edited/drivers/usb/host/ehci-hcd.c  Thu Feb 19 22:42:53 2004
@@ -41,6 +41,7 @@
 #include <linux/reboot.h>
 #include <linux/usb.h>
 #include <linux/moduleparam.h>
+#include <linux/dma-mapping.h>
 
 #include "../core/hcd.h"
 

so this works for now, even though it's really really ugly (and it _will_
BUG() out if anybody ever passes a non-PCI-related "struct device" to the
thing).

Let's see if it boots too. So far it's only compiled successfully ;)

		Linus
