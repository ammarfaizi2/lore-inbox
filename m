Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751086AbVKSL6m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751086AbVKSL6m (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Nov 2005 06:58:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751088AbVKSL6m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Nov 2005 06:58:42 -0500
Received: from dbl.q-ag.de ([213.172.117.3]:43396 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S1751086AbVKSL6l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Nov 2005 06:58:41 -0500
Message-ID: <437F1333.5010308@colorfullife.com>
Date: Sat, 19 Nov 2005 12:57:39 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7.12) Gecko/20050923 Fedora/1.7.12-1.5.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pekka Enberg <penberg@cs.helsinki.fi>
CC: akpm@osdl.org, linux-kernel@vger.kernel.org, colpatch@us.ibm.com
Subject: Re: [PATCH 1/5] slab: rename obj_reallen to obj_size
References: <iq5uu1.87bo1s.3tcvszwr6pjjr4ngr04pw358p.beaver@cs.helsinki.fi>
In-Reply-To: <iq5uu1.87bo1s.3tcvszwr6pjjr4ngr04pw358p.beaver@cs.helsinki.fi>
Content-Type: multipart/mixed;
 boundary="------------060902080706060100040008"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060902080706060100040008
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Pekka Enberg wrote:

>This patch renames the obj_reallen() function to obj_size() which makes the
>code more readable.
>
>  
>
I disagree. There are two different object length:
- the amount of memory available for the user. This is stored in 
cachep->reallen.
- the amount of memory allocated internally. Due to redzoning, this can 
be larger than the amount available. Stored in cachep->objsize.

With your change, cachep->objsize is the internal allocation and 
obj_size(cachep) is the user visible part. This reduces the readability.
I agree that the names obj_size and reallen are bad. What about the 
attached patch?

Signed-Off-By: Manfred Spraul <manfred@colorfullife.com>

--------------060902080706060100040008
Content-Type: text/plain;
 name="patch-slab-cleanup-001"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-slab-cleanup-001"

--- 2.6/mm/slab.c	2005-11-19 12:17:26.000000000 +0100
+++ build-2.6/mm/slab.c	2005-11-19 12:55:59.000000000 +0100
@@ -426,8 +426,14 @@
 	atomic_t		freemiss;
 #endif
 #if DEBUG
-	int			dbghead;
-	int			reallen;
+	/*
+	 * If debugging is enabled, then the allocator can add additional
+	 * fields and/or padding to every object. objsize contains the total
+	 * object size including these internal fields, the following two
+	 * variables contain the offset to the user object and its size.
+	 */
+	int			user_off;
+	int			user_size;
 #endif
 };
 
@@ -498,29 +504,29 @@
 
 /* memory layout of objects:
  * 0		: objp
- * 0 .. cachep->dbghead - BYTES_PER_WORD - 1: padding. This ensures that
+ * 0 .. cachep->user_off - BYTES_PER_WORD - 1: padding. This ensures that
  * 		the end of an object is aligned with the end of the real
  * 		allocation. Catches writes behind the end of the allocation.
- * cachep->dbghead - BYTES_PER_WORD .. cachep->dbghead - 1:
+ * cachep->user_off - BYTES_PER_WORD .. cachep->user_off - 1:
  * 		redzone word.
- * cachep->dbghead: The real object.
+ * cachep->user_off: The real object.
  * cachep->objsize - 2* BYTES_PER_WORD: redzone word [BYTES_PER_WORD long]
  * cachep->objsize - 1* BYTES_PER_WORD: last caller address [BYTES_PER_WORD long]
  */
-static int obj_dbghead(kmem_cache_t *cachep)
+static int obj_user_off(kmem_cache_t *cachep)
 {
-	return cachep->dbghead;
+	return cachep->user_off;
 }
 
-static int obj_reallen(kmem_cache_t *cachep)
+static int obj_user_size(kmem_cache_t *cachep)
 {
-	return cachep->reallen;
+	return cachep->user_size;
 }
 
 static unsigned long *dbg_redzone1(kmem_cache_t *cachep, void *objp)
 {
 	BUG_ON(!(cachep->flags & SLAB_RED_ZONE));
-	return (unsigned long*) (objp+obj_dbghead(cachep)-BYTES_PER_WORD);
+	return (unsigned long*) (objp+obj_user_off(cachep)-BYTES_PER_WORD);
 }
 
 static unsigned long *dbg_redzone2(kmem_cache_t *cachep, void *objp)
@@ -539,8 +545,8 @@
 
 #else
 
-#define obj_dbghead(x)			0
-#define obj_reallen(cachep)		(cachep->objsize)
+#define obj_user_off(x)			0
+#define obj_user_size(cachep)		(cachep->objsize)
 #define dbg_redzone1(cachep, objp)	({BUG(); (unsigned long *)NULL;})
 #define dbg_redzone2(cachep, objp)	({BUG(); (unsigned long *)NULL;})
 #define dbg_userword(cachep, objp)	({BUG(); (void **)NULL;})
@@ -630,7 +636,7 @@
 	.spinlock	= SPIN_LOCK_UNLOCKED,
 	.name		= "kmem_cache",
 #if DEBUG
-	.reallen	= sizeof(kmem_cache_t),
+	.user_size	= sizeof(kmem_cache_t),
 #endif
 };
 
@@ -1265,9 +1271,9 @@
 static void store_stackinfo(kmem_cache_t *cachep, unsigned long *addr,
 				unsigned long caller)
 {
-	int size = obj_reallen(cachep);
+	int size = obj_user_size(cachep);
 
-	addr = (unsigned long *)&((char*)addr)[obj_dbghead(cachep)];
+	addr = (unsigned long *)&((char*)addr)[obj_user_off(cachep)];
 
 	if (size < 5*sizeof(unsigned long))
 		return;
@@ -1297,8 +1303,8 @@
 
 static void poison_obj(kmem_cache_t *cachep, void *addr, unsigned char val)
 {
-	int size = obj_reallen(cachep);
-	addr = &((char*)addr)[obj_dbghead(cachep)];
+	int size = obj_user_size(cachep);
+	addr = &((char*)addr)[obj_user_off(cachep)];
 
 	memset(addr, val, size);
 	*(unsigned char *)(addr+size-1) = POISON_END;
@@ -1335,8 +1341,8 @@
 				(unsigned long)*dbg_userword(cachep, objp));
 		printk("\n");
 	}
-	realobj = (char*)objp+obj_dbghead(cachep);
-	size = obj_reallen(cachep);
+	realobj = (char*)objp+obj_user_off(cachep);
+	size = obj_user_size(cachep);
 	for (i=0; i<size && lines;i+=16, lines--) {
 		int limit;
 		limit = 16;
@@ -1352,8 +1358,8 @@
 	int size, i;
 	int lines = 0;
 
-	realobj = (char*)objp+obj_dbghead(cachep);
-	size = obj_reallen(cachep);
+	realobj = (char*)objp+obj_user_off(cachep);
+	size = obj_user_size(cachep);
 
 	for (i=0;i<size;i++) {
 		char exp = POISON_FREE;
@@ -1391,14 +1397,14 @@
 		objnr = (objp-slabp->s_mem)/cachep->objsize;
 		if (objnr) {
 			objp = slabp->s_mem+(objnr-1)*cachep->objsize;
-			realobj = (char*)objp+obj_dbghead(cachep);
+			realobj = (char*)objp+obj_user_off(cachep);
 			printk(KERN_ERR "Prev obj: start=%p, len=%d\n",
 						realobj, size);
 			print_objinfo(cachep, objp, 2);
 		}
 		if (objnr+1 < cachep->num) {
 			objp = slabp->s_mem+(objnr+1)*cachep->objsize;
-			realobj = (char*)objp+obj_dbghead(cachep);
+			realobj = (char*)objp+obj_user_off(cachep);
 			printk(KERN_ERR "Next obj: start=%p, len=%d\n",
 						realobj, size);
 			print_objinfo(cachep, objp, 2);
@@ -1439,7 +1445,7 @@
 							"was overwritten");
 		}
 		if (cachep->dtor && !(cachep->flags & SLAB_POISON))
-			(cachep->dtor)(objp+obj_dbghead(cachep), cachep, 0);
+			(cachep->dtor)(objp+obj_user_off(cachep), cachep, 0);
 	}
 #else
 	if (cachep->dtor) {
@@ -1643,14 +1649,14 @@
 	memset(cachep, 0, sizeof(kmem_cache_t));
 
 #if DEBUG
-	cachep->reallen = size;
+	cachep->user_size = size;
 
 	if (flags & SLAB_RED_ZONE) {
 		/* redzoning only works with word aligned caches */
 		align = BYTES_PER_WORD;
 
 		/* add space for red zone words */
-		cachep->dbghead += BYTES_PER_WORD;
+		cachep->user_off += BYTES_PER_WORD;
 		size += 2*BYTES_PER_WORD;
 	}
 	if (flags & SLAB_STORE_USER) {
@@ -1662,8 +1668,8 @@
 		size += BYTES_PER_WORD;
 	}
 #if FORCED_DEBUG && defined(CONFIG_DEBUG_PAGEALLOC)
-	if (size >= malloc_sizes[INDEX_L3+1].cs_size && cachep->reallen > cache_line_size() && size < PAGE_SIZE) {
-		cachep->dbghead += PAGE_SIZE - size;
+	if (size >= malloc_sizes[INDEX_L3+1].cs_size && cachep->user_size > cache_line_size() && size < PAGE_SIZE) {
+		cachep->user_off += PAGE_SIZE - size;
 		size = PAGE_SIZE;
 	}
 #endif
@@ -2113,7 +2119,7 @@
 		 * Otherwise, deadlock. They must also be threaded.
 		 */
 		if (cachep->ctor && !(cachep->flags & SLAB_POISON))
-			cachep->ctor(objp+obj_dbghead(cachep), cachep, ctor_flags);
+			cachep->ctor(objp+obj_user_off(cachep), cachep, ctor_flags);
 
 		if (cachep->flags & SLAB_RED_ZONE) {
 			if (*dbg_redzone2(cachep, objp) != RED_INACTIVE)
@@ -2282,7 +2288,7 @@
 	unsigned int objnr;
 	struct slab *slabp;
 
-	objp -= obj_dbghead(cachep);
+	objp -= obj_user_off(cachep);
 	kfree_debugcheck(objp);
 	page = virt_to_page(objp);
 
@@ -2318,14 +2324,14 @@
 		 * caller can perform a verify of its state (debugging).
 		 * Called without the cache-lock held.
 		 */
-		cachep->ctor(objp+obj_dbghead(cachep),
+		cachep->ctor(objp+obj_user_off(cachep),
 					cachep, SLAB_CTOR_CONSTRUCTOR|SLAB_CTOR_VERIFY);
 	}
 	if (cachep->flags & SLAB_POISON && cachep->dtor) {
 		/* we want to cache poison the object,
 		 * call the destruction callback
 		 */
-		cachep->dtor(objp+obj_dbghead(cachep), cachep, 0);
+		cachep->dtor(objp+obj_user_off(cachep), cachep, 0);
 	}
 	if (cachep->flags & SLAB_POISON) {
 #ifdef CONFIG_DEBUG_PAGEALLOC
@@ -2521,7 +2527,7 @@
 		objnr = (objp - slabp->s_mem) / cachep->objsize;
 		slab_bufctl(slabp)[objnr] = (unsigned long)caller;
 	}
-	objp += obj_dbghead(cachep);
+	objp += obj_user_off(cachep);
 	if (cachep->ctor && cachep->flags & SLAB_POISON) {
 		unsigned long	ctor_flags = SLAB_CTOR_CONSTRUCTOR;
 
@@ -3079,7 +3085,7 @@
 
 unsigned int kmem_cache_size(kmem_cache_t *cachep)
 {
-	return obj_reallen(cachep);
+	return obj_user_size(cachep);
 }
 EXPORT_SYMBOL(kmem_cache_size);
 
@@ -3655,7 +3661,7 @@
 	if (unlikely(objp == NULL))
 		return 0;
 
-	return obj_reallen(page_get_cache(virt_to_page(objp)));
+	return obj_user_size(page_get_cache(virt_to_page(objp)));
 }
 
 void kmem_set_shrinker(kmem_cache_t *cachep, struct shrinker *shrinker)

--------------060902080706060100040008--
