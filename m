Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932264AbVJVQaS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932264AbVJVQaS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Oct 2005 12:30:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932265AbVJVQaS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Oct 2005 12:30:18 -0400
Received: from gold.veritas.com ([143.127.12.110]:518 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S932264AbVJVQaQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Oct 2005 12:30:16 -0400
Date: Sat, 22 Oct 2005 17:29:14 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: Christoph Lameter <clameter@sgi.com>, Russell King <rmk@arm.linux.org.uk>,
       Matthew Wilcox <matthew@wil.cx>, Jeff Dike <jdike@addtoit.com>,
       linux-kernel@vger.kernel.org
Subject: [PATCH 7/9] mm: split page table lock
In-Reply-To: <Pine.LNX.4.61.0510221716380.18047@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.61.0510221727060.18047@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0510221716380.18047@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 22 Oct 2005 16:30:15.0894 (UTC) FILETIME=[E236EF60:01C5D725]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter demonstrated very poor scalability on the SGI 512-way,
with a many-threaded application which concurrently initializes different
parts of a large anonymous area.

This patch corrects that, by using a separate spinlock per page table
page, to guard the page table entries in that page, instead of using
the mm's single page_table_lock.  (But even then, page_table_lock is
still used to guard page table allocation, and anon_vma allocation.)

In this implementation, the spinlock is tucked inside the struct page of
the page table page: with a BUILD_BUG_ON in case it overflows - which it
would in the case of 32-bit PA-RISC with spinlock debugging enabled.

Splitting the lock is not quite for free: another cacheline access.
Ideally, I suppose we would use split ptlock only for multi-threaded
processes on multi-cpu machines; but deciding that dynamically would
have its own costs.  So for now enable it by config, at some number
of cpus - since the Kconfig language doesn't support inequalities, let
preprocessor compare that with NR_CPUS.  But I don't think it's worth
being user-configurable: for good testing of both split and unsplit
configs, split now at 4 cpus, and perhaps change that to 8 later.

There is a benefit even for singly threaded processes: kswapd can be
attacking one part of the mm while another part is busy faulting.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

 arch/arm/mm/mm-armv.c     |    1 +
 arch/um/kernel/skas/mmu.c |    1 +
 include/linux/mm.h        |   26 +++++++++++++++++++++++++-
 mm/Kconfig                |   13 +++++++++++++
 mm/memory.c               |   24 ++++++++++++++----------
 mm/mremap.c               |   11 ++++++++++-
 mm/rmap.c                 |    2 +-
 7 files changed, 65 insertions(+), 13 deletions(-)

--- mm6/arch/arm/mm/mm-armv.c	2005-10-17 12:05:08.000000000 +0100
+++ mm7/arch/arm/mm/mm-armv.c	2005-10-22 14:07:25.000000000 +0100
@@ -229,6 +229,7 @@ void free_pgd_slow(pgd_t *pgd)
 	pte = pmd_page(*pmd);
 	pmd_clear(pmd);
 	dec_page_state(nr_page_table_pages);
+	pte_lock_deinit(pte);
 	pte_free(pte);
 	pmd_free(pmd);
 free:
--- mm6/arch/um/kernel/skas/mmu.c	2005-10-17 12:05:14.000000000 +0100
+++ mm7/arch/um/kernel/skas/mmu.c	2005-10-22 14:07:25.000000000 +0100
@@ -144,6 +144,7 @@ void destroy_context_skas(struct mm_stru
 
 	if(!proc_mm || !ptrace_faultinfo){
 		free_page(mmu->id.stack);
+		pte_lock_deinit(virt_to_page(mmu->last_page_table));
 		pte_free_kernel((pte_t *) mmu->last_page_table);
                 dec_page_state(nr_page_table_pages);
 #ifdef CONFIG_3_LEVEL_PGTABLES
--- mm6/include/linux/mm.h	2005-10-17 12:05:38.000000000 +0100
+++ mm7/include/linux/mm.h	2005-10-22 14:07:25.000000000 +0100
@@ -778,9 +778,33 @@ static inline pmd_t *pmd_alloc(struct mm
 }
 #endif /* CONFIG_MMU && !__ARCH_HAS_4LEVEL_HACK */
 
+#if NR_CPUS >= CONFIG_SPLIT_PTLOCK_CPUS
+/*
+ * We tuck a spinlock to guard each pagetable page into its struct page,
+ * at page->private, with BUILD_BUG_ON to make sure that this will not
+ * overflow into the next struct page (as it might with DEBUG_SPINLOCK).
+ * When freeing, reset page->mapping so free_pages_check won't complain.
+ */
+#define __pte_lockptr(page)	((spinlock_t *)&((page)->private))
+#define pte_lock_init(_page)	do {					\
+	BUILD_BUG_ON((size_t)(__pte_lockptr((struct page *)0) + 1) >	\
+						sizeof(struct page));	\
+	spin_lock_init(__pte_lockptr(_page));				\
+} while (0)
+#define pte_lock_deinit(page)	((page)->mapping = NULL)
+#define pte_lockptr(mm, pmd)	({(void)(mm); __pte_lockptr(pmd_page(*(pmd)));})
+#else
+/*
+ * We use mm->page_table_lock to guard all pagetable pages of the mm.
+ */
+#define pte_lock_init(page)	do {} while (0)
+#define pte_lock_deinit(page)	do {} while (0)
+#define pte_lockptr(mm, pmd)	({(void)(pmd); &(mm)->page_table_lock;})
+#endif /* NR_CPUS < CONFIG_SPLIT_PTLOCK_CPUS */
+
 #define pte_offset_map_lock(mm, pmd, address, ptlp)	\
 ({							\
-	spinlock_t *__ptl = &(mm)->page_table_lock;	\
+	spinlock_t *__ptl = pte_lockptr(mm, pmd);	\
 	pte_t *__pte = pte_offset_map(pmd, address);	\
 	*(ptlp) = __ptl;				\
 	spin_lock(__ptl);				\
--- mm6/mm/Kconfig	2005-10-17 12:05:40.000000000 +0100
+++ mm7/mm/Kconfig	2005-10-22 14:07:25.000000000 +0100
@@ -119,3 +119,16 @@ config MEMORY_HOTPLUG
 
 comment "Memory hotplug is currently incompatible with Software Suspend"
 	depends on SPARSEMEM && HOTPLUG && SOFTWARE_SUSPEND
+
+# Heavily threaded applications may benefit from splitting the mm-wide
+# page_table_lock, so that faults on different parts of the user address
+# space can be handled with less contention: split it at this NR_CPUS.
+# Default to 4 for wider testing, though 8 might be more appropriate.
+# ARM's adjust_pte (unused if VIPT) depends on mm-wide page_table_lock.
+# PA-RISC's debug spinlock_t is too large for the 32-bit struct page.
+#
+config SPLIT_PTLOCK_CPUS
+	int
+	default "4096" if ARM && !CPU_CACHE_VIPT
+	default "4096" if PARISC && DEBUG_SPINLOCK && !64BIT
+	default "4"
--- mm6/mm/memory.c	2005-10-17 12:05:40.000000000 +0100
+++ mm7/mm/memory.c	2005-10-22 14:07:25.000000000 +0100
@@ -114,6 +114,7 @@ static void free_pte_range(struct mmu_ga
 {
 	struct page *page = pmd_page(*pmd);
 	pmd_clear(pmd);
+	pte_lock_deinit(page);
 	pte_free_tlb(tlb, page);
 	dec_page_state(nr_page_table_pages);
 	tlb->mm->nr_ptes--;
@@ -294,10 +295,12 @@ int __pte_alloc(struct mm_struct *mm, pm
 	if (!new)
 		return -ENOMEM;
 
+	pte_lock_init(new);
 	spin_lock(&mm->page_table_lock);
-	if (pmd_present(*pmd))		/* Another has populated it */
+	if (pmd_present(*pmd)) {	/* Another has populated it */
+		pte_lock_deinit(new);
 		pte_free(new);
-	else {
+	} else {
 		mm->nr_ptes++;
 		inc_page_state(nr_page_table_pages);
 		pmd_populate(mm, pmd, new);
@@ -432,7 +435,7 @@ again:
 	if (!dst_pte)
 		return -ENOMEM;
 	src_pte = pte_offset_map_nested(src_pmd, addr);
-	src_ptl = &src_mm->page_table_lock;
+	src_ptl = pte_lockptr(src_mm, src_pmd);
 	spin_lock(src_ptl);
 
 	do {
@@ -1194,15 +1197,16 @@ EXPORT_SYMBOL(remap_pfn_range);
  * (but do_wp_page is only called after already making such a check;
  * and do_anonymous_page and do_no_page can safely check later on).
  */
-static inline int pte_unmap_same(struct mm_struct *mm,
+static inline int pte_unmap_same(struct mm_struct *mm, pmd_t *pmd,
 				pte_t *page_table, pte_t orig_pte)
 {
 	int same = 1;
 #if defined(CONFIG_SMP) || defined(CONFIG_PREEMPT)
 	if (sizeof(pte_t) > sizeof(unsigned long)) {
-		spin_lock(&mm->page_table_lock);
+		spinlock_t *ptl = pte_lockptr(mm, pmd);
+		spin_lock(ptl);
 		same = pte_same(*page_table, orig_pte);
-		spin_unlock(&mm->page_table_lock);
+		spin_unlock(ptl);
 	}
 #endif
 	pte_unmap(page_table);
@@ -1655,7 +1659,7 @@ static int do_swap_page(struct mm_struct
 	pte_t pte;
 	int ret = VM_FAULT_MINOR;
 
-	if (!pte_unmap_same(mm, page_table, orig_pte))
+	if (!pte_unmap_same(mm, pmd, page_table, orig_pte))
 		goto out;
 
 	entry = pte_to_swp_entry(orig_pte);
@@ -1773,7 +1777,7 @@ static int do_anonymous_page(struct mm_s
 		page_cache_get(page);
 		entry = mk_pte(page, vma->vm_page_prot);
 
-		ptl = &mm->page_table_lock;
+		ptl = pte_lockptr(mm, pmd);
 		spin_lock(ptl);
 		if (!pte_none(*page_table))
 			goto release;
@@ -1934,7 +1938,7 @@ static int do_file_page(struct mm_struct
 	pgoff_t pgoff;
 	int err;
 
-	if (!pte_unmap_same(mm, page_table, orig_pte))
+	if (!pte_unmap_same(mm, pmd, page_table, orig_pte))
 		return VM_FAULT_MINOR;
 
 	if (unlikely(!(vma->vm_flags & VM_NONLINEAR))) {
@@ -1992,7 +1996,7 @@ static inline int handle_pte_fault(struc
 					pte, pmd, write_access, entry);
 	}
 
-	ptl = &mm->page_table_lock;
+	ptl = pte_lockptr(mm, pmd);
 	spin_lock(ptl);
 	if (unlikely(!pte_same(*pte, entry)))
 		goto unlock;
--- mm6/mm/mremap.c	2005-10-17 12:05:40.000000000 +0100
+++ mm7/mm/mremap.c	2005-10-22 14:07:25.000000000 +0100
@@ -72,7 +72,7 @@ static void move_ptes(struct vm_area_str
 	struct address_space *mapping = NULL;
 	struct mm_struct *mm = vma->vm_mm;
 	pte_t *old_pte, *new_pte, pte;
-	spinlock_t *old_ptl;
+	spinlock_t *old_ptl, *new_ptl;
 
 	if (vma->vm_file) {
 		/*
@@ -88,8 +88,15 @@ static void move_ptes(struct vm_area_str
 			new_vma->vm_truncate_count = 0;
 	}
 
+	/*
+	 * We don't have to worry about the ordering of src and dst
+	 * pte locks because exclusive mmap_sem prevents deadlock.
+	 */
 	old_pte = pte_offset_map_lock(mm, old_pmd, old_addr, &old_ptl);
  	new_pte = pte_offset_map_nested(new_pmd, new_addr);
+	new_ptl = pte_lockptr(mm, new_pmd);
+	if (new_ptl != old_ptl)
+		spin_lock(new_ptl);
 
 	for (; old_addr < old_end; old_pte++, old_addr += PAGE_SIZE,
 				   new_pte++, new_addr += PAGE_SIZE) {
@@ -101,6 +108,8 @@ static void move_ptes(struct vm_area_str
 		set_pte_at(mm, new_addr, new_pte, pte);
 	}
 
+	if (new_ptl != old_ptl)
+		spin_unlock(new_ptl);
 	pte_unmap_nested(new_pte - 1);
 	pte_unmap_unlock(old_pte - 1, old_ptl);
 	if (mapping)
--- mm6/mm/rmap.c	2005-10-17 12:05:40.000000000 +0100
+++ mm7/mm/rmap.c	2005-10-22 14:07:25.000000000 +0100
@@ -274,7 +274,7 @@ pte_t *page_check_address(struct page *p
 		return NULL;
 	}
 
-	ptl = &mm->page_table_lock;
+	ptl = pte_lockptr(mm, pmd);
 	spin_lock(ptl);
 	if (pte_present(*pte) && page_to_pfn(page) == pte_pfn(*pte)) {
 		*ptlp = ptl;
