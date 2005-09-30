Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932550AbVI3C15@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932550AbVI3C15 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 22:27:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932544AbVI3CXd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 22:23:33 -0400
Received: from smtp.osdl.org ([65.172.181.4]:5546 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932541AbVI3CXY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 22:23:24 -0400
Message-Id: <20050930022236.211896000@localhost.localdomain>
References: <20050930022016.640197000@localhost.localdomain>
Date: Thu, 29 Sep 2005 19:20:22 -0700
From: Chris Wright <chrisw@osdl.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       "Paolo Blaisorblade Giarrusso" <blaisorblade@yahoo.it>,
       jdike@addtoit.com, user-mode-linux-devel@lists.sourceforge.net,
       Chris Wright <chrisw@osdl.org>
Subject: [PATCH 06/10] [PATCH] uml - Fix x86_64 page leak
Content-Disposition: inline; filename=uml-fix-x86_64-page-leak.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

We were leaking pmd pages when 3_LEVEL_PGTABLES was enabled. This fixes that,
has been well tested and is included in mainline tree. Please include in -stable
as well.

Signed-off-by: Jeff Dike <jdike@addtoit.com>
Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
Signed-off-by: Chris Wright <chrisw@osdl.org>
---
 arch/um/kernel/skas/include/mmu-skas.h |    4 ++++
 arch/um/kernel/skas/mmu.c              |    9 ++++++++-
 include/asm-um/pgalloc.h               |   12 +++++++-----
 include/asm-um/pgtable-3level.h        |    9 +++------
 4 files changed, 22 insertions(+), 12 deletions(-)

Index: linux-2.6.13.y/arch/um/kernel/skas/include/mmu-skas.h
===================================================================
--- linux-2.6.13.y.orig/arch/um/kernel/skas/include/mmu-skas.h
+++ linux-2.6.13.y/arch/um/kernel/skas/include/mmu-skas.h
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
Index: linux-2.6.13.y/arch/um/kernel/skas/mmu.c
===================================================================
--- linux-2.6.13.y.orig/arch/um/kernel/skas/mmu.c
+++ linux-2.6.13.y/arch/um/kernel/skas/mmu.c
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
Index: linux-2.6.13.y/include/asm-um/pgalloc.h
===================================================================
--- linux-2.6.13.y.orig/include/asm-um/pgalloc.h
+++ linux-2.6.13.y/include/asm-um/pgalloc.h
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
Index: linux-2.6.13.y/include/asm-um/pgtable-3level.h
===================================================================
--- linux-2.6.13.y.orig/include/asm-um/pgtable-3level.h
+++ linux-2.6.13.y/include/asm-um/pgtable-3level.h
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
