Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129737AbRCAR0g>; Thu, 1 Mar 2001 12:26:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129741AbRCAR01>; Thu, 1 Mar 2001 12:26:27 -0500
Received: from colorfullife.com ([216.156.138.34]:42756 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S129737AbRCAR0P>;
	Thu, 1 Mar 2001 12:26:15 -0500
Message-ID: <3A9E8628.7CCD1162@colorfullife.com>
Date: Thu, 01 Mar 2001 18:26:00 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.17-14 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Q: explicit alignment control for the slab allocator
Content-Type: multipart/mixed;
 boundary="------------7347AA9FCDF58C9F075E65C1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------7347AA9FCDF58C9F075E65C1
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Alan added a CONFIG options for FORCED_DEBUG slab debugging, but there
is one minor problem with FORCED_DEBUG: FORCED_DEBUG disables
HW_CACHEALIGN, and several drivers assume that HW_CACHEALIGN implies a
certain alignment (iirc usb/uhci.c assumes 16-byte alignment)

I've attached a patch that fixes the explicit alignment control in
kmem_cache_create().

The parameter 'offset' [the minimum offset to be used for cache
coloring] actually is the guaranteed alignment, except that the
implementation was broken. I've fixed the implementation and renamed
'offset' to 'align'.

Patch against 2.4.2-ac6
--
	Manfred
--------------7347AA9FCDF58C9F075E65C1
Content-Type: text/plain; charset=us-ascii;
 name="patch-slab-align"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-slab-align"

--- 2.4/mm/slab.c	Wed Feb 28 14:05:52 2001
+++ build-2.4/mm/slab.c	Thu Mar  1 17:45:11 2001
@@ -207,6 +207,7 @@
 	size_t			colour;		/* cache colouring range */
 	unsigned int		colour_off;	/* colour offset */
 	unsigned int		colour_next;	/* cache colouring */
+	size_t			slab_size;
 	kmem_cache_t		*slabp_cache;
 	unsigned int		growing;
 	unsigned int		dflags;		/* dynamic flags */
@@ -356,7 +357,7 @@
 	objsize:	sizeof(kmem_cache_t),
 	flags:		SLAB_NO_REAP,
 	spinlock:	SPIN_LOCK_UNLOCKED,
-	colour_off:	L1_CACHE_BYTES,
+	colour_off:	SMP_CACHE_BYTES,
 	name:		"kmem_cache",
 };
 
@@ -379,8 +380,13 @@
 static void enable_all_cpucaches (void);
 #endif
 
+static size_t aligned_size(size_t x, size_t alignment)
+{
+	return (x+alignment-1)&(~(alignment-1));
+}
+
 /* Cal the num objs, wastage, and bytes left over for a given slab size. */
-static void kmem_cache_estimate (unsigned long gfporder, size_t size,
+static void kmem_cache_estimate (unsigned long gfporder, size_t size, size_t align,
 		 int flags, size_t *left_over, unsigned int *num)
 {
 	int i;
@@ -393,7 +399,7 @@
 		extra = sizeof(kmem_bufctl_t);
 	}
 	i = 0;
-	while (i*size + L1_CACHE_ALIGN(base+i*extra) <= wastage)
+	while (i*size + aligned_size(base+i*extra, align) <= wastage)
 		i++;
 	if (i > 0)
 		i--;
@@ -403,7 +409,7 @@
 
 	*num = i;
 	wastage -= i*size;
-	wastage -= L1_CACHE_ALIGN(base+i*extra);
+	wastage -= aligned_size(base+i*extra, align);
 	*left_over = wastage;
 }
 
@@ -415,13 +421,15 @@
 	init_MUTEX(&cache_chain_sem);
 	INIT_LIST_HEAD(&cache_chain);
 
-	kmem_cache_estimate(0, cache_cache.objsize, 0,
+	kmem_cache_estimate(0, cache_cache.objsize, SMP_CACHE_BYTES, 0,
 			&left_over, &cache_cache.num);
 	if (!cache_cache.num)
 		BUG();
 
 	cache_cache.colour = left_over/cache_cache.colour_off;
 	cache_cache.colour_next = 0;
+	cache_cache.slab_size = aligned_size(sizeof(slab_t)
+			+ cache_cache.num*sizeof(kmem_bufctl_t), SMP_CACHE_BYTES);
 }
 
 
@@ -589,7 +597,7 @@
  * kmem_cache_create - Create a cache.
  * @name: A string which is used in /proc/slabinfo to identify this cache.
  * @size: The size of objects to be created in this cache.
- * @offset: The offset to use within the page.
+ * @align: The required alignment for the objects.
  * @flags: SLAB flags
  * @ctor: A constructor for the objects.
  * @dtor: A destructor for the objects.
@@ -614,12 +622,12 @@
  * as davem.
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
@@ -631,7 +639,7 @@
 		(size < BYTES_PER_WORD) ||
 		(size > (1<<MAX_OBJ_ORDER)*PAGE_SIZE) ||
 		(dtor && !ctor) ||
-		(offset < 0 || offset > size))
+		(align < 0))
 			BUG();
 
 #if DEBUG
@@ -647,7 +655,7 @@
 		flags &= ~SLAB_POISON;
 	}
 #if FORCED_DEBUG
-	if (size < (PAGE_SIZE>>3))
+	if (size < (PAGE_SIZE>>3) && (align <= BYTES_PER_WORD))
 		/*
 		 * do not red zone large object, causes severe
 		 * fragmentation.
@@ -680,38 +688,42 @@
 		size &= ~(BYTES_PER_WORD-1);
 		printk("%sForcing size word alignment - %s\n", func_nm, name);
 	}
-	
-#if DEBUG
-	if (flags & SLAB_RED_ZONE) {
-		/*
-		 * There is no point trying to honour cache alignment
-		 * when redzoning.
+
+	if (align < BYTES_PER_WORD)
+		align = BYTES_PER_WORD;
+
+	/*
+	 * There is no point trying to honour cache alignment
+	 * when redzoning.
+	 */
+	 if ((flags & SLAB_HWCACHE_ALIGN) && !(flags & SLAB_RED_ZONE)) {
+	 	int autoalign = SMP_CACHE_BYTES;
+		/* HWCACHE_ALIGN is only a hint, squeeze multiple objects
+		 * into one cache line if they fit.
+		 * Otherwise we would 128 byte align the 32 byte kmalloc
+		 * block on a P IV...
 		 */
-		flags &= ~SLAB_HWCACHE_ALIGN;
-		size += 2*BYTES_PER_WORD;	/* words for redzone */
+		while (size < autoalign/2)
+			autoalign /= 2;
+		if (autoalign > align)
+			align = autoalign;
 	}
+
+#if DEBUG
+	if (flags & SLAB_RED_ZONE)
+		size += 2*BYTES_PER_WORD;	/* words for redzone */
 #endif
-	align = BYTES_PER_WORD;
-	if (flags & SLAB_HWCACHE_ALIGN)
-		align = L1_CACHE_BYTES;
+
+	/* Need to adjust size so that objs are cache aligned. */
+	size = aligned_size(size, align);
 
 	/* Determine if the slab management is 'on' or 'off' slab. */
-	if (size >= (PAGE_SIZE>>3))
+	if (size >= (PAGE_SIZE>>3) || align >= (PAGE_SIZE>>3))
 		/*
 		 * Size is large, assume best to place the slab management obj
 		 * off-slab (should allow better packing of objs).
 		 */
 		flags |= CFLGS_OFF_SLAB;
-
-	if (flags & SLAB_HWCACHE_ALIGN) {
-		/* Need to adjust size so that objs are cache aligned. */
-		/* Small obj size, can get at least two per cache line. */
-		/* FIXME: only power of 2 supported, was better */
-		while (size < align/2)
-			align /= 2;
-		size = (size+align-1)&(~(align-1));
-	}
-
 	/* Cal size (in pages) of slabs, and the num of objs per slab.
 	 * This could be made much more intelligent.  For now, try to avoid
 	 * using high page-orders for slabs.  When the gfp() funcs are more
@@ -720,7 +732,7 @@
 	do {
 		unsigned int break_flag = 0;
 cal_wastage:
-		kmem_cache_estimate(cachep->gfporder, size, flags,
+		kmem_cache_estimate(cachep->gfporder, size, align, flags,
 						&left_over, &cachep->num);
 		if (break_flag)
 			break;
@@ -754,24 +766,24 @@
 		cachep = NULL;
 		goto opps;
 	}
-	slab_size = L1_CACHE_ALIGN(cachep->num*sizeof(kmem_bufctl_t)+sizeof(slab_t));
-
 	/*
 	 * If the slab has been placed off-slab, and we have enough space then
 	 * move it on-slab. This is at the expense of any extra colouring.
 	 */
-	if (flags & CFLGS_OFF_SLAB && left_over >= slab_size) {
+	slab_size = aligned_size(cachep->num*sizeof(kmem_bufctl_t)+sizeof(slab_t), align);
+
+	if ((flags & CFLGS_OFF_SLAB) && left_over >= slab_size) {
 		flags &= ~CFLGS_OFF_SLAB;
 		left_over -= slab_size;
 	}
+	if (flags & CFLGS_OFF_SLAB) {
+		/* really off slab. No need for manual alignment */
+		slab_size = cachep->num*sizeof(kmem_bufctl_t)+sizeof(slab_t);
+	}
 
-	/* Offset must be a multiple of the alignment. */
-	offset += (align-1);
-	offset &= ~(align-1);
-	if (!offset)
-		offset = L1_CACHE_BYTES;
-	cachep->colour_off = offset;
-	cachep->colour = left_over/offset;
+	cachep->slab_size = slab_size;
+	cachep->colour_off = align;
+	cachep->colour = left_over/align;
 
 	/* init remaining fields */
 	if (!cachep->gfporder && !(flags & CFLGS_OFF_SLAB))
@@ -1016,8 +1028,7 @@
 		 * if you enable OPTIMIZE
 		 */
 		slabp = objp+colour_off;
-		colour_off += L1_CACHE_ALIGN(cachep->num *
-				sizeof(kmem_bufctl_t) + sizeof(slab_t));
+		colour_off += cachep->slab_size;
 	}
 	slabp->inuse = 0;
 	slabp->colouroff = colour_off;


--------------7347AA9FCDF58C9F075E65C1--


