Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315415AbSHFTbg>; Tue, 6 Aug 2002 15:31:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315445AbSHFTbg>; Tue, 6 Aug 2002 15:31:36 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:21004 "HELO holly.csn.ul.ie")
	by vger.kernel.org with SMTP id <S315415AbSHFT34>;
	Tue, 6 Aug 2002 15:29:56 -0400
Date: Tue, 6 Aug 2002 20:33:29 +0100 (IST)
From: Mel <mel@csn.ul.ie>
X-X-Sender: mel@skynet
To: marcelo@conectiva.com.br
Cc: linux-kernel@vger.kernel.org
Subject: [patch 4/5] slab commentry
Message-ID: <Pine.LNX.4.44.0208062021010.14917-100000@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a commentry patch documenting a bit more how the slab allocator
works. No code is changed. Please apply

Mel Gorman
MSc Student, University of Limerick
http://www.csn.ul.ie/~mel


--- linux-2.4.19/mm/slab.c	Sat Aug  3 01:39:46 2002
+++ linux-2.4.19-mel/mm/slab.c	Tue Aug  6 18:25:32 2002
@@ -175,10 +175,14 @@
 	unsigned int limit;
 } cpucache_t;

+/* Returns a pointer to the first object in the CPU cache */
 #define cc_entry(cpucache) \
 	((void **)(((cpucache_t*)(cpucache))+1))
+
+/* Returns the cpu cache struct for this processor */
 #define cc_data(cachep) \
 	((cachep)->cpudata[smp_processor_id()])
+
 /*
  * kmem_cache_t
  *
@@ -198,7 +202,8 @@
 	unsigned int		num;	/* # of objs per slab */
 	spinlock_t		spinlock;
 #ifdef CONFIG_SMP
-	unsigned int		batchcount;
+	/* Number of objects allocated to a CPU cache in one batch */
+	unsigned int		batchcount;
 #endif

 /* 2) slab additions /removals */
@@ -302,6 +307,12 @@

 #endif

+/*
+ * QUERY: Would it make more sense to make this value related to MAX_GFP_ORDER
+ *        like MAX_GFP_ORDER / 2 . Evaluates to the same thing but 5 is a magic
+ *        number where as MAX_GFP_ORDER / 2 says "at least have two objects
+ *        in a slab"
+ */
 /* maximum size of an obj (in 2^order pages) */
 #define	MAX_OBJ_ORDER	5	/* 32 pages */

@@ -317,10 +328,10 @@
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
@@ -397,6 +408,7 @@
 		base = sizeof(slab_t);
 		extra = sizeof(kmem_bufctl_t);
 	}
+	/* Keep trying to pack in objects until we run out of space */
 	i = 0;
 	while (i*size + L1_CACHE_ALIGN(base+i*extra) <= wastage)
 		i++;
@@ -522,6 +534,15 @@
 }

 #if DEBUG
+/**
+ *
+ * kmem_poison_obj - Poison an object with a known pattern
+ * @cachep: The cache the object belongs to
+ * @addr: The address of the object to be poisoned
+ *
+ * This fills an object with POISON_BYTE bytes and marks the end with
+ * POISON_END. It's used to catch overruns
+ */
 static inline void kmem_poison_obj (kmem_cache_t *cachep, void *addr)
 {
 	int size = cachep->objsize;
@@ -533,6 +554,16 @@
 	*(unsigned char *)(addr+size-1) = POISON_END;
 }

+/**
+ *
+ * kmem_check_poison_obj - Check an objects poisoned pattern for overruns
+ * @cachep: The cache the object belongs to
+ * @addr: The address of the object been checked
+ *
+ * This will make sure an object hasn't been used prematurly or is
+ * overlapping with another object by making sure the marker POISON_END
+ * is at the right place
+ */
 static inline int kmem_check_poison_obj (kmem_cache_t *cachep, void *addr)
 {
 	int size = cachep->objsize;
@@ -548,7 +579,8 @@
 }
 #endif

-/* Destroy all the objs in a slab, and release the mem back to the system.
+/*
+ * Destroy all the objs in a slab, and release the mem back to the system.
  * Before calling the slab must have been unlinked from the cache.
  * The cache-lock is not held/needed.
  */
@@ -740,8 +772,10 @@
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
@@ -802,7 +836,10 @@
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
@@ -871,6 +908,17 @@
 	cpucache_t *new[NR_CPUS];
 } ccupdate_struct_t;

+/**
+ *
+ * do_ccupdate_local - Swap the cachep data in 'info' with the cache descriptor
+ *
+ * When this function is called, info is a local variable of type
+ * ccupdate_struct_t . The job of this function is to take all the
+ * information in it and swap it with the CPU data in the cachep
+ * structure. As each CPU handles it's own data, a spinlock is
+ * unnecessary. The information is swapped rather than copied so
+ * that the caller can free the old memory
+ */
 static void do_ccupdate_local(void *info)
 {
 	ccupdate_struct_t *new = (ccupdate_struct_t *)info;
@@ -882,18 +930,33 @@

 static void free_block (kmem_cache_t* cachep, void** objpp, int len);

+/**
+ *
+ * drain_cpu_caches - Remove all free objects in a CPU cache
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
+	/*
+	 * Temporarily disable the per CPU cache by swapping in null pointers
+	 * from new
+	 */
 	smp_call_function_all_cpus(do_ccupdate_local, (void *)&new);

+	/* For every cpu, free all the avail objects they have */
 	for (i = 0; i < smp_num_cpus; i++) {
 		cpucache_t* ccold = new.new[cpu_logical_map(i)];
 		if (!ccold || (ccold->avail == 0))
@@ -903,7 +966,10 @@
 		local_irq_enable();
 		ccold->avail = 0;
 	}
+
+	/* Update the per CPU caches with the new empty caches */
 	smp_call_function_all_cpus(do_ccupdate_local, (void *)&new);
+
 	up(&cache_chain_sem);
 }

@@ -942,6 +1008,15 @@
 	return ret;
 }

+/**
+ *
+ * __kmem_cache_shrink - Shrink a cache
+ * @cachep: The cache to shrink
+ *
+ * Shrinks a cache and returns if the cache is totally free or not. The
+ * cache is shrunk by draining the per CPU cache and then deleting all
+ * free slabs.
+ */
 static int __kmem_cache_shrink(kmem_cache_t *cachep)
 {
 	int ret;
@@ -960,8 +1035,13 @@
  * kmem_cache_shrink - Shrink a cache.
  * @cachep: The cache to shrink.
  *
- * Releases as many slabs as possible for a cache.
- * Returns number of pages released.
+ * Shrinks a cache and returns the number of pages freed. The
+ * cache is shrunk by draining the per CPU cache and then deleting all
+ * free slabs.
+ *
+ * Note the difference between this and __kmem_cache_shrink. This function
+ * returns the pages free and the other returns a boolean indicating if
+ * there is partially filled or empty slabs remaining
  */
 int kmem_cache_shrink(kmem_cache_t *cachep)
 {
@@ -976,6 +1056,7 @@
 	ret = __kmem_cache_shrink_locked(cachep);
 	spin_unlock_irq(&cachep->spinlock);

+	/* Number of slabs returned << gfporder gives number of pages freed */
 	return ret << cachep->gfporder;
 }

@@ -1055,6 +1136,19 @@
 	return slabp;
 }

+/**
+ *
+ * kmem_cache_init_objs - Initialise all objects in a slab
+ * @cachep: The cache the objects belong to
+ * @slabp: The slab the objects belong to
+ * @ctor_flags: Flags to pass to the constructor function
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
@@ -1084,6 +1178,13 @@
 		if (cachep->flags & SLAB_POISON)
 			/* need to poison the objs */
 			kmem_poison_obj(cachep, objp);
+
+		/*
+		 * QUERY: Is it really necessary to check this now? They were
+		 *        just written above so unless the objp
+		 *        pointers were totally screwed, this isn't
+		 *        going to be true.
+		 */
 		if (cachep->flags & SLAB_RED_ZONE) {
 			if (*((unsigned long*)(objp)) != RED_MAGIC1)
 				BUG();
@@ -1117,6 +1218,11 @@
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

@@ -1169,7 +1275,7 @@
 	if (!(slabp = kmem_cache_slabmgmt(cachep, objp, offset, local_flags)))
 		goto opps1;

-	/* Nasty!!!!!! I hope this is OK. */
+	/* For each page used for the slab, attach the cachep and slabp */
 	i = 1 << cachep->gfporder;
 	page = virt_to_page(objp);
 	do {
@@ -1228,6 +1334,14 @@
 }
 #endif

+/**
+ *
+ * kmem_cache_alloc_head - Simple debugging checks before and object is
+ * allocated
+ *
+ * Asserts that the wrong combination of SLAB_DMA and GFP_DMA is not in
+ * use.
+ */
 static inline void kmem_cache_alloc_head(kmem_cache_t *cachep, int flags)
 {
 	if (flags & SLAB_DMA) {
@@ -1239,6 +1353,7 @@
 	}
 }

+/* kmem_cache_alloc_one_tail - Allocate one object from the slab provided */
 static inline void * kmem_cache_alloc_one_tail (kmem_cache_t *cachep,
 						slab_t *slabp)
 {
@@ -1251,6 +1366,7 @@
 	/* get obj pointer */
 	slabp->inuse++;
 	objp = slabp->s_mem + slabp->free*cachep->objsize;
+
 	slabp->free=slab_bufctl(slabp)[slabp->free];

 	if (unlikely(slabp->free == BUFCTL_END)) {
@@ -1302,6 +1418,13 @@
 })

 #ifdef CONFIG_SMP
+/**
+ *
+ * kmem_cache_alloc_batch - Allocate multiple objects and store in cache
+ *
+ * This function will allocate a number of objects for a slab and keep a
+ * reference to them in the local cpucache_t entry.
+ */
 void* kmem_cache_alloc_batch(kmem_cache_t* cachep, cpucache_t* cc, int flags)
 {
 	int batchcount = cachep->batchcount;
@@ -1310,13 +1433,16 @@
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
@@ -1324,6 +1450,8 @@
 		}

 		slabp = list_entry(entry, slab_t, list);
+
+		/* Increment the number of avail objects for this CPU cache */
 		cc_entry(cc)[cc->avail++] =
 				kmem_cache_alloc_one_tail(cachep, slabp);
 	}
@@ -1335,6 +1463,7 @@
 }
 #endif

+/* __kmem_cache_alloc - Allocate an object from a slab */
 static inline void * __kmem_cache_alloc (kmem_cache_t *cachep, int flags)
 {
 	unsigned long save_flags;
@@ -1342,9 +1471,12 @@

 	kmem_cache_alloc_head(cachep, flags);
 try_again:
+
 	local_irq_save(save_flags);
+
 #ifdef CONFIG_SMP
 	{
+		/* Check to see can we allocate from the CPU cache */
 		cpucache_t *cc = cc_data(cachep);

 		if (cc) {
@@ -1368,6 +1500,8 @@
 #endif
 	local_irq_restore(save_flags);
 	return objp;
+
+/* kmem_cache_alloc_one contains a goto to this label */
 alloc_new_slab:
 #ifdef CONFIG_SMP
 	spin_unlock(&cachep->spinlock);
@@ -1448,8 +1582,14 @@
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
@@ -1478,6 +1618,13 @@
 		kmem_cache_free_one(cachep, *objpp);
 }

+/**
+ *
+ * free_block - Free a number of objects placed together
+ *
+ * Of primary interest to the per CPU cache which will have a number of
+ * objects placed together
+ */
 static void free_block (kmem_cache_t* cachep, void** objpp, int len)
 {
 	spin_lock(&cachep->spinlock);
@@ -1556,6 +1703,7 @@
 {
 	cache_sizes_t *csizep = cache_sizes;

+	/* QUERY: Use kmem_find_general_cachep? */
 	for (; csizep->cs_size; csizep++) {
 		if (size > csizep->cs_size)
 			continue;
@@ -1602,12 +1750,18 @@
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
@@ -1626,14 +1780,25 @@

 #ifdef CONFIG_SMP

-/* called with cache_chain_sem acquired.  */
+/**
+ *
+ * kmem_tune_cpucache - Create or resize the per CPU caches
+ * @cachep: The cache been tuned
+ * @limit: The total number of objects reserved for a CPU
+ * @batchcount: How many objects to allocate in batch to the CPU cache
+ *
+ * This function is responsible for creating a cpucache_t for each CPU.
+ * It sets an appropriate limit and avail based on batchcount
+ */
 static int kmem_tune_cpucache (kmem_cache_t* cachep, int limit, int batchcount)
 {
+	/* Static struct large enough to store data on NR_CPU CPU's */
 	ccupdate_struct_t new;
 	int i;

 	/*
-	 * These are admin-provided, so we are more graceful.
+	 * These are admin-provided via the prox interface, so we are
+	 * more graceful.
 	 */
 	if (limit < 0)
 		return -EINVAL;
@@ -1646,6 +1811,10 @@

 	memset(&new.new,0,sizeof(new.new));
 	if (limit) {
+		/*
+		 * Create smp_num_cpus number of cpucache_t and place them
+		 * in the ccupdate_struct_t struct new
+		 */
 		for (i = 0; i< smp_num_cpus; i++) {
 			cpucache_t* ccnew;

@@ -1663,8 +1832,10 @@
 	cachep->batchcount = batchcount;
 	spin_unlock_irq(&cachep->spinlock);

+	/* Swap the new information with what is in the cache descriptor */
 	smp_call_function_all_cpus(do_ccupdate_local, (void *)&new);

+	/* new now contains the old per cpu cache so it can be deleted here */
 	for (i = 0; i < smp_num_cpus; i++) {
 		cpucache_t* ccold = new.new[cpu_logical_map(i)];
 		if (!ccold)
@@ -1674,6 +1845,7 @@
 		local_irq_enable();
 		kfree(ccold);
 	}
+
 	return 0;
 oom:
 	for (i--; i >= 0; i--)
@@ -1681,6 +1853,14 @@
 	return -ENOMEM;
 }

+/**
+ *
+ * enable_cpucache - Enable the per cpu object cache
+ * @cachep: The cache to enable the cpucaches for
+ *
+ * Find a good size for limit based on the size of the objects and create
+ * the CPU caches with kmem_tune_cpucache
+ */
 static void enable_cpucache (kmem_cache_t *cachep)
 {
 	int err;
@@ -1764,6 +1944,7 @@
 		}
 #ifdef CONFIG_SMP
 		{
+			/* Free the per CPU cache */
 			cpucache_t *cc = cc_data(searchp);
 			if (cc && cc->avail) {
 				__free_block(searchp, cc_entry(cc), cc->avail);
@@ -1774,6 +1955,8 @@

 		full_free = 0;
 		p = searchp->slabs_free.next;
+
+		/* Count the number of free slabs (full_free) */
 		while (p != &searchp->slabs_free) {
 			slabp = list_entry(p, slab_t, list);
 #if DEBUG
@@ -1822,7 +2005,11 @@
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
@@ -1844,6 +2031,8 @@
 		spin_lock_irq(&best_cachep->spinlock);
 	}
 	spin_unlock_irq(&best_cachep->spinlock);
+
+	/* Return number of pages freed */
 	ret = scan * (1 << best_cachep->gfporder);
 out:
 	up(&cache_chain_sem);


