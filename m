Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751134AbWIAWfT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751134AbWIAWfT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 18:35:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751131AbWIAWe7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 18:34:59 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:39908 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751134AbWIAWeo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 18:34:44 -0400
Date: Fri, 1 Sep 2006 15:34:29 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: akpm@osdl.org
Cc: Pekka Enberg <penberg@cs.helsinki.fi>, Marcelo Tosatti <marcelo@kvack.org>,
       linux-kernel@vger.kernel.org, Nick Piggin <nickpiggin@yahoo.com.au>,
       linux-mm@kvack.org, Christoph Lameter <clameter@sgi.com>,
       mpm@selenic.com, Manfred Spraul <manfred@colorfullife.com>,
       Dave Chinner <dgc@sgi.com>, Andi Kleen <ak@suse.de>
Message-Id: <20060901223429.21034.73197.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20060901223358.21034.83736.sendpatchset@schroedinger.engr.sgi.com>
References: <20060901223358.21034.83736.sendpatchset@schroedinger.engr.sgi.com>
Subject: [MODSLAB] Bypass indirections [for performance testing only]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bypass indirections.

This is a patch to bypass indirections so that one can get some statistics
on how high the impact of the indirect calls is.

Only use this for testing.

Index: linux-2.6.18-rc5-mm1/mm/slabifier.c
===================================================================
--- linux-2.6.18-rc5-mm1.orig/mm/slabifier.c	2006-09-01 14:25:55.907938735 -0700
+++ linux-2.6.18-rc5-mm1/mm/slabifier.c	2006-09-01 15:20:51.915297648 -0700
@@ -498,12 +498,13 @@ gotpage:
 	goto redo;
 }
 
-static void *slab_alloc(struct slab_cache *sc, gfp_t gfpflags)
+void *slab_alloc(struct slab_cache *sc, gfp_t gfpflags)
 {
 	return __slab_alloc(sc, gfpflags, -1);
 }
+EXPORT_SYMBOL(slab_alloc);
 
-static void *slab_alloc_node(struct slab_cache *sc, gfp_t gfpflags,
+void *slab_alloc_node(struct slab_cache *sc, gfp_t gfpflags,
 							int node)
 {
 #ifdef CONFIG_NUMA
@@ -512,8 +513,9 @@ static void *slab_alloc_node(struct slab
 	return slab_alloc(sc, gfpflags);
 #endif
 }
+EXPORT_SYMBOL(slab_alloc_node);
 
-static void slab_free(struct slab_cache *sc, const void *x)
+void slab_free(struct slab_cache *sc, const void *x)
 {
 	struct slab *s = (void *)sc;
 	struct page * page;
@@ -617,6 +619,7 @@ dumpret:
 	return;
 #endif
 }
+EXPORT_SYMBOL(slab_free);
 
 /* Figure out on which slab object the object resides */
 static __always_inline struct page *get_object_page(const void *x)
Index: linux-2.6.18-rc5-mm1/include/linux/kmalloc.h
===================================================================
--- linux-2.6.18-rc5-mm1.orig/include/linux/kmalloc.h	2006-09-01 14:26:06.439513840 -0700
+++ linux-2.6.18-rc5-mm1/include/linux/kmalloc.h	2006-09-01 15:20:51.917250652 -0700
@@ -67,6 +67,10 @@ static inline int kmalloc_index(int size
 	return -1;
 }
 
+extern void *slab_alloc(struct slab_cache *, gfp_t flags);
+extern void *slab_alloc_node(struct slab_cache *, gfp_t, int);
+extern void slab_free(struct slab_cache *, const void *);
+
 /*
  * Find the slab cache for a given combination of allocation flags and size.
  *
@@ -96,7 +100,7 @@ static inline void *kmalloc(size_t size,
 	if (__builtin_constant_p(size) && !(flags & __GFP_DMA)) {
 		struct slab_cache *s = kmalloc_slab(size);
 
-		return KMALLOC_ALLOCATOR.alloc(s, flags);
+		return slab_alloc(s, flags);
 	} else
 		return __kmalloc(size, flags);
 }
@@ -108,7 +112,7 @@ static inline void *kmalloc_node(size_t 
 	if (__builtin_constant_p(size) && !(flags & __GFP_DMA)) {
 		struct slab_cache *s = kmalloc_slab(size);
 
-		return KMALLOC_ALLOCATOR.alloc_node(s, flags, node);
+		return slab_alloc_node(s, flags, node);
 	} else
 		return __kmalloc_node(size, flags, node);
 }
@@ -119,7 +123,7 @@ static inline void *kmalloc_node(size_t 
 /* Free an object */
 static inline void kfree(const void *x)
 {
-	return KMALLOC_ALLOCATOR.free(NULL, x);
+	slab_free(NULL, x);
 }
 
 /* Allocate and zero the specified number of bytes */
Index: linux-2.6.18-rc5-mm1/mm/kmalloc.c
===================================================================
--- linux-2.6.18-rc5-mm1.orig/mm/kmalloc.c	2006-09-01 14:26:06.440490342 -0700
+++ linux-2.6.18-rc5-mm1/mm/kmalloc.c	2006-09-01 15:20:51.917250652 -0700
@@ -124,15 +124,14 @@ static struct slab_cache *get_slab(size_
 
 void *__kmalloc(size_t size, gfp_t flags)
 {
-	return KMALLOC_ALLOCATOR.alloc(get_slab(size, flags), flags);
+	return slab_alloc(get_slab(size, flags), flags);
 }
 EXPORT_SYMBOL(__kmalloc);
 
 #ifdef CONFIG_NUMA
 void *__kmalloc_node(size_t size, gfp_t flags, int node)
 {
-	return KMALLOC_ALLOCATOR.alloc_node(get_slab(size, flags),
-							flags, node);
+	return slab_alloc_node(get_slab(size, flags), flags, node);
 }
 EXPORT_SYMBOL(__kmalloc_node);
 #endif
Index: linux-2.6.18-rc5-mm1/include/linux/slabulator.h
===================================================================
--- linux-2.6.18-rc5-mm1.orig/include/linux/slabulator.h	2006-09-01 14:26:06.861362745 -0700
+++ linux-2.6.18-rc5-mm1/include/linux/slabulator.h	2006-09-01 15:20:51.918227155 -0700
@@ -73,20 +73,23 @@ static inline const char *kmem_cache_nam
 
 static inline void *kmem_cache_alloc(struct slab_cache *s, gfp_t flags)
 {
-	return SLABULATOR_ALLOCATOR.alloc(s, flags);
+	return slab_alloc(s, flags);
+	//return SLABULATOR_ALLOCATOR.alloc(s, flags);
 }
 
 static inline void *kmem_cache_alloc_node(struct slab_cache *s,
 					gfp_t flags, int node)
 {
-	return SLABULATOR_ALLOCATOR.alloc_node(s, flags, node);
+	return slab_alloc_node(s, flags, node);
+//	return SLABULATOR_ALLOCATOR.alloc_node(s, flags, node);
 }
 
 extern void *kmem_cache_zalloc(struct slab_cache *s, gfp_t flags);
 
 static inline void kmem_cache_free(struct slab_cache *s, const void *x)
 {
-	SLABULATOR_ALLOCATOR.free(s, x);
+	slab_free(s, x);
+//	SLABULATOR_ALLOCATOR.free(s, x);
 }
 
 static inline int kmem_ptr_validate(struct slab_cache *s, void *x)

-- 
VGER BF report: H 9.54801e-11
