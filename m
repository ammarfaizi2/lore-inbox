Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964818AbWFSRxv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964818AbWFSRxv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 13:53:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964812AbWFSRxs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 13:53:48 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:5273 "EHLO
	amsfep12-int.chello.nl") by vger.kernel.org with ESMTP
	id S964805AbWFSRx2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 13:53:28 -0400
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       David Howells <dhowells@redhat.com>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Christoph Lameter <christoph@lameter.com>,
       Martin Bligh <mbligh@google.com>, Nick Piggin <npiggin@suse.de>,
       Linus Torvalds <torvalds@osdl.org>
Date: Mon, 19 Jun 2006 19:53:15 +0200
Message-Id: <20060619175315.24655.45123.sendpatchset@lappy>
In-Reply-To: <20060619175243.24655.76005.sendpatchset@lappy>
References: <20060619175243.24655.76005.sendpatchset@lappy>
Subject: [PATCH 3/6] mm: msync() cleanup
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Peter Zijlstra <a.p.zijlstra@chello.nl>

With the tracking of dirty pages properly done now, msync doesn't need to
scan the PTEs anymore to determine the dirty status.

Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>

 mm/msync.c |  129 ++++---------------------------------------------------------
 1 file changed, 9 insertions(+), 120 deletions(-)

Index: 2.6-mm/mm/msync.c
===================================================================
--- 2.6-mm.orig/mm/msync.c	2006-06-19 16:21:13.000000000 +0200
+++ 2.6-mm/mm/msync.c	2006-06-19 16:21:21.000000000 +0200
@@ -20,109 +20,14 @@
 #include <asm/pgtable.h>
 #include <asm/tlbflush.h>
 
-static unsigned long msync_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
-				unsigned long addr, unsigned long end)
-{
-	pte_t *pte;
-	spinlock_t *ptl;
-	int progress = 0;
-	unsigned long ret = 0;
-
-again:
-	pte = pte_offset_map_lock(vma->vm_mm, pmd, addr, &ptl);
-	do {
-		struct page *page;
-
-		if (progress >= 64) {
-			progress = 0;
-			if (need_resched() || need_lockbreak(ptl))
-				break;
-		}
-		progress++;
-		if (!pte_present(*pte))
-			continue;
-		if (!pte_maybe_dirty(*pte))
-			continue;
-		page = vm_normal_page(vma, addr, *pte);
-		if (!page)
-			continue;
-		if (ptep_clear_flush_dirty(vma, addr, pte) ||
-				page_test_and_clear_dirty(page))
-			ret += set_page_dirty(page);
-		progress += 3;
-	} while (pte++, addr += PAGE_SIZE, addr != end);
-	pte_unmap_unlock(pte - 1, ptl);
-	cond_resched();
-	if (addr != end)
-		goto again;
-	return ret;
-}
-
-static inline unsigned long msync_pmd_range(struct vm_area_struct *vma,
-			pud_t *pud, unsigned long addr, unsigned long end)
-{
-	pmd_t *pmd;
-	unsigned long next;
-	unsigned long ret = 0;
-
-	pmd = pmd_offset(pud, addr);
-	do {
-		next = pmd_addr_end(addr, end);
-		if (pmd_none_or_clear_bad(pmd))
-			continue;
-		ret += msync_pte_range(vma, pmd, addr, next);
-	} while (pmd++, addr = next, addr != end);
-	return ret;
-}
-
-static inline unsigned long msync_pud_range(struct vm_area_struct *vma,
-			pgd_t *pgd, unsigned long addr, unsigned long end)
-{
-	pud_t *pud;
-	unsigned long next;
-	unsigned long ret = 0;
-
-	pud = pud_offset(pgd, addr);
-	do {
-		next = pud_addr_end(addr, end);
-		if (pud_none_or_clear_bad(pud))
-			continue;
-		ret += msync_pmd_range(vma, pud, addr, next);
-	} while (pud++, addr = next, addr != end);
-	return ret;
-}
-
-static unsigned long msync_page_range(struct vm_area_struct *vma,
-				unsigned long addr, unsigned long end)
-{
-	pgd_t *pgd;
-	unsigned long next;
-	unsigned long ret = 0;
-
-	/* For hugepages we can't go walking the page table normally,
-	 * but that's ok, hugetlbfs is memory based, so we don't need
-	 * to do anything more on an msync().
-	 */
-	if (vma->vm_flags & VM_HUGETLB)
-		return 0;
-
-	BUG_ON(addr >= end);
-	pgd = pgd_offset(vma->vm_mm, addr);
-	flush_cache_range(vma, addr, end);
-	do {
-		next = pgd_addr_end(addr, end);
-		if (pgd_none_or_clear_bad(pgd))
-			continue;
-		ret += msync_pud_range(vma, pgd, addr, next);
-	} while (pgd++, addr = next, addr != end);
-	return ret;
-}
-
 /*
  * MS_SYNC syncs the entire file - including mappings.
  *
- * MS_ASYNC does not start I/O (it used to, up to 2.5.67).  Instead, it just
- * marks the relevant pages dirty.  The application may now run fsync() to
+ * MS_ASYNC does not start I/O (it used to, up to 2.5.67).
+ * Nor does it marks the relevant pages dirty (it used to up to 2.6.17).
+ * Now it doesn't do anything, since dirty pages are properly tracked.
+ *
+ * The application may now run fsync() to
  * write out the dirty pages and wait on the writeout and check the result.
  * Or the application may run fadvise(FADV_DONTNEED) against the fd to start
  * async writeout immediately.
@@ -130,16 +35,11 @@ static unsigned long msync_page_range(st
  * applications.
  */
 static int msync_interval(struct vm_area_struct *vma, unsigned long addr,
-			unsigned long end, int flags,
-			unsigned long *nr_pages_dirtied)
+			unsigned long end, int flags)
 {
-	struct file *file = vma->vm_file;
-
 	if ((flags & MS_INVALIDATE) && (vma->vm_flags & VM_LOCKED))
 		return -EBUSY;
 
-	if (file && (vma->vm_flags & VM_SHARED))
-		*nr_pages_dirtied = msync_page_range(vma, addr, end);
 	return 0;
 }
 
@@ -178,7 +78,6 @@ asmlinkage long sys_msync(unsigned long 
 		goto out_unlock;
 	}
 	do {
-		unsigned long nr_pages_dirtied = 0;
 		struct file *file;
 
 		/* Here start < vma->vm_end. */
@@ -189,8 +88,7 @@ asmlinkage long sys_msync(unsigned long 
 		/* Here vma->vm_start <= start < vma->vm_end. */
 		if (end <= vma->vm_end) {
 			if (start < end) {
-				error = msync_interval(vma, start, end, flags,
-							&nr_pages_dirtied);
+				error = msync_interval(vma, start, end, flags);
 				if (error)
 					goto out_unlock;
 			}
@@ -198,22 +96,13 @@ asmlinkage long sys_msync(unsigned long 
 			done = 1;
 		} else {
 			/* Here vma->vm_start <= start < vma->vm_end < end. */
-			error = msync_interval(vma, start, vma->vm_end, flags,
-						&nr_pages_dirtied);
+			error = msync_interval(vma, start, vma->vm_end, flags);
 			if (error)
 				goto out_unlock;
 		}
 		file = vma->vm_file;
 		start = vma->vm_end;
-		if ((flags & MS_ASYNC) && file && nr_pages_dirtied) {
-			get_file(file);
-			up_read(&current->mm->mmap_sem);
-			balance_dirty_pages_ratelimited_nr(file->f_mapping,
-							nr_pages_dirtied);
-			fput(file);
-			down_read(&current->mm->mmap_sem);
-			vma = find_vma(current->mm, start);
-		} else if ((flags & MS_SYNC) && file &&
+		if ((flags & MS_SYNC) && file &&
 				(vma->vm_flags & VM_SHARED)) {
 			get_file(file);
 			up_read(&current->mm->mmap_sem);
