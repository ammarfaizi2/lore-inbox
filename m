Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750828AbWHPCYs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750828AbWHPCYs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 22:24:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750827AbWHPCYr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 22:24:47 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:8365 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750830AbWHPCXb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 22:23:31 -0400
Date: Tue, 15 Aug 2006 19:23:14 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: mpm@selenic.com
Cc: Marcelo Tosatti <marcelo@kvack.org>, linux-kernel@vger.kernel.org,
       Nick Piggin <nickpiggin@yahoo.com.au>, Andi Kleen <ak@suse.de>,
       Christoph Lameter <clameter@sgi.com>, Dave Chinner <dgc@sgi.com>,
       Manfred Spraul <manfred@colorfullife.com>
Message-Id: <20060816022314.13379.59229.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20060816022238.13379.24081.sendpatchset@schroedinger.engr.sgi.com>
References: <20060816022238.13379.24081.sendpatchset@schroedinger.engr.sgi.com>
Subject: [MODSLAB 7/7] A slab allocator: Page Slab allocator
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The page slab is a specialized slab allocator that can only handle
page order size object. It directly uses the page allocator to
track the objects and can therefore avoid the overhead of the
slabifier.

[Have not had time to test this one yet. Compiles... and
its the simplest slab allocator of them all.]

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.18-rc4/mm/page_slab.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.18-rc4/mm/page_slab.c	2006-08-15 18:57:03.553625883 -0700
@@ -0,0 +1,145 @@
+/*
+ * Page Slab implementation
+ *
+ * This is a special slab allocator that uses the page cache to manage
+ * the objects. It is restricted to page size order allocations.
+ *
+ * (C) 2006 Silicon Graphics Inc.
+ *		Christoph Lameter <clameter@sgi.com
+ */
+
+#include <linux/mm.h>
+#include <linux/allocator.h>
+#include <linux/module.h>
+
+/*
+ * Allocator to use for the metadata
+ */
+#define baseslab slabifier_allocator
+
+static struct slab_cache *page_slab_cache;
+
+struct page_slab {
+	struct slab_cache sc;
+	spinlock_t lock;
+	atomic_t refcount;
+	atomic_t pages;
+};
+
+static struct slab_cache *page_slab_create
+	(const struct slab_allocator *slab_alloc,
+		const struct page_allocator *page_alloc, int node,
+		const char *name, int size, int align, int order,
+		int objsize, int inuse, int offset)
+{
+	struct page_slab *n;
+
+	if (!page_slab_cache) {
+		page_slab_cache = baseslab.create(&baseslab, page_alloc, node,
+			"page_slab_cache",
+			ALIGN(sizeof(struct page_slab), L1_CACHE_BYTES),
+			L1_CACHE_BYTES, 0, sizeof(struct page_slab),
+			sizeof(struct page_slab), 0);
+		if (!page_slab_cache)
+			panic("Cannot create page_slab cache\n");
+	}
+
+	n = baseslab.alloc(page_slab_cache, GFP_KERNEL);
+	if (!n)
+		return NULL;
+
+	memset(n, 0, sizeof(struct page_slab));
+	slab_allocator_fill(&n->sc, slab_alloc, page_alloc, node, name, size,
+			align, order, objsize, inuse, offset);
+	spin_lock_init(&n->lock);
+	atomic_set(&n->refcount, 1);
+	return &n->sc;
+}
+
+static void *page_slab_alloc_node(struct slab_cache *sc, gfp_t flags, int node)
+{
+	struct page_slab *n = (void *)sc;
+	struct page * page;
+
+	page = sc->page_alloc->allocate(sc->page_alloc, sc->order,
+					flags, node);
+	atomic_inc(&n->pages);
+	if (!page)
+		return NULL;
+	return page_address(page);
+}
+
+static void *page_slab_alloc(struct slab_cache *sc, gfp_t flags)
+{
+	return page_slab_alloc_node(sc, flags, -1);
+}
+
+static void page_slab_free(struct slab_cache *sc, const void *object)
+{
+	struct page_slab *p = (void *)sc;
+
+	atomic_dec(&p->pages);
+	return __free_pages(virt_to_page(object), sc ? sc->order : 0);
+}
+
+static int page_slab_destroy(struct slab_cache *sc)
+{
+	struct page_slab *p = (void *)sc;
+
+	if (!atomic_dec_and_test(&p->refcount))
+		return 0;
+
+	baseslab.free(page_slab_cache, sc);
+	return 0;
+}
+
+static int page_slab_pointer_valid(struct slab_cache *sc, const void *object)
+{
+	struct page *page = virt_to_page(object);
+
+	return page_address(page) == object;
+}
+
+static unsigned long page_slab_object_size(struct slab_cache *sc,
+					const void *object)
+{
+	return PAGE_SIZE << sc->order;
+}
+
+static struct slab_cache *page_slab_dup(struct slab_cache *sc)
+{
+	struct page_slab *p = (void *)sc;
+
+	atomic_inc(&p->refcount);
+	return sc;
+}
+
+static int page_slab_shrink(struct slab_cache *sc,
+	int (*move_object)(struct slab_cache *, void *))
+{
+	return 0;
+}
+
+static unsigned long page_slab_objects(struct slab_cache *sc,
+	unsigned long *active, unsigned long *partial)
+{
+	struct page_slab *p = (void *)sc;
+	return atomic_read(&p->pages);
+}
+
+struct slab_allocator page_slab_allocator = {
+	.name = "PageSlab",
+	.create = page_slab_create,
+	.alloc = page_slab_alloc,
+	.alloc_node = page_slab_alloc_node,
+	.free = page_slab_free,
+	.valid_pointer = page_slab_pointer_valid,
+	.object_size = page_slab_object_size,
+	.objects = page_slab_objects,
+	.shrink = page_slab_shrink,
+	.dup = page_slab_dup,
+	.destroy = page_slab_destroy,
+	.destructor = null_slab_allocator_destructor
+};
+EXPORT_SYMBOL(page_slab_allocator);
+
Index: linux-2.6.18-rc4/mm/Makefile
===================================================================
--- linux-2.6.18-rc4.orig/mm/Makefile	2006-08-15 18:57:03.516518810 -0700
+++ linux-2.6.18-rc4/mm/Makefile	2006-08-15 18:57:03.554602385 -0700
@@ -26,4 +26,5 @@ obj-$(CONFIG_FS_XIP) += filemap_xip.o
 obj-$(CONFIG_MIGRATION) += migrate.o
 obj-$(CONFIG_MODULAR_SLAB) += allocator.o kmalloc.o slabulator.o slabifier.o
 obj-$(CONFIG_NUMA_SLAB) += numa_slab.o
+obj-$(CONFIG_PAGE_SLAB) += page_slab.o
 
Index: linux-2.6.18-rc4/init/Kconfig
===================================================================
--- linux-2.6.18-rc4.orig/init/Kconfig	2006-08-15 18:57:03.517495312 -0700
+++ linux-2.6.18-rc4/init/Kconfig	2006-08-15 18:57:03.554602385 -0700
@@ -418,6 +418,15 @@ config NUMA_SLAB
 	bool "NUMA Slab allocator (for lots of memory)"
 	depends on MODULAR_SLAB && NUMA
 
+config PAGE_SLAB
+	default n
+	depends on MODULAR_SLAB
+	bool "Page slab allocator"
+	help
+	  The page slab allocator is a form of slab allocator but it manges
+	  page in order of pagesize through the page allocator. This allows
+	  for efficient management of slab caches with huge objects.
+
 config VM_EVENT_COUNTERS
 	default y
 	bool "Enable VM event counters for /proc/vmstat" if EMBEDDED
