Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261998AbVCUVkW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261998AbVCUVkW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 16:40:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261880AbVCUVKe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 16:10:34 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:24920 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261889AbVCUU5r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 15:57:47 -0500
Date: Mon, 21 Mar 2005 20:56:39 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: Nick Piggin <nickpiggin@yahoo.com.au>,
       "David S. Miller" <davem@davemloft.net>,
       "Luck, Tony" <tony.luck@intel.com>,
       Ben Herrenschmidt <benh@kernel.crashing.org>,
       linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] freepgt: hugetlb_free_pgd_range
In-Reply-To: <Pine.LNX.4.61.0503212048040.1970@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.61.0503212055400.1970@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0503212048040.1970@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ia64 and ppc64 had hugetlb_free_pgtables functions which were no longer
being called, and it wasn't obvious what to do about them.

The ppc64 case turns out to be easy: the associated tables are noted
elsewhere and freed later, safe to either skip its hugetlb areas or go
through the motions of freeing nothing.  Since ia64 does need a special
case, restore to ppc64 the special case of skipping them.

The ia64 hugetlb case has been broken since pgd_addr_end went in, though
it probably appeared to work okay if you just had one such area; in fact
it's been broken much longer if you consider a long munmap spanning from
another region into the hugetlb region.

In the ia64 hugetlb region, more virtual address bits are available than
in the other regions, yet the page tables are structured the same way:
the page at the bottom is larger.  Here we need to scale down each addr
before passing it to the standard free_pgd_range.  Was about to write a
hugely_scaled_down macro, but found htlbpage_to_page already exists for
just this purpose.  Fixed off-by-one in ia64 is_hugepage_only_range.

Uninline free_pgd_range to make it available to ia64.  Make sure the
vma-gathering loop in free_pgtables cannot join a hugepage_only_range
to any other (safe to join huges? probably but don't bother).

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

 arch/ia64/mm/hugetlbpage.c  |   29 +++++++++++++++++++++++------
 arch/ppc64/mm/hugetlbpage.c |   10 ----------
 include/asm-ia64/page.h     |    2 +-
 include/asm-ia64/pgtable.h  |    4 ++--
 include/asm-ppc64/pgtable.h |   12 +++++++++---
 include/linux/hugetlb.h     |    6 ++++--
 include/linux/mm.h          |    4 +++-
 mm/memory.c                 |   30 +++++++++++++++++++-----------
 8 files changed, 61 insertions(+), 36 deletions(-)

--- freepgt2/arch/ia64/mm/hugetlbpage.c	2005-03-21 19:06:35.000000000 +0000
+++ freepgt3/arch/ia64/mm/hugetlbpage.c	2005-03-21 19:07:01.000000000 +0000
@@ -186,13 +186,30 @@ follow_huge_pmd(struct mm_struct *mm, un
 	return NULL;
 }
 
-/*
- * Do nothing, until we've worked out what to do!  To allow build, we
- * must remove reference to clear_page_range since it no longer exists.
- */
-void hugetlb_free_pgtables(struct mmu_gather *tlb, struct vm_area_struct *prev,
-	unsigned long start, unsigned long end)
+void hugetlb_free_pgd_range(struct mmu_gather **tlb,
+			unsigned long addr, unsigned long end,
+			unsigned long floor, unsigned long ceiling)
 {
+	/*
+	 * This is called only when is_hugepage_only_range(addr,),
+	 * and it follows that is_hugepage_only_range(end,) also.
+	 *
+	 * The offset of these addresses from the base of the hugetlb
+	 * region must be scaled down by HPAGE_SIZE/PAGE_SIZE so that
+	 * the standard free_pgd_range will free the right page tables.
+	 *
+	 * If floor and ceiling are also in the hugetlb region, they
+	 * must likewise be scaled down; but if outside, left unchanged.
+	 */
+
+	addr = htlbpage_to_page(addr);
+	end  = htlbpage_to_page(end);
+	if (is_hugepage_only_range(floor, HPAGE_SIZE))
+		floor = htlbpage_to_page(floor);
+	if (is_hugepage_only_range(ceiling, HPAGE_SIZE))
+		ceiling = htlbpage_to_page(ceiling);
+
+	free_pgd_range(tlb, addr, end, floor, ceiling);
 }
 
 void unmap_hugepage_range(struct vm_area_struct *vma, unsigned long start, unsigned long end)
--- freepgt2/arch/ppc64/mm/hugetlbpage.c	2005-03-18 10:22:20.000000000 +0000
+++ freepgt3/arch/ppc64/mm/hugetlbpage.c	2005-03-21 19:07:01.000000000 +0000
@@ -430,16 +430,6 @@ void unmap_hugepage_range(struct vm_area
 	flush_tlb_pending();
 }
 
-void hugetlb_free_pgtables(struct mmu_gather *tlb, struct vm_area_struct *prev,
-			   unsigned long start, unsigned long end)
-{
-	/* Because the huge pgtables are only 2 level, they can take
-	 * at most around 4M, much less than one hugepage which the
-	 * process is presumably entitled to use.  So we don't bother
-	 * freeing up the pagetables on unmap, and wait until
-	 * destroy_context() to clean up the lot. */
-}
-
 int hugetlb_prefault(struct address_space *mapping, struct vm_area_struct *vma)
 {
 	struct mm_struct *mm = current->mm;
--- freepgt2/include/asm-ia64/page.h	2005-03-02 07:38:52.000000000 +0000
+++ freepgt3/include/asm-ia64/page.h	2005-03-21 19:07:01.000000000 +0000
@@ -139,7 +139,7 @@ typedef union ia64_va {
 # define HUGETLB_PAGE_ORDER	(HPAGE_SHIFT - PAGE_SHIFT)
 # define is_hugepage_only_range(addr, len)		\
 	 (REGION_NUMBER(addr) == REGION_HPAGE &&	\
-	  REGION_NUMBER((addr)+(len)) == REGION_HPAGE)
+	  REGION_NUMBER((addr)+(len)-1) == REGION_HPAGE)
 extern unsigned int hpage_shift;
 #endif
 
--- freepgt2/include/asm-ia64/pgtable.h	2005-03-19 14:50:08.000000000 +0000
+++ freepgt3/include/asm-ia64/pgtable.h	2005-03-21 19:07:01.000000000 +0000
@@ -463,8 +463,8 @@ extern struct page *zero_page_memmap_ptr
 #define HUGETLB_PGDIR_SIZE	(__IA64_UL(1) << HUGETLB_PGDIR_SHIFT)
 #define HUGETLB_PGDIR_MASK	(~(HUGETLB_PGDIR_SIZE-1))
 struct mmu_gather;
-extern void hugetlb_free_pgtables(struct mmu_gather *tlb,
-	struct vm_area_struct * prev, unsigned long start, unsigned long end);
+void hugetlb_free_pgd_range(struct mmu_gather **tlb, unsigned long addr,
+		unsigned long end, unsigned long floor, unsigned long ceiling);
 #endif
 
 /*
--- freepgt2/include/asm-ppc64/pgtable.h	2005-03-18 10:22:41.000000000 +0000
+++ freepgt3/include/asm-ppc64/pgtable.h	2005-03-21 19:07:01.000000000 +0000
@@ -492,9 +492,15 @@ extern pgd_t ioremap_dir[1024];
 
 extern void paging_init(void);
 
-struct mmu_gather;
-void hugetlb_free_pgtables(struct mmu_gather *tlb, struct vm_area_struct *prev,
-			   unsigned long start, unsigned long end);
+/*
+ * Because the huge pgtables are only 2 level, they can take
+ * at most around 4M, much less than one hugepage which the
+ * process is presumably entitled to use.  So we don't bother
+ * freeing up the pagetables on unmap, and wait until
+ * destroy_context() to clean up the lot.
+ */
+#define hugetlb_free_pgd_range(tlb, addr, end, floor, ceiling) \
+						do { } while (0)
 
 /*
  * This gets called at the end of handling a page fault, when
--- freepgt2/include/linux/hugetlb.h	2004-08-14 06:39:00.000000000 +0100
+++ freepgt3/include/linux/hugetlb.h	2005-03-21 19:07:01.000000000 +0000
@@ -37,7 +37,8 @@ extern int sysctl_hugetlb_shm_group;
 
 #ifndef ARCH_HAS_HUGEPAGE_ONLY_RANGE
 #define is_hugepage_only_range(addr, len)	0
-#define hugetlb_free_pgtables(tlb, prev, start, end) do { } while (0)
+#define hugetlb_free_pgd_range(tlb, addr, end, floor, ceiling) \
+						do { } while (0)
 #endif
 
 #ifndef ARCH_HAS_PREPARE_HUGEPAGE_RANGE
@@ -72,7 +73,8 @@ static inline unsigned long hugetlb_tota
 #define prepare_hugepage_range(addr, len)	(-EINVAL)
 #define pmd_huge(x)	0
 #define is_hugepage_only_range(addr, len)	0
-#define hugetlb_free_pgtables(tlb, prev, start, end) do { } while (0)
+#define hugetlb_free_pgd_range(tlb, addr, end, floor, ceiling) \
+						do { } while (0)
 #define alloc_huge_page()			({ NULL; })
 #define free_huge_page(p)			({ (void)(p); BUG(); })
 
--- freepgt2/include/linux/mm.h	2005-03-21 19:06:48.000000000 +0000
+++ freepgt3/include/linux/mm.h	2005-03-21 19:07:01.000000000 +0000
@@ -586,7 +586,9 @@ unsigned long unmap_vmas(struct mmu_gath
 		struct vm_area_struct *start_vma, unsigned long start_addr,
 		unsigned long end_addr, unsigned long *nr_accounted,
 		struct zap_details *);
-void free_pgtables(struct mmu_gather **tlb, struct vm_area_struct *vma,
+void free_pgd_range(struct mmu_gather **tlb, unsigned long addr,
+		unsigned long end, unsigned long floor, unsigned long ceiling);
+void free_pgtables(struct mmu_gather **tlb, struct vm_area_struct *start_vma,
 		unsigned long floor, unsigned long ceiling);
 int copy_page_range(struct mm_struct *dst, struct mm_struct *src,
 			struct vm_area_struct *vma);
--- freepgt2/mm/memory.c	2005-03-21 19:06:48.000000000 +0000
+++ freepgt3/mm/memory.c	2005-03-21 19:07:01.000000000 +0000
@@ -187,7 +187,7 @@ static inline void free_pud_range(struct
  *
  * Must be called with pagetable lock held.
  */
-static inline void free_pgd_range(struct mmu_gather *tlb,
+void free_pgd_range(struct mmu_gather **tlb,
 			unsigned long addr, unsigned long end,
 			unsigned long floor, unsigned long ceiling)
 {
@@ -206,16 +206,16 @@ static inline void free_pgd_range(struct
 		return;
 
 	start = addr;
-	pgd = pgd_offset(tlb->mm, addr);
+	pgd = pgd_offset((*tlb)->mm, addr);
 	do {
 		next = pgd_addr_end(addr, end);
 		if (pgd_none_or_clear_bad(pgd))
 			continue;
-		free_pud_range(tlb, pgd, addr, next, floor, ceiling);
+		free_pud_range(*tlb, pgd, addr, next, floor, ceiling);
 	} while (pgd++, addr = next, addr != end);
 
-	if (!tlb_is_full_mm(tlb))
-		flush_tlb_pgtables(tlb->mm, start, end);
+	if (!tlb_is_full_mm(*tlb))
+		flush_tlb_pgtables((*tlb)->mm, start, end);
 }
 
 void free_pgtables(struct mmu_gather **tlb, struct vm_area_struct *vma,
@@ -225,13 +225,21 @@ void free_pgtables(struct mmu_gather **t
 		struct vm_area_struct *next = vma->vm_next;
 		unsigned long addr = vma->vm_start;
 
-		/* Optimization: gather nearby vmas into a single call down */
-		while (next && next->vm_start <= vma->vm_end + PMD_SIZE) {
-			vma = next;
-			next = vma->vm_next;
-		}
-		free_pgd_range(*tlb, addr, vma->vm_end,
+		if (is_hugepage_only_range(addr, HPAGE_SIZE)) {
+			hugetlb_free_pgd_range(tlb, addr, vma->vm_end,
 				floor, next? next->vm_start: ceiling);
+		} else {
+			/*
+			 * Optimization: gather nearby vmas into one call down
+			 */
+			while (next && next->vm_start <= vma->vm_end + PMD_SIZE
+			&& !is_hugepage_only_range(next->vm_start, HPAGE_SIZE)){
+				vma = next;
+				next = vma->vm_next;
+			}
+			free_pgd_range(tlb, addr, vma->vm_end,
+				floor, next? next->vm_start: ceiling);
+		}
 		vma = next;
 	}
 }
