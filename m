Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263413AbUGACwl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263413AbUGACwl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 22:52:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263752AbUGACwl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 22:52:41 -0400
Received: from stat1.steeleye.com ([65.114.3.130]:56454 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S263413AbUGACw1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 22:52:27 -0400
Subject: [PATCH] provide x86 implementation of on-chip coherent memory API
	for DMA
From: James Bottomley <James.Bottomley@steeleye.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: an Molton <spyro@f2s.com>, tony@atomide.com, jamey.hicks@hp.com,
       joshua@joshuawise.com, david-b@pacbell.net,
       Russell King <rmk@arm.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 30 Jun 2004 21:52:24 -0500
Message-Id: <1088650346.1887.12.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This touches several areas, as you can see from the patch descriptions,
but almost completely implements the API for x86 (there are actually
three separate patches in this).

James

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/06/30 21:38:34-05:00 jejb@mulgrave.(none) 
#   Add x86 implementation of dma_declare_coherent_memory
#   
#   This actually implements the API (all except for
#   DMA_MEMORY_INCLUDES_CHILDREN).
# 
# include/linux/device.h
#   2004/06/30 21:37:55-05:00 jejb@mulgrave.(none) +3 -0
#   Add x86 implementation of dma_declare_coherent_memory
# 
# include/asm-i386/dma-mapping.h
#   2004/06/30 21:37:55-05:00 jejb@mulgrave.(none) +12 -0
#   Add x86 implementation of dma_declare_coherent_memory
# 
# arch/i386/kernel/pci-dma.c
#   2004/06/30 21:37:55-05:00 jejb@mulgrave.(none) +109 -2
#   Add x86 implementation of dma_declare_coherent_memory
# 
# ChangeSet
#   2004/06/30 21:11:14-05:00 jejb@mulgrave.(none) 
#   Add vmalloc alignment constraints
#   
#   vmalloc is used by ioremap() to get regions for
#   remapping I/O space.  To feed these regions back
#   into a __get_free_pages() type memory allocator,
#   they are expected to have more alignment than 
#   get_vm_area() proves.  So add additional alignment
#   constraints for VM_IOREMAP.
# 
# mm/vmalloc.c
#   2004/06/30 21:10:54-05:00 jejb@mulgrave.(none) +18 -2
#   Add vmalloc alignment constraints
# 
# ChangeSet
#   2004/06/30 21:08:15-05:00 jejb@mulgrave.(none) 
#   Add memory region bitmap implementations
#   
#   These APIs deal with bitmaps representing contiguous
#   memory regions.  The idea is to set, free and find
#   a contiguous area.
#   
#   For ease of implementation (as well as to conform
#   to the standard requirements), the bitmaps always
#   return n aligned n length regions.  The implementation
#   is also limited to BITS_PER_LONG contiguous regions.
# 
# lib/bitmap.c
#   2004/06/30 21:07:26-05:00 jejb@mulgrave.(none) +76 -0
#   Add memory region bitmap implementations
# 
# include/linux/bitmap.h
#   2004/06/30 21:07:26-05:00 jejb@mulgrave.(none) +3 -0
#   Add memory region bitmap implementations
# 
diff -Nru a/arch/i386/kernel/pci-dma.c b/arch/i386/kernel/pci-dma.c
--- a/arch/i386/kernel/pci-dma.c	2004-06-30 21:51:26 -05:00
+++ b/arch/i386/kernel/pci-dma.c	2004-06-30 21:51:26 -05:00
@@ -13,17 +13,40 @@
 #include <linux/pci.h>
 #include <asm/io.h>
 
+struct dma_coherent_mem {
+	void		*virt_base;
+	u32		device_base;
+	int		size;
+	int		flags;
+	unsigned long	*bitmap;
+};
+
 void *dma_alloc_coherent(struct device *dev, size_t size,
 			   dma_addr_t *dma_handle, int gfp)
 {
 	void *ret;
+	struct dma_coherent_mem *mem = dev->dma_mem;
+	int order = get_order(size);
 	/* ignore region specifiers */
 	gfp &= ~(__GFP_DMA | __GFP_HIGHMEM);
 
+	if (mem) {
+		int page = bitmap_find_free_region(mem->bitmap, mem->size,
+						     order);
+		if (page >= 0) {
+			*dma_handle = mem->device_base + (page << PAGE_SHIFT);
+			ret = mem->virt_base + (page << PAGE_SHIFT);
+			memset(ret, 0, size);
+			return ret;
+		}
+		if (mem->flags & DMA_MEMORY_EXCLUSIVE)
+			return NULL;
+	}
+
 	if (dev == NULL || (dev->coherent_dma_mask < 0xffffffff))
 		gfp |= GFP_DMA;
 
-	ret = (void *)__get_free_pages(gfp, get_order(size));
+	ret = (void *)__get_free_pages(gfp, order);
 
 	if (ret != NULL) {
 		memset(ret, 0, size);
@@ -35,5 +58,89 @@
 void dma_free_coherent(struct device *dev, size_t size,
 			 void *vaddr, dma_addr_t dma_handle)
 {
-	free_pages((unsigned long)vaddr, get_order(size));
+	struct dma_coherent_mem *mem = dev->dma_mem;
+	int order = get_order(size);
+	
+	if (mem && vaddr >= mem->virt_base && vaddr < (mem->virt_base + (mem->size << PAGE_SHIFT))) {
+		int page = (vaddr - mem->virt_base) >> PAGE_SHIFT;
+
+		bitmap_release_region(mem->bitmap, page, order);
+	} else
+		free_pages((unsigned long)vaddr, order);
+}
+
+int dma_declare_coherent_memory(struct device *dev, dma_addr_t bus_addr,
+				dma_addr_t device_addr, size_t size, int flags)
+{
+	void *mem_base;
+	int pages = size >> PAGE_SHIFT;
+	int bitmap_size = (pages + 31)/32;
+
+	if ((flags & (DMA_MEMORY_MAP | DMA_MEMORY_IO)) == 0)
+		goto out;
+	if (!size)
+		goto out;
+	if (dev->dma_mem)
+		goto out;
+
+	/* FIXME: this routine just ignores DMA_MEMORY_INCLUDES_CHILDREN */
+
+	mem_base = ioremap(bus_addr, size);
+	if (!mem_base)
+		goto out;
+
+	dev->dma_mem = kmalloc(GFP_KERNEL, sizeof(struct dma_coherent_mem));
+	if (!dev->dma_mem)
+		goto out;
+	memset(dev->dma_mem, 0, sizeof(struct dma_coherent_mem));
+	dev->dma_mem->bitmap = kmalloc(GFP_KERNEL, bitmap_size);
+	if (!dev->dma_mem->bitmap)
+		goto free1_out;
+	memset(dev->dma_mem->bitmap, 0, bitmap_size);
+
+	dev->dma_mem->virt_base = mem_base;
+	dev->dma_mem->device_base = device_addr;
+	dev->dma_mem->size = pages;
+	dev->dma_mem->flags = flags;
+
+	if (flags & DMA_MEMORY_MAP)
+		return DMA_MEMORY_MAP;
+
+	return DMA_MEMORY_IO;
+
+ free1_out:
+	kfree(dev->dma_mem->bitmap);
+ out:
+	return 0;
+}
+EXPORT_SYMBOL(dma_declare_coherent_memory);
+
+void dma_release_declared_memory(struct device *dev)
+{
+	struct dma_coherent_mem *mem = dev->dma_mem;
+	
+	if(!mem)
+		return;
+	dev->dma_mem = NULL;
+	kfree(mem->bitmap);
+	kfree(mem);
+}
+EXPORT_SYMBOL(dma_release_declared_memory);
+
+void *dma_mark_declared_memory_occupied(struct device *dev,
+					dma_addr_t device_addr, size_t size)
+{
+	struct dma_coherent_mem *mem = dev->dma_mem;
+	int pages = (size + PAGE_SIZE - 1) >> PAGE_SHIFT;
+	int pos, err;
+
+	if (!mem)
+		return ERR_PTR(-EINVAL);
+
+	pos = (device_addr - mem->device_base) >> PAGE_SHIFT;
+	err = bitmap_allocate_region(mem->bitmap, pos, get_order(pages));
+	if (err != 0)
+		return ERR_PTR(err);
+	return mem->virt_base + (pos << PAGE_SHIFT);
 }
+EXPORT_SYMBOL(dma_mark_declared_memory_occupied);
diff -Nru a/include/asm-i386/dma-mapping.h b/include/asm-i386/dma-mapping.h
--- a/include/asm-i386/dma-mapping.h	2004-06-30 21:51:26 -05:00
+++ b/include/asm-i386/dma-mapping.h	2004-06-30 21:51:26 -05:00
@@ -163,4 +163,16 @@
 	flush_write_buffers();
 }
 
+#define ARCH_HAS_DMA_DECLARE_COHERENT_MEMORY
+extern int
+dma_declare_coherent_memory(struct device *dev, dma_addr_t bus_addr,
+			    dma_addr_t device_addr, size_t size, int flags);
+
+extern void
+dma_release_declared_memory(struct device *dev);
+
+extern void *
+dma_mark_declared_memory_occupied(struct device *dev,
+				  dma_addr_t device_addr, size_t size);
+
 #endif
diff -Nru a/include/linux/bitmap.h b/include/linux/bitmap.h
--- a/include/linux/bitmap.h	2004-06-30 21:51:26 -05:00
+++ b/include/linux/bitmap.h	2004-06-30 21:51:26 -05:00
@@ -98,6 +98,9 @@
 			const unsigned long *src, int nbits);
 extern int bitmap_parse(const char __user *ubuf, unsigned int ulen,
 			unsigned long *dst, int nbits);
+extern int bitmap_find_free_region(unsigned long *bitmap, int bits, int order);
+extern void bitmap_release_region(unsigned long *bitmap, int pos, int order);
+extern int bitmap_allocate_region(unsigned long *bitmap, int pos, int order);
 
 #define BITMAP_LAST_WORD_MASK(nbits)					\
 (									\
diff -Nru a/include/linux/device.h b/include/linux/device.h
--- a/include/linux/device.h	2004-06-30 21:51:26 -05:00
+++ b/include/linux/device.h	2004-06-30 21:51:26 -05:00
@@ -283,6 +283,9 @@
 
 	struct list_head	dma_pools;	/* dma pools (if dma'ble) */
 
+	struct dma_coherent_mem	*dma_mem; /* internal for coherent mem
+					     override */
+
 	void	(*release)(struct device * dev);
 };
 
diff -Nru a/lib/bitmap.c b/lib/bitmap.c
--- a/lib/bitmap.c	2004-06-30 21:51:26 -05:00
+++ b/lib/bitmap.c	2004-06-30 21:51:26 -05:00
@@ -408,3 +408,79 @@
 	return 0;
 }
 EXPORT_SYMBOL(bitmap_parse);
+
+/**
+ *	bitmap_find_free_region - find a contiguous aligned mem region
+ *	@bitmap: an array of unsigned longs corresponding to the bitmap
+ *	@bits: number of bits in the bitmap
+ *	@order: region size to find (size is actually 1<<order)
+ *
+ * This is used to allocate a memory region from a bitmap.  The idea is
+ * that the region has to be 1<<order sized and 1<<order aligned (this
+ * makes the search algorithm much faster).
+ *
+ * The region is marked as set bits in the bitmap if a free one is
+ * found.
+ *
+ * Returns either beginning of region or negative error
+ */
+int bitmap_find_free_region(unsigned long *bitmap, int bits, int order)
+{
+	unsigned long mask;
+	int pages = 1 << order;
+	int i;
+
+	if(pages > BITS_PER_LONG)
+		return -EINVAL;
+
+	/* make a mask of the order */
+	mask = (1ul << (pages - 1));
+	mask += mask - 1;
+
+	/* run up the bitmap pages bits at a time */
+	for (i = 0; i < bits; i += pages) {
+		int index = BITS_TO_LONGS(i);
+		int offset = i - (index * BITS_PER_LONG);
+		if((bitmap[index] & (mask << offset)) == 0) {
+			/* set region in bimap */
+			bitmap[index] |= (mask << offset);
+			return i;
+		}
+	}
+	return -ENOMEM;
+}
+EXPORT_SYMBOL(bitmap_find_free_region);
+
+/**
+ *	bitmap_release_region - release allocated bitmap region
+ *	@bitmap: a pointer to the bitmap
+ *	@pos: the beginning of the region
+ *	@order: the order of the bits to release (number is 1<<order)
+ *
+ * This is the complement to __bitmap_find_free_region and releases
+ * the found region (by clearing it in the bitmap).
+ */
+void bitmap_release_region(unsigned long *bitmap, int pos, int order)
+{
+	int pages = 1 << order;
+	unsigned long mask = (1ul << (pages - 1));
+	int index = BITS_TO_LONGS(pos);
+	int offset = pos - (index * BITS_PER_LONG);
+	mask += mask - 1;
+	bitmap[index] &= ~(mask << offset);
+}
+EXPORT_SYMBOL(bitmap_release_region);
+
+int bitmap_allocate_region(unsigned long *bitmap, int pos, int order)
+{
+	int pages = 1 << order;
+	unsigned long mask = (1ul << (pages - 1));
+	int index = BITS_TO_LONGS(pos);
+	int offset = pos - (index * BITS_PER_LONG);
+	mask += mask - 1;
+	if (bitmap[index] & (mask << offset))
+		return -EBUSY;
+	bitmap[index] |= (mask << offset);
+	return 0;
+}
+EXPORT_SYMBOL(bitmap_allocate_region);
diff -Nru a/mm/vmalloc.c b/mm/vmalloc.c
--- a/mm/vmalloc.c	2004-06-30 21:51:26 -05:00
+++ b/mm/vmalloc.c	2004-06-30 21:51:26 -05:00
@@ -179,11 +179,27 @@
 	return err;
 }
 
+#define IOREMAP_MAX_ORDER	(3 + PAGE_SHIFT)	/* 8 pages */
+
 struct vm_struct *__get_vm_area(unsigned long size, unsigned long flags,
 				unsigned long start, unsigned long end)
 {
 	struct vm_struct **p, *tmp, *area;
-	unsigned long addr = start;
+	unsigned long align = 1;
+	unsigned long addr;
+
+	if (flags & VM_IOREMAP) {
+		int bit = fls(size);
+
+		if (bit > IOREMAP_MAX_ORDER)
+			bit = IOREMAP_MAX_ORDER;
+		else if (bit < PAGE_SHIFT)
+			bit = PAGE_SHIFT;
+
+		align = 1ul << bit;
+	}
+	addr = ALIGN(start, align);
+
 
 	area = kmalloc(sizeof(*area), GFP_KERNEL);
 	if (unlikely(!area))
@@ -206,7 +222,7 @@
 			goto out;
 		if (size + addr <= (unsigned long)tmp->addr)
 			goto found;
-		addr = tmp->size + (unsigned long)tmp->addr;
+		addr = ALIGN(tmp->size + (unsigned long)tmp->addr, align);
 		if (addr > end - size)
 			goto out;
 	}

