Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261681AbUJYHkE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261681AbUJYHkE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 03:40:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261699AbUJYHkD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 03:40:03 -0400
Received: from cantor.suse.de ([195.135.220.2]:12448 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261681AbUJYHZk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 03:25:40 -0400
Date: Mon, 25 Oct 2004 09:23:49 +0200
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: [PATCH 3/17] 4level core patch
Message-ID: <417CAA05.mail3Y814D9ZM@wotan.suse.de>
User-Agent: nail 10.6 11/15/03
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: ak@suse.de (Andreas Kleen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

4level core patch

This patch extends the Linux MM to 4level page tables. 

The conversion is quite straight forward. The additional level
is called pml4.  The biggest change is that I rewrote copy_page_range(),
because the old version just wasn't scalable anymore.

This is the core patch for mm/*, fs/*, include/linux/*  

It breaks all architectures, which will be fixed in separate patches.

pgd_offset() and pgd_offset_k() have been renamed to make sure
all unconverted code causes an compile error. They are replaced
with pml4_offset()/pml4_offset_k() and pml4_pgd_offset()/pml4_pgd_offset_k()
Please note than when you use pml4_offset_k() you also have 
to use pml4_pgd_offset_k() because IA64 requires a special case here.

Signed-off-by: Andi Kleen <ak@suse.de>

diff -urpN -X ../KDIFX linux-2.6.10rc1/fs/exec.c linux-2.6.10rc1-4level/fs/exec.c
--- linux-2.6.10rc1/fs/exec.c	2004-10-25 04:47:16.000000000 +0200
+++ linux-2.6.10rc1-4level/fs/exec.c	2004-10-25 06:22:28.000000000 +0200
@@ -299,6 +299,7 @@ void install_arg_page(struct vm_area_str
 			struct page *page, unsigned long address)
 {
 	struct mm_struct *mm = vma->vm_mm;
+	pml4_t *pml4;
 	pgd_t * pgd;
 	pmd_t * pmd;
 	pte_t * pte;
@@ -307,9 +308,12 @@ void install_arg_page(struct vm_area_str
 		goto out_sig;
 
 	flush_dcache_page(page);
-	pgd = pgd_offset(mm, address);
+	pml4 = pml4_offset(mm, address);
 
 	spin_lock(&mm->page_table_lock);
+	pgd = pgd_alloc(mm, pml4, address);
+	if (!pgd) 
+		goto out;
 	pmd = pmd_alloc(mm, pgd, address);
 	if (!pmd)
 		goto out;
diff -urpN -X ../KDIFX linux-2.6.10rc1/include/linux/init_task.h linux-2.6.10rc1-4level/include/linux/init_task.h
--- linux-2.6.10rc1/include/linux/init_task.h	2004-10-25 04:47:37.000000000 +0200
+++ linux-2.6.10rc1-4level/include/linux/init_task.h	2004-10-25 04:48:10.000000000 +0200
@@ -34,7 +34,7 @@
 #define INIT_MM(name) \
 {			 					\
 	.mm_rb		= RB_ROOT,				\
-	.pgd		= swapper_pg_dir, 			\
+	.pml4		= swapper_pml4, 			\
 	.mm_users	= ATOMIC_INIT(2), 			\
 	.mm_count	= ATOMIC_INIT(1), 			\
 	.mmap_sem	= __RWSEM_INITIALIZER(name.mmap_sem),	\
diff -urpN -X ../KDIFX linux-2.6.10rc1/include/linux/mm.h linux-2.6.10rc1-4level/include/linux/mm.h
--- linux-2.6.10rc1/include/linux/mm.h	2004-10-25 04:47:37.000000000 +0200
+++ linux-2.6.10rc1-4level/include/linux/mm.h	2004-10-25 04:48:10.000000000 +0200
@@ -564,7 +564,7 @@ int unmap_vmas(struct mmu_gather **tlbp,
 		struct vm_area_struct *start_vma, unsigned long start_addr,
 		unsigned long end_addr, unsigned long *nr_accounted,
 		struct zap_details *);
-void clear_page_tables(struct mmu_gather *tlb, unsigned long first, int nr);
+void clear_page_range(struct mmu_gather *tlb, unsigned long addr, unsigned long end);
 int copy_page_range(struct mm_struct *dst, struct mm_struct *src,
 			struct vm_area_struct *vma);
 int zeromap_page_range(struct vm_area_struct *vma, unsigned long from,
@@ -580,6 +580,7 @@ static inline void unmap_shared_mapping_
 
 extern int vmtruncate(struct inode * inode, loff_t offset);
 extern pmd_t *FASTCALL(__pmd_alloc(struct mm_struct *mm, pgd_t *pgd, unsigned long address));
+extern pgd_t fastcall *__pgd_alloc(struct mm_struct *mm, pml4_t *pgd, unsigned long address);
 extern pte_t *FASTCALL(pte_alloc_kernel(struct mm_struct *mm, pmd_t *pmd, unsigned long address));
 extern pte_t *FASTCALL(pte_alloc_map(struct mm_struct *mm, pmd_t *pmd, unsigned long address));
 extern int install_page(struct mm_struct *mm, struct vm_area_struct *vma, unsigned long addr, struct page *page, pgprot_t prot);
@@ -635,6 +636,20 @@ static inline pmd_t *pmd_alloc(struct mm
 	return pmd_offset(pgd, address);
 }
 
+static inline pgd_t *pgd_alloc(struct mm_struct *mm, pml4_t *pml4, unsigned long address)
+{
+	if (pml4_none(*pml4))
+		return __pgd_alloc(mm, pml4, address); 
+	return pml4_pgd_offset(pml4, address); 
+}
+
+static inline pgd_t *pgd_alloc_k(struct mm_struct *mm, pml4_t *pml4, unsigned long address)
+{
+	if (pml4_none(*pml4))
+		return __pgd_alloc(mm, pml4, address); 
+	return pml4_pgd_offset_k(pml4, address); 
+}
+
 extern void free_area_init(unsigned long * zones_size);
 extern void free_area_init_node(int nid, pg_data_t *pgdat,
 	unsigned long * zones_size, unsigned long zone_start_pfn, 
diff -urpN -X ../KDIFX linux-2.6.10rc1/include/linux/sched.h linux-2.6.10rc1-4level/include/linux/sched.h
--- linux-2.6.10rc1/include/linux/sched.h	2004-10-25 04:47:38.000000000 +0200
+++ linux-2.6.10rc1-4level/include/linux/sched.h	2004-10-25 04:48:10.000000000 +0200
@@ -211,7 +211,7 @@ struct mm_struct {
 	void (*unmap_area) (struct vm_area_struct *area);
 	unsigned long mmap_base;		/* base of mmap area */
 	unsigned long free_area_cache;		/* first hole */
-	pgd_t * pgd;
+	pml4_t * pml4;
 	atomic_t mm_users;			/* How many users with user space? */
 	atomic_t mm_count;			/* How many references to "struct mm_struct" (users count as 1) */
 	int map_count;				/* number of VMAs */
diff -urpN -X ../KDIFX linux-2.6.10rc1/kernel/fork.c linux-2.6.10rc1-4level/kernel/fork.c
--- linux-2.6.10rc1/kernel/fork.c	2004-10-25 04:47:38.000000000 +0200
+++ linux-2.6.10rc1-4level/kernel/fork.c	2004-10-25 04:48:10.000000000 +0200
@@ -261,15 +261,15 @@ fail_nomem:
 
 static inline int mm_alloc_pgd(struct mm_struct * mm)
 {
-	mm->pgd = pgd_alloc(mm);
-	if (unlikely(!mm->pgd))
+	mm->pml4 = pml4_alloc(mm);
+	if (unlikely(!mm->pml4))
 		return -ENOMEM;
 	return 0;
 }
 
 static inline void mm_free_pgd(struct mm_struct * mm)
 {
-	pgd_free(mm->pgd);
+	pml4_free(mm->pml4);
 }
 #else
 #define dup_mmap(mm, oldmm)	(0)
diff -urpN -X ../KDIFX linux-2.6.10rc1/mm/fremap.c linux-2.6.10rc1-4level/mm/fremap.c
--- linux-2.6.10rc1/mm/fremap.c	2004-10-25 04:47:38.000000000 +0200
+++ linux-2.6.10rc1-4level/mm/fremap.c	2004-10-25 04:48:10.000000000 +0200
@@ -64,9 +64,11 @@ int install_page(struct mm_struct *mm, s
 	pmd_t *pmd;
 	pte_t pte_val;
 
-	pgd = pgd_offset(mm, addr);
 	spin_lock(&mm->page_table_lock);
-
+	pgd = pgd_alloc(mm, pml4_offset(mm, addr), addr); 
+	if (!pgd) 
+	    goto err_unlock;
+	
 	pmd = pmd_alloc(mm, pgd, addr);
 	if (!pmd)
 		goto err_unlock;
@@ -111,13 +113,18 @@ int install_file_pte(struct mm_struct *m
 		unsigned long addr, unsigned long pgoff, pgprot_t prot)
 {
 	int err = -ENOMEM;
+	pml4_t *pml4;
 	pte_t *pte;
 	pgd_t *pgd;
 	pmd_t *pmd;
 	pte_t pte_val;
 
-	pgd = pgd_offset(mm, addr);
-	spin_lock(&mm->page_table_lock);
+	pml4 = pml4_offset(mm, addr); 
+
+	spin_lock(&mm->page_table_lock);  
+	pgd = pgd_alloc(mm, pml4, addr); 
+	if (!pgd) 
+		goto err_unlock;
 
 	pmd = pmd_alloc(mm, pgd, addr);
 	if (!pmd)
diff -urpN -X ../KDIFX linux-2.6.10rc1/mm/memory.c linux-2.6.10rc1-4level/mm/memory.c
--- linux-2.6.10rc1/mm/memory.c	2004-10-25 04:47:38.000000000 +0200
+++ linux-2.6.10rc1-4level/mm/memory.c	2004-10-25 05:17:14.000000000 +0200
@@ -34,6 +34,8 @@
  *
  * 16.07.99  -  Support of BIGMEM added by Gerhard Wichert, Siemens AG
  *		(Gerhard.Wichert@pdb.siemens.de)
+ *
+ * Aug/Sep 2004 Changed to four level page tables (Andi Kleen) 
  */
 
 #include <linux/kernel_stat.h>
@@ -137,21 +139,62 @@ static inline void free_one_pgd(struct m
 	pmd_free_tlb(tlb, pmd);
 }
 
+static inline void free_one_pml4(struct mmu_gather *tlb, pml4_t *pml4,
+				 unsigned long addr, unsigned long end) 
+{
+	int free;
+	pgd_t *pgd, *pgd_start;
+
+	if (pml4_none(*pml4))
+		return;
+	if (unlikely(pml4_bad(*pml4))) {
+		pml4_ERROR(*pml4);
+		pml4_clear(pml4);
+		return;
+	}
+	BUG_ON(addr & ~PGDIR_MASK);
+	BUG_ON(end & ~PGDIR_MASK);
+	pgd_start = pml4_pgd_offset(pml4, addr);
+	free = 0;
+	pgd = pgd_start;
+	do { 
+		free_one_pgd(tlb, pgd);
+		free++;
+		pgd++;
+		if (pgd - pgd_start >= PTRS_PER_PGD) 
+			break;
+		addr = (addr + PGDIR_SIZE) & PGDIR_MASK;
+	} while (addr && addr < end); 
+	/* Could keep a counter in the struct page here too to handle
+	   partials unmaps better. */
+	if (free == PTRS_PER_PGD) {
+		pml4_clear(pml4);
+		pgd_free_tlb(tlb, pgd_start);
+	}
+}
+
 /*
- * This function clears all user-level page tables of a process - this
- * is needed by execve(), so that old pages aren't in the way.
+ * This function clears user-level page tables of a process.
  *
  * Must be called with pagetable lock held.
+ * 
+ * This function is not exact and may clear less than the range if
+ * addr and end are not suitably aligned.
  */
-void clear_page_tables(struct mmu_gather *tlb, unsigned long first, int nr)
+void clear_page_range(struct mmu_gather *tlb, unsigned long addr, unsigned long end)
 {
-	pgd_t * page_dir = tlb->mm->pgd;
+	int i;
+	pml4_t *pml4 = tlb->mm->pml4;
+	unsigned long next;
 
-	page_dir += first;
-	do {
-		free_one_pgd(tlb, page_dir);
-		page_dir++;
-	} while (--nr);
+	for (i = pml4_index(addr); i <= pml4_index(end-1); i++) { 
+		next = (addr + PML4_SIZE) & PML4_MASK;
+		if (next > end || next <= addr) 
+			next = end; 
+		if (!(addr & ~PML4_MASK))
+			free_one_pml4(tlb, pml4 + i, addr, next);  
+		addr = next;
+	}
 }
 
 pte_t fastcall * pte_alloc_map(struct mm_struct *mm, pmd_t *pmd, unsigned long address)
@@ -164,6 +207,7 @@ pte_t fastcall * pte_alloc_map(struct mm
 		spin_lock(&mm->page_table_lock);
 		if (!new)
 			return NULL;
+
 		/*
 		 * Because we dropped the lock, we should re-check the
 		 * entry, as somebody else could have populated it..
@@ -204,164 +248,210 @@ pte_t fastcall * pte_alloc_kernel(struct
 out:
 	return pte_offset_kernel(pmd, address);
 }
-#define PTE_TABLE_MASK	((PTRS_PER_PTE-1) * sizeof(pte_t))
-#define PMD_TABLE_MASK	((PTRS_PER_PMD-1) * sizeof(pmd_t))
 
 /*
  * copy one vm_area from one task to the other. Assumes the page tables
  * already present in the new task to be cleared in the whole range
  * covered by this vma.
- *
- * 08Jan98 Merged into one routine from several inline routines to reduce
- *         variable count and make things faster. -jj
- *
+ * 
  * dst->page_table_lock is held on entry and exit,
- * but may be dropped within pmd_alloc() and pte_alloc_map().
+ * but may be dropped within p[mg]d_alloc() and pte_alloc_map().
  */
-int copy_page_range(struct mm_struct *dst, struct mm_struct *src,
-			struct vm_area_struct *vma)
-{
-	pgd_t * src_pgd, * dst_pgd;
-	unsigned long address = vma->vm_start;
-	unsigned long end = vma->vm_end;
-	unsigned long cow;
-
-	if (is_vm_hugetlb_page(vma))
-		return copy_hugetlb_page_range(dst, src, vma);
 
-	cow = (vma->vm_flags & (VM_SHARED | VM_MAYWRITE)) == VM_MAYWRITE;
-	src_pgd = pgd_offset(src, address)-1;
-	dst_pgd = pgd_offset(dst, address)-1;
+static inline void 
+copy_swap_pte(struct mm_struct *dst_mm, struct mm_struct *src_mm, pte_t pte) 
+{
+	if (pte_file(pte))
+		return;
+	swap_duplicate(pte_to_swp_entry(pte));
+	if (list_empty(&dst_mm->mmlist)) { 
+		spin_lock(&mmlist_lock);
+		list_add(&dst_mm->mmlist, &src_mm->mmlist);
+		spin_unlock(&mmlist_lock);
+	} 
+}
+	
+static inline void 
+copy_one_pte(struct mm_struct *dst_mm,  struct mm_struct *src_mm,
+	     pte_t *dst_pte, pte_t *src_pte, unsigned long vm_flags,
+	     unsigned long addr)
+{
+	pte_t pte = *src_pte;
+	struct page *page;
+	unsigned long pfn;
+	
+	/* pte contains position in swap, so copy. */
+	if (!pte_present(pte)) {
+		copy_swap_pte(dst_mm, src_mm, pte);
+		set_pte(dst_pte, pte);
+		return; 
+	}
+	pfn = pte_pfn(pte);
+	/* the pte points outside of valid memory, the
+	 * mapping is assumed to be good, meaningful
+	 * and not mapped via rmap - duplicate the
+	 * mapping as is.
+	 */
+	page = NULL;
+	if (pfn_valid(pfn)) 
+		page = pfn_to_page(pfn); 
+	
+	if (!page || PageReserved(page)) {
+		set_pte(dst_pte, pte);
+		return;
+	}
+	
+	/*
+	 * If it's a COW mapping, write protect it both
+	 * in the parent and the child
+	 */
+	if ((vm_flags & (VM_SHARED | VM_MAYWRITE)) == VM_MAYWRITE) {
+		ptep_set_wrprotect(src_pte);
+		pte = *src_pte;
+	}
+	
+	/*
+	 * If it's a shared mapping, mark it clean in
+	 * the child
+	 */
+	if (vm_flags & VM_SHARED)
+		pte = pte_mkclean(pte);
+	pte = pte_mkold(pte);
+	get_page(page);
+	dst_mm->rss++;
+	set_pte(dst_pte, pte);
+	page_dup_rmap(page);
+}
+
+static int copy_pte_range(struct mm_struct *dst_mm,  struct mm_struct *src_mm,
+			   pmd_t *dst_pmd, pmd_t *src_pmd, struct vm_area_struct *vma,
+			   unsigned long addr, unsigned long end)
+{
+	pte_t * src_pte, * dst_pte;
+	unsigned long vm_flags = vma->vm_flags;
+
+	dst_pte = pte_alloc_map(dst_mm, dst_pmd, addr);
+	if (!dst_pte)
+		return -ENOMEM;
+
+	spin_lock(&src_mm->page_table_lock);
+	src_pte = pte_offset_map_nested(src_pmd, addr);	
+	for (; 
+	     addr < end; 
+	     addr += PAGE_SIZE, src_pte++, dst_pte++) {
+		if (pte_none(*src_pte))
+			continue;
+		copy_one_pte(dst_mm, src_mm, dst_pte, src_pte, vm_flags, addr);
+	}
+	pte_unmap_nested(src_pte);
+	pte_unmap(dst_pte);
+	spin_unlock(&src_mm->page_table_lock);
+	cond_resched_lock(&dst_mm->page_table_lock);
+	return 0;
+}
 
-	for (;;) {
-		pmd_t * src_pmd, * dst_pmd;
+static int copy_pmd_range(struct mm_struct *dst_mm,  struct mm_struct *src_mm,
+			   pgd_t *dst_pgd, pgd_t *src_pgd, struct vm_area_struct *vma,
+			   unsigned long addr, unsigned long end)
+{
+	pmd_t *src_pmd, *dst_pmd;
+	int err = 0;
+	unsigned long next;
+
+	src_pmd = pmd_offset(src_pgd, addr);
+	dst_pmd = pmd_alloc(dst_mm, dst_pgd, addr);
+	if (!dst_pmd)
+		return -ENOMEM;
+	
+	for (; addr < end; addr = next, src_pmd++, dst_pmd++) {
+		next = (addr + PMD_SIZE) & PMD_MASK;
+		if (next > end) 
+			next = end; 
+		if (pmd_none(*src_pmd))
+			continue;
+		if (pmd_bad(*src_pmd)) { 
+			pmd_ERROR(*src_pmd);
+			pmd_clear(src_pmd);
+			continue;
+		}		
+		err = copy_pte_range(dst_mm, src_mm, dst_pmd, src_pmd, vma, addr, next);
+		if (err)
+			break;
+	}
+	return err;
+}
 
-		src_pgd++; dst_pgd++;
-		
-		/* copy_pmd_range */
-		
+static int copy_pgd_range(struct mm_struct *dst_mm,  struct mm_struct *src_mm,
+			   pml4_t *dst, pml4_t *src, struct vm_area_struct *vma,
+			   unsigned long addr, unsigned long end)
+{
+	pgd_t *src_pgd, *dst_pgd;
+	int err = 0;
+	unsigned long next;
+
+	src_pgd = pml4_pgd_offset(src, addr);
+	dst_pgd = pgd_alloc(dst_mm, dst, addr);
+	if (!dst_pgd)
+		return -ENOMEM;
+
+	for (; addr < end; addr = next, src_pgd++, dst_pgd++) {
+		next = (addr + PGDIR_SIZE) & PGDIR_MASK;
+		if (next > end) 
+			next = end;
 		if (pgd_none(*src_pgd))
-			goto skip_copy_pmd_range;
-		if (unlikely(pgd_bad(*src_pgd))) {
+			continue;
+		if (pgd_bad(*src_pgd)) { 
 			pgd_ERROR(*src_pgd);
 			pgd_clear(src_pgd);
-skip_copy_pmd_range:	address = (address + PGDIR_SIZE) & PGDIR_MASK;
-			if (!address || (address >= end))
-				goto out;
 			continue;
 		}
+		err = copy_pmd_range(dst_mm, src_mm, dst_pgd, src_pgd, vma, 
+				     addr, next);
+		if (err)
+			break;
+	}
+	return err;
+}
 
-		src_pmd = pmd_offset(src_pgd, address);
-		dst_pmd = pmd_alloc(dst, dst_pgd, address);
-		if (!dst_pmd)
-			goto nomem;
-
-		do {
-			pte_t * src_pte, * dst_pte;
-		
-			/* copy_pte_range */
-		
-			if (pmd_none(*src_pmd))
-				goto skip_copy_pte_range;
-			if (unlikely(pmd_bad(*src_pmd))) {
-				pmd_ERROR(*src_pmd);
-				pmd_clear(src_pmd);
-skip_copy_pte_range:
-				address = (address + PMD_SIZE) & PMD_MASK;
-				if (address >= end)
-					goto out;
-				goto cont_copy_pmd_range;
-			}
+int copy_page_range(struct mm_struct *dst, struct mm_struct *src, struct vm_area_struct *vma)
+{
+	pml4_t *src_pml4, *dst_pml4;
+	unsigned long addr, start, end, next;
+	int err = 0;
+	int i;
 
-			dst_pte = pte_alloc_map(dst, dst_pmd, address);
-			if (!dst_pte)
-				goto nomem;
-			spin_lock(&src->page_table_lock);	
-			src_pte = pte_offset_map_nested(src_pmd, address);
-			do {
-				pte_t pte = *src_pte;
-				struct page *page;
-				unsigned long pfn;
-
-				/* copy_one_pte */
-
-				if (pte_none(pte))
-					goto cont_copy_pte_range_noset;
-				/* pte contains position in swap, so copy. */
-				if (!pte_present(pte)) {
-					if (!pte_file(pte)) {
-						swap_duplicate(pte_to_swp_entry(pte));
-						if (list_empty(&dst->mmlist)) {
-							spin_lock(&mmlist_lock);
-							list_add(&dst->mmlist,
-								 &src->mmlist);
-							spin_unlock(&mmlist_lock);
-						}
-					}
-					set_pte(dst_pte, pte);
-					goto cont_copy_pte_range_noset;
-				}
-				pfn = pte_pfn(pte);
-				/* the pte points outside of valid memory, the
-				 * mapping is assumed to be good, meaningful
-				 * and not mapped via rmap - duplicate the
-				 * mapping as is.
-				 */
-				page = NULL;
-				if (pfn_valid(pfn)) 
-					page = pfn_to_page(pfn); 
-
-				if (!page || PageReserved(page)) {
-					set_pte(dst_pte, pte);
-					goto cont_copy_pte_range_noset;
-				}
+	if (is_vm_hugetlb_page(vma))
+		return copy_hugetlb_page_range(dst, src, vma);
 
-				/*
-				 * If it's a COW mapping, write protect it both
-				 * in the parent and the child
-				 */
-				if (cow) {
-					ptep_set_wrprotect(src_pte);
-					pte = *src_pte;
-				}
+	start = vma->vm_start; 
+	src_pml4 = pml4_offset(src, start); 
+	dst_pml4 = pml4_offset(dst, start);
+
+	end = vma->vm_end;
+	addr = start; 
+	/* Adding PML4_SIZE can wrap on ports with less than 4 levels. */
+	for (i = pml4_index(addr); 
+	     i <= pml4_index(end-1); 
+	     i++, addr = next, src_pml4++, dst_pml4++) { 
+		next = (addr + PML4_SIZE) & PML4_MASK;
+		if (next > end || next <= addr) 
+			next = end;
+		if (pml4_none(*src_pml4)) 
+			continue; 
+		if (pml4_bad(*src_pml4)) { 
+			pml4_ERROR(*src_pml4); 
+			pml4_clear(src_pml4);
+			continue; 
+		}		
+		err = copy_pgd_range(dst, src, 
+				     dst_pml4, src_pml4, vma, addr, 
+				     next); 
+		if (err) 
+			break; 
+	}	
 
-				/*
-				 * If it's a shared mapping, mark it clean in
-				 * the child
-				 */
-				if (vma->vm_flags & VM_SHARED)
-					pte = pte_mkclean(pte);
-				pte = pte_mkold(pte);
-				get_page(page);
-				dst->rss++;
-				set_pte(dst_pte, pte);
-				page_dup_rmap(page);
-cont_copy_pte_range_noset:
-				address += PAGE_SIZE;
-				if (address >= end) {
-					pte_unmap_nested(src_pte);
-					pte_unmap(dst_pte);
-					goto out_unlock;
-				}
-				src_pte++;
-				dst_pte++;
-			} while ((unsigned long)src_pte & PTE_TABLE_MASK);
-			pte_unmap_nested(src_pte-1);
-			pte_unmap(dst_pte-1);
-			spin_unlock(&src->page_table_lock);
-			cond_resched_lock(&dst->page_table_lock);
-cont_copy_pmd_range:
-			src_pmd++;
-			dst_pmd++;
-		} while ((unsigned long)src_pmd & PMD_TABLE_MASK);
-	}
-out_unlock:
-	spin_unlock(&src->page_table_lock);
-out:
-	return 0;
-nomem:
-	return -ENOMEM;
-}
+	return err;
+} 
 
 static void zap_pte_range(struct mmu_gather *tlb,
 		pmd_t *pmd, unsigned long address,
@@ -469,20 +559,46 @@ static void zap_pmd_range(struct mmu_gat
 	} while (address && (address < end));
 }
 
+static void zap_pgd_range(struct mmu_gather *tlb,
+		pml4_t *pml4, unsigned long address,
+		unsigned long end, struct zap_details *details)
+{
+	pgd_t * pgd;
+
+	if (pml4_none(*pml4))
+		return;
+	if (unlikely(pml4_bad(*pml4))) {
+		pml4_ERROR(*pml4);
+		pml4_clear(pml4);
+		return;
+	}
+	pgd = pml4_pgd_offset(pml4, address);
+	do {
+		zap_pmd_range(tlb, pgd, address, end - address, details);
+		address = (address + PGDIR_SIZE) & PGDIR_MASK; 
+		pgd++;
+	} while (address && (address < end));
+}
+
 static void unmap_page_range(struct mmu_gather *tlb,
 		struct vm_area_struct *vma, unsigned long address,
 		unsigned long end, struct zap_details *details)
 {
-	pgd_t * dir;
+	unsigned long next;
+	pml4_t *pml4;
+	int i;
 
 	BUG_ON(address >= end);
-	dir = pgd_offset(vma->vm_mm, address);
+	pml4 = pml4_offset(vma->vm_mm, address);
 	tlb_start_vma(tlb, vma);
-	do {
-		zap_pmd_range(tlb, dir, address, end - address, details);
-		address = (address + PGDIR_SIZE) & PGDIR_MASK;
-		dir++;
-	} while (address && (address < end));
+	for (i = pml4_index(address); i <= pml4_index(end-1); i++) { 
+		next = (address + PML4_SIZE) & PML4_MASK;
+		if (next <= address || next > end) 
+			next = end; 
+		zap_pgd_range(tlb, pml4, address, next, details);
+		address = next;
+		pml4++;
+	}
 	tlb_end_vma(tlb, vma);
 }
 
@@ -623,6 +739,7 @@ void zap_page_range(struct vm_area_struc
 struct page *
 follow_page(struct mm_struct *mm, unsigned long address, int write) 
 {
+	pml4_t *pml4;
 	pgd_t *pgd;
 	pmd_t *pmd;
 	pte_t *ptep, pte;
@@ -633,7 +750,16 @@ follow_page(struct mm_struct *mm, unsign
 	if (! IS_ERR(page))
 		return page;
 
-	pgd = pgd_offset(mm, address);
+	pml4 = pml4_offset(mm, address);
+	if (pml4_bad(*pml4)) { 
+		pml4_ERROR(*pml4);
+		pml4_clear(pml4); 
+		goto out;
+	}			
+	if (pml4_none(*pml4))
+		goto out; 
+
+	pgd = pml4_pgd_offset(pml4, address);
 	if (pgd_none(*pgd) || unlikely(pgd_bad(*pgd)))
 		goto out;
 
@@ -686,6 +812,7 @@ static inline int
 untouched_anonymous_page(struct mm_struct* mm, struct vm_area_struct *vma,
 			 unsigned long address)
 {
+	pml4_t *pml4;
 	pgd_t *pgd;
 	pmd_t *pmd;
 
@@ -694,7 +821,16 @@ untouched_anonymous_page(struct mm_struc
 		return 0;
 
 	/* Check if page directory entry exists. */
-	pgd = pgd_offset(mm, address);
+	pml4 = pml4_offset(mm, address);
+	if (pml4_bad(*pml4)) { 
+		pml4_ERROR(*pml4);
+		pml4_clear(pml4);
+		return 1;
+	}
+	if (pml4_none(*pml4))
+		return 1;
+
+	pgd = pml4_pgd_offset(pml4, address);
 	if (pgd_none(*pgd) || unlikely(pgd_bad(*pgd)))
 		return 1;
 
@@ -733,17 +869,21 @@ int get_user_pages(struct task_struct *t
 			pgd_t *pgd;
 			pmd_t *pmd;
 			pte_t *pte;
+			pml4_t *pml4;
 			if (write) /* user gate pages are read-only */
 				return i ? : -EFAULT;
-			pgd = pgd_offset_gate(mm, pg);
-			if (!pgd)
+			pml4 = pml4_offset_gate(mm, pg);
+			/* AK: BUG_ON would be more appropiate for the
+			   _none checks below. */
+			if (pml4_none(*pml4))
+				return i ? : -EFAULT;
+			pgd = pml4_pgd_offset(pml4, pg);
+			if (pgd_none(*pgd))
 				return i ? : -EFAULT;
 			pmd = pmd_offset(pgd, pg);
-			if (!pmd)
+			if (pmd_none(*pmd))
 				return i ? : -EFAULT;
 			pte = pte_offset_map(pmd, pg);
-			if (!pte)
-				return i ? : -EFAULT;
 			if (!pte_present(*pte)) {
 				pte_unmap(pte);
 				return i ? : -EFAULT;
@@ -879,31 +1019,56 @@ static inline int zeromap_pmd_range(stru
 	return 0;
 }
 
+static inline int zeromap_pgd_range(struct mm_struct *mm, pgd_t * pgd, 
+				    unsigned long address,
+                                    unsigned long size, pgprot_t prot)
+{
+	unsigned long base, end;
+
+	base = address & PML4_MASK;
+	address &= ~PML4_MASK;
+	end = address + size;
+	do {
+		pmd_t * pmd = pmd_alloc(mm, pgd, base + address);
+		if (!pgd)
+			return -ENOMEM;
+		zeromap_pmd_range(mm, pmd, address, end - address, prot);
+		address = (address + PGDIR_SIZE) & PGDIR_MASK;
+		pgd++;
+	} while (address && (address < end));
+	return 0;
+}
+
 int zeromap_page_range(struct vm_area_struct *vma, unsigned long address, unsigned long size, pgprot_t prot)
 {
+	int i;
 	int error = 0;
-	pgd_t * dir;
+	pml4_t *pml4;
 	unsigned long beg = address;
 	unsigned long end = address + size;
+	unsigned long next;
 	struct mm_struct *mm = vma->vm_mm;
 
-	dir = pgd_offset(mm, address);
+	pml4 = pml4_offset(mm, address);
 	flush_cache_range(vma, beg, end);
-	if (address >= end)
-		BUG();
+	BUG_ON(address >= end);
+	BUG_ON(end > vma->vm_end);
 
 	spin_lock(&mm->page_table_lock);
-	do {
-		pmd_t *pmd = pmd_alloc(mm, dir, address);
+	for (i = pml4_index(address); i <= pml4_index(end-1); i++) { 
+		pgd_t *pgd = pgd_alloc(mm, pml4, address);
 		error = -ENOMEM;
-		if (!pmd)
+		if (!pgd)
 			break;
-		error = zeromap_pmd_range(mm, pmd, address, end - address, prot);
+		next = (address + PML4_SIZE) & PML4_MASK;
+		if (next <= beg || next > end) 
+			next = end;
+		error = zeromap_pgd_range(mm, pgd, address, next - address, prot);
 		if (error)
 			break;
-		address = (address + PGDIR_SIZE) & PGDIR_MASK;
-		dir++;
-	} while (address && (address < end));
+		address = next;
+		pml4++;
+	}
 	/*
 	 * Why flush? zeromap_pte_range has a BUG_ON for !pte_none()
 	 */
@@ -917,8 +1082,9 @@ int zeromap_page_range(struct vm_area_st
  * mappings are removed. any references to nonexistent pages results
  * in null mappings (currently treated as "copy-on-access")
  */
-static inline void remap_pte_range(pte_t * pte, unsigned long address, unsigned long size,
-	unsigned long pfn, pgprot_t prot)
+static inline void 
+remap_pte_range(pte_t * pte, unsigned long address, unsigned long size,
+		unsigned long pfn, pgprot_t prot)
 {
 	unsigned long end;
 
@@ -936,8 +1102,9 @@ static inline void remap_pte_range(pte_t
 	} while (address && (address < end));
 }
 
-static inline int remap_pmd_range(struct mm_struct *mm, pmd_t * pmd, unsigned long address, unsigned long size,
-	unsigned long pfn, pgprot_t prot)
+static inline int 
+remap_pmd_range(struct mm_struct *mm, pmd_t * pmd, unsigned long address, 
+		unsigned long size, unsigned long pfn, pgprot_t prot)
 {
 	unsigned long base, end;
 
@@ -946,12 +1113,13 @@ static inline int remap_pmd_range(struct
 	end = address + size;
 	if (end > PGDIR_SIZE)
 		end = PGDIR_SIZE;
-	pfn -= address >> PAGE_SHIFT;
+	pfn -= (address >> PAGE_SHIFT);
 	do {
 		pte_t * pte = pte_alloc_map(mm, pmd, base + address);
 		if (!pte)
 			return -ENOMEM;
-		remap_pte_range(pte, base + address, end - address, pfn + (address >> PAGE_SHIFT), prot);
+		remap_pte_range(pte, base + address, end - address, 
+				(address >> PAGE_SHIFT) + pfn, prot);
 		pte_unmap(pte);
 		address = (address + PMD_SIZE) & PMD_MASK;
 		pmd++;
@@ -959,17 +1127,43 @@ static inline int remap_pmd_range(struct
 	return 0;
 }
 
+static inline int remap_pgd_range(struct mm_struct *mm, pgd_t * pgd, 
+				  unsigned long address, unsigned long size,
+				  unsigned long pfn, pgprot_t prot)
+{
+	unsigned long base, end;
+
+	base = address & PML4_MASK;
+	address &= ~PML4_MASK;
+	end = address + size;
+	pfn -= address >> PAGE_SHIFT;
+	do {
+		pmd_t *pmd = pmd_alloc(mm, pgd, base+address);
+		if (!pmd)
+			return -ENOMEM;
+		remap_pmd_range(mm, pmd, base + address, end - address, 
+				(address >> PAGE_SHIFT) + pfn, prot);
+		address = (address + PGDIR_SIZE) & PGDIR_MASK;
+		pgd++;
+	} while (address && (address < end));
+	return 0;
+}
+
 /*  Note: this is only safe if the mm semaphore is held when called. */
-int remap_pfn_range(struct vm_area_struct *vma, unsigned long from, unsigned long pfn, unsigned long size, pgprot_t prot)
+int remap_pfn_range(struct vm_area_struct *vma, unsigned long from, 
+		    unsigned long pfn, unsigned long size, 
+		    pgprot_t prot)
 {
 	int error = 0;
-	pgd_t * dir;
+	pml4_t *pml4;
 	unsigned long beg = from;
 	unsigned long end = from + size;
+	unsigned long next;
 	struct mm_struct *mm = vma->vm_mm;
+	int i;
 
 	pfn -= from >> PAGE_SHIFT;
-	dir = pgd_offset(mm, from);
+	pml4 = pml4_offset(mm, from);
 	flush_cache_range(vma, beg, end);
 	if (from >= end)
 		BUG();
@@ -983,25 +1177,32 @@ int remap_pfn_range(struct vm_area_struc
 	 *	this region.
 	 */
 	vma->vm_flags |= VM_IO | VM_RESERVED;
+
 	spin_lock(&mm->page_table_lock);
-	do {
-		pmd_t *pmd = pmd_alloc(mm, dir, from);
+	for (i = pml4_index(beg); i <= pml4_index(end-1); i++) { 
+		pgd_t *pgd = pgd_alloc(mm, pml4, from);
 		error = -ENOMEM;
-		if (!pmd)
+		if (!pgd)
 			break;
-		error = remap_pmd_range(mm, pmd, from, end - from, pfn + (from >> PAGE_SHIFT), prot);
+		next = (from + PML4_SIZE) & PML4_MASK;
+		if (next > end || next <= from)
+			next = end;
+		error = remap_pgd_range(mm, pgd, from, end - from, 
+					pfn + (from >> PAGE_SHIFT), prot);
 		if (error)
 			break;
-		from = (from + PGDIR_SIZE) & PGDIR_MASK;
-		dir++;
-	} while (from && (from < end));
+		from = next;
+		pml4++;
+	}
 	/*
 	 * Why flush? remap_pte_range has a BUG_ON for !pte_none()
 	 */
 	flush_tlb_range(vma, beg, end);
 	spin_unlock(&mm->page_table_lock);
+
 	return error;
 }
+
 EXPORT_SYMBOL(remap_pfn_range);
 
 /*
@@ -1693,11 +1894,11 @@ static inline int handle_pte_fault(struc
 int handle_mm_fault(struct mm_struct *mm, struct vm_area_struct * vma,
 	unsigned long address, int write_access)
 {
+	pml4_t *pml4;
 	pgd_t *pgd;
 	pmd_t *pmd;
 
 	__set_current_state(TASK_RUNNING);
-	pgd = pgd_offset(mm, address);
 
 	inc_page_state(pgfault);
 
@@ -1708,14 +1909,21 @@ int handle_mm_fault(struct mm_struct *mm
 	 * We need the page table lock to synchronize with kswapd
 	 * and the SMP-safe atomic PTE updates.
 	 */
+	pml4 = pml4_offset(mm, address);
 	spin_lock(&mm->page_table_lock);
-	pmd = pmd_alloc(mm, pgd, address);
 
+	pgd = pgd_alloc(mm, pml4, address);
+	if (!pgd)
+		goto oom; 
+
+	pmd = pmd_alloc(mm, pgd, address);
 	if (pmd) {
 		pte_t * pte = pte_alloc_map(mm, pmd, address);
 		if (pte)
 			return handle_pte_fault(mm, vma, address, write_access, pte, pmd);
 	}
+
+ oom: 
 	spin_unlock(&mm->page_table_lock);
 	return VM_FAULT_OOM;
 }
@@ -1752,6 +1960,29 @@ out:
 	return pmd_offset(pgd, address);
 }
 
+#if PTRS_PER_PML4 > 1
+pgd_t fastcall *__pgd_alloc(struct mm_struct *mm, pml4_t *pml4, unsigned long address)
+{
+	pgd_t *new;
+
+	spin_unlock(&mm->page_table_lock);
+	new = pgd_alloc_one(mm, address);
+	spin_lock(&mm->page_table_lock);
+	if (!new)
+		return NULL;
+
+	/*
+	 * Because we dropped the lock, we should re-check the
+	 * entry, as somebody else could have populated it..
+	 */
+	if (pml4_present(*pml4))
+		pgd_free(new);
+	else
+		pml4_populate(mm, pml4, new);
+	return pml4_pgd_offset(pml4, address);
+}
+#endif
+
 int make_pages_present(unsigned long addr, unsigned long end)
 {
 	int ret, len, write;
@@ -1780,10 +2011,15 @@ struct page * vmalloc_to_page(void * vma
 {
 	unsigned long addr = (unsigned long) vmalloc_addr;
 	struct page *page = NULL;
-	pgd_t *pgd = pgd_offset_k(addr);
+	pml4_t *pml4 = pml4_offset_k(addr);
+	pgd_t *pgd;
 	pmd_t *pmd;
 	pte_t *ptep, pte;
   
+	if (pml4_none(*pml4))
+		return NULL;
+	pgd = pml4_pgd_offset_k(pml4, addr);
+
 	if (!pgd_none(*pgd)) {
 		pmd = pmd_offset(pgd, addr);
 		if (!pmd_none(*pmd)) {
diff -urpN -X ../KDIFX linux-2.6.10rc1/mm/mempolicy.c linux-2.6.10rc1-4level/mm/mempolicy.c
--- linux-2.6.10rc1/mm/mempolicy.c	2004-10-25 04:47:38.000000000 +0200
+++ linux-2.6.10rc1-4level/mm/mempolicy.c	2004-10-25 04:48:10.000000000 +0200
@@ -233,13 +233,24 @@ static struct mempolicy *mpol_new(int mo
 
 /* Ensure all existing pages follow the policy. */
 static int
-verify_pages(unsigned long addr, unsigned long end, unsigned long *nodes)
+verify_pages(struct mm_struct *mm,
+	     unsigned long addr, unsigned long end, unsigned long *nodes)
 {
 	while (addr < end) {
 		struct page *p;
 		pte_t *pte;
 		pmd_t *pmd;
-		pgd_t *pgd = pgd_offset_k(addr);
+		pgd_t *pgd;
+		pml4_t *pml4;
+		pml4 = pml4_offset(mm, addr); 
+		if (pml4_none(*pml4)) { 
+			unsigned long next = (addr + PML4_SIZE) & PML4_MASK; 
+			if (next > addr)
+				break;
+			addr = next;
+			continue;
+		} 
+		pgd = pml4_pgd_offset(pml4, addr);
 		if (pgd_none(*pgd)) {
 			addr = (addr + PGDIR_SIZE) & PGDIR_MASK;
 			continue;
@@ -282,7 +293,8 @@ check_range(struct mm_struct *mm, unsign
 		if (prev && prev->vm_end < vma->vm_start)
 			return ERR_PTR(-EFAULT);
 		if ((flags & MPOL_MF_STRICT) && !is_vm_hugetlb_page(vma)) {
-			err = verify_pages(vma->vm_start, vma->vm_end, nodes);
+			err = verify_pages(vma->vm_mm, 
+					   vma->vm_start, vma->vm_end, nodes);
 			if (err) {
 				first = ERR_PTR(err);
 				break;
diff -urpN -X ../KDIFX linux-2.6.10rc1/mm/mmap.c linux-2.6.10rc1-4level/mm/mmap.c
--- linux-2.6.10rc1/mm/mmap.c	2004-10-25 04:47:38.000000000 +0200
+++ linux-2.6.10rc1-4level/mm/mmap.c	2004-10-25 04:48:10.000000000 +0200
@@ -1459,7 +1459,7 @@ find_extend_vma(struct mm_struct * mm, u
  * the page tables themselves.
  *
  * Right now we try to free page tables if we have a nice
- * PGDIR-aligned area that got free'd up. We could be more
+ * PGD/PML4-aligned area that got free'd up. We could be more
  * granular if we want to, but this is fast and simple,
  * and covers the bad cases.
  *
@@ -1471,7 +1471,7 @@ static void free_pgtables(struct mmu_gat
 {
 	unsigned long first = start & PGDIR_MASK;
 	unsigned long last = end + PGDIR_SIZE - 1;
-	unsigned long start_index, end_index;
+	unsigned long start_pml4_index, start_pgd_index;
 	struct mm_struct *mm = tlb->mm;
 
 	if (!prev) {
@@ -1495,24 +1495,26 @@ static void free_pgtables(struct mmu_gat
 			if (last > next->vm_start)
 				last = next->vm_start;
 		}
-		if (prev->vm_end > first)
-			first = prev->vm_end + PGDIR_SIZE - 1;
+		if (prev->vm_end > first) {
+			first = prev->vm_end + PML4_SIZE - 1;
+			if (first < prev->vm_end) 
+				first = TASK_SIZE;
+		}
 		break;
 	}
 no_mmaps:
-	if (last < first)	/* for arches with discontiguous pgd indices */
+	if (last < first)	/* for arches with discontiguous indices */
 		return;
-	/*
-	 * If the PGD bits are not consecutive in the virtual address, the
-	 * old method of shifting the VA >> by PGDIR_SHIFT doesn't work.
-	 */
-	start_index = pgd_index(first);
-	if (start_index < FIRST_USER_PGD_NR)
-		start_index = FIRST_USER_PGD_NR;
-	end_index = pgd_index(last);
-	if (end_index > start_index) {
-		clear_page_tables(tlb, start_index, end_index - start_index);
-		flush_tlb_pgtables(mm, first & PGDIR_MASK, last & PGDIR_MASK);
+	start_pml4_index = pml4_index(first);
+	start_pgd_index = pgd_index(first);
+	if (start_pml4_index == 0 && start_pgd_index < FIRST_USER_PGD_NR) { 
+		start_pgd_index = FIRST_USER_PGD_NR;
+		first = start_pgd_index * PGDIR_SIZE;
+	}
+	if (pml4_index(last) > start_pml4_index || 
+	    pgd_index(last) > start_pgd_index) {
+		clear_page_range(tlb, first, last);
+		flush_tlb_pgtables(mm, first & PML4_MASK, last & PML4_MASK);
 	}
 }
 
@@ -1841,7 +1843,8 @@ void exit_mmap(struct mm_struct *mm)
 					~0UL, &nr_accounted, NULL);
 	vm_unacct_memory(nr_accounted);
 	BUG_ON(mm->map_count);	/* This is just debugging */
-	clear_page_tables(tlb, FIRST_USER_PGD_NR, USER_PTRS_PER_PGD);
+	clear_page_range(tlb, FIRST_USER_PGD_NR * PGDIR_SIZE, 
+			 (TASK_SIZE + PGDIR_SIZE - 1) & ~(PGDIR_SIZE - 1));
 	tlb_finish_mmu(tlb, 0, MM_VM_SIZE(mm));
 
 	vma = mm->mmap;
diff -urpN -X ../KDIFX linux-2.6.10rc1/mm/mprotect.c linux-2.6.10rc1-4level/mm/mprotect.c
--- linux-2.6.10rc1/mm/mprotect.c	2004-10-25 04:47:38.000000000 +0200
+++ linux-2.6.10rc1-4level/mm/mprotect.c	2004-10-25 04:48:10.000000000 +0200
@@ -87,23 +87,51 @@ change_pmd_range(pgd_t *pgd, unsigned lo
 	} while (address && (address < end));
 }
 
+static inline void
+change_pgd_range(pml4_t *pml4, unsigned long address,
+		unsigned long size, pgprot_t newprot)
+{
+	pgd_t * pgd;
+	unsigned long end;
+
+	if (pml4_none(*pml4))
+		return;
+	if (pml4_bad(*pml4)) {
+		pml4_ERROR(*pml4);
+		pml4_clear(pml4);
+		return;
+	}
+	pgd = pml4_pgd_offset(pml4, address);
+	address &= ~PML4_MASK;
+	end = address + size;
+	do {
+		change_pmd_range(pgd, address, end - address, newprot);
+		address = (address + PGDIR_SIZE) & PGDIR_MASK;
+		pgd++;
+	} while (address && (address < end));
+}
+
 static void
 change_protection(struct vm_area_struct *vma, unsigned long start,
 		unsigned long end, pgprot_t newprot)
 {
-	pgd_t *dir;
-	unsigned long beg = start;
+	pml4_t *pml4; 
+	unsigned long beg = start, next;
+	int i;
 
-	dir = pgd_offset(current->mm, start);
+	pml4 = pml4_offset(current->mm, start);
 	flush_cache_range(vma, beg, end);
 	if (start >= end)
 		BUG();
 	spin_lock(&current->mm->page_table_lock);
-	do {
-		change_pmd_range(dir, start, end - start, newprot);
-		start = (start + PGDIR_SIZE) & PGDIR_MASK;
-		dir++;
-	} while (start && (start < end));
+	for (i = pml4_index(start); i <= pml4_index(end-1); i++) { 
+		next = (start + PML4_SIZE) & PML4_MASK;
+		if (next <= start || next > end)
+			next = end;
+		change_pgd_range(pml4, start, next - start, newprot);
+		start = next;
+		pml4++;
+	}
 	flush_tlb_range(vma, beg, end);
 	spin_unlock(&current->mm->page_table_lock);
 	return;
diff -urpN -X ../KDIFX linux-2.6.10rc1/mm/mremap.c linux-2.6.10rc1-4level/mm/mremap.c
--- linux-2.6.10rc1/mm/mremap.c	2004-10-25 04:47:38.000000000 +0200
+++ linux-2.6.10rc1-4level/mm/mremap.c	2004-10-25 04:48:10.000000000 +0200
@@ -24,11 +24,16 @@
 
 static pte_t *get_one_pte_map_nested(struct mm_struct *mm, unsigned long addr)
 {
+	pml4_t *pml4;
 	pgd_t *pgd;
 	pmd_t *pmd;
 	pte_t *pte = NULL;
 
-	pgd = pgd_offset(mm, addr);
+	pml4 = pml4_offset(mm, addr);
+	if (pml4_none(*pml4))
+		goto end;	
+
+	pgd = pml4_pgd_offset(pml4, addr);
 	if (pgd_none(*pgd))
 		goto end;
 	if (pgd_bad(*pgd)) {
@@ -57,10 +62,15 @@ end:
 
 static pte_t *get_one_pte_map(struct mm_struct *mm, unsigned long addr)
 {
+	pml4_t *pml4;
 	pgd_t *pgd;
 	pmd_t *pmd;
 
-	pgd = pgd_offset(mm, addr);
+	pml4 = pml4_offset(mm, addr);
+	if (pml4_none(*pml4))
+		return NULL;
+	
+	pgd = pml4_pgd_offset(pml4, addr);
 	if (pgd_none(*pgd))
 		return NULL;
 	pmd = pmd_offset(pgd, addr);
@@ -71,10 +81,15 @@ static pte_t *get_one_pte_map(struct mm_
 
 static inline pte_t *alloc_one_pte_map(struct mm_struct *mm, unsigned long addr)
 {
+	pgd_t *pgd; 
 	pmd_t *pmd;
 	pte_t *pte = NULL;
 
-	pmd = pmd_alloc(mm, pgd_offset(mm, addr), addr);
+	pgd = pgd_alloc(mm, pml4_offset(mm,addr), addr);
+	if (!pgd) 
+		return NULL;
+
+	pmd = pmd_alloc(mm, pgd, addr);
 	if (pmd)
 		pte = pte_alloc_map(mm, pmd, addr);
 	return pte;
diff -urpN -X ../KDIFX linux-2.6.10rc1/mm/msync.c linux-2.6.10rc1-4level/mm/msync.c
--- linux-2.6.10rc1/mm/msync.c	2004-10-25 04:47:38.000000000 +0200
+++ linux-2.6.10rc1-4level/mm/msync.c	2004-10-25 04:48:10.000000000 +0200
@@ -93,11 +93,37 @@ static inline int filemap_sync_pmd_range
 	return error;
 }
 
+static inline int filemap_sync_pgd_range(pml4_t *pml4,
+	unsigned long address, unsigned long end, 
+	struct vm_area_struct *vma, unsigned int flags)
+{
+	pgd_t *pgd;
+	int error;
+
+	if (pml4_none(*pml4))
+		return 0;
+	if (pml4_bad(*pml4)) {
+		pml4_ERROR(*pml4);
+		pml4_clear(pml4);
+		return 0;
+	}
+	pgd = pml4_pgd_offset(pml4, address);
+	error = 0;
+	do {
+		error |= filemap_sync_pmd_range(pgd, address, end, vma, flags);
+		address = (address + PGDIR_SIZE) & PGDIR_MASK;
+		pgd++;
+	} while (address && (address < end));
+	return error;
+}
+
 static int filemap_sync(struct vm_area_struct * vma, unsigned long address,
 	size_t size, unsigned int flags)
 {
-	pgd_t * dir;
+	pml4_t *pml4;
 	unsigned long end = address + size;
+	unsigned long next;
+	int i;
 	int error = 0;
 
 	/* Aquire the lock early; it may be possible to avoid dropping
@@ -105,7 +131,7 @@ static int filemap_sync(struct vm_area_s
 	 */
 	spin_lock(&vma->vm_mm->page_table_lock);
 
-	dir = pgd_offset(vma->vm_mm, address);
+	pml4 = pml4_offset(vma->vm_mm, address); 
 	flush_cache_range(vma, address, end);
 
 	/* For hugepages we can't go walking the page table normally,
@@ -116,11 +142,14 @@ static int filemap_sync(struct vm_area_s
 
 	if (address >= end)
 		BUG();
-	do {
-		error |= filemap_sync_pmd_range(dir, address, end, vma, flags);
-		address = (address + PGDIR_SIZE) & PGDIR_MASK;
-		dir++;
-	} while (address && (address < end));
+	for (i = pml4_index(address); i <= pml4_index(end-1); i++) { 
+		next = (address + PML4_SIZE) & PML4_MASK;
+		if (next <= address || next > end) 
+			next = end;
+		error |= filemap_sync_pgd_range(pml4, address, next, vma, flags);
+		address = next;
+		pml4++;
+	}
 	/*
 	 * Why flush ? filemap_sync_pte already flushed the tlbs with the
 	 * dirty bits.
diff -urpN -X ../KDIFX linux-2.6.10rc1/mm/rmap.c linux-2.6.10rc1-4level/mm/rmap.c
--- linux-2.6.10rc1/mm/rmap.c	2004-10-25 04:47:38.000000000 +0200
+++ linux-2.6.10rc1-4level/mm/rmap.c	2004-10-25 04:48:10.000000000 +0200
@@ -258,6 +258,7 @@ static int page_referenced_one(struct pa
 {
 	struct mm_struct *mm = vma->vm_mm;
 	unsigned long address;
+	pml4_t *pml4;
 	pgd_t *pgd;
 	pmd_t *pmd;
 	pte_t *pte;
@@ -271,7 +272,11 @@ static int page_referenced_one(struct pa
 
 	spin_lock(&mm->page_table_lock);
 
-	pgd = pgd_offset(mm, address);
+	pml4 = pml4_offset(mm, address);
+	if (!pml4_present(*pml4))
+		goto out_unlock; 
+
+	pgd = pml4_pgd_offset(pml4, address);
 	if (!pgd_present(*pgd))
 		goto out_unlock;
 
@@ -496,6 +501,7 @@ static int try_to_unmap_one(struct page 
 {
 	struct mm_struct *mm = vma->vm_mm;
 	unsigned long address;
+	pml4_t *pml4;
 	pgd_t *pgd;
 	pmd_t *pmd;
 	pte_t *pte;
@@ -514,7 +520,11 @@ static int try_to_unmap_one(struct page 
 	 */
 	spin_lock(&mm->page_table_lock);
 
-	pgd = pgd_offset(mm, address);
+	pml4 = pml4_offset(mm, address);
+	if (!pml4_present(*pml4))
+		goto out_unlock; 
+
+	pgd = pml4_pgd_offset(pml4, address);
 	if (!pgd_present(*pgd))
 		goto out_unlock;
 
@@ -624,6 +634,7 @@ static void try_to_unmap_cluster(unsigne
 	unsigned int *mapcount, struct vm_area_struct *vma)
 {
 	struct mm_struct *mm = vma->vm_mm;
+	pml4_t *pml4;
 	pgd_t *pgd;
 	pmd_t *pmd;
 	pte_t *pte;
@@ -646,7 +657,11 @@ static void try_to_unmap_cluster(unsigne
 	if (end > vma->vm_end)
 		end = vma->vm_end;
 
-	pgd = pgd_offset(mm, address);
+	pml4 = pml4_offset(mm, address);
+	if (!pml4_present(*pml4))
+		goto out_unlock;
+
+	pgd = pml4_pgd_offset(pml4, address);
 	if (!pgd_present(*pgd))
 		goto out_unlock;
 
diff -urpN -X ../KDIFX linux-2.6.10rc1/mm/swapfile.c linux-2.6.10rc1-4level/mm/swapfile.c
--- linux-2.6.10rc1/mm/swapfile.c	2004-10-25 04:47:38.000000000 +0200
+++ linux-2.6.10rc1-4level/mm/swapfile.c	2004-10-25 04:48:10.000000000 +0200
@@ -487,11 +487,11 @@ static unsigned long unuse_pmd(struct vm
 
 /* vma->vm_mm->page_table_lock is held */
 static unsigned long unuse_pgd(struct vm_area_struct * vma, pgd_t *dir,
-	unsigned long address, unsigned long size,
+        unsigned long address, unsigned long size, unsigned long offset,
 	swp_entry_t entry, struct page *page)
 {
 	pmd_t * pmd;
-	unsigned long offset, end;
+	unsigned long end;
 	unsigned long foundaddr;
 
 	if (pgd_none(*dir))
@@ -502,7 +502,7 @@ static unsigned long unuse_pgd(struct vm
 		return 0;
 	}
 	pmd = pmd_offset(dir, address);
-	offset = address & PGDIR_MASK;
+	offset += address & PGDIR_MASK;
 	address &= ~PGDIR_MASK;
 	end = address + size;
 	if (end > PGDIR_SIZE)
@@ -521,12 +521,46 @@ static unsigned long unuse_pgd(struct vm
 }
 
 /* vma->vm_mm->page_table_lock is held */
+static unsigned long unuse_pml4(struct vm_area_struct * vma, pml4_t *pml4,
+	unsigned long address, unsigned long size,
+	swp_entry_t entry, struct page *page)
+{
+	pgd_t * pgd;
+	unsigned long offset;
+	unsigned long foundaddr;
+	unsigned long end;
+
+	if (pml4_none(*pml4))
+		return 0;
+	if (pml4_bad(*pml4)) {
+		pml4_ERROR(*pml4);
+		pml4_clear(pml4);
+		return 0;
+	}
+	pgd = pml4_pgd_offset(pml4, address);
+	offset = address & PML4_MASK;
+	address &= ~PML4_MASK;
+	end = address + size;
+	BUG_ON (address >= end);
+	do {
+		foundaddr = unuse_pgd(vma, pgd, address, end - address,
+					        offset, entry, page);
+		if (foundaddr)
+			return foundaddr;
+		address = (address + PGDIR_SIZE) & PGDIR_MASK;
+		pgd++;
+	} while (address && (address < end));
+	return 0;
+}
+
+/* vma->vm_mm->page_table_lock is held */
 static unsigned long unuse_vma(struct vm_area_struct * vma,
 	swp_entry_t entry, struct page *page)
 {
-	pgd_t *pgdir;
-	unsigned long start, end;
+	pml4_t *pml4;
+	unsigned long start, end, next;
 	unsigned long foundaddr;
+	int i;
 
 	if (page->mapping) {
 		start = page_address_in_vma(page, vma);
@@ -538,15 +572,18 @@ static unsigned long unuse_vma(struct vm
 		start = vma->vm_start;
 		end = vma->vm_end;
 	}
-	pgdir = pgd_offset(vma->vm_mm, start);
-	do {
-		foundaddr = unuse_pgd(vma, pgdir, start, end - start,
-						entry, page);
+	pml4 = pml4_offset(vma->vm_mm, start);
+	for (i = pml4_index(start); i <= pml4_index(end-1); i++) { 
+		next = (start + PML4_SIZE) & PML4_MASK;
+		if (next > end || next <= start)
+			next = end;
+		foundaddr = unuse_pml4(vma, pml4, start, next - start, entry, page);
 		if (foundaddr)
 			return foundaddr;
-		start = (start + PGDIR_SIZE) & PGDIR_MASK;
-		pgdir++;
-	} while (start && (start < end));
+		start = next; 
+		i++; 
+		pml4++;
+	}
 	return 0;
 }
 
diff -urpN -X ../KDIFX linux-2.6.10rc1/mm/vmalloc.c linux-2.6.10rc1-4level/mm/vmalloc.c
--- linux-2.6.10rc1/mm/vmalloc.c	2004-10-19 01:55:37.000000000 +0200
+++ linux-2.6.10rc1-4level/mm/vmalloc.c	2004-10-25 04:48:10.000000000 +0200
@@ -83,6 +83,31 @@ static void unmap_area_pmd(pgd_t *dir, u
 	} while (address < end);
 }
 
+static void unmap_area_pgd(pml4_t *pml4, unsigned long address,
+			   unsigned long size)
+{
+	pgd_t *pgd;
+	unsigned long end;
+
+	if (pml4_none(*pml4))
+		return;
+	if (pml4_bad(*pml4)) {
+		pml4_ERROR(*pml4);
+		pml4_clear(pml4);
+		return;
+	}
+
+	pgd = pml4_pgd_offset_k(pml4, address);
+	address &= ~PML4_MASK;
+	end = address + size;
+
+	do {
+		unmap_area_pmd(pgd, address, end - address);
+		address = (address + PGDIR_SIZE) & PGDIR_MASK;
+		pgd++;
+	} while (address && (address < end));
+}
+
 static int map_area_pte(pte_t *pte, unsigned long address,
 			       unsigned long size, pgprot_t prot,
 			       struct page ***pages)
@@ -96,7 +121,6 @@ static int map_area_pte(pte_t *pte, unsi
 
 	do {
 		struct page *page = **pages;
-
 		WARN_ON(!pte_none(*pte));
 		if (!page)
 			return -ENOMEM;
@@ -134,19 +158,41 @@ static int map_area_pmd(pmd_t *pmd, unsi
 	return 0;
 }
 
+static int map_area_pgd(pgd_t *pgd, unsigned long address,
+			       unsigned long end, pgprot_t prot,
+			       struct page ***pages)
+{
+	do {
+		pmd_t *pmd = pmd_alloc(&init_mm, pgd, address);
+		if (!pmd)
+			return -ENOMEM;
+		if (map_area_pmd(pmd, address, end - address, prot, pages))
+			return -ENOMEM;
+		address = (address + PGDIR_SIZE) & PGDIR_MASK;
+		pgd++;
+	} while (address && address < end);
+
+	return 0;
+}
+
 void unmap_vm_area(struct vm_struct *area)
 {
 	unsigned long address = (unsigned long) area->addr;
 	unsigned long end = (address + area->size);
-	pgd_t *dir;
+	unsigned long next;
+	pml4_t *pml4;
+	int i;
 
-	dir = pgd_offset_k(address);
+	pml4 = pml4_offset_k(address);
 	flush_cache_vunmap(address, end);
-	do {
-		unmap_area_pmd(dir, address, end - address);
-		address = (address + PGDIR_SIZE) & PGDIR_MASK;
-		dir++;
-	} while (address && (address < end));
+	for (i = pml4_index(address); i <= pml4_index(end-1); i++) { 
+		next = (address + PML4_SIZE) & PML4_MASK;
+		if (next <= address || next > end)
+			next = end;
+		unmap_area_pgd(pml4, address, next - address);
+		address = next;
+	        pml4++;
+	}
 	flush_tlb_kernel_range((unsigned long) area->addr, end);
 }
 
@@ -154,25 +200,30 @@ int map_vm_area(struct vm_struct *area, 
 {
 	unsigned long address = (unsigned long) area->addr;
 	unsigned long end = address + (area->size-PAGE_SIZE);
-	pgd_t *dir;
+	unsigned long next;
+	pml4_t *pml4;
 	int err = 0;
+	int i;
 
-	dir = pgd_offset_k(address);
+	pml4 = pml4_offset_k(address);
 	spin_lock(&init_mm.page_table_lock);
-	do {
-		pmd_t *pmd = pmd_alloc(&init_mm, dir, address);
-		if (!pmd) {
+	for (i = pml4_index(address); i <= pml4_index(end-1); i++) {
+		pgd_t *pgd = pgd_alloc_k(&init_mm, pml4, address);
+		if (!pgd) {
 			err = -ENOMEM;
 			break;
 		}
-		if (map_area_pmd(pmd, address, end - address, prot, pages)) {
+		next = (address + PGDIR_SIZE) & PGDIR_MASK;
+		if (next < address || next > end)
+			next = end;
+		if (map_area_pgd(pgd, address, next, prot, pages)) {
 			err = -ENOMEM;
 			break;
 		}
 
-		address = (address + PGDIR_SIZE) & PGDIR_MASK;
-		dir++;
-	} while (address && (address < end));
+		address = next;
+		pml4++;
+	}
 
 	spin_unlock(&init_mm.page_table_lock);
 	flush_cache_vmap((unsigned long) area->addr, end);
