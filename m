Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316465AbSHJA6g>; Fri, 9 Aug 2002 20:58:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316535AbSHJA6K>; Fri, 9 Aug 2002 20:58:10 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:23058 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S316512AbSHJA4B>;
	Fri, 9 Aug 2002 20:56:01 -0400
Message-ID: <3D5464F7.179A69A0@zip.com.au>
Date: Fri, 09 Aug 2002 17:57:27 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [patch 9/12] sync get_user_pages with 2.4
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Forward port of get_user_pages() change from 2.4.

- If the vma is marked as VM_IO area then fail the map.

  This prevents kernel deadlocks which occur when applications which
  have frame buffers mapped try to dump core.  Also prevents a kernel
  oops when a debugger is attached to a process which has an IO mmap.

- Check that the mapped page is inside mem_map[] (pfn_valid).

- inline follow_page() and remove the preempt_disable()s.  It has
  only a single callsite and is called under spinloclk.


 memory.c |   45 +++++++++++++++++++++++++--------------------
 1 files changed, 25 insertions, 20 deletions

--- 2.5.30/mm/memory.c~get_user_pages-sync	Fri Aug  9 17:36:46 2002
+++ 2.5.30-akpm/mm/memory.c	Fri Aug  9 17:36:46 2002
@@ -432,9 +432,11 @@ void zap_page_range(struct vm_area_struc
 }
 
 /*
- * Do a quick page-table lookup for a single page. 
+ * Do a quick page-table lookup for a single page.
+ * mm->page_table_lock must be held.
  */
-static struct page * follow_page(struct mm_struct *mm, unsigned long address, int write) 
+static inline struct page *
+follow_page(struct mm_struct *mm, unsigned long address, int write) 
 {
 	pgd_t *pgd;
 	pmd_t *pmd;
@@ -449,19 +451,14 @@ static struct page * follow_page(struct 
 	if (pmd_none(*pmd) || pmd_bad(*pmd))
 		goto out;
 
-	preempt_disable();
 	ptep = pte_offset_map(pmd, address);
-	if (!ptep) {
-		preempt_enable();
+	if (!ptep)
 		goto out;
-	}
 
 	pte = *ptep;
 	pte_unmap(ptep);
-	preempt_enable();
 	if (pte_present(pte)) {
-		if (!write ||
-		    (pte_write(pte) && pte_dirty(pte))) {
+		if (!write || (pte_write(pte) && pte_dirty(pte))) {
 			pfn = pte_pfn(pte);
 			if (pfn_valid(pfn))
 				return pfn_to_page(pfn);
@@ -478,13 +475,17 @@ out:
  * with IO-aperture pages in kiobufs.
  */
 
-static inline struct page * get_page_map(struct page *page)
+static inline struct page *get_page_map(struct page *page)
 {
+	if (!pfn_valid(page_to_pfn(page)))
+		return 0;
 	return page;
 }
 
-int get_user_pages(struct task_struct *tsk, struct mm_struct *mm, unsigned long start,
-		int len, int write, int force, struct page **pages, struct vm_area_struct **vmas)
+
+int get_user_pages(struct task_struct *tsk, struct mm_struct *mm,
+		unsigned long start, int len, int write, int force,
+		struct page **pages, struct vm_area_struct **vmas)
 {
 	int i;
 	unsigned int flags;
@@ -496,14 +497,14 @@ int get_user_pages(struct task_struct *t
 	flags = write ? (VM_WRITE | VM_MAYWRITE) : (VM_READ | VM_MAYREAD);
 	flags &= force ? (VM_MAYREAD | VM_MAYWRITE) : (VM_READ | VM_WRITE);
 	i = 0;
-	
 
 	do {
 		struct vm_area_struct *	vma;
 
 		vma = find_extend_vma(mm, start);
 
-		if ( !vma || !(flags & vma->vm_flags) )
+		if (!vma || (pages && (vma->vm_flags & VM_IO))
+				|| !(flags & vma->vm_flags))
 			return i ? : -EFAULT;
 
 		spin_lock(&mm->page_table_lock);
@@ -511,7 +512,7 @@ int get_user_pages(struct task_struct *t
 			struct page *map;
 			while (!(map = follow_page(mm, start, write))) {
 				spin_unlock(&mm->page_table_lock);
-				switch (handle_mm_fault(mm, vma, start, write)) {
+				switch (handle_mm_fault(mm,vma,start,write)) {
 				case VM_FAULT_MINOR:
 					tsk->min_flt++;
 					break;
@@ -529,11 +530,14 @@ int get_user_pages(struct task_struct *t
 			}
 			if (pages) {
 				pages[i] = get_page_map(map);
-				/* FIXME: call the correct function,
-				 * depending on the type of the found page
-				 */
-				if (pages[i])
-					page_cache_get(pages[i]);
+				if (!pages[i]) {
+					spin_unlock(&mm->page_table_lock);
+					while (i--)
+						page_cache_release(pages[i]);
+					i = -EFAULT;
+					goto out;
+				}
+				page_cache_get(pages[i]);
 			}
 			if (vmas)
 				vmas[i] = vma;
@@ -543,6 +547,7 @@ int get_user_pages(struct task_struct *t
 		} while(len && start < vma->vm_end);
 		spin_unlock(&mm->page_table_lock);
 	} while(len);
+out:
 	return i;
 }
 

.
