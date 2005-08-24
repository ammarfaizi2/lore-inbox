Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750866AbVHXGFz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750866AbVHXGFz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 02:05:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751461AbVHXGFz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 02:05:55 -0400
Received: from smtp.osdl.org ([65.172.181.4]:62415 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750866AbVHXGFy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 02:05:54 -0400
Date: Tue, 23 Aug 2005 23:04:52 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Dave Airlie <airlied@gmail.com>
cc: Helge Hafting <helgehaf@aitel.hist.no>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
       Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Subject: Re: rc6 keeps hanging and blanking displays
In-Reply-To: <Pine.LNX.4.58.0508221628140.3317@g5.osdl.org>
Message-ID: <Pine.LNX.4.58.0508232302370.3317@g5.osdl.org>
References: <20050815221109.GA21279@aitel.hist.no>  <21d7e99705081516241197164a@mail.gmail.com>
  <20050816165242.GA10024@aitel.hist.no>  <Pine.LNX.4.58.0508160955270.3553@g5.osdl.org>
  <20050816211424.GA14367@aitel.hist.no>  <21d7e99705081616504d28cca5@mail.gmail.com>
  <43031A12.8020301@aitel.hist.no>  <21d7e997050817040523a1bf46@mail.gmail.com>
  <Pine.LNX.4.58.0508170815370.3553@g5.osdl.org>  <20050822214453.GA31266@aitel.hist.no>
 <21d7e9970508221607bb74cc7@mail.gmail.com> <Pine.LNX.4.58.0508221628140.3317@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 22 Aug 2005, Linus Torvalds wrote:
> 
> But disabling the ROM assignment might be a good idea. Almost nobody ever 
> really wants to assign the ROM anyway, and there are cards where there are 
> some strange rules about ROM alignment (read: doesn't follow spec).

Here's an even better idea.

Let's do the assignment internally in the kernel, but just not write it to 
the device unless it's actually enabled. IOW, we'll be doing all the 
resource allocation, but devices won't be affected. Modern lspci versions 
will show this as a "[virtual] Expansion ROM".

The patch might look something like this. Helge, does this make any 
difference?

Ivan, opinions?

		Linus
---
diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
--- a/drivers/pci/setup-res.c
+++ b/drivers/pci/setup-res.c
@@ -53,7 +53,9 @@ pci_update_resource(struct pci_dev *dev,
 	if (resno < 6) {
 		reg = PCI_BASE_ADDRESS_0 + 4 * resno;
 	} else if (resno == PCI_ROM_RESOURCE) {
-		new |= res->flags & IORESOURCE_ROM_ENABLE;
+		if (!(res->flags & IORESOURCE_ROM_ENABLE))
+			return;
+		new |= PCI_ROM_ADDRESS_ENABLE;
 		reg = dev->rom_base_reg;
 	} else {
 		/* Hmm, non-standard resource. */
