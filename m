Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262489AbVCPECk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262489AbVCPECk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 23:02:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262493AbVCPECk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 23:02:40 -0500
Received: from 209-204-138-32.dsl.static.sonic.net ([209.204.138.32]:43532
	"EHLO graphe.net") by vger.kernel.org with ESMTP id S262489AbVCPEAZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 23:00:25 -0500
Date: Tue, 15 Mar 2005 20:00:17 -0800 (PST)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@server.graphe.net
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH] NUMA Slab Allocator
Message-ID: <Pine.LNX.4.58.0503151958590.4860@server.graphe.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a NUMA slab allocator. It creates slabs on multiple nodes and
manages slabs in such a way that locality of allocations is optimized.
Each node has its own list of partial, free and full slabs. All object
allocations for a node occur from node specific slab lists.

Signed-off-by: Alok N Kataria <alokk@calsoftinc.com>
Signed-off-by: Shobhit Dayal <shobhit@calsoftinc.com>
Signed-off-by: Christoph Lameter <christoph@lameter.com>
Signed-off-by: Shai Fultheim <Shai@Scalex86.org>

Index: linux-2.6.11/include/linux/slab.h
===================================================================
--- linux-2.6.11.orig/include/linux/slab.h	2005-03-15 14:47:12.567040608 -0800
+++ linux-2.6.11/include/linux/slab.h	2005-03-15 14:47:19.290018560 -0800
@@ -63,11 +63,11 @@ extern int kmem_cache_destroy(kmem_cache
 extern int kmem_cache_shrink(kmem_cache_t *);
 extern void *kmem_cache_alloc(kmem_cache_t *, int);
 #ifdef CONFIG_NUMA
-extern void *kmem_cache_alloc_node(kmem_cache_t *, int);
+extern void *kmem_cache_alloc_node(kmem_cache_t *, int, int);
 #else
-static inline void *kmem_cache_alloc_node(kmem_cache_t *cachep, int node)
+static inline void *kmem_cache_alloc_node(kmem_cache_t *cachep, int node, int gfp_mask)
 {
-	return kmem_cache_alloc(cachep, GFP_KERNEL);
+	return kmem_cache_alloc(cachep, gfp_mask);
 }
 #endif
 extern void kmem_cache_free(kmem_cache_t *, void *);
@@ -81,6 +81,33 @@ struct cache_sizes {
 };
 extern struct cache_sizes malloc_sizes[];
 extern void *__kmalloc(size_t, int);
+extern void *__kmalloc_node(size_t, int, int);
+
+/*
+ * A new interface to allow allocating memory on a specific node.
+ */
+static inline void *kmalloc_node(size_t size, int node, int flags)
+{
+	if (__builtin_constant_p(size)) {
+		int i = 0;
+#define CACHE(x) \
+		if (size <= x) \
+			goto found; \
+		else \
+			i++;
+#include "kmalloc_sizes.h"
+#undef CACHE
+		{
+			extern void __you_cannot_kmalloc_that_much(void);
+			__you_cannot_kmalloc_that_much();
+		}
+found:
+		return kmem_cache_alloc_node((flags & GFP_DMA) ?
+			malloc_sizes[i].cs_dmacachep :
+			malloc_sizes[i].cs_cachep, node, flags);
+	}
+	return __kmalloc_node(size, node, flags);
+}

 static inline void *kmalloc(size_t size, int flags)
 {
Index: linux-2.6.11/mm/slab.c
===================================================================
--- linux-2.6.11.orig/mm/slab.c	2005-03-15 14:47:12.567040608 -0800
+++ linux-2.6.11/mm/slab.c	2005-03-15 16:17:27.242884760 -0800
@@ -75,6 +75,15 @@
  *
  *	At present, each engine can be growing a cache.  This should be blocked.
  *
+ * 15 March 2005. NUMA slab allocator.
+ *	Shobhit Dayal <shobhit@calsoftinc.com>
+ *	Alok N Kataria <alokk@calsoftinc.com>
+ *
+ *	Modified the slab allocator to be node aware on NUMA systems.
+ *	Each node has its own list of partial, free and full slabs.
+ *	All object allocations for a node occur from node specific slab lists.
+ *	Created a new interface called kmalloc_node() for allocating memory from
+ *	a specific node.
  */

 #include	<linux/config.h>
@@ -92,7 +101,7 @@
 #include	<linux/sysctl.h>
 #include	<linux/module.h>
 #include	<linux/rcupdate.h>
-
+#include	<linux/nodemask.h>
 #include	<asm/uaccess.h>
 #include	<asm/cacheflush.h>
 #include	<asm/tlbflush.h>
@@ -210,6 +219,7 @@ struct slab {
 	void			*s_mem;		/* including colour offset */
 	unsigned int		inuse;		/* num of objs active in slab */
 	kmem_bufctl_t		free;
+	unsigned short          nodeid;
 };

 /*
@@ -278,21 +288,58 @@ struct kmem_list3 {
 	int		free_touched;
 	unsigned long	next_reap;
 	struct array_cache	*shared;
+	spinlock_t      list_lock;
+	unsigned int 	free_limit;
 };

+/*
+ * Need this for bootstrapping a per node allocator.
+ */
+#define NUM_INIT_LISTS 3
+struct kmem_list3 __initdata initkmem_list3[NUM_INIT_LISTS];
+struct kmem_list3 __initdata kmem64_list3[MAX_NUMNODES];
+
 #define LIST3_INIT(parent) \
-	{ \
-		.slabs_full	= LIST_HEAD_INIT(parent.slabs_full), \
-		.slabs_partial	= LIST_HEAD_INIT(parent.slabs_partial), \
-		.slabs_free	= LIST_HEAD_INIT(parent.slabs_free) \
-	}
+	do {	\
+		INIT_LIST_HEAD(&(parent)->slabs_full);	\
+		INIT_LIST_HEAD(&(parent)->slabs_partial);	\
+		INIT_LIST_HEAD(&(parent)->slabs_free);	\
+		(parent)->shared = NULL; \
+		(parent)->list_lock = SPIN_LOCK_UNLOCKED;	\
+		(parent)->free_objects = 0;	\
+		(parent)->free_touched = 0;	\
+	} while(0)
+
+#define MAKE_LIST(cachep, listp, slab, nodeid)	\
+	do {	\
+		if(list_empty(&(cachep->nodelists[nodeid]->slab)))	\
+			INIT_LIST_HEAD(listp);		\
+		else {	listp->next->prev = listp;	\
+			listp->prev->next = listp;	\
+		}					\
+	}while(0)
+
+#define	MAKE_ALL_LISTS(cachep, ptr, nodeid)			\
+	do {					\
+	MAKE_LIST((cachep), (&(ptr)->slabs_full), slabs_full, nodeid);	\
+	MAKE_LIST((cachep), (&(ptr)->slabs_partial), slabs_partial, nodeid);	\
+	MAKE_LIST((cachep), (&(ptr)->slabs_free), slabs_free, nodeid);	\
+	}while(0)
+
 #define list3_data(cachep) \
-	(&(cachep)->lists)
+	((cachep->nodelists[numa_node_id()]))

 /* NUMA: per-node */
 #define list3_data_ptr(cachep, ptr) \
 		list3_data(cachep)

+#ifdef CONFIG_NUMA
+#define is_node_online(node) node_online(node)
+#else
+#define is_node_online(node) \
+	({ BUG_ON(node != 0); 1; })
+#endif /* CONFIG_NUMA */
+
 /*
  * kmem_cache_t
  *
@@ -304,13 +351,12 @@ struct kmem_cache_s {
 	struct array_cache	*array[NR_CPUS];
 	unsigned int		batchcount;
 	unsigned int		limit;
+	unsigned int 		shared;
 /* 2) touched by every alloc & free from the backend */
-	struct kmem_list3	lists;
-	/* NUMA: kmem_3list_t	*nodelists[MAX_NUMNODES] */
+	struct kmem_list3	*nodelists[MAX_NUMNODES];
 	unsigned int		objsize;
 	unsigned int	 	flags;	/* constant flags */
 	unsigned int		num;	/* # of objs per slab */
-	unsigned int		free_limit; /* upper limit of objects in the lists */
 	spinlock_t		spinlock;

 /* 3) cache_grow/shrink */
@@ -533,9 +579,9 @@ static struct arraycache_init initarray_

 /* internal cache of cache description objs */
 static kmem_cache_t cache_cache = {
-	.lists		= LIST3_INIT(cache_cache.lists),
 	.batchcount	= 1,
 	.limit		= BOOT_CPUCACHE_ENTRIES,
+	.shared		= 1,
 	.objsize	= sizeof(kmem_cache_t),
 	.flags		= SLAB_NO_REAP,
 	.spinlock	= SPIN_LOCK_UNLOCKED,
@@ -568,11 +614,20 @@ static enum {
 	FULL
 } g_cpucache_up;

+static enum {
+	CACHE_CACHE,
+	SIZE_32,
+	SIZE_DMA_32,
+	SIZE_64,
+	ALL
+} cpucache_up_64;
+
 static DEFINE_PER_CPU(struct work_struct, reap_work);

 static void free_block(kmem_cache_t* cachep, void** objpp, int len);
 static void enable_cpucache (kmem_cache_t *cachep);
 static void cache_reap (void *unused);
+static int __cache_shrink(kmem_cache_t *, int);

 static inline void ** ac_entry(struct array_cache *ac)
 {
@@ -664,14 +719,7 @@ static struct array_cache *alloc_arrayca
 	int memsize = sizeof(void*)*entries+sizeof(struct array_cache);
 	struct array_cache *nc = NULL;

-	if (cpu != -1) {
-		kmem_cache_t *cachep;
-		cachep = kmem_find_general_cachep(memsize, GFP_KERNEL);
-		if (cachep)
-			nc = kmem_cache_alloc_node(cachep, cpu_to_node(cpu));
-	}
-	if (!nc)
-		nc = kmalloc(memsize, GFP_KERNEL);
+	nc = kmalloc_node(memsize, cpu_to_node(cpu), GFP_KERNEL);
 	if (nc) {
 		nc->avail = 0;
 		nc->limit = entries;
@@ -686,24 +734,59 @@ static int __devinit cpuup_callback(stru
 				  void *hcpu)
 {
 	long cpu = (long)hcpu;
-	kmem_cache_t* cachep;
+	kmem_cache_t *cachep;
+	struct kmem_list3 *l3 = NULL;
+	int node = cpu_to_node(cpu);
+	int memsize = sizeof(struct kmem_list3);
+	struct array_cache *nc = NULL;
+	unsigned long flags;

 	switch (action) {
 	case CPU_UP_PREPARE:
 		down(&cache_chain_sem);
+		/* we need to do this right in the begining since
+		 * alloc_arraycache's are going to use this list.
+		 * kmalloc_node allows us to add the slab to the right
+		 * kmem_list3 and not this cpu's kmem_list3
+		 */
+
 		list_for_each_entry(cachep, &cache_chain, next) {
-			struct array_cache *nc;
+			/* setup the size64 kmemlist for hcpu before we can begin anything.
+			 * Make sure some other cpu on this node has not already allocated this
+			 */
+			if(!cachep->nodelists[node]) {
+				if(!(l3 = kmalloc_node(memsize,	node, GFP_KERNEL)))
+					goto bad;
+				LIST3_INIT(l3);
+				l3->next_reap = jiffies + REAPTIMEOUT_LIST3 +
+					((unsigned long)cachep)%REAPTIMEOUT_LIST3;
+
+				cachep->nodelists[node] = l3;
+			}
+
+			spin_lock_irqsave(&cachep->nodelists[node]->list_lock, flags);
+			cachep->nodelists[node]->free_limit = (1 + nr_cpus_node(node))*cachep->batchcount
+				+ cachep->num;
+			spin_unlock_irqrestore(&cachep->nodelists[node]->list_lock, flags);
+		}
+
+		/*Now we can go ahead with allocating the shared array's & array cache's*/
+		list_for_each_entry(cachep, &cache_chain, next) {
+			l3 = cachep->nodelists[node];
+			BUG_ON(!l3);
+			if(!l3->shared) {
+				if(!(nc = alloc_arraycache(cpu, cachep->shared*cachep->batchcount, 0xbaadf00d)))
+					goto  bad;
+
+				/*we are serialised from CPU_DEAD or CPU_UP_CANCELLED by the cpucontrol lock*/
+				l3->shared = nc;
+			}

 			nc = alloc_arraycache(cpu, cachep->limit, cachep->batchcount);
 			if (!nc)
 				goto bad;

-			spin_lock_irq(&cachep->spinlock);
 			cachep->array[cpu] = nc;
-			cachep->free_limit = (1+num_online_cpus())*cachep->batchcount
-						+ cachep->num;
-			spin_unlock_irq(&cachep->spinlock);
-
 		}
 		up(&cache_chain_sem);
 		break;
@@ -718,13 +801,37 @@ static int __devinit cpuup_callback(stru

 		list_for_each_entry(cachep, &cache_chain, next) {
 			struct array_cache *nc;
+			cpumask_t mask;

+			mask = node_to_cpumask(node);
 			spin_lock_irq(&cachep->spinlock);
 			/* cpu is dead; no one can alloc from it. */
 			nc = cachep->array[cpu];
 			cachep->array[cpu] = NULL;
-			cachep->free_limit -= cachep->batchcount;
-			free_block(cachep, ac_entry(nc), nc->avail);
+			l3 = cachep->nodelists[node];
+			if(!l3)
+				goto unlock_cache;
+			spin_lock(&l3->list_lock);
+			l3->free_limit -= cachep->batchcount;		//Free limit for this kmem_list3
+			if(nc)
+				free_block(cachep, ac_entry(nc), nc->avail);
+			if(!cpus_empty(mask)) {
+                                spin_unlock(&l3->list_lock);
+                                goto unlock_cache;
+                        }
+
+			if(!l3->shared)
+				free_block(cachep, ac_entry(l3->shared), l3->shared->avail);
+
+			spin_unlock(&l3->list_lock);
+
+			/* free slabs belonging to this node */
+			if(__cache_shrink(cachep, node)) {
+				cachep->nodelists[node] = NULL;
+				kfree(l3->shared);
+				kfree(l3);
+			}
+unlock_cache:
 			spin_unlock_irq(&cachep->spinlock);
 			kfree(nc);
 		}
@@ -740,6 +847,24 @@ bad:

 static struct notifier_block cpucache_notifier = { &cpuup_callback, NULL, 0 };

+/*
+ * swap the static kmem_list3 with kmalloced memory
+ */
+static void init_list(kmem_cache_t *cachep, struct kmem_list3 *list, int nodeid)
+{
+	struct kmem_list3 *ptr;
+
+	BUG_ON((cachep->nodelists[nodeid]) != list);
+	ptr = kmalloc_node(sizeof(struct kmem_list3), nodeid ,GFP_KERNEL);
+	BUG_ON(!ptr);
+
+	local_irq_disable();
+	memcpy(ptr, list, sizeof(struct kmem_list3));
+	MAKE_ALL_LISTS(cachep, ptr, nodeid);
+	cachep->nodelists[nodeid] = ptr;
+	local_irq_enable();
+}
+
 /* Initialisation.
  * Called after the gfp() functions have been enabled, and before smp_init().
  */
@@ -748,7 +873,15 @@ void __init kmem_cache_init(void)
 	size_t left_over;
 	struct cache_sizes *sizes;
 	struct cache_names *names;
+	int i;
+
+	for(i = 0; i < NUM_INIT_LISTS; i++)
+		LIST3_INIT(&initkmem_list3[i]);

+	for(i = 0; i < MAX_NUMNODES; i++) {
+		LIST3_INIT(&kmem64_list3[i]);
+		cache_cache.nodelists[i] = NULL;
+	}
 	/*
 	 * Fragmentation resistance on low memory - only use bigger
 	 * page orders on machines with more than 32MB of memory.
@@ -762,15 +895,18 @@ void __init kmem_cache_init(void)
 	 * 1) initialize the cache_cache cache: it contains the kmem_cache_t
 	 *    structures of all caches, except cache_cache itself: cache_cache
 	 *    is statically allocated.
-	 *    Initially an __init data area is used for the head array, it's
-	 *    replaced with a kmalloc allocated array at the end of the bootstrap.
+	 *    Initially an __init data area is used for the head array and the
+	 *    kmem_list3 structures, it's replaced with a kmalloc allocated array
+	 *    at the end of the bootstrap.
 	 * 2) Create the first kmalloc cache.
 	 *    The kmem_cache_t for the new cache is allocated normally. An __init
 	 *    data area is used for the head array.
 	 * 3) Create the remaining kmalloc caches, with minimally sized head arrays.
 	 * 4) Replace the __init data head arrays for cache_cache and the first
 	 *    kmalloc cache with kmalloc allocated arrays.
-	 * 5) Resize the head arrays of the kmalloc caches to their final sizes.
+	 * 5) Replace the __init data for kmem_list3 for cache_cache and the other cache's
+	 *    with kmalloc allocated memory.
+	 * 6) Resize the head arrays of the kmalloc caches to their final sizes.
 	 */

 	/* 1) create the cache_cache */
@@ -779,6 +915,7 @@ void __init kmem_cache_init(void)
 	list_add(&cache_cache.next, &cache_chain);
 	cache_cache.colour_off = cache_line_size();
 	cache_cache.array[smp_processor_id()] = &initarray_cache.cache;
+	cache_cache.nodelists[cpu_to_node(smp_processor_id())] = &initkmem_list3[CACHE_CACHE];

 	cache_cache.objsize = ALIGN(cache_cache.objsize, cache_line_size());

@@ -837,10 +974,28 @@ void __init kmem_cache_init(void)
 		memcpy(ptr, ac_data(malloc_sizes[0].cs_cachep),
 				sizeof(struct arraycache_init));
 		malloc_sizes[0].cs_cachep->array[smp_processor_id()] = ptr;
+	}
+	/* 5) Replace the bootstrap kmem_list3's */
+	{
+		int i, j;
+		for(i=0 ; malloc_sizes[i].cs_size && (malloc_sizes[i].cs_size < sizeof(struct kmem_list3)); i++);
+
+		BUG_ON(!malloc_sizes[i].cs_size);
+		/*Replace the static kmem_list3 structures for the boot cpu*/
+		init_list(&cache_cache, &initkmem_list3[CACHE_CACHE], numa_node_id());
+		if(i) {
+			init_list(malloc_sizes[0].cs_cachep, &initkmem_list3[SIZE_32], numa_node_id());
+			init_list(malloc_sizes[0].cs_dmacachep, &initkmem_list3[SIZE_DMA_32], numa_node_id());
+		}
+
+		for( j=0; j < MAX_NUMNODES; j++) {
+			if(is_node_online(j))
+				init_list(malloc_sizes[i].cs_cachep, &kmem64_list3[j], j);
+		}
 		local_irq_enable();
 	}

-	/* 5) resize the head arrays to their final sizes */
+	/* 6) resize the head arrays to their final sizes */
 	{
 		kmem_cache_t *cachep;
 		down(&cache_chain_sem);
@@ -1152,6 +1307,19 @@ static void slab_destroy (kmem_cache_t *
 	}
 }

+/* For setting up all the kmem_list3s for cache whose objsize is same as size of kmem_list3. */
+static inline void set_up_list3s(kmem_cache_t *cachep)
+{
+	int i;
+	for(i = 0; i < MAX_NUMNODES; i++) {
+		if(is_node_online(i)) {
+			cachep->nodelists[i] = &kmem64_list3[i];
+			cachep->nodelists[i]->next_reap = jiffies + REAPTIMEOUT_LIST3 +
+				((unsigned long)cachep)%REAPTIMEOUT_LIST3;
+		}
+	}
+}
+
 /**
  * kmem_cache_create - Create a cache.
  * @name: A string which is used in /proc/slabinfo to identify this cache.
@@ -1407,10 +1575,6 @@ next:
 		cachep->gfpflags |= GFP_DMA;
 	spin_lock_init(&cachep->spinlock);
 	cachep->objsize = size;
-	/* NUMA */
-	INIT_LIST_HEAD(&cachep->lists.slabs_full);
-	INIT_LIST_HEAD(&cachep->lists.slabs_partial);
-	INIT_LIST_HEAD(&cachep->lists.slabs_free);

 	if (flags & CFLGS_OFF_SLAB)
 		cachep->slabp_cache = kmem_find_general_cachep(slab_size,0);
@@ -1425,28 +1589,55 @@ next:
 		enable_cpucache(cachep);
 	} else {
 		if (g_cpucache_up == NONE) {
+			int i;
 			/* Note: the first kmem_cache_create must create
 			 * the cache that's used by kmalloc(24), otherwise
 			 * the creation of further caches will BUG().
 			 */
 			cachep->array[smp_processor_id()] = &initarray_generic.cache;
+
+			/* If the cache that's used by kmalloc(sizeof(kmem_list3))
+			 * is the first cache, then we need to set up all its list3s,
+			 * otherwise the creation of further caches will BUG().
+			 */
+			for(i=0 ; malloc_sizes[i].cs_size && (malloc_sizes[i].cs_size < sizeof(struct kmem_list3)); i++);
+			if(i == 0) {
+				set_up_list3s(cachep);
+				cpucache_up_64 = ALL;
+			}
+			else {
+				cachep->nodelists[numa_node_id()] = &initkmem_list3[SIZE_32];
+				cpucache_up_64 = SIZE_DMA_32;
+			}
+
 			g_cpucache_up = PARTIAL;
 		} else {
 			cachep->array[smp_processor_id()] = kmalloc(sizeof(struct arraycache_init),GFP_KERNEL);
+			if(cpucache_up_64 == SIZE_DMA_32) {
+				cachep->nodelists[numa_node_id()] = &initkmem_list3[SIZE_DMA_32];
+				cpucache_up_64 = SIZE_64;
+			}
+			else if(cpucache_up_64 == SIZE_64) {
+				set_up_list3s(cachep);
+				cpucache_up_64 = ALL;
+			}
+			else {
+				cachep->nodelists[numa_node_id()] = kmalloc(sizeof(struct kmem_list3),GFP_KERNEL);
+				LIST3_INIT(cachep->nodelists[numa_node_id()]);
+			}
 		}
+		cachep->nodelists[numa_node_id()]->next_reap = jiffies + REAPTIMEOUT_LIST3 +
+			((unsigned long)cachep)%REAPTIMEOUT_LIST3;
+
 		BUG_ON(!ac_data(cachep));
+		BUG_ON(!cachep->nodelists[numa_node_id()]);
 		ac_data(cachep)->avail = 0;
 		ac_data(cachep)->limit = BOOT_CPUCACHE_ENTRIES;
 		ac_data(cachep)->batchcount = 1;
 		ac_data(cachep)->touched = 0;
 		cachep->batchcount = 1;
 		cachep->limit = BOOT_CPUCACHE_ENTRIES;
-		cachep->free_limit = (1+num_online_cpus())*cachep->batchcount
-					+ cachep->num;
-	}
-
-	cachep->lists.next_reap = jiffies + REAPTIMEOUT_LIST3 +
-					((unsigned long)cachep)%REAPTIMEOUT_LIST3;
+	}

 	/* Need the semaphore to access the chain. */
 	down(&cache_chain_sem);
@@ -1504,13 +1695,23 @@ static void check_spinlock_acquired(kmem
 {
 #ifdef CONFIG_SMP
 	check_irq_off();
-	BUG_ON(spin_trylock(&cachep->spinlock));
+	BUG_ON(spin_trylock(&list3_data(cachep)->list_lock));
+#endif
+}
+
+static inline void check_spinlock_acquired_node(kmem_cache_t *cachep, int node)
+{
+#ifdef CONFIG_SMP
+	check_irq_off();
+	BUG_ON(spin_trylock(&(cachep->nodelists[node])->list_lock));
 #endif
 }
+
 #else
 #define check_irq_off()	do { } while(0)
 #define check_irq_on()	do { } while(0)
 #define check_spinlock_acquired(x) do { } while(0)
+#define check_spinlock_acquired_node(x, y) do { } while(0)
 #endif

 /*
@@ -1532,7 +1733,7 @@ static void smp_call_function_all_cpus(v
 }

 static void drain_array_locked(kmem_cache_t* cachep,
-				struct array_cache *ac, int force);
+				struct array_cache *ac, int force, int node);

 static void do_drain(void *arg)
 {
@@ -1541,56 +1742,76 @@ static void do_drain(void *arg)

 	check_irq_off();
 	ac = ac_data(cachep);
-	spin_lock(&cachep->spinlock);
+	spin_lock(&list3_data(cachep)->list_lock);
 	free_block(cachep, &ac_entry(ac)[0], ac->avail);
-	spin_unlock(&cachep->spinlock);
+	spin_unlock(&list3_data(cachep)->list_lock);
 	ac->avail = 0;
 }

 static void drain_cpu_caches(kmem_cache_t *cachep)
 {
+	struct kmem_list3 *l3;
+	int i;
+
 	smp_call_function_all_cpus(do_drain, cachep);
 	check_irq_on();
 	spin_lock_irq(&cachep->spinlock);
-	if (cachep->lists.shared)
-		drain_array_locked(cachep, cachep->lists.shared, 1);
+	for(i = 0; i < MAX_NUMNODES; i++)  {
+		l3 = cachep->nodelists[i];
+		if (l3) {
+			spin_lock(&l3->list_lock);
+			drain_array_locked(cachep, l3->shared, 1, i);
+			spin_unlock(&l3->list_lock);
+		}
+	}
 	spin_unlock_irq(&cachep->spinlock);
 }

-
-/* NUMA shrink all list3s */
-static int __cache_shrink(kmem_cache_t *cachep)
+/*
+ * NUMA shrink list3
+ * @nodeid : If -1 free all list3s, else free a particular nodes list3.
+ */
+static int __cache_shrink(kmem_cache_t *cachep, int nodeid)
 {
 	struct slab *slabp;
-	int ret;
-
-	drain_cpu_caches(cachep);
+	int ret = 0, i = 0;
+	struct kmem_list3 *l3;

 	check_irq_on();
-	spin_lock_irq(&cachep->spinlock);
+	if(nodeid == -1)
+		drain_cpu_caches(cachep);
+	else
+		i = nodeid;

-	for(;;) {
-		struct list_head *p;
+	do {
+		if(!is_node_online(i))
+			continue;
+		l3 = cachep->nodelists[i];
+		spin_lock_irq(&l3->list_lock);

-		p = cachep->lists.slabs_free.prev;
-		if (p == &cachep->lists.slabs_free)
-			break;
+		for(;;) {
+			struct list_head *p;
+
+			p = l3->slabs_free.prev;
+			if (p == &l3->slabs_free)
+				break;

-		slabp = list_entry(cachep->lists.slabs_free.prev, struct slab, list);
+			slabp = list_entry(l3->slabs_free.prev, struct slab, list);
 #if DEBUG
-		if (slabp->inuse)
-			BUG();
+			if (slabp->inuse)
+				BUG();
 #endif
-		list_del(&slabp->list);
+			list_del(&slabp->list);

-		cachep->lists.free_objects -= cachep->num;
-		spin_unlock_irq(&cachep->spinlock);
-		slab_destroy(cachep, slabp);
-		spin_lock_irq(&cachep->spinlock);
-	}
-	ret = !list_empty(&cachep->lists.slabs_full) ||
-		!list_empty(&cachep->lists.slabs_partial);
-	spin_unlock_irq(&cachep->spinlock);
+			l3->free_objects -= cachep->num;
+			spin_unlock_irq(&l3->list_lock);
+			slab_destroy(cachep, slabp);
+			spin_lock_irq(&l3->list_lock);
+		}
+
+		ret = ret || !list_empty(&l3->slabs_full) || !list_empty(&l3->slabs_partial);
+		spin_unlock_irq(&l3->list_lock);
+	}while(++i < MAX_NUMNODES && nodeid == -1);
 	return ret;
 }

@@ -1606,7 +1827,7 @@ int kmem_cache_shrink(kmem_cache_t *cach
 	if (!cachep || in_interrupt())
 		BUG();

-	return __cache_shrink(cachep);
+	return __cache_shrink(cachep, -1);
 }

 EXPORT_SYMBOL(kmem_cache_shrink);
@@ -1631,6 +1852,7 @@ EXPORT_SYMBOL(kmem_cache_shrink);
 int kmem_cache_destroy (kmem_cache_t * cachep)
 {
 	int i;
+	struct kmem_list3 *l3;

 	if (!cachep || in_interrupt())
 		BUG();
@@ -1646,7 +1868,7 @@ int kmem_cache_destroy (kmem_cache_t * c
 	list_del(&cachep->next);
 	up(&cache_chain_sem);

-	if (__cache_shrink(cachep)) {
+	if (__cache_shrink(cachep, -1)) {
 		slab_error(cachep, "Can't free all objects");
 		down(&cache_chain_sem);
 		list_add(&cachep->next,&cache_chain);
@@ -1665,8 +1887,12 @@ int kmem_cache_destroy (kmem_cache_t * c
 		kfree(cachep->array[i]);

 	/* NUMA: free the list3 structures */
-	kfree(cachep->lists.shared);
-	cachep->lists.shared = NULL;
+	for(i = 0; i < MAX_NUMNODES; i++) {
+		if((l3 = cachep->nodelists[i])) {
+			kfree(l3->shared);
+			kfree(l3);
+		}
+	}
 	kmem_cache_free(&cache_cache, cachep);

 	unlock_cpu_hotplug();
@@ -1782,10 +2008,11 @@ static void set_slab_attr(kmem_cache_t *
 static int cache_grow (kmem_cache_t * cachep, int flags, int nodeid)
 {
 	struct slab	*slabp;
-	void		*objp;
+	void		*objp = NULL;
 	size_t		 offset;
 	int		 local_flags;
 	unsigned long	 ctor_flags;
+	struct kmem_list3 *l3;

 	/* Be lazy and only check for valid flags here,
  	 * keeping it out of the critical path in kmem_cache_alloc().
@@ -1817,6 +2044,7 @@ static int cache_grow (kmem_cache_t * ca

 	spin_unlock(&cachep->spinlock);

+	check_irq_off();
 	if (local_flags & __GFP_WAIT)
 		local_irq_enable();

@@ -1829,7 +2057,9 @@ static int cache_grow (kmem_cache_t * ca
 	kmem_flagcheck(cachep, flags);


-	/* Get mem for the objs. */
+	/* Get mem for the objs.
+	 * Attmept to allocate a physical page from 'nodeid',
+	*/
 	if (!(objp = kmem_getpages(cachep, flags, nodeid)))
 		goto failed;

@@ -1837,6 +2067,8 @@ static int cache_grow (kmem_cache_t * ca
 	if (!(slabp = alloc_slabmgmt(cachep, objp, offset, local_flags)))
 		goto opps1;

+	slabp->nodeid = nodeid;
+
 	set_slab_attr(cachep, slabp, objp);

 	cache_init_objs(cachep, slabp, ctor_flags);
@@ -1844,13 +2076,14 @@ static int cache_grow (kmem_cache_t * ca
 	if (local_flags & __GFP_WAIT)
 		local_irq_disable();
 	check_irq_off();
-	spin_lock(&cachep->spinlock);
+	l3 = cachep->nodelists[nodeid];
+	spin_lock(&l3->list_lock);

 	/* Make slab active. */
-	list_add_tail(&slabp->list, &(list3_data(cachep)->slabs_free));
+	list_add_tail(&slabp->list, &(l3->slabs_free));
 	STATS_INC_GROWN(cachep);
-	list3_data(cachep)->free_objects += cachep->num;
-	spin_unlock(&cachep->spinlock);
+	l3->free_objects += cachep->num;
+	spin_unlock(&l3->list_lock);
 	return 1;
 opps1:
 	kmem_freepages(cachep, objp);
@@ -1955,7 +2188,6 @@ static void check_slabp(kmem_cache_t *ca
 	int i;
 	int entries = 0;

-	check_spinlock_acquired(cachep);
 	/* Check slab's freelist to see if this obj is there. */
 	for (i = slabp->free; i != BUFCTL_END; i = slab_bufctl(slabp)[i]) {
 		entries++;
@@ -2001,8 +2233,9 @@ retry:
 	}
 	l3 = list3_data(cachep);

-	BUG_ON(ac->avail > 0);
-	spin_lock(&cachep->spinlock);
+	BUG_ON(ac->avail > 0 || !l3);
+	spin_lock(&l3->list_lock);
+
 	if (l3->shared) {
 		struct array_cache *shared_array = l3->shared;
 		if (shared_array->avail) {
@@ -2060,11 +2293,11 @@ retry:
 must_grow:
 	l3->free_objects -= ac->avail;
 alloc_done:
-	spin_unlock(&cachep->spinlock);
+	spin_unlock(&l3->list_lock);

 	if (unlikely(!ac->avail)) {
 		int x;
-		x = cache_grow(cachep, flags, -1);
+		x = cache_grow(cachep, flags, numa_node_id());

 		// cache_grow can reenable interrupts, then ac could change.
 		ac = ac_data(cachep);
@@ -2157,29 +2390,96 @@ static inline void * __cache_alloc (kmem
 	return objp;
 }

-/*
- * NUMA: different approach needed if the spinlock is moved into
- * the l3 structure
+/*
+ * A interface to enable slab creation on nodeid
+ */
+static void *__cache_alloc_node(kmem_cache_t *cachep, int nodeid, int flags)
+{
+	struct list_head *entry;
+	struct slab *slabp;
+	struct kmem_list3 *l3;
+	void *obj;
+	kmem_bufctl_t next;
+	int x;
+
+	l3 = cachep->nodelists[nodeid];
+	BUG_ON(!l3);
+
+retry:
+	spin_lock(&l3->list_lock);
+	entry = l3->slabs_partial.next;
+	if (entry == &l3->slabs_partial) {
+		l3->free_touched = 1;
+		entry = l3->slabs_free.next;
+		if (entry == &l3->slabs_free)
+			goto must_grow;
+	}
+
+	slabp = list_entry(entry, struct slab, list);
+	check_spinlock_acquired_node(cachep, nodeid);
+	check_slabp(cachep, slabp);
+
+	STATS_INC_ALLOCED(cachep);
+	STATS_INC_ACTIVE(cachep);
+	STATS_SET_HIGH(cachep);
+
+	BUG_ON(slabp->inuse == cachep->num);
+
+	/* get obj pointer */
+	obj =  slabp->s_mem + slabp->free*cachep->objsize;
+	slabp->inuse++;
+	next = slab_bufctl(slabp)[slabp->free];
+#if DEBUG
+	slab_bufctl(slabp)[slabp->free] = BUFCTL_FREE;
+#endif
+	slabp->free = next;
+	check_slabp(cachep, slabp);
+	l3->free_objects--;
+	/* move slabp to correct slabp list: */
+	list_del(&slabp->list);
+
+	if (slabp->free == BUFCTL_END) {
+		list_add(&slabp->list, &l3->slabs_full);
+	}
+	else {
+		list_add(&slabp->list, &l3->slabs_partial);
+	}
+
+	spin_unlock(&l3->list_lock);
+	goto done;
+
+must_grow:
+	spin_unlock(&l3->list_lock);
+	x = cache_grow(cachep, flags, nodeid);
+
+	if (!x)
+		return NULL;
+
+	goto retry;
+done:
+	return obj;
+}
+/*
+ * Caller needs to acquire correct kmem_list's list_lock
  */

 static void free_block(kmem_cache_t *cachep, void **objpp, int nr_objects)
 {
 	int i;
-
-	check_spinlock_acquired(cachep);
-
-	/* NUMA: move add into loop */
-	cachep->lists.free_objects += nr_objects;
+	struct kmem_list3 *l3;
+	struct slab *slabp;

 	for (i = 0; i < nr_objects; i++) {
 		void *objp = objpp[i];
-		struct slab *slabp;
 		unsigned int objnr;

 		slabp = GET_PAGE_SLAB(virt_to_page(objp));
+		l3 = cachep->nodelists[slabp->nodeid];
 		list_del(&slabp->list);
 		objnr = (objp - slabp->s_mem) / cachep->objsize;
+		check_spinlock_acquired_node(cachep, slabp->nodeid);
 		check_slabp(cachep, slabp);
+
 #if DEBUG
 		if (slab_bufctl(slabp)[objnr] != BUFCTL_FREE) {
 			printk(KERN_ERR "slab: double free detected in cache '%s', objp %p.\n",
@@ -2191,16 +2491,17 @@ static void free_block(kmem_cache_t *cac
 		slabp->free = objnr;
 		STATS_DEC_ACTIVE(cachep);
 		slabp->inuse--;
+		l3->free_objects++;
 		check_slabp(cachep, slabp);

 		/* fixup slab chains */
 		if (slabp->inuse == 0) {
-			if (cachep->lists.free_objects > cachep->free_limit) {
-				cachep->lists.free_objects -= cachep->num;
+			if (l3->free_objects > l3->free_limit) {
+				l3->free_objects -= cachep->num;
 				slab_destroy(cachep, slabp);
 			} else {
 				list_add(&slabp->list,
-				&list3_data_ptr(cachep, objp)->slabs_free);
+				&l3->slabs_free);
 			}
 		} else {
 			/* Unconditionally move a slab to the end of the
@@ -2208,7 +2509,7 @@ static void free_block(kmem_cache_t *cac
 			 * other objects to be freed, too.
 			 */
 			list_add_tail(&slabp->list,
-				&list3_data_ptr(cachep, objp)->slabs_partial);
+				&l3->slabs_partial);
 		}
 	}
 }
@@ -2216,15 +2517,17 @@ static void free_block(kmem_cache_t *cac
 static void cache_flusharray (kmem_cache_t* cachep, struct array_cache *ac)
 {
 	int batchcount;
+	struct kmem_list3 *l3;

 	batchcount = ac->batchcount;
 #if DEBUG
 	BUG_ON(!batchcount || batchcount > ac->avail);
 #endif
 	check_irq_off();
-	spin_lock(&cachep->spinlock);
-	if (cachep->lists.shared) {
-		struct array_cache *shared_array = cachep->lists.shared;
+	l3 = list3_data(cachep);
+	spin_lock(&l3->list_lock);
+	if (l3->shared) {
+		struct array_cache *shared_array = l3->shared;
 		int max = shared_array->limit-shared_array->avail;
 		if (max) {
 			if (batchcount > max)
@@ -2244,8 +2547,8 @@ free_done:
 		int i = 0;
 		struct list_head *p;

-		p = list3_data(cachep)->slabs_free.next;
-		while (p != &(list3_data(cachep)->slabs_free)) {
+		p = l3->slabs_free.next;
+		while (p != &(l3->slabs_free)) {
 			struct slab *slabp;

 			slabp = list_entry(p, struct slab, list);
@@ -2257,12 +2560,13 @@ free_done:
 		STATS_SET_FREEABLE(cachep, i);
 	}
 #endif
-	spin_unlock(&cachep->spinlock);
+	spin_unlock(&l3->list_lock);
 	ac->avail -= batchcount;
 	memmove(&ac_entry(ac)[0], &ac_entry(ac)[batchcount],
 			sizeof(void*)*ac->avail);
 }

+
 /*
  * __cache_free
  * Release an obj back to its cache. If the obj has a constructed
@@ -2273,11 +2577,23 @@ free_done:
 static inline void __cache_free (kmem_cache_t *cachep, void* objp)
 {
 	struct array_cache *ac = ac_data(cachep);
+	struct slab *slabp;

 	check_irq_off();
 	objp = cache_free_debugcheck(cachep, objp, __builtin_return_address(0));

-	if (likely(ac->avail < ac->limit)) {
+	/* Make sure we are not freeing a object from another
+	 * node to the array cache on this cpu.
+	 */
+	slabp = GET_PAGE_SLAB(virt_to_page(objp));
+	if(unlikely(slabp->nodeid != numa_node_id())) {
+		STATS_INC_FREEMISS(cachep);
+		int nodeid = slabp->nodeid;
+		spin_lock(&(cachep->nodelists[nodeid])->list_lock);
+		free_block(cachep, &objp, 1);
+		spin_unlock(&(cachep->nodelists[nodeid])->list_lock);
+	}
+	else if (likely(ac->avail < ac->limit)) {
 		STATS_INC_FREEHIT(cachep);
 		ac_entry(ac)[ac->avail++] = objp;
 		return;
@@ -2355,78 +2671,24 @@ out:
  * Identical to kmem_cache_alloc, except that this function is slow
  * and can sleep. And it will allocate memory on the given node, which
  * can improve the performance for cpu bound structures.
+ * New and improved: it will now make sure that the object gets
+ * put on the correct node list so that there is no false sharing.
  */
-void *kmem_cache_alloc_node(kmem_cache_t *cachep, int nodeid)
+void *kmem_cache_alloc_node(kmem_cache_t *cachep, int nodeid, int flags)
 {
-	int loop;
-	void *objp;
-	struct slab *slabp;
-	kmem_bufctl_t next;
-
-	for (loop = 0;;loop++) {
-		struct list_head *q;
-
-		objp = NULL;
-		check_irq_on();
-		spin_lock_irq(&cachep->spinlock);
-		/* walk through all partial and empty slab and find one
-		 * from the right node */
-		list_for_each(q,&cachep->lists.slabs_partial) {
-			slabp = list_entry(q, struct slab, list);
-
-			if (page_to_nid(virt_to_page(slabp->s_mem)) == nodeid ||
-					loop > 2)
-				goto got_slabp;
-		}
-		list_for_each(q, &cachep->lists.slabs_free) {
-			slabp = list_entry(q, struct slab, list);
-
-			if (page_to_nid(virt_to_page(slabp->s_mem)) == nodeid ||
-					loop > 2)
-				goto got_slabp;
-		}
-		spin_unlock_irq(&cachep->spinlock);
-
-		local_irq_disable();
-		if (!cache_grow(cachep, GFP_KERNEL, nodeid)) {
-			local_irq_enable();
-			return NULL;
-		}
-		local_irq_enable();
-	}
-got_slabp:
-	/* found one: allocate object */
-	check_slabp(cachep, slabp);
-	check_spinlock_acquired(cachep);
-
-	STATS_INC_ALLOCED(cachep);
-	STATS_INC_ACTIVE(cachep);
-	STATS_SET_HIGH(cachep);
-	STATS_INC_NODEALLOCS(cachep);
-
-	objp = slabp->s_mem + slabp->free*cachep->objsize;
-
-	slabp->inuse++;
-	next = slab_bufctl(slabp)[slabp->free];
-#if DEBUG
-	slab_bufctl(slabp)[slabp->free] = BUFCTL_FREE;
-#endif
-	slabp->free = next;
-	check_slabp(cachep, slabp);
-
-	/* move slabp to correct slabp list: */
-	list_del(&slabp->list);
-	if (slabp->free == BUFCTL_END)
-		list_add(&slabp->list, &cachep->lists.slabs_full);
-	else
-		list_add(&slabp->list, &cachep->lists.slabs_partial);
+	unsigned long save_flags;
+	void *ptr;
+
+	if(nodeid == numa_node_id() || nodeid == -1)
+		return __cache_alloc(cachep, flags);

-	list3_data(cachep)->free_objects--;
-	spin_unlock_irq(&cachep->spinlock);
+	cache_alloc_debugcheck_before(cachep, flags);
+	local_irq_save(save_flags);
+	ptr = __cache_alloc_node(cachep, nodeid, flags);
+	local_irq_restore(save_flags);
+	ptr = cache_alloc_debugcheck_after(cachep, flags, ptr, __builtin_return_address(0));

-	objp = cache_alloc_debugcheck_after(cachep, GFP_KERNEL, objp,
-					__builtin_return_address(0));
-	return objp;
+	return ptr;
 }
 EXPORT_SYMBOL(kmem_cache_alloc_node);

@@ -2475,6 +2737,39 @@ void * __kmalloc (size_t size, int flags

 EXPORT_SYMBOL(__kmalloc);

+void * __kmalloc_node (size_t size, int nodeid, int flags)
+{
+	struct cache_sizes *csizep = malloc_sizes;
+	unsigned long save_flags;
+	kmem_cache_t *cachep;
+	void *ptr;
+
+	for (; csizep->cs_size; csizep++) {
+		if (size > csizep->cs_size)
+			continue;
+#if DEBUG
+		/* This happens if someone tries to call
+		 * kmem_cache_create(), or kmalloc(), before
+		 * the generic caches are initialized.
+		 */
+		BUG_ON(csizep->cs_cachep == NULL);
+#endif
+		cachep = flags & GFP_DMA ? csizep->cs_dmacachep : csizep->cs_cachep;
+		if(nodeid == numa_node_id() || nodeid == -1)
+			return __cache_alloc(cachep, flags);
+
+		cache_alloc_debugcheck_before(cachep, flags);
+		local_irq_save(save_flags);
+		ptr = __cache_alloc_node(cachep, nodeid, flags);
+		local_irq_restore(save_flags);
+		ptr = cache_alloc_debugcheck_after(cachep, flags, ptr, __builtin_return_address(0));
+		return ptr;
+	}
+	return NULL;
+}
+
+EXPORT_SYMBOL(__kmalloc_node);
+
 #ifdef CONFIG_SMP
 /**
  * __alloc_percpu - allocate one copy of the object for every present
@@ -2495,9 +2790,7 @@ void *__alloc_percpu(size_t size, size_t
 	for (i = 0; i < NR_CPUS; i++) {
 		if (!cpu_possible(i))
 			continue;
-		pdata->ptrs[i] = kmem_cache_alloc_node(
-				kmem_find_general_cachep(size, GFP_KERNEL),
-				cpu_to_node(i));
+		pdata->ptrs[i] = kmalloc_node(size, cpu_to_node(i), GFP_KERNEL);

 		if (!pdata->ptrs[i])
 			goto unwind_oom;
@@ -2615,6 +2908,52 @@ unsigned int kmem_cache_size(kmem_cache_

 EXPORT_SYMBOL(kmem_cache_size);

+/*
+ * This initializes kmem_list3 for all nodes.
+ */
+static int alloc_kmemlist(kmem_cache_t *cachep)
+{
+	int node, i;
+	struct kmem_list3 *l3;
+	int err = 0;
+
+	for(i=0; i < NR_CPUS; i++) {
+		if(cpu_online(i)) {
+			struct array_cache *nc = NULL, *new;
+			node = cpu_to_node(i);
+			if(!(new = alloc_arraycache(i, (cachep->shared*cachep->batchcount), 0xbaadf00d)))
+				goto fail;
+
+			if((l3 = cachep->nodelists[node])) {
+
+				spin_lock_irq(&l3->list_lock);
+
+				if((nc = cachep->nodelists[node]->shared))
+					free_block(cachep, ac_entry(nc), nc->avail);
+
+				l3->shared = new;
+				l3->free_limit = (1 + nr_cpus_node(node))*cachep->batchcount + cachep->num;
+
+				spin_unlock_irq(&l3->list_lock);
+				kfree(nc);
+				continue;
+			}
+			if(!(l3 = kmalloc_node(sizeof(struct kmem_list3), node, GFP_KERNEL)))
+				goto fail;
+
+			LIST3_INIT(l3);
+			l3->next_reap = jiffies + REAPTIMEOUT_LIST3 + ((unsigned long)cachep)%REAPTIMEOUT_LIST3;
+			l3->shared = new;
+			l3->free_limit = (1 + nr_cpus_node(node))*cachep->batchcount + cachep->num;
+			cachep->nodelists[node] = l3;
+		}
+	}
+	return err;
+fail:
+	err = -ENOMEM;
+	return err;
+}
+
 struct ccupdate_struct {
 	kmem_cache_t *cachep;
 	struct array_cache *new[NR_CPUS];
@@ -2636,8 +2975,7 @@ static void do_ccupdate_local(void *info
 static int do_tune_cpucache (kmem_cache_t* cachep, int limit, int batchcount, int shared)
 {
 	struct ccupdate_struct new;
-	struct array_cache *new_shared;
-	int i;
+	int i, err;

 	memset(&new.new,0,sizeof(new.new));
 	for (i = 0; i < NR_CPUS; i++) {
@@ -2659,31 +2997,25 @@ static int do_tune_cpucache (kmem_cache_
 	spin_lock_irq(&cachep->spinlock);
 	cachep->batchcount = batchcount;
 	cachep->limit = limit;
-	cachep->free_limit = (1+num_online_cpus())*cachep->batchcount + cachep->num;
+	cachep->shared = shared;
 	spin_unlock_irq(&cachep->spinlock);

 	for (i = 0; i < NR_CPUS; i++) {
 		struct array_cache *ccold = new.new[i];
 		if (!ccold)
 			continue;
-		spin_lock_irq(&cachep->spinlock);
+		spin_lock_irq(&cachep->nodelists[cpu_to_node(i)]->list_lock);
 		free_block(cachep, ac_entry(ccold), ccold->avail);
-		spin_unlock_irq(&cachep->spinlock);
+		spin_unlock_irq(&cachep->nodelists[cpu_to_node(i)]->list_lock);
 		kfree(ccold);
 	}
-	new_shared = alloc_arraycache(-1, batchcount*shared, 0xbaadf00d);
-	if (new_shared) {
-		struct array_cache *old;
-
-		spin_lock_irq(&cachep->spinlock);
-		old = cachep->lists.shared;
-		cachep->lists.shared = new_shared;
-		if (old)
-			free_block(cachep, ac_entry(old), old->avail);
-		spin_unlock_irq(&cachep->spinlock);
-		kfree(old);
-	}

+	err = alloc_kmemlist(cachep);
+	if (err) {
+		printk(KERN_ERR "alloc_kmemlist failed for %s, error %d.\n",
+				cachep->name, -err);
+		BUG();
+	}
 	return 0;
 }

@@ -2741,11 +3073,11 @@ static void enable_cpucache (kmem_cache_
 }

 static void drain_array_locked(kmem_cache_t *cachep,
-				struct array_cache *ac, int force)
+				struct array_cache *ac, int force, int node)
 {
 	int tofree;

-	check_spinlock_acquired(cachep);
+	check_spinlock_acquired_node(cachep, node);
 	if (ac->touched && !force) {
 		ac->touched = 0;
 	} else if (ac->avail) {
@@ -2774,6 +3106,7 @@ static void drain_array_locked(kmem_cach
 static void cache_reap(void *unused)
 {
 	struct list_head *walk;
+	struct kmem_list3 *l3;

 	if (down_trylock(&cache_chain_sem)) {
 		/* Give up. Setup the next iteration. */
@@ -2794,27 +3127,28 @@ static void cache_reap(void *unused)

 		check_irq_on();

-		spin_lock_irq(&searchp->spinlock);
+		l3 = list3_data(searchp);
+		spin_lock_irq(&l3->list_lock);

-		drain_array_locked(searchp, ac_data(searchp), 0);
+		drain_array_locked(searchp, ac_data(searchp), 0, numa_node_id());

-		if(time_after(searchp->lists.next_reap, jiffies))
+		if(time_after(l3->next_reap, jiffies))
 			goto next_unlock;

-		searchp->lists.next_reap = jiffies + REAPTIMEOUT_LIST3;
+		l3->next_reap = jiffies + REAPTIMEOUT_LIST3;

-		if (searchp->lists.shared)
-			drain_array_locked(searchp, searchp->lists.shared, 0);
+		if (l3->shared)
+			drain_array_locked(searchp, l3->shared, 0, numa_node_id());

-		if (searchp->lists.free_touched) {
-			searchp->lists.free_touched = 0;
+		if (l3->free_touched) {
+			l3->free_touched = 0;
 			goto next_unlock;
 		}

-		tofree = (searchp->free_limit+5*searchp->num-1)/(5*searchp->num);
+		tofree = (l3->free_limit+5*searchp->num-1)/(5*searchp->num);
 		do {
-			p = list3_data(searchp)->slabs_free.next;
-			if (p == &(list3_data(searchp)->slabs_free))
+			p = l3->slabs_free.next;
+			if (p == &(l3->slabs_free))
 				break;

 			slabp = list_entry(p, struct slab, list);
@@ -2827,13 +3161,13 @@ static void cache_reap(void *unused)
 			 * searchp cannot disappear, we hold
 			 * cache_chain_lock
 			 */
-			searchp->lists.free_objects -= searchp->num;
-			spin_unlock_irq(&searchp->spinlock);
+			l3->free_objects -= searchp->num;
+			spin_unlock_irq(&l3->list_lock);
 			slab_destroy(searchp, slabp);
-			spin_lock_irq(&searchp->spinlock);
+			spin_lock_irq(&l3->list_lock);
 		} while(--tofree > 0);
 next_unlock:
-		spin_unlock_irq(&searchp->spinlock);
+		spin_unlock_irq(&l3->list_lock);
 next:
 		cond_resched();
 	}
@@ -2901,39 +3235,53 @@ static int s_show(struct seq_file *m, vo
 	unsigned long	active_objs;
 	unsigned long	num_objs;
 	unsigned long	active_slabs = 0;
-	unsigned long	num_slabs;
-	const char *name;
+	unsigned long	num_slabs, free_objects = 0, shared_avail = 0;
+	const char *name;
 	char *error = NULL;
+	int i;
+	struct kmem_list3 *l3;

 	check_irq_on();
 	spin_lock_irq(&cachep->spinlock);
 	active_objs = 0;
 	num_slabs = 0;
-	list_for_each(q,&cachep->lists.slabs_full) {
-		slabp = list_entry(q, struct slab, list);
-		if (slabp->inuse != cachep->num && !error)
-			error = "slabs_full accounting error";
-		active_objs += cachep->num;
-		active_slabs++;
-	}
-	list_for_each(q,&cachep->lists.slabs_partial) {
-		slabp = list_entry(q, struct slab, list);
-		if (slabp->inuse == cachep->num && !error)
-			error = "slabs_partial inuse accounting error";
-		if (!slabp->inuse && !error)
-			error = "slabs_partial/inuse accounting error";
-		active_objs += slabp->inuse;
-		active_slabs++;
-	}
-	list_for_each(q,&cachep->lists.slabs_free) {
-		slabp = list_entry(q, struct slab, list);
-		if (slabp->inuse && !error)
-			error = "slabs_free/inuse accounting error";
-		num_slabs++;
+	for( i=0; i<MAX_NUMNODES; i++) {
+		l3 = cachep->nodelists[i];
+		if(!l3 || !is_node_online(i))
+			continue;
+
+		spin_lock(&l3->list_lock);
+
+		list_for_each(q,&l3->slabs_full) {
+			slabp = list_entry(q, struct slab, list);
+			if (slabp->inuse != cachep->num && !error)
+				error = "slabs_full accounting error";
+			active_objs += cachep->num;
+			active_slabs++;
+		}
+		list_for_each(q,&l3->slabs_partial) {
+			slabp = list_entry(q, struct slab, list);
+			if (slabp->inuse == cachep->num && !error)
+				error = "slabs_partial inuse accounting error";
+			if (!slabp->inuse && !error)
+				error = "slabs_partial/inuse accounting error";
+			active_objs += slabp->inuse;
+			active_slabs++;
+		}
+		list_for_each(q,&l3->slabs_free) {
+			slabp = list_entry(q, struct slab, list);
+			if (slabp->inuse && !error)
+				error = "slabs_free/inuse accounting error";
+			num_slabs++;
+		}
+		free_objects += l3->free_objects;
+		shared_avail += l3->shared->avail;
+
+		spin_unlock(&l3->list_lock);
 	}
 	num_slabs+=active_slabs;
 	num_objs = num_slabs*cachep->num;
-	if (num_objs - active_objs != cachep->lists.free_objects && !error)
+	if (num_objs - active_objs != free_objects && !error)
 		error = "free_objects accounting error";

 	name = cachep->name;
@@ -2945,9 +3293,9 @@ static int s_show(struct seq_file *m, vo
 		cachep->num, (1<<cachep->gfporder));
 	seq_printf(m, " : tunables %4u %4u %4u",
 			cachep->limit, cachep->batchcount,
-			cachep->lists.shared->limit/cachep->batchcount);
-	seq_printf(m, " : slabdata %6lu %6lu %6u",
-			active_slabs, num_slabs, cachep->lists.shared->avail);
+			cachep->shared);
+	seq_printf(m, " : slabdata %6lu %6lu %6lu",
+			active_slabs, num_slabs, shared_avail);
 #if STATS
 	{	/* list3 stats */
 		unsigned long high = cachep->high_mark;
@@ -2956,12 +3304,11 @@ static int s_show(struct seq_file *m, vo
 		unsigned long reaped = cachep->reaped;
 		unsigned long errors = cachep->errors;
 		unsigned long max_freeable = cachep->max_freeable;
-		unsigned long free_limit = cachep->free_limit;
 		unsigned long node_allocs = cachep->node_allocs;

-		seq_printf(m, " : globalstat %7lu %6lu %5lu %4lu %4lu %4lu %4lu %4lu",
+		seq_printf(m, " : globalstat %7lu %6lu %5lu %4lu %4lu %4lu %4lu",
 				allocs, high, grown, reaped, errors,
-				max_freeable, free_limit, node_allocs);
+				max_freeable, node_allocs);
 	}
 	/* cpu stats */
 	{
