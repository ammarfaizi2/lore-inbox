Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264543AbUD1ANd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264543AbUD1ANd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 20:13:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264540AbUD1ALg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 20:11:36 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:18190 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S264539AbUD1AG5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 20:06:57 -0400
Date: Wed, 28 Apr 2004 01:06:47 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@osdl.org>
cc: Rajesh Venkatasubramanian <vrajesh@umich.edu>, <rmk@arm.linux.org.uk>,
       <James.Bottomley@SteelEye.com>, <schwidefsky@de.ibm.com>, <ak@suse.de>,
       <linux-kernel@vger.kernel.org>
Subject: [PATCH] rmap 19 arch prio_tree
In-Reply-To: <Pine.LNX.4.44.0404280055270.2444-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0404280104370.2444-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The previous patches of this prio_tree batch have been to generic only.
Now the arm and parisc __flush_dcache_page are converted to using
vma_prio_tree_next, and benefit from its selection of relevant vmas.
They're still accessing the tree without i_shared_lock or any other,
that's not forgotten but still under investigation.  Include pagemap.h
for the definition of PAGE_CACHE_SHIFT.  s390 and x86_64 no longer
initialize vma's shared field (whose type has changed), done later.

 arch/arm/mm/fault-armv.c        |   59 ++++++++++++----------------------------
 arch/parisc/kernel/cache.c      |   49 ++++++++++++---------------------
 arch/parisc/kernel/sys_parisc.c |   14 +--------
 arch/s390/kernel/compat_exec.c  |    1 
 arch/x86_64/ia32/ia32_binfmt.c  |    1 
 5 files changed, 39 insertions(+), 85 deletions(-)

--- 2.6.6-rc2-mm2/arch/arm/mm/fault-armv.c	2004-04-21 06:28:40.000000000 +0100
+++ rmap19/arch/arm/mm/fault-armv.c	2004-04-27 19:19:17.337481856 +0100
@@ -16,6 +16,7 @@
 #include <linux/bitops.h>
 #include <linux/vmalloc.h>
 #include <linux/init.h>
+#include <linux/pagemap.h>
 
 #include <asm/cacheflush.h>
 #include <asm/io.h>
@@ -187,7 +188,10 @@ void __flush_dcache_page(struct page *pa
 {
 	struct address_space *mapping = page_mapping(page);
 	struct mm_struct *mm = current->active_mm;
-	struct list_head *l;
+	struct vm_area_struct *mpnt = NULL;
+	struct prio_tree_iter iter;
+	unsigned long offset;
+	pgoff_t pgoff;
 
 	__cpuc_flush_dcache_page(page_address(page));
 
@@ -198,26 +202,16 @@ void __flush_dcache_page(struct page *pa
 	 * With a VIVT cache, we need to also write back
 	 * and invalidate any user data.
 	 */
-	list_for_each(l, &mapping->i_mmap_shared) {
-		struct vm_area_struct *mpnt;
-		unsigned long off;
-
-		mpnt = list_entry(l, struct vm_area_struct, shared);
-
+	pgoff = page->index << (PAGE_CACHE_SHIFT - PAGE_SHIFT);
+	while ((mpnt = vma_prio_tree_next(mpnt, &mapping->i_mmap_shared,
+					&iter, pgoff, pgoff)) != NULL) {
 		/*
 		 * If this VMA is not in our MM, we can ignore it.
 		 */
 		if (mpnt->vm_mm != mm)
 			continue;
-
-		if (page->index < mpnt->vm_pgoff)
-			continue;
-
-		off = page->index - mpnt->vm_pgoff;
-		if (off >= (mpnt->vm_end - mpnt->vm_start) >> PAGE_SHIFT)
-			continue;
-
-		flush_cache_page(mpnt, mpnt->vm_start + (off << PAGE_SHIFT));
+		offset = (pgoff - mpnt->vm_pgoff) << PAGE_SHIFT;
+		flush_cache_page(mpnt, mpnt->vm_start + offset);
 	}
 }
 
@@ -225,9 +219,11 @@ static void
 make_coherent(struct vm_area_struct *vma, unsigned long addr, struct page *page, int dirty)
 {
 	struct address_space *mapping = page_mapping(page);
-	struct list_head *l;
 	struct mm_struct *mm = vma->vm_mm;
-	unsigned long pgoff;
+	struct vm_area_struct *mpnt = NULL;
+	struct prio_tree_iter iter;
+	unsigned long offset;
+	pgoff_t pgoff;
 	int aliases = 0;
 
 	if (!mapping)
@@ -240,12 +236,8 @@ make_coherent(struct vm_area_struct *vma
 	 * space, then we need to handle them specially to maintain
 	 * cache coherency.
 	 */
-	list_for_each(l, &mapping->i_mmap_shared) {
-		struct vm_area_struct *mpnt;
-		unsigned long off;
-
-		mpnt = list_entry(l, struct vm_area_struct, shared);
-
+	while ((mpnt = vma_prio_tree_next(mpnt, &mapping->i_mmap_shared,
+					&iter, pgoff, pgoff)) != NULL) {
 		/*
 		 * If this VMA is not in our MM, we can ignore it.
 		 * Note that we intentionally mask out the VMA
@@ -253,23 +245,8 @@ make_coherent(struct vm_area_struct *vma
 		 */
 		if (mpnt->vm_mm != mm || mpnt == vma)
 			continue;
-
-		/*
-		 * If the page isn't in this VMA, we can also ignore it.
-		 */
-		if (pgoff < mpnt->vm_pgoff)
-			continue;
-
-		off = pgoff - mpnt->vm_pgoff;
-		if (off >= (mpnt->vm_end - mpnt->vm_start) >> PAGE_SHIFT)
-			continue;
-
-		off = mpnt->vm_start + (off << PAGE_SHIFT);
-
-		/*
-		 * Ok, it is within mpnt.  Fix it up.
-		 */
-		aliases += adjust_pte(mpnt, off);
+		offset = (pgoff - mpnt->vm_pgoff) << PAGE_SHIFT;
+		aliases += adjust_pte(mpnt, mpnt->vm_start + offset);
 	}
 	if (aliases)
 		adjust_pte(vma, addr);
--- 2.6.6-rc2-mm2/arch/parisc/kernel/cache.c	2004-04-21 06:28:44.000000000 +0100
+++ rmap19/arch/parisc/kernel/cache.c	2004-04-27 19:19:17.338481704 +0100
@@ -17,6 +17,7 @@
 #include <linux/mm.h>
 #include <linux/module.h>
 #include <linux/seq_file.h>
+#include <linux/pagemap.h>
 
 #include <asm/pdc.h>
 #include <asm/cache.h>
@@ -231,34 +232,30 @@ void __flush_dcache_page(struct page *pa
 {
 	struct address_space *mapping = page_mapping(page);
 	struct mm_struct *mm = current->active_mm;
-	struct list_head *l;
+	struct vm_area_struct *mpnt = NULL;
+	struct prio_tree_iter iter;
+	unsigned long offset;
+	pgoff_t pgoff;
 
 	flush_kernel_dcache_page(page_address(page));
 
 	if (!mapping)
 		return;
-	/* check shared list first if it's not empty...it's usually
-	 * the shortest */
-	list_for_each(l, &mapping->i_mmap_shared) {
-		struct vm_area_struct *mpnt;
-		unsigned long off;
 
-		mpnt = list_entry(l, struct vm_area_struct, shared);
+	pgoff = page->index << (PAGE_CACHE_SHIFT - PAGE_SHIFT);
 
+	/* check shared list first if it's not empty...it's usually
+	 * the shortest */
+	while ((mpnt = vma_prio_tree_next(mpnt, &mapping->i_mmap_shared,
+					&iter, pgoff, pgoff)) != NULL) {
 		/*
 		 * If this VMA is not in our MM, we can ignore it.
 		 */
 		if (mpnt->vm_mm != mm)
 			continue;
 
-		if (page->index < mpnt->vm_pgoff)
-			continue;
-
-		off = page->index - mpnt->vm_pgoff;
-		if (off >= (mpnt->vm_end - mpnt->vm_start) >> PAGE_SHIFT)
-			continue;
-
-		flush_cache_page(mpnt, mpnt->vm_start + (off << PAGE_SHIFT));
+		offset = (pgoff - mpnt->vm_pgoff) << PAGE_SHIFT;
+		flush_cache_page(mpnt, mpnt->vm_start + offset);
 
 		/* All user shared mappings should be equivalently mapped,
 		 * so once we've flushed one we should be ok
@@ -268,24 +265,16 @@ void __flush_dcache_page(struct page *pa
 
 	/* then check private mapping list for read only shared mappings
 	 * which are flagged by VM_MAYSHARE */
-	list_for_each(l, &mapping->i_mmap) {
-		struct vm_area_struct *mpnt;
-		unsigned long off;
-
-		mpnt = list_entry(l, struct vm_area_struct, shared);
-
-
+	while ((mpnt = vma_prio_tree_next(mpnt, &mapping->i_mmap,
+					&iter, pgoff, pgoff)) != NULL) {
+		/*
+		 * If this VMA is not in our MM, we can ignore it.
+		 */
 		if (mpnt->vm_mm != mm || !(mpnt->vm_flags & VM_MAYSHARE))
 			continue;
 
-		if (page->index < mpnt->vm_pgoff)
-			continue;
-
-		off = page->index - mpnt->vm_pgoff;
-		if (off >= (mpnt->vm_end - mpnt->vm_start) >> PAGE_SHIFT)
-			continue;
-
-		flush_cache_page(mpnt, mpnt->vm_start + (off << PAGE_SHIFT));
+		offset = (pgoff - mpnt->vm_pgoff) << PAGE_SHIFT;
+		flush_cache_page(mpnt, mpnt->vm_start + offset);
 
 		/* All user shared mappings should be equivalently mapped,
 		 * so once we've flushed one we should be ok
--- 2.6.6-rc2-mm2/arch/parisc/kernel/sys_parisc.c	2004-04-04 03:38:55.000000000 +0100
+++ rmap19/arch/parisc/kernel/sys_parisc.c	2004-04-27 19:19:17.339481552 +0100
@@ -68,17 +68,8 @@ static unsigned long get_unshared_area(u
  * existing mapping and use the same offset.  New scheme is to use the
  * address of the kernel data structure as the seed for the offset.
  * We'll see how that works...
- */
-#if 0
-static int get_offset(struct address_space *mapping)
-{
-	struct vm_area_struct *vma = list_entry(mapping->i_mmap_shared.next,
-			struct vm_area_struct, shared);
-	return (vma->vm_start + ((pgoff - vma->vm_pgoff) << PAGE_SHIFT)) &
-		(SHMLBA - 1);
-}
-#else
-/* The mapping is cacheline aligned, so there's no information in the bottom
+ *
+ * The mapping is cacheline aligned, so there's no information in the bottom
  * few bits of the address.  We're looking for 10 bits (4MB / 4k), so let's
  * drop the bottom 8 bits and use bits 8-17.  
  */
@@ -87,7 +78,6 @@ static int get_offset(struct address_spa
 	int offset = (unsigned long) mapping << (PAGE_SHIFT - 8);
 	return offset & 0x3FF000;
 }
-#endif
 
 static unsigned long get_shared_area(struct address_space *mapping,
 		unsigned long addr, unsigned long len, unsigned long pgoff)
--- 2.6.6-rc2-mm2/arch/s390/kernel/compat_exec.c	2004-04-26 12:39:39.560193296 +0100
+++ rmap19/arch/s390/kernel/compat_exec.c	2004-04-27 19:19:17.340481400 +0100
@@ -73,7 +73,6 @@ int setup_arg_pages32(struct linux_binpr
 		mpnt->vm_pgoff = 0;
 		mpnt->vm_file = NULL;
 		mpol_set_vma_default(mpnt);
-		INIT_LIST_HEAD(&mpnt->shared);
 		mpnt->vm_private_data = (void *) 0;
 		insert_vm_struct(mm, mpnt);
 		mm->total_vm = (mpnt->vm_end - mpnt->vm_start) >> PAGE_SHIFT;
--- 2.6.6-rc2-mm2/arch/x86_64/ia32/ia32_binfmt.c	2004-04-26 12:39:40.006125504 +0100
+++ rmap19/arch/x86_64/ia32/ia32_binfmt.c	2004-04-27 19:19:17.341481248 +0100
@@ -366,7 +366,6 @@ int setup_arg_pages(struct linux_binprm 
 		mpnt->vm_pgoff = 0;
 		mpnt->vm_file = NULL;
 		mpol_set_vma_default(mpnt);
-		INIT_LIST_HEAD(&mpnt->shared);
 		mpnt->vm_private_data = (void *) 0;
 		insert_vm_struct(mm, mpnt);
 		mm->total_vm = (mpnt->vm_end - mpnt->vm_start) >> PAGE_SHIFT;

