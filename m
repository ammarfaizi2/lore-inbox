Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266961AbTCEA2z>; Tue, 4 Mar 2003 19:28:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266968AbTCEA2z>; Tue, 4 Mar 2003 19:28:55 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:22802 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S266961AbTCEA2v>; Tue, 4 Mar 2003 19:28:51 -0500
Date: Wed, 5 Mar 2003 00:39:18 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [CFT] PCI probing for cardbus (1/5)
Message-ID: <20030305003918.B25251@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>
References: <20030305003635.A25251@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030305003635.A25251@flint.arm.linux.org.uk>; from rmk@arm.linux.org.uk on Wed, Mar 05, 2003 at 12:36:35AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -uN orig/drivers/pci/Makefile linux/drivers/pci/Makefile
--- orig/drivers/pci/Makefile	Tue Feb 25 10:57:49 2003
+++ linux/drivers/pci/Makefile	Sat Mar  1 15:41:20 2003
@@ -2,7 +2,7 @@
 # Makefile for the PCI bus specific drivers.
 #
 
-obj-y		+= access.o probe.o pci.o pool.o quirks.o \
+obj-y		+= access.o bus.o probe.o pci.o pool.o quirks.o \
 			names.o pci-driver.o search.o hotplug.o \
 			pci-sysfs.o
 obj-$(CONFIG_PM)  += power.o
diff -uN orig/drivers/pci/bus.c linux/drivers/pci/bus.c
--- orig/drivers/pci/bus.c	Thu Jan  1 01:00:00 1970
+++ linux/drivers/pci/bus.c	Sat Mar  1 16:36:43 2003
@@ -0,0 +1,81 @@
+/*
+ *	drivers/pci/bus.c
+ *
+ * From setup-res.c, by:
+ *	Dave Rusling (david.rusling@reo.mts.dec.com)
+ *	David Mosberger (davidm@cs.arizona.edu)
+ *	David Miller (davem@redhat.com)
+ *	Ivan Kokshaysky (ink@jurassic.park.msu.ru)
+ */
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/pci.h>
+#include <linux/errno.h>
+#include <linux/ioport.h>
+
+/**
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
+	int i, ret = -ENOMEM;
+
+	type_mask |= IORESOURCE_IO | IORESOURCE_MEM;
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
+		/* We cannot allocate a non-prefetching resource
+		   from a pre-fetching area */
+		if ((r->flags & IORESOURCE_PREFETCH) &&
+		    !(res->flags & IORESOURCE_PREFETCH))
+			continue;
+
+		/* Ok, try it out.. */
+		ret = allocate_resource(r, res, size, min, -1, align,
+					alignf, alignf_data);
+		if (ret == 0)
+			break;
+	}
+	return ret;
+}
+
+void pci_enable_bridges(struct pci_bus *bus)
+{
+	struct pci_dev *dev;
+
+	list_for_each_entry(dev, &bus->devices, bus_list) {
+		if (dev->subordinate) {
+			pci_enable_device(dev);
+			pci_set_master(dev);
+			pci_enable_bridges(dev->subordinate);
+		}
+	}
+}
+
+EXPORT_SYMBOL(pci_bus_alloc_resource);
+EXPORT_SYMBOL(pci_enable_bridges);
diff -uN orig/drivers/pci/setup-res.c linux/drivers/pci/setup-res.c
--- orig/drivers/pci/setup-res.c	Sat Dec 28 17:07:35 2002
+++ linux/drivers/pci/setup-res.c	Sat Mar  1 10:11:51 2003
@@ -55,84 +55,47 @@
 	return err;
 }
 
-/*
- * Given the PCI bus a device resides on, try to
- * find an acceptable resource allocation for a
- * specific device resource..
- */
-static int pci_assign_bus_resource(const struct pci_bus *bus,
-	struct pci_dev *dev,
-	struct resource *res,
-	unsigned long size,
-	unsigned long min,
-	unsigned int type_mask,
-	int resno)
+int pci_assign_resource(struct pci_dev *dev, int resno)
 {
-	unsigned long align;
-	int i;
-
-	type_mask |= IORESOURCE_IO | IORESOURCE_MEM;
-	for (i = 0 ; i < PCI_BUS_NUM_RESOURCES; i++) {
-		struct resource *r = bus->resource[i];
-		if (!r)
-			continue;
-
-		/* type_mask must match */
-		if ((res->flags ^ r->flags) & type_mask)
-			continue;
-
-		/* We cannot allocate a non-prefetching resource
-		   from a pre-fetching area */
-		if ((r->flags & IORESOURCE_PREFETCH) &&
-		    !(res->flags & IORESOURCE_PREFETCH))
-			continue;
-
-		/* The bridge resources are special, as their
-		   size != alignment. Sizing routines return
-		   required alignment in the "start" field. */
-		align = (resno < PCI_BRIDGE_RESOURCES) ? size : res->start;
-
-		/* Ok, try it out.. */
-		if (allocate_resource(r, res, size, min, -1, align,
-				      pcibios_align_resource, dev) < 0)
-			continue;
-
-		/* Update PCI config space.  */
-		pcibios_update_resource(dev, r, res, resno);
-		return 0;
-	}
-	return -EBUSY;
-}
-
-int 
-pci_assign_resource(struct pci_dev *dev, int i)
-{
-	const struct pci_bus *bus = dev->bus;
-	struct resource *res = dev->resource + i;
-	unsigned long size, min;
+	struct pci_bus *bus = dev->bus;
+	struct resource *res = dev->resource + resno;
+	unsigned long size, min, align;
+	int ret;
 
 	size = res->end - res->start + 1;
 	min = (res->flags & IORESOURCE_IO) ? PCIBIOS_MIN_IO : PCIBIOS_MIN_MEM;
+	/* The bridge resources are special, as their
+	   size != alignment. Sizing routines return
+	   required alignment in the "start" field. */
+	align = (resno < PCI_BRIDGE_RESOURCES) ? size : res->start;
 
 	/* First, try exact prefetching match.. */
-	if (pci_assign_bus_resource(bus, dev, res, size, min, IORESOURCE_PREFETCH, i) < 0) {
+	ret = pci_bus_alloc_resource(bus, res, size, align, min,
+				     IORESOURCE_PREFETCH,
+				     pcibios_align_resource, dev);
+
+	if (ret < 0 && (res->flags & IORESOURCE_PREFETCH)) {
 		/*
 		 * That failed.
 		 *
 		 * But a prefetching area can handle a non-prefetching
 		 * window (it will just not perform as well).
 		 */
-		if (!(res->flags & IORESOURCE_PREFETCH) || pci_assign_bus_resource(bus, dev, res, size, min, 0, i) < 0) {
-			printk(KERN_ERR "PCI: Failed to allocate resource %d(%lx-%lx) for %s\n",
-			       i, res->start, res->end, dev->slot_name);
-			return -EBUSY;
-		}
+		ret = pci_bus_alloc_resource(bus, res, size, align, min, 0,
+					     pcibios_align_resource, dev);
 	}
 
-	DBGC((KERN_ERR "  got res[%lx:%lx] for resource %d of %s\n", res->start,
-						res->end, i, dev->dev.name));
+	if (ret) {
+		printk(KERN_ERR "PCI: Failed to allocate resource %d(%lx-%lx) for %s\n",
+		       resno, res->start, res->end, dev->slot_name);
+	} else {
+		DBGC((KERN_ERR "  got res[%lx:%lx] for resource %d of %s\n",
+		      res->start, res->end, i, dev->dev.name));
+		/* Update PCI config space.  */
+		pcibios_update_resource(dev, res->parent, res, resno);
+	}
 
-	return 0;
+	return ret;
 }
 
 /* Sort resources by alignment */
--- orig/include/linux/pci.h	Sun Mar  2 22:42:29 2003
+++ linux/include/linux/pci.h	Sat Mar  1 15:36:42 2003
@@ -641,6 +641,16 @@
 int pci_request_region(struct pci_dev *, int, char *);
 void pci_release_region(struct pci_dev *, int);
 
+/* drivers/pci/bus.c */
+
+int pci_bus_alloc_resource(struct pci_bus *bus, struct resource *res,
+			   unsigned long size, unsigned long align,
+			   unsigned long min, unsigned int type_mask,
+			   void (*alignf)(void *, struct resource *,
+					  unsigned long, unsigned long),
+			   void *alignf_data);
+void pci_enable_bridges(struct pci_bus *bus);
+
 /* New-style probing supporting hot-pluggable devices */
 int pci_register_driver(struct pci_driver *);
 void pci_unregister_driver(struct pci_driver *);

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

