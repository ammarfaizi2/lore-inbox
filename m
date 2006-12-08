Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1760811AbWLHS16@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760811AbWLHS16 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Dec 2006 13:27:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760810AbWLHS15
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 13:27:57 -0500
Received: from smtp.osdl.org ([65.172.181.25]:46211 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760811AbWLHS14 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 13:27:56 -0500
Message-Id: <20061208182500.407073000@osdl.org>
References: <20061208182241.786324000@osdl.org>
User-Agent: quilt/0.46-1
Date: Fri, 08 Dec 2006 10:22:42 -0800
From: Stephen Hemminger <shemminger@osdl.org>
To: Greg Kroah-Hartman <gregkh@suse.de>
Cc: linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] PCI-X Max Read Byte Count interface
Content-Disposition: inline; filename=pci-x-mmrbc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add interface to allow setting PCI-X Max Memory Read Byte Count
The get interface is commented out because there are no drivers
that need it.

The AMD 8131 chipset has a number of errata's related to PCI-X
configuration. The BIOS sets initial value correctly, but if a
device changes MMRBC it could cause data corruption. There are
some more settings of MMRBC that could be allowed but 
determining the safe values is more effort than it is worth.


Signed-off-by: Stephen Hemminger <shemminger@osdl.org>
---
 drivers/pci/pci.c    |   80 +++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/pci/quirks.c |   19 +++++++++++-
 include/linux/pci.h  |    5 ++-
 3 files changed, 102 insertions(+), 2 deletions(-)

--- pci-x.orig/drivers/pci/pci.c
+++ pci-x/drivers/pci/pci.c
@@ -1059,6 +1059,86 @@ pci_set_consistent_dma_mask(struct pci_d
 	return 0;
 }
 #endif
+
+
+#if 0
+/**
+ * pcix_get_mmrbc - get PCI-X maximum memory read byte count
+ * @dev: PCI device to query
+ *
+ * Returns mmrbc: maximum memory read count in bytes
+ *    or appropriate error value.
+ */
+int pcix_get_mmrbc(struct pci_dev *dev)
+{
+	int ret, cap;
+	u32 cmd;
+
+	cap = pci_find_capability(dev, PCI_CAP_ID_PCIX);
+	if (!cap)
+		return -EINVAL;
+
+	ret = pci_read_config_dword(dev, cap + PCI_X_CMD, &cmd);
+	if (!ret)
+		ret = 512 << ((cmd & PCI_X_CMD_MAX_READ) >> 2);
+
+	return ret;
+}
+EXPORT_SYMBOL(pcix_get_mmrbc);
+#endif
+
+/**
+ * pcix_set_mmrbc - set PCI-X maximum memory read byte count
+ * @dev: PCI device to query
+ * @mmrbc: maximum memory read count in bytes
+ *    valid values are 512, 1024, 2048, 4096
+ *
+ * If possible sets maximum memory read byte count, some bridges have erratas
+ * that prevent this.
+ */
+int
+pcix_set_mmrbc(struct pci_dev *dev, int mmrbc)
+{
+	int cap, err = -EINVAL;
+	u32 stat, cmd, v, o;
+
+	if (mmrbc < 512 || mmrbc > 4096 || (mmrbc & (mmrbc-1)))
+		goto out;
+
+	v = ffs(mmrbc) - 10;
+
+	cap = pci_find_capability(dev, PCI_CAP_ID_PCIX);
+	if (!cap)
+		goto out;	/* not PCI-X */
+
+	err = pci_read_config_dword(dev, cap + PCI_X_STATUS, &stat);
+	if (err)
+		goto out;
+
+	if (v > (stat & PCI_X_STATUS_MAX_READ) >> 21)
+		return -E2BIG;
+
+	err = pci_read_config_dword(dev, cap + PCI_X_CMD, &cmd);
+	if (err)
+		goto out;
+
+	o = (cmd & PCI_X_CMD_MAX_READ) >> 2;
+	if (o != v) {
+		/* Increasing can cause problems o some broken bridges */
+		if (v > o && dev->bus &&
+		    (dev->bus->bus_flags & PCI_BUS_FLAGS_NO_MMRBC))
+			return -EIO;
+
+		cmd &= ~PCI_X_CMD_MAX_READ;
+		cmd |= v << 2;
+		err = pci_write_config_dword(dev, cap + PCI_X_CMD, cmd);
+	}
+
+out:
+	return err;
+}
+EXPORT_SYMBOL(pcix_set_mmrbc);
+
      
 static int __devinit pci_init(void)
 {
--- pci-x.orig/drivers/pci/quirks.c
+++ pci-x/drivers/pci/quirks.c
@@ -615,9 +615,26 @@ static void __init quirk_amd_8131_ioapic
                 pci_write_config_byte( dev, AMD8131_MISC, tmp);
         }
 } 
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_8131_BRIDGE, quirk_amd_8131_ioapic);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_8131_BRIDGE, quirk_amd_8131o_ioapic);
 #endif /* CONFIG_X86_IO_APIC */
 
+/*
+ * Some settings of MMRBC can lead to data corruption so block changes.
+ * See AMD 8131 HyperTransport PCI-X Tunnel Revision Guide
+ */
+static void __init quirk_amd_8131_mmrbc(struct pci_dev *dev)
+{
+	unsigned char revid;
+
+        pci_read_config_byte(dev, PCI_REVISION_ID, &revid);
+        if (dev->subordinate && revid <= 0x12) {
+                printk(KERN_INFO "AMD8131 rev %x detected, disabling PCI-X MMRBC\n",
+		       revid);
+		dev->subordinate->bus_flags |= PCI_BUS_FLAGS_NO_MMRBC;
+        }
+}
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_8131_BRIDGE, quirk_amd_8131_mmrbc);
+
 
 /*
  * FIXME: it is questionable that quirk_via_acpi
--- pci-x.orig/include/linux/pci.h
+++ pci-x/include/linux/pci.h
@@ -98,7 +98,8 @@ enum pci_channel_state {
 
 typedef unsigned short __bitwise pci_bus_flags_t;
 enum pci_bus_flags {
-	PCI_BUS_FLAGS_NO_MSI = (__force pci_bus_flags_t) 1,
+	PCI_BUS_FLAGS_NO_MSI   = (__force pci_bus_flags_t) 1,
+	PCI_BUS_FLAGS_NO_MMRBC = (__force pci_bus_flags_t) 2,
 };
 
 struct pci_cap_saved_state {
@@ -511,6 +512,8 @@ void pci_clear_mwi(struct pci_dev *dev);
 void pci_intx(struct pci_dev *dev, int enable);
 int pci_set_dma_mask(struct pci_dev *dev, u64 mask);
 int pci_set_consistent_dma_mask(struct pci_dev *dev, u64 mask);
+int pcix_get_mmrbc(struct pci_dev *dev);
+int pcix_set_mmrbc(struct pci_dev *dev, int mmrbc);
 void pci_update_resource(struct pci_dev *dev, struct resource *res, int resno);
 int __must_check pci_assign_resource(struct pci_dev *dev, int i);
 int __must_check pci_assign_resource_fixed(struct pci_dev *dev, int i);

-- 

