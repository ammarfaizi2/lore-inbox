Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751120AbWANMrU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751120AbWANMrU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 07:47:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932248AbWANMqI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 07:46:08 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:11170 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1751120AbWANMqF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 07:46:05 -0500
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
Date: Sat, 14 Jan 2006 14:46:02 +0200
Message-Id: <20060114122407.971070000@localhost>
References: <20060114122249.246354000@localhost>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, manfred@colorfullife.com
Subject: [patch 01/10] slab: distinguish between object and buffer size
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Manfred Spraul <manfred@colorfullife.com>

An object cache has two different object lengths:

  - the amount of memory available for the user (object size)
  - the amount of memory allocated internally (buffer size)

This patch does some renames to make the code reflect that better.

Signed-off-by: Manfred Spraul <manfred@colorfullife.com>
Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
---

 mm/slab.c |  154 ++++++++++++++++++++++++++++++++------------------------------
 1 file changed, 80 insertions(+), 74 deletions(-)

Index: 2.6/mm/slab.c
===================================================================
--- 2.6.orig/mm/slab.c
+++ 2.6/mm/slab.c
@@ -373,7 +373,7 @@ struct kmem_cache {
 	unsigned int batchcount;
 	unsigned int limit;
 	unsigned int shared;
-	unsigned int objsize;
+	unsigned int buffer_size;
 /* 2) touched by every alloc & free from the backend */
 	struct kmem_list3 *nodelists[MAX_NUMNODES];
 	unsigned int flags;	/* constant flags */
@@ -421,8 +421,14 @@ struct kmem_cache {
 	atomic_t freemiss;
 #endif
 #if DEBUG
-	int dbghead;
-	int reallen;
+	/*
+	 * If debugging is enabled, then the allocator can add additional
+	 * fields and/or padding to every object. buffer_size contains the total
+	 * object size including these internal fields, the following two
+	 * variables contain the offset to the user object and its size.
+	 */
+	int obj_offset;
+	int obj_size;
 #endif
 };
 
@@ -493,50 +499,50 @@ struct kmem_cache {
 
 /* memory layout of objects:
  * 0		: objp
- * 0 .. cachep->dbghead - BYTES_PER_WORD - 1: padding. This ensures that
+ * 0 .. cachep->obj_offset - BYTES_PER_WORD - 1: padding. This ensures that
  * 		the end of an object is aligned with the end of the real
  * 		allocation. Catches writes behind the end of the allocation.
- * cachep->dbghead - BYTES_PER_WORD .. cachep->dbghead - 1:
+ * cachep->obj_offset - BYTES_PER_WORD .. cachep->obj_offset - 1:
  * 		redzone word.
- * cachep->dbghead: The real object.
- * cachep->objsize - 2* BYTES_PER_WORD: redzone word [BYTES_PER_WORD long]
- * cachep->objsize - 1* BYTES_PER_WORD: last caller address [BYTES_PER_WORD long]
+ * cachep->obj_offset: The real object.
+ * cachep->buffer_size - 2* BYTES_PER_WORD: redzone word [BYTES_PER_WORD long]
+ * cachep->buffer_size - 1* BYTES_PER_WORD: last caller address [BYTES_PER_WORD long]
  */
-static int obj_dbghead(kmem_cache_t *cachep)
+static int obj_offset(kmem_cache_t *cachep)
 {
-	return cachep->dbghead;
+	return cachep->obj_offset;
 }
 
-static int obj_reallen(kmem_cache_t *cachep)
+static int obj_size(kmem_cache_t *cachep)
 {
-	return cachep->reallen;
+	return cachep->obj_size;
 }
 
 static unsigned long *dbg_redzone1(kmem_cache_t *cachep, void *objp)
 {
 	BUG_ON(!(cachep->flags & SLAB_RED_ZONE));
-	return (unsigned long*) (objp+obj_dbghead(cachep)-BYTES_PER_WORD);
+	return (unsigned long*) (objp+obj_offset(cachep)-BYTES_PER_WORD);
 }
 
 static unsigned long *dbg_redzone2(kmem_cache_t *cachep, void *objp)
 {
 	BUG_ON(!(cachep->flags & SLAB_RED_ZONE));
 	if (cachep->flags & SLAB_STORE_USER)
-		return (unsigned long *)(objp + cachep->objsize -
+		return (unsigned long *)(objp + cachep->buffer_size -
 					 2 * BYTES_PER_WORD);
-	return (unsigned long *)(objp + cachep->objsize - BYTES_PER_WORD);
+	return (unsigned long *)(objp + cachep->buffer_size - BYTES_PER_WORD);
 }
 
 static void **dbg_userword(kmem_cache_t *cachep, void *objp)
 {
 	BUG_ON(!(cachep->flags & SLAB_STORE_USER));
-	return (void **)(objp + cachep->objsize - BYTES_PER_WORD);
+	return (void **)(objp + cachep->buffer_size - BYTES_PER_WORD);
 }
 
 #else
 
-#define obj_dbghead(x)			0
-#define obj_reallen(cachep)		(cachep->objsize)
+#define obj_offset(x)			0
+#define obj_size(cachep)		(cachep->buffer_size)
 #define dbg_redzone1(cachep, objp)	({BUG(); (unsigned long *)NULL;})
 #define dbg_redzone2(cachep, objp)	({BUG(); (unsigned long *)NULL;})
 #define dbg_userword(cachep, objp)	({BUG(); (void **)NULL;})
@@ -621,12 +627,12 @@ static kmem_cache_t cache_cache = {
 	.batchcount = 1,
 	.limit = BOOT_CPUCACHE_ENTRIES,
 	.shared = 1,
-	.objsize = sizeof(kmem_cache_t),
+	.buffer_size = sizeof(kmem_cache_t),
 	.flags = SLAB_NO_REAP,
 	.spinlock = SPIN_LOCK_UNLOCKED,
 	.name = "kmem_cache",
 #if DEBUG
-	.reallen = sizeof(kmem_cache_t),
+	.obj_size = sizeof(kmem_cache_t),
 #endif
 };
 
@@ -1054,9 +1060,9 @@ void __init kmem_cache_init(void)
 	cache_cache.array[smp_processor_id()] = &initarray_cache.cache;
 	cache_cache.nodelists[numa_node_id()] = &initkmem_list3[CACHE_CACHE];
 
-	cache_cache.objsize = ALIGN(cache_cache.objsize, cache_line_size());
+	cache_cache.buffer_size = ALIGN(cache_cache.buffer_size, cache_line_size());
 
-	cache_estimate(0, cache_cache.objsize, cache_line_size(), 0,
+	cache_estimate(0, cache_cache.buffer_size, cache_line_size(), 0,
 		       &left_over, &cache_cache.num);
 	if (!cache_cache.num)
 		BUG();
@@ -1271,9 +1277,9 @@ static void kmem_rcu_free(struct rcu_hea
 static void store_stackinfo(kmem_cache_t *cachep, unsigned long *addr,
 			    unsigned long caller)
 {
-	int size = obj_reallen(cachep);
+	int size = obj_size(cachep);
 
-	addr = (unsigned long *)&((char *)addr)[obj_dbghead(cachep)];
+	addr = (unsigned long *)&((char *)addr)[obj_offset(cachep)];
 
 	if (size < 5 * sizeof(unsigned long))
 		return;
@@ -1303,8 +1309,8 @@ static void store_stackinfo(kmem_cache_t
 
 static void poison_obj(kmem_cache_t *cachep, void *addr, unsigned char val)
 {
-	int size = obj_reallen(cachep);
-	addr = &((char *)addr)[obj_dbghead(cachep)];
+	int size = obj_size(cachep);
+	addr = &((char *)addr)[obj_offset(cachep)];
 
 	memset(addr, val, size);
 	*(unsigned char *)(addr + size - 1) = POISON_END;
@@ -1341,8 +1347,8 @@ static void print_objinfo(kmem_cache_t *
 			     (unsigned long)*dbg_userword(cachep, objp));
 		printk("\n");
 	}
-	realobj = (char *)objp + obj_dbghead(cachep);
-	size = obj_reallen(cachep);
+	realobj = (char *)objp + obj_offset(cachep);
+	size = obj_size(cachep);
 	for (i = 0; i < size && lines; i += 16, lines--) {
 		int limit;
 		limit = 16;
@@ -1358,8 +1364,8 @@ static void check_poison_obj(kmem_cache_
 	int size, i;
 	int lines = 0;
 
-	realobj = (char *)objp + obj_dbghead(cachep);
-	size = obj_reallen(cachep);
+	realobj = (char *)objp + obj_offset(cachep);
+	size = obj_size(cachep);
 
 	for (i = 0; i < size; i++) {
 		char exp = POISON_FREE;
@@ -1395,17 +1401,17 @@ static void check_poison_obj(kmem_cache_
 		struct slab *slabp = page_get_slab(virt_to_page(objp));
 		int objnr;
 
-		objnr = (objp - slabp->s_mem) / cachep->objsize;
+		objnr = (objp - slabp->s_mem) / cachep->buffer_size;
 		if (objnr) {
-			objp = slabp->s_mem + (objnr - 1) * cachep->objsize;
-			realobj = (char *)objp + obj_dbghead(cachep);
+			objp = slabp->s_mem + (objnr - 1) * cachep->buffer_size;
+			realobj = (char *)objp + obj_offset(cachep);
 			printk(KERN_ERR "Prev obj: start=%p, len=%d\n",
 			       realobj, size);
 			print_objinfo(cachep, objp, 2);
 		}
 		if (objnr + 1 < cachep->num) {
-			objp = slabp->s_mem + (objnr + 1) * cachep->objsize;
-			realobj = (char *)objp + obj_dbghead(cachep);
+			objp = slabp->s_mem + (objnr + 1) * cachep->buffer_size;
+			realobj = (char *)objp + obj_offset(cachep);
 			printk(KERN_ERR "Next obj: start=%p, len=%d\n",
 			       realobj, size);
 			print_objinfo(cachep, objp, 2);
@@ -1425,14 +1431,14 @@ static void slab_destroy(kmem_cache_t *c
 #if DEBUG
 	int i;
 	for (i = 0; i < cachep->num; i++) {
-		void *objp = slabp->s_mem + cachep->objsize * i;
+		void *objp = slabp->s_mem + cachep->buffer_size * i;
 
 		if (cachep->flags & SLAB_POISON) {
 #ifdef CONFIG_DEBUG_PAGEALLOC
-			if ((cachep->objsize % PAGE_SIZE) == 0
+			if ((cachep->buffer_size % PAGE_SIZE) == 0
 			    && OFF_SLAB(cachep))
 				kernel_map_pages(virt_to_page(objp),
-						 cachep->objsize / PAGE_SIZE,
+						 cachep->buffer_size / PAGE_SIZE,
 						 1);
 			else
 				check_poison_obj(cachep, objp);
@@ -1449,13 +1455,13 @@ static void slab_destroy(kmem_cache_t *c
 					   "was overwritten");
 		}
 		if (cachep->dtor && !(cachep->flags & SLAB_POISON))
-			(cachep->dtor) (objp + obj_dbghead(cachep), cachep, 0);
+			(cachep->dtor) (objp + obj_offset(cachep), cachep, 0);
 	}
 #else
 	if (cachep->dtor) {
 		int i;
 		for (i = 0; i < cachep->num; i++) {
-			void *objp = slabp->s_mem + cachep->objsize * i;
+			void *objp = slabp->s_mem + cachep->buffer_size * i;
 			(cachep->dtor) (objp, cachep, 0);
 		}
 	}
@@ -1475,7 +1481,7 @@ static void slab_destroy(kmem_cache_t *c
 	}
 }
 
-/* For setting up all the kmem_list3s for cache whose objsize is same
+/* For setting up all the kmem_list3s for cache whose buffer_size is same
    as size of kmem_list3. */
 static inline void set_up_list3s(kmem_cache_t *cachep, int index)
 {
@@ -1608,7 +1614,7 @@ kmem_cache_create (const char *name, siz
 		set_fs(old_fs);
 		if (res) {
 			printk("SLAB: cache with size %d has lost its name\n",
-			       pc->objsize);
+			       pc->buffer_size);
 			continue;
 		}
 
@@ -1699,14 +1705,14 @@ kmem_cache_create (const char *name, siz
 	memset(cachep, 0, sizeof(kmem_cache_t));
 
 #if DEBUG
-	cachep->reallen = size;
+	cachep->obj_size = size;
 
 	if (flags & SLAB_RED_ZONE) {
 		/* redzoning only works with word aligned caches */
 		align = BYTES_PER_WORD;
 
 		/* add space for red zone words */
-		cachep->dbghead += BYTES_PER_WORD;
+		cachep->obj_offset += BYTES_PER_WORD;
 		size += 2 * BYTES_PER_WORD;
 	}
 	if (flags & SLAB_STORE_USER) {
@@ -1719,8 +1725,8 @@ kmem_cache_create (const char *name, siz
 	}
 #if FORCED_DEBUG && defined(CONFIG_DEBUG_PAGEALLOC)
 	if (size >= malloc_sizes[INDEX_L3 + 1].cs_size
-	    && cachep->reallen > cache_line_size() && size < PAGE_SIZE) {
-		cachep->dbghead += PAGE_SIZE - size;
+	    && cachep->obj_size > cache_line_size() && size < PAGE_SIZE) {
+		cachep->obj_offset += PAGE_SIZE - size;
 		size = PAGE_SIZE;
 	}
 #endif
@@ -1783,7 +1789,7 @@ kmem_cache_create (const char *name, siz
 	if (flags & SLAB_CACHE_DMA)
 		cachep->gfpflags |= GFP_DMA;
 	spin_lock_init(&cachep->spinlock);
-	cachep->objsize = size;
+	cachep->buffer_size = size;
 
 	if (flags & CFLGS_OFF_SLAB)
 		cachep->slabp_cache = kmem_find_general_cachep(slab_size, 0u);
@@ -2115,7 +2121,7 @@ static void cache_init_objs(kmem_cache_t
 	int i;
 
 	for (i = 0; i < cachep->num; i++) {
-		void *objp = slabp->s_mem + cachep->objsize * i;
+		void *objp = slabp->s_mem + cachep->buffer_size * i;
 #if DEBUG
 		/* need to poison the objs? */
 		if (cachep->flags & SLAB_POISON)
@@ -2133,7 +2139,7 @@ static void cache_init_objs(kmem_cache_t
 		 * Otherwise, deadlock. They must also be threaded.
 		 */
 		if (cachep->ctor && !(cachep->flags & SLAB_POISON))
-			cachep->ctor(objp + obj_dbghead(cachep), cachep,
+			cachep->ctor(objp + obj_offset(cachep), cachep,
 				     ctor_flags);
 
 		if (cachep->flags & SLAB_RED_ZONE) {
@@ -2144,10 +2150,10 @@ static void cache_init_objs(kmem_cache_t
 				slab_error(cachep, "constructor overwrote the"
 					   " start of an object");
 		}
-		if ((cachep->objsize % PAGE_SIZE) == 0 && OFF_SLAB(cachep)
+		if ((cachep->buffer_size % PAGE_SIZE) == 0 && OFF_SLAB(cachep)
 		    && cachep->flags & SLAB_POISON)
 			kernel_map_pages(virt_to_page(objp),
-					 cachep->objsize / PAGE_SIZE, 0);
+					 cachep->buffer_size / PAGE_SIZE, 0);
 #else
 		if (cachep->ctor)
 			cachep->ctor(objp, cachep, ctor_flags);
@@ -2306,7 +2312,7 @@ static void *cache_free_debugcheck(kmem_
 	unsigned int objnr;
 	struct slab *slabp;
 
-	objp -= obj_dbghead(cachep);
+	objp -= obj_offset(cachep);
 	kfree_debugcheck(objp);
 	page = virt_to_page(objp);
 
@@ -2338,31 +2344,31 @@ static void *cache_free_debugcheck(kmem_
 	if (cachep->flags & SLAB_STORE_USER)
 		*dbg_userword(cachep, objp) = caller;
 
-	objnr = (objp - slabp->s_mem) / cachep->objsize;
+	objnr = (objp - slabp->s_mem) / cachep->buffer_size;
 
 	BUG_ON(objnr >= cachep->num);
-	BUG_ON(objp != slabp->s_mem + objnr * cachep->objsize);
+	BUG_ON(objp != slabp->s_mem + objnr * cachep->buffer_size);
 
 	if (cachep->flags & SLAB_DEBUG_INITIAL) {
 		/* Need to call the slab's constructor so the
 		 * caller can perform a verify of its state (debugging).
 		 * Called without the cache-lock held.
 		 */
-		cachep->ctor(objp + obj_dbghead(cachep),
+		cachep->ctor(objp + obj_offset(cachep),
 			     cachep, SLAB_CTOR_CONSTRUCTOR | SLAB_CTOR_VERIFY);
 	}
 	if (cachep->flags & SLAB_POISON && cachep->dtor) {
 		/* we want to cache poison the object,
 		 * call the destruction callback
 		 */
-		cachep->dtor(objp + obj_dbghead(cachep), cachep, 0);
+		cachep->dtor(objp + obj_offset(cachep), cachep, 0);
 	}
 	if (cachep->flags & SLAB_POISON) {
 #ifdef CONFIG_DEBUG_PAGEALLOC
-		if ((cachep->objsize % PAGE_SIZE) == 0 && OFF_SLAB(cachep)) {
+		if ((cachep->buffer_size % PAGE_SIZE) == 0 && OFF_SLAB(cachep)) {
 			store_stackinfo(cachep, objp, (unsigned long)caller);
 			kernel_map_pages(virt_to_page(objp),
-					 cachep->objsize / PAGE_SIZE, 0);
+					 cachep->buffer_size / PAGE_SIZE, 0);
 		} else {
 			poison_obj(cachep, objp, POISON_FREE);
 		}
@@ -2465,7 +2471,7 @@ static void *cache_alloc_refill(kmem_cac
 
 			/* get obj pointer */
 			ac->entry[ac->avail++] = slabp->s_mem +
-			    slabp->free * cachep->objsize;
+			    slabp->free * cachep->buffer_size;
 
 			slabp->inuse++;
 			next = slab_bufctl(slabp)[slabp->free];
@@ -2523,9 +2529,9 @@ static void *cache_alloc_debugcheck_afte
 		return objp;
 	if (cachep->flags & SLAB_POISON) {
 #ifdef CONFIG_DEBUG_PAGEALLOC
-		if ((cachep->objsize % PAGE_SIZE) == 0 && OFF_SLAB(cachep))
+		if ((cachep->buffer_size % PAGE_SIZE) == 0 && OFF_SLAB(cachep))
 			kernel_map_pages(virt_to_page(objp),
-					 cachep->objsize / PAGE_SIZE, 1);
+					 cachep->buffer_size / PAGE_SIZE, 1);
 		else
 			check_poison_obj(cachep, objp);
 #else
@@ -2550,7 +2556,7 @@ static void *cache_alloc_debugcheck_afte
 		*dbg_redzone1(cachep, objp) = RED_ACTIVE;
 		*dbg_redzone2(cachep, objp) = RED_ACTIVE;
 	}
-	objp += obj_dbghead(cachep);
+	objp += obj_offset(cachep);
 	if (cachep->ctor && cachep->flags & SLAB_POISON) {
 		unsigned long ctor_flags = SLAB_CTOR_CONSTRUCTOR;
 
@@ -2636,7 +2642,7 @@ static void *__cache_alloc_node(kmem_cac
 	BUG_ON(slabp->inuse == cachep->num);
 
 	/* get obj pointer */
-	obj = slabp->s_mem + slabp->free * cachep->objsize;
+	obj = slabp->s_mem + slabp->free * cachep->buffer_size;
 	slabp->inuse++;
 	next = slab_bufctl(slabp)[slabp->free];
 #if DEBUG
@@ -2687,7 +2693,7 @@ static void free_block(kmem_cache_t *cac
 		slabp = page_get_slab(virt_to_page(objp));
 		l3 = cachep->nodelists[node];
 		list_del(&slabp->list);
-		objnr = (objp - slabp->s_mem) / cachep->objsize;
+		objnr = (objp - slabp->s_mem) / cachep->buffer_size;
 		check_spinlock_acquired_node(cachep, node);
 		check_slabp(cachep, slabp);
 
@@ -2869,7 +2875,7 @@ int fastcall kmem_ptr_validate(kmem_cach
 	unsigned long addr = (unsigned long)ptr;
 	unsigned long min_addr = PAGE_OFFSET;
 	unsigned long align_mask = BYTES_PER_WORD - 1;
-	unsigned long size = cachep->objsize;
+	unsigned long size = cachep->buffer_size;
 	struct page *page;
 
 	if (unlikely(addr < min_addr))
@@ -3071,7 +3077,7 @@ void kfree(const void *objp)
 	local_irq_save(flags);
 	kfree_debugcheck(objp);
 	c = page_get_cache(virt_to_page(objp));
-	mutex_debug_check_no_locks_freed(objp, obj_reallen(c));
+	mutex_debug_check_no_locks_freed(objp, obj_size(c));
 	__cache_free(c, (void *)objp);
 	local_irq_restore(flags);
 }
@@ -3102,7 +3108,7 @@ EXPORT_SYMBOL(free_percpu);
 
 unsigned int kmem_cache_size(kmem_cache_t *cachep)
 {
-	return obj_reallen(cachep);
+	return obj_size(cachep);
 }
 EXPORT_SYMBOL(kmem_cache_size);
 
@@ -3246,13 +3252,13 @@ static void enable_cpucache(kmem_cache_t
 	 * The numbers are guessed, we should auto-tune as described by
 	 * Bonwick.
 	 */
-	if (cachep->objsize > 131072)
+	if (cachep->buffer_size > 131072)
 		limit = 1;
-	else if (cachep->objsize > PAGE_SIZE)
+	else if (cachep->buffer_size > PAGE_SIZE)
 		limit = 8;
-	else if (cachep->objsize > 1024)
+	else if (cachep->buffer_size > 1024)
 		limit = 24;
-	else if (cachep->objsize > 256)
+	else if (cachep->buffer_size > 256)
 		limit = 54;
 	else
 		limit = 120;
@@ -3267,7 +3273,7 @@ static void enable_cpucache(kmem_cache_t
 	 */
 	shared = 0;
 #ifdef CONFIG_SMP
-	if (cachep->objsize <= PAGE_SIZE)
+	if (cachep->buffer_size <= PAGE_SIZE)
 		shared = 8;
 #endif
 
@@ -3516,7 +3522,7 @@ static int s_show(struct seq_file *m, vo
 		printk(KERN_ERR "slab: cache %s error: %s\n", name, error);
 
 	seq_printf(m, "%-17s %6lu %6lu %6u %4u %4d",
-		   name, active_objs, num_objs, cachep->objsize,
+		   name, active_objs, num_objs, cachep->buffer_size,
 		   cachep->num, (1 << cachep->gfporder));
 	seq_printf(m, " : tunables %4u %4u %4u",
 		   cachep->limit, cachep->batchcount, cachep->shared);
@@ -3644,5 +3650,5 @@ unsigned int ksize(const void *objp)
 	if (unlikely(objp == NULL))
 		return 0;
 
-	return obj_reallen(page_get_cache(virt_to_page(objp)));
+	return obj_size(page_get_cache(virt_to_page(objp)));
 }

--

