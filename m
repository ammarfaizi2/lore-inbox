Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932647AbVIMOZr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932647AbVIMOZr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 10:25:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932648AbVIMOZr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 10:25:47 -0400
Received: from smtp.osdl.org ([65.172.181.4]:26245 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932647AbVIMOZq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 10:25:46 -0400
Date: Tue, 13 Sep 2005 07:25:11 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Norbert Kiesel <nkiesel@tbdnetworks.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.13.1 locks machine after some time, 2.6.12.5 work fine
In-Reply-To: <20050913033814.GA879@tbdnetworks.com>
Message-ID: <Pine.LNX.4.58.0509130717360.3351@g5.osdl.org>
References: <1126569577.25875.25.camel@defiant> <Pine.LNX.4.58.0509121950340.3266@g5.osdl.org>
 <20050913033814.GA879@tbdnetworks.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 12 Sep 2005, Norbert Kiesel wrote:
> 
> diff is appended.  Regarding the -rc3 and friends, currently I can't as
> I jumped directly from 12.5 to 13.  This is my desktop at work, so I
> try to keep it somewhat stable.  However, if you have a guess which
> versions to try, I can give it a spin.  It takes some time though to
> test, as the lockup normally only happens after 1 hour or so (although
> I could propably speed this up by doing lots of disk IO).

No need. The numbers made it clear: this is the same bug that hit the 
hpt366 driver:

	 0000:00:10.0 RAID bus controller: Silicon Image, Inc. SiI 0649
			Ultra ATA/100 PCI to ATA Host Controller (rev 01)
	 ...
	 00: 95 10 49 06 07 00 90 02 01 00 04 01 00 40 00 00
	 10: 01 b8 00 00 01 bc 00 00 01 c0 00 00 01 c4 00 00
	 20: 01 c8 00 00 00 00 00 00 00 00 00 00 95 10 49 06
	-30: 00 00 00 00 60 00 00 00 00 00 00 00 0c 01 02 04
	+30: 01 00 00 00 60 00 00 00 00 00 00 00 0c 01 02 04

and the exact same cause too. 

I wonder who the _hell_ has been sprinkling these _byte_ writes to the ROM
enable logic around?

I bet this will fix it..

		Linus
---
diff --git a/drivers/ide/pci/cmd64x.c b/drivers/ide/pci/cmd64x.c
--- a/drivers/ide/pci/cmd64x.c
+++ b/drivers/ide/pci/cmd64x.c
@@ -608,7 +608,7 @@ static unsigned int __devinit init_chips
 
 #ifdef __i386__
 	if (dev->resource[PCI_ROM_RESOURCE].start) {
-		pci_write_config_byte(dev, PCI_ROM_ADDRESS, dev->resource[PCI_ROM_RESOURCE].start | PCI_ROM_ADDRESS_ENABLE);
+		pci_write_config_dword(dev, PCI_ROM_ADDRESS, dev->resource[PCI_ROM_RESOURCE].start | PCI_ROM_ADDRESS_ENABLE);
 		printk(KERN_INFO "%s: ROM enabled at 0x%08lx\n", name, dev->resource[PCI_ROM_RESOURCE].start);
 	}
 #endif
