Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267923AbUJLVo1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267923AbUJLVo1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 17:44:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267882AbUJLVnF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 17:43:05 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:19841 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S267893AbUJLVlv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 17:41:51 -0400
Date: Tue, 12 Oct 2004 14:42:09 -0700
From: Hanna Linder <hannal@us.ibm.com>
To: sfeldma@pobox.com
cc: Hanna Linder <hannal@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>,
       kernel-janitors <kernel-janitors@lists.osdl.org>,
       benh@kernel.crashing.org, paulus@samba.org, greg@kroah.com
Subject: Re: [Kernel-janitors] [PATCH 2.6][10/12] prep_pci.c replace	pci_find_device with pci_get_device
Message-ID: <147590000.1097617329@w-hlinder.beaverton.ibm.com>
In-Reply-To: <1097341535.3903.6.camel@sfeldma-mobl2.dsl-verizon.net>
References: <35460000.1097192417@w-hlinder.beaverton.ibm.com> <1097341535.3903.6.camel@sfeldma-mobl2.dsl-verizon.net>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--On Saturday, October 09, 2004 10:05:35 AM -0700 Scott Feldman <sfeldma@pobox.com> wrote:
> Missing pci_dev_put(dev) cleanup?

Here is the new patch. Thanks Scott.

Signed-off-by: Hanna Linder <hannal@us.ibm.com>

diff -Nrup linux-2.6.9-rc4-mm1cln/arch/ppc/platforms/prep_pci.c linux-2.6.9-rc4-mm1patch2/arch/ppc/platforms/prep_pci.c
--- linux-2.6.9-rc4-mm1cln/arch/ppc/platforms/prep_pci.c	2004-10-12 14:15:28.000000000 -0700
+++ linux-2.6.9-rc4-mm1patch2/arch/ppc/platforms/prep_pci.c	2004-10-12 14:29:11.165888096 -0700
@@ -1069,7 +1069,7 @@ prep_pib_init(void)
 		 * Perform specific configuration for the Via Tech or
 		 * or Winbond PCI-ISA-Bridge part.
 		 */
-		if ((dev = pci_find_device(PCI_VENDOR_ID_VIA,
+		if ((dev = pci_get_device(PCI_VENDOR_ID_VIA,
 					PCI_DEVICE_ID_VIA_82C586_1, dev))) {
 			/*
 			 * PPCBUG does not set the enable bits
@@ -1080,7 +1080,7 @@ prep_pib_init(void)
 			reg |= 0x03; /* IDE: Chip Enable Bits */
 			pci_write_config_byte(dev, 0x40, reg);
 		}
-		if ((dev = pci_find_device(PCI_VENDOR_ID_VIA,
+		if ((dev = pci_get_device(PCI_VENDOR_ID_VIA,
 						PCI_DEVICE_ID_VIA_82C586_2,
 						dev)) && (dev->devfn = 0x5a)) {
 			/* Force correct USB interrupt */
@@ -1089,7 +1089,7 @@ prep_pib_init(void)
 					PCI_INTERRUPT_LINE,
 					dev->irq);
 		}
-		if ((dev = pci_find_device(PCI_VENDOR_ID_WINBOND,
+		if ((dev = pci_get_device(PCI_VENDOR_ID_WINBOND,
 					PCI_DEVICE_ID_WINBOND_83C553, dev))) {
 			 /* Clear PCI Interrupt Routing Control Register. */
 			short_reg = 0x0000;
@@ -1100,9 +1100,10 @@ prep_pib_init(void)
 				pci_write_config_byte(dev, 0x43, reg);
 			}
 		}
+		pci_dev_put(dev);
 	}
 
-	if ((dev = pci_find_device(PCI_VENDOR_ID_WINBOND,
+	if ((dev = pci_get_device(PCI_VENDOR_ID_WINBOND,
 				   PCI_DEVICE_ID_WINBOND_82C105, dev))){
 		if (OpenPIC_Addr){
 			/*
@@ -1121,6 +1122,7 @@ prep_pib_init(void)
 			pci_write_config_dword(dev, 0x40, 0x10ff08a1);
 		}
 	}
+	pci_dev_put(dev);
 }
 
 static void __init
@@ -1207,7 +1209,7 @@ prep_pcibios_fixup(void)
 	printk("Setting PCI interrupts for a \"%s\"\n", Motherboard_map_name);
 
 	/* Iterate through all the PCI devices, setting the IRQ */
-	while ((dev = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL) {
+	for_each_pci_dev(dev) {
 		/*
 		 * If we have residual data, then this is easy: query the
 		 * residual data for the IRQ line allocated to the device.
@@ -1260,12 +1262,13 @@ prep_pcibios_after_init(void)
 	 * instead of 0xc0000. vgacon.c (for example) is completely unaware of
 	 * this little quirk.
 	 */
-	dev = pci_find_device(PCI_VENDOR_ID_WD, PCI_DEVICE_ID_WD_90C, NULL);
+	dev = pci_get_device(PCI_VENDOR_ID_WD, PCI_DEVICE_ID_WD_90C, NULL);
 	if (dev) {
 		dev->resource[1].end -= dev->resource[1].start;
 		dev->resource[1].start = 0;
 		/* tell the hardware */
 		pci_write_config_dword(dev, PCI_BASE_ADDRESS_1, 0x0);
+		pci_dev_put(dev);
 	}
 #endif
 }

