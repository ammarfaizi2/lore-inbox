Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262575AbUKRAnF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262575AbUKRAnF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 19:43:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262403AbUKRAmM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 19:42:12 -0500
Received: from mta1.cl.cam.ac.uk ([128.232.0.15]:16548 "EHLO mta1.cl.cam.ac.uk")
	by vger.kernel.org with ESMTP id S262575AbUKQXtC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 18:49:02 -0500
To: linux-kernel@vger.kernel.org
cc: Ian.Pratt@cl.cam.ac.uk, akpm@osdl.org, Keir.Fraser@cl.cam.ac.uk,
       Christian.Limpach@cl.cam.ac.uk
Subject: [patch 2] Xen core patch : arch_free_page return value
Date: Wed, 17 Nov 2004 23:48:57 +0000
From: Ian Pratt <Ian.Pratt@cl.cam.ac.uk>
Message-Id: <E1CUZXm-00053v-00@mta1.cl.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch adds a return value to the existing arch_free_page function
that indicates whether the normal free routine still has work to
do. The only architecture that currently uses arch_free_page is arch
'um'. arch-xen needs this for 'foreign pages' - pages that don't
belong to the page allocator but are instead managed by custom
allocators. Unlike PG_Reserved, we need the ref counting, but just
need to control how the page is finally freed.

Signed-off-by: ian.pratt@cl.cam.ac.uk

---

diff -ur linux-2.6.9/arch/um/kernel/physmem.c linux-2.6.9-new/arch/um/kernel/physmem.c
--- linux-2.6.9/arch/um/kernel/physmem.c	2004-10-18 22:54:37.000000000 +0100
+++ linux-2.6.9-new/arch/um/kernel/physmem.c	2004-11-16 17:37:32.919951978 +0000
@@ -225,7 +225,7 @@
 EXPORT_SYMBOL(physmem_remove_mapping);
 EXPORT_SYMBOL(physmem_subst_mapping);
 
-void arch_free_page(struct page *page, int order)
+int arch_free_page(struct page *page, int order)
 {
 	void *virt;
 	int i;
@@ -234,6 +234,8 @@
 		virt = __va(page_to_phys(page + i));
 		physmem_remove_mapping(virt);
 	}
+
+	return 0;
 }
 
 int is_remapped(void *virt)
diff -ur linux-2.6.9/include/asm-um/page.h linux-2.6.9-new/include/asm-um/page.h
--- linux-2.6.9/include/asm-um/page.h	2004-10-18 22:55:36.000000000 +0100
+++ linux-2.6.9-new/include/asm-um/page.h	2004-11-16 17:37:55.471701151 +0000
@@ -46,7 +46,7 @@
 extern struct page *arch_validate(struct page *page, int mask, int order);
 #define HAVE_ARCH_VALIDATE
 
-extern void arch_free_page(struct page *page, int order);
+extern int arch_free_page(struct page *page, int order);
 #define HAVE_ARCH_FREE_PAGE
 
 #endif
diff -ur linux-2.6.9/include/linux/gfp.h linux-2.6.9-new/include/linux/gfp.h
--- linux-2.6.9/include/linux/gfp.h	2004-10-18 22:53:44.000000000 +0100
+++ linux-2.6.9-new/include/linux/gfp.h	2004-11-16 17:41:25.825723812 +0000
@@ -74,8 +74,16 @@
  * optimized to &contig_page_data at compile-time.
  */
 
+/*
+ * If arch_free_page returns non-zero then the generic free_page code can
+ * immediately bail: the arch-specific function has done all the work.
+ */
 #ifndef HAVE_ARCH_FREE_PAGE
-static inline void arch_free_page(struct page *page, int order) { }
+static inline int arch_free_page(struct page *page, int order)
+{
+	/* Generic free_page must do the work. */
+	return 0;
+}
 #endif
 
 extern struct page *
diff -ur linux-2.6.9/mm/page_alloc.c linux-2.6.9-new/mm/page_alloc.c
--- linux-2.6.9/mm/page_alloc.c	2004-10-18 22:53:11.000000000 +0100
+++ linux-2.6.9-new/mm/page_alloc.c	2004-11-16 17:42:23.793227175 +0000
@@ -275,7 +275,8 @@
 	LIST_HEAD(list);
 	int i;
 
-	arch_free_page(page, order);
+	if (arch_free_page(page, order))
+		return;
 
 	mod_page_state(pgfree, 1 << order);
 	for (i = 0 ; i < (1 << order) ; ++i)
@@ -505,7 +506,8 @@
 	struct per_cpu_pages *pcp;
 	unsigned long flags;
 
-	arch_free_page(page, 0);
+	if (arch_free_page(page, 0))
+		return;
 
 	kernel_map_pages(page, 1, 0);
 	inc_page_state(pgfree);


