Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268308AbUHQPXu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268308AbUHQPXu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 11:23:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268299AbUHQPWe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 11:22:34 -0400
Received: from fep01fe.ttnet.net.tr ([212.156.4.130]:12253 "EHLO
	fep01.ttnet.net.tr") by vger.kernel.org with ESMTP id S268272AbUHQPPd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 11:15:33 -0400
Message-ID: <412220E1.7070702@ttnet.net.tr>
Date: Tue, 17 Aug 2004 18:14:41 +0300
From: "O.Sezer" <sezeroz@ttnet.net.tr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: tr, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: marcelo.tosatti@cyclades.com
Subject: [PATCH] [2.4.28-pre1] more gcc3.4 inline fixes [4/10]
Content-Type: multipart/mixed;
	boundary="------------010203040209080309010501"
X-ESAFE-STATUS: Mail clean
X-ESAFE-DETAILS: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010203040209080309010501
Content-Type: text/plain;
	charset=ISO-8859-9;
	format=flowed
Content-Transfer-Encoding: 7bit


--------------010203040209080309010501
Content-Type: text/plain;
	name="gcc34_inline_04.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="gcc34_inline_04.diff"

--- 28p1/drivers/media/radio/radio-maestro.c~	2001-09-30 22:26:06.000000000 +0300
+++ 28p1/drivers/media/radio/radio-maestro.c	2004-08-16 22:13:07.000000000 +0300
@@ -307,30 +307,6 @@
 	video_unregister_device(&maestro_radio);
 }
 
-int __init maestro_radio_init(void)
-{
-	register __u16 found=0;
-	struct pci_dev *pcidev = NULL;
-	if(!pci_present())
-		return -ENODEV;
-	while(!found && (pcidev = pci_find_device(PCI_VENDOR_ESS, 
-						  PCI_DEVICE_ID_ESS_ESS1968,
-						  pcidev)))
-		found |= radio_install(pcidev);
-	while(!found && (pcidev = pci_find_device(PCI_VENDOR_ESS,
-						  PCI_DEVICE_ID_ESS_ESS1978, 
-						  pcidev)))
-		found |= radio_install(pcidev);
-	if(!found) {
-		printk(KERN_INFO "radio-maestro: no devices found.\n");
-		return -ENODEV;
-	}
-	return 0;
-}
-
-module_init(maestro_radio_init);
-module_exit(maestro_radio_exit);
-
 inline static __u16 radio_power_on(struct radio_device *dev)
 {
 	register __u16 io=dev->io;
@@ -378,3 +354,27 @@
 		return 0;   
 }
 
+int __init maestro_radio_init(void)
+{
+	register __u16 found=0;
+	struct pci_dev *pcidev = NULL;
+	if(!pci_present())
+		return -ENODEV;
+	while(!found && (pcidev = pci_find_device(PCI_VENDOR_ESS, 
+						  PCI_DEVICE_ID_ESS_ESS1968,
+						  pcidev)))
+		found |= radio_install(pcidev);
+	while(!found && (pcidev = pci_find_device(PCI_VENDOR_ESS,
+						  PCI_DEVICE_ID_ESS_ESS1978, 
+						  pcidev)))
+		found |= radio_install(pcidev);
+	if(!found) {
+		printk(KERN_INFO "radio-maestro: no devices found.\n");
+		return -ENODEV;
+	}
+	return 0;
+}
+
+module_init(maestro_radio_init);
+module_exit(maestro_radio_exit);
+
--- 28p1/drivers/media/video/w9966.c~	2003-06-13 17:51:34.000000000 +0300
+++ 28p1/drivers/media/video/w9966.c	2004-08-16 22:18:28.000000000 +0300
@@ -691,6 +691,14 @@
 	udelay(W9966_I2C_UDELAY);
 }
 
+// Get peripheral clock line
+// Expects a claimed pdev.
+static inline int w9966_i2c_getscl(struct w9966_dev* cam)
+{
+	const u8 pins = w9966_rreg(cam, 0x18);
+	return ((pins & W9966_I2C_R_CLOCK) > 0);
+}
+
 // Sets the clock line on the i2c bus.
 // Expects a claimed pdev.
 // 1 on success, else 0
@@ -723,14 +731,6 @@
 	return ((pins & W9966_I2C_R_DATA) > 0);
 }
 
-// Get peripheral clock line
-// Expects a claimed pdev.
-static inline int w9966_i2c_getscl(struct w9966_dev* cam)
-{
-	const u8 pins = w9966_rreg(cam, 0x18);
-	return ((pins & W9966_I2C_R_CLOCK) > 0);
-}
-
 // Write a byte with ack to the i2c bus.
 // Expects a claimed pdev.
 // 1 on success, else 0

--------------010203040209080309010501--
