Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263795AbUDFMtT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 08:49:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263800AbUDFMtT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 08:49:19 -0400
Received: from sv1.valinux.co.jp ([210.128.90.2]:12203 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S263795AbUDFMrv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 08:47:51 -0400
Date: Tue, 06 Apr 2004 21:48:01 +0900 (JST)
Message-Id: <20040406.214801.127823252.taka@valinux.co.jp>
To: linux-kernel@vger.kernel.org, lhms-devel@lists.sourceforge.net
Subject: [Lhms-devel] [patch 4/6] memory hotplug for hugetlbpages
From: Hirokazu Takahashi <taka@valinux.co.jp>
In-Reply-To: <20040406.214123.129013798.taka@valinux.co.jp>
References: <20040406105353.9BDE8705DE@sv1.valinux.co.jp>
	<20040406.214123.129013798.taka@valinux.co.jp>
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.0 (HANANOEN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a part 4 of memory hotplug patches for hugetlbpages.

$Id: va-hugepagermap.patch,v 1.11 2004/04/01 08:57:40 taka Exp $

--- linux-2.6.4.ORG/include/asm-i386/rmap.h	Thu Mar 11 11:55:34 2004
+++ linux-2.6.4/include/asm-i386/rmap.h	Thu Apr  1 15:38:03 2032
@@ -1,6 +1,9 @@
 #ifndef _I386_RMAP_H
 #define _I386_RMAP_H
 
+#define pmd_add_rmap(page, mm, address)		do { } while (0)
+#define pmd_remove_rmap(page)			do { } while (0)
+
 /* nothing to see, move along */
 #include <asm-generic/rmap.h>
 
--- linux-2.6.4.ORG/include/asm-generic/rmap.h	Thu Mar 11 11:55:34 2004
+++ linux-2.6.4/include/asm-generic/rmap.h	Thu Apr  1 15:38:03 2032
@@ -87,4 +87,51 @@ static inline void rmap_ptep_unmap(pte_t
 }
 #endif
 
+static inline void __pmd_add_rmap(struct page * page, struct mm_struct * mm, unsigned long address)
+{
+#ifdef BROKEN_PPC_PTE_ALLOC_ONE
+	/* OK, so PPC calls pte_alloc() before mem_map[] is setup ... ;( */
+	extern int mem_init_done;
+
+	if (!mem_init_done)
+		return;
+#endif
+	page->mapping = (void *)mm;
+	page->index = address & ~((PTRS_PER_PMD * PTRS_PER_PTE * PAGE_SIZE) - 1);
+}
+
+static inline void __pmd_remove_rmap(struct page * page)
+{
+	page->mapping = NULL;
+	page->index = 0;
+}
+
+static inline void pgd_add_rmap(struct page * page, struct mm_struct * mm)
+{
+#ifdef BROKEN_PPC_PTE_ALLOC_ONE
+	/* OK, so PPC calls pte_alloc() before mem_map[] is setup ... ;( */
+	extern int mem_init_done;
+
+	if (!mem_init_done)
+		return;
+#endif
+	page->mapping = (void *)mm;
+	page->index = 0;
+}
+
+static inline void pgd_remove_rmap(struct page * page)
+{
+	page->mapping = NULL;
+	page->index = 0;
+}
+
+#if !defined(pmd_add_rmap)
+#define pmd_add_rmap(page, mm, address)	__pmd_add_rmap(page, mm, address)
+#endif
+
+#if !defined(pmd_remove_rmap)
+#define pmd_remove_rmap(page)		__pmd_remove_rmap(page)
+#endif
+
+
 #endif /* _GENERIC_RMAP_H */
--- linux-2.6.4.ORG/include/linux/hugetlb.h	Thu Apr  1 15:36:20 2032
+++ linux-2.6.4/include/linux/hugetlb.h	Thu Apr  1 15:38:03 2032
@@ -29,6 +29,7 @@ int is_aligned_hugepage_range(unsigned l
 int pmd_huge(pmd_t pmd);
 extern int hugetlb_fault(struct mm_struct *, struct vm_area_struct *,
 				int, unsigned long);
+int try_to_unmap_hugepage(struct page *, pte_addr_t, struct list_head *);
 
 extern int htlbpage_max;
 
@@ -68,6 +69,7 @@ static inline int is_vm_hugetlb_page(str
 #define is_hugepage_only_range(addr, len)	0
 #define hugetlb_free_pgtables(tlb, prev, start, end) do { } while (0)
 #define hugetlb_fault(mm, vma, write, addr)	0
+#define try_to_unmap_hugepage(page, paddr, force)	0
 
 #ifndef HPAGE_MASK
 #define HPAGE_MASK	0		/* Keep the compiler happy */
--- linux-2.6.4.ORG/mm/rmap.c	Thu Apr  1 14:24:07 2032
+++ linux-2.6.4/mm/rmap.c	Thu Apr  1 15:38:03 2032
@@ -30,6 +30,7 @@
 #include <linux/rmap-locking.h>
 #include <linux/cache.h>
 #include <linux/percpu.h>
+#include <linux/hugetlb.h>
 
 #include <asm/pgalloc.h>
 #include <asm/rmap.h>
@@ -298,15 +299,27 @@ static int FASTCALL(try_to_unmap_one(str
 static int fastcall try_to_unmap_one(struct page * page, pte_addr_t paddr,
     struct list_head *force)
 {
-	pte_t *ptep = rmap_ptep_map(paddr);
-	unsigned long address = ptep_to_address(ptep);
-	struct mm_struct * mm = ptep_to_mm(ptep);
+	pte_t *ptep;
+	unsigned long address;
+	struct mm_struct * mm;
 	struct vm_area_struct * vma;
 #ifdef CONFIG_MEMHOTPLUG
 	struct page_va_list *vlist;
 #endif
 	pte_t pte;
 	int ret;
+
+	/*
+	 * Is there any better way to check whether the page is
+	 * HugePage or not?
+	 */
+	if (PageCompound(page))
+		return try_to_unmap_hugepage(page, paddr, force);
+
+	ptep = rmap_ptep_map(paddr);
+	address = ptep_to_address(ptep);
+	mm = ptep_to_mm(ptep);
+  
 
 	if (!mm)
 		BUG();
--- linux-2.6.4.ORG/mm/memory.c	Thu Apr  1 15:36:20 2032
+++ linux-2.6.4/mm/memory.c	Thu Apr  1 15:38:03 2032
@@ -113,6 +113,7 @@ static inline void free_one_pgd(struct m
 {
 	int j;
 	pmd_t * pmd;
+	struct page *page;
 
 	if (pgd_none(*dir))
 		return;
@@ -125,6 +126,8 @@ static inline void free_one_pgd(struct m
 	pgd_clear(dir);
 	for (j = 0; j < PTRS_PER_PMD ; j++)
 		free_one_pmd(tlb, pmd+j);
+	page = virt_to_page(pmd);
+	pmd_remove_rmap(page);
 	pmd_free_tlb(tlb, pmd);
 }
 
@@ -1667,6 +1670,7 @@ int handle_mm_fault(struct mm_struct *mm
 pmd_t fastcall *__pmd_alloc(struct mm_struct *mm, pgd_t *pgd, unsigned long address)
 {
 	pmd_t *new;
+	struct page *page;
 
 	spin_unlock(&mm->page_table_lock);
 	new = pmd_alloc_one(mm, address);
@@ -1682,6 +1686,8 @@ pmd_t fastcall *__pmd_alloc(struct mm_st
 		pmd_free(new);
 		goto out;
 	}
+	page = virt_to_page(new);
+	pmd_add_rmap(new, mm, address);
 	pgd_populate(mm, pgd, new);
 out:
 	return pmd_offset(pgd, address);
--- linux-2.6.4.ORG/arch/i386/mm/pgtable.c	Thu Mar 11 11:55:56 2004
+++ linux-2.6.4/arch/i386/mm/pgtable.c	Thu Apr  1 15:38:03 2032
@@ -21,6 +21,7 @@
 #include <asm/e820.h>
 #include <asm/tlb.h>
 #include <asm/tlbflush.h>
+#include <asm/rmap.h>
 
 void show_mem(void)
 {
@@ -206,22 +207,34 @@ void pgd_dtor(void *pgd, kmem_cache_t *c
 pgd_t *pgd_alloc(struct mm_struct *mm)
 {
 	int i;
+	struct page *page;
 	pgd_t *pgd = kmem_cache_alloc(pgd_cache, GFP_KERNEL);
 
-	if (PTRS_PER_PMD == 1 || !pgd)
+	if (!pgd)
 		return pgd;
+	if (PTRS_PER_PMD == 1) {
+		page = virt_to_page(pgd);
+		pgd_add_rmap(page, mm);
+		return pgd;
+	}
 
 	for (i = 0; i < USER_PTRS_PER_PGD; ++i) {
 		pmd_t *pmd = kmem_cache_alloc(pmd_cache, GFP_KERNEL);
 		if (!pmd)
 			goto out_oom;
+		page = virt_to_page(pmd);
+		__pmd_add_rmap(page, mm, (PTRS_PER_PMD * PTRS_PER_PTE * PAGE_SIZE)*i);
 		set_pgd(&pgd[i], __pgd(1 + __pa((u64)((u32)pmd))));
 	}
 	return pgd;
 
 out_oom:
-	for (i--; i >= 0; i--)
-		kmem_cache_free(pmd_cache, (void *)__va(pgd_val(pgd[i])-1));
+	for (i--; i >= 0; i--) {
+		pmd_t *pmd = (pmd_t *)__va(pgd_val(pgd[i])-1);
+		page = virt_to_page(pmd);
+		__pmd_remove_rmap(page);
+		kmem_cache_free(pmd_cache, pmd);
+	}
 	kmem_cache_free(pgd_cache, pgd);
 	return NULL;
 }
@@ -229,11 +242,20 @@ out_oom:
 void pgd_free(pgd_t *pgd)
 {
 	int i;
+	struct page *page;
 
 	/* in the PAE case user pgd entries are overwritten before usage */
-	if (PTRS_PER_PMD > 1)
-		for (i = 0; i < USER_PTRS_PER_PGD; ++i)
-			kmem_cache_free(pmd_cache, (void *)__va(pgd_val(pgd[i])-1));
+	if (PTRS_PER_PMD > 1) {
+		for (i = 0; i < USER_PTRS_PER_PGD; ++i) {
+			pmd_t *pmd = (pmd_t *)__va(pgd_val(pgd[i])-1);
+			page = virt_to_page(pmd);
+			__pmd_remove_rmap(page);
+			kmem_cache_free(pmd_cache, pmd);
+		}
+	} else {
+		page = virt_to_page(pgd);
+		pgd_remove_rmap(page);
+	}
 	/* in the non-PAE case, clear_page_tables() clears user pgd entries */
 	kmem_cache_free(pgd_cache, pgd);
 }
--- linux-2.6.4.ORG/arch/i386/mm/hugetlbpage.c	Thu Apr  1 15:37:21 2032
+++ linux-2.6.4/arch/i386/mm/hugetlbpage.c	Thu Apr  1 15:38:03 2032
@@ -12,11 +12,13 @@
 #include <linux/pagemap.h>
 #include <linux/smp_lock.h>
 #include <linux/slab.h>
+#include <linux/rmap-locking.h>
 #include <linux/module.h>
 #include <linux/err.h>
 #include <linux/sysctl.h>
 #include <asm/mman.h>
 #include <asm/pgalloc.h>
+#include <asm/rmap.h>
 #include <asm/tlb.h>
 #include <asm/tlbflush.h>
 
@@ -28,6 +30,29 @@ static struct list_head hugepage_freelis
 static struct list_head hugepage_alllists[MAX_NUMNODES];
 static spinlock_t htlbpage_lock = SPIN_LOCK_UNLOCKED;
 
+static inline void hugepgtable_add_rmap(struct page * page, struct mm_struct * mm, unsigned long address)
+{
+/* 	page->mapping = (void *)mm; */
+	page->index = address & ~((PTRS_PER_PTE * HPAGE_SIZE) - 1);
+}
+
+static inline void hugepgtable_remove_rmap(struct page * page)
+{
+	page->mapping = NULL;
+	page->index = 0;
+}
+
+static inline struct pte_chain *hugepage_add_rmap(struct page *page, pte_t *ptep, struct pte_chain *pte_chain)
+{
+	return page_add_rmap(page, ptep, pte_chain);
+}
+
+static inline void hugepage_remove_rmap(struct page *page, pte_t *ptep)
+{
+	ClearPageReferenced(page);	/* XXX */
+	page_remove_rmap(page, ptep);
+}
+
 static void register_huge_page(struct page *page)
 {
 	list_add(&page[1].list,
@@ -37,10 +62,12 @@ static void register_huge_page(struct pa
 static void unregister_huge_page(struct page *page)
 {
 	list_del(&page[1].list);
+	INIT_LIST_HEAD(&page[1].list);
 }
 
 static void enqueue_huge_page(struct page *page)
 {
+/* 	set_page_count(page, 1); */
 	list_add(&page->list,
 		&hugepage_freelists[page_zone(page)->zone_pgdat->node_id]);
 }
@@ -97,9 +124,14 @@ static pte_t *huge_pte_alloc(struct mm_s
 {
 	pgd_t *pgd;
 	pmd_t *pmd = NULL;
+	struct page *page;
 
 	pgd = pgd_offset(mm, addr);
 	pmd = pmd_alloc(mm, pgd, addr);
+	page = virt_to_page(pmd);
+	/* The following call may be redundant. */
+	hugepgtable_add_rmap(page, mm, addr);
+
 	return (pte_t *) pmd;
 }
 
@@ -147,24 +179,49 @@ int copy_hugetlb_page_range(struct mm_st
 	struct page *ptepage;
 	unsigned long addr = vma->vm_start;
 	unsigned long end = vma->vm_end;
+	struct pte_chain *pte_chain = NULL;
+
+	pte_chain = pte_chain_alloc(GFP_ATOMIC);
+	if (!pte_chain) {
+		spin_unlock(&dst->page_table_lock);
+		pte_chain = pte_chain_alloc(GFP_KERNEL);
+		spin_lock(&dst->page_table_lock);
+		if (!pte_chain)
+			goto nomem;
+	}
 
 	while (addr < end) {
 		dst_pte = huge_pte_alloc(dst, addr);
 		if (!dst_pte)
 			goto nomem;
+		spin_lock(&src->page_table_lock);
 		src_pte = huge_pte_offset(src, addr);
 		entry = *src_pte;
 		if (!pte_none(entry)) {
 			ptepage = pte_page(entry);
 			get_page(ptepage);
+			pte_chain = hugepage_add_rmap(ptepage, dst_pte, pte_chain);
 		}
 		set_pte(dst_pte, entry);
+		spin_unlock(&src->page_table_lock);
 		dst->rss += (HPAGE_SIZE / PAGE_SIZE);
 		addr += HPAGE_SIZE;
+		if (pte_chain)
+			continue;
+		pte_chain = pte_chain_alloc(GFP_ATOMIC);
+		if (!pte_chain) {
+			spin_unlock(&dst->page_table_lock);
+			pte_chain = pte_chain_alloc(GFP_KERNEL);
+			spin_lock(&dst->page_table_lock);
+			if (!pte_chain)
+				goto nomem;
+		}
 	}
+	pte_chain_free(pte_chain);
 	return 0;
 
 nomem:
+	pte_chain_free(pte_chain);
 	return -ENOMEM;
 }
 
@@ -336,6 +393,7 @@ void unmap_hugepage_range(struct vm_area
 		if (pte_none(*pte))
 			continue;
 		page = pte_page(*pte);
+		hugepage_remove_rmap(page, pte);
 		huge_page_release(page);
 		pte_clear(pte);
 	}
@@ -360,6 +418,7 @@ int hugetlb_fault(struct mm_struct *mm, 
 	struct page *page;
 	unsigned long idx;
 	pte_t *pte = huge_pte_alloc(mm, address);
+	struct pte_chain *pte_chain = NULL;
 	int ret;
 
 	BUG_ON(vma->vm_start & ~HPAGE_MASK);
@@ -375,6 +434,16 @@ int hugetlb_fault(struct mm_struct *mm, 
 		goto out;
 	}
 
+	pte_chain = pte_chain_alloc(GFP_ATOMIC);
+	if (!pte_chain) {
+		pte_chain = pte_chain_alloc(GFP_KERNEL);
+		if (!pte_chain) {
+			ret = VM_FAULT_SIGBUS;
+			goto out;
+		}
+		pte = huge_pte_alloc(mm, address);
+	}
+
 	idx = ((address - vma->vm_start) >> HPAGE_SHIFT)
 		+ (vma->vm_pgoff >> (HPAGE_SHIFT - PAGE_SHIFT));
 again:
@@ -402,6 +471,7 @@ again:
 	spin_lock(&mm->page_table_lock);
 	if (pte_none(*pte)) {
 		set_huge_pte(mm, vma, page, pte, vma->vm_flags & VM_WRITE);
+		pte_chain = hugepage_add_rmap(page, pte, pte_chain);
 		flush_tlb_page(vma, address);
 		update_mmu_cache(vma, address, *pte);
 	} else {
@@ -411,6 +481,7 @@ again:
 	unlock_page(page);
 	ret = VM_FAULT_MINOR;
 out:
+	pte_chain_free(pte_chain);
 	return ret;
 }
 
@@ -441,6 +512,86 @@ int hugetlb_prefault(struct address_spac
 		}
 		ret = 0;
 	}
+	spin_unlock(&mm->page_table_lock);
+	return ret;
+}
+
+static inline unsigned long hugeptep_to_address(pte_t *ptep)
+{
+	struct page *page = kmap_atomic_to_page(ptep);
+	unsigned long low_bits;
+	low_bits = ((unsigned long)ptep & ~PAGE_MASK)/sizeof(pte_t)*HPAGE_SIZE;
+	return page->index + low_bits;
+}
+
+int try_to_unmap_hugepage(struct page * page, pte_addr_t paddr, struct list_head *force)
+{
+	pte_t *ptep = rmap_ptep_map(paddr);
+	unsigned long address = hugeptep_to_address(ptep);
+	struct mm_struct * mm = ptep_to_mm(ptep);
+	struct vm_area_struct * vma;
+	pte_t pte;
+	int ret;
+
+	if (!mm)
+		BUG();
+
+	/*
+	 * We need the page_table_lock to protect us from page faults,
+	 * munmap, fork, etc...
+	 */
+	if (!spin_trylock(&mm->page_table_lock)) {
+		rmap_ptep_unmap(ptep);
+		return SWAP_AGAIN;
+	}
+
+
+	/* During mremap, it's possible pages are not in a VMA. */
+	vma = find_vma(mm, address);
+	if (!vma) {
+		ret = SWAP_FAIL;
+		goto out_unlock;
+	}
+
+	/* The page is mlock()d, we cannot swap it out. */
+	if (force == NULL && (vma->vm_flags & VM_LOCKED)) {
+		BUG();	/* Never come here */
+	}
+
+	/* Nuke the page table entry. */
+	flush_cache_page(vma, address);
+	pte = ptep_get_and_clear(ptep);
+	flush_tlb_range(vma, address, address + HPAGE_SIZE);
+
+	if (PageSwapCache(page)) {
+		BUG();	/* Never come here */
+	} else {
+		unsigned long pgidx;
+		/*
+		 * If a nonlinear mapping then store the file page offset
+		 * in the pte.
+		 */
+		pgidx = (address - vma->vm_start) >> HPAGE_SHIFT;
+		pgidx += vma->vm_pgoff >> (HPAGE_SHIFT - PAGE_SHIFT);
+		pgidx >>= PAGE_CACHE_SHIFT - PAGE_SHIFT;
+		if (page->index != pgidx) {
+#if 0
+			set_pte(ptep, pgoff_to_pte(page->index));
+			BUG_ON(!pte_file(*ptep));
+#endif
+		}
+	}
+
+	/* Move the dirty bit to the physical page now the pte is gone. */
+	if (pte_dirty(pte))
+		set_page_dirty(page);
+
+	mm->rss -= (HPAGE_SIZE / PAGE_SIZE);
+	page_cache_release(page);
+	ret = SWAP_SUCCESS;
+
+out_unlock:
+	rmap_ptep_unmap(ptep);
 	spin_unlock(&mm->page_table_lock);
 	return ret;
 }
