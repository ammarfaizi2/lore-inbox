Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317946AbSHKH2l>; Sun, 11 Aug 2002 03:28:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317945AbSHKH16>; Sun, 11 Aug 2002 03:27:58 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:33542 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S317947AbSHKHZQ>;
	Sun, 11 Aug 2002 03:25:16 -0400
Message-ID: <3D56148E.D06B13F2@zip.com.au>
Date: Sun, 11 Aug 2002 00:38:54 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [patch 7/21] batched freeing of anonymous pages
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



The VMA teardown code is currently removing pages from the LRU
one-at-a-time.  And it is freeing those pages one-at-a-time.

The patch batches that up to sixteen-at-a-time by passing an on-stack
pagevec around and freeing all the pages whenever the pagevec fills up.




 include/asm-arm/tlb.h               |    2 +-
 include/asm-generic/tlb.h           |   12 +++++++++---
 include/asm-i386/pgalloc.h          |    2 +-
 include/asm-ia64/pgalloc.h          |    2 +-
 include/asm-m68k/motorola_pgalloc.h |    3 ++-
 include/asm-m68k/sun3_pgalloc.h     |    5 +++--
 include/asm-ppc/pgalloc.h           |    2 +-
 include/asm-ppc64/pgalloc.h         |    4 ++--
 include/asm-s390/pgalloc.h          |    2 +-
 include/asm-s390x/pgalloc.h         |    2 +-
 include/asm-sparc64/tlb.h           |    2 +-
 include/asm-x86_64/pgalloc.h        |    2 +-
 include/linux/pagevec.h             |    3 +++
 include/linux/swap.h                |    3 ++-
 mm/memory.c                         |   21 +++++++++++++++------
 mm/mmap.c                           |    1 +
 mm/page_alloc.c                     |   16 +++++++++++++---
 mm/swap_state.c                     |    6 ++++--
 18 files changed, 62 insertions(+), 28 deletions(-)

--- 2.5.31/mm/swap_state.c~anon-pagevec	Sun Aug 11 00:20:33 2002
+++ 2.5.31-akpm/mm/swap_state.c	Sun Aug 11 00:21:02 2002
@@ -14,6 +14,7 @@
 #include <linux/pagemap.h>
 #include <linux/smp_lock.h>
 #include <linux/buffer_head.h>	/* block_sync_page() */
+#include <linux/pagevec.h>
 
 #include <asm/pgtable.h>
 
@@ -295,7 +296,7 @@ int move_from_swap_cache(struct page *pa
  * this page if it is the last user of the page. Can not do a lock_page,
  * as we are holding the page_table_lock spinlock.
  */
-void free_page_and_swap_cache(struct page *page)
+void free_page_and_swap_cache(struct pagevec *pvec, struct page *page)
 {
 	/* 
 	 * If we are the only user, then try to free up the swap cache. 
@@ -309,7 +310,8 @@ void free_page_and_swap_cache(struct pag
 		remove_exclusive_swap_page(page);
 		unlock_page(page);
 	}
-	page_cache_release(page);
+	if (!pagevec_add(pvec, page))
+		__pagevec_release(pvec);
 }
 
 /*
--- 2.5.31/include/asm-generic/tlb.h~anon-pagevec	Sun Aug 11 00:20:33 2002
+++ 2.5.31-akpm/include/asm-generic/tlb.h	Sun Aug 11 00:20:33 2002
@@ -14,6 +14,7 @@
 #define _ASM_GENERIC__TLB_H
 
 #include <linux/config.h>
+#include <linux/pagevec.h>
 #include <asm/tlbflush.h>
 
 /*
@@ -70,9 +71,13 @@ static inline void tlb_flush_mmu(mmu_gat
 	nr = tlb->nr;
 	if (!tlb_fast_mode(tlb)) {
 		unsigned long i;
+		struct pagevec pvec;
+
 		tlb->nr = 0;
+		pagevec_init(&pvec);
 		for (i=0; i < nr; i++)
-			free_page_and_swap_cache(tlb->pages[i]);
+			free_page_and_swap_cache(&pvec, tlb->pages[i]);
+		pagevec_release(&pvec);
 	}
 }
 
@@ -101,10 +106,11 @@ static inline void tlb_finish_mmu(mmu_ga
  *	handling the additional races in SMP caused by other CPUs caching valid
  *	mappings in their TLBs.
  */
-static inline void tlb_remove_page(mmu_gather_t *tlb, struct page *page)
+static inline void
+tlb_remove_page(mmu_gather_t *tlb, struct pagevec *pvec, struct page *page)
 {
 	if (tlb_fast_mode(tlb)) {
-		free_page_and_swap_cache(page);
+		free_page_and_swap_cache(pvec, page);
 		return;
 	}
 	tlb->pages[tlb->nr++] = page;
--- 2.5.31/include/linux/swap.h~anon-pagevec	Sun Aug 11 00:20:33 2002
+++ 2.5.31-akpm/include/linux/swap.h	Sun Aug 11 00:21:02 2002
@@ -140,6 +140,7 @@ struct vm_area_struct;
 struct sysinfo;
 struct address_space;
 struct zone_t;
+struct pagevec;
 
 /* linux/mm/rmap.c */
 extern int FASTCALL(page_referenced(struct page *));
@@ -183,7 +184,7 @@ extern void delete_from_swap_cache(struc
 extern int move_to_swap_cache(struct page *page, swp_entry_t entry);
 extern int move_from_swap_cache(struct page *page, unsigned long index,
 		struct address_space *mapping);
-extern void free_page_and_swap_cache(struct page *page);
+extern void free_page_and_swap_cache(struct pagevec *pvec, struct page *page);
 extern struct page * lookup_swap_cache(swp_entry_t);
 extern struct page * read_swap_cache_async(swp_entry_t);
 
--- 2.5.31/mm/memory.c~anon-pagevec	Sun Aug 11 00:20:33 2002
+++ 2.5.31-akpm/mm/memory.c	Sun Aug 11 00:21:01 2002
@@ -44,6 +44,7 @@
 #include <linux/iobuf.h>
 #include <linux/highmem.h>
 #include <linux/pagemap.h>
+#include <linux/pagevec.h>
 
 #include <asm/pgalloc.h>
 #include <asm/rmap.h>
@@ -78,7 +79,8 @@ struct page *mem_map;
  * Note: this doesn't free the actual pages themselves. That
  * has been handled earlier when unmapping all the memory regions.
  */
-static inline void free_one_pmd(mmu_gather_t *tlb, pmd_t * dir)
+static inline void
+free_one_pmd(mmu_gather_t *tlb, struct pagevec *pvec, pmd_t * dir)
 {
 	struct page *page;
 
@@ -92,10 +94,11 @@ static inline void free_one_pmd(mmu_gath
 	page = pmd_page(*dir);
 	pmd_clear(dir);
 	pgtable_remove_rmap(page);
-	pte_free_tlb(tlb, page);
+	pte_free_tlb(tlb, pvec, page);
 }
 
-static inline void free_one_pgd(mmu_gather_t *tlb, pgd_t * dir)
+static inline void
+free_one_pgd(mmu_gather_t *tlb, struct pagevec *pvec, pgd_t *dir)
 {
 	int j;
 	pmd_t * pmd;
@@ -111,7 +114,7 @@ static inline void free_one_pgd(mmu_gath
 	pgd_clear(dir);
 	for (j = 0; j < PTRS_PER_PMD ; j++) {
 		prefetchw(pmd+j+(PREFETCH_STRIDE/16));
-		free_one_pmd(tlb, pmd+j);
+		free_one_pmd(tlb, pvec, pmd+j);
 	}
 	pmd_free_tlb(tlb, pmd);
 }
@@ -125,12 +128,15 @@ static inline void free_one_pgd(mmu_gath
 void clear_page_tables(mmu_gather_t *tlb, unsigned long first, int nr)
 {
 	pgd_t * page_dir = tlb->mm->pgd;
+	struct pagevec pvec;
 
+	pagevec_init(&pvec);
 	page_dir += first;
 	do {
-		free_one_pgd(tlb, page_dir);
+		free_one_pgd(tlb, &pvec, page_dir);
 		page_dir++;
 	} while (--nr);
+	pagevec_release(&pvec);
 }
 
 pte_t * pte_alloc_map(struct mm_struct *mm, pmd_t *pmd, unsigned long address)
@@ -322,6 +328,7 @@ static void zap_pte_range(mmu_gather_t *
 {
 	unsigned long offset;
 	pte_t *ptep;
+	struct pagevec pvec;
 
 	if (pmd_none(*pmd))
 		return;
@@ -335,6 +342,7 @@ static void zap_pte_range(mmu_gather_t *
 	if (offset + size > PMD_SIZE)
 		size = PMD_SIZE - offset;
 	size &= PAGE_MASK;
+	pagevec_init(&pvec);
 	for (offset=0; offset < size; ptep++, offset += PAGE_SIZE) {
 		pte_t pte = *ptep;
 		if (pte_none(pte))
@@ -351,7 +359,7 @@ static void zap_pte_range(mmu_gather_t *
 						set_page_dirty(page);
 					tlb->freed++;
 					page_remove_rmap(page, ptep);
-					tlb_remove_page(tlb, page);
+					tlb_remove_page(tlb, &pvec, page);
 				}
 			}
 		} else {
@@ -360,6 +368,7 @@ static void zap_pte_range(mmu_gather_t *
 		}
 	}
 	pte_unmap(ptep-1);
+	pagevec_release(&pvec);
 }
 
 static void zap_pmd_range(mmu_gather_t *tlb, pgd_t * dir, unsigned long address, unsigned long size)
--- 2.5.31/mm/page_alloc.c~anon-pagevec	Sun Aug 11 00:20:33 2002
+++ 2.5.31-akpm/mm/page_alloc.c	Sun Aug 11 00:21:02 2002
@@ -452,10 +452,20 @@ unsigned long get_zeroed_page(unsigned i
 
 void page_cache_release(struct page *page)
 {
+	/*
+	 * FIXME: this PageReserved test is really expensive
+	 */
 	if (!PageReserved(page) && put_page_testzero(page)) {
-		if (PageLRU(page))
-			lru_cache_del(page);
-		__free_pages_ok(page, 0);
+		/*
+		 * This path almost never happens - pages are normally freed
+		 * via pagevecs.
+		 */
+		struct pagevec pvec;
+
+		page_cache_get(page);
+		pvec.nr = 1;
+		pvec.pages[0] = page;
+		__pagevec_release(&pvec);
 	}
 }
 
--- 2.5.31/mm/mmap.c~anon-pagevec	Sun Aug 11 00:20:33 2002
+++ 2.5.31-akpm/mm/mmap.c	Sun Aug 11 00:20:33 2002
@@ -16,6 +16,7 @@
 #include <linux/file.h>
 #include <linux/fs.h>
 #include <linux/personality.h>
+#include <linux/pagevec.h>
 #include <linux/security.h>
 
 #include <asm/uaccess.h>
--- 2.5.31/include/asm-m68k/sun3_pgalloc.h~anon-pagevec	Sun Aug 11 00:20:33 2002
+++ 2.5.31-akpm/include/asm-m68k/sun3_pgalloc.h	Sun Aug 11 00:20:33 2002
@@ -31,9 +31,10 @@ static inline void pte_free(struct page 
         __free_page(page);
 }
 
-static inline void pte_free_tlb(mmu_gather_t *tlb, struct page *page)
+static inline void
+pte_free_tlb(mmu_gather_t *tlb, struct pagevec *pvec, struct page *page)
 {
-	tlb_remove_page(tlb, page);
+	tlb_remove_page(tlb, pvec, page);
 }
 
 static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm, 
--- 2.5.31/include/asm-i386/pgalloc.h~anon-pagevec	Sun Aug 11 00:20:33 2002
+++ 2.5.31-akpm/include/asm-i386/pgalloc.h	Sun Aug 11 00:20:33 2002
@@ -37,7 +37,7 @@ static inline void pte_free(struct page 
 }
 
 
-#define pte_free_tlb(tlb,pte) tlb_remove_page((tlb),(pte))
+#define pte_free_tlb(tlb,pvec,pte) tlb_remove_page((tlb),(pvec),(pte))
 
 /*
  * allocating and freeing a pmd is trivial: the 1-entry pmd is
--- 2.5.31/include/asm-ia64/pgalloc.h~anon-pagevec	Sun Aug 11 00:20:33 2002
+++ 2.5.31-akpm/include/asm-ia64/pgalloc.h	Sun Aug 11 00:20:33 2002
@@ -153,7 +153,7 @@ pte_free_kernel (pte_t *pte)
 	free_page((unsigned long) pte);
 }
 
-#define pte_free_tlb(tlb, pte)	tlb_remove_page((tlb), (pte))
+#define pte_free_tlb(tlb, pvec, pte)	tlb_remove_page((tlb), (pvec), (pte))
 
 extern void check_pgt_cache (void);
 
--- 2.5.31/include/asm-s390/pgalloc.h~anon-pagevec	Sun Aug 11 00:20:33 2002
+++ 2.5.31-akpm/include/asm-s390/pgalloc.h	Sun Aug 11 00:20:33 2002
@@ -107,7 +107,7 @@ static inline void pte_free(struct page 
         __free_page(pte);
 }
 
-#define pte_free_tlb(tlb,pte) tlb_remove_page((tlb),(pte))
+#define pte_free_tlb(tlb,pvec,pte) tlb_remove_page((tlb),(pvec),(pte))
 
 /*
  * This establishes kernel virtual mappings (e.g., as a result of a
--- 2.5.31/include/asm-s390x/pgalloc.h~anon-pagevec	Sun Aug 11 00:20:33 2002
+++ 2.5.31-akpm/include/asm-s390x/pgalloc.h	Sun Aug 11 00:20:33 2002
@@ -123,7 +123,7 @@ static inline void pte_free(struct page 
         __free_page(pte);
 }
 
-#define pte_free_tlb(tlb,pte) tlb_remove_page((tlb),(pte))
+#define pte_free_tlb(tlb,pvec,pte) tlb_remove_page((tlb),(pvec),(pte))
 
 /*
  * This establishes kernel virtual mappings (e.g., as a result of a
--- 2.5.31/include/asm-x86_64/pgalloc.h~anon-pagevec	Sun Aug 11 00:20:33 2002
+++ 2.5.31-akpm/include/asm-x86_64/pgalloc.h	Sun Aug 11 00:20:33 2002
@@ -75,7 +75,7 @@ extern inline void pte_free(struct page 
 	__free_page(pte);
 } 
 
-#define pte_free_tlb(tlb,pte) tlb_remove_page((tlb),(pte))
+#define pte_free_tlb(tlb,pvec,pte) tlb_remove_page((tlb),(pvec),(pte))
 #define pmd_free_tlb(tlb,x)   do { } while (0)
 
 #endif /* _X86_64_PGALLOC_H */
--- 2.5.31/include/asm-arm/tlb.h~anon-pagevec	Sun Aug 11 00:20:33 2002
+++ 2.5.31-akpm/include/asm-arm/tlb.h	Sun Aug 11 00:20:33 2002
@@ -16,6 +16,6 @@
 #include <asm-generic/tlb.h>
 
 #define pmd_free_tlb(tlb, pmd)	pmd_free(pmd)
-#define pte_free_tlb(tlb, pte)	pte_free(pte)
+#define pte_free_tlb(tlb, pvec, pte)	pte_free(pte)
 
 #endif
--- 2.5.31/include/asm-m68k/motorola_pgalloc.h~anon-pagevec	Sun Aug 11 00:20:33 2002
+++ 2.5.31-akpm/include/asm-m68k/motorola_pgalloc.h	Sun Aug 11 00:20:33 2002
@@ -55,7 +55,8 @@ static inline void pte_free(struct page 
 	__free_page(page);
 }
 
-static inline void pte_free_tlb(mmu_gather_t *tlb, struct page *page)
+static inline void
+pte_free_tlb(mmu_gather_t *tlb, struct pagevec *pvec, struct page *page)
 {
 	cache_page(kmap(page));
 	kunmap(page);
--- 2.5.31/include/asm-ppc/pgalloc.h~anon-pagevec	Sun Aug 11 00:20:33 2002
+++ 2.5.31-akpm/include/asm-ppc/pgalloc.h	Sun Aug 11 00:20:33 2002
@@ -33,7 +33,7 @@ extern struct page *pte_alloc_one(struct
 extern void pte_free_kernel(pte_t *pte);
 extern void pte_free(struct page *pte);
 
-#define pte_free_tlb(tlb, pte)	pte_free((pte))
+#define pte_free_tlb(tlb, pvec, pte)	pte_free((pte))
 
 #define check_pgt_cache()	do { } while (0)
 
--- 2.5.31/include/asm-sparc64/tlb.h~anon-pagevec	Sun Aug 11 00:20:33 2002
+++ 2.5.31-akpm/include/asm-sparc64/tlb.h	Sun Aug 11 00:20:33 2002
@@ -22,6 +22,6 @@ do {	if (!(tlb)->fullmm)	\
 #include <asm-generic/tlb.h>
 
 #define pmd_free_tlb(tlb, pmd)	pmd_free(pmd)
-#define pte_free_tlb(tlb, pte)	pte_free(pte)
+#define pte_free_tlb(tlb, pvec, pte)	pte_free(pte)
 
 #endif /* _SPARC64_TLB_H */
--- 2.5.31/include/asm-ppc64/pgalloc.h~anon-pagevec	Sun Aug 11 00:20:33 2002
+++ 2.5.31-akpm/include/asm-ppc64/pgalloc.h	Sun Aug 11 00:20:33 2002
@@ -87,8 +87,8 @@ pte_free_kernel(pte_t *pte)
 	free_page((unsigned long)pte);
 }
 
-#define pte_free(pte_page)	pte_free_kernel(page_address(pte_page))
-#define pte_free_tlb(tlb, pte)	pte_free(pte)
+#define pte_free(pte_page)		pte_free_kernel(page_address(pte_page))
+#define pte_free_tlb(tlb, pvec, pte)	pte_free(pte)
 
 #define check_pgt_cache()	do { } while (0)
 
--- 2.5.31/include/linux/pagevec.h~anon-pagevec	Sun Aug 11 00:20:33 2002
+++ 2.5.31-akpm/include/linux/pagevec.h	Sun Aug 11 00:21:01 2002
@@ -1,3 +1,5 @@
+#ifndef _LINUX_PAGEVEC_H
+#define _LINUX_PAGEVEC_H
 /*
  * include/linux/pagevec.h
  *
@@ -74,3 +76,4 @@ static inline void pagevec_lru_del(struc
 	if (pagevec_count(pvec))
 		__pagevec_lru_del(pvec);
 }
+#endif _LINUX_PAGEVEC_H

.
