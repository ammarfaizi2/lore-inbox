Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313567AbSDZA5m>; Thu, 25 Apr 2002 20:57:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313569AbSDZA5l>; Thu, 25 Apr 2002 20:57:41 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:23301 "HELO holly.csn.ul.ie")
	by vger.kernel.org with SMTP id <S313567AbSDZA5f>;
	Thu, 25 Apr 2002 20:57:35 -0400
Date: Fri, 26 Apr 2002 01:57:29 +0100 (IST)
From: Mel <mel@csn.ul.ie>
X-X-Sender: mel@skynet
To: linux-kernel@vger.kernel.org
Subject: slab.c comments patch and doc
Message-ID: <Pine.LNX.4.44.0204260146220.16148-100000@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a first cut effort patch against 2.4.19pre7 at improving the
documentation for the slab allocator.  These are pretty minor changes and
none involving code.

The main work into this is at
http://www.csn.ul.ie/~mel/projects/vm/docs/slab.html which is a verbose
document that tries to explain the slab allocator. It covers most of the
slab allocator with the per cpu cache been the only major absense.

I'd really appreciate it if people took a look at the patch and the doc to
make sure there is no glaring errors in it. As I'll eventually be
submitting docs on each part of the VM for the Documentation/vm directory,
the less errors in it, the better :-)

Thanks

			Mel Gorman



--- /usr/src/linux-2.4.19pre7.orig/mm/slab.c	Tue Apr 16 20:36:49 2002
+++ /usr/src/linux-2.4.19pre7.mel/mm/slab.c	Fri Apr 26 01:45:05 2002
@@ -173,8 +173,11 @@
 	unsigned int limit;
 } cpucache_t;

+/* Returns back the next cpucache_t struct */
 #define cc_entry(cpucache) \
 	((void **)(((cpucache_t*)(cpucache))+1))
+
+/* Returns back the cpucachet struct for this processor */
 #define cc_data(cachep) \
 	((cachep)->cpudata[smp_processor_id()])
 /*
@@ -196,7 +199,8 @@
 	unsigned int		num;	/* # of objs per slab */
 	spinlock_t		spinlock;
 #ifdef CONFIG_SMP
-	unsigned int		batchcount;
+	/* Number of objects allocated to a CPU cache in one batch */
+	unsigned int		batchcount;
 #endif

 /* 2) slab additions /removals */
@@ -300,6 +304,11 @@

 #endif

+/* QUERY: Would it make more sense to make this value related to MAX_GFP_ORDER
+ *        like MAX_GFP_ORDER / 2 . Evaluates to the same thing but 5 is a magic
+ *        number where as MAX_GFP_ORDER / 2 says "at least have two objects
+ *        in a slab"
+ */
 /* maximum size of an obj (in 2^order pages) */
 #define	MAX_OBJ_ORDER	5	/* 32 pages */

@@ -315,10 +324,10 @@
  */
 #define	MAX_GFP_ORDER	5	/* 32 pages */

-
-/* Macros for storing/retrieving the cachep and or slab from the
- * global 'mem_map'. These are used to find the slab an obj belongs to.
- * With kfree(), these are used to find the cache which an obj belongs to.
+/*
+ * The slab_t and cache_t a page belongs to is stored on the
+ * struct page->list . This macros will retrieve set and retrieve it.
+ * With kfree(), these are used to find the cache which an obj belongs to
  */
 #define	SET_PAGE_CACHE(pg,x)  ((pg)->list.next = (struct list_head *)(x))
 #define	GET_PAGE_CACHE(pg)    ((kmem_cache_t *)(pg)->list.next)
@@ -395,6 +404,7 @@
 		base = sizeof(slab_t);
 		extra = sizeof(kmem_bufctl_t);
 	}
+	/* Keep trying to pack in objects until we run out of space */
 	i = 0;
 	while (i*size + L1_CACHE_ALIGN(base+i*extra) <= wastage)
 		i++;
@@ -520,6 +530,12 @@
 }

 #if DEBUG
+/*
+ * kmem_poison_obj - Poison an object
+ *
+ * This fills an object with POISON_BYTE bytes and marks the end with
+ * POISON_END. It's used to catch overruns
+ */
 static inline void kmem_poison_obj (kmem_cache_t *cachep, void *addr)
 {
 	int size = cachep->objsize;
@@ -531,6 +547,13 @@
 	*(unsigned char *)(addr+size-1) = POISON_END;
 }

+/*
+ * kmem_check_poison_obj - Make sure an object hasn't been overrun
+ *
+ * This will make sure an object hasn't been used prematurly or is
+ * overlapping with another object by making sure the marker POISON_END
+ * is at the right place
+ */
 static inline int kmem_check_poison_obj (kmem_cache_t *cachep, void *addr)
 {
 	int size = cachep->objsize;
@@ -738,8 +761,10 @@
 		}

 		/*
-		 * Large num of objs is good, but v. large slabs are currently
-		 * bad for the gfp()s.
+		 * The Buddy Allocator will suffer if it has to deal with
+		 * too many allocators of a large order. So while large
+		 * numbers of objects is good, large orders are not so
+		 * slab_break_gfp_order forces a balance
 		 */
 		if (cachep->gfporder >= slab_break_gfp_order)
 			break;
@@ -800,7 +825,10 @@
 	if (g_cpucache_up)
 		enable_cpucache(cachep);
 #endif
-	/* Need the semaphore to access the chain. */
+	/*
+	 * Need the semaphore to access the chain. Cycle through the chain
+	 * to make sure there isn't a cache of the same name available.
+	 */
 	down(&cache_chain_sem);
 	{
 		struct list_head *p;
@@ -869,6 +897,14 @@
 	cpucache_t *new[NR_CPUS];
 } ccupdate_struct_t;

+/*
+ * do_ccupdate_local - Copy the cachep data from info into the cachep
+ *
+ * When this function is called, info is a local variable of type
+ * ccupdate_struct_t . The job of this function is to take all the
+ * information in it and copy it into the cpudata array in the
+ * cachep
+ */
 static void do_ccupdate_local(void *info)
 {
 	ccupdate_struct_t *new = (ccupdate_struct_t *)info;
@@ -880,18 +916,29 @@

 static void free_block (kmem_cache_t* cachep, void** objpp, int len);

+/*
+ * drain_cpu_caches - Remove all free objects kept spare for a CPU
+ *
+ * kmem_cache_alloc_batch allocates a block of objects that are reserved
+ * for the use of that CPU. This function is called during kmem_cache_shrink
+ * so the objects need to be freed
+ */
 static void drain_cpu_caches(kmem_cache_t *cachep)
 {
 	ccupdate_struct_t new;
 	int i;

+	/* new is an array of cpucache_t */
 	memset(&new.new,0,sizeof(new.new));

 	new.cachep = cachep;

 	down(&cache_chain_sem);
+
+	/* Update all the local CPU caches to show they are now empty */
 	smp_call_function_all_cpus(do_ccupdate_local, (void *)&new);

+	/* For every cpu, free all the avail objects they have */
 	for (i = 0; i < smp_num_cpus; i++) {
 		cpucache_t* ccold = new.new[cpu_logical_map(i)];
 		if (!ccold || (ccold->avail == 0))
@@ -901,7 +948,10 @@
 		local_irq_enable();
 		ccold->avail = 0;
 	}
+
+	/* QUERY: Why do we set it twice, wasn't it set above? */
 	smp_call_function_all_cpus(do_ccupdate_local, (void *)&new);
+
 	up(&cache_chain_sem);
 }

@@ -940,6 +990,12 @@
 	return ret;
 }

+/*
+ * __kmem_cache_shrink - Shrink a cache
+ *
+ * Shrinks a cache and returns if the cache is totally free or not. Used when
+ * trying to destroy a cache
+ */
 static int __kmem_cache_shrink(kmem_cache_t *cachep)
 {
 	int ret;
@@ -974,6 +1030,7 @@
 	ret = __kmem_cache_shrink_locked(cachep);
 	spin_unlock_irq(&cachep->spinlock);

+	/* Number of slabs returned << gfporder gives number of pages freed */
 	return ret << cachep->gfporder;
 }

@@ -1053,6 +1110,15 @@
 	return slabp;
 }

+/*
+ * kmem_cache_init_objs - Initialise all objects in a slab
+ *
+ * Called once by kmem_cache_grow. It creates all the objects for the slab
+ * and calls the constructor if there is one available. If debugging is
+ * available, either end of an object will be marked with RED_MAGIC1 to
+ * catch overruns. Then the object will be poisoned with a known pattern
+ *
+ */
 static inline void kmem_cache_init_objs (kmem_cache_t * cachep,
 			slab_t * slabp, unsigned long ctor_flags)
 {
@@ -1082,6 +1148,12 @@
 		if (cachep->flags & SLAB_POISON)
 			/* need to poison the objs */
 			kmem_poison_obj(cachep, objp);
+
+		/* QUERY: Is it really necessary to check this now? We
+		 *        just wrote them above ago unless the objp
+		 *        pointers were totally screwed, this isn't
+		 *        going to be true surely?
+		 */
 		if (cachep->flags & SLAB_RED_ZONE) {
 			if (*((unsigned long*)(objp)) != RED_MAGIC1)
 				BUG();
@@ -1115,6 +1187,11 @@
 	 */
 	if (flags & ~(SLAB_DMA|SLAB_LEVEL_MASK|SLAB_NO_GROW))
 		BUG();
+
+	/* QUERY: Dead check? Wouldn't BUG() have above have prevented getting
+	         Or is having SLAB_NO_GROW in here not a bug at all and
+	 *        the previous check is bogus?
+	 */
 	if (flags & SLAB_NO_GROW)
 		return 0;

@@ -1167,7 +1244,7 @@
 	if (!(slabp = kmem_cache_slabmgmt(cachep, objp, offset, local_flags)))
 		goto opps1;

-	/* Nasty!!!!!! I hope this is OK. */
+	/* For each page used for the slab, attach the cachep and slabp */
 	i = 1 << cachep->gfporder;
 	page = virt_to_page(objp);
 	do {
@@ -1226,6 +1303,13 @@
 }
 #endif

+/*
+ * kmem_cache_alloc_head - Simple debugging checks before and object is
+ * allocated
+ *
+ * Asserts that the wrong combination of SLAB_DMA and GFP_DMA is not in
+ * use.
+ */
 static inline void kmem_cache_alloc_head(kmem_cache_t *cachep, int flags)
 {
 	if (flags & SLAB_DMA) {
@@ -1237,6 +1321,7 @@
 	}
 }

+/* kmem_cache_alloc_one_tail - Allocate one object from the slab provided */
 static inline void * kmem_cache_alloc_one_tail (kmem_cache_t *cachep,
 						slab_t *slabp)
 {
@@ -1249,6 +1334,13 @@
 	/* get obj pointer */
 	slabp->inuse++;
 	objp = slabp->s_mem + slabp->free*cachep->objsize;
+
+	/* QUERY: This moves free onto the next object. However, during
+	 *        kmem_cache_free_one, the free is pointed to the object
+	 *        been freed. Lets say the one freed pointed into the middle
+	 *        of an allocated group of objects. free now points to
+	 *        an allocated object. bug?
+	 */
 	slabp->free=slab_bufctl(slabp)[slabp->free];

 	if (unlikely(slabp->free == BUFCTL_END)) {
@@ -1300,6 +1392,12 @@
 })

 #ifdef CONFIG_SMP
+/*
+ * kmem_cache_alloc_batch - Allocate multiple objects and store in cache
+ *
+ * This function will allocate a number of objects for a slab and keep a
+ * reference to them in the local cpucache_t entry.
+ */
 void* kmem_cache_alloc_batch(kmem_cache_t* cachep, cpucache_t* cc, int flags)
 {
 	int batchcount = cachep->batchcount;
@@ -1308,13 +1406,16 @@
 	while (batchcount--) {
 		struct list_head * slabs_partial, * entry;
 		slab_t *slabp;
-		/* Get slab alloc is to come from. */
+
+		/* Get slab alloc is to come from */
 		slabs_partial = &(cachep)->slabs_partial;
 		entry = slabs_partial->next;
 		if (unlikely(entry == slabs_partial)) {
 			struct list_head * slabs_free;
 			slabs_free = &(cachep)->slabs_free;
 			entry = slabs_free->next;
+
+			/* no partial or free slab. call kmem_cache_grow */
 			if (unlikely(entry == slabs_free))
 				break;
 			list_del(entry);
@@ -1322,6 +1423,8 @@
 		}

 		slabp = list_entry(entry, slab_t, list);
+
+		/* Increment the number of avail objects for this CPU cache */
 		cc_entry(cc)[cc->avail++] =
 				kmem_cache_alloc_one_tail(cachep, slabp);
 	}
@@ -1333,6 +1436,7 @@
 }
 #endif

+/* __kmem_cache_alloc - Allocate an object from a slab */
 static inline void * __kmem_cache_alloc (kmem_cache_t *cachep, int flags)
 {
 	unsigned long save_flags;
@@ -1340,9 +1444,13 @@

 	kmem_cache_alloc_head(cachep, flags);
 try_again:
+
+	/* QUERY: Is this really needed for the UP case? */
 	local_irq_save(save_flags);
+
 #ifdef CONFIG_SMP
 	{
+		/* Check to see can we allocate from the CPU cache */
 		cpucache_t *cc = cc_data(cachep);

 		if (cc) {
@@ -1366,6 +1474,8 @@
 #endif
 	local_irq_restore(save_flags);
 	return objp;
+
+/* kmem_cache_alloc_one contains a goto to this label */
 alloc_new_slab:
 #ifdef CONFIG_SMP
 	spin_unlock(&cachep->spinlock);
@@ -1446,8 +1556,14 @@
 		return;
 #endif
 	{
+		/* Set free to point to this object now that it has been
+		 * freed.
+		 *
+		 * QUERY: This could introduce problems during the next
+		 *        alloc_one. see kmem_cache_alloc_one_tail for
+		 *        details.
+		 */
 		unsigned int objnr = (objp-slabp->s_mem)/cachep->objsize;
-
 		slab_bufctl(slabp)[objnr] = slabp->free;
 		slabp->free = objnr;
 	}
@@ -1476,6 +1592,11 @@
 		kmem_cache_free_one(cachep, *objpp);
 }

+/* free_block - Free a number of objects placed together
+ *
+ * Of primary interest to the per CPU cache which will have a number of
+ * objects placed together
+ */
 static void free_block (kmem_cache_t* cachep, void** objpp, int len)
 {
 	spin_lock(&cachep->spinlock);
@@ -1554,6 +1675,7 @@
 {
 	cache_sizes_t *csizep = cache_sizes;

+	/* QUERY: Use kmem_find_general_cachep? */
 	for (; csizep->cs_size; csizep++) {
 		if (size > csizep->cs_size)
 			continue;
@@ -1600,12 +1722,18 @@
 	if (!objp)
 		return;
 	local_irq_save(flags);
+
+	/* CHECK\_PAGE makes sure this is a slab cache. */
 	CHECK_PAGE(virt_to_page(objp));
+
+	/* The struct page list stores the pointer to the kmem_cache_t */
 	c = GET_PAGE_CACHE(virt_to_page(objp));
+
 	__kmem_cache_free(c, (void*)objp);
 	local_irq_restore(flags);
 }

+/* kmem_find_general_cachep - Find a general cache large enough for size */
 kmem_cache_t * kmem_find_general_cachep (size_t size, int gfpflags)
 {
 	cache_sizes_t *csizep = cache_sizes;
@@ -1624,9 +1752,15 @@

 #ifdef CONFIG_SMP

-/* called with cache_chain_sem acquired.  */
+/*
+ * kmem_tune_cpucache - Create and tune the per CPU caches
+ *
+ * This function is responsible for creating a cpucache_t for each CPU.
+ * It sets an appropriate limit and avail based on batchcount
+ */
 static int kmem_tune_cpucache (kmem_cache_t* cachep, int limit, int batchcount)
 {
+	/* Static struct large enough to store data on NR_CPU CPU's */
 	ccupdate_struct_t new;
 	int i;

@@ -1644,6 +1778,10 @@

 	memset(&new.new,0,sizeof(new.new));
 	if (limit) {
+		/*
+		 * Create smp_num_cpus number of cpucache_t and place them
+		 * in the ccupdate_struct_t struct new
+		 */
 		for (i = 0; i< smp_num_cpus; i++) {
 			cpucache_t* ccnew;

@@ -1661,8 +1799,10 @@
 	cachep->batchcount = batchcount;
 	spin_unlock_irq(&cachep->spinlock);

+	/* Copy the information from new into cachep */
 	smp_call_function_all_cpus(do_ccupdate_local, (void *)&new);

+	/* This clears all objects in all CPU caches */
 	for (i = 0; i < smp_num_cpus; i++) {
 		cpucache_t* ccold = new.new[cpu_logical_map(i)];
 		if (!ccold)
@@ -1672,6 +1812,7 @@
 		local_irq_enable();
 		kfree(ccold);
 	}
+
 	return 0;
 oom:
 	for (i--; i >= 0; i--)
@@ -1679,6 +1820,12 @@
 	return -ENOMEM;
 }

+/*
+ * enable_cpucache
+ *
+ * Find a good size for limit based on the size of the objects and create
+ * the CPU caches with kmem_tune_cpucache
+ */
 static void enable_cpucache (kmem_cache_t *cachep)
 {
 	int err;
@@ -1762,6 +1909,7 @@
 		}
 #ifdef CONFIG_SMP
 		{
+			/* Free the per CPU cache */
 			cpucache_t *cc = cc_data(searchp);
 			if (cc && cc->avail) {
 				__free_block(searchp, cc_entry(cc), cc->avail);
@@ -1772,6 +1920,8 @@

 		full_free = 0;
 		p = searchp->slabs_free.next;
+
+		/* Count the number of free slabs (full_free) */
 		while (p != &searchp->slabs_free) {
 			slabp = list_entry(p, slab_t, list);
 #if DEBUG
@@ -1820,7 +1970,11 @@
 	best_len = (best_len + 1)/2;
 	for (scan = 0; scan < best_len; scan++) {
 		struct list_head *p;
-
+
+		/*
+		 * QUERY: useless check? The search above always skips over
+		 *        caches that are growing.
+		 */
 		if (best_cachep->growing)
 			break;
 		p = best_cachep->slabs_free.prev;
@@ -1842,6 +1996,8 @@
 		spin_lock_irq(&best_cachep->spinlock);
 	}
 	spin_unlock_irq(&best_cachep->spinlock);
+
+	/* Return number of pages freed */
 	ret = scan * (1 << best_cachep->gfporder);
 out:
 	up(&cache_chain_sem);

