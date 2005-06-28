Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261555AbVF1FpJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261555AbVF1FpJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 01:45:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261330AbVF1FoS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 01:44:18 -0400
Received: from mail.kroah.org ([69.55.234.183]:11244 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261553AbVF1Fdf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 01:33:35 -0400
Cc: michael@ellerman.id.au
Subject: [PATCH] PCI: fix-pci-mmap-on-ppc-and-ppc64.patch
In-Reply-To: <1119936774301@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 27 Jun 2005 22:32:54 -0700
Message-Id: <11199367741201@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] PCI: fix-pci-mmap-on-ppc-and-ppc64.patch

This is an updated version of Ben's fix-pci-mmap-on-ppc-and-ppc64.patch
which is in 2.6.12-rc4-mm1.

It fixes the patch to work on PPC iSeries, removes some debug printks
at Ben's request, and incorporates your
fix-pci-mmap-on-ppc-and-ppc64-fix.patch also.

Originally from Benjamin Herrenschmidt <benh@kernel.crashing.org>

This patch was discussed at length on linux-pci and so far, the last
iteration of it didn't raise any comment.  It's effect is a nop on
architecture that don't define the new pci_resource_to_user() callback
anyway.  It allows architecture like ppc who put weird things inside of
PCI resource structures to convert to some different value for user
visible ones.  It also fixes mmap'ing of IO space on those archs.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 2311b1f2bbd36fa5f366a7448c718b2556e0f02c
tree 10e836c5c34893f8098464a5ae15aba351a7bb2a
parent a0d399a808916d22c1c222c6b5ca4e8edd6d91a9
author Michael Ellerman <michael@ellerman.id.au> Fri, 13 May 2005 17:44:10 +1000
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 27 Jun 2005 21:52:45 -0700

 arch/ppc/kernel/pci.c   |   21 +++++++++++++++++++--
 arch/ppc64/kernel/pci.c |   22 ++++++++++++++++++++--
 drivers/pci/pci-sysfs.c |   26 +++++++++++++++++++++-----
 drivers/pci/proc.c      |   14 ++++++++++----
 include/asm-ppc/pci.h   |    6 ++++++
 include/asm-ppc64/pci.h |    7 +++++++
 include/linux/pci.h     |   14 ++++++++++++++
 7 files changed, 97 insertions(+), 13 deletions(-)

diff --git a/arch/ppc/kernel/pci.c b/arch/ppc/kernel/pci.c
--- a/arch/ppc/kernel/pci.c
+++ b/arch/ppc/kernel/pci.c
@@ -1495,7 +1495,7 @@ static struct resource *__pci_mmap_make_
 		*offset += hose->pci_mem_offset;
 		res_bit = IORESOURCE_MEM;
 	} else {
-		io_offset = (unsigned long)hose->io_base_virt;
+		io_offset = hose->io_base_virt - ___IO_BASE;
 		*offset += io_offset;
 		res_bit = IORESOURCE_IO;
 	}
@@ -1522,7 +1522,7 @@ static struct resource *__pci_mmap_make_
 
 		/* found it! construct the final physical address */
 		if (mmap_state == pci_mmap_io)
-			*offset += hose->io_base_phys - _IO_BASE;
+			*offset += hose->io_base_phys - io_offset;
 		return rp;
 	}
 
@@ -1739,6 +1739,23 @@ long sys_pciconfig_iobase(long which, un
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
diff --git a/arch/ppc64/kernel/pci.c b/arch/ppc64/kernel/pci.c
--- a/arch/ppc64/kernel/pci.c
+++ b/arch/ppc64/kernel/pci.c
@@ -351,7 +351,7 @@ static struct resource *__pci_mmap_make_
 		*offset += hose->pci_mem_offset;
 		res_bit = IORESOURCE_MEM;
 	} else {
-		io_offset = (unsigned long)hose->io_base_virt;
+		io_offset = (unsigned long)hose->io_base_virt - pci_io_base;
 		*offset += io_offset;
 		res_bit = IORESOURCE_IO;
 	}
@@ -378,7 +378,7 @@ static struct resource *__pci_mmap_make_
 
 		/* found it! construct the final physical address */
 		if (mmap_state == pci_mmap_io)
-			*offset += hose->io_base_phys - io_offset;
+		       	*offset += hose->io_base_phys - io_offset;
 		return rp;
 	}
 
@@ -944,4 +944,22 @@ int pci_read_irq_line(struct pci_dev *pc
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
diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -60,15 +60,18 @@ resource_show(struct device * dev, struc
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
+		str += sprintf(str,"0x%016llx 0x%016llx 0x%016llx\n",
+			       (unsigned long long)start,
+			       (unsigned long long)end,
+			       (unsigned long long)res->flags);
 	}
 	return (str - buf);
 }
@@ -313,8 +316,21 @@ pci_mmap_resource(struct kobject *kobj, 
 						       struct device, kobj));
 	struct resource *res = (struct resource *)attr->private;
 	enum pci_mmap_state mmap_type;
+	u64 start, end;
+	int i;
 
-	vma->vm_pgoff += res->start >> PAGE_SHIFT;
+	for (i = 0; i < PCI_ROM_RESOURCE; i++)
+		if (res == &pdev->resource[i])
+			break;
+	if (i >= PCI_ROM_RESOURCE)
+		return -ENODEV;
+
+	/* pci_mmap_page_range() expects the same kind of entry as coming
+	 * from /proc/bus/pci/ which is a "user visible" value. If this is
+	 * different from the resource itself, arch will do necessary fixup.
+	 */
+	pci_resource_to_user(pdev, i, res, &start, &end);
+	vma->vm_pgoff += start >> PAGE_SHIFT;
 	mmap_type = res->flags & IORESOURCE_MEM ? pci_mmap_mem : pci_mmap_io;
 
 	return pci_mmap_page_range(pdev, vma, mmap_type, 0);
diff --git a/drivers/pci/proc.c b/drivers/pci/proc.c
--- a/drivers/pci/proc.c
+++ b/drivers/pci/proc.c
@@ -355,14 +355,20 @@ static int show_device(struct seq_file *
 			dev->device,
 			dev->irq);
 	/* Here should be 7 and not PCI_NUM_RESOURCES as we need to preserve compatibility */
-	for(i=0; i<7; i++)
+	for (i=0; i<7; i++) {
+		u64 start, end;
+		pci_resource_to_user(dev, i, &dev->resource[i], &start, &end);
 		seq_printf(m, LONG_FORMAT,
-			dev->resource[i].start |
+			((unsigned long)start) |
 			(dev->resource[i].flags & PCI_REGION_FLAG_MASK));
-	for(i=0; i<7; i++)
+	}
+	for (i=0; i<7; i++) {
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
diff --git a/include/asm-ppc/pci.h b/include/asm-ppc/pci.h
--- a/include/asm-ppc/pci.h
+++ b/include/asm-ppc/pci.h
@@ -103,6 +103,12 @@ extern pgprot_t	pci_phys_mem_access_prot
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
diff --git a/include/asm-ppc64/pci.h b/include/asm-ppc64/pci.h
--- a/include/asm-ppc64/pci.h
+++ b/include/asm-ppc64/pci.h
@@ -136,6 +136,13 @@ extern pgprot_t	pci_phys_mem_access_prot
 					 unsigned long size,
 					 pgprot_t prot);
 
+#ifdef CONFIG_PPC_MULTIPLATFORM
+#define HAVE_ARCH_PCI_RESOURCE_TO_USER
+extern void pci_resource_to_user(const struct pci_dev *dev, int bar,
+				 const struct resource *rsrc,
+				 u64 *start, u64 *end);
+#endif /* CONFIG_PPC_MULTIPLATFORM */
+
 
 #endif	/* __KERNEL__ */
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1020,6 +1020,20 @@ static inline char *pci_name(struct pci_
 #define pci_pretty_name(dev) ""
 #endif
 
+
+/* Some archs don't want to expose struct resource to userland as-is
+ * in sysfs and /proc
+ */
+#ifndef HAVE_ARCH_PCI_RESOURCE_TO_USER
+static inline void pci_resource_to_user(const struct pci_dev *dev, int bar,
+                const struct resource *rsrc, u64 *start, u64 *end)
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

