Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262757AbVCWRRq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262757AbVCWRRq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 12:17:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262775AbVCWRRp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 12:17:45 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:40989 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S262757AbVCWRNe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 12:13:34 -0500
Date: Wed, 23 Mar 2005 17:12:25 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: akpm@osdl.org, davem@davemloft.net, tony.luck@intel.com,
       benh@kernel.crashing.org, ak@suse.de, linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] freepgt: remove MM_VM_SIZE(mm)
In-Reply-To: <Pine.LNX.4.61.0503231705560.15274@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.61.0503231711420.15274@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0503231705560.15274@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There's only one usage of MM_VM_SIZE(mm) left, and it's a troublesome
macro because mm doesn't contain the (32-bit emulation?) info needed.
But it too is only needed because we ignore the end from the vma list.

We could make flush_pgtables return that end, or unmap_vmas.  Choose the
latter, since it's a natural fit with unmap_mapping_range_vma needing to
know its restart addr.  This does make more than minimal change, but if
unmap_vmas had returned the end before, this is how we'd have done it,
rather than storing the break_addr in zap_details.

unmap_vmas used to return count of vmas scanned, but that's just debug
which hasn't been useful in a while; and if we want the map_count 0 on
exit check back, it can easily come from the final remove_vm_struct loop.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

 include/asm-ia64/processor.h  |    8 --------
 include/asm-ppc64/processor.h |    4 ----
 include/asm-s390/processor.h  |    2 --
 include/linux/mm.h            |    9 ++-------
 mm/memory.c                   |   28 +++++++++++++---------------
 mm/mmap.c                     |    6 +++---
 6 files changed, 18 insertions(+), 39 deletions(-)

--- freepgt1/include/asm-ia64/processor.h	2004-12-24 21:36:47.000000000 +0000
+++ freepgt2/include/asm-ia64/processor.h	2005-03-21 19:06:48.000000000 +0000
@@ -43,14 +43,6 @@
 #define TASK_SIZE		(current->thread.task_size)
 
 /*
- * MM_VM_SIZE(mm) gives the maximum address (plus 1) which may contain a mapping for
- * address-space MM.  Note that with 32-bit tasks, this is still DEFAULT_TASK_SIZE,
- * because the kernel may have installed helper-mappings above TASK_SIZE.  For example,
- * for x86 emulation, the LDT and GDT are mapped above TASK_SIZE.
- */
-#define MM_VM_SIZE(mm)		DEFAULT_TASK_SIZE
-
-/*
  * This decides where the kernel will search for a free chunk of vm
  * space during mmap's.
  */
--- freepgt1/include/asm-ppc64/processor.h	2005-03-18 10:22:41.000000000 +0000
+++ freepgt2/include/asm-ppc64/processor.h	2005-03-21 19:06:48.000000000 +0000
@@ -542,10 +542,6 @@ extern struct task_struct *last_task_use
 #define TASK_SIZE (test_thread_flag(TIF_32BIT) ? \
 		TASK_SIZE_USER32 : TASK_SIZE_USER64)
 
-/* We can't actually tell the TASK_SIZE given just the mm, but default
- * to the 64-bit case to make sure that enough gets cleaned up. */
-#define MM_VM_SIZE(mm)	TASK_SIZE_USER64
-
 /* This decides where the kernel will search for a free chunk of vm
  * space during mmap's.
  */
--- freepgt1/include/asm-s390/processor.h	2004-10-18 22:56:29.000000000 +0100
+++ freepgt2/include/asm-s390/processor.h	2005-03-21 19:06:48.000000000 +0000
@@ -74,8 +74,6 @@ extern struct task_struct *last_task_use
 
 #endif /* __s390x__ */
 
-#define MM_VM_SIZE(mm)		DEFAULT_TASK_SIZE
-
 #define HAVE_ARCH_PICK_MMAP_LAYOUT
 
 typedef struct {
--- freepgt1/include/linux/mm.h	2005-03-21 19:06:35.000000000 +0000
+++ freepgt2/include/linux/mm.h	2005-03-21 19:06:48.000000000 +0000
@@ -37,10 +37,6 @@ extern int sysctl_legacy_va_layout;
 #include <asm/processor.h>
 #include <asm/atomic.h>
 
-#ifndef MM_VM_SIZE
-#define MM_VM_SIZE(mm)	((TASK_SIZE + PGDIR_SIZE - 1) & PGDIR_MASK)
-#endif
-
 #define nth_page(page,n) pfn_to_page(page_to_pfn((page)) + (n))
 
 /*
@@ -581,13 +577,12 @@ struct zap_details {
 	pgoff_t	first_index;			/* Lowest page->index to unmap */
 	pgoff_t last_index;			/* Highest page->index to unmap */
 	spinlock_t *i_mmap_lock;		/* For unmap_mapping_range: */
-	unsigned long break_addr;		/* Where unmap_vmas stopped */
 	unsigned long truncate_count;		/* Compare vm_truncate_count */
 };
 
-void zap_page_range(struct vm_area_struct *vma, unsigned long address,
+unsigned long zap_page_range(struct vm_area_struct *vma, unsigned long address,
 		unsigned long size, struct zap_details *);
-int unmap_vmas(struct mmu_gather **tlbp, struct mm_struct *mm,
+unsigned long unmap_vmas(struct mmu_gather **tlb, struct mm_struct *mm,
 		struct vm_area_struct *start_vma, unsigned long start_addr,
 		unsigned long end_addr, unsigned long *nr_accounted,
 		struct zap_details *);
--- freepgt1/mm/memory.c	2005-03-23 15:27:19.000000000 +0000
+++ freepgt2/mm/memory.c	2005-03-23 15:27:53.000000000 +0000
@@ -645,7 +645,7 @@ static void unmap_page_range(struct mmu_
  * @nr_accounted: Place number of unmapped pages in vm-accountable vma's here
  * @details: details of nonlinear truncation or shared cache invalidation
  *
- * Returns the number of vma's which were covered by the unmapping.
+ * Returns the end address of the unmapping (restart addr if interrupted).
  *
  * Unmap all pages in the vma list.  Called under page_table_lock.
  *
@@ -662,7 +662,7 @@ static void unmap_page_range(struct mmu_
  * ensure that any thus-far unmapped pages are flushed before unmap_vmas()
  * drops the lock and schedules.
  */
-int unmap_vmas(struct mmu_gather **tlbp, struct mm_struct *mm,
+unsigned long unmap_vmas(struct mmu_gather **tlbp, struct mm_struct *mm,
 		struct vm_area_struct *vma, unsigned long start_addr,
 		unsigned long end_addr, unsigned long *nr_accounted,
 		struct zap_details *details)
@@ -670,12 +670,11 @@ int unmap_vmas(struct mmu_gather **tlbp,
 	unsigned long zap_bytes = ZAP_BLOCK_SIZE;
 	unsigned long tlb_start = 0;	/* For tlb_finish_mmu */
 	int tlb_start_valid = 0;
-	int ret = 0;
+	unsigned long start = start_addr;
 	spinlock_t *i_mmap_lock = details? details->i_mmap_lock: NULL;
 	int fullmm = tlb_is_full_mm(*tlbp);
 
 	for ( ; vma && vma->vm_start < end_addr; vma = vma->vm_next) {
-		unsigned long start;
 		unsigned long end;
 
 		start = max(vma->vm_start, start_addr);
@@ -688,7 +687,6 @@ int unmap_vmas(struct mmu_gather **tlbp,
 		if (vma->vm_flags & VM_ACCOUNT)
 			*nr_accounted += (end - start) >> PAGE_SHIFT;
 
-		ret++;
 		while (start != end) {
 			unsigned long block;
 
@@ -719,7 +717,6 @@ int unmap_vmas(struct mmu_gather **tlbp,
 				if (i_mmap_lock) {
 					/* must reset count of rss freed */
 					*tlbp = tlb_gather_mmu(mm, fullmm);
-					details->break_addr = start;
 					goto out;
 				}
 				spin_unlock(&mm->page_table_lock);
@@ -733,7 +730,7 @@ int unmap_vmas(struct mmu_gather **tlbp,
 		}
 	}
 out:
-	return ret;
+	return start;	/* which is now the end (or restart) address */
 }
 
 /**
@@ -743,7 +740,7 @@ out:
  * @size: number of bytes to zap
  * @details: details of nonlinear truncation or shared cache invalidation
  */
-void zap_page_range(struct vm_area_struct *vma, unsigned long address,
+unsigned long zap_page_range(struct vm_area_struct *vma, unsigned long address,
 		unsigned long size, struct zap_details *details)
 {
 	struct mm_struct *mm = vma->vm_mm;
@@ -753,15 +750,16 @@ void zap_page_range(struct vm_area_struc
 
 	if (is_vm_hugetlb_page(vma)) {
 		zap_hugepage_range(vma, address, size);
-		return;
+		return end;
 	}
 
 	lru_add_drain();
 	spin_lock(&mm->page_table_lock);
 	tlb = tlb_gather_mmu(mm, 0);
-	unmap_vmas(&tlb, mm, vma, address, end, &nr_accounted, details);
+	end = unmap_vmas(&tlb, mm, vma, address, end, &nr_accounted, details);
 	tlb_finish_mmu(tlb, address, end);
 	spin_unlock(&mm->page_table_lock);
+	return end;
 }
 
 /*
@@ -1346,7 +1344,7 @@ no_new_page:
  * i_mmap_lock.
  *
  * In order to make forward progress despite repeatedly restarting some
- * large vma, note the break_addr set by unmap_vmas when it breaks out:
+ * large vma, note the restart_addr from unmap_vmas when it breaks out:
  * and restart from that address when we reach that vma again.  It might
  * have been split or merged, shrunk or extended, but never shifted: so
  * restart_addr remains valid so long as it remains in the vma's range.
@@ -1384,8 +1382,8 @@ again:
 		}
 	}
 
-	details->break_addr = end_addr;
-	zap_page_range(vma, start_addr, end_addr - start_addr, details);
+	restart_addr = zap_page_range(vma, start_addr,
+					end_addr - start_addr, details);
 
 	/*
 	 * We cannot rely on the break test in unmap_vmas:
@@ -1396,14 +1394,14 @@ again:
 	need_break = need_resched() ||
 			need_lockbreak(details->i_mmap_lock);
 
-	if (details->break_addr >= end_addr) {
+	if (restart_addr >= end_addr) {
 		/* We have now completed this vma: mark it so */
 		vma->vm_truncate_count = details->truncate_count;
 		if (!need_break)
 			return 0;
 	} else {
 		/* Note restart_addr in vma's truncate_count field */
-		vma->vm_truncate_count = details->break_addr;
+		vma->vm_truncate_count = restart_addr;
 		if (!need_break)
 			goto again;
 	}
--- freepgt1/mm/mmap.c	2005-03-21 19:06:35.000000000 +0000
+++ freepgt2/mm/mmap.c	2005-03-21 19:06:48.000000000 +0000
@@ -1900,6 +1900,7 @@ void exit_mmap(struct mm_struct *mm)
 	struct mmu_gather *tlb;
 	struct vm_area_struct *vma = mm->mmap;
 	unsigned long nr_accounted = 0;
+	unsigned long end;
 
 	lru_add_drain();
 
@@ -1908,10 +1909,10 @@ void exit_mmap(struct mm_struct *mm)
 	flush_cache_mm(mm);
 	tlb = tlb_gather_mmu(mm, 1);
 	/* Use -1 here to ensure all VMAs in the mm are unmapped */
-	mm->map_count -= unmap_vmas(&tlb, mm, vma, 0, -1, &nr_accounted, NULL);
+	end = unmap_vmas(&tlb, mm, vma, 0, -1, &nr_accounted, NULL);
 	vm_unacct_memory(nr_accounted);
 	free_pgtables(&tlb, vma, 0, 0);
-	tlb_finish_mmu(tlb, 0, MM_VM_SIZE(mm));
+	tlb_finish_mmu(tlb, 0, end);
 
 	mm->mmap = mm->mmap_cache = NULL;
 	mm->mm_rb = RB_ROOT;
@@ -1931,7 +1932,6 @@ void exit_mmap(struct mm_struct *mm)
 		vma = next;
 	}
 
-	BUG_ON(mm->map_count);	/* This is just debugging */
 	BUG_ON(mm->nr_ptes);	/* This is just debugging */
 }
 
