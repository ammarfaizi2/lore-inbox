Return-Path: <linux-kernel-owner+w=401wt.eu-S1161082AbWLPPsJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161082AbWLPPsJ (ORCPT <rfc822;w@1wt.eu>);
	Sat, 16 Dec 2006 10:48:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161083AbWLPPrk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Dec 2006 10:47:40 -0500
Received: from queue04-winn.ispmail.ntl.com ([81.103.221.58]:42406 "EHLO
	queue04-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1161078AbWLPPre (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Dec 2006 10:47:34 -0500
From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: [PATCH 2.6.20-rc1 03/10] Add the memory allocation/freeing hooks for
	kmemleak
To: linux-kernel@vger.kernel.org
Date: Sat, 16 Dec 2006 15:34:48 +0000
Message-ID: <20061216153448.18200.73637.stgit@localhost.localdomain>
In-Reply-To: <20061216153346.18200.51408.stgit@localhost.localdomain>
References: <20061216153346.18200.51408.stgit@localhost.localdomain>
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

 include/linux/slab_def.h |    6 ++++++
 mm/page_alloc.c          |    2 ++
 mm/slab.c                |   19 +++++++++++++++++--
 mm/vmalloc.c             |   22 ++++++++++++++++++++--
 4 files changed, 45 insertions(+), 4 deletions(-)

diff --git a/include/linux/slab_def.h b/include/linux/slab_def.h
index 4b463e6..30d4bd9 100644
--- a/include/linux/slab_def.h
+++ b/include/linux/slab_def.h
@@ -25,6 +25,7 @@ extern struct cache_sizes malloc_sizes[]
 
 static inline void *kmalloc(size_t size, gfp_t flags)
 {
+#ifndef CONFIG_DEBUG_MEMLEAK
 	if (__builtin_constant_p(size)) {
 		int i = 0;
 #define CACHE(x) \
@@ -43,11 +44,13 @@ found:
 			malloc_sizes[i].cs_dmacachep :
 			malloc_sizes[i].cs_cachep, flags);
 	}
+#endif
 	return __kmalloc(size, flags);
 }
 
 static inline void *kzalloc(size_t size, gfp_t flags)
 {
+#ifndef CONFIG_DEBUG_MEMLEAK
 	if (__builtin_constant_p(size)) {
 		int i = 0;
 #define CACHE(x) \
@@ -66,6 +69,7 @@ found:
 			malloc_sizes[i].cs_dmacachep :
 			malloc_sizes[i].cs_cachep, flags);
 	}
+#endif
 	return __kzalloc(size, flags);
 }
 
@@ -74,6 +78,7 @@ extern void *__kmalloc_node(size_t size,
 
 static inline void *kmalloc_node(size_t size, gfp_t flags, int node)
 {
+#ifndef CONFIG_DEBUG_MEMLEAK
 	if (__builtin_constant_p(size)) {
 		int i = 0;
 #define CACHE(x) \
@@ -92,6 +97,7 @@ found:
 			malloc_sizes[i].cs_dmacachep :
 			malloc_sizes[i].cs_cachep, flags, node);
 	}
+#endif
 	return __kmalloc_node(size, flags, node);
 }
 
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 8c1a116..816e909 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3363,6 +3363,8 @@ void *__init alloc_large_system_hash(con
 	if (_hash_mask)
 		*_hash_mask = (1 << log2qty) - 1;
 
+	memleak_alloc(table, size, 1);
+
 	return table;
 }
 
diff --git a/mm/slab.c b/mm/slab.c
index 909975f..4db2029 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -2574,6 +2574,9 @@ static struct slab *alloc_slabmgmt(struc
 		/* Slab management obj is off-slab. */
 		slabp = kmem_cache_alloc_node(cachep->slabp_cache,
 					      local_flags & ~GFP_THISNODE, nodeid);
+		/* only scan the list member to avoid false negatives */
+		memleak_scan_area(slabp, offsetof(struct slab, list),
+				  sizeof(struct list_head));
 		if (!slabp)
 			return NULL;
 	} else {
@@ -3194,6 +3197,8 @@ static inline void *____cache_alloc(stru
 		STATS_INC_ALLOCMISS(cachep);
 		objp = cache_alloc_refill(cachep, flags);
 	}
+	/* avoid false negatives */
+	memleak_erase(&ac->entry[ac->avail]);
 	return objp;
 }
 
@@ -3222,6 +3227,7 @@ static __always_inline void *__cache_all
 	local_irq_restore(save_flags);
 	objp = cache_alloc_debugcheck_after(cachep, flags, objp,
 					    caller);
+	memleak_alloc(objp, obj_size(cachep), 1);
 	prefetchw(objp);
 	return objp;
 }
@@ -3492,6 +3498,7 @@ static inline void __cache_free(struct k
 	struct array_cache *ac = cpu_cache_get(cachep);
 
 	check_irq_off();
+	memleak_free(objp);
 	objp = cache_free_debugcheck(cachep, objp, __builtin_return_address(0));
 
 	if (cache_free_alien(cachep, objp))
@@ -3628,6 +3635,7 @@ __cache_alloc_node(struct kmem_cache *ca
 
 	local_irq_restore(save_flags);
 	ptr = cache_alloc_debugcheck_after(cachep, flags, ptr, caller);
+	memleak_alloc(ptr, obj_size(cachep), 1);
 
 	return ptr;
 }
@@ -3643,11 +3651,14 @@ static __always_inline void *
 __do_kmalloc_node(size_t size, gfp_t flags, int node, void *caller)
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
 
 #ifdef CONFIG_DEBUG_SLAB
@@ -3683,6 +3694,7 @@ static __always_inline void *__do_kmallo
 					  void *caller)
 {
 	struct kmem_cache *cachep;
+	void *ptr;
 
 	/* If you want to save a few bytes .text space: replace
 	 * __ with kmem_.
@@ -3692,7 +3704,10 @@ static __always_inline void *__do_kmallo
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
