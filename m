Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751153AbWIAWgH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751153AbWIAWgH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 18:36:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751144AbWIAWez
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 18:34:55 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:42980 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751138AbWIAWet (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 18:34:49 -0400
Date: Fri, 1 Sep 2006 15:34:03 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: akpm@osdl.org
Cc: Pekka Enberg <penberg@cs.helsinki.fi>, Marcelo Tosatti <marcelo@kvack.org>,
       linux-kernel@vger.kernel.org, Nick Piggin <nickpiggin@yahoo.com.au>,
       linux-mm@kvack.org, Christoph Lameter <clameter@sgi.com>,
       mpm@selenic.com, Andi Kleen <ak@suse.de>, Dave Chinner <dgc@sgi.com>,
       Manfred Spraul <manfred@colorfullife.com>
Message-Id: <20060901223403.21034.56997.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20060901223358.21034.83736.sendpatchset@schroedinger.engr.sgi.com>
References: <20060901223358.21034.83736.sendpatchset@schroedinger.engr.sgi.com>
Subject: [MODSLAB 1/5] Generic Allocator Framework
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add allocator abstraction

The allocator abstraction layer provides sources of pages for the slabifier
and it provides ways to customize the slabifier to ones needs (one can
put dmaificiation, rcuification and so on of slab frees etc on top of the
standard page allocator).

The allocator framework also provides a means for deriving new slab
allocators from old ones. That way features can be added in a generic way.
It would be possible to add rcu for slab objects or debugging in that
fashion.

The object-oriented style of deconstructing the allocators has the
advantage that we can deal with small pieces of code that add special
functionality. The overall framework makes it easy to replace pieces
and evolve the whole allocator systems in a faster way.

It also provides a generic way to operate on different allocators.

It is no problem to define a new allocator that allocates from
memory pools and then use the slab allocator on that memory pool.

The code in mm/allocators.c provides some examples what could be
done with derived allocators.

Signed-off-by: Christoph Lameter <clameter>.

Index: linux-2.6.18-rc5-mm1/mm/Makefile
===================================================================
--- linux-2.6.18-rc5-mm1.orig/mm/Makefile	2006-09-01 10:13:42.824597049 -0700
+++ linux-2.6.18-rc5-mm1/mm/Makefile	2006-09-01 11:47:50.231748544 -0700
@@ -28,3 +28,4 @@ obj-$(CONFIG_MEMORY_HOTPLUG) += memory_h
 obj-$(CONFIG_FS_XIP) += filemap_xip.o
 obj-$(CONFIG_MIGRATION) += migrate.o
 obj-$(CONFIG_SMP) += allocpercpu.o
+obj-$(CONFIG_MODULAR_SLAB) += allocator.o
Index: linux-2.6.18-rc5-mm1/include/linux/allocator.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.18-rc5-mm1/include/linux/allocator.h	2006-09-01 11:47:23.782211182 -0700
@@ -0,0 +1,221 @@
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
+ * effort. This allows us to encapsulate new features.
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
+/* Standard page allocators*/
+extern const struct page_allocator page_allocator;
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
+ * allocation and freeing via the slab.
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
+
+/*
+ * Allocation and freeing is tracked with slab_reclaim_pages
+ */
+struct page_allocator *reclaimable_slab
+			(const struct page_allocator *base);
+
+struct page_allocator *unreclaimable_slab
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
+	(const struct page_allocator *, unsigned int size, void *private,
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
+struct derived_page_allocator *derive_page_allocator
+				(const struct page_allocator *base,
+				const char *name);
+
+/*
+ * Slab allocators
+ */
+
+
+/*
+ * A slab cache structure must be generated and be populated in order to
+ * create a working slab cache.
+ */
+struct slab_cache {
+	const struct slab_allocator *slab_alloc;
+	const struct page_allocator *page_alloc;
+	short int node;		/* Node passed to page allocator */
+	short int align;	/* Alignment requirements */
+	int size;		/* The size of a chunk on a slab */
+	int objsize;		/* The size of an object that is in a chunk */
+	int inuse;		/* Used portion of the chunk */
+	int offset;		/* Offset to the freelist pointer */
+	unsigned int order;	/* Size of the slab page */
+	const char *name;	/* Name (only for display!) */
+	struct list_head list;	/* slabinfo data */
+};
+
+/*
+ * Generic structure for opaque per slab data for slab allocators
+ */
+struct slab_control {
+	struct slab_cache sc;	/* Common information */
+	void *data[50];		/* Some data */
+	void *percpu[NR_CPUS];	/* Some per cpu information. */
+};
+
+struct slab_allocator {
+	/* Allocation functions */
+	void *(*alloc)(struct slab_cache *, gfp_t);
+	void *(*alloc_node)(struct slab_cache *, gfp_t, int);
+	void (*free)(struct slab_cache *, const void *);
+
+	/* Entry point from kfree */
+	void (*__free)(struct page *, const void *);
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
+	unsigned long (*get_objects)(struct slab_cache *, unsigned long *total,
+			unsigned long *active, unsigned long *partial);
+
+	/*
+	 * Create an actually usable slab cache from a slab allocator
+	 */
+	struct slab_cache *(*create)(struct slab_control *,
+		const struct slab_cache *);
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
+	 * Establish a new reference so that destroy does not
+	 * unecessarily destroy the slab_cache
+	 */
+	struct slab_cache * (*dup)(struct slab_cache *);
+	int (*destroy)(struct slab_cache *);
+	void (*destructor)(struct slab_allocator *);
+	const char *name;
+};
+
+/* Standard slab allocator */
+extern const struct slab_allocator slabifier_allocator;
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
+struct derived_slab_allocator *derive_slab_allocator
+			(const struct slab_allocator *base,
+			const char *name);
+
+#endif /* _LINUX_ALLOCATOR_H */
Index: linux-2.6.18-rc5-mm1/mm/allocator.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.18-rc5-mm1/mm/allocator.c	2006-09-01 11:50:41.934026026 -0700
@@ -0,0 +1,451 @@
+/*
+ * Generic allocator and modifiers for allocators (slab and page allocators)
+ *
+ * (C) 2006 Silicon Graphics, Inc. Christoph Lameter <clameter@sgi.com>
+ */
+
+#include <linux/allocator.h>
+#include <linux/mm.h>
+#include <linux/module.h>
+
+/*
+ * Section One: Page Allocators
+ */
+
+static char *alloc_str_combine(const char *new, const char *base)
+{
+	char *s;
+
+	s = kmalloc(strlen(new) + strlen(base) + 2, GFP_KERNEL);
+	strcpy(s, new);
+	strcat(s, ":");
+	strcat(s, base);
+	return s;
+}
+
+/* For static allocators */
+static void null_destructor(struct page_allocator *a) {}
+
+/*
+ * A general page allocator that can allocate all of memory
+ */
+static struct page *gen_alloc(const struct page_allocator *a, int order,
+		gfp_t flags, int node)
+{
+	if (order)
+		flags |= __GFP_COMP;
+#ifdef CONFIG_NUMA
+	if (node >=0)
+		return alloc_pages_node(node, flags, order);
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
+ * Functions to deal with dynamically generating allocators.
+ */
+void derived_destructor(struct page_allocator *a)
+{
+	struct derived_page_allocator *d = (void *)a;
+
+	d->base->destructor((struct page_allocator *)d->base);
+	kfree(a->name);
+	kfree(a);
+}
+
+/*
+ * Create a new allocator based on another one. All functionality
+ * is duplicated except for the destructor. The caller needs to do
+ * modifications to some of the methods in the copy.
+ */
+struct derived_page_allocator *derive_page_allocator
+		(const struct page_allocator *base, const char *name)
+{
+	struct derived_page_allocator *d =
+		kmalloc(sizeof(struct derived_page_allocator), GFP_KERNEL);
+
+	d->base = base;
+	d->a.allocate = base->allocate;
+	d->a.free = base->free;
+	d->a.name = alloc_str_combine(name, base->name);
+	d->a.destructor = derived_destructor;
+	return d;
+};
+
+/*
+ * RCU allocator generator (this is used f.e in the slabifier
+ * to realize SLAB_DESTROY_BY_RCU see the slabulator on how to do this).
+ *
+ * We overload struct page once more for the RCU data
+ * lru = RCU head
+ * index = order
+ * mapping = base allocator
+ */
+static void page_free_rcu(struct rcu_head *h)
+{
+	struct page *page;
+	struct page_allocator *base;
+	int order;
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
+	struct derived_page_allocator *d = derive_page_allocator(base,"rcu");
+
+	d->a.free = rcu_free;
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
+	struct derived_page_allocator *d = derive_page_allocator(base, "dma");
+
+	d->a.allocate = dma_alloc;
+	return &d->a;
+}
+
+/*
+ * Allocator with constructur and destructor in fixed sized length
+ * in the page (used by the slabifier to realize slab destructors
+ * and constructors).
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
+		int mode = 1;
+
+		/* Setup a mode compatible with slab usage */
+		if (!(mode & __GFP_WAIT))
+			mode |= 2;
+
+		for (p = start; p <= end - d->size; p += d->size)
+			d->ctor(p, d->private, mode);
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
+		unsigned int size, void *private,
+		void (*ctor)(void *, void *, unsigned long),
+		void (*dtor)(void *, void *, unsigned long))
+{
+	struct deconstructor *d =
+		kmalloc(sizeof(struct deconstructor), GFP_KERNEL);
+
+	d->a.allocate = ctor ? ctor_alloc : base->allocate;
+	d->a.free = dtor ? dtor_free : base->free;
+	d->a.destructor = derived_destructor;
+	d->a.name = alloc_str_combine("ctor_dtor", base->name);
+	d->base = base;
+	d->ctor = ctor;
+	d->dtor = dtor;
+	d->size = size;
+	d->private = private;
+	return &d->a;
+}
+
+/*
+ * Track reclaimable pages. This is used by the slabulator
+ * to mark allocations of certain slab caches.
+ */
+static struct page *rac_alloc(const struct page_allocator *a, int order,
+			gfp_t flags, int node)
+{
+	struct derived_page_allocator *d = (void *)a;
+	struct page *page = d->base->allocate(d->base, order, flags, node);
+
+	mod_zone_page_state(page_zone(page), NR_SLAB_RECLAIMABLE, 1 << order);
+	return page;
+}
+
+static void rac_free(const struct page_allocator *a, struct page *page,
+							int order)
+{
+	struct derived_page_allocator *d = (void *)a;
+
+	mod_zone_page_state(page_zone(page),
+					NR_SLAB_RECLAIMABLE, -(1 << order));
+	d->base->free(d->base, page, order);
+}
+
+struct page_allocator *reclaimable_slab(const struct page_allocator *base)
+{
+	struct derived_page_allocator *d =
+		derive_page_allocator(&page_allocator,"reclaimable");
+
+	d->a.allocate = rac_alloc;
+	d->a.free = rac_free;
+	return &d->a;
+}
+
+/*
+ * Track unreclaimable pages. This is used by the slabulator
+ * to mark allocations of certain slab caches.
+ */
+static struct page *urac_alloc(const struct page_allocator *a, int order,
+			gfp_t flags, int node)
+{
+	struct derived_page_allocator *d = (void *)a;
+	struct page *page = d->base->allocate(d->base, order, flags, node);
+
+	mod_zone_page_state(page_zone(page),
+			NR_SLAB_UNRECLAIMABLE, 1 << order);
+	return page;
+}
+
+static void urac_free(const struct page_allocator *a, struct page *page,
+							int order)
+{
+	struct derived_page_allocator *d = (void *)a;
+
+	mod_zone_page_state(page_zone(page),
+					NR_SLAB_UNRECLAIMABLE, -(1 << order));
+	d->base->free(d->base, page, order);
+}
+
+struct page_allocator *unreclaimable_slab(const struct page_allocator *base)
+{
+	struct derived_page_allocator *d =
+		derive_page_allocator(&page_allocator,"unreclaimable");
+
+	d->a.allocate = urac_alloc;
+	d->a.free = urac_free;
+	return &d->a;
+}
+
+/*
+ * Numacontrol for allocators
+ */
+struct numactl {
+	struct page_allocator a;
+	const struct page_allocator *base;
+	int node;
+	gfp_t flags;
+};
+
+static struct page *numactl_alloc(const struct page_allocator *a,
+				int order, gfp_t flags, int node)
+{
+	struct numactl *d = (void *)a;
+
+	if (d->node >= 0)
+		node = d->node;
+
+	return d->base->allocate(d->base, order, flags | d->flags, node);
+}
+
+
+struct page_allocator *numactl_allocator(const struct page_allocator *base,
+	int node, gfp_t flags)
+{
+	struct numactl *d =
+		kmalloc(sizeof(struct numactl), GFP_KERNEL);
+
+	d->a.allocate = numactl_alloc;
+	d->a.destructor = derived_destructor;
+	d->a.name = alloc_str_combine("numa", base->name);
+	d->base = base;
+	d->node = node;
+	d->flags = flags;
+	return &d->a;
+}
+
+/*
+ * Slab allocators
+ */
+
+/* Tools to make your own */
+void null_slab_allocator_destructor(struct slab_allocator *a) {}
+
+void derived_slab_destructor(struct slab_allocator *a) {
+	struct derived_slab_allocator *d = (void *)a;
+
+	d->base->destructor((struct slab_allocator *)d->base);
+	kfree(d);
+}
+
+struct derived_slab_allocator *derive_slab_allocator
+		(const struct slab_allocator *base,
+			const char *name) {
+	struct derived_slab_allocator *d =
+		 kmalloc(sizeof(struct derived_slab_allocator), GFP_KERNEL);
+
+	memcpy(&d->a, base, sizeof(struct slab_allocator));
+	d->base = base;
+	d->a.name = alloc_str_combine("name", base->name);
+	d->a.destructor = derived_slab_destructor;
+	return d;
+}
+
+/* Generate new slab allocators based on old ones */
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
+struct slab_cache *rcuify_slab_create(struct slab_control *c,
+	const struct slab_cache *sc)
+{
+	struct rcuified_slab *d = (void *)sc->slab_alloc;
+	struct slab_cache i;
+
+	memcpy(&i, sc, sizeof(struct slab_cache));
+
+	i.inuse = d->rcu_offset = ALIGN(sc->inuse, sizeof(void *));
+	i.inuse += sizeof(struct slabr) + sizeof(void *);
+	while (i.inuse > i.size)
+		i.size += i.align;
+
+	i.slab_alloc = d->base;
+
+	return d->base->create(c, &i);
+}
+
+void rcu_slab_free(struct rcu_head *rcu)
+{
+	struct slabr *r = (void *) rcu;
+	struct slab_cache *s = r->s;
+	struct rcuified_slab *d = (void *)s->slab_alloc;
+	void *object = (void *) rcu - d->rcu_offset;
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
+	struct derived_slab_allocator *d = derive_slab_allocator(base,"rcu");
+
+	d->a.create = rcuify_slab_create;
+	d->a.free = rcuify_slab_free;
+	return &d->a;
+}
+
+/*
+ * dmaification of slab allocation. This is done by dmaifying the
+ * underlying page allocator.
+ */
+struct slab_cache *dmaify_slab_create(struct slab_control *c,
+		const struct slab_cache *sc)
+{
+	struct derived_slab_allocator *d = (void *)sc->slab_alloc;
+	struct slab_cache i;
+
+	memcpy(&i, sc, sizeof(struct slab_cache));
+
+	i.page_alloc = dmaify_page_allocator(sc->page_alloc);
+
+	return d->base->create(c, &i);
+}
+
+struct slab_allocator *dmaify_slab_allocator
+			(const struct slab_allocator *base)
+{
+	struct derived_slab_allocator *d = derive_slab_allocator(base, "dma");
+
+	d->a.create = dmaify_slab_create;
+	return &d->a;
+}
+

-- 
VGER BF report: U 0.496883
