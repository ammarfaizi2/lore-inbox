Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965131AbVHZRCw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965131AbVHZRCw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 13:02:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965128AbVHZRCl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 13:02:41 -0400
Received: from ppp-62-11-73-212.dialup.tiscali.it ([62.11.73.212]:33941 "EHLO
	zion.home.lan") by vger.kernel.org with ESMTP id S965127AbVHZRCS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 13:02:18 -0400
Subject: [patch 09/18] remap_file_pages protection support: fix get_user_pages() on VM_NONUNIFORM vmas
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu, blaisorblade@yahoo.it
From: blaisorblade@yahoo.it
Date: Fri, 26 Aug 2005 18:53:34 +0200
Message-Id: <20050826165334.8D161254626@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

get_user_pages may well call handle_mm_fault on present and valid PTEs. Signal
that by using VM_MAYREAD in the access_mask.

Also, get_user_pages() may give write faults on present readonly PTEs in
VM_NONUNIFORM areas (think of PTRACE_POKETEXT), so we must still do do_wp_page
even on VM_NONUNIFORM areas.

So, possibly use VM_MAYWRITE in the access_mask and check VM_NONUNIFORM in
maybe_mkwrite_file (new variant of maybe_mkwrite).

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.git-paolo/include/linux/mm.h |   13 +++++++-
 linux-2.6.git-paolo/mm/memory.c        |   52 +++++++++++++++++++++++----------
 2 files changed, 49 insertions(+), 16 deletions(-)

diff -puN mm/memory.c~rfp-fix-get_user_pages mm/memory.c
--- linux-2.6.git/mm/memory.c~rfp-fix-get_user_pages	2005-08-24 13:34:45.000000000 +0200
+++ linux-2.6.git-paolo/mm/memory.c	2005-08-24 15:53:50.000000000 +0200
@@ -945,7 +945,7 @@ int get_user_pages(struct task_struct *t
 		}
 		spin_lock(&mm->page_table_lock);
 		do {
-			int write_access = write ? VM_WRITE : 0;
+			int write_access = flags & (VM_MAYWRITE | VM_WRITE);
 			struct page *page;
 
 			cond_resched_lock(&mm->page_table_lock);
@@ -964,7 +964,8 @@ int get_user_pages(struct task_struct *t
 					break;
 				}
 				spin_unlock(&mm->page_table_lock);
-				ret = __handle_mm_fault(mm, vma, start, write_access);
+				ret = __handle_mm_fault(mm, vma, start,
+						write_access | VM_MAYREAD);
 
 				/*
 				 * The VM_FAULT_WRITE bit tells us that do_wp_page has
@@ -1190,7 +1191,20 @@ EXPORT_SYMBOL(remap_pfn_range);
  * servicing faults for write access.  In the normal case, do always want
  * pte_mkwrite.  But get_user_pages can cause write faults for mappings
  * that do not have writing enabled, when used by access_process_vm.
+ *
+ * Also, we must never change protections on VM_NONUNIFORM pages; that's only
+ * allowed in do_no_page(), so test only VMA protections there. For other cases
+ * we *know* that VM_NONUNIFORM is clear, such as anonymous/swap pages, and in
+ * that case using plain maybe_mkwrite() is an optimization.
+ * Instead, when we may be mapping a file, we must use maybe_mkwrite_file.
  */
+static inline pte_t maybe_mkwrite_file(pte_t pte, struct vm_area_struct *vma)
+{
+	if (likely((vma->vm_flags & (VM_WRITE | VM_NONUNIFORM)) == VM_WRITE))
+		pte = pte_mkwrite(pte);
+	return pte;
+}
+
 static inline pte_t maybe_mkwrite(pte_t pte, struct vm_area_struct *vma)
 {
 	if (likely(vma->vm_flags & VM_WRITE))
@@ -1206,8 +1220,8 @@ static inline void break_cow(struct vm_a
 {
 	pte_t entry;
 
-	entry = maybe_mkwrite(pte_mkdirty(mk_pte(new_page, vma->vm_page_prot)),
-			      vma);
+	entry = maybe_mkwrite_file(pte_mkdirty(mk_pte(new_page,
+					vma->vm_page_prot)), vma);
 	ptep_establish(vma, address, page_table, entry);
 	update_mmu_cache(vma, address, entry);
 	lazy_mmu_prot_update(entry);
@@ -1260,8 +1274,8 @@ static int do_wp_page(struct mm_struct *
 		unlock_page(old_page);
 		if (reuse) {
 			flush_cache_page(vma, address, pfn);
-			entry = maybe_mkwrite(pte_mkyoung(pte_mkdirty(pte)),
-					      vma);
+			entry = maybe_mkwrite_file(pte_mkyoung(pte_mkdirty(pte)),
+					vma);
 			ptep_set_access_flags(vma, address, page_table, entry, 1);
 			update_mmu_cache(vma, address, entry);
 			lazy_mmu_prot_update(entry);
@@ -1971,14 +1985,15 @@ static int do_file_page(struct mm_struct
 	 * ->populate; in this case do the protection checks.
 	 */
 	if (!vma->vm_ops->populate ||
-			((access_mask & VM_WRITE) && !(vma->vm_flags & VM_SHARED))) {
+			((access_mask & (VM_WRITE|VM_MAYWRITE)) &&
+			 !(vma->vm_flags & VM_SHARED))) {
 		/* We're behaving as if pte_file was cleared, so check
 		 * protections like in handle_pte_fault. */
 		if (check_perms(vma, access_mask))
 			goto out_segv;
 
 		pte_clear(mm, address, pte);
-		return do_no_page(mm, vma, address, access_mask & VM_WRITE, pte, pmd);
+		return do_no_page(mm, vma, address, access_mask & (VM_WRITE|VM_MAYWRITE), pte, pmd);
 	}
 
 	pgoff = pte_to_pgoff(*pte);
@@ -2042,19 +2057,26 @@ static inline int handle_pte_fault(struc
 		 */
 		if (unlikely(pte_file(entry)))
 			return do_file_page(mm, vma, address, access_mask, pte, pmd);
-		access_mask &= VM_WRITE;
+		access_mask &= VM_WRITE | VM_MAYWRITE;
 		if (pte_none(entry))
 			return do_no_page(mm, vma, address, access_mask, pte, pmd);
 		return do_swap_page(mm, vma, address, pte, pmd, entry, access_mask);
 	}
 
 	/* VM_NONUNIFORM vma's have PTE's always installed with the correct
-	 * protection. So, generate a SIGSEGV if a fault is caught there. */
-	if (unlikely(vma->vm_flags & VM_NONUNIFORM))
-		goto out_segv;
-
-	/* We only need to know whether the fault is a write one.*/
-	access_mask &= VM_WRITE;
+	 * protection. So, generate a SIGSEGV if a fault is caught there.
+	 * get_user_pages could still want to do a fault here, so treat it
+	 * (VM_MAYREAD) differently. */
+	if (unlikely(vma->vm_flags & VM_NONUNIFORM)) {
+		if (likely(!(access_mask & (VM_MAYWRITE|VM_MAYREAD))))
+			goto out_segv;
+		/* VM_MAYREAD | VM_WRITE means leave present pages as-is, so
+		 * kill VM_WRITE to avoid COW breaking. */
+		access_mask &= VM_MAYWRITE;
+	} else {
+		/* We only need to know whether the fault is a write one.*/
+		access_mask &= VM_WRITE | VM_MAYWRITE;
+	}
 
 	if (access_mask) {
 		if (!pte_write(entry))
diff -puN include/linux/mm.h~rfp-fix-get_user_pages include/linux/mm.h
--- linux-2.6.git/include/linux/mm.h~rfp-fix-get_user_pages	2005-08-24 13:34:45.000000000 +0200
+++ linux-2.6.git-paolo/include/linux/mm.h	2005-08-24 15:52:01.000000000 +0200
@@ -719,7 +719,18 @@ extern pte_t *FASTCALL(pte_alloc_map(str
 extern int install_page(struct mm_struct *mm, struct vm_area_struct *vma, unsigned long addr, struct page *page, pgprot_t prot);
 extern int install_file_pte(struct mm_struct *mm, struct vm_area_struct *vma, unsigned long addr, unsigned long pgoff, pgprot_t prot);
 
-/* We reuse VM_READ, VM_WRITE and VM_EXEC for the @access_mask. */
+/* We reuse VM_READ, VM_WRITE and VM_EXEC for the @access_mask, to report the
+ * kind of access we request for permission checking, in case the VMA is
+ * VM_NONUNIFORM.
+ *
+ * Also, the interaction of VM_NONUNIFORM vma's with this must be careful, when
+ * called by get_user_pages().
+ * When calling this to install pages rather than to handle a fault (such as in
+ * get_user_pages()), you must pass VM_MAYREAD.
+ * Additionally, when wanting to force it to copy COW pages even if the PTE is
+ * not readable, use VM_MAYWRITE beyond VM_MAYREAD.
+ */
+
 extern int __handle_mm_fault(struct mm_struct *mm,struct vm_area_struct *vma, unsigned long address, int access_mask);
 
 static inline int handle_mm_fault(struct mm_struct *mm, struct vm_area_struct *vma, unsigned long address, int write_access)
_
