Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932229AbVIYPva@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932229AbVIYPva (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Sep 2005 11:51:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932169AbVIYPva
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Sep 2005 11:51:30 -0400
Received: from silver.veritas.com ([143.127.12.111]:28086 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S932229AbVIYPv3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Sep 2005 11:51:29 -0400
Date: Sun, 25 Sep 2005 16:51:03 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: Paolo Giarrusso <blaisorblade@yahoo.it>, linux-kernel@vger.kernel.org
Subject: [PATCH 05/21] mm: anon is already wrprotected
In-Reply-To: <Pine.LNX.4.61.0509251644100.3490@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.61.0509251649580.3490@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0509251644100.3490@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 25 Sep 2005 15:51:29.0321 (UTC) FILETIME=[FE50D190:01C5C1E8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

do_anonymous_page's pte_wrprotect causes some confusion: in such a case,
vm_page_prot must already be forcing COW, so must omit write permission,
and so the pte_wrprotect is redundant.  Replace it by a comment to that
effect, and reword the comment on unuse_pte which also caused confusion.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

 mm/memory.c   |    7 ++++---
 mm/swapfile.c |    7 +++----
 2 files changed, 7 insertions(+), 7 deletions(-)

--- mm04/mm/memory.c	2005-09-24 19:27:05.000000000 +0100
+++ mm05/mm/memory.c	2005-09-24 19:27:19.000000000 +0100
@@ -1768,13 +1768,14 @@ do_anonymous_page(struct mm_struct *mm, 
 		unsigned long addr)
 {
 	pte_t entry;
-	struct page * page = ZERO_PAGE(addr);
 
-	/* Read-only mapping of ZERO_PAGE. */
-	entry = pte_wrprotect(mk_pte(ZERO_PAGE(addr), vma->vm_page_prot));
+	/* Mapping of ZERO_PAGE - vm_page_prot is readonly */
+	entry = mk_pte(ZERO_PAGE(addr), vma->vm_page_prot);
 
 	/* ..except if it's a write access */
 	if (write_access) {
+		struct page *page;
+
 		/* Allocate our own private page. */
 		pte_unmap(page_table);
 		spin_unlock(&mm->page_table_lock);
--- mm04/mm/swapfile.c	2005-09-22 12:32:04.000000000 +0100
+++ mm05/mm/swapfile.c	2005-09-24 19:27:19.000000000 +0100
@@ -396,10 +396,9 @@ void free_swap_and_cache(swp_entry_t ent
 }
 
 /*
- * Always set the resulting pte to be nowrite (the same as COW pages
- * after one process has exited).  We don't know just how many PTEs will
- * share this swap entry, so be cautious and let do_wp_page work out
- * what to do if a write is requested later.
+ * No need to decide whether this PTE shares the swap entry with others,
+ * just let do_wp_page work it out if a write is requested later - to
+ * force COW, vm_page_prot omits write permission from any private vma.
  *
  * vma->vm_mm->page_table_lock is held.
  */
