Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751469AbWION6W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751469AbWION6W (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 09:58:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751475AbWION6W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 09:58:22 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:47012 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751469AbWION6V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 09:58:21 -0400
Subject: [PATCH] mtd: switch to pci_get_device and do ref counting
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: akpm@osdl.org, dwmw2@redhat.com, linux-kernel@vger.kernel.org,
       linux-mtd@lists.infradead.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 15 Sep 2006 15:20:32 +0100
Message-Id: <1158330032.29932.48.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-rc6-mm1/drivers/mtd/devices/pmc551.c linux-2.6.18-rc6-mm1/drivers/mtd/devices/pmc551.c
--- linux.vanilla-2.6.18-rc6-mm1/drivers/mtd/devices/pmc551.c	2006-09-11 17:00:13.000000000 +0100
+++ linux-2.6.18-rc6-mm1/drivers/mtd/devices/pmc551.c	2006-09-14 17:13:56.000000000 +0100
@@ -674,7 +674,7 @@
          */
         for( count = 0; count < MAX_MTD_DEVICES; count++ ) {
 
-                if ((PCI_Device = pci_find_device(PCI_VENDOR_ID_V3_SEMI,
+                if ((PCI_Device = pci_get_device(PCI_VENDOR_ID_V3_SEMI,
                                                   PCI_DEVICE_ID_V3_SEMI_V370PDC,
 						  PCI_Device ) ) == NULL) {
                         break;
@@ -783,6 +783,10 @@
                         kfree(mtd);
                         break;
                 }
+                
+                /* Keep a reference as the add_mtd_device worked */
+                pci_dev_get(PCI_Device);
+
                 printk(KERN_NOTICE "Registered pmc551 memory device.\n");
                 printk(KERN_NOTICE "Mapped %dM of memory from 0x%p to 0x%p\n",
                        priv->asize>>20,
@@ -797,6 +801,10 @@
 		found++;
         }
 
+        /* Exited early, reference left over */
+        if (PCI_Device)
+        	pci_dev_put(PCI_Device);
+
         if( !pmc551list ) {
                 printk(KERN_NOTICE "pmc551: not detected\n");
                 return -ENODEV;
@@ -824,6 +832,7 @@
 				priv->asize>>20, priv->start);
 			iounmap (priv->start);
 		}
+		pci_dev_put(priv->dev);
 
 		kfree (mtd->priv);
 		del_mtd_device (mtd);
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-rc6-mm1/drivers/mtd/maps/amd76xrom.c linux-2.6.18-rc6-mm1/drivers/mtd/maps/amd76xrom.c
--- linux.vanilla-2.6.18-rc6-mm1/drivers/mtd/maps/amd76xrom.c	2006-09-11 11:02:17.000000000 +0100
+++ linux-2.6.18-rc6-mm1/drivers/mtd/maps/amd76xrom.c	2006-09-14 17:10:52.000000000 +0100
@@ -57,11 +57,12 @@
 		/* Disable writes through the rom window */
 		pci_read_config_byte(window->pdev, 0x40, &byte);
 		pci_write_config_byte(window->pdev, 0x40, byte & ~1);
+		pci_dev_put(window->pdev);
 	}
 
 	/* Free all of the mtd devices */
 	list_for_each_entry_safe(map, scratch, &window->maps, list) {
-		if (map->rsrc.parent) {
+		if (map->rsrc.parent) {
 			release_resource(&map->rsrc);
 		}
 		del_mtd_device(map->mtd);
@@ -91,7 +92,7 @@
 	struct amd76xrom_map_info *map = NULL;
 	unsigned long map_top;
 
-	/* Remember the pci dev I find the window in */
+	/* Remember the pci dev I find the window in - already have a ref */
 	window->pdev = pdev;
 
 	/* Assume the rom window is properly setup, and find it's size */
@@ -302,7 +303,7 @@
 	struct pci_device_id *id;
 	pdev = NULL;
 	for(id = amd76xrom_pci_tbl; id->vendor; id++) {
-		pdev = pci_find_device(id->vendor, id->device, NULL);
+		pdev = pci_get_device(id->vendor, id->device, NULL);
 		if (pdev) {
 			break;
 		}
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-rc6-mm1/drivers/mtd/maps/ichxrom.c linux-2.6.18-rc6-mm1/drivers/mtd/maps/ichxrom.c
--- linux.vanilla-2.6.18-rc6-mm1/drivers/mtd/maps/ichxrom.c	2006-09-11 11:02:17.000000000 +0100
+++ linux-2.6.18-rc6-mm1/drivers/mtd/maps/ichxrom.c	2006-09-14 17:11:15.000000000 +0100
@@ -61,6 +61,7 @@
 	/* Disable writes through the rom window */
 	pci_read_config_word(window->pdev, BIOS_CNTL, &word);
 	pci_write_config_word(window->pdev, BIOS_CNTL, word & ~1);
+	pci_dev_put(window->pdev);
 
 	/* Free all of the mtd devices */
 	list_for_each_entry_safe(map, scratch, &window->maps, list) {
@@ -355,7 +356,7 @@
 
 	pdev = NULL;
 	for (id = ichxrom_pci_tbl; id->vendor; id++) {
-		pdev = pci_find_device(id->vendor, id->device, NULL);
+		pdev = pci_get_device(id->vendor, id->device, NULL);
 		if (pdev) {
 			break;
 		}
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-rc6-mm1/drivers/mtd/maps/l440gx.c linux-2.6.18-rc6-mm1/drivers/mtd/maps/l440gx.c
--- linux.vanilla-2.6.18-rc6-mm1/drivers/mtd/maps/l440gx.c	2006-09-11 11:02:17.000000000 +0100
+++ linux-2.6.18-rc6-mm1/drivers/mtd/maps/l440gx.c	2006-09-14 17:06:58.000000000 +0100
@@ -61,14 +61,17 @@
 	struct resource *pm_iobase;
 	__u16 word;
 
-	dev = pci_find_device(PCI_VENDOR_ID_INTEL,
+	dev = pci_get_device(PCI_VENDOR_ID_INTEL,
 		PCI_DEVICE_ID_INTEL_82371AB_0, NULL);
 
-	pm_dev = pci_find_device(PCI_VENDOR_ID_INTEL,
+	pm_dev = pci_get_device(PCI_VENDOR_ID_INTEL,
 		PCI_DEVICE_ID_INTEL_82371AB_3, NULL);
 
+	pci_dev_put(dev);
+
 	if (!dev || !pm_dev) {
 		printk(KERN_NOTICE "L440GX flash mapping: failed to find PIIX4 ISA bridge, cannot continue\n");
+		pci_dev_put(pm_dev);
 		return -ENODEV;
 	}
 
@@ -76,6 +79,7 @@
 
 	if (!l440gx_map.virt) {
 		printk(KERN_WARNING "Failed to ioremap L440GX flash region\n");
+		pci_dev_put(pm_dev);
 		return -ENOMEM;
 	}
 	simple_map_init(&l440gx_map);
@@ -99,8 +103,12 @@
 		pm_iobase->start += iobase & ~1;
 		pm_iobase->end += iobase & ~1;
 
+		pci_dev_put(pm_dev);
+
 		/* Allocate the resource region */
 		if (pci_assign_resource(pm_dev, PIIXE_IOBASE_RESOURCE) != 0) {
+			pci_dev_put(dev);
+			pci_dev_put(pm_dev);
 			printk(KERN_WARNING "Could not allocate pm iobase resource\n");
 			iounmap(l440gx_map.virt);
 			return -ENXIO;
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-rc6-mm1/drivers/mtd/maps/scx200_docflash.c linux-2.6.18-rc6-mm1/drivers/mtd/maps/scx200_docflash.c
--- linux.vanilla-2.6.18-rc6-mm1/drivers/mtd/maps/scx200_docflash.c	2006-09-11 11:02:17.000000000 +0100
+++ linux-2.6.18-rc6-mm1/drivers/mtd/maps/scx200_docflash.c	2006-09-14 17:04:02.000000000 +0100
@@ -87,19 +87,23 @@
 
 	printk(KERN_DEBUG NAME ": NatSemi SCx200 DOCCS Flash Driver\n");
 
-	if ((bridge = pci_find_device(PCI_VENDOR_ID_NS,
+	if ((bridge = pci_get_device(PCI_VENDOR_ID_NS,
 				      PCI_DEVICE_ID_NS_SCx200_BRIDGE,
 				      NULL)) == NULL)
 		return -ENODEV;
 
 	/* check that we have found the configuration block */
-	if (!scx200_cb_present())
+	if (!scx200_cb_present()) {
+		pci_dev_put(bridge);
 		return -ENODEV;
+	}
 
 	if (probe) {
 		/* Try to use the present flash mapping if any */
 		pci_read_config_dword(bridge, SCx200_DOCCS_BASE, &base);
 		pci_read_config_dword(bridge, SCx200_DOCCS_CTRL, &ctrl);
+		pci_dev_put(bridge);
+
 		pmr = inl(scx200_cb_base + SCx200_PMR);
 
 		if (base == 0
@@ -127,6 +131,7 @@
 			return -ENOMEM;
 		}
 	} else {
+		pci_dev_put(bridge);
 		for (u = size; u > 1; u >>= 1)
 			;
 		if (u != 1) {

