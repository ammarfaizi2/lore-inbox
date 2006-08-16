Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750801AbWHPCYp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750801AbWHPCYp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 22:24:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750824AbWHPCXa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 22:23:30 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:429 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750819AbWHPCXL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 22:23:11 -0400
Date: Tue, 15 Aug 2006 19:22:53 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: mpm@selenic.com
Cc: Marcelo Tosatti <marcelo@kvack.org>, linux-kernel@vger.kernel.org,
       Nick Piggin <nickpiggin@yahoo.com.au>, Andi Kleen <ak@suse.de>,
       Christoph Lameter <clameter@sgi.com>, Dave Chinner <dgc@sgi.com>,
       Manfred Spraul <manfred@colorfullife.com>
Message-Id: <20060816022253.13379.76984.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20060816022238.13379.24081.sendpatchset@schroedinger.engr.sgi.com>
References: <20060816022238.13379.24081.sendpatchset@schroedinger.engr.sgi.com>
Subject: [MODSLAB 3/7] A Kmalloc subsystem
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kmalloc layer for the modular slab

New ideas:

1. Generate slabs on the fly (May have issues with GFP_KERNEL).

2. use fls to calculate array position.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.18-rc4/include/linux/kmalloc.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.18-rc4/include/linux/kmalloc.h	2006-08-15 18:37:47.757837824 -0700
@@ -0,0 +1,72 @@
+#ifndef _LINUX_KMALLOC_H
+#define _LINUX_KMALLOC_H
+/*
+ * In kernel dynamic memory allocator.
+ *
+ * (C) 2006 Silicon Graphics, Inc,
+ * 		Christoph Lameter <clameter@sgi.com>
+ */
+
+#include <linux/allocator.h>
+#include <linux/config.h>
+#include <linux/types.h>
+
+#ifdef CONFIG_NUMA_SLAB
+#define kmalloc_allocator numa_slab_allocator
+#else
+#define kmalloc_allocator slabifier_allocator
+#endif
+
+/*
+ * We keep the general caches in an array of slab caches that are used for
+ * 2^x bytes of allocations. For each size we generate a DMA and a
+ * non DMA cache (Do not get confused: DMA simply means memory for
+ * legacy I/O. The regular caches can be used for devices that can
+ * do DMA to all of memory).
+ */
+extern struct slab_cache *kmalloc_caches[2][BITS_PER_LONG];
+
+struct slab_cache *kmalloc_generate_slab(int index, gfp_t flags);
+
+/*
+ * Find (and possibly create) the slab cache for a given combination of
+ * allocation flags and size.
+ *
+ * Believe it or not but this should result in a simple load
+ * from a global memory address for a constant flag and size,
+ * a comparison and two function calls with the same parameters.
+ */
+static inline struct slab_cache *kmalloc_slab(size_t size, gfp_t flags)
+{
+	struct slab_cache *s;
+	int index = fls(size - 1);
+
+	s = kmalloc_caches[!!(flags & __GFP_DMA)][index];
+	if (!s)
+		s = kmalloc_generate_slab(index, flags);
+	return s;
+}
+
+static inline void *kmalloc(size_t size, gfp_t flags)
+{
+	return kmalloc_allocator.alloc(kmalloc_slab(size, flags), flags);
+}
+
+static inline void *kmalloc_node(size_t size, gfp_t flags, int node)
+{
+	return kmalloc_allocator.alloc_node(kmalloc_slab(size, flags),
+			 flags, node);
+}
+
+static inline void kfree(const void *x)
+{
+	kmalloc_allocator.free(NULL, x);
+}
+
+/* Allocate and zero the specified number of bytes */
+extern void *kzalloc(size_t, gfp_t);
+
+/* Figure out what size the chunk is */
+extern size_t ksize(const void *);
+
+#endif	/* _LINUX_KMALLOC_H */
Index: linux-2.6.18-rc4/mm/kmalloc.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.18-rc4/mm/kmalloc.c	2006-08-15 18:35:04.744461494 -0700
@@ -0,0 +1,114 @@
+/*
+ * Implement basic generic caches for memory allocation.
+ *
+ * This is an on demand implementation. General slabs
+ * are only created if there is an actual need for allocations
+ * of that size.
+ *
+ * (C) 2006 Silicon Graphics. Inc. Christoph Lameter <clameter@sgi.com>
+ */
+
+#include <linux/mm.h>
+#include <linux/allocator.h>
+#include <linux/module.h>
+
+// #define KMALLOC_DEBUG
+
+struct slab_cache *kmalloc_caches[2][BITS_PER_LONG] __cacheline_aligned;
+EXPORT_SYMBOL(kmalloc_caches);
+
+/* Smallest size of a cache in 2^x */
+#define LOW 5		/* 32 byte */
+
+#if BITS_PER_LONG == 64
+/* 64 bit platform. Maximum size is 2 Gigabyte */
+#define HIGH 31
+#else
+/* 32 bit. Take the customary max of 128k */
+#define HIGH 17
+#endif
+
+/*
+ * Given a slab size find the correct order to use.
+ * We only support powers of two so there is really
+ * no need for anything special. Objects will always
+ * fit exactly into the slabs.
+ */
+static int order(size_t size)
+{
+	if (size >= PAGE_SIZE)
+		/* One object per slab */
+		return fls(size -1) - PAGE_SHIFT + 1;
+
+	/* Multiple objects but let slab_create() figure out how much */
+	return 0;
+}
+
+static DEFINE_SPINLOCK(kmalloc_lock);
+
+/*
+ * Create a general slab
+ */
+struct slab_cache *kmalloc_generate_slab(int index, gfp_t flags)
+{
+	int dma = !!(flags & __GFP_DMA);
+	struct slab_cache *s;
+	long realsize;
+	const struct page_allocator *a = &page_allocator;
+
+#ifdef KMALLOC_DEBUG
+	printk(KERN_CRIT "kmalloc_generate_slab(%d, %x)\n", index, flags);
+#endif
+	if (index < LOW) {
+		s = kmalloc_caches[dma][LOW];
+		if (s) {
+			kmalloc_caches[dma][index] = s;
+			return s;
+		}
+		index = LOW;
+	}
+
+	if (index > HIGH) {
+		printk(KERN_CRIT "Kmalloc size(%ld) too large.\n",
+							 1L << index);
+		BUG();
+	}
+
+	realsize = 1 << index;
+
+	if (dma)
+		a = dmaify_page_allocator(a);
+
+	s = kmalloc_allocator.create(&kmalloc_allocator, a, -1,
+		dma ? "kmalloc-DMA" : "kmalloc", realsize,
+		L1_CACHE_BYTES, order(realsize), realsize, realsize, 0);
+
+	if (!s)
+		panic("Creation of kmalloc slab dma=%d index=%d failed.\n",
+			dma, index);
+	spin_lock_irq(&kmalloc_lock);
+	if (kmalloc_caches[dma][index])
+		kmalloc_allocator.destroy(s);
+	else
+		kmalloc_caches[dma][index] = s;
+	spin_unlock_irq(&kmalloc_lock);
+	return s;
+}
+EXPORT_SYMBOL(kmalloc_generate_slab);
+
+void *kzalloc(size_t size, gfp_t flags)
+{
+	void *x = kmalloc(size, flags);
+
+	if (x)
+		memset(x, 0, size);
+	return x;
+}
+EXPORT_SYMBOL(kzalloc);
+
+size_t ksize(const void *object)
+{
+	return kmalloc_allocator.object_size(NULL, object);
+};
+EXPORT_SYMBOL(ksize);
+
Index: linux-2.6.18-rc4/mm/Makefile
===================================================================
--- linux-2.6.18-rc4.orig/mm/Makefile	2006-08-15 18:35:03.591212358 -0700
+++ linux-2.6.18-rc4/mm/Makefile	2006-08-15 18:35:04.744461494 -0700
@@ -24,5 +24,6 @@ obj-$(CONFIG_SLAB) += slab.o
 obj-$(CONFIG_MEMORY_HOTPLUG) += memory_hotplug.o
 obj-$(CONFIG_FS_XIP) += filemap_xip.o
 obj-$(CONFIG_MIGRATION) += migrate.o
-obj-$(CONFIG_MODULAR_SLAB) += allocator.o
+obj-$(CONFIG_MODULAR_SLAB) += allocator.o kmalloc.o
+
 
