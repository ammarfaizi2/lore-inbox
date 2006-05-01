Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932124AbWEAPrR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932124AbWEAPrR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 11:47:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932137AbWEAPrR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 11:47:17 -0400
Received: from gate.crashing.org ([63.228.1.57]:40128 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S932124AbWEAPrQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 11:47:16 -0400
Date: Mon, 1 May 2006 10:43:46 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
X-X-Sender: galak@gate.crashing.org
To: Andrew Morton <akpm@osdl.org>
cc: greg@kroah.com, <linux-pci@atrey.karlin.mff.cuni.cz>,
       <linux-kernel@vger.kernel.org>
Subject: [PATCH][UPDATE] PCI: Add pci_assign_resource_fixed -- allow fixed
 address assignments
In-Reply-To: <DE38C452-B9E4-4365-8DC1-39B19BAEE772@kernel.crashing.org>
Message-ID: <Pine.LNX.4.44.0605011043270.11156-100000@gate.crashing.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

PCI: Add pci_assign_resource_fixed -- allow fixed address assignments

On some embedded systems the PCI address for hotplug devices are not only
known a priori but are required to be at a given PCI address for other
master in the system to be able to access.

An example of such a system would be an FPGA which is setup from user space
after the system has booted.  The FPGA may be access by DSPs in the system
and those DSPs expect the FPGA at a fixed PCI address.

Added pci_assign_resource_fixed() as a way to allow assignment of the PCI
devices's BARs at fixed PCI addresses.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

---
commit a6dbd2dcbccd760291bb098d5ee4a72cd4ccd45b
tree 7b10a03750e293901a2ce192d7d8055381810e2d
parent 2be4d50295e2b6f62c07b614e1b103e280dddb84
author Kumar Gala <galak@kernel.crashing.org> Mon, 01 May 2006 10:46:00 -0500
committer Kumar Gala <galak@kernel.crashing.org> Mon, 01 May 2006 10:46:00 -0500

 drivers/pci/setup-res.c |   40 ++++++++++++++++++++++++++++++++++++++++
 include/linux/pci.h     |    1 +
 2 files changed, 41 insertions(+), 0 deletions(-)

diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
index ea9277b..5ae09d2 100644
--- a/drivers/pci/setup-res.c
+++ b/drivers/pci/setup-res.c
@@ -155,6 +155,46 @@ int pci_assign_resource(struct pci_dev *
 	return ret;
 }
 
+#ifdef CONFIG_EMBEDDED
+int pci_assign_resource_fixed(struct pci_dev *dev, int resno)
+{
+	struct pci_bus *bus = dev->bus;
+	struct resource *res = dev->resource + resno;
+	unsigned int type_mask;
+	int i, ret = -EBUSY;
+
+	type_mask = IORESOURCE_IO | IORESOURCE_MEM | IORESOURCE_PREFETCH;
+
+	for (i = 0; i < PCI_BUS_NUM_RESOURCES; i++) {
+		struct resource *r = bus->resource[i];
+		if (!r)
+			continue;
+
+		/* type_mask must match */
+		if ((res->flags ^ r->flags) & type_mask)
+			continue;
+
+		ret = request_resource(r, res);
+
+		if (ret == 0)
+			break;
+	}
+
+	if (ret) {
+		printk(KERN_ERR "PCI: Failed to allocate %s resource "
+				"#%d:%llx@%llx for %s\n",
+			res->flags & IORESOURCE_IO ? "I/O" : "mem",
+			resno, (unsigned long long)(res->end - res->start + 1),
+			(unsigned long long)res->start, pci_name(dev));
+	} else if (resno < PCI_BRIDGE_RESOURCES) {
+		pci_update_resource(dev, res, resno);
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL(pci_assign_resource_fixed);
+#endif
+
 /* Sort resources by alignment */
 void __devinit
 pdev_sort_resources(struct pci_dev *dev, struct resource_list *head)
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 3a6a4e3..704dae3 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -496,6 +496,7 @@ int pci_set_dma_mask(struct pci_dev *dev
 int pci_set_consistent_dma_mask(struct pci_dev *dev, u64 mask);
 void pci_update_resource(struct pci_dev *dev, struct resource *res, int resno);
 int pci_assign_resource(struct pci_dev *dev, int i);
+int pci_assign_resource_fixed(struct pci_dev *dev, int i);
 void pci_restore_bars(struct pci_dev *dev);
 
 /* ROM control related routines */

