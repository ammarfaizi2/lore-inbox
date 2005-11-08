Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030346AbVKHVDv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030346AbVKHVDv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 16:03:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030348AbVKHVDv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 16:03:51 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:29408 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1030346AbVKHVDt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 16:03:49 -0500
Date: Tue, 8 Nov 2005 13:03:11 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: akpm@osdl.org
Cc: Mike Kravetz <kravetz@us.ibm.com>, linux-kernel@vger.kernel.org,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, linux-mm@kvack.org,
       torvalds@osdl.org, Christoph Lameter <clameter@sgi.com>,
       Hirokazu Takahashi <taka@valinux.co.jp>, Andi Kleen <ak@suse.de>,
       Magnus Damm <magnus.damm@gmail.com>, Paul Jackson <pj@sgi.com>,
       Dave Hansen <haveblue@us.ibm.com>,
       KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Message-Id: <20051108210301.31330.5501.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20051108210246.31330.61756.sendpatchset@schroedinger.engr.sgi.com>
References: <20051108210246.31330.61756.sendpatchset@schroedinger.engr.sgi.com>
Subject: [PATCH 1/8] Direct Migration V2: Swap migration patchset fixes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes to swap migration patch V5 (may already be in mm)

- Fix comment for isolate_lru_page() and the check for the result
  of __isolate_lru_page in isolate_lru_pages()

- migrate_page_add: check for mapping == NULL

- check_range: Its okay if the first vma has the flag VM_RESERVED set if the
  MPOL_MF_DISCONTIG_OK flag was specified by the caller.

- Change the permission check to use comparisons instead of XORs.
  Revise the comments.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.14-mm1/mm/vmscan.c
===================================================================
--- linux-2.6.14-mm1.orig/mm/vmscan.c	2005-11-07 11:48:47.000000000 -0800
+++ linux-2.6.14-mm1/mm/vmscan.c	2005-11-08 11:17:13.000000000 -0800
@@ -755,7 +755,7 @@ static int isolate_lru_pages(struct zone
 			/* Succeeded to isolate page */
 			list_add(&page->lru, dst);
 			break;
-		case -1:
+		case -ENOENT:
 			/* Not possible to isolate */
 			list_move(&page->lru, src);
 			break;
@@ -782,7 +782,7 @@ static void lru_add_drain_per_cpu(void *
  * Result:
  *  0 = page not on LRU list
  *  1 = page removed from LRU list and added to the specified list.
- * -1 = page is being freed elsewhere.
+ * -ENOENT = page is being freed elsewhere.
  */
 int isolate_lru_page(struct page *page)
 {
Index: linux-2.6.14-mm1/mm/mempolicy.c
===================================================================
--- linux-2.6.14-mm1.orig/mm/mempolicy.c	2005-11-07 11:48:26.000000000 -0800
+++ linux-2.6.14-mm1/mm/mempolicy.c	2005-11-08 11:16:42.000000000 -0800
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
