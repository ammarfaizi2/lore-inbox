Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269459AbUHZThz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269459AbUHZThz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 15:37:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269435AbUHZTfM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 15:35:12 -0400
Received: from atlrel6.hp.com ([156.153.255.205]:10650 "EHLO atlrel6.hp.com")
	by vger.kernel.org with ESMTP id S269336AbUHZT3t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 15:29:49 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] propagate pci_enable_device() errors
Date: Thu, 26 Aug 2004 13:29:16 -0600
User-Agent: KMail/1.6.2
Cc: Jeff Garzik <jgarzik@pobox.com>, ecd@atecom.com, chas@cmf.nrl.navy.mil,
       linux-atm-general@lists.sourceforge.net, kkeil@suse.de,
       kai.germaschewski@gmx.de, isdn4linux@listserv.isdn4linux.de,
       stelian.pop@fr.alcove.com, support@auvertech.fr, amax@us.ibm.com,
       davies@maniac.ultranet.com, tulip-users@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200408261329.16825.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik pointed out that I should have propagated the error returned
from pci_enable_device() rather than making up -ENODEV.


Propagate pci_enable_device() error returns rather than using -ENODEV.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

===== drivers/atm/idt77252.c 1.25 vs edited =====
--- 1.25/drivers/atm/idt77252.c	2004-08-24 03:08:33 -06:00
+++ edited/drivers/atm/idt77252.c	2004-08-26 13:08:03 -06:00
@@ -3684,9 +3684,9 @@
 	int i, err;
 
 
-	if (pci_enable_device(pcidev)) {
+	if ((err = pci_enable_device(pcidev))) {
 		printk("idt77252: can't enable PCI device at %s\n", pci_name(pcidev));
-		return -ENODEV;
+		return err;
 	}
 
 	if (pci_read_config_word(pcidev, PCI_REVISION_ID, &revision)) {
===== drivers/isdn/tpam/tpam_main.c 1.12 vs edited =====
--- 1.12/drivers/isdn/tpam/tpam_main.c	2004-08-24 03:08:33 -06:00
+++ edited/drivers/isdn/tpam/tpam_main.c	2004-08-26 13:09:52 -06:00
@@ -88,10 +88,10 @@
 	tpam_card *card, *c;
 	int i, err;
 
-	if (pci_enable_device(dev)) {
+	if ((err = pci_enable_device(dev))) {
 		printk(KERN_ERR "TurboPAM: can't enable PCI device at %s\n",
 			pci_name(dev));
-		return -ENODEV;
+		return err;
 	}
 
 	/* allocate memory for the board structure */
===== drivers/misc/ibmasm/module.c 1.3 vs edited =====
--- 1.3/drivers/misc/ibmasm/module.c	2004-08-24 03:08:34 -06:00
+++ edited/drivers/misc/ibmasm/module.c	2004-08-26 13:11:17 -06:00
@@ -59,13 +59,13 @@
 
 static int __init ibmasm_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
 {
-	int result = -ENOMEM;
+	int err, result = -ENOMEM;
 	struct service_processor *sp;
 
-	if (pci_enable_device(pdev)) {
+	if ((err = pci_enable_device(pdev))) {
 		printk(KERN_ERR "%s: can't enable PCI device at %s\n",
 			DRIVER_NAME, pci_name(pdev));
-		return -ENODEV;
+		return err;
 	}
 
 	sp = kmalloc(sizeof(struct service_processor), GFP_KERNEL);
===== drivers/net/tulip/de4x5.c 1.40 vs edited =====
--- 1.40/drivers/net/tulip/de4x5.c	2004-08-25 11:34:58 -06:00
+++ edited/drivers/net/tulip/de4x5.c	2004-08-26 13:13:04 -06:00
@@ -2242,8 +2242,8 @@
 		return -ENODEV;
 
 	/* Ok, the device seems to be for us. */
-	if (pci_enable_device (pdev))
-		return -ENODEV;
+	if ((error = pci_enable_device (pdev)))
+		return error;
 
 	if (!(dev = alloc_etherdev (sizeof (struct de4x5_private)))) {
 		error = -ENOMEM;
