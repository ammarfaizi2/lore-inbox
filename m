Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267035AbSL3W5K>; Mon, 30 Dec 2002 17:57:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267052AbSL3W5K>; Mon, 30 Dec 2002 17:57:10 -0500
Received: from mta7.pltn13.pbi.net ([64.164.98.8]:33252 "EHLO
	mta7.pltn13.pbi.net") by vger.kernel.org with ESMTP
	id <S267035AbSL3W4w>; Mon, 30 Dec 2002 17:56:52 -0500
Date: Mon, 30 Dec 2002 15:11:19 -0800
From: David Brownell <david-b@pacbell.net>
Subject: [PATCH] generic device DMA (dma_pool update)
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: linux-kernel@vger.kernel.org
Message-id: <3E10D297.1090206@pacbell.net>
MIME-version: 1.0
Content-type: multipart/mixed; boundary="Boundary_(ID_1cA7JVMRBDqITj0Td4//ug)"
X-Accept-Language: en-us, en, fr
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020513
References: <200212272140.gBRLeMW03698@localhost.localdomain>
 <3E0D04DB.1000500@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Boundary_(ID_1cA7JVMRBDqITj0Td4//ug)
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT

  >>> - There's no analogue to pci_pool, and there's nothing like
  >>>   "kmalloc" (likely built from N dma-coherent pools).
  >>
  >> I didn't want to build another memory pool re-implementation.  The
  >> mempool API seems to me to be flexible enough for this, is there some
  >> reason it won't work?
  >
  > I didn't notice any way it would track, and return, DMA addresses.
  > It's much like a kmem_cache in that way.

Here's a patch (against 2.5.53) that does it with current allocators:

- adds new dma_pool calls, implemented by inlines using "kmem_cache_t *"
   (wrapped) or "struct pci_pool *" depending on the arch/config.

        struct dma_pool *dma_pool_create(char *, struct device *, size_t)
        void dma_pool_destroy (struct dma_pool *pool)
        void *dma_pool_alloc(struct dma_pool *, int mem_flags, dma_addr_t *)
        void dma_pool_free(struct dma_pool *, void *, dma_addr_t)

- new kmalloc/kfree style calls, likewise turned by inlines into kmalloc
   or code that can use dma_pool (but can't yet, needs a device dma state
   hook), falling back to dma_alloc_coherent for page allocation otherwise.

        void *dma_alloc(struct device *, size_t, dma_addr_t *, int mem_flags)
        void dma_free(struct device *, size_t, void *, dma_addr_t)

- pci_pool is now arch-specific like the rest of the pci dma calls.
   along with a DMA-API.txt update, this makes 2/3 of this patch. so
   x86 uses dma_pool instead, through <asm-generic/pci-dma-compat.h>

An immediate effect of this patch is that on x86, both USB and Firewire will
do their pci_pool allocations through kmem_cache_t, which is a smarter (and
faster) allocator.  (So would other drivers using pci_pool calls.)

Comments?

- Dave





--Boundary_(ID_1cA7JVMRBDqITj0Td4//ug)
Content-type: text/plain; name=dma-1230.patch
Content-transfer-encoding: 7BIT
Content-disposition: inline; filename=dma-1230.patch

--- ./include-dist/asm-generic/dma-mapping.h	Wed Dec 25 08:47:40 2002
+++ ./include/asm-generic/dma-mapping.h	Mon Dec 30 11:17:32 2002
@@ -152,5 +152,33 @@
 	BUG();
 }
 
+#ifdef __dma_slab_flags
+/* if we can use the slab allocator, do so.  */
+#include <asm-generic/dma-slab.h>
+
+#else
+
+extern void *
+dma_alloc (struct device *dev, size_t size, dma_addr_t *handle, int mem_flags);
+
+extern void
+dma_free (struct device *dev, size_t size, void *vaddr, dma_addr_t dma);
+
+
+#define dma_pool pci_pool
+
+static inline struct dma_pool *
+dma_pool_create (const char *name, struct device *dev, size_t size)
+{
+	BUG_ON(dev->bus != &pci_bus_type);
+	return pci_pool_create(name, to_pci_dev(dev), size, 0, 0);
+}
+
+#define dma_pool_destroy	pci_pool_destroy
+#define dma_pool_alloc		pci_pool_alloc
+#define dma_pool_free		pci_pool_free
+
+#endif
+
 #endif
 
--- ./include-dist/asm-generic/dma-slab.h	Wed Dec 31 16:00:00 1969
+++ ./include/asm-generic/dma-slab.h	Mon Dec 30 10:35:47 2002
@@ -0,0 +1,59 @@
+#ifndef _ASM_GENERIC_DMA_SLAB_H
+#define _ASM_GENERIC_DMA_SLAB_H
+
+/* flags == SLAB_KERNEL or SLAB_ATOMIC */
+static inline void *
+dma_alloc (struct device *dev, size_t size, dma_addr_t *handle, int mem_flags)
+{
+	void	*ret;
+
+	/* We rely on kmalloc memory being aligned to L1_CACHE_BYTES, to
+	 * prevent cacheline sharing during DMA.  With dma-incoherent caches,
+	 * such sharing causes bugs, not just cache-related slowdown.
+	 */
+	ret = kmalloc (size, mem_flags | __dma_slab_flags (dev));
+	if (likely (ret != 0))
+		*handle = virt_to_phys (ret);
+	return ret;
+}
+
+static inline void
+dma_free (struct device *dev, size_t size, void *vaddr, dma_addr_t dma)
+{
+	kfree (vaddr);
+}
+
+
+struct dma_pool {
+	/* these caches are forced to be hw-aligned too */
+	kmem_cache_t 	*cache;
+	struct device	*dev;
+	char		name [0];
+};
+
+extern struct dma_pool *
+dma_pool_create (const char *name, struct device *dev, size_t size);
+
+extern void dma_pool_destroy (struct dma_pool *pool);
+
+
+/* flags == SLAB_KERNEL or SLAB_ATOMIC */
+static inline void *
+dma_pool_alloc (struct dma_pool *pool, int flags, dma_addr_t *handle)
+{
+	void		*ret;
+
+	ret = kmem_cache_alloc (pool->cache, flags);
+	if (likely (ret != 0))
+		*handle = virt_to_phys (ret);
+	return ret;
+}
+
+static inline void
+dma_pool_free (struct dma_pool *pool, void *vaddr, dma_addr_t addr)
+{
+	kmem_cache_free (pool->cache, vaddr);
+}
+
+#endif
+
--- ./include-dist/asm-i386/dma-mapping.h	Wed Dec 25 08:49:09 2002
+++ ./include/asm-i386/dma-mapping.h	Mon Dec 30 13:12:07 2002
@@ -134,4 +134,9 @@
 	flush_write_buffers();
 }
 
+/* use the slab allocator to manage dma buffers */
+#define __dma_slab_flags(dev) \
+	((*(dev)->dma_mask <= 0x00ffffff) ? SLAB_DMA : 0)
+#include <asm-generic/dma-slab.h>
+
 #endif
--- ./include-dist/asm-ppc/dma-mapping.h	Wed Dec 25 08:48:02 2002
+++ ./include/asm-ppc/dma-mapping.h	Mon Dec 30 10:43:51 2002
@@ -1 +1,7 @@
+#ifndef CONFIG_NOT_COHERENT_CACHE
+/* use the slab allocator to manage dma buffers */
+#define __dma_slab_flags(dev) \
+	((*(dev)->dma_mask != 0xffffffff) ? SLAB_DMA : 0)
+#endif
+
 #include <asm-generic/dma-mapping.h>
--- ./include-dist/asm-um/dma-mapping.h	Wed Dec 25 08:49:40 2002
+++ ./include/asm-um/dma-mapping.h	Mon Dec 30 13:25:28 2002
@@ -1 +1,4 @@
+/* use the slab allocator to manage dma buffers */
+#define __dma_slab_flags(dev) 0
+
 #include <asm-generic/dma-mapping.h>
--- ./include-dist/asm-arm/dma-mapping.h	Wed Dec 25 08:48:19 2002
+++ ./include/asm-arm/dma-mapping.h	Mon Dec 30 13:25:36 2002
@@ -1 +1,6 @@
+#ifdef	CONFIG_SA1111
+/* we can just use the slab allocator to manage dma buffers */
+#define __dma_slab_flags(dev) SLAB_DMA
+#endif
+
 #include <asm-generic/dma-mapping.h>
--- ./drivers/base-dist/dma.c	Wed Dec 31 16:00:00 1969
+++ ./drivers/base/dma.c	Mon Dec 30 14:37:46 2002
@@ -0,0 +1,106 @@
+/* the non-inlined support for coherent dma memory buffer calls */
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/version.h>
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/device.h>
+
+#include <asm/io.h>
+#include <asm/scatterlist.h>
+#include <linux/mm.h>
+#include <linux/dma-mapping.h>
+
+
+#ifdef __dma_slab_flags
+
+/*
+ * Slab memory can be used for DMA buffers on some platforms (including i386).
+ * This implementation is mostly inlined in <asm-generic/dma-slab.h>.
+ */
+
+struct dma_pool *
+dma_pool_create (const char *name, struct device *dev, size_t size)
+{
+	int		tmp;
+	struct dma_pool	*pool;
+
+	tmp = strlen (name);
+	pool = kmalloc (sizeof *pool + tmp + strlen (dev->bus_id) + 2, SLAB_KERNEL);
+	if (!pool)
+		return pool;
+
+	/* bus_id makes the name unique over dev->bus, not globally */
+	memcpy (pool->name, name, tmp);
+	pool->name [tmp] = '/';
+	strcpy (&pool->name [tmp + 1], dev->bus_id);
+
+	tmp = SLAB_HWCACHE_ALIGN | SLAB_MUST_HWCACHE_ALIGN;
+	if (__dma_slab_flags (dev) & SLAB_DMA)
+		tmp |= SLAB_CACHE_DMA;
+
+	pool->cache = kmem_cache_create (pool->name, size, 0, tmp, 0, 0);
+	if (!pool->cache) {
+		kfree (pool);
+		pool = 0;
+	} else
+		pool->dev = get_device (dev);
+	return pool;
+}
+EXPORT_SYMBOL (dma_pool_create);
+
+void dma_pool_destroy (struct dma_pool *pool)
+{
+	kmem_cache_destroy (pool->cache);
+	put_device (pool->dev);
+	kfree (pool);
+}
+EXPORT_SYMBOL (dma_pool_destroy);
+
+#elif	defined (CONFIG_PCI)
+
+#include <linux/pci.h>
+
+/*
+ * Otherwise, assume wrapping pci_pool will do.
+ * This implementation is mostly inlined in <asm-generic/dma-mapping.h>.
+ */
+
+void *
+dma_alloc (struct device *dev, size_t size, dma_addr_t *handle, int mem_flags)
+{
+	struct pci_dev	*pdev = to_pci_dev(dev);
+
+	BUG_ON(dev->bus != &pci_bus_type);
+
+	if (size >= PAGE_SIZE)
+		return pci_alloc_consistent (pdev, size, handle);
+
+	/* FIXME keep N pools of per-device dma state, not just a u64 for the
+	 * dma mask.  allocate from the right pool here.  (unless this platform
+	 * has a pci_alloc_consistent() that does 1/Nth page allocations.)
+	 * and since pci_alloc_consistent can't fail (so must BUG out), it
+	 * might be a good idea to cache a few larger buffers here too.
+	 */
+#warning "broken dma_alloc()"
+
+	return 0;
+}
+EXPORT_SYMBOL (dma_alloc);
+
+void
+dma_free (struct device *dev, size_t size, void *vaddr, dma_addr_t dma)
+{
+	struct pci_dev	*pdev = to_pci_dev(dev);
+
+	BUG_ON(dev->bus != &pci_bus_type);
+
+	pci_free_consistent (pdev, size, vaddr, dma);
+}
+EXPORT_SYMBOL (dma_free);
+
+
+#else
+#error "no dma buffer allocation is available"
+#endif
--- ./drivers/base-dist/Makefile	Wed Dec 25 08:50:00 2002
+++ ./drivers/base/Makefile	Sat Dec 28 11:10:42 2002
@@ -2,7 +2,7 @@
 
 obj-y		:= core.o sys.o interface.o power.o bus.o \
 			driver.o class.o intf.o platform.o \
-			cpu.o firmware.o
+			cpu.o firmware.o dma.o
 
 obj-$(CONFIG_NUMA)	+= node.o  memblk.o
 
@@ -11,4 +11,4 @@
 obj-$(CONFIG_HOTPLUG)	+= hotplug.o
 
 export-objs	:= core.o power.o sys.o bus.o driver.o \
-			class.o intf.o platform.o firmware.o
+			class.o intf.o platform.o firmware.o dma.o
--- ./Documentation-dist/DMA-API.txt	Wed Dec 25 08:54:25 2002
+++ ./Documentation/DMA-API.txt	Mon Dec 30 12:01:37 2002
@@ -5,7 +5,8 @@
 
 This document describes the DMA API.  For a more gentle introduction
 phrased in terms of the pci_ equivalents (and actual examples) see
-DMA-mapping.txt
+DMA-mapping.txt; USB device drivers will normally use the USB DMA
+APIs, see Documentation/usb/dma.txt instead.
 
 This API is split into two pieces.  Part I describes the API and the
 corresponding pci_ API.  Part II describes the extensions to the API
@@ -20,18 +21,31 @@
 To get the pci_ API, you must #include <linux/pci.h>
 To get the dma_ API, you must #include <linux/dma-mapping.h>
 
-void *
-dma_alloc_coherent(struct device *dev, size_t size,
+
+I.A Coherent memory
++++++++++++++++++++
+Coherent memory is memory for which a write by either the device or the
+processor can immediately be read by the other, without having to worry
+about caches losing the write.  Drivers should normally use memory barrier
+instructions to ensure that the device and processor see writes in the
+intended order.  CPUs and compilers commonly re-order reads, unless rmb()
+or mb() is used.  Many also reorder writes unless wmb() or mb() is used.
+
+Just as with normal kernel memory, there are several allocation APIs.
+One talks in terms of pages, another talks in terms of arbitrary sized
+buffers, and another talks in terms of pools of fixed-size blocks.
+
+
+ALLOCATING AND FREEING ONE OR MORE PAGES
+
+	void *
+	dma_alloc_coherent(struct device *dev, size_t size,
 			     dma_addr_t *dma_handle)
-void *
-pci_alloc_consistent(struct pci_dev *dev, size_t size,
+	void *
+	pci_alloc_consistent(struct pci_dev *dev, size_t size,
 			     dma_addr_t *dma_handle)
 
-Consistent memory is memory for which a write by either the device or
-the processor can immediately be read by the processor or device
-without having to worry about caching effects.
-
-This routine allocates a region of <size> bytes of consistent memory.
+This routine allocates a region of <size> bytes of coherent memory.
 it also returns a <dma_handle> which may be cast to an unsigned
 integer the same width as the bus and used as the physical address
 base of the region.
@@ -39,26 +53,113 @@
 Returns: a pointer to the allocated region (in the processor's virtual
 address space) or NULL if the allocation failed.
 
-Note: consistent memory can be expensive on some platforms, and the
+Note: coherent memory can be expensive on some platforms, and the
 minimum allocation length may be as big as a page, so you should
-consolidate your requests for consistent memory as much as possible.
+consolidate your requests for coherent memory as much as possible.
+Or better yet, use the other APIs (below), which handle 1/N page
+allocations as well as N-page allocations.
 
-void
-dma_free_coherent(struct device *dev, size_t size, void *cpu_addr
+	void
+	dma_free_coherent(struct device *dev, size_t size, void *cpu_addr
 			   dma_addr_t dma_handle)
-void
-pci_free_consistent(struct pci_dev *dev, size_t size, void *cpu_addr
+	void
+	pci_free_consistent(struct pci_dev *dev, size_t size, void *cpu_addr
 			   dma_addr_t dma_handle)
 
-Free the region of consistent memory you previously allocated.  dev,
+Free the region of coherent memory you previously allocated.  dev,
 size and dma_handle must all be the same as those passed into the
-consistent allocate.  cpu_addr must be the virtual address returned by
-the consistent allocate
+coherent allocation.  cpu_addr must be the virtual address returned by
+the coherent allocation.
+
+
+If you are working with coherent memory that's smaller than a page, use the
+pool allocators (for fixed size allocations) or dma_alloc (otherwise).  All
+this memory is aligned to at least L1_CACHE_BYTES, so that cacheline sharing
+can't cause bugs (on systems with cache-incoherent dma) or performance loss
+(on the more widely used systems with cache-coherent DMA).
+
+Note that there is no pci analogue to dma_alloc(), and there's no USB
+analogue to dma pools.
+
+
+ALLOCATING AND FREEING ARBITRARY SIZED BUFFERS
+
+	void *
+	dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
+		int mem_flags)
+
+	void
+	dma_free(struct device *dev, void *vaddr, dma_addr_t dma)
+
+These are like kmalloc and kfree, except that since they return dma-coherent
+memory they must also return DMA addresses.  Also, they aren't guaranteed to
+accept mem_flags values other than SLAB_KERNEL and SLAB_ATOMIC.  The allocator
+returns null when it fails for any reason.
+
+
+POOL CREATION AND DESTRUCTION
+
+Device drivers often use pools of coherent memory, along with memory
+barriers, to communicate to devices through request queues.
+
+	struct dma_pool *
+	dma_pool_create(char *name, struct pci_dev *dev, size_t size);
+
+	struct pci_pool *
+	pci_pool_create(char *name, struct pci_dev *dev,
+		size_t size, size_t align, size_t alloc)
 
-int
-dma_supported(struct device *dev, u64 mask)
-int
-pci_dma_supported(struct device *dev, u64 mask)
+Pools are like a kmem_cache_t but they work for dma-coherent memory.  They
+must be created (or destroyed) in thread contexts.  For the generic API, use
+'size' to force alignment to bigger boundaries than L1_CACHE_BYTES, and to
+ensure that allocations can't cross 'alloc' byte boundaries.
+
+Returns the pool, or null if one can't be created.
+
+	void
+	dma_pool_destroy(struct dma_pool *pool)
+
+	void
+	pci_pool_destroy(struct pci_pool *pool)
+
+These calls just destroy the pool provided.  The caller guarantees all the
+memory has been returned to the pool, and is not currently in use.
+
+ALLOCATING AND FREEING MEMORY FROM A POOL
+
+	void *
+	dma_pool_alloc(struct dma_pool *pool, int mem_flags, dma_addr_t *handle)
+
+	void *
+	pci_pool_alloc(struct pci_pool *pool, int mem_flags, dma_addr_t *handle)
+
+When allocation succeeds, a pointer to the allocated memory is returned
+and the dma address is stored at the other end of the handle.  "flags"
+can be SLAB_KERNEL or SLAB_ATOMIC, controlling whether it's OK to sleep.
+If allocation fails for any reason, null is returned.
+
+	void *
+	dma_pool_free(struct dma_pool *pool, void *vaddr, dma_addr_t dma)
+
+	void *
+	pci_pool_free(struct pci_pool *pool, void *vaddr, dma_addr_t dma)
+
+When your driver is done using memory allocated using the pool allocation
+calls, pass both of the memory addresses to the free() routine.
+
+
+I.B DMA masks
++++++++++++++
+Hardware often has limitations in the DMA address space it supports.
+Some common examples are x86 ISA addresses, in the first 16 MBytes of
+PC address space, and "highmem" I/O, over the 4 GB mark.  The coherent
+memory allocators will never return "highmem" pointers.
+
+	int
+	dma_supported(struct device *dev, u64 mask)
+
+	int
+	pci_dma_supported(struct device *dev, u64 mask)
 
 Checks to see if the device can support DMA to the memory described by
 mask.
@@ -70,21 +171,31 @@
 internal API for use by the platform than an external API for use by
 driver writers.
 
-int
-dma_set_mask(struct device *dev, u64 mask)
-int
-pci_dma_set_mask(struct pci_device *dev, u64 mask)
+	int
+	dma_set_mask(struct device *dev, u64 mask)
+
+	int
+	pci_dma_set_mask(struct pci_device *dev, u64 mask)
 
 Checks to see if the mask is possible and updates the device
 parameters if it is.
 
 Returns: 1 if successful and 0 if not
 
-dma_addr_t
-dma_map_single(struct device *dev, void *cpu_addr, size_t size,
+
+I.C DMA mappings
+++++++++++++++++
+To work with arbitrary DMA-ready memory, you need to map it into the DMA
+address space of the device.  This might involve an IOMMU or a bounce buffer.
+The two kinds of mapping are  flat "single" mappings, sometimes for single
+pages; and grouped "scatter/gather" ones.  If you're not using the mappings
+for one-shot I/O, you may also need to synchronize the mappings.
+
+	dma_addr_t
+	dma_map_single(struct device *dev, void *cpu_addr, size_t size,
 		      enum dma_data_direction direction)
-dma_addr_t
-pci_map_single(struct device *dev, void *cpu_addr, size_t size,
+	dma_addr_t
+	pci_map_single(struct device *dev, void *cpu_addr, size_t size,
 		      int direction)
 
 Maps a piece of processor virtual memory so it can be accessed by the
--- ./include-dist/linux/pci.h	Wed Dec 25 08:48:53 2002
+++ ./include/linux/pci.h	Mon Dec 30 12:47:36 2002
@@ -672,14 +672,6 @@
 struct pci_bus * pci_add_new_bus(struct pci_bus *parent, struct pci_dev *dev, int busnr);
 int pci_scan_bridge(struct pci_bus *bus, struct pci_dev * dev, int max, int pass);
 
-/* kmem_cache style wrapper around pci_alloc_consistent() */
-struct pci_pool *pci_pool_create (const char *name, struct pci_dev *dev,
-		size_t size, size_t align, size_t allocation);
-void pci_pool_destroy (struct pci_pool *pool);
-
-void *pci_pool_alloc (struct pci_pool *pool, int flags, dma_addr_t *handle);
-void pci_pool_free (struct pci_pool *pool, void *vaddr, dma_addr_t addr);
-
 #if defined(CONFIG_ISA) || defined(CONFIG_EISA)
 extern struct pci_dev *isa_bridge;
 #endif
--- ./include-dist/asm-generic/pci-dma-compat.h	Wed Dec 25 08:47:40 2002
+++ ./include/asm-generic/pci-dma-compat.h	Mon Dec 30 13:14:41 2002
@@ -35,6 +35,39 @@
 	return dma_map_single(&hwdev->dev, ptr, size, (enum dma_data_direction)direction);
 }
 
+static inline struct pci_pool *
+pci_pool_create (const char *name, struct pci_dev *hwdev,
+		size_t size, size_t align, size_t allocation)
+{
+	if (size < align)
+		size = align;
+	if (allocation) {
+		while (align < allocation && (allocation % size) != 0) {
+			align <<= 1;
+			if (size < align)
+				size = align;
+		}
+	}
+	return (struct pci_pool *) dma_pool_create(name, &hwdev->dev, size);
+}
+
+static inline void pci_pool_destroy (struct pci_pool *pool)
+{
+	dma_pool_destroy ((struct dma_pool *) pool);
+}
+
+static inline void *
+pci_pool_alloc (struct pci_pool *pool, int flags, dma_addr_t *handle)
+{
+	return dma_pool_alloc((struct dma_pool *) pool, flags, handle);
+}
+
+static inline void
+pci_pool_free (struct pci_pool *pool, void *vaddr, dma_addr_t addr)
+{
+	return dma_pool_free((struct dma_pool *) pool, vaddr, addr);
+}
+
 static inline void
 pci_unmap_single(struct pci_dev *hwdev, dma_addr_t dma_addr,
 		 size_t size, int direction)
--- ./drivers/pci-dist/pool.c	Wed Dec 25 08:51:41 2002
+++ ./drivers/pci/pool.c	Mon Dec 30 12:51:57 2002
@@ -2,6 +2,8 @@
 #include <linux/slab.h>
 #include <linux/module.h>
 
+#ifndef __dma_slab_flags
+
 /*
  * Pool allocator ... wraps the pci_alloc_consistent page allocator, so
  * small blocks are easily used by drivers for bus mastering controllers.
@@ -403,3 +405,5 @@
 EXPORT_SYMBOL (pci_pool_destroy);
 EXPORT_SYMBOL (pci_pool_alloc);
 EXPORT_SYMBOL (pci_pool_free);
+
+#endif /* !__dma_slab_flags */
--- ./include-dist/asm-alpha/pci.h	Wed Dec 25 08:49:02 2002
+++ ./include/asm-alpha/pci.h	Mon Dec 30 12:35:11 2002
@@ -81,6 +81,14 @@
 
 extern void pci_free_consistent(struct pci_dev *, size_t, void *, dma_addr_t);
 
+/* kmem_cache style wrapper around pci_alloc_consistent() */
+struct pci_pool *pci_pool_create (const char *name, struct pci_dev *dev,
+		size_t size, size_t align, size_t allocation);
+void pci_pool_destroy (struct pci_pool *pool);
+
+void *pci_pool_alloc (struct pci_pool *pool, int flags, dma_addr_t *handle);
+void pci_pool_free (struct pci_pool *pool, void *vaddr, dma_addr_t addr);
+
 /* Map a single buffer of the indicate size for PCI DMA in streaming
    mode.  The 32-bit PCI bus mastering address to use is returned.
    Once the device is given the dma address, the device owns this memory
--- ./include-dist/asm-arm/pci.h	Wed Dec 25 08:48:18 2002
+++ ./include/asm-arm/pci.h	Mon Dec 30 12:35:29 2002
@@ -76,6 +76,14 @@
 	consistent_free(vaddr, size, dma_handle);
 }
 
+/* kmem_cache style wrapper around pci_alloc_consistent() */
+struct pci_pool *pci_pool_create (const char *name, struct pci_dev *dev,
+		size_t size, size_t align, size_t allocation);
+void pci_pool_destroy (struct pci_pool *pool);
+
+void *pci_pool_alloc (struct pci_pool *pool, int flags, dma_addr_t *handle);
+void pci_pool_free (struct pci_pool *pool, void *vaddr, dma_addr_t addr);
+
 /* Map a single buffer of the indicated size for DMA in streaming mode.
  * The 32-bit bus address to use is returned.
  *
--- ./include-dist/asm-ia64/pci.h	Wed Dec 25 08:47:47 2002
+++ ./include/asm-ia64/pci.h	Mon Dec 30 12:36:21 2002
@@ -58,6 +58,14 @@
 #define sg_dma_address			platform_pci_dma_address
 #define pci_dma_supported		platform_pci_dma_supported
 
+/* kmem_cache style wrapper around pci_alloc_consistent() */
+struct pci_pool *pci_pool_create (const char *name, struct pci_dev *dev,
+		size_t size, size_t align, size_t allocation);
+void pci_pool_destroy (struct pci_pool *pool);
+
+void *pci_pool_alloc (struct pci_pool *pool, int flags, dma_addr_t *handle);
+void pci_pool_free (struct pci_pool *pool, void *vaddr, dma_addr_t addr);
+
 /* pci_unmap_{single,page} is not a nop, thus... */
 #define DECLARE_PCI_UNMAP_ADDR(ADDR_NAME)	\
 	dma_addr_t ADDR_NAME;
--- ./include-dist/asm-mips/pci.h	Wed Dec 25 08:48:27 2002
+++ ./include/asm-mips/pci.h	Mon Dec 30 12:36:52 2002
@@ -77,6 +77,14 @@
 extern void pci_free_consistent(struct pci_dev *hwdev, size_t size,
 				void *vaddr, dma_addr_t dma_handle);
 
+/* kmem_cache style wrapper around pci_alloc_consistent() */
+struct pci_pool *pci_pool_create (const char *name, struct pci_dev *dev,
+		size_t size, size_t align, size_t allocation);
+void pci_pool_destroy (struct pci_pool *pool);
+
+void *pci_pool_alloc (struct pci_pool *pool, int flags, dma_addr_t *handle);
+void pci_pool_free (struct pci_pool *pool, void *vaddr, dma_addr_t addr);
+
 /*
  * Map a single buffer of the indicated size for DMA in streaming mode.
  * The 32-bit bus address to use is returned.
--- ./include-dist/asm-mips64/pci.h	Wed Dec 25 08:49:31 2002
+++ ./include/asm-mips64/pci.h	Mon Dec 30 12:37:04 2002
@@ -70,6 +70,14 @@
 extern void pci_free_consistent(struct pci_dev *hwdev, size_t size,
 				void *vaddr, dma_addr_t dma_handle);
 
+/* kmem_cache style wrapper around pci_alloc_consistent() */
+struct pci_pool *pci_pool_create (const char *name, struct pci_dev *dev,
+		size_t size, size_t align, size_t allocation);
+void pci_pool_destroy (struct pci_pool *pool);
+
+void *pci_pool_alloc (struct pci_pool *pool, int flags, dma_addr_t *handle);
+void pci_pool_free (struct pci_pool *pool, void *vaddr, dma_addr_t addr);
+
 
 #ifdef CONFIG_MAPPED_PCI_IO
 
--- ./include-dist/asm-parisc/pci.h	Wed Dec 25 08:48:31 2002
+++ ./include/asm-parisc/pci.h	Mon Dec 30 12:37:26 2002
@@ -146,6 +146,14 @@
 	void (*dma_sync_sg)(struct pci_dev *dev, struct scatterlist *sg, int nelems, int direction);
 };
 
+/* kmem_cache style wrapper around pci_alloc_consistent() */
+struct pci_pool *pci_pool_create (const char *name, struct pci_dev *dev,
+		size_t size, size_t align, size_t allocation);
+void pci_pool_destroy (struct pci_pool *pool);
+
+void *pci_pool_alloc (struct pci_pool *pool, int flags, dma_addr_t *handle);
+void pci_pool_free (struct pci_pool *pool, void *vaddr, dma_addr_t addr);
+
 
 /*
 ** We could live without the hppa_dma_ops indirection if we didn't want
--- ./include-dist/asm-ppc/pci.h	Wed Dec 25 08:48:02 2002
+++ ./include/asm-ppc/pci.h	Mon Dec 30 12:37:45 2002
@@ -91,6 +91,14 @@
 extern void pci_free_consistent(struct pci_dev *hwdev, size_t size,
 				void *vaddr, dma_addr_t dma_handle);
 
+/* kmem_cache style wrapper around pci_alloc_consistent() */
+struct pci_pool *pci_pool_create (const char *name, struct pci_dev *dev,
+		size_t size, size_t align, size_t allocation);
+void pci_pool_destroy (struct pci_pool *pool);
+
+void *pci_pool_alloc (struct pci_pool *pool, int flags, dma_addr_t *handle);
+void pci_pool_free (struct pci_pool *pool, void *vaddr, dma_addr_t addr);
+
 /* Map a single buffer of the indicated size for DMA in streaming mode.
  * The 32-bit bus address to use is returned.
  *
--- ./include-dist/asm-ppc64/pci.h	Wed Dec 25 08:47:38 2002
+++ ./include/asm-ppc64/pci.h	Mon Dec 30 12:37:53 2002
@@ -43,6 +43,14 @@
 extern void pci_free_consistent(struct pci_dev *hwdev, size_t size,
 				void *vaddr, dma_addr_t dma_handle);
 
+/* kmem_cache style wrapper around pci_alloc_consistent() */
+struct pci_pool *pci_pool_create (const char *name, struct pci_dev *dev,
+		size_t size, size_t align, size_t allocation);
+void pci_pool_destroy (struct pci_pool *pool);
+
+void *pci_pool_alloc (struct pci_pool *pool, int flags, dma_addr_t *handle);
+void pci_pool_free (struct pci_pool *pool, void *vaddr, dma_addr_t addr);
+
 extern dma_addr_t pci_map_single(struct pci_dev *hwdev, void *ptr,
 				 size_t size, int direction);
 extern void pci_unmap_single(struct pci_dev *hwdev, dma_addr_t dma_addr,
--- ./include-dist/asm-sh/pci.h	Wed Dec 25 08:49:37 2002
+++ ./include/asm-sh/pci.h	Mon Dec 30 12:38:03 2002
@@ -71,6 +71,14 @@
 extern void pci_free_consistent(struct pci_dev *hwdev, size_t size,
 				void *vaddr, dma_addr_t dma_handle);
 
+/* kmem_cache style wrapper around pci_alloc_consistent() */
+struct pci_pool *pci_pool_create (const char *name, struct pci_dev *dev,
+		size_t size, size_t align, size_t allocation);
+void pci_pool_destroy (struct pci_pool *pool);
+
+void *pci_pool_alloc (struct pci_pool *pool, int flags, dma_addr_t *handle);
+void pci_pool_free (struct pci_pool *pool, void *vaddr, dma_addr_t addr);
+
 /* Map a single buffer of the indicated size for DMA in streaming mode.
  * The 32-bit bus address to use is returned.
  *
--- ./include-dist/asm-sparc/pci.h	Wed Dec 25 08:49:17 2002
+++ ./include/asm-sparc/pci.h	Mon Dec 30 12:38:13 2002
@@ -47,6 +47,14 @@
  */
 extern void pci_free_consistent(struct pci_dev *hwdev, size_t size, void *vaddr, dma_addr_t dma_handle);
 
+/* kmem_cache style wrapper around pci_alloc_consistent() */
+struct pci_pool *pci_pool_create (const char *name, struct pci_dev *dev,
+		size_t size, size_t align, size_t allocation);
+void pci_pool_destroy (struct pci_pool *pool);
+
+void *pci_pool_alloc (struct pci_pool *pool, int flags, dma_addr_t *handle);
+void pci_pool_free (struct pci_pool *pool, void *vaddr, dma_addr_t addr);
+
 /* Map a single buffer of the indicated size for DMA in streaming mode.
  * The 32-bit bus address to use is returned.
  *
--- ./include-dist/asm-sparc64/pci.h	Wed Dec 25 08:49:25 2002
+++ ./include/asm-sparc64/pci.h	Mon Dec 30 12:38:21 2002
@@ -55,6 +55,14 @@
  */
 extern void pci_free_consistent(struct pci_dev *hwdev, size_t size, void *vaddr, dma_addr_t dma_handle);
 
+/* kmem_cache style wrapper around pci_alloc_consistent() */
+struct pci_pool *pci_pool_create (const char *name, struct pci_dev *dev,
+		size_t size, size_t align, size_t allocation);
+void pci_pool_destroy (struct pci_pool *pool);
+
+void *pci_pool_alloc (struct pci_pool *pool, int flags, dma_addr_t *handle);
+void pci_pool_free (struct pci_pool *pool, void *vaddr, dma_addr_t addr);
+
 /* Map a single buffer of the indicated size for DMA in streaming mode.
  * The 32-bit bus address to use is returned.
  *
--- ./include-dist/asm-v850/pci.h	Wed Dec 25 08:49:46 2002
+++ ./include/asm-v850/pci.h	Mon Dec 30 12:38:36 2002
@@ -74,4 +74,12 @@
 pci_free_consistent (struct pci_dev *pdev, size_t size, void *cpu_addr,
 		     dma_addr_t dma_addr);
 
+/* kmem_cache style wrapper around pci_alloc_consistent() */
+struct pci_pool *pci_pool_create (const char *name, struct pci_dev *dev,
+		size_t size, size_t align, size_t allocation);
+void pci_pool_destroy (struct pci_pool *pool);
+
+void *pci_pool_alloc (struct pci_pool *pool, int flags, dma_addr_t *handle);
+void pci_pool_free (struct pci_pool *pool, void *vaddr, dma_addr_t addr);
+
 #endif /* __V850_PCI_H__ */
--- ./include-dist/asm-x86_64/pci.h	Wed Dec 25 08:47:55 2002
+++ ./include/asm-x86_64/pci.h	Mon Dec 30 12:40:43 2002
@@ -69,6 +69,14 @@
 extern void pci_free_consistent(struct pci_dev *hwdev, size_t size,
 				void *vaddr, dma_addr_t dma_handle);
 
+/* kmem_cache style wrapper around pci_alloc_consistent() */
+struct pci_pool *pci_pool_create (const char *name, struct pci_dev *dev,
+		size_t size, size_t align, size_t allocation);
+void pci_pool_destroy (struct pci_pool *pool);
+
+void *pci_pool_alloc (struct pci_pool *pool, int flags, dma_addr_t *handle);
+void pci_pool_free (struct pci_pool *pool, void *vaddr, dma_addr_t addr);
+
 #ifdef CONFIG_GART_IOMMU
 
 /* Map a single buffer of the indicated size for DMA in streaming mode.

--Boundary_(ID_1cA7JVMRBDqITj0Td4//ug)--
