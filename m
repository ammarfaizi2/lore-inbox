Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261678AbSKIRrN>; Sat, 9 Nov 2002 12:47:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262129AbSKIRrN>; Sat, 9 Nov 2002 12:47:13 -0500
Received: from dbl.q-ag.de ([80.146.160.66]:49823 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S261678AbSKIRqe>;
	Sat, 9 Nov 2002 12:46:34 -0500
Message-ID: <3DCD4B30.2090204@colorfullife.com>
Date: Sat, 09 Nov 2002 18:51:44 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020830
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net
Subject: [PATCH] numa slab, rediffed against 2.5.46
Content-Type: multipart/mixed;
 boundary="------------090700010801050401070407"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090700010801050401070407
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Attached is my numa aware slab allocator, rediffed against 2.5.46.
It makes the objects that are returned from kmem_cache_alloc strictly 
node local. Unfortunately this means that kmem_cache_free must return 
objects to the home node, which is expensive. (The return is batched, 
but it's still expensive)

I'm not sure that the patch will improve the performance - benchmarks 
are now needed.

TODO:
- implement ptr_to_nodeid() for all archs.The current implementation is 
a dummy, to test the code on non-NUMA systems.
- switch from MAX_NUMNODES to numnodes - Anton proposed that.
- improve the handling of nodes without cpus or without memory.
- add a kmem_cache_alloc_fromnode() function
- replace the kmem_list3 array with an array of pointers, and allocate 
the storage from the right node.
- allocate the head arrays from the node that is local to the cpu that 
accesses the head array.
- check for regressions - I was careful not to undo any cleanups that 
happened between 2.5.42 and 46, but it's possible that I missed some.

--
    Manfred

--------------090700010801050401070407
Content-Type: text/plain;
 name="patch-slab-numa"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-slab-numa"

--- 2.5/mm/slab.c	2002-11-09 00:45:37.000000000 +0100
+++ build-2.5/mm/slab.c	2002-11-09 15:25:05.000000000 +0100
@@ -10,6 +10,8 @@
  *
  * Cleanup, make the head arrays unconditional, preparation for NUMA
  * 	(c) 2002 Manfred Spraul
+ * Initial NUMA implementation
+ *      (c) 2002 Manfred Spraul
  *
  * An implementation of the Slab Allocator as described in outline in;
  *	UNIX Internals: The New Frontiers by Uresh Vahalia
@@ -85,6 +87,29 @@
 #include	<asm/uaccess.h>
 
 /*
+ * Enable the NUMA mode for slab
+ * This is a separate define from CONFIG_DISCONTIGMEM, because it only
+ * applies if ZONE_NORMAL allocations are possible on all zones.
+ * TODO:
+ * - move ptr_to_nodeid into include/asm-
+ * - make the cache structures themselves node local
+ * - is it possible to use the cpu alloc interface?
+ * - the behaviour is bad if get_free_pages returns returns
+ *   memory from the another node: 
+ *   The page is used just for one refill, then left on the
+ *   other node's partial list.
+ *   Is that acceptable?
+ * - determine the optimal placement for the chache spinlock:
+ *   node local or global?
+ * - which additional statistic counters would be interesting?
+ * - disable object return for the hopeless caches [journal head,
+ *   buffer head, dentry - we'll trash cachelines anyway]
+ */
+#define CONFIG_SLAB_NUMA
+#undef MAX_NUMNODES
+#define MAX_NUMNODES 4
+ 
+/*
  * DEBUG	- 1 for kmem_cache_create() to honour; SLAB_DEBUG_INITIAL,
  *		  SLAB_RED_ZONE & SLAB_POISON.
  *		  0 for faster, smaller code (especially in the critical paths).
@@ -174,6 +199,10 @@
  *
  * The limit is stored in the per-cpu structure to reduce the data cache
  * footprint.
+ * On NUMA systems, 2 per-cpu structures exist: one for the current
+ * node, one for wrong node free calls.
+ * Memory from the wrong node is never returned by alloc, it's returned
+ * to the home node as soon as the cpu cache is filled
  *
  */
 struct array_cache {
@@ -183,8 +212,17 @@
 	unsigned int touched;
 };
 
+struct cpucache_wrapper {
+	struct array_cache *native;
+#ifdef CONFIG_SLAB_NUMA
+	struct array_cache *alien;
+#endif
+};
 /* bootstrap: The caches do not work without cpuarrays anymore,
  * but the cpuarrays are allocated from the generic caches...
+ *
+ * sizeof(struct arraycache_init) must be <= the size of the first
+ * 	kmalloc general cache, otherwise the bootstrap will crash.
  */
 #define BOOT_CPUCACHE_ENTRIES	1
 struct arraycache_init {
@@ -206,20 +244,31 @@
 	unsigned long	free_objects;
 	int		free_touched;
 	unsigned long	next_reap;
+#if STATS
+	unsigned long		num_allocations;
+
+	unsigned long		grown;
+	unsigned long		high_mark;
+	unsigned long		num_active;
+#endif
 };
 
-#define LIST3_INIT(parent) \
-	{ \
-		.slabs_full	= LIST_HEAD_INIT(parent.slabs_full), \
-		.slabs_partial	= LIST_HEAD_INIT(parent.slabs_partial), \
-		.slabs_free	= LIST_HEAD_INIT(parent.slabs_free) \
-	}
-#define list3_data(cachep) \
-	(&(cachep)->lists)
+#if STATS
+#define	STATS_INC_GROWN(x)	((x)->grown++)
+#define	STATS_INC_ALLOCED(x)	((x)->num_allocations++)
+#define	STATS_INC_ACTIVE(x)	do { (x)->num_active++; \
+				     if ((x)->num_active > (x)->high_mark) \
+					(x)->high_mark = (x)->num_active; \
+				} while (0)
+#define	STATS_DEC_ACTIVE(x)	((x)->num_active--)
+#else
+#define	STATS_INC_GROWN(x)	do { } while (0)
+#define	STATS_INC_ALLOCED(x)	do { } while (0)
+#define	STATS_INC_ACTIVE(x)	do { } while (0)
 
-/* NUMA: per-node */
-#define list3_data_ptr(cachep, ptr) \
-		list3_data(cachep)
+#define	STATS_DEC_ACTIVE(x)	do { } while (0)
+
+#endif
 
 /*
  * kmem_cache_t
@@ -229,12 +278,11 @@
 	
 struct kmem_cache_s {
 /* 1) per-cpu data, touched during every alloc/free */
-	struct array_cache	*array[NR_CPUS];
+	struct cpucache_wrapper	cpudata[NR_CPUS];
 	unsigned int		batchcount;
 	unsigned int		limit;
 /* 2) touched by every alloc & free from the backend */
-	struct kmem_list3	lists;
-	/* NUMA: kmem_3list_t	*nodelists[NR_NODES] */
+	struct kmem_list3	lists[MAX_NUMNODES];	/* NUMA: pointers would be better */
 	unsigned int		objsize;
 	unsigned int	 	flags;	/* constant flags */
 	unsigned int		num;	/* # of objs per slab */
@@ -252,7 +300,6 @@
 	unsigned int		colour_off;	/* colour offset */
 	unsigned int		colour_next;	/* cache colouring */
 	kmem_cache_t		*slabp_cache;
-	unsigned int		dflags;		/* dynamic flags */
 
 	/* constructor func */
 	void (*ctor)(void *, kmem_cache_t *, unsigned long);
@@ -266,17 +313,15 @@
 
 /* 5) statistics */
 #if STATS
-	unsigned long		num_active;
-	unsigned long		num_allocations;
-	unsigned long		high_mark;
-	unsigned long		grown;
-	unsigned long		reaped;
-	unsigned long 		errors;
-	unsigned long		max_freeable;
-	atomic_t		allochit;
-	atomic_t		allocmiss;
-	atomic_t		freehit;
-	atomic_t		freemiss;
+	atomic_t	errors;
+
+	atomic_t	allochit[NR_CPUS];
+	atomic_t	allocmiss[NR_CPUS];
+	atomic_t	freehit[NR_CPUS];
+	atomic_t	freemiss[NR_CPUS];
+#ifdef CONFIG_SLAB_NUMA
+	atomic_t	foreign[NR_CPUS];
+#endif
 #endif
 };
 
@@ -296,39 +341,21 @@
 #define REAPTIMEOUT_LIST3	(4*HZ)
 
 #if STATS
-#define	STATS_INC_ACTIVE(x)	((x)->num_active++)
-#define	STATS_DEC_ACTIVE(x)	((x)->num_active--)
-#define	STATS_INC_ALLOCED(x)	((x)->num_allocations++)
-#define	STATS_INC_GROWN(x)	((x)->grown++)
-#define	STATS_INC_REAPED(x)	((x)->reaped++)
-#define	STATS_SET_HIGH(x)	do { if ((x)->num_active > (x)->high_mark) \
-					(x)->high_mark = (x)->num_active; \
-				} while (0)
-#define	STATS_INC_ERR(x)	((x)->errors++)
-#define	STATS_SET_FREEABLE(x, i) \
-				do { if ((x)->max_freeable < i) \
-					(x)->max_freeable = i; \
-				} while (0)
+#define	STATS_INC_ERR(x)	atomic_inc(&(x)->errors)
 
-#define STATS_INC_ALLOCHIT(x)	atomic_inc(&(x)->allochit)
-#define STATS_INC_ALLOCMISS(x)	atomic_inc(&(x)->allocmiss)
-#define STATS_INC_FREEHIT(x)	atomic_inc(&(x)->freehit)
-#define STATS_INC_FREEMISS(x)	atomic_inc(&(x)->freemiss)
+#define STATS_INC_ALLOCHIT(x)	atomic_inc(&(x)->allochit[smp_processor_id()])
+#define STATS_INC_ALLOCMISS(x)	atomic_inc(&(x)->allocmiss[smp_processor_id()])
+#define STATS_INC_FREEHIT(x)	atomic_inc(&(x)->freehit[smp_processor_id()])
+#define STATS_INC_FREEMISS(x)	atomic_inc(&(x)->freemiss[smp_processor_id()])
+#define STATS_INC_FOREIGN(x)	atomic_inc(&(x)->foreign[smp_processor_id()])
 #else
-#define	STATS_INC_ACTIVE(x)	do { } while (0)
-#define	STATS_DEC_ACTIVE(x)	do { } while (0)
-#define	STATS_INC_ALLOCED(x)	do { } while (0)
-#define	STATS_INC_GROWN(x)	do { } while (0)
-#define	STATS_INC_REAPED(x)	do { } while (0)
-#define	STATS_SET_HIGH(x)	do { } while (0)
-#define	STATS_INC_ERR(x)	do { } while (0)
-#define	STATS_SET_FREEABLE(x, i) \
-				do { } while (0)
+#define STATS_INC_ERR(x)	do { } while (0)
 
 #define STATS_INC_ALLOCHIT(x)	do { } while (0)
 #define STATS_INC_ALLOCMISS(x)	do { } while (0)
 #define STATS_INC_FREEHIT(x)	do { } while (0)
 #define STATS_INC_FREEMISS(x)	do { } while (0)
+#define STATS_INC_FOREIGN(x)	do { } while (0)	
 #endif
 
 #if DEBUG
@@ -436,8 +463,6 @@
 
 /* internal cache of cache description objs */
 static kmem_cache_t cache_cache = {
-	.lists		= LIST3_INIT(cache_cache.lists),
-	.array		= { [0] = &initarray_cache.cache },
 	.batchcount	= 1,
 	.limit		= BOOT_CPUCACHE_ENTRIES,
 	.objsize	= sizeof(kmem_cache_t),
@@ -514,6 +539,23 @@
 	}
 }
 
+static struct array_cache *alloc_acdata(int limit, int batchcount)
+{
+	int memsize;
+	struct array_cache *nc;
+
+	memsize = sizeof(void*)*limit+sizeof(struct array_cache);
+	nc = kmalloc(memsize, GFP_KERNEL);
+	if (!nc)
+		return NULL;
+	nc->avail = 0;
+	nc->limit = limit;
+	nc->batchcount = batchcount;
+	nc->touched = 0;
+
+	return nc;
+}
+
 /*
  * Note: if someone calls kmem_cache_alloc() on the new
  * cpu before the cpuup callback had a chance to allocate
@@ -531,25 +573,27 @@
 	case CPU_UP_PREPARE:
 		down(&cache_chain_sem);
 		list_for_each(p, &cache_chain) {
-			int memsize;
 			struct array_cache *nc;
 
 			kmem_cache_t* cachep = list_entry(p, kmem_cache_t, next);
-			memsize = sizeof(void*)*cachep->limit+sizeof(struct array_cache);
-			nc = kmalloc(memsize, GFP_KERNEL);
+			nc = alloc_acdata(cachep->limit, cachep->batchcount);
 			if (!nc)
 				goto bad;
-			nc->avail = 0;
-			nc->limit = cachep->limit;
-			nc->batchcount = cachep->batchcount;
-			nc->touched = 0;
 
 			spin_lock_irq(&cachep->spinlock);
-			cachep->array[cpu] = nc;
+			cachep->cpudata[cpu].native = nc;
 			cachep->free_limit = (1+num_online_cpus())*cachep->batchcount
 						+ cachep->num;
 			spin_unlock_irq(&cachep->spinlock);
+#ifdef CONFIG_SLAB_NUMA
+			nc = alloc_acdata(cachep->limit, cachep->limit);
+			if (!nc)
+				goto bad;
 
+			spin_lock_irq(&cachep->spinlock);
+			cachep->cpudata[cpu].alien = nc;
+			spin_unlock_irq(&cachep->spinlock);
+#endif
 		}
 		up(&cache_chain_sem);
 		break;
@@ -564,9 +608,14 @@
 			struct array_cache *nc;
 			kmem_cache_t* cachep = list_entry(p, kmem_cache_t, next);
 
-			nc = cachep->array[cpu];
-			cachep->array[cpu] = NULL;
+			nc = cachep->cpudata[cpu].native;
+			cachep->cpudata[cpu].native = NULL;
 			kfree(nc);
+#ifdef CONFIG_SLAB_NUMA
+			nc = cachep->cpudata[cpu].alien;
+			cachep->cpudata[cpu].alien = NULL;
+			kfree(nc);
+#endif
 		}
 		up(&cache_chain_sem);
 		break;
@@ -584,20 +633,74 @@
 	return (void**)(ac+1);
 }
 
-static inline struct array_cache *ac_data(kmem_cache_t *cachep)
+/*
+ * Helper functions/macros to access the per-cpu
+ * and per-node structures
+ */
+
+#define ac_data(cachep) \
+	((cachep)->cpudata[smp_processor_id()].native)
+
+#define list3_data(cachep) \
+	(&(cachep)->lists[__cpu_to_node(smp_processor_id())])
+
+#ifdef CONFIG_SLAB_NUMA
+/*
+ * NUMA: check where ptr points, and select the appropriate storage
+ * 	for the object.
+ */
+/* FIXME - this function must be somewhere in include/asm- */
+static inline int ptr_to_node(void *obj)
 {
-	return cachep->array[smp_processor_id()];
+	return (((unsigned long)obj)/4/1024/1024)%MAX_NUMNODES;
 }
 
+static inline struct array_cache * ac_data_ptr(kmem_cache_t *cachep, void *objp)
+{
+	if (ptr_to_node(objp) == __cpu_to_node(smp_processor_id()))
+		return cachep->cpudata[smp_processor_id()].native;
+	STATS_INC_FOREIGN(cachep);
+	return cachep->cpudata[smp_processor_id()].alien;
+}
+#define DEFINE_NUMALIST_PTR(x)	\
+	struct kmem_list3 *x
+
+#define set_numalist_ptr(x, cachep, objp) \
+		do { x = &cachep->lists[ptr_to_node(objp)]; } while(0)
+#define set_numalist_cur(x, cachep) \
+		do { x = &cachep->lists[__cpu_to_node(smp_processor_id())]; } while(0)
+#define access_numalist_ptr(cachep, x) \
+		(x)
+
+#else
+
+#define ac_data_ptr(cachep, ptr)	 ac_data(cachep)
+
+#define DEFINE_NUMALIST_PTR(x)	
+#define set_numalist_ptr(x, cachep, objp)	do { } while(0)
+#define set_numalist_cur(x, cachep)	 	do { } while(0)
+
+#define access_numalist_ptr(cachep, x)	 	(&(cachep->lists[0]))
+
+#endif
+
 /* Initialisation - setup the `cache' cache. */
 void __init kmem_cache_init(void)
 {
 	size_t left_over;
+	int i;
 
 	init_MUTEX(&cache_chain_sem);
 	INIT_LIST_HEAD(&cache_chain);
 	list_add(&cache_cache.next, &cache_chain);
 
+	for (i=0;i<MAX_NUMNODES;i++) {
+		INIT_LIST_HEAD(&cache_cache.lists[i].slabs_full);
+		INIT_LIST_HEAD(&cache_cache.lists[i].slabs_partial);
+		INIT_LIST_HEAD(&cache_cache.lists[i].slabs_free);
+	}
+	ac_data(&cache_cache) = &initarray_cache.cache;
+
 	cache_estimate(0, cache_cache.objsize, 0,
 			&left_over, &cache_cache.num);
 	if (!cache_cache.num)
@@ -657,20 +760,33 @@
 	 */
 	{
 		void * ptr;
+#ifdef CONFIG_SLAB_NUMA
+		void * ptr2;
+#endif
 		
-		ptr = kmalloc(sizeof(struct arraycache_init), GFP_KERNEL);
+		ptr = alloc_acdata(1, 1);
+#ifdef CONFIG_SLAB_NUMA
+		ptr2 = alloc_acdata(1, 1);
+#endif
 		local_irq_disable();
-		BUG_ON(ac_data(&cache_cache) != &initarray_cache.cache);
-		memcpy(ptr, ac_data(&cache_cache), sizeof(struct arraycache_init));
-		cache_cache.array[smp_processor_id()] = ptr;
+		BUG_ON(cache_cache.cpudata[smp_processor_id()].native != &initarray_cache.cache);
+		cache_cache.cpudata[smp_processor_id()].native = ptr;
+#ifdef CONFIG_SLAB_NUMA
+		cache_cache.cpudata[smp_processor_id()].alien = ptr2;
+#endif
 		local_irq_enable();
 	
-		ptr = kmalloc(sizeof(struct arraycache_init), GFP_KERNEL);
+		ptr = alloc_acdata(1, 1);
+#ifdef CONFIG_SLAB_NUMA
+		ptr2 = alloc_acdata(1, 1);
+#endif
 		local_irq_disable();
-		BUG_ON(ac_data(malloc_sizes[0].cs_cachep) != &initarray_generic.cache);
-		memcpy(ptr, ac_data(malloc_sizes[0].cs_cachep),
-				sizeof(struct arraycache_init));
-		malloc_sizes[0].cs_cachep->array[smp_processor_id()] = ptr;
+		BUG_ON(malloc_sizes[0].cs_cachep->cpudata[smp_processor_id()].native !=
+				&initarray_generic.cache);
+		malloc_sizes[0].cs_cachep->cpudata[smp_processor_id()].native = ptr;
+#ifdef CONFIG_SLAB_NUMA
+		malloc_sizes[0].cs_cachep->cpudata[smp_processor_id()].alien = ptr2;
+#endif
 		local_irq_enable();
 	}
 }
@@ -850,6 +966,7 @@
 	const char *func_nm = KERN_ERR "kmem_create: ";
 	size_t left_over, align, slab_size;
 	kmem_cache_t *cachep = NULL;
+	int i;
 
 	/*
 	 * Sanity checks... these are all serious usage bugs.
@@ -1000,10 +1117,11 @@
 		cachep->gfpflags |= GFP_DMA;
 	spin_lock_init(&cachep->spinlock);
 	cachep->objsize = size;
-	/* NUMA */
-	INIT_LIST_HEAD(&cachep->lists.slabs_full);
-	INIT_LIST_HEAD(&cachep->lists.slabs_partial);
-	INIT_LIST_HEAD(&cachep->lists.slabs_free);
+	for (i=0;i<MAX_NUMNODES;i++) {
+		INIT_LIST_HEAD(&cachep->lists[i].slabs_full);
+		INIT_LIST_HEAD(&cachep->lists[i].slabs_partial);
+		INIT_LIST_HEAD(&cachep->lists[i].slabs_free);
+	}
 
 	if (flags & CFLGS_OFF_SLAB)
 		cachep->slabp_cache = kmem_find_general_cachep(slab_size,0);
@@ -1019,24 +1137,26 @@
 			 * the cache that's used by kmalloc(24), otherwise
 			 * the creation of further caches will BUG().
 			 */
-			cachep->array[smp_processor_id()] = &initarray_generic.cache;
+			ac_data(cachep) = &initarray_generic.cache;
 			g_cpucache_up = PARTIAL;
 		} else {
-			cachep->array[smp_processor_id()] = kmalloc(sizeof(struct arraycache_init),GFP_KERNEL);
+			ac_data(cachep) = alloc_acdata(1,1);
+#ifdef CONFIG_SLAB_NUMA
+			cachep->cpudata[smp_processor_id()].alien =
+					alloc_acdata(1,1);
+#endif
 		}
-		BUG_ON(!ac_data(cachep));
-		ac_data(cachep)->avail = 0;
-		ac_data(cachep)->limit = BOOT_CPUCACHE_ENTRIES;
-		ac_data(cachep)->batchcount = 1;
-		ac_data(cachep)->touched = 0;
 		cachep->batchcount = 1;
 		cachep->limit = BOOT_CPUCACHE_ENTRIES;
 		cachep->free_limit = (1+num_online_cpus())*cachep->batchcount
 					+ cachep->num;
 	} 
 
-	cachep->lists.next_reap = jiffies + REAPTIMEOUT_LIST3 +
-					((unsigned long)cachep)%REAPTIMEOUT_LIST3;
+	for (i=0;i< MAX_NUMNODES;i++) {
+		cachep->lists[i].next_reap = jiffies + REAPTIMEOUT_LIST3 +
+					((unsigned long)cachep)%REAPTIMEOUT_LIST3 +
+					i*HZ/10;
+	}
 
 	/* Need the semaphore to access the chain. */
 	down(&cache_chain_sem);
@@ -1128,38 +1248,41 @@
 }
 
 
-/* NUMA shrink all list3s */
 static int __cache_shrink(kmem_cache_t *cachep)
 {
 	struct slab *slabp;
 	int ret;
+	int i;
 
 	drain_cpu_caches(cachep);
 
 	check_irq_on();
 	spin_lock_irq(&cachep->spinlock);
 
-	for(;;) {
-		struct list_head *p;
+	ret = 0;
+	for (i=0;i<MAX_NUMNODES;i++) {
+		for(;;) {
+			struct list_head *p;
 
-		p = cachep->lists.slabs_free.prev;
-		if (p == &cachep->lists.slabs_free)
-			break;
+			p = cachep->lists[i].slabs_free.prev;
+			if (p == &cachep->lists[i].slabs_free)
+				break;
 
-		slabp = list_entry(cachep->lists.slabs_free.prev, struct slab, list);
+			slabp = list_entry(cachep->lists[i].slabs_free.prev, struct slab, list);
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
+			cachep->lists[i].free_objects -= cachep->num;
+			spin_unlock_irq(&cachep->spinlock);
+			slab_destroy(cachep, slabp);
+			spin_lock_irq(&cachep->spinlock);
+		}
+		ret |= !list_empty(&cachep->lists[i].slabs_full);
+		ret |= !list_empty(&cachep->lists[i].slabs_partial);
 	}
-	ret = !list_empty(&cachep->lists.slabs_full) ||
-		!list_empty(&cachep->lists.slabs_partial);
 	spin_unlock_irq(&cachep->spinlock);
 	return ret;
 }
@@ -1217,9 +1340,12 @@
 	}
 	{
 		int i;
-		for (i = 0; i < NR_CPUS; i++)
-			kfree(cachep->array[i]);
-		/* NUMA: free the list3 structures */
+		for (i = 0; i < NR_CPUS; i++) {
+			kfree(cachep->cpudata[i].native);
+#ifdef CONFIG_SLAB_NUMA
+			kfree(cachep->cpudata[i].alien);
+#endif
+		}
 	}
 	kmem_cache_free(&cache_cache, cachep);
 
@@ -1316,7 +1442,7 @@
  * Grow (by 1) the number of slabs within a cache.  This is called by
  * kmem_cache_alloc() when there are no active objs left in a cache.
  */
-static int cache_grow (kmem_cache_t * cachep, int flags)
+static struct kmem_list3 *cache_grow (kmem_cache_t * cachep, int flags)
 {
 	struct slab	*slabp;
 	struct page	*page;
@@ -1324,6 +1450,7 @@
 	size_t		 offset;
 	unsigned int	 i, local_flags;
 	unsigned long	 ctor_flags;
+	DEFINE_NUMALIST_PTR(l3);
 
 	/* Be lazy and only check for valid flags here,
  	 * keeping it out of the critical path in kmem_cache_alloc().
@@ -1394,15 +1521,17 @@
 	spin_lock(&cachep->spinlock);
 
 	/* Make slab active. */
-	list_add_tail(&slabp->list, &(list3_data(cachep)->slabs_free));
-	STATS_INC_GROWN(cachep);
-	list3_data(cachep)->free_objects += cachep->num;
+	set_numalist_ptr(l3, cachep, slabp->s_mem);
+	list_add_tail(&slabp->list, &(access_numalist_ptr(cachep, l3)->slabs_free));
+	STATS_INC_GROWN(access_numalist_ptr(cachep, l3));
+	access_numalist_ptr(cachep, l3)->free_objects += cachep->num;
 	spin_unlock(&cachep->spinlock);
-	return 1;
+	return access_numalist_ptr(cachep, l3);
 opps1:
 	kmem_freepages(cachep, objp);
 failed:
-	return 0;
+	STATS_INC_ERR(cachep);
+	return NULL;
 }
 
 /*
@@ -1502,25 +1631,6 @@
 #endif
 }
 
-static inline void * cache_alloc_one_tail (kmem_cache_t *cachep,
-						struct slab *slabp)
-{
-	void *objp;
-
-	check_spinlock_acquired(cachep);
-
-	STATS_INC_ALLOCED(cachep);
-	STATS_INC_ACTIVE(cachep);
-	STATS_SET_HIGH(cachep);
-
-	/* get obj pointer */
-	slabp->inuse++;
-	objp = slabp->s_mem + slabp->free*cachep->objsize;
-	slabp->free=slab_bufctl(slabp)[slabp->free];
-
-	return objp;
-}
-
 static inline void cache_alloc_listfixup(struct kmem_list3 *l3, struct slab *slabp)
 {
 	list_del(&slabp->list);
@@ -1539,6 +1649,7 @@
 
 	check_irq_off();
 	ac = ac_data(cachep);
+	l3 = list3_data(cachep);
 retry:
 	batchcount = ac->batchcount;
 	if (!ac->touched && batchcount > BATCHREFILL_LIMIT) {
@@ -1548,7 +1659,6 @@
 		 */
 		batchcount = BATCHREFILL_LIMIT;
 	}
-	l3 = list3_data(cachep);
 
 	BUG_ON(ac->avail > 0);
 	spin_lock(&cachep->spinlock);
@@ -1566,9 +1676,16 @@
 
 		slabp = list_entry(entry, struct slab, list);
 		check_slabp(cachep, slabp);
-		while (slabp->inuse < cachep->num && batchcount--)
+		while (slabp->inuse < cachep->num && batchcount--) {
+			STATS_INC_ALLOCED(l3);
+			STATS_INC_ACTIVE(l3);
+
+			slabp->inuse++;
+			/* get obj pointer */
 			ac_entry(ac)[ac->avail++] =
-				cache_alloc_one_tail(cachep, slabp);
+					slabp->s_mem + slabp->free*cachep->objsize;
+			slabp->free=slab_bufctl(slabp)[slabp->free];
+		}
 		check_slabp(cachep, slabp);
 		cache_alloc_listfixup(l3, slabp);
 	}
@@ -1578,12 +1695,11 @@
 	spin_unlock(&cachep->spinlock);
 
 	if (unlikely(!ac->avail)) {
-		int x;
-		x = cache_grow(cachep, flags);
+		l3 = cache_grow(cachep, flags);
 		
 		// cache_grow can reenable interrupts, then ac could change.
 		ac = ac_data(cachep);
-		if (!x && ac->avail == 0)	// no objects in sight? abort
+		if (!l3 && ac->avail == 0)	// no objects in sight? abort
 			return NULL;
 
 		if (!ac->avail)		// objects refilled by interrupt?
@@ -1654,51 +1770,48 @@
 	return objp;
 }
 
-/* 
- * NUMA: different approach needed if the spinlock is moved into
- * the l3 structure
- */
-
-static inline void
-__free_block(kmem_cache_t *cachep, void **objpp, int nr_objects)
+static inline void __free_block (kmem_cache_t* cachep, void** objpp, int len)
 {
-	int i;
-
 	check_irq_off();
 	spin_lock(&cachep->spinlock);
+#ifndef CONFIG_SLAB_NUMA
+	cachep->lists[0].free_objects += len;
+#endif
 
-	/* NUMA: move add into loop */
-	cachep->lists.free_objects += nr_objects;
-
-	for (i = 0; i < nr_objects; i++) {
-		void *objp = objpp[i];
-		struct slab *slabp;
-		unsigned int objnr;
+	for ( ; len > 0; len--, objpp++) {
+		struct slab* slabp;
+		void *objp = *objpp;
+		DEFINE_NUMALIST_PTR(l3);
 
 		slabp = GET_PAGE_SLAB(virt_to_page(objp));
 		list_del(&slabp->list);
-		objnr = (objp - slabp->s_mem) / cachep->objsize;
-		slab_bufctl(slabp)[objnr] = slabp->free;
-		slabp->free = objnr;
-		STATS_DEC_ACTIVE(cachep);
-		slabp->inuse--;
+		{
+			unsigned int objnr = (objp-slabp->s_mem)/cachep->objsize;
 
+			slab_bufctl(slabp)[objnr] = slabp->free;
+			slabp->free = objnr;
+		}
+	
+		set_numalist_ptr(l3, cachep, objp);
+		STATS_DEC_ACTIVE(access_numalist_ptr(cachep, l3));
+#ifdef CONFIG_SLAB_NUMA
+		l3->free_objects++;
+#endif
 		/* fixup slab chains */
-		if (slabp->inuse == 0) {
-			if (cachep->lists.free_objects > cachep->free_limit) {
-				cachep->lists.free_objects -= cachep->num;
+		if (unlikely(!--slabp->inuse)) {
+			if (access_numalist_ptr(cachep, l3)->free_objects > cachep->free_limit) {
+				access_numalist_ptr(cachep, l3)->free_objects -= cachep->num;
 				slab_destroy(cachep, slabp);
 			} else {
 				list_add(&slabp->list,
-				&list3_data_ptr(cachep, objp)->slabs_free);
+						&(access_numalist_ptr(cachep, l3)->slabs_free));
 			}
 		} else {
 			/* Unconditionally move a slab to the end of the
 			 * partial list on free - maximum time for the
 			 * other objects to be freed, too.
 			 */
-			list_add_tail(&slabp->list,
-				&list3_data_ptr(cachep, objp)->slabs_partial);
+			list_add_tail(&slabp->list, &(access_numalist_ptr(cachep, l3)->slabs_partial));
 		}
 	}
 	spin_unlock(&cachep->spinlock);
@@ -1720,26 +1833,6 @@
 	check_irq_off();
 	__free_block(cachep, &ac_entry(ac)[0], batchcount);
 
-#if STATS
-	{
-		int i = 0;
-		struct list_head *p;
-
-		spin_lock(&cachep->spinlock);
-		p = list3_data(cachep)->slabs_free.next;
-		while (p != &(list3_data(cachep)->slabs_free)) {
-			struct slab *slabp;
-
-			slabp = list_entry(p, struct slab, list);
-			BUG_ON(slabp->inuse);
-
-			i++;
-			p = p->next;
-		}
-		STATS_SET_FREEABLE(cachep, i);
-		spin_unlock(&cachep->spinlock);
-	}
-#endif
 	ac->avail -= batchcount;
 	memmove(&ac_entry(ac)[0], &ac_entry(ac)[batchcount],
 			sizeof(void*)*ac->avail);
@@ -1754,7 +1847,7 @@
  */
 static inline void __cache_free (kmem_cache_t *cachep, void* objp)
 {
-	struct array_cache *ac = ac_data(cachep);
+	struct array_cache *ac = ac_data_ptr(cachep, objp);
 
 	check_irq_off();
 	objp = cache_free_debugcheck(cachep, objp);
@@ -1890,6 +1983,9 @@
 struct ccupdate_struct {
 	kmem_cache_t *cachep;
 	struct array_cache *new[NR_CPUS];
+#ifdef CONFIG_SLAB_NUMA
+	struct array_cache *new_alien[NR_CPUS];
+#endif
 };
 
 static void do_ccupdate_local(void *info)
@@ -1898,10 +1994,15 @@
 	struct array_cache *old;
 
 	check_irq_off();
-	old = ac_data(new->cachep);
-	
-	new->cachep->array[smp_processor_id()] = new->new[smp_processor_id()];
+	old = new->cachep->cpudata[smp_processor_id()].native;
+	new->cachep->cpudata[smp_processor_id()].native = new->new[smp_processor_id()];
 	new->new[smp_processor_id()] = old;
+
+#ifdef CONFIG_SLAB_NUMA
+	old = new->cachep->cpudata[smp_processor_id()].alien;
+	new->cachep->cpudata[smp_processor_id()].alien = new->new_alien[smp_processor_id()];
+	new->new_alien[smp_processor_id()] = old;
+#endif
 }
 
 
@@ -1909,22 +2010,22 @@
 {
 	struct ccupdate_struct new;
 	int i;
+	int ret;
 
 	memset(&new.new,0,sizeof(new.new));
 	for (i = 0; i < NR_CPUS; i++) {
-		struct array_cache *ccnew;
-
-		ccnew = kmalloc(sizeof(void*)*limit+
-				sizeof(struct array_cache), GFP_KERNEL);
-		if (!ccnew) {
-			for (i--; i >= 0; i--) kfree(new.new[i]);
-			return -ENOMEM;
-		}
-		ccnew->avail = 0;
-		ccnew->limit = limit;
-		ccnew->batchcount = batchcount;
-		ccnew->touched = 0;
-		new.new[i] = ccnew;
+		new.new[i] = alloc_acdata(limit, batchcount);
+		if (!new.new[i]) {
+			ret = -ENOMEM;
+			goto out;
+		}
+#ifdef CONFIG_SLAB_NUMA
+		new.new_alien[i] = alloc_acdata(limit, limit);
+		if (!new.new_alien[i]) {
+			ret = -ENOMEM;
+			goto out;
+		}
+#endif
 	}
 	new.cachep = cachep;
 
@@ -1936,17 +2037,30 @@
 	cachep->limit = limit;
 	cachep->free_limit = (1+num_online_cpus())*cachep->batchcount + cachep->num;
 	spin_unlock_irq(&cachep->spinlock);
-
+	
+	ret = 0;
+out:
 	for (i = 0; i < NR_CPUS; i++) {
-		struct array_cache *ccold = new.new[i];
-		if (!ccold)
-			continue;
-		local_irq_disable();
-		free_block(cachep, ac_entry(ccold), ccold->avail);
-		local_irq_enable();
-		kfree(ccold);
+		struct array_cache* ccold;
+		
+		ccold = new.new[i];
+		if (ccold) {
+			local_irq_disable();
+			free_block(cachep, ac_entry(ccold), ccold->avail);
+			local_irq_enable();
+			kfree(ccold);
+		}
+#ifdef CONFIG_SLAB_NUMA
+		ccold = new.new_alien[i];
+		if (ccold) {
+			local_irq_disable();
+			free_block(cachep, ac_entry(ccold), ccold->avail);
+			local_irq_enable();
+			kfree(ccold);
+		}
+#endif
 	}
-	return 0;
+	return ret;
 }
 
 
@@ -1998,6 +2112,7 @@
 		int tofree;
 		struct array_cache *ac;
 		struct slab *slabp;
+		DEFINE_NUMALIST_PTR(l3);
 
 		searchp = list_entry(walk, kmem_cache_t, next);
 
@@ -2019,36 +2134,41 @@
 			memmove(&ac_entry(ac)[0], &ac_entry(ac)[tofree],
 					sizeof(void*)*ac->avail);
 		}
-		if(time_after(searchp->lists.next_reap, jiffies))
+#ifdef CONFIG_SLAB_NUMA
+		ac = searchp->cpudata[smp_processor_id()].alien;
+		free_block(searchp, ac_entry(ac), ac->avail);
+		ac->avail = 0;
+#endif
+		set_numalist_cur(l3, searchp);
+		if(time_after(access_numalist_ptr(searchp, l3)->next_reap, jiffies))
 			goto next_irqon;
 
 		spin_lock(&searchp->spinlock);
-		if(time_after(searchp->lists.next_reap, jiffies)) {
+		if(time_after(access_numalist_ptr(searchp, l3)->next_reap, jiffies)) {
 			goto next_unlock;
 		}
-		searchp->lists.next_reap = jiffies + REAPTIMEOUT_LIST3;
-		if (searchp->lists.free_touched) {
-			searchp->lists.free_touched = 0;
+		access_numalist_ptr(searchp, l3)->next_reap = jiffies + REAPTIMEOUT_LIST3;
+		if (access_numalist_ptr(searchp, l3)->free_touched) {
+			access_numalist_ptr(searchp, l3)->free_touched = 0;
 			goto next_unlock;
 		}
 
 		tofree = (searchp->free_limit+5*searchp->num-1)/(5*searchp->num);
 		do {
-			p = list3_data(searchp)->slabs_free.next;
-			if (p == &(list3_data(searchp)->slabs_free))
+			p = access_numalist_ptr(searchp, l3)->slabs_free.next;
+			if (p == &(access_numalist_ptr(searchp, l3)->slabs_free))
 				break;
 
 			slabp = list_entry(p, struct slab, list);
 			BUG_ON(slabp->inuse);
 			list_del(&slabp->list);
-			STATS_INC_REAPED(searchp);
 
 			/* Safe to drop the lock. The slab is no longer
 			 * linked to the cache.
 			 * searchp cannot disappear, we hold
 			 * cache_chain_lock
 			 */
-			searchp->lists.free_objects -= searchp->num;
+			access_numalist_ptr(searchp, l3)->free_objects -= searchp->num;
 			spin_unlock_irq(&searchp->spinlock);
 			slab_destroy(searchp, slabp);
 			spin_lock_irq(&searchp->spinlock);
@@ -2075,7 +2195,7 @@
 	struct timer_list *rt = &reap_timers[cpu];
 
 	cache_reap();
-	mod_timer(rt, jiffies + REAPTIMEOUT_CPUC + cpu);
+	mod_timer(rt, jiffies + REAPTIMEOUT_CPUC);
 }
 
 #ifdef CONFIG_PROC_FS
@@ -2116,19 +2236,16 @@
 {
 	kmem_cache_t *cachep = p;
 	struct list_head *q;
-	struct slab	*slabp;
-	unsigned long	active_objs;
-	unsigned long	num_objs;
-	unsigned long	active_slabs = 0;
-	unsigned long	num_slabs;
+	struct slab		*slabp;
 	const char *name; 
+	int i;
 
 	if (p == (void*)1) {
 		/*
 		 * Output format version, so at least we can change it
 		 * without _too_ many complaints.
 		 */
-		seq_puts(m, "slabinfo - version: 1.2"
+		seq_puts(m, "slabinfo - version: 2.0"
 #if STATS
 				" (statistics)"
 #endif
@@ -2136,33 +2253,7 @@
 		return 0;
 	}
 
-	check_irq_on();
-	spin_lock_irq(&cachep->spinlock);
-	active_objs = 0;
-	num_slabs = 0;
-	list_for_each(q,&cachep->lists.slabs_full) {
-		slabp = list_entry(q, struct slab, list);
-		if (slabp->inuse != cachep->num)
-			BUG();
-		active_objs += cachep->num;
-		active_slabs++;
-	}
-	list_for_each(q,&cachep->lists.slabs_partial) {
-		slabp = list_entry(q, struct slab, list);
-		BUG_ON(slabp->inuse == cachep->num || !slabp->inuse);
-		active_objs += slabp->inuse;
-		active_slabs++;
-	}
-	list_for_each(q,&cachep->lists.slabs_free) {
-		slabp = list_entry(q, struct slab, list);
-		if (slabp->inuse)
-			BUG();
-		num_slabs++;
-	}
-	num_slabs+=active_slabs;
-	num_objs = num_slabs*cachep->num;
-	BUG_ON(num_objs - active_objs != cachep->lists.free_objects);
-
+	/* line 1: global stats */
 	name = cachep->name; 
 	{
 	char tmp; 
@@ -2175,33 +2266,76 @@
 	set_fs(old_fs);
 	} 	
 
-	seq_printf(m, "%-17s %6lu %6lu %6u %4lu %4lu %4u",
-		name, active_objs, num_objs, cachep->objsize,
-		active_slabs, num_slabs, (1<<cachep->gfporder));
+	seq_printf(m, "%-17s : %6u %6u %4u 0x%04x %6u %4u %4u",
+		name, cachep->objsize, cachep->num, (1<<cachep->gfporder),
+		cachep->flags, cachep->free_limit, cachep->limit, cachep->batchcount);
+#if STATS
+	seq_printf(m, " %4u", atomic_read(&cachep->errors));
+#endif
+
+	seq_putc(m, '\n');
+
+
+	check_irq_on();
+	/* block 2: list3 data */
+	spin_lock_irq(&cachep->spinlock);
+	for (i=0;i<MAX_NUMNODES;i++) {
+		struct kmem_list3 *l3 = &cachep->lists[i];
+		unsigned long	active_objs = 0;
+		unsigned long	num_objs = 0;
+		unsigned long	active_slabs = 0;
+		unsigned long	num_slabs = 0;
+
+		list_for_each(q,&l3->slabs_full) {
+			slabp = list_entry(q, struct slab, list);
+			if (slabp->inuse != cachep->num)
+				BUG();
+			active_objs += cachep->num;
+			active_slabs++;
+		}
+		list_for_each(q,&l3->slabs_partial) {
+			slabp = list_entry(q, struct slab, list);
+			BUG_ON(slabp->inuse == cachep->num || !slabp->inuse);
+			active_objs += slabp->inuse;
+			active_slabs++;
+		}
+		list_for_each(q,&l3->slabs_free) {
+			slabp = list_entry(q, struct slab, list);
+			if (slabp->inuse)
+				BUG();
+			num_slabs++;
+		}
+		num_slabs+=active_slabs;
+		num_objs = num_slabs*cachep->num;
+
+		BUG_ON(num_objs - active_objs != l3->free_objects);
+		seq_printf(m, "# Node %2u         : %6lu %6lu %8lu %8lu",
+			i, active_slabs, num_slabs, active_objs, num_objs);
+#if STATS
+		BUG_ON(active_objs != l3->num_active);
 
-	seq_printf(m, " : %4u %4u", cachep->limit, cachep->batchcount);
+		seq_printf(m, " %8lu %8lu %6lu", l3->num_allocations, 
+					l3->high_mark, l3->grown);
+#endif
+		seq_putc(m, '\n');
+	}
+	/* block 3: array data */
 #if STATS
-	{	// list3 stats
-		unsigned long high = cachep->high_mark;
-		unsigned long allocs = cachep->num_allocations;
-		unsigned long grown = cachep->grown;
-		unsigned long reaped = cachep->reaped;
-		unsigned long errors = cachep->errors;
-		unsigned long max_freeable = cachep->max_freeable;
-		unsigned long free_limit = cachep->free_limit;
-
-		seq_printf(m, " : %6lu %7lu %5lu %4lu %4lu %4lu %4lu",
-				high, allocs, grown, reaped, errors, 
-				max_freeable, free_limit);
-	}
-	{	// cpucache stats
-		unsigned long allochit = atomic_read(&cachep->allochit);
-		unsigned long allocmiss = atomic_read(&cachep->allocmiss);
-		unsigned long freehit = atomic_read(&cachep->freehit);
-		unsigned long freemiss = atomic_read(&cachep->freemiss);
+	for (i=0;i<NR_CPUS;i++) {
+		if (!cpu_online(i))
+			continue;
 
-		seq_printf(m, " : %6lu %6lu %6lu %6lu",
-				allochit, allocmiss, freehit, freemiss);
+		seq_printf(m, "# Cpu %2i          : %6u %6u %6u %6u",
+				i, 
+				atomic_read(&cachep->allochit[i]),
+				atomic_read(&cachep->allocmiss[i]),
+				atomic_read(&cachep->freehit[i]),
+				atomic_read(&cachep->freemiss[i]));
+#ifdef CONFIG_SLAB_NUMA
+		seq_printf(m, " %6u",
+				atomic_read(&cachep->foreign[i]));
+#endif
+		seq_putc(m, '\n');
 	}
 #endif
 	spin_unlock_irq(&cachep->spinlock);

--------------090700010801050401070407--


