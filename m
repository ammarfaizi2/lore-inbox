Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932218AbVIJSE0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932218AbVIJSE0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 14:04:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932222AbVIJSEZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 14:04:25 -0400
Received: from ppp-62-11-72-160.dialup.tiscali.it ([62.11.72.160]:30888 "EHLO
	zion.home.lan") by vger.kernel.org with ESMTP id S932218AbVIJSEY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 14:04:24 -0400
Message-Id: <20050910174628.539817000@zion.home.lan>
References: <20050910174452.907256000@zion.home.lan>
Date: Sat, 10 Sep 2005 19:44:56 +0200
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>,
       Paolo Blaisorblade Giarrusso <blaisorblade@yahoo.it>
Cc: LKML <linux-kernel@vger.kernel.org>
Cc: user-mode-linux-devel@lists.sourceforge.net
Subject: [patch 4/7] uml: inline mk_pte and various friends
Content-Disposition: inline; filename=uml-inline-mk_pte
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Turns out that, for UML, a *lot* of VM-related trivial functions are not
inlined but rather normal functions.

In other sections of UML code, this is justified by having files which
interact with the host and cannot therefore include kernel headers, but in
this case there's no such justification.

I've had to turn many of them to macros because of missing declarations. While
doing this, I've decided to reuse some already existing macros.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/include/mem.h    |   12 +++++++++++-
 arch/um/kernel/ksyms.c   |    5 -----
 arch/um/kernel/physmem.c |   35 -----------------------------------
 include/asm-um/page.h    |    3 +--
 include/asm-um/pgtable.h |   16 +++++++++++-----
 5 files changed, 23 insertions(+), 48 deletions(-)

diff --git a/arch/um/include/mem.h b/arch/um/include/mem.h
--- a/arch/um/include/mem.h
+++ b/arch/um/include/mem.h
@@ -13,7 +13,17 @@ extern int physmem_subst_mapping(void *v
 extern int is_remapped(void *virt);
 extern int physmem_remove_mapping(void *virt);
 extern void physmem_forget_descriptor(int fd);
-extern unsigned long to_phys(void *virt);
+
+extern unsigned long uml_physmem;
+static inline unsigned long to_phys(void *virt)
+{
+	return(((unsigned long) virt) - uml_physmem);
+}
+
+static inline void *to_virt(unsigned long phys)
+{
+	return((void *) uml_physmem + phys);
+}
 
 #endif
 
diff --git a/arch/um/kernel/ksyms.c b/arch/um/kernel/ksyms.c
--- a/arch/um/kernel/ksyms.c
+++ b/arch/um/kernel/ksyms.c
@@ -34,14 +34,9 @@ EXPORT_SYMBOL(host_task_size);
 EXPORT_SYMBOL(arch_validate);
 EXPORT_SYMBOL(get_kmem_end);
 
-EXPORT_SYMBOL(page_to_phys);
-EXPORT_SYMBOL(phys_to_page);
 EXPORT_SYMBOL(high_physmem);
 EXPORT_SYMBOL(empty_zero_page);
 EXPORT_SYMBOL(um_virt_to_phys);
-EXPORT_SYMBOL(__virt_to_page);
-EXPORT_SYMBOL(to_phys);
-EXPORT_SYMBOL(to_virt);
 EXPORT_SYMBOL(mode_tt);
 EXPORT_SYMBOL(handle_page_fault);
 EXPORT_SYMBOL(find_iomem);
diff --git a/arch/um/kernel/physmem.c b/arch/um/kernel/physmem.c
--- a/arch/um/kernel/physmem.c
+++ b/arch/um/kernel/physmem.c
@@ -248,16 +248,6 @@ unsigned long high_physmem;
 
 extern unsigned long physmem_size;
 
-void *to_virt(unsigned long phys)
-{
-	return((void *) uml_physmem + phys);
-}
-
-unsigned long to_phys(void *virt)
-{
-	return(((unsigned long) virt) - uml_physmem);
-}
-
 int init_maps(unsigned long physmem, unsigned long iomem, unsigned long highmem)
 {
 	struct page *p, *map;
@@ -298,31 +288,6 @@ int init_maps(unsigned long physmem, uns
 	return(0);
 }
 
-struct page *phys_to_page(const unsigned long phys)
-{
-	return(&mem_map[phys >> PAGE_SHIFT]);
-}
-
-struct page *__virt_to_page(const unsigned long virt)
-{
-	return(&mem_map[__pa(virt) >> PAGE_SHIFT]);
-}
-
-phys_t page_to_phys(struct page *page)
-{
-	return((page - mem_map) << PAGE_SHIFT);
-}
-
-pte_t mk_pte(struct page *page, pgprot_t pgprot)
-{
-	pte_t pte;
-
-	pte_set_val(pte, page_to_phys(page), pgprot);
-	if(pte_present(pte))
-		pte_mknewprot(pte_mknewpage(pte));
-	return(pte);
-}
-
 /* Changed during early boot */
 static unsigned long kmem_top = 0;
 
diff --git a/include/asm-um/page.h b/include/asm-um/page.h
--- a/include/asm-um/page.h
+++ b/include/asm-um/page.h
@@ -96,8 +96,7 @@ extern unsigned long uml_physmem;
 
 #define __va_space (8*1024*1024)
 
-extern unsigned long to_phys(void *virt);
-extern void *to_virt(unsigned long phys);
+#include "mem.h"
 
 /* Cast to unsigned long before casting to void * to avoid a warning from
  * mmap_kmem about cutting a long long down to a void *.  Not sure that
diff --git a/include/asm-um/pgtable.h b/include/asm-um/pgtable.h
--- a/include/asm-um/pgtable.h
+++ b/include/asm-um/pgtable.h
@@ -326,14 +326,22 @@ static inline void set_pte(pte_t *pteptr
 }
 #define set_pte_at(mm,addr,ptep,pteval) set_pte(ptep,pteval)
 
-extern phys_t page_to_phys(struct page *page);
-
 /*
  * Conversion functions: convert a page and protection to a page entry,
  * and a page entry and page directory to the page they refer to.
  */
 
-extern pte_t mk_pte(struct page *page, pgprot_t pgprot);
+#define phys_to_page(phys) pfn_to_page(phys_to_pfn(phys))
+#define __virt_to_page(virt) phys_to_page(__pa(virt))
+#define page_to_phys(page) pfn_to_phys(page_to_pfn(page))
+
+#define mk_pte(page, pgprot) \
+	({ pte_t pte;					\
+							\
+	pte_set_val(pte, page_to_phys(page), (pgprot));	\
+	if (pte_present(pte))				\
+		pte_mknewprot(pte_mknewpage(pte));	\
+	pte;})
 
 static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 {
@@ -410,8 +418,6 @@ static inline pte_t pte_modify(pte_t pte
 #endif
 #endif
 
-extern struct page *phys_to_page(const unsigned long phys);
-extern struct page *__virt_to_page(const unsigned long virt);
 #define virt_to_page(addr) __virt_to_page((const unsigned long) addr)
 
 /*

--
