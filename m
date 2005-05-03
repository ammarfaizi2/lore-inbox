Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261401AbVECFlA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261401AbVECFlA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 01:41:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261403AbVECFk7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 01:40:59 -0400
Received: from gate.crashing.org ([63.228.1.57]:3244 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261401AbVECFkP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 01:40:15 -0400
Subject: pci-sysfs resource mmap broken PATCH#2
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Grant Grundler <grundler@parisc-linux.org>
Cc: linux-pci@atrey.karlin.mff.cuni.cz,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>, bjorn.helgaas@hp.com,
       "David S. Miller" <davem@redhat.com>
In-Reply-To: <1114670123.7182.241.camel@gaston>
References: <1114493609.7183.55.camel@gaston>
	 <20050426163042.GE2612@colo.lackof.org> <1114555655.7183.81.camel@gaston>
	 <1114643616.7183.183.camel@gaston> <20050428053311.GH21784@colo.lackof.org>
	 <1114670123.7182.241.camel@gaston>
Content-Type: text/plain
Date: Tue, 03 May 2005 15:37:52 +1000
Message-Id: <1115098672.6155.86.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, here's my latest version. It goes back to "resource" instead of
"resources" since I finally didn't add the resource number. Since the
format doesn't change for most archs (only ppc/ppc64 for now will get
different values in there), I decided to keep it to it's old name.

So that patch should only impact ppc/ppc64 for now.

If everybody is ok tomorrow, I'll submit it upstream.

Index: linux-work/arch/ppc64/kernel/pci.c
===================================================================
--- linux-work.orig/arch/ppc64/kernel/pci.c	2005-04-24 11:37:38.000000000 +1000
+++ linux-work/arch/ppc64/kernel/pci.c	2005-04-27 14:44:46.000000000 +1000
@@ -351,9 +351,12 @@
 		*offset += hose->pci_mem_offset;
 		res_bit = IORESOURCE_MEM;
 	} else {
-		io_offset = (unsigned long)hose->io_base_virt;
+		io_offset = (unsigned long)hose->io_base_virt - pci_io_base;
+		printk("offset: %lx, io_base_virt: %p, pci_io_base: %lx, io_offset: %lx\n",
+		       *offset, hose->io_base_virt, pci_io_base, io_offset);
 		*offset += io_offset;
 		res_bit = IORESOURCE_IO;
+		printk(" -> offset: %lx\n", *offset);
 	}
 
 	/*
@@ -373,12 +376,15 @@
 			continue;
 
 		/* In the range of this resource? */
+		printk(" r%d: %lx -> %lx\n", i, rp->start, rp->end);
 		if (*offset < (rp->start & PAGE_MASK) || *offset > rp->end)
 			continue;
 
 		/* found it! construct the final physical address */
-		if (mmap_state == pci_mmap_io)
-			*offset += hose->io_base_phys - io_offset;
+		if (mmap_state == pci_mmap_io) {
+		       	*offset += hose->io_base_phys - io_offset;
+			printk(" result: %lx\n", *offset);
+		}
 		return rp;
 	}
 
@@ -941,4 +947,22 @@
 }
 EXPORT_SYMBOL(pci_read_irq_line);
 
+void pci_resource_to_user(const struct pci_dev *dev, int bar,
+			  const struct resource *rsrc,
+			  u64 *start, u64 *end)
+{
+	struct pci_controller *hose = pci_bus_to_host(dev->bus);
+	unsigned long offset = 0;
+
+	if (hose == NULL)
+		return;
+
+	if (rsrc->flags & IORESOURCE_IO)
+		offset = pci_io_base - (unsigned long)hose->io_base_virt +
+			hose->io_base_phys;
+
+	*start = rsrc->start + offset;
+	*end = rsrc->end + offset;
+}
+
 #endif /* CONFIG_PPC_MULTIPLATFORM */
Index: linux-work/drivers/pci/pci-sysfs.c
===================================================================
--- linux-work.orig/drivers/pci/pci-sysfs.c	2005-04-24 11:37:45.000000000 +1000
+++ linux-work/drivers/pci/pci-sysfs.c	2005-04-27 14:40:28.000000000 +1000
@@ -54,27 +54,30 @@
 
 /* show resources */
 static ssize_t
-resource_show(struct device * dev, char * buf)
+resources_show(struct device * dev, char * buf)
 {
 	struct pci_dev * pci_dev = to_pci_dev(dev);
 	char * str = buf;
 	int i;
 	int max = 7;
+	u64 start, end;
 
 	if (pci_dev->subordinate)
 		max = DEVICE_COUNT_RESOURCE;
 
 	for (i = 0; i < max; i++) {
-		str += sprintf(str,"0x%016lx 0x%016lx 0x%016lx\n",
-			       pci_resource_start(pci_dev,i),
-			       pci_resource_end(pci_dev,i),
-			       pci_resource_flags(pci_dev,i));
+		struct resource *res =  &pci_dev->resource[i];
+		pci_resource_to_user(pci_dev, i, res, &start, &end);
+		str += sprintf(str,"0x%02x 0x%016llx 0x%016llx 0x%016llx\n", i,
+			       (unsigned long long)start,
+			       (unsigned long long)end,
+			       (unsigned long long)res->flags);
 	}
 	return (str - buf);
 }
 
 struct device_attribute pci_dev_attrs[] = {
-	__ATTR_RO(resource),
+	__ATTR_RO(resources),
 	__ATTR_RO(vendor),
 	__ATTR_RO(device),
 	__ATTR_RO(subsystem_vendor),
@@ -267,8 +270,21 @@
 						       struct device, kobj));
 	struct resource *res = (struct resource *)attr->private;
 	enum pci_mmap_state mmap_type;
+	u64 start, end;
+	int i;
+
+	for (i = 0; i < PCI_ROM_RESOURCE; i++)
+		if (res == &pdev->resource[i])
+			break;
+	if (i >= PCI_ROM_RESOURCE)
+		return -ENODEV;
 
-	vma->vm_pgoff += res->start >> PAGE_SHIFT;
+	/* pci_mmap_page_range() expects the same kind of entry as coming
+	 * from /proc/bus/pci/ which is a "user visible" value. If this is
+	 * different from the resource itself, arch will do necessary fixup.
+	 */
+	pci_resource_to_user(pdev, i, res, &start, &end);
+	vma->vm_pgoff += start >> PAGE_SHIFT;
 	mmap_type = res->flags & IORESOURCE_MEM ? pci_mmap_mem : pci_mmap_io;
 
 	return pci_mmap_page_range(pdev, vma, mmap_type, 0);
Index: linux-work/include/asm-ppc64/pci.h
===================================================================
--- linux-work.orig/include/asm-ppc64/pci.h	2005-04-24 11:38:56.000000000 +1000
+++ linux-work/include/asm-ppc64/pci.h	2005-04-27 14:34:18.000000000 +1000
@@ -135,6 +135,11 @@
 					 unsigned long offset,
 					 unsigned long size,
 					 pgprot_t prot);
+#define HAVE_ARCH_PCI_RESOURCE_TO_USER
+extern void pci_resource_to_user(const struct pci_dev *dev, int bar,
+				 const struct resource *rsrc,
+				 u64 *start, u64 *end);
+
 
 
 #endif	/* __KERNEL__ */
Index: linux-work/drivers/pci/proc.c
===================================================================
--- linux-work.orig/drivers/pci/proc.c	2005-04-24 11:37:45.000000000 +1000
+++ linux-work/drivers/pci/proc.c	2005-04-27 14:34:18.000000000 +1000
@@ -354,14 +354,20 @@
 			dev->device,
 			dev->irq);
 	/* Here should be 7 and not PCI_NUM_RESOURCES as we need to preserve compatibility */
-	for(i=0; i<7; i++)
+	for(i=0; i<7; i++) {
+		u64 start, end;
+		pci_resource_to_user(dev, i, &dev->resource[i], &start, &end);
 		seq_printf(m, LONG_FORMAT,
-			dev->resource[i].start |
+			((unsigned long)start) |
 			(dev->resource[i].flags & PCI_REGION_FLAG_MASK));
-	for(i=0; i<7; i++)
+	}
+	for(i=0; i<7; i++) {
+		u64 start, end;
+		pci_resource_to_user(dev, i, &dev->resource[i], &start, &end);
 		seq_printf(m, LONG_FORMAT,
 			dev->resource[i].start < dev->resource[i].end ?
-			dev->resource[i].end - dev->resource[i].start + 1 : 0);
+			(unsigned long)(end - start) + 1 : 0);
+	}
 	seq_putc(m, '\t');
 	if (drv)
 		seq_printf(m, "%s", drv->name);
Index: linux-work/drivers/pci/pci.c
===================================================================
--- linux-work.orig/drivers/pci/pci.c	2005-04-24 11:37:45.000000000 +1000
+++ linux-work/drivers/pci/pci.c	2005-04-27 14:34:18.000000000 +1000
@@ -770,7 +770,7 @@
 	return 0;
 }
 #endif
-     
+
 static int __devinit pci_init(void)
 {
 	struct pci_dev *dev = NULL;
Index: linux-work/include/linux/pci.h
===================================================================
--- linux-work.orig/include/linux/pci.h	2005-04-24 11:39:20.000000000 +1000
+++ linux-work/include/linux/pci.h	2005-04-27 14:34:18.000000000 +1000
@@ -1017,6 +1017,21 @@
 #define pci_pretty_name(dev) ""
 #endif
 
+
+/* Some archs don't want to expose struct resource to userland as-is
+ * in sysfs and /proc
+ */
+#ifndef HAVE_ARCH_PCI_RESOURCE_TO_USER
+static void pci_resource_to_user(const struct pci_dev *dev, int bar,
+				 const struct resource *rsrc,
+				 u64 *start, u64 *end)
+{
+	*start = rsrc->start;
+	*end = rsrc->end;
+}
+#endif /* HAVE_ARCH_PCI_RESOURCE_TO_USER */
+
+
 /*
  *  The world is not perfect and supplies us with broken PCI devices.
  *  For at least a part of these bugs we need a work-around, so both
Index: linux-work/include/asm-ppc/pci.h
===================================================================
--- linux-work.orig/include/asm-ppc/pci.h	2005-04-24 11:38:54.000000000 +1000
+++ linux-work/include/asm-ppc/pci.h	2005-04-27 14:34:18.000000000 +1000
@@ -103,6 +103,12 @@
 					 unsigned long size,
 					 pgprot_t prot);
 
+#define HAVE_ARCH_PCI_RESOURCE_TO_USER
+extern void pci_resource_to_user(const struct pci_dev *dev, int bar,
+				 const struct resource *rsrc,
+				 u64 *start, u64 *end);
+
+
 #endif	/* __KERNEL__ */
 
 #endif /* __PPC_PCI_H */
Index: linux-work/arch/ppc/kernel/pci.c
===================================================================
--- linux-work.orig/arch/ppc/kernel/pci.c	2005-04-24 11:37:38.000000000 +1000
+++ linux-work/arch/ppc/kernel/pci.c	2005-04-27 14:42:34.000000000 +1000
@@ -1495,7 +1495,7 @@
 		*offset += hose->pci_mem_offset;
 		res_bit = IORESOURCE_MEM;
 	} else {
-		io_offset = (unsigned long)hose->io_base_virt;
+		io_offset = hose->io_base_virt - ___IO_BASE;
 		*offset += io_offset;
 		res_bit = IORESOURCE_IO;
 	}
@@ -1522,7 +1522,7 @@
 
 		/* found it! construct the final physical address */
 		if (mmap_state == pci_mmap_io)
-			*offset += hose->io_base_phys - _IO_BASE;
+			*offset += hose->io_base_phys - io_offset;
 		return rp;
 	}
 
@@ -1739,6 +1739,23 @@
 	return result;
 }
 
+void pci_resource_to_user(const struct pci_dev *dev, int bar,
+			  const struct resource *rsrc,
+			  u64 *start, u64 *end)
+{
+	struct pci_controller *hose = pci_bus_to_hose(dev->bus->number);
+	unsigned long offset = 0;
+
+	if (hose == NULL)
+		return;
+
+	if (rsrc->flags & IORESOURCE_IO)
+		offset = ___IO_BASE - hose->io_base_virt + hose->io_base_phys;
+
+	*start = rsrc->start + offset;
+	*end = rsrc->end + offset;
+}
+
 void __init
 pci_init_resource(struct resource *res, unsigned long start, unsigned long end,
 		  int flags, char *name)


