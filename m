Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965261AbWGJWKi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965261AbWGJWKi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 18:10:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965258AbWGJWKU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 18:10:20 -0400
Received: from mta07-winn.ispmail.ntl.com ([81.103.221.47]:1808 "EHLO
	mtaout01-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S965254AbWGJWKC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 18:10:02 -0400
From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: [PATCH 03/10] Add the memory allocation/freeing hooks for kmemleak
Date: Mon, 10 Jul 2006 23:09:58 +0100
To: linux-kernel@vger.kernel.org
Message-Id: <20060710220957.5191.54019.stgit@localhost.localdomain>
In-Reply-To: <20060710220901.5191.66488.stgit@localhost.localdomain>
References: <20060710220901.5191.66488.stgit@localhost.localdomain>
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
 mm/slab.c            |   26 +++++++++++++++++++++++---
 mm/vmalloc.c         |   22 ++++++++++++++++++++--
 4 files changed, 51 insertions(+), 5 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index 45ad55b..e3f5945 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -133,6 +133,8 @@ #endif
  */
 static inline void *kmalloc(size_t size, gfp_t flags)
 {
+#ifndef CONFIG_DEBUG_MEMLEAK
+	/* this block removes the size information needed by kmemleak */
 	if (__builtin_constant_p(size)) {
 		int i = 0;
 #define CACHE(x) \
@@ -151,6 +153,7 @@ found:
 			malloc_sizes[i].cs_dmacachep :
 			malloc_sizes[i].cs_cachep, flags);
 	}
+#endif
 	return __kmalloc(size, flags);
 }
 
@@ -163,6 +166,8 @@ extern void *__kzalloc(size_t, gfp_t);
  */
 static inline void *kzalloc(size_t size, gfp_t flags)
 {
+#ifndef CONFIG_DEBUG_MEMLEAK
+	/* this block removes the size information needed by kmemleak */
 	if (__builtin_constant_p(size)) {
 		int i = 0;
 #define CACHE(x) \
@@ -181,6 +186,7 @@ found:
 			malloc_sizes[i].cs_dmacachep :
 			malloc_sizes[i].cs_cachep, flags);
 	}
+#endif
 	return __kzalloc(size, flags);
 }
 
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 54a4f53..bdf6445 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2450,6 +2450,8 @@ void *__init alloc_large_system_hash(con
 	if (_hash_mask)
 		*_hash_mask = (1 << log2qty) - 1;
 
+	memleak_alloc(table, size, 1);
+
 	return table;
 }
 
diff --git a/mm/slab.c b/mm/slab.c
index 85c2e03..2752272 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -2967,6 +2967,7 @@ #endif
 		STATS_INC_ALLOCMISS(cachep);
 		objp = cache_alloc_refill(cachep, flags);
 	}
+	memleak_erase(&ac->entry[ac->avail]);
 	return objp;
 }
 
@@ -3183,6 +3184,7 @@ static void __cache_free(struct kmem_cac
 	struct array_cache *ac = cpu_cache_get(cachep);
 
 	check_irq_off();
+	memleak_free(objp);
 	objp = cache_free_debugcheck(cachep, objp, __builtin_return_address(0));
 
 	if (cache_free_alien(cachep, objp, nesting))
@@ -3209,7 +3211,11 @@ static void __cache_free(struct kmem_cac
  */
 void *kmem_cache_alloc(struct kmem_cache *cachep, gfp_t flags)
 {
-	return __cache_alloc(cachep, flags, __builtin_return_address(0));
+	void *ptr = __cache_alloc(cachep, flags, __builtin_return_address(0));
+
+	memleak_alloc(ptr, obj_size(cachep), 1);
+
+	return ptr;
 }
 EXPORT_SYMBOL(kmem_cache_alloc);
 
@@ -3224,6 +3230,9 @@ EXPORT_SYMBOL(kmem_cache_alloc);
 void *kmem_cache_zalloc(struct kmem_cache *cache, gfp_t flags)
 {
 	void *ret = __cache_alloc(cache, flags, __builtin_return_address(0));
+
+	memleak_alloc(ret, obj_size(cache), 1);
+
 	if (ret)
 		memset(ret, 0, obj_size(cache));
 	return ret;
@@ -3302,6 +3311,7 @@ void *kmem_cache_alloc_node(struct kmem_
 
 	ptr = cache_alloc_debugcheck_after(cachep, flags, ptr,
 					   __builtin_return_address(0));
+	memleak_alloc(ptr, obj_size(cachep), 1);
 
 	return ptr;
 }
@@ -3310,11 +3320,15 @@ EXPORT_SYMBOL(kmem_cache_alloc_node);
 void *kmalloc_node(size_t size, gfp_t flags, int node)
 {
 	struct kmem_cache *cachep;
+	void *ptr;
 
 	cachep = kmem_find_general_cachep(size, flags);
 	if (unlikely(cachep == NULL))
 		return NULL;
-	return kmem_cache_alloc_node(cachep, flags, node);
+	ptr = kmem_cache_alloc_node(cachep, flags, node);
+	memleak_typeid_raw(ptr, ml_guess_typeid(size));
+	memleak_padding(ptr, 0, size);
+	return ptr;
 }
 EXPORT_SYMBOL(kmalloc_node);
 #endif
@@ -3329,6 +3343,7 @@ static __always_inline void *__do_kmallo
 					  void *caller)
 {
 	struct kmem_cache *cachep;
+	void *ptr;
 
 	/* If you want to save a few bytes .text space: replace
 	 * __ with kmem_.
@@ -3338,7 +3353,11 @@ static __always_inline void *__do_kmallo
 	cachep = __find_general_cachep(size, flags);
 	if (unlikely(cachep == NULL))
 		return NULL;
-	return __cache_alloc(cachep, flags, caller);
+	ptr = __cache_alloc(cachep, flags, caller);
+
+	memleak_alloc(ptr, size, 1);
+
+	return ptr;
 }
 
 
@@ -3447,6 +3466,7 @@ void kfree(const void *objp)
 		return;
 	local_irq_save(flags);
 	kfree_debugcheck(objp);
+
 	c = virt_to_cache(objp);
 	debug_check_no_locks_freed(objp, obj_size(c));
 	__cache_free(c, (void *)objp, 0);
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 7b45079..b84a862 100644
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
@@ -462,7 +465,14 @@ fail:
 
 void *__vmalloc_area(struct vm_struct *area, gfp_t gfp_mask, pgprot_t prot)
 {
-	return __vmalloc_area_node(area, gfp_mask, prot, -1);
+	void *addr = __vmalloc_area_node(area, gfp_mask, prot, -1);
+
+	/* this needs ref_count = 2 since vm_struct also contains a
+	   pointer to this address. The guard page is also subtracted
+	   from the size */
+	memleak_alloc(addr, area->size - PAGE_SIZE, 2);
+
+	return addr;
 }
 
 /**
@@ -481,6 +491,8 @@ void *__vmalloc_node(unsigned long size,
 			int node)
 {
 	struct vm_struct *area;
+	void *addr;
+	unsigned long real_size = size;
 
 	size = PAGE_ALIGN(size);
 	if (!size || (size >> PAGE_SHIFT) > num_physpages)
@@ -490,7 +502,13 @@ void *__vmalloc_node(unsigned long size,
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
 EXPORT_SYMBOL(__vmalloc_node);
 
