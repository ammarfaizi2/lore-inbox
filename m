Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751437AbVKJCBe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751437AbVKJCBe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 21:01:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751658AbVKJCBe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 21:01:34 -0500
Received: from gold.veritas.com ([143.127.12.110]:30005 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S1751437AbVKJCBd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 21:01:33 -0500
Date: Thu, 10 Nov 2005 02:00:21 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: Paul Mackerras <paulus@samba.org>,
       Ben Herrenschmidt <benh@kernel.crashing.org>,
       Paul Mundt <lethal@linux-sh.org>, Dave Airlie <airlied@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: [PATCH 11/15] mm: long page counts
In-Reply-To: <Pine.LNX.4.61.0511100139550.5814@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.61.0511100157560.5814@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0511100139550.5814@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 10 Nov 2005 02:01:33.0318 (UTC) FILETIME=[AC964260:01C5E59A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The type of the page_count and page_mapcount functions has changed from
int to long.  Update those places which give warnings (mostly debug
printks), or where the count might significantly overflow.

Don't bother with the arch's show_mem functions for now (some say int
shared, some long): they don't cause warnings, the truncation wouldn't
matter much, and we'll want to visit them all (perhaps bring them into
common code) in a later phase of PageReserved removal.

The thought of page_referenced on a page whose mapcount exceeds an int
is rather disturbing: it should probably skip high mapcounts unless the
memory pressure is high; but that's a different problem, ignore for now.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

 arch/ppc64/kernel/vdso.c  |    6 +++---
 arch/sh64/lib/dbg.c       |    2 +-
 drivers/char/drm/drm_vm.c |    2 +-
 fs/proc/task_mmu.c        |    2 +-
 mm/page_alloc.c           |    2 +-
 mm/rmap.c                 |   18 +++++++++---------
 mm/swapfile.c             |    2 +-
 7 files changed, 17 insertions(+), 17 deletions(-)

--- mm10/arch/ppc64/kernel/vdso.c	2005-11-07 07:39:07.000000000 +0000
+++ mm11/arch/ppc64/kernel/vdso.c	2005-11-09 14:40:00.000000000 +0000
@@ -112,11 +112,11 @@ struct lib64_elfinfo
 #ifdef __DEBUG
 static void dump_one_vdso_page(struct page *pg, struct page *upg)
 {
-	printk("kpg: %p (c:%d,f:%08lx)", __va(page_to_pfn(pg) << PAGE_SHIFT),
+	printk("kpg: %p (c:%ld,f:%08lx)", __va(page_to_pfn(pg) << PAGE_SHIFT),
 	       page_count(pg),
 	       pg->flags);
 	if (upg/* && pg != upg*/) {
-		printk(" upg: %p (c:%d,f:%08lx)", __va(page_to_pfn(upg) << PAGE_SHIFT),
+		printk(" upg: %p (c:%ld,f:%08lx)", __va(page_to_pfn(upg) << PAGE_SHIFT),
 		       page_count(upg),
 		       upg->flags);
 	}
@@ -184,7 +184,7 @@ static struct page * vdso_vma_nopage(str
 		pg = virt_to_page(vbase + offset);
 
 	get_page(pg);
-	DBG(" ->page count: %d\n", page_count(pg));
+	DBG(" ->page count: %ld\n", page_count(pg));
 
 	return pg;
 }
--- mm10/arch/sh64/lib/dbg.c	2005-06-17 20:48:29.000000000 +0100
+++ mm11/arch/sh64/lib/dbg.c	2005-11-09 14:40:00.000000000 +0000
@@ -422,7 +422,7 @@ unsigned long lookup_itlb(unsigned long 
 
 void print_page(struct page *page)
 {
-	printk("  page[%p] -> index 0x%lx,  count 0x%x,  flags 0x%lx\n",
+	printk("  page[%p] -> index 0x%lx,  count 0x%lx,  flags 0x%lx\n",
 	       page, page->index, page_count(page), page->flags);
 	printk("       address_space = %p, pages =%ld\n", page->mapping,
 	       page->mapping->nrpages);
--- mm10/drivers/char/drm/drm_vm.c	2005-11-07 07:39:15.000000000 +0000
+++ mm11/drivers/char/drm/drm_vm.c	2005-11-09 14:40:00.000000000 +0000
@@ -112,7 +112,7 @@ static __inline__ struct page *drm_do_vm
 		get_page(page);
 
 		DRM_DEBUG
-		    ("baddr = 0x%lx page = 0x%p, offset = 0x%lx, count=%d\n",
+		    ("baddr = 0x%lx page = 0x%p, offset = 0x%lx, count=%ld\n",
 		     baddr, __va(agpmem->memory->memory[offset]), offset,
 		     page_count(page));
 
--- mm10/fs/proc/task_mmu.c	2005-11-07 07:39:46.000000000 +0000
+++ mm11/fs/proc/task_mmu.c	2005-11-09 14:40:00.000000000 +0000
@@ -422,7 +422,7 @@ static struct numa_maps *get_numa_maps(c
  	for (vaddr = vma->vm_start; vaddr < vma->vm_end; vaddr += PAGE_SIZE) {
 		page = follow_page(mm, vaddr, 0);
 		if (page) {
-			int count = page_mapcount(page);
+			long count = page_mapcount(page);
 
 			if (count)
 				md->mapped++;
--- mm10/mm/page_alloc.c	2005-11-09 14:38:03.000000000 +0000
+++ mm11/mm/page_alloc.c	2005-11-09 14:40:00.000000000 +0000
@@ -126,7 +126,7 @@ static void bad_page(const char *functio
 {
 	printk(KERN_EMERG "Bad page state at %s (in process '%s', page %p)\n",
 		function, current->comm, page);
-	printk(KERN_EMERG "flags:0x%0*lx mapping:%p mapcount:%d count:%d\n",
+	printk(KERN_EMERG "flags:0x%0*lx mapping:%p mapcount:%ld count:%ld\n",
 		(int)(2*sizeof(unsigned long)), (unsigned long)page->flags,
 		page->mapping, page_mapcount(page), page_count(page));
 	printk(KERN_EMERG "Backtrace:\n");
--- mm10/mm/rmap.c	2005-11-09 14:40:00.000000000 +0000
+++ mm11/mm/rmap.c	2005-11-09 14:40:00.000000000 +0000
@@ -64,12 +64,12 @@ static inline void validate_anon_vma(str
 #ifdef RMAP_DEBUG
 	struct anon_vma *anon_vma = find_vma->anon_vma;
 	struct vm_area_struct *vma;
-	unsigned int mapcount = 0;
+	unsigned int vmacount = 0;
 	int found = 0;
 
 	list_for_each_entry(vma, &anon_vma->head, anon_vma_node) {
-		mapcount++;
-		BUG_ON(mapcount > 100000);
+		vmacount++;
+		BUG_ON(vmacount > 100000);
 		if (vma == find_vma)
 			found = 1;
 	}
@@ -289,7 +289,7 @@ pte_t *page_check_address(struct page *p
  * repeatedly from either page_referenced_anon or page_referenced_file.
  */
 static int page_referenced_one(struct page *page,
-	struct vm_area_struct *vma, unsigned int *mapcount, int ignore_token)
+	struct vm_area_struct *vma, long *mapcount, int ignore_token)
 {
 	struct mm_struct *mm = vma->vm_mm;
 	unsigned long address;
@@ -322,7 +322,7 @@ out:
 
 static int page_referenced_anon(struct page *page, int ignore_token)
 {
-	unsigned int mapcount;
+	long mapcount;
 	struct anon_vma *anon_vma;
 	struct vm_area_struct *vma;
 	int referenced = 0;
@@ -355,7 +355,7 @@ static int page_referenced_anon(struct p
  */
 static int page_referenced_file(struct page *page, int ignore_token)
 {
-	unsigned int mapcount;
+	long mapcount;
 	struct address_space *mapping = page->mapping;
 	pgoff_t pgoff = page->index << (PAGE_CACHE_SHIFT - PAGE_SHIFT);
 	struct vm_area_struct *vma;
@@ -600,7 +600,7 @@ out:
 #define CLUSTER_MASK	(~(CLUSTER_SIZE - 1))
 
 static void try_to_unmap_cluster(unsigned long cursor,
-	unsigned int *mapcount, struct vm_area_struct *vma)
+	long *mapcount, struct vm_area_struct *vma)
 {
 	struct mm_struct *mm = vma->vm_mm;
 	pgd_t *pgd;
@@ -712,7 +712,7 @@ static int try_to_unmap_file(struct page
 	unsigned long cursor;
 	unsigned long max_nl_cursor = 0;
 	unsigned long max_nl_size = 0;
-	unsigned int mapcount;
+	long mapcount;
 
 	spin_lock(&mapping->i_mmap_lock);
 	vma_prio_tree_foreach(vma, &iter, &mapping->i_mmap, pgoff, pgoff) {
@@ -768,7 +768,7 @@ static int try_to_unmap_file(struct page
 				try_to_unmap_cluster(cursor, &mapcount, vma);
 				cursor += CLUSTER_SIZE;
 				vma->vm_private_data = (void *) cursor;
-				if ((int)mapcount <= 0)
+				if (mapcount <= 0)
 					goto out;
 			}
 			vma->vm_private_data = (void *) max_nl_cursor;
--- mm10/mm/swapfile.c	2005-11-09 14:38:03.000000000 +0000
+++ mm11/mm/swapfile.c	2005-11-09 14:40:00.000000000 +0000
@@ -308,7 +308,7 @@ static inline int page_swapcount(struct 
  */
 int can_share_swap_page(struct page *page)
 {
-	int count;
+	long count;
 
 	BUG_ON(!PageLocked(page));
 	count = page_mapcount(page);
