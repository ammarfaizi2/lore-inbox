Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750819AbWHPCYE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750819AbWHPCYE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 22:24:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750828AbWHPCXk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 22:23:40 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:6829 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750827AbWHPCXZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 22:23:25 -0400
Date: Tue, 15 Aug 2006 19:23:09 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: mpm@selenic.com
Cc: Marcelo Tosatti <marcelo@kvack.org>, linux-kernel@vger.kernel.org,
       Nick Piggin <nickpiggin@yahoo.com.au>, Andi Kleen <ak@suse.de>,
       Manfred Spraul <manfred@colorfullife.com>, Dave Chinner <dgc@sgi.com>,
       Christoph Lameter <clameter@sgi.com>
Message-Id: <20060816022309.13379.60403.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20060816022238.13379.24081.sendpatchset@schroedinger.engr.sgi.com>
References: <20060816022238.13379.24081.sendpatchset@schroedinger.engr.sgi.com>
Subject: [MODSLAB 6/7] A slab allocator: NUMA Slab allocator
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Simple NUMA slab allocator

The NUMA slab allocator simply generates a slab per node
on demand and uses the slabifier to manage per node
slab caches.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.18-rc4/mm/numa_slab.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.18-rc4/mm/numa_slab.c	2006-08-15 18:44:01.142994108 -0700
@@ -0,0 +1,311 @@
+/*
+ * NUMA slab implementation
+ *
+ * (C) 2006 Silicon Graphics Inc.
+ *		Christoph Lameter <clameter@sgi.com
+ */
+
+#include <linux/mm.h>
+#include <linux/allocator.h>
+#include <linux/kmalloc.h>
+#include <linux/cpuset.h>
+#include <linux/mempolicy.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+
+#define NUMA_SLAB_DEBUG
+
+//#define TPRINTK printk
+#define TPRINTK(x, ...)
+
+/*
+ * Prelude : Numacontrol for allocators
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
+	d->a.name = "numa";
+	d->base = base;
+	d->node = node;
+	d->flags = flags;
+	return &d->a;
+}
+
+/*
+ * Allocator on which we base this functionality.
+ */
+#define base slabifier_allocator
+
+static struct slab_cache *numa_cache;
+
+struct numa_slab {
+	struct slab_cache sc;
+	spinlock_t lock;
+	atomic_t refcount;
+	struct slab_cache *node[MAX_NUMNODES];
+};
+
+static int __numa_slab_destroy(struct numa_slab *n)
+{
+	int node;
+
+	TPRINTK(KERN_CRIT "__numa_slab_destroy(%s)\n", n->sc.name);
+
+	for_each_node(node) {
+		base.free(NULL,n->node[node]);
+		n->node[node] = NULL;
+	}
+	return 0;
+}
+
+static struct slab_cache *bring_up_node(struct numa_slab *n, int node)
+{
+	struct slab_cache *s = n->node[node];
+	struct slab_cache *sc = &n->sc;
+
+	TPRINTK(KERN_CRIT "bring_up_node(%s, %d)\n", n->sc.name, node);
+	if (s)
+		return s;
+
+	spin_lock(&n->lock);
+	s = n->node[node];
+	if (s) {
+		spin_unlock(&n->lock);
+		return s;
+	}
+	s = n->node[node] = base.create(&base, sc->page_alloc, node,
+		sc->name, sc->size, sc->align, sc->order, sc->objsize, sc->inuse,
+		sc->offset);
+
+	spin_unlock(&n->lock);
+	return s;
+}
+
+static struct slab_cache *numa_slab_create
+	(const struct slab_allocator *slab_alloc,
+		const struct page_allocator *page_alloc, int node,
+		const char *name, int size, int align, int order,
+		int objsize, int inuse, int offset)
+{
+	struct numa_slab *n;
+
+	TPRINTK(KERN_CRIT "numa_slab_create(%s, %s, %d, %s, %d, %d, %d ,%d ,%d ,%d)\n",
+			slab_alloc->name, page_alloc->name, node, name, size,
+			align, order, objsize, inuse, offset);
+
+	if (!numa_cache) {
+		numa_cache = base.create(&base, page_alloc, node, "numa_cache",
+			ALIGN(sizeof(struct numa_slab), L1_CACHE_BYTES),
+			L1_CACHE_BYTES, 0, sizeof(struct numa_slab),
+			sizeof(struct numa_slab), 0);
+		if (!numa_cache)
+			panic("Cannot create numa cache\n");
+	}
+
+	n = base.alloc(numa_cache, in_atomic() ? GFP_ATOMIC : GFP_KERNEL);
+	if (!n)
+		return NULL;
+
+	memset(n, 0, sizeof(struct numa_slab));
+	slab_allocator_fill(&n->sc, slab_alloc, page_alloc, node, name, size, align,
+			order, objsize, inuse, offset);
+	spin_lock_init(&n->lock);
+	atomic_set(&n->refcount, 1);
+
+	/* Do not bring up a node here. slabulator may set a constructor after the fact */
+	return &n->sc;
+}
+
+static void *numa_slab_alloc(struct slab_cache *sc, gfp_t flags);
+
+static void *numa_slab_alloc_node(struct slab_cache *sc, gfp_t flags, int node)
+{
+	struct numa_slab *n = (void *)sc;
+	struct slab_cache *s;
+
+	TPRINTK(KERN_CRIT "numa_slab_alloc_node(%s, %x, %d)\n", sc->name, flags, node);
+
+	if (node < 0)
+		node = numa_node_id();
+
+	s = n->node[node];
+
+	if (unlikely(!s)) {
+		s = bring_up_node(n, node);
+		if (!s)
+			return NULL;
+	}
+	return base.alloc(s, flags);
+}
+
+static void *numa_slab_alloc(struct slab_cache *sc, gfp_t flags)
+{
+	int node = numa_node_id();
+
+	TPRINTK(KERN_CRIT "numa_slab_alloc(%s, %x)\n", sc->name, flags);
+
+	if (unlikely(current->flags & (PF_SPREAD_SLAB | PF_MEMPOLICY))
+		&& !in_interrupt()) {
+		if (cpuset_do_slab_mem_spread())
+	 		node = cpuset_mem_spread_node();
+		else if (current->mempolicy)
+                	node = slab_node(current->mempolicy);
+	}
+	return numa_slab_alloc_node(sc, flags, node);
+}
+
+static int numa_slab_destroy(struct slab_cache *sc)
+{
+	struct numa_slab *n = (void *)sc;
+
+	TPRINTK(KERN_CRIT "numa_slab_destroy(%s)\n", sc->name);
+
+	if (!atomic_dec_and_test(&n->refcount))
+		return 0;
+
+	__numa_slab_destroy(n);
+	return 0;
+}
+
+static int numa_slab_pointer_valid(struct slab_cache *sc, const void *object)
+{
+	struct numa_slab *n = (void *)sc;
+	int node;
+
+	TPRINTK(KERN_CRIT "numa_slab_pointer_valid(%s, %p)\n", sc->name, object);
+
+	/* We can deduct from the allocator which node this is. */
+	node = ((struct numactl *)(sc->page_alloc))->node;
+	return base.valid_pointer(n->node[node], object);
+}
+
+static unsigned long numa_slab_object_size(struct slab_cache *sc,
+						 const void *object)
+{
+	struct numa_slab *n = (void *)sc;
+	int node;
+
+	TPRINTK(KERN_CRIT "numa_slab_object_size(%s, %p)\n", sc->name, object);
+
+	/* We can deduct from the allocator which node this is. */
+	node = ((struct numactl *)(sc->page_alloc))->node;
+	return base.object_size(n->node[node], object);
+}
+
+static void numa_slab_free(struct slab_cache *sc, const void *object)
+{
+	TPRINTK(KERN_CRIT "numa_slab_free(%s, %p)\n", sc ? sc->name : "<none>", object);
+	base.free(NULL, object);
+}
+
+static struct slab_cache *numa_slab_dup(struct slab_cache *sc)
+{
+	struct numa_slab *n = (void *)sc;
+
+	TPRINTK(KERN_CRIT "numa_slab_dup(%s)\n", sc->name);
+
+	atomic_inc(&n->refcount);
+	return sc;
+}
+
+static struct slab_cache *numa_slab_node(struct slab_cache *sc, int node)
+{
+	struct numa_slab *n = (void *)sc;
+	struct slab_cache *s = n->node[node];
+
+	return s;
+}
+
+static int numa_slab_shrink(struct slab_cache *sc,
+	int (*move_object)(struct slab_cache *, void *))
+{
+	struct numa_slab *n = (void *)sc;
+	int node;
+	int count = 0;
+
+	TPRINTK(KERN_CRIT "numa_slab_shrink(%s, %p)\n", sc->name, move_object);
+
+	/*
+	 * FIXME: What you really want to do here is to
+	 * run the shrinking on each node separately
+	 */
+	spin_lock(&n->lock);
+	for_each_node(node) {
+		struct slab_cache *s = n->node[node];
+
+		if (s)
+			count += base.shrink(n->node[node], move_object);
+	}
+	spin_unlock(&n->lock);
+	return count;
+}
+
+static unsigned long numa_slab_objects(struct slab_cache *sc,
+	unsigned long *active, unsigned long *partial)
+{
+	struct numa_slab *n = (void *)sc;
+	int node;
+	unsigned long count = 0;
+	unsigned long count_active = 0;
+	unsigned long count_partial = 0;
+
+	printk(KERN_CRIT "numa_slab_objects(%s)\n", sc->name);
+
+	for_each_node(node) {
+		unsigned long nactive, npartial;
+		struct slab_cache *s = n->node[node];
+
+		if (!s)
+			continue;
+
+		count += base.objects(n->node[node], &nactive, &npartial);
+		count_active += nactive;
+		count_partial += npartial;
+	}
+	if  (active)
+		*active = count_active;
+	if (partial)
+		*partial = count_partial;
+	return count;
+}
+
+const struct slab_allocator numa_slab_allocator = {
+	.name = "NumaSlab",
+	.create = numa_slab_create,
+	.alloc = numa_slab_alloc,
+	.alloc_node = numa_slab_alloc_node,
+	.free = numa_slab_free,
+	.valid_pointer = numa_slab_pointer_valid,
+	.object_size = numa_slab_object_size,
+	.objects = numa_slab_objects,
+	.shrink = numa_slab_shrink,
+	.dup = numa_slab_dup,
+	.node = numa_slab_node,
+	.destroy = numa_slab_destroy,
+	.destructor = null_slab_allocator_destructor
+};
+EXPORT_SYMBOL(numa_slab_allocator);
Index: linux-2.6.18-rc4/mm/Makefile
===================================================================
--- linux-2.6.18-rc4.orig/mm/Makefile	2006-08-15 18:37:53.847305724 -0700
+++ linux-2.6.18-rc4/mm/Makefile	2006-08-15 18:43:25.610031185 -0700
@@ -25,4 +25,5 @@ obj-$(CONFIG_MEMORY_HOTPLUG) += memory_h
 obj-$(CONFIG_FS_XIP) += filemap_xip.o
 obj-$(CONFIG_MIGRATION) += migrate.o
 obj-$(CONFIG_MODULAR_SLAB) += allocator.o kmalloc.o slabulator.o slabifier.o
+obj-$(CONFIG_NUMA_SLAB) += numa_slab.o
 
Index: linux-2.6.18-rc4/init/Kconfig
===================================================================
--- linux-2.6.18-rc4.orig/init/Kconfig	2006-08-15 18:37:52.247795073 -0700
+++ linux-2.6.18-rc4/init/Kconfig	2006-08-15 18:43:25.611007687 -0700
@@ -405,7 +405,7 @@ config SLAB
 
 config MODULAR_SLAB
 	default n
-	bool "Use the modular slab allocator frameworkr"
+	bool "Modular SLAB allocator framework"
 	depends on EXPERIMENTAL
 	help
 	 The modular slab allocator framework allows the flexible use
@@ -413,6 +413,11 @@ config MODULAR_SLAB
 	 allocation. This will completely replace the existing
 	 slab allocator. Beware this is experimental code.
 
+config NUMA_SLAB
+	default y
+	bool "NUMA Slab allocator (for lots of memory)"
+	depends on MODULAR_SLAB && NUMA
+
 config VM_EVENT_COUNTERS
 	default y
 	bool "Enable VM event counters for /proc/vmstat" if EMBEDDED
