Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263625AbUDPUL2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 16:11:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263672AbUDPUL2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 16:11:28 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:21349 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S263625AbUDPUHn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 16:07:43 -0400
Date: Fri, 16 Apr 2004 21:07:33 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, <rmk@arm.linux.org.uk>, <paulus@samba.org>,
       <anton@samba.org>
Subject: [PATCH] rmap 12 pgtable remove rmap
Message-ID: <Pine.LNX.4.44.0404162105100.13995-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

First of two patches against yesterday's rmap 11 or 2.6.5-mm6:
rmap 12 pgtable remove rmap

Remove the support for pte_chain rmap from page table initialization,
just continue to maintain nr_page_table_pages (but only for user page
tables - it also counted vmalloc page tables before, little need, and
I'm unsure if per-cpu stats are safe early enough on all arches).
mm/memory.c is the only core file affected.

But ppc and ppc64 have found the old rmap page table initialization
useful to support their ptep_test_and_clear_young: so transfer rmap's
initialization to them (even on kernel page tables? well, okay).

 arch/arm/mm/mm-armv.c       |    3 +--
 arch/ppc/mm/pgtable.c       |   28 +++++++++++++++++++---------
 arch/ppc64/mm/hugetlbpage.c |    3 +--
 arch/ppc64/mm/tlb.c         |    4 ++--
 include/asm-ppc64/pgalloc.h |   31 +++++++++++++++++++++++--------
 mm/memory.c                 |    6 ++----
 6 files changed, 48 insertions(+), 27 deletions(-)

--- rmap11/arch/arm/mm/mm-armv.c	2004-03-11 01:56:10.000000000 +0000
+++ rmap12/arch/arm/mm/mm-armv.c	2004-04-16 19:23:24.249297504 +0100
@@ -19,7 +19,6 @@
 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
 #include <asm/page.h>
-#include <asm/rmap.h>
 #include <asm/io.h>
 #include <asm/setup.h>
 #include <asm/tlbflush.h>
@@ -232,7 +231,7 @@ void free_pgd_slow(pgd_t *pgd)
 
 	pte = pmd_page(*pmd);
 	pmd_clear(pmd);
-	pgtable_remove_rmap(pte);
+	dec_page_state(nr_page_table_pages);
 	pte_free(pte);
 	pmd_free(pmd);
 free:
--- rmap11/arch/ppc/mm/pgtable.c	2004-04-15 09:01:54.635503656 +0100
+++ rmap12/arch/ppc/mm/pgtable.c	2004-04-16 19:23:24.251297200 +0100
@@ -86,9 +86,14 @@ pte_t *pte_alloc_one_kernel(struct mm_st
 	extern int mem_init_done;
 	extern void *early_get_page(void);
 
-	if (mem_init_done)
+	if (mem_init_done) {
 		pte = (pte_t *)__get_free_page(GFP_KERNEL|__GFP_REPEAT);
-	else
+		if (pte) {
+			struct page *ptepage = virt_to_page(pte);
+			ptepage->mapping = (void *) mm;
+			ptepage->index = address & PMD_MASK;
+		}
+	} else
 		pte = (pte_t *)early_get_page();
 	if (pte)
 		clear_page(pte);
@@ -97,7 +102,7 @@ pte_t *pte_alloc_one_kernel(struct mm_st
 
 struct page *pte_alloc_one(struct mm_struct *mm, unsigned long address)
 {
-	struct page *pte;
+	struct page *ptepage;
 
 #ifdef CONFIG_HIGHPTE
 	int flags = GFP_KERNEL | __GFP_HIGHMEM | __GFP_REPEAT;
@@ -105,10 +110,13 @@ struct page *pte_alloc_one(struct mm_str
 	int flags = GFP_KERNEL | __GFP_REPEAT;
 #endif
 
-	pte = alloc_pages(flags, 0);
-	if (pte)
-		clear_highpage(pte);
-	return pte;
+	ptepage = alloc_pages(flags, 0);
+	if (ptepage) {
+		ptepage->mapping = (void *) mm;
+		ptepage->index = address & PMD_MASK;
+		clear_highpage(ptepage);
+	}
+	return ptepage;
 }
 
 void pte_free_kernel(pte_t *pte)
@@ -116,15 +124,17 @@ void pte_free_kernel(pte_t *pte)
 #ifdef CONFIG_SMP
 	hash_page_sync();
 #endif
+	virt_to_page(pte)->mapping = NULL;
 	free_page((unsigned long)pte);
 }
 
-void pte_free(struct page *pte)
+void pte_free(struct page *ptepage)
 {
 #ifdef CONFIG_SMP
 	hash_page_sync();
 #endif
-	__free_page(pte);
+	ptepage->mapping = NULL;
+	__free_page(ptepage);
 }
 
 #ifndef CONFIG_44x
--- rmap11/arch/ppc64/mm/hugetlbpage.c	2004-04-15 09:01:54.582511712 +0100
+++ rmap12/arch/ppc64/mm/hugetlbpage.c	2004-04-16 19:23:24.252297048 +0100
@@ -25,7 +25,6 @@
 #include <asm/machdep.h>
 #include <asm/cputable.h>
 #include <asm/tlb.h>
-#include <asm/rmap.h>
 
 #include <linux/sysctl.h>
 
@@ -204,7 +203,7 @@ static int prepare_low_seg_for_htlb(stru
 		}
 		page = pmd_page(*pmd);
 		pmd_clear(pmd);
-		pgtable_remove_rmap(page);
+		dec_page_state(nr_page_table_pages);
 		pte_free_tlb(tlb, page);
 	}
 	tlb_finish_mmu(tlb, start, end);
--- rmap11/arch/ppc64/mm/tlb.c	2004-03-11 01:56:13.000000000 +0000
+++ rmap12/arch/ppc64/mm/tlb.c	2004-04-16 19:23:24.253296896 +0100
@@ -31,7 +31,6 @@
 #include <asm/tlb.h>
 #include <asm/hardirq.h>
 #include <linux/highmem.h>
-#include <asm/rmap.h>
 
 DEFINE_PER_CPU(struct ppc64_tlb_batch, ppc64_tlb_batch);
 
@@ -59,7 +58,8 @@ void hpte_update(pte_t *ptep, unsigned l
 
 	ptepage = virt_to_page(ptep);
 	mm = (struct mm_struct *) ptepage->mapping;
-	addr = ptep_to_address(ptep);
+	addr = ptepage->index +
+		(((unsigned long)ptep & ~PAGE_MASK) * PTRS_PER_PTE);
 
 	if (REGION_ID(addr) == USER_REGION_ID)
 		context = mm->context.id;
--- rmap11/include/asm-ppc64/pgalloc.h	2004-02-04 02:45:16.000000000 +0000
+++ rmap12/include/asm-ppc64/pgalloc.h	2004-04-16 19:23:24.254296744 +0100
@@ -48,28 +48,43 @@ pmd_free(pmd_t *pmd)
 	pmd_populate_kernel(mm, pmd, page_address(pte_page))
 
 static inline pte_t *
-pte_alloc_one_kernel(struct mm_struct *mm, unsigned long addr)
+pte_alloc_one_kernel(struct mm_struct *mm, unsigned long address)
 {
-	return kmem_cache_alloc(zero_cache, GFP_KERNEL|__GFP_REPEAT);
+	pte_t *pte;
+	pte = kmem_cache_alloc(zero_cache, GFP_KERNEL|__GFP_REPEAT);
+	if (pte) {
+		struct page *ptepage = virt_to_page(pte);
+		ptepage->mapping = (void *) mm;
+		ptepage->index = address & PMD_MASK;
+	}
+	return pte;
 }
 
 static inline struct page *
 pte_alloc_one(struct mm_struct *mm, unsigned long address)
 {
-	pte_t *pte = pte_alloc_one_kernel(mm, address);
-
-	if (pte)
-		return virt_to_page(pte);
-
+	pte_t *pte;
+	pte = kmem_cache_alloc(zero_cache, GFP_KERNEL|__GFP_REPEAT);
+	if (pte) {
+		struct page *ptepage = virt_to_page(pte);
+		ptepage->mapping = (void *) mm;
+		ptepage->index = address & PMD_MASK;
+		return ptepage;
+	}
 	return NULL;
 }
 		
 static inline void pte_free_kernel(pte_t *pte)
 {
+	virt_to_page(pte)->mapping = NULL;
 	kmem_cache_free(zero_cache, pte);
 }
 
-#define pte_free(pte_page)	pte_free_kernel(page_address(pte_page))
+static inline void pte_free(struct page *ptepage)
+{
+	ptepage->mapping = NULL;
+	kmem_cache_free(zero_cache, page_address(ptepage));
+}
 
 struct pte_freelist_batch
 {
--- rmap11/mm/memory.c	2004-04-15 20:24:18.454474856 +0100
+++ rmap12/mm/memory.c	2004-04-16 19:23:24.257296288 +0100
@@ -48,7 +48,6 @@
 #include <linux/init.h>
 
 #include <asm/pgalloc.h>
-#include <asm/rmap.h>
 #include <asm/uaccess.h>
 #include <asm/tlb.h>
 #include <asm/tlbflush.h>
@@ -105,7 +104,7 @@ static inline void free_one_pmd(struct m
 	}
 	page = pmd_page(*dir);
 	pmd_clear(dir);
-	pgtable_remove_rmap(page);
+	dec_page_state(nr_page_table_pages);
 	pte_free_tlb(tlb, page);
 }
 
@@ -164,7 +163,7 @@ pte_t fastcall * pte_alloc_map(struct mm
 			pte_free(new);
 			goto out;
 		}
-		pgtable_add_rmap(new, mm, address);
+		inc_page_state(nr_page_table_pages);
 		pmd_populate(mm, pmd, new);
 	}
 out:
@@ -190,7 +189,6 @@ pte_t fastcall * pte_alloc_kernel(struct
 			pte_free_kernel(new);
 			goto out;
 		}
-		pgtable_add_rmap(virt_to_page(new), mm, address);
 		pmd_populate_kernel(mm, pmd, new);
 	}
 out:

