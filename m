Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262110AbTJXJ5a (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Oct 2003 05:57:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262126AbTJXJ5a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Oct 2003 05:57:30 -0400
Received: from mailout07.sul.t-online.com ([194.25.134.83]:20110 "EHLO
	mailout07.sul.t-online.com") by vger.kernel.org with ESMTP
	id S262110AbTJXJ52 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Oct 2003 05:57:28 -0400
Date: Fri, 24 Oct 2003 11:56:13 +0200
From: malware@t-online.de (Malware)
Message-Id: <200310240956.h9O9uDK27733@winbloz.malware.de>
To: mj@ucw.cz
Subject: [2.4] PCI chipset Opti Viper M/N+
Cc: linux-kernel@vger.kernel.org
X-Seen: false
X-ID: rITdocZFoePLPUfzHkBktK33MaHhXr46T-o3+GKWxv+qT1pF8t-DZk
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin and linux-kernel readers,

I had problems using CardBus cards in my laptop, they simply got no IRQ assigned. The kernel currently used is 2.4.22.

BIOS settings and telling the kernel to use the PCI BIOS provided no solution. The BIOS settings available are minimal and the PCI BIOS is buggy causing crashes when called from the kernel.

So finally I added support for the specific PCI chipset, Opti Viper M/N+, to the kernel PCI code. See the patch below which is relative to the 2.4.22 kernel. Now the CardBus cards get an interrupt assigned as excepted. It worked fine with a Xircom modem/ethernet card which I got access to for a short testing.


Michael


--- kernel-source-2.4.22-1/arch/i386/kernel/pci-irq.c.orig	2003-10-21 22:52:50.000000000 +0200
+++ kernel-source-2.4.22-1/arch/i386/kernel/pci-irq.c	2003-10-24 11:18:31.000000000 +0200
@@ -243,6 +243,44 @@
 }
 
 /*
+ * OPTI Viper-M/N+: Bit field with 3 bits per entry.
+ * Due to the lack of a specification the information about this chipset
+ * was taken from the NetBSD source code.
+ */
+static int pirq_viper_get(struct pci_dev *router, struct pci_dev *dev, int pirq)
+{
+	static const int viper_irq_decode[] = { 0, 5, 9, 10, 11, 12, 14, 15 };
+	u32 irq;
+
+	pci_read_config_dword(router, 0x40, &irq);
+	irq >>= (pirq-1)*3;
+	irq &= 7;
+
+	return viper_irq_decode[irq];
+}
+
+static int pirq_viper_set(struct pci_dev *router, struct pci_dev *dev, int pirq, int irq)
+{
+	static const int viper_irq_map[] = { -1, -1, -1, -1, -1, 1, -1, -1, -1, 2, 3, 4, 5, -1, 6, 7 };
+	int newval = viper_irq_map[irq];
+	u32 val;
+	u32 mask = 7 << (3*(pirq-1));
+#if 0
+	mask |= 0x10000UL << (pirq-1);	/* edge triggered */
+#endif
+
+	if ( newval == -1 )
+		return 0;
+	
+	pci_read_config_dword(router, 0x40, &val);
+	val &= ~mask;
+	val |= newval << (3*(pirq*1));
+	pci_write_config_dword(router, 0x40, val);
+
+	return 1;
+}
+
+/*
  * Cyrix: nibble offset 0x5C
  */
 static int pirq_cyrix_get(struct pci_dev *router, struct pci_dev *dev, int pirq)
@@ -485,6 +523,7 @@
 	{ "VIA", PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C686, pirq_via_get, pirq_via_set },
 
 	{ "OPTI", PCI_VENDOR_ID_OPTI, PCI_DEVICE_ID_OPTI_82C700, pirq_opti_get, pirq_opti_set },
+	{ "OPTI VIPER", PCI_VENDOR_ID_OPTI, PCI_DEVICE_ID_OPTI_82C558, pirq_viper_get, pirq_viper_set },
 
 	{ "NatSemi", PCI_VENDOR_ID_CYRIX, PCI_DEVICE_ID_CYRIX_5520, pirq_cyrix_get, pirq_cyrix_set },
 	{ "SIS", PCI_VENDOR_ID_SI, PCI_DEVICE_ID_SI_503, pirq_sis_get, pirq_sis_set },
