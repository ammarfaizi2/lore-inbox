Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932537AbVISSGV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932537AbVISSGV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 14:06:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932539AbVISSGV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 14:06:21 -0400
Received: from [151.97.230.9] ([151.97.230.9]:3047 "EHLO ssc.unict.it")
	by vger.kernel.org with ESMTP id S932537AbVISSGU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 14:06:20 -0400
Message-Id: <20050919180321.615510000@zion.home.lan>
References: <20050919180231.358170000@zion.home.lan>
Date: Mon, 19 Sep 2005 20:02:32 +0200
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
To: stable@kernel.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net,
       Paolo Blaisorblade Giarrusso <blaisorblade@yahoo.it>
Subject: [patch 1/1] uml - Fix x86_64 page leak
Content-Disposition: inline; filename=uml-fix-x86-64-page-leak
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We were leaking pmd pages when 3_LEVEL_PGTABLES was enabled. This fixes that,
has been well tested and is included in mainline tree. Please include in -stable
as well.

Signed-off-by: Jeff Dike <jdike@addtoit.com>
Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Index: linux-2.6.13/arch/um/kernel/skas/include/mmu-skas.h
===================================================================
--- linux-2.6.13.orig/arch/um/kernel/skas/include/mmu-skas.h
+++ linux-2.6.13/arch/um/kernel/skas/include/mmu-skas.h
@@ -6,11 +6,15 @@
 #ifndef __SKAS_MMU_H
 #define __SKAS_MMU_H
 
+#include "linux/config.h"
 #include "mm_id.h"
 
 struct mmu_context_skas {
 	struct mm_id id;
         unsigned long last_page_table;
+#ifdef CONFIG_3_LEVEL_PGTABLES
+        unsigned long last_pmd;
+#endif
 };
 
 extern void switch_mm_skas(struct mm_id * mm_idp);
Index: linux-2.6.13/arch/um/kernel/skas/mmu.c
===================================================================
--- linux-2.6.13.orig/arch/um/kernel/skas/mmu.c
+++ linux-2.6.13/arch/um/kernel/skas/mmu.c
@@ -56,6 +56,9 @@ static int init_stub_pte(struct mm_struc
 	 */
 
         mm->context.skas.last_page_table = pmd_page_kernel(*pmd);
+#ifdef CONFIG_3_LEVEL_PGTABLES
+        mm->context.skas.last_pmd = (unsigned long) __va(pud_val(*pud));
+#endif
 
 	*pte = mk_pte(virt_to_page(kernel), __pgprot(_PAGE_PRESENT));
 	*pte = pte_mkexec(*pte);
@@ -140,6 +143,10 @@ void destroy_context_skas(struct mm_stru
 	else {
 		os_kill_ptraced_process(mmu->id.u.pid, 1);
 		free_page(mmu->id.stack);
-		free_page(mmu->last_page_table);
+		pte_free_kernel((pte_t *) mmu->last_page_table);
+		dec_page_state(nr_page_table_pages);
+#ifdef CONFIG_3_LEVEL_PGTABLES
+		pmd_free((pmd_t *) mmu->last_pmd);
+#endif
 	}
 }
Index: linux-2.6.13/include/asm-um/pgalloc.h
===================================================================
--- linux-2.6.13.orig/include/asm-um/pgalloc.h
+++ linux-2.6.13/include/asm-um/pgalloc.h
@@ -42,11 +42,13 @@ static inline void pte_free(struct page 
 #define __pte_free_tlb(tlb,pte) tlb_remove_page((tlb),(pte))
 
 #ifdef CONFIG_3_LEVEL_PGTABLES
-/*
- * In the 3-level case we free the pmds as part of the pgd.
- */
-#define pmd_free(x)			do { } while (0)
-#define __pmd_free_tlb(tlb,x)		do { } while (0)
+
+extern __inline__ void pmd_free(pmd_t *pmd)
+{
+	free_page((unsigned long)pmd);
+}
+
+#define __pmd_free_tlb(tlb,x)   tlb_remove_page((tlb),virt_to_page(x))
 #endif
 
 #define check_pgt_cache()	do { } while (0)
Index: linux-2.6.13/include/asm-um/pgtable-3level.h
===================================================================
--- linux-2.6.13.orig/include/asm-um/pgtable-3level.h
+++ linux-2.6.13/include/asm-um/pgtable-3level.h
@@ -98,14 +98,11 @@ static inline pmd_t *pmd_alloc_one(struc
         return pmd;
 }
 
-static inline void pmd_free(pmd_t *pmd){
-	free_page((unsigned long) pmd);
+extern inline void pud_clear (pud_t *pud)
+{
+        set_pud(pud, __pud(0));
 }
 
-#define __pmd_free_tlb(tlb,x)   do { } while (0)
-
-static inline void pud_clear (pud_t * pud) { }
-
 #define pud_page(pud) \
 	((struct page *) __va(pud_val(pud) & PAGE_MASK))
 

--
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade
