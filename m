Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261357AbVCQXSx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261357AbVCQXSx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 18:18:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261360AbVCQXSx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 18:18:53 -0500
Received: from isilmar.linta.de ([213.239.214.66]:40579 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S261357AbVCQXSc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 18:18:32 -0500
Date: Fri, 18 Mar 2005 00:18:31 +0100
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: gregkh@suse.de, linux-pci@atrey.karlin.mff.cuni.cz, torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, benh@kernel.crashing.org, akpm@osdl.org
Subject: [PATCH 1/2] PCI-PCI transparent bridge handling improvements (pci core)
Message-ID: <20050317231831.GA24645@isilmar.linta.de>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.net>,
	gregkh@suse.de, linux-pci@atrey.karlin.mff.cuni.cz,
	torvalds@osdl.org, linux-kernel@vger.kernel.org,
	benh@kernel.crashing.org, akpm@osdl.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Transparent" PCI-PCI bridges are currently "ignored" by the resource
management code in the PCI core. This means devices behind the bridge are
handled as if there was no bridge.

However, it seems more suitable -- and it seems to allow for proper
"prefetch"-type memory handling, too -- to handle a transparent PCI-PCI bridge 
like any other PCI-PCI bridge, and to only break out of the limits set by
the bridge windows if the resource allocation code determines it needs to 
do s.

The tricky part is in pci_find_parent_resource(). There are two types of
functions calling it: some functions already know the exact resource for
which they want to find the parent in order to properly insert it into the
resource database. This can be handled easily -- if the resource is inside
the bridge window, this is returned; if it isn't, the bridge's parent
resource is returned.

However, two callers (yenta_socket and i2o) intend something different: they
call pci_find_parent_resource() with an empty resource and want to find out
the biggest valid resource of the proper type in order to analyze it and
adapt its own hunger for resources to it. To keep this behaviour 
backwards-compatible, we always need to not limit it to the bridge window 
resources, but get back to the parent bus.


This patch is a modified and (hopefully) improved derivation of Linus' 
"pcmcia-bridge-resource-management-fix.patch" included in 2.6.11-rc4-mm1.


Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>

Index: 2.6.11++/drivers/pci/bus.c
===================================================================
--- 2.6.11++.orig/drivers/pci/bus.c	2005-03-17 00:39:00.000000000 +0100
+++ 2.6.11++/drivers/pci/bus.c	2005-03-17 00:39:24.000000000 +0100
@@ -18,22 +18,12 @@
 #include "pci.h"
 
 /**
- * pci_bus_alloc_resource - allocate a resource from a parent bus
- * @bus: PCI bus
- * @res: resource to allocate
- * @size: size of resource to allocate
- * @align: alignment of resource to allocate
- * @min: minimum /proc/iomem address to allocate
- * @type_mask: IORESOURCE_* type flags
- * @alignf: resource alignment function
- * @alignf_data: data argument for resource alignment function
+ * pci_one_bus_alloc_resource - allocate a resource from one specific bus
  *
- * Given the PCI bus a device resides on, the size, minimum address,
- * alignment and type, try to find an acceptable resource allocation
- * for a specific device resource.
+ * Always use pci_bus_alloc_resource() described below.
  */
-int
-pci_bus_alloc_resource(struct pci_bus *bus, struct resource *res,
+static int
+pci_one_bus_alloc_resource(struct pci_bus *bus, struct resource *res,
 	unsigned long size, unsigned long align, unsigned long min,
 	unsigned int type_mask,
 	void (*alignf)(void *, struct resource *,
@@ -69,6 +59,48 @@
 }
 
 /**
+ * pci_bus_alloc_resource - allocate a resource from a parent bus
+ * @bus: PCI bus
+ * @res: resource to allocate
+ * @size: size of resource to allocate
+ * @align: alignment of resource to allocate
+ * @min: minimum /proc/iomem address to allocate
+ * @type_mask: IORESOURCE_* type flags
+ * @alignf: resource alignment function
+ * @alignf_data: data argument for resource alignment function
+ *
+ * Given the PCI bus a device resides on, the size, minimum address,
+ * alignment and type, try to find an acceptable resource allocation
+ * for a specific device resource.
+ */
+int
+pci_bus_alloc_resource(struct pci_bus *bus, struct resource *res,
+	unsigned long size, unsigned long align, unsigned long min,
+	unsigned int type_mask,
+	void (*alignf)(void *, struct resource *,
+			unsigned long, unsigned long),
+	void *alignf_data)
+{
+	int ret = pci_one_bus_alloc_resource(bus, res, size, align, min,
+					type_mask, alignf, alignf_data);
+
+	/*
+	 * If allocation from the resources available to this bus failed,
+	 * and there is a transparent parent PCI-PCI bridge, we can check
+	 * the resources of the parent bus as well
+	 */
+	while (ret && bus->self && bus->self->transparent) {
+		bus = bus->self->bus;
+		if (!bus)
+			return ret;
+		ret = pci_one_bus_alloc_resource(bus, res, size, align, min,
+					type_mask, alignf, alignf_data);
+	}
+	return ret;
+}
+
+
+/**
  * add a single device
  * @dev: device to add
  *
Index: 2.6.11++/drivers/pci/pci.c
===================================================================
--- 2.6.11++.orig/drivers/pci/pci.c	2005-03-17 00:39:00.000000000 +0100
+++ 2.6.11++/drivers/pci/pci.c	2005-03-17 01:12:18.000000000 +0100
@@ -195,18 +195,13 @@
 }
 
 /**
- * pci_find_parent_resource - return resource region of parent bus of given region
- * @dev: PCI device structure contains resources to be searched
- * @res: child resource record for which parent is sought
+ * pci_bus_find_parent_resource
  *
- *  For given resource region of given device, return the resource
- *  region of parent bus the given region is contained in or where
- *  it should be allocated from.
+ *  Always use pci_find_parent_resource below.
  */
-struct resource *
-pci_find_parent_resource(const struct pci_dev *dev, struct resource *res)
+static struct resource *
+pci_bus_find_parent_resource(const struct pci_bus *bus, struct resource *res)
 {
-	const struct pci_bus *bus = dev->bus;
 	int i;
 	struct resource *best = NULL;
 
@@ -227,6 +222,54 @@
 }
 
 /**
+ * pci_find_parent_resource - return resource region of parent bus of given region
+ * @dev: PCI device structure contains resources to be searched
+ * @res: child resource record for which parent is sought.
+ *
+ *  For given resource region of given device, return the resource
+ *  region of parent bus the given region is contained in or where
+ *  it should be allocated from.
+ */
+struct resource *
+pci_find_parent_resource(const struct pci_dev *dev, struct resource *res)
+{
+	struct pci_bus *bus = dev->bus;
+	struct resource *best, *r;
+
+	best = pci_bus_find_parent_resource(bus, res);
+
+	/*
+	 * If there's a transparent parent PCI-PCI bridge, we check the parent
+	 * bus as well in the following occasions:
+	 *  - we didn't find any appropriate resource
+	 *  - res->start and res->end were 0. This is used in code which
+	 *    then wants to request large amounts of IO, so better not limit
+	 *    it to the sub bus. [yenta_socket.c, i2o/iop.c]
+	 *  - we did find a sub-optimal resource (no PREFETCH for PREFETCH)
+	 */
+	while (bus->self && bus->self->transparent &&
+		(!best  || (!res->start && !res->end)
+			|| ((res->flags & IORESOURCE_PREFETCH) &&
+			    !(best->flags & IORESOURCE_PREFETCH)))) {
+		bus = bus->self->bus;
+		if (!bus)
+			return best;
+		r = pci_bus_find_parent_resource(bus, res);
+
+		/*
+		 * If we didn't find an appropriate resource before, use what
+		 * we found in the parent bus; if it's just a matter of
+		 * PREFETCH, only use it if it is optimal.
+		 */
+		if (!best || (!res->start && !res->end)
+			  || ((r->flags & IORESOURCE_PREFETCH) &&
+			      !(best->flags & IORESOURCE_PREFETCH)))
+			best = r;
+	}
+	return best;
+}
+
+/**
  * pci_set_power_state - Set the power state of a PCI device
  * @dev: PCI device to be suspended
  * @state: PCI power state (D0, D1, D2, D3hot, D3cold) we're entering
Index: 2.6.11++/drivers/pci/probe.c
===================================================================
--- 2.6.11++.orig/drivers/pci/probe.c	2005-03-17 00:39:00.000000000 +0100
+++ 2.6.11++/drivers/pci/probe.c	2005-03-17 00:39:24.000000000 +0100
@@ -243,16 +243,10 @@
 	if (!dev)		/* It's a host bus, nothing to read */
 		return;
 
-	if (dev->transparent) {
-		printk(KERN_INFO "PCI: Transparent bridge - %s\n", pci_name(dev));
-		for(i = 0; i < PCI_BUS_NUM_RESOURCES; i++)
-			child->resource[i] = child->parent->resource[i];
-		return;
-	}
-
-	for(i=0; i<3; i++)
+	for (i=0; i<3; i++)
 		child->resource[i] = &dev->resource[PCI_BRIDGE_RESOURCES+i];
 
+	/* Resource 0 - IO ports */
 	res = child->resource[0];
 	pci_read_config_byte(dev, PCI_IO_BASE, &io_base_lo);
 	pci_read_config_byte(dev, PCI_IO_LIMIT, &io_limit_lo);
@@ -273,6 +267,7 @@
 		res->end = limit + 0xfff;
 	}
 
+	/* Resource 1 - nonprefetchable memory resource */
 	res = child->resource[1];
 	pci_read_config_word(dev, PCI_MEMORY_BASE, &mem_base_lo);
 	pci_read_config_word(dev, PCI_MEMORY_LIMIT, &mem_limit_lo);
@@ -284,6 +279,7 @@
 		res->end = limit + 0xfffff;
 	}
 
+	/* Resource 2 - prefetchable memory resource */
 	res = child->resource[2];
 	pci_read_config_word(dev, PCI_PREF_MEMORY_BASE, &mem_base_lo);
 	pci_read_config_word(dev, PCI_PREF_MEMORY_LIMIT, &mem_limit_lo);
