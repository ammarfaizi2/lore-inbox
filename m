Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263210AbVCKGtx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263210AbVCKGtx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 01:49:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263207AbVCKGtx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 01:49:53 -0500
Received: from gate.crashing.org ([63.228.1.57]:41178 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S263210AbVCKGto (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 01:49:44 -0500
Subject: [PATCH] ppc64: Fix some PCI interrupt routing issues on iMac G5
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Fri, 11 Mar 2005 17:49:32 +1100
Message-Id: <1110523772.5752.57.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

The iMac G5 has some issues with Apple chips not having a valid
PCI_INTERRUPT_PIN. This patch fixes IRQ routing on PowerMac
platforms so that it only relies on the Open Firmware informations
which are correct.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: J. Mayer <l_indien@magic.fr>

Index: linux-work/arch/ppc64/kernel/pmac_pci.c
===================================================================
--- linux-work.orig/arch/ppc64/kernel/pmac_pci.c	2005-01-31 14:18:14.000000000 +1100
+++ linux-work/arch/ppc64/kernel/pmac_pci.c	2005-03-10 14:57:03.000000000 +1100
@@ -656,13 +656,32 @@
 	return 0;
 }
 
+/*
+ * We use our own read_irq_line here because PCI_INTERRUPT_PIN is
+ * crap on some of Apple ASICs. We unconditionally use the Open Firmware
+ * interrupt number as this is always right.
+ */
+static int pmac_pci_read_irq_line(struct pci_dev *pci_dev)
+{
+	struct device_node *node;
+
+	node = pci_device_to_OF_node(pci_dev);
+	if (node == NULL)
+		return -1;	
+	if (node->n_intrs == 0)
+		return -1;	
+	pci_dev->irq = node->intrs[0].line;
+	pci_write_config_byte(pci_dev, PCI_INTERRUPT_LINE, pci_dev->irq);
+
+	return 0;
+}
 
 void __init pmac_pcibios_fixup(void)
 {
 	struct pci_dev *dev = NULL;
 
 	for_each_pci_dev(dev)
-		pci_read_irq_line(dev);
+		pmac_pci_read_irq_line(dev);
 }
 
 static void __init pmac_fixup_phb_resources(void)
@@ -771,3 +790,4 @@
 	}
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SERVERWORKS, 0x0240, fixup_k2_sata);
+


