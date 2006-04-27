Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965002AbWD0Rqs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965002AbWD0Rqs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 13:46:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965003AbWD0Rqs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 13:46:48 -0400
Received: from gate.crashing.org ([63.228.1.57]:19087 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S965002AbWD0Rqs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 13:46:48 -0400
Date: Thu, 27 Apr 2006 12:43:31 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
X-X-Sender: galak@gate.crashing.org
To: Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>
cc: linux-pci@atrey.karlin.mff.cuni.cz, <linux-kernel@vger.kernel.org>
Subject: [PATCH] PCI: Add pci_assign_resource_fixed -- allow fixed address
 assignments
Message-ID: <Pine.LNX.4.44.0604271242410.25641-100000@gate.crashing.org>
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
commit cb0b39d6c2f3986dd86976062b0f899fa35358ae
tree 4b0af5b9d630113fd4fdcfb35b61313f2b3efb41
parent 2be4d50295e2b6f62c07b614e1b103e280dddb84
author Kumar Gala <galak@kernel.crashing.org> Thu, 27 Apr 2006 12:45:02 -0500
committer Kumar Gala <galak@kernel.crashing.org> Thu, 27 Apr 2006 12:45:02 -0500

 drivers/pci/pci.c       |    1 +
 drivers/pci/setup-res.c |   35 +++++++++++++++++++++++++++++++++++
 include/linux/pci.h     |    1 +
 3 files changed, 37 insertions(+), 0 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 2329f94..5dc7c14 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -947,6 +947,7 @@ EXPORT_SYMBOL_GPL(pci_intx);
 EXPORT_SYMBOL(pci_set_dma_mask);
 EXPORT_SYMBOL(pci_set_consistent_dma_mask);
 EXPORT_SYMBOL(pci_assign_resource);
+EXPORT_SYMBOL(pci_assign_resource_fixed);
 EXPORT_SYMBOL(pci_find_parent_resource);
 
 EXPORT_SYMBOL(pci_set_power_state);
diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
index ea9277b..f485958 100644
--- a/drivers/pci/setup-res.c
+++ b/drivers/pci/setup-res.c
@@ -155,6 +155,41 @@ int pci_assign_resource(struct pci_dev *
 	return ret;
 }
 
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


