Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262414AbVCXG0d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262414AbVCXG0d (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 01:26:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262415AbVCXG0d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 01:26:33 -0500
Received: from gate.crashing.org ([63.228.1.57]:43682 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262414AbVCXGYt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 01:24:49 -0500
Subject: [PATCH] ppc32/64: Map prefetchable PCI without guarded bit
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Thu, 24 Mar 2005 17:24:24 +1100
Message-Id: <1111645464.5569.15.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

While experimenting with framebuffer access performances, we noticed a
very significant improvement in write access to it when not setting
the "guarded" bit on the MMU mappings. This bit basically says that
reads and writes won't have side effects (it allows speculation). It
appears that it also disables write combining.

This patch implements a new phys_mem_access_prot() arch callback for
use by /dev/mem and fbdev when available, implements it for ppc32 and
ppc64, and modifies /dev/mem and fbdev to use it, respectively when
available or on ppc. I didn't change fbdev to use it on all archs
when available because there is already a whole lot of arch specific
mess in there (more than in /dev/mem !) that I didn't feel like messing
with, but archs maintainers are welcome to give it a go).

The old mecanism in /dev/mem is still there, but arch maintainers should
probably switch to this once which is more consistent imho.

Finally, the ppc32 and ppc64 implementation of this and of the PCI mmap
calls (used by /proc and /sys) are modified to check if the mapping
happens in a prefetchable PCI resource, in which case, the guarded bit
is not set for the pgprot. In fact, ppc32 implementation of this code is
updated to be identical to ppc64.

This improves framebuffer write performance on a simple test paul wrote
from about 50Mb/sec to 200Mb/sec on my M9 based laptop and on a G5. The
new hook will automatically catch up Xfree mmap's from /dev/mem, so it
will work out of the box with existing X servers. Kernel fbdev accesses
aren't improved yet as ioremap doesn't use that mecanism.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-work/drivers/char/mem.c
===================================================================
--- linux-work.orig/drivers/char/mem.c	2005-03-24 16:25:43.000000000 +1100
+++ linux-work/drivers/char/mem.c	2005-03-24 16:26:05.000000000 +1100
@@ -76,14 +76,6 @@
 	 * On ia64, we ignore O_SYNC because we cannot tolerate memory attribute aliases.
 	 */
 	return !(efi_mem_attributes(addr) & EFI_MEMORY_WB);
-#elif defined(CONFIG_PPC64)
-	/* On PPC64, we always do non-cacheable access to the IO hole and
-	 * cacheable elsewhere. Cache paradox can checkstop the CPU and
-	 * the high_memory heuristic below is wrong on machines with memory
-	 * above the IO hole... Ah, and of course, XFree86 doesn't pass
-	 * O_SYNC when mapping us to tap IO space. Surprised ?
-	 */
-	return !page_is_ram(addr >> PAGE_SHIFT);
 #else
 	/*
 	 * Accessing memory above the top the kernel knows about or through a file pointer
@@ -238,7 +230,13 @@
 
 static int mmap_mem(struct file * file, struct vm_area_struct * vma)
 {
-#ifdef pgprot_noncached
+#if defined(__HAVE_PHYS_MEM_ACCESS_PROT)
+	unsigned long offset = vma->vm_pgoff << PAGE_SHIFT;
+
+	vma->vm_page_prot = phys_mem_access_prot(file, offset,
+						 vma->vm_end - vma->vm_start,
+						 vma->vm_page_prot);
+#elif defined(pgprot_noncached)
 	unsigned long offset = vma->vm_pgoff << PAGE_SHIFT;
 	int uncached;
 
Index: linux-work/include/asm-ppc64/machdep.h
===================================================================
--- linux-work.orig/include/asm-ppc64/machdep.h	2005-03-24 16:25:43.000000000 +1100
+++ linux-work/include/asm-ppc64/machdep.h	2005-03-24 16:26:05.000000000 +1100
@@ -21,6 +21,7 @@
 struct device_node;
 struct iommu_table;
 struct rtc_time;
+struct file;
 
 #ifdef CONFIG_SMP
 struct smp_ops_t {
@@ -131,6 +132,12 @@
 	/* Get legacy PCI/IDE interrupt mapping */ 
 	int		(*pci_get_legacy_ide_irq)(struct pci_dev *dev, int channel);
 	
+	/* Get access protection for /dev/mem */
+	pgprot_t	(*phys_mem_access_prot)(struct file *file,
+						unsigned long offset,
+						unsigned long size,
+						pgprot_t vma_prot);
+
 };
 
 extern struct machdep_calls ppc_md;
Index: linux-work/drivers/video/fbmem.c
===================================================================
--- linux-work.orig/drivers/video/fbmem.c	2005-03-24 16:25:43.000000000 +1100
+++ linux-work/drivers/video/fbmem.c	2005-03-24 16:26:05.000000000 +1100
@@ -957,7 +957,9 @@
 	}
 #endif
 #elif defined(__powerpc__)
-	pgprot_val(vma->vm_page_prot) |= _PAGE_NO_CACHE|_PAGE_GUARDED;
+	vma->vm_page_prot = phys_mem_access_prot(file, off,
+						 vma->vm_end - vma->vm_start,
+						 vma->vm_page_prot);
 #elif defined(__alpha__)
 	/* Caching is off in the I/O space quadrant by design.  */
 #elif defined(__i386__) || defined(__x86_64__)
Index: linux-work/include/asm-ppc64/pgtable.h
===================================================================
--- linux-work.orig/include/asm-ppc64/pgtable.h	2005-03-24 16:25:43.000000000 +1100
+++ linux-work/include/asm-ppc64/pgtable.h	2005-03-24 16:26:05.000000000 +1100
@@ -472,6 +472,11 @@
  */
 #define pgprot_noncached(prot)	(__pgprot(pgprot_val(prot) | _PAGE_NO_CACHE | _PAGE_GUARDED))
 
+struct file;
+extern pgprot_t phys_mem_access_prot(struct file *file, unsigned long addr,
+				     unsigned long size, pgprot_t vma_prot);
+#define __HAVE_PHYS_MEM_ACCESS_PROT
+
 #define __HAVE_ARCH_PTE_SAME
 #define pte_same(A,B)	(((pte_val(A) ^ pte_val(B)) & ~_PAGE_HPTEFLAGS) == 0)
 
Index: linux-work/arch/ppc64/kernel/pci.c
===================================================================
--- linux-work.orig/arch/ppc64/kernel/pci.c	2005-03-24 16:25:43.000000000 +1100
+++ linux-work/arch/ppc64/kernel/pci.c	2005-03-24 17:10:21.000000000 +1100
@@ -210,6 +210,11 @@
 	struct pci_controller *hose, *tmp;
 	struct pci_bus *bus;
 
+	/* For now, override phys_mem_access_prot. If we need it,
+	 * later, we may move that initialization to each ppc_md
+	 */
+	ppc_md.phys_mem_access_prot = pci_phys_mem_access_prot;
+
 #ifdef CONFIG_PPC_ISERIES
 	iSeries_pcibios_init(); 
 #endif
@@ -330,25 +335,24 @@
  *
  * Returns negative error code on failure, zero on success.
  */
-static __inline__ int __pci_mmap_make_offset(struct pci_dev *dev,
-					     struct vm_area_struct *vma,
-					     enum pci_mmap_state mmap_state)
+static struct resource *__pci_mmap_make_offset(struct pci_dev *dev,
+					       unsigned long *offset,
+					       enum pci_mmap_state mmap_state)
 {
 	struct pci_controller *hose = pci_bus_to_host(dev->bus);
-	unsigned long offset = vma->vm_pgoff << PAGE_SHIFT;
 	unsigned long io_offset = 0;
 	int i, res_bit;
 
 	if (hose == 0)
-		return -EINVAL;		/* should never happen */
+		return NULL;		/* should never happen */
 
 	/* If memory, add on the PCI bridge address offset */
 	if (mmap_state == pci_mmap_mem) {
-		offset += hose->pci_mem_offset;
+		*offset += hose->pci_mem_offset;
 		res_bit = IORESOURCE_MEM;
 	} else {
 		io_offset = (unsigned long)hose->io_base_virt;
-		offset += io_offset;
+		*offset += io_offset;
 		res_bit = IORESOURCE_IO;
 	}
 
@@ -369,50 +373,106 @@
 			continue;
 
 		/* In the range of this resource? */
-		if (offset < (rp->start & PAGE_MASK) || offset > rp->end)
+		if (*offset < (rp->start & PAGE_MASK) || *offset > rp->end)
 			continue;
 
 		/* found it! construct the final physical address */
 		if (mmap_state == pci_mmap_io)
-			offset += hose->io_base_phys - io_offset;
-
-		vma->vm_pgoff = offset >> PAGE_SHIFT;
-		return 0;
+			*offset += hose->io_base_phys - io_offset;
+		return rp;
 	}
 
-	return -EINVAL;
-}
-
-/*
- * Set vm_flags of VMA, as appropriate for this architecture, for a pci device
- * mapping.
- */
-static __inline__ void __pci_mmap_set_flags(struct pci_dev *dev,
-					    struct vm_area_struct *vma,
-					    enum pci_mmap_state mmap_state)
-{
-	vma->vm_flags |= VM_SHM | VM_LOCKED | VM_IO;
+	return NULL;
 }
 
 /*
  * Set vm_page_prot of VMA, as appropriate for this architecture, for a pci
  * device mapping.
  */
-static __inline__ void __pci_mmap_set_pgprot(struct pci_dev *dev,
-					     struct vm_area_struct *vma,
-					     enum pci_mmap_state mmap_state,
-					     int write_combine)
-{
-	long prot = pgprot_val(vma->vm_page_prot);
+static pgprot_t __pci_mmap_set_pgprot(struct pci_dev *dev, struct resource *rp,
+				      pgprot_t protection,
+				      enum pci_mmap_state mmap_state,
+				      int write_combine)
+{
+	unsigned long prot = pgprot_val(protection);
+
+	/* Write combine is always 0 on non-memory space mappings. On
+	 * memory space, if the user didn't pass 1, we check for a
+	 * "prefetchable" resource. This is a bit hackish, but we use
+	 * this to workaround the inability of /sysfs to provide a write
+	 * combine bit
+	 */
+	if (mmap_state != pci_mmap_mem)
+		write_combine = 0;
+	else if (write_combine == 0) {
+		if (rp->flags & IORESOURCE_PREFETCH)
+			write_combine = 1;
+	}
 
 	/* XXX would be nice to have a way to ask for write-through */
 	prot |= _PAGE_NO_CACHE;
-	if (!write_combine)
+	if (write_combine)
+		prot &= ~_PAGE_GUARDED;
+	else
 		prot |= _PAGE_GUARDED;
-	vma->vm_page_prot = __pgprot(prot);
+
+	printk("PCI map for %s:%lx, prot: %lx\n", pci_name(dev), rp->start,
+	       prot);
+
+	return __pgprot(prot);
 }
 
 /*
+ * This one is used by /dev/mem and fbdev who have no clue about the
+ * PCI device, it tries to find the PCI device first and calls the
+ * above routine
+ */
+pgprot_t pci_phys_mem_access_prot(struct file *file,
+				  unsigned long offset,
+				  unsigned long size,
+				  pgprot_t protection)
+{
+	struct pci_dev *pdev = NULL;
+	struct resource *found = NULL;
+	unsigned long prot = pgprot_val(protection);
+	int i;
+
+	if (page_is_ram(offset >> PAGE_SHIFT))
+		return prot;
+
+	prot |= _PAGE_NO_CACHE | _PAGE_GUARDED;
+
+	for_each_pci_dev(pdev) {
+		for (i = 0; i <= PCI_ROM_RESOURCE; i++) {
+			struct resource *rp = &pdev->resource[i];
+			int flags = rp->flags;
+
+			/* Active and same type? */
+			if ((flags & IORESOURCE_MEM) == 0)
+				continue;
+			/* In the range of this resource? */
+			if (offset < (rp->start & PAGE_MASK) ||
+			    offset > rp->end)
+				continue;
+			found = rp;
+			break;
+		}
+		if (found)
+			break;
+	}
+	if (found) {
+		if (found->flags & IORESOURCE_PREFETCH)
+			prot &= ~_PAGE_GUARDED;
+		pci_dev_put(pdev);
+	}
+
+	DBG("non-PCI map for %lx, prot: %lx\n", offset, prot);
+
+	return __pgprot(prot);
+}
+
+
+/*
  * Perform the actual remap of the pages for a PCI device mapping, as
  * appropriate for this architecture.  The region in the process to map
  * is described by vm_start and vm_end members of VMA, the base physical
@@ -426,14 +486,19 @@
 			enum pci_mmap_state mmap_state,
 			int write_combine)
 {
+	unsigned long offset = vma->vm_pgoff << PAGE_SHIFT;
+	struct resource *rp;
 	int ret;
 
-	ret = __pci_mmap_make_offset(dev, vma, mmap_state);
-	if (ret < 0)
-		return ret;
+	rp = __pci_mmap_make_offset(dev, &offset, mmap_state);
+	if (rp == NULL)
+		return -EINVAL;
 
-	__pci_mmap_set_flags(dev, vma, mmap_state);
-	__pci_mmap_set_pgprot(dev, vma, mmap_state, write_combine);
+	vma->vm_pgoff = offset >> PAGE_SHIFT;
+	vma->vm_flags |= VM_SHM | VM_LOCKED | VM_IO;
+	vma->vm_page_prot = __pci_mmap_set_pgprot(dev, rp,
+						  vma->vm_page_prot,
+						  mmap_state, write_combine);
 
 	ret = remap_pfn_range(vma, vma->vm_start, vma->vm_pgoff,
 			       vma->vm_end - vma->vm_start, vma->vm_page_prot);
Index: linux-work/arch/ppc64/mm/init.c
===================================================================
--- linux-work.orig/arch/ppc64/mm/init.c	2005-03-24 16:25:43.000000000 +1100
+++ linux-work/arch/ppc64/mm/init.c	2005-03-24 16:26:05.000000000 +1100
@@ -912,3 +912,16 @@
 	if (!zero_cache)
 		panic("pgtable_cache_init(): could not create zero_cache!\n");
 }
+
+pgprot_t phys_mem_access_prot(struct file *file, unsigned long addr,
+			      unsigned long size, pgprot_t vma_prot)
+{
+	if (ppc_md.phys_mem_access_prot)
+		return ppc_md.phys_mem_access_prot(file, addr, size, vma_prot);
+	
+	if (!page_is_ram(addr >> PAGE_SHIFT))
+		vma_prot = __pgprot(pgprot_val(vma_prot)
+				    | _PAGE_GUARDED | _PAGE_NO_CACHE);
+	return vma_prot;
+}
+EXPORT_SYMBOL(phys_mem_access_prot);
Index: linux-work/include/asm-ppc64/pci.h
===================================================================
--- linux-work.orig/include/asm-ppc64/pci.h	2005-03-24 16:25:43.000000000 +1100
+++ linux-work/include/asm-ppc64/pci.h	2005-03-24 16:26:05.000000000 +1100
@@ -130,6 +130,13 @@
 
 extern void pcibios_add_platform_entries(struct pci_dev *dev);
 
+struct file;
+extern pgprot_t	pci_phys_mem_access_prot(struct file *file,
+					 unsigned long offset,
+					 unsigned long size,
+					 pgprot_t prot);
+
+
 #endif	/* __KERNEL__ */
 
 #endif /* __PPC64_PCI_H */
Index: linux-work/include/asm-ppc/pci.h
===================================================================
--- linux-work.orig/include/asm-ppc/pci.h	2005-03-24 16:25:14.000000000 +1100
+++ linux-work/include/asm-ppc/pci.h	2005-03-24 16:26:05.000000000 +1100
@@ -97,6 +97,12 @@
 
 extern void pcibios_add_platform_entries(struct pci_dev *dev);
 
+struct file;
+extern pgprot_t	pci_phys_mem_access_prot(struct file *file,
+					 unsigned long offset,
+					 unsigned long size,
+					 pgprot_t prot);
+
 #endif	/* __KERNEL__ */
 
 #endif /* __PPC_PCI_H */
Index: linux-work/arch/ppc/kernel/pci.c
===================================================================
--- linux-work.orig/arch/ppc/kernel/pci.c	2005-03-24 16:25:14.000000000 +1100
+++ linux-work/arch/ppc/kernel/pci.c	2005-03-24 17:10:08.000000000 +1100
@@ -1478,97 +1478,145 @@
 	return res->start;
 }
 
-/*
- * Platform support for /proc/bus/pci/X/Y mmap()s,
- * modelled on the sparc64 implementation by Dave Miller.
- *  -- paulus.
- */
 
-/*
- * Adjust vm_pgoff of VMA such that it is the physical page offset
- * corresponding to the 32-bit pci bus offset for DEV requested by the user.
- *
- * Basically, the user finds the base address for his device which he wishes
- * to mmap.  They read the 32-bit value from the config space base register,
- * add whatever PAGE_SIZE multiple offset they wish, and feed this into the
- * offset parameter of mmap on /proc/bus/pci/XXX for that device.
- *
- * Returns negative error code on failure, zero on success.
- */
-static __inline__ int
-__pci_mmap_make_offset(struct pci_dev *dev, struct vm_area_struct *vma,
-		       enum pci_mmap_state mmap_state)
-{
-	struct pci_controller *hose = (struct pci_controller *) dev->sysdata;
-	unsigned long offset = vma->vm_pgoff << PAGE_SHIFT;
-	unsigned long size = vma->vm_end - vma->vm_start;
-	unsigned long base;
-	struct resource *res;
-	int i;
-	int ret = -EINVAL;
+static struct resource *__pci_mmap_make_offset(struct pci_dev *dev,
+					       unsigned long *offset,
+					       enum pci_mmap_state mmap_state)
+{
+	struct pci_controller *hose = pci_bus_to_hose(dev->bus->number);
+	unsigned long io_offset = 0;
+	int i, res_bit;
 
 	if (hose == 0)
-		return -EINVAL;		/* should never happen */
-	if (offset + size <= offset)
-		return -EINVAL;
+		return NULL;		/* should never happen */
 
+	/* If memory, add on the PCI bridge address offset */
 	if (mmap_state == pci_mmap_mem) {
-		/* PCI memory space */
-		base = hose->pci_mem_offset;
-		for (i = 0; i < 3; ++i) {
-			res = &hose->mem_resources[i];
-			if (res->flags == 0)
-				continue;
-			if (offset >= res->start - base
-			    && offset + size - 1 <= res->end - base) {
-				ret = 0;
-				break;
-			}
-		}
-		offset += hose->pci_mem_offset;
+		*offset += hose->pci_mem_offset;
+		res_bit = IORESOURCE_MEM;
 	} else {
-		/* PCI I/O space */
-		base = (unsigned long)hose->io_base_virt - isa_io_base;
-		res = &hose->io_resource;
-		if (offset >= res->start - base
-		    && offset + size - 1 <= res->end - base)
-			ret = 0;
-		offset += hose->io_base_phys;
+		io_offset = (unsigned long)hose->io_base_virt;
+		*offset += io_offset;
+		res_bit = IORESOURCE_IO;
 	}
 
-	vma->vm_pgoff = offset >> PAGE_SHIFT;
-	return ret;
-}
+	/*
+	 * Check that the offset requested corresponds to one of the
+	 * resources of the device.
+	 */
+	for (i = 0; i <= PCI_ROM_RESOURCE; i++) {
+		struct resource *rp = &dev->resource[i];
+		int flags = rp->flags;
+
+		/* treat ROM as memory (should be already) */
+		if (i == PCI_ROM_RESOURCE)
+			flags |= IORESOURCE_MEM;
+
+		/* Active and same type? */
+		if ((flags & res_bit) == 0)
+			continue;
+
+		/* In the range of this resource? */
+		if (*offset < (rp->start & PAGE_MASK) || *offset > rp->end)
+			continue;
+
+		/* found it! construct the final physical address */
+		if (mmap_state == pci_mmap_io)
+			*offset += hose->io_base_phys - _IO_BASE;
+		return rp;
+	}
 
-/*
- * Set vm_flags of VMA, as appropriate for this architecture, for a pci device
- * mapping.
- */
-static __inline__ void
-__pci_mmap_set_flags(struct pci_dev *dev, struct vm_area_struct *vma,
-		     enum pci_mmap_state mmap_state)
-{
-	vma->vm_flags |= VM_SHM | VM_LOCKED | VM_IO;
+	return NULL;
 }
 
 /*
  * Set vm_page_prot of VMA, as appropriate for this architecture, for a pci
  * device mapping.
  */
-static __inline__ void
-__pci_mmap_set_pgprot(struct pci_dev *dev, struct vm_area_struct *vma,
-		      enum pci_mmap_state mmap_state, int write_combine)
-{
-	int prot = pgprot_val(vma->vm_page_prot);
+static pgprot_t __pci_mmap_set_pgprot(struct pci_dev *dev, struct resource *rp,
+				      pgprot_t protection,
+				      enum pci_mmap_state mmap_state,
+				      int write_combine)
+{
+	unsigned long prot = pgprot_val(protection);
+
+	/* Write combine is always 0 on non-memory space mappings. On
+	 * memory space, if the user didn't pass 1, we check for a
+	 * "prefetchable" resource. This is a bit hackish, but we use
+	 * this to workaround the inability of /sysfs to provide a write
+	 * combine bit
+	 */
+	if (mmap_state != pci_mmap_mem)
+		write_combine = 0;
+	else if (write_combine == 0) {
+		if (rp->flags & IORESOURCE_PREFETCH)
+			write_combine = 1;
+	}
 
 	/* XXX would be nice to have a way to ask for write-through */
 	prot |= _PAGE_NO_CACHE;
-	if (!write_combine)
+	if (write_combine)
+		prot &= ~_PAGE_GUARDED;
+	else
 		prot |= _PAGE_GUARDED;
-	vma->vm_page_prot = __pgprot(prot);
+
+	printk("PCI map for %s:%lx, prot: %lx\n", pci_name(dev), rp->start,
+	       prot);
+
+	return __pgprot(prot);
 }
 
 /*
+ * This one is used by /dev/mem and fbdev who have no clue about the
+ * PCI device, it tries to find the PCI device first and calls the
+ * above routine
+ */
+pgprot_t pci_phys_mem_access_prot(struct file *file,
+				  unsigned long offset,
+				  unsigned long size,
+				  pgprot_t protection)
+{
+	struct pci_dev *pdev = NULL;
+	struct resource *found = NULL;
+	unsigned long prot = pgprot_val(protection);
+	int i;
+
+	if (page_is_ram(offset >> PAGE_SHIFT))
+		return prot;
+
+	prot |= _PAGE_NO_CACHE | _PAGE_GUARDED;
+
+	for_each_pci_dev(pdev) {
+		for (i = 0; i <= PCI_ROM_RESOURCE; i++) {
+			struct resource *rp = &pdev->resource[i];
+			int flags = rp->flags;
+
+			/* Active and same type? */
+			if ((flags & IORESOURCE_MEM) == 0)
+				continue;
+			/* In the range of this resource? */
+			if (offset < (rp->start & PAGE_MASK) ||
+			    offset > rp->end)
+				continue;
+			found = rp;
+			break;
+		}
+		if (found)
+			break;
+	}
+	if (found) {
+		if (found->flags & IORESOURCE_PREFETCH)
+			prot &= ~_PAGE_GUARDED;
+		pci_dev_put(pdev);
+	}
+
+	DBG("non-PCI map for %lx, prot: %lx\n", offset, prot);
+
+	return __pgprot(prot);
+}
+
+
+/*
  * Perform the actual remap of the pages for a PCI device mapping, as
  * appropriate for this architecture.  The region in the process to map
  * is described by vm_start and vm_end members of VMA, the base physical
@@ -1582,14 +1630,19 @@
 			enum pci_mmap_state mmap_state,
 			int write_combine)
 {
+	unsigned long offset = vma->vm_pgoff << PAGE_SHIFT;
+	struct resource *rp;
 	int ret;
 
-	ret = __pci_mmap_make_offset(dev, vma, mmap_state);
-	if (ret < 0)
-		return ret;
+	rp = __pci_mmap_make_offset(dev, &offset, mmap_state);
+	if (rp == NULL)
+		return -EINVAL;
 
-	__pci_mmap_set_flags(dev, vma, mmap_state);
-	__pci_mmap_set_pgprot(dev, vma, mmap_state, write_combine);
+	vma->vm_pgoff = offset >> PAGE_SHIFT;
+	vma->vm_flags |= VM_SHM | VM_LOCKED | VM_IO;
+	vma->vm_page_prot = __pci_mmap_set_pgprot(dev, rp,
+						  vma->vm_page_prot,
+						  mmap_state, write_combine);
 
 	ret = remap_pfn_range(vma, vma->vm_start, vma->vm_pgoff,
 			       vma->vm_end - vma->vm_start, vma->vm_page_prot);
Index: linux-work/include/asm-ppc/pgtable.h
===================================================================
--- linux-work.orig/include/asm-ppc/pgtable.h	2005-03-24 16:25:14.000000000 +1100
+++ linux-work/include/asm-ppc/pgtable.h	2005-03-24 16:26:05.000000000 +1100
@@ -623,6 +623,11 @@
  */
 #define pgprot_noncached(prot)	(__pgprot(pgprot_val(prot) | _PAGE_NO_CACHE | _PAGE_GUARDED))
 
+struct file;
+extern pgprot_t phys_mem_access_prot(struct file *file, unsigned long addr,
+				     unsigned long size, pgprot_t vma_prot);
+#define __HAVE_PHYS_MEM_ACCESS_PROT
+
 #define __HAVE_ARCH_PTE_SAME
 #define pte_same(A,B)	(((pte_val(A) ^ pte_val(B)) & ~_PAGE_HASHPTE) == 0)
 
Index: linux-work/arch/ppc/platforms/chrp_setup.c
===================================================================
--- linux-work.orig/arch/ppc/platforms/chrp_setup.c	2005-03-24 16:25:14.000000000 +1100
+++ linux-work/arch/ppc/platforms/chrp_setup.c	2005-03-24 16:26:05.000000000 +1100
@@ -527,6 +527,8 @@
 
 	ppc_md.init           = chrp_init2;
 
+	ppc_md.phys_mem_access_prot = pci_phys_mem_access_prot;
+
 	ppc_md.restart        = chrp_restart;
 	ppc_md.power_off      = chrp_power_off;
 	ppc_md.halt           = chrp_halt;
Index: linux-work/include/asm-ppc/page.h
===================================================================
--- linux-work.orig/include/asm-ppc/page.h	2005-03-24 16:25:14.000000000 +1100
+++ linux-work/include/asm-ppc/page.h	2005-03-24 16:26:05.000000000 +1100
@@ -137,6 +137,8 @@
 #define ___va(paddr) ((paddr)+PPC_MEMOFFSET)
 #endif
 
+extern int page_is_ram(unsigned long pfn);
+
 #define __pa(x) ___pa((unsigned long)(x))
 #define __va(x) ((void *)(___va((unsigned long)(x))))
 
Index: linux-work/include/asm-ppc/machdep.h
===================================================================
--- linux-work.orig/include/asm-ppc/machdep.h	2005-03-24 16:25:14.000000000 +1100
+++ linux-work/include/asm-ppc/machdep.h	2005-03-24 16:26:05.000000000 +1100
@@ -6,6 +6,7 @@
 #include <linux/init.h>
 
 #include <asm/setup.h>
+#include <asm/page.h>
 
 #ifdef CONFIG_APUS
 #include <asm-m68k/machdep.h>
@@ -15,6 +16,7 @@
 struct pci_bus;	
 struct pci_dev;
 struct seq_file;
+struct file;
 
 /* We export this macro for external modules like Alsa to know if
  * ppc_md.feature_call is implemented or not
@@ -93,6 +95,12 @@
 	/* Called at then very end of pcibios_init() */
 	void (*pcibios_after_init)(void);
 
+	/* Get access protection for /dev/mem */
+	pgprot_t	(*phys_mem_access_prot)(struct file *file,
+						unsigned long offset,
+						unsigned long size,
+						pgprot_t vma_prot);
+
 	/* this is for modules, since _machine can be a define -- Cort */
 	int ppc_machine;
 
Index: linux-work/arch/ppc/platforms/prep_setup.c
===================================================================
--- linux-work.orig/arch/ppc/platforms/prep_setup.c	2005-03-24 16:25:14.000000000 +1100
+++ linux-work/arch/ppc/platforms/prep_setup.c	2005-03-24 16:26:05.000000000 +1100
@@ -1144,6 +1144,8 @@
 	/* this gets changed later on if we have an OpenPIC -- Cort */
 	ppc_md.get_irq        = i8259_irq;
 
+	ppc_md.phys_mem_access_prot = pci_phys_mem_access_prot;
+
 	ppc_md.restart        = prep_restart;
 	ppc_md.power_off      = NULL; /* set in prep_setup_arch() */
 	ppc_md.halt           = prep_halt;
Index: linux-work/arch/ppc/platforms/pmac_setup.c
===================================================================
--- linux-work.orig/arch/ppc/platforms/pmac_setup.c	2005-03-24 16:25:14.000000000 +1100
+++ linux-work/arch/ppc/platforms/pmac_setup.c	2005-03-24 16:26:05.000000000 +1100
@@ -669,6 +669,7 @@
 	ppc_md.pcibios_fixup  = pmac_pcibios_fixup;
 	ppc_md.pcibios_enable_device_hook = pmac_pci_enable_device_hook;
 	ppc_md.pcibios_after_init = pmac_pcibios_after_init;
+	ppc_md.phys_mem_access_prot = pci_phys_mem_access_prot;
 
 	ppc_md.restart        = pmac_restart;
 	ppc_md.power_off      = pmac_power_off;
Index: linux-work/arch/ppc/mm/init.c
===================================================================
--- linux-work.orig/arch/ppc/mm/init.c	2005-03-24 16:25:14.000000000 +1100
+++ linux-work/arch/ppc/mm/init.c	2005-03-24 16:44:42.000000000 +1100
@@ -641,3 +641,27 @@
 	}
 #endif
 }
+
+/*
+ * This is called by /dev/mem to know if a given address has to
+ * be mapped non-cacheable or not
+ */
+int page_is_ram(unsigned long pfn)
+{
+	unsigned long paddr = (pfn << PAGE_SHIFT);
+
+	return paddr < __pa(high_memory);
+}
+
+pgprot_t phys_mem_access_prot(struct file *file, unsigned long addr,
+			      unsigned long size, pgprot_t vma_prot)
+{
+	if (ppc_md.phys_mem_access_prot)
+		return ppc_md.phys_mem_access_prot(file, addr, size, vma_prot);
+	
+	if (!page_is_ram(addr >> PAGE_SHIFT))
+		vma_prot = __pgprot(pgprot_val(vma_prot)
+				    | _PAGE_GUARDED | _PAGE_NO_CACHE);
+	return vma_prot;
+}
+EXPORT_SYMBOL(phys_mem_access_prot);


