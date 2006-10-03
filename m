Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030652AbWJCXFq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030652AbWJCXFq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 19:05:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030658AbWJCXFq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 19:05:46 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:62368 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1030652AbWJCXFc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 19:05:32 -0400
Subject: [PATCH] ide : more conversion to pci_get APIs
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 04 Oct 2006 00:30:46 +0100
Message-Id: <1159918246.17553.100.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This completes IDE except for one use which requires a new core PCI
function and will be polished up at the end

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-mm3/drivers/ide/pci/alim15x3.c linux-2.6.18-mm3/drivers/ide/pci/alim15x3.c
--- linux.vanilla-2.6.18-mm3/drivers/ide/pci/alim15x3.c	2006-10-03 19:06:21.805503096 +0100
+++ linux-2.6.18-mm3/drivers/ide/pci/alim15x3.c	2006-09-25 12:19:18.000000000 +0100
@@ -586,11 +586,11 @@
 {
 	unsigned long flags;
 	u8 tmpbyte;
-	struct pci_dev *north = pci_find_slot(0, PCI_DEVFN(0,0));
+	struct pci_dev *north = pci_get_slot(dev->bus, PCI_DEVFN(0,0));
 
 	pci_read_config_byte(dev, PCI_REVISION_ID, &m5229_revision);
 
-	isa_dev = pci_find_device(PCI_VENDOR_ID_AL, PCI_DEVICE_ID_AL_M1533, NULL);
+	isa_dev = pci_get_device(PCI_VENDOR_ID_AL, PCI_DEVICE_ID_AL_M1533, NULL);
 
 #if defined(DISPLAY_ALI_TIMINGS) && defined(CONFIG_PROC_FS)
 	if (!ali_proc) {
@@ -613,8 +613,7 @@
 		 * clear bit 7
 		 */
 		pci_write_config_byte(dev, 0x4b, tmpbyte & 0x7F);
-		local_irq_restore(flags);
-		return 0;
+		goto out;
 	}
 
 	/*
@@ -637,10 +636,8 @@
 	 * box without a device at 0:0.0. The ALi bridge will be at
 	 * 0:0.0 so if we didn't find one we know what is cooking.
 	 */
-	if (north && north->vendor != PCI_VENDOR_ID_AL) {
-		local_irq_restore(flags);
-	        return 0;
-	}
+	if (north && north->vendor != PCI_VENDOR_ID_AL)
+		goto out;
 
 	if (m5229_revision < 0xC5 && isa_dev)
 	{	
@@ -661,6 +658,9 @@
 			pci_write_config_byte(isa_dev, 0x79, tmpbyte | 0x02);
 		}
 	}
+out:
+	pci_dev_put(north);
+	pci_dev_put(isa_dev);
 	local_irq_restore(flags);
 	return 0;
 }
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-mm3/drivers/ide/pci/pdc202xx_new.c linux-2.6.18-mm3/drivers/ide/pci/pdc202xx_new.c
--- linux.vanilla-2.6.18-mm3/drivers/ide/pci/pdc202xx_new.c	2006-10-03 19:06:21.829499448 +0100
+++ linux-2.6.18-mm3/drivers/ide/pci/pdc202xx_new.c	2006-09-25 12:19:18.000000000 +0100
@@ -362,6 +362,7 @@
 					 ide_pci_device_t *d)
 {
 	struct pci_dev *findev = NULL;
+	int ret;
 
 	if ((dev->bus->self &&
 	     dev->bus->self->vendor == PCI_VENDOR_ID_DEC) &&
@@ -369,14 +370,16 @@
 		if (PCI_SLOT(dev->devfn) & 2)
 			return -ENODEV;
 		d->extra = 0;
-		while ((findev = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, findev)) != NULL) {
+		while ((findev = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, findev)) != NULL) {
 			if ((findev->vendor == dev->vendor) &&
 			    (findev->device == dev->device) &&
 			    (PCI_SLOT(findev->devfn) & 2)) {
 				if (findev->irq != dev->irq) {
 					findev->irq = dev->irq;
 				}
-				return ide_setup_pci_devices(dev, findev, d);
+				ret = ide_setup_pci_devices(dev, findev, d);
+				pci_dev_put(findev);
+				return ret;
 			}
 		}
 	}
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-mm3/drivers/ide/pci/sis5513.c linux-2.6.18-mm3/drivers/ide/pci/sis5513.c
--- linux.vanilla-2.6.18-mm3/drivers/ide/pci/sis5513.c	2006-10-03 19:23:03.177271448 +0100
+++ linux-2.6.18-mm3/drivers/ide/pci/sis5513.c	2006-09-25 12:35:35.000000000 +0100
@@ -800,9 +800,10 @@
 
 			if (trueid == 0x5517) { /* SiS 961/961B */
 
-				lpc_bridge = pci_find_slot(0x00, 0x10); /* Bus 0, Dev 2, Fn 0 */
+				lpc_bridge = pci_get_slot(dev->bus, 0x10); /* Bus 0, Dev 2, Fn 0 */
 				pci_read_config_byte(lpc_bridge, PCI_REVISION_ID, &sbrev);
 				pci_read_config_byte(dev, 0x49, &prefctl);
+				pci_dev_put(lpc_bridge);
 
 				if (sbrev == 0x10 && (prefctl & 0x80)) {
 					printk(KERN_INFO "SIS5513: SiS 961B MuTIOL IDE UDMA133 controller\n");
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-mm3/include/asm-i386/ide.h linux-2.6.18-mm3/include/asm-i386/ide.h
--- linux.vanilla-2.6.18-mm3/include/asm-i386/ide.h	2006-10-03 19:06:52.988762520 +0100
+++ linux-2.6.18-mm3/include/asm-i386/ide.h	2006-09-25 12:26:46.000000000 +0100
@@ -40,13 +40,14 @@
 
 static __inline__ unsigned long ide_default_io_base(int index)
 {
+	struct pci_dev *pdev;
 	/*
 	 *	If PCI is present then it is not safe to poke around
 	 *	the other legacy IDE ports. Only 0x1f0 and 0x170 are
 	 *	defined compatibility mode ports for PCI. A user can 
 	 *	override this using ide= but we must default safe.
 	 */
-	if (pci_find_device(PCI_ANY_ID, PCI_ANY_ID, NULL) == NULL) {
+	if ((pdev = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, NULL)) == NULL) {
 		switch(index) {
 			case 2: return 0x1e8;
 			case 3: return 0x168;
@@ -54,6 +55,7 @@
 			case 5: return 0x160;
 		}
 	}
+	pci_dev_put(pdev);
 	switch (index) {
 		case 0:	return 0x1f0;
 		case 1:	return 0x170;

