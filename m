Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316519AbSHFXLn>; Tue, 6 Aug 2002 19:11:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316512AbSHFXLn>; Tue, 6 Aug 2002 19:11:43 -0400
Received: from holomorphy.com ([66.224.33.161]:16529 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S316519AbSHFXLg>;
	Tue, 6 Aug 2002 19:11:36 -0400
Date: Tue, 6 Aug 2002 16:15:22 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@zip.com.au, riel@surriel.com
Subject: fix CONFIG_HIGHPTE
Message-ID: <20020806231522.GJ6256@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org, akpm@zip.com.au, riel@surriel.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Minimalistic fix. Perhaps rough at the edges but I can clean the
ugliness ppl care about when they complain. 2.5.30 successfully booted
& ran userspace on a 16-way NUMA-Q with 16GB of RAM with this patch
and CONFIG_HIGHPTE enabled.



Cheers,
Bill


===== arch/i386/config.in 1.44 vs edited =====
--- 1.44/arch/i386/config.in	Thu Jul 25 14:02:05 2002
+++ edited/arch/i386/config.in	Fri Aug  2 22:56:10 2002
@@ -194,6 +194,10 @@
    define_bool CONFIG_X86_PAE y
 fi
 
+if [ "$CONFIG_HIGHMEM4G" = "y" -o "$CONFIG_HIGHMEM64G" = "y" ]; then
+   bool 'Allocate 3rd-level pagetables from highmem' CONFIG_HIGHPTE
+fi
+
 bool 'Math emulation' CONFIG_MATH_EMULATION
 bool 'MTRR (Memory Type Range Register) support' CONFIG_MTRR
 
===== include/asm-generic/rmap.h 1.2 vs edited =====
--- 1.2/include/asm-generic/rmap.h	Tue Jul 16 14:46:30 2002
+++ edited/include/asm-generic/rmap.h	Fri Aug  2 23:25:57 2002
@@ -39,16 +39,30 @@
 
 static inline struct mm_struct * ptep_to_mm(pte_t * ptep)
 {
-	struct page * page = virt_to_page(ptep);
+	struct page * page = kmap_to_page(ptep);
 	return (struct mm_struct *) page->mapping;
 }
 
 static inline unsigned long ptep_to_address(pte_t * ptep)
 {
-	struct page * page = virt_to_page(ptep);
+	struct page * page = kmap_to_page(ptep);
 	unsigned long low_bits;
 	low_bits = ((unsigned long)ptep & ~PAGE_MASK) * PTRS_PER_PTE;
 	return page->index + low_bits;
 }
+
+#if CONFIG_HIGHPTE
+static inline pte_addr_t ptep_to_paddr(pte_t *ptep)
+{
+	pte_addr_t paddr;
+	paddr = ((pte_addr_t)page_to_pfn(kmap_to_page(ptep))) << PAGE_SHIFT;
+	return paddr + (pte_addr_t)((unsigned long)ptep & ~PAGE_MASK);
+}
+#else
+static inline pte_addr_t ptep_to_paddr(pte_t *ptep)
+{
+	return (pte_addr_t)ptep;
+}
+#endif
 
 #endif /* _GENERIC_RMAP_H */
===== include/asm-i386/fixmap.h 1.5 vs edited =====
--- 1.5/include/asm-i386/fixmap.h	Thu Mar 14 02:11:25 2002
+++ edited/include/asm-i386/fixmap.h	Fri Aug  2 23:32:53 2002
@@ -103,6 +103,7 @@
 #define FIXADDR_START	(FIXADDR_TOP - __FIXADDR_SIZE)
 
 #define __fix_to_virt(x)	(FIXADDR_TOP - ((x) << PAGE_SHIFT))
+#define __virt_to_fix(x)	((FIXADDR_TOP - (x)) >> PAGE_SHIFT)
 
 extern void __this_fixmap_does_not_exist(void);
 
@@ -126,6 +127,12 @@
 		__this_fixmap_does_not_exist();
 
         return __fix_to_virt(idx);
+}
+
+static inline unsigned long virt_to_fix(const unsigned long vaddr)
+{
+	BUG_ON(vaddr >= FIXADDR_TOP || vaddr < FIXADDR_START);
+	return __virt_to_fix(vaddr);
 }
 
 #endif
===== include/asm-i386/highmem.h 1.7 vs edited =====
--- 1.7/include/asm-i386/highmem.h	Wed Jun  5 01:48:57 2002
+++ edited/include/asm-i386/highmem.h	Fri Aug  2 23:06:52 2002
@@ -122,6 +122,19 @@
 	preempt_enable();
 }
 
+static inline struct page *kmap_to_page(void *ptr)
+{
+	unsigned long idx, vaddr = (unsigned long)ptr;
+	pte_t *pte;
+
+	if (vaddr < FIXADDR_START)
+		return virt_to_page(ptr);
+
+	idx = virt_to_fix(vaddr);
+	pte = kmap_pte - (idx - FIX_KMAP_BEGIN);
+	return pte_page(*pte);
+}
+
 #endif /* __KERNEL__ */
 
 #endif /* _ASM_HIGHMEM_H */
===== include/asm-i386/kmap_types.h 1.8 vs edited =====
--- 1.8/include/asm-i386/kmap_types.h	Sun Jun 16 15:50:19 2002
+++ edited/include/asm-i386/kmap_types.h	Fri Aug  2 22:26:12 2002
@@ -19,7 +19,8 @@
 D(6)	KM_BIO_DST_IRQ,
 D(7)	KM_PTE0,
 D(8)	KM_PTE1,
-D(9)	KM_TYPE_NR
+D(9)	KM_PTE2,
+D(10)	KM_TYPE_NR
 };
 
 #undef D
===== include/asm-i386/pgtable.h 1.17 vs edited =====
--- 1.17/include/asm-i386/pgtable.h	Mon Jun 17 20:14:46 2002
+++ edited/include/asm-i386/pgtable.h	Fri Aug  2 23:19:13 2002
@@ -264,6 +265,27 @@
 	((pte_t *)kmap_atomic(pmd_page(*(dir)),KM_PTE1) + __pte_offset(address))
 #define pte_unmap(pte) kunmap_atomic(pte, KM_PTE0)
 #define pte_unmap_nested(pte) kunmap_atomic(pte, KM_PTE1)
+
+#if CONFIG_HIGHPTE
+#define rmap_ptep_map(pte_paddr)					\
+({									\
+	unsigned long pfn = (unsigned long)(pte_paddr >> PAGE_SHIFT);	\
+	unsigned long idx = __pte_offset(((unsigned long)pte_paddr));	\
+	(pte_t *)kmap_atomic(pfn_to_page(pfn), KM_PTE2) + idx;		\
+})
+
+#define rmap_ptep_unmap(pte) kunmap_atomic(pte, KM_PTE2)
+#else /* !CONFIG_HIGHPTE */
+static inline rmap_ptep_map(pte_addr_t pte_paddr)
+{
+	return (pte_t *)pte_paddr;
+}
+
+static inline rmap_ptep_unmap(pte_t *pte)
+{
+	return;
+}
+#endif /* !CONFIG_HIGHPTE */
 
 /*
  * The i386 doesn't have any external MMU info: the kernel page
===== include/linux/mm.h 1.66 vs edited =====
--- 1.66/include/linux/mm.h	Thu Aug  1 12:30:06 2002
+++ edited/include/linux/mm.h	Fri Aug  2 22:24:40 2002
@@ -161,7 +161,7 @@
 	union {
 		struct pte_chain * chain;	/* Reverse pte mapping pointer.
 					 * protected by PG_chainlock */
-		pte_t		 * direct;
+		pte_addr_t		 direct;
 	} pte;
 	unsigned long private;		/* mapping-private opaque data */
 
===== include/linux/types.h 1.4 vs edited =====
--- 1.4/include/linux/types.h	Tue Jun 11 18:51:43 2002
+++ edited/include/linux/types.h	Fri Aug  2 23:23:46 2002
@@ -11,6 +11,12 @@
 #include <linux/posix_types.h>
 #include <asm/types.h>
 
+#if CONFIG_HIGHPTE
+typedef u64 pte_addr_t;
+#else
+typedef pte_t *pte_addr_t;
+#endif
+
 #ifndef __KERNEL_STRICT_NAMES
 
 typedef __kernel_fd_set		fd_set;
===== mm/rmap.c 1.7 vs edited =====
--- 1.7/mm/rmap.c	Wed Jul 31 02:58:53 2002
+++ edited/mm/rmap.c	Fri Aug  2 23:29:10 2002
@@ -49,7 +49,7 @@
  */
 struct pte_chain {
 	struct pte_chain * next;
-	pte_t * ptep;
+	pte_addr_t ptep;
 };
 
 static kmem_cache_t	*pte_chain_cache;
@@ -74,13 +74,17 @@
 		referenced++;
 
 	if (PageDirect(page)) {
-		if (ptep_test_and_clear_young(page->pte.direct))
+		pte_t *pte = rmap_ptep_map(page->pte.direct);
+		if (ptep_test_and_clear_young(pte))
 			referenced++;
+		rmap_ptep_unmap(pte);
 	} else {
 		/* Check all the page tables mapping this page. */
 		for (pc = page->pte.chain; pc; pc = pc->next) {
-			if (ptep_test_and_clear_young(pc->ptep))
+			pte_t *pte = rmap_ptep_map(pc->ptep);
+			if (ptep_test_and_clear_young(pte))
 				referenced++;
+			rmap_ptep_unmap(pte);
 		}
 	}
 	return referenced;
@@ -97,7 +101,8 @@
 void page_add_rmap(struct page * page, pte_t * ptep)
 {
 	struct pte_chain * pte_chain;
-	unsigned long pfn = pte_pfn(*ptep);
+	unsigned long pfn = page_to_pfn(page);
+	pte_addr_t pte_paddr = ptep_to_paddr(ptep);
 
 #ifdef DEBUG_RMAP
 	if (!page || !ptep)
@@ -112,6 +117,9 @@
 		return;
 
 #ifdef DEBUG_RMAP
+	/*
+	 * This stuff needs help to get up to highmem speed.
+	 */
 	pte_chain_lock(page);
 	{
 		struct pte_chain * pc;
@@ -141,11 +149,11 @@
 	if (page->pte.chain) {
 		/* Hook up the pte_chain to the page. */
 		pte_chain = pte_chain_alloc();
-		pte_chain->ptep = ptep;
+		pte_chain->ptep = pte_paddr;
 		pte_chain->next = page->pte.chain;
 		page->pte.chain = pte_chain;
 	} else {
-		page->pte.direct = ptep;
+		page->pte.direct = pte_paddr;
 		SetPageDirect(page);
 	}
 
@@ -167,6 +175,7 @@
 {
 	struct pte_chain * pc, * prev_pc = NULL;
 	unsigned long pfn = page_to_pfn(page);
+	pte_addr_t paddr = ptep_to_paddr(ptep);
 
 	if (!page || !ptep)
 		BUG();
@@ -176,14 +185,14 @@
 	pte_chain_lock(page);
 
 	if (PageDirect(page)) {
-		if (page->pte.direct == ptep) {
-			page->pte.direct = NULL;
+		if (page->pte.direct == paddr) {
+			page->pte.direct = (pte_addr_t)NULL;
 			ClearPageDirect(page);
 			goto out;
 		}
 	} else {
 		for (pc = page->pte.chain; pc; prev_pc = pc, pc = pc->next) {
-			if (pc->ptep == ptep) {
+			if (pc->ptep == paddr) {
 				pte_chain_free(pc, prev_pc, page);
 				/* Check whether we can convert to direct */
 				pc = page->pte.chain;
@@ -211,8 +220,8 @@
 #endif
 
 out:
-	dec_page_state(nr_reverse_maps);
 	pte_chain_unlock(page);
+	dec_page_state(nr_reverse_maps);
 	return;
 }
 
@@ -230,9 +239,10 @@
  *		pte_chain_lock		page_launder()
  *		    mm->page_table_lock	try_to_unmap_one(), trylock
  */
-static int FASTCALL(try_to_unmap_one(struct page *, pte_t *));
-static int try_to_unmap_one(struct page * page, pte_t * ptep)
+static int FASTCALL(try_to_unmap_one(struct page *, pte_addr_t));
+static int try_to_unmap_one(struct page * page, pte_addr_t paddr)
 {
+	pte_t *ptep = rmap_ptep_map(paddr);
 	unsigned long address = ptep_to_address(ptep);
 	struct mm_struct * mm = ptep_to_mm(ptep);
 	struct vm_area_struct * vma;
@@ -246,8 +256,11 @@
 	 * We need the page_table_lock to protect us from page faults,
 	 * munmap, fork, etc...
 	 */
-	if (!spin_trylock(&mm->page_table_lock))
+	if (!spin_trylock(&mm->page_table_lock)) {
+		rmap_ptep_unmap(ptep);
 		return SWAP_AGAIN;
+	}
+
 
 	/* During mremap, it's possible pages are not in a VMA. */
 	vma = find_vma(mm, address);
@@ -284,6 +297,7 @@
 	ret = SWAP_SUCCESS;
 
 out_unlock:
+	rmap_ptep_unmap(ptep);
 	spin_unlock(&mm->page_table_lock);
 	return ret;
 }
