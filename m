Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261550AbVC3Fbb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261550AbVC3Fbb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 00:31:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261567AbVC3Fba
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 00:31:30 -0500
Received: from graphe.net ([209.204.138.32]:60170 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S261550AbVC3Faq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 00:30:46 -0500
Date: Tue, 29 Mar 2005 21:30:30 -0800 (PST)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@server.graphe.net
To: Manfred Spraul <manfred@colorfullife.com>
cc: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org, shai@scalex86.org
Subject: API changes to the slab allocator for NUMA memory allocation
In-Reply-To: <4238845E.5060304@colorfullife.com>
Message-ID: <Pine.LNX.4.58.0503292126050.32140@server.graphe.net>
References: <20050315204110.6664771d.akpm@osdl.org> <42387C2E.4040106@colorfullife.com>
 <273220000.1110999247@[10.10.2.4]> <4238845E.5060304@colorfullife.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch makes the following function calls available to allocate memory on
a specific node without changing the basic operation of the slab
allocator:

 kmem_cache_alloc_node(kmem_cache_t *cachep, unsigned int flags, int node);
 kmalloc_node(size_t size, unsigned int flags, int node);

These are similar then to the existing node-blind functions:

 kmem_cache_alloc(kmem_cache_t *cachep, unsigned int flags);
 kmalloc(size, flags);

The implementation for kmalloc_node is a slight variation on the old
kmalloc function. kmem_cache_alloc_node was changed to pass flags and
the node information through the existing layers of the slab allocator
(which lead to some minor rearrangements). The functions at the lowest
layer (kmem_getpages, cache_grow) are already node aware.
Also __alloc_percpu can call kmalloc_node now.

This patch is necessary for the pageset localization patch posted
after this patch. The pageset patch also contains results of an
AIM7 benchmark that exercises this patch.

Patch against 2.6.11.6-bk3

Signed-off-by: Christoph Lameter <christoph@lameter.com>

Index: linux-2.6.11/include/linux/slab.h
===================================================================
--- linux-2.6.11.orig/include/linux/slab.h	2005-03-29 15:02:20.000000000 -0800
+++ linux-2.6.11/include/linux/slab.h	2005-03-29 18:17:19.000000000 -0800
@@ -61,15 +61,6 @@ extern kmem_cache_t *kmem_cache_create(c
 				       void (*)(void *, kmem_cache_t *, unsigned long));
 extern int kmem_cache_destroy(kmem_cache_t *);
 extern int kmem_cache_shrink(kmem_cache_t *);
-extern void *kmem_cache_alloc(kmem_cache_t *, unsigned int __nocast);
-#ifdef CONFIG_NUMA
-extern void *kmem_cache_alloc_node(kmem_cache_t *, int);
-#else
-static inline void *kmem_cache_alloc_node(kmem_cache_t *cachep, int node)
-{
-	return kmem_cache_alloc(cachep, GFP_KERNEL);
-}
-#endif
 extern void kmem_cache_free(kmem_cache_t *, void *);
 extern unsigned int kmem_cache_size(kmem_cache_t *);

@@ -80,9 +71,23 @@ struct cache_sizes {
 	kmem_cache_t	*cs_dmacachep;
 };
 extern struct cache_sizes malloc_sizes[];
-extern void *__kmalloc(size_t, unsigned int __nocast);

-static inline void *kmalloc(size_t size, unsigned int __nocast flags)
+extern void *__kmalloc_node(size_t, unsigned int __nocast, int node);
+#ifdef CONFIG_NUMA
+extern void *kmem_cache_alloc_node(kmem_cache_t *, unsigned int __nocast, int);
+#define kmem_cache_alloc(cachep, flags) kmem_cache_alloc_node(cachep, flags, -1)
+#else
+extern void *kmem_cache_alloc(kmem_cache_t *, unsigned int __nocast);
+#define kmem_cache_alloc_node(cachep, flags, node) kmem_cache_alloc(cachep, flags)
+#endif
+
+#define __kmalloc(size, flags) __kmalloc_node(size, flags, -1)
+#define kmalloc(size, flags) kmalloc_node(size, flags, -1)
+
+/*
+ * Allocating memory on a specific node.
+ */
+static inline void *kmalloc_node(size_t size, unsigned int flags, int node)
 {
 	if (__builtin_constant_p(size)) {
 		int i = 0;
@@ -98,11 +103,11 @@ static inline void *kmalloc(size_t size,
 			__you_cannot_kmalloc_that_much();
 		}
 found:
-		return kmem_cache_alloc((flags & GFP_DMA) ?
+		return kmem_cache_alloc_node((flags & GFP_DMA) ?
 			malloc_sizes[i].cs_dmacachep :
-			malloc_sizes[i].cs_cachep, flags);
+			malloc_sizes[i].cs_cachep, flags, node);
 	}
-	return __kmalloc(size, flags);
+	return __kmalloc_node(size, flags, node);
 }

 extern void *kcalloc(size_t, size_t, unsigned int __nocast);
Index: linux-2.6.11/mm/slab.c
===================================================================
--- linux-2.6.11.orig/mm/slab.c	2005-03-29 15:02:20.000000000 -0800
+++ linux-2.6.11/mm/slab.c	2005-03-29 15:02:27.000000000 -0800
@@ -676,7 +676,7 @@ static struct array_cache *alloc_arrayca
 		kmem_cache_t *cachep;
 		cachep = kmem_find_general_cachep(memsize, GFP_KERNEL);
 		if (cachep)
-			nc = kmem_cache_alloc_node(cachep, cpu_to_node(cpu));
+			nc = kmem_cache_alloc_node(cachep, GFP_KERNEL, cpu_to_node(cpu));
 	}
 	if (!nc)
 		nc = kmalloc(memsize, GFP_KERNEL);
@@ -1988,7 +1988,7 @@ bad:
 #define check_slabp(x,y) do { } while(0)
 #endif

-static void *cache_alloc_refill(kmem_cache_t *cachep, unsigned int __nocast flags)
+static void *cache_alloc_refill(kmem_cache_t *cachep, unsigned int __nocast flags, int node)
 {
 	int batchcount;
 	struct kmem_list3 *l3;
@@ -2070,7 +2070,7 @@ alloc_done:

 	if (unlikely(!ac->avail)) {
 		int x;
-		x = cache_grow(cachep, flags, -1);
+		x = cache_grow(cachep, flags, node);

 		// cache_grow can reenable interrupts, then ac could change.
 		ac = ac_data(cachep);
@@ -2140,7 +2140,7 @@ cache_alloc_debugcheck_after(kmem_cache_
 #endif


-static inline void *__cache_alloc(kmem_cache_t *cachep, unsigned int __nocast flags)
+static inline void *__cache_alloc(kmem_cache_t *cachep, unsigned int __nocast flags, int node)
 {
 	unsigned long save_flags;
 	void* objp;
@@ -2156,7 +2156,7 @@ static inline void *__cache_alloc(kmem_c
 		objp = ac_entry(ac)[--ac->avail];
 	} else {
 		STATS_INC_ALLOCMISS(cachep);
-		objp = cache_alloc_refill(cachep, flags);
+		objp = cache_alloc_refill(cachep, flags, node);
 	}
 	local_irq_restore(save_flags);
 	objp = cache_alloc_debugcheck_after(cachep, flags, objp, __builtin_return_address(0));
@@ -2167,7 +2167,6 @@ static inline void *__cache_alloc(kmem_c
  * NUMA: different approach needed if the spinlock is moved into
  * the l3 structure
  */
-
 static void free_block(kmem_cache_t *cachep, void **objpp, int nr_objects)
 {
 	int i;
@@ -2295,20 +2294,6 @@ static inline void __cache_free(kmem_cac
 }

 /**
- * kmem_cache_alloc - Allocate an object
- * @cachep: The cache to allocate from.
- * @flags: See kmalloc().
- *
- * Allocate an object from this cache.  The flags are only relevant
- * if the cache has no available objects.
- */
-void *kmem_cache_alloc(kmem_cache_t *cachep, unsigned int __nocast flags)
-{
-	return __cache_alloc(cachep, flags);
-}
-EXPORT_SYMBOL(kmem_cache_alloc);
-
-/**
  * kmem_ptr_validate - check if an untrusted pointer might
  *	be a slab entry.
  * @cachep: the cache we're checking against
@@ -2350,7 +2335,23 @@ out:
 	return 0;
 }

-#ifdef CONFIG_NUMA
+#ifndef CONFIG_NUMA
+/**
+ * kmem_cache_alloc - Allocate an object
+ * @cachep: The cache to allocate from.
+ * @flags: See kmalloc().
+ *
+ * Allocate an object from this cache.  The flags are only relevant
+ * if the cache has no available objects.
+ */
+void *kmem_cache_alloc(kmem_cache_t *cachep, unsigned int __nocast flags)
+{
+	return __cache_alloc(cachep, flags, -1);
+}
+EXPORT_SYMBOL(kmem_cache_alloc);
+
+#else
+
 /**
  * kmem_cache_alloc_node - Allocate an object on the specified node
  * @cachep: The cache to allocate from.
@@ -2361,13 +2362,16 @@ out:
  * and can sleep. And it will allocate memory on the given node, which
  * can improve the performance for cpu bound structures.
  */
-void *kmem_cache_alloc_node(kmem_cache_t *cachep, int nodeid)
+void *kmem_cache_alloc_node(kmem_cache_t *cachep, unsigned int flags, int nodeid)
 {
 	int loop;
 	void *objp;
 	struct slab *slabp;
 	kmem_bufctl_t next;

+	if (nodeid < 0)
+		return  __cache_alloc(cachep, flags, -1);
+
 	for (loop = 0;;loop++) {
 		struct list_head *q;

@@ -2393,7 +2397,7 @@ void *kmem_cache_alloc_node(kmem_cache_t
 		spin_unlock_irq(&cachep->spinlock);

 		local_irq_disable();
-		if (!cache_grow(cachep, GFP_KERNEL, nodeid)) {
+		if (!cache_grow(cachep, flags, nodeid)) {
 			local_irq_enable();
 			return NULL;
 		}
@@ -2429,7 +2433,7 @@ got_slabp:
 	list3_data(cachep)->free_objects--;
 	spin_unlock_irq(&cachep->spinlock);

-	objp = cache_alloc_debugcheck_after(cachep, GFP_KERNEL, objp,
+	objp = cache_alloc_debugcheck_after(cachep, flags, objp,
 					__builtin_return_address(0));
 	return objp;
 }
@@ -2441,6 +2445,7 @@ EXPORT_SYMBOL(kmem_cache_alloc_node);
  * kmalloc - allocate memory
  * @size: how many bytes of memory are required.
  * @flags: the type of memory to allocate.
+ * @node: the node from which to allocate or -1
  *
  * kmalloc is the normal method of allocating memory
  * in the kernel.
@@ -2458,16 +2463,16 @@ EXPORT_SYMBOL(kmem_cache_alloc_node);
  * platforms.  For example, on i386, it means that the memory must come
  * from the first 16MB.
  */
-void *__kmalloc(size_t size, unsigned int __nocast flags)
+void *__kmalloc_node(size_t size, unsigned int __nocast flags, int node)
 {
 	kmem_cache_t *cachep;

 	cachep = kmem_find_general_cachep(size, flags);
 	if (unlikely(cachep == NULL))
 		return NULL;
-	return __cache_alloc(cachep, flags);
+	return __cache_alloc(cachep, flags, node);
 }
-EXPORT_SYMBOL(__kmalloc);
+EXPORT_SYMBOL(__kmalloc_node);

 #ifdef CONFIG_SMP
 /**
@@ -2489,9 +2494,7 @@ void *__alloc_percpu(size_t size, size_t
 	for (i = 0; i < NR_CPUS; i++) {
 		if (!cpu_possible(i))
 			continue;
-		pdata->ptrs[i] = kmem_cache_alloc_node(
-				kmem_find_general_cachep(size, GFP_KERNEL),
-				cpu_to_node(i));
+		pdata->ptrs[i] = kmalloc_node(size, GFP_KERNEL, cpu_to_node(i));

 		if (!pdata->ptrs[i])
 			goto unwind_oom;
