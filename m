Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964846AbVJMBPe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964846AbVJMBPe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 21:15:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964845AbVJMBPd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 21:15:33 -0400
Received: from gold.veritas.com ([143.127.12.110]:57876 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S964847AbVJMBPd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 21:15:33 -0400
Date: Thu, 13 Oct 2005 02:14:47 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: Jeff Dike <jdike@addtoit.com>, Blaisorblade <blaisorblade@yahoo.it>,
       linux-kernel@vger.kernel.org
Subject: [PATCH 14/21] mm: pte_offset_map_lock loops
In-Reply-To: <Pine.LNX.4.61.0510130143240.4060@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.61.0510130213290.4343@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0510130143240.4060@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 13 Oct 2005 01:15:32.0695 (UTC) FILETIME=[9B8F9E70:01C5CF93]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Convert those common loops using page_table_lock on the outside and
pte_offset_map within to use just pte_offset_map_lock within instead.

These all hold mmap_sem (some exclusively, some not), so at no level can
a page table be whipped away from beneath them.  But whereas pte_alloc
loops tested with the "atomic" pmd_present, these loops are testing with
pmd_none, which on i386 PAE tests both lower and upper halves.

That's now unsafe, so add a cast into pmd_none to test only the vital
lower half: we lose a little sensitivity to a corrupt middle directory,
but not enough to worry about.  It appears that i386 and UML were the
only architectures vulnerable in this way, and pgd and pud no problem.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

 fs/proc/task_mmu.c         |   17 ++++++-----------
 include/asm-i386/pgtable.h |    3 ++-
 include/asm-um/pgtable.h   |    2 +-
 mm/mempolicy.c             |    7 +++----
 mm/mprotect.c              |    7 +++----
 mm/msync.c                 |   21 ++++++---------------
 mm/swapfile.c              |   20 +++++++++-----------
 7 files changed, 30 insertions(+), 47 deletions(-)

--- mm13/fs/proc/task_mmu.c	2005-10-11 23:54:33.000000000 +0100
+++ mm14/fs/proc/task_mmu.c	2005-10-11 23:57:10.000000000 +0100
@@ -203,13 +203,14 @@ static void smaps_pte_range(struct vm_ar
 				struct mem_size_stats *mss)
 {
 	pte_t *pte, ptent;
+	spinlock_t *ptl;
 	unsigned long pfn;
 	struct page *page;
 
-	pte = pte_offset_map(pmd, addr);
+	pte = pte_offset_map_lock(vma->vm_mm, pmd, addr, &ptl);
 	do {
 		ptent = *pte;
-		if (pte_none(ptent) || !pte_present(ptent))
+		if (!pte_present(ptent))
 			continue;
 
 		mss->resident += PAGE_SIZE;
@@ -230,8 +231,8 @@ static void smaps_pte_range(struct vm_ar
 				mss->private_clean += PAGE_SIZE;
 		}
 	} while (pte++, addr += PAGE_SIZE, addr != end);
-	pte_unmap(pte - 1);
-	cond_resched_lock(&vma->vm_mm->page_table_lock);
+	pte_unmap_unlock(pte - 1, ptl);
+	cond_resched();
 }
 
 static inline void smaps_pmd_range(struct vm_area_struct *vma, pud_t *pud,
@@ -285,17 +286,11 @@ static inline void smaps_pgd_range(struc
 static int show_smap(struct seq_file *m, void *v)
 {
 	struct vm_area_struct *vma = v;
-	struct mm_struct *mm = vma->vm_mm;
 	struct mem_size_stats mss;
 
 	memset(&mss, 0, sizeof mss);
-
-	if (mm) {
-		spin_lock(&mm->page_table_lock);
+	if (vma->vm_mm)
 		smaps_pgd_range(vma, vma->vm_start, vma->vm_end, &mss);
-		spin_unlock(&mm->page_table_lock);
-	}
-
 	return show_map_internal(m, v, &mss);
 }
 
--- mm13/include/asm-i386/pgtable.h	2005-09-30 11:59:09.000000000 +0100
+++ mm14/include/asm-i386/pgtable.h	2005-10-11 23:57:10.000000000 +0100
@@ -213,7 +213,8 @@ extern unsigned long pg0[];
 #define pte_present(x)	((x).pte_low & (_PAGE_PRESENT | _PAGE_PROTNONE))
 #define pte_clear(mm,addr,xp)	do { set_pte_at(mm, addr, xp, __pte(0)); } while (0)
 
-#define pmd_none(x)	(!pmd_val(x))
+/* To avoid harmful races, pmd_none(x) should check only the lower when PAE */
+#define pmd_none(x)	(!(unsigned long)pmd_val(x))
 #define pmd_present(x)	(pmd_val(x) & _PAGE_PRESENT)
 #define pmd_clear(xp)	do { set_pmd(xp, __pmd(0)); } while (0)
 #define	pmd_bad(x)	((pmd_val(x) & (~PAGE_MASK & ~_PAGE_USER)) != _KERNPG_TABLE)
--- mm13/include/asm-um/pgtable.h	2005-0OB9-30 11:59:10.000000000 +0100
+++ mm14/include/asm-um/pgtable.h	2005-10-11 23:57:10.000000000 +0100
@@ -138,7 +138,7 @@ extern unsigned long pg0[1024];
 
 #define pte_clear(mm,addr,xp) pte_set_val(*(xp), (phys_t) 0, __pgprot(_PAGE_NEWPAGE))
 
-#define pmd_none(x)	(!(pmd_val(x) & ~_PAGE_NEWPAGE))
+#define pmd_none(x)	(!((unsigned long)pmd_val(x) & ~_PAGE_NEWPAGE))
 #define	pmd_bad(x)	((pmd_val(x) & (~PAGE_MASK & ~_PAGE_USER)) != _KERNPG_TABLE)
 #define pmd_present(x)	(pmd_val(x) & _PAGE_PRESENT)
 #define pmd_clear(xp)	do { pmd_val(*(xp)) = _PAGE_NEWPAGE; } while (0)
--- mm13/mm/mempolicy.c	2005-10-11 12:16:50.000000000 +0100
+++ mm14/mm/mempolicy.c	2005-10-11 23:57:10.000000000 +0100
@@ -228,9 +228,9 @@ static int check_pte_range(struct vm_are
 {
 	pte_t *orig_pte;
 	pte_t *pte;
+	spinlock_t *ptl;
 
-	spin_lock(&vma->vm_mm->page_table_lock);
-	orig_pte = pte = pte_offset_map(pmd, addr);
+	orig_pte = pte = pte_offset_map_lock(vma->vm_mm, pmd, addr, &ptl);
 	do {
 		unsigned long pfn;
 		unsigned int nid;
@@ -246,8 +246,7 @@ static int check_pte_range(struct vm_are
 		if (!node_isset(nid, *nodes))
 			break;
 	} while (pte++, addr += PAGE_SIZE, addr != end);
-	pte_unmap(orig_pte);
-	spin_unlock(&vma->vm_mm->page_table_lock);
+	pte_unmap_unlock(orig_pte, ptl);
 	return addr != end;
 }
 
--- mm13/mm/mprotect.c	2005-10-11 12:16:50.000000000 +0100
+++ mm14/mm/mprotect.c	2005-10-11 23:57:10.000000000 +0100
@@ -29,8 +29,9 @@ static void change_pte_range(struct mm_s
 		unsigned long addr, unsigned long end, pgprot_t newprot)
 {
 	pte_t *pte;
+	spinlock_t *ptl;
 
-	pte = pte_offset_map(pmd, addr);
+	pte = pte_offset_map_lock(mm, pmd, addr, &ptl);
 	do {
 		if (pte_present(*pte)) {
 			pte_t ptent;
@@ -44,7 +45,7 @@ static void change_pte_range(struct mm_s
 			lazy_mmu_prot_update(ptent);
 		}
 	} while (pte++, addr += PAGE_SIZE, addr != end);
-	pte_unmap(pte - 1);
+	pte_unmap_unlock(pte - 1, ptl);
 }
 
 static inline void change_pmd_range(struct mm_struct *mm, pud_t *pud,
@@ -88,7 +89,6 @@ static void change_protection(struct vm_
 	BUG_ON(addr >= end);
 	pgd = pgd_offset(mm, addr);
 	flush_cache_range(vma, addr, end);
-	spin_lock(&mm->page_table_lock);
 	do {
 		next = pgd_addr_end(addr, end);
 		if (pgd_none_or_clear_bad(pgd))
@@ -96,7 +96,6 @@ static void change_protection(struct vm_
 		change_pud_range(mm, pgd, addr, next, newprot);
 	} while (pgd++, addr = next, addr != end);
 	flush_tlb_range(vma, start, end);
-	spin_unlock(&mm->page_table_lock);
 }
 
 static int
--- mm13/mm/msync.c	2005-10-11 12:16:50.000000000 +0100
+++ mm14/mm/msync.c	2005-10-11 23:57:10.000000000 +0100
@@ -17,28 +17,22 @@
 #include <asm/pgtable.h>
 #include <asm/tlbflush.h>
 
-/*
- * Called with mm->page_table_lock held to protect against other
- * threads/the swapper from ripping pte's out from under us.
- */
-
 static void msync_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
 				unsigned long addr, unsigned long end)
 {
-	struct mm_struct *mm = vma->vm_mm;
 	pte_t *pte;
+	spinlock_t *ptl;
 	int progress = 0;
 
 again:
-	pte = pte_offset_map(pmd, addr);
+	pte = pte_offset_map_lock(vma->vm_mm, pmd, addr, &ptl);
 	do {
 		unsigned long pfn;
 		struct page *page;
 
 		if (progress >= 64) {
 			progress = 0;
-			if (need_resched() ||
-			    need_lockbreak(&mm->page_table_lock))
+			if (need_resched() || need_lockbreak(ptl))
 				break;
 		}
 		progress++;
@@ -58,8 +52,8 @@ again:
 			set_page_dirty(page);
 		progress += 3;
 	} while (pte++, addr += PAGE_SIZE, addr != end);
-	pte_unmap(pte - 1);
-	cond_resched_lock(&mm->page_table_lock);
+	pte_unmap_unlock(pte - 1, ptl);
+	cond_resched();
 	if (addr != end)
 		goto again;
 }
@@ -97,7 +91,6 @@ static inline void msync_pud_range(struc
 static void msync_page_range(struct vm_area_struct *vma,
 				unsigned long addr, unsigned long end)
 {
-	struct mm_struct *mm = vma->vm_mm;
 	pgd_t *pgd;
 	unsigned long next;
 
@@ -110,16 +103,14 @@ static void msync_page_range(struct vm_a
 		return;
 
 	BUG_ON(addr >= end);
-	pgd = pgd_offset(mm, addr);
+	pgd = pgd_offset(vma->vm_mm, addr);
 	flush_cache_range(vma, addr, end);
-	spin_lock(&mm->page_table_lock);
 	do {
 		next = pgd_addr_end(addr, end);
 		if (pgd_none_or_clear_bad(pgd))
 			continue;
 		msync_pud_range(vma, pgd, addr, next);
 	} while (pgd++, addr = next, addr != end);
-	spin_unlock(&mm->page_table_lock);
 }
 
 /*
--- mm13/mm/swapfile.c	2005-09-30 11:59:12.000000000 +0100
+++ mm14/mm/swapfile.c	2005-10-11 23:57:10.000000000 +0100
@@ -399,8 +399,6 @@ void free_swap_and_cache(swp_entry_t ent
  * No need to decide whether this PTE shares the swap entry with others,
  * just let do_wp_page work it out if a write is requested later - to
  * force COW, vm_page_prot omits write permission from any private vma.
- *
- * vma->vm_mm->page_table_lock is held.
  */
 static void unuse_pte(struct vm_area_struct *vma, pte_t *pte,
 		unsigned long addr, swp_entry_t entry, struct page *page)
@@ -422,23 +420,25 @@ static int unuse_pte_range(struct vm_are
 				unsigned long addr, unsigned long end,
 				swp_entry_t entry, struct page *page)
 {
-	pte_t *pte;
 	pte_t swp_pte = swp_entry_to_pte(entry);
+	pte_t *pte;
+	spinlock_t *ptl;
+	int found = 0;
 
-	pte = pte_offset_map(pmd, addr);
+	pte = pte_offset_map_lock(vma->vm_mm, pmd, addr, &ptl);
 	do {
 		/*
 		 * swapoff spends a _lot_ of time in this loop!
 		 * Test inline before going to call unuse_pte.
 		 */
 		if (unlikely(pte_same(*pte, swp_pte))) {
-			unuse_pte(vma, pte, addr, entry, page);
-			pte_unmap(pte);
-			return 1;
+			unuse_pte(vma, pte++, addr, entry, page);
+			found = 1;
+			break;
 		}
 	} while (pte++, addr += PAGE_SIZE, addr != end);
-	pte_unmap(pte - 1);
-	return 0;
+	pte_unmap_unlock(pte - 1, ptl);
+	return found;
 }
 
 static inline int unuse_pmd_range(struct vm_area_struct *vma, pud_t *pud,
@@ -520,12 +520,10 @@ static int unuse_mm(struct mm_struct *mm
 		down_read(&mm->mmap_sem);
 		lock_page(page);
 	}
-	spin_lock(&mm->page_table_lock);
 	for (vma = mm->mmap; vma; vma = vma->vm_next) {
 		if (vma->anon_vma && unuse_vma(vma, entry, page))
 			break;
 	}
-	spin_unlock(&mm->page_table_lock);
 	up_read(&mm->mmap_sem);
 	/*
 	 * Currently unuse_mm cannot fail, but leave error handling
