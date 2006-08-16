Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750815AbWHPCX3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750815AbWHPCX3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 22:23:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750830AbWHPCX3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 22:23:29 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:64172 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750815AbWHPCXI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 22:23:08 -0400
Date: Tue, 15 Aug 2006 19:22:48 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: mpm@selenic.com
Cc: Marcelo Tosatti <marcelo@kvack.org>, linux-kernel@vger.kernel.org,
       Nick Piggin <nickpiggin@yahoo.com.au>, Andi Kleen <ak@suse.de>,
       Manfred Spraul <manfred@colorfullife.com>, Dave Chinner <dgc@sgi.com>,
       Christoph Lameter <clameter@sgi.com>
Message-Id: <20060816022248.13379.52440.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20060816022238.13379.24081.sendpatchset@schroedinger.engr.sgi.com>
References: <20060816022238.13379.24081.sendpatchset@schroedinger.engr.sgi.com>
Subject: [MODSLAB 2/7] Allocator Framework and misc features
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add allocator abstraction

The allocator abstraction layer provides sources of pages for the slabifier.
Various basic sources of pages are provided (regular, vmalloc, numa
node memory) and some modifiers (rcuify, dma etc). The slabifier will use
those sources of pages as the source of memory on top of which it sets up
its slab structures.

Signed-off-by: Christoph Lameter <clameter>.

Index: linux-2.6.18-rc4/mm/Makefile
===================================================================
--- linux-2.6.18-rc4.orig/mm/Makefile	2006-08-13 23:26:17.597328068 -0700
+++ linux-2.6.18-rc4/mm/Makefile	2006-08-15 15:09:06.168282639 -0700
@@ -24,4 +24,5 @@ obj-$(CONFIG_SLAB) += slab.o
 obj-$(CONFIG_MEMORY_HOTPLUG) += memory_hotplug.o
 obj-$(CONFIG_FS_XIP) += filemap_xip.o
 obj-$(CONFIG_MIGRATION) += migrate.o
+obj-$(CONFIG_MODULAR_SLAB) += allocator.o
 
Index: linux-2.6.18-rc4/include/linux/allocator.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.18-rc4/include/linux/allocator.h	2006-08-15 16:18:38.379110868 -0700
@@ -0,0 +1,233 @@
+#ifndef _LINUX_ALLOCATOR_H
+#define _LINUX_ALLOCATOR_H
+
+/*
+ * Generic API to memory allocators.
+ * (C) 2006 Silicon Graphics, Inc,
+ *	Christoph Lameter <clameter@sgi.com>
+ */
+#include <linux/gfp.h>
+
+/*
+ * Page allocators
+ *
+ * Page allocators are sources of memory in pages. They basically only
+ * support allocation and freeing of pages. The interesting thing
+ * is how these pages are obtained. Plus with these methods
+ * we can add things in between the page allocator a use
+ * of the page allocator to add things without too much
+ * effort . This allows us to encapsulate new features.
+ *
+ * New allocators could be added f.e. for specialized memory pools.
+ */
+
+struct page_allocator {
+	struct page *(*allocate)(const struct page_allocator *, int order,
+		gfp_t mask, int node);
+	void (*free)(const struct page_allocator *, struct page *, int order);
+	void (*destructor) (struct page_allocator *);
+	const char *name;
+};
+
+/* Some known page allocators */
+extern const struct page_allocator page_allocator;
+extern const struct page_allocator vmalloc_allocator;
+
+/*
+ * Generators for new allocators based on known allocators
+ *
+ * These behave like modifiers to already generated or
+ * existing allocators. May be combined at will.
+ */
+
+/*
+ * A way to free all pages via RCU. The RCU head is placed in the
+ * struct page so this fully transparent and does not require any
+ * allocation and freeing of memory.
+ */
+struct page_allocator *rcuify_page_allocator
+			(const struct page_allocator *base);
+
+/*
+ * Make an allocation via a specific allocator always return
+ * DMA memory.
+ */
+struct page_allocator *dmaify_page_allocator
+			(const struct page_allocator *base);
+
+/*
+ * This provides a constructor and a destructor call for each object
+ * on a page. The constructors and destructors calling conventions
+ * are compatible with the existing slab implementation. However,
+ * this implementation assumes that the objects always start at offset 0.
+ *
+ * The main use of these is to provide a generic forrm of constructors
+ * and destructors. These run after a page was allocated and before
+ * a page is freed.
+ */
+struct page_allocator *ctor_and_dtor_for_page_allocator
+	(const struct page_allocator *, unsigned long size, void *private,
+		void (*ctor)(void *, void *, unsigned long),
+                void (*dtor)(void *, void *, unsigned long));
+
+#ifdef CONFIG_NUMA
+/*
+ * Allocator that allows the customization of the NUMA behavior of an
+ * allocator. If a node is specified then the allocator will always try
+ * to allocate on that node. Flags set are ORed for every allocation.
+ * F.e. one can set GFP_THISNODE to force an allocation on a particular node
+ * or on a local node.
+ */
+struct page_allocator *numactl_allocator(const struct page_allocator *,
+						int node, gfp_t flags);
+#endif
+
+/* Tools to make your own */
+struct derived_page_allocator {
+	struct page_allocator a;
+	const struct page_allocator *base;
+};
+
+void derived_destructor(struct page_allocator *a);
+
+struct derived_page_allocator *derive_page_allocator(
+				const struct page_allocator *base);
+
+/*
+ * Slab allocators
+ */
+
+
+/*
+ * A slab cache structure is generated by a slab allocator when the
+ * create method is invoked.
+ */
+struct slab_cache {
+	const struct slab_allocator *slab_alloc;
+	const struct page_allocator *page_alloc;
+	int node;		/* Node passed to page allocator */
+	const char *name;	/* Name (only for display!) */
+	int size;		/* The size of a chunk on a slab */
+	int align;		/* Alignment requirements */
+	int objsize;		/* The size of an object that is in a chunk */
+	int inuse;		/* Used portion of the chunk */
+	int offset;		/* Offset to the freelist pointer */
+	unsigned int order;	/* Size of the slab page */
+};
+
+struct slab_allocator {
+	/*
+	 * Create an actually usable slab cache from a slab allocator
+	 */
+	struct slab_cache *(*create)(const struct slab_allocator *,
+		const struct page_allocator *a, int node, const char *name,
+		int size, int align, int order, int objsize, int inuse,
+		int offset);
+
+	/* Allocation functions */
+	void *(*alloc)(struct slab_cache *, gfp_t);
+	void *(*alloc_node)(struct slab_cache *, gfp_t, int);
+	void (*free)(struct slab_cache *, const void *);
+
+	/* Object checks */
+	int (*valid_pointer)(struct slab_cache *, const void *object);
+	unsigned long (*object_size)(struct slab_cache *, const void *);
+
+	/*
+	 * Determine slab statistics in units of slabs. Returns the
+	 * number of total pages used by the slab cache.
+	 * active are the pages under allocation or empty
+	 * partial are the number of partial slabs.
+	 */
+	unsigned long (*objects)(struct slab_cache *, unsigned long *active,
+			unsigned long *partial);
+
+	/*
+	 * shrink defragments a slab cache by moving objects from sparsely
+	 * populated slabs to others. slab shrink will terminate when there
+	 * is only one fragmented slab left.
+	 *
+	 * The move_object function must be supplied otherwise shrink can only
+	 * free pages that are competely empty.
+	 *
+	 * move_object gets a slab_cache pointer and an object pointer. The
+	 * function must reallocate another object and move the contents
+	 * from this object into the new object. Then the function should
+	 * return 1 for success. If it return 0 then the object is pinned.
+	 * the slab that the object resides on will not be freed.
+	 */
+	int (*shrink)(struct slab_cache *,
+			int (*move_object)(struct slab_cache *, void *));
+
+	/*
+	 * The NUMA slab provides an array of slab caches. This is a means
+	 * to get to the slab cache on a particular node. But beware!
+	 * The resulting slab_cache belongs to another allocator.
+	 */
+	struct slab_cache *(*node)(struct slab_cache *, int node);
+
+	/*
+	 * Establish a new reference so that destroy does not
+	 * unecessarilyl destroy the slab_cache
+	 */
+	struct slab_cache * (*dup)(struct slab_cache *);
+	int (*destroy)(struct slab_cache *);
+	void (*destructor)(struct slab_allocator *);
+	const char *name;
+};
+
+/* Standard slab allocators */
+extern const struct slab_allocator slab_allocator;	/* The original one */
+extern const struct slab_allocator slob_allocator;
+extern const struct slab_allocator slabifier_allocator;
+
+/* Use page allocator for slab (allocation size in pages) */
+extern struct slab_allocator page_slab_allocator;
+
+/* Access kmalloc's fixed slabs without creating new ones. */
+extern struct slab_allocator kmalloc_slab_allocator;
+
+#ifdef CONFIG_NUMA
+extern const struct slab_allocator numa_slab_allocator;
+#endif
+
+/* Generate new slab allocators based on old ones */
+struct slab_allocator *rcuify_slab(struct slab_allocator *base);
+struct slab_allocator *dmaify_slab(struct slab_allocator *base);
+struct slab_allocator *redzone_slab(struct slab_allocator *base);
+struct slab_allocator *track_slab(struct slab_allocator *base);
+struct slab_allocator *trace_slab(struct slab_allocator *base);
+
+/* Tools to make your own slab allocators */
+static inline void slab_allocator_fill(struct slab_cache *sc,
+	const struct slab_allocator *slab_alloc,
+	const struct page_allocator *page_alloc, int node,
+	const char *name, int size, int align,
+		int order, int objsize, int inuse, int offset)
+{
+	sc->slab_alloc = slab_alloc;
+	sc->page_alloc = page_alloc;
+	sc->node = node;
+	sc->name = name;
+	sc->size = size;
+	sc->align = align;
+	sc->order = order;
+	sc->objsize = objsize;
+	sc->inuse = inuse;
+	sc->offset = offset;
+}
+
+/* Indestructible static allocators use this. */
+void null_slab_allocator_destructor(struct slab_allocator *);
+
+struct derived_slab_allocator {
+	struct slab_allocator a;
+	const struct slab_allocator *base;
+};
+
+void derived_slab_destructor(struct slab_allocator *a);
+
+struct derived_slab_allocator *derive_slab_allocator(
+			const struct slab_allocator *base);
+
+#endif /* _LINUX_ALLOCATOR_H */
Index: linux-2.6.18-rc4/mm/allocator.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.18-rc4/mm/allocator.c	2006-08-15 16:17:27.996739026 -0700
@@ -0,0 +1,411 @@
+/*
+ * Generic Allocator Functions for the slabifier
+ *
+ * This abstracts pagesize based order N allocators.
+ *
+ * (C) 2006 Silicon Graphics, Inc. Christoph Lameter <clameter@sgi.com>
+ */
+
+#include <linux/allocator.h>
+#include <linux/vmalloc.h>
+#include <linux/mm.h>
+
+/* For static allocators */
+
+static void null_destructor(struct page_allocator *a)
+{
+}
+
+/*
+ * Static allocators
+ */
+
+/*
+ * The page allocator that can allocate all of memory
+ */
+static struct page *gen_alloc(const struct page_allocator *a, int order,
+		gfp_t flags, int node)
+{
+	if (order)
+		flags |= __GFP_COMP;
+#ifdef CONFIG_NUMA
+	if (node >=0)
+		return alloc_pages_node(flags, order, node);
+#endif
+	return alloc_pages(flags, order);
+}
+
+static void gen_free(const struct page_allocator *a, struct page *page,
+							int order)
+{
+	__free_pages(page, order);
+}
+
+const struct page_allocator page_allocator = {
+	.allocate = gen_alloc,
+	.free = gen_free,
+	.destructor = null_destructor,
+	.name = "page_allocator"
+};
+
+/*
+ * Allocate vmalloc memory
+ */
+static struct page *vmalloc_alloc(const struct page_allocator *a, int order,
+		gfp_t flags, int node)
+{
+	void *addr;
+
+#ifdef CONFIG_NUMA
+	if (node >= 0)
+		addr = vmalloc_node(PAGE_SIZE << order, node);
+	else
+#endif
+	addr = vmalloc(PAGE_SIZE << order);
+
+	if (!addr)
+		return NULL;
+
+	return virt_to_page(addr);
+}
+
+static void vmalloc_free(const struct page_allocator *a,
+				 struct page *page, int order)
+{
+	vfree(page_address(page));
+}
+
+const struct page_allocator vmalloc_allocator = {
+	.allocate = vmalloc_alloc,
+	.free = vmalloc_free,
+	.destructor = null_destructor,
+	.name = "vmalloc_allocator"
+};
+
+/*
+ * Functions to deal with dynamically generating allocators.
+ */
+void derived_destructor(struct page_allocator *a)
+{
+	struct derived_page_allocator *d = (void *)a;
+
+	d->base->destructor((struct page_allocator *)d->base);
+	kfree(a);
+}
+
+/*
+ * Create a new allocator based on another one. All functionality
+ * is duplicated except for the destructor. The caller needs to do
+ * modifications to some of the methods in the copy.
+ */
+struct derived_page_allocator *derive_page_allocator
+		(const struct page_allocator *base)
+{
+	struct derived_page_allocator *d =
+		kmalloc(sizeof(struct derived_page_allocator), GFP_KERNEL);
+
+	d->a.allocate = base->allocate;
+	d->a.free = base->free;
+	d->a.name = "derived";
+	d->a.destructor = derived_destructor;
+	d->base = base;
+	return d;
+};
+
+/*
+ * RCU allocator generator
+ *
+ * We overload struct page once more for the RCU data
+ * lru = RCU head
+ * index = order
+ * mapping = base allocator
+ */
+static void page_free_rcu(struct rcu_head *h)
+{
+	struct page *page;
+	struct page_allocator * base;
+	int order = page->index;
+
+ 	page = container_of((struct list_head *)h, struct page, lru);
+	base = (void *)page->mapping;
+	order = page->index;
+	page->index = 0;
+	page->mapping = NULL;
+	base->free(base, page, order);
+}
+
+/*
+ * Use page struct as intermediate rcu storage.
+ */
+static void rcu_free(const struct page_allocator *a, struct page *page,
+							 int order)
+{
+	struct rcu_head *head = (void *)&page->lru;
+	struct derived_page_allocator *d = (void *)a;
+
+	page->index = order;
+	page->mapping = (void *)d->base;
+	call_rcu(head, page_free_rcu);
+}
+
+struct page_allocator *rcuify_page_allocator
+			(const struct page_allocator *base)
+{
+	struct derived_page_allocator *d = derive_page_allocator(base);
+
+	d->a.free = rcu_free;
+	d->a.name = "rcu";
+	return &d->a;
+};
+
+/*
+ * Restrict memory allocations to DMA
+ */
+static struct page *dma_alloc(const struct page_allocator *a, int order,
+						gfp_t flags, int node)
+{
+	struct derived_page_allocator *d = (void *)a;
+
+	return d->base->allocate(d->base, order, flags | __GFP_DMA, node);
+}
+
+struct page_allocator *dmaify_page_allocator
+			(const struct page_allocator *base)
+{
+	struct derived_page_allocator *d = derive_page_allocator(base);
+
+	d->a.allocate = dma_alloc;
+	d->a.name = "dma";
+	return &d->a;
+}
+
+/*
+ * Allocator with constructur and destructor in fixed sized length
+ * in the page.
+ */
+struct deconstructor {
+	struct page_allocator a;
+	const struct page_allocator *base;
+	unsigned int size;
+	void *private;
+	void (*ctor)(void *, void *, unsigned long);
+        void (*dtor)(void *, void *, unsigned long);
+};
+
+static struct page *ctor_alloc(const struct page_allocator *a,
+				int order, gfp_t flags, int node)
+{
+	struct deconstructor *d = (void *)a;
+	struct page * page = d->base->allocate(d->base, order, flags, node);
+
+	if (d->ctor) {
+		void *start = page_address(page);
+		void *end = start + (PAGE_SIZE << order);
+		void *p;
+
+		for (p = start; p <= end - d->size; p += d->size)
+		/* Make the flags of the constructor compatible with SLAB use */
+			d->ctor(p, d->private, 1 + !(flags & __GFP_WAIT));
+	}
+	return page;
+}
+
+static void dtor_free(const struct page_allocator *a,
+				struct page *page, int order)
+{
+	struct deconstructor *d = (void *)a;
+
+	if (d->dtor) {
+		void *start = page_address(page);
+		void *end = start + (PAGE_SIZE << order);
+		void *p;
+
+		for (p = start; p <= end - d->size; p += d->size)
+			d->dtor(p, d->private, 0);
+	}
+	d->base->free(d->base, page, order);
+}
+
+struct page_allocator *ctor_and_dtor_for_page_allocator
+	(const struct page_allocator *base,
+		size_t size, void *private,
+		void (*ctor)(void *, void *, unsigned long),
+		void (*dtor)(void *, void *, unsigned long))
+{
+	struct deconstructor *d =
+		kmalloc(sizeof(struct deconstructor), GFP_KERNEL);
+
+	d->a.allocate = ctor ? ctor_alloc : base->allocate;
+	d->a.free = dtor ? dtor_free : base->free;
+	d->a.destructor = derived_destructor;
+	d->a.name = "ctor_dtor";
+	d->base = base;
+	d->ctor = ctor;
+	d->dtor = dtor;
+	d->size = size;
+	d->private = private;
+	return &d->a;
+}
+
+
+/*
+ * Slab allocators
+ */
+
+/* Tools to make your own */
+void null_slab_allocator_destructor(struct slab_allocator *a)
+{
+}
+
+void derived_slab_destructor(struct slab_allocator *a) {
+	struct derived_slab_allocator *d = (void *)a;
+
+	d->base->destructor((struct slab_allocator *)d->base);
+	kfree(d);
+}
+
+struct derived_slab_allocator *derive_slab_allocator(
+			const struct slab_allocator *base) {
+	struct derived_slab_allocator *d =
+		 kmalloc(sizeof(struct derived_slab_allocator), GFP_KERNEL);
+
+	memcpy(&d->a, base, sizeof(struct slab_allocator));
+	d->base = base;
+	d->a.name = "derived";
+	d->a.destructor = derived_slab_destructor;
+	return d;
+}
+
+/* Generate a new slab allocators based on old ones */
+
+/*
+ * First a generic method to rcuify any slab. We add the rcuhead
+ * to the end of the object and use that on free.
+ */
+
+struct rcuified_slab {
+	struct slab_allocator *a;
+	const struct slab_allocator *base;
+	unsigned int rcu_offset;
+};
+
+/*
+ * Information that is added to the end of the slab
+ */
+struct slabr {
+	struct rcu_head r;
+	struct slab_cache *s;
+};
+
+struct slab_cache *rcuify_slab_create(const struct slab_allocator *sa,
+	const struct page_allocator *pa, int node,
+	const char *name, int size, int align, int order,
+		int  objsize, int inuse, int offset)
+{
+	struct rcuified_slab *d = (void *)sa;
+
+	inuse = d->rcu_offset = ALIGN(inuse, sizeof(void *));
+	inuse += sizeof(struct slabr) + sizeof(void *);
+	while (inuse > size)
+		size += align;
+
+	return d->base->create(d->base, pa, node, name, size, align,
+				order, objsize, inuse, offset);
+}
+
+void rcu_slab_free(struct rcu_head *rcu)
+{
+	struct slabr *r = (void *) rcu;
+	struct slab_cache *s = r->s;
+	struct rcuified_slab *d = (void *)s->slab_alloc;
+	void *object = (void *)object - d->rcu_offset;
+
+	d->base->free(s, object);
+}
+
+void rcuify_slab_free(struct slab_cache *s, const void *object)
+{
+	struct rcuified_slab *r = (struct rcuified_slab *)(s->slab_alloc);
+
+	call_rcu((struct rcu_head *)(object + r->rcu_offset), rcu_slab_free);
+}
+
+struct slab_allocator *rcuify_slab_allocator
+			(const struct slab_allocator *base)
+{
+	struct derived_slab_allocator *d = derive_slab_allocator(base);
+
+	d->a.create = rcuify_slab_create;
+	d->a.free = rcuify_slab_free;
+	d->a.name = "rcu";
+	return &d->a;
+}
+
+
+/*
+ * dmaification of slab allocation. This is done by dmaifying the
+ * underlying page allocator.
+ */
+
+struct slab_cache *dmaify_slab_create(const struct slab_allocator *s,
+		const struct page_allocator *a, int node, const char *name,
+		int size, int align, int order, int objsize, int inuse,
+		int offset)
+{
+	struct derived_slab_allocator *d = (void *)s;
+
+	return d->base->create(s, dmaify_page_allocator(a), node, name,
+			size, align, order, objsize, inuse, offset);
+}
+
+struct slab_allocator *dmaify_slab_allocator
+			(const struct slab_allocator *base)
+{
+	struct derived_slab_allocator *d = derive_slab_allocator(base);
+
+	d->a.create = dmaify_slab_create;
+	d->a.name = "dma";
+	return &d->a;
+}
+
+#if 0
+/*
+ * Generic Redzoning support works by adding a word at the end
+ * of an object and filling up to the beginning of the next
+ * object (depending on the gap between objects).
+ *
+ * The fillings are different on free and allocate so that
+ * we can check on each if the object or the guard area was
+ * corrupted.
+ */
+struct slab_allocator *redzone_slab_allocator(struct slab_allocator *base)
+{
+	struct derived_slab_allocat *d = derive_slab_allcator(base);
+
+	d->create = redzone_create;
+	d->alloc = redzone_alloc;
+	d->free = redzone_free;
+	return &d->aL;
+}
+
+/*
+ * Object tracking adds two words to the end of the slab that track
+ * the latest allocator and the last freeer of the object.
+ */
+struct slab_allocator *track_slab_allocator(struct slab_allocator *base)
+{
+	return NULL;
+}
+
+/*
+ * Write to the syslog whenever something happens on a slab.
+ *
+ * CAUTION: Do not try this on busy system slabs.
+ */
+struct slab_allocator *trace_slab_allocator(struct slab_allocator *base)
+{
+	return NULL;
+}
+#endif
+
+
