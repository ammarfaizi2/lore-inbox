Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261565AbTIKVxo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 17:53:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261578AbTIKVxo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 17:53:44 -0400
Received: from [80.146.160.66] ([80.146.160.66]:32916 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S261565AbTIKVvj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 17:51:39 -0400
Message-ID: <3F60EDFE.5090502@colorfullife.com>
Date: Thu, 11 Sep 2003 23:49:50 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030701
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ravikiran G Thirumalai <kiran@in.ibm.com>
CC: akpm@osdl.org, linux-kernel@vger.kernel.org, Robert Love <rml@tech9.net>,
       dipankar@in.ibm.com
Subject: Re: [patch] Make slab allocator work with SLAB_MUST_HWCACHE_ALIGN
References: <20030910081654.GA1129@llm08.in.ibm.com> <1063208464.700.35.camel@localhost> <20030911055428.GA1140@llm08.in.ibm.com> <20030911110853.GB3700@llm08.in.ibm.com> <3F60A08A.7040504@colorfullife.com>
In-Reply-To: <3F60A08A.7040504@colorfullife.com>
Content-Type: multipart/mixed;
 boundary="------------040802090608080501070109"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040802090608080501070109
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Attached is a forward port of my arbitrary-align patch from 2.4.something.
Only partially tested. And a small correction: rmap needs alignment to 
it's own object size, it crashes immediately if this is not provided by 
slab. Probably it's a good idea to use the new API to decouple the 
pte_chain size from the L1_CACHE_SIZE: I'd bet that 32-byte for a pIII 
is too small.

I'm still thinking how to implement kmem_cache_alloc_forcpu() without 
having to change too much in slab - it's not as simple as I assumed 
initially

--
    Manfred

--------------040802090608080501070109
Content-Type: text/plain;
 name="patch-slab-alignobj"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-slab-alignobj"

// $Header$
// Kernel Version:
//  VERSION = 2
//  PATCHLEVEL = 6
//  SUBLEVEL = 0
//  EXTRAVERSION = -test5-mm1
--- 2.6/mm/slab.c	2003-09-11 22:30:47.000000000 +0200
+++ build-2.6/mm/slab.c	2003-09-11 23:42:16.000000000 +0200
@@ -268,6 +268,7 @@
 	unsigned int		colour_off;	/* colour offset */
 	unsigned int		colour_next;	/* cache colouring */
 	kmem_cache_t		*slabp_cache;
+	unsigned int		slab_size;
 	unsigned int		dflags;		/* dynamic flags */
 
 	/* constructor func */
@@ -488,7 +489,7 @@
 	.objsize	= sizeof(kmem_cache_t),
 	.flags		= SLAB_NO_REAP,
 	.spinlock	= SPIN_LOCK_UNLOCKED,
-	.colour_off	= L1_CACHE_BYTES,
+	.colour_off	= SMP_CACHE_BYTES,
 	.name		= "kmem_cache",
 };
 
@@ -523,7 +524,7 @@
 static void enable_cpucache (kmem_cache_t *cachep);
 
 /* Cal the num objs, wastage, and bytes left over for a given slab size. */
-static void cache_estimate (unsigned long gfporder, size_t size,
+static void cache_estimate (unsigned long gfporder, size_t size, size_t align,
 		 int flags, size_t *left_over, unsigned int *num)
 {
 	int i;
@@ -536,7 +537,7 @@
 		extra = sizeof(kmem_bufctl_t);
 	}
 	i = 0;
-	while (i*size + L1_CACHE_ALIGN(base+i*extra) <= wastage)
+	while (i*size + ALIGN(base+i*extra, align) <= wastage)
 		i++;
 	if (i > 0)
 		i--;
@@ -546,7 +547,7 @@
 
 	*num = i;
 	wastage -= i*size;
-	wastage -= L1_CACHE_ALIGN(base+i*extra);
+	wastage -= ALIGN(base+i*extra, align);
 	*left_over = wastage;
 }
 
@@ -690,14 +691,15 @@
 	list_add(&cache_cache.next, &cache_chain);
 	cache_cache.array[smp_processor_id()] = &initarray_cache.cache;
 
-	cache_estimate(0, cache_cache.objsize, 0,
-			&left_over, &cache_cache.num);
+	cache_estimate(0, cache_cache.objsize, SMP_CACHE_BYTES, 0,
+  			&left_over, &cache_cache.num);
 	if (!cache_cache.num)
 		BUG();
 
 	cache_cache.colour = left_over/cache_cache.colour_off;
 	cache_cache.colour_next = 0;
-
+	cache_cache.slab_size = ALIGN(cache_cache.num*sizeof(kmem_bufctl_t) + sizeof(struct slab),
+					SMP_CACHE_BYTES);
 
 	/* 2+3) create the kmalloc caches */
 	sizes = malloc_sizes;
@@ -993,7 +995,7 @@
  * kmem_cache_create - Create a cache.
  * @name: A string which is used in /proc/slabinfo to identify this cache.
  * @size: The size of objects to be created in this cache.
- * @offset: The offset to use within the page.
+ * @align: The required alignment for the objects.
  * @flags: SLAB flags
  * @ctor: A constructor for the objects.
  * @dtor: A destructor for the objects.
@@ -1018,17 +1020,15 @@
  * %SLAB_NO_REAP - Don't automatically reap this cache when we're under
  * memory pressure.
  *
- * %SLAB_HWCACHE_ALIGN - Align the objects in this cache to a hardware
- * cacheline.  This can be beneficial if you're counting cycles as closely
- * as davem.
+ * %SLAB_HWCACHE_ALIGN - This flag has no effect and will be removed soon.
  */
 kmem_cache_t *
-kmem_cache_create (const char *name, size_t size, size_t offset,
+kmem_cache_create (const char *name, size_t size, size_t align,
 	unsigned long flags, void (*ctor)(void*, kmem_cache_t *, unsigned long),
 	void (*dtor)(void*, kmem_cache_t *, unsigned long))
 {
 	const char *func_nm = KERN_ERR "kmem_create: ";
-	size_t left_over, align, slab_size;
+	size_t left_over, slab_size;
 	kmem_cache_t *cachep = NULL;
 
 	/*
@@ -1039,7 +1039,7 @@
 		(size < BYTES_PER_WORD) ||
 		(size > (1<<MAX_OBJ_ORDER)*PAGE_SIZE) ||
 		(dtor && !ctor) ||
-		(offset < 0 || offset > size))
+		(align < 0))
 			BUG();
 
 #if DEBUG
@@ -1051,22 +1051,16 @@
 
 #if FORCED_DEBUG
 	/*
-	 * Enable redzoning and last user accounting, except
-	 * - for caches with forced alignment: redzoning would violate the
-	 *   alignment
-	 * - for caches with large objects, if the increased size would
-	 *   increase the object size above the next power of two: caches
-	 *   with object sizes just above a power of two have a significant
-	 *   amount of internal fragmentation
+	 * Enable redzoning and last user accounting, except for caches with
+	 * large objects, if the increased size would increase the object size
+	 * above the next power of two: caches with object sizes just above a
+	 * power of two have a significant amount of internal fragmentation.
 	 */
-	if ((size < 4096 || fls(size-1) == fls(size-1+3*BYTES_PER_WORD))
-			&& !(flags & SLAB_MUST_HWCACHE_ALIGN)) {
+	if ((size < 4096 || fls(size-1) == fls(size-1+3*BYTES_PER_WORD)))
 		flags |= SLAB_RED_ZONE|SLAB_STORE_USER;
-	}
 	flags |= SLAB_POISON;
 #endif
 #endif
-
 	/*
 	 * Always checks flags, a caller might be expecting debug
 	 * support which isn't available.
@@ -1074,15 +1068,23 @@
 	if (flags & ~CREATE_MASK)
 		BUG();
 
+	if (align) {
+		/* minimum supported alignment: */
+		if (align < BYTES_PER_WORD)
+			align = BYTES_PER_WORD;
+
+		/* combinations of forced alignment and advanced debugging is
+		 * not yet implemented.
+		 */
+		flags &= ~(SLAB_RED_ZONE|SLAB_STORE_USER);
+	}
+
 	/* Get cache's description obj. */
 	cachep = (kmem_cache_t *) kmem_cache_alloc(&cache_cache, SLAB_KERNEL);
 	if (!cachep)
 		goto opps;
 	memset(cachep, 0, sizeof(kmem_cache_t));
 
-#if DEBUG
-	cachep->reallen = size;
-#endif
 	/* Check that size is in terms of words.  This is needed to avoid
 	 * unaligned accesses for some archs when redzoning is used, and makes
 	 * sure any on-slab bufctl's are also correctly aligned.
@@ -1094,20 +1096,25 @@
 	}
 	
 #if DEBUG
+	cachep->reallen = size;
+
 	if (flags & SLAB_RED_ZONE) {
-		/*
-		 * There is no point trying to honour cache alignment
-		 * when redzoning.
-		 */
-		flags &= ~SLAB_HWCACHE_ALIGN;
+		/* redzoning only works with word aligned caches */
+		align = BYTES_PER_WORD;
+
 		/* add space for red zone words */
 		cachep->dbghead += BYTES_PER_WORD;
 		size += 2*BYTES_PER_WORD;
 	}
 	if (flags & SLAB_STORE_USER) {
-		flags &= ~SLAB_HWCACHE_ALIGN;
-		size += BYTES_PER_WORD; /* add space */
+		/* user store requires word alignment and
+		 * one word storage behind the end of the real
+		 * object.
+		 */
+		align = BYTES_PER_WORD;
+		size += BYTES_PER_WORD;
 	}
+
 #if FORCED_DEBUG && defined(CONFIG_DEBUG_PAGEALLOC)
 	if (size > 128 && cachep->reallen > L1_CACHE_BYTES && size < PAGE_SIZE) {
 		cachep->dbghead += PAGE_SIZE - size;
@@ -1115,9 +1122,6 @@
 	}
 #endif
 #endif
-	align = BYTES_PER_WORD;
-	if (flags & SLAB_HWCACHE_ALIGN)
-		align = L1_CACHE_BYTES;
 
 	/* Determine if the slab management is 'on' or 'off' slab. */
 	if (size >= (PAGE_SIZE>>3))
@@ -1127,13 +1131,16 @@
 		 */
 		flags |= CFLGS_OFF_SLAB;
 
-	if (flags & SLAB_HWCACHE_ALIGN) {
-		/* Need to adjust size so that objs are cache aligned. */
-		/* Small obj size, can get at least two per cache line. */
+	if (!align) {
+		/* Default alignment: compile time specified l1 cache size.
+		 * But if an object is really small, then squeeze multiple
+		 * into one cacheline.
+		 */
+		align = L1_CACHE_BYTES;
 		while (size <= align/2)
 			align /= 2;
-		size = (size+align-1)&(~(align-1));
 	}
+	size = ALIGN(size, align);
 
 	/* Cal size (in pages) of slabs, and the num of objs per slab.
 	 * This could be made much more intelligent.  For now, try to avoid
@@ -1143,7 +1150,7 @@
 	do {
 		unsigned int break_flag = 0;
 cal_wastage:
-		cache_estimate(cachep->gfporder, size, flags,
+		cache_estimate(cachep->gfporder, size, align, flags,
 						&left_over, &cachep->num);
 		if (break_flag)
 			break;
@@ -1177,8 +1184,8 @@
 		cachep = NULL;
 		goto opps;
 	}
-	slab_size = L1_CACHE_ALIGN(cachep->num*sizeof(kmem_bufctl_t) +
-			sizeof(struct slab));
+	slab_size = ALIGN(cachep->num*sizeof(kmem_bufctl_t) + sizeof(struct slab),
+			align);
 
 	/*
 	 * If the slab has been placed off-slab, and we have enough space then
@@ -1189,14 +1196,17 @@
 		left_over -= slab_size;
 	}
 
+	if (flags & CFLGS_OFF_SLAB) {
+		/* really off slab. No need for manual alignment */
+		slab_size = cachep->num*sizeof(kmem_bufctl_t)+sizeof(struct slab);
+	}
+ 
+	cachep->colour_off = L1_CACHE_BYTES;
 	/* Offset must be a multiple of the alignment. */
-	offset += (align-1);
-	offset &= ~(align-1);
-	if (!offset)
-		offset = L1_CACHE_BYTES;
-	cachep->colour_off = offset;
-	cachep->colour = left_over/offset;
-
+	if (cachep->colour_off < align)
+		cachep->colour_off = align;
+	cachep->colour = left_over/cachep->colour_off;
+	cachep->slab_size = slab_size;
 	cachep->flags = flags;
 	cachep->gfpflags = 0;
 	if (flags & SLAB_CACHE_DMA)
@@ -1470,8 +1480,7 @@
 			return NULL;
 	} else {
 		slabp = objp+colour_off;
-		colour_off += L1_CACHE_ALIGN(cachep->num *
-				sizeof(kmem_bufctl_t) + sizeof(struct slab));
+		colour_off += cachep->slab_size;
 	}
 	slabp->inuse = 0;
 	slabp->colouroff = colour_off;
--- 2.6/arch/i386/mm/init.c	2003-09-11 22:30:47.000000000 +0200
+++ build-2.6/arch/i386/mm/init.c	2003-09-11 22:38:57.000000000 +0200
@@ -509,8 +509,8 @@
 	if (PTRS_PER_PMD > 1) {
 		pmd_cache = kmem_cache_create("pmd",
 					PTRS_PER_PMD*sizeof(pmd_t),
+					PTRS_PER_PMD*sizeof(pmd_t),
 					0,
-					SLAB_HWCACHE_ALIGN | SLAB_MUST_HWCACHE_ALIGN,
 					pmd_ctor,
 					NULL);
 		if (!pmd_cache)
@@ -519,8 +519,8 @@
 		if (TASK_SIZE > PAGE_OFFSET) {
 			kpmd_cache = kmem_cache_create("kpmd",
 					PTRS_PER_PMD*sizeof(pmd_t),
+					PTRS_PER_PMD*sizeof(pmd_t),
 					0,
-					SLAB_HWCACHE_ALIGN | SLAB_MUST_HWCACHE_ALIGN,
 					kpmd_ctor,
 					NULL);
 			if (!kpmd_cache)
@@ -541,8 +541,8 @@
 
 	pgd_cache = kmem_cache_create("pgd",
 				PTRS_PER_PGD*sizeof(pgd_t),
+				PTRS_PER_PGD*sizeof(pgd_t),
 				0,
-				SLAB_HWCACHE_ALIGN | SLAB_MUST_HWCACHE_ALIGN,
 				ctor,
 				dtor);
 	if (!pgd_cache)
--- 2.6/mm/rmap.c	2003-09-11 19:33:57.000000000 +0200
+++ build-2.6/mm/rmap.c	2003-09-11 23:41:55.000000000 +0200
@@ -521,8 +521,8 @@
 {
 	pte_chain_cache = kmem_cache_create(	"pte_chain",
 						sizeof(struct pte_chain),
+						sizeof(struct pte_chain),
 						0,
-						SLAB_MUST_HWCACHE_ALIGN,
 						pte_chain_ctor,
 						NULL);
 

--------------040802090608080501070109--

