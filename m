Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964810AbWAWQ5W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964810AbWAWQ5W (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 11:57:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964808AbWAWQ5W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 11:57:22 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:39613 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S964811AbWAWQ5V
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 11:57:21 -0500
Subject: [RFC/PATCH 1/3] slab: rename kmem_list3 to node_cache
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: manfred@colorfullife.com, christoph@lameter.com
Cc: linux-kernel@vger.kernel.org
Date: Mon, 23 Jan 2006 18:57:16 +0200
Message-Id: <1138035437.10527.19.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution 2.4.2.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pekka Enberg <penberg@cs.helsinki.fi>

This patch renames struct kmem_list3 to struct node_cache. I also renamed
local variables appropriately and list_lock to spin_lock.

Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
---

 mm/slab.c |  440 +++++++++++++++++++++++++++++++-------------------------------
 1 file changed, 220 insertions(+), 220 deletions(-)

Index: 2.6/mm/slab.c
===================================================================
--- 2.6.orig/mm/slab.c
+++ 2.6/mm/slab.c
@@ -281,10 +281,10 @@ struct arraycache_init {
 	void *entries[BOOT_CPUCACHE_ENTRIES];
 };
 
-/*
- * The slab lists for all objects.
+/**
+ * struct node_cache - per node slab lists and array caches.
  */
-struct kmem_list3 {
+struct node_cache {
 	struct list_head slabs_partial;	/* partial list first, better asm code */
 	struct list_head slabs_full;
 	struct list_head slabs_free;
@@ -292,7 +292,7 @@ struct kmem_list3 {
 	unsigned long next_reap;
 	int free_touched;
 	unsigned int free_limit;
-	spinlock_t list_lock;
+	spinlock_t spin_lock;
 	struct array_cache *shared;	/* shared per node */
 	struct array_cache **alien;	/* on other nodes */
 };
@@ -301,10 +301,10 @@ struct kmem_list3 {
  * Need this for bootstrapping a per node allocator.
  */
 #define NUM_INIT_LISTS (2 * MAX_NUMNODES + 1)
-struct kmem_list3 __initdata initkmem_list3[NUM_INIT_LISTS];
+struct node_cache __initdata initnode_cache[NUM_INIT_LISTS];
 #define	CACHE_CACHE 0
 #define	SIZE_AC 1
-#define	SIZE_L3 (1 + MAX_NUMNODES)
+#define	SIZE_NODE_CACHE (1 + MAX_NUMNODES)
 
 /*
  * This function must be completely optimized away if
@@ -333,16 +333,16 @@ static __always_inline int index_of(cons
 }
 
 #define INDEX_AC index_of(sizeof(struct arraycache_init))
-#define INDEX_L3 index_of(sizeof(struct kmem_list3))
+#define INDEX_NODE_CACHE index_of(sizeof(struct node_cache))
 
-static void kmem_list3_init(struct kmem_list3 *parent)
+static void node_cache_init(struct node_cache *parent)
 {
 	INIT_LIST_HEAD(&parent->slabs_full);
 	INIT_LIST_HEAD(&parent->slabs_partial);
 	INIT_LIST_HEAD(&parent->slabs_free);
 	parent->shared = NULL;
 	parent->alien = NULL;
-	spin_lock_init(&parent->list_lock);
+	spin_lock_init(&parent->spin_lock);
 	parent->free_objects = 0;
 	parent->free_touched = 0;
 }
@@ -374,7 +374,7 @@ struct kmem_cache {
 	unsigned int shared;
 	unsigned int buffer_size;
 /* 2) touched by every alloc & free from the backend */
-	struct kmem_list3 *nodelists[MAX_NUMNODES];
+	struct node_cache *nodelists[MAX_NUMNODES];
 	unsigned int flags;	/* constant flags */
 	unsigned int num;	/* # of objs per slab */
 	spinlock_t spinlock;
@@ -666,7 +666,7 @@ atomic_t slab_reclaim_pages;
 static enum {
 	NONE,
 	PARTIAL_AC,
-	PARTIAL_L3,
+	PARTIAL_NODE_CACHES,
 	FULL
 } g_cpucache_up;
 
@@ -869,24 +869,24 @@ static void free_alien_cache(struct arra
 static void __drain_alien_cache(struct kmem_cache *cachep,
 				struct array_cache *ac, int node)
 {
-	struct kmem_list3 *rl3 = cachep->nodelists[node];
+	struct node_cache *node_cache = cachep->nodelists[node];
 
 	if (ac->avail) {
-		spin_lock(&rl3->list_lock);
+		spin_lock(&node_cache->spin_lock);
 		free_block(cachep, ac->entry, ac->avail, node);
 		ac->avail = 0;
-		spin_unlock(&rl3->list_lock);
+		spin_unlock(&node_cache->spin_lock);
 	}
 }
 
-static void drain_alien_cache(struct kmem_cache *cachep, struct kmem_list3 *l3)
+static void drain_alien_cache(struct kmem_cache *cachep, struct node_cache *node_cache)
 {
 	int i = 0;
 	struct array_cache *ac;
 	unsigned long flags;
 
 	for_each_online_node(i) {
-		ac = l3->alien[i];
+		ac = node_cache->alien[i];
 		if (ac) {
 			spin_lock_irqsave(&ac->lock, flags);
 			__drain_alien_cache(cachep, ac, i);
@@ -897,7 +897,7 @@ static void drain_alien_cache(struct kme
 #else
 #define alloc_alien_cache(node, limit) do { } while (0)
 #define free_alien_cache(ac_ptr) do { } while (0)
-#define drain_alien_cache(cachep, l3) do { } while (0)
+#define drain_alien_cache(cachep, node_cache) do { } while (0)
 #endif
 
 static int __devinit cpuup_callback(struct notifier_block *nfb,
@@ -905,9 +905,9 @@ static int __devinit cpuup_callback(stru
 {
 	long cpu = (long)hcpu;
 	struct kmem_cache *cachep;
-	struct kmem_list3 *l3 = NULL;
+	struct node_cache *node_cache = NULL;
 	int node = cpu_to_node(cpu);
-	int memsize = sizeof(struct kmem_list3);
+	int memsize = sizeof(struct node_cache);
 
 	switch (action) {
 	case CPU_UP_PREPARE:
@@ -915,30 +915,30 @@ static int __devinit cpuup_callback(stru
 		/* we need to do this right in the beginning since
 		 * alloc_arraycache's are going to use this list.
 		 * kmalloc_node allows us to add the slab to the right
-		 * kmem_list3 and not this cpu's kmem_list3
+		 * node_cache and not this cpu's node_cache
 		 */
 
 		list_for_each_entry(cachep, &cache_chain, next) {
-			/* setup the size64 kmemlist for cpu before we can
+			/* setup the size64 node_caches for cpu before we can
 			 * begin anything. Make sure some other cpu on this
 			 * node has not already allocated this
 			 */
 			if (!cachep->nodelists[node]) {
-				if (!(l3 = kmalloc_node(memsize,
+				if (!(node_cache = kmalloc_node(memsize,
 							GFP_KERNEL, node)))
 					goto bad;
-				kmem_list3_init(l3);
-				l3->next_reap = jiffies + REAPTIMEOUT_LIST3 +
+				node_cache_init(node_cache);
+				node_cache->next_reap = jiffies + REAPTIMEOUT_LIST3 +
 				    ((unsigned long)cachep) % REAPTIMEOUT_LIST3;
 
-				cachep->nodelists[node] = l3;
+				cachep->nodelists[node] = node_cache;
 			}
 
-			spin_lock_irq(&cachep->nodelists[node]->list_lock);
+			spin_lock_irq(&cachep->nodelists[node]->spin_lock);
 			cachep->nodelists[node]->free_limit =
 			    (1 + nr_cpus_node(node)) *
 			    cachep->batchcount + cachep->num;
-			spin_unlock_irq(&cachep->nodelists[node]->list_lock);
+			spin_unlock_irq(&cachep->nodelists[node]->spin_lock);
 		}
 
 		/* Now we can go ahead with allocating the shared array's
@@ -952,9 +952,9 @@ static int __devinit cpuup_callback(stru
 				goto bad;
 			cachep->array[cpu] = nc;
 
-			l3 = cachep->nodelists[node];
-			BUG_ON(!l3);
-			if (!l3->shared) {
+			node_cache = cachep->nodelists[node];
+			BUG_ON(!node_cache);
+			if (!node_cache->shared) {
 				if (!(nc = alloc_arraycache(node,
 							    cachep->shared *
 							    cachep->batchcount,
@@ -963,7 +963,7 @@ static int __devinit cpuup_callback(stru
 
 				/* we are serialised from CPU_DEAD or
 				   CPU_UP_CANCELLED by the cpucontrol lock */
-				l3->shared = nc;
+				node_cache->shared = nc;
 			}
 		}
 		up(&cache_chain_sem);
@@ -986,42 +986,42 @@ static int __devinit cpuup_callback(stru
 			/* cpu is dead; no one can alloc from it. */
 			nc = cachep->array[cpu];
 			cachep->array[cpu] = NULL;
-			l3 = cachep->nodelists[node];
+			node_cache = cachep->nodelists[node];
 
-			if (!l3)
+			if (!node_cache)
 				goto unlock_cache;
 
-			spin_lock(&l3->list_lock);
+			spin_lock(&node_cache->spin_lock);
 
-			/* Free limit for this kmem_list3 */
-			l3->free_limit -= cachep->batchcount;
+			/* Free limit for this node_cache */
+			node_cache->free_limit -= cachep->batchcount;
 			if (nc)
 				free_block(cachep, nc->entry, nc->avail, node);
 
 			if (!cpus_empty(mask)) {
-				spin_unlock(&l3->list_lock);
+				spin_unlock(&node_cache->spin_lock);
 				goto unlock_cache;
 			}
 
-			if (l3->shared) {
-				free_block(cachep, l3->shared->entry,
-					   l3->shared->avail, node);
-				kfree(l3->shared);
-				l3->shared = NULL;
+			if (node_cache->shared) {
+				free_block(cachep, node_cache->shared->entry,
+					   node_cache->shared->avail, node);
+				kfree(node_cache->shared);
+				node_cache->shared = NULL;
 			}
-			if (l3->alien) {
-				drain_alien_cache(cachep, l3);
-				free_alien_cache(l3->alien);
-				l3->alien = NULL;
+			if (node_cache->alien) {
+				drain_alien_cache(cachep, node_cache);
+				free_alien_cache(node_cache->alien);
+				node_cache->alien = NULL;
 			}
 
 			/* free slabs belonging to this node */
 			if (__node_shrink(cachep, node)) {
 				cachep->nodelists[node] = NULL;
-				spin_unlock(&l3->list_lock);
-				kfree(l3);
+				spin_unlock(&node_cache->spin_lock);
+				kfree(node_cache);
 			} else {
-				spin_unlock(&l3->list_lock);
+				spin_unlock(&node_cache->spin_lock);
 			}
 		      unlock_cache:
 			spin_unlock_irq(&cachep->spinlock);
@@ -1040,18 +1040,18 @@ static int __devinit cpuup_callback(stru
 static struct notifier_block cpucache_notifier = { &cpuup_callback, NULL, 0 };
 
 /*
- * swap the static kmem_list3 with kmalloced memory
+ * swap the static node_cache with kmalloced memory
  */
-static void init_list(struct kmem_cache *cachep, struct kmem_list3 *list, int nodeid)
+static void init_list(struct kmem_cache *cachep, struct node_cache *list, int nodeid)
 {
-	struct kmem_list3 *ptr;
+	struct node_cache *ptr;
 
 	BUG_ON(cachep->nodelists[nodeid] != list);
-	ptr = kmalloc_node(sizeof(struct kmem_list3), GFP_KERNEL, nodeid);
+	ptr = kmalloc_node(sizeof(struct node_cache), GFP_KERNEL, nodeid);
 	BUG_ON(!ptr);
 
 	local_irq_disable();
-	memcpy(ptr, list, sizeof(struct kmem_list3));
+	memcpy(ptr, list, sizeof(struct node_cache));
 	MAKE_ALL_LISTS(cachep, ptr, nodeid);
 	cachep->nodelists[nodeid] = ptr;
 	local_irq_enable();
@@ -1068,7 +1068,7 @@ void __init kmem_cache_init(void)
 	int i;
 
 	for (i = 0; i < NUM_INIT_LISTS; i++) {
-		kmem_list3_init(&initkmem_list3[i]);
+		node_cache_init(&initnode_cache[i]);
 		if (i < MAX_NUMNODES)
 			cache_cache.nodelists[i] = NULL;
 	}
@@ -1086,7 +1086,7 @@ void __init kmem_cache_init(void)
 	 *    structures of all caches, except cache_cache itself: cache_cache
 	 *    is statically allocated.
 	 *    Initially an __init data area is used for the head array and the
-	 *    kmem_list3 structures, it's replaced with a kmalloc allocated
+	 *    node_cache structures, it's replaced with a kmalloc allocated
 	 *    array at the end of the bootstrap.
 	 * 2) Create the first kmalloc cache.
 	 *    The struct kmem_cache for the new cache is allocated normally.
@@ -1095,7 +1095,7 @@ void __init kmem_cache_init(void)
 	 *    head arrays.
 	 * 4) Replace the __init data head arrays for cache_cache and the first
 	 *    kmalloc cache with kmalloc allocated arrays.
-	 * 5) Replace the __init data for kmem_list3 for cache_cache and
+	 * 5) Replace the __init data for node_cache for cache_cache and
 	 *    the other cache's with kmalloc allocated memory.
 	 * 6) Resize the head arrays of the kmalloc caches to their final sizes.
 	 */
@@ -1106,7 +1106,7 @@ void __init kmem_cache_init(void)
 	list_add(&cache_cache.next, &cache_chain);
 	cache_cache.colour_off = cache_line_size();
 	cache_cache.array[smp_processor_id()] = &initarray_cache.cache;
-	cache_cache.nodelists[numa_node_id()] = &initkmem_list3[CACHE_CACHE];
+	cache_cache.nodelists[numa_node_id()] = &initnode_cache[CACHE_CACHE];
 
 	cache_cache.buffer_size = ALIGN(cache_cache.buffer_size, cache_line_size());
 
@@ -1125,7 +1125,7 @@ void __init kmem_cache_init(void)
 	names = cache_names;
 
 	/* Initialize the caches that provide memory for the array cache
-	 * and the kmem_list3 structures first.
+	 * and the node_cache structures first.
 	 * Without this, further allocations will bug
 	 */
 
@@ -1135,10 +1135,10 @@ void __init kmem_cache_init(void)
 						      (ARCH_KMALLOC_FLAGS |
 						       SLAB_PANIC), NULL, NULL);
 
-	if (INDEX_AC != INDEX_L3)
-		sizes[INDEX_L3].cs_cachep =
-		    kmem_cache_create(names[INDEX_L3].name,
-				      sizes[INDEX_L3].cs_size,
+	if (INDEX_AC != INDEX_NODE_CACHE)
+		sizes[INDEX_NODE_CACHE].cs_cachep =
+		    kmem_cache_create(names[INDEX_NODE_CACHE].name,
+				      sizes[INDEX_NODE_CACHE].cs_size,
 				      ARCH_KMALLOC_MINALIGN,
 				      (ARCH_KMALLOC_FLAGS | SLAB_PANIC), NULL,
 				      NULL);
@@ -1200,20 +1200,20 @@ void __init kmem_cache_init(void)
 		    ptr;
 		local_irq_enable();
 	}
-	/* 5) Replace the bootstrap kmem_list3's */
+	/* 5) Replace the bootstrap node_cache's */
 	{
 		int node;
-		/* Replace the static kmem_list3 structures for the boot cpu */
-		init_list(&cache_cache, &initkmem_list3[CACHE_CACHE],
+		/* Replace the static node_cache structures for the boot cpu */
+		init_list(&cache_cache, &initnode_cache[CACHE_CACHE],
 			  numa_node_id());
 
 		for_each_online_node(node) {
 			init_list(malloc_sizes[INDEX_AC].cs_cachep,
-				  &initkmem_list3[SIZE_AC + node], node);
+				  &initnode_cache[SIZE_AC + node], node);
 
-			if (INDEX_AC != INDEX_L3) {
-				init_list(malloc_sizes[INDEX_L3].cs_cachep,
-					  &initkmem_list3[SIZE_L3 + node],
+			if (INDEX_AC != INDEX_NODE_CACHE) {
+				init_list(malloc_sizes[INDEX_NODE_CACHE].cs_cachep,
+					  &initnode_cache[SIZE_NODE_CACHE + node],
 					  node);
 			}
 		}
@@ -1541,14 +1541,14 @@ static void slab_destroy(struct kmem_cac
 	}
 }
 
-/* For setting up all the kmem_list3s for cache whose buffer_size is same
-   as size of kmem_list3. */
-static void set_up_list3s(struct kmem_cache *cachep, int index)
+/* For setting up all the node_caches for cache whose buffer_size is same
+   as size of node_cache. */
+static void set_up_node_caches(struct kmem_cache *cachep, int index)
 {
 	int node;
 
 	for_each_online_node(node) {
-		cachep->nodelists[node] = &initkmem_list3[index + node];
+		cachep->nodelists[node] = &initnode_cache[index + node];
 		cachep->nodelists[node]->next_reap = jiffies +
 		    REAPTIMEOUT_LIST3 +
 		    ((unsigned long)cachep) % REAPTIMEOUT_LIST3;
@@ -1784,7 +1784,7 @@ kmem_cache_create (const char *name, siz
 		size += BYTES_PER_WORD;
 	}
 #if FORCED_DEBUG && defined(CONFIG_DEBUG_PAGEALLOC)
-	if (size >= malloc_sizes[INDEX_L3 + 1].cs_size
+	if (size >= malloc_sizes[INDEX_NODE_CACHE + 1].cs_size
 	    && cachep->obj_size > cache_line_size() && size < PAGE_SIZE) {
 		cachep->obj_offset += PAGE_SIZE - size;
 		size = PAGE_SIZE;
@@ -1872,13 +1872,13 @@ kmem_cache_create (const char *name, siz
 			    &initarray_generic.cache;
 
 			/* If the cache that's used by
-			 * kmalloc(sizeof(kmem_list3)) is the first cache,
-			 * then we need to set up all its list3s, otherwise
+			 * kmalloc(sizeof(node_cache)) is the first cache,
+			 * then we need to set up all its node_caches, otherwise
 			 * the creation of further caches will BUG().
 			 */
-			set_up_list3s(cachep, SIZE_AC);
-			if (INDEX_AC == INDEX_L3)
-				g_cpucache_up = PARTIAL_L3;
+			set_up_node_caches(cachep, SIZE_AC);
+			if (INDEX_AC == INDEX_NODE_CACHE)
+				g_cpucache_up = PARTIAL_NODE_CACHES;
 			else
 				g_cpucache_up = PARTIAL_AC;
 		} else {
@@ -1886,18 +1886,18 @@ kmem_cache_create (const char *name, siz
 			    kmalloc(sizeof(struct arraycache_init), GFP_KERNEL);
 
 			if (g_cpucache_up == PARTIAL_AC) {
-				set_up_list3s(cachep, SIZE_L3);
-				g_cpucache_up = PARTIAL_L3;
+				set_up_node_caches(cachep, SIZE_NODE_CACHE);
+				g_cpucache_up = PARTIAL_NODE_CACHES;
 			} else {
 				int node;
 				for_each_online_node(node) {
 
 					cachep->nodelists[node] =
 					    kmalloc_node(sizeof
-							 (struct kmem_list3),
+							 (struct node_cache),
 							 GFP_KERNEL, node);
 					BUG_ON(!cachep->nodelists[node]);
-					kmem_list3_init(cachep->
+					node_cache_init(cachep->
 							nodelists[node]);
 				}
 			}
@@ -1942,7 +1942,7 @@ static void check_spinlock_acquired(stru
 {
 #ifdef CONFIG_SMP
 	check_irq_off();
-	assert_spin_locked(&cachep->nodelists[numa_node_id()]->list_lock);
+	assert_spin_locked(&cachep->nodelists[numa_node_id()]->spin_lock);
 #endif
 }
 
@@ -1950,7 +1950,7 @@ static void check_spinlock_acquired_node
 {
 #ifdef CONFIG_SMP
 	check_irq_off();
-	assert_spin_locked(&cachep->nodelists[node]->list_lock);
+	assert_spin_locked(&cachep->nodelists[node]->spin_lock);
 #endif
 }
 
@@ -1990,28 +1990,28 @@ static void do_drain(void *arg)
 
 	check_irq_off();
 	ac = cpu_cache_get(cachep);
-	spin_lock(&cachep->nodelists[node]->list_lock);
+	spin_lock(&cachep->nodelists[node]->spin_lock);
 	free_block(cachep, ac->entry, ac->avail, node);
-	spin_unlock(&cachep->nodelists[node]->list_lock);
+	spin_unlock(&cachep->nodelists[node]->spin_lock);
 	ac->avail = 0;
 }
 
 static void drain_cpu_caches(struct kmem_cache *cachep)
 {
-	struct kmem_list3 *l3;
+	struct node_cache *node_cache;
 	int node;
 
 	smp_call_function_all_cpus(do_drain, cachep);
 	check_irq_on();
 	spin_lock_irq(&cachep->spinlock);
 	for_each_online_node(node) {
-		l3 = cachep->nodelists[node];
-		if (l3) {
-			spin_lock(&l3->list_lock);
-			drain_array_locked(cachep, l3->shared, 1, node);
-			spin_unlock(&l3->list_lock);
-			if (l3->alien)
-				drain_alien_cache(cachep, l3);
+		node_cache = cachep->nodelists[node];
+		if (node_cache) {
+			spin_lock(&node_cache->spin_lock);
+			drain_array_locked(cachep, node_cache->shared, 1, node);
+			spin_unlock(&node_cache->spin_lock);
+			if (node_cache->alien)
+				drain_alien_cache(cachep, node_cache);
 		}
 	}
 	spin_unlock_irq(&cachep->spinlock);
@@ -2020,46 +2020,46 @@ static void drain_cpu_caches(struct kmem
 static int __node_shrink(struct kmem_cache *cachep, int node)
 {
 	struct slab *slabp;
-	struct kmem_list3 *l3 = cachep->nodelists[node];
+	struct node_cache *node_cache = cachep->nodelists[node];
 	int ret;
 
 	for (;;) {
 		struct list_head *p;
 
-		p = l3->slabs_free.prev;
-		if (p == &l3->slabs_free)
+		p = node_cache->slabs_free.prev;
+		if (p == &node_cache->slabs_free)
 			break;
 
-		slabp = list_entry(l3->slabs_free.prev, struct slab, list);
+		slabp = list_entry(node_cache->slabs_free.prev, struct slab, list);
 #if DEBUG
 		if (slabp->inuse)
 			BUG();
 #endif
 		list_del(&slabp->list);
 
-		l3->free_objects -= cachep->num;
-		spin_unlock_irq(&l3->list_lock);
+		node_cache->free_objects -= cachep->num;
+		spin_unlock_irq(&node_cache->spin_lock);
 		slab_destroy(cachep, slabp);
-		spin_lock_irq(&l3->list_lock);
+		spin_lock_irq(&node_cache->spin_lock);
 	}
-	ret = !list_empty(&l3->slabs_full) || !list_empty(&l3->slabs_partial);
+	ret = !list_empty(&node_cache->slabs_full) || !list_empty(&node_cache->slabs_partial);
 	return ret;
 }
 
 static int __cache_shrink(struct kmem_cache *cachep)
 {
 	int ret = 0, i = 0;
-	struct kmem_list3 *l3;
+	struct node_cache *node_cache;
 
 	drain_cpu_caches(cachep);
 
 	check_irq_on();
 	for_each_online_node(i) {
-		l3 = cachep->nodelists[i];
-		if (l3) {
-			spin_lock_irq(&l3->list_lock);
+		node_cache = cachep->nodelists[i];
+		if (node_cache) {
+			spin_lock_irq(&node_cache->spin_lock);
 			ret += __node_shrink(cachep, i);
-			spin_unlock_irq(&l3->list_lock);
+			spin_unlock_irq(&node_cache->spin_lock);
 		}
 	}
 	return (ret ? 1 : 0);
@@ -2101,7 +2101,7 @@ EXPORT_SYMBOL(kmem_cache_shrink);
 int kmem_cache_destroy(struct kmem_cache *cachep)
 {
 	int i;
-	struct kmem_list3 *l3;
+	struct node_cache *node_cache;
 
 	if (!cachep || in_interrupt())
 		BUG();
@@ -2132,12 +2132,12 @@ int kmem_cache_destroy(struct kmem_cache
 	for_each_online_cpu(i)
 	    kfree(cachep->array[i]);
 
-	/* NUMA: free the list3 structures */
+	/* NUMA: free the node cache structures */
 	for_each_online_node(i) {
-		if ((l3 = cachep->nodelists[i])) {
-			kfree(l3->shared);
-			free_alien_cache(l3->alien);
-			kfree(l3);
+		if ((node_cache = cachep->nodelists[i])) {
+			kfree(node_cache->shared);
+			free_alien_cache(node_cache->alien);
+			kfree(node_cache);
 		}
 	}
 	kmem_cache_free(&cache_cache, cachep);
@@ -2297,7 +2297,7 @@ static int cache_grow(struct kmem_cache 
 	size_t offset;
 	gfp_t local_flags;
 	unsigned long ctor_flags;
-	struct kmem_list3 *l3;
+	struct node_cache *node_cache;
 
 	/* Be lazy and only check for valid flags here,
 	 * keeping it out of the critical path in kmem_cache_alloc().
@@ -2359,14 +2359,14 @@ static int cache_grow(struct kmem_cache 
 	if (local_flags & __GFP_WAIT)
 		local_irq_disable();
 	check_irq_off();
-	l3 = cachep->nodelists[nodeid];
-	spin_lock(&l3->list_lock);
+	node_cache = cachep->nodelists[nodeid];
+	spin_lock(&node_cache->spin_lock);
 
 	/* Make slab active. */
-	list_add_tail(&slabp->list, &(l3->slabs_free));
+	list_add_tail(&slabp->list, &(node_cache->slabs_free));
 	STATS_INC_GROWN(cachep);
-	l3->free_objects += cachep->num;
-	spin_unlock(&l3->list_lock);
+	node_cache->free_objects += cachep->num;
+	spin_unlock(&node_cache->spin_lock);
 	return 1;
       opps1:
 	kmem_freepages(cachep, objp);
@@ -2511,7 +2511,7 @@ static void check_slabp(struct kmem_cach
 static void *cache_alloc_refill(struct kmem_cache *cachep, gfp_t flags)
 {
 	int batchcount;
-	struct kmem_list3 *l3;
+	struct node_cache *node_cache;
 	struct array_cache *ac;
 
 	check_irq_off();
@@ -2525,13 +2525,13 @@ static void *cache_alloc_refill(struct k
 		 */
 		batchcount = BATCHREFILL_LIMIT;
 	}
-	l3 = cachep->nodelists[numa_node_id()];
+	node_cache = cachep->nodelists[numa_node_id()];
 
-	BUG_ON(ac->avail > 0 || !l3);
-	spin_lock(&l3->list_lock);
+	BUG_ON(ac->avail > 0 || !node_cache);
+	spin_lock(&node_cache->spin_lock);
 
-	if (l3->shared) {
-		struct array_cache *shared_array = l3->shared;
+	if (node_cache->shared) {
+		struct array_cache *shared_array = node_cache->shared;
 		if (shared_array->avail) {
 			if (batchcount > shared_array->avail)
 				batchcount = shared_array->avail;
@@ -2548,11 +2548,11 @@ static void *cache_alloc_refill(struct k
 		struct list_head *entry;
 		struct slab *slabp;
 		/* Get slab alloc is to come from. */
-		entry = l3->slabs_partial.next;
-		if (entry == &l3->slabs_partial) {
-			l3->free_touched = 1;
-			entry = l3->slabs_free.next;
-			if (entry == &l3->slabs_free)
+		entry = node_cache->slabs_partial.next;
+		if (entry == &node_cache->slabs_partial) {
+			node_cache->free_touched = 1;
+			entry = node_cache->slabs_free.next;
+			if (entry == &node_cache->slabs_free)
 				goto must_grow;
 		}
 
@@ -2572,15 +2572,15 @@ static void *cache_alloc_refill(struct k
 		/* move slabp to correct slabp list: */
 		list_del(&slabp->list);
 		if (slabp->free == BUFCTL_END)
-			list_add(&slabp->list, &l3->slabs_full);
+			list_add(&slabp->list, &node_cache->slabs_full);
 		else
-			list_add(&slabp->list, &l3->slabs_partial);
+			list_add(&slabp->list, &node_cache->slabs_partial);
 	}
 
       must_grow:
-	l3->free_objects -= ac->avail;
+	node_cache->free_objects -= ac->avail;
       alloc_done:
-	spin_unlock(&l3->list_lock);
+	spin_unlock(&node_cache->spin_lock);
 
 	if (unlikely(!ac->avail)) {
 		int x;
@@ -2699,20 +2699,20 @@ static void *__cache_alloc_node(struct k
 {
 	struct list_head *entry;
 	struct slab *slabp;
-	struct kmem_list3 *l3;
+	struct node_cache *node_cache;
 	void *obj;
 	int x;
 
-	l3 = cachep->nodelists[nodeid];
-	BUG_ON(!l3);
+	node_cache = cachep->nodelists[nodeid];
+	BUG_ON(!node_cache);
 
       retry:
-	spin_lock(&l3->list_lock);
-	entry = l3->slabs_partial.next;
-	if (entry == &l3->slabs_partial) {
-		l3->free_touched = 1;
-		entry = l3->slabs_free.next;
-		if (entry == &l3->slabs_free)
+	spin_lock(&node_cache->spin_lock);
+	entry = node_cache->slabs_partial.next;
+	if (entry == &node_cache->slabs_partial) {
+		node_cache->free_touched = 1;
+		entry = node_cache->slabs_free.next;
+		if (entry == &node_cache->slabs_free)
 			goto must_grow;
 	}
 
@@ -2728,21 +2728,21 @@ static void *__cache_alloc_node(struct k
 
 	obj = slab_get_obj(cachep, slabp, nodeid);
 	check_slabp(cachep, slabp);
-	l3->free_objects--;
+	node_cache->free_objects--;
 	/* move slabp to correct slabp list: */
 	list_del(&slabp->list);
 
 	if (slabp->free == BUFCTL_END) {
-		list_add(&slabp->list, &l3->slabs_full);
+		list_add(&slabp->list, &node_cache->slabs_full);
 	} else {
-		list_add(&slabp->list, &l3->slabs_partial);
+		list_add(&slabp->list, &node_cache->slabs_partial);
 	}
 
-	spin_unlock(&l3->list_lock);
+	spin_unlock(&node_cache->spin_lock);
 	goto done;
 
       must_grow:
-	spin_unlock(&l3->list_lock);
+	spin_unlock(&node_cache->spin_lock);
 	x = cache_grow(cachep, flags, nodeid);
 
 	if (!x)
@@ -2755,42 +2755,42 @@ static void *__cache_alloc_node(struct k
 #endif
 
 /*
- * Caller needs to acquire correct kmem_list's list_lock
+ * Caller needs to acquire correct kmem_list's spin_lock
  */
 static void free_block(struct kmem_cache *cachep, void **objpp, int nr_objects,
 		       int node)
 {
 	int i;
-	struct kmem_list3 *l3;
+	struct node_cache *node_cache;
 
 	for (i = 0; i < nr_objects; i++) {
 		void *objp = objpp[i];
 		struct slab *slabp;
 
 		slabp = virt_to_slab(objp);
-		l3 = cachep->nodelists[node];
+		node_cache = cachep->nodelists[node];
 		list_del(&slabp->list);
 		check_spinlock_acquired_node(cachep, node);
 		check_slabp(cachep, slabp);
 		slab_put_obj(cachep, slabp, objp, node);
 		STATS_DEC_ACTIVE(cachep);
-		l3->free_objects++;
+		node_cache->free_objects++;
 		check_slabp(cachep, slabp);
 
 		/* fixup slab chains */
 		if (slabp->inuse == 0) {
-			if (l3->free_objects > l3->free_limit) {
-				l3->free_objects -= cachep->num;
+			if (node_cache->free_objects > node_cache->free_limit) {
+				node_cache->free_objects -= cachep->num;
 				slab_destroy(cachep, slabp);
 			} else {
-				list_add(&slabp->list, &l3->slabs_free);
+				list_add(&slabp->list, &node_cache->slabs_free);
 			}
 		} else {
 			/* Unconditionally move a slab to the end of the
 			 * partial list on free - maximum time for the
 			 * other objects to be freed, too.
 			 */
-			list_add_tail(&slabp->list, &l3->slabs_partial);
+			list_add_tail(&slabp->list, &node_cache->slabs_partial);
 		}
 	}
 }
@@ -2798,7 +2798,7 @@ static void free_block(struct kmem_cache
 static void cache_flusharray(struct kmem_cache *cachep, struct array_cache *ac)
 {
 	int batchcount;
-	struct kmem_list3 *l3;
+	struct node_cache *node_cache;
 	int node = numa_node_id();
 
 	batchcount = ac->batchcount;
@@ -2806,10 +2806,10 @@ static void cache_flusharray(struct kmem
 	BUG_ON(!batchcount || batchcount > ac->avail);
 #endif
 	check_irq_off();
-	l3 = cachep->nodelists[node];
-	spin_lock(&l3->list_lock);
-	if (l3->shared) {
-		struct array_cache *shared_array = l3->shared;
+	node_cache = cachep->nodelists[node];
+	spin_lock(&node_cache->spin_lock);
+	if (node_cache->shared) {
+		struct array_cache *shared_array = node_cache->shared;
 		int max = shared_array->limit - shared_array->avail;
 		if (max) {
 			if (batchcount > max)
@@ -2828,8 +2828,8 @@ static void cache_flusharray(struct kmem
 		int i = 0;
 		struct list_head *p;
 
-		p = l3->slabs_free.next;
-		while (p != &(l3->slabs_free)) {
+		p = node_cache->slabs_free.next;
+		while (p != &(node_cache->slabs_free)) {
 			struct slab *slabp;
 
 			slabp = list_entry(p, struct slab, list);
@@ -2841,7 +2841,7 @@ static void cache_flusharray(struct kmem
 		STATS_SET_FREEABLE(cachep, i);
 	}
 #endif
-	spin_unlock(&l3->list_lock);
+	spin_unlock(&node_cache->spin_lock);
 	ac->avail -= batchcount;
 	memmove(ac->entry, &(ac->entry[batchcount]),
 		sizeof(void *) * ac->avail);
@@ -2871,12 +2871,12 @@ static inline void __cache_free(struct k
 		if (unlikely(slabp->nodeid != numa_node_id())) {
 			struct array_cache *alien = NULL;
 			int nodeid = slabp->nodeid;
-			struct kmem_list3 *l3 =
+			struct node_cache *node_cache =
 			    cachep->nodelists[numa_node_id()];
 
 			STATS_INC_NODEFREES(cachep);
-			if (l3->alien && l3->alien[nodeid]) {
-				alien = l3->alien[nodeid];
+			if (node_cache->alien && node_cache->alien[nodeid]) {
+				alien = node_cache->alien[nodeid];
 				spin_lock(&alien->lock);
 				if (unlikely(alien->avail == alien->limit))
 					__drain_alien_cache(cachep,
@@ -2885,10 +2885,10 @@ static inline void __cache_free(struct k
 				spin_unlock(&alien->lock);
 			} else {
 				spin_lock(&(cachep->nodelists[nodeid])->
-					  list_lock);
+					  spin_lock);
 				free_block(cachep, &objp, 1, nodeid);
 				spin_unlock(&(cachep->nodelists[nodeid])->
-					    list_lock);
+					    spin_lock);
 			}
 			return;
 		}
@@ -3173,12 +3173,12 @@ const char *kmem_cache_name(struct kmem_
 EXPORT_SYMBOL_GPL(kmem_cache_name);
 
 /*
- * This initializes kmem_list3 for all nodes.
+ * This initializes node_cache for all nodes.
  */
-static int alloc_kmemlist(struct kmem_cache *cachep)
+static int alloc_node_caches(struct kmem_cache *cachep)
 {
 	int node;
-	struct kmem_list3 *l3;
+	struct node_cache *node_cache;
 	int err = 0;
 
 	for_each_online_node(node) {
@@ -3192,37 +3192,37 @@ static int alloc_kmemlist(struct kmem_ca
 						    cachep->batchcount),
 					     0xbaadf00d)))
 			goto fail;
-		if ((l3 = cachep->nodelists[node])) {
+		if ((node_cache = cachep->nodelists[node])) {
 
-			spin_lock_irq(&l3->list_lock);
+			spin_lock_irq(&node_cache->spin_lock);
 
 			if ((nc = cachep->nodelists[node]->shared))
 				free_block(cachep, nc->entry, nc->avail, node);
 
-			l3->shared = new;
+			node_cache->shared = new;
 			if (!cachep->nodelists[node]->alien) {
-				l3->alien = new_alien;
+				node_cache->alien = new_alien;
 				new_alien = NULL;
 			}
-			l3->free_limit = (1 + nr_cpus_node(node)) *
+			node_cache->free_limit = (1 + nr_cpus_node(node)) *
 			    cachep->batchcount + cachep->num;
-			spin_unlock_irq(&l3->list_lock);
+			spin_unlock_irq(&node_cache->spin_lock);
 			kfree(nc);
 			free_alien_cache(new_alien);
 			continue;
 		}
-		if (!(l3 = kmalloc_node(sizeof(struct kmem_list3),
+		if (!(node_cache = kmalloc_node(sizeof(struct node_cache),
 					GFP_KERNEL, node)))
 			goto fail;
 
-		kmem_list3_init(l3);
-		l3->next_reap = jiffies + REAPTIMEOUT_LIST3 +
+		node_cache_init(node_cache);
+		node_cache->next_reap = jiffies + REAPTIMEOUT_LIST3 +
 		    ((unsigned long)cachep) % REAPTIMEOUT_LIST3;
-		l3->shared = new;
-		l3->alien = new_alien;
-		l3->free_limit = (1 + nr_cpus_node(node)) *
+		node_cache->shared = new;
+		node_cache->alien = new_alien;
+		node_cache->free_limit = (1 + nr_cpus_node(node)) *
 		    cachep->batchcount + cachep->num;
-		cachep->nodelists[node] = l3;
+		cachep->nodelists[node] = node_cache;
 	}
 	return err;
       fail:
@@ -3278,15 +3278,15 @@ static int do_tune_cpucache(struct kmem_
 		struct array_cache *ccold = new.new[i];
 		if (!ccold)
 			continue;
-		spin_lock_irq(&cachep->nodelists[cpu_to_node(i)]->list_lock);
+		spin_lock_irq(&cachep->nodelists[cpu_to_node(i)]->spin_lock);
 		free_block(cachep, ccold->entry, ccold->avail, cpu_to_node(i));
-		spin_unlock_irq(&cachep->nodelists[cpu_to_node(i)]->list_lock);
+		spin_unlock_irq(&cachep->nodelists[cpu_to_node(i)]->spin_lock);
 		kfree(ccold);
 	}
 
-	err = alloc_kmemlist(cachep);
+	err = alloc_node_caches(cachep);
 	if (err) {
-		printk(KERN_ERR "alloc_kmemlist failed for %s, error %d.\n",
+		printk(KERN_ERR "alloc_node_caches failed for %s, error %d.\n",
 		       cachep->name, -err);
 		BUG();
 	}
@@ -3380,7 +3380,7 @@ static void drain_array_locked(struct km
 static void cache_reap(void *unused)
 {
 	struct list_head *walk;
-	struct kmem_list3 *l3;
+	struct node_cache *node_cache;
 
 	if (down_trylock(&cache_chain_sem)) {
 		/* Give up. Setup the next iteration. */
@@ -3402,34 +3402,34 @@ static void cache_reap(void *unused)
 
 		check_irq_on();
 
-		l3 = searchp->nodelists[numa_node_id()];
-		if (l3->alien)
-			drain_alien_cache(searchp, l3);
-		spin_lock_irq(&l3->list_lock);
+		node_cache = searchp->nodelists[numa_node_id()];
+		if (node_cache->alien)
+			drain_alien_cache(searchp, node_cache);
+		spin_lock_irq(&node_cache->spin_lock);
 
 		drain_array_locked(searchp, cpu_cache_get(searchp), 0,
 				   numa_node_id());
 
-		if (time_after(l3->next_reap, jiffies))
+		if (time_after(node_cache->next_reap, jiffies))
 			goto next_unlock;
 
-		l3->next_reap = jiffies + REAPTIMEOUT_LIST3;
+		node_cache->next_reap = jiffies + REAPTIMEOUT_LIST3;
 
-		if (l3->shared)
-			drain_array_locked(searchp, l3->shared, 0,
+		if (node_cache->shared)
+			drain_array_locked(searchp, node_cache->shared, 0,
 					   numa_node_id());
 
-		if (l3->free_touched) {
-			l3->free_touched = 0;
+		if (node_cache->free_touched) {
+			node_cache->free_touched = 0;
 			goto next_unlock;
 		}
 
 		tofree =
-		    (l3->free_limit + 5 * searchp->num -
+		    (node_cache->free_limit + 5 * searchp->num -
 		     1) / (5 * searchp->num);
 		do {
-			p = l3->slabs_free.next;
-			if (p == &(l3->slabs_free))
+			p = node_cache->slabs_free.next;
+			if (p == &(node_cache->slabs_free))
 				break;
 
 			slabp = list_entry(p, struct slab, list);
@@ -3442,13 +3442,13 @@ static void cache_reap(void *unused)
 			 * searchp cannot disappear, we hold
 			 * cache_chain_lock
 			 */
-			l3->free_objects -= searchp->num;
-			spin_unlock_irq(&l3->list_lock);
+			node_cache->free_objects -= searchp->num;
+			spin_unlock_irq(&node_cache->spin_lock);
 			slab_destroy(searchp, slabp);
-			spin_lock_irq(&l3->list_lock);
+			spin_lock_irq(&node_cache->spin_lock);
 		} while (--tofree > 0);
 	      next_unlock:
-		spin_unlock_irq(&l3->list_lock);
+		spin_unlock_irq(&node_cache->spin_lock);
 	      next:
 		cond_resched();
 	}
@@ -3526,27 +3526,27 @@ static int s_show(struct seq_file *m, vo
 	const char *name;
 	char *error = NULL;
 	int node;
-	struct kmem_list3 *l3;
+	struct node_cache *node_cache;
 
 	check_irq_on();
 	spin_lock_irq(&cachep->spinlock);
 	active_objs = 0;
 	num_slabs = 0;
 	for_each_online_node(node) {
-		l3 = cachep->nodelists[node];
-		if (!l3)
+		node_cache = cachep->nodelists[node];
+		if (!node_cache)
 			continue;
 
-		spin_lock(&l3->list_lock);
+		spin_lock(&node_cache->spin_lock);
 
-		list_for_each(q, &l3->slabs_full) {
+		list_for_each(q, &node_cache->slabs_full) {
 			slabp = list_entry(q, struct slab, list);
 			if (slabp->inuse != cachep->num && !error)
 				error = "slabs_full accounting error";
 			active_objs += cachep->num;
 			active_slabs++;
 		}
-		list_for_each(q, &l3->slabs_partial) {
+		list_for_each(q, &node_cache->slabs_partial) {
 			slabp = list_entry(q, struct slab, list);
 			if (slabp->inuse == cachep->num && !error)
 				error = "slabs_partial inuse accounting error";
@@ -3555,16 +3555,16 @@ static int s_show(struct seq_file *m, vo
 			active_objs += slabp->inuse;
 			active_slabs++;
 		}
-		list_for_each(q, &l3->slabs_free) {
+		list_for_each(q, &node_cache->slabs_free) {
 			slabp = list_entry(q, struct slab, list);
 			if (slabp->inuse && !error)
 				error = "slabs_free/inuse accounting error";
 			num_slabs++;
 		}
-		free_objects += l3->free_objects;
-		shared_avail += l3->shared->avail;
+		free_objects += node_cache->free_objects;
+		shared_avail += node_cache->shared->avail;
 
-		spin_unlock(&l3->list_lock);
+		spin_unlock(&node_cache->spin_lock);
 	}
 	num_slabs += active_slabs;
 	num_objs = num_slabs * cachep->num;
@@ -3583,7 +3583,7 @@ static int s_show(struct seq_file *m, vo
 	seq_printf(m, " : slabdata %6lu %6lu %6lu",
 		   active_slabs, num_slabs, shared_avail);
 #if STATS
-	{			/* list3 stats */
+	{			/* node cache stats */
 		unsigned long high = cachep->high_mark;
 		unsigned long allocs = cachep->num_allocations;
 		unsigned long grown = cachep->grown;


