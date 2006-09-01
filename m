Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751130AbWIAWel@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751130AbWIAWel (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 18:34:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751131AbWIAWel
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 18:34:41 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:38116 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751130AbWIAWek (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 18:34:40 -0400
Date: Fri, 1 Sep 2006 15:34:19 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: akpm@osdl.org
Cc: Pekka Enberg <penberg@cs.helsinki.fi>, Marcelo Tosatti <marcelo@kvack.org>,
       linux-kernel@vger.kernel.org, Nick Piggin <nickpiggin@yahoo.com.au>,
       linux-mm@kvack.org, Christoph Lameter <clameter@sgi.com>,
       mpm@selenic.com, Manfred Spraul <manfred@colorfullife.com>,
       Dave Chinner <dgc@sgi.com>, Andi Kleen <ak@suse.de>
Message-Id: <20060901223419.21034.99272.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20060901223358.21034.83736.sendpatchset@schroedinger.engr.sgi.com>
References: <20060901223358.21034.83736.sendpatchset@schroedinger.engr.sgi.com>
Subject: [MODSLAB 4/5] Kmalloc subsystem
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A generic kmalloc layer for the modular slab

Regular kmalloc allocations are optimized. DMA kmalloc slabs are
created on demand.

Also re exports the kmalloc array as a new slab_allocator that
can be used to tie into the kmalloc array (the slabulator
uses that to avoid creating new slabs that are compatible
with generic kmalloc caches).

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.18-rc5-mm1/include/linux/kmalloc.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.18-rc5-mm1/include/linux/kmalloc.h	2006-09-01 11:54:43.745232343 -0700
@@ -0,0 +1,136 @@
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
+#ifndef KMALLOC_ALLOCATOR
+#define KMALLOC_ALLOCATOR slabifier_allocator
+#endif
+
+#define KMALLOC_SHIFT_LOW 3
+
+#define KMALLOC_SHIFT_HIGH 18
+
+#if L1_CACHE_BYTES <= 64
+#define KMALLOC_EXTRAS 2
+#define KMALLOC_EXTRA
+#else
+#define KMALLOC_EXTRAS 0
+#endif
+
+#define KMALLOC_NR_CACHES (KMALLOC_SHIFT_HIGH - KMALLOC_SHIFT_LOW \
+			 + 1 + KMALLOC_EXTRAS)
+/*
+ * We keep the general caches in an array of slab caches that are used for
+ * 2^x bytes of allocations. For each size we generate a DMA and a
+ * non DMA cache (DMA simply means memory for legacy I/O. The regular
+ * caches can be used for devices that can DMA to all of memory).
+ */
+extern struct slab_control kmalloc_caches[KMALLOC_NR_CACHES];
+
+/*
+ * Sorry that the following has to be that ugly but GCC has trouble
+ * with constant propagation and loops.
+ */
+static inline int kmalloc_index(int size)
+{
+	if (size <=    8) return 3;
+	if (size <=   16) return 4;
+	if (size <=   32) return 5;
+	if (size <=   64) return 6;
+#ifdef KMALLOC_EXTRA
+	if (size <=   96) return KMALLOC_SHIFT_HIGH + 1;
+#endif
+	if (size <=  128) return 7;
+#ifdef KMALLOC_EXTRA
+	if (size <=  192) return KMALLOC_SHIFT_HIGH + 2;
+#endif
+	if (size <=  256) return 8;
+	if (size <=  512) return 9;
+	if (size <= 1024) return 10;
+	if (size <= 2048) return 11;
+	if (size <= 4096) return 12;
+	if (size <=   8 * 1024) return 13;
+	if (size <=  16 * 1024) return 14;
+	if (size <=  32 * 1024) return 15;
+	if (size <=  64 * 1024) return 16;
+	if (size <= 128 * 1024) return 17;
+	if (size <= 256 * 1024) return 18;
+	return -1;
+}
+
+/*
+ * Find the slab cache for a given combination of allocation flags and size.
+ *
+ * This ought to end up with a global pointer to the right cache
+ * in kmalloc_caches.
+ */
+static inline struct slab_cache *kmalloc_slab(size_t size)
+{
+	int index = kmalloc_index(size) - KMALLOC_SHIFT_LOW;
+
+	if (index < 0) {
+		/*
+		 * Generate a link failure. Would be great if we could
+		 * do something to stop the compile here.
+		 */
+		extern void __kmalloc_size_too_large(void);
+		__kmalloc_size_too_large();
+	}
+	return &kmalloc_caches[index].sc;
+}
+
+extern void *__kmalloc(size_t, gfp_t);
+#define ____kmalloc __kmalloc
+
+static inline void *kmalloc(size_t size, gfp_t flags)
+{
+	if (__builtin_constant_p(size) && !(flags & __GFP_DMA)) {
+		struct slab_cache *s = kmalloc_slab(size);
+
+		return KMALLOC_ALLOCATOR.alloc(s, flags);
+	} else
+		return __kmalloc(size, flags);
+}
+
+#ifdef CONFIG_NUMA
+extern void *__kmalloc_node(size_t, gfp_t, int);
+static inline void *kmalloc_node(size_t size, gfp_t flags, int node)
+{
+	if (__builtin_constant_p(size) && !(flags & __GFP_DMA)) {
+		struct slab_cache *s = kmalloc_slab(size);
+
+		return KMALLOC_ALLOCATOR.alloc_node(s, flags, node);
+	} else
+		return __kmalloc_node(size, flags, node);
+}
+#else
+#define kmalloc_node(__size, __flags, __node) kmalloc((__size), (__flags))
+#endif
+
+/* Free an object */
+static inline void kfree(const void *x)
+{
+	return KMALLOC_ALLOCATOR.free(NULL, x);
+}
+
+/* Allocate and zero the specified number of bytes */
+extern void *kzalloc(size_t, gfp_t);
+
+/* Figure out what size the chunk is */
+extern size_t ksize(const void *);
+
+extern struct page_allocator *reclaimable_allocator;
+extern struct page_allocator *unreclaimable_allocator;
+
+extern int slab_min_order;
+
+#endif	/* _LINUX_KMALLOC_H */
Index: linux-2.6.18-rc5-mm1/mm/kmalloc.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.18-rc5-mm1/mm/kmalloc.c	2006-09-01 11:56:08.877659139 -0700
@@ -0,0 +1,226 @@
+/*
+ * Create generic slab caches for memory allocation.
+ *
+ * (C) 2006 Silicon Graphics. Inc. Christoph Lameter <clameter@sgi.com>
+ */
+
+#include <linux/mm.h>
+#include <linux/allocator.h>
+#include <linux/module.h>
+#include <linux/kmalloc.h>
+#include <linux/slabstat.h>
+
+#ifndef ARCH_KMALLOC_MINALIGN
+#define ARCH_KMALLOC_MINALIGN sizeof(void *)
+#endif
+
+struct slab_control kmalloc_caches[KMALLOC_NR_CACHES] __cacheline_aligned;
+EXPORT_SYMBOL(kmalloc_caches);
+
+static struct page_allocator *dma_allocator;
+struct page_allocator *reclaimable_allocator;
+struct page_allocator *unreclaimable_allocator;
+
+/*
+ * Mininum order of slab pages. This influences locking overhead and slab
+ * fragmentation. A higher order reduces the number of partial slabs
+ * and increases the number of allocations possible without having to
+ * take the list_lock.
+ */
+int slab_min_order = 0;
+EXPORT(slab_min_order);
+
+static struct slab_cache *kmalloc_caches_dma[KMALLOC_NR_CACHES];
+
+static int __init setup_slab_min_order(char *str)
+{
+	get_option (&str, &slab_min_order);
+
+	return 1;
+}
+
+__setup("slab_min_order=", setup_slab_min_order);
+
+/*
+ * Given a slab size find the correct order to use.
+ * We only support powers of two so there is really
+ * no need for anything special. Objects will always
+ * fit exactly into the slabs with no overhead.
+ */
+static int order(size_t size)
+{
+	unsigned long base_size = PAGE_SIZE << slab_min_order;
+
+	if (size >= base_size)
+		/* One object per slab */
+		return fls(size -1) - PAGE_SHIFT;
+
+	return slab_min_order;
+}
+
+static struct slab_cache *create_kmalloc_cache(struct slab_control *x,
+		const char *name,
+		const struct page_allocator *p,
+		int size)
+{
+	struct slab_cache s;
+	struct slab_cache *rs;
+
+	s.page_alloc = p;
+	s.slab_alloc = &KMALLOC_ALLOCATOR;
+	s.size = size;
+	s.align = ARCH_KMALLOC_MINALIGN;
+	s.offset = 0;
+	s.objsize = size;
+	s.inuse = size;
+	s.node = -1;
+	s.order = order(size);
+	s.name = "kmalloc";
+	rs = KMALLOC_ALLOCATOR.create(x, &s);
+	if (!rs)
+		panic("Creation of kmalloc slab %s size=%d failed.\n",
+			name, size);
+	register_slab(rs);
+	return rs;
+}
+
+static struct slab_cache *get_slab(size_t size, gfp_t flags)
+{
+	int index = kmalloc_index(size) - KMALLOC_SHIFT_LOW;
+	struct slab_cache *s;
+	struct slab_control *x;
+	size_t realsize;
+
+	BUG_ON(size < 0);
+
+	if (!(flags & __GFP_DMA))
+		return &kmalloc_caches[index].sc;
+
+	s = kmalloc_caches_dma[index];
+	if (s)
+		return s;
+
+	/* Dynamically create dma cache */
+	x = kmalloc(sizeof(struct slab_control), flags & ~(__GFP_DMA));
+
+	if (!x)
+		panic("Unable to allocate memory for dma cache\n");
+
+#ifdef KMALLOC_EXTRA
+	if (index <= KMALLOC_SHIFT_HIGH - KMALLOC_SHIFT_LOW)
+#endif
+		realsize = 1 << index;
+#ifdef KMALLOC_EXTRA
+	else if (index = KMALLOC_EXTRA)
+		realsize = 96;
+	else
+		realsize = 192;
+#endif
+
+	s = create_kmalloc_cache(x, "kmalloc_dma", dma_allocator, realsize);
+	kmalloc_caches_dma[index] = s;
+	return s;
+}
+
+void *__kmalloc(size_t size, gfp_t flags)
+{
+	return KMALLOC_ALLOCATOR.alloc(get_slab(size, flags), flags);
+}
+EXPORT_SYMBOL(__kmalloc);
+
+#ifdef CONFIG_NUMA
+void *__kmalloc_node(size_t size, gfp_t flags, int node)
+{
+	return KMALLOC_ALLOCATOR.alloc_node(get_slab(size, flags),
+							flags, node);
+}
+EXPORT_SYMBOL(__kmalloc_node);
+#endif
+
+void *kzalloc(size_t size, gfp_t flags)
+{
+	void *x = __kmalloc(size, flags);
+
+	if (x)
+		memset(x, 0, size);
+	return x;
+}
+EXPORT_SYMBOL(kzalloc);
+
+size_t ksize(const void *object)
+{
+	return KMALLOC_ALLOCATOR.object_size(NULL, object);
+};
+EXPORT_SYMBOL(ksize);
+
+/*
+ * Provide the kmalloc array as regular slab allocator for the
+ * generic allocator framework.
+ */
+struct slab_allocator kmalloc_slab_allocator;
+
+static struct slab_cache *kmalloc_create(struct slab_control *x,
+	const struct slab_cache *s)
+{
+	struct slab_cache *km;
+
+	int index = max(0, fls(s->size - 1) - KMALLOC_SHIFT_LOW);
+
+	if (index > KMALLOC_SHIFT_HIGH - KMALLOC_SHIFT_LOW + 1
+			|| s->offset)
+		return NULL;
+
+	km = &kmalloc_caches[index].sc;
+
+	BUG_ON(s->size > km->size);
+
+	return KMALLOC_ALLOCATOR.dup(km);
+}
+
+static void null_destructor(struct page_allocator *x) {}
+
+void __init kmalloc_init(void)
+{
+	int i;
+
+	for (i =  KMALLOC_SHIFT_LOW; i <= KMALLOC_SHIFT_HIGH; i++) {
+		create_kmalloc_cache(
+			&kmalloc_caches[i - KMALLOC_SHIFT_LOW],
+			"kmalloc", &page_allocator, 1 << i);
+	}
+#ifdef KMALLOC_EXTRA
+	/* Non-power of two caches */
+	create_kmalloc_cache(&kmalloc_caches
+		[KMALLOC_SHIFT_HIGH - KMALLOC_SHIFT_LOW + 1], name,
+						&page_allocator, 96);
+	create_kmalloc_cache(&kmalloc_caches
+		[KMALLOC_SHIFT_HIGH - KMALLOC_SHIFT_LOW + 2], name,
+						&page_allocator, 192);
+#endif
+
+	/*
+	 * The above must be done first. Deriving a page allocator requires
+	 * a working (normal) kmalloc array.
+	 */
+	unreclaimable_allocator = unreclaimable_slab(&page_allocator);
+	unreclaimable_allocator->destructor = null_destructor;
+
+	/*
+	 * Fix up the initial arrays. Because of the precending uses
+	 * we likely have consumed a couple of pages that we cannot account
+	 * for.
+	 */
+	for(i = 0; i < KMALLOC_NR_CACHES; i++)
+		kmalloc_caches[i].sc.page_alloc = unreclaimable_allocator;
+
+	reclaimable_allocator = reclaimable_slab(&page_allocator);
+	reclaimable_allocator->destructor = null_destructor;
+	dma_allocator = dmaify_page_allocator(unreclaimable_allocator);
+
+	/* And deal with the kmalloc_cache_allocator */
+	memcpy(&kmalloc_slab_allocator, &KMALLOC_ALLOCATOR,
+			sizeof(struct slab_allocator));
+	kmalloc_slab_allocator.create = kmalloc_create;
+	kmalloc_slab_allocator.destructor = null_slab_allocator_destructor;
+}
+
Index: linux-2.6.18-rc5-mm1/mm/Makefile
===================================================================
--- linux-2.6.18-rc5-mm1.orig/mm/Makefile	2006-09-01 11:54:04.735927776 -0700
+++ linux-2.6.18-rc5-mm1/mm/Makefile	2006-09-01 11:54:06.508279026 -0700
@@ -28,4 +28,4 @@ obj-$(CONFIG_MEMORY_HOTPLUG) += memory_h
 obj-$(CONFIG_FS_XIP) += filemap_xip.o
 obj-$(CONFIG_MIGRATION) += migrate.o
 obj-$(CONFIG_SMP) += allocpercpu.o
-obj-$(CONFIG_MODULAR_SLAB) += allocator.o slabifier.o slabstat.o
+obj-$(CONFIG_MODULAR_SLAB) += allocator.o slabifier.o slabstat.o kmalloc.o
Index: linux-2.6.18-rc5-mm1/include/asm-i386/page.h
===================================================================
--- linux-2.6.18-rc5-mm1.orig/include/asm-i386/page.h	2006-08-27 20:41:48.000000000 -0700
+++ linux-2.6.18-rc5-mm1/include/asm-i386/page.h	2006-09-01 11:54:06.508279026 -0700
@@ -37,6 +37,7 @@
 
 #define alloc_zeroed_user_highpage(vma, vaddr) alloc_page_vma(GFP_HIGHUSER | __GFP_ZERO, vma, vaddr)
 #define __HAVE_ARCH_ALLOC_ZEROED_USER_HIGHPAGE
+#define ARCH_NEEDS_SMALL_SLABS
 
 /*
  * These are used to make use of C type-checking..

-- 
VGER BF report: H 0.220347
