Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262604AbSLRCyV>; Tue, 17 Dec 2002 21:54:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266979AbSLRCyV>; Tue, 17 Dec 2002 21:54:21 -0500
Received: from host194.steeleye.com ([66.206.164.34]:23052 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S262604AbSLRCyG>; Tue, 17 Dec 2002 21:54:06 -0500
Message-Id: <200212180301.gBI31wE06794@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: linux-kernel@vger.kernel.org
cc: James.Bottomley@SteelEye.com
Subject: [RFT][PATCH] generic device DMA implementation
Mime-Version: 1.0
Content-Type: multipart/mixed ;
	boundary="==_Exmh_11357881300"
Date: Tue, 17 Dec 2002 21:01:57 -0600
From: James Bottomley <James.Bottomley@steeleye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multipart MIME message.

--==_Exmh_11357881300
Content-Type: text/plain; charset=us-ascii

The attached should represent close to final form for the generic DMA API.  It 
includes documentation (surprise!) and and implementation in terms of the pci_ 
API for every arch (apart from parisc, which will be submitted later).

I've folded in the feedback from the previous thread.  Hopefully, this should 
be ready for inclusion.  If people could test it on x86 and other 
architectures, I'd be grateful.

comments and feedback from testing welcome.

James


--==_Exmh_11357881300
Content-Type: text/plain ; name="tmp.diff"; charset=us-ascii
Content-Description: tmp.diff
Content-Disposition: attachment; filename="tmp.diff"

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.859   -> 1.861  
#	arch/i386/kernel/pci-dma.c	1.8     -> 1.10   
#	   drivers/pci/pci.c	1.51    -> 1.52   
#	include/asm-i386/pci.h	1.17    -> 1.18   
#	 include/linux/pci.h	1.55    -> 1.56   
#	Documentation/DMA-mapping.txt	1.13    -> 1.14   
#	arch/i386/kernel/i386_ksyms.c	1.40    -> 1.41   
#	               (new)	        -> 1.1     include/asm-s390x/dma-mapping.h
#	               (new)	        -> 1.1     include/asm-arm/dma-mapping.h
#	               (new)	        -> 1.1     include/asm-sparc/dma-mapping.h
#	               (new)	        -> 1.1     include/asm-cris/dma-mapping.h
#	               (new)	        -> 1.1     include/asm-sh/dma-mapping.h
#	               (new)	        -> 1.1     include/asm-ppc64/dma-mapping.h
#	               (new)	        -> 1.1     include/asm-m68knommu/dma-mapping.h
#	               (new)	        -> 1.1     Documentation/DMA-API.txt
#	               (new)	        -> 1.1     include/asm-um/dma-mapping.h
#	               (new)	        -> 1.1     include/asm-ia64/dma-mapping.h
#	               (new)	        -> 1.3     include/asm-generic/dma-mapping.h
#	               (new)	        -> 1.1     include/asm-alpha/dma-mapping.h
#	               (new)	        -> 1.2     include/linux/dma-mapping.h
#	               (new)	        -> 1.1     include/asm-ppc/dma-mapping.h
#	               (new)	        -> 1.1     include/asm-s390/dma-mapping.h
#	               (new)	        -> 1.5     include/asm-i386/dma-mapping.h
#	               (new)	        -> 1.1     include/asm-sparc64/dma-mapping.h
#	               (new)	        -> 1.1     include/asm-m68k/dma-mapping.h
#	               (new)	        -> 1.1     include/asm-mips/dma-mapping.h
#	               (new)	        -> 1.1     include/asm-x86_64/dma-mapping.h
#	               (new)	        -> 1.1     include/asm-v850/dma-mapping.h
#	               (new)	        -> 1.1     include/asm-mips64/dma-mapping.h
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/12/09	jejb@mulgrave.(none)	1.860
# Merge ssh://raven/BK/dma-generic-device-2.5.50
# into mulgrave.(none):/home/jejb/BK/dma-generic-device-2.5
# --------------------------------------------
# 02/12/16	jejb@mulgrave.(none)	1.861
# Documentation complete
# --------------------------------------------
#
diff -Nru a/Documentation/DMA-API.txt b/Documentation/DMA-API.txt
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/Documentation/DMA-API.txt	Tue Dec 17 20:49:32 2002
@@ -0,0 +1,325 @@
+               Dynamic DMA mapping using the generic device
+               ============================================
+
+        James E.J. Bottomley <James.Bottomley@HansenPartnership.com>
+
+This document describes the DMA API.  For a more gentle introduction
+phrased in terms of the pci_ equivalents (and actual examples) see
+DMA-mapping.txt
+
+This API is split into two pieces.  Part I describes the API and the
+corresponding pci_ API.  Part II describes the extensions to the API
+for supporting non-consistent memory machines.  Unless you know that
+your driver absolutely has to support non-consistent platforms (this
+is usually only legacy platforms) you should only use the API
+described in part I.
+
+Part I - pci_ and dma_ Equivalent API 
+-------------------------------------
+
+To get the pci_ API, you must #include <linux/pci.h>
+To get the dma_ API, you must #include <linux/dma-mapping.h>
+
+void *
+dma_alloc_consistent(struct device *dev, size_t size,
+			     dma_addr_t *dma_handle)
+void *
+pci_alloc_consistent(struct pci_dev *dev, size_t size,
+			     dma_addr_t *dma_handle)
+
+Consistent memory is memory for which a write by either the device or
+the processor can immediately be read by the processor or device
+without having to worry about caching effects.
+
+This routine allocates a region of <size> bytes of consistent memory.
+it also returns a <dma_handle> which may be cast to an unsigned
+integer the same width as the bus and used as the physical address
+base of the region.
+
+Returns: a pointer to the allocated region (in the processor's virtual
+address space) or NULL if the allocation failed.
+
+Note: consistent memory can be expensive on some platforms, and the
+minimum allocation length may be as big as a page, so you should
+consolidate your requests for consistent memory as much as possible.
+
+void
+dma_free_consistent(struct device *dev, size_t size, void *cpu_addr
+			   dma_addr_t dma_handle)
+void
+pci_free_consistent(struct pci_dev *dev, size_t size, void *cpu_addr
+			   dma_addr_t dma_handle)
+
+Free the region of consistent memory you previously allocated.  dev,
+size and dma_handle must all be the same as those passed into the
+consistent allocate.  cpu_addr must be the virtual address returned by
+the consistent allocate
+
+int
+dma_supported(struct device *dev, u64 mask)
+int
+pci_dma_supported(struct device *dev, u64 mask)
+
+Checks to see if the device can support DMA to the memory described by
+mask.
+
+Returns: 1 if it can and 0 if it can't.
+
+Notes: This routine merely tests to see if the mask is possible.  It
+won't change the current mask settings.  It is more intended as an
+internal API for use by the platform than an external API for use by
+driver writers.
+
+int
+dma_set_mask(struct device *dev, u64 mask)
+int
+pci_dma_set_mask(struct pci_device *dev, u64 mask)
+
+Checks to see if the mask is possible and updates the device
+parameters if it is.
+
+Returns: 1 if successful and 0 if not
+
+dma_addr_t
+dma_map_single(struct device *dev, void *cpu_addr, size_t size,
+		      enum dma_data_direction direction)
+dma_addr_t
+pci_map_single(struct device *dev, void *cpu_addr, size_t size,
+		      int direction)
+
+Maps a piece of processor virtual memory so it can be accessed by the
+device and returns the physical handle of the memory.
+
+The direction for both api's may be converted freely by casting.
+However the dma_ API uses a strongly typed enumerator for its
+direction:
+
+DMA_NONE		= PCI_DMA_NONE		no direction (used for
+						debugging)
+DMA_TO_DEVICE		= PCI_DMA_TODEVICE	data is going from the
+						memory to the device
+DMA_FROM_DEVICE		= PCI_DMA_FROMDEVICE	data is coming from
+						the device to the
+						memory
+DMA_BIDIRECTIONAL	= PCI_DMA_BIDIRECTIONAL	direction isn't known
+
+Notes:  Not all memory regions in a machine can be mapped by this
+API.  Further, regions that appear to be physically contiguous in
+kernel virtual space may not be contiguous as physical memory.  Since
+this API does not provide any scatter/gather capability, it will fail
+if the user tries to map a non physically contiguous piece of memory.
+For this reason, it is recommended that memory mapped by this API be
+obtained only from sources which guarantee to be physically contiguous
+(like kmalloc).
+
+Further, the physical address of the memory must be within the
+dma_mask of the device (the dma_mask represents a bit mask of the
+addressable region for the device.  i.e. if the physical address of
+the memory anded with the dma_mask is still equal to the physical
+address, then the device can perform DMA to the memory).  In order to
+ensure that the memory allocated by kmalloc is within the dma_mask,
+the driver may specify various platform dependent flags to restrict
+the physical memory range of the allocation (e.g. on x86, GFP_DMA
+guarantees to be within the first 16Mb of available physical memory,
+as required by ISA devices).
+
+Note also that the above constraints on physical contiguity and
+dma_mask may not apply if the platform has an IOMMU (a device which
+supplies a physical to virtual mapping between the I/O memory bus and
+the device).  However, to be portable, device driver writers may *not*
+assume that such an IOMMU exists.
+
+Warnings:  Memory coherency operates at a granularity called the cache
+line width.  In order for memory mapped by this API to operate
+correctly, the mapped region must begin exactly on a cache line
+boundary and end exactly on one (to prevent two separately mapped
+regions from sharing a single cache line).  Since the cache line size
+may not be known at compile time, the API will not enforce this
+requirement.  Therefore, it is recommended that driver writers who
+don't take special care to determine the cache line size at run time
+only map virtual regions that begin and end on page boundaries (which
+are guaranteed also to be cache line boundaries).
+
+DMA_TO_DEVICE synchronisation must be done after the last modification
+of the memory region by the software and before it is handed off to
+the driver.  Once this primitive is used.  Memory covered by this
+primitive should be treated as read only by the device.  If the device
+may write to it at any point, it should be DMA_BIDIRECTIONAL (see
+below).
+
+DMA_FROM_DEVICE synchronisation must be done before the driver
+accesses data that may be changed by the device.  This memory should
+be treated as read only by the driver.  If the driver needs to write
+to it at any point, it should be DMA_BIDIRECTIONAL (see below).
+
+DMA_BIDIRECTIONAL requires special handling: it means that the driver
+isn't sure if the memory was modified before being handed off to the
+device and also isn't sure if the device will also modify it.  Thus,
+you must always sync bidirectional memory twice: once before the
+memory is handed off to the device (to make sure all memory changes
+are flushed from the processor) and once before the data may be
+accessed after being used by the device (to make sure any processor
+cache lines are updated with data that the device may have changed.
+
+void
+dma_unmap_single(struct device *dev, dma_addr_t dma_addr, size_t size,
+		 enum dma_data_direction direction)
+void
+pci_unmap_single(struct pci_dev *hwdev, dma_addr_t dma_addr,
+		 size_t size, int direction)
+
+Unmaps the region previously mapped.  All the parameters passed in
+must be identical to those passed in (and returned) by the mapping
+API.
+
+dma_addr_t
+dma_map_page(struct device *dev, struct page *page,
+		    unsigned long offset, size_t size,
+		    enum dma_data_direction direction)
+dma_addr_t
+pci_map_page(struct pci_dev *hwdev, struct page *page,
+		    unsigned long offset, size_t size, int direction)
+void
+dma_unmap_page(struct device *dev, dma_addr_t dma_address, size_t size,
+	       enum dma_data_direction direction)
+void
+pci_unmap_page(struct pci_dev *hwdev, dma_addr_t dma_address,
+	       size_t size, int direction)
+
+API for mapping and unmapping for pages.  All the notes and warnings
+for the other mapping APIs apply here.  Also, although the <offset>
+and <size> parameters are provided to do partial page mapping, it is
+recommended that you never use these unless you really know what the
+cache width is.
+
+int
+dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
+	   enum dma_data_direction direction)
+int
+pci_map_sg(struct pci_dev *hwdev, struct scatterlist *sg,
+	   int nents, int direction)
+
+Maps a scatter gather list from the block layer.
+
+Returns: the number of physical segments mapped (this may be shorted
+than <nents> passed in if the block layer determines that some
+elements of the scatter/gather list are physically adjacent and thus
+may be mapped with a single entry).
+
+void
+dma_unmap_sg(struct device *dev, struct scatterlist *sg, int nhwentries,
+	     enum dma_data_direction direction)
+void
+pci_unmap_sg(struct pci_dev *hwdev, struct scatterlist *sg,
+	     int nents, int direction)
+
+unmap the previously mapped scatter/gather list.  All the parameters
+must be the same as those and passed in to the scatter/gather mapping
+API.
+
+Note: <nents> must be the number you passed in, *not* the number of
+physical entries returned.
+
+void
+dma_sync_single(struct device *dev, dma_addr_t dma_handle, size_t size,
+		enum dma_data_direction direction)
+void
+pci_dma_sync_single(struct pci_dev *hwdev, dma_addr_t dma_handle,
+			   size_t size, int direction)
+void
+dma_sync_sg(struct device *dev, struct scatterlist *sg, int nelems,
+			  enum dma_data_direction direction)
+void
+pci_dma_sync_sg(struct pci_dev *hwdev, struct scatterlist *sg,
+		       int nelems, int direction)
+
+synchronise a single contiguous or scatter/gather mapping.  All the
+parameters must be the same as those passed into the single mapping
+API.
+
+Notes:  You must do this:
+
+- Before reading values that have been written by DMA from the device
+  (use the DMA_FROM_DEVICE direction)
+- After writing values that will be written to the device using DMA
+  (use the DMA_TO_DEVICE) direction
+- before *and* after handing memory to the device if the memory is
+  DMA_BIDIRECTIONAL
+
+See also dma_map_single().
+
+Part II - Advanced dma_ usage
+-----------------------------
+
+Warning: These pieces of the DMA API have no PCI equivalent.  They
+should also not be used in the majority of cases, since they cater for
+unlikely corner cases that don't belong in usual drivers.
+
+If you don't understand how cache line coherency works between a
+processor and an I/O device, you should not be using this part of the
+API at all.
+
+void *
+dma_alloc_nonconsistent(struct device *dev, size_t size,
+			       dma_addr_t *dma_handle)
+
+Identical to dma_alloc_consistent() except that the platform will
+choose to return either consistent or non-consistent memory as it sees
+fit.  By using this API, you are guaranteeing to the platform that you
+have all the correct and necessary sync points for this memory in the
+driver should it choose to return non-consistent memory.
+
+Note: where the platform can return consistent memory, it will
+guarantee that the sync points become nops.
+
+Warning:  Handling non-consistent memory is a real pain.  You should
+only ever use this API if you positively know your driver will be
+required to work on one of the rare (usually non-PCI) architectures
+that simply cannot make consistent memory.
+
+void
+dma_free_nonconsistent(struct device *dev, size_t size, void *cpu_addr,
+			      dma_addr_t dma_handle)
+
+free memory allocated by the nonconsistent API.  All parameters must
+be identical to those passed in (and returned by
+dma_alloc_nonconsistent()).
+
+int
+dma_is_consistent(dma_addr_t dma_handle)
+
+returns true if the memory pointed to by the dma_handle is actually
+consistent.
+
+int
+dma_get_cache_alignment(void)
+
+returns the processor cache alignment.  This is the absolute minimum
+alignment *and* width that you must observe when either mapping
+memory or doing partial flushes.
+
+Notes: This API may return a number *larger* than the actual cache
+line, but it will guarantee that one or more cache lines fit exactly
+into the width returned by this call.  It will also always be a power
+of two for easy alignment
+
+void
+dma_sync_single_range(struct device *dev, dma_addr_t dma_handle,
+		      unsigned long offset, size_t size,
+		      enum dma_data_direction direction)
+
+does a partial sync.  starting at offset and continuing for size.  You
+must be careful to observe the cache alignment and width when doing
+anything like this.  You must also be extra careful about accessing
+memory you intend to sync partially.
+
+void
+dma_cache_sync(void *vaddr, size_t size,
+	       enum dma_data_direction direction)
+
+Do a partial sync of memory that was allocated by
+dma_alloc_nonconsistent(), starting at virtual address vaddr and
+continuing on for size.  Again, you *must* observe the cache line
+boundaries when doing this.
+
+
diff -Nru a/Documentation/DMA-mapping.txt b/Documentation/DMA-mapping.txt
--- a/Documentation/DMA-mapping.txt	Tue Dec 17 20:49:32 2002
+++ b/Documentation/DMA-mapping.txt	Tue Dec 17 20:49:32 2002
@@ -5,6 +5,10 @@
 		 Richard Henderson <rth@cygnus.com>
 		  Jakub Jelinek <jakub@redhat.com>
 
+This document describes the DMA mapping system in terms of the pci_
+API.  For a similar API that works for generic devices, see
+DMA-API.txt.
+
 Most of the 64bit platforms have special hardware that translates bus
 addresses (DMA addresses) into physical addresses.  This is similar to
 how page tables and/or a TLB translates virtual addresses to physical
diff -Nru a/arch/i386/kernel/i386_ksyms.c b/arch/i386/kernel/i386_ksyms.c
--- a/arch/i386/kernel/i386_ksyms.c	Tue Dec 17 20:49:32 2002
+++ b/arch/i386/kernel/i386_ksyms.c	Tue Dec 17 20:49:32 2002
@@ -124,8 +124,8 @@
 EXPORT_SYMBOL(__copy_to_user);
 EXPORT_SYMBOL(strnlen_user);
 
-EXPORT_SYMBOL(pci_alloc_consistent);
-EXPORT_SYMBOL(pci_free_consistent);
+EXPORT_SYMBOL(dma_alloc_consistent);
+EXPORT_SYMBOL(dma_free_consistent);
 
 #ifdef CONFIG_PCI
 EXPORT_SYMBOL(pcibios_penalize_isa_irq);
diff -Nru a/arch/i386/kernel/pci-dma.c b/arch/i386/kernel/pci-dma.c
--- a/arch/i386/kernel/pci-dma.c	Tue Dec 17 20:49:32 2002
+++ b/arch/i386/kernel/pci-dma.c	Tue Dec 17 20:49:32 2002
@@ -13,13 +13,13 @@
 #include <linux/pci.h>
 #include <asm/io.h>
 
-void *pci_alloc_consistent(struct pci_dev *hwdev, size_t size,
+void *dma_alloc_consistent(struct device *dev, size_t size,
 			   dma_addr_t *dma_handle)
 {
 	void *ret;
 	int gfp = GFP_ATOMIC;
 
-	if (hwdev == NULL || ((u32)hwdev->dma_mask != 0xffffffff))
+	if (dev == NULL || ((u32)*dev->dma_mask != 0xffffffff))
 		gfp |= GFP_DMA;
 	ret = (void *)__get_free_pages(gfp, get_order(size));
 
@@ -30,7 +30,7 @@
 	return ret;
 }
 
-void pci_free_consistent(struct pci_dev *hwdev, size_t size,
+void dma_free_consistent(struct device *dev, size_t size,
 			 void *vaddr, dma_addr_t dma_handle)
 {
 	free_pages((unsigned long)vaddr, get_order(size));
diff -Nru a/include/asm-alpha/dma-mapping.h b/include/asm-alpha/dma-mapping.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/include/asm-alpha/dma-mapping.h	Tue Dec 17 20:49:32 2002
@@ -0,0 +1 @@
+#include <asm-generic/dma-mapping.h>
diff -Nru a/include/asm-arm/dma-mapping.h b/include/asm-arm/dma-mapping.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/include/asm-arm/dma-mapping.h	Tue Dec 17 20:49:32 2002
@@ -0,0 +1 @@
+#include <asm-generic/dma-mapping.h>
diff -Nru a/include/asm-cris/dma-mapping.h b/include/asm-cris/dma-mapping.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/include/asm-cris/dma-mapping.h	Tue Dec 17 20:49:32 2002
@@ -0,0 +1 @@
+#include <asm-generic/dma-mapping.h>
diff -Nru a/include/asm-generic/dma-mapping.h b/include/asm-generic/dma-mapping.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/include/asm-generic/dma-mapping.h	Tue Dec 17 20:49:32 2002
@@ -0,0 +1,154 @@
+/* Copyright (C) 2002 by James.Bottomley@HansenPartnership.com 
+ *
+ * Implements the generic device dma API via the existing pci_ one
+ * for unconverted architectures
+ */
+
+#ifndef _ASM_GENERIC_DMA_MAPPING_H
+#define _ASM_GENERIC_DMA_MAPPING_H
+
+/* we implement the API below in terms of the existing PCI one,
+ * so include it */
+#include <linux/pci.h>
+
+static inline int
+dma_supported(struct device *dev, u64 mask)
+{
+	BUG_ON(dev->bus != &pci_bus_type);
+
+	return pci_dma_supported(to_pci_dev(dev), mask);
+}
+
+static inline int
+dma_set_mask(struct device *dev, u64 dma_mask)
+{
+	BUG_ON(dev->bus != &pci_bus_type);
+
+	return pci_set_dma_mask(to_pci_dev(dev), dma_mask);
+}
+
+static inline void *
+dma_alloc_consistent(struct device *dev, size_t size, dma_addr_t *dma_handle)
+{
+	BUG_ON(dev->bus != &pci_bus_type);
+
+	return pci_alloc_consistent(to_pci_dev(dev), size, dma_handle);
+}
+
+static inline void
+dma_free_consistent(struct device *dev, size_t size, void *cpu_addr,
+		    dma_addr_t dma_handle)
+{
+	BUG_ON(dev->bus != &pci_bus_type);
+
+	pci_free_consistent(to_pci_dev(dev), size, cpu_addr, dma_handle);
+}
+
+static inline dma_addr_t
+dma_map_single(struct device *dev, void *cpu_addr, size_t size,
+	       enum dma_data_direction direction)
+{
+	BUG_ON(dev->bus != &pci_bus_type);
+
+	return pci_map_single(to_pci_dev(dev), cpu_addr, size, (int)direction);
+}
+
+static inline void
+dma_unmap_single(struct device *dev, dma_addr_t dma_addr, size_t size,
+		 enum dma_data_direction direction)
+{
+	BUG_ON(dev->bus != &pci_bus_type);
+
+	pci_unmap_single(to_pci_dev(dev), dma_addr, size, (int)direction);
+}
+
+static inline dma_addr_t
+dma_map_page(struct device *dev, struct page *page,
+	     unsigned long offset, size_t size,
+	     enum dma_data_direction direction)
+{
+	BUG_ON(dev->bus != &pci_bus_type);
+
+	return pci_map_page(to_pci_dev(dev), page, offset, size, (int)direction);
+}
+
+static inline void
+dma_unmap_page(struct device *dev, dma_addr_t dma_address, size_t size,
+	       enum dma_data_direction direction)
+{
+	BUG_ON(dev->bus != &pci_bus_type);
+
+	pci_unmap_page(to_pci_dev(dev), dma_address, size, (int)direction);
+}
+
+static inline int
+dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
+	   enum dma_data_direction direction)
+{
+	BUG_ON(dev->bus != &pci_bus_type);
+
+	return pci_map_sg(to_pci_dev(dev), sg, nents, (int)direction);
+}
+
+static inline void
+dma_unmap_sg(struct device *dev, struct scatterlist *sg, int nhwentries,
+	     enum dma_data_direction direction)
+{
+	BUG_ON(dev->bus != &pci_bus_type);
+
+	pci_unmap_sg(to_pci_dev(dev), sg, nhwentries, (int)direction);
+}
+
+static inline void
+dma_sync_single(struct device *dev, dma_addr_t dma_handle, size_t size,
+		enum dma_data_direction direction)
+{
+	BUG_ON(dev->bus != &pci_bus_type);
+
+	pci_dma_sync_single(to_pci_dev(dev), dma_handle, size, (int)direction);
+}
+
+static inline void
+dma_sync_sg(struct device *dev, struct scatterlist *sg, int nelems,
+	    enum dma_data_direction direction)
+{
+	BUG_ON(dev->bus != &pci_bus_type);
+
+	pci_dma_sync_sg(to_pci_dev(dev), sg, nelems, (int)direction);
+}
+
+/* Now for the API extensions over the pci_ one */
+
+#define dma_alloc_nonconsistent(d, s, h) dma_alloc_consistent(d, s, h)
+#define dma_free_nonconsistent(d, s, v, h) dma_free_consistent(d, s, v, h)
+#define dma_is_consistent(d)	(1)
+
+static inline int
+dma_get_cache_alignment(void)
+{
+	/* no easy way to get cache size on all processors, so return
+	 * the maximum possible, to be safe */
+	return (1 << L1_CACHE_SHIFT_MAX);
+}
+
+static inline void
+dma_sync_single_range(struct device *dev, dma_addr_t dma_handle,
+		      unsigned long offset, size_t size,
+		      enum dma_data_direction direction)
+{
+	/* just sync everything, that's all the pci API can do */
+	dma_sync_single(dev, dma_handle, offset+size, direction);
+}
+
+static inline void
+dma_cache_sync(void *vaddr, size_t size,
+	       enum dma_data_direction direction)
+{
+	/* could define this in terms of the dma_cache ... operations,
+	 * but if you get this on a platform, you should convert the platform
+	 * to using the generic device DMA API */
+	BUG();
+}
+
+#endif
+
diff -Nru a/include/asm-i386/dma-mapping.h b/include/asm-i386/dma-mapping.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/include/asm-i386/dma-mapping.h	Tue Dec 17 20:49:32 2002
@@ -0,0 +1,137 @@
+#ifndef _ASM_I386_DMA_MAPPING_H
+#define _ASM_I386_DMA_MAPPING_H
+
+#include <asm/cache.h>
+
+#define dma_alloc_nonconsistent(d, s, h) dma_alloc_consistent(d, s, h)
+#define dma_free_nonconsistent(d, s, v, h) dma_free_consistent(d, s, v, h)
+
+void *dma_alloc_consistent(struct device *dev, size_t size,
+			   dma_addr_t *dma_handle);
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
+dma_sync_single_range(struct device *dev, dma_addr_t dma_handle,
+		      unsigned long offset, size_t size,
+		      enum dma_data_direction direction)
+{
+	flush_write_buffers();
+}
+
+
+static inline void
+dma_sync_sg(struct device *dev, struct scatterlist *sg, int nelems,
+		 enum dma_data_direction direction)
+{
+	flush_write_buffers();
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
+static inline int
+dma_get_cache_alignment(void)
+{
+	/* no easy way to get cache size on all x86, so return the
+	 * maximum possible, to be safe */
+	return (1 << L1_CACHE_SHIFT_MAX);
+}
+
+#define dma_is_consistent(d)	(1)
+
+static inline void
+dma_cache_sync(void *vaddr, size_t size,
+	       enum dma_data_direction direction)
+{
+	flush_write_buffers();
+}
+
+#endif
diff -Nru a/include/asm-i386/pci.h b/include/asm-i386/pci.h
--- a/include/asm-i386/pci.h	Tue Dec 17 20:49:32 2002
+++ b/include/asm-i386/pci.h	Tue Dec 17 20:49:32 2002
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
diff -Nru a/include/asm-ia64/dma-mapping.h b/include/asm-ia64/dma-mapping.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/include/asm-ia64/dma-mapping.h	Tue Dec 17 20:49:32 2002
@@ -0,0 +1 @@
+#include <asm-generic/dma-mapping.h>
diff -Nru a/include/asm-m68k/dma-mapping.h b/include/asm-m68k/dma-mapping.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/include/asm-m68k/dma-mapping.h	Tue Dec 17 20:49:32 2002
@@ -0,0 +1 @@
+#include <asm-generic/dma-mapping.h>
diff -Nru a/include/asm-m68knommu/dma-mapping.h b/include/asm-m68knommu/dma-mapping.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/include/asm-m68knommu/dma-mapping.h	Tue Dec 17 20:49:32 2002
@@ -0,0 +1 @@
+#include <asm-generic/dma-mapping.h>
diff -Nru a/include/asm-mips/dma-mapping.h b/include/asm-mips/dma-mapping.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/include/asm-mips/dma-mapping.h	Tue Dec 17 20:49:32 2002
@@ -0,0 +1 @@
+#include <asm-generic/dma-mapping.h>
diff -Nru a/include/asm-mips64/dma-mapping.h b/include/asm-mips64/dma-mapping.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/include/asm-mips64/dma-mapping.h	Tue Dec 17 20:49:32 2002
@@ -0,0 +1 @@
+#include <asm-generic/dma-mapping.h>
diff -Nru a/include/asm-ppc/dma-mapping.h b/include/asm-ppc/dma-mapping.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/include/asm-ppc/dma-mapping.h	Tue Dec 17 20:49:32 2002
@@ -0,0 +1 @@
+#include <asm-generic/dma-mapping.h>
diff -Nru a/include/asm-ppc64/dma-mapping.h b/include/asm-ppc64/dma-mapping.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/include/asm-ppc64/dma-mapping.h	Tue Dec 17 20:49:32 2002
@@ -0,0 +1 @@
+#include <asm-generic/dma-mapping.h>
diff -Nru a/include/asm-s390/dma-mapping.h b/include/asm-s390/dma-mapping.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/include/asm-s390/dma-mapping.h	Tue Dec 17 20:49:32 2002
@@ -0,0 +1 @@
+#include <asm-generic/dma-mapping.h>
diff -Nru a/include/asm-s390x/dma-mapping.h b/include/asm-s390x/dma-mapping.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/include/asm-s390x/dma-mapping.h	Tue Dec 17 20:49:32 2002
@@ -0,0 +1 @@
+#include <asm-generic/dma-mapping.h>
diff -Nru a/include/asm-sh/dma-mapping.h b/include/asm-sh/dma-mapping.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/include/asm-sh/dma-mapping.h	Tue Dec 17 20:49:32 2002
@@ -0,0 +1 @@
+#include <asm-generic/dma-mapping.h>
diff -Nru a/include/asm-sparc/dma-mapping.h b/include/asm-sparc/dma-mapping.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/include/asm-sparc/dma-mapping.h	Tue Dec 17 20:49:32 2002
@@ -0,0 +1 @@
+#include <asm-generic/dma-mapping.h>
diff -Nru a/include/asm-sparc64/dma-mapping.h b/include/asm-sparc64/dma-mapping.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/include/asm-sparc64/dma-mapping.h	Tue Dec 17 20:49:32 2002
@@ -0,0 +1 @@
+#include <asm-generic/dma-mapping.h>
diff -Nru a/include/asm-um/dma-mapping.h b/include/asm-um/dma-mapping.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/include/asm-um/dma-mapping.h	Tue Dec 17 20:49:32 2002
@@ -0,0 +1 @@
+#include <asm-generic/dma-mapping.h>
diff -Nru a/include/asm-v850/dma-mapping.h b/include/asm-v850/dma-mapping.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/include/asm-v850/dma-mapping.h	Tue Dec 17 20:49:32 2002
@@ -0,0 +1 @@
+#include <asm-generic/dma-mapping.h>
diff -Nru a/include/asm-x86_64/dma-mapping.h b/include/asm-x86_64/dma-mapping.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/include/asm-x86_64/dma-mapping.h	Tue Dec 17 20:49:32 2002
@@ -0,0 +1 @@
+#include <asm-generic/dma-mapping.h>
diff -Nru a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/include/linux/dma-mapping.h	Tue Dec 17 20:49:32 2002
@@ -0,0 +1,17 @@
+#ifndef _ASM_LINUX_DMA_MAPPING_H
+#define _ASM_LINUX_DMA_MAPPING_H
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
--- a/include/linux/pci.h	Tue Dec 17 20:49:32 2002
+++ b/include/linux/pci.h	Tue Dec 17 20:49:32 2002
@@ -826,5 +826,92 @@
 #define PCIPCI_VIAETBF		8
 #define PCIPCI_VSFX		16
 
+#include <linux/dma-mapping.h>
+
+/* If you define PCI_NEW_DMA_COMPAT_API it means you support the new DMA API
+ * and you want the pci_ DMA API to be implemented using it.
+ */
+#if defined(PCI_NEW_DMA_COMPAT_API) && defined(CONFIG_PCI)
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
+	return dma_alloc_consistent(&hwdev->dev, size, dma_handle);
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

--==_Exmh_11357881300--


