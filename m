Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932465AbWEMQGn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932465AbWEMQGn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 May 2006 12:06:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932476AbWEMQGc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 May 2006 12:06:32 -0400
Received: from mta08-winn.ispmail.ntl.com ([81.103.221.48]:64542 "EHLO
	mtaout02-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S932465AbWEMQGJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 May 2006 12:06:09 -0400
From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: [PATCH 2.6.17-rc4 3/6] Add the memory allocation/freeing hooks for kmemleak
Date: Sat, 13 May 2006 17:06:05 +0100
To: linux-kernel@vger.kernel.org
Message-Id: <20060513160605.8848.57802.stgit@localhost.localdomain>
In-Reply-To: <20060513155757.8848.11980.stgit@localhost.localdomain>
References: <20060513155757.8848.11980.stgit@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Catalin Marinas <catalin.marinas@arm.com>

This patch adds the callbacks to memleak_(alloc|free) functions from
kmalloc/kree, kmem_cache_(alloc|free), vmalloc/vfree etc.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---

 include/linux/slab.h |    4 ++++
 mm/page_alloc.c      |    3 +++
 mm/slab.c            |   30 ++++++++++++++++++++++++++----
 mm/vmalloc.c         |   20 ++++++++++++++++++--
 4 files changed, 51 insertions(+), 6 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index 3af03b1..4a573ff 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -89,6 +89,7 @@ #endif
 
 static inline void *kmalloc(size_t size, gfp_t flags)
 {
+#ifndef CONFIG_DEBUG_MEMLEAK
 	if (__builtin_constant_p(size)) {
 		int i = 0;
 #define CACHE(x) \
@@ -107,6 +108,7 @@ found:
 			malloc_sizes[i].cs_dmacachep :
 			malloc_sizes[i].cs_cachep, flags);
 	}
+#endif
 	return __kmalloc(size, flags);
 }
 
@@ -114,6 +116,7 @@ extern void *__kzalloc(size_t, gfp_t);
 
 static inline void *kzalloc(size_t size, gfp_t flags)
 {
+#ifndef CONFIG_DEBUG_MEMLEAK
 	if (__builtin_constant_p(size)) {
 		int i = 0;
 #define CACHE(x) \
@@ -132,6 +135,7 @@ found:
 			malloc_sizes[i].cs_dmacachep :
 			malloc_sizes[i].cs_cachep, flags);
 	}
+#endif
 	return __kzalloc(size, flags);
 }
 
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index ea77c99..d511586 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2788,6 +2788,9 @@ void *__init alloc_large_system_hash(con
 	if (_hash_mask)
 		*_hash_mask = (1 << log2qty) - 1;
 
+#ifdef CONFIG_DEBUG_MEMLEAK
+	memleak_alloc(table, size, 1);
+#endif
 	return table;
 }
 
diff --git a/mm/slab.c b/mm/slab.c
index c32af7e..5f4ebf4 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -434,6 +434,8 @@ #if DEBUG
 	 * variables contain the offset to the user object and its size.
 	 */
 	int obj_offset;
+#endif
+#if DEBUG || defined(CONFIG_DEBUG_MEMLEAK)
 	int obj_size;
 #endif
 };
@@ -672,7 +674,7 @@ static struct kmem_cache cache_cache = {
 	.shared = 1,
 	.buffer_size = sizeof(struct kmem_cache),
 	.name = "kmem_cache",
-#if DEBUG
+#if DEBUG || defined(CONFIG_DEBUG_MEMLEAK)
 	.obj_size = sizeof(struct kmem_cache),
 #endif
 };
@@ -2034,9 +2036,11 @@ #endif
 	if (!cachep)
 		goto oops;
 
-#if DEBUG
+#if DEBUG || defined(CONFIG_DEBUG_MEMLEAK)
 	cachep->obj_size = size;
+#endif
 
+#if DEBUG
 	if (flags & SLAB_RED_ZONE) {
 		/* redzoning only works with word aligned caches */
 		align = BYTES_PER_WORD;
@@ -3133,7 +3137,11 @@ #endif
  */
 void *kmem_cache_alloc(struct kmem_cache *cachep, gfp_t flags)
 {
-	return __cache_alloc(cachep, flags, __builtin_return_address(0));
+	void *ptr = __cache_alloc(cachep, flags, __builtin_return_address(0));
+#ifdef CONFIG_DEBUG_MEMLEAK
+	memleak_alloc(ptr, cachep->obj_size, 1);
+#endif
+	return ptr;
 }
 EXPORT_SYMBOL(kmem_cache_alloc);
 
@@ -3148,6 +3156,9 @@ EXPORT_SYMBOL(kmem_cache_alloc);
 void *kmem_cache_zalloc(struct kmem_cache *cache, gfp_t flags)
 {
 	void *ret = __cache_alloc(cache, flags, __builtin_return_address(0));
+#ifdef CONFIG_DEBUG_MEMLEAK
+	memleak_alloc(ret, cache->obj_size, 1);
+#endif
 	if (ret)
 		memset(ret, 0, obj_size(cache));
 	return ret;
@@ -3269,6 +3280,7 @@ static __always_inline void *__do_kmallo
 					  void *caller)
 {
 	struct kmem_cache *cachep;
+	void *ptr;
 
 	/* If you want to save a few bytes .text space: replace
 	 * __ with kmem_.
@@ -3278,7 +3290,11 @@ static __always_inline void *__do_kmallo
 	cachep = __find_general_cachep(size, flags);
 	if (unlikely(cachep == NULL))
 		return NULL;
-	return __cache_alloc(cachep, flags, caller);
+	ptr = __cache_alloc(cachep, flags, caller);
+#ifdef CONFIG_DEBUG_MEMLEAK
+	memleak_alloc(ptr, size, 1);
+#endif
+	return ptr;
 }
 
 
@@ -3362,6 +3378,9 @@ void kmem_cache_free(struct kmem_cache *
 	unsigned long flags;
 
 	local_irq_save(flags);
+#ifdef CONFIG_DEBUG_MEMLEAK
+	memleak_free(objp);
+#endif
 	__cache_free(cachep, objp);
 	local_irq_restore(flags);
 }
@@ -3385,6 +3404,9 @@ void kfree(const void *objp)
 		return;
 	local_irq_save(flags);
 	kfree_debugcheck(objp);
+#ifdef CONFIG_DEBUG_MEMLEAK
+	memleak_free(objp);
+#endif
 	c = virt_to_cache(objp);
 	mutex_debug_check_no_locks_freed(objp, obj_size(c));
 	__cache_free(c, (void *)objp);
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index c0504f1..ffd6154 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -349,6 +349,9 @@ void __vunmap(void *addr, int deallocate
 void vfree(void *addr)
 {
 	BUG_ON(in_interrupt());
+#ifdef CONFIG_DEBUG_MEMLEAK
+	memleak_free(addr);
+#endif
 	__vunmap(addr, 1);
 }
 EXPORT_SYMBOL(vfree);
@@ -447,7 +450,14 @@ fail:
 
 void *__vmalloc_area(struct vm_struct *area, gfp_t gfp_mask, pgprot_t prot)
 {
-	return __vmalloc_area_node(area, gfp_mask, prot, -1);
+	void *addr = __vmalloc_area_node(area, gfp_mask, prot, -1);
+#ifdef CONFIG_DEBUG_MEMLEAK
+	/* this needs ref_count = 2 since vm_struct also contains a
+	   pointer to this address. The guard page is also subtracted
+	   from the size */
+	memleak_alloc(addr, area->size - PAGE_SIZE, 2);
+#endif
+	return addr;
 }
 
 /**
@@ -481,7 +491,13 @@ EXPORT_SYMBOL(__vmalloc_node);
 
 void *__vmalloc(unsigned long size, gfp_t gfp_mask, pgprot_t prot)
 {
-	return __vmalloc_node(size, gfp_mask, prot, -1);
+	void *addr = __vmalloc_node(size, gfp_mask, prot, -1);
+#ifdef CONFIG_DEBUG_MEMLEAK
+	/* this needs ref_count = 2 since the vm_struct also contains
+	   a pointer to this address */
+	memleak_alloc(addr, size, 2);
+#endif
+	return addr;
 }
 EXPORT_SYMBOL(__vmalloc);
 
