Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261720AbTCGT2u>; Fri, 7 Mar 2003 14:28:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261728AbTCGT2u>; Fri, 7 Mar 2003 14:28:50 -0500
Received: from dbl.q-ag.de ([80.146.160.66]:46556 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S261720AbTCGT2o>;
	Fri, 7 Mar 2003 14:28:44 -0500
Message-ID: <3E68F552.1010807@colorfullife.com>
Date: Fri, 07 Mar 2003 20:38:58 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@digeo.com>
CC: Zwane Mwaikambo <zwane@linuxpower.ca>, linux-kernel@vger.kernel.org
Subject: Re: Oops: 2.5.64 check_obj_poison for 'size-64'
References: <Pine.LNX.4.50.0303062358130.17080-100000@montezuma.mastecende.com>	<20030306222328.14b5929c.akpm@digeo.com>	<Pine.LNX.4.50.0303070221470.18716-100000@montezuma.mastecende.com>	<20030306233517.68c922f9.akpm@digeo.com>	<Pine.LNX.4.50.0303070351060.18716-100000@montezuma.mastecende.com> <20030307010539.3c0a14a3.akpm@digeo.com>
In-Reply-To: <20030307010539.3c0a14a3.akpm@digeo.com>
Content-Type: multipart/mixed;
 boundary="------------060405000203080404060107"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060405000203080404060107
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Andrew Morton wrote:

>This is a bad, bad bug.  How are you triggering it?
>
>Manfred, would it be possible to add builtin_return_address(0) into each
>object, so we can find out who did the initial kmalloc (or kfree, even)?
>
>It'll probably require CONFIG_FRAME_POINTER.
>  
>
No, CONFIG_FRAME_POINTER is only needed for __builtin_return_address(x, 
x>0). _address(0) always works.

I've attached a patch that records the last kfree address and prints 
that if a poison check fails.

Zwane, could you try to reproduce the bug?

If this doesn't help, we must implement the brute force approach: Use 
one page for each object and unmap it with change_page_addr from the 
linear mapping. Solaris can do that to hunt such bugs.

patch against 2.5.64+use_after_free_check.patch.

--
    Manfred

--------------060405000203080404060107
Content-Type: text/plain;
 name="patch-slab-caller"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-slab-caller"

// $Header$
// Kernel Version:
//  VERSION = 2
//  PATCHLEVEL = 5
//  SUBLEVEL = 64
//  EXTRAVERSION =
--- 2.5/include/linux/slab.h	2003-02-10 20:27:29.000000000 +0100
+++ build-2.5/include/linux/slab.h	2003-03-07 20:08:54.000000000 +0100
@@ -37,6 +37,7 @@
 #define	SLAB_HWCACHE_ALIGN	0x00002000UL	/* align objs on a h/w cache lines */
 #define SLAB_CACHE_DMA		0x00004000UL	/* use GFP_DMA memory */
 #define SLAB_MUST_HWCACHE_ALIGN	0x00008000UL	/* force alignment */
+#define SLAB_STORE_USER		0x00010000UL	/* store the last owner for bug hunting */
 
 /* flags passed to a constructor func */
 #define	SLAB_CTOR_CONSTRUCTOR	0x001UL		/* if not set, then deconstructor */
--- 2.5/mm/slab.c	2003-03-07 20:30:51.000000000 +0100
+++ build-2.5/mm/slab.c	2003-03-07 20:33:17.000000000 +0100
@@ -114,7 +114,7 @@
 # define CREATE_MASK	(SLAB_DEBUG_INITIAL | SLAB_RED_ZONE | \
 			 SLAB_POISON | SLAB_HWCACHE_ALIGN | \
 			 SLAB_NO_REAP | SLAB_CACHE_DMA | \
-			 SLAB_MUST_HWCACHE_ALIGN)
+			 SLAB_MUST_HWCACHE_ALIGN | SLAB_STORE_USER)
 #else
 # define CREATE_MASK	(SLAB_HWCACHE_ALIGN | SLAB_NO_REAP | \
 			 SLAB_CACHE_DMA | SLAB_MUST_HWCACHE_ALIGN)
@@ -280,9 +280,7 @@
 #endif
 };
 
-/* internal c_flags */
-#define	CFLGS_OFF_SLAB	0x010000UL	/* slab management in own cache */
-
+#define CFLGS_OFF_SLAB		(0x80000000UL)
 #define	OFF_SLAB(x)	((x)->flags & CFLGS_OFF_SLAB)
 
 #define BATCHREFILL_LIMIT	16
@@ -764,6 +762,9 @@
 		addr += BYTES_PER_WORD;
 		size -= 2*BYTES_PER_WORD;
 	}
+	if (cachep->flags & SLAB_STORE_USER) {
+		size -= BYTES_PER_WORD;
+	}
 	memset(addr, val, size);
 	*(unsigned char *)(addr+size-1) = POISON_END;
 }
@@ -791,11 +792,21 @@
 		addr += BYTES_PER_WORD;
 		size -= 2*BYTES_PER_WORD;
 	}
+	if (cachep->flags & SLAB_STORE_USER) {
+		size -= BYTES_PER_WORD;
+	}
 	end = fprob(addr, size);
 	if (end) {
 		int s;
 		printk(KERN_ERR "Slab corruption: start=%p, expend=%p, "
 				"problemat=%p\n", addr, addr+size-1, end);
+		if (cachep->flags & SLAB_STORE_USER) {
+			if (cachep->flags & SLAB_RED_ZONE)
+				printk(KERN_ERR "Last user: [<%p>]\n", *(void**)(addr+size+BYTES_PER_WORD));
+			else
+				printk(KERN_ERR "Last user: [<%p>]\n", *(void**)(addr+size));
+
+		}
 		printk(KERN_ERR "Data: ");
 		for (s = 0; s < size; s++) {
 			if (((char*)addr)[s] == POISON_BEFORE)
@@ -831,16 +842,19 @@
 	int i;
 	for (i = 0; i < cachep->num; i++) {
 		void *objp = slabp->s_mem + cachep->objsize * i;
+		int objlen = cachep->objsize;
 
 		if (cachep->flags & SLAB_POISON)
 			check_poison_obj(cachep, objp);
+		if (cachep->flags & SLAB_STORE_USER)
+			objlen -= BYTES_PER_WORD;
 
 		if (cachep->flags & SLAB_RED_ZONE) {
 			if (*((unsigned long*)(objp)) != RED_INACTIVE)
 				slab_error(cachep, "start of a freed object "
 							"was overwritten");
-			if (*((unsigned long*)(objp + cachep->objsize -
-					BYTES_PER_WORD)) != RED_INACTIVE)
+			if (*((unsigned long*)(objp + objlen - BYTES_PER_WORD))
+				       	!= RED_INACTIVE)
 				slab_error(cachep, "end of a freed object "
 							"was overwritten");
 			objp += BYTES_PER_WORD;
@@ -929,7 +943,7 @@
 		 * do not red zone large object, causes severe
 		 * fragmentation.
 		 */
-		flags |= SLAB_RED_ZONE;
+		flags |= SLAB_RED_ZONE|SLAB_STORE_USER;
 	flags |= SLAB_POISON;
 #endif
 #endif
@@ -966,6 +980,10 @@
 		flags &= ~SLAB_HWCACHE_ALIGN;
 		size += 2*BYTES_PER_WORD;	/* words for redzone */
 	}
+	if (flags & SLAB_STORE_USER) {
+		flags &= ~SLAB_HWCACHE_ALIGN;
+		size += BYTES_PER_WORD;		/* word for kfree caller address */
+	}
 #endif
 	align = BYTES_PER_WORD;
 	if (flags & SLAB_HWCACHE_ALIGN)
@@ -1322,15 +1340,20 @@
 	for (i = 0; i < cachep->num; i++) {
 		void* objp = slabp->s_mem+cachep->objsize*i;
 #if DEBUG
+		int objlen = cachep->objsize;
 		/* need to poison the objs? */
 		if (cachep->flags & SLAB_POISON)
 			poison_obj(cachep, objp, POISON_BEFORE);
+		if (cachep->flags & SLAB_STORE_USER) {
+			objlen -= BYTES_PER_WORD;
+			((unsigned long*)(objp+objlen))[0] = 0;
+		}
 
 		if (cachep->flags & SLAB_RED_ZONE) {
 			*((unsigned long*)(objp)) = RED_INACTIVE;
-			*((unsigned long*)(objp + cachep->objsize -
-					BYTES_PER_WORD)) = RED_INACTIVE;
 			objp += BYTES_PER_WORD;
+			objlen -= 2* BYTES_PER_WORD;
+			*((unsigned long*)(objp + objlen)) = RED_INACTIVE;
 		}
 		/*
 		 * Constructors are not allowed to allocate memory from
@@ -1341,14 +1364,13 @@
 			cachep->ctor(objp, cachep, ctor_flags);
 
 		if (cachep->flags & SLAB_RED_ZONE) {
+			if (*((unsigned long*)(objp + objlen)) != RED_INACTIVE)
+				slab_error(cachep, "constructor overwrote the"
+							" end of an object");
 			objp -= BYTES_PER_WORD;
 			if (*((unsigned long*)(objp)) != RED_INACTIVE)
 				slab_error(cachep, "constructor overwrote the"
 							" start of an object");
-			if (*((unsigned long*)(objp + cachep->objsize -
-					BYTES_PER_WORD)) != RED_INACTIVE)
-				slab_error(cachep, "constructor overwrote the"
-							" end of an object");
 		}
 #else
 		if (cachep->ctor)
@@ -1490,11 +1512,12 @@
 #endif 
 }
 
-static inline void *cache_free_debugcheck (kmem_cache_t * cachep, void * objp)
+static inline void *cache_free_debugcheck (kmem_cache_t * cachep, void * objp, void *caller)
 {
 #if DEBUG
 	struct page *page;
 	unsigned int objnr;
+	int objlen = cachep->objsize;
 	struct slab *slabp;
 
 	kfree_debugcheck(objp);
@@ -1503,16 +1526,21 @@
 	BUG_ON(GET_PAGE_CACHE(page) != cachep);
 	slabp = GET_PAGE_SLAB(page);
 
+	if (cachep->flags & SLAB_STORE_USER) {
+		objlen -= BYTES_PER_WORD;
+	}
 	if (cachep->flags & SLAB_RED_ZONE) {
 		objp -= BYTES_PER_WORD;
 		if (xchg((unsigned long *)objp, RED_INACTIVE) != RED_ACTIVE)
 			slab_error(cachep, "double free, or memory before"
 						" object was overwritten");
-		if (xchg((unsigned long *)(objp+cachep->objsize -
-				BYTES_PER_WORD), RED_INACTIVE) != RED_ACTIVE)
+		if (xchg((unsigned long *)(objp+objlen-BYTES_PER_WORD), RED_INACTIVE) != RED_ACTIVE)
 			slab_error(cachep, "double free, or memory after "
 						" object was overwritten");
 	}
+	if (cachep->flags & SLAB_STORE_USER) {
+		*((void**)(objp+objlen)) = caller;
+	}
 
 	objnr = (objp-slabp->s_mem)/cachep->objsize;
 
@@ -1665,22 +1693,31 @@
 
 static inline void *
 cache_alloc_debugcheck_after(kmem_cache_t *cachep,
-			unsigned long flags, void *objp)
+			unsigned long flags, void *objp, void *caller)
 {
 #if DEBUG
+	int objlen = cachep->objsize;
+
 	if (!objp)	
 		return objp;
 	if (cachep->flags & SLAB_POISON)
 		check_poison_obj(cachep, objp);
+	if (cachep->flags & SLAB_STORE_USER) {
+		objlen -= BYTES_PER_WORD;
+		*((void **)(objp+objlen)) = caller;
+	}
+
 	if (cachep->flags & SLAB_RED_ZONE) {
 		/* Set alloc red-zone, and check old one. */
-		if (xchg((unsigned long *)objp, RED_ACTIVE) != RED_INACTIVE)
+		if (xchg((unsigned long *)objp, RED_ACTIVE) != RED_INACTIVE) {
 			slab_error(cachep, "memory before object was "
 						"overwritten");
-		if (xchg((unsigned long *)(objp+cachep->objsize -
-			  BYTES_PER_WORD), RED_ACTIVE) != RED_INACTIVE)
+		}
+		if (xchg((unsigned long *)(objp+objlen - BYTES_PER_WORD),
+				       	RED_ACTIVE) != RED_INACTIVE) {
 			slab_error(cachep, "memory after object was "
 						"overwritten");
+		}
 		objp += BYTES_PER_WORD;
 	}
 	if (cachep->ctor && cachep->flags & SLAB_POISON) {
@@ -1715,7 +1752,7 @@
 		objp = cache_alloc_refill(cachep, flags);
 	}
 	local_irq_restore(save_flags);
-	objp = cache_alloc_debugcheck_after(cachep, flags, objp);
+	objp = cache_alloc_debugcheck_after(cachep, flags, objp, __builtin_return_address(0));
 	return objp;
 }
 
@@ -1822,7 +1859,7 @@
 	struct array_cache *ac = ac_data(cachep);
 
 	check_irq_off();
-	objp = cache_free_debugcheck(cachep, objp);
+	objp = cache_free_debugcheck(cachep, objp, __builtin_return_address(0));
 
 	if (likely(ac->avail < ac->limit)) {
 		STATS_INC_FREEHIT(cachep);

--------------060405000203080404060107--

