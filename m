Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316528AbSEUGVq>; Tue, 21 May 2002 02:21:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316529AbSEUGVq>; Tue, 21 May 2002 02:21:46 -0400
Received: from pizda.ninka.net ([216.101.162.242]:32710 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S316528AbSEUGVn>;
	Tue, 21 May 2002 02:21:43 -0400
Date: Mon, 20 May 2002 23:07:50 -0700 (PDT)
Message-Id: <20020520.230750.83973189.davem@redhat.com>
To: torvalds@transmeta.com
CC: linux-kernel@vger.kernel.org
Subject: Make 2.5.17 TLB even more friendlier
From: "David S. Miller" <davem@redhat.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


How about this one?  Linus, you can pull it from:

	master.kernel.org:/home/davem/BK/tlb-2.5

if you think it is fine.  [ And no, before someone asks, I do
put provide my BK trees anywhere publicly. I don't do it because
it would mean I would have to maintain every tree twice, and I
push often enough to Linus and Marcelo that it does not matter. ]

The idea is to give pte_free_tlb() a way to know "which" pte page
is being killed.  We need to know that to flush the virtual PTEs
used to make TLB misses go fast on sparc64.

I verified that if you don't make reference to the pte_page_nr
or pmd_page_nr values, GCC optimizes it completely away.

The next part is allowing for a "full_mm_flush" state such that
tlb_flush() can make decisions based upon that.  Then we move
the tlb_{start,end}_vma() invocations one level up.  So for
the exit_mmap case it is:

	tlb_gather_mmu(mm, 1);

	flush_cache_mm(mm);

	for each vma {
		...
		unmap_page_range(...);
	}

	clear_page_tables();
	tlb_finish_mmu();

and for munmap-like operations it is:

	tlb_gather_mmu(mm, 0);

	for each vma {
		..
		tlb_start_vma(tlb, vma, start, end);
		unmap_page_range(vma, start, end);
		tlb_end_vma(tlb, vma, start, end);
	}
	tlb_finish_mmu();

So on Sparc64 we can make tlb_{start,end}_vma() do the
cache/tlb range flushes.  Then tlb_flush will do
a flush_tlb_mm if we are not doing a full flush.

Finally, flush_tlb_pgtables is no longer needed and also
buggy, so we kill it off.

Makes sense?

--- ./include/asm-generic/tlb.h.~1~	Mon May 20 22:26:06 2002
+++ ./include/asm-generic/tlb.h	Mon May 20 22:28:46 2002
@@ -22,7 +22,7 @@
  */
 #ifdef CONFIG_SMP
   #define FREE_PTE_NR	507
-  #define tlb_fast_mode(tlb) ((tlb)->nr == ~0UL) 
+  #define tlb_fast_mode(tlb) ((tlb)->nr == ~0U) 
 #else
   #define FREE_PTE_NR	1
   #define tlb_fast_mode(tlb) 1
@@ -35,7 +35,8 @@
  */
 typedef struct free_pte_ctx {
 	struct mm_struct	*mm;
-	unsigned long		nr;	/* set to ~0UL means fast mode */
+	unsigned int		nr;	/* set to ~0U means fast mode */
+	unsigned int		full_mm_flush;
 	unsigned long		freed;
 	struct page *		pages[FREE_PTE_NR];
 } mmu_gather_t;
@@ -46,15 +47,18 @@ extern mmu_gather_t	mmu_gathers[NR_CPUS]
 /* tlb_gather_mmu
  *	Return a pointer to an initialized mmu_gather_t.
  */
-static inline mmu_gather_t *tlb_gather_mmu(struct mm_struct *mm)
+static inline mmu_gather_t *tlb_gather_mmu(struct mm_struct *mm, int full_mm_flush)
 {
 	mmu_gather_t *tlb = &mmu_gathers[smp_processor_id()];
 
 	tlb->mm = mm;
-	tlb->freed = 0;
 
 	/* Use fast mode if only one CPU is online */
-	tlb->nr = smp_num_cpus > 1 ? 0UL : ~0UL;
+	tlb->nr = smp_num_cpus > 1 ? 0U : ~0U;
+
+	tlb->full_mm_flush = full_mm_flush;
+	tlb->freed = 0;
+
 	return tlb;
 }
 
--- ./include/asm-i386/tlb.h.~1~	Mon May 20 22:32:02 2002
+++ ./include/asm-i386/tlb.h	Mon May 20 22:32:11 2002
@@ -5,8 +5,8 @@
  * x86 doesn't need any special per-pte or
  * per-vma handling..
  */
-#define tlb_start_vma(tlb, vma) do { } while (0)
-#define tlb_end_vma(tlb, vma) do { } while (0)
+#define tlb_start_vma(tlb, vma, start, end) do { } while (0)
+#define tlb_end_vma(tlb, vma, start, end) do { } while (0)
 #define tlb_remove_tlb_entry(tlb, pte, address) do { } while (0)
 
 /*
--- ./include/asm-i386/pgalloc.h.~1~	Mon May 20 22:35:48 2002
+++ ./include/asm-i386/pgalloc.h	Mon May 20 22:36:03 2002
@@ -36,7 +36,7 @@ static inline void pte_free(struct page 
 }
 
 
-#define pte_free_tlb(tlb,pte) tlb_remove_page((tlb),(pte))
+#define pte_free_tlb(tlb,pte,pte_page_nr) tlb_remove_page((tlb),(pte))
 
 /*
  * allocating and freeing a pmd is trivial: the 1-entry pmd is
@@ -46,7 +46,7 @@ static inline void pte_free(struct page 
 
 #define pmd_alloc_one(mm, addr)		({ BUG(); ((pmd_t *)2); })
 #define pmd_free(x)			do { } while (0)
-#define pmd_free_tlb(tlb,x)		do { } while (0)
+#define pmd_free_tlb(tlb,x,y)		do { } while (0)
 #define pgd_populate(mm, pmd, pte)	BUG()
 
 #define check_pgt_cache()	do { } while (0)
--- ./include/asm-sparc64/tlb.h.~1~	Mon May 20 22:22:43 2002
+++ ./include/asm-sparc64/tlb.h	Mon May 20 22:38:08 2002
@@ -1 +1,36 @@
+#ifndef _SPARC64_TLB_H
+#define _SPARC64_TLB_H
+
+#define tlb_flush(tlb)			\
+do {	if ((tlb)->full_mm_flush)	\
+		flush_tlb_mm((tlb)->mm);\
+} while (0)
+
+#define tlb_start_vma(tlb, vma, start, end)	\
+	flush_cache_range(vma, start, end)
+#define tlb_end_vma(tlb, vma, start, end)	\
+	flush_tlb_range(vma, start, end)
+
+#define tlb_remove_tlb_entry(tlb, pte, address) do { } while (0)
+
 #include <asm-generic/tlb.h>
+
+#define pmd_free_tlb(tlb, pmd, pmd_page_nr)	pmd_free(pmd)
+
+static __inline__ void pte_free_tlb(mmu_gather_t *tlb, struct page *pte,
+	unsigned long pte_page_nr)
+{
+	pte_free(pte);
+
+	if (!tlb->full_mm_flush) {
+		unsigned long vpte_addr;
+
+		vpte_addr = (tlb_type == spitfire ?
+			     VPTE_BASE_SPITFIRE :
+			     VPTE_BASE_CHEETAH);
+		vpte_addr += (pte_page_nr << PAGE_SHIFT);
+		flush_tlb_vpte(tlb->mm, vpte_addr);
+	}
+}
+
+#endif /* _SPARC64_TLB_H */
--- ./include/asm-sparc64/tlbflush.h.~1~	Mon May 20 22:34:25 2002
+++ ./include/asm-sparc64/tlbflush.h	Mon May 20 22:46:47 2002
@@ -43,6 +43,13 @@ do { struct mm_struct *__mm = (vma)->vm_
 			 SECONDARY_CONTEXT); \
 } while(0)
 
+#define flush_tlb_vpte(mm, addr) \
+do { struct mm_struct *__mm = (mm); \
+     if (CTX_VALID(__mm->context)) \
+	__flush_tlb_page(CTX_HWBITS(__mm->context), (addr)&PAGE_MASK, \
+			 SECONDARY_CONTEXT); \
+} while(0)
+
 #else /* CONFIG_SMP */
 
 extern void smp_flush_tlb_all(void);
@@ -61,33 +68,9 @@ extern void smp_flush_tlb_page(struct mm
 	smp_flush_tlb_kernel_range(start, end)
 #define flush_tlb_page(vma, page) \
 	smp_flush_tlb_page((vma)->vm_mm, page)
+#define flush_tlb_vpte(mm, addr) \
+	smp_flush_tlb_page((mm), addr)
 
 #endif /* ! CONFIG_SMP */
-
-static __inline__ void flush_tlb_pgtables(struct mm_struct *mm, unsigned long start,
-					  unsigned long end)
-{
-	/* Note the signed type.  */
-	long s = start, e = end, vpte_base;
-	if (s > e)
-		/* Nobody should call us with start below VM hole and end above.
-		   See if it is really true.  */
-		BUG();
-#if 0
-	/* Currently free_pgtables guarantees this.  */
-	s &= PMD_MASK;
-	e = (e + PMD_SIZE - 1) & PMD_MASK;
-#endif
-	vpte_base = (tlb_type == spitfire ?
-		     VPTE_BASE_SPITFIRE :
-		     VPTE_BASE_CHEETAH);
-	{
-		struct vm_area_struct vma;
-		vma.vm_mm = mm;
-		flush_tlb_range(&vma,
-				vpte_base + (s >> (PAGE_SHIFT - 3)),
-				vpte_base + (e >> (PAGE_SHIFT - 3)));
-	}
-}
 
 #endif /* _SPARC64_TLBFLUSH_H */
--- ./mm/mmap.c.~1~	Mon May 20 22:26:27 2002
+++ ./mm/mmap.c	Mon May 20 22:35:11 2002
@@ -785,10 +785,8 @@ no_mmaps:
 	 */
 	start_index = pgd_index(first);
 	end_index = pgd_index(last);
-	if (end_index > start_index) {
+	if (end_index > start_index)
 		clear_page_tables(tlb, start_index, end_index - start_index);
-		flush_tlb_pgtables(mm, first & PGDIR_MASK, last & PGDIR_MASK);
-	}
 }
 
 /* Normal function to fix up a mapping
@@ -846,7 +844,7 @@ static void unmap_region(struct mm_struc
 {
 	mmu_gather_t *tlb;
 
-	tlb = tlb_gather_mmu(mm);
+	tlb = tlb_gather_mmu(mm, 0);
 
 	do {
 		unsigned long from, to;
@@ -854,7 +852,9 @@ static void unmap_region(struct mm_struc
 		from = start < mpnt->vm_start ? mpnt->vm_start : start;
 		to = end > mpnt->vm_end ? mpnt->vm_end : end;
 
+		tlb_start_vma(tlb, mpnt, from, to);
 		unmap_page_range(tlb, mpnt, from, to);
+		tlb_end_vma(tlb, mpnt, from, to);
 	} while ((mpnt = mpnt->vm_next) != NULL);
 
 	free_pgtables(tlb, prev, start, end);
@@ -1103,7 +1103,7 @@ void exit_mmap(struct mm_struct * mm)
 	release_segments(mm);
 	spin_lock(&mm->page_table_lock);
 
-	tlb = tlb_gather_mmu(mm);
+	tlb = tlb_gather_mmu(mm, 1);
 
 	flush_cache_mm(mm);
 	mpnt = mm->mmap;
--- ./mm/memory.c.~1~	Mon May 20 22:26:27 2002
+++ ./mm/memory.c	Mon May 20 22:37:41 2002
@@ -75,7 +75,8 @@ mem_map_t * mem_map;
  * Note: this doesn't free the actual pages themselves. That
  * has been handled earlier when unmapping all the memory regions.
  */
-static inline void free_one_pmd(mmu_gather_t *tlb, pmd_t * dir)
+static inline void free_one_pmd(mmu_gather_t *tlb, pmd_t * dir,
+	unsigned long pte_page_nr)
 {
 	struct page *pte;
 
@@ -88,28 +89,32 @@ static inline void free_one_pmd(mmu_gath
 	}
 	pte = pmd_page(*dir);
 	pmd_clear(dir);
-	pte_free_tlb(tlb, pte);
+	pte_free_tlb(tlb, pte, pte_page_nr);
 }
 
-static inline void free_one_pgd(mmu_gather_t *tlb, pgd_t * dir)
+static inline unsigned long free_one_pgd(mmu_gather_t *tlb, pgd_t * dir,
+	unsigned long pte_page_nr)
 {
 	int j;
 	pmd_t * pmd;
 
 	if (pgd_none(*dir))
-		return;
+		goto out;
 	if (pgd_bad(*dir)) {
 		pgd_ERROR(*dir);
 		pgd_clear(dir);
-		return;
+		goto out;
 	}
 	pmd = pmd_offset(dir, 0);
 	pgd_clear(dir);
 	for (j = 0; j < PTRS_PER_PMD ; j++) {
 		prefetchw(pmd+j+(PREFETCH_STRIDE/16));
-		free_one_pmd(tlb, pmd+j);
+		free_one_pmd(tlb, pmd+j, pte_page_nr+j);
 	}
-	pmd_free_tlb(tlb, pmd);
+	pmd_free_tlb(tlb, pmd, (dir - tlb->mm->pgd));
+
+out:
+	return pte_page_nr + PTRS_PER_PMD;
 }
 
 /*
@@ -121,10 +126,12 @@ static inline void free_one_pgd(mmu_gath
 void clear_page_tables(mmu_gather_t *tlb, unsigned long first, int nr)
 {
 	pgd_t * page_dir = tlb->mm->pgd;
+	unsigned long pte_page_nr;
 
 	page_dir += first;
+	pte_page_nr = first * PTRS_PER_PMD;
 	do {
-		free_one_pgd(tlb, page_dir);
+		pte_page_nr = free_one_pgd(tlb, page_dir, pte_page_nr);
 		page_dir++;
 	} while (--nr);
 
@@ -396,13 +403,11 @@ void unmap_page_range(mmu_gather_t *tlb,
 	if (address >= end)
 		BUG();
 	dir = pgd_offset(vma->vm_mm, address);
-	tlb_start_vma(tlb, vma);
 	do {
 		zap_pmd_range(tlb, dir, address, end - address);
 		address = (address + PGDIR_SIZE) & PGDIR_MASK;
 		dir++;
 	} while (address && (address < end));
-	tlb_end_vma(tlb, vma);
 }
 
 /*
@@ -429,8 +434,10 @@ void zap_page_range(struct vm_area_struc
 	spin_lock(&mm->page_table_lock);
 	flush_cache_range(vma, address, end);
 
-	tlb = tlb_gather_mmu(mm);
+	tlb = tlb_gather_mmu(mm, 0);
+	tlb_start_vma(tlb, vma, address, end);
 	unmap_page_range(tlb, vma, address, end);
+	tlb_end_vma(tlb, vma, address, end);
 	tlb_finish_mmu(tlb, start, end);
 	spin_unlock(&mm->page_table_lock);
 }
