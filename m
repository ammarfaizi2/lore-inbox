Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319289AbSHNT3u>; Wed, 14 Aug 2002 15:29:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319290AbSHNT3u>; Wed, 14 Aug 2002 15:29:50 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:42507 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S319289AbSHNT3p>;
	Wed, 14 Aug 2002 15:29:45 -0400
Message-ID: <3D5AB005.8D067BCD@zip.com.au>
Date: Wed, 14 Aug 2002 12:31:17 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>,
       "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: [patch] reduce the number of tlb invalidations
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



It has been noticed that across a kernel build many calls to
tlb_flush_mmu() do not have anything to flush, apparently because glibc
is mmapping a file over a previously-mapped region which has no
faulted-in ptes.

This patch detects this case and optimises away a little over one third
of the tlb invalidations.

The functions which potentially cause an invalidate are
tlb_remove_tlb_entry(), pte_free_tlb() and pmd_free_tlb().  These have
been front-ended in asm-generic/tlb.h and the per-arch versions now
have leading double-underscores.  The generic versions tag the
mmu_gather_t as needing a flush and then call the arch-specific
version.

tlb_flush_mmu() looks at tlb->need_flush and if it sees that no real
activity has happened, the invalidation is avoided.

The success rate is displayed in /proc/meminfo for the while.  This
should be removed later.



 fs/proc/proc_misc.c                 |   19 +++++++++++++++---
 include/asm-alpha/tlb.h             |    6 ++---
 include/asm-arm/tlb.h               |    6 ++---
 include/asm-generic/tlb.h           |   37 +++++++++++++++++++++++++++++++++++-
 include/asm-i386/pgalloc.h          |    4 +--
 include/asm-i386/tlb.h              |    2 -
 include/asm-ia64/pgalloc.h          |    4 +--
 include/asm-ia64/tlb.h              |    2 -
 include/asm-m68k/motorola_pgalloc.h |    4 +--
 include/asm-m68k/sun3_pgalloc.h     |    4 +--
 include/asm-m68k/tlb.h              |    2 -
 include/asm-ppc/pgalloc.h           |    4 +--
 include/asm-ppc/tlb.h               |    4 +--
 include/asm-ppc64/pgalloc.h         |    4 +--
 include/asm-ppc64/tlb.h             |    2 -
 include/asm-s390/pgalloc.h          |    4 +--
 include/asm-s390/tlb.h              |    2 -
 include/asm-s390x/pgalloc.h         |    4 +--
 include/asm-s390x/tlb.h             |    2 -
 include/asm-sparc/pgalloc.h         |    4 +--
 include/asm-sparc/tlb.h             |    2 -
 include/asm-sparc64/tlb.h           |    6 ++---
 include/asm-x86_64/pgalloc.h        |    4 +--
 include/asm-x86_64/tlb.h            |    2 -
 24 files changed, 91 insertions, 43 deletions

--- 2.5.31/include/asm-alpha/tlb.h~tlb-speedup	Wed Aug 14 12:00:27 2002
+++ 2.5.31-akpm/include/asm-alpha/tlb.h	Wed Aug 14 12:04:57 2002
@@ -3,13 +3,13 @@
 
 #define tlb_start_vma(tlb, vma)			do { } while (0)
 #define tlb_end_vma(tlb, vma)			do { } while (0)
-#define tlb_remove_tlb_entry(tlb, pte, addr)	do { } while (0)
+#define __tlb_remove_tlb_entry(tlb, pte, addr)	do { } while (0)
 
 #define tlb_flush(tlb)				flush_tlb_mm((tlb)->mm)
 
 #include <asm-generic/tlb.h>
 
-#define pte_free_tlb(tlb,pte)			pte_free(pte)
-#define pmd_free_tlb(tlb,pmd)			pmd_free(pmd)
+#define __pte_free_tlb(tlb,pte)			pte_free(pte)
+#define __pmd_free_tlb(tlb,pmd)			pmd_free(pmd)
  
 #endif
--- 2.5.31/include/asm-arm/tlb.h~tlb-speedup	Wed Aug 14 12:00:27 2002
+++ 2.5.31-akpm/include/asm-arm/tlb.h	Wed Aug 14 12:05:03 2002
@@ -11,11 +11,11 @@
 #define tlb_end_vma(tlb,vma)	\
 	flush_tlb_range(vma, vma->vm_start, vma->vm_end)
 
-#define tlb_remove_tlb_entry(tlb, ptep, address) do { } while (0)
+#define __tlb_remove_tlb_entry(tlb, ptep, address) do { } while (0)
 
 #include <asm-generic/tlb.h>
 
-#define pmd_free_tlb(tlb, pmd)	pmd_free(pmd)
-#define pte_free_tlb(tlb, pte)	pte_free(pte)
+#define __pmd_free_tlb(tlb, pmd)	pmd_free(pmd)
+#define __pte_free_tlb(tlb, pte)	pte_free(pte)
 
 #endif
--- 2.5.31/include/asm-generic/tlb.h~tlb-speedup	Wed Aug 14 12:00:27 2002
+++ 2.5.31-akpm/include/asm-generic/tlb.h	Wed Aug 14 12:11:40 2002
@@ -36,9 +36,12 @@
 typedef struct free_pte_ctx {
 	struct mm_struct	*mm;
 	unsigned int		nr;	/* set to ~0U means fast mode */
+	unsigned int		need_flush;/* Really unmapped some ptes? */
 	unsigned int		fullmm; /* non-zero means full mm flush */
 	unsigned long		freed;
 	struct page *		pages[FREE_PTE_NR];
+	unsigned long		flushes;/* stats: count avoided flushes */
+	unsigned long		avoided_flushes;
 } mmu_gather_t;
 
 /* Users of the generic TLB shootdown code must declare this storage space. */
@@ -66,6 +69,13 @@ static inline void tlb_flush_mmu(mmu_gat
 {
 	unsigned long nr;
 
+	if (!tlb->need_flush) {
+		tlb->avoided_flushes++;
+		return;
+	}
+	tlb->need_flush = 0;
+	tlb->flushes++;
+
 	tlb_flush(tlb);
 	nr = tlb->nr;
 	if (!tlb_fast_mode(tlb)) {
@@ -103,6 +113,7 @@ static inline void tlb_finish_mmu(mmu_ga
  */
 static inline void tlb_remove_page(mmu_gather_t *tlb, struct page *page)
 {
+	tlb->need_flush = 1;
 	if (tlb_fast_mode(tlb)) {
 		free_page_and_swap_cache(page);
 		return;
@@ -112,5 +123,29 @@ static inline void tlb_remove_page(mmu_g
 		tlb_flush_mmu(tlb, 0, 0);
 }
 
-#endif /* _ASM_GENERIC__TLB_H */
+/**
+ * tlb_remove_tlb_entry - remember a pte unmapping for later tlb invalidation.
+ *
+ * Record the fact that pte's were really umapped in ->need_flush, so we can
+ * later optimise away the tlb invalidate.   This helps when userspace is
+ * unmapping already-unmapped pages, which happens quite a lot.
+ */
+#define tlb_remove_tlb_entry(tlb, ptep, address)		\
+	do {							\
+		tlb->need_flush = 1;				\
+		__tlb_remove_tlb_entry(tlb, ptep, address);	\
+	} while (0)
+
+#define pte_free_tlb(tlb, ptep)					\
+	do {							\
+		tlb->need_flush = 1;				\
+		__pte_free_tlb(tlb, ptep);			\
+	} while (0)
+
+#define pmd_free_tlb(tlb, pmdp)					\
+	do {							\
+		tlb->need_flush = 1;				\
+		__pmd_free_tlb(tlb, pmdp);			\
+	} while (0)
 
+#endif /* _ASM_GENERIC__TLB_H */
--- 2.5.31/include/asm-i386/tlb.h~tlb-speedup	Wed Aug 14 12:00:27 2002
+++ 2.5.31-akpm/include/asm-i386/tlb.h	Wed Aug 14 12:00:27 2002
@@ -7,7 +7,7 @@
  */
 #define tlb_start_vma(tlb, vma) do { } while (0)
 #define tlb_end_vma(tlb, vma) do { } while (0)
-#define tlb_remove_tlb_entry(tlb, ptep, address) do { } while (0)
+#define __tlb_remove_tlb_entry(tlb, ptep, address) do { } while (0)
 
 /*
  * .. because we flush the whole mm when it
--- 2.5.31/include/asm-ia64/tlb.h~tlb-speedup	Wed Aug 14 12:00:27 2002
+++ 2.5.31-akpm/include/asm-ia64/tlb.h	Wed Aug 14 12:00:27 2002
@@ -172,7 +172,7 @@ tlb_finish_mmu (mmu_gather_t *tlb, unsig
  * PTE, not just those pointing to (normal) physical memory.
  */
 static inline void
-tlb_remove_tlb_entry (mmu_gather_t *tlb, pte_t *ptep, unsigned long address)
+__tlb_remove_tlb_entry (mmu_gather_t *tlb, pte_t *ptep, unsigned long address)
 {
 	if (tlb->start_addr == ~0UL)
 		tlb->start_addr = address;
--- 2.5.31/include/asm-m68k/tlb.h~tlb-speedup	Wed Aug 14 12:00:27 2002
+++ 2.5.31-akpm/include/asm-m68k/tlb.h	Wed Aug 14 12:00:27 2002
@@ -7,7 +7,7 @@
  */
 #define tlb_start_vma(tlb, vma)	do { } while (0)
 #define tlb_end_vma(tlb, vma)	do { } while (0)
-#define tlb_remove_tlb_entry(tlb, ptep, address)	do { } while (0)
+#define __tlb_remove_tlb_entry(tlb, ptep, address)	do { } while (0)
 
 /*
  * .. because we flush the whole mm when it
--- 2.5.31/include/asm-ppc64/tlb.h~tlb-speedup	Wed Aug 14 12:00:27 2002
+++ 2.5.31-akpm/include/asm-ppc64/tlb.h	Wed Aug 14 12:00:27 2002
@@ -40,7 +40,7 @@ struct ppc64_tlb_batch {
 
 extern struct ppc64_tlb_batch ppc64_tlb_batch[NR_CPUS];
 
-static inline void tlb_remove_tlb_entry(mmu_gather_t *tlb, pte_t *ptep,
+static inline void __tlb_remove_tlb_entry(mmu_gather_t *tlb, pte_t *ptep,
 					unsigned long address)
 {
 	int cpu = smp_processor_id();
--- 2.5.31/include/asm-ppc/tlb.h~tlb-speedup	Wed Aug 14 12:00:27 2002
+++ 2.5.31-akpm/include/asm-ppc/tlb.h	Wed Aug 14 12:00:27 2002
@@ -34,7 +34,7 @@ extern void tlb_flush(struct free_pte_ct
 extern void flush_hash_entry(struct mm_struct *mm, pte_t *ptep,
 			     unsigned long address);
 
-static inline void tlb_remove_tlb_entry(mmu_gather_t *tlb, pte_t *ptep,
+static inline void __tlb_remove_tlb_entry(mmu_gather_t *tlb, pte_t *ptep,
 					unsigned long address)
 {
 	if (pte_val(*ptep) & _PAGE_HASHPTE)
@@ -50,7 +50,7 @@ struct flush_tlb_arch { };
 #define tlb_finish_arch(tlb)		do { } while (0)
 #define tlb_start_vma(tlb, vma)		do { } while (0)
 #define tlb_end_vma(tlb, vma)		do { } while (0)
-#define tlb_remove_tlb_entry(tlb, pte, address) do { } while (0)
+#define __tlb_remove_tlb_entry(tlb, pte, address) do { } while (0)
 #define tlb_flush(tlb)			flush_tlb_mm((tlb)->mm)
 
 /* Get the generic bits... */
--- 2.5.31/include/asm-s390/tlb.h~tlb-speedup	Wed Aug 14 12:00:27 2002
+++ 2.5.31-akpm/include/asm-s390/tlb.h	Wed Aug 14 12:00:27 2002
@@ -7,7 +7,7 @@
  */
 #define tlb_start_vma(tlb, vma) do { } while (0)
 #define tlb_end_vma(tlb, vma) do { } while (0)
-#define tlb_remove_tlb_entry(tlb, ptep, address) do { } while (0)
+#define __tlb_remove_tlb_entry(tlb, ptep, address) do { } while (0)
 
 /*
  * .. because we flush the whole mm when it
--- 2.5.31/include/asm-s390x/tlb.h~tlb-speedup	Wed Aug 14 12:00:27 2002
+++ 2.5.31-akpm/include/asm-s390x/tlb.h	Wed Aug 14 12:00:27 2002
@@ -7,7 +7,7 @@
  */
 #define tlb_start_vma(tlb, vma) do { } while (0)
 #define tlb_end_vma(tlb, vma) do { } while (0)
-#define tlb_remove_tlb_entry(tlb, ptep, address) do { } while (0)
+#define __tlb_remove_tlb_entry(tlb, ptep, address) do { } while (0)
 
 /*
  * .. because we flush the whole mm when it
--- 2.5.31/include/asm-sparc64/tlb.h~tlb-speedup	Wed Aug 14 12:00:27 2002
+++ 2.5.31-akpm/include/asm-sparc64/tlb.h	Wed Aug 14 12:10:59 2002
@@ -16,12 +16,12 @@ do {	if (!(tlb)->fullmm)	\
 		flush_tlb_range(vma, vma->vm_start, vma->vm_end); \
 } while (0)
 
-#define tlb_remove_tlb_entry(tlb, ptep, address) \
+#define __tlb_remove_tlb_entry(tlb, ptep, address) \
 	do { } while (0)
 
 #include <asm-generic/tlb.h>
 
-#define pmd_free_tlb(tlb, pmd)	pmd_free(pmd)
-#define pte_free_tlb(tlb, pte)	pte_free(pte)
+#define __pmd_free_tlb(tlb, pmd)	pmd_free(pmd)
+#define __pte_free_tlb(tlb, pte)	pte_free(pte)
 
 #endif /* _SPARC64_TLB_H */
--- 2.5.31/include/asm-sparc/tlb.h~tlb-speedup	Wed Aug 14 12:00:27 2002
+++ 2.5.31-akpm/include/asm-sparc/tlb.h	Wed Aug 14 12:00:27 2002
@@ -11,7 +11,7 @@ do {								\
 	flush_tlb_range(vma, vma->vm_start, vma->vm_end);	\
 } while (0)
 
-#define tlb_remove_tlb_entry(tlb, pte, address) \
+#define __tlb_remove_tlb_entry(tlb, pte, address) \
 	do { } while (0)
 
 #define tlb_flush(tlb) \
--- 2.5.31/include/asm-x86_64/tlb.h~tlb-speedup	Wed Aug 14 12:00:27 2002
+++ 2.5.31-akpm/include/asm-x86_64/tlb.h	Wed Aug 14 12:00:27 2002
@@ -4,7 +4,7 @@
 
 #define tlb_start_vma(tlb, vma) do { } while (0)
 #define tlb_end_vma(tlb, vma) do { } while (0)
-#define tlb_remove_tlb_entry(tlb, ptep, address) do { } while (0)
+#define __tlb_remove_tlb_entry(tlb, ptep, address) do { } while (0)
 
 #define tlb_flush(tlb) flush_tlb_mm((tlb)->mm)
 
--- 2.5.31/fs/proc/proc_misc.c~tlb-speedup	Wed Aug 14 12:00:27 2002
+++ 2.5.31-akpm/fs/proc/proc_misc.c	Wed Aug 14 12:00:27 2002
@@ -41,7 +41,8 @@
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
 #include <asm/io.h>
-
+#include <asm/pgalloc.h>
+#include <asm/tlb.h>
 
 #define LOAD_INT(x) ((x) >> FSHIFT)
 #define LOAD_FRAC(x) LOAD_INT(((x) & (FIXED_1-1)) * 100)
@@ -134,6 +135,14 @@ static int meminfo_read_proc(char *page,
 	struct sysinfo i;
 	int len, committed;
 	struct page_state ps;
+	int cpu;
+	unsigned long flushes = 0;
+	unsigned long non_flushes = 0;
+
+	for (cpu = 0; cpu < NR_CPUS; cpu++) {
+		flushes += mmu_gathers[cpu].flushes;
+		non_flushes += mmu_gathers[cpu].avoided_flushes;
+	}
 
 	get_page_state(&ps);
 /*
@@ -165,7 +174,9 @@ static int meminfo_read_proc(char *page,
 		"Writeback:    %8lu kB\n"
 		"Committed_AS: %8u kB\n"
 		"PageTables:   %8lu kB\n"
-		"ReverseMaps:  %8lu\n",
+		"ReverseMaps:  %8lu\n"
+		"TLB flushes:  %8lu\n"
+		"non flushes:  %8lu\n",
 		K(i.totalram),
 		K(i.freeram),
 		K(i.sharedram),
@@ -183,7 +194,9 @@ static int meminfo_read_proc(char *page,
 		K(ps.nr_writeback),
 		K(committed),
 		K(ps.nr_page_table_pages),
-		ps.nr_reverse_maps
+		ps.nr_reverse_maps,
+		flushes,
+		non_flushes
 		);
 
 	return proc_calc_metrics(page, start, off, count, eof, len);
--- 2.5.31/include/asm-i386/pgalloc.h~tlb-speedup	Wed Aug 14 12:01:52 2002
+++ 2.5.31-akpm/include/asm-i386/pgalloc.h	Wed Aug 14 12:05:24 2002
@@ -37,7 +37,7 @@ static inline void pte_free(struct page 
 }
 
 
-#define pte_free_tlb(tlb,pte) tlb_remove_page((tlb),(pte))
+#define __pte_free_tlb(tlb,pte) tlb_remove_page((tlb),(pte))
 
 /*
  * allocating and freeing a pmd is trivial: the 1-entry pmd is
@@ -47,7 +47,7 @@ static inline void pte_free(struct page 
 
 #define pmd_alloc_one(mm, addr)		({ BUG(); ((pmd_t *)2); })
 #define pmd_free(x)			do { } while (0)
-#define pmd_free_tlb(tlb,x)		do { } while (0)
+#define __pmd_free_tlb(tlb,x)		do { } while (0)
 #define pgd_populate(mm, pmd, pte)	BUG()
 
 #define check_pgt_cache()	do { } while (0)
--- 2.5.31/include/asm-ia64/pgalloc.h~tlb-speedup	Wed Aug 14 12:01:52 2002
+++ 2.5.31-akpm/include/asm-ia64/pgalloc.h	Wed Aug 14 12:07:39 2002
@@ -108,7 +108,7 @@ pmd_free (pmd_t *pmd)
 	++pgtable_cache_size;
 }
 
-#define pmd_free_tlb(tlb, pmd)	pmd_free(pmd)
+#define __pmd_free_tlb(tlb, pmd)	pmd_free(pmd)
 
 static inline void
 pmd_populate (struct mm_struct *mm, pmd_t *pmd_entry, struct page *pte)
@@ -154,7 +154,7 @@ pte_free_kernel (pte_t *pte)
 	free_page((unsigned long) pte);
 }
 
-#define pte_free_tlb(tlb, pte)	tlb_remove_page((tlb), (pte))
+#define __pte_free_tlb(tlb, pte)	tlb_remove_page((tlb), (pte))
 
 extern void check_pgt_cache (void);
 
--- 2.5.31/include/asm-m68k/motorola_pgalloc.h~tlb-speedup	Wed Aug 14 12:01:53 2002
+++ 2.5.31-akpm/include/asm-m68k/motorola_pgalloc.h	Wed Aug 14 12:07:44 2002
@@ -55,7 +55,7 @@ static inline void pte_free(struct page 
 	__free_page(page);
 }
 
-static inline void pte_free_tlb(mmu_gather_t *tlb, struct page *page)
+static inline void __pte_free_tlb(mmu_gather_t *tlb, struct page *page)
 {
 	cache_page(kmap(page));
 	kunmap(page);
@@ -73,7 +73,7 @@ static inline int pmd_free(pmd_t *pmd)
 	return free_pointer_table(pmd);
 }
 
-static inline int pmd_free_tlb(mmu_gather_t *tlb, pmd_t *pmd)
+static inline int __pmd_free_tlb(mmu_gather_t *tlb, pmd_t *pmd)
 {
 	return free_pointer_table(pmd);
 }
--- 2.5.31/include/asm-m68k/sun3_pgalloc.h~tlb-speedup	Wed Aug 14 12:01:53 2002
+++ 2.5.31-akpm/include/asm-m68k/sun3_pgalloc.h	Wed Aug 14 12:07:48 2002
@@ -31,7 +31,7 @@ static inline void pte_free(struct page 
         __free_page(page);
 }
 
-static inline void pte_free_tlb(mmu_gather_t *tlb, struct page *page)
+static inline void __pte_free_tlb(mmu_gather_t *tlb, struct page *page)
 {
 	tlb_remove_page(tlb, page);
 }
@@ -76,7 +76,7 @@ static inline void pmd_populate(struct m
  * inside the pgd, so has no extra memory associated with it.
  */
 #define pmd_free(x)			do { } while (0)
-#define pmd_free_tlb(tlb, x)		do { } while (0)
+#define __pmd_free_tlb(tlb, x)		do { } while (0)
 
 static inline void pgd_free(pgd_t * pgd)
 {
--- 2.5.31/include/asm-ppc64/pgalloc.h~tlb-speedup	Wed Aug 14 12:01:53 2002
+++ 2.5.31-akpm/include/asm-ppc64/pgalloc.h	Wed Aug 14 12:07:53 2002
@@ -53,7 +53,7 @@ pmd_free(pmd_t *pmd)
 	free_page((unsigned long)pmd);
 }
 
-#define pmd_free_tlb(tlb, pmd)	pmd_free(pmd)
+#define __pmd_free_tlb(tlb, pmd)	pmd_free(pmd)
 
 #define pmd_populate_kernel(mm, pmd, pte) pmd_set(pmd, pte)
 #define pmd_populate(mm, pmd, pte_page) \
@@ -88,7 +88,7 @@ pte_free_kernel(pte_t *pte)
 }
 
 #define pte_free(pte_page)	pte_free_kernel(page_address(pte_page))
-#define pte_free_tlb(tlb, pte)	pte_free(pte)
+#define __pte_free_tlb(tlb, pte)	pte_free(pte)
 
 #define check_pgt_cache()	do { } while (0)
 
--- 2.5.31/include/asm-ppc/pgalloc.h~tlb-speedup	Wed Aug 14 12:01:53 2002
+++ 2.5.31-akpm/include/asm-ppc/pgalloc.h	Wed Aug 14 12:08:03 2002
@@ -20,7 +20,7 @@ extern void pgd_free(pgd_t *pgd);
  */
 #define pmd_alloc_one(mm,address)       ({ BUG(); ((pmd_t *)2); })
 #define pmd_free(x)                     do { } while (0)
-#define pmd_free_tlb(tlb,x)		do { } while (0)
+#define __pmd_free_tlb(tlb,x)		do { } while (0)
 #define pgd_populate(mm, pmd, pte)      BUG()
 
 #define pmd_populate_kernel(mm, pmd, pte)	\
@@ -33,7 +33,7 @@ extern struct page *pte_alloc_one(struct
 extern void pte_free_kernel(pte_t *pte);
 extern void pte_free(struct page *pte);
 
-#define pte_free_tlb(tlb, pte)	pte_free((pte))
+#define __pte_free_tlb(tlb, pte)	pte_free((pte))
 
 #define check_pgt_cache()	do { } while (0)
 
--- 2.5.31/include/asm-s390/pgalloc.h~tlb-speedup	Wed Aug 14 12:01:53 2002
+++ 2.5.31-akpm/include/asm-s390/pgalloc.h	Wed Aug 14 12:08:09 2002
@@ -49,7 +49,7 @@ static inline void pgd_free(pgd_t *pgd)
  */
 #define pmd_alloc_one(mm,address)       ({ BUG(); ((pmd_t *)2); })
 #define pmd_free(x)                     do { } while (0)
-#define pmd_free_tlb(tlb,x)		do { } while (0)
+#define __pmd_free_tlb(tlb,x)		do { } while (0)
 #define pgd_populate(mm, pmd, pte)      BUG()
 
 static inline void 
@@ -107,7 +107,7 @@ static inline void pte_free(struct page 
         __free_page(pte);
 }
 
-#define pte_free_tlb(tlb,pte) tlb_remove_page((tlb),(pte))
+#define __pte_free_tlb(tlb,pte) tlb_remove_page((tlb),(pte))
 
 /*
  * This establishes kernel virtual mappings (e.g., as a result of a
--- 2.5.31/include/asm-s390x/pgalloc.h~tlb-speedup	Wed Aug 14 12:01:53 2002
+++ 2.5.31-akpm/include/asm-s390x/pgalloc.h	Wed Aug 14 12:08:12 2002
@@ -68,7 +68,7 @@ static inline void pmd_free (pmd_t *pmd)
 	free_pages((unsigned long) pmd, 2);
 }
 
-#define pmd_free_tlb(tlb,pmd) pmd_free(pmd)
+#define __pmd_free_tlb(tlb,pmd) pmd_free(pmd)
 
 static inline void
 pmd_populate_kernel(struct mm_struct *mm, pmd_t *pmd, pte_t *pte)
@@ -123,7 +123,7 @@ static inline void pte_free(struct page 
         __free_page(pte);
 }
 
-#define pte_free_tlb(tlb,pte) tlb_remove_page((tlb),(pte))
+#define __pte_free_tlb(tlb,pte) tlb_remove_page((tlb),(pte))
 
 /*
  * This establishes kernel virtual mappings (e.g., as a result of a
--- 2.5.31/include/asm-sparc/pgalloc.h~tlb-speedup	Wed Aug 14 12:01:53 2002
+++ 2.5.31-akpm/include/asm-sparc/pgalloc.h	Wed Aug 14 12:11:09 2002
@@ -47,7 +47,7 @@ BTFIXUPDEF_CALL(void, free_pmd_fast, pmd
 #define free_pmd_fast(pmd)	BTFIXUP_CALL(free_pmd_fast)(pmd)
 
 #define pmd_free(pmd)           free_pmd_fast(pmd)
-#define pmd_free_tlb(tlb, pmd)	pmd_free(pmd)
+#define __pmd_free_tlb(tlb, pmd) pmd_free(pmd)
 
 BTFIXUPDEF_CALL(void, pmd_populate, pmd_t *, struct page *)
 #define pmd_populate(MM, PMD, PTE)        BTFIXUP_CALL(pmd_populate)(PMD, PTE)
@@ -64,6 +64,6 @@ BTFIXUPDEF_CALL(void, free_pte_fast, pte
 
 BTFIXUPDEF_CALL(void, pte_free, struct page *)
 #define pte_free(pte)		BTFIXUP_CALL(pte_free)(pte)
-#define pte_free_tlb(tlb, pte)	pte_free(pte)
+#define __pte_free_tlb(tlb, pte)	pte_free(pte)
 
 #endif /* _SPARC_PGALLOC_H */
--- 2.5.31/include/asm-x86_64/pgalloc.h~tlb-speedup	Wed Aug 14 12:01:53 2002
+++ 2.5.31-akpm/include/asm-x86_64/pgalloc.h	Wed Aug 14 12:11:14 2002
@@ -75,7 +75,7 @@ extern inline void pte_free(struct page 
 	__free_page(pte);
 } 
 
-#define pte_free_tlb(tlb,pte) tlb_remove_page((tlb),(pte))
-#define pmd_free_tlb(tlb,x)   do { } while (0)
+#define __pte_free_tlb(tlb,pte) tlb_remove_page((tlb),(pte))
+#define __pmd_free_tlb(tlb,x)   do { } while (0)
 
 #endif /* _X86_64_PGALLOC_H */

.
