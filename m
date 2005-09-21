Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751106AbVIUP4A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751106AbVIUP4A (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 11:56:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751109AbVIUP4A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 11:56:00 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:20882 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S1751106AbVIUP4A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 11:56:00 -0400
Date: Wed, 21 Sep 2005 19:55:36 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Andreas Koch <koch@esa.informatik.tu-darmstadt.de>
Cc: linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: Re: Continuing PCI and Yenta troubles in 2.6.13.1 and 2.6.14-rc1
Message-ID: <20050921195536.A32255@jurassic.park.msu.ru>
References: <200509030138.11905.koch@esa.informatik.tu-darmstadt.de> <200509201202.24318.koch@esa.informatik.tu-darmstadt.de> <20050920165902.A27065@jurassic.park.msu.ru> <200509202006.19193.koch@esa.informatik.tu-darmstadt.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200509202006.19193.koch@esa.informatik.tu-darmstadt.de>; from koch@esa.informatik.tu-darmstadt.de on Tue, Sep 20, 2005 at 08:06:15PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 20, 2005 at 08:06:15PM +0200, Andreas Koch wrote:
> many thanks for the quick patch. I have applied it and your previous Yenta 
> patch (is that still necessary with the new patch?) to 2.6.13.2.

Yenta patch is still needed (it will be included in 2.6.13.3). 

> With pci=assign-busses, I don't see any obvious oops or slow-downs either.
> However: As you can see from the attached boot log (assign-busses-26132.log), 
> there are now problems with the USB ports 9-2 and 10-2, on  
> uhci_hcd 0000:05:02.1 and uhci_hcd 0000:05:03.0, respectively. This delays the 
> boot for about 5 seconds per error, but does continue. The system doesn't 
> hang afterwards, either (again, tested for roughly 15min). The lspci-vvx 
> output is attached as assign-busses-26132.lspci.

These errors most likely mean that there are no interrupts form PCI
devices in the docking station. I'd suppose that massively changed bus
numbers make ACPI confused wrt interrupt routing, but all relevant IRQs
are exactly the same as without "assign-busses", so I'm puzzled...

> I'll try using the patched 2.6.13.2 without pci=assign-busses in the next few 
> days and test whether other instabilities come up. If you want me to try 
> further patches for fixing the assign-busses option, I'm game.

At the moment I can only think of something like this: the PCIE-to-PCI bridge
(Intel 6702PXH) in your docking station also has IOxAPIC as PCI function #1,
but its config space is turned off by BIOS for some reason. However, its MMIO
registers are still present somewhere in PCI address space - we just don't
know where.
So there is a small possibility that we have accidentally stepped on them
and destroyed IRQ routing setup writing to MMIO registers of totally
unrelated device.

Please test this patch, though chances that it helps are quite small...
In either case lspci output will be useful.

Ivan.

--- 2.6.13.2/drivers/pci/quirks.c	Mon Aug 29 03:41:01 2005
+++ linux/drivers/pci/quirks.c	Wed Sep 21 16:58:01 2005
@@ -1298,6 +1298,12 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_IN
  */
 static void __devinit quirk_pcie_pxh(struct pci_dev *dev)
 {
+	u16 ctrl;
+
+	/* Enable config access to I/OxAPIC function. */
+	pci_read_config_word(dev, 0x40, &ctrl);
+	pci_write_config_word(dev, 0x40, ctrl | 0x2000);
+
 	disable_msi_mode(dev, pci_find_capability(dev, PCI_CAP_ID_MSI),
 					PCI_CAP_ID_MSI);
 	dev->no_msi = 1;
