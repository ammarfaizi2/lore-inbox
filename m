Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750823AbWHPCXj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750823AbWHPCXj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 22:23:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750819AbWHPCXc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 22:23:32 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:3501 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750823AbWHPCXS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 22:23:18 -0400
Date: Tue, 15 Aug 2006 19:22:58 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: mpm@selenic.com
Cc: Marcelo Tosatti <marcelo@kvack.org>, linux-kernel@vger.kernel.org,
       Nick Piggin <nickpiggin@yahoo.com.au>, Andi Kleen <ak@suse.de>,
       Manfred Spraul <manfred@colorfullife.com>, Dave Chinner <dgc@sgi.com>,
       Christoph Lameter <clameter@sgi.com>
Message-Id: <20060816022258.13379.62625.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20060816022238.13379.24081.sendpatchset@schroedinger.engr.sgi.com>
References: <20060816022238.13379.24081.sendpatchset@schroedinger.engr.sgi.com>
Subject: [MODSLAB 4/7] Slabulator: Emulate the existing Slab Layer
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The slab emulation layer.

This provides a layer that implements the existing slab API. Put
a hook into slab.h to redirect include for slab.h.

kmem_cache_create dynamically derives page allocators with the
proper features requested.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.18-rc4/mm/slabulator.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.18-rc4/mm/slabulator.c	2006-08-15 18:36:39.655595826 -0700
@@ -0,0 +1,208 @@
+/*
+ * Slabulator = Emulate the old Slab API and provide various debugging helps.
+ *
+ * (C) 2006 Silicon Graphics, Inc. Christoph Lameter <clameter@sgi.com>
+ *
+ * Important missing things: (breaking stuff!)
+ * 1. Support 2 second cache reaper calls (no pcp draining and VM stat
+ *    update currently!).
+ */
+#include <linux/kmalloc.h>
+#include <linux/module.h>
+#include <linux/allocator.h>
+#include <linux/bitops.h>
+#include <linux/slab.h>
+
+#define SLAB_MAX_ORDER 4
+
+// #define SLABMULATOR_DEBUG
+// #define SLABMULATOR_MERGE
+
+#ifndef ARCH_SLAB_MINALIGN
+#define ARCH_SLAB_MINALIGN sizeof(void *)
+#endif
+
+static int calculate_order(int size)
+{
+	int order;
+	int rem;
+
+	for(order = max(0, fls(size - 1) - PAGE_SHIFT);
+			order < MAX_ORDER; order++) {
+		unsigned long slab_size = PAGE_SIZE << order;
+
+		if (slab_size < size)
+			continue;
+
+		rem = slab_size % size;
+
+		if (rem * 8 <= PAGE_SIZE << order)
+			break;
+
+	}
+	if (order >= MAX_ORDER)
+		return -E2BIG;
+	return order;
+}
+
+/*
+ * Track reclaimable pages using a special allocator
+ */
+static struct derived_page_allocator *reclaim_accounting_allocator;
+
+atomic_t slab_reclaim_pages = ATOMIC_INIT(0);
+EXPORT_SYMBOL(slab_reclaim_pages);
+
+static struct page *rac_alloc(const struct page_allocator *a, int order,
+			gfp_t flags, int node)
+{
+	struct derived_page_allocator *d = (void *)a;
+
+	atomic_add(1 << order, &slab_reclaim_pages);
+	return d->base->allocate(d->base, order, flags, node);
+}
+
+static void rac_free(const struct page_allocator *a, struct page *page,
+							int order)
+{
+	struct derived_page_allocator *d = (void *)a;
+
+	atomic_sub(1 << order, &slab_reclaim_pages);
+	d->base->free(d->base, page, order);
+}
+
+/*
+ * kmem_cache_init() is not particularly useful here. We can actually operate
+ * slabs any time after the page allocator is up (on demand creation of
+ * all necessary structure) and maybe shift the
+ * initialization of the reclaim accounting allocator somewhere else..
+ * But for traditions sake we provide the same mechanism as the slab here.
+ */
+int slabulator_up = 0;
+
+int slab_is_available(void) {
+	return slabulator_up;
+}
+
+void kmem_cache_init(void)
+{
+	reclaim_accounting_allocator = derive_page_allocator(&page_allocator);
+	reclaim_accounting_allocator->a.allocate = rac_alloc;
+	reclaim_accounting_allocator->a.free = rac_free;
+	slabulator_up = 1;
+}
+
+struct slab_cache *kmem_cache_create(const char *name, size_t size,
+		size_t align, unsigned long flags,
+		void (*ctor)(void *, struct slab_cache *, unsigned long),
+		void (*dtor)(void *, struct slab_cache *, unsigned long))
+{
+	const struct page_allocator *a = &page_allocator;
+	unsigned int offset = 0;
+	unsigned int realsize;
+	int order;
+	int inuse;
+	struct slab_cache *s;
+
+	align = max(ARCH_SLAB_MINALIGN, ALIGN(align, sizeof(void *)));
+
+	if (flags & (SLAB_MUST_HWCACHE_ALIGN|SLAB_HWCACHE_ALIGN))
+		align = L1_CACHE_BYTES;
+
+	inuse = size;
+	realsize = ALIGN(size, align);
+
+	/* Pick the right allocator for our purposes */
+	if (flags & SLAB_RECLAIM_ACCOUNT)
+		a = &reclaim_accounting_allocator->a;
+
+	if (flags & SLAB_CACHE_DMA)
+		a = dmaify_page_allocator(a);
+
+	if (flags & SLAB_DESTROY_BY_RCU)
+		a = rcuify_page_allocator(a);
+
+	if ((flags & SLAB_DESTROY_BY_RCU) || ctor || dtor) {
+		/*
+		 * For RCU processing and constructors / destructors:
+		 * The object must remain intact even if it is free.
+		 * The free pointer would hurt us there.
+		 * Relocate the free object pointer out of
+		 * the space used by the object.
+		 */
+		offset = realsize - sizeof(void *);
+		if (offset < size) {
+			/*
+			 * Would overlap the object. We need to waste some
+			 * more space to make the object RCU safe
+			 */
+			offset = realsize;
+			realsize += align;
+		}
+		inuse = realsize;
+	}
+
+	order = calculate_order(realsize);
+
+	if (order < 0)
+		goto error;
+
+#ifdef SLABMULATOR_MERGE
+	/*
+	 * This works but is this really something we want?
+	 */
+	if (((realsize & (realsize - 1))==0) && !ctor && !dtor &&
+		   !(flags & (SLAB_DESTROY_BY_RCU|SLAB_RECLAIM_ACCOUNT))) {
+		a->destructor((struct page_allocator *)a);
+
+		printk(KERN_CRIT "Merging slab %s size %d to kmalloc\n",
+				name, realsize);
+		return slabulator_allocator.dup(kmalloc_slab(realsize, flags));
+	}
+#endif
+
+	s = slabulator_allocator.create(&slabulator_allocator, a, -1, name,
+			realsize, align, order, size, inuse, offset);
+#ifdef SLABMULATOR_DEBUG
+	printk(KERN_CRIT "Creating slab %s size=%ld realsize=%d "
+			"order=%d offset=%d flags=%lx\n",
+			name, size, realsize, order, offset, flags);
+#endif
+	if (!s)
+		goto error;
+
+	/*
+	 * Now deal with constuctors and destructors. We need to know the
+	 * slab_cache address in order to be able to pass the slab_cache
+	 * address down the chain.
+	 */
+	if (ctor || dtor)
+		s->page_alloc =
+			ctor_and_dtor_for_page_allocator(s->page_alloc,
+				realsize, s,
+				(void *)ctor, (void *)dtor);
+
+	return s;
+
+error:
+	a->destructor((struct page_allocator *)a);
+	if (flags & SLAB_PANIC)
+		panic("Cannot create slab %s size=%ld realsize=%d "
+			"order=%d offset=%d flags=%lx\n",
+			name, size, realsize, order, offset, flags);
+
+
+	return NULL;
+}
+EXPORT_SYMBOL(kmem_cache_create);
+
+void *kmem_cache_zalloc(struct slab_cache *s, gfp_t flags)
+{
+	void *x;
+
+	x = kmem_cache_alloc(s, flags);
+	if (x)
+		memset(x, 0, s->objsize);
+	return x;
+}
+
Index: linux-2.6.18-rc4/include/linux/slabulator.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.18-rc4/include/linux/slabulator.h	2006-08-15 18:37:11.758106635 -0700
@@ -0,0 +1,128 @@
+/*
+ * Slabulator: Emulate the existing Slab API.
+ *
+ * (C) 2006 Silicon Graphics, Inc.
+ *		Christoph Lameter <clameter@sgi.com>
+ *
+ * The use of this API necessarily restrict the user to a single type
+ * of Slab allocator and the functions available.
+ */
+
+#include <linux/allocator.h>
+#include <linux/kmalloc.h>
+
+#define kmem_cache_t	struct slab_cache
+#define kmem_cache	slab_cache
+
+#define ____kmalloc kmalloc
+#define __kmalloc kmalloc
+
+#ifdef CONFIG_NUMA_SLAB
+#define slabulator_allocator numa_slab_allocator
+#else
+#define slabulator_allocator slabifier_allocator
+#endif
+
+/* We really should be getting rid of these */
+#define	SLAB_KERNEL		GFP_KERNEL
+#define	SLAB_ATOMIC		GFP_ATOMIC
+#define	SLAB_NOFS		GFP_NOFS
+
+/* No debug features for now */
+#define	SLAB_HWCACHE_ALIGN	0x00002000UL	/* align objs on a h/w cache lines */
+#define SLAB_CACHE_DMA		0x00004000UL	/* use GFP_DMA memory */
+#define SLAB_MUST_HWCACHE_ALIGN	0x00008000UL	/* force alignment */
+#define SLAB_RECLAIM_ACCOUNT	0x00020000UL	/* track pages allocated to indicate
+						   what is reclaimable later*/
+#define SLAB_PANIC		0x00040000UL	/* panic if kmem_cache_create() fails */
+#define SLAB_DESTROY_BY_RCU	0x00080000UL	/* defer freeing pages to RCU */
+#define SLAB_MEM_SPREAD		0x00100000UL	/* Spread some memory over cpuset */
+
+/* flags passed to a constructor func */
+#define	SLAB_CTOR_CONSTRUCTOR	0x001UL		/* if not set, then deconstructor */
+#define SLAB_CTOR_ATOMIC	0x002UL		/* tell constructor it can't sleep */
+#define	SLAB_CTOR_VERIFY	0x004UL		/* tell constructor it's a verify call */
+
+
+/*
+ * slab_allocators are always available on demand after the page allocator
+ * has been brought up but for completenesses sake:
+ */
+extern int slab_is_available(void);
+extern void kmem_cache_init(void);
+
+/* System wide caches (Should these be really here?) */
+extern struct slab_cache *vm_area_cachep;
+extern struct slab_cache *names_cachep;
+extern struct slab_cache *files_cachep;
+extern struct slab_cache *filp_cachep;
+extern struct slab_cache *fs_cachep;
+extern struct slab_cache *sighand_cachep;
+extern struct slab_cache *bio_cachep;
+
+/* And this really would be be placed with the reclaim code ? */
+extern atomic_t slab_reclaim_pages;
+
+
+extern struct slab_cache *kmem_cache_create(const char *name, size_t size, size_t align,
+	unsigned long flags,
+	void (*ctor)(void *, struct slab_cache *, unsigned long),
+	void (*dtor)(void *, struct slab_cache *, unsigned long));
+
+static inline unsigned int kmem_cache_size(struct slab_cache *s)
+{
+	return s->objsize;
+}
+
+static inline const char *kmem_cache_name(struct slab_cache *s)
+{
+	return s->name;
+}
+
+static inline void *kmem_cache_alloc(struct slab_cache *s, gfp_t flags)
+{
+	return slabulator_allocator.alloc(s, flags);
+}
+
+static inline void *kmem_cache_alloc_node(struct slab_cache *s,
+					gfp_t flags, int node)
+{
+	return slabulator_allocator.alloc_node(s, flags, node);
+}
+
+extern void *kmem_cache_zalloc(struct slab_cache *s, gfp_t flags);
+
+static inline void kmem_cache_free(struct slab_cache *s, const void *x)
+{
+	slabulator_allocator.free(s, x);
+}
+
+static inline int kmem_ptr_validate(struct slab_cache *s, void *x)
+{
+	return slabulator_allocator.valid_pointer(s, x);
+}
+
+static inline int kmem_cache_destroy(struct slab_cache *s)
+{
+	return slabulator_allocator.destroy(s);
+}
+
+static inline int kmem_cache_shrink(struct slab_cache *s)
+{
+	return slabulator_allocator.shrink(s, NULL);
+}
+
+/**
+ * kcalloc - allocate memory for an array. The memory is set to zero.
+ * @n: number of elements.
+ * @size: element size.
+ * @flags: the type of memory to allocate.
+ */
+static inline void *kcalloc(size_t n, size_t size, gfp_t flags)
+{
+	if (n != 0 && size > ULONG_MAX / n)
+		return NULL;
+	return kzalloc(n * size, flags);
+}
+
+
Index: linux-2.6.18-rc4/mm/Makefile
===================================================================
--- linux-2.6.18-rc4.orig/mm/Makefile	2006-08-15 18:35:04.744461494 -0700
+++ linux-2.6.18-rc4/mm/Makefile	2006-08-15 18:36:39.656572329 -0700
@@ -24,6 +24,5 @@ obj-$(CONFIG_SLAB) += slab.o
 obj-$(CONFIG_MEMORY_HOTPLUG) += memory_hotplug.o
 obj-$(CONFIG_FS_XIP) += filemap_xip.o
 obj-$(CONFIG_MIGRATION) += migrate.o
-obj-$(CONFIG_MODULAR_SLAB) += allocator.o kmalloc.o
-
+obj-$(CONFIG_MODULAR_SLAB) += allocator.o kmalloc.o slabulator.o
 
Index: linux-2.6.18-rc4/init/Kconfig
===================================================================
--- linux-2.6.18-rc4.orig/init/Kconfig	2006-08-06 11:20:11.000000000 -0700
+++ linux-2.6.18-rc4/init/Kconfig	2006-08-15 18:36:39.657548831 -0700
@@ -403,6 +403,16 @@ config SLAB
 	  SLOB is more space efficient but does not scale well and is
 	  more susceptible to fragmentation.
 
+config MODULAR_SLAB
+	default n
+	bool "Use the modular slab allocator frameworkr"
+	depends on EXPERIMENTAL
+	help
+	 The modular slab allocator framework allows the flexible use
+	 of different slab allocators and page allocators for memory
+	 allocation. This will completely replace the existing
+	 slab allocator. Beware this is experimental code.
+
 config VM_EVENT_COUNTERS
 	default y
 	bool "Enable VM event counters for /proc/vmstat" if EMBEDDED
@@ -424,7 +434,7 @@ config BASE_SMALL
 	default 1 if !BASE_FULL
 
 config SLOB
-	default !SLAB
+	default !SLAB && !MODULAR_SLAB
 	bool
 
 menu "Loadable module support"
Index: linux-2.6.18-rc4/include/linux/slab.h
===================================================================
--- linux-2.6.18-rc4.orig/include/linux/slab.h	2006-08-06 11:20:11.000000000 -0700
+++ linux-2.6.18-rc4/include/linux/slab.h	2006-08-15 18:36:39.657548831 -0700
@@ -9,6 +9,10 @@
 
 #if	defined(__KERNEL__)
 
+#ifdef CONFIG_MODULAR_SLAB
+#include <linux/slabulator.h>
+#else
+
 typedef struct kmem_cache kmem_cache_t;
 
 #include	<linux/gfp.h>
@@ -265,6 +269,8 @@ extern kmem_cache_t	*bio_cachep;
 
 extern atomic_t slab_reclaim_pages;
 
+#endif /* CONFIG_SLABULATOR */
+
 #endif	/* __KERNEL__ */
 
 #endif	/* _LINUX_SLAB_H */
