Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262700AbUKLXos@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262700AbUKLXos (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 18:44:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262650AbUKLXnk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 18:43:40 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.103]:34947 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262711AbUKLXWy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 18:22:54 -0500
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI fixes for 2.6.10-rc1
User-Agent: Mutt/1.5.6i
In-Reply-To: <1100301721392@kroah.com>
Date: Fri, 12 Nov 2004 15:22:01 -0800
Message-Id: <11003017212416@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2091.1.25, 2004/11/12 14:12:34-08:00, hannal@us.ibm.com

[PATCH] prep_pci.c: replace pci_find_device with pci_get_device

Signed-off-by: Hanna Linder <hannal@us.ibm.com>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 arch/ppc/platforms/prep_pci.c |   15 +++++++++------
 1 files changed, 9 insertions(+), 6 deletions(-)


diff -Nru a/arch/ppc/platforms/prep_pci.c b/arch/ppc/platforms/prep_pci.c
--- a/arch/ppc/platforms/prep_pci.c	2004-11-12 15:08:57 -08:00
+++ b/arch/ppc/platforms/prep_pci.c	2004-11-12 15:08:57 -08:00
@@ -1069,7 +1069,7 @@
 		 * Perform specific configuration for the Via Tech or
 		 * or Winbond PCI-ISA-Bridge part.
 		 */
-		if ((dev = pci_find_device(PCI_VENDOR_ID_VIA,
+		if ((dev = pci_get_device(PCI_VENDOR_ID_VIA,
 					PCI_DEVICE_ID_VIA_82C586_1, dev))) {
 			/*
 			 * PPCBUG does not set the enable bits
@@ -1080,7 +1080,7 @@
 			reg |= 0x03; /* IDE: Chip Enable Bits */
 			pci_write_config_byte(dev, 0x40, reg);
 		}
-		if ((dev = pci_find_device(PCI_VENDOR_ID_VIA,
+		if ((dev = pci_get_device(PCI_VENDOR_ID_VIA,
 						PCI_DEVICE_ID_VIA_82C586_2,
 						dev)) && (dev->devfn = 0x5a)) {
 			/* Force correct USB interrupt */
@@ -1089,7 +1089,7 @@
 					PCI_INTERRUPT_LINE,
 					dev->irq);
 		}
-		if ((dev = pci_find_device(PCI_VENDOR_ID_WINBOND,
+		if ((dev = pci_get_device(PCI_VENDOR_ID_WINBOND,
 					PCI_DEVICE_ID_WINBOND_83C553, dev))) {
 			 /* Clear PCI Interrupt Routing Control Register. */
 			short_reg = 0x0000;
@@ -1100,9 +1100,10 @@
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
@@ -1121,6 +1122,7 @@
 			pci_write_config_dword(dev, 0x40, 0x10ff08a1);
 		}
 	}
+	pci_dev_put(dev);
 }
 
 static void __init
@@ -1207,7 +1209,7 @@
 	printk("Setting PCI interrupts for a \"%s\"\n", Motherboard_map_name);
 
 	/* Iterate through all the PCI devices, setting the IRQ */
-	while ((dev = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL) {
+	for_each_pci_dev(dev) {
 		/*
 		 * If we have residual data, then this is easy: query the
 		 * residual data for the IRQ line allocated to the device.
@@ -1260,12 +1262,13 @@
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

