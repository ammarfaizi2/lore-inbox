Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751546AbWIYWY7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751546AbWIYWY7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 18:24:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751544AbWIYWY7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 18:24:59 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:29385 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751548AbWIYWY6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 18:24:58 -0400
Subject: [PATCH] trident oss: Switch to newer API also fix a bug
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 25 Sep 2006 23:49:43 +0100
Message-Id: <1159224583.11049.173.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The old driver erroneously passed pdev not NULL to a second search. This
happened to always work except with pci=reverse because of chip
ordering.

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-mm1/sound/oss/trident.c linux-2.6.18-mm1/sound/oss/trident.c
--- linux.vanilla-2.6.18-mm1/sound/oss/trident.c	2006-09-25 12:10:29.000000000 +0100
+++ linux-2.6.18-mm1/sound/oss/trident.c	2006-09-25 12:29:39.000000000 +0100
@@ -3269,7 +3269,7 @@
 	char temp;
 	struct pci_dev *pci_dev = NULL;
 
-	pci_dev = pci_find_device(PCI_VENDOR_ID_AL, PCI_DEVICE_ID_AL_M1533, 
+	pci_dev = pci_get_device(PCI_VENDOR_ID_AL, PCI_DEVICE_ID_AL_M1533, 
 				  pci_dev);
 	if (pci_dev == NULL)
 		return;
@@ -3283,6 +3283,8 @@
 	temp &= (~0x20);
 	temp |= 0x10;
 	pci_write_config_byte(pci_dev, 0x7e, temp);
+	
+	pci_dev_put(pci_dev);
 
 	ch = inb(TRID_REG(card, ALI_SCTRL));
 	outb(ch | ALI_SPDIF_OUT_ENABLE, TRID_REG(card, ALI_SCTRL));
@@ -3490,22 +3492,25 @@
 	char temp = 0;
 	struct pci_dev *pci_dev = NULL;
 
-	pci_dev = pci_find_device(PCI_VENDOR_ID_AL, PCI_DEVICE_ID_AL_M1533, 
+	pci_dev = pci_get_device(PCI_VENDOR_ID_AL, PCI_DEVICE_ID_AL_M1533, 
 				  pci_dev);
 	if (pci_dev == NULL)
 		return -1;
+		
 	pci_read_config_byte(pci_dev, 0x59, &temp);
 	temp &= ~0x80;
 	pci_write_config_byte(pci_dev, 0x59, temp);
-
-	pci_dev = pci_find_device(PCI_VENDOR_ID_AL, PCI_DEVICE_ID_AL_M7101, 
-				  pci_dev);
+	
+	pci_dev = pci_get_device(PCI_VENDOR_ID_AL, PCI_DEVICE_ID_AL_M7101, 
+				  NULL);
 	if (pci_dev == NULL)
 		return -1;
 
 	pci_read_config_byte(pci_dev, 0xB8, &temp);
 	temp &= ~0x20;
 	pci_write_config_byte(pci_dev, 0xB8, temp);
+	
+	pci_dev_put(pci_dev);
 
 	return 0;
 }
@@ -3517,7 +3522,7 @@
 	char temp = 0;
 	struct pci_dev *pci_dev = NULL;
 
-	pci_dev = pci_find_device(PCI_VENDOR_ID_AL, PCI_DEVICE_ID_AL_M1533, 
+	pci_dev = pci_get_device(PCI_VENDOR_ID_AL, PCI_DEVICE_ID_AL_M1533, 
 				  pci_dev);
 	if (pci_dev == NULL)
 		return -1;
@@ -3525,13 +3530,16 @@
 	temp |= 0x80;
 	pci_write_config_byte(pci_dev, 0x59, temp);
 
-	pci_dev = pci_find_device(PCI_VENDOR_ID_AL, PCI_DEVICE_ID_AL_M7101, 
-				  pci_dev);
+	pci_dev = pci_get_device(PCI_VENDOR_ID_AL, PCI_DEVICE_ID_AL_M7101, 
+				  NULL);
 	if (pci_dev == NULL)
 		return -1;
 	pci_read_config_byte(pci_dev, (int) 0xB8, &temp);
 	temp |= 0x20;
 	pci_write_config_byte(pci_dev, (int) 0xB8, (u8) temp);
+	
+	pci_dev_put(pci_dev);
+	
 	if (chan_nums == 6) {
 		dwValue = inl(TRID_REG(card, ALI_SCTRL)) | 0x000f0000;
 		outl(dwValue, TRID_REG(card, ALI_SCTRL));
@@ -4103,7 +4111,7 @@
 	unsigned int dwVal;
 	unsigned short wCount, wReg;
 
-	pci_dev = pci_find_device(PCI_VENDOR_ID_AL, PCI_DEVICE_ID_AL_M1533, 
+	pci_dev = pci_get_device(PCI_VENDOR_ID_AL, PCI_DEVICE_ID_AL_M1533, 
 				  pci_dev);
 	if (pci_dev == NULL)
 		return -1;
@@ -4114,6 +4122,9 @@
 	pci_read_config_dword(pci_dev, 0x7c, &dwVal);
 	pci_write_config_dword(pci_dev, 0x7c, dwVal & 0xf7ffffff);
 	udelay(5000);
+	
+	pci_dev_put(pdev);
+	
 
 	pci_dev = card->pci_dev;
 	if (pci_dev == NULL)
@@ -4393,7 +4404,7 @@
 
 	init_timer(&card->timer);
 	card->iobase = iobase;
-	card->pci_dev = pci_dev;
+	card->pci_dev = pci_dev_get(pci_dev);
 	card->pci_id = pci_id->device;
 	card->revision = revision;
 	card->irq = pci_dev->irq;
@@ -4597,9 +4608,9 @@
 		}
 	unregister_sound_dsp(card->dev_audio);
 
-	kfree(card);
-
 	pci_set_drvdata(pci_dev, NULL);
+	pci_dev_put(card->pci_dev);
+	kfree(card);
 }
 
 MODULE_AUTHOR("Alan Cox, Aaron Holtzman, Ollie Lho, Ching Ling Lee, Muli Ben-Yehuda");

