Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964984AbWE0WGz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964984AbWE0WGz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 May 2006 18:06:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964994AbWE0WGy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 May 2006 18:06:54 -0400
Received: from rtsoft2.corbina.net ([85.21.88.2]:11751 "HELO
	mail.dev.rtsoft.ru") by vger.kernel.org with SMTP id S964982AbWE0WGx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 May 2006 18:06:53 -0400
Message-ID: <4478CD3D.6010409@ru.mvista.com>
Date: Sun, 28 May 2006 02:05:49 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] HPT3xx: switch to using pci_find_slot()
References: <444B3BDE.1030106@ru.mvista.com> <4457DC97.3010807@ru.mvista.com> <445A5A1B.60903@ru.mvista.com> <446A55D6.90507@ru.mvista.com> <446ED8A3.6030702@ru.mvista.com>
In-Reply-To: <446ED8A3.6030702@ru.mvista.com>
Content-Type: multipart/mixed;
 boundary="------------050207070602000204000104"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050207070602000204000104
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

    Switch to using pci_find_slot() to get to the function 1 of HPT36x/374
chips -- there's no need for the driver itself to walk the list of the PCI 
devices, and it also forgets to check the bus number of the device found.

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>


--------------050207070602000204000104
Content-Type: text/plain;
 name="HPT3xx-use-pci_find_slot.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="HPT3xx-use-pci_find_slot.patch"

Index: linus/drivers/ide/pci/hpt366.c
===================================================================
--- linus.orig/drivers/ide/pci/hpt366.c
+++ linus/drivers/ide/pci/hpt366.c
@@ -1,5 +1,5 @@
 /*
- * linux/drivers/ide/pci/hpt366.c		Version 0.44	May 20, 2006
+ * linux/drivers/ide/pci/hpt366.c		Version 0.45	May 21, 2006
  *
  * Copyright (C) 1999-2003		Andre Hedrick <andre@linux-ide.org>
  * Portions Copyright (C) 2001	        Sun Microsystems, Inc.
@@ -79,6 +79,7 @@
  * - prefix the driver startup messages with the real chip name
  * - claim the extra 240 bytes of I/O space for all chips
  * - optimize the rate masking/filtering and the drive list lookup code
+ * - use pci_find_slot() to get to the function 1 of HPT36x/374
  *		<source@mvista.com>
  *
  */
@@ -1412,24 +1413,20 @@ static void __devinit init_iops_hpt366(i
 
 static int __devinit init_setup_hpt374(struct pci_dev *dev, ide_pci_device_t *d)
 {
-	struct pci_dev *findev = NULL;
+	struct pci_dev *dev2;
 
 	if (PCI_FUNC(dev->devfn) & 1)
 		return -ENODEV;
 
-	while ((findev = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, findev)) != NULL) {
-		if ((findev->vendor == dev->vendor) &&
-		    (findev->device == dev->device) &&
-		    ((findev->devfn - dev->devfn) == 1) &&
-		    (PCI_FUNC(findev->devfn) & 1)) {
-			if (findev->irq != dev->irq) {
-				/* FIXME: we need a core pci_set_interrupt() */
-				findev->irq = dev->irq;
-				printk(KERN_WARNING "%s: pci-config space interrupt "
-					"fixed.\n", d->name);
-			}
-			return ide_setup_pci_devices(dev, findev, d);
+	dev2 = pci_find_slot(dev->bus->number, dev->devfn + 1);
+	if (dev2 != NULL) {
+		if (dev2->irq != dev->irq) {
+			/* FIXME: we need a core pci_set_interrupt() */
+			dev2->irq = dev->irq;
+			printk(KERN_WARNING "%s: pci-config space interrupt "
+			       "fixed.\n", d->name);
 		}
+		return ide_setup_pci_devices(dev, dev2, d);
 	}
 	return ide_setup_pci_device(dev, d);
 }
@@ -1487,8 +1484,8 @@ static int __devinit init_setup_hpt302(s
 
 static int __devinit init_setup_hpt366(struct pci_dev *dev, ide_pci_device_t *d)
 {
-	struct pci_dev *findev = NULL;
-	u8 rev = 0, pin1 = 0, pin2 = 0;
+	struct pci_dev *dev2;
+	u8 rev = 0;
 	static char   *chipset_names[] = { "HPT366", "HPT366",  "HPT368",
 					   "HPT370", "HPT370A", "HPT372",
 					   "HPT372N" };
@@ -1508,21 +1505,18 @@ static int __devinit init_setup_hpt366(s
 
 	d->channels = 1;
 
-	pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &pin1);
-	while ((findev = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, findev)) != NULL) {
-		if ((findev->vendor == dev->vendor) &&
-		    (findev->device == dev->device) &&
-		    ((findev->devfn - dev->devfn) == 1) &&
-		    (PCI_FUNC(findev->devfn) & 1)) {
-			pci_read_config_byte(findev, PCI_INTERRUPT_PIN, &pin2);
-			if ((pin1 != pin2) && (dev->irq == findev->irq)) {
-				d->bootable = ON_BOARD;
-				printk("%s: onboard version of chipset, "
-					"pin1=%d pin2=%d\n", d->name,
-					pin1, pin2);
-			}
-			return ide_setup_pci_devices(dev, findev, d);
+	dev2 = pci_find_slot(dev->bus->number, dev->devfn + 1);
+	if (dev2 != NULL) {
+	  	u8 pin1 = 0, pin2 = 0;
+
+		pci_read_config_byte(dev,  PCI_INTERRUPT_PIN, &pin1);
+		pci_read_config_byte(dev2, PCI_INTERRUPT_PIN, &pin2);
+		if (pin1 != pin2 && dev->irq == dev2->irq) {
+			d->bootable = ON_BOARD;
+			printk("%s: onboard version of chipset, pin1=%d pin2=%d\n",
+			       d->name, pin1, pin2);
 		}
+		return ide_setup_pci_devices(dev, dev2, d);
 	}
 init_single:
 	return ide_setup_pci_device(dev, d);



--------------050207070602000204000104--
