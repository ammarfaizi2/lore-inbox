Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932285AbWE3OIV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932285AbWE3OIV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 10:08:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932280AbWE3OHz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 10:07:55 -0400
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:1943 "EHLO
	cam-admin0.cambridge.arm.com") by vger.kernel.org with ESMTP
	id S932273AbWE3OHZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 10:07:25 -0400
From: Catalin Marinas <catalin.marinas@arm.com>
Reply-To: catalin.marinas@gmail.com
Subject: [PATCH 2.6.17-rc5 3/7] Add the memory allocation/freeing hooks for kmemleak
Date: Tue, 30 May 2006 15:07:23 +0100
To: linux-kernel@vger.kernel.org
Message-Id: <20060530140722.21491.18229.stgit@localhost.localdomain>
In-Reply-To: <20060530135016.21491.34817.stgit@localhost.localdomain>
References: <20060530135016.21491.34817.stgit@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
X-OriginalArrivalTime: 30 May 2006 14:07:23.0712 (UTC) FILETIME=[5FACC400:01C683F2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Catalin Marinas <catalin.marinas@arm.com>

This patch adds the callbacks to memleak_(alloc|free) functions from
kmalloc/kree, kmem_cache_(alloc|free), vmalloc/vfree etc.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---

 drivers/base/platform.c |    1 +
 include/linux/slab.h    |    4 ++++
 kernel/module.c         |   18 ++++++++++++++++++
 mm/page_alloc.c         |    2 ++
 mm/slab.c               |   31 +++++++++++++++++++++++++++----
 mm/vmalloc.c            |   24 ++++++++++++++++++++++--
 6 files changed, 74 insertions(+), 6 deletions(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 83f5c59..824d447 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -166,6 +166,7 @@ struct platform_device *platform_device_
 	struct platform_object *pa;
 
 	pa = kzalloc(sizeof(struct platform_object) + strlen(name), GFP_KERNEL);
+	memleak_debug_resize(pa, sizeof(struct platform_object));
 	if (pa) {
 		strcpy(pa->name, name);
 		pa->pdev.name = pa->name;
diff --git a/include/linux/slab.h b/include/linux/slab.h
index 2d985d5..aa37216 100644
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
 
diff --git a/kernel/module.c b/kernel/module.c
index bbe0486..9b400dc 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -1413,6 +1413,9 @@ static struct module *load_module(void _
 		exportindex, modindex, obsparmindex, infoindex, gplindex,
 		crcindex, gplcrcindex, versindex, pcpuindex, gplfutureindex,
 		gplfuturecrcindex;
+#ifdef CONFIG_DEBUG_MEMLEAK
+	unsigned int dataindex, bssindex;
+#endif
 	struct module *mod;
 	long err = 0;
 	void *percpu = NULL, *ptr = NULL; /* Stops spurious gcc warning */
@@ -1510,6 +1513,10 @@ #ifdef CONFIG_KALLSYMS
 	sechdrs[symindex].sh_flags |= SHF_ALLOC;
 	sechdrs[strindex].sh_flags |= SHF_ALLOC;
 #endif
+#ifdef CONFIG_DEBUG_MEMLEAK
+	dataindex = find_sec(hdr, sechdrs, secstrings, ".data");
+	bssindex = find_sec(hdr, sechdrs, secstrings, ".bss");
+#endif
 
 	/* Check module struct version now, before we try to use module. */
 	if (!check_modstruct_version(sechdrs, versindex, mod)) {
@@ -1608,6 +1615,17 @@ #endif
 	/* Module has been moved. */
 	mod = (void *)sechdrs[modindex].sh_addr;
 
+	/* only scan the sections containing data */
+	memleak_debug_scan_area(mod->module_core,
+				(unsigned long)mod - (unsigned long)mod->module_core,
+				sizeof(struct module));
+	memleak_debug_scan_area(mod->module_core,
+				sechdrs[dataindex].sh_addr - (unsigned long)mod->module_core,
+				sechdrs[dataindex].sh_size);
+	memleak_debug_scan_area(mod->module_core,
+				sechdrs[bssindex].sh_addr - (unsigned long)mod->module_core,
+				sechdrs[bssindex].sh_size);
+
 	/* Now we've moved module, initialize linked lists, etc. */
 	module_unload_init(mod);
 
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 253a450..b33114e 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2800,6 +2800,8 @@ void *__init alloc_large_system_hash(con
 	if (_hash_mask)
 		*_hash_mask = (1 << log2qty) - 1;
 
+	memleak_debug_alloc(table, size, 1);
+
 	return table;
 }
 
diff --git a/mm/slab.c b/mm/slab.c
index d31a06b..cd30c85 100644
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
@@ -2042,9 +2044,11 @@ #endif
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
@@ -2879,6 +2883,7 @@ #endif
 		STATS_INC_ALLOCMISS(cachep);
 		objp = cache_alloc_refill(cachep, flags);
 	}
+	memleak_debug_erase(ac->entry[ac->avail]);
 	return objp;
 }
 
@@ -3144,7 +3149,11 @@ #endif
  */
 void *kmem_cache_alloc(struct kmem_cache *cachep, gfp_t flags)
 {
-	return __cache_alloc(cachep, flags, __builtin_return_address(0));
+	void *ptr = __cache_alloc(cachep, flags, __builtin_return_address(0));
+
+	memleak_debug_alloc(ptr, cachep->obj_size, 1);
+
+	return ptr;
 }
 EXPORT_SYMBOL(kmem_cache_alloc);
 
@@ -3159,6 +3168,9 @@ EXPORT_SYMBOL(kmem_cache_alloc);
 void *kmem_cache_zalloc(struct kmem_cache *cache, gfp_t flags)
 {
 	void *ret = __cache_alloc(cache, flags, __builtin_return_address(0));
+
+	memleak_debug_alloc(ret, cache->obj_size, 1);
+
 	if (ret)
 		memset(ret, 0, obj_size(cache));
 	return ret;
@@ -3280,6 +3292,7 @@ static __always_inline void *__do_kmallo
 					  void *caller)
 {
 	struct kmem_cache *cachep;
+	void *ptr;
 
 	/* If you want to save a few bytes .text space: replace
 	 * __ with kmem_.
@@ -3289,7 +3302,11 @@ static __always_inline void *__do_kmallo
 	cachep = __find_general_cachep(size, flags);
 	if (unlikely(cachep == NULL))
 		return NULL;
-	return __cache_alloc(cachep, flags, caller);
+	ptr = __cache_alloc(cachep, flags, caller);
+
+	memleak_debug_alloc(ptr, size, 1);
+
+	return ptr;
 }
 
 
@@ -3345,6 +3362,7 @@ void *__alloc_percpu(size_t size)
 		memset(pdata->ptrs[i], 0, size);
 	}
 
+	memleak_debug_not_leak(pdata);
 	/* Catch derefs w/o wrappers */
 	return (void *)(~(unsigned long)pdata);
 
@@ -3373,6 +3391,9 @@ void kmem_cache_free(struct kmem_cache *
 	unsigned long flags;
 
 	local_irq_save(flags);
+
+	memleak_debug_free(objp);
+
 	__cache_free(cachep, objp);
 	local_irq_restore(flags);
 }
@@ -3396,6 +3417,8 @@ void kfree(const void *objp)
 		return;
 	local_irq_save(flags);
 	kfree_debugcheck(objp);
+	memleak_debug_free(objp);
+
 	c = virt_to_cache(objp);
 	mutex_debug_check_no_locks_freed(objp, obj_size(c));
 	__cache_free(c, (void *)objp);
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index c0504f1..5197492 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -349,6 +349,9 @@ void __vunmap(void *addr, int deallocate
 void vfree(void *addr)
 {
 	BUG_ON(in_interrupt());
+
+	memleak_debug_free(addr);
+
 	__vunmap(addr, 1);
 }
 EXPORT_SYMBOL(vfree);
@@ -447,7 +450,14 @@ fail:
 
 void *__vmalloc_area(struct vm_struct *area, gfp_t gfp_mask, pgprot_t prot)
 {
-	return __vmalloc_area_node(area, gfp_mask, prot, -1);
+	void *addr = __vmalloc_area_node(area, gfp_mask, prot, -1);
+
+	/* this needs ref_count = 2 since vm_struct also contains a
+	   pointer to this address. The guard page is also subtracted
+	   from the size */
+	memleak_debug_alloc(addr, area->size - PAGE_SIZE, 2);
+
+	return addr;
 }
 
 /**
@@ -466,6 +476,10 @@ void *__vmalloc_node(unsigned long size,
 			int node)
 {
 	struct vm_struct *area;
+	void *addr;
+#ifdef CONFIG_DEBUG_MEMLEAK
+	unsigned long real_size = size;
+#endif
 
 	size = PAGE_ALIGN(size);
 	if (!size || (size >> PAGE_SHIFT) > num_physpages)
@@ -475,7 +489,13 @@ void *__vmalloc_node(unsigned long size,
 	if (!area)
 		return NULL;
 
-	return __vmalloc_area_node(area, gfp_mask, prot, node);
+	addr = __vmalloc_area_node(area, gfp_mask, prot, node);
+
+	/* this needs ref_count = 2 since the vm_struct also contains
+	   a pointer to this address */
+	memleak_debug_alloc(addr, real_size, 2);
+
+	return addr;
 }
 EXPORT_SYMBOL(__vmalloc_node);
 
