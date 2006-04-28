Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751043AbWD1EcT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751043AbWD1EcT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 00:32:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751840AbWD1EcT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 00:32:19 -0400
Received: from gate.crashing.org ([63.228.1.57]:46999 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1751043AbWD1EcS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 00:32:18 -0400
Date: Thu, 27 Apr 2006 23:29:03 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
X-X-Sender: galak@gate.crashing.org
To: Greg KH <greg@kroah.com>
cc: Andrew Morton <akpm@osdl.org>, <linux-pci@atrey.karlin.mff.cuni.cz>,
       <linux-kernel@vger.kernel.org>
Subject: [PATCH][UPDATE] PCI: Add pci_assign_resource_fixed -- allow fixed
 address assignments
In-Reply-To: <20060428001758.GA18917@kroah.com>
Message-ID: <Pine.LNX.4.44.0604272328380.5047-100000@gate.crashing.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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
commit 094733d858fc30c7a5412485b22f94d47b3efd86
tree 8d3b461566134baf72e085ee85d06bcc1fbd800f
parent 2be4d50295e2b6f62c07b614e1b103e280dddb84
author Kumar Gala <galak@kernel.crashing.org> Thu, 27 Apr 2006 23:30:43 -0500
committer Kumar Gala <galak@kernel.crashing.org> Thu, 27 Apr 2006 23:30:43 -0500

 drivers/pci/pci.c       |    3 +++
 drivers/pci/setup-res.c |   37 +++++++++++++++++++++++++++++++++++++
 include/linux/pci.h     |    3 +++
 3 files changed, 43 insertions(+), 0 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 2329f94..955a96e 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -947,6 +947,9 @@ EXPORT_SYMBOL_GPL(pci_intx);
 EXPORT_SYMBOL(pci_set_dma_mask);
 EXPORT_SYMBOL(pci_set_consistent_dma_mask);
 EXPORT_SYMBOL(pci_assign_resource);
+#ifdef CONFIG_EMBEDDED
+EXPORT_SYMBOL(pci_assign_resource_fixed);
+#endif
 EXPORT_SYMBOL(pci_find_parent_resource);
 
 EXPORT_SYMBOL(pci_set_power_state);
diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
index ea9277b..fbfb461 100644
--- a/drivers/pci/setup-res.c
+++ b/drivers/pci/setup-res.c
@@ -155,6 +155,43 @@ int pci_assign_resource(struct pci_dev *
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
+		printk(KERN_ERR "PCI: Failed to allocate %s resource #%d:%lx@%lx for %s\n",
+		       res->flags & IORESOURCE_IO ? "I/O" : "mem",
+		       resno, res->end - res->start + 1, res->start, pci_name(dev));
+	} else if (resno < PCI_BRIDGE_RESOURCES) {
+		pci_update_resource(dev, res, resno);
+	}
+
+	return ret;
+}
+#endif
+
 /* Sort resources by alignment */
 void __devinit
 pdev_sort_resources(struct pci_dev *dev, struct resource_list *head)
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 3a6a4e3..c7c5399 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -496,6 +496,9 @@ int pci_set_dma_mask(struct pci_dev *dev
 int pci_set_consistent_dma_mask(struct pci_dev *dev, u64 mask);
 void pci_update_resource(struct pci_dev *dev, struct resource *res, int resno);
 int pci_assign_resource(struct pci_dev *dev, int i);
+#ifdef CONFIG_EMBEDDED
+int pci_assign_resource_fixed(struct pci_dev *dev, int i);
+#endif
 void pci_restore_bars(struct pci_dev *dev);
 
 /* ROM control related routines */

