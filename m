Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750821AbWGCAum@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750821AbWGCAum (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jul 2006 20:50:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750808AbWGCAuZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jul 2006 20:50:25 -0400
Received: from h-66-166-126-70.lsanca54.covad.net ([66.166.126.70]:21212 "EHLO
	myri.com") by vger.kernel.org with ESMTP id S1750772AbWGCAuU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jul 2006 20:50:20 -0400
Message-Id: <20060703004056.199189000@myri.com>
References: <20060703003959.942374000@myri.com>
User-Agent: quilt/0.45-1
Date: Sun, 02 Jul 2006 20:40:04 -0400
From: Brice Goglin <brice@myri.com>
To: linux-pci@atrey.karlin.mff.cuni.cz
Cc: linux-kernel@vger.kernel.org
Subject: [patch 5/7] Blacklist PCI-E chipsets depending on Hypertransport MSI capability
Content-Disposition: inline; filename=05-check_hypertransport_msi_capabilities.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce msi_ht_cap_enabled() to check the MSI capability in the
Hypertransport configuration space.
It is used in a generic quirk quirk_msi_ht_cap() to check whether
MSI is enabled on hypertransport chipset, and a nVidia specific quirk
quirk_nvidia_ck804_msi_ht_cap() where two 2 HT MSI mappings have to
be checked.
Both quirks set the no_msi flag when MSI is disabled.

Signed-off-by: Brice Goglin <brice@myri.com>
---
In case of broken hardware, there's now a TTL to protect the
pci_find_next_capability() loop when looking for the HT MSI cap.

 drivers/pci/quirks.c    |   55 ++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/pci_ids.h |    1 
 2 files changed, 56 insertions(+)

Index: linux-git/drivers/pci/quirks.c
===================================================================
--- linux-git.orig/drivers/pci/quirks.c	2006-07-02 11:53:09.000000000 -0400
+++ linux-git/drivers/pci/quirks.c	2006-07-02 12:28:49.000000000 -0400
@@ -1516,6 +1516,61 @@
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_8131_BRIDGE, quirk_disable_msi);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_SERVERWORKS, PCI_DEVICE_ID_SERVERWORKS_GCNB_LE,
 			quirk_disable_msi);
+
+/* Go through the list of Hypertransport capabilities and
+ * return 1 if a HT MSI capability is found and enabled */
+static int __devinit msi_ht_cap_enabled(struct pci_dev *dev)
+{
+	u8 pos;
+	int ttl;
+	for (pos = pci_find_capability(dev, PCI_CAP_ID_HT), ttl = 48;
+	     pos && ttl;
+	     pos = pci_find_next_capability(dev, pos, PCI_CAP_ID_HT), ttl--) {
+		u32 cap_hdr;
+		/* MSI mapping section according to Hypertransport spec */
+		if (pci_read_config_dword(dev, pos, &cap_hdr) == 0
+		    && (cap_hdr & 0xf8000000) == 0xa8000000 /* MSI mapping */) {
+			printk(KERN_INFO "PCI: Found HT MSI mapping on %s with capability %s\n",
+			       pci_name(dev), cap_hdr & 0x10000 ? "enabled" : "disabled");
+			return (cap_hdr & 0x10000) != 0; /* MSI mapping cap enabled */
+		}
+	}
+	return 0;
+}
+
+/* Check the hypertransport MSI mapping to know whether MSI is enabled or not */
+static void __devinit quirk_msi_ht_cap(struct pci_dev *dev)
+{
+	if (!msi_ht_cap_enabled(dev)) {
+		printk(KERN_WARNING "PCI: MSI quirk detected. "
+		       "MSI disabled on chipset %s.\n",
+		       pci_name(dev));
+		dev->no_msi = 1;
+	}
+}
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_SERVERWORKS, PCI_DEVICE_ID_SERVERWORKS_HT2000_PCIE,
+			quirk_msi_ht_cap);
+
+/* The nVidia CK804 chipset may have 2 HT MSI mappings.
+ * MSI are supported if the MSI capability set in any of these mappings.
+ */
+static void __devinit quirk_nvidia_ck804_msi_ht_cap(struct pci_dev *dev)
+{
+	struct pci_dev *pdev;
+
+	/* check HT MSI cap on this chipset and the root one.
+	 * a single one having MSI is enough to be sure that MSI are supported.
+	 */
+	pdev = pci_find_slot(dev->bus->number, 0);
+	if (!msi_ht_cap_enabled(dev) && !msi_ht_cap_enabled(pdev)) {
+		printk(KERN_WARNING "PCI: MSI quirk detected. "
+		       "MSI disabled on chipset %s.\n",
+		       pci_name(dev));
+		dev->no_msi = 1;
+	}
+}
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_CK804_PCIE,
+			quirk_nvidia_ck804_msi_ht_cap);
 #endif /* CONFIG_PCI_MSI */
 
 EXPORT_SYMBOL(pcie_mch_quirk);
Index: linux-git/include/linux/pci_ids.h
===================================================================
--- linux-git.orig/include/linux/pci_ids.h	2006-07-02 11:52:37.000000000 -0400
+++ linux-git/include/linux/pci_ids.h	2006-07-02 11:54:01.000000000 -0400
@@ -1407,6 +1407,7 @@
 #define PCI_DEVICE_ID_SERVERWORKS_LE	  0x0009
 #define PCI_DEVICE_ID_SERVERWORKS_GCNB_LE 0x0017
 #define PCI_DEVICE_ID_SERVERWORKS_EPB	  0x0103
+#define PCI_DEVICE_ID_SERVERWORKS_HT2000_PCIE	0x0132
 #define PCI_DEVICE_ID_SERVERWORKS_OSB4	  0x0200
 #define PCI_DEVICE_ID_SERVERWORKS_CSB5	  0x0201
 #define PCI_DEVICE_ID_SERVERWORKS_CSB6    0x0203

