Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751930AbWFUCc2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751930AbWFUCc2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 22:32:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751929AbWFUCc2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 22:32:28 -0400
Received: from h-66-166-126-70.lsanca54.covad.net ([66.166.126.70]:5887 "EHLO
	myri.com") by vger.kernel.org with ESMTP id S1751930AbWFUCc1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 22:32:27 -0400
Date: Tue, 20 Jun 2006 22:32:24 -0400
From: Brice Goglin <brice@myri.com>
To: linux-pci@atrey.karlin.mff.cuni.cz
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] Blacklist PCI-E chipsets depending on Hypertransport MSI capabality
Message-ID: <20060621023224.GC16292@myri.com>
References: <20060621023104.GA16271@myri.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060621023104.GA16271@myri.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH 3/6] Blacklist PCI-E chipsets depending on Hypertransport MSI capabality

Introduce msi_ht_cap_enabled() to check the MSI capability in the
Hypertransport configuration space.
It is used in a generic quirk quirk_msi_ht_cap() to check whether
MSI is enabled on hypertransport chipset, and a nVidia specific quirk
quirk_nvidia_ck804_msi_ht_cap() where two 2 HT MSI mappings have to
be checked.
Both quirks set the PCI_BUS_FLAGS_NO_MSI flags when MSI is disabled.

Signed-off-by: Brice Goglin <brice@myri.com>
---
This patch will conflict with
pci/pci-nvidia-quirk-to-make-aer-pci-e-extended-capability-visible.patch
(currently in Greg K-H's patchset) since they both add
PCI_DEVICE_ID_NVIDIA_CK804_PCIE in pci_ids.h.
The first part of the changes in include/linux/pci_ids.h would have
to be dropped.

 drivers/pci/quirks.c    |   64 ++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/pci_ids.h |    2 +
 2 files changed, 66 insertions(+)

Index: linux-mm/drivers/pci/quirks.c
===================================================================
--- linux-mm.orig/drivers/pci/quirks.c	2006-06-20 22:03:27.000000000 -0400
+++ linux-mm/drivers/pci/quirks.c	2006-06-20 22:03:45.000000000 -0400
@@ -1557,6 +1557,70 @@
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_8131_BRIDGE, quirk_disable_msi);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_SERVERWORKS, PCI_DEVICE_ID_SERVERWORKS_GCNB_LE,
 			quirk_disable_msi);
+
+/* Returns 1 if the HT MSI capability is found and enabled */
+static pci_bus_flags_t __devinit msi_ht_cap_enabled(struct pci_dev *dev)
+{
+	u8 cap_off;
+	int nbcap = 0;
+	cap_off = PCI_CAPABILITY_LIST - 1;
+
+	/* go through all caps looking for a hypertransport msi mapping */
+	while (pci_read_config_byte(dev, cap_off + 1, &cap_off) == 0 &&
+		nbcap++ <= 256 / 4) {
+		u32 cap_hdr;
+		if (cap_off == 0 || cap_off == 0xff)
+			break;
+		cap_off &= 0xfc;
+		/* msi mapping section according to hypertransport spec */
+		if (pci_read_config_dword(dev, cap_off, &cap_hdr) == 0
+		    && (cap_hdr & 0xff) == PCI_CAP_ID_HT /* hypertransport cap */
+		    && (cap_hdr & 0xf8000000) == 0xa8000000 /* msi mapping */) {
+			printk(KERN_INFO "PCI: Found HT MSI mapping on %s with capability %s\n",
+			       pci_name(dev), cap_hdr & 0x10000 ? "enabled" : "disabled");
+			return (cap_hdr & 0x10000) != 0; /* msi mapping cap enabled */
+		}
+	}
+	return 0;
+}
+
+/* Check the hypertransport MSI mapping to know whether MSI is enabled or not */
+static void __devinit quirk_msi_ht_cap(struct pci_dev *dev)
+{
+	if (!dev->subordinate)
+		return;
+
+	if (!msi_ht_cap_enabled(dev)) {
+		printk(KERN_WARNING "PCI: MSI quirk detected. "
+		       "PCI_BUS_FLAGS_NO_MSI set for %s subordinate bus.\n",
+		       pci_name(dev));
+		dev->subordinate->bus_flags |= PCI_BUS_FLAGS_NO_MSI;
+	}
+}
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_SERVERWORKS, PCI_DEVICE_ID_SERVERWORKS_HT2000_PCIE, quirk_msi_ht_cap);
+
+/* The nVidia CK804 chipset may have 2 HT MSI mappings.
+ * MSI are supported if the MSI capability set in any of these mappings.
+ */
+static void __devinit quirk_nvidia_ck804_msi_ht_cap(struct pci_dev *dev)
+{
+	struct pci_dev *pdev;
+
+	if (!dev->subordinate)
+		return;
+
+	/* check HT MSI cap on this chipset and the root one.
+	 * a single one having MSI is enough to be sure that MSI are supported.
+	 */
+	pdev = pci_find_slot(dev->bus->number, 0);
+	if (!msi_ht_cap_enabled(dev) && !msi_ht_cap_enabled(pdev)) {
+		printk(KERN_WARNING "PCI: MSI quirk detected. "
+		       "PCI_BUS_FLAGS_NO_MSI set for %s subordinate bus.\n",
+		       pci_name(dev));
+		dev->subordinate->bus_flags |= PCI_BUS_FLAGS_NO_MSI;
+	}
+}
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_CK804_PCIE, quirk_nvidia_ck804_msi_ht_cap);
 #endif /* CONFIG_PCI_MSI */
 
 EXPORT_SYMBOL(pcie_mch_quirk);
Index: linux-mm/include/linux/pci_ids.h
===================================================================
--- linux-mm.orig/include/linux/pci_ids.h	2006-06-20 22:02:02.000000000 -0400
+++ linux-mm/include/linux/pci_ids.h	2006-06-20 22:03:30.000000000 -0400
@@ -1027,6 +1027,7 @@
 #define PCI_DEVICE_ID_NVIDIA_NVENET_8		0x0056
 #define PCI_DEVICE_ID_NVIDIA_NVENET_9		0x0057
 #define PCI_DEVICE_ID_NVIDIA_CK804_AUDIO	0x0059
+#define PCI_DEVICE_ID_NVIDIA_CK804_PCIE		0x005d
 #define PCI_DEVICE_ID_NVIDIA_NFORCE2_SMBUS	0x0064
 #define PCI_DEVICE_ID_NVIDIA_NFORCE2_IDE	0x0065
 #define PCI_DEVICE_ID_NVIDIA_NVENET_2		0x0066
@@ -1405,6 +1406,7 @@
 #define PCI_DEVICE_ID_SERVERWORKS_LE	  0x0009
 #define PCI_DEVICE_ID_SERVERWORKS_GCNB_LE 0x0017
 #define PCI_DEVICE_ID_SERVERWORKS_EPB	  0x0103
+#define PCI_DEVICE_ID_SERVERWORKS_HT2000_PCIE	0x0132
 #define PCI_DEVICE_ID_SERVERWORKS_OSB4	  0x0200
 #define PCI_DEVICE_ID_SERVERWORKS_CSB5	  0x0201
 #define PCI_DEVICE_ID_SERVERWORKS_CSB6    0x0203
