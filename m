Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261338AbVGGMgr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261338AbVGGMgr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 08:36:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261379AbVGGMep
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 08:34:45 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:52631 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S261456AbVGGMcA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 08:32:00 -0400
Date: Thu, 7 Jul 2005 16:31:40 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Tero Roponen <teanropo@cc.jyu.fi>
Cc: Jon Smirl <jonsmirl@gmail.com>, gregkh@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc2 hangs at boot
Message-ID: <20050707163140.A4006@jurassic.park.msu.ru>
References: <Pine.GSO.4.58.0507061638380.13297@tukki.cc.jyu.fi> <9e47339105070618273dfb6ff8@mail.gmail.com> <20050707135928.A3314@jurassic.park.msu.ru> <Pine.GSO.4.58.0507071324560.26776@tukki.cc.jyu.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.4.58.0507071324560.26776@tukki.cc.jyu.fi>; from teanropo@cc.jyu.fi on Thu, Jul 07, 2005 at 01:33:46PM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 07, 2005 at 01:33:46PM +0300, Tero Roponen wrote:
> 00:00.0 Host bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX Host bridge (AGP disabled) (rev 02)
> 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> 	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR+
> 	Latency: 64
> 	Region 0: Memory at <unassigned> (32-bit, prefetchable)
			    ^^^^^^^^^^^^
I'd bet this is the cause of your problem.
The pci_assign_unassigned_resources() is not aware of potential
problems with i386 host bridges and just reassigns this region.
Which effectively turns the DMA off on your machine, I guess.

The patch here (against clean 2.6.13-rc2) should fix that.

Ivan.

--- 2.6.13-rc2/arch/i386/pci/i386.c	Thu Jul  7 15:38:54 2005
+++ linux/arch/i386/pci/i386.c	Thu Jul  7 15:40:26 2005
@@ -176,10 +176,6 @@ static int __init pcibios_assign_resourc
 	for_each_pci_dev(dev) {
 		int class = dev->class >> 8;
 
-		/* Don't touch classless devices and host bridges */
-		if (!class || class == PCI_CLASS_BRIDGE_HOST)
-			continue;
-
 		for(idx=0; idx<6; idx++) {
 			r = &dev->resource[idx];
 
@@ -195,8 +191,15 @@ static int __init pcibios_assign_resourc
 			 *  the BIOS forgot to do so or because we have decided the old
 			 *  address was unusable for some reason.
 			 */
-			if (!r->start && r->end)
-				pci_assign_resource(dev, idx);
+			if (!r->start && r->end) {
+				/* Don't touch classless devices and host
+				   bridges and also hide their unassigned
+				   resources from the rest of PCI subsystem. */
+				if (!class || class == PCI_CLASS_BRIDGE_HOST)
+					r->flags = 0;
+				else
+					pci_assign_resource(dev, idx);
+			}
 		}
 
 		if (pci_probe & PCI_ASSIGN_ROMS) {
