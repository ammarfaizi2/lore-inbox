Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261263AbULMQFx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261263AbULMQFx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 11:05:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261258AbULMQE4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 11:04:56 -0500
Received: from atlrel7.hp.com ([156.153.255.213]:25735 "EHLO atlrel7.hp.com")
	by vger.kernel.org with ESMTP id S261270AbULMQDX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 11:03:23 -0500
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] hisax: don't look at pci_dev->irq before calling pci_enable_device()
Date: Mon, 13 Dec 2004 09:03:01 -0700
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org, kkeil@suse.de, kai.germaschewski@gmx.de,
       isdn4linux@listserv.isdn4linux.de
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_20bvBFUWUtI5bl/"
Message-Id: <200412130903.02119.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_20bvBFUWUtI5bl/
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

The hisax driver looks at dev_avm->irq before calling pci_enable_device(),
which means it requests the wrong IRQ.  This patch fixes it.

Thanks to Thorsten Doil for reporting the problem and testing the fix.

--Boundary-00=_20bvBFUWUtI5bl/
Content-Type: text/x-diff;
  charset="us-ascii";
  name="hisax-irq.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="hisax-irq.patch"

The hisax driver looks at dev_avm->irq before calling pci_enable_device(),
which means it requests the wrong IRQ.  This patch fixes it.

Thanks to Thorsten Doil for reporting the problem and testing the fix.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

===== drivers/isdn/hisax/avm_pci.c 1.48 vs edited =====
--- 1.48/drivers/isdn/hisax/avm_pci.c	2004-08-24 03:08:30 -06:00
+++ edited/drivers/isdn/hisax/avm_pci.c	2004-12-09 13:26:25 -07:00
@@ -794,13 +794,13 @@
 #ifdef CONFIG_PCI
 	if ((dev_avm = pci_find_device(PCI_VENDOR_ID_AVM,
 		PCI_DEVICE_ID_AVM_A1,  dev_avm))) {
+		if (pci_enable_device(dev_avm))
+			return(0);
 		cs->irq = dev_avm->irq;
 		if (!cs->irq) {
 			printk(KERN_ERR "FritzPCI: No IRQ for PCI card found\n");
 			return(0);
 		}
-		if (pci_enable_device(dev_avm))
-			return(0);
 		cs->hw.avm.cfg_reg = pci_resource_start(dev_avm, 1);
 		if (!cs->hw.avm.cfg_reg) {
 			printk(KERN_ERR "FritzPCI: No IO-Adr for PCI card found\n");

--Boundary-00=_20bvBFUWUtI5bl/--
