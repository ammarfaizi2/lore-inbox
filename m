Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269954AbUJGXrG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269954AbUJGXrG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 19:47:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269939AbUJGXqb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 19:46:31 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:5565 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S269938AbUJGXjp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 19:39:45 -0400
Date: Thu, 07 Oct 2004 16:40:17 -0700
From: Hanna Linder <hannal@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
cc: kernel-janitors <kernel-janitors@lists.osdl.org>, greg@kroah.com,
       hannal@us.ibm.com, paulus@samba.org, benh@kernel.crashing.org
Subject: [PATCH 2.6][10/12] prep_pci.c replace pci_find_device with pci_get_device
Message-ID: <35460000.1097192417@w-hlinder.beaverton.ibm.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


As pci_find_device is going away I've replaced it with pci_get_device.
If someone with a PPC system could test it I would appreciate it.

Thanks.

Hanna Linder
IBM Linux Technology Center

Signed-off-by: Hanna Linder <hannal@us.ibm.com>

---
diff -Nrup linux-2.6.9-rc3-mm3cln/arch/ppc/platforms/prep_pci.c linux-2.6.9-rc3-mm3patch/arch/ppc/platforms/prep_pci.c
--- linux-2.6.9-rc3-mm3cln/arch/ppc/platforms/prep_pci.c	2004-09-29 20:05:51.000000000 -0700
+++ linux-2.6.9-rc3-mm3patch/arch/ppc/platforms/prep_pci.c	2004-10-07 16:29:09.995482096 -0700
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
@@ -1102,7 +1102,7 @@ prep_pib_init(void)
 		}
 	}
 
-	if ((dev = pci_find_device(PCI_VENDOR_ID_WINBOND,
+	if ((dev = pci_get_device(PCI_VENDOR_ID_WINBOND,
 				   PCI_DEVICE_ID_WINBOND_82C105, dev))){
 		if (OpenPIC_Addr){
 			/*
@@ -1207,7 +1207,7 @@ prep_pcibios_fixup(void)
 	printk("Setting PCI interrupts for a \"%s\"\n", Motherboard_map_name);
 
 	/* Iterate through all the PCI devices, setting the IRQ */
-	while ((dev = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL) {
+	for_each_pci_dev(dev) {
 		/*
 		 * If we have residual data, then this is easy: query the
 		 * residual data for the IRQ line allocated to the device.
@@ -1260,12 +1260,13 @@ prep_pcibios_after_init(void)
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

