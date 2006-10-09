Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932645AbWJIMtS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932645AbWJIMtS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 08:49:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932643AbWJIMtS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 08:49:18 -0400
Received: from mtaout02-winn.ispmail.ntl.com ([81.103.221.48]:48998 "EHLO
	mtaout02-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S932645AbWJIMtP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 08:49:15 -0400
From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: [PATCH 2.6.19-rc1 03/10] Add the memory allocation/freeing hooks for kmemleak
Date: Mon, 09 Oct 2006 13:49:05 +0100
To: linux-kernel@vger.kernel.org
Message-Id: <20061009124905.2695.98906.stgit@localhost.localdomain>
In-Reply-To: <20061009124813.2695.8123.stgit@localhost.localdomain>
References: <20061009124813.2695.8123.stgit@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Catalin Marinas <catalin.marinas@arm.com>

This patch adds the callbacks to memleak_(alloc|free) functions from
kmalloc/kfree, kmem_cache_(alloc|free), vmalloc/vfree etc.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
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
index a8c003e..9e1eff9 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3121,6 +3121,8 @@ void *__init alloc_large_system_hash(con
 	if (_hash_mask)
 		*_hash_mask = (1 << log2qty) - 1;
 
+	memleak_alloc(table, size, 1);
+
 	return table;
 }
 
diff --git a/mm/slab.c b/mm/slab.c
index e9a63b5..4d18cb1 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -2545,6 +2545,9 @@ static struct slab *alloc_slabmgmt(struc
 		/* Slab management obj is off-slab. */
 		slabp = kmem_cache_alloc_node(cachep->slabp_cache,
 					      local_flags, nodeid);
+		/* only scan the list member to avoid false negatives */
+		memleak_scan_area(slabp, offsetof(struct slab, list),
+				  sizeof(struct list_head));
 		if (!slabp)
 			return NULL;
 	} else {
@@ -3077,6 +3080,8 @@ static inline void *____cache_alloc(stru
 		STATS_INC_ALLOCMISS(cachep);
 		objp = cache_alloc_refill(cachep, flags);
 	}
+	/* avoid false negatives */
+	memleak_erase(&ac->entry[ac->avail]);
 	return objp;
 }
 
@@ -3105,6 +3110,7 @@ static __always_inline void *__cache_all
 	local_irq_restore(save_flags);
 	objp = cache_alloc_debugcheck_after(cachep, flags, objp,
 					    caller);
+	memleak_alloc(objp, obj_size(cachep), 1);
 	prefetchw(objp);
 	return objp;
 }
@@ -3328,6 +3334,7 @@ static inline void __cache_free(struct k
 	struct array_cache *ac = cpu_cache_get(cachep);
 
 	check_irq_off();
+	memleak_free(objp);
 	objp = cache_free_debugcheck(cachep, objp, __builtin_return_address(0));
 
 	if (cache_free_alien(cachep, objp))
@@ -3447,6 +3454,7 @@ void *kmem_cache_alloc_node(struct kmem_
 
 	ptr = cache_alloc_debugcheck_after(cachep, flags, ptr,
 					   __builtin_return_address(0));
+	memleak_alloc(ptr, obj_size(cachep), 1);
 
 	return ptr;
 }
@@ -3455,11 +3463,14 @@ EXPORT_SYMBOL(kmem_cache_alloc_node);
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
@@ -3474,6 +3485,7 @@ static __always_inline void *__do_kmallo
 					  void *caller)
 {
 	struct kmem_cache *cachep;
+	void *ptr;
 
 	/* If you want to save a few bytes .text space: replace
 	 * __ with kmem_.
@@ -3483,7 +3495,10 @@ static __always_inline void *__do_kmallo
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
index 750ab6e..d13dba3 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -364,6 +364,9 @@ void __vunmap(void *addr, int deallocate
 void vfree(void *addr)
 {
 	BUG_ON(in_interrupt());
+
+	memleak_free(addr);
+
 	__vunmap(addr, 1);
 }
 EXPORT_SYMBOL(vfree);
@@ -461,7 +464,14 @@ fail:
 
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
@@ -479,6 +489,8 @@ static void *__vmalloc_node(unsigned lon
 			    int node)
 {
 	struct vm_struct *area;
+	void *addr;
+	unsigned long real_size = size;
 
 	size = PAGE_ALIGN(size);
 	if (!size || (size >> PAGE_SHIFT) > num_physpages)
@@ -488,7 +500,13 @@ static void *__vmalloc_node(unsigned lon
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
