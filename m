Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964864AbWIZWBj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964864AbWIZWBj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 18:01:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932435AbWIZWBj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 18:01:39 -0400
Received: from mtagate1.uk.ibm.com ([195.212.29.134]:12772 "EHLO
	mtagate1.uk.ibm.com") by vger.kernel.org with ESMTP id S932290AbWIZWBi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 18:01:38 -0400
Date: Wed, 27 Sep 2006 01:01:35 +0300
From: Muli Ben-Yehuda <muli@il.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: [PATCH TRIDENT] fix pci_dev reference counting and buglet
Message-ID: <20060926220135.GF7129@rhun.haifa.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Switch trident to use pci_get/put_dev properly. Also fix a bug where
the driver erroneously passed pdev not NULL to a second search. This
happened to always work except with pci=reverse because of chip
ordering.

Signed-off-by: Alan Cox <alan@redhat.com>
Signed-off-by: Muli Ben-Yehuda <muli@il.ibm.com>

diff -r 7e955ce92497 sound/oss/trident.c
--- a/sound/oss/trident.c	Wed Sep 27 01:49:46 2006 +0700
+++ b/sound/oss/trident.c	Wed Sep 27 00:58:36 2006 +0300
@@ -3280,8 +3280,8 @@ ali_setup_spdif_out(struct trident_card 
 	char temp;
 	struct pci_dev *pci_dev = NULL;
 
-	pci_dev = pci_find_device(PCI_VENDOR_ID_AL, PCI_DEVICE_ID_AL_M1533, 
-				  pci_dev);
+	pci_dev = pci_get_device(PCI_VENDOR_ID_AL, PCI_DEVICE_ID_AL_M1533,
+				 pci_dev);
 	if (pci_dev == NULL)
 		return;
 	pci_read_config_byte(pci_dev, 0x61, &temp);
@@ -3294,6 +3294,8 @@ ali_setup_spdif_out(struct trident_card 
 	temp &= (~0x20);
 	temp |= 0x10;
 	pci_write_config_byte(pci_dev, 0x7e, temp);
+
+	pci_dev_put(pci_dev);
 
 	ch = inb(TRID_REG(card, ALI_SCTRL));
 	outb(ch | ALI_SPDIF_OUT_ENABLE, TRID_REG(card, ALI_SCTRL));
@@ -3501,16 +3503,19 @@ ali_close_multi_channels(void)
 	char temp = 0;
 	struct pci_dev *pci_dev = NULL;
 
-	pci_dev = pci_find_device(PCI_VENDOR_ID_AL, PCI_DEVICE_ID_AL_M1533, 
-				  pci_dev);
+	pci_dev = pci_get_device(PCI_VENDOR_ID_AL, PCI_DEVICE_ID_AL_M1533,
+				 pci_dev);
 	if (pci_dev == NULL)
 		return -1;
+
 	pci_read_config_byte(pci_dev, 0x59, &temp);
 	temp &= ~0x80;
 	pci_write_config_byte(pci_dev, 0x59, temp);
 
-	pci_dev = pci_find_device(PCI_VENDOR_ID_AL, PCI_DEVICE_ID_AL_M7101, 
-				  pci_dev);
+	pci_dev_put(pci_dev);
+
+	pci_dev = pci_get_device(PCI_VENDOR_ID_AL, PCI_DEVICE_ID_AL_M7101,
+				 NULL);
 	if (pci_dev == NULL)
 		return -1;
 
@@ -3518,6 +3523,8 @@ ali_close_multi_channels(void)
 	temp &= ~0x20;
 	pci_write_config_byte(pci_dev, 0xB8, temp);
 
+	pci_dev_put(pci_dev);
+
 	return 0;
 }
 
@@ -3528,21 +3535,26 @@ ali_setup_multi_channels(struct trident_
 	char temp = 0;
 	struct pci_dev *pci_dev = NULL;
 
-	pci_dev = pci_find_device(PCI_VENDOR_ID_AL, PCI_DEVICE_ID_AL_M1533, 
-				  pci_dev);
+	pci_dev = pci_get_device(PCI_VENDOR_ID_AL, PCI_DEVICE_ID_AL_M1533,
+				 pci_dev);
 	if (pci_dev == NULL)
 		return -1;
 	pci_read_config_byte(pci_dev, 0x59, &temp);
 	temp |= 0x80;
 	pci_write_config_byte(pci_dev, 0x59, temp);
 
-	pci_dev = pci_find_device(PCI_VENDOR_ID_AL, PCI_DEVICE_ID_AL_M7101, 
-				  pci_dev);
+	pci_dev_put(pci_dev);
+
+	pci_dev = pci_get_device(PCI_VENDOR_ID_AL, PCI_DEVICE_ID_AL_M7101,
+				 NULL);
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
@@ -4105,8 +4117,8 @@ ali_reset_5451(struct trident_card *card
 	unsigned int dwVal;
 	unsigned short wCount, wReg;
 
-	pci_dev = pci_find_device(PCI_VENDOR_ID_AL, PCI_DEVICE_ID_AL_M1533, 
-				  pci_dev);
+	pci_dev = pci_get_device(PCI_VENDOR_ID_AL, PCI_DEVICE_ID_AL_M1533,
+				 pci_dev);
 	if (pci_dev == NULL)
 		return -1;
 
@@ -4116,6 +4128,7 @@ ali_reset_5451(struct trident_card *card
 	pci_read_config_dword(pci_dev, 0x7c, &dwVal);
 	pci_write_config_dword(pci_dev, 0x7c, dwVal & 0xf7ffffff);
 	udelay(5000);
+	pci_dev_put(pci_dev);
 
 	pci_dev = card->pci_dev;
 	if (pci_dev == NULL)
@@ -4395,7 +4408,7 @@ trident_probe(struct pci_dev *pci_dev, c
 
 	init_timer(&card->timer);
 	card->iobase = iobase;
-	card->pci_dev = pci_dev;
+	card->pci_dev = pci_dev_get(pci_dev);
 	card->pci_id = pci_id->device;
 	card->revision = revision;
 	card->irq = pci_dev->irq;
@@ -4549,6 +4562,7 @@ out_free_irq:
 out_free_irq:
 	free_irq(card->irq, card);
 out_proc_fs:
+	pci_dev_put(card->pci_dev);
 	if (res) {
 		remove_proc_entry("ALi5451", NULL);
 		res = NULL;
@@ -4599,9 +4613,9 @@ trident_remove(struct pci_dev *pci_dev)
 		}
 	unregister_sound_dsp(card->dev_audio);
 
+	pci_set_drvdata(pci_dev, NULL);
+	pci_dev_put(card->pci_dev);
 	kfree(card);
-
-	pci_set_drvdata(pci_dev, NULL);
 }
 
 MODULE_AUTHOR("Alan Cox, Aaron Holtzman, Ollie Lho, Ching Ling Lee, Muli Ben-Yehuda");
