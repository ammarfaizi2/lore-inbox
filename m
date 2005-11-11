Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751278AbVKKWgn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751278AbVKKWgn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 17:36:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751279AbVKKWgn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 17:36:43 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:26304 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751278AbVKKWgm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 17:36:42 -0500
Date: Fri, 11 Nov 2005 14:36:37 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: Christoph Lameter <clameter@sgi.com>, lhms-devel@lists.sourceforge.net
Message-Id: <20051111223637.21716.94084.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20051111223632.21716.49021.sendpatchset@schroedinger.engr.sgi.com>
References: <20051111223632.21716.49021.sendpatchset@schroedinger.engr.sgi.com>
Subject: [PATCH 1/8] Direct Migration V3: Swap migration patchset fixes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes to swap migration patch V5

- Fix comment for isolate_lru_page().

- migrate_page_add: check for mapping == NULL

- check_range: Its okay if the first vma has the flag VM_RESERVED set if the
  MPOL_MF_DISCONTIG_OK flag was specified by the caller.

- Change the permission check to use comparisons instead of XORs.
  Revise the comments.

- Only include move_to_lru and putback_lru_pages() if CONFIG_MIGRATION is set.
  (this may be the 0.5k codesize that Andrew was worrying about)

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.14-mm2/mm/vmscan.c
===================================================================
--- linux-2.6.14-mm2.orig/mm/vmscan.c	2005-11-11 12:26:58.000000000 -0800
+++ linux-2.6.14-mm2/mm/vmscan.c	2005-11-11 12:42:13.000000000 -0800
@@ -572,6 +572,39 @@ keep:
 }
 
 #ifdef CONFIG_MIGRATION
+static inline void move_to_lru(struct page *page)
+{
+	list_del(&page->lru);
+	if (PageActive(page)) {
+		/*
+		 * lru_cache_add_active checks that
+		 * the PG_active bit is off.
+		 */
+		ClearPageActive(page);
+		lru_cache_add_active(page);
+	} else
+		lru_cache_add(page);
+	put_page(page);
+}
+
+/*
+ * Add isolated pages on the list back to the LRU
+ *
+ * returns the number of pages put back.
+ */
+int putback_lru_pages(struct list_head *l)
+{
+	struct page *page;
+	struct page *page2;
+	int count = 0;
+
+	list_for_each_entry_safe(page, page2, l, lru) {
+		move_to_lru(page);
+		count++;
+	}
+	return count;
+}
+
 /*
  * swapout a single page
  * page is locked upon entry, unlocked on exit
@@ -782,7 +815,7 @@ static void lru_add_drain_per_cpu(void *
  * Result:
  *  0 = page not on LRU list
  *  1 = page removed from LRU list and added to the specified list.
- * -1 = page is being freed elsewhere.
+ * -ENOENT = page is being freed elsewhere.
  */
 int isolate_lru_page(struct page *page)
 {
@@ -868,39 +901,6 @@ done:
 	pagevec_release(&pvec);
 }
 
-static inline void move_to_lru(struct page *page)
-{
-	list_del(&page->lru);
-	if (PageActive(page)) {
-		/*
-		 * lru_cache_add_active checks that
-		 * the PG_active bit is off.
-		 */
-		ClearPageActive(page);
-		lru_cache_add_active(page);
-	} else
-		lru_cache_add(page);
-	put_page(page);
-}
-
-/*
- * Add isolated pages on the list back to the LRU
- *
- * returns the number of pages put back.
- */
-int putback_lru_pages(struct list_head *l)
-{
-	struct page *page;
-	struct page *page2;
-	int count = 0;
-
-	list_for_each_entry_safe(page, page2, l, lru) {
-		move_to_lru(page);
-		count++;
-	}
-	return count;
-}
-
 /*
  * This moves pages from the active list to the inactive list.
  *
Index: linux-2.6.14-mm2/mm/mempolicy.c
===================================================================
--- linux-2.6.14-mm2.orig/mm/mempolicy.c	2005-11-11 12:29:04.000000000 -0800
+++ linux-2.6.14-mm2/mm/mempolicy.c	2005-11-11 12:29:06.000000000 -0800
@@ -217,6 +217,7 @@ static void migrate_page_add(struct vm_a
 	 * Avoid migrating a page that is shared by others and not writable.
 	 */
 	if ((flags & MPOL_MF_MOVE_ALL) ||
+	    !page->mapping ||
 	    PageAnon(page) ||
 	    mapping_writably_mapped(page->mapping) ||
 	    single_mm_mapping(vma->vm_mm, page->mapping)
@@ -359,7 +360,8 @@ check_range(struct mm_struct *mm, unsign
 	first = find_vma(mm, start);
 	if (!first)
 		return ERR_PTR(-EFAULT);
-	if (first->vm_flags & VM_RESERVED)
+	if (first->vm_flags & VM_RESERVED &&
+	    !(flags & MPOL_MF_DISCONTIG_OK))
 		return ERR_PTR(-EACCES);
 	prev = NULL;
 	for (vma = first; vma && vma->vm_start < end; vma = vma->vm_next) {
@@ -790,18 +792,13 @@ asmlinkage long sys_migrate_pages(pid_t 
 		return -EINVAL;
 
 	/*
-	 * We only allow a process to move the pages of another
-	 * if the process issuing sys_migrate has the right to send a kill
-	 * signal to the process to be moved. Moving another processes
-	 * memory may impact the performance of that process. If the
-	 * process issuing sys_migrate_pages has the right to kill the
-	 * target process then obviously that process has the right to
-	 * impact the performance of the target process.
-	 *
-	 * The permission check was taken from  check_kill_permission()
+	 * Check if this process has the right to modify the specified
+	 * process. The right exists if the process has administrative
+	 * capabilities, superuser priviledges or the same
+	 * userid as the target process.
 	 */
-	if ((current->euid ^ task->suid) && (current->euid ^ task->uid) &&
-	    (current->uid ^ task->suid) && (current->uid ^ task->uid) &&
+	if ((current->euid != task->suid) && (current->euid != task->uid) &&
+	    (current->uid != task->suid) && (current->uid != task->uid) &&
 	    !capable(CAP_SYS_ADMIN)) {
 		err = -EPERM;
 		goto out;
