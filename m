Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1760825AbWLHS2V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760825AbWLHS2V (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Dec 2006 13:28:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760810AbWLHS17
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 13:27:59 -0500
Received: from smtp.osdl.org ([65.172.181.25]:46212 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760813AbWLHS14 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 13:27:56 -0500
Message-Id: <20061208182500.550052000@osdl.org>
References: <20061208182241.786324000@osdl.org>
User-Agent: quilt/0.46-1
Date: Fri, 08 Dec 2006 10:22:44 -0800
From: Stephen Hemminger <shemminger@osdl.org>
To: Greg Kroah-Hartman <gregkh@suse.de>
Cc: linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] PCI Express get/set read request size
Content-Disposition: inline; filename=pcie-rrbc.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add PCI infrastructure for setting read request size.
The pcie_get_readrq is commented out because there are no drivers
that need it.


---
 drivers/pci/pci.c   |   65 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 include/linux/pci.h |    4 ++-
 2 files changed, 67 insertions(+), 2 deletions(-)

--- pci-x.orig/drivers/pci/pci.c
+++ pci-x/drivers/pci/pci.c
@@ -1139,7 +1139,70 @@ out:
 }
 EXPORT_SYMBOL(pcix_set_mmrbc);
 
-     
+#if 0
+/**
+ * pcie_get_readrq - get PCI Express read request size
+ * @dev: PCI device to query
+ *
+ * Returns maximum memory read request in bytes
+ *    or appropriate error value.
+ */
+int pcie_get_readrq(struct pci_dev *dev)
+{
+	int ret, cap;
+	u16 ctl;
+
+	cap = pci_find_capability(dev, PCI_CAP_ID_EXP);
+	if (!cap)
+		return -EINVAL;
+
+	ret = pci_read_config_word(dev, cap + PCI_EXP_DEVCTL, &ctl);
+	if (!ret)
+		ret = 128 << ((ctl & PCI_EXP_DEVCTL_READRQ) >> 12);
+
+	return ret;
+}
+EXPORT_SYMBOL(pcie_get_readrq);
+#endif
+
+/**
+ * pcie_set_readrq - set PCI Express maximum memory read request
+ * @dev: PCI device to query
+ * @count: maximum memory read count in bytes
+ *    valid values are 128, 256, 512, 1024, 2048, 4096
+ *
+ * If possible sets maximum read byte count
+ */
+int
+pcie_set_readrq(struct pci_dev *dev, int count)
+{
+	int cap, err = -EINVAL;
+	u16 ctl, v;
+
+	if (count < 128 || count > 4096 || (count & (count-1)))
+		goto out;
+
+	v = (ffs(count) - 8) << 12;
+
+	cap = pci_find_capability(dev, PCI_CAP_ID_EXP);
+	if (!cap)
+		goto out;
+
+	err = pci_read_config_word(dev, cap + PCI_EXP_DEVCTL, &ctl);
+	if (err)
+		goto out;
+
+	if ((ctl & PCI_EXP_DEVCTL_READRQ) != v) {
+		ctl &= ~PCI_EXP_DEVCTL_READRQ;
+		ctl |= v;
+		err = pci_write_config_dword(dev, cap + PCI_EXP_DEVCTL, ctl);
+	}
+
+out:
+	return err;
+}
+EXPORT_SYMBOL(pcie_set_readrq);
+
 static int __devinit pci_init(void)
 {
 	struct pci_dev *dev = NULL;
--- pci-x.orig/include/linux/pci.h
+++ pci-x/include/linux/pci.h
@@ -513,7 +513,9 @@ void pci_intx(struct pci_dev *dev, int e
 int pci_set_dma_mask(struct pci_dev *dev, u64 mask);
 int pci_set_consistent_dma_mask(struct pci_dev *dev, u64 mask);
 int pcix_get_mmrbc(struct pci_dev *dev);
-int pcix_set_mmrbc(struct pci_dev *dev, int mmrbc);
+int pcix_set_mmrbc(struct pci_dev *dev, int rq);
+int pcie_get_readrq(struct pci_dev *dev);
+int pcie_set_readrq(struct pci_dev *dev, int rq);
 void pci_update_resource(struct pci_dev *dev, struct resource *res, int resno);
 int __must_check pci_assign_resource(struct pci_dev *dev, int i);
 int __must_check pci_assign_resource_fixed(struct pci_dev *dev, int i);

-- 

