Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750937AbWFMSgH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750937AbWFMSgH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 14:36:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750964AbWFMSgG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 14:36:06 -0400
Received: from h-66-166-126-70.lsanca54.covad.net ([66.166.126.70]:18126 "EHLO
	myri.com") by vger.kernel.org with ESMTP id S1750937AbWFMSgF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 14:36:05 -0400
Message-ID: <448F057E.1040104@myri.com>
Date: Tue, 13 Jun 2006 14:35:42 -0400
From: Brice Goglin <brice@myri.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060516)
MIME-Version: 1.0
To: Greg KH <gregkh@suse.de>
CC: linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: [PATCH] nVidia quirk to make AER PCI-E extended capability visible
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The nVidia CK804 PCI-E chipset supports the AER extended capability
but sometimes fails to link it (with some BIOS or after a warm reboot).
It makes the AER cap invisible to pci_find_ext_capability().

The patch adds a quirk to set the missing bit that controls the
linking of the capability.
By the way, it removes the corresponding code in the myri10ge driver.

Signed-off-by: Brice Goglin <brice@myri.com>
Signed-off-by: Loic Prylli <loic@myri.com>

---

 drivers/net/myri10ge/myri10ge.c |    8 --------
 drivers/pci/quirks.c            |   19 +++++++++++++++++++
 include/linux/pci_ids.h         |    1 +
 3 files changed, 20 insertions(+), 8 deletions(-)

Index: linux-mm/drivers/pci/quirks.c
===================================================================
--- linux-mm.orig/drivers/pci/quirks.c	2006-06-09 20:24:56.000000000 -0400
+++ linux-mm/drivers/pci/quirks.c	2006-06-09 20:32:39.000000000 -0400
@@ -1556,6 +1556,25 @@
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	0x1460,		quirk_p64h2_1k_io);
 
+/* Under some circumstances, AER is not linked with extended capabilities.
+ * Force it to be linked by setting the corresponding control bit in the
+ * config space.
+ */
+static void __devinit quirk_nvidia_ck804_pcie_aer_ext_cap(struct pci_dev *dev)
+{
+	uint8_t b;
+	if (pci_read_config_byte(dev, 0xf41, &b) == 0) {
+		if (!(b & 0x20)) {
+			pci_write_config_byte(dev, 0xf41, b | 0x20);
+			printk(KERN_INFO
+			       "PCI: Linking AER extended capability on %s\n",
+			       pci_name(dev));
+		}
+	}
+}
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_NVIDIA,  PCI_DEVICE_ID_NVIDIA_CK804_PCIE,
+			quirk_nvidia_ck804_pcie_aer_ext_cap);
+
 EXPORT_SYMBOL(pcie_mch_quirk);
 #ifdef CONFIG_HOTPLUG
 EXPORT_SYMBOL(pci_fixup_device);
Index: linux-mm/include/linux/pci_ids.h
===================================================================
--- linux-mm.orig/include/linux/pci_ids.h	2006-06-09 20:24:56.000000000 -0400
+++ linux-mm/include/linux/pci_ids.h	2006-06-09 20:32:39.000000000 -0400
@@ -1027,6 +1027,7 @@
 #define PCI_DEVICE_ID_NVIDIA_NVENET_8		0x0056
 #define PCI_DEVICE_ID_NVIDIA_NVENET_9		0x0057
 #define PCI_DEVICE_ID_NVIDIA_CK804_AUDIO	0x0059
+#define PCI_DEVICE_ID_NVIDIA_CK804_PCIE		0x005d
 #define PCI_DEVICE_ID_NVIDIA_NFORCE2_SMBUS	0x0064
 #define PCI_DEVICE_ID_NVIDIA_NFORCE2_IDE	0x0065
 #define PCI_DEVICE_ID_NVIDIA_NVENET_2		0x0066


