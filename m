Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261698AbSI0OEW>; Fri, 27 Sep 2002 10:04:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261699AbSI0OEW>; Fri, 27 Sep 2002 10:04:22 -0400
Received: from zero.aec.at ([193.170.194.10]:18957 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id <S261698AbSI0OEU>;
	Fri, 27 Sep 2002 10:04:20 -0400
Date: Fri, 27 Sep 2002 16:09:30 +0200
From: Andi Kleen <ak@muc.de>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] Put modules into linear mapping
Message-ID: <20020927140930.GA12610@averell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Now that kksymoops is in this can be safely merged:

In some cases there is a benchmarkable difference (in the several percent
range) between a compiled in driver and a modular driver. The reason is 
the compiled in driver is mapped in 2/4MB pages in the direct mapping,
while modules are mapped wit 4K pages in the vmalloc area. The resulting
TLB misses can make that much difference.

This patch fixes it by just putting the modules into the linear mapping
if possible. This needs unfragmented memory, but modules tend to be loaded
at bootup when there is still plenty of this. When it fails it just falls
back to vmalloc.

It has one drawback in that it makes the load address of modules much more
random than they were previously: you have a bigger chance that 
the module is loaded somewhere else after reboot and then ksymoops wouldn't
be able to decode an module oops correctly anymore. With kksymoops this
shouldn't be a problem anymore, so it can be safely merged.

To avoid too much memory wastage it adds a new interface alloc_exact/free_exact
that allocates pages from the page allocator but doesn't round the area size
to the next power of two. 

Variants of this patch have run successfully for several years in the -aa
kernels and in the SuSE kernels.

Patch for 2.5.38. Please apply.

-Andi


--- linux-2.5.38-work/include/linux/gfp.h-MODULE	2002-09-25 00:59:27.000000000 +0200
+++ linux-2.5.38-work/include/linux/gfp.h	2002-09-27 15:30:59.000000000 +0200
@@ -85,4 +85,7 @@
 #define __free_page(page) __free_pages((page), 0)
 #define free_page(addr) free_pages((addr),0)
 
+extern void *alloc_exact(unsigned int size);
+extern void free_exact(void * addr, unsigned int size);
+
 #endif /* __LINUX_GFP_H */
--- linux-2.5.38-work/include/asm-i386/module.h-MODULE	2002-09-25 00:59:28.000000000 +0200
+++ linux-2.5.38-work/include/asm-i386/module.h	2002-09-27 15:30:35.000000000 +0200
@@ -3,9 +3,31 @@
 /*
  * This file contains the i386 architecture specific module code.
  */
+#include <linux/vmalloc.h>
+#include <linux/highmem.h>
+#include <asm/page.h>
+
+/* 
+ * Try to allocate in the linear large page mapping first to conserve
+ * TLB entries. 
+ */
+static inline void *module_map(unsigned long size) 
+{ 
+	void *p = alloc_exact(size); 
+	if (!p)
+		p = vmalloc(size); 
+	return p;
+} 
+
+static inline void module_unmap (struct module *mod)
+{
+	unsigned long mptr = (unsigned long)mod;
+	if (mptr >= VMALLOC_START && mptr+mod->size <= VMALLOC_END)
+		vfree(mod); 
+	else
+		free_exact(mod, mod->size);
+}
 
-#define module_map(x)		vmalloc(x)
-#define module_unmap(x)		vfree(x)
 #define module_arch_init(x)	(0)
 #define arch_init_modules(x)	do { } while (0)
 
--- linux-2.5.38-work/mm/page_alloc.c-MODULE	2002-09-25 00:59:29.000000000 +0200
+++ linux-2.5.38-work/mm/page_alloc.c	2002-09-27 15:34:59.000000000 +0200
@@ -464,6 +464,38 @@
 		__free_pages(virt_to_page(addr), order);
 	}
 }
+ 
+void *alloc_exact(unsigned int size)
+{ 
+	struct page *p, *w; 
+	int order = get_order(size); 
+
+	p = alloc_pages(GFP_KERNEL, order);
+	if (p) {
+		struct page *end = p + (1UL << order); 
+		for (w = p+1; w < end; ++w) 
+			set_page_count(w, 1); 
+		for (w = p + (size>>PAGE_SHIFT)+1; w < end; ++w) 	      
+			__free_pages(w, 0); 
+		return (void *) page_address(p); 
+	} 
+
+	return NULL;
+} 
+
+void free_exact(void * addr, unsigned int size)
+{ 
+	struct page * w; 
+	unsigned long mptr = (unsigned long) addr; 
+	int sz;
+
+	w = virt_to_page(addr); 
+	for (sz = size; sz > 0; sz -= PAGE_SIZE, ++w) { 
+		if (atomic_read(&w->count) != 1) 
+			BUG(); 
+		__free_pages(w, 0); 
+	} 	
+} 
 
 /*
  * Total amount of free (allocatable) RAM:
--- linux-2.5.38-work/kernel/ksyms.c-MODULE	2002-09-25 00:59:29.000000000 +0200
+++ linux-2.5.38-work/kernel/ksyms.c	2002-09-27 15:51:47.000000000 +0200
@@ -97,6 +97,8 @@
 EXPORT_SYMBOL(get_zeroed_page);
 EXPORT_SYMBOL(__page_cache_release);
 EXPORT_SYMBOL(__free_pages);
+EXPORT_SYMBOL(alloc_exact);
+EXPORT_SYMBOL(free_exact);
 EXPORT_SYMBOL(free_pages);
 EXPORT_SYMBOL(num_physpages);
 EXPORT_SYMBOL(kmem_find_general_cachep);
