Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261697AbUKSXYw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261697AbUKSXYw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 18:24:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261684AbUKSXXL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 18:23:11 -0500
Received: from mta1.cl.cam.ac.uk ([128.232.0.15]:58822 "EHLO mta1.cl.cam.ac.uk")
	by vger.kernel.org with ESMTP id S261638AbUKSXU4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 18:20:56 -0500
To: Ian Pratt <Ian.Pratt@cl.cam.ac.uk>
cc: linux-kernel@vger.kernel.org, Steven.Hand@cl.cam.ac.uk,
       Christian.Limpach@cl.cam.ac.uk, Keir.Fraser@cl.cam.ac.uk,
       Ian.Pratt@cl.cam.ac.uk
Subject: [2/7] Xen VMM patch set : return code for arch_free_page
In-reply-to: Your message of "Fri, 19 Nov 2004 23:16:33 GMT."
             <E1CVHzW-0004XC-00@mta1.cl.cam.ac.uk> 
Date: Fri, 19 Nov 2004 23:20:54 +0000
From: Ian Pratt <Ian.Pratt@cl.cam.ac.uk>
Message-Id: <E1CVI3j-0004Zq-00@mta1.cl.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch adds a return value to the existing arch_free_page function
that indicates whether the normal free routine still has work to
do. The only architecture that currently uses arch_free_page is arch
'um'. arch xen needs this for 'foreign pages' - pages that don't
belong to the page allocator but are instead managed by custom
allocators. Such pages are marked using PG_arch_1.

Signed-off-by: ian.pratt@cl.cam.ac.uk

---


diff -Nurp pristine-linux-2.6.10-rc2/include/linux/gfp.h tmp-linux-2.6.10-rc2-xen.patch/include/linux/gfp.h
--- pristine-linux-2.6.10-rc2/include/linux/gfp.h	2004-11-15 01:27:15.000000000 +0000
+++ tmp-linux-2.6.10-rc2-xen.patch/include/linux/gfp.h	2004-11-18 19:58:13.000000000 +0000
@@ -74,8 +74,12 @@ struct vm_area_struct;
  * optimized to &contig_page_data at compile-time.
  */
 
+/*
+ * If arch_free_page returns non-zero then the generic free_page code can
+ * immediately bail: the arch-specific function has done all the work.
+ */
 #ifndef HAVE_ARCH_FREE_PAGE
-static inline void arch_free_page(struct page *page, int order) { }
+#define arch_free_page(page, order) 0
 #endif
 
 extern struct page *
diff -Nurp pristine-linux-2.6.10-rc2/mm/page_alloc.c tmp-linux-2.6.10-rc2-xen.patch/mm/page_alloc.c
--- pristine-linux-2.6.10-rc2/mm/page_alloc.c	2004-11-15 01:26:42.000000000 +0000
+++ tmp-linux-2.6.10-rc2-xen.patch/mm/page_alloc.c	2004-11-18 20:07:40.000000000 +0000
@@ -278,7 +278,8 @@ void __free_pages_ok(struct page *page, 
 	LIST_HEAD(list);
 	int i;
 
-	arch_free_page(page, order);
+	if (arch_free_page(page, order))
+		return;
 
 	mod_page_state(pgfree, 1 << order);
 	for (i = 0 ; i < (1 << order) ; ++i)
@@ -508,7 +509,8 @@ static void fastcall free_hot_cold_page(
 	struct per_cpu_pages *pcp;
 	unsigned long flags;
 
-	arch_free_page(page, 0);
+	if (arch_free_page(page, 0))
+		return;
 
 	kernel_map_pages(page, 1, 0);
 	inc_page_state(pgfree);
diff -Nurp pristine-linux-2.6.10-rc2/arch/um/kernel/physmem.c tmp-linux-2.6.10-rc2-xen.patch/arch/um/kernel/physmem.c
--- pristine-linux-2.6.10-rc2/arch/um/kernel/physmem.c	2004-11-19 20:04:30.000000000 +0000
+++ tmp-linux-2.6.10-rc2-xen.patch/arch/um/kernel/physmem.c	2004-11-19 20:05:33.000000000 +0000
@@ -225,7 +225,7 @@ EXPORT_SYMBOL(physmem_forget_descriptor)
 EXPORT_SYMBOL(physmem_remove_mapping);
 EXPORT_SYMBOL(physmem_subst_mapping);
 
-void arch_free_page(struct page *page, int order)
+void __arch_free_page(struct page *page, int order)
 {
 	void *virt;
 	int i;
diff -Nurp pristine-linux-2.6.10-rc2/include/asm-um/page.h tmp-linux-2.6.10-rc2-xen.patch/include/asm-um/page.h
--- pristine-linux-2.6.10-rc2/include/asm-um/page.h	2004-11-19 20:04:52.000000000 +0000
+++ tmp-linux-2.6.10-rc2-xen.patch/include/asm-um/page.h	2004-11-19 20:05:33.000000000 +0000
@@ -46,7 +46,8 @@ extern void *to_virt(unsigned long phys)
 extern struct page *arch_validate(struct page *page, int mask, int order);
 #define HAVE_ARCH_VALIDATE
 
-extern void arch_free_page(struct page *page, int order);
+extern void __arch_free_page(struct page *page, int order);
+#define arch_free_page(page, order) (__arch_free_page((page), (order)), 0)
 #define HAVE_ARCH_FREE_PAGE
 
 #endif

