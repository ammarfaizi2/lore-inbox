Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967947AbWK3XAb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967947AbWK3XAb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 18:00:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967944AbWK3XAa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 18:00:30 -0500
Received: from mtaout01-winn.ispmail.ntl.com ([81.103.221.47]:1849 "EHLO
	mtaout01-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S967947AbWK3XAY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 18:00:24 -0500
From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: [PATCH 2.6.19 03/10] Add the memory allocation/freeing hooks for
	kmemleak
To: linux-kernel@vger.kernel.org
Date: Thu, 30 Nov 2006 23:00:19 +0000
Message-ID: <20061130230019.5469.62357.stgit@localhost.localdomain>
In-Reply-To: <20061130225219.5469.2453.stgit@localhost.localdomain>
References: <20061130225219.5469.2453.stgit@localhost.localdomain>
User-Agent: StGIT/0.11
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the callbacks to memleak_(alloc|free) functions from
kmalloc/kfree, kmem_cache_(alloc|free), vmalloc/vfree etc.

Signed-off-by: Catalin Marinas <catalin.marinas@gmail.com>
---

 include/linux/slab.h |    6 ++++++
 mm/page_alloc.c      |    2 ++
 mm/slab.c            |   19 +++++++++++++++++--
 mm/vmalloc.c         |   22 ++++++++++++++++++++--
 4 files changed, 45 insertions(+), 4 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index c4947b8..cbb8e47 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -125,6 +125,8 @@ extern void *__kmalloc(size_t, gfp_t);
  */
 static inline void *kmalloc(size_t size, gfp_t flags)
 {
+#ifndef CONFIG_DEBUG_MEMLEAK
+	/* this block removes the size information needed by kmemleak */
 	if (__builtin_constant_p(size)) {
 		int i = 0;
 #define CACHE(x) \
@@ -143,6 +145,7 @@ found:
 			malloc_sizes[i].cs_dmacachep :
 			malloc_sizes[i].cs_cachep, flags);
 	}
+#endif
 	return __kmalloc(size, flags);
 }
 
@@ -172,6 +175,8 @@ extern void *__kzalloc(size_t, gfp_t);
  */
 static inline void *kzalloc(size_t size, gfp_t flags)
 {
+#ifndef CONFIG_DEBUG_MEMLEAK
+	/* this block removes the size information needed by kmemleak */
 	if (__builtin_constant_p(size)) {
 		int i = 0;
 #define CACHE(x) \
@@ -190,6 +195,7 @@ found:
 			malloc_sizes[i].cs_dmacachep :
 			malloc_sizes[i].cs_cachep, flags);
 	}
+#endif
 	return __kzalloc(size, flags);
 }
 
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index aa6fcc7..2176d03 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3107,6 +3107,8 @@ void *__init alloc_large_system_hash(con
 	if (_hash_mask)
 		*_hash_mask = (1 << log2qty) - 1;
 
+	memleak_alloc(table, size, 1);
+
 	return table;
 }
 
diff --git a/mm/slab.c b/mm/slab.c
index 3c4a7e3..93aead5 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -2549,6 +2549,9 @@ static struct slab *alloc_slabmgmt(struc
 		/* Slab management obj is off-slab. */
 		slabp = kmem_cache_alloc_node(cachep->slabp_cache,
 					      local_flags, nodeid);
+		/* only scan the list member to avoid false negatives */
+		memleak_scan_area(slabp, offsetof(struct slab, list),
+				  sizeof(struct list_head));
 		if (!slabp)
 			return NULL;
 	} else {
@@ -3084,6 +3087,8 @@ static inline void *____cache_alloc(stru
 		STATS_INC_ALLOCMISS(cachep);
 		objp = cache_alloc_refill(cachep, flags);
 	}
+	/* avoid false negatives */
+	memleak_erase(&ac->entry[ac->avail]);
 	return objp;
 }
 
@@ -3112,6 +3117,7 @@ static __always_inline void *__cache_all
 	local_irq_restore(save_flags);
 	objp = cache_alloc_debugcheck_after(cachep, flags, objp,
 					    caller);
+	memleak_alloc(objp, obj_size(cachep), 1);
 	prefetchw(objp);
 	return objp;
 }
@@ -3338,6 +3344,7 @@ static inline void __cache_free(struct k
 	struct array_cache *ac = cpu_cache_get(cachep);
 
 	check_irq_off();
+	memleak_free(objp);
 	objp = cache_free_debugcheck(cachep, objp, __builtin_return_address(0));
 
 	if (cache_free_alien(cachep, objp))
@@ -3457,6 +3464,7 @@ void *kmem_cache_alloc_node(struct kmem_
 
 	ptr = cache_alloc_debugcheck_after(cachep, flags, ptr,
 					   __builtin_return_address(0));
+	memleak_alloc(ptr, obj_size(cachep), 1);
 
 	return ptr;
 }
@@ -3465,11 +3473,14 @@ EXPORT_SYMBOL(kmem_cache_alloc_node);
 void *__kmalloc_node(size_t size, gfp_t flags, int node)
 {
 	struct kmem_cache *cachep;
+	void *ptr;
 
 	cachep = kmem_find_general_cachep(size, flags);
 	if (unlikely(cachep == NULL))
 		return NULL;
-	return kmem_cache_alloc_node(cachep, flags, node);
+	ptr = kmem_cache_alloc_node(cachep, flags, node);
+	memleak_padding(ptr, 0, size);
+	return ptr;
 }
 EXPORT_SYMBOL(__kmalloc_node);
 #endif
@@ -3484,6 +3495,7 @@ static __always_inline void *__do_kmallo
 					  void *caller)
 {
 	struct kmem_cache *cachep;
+	void *ptr;
 
 	/* If you want to save a few bytes .text space: replace
 	 * __ with kmem_.
@@ -3493,7 +3505,10 @@ static __always_inline void *__do_kmallo
 	cachep = __find_general_cachep(size, flags);
 	if (unlikely(cachep == NULL))
 		return NULL;
-	return __cache_alloc(cachep, flags, caller);
+	ptr = __cache_alloc(cachep, flags, caller);
+	memleak_padding(ptr, 0, size);
+
+	return ptr;
 }
 
 
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 86897ee..603aee9 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -365,6 +365,9 @@ void __vunmap(void *addr, int deallocate
 void vfree(void *addr)
 {
 	BUG_ON(in_interrupt());
+
+	memleak_free(addr);
+
 	__vunmap(addr, 1);
 }
 EXPORT_SYMBOL(vfree);
@@ -465,7 +468,14 @@ fail:
 
 void *__vmalloc_area(struct vm_struct *area, gfp_t gfp_mask, pgprot_t prot)
 {
-	return __vmalloc_area_node(area, gfp_mask, prot, -1);
+	void *addr = __vmalloc_area_node(area, gfp_mask, prot, -1);
+
+	/* this needs ref_count = 2 since vm_struct also contains a
+	 * pointer to this address. The guard page is also subtracted
+	 * from the size */
+	memleak_alloc(addr, area->size - PAGE_SIZE, 2);
+
+	return addr;
 }
 
 /**
@@ -483,6 +493,8 @@ static void *__vmalloc_node(unsigned lon
 			    int node)
 {
 	struct vm_struct *area;
+	void *addr;
+	unsigned long real_size = size;
 
 	size = PAGE_ALIGN(size);
 	if (!size || (size >> PAGE_SHIFT) > num_physpages)
@@ -492,7 +504,13 @@ static void *__vmalloc_node(unsigned lon
 	if (!area)
 		return NULL;
 
-	return __vmalloc_area_node(area, gfp_mask, prot, node);
+	addr = __vmalloc_area_node(area, gfp_mask, prot, node);
+
+	/* this needs ref_count = 2 since the vm_struct also contains
+	   a pointer to this address */
+	memleak_alloc(addr, real_size, 2);
+
+	return addr;
 }
 
 void *__vmalloc(unsigned long size, gfp_t gfp_mask, pgprot_t prot)
