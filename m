Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262460AbSI2MkP>; Sun, 29 Sep 2002 08:40:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262459AbSI2MkP>; Sun, 29 Sep 2002 08:40:15 -0400
Received: from dbl.q-ag.de ([80.146.160.66]:12447 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S262466AbSI2Mjh>;
	Sun, 29 Sep 2002 08:39:37 -0400
Message-ID: <3D96F559.2070502@colorfullife.com>
Date: Sun, 29 Sep 2002 14:43:05 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/4.0 (compatible; MSIE 5.5; Windows NT 4.0)
X-Accept-Language: en, de
MIME-Version: 1.0
To: lse-tech@lists.sourceforge.net
CC: "Martin J. Bligh" <mbligh@aracnet.com>, akpm@digeo.com, tomlins@cam.org,
       "Kamble, Nitin A" <nitin.a.kamble@intel.com>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
Subject: [PATH] slab cleanup
Content-Type: multipart/mixed;
 boundary="------------040207010207030008060802"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040207010207030008060802
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

I think we should make some cleanups before adding NUMA:

a) make the per-cpu arrays unconditional, even on UP.
	The arrays provides LIFO ordering, which should improve
	cache hit rates. The disadvantage is probably a higher
	internal fragmentation [not measured], but memory is cheap,
	and cache hit are important.
	In addition, this makes it possible to perform some cleanups.
	No more kmem_cache_alloc_one, for example.

b) use arrays for all caches, even with large objects.
	E.g. right now, the 16 kB loopback socket buffers
	are not handled per-cpu.

Nitin, in your NUMA patch, you return each "wrong-node" object
immediately, without batching them together. Have you considered
batching? It could reduce the number of spinlock operations dramatically.

There is one additional problem without an obvious solution:
kmem_cache_reap() is too inefficient. Before 2.5.39, it served 2 purposes:

1) return freeable slabs back to gfp.

	<2.5.39 scans through the caches in every try_to_free_pages.
	That scan is terribly inefficient, and akpm noticed lots of
	idle reschedules on the cache_chain_sem

	2.5.39 limits the freeable slabs list to one entry, and doesn't
	scan at all. On the one hand, this locks up one slab in each
	cache [in the worst case, a order=5 allocation]. For very
	bursty, slightly fragmented caches, it could lead to
	more kmem_cache_grow().

	My patch scans every 2 seconds, and return 80% of the pages.

2) regularly flush the per-cpu arrays
	<2.5.39 does that in every try_to_free_pages.

	My patch does that evey 2 seconds, on a random cpu.
	
	2.5.39 does that never. It probably reduces cpucache trashing
	[alloc batch of 120 objects, return one object, release
	batch of 119 objects due to th next try_to_free_pages]
	The problem is that without flushing, the cpuarrays can
	lock up lots of pages.[in the worst case, several thousand
	for each cpu].

The attached patch is WIP:
* boots on UP
* partially boots with bochs [cpu simulator], until bochs locks up.
* contains comments, where I'd add modifications for NUMA.

What do you think?
For NUMA, is it possible to figure out efficiently into which node a
pointer points? That would happen in every kmem_cache_free().

Could someone test that it works on real SMP?

What the best replacement for kmem_cache_reap()? 2.5.39 contains
obviously the simplest approach, but I'm not sure if it's the best.

--
	Manfred



--------------040207010207030008060802
Content-Type: text/plain;
 name="patch-slab-LIFO"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-slab-LIFO"

--- 2.5/mm/slab.c	Sat Sep 28 12:55:16 2002
+++ build-2.5/mm/slab.c	Sun Sep 29 13:16:49 2002
@@ -8,6 +8,9 @@
  * Major cleanup, different bufctl logic, per-cpu arrays
  *	(c) 2000 Manfred Spraul
  *
+ * Cleanup, make the head arrays unconditional, preparation for NUMA
+ * 	(c) 2002 Manfred Spraul
+ *
  * An implementation of the Slab Allocator as described in outline in;
  *	UNIX Internals: The New Frontiers by Uresh Vahalia
  *	Pub: Prentice Hall	ISBN 0-13-101908-2
@@ -16,7 +19,6 @@
  *	Jeff Bonwick (Sun Microsystems).
  *	Presented at: USENIX Summer 1994 Technical Conference
  *
- *
  * The memory is organized in caches, one cache for each object type.
  * (e.g. inode_cache, dentry_cache, buffer_head, vm_area_struct)
  * Each cache consists out of many slabs (they are small (usually one
@@ -38,12 +40,14 @@
  * kmem_cache_destroy() CAN CRASH if you try to allocate from the cache
  * during kmem_cache_destroy(). The caller must prevent concurrent allocs.
  *
- * On SMP systems, each cache has a short per-cpu head array, most allocs
+ * Each cache has a short per-cpu head array, most allocs
  * and frees go into that array, and if that array overflows, then 1/2
  * of the entries in the array are given back into the global cache.
- * This reduces the number of spinlock operations.
+ * The head array is strictly LIFO and should improve the cache hit rates.
+ * On SMP, it additionally reduces the spinlock operations.
  *
- * The c_cpuarray may not be read with enabled local interrupts.
+ * The c_cpuarray may not be read with enabled local interrupts - 
+ * it's changed with a smp_call_function().
  *
  * SMP synchronization:
  *  constructors and destructors are called without any locking.
@@ -53,6 +57,10 @@
  *  	and local interrupts are disabled so slab code is preempt-safe.
  *  The non-constant members are protected with a per-cache irq spinlock.
  *
+ * Many thanks to Mark Hemment, who wrote another per-cpu slab patch
+ * in 2000 - many ideas in the current implementation are derived from
+ * his patch.
+ *
  * Further notes from the original documentation:
  *
  * 11 April '97.  Started multi-threading - markhe
@@ -61,10 +69,6 @@
  *	can never happen inside an interrupt (kmem_cache_create(),
  *	kmem_cache_shrink() and kmem_cache_reap()).
  *
- *	To prevent kmem_cache_shrink() trying to shrink a 'growing' cache (which
- *	maybe be sleeping and therefore not holding the semaphore/lock), the
- *	growing field is used.  This also prevents reaping from a cache.
- *
  *	At present, each engine can be growing a cache.  This should be blocked.
  *
  */
@@ -77,6 +81,7 @@
 #include	<linux/init.h>
 #include	<linux/compiler.h>
 #include	<linux/seq_file.h>
+#include	<linux/notifier.h>
 #include	<asm/uaccess.h>
 
 /*
@@ -100,11 +105,8 @@
 #define	FORCED_DEBUG	0
 #endif
 
-/*
- * Parameters for kmem_cache_reap
- */
-#define REAP_SCANLEN	10
-#define REAP_PERFECT	10
+
+static unsigned long g_cache_count;
 
 /* Shouldn't this be in a header file somewhere? */
 #define	BYTES_PER_WORD		sizeof(void *)
@@ -170,39 +172,91 @@
  * cpucache_t
  *
  * Per cpu structures
+ * Purpose:
+ * - LIFO ordering, to hand out cache-warm objects from _alloc
+ * - reduce spinlock operations
+ *
  * The limit is stored in the per-cpu structure to reduce the data cache
  * footprint.
+ * On NUMA systems, 2 per-cpu structures exist: one for the current
+ * node, one for wrong node free calls.
+ * Memory from the wrong node is never returned by alloc, it's returned
+ * to the home node as soon as the cpu cache is filled
+ *
  */
 typedef struct cpucache_s {
 	unsigned int avail;
 	unsigned int limit;
+	unsigned int batchcount;
 } cpucache_t;
 
+/* bootstrap: The caches do not work without cpuarrays anymore,
+ * but the cpuarrays are allocated from the generic caches...
+ */
+#define BOOT_CPUCACHE_ENTRIES	1
+struct cpucache_int {
+	cpucache_t cache;
+	void * entries[BOOT_CPUCACHE_ENTRIES];
+};
+
 #define cc_entry(cpucache) \
 	((void **)(((cpucache_t*)(cpucache))+1))
 #define cc_data(cachep) \
 	((cachep)->cpudata[smp_processor_id()])
 /*
+ * NUMA: check if 'ptr' points into the current node,
+ * 	use the alternate cpudata cache if wrong
+ */
+#define cc_data_ptr(cachep, ptr) \
+		cc_data(cachep)
+
+/*
+ * The slab lists of all objects.
+ * They provide some aging, and hopefully reduce the 
+ * internal fragmentation
+ * TODO: The spinlock should be moved from the kmem_cache_t
+ * into this structure, too.
+ */
+struct kmem_list3 {
+	struct list_head	slabs_partial;	/* partial list first, better asm code */
+	struct list_head	slabs_full;
+	struct list_head	slabs_free;
+};
+
+#define LIST3_INIT(parent) \
+	{ \
+		.slabs_full	= LIST_HEAD_INIT(parent.slabs_full), \
+		.slabs_partial	= LIST_HEAD_INIT(parent.slabs_partial), \
+		.slabs_free	= LIST_HEAD_INIT(parent.slabs_free) \
+	}
+#define list3_data(cachep) \
+	(&(cachep)->lists)
+
+/* NUMA: per-node */
+#define list3_data_ptr(cachep, ptr) \
+		list3_data(cachep)
+
+/*
  * kmem_cache_t
  *
  * manages a cache.
  */
-
+	
 struct kmem_cache_s {
-/* 1) each alloc & free */
-	/* full, partial first, then free */
-	struct list_head	slabs_full;
-	struct list_head	slabs_partial;
-	struct list_head	slabs_free;
+/* 1) per-cpu data, touched during every alloc/free */
+	cpucache_t		*cpudata[NR_CPUS];
+	/* NUMA: cpucache_t	*cpudata_othernode[NR_CPUS]; */
+	unsigned int		batchcount;
+	unsigned int		limit;
+/* 2) touched by every alloc & free from the backend */
+	struct kmem_list3	lists;
+	/* NUMA: kmem_3list_t	*nodelists[NR_NODES] */
 	unsigned int		objsize;
 	unsigned int	 	flags;	/* constant flags */
 	unsigned int		num;	/* # of objs per slab */
 	spinlock_t		spinlock;
-#ifdef CONFIG_SMP
-	unsigned int		batchcount;
-#endif
 
-/* 2) slab additions /removals */
+/* 3) kmem_cache_grow/shrink */
 	/* order of pgs per slab (2^n) */
 	unsigned int		gfporder;
 
@@ -213,7 +267,6 @@
 	unsigned int		colour_off;	/* colour offset */
 	unsigned int		colour_next;	/* cache colouring */
 	kmem_cache_t		*slabp_cache;
-	unsigned int		growing;
 	unsigned int		dflags;		/* dynamic flags */
 
 	/* constructor func */
@@ -222,15 +275,11 @@
 	/* de-constructor func */
 	void (*dtor)(void *, kmem_cache_t *, unsigned long);
 
-	unsigned long		failures;
-
-/* 3) cache creation/removal */
+/* 4) cache creation/removal */
 	const char		*name;
 	struct list_head	next;
-#ifdef CONFIG_SMP
-/* 4) per-cpu data */
-	cpucache_t		*cpudata[NR_CPUS];
-#endif
+
+/* 5) statistics */
 #if STATS
 	unsigned long		num_active;
 	unsigned long		num_allocations;
@@ -238,13 +287,12 @@
 	unsigned long		grown;
 	unsigned long		reaped;
 	unsigned long 		errors;
-#ifdef CONFIG_SMP
+	unsigned long		max_freeable;
 	atomic_t		allochit;
 	atomic_t		allocmiss;
 	atomic_t		freehit;
 	atomic_t		freemiss;
 #endif
-#endif
 };
 
 /* internal c_flags */
@@ -268,6 +316,15 @@
 					(x)->high_mark = (x)->num_active; \
 				} while (0)
 #define	STATS_INC_ERR(x)	((x)->errors++)
+#define	STATS_SET_FREEABLE(x, i) \
+				do { if ((x)->max_freeable < i) \
+					(x)->max_freeable = i; \
+				} while (0)
+#
+#define STATS_INC_ALLOCHIT(x)	atomic_inc(&(x)->allochit)
+#define STATS_INC_ALLOCMISS(x)	atomic_inc(&(x)->allocmiss)
+#define STATS_INC_FREEHIT(x)	atomic_inc(&(x)->freehit)
+#define STATS_INC_FREEMISS(x)	atomic_inc(&(x)->freemiss)
 #else
 #define	STATS_INC_ACTIVE(x)	do { } while (0)
 #define	STATS_DEC_ACTIVE(x)	do { } while (0)
@@ -276,18 +333,14 @@
 #define	STATS_INC_REAPED(x)	do { } while (0)
 #define	STATS_SET_HIGH(x)	do { } while (0)
 #define	STATS_INC_ERR(x)	do { } while (0)
-#endif
+#define	STATS_SET_FREEABLE(x, i) \
+				do { } while (0)
 
-#if STATS && defined(CONFIG_SMP)
-#define STATS_INC_ALLOCHIT(x)	atomic_inc(&(x)->allochit)
-#define STATS_INC_ALLOCMISS(x)	atomic_inc(&(x)->allocmiss)
-#define STATS_INC_FREEHIT(x)	atomic_inc(&(x)->freehit)
-#define STATS_INC_FREEMISS(x)	atomic_inc(&(x)->freemiss)
-#else
 #define STATS_INC_ALLOCHIT(x)	do { } while (0)
 #define STATS_INC_ALLOCMISS(x)	do { } while (0)
 #define STATS_INC_FREEHIT(x)	do { } while (0)
 #define STATS_INC_FREEMISS(x)	do { } while (0)
+
 #endif
 
 #if DEBUG
@@ -382,11 +435,15 @@
 }; 
 #undef CN
 
+struct cpucache_int cpuarray_cache __initdata = { { 0, BOOT_CPUCACHE_ENTRIES, 1} };
+struct cpucache_int cpuarray_generic __initdata = { { 0, BOOT_CPUCACHE_ENTRIES, 1} };
+
 /* internal cache of cache description objs */
 static kmem_cache_t cache_cache = {
-	.slabs_full	= LIST_HEAD_INIT(cache_cache.slabs_full),
-	.slabs_partial	= LIST_HEAD_INIT(cache_cache.slabs_partial),
-	.slabs_free	= LIST_HEAD_INIT(cache_cache.slabs_free),
+	.lists		= LIST3_INIT(cache_cache.lists),
+	.cpudata	= { [0] = &cpuarray_cache.cache },
+	.batchcount	= 1,
+	.limit		= BOOT_CPUCACHE_ENTRIES,
 	.objsize	= sizeof(kmem_cache_t),
 	.flags		= SLAB_NO_REAP,
 	.spinlock	= SPIN_LOCK_UNLOCKED,
@@ -402,16 +459,21 @@
 
 #define cache_chain (cache_cache.next)
 
-#ifdef CONFIG_SMP
 /*
  * chicken and egg problem: delay the per-cpu array allocation
  * until the general caches are up.
  */
-static int g_cpucache_up;
+enum {
+	NONE,
+	PARTIAL,
+	FULL
+} g_cpucache_up;
+
+static struct timer_list reap_timer;
+static void reap_timer_fnc(unsigned long data);
 
 static void enable_cpucache (kmem_cache_t *cachep);
 static void enable_all_cpucaches (void);
-#endif
 
 /* Cal the num objs, wastage, and bytes left over for a given slab size. */
 static void kmem_cache_estimate (unsigned long gfporder, size_t size,
@@ -441,6 +503,46 @@
 	*left_over = wastage;
 }
 
+static int __devinit cpuup_callback(struct notifier_block *nfb,
+				  unsigned long action,
+				  void *hcpu)
+{
+	int cpu = (int)hcpu;
+	if (action == CPU_ONLINE) {
+		struct list_head *p;
+		cpucache_t *nc;
+
+		down(&cache_chain_sem);
+
+		p = &cache_cache.next;
+		do {
+			int memsize;
+
+			kmem_cache_t* cachep = list_entry(p, kmem_cache_t, next);
+			memsize = sizeof(void*)*cachep->limit+sizeof(cpucache_t);
+			nc = kmalloc(memsize, GFP_KERNEL);
+			if (!nc)
+				goto bad;
+			nc->avail = 0;
+			nc->limit = cachep->limit;
+			nc->batchcount = cachep->batchcount;
+
+			cachep->cpudata[cpu] = nc;
+
+			p = cachep->next.next;
+		} while (p != &cache_cache.next);
+
+		up(&cache_chain_sem);
+	}
+
+	return NOTIFY_OK;
+bad:
+	up(&cache_chain_sem);
+	return NOTIFY_BAD;
+}
+
+static struct notifier_block cpucache_notifier = { &cpuup_callback, NULL, 0 };
+
 /* Initialisation - setup the `cache' cache. */
 void __init kmem_cache_init(void)
 {
@@ -456,6 +558,22 @@
 
 	cache_cache.colour = left_over/cache_cache.colour_off;
 	cache_cache.colour_next = 0;
+
+	g_cache_count = 1;
+
+	/* Register a cpu startup notifier callback
+	 * that initializes cc_data for all new cpus
+	 */
+
+	register_cpu_notifier(&cpucache_notifier);
+	
+	/* register the timer that return unneeded
+	 * pages to gfp.
+	 */
+	init_timer(&reap_timer);
+	reap_timer.expires = jiffies + HZ;
+	reap_timer.function = reap_timer_fnc;
+	add_timer(&reap_timer);
 }
 
 
@@ -465,6 +583,7 @@
 void __init kmem_cache_sizes_init(void)
 {
 	cache_sizes_t *sizes = cache_sizes;
+
 	/*
 	 * Fragmentation resistance on low memory - only use bigger
 	 * page orders on machines with more than 32MB of memory.
@@ -497,14 +616,34 @@
 			BUG();
 		sizes++;
 	} while (sizes->cs_size);
+	/*
+	 * The generic caches are running - time to kick out the
+	 * bootstrap cpucaches.
+	 */
+	{
+		void * ptr;
+		
+		ptr = kmalloc(sizeof(struct cpucache_int), GFP_KERNEL);
+		local_irq_disable();
+		BUG_ON(cc_data(&cache_cache) != &cpuarray_cache.cache);
+		memcpy(ptr, cc_data(&cache_cache), sizeof(struct cpucache_int));
+		cc_data(&cache_cache) = ptr;
+		local_irq_enable();
+	
+		ptr = kmalloc(sizeof(struct cpucache_int), GFP_KERNEL);
+		local_irq_disable();
+		BUG_ON(cc_data(cache_sizes[0].cs_cachep) != &cpuarray_generic.cache);
+		memcpy(ptr, cc_data(cache_sizes[0].cs_cachep),
+				sizeof(struct cpucache_int));
+		cc_data(cache_sizes[0].cs_cachep) = ptr;
+		local_irq_enable();
+	}
 }
 
 int __init kmem_cpucache_init(void)
 {
-#ifdef CONFIG_SMP
-	g_cpucache_up = 1;
+	g_cpucache_up = FULL;
 	enable_all_cpucaches();
-#endif
 	return 0;
 }
 
@@ -552,7 +691,7 @@
 }
 
 #if DEBUG
-static inline void kmem_poison_obj (kmem_cache_t *cachep, void *addr)
+static void kmem_poison_obj (kmem_cache_t *cachep, void *addr)
 {
 	int size = cachep->objsize;
 	if (cachep->flags & SLAB_RED_ZONE) {
@@ -563,7 +702,7 @@
 	*(unsigned char *)(addr+size-1) = POISON_END;
 }
 
-static inline int kmem_check_poison_obj (kmem_cache_t *cachep, void *addr)
+static int kmem_check_poison_obj (kmem_cache_t *cachep, void *addr)
 {
 	int size = cachep->objsize;
 	void *end;
@@ -584,37 +723,34 @@
  */
 static void kmem_slab_destroy (kmem_cache_t *cachep, slab_t *slabp)
 {
-	if (cachep->dtor
 #if DEBUG
-		|| cachep->flags & (SLAB_POISON | SLAB_RED_ZONE)
-#endif
-	) {
+	int i;
+	for (i = 0; i < cachep->num; i++) {
+		void* objp = slabp->s_mem+cachep->objsize*i;
+		if (cachep->flags & SLAB_POISON)
+			kmem_check_poison_obj(cachep, objp);
+
+		if (cachep->flags & SLAB_RED_ZONE) {
+			if (*((unsigned long*)(objp)) != RED_MAGIC1)
+				BUG();
+			if (*((unsigned long*)(objp + cachep->objsize -
+					BYTES_PER_WORD)) != RED_MAGIC1)
+				BUG();
+			objp += BYTES_PER_WORD;
+		}
+		if (cachep->dtor && !(cachep->flags & SLAB_POISON))
+			(cachep->dtor)(objp, cachep, 0);
+	}
+#else
+	if (cachep->dtor) {
 		int i;
 		for (i = 0; i < cachep->num; i++) {
 			void* objp = slabp->s_mem+cachep->objsize*i;
-#if DEBUG
-			if (cachep->flags & SLAB_RED_ZONE) {
-				if (*((unsigned long*)(objp)) != RED_MAGIC1)
-					BUG();
-				if (*((unsigned long*)(objp + cachep->objsize
-						-BYTES_PER_WORD)) != RED_MAGIC1)
-					BUG();
-				objp += BYTES_PER_WORD;
-			}
-#endif
-			if (cachep->dtor)
-				(cachep->dtor)(objp, cachep, 0);
-#if DEBUG
-			if (cachep->flags & SLAB_RED_ZONE) {
-				objp -= BYTES_PER_WORD;
-			}	
-			if ((cachep->flags & SLAB_POISON)  &&
-				kmem_check_poison_obj(cachep, objp))
-				BUG();
-#endif
+			(cachep->dtor)(objp, cachep, 0);
 		}
 	}
-
+#endif
+	
 	kmem_freepages(cachep, slabp->s_mem-slabp->colouroff);
 	if (OFF_SLAB(cachep))
 		kmem_cache_free(cachep->slabp_cache, slabp);
@@ -701,8 +837,7 @@
 	 * Always checks flags, a caller might be expecting debug
 	 * support which isn't available.
 	 */
-	if (flags & ~CREATE_MASK)
-		BUG();
+	BUG_ON(flags & ~CREATE_MASK);
 
 	/* Get cache's description obj. */
 	cachep = (kmem_cache_t *) kmem_cache_alloc(&cache_cache, SLAB_KERNEL);
@@ -745,7 +880,6 @@
 	if (flags & SLAB_HWCACHE_ALIGN) {
 		/* Need to adjust size so that objs are cache aligned. */
 		/* Small obj size, can get at least two per cache line. */
-		/* FIXME: only power of 2 supported, was better */
 		while (size < align/2)
 			align /= 2;
 		size = (size+align-1)&(~(align-1));
@@ -822,9 +956,10 @@
 		cachep->gfpflags |= GFP_DMA;
 	spin_lock_init(&cachep->spinlock);
 	cachep->objsize = size;
-	INIT_LIST_HEAD(&cachep->slabs_full);
-	INIT_LIST_HEAD(&cachep->slabs_partial);
-	INIT_LIST_HEAD(&cachep->slabs_free);
+	/* NUMA */
+	INIT_LIST_HEAD(&cachep->lists.slabs_full);
+	INIT_LIST_HEAD(&cachep->lists.slabs_partial);
+	INIT_LIST_HEAD(&cachep->lists.slabs_free);
 
 	if (flags & CFLGS_OFF_SLAB)
 		cachep->slabp_cache = kmem_find_general_cachep(slab_size,0);
@@ -832,10 +967,27 @@
 	cachep->dtor = dtor;
 	cachep->name = name;
 
-#ifdef CONFIG_SMP
-	if (g_cpucache_up)
+	if (g_cpucache_up == FULL) {
 		enable_cpucache(cachep);
-#endif
+	} else {
+		if (g_cpucache_up == NONE) {
+			/* Note: the first kmem_cache_create must create
+			 * the cache that's used by kmalloc(16), otherwise
+			 * the creation of further caches will BUG().
+			 */
+			cc_data(cachep) = &cpuarray_generic.cache;
+			g_cpucache_up = PARTIAL;
+		} else {
+			cc_data(cachep) = kmalloc(sizeof(struct cpucache_int),GFP_KERNEL);
+		}
+		BUG_ON(!cc_data(cachep));
+		cc_data(cachep)->avail = 0;
+		cc_data(cachep)->limit = BOOT_CPUCACHE_ENTRIES;
+		cc_data(cachep)->batchcount = 1;
+		cachep->batchcount = 1;
+		cachep->limit = BOOT_CPUCACHE_ENTRIES;
+	} 
+
 	/* Need the semaphore to access the chain. */
 	down(&cache_chain_sem);
 	{
@@ -869,96 +1021,14 @@
 	 */
 	list_add(&cachep->next, &cache_chain);
 	up(&cache_chain_sem);
+	g_cache_count++;
 opps:
 	return cachep;
 }
 
+static void drain_cpu_caches(kmem_cache_t *cachep);
 
-#if DEBUG
-/*
- * This check if the kmem_cache_t pointer is chained in the cache_cache
- * list. -arca
- */
-static int is_chained_kmem_cache(kmem_cache_t * cachep)
-{
-	struct list_head *p;
-	int ret = 0;
-
-	/* Find the cache in the chain of caches. */
-	down(&cache_chain_sem);
-	list_for_each(p, &cache_chain) {
-		if (p == &cachep->next) {
-			ret = 1;
-			break;
-		}
-	}
-	up(&cache_chain_sem);
-
-	return ret;
-}
-#else
-#define is_chained_kmem_cache(x) 1
-#endif
-
-#ifdef CONFIG_SMP
-/*
- * Waits for all CPUs to execute func().
- */
-static void smp_call_function_all_cpus(void (*func) (void *arg), void *arg)
-{
-	local_irq_disable();
-	func(arg);
-	local_irq_enable();
-
-	if (smp_call_function(func, arg, 1, 1))
-		BUG();
-}
-typedef struct ccupdate_struct_s
-{
-	kmem_cache_t *cachep;
-	cpucache_t *new[NR_CPUS];
-} ccupdate_struct_t;
-
-static void do_ccupdate_local(void *info)
-{
-	ccupdate_struct_t *new = (ccupdate_struct_t *)info;
-	cpucache_t *old = cc_data(new->cachep);
-	
-	cc_data(new->cachep) = new->new[smp_processor_id()];
-	new->new[smp_processor_id()] = old;
-}
-
-static void free_block (kmem_cache_t* cachep, void** objpp, int len);
-
-static void drain_cpu_caches(kmem_cache_t *cachep)
-{
-	ccupdate_struct_t new;
-	int i;
-
-	memset(&new.new,0,sizeof(new.new));
-
-	new.cachep = cachep;
-
-	down(&cache_chain_sem);
-	smp_call_function_all_cpus(do_ccupdate_local, (void *)&new);
-
-	for (i = 0; i < NR_CPUS; i++) {
-		cpucache_t* ccold = new.new[i];
-		if (!ccold || (ccold->avail == 0))
-			continue;
-		local_irq_disable();
-		free_block(cachep, cc_entry(ccold), ccold->avail);
-		local_irq_enable();
-		ccold->avail = 0;
-	}
-	smp_call_function_all_cpus(do_ccupdate_local, (void *)&new);
-	up(&cache_chain_sem);
-}
-
-#else
-#define drain_cpu_caches(cachep)	do { } while (0)
-#endif
-
+/* NUMA shrink all list3s */
 static int __kmem_cache_shrink(kmem_cache_t *cachep)
 {
 	slab_t *slabp;
@@ -968,26 +1038,23 @@
 
 	spin_lock_irq(&cachep->spinlock);
 
-	/* If the cache is growing, stop shrinking. */
-	while (!cachep->growing) {
+	for(;;) {
 		struct list_head *p;
 
-		p = cachep->slabs_free.prev;
-		if (p == &cachep->slabs_free)
+		p = cachep->lists.slabs_free.prev;
+		if (p == &cachep->lists.slabs_free)
 			break;
 
-		slabp = list_entry(cachep->slabs_free.prev, slab_t, list);
-#if DEBUG
-		if (slabp->inuse)
-			BUG();
-#endif
+		slabp = list_entry(cachep->lists.slabs_free.prev, slab_t, list);
+		BUG_ON(slabp->inuse);
 		list_del(&slabp->list);
 
 		spin_unlock_irq(&cachep->spinlock);
 		kmem_slab_destroy(cachep, slabp);
 		spin_lock_irq(&cachep->spinlock);
 	}
-	ret = !list_empty(&cachep->slabs_full) || !list_empty(&cachep->slabs_partial);
+	ret = !list_empty(&cachep->lists.slabs_full) ||
+		!list_empty(&cachep->lists.slabs_partial);
 	spin_unlock_irq(&cachep->spinlock);
 	return ret;
 }
@@ -1001,8 +1068,7 @@
  */
 int kmem_cache_shrink(kmem_cache_t *cachep)
 {
-	if (!cachep || in_interrupt() || !is_chained_kmem_cache(cachep))
-		BUG();
+	BUG_ON(!cachep || in_interrupt());
 
 	return __kmem_cache_shrink(cachep);
 }
@@ -1024,8 +1090,7 @@
  */
 int kmem_cache_destroy (kmem_cache_t * cachep)
 {
-	if (!cachep || in_interrupt() || cachep->growing)
-		BUG();
+	BUG_ON(!cachep || in_interrupt());
 
 	/* Find the cache in the chain of caches. */
 	down(&cache_chain_sem);
@@ -1044,14 +1109,14 @@
 		up(&cache_chain_sem);
 		return 1;
 	}
-#ifdef CONFIG_SMP
 	{
 		int i;
 		for (i = 0; i < NR_CPUS; i++)
 			kfree(cachep->cpudata[i]);
+		/* NUMA: free the list3 structures */
 	}
-#endif
 	kmem_cache_free(&cache_cache, cachep);
+	g_cache_count--;
 
 	return 0;
 }
@@ -1068,10 +1133,6 @@
 		if (!slabp)
 			return NULL;
 	} else {
-		/* FIXME: change to
-			slabp = objp
-		 * if you enable OPTIMIZE
-		 */
 		slabp = objp+colour_off;
 		colour_off += L1_CACHE_ALIGN(cachep->num *
 				sizeof(kmem_bufctl_t) + sizeof(slab_t));
@@ -1091,34 +1152,30 @@
 	for (i = 0; i < cachep->num; i++) {
 		void* objp = slabp->s_mem+cachep->objsize*i;
 #if DEBUG
+		/* need to poison the objs? */
+		if (cachep->flags & SLAB_POISON)
+			kmem_poison_obj(cachep, objp);
+
 		if (cachep->flags & SLAB_RED_ZONE) {
 			*((unsigned long*)(objp)) = RED_MAGIC1;
 			*((unsigned long*)(objp + cachep->objsize -
 					BYTES_PER_WORD)) = RED_MAGIC1;
 			objp += BYTES_PER_WORD;
 		}
-#endif
-
-		/*
-		 * Constructors are not allowed to allocate memory from
-		 * the same cache which they are a constructor for.
-		 * Otherwise, deadlock. They must also be threaded.
-		 */
-		if (cachep->ctor)
+		if (cachep->ctor && !(cachep->flags & SLAB_POISON))
 			cachep->ctor(objp, cachep, ctor_flags);
-#if DEBUG
-		if (cachep->flags & SLAB_RED_ZONE)
-			objp -= BYTES_PER_WORD;
-		if (cachep->flags & SLAB_POISON)
-			/* need to poison the objs */
-			kmem_poison_obj(cachep, objp);
+
 		if (cachep->flags & SLAB_RED_ZONE) {
+			objp -= BYTES_PER_WORD;
 			if (*((unsigned long*)(objp)) != RED_MAGIC1)
 				BUG();
 			if (*((unsigned long*)(objp + cachep->objsize -
 					BYTES_PER_WORD)) != RED_MAGIC1)
 				BUG();
 		}
+#else
+		if (cachep->ctor)
+			cachep->ctor(objp, cachep, ctor_flags);
 #endif
 		slab_bufctl(slabp)[i] = i+1;
 	}
@@ -1126,6 +1183,31 @@
 	slabp->free = 0;
 }
 
+static void kmem_flagcheck(kmem_cache_t *cachep, int flags)
+{
+/* FIXME: disable in release
+#if DEBUG
+*/
+	if (flags & __GFP_WAIT)
+		might_sleep();
+
+	if (flags & SLAB_DMA) {
+		if (!(cachep->gfpflags & GFP_DMA))
+			BUG();
+	} else {
+		if (cachep->gfpflags & GFP_DMA)
+			BUG();
+	}
+/* #endif */
+}
+
+static inline void check_irq_off(void)
+{
+#if DEBUG
+	BUG_ON(!irqs_disabled());
+#endif
+}
+
 /*
  * Grow (by 1) the number of slabs within a cache.  This is called by
  * kmem_cache_alloc() when there are no active objs left in a cache.
@@ -1138,7 +1220,6 @@
 	size_t		 offset;
 	unsigned int	 i, local_flags;
 	unsigned long	 ctor_flags;
-	unsigned long	 save_flags;
 
 	/* Be lazy and only check for valid flags here,
  	 * keeping it out of the critical path in kmem_cache_alloc().
@@ -1148,15 +1229,6 @@
 	if (flags & SLAB_NO_GROW)
 		return 0;
 
-	/*
-	 * The test for missing atomic flag is performed here, rather than
-	 * the more obvious place, simply to reduce the critical path length
-	 * in kmem_cache_alloc(). If a caller is seriously mis-behaving they
-	 * will eventually be caught here (where it matters).
-	 */
-	if (in_interrupt() && (flags & __GFP_WAIT))
-		BUG();
-
 	ctor_flags = SLAB_CTOR_CONSTRUCTOR;
 	local_flags = (flags & SLAB_LEVEL_MASK);
 	if (!(local_flags & __GFP_WAIT))
@@ -1167,7 +1239,8 @@
 		ctor_flags |= SLAB_CTOR_ATOMIC;
 
 	/* About to mess with non-constant members - lock. */
-	spin_lock_irqsave(&cachep->spinlock, save_flags);
+	check_irq_off();
+	spin_lock(&cachep->spinlock);
 
 	/* Get colour for the slab, and cal the next value. */
 	offset = cachep->colour_next;
@@ -1177,17 +1250,19 @@
 	offset *= cachep->colour_off;
 	cachep->dflags |= DFLGS_GROWN;
 
-	cachep->growing++;
-	spin_unlock_irqrestore(&cachep->spinlock, save_flags);
+	spin_unlock(&cachep->spinlock);
+
+	if (local_flags & __GFP_WAIT)
+		local_irq_enable();
 
-	/* A series of memory allocations for a new slab.
-	 * Neither the cache-chain semaphore, or cache-lock, are
-	 * held, but the incrementing c_growing prevents this
-	 * cache from being reaped or shrunk.
-	 * Note: The cache could be selected in for reaping in
-	 * kmem_cache_reap(), but when the final test is made the
-	 * growing value will be seen.
+	/*
+	 * The test for missing atomic flag is performed here, rather than
+	 * the more obvious place, simply to reduce the critical path length
+	 * in kmem_cache_alloc(). If a caller is seriously mis-behaving they
+	 * will eventually be caught here (where it matters).
 	 */
+	kmem_flagcheck(cachep, flags);
+
 
 	/* Get mem for the objs. */
 	if (!(objp = kmem_getpages(cachep, flags)))
@@ -1210,62 +1285,107 @@
 
 	kmem_cache_init_objs(cachep, slabp, ctor_flags);
 
-	spin_lock_irqsave(&cachep->spinlock, save_flags);
-	cachep->growing--;
+	if (local_flags & __GFP_WAIT)
+		local_irq_disable();
+	check_irq_off();
+	spin_lock(&cachep->spinlock);
 
 	/* Make slab active. */
-	list_add_tail(&slabp->list, &cachep->slabs_free);
+	list_add_tail(&slabp->list, &(list3_data(cachep)->slabs_free));
 	STATS_INC_GROWN(cachep);
-	cachep->failures = 0;
-
-	spin_unlock_irqrestore(&cachep->spinlock, save_flags);
+	spin_unlock(&cachep->spinlock);
 	return 1;
 opps1:
 	kmem_freepages(cachep, objp);
 failed:
-	spin_lock_irqsave(&cachep->spinlock, save_flags);
-	cachep->growing--;
-	spin_unlock_irqrestore(&cachep->spinlock, save_flags);
 	return 0;
 }
 
 /*
  * Perform extra freeing checks:
- * - detect double free
  * - detect bad pointers.
- * Called with the cache-lock held.
+ * - POISON/RED_ZONE checking
+ * - destructor calls, for caches with POISON+dtor
  */
-
-#if DEBUG
-static int kmem_extra_free_checks (kmem_cache_t * cachep,
-			slab_t *slabp, void * objp)
+static inline void kfree_debugcheck(const void *objp)
 {
-	int i;
-	unsigned int objnr = (objp-slabp->s_mem)/cachep->objsize;
+#if DEBUG
+	struct page *page;
 
-	if (objnr >= cachep->num)
-		BUG();
-	if (objp != slabp->s_mem + objnr*cachep->objsize)
+	if (!virt_addr_valid(objp)) {
+		printk(KERN_ERR "kfree_debugcheck: out of range ptr %lxh.\n",
+			(unsigned long)objp);	
+		BUG();	
+	}
+	page = virt_to_page(objp);
+	if (!PageSlab(page)) {
+		printk(KERN_ERR "kfree_debugcheck: bad ptr %lxh.\n", (unsigned long)objp);
 		BUG();
+	}
+#endif 
+}
 
-	/* Check slab's freelist to see if this obj is there. */
-	for (i = slabp->free; i != BUFCTL_END; i = slab_bufctl(slabp)[i]) {
-		if (i == objnr)
+static inline void *kmem_cache_free_debugcheck (kmem_cache_t * cachep, void * objp)
+{
+#if DEBUG
+	struct page *page;
+	unsigned int objnr;
+	slab_t *slabp;
+
+	kfree_debugcheck(objp);
+	page = virt_to_page(objp);
+
+	BUG_ON(GET_PAGE_CACHE(page) != cachep);
+	slabp = GET_PAGE_SLAB(page);
+
+	if (cachep->flags & SLAB_RED_ZONE) {
+		objp -= BYTES_PER_WORD;
+		if (xchg((unsigned long *)objp, RED_MAGIC1) != RED_MAGIC2)
+			/* Either write before start, or a double free. */
+			BUG();
+		if (xchg((unsigned long *)(objp+cachep->objsize -
+				BYTES_PER_WORD), RED_MAGIC1) != RED_MAGIC2)
+			/* Either write past end, or a double free. */
 			BUG();
 	}
-	return 0;
-}
+
+	objnr = (objp-slabp->s_mem)/cachep->objsize;
+
+	BUG_ON(objnr >= cachep->num);
+	BUG_ON(objp != slabp->s_mem + objnr*cachep->objsize);
+
+	if (cachep->flags & SLAB_DEBUG_INITIAL) {
+		/* Need to call the slab's constructor so the
+		 * caller can perform a verify of its state (debugging).
+		 * Called without the cache-lock held.
+		 */
+		cachep->ctor(objp, cachep, SLAB_CTOR_CONSTRUCTOR|SLAB_CTOR_VERIFY);
+	}
+	if (cachep->flags & SLAB_POISON && cachep->dtor) {
+		/* we want to cache poison the object,
+		 * call the destruction callback
+		 */
+		cachep->dtor(objp, cachep, 0);
+	}
+	if (cachep->flags & SLAB_POISON) {
+		kmem_poison_obj(cachep, objp);
+	}
 #endif
+	return objp;
+}
 
-static inline void kmem_cache_alloc_head(kmem_cache_t *cachep, int flags)
+static inline void kmem_check_slabp(kmem_cache_t *cachep, slab_t *slabp)
 {
-	if (flags & SLAB_DMA) {
-		if (!(cachep->gfpflags & GFP_DMA))
-			BUG();
-	} else {
-		if (cachep->gfpflags & GFP_DMA)
-			BUG();
+#if DEBUG
+	int i;
+	int entries = 0;
+	/* Check slab's freelist to see if this obj is there. */
+	for (i = slabp->free; i != BUFCTL_END; i = slab_bufctl(slabp)[i]) {
+		entries++;
+		BUG_ON(entries > cachep->num);
 	}
+	BUG_ON(entries != cachep->num - slabp->inuse);
+#endif
 }
 
 static inline void * kmem_cache_alloc_one_tail (kmem_cache_t *cachep,
@@ -1282,209 +1402,135 @@
 	objp = slabp->s_mem + slabp->free*cachep->objsize;
 	slabp->free=slab_bufctl(slabp)[slabp->free];
 
-	if (unlikely(slabp->free == BUFCTL_END)) {
-		list_del(&slabp->list);
-		list_add(&slabp->list, &cachep->slabs_full);
-	}
-#if DEBUG
-	if (cachep->flags & SLAB_POISON)
-		if (kmem_check_poison_obj(cachep, objp))
-			BUG();
-	if (cachep->flags & SLAB_RED_ZONE) {
-		/* Set alloc red-zone, and check old one. */
-		if (xchg((unsigned long *)objp, RED_MAGIC2) !=
-							 RED_MAGIC1)
-			BUG();
-		if (xchg((unsigned long *)(objp+cachep->objsize -
-			  BYTES_PER_WORD), RED_MAGIC2) != RED_MAGIC1)
-			BUG();
-		objp += BYTES_PER_WORD;
-	}
-#endif
 	return objp;
 }
 
-/*
- * Returns a ptr to an obj in the given cache.
- * caller must guarantee synchronization
- * #define for the goto optimization 8-)
- */
-#define kmem_cache_alloc_one(cachep)				\
-({								\
-	struct list_head * slabs_partial, * entry;		\
-	slab_t *slabp;						\
-								\
-	slabs_partial = &(cachep)->slabs_partial;		\
-	entry = slabs_partial->next;				\
-	if (unlikely(entry == slabs_partial)) {			\
-		struct list_head * slabs_free;			\
-		slabs_free = &(cachep)->slabs_free;		\
-		entry = slabs_free->next;			\
-		if (unlikely(entry == slabs_free))		\
-			goto alloc_new_slab;			\
-		list_del(entry);				\
-		list_add(entry, slabs_partial);			\
-	}							\
-								\
-	slabp = list_entry(entry, slab_t, list);		\
-	kmem_cache_alloc_one_tail(cachep, slabp);		\
-})
+static inline void kmem_cache_alloc_listfixup(struct kmem_list3 *l3, slab_t *slabp)
+{
+	list_del(&slabp->list);
+	if (slabp->free == BUFCTL_END) {
+		list_add(&slabp->list, &l3->slabs_full);
+	} else {
+		list_add(&slabp->list, &l3->slabs_partial);
+	}
+}
 
-#ifdef CONFIG_SMP
-void* kmem_cache_alloc_batch(kmem_cache_t* cachep, int flags)
+static void* kmem_cache_alloc_refill(kmem_cache_t* cachep, int flags)
 {
-	int batchcount = cachep->batchcount;
-	cpucache_t* cc = cc_data(cachep);
+	int batchcount;
+	struct kmem_list3 *l3;
+	cpucache_t *cc;
+
+retry:
+	/* reload cache state after each grow:
+	 * it might have reenabled the cpu interrupts
+	 */
+	cc = cc_data(cachep);
+	batchcount = cc->batchcount;
+	l3 = list3_data(cachep);
 
+	check_irq_off();
 	spin_lock(&cachep->spinlock);
-	while (batchcount--) {
-		struct list_head * slabs_partial, * entry;
+	while (batchcount > 0) {
+		struct list_head *entry;
 		slab_t *slabp;
 		/* Get slab alloc is to come from. */
-		slabs_partial = &(cachep)->slabs_partial;
-		entry = slabs_partial->next;
-		if (unlikely(entry == slabs_partial)) {
-			struct list_head * slabs_free;
-			slabs_free = &(cachep)->slabs_free;
-			entry = slabs_free->next;
-			if (unlikely(entry == slabs_free))
-				break;
-			list_del(entry);
-			list_add(entry, slabs_partial);
+		entry = l3->slabs_partial.next;
+		if (entry == &l3->slabs_partial) {
+			entry = l3->slabs_free.next;
+			if (entry == &l3->slabs_free)
+				goto must_grow;
 		}
 
 		slabp = list_entry(entry, slab_t, list);
-		cc_entry(cc)[cc->avail++] =
+		kmem_check_slabp(cachep, slabp);
+		while (slabp->inuse < cachep->num && batchcount--)
+			cc_entry(cc)[cc->avail++] =
 				kmem_cache_alloc_one_tail(cachep, slabp);
+		kmem_check_slabp(cachep, slabp);
+		kmem_cache_alloc_listfixup(l3, slabp);
 	}
+
+must_grow:
 	spin_unlock(&cachep->spinlock);
 
 	if (cc->avail)
 		return cc_entry(cc)[--cc->avail];
+	
+	if(kmem_cache_grow(cachep, flags))
+		goto retry;
+
 	return NULL;
 }
+
+static inline void kmem_cache_alloc_debugcheck_before(kmem_cache_t *cachep, int flags)
+{
+#if DEBUG
+	kmem_flagcheck(cachep, flags);
 #endif
+}
+
+static inline void *kmem_cache_alloc_debugcheck_after (kmem_cache_t *cachep, unsigned long flags, void *objp)
+{
+#if DEBUG
+	if (cachep->flags & SLAB_POISON)
+		if (kmem_check_poison_obj(cachep, objp))
+			BUG();
+	if (cachep->flags & SLAB_RED_ZONE) {
+		/* Set alloc red-zone, and check old one. */
+		if (xchg((unsigned long *)objp, RED_MAGIC2) !=
+							 RED_MAGIC1)
+			BUG();
+		if (xchg((unsigned long *)(objp+cachep->objsize -
+			  BYTES_PER_WORD), RED_MAGIC2) != RED_MAGIC1)
+			BUG();
+		objp += BYTES_PER_WORD;
+		if (cachep->ctor) {
+			unsigned long	ctor_flags = SLAB_CTOR_CONSTRUCTOR;
+
+			if (!flags & __GFP_WAIT)
+				ctor_flags |= SLAB_CTOR_ATOMIC;
+
+			cachep->ctor(objp, cachep, ctor_flags);
+		}	
+	}
+#endif
+	return objp;
+}
+
 
 static inline void * __kmem_cache_alloc (kmem_cache_t *cachep, int flags)
 {
 	unsigned long save_flags;
 	void* objp;
+	cpucache_t *cc;
 
-	if (flags & __GFP_WAIT)
-		might_sleep();
+	kmem_cache_alloc_debugcheck_before(cachep, flags);
 
-	kmem_cache_alloc_head(cachep, flags);
-try_again:
 	local_irq_save(save_flags);
-#ifdef CONFIG_SMP
-	{
-		cpucache_t *cc = cc_data(cachep);
-
-		if (cc) {
-			if (cc->avail) {
-				STATS_INC_ALLOCHIT(cachep);
-				objp = cc_entry(cc)[--cc->avail];
-			} else {
-				STATS_INC_ALLOCMISS(cachep);
-				objp = kmem_cache_alloc_batch(cachep,flags);
-				local_irq_restore(save_flags);
-				if (!objp)
-					goto alloc_new_slab_nolock;
-				return objp;
-			}
-		} else {
-			spin_lock(&cachep->spinlock);
-			objp = kmem_cache_alloc_one(cachep);
-			spin_unlock(&cachep->spinlock);
-		}
+	cc = cc_data(cachep);
+	if (likely(cc->avail)) {
+		STATS_INC_ALLOCHIT(cachep);
+		objp = cc_entry(cc)[--cc->avail];
+	} else {
+		STATS_INC_ALLOCMISS(cachep);
+		objp = kmem_cache_alloc_refill(cachep, flags);
 	}
-#else
-	objp = kmem_cache_alloc_one(cachep);
-#endif
 	local_irq_restore(save_flags);
+	objp = kmem_cache_alloc_debugcheck_after(cachep, flags, objp);
 	return objp;
-alloc_new_slab:
-#ifdef CONFIG_SMP
-	spin_unlock(&cachep->spinlock);
-#endif
-	local_irq_restore(save_flags);
-#ifdef CONFIG_SMP
-alloc_new_slab_nolock:
-#endif
-	if (kmem_cache_grow(cachep, flags))
-		/* Someone may have stolen our objs.  Doesn't matter, we'll
-		 * just come back here again.
-		 */
-		goto try_again;
-	return NULL;
 }
 
-/*
- * Release an obj back to its cache. If the obj has a constructed
- * state, it should be in this state _before_ it is released.
- * - caller is responsible for the synchronization
+/* 
+ * NUMA: different approach needed if the spinlock is moved into
+ * the l3 structure
  */
-
-#if DEBUG
-# define CHECK_NR(pg)						\
-	do {							\
-		if (!virt_addr_valid(pg)) {			\
-			printk(KERN_ERR "kfree: out of range ptr %lxh.\n", \
-				(unsigned long)objp);		\
-			BUG();					\
-		} \
-	} while (0)
-# define CHECK_PAGE(addr)					\
-	do {							\
-		struct page *page = virt_to_page(addr);		\
-		CHECK_NR(addr);					\
-		if (!PageSlab(page)) {				\
-			printk(KERN_ERR "kfree: bad ptr %lxh.\n", \
-				(unsigned long)objp);		\
-			BUG();					\
-		}						\
-	} while (0)
-
-#else
-# define CHECK_PAGE(pg)	do { } while (0)
-#endif
-
 static inline void kmem_cache_free_one(kmem_cache_t *cachep, void *objp)
 {
 	slab_t* slabp;
 
-	CHECK_PAGE(objp);
-	/* reduces memory footprint
-	 *
-	if (OPTIMIZE(cachep))
-		slabp = (void*)((unsigned long)objp&(~(PAGE_SIZE-1)));
-	 else
-	 */
 	slabp = GET_PAGE_SLAB(virt_to_page(objp));
-
-#if DEBUG
-	if (cachep->flags & SLAB_DEBUG_INITIAL)
-		/* Need to call the slab's constructor so the
-		 * caller can perform a verify of its state (debugging).
-		 * Called without the cache-lock held.
-		 */
-		cachep->ctor(objp, cachep, SLAB_CTOR_CONSTRUCTOR|SLAB_CTOR_VERIFY);
-
-	if (cachep->flags & SLAB_RED_ZONE) {
-		objp -= BYTES_PER_WORD;
-		if (xchg((unsigned long *)objp, RED_MAGIC1) != RED_MAGIC2)
-			/* Either write before start, or a double free. */
-			BUG();
-		if (xchg((unsigned long *)(objp+cachep->objsize -
-				BYTES_PER_WORD), RED_MAGIC1) != RED_MAGIC2)
-			/* Either write past end, or a double free. */
-			BUG();
-	}
-	if (cachep->flags & SLAB_POISON)
-		kmem_poison_obj(cachep, objp);
-	if (kmem_extra_free_checks(cachep, slabp, objp))
-		return;
-#endif
+	list_del(&slabp->list);
 	{
 		unsigned int objnr = (objp-slabp->s_mem)/cachep->objsize;
 
@@ -1494,69 +1540,82 @@
 	STATS_DEC_ACTIVE(cachep);
 	
 	/* fixup slab chains */
-	{
-		int inuse = slabp->inuse;
-		if (unlikely(!--slabp->inuse)) {
-			/* Was partial or full, now empty. */
-			list_del(&slabp->list);
-/*			list_add(&slabp->list, &cachep->slabs_free); 		*/
-			if (unlikely(list_empty(&cachep->slabs_partial)))
-				list_add(&slabp->list, &cachep->slabs_partial);
-			else
-				kmem_slab_destroy(cachep, slabp);
-		} else if (unlikely(inuse == cachep->num)) {
-			/* Was full. */
-			list_del(&slabp->list);
-			list_add(&slabp->list, &cachep->slabs_partial);
-		}
+	if (unlikely(!--slabp->inuse)) {
+		list_add(&slabp->list, &list3_data_ptr(cachep, objp)->slabs_free);
+	} else {
+		/* Unconditionally move a slab to the end of the
+		 * partial list on free - maximum time for the
+		 * other objects to be freed, too.
+		 */
+		list_add_tail(&slabp->list, &list3_data_ptr(cachep, objp)->slabs_partial);
 	}
 }
 
-#ifdef CONFIG_SMP
-static inline void __free_block (kmem_cache_t* cachep,
-							void** objpp, int len)
+static inline void __free_block (kmem_cache_t* cachep, void** objpp, int len)
 {
 	for ( ; len > 0; len--, objpp++)
 		kmem_cache_free_one(cachep, *objpp);
 }
 
-static void free_block (kmem_cache_t* cachep, void** objpp, int len)
+
+static void kmem_cache_flusharray (kmem_cache_t* cachep, cpucache_t *cc)
 {
+	int batchcount;
+
+	batchcount = cc->batchcount;
+#if DEBUG
+	BUG_ON(!batchcount || batchcount > cc->avail);
+#endif
+	check_irq_off();
 	spin_lock(&cachep->spinlock);
-	__free_block(cachep, objpp, len);
+	__free_block(cachep, &cc_entry(cc)[0], batchcount);
+
+#if STATS
+	{
+		int i = 0;
+		struct list_head *p;
+		p = list3_data(cachep)->slabs_free.next;
+		while (p != &(list3_data(cachep)->slabs_free)) {
+			slab_t *slabp;
+
+			slabp = list_entry(p, slab_t, list);
+			BUG_ON(slabp->inuse);
+
+			i++;
+			p = p->next;
+		}
+		STATS_SET_FREEABLE(cachep, i);
+	}
+#endif
+
 	spin_unlock(&cachep->spinlock);
+	cc->avail -= batchcount;
+	memcpy(&cc_entry(cc)[0], &cc_entry(cc)[batchcount],
+			sizeof(void*)*cc->avail);
 }
-#endif
 
 /*
  * __kmem_cache_free
- * called with disabled ints
+ * Release an obj back to its cache. If the obj has a constructed
+ * state, it must be in this state _before_ it is released.
+ *
+ * Called with disabled ints.
  */
 static inline void __kmem_cache_free (kmem_cache_t *cachep, void* objp)
 {
-#ifdef CONFIG_SMP
-	cpucache_t *cc = cc_data(cachep);
+	cpucache_t *cc = cc_data_ptr(cachep, objp);
 
-	CHECK_PAGE(objp);
-	if (cc) {
-		int batchcount;
-		if (cc->avail < cc->limit) {
-			STATS_INC_FREEHIT(cachep);
-			cc_entry(cc)[cc->avail++] = objp;
-			return;
-		}
-		STATS_INC_FREEMISS(cachep);
-		batchcount = cachep->batchcount;
-		cc->avail -= batchcount;
-		free_block(cachep, &cc_entry(cc)[cc->avail], batchcount);
+	objp = kmem_cache_free_debugcheck(cachep, objp);
+
+	if (likely(cc->avail < cc->limit)) {
+		STATS_INC_FREEHIT(cachep);
 		cc_entry(cc)[cc->avail++] = objp;
 		return;
 	} else {
-		free_block(cachep, &objp, 1);
+		STATS_INC_FREEMISS(cachep);
+		kmem_cache_flusharray(cachep, cc);
+		cc_entry(cc)[cc->avail++] = objp;
 	}
-#else
-	kmem_cache_free_one(cachep, objp);
-#endif
 }
 
 /**
@@ -1600,6 +1659,13 @@
 	for (; csizep->cs_size; csizep++) {
 		if (size > csizep->cs_size)
 			continue;
+#if DEBUG
+		/* This happens if someone tries to call
+		 * kmem_cache_create(), or kmalloc(), before
+		 * the generic caches are initialized.
+		 */
+		BUG_ON(csizep->cs_cachep == NULL);
+#endif
 		return __kmem_cache_alloc(flags & GFP_DMA ?
 			 csizep->cs_dmacachep : csizep->cs_cachep, flags);
 	}
@@ -1617,11 +1683,6 @@
 void kmem_cache_free (kmem_cache_t *cachep, void *objp)
 {
 	unsigned long flags;
-#if DEBUG
-	CHECK_PAGE(objp);
-	if (cachep != GET_PAGE_CACHE(virt_to_page(objp)))
-		BUG();
-#endif
 
 	local_irq_save(flags);
 	__kmem_cache_free(cachep, objp);
@@ -1643,7 +1704,7 @@
 	if (!objp)
 		return;
 	local_irq_save(flags);
-	CHECK_PAGE(objp);
+	kfree_debugcheck(objp);
 	c = GET_PAGE_CACHE(virt_to_page(objp));
 	__kmem_cache_free(c, (void*)objp);
 	local_irq_restore(flags);
@@ -1674,86 +1735,114 @@
 	return (gfpflags & GFP_DMA) ? csizep->cs_dmacachep : csizep->cs_cachep;
 }
 
-#ifdef CONFIG_SMP
+/*
+ * Waits for all CPUs to execute func().
+ */
+static void smp_call_function_all_cpus(void (*func) (void *arg), void *arg)
+{
+	local_irq_disable();
+	func(arg);
+	local_irq_enable();
 
-/* called with cache_chain_sem acquired.  */
-static int kmem_tune_cpucache (kmem_cache_t* cachep, int limit, int batchcount)
+	if (smp_call_function(func, arg, 1, 1))
+		BUG();
+}
+
+static void do_drain(void *arg)
 {
-	ccupdate_struct_t new;
-	int i;
+	kmem_cache_t *cachep = (kmem_cache_t*)arg;
+	cpucache_t *cc;
 
-	/*
-	 * These are admin-provided, so we are more graceful.
-	 */
-	if (limit < 0)
-		return -EINVAL;
-	if (batchcount < 0)
-		return -EINVAL;
-	if (batchcount > limit)
-		return -EINVAL;
-	if (limit != 0 && !batchcount)
-		return -EINVAL;
+	cc = cc_data(cachep);
+	check_irq_off();
+	spin_lock(&cachep->spinlock);
+	__free_block(cachep, &cc_entry(cc)[0], cc->avail);
+	spin_unlock(&cachep->spinlock);
+	cc->avail = 0;
+}
+
+static void drain_cpu_caches(kmem_cache_t *cachep)
+{
+	smp_call_function_all_cpus(do_drain, cachep);
+}
+
+
+struct ccupdate_struct {
+	kmem_cache_t *cachep;
+	cpucache_t *new[NR_CPUS];
+};
+
+static void do_ccupdate_local(void *info)
+{
+	struct ccupdate_struct *new = (struct ccupdate_struct *)info;
+	cpucache_t *old;
+	old = cc_data(new->cachep);
+	
+	cc_data(new->cachep) = new->new[smp_processor_id()];
+	new->new[smp_processor_id()] = old;
+}
+
+
+static int do_tune_cpucache (kmem_cache_t* cachep, int limit, int batchcount)
+{
+	struct ccupdate_struct new;
+	int i;
 
 	memset(&new.new,0,sizeof(new.new));
-	if (limit) {
-		for (i = 0; i < NR_CPUS; i++) {
-			cpucache_t* ccnew;
-
-			ccnew = kmalloc(sizeof(void*)*limit+
-					sizeof(cpucache_t), GFP_KERNEL);
-			if (!ccnew) {
-				for (i--; i >= 0; i--) kfree(new.new[i]);
-				return -ENOMEM;
-			}
-			ccnew->limit = limit;
-			ccnew->avail = 0;
-			new.new[i] = ccnew;
+	for (i = 0; i < NR_CPUS; i++) {
+		cpucache_t* ccnew;
+
+		ccnew = kmalloc(sizeof(void*)*limit+
+				sizeof(cpucache_t), GFP_KERNEL);
+		if (!ccnew) {
+			for (i--; i >= 0; i--) kfree(new.new[i]);
+			return -ENOMEM;
 		}
+		ccnew->avail = 0;
+		ccnew->limit = limit;
+		ccnew->batchcount = batchcount;
+		new.new[i] = ccnew;
 	}
 	new.cachep = cachep;
+
+	smp_call_function_all_cpus(do_ccupdate_local, (void *)&new);
+	
 	spin_lock_irq(&cachep->spinlock);
 	cachep->batchcount = batchcount;
+	cachep->limit = limit;
 	spin_unlock_irq(&cachep->spinlock);
 
-	smp_call_function_all_cpus(do_ccupdate_local, (void *)&new);
-
 	for (i = 0; i < NR_CPUS; i++) {
 		cpucache_t* ccold = new.new[i];
 		if (!ccold)
 			continue;
 		local_irq_disable();
-		free_block(cachep, cc_entry(ccold), ccold->avail);
+		__free_block(cachep, cc_entry(ccold), ccold->avail);
 		local_irq_enable();
 		kfree(ccold);
 	}
 	return 0;
 }
 
-/* 
- * If slab debugging is enabled, don't batch slabs
- * on the per-cpu lists by defaults.
- */
+
 static void enable_cpucache (kmem_cache_t *cachep)
 {
-#ifndef CONFIG_DEBUG_SLAB
 	int err;
 	int limit;
 
-	/* FIXME: optimize */
 	if (cachep->objsize > PAGE_SIZE)
-		return;
-	if (cachep->objsize > 1024)
+		limit = 4;
+	else if (cachep->objsize > 1024)
 		limit = 60;
 	else if (cachep->objsize > 256)
 		limit = 124;
 	else
 		limit = 252;
 
-	err = kmem_tune_cpucache(cachep, limit, limit/2);
+	err = do_tune_cpucache(cachep, limit, limit/2);
 	if (err)
 		printk(KERN_ERR "enable_cpucache failed for %s, error %d.\n",
 					cachep->name, -err);
-#endif
 }
 
 static void enable_all_cpucaches (void)
@@ -1765,143 +1854,114 @@
 	p = &cache_cache.next;
 	do {
 		kmem_cache_t* cachep = list_entry(p, kmem_cache_t, next);
-
 		enable_cpucache(cachep);
 		p = cachep->next.next;
 	} while (p != &cache_cache.next);
 
 	up(&cache_chain_sem);
 }
-#endif
+
+#define REAP_SCANLEN	10
 
 /**
- * kmem_cache_reap - Reclaim memory from caches.
- * @gfp_mask: the type of memory required.
+ * cache_reap - Reclaim memory from caches.
  *
- * Called from do_try_to_free_pages() and __alloc_pages()
+ * Called from a timer, 10 times/second.
+ * Purpuse:
+ * - clear the per-cpu caches
+ * - return freeable pages to gfp.
  */
-int kmem_cache_reap (int gfp_mask)
+static int cache_reap (void)
 {
-	slab_t *slabp;
+	int todo;
 	kmem_cache_t *searchp;
-	kmem_cache_t *best_cachep;
-	unsigned int best_pages;
-	unsigned int best_len;
-	unsigned int scan;
-	int ret = 0;
 
-	if (gfp_mask & __GFP_WAIT)
-		down(&cache_chain_sem);
-	else
-		if (down_trylock(&cache_chain_sem))
-			return 0;
+	if (down_trylock(&cache_chain_sem))
+		return -1;
 
-	scan = REAP_SCANLEN;
-	best_len = 0;
-	best_pages = 0;
-	best_cachep = NULL;
+	todo = (g_cache_count+REAP_SCANLEN-1)/REAP_SCANLEN;
 	searchp = clock_searchp;
+
 	do {
-		unsigned int pages;
 		struct list_head* p;
 		unsigned int full_free;
+		cpucache_t *cc;
+		slab_t *slabp;
 
-		/* It's safe to test this without holding the cache-lock. */
 		if (searchp->flags & SLAB_NO_REAP)
 			goto next;
+
 		spin_lock_irq(&searchp->spinlock);
-		if (searchp->growing)
-			goto next_unlock;
 		if (searchp->dflags & DFLGS_GROWN) {
 			searchp->dflags &= ~DFLGS_GROWN;
 			goto next_unlock;
 		}
-#ifdef CONFIG_SMP
-		{
-			cpucache_t *cc = cc_data(searchp);
-			if (cc && cc->avail) {
-				__free_block(searchp, cc_entry(cc), cc->avail);
-				cc->avail = 0;
-			}
+		cc = cc_data(searchp);
+		if (cc && cc->avail) {
+			__free_block(searchp, cc_entry(cc), cc->avail);
+			cc->avail = 0;
 		}
-#endif
 
 		full_free = 0;
-		p = searchp->slabs_free.next;
-		while (p != &searchp->slabs_free) {
+		p = searchp->lists.slabs_free.next;
+		while (p != &searchp->lists.slabs_free) {
 			slabp = list_entry(p, slab_t, list);
-#if DEBUG
-			if (slabp->inuse)
-				BUG();
-#endif
+			BUG_ON(slabp->inuse);
+
 			full_free++;
 			p = p->next;
 		}
 
-		/*
-		 * Try to avoid slabs with constructors and/or
-		 * more than one page per slab (as it can be difficult
-		 * to get high orders from gfp()).
-		 */
-		pages = full_free * (1<<searchp->gfporder);
-		if (searchp->ctor)
-			pages = (pages*4+1)/5;
-		if (searchp->gfporder)
-			pages = (pages*4+1)/5;
-		if (pages > best_pages) {
-			best_cachep = searchp;
-			best_len = full_free;
-			best_pages = pages;
-			if (pages >= REAP_PERFECT) {
-				clock_searchp = list_entry(searchp->next.next,
-							kmem_cache_t,next);
-				goto perfect;
+		if(full_free) {
+			full_free = (full_free*4+1)/5;
+			while (full_free--) {
+				p = searchp->lists.slabs_free.next;
+				if (p == &searchp->lists.slabs_free)
+					break;
+				slabp = list_entry(p, slab_t, list);
+				BUG_ON(slabp->inuse);
+				list_del(&slabp->list);
+				STATS_INC_REAPED(searchp);
+
+				/* Safe to drop the lock. The slab is no longer
+				 * linked to the cache.
+				 * cachep cannot disappear, we hold
+				 * cache_chain_sem
+				 */
+				spin_unlock_irq(&searchp->spinlock);
+				kmem_slab_destroy(searchp, slabp);
+				spin_lock_irq(&searchp->spinlock);
 			}
 		}
+
 next_unlock:
 		spin_unlock_irq(&searchp->spinlock);
 next:
 		searchp = list_entry(searchp->next.next,kmem_cache_t,next);
-	} while (--scan && searchp != clock_searchp);
+	} while (--todo);
 
 	clock_searchp = searchp;
+	up(&cache_chain_sem);
+	return 0;
+}
 
-	if (!best_cachep)
-		/* couldn't find anything to reap */
-		goto out;
-
-	spin_lock_irq(&best_cachep->spinlock);
-perfect:
-	/* free only 50% of the free slabs */
-	best_len = (best_len + 1)/2;
-	for (scan = 0; scan < best_len; scan++) {
-		struct list_head *p;
+static void reap_timer_fnc(unsigned long data)
+{
+	unsigned long expires;
 
-		if (best_cachep->growing)
-			break;
-		p = best_cachep->slabs_free.prev;
-		if (p == &best_cachep->slabs_free)
-			break;
-		slabp = list_entry(p,slab_t,list);
-#if DEBUG
-		if (slabp->inuse)
-			BUG();
-#endif
-		list_del(&slabp->list);
-		STATS_INC_REAPED(best_cachep);
+	// Optimization question: fewer reaps
+	// means less probability for unnessary
+	// cpucache drain/refill cycles
+	//
+	// OTHO a rare flush means that e.g.
+	// 4 order=5 objects could sit in the per-cpu array
+	if(cache_reap() < 0)
+		expires = 1;
+	else
+		expires = 2*HZ/REAP_SCANLEN;
 
-		/* Safe to drop the lock. The slab is no longer linked to the
-		 * cache.
-		 */
-		spin_unlock_irq(&best_cachep->spinlock);
-		kmem_slab_destroy(best_cachep, slabp);
-		spin_lock_irq(&best_cachep->spinlock);
-	}
-	spin_unlock_irq(&best_cachep->spinlock);
-	ret = scan * (1 << best_cachep->gfporder);
-out:
-	up(&cache_chain_sem);
-	return ret;
+	reap_timer.expires = jiffies + expires;
+	add_timer(&reap_timer);
 }
 
 #ifdef CONFIG_PROC_FS
@@ -1954,13 +2014,10 @@
 		 * Output format version, so at least we can change it
 		 * without _too_ many complaints.
 		 */
-		seq_puts(m, "slabinfo - version: 1.1"
+		seq_puts(m, "slabinfo - version: 1.2"
 #if STATS
 				" (statistics)"
 #endif
-#ifdef CONFIG_SMP
-				" (SMP)"
-#endif
 				"\n");
 		return 0;
 	}
@@ -1968,21 +2025,21 @@
 	spin_lock_irq(&cachep->spinlock);
 	active_objs = 0;
 	num_slabs = 0;
-	list_for_each(q,&cachep->slabs_full) {
+	list_for_each(q,&cachep->lists.slabs_full) {
 		slabp = list_entry(q, slab_t, list);
 		if (slabp->inuse != cachep->num)
 			BUG();
 		active_objs += cachep->num;
 		active_slabs++;
 	}
-	list_for_each(q,&cachep->slabs_partial) {
+	list_for_each(q,&cachep->lists.slabs_partial) {
 		slabp = list_entry(q, slab_t, list);
-		if (slabp->inuse == cachep->num)
+		if (slabp->inuse == cachep->num || !slabp->inuse)
 			BUG();
 		active_objs += slabp->inuse;
 		active_slabs++;
 	}
-	list_for_each(q,&cachep->slabs_free) {
+	list_for_each(q,&cachep->lists.slabs_free) {
 		slabp = list_entry(q, slab_t, list);
 		if (slabp->inuse)
 			BUG();
@@ -2007,19 +2064,6 @@
 		name, active_objs, num_objs, cachep->objsize,
 		active_slabs, num_slabs, (1<<cachep->gfporder));
 
-#if STATS
-	{
-		unsigned long errors = cachep->errors;
-		unsigned long high = cachep->high_mark;
-		unsigned long grown = cachep->grown;
-		unsigned long reaped = cachep->reaped;
-		unsigned long allocs = cachep->num_allocations;
-
-		seq_printf(m, " : %6lu %7lu %5lu %4lu %4lu",
-				high, allocs, grown, reaped, errors);
-	}
-#endif
-#ifdef CONFIG_SMP
 	{
 		unsigned int batchcount = cachep->batchcount;
 		unsigned int limit;
@@ -2030,13 +2074,21 @@
 			limit = 0;
 		seq_printf(m, " : %4u %4u", limit, batchcount);
 	}
-#endif
-#if STATS && defined(CONFIG_SMP)
+#if STATS
 	{
+		unsigned long high = cachep->high_mark;
+		unsigned long allocs = cachep->num_allocations;
+		unsigned long grown = cachep->grown;
+		unsigned long reaped = cachep->reaped;
+		unsigned long errors = cachep->errors;
+		unsigned long max_freeable = cachep->max_freeable;
 		unsigned long allochit = atomic_read(&cachep->allochit);
 		unsigned long allocmiss = atomic_read(&cachep->allocmiss);
 		unsigned long freehit = atomic_read(&cachep->freehit);
 		unsigned long freemiss = atomic_read(&cachep->freemiss);
+
+		seq_printf(m, " : %6lu %7lu %5lu %4lu %4lu %4lu",
+				high, allocs, grown, reaped, errors, max_freeable);
 		seq_printf(m, " : %6lu %6lu %6lu %6lu",
 				allochit, allocmiss, freehit, freemiss);
 	}
@@ -2078,7 +2130,6 @@
 ssize_t slabinfo_write(struct file *file, const char *buffer,
 				size_t count, loff_t *ppos)
 {
-#ifdef CONFIG_SMP
 	char kbuf[MAX_SLABINFO_WRITE+1], *tmp;
 	int limit, batchcount, res;
 	struct list_head *p;
@@ -2106,7 +2157,13 @@
 		kmem_cache_t *cachep = list_entry(p, kmem_cache_t, next);
 
 		if (!strcmp(cachep->name, kbuf)) {
-			res = kmem_tune_cpucache(cachep, limit, batchcount);
+			if (limit < 1 ||
+			    batchcount < 1 ||
+			    batchcount > limit) {
+				res = -EINVAL;
+			} else {
+				res = do_tune_cpucache(cachep, limit, batchcount);
+			}
 			break;
 		}
 	}
@@ -2114,8 +2171,5 @@
 	if (res >= 0)
 		res = count;
 	return res;
-#else
-	return -EINVAL;
-#endif
 }
 #endif



--------------040207010207030008060802--


