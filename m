Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964849AbVJMBTi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964849AbVJMBTi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 21:19:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964852AbVJMBTi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 21:19:38 -0400
Received: from gold.veritas.com ([143.127.12.110]:16149 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S964849AbVJMBTh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 21:19:37 -0400
Date: Thu, 13 Oct 2005 02:18:52 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: William Irwin <wli@holomorphy.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 17/21] mm: unmap_vmas with inner ptlock
In-Reply-To: <Pine.LNX.4.61.0510130143240.4060@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.61.0510130217420.4343@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0510130143240.4060@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 13 Oct 2005 01:19:36.0852 (UTC) FILETIME=[2D170540:01C5CF94]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the page_table_lock from around the calls to unmap_vmas, and
replace the pte_offset_map in zap_pte_range by pte_offset_map_lock:
all callers are now safe to descend without page_table_lock.

Don't attempt fancy locking for hugepages, just take page_table_lock in
unmap_hugepage_range.  Which makes zap_hugepage_range, and the hugetlb
test in zap_page_range, redundant: unmap_vmas calls unmap_hugepage_range
anyway.  Nor does unmap_vmas have much use for its mm arg now.

The tlb_start_vma and tlb_end_vma in unmap_page_range are now called
without page_table_lock: if they're implemented at all, they typically
come down to flush_cache_range (usually done outside page_table_lock)
and flush_tlb_range (which we already audited for the mprotect case).

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

 fs/hugetlbfs/inode.c    |    4 ++--
 include/linux/hugetlb.h |    2 --
 include/linux/mm.h      |    2 +-
 mm/hugetlb.c            |   12 +++---------
 mm/memory.c             |   41 ++++++++++++-----------------------------
 mm/mmap.c               |    8 ++------
 6 files changed, 20 insertions(+), 49 deletions(-)

--- mm16/fs/hugetlbfs/inode.c	2005-09-30 11:59:08.000000000 +0100
+++ mm17/fs/hugetlbfs/inode.c	2005-10-11 23:57:59.000000000 +0100
@@ -92,7 +92,7 @@ out:
 }
 
 /*
- * Called under down_write(mmap_sem), page_table_lock is not held
+ * Called under down_write(mmap_sem).
  */
 
 #ifdef HAVE_ARCH_HUGETLB_UNMAPPED_AREA
@@ -297,7 +297,7 @@ hugetlb_vmtruncate_list(struct prio_tree
 
 		v_length = vma->vm_end - vma->vm_start;
 
-		zap_hugepage_range(vma,
+		unmap_hugepage_range(vma,
 				vma->vm_start + v_offset,
 				v_length - v_offset);
 	}
--- mm16/include/linux/hugetlb.h	2005-09-21 12:16:56.000000000 +0100
+++ mm17/include/linux/hugetlb.h	2005-10-11 23:57:59.000000000 +0100
@@ -16,7 +16,6 @@ static inline int is_vm_hugetlb_page(str
 int hugetlb_sysctl_handler(struct ctl_table *, int, struct file *, void __user *, size_t *, loff_t *);
 int copy_hugetlb_page_range(struct mm_struct *, struct mm_struct *, struct vm_area_struct *);
 int follow_hugetlb_page(struct mm_struct *, struct vm_area_struct *, struct page **, struct vm_area_struct **, unsigned long *, int *, int);
-void zap_hugepage_range(struct vm_area_struct *, unsigned long, unsigned long);
 void unmap_hugepage_range(struct vm_area_struct *, unsigned long, unsigned long);
 int hugetlb_prefault(struct address_space *, struct vm_area_struct *);
 int hugetlb_report_meminfo(char *);
@@ -85,7 +84,6 @@ static inline unsigned long hugetlb_tota
 #define follow_huge_addr(mm, addr, write)	ERR_PTR(-EINVAL)
 #define copy_hugetlb_page_range(src, dst, vma)	({ BUG(); 0; })
 #define hugetlb_prefault(mapping, vma)		({ BUG(); 0; })
-#define zap_hugepage_range(vma, start, len)	BUG()
 #define unmap_hugepage_range(vma, start, end)	BUG()
 #define is_hugepage_mem_enough(size)		0
 #define hugetlb_report_meminfo(buf)		0
--- mm16/include/linux/mm.h	2005-10-11 23:56:25.000000000 +0100
+++ mm17/include/linux/mm.h	2005-10-11 23:57:59.000000000 +0100
@@ -687,7 +687,7 @@ struct zap_details {
 
 unsigned long zap_page_range(struct vm_area_struct *vma, unsigned long address,
 		unsigned long size, struct zap_details *);
-unsigned long unmap_vmas(struct mmu_gather **tlb, struct mm_struct *mm,
+unsigned long unmap_vmas(struct mmu_gather **tlb,
 		struct vm_area_struct *start_vma, unsigned long start_addr,
 		unsigned long end_addr, unsigned long *nr_accounted,
 		struct zap_details *);
--- mm16/mm/hugetlb.c	2005-10-11 23:56:25.000000000 +0100
+++ mm17/mm/hugetlb.c	2005-10-11 23:57:59.000000000 +0100
@@ -313,6 +313,8 @@ void unmap_hugepage_range(struct vm_area
 	BUG_ON(start & ~HPAGE_MASK);
 	BUG_ON(end & ~HPAGE_MASK);
 
+	spin_lock(&mm->page_table_lock);
+
 	/* Update high watermark before we lower rss */
 	update_hiwater_rss(mm);
 
@@ -332,17 +334,9 @@ void unmap_hugepage_range(struct vm_area
 		put_page(page);
 		add_mm_counter(mm, file_rss,  - (HPAGE_SIZE / PAGE_SIZE));
 	}
-	flush_tlb_range(vma, start, end);
-}
 
-void zap_hugepage_range(struct vm_area_struct *vma,
-			unsigned long start, unsigned long length)
-{
-	struct mm_struct *mm = vma->vm_mm;
-
-	spin_lock(&mm->page_table_lock);
-	unmap_hugepage_range(vma, start, start + length);
 	spin_unlock(&mm->page_table_lock);
+	flush_tlb_range(vma, start, end);
 }
 
 int hugetlb_prefault(struct address_space *mapping, struct vm_area_struct *vma)
--- mm16/mm/memory.c	2005-10-11 23:57:45.000000000 +0100
+++ mm17/mm/memory.c	2005-10-11 23:57:59.000000000 +0100
@@ -551,10 +551,11 @@ static void zap_pte_range(struct mmu_gat
 {
 	struct mm_struct *mm = tlb->mm;
 	pte_t *pte;
+	spinlock_t *ptl;
 	int file_rss = 0;
 	int anon_rss = 0;
 
-	pte = pte_offset_map(pmd, addr);
+	pte = pte_offset_map_lock(mm, pmd, addr, &ptl);
 	do {
 		pte_t ptent = *pte;
 		if (pte_none(ptent))
@@ -621,7 +622,7 @@ static void zap_pte_range(struct mmu_gat
 	} while (pte++, addr += PAGE_SIZE, addr != end);
 
 	add_mm_rss(mm, file_rss, anon_rss);
-	pte_unmap(pte - 1);
+	pte_unmap_unlock(pte - 1, ptl);
 }
 
 static inline void zap_pmd_range(struct mmu_gather *tlb,
@@ -690,7 +691,6 @@ static void unmap_page_range(struct mmu_
 /**
  * unmap_vmas - unmap a range of memory covered by a list of vma's
  * @tlbp: address of the caller's struct mmu_gather
- * @mm: the controlling mm_struct
  * @vma: the starting vma
  * @start_addr: virtual address at which to start unmapping
  * @end_addr: virtual address at which to end unmapping
@@ -699,10 +699,10 @@ static void unmap_page_range(struct mmu_
  *
  * Returns the end address of the unmapping (restart addr if interrupted).
  *
- * Unmap all pages in the vma list.  Called under page_table_lock.
+ * Unmap all pages in the vma list.
  *
- * We aim to not hold page_table_lock for too long (for scheduling latency
- * reasons).  So zap pages in ZAP_BLOCK_SIZE bytecounts.  This means we need to
+ * We aim to not hold locks for too long (for scheduling latency reasons).
+ * So zap pages in ZAP_BLOCK_SIZE bytecounts.  This means we need to
  * return the ending mmu_gather to the caller.
  *
  * Only addresses between `start' and `end' will be unmapped.
@@ -714,7 +714,7 @@ static void unmap_page_range(struct mmu_
  * ensure that any thus-far unmapped pages are flushed before unmap_vmas()
  * drops the lock and schedules.
  */
-unsigned long unmap_vmas(struct mmu_gather **tlbp, struct mm_struct *mm,
+unsigned long unmap_vmas(struct mmu_gather **tlbp,
 		struct vm_area_struct *vma, unsigned long start_addr,
 		unsigned long end_addr, unsigned long *nr_accounted,
 		struct zap_details *details)
@@ -764,19 +764,15 @@ unsigned long unmap_vmas(struct mmu_gath
 			tlb_finish_mmu(*tlbp, tlb_start, start);
 
 			if (need_resched() ||
-				need_lockbreak(&mm->page_table_lock) ||
 				(i_mmap_lock && need_lockbreak(i_mmap_lock))) {
 				if (i_mmap_lock) {
-					/* must reset count of rss freed */
-					*tlbp = tlb_gather_mmu(mm, fullmm);
+					*tlbp = NULL;
 					goto out;
 				}
-				spin_unlock(&mm->page_table_lock);
 				cond_resched();
-				spin_lock(&mm->page_table_lock);
 			}
 
-			*tlbp = tlb_gather_mmu(mm, fullmm);
+			*tlbp = tlb_gather_mmu(vma->vm_mm, fullmm);
 			tlb_start_valid = 0;
 			zap_bytes = ZAP_BLOCK_SIZE;
 		}
@@ -800,18 +796,12 @@ unsigned long zap_page_range(struct vm_a
 	unsigned long end = address + size;
 	unsigned long nr_accounted = 0;
 
-	if (is_vm_hugetlb_page(vma)) {
-		zap_hugepage_range(vma, address, size);
-		return end;
-	}
-
 	lru_add_drain();
 	tlb = tlb_gather_mmu(mm, 0);
 	update_hiwater_rss(mm);
-	spin_lock(&mm->page_table_lock);
-	end = unmap_vmas(&tlb, mm, vma, address, end, &nr_accounted, details);
-	spin_unlock(&mm->page_table_lock);
-	tlb_finish_mmu(tlb, address, end);
+	end = unmap_vmas(&tlb, vma, address, end, &nr_accounted, details);
+	if (tlb)
+		tlb_finish_mmu(tlb, address, end);
 	return end;
 }
 
@@ -1434,13 +1424,6 @@ again:
 
 	restart_addr = zap_page_range(vma, start_addr,
 					end_addr - start_addr, details);
-
-	/*
-	 * We cannot rely on the break test in unmap_vmas:
-	 * on the one hand, we don't want to restart our loop
-	 * just because that broke out for the page_table_lock;
-	 * on the other hand, it does no test when vma is small.
-	 */
 	need_break = need_resched() ||
 			need_lockbreak(details->i_mmap_lock);
 
--- mm16/mm/mmap.c	2005-10-11 23:57:46.000000000 +0100
+++ mm17/mm/mmap.c	2005-10-11 23:57:59.000000000 +0100
@@ -1669,9 +1669,7 @@ static void unmap_region(struct mm_struc
 	lru_add_drain();
 	tlb = tlb_gather_mmu(mm, 0);
 	update_hiwater_rss(mm);
-	spin_lock(&mm->page_table_lock);
-	unmap_vmas(&tlb, mm, vma, start, end, &nr_accounted, NULL);
-	spin_unlock(&mm->page_table_lock);
+	unmap_vmas(&tlb, vma, start, end, &nr_accounted, NULL);
 	vm_unacct_memory(nr_accounted);
 	free_pgtables(&tlb, vma, prev? prev->vm_end: FIRST_USER_ADDRESS,
 				 next? next->vm_start: 0);
@@ -1954,9 +1952,7 @@ void exit_mmap(struct mm_struct *mm)
 	tlb = tlb_gather_mmu(mm, 1);
 	/* Don't update_hiwater_rss(mm) here, do_exit already did */
 	/* Use -1 here to ensure all VMAs in the mm are unmapped */
-	spin_lock(&mm->page_table_lock);
-	end = unmap_vmas(&tlb, mm, vma, 0, -1, &nr_accounted, NULL);
-	spin_unlock(&mm->page_table_lock);
+	end = unmap_vmas(&tlb, vma, 0, -1, &nr_accounted, NULL);
 	vm_unacct_memory(nr_accounted);
 	free_pgtables(&tlb, vma, FIRST_USER_ADDRESS, 0);
 	tlb_finish_mmu(tlb, 0, end);
