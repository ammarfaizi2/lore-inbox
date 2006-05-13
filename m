Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750764AbWEMTu5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750764AbWEMTu5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 May 2006 15:50:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750799AbWEMTu5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 May 2006 15:50:57 -0400
Received: from dbl.q-ag.de ([213.172.117.3]:59326 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S1750764AbWEMTu4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 May 2006 15:50:56 -0400
Message-ID: <44663889.6030008@colorfullife.com>
Date: Sat, 13 May 2006 21:50:33 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7.13) Gecko/20060501 Fedora/1.7.13-1.1.fc5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Pekka J Enberg <penberg@cs.Helsinki.FI>
Subject: [PATCH] kfree without virt_to_page()
Content-Type: multipart/mixed;
 boundary="------------040705020300060502070108"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040705020300060502070108
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

as discussed, I have implemented a kfree() without virt_to_page(). The 
patch is a proof-of-concept, intended for developers.

- the kmalloc caches remained at power-of-two, i.e. the patch wastes 
lots of memory.
- alloc_threadinfo() assumed that kmalloc(8192) returned 8192 byte 
aligned memory. This was never guaranteed. I have replaced the kmalloc 
call with gfp() on i386. Probably all other archs are broken.
- get_colourspace() is incorrect, a bounds check is missing (the last 
object must never start beyond addr+PAGE_SIZE+sizeof(kmem_pagehdr)).

The patch boots on i386 with debugging enabled, I have not performed any 
other tests.

Btw, it might be possible to combine the kmem_pagehdr implementation and 
virt_to_page(): If the obj pointer is PAGE_SIZE-aligned, then use 
virt_to_page(). Otherwise use kmem_pagehdr.

--
    Manfred

--------------040705020300060502070108
Content-Type: text/plain;
 name="patch-slab-no_virt_to_page"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-slab-no_virt_to_page"

// $Header$
// Kernel Version:
//  VERSION = 2
//  PATCHLEVEL = 6
//  SUBLEVEL = 17
//  EXTRAVERSION =-rc1-mm3
--- 2.6/mm/slab.c	2006-04-18 13:18:57.000000000 +0200
+++ build-2.6/mm/slab.c	2006-05-13 21:25:04.000000000 +0200
@@ -223,11 +223,9 @@
  */
 struct slab {
 	struct list_head list;
-	unsigned long colouroff;
 	void *s_mem;		/* including colour offset */
 	unsigned int inuse;	/* num of objs active in slab */
 	kmem_bufctl_t free;
-	unsigned short nodeid;
 };
 
 /*
@@ -305,6 +303,14 @@
 	int free_touched;		/* updated without locking */
 };
 
+struct kmem_pagehdr {
+	struct slab *slabp;
+	kmem_cache_t *cachep;
+#ifdef CONFIG_NUMA
+	int nodeid;
+#endif
+};
+
 /*
  * Need this for bootstrapping a per node allocator.
  */
@@ -398,7 +404,7 @@
 	size_t colour;			/* cache colouring range */
 	unsigned int colour_off;	/* colour offset */
 	struct kmem_cache *slabp_cache;
-	unsigned int slab_size;
+	unsigned int data_offset;
 	unsigned int dflags;		/* dynamic flags */
 
 	/* constructor func */
@@ -571,51 +577,38 @@
 #endif
 
 /*
- * Do not go above this order unless 0 objects fit into the slab.
- */
-#define	BREAK_GFP_ORDER_HI	1
-#define	BREAK_GFP_ORDER_LO	0
-static int slab_break_gfp_order = BREAK_GFP_ORDER_LO;
-
-/*
  * Functions for storing/retrieving the cachep and or slab from the page
  * allocator.  These are used to find the slab an obj belongs to.  With kfree(),
  * these are used to find the cache which an obj belongs to.
  */
-static inline void page_set_cache(struct page *page, struct kmem_cache *cache)
-{
-	page->lru.next = (struct list_head *)cache;
-}
 
-static inline struct kmem_cache *page_get_cache(struct page *page)
+static inline struct kmem_pagehdr *objp_to_pagehdr(const void *objp)
 {
-	if (unlikely(PageCompound(page)))
-		page = (struct page *)page_private(page);
-	return (struct kmem_cache *)page->lru.next;
-}
+	unsigned long addr;
+	addr = (unsigned long)objp;
+	addr -= sizeof(struct kmem_pagehdr);
+	addr &= ~(PAGE_SIZE-1);
 
-static inline void page_set_slab(struct page *page, struct slab *slab)
-{
-	page->lru.prev = (struct list_head *)slab;
+	return (struct kmem_pagehdr *)addr;
 }
 
-static inline struct slab *page_get_slab(struct page *page)
+static inline struct kmem_cache *virt_to_cache(const void *objp)
 {
-	if (unlikely(PageCompound(page)))
-		page = (struct page *)page_private(page);
-	return (struct slab *)page->lru.prev;
+	return objp_to_pagehdr(objp)->cachep;
 }
 
-static inline struct kmem_cache *virt_to_cache(const void *obj)
+static inline struct slab *virt_to_slab(const void *objp)
 {
-	struct page *page = virt_to_page(obj);
-	return page_get_cache(page);
+	return objp_to_pagehdr(objp)->slabp;
 }
 
-static inline struct slab *virt_to_slab(const void *obj)
+static inline int slabp_to_nodeid(struct slab *slabp)
 {
-	struct page *page = virt_to_page(obj);
-	return page_get_slab(page);
+#ifdef CONFIG_NUMA
+	return objp_to_pagehdr(slabp->s_mem)->nodeid;
+#else
+	return 0;
+#endif
 }
 
 static inline void *index_to_obj(struct kmem_cache *cache, struct slab *slab,
@@ -738,72 +731,6 @@
 }
 EXPORT_SYMBOL(kmem_find_general_cachep);
 
-static size_t slab_mgmt_size(size_t nr_objs, size_t align)
-{
-	return ALIGN(sizeof(struct slab)+nr_objs*sizeof(kmem_bufctl_t), align);
-}
-
-/*
- * Calculate the number of objects and left-over bytes for a given buffer size.
- */
-static void cache_estimate(unsigned long gfporder, size_t buffer_size,
-			   size_t align, int flags, size_t *left_over,
-			   unsigned int *num)
-{
-	int nr_objs;
-	size_t mgmt_size;
-	size_t slab_size = PAGE_SIZE << gfporder;
-
-	/*
-	 * The slab management structure can be either off the slab or
-	 * on it. For the latter case, the memory allocated for a
-	 * slab is used for:
-	 *
-	 * - The struct slab
-	 * - One kmem_bufctl_t for each object
-	 * - Padding to respect alignment of @align
-	 * - @buffer_size bytes for each object
-	 *
-	 * If the slab management structure is off the slab, then the
-	 * alignment will already be calculated into the size. Because
-	 * the slabs are all pages aligned, the objects will be at the
-	 * correct alignment when allocated.
-	 */
-	if (flags & CFLGS_OFF_SLAB) {
-		mgmt_size = 0;
-		nr_objs = slab_size / buffer_size;
-
-		if (nr_objs > SLAB_LIMIT)
-			nr_objs = SLAB_LIMIT;
-	} else {
-		/*
-		 * Ignore padding for the initial guess. The padding
-		 * is at most @align-1 bytes, and @buffer_size is at
-		 * least @align. In the worst case, this result will
-		 * be one greater than the number of objects that fit
-		 * into the memory allocation when taking the padding
-		 * into account.
-		 */
-		nr_objs = (slab_size - sizeof(struct slab)) /
-			  (buffer_size + sizeof(kmem_bufctl_t));
-
-		/*
-		 * This calculated number will be either the right
-		 * amount, or one greater than what we want.
-		 */
-		if (slab_mgmt_size(nr_objs, align) + nr_objs*buffer_size
-		       > slab_size)
-			nr_objs--;
-
-		if (nr_objs > SLAB_LIMIT)
-			nr_objs = SLAB_LIMIT;
-
-		mgmt_size = slab_mgmt_size(nr_objs, align);
-	}
-	*num = nr_objs;
-	*left_over = slab_size - nr_objs*buffer_size - mgmt_size;
-}
-
 #define slab_error(cachep, msg) __slab_error(__FUNCTION__, cachep, msg)
 
 static void __slab_error(const char *function, struct kmem_cache *cachep,
@@ -1018,7 +945,7 @@
 static inline int cache_free_alien(struct kmem_cache *cachep, void *objp)
 {
 	struct slab *slabp = virt_to_slab(objp);
-	int nodeid = slabp->nodeid;
+	int nodeid = slabp_to_nodeid(slabp);
 	struct kmem_list3 *l3;
 	struct array_cache *alien = NULL;
 
@@ -1026,7 +953,7 @@
 	 * Make sure we are not freeing a object from another node to the array
 	 * cache on this cpu.
 	 */
-	if (likely(slabp->nodeid == numa_node_id()))
+	if (likely(nodeid == numa_node_id()))
 		return 0;
 
 	l3 = cachep->nodelists[numa_node_id()];
@@ -1272,17 +1199,105 @@
 	local_irq_enable();
 }
 
+static int get_dataoff(kmem_cache_t *cachep, size_t align)
+{
+	int off;
+
+	off = sizeof(struct kmem_pagehdr);
+	if (!(cachep->flags & CFLGS_OFF_SLAB)) {
+		off = ALIGN(off, sizeof(void*));
+		off += (cachep->num*sizeof(kmem_bufctl_t) +
+			       	sizeof(struct slab));
+	}
+	off=ALIGN(off, align);
+
+	return off;
+}
+
+static int get_colourspace(struct kmem_cache *cachep)
+{
+	int used, avail, ret;
+
+	avail = PAGE_SIZE * (1<<cachep->gfporder);
+	used = cachep->data_offset + cachep->buffer_size*cachep->num;
+
+	ret = (avail-used)/(cachep->colour_off);
+
+	return ret;
+}
+
+
+/**
+ * get_pagecnt - calculate the number of pages required for a slab setup
+ * @size: size of objects to be created in this cache.
+ * @align: required alignment for the objects.
+ * @on_slab: slab struct on slab?
+ * @count: Number of objects
+ */
+static int get_pagecnt(size_t size, size_t align, int on_slab, int count)
+{
+	int hdr;
+	int pages;
+
+	hdr = sizeof(struct kmem_pagehdr);
+
+	if (on_slab) {
+		hdr = ALIGN(hdr, sizeof(void*));
+
+		hdr += sizeof(struct slab)+count*sizeof(kmem_bufctl_t);
+	}
+	hdr = ALIGN(hdr,align);
+
+	pages = (count*size+hdr+PAGE_SIZE-1)/PAGE_SIZE;
+
+	return pages;
+}
+
+/**
+ * calculate_sizes - calculate size (page order) of slabs
+ * @numobj: Number of objects in one slab (out)
+ * @gfporder: gfp order of the slab (out)
+ * @size: size of objects to be created in this cache.
+ * @align: required alignment for the objects.
+ * @on_slab: slab struct on slab?
+ *
+ */
+static void calculate_sizes(int *numobj, int *gfporder,
+			size_t size, size_t align, int on_slab)
+{
+	int pages, num;
+
+	pages = get_pagecnt(size, align, on_slab, 1);
+
+	if (pages == 1) {
+		num = 1;
+		*gfporder = 0;
+
+		while (get_pagecnt(size, align, on_slab, num+1) == 1) {
+			num++;
+		}
+		*numobj = num;
+	} else {
+		int i;
+		*numobj = 1;
+		*gfporder = 0;
+		i = 1;
+		while (pages > i) {
+			i <<= 1;
+			(*gfporder)++;
+		}
+	}
+}
+
 /*
  * Initialisation.  Called after the page allocator have been initialised and
  * before smp_init().
  */
 void __init kmem_cache_init(void)
 {
-	size_t left_over;
 	struct cache_sizes *sizes;
 	struct cache_names *names;
 	int i;
-	int order;
 
 	for (i = 0; i < NUM_INIT_LISTS; i++) {
 		kmem_list3_init(&initkmem_list3[i]);
@@ -1290,13 +1305,6 @@
 			cache_cache.nodelists[i] = NULL;
 	}
 
-	/*
-	 * Fragmentation resistance on low memory - only use bigger
-	 * page orders on machines with more than 32MB of memory.
-	 */
-	if (num_physpages > (32 << 20) >> PAGE_SHIFT)
-		slab_break_gfp_order = BREAK_GFP_ORDER_HI;
-
 	/* Bootstrap is tricky, because several objects are allocated
 	 * from caches that do not exist yet:
 	 * 1) initialize the cache_cache cache: it contains the struct
@@ -1327,17 +1335,11 @@
 	cache_cache.buffer_size = ALIGN(cache_cache.buffer_size,
 					cache_line_size());
 
-	for (order = 0; order < MAX_ORDER; order++) {
-		cache_estimate(order, cache_cache.buffer_size,
-			cache_line_size(), 0, &left_over, &cache_cache.num);
-		if (cache_cache.num)
-			break;
-	}
+	calculate_sizes(&cache_cache.num, &cache_cache.gfporder,
+			cache_cache.buffer_size, cache_line_size(), 1);
 	BUG_ON(!cache_cache.num);
-	cache_cache.gfporder = order;
-	cache_cache.colour = left_over / cache_cache.colour_off;
-	cache_cache.slab_size = ALIGN(cache_cache.num * sizeof(kmem_bufctl_t) +
-				      sizeof(struct slab), cache_line_size());
+	cache_cache.data_offset = get_dataoff(&cache_cache, cache_line_size());
+	cache_cache.colour = get_colourspace(&cache_cache);
 
 	/* 2+3) create the kmalloc caches */
 	sizes = malloc_sizes;
@@ -1753,7 +1755,7 @@
  */
 static void slab_destroy(struct kmem_cache *cachep, struct slab *slabp)
 {
-	void *addr = slabp->s_mem - slabp->colouroff;
+	void *addr = objp_to_pagehdr(slabp->s_mem);	
 
 	slab_destroy_objs(cachep, slabp);
 	if (unlikely(cachep->flags & SLAB_DESTROY_BY_RCU)) {
@@ -1786,66 +1788,6 @@
 	}
 }
 
-/**
- * calculate_slab_order - calculate size (page order) of slabs
- * @cachep: pointer to the cache that is being created
- * @size: size of objects to be created in this cache.
- * @align: required alignment for the objects.
- * @flags: slab allocation flags
- *
- * Also calculates the number of objects per slab.
- *
- * This could be made much more intelligent.  For now, try to avoid using
- * high order pages for slabs.  When the gfp() functions are more friendly
- * towards high-order requests, this should be changed.
- */
-static size_t calculate_slab_order(struct kmem_cache *cachep,
-			size_t size, size_t align, unsigned long flags)
-{
-	size_t left_over = 0;
-	int gfporder;
-
-	for (gfporder = 0; gfporder <= MAX_GFP_ORDER; gfporder++) {
-		unsigned int num;
-		size_t remainder;
-
-		cache_estimate(gfporder, size, align, flags, &remainder, &num);
-		if (!num)
-			continue;
-
-		/* More than offslab_limit objects will cause problems */
-		if ((flags & CFLGS_OFF_SLAB) && num > offslab_limit)
-			break;
-
-		/* Found something acceptable - save it away */
-		cachep->num = num;
-		cachep->gfporder = gfporder;
-		left_over = remainder;
-
-		/*
-		 * A VFS-reclaimable slab tends to have most allocations
-		 * as GFP_NOFS and we really don't want to have to be allocating
-		 * higher-order pages when we are unable to shrink dcache.
-		 */
-		if (flags & SLAB_RECLAIM_ACCOUNT)
-			break;
-
-		/*
-		 * Large number of objects is good, but very large slabs are
-		 * currently bad for the gfp()s.
-		 */
-		if (gfporder >= slab_break_gfp_order)
-			break;
-
-		/*
-		 * Acceptable internal fragmentation?
-		 */
-		if (left_over * 8 <= (PAGE_SIZE << gfporder))
-			break;
-	}
-	return left_over;
-}
-
 static void setup_cpu_cache(struct kmem_cache *cachep)
 {
 	if (g_cpucache_up == FULL) {
@@ -1935,7 +1877,7 @@
 	void (*ctor)(void*, struct kmem_cache *, unsigned long),
 	void (*dtor)(void*, struct kmem_cache *, unsigned long))
 {
-	size_t left_over, slab_size, ralign;
+	size_t ralign;
 	struct kmem_cache *cachep = NULL, *pc;
 
 	/*
@@ -1948,6 +1890,10 @@
 		BUG();
 	}
 
+	if (align > PAGE_SIZE) {
+		printk(KERN_ERR "%s: alignment too large (%d)\n", name, align);
+		goto out;
+	}
 	/*
 	 * Prevent CPUs from coming and going.
 	 * lock_cpu_hotplug() nests outside cache_chain_mutex
@@ -2090,17 +2036,24 @@
 #endif
 #endif
 
-	/* Determine if the slab management is 'on' or 'off' slab. */
-	if (size >= (PAGE_SIZE >> 3))
-		/*
-		 * Size is large, assume best to place the slab management obj
-		 * off-slab (should allow better packing of objs).
-		 */
-		flags |= CFLGS_OFF_SLAB;
-
 	size = ALIGN(size, align);
 
-	left_over = calculate_slab_order(cachep, size, align, flags);
+	{
+		int num_on, gfp_on, num_off, gfp_off;
+
+		calculate_sizes(&num_on, &gfp_on, size, align, 1);
+		calculate_sizes(&num_off, &gfp_off, size, align, 0);
+
+		if(gfp_on > gfp_off || 
+				(num_on > num_off && size > PAGE_SIZE/8)) {
+			flags |= CFLGS_OFF_SLAB;
+			cachep->num = num_off;
+			cachep->gfporder = gfp_off;
+		} else {
+			cachep->num = num_on;
+			cachep->gfporder = gfp_on;
+		}
+	}
 
 	if (!cachep->num) {
 		printk("kmem_cache_create: couldn't create cache %s.\n", name);
@@ -2108,53 +2061,43 @@
 		cachep = NULL;
 		goto oops;
 	}
-	slab_size = ALIGN(cachep->num * sizeof(kmem_bufctl_t)
-			  + sizeof(struct slab), align);
-
-	/*
-	 * If the slab has been placed off-slab, and we have enough space then
-	 * move it on-slab. This is at the expense of any extra colouring.
-	 */
-	if (flags & CFLGS_OFF_SLAB && left_over >= slab_size) {
-		flags &= ~CFLGS_OFF_SLAB;
-		left_over -= slab_size;
-	}
 
 	if (flags & CFLGS_OFF_SLAB) {
-		/* really off slab. No need for manual alignment */
-		slab_size =
-		    cachep->num * sizeof(kmem_bufctl_t) + sizeof(struct slab);
+		size_t slab_size;
+
+		slab_size = sizeof(struct slab);
+		slab_size += cachep->num * sizeof(kmem_bufctl_t);
+		cachep->slabp_cache = kmem_find_general_cachep(slab_size, 0u);
 	}
 
 	cachep->colour_off = cache_line_size();
 	/* Offset must be a multiple of the alignment. */
 	if (cachep->colour_off < align)
 		cachep->colour_off = align;
-	cachep->colour = left_over / cachep->colour_off;
-	cachep->slab_size = slab_size;
 	cachep->flags = flags;
 	cachep->gfpflags = 0;
 	if (flags & SLAB_CACHE_DMA)
 		cachep->gfpflags |= GFP_DMA;
 	cachep->buffer_size = size;
 
-	if (flags & CFLGS_OFF_SLAB)
-		cachep->slabp_cache = kmem_find_general_cachep(slab_size, 0u);
+	cachep->data_offset = get_dataoff(cachep, align);
+	cachep->colour = get_colourspace(cachep);
+
 	cachep->ctor = ctor;
 	cachep->dtor = dtor;
 	cachep->name = name;
 
-
 	setup_cpu_cache(cachep);
 
 	/* cache setup completed, link it into the list */
 	list_add(&cachep->next, &cache_chain);
 oops:
+	mutex_unlock(&cache_chain_mutex);
+	unlock_cpu_hotplug();
+out:
 	if (!cachep && (flags & SLAB_PANIC))
 		panic("kmem_cache_create(): failed to create slab `%s'\n",
 		      name);
-	mutex_unlock(&cache_chain_mutex);
-	unlock_cpu_hotplug();
 	return cachep;
 }
 EXPORT_SYMBOL(kmem_cache_create);
@@ -2356,7 +2299,7 @@
 EXPORT_SYMBOL(kmem_cache_destroy);
 
 /* Get the memory for a slab management obj. */
-static struct slab *alloc_slabmgmt(struct kmem_cache *cachep, void *objp,
+static struct slab *alloc_slabmgmt(struct kmem_cache *cachep, void *addr,
 				   int colour_off, gfp_t local_flags,
 				   int nodeid)
 {
@@ -2369,13 +2312,12 @@
 		if (!slabp)
 			return NULL;
 	} else {
-		slabp = objp + colour_off;
-		colour_off += cachep->slab_size;
+		slabp = addr
+			+ ALIGN(sizeof(struct kmem_pagehdr), sizeof(void*))
+			+ colour_off;
 	}
 	slabp->inuse = 0;
-	slabp->colouroff = colour_off;
-	slabp->s_mem = objp + colour_off;
-	slabp->nodeid = nodeid;
+	slabp->s_mem = addr + cachep->data_offset + colour_off;
 	return slabp;
 }
 
@@ -2451,7 +2393,7 @@
 	next = slab_bufctl(slabp)[slabp->free];
 #if DEBUG
 	slab_bufctl(slabp)[slabp->free] = BUFCTL_FREE;
-	WARN_ON(slabp->nodeid != nodeid);
+	WARN_ON(slabp_to_nodeid(slabp) != nodeid);
 #endif
 	slabp->free = next;
 
@@ -2483,23 +2425,18 @@
  * for the slab allocator to be able to lookup the cache and slab of a
  * virtual address for kfree, ksize, kmem_ptr_validate, and slab debugging.
  */
-static void slab_map_pages(struct kmem_cache *cache, struct slab *slab,
-			   void *addr)
+static void slab_map_pages(void *addr, struct kmem_cache *cachep,
+				struct slab *slabp, int nodeid)
 {
-	int nr_pages;
-	struct page *page;
+	struct kmem_pagehdr *phdr;
 
-	page = virt_to_page(addr);
+	phdr = (struct kmem_pagehdr*)addr;
 
-	nr_pages = 1;
-	if (likely(!PageCompound(page)))
-		nr_pages <<= cache->gfporder;
-
-	do {
-		page_set_cache(page, cache);
-		page_set_slab(page, slab);
-		page++;
-	} while (--nr_pages);
+	phdr->cachep = cachep;
+	phdr->slabp = slabp;
+#ifdef CONFIG_NUMA
+	phdr->nodeid = nodeid;
+#endif
 }
 
 /*
@@ -2509,7 +2446,7 @@
 static int cache_grow(struct kmem_cache *cachep, gfp_t flags, int nodeid)
 {
 	struct slab *slabp;
-	void *objp;
+	void *addr;
 	size_t offset;
 	gfp_t local_flags;
 	unsigned long ctor_flags;
@@ -2561,17 +2498,16 @@
 	 * Get mem for the objs.  Attempt to allocate a physical page from
 	 * 'nodeid'.
 	 */
-	objp = kmem_getpages(cachep, flags, nodeid);
-	if (!objp)
+	addr = kmem_getpages(cachep, flags, nodeid);
+	if (!addr)
 		goto failed;
 
 	/* Get slab management. */
-	slabp = alloc_slabmgmt(cachep, objp, offset, local_flags, nodeid);
+	slabp = alloc_slabmgmt(cachep, addr, offset, local_flags, nodeid);
 	if (!slabp)
 		goto opps1;
 
-	slabp->nodeid = nodeid;
-	slab_map_pages(cachep, slabp, objp);
+	slab_map_pages(addr, cachep, slabp, nodeid);
 
 	cache_init_objs(cachep, slabp, ctor_flags);
 
@@ -2587,7 +2523,7 @@
 	spin_unlock(&l3->list_lock);
 	return 1;
 opps1:
-	kmem_freepages(cachep, objp);
+	kmem_freepages(cachep, addr);
 failed:
 	if (local_flags & __GFP_WAIT)
 		local_irq_disable();
@@ -2622,24 +2558,22 @@
 static void *cache_free_debugcheck(struct kmem_cache *cachep, void *objp,
 				   void *caller)
 {
-	struct page *page;
 	unsigned int objnr;
 	struct slab *slabp;
 
 	objp -= obj_offset(cachep);
 	kfree_debugcheck(objp);
-	page = virt_to_page(objp);
 
-	if (page_get_cache(page) != cachep) {
+	if (virt_to_cache(objp) != cachep) {
 		printk(KERN_ERR "mismatch in kmem_cache_free: expected "
 				"cache %p, got %p\n",
-		       page_get_cache(page), cachep);
+		       virt_to_cache(objp), cachep);
 		printk(KERN_ERR "%p is %s.\n", cachep, cachep->name);
-		printk(KERN_ERR "%p is %s.\n", page_get_cache(page),
-		       page_get_cache(page)->name);
+		printk(KERN_ERR "%p is %s.\n", virt_to_cache(objp),
+		       virt_to_cache(objp)->name);
 		WARN_ON(1);
 	}
-	slabp = page_get_slab(page);
+	slabp = virt_to_slab(objp);
 
 	if (cachep->flags & SLAB_RED_ZONE) {
 		if (*dbg_redzone1(cachep, objp) != RED_ACTIVE ||
@@ -2857,7 +2791,7 @@
 		int objnr;
 		struct slab *slabp;
 
-		slabp = page_get_slab(virt_to_page(objp));
+		slabp = virt_to_slab(objp);
 
 		objnr = (objp - slabp->s_mem) / cachep->buffer_size;
 		slab_bufctl(slabp)[objnr] = (unsigned long)caller;
@@ -2867,7 +2801,7 @@
 		struct slab *slabp;
 		unsigned objnr;
 
-		slabp = page_get_slab(virt_to_page(objp));
+		slabp = virt_to_slab(objp);
 		objnr = (unsigned)(objp - slabp->s_mem) / cachep->buffer_size;
 		slab_bufctl(slabp)[objnr] = BUFCTL_ACTIVE;
 	}
@@ -3199,7 +3133,7 @@
 	page = virt_to_page(ptr);
 	if (unlikely(!PageSlab(page)))
 		goto out;
-	if (unlikely(page_get_cache(page) != cachep))
+	if (unlikely(virt_to_cache(ptr) != cachep))
 		goto out;
 	return 1;
 out:
--- 2.6/include/asm-i386/thread_info.h	2006-03-20 06:53:29.000000000 +0100
+++ build-2.6/include/asm-i386/thread_info.h	2006-05-13 20:51:19.000000000 +0200
@@ -55,8 +55,10 @@
 #define PREEMPT_ACTIVE		0x10000000
 #ifdef CONFIG_4KSTACKS
 #define THREAD_SIZE            (4096)
+#define THREAD_GFPORDER		0
 #else
 #define THREAD_SIZE		(8192)
+#define THREAD_GFPORDER		1
 #endif
 
 #define STACK_WARN             (THREAD_SIZE/8)
@@ -101,16 +103,17 @@
 	({							\
 		struct thread_info *ret;			\
 								\
-		ret = kmalloc(THREAD_SIZE, GFP_KERNEL);		\
+	 	ret = __get_free_pages(GFP_KERNEL, THREAD_GFPORDER) \
 		if (ret)					\
 			memset(ret, 0, THREAD_SIZE);		\
 		ret;						\
 	})
 #else
-#define alloc_thread_info(tsk) kmalloc(THREAD_SIZE, GFP_KERNEL)
+#define alloc_thread_info(tsk) \
+	 	__get_free_pages(GFP_KERNEL, THREAD_GFPORDER)
 #endif
 
-#define free_thread_info(info)	kfree(info)
+#define free_thread_info(info)	free_pages(info, THREAD_GFPORDER)
 
 #else /* !__ASSEMBLY__ */
 

--------------040705020300060502070108--
