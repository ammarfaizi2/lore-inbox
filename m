Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316480AbSEUBQU>; Mon, 20 May 2002 21:16:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316482AbSEUBQT>; Mon, 20 May 2002 21:16:19 -0400
Received: from pizda.ninka.net ([216.101.162.242]:60867 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S316480AbSEUBQN>;
	Mon, 20 May 2002 21:16:13 -0400
Date: Mon, 20 May 2002 18:02:20 -0700 (PDT)
Message-Id: <20020520.180220.90351639.davem@redhat.com>
To: torvalds@transmeta.com
Cc: paulus@samba.org, linux-kernel@vger.kernel.org
Subject: [PATCH] TLB changes (was Re: Linux-2.5.16)
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020520.163724.40381283.davem@redhat.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ok, here is what I'm playing with now on sparc64.  It seems to
work so far and I'm stressing it out with a 64-bit gcc-3.1 bootstrap.

1) We differentiate between unmapping for munmap() type operations
   and flushing out the entire address space.

   tlb->full_mm_flush keeps track of that, initialized via
   tlb_gather_mmu().

   In this way a platform that wants to do the per-VMA flushes
   can do so, and still get the:

	flush_cache_mm(mm);
	.. flush all VMAs ...
	flush_tlb_mm(mm);

   when clearing out the entire address space.

2) The {pmd,pte}_free_tlb stuff needs to know which part of the
   address space that pmd/pte came from in order to flush it
   properly.

   Basically, it needs to have the same information that
   flush_tlb_pgtables() had access to.

   So I made the page table clearing keep track of this.

   This is an area that undoubtedly can be optimized further.

   For example, if we keep track of the first pte_page_nr fully
   freed and also the last one fully freed, we can just do a single
   flush at the end.

   If we move in that direction, I don't think it makes sense to
   provide two different routines anymore.  Just one:

	flush_page_tables(mm, first_pte_page_nr, last_pte_page_nr);

   Actually, I'm not so sure this meshes well with what the PPC
   folks want to accomplish to flush the hash tables efficiently.
   Paul, comments?

3) As a consequence of #2 being able to do the page table flushing
   we can totally kill off flush_tlb_pgtables.  It is buggy and
   the work is to be done by the TLB infrastructure.

Comments?

--- ./include/asm-generic/tlb.h.~1~	Mon May 20 16:31:23 2002
+++ ./include/asm-generic/tlb.h	Mon May 20 17:16:56 2002
@@ -28,6 +28,7 @@ typedef struct free_pte_ctx {
 	struct mm_struct	*mm;
 	unsigned long		nr;	/* set to ~0UL means fast mode */
 	unsigned long		freed;
+	int			full_mm_flush;	/* non-zero means full address space flush */
 	struct page *		pages[FREE_PTE_NR];
 } mmu_gather_t;
 
@@ -35,18 +36,19 @@ typedef struct free_pte_ctx {
 extern mmu_gather_t	mmu_gathers[NR_CPUS];
 
 /* Do me later */
-#define tlb_start_vma(tlb, vma) do { } while (0)
-#define tlb_end_vma(tlb, vma) do { } while (0)
+#define tlb_start_vma(tlb, vma, start, end) do { } while (0)
+#define tlb_end_vma(tlb, vma, start, end) do { } while (0)
 
 /* tlb_gather_mmu
  *	Return a pointer to an initialized mmu_gather_t.
  */
-static inline mmu_gather_t *tlb_gather_mmu(struct mm_struct *mm)
+static inline mmu_gather_t *tlb_gather_mmu(struct mm_struct *mm, int full_mm_flush)
 {
 	mmu_gather_t *tlb = &mmu_gathers[smp_processor_id()];
 
 	tlb->mm = mm;
 	tlb->freed = 0;
+	tlb->full_mm_flush = full_mm_flush;
 
 	/* Use fast mode if only one CPU is online */
 	tlb->nr = smp_num_cpus > 1 ? 0UL : ~0UL;
@@ -57,7 +59,10 @@ static inline void tlb_flush_mmu(mmu_gat
 {
 	unsigned long nr;
 
-	flush_tlb_mm(tlb->mm);
+	if (tlb->full_mm_flush)
+		flush_tlb_mm(tlb->mm);
+	else
+		tlb_flush_mm(tlb->mm);
 	nr = tlb->nr;
 	if (nr != ~0UL) {
 		unsigned long i;
--- ./include/asm-sparc64/tlb.h.~1~	Mon May 20 16:30:00 2002
+++ ./include/asm-sparc64/tlb.h	Mon May 20 17:21:49 2002
@@ -1 +1,29 @@
+#define tlb_flush_mm(mm)			do { } while (0)
+
 #include <asm-generic/tlb.h>
+
+/* We need to flush at the VMA level.  */
+#undef tlb_start_vma
+#define tlb_start_vma(tlb, vma, start, end) \
+	flush_cache_range(vma, start, end)
+#undef tlb_end_vma
+#define tlb_end_vma(tlb, vma, start, end) \
+	flush_tlb_range(vma, start, end)
+
+#define pmd_free_tlb(tlb, pmd, pmd_page_nr)	do { } while (0)
+
+static __inline__ void pte_free_tlb(mmu_gather_t *tlb, struct page *pte,
+	unsigned long pte_page_nr)
+{
+	tlb_remove_page(tlb, pte);
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
--- ./include/asm-sparc64/tlbflush.h.~1~	Mon May 20 17:09:24 2002
+++ ./include/asm-sparc64/tlbflush.h	Mon May 20 17:15:01 2002
@@ -22,12 +22,12 @@ extern void __flush_tlb_kernel_range(uns
 	__flush_tlb_kernel_range(start,end)
 
 #define flush_tlb_mm(__mm) \
-do { if(CTX_VALID((__mm)->context)) \
+do { if (CTX_VALID((__mm)->context)) \
 	__flush_tlb_mm(CTX_HWBITS((__mm)->context), SECONDARY_CONTEXT); \
 } while(0)
 
 #define flush_tlb_range(__vma, start, end) \
-do { if(CTX_VALID((__vma)->vm_mm->context)) { \
+do { if (CTX_VALID((__vma)->vm_mm->context)) { \
 	unsigned long __start = (start)&PAGE_MASK; \
 	unsigned long __end = PAGE_ALIGN(end); \
 	__flush_tlb_range(CTX_HWBITS((__vma)->vm_mm->context), __start, \
@@ -38,11 +38,18 @@ do { if(CTX_VALID((__vma)->vm_mm->contex
 
 #define flush_tlb_page(vma, page) \
 do { struct mm_struct *__mm = (vma)->vm_mm; \
-     if(CTX_VALID(__mm->context)) \
+     if (CTX_VALID(__mm->context)) \
 	__flush_tlb_page(CTX_HWBITS(__mm->context), (page)&PAGE_MASK, \
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
--- ./mm/memory.c.~1~	Mon May 20 16:31:43 2002
+++ ./mm/memory.c	Mon May 20 17:24:43 2002
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
 
@@ -394,13 +401,11 @@ void unmap_page_range(mmu_gather_t *tlb,
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
@@ -427,8 +432,10 @@ void zap_page_range(struct vm_area_struc
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
--- ./mm/mmap.c.~1~	Mon May 20 16:55:53 2002
+++ ./mm/mmap.c	Mon May 20 17:22:03 2002
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
@@ -1107,7 +1107,7 @@ void exit_mmap(struct mm_struct * mm)
 	release_segments(mm);
 	spin_lock(&mm->page_table_lock);
 
-	tlb = tlb_gather_mmu(mm);
+	tlb = tlb_gather_mmu(mm, 1);
 
 	flush_cache_mm(mm);
 	mpnt = mm->mmap;
