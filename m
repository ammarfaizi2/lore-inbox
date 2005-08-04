Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262487AbVHDLsv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262487AbVHDLsv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 07:48:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262488AbVHDLsv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 07:48:51 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:16819 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S262487AbVHDLsu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 07:48:50 -0400
Date: Thu, 4 Aug 2005 06:48:12 -0500
From: Robin Holt <holt@sgi.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: Robin Holt <holt@sgi.com>, Linus Torvalds <torvalds@osdl.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Andrew Morton <akpm@osdl.org>,
       Roland McGrath <roland@redhat.com>, linux-mm@kvack.org,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch 2.6.13-rc4] fix get_user_pages bug
Message-ID: <20050804114812.GB31596@lnx-holt.americas.sgi.com>
References: <20050801032258.A465C180EC0@magilla.sf.frob.com> <42EDDB82.1040900@yahoo.com.au> <Pine.LNX.4.58.0508010833250.14342@g5.osdl.org> <Pine.LNX.4.58.0508011116180.3341@g5.osdl.org> <20050803082414.GB6384@lnx-holt.americas.sgi.com> <Pine.LNX.4.61.0508031223590.13845@goblin.wat.veritas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0508031223590.13845@goblin.wat.veritas.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 03, 2005 at 12:31:34PM +0100, Hugh Dickins wrote:
> On Wed, 3 Aug 2005, Robin Holt wrote:
> > On Mon, Aug 01, 2005 at 11:18:42AM -0700, Linus Torvalds wrote:
> > > 
> > > Can somebody who saw the problem in the first place please verify?

OK.  I took the three commits:
4ceb5db9757aaeadcf8fbbf97d76bd42aa4df0d6
f33ea7f404e592e4563b12101b7a4d17da6558d7
a68d2ebc1581a3aec57bd032651e013fa609f530

I back ported them to the SuSE SLES9SP2 kernel.  I will add them at
the end so you can tell me if I messed things up.  I was then able
to run the customer test application multiple times without issue.
Before the fix, we had never acheived three consecutive runs that did
not trip the fault.  After the change, it has been in excess of thirty.
I would say this has fixed the problem.  Did I miss anything which
needs to be tested?

Thanks,
Robin Holt


----- Patches against SLES9SP2 7.191 kernel -----


Adapted for SLES9 SP2 kernel from
X-Git-Url: http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=4ceb5db9757aaeadcf8fbbf97d76bd42aa4df0d6
Index: linux/mm/memory.c
===================================================================
--- linux.orig/mm/memory.c	2005-08-03 16:18:31.553626601 -0500
+++ linux/mm/memory.c	2005-08-03 16:24:08.905247901 -0500
@@ -674,7 +674,7 @@ follow_page(struct mm_struct *mm, unsign
 	pte = *ptep;
 	pte_unmap(ptep);
 	if (pte_present(pte)) {
-		if (write && !pte_write(pte))
+		if (write && !pte_dirty(pte))
 			goto out;
 		if (write && !pte_dirty(pte)) {
 			struct page *page = pte_page(pte);
@@ -814,8 +814,7 @@ int get_user_pages(struct task_struct *t
 		spin_lock(&mm->page_table_lock);
 		do {
 			struct page *map;
-			int lookup_write = write;
-			while (!(map = follow_page(mm, start, lookup_write))) {
+			while (!(map = follow_page(mm, start, write))) {
 				/*
 				 * Shortcut for anonymous pages. We don't want
 				 * to force the creation of pages tables for
@@ -823,8 +822,7 @@ int get_user_pages(struct task_struct *t
 				 * nobody touched so far. This is important
 				 * for doing a core dump for these mappings.
 				 */
-				if (!lookup_write &&
-				    untouched_anonymous_page(mm,vma,start)) {
+				if (!write && untouched_anonymous_page(mm,vma,start)) {
 					map = ZERO_PAGE(start);
 					break;
 				}
@@ -843,14 +841,6 @@ int get_user_pages(struct task_struct *t
 				default:
 					BUG();
 				}
-				/*
-				 * Now that we have performed a write fault
-				 * and surely no longer have a shared page we
-				 * shouldn't write, we shouldn't ignore an
-				 * unwritable page in the page table if
-				 * we are forcing write access.
-				 */
-				lookup_write = write && !force;
 				spin_lock(&mm->page_table_lock);
 			}
 			if (pages) {






Adapted for SLES9 SP2 kernel from
X-Git-Url: http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=f33ea7f404e592e4563b12101b7a4d17da6558d7
Index: linux/include/linux/mm.h
===================================================================
--- linux.orig/include/linux/mm.h	2005-08-03 16:22:55.905794491 -0500
+++ linux/include/linux/mm.h	2005-08-03 16:24:48.123938110 -0500
@@ -651,10 +651,16 @@ static inline int page_mapped(struct pag
  * Used to decide whether a process gets delivered SIGBUS or
  * just gets major/minor fault counters bumped up.
  */
-#define VM_FAULT_OOM	(-1)
-#define VM_FAULT_SIGBUS	0
-#define VM_FAULT_MINOR	1
-#define VM_FAULT_MAJOR	2
+#define VM_FAULT_OOM	0x00
+#define VM_FAULT_SIGBUS	0x01
+#define VM_FAULT_MINOR	0x02
+#define VM_FAULT_MAJOR	0x03
+
+/* 
+ * Special case for get_user_pages.
+ * Must be in a distinct bit from the above VM_FAULT_ flags.
+ */
+#define VM_FAULT_WRITE	0x10
 
 #define offset_in_page(p)	((unsigned long)(p) & ~PAGE_MASK)
 
@@ -704,7 +710,13 @@ extern pte_t *FASTCALL(pte_alloc_kernel(
 extern pte_t *FASTCALL(pte_alloc_map(struct mm_struct *mm, pmd_t *pmd, unsigned long address));
 extern int install_page(struct mm_struct *mm, struct vm_area_struct *vma, unsigned long addr, struct page *page, pgprot_t prot);
 extern int install_file_pte(struct mm_struct *mm, struct vm_area_struct *vma, unsigned long addr, unsigned long pgoff, pgprot_t prot);
-extern int handle_mm_fault(struct mm_struct *mm,struct vm_area_struct *vma, unsigned long address, int write_access);
+extern int __handle_mm_fault(struct mm_struct *mm,struct vm_area_struct *vma, unsigned long address, int write_access);
+
+static inline int handle_mm_fault(struct mm_struct *mm, struct vm_area_struct *vma, unsigned long address, int write_access)
+{
+	return __handle_mm_fault(mm, vma, address, write_access) & (~VM_FAULT_WRITE);
+}
+
 extern void make_pages_present(unsigned long addr, unsigned long end);
 extern int access_process_vm(struct task_struct *tsk, unsigned long addr, void *buf, int len, int write);
 void put_dirty_page(struct task_struct *tsk, struct page *page,
Index: linux/mm/memory.c
===================================================================
--- linux.orig/mm/memory.c	2005-08-03 16:24:08.905247901 -0500
+++ linux/mm/memory.c	2005-08-03 16:29:01.901967868 -0500
@@ -674,7 +674,7 @@ follow_page(struct mm_struct *mm, unsign
 	pte = *ptep;
 	pte_unmap(ptep);
 	if (pte_present(pte)) {
-		if (write && !pte_dirty(pte))
+		if (write && !pte_write(pte))
 			goto out;
 		if (write && !pte_dirty(pte)) {
 			struct page *page = pte_page(pte);
@@ -684,8 +684,9 @@ follow_page(struct mm_struct *mm, unsign
 		pfn = pte_pfn(pte);
 		if (pfn_valid(pfn)) {
 			struct page *page = pfn_to_page(pfn);
-			
-			mark_page_accessed(page);
+			if (write && !pte_dirty(pte) &&!PageDirty(page))
+				set_page_dirty(page);
+  			mark_page_accessed(page);
 			return page;
 		}
 	}
@@ -813,8 +814,9 @@ int get_user_pages(struct task_struct *t
 		}
 		spin_lock(&mm->page_table_lock);
 		do {
+			int write_access = write;
 			struct page *map;
-			while (!(map = follow_page(mm, start, write))) {
+			while (!(map = follow_page(mm, start, write_access))) {
 				/*
 				 * Shortcut for anonymous pages. We don't want
 				 * to force the creation of pages tables for
@@ -827,7 +829,16 @@ int get_user_pages(struct task_struct *t
 					break;
 				}
 				spin_unlock(&mm->page_table_lock);
-				switch (handle_mm_fault(mm,vma,start,write)) {
+				switch (__handle_mm_fault(mm, vma, start,
+							write_access)) {
+				case VM_FAULT_WRITE:
+					/*
+					 * do_wp_page has broken COW when
+					 * necessary, even if maybe_mkwrite
+					 * decided not to set pte_write
+					 */
+					write_access = 0;
+					/* FALLTHRU */
 				case VM_FAULT_MINOR:
 					tsk->min_flt++;
 					break;
@@ -1086,6 +1097,7 @@ static int do_wp_page(struct mm_struct *
 	struct page *old_page, *new_page;
 	unsigned long pfn = pte_pfn(pte);
 	pte_t entry;
+	int ret;
 
 	if (unlikely(!pfn_valid(pfn))) {
 		/*
@@ -1113,7 +1125,7 @@ static int do_wp_page(struct mm_struct *
 			lazy_mmu_prot_update(entry);
 			pte_unmap(page_table);
 			spin_unlock(&mm->page_table_lock);
-			return VM_FAULT_MINOR;
+			return VM_FAULT_MINOR|VM_FAULT_WRITE;
 		}
 	}
 	pte_unmap(page_table);
@@ -1135,6 +1147,7 @@ static int do_wp_page(struct mm_struct *
 	/*
 	 * Re-check the pte - we dropped the lock
 	 */
+	ret = VM_FAULT_MINOR;
 	spin_lock(&mm->page_table_lock);
 	page_table = pte_offset_map(pmd, address);
 	if (likely(pte_same(*page_table, pte))) {
@@ -1153,12 +1166,13 @@ static int do_wp_page(struct mm_struct *
 
 		/* Free the old page.. */
 		new_page = old_page;
+		ret |= VM_FAULT_WRITE;
 	}
 	pte_unmap(page_table);
 	page_cache_release(new_page);
 	page_cache_release(old_page);
 	spin_unlock(&mm->page_table_lock);
-	return VM_FAULT_MINOR;
+	return ret;
 
 no_new_page:
 	page_cache_release(old_page);
@@ -1753,7 +1767,6 @@ static inline int handle_pte_fault(struc
 	if (write_access) {
 		if (!pte_write(entry))
 			return do_wp_page(mm, vma, address, pte, pmd, entry);
-
 		entry = pte_mkdirty(entry);
 	}
 	entry = pte_mkyoung(entry);
@@ -1777,7 +1790,7 @@ int __attribute__((weak)) arch_hugetlb_f
 /*
  * By the time we get here, we already hold the mm semaphore
  */
-int handle_mm_fault(struct mm_struct *mm, struct vm_area_struct * vma,
+int __handle_mm_fault(struct mm_struct *mm, struct vm_area_struct * vma,
 	unsigned long address, int write_access)
 {
 	pgd_t *pgd;



Adapted for SLES9 SP2 kernel from
X-Git-Url: http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=a68d2ebc1581a3aec57bd032651e013fa609f530
Index: linux/mm/memory.c
===================================================================
--- linux.orig/mm/memory.c	2005-08-03 16:29:13.789434124 -0500
+++ linux/mm/memory.c	2005-08-03 16:29:13.838257298 -0500
@@ -817,6 +817,8 @@ int get_user_pages(struct task_struct *t
 			int write_access = write;
 			struct page *map;
 			while (!(map = follow_page(mm, start, write_access))) {
+				int ret;
+
 				/*
 				 * Shortcut for anonymous pages. We don't want
 				 * to force the creation of pages tables for
@@ -829,16 +831,18 @@ int get_user_pages(struct task_struct *t
 					break;
 				}
 				spin_unlock(&mm->page_table_lock);
-				switch (__handle_mm_fault(mm, vma, start,
-							write_access)) {
-				case VM_FAULT_WRITE:
-					/*
-					 * do_wp_page has broken COW when
-					 * necessary, even if maybe_mkwrite
-					 * decided not to set pte_write
-					 */
+				ret = __handle_mm_fault(mm, vma, start, write_access);
+
+				/*
+				 * The VM_FAULT_WRITE bit tells us that do_wp_page has
+				 * broken COW when necessary, even if maybe_mkwrite
+				 * decided not to set pte_write. We can thus safely do
+				 * subsequent page lookups as if they were reads.
+				 */
+				if (ret & VM_FAULT_WRITE)
 					write_access = 0;
-					/* FALLTHRU */
+				
+				switch (ret & ~VM_FAULT_WRITE) {
 				case VM_FAULT_MINOR:
 					tsk->min_flt++;
 					break;
