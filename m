Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751281AbVHVXlG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751281AbVHVXlG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 19:41:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751309AbVHVXlG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 19:41:06 -0400
Received: from smtp.osdl.org ([65.172.181.4]:15780 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751281AbVHVXlF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 19:41:05 -0400
Date: Mon, 22 Aug 2005 16:40:50 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Dave Airlie <airlied@gmail.com>
cc: Helge Hafting <helgehaf@aitel.hist.no>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
       Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Subject: Re: rc6 keeps hanging and blanking displays
In-Reply-To: <21d7e9970508221607bb74cc7@mail.gmail.com>
Message-ID: <Pine.LNX.4.58.0508221628140.3317@g5.osdl.org>
References: <20050815221109.GA21279@aitel.hist.no>  <21d7e99705081516241197164a@mail.gmail.com>
  <20050816165242.GA10024@aitel.hist.no>  <Pine.LNX.4.58.0508160955270.3553@g5.osdl.org>
  <20050816211424.GA14367@aitel.hist.no>  <21d7e99705081616504d28cca5@mail.gmail.com>
  <43031A12.8020301@aitel.hist.no>  <21d7e997050817040523a1bf46@mail.gmail.com>
  <Pine.LNX.4.58.0508170815370.3553@g5.osdl.org>  <20050822214453.GA31266@aitel.hist.no>
 <21d7e9970508221607bb74cc7@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 23 Aug 2005, Dave Airlie wrote:
> 
> Can we revert the PCI assign resources patch?

I'd rather not revert the whole PCI assign thing, because it's good.

But disabling the ROM assignment might be a good idea. Almost nobody ever 
really wants to assign the ROM anyway, and there are cards where there are 
some strange rules about ROM alignment (read: doesn't follow spec).

That may be the problem with MGA - I think some gfx cards used the same
decoder for ROM and for the video RAM aperture, so that you were supposed
to only enable ROM when the RAM thing was quiescent or something, and 
always use the same address too (the current code doesn't _enable_ the 
ROM, but I think it allocates and programs the base address. Which 
should be harmless, but..).

Ivan? Does something like this make a difference?

		Linus

---
diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
--- a/drivers/pci/setup-res.c
+++ b/drivers/pci/setup-res.c
@@ -52,10 +52,12 @@ pci_update_resource(struct pci_dev *dev,
 
 	if (resno < 6) {
 		reg = PCI_BASE_ADDRESS_0 + 4 * resno;
+#if 0
 	} else if (resno == PCI_ROM_RESOURCE) {
 		new |= res->flags & IORESOURCE_ROM_ENABLE;
 		reg = dev->rom_base_reg;
 	} else {
+#endif
 		/* Hmm, non-standard resource. */
 	
 		return;		/* kill uninitialised var warning */
