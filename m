Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932428AbWGHAHw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932428AbWGHAHw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 20:07:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932427AbWGHAF1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 20:05:27 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:60370 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932426AbWGHAFY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 20:05:24 -0400
Date: Fri, 7 Jul 2006 17:05:12 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: Nick Piggin <nickpiggin@yahoo.com.au>,
       Christoph Hellwig <hch@infradead.org>,
       Marcelo Tosatti <marcelo@kvack.org>,
       Arjan van de Ven <arjan@infradead.org>,
       Martin Bligh <mbligh@google.com>, Christoph Lameter <clameter@sgi.com>,
       KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
       Andi Kleen <ak@suse.de>
Message-Id: <20060708000511.3829.66071.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20060708000501.3829.25578.sendpatchset@schroedinger.engr.sgi.com>
References: <20060708000501.3829.25578.sendpatchset@schroedinger.engr.sgi.com>
Subject: [RFC 2/8] slab allocator: Make DMA support configurable
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Support slab without ZONE_SLAB.

If CONFIG_ZONE_DMA is not defined then drop support for ZONE_DMA from
the slab allocator.

Do not create the special DMA slab series for kmalloc and always
return memory from ZONE_NORMAL.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.17-mm6/mm/slab.c
===================================================================
--- linux-2.6.17-mm6.orig/mm/slab.c	2006-07-03 13:47:22.651238848 -0700
+++ linux-2.6.17-mm6/mm/slab.c	2006-07-03 21:39:07.050259199 -0700
@@ -650,11 +650,17 @@ EXPORT_SYMBOL(malloc_sizes);
 /* Must match cache_sizes above. Out of line to keep cache footprint low. */
 struct cache_names {
 	char *name;
+#ifdef CONFIG_ZONE_DMA
 	char *name_dma;
+#endif
 };
 
 static struct cache_names __initdata cache_names[] = {
+#ifdef CONFIG_ZONE_DMA
 #define CACHE(x) { .name = "size-" #x, .name_dma = "size-" #x "(DMA)" },
+#else
+#define CACHE(x) { .name = "size-" #x },
+#endif
 #include <linux/kmalloc_sizes.h>
 	{NULL,}
 #undef CACHE
@@ -729,7 +735,7 @@ static inline struct kmem_cache *__find_
 #endif
 	while (size > csizep->cs_size)
 		csizep++;
-
+#ifdef CONFIG_ZONE_DMA
 	/*
 	 * Really subtle: The last entry with cs->cs_size==ULONG_MAX
 	 * has cs_{dma,}cachep==NULL. Thus no special case
@@ -737,6 +743,7 @@ static inline struct kmem_cache *__find_
 	 */
 	if (unlikely(gfpflags & GFP_DMA))
 		return csizep->cs_dmacachep;
+#endif
 	return csizep->cs_cachep;
 }
 
@@ -1395,13 +1402,14 @@ void __init kmem_cache_init(void)
 					ARCH_KMALLOC_FLAGS|SLAB_PANIC,
 					NULL, NULL);
 		}
-
+#ifdef CONFIG_ZONE_DMA
 		sizes->cs_dmacachep = kmem_cache_create(names->name_dma,
 					sizes->cs_size,
 					ARCH_KMALLOC_MINALIGN,
 					ARCH_KMALLOC_FLAGS|SLAB_CACHE_DMA|
 						SLAB_PANIC,
 					NULL, NULL);
+#endif
 		sizes++;
 		names++;
 	}
@@ -2179,8 +2187,10 @@ kmem_cache_create (const char *name, siz
 	cachep->slab_size = slab_size;
 	cachep->flags = flags;
 	cachep->gfpflags = 0;
+#ifdef CONFIG_ZONE_DMA
 	if (flags & SLAB_CACHE_DMA)
 		cachep->gfpflags |= GFP_DMA;
+#endif
 	cachep->buffer_size = size;
 
 	if (flags & CFLGS_OFF_SLAB)
@@ -2498,10 +2508,12 @@ static void cache_init_objs(struct kmem_
 
 static void kmem_flagcheck(struct kmem_cache *cachep, gfp_t flags)
 {
+#ifdef CONFIG_ZONE_DMA
 	if (flags & SLAB_DMA)
 		BUG_ON(!(cachep->gfpflags & GFP_DMA));
 	else
 		BUG_ON(cachep->gfpflags & GFP_DMA);
+#endif
 }
 
 static void *slab_get_obj(struct kmem_cache *cachep, struct slab *slabp,
Index: linux-2.6.17-mm6/include/linux/slab.h
===================================================================
--- linux-2.6.17-mm6.orig/include/linux/slab.h	2006-07-03 21:27:34.756012776 -0700
+++ linux-2.6.17-mm6/include/linux/slab.h	2006-07-03 22:07:16.857980432 -0700
@@ -72,7 +72,9 @@ extern const char *kmem_cache_name(kmem_
 struct cache_sizes {
 	size_t		 cs_size;
 	kmem_cache_t	*cs_cachep;
+#ifdef CONFIG_ZONE_DMA
 	kmem_cache_t	*cs_dmacachep;
+#endif
 };
 extern struct cache_sizes malloc_sizes[];
 
@@ -146,9 +148,13 @@ static inline void *kmalloc(size_t size,
 			__you_cannot_kmalloc_that_much();
 		}
 found:
+#ifdef CONFIG_ZONE_DMA
 		return kmem_cache_alloc((flags & GFP_DMA) ?
 			malloc_sizes[i].cs_dmacachep :
 			malloc_sizes[i].cs_cachep, flags);
+#else
+		return kmem_cache_alloc(malloc_sizes[i].cs_cachep, flags);
+#endif
 	}
 	return __kmalloc(size, flags);
 }
@@ -176,9 +182,13 @@ static inline void *kzalloc(size_t size,
 			__you_cannot_kzalloc_that_much();
 		}
 found:
+#ifdef CONFIG_ZONE_DMA
 		return kmem_cache_zalloc((flags & GFP_DMA) ?
 			malloc_sizes[i].cs_dmacachep :
 			malloc_sizes[i].cs_cachep, flags);
+#else
+		return kmem_cache_zalloc(malloc_sizes[i].cs_cachep, flags);
+#endif
 	}
 	return __kzalloc(size, flags);
 }
