Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266968AbSLDRjz>; Wed, 4 Dec 2002 12:39:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266970AbSLDRjz>; Wed, 4 Dec 2002 12:39:55 -0500
Received: from host194.steeleye.com ([66.206.164.34]:18950 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S266968AbSLDRjr>; Wed, 4 Dec 2002 12:39:47 -0500
Message-Id: <200212041747.gB4HlEF03005@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: linux-kernel@vger.kernel.org
cc: James.Bottomley@SteelEye.com
Subject: [RFC] generic device DMA implementation
Mime-Version: 1.0
Content-Type: multipart/mixed ;
	boundary="==_Exmh_21426993290"
Date: Wed, 04 Dec 2002 11:47:14 -0600
From: James Bottomley <James.Bottomley@steeleye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multipart MIME message.

--==_Exmh_21426993290
Content-Type: text/plain; charset=us-ascii

Currently our only DMA API is highly PCI specific (making any non-pci bus with 
a DMA controller create fake PCI devices to help it function).

Now that we have the generic device model, it should be equally possible to 
rephrase the entire API for generic devices instead of pci_devs.

This patch does just that (for x86---although I also have working code for 
parisc, that's where I actually tested the DMA capability).

The API is substantially the same as the PCI DMA one, with one important 
exception with regard to consistent memory:

The PCI api has pci_alloc_consistent which allocates only consistent memory 
and fails the allocation if none is available thus leading to driver writers 
who might need to function with inconsistent memory to detect this and employ 
a fallback strategy.

The new DMA API allows a driver to advertise its level of consistent memory 
compliance to dma_alloc_consistent.  There are essentially two levels:

- I only work with consistent memory, fail if I cannot get it, or
- I can work with inconsistent memory, try consistent first but return 
inconsistent if it's not available.

The idea is that the memory type can be coded into dma_addr_t which the 
subsequent memory sync operations can use to determine whether 
wback/invalidate should be a nop or not.

Using this scheme allows me to eliminate all the inconsistent memory fallbacks 
from my drivers.

Comments welcome.

James


--==_Exmh_21426993290
Content-Type: text/plain ; name="tmp.diff"; charset=us-ascii
Content-Description: tmp.diff
Content-Disposition: attachment; filename="tmp.diff"

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.926   -> 1.929  
#	arch/i386/kernel/pci-dma.c	1.8     -> 1.9    
#	   drivers/pci/pci.c	1.50    -> 1.51   
#	include/asm-i386/pci.h	1.17    -> 1.18   
#	 include/linux/pci.h	1.52    -> 1.54   
#	               (new)	        -> 1.3     include/asm-i386/dma-mapping.h
#	               (new)	        -> 1.1     include/asm-generic/dma-mapping.h
#	               (new)	        -> 1.1     include/linux/dma-mapping.h
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/12/03	jejb@raven.il.steeleye.com	1.927
# Implement a generic device based DMA API
# 
# implement a DMA mapping API based on generic devices instead of
# PCI ones.
# 
# The API is almost identical to the PCI one except for
# 
# - the dma_alloc_consistent takes a conformance level, so the driver
# may choose to support only consistent or also non-consistent memory.
# --------------------------------------------
# 02/12/03	jejb@raven.il.steeleye.com	1.928
# Update to include dma_supported in the API
# --------------------------------------------
# 02/12/03	jejb@raven.il.steeleye.com	1.929
# minor fixes to x86 dma implementation
# --------------------------------------------
#
diff -Nru a/arch/i386/kernel/pci-dma.c b/arch/i386/kernel/pci-dma.c
--- a/arch/i386/kernel/pci-dma.c	Wed Dec  4 11:25:59 2002
+++ b/arch/i386/kernel/pci-dma.c	Wed Dec  4 11:25:59 2002
@@ -13,13 +13,17 @@
 #include <linux/pci.h>
 #include <asm/io.h>
 
-void *pci_alloc_consistent(struct pci_dev *hwdev, size_t size,
-			   dma_addr_t *dma_handle)
+void *dma_alloc_consistent(struct device *dev, size_t size,
+			   dma_addr_t *dma_handle,
+			   enum dma_conformance_level level)
 {
 	void *ret;
 	int gfp = GFP_ATOMIC;
 
-	if (hwdev == NULL || ((u32)hwdev->dma_mask != 0xffffffff))
+	if(level == DMA_CONFORMANCE_NONE)
+		return NULL;
+
+	if (dev == NULL || ((u32)*dev->dma_mask != 0xffffffff))
 		gfp |= GFP_DMA;
 	ret = (void *)__get_free_pages(gfp, get_order(size));
 
@@ -30,7 +34,7 @@
 	return ret;
 }
 
-void pci_free_consistent(struct pci_dev *hwdev, size_t size,
+void dma_free_consistent(struct device *dev, size_t size,
 			 void *vaddr, dma_addr_t dma_handle)
 {
 	free_pages((unsigned long)vaddr, get_order(size));
diff -Nru a/drivers/pci/pci.c b/drivers/pci/pci.c
--- a/drivers/pci/pci.c	Wed Dec  4 11:25:59 2002
+++ b/drivers/pci/pci.c	Wed Dec  4 11:25:59 2002
@@ -680,7 +680,7 @@
 int
 pci_set_dma_mask(struct pci_dev *dev, u64 mask)
 {
-	if (!pci_dma_supported(dev, mask))
+	if (!dma_supported(&dev->dev, mask))
 		return -EIO;
 
 	dev->dma_mask = mask;
diff -Nru a/include/asm-generic/dma-mapping.h b/include/asm-generic/dma-mapping.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/include/asm-generic/dma-mapping.h	Wed Dec  4 11:25:59 2002
@@ -0,0 +1,29 @@
+#ifndef _ASM_GENERIC_DMA_MAPPING_H
+#define _ASM_GENERIC_DMA_MAPPING_H
+
+int dma_set_mask(struct device *dev, u64 dma_mask);
+void *dma_alloc_consistent(struct device *dev, size_t size,
+			   dma_addr_t *dma_handle,
+			   enum dma_conformance_level level);
+enum dma_conformance_level dma_get_conformance(dma_addr_t dma_handle);
+void dma_free_consistent(struct device *dev, size_t size, void *cpu_addr,
+			  dma_addr_t dma_handle);
+dma_addr_t dma_map_single(struct device *dev, void *cpu_addr, size_t size,
+			   enum dma_data_direction direction);
+void dma_unmap_single(struct device *dev, dma_addr_t dma_addr, size_t size,
+		      enum dma_data_direction direction);
+dma_addr_t dma_map_page(struct device *dev, struct page *page,
+			unsigned long offset, size_t size,
+			enum dma_data_direction direction);
+void dma_unmap_page(struct device *dev, dma_addr_t dma_address, size_t size,
+		    enum dma_data_direction direction);
+int dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
+	       enum dma_data_direction direction);
+void dma_unmap_sg(struct device *dev, struct scatterlist *sg, int nhwentries,
+		  enum dma_data_direction direction);
+void dma_sync_single(struct device *dev, dma_addr_t dma_handle, size_t size,
+		     enum dma_data_direction direction);
+void dma_sync_sg(struct device *dev, struct scatterlist *sg, int nelems,
+		 enum dma_data_direction direction);
+#endif
+
diff -Nru a/include/asm-i386/dma-mapping.h b/include/asm-i386/dma-mapping.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/include/asm-i386/dma-mapping.h	Wed Dec  4 11:25:59 2002
@@ -0,0 +1,113 @@
+#ifndef _ASM_I386_DMA_MAPPING_H
+#define _ASM_I386_DMA_MAPPING_H
+
+void *dma_alloc_consistent(struct device *dev, size_t size,
+			   dma_addr_t *dma_handle,
+			   enum dma_conformance_level level);
+
+void dma_free_consistent(struct device *dev, size_t size,
+			 void *vaddr, dma_addr_t dma_handle);
+
+static inline dma_addr_t
+dma_map_single(struct device *dev, void *ptr, size_t size,
+	       enum dma_data_direction direction)
+{
+	BUG_ON(direction == DMA_NONE);
+	flush_write_buffers();
+	return virt_to_phys(ptr);
+}
+
+static inline void
+dma_unmap_single(struct device *dev, dma_addr_t dma_addr, size_t size,
+		 enum dma_data_direction direction)
+{
+	BUG_ON(direction == DMA_NONE);
+}
+
+static inline int
+dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
+	   enum dma_data_direction direction)
+{
+	int i;
+
+	BUG_ON(direction == DMA_NONE);
+
+	for (i = 0; i < nents; i++ ) {
+		BUG_ON(!sg[i].page);
+
+		sg[i].dma_address = page_to_phys(sg[i].page) + sg[i].offset;
+	}
+
+	flush_write_buffers();
+	return nents;
+}
+
+static inline dma_addr_t
+dma_map_page(struct device *dev, struct page *page, unsigned long offset,
+	     size_t size, enum dma_data_direction direction)
+{
+	BUG_ON(direction == DMA_NONE);
+	return (dma_addr_t)(page_to_pfn(page)) * PAGE_SIZE + offset;
+}
+
+static inline void
+dma_unmap_page(struct device *dev, dma_addr_t dma_address, size_t size,
+	       enum dma_data_direction direction)
+{
+	BUG_ON(direction == DMA_NONE);
+}
+
+
+static inline void
+dma_unmap_sg(struct device *dev, struct scatterlist *sg, int nhwentries,
+	     enum dma_data_direction direction)
+{
+	BUG_ON(direction == DMA_NONE);
+}
+
+static inline void
+dma_sync_single(struct device *dev, dma_addr_t dma_handle, size_t size,
+		enum dma_data_direction direction)
+{
+	flush_write_buffers();
+}
+
+static inline void
+dma_sync_sg(struct device *dev, struct scatterlist *sg, int nelems,
+		 enum dma_data_direction direction)
+{
+	flush_write_buffers();
+}
+
+static inline enum dma_conformance_level
+dma_get_conformance(dma_addr_t dma_handle)
+{
+	return DMA_CONFORMANCE_CONSISTENT;
+}
+
+static inline int
+dma_supported(struct device *dev, u64 mask)
+{
+        /*
+         * we fall back to GFP_DMA when the mask isn't all 1s,
+         * so we can't guarantee allocations that must be
+         * within a tighter range than GFP_DMA..
+         */
+        if(mask < 0x00ffffff)
+                return 0;
+
+	return 1;
+}
+
+static inline int
+dma_set_mask(struct device *dev, u64 mask)
+{
+	if(!dev->dma_mask || !dma_supported(dev, mask))
+		return -EIO;
+
+	*dev->dma_mask = mask;
+
+	return 0;
+}
+
+#endif
diff -Nru a/include/asm-i386/pci.h b/include/asm-i386/pci.h
--- a/include/asm-i386/pci.h	Wed Dec  4 11:25:59 2002
+++ b/include/asm-i386/pci.h	Wed Dec  4 11:25:59 2002
@@ -6,6 +6,9 @@
 #ifdef __KERNEL__
 #include <linux/mm.h>		/* for struct page */
 
+/* we support the new DMA API, but still provide the old one */
+#define PCI_NEW_DMA_COMPAT_API	1
+
 /* Can be used to override the logic in pci_scan_bus for skipping
    already-configured bus numbers - to be used for buggy BIOSes
    or architectures with incomplete PCI setup by the loader */
@@ -46,78 +49,6 @@
  */
 #define PCI_DMA_BUS_IS_PHYS	(1)
 
-/* Allocate and map kernel buffer using consistent mode DMA for a device.
- * hwdev should be valid struct pci_dev pointer for PCI devices,
- * NULL for PCI-like buses (ISA, EISA).
- * Returns non-NULL cpu-view pointer to the buffer if successful and
- * sets *dma_addrp to the pci side dma address as well, else *dma_addrp
- * is undefined.
- */
-extern void *pci_alloc_consistent(struct pci_dev *hwdev, size_t size,
-				  dma_addr_t *dma_handle);
-
-/* Free and unmap a consistent DMA buffer.
- * cpu_addr is what was returned from pci_alloc_consistent,
- * size must be the same as what as passed into pci_alloc_consistent,
- * and likewise dma_addr must be the same as what *dma_addrp was set to.
- *
- * References to the memory and mappings associated with cpu_addr/dma_addr
- * past this call are illegal.
- */
-extern void pci_free_consistent(struct pci_dev *hwdev, size_t size,
-				void *vaddr, dma_addr_t dma_handle);
-
-/* Map a single buffer of the indicated size for DMA in streaming mode.
- * The 32-bit bus address to use is returned.
- *
- * Once the device is given the dma address, the device owns this memory
- * until either pci_unmap_single or pci_dma_sync_single is performed.
- */
-static inline dma_addr_t pci_map_single(struct pci_dev *hwdev, void *ptr,
-					size_t size, int direction)
-{
-	if (direction == PCI_DMA_NONE)
-		BUG();
-	flush_write_buffers();
-	return virt_to_phys(ptr);
-}
-
-/* Unmap a single streaming mode DMA translation.  The dma_addr and size
- * must match what was provided for in a previous pci_map_single call.  All
- * other usages are undefined.
- *
- * After this call, reads by the cpu to the buffer are guarenteed to see
- * whatever the device wrote there.
- */
-static inline void pci_unmap_single(struct pci_dev *hwdev, dma_addr_t dma_addr,
-				    size_t size, int direction)
-{
-	if (direction == PCI_DMA_NONE)
-		BUG();
-	/* Nothing to do */
-}
-
-/*
- * pci_{map,unmap}_single_page maps a kernel page to a dma_addr_t. identical
- * to pci_map_single, but takes a struct page instead of a virtual address
- */
-static inline dma_addr_t pci_map_page(struct pci_dev *hwdev, struct page *page,
-				      unsigned long offset, size_t size, int direction)
-{
-	if (direction == PCI_DMA_NONE)
-		BUG();
-
-	return (dma_addr_t)(page_to_pfn(page)) * PAGE_SIZE + offset;
-}
-
-static inline void pci_unmap_page(struct pci_dev *hwdev, dma_addr_t dma_address,
-				  size_t size, int direction)
-{
-	if (direction == PCI_DMA_NONE)
-		BUG();
-	/* Nothing to do */
-}
-
 /* pci_unmap_{page,single} is a nop so... */
 #define DECLARE_PCI_UNMAP_ADDR(ADDR_NAME)
 #define DECLARE_PCI_UNMAP_LEN(LEN_NAME)
@@ -126,84 +57,6 @@
 #define pci_unmap_len(PTR, LEN_NAME)		(0)
 #define pci_unmap_len_set(PTR, LEN_NAME, VAL)	do { } while (0)
 
-/* Map a set of buffers described by scatterlist in streaming
- * mode for DMA.  This is the scather-gather version of the
- * above pci_map_single interface.  Here the scatter gather list
- * elements are each tagged with the appropriate dma address
- * and length.  They are obtained via sg_dma_{address,length}(SG).
- *
- * NOTE: An implementation may be able to use a smaller number of
- *       DMA address/length pairs than there are SG table elements.
- *       (for example via virtual mapping capabilities)
- *       The routine returns the number of addr/length pairs actually
- *       used, at most nents.
- *
- * Device ownership issues as mentioned above for pci_map_single are
- * the same here.
- */
-static inline int pci_map_sg(struct pci_dev *hwdev, struct scatterlist *sg,
-			     int nents, int direction)
-{
-	int i;
-
-	if (direction == PCI_DMA_NONE)
-		BUG();
-
-	for (i = 0; i < nents; i++ ) {
-		if (!sg[i].page)
-			BUG();
-
-		sg[i].dma_address = page_to_phys(sg[i].page) + sg[i].offset;
-	}
-
-	flush_write_buffers();
-	return nents;
-}
-
-/* Unmap a set of streaming mode DMA translations.
- * Again, cpu read rules concerning calls here are the same as for
- * pci_unmap_single() above.
- */
-static inline void pci_unmap_sg(struct pci_dev *hwdev, struct scatterlist *sg,
-				int nents, int direction)
-{
-	if (direction == PCI_DMA_NONE)
-		BUG();
-	/* Nothing to do */
-}
-
-/* Make physical memory consistent for a single
- * streaming mode DMA translation after a transfer.
- *
- * If you perform a pci_map_single() but wish to interrogate the
- * buffer using the cpu, yet do not wish to teardown the PCI dma
- * mapping, you must call this function before doing so.  At the
- * next point you give the PCI dma address back to the card, the
- * device again owns the buffer.
- */
-static inline void pci_dma_sync_single(struct pci_dev *hwdev,
-				       dma_addr_t dma_handle,
-				       size_t size, int direction)
-{
-	if (direction == PCI_DMA_NONE)
-		BUG();
-	flush_write_buffers();
-}
-
-/* Make physical memory consistent for a set of streaming
- * mode DMA translations after a transfer.
- *
- * The same as pci_dma_sync_single but for a scatter-gather list,
- * same rules and usage.
- */
-static inline void pci_dma_sync_sg(struct pci_dev *hwdev,
-				   struct scatterlist *sg,
-				   int nelems, int direction)
-{
-	if (direction == PCI_DMA_NONE)
-		BUG();
-	flush_write_buffers();
-}
 
 /* Return whether the given PCI device DMA address mask can
  * be supported properly.  For example, if your device can
diff -Nru a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/include/linux/dma-mapping.h	Wed Dec  4 11:25:59 2002
@@ -0,0 +1,32 @@
+#ifndef _ASM_LINUX_DMA_MAPPING_H
+#define _ASM_LINUX_DMA_MAPPING_H
+
+/* This is the level of conformance required for consistent allocation
+ *
+ * DMA_CONFORMANCE_NONE - debugging: always fail consistent allocation
+ * DMA_CONFORMANCE_CONSISTENT - only allocate consistent memory.  Fail
+ *	if consistent memory cannot be allocated.
+ * DMA_CONFORMANCE_NON_CONSISTENT - driver has full writeback/invalidate
+ *	compliance.  Return non-consistent memory if consistent cannot be
+ *	allocated.
+ */
+enum dma_conformance_level {
+	DMA_CONFORMANCE_NONE,
+	DMA_CONFORMANCE_CONSISTENT,
+	DMA_CONFORMANCE_NON_CONSISTENT,
+};
+
+/* These definitions mirror those in pci.h, so they can be used
+ * interchangeably with their PCI_ counterparts */
+enum dma_data_direction {
+	DMA_BIDIRECTIONAL = 0,
+	DMA_TO_DEVICE = 1,
+	DMA_FROM_DEVICE = 2,
+	DMA_NONE = 3,
+};
+
+#include <asm/dma-mapping.h>
+
+#endif
+
+
diff -Nru a/include/linux/pci.h b/include/linux/pci.h
--- a/include/linux/pci.h	Wed Dec  4 11:25:59 2002
+++ b/include/linux/pci.h	Wed Dec  4 11:25:59 2002
@@ -788,5 +788,95 @@
 #define PCIPCI_VIAETBF		8
 #define PCIPCI_VSFX		16
 
+#include <linux/dma-mapping.h>
+
+/* If you define this macro it means you support the new DMA API.
+ *
+ * The old pci_dma... API is deprecated, but for now it is simply translated
+ * into the new generic device based API.
+ */
+#ifdef PCI_NEW_DMA_COMPAT_API
+
+/* note pci_set_dma_mask isn't here, since it's a public function
+ * exported from drivers/pci, use dma_supported instead */
+
+static inline int
+pci_dma_supported(struct pci_dev *hwdev, u64 mask)
+{
+	return dma_supported(&hwdev->dev, mask);
+}
+
+static inline void *
+pci_alloc_consistent(struct pci_dev *hwdev, size_t size,
+		     dma_addr_t *dma_handle)
+{
+	return dma_alloc_consistent(&hwdev->dev, size, dma_handle,
+				    DMA_CONFORMANCE_CONSISTENT);
+}
+
+static inline void
+pci_free_consistent(struct pci_dev *hwdev, size_t size,
+		    void *vaddr, dma_addr_t dma_handle)
+{
+	dma_free_consistent(&hwdev->dev, size, vaddr, dma_handle);
+}
+
+static inline dma_addr_t
+pci_map_single(struct pci_dev *hwdev, void *ptr, size_t size, int direction)
+{
+	return dma_map_single(&hwdev->dev, ptr, size, (enum dma_data_direction)direction);
+}
+
+static inline void
+pci_unmap_single(struct pci_dev *hwdev, dma_addr_t dma_addr,
+		 size_t size, int direction)
+{
+	dma_unmap_single(&hwdev->dev, dma_addr, size, (enum dma_data_direction)direction);
+}
+
+static inline dma_addr_t
+pci_map_page(struct pci_dev *hwdev, struct page *page,
+	     unsigned long offset, size_t size, int direction)
+{
+	return dma_map_page(&hwdev->dev, page, offset, size, (enum dma_data_direction)direction);
+}
+
+static inline void
+pci_unmap_page(struct pci_dev *hwdev, dma_addr_t dma_address,
+	       size_t size, int direction)
+{
+	dma_unmap_page(&hwdev->dev, dma_address, size, (enum dma_data_direction)direction);
+}
+
+static inline int
+pci_map_sg(struct pci_dev *hwdev, struct scatterlist *sg,
+	   int nents, int direction)
+{
+	return dma_map_sg(&hwdev->dev, sg, nents, (enum dma_data_direction)direction);
+}
+
+static inline void
+pci_unmap_sg(struct pci_dev *hwdev, struct scatterlist *sg,
+	     int nents, int direction)
+{
+	dma_unmap_sg(&hwdev->dev, sg, nents, (enum dma_data_direction)direction);
+}
+
+static inline void
+pci_dma_sync_single(struct pci_dev *hwdev, dma_addr_t dma_handle,
+		    size_t size, int direction)
+{
+	dma_sync_single(&hwdev->dev, dma_handle, size, (enum dma_data_direction)direction);
+}
+
+static inline void
+pci_dma_sync_sg(struct pci_dev *hwdev, struct scatterlist *sg,
+		int nelems, int direction)
+{
+	dma_sync_sg(&hwdev->dev, sg, nelems, (enum dma_data_direction)direction);
+}
+
+#endif
+
 #endif /* __KERNEL__ */
 #endif /* LINUX_PCI_H */

--==_Exmh_21426993290--


