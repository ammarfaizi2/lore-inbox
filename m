Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262231AbVCIWo4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262231AbVCIWo4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 17:44:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262194AbVCIWoE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 17:44:04 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:26489 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S262231AbVCIWQV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 17:16:21 -0500
Date: Wed, 9 Mar 2005 22:15:35 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH 14/15] ptwalk: inline pmd_range and pud_range
In-Reply-To: <Pine.LNX.4.61.0503092201070.6070@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.61.0503092214540.6070@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0503092201070.6070@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As a general rule, ask the compiler to inline action_on_pmd_range and
action_on_pud_range: they're none very interesting, and it has a better
chance of eliding them that way.  But conversely, it helps debug traces
if action_on_pte_range and top action_on_page_range remain uninlined.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

 mm/memory.c   |   10 +++++-----
 mm/mprotect.c |    2 +-
 mm/msync.c    |    4 ++--
 mm/swapfile.c |    4 ++--
 mm/vmalloc.c  |   18 ++++++++++--------
 5 files changed, 20 insertions(+), 18 deletions(-)

--- ptwalk13/mm/memory.c	2005-03-09 01:39:18.000000000 +0000
+++ ptwalk14/mm/memory.c	2005-03-09 01:39:31.000000000 +0000
@@ -358,7 +358,7 @@ again:
 	return 0;
 }
 
-static int copy_pmd_range(struct mm_struct *dst_mm, struct mm_struct *src_mm,
+static inline int copy_pmd_range(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 		pud_t *dst_pud, pud_t *src_pud, struct vm_area_struct *vma,
 		unsigned long addr, unsigned long end)
 {
@@ -380,7 +380,7 @@ static int copy_pmd_range(struct mm_stru
 	return 0;
 }
 
-static int copy_pud_range(struct mm_struct *dst_mm, struct mm_struct *src_mm,
+static inline int copy_pud_range(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 		pgd_t *dst_pgd, pgd_t *src_pgd, struct vm_area_struct *vma,
 		unsigned long addr, unsigned long end)
 {
@@ -496,7 +496,7 @@ static void zap_pte_range(struct mmu_gat
 	pte_unmap(pte - 1);
 }
 
-static void zap_pmd_range(struct mmu_gather *tlb, pud_t *pud,
+static inline void zap_pmd_range(struct mmu_gather *tlb, pud_t *pud,
 				unsigned long addr, unsigned long end,
 				struct zap_details *details)
 {
@@ -512,7 +512,7 @@ static void zap_pmd_range(struct mmu_gat
 	} while (pmd++, addr = next, addr != end);
 }
 
-static void zap_pud_range(struct mmu_gather *tlb, pgd_t *pgd,
+static inline void zap_pud_range(struct mmu_gather *tlb, pgd_t *pgd,
 				unsigned long addr, unsigned long end,
 				struct zap_details *details)
 {
@@ -1013,7 +1013,7 @@ int zeromap_page_range(struct vm_area_st
  * mappings are removed. any references to nonexistent pages results
  * in null mappings (currently treated as "copy-on-access")
  */
-static inline int remap_pte_range(struct mm_struct *mm, pmd_t *pmd,
+static int remap_pte_range(struct mm_struct *mm, pmd_t *pmd,
 			unsigned long addr, unsigned long end,
 			unsigned long pfn, pgprot_t prot)
 {
--- ptwalk13/mm/mprotect.c	2005-03-09 01:39:18.000000000 +0000
+++ ptwalk14/mm/mprotect.c	2005-03-09 01:39:31.000000000 +0000
@@ -25,7 +25,7 @@
 #include <asm/cacheflush.h>
 #include <asm/tlbflush.h>
 
-static inline void change_pte_range(struct mm_struct *mm, pmd_t *pmd,
+static void change_pte_range(struct mm_struct *mm, pmd_t *pmd,
 		unsigned long addr, unsigned long end, pgprot_t newprot)
 {
 	pte_t *pte;
--- ptwalk13/mm/msync.c	2005-03-09 01:39:18.000000000 +0000
+++ ptwalk14/mm/msync.c	2005-03-09 01:39:31.000000000 +0000
@@ -105,7 +105,7 @@ static void sync_page_range(struct vm_ar
 }
 
 #ifdef CONFIG_PREEMPT
-static void filemap_sync(struct vm_area_struct *vma,
+static inline void filemap_sync(struct vm_area_struct *vma,
 				unsigned long addr, unsigned long end)
 {
 	const size_t chunk = 64 * 1024;	/* bytes */
@@ -120,7 +120,7 @@ static void filemap_sync(struct vm_area_
 	} while (addr = next, addr != end);
 }
 #else
-static void filemap_sync(struct vm_area_struct *vma,
+static inline void filemap_sync(struct vm_area_struct *vma,
 				unsigned long addr, unsigned long end)
 {
 	sync_page_range(vma, addr, end);
--- ptwalk13/mm/swapfile.c	2005-03-09 01:39:18.000000000 +0000
+++ ptwalk14/mm/swapfile.c	2005-03-09 01:39:31.000000000 +0000
@@ -458,7 +458,7 @@ static int unuse_pte_range(struct vm_are
 	return 0;
 }
 
-static int unuse_pmd_range(struct vm_area_struct *vma, pud_t *pud,
+static inline int unuse_pmd_range(struct vm_area_struct *vma, pud_t *pud,
 				unsigned long addr, unsigned long end,
 				swp_entry_t entry, struct page *page)
 {
@@ -476,7 +476,7 @@ static int unuse_pmd_range(struct vm_are
 	return 0;
 }
 
-static int unuse_pud_range(struct vm_area_struct *vma, pgd_t *pgd,
+static inline int unuse_pud_range(struct vm_area_struct *vma, pgd_t *pgd,
 				unsigned long addr, unsigned long end,
 				swp_entry_t entry, struct page *page)
 {
--- ptwalk13/mm/vmalloc.c	2005-03-09 01:39:18.000000000 +0000
+++ ptwalk14/mm/vmalloc.c	2005-03-09 01:39:31.000000000 +0000
@@ -34,7 +34,8 @@ static void vunmap_pte_range(pmd_t *pmd,
 	} while (pte++, addr += PAGE_SIZE, addr != end);
 }
 
-static void vunmap_pmd_range(pud_t *pud, unsigned long addr, unsigned long end)
+static inline void vunmap_pmd_range(pud_t *pud, unsigned long addr,
+						unsigned long end)
 {
 	pmd_t *pmd;
 	unsigned long next;
@@ -48,7 +49,8 @@ static void vunmap_pmd_range(pud_t *pud,
 	} while (pmd++, addr = next, addr != end);
 }
 
-static void vunmap_pud_range(pgd_t *pgd, unsigned long addr, unsigned long end)
+static inline void vunmap_pud_range(pgd_t *pgd, unsigned long addr,
+						unsigned long end)
 {
 	pud_t *pud;
 	unsigned long next;
@@ -81,8 +83,8 @@ void unmap_vm_area(struct vm_struct *are
 	flush_tlb_kernel_range((unsigned long) area->addr, end);
 }
 
-static int vmap_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
-				pgprot_t prot, struct page ***pages)
+static int vmap_pte_range(pmd_t *pmd, unsigned long addr,
+			unsigned long end, pgprot_t prot, struct page ***pages)
 {
 	pte_t *pte;
 
@@ -100,8 +102,8 @@ static int vmap_pte_range(pmd_t *pmd, un
 	return 0;
 }
 
-static int vmap_pmd_range(pud_t *pud, unsigned long addr, unsigned long end,
-				pgprot_t prot, struct page ***pages)
+static inline int vmap_pmd_range(pud_t *pud, unsigned long addr,
+			unsigned long end, pgprot_t prot, struct page ***pages)
 {
 	pmd_t *pmd;
 	unsigned long next;
@@ -117,8 +119,8 @@ static int vmap_pmd_range(pud_t *pud, un
 	return 0;
 }
 
-static int vmap_pud_range(pgd_t *pgd, unsigned long addr, unsigned long end,
-				pgprot_t prot, struct page ***pages)
+static inline int vmap_pud_range(pgd_t *pgd, unsigned long addr,
+			unsigned long end, pgprot_t prot, struct page ***pages)
 {
 	pud_t *pud;
 	unsigned long next;
