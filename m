Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265544AbSJSDyM>; Fri, 18 Oct 2002 23:54:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265545AbSJSDyM>; Fri, 18 Oct 2002 23:54:12 -0400
Received: from zero.aec.at ([193.170.194.10]:59909 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id <S265544AbSJSDyK>;
	Fri, 18 Oct 2002 23:54:10 -0400
Date: Sat, 19 Oct 2002 06:00:00 +0200
From: Andi Kleen <ak@muc.de>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Use direct mapping for modules on i386
Message-ID: <20021019040000.GA21880@averell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


In some workloads there is a benchmarkable difference between drivers 
compiled into the kernel and drivers which are loaded modular.
The reason is TLB thrashing: modules are not in the direct mapping
which uses large pages, but in the 4K mapped vmalloc area. 
When someone else uses all your TLB entries all the time then
modules suffer worse from TLB misses than other code.

This patch addresses this problem by loading the module into 
the direct mapping if possible. Only when that fails it falls back
to vmalloc.

There is one drawback: module load addresses are somewhat less predictable
with this. vmalloc tends to always put them on the same kernel
address. When you load your module at random times and you get a oops
and you run ksymoops after rebooting then there is a higher probability
that ksymoops cannot resolve the module symbols because /proc/ksyms
has changed. But now that 2.5 has CONFIG_KALLSYMS this shouldn't be
a problem anymore. In practice it wasn't a big problem even withotu
CONFIG_KALLSYMS, because most modules are loaded at boot time
and tend to end up at predictable addresses.

Variants of this patch have been running for years in -aa/SuSE kernels.

Should address (nearly) all criticism that earlier versions of this
patch yielded.

One caveat: some old AMD CPUs (K6) only have 4 TLB entries for large pages,
but many more for 4K pages.  If the modules are sufficiently spread out
over memory then this may lead to more TLB thrashing for them.
I would welcome benchmark results for these to see if it's worth disabling
when the kernel is compiled for K6. Please contact me for the benchmark
methology. It should be a win on all modern x86.  I still believe 
it's fit for merging.

Patch for 2.5.43. Please consider merging.

-Andi

--- linux-2.5.43-work/include/linux/gfp.h-MODMAP	2002-10-12 14:46:18.000000000 +0200
+++ linux-2.5.43-work/include/linux/gfp.h	2002-10-19 05:39:56.000000000 +0200
@@ -86,4 +86,7 @@
 #define __free_page(page) __free_pages((page), 0)
 #define free_page(addr) free_pages((addr),0)
 
+extern void *alloc_exact(unsigned int size, int gfp);
+extern void free_exact(void * addr, unsigned int size);
+
 #endif /* __LINUX_GFP_H */
--- linux-2.5.43-work/include/asm-i386/module.h-MODMAP	2002-09-25 00:59:28.000000000 +0200
+++ linux-2.5.43-work/include/asm-i386/module.h	2002-10-19 05:40:21.000000000 +0200
@@ -3,9 +3,32 @@
 /*
  * This file contains the i386 architecture specific module code.
  */
+#include <linux/vmalloc.h>
+#include <linux/highmem.h>
+#include <asm/page.h>
+#include <linux/gfp.h>
+
+/* 
+ * Try to allocate in the linear large page mapping first to conserve
+ * TLB entries. 
+ */
+static inline void *module_map(unsigned long size) 
+{ 
+	void *p = alloc_exact(size, GFP_KERNEL); 
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
 
--- linux-2.5.43-work/kernel/ksyms.c-MODMAP	2002-10-16 05:55:51.000000000 +0200
+++ linux-2.5.43-work/kernel/ksyms.c	2002-10-18 05:34:47.000000000 +0200
@@ -93,6 +93,8 @@
 EXPORT_SYMBOL(get_zeroed_page);
 EXPORT_SYMBOL(__page_cache_release);
 EXPORT_SYMBOL(__free_pages);
+EXPORT_SYMBOL(alloc_exact);
+EXPORT_SYMBOL(free_exact);
 EXPORT_SYMBOL(free_pages);
 EXPORT_SYMBOL(num_physpages);
 EXPORT_SYMBOL(kmem_find_general_cachep);
--- linux-2.5.43-work/mm/page_alloc.c-MODMAP	2002-10-16 05:55:51.000000000 +0200
+++ linux-2.5.43-work/mm/page_alloc.c	2002-10-19 05:39:50.000000000 +0200
@@ -478,6 +478,38 @@
 		__free_pages(virt_to_page(addr), order);
 	}
 }
+ 
+void *alloc_exact(unsigned int size, int gfp)
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
