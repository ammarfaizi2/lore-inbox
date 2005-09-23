Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750907AbVIWRuK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750907AbVIWRuK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 13:50:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750925AbVIWRuJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 13:50:09 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:25525 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1750919AbVIWRuI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 13:50:08 -0400
Date: Fri, 23 Sep 2005 10:50:02 -0700 (PDT)
From: Christoph Lameter <clameter@engr.sgi.com>
To: akpm@osdl.org
cc: Nick Piggin <nickpiggin@yahoo.com.au>,
       "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org
Subject: Re: Make kzalloc a macro
In-Reply-To: <Pine.LNX.4.62.0509230857190.22086@schroedinger.engr.sgi.com>
Message-ID: <Pine.LNX.4.62.0509231048530.22423@schroedinger.engr.sgi.com>
References: <4333A109.2000908@yahoo.com.au>  <200509230909.54046.ioe-lkml@rameria.de>
  <4333B588.9060503@yahoo.com.au>  <20050923.010939.11256142.davem@davemloft.net>
  <4333C4F4.9030402@yahoo.com.au> <2cd57c9005092302174e0f657e@mail.gmail.com>
 <Pine.LNX.4.62.0509230857190.22086@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Next rev. There was an issue with kmalloc_node:

---
Make kzalloc a macro and use __GFP_ZERO for zeroed slab allocations

kzalloc is right now a function call. The optimization that the kmalloc macro
provides does not work for kzalloc invocations. kmalloc also determines the
slab to use at compile time and fails the compilation if the size is too big.
kzalloc cannot do not.

Moreover there is no kzalloc_node.

This patch adds the ability to the slab allocator to indicate that an entity
should be zeroed by using __GFP_ZERO in the same way to the page allocator.

__GFP_ZERO may be specified when using any slab allocation operation.

Then kzalloc can be defined as a simple macro which will then perform all the
compile time checks of kmalloc and also check the sizes.

Signed-off-by: Christoph Lameter

Index: linux-2.6.14-rc2/include/linux/slab.h
===================================================================
--- linux-2.6.14-rc2.orig/include/linux/slab.h	2005-09-19 20:00:41.000000000 -0700
+++ linux-2.6.14-rc2/include/linux/slab.h	2005-09-23 10:17:20.000000000 -0700
@@ -99,7 +99,7 @@ found:
 	return __kmalloc(size, flags);
 }
 
-extern void *kzalloc(size_t, unsigned int __nocast);
+#define kzalloc(__size, __flags) kmalloc(__size, (__flags) | __GFP_ZERO)
 
 /**
  * kcalloc - allocate memory for an array. The memory is set to zero.
Index: linux-2.6.14-rc2/mm/slab.c
===================================================================
--- linux-2.6.14-rc2.orig/mm/slab.c	2005-09-23 10:17:20.000000000 -0700
+++ linux-2.6.14-rc2/mm/slab.c	2005-09-23 10:17:20.000000000 -0700
@@ -1191,7 +1191,7 @@ static void *kmem_getpages(kmem_cache_t 
 	void *addr;
 	int i;
 
-	flags |= cachep->gfpflags;
+	flags = (flags | cachep->gfpflags) & ~__GFP_ZERO;
 	if (likely(nodeid == -1)) {
 		page = alloc_pages(flags, cachep->gfporder);
 	} else {
@@ -2510,11 +2510,21 @@ cache_alloc_debugcheck_after(kmem_cache_
 #define cache_alloc_debugcheck_after(a,b,objp,d) (objp)
 #endif
 
+static inline void *obj_checkout(kmem_cache_t *cachep, unsigned int __nocast flags, void *objp)
+{
+	if (likely(objp)) {
+		if (unlikely(flags & __GFP_ZERO))
+			memset(objp, 0, obj_reallen(cachep));
+		else
+			prefetchw(objp);
+	}
+	return objp;
+}
 
 static inline void *__cache_alloc(kmem_cache_t *cachep, unsigned int __nocast flags)
 {
 	unsigned long save_flags;
-	void* objp;
+	void *objp;
 	struct array_cache *ac;
 
 	cache_alloc_debugcheck_before(cachep, flags);
@@ -2532,8 +2542,7 @@ static inline void *__cache_alloc(kmem_c
 	local_irq_restore(save_flags);
 	objp = cache_alloc_debugcheck_after(cachep, flags, objp,
 					__builtin_return_address(0));
-	prefetchw(objp);
-	return objp;
+	return obj_checkout(cachep, flags, objp);
 }
 
 #ifdef CONFIG_NUMA
@@ -2558,8 +2567,15 @@ retry:
  	if (entry == &l3->slabs_partial) {
  		l3->free_touched = 1;
  		entry = l3->slabs_free.next;
- 		if (entry == &l3->slabs_free)
- 			goto must_grow;
+ 		if (entry == &l3->slabs_free) {
+ 			spin_unlock(&l3->list_lock);
+ 			x = cache_grow(cachep, flags, nodeid);
+
+		 	if (!x)
+ 				return NULL;
+
+ 			goto retry;
+		}
  	}
 
  	slabp = list_entry(entry, struct slab, list);
@@ -2592,18 +2608,7 @@ retry:
  	}
 
  	spin_unlock(&l3->list_lock);
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
+	return obj_checkout(cachep, flags, obj);
 }
 #endif
 
@@ -2981,20 +2986,6 @@ void kmem_cache_free(kmem_cache_t *cache
 EXPORT_SYMBOL(kmem_cache_free);
 
 /**
- * kzalloc - allocate memory. The memory is set to zero.
- * @size: how many bytes of memory are required.
- * @flags: the type of memory to allocate.
- */
-void *kzalloc(size_t size, unsigned int __nocast flags)
-{
-	void *ret = kmalloc(size, flags);
-	if (ret)
-		memset(ret, 0, size);
-	return ret;
-}
-EXPORT_SYMBOL(kzalloc);
-
-/**
  * kfree - free previously allocated memory
  * @objp: pointer returned by kmalloc.
  *
