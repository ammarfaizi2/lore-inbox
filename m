Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261426AbSJHWLa>; Tue, 8 Oct 2002 18:11:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261427AbSJHWLa>; Tue, 8 Oct 2002 18:11:30 -0400
Received: from dbl.q-ag.de ([80.146.160.66]:27784 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S261426AbSJHWKu>;
	Tue, 8 Oct 2002 18:10:50 -0400
Message-ID: <3DA35929.2070707@colorfullife.com>
Date: Wed, 09 Oct 2002 00:16:09 +0200
From: Manfred Spraul <manfred@colorfullife.com>
Reply-To: "Martin J. Bligh" <mbligh@aracnet.com>
User-Agent: Mozilla/4.0 (compatible; MSIE 5.5; Windows NT 4.0)
X-Accept-Language: en, de
MIME-Version: 1.0
To: "'Manfred Spraul'" <manfred@colorfullife.com>
CC: "Kamble, Nitin A" <nitin.a.kamble@intel.com>,
       lse-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       tomlins@cam.org, akpm@digeo.com
Subject: [RFC] numa slab for 2.5.41-mm1
References: <39B5C4829263D411AA93009027AE9EBB13299770@fmsmsx35.fm.intel.com>
Content-Type: multipart/mixed;
 boundary="------------050104010903010307000200"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050104010903010307000200
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

attached is my draft proposal for numa support:

- batching for the return of objects
- the magazine layer as in Bonwicks paper is really missing: it would be 
great to pass filled cpu arrays around between nodes, to reduce the 
amount of list operations.
- global spinlock - I want to get some stats first: the batch return is 
more efficient with a global spinlocks (1 global spinlock, instead of 
(number_of_nodes-1) spinlocks from remote nodes), batch alloc is more 
efficient with a per-node spinlock (one local spinlock instead of one 
global spinlock).

Questions:
- What should happen if a node has no memory? Right now, all memory 
would be considered as foreign.
- What should happen if get_free_pages() returns memory from another 
node? Right now, the code corrupts the object counters.
- is it possible implement
	ptr_to_nodeid()
   on all archs efficiently? It will happen for every kfree().

The patch contains some code duplication, it's possible to merge some 
parts of the cpuarray initialization.

What do you think? The patch boots on uniprocessor, with NUMA simulated 
[replace node==cur_node with !=, etc], but is not yet really tested.

--
	Manfred

--------------050104010903010307000200
Content-Type: text/plain;
 name="patch-slab-numa-draft"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-slab-numa-draft"

--- 2.5/mm/slab.c	Tue Oct  8 22:18:52 2002
+++ build-2.5/mm/slab.c	Wed Oct  9 00:03:37 2002
@@ -85,6 +85,21 @@
 #include	<asm/uaccess.h>
 
 /*
+ * Enable the NUMA mode for slab
+ * This is a separate define from CONFIG_DISCONTIGMEM, because it only
+ * applies if ZONE_NORMAL allocations are possible on all zones.
+ * TODO:
+ * - the behaviour is extremely bad if get_free_pages returns returns
+ *   memory from the another node. This must be improved.
+ * - make the cache structures themselves node local
+ * - determine the optimal placement for the chache spinlock:
+ *   node local or global?
+ * - add NUMA specific statistic counters, otherwise we'll
+ *   never find that out.
+ */
+#define CONFIG_SLAB_NUMA
+ 
+/*
  * DEBUG	- 1 for kmem_cache_create() to honour; SLAB_DEBUG_INITIAL,
  *		  SLAB_RED_ZONE & SLAB_POISON.
  *		  0 for faster, smaller code (especially in the critical paths).
@@ -189,6 +204,12 @@
 	unsigned int touched;
 } cpucache_t;
 
+struct cpucache_wrapper {
+	struct cpucache_s *native;
+#ifdef CONFIG_SLAB_NUMA
+	struct cpucache_s *alien;
+#endif
+};
 /* bootstrap: The caches do not work without cpuarrays anymore,
  * but the cpuarrays are allocated from the generic caches...
  */
@@ -200,14 +221,20 @@
 
 #define cc_entry(cpucache) \
 	((void **)(((cpucache_t*)(cpucache))+1))
+
+
+#ifdef CONFIG_SLAB_NUMA
+
 #define cc_data(cachep) \
-	((cachep)->cpudata[smp_processor_id()])
-/*
- * NUMA: check if 'ptr' points into the current node,
- * 	use the alternate cpudata cache if wrong
- */
+	((cachep)->cpudata[smp_processor_id()].native)
+
+#else
+#define cc_data(cachep) \
+	((cachep)->cpudata[smp_processor_id()].native)
+
 #define cc_data_ptr(cachep, ptr) \
 		cc_data(cachep)
+#endif
 
 /*
  * The slab lists of all objects.
@@ -231,12 +258,25 @@
 		.slabs_partial	= LIST_HEAD_INIT(parent.slabs_partial), \
 		.slabs_free	= LIST_HEAD_INIT(parent.slabs_free) \
 	}
+
+#ifdef CONFIG_SLAB_NUMA
+#define list3_data(cachep) \
+	(&(cachep)->lists[__cpu_to_node(smp_processor_id())])
+#else
 #define list3_data(cachep) \
-	(&(cachep)->lists)
+	(&(cachep)->lists[0])
+
+#define DEFINE_NUMALIST_PTR(x)	
+#define set_numalist_ptr(x, cachep, objp) \
+		do { } while(0)
 
-/* NUMA: per-node */
-#define list3_data_ptr(cachep, ptr) \
-		list3_data(cachep)
+#define set_numalist_cur(x, cachep) \
+		do { } while(0)
+
+#define access_numalist_ptr(cachep, x) \
+		(&(cachep->lists[0]))
+
+#endif
 
 /*
  * kmem_cache_t
@@ -246,13 +286,12 @@
 	
 struct kmem_cache_s {
 /* 1) per-cpu data, touched during every alloc/free */
-	cpucache_t		*cpudata[NR_CPUS];
-	/* NUMA: cpucache_t	*cpudata_othernode[NR_CPUS]; */
+
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
@@ -446,8 +485,6 @@
 
 /* internal cache of cache description objs */
 static kmem_cache_t cache_cache = {
-	.lists		= LIST3_INIT(cache_cache.lists),
-	.cpudata	= { [0] = &cpuarray_cache.cache },
 	.batchcount	= 1,
 	.limit		= BOOT_CPUCACHE_ENTRIES,
 	.objsize	= sizeof(kmem_cache_t),
@@ -590,11 +627,26 @@
 			nc->touched = 0;
 
 			spin_lock_irq(&cachep->spinlock);
-			cachep->cpudata[cpu] = nc;
+			cachep->cpudata[cpu].native = nc;
 			cachep->free_limit = (1+num_online_cpus())*cachep->batchcount
 						+ cachep->num;
 			spin_unlock_irq(&cachep->spinlock);
+#ifdef CONFIG_NUMASLAB
+			memsize = sizeof(void*)*cachep->limit+sizeof(cpucache_t);
+			nc = kmalloc(memsize, GFP_KERNEL);
+			if (!nc)
+				goto bad;
+			nc->avail = 0;
+			nc->limit = cachep->limit;
+			nc->batchcount = cachep->limit;
+			nc->touched = 0;
 
+			spin_lock_irq(&cachep->spinlock);
+			cachep->cpudata[cpu].alien = nc;
+			cachep->free_limit = (1+num_online_cpus())*cachep->batchcount
+						+ cachep->num;
+			spin_unlock_irq(&cachep->spinlock);
+#endif
 		}
 
 		if (g_cpucache_up == FULL)
@@ -610,15 +662,51 @@
 
 static struct notifier_block cpucache_notifier = { &cpuup_callback, NULL, 0 };
 
+#ifdef CONFIG_SLAB_NUMA
+/*
+ * NUMA: check where ptr points, and select the appropriate storage
+ * 	for the object.
+ */
+
+static inline int ptr_to_node(void *obj)
+{
+	return 0;	/* FIXME */
+}
+static inline struct cpucache_s * cc_data_ptr(kmem_cache_t *cachep, void *objp)
+{
+	if (ptr_to_node(objp) == __cpu_to_node(smp_processor_id()))
+		return cachep->cpudata[smp_processor_id()].native;
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
+	cc_data(&cache_cache) = &cpuarray_cache.cache;
+
 	cache_estimate(0, cache_cache.objsize, 0,
 			&left_over, &cache_cache.num);
 	if (!cache_cache.num)
@@ -678,20 +766,38 @@
 	 */
 	{
 		void * ptr;
+#ifdef CONFIG_SLAB_NUMA
+		void * ptr2;
+#endif
 		
 		ptr = kmalloc(sizeof(struct cpucache_int), GFP_KERNEL);
+#ifdef CONFIG_SLAB_NUMA
+		ptr2 = kmalloc(sizeof(struct cpucache_int), GFP_KERNEL);
+#endif
 		local_irq_disable();
-		BUG_ON(cc_data(&cache_cache) != &cpuarray_cache.cache);
-		memcpy(ptr, cc_data(&cache_cache), sizeof(struct cpucache_int));
-		cc_data(&cache_cache) = ptr;
+		BUG_ON(cache_cache.cpudata[0].native != &cpuarray_cache.cache);
+		memcpy(ptr, cache_cache.cpudata[0].native, sizeof(struct cpucache_int));
+		cache_cache.cpudata[0].native = ptr;
+#ifdef CONFIG_SLAB_NUMA
+		memcpy(ptr2, ptr, sizeof(struct cpucache_int));
+		cache_cache.cpudata[0].alien = ptr2;
+#endif
 		local_irq_enable();
 	
 		ptr = kmalloc(sizeof(struct cpucache_int), GFP_KERNEL);
+#ifdef CONFIG_SLAB_NUMA
+		ptr2 = kmalloc(sizeof(struct cpucache_int), GFP_KERNEL);
+#endif
 		local_irq_disable();
-		BUG_ON(cc_data(cache_sizes[0].cs_cachep) != &cpuarray_generic.cache);
-		memcpy(ptr, cc_data(cache_sizes[0].cs_cachep),
+		BUG_ON(cache_sizes[0].cs_cachep->cpudata[0].native !=
+				&cpuarray_generic.cache);
+		memcpy(ptr, cache_sizes[0].cs_cachep->cpudata[0].native,
 				sizeof(struct cpucache_int));
-		cc_data(cache_sizes[0].cs_cachep) = ptr;
+		cache_sizes[0].cs_cachep->cpudata[0].native = ptr;
+#ifdef CONFIG_SLAB_NUMA
+		memcpy(ptr2, ptr, sizeof(struct cpucache_int));
+		cache_sizes[0].cs_cachep->cpudata[0].alien = ptr2;
+#endif
 		local_irq_enable();
 	}
 }
@@ -871,6 +977,7 @@
 	const char *func_nm = KERN_ERR "kmem_create: ";
 	size_t left_over, align, slab_size;
 	kmem_cache_t *cachep = NULL;
+	int i;
 
 	/*
 	 * Sanity checks... these are all serious usage bugs.
@@ -1021,10 +1128,11 @@
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
@@ -1044,20 +1152,35 @@
 			g_cpucache_up = PARTIAL;
 		} else {
 			cc_data(cachep) = kmalloc(sizeof(struct cpucache_int),GFP_KERNEL);
+#ifdef CONFIG_SLAB_NUMA
+			cachep->cpudata[smp_processor_id()].alien =
+				kmalloc(sizeof(struct cpucache_int),GFP_KERNEL);
+#endif
 		}
 		BUG_ON(!cc_data(cachep));
 		cc_data(cachep)->avail = 0;
 		cc_data(cachep)->limit = BOOT_CPUCACHE_ENTRIES;
 		cc_data(cachep)->batchcount = 1;
 		cc_data(cachep)->touched = 0;
+#ifdef CONFIG_SLAB_NUMA
+		if (cachep->cpudata[smp_processor_id()].alien) {
+			cachep->cpudata[smp_processor_id()].alien->avail = 0;
+			cachep->cpudata[smp_processor_id()].alien->limit = BOOT_CPUCACHE_ENTRIES;
+			cachep->cpudata[smp_processor_id()].alien->batchcount = 1;
+			cachep->cpudata[smp_processor_id()].alien->touched = 0;
+		}
+#endif
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
@@ -1151,38 +1274,41 @@
 }
 
 
-/* NUMA shrink all list3s */
 static int __cache_shrink(kmem_cache_t *cachep)
 {
 	slab_t *slabp;
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
 
-		slabp = list_entry(cachep->lists.slabs_free.prev, slab_t, list);
+			slabp = list_entry(cachep->lists[i].slabs_free.prev, slab_t, list);
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
@@ -1242,9 +1368,12 @@
 	}
 	{
 		int i;
-		for (i = 0; i < NR_CPUS; i++)
-			kfree(cachep->cpudata[i]);
-		/* NUMA: free the list3 structures */
+		for (i = 0; i < NR_CPUS; i++) {
+			kfree(cachep->cpudata[i].native);
+#ifdef CONFIG_SLAB_NUMA
+			kfree(cachep->cpudata[i].alien);
+#endif
+		}
 	}
 	kmem_cache_free(&cache_cache, cachep);
 
@@ -1674,21 +1803,18 @@
 	return objp;
 }
 
-/* 
- * NUMA: different approach needed if the spinlock is moved into
- * the l3 structure
- */
-
 static inline void __free_block (kmem_cache_t* cachep, void** objpp, int len)
 {
 	check_irq_off();
 	spin_lock(&cachep->spinlock);
-	/* NUMA: move add into loop */
-	cachep->lists.free_objects += len;
+#ifndef CONFIG_SLAB_NUMA
+	cachep->lists[0].free_objects += len;
+#endif
 
 	for ( ; len > 0; len--, objpp++) {
 		slab_t* slabp;
 		void *objp = *objpp;
+		DEFINE_NUMALIST_PTR(l3);
 
 		slabp = GET_PAGE_SLAB(virt_to_page(objp));
 		list_del(&slabp->list);
@@ -1700,21 +1826,25 @@
 		}
 		STATS_DEC_ACTIVE(cachep);
 	
+		set_numalist_ptr(l3, cachep, objp);
+#ifdef CONFIG_SLAB_NUMA
+		l3->free_objects++;
+#endif
 		/* fixup slab chains */
 		if (unlikely(!--slabp->inuse)) {
-			if (cachep->lists.free_objects > cachep->free_limit) {
-				cachep->lists.free_objects -= cachep->num;
+			if (access_numalist_ptr(cachep, l3)->free_objects > cachep->free_limit) {
+				access_numalist_ptr(cachep, l3)->free_objects -= cachep->num;
 				slab_destroy(cachep, slabp);
 			} else {
 				list_add(&slabp->list,
-						&list3_data_ptr(cachep, objp)->slabs_free);
+						&(access_numalist_ptr(cachep, l3)->slabs_free));
 			}
 		} else {
 			/* Unconditionally move a slab to the end of the
 			 * partial list on free - maximum time for the
 			 * other objects to be freed, too.
 			 */
-			list_add_tail(&slabp->list, &list3_data_ptr(cachep, objp)->slabs_partial);
+			list_add_tail(&slabp->list, &(access_numalist_ptr(cachep, l3)->slabs_partial));
 		}
 	}
 	spin_unlock(&cachep->spinlock);
@@ -1906,6 +2036,9 @@
 struct ccupdate_struct {
 	kmem_cache_t *cachep;
 	cpucache_t *new[NR_CPUS];
+#ifdef CONFIG_SLAB_NUMA
+	cpucache_t *new_alien[NR_CPUS];
+#endif
 };
 
 static void do_ccupdate_local(void *info)
@@ -1914,10 +2047,15 @@
 	cpucache_t *old;
 
 	check_irq_off();
-	old = cc_data(new->cachep);
-	
-	cc_data(new->cachep) = new->new[smp_processor_id()];
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
 
 
@@ -1941,6 +2079,19 @@
 		ccnew->batchcount = batchcount;
 		ccnew->touched = 0;
 		new.new[i] = ccnew;
+#ifdef CONFIG_SLAB_NUMA
+		ccnew = kmalloc(sizeof(void*)*limit+
+				sizeof(cpucache_t), GFP_KERNEL);
+		if (!ccnew) {
+			for (i--; i >= 0; i--) kfree(new.new[i]);
+			return -ENOMEM;
+		}
+		ccnew->avail = 0;
+		ccnew->limit = limit;
+		ccnew->batchcount = limit;
+		ccnew->touched = 0;
+		new.new_alien[i] = ccnew;
+#endif
 	}
 	new.cachep = cachep;
 
@@ -1954,13 +2105,22 @@
 	spin_unlock_irq(&cachep->spinlock);
 
 	for (i = 0; i < NR_CPUS; i++) {
-		cpucache_t* ccold = new.new[i];
-		if (!ccold)
-			continue;
-		local_irq_disable();
-		free_block(cachep, cc_entry(ccold), ccold->avail);
-		local_irq_enable();
-		kfree(ccold);
+		cpucache_t* ccold;
+		
+		ccold = new.new[i];
+		if (ccold) {
+			local_irq_disable();
+			free_block(cachep, cc_entry(ccold), ccold->avail);
+			local_irq_enable();
+			kfree(ccold);
+		}
+		ccold = new.new_alien[i];
+		if (ccold) {
+			local_irq_disable();
+			free_block(cachep, cc_entry(ccold), ccold->avail);
+			local_irq_enable();
+			kfree(ccold);
+		}
 	}
 	return 0;
 }
@@ -2010,6 +2170,7 @@
 		int tofree;
 		cpucache_t *cc;
 		slab_t *slabp;
+		DEFINE_NUMALIST_PTR(l3);
 
 		searchp = list_entry(walk, kmem_cache_t, next);
 
@@ -2031,16 +2192,22 @@
 			memmove(&cc_entry(cc)[0], &cc_entry(cc)[tofree],
 					sizeof(void*)*cc->avail);
 		}
-		if(time_after(searchp->lists.next_reap, jiffies))
+#ifdef CONFIG_SLAB_NUMA
+		cc = searchp->cpudata[smp_processor_id()].alien;
+		free_block(searchp, cc_entry(cc), cc->avail);
+		cc->avail = 0;
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
 
@@ -2060,7 +2227,7 @@
 			 * searchp cannot disappear, we hold
 			 * cache_chain_lock
 			 */
-			searchp->lists.free_objects -= searchp->num;
+			access_numalist_ptr(searchp, l3)->free_objects -= searchp->num;
 			spin_unlock_irq(&searchp->spinlock);
 			slab_destroy(searchp, slabp);
 			spin_lock_irq(&searchp->spinlock);
@@ -2128,6 +2295,7 @@
 	unsigned long	active_slabs = 0;
 	unsigned long	num_slabs;
 	const char *name; 
+	int i;
 
 	if (p == (void*)1) {
 		/*
@@ -2146,28 +2314,32 @@
 	spin_lock_irq(&cachep->spinlock);
 	active_objs = 0;
 	num_slabs = 0;
-	list_for_each(q,&cachep->lists.slabs_full) {
-		slabp = list_entry(q, slab_t, list);
-		if (slabp->inuse != cachep->num)
-			BUG();
-		active_objs += cachep->num;
-		active_slabs++;
-	}
-	list_for_each(q,&cachep->lists.slabs_partial) {
-		slabp = list_entry(q, slab_t, list);
-		BUG_ON(slabp->inuse == cachep->num || !slabp->inuse);
-		active_objs += slabp->inuse;
-		active_slabs++;
-	}
-	list_for_each(q,&cachep->lists.slabs_free) {
-		slabp = list_entry(q, slab_t, list);
-		if (slabp->inuse)
-			BUG();
-		num_slabs++;
+	for (i=0;i<MAX_NUMNODES;i++) {
+		list_for_each(q,&cachep->lists[i].slabs_full) {
+			slabp = list_entry(q, slab_t, list);
+			if (slabp->inuse != cachep->num)
+				BUG();
+			active_objs += cachep->num;
+			active_slabs++;
+		}
+		list_for_each(q,&cachep->lists[i].slabs_partial) {
+			slabp = list_entry(q, slab_t, list);
+			BUG_ON(slabp->inuse == cachep->num || !slabp->inuse);
+			active_objs += slabp->inuse;
+			active_slabs++;
+		}
+		list_for_each(q,&cachep->lists[i].slabs_free) {
+			slabp = list_entry(q, slab_t, list);
+			if (slabp->inuse)
+				BUG();
+			num_slabs++;
+		}
 	}
 	num_slabs+=active_slabs;
 	num_objs = num_slabs*cachep->num;
-	BUG_ON(num_objs - active_objs != cachep->lists.free_objects);
+#ifndef CONFIG_SLAB_NUMA
+	BUG_ON(num_objs - active_objs != cachep->lists[0].free_objects);
+#endif
 
 	name = cachep->name; 
 	{

--------------050104010903010307000200--

