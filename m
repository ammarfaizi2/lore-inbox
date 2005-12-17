Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964998AbVLQW56@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964998AbVLQW56 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Dec 2005 17:57:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965000AbVLQW56
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Dec 2005 17:57:58 -0500
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:1731 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S964998AbVLQW55 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Dec 2005 17:57:57 -0500
Subject: Re: 2.6.15-rc5-rt2 slowness
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Gunter Ohrner <G.Ohrner@post.rwth-aachen.de>,
       john stultz <johnstul@us.ibm.com>
In-Reply-To: <1134790400.13138.160.camel@localhost.localdomain>
References: <dnu8ku$ie4$1@sea.gmane.org>
	 <1134790400.13138.160.camel@localhost.localdomain>
Content-Type: text/plain
Date: Sat, 17 Dec 2005 17:57:31 -0500
Message-Id: <1134860251.13138.193.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo,

I ported your old changes of 2.6.14-rt22 of mm/slab.c to 2.6.15-rc5-rt2
and tried it out.  I believe that this confirms that the SLOB _is_ the
problem in the slowness.  Booting with this slab patch, gives the old
speeds that we use to have.

Now, is the solution to bring the SLOB up to par with the SLAB, or to
make the SLAB as close to possible to the mainline (why remove NUMA?)
and keep it for PREEMPT_RT?

Below is the port of the slab changes if anyone else would like to see
if this speeds things up for them.

-- Steve

Index: linux-2.6.15-rc5-rt2/init/Kconfig
===================================================================
--- linux-2.6.15-rc5-rt2.orig/init/Kconfig	2005-12-17 14:09:22.000000000 -0500
+++ linux-2.6.15-rc5-rt2/init/Kconfig	2005-12-17 14:09:41.000000000 -0500
@@ -402,7 +402,7 @@
 	default y
 	bool "Use full SLAB allocator" if EMBEDDED
 	# we switch to the SLOB on PREEMPT_RT
-	depends on !PREEMPT_RT
+#	depends on !PREEMPT_RT
 	help
 	  Disabling this replaces the advanced SLAB allocator and
 	  kmalloc support with the drastically simpler SLOB allocator.
Index: linux-2.6.15-rc5-rt2/mm/slab.c
===================================================================
--- linux-2.6.15-rc5-rt2.orig/mm/slab.c	2005-12-17 16:44:10.000000000 -0500
+++ linux-2.6.15-rc5-rt2/mm/slab.c	2005-12-17 17:27:30.000000000 -0500
@@ -75,15 +75,6 @@
  *
  *	At present, each engine can be growing a cache.  This should be blocked.
  *
- * 15 March 2005. NUMA slab allocator.
- *	Shai Fultheim <shai@scalex86.org>.
- *	Shobhit Dayal <shobhit@calsoftinc.com>
- *	Alok N Kataria <alokk@calsoftinc.com>
- *	Christoph Lameter <christoph@lameter.com>
- *
- *	Modified the slab allocator to be node aware on NUMA systems.
- *	Each node has its own list of partial, free and full slabs.
- *	All object allocations for a node occur from node specific slab lists.
  */
 
 #include	<linux/config.h>
@@ -102,7 +93,6 @@
 #include	<linux/module.h>
 #include	<linux/rcupdate.h>
 #include	<linux/string.h>
-#include	<linux/nodemask.h>
 
 #include	<asm/uaccess.h>
 #include	<asm/cacheflush.h>
@@ -222,7 +212,6 @@
 	void			*s_mem;		/* including colour offset */
 	unsigned int		inuse;		/* num of objs active in slab */
 	kmem_bufctl_t		free;
-	unsigned short          nodeid;
 };
 
 /*
@@ -250,6 +239,7 @@
 /*
  * struct array_cache
  *
+ * Per cpu structures
  * Purpose:
  * - LIFO ordering, to hand out cache-warm objects from _alloc
  * - reduce the number of linked list operations
@@ -264,13 +254,6 @@
 	unsigned int limit;
 	unsigned int batchcount;
 	unsigned int touched;
-	spinlock_t lock;
-	void *entry[0];		/*
-				 * Must have this definition in here for the proper
-				 * alignment of array_cache. Also simplifies accessing
-				 * the entries.
-				 * [0] is for gcc 2.95. It should really be [].
-				 */
 };
 
 /* bootstrap: The caches do not work without cpuarrays anymore,
@@ -283,84 +266,34 @@
 };
 
 /*
- * The slab lists for all objects.
+ * The slab lists of all objects.
+ * Hopefully reduce the internal fragmentation
+ * NUMA: The spinlock could be moved from the kmem_cache_t
+ * into this structure, too. Figure out what causes
+ * fewer cross-node spinlock operations.
  */
 struct kmem_list3 {
 	struct list_head	slabs_partial;	/* partial list first, better asm code */
 	struct list_head	slabs_full;
 	struct list_head	slabs_free;
 	unsigned long	free_objects;
-	unsigned long	next_reap;
 	int		free_touched;
-	unsigned int 	free_limit;
-	spinlock_t      list_lock;
-	struct array_cache	*shared;	/* shared per node */
-	struct array_cache	**alien;	/* on other nodes */
+	unsigned long	next_reap;
+	struct array_cache	*shared;
 };
 
-/*
- * Need this for bootstrapping a per node allocator.
- */
-#define NUM_INIT_LISTS (2 * MAX_NUMNODES + 1)
-struct kmem_list3 __initdata initkmem_list3[NUM_INIT_LISTS];
-#define	CACHE_CACHE 0
-#define	SIZE_AC 1
-#define	SIZE_L3 (1 + MAX_NUMNODES)
-
-/*
- * This function must be completely optimized away if
- * a constant is passed to it. Mostly the same as
- * what is in linux/slab.h except it returns an
- * index.
- */
-static __always_inline int index_of(const size_t size)
-{
-	if (__builtin_constant_p(size)) {
-		int i = 0;
-
-#define CACHE(x) \
-	if (size <=x) \
-		return i; \
-	else \
-		i++;
-#include "linux/kmalloc_sizes.h"
-#undef CACHE
-		{
-			extern void __bad_size(void);
-			__bad_size();
-		}
-	} else
-		BUG();
-	return 0;
-}
-
-#define INDEX_AC index_of(sizeof(struct arraycache_init))
-#define INDEX_L3 index_of(sizeof(struct kmem_list3))
-
-static inline void kmem_list3_init(struct kmem_list3 *parent)
-{
-	INIT_LIST_HEAD(&parent->slabs_full);
-	INIT_LIST_HEAD(&parent->slabs_partial);
-	INIT_LIST_HEAD(&parent->slabs_free);
-	parent->shared = NULL;
-	parent->alien = NULL;
-	spin_lock_init(&parent->list_lock);
-	parent->free_objects = 0;
-	parent->free_touched = 0;
-}
-
-#define MAKE_LIST(cachep, listp, slab, nodeid)	\
-	do {	\
-		INIT_LIST_HEAD(listp);		\
-		list_splice(&(cachep->nodelists[nodeid]->slab), listp); \
-	} while (0)
-
-#define	MAKE_ALL_LISTS(cachep, ptr, nodeid)			\
-	do {					\
-	MAKE_LIST((cachep), (&(ptr)->slabs_full), slabs_full, nodeid);	\
-	MAKE_LIST((cachep), (&(ptr)->slabs_partial), slabs_partial, nodeid); \
-	MAKE_LIST((cachep), (&(ptr)->slabs_free), slabs_free, nodeid);	\
-	} while (0)
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
 
 /*
  * kmem_cache_t
@@ -373,12 +306,13 @@
 	struct array_cache	*array[NR_CPUS];
 	unsigned int		batchcount;
 	unsigned int		limit;
-	unsigned int 		shared;
-	unsigned int		objsize;
 /* 2) touched by every alloc & free from the backend */
-	struct kmem_list3	*nodelists[MAX_NUMNODES];
+	struct kmem_list3	lists;
+	/* NUMA: kmem_3list_t	*nodelists[MAX_NUMNODES] */
+	unsigned int		objsize;
 	unsigned int	 	flags;	/* constant flags */
 	unsigned int		num;	/* # of objs per slab */
+	unsigned int		free_limit; /* upper limit of objects in the lists */
 	spinlock_t		spinlock;
 
 /* 3) cache_grow/shrink */
@@ -415,7 +349,6 @@
 	unsigned long 		errors;
 	unsigned long		max_freeable;
 	unsigned long		node_allocs;
-	unsigned long		node_frees;
 	atomic_t		allochit;
 	atomic_t		allocmiss;
 	atomic_t		freehit;
@@ -451,7 +384,6 @@
 				} while (0)
 #define	STATS_INC_ERR(x)	((x)->errors++)
 #define	STATS_INC_NODEALLOCS(x)	((x)->node_allocs++)
-#define	STATS_INC_NODEFREES(x)	((x)->node_frees++)
 #define	STATS_SET_FREEABLE(x, i) \
 				do { if ((x)->max_freeable < i) \
 					(x)->max_freeable = i; \
@@ -470,7 +402,6 @@
 #define	STATS_SET_HIGH(x)	do { } while (0)
 #define	STATS_INC_ERR(x)	do { } while (0)
 #define	STATS_INC_NODEALLOCS(x)	do { } while (0)
-#define	STATS_INC_NODEFREES(x)	do { } while (0)
 #define	STATS_SET_FREEABLE(x, i) \
 				do { } while (0)
 
@@ -618,9 +549,9 @@
 
 /* internal cache of cache description objs */
 static kmem_cache_t cache_cache = {
+	.lists		= LIST3_INIT(cache_cache.lists),
 	.batchcount	= 1,
 	.limit		= BOOT_CPUCACHE_ENTRIES,
-	.shared		= 1,
 	.objsize	= sizeof(kmem_cache_t),
 	.flags		= SLAB_NO_REAP,
 	.spinlock	= SPIN_LOCK_UNLOCKED(cache_cache.spinlock),
@@ -641,6 +572,7 @@
  * SLAB_RECLAIM_ACCOUNT turns this on per-slab
  */
 atomic_t slab_reclaim_pages;
+EXPORT_SYMBOL(slab_reclaim_pages);
 
 /*
  * chicken and egg problem: delay the per-cpu array allocation
@@ -648,24 +580,28 @@
  */
 static enum {
 	NONE,
-	PARTIAL_AC,
-	PARTIAL_L3,
+	PARTIAL,
 	FULL
 } g_cpucache_up;
 
 static DEFINE_PER_CPU(struct work_struct, reap_work);
 
-static void free_block(kmem_cache_t* cachep, void** objpp, int len, int node);
+static void free_block(kmem_cache_t* cachep, void** objpp, int len);
 static void enable_cpucache (kmem_cache_t *cachep);
 static void cache_reap (void *unused);
-static int __node_shrink(kmem_cache_t *cachep, int node);
 
-static inline struct array_cache *ac_data(kmem_cache_t *cachep)
+static inline void **ac_entry(struct array_cache *ac)
 {
-	return cachep->array[smp_processor_id()];
+	return (void**)(ac+1);
 }
 
-static inline kmem_cache_t *__find_general_cachep(size_t size, gfp_t gfpflags)
+static inline struct array_cache *ac_data(kmem_cache_t *cachep, int cpu)
+{
+	return cachep->array[cpu];
+}
+
+static inline kmem_cache_t *__find_general_cachep(size_t size,
+						unsigned int __nocast gfpflags)
 {
 	struct cache_sizes *csizep = malloc_sizes;
 
@@ -674,13 +610,13 @@
  	* kmem_cache_create(), or __kmalloc(), before
  	* the generic caches are initialized.
  	*/
-	BUG_ON(malloc_sizes[INDEX_AC].cs_cachep == NULL);
+	BUG_ON(csizep->cs_cachep == NULL);
 #endif
 	while (size > csizep->cs_size)
 		csizep++;
 
 	/*
-	 * Really subtle: The last entry with cs->cs_size==ULONG_MAX
+	 * Really subtile: The last entry with cs->cs_size==ULONG_MAX
 	 * has cs_{dma,}cachep==NULL. Thus no special case
 	 * for large kmalloc calls required.
 	 */
@@ -689,7 +625,8 @@
 	return csizep->cs_cachep;
 }
 
-kmem_cache_t *kmem_find_general_cachep(size_t size, gfp_t gfpflags)
+kmem_cache_t *kmem_find_general_cachep(size_t size,
+		unsigned int __nocast gfpflags)
 {
 	return __find_general_cachep(size, gfpflags);
 }
@@ -754,160 +691,48 @@
 	}
 }
 
-static struct array_cache *alloc_arraycache(int node, int entries,
+static struct array_cache *alloc_arraycache(int cpu, int entries,
 						int batchcount)
 {
 	int memsize = sizeof(void*)*entries+sizeof(struct array_cache);
 	struct array_cache *nc = NULL;
 
-	nc = kmalloc_node(memsize, GFP_KERNEL, node);
+	if (cpu == -1)
+		nc = kmalloc(memsize, GFP_KERNEL);
+	else
+		nc = kmalloc_node(memsize, GFP_KERNEL, cpu_to_node(cpu));
+
 	if (nc) {
 		nc->avail = 0;
 		nc->limit = entries;
 		nc->batchcount = batchcount;
 		nc->touched = 0;
-		spin_lock_init(&nc->lock);
 	}
 	return nc;
 }
 
-#ifdef CONFIG_NUMA
-static inline struct array_cache **alloc_alien_cache(int node, int limit)
-{
-	struct array_cache **ac_ptr;
-	int memsize = sizeof(void*)*MAX_NUMNODES;
-	int i;
-
-	if (limit > 1)
-		limit = 12;
-	ac_ptr = kmalloc_node(memsize, GFP_KERNEL, node);
-	if (ac_ptr) {
-		for_each_node(i) {
-			if (i == node || !node_online(i)) {
-				ac_ptr[i] = NULL;
-				continue;
-			}
-			ac_ptr[i] = alloc_arraycache(node, limit, 0xbaadf00d);
-			if (!ac_ptr[i]) {
-				for (i--; i <=0; i--)
-					kfree(ac_ptr[i]);
-				kfree(ac_ptr);
-				return NULL;
-			}
-		}
-	}
-	return ac_ptr;
-}
-
-static inline void free_alien_cache(struct array_cache **ac_ptr)
-{
-	int i;
-
-	if (!ac_ptr)
-		return;
-
-	for_each_node(i)
-		kfree(ac_ptr[i]);
-
-	kfree(ac_ptr);
-}
-
-static inline void __drain_alien_cache(kmem_cache_t *cachep, struct array_cache *ac, int node)
-{
-	struct kmem_list3 *rl3 = cachep->nodelists[node];
-
-	if (ac->avail) {
-		spin_lock(&rl3->list_lock);
-		free_block(cachep, ac->entry, ac->avail, node);
-		ac->avail = 0;
-		spin_unlock(&rl3->list_lock);
-	}
-}
-
-static void drain_alien_cache(kmem_cache_t *cachep, struct kmem_list3 *l3)
-{
-	int i=0;
-	struct array_cache *ac;
-	unsigned long flags;
-
-	for_each_online_node(i) {
-		ac = l3->alien[i];
-		if (ac) {
-			spin_lock_irqsave(&ac->lock, flags);
-			__drain_alien_cache(cachep, ac, i);
-			spin_unlock_irqrestore(&ac->lock, flags);
-		}
-	}
-}
-#else
-#define alloc_alien_cache(node, limit) do { } while (0)
-#define free_alien_cache(ac_ptr) do { } while (0)
-#define drain_alien_cache(cachep, l3) do { } while (0)
-#endif
-
 static int __devinit cpuup_callback(struct notifier_block *nfb,
 				  unsigned long action, void *hcpu)
 {
 	long cpu = (long)hcpu;
 	kmem_cache_t* cachep;
-	struct kmem_list3 *l3 = NULL;
-	int node = cpu_to_node(cpu);
-	int memsize = sizeof(struct kmem_list3);
-	struct array_cache *nc = NULL;
 
 	switch (action) {
 	case CPU_UP_PREPARE:
 		down(&cache_chain_sem);
-		/* we need to do this right in the beginning since
-		 * alloc_arraycache's are going to use this list.
-		 * kmalloc_node allows us to add the slab to the right
-		 * kmem_list3 and not this cpu's kmem_list3
-		 */
-
 		list_for_each_entry(cachep, &cache_chain, next) {
-			/* setup the size64 kmemlist for cpu before we can
-			 * begin anything. Make sure some other cpu on this
-			 * node has not already allocated this
-			 */
-			if (!cachep->nodelists[node]) {
-				if (!(l3 = kmalloc_node(memsize,
-						GFP_KERNEL, node)))
-					goto bad;
-				kmem_list3_init(l3);
-				l3->next_reap = jiffies + REAPTIMEOUT_LIST3 +
-				  ((unsigned long)cachep)%REAPTIMEOUT_LIST3;
-
-				cachep->nodelists[node] = l3;
-			}
-
-			spin_lock_irq(&cachep->nodelists[node]->list_lock);
-			cachep->nodelists[node]->free_limit =
-				(1 + nr_cpus_node(node)) *
-				cachep->batchcount + cachep->num;
-			spin_unlock_irq(&cachep->nodelists[node]->list_lock);
-		}
+			struct array_cache *nc;
 
-		/* Now we can go ahead with allocating the shared array's
-		  & array cache's */
-		list_for_each_entry(cachep, &cache_chain, next) {
-			nc = alloc_arraycache(node, cachep->limit,
-					cachep->batchcount);
+			nc = alloc_arraycache(cpu, cachep->limit, cachep->batchcount);
 			if (!nc)
 				goto bad;
+
+			spin_lock_irq(&cachep->spinlock);
 			cachep->array[cpu] = nc;
+			cachep->free_limit = (1+num_online_cpus())*cachep->batchcount
+						+ cachep->num;
+			spin_unlock_irq(&cachep->spinlock);
 
-			l3 = cachep->nodelists[node];
-			BUG_ON(!l3);
-			if (!l3->shared) {
-				if (!(nc = alloc_arraycache(node,
-					cachep->shared*cachep->batchcount,
-					0xbaadf00d)))
-					goto  bad;
-
-				/* we are serialised from CPU_DEAD or
-				  CPU_UP_CANCELLED by the cpucontrol lock */
-				l3->shared = nc;
-			}
 		}
 		up(&cache_chain_sem);
 		break;
@@ -922,51 +747,13 @@
 
 		list_for_each_entry(cachep, &cache_chain, next) {
 			struct array_cache *nc;
-			cpumask_t mask;
 
-			mask = node_to_cpumask(node);
 			spin_lock_irq(&cachep->spinlock);
 			/* cpu is dead; no one can alloc from it. */
 			nc = cachep->array[cpu];
 			cachep->array[cpu] = NULL;
-			l3 = cachep->nodelists[node];
-
-			if (!l3)
-				goto unlock_cache;
-
-			spin_lock(&l3->list_lock);
-
-			/* Free limit for this kmem_list3 */
-			l3->free_limit -= cachep->batchcount;
-			if (nc)
-				free_block(cachep, nc->entry, nc->avail, node);
-
-			if (!cpus_empty(mask)) {
-                                spin_unlock(&l3->list_lock);
-                                goto unlock_cache;
-                        }
-
-			if (l3->shared) {
-				free_block(cachep, l3->shared->entry,
-						l3->shared->avail, node);
-				kfree(l3->shared);
-				l3->shared = NULL;
-			}
-			if (l3->alien) {
-				drain_alien_cache(cachep, l3);
-				free_alien_cache(l3->alien);
-				l3->alien = NULL;
-			}
-
-			/* free slabs belonging to this node */
-			if (__node_shrink(cachep, node)) {
-				cachep->nodelists[node] = NULL;
-				spin_unlock(&l3->list_lock);
-				kfree(l3);
-			} else {
-				spin_unlock(&l3->list_lock);
-			}
-unlock_cache:
+			cachep->free_limit -= cachep->batchcount;
+			free_block(cachep, ac_entry(nc), nc->avail);
 			spin_unlock_irq(&cachep->spinlock);
 			kfree(nc);
 		}
@@ -982,25 +769,6 @@
 
 static struct notifier_block cpucache_notifier = { &cpuup_callback, NULL, 0 };
 
-/*
- * swap the static kmem_list3 with kmalloced memory
- */
-static void init_list(kmem_cache_t *cachep, struct kmem_list3 *list,
-		int nodeid)
-{
-	struct kmem_list3 *ptr;
-
-	BUG_ON(cachep->nodelists[nodeid] != list);
-	ptr = kmalloc_node(sizeof(struct kmem_list3), GFP_KERNEL, nodeid);
-	BUG_ON(!ptr);
-
-	local_irq_disable();
-	memcpy(ptr, list, sizeof(struct kmem_list3));
-	MAKE_ALL_LISTS(cachep, ptr, nodeid);
-	cachep->nodelists[nodeid] = ptr;
-	local_irq_enable();
-}
-
 /* Initialisation.
  * Called after the gfp() functions have been enabled, and before smp_init().
  */
@@ -1009,13 +777,6 @@
 	size_t left_over;
 	struct cache_sizes *sizes;
 	struct cache_names *names;
-	int i;
-
-	for (i = 0; i < NUM_INIT_LISTS; i++) {
-		kmem_list3_init(&initkmem_list3[i]);
-		if (i < MAX_NUMNODES)
-			cache_cache.nodelists[i] = NULL;
-	}
 
 	/*
 	 * Fragmentation resistance on low memory - only use bigger
@@ -1024,24 +785,21 @@
 	if (num_physpages > (32 << 20) >> PAGE_SHIFT)
 		slab_break_gfp_order = BREAK_GFP_ORDER_HI;
 
+
 	/* Bootstrap is tricky, because several objects are allocated
 	 * from caches that do not exist yet:
 	 * 1) initialize the cache_cache cache: it contains the kmem_cache_t
 	 *    structures of all caches, except cache_cache itself: cache_cache
 	 *    is statically allocated.
-	 *    Initially an __init data area is used for the head array and the
-	 *    kmem_list3 structures, it's replaced with a kmalloc allocated
-	 *    array at the end of the bootstrap.
+	 *    Initially an __init data area is used for the head array, it's
+	 *    replaced with a kmalloc allocated array at the end of the bootstrap.
 	 * 2) Create the first kmalloc cache.
-	 *    The kmem_cache_t for the new cache is allocated normally.
-	 *    An __init data area is used for the head array.
-	 * 3) Create the remaining kmalloc caches, with minimally sized
-	 *    head arrays.
+	 *    The kmem_cache_t for the new cache is allocated normally. An __init
+	 *    data area is used for the head array.
+	 * 3) Create the remaining kmalloc caches, with minimally sized head arrays.
 	 * 4) Replace the __init data head arrays for cache_cache and the first
 	 *    kmalloc cache with kmalloc allocated arrays.
-	 * 5) Replace the __init data for kmem_list3 for cache_cache and
-	 *    the other cache's with kmalloc allocated memory.
-	 * 6) Resize the head arrays of the kmalloc caches to their final sizes.
+	 * 5) Resize the head arrays of the kmalloc caches to their final sizes.
 	 */
 
 	/* 1) create the cache_cache */
@@ -1050,7 +808,6 @@
 	list_add(&cache_cache.next, &cache_chain);
 	cache_cache.colour_off = cache_line_size();
 	cache_cache.array[smp_processor_id()] = &initarray_cache.cache;
-	cache_cache.nodelists[numa_node_id()] = &initkmem_list3[CACHE_CACHE];
 
 	cache_cache.objsize = ALIGN(cache_cache.objsize, cache_line_size());
 
@@ -1068,33 +825,15 @@
 	sizes = malloc_sizes;
 	names = cache_names;
 
-	/* Initialize the caches that provide memory for the array cache
-	 * and the kmem_list3 structures first.
-	 * Without this, further allocations will bug
-	 */
-
-	sizes[INDEX_AC].cs_cachep = kmem_cache_create(names[INDEX_AC].name,
-				sizes[INDEX_AC].cs_size, ARCH_KMALLOC_MINALIGN,
-				(ARCH_KMALLOC_FLAGS | SLAB_PANIC), NULL, NULL);
-
-	if (INDEX_AC != INDEX_L3)
-		sizes[INDEX_L3].cs_cachep =
-			kmem_cache_create(names[INDEX_L3].name,
-				sizes[INDEX_L3].cs_size, ARCH_KMALLOC_MINALIGN,
-				(ARCH_KMALLOC_FLAGS | SLAB_PANIC), NULL, NULL);
-
 	while (sizes->cs_size != ULONG_MAX) {
-		/*
-		 * For performance, all the general caches are L1 aligned.
+		/* For performance, all the general caches are L1 aligned.
 		 * This should be particularly beneficial on SMP boxes, as it
 		 * eliminates "false sharing".
 		 * Note for systems short on memory removing the alignment will
-		 * allow tighter packing of the smaller caches.
-		 */
-		if(!sizes->cs_cachep)
-			sizes->cs_cachep = kmem_cache_create(names->name,
-				sizes->cs_size, ARCH_KMALLOC_MINALIGN,
-				(ARCH_KMALLOC_FLAGS | SLAB_PANIC), NULL, NULL);
+		 * allow tighter packing of the smaller caches. */
+		sizes->cs_cachep = kmem_cache_create(names->name,
+			sizes->cs_size, ARCH_KMALLOC_MINALIGN,
+			(ARCH_KMALLOC_FLAGS | SLAB_PANIC), NULL, NULL);
 
 		/* Inc off-slab bufctl limit until the ceiling is hit. */
 		if (!(OFF_SLAB(sizes->cs_cachep))) {
@@ -1113,47 +852,25 @@
 	/* 4) Replace the bootstrap head arrays */
 	{
 		void * ptr;
+		int cpu = smp_processor_id();
 
 		ptr = kmalloc(sizeof(struct arraycache_init), GFP_KERNEL);
-
-		local_irq_disable();
-		BUG_ON(ac_data(&cache_cache) != &initarray_cache.cache);
-		memcpy(ptr, ac_data(&cache_cache),
-				sizeof(struct arraycache_init));
-		cache_cache.array[smp_processor_id()] = ptr;
-		local_irq_enable();
+		local_irq_disable_nort();
+		BUG_ON(ac_data(&cache_cache, cpu) != &initarray_cache.cache);
+		memcpy(ptr, ac_data(&cache_cache, cpu), sizeof(struct arraycache_init));
+		cache_cache.array[cpu] = ptr;
+		local_irq_enable_nort();
 
 		ptr = kmalloc(sizeof(struct arraycache_init), GFP_KERNEL);
-
-		local_irq_disable();
-		BUG_ON(ac_data(malloc_sizes[INDEX_AC].cs_cachep)
-				!= &initarray_generic.cache);
-		memcpy(ptr, ac_data(malloc_sizes[INDEX_AC].cs_cachep),
+		local_irq_disable_nort();
+		BUG_ON(ac_data(malloc_sizes[0].cs_cachep, cpu) != &initarray_generic.cache);
+		memcpy(ptr, ac_data(malloc_sizes[0].cs_cachep, cpu),
 				sizeof(struct arraycache_init));
-		malloc_sizes[INDEX_AC].cs_cachep->array[smp_processor_id()] =
-						ptr;
-		local_irq_enable();
-	}
-	/* 5) Replace the bootstrap kmem_list3's */
-	{
-		int node;
-		/* Replace the static kmem_list3 structures for the boot cpu */
-		init_list(&cache_cache, &initkmem_list3[CACHE_CACHE],
-				numa_node_id());
-
-		for_each_online_node(node) {
-			init_list(malloc_sizes[INDEX_AC].cs_cachep,
-					&initkmem_list3[SIZE_AC+node], node);
-
-			if (INDEX_AC != INDEX_L3) {
-				init_list(malloc_sizes[INDEX_L3].cs_cachep,
-						&initkmem_list3[SIZE_L3+node],
-						node);
-			}
-		}
+		malloc_sizes[0].cs_cachep->array[cpu] = ptr;
+		local_irq_enable_nort();
 	}
 
-	/* 6) resize the head arrays to their final sizes */
+	/* 5) resize the head arrays to their final sizes */
 	{
 		kmem_cache_t *cachep;
 		down(&cache_chain_sem);
@@ -1170,6 +887,7 @@
 	 */
 	register_cpu_notifier(&cpucache_notifier);
 
+
 	/* The reap timers are started later, with a module init call:
 	 * That part of the kernel is not yet operational.
 	 */
@@ -1183,8 +901,10 @@
 	 * Register the timers that return unneeded
 	 * pages to gfp.
 	 */
-	for_each_online_cpu(cpu)
-		start_cpu_timer(cpu);
+	for (cpu = 0; cpu < NR_CPUS; cpu++) {
+		if (cpu_online(cpu))
+			start_cpu_timer(cpu);
+	}
 
 	return 0;
 }
@@ -1198,7 +918,7 @@
  * did not request dmaable memory, we might get it, but that
  * would be relatively rare and ignorable.
  */
-static void *kmem_getpages(kmem_cache_t *cachep, gfp_t flags, int nodeid)
+static void *kmem_getpages(kmem_cache_t *cachep, unsigned int __nocast flags, int nodeid)
 {
 	struct page *page;
 	void *addr;
@@ -1268,7 +988,7 @@
 
 	*addr++=0x12345678;
 	*addr++=caller;
-	*addr++=smp_processor_id();
+	*addr++=raw_smp_processor_id();
 	size -= 3*sizeof(unsigned long);
 	{
 		unsigned long *sptr = &caller;
@@ -1459,20 +1179,6 @@
 	}
 }
 
-/* For setting up all the kmem_list3s for cache whose objsize is same
-   as size of kmem_list3. */
-static inline void set_up_list3s(kmem_cache_t *cachep, int index)
-{
-	int node;
-
-	for_each_online_node(node) {
-		cachep->nodelists[node] = &initkmem_list3[index+node];
-		cachep->nodelists[node]->next_reap = jiffies +
-			REAPTIMEOUT_LIST3 +
-			((unsigned long)cachep)%REAPTIMEOUT_LIST3;
-	}
-}
-
 /**
  * kmem_cache_create - Create a cache.
  * @name: A string which is used in /proc/slabinfo to identify this cache.
@@ -1514,6 +1220,7 @@
 	size_t left_over, slab_size, ralign;
 	kmem_cache_t *cachep = NULL;
 	struct list_head *p;
+	int cpu = raw_smp_processor_id();
 
 	/*
 	 * Sanity checks... these are all serious usage bugs.
@@ -1656,7 +1363,7 @@
 		size += BYTES_PER_WORD;
 	}
 #if FORCED_DEBUG && defined(CONFIG_DEBUG_PAGEALLOC)
-	if (size >= malloc_sizes[INDEX_L3+1].cs_size && cachep->reallen > cache_line_size() && size < PAGE_SIZE) {
+	if (size > 128 && cachep->reallen > cache_line_size() && size < PAGE_SIZE) {
 		cachep->dbghead += PAGE_SIZE - size;
 		size = PAGE_SIZE;
 	}
@@ -1758,9 +1465,13 @@
 		cachep->gfpflags |= GFP_DMA;
 	spin_lock_init(&cachep->spinlock);
 	cachep->objsize = size;
+	/* NUMA */
+	INIT_LIST_HEAD(&cachep->lists.slabs_full);
+	INIT_LIST_HEAD(&cachep->lists.slabs_partial);
+	INIT_LIST_HEAD(&cachep->lists.slabs_free);
 
 	if (flags & CFLGS_OFF_SLAB)
-		cachep->slabp_cache = kmem_find_general_cachep(slab_size, 0u);
+		cachep->slabp_cache = kmem_find_general_cachep(slab_size,0);
 	cachep->ctor = ctor;
 	cachep->dtor = dtor;
 	cachep->name = name;
@@ -1776,52 +1487,25 @@
 			 * the cache that's used by kmalloc(24), otherwise
 			 * the creation of further caches will BUG().
 			 */
-			cachep->array[smp_processor_id()] =
-				&initarray_generic.cache;
-
-			/* If the cache that's used by
-			 * kmalloc(sizeof(kmem_list3)) is the first cache,
-			 * then we need to set up all its list3s, otherwise
-			 * the creation of further caches will BUG().
-			 */
-			set_up_list3s(cachep, SIZE_AC);
-			if (INDEX_AC == INDEX_L3)
-				g_cpucache_up = PARTIAL_L3;
-			else
-				g_cpucache_up = PARTIAL_AC;
+			cachep->array[cpu] = &initarray_generic.cache;
+			g_cpucache_up = PARTIAL;
 		} else {
-			cachep->array[smp_processor_id()] =
-				kmalloc(sizeof(struct arraycache_init),
-						GFP_KERNEL);
-
-			if (g_cpucache_up == PARTIAL_AC) {
-				set_up_list3s(cachep, SIZE_L3);
-				g_cpucache_up = PARTIAL_L3;
-			} else {
-				int node;
-				for_each_online_node(node) {
-
-					cachep->nodelists[node] =
-						kmalloc_node(sizeof(struct kmem_list3),
-								GFP_KERNEL, node);
-					BUG_ON(!cachep->nodelists[node]);
-					kmem_list3_init(cachep->nodelists[node]);
-				}
-			}
+			cachep->array[cpu] = kmalloc(sizeof(struct arraycache_init),GFP_KERNEL);
 		}
-		cachep->nodelists[numa_node_id()]->next_reap =
-			jiffies + REAPTIMEOUT_LIST3 +
-			((unsigned long)cachep)%REAPTIMEOUT_LIST3;
-
-		BUG_ON(!ac_data(cachep));
-		ac_data(cachep)->avail = 0;
-		ac_data(cachep)->limit = BOOT_CPUCACHE_ENTRIES;
-		ac_data(cachep)->batchcount = 1;
-		ac_data(cachep)->touched = 0;
+		BUG_ON(!ac_data(cachep, cpu));
+		ac_data(cachep, cpu)->avail = 0;
+		ac_data(cachep, cpu)->limit = BOOT_CPUCACHE_ENTRIES;
+		ac_data(cachep, cpu)->batchcount = 1;
+		ac_data(cachep, cpu)->touched = 0;
 		cachep->batchcount = 1;
 		cachep->limit = BOOT_CPUCACHE_ENTRIES;
+		cachep->free_limit = (1+num_online_cpus())*cachep->batchcount
+					+ cachep->num;
 	} 
 
+	cachep->lists.next_reap = jiffies + REAPTIMEOUT_LIST3 +
+					((unsigned long)cachep)%REAPTIMEOUT_LIST3;
+
 	/* cache setup completed, link it into the list */
 	list_add(&cachep->next, &cache_chain);
 	unlock_cpu_hotplug();
@@ -1837,35 +1521,27 @@
 #if DEBUG
 static void check_irq_off(void)
 {
-	BUG_ON(!irqs_disabled());
+#ifndef CONFIG_PREEMPT_RT
+	BUG_ON(!raw_irqs_disabled());
+#endif
 }
 
 static void check_irq_on(void)
 {
-	BUG_ON(irqs_disabled());
+	BUG_ON(raw_irqs_disabled());
 }
 
 static void check_spinlock_acquired(kmem_cache_t *cachep)
 {
 #ifdef CONFIG_SMP
 	check_irq_off();
-	assert_spin_locked(&cachep->nodelists[numa_node_id()]->list_lock);
-#endif
-}
-
-static inline void check_spinlock_acquired_node(kmem_cache_t *cachep, int node)
-{
-#ifdef CONFIG_SMP
-	check_irq_off();
-	assert_spin_locked(&cachep->nodelists[node]->list_lock);
+	BUG_ON(spin_trylock(&cachep->spinlock));
 #endif
 }
-
 #else
 #define check_irq_off()	do { } while(0)
 #define check_irq_on()	do { } while(0)
 #define check_spinlock_acquired(x) do { } while(0)
-#define check_spinlock_acquired_node(x, y) do { } while(0)
 #endif
 
 /*
@@ -1876,9 +1552,9 @@
 	check_irq_on();
 	preempt_disable();
 
-	local_irq_disable();
+	raw_local_irq_disable();
 	func(arg);
-	local_irq_enable();
+	raw_local_irq_enable();
 
 	if (smp_call_function(func, arg, 1, 1))
 		BUG();
@@ -1887,92 +1563,85 @@
 }
 
 static void drain_array_locked(kmem_cache_t* cachep,
-				struct array_cache *ac, int force, int node);
+				struct array_cache *ac, int force);
 
-static void do_drain(void *arg)
+static void do_drain_cpu(kmem_cache_t *cachep, int cpu)
 {
-	kmem_cache_t *cachep = (kmem_cache_t*)arg;
 	struct array_cache *ac;
-	int node = numa_node_id();
 
 	check_irq_off();
-	ac = ac_data(cachep);
-	spin_lock(&cachep->nodelists[node]->list_lock);
-	free_block(cachep, ac->entry, ac->avail, node);
-	spin_unlock(&cachep->nodelists[node]->list_lock);
+
+	spin_lock(&cachep->spinlock);
+	ac = ac_data(cachep, cpu);
+	free_block(cachep, &ac_entry(ac)[0], ac->avail);
 	ac->avail = 0;
+	spin_unlock(&cachep->spinlock);
 }
 
-static void drain_cpu_caches(kmem_cache_t *cachep)
+#ifndef CONFIG_PREEMPT_RT
+/*
+ * Executes in an IRQ context:
+ */
+static void do_drain(void *arg)
 {
-	struct kmem_list3 *l3;
-	int node;
+	do_drain_cpu((kmem_cache_t*)arg, smp_processor_id());
+}
+#endif
 
+static void drain_cpu_caches(kmem_cache_t *cachep)
+{
+#ifndef CONFIG_PREEMPT_RT
 	smp_call_function_all_cpus(do_drain, cachep);
+#else
+	int cpu;
+
+	for_each_online_cpu(cpu)
+		do_drain_cpu(cachep, cpu);
+#endif
 	check_irq_on();
 	spin_lock_irq(&cachep->spinlock);
-	for_each_online_node(node)  {
-		l3 = cachep->nodelists[node];
-		if (l3) {
-			spin_lock(&l3->list_lock);
-			drain_array_locked(cachep, l3->shared, 1, node);
-			spin_unlock(&l3->list_lock);
-			if (l3->alien)
-				drain_alien_cache(cachep, l3);
-		}
-	}
+	if (cachep->lists.shared)
+		drain_array_locked(cachep, cachep->lists.shared, 1);
 	spin_unlock_irq(&cachep->spinlock);
 }
 
-static int __node_shrink(kmem_cache_t *cachep, int node)
+
+/* NUMA shrink all list3s */
+static int __cache_shrink(kmem_cache_t *cachep)
 {
 	struct slab *slabp;
-	struct kmem_list3 *l3 = cachep->nodelists[node];
 	int ret;
 
-	for (;;) {
+	drain_cpu_caches(cachep);
+
+	check_irq_on();
+	spin_lock_irq(&cachep->spinlock);
+
+	for(;;) {
 		struct list_head *p;
 
-		p = l3->slabs_free.prev;
-		if (p == &l3->slabs_free)
+		p = cachep->lists.slabs_free.prev;
+		if (p == &cachep->lists.slabs_free)
 			break;
 
-		slabp = list_entry(l3->slabs_free.prev, struct slab, list);
+		slabp = list_entry(cachep->lists.slabs_free.prev, struct slab, list);
 #if DEBUG
 		if (slabp->inuse)
 			BUG();
 #endif
 		list_del(&slabp->list);
 
-		l3->free_objects -= cachep->num;
-		spin_unlock_irq(&l3->list_lock);
+		cachep->lists.free_objects -= cachep->num;
+		spin_unlock_irq(&cachep->spinlock);
 		slab_destroy(cachep, slabp);
-		spin_lock_irq(&l3->list_lock);
+		spin_lock_irq(&cachep->spinlock);
 	}
-	ret = !list_empty(&l3->slabs_full) ||
-		!list_empty(&l3->slabs_partial);
+	ret = !list_empty(&cachep->lists.slabs_full) ||
+		!list_empty(&cachep->lists.slabs_partial);
+	spin_unlock_irq(&cachep->spinlock);
 	return ret;
 }
 
-static int __cache_shrink(kmem_cache_t *cachep)
-{
-	int ret = 0, i = 0;
-	struct kmem_list3 *l3;
-
-	drain_cpu_caches(cachep);
-
-	check_irq_on();
-	for_each_online_node(i) {
-		l3 = cachep->nodelists[i];
-		if (l3) {
-			spin_lock_irq(&l3->list_lock);
-			ret += __node_shrink(cachep, i);
-			spin_unlock_irq(&l3->list_lock);
-		}
-	}
-	return (ret ? 1 : 0);
-}
-
 /**
  * kmem_cache_shrink - Shrink a cache.
  * @cachep: The cache to shrink.
@@ -2009,7 +1678,6 @@
 int kmem_cache_destroy(kmem_cache_t * cachep)
 {
 	int i;
-	struct kmem_list3 *l3;
 
 	if (!cachep || in_interrupt())
 		BUG();
@@ -2037,17 +1705,15 @@
 	if (unlikely(cachep->flags & SLAB_DESTROY_BY_RCU))
 		synchronize_rcu();
 
-	for_each_online_cpu(i)
+	/* no cpu_online check required here since we clear the percpu
+	 * array on cpu offline and set this to NULL.
+	 */
+	for (i = 0; i < NR_CPUS; i++)
 		kfree(cachep->array[i]);
 
 	/* NUMA: free the list3 structures */
-	for_each_online_node(i) {
-		if ((l3 = cachep->nodelists[i])) {
-			kfree(l3->shared);
-			free_alien_cache(l3->alien);
-			kfree(l3);
-		}
-	}
+	kfree(cachep->lists.shared);
+	cachep->lists.shared = NULL;
 	kmem_cache_free(&cache_cache, cachep);
 
 	unlock_cpu_hotplug();
@@ -2057,8 +1723,8 @@
 EXPORT_SYMBOL(kmem_cache_destroy);
 
 /* Get the memory for a slab management obj. */
-static struct slab* alloc_slabmgmt(kmem_cache_t *cachep, void *objp,
-			int colour_off, gfp_t local_flags)
+static struct slab* alloc_slabmgmt(kmem_cache_t *cachep,
+			void *objp, int colour_off, unsigned int __nocast local_flags)
 {
 	struct slab *slabp;
 	
@@ -2089,7 +1755,7 @@
 	int i;
 
 	for (i = 0; i < cachep->num; i++) {
-		void *objp = slabp->s_mem+cachep->objsize*i;
+		void* objp = slabp->s_mem+cachep->objsize*i;
 #if DEBUG
 		/* need to poison the objs? */
 		if (cachep->flags & SLAB_POISON)
@@ -2159,14 +1825,13 @@
  * Grow (by 1) the number of slabs within a cache.  This is called by
  * kmem_cache_alloc() when there are no active objs left in a cache.
  */
-static int cache_grow(kmem_cache_t *cachep, gfp_t flags, int nodeid)
+static int cache_grow(kmem_cache_t *cachep, unsigned int __nocast flags, int nodeid)
 {
 	struct slab	*slabp;
 	void		*objp;
 	size_t		 offset;
 	gfp_t	 	 local_flags;
 	unsigned long	 ctor_flags;
-	struct kmem_list3 *l3;
 
 	/* Be lazy and only check for valid flags here,
  	 * keeping it out of the critical path in kmem_cache_alloc().
@@ -2198,9 +1863,8 @@
 
 	spin_unlock(&cachep->spinlock);
 
-	check_irq_off();
 	if (local_flags & __GFP_WAIT)
-		local_irq_enable();
+		local_irq_enable_nort();
 
 	/*
 	 * The test for missing atomic flag is performed here, rather than
@@ -2210,9 +1874,8 @@
 	 */
 	kmem_flagcheck(cachep, flags);
 
-	/* Get mem for the objs.
-	 * Attempt to allocate a physical page from 'nodeid',
-	 */
+
+	/* Get mem for the objs. */
 	if (!(objp = kmem_getpages(cachep, flags, nodeid)))
 		goto failed;
 
@@ -2220,28 +1883,26 @@
 	if (!(slabp = alloc_slabmgmt(cachep, objp, offset, local_flags)))
 		goto opps1;
 
-	slabp->nodeid = nodeid;
 	set_slab_attr(cachep, slabp, objp);
 
 	cache_init_objs(cachep, slabp, ctor_flags);
 
 	if (local_flags & __GFP_WAIT)
-		local_irq_disable();
+		local_irq_disable_nort();
 	check_irq_off();
-	l3 = cachep->nodelists[nodeid];
-	spin_lock(&l3->list_lock);
+	spin_lock(&cachep->spinlock);
 
 	/* Make slab active. */
-	list_add_tail(&slabp->list, &(l3->slabs_free));
+	list_add_tail(&slabp->list, &(list3_data(cachep)->slabs_free));
 	STATS_INC_GROWN(cachep);
-	l3->free_objects += cachep->num;
-	spin_unlock(&l3->list_lock);
+	list3_data(cachep)->free_objects += cachep->num;
+	spin_unlock(&cachep->spinlock);
 	return 1;
 opps1:
 	kmem_freepages(cachep, objp);
 failed:
 	if (local_flags & __GFP_WAIT)
-		local_irq_disable();
+		local_irq_disable_nort();
 	return 0;
 }
 
@@ -2341,6 +2002,7 @@
 	kmem_bufctl_t i;
 	int entries = 0;
 	
+	check_spinlock_acquired(cachep);
 	/* Check slab's freelist to see if this obj is there. */
 	for (i = slabp->free; i != BUFCTL_END; i = slab_bufctl(slabp)[i]) {
 		entries++;
@@ -2366,14 +2028,14 @@
 #define check_slabp(x,y) do { } while(0)
 #endif
 
-static void *cache_alloc_refill(kmem_cache_t *cachep, gfp_t flags)
+static void *cache_alloc_refill(kmem_cache_t *cachep, unsigned int __nocast flags, int cpu)
 {
 	int batchcount;
 	struct kmem_list3 *l3;
 	struct array_cache *ac;
 
 	check_irq_off();
-	ac = ac_data(cachep);
+	ac = ac_data(cachep, cpu);
 retry:
 	batchcount = ac->batchcount;
 	if (!ac->touched && batchcount > BATCHREFILL_LIMIT) {
@@ -2383,11 +2045,10 @@
 		 */
 		batchcount = BATCHREFILL_LIMIT;
 	}
-	l3 = cachep->nodelists[numa_node_id()];
-
-	BUG_ON(ac->avail > 0 || !l3);
-	spin_lock(&l3->list_lock);
+	l3 = list3_data(cachep);
 
+	BUG_ON(ac->avail > 0);
+	spin_lock_nort(&cachep->spinlock);
 	if (l3->shared) {
 		struct array_cache *shared_array = l3->shared;
 		if (shared_array->avail) {
@@ -2395,9 +2056,8 @@
 				batchcount = shared_array->avail;
 			shared_array->avail -= batchcount;
 			ac->avail = batchcount;
-			memcpy(ac->entry,
-				&(shared_array->entry[shared_array->avail]),
-				sizeof(void*)*batchcount);
+			memcpy(ac_entry(ac), &ac_entry(shared_array)[shared_array->avail],
+					sizeof(void*)*batchcount);
 			shared_array->touched = 1;
 			goto alloc_done;
 		}
@@ -2424,8 +2084,7 @@
 			STATS_SET_HIGH(cachep);
 
 			/* get obj pointer */
-			ac->entry[ac->avail++] = slabp->s_mem +
-				slabp->free*cachep->objsize;
+			ac_entry(ac)[ac->avail++] = slabp->s_mem + slabp->free*cachep->objsize;
 
 			slabp->inuse++;
 			next = slab_bufctl(slabp)[slabp->free];
@@ -2448,14 +2107,17 @@
 must_grow:
 	l3->free_objects -= ac->avail;
 alloc_done:
-	spin_unlock(&l3->list_lock);
+	spin_unlock_nort(&cachep->spinlock);
 
 	if (unlikely(!ac->avail)) {
 		int x;
-		x = cache_grow(cachep, flags, numa_node_id());
+		spin_unlock_rt(&cachep->spinlock);
+		x = cache_grow(cachep, flags, -1);
 
+		spin_lock_rt(&cachep->spinlock);
 		// cache_grow can reenable interrupts, then ac could change.
-		ac = ac_data(cachep);
+		cpu = smp_processor_id_rt(cpu);
+		ac = ac_data(cachep, cpu);
 		if (!x && ac->avail == 0)	// no objects in sight? abort
 			return NULL;
 
@@ -2463,11 +2125,11 @@
 			goto retry;
 	}
 	ac->touched = 1;
-	return ac->entry[--ac->avail];
+	return ac_entry(ac)[--ac->avail];
 }
 
 static inline void
-cache_alloc_debugcheck_before(kmem_cache_t *cachep, gfp_t flags)
+cache_alloc_debugcheck_before(kmem_cache_t *cachep, unsigned int __nocast flags)
 {
 	might_sleep_if(flags & __GFP_WAIT);
 #if DEBUG
@@ -2478,7 +2140,7 @@
 #if DEBUG
 static void *
 cache_alloc_debugcheck_after(kmem_cache_t *cachep,
-			gfp_t flags, void *objp, void *caller)
+			unsigned int __nocast flags, void *objp, void *caller)
 {
 	if (!objp)	
 		return objp;
@@ -2521,118 +2183,47 @@
 #define cache_alloc_debugcheck_after(a,b,objp,d) (objp)
 #endif
 
-static inline void *____cache_alloc(kmem_cache_t *cachep, gfp_t flags)
+
+static inline void *__cache_alloc(kmem_cache_t *cachep, unsigned int __nocast flags)
 {
+	int cpu;
+	unsigned long save_flags;
 	void* objp;
 	struct array_cache *ac;
 
-	check_irq_off();
-	ac = ac_data(cachep);
+	cache_alloc_debugcheck_before(cachep, flags);
+
+	local_irq_save_nort(save_flags);
+	spin_lock_rt(&cachep->spinlock);
+	cpu = raw_smp_processor_id();
+	ac = ac_data(cachep, cpu);
 	if (likely(ac->avail)) {
 		STATS_INC_ALLOCHIT(cachep);
 		ac->touched = 1;
-		objp = ac->entry[--ac->avail];
+		objp = ac_entry(ac)[--ac->avail];
 	} else {
 		STATS_INC_ALLOCMISS(cachep);
-		objp = cache_alloc_refill(cachep, flags);
+		objp = cache_alloc_refill(cachep, flags, cpu);
 	}
+	spin_unlock_rt(&cachep->spinlock);
+	local_irq_restore_nort(save_flags);
+	objp = cache_alloc_debugcheck_after(cachep, flags, objp, __builtin_return_address(0));
 	return objp;
 }
 
-static inline void *__cache_alloc(kmem_cache_t *cachep, gfp_t flags)
-{
-	unsigned long save_flags;
-	void* objp;
-
-	cache_alloc_debugcheck_before(cachep, flags);
-
-	local_irq_save(save_flags);
-	objp = ____cache_alloc(cachep, flags);
-	local_irq_restore(save_flags);
-	objp = cache_alloc_debugcheck_after(cachep, flags, objp,
-					__builtin_return_address(0));
-	prefetchw(objp);
-	return objp;
-}
-
-#ifdef CONFIG_NUMA
 /*
- * A interface to enable slab creation on nodeid
+ * NUMA: different approach needed if the spinlock is moved into
+ * the l3 structure
  */
-static void *__cache_alloc_node(kmem_cache_t *cachep, gfp_t flags, int nodeid)
-{
-	struct list_head *entry;
- 	struct slab *slabp;
- 	struct kmem_list3 *l3;
- 	void *obj;
- 	kmem_bufctl_t next;
- 	int x;
 
- 	l3 = cachep->nodelists[nodeid];
- 	BUG_ON(!l3);
-
-retry:
- 	spin_lock(&l3->list_lock);
- 	entry = l3->slabs_partial.next;
- 	if (entry == &l3->slabs_partial) {
- 		l3->free_touched = 1;
- 		entry = l3->slabs_free.next;
- 		if (entry == &l3->slabs_free)
- 			goto must_grow;
- 	}
-
- 	slabp = list_entry(entry, struct slab, list);
- 	check_spinlock_acquired_node(cachep, nodeid);
- 	check_slabp(cachep, slabp);
-
- 	STATS_INC_NODEALLOCS(cachep);
- 	STATS_INC_ACTIVE(cachep);
- 	STATS_SET_HIGH(cachep);
-
- 	BUG_ON(slabp->inuse == cachep->num);
-
- 	/* get obj pointer */
- 	obj =  slabp->s_mem + slabp->free*cachep->objsize;
- 	slabp->inuse++;
- 	next = slab_bufctl(slabp)[slabp->free];
-#if DEBUG
- 	slab_bufctl(slabp)[slabp->free] = BUFCTL_FREE;
-#endif
- 	slabp->free = next;
- 	check_slabp(cachep, slabp);
- 	l3->free_objects--;
- 	/* move slabp to correct slabp list: */
- 	list_del(&slabp->list);
-
- 	if (slabp->free == BUFCTL_END) {
- 		list_add(&slabp->list, &l3->slabs_full);
- 	} else {
- 		list_add(&slabp->list, &l3->slabs_partial);
- 	}
-
- 	spin_unlock(&l3->list_lock);
- 	goto done;
-
-must_grow:
- 	spin_unlock(&l3->list_lock);
- 	x = cache_grow(cachep, flags, nodeid);
-
- 	if (!x)
- 		return NULL;
-
- 	goto retry;
-done:
- 	return obj;
-}
-#endif
-
-/*
- * Caller needs to acquire correct kmem_list's list_lock
- */
-static void free_block(kmem_cache_t *cachep, void **objpp, int nr_objects, int node)
+static void free_block(kmem_cache_t *cachep, void **objpp, int nr_objects)
 {
 	int i;
-	struct kmem_list3 *l3;
+
+	check_spinlock_acquired(cachep);
+
+	/* NUMA: move add into loop */
+	cachep->lists.free_objects += nr_objects;
 
 	for (i = 0; i < nr_objects; i++) {
 		void *objp = objpp[i];
@@ -2640,19 +2231,16 @@
 		unsigned int objnr;
 
 		slabp = page_get_slab(virt_to_page(objp));
-		l3 = cachep->nodelists[node];
 		list_del(&slabp->list);
 		objnr = (objp - slabp->s_mem) / cachep->objsize;
-		check_spinlock_acquired_node(cachep, node);
 		check_slabp(cachep, slabp);
-
 #if DEBUG
 		/* Verify that the slab belongs to the intended node */
 		WARN_ON(slabp->nodeid != node);
 
 		if (slab_bufctl(slabp)[objnr] != BUFCTL_FREE) {
-			printk(KERN_ERR "slab: double free detected in cache "
-					"'%s', objp %p\n", cachep->name, objp);
+			printk(KERN_ERR "slab: double free detected in cache '%s', objp %p.\n",
+						cachep->name, objp);
 			BUG();
 		}
 #endif
@@ -2660,23 +2248,24 @@
 		slabp->free = objnr;
 		STATS_DEC_ACTIVE(cachep);
 		slabp->inuse--;
-		l3->free_objects++;
 		check_slabp(cachep, slabp);
 
 		/* fixup slab chains */
 		if (slabp->inuse == 0) {
-			if (l3->free_objects > l3->free_limit) {
-				l3->free_objects -= cachep->num;
+			if (cachep->lists.free_objects > cachep->free_limit) {
+				cachep->lists.free_objects -= cachep->num;
 				slab_destroy(cachep, slabp);
 			} else {
-				list_add(&slabp->list, &l3->slabs_free);
+				list_add(&slabp->list,
+				&list3_data_ptr(cachep, objp)->slabs_free);
 			}
 		} else {
 			/* Unconditionally move a slab to the end of the
 			 * partial list on free - maximum time for the
 			 * other objects to be freed, too.
 			 */
-			list_add_tail(&slabp->list, &l3->slabs_partial);
+			list_add_tail(&slabp->list,
+				&list3_data_ptr(cachep, objp)->slabs_partial);
 		}
 	}
 }
@@ -2684,39 +2273,36 @@
 static void cache_flusharray(kmem_cache_t *cachep, struct array_cache *ac)
 {
 	int batchcount;
-	struct kmem_list3 *l3;
-	int node = numa_node_id();
 
 	batchcount = ac->batchcount;
 #if DEBUG
 	BUG_ON(!batchcount || batchcount > ac->avail);
 #endif
 	check_irq_off();
-	l3 = cachep->nodelists[node];
-	spin_lock(&l3->list_lock);
-	if (l3->shared) {
-		struct array_cache *shared_array = l3->shared;
+	spin_lock_nort(&cachep->spinlock);
+	if (cachep->lists.shared) {
+		struct array_cache *shared_array = cachep->lists.shared;
 		int max = shared_array->limit-shared_array->avail;
 		if (max) {
 			if (batchcount > max)
 				batchcount = max;
-			memcpy(&(shared_array->entry[shared_array->avail]),
-					ac->entry,
+			memcpy(&ac_entry(shared_array)[shared_array->avail],
+					&ac_entry(ac)[0],
 					sizeof(void*)*batchcount);
 			shared_array->avail += batchcount;
 			goto free_done;
 		}
 	}
 
-	free_block(cachep, ac->entry, batchcount, node);
+	free_block(cachep, &ac_entry(ac)[0], batchcount);
 free_done:
 #if STATS
 	{
 		int i = 0;
 		struct list_head *p;
 
-		p = l3->slabs_free.next;
-		while (p != &(l3->slabs_free)) {
+		p = list3_data(cachep)->slabs_free.next;
+		while (p != &(list3_data(cachep)->slabs_free)) {
 			struct slab *slabp;
 
 			slabp = list_entry(p, struct slab, list);
@@ -2728,13 +2314,12 @@
 		STATS_SET_FREEABLE(cachep, i);
 	}
 #endif
-	spin_unlock(&l3->list_lock);
+	spin_unlock_nort(&cachep->spinlock);
 	ac->avail -= batchcount;
-	memmove(ac->entry, &(ac->entry[batchcount]),
+	memmove(&ac_entry(ac)[0], &ac_entry(ac)[batchcount],
 			sizeof(void*)*ac->avail);
 }
 
-
 /*
  * __cache_free
  * Release an obj back to its cache. If the obj has a constructed
@@ -2744,52 +2329,24 @@
  */
 static inline void __cache_free(kmem_cache_t *cachep, void *objp)
 {
-	struct array_cache *ac = ac_data(cachep);
+	int cpu;
+	struct array_cache *ac;
 
 	check_irq_off();
 	objp = cache_free_debugcheck(cachep, objp, __builtin_return_address(0));
 
-	/* Make sure we are not freeing a object from another
-	 * node to the array cache on this cpu.
-	 */
-#ifdef CONFIG_NUMA
-	{
-		struct slab *slabp;
-		slabp = page_get_slab(virt_to_page(objp));
-		if (unlikely(slabp->nodeid != numa_node_id())) {
-			struct array_cache *alien = NULL;
-			int nodeid = slabp->nodeid;
-			struct kmem_list3 *l3 = cachep->nodelists[numa_node_id()];
-
-			STATS_INC_NODEFREES(cachep);
-			if (l3->alien && l3->alien[nodeid]) {
-				alien = l3->alien[nodeid];
-				spin_lock(&alien->lock);
-				if (unlikely(alien->avail == alien->limit))
-					__drain_alien_cache(cachep,
-							alien, nodeid);
-				alien->entry[alien->avail++] = objp;
-				spin_unlock(&alien->lock);
-			} else {
-				spin_lock(&(cachep->nodelists[nodeid])->
-						list_lock);
-				free_block(cachep, &objp, 1, nodeid);
-				spin_unlock(&(cachep->nodelists[nodeid])->
-						list_lock);
-			}
-			return;
-		}
-	}
-#endif
+	spin_lock_rt(&cachep->spinlock);
+	cpu = raw_smp_processor_id();
+	ac = ac_data(cachep, cpu);
 	if (likely(ac->avail < ac->limit)) {
 		STATS_INC_FREEHIT(cachep);
-		ac->entry[ac->avail++] = objp;
-		return;
+		ac_entry(ac)[ac->avail++] = objp;
 	} else {
 		STATS_INC_FREEMISS(cachep);
 		cache_flusharray(cachep, ac);
-		ac->entry[ac->avail++] = objp;
+		ac_entry(ac)[ac->avail++] = objp;
 	}
+	spin_unlock_rt(&cachep->spinlock);
 }
 
 /**
@@ -2800,7 +2357,7 @@
  * Allocate an object from this cache.  The flags are only relevant
  * if the cache has no available objects.
  */
-void *kmem_cache_alloc(kmem_cache_t *cachep, gfp_t flags)
+void *kmem_cache_alloc(kmem_cache_t *cachep, unsigned int __nocast flags)
 {
 	return __cache_alloc(cachep, flags);
 }
@@ -2858,37 +2415,85 @@
  * Identical to kmem_cache_alloc, except that this function is slow
  * and can sleep. And it will allocate memory on the given node, which
  * can improve the performance for cpu bound structures.
- * New and improved: it will now make sure that the object gets
- * put on the correct node list so that there is no false sharing.
  */
-void *kmem_cache_alloc_node(kmem_cache_t *cachep, gfp_t flags, int nodeid)
+void *kmem_cache_alloc_node(kmem_cache_t *cachep, unsigned int __nocast flags, int nodeid)
 {
-	unsigned long save_flags;
-	void *ptr;
+	int loop;
+	void *objp;
+	struct slab *slabp;
+	kmem_bufctl_t next;
 
 	if (nodeid == -1)
-		return __cache_alloc(cachep, flags);
+		return kmem_cache_alloc(cachep, flags);
 
-	if (unlikely(!cachep->nodelists[nodeid])) {
-		/* Fall back to __cache_alloc if we run into trouble */
-		printk(KERN_WARNING "slab: not allocating in inactive node %d for cache %s\n", nodeid, cachep->name);
-		return __cache_alloc(cachep,flags);
+	for (loop = 0;;loop++) {
+		struct list_head *q;
+
+		objp = NULL;
+		check_irq_on();
+		spin_lock_irq(&cachep->spinlock);
+		/* walk through all partial and empty slab and find one
+		 * from the right node */
+		list_for_each(q,&cachep->lists.slabs_partial) {
+			slabp = list_entry(q, struct slab, list);
+
+			if (page_to_nid(virt_to_page(slabp->s_mem)) == nodeid ||
+					loop > 2)
+				goto got_slabp;
+		}
+		list_for_each(q, &cachep->lists.slabs_free) {
+			slabp = list_entry(q, struct slab, list);
+
+			if (page_to_nid(virt_to_page(slabp->s_mem)) == nodeid ||
+					loop > 2)
+				goto got_slabp;
+		}
+		spin_unlock_irq(&cachep->spinlock);
+
+		local_irq_disable_nort();
+		if (!cache_grow(cachep, flags, nodeid)) {
+			local_irq_enable_nort();
+			return NULL;
+		}
+		local_irq_enable_nort();
 	}
+got_slabp:
+	/* found one: allocate object */
+	check_slabp(cachep, slabp);
+	check_spinlock_acquired(cachep);
 
-	cache_alloc_debugcheck_before(cachep, flags);
-	local_irq_save(save_flags);
-	if (nodeid == numa_node_id())
-		ptr = ____cache_alloc(cachep, flags);
+	STATS_INC_ALLOCED(cachep);
+	STATS_INC_ACTIVE(cachep);
+	STATS_SET_HIGH(cachep);
+	STATS_INC_NODEALLOCS(cachep);
+
+	objp = slabp->s_mem + slabp->free*cachep->objsize;
+
+	slabp->inuse++;
+	next = slab_bufctl(slabp)[slabp->free];
+#if DEBUG
+	slab_bufctl(slabp)[slabp->free] = BUFCTL_FREE;
+#endif
+	slabp->free = next;
+	check_slabp(cachep, slabp);
+
+	/* move slabp to correct slabp list: */
+	list_del(&slabp->list);
+	if (slabp->free == BUFCTL_END)
+		list_add(&slabp->list, &cachep->lists.slabs_full);
 	else
-		ptr = __cache_alloc_node(cachep, flags, nodeid);
-	local_irq_restore(save_flags);
-	ptr = cache_alloc_debugcheck_after(cachep, flags, ptr, __builtin_return_address(0));
+		list_add(&slabp->list, &cachep->lists.slabs_partial);
+
+	list3_data(cachep)->free_objects--;
+	spin_unlock_irq(&cachep->spinlock);
 
-	return ptr;
+	objp = cache_alloc_debugcheck_after(cachep, GFP_KERNEL, objp,
+					__builtin_return_address(0));
+	return objp;
 }
 EXPORT_SYMBOL(kmem_cache_alloc_node);
 
-void *kmalloc_node(size_t size, gfp_t flags, int node)
+void *kmalloc_node(size_t size, unsigned int __nocast flags, int node)
 {
 	kmem_cache_t *cachep;
 
@@ -2921,7 +2526,7 @@
  * platforms.  For example, on i386, it means that the memory must come
  * from the first 16MB.
  */
-void *__kmalloc(size_t size, gfp_t flags)
+void *__kmalloc(size_t size, unsigned int __nocast flags)
 {
 	kmem_cache_t *cachep;
 
@@ -2954,18 +2559,11 @@
 	if (!pdata)
 		return NULL;
 
-	/*
-	 * Cannot use for_each_online_cpu since a cpu may come online
-	 * and we have no way of figuring out how to fix the array
-	 * that we have allocated then....
-	 */
-	for_each_cpu(i) {
-		int node = cpu_to_node(i);
-
-		if (node_online(node))
-			pdata->ptrs[i] = kmalloc_node(size, GFP_KERNEL, node);
-		else
-			pdata->ptrs[i] = kmalloc(size, GFP_KERNEL);
+	for (i = 0; i < NR_CPUS; i++) {
+		if (!cpu_possible(i))
+			continue;
+		pdata->ptrs[i] = kmalloc_node(size, GFP_KERNEL,
+						cpu_to_node(i));
 
 		if (!pdata->ptrs[i])
 			goto unwind_oom;
@@ -2999,18 +2597,31 @@
 {
 	unsigned long flags;
 
-	local_irq_save(flags);
+	local_irq_save_nort(flags);
 	__cache_free(cachep, objp);
-	local_irq_restore(flags);
+	local_irq_restore_nort(flags);
 }
 EXPORT_SYMBOL(kmem_cache_free);
 
+#ifdef CONFIG_DEBUG_DEADLOCKS
+static size_t cache_size(kmem_cache_t *c)
+{
+	struct cache_sizes *csizep = malloc_sizes;
+
+	for ( ; csizep->cs_size; csizep++) {
+		if (csizep->cs_cachep == c)
+			return csizep->cs_size;
+		if (csizep->cs_dmacachep == c)
+			return csizep->cs_size;
+	}
+	return 0;
+}
+#endif
+
 /**
  * kfree - free previously allocated memory
  * @objp: pointer returned by kmalloc.
  *
- * If @objp is NULL, no operation is performed.
- *
  * Don't free memory not originally allocated by kmalloc()
  * or you will run into trouble.
  */
@@ -3021,11 +2632,16 @@
 
 	if (unlikely(!objp))
 		return;
-	local_irq_save(flags);
+	local_irq_save_nort(flags);
 	kfree_debugcheck(objp);
 	c = page_get_cache(virt_to_page(objp));
+#ifdef CONFIG_DEBUG_DEADLOCKS
+	if (check_no_locks_freed(objp, objp+cache_size(c)))
+		printk("slab %s[%p] (%d), obj: %p\n",
+			c->name, c, c->objsize, objp);
+#endif
 	__cache_free(c, (void*)objp);
-	local_irq_restore(flags);
+	local_irq_restore_nort(flags);
 }
 EXPORT_SYMBOL(kfree);
 
@@ -3043,11 +2659,11 @@
 	int i;
 	struct percpu_data *p = (struct percpu_data *) (~(unsigned long) objp);
 
-	/*
-	 * We allocate for all cpus so we cannot use for online cpu here.
-	 */
-	for_each_cpu(i)
+	for (i = 0; i < NR_CPUS; i++) {
+		if (!cpu_possible(i))
+			continue;
 		kfree(p->ptrs[i]);
+	}
 	kfree(p);
 }
 EXPORT_SYMBOL(free_percpu);
@@ -3065,76 +2681,21 @@
 }
 EXPORT_SYMBOL_GPL(kmem_cache_name);
 
-/*
- * This initializes kmem_list3 for all nodes.
- */
-static int alloc_kmemlist(kmem_cache_t *cachep)
-{
-	int node;
-	struct kmem_list3 *l3;
-	int err = 0;
-
-	for_each_online_node(node) {
-		struct array_cache *nc = NULL, *new;
-		struct array_cache **new_alien = NULL;
-#ifdef CONFIG_NUMA
-		if (!(new_alien = alloc_alien_cache(node, cachep->limit)))
-			goto fail;
-#endif
-		if (!(new = alloc_arraycache(node, (cachep->shared*
-				cachep->batchcount), 0xbaadf00d)))
-			goto fail;
-		if ((l3 = cachep->nodelists[node])) {
-
-			spin_lock_irq(&l3->list_lock);
-
-			if ((nc = cachep->nodelists[node]->shared))
-				free_block(cachep, nc->entry,
-							nc->avail, node);
-
-			l3->shared = new;
-			if (!cachep->nodelists[node]->alien) {
-				l3->alien = new_alien;
-				new_alien = NULL;
-			}
-			l3->free_limit = (1 + nr_cpus_node(node))*
-				cachep->batchcount + cachep->num;
-			spin_unlock_irq(&l3->list_lock);
-			kfree(nc);
-			free_alien_cache(new_alien);
-			continue;
-		}
-		if (!(l3 = kmalloc_node(sizeof(struct kmem_list3),
-						GFP_KERNEL, node)))
-			goto fail;
-
-		kmem_list3_init(l3);
-		l3->next_reap = jiffies + REAPTIMEOUT_LIST3 +
-			((unsigned long)cachep)%REAPTIMEOUT_LIST3;
-		l3->shared = new;
-		l3->alien = new_alien;
-		l3->free_limit = (1 + nr_cpus_node(node))*
-			cachep->batchcount + cachep->num;
-		cachep->nodelists[node] = l3;
-	}
-	return err;
-fail:
-	err = -ENOMEM;
-	return err;
-}
-
 struct ccupdate_struct {
 	kmem_cache_t *cachep;
 	struct array_cache *new[NR_CPUS];
 };
 
+/*
+ * Executes in IRQ context:
+ */
 static void do_ccupdate_local(void *info)
 {
 	struct ccupdate_struct *new = (struct ccupdate_struct *)info;
 	struct array_cache *old;
 
 	check_irq_off();
-	old = ac_data(new->cachep);
+	old = ac_data(new->cachep, smp_processor_id());
 
 	new->cachep->array[smp_processor_id()] = new->new[smp_processor_id()];
 	new->new[smp_processor_id()] = old;
@@ -3145,14 +2706,19 @@
 				int shared)
 {
 	struct ccupdate_struct new;
-	int i, err;
+	struct array_cache *new_shared;
+	int i;
 
 	memset(&new.new,0,sizeof(new.new));
-	for_each_online_cpu(i) {
-		new.new[i] = alloc_arraycache(cpu_to_node(i), limit, batchcount);
-		if (!new.new[i]) {
-			for (i--; i >= 0; i--) kfree(new.new[i]);
-			return -ENOMEM;
+	for (i = 0; i < NR_CPUS; i++) {
+		if (cpu_online(i)) {
+			new.new[i] = alloc_arraycache(i, limit, batchcount);
+			if (!new.new[i]) {
+				for (i--; i >= 0; i--) kfree(new.new[i]);
+				return -ENOMEM;
+			}
+		} else {
+			new.new[i] = NULL;
 		}
 	}
 	new.cachep = cachep;
@@ -3163,25 +2729,31 @@
 	spin_lock_irq(&cachep->spinlock);
 	cachep->batchcount = batchcount;
 	cachep->limit = limit;
-	cachep->shared = shared;
+	cachep->free_limit = (1+num_online_cpus())*cachep->batchcount + cachep->num;
 	spin_unlock_irq(&cachep->spinlock);
 
-	for_each_online_cpu(i) {
+	for (i = 0; i < NR_CPUS; i++) {
 		struct array_cache *ccold = new.new[i];
 		if (!ccold)
 			continue;
-		spin_lock_irq(&cachep->nodelists[cpu_to_node(i)]->list_lock);
-		free_block(cachep, ccold->entry, ccold->avail, cpu_to_node(i));
-		spin_unlock_irq(&cachep->nodelists[cpu_to_node(i)]->list_lock);
+		spin_lock_irq(&cachep->spinlock);
+		free_block(cachep, ac_entry(ccold), ccold->avail);
+		spin_unlock_irq(&cachep->spinlock);
 		kfree(ccold);
 	}
-
-	err = alloc_kmemlist(cachep);
-	if (err) {
-		printk(KERN_ERR "alloc_kmemlist failed for %s, error %d.\n",
-				cachep->name, -err);
-		BUG();
+	new_shared = alloc_arraycache(-1, batchcount*shared, 0xbaadf00d);
+	if (new_shared) {
+		struct array_cache *old;
+
+		spin_lock_irq(&cachep->spinlock);
+		old = cachep->lists.shared;
+		cachep->lists.shared = new_shared;
+		if (old)
+			free_block(cachep, ac_entry(old), old->avail);
+		spin_unlock_irq(&cachep->spinlock);
+		kfree(old);
 	}
+
 	return 0;
 }
 
@@ -3232,6 +2804,10 @@
 	if (limit > 32)
 		limit = 32;
 #endif
+#ifdef CONFIG_PREEMPT
+	if (limit > 16)
+		limit = 16;
+#endif
 	err = do_tune_cpucache(cachep, limit, (limit+1)/2, shared);
 	if (err)
 		printk(KERN_ERR "enable_cpucache failed for %s, error %d.\n",
@@ -3239,11 +2815,11 @@
 }
 
 static void drain_array_locked(kmem_cache_t *cachep,
-				struct array_cache *ac, int force, int node)
+				struct array_cache *ac, int force)
 {
 	int tofree;
 
-	check_spinlock_acquired_node(cachep, node);
+	check_spinlock_acquired(cachep);
 	if (ac->touched && !force) {
 		ac->touched = 0;
 	} else if (ac->avail) {
@@ -3251,9 +2827,9 @@
 		if (tofree > ac->avail) {
 			tofree = (ac->avail+1)/2;
 		}
-		free_block(cachep, ac->entry, tofree, node);
+		free_block(cachep, ac_entry(ac), tofree);
 		ac->avail -= tofree;
-		memmove(ac->entry, &(ac->entry[tofree]),
+		memmove(&ac_entry(ac)[0], &ac_entry(ac)[tofree],
 					sizeof(void*)*ac->avail);
 	}
 }
@@ -3272,12 +2848,14 @@
  */
 static void cache_reap(void *unused)
 {
+	int cpu;
 	struct list_head *walk;
-	struct kmem_list3 *l3;
 
 	if (down_trylock(&cache_chain_sem)) {
 		/* Give up. Setup the next iteration. */
-		schedule_delayed_work(&__get_cpu_var(reap_work), REAPTIMEOUT_CPUC);
+next_iteration:
+		cpu = raw_smp_processor_id();
+		schedule_delayed_work(&per_cpu(reap_work, cpu), REAPTIMEOUT_CPUC + cpu);
 		return;
 	}
 
@@ -3294,32 +2872,28 @@
 
 		check_irq_on();
 
-		l3 = searchp->nodelists[numa_node_id()];
-		if (l3->alien)
-			drain_alien_cache(searchp, l3);
-		spin_lock_irq(&l3->list_lock);
+		spin_lock_irq(&searchp->spinlock);
+		cpu = raw_smp_processor_id();
 
-		drain_array_locked(searchp, ac_data(searchp), 0,
-				numa_node_id());
+		drain_array_locked(searchp, ac_data(searchp, cpu), 0);
 
-		if (time_after(l3->next_reap, jiffies))
+		if(time_after(searchp->lists.next_reap, jiffies))
 			goto next_unlock;
 
-		l3->next_reap = jiffies + REAPTIMEOUT_LIST3;
+		searchp->lists.next_reap = jiffies + REAPTIMEOUT_LIST3;
 
-		if (l3->shared)
-			drain_array_locked(searchp, l3->shared, 0,
-				numa_node_id());
+		if (searchp->lists.shared)
+			drain_array_locked(searchp, searchp->lists.shared, 0);
 
-		if (l3->free_touched) {
-			l3->free_touched = 0;
+		if (searchp->lists.free_touched) {
+			searchp->lists.free_touched = 0;
 			goto next_unlock;
 		}
 
-		tofree = (l3->free_limit+5*searchp->num-1)/(5*searchp->num);
+		tofree = (searchp->free_limit+5*searchp->num-1)/(5*searchp->num);
 		do {
-			p = l3->slabs_free.next;
-			if (p == &(l3->slabs_free))
+			p = list3_data(searchp)->slabs_free.next;
+			if (p == &(list3_data(searchp)->slabs_free))
 				break;
 
 			slabp = list_entry(p, struct slab, list);
@@ -3332,13 +2906,13 @@
 			 * searchp cannot disappear, we hold
 			 * cache_chain_lock
 			 */
-			l3->free_objects -= searchp->num;
-			spin_unlock_irq(&l3->list_lock);
+			searchp->lists.free_objects -= searchp->num;
+			spin_unlock_irq(&searchp->spinlock);
 			slab_destroy(searchp, slabp);
-			spin_lock_irq(&l3->list_lock);
+			spin_lock_irq(&searchp->spinlock);
 		} while(--tofree > 0);
 next_unlock:
-		spin_unlock_irq(&l3->list_lock);
+		spin_unlock_irq(&searchp->spinlock);
 next:
 		cond_resched();
 	}
@@ -3346,7 +2920,7 @@
 	up(&cache_chain_sem);
 	drain_remote_pages();
 	/* Setup the next iteration */
-	schedule_delayed_work(&__get_cpu_var(reap_work), REAPTIMEOUT_CPUC);
+	goto next_iteration;
 }
 
 #ifdef CONFIG_PROC_FS
@@ -3372,7 +2946,7 @@
 		seq_puts(m, " : slabdata <active_slabs> <num_slabs> <sharedavail>");
 #if STATS
 		seq_puts(m, " : globalstat <listallocs> <maxobjs> <grown> <reaped>"
-				" <error> <maxfreeable> <nodeallocs> <remotefrees>");
+				" <error> <maxfreeable> <freelimit> <nodeallocs>");
 		seq_puts(m, " : cpustat <allochit> <allocmiss> <freehit> <freemiss>");
 #endif
 		seq_putc(m, '\n');
@@ -3407,53 +2981,39 @@
 	unsigned long	active_objs;
 	unsigned long	num_objs;
 	unsigned long	active_slabs = 0;
-	unsigned long	num_slabs, free_objects = 0, shared_avail = 0;
+	unsigned long	num_slabs;
 	const char *name;
 	char *error = NULL;
-	int node;
-	struct kmem_list3 *l3;
 
 	check_irq_on();
 	spin_lock_irq(&cachep->spinlock);
 	active_objs = 0;
 	num_slabs = 0;
-	for_each_online_node(node) {
-		l3 = cachep->nodelists[node];
-		if (!l3)
-			continue;
-
-		spin_lock(&l3->list_lock);
-
-		list_for_each(q,&l3->slabs_full) {
-			slabp = list_entry(q, struct slab, list);
-			if (slabp->inuse != cachep->num && !error)
-				error = "slabs_full accounting error";
-			active_objs += cachep->num;
-			active_slabs++;
-		}
-		list_for_each(q,&l3->slabs_partial) {
-			slabp = list_entry(q, struct slab, list);
-			if (slabp->inuse == cachep->num && !error)
-				error = "slabs_partial inuse accounting error";
-			if (!slabp->inuse && !error)
-				error = "slabs_partial/inuse accounting error";
-			active_objs += slabp->inuse;
-			active_slabs++;
-		}
-		list_for_each(q,&l3->slabs_free) {
-			slabp = list_entry(q, struct slab, list);
-			if (slabp->inuse && !error)
-				error = "slabs_free/inuse accounting error";
-			num_slabs++;
-		}
-		free_objects += l3->free_objects;
-		shared_avail += l3->shared->avail;
-
-		spin_unlock(&l3->list_lock);
+	list_for_each(q,&cachep->lists.slabs_full) {
+		slabp = list_entry(q, struct slab, list);
+		if (slabp->inuse != cachep->num && !error)
+			error = "slabs_full accounting error";
+		active_objs += cachep->num;
+		active_slabs++;
+	}
+	list_for_each(q,&cachep->lists.slabs_partial) {
+		slabp = list_entry(q, struct slab, list);
+		if (slabp->inuse == cachep->num && !error)
+			error = "slabs_partial inuse accounting error";
+		if (!slabp->inuse && !error)
+			error = "slabs_partial/inuse accounting error";
+		active_objs += slabp->inuse;
+		active_slabs++;
+	}
+	list_for_each(q,&cachep->lists.slabs_free) {
+		slabp = list_entry(q, struct slab, list);
+		if (slabp->inuse && !error)
+			error = "slabs_free/inuse accounting error";
+		num_slabs++;
 	}
 	num_slabs+=active_slabs;
 	num_objs = num_slabs*cachep->num;
-	if (num_objs - active_objs != free_objects && !error)
+	if (num_objs - active_objs != cachep->lists.free_objects && !error)
 		error = "free_objects accounting error";
 
 	name = cachep->name; 
@@ -3465,9 +3025,9 @@
 		cachep->num, (1<<cachep->gfporder));
 	seq_printf(m, " : tunables %4u %4u %4u",
 			cachep->limit, cachep->batchcount,
-			cachep->shared);
-	seq_printf(m, " : slabdata %6lu %6lu %6lu",
-			active_slabs, num_slabs, shared_avail);
+			cachep->lists.shared->limit/cachep->batchcount);
+	seq_printf(m, " : slabdata %6lu %6lu %6u",
+			active_slabs, num_slabs, cachep->lists.shared->avail);
 #if STATS
 	{	/* list3 stats */
 		unsigned long high = cachep->high_mark;
@@ -3476,13 +3036,12 @@
 		unsigned long reaped = cachep->reaped;
 		unsigned long errors = cachep->errors;
 		unsigned long max_freeable = cachep->max_freeable;
+		unsigned long free_limit = cachep->free_limit;
 		unsigned long node_allocs = cachep->node_allocs;
-		unsigned long node_frees = cachep->node_frees;
 
-		seq_printf(m, " : globalstat %7lu %6lu %5lu %4lu \
-				%4lu %4lu %4lu %4lu",
+		seq_printf(m, " : globalstat %7lu %6lu %5lu %4lu %4lu %4lu %4lu %4lu",
 				allocs, high, grown, reaped, errors,
-				max_freeable, node_allocs, node_frees);
+				max_freeable, free_limit, node_allocs);
 	}
 	/* cpu stats */
 	{
@@ -3561,10 +3120,9 @@
 			    batchcount < 1 ||
 			    batchcount > limit ||
 			    shared < 0) {
-				res = 0;
+				res = -EINVAL;
 			} else {
-				res = do_tune_cpucache(cachep, limit,
-							batchcount, shared);
+				res = do_tune_cpucache(cachep, limit, batchcount, shared);
 			}
 			break;
 		}
@@ -3576,22 +3134,18 @@
 }
 #endif
 
-/**
- * ksize - get the actual amount of memory allocated for a given object
- * @objp: Pointer to the object
- *
- * kmalloc may internally round up allocations and return more memory
- * than requested. ksize() can be used to determine the actual amount of
- * memory allocated. The caller may use this additional memory, even though
- * a smaller amount of memory was initially specified with the kmalloc call.
- * The caller must guarantee that objp points to a valid object previously
- * allocated with either kmalloc() or kmem_cache_alloc(). The object
- * must not be freed during the duration of the call.
- */
 unsigned int ksize(const void *objp)
 {
-	if (unlikely(objp == NULL))
-		return 0;
+	kmem_cache_t *c;
+	unsigned long flags;
+	unsigned int size = 0;
+
+	if (likely(objp != NULL)) {
+		local_irq_save_nort(flags);
+		c = page_get_cache(virt_to_page(objp));
+		size = kmem_cache_size(c);
+		local_irq_restore_nort(flags);
+	}
 
-	return obj_reallen(page_get_cache(virt_to_page(objp)));
+	return size;
 }


