Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264054AbUFBUNQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264054AbUFBUNQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 16:13:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264026AbUFBUNP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 16:13:15 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:56415 "EHLO
	MTVMIME02.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S264054AbUFBUMG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 16:12:06 -0400
Date: Wed, 2 Jun 2004 21:11:56 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] kill missed pte warning
In-Reply-To: <Pine.LNX.4.44.0406022103500.27696-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0406022110580.27696-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've seen no warnings, nor heard any reports of warnings, that anon_vma
ever misses ptes (nor anonmm before it).  That WARN_ON (with its useless
stack dump) was okay to goad developers into making reports, but would
mainly be an irritation if it ever appears on user systems: kill it now.

Signed-off-by: Hugh Dickins <hugh@veritas.com>

 mm/rmap.c |   29 +++++++----------------------
 1 files changed, 7 insertions(+), 22 deletions(-)

--- 2.6.7-rc2/mm/rmap.c	2004-05-30 11:36:40.000000000 +0100
+++ linux/mm/rmap.c	2004-06-02 16:32:17.644617976 +0100
@@ -193,7 +193,7 @@ vma_address(struct page *page, struct vm
  * repeatedly from either page_referenced_anon or page_referenced_file.
  */
 static int page_referenced_one(struct page *page,
-	struct vm_area_struct *vma, unsigned int *mapcount, int *failed)
+	struct vm_area_struct *vma, unsigned int *mapcount)
 {
 	struct mm_struct *mm = vma->vm_mm;
 	unsigned long address;
@@ -208,14 +208,8 @@ static int page_referenced_one(struct pa
 	if (address == -EFAULT)
 		goto out;
 
-	if (!spin_trylock(&mm->page_table_lock)) {
-		/*
-		 * For debug we're currently warning if not all found,
-		 * but in this case that's expected: suppress warning.
-		 */
-		(*failed)++;
+	if (!spin_trylock(&mm->page_table_lock))
 		goto out;
-	}
 
 	pgd = pgd_offset(mm, address);
 	if (!pgd_present(*pgd))
@@ -251,18 +245,14 @@ static inline int page_referenced_anon(s
 	struct anon_vma *anon_vma = (struct anon_vma *) page->mapping;
 	struct vm_area_struct *vma;
 	int referenced = 0;
-	int failed = 0;
 
 	spin_lock(&anon_vma->lock);
 	BUG_ON(list_empty(&anon_vma->head));
 	list_for_each_entry(vma, &anon_vma->head, anon_vma_node) {
-		referenced += page_referenced_one(page, vma,
-						  &mapcount, &failed);
+		referenced += page_referenced_one(page, vma, &mapcount);
 		if (!mapcount)
-			goto out;
+			break;
 	}
-	WARN_ON(!failed);
-out:
 	spin_unlock(&anon_vma->lock);
 	return referenced;
 }
@@ -289,7 +279,6 @@ static inline int page_referenced_file(s
 	struct vm_area_struct *vma = NULL;
 	struct prio_tree_iter iter;
 	int referenced = 0;
-	int failed = 0;
 
 	if (!spin_trylock(&mapping->i_mmap_lock))
 		return 0;
@@ -299,17 +288,13 @@ static inline int page_referenced_file(s
 		if ((vma->vm_flags & (VM_LOCKED|VM_MAYSHARE))
 				  == (VM_LOCKED|VM_MAYSHARE)) {
 			referenced++;
-			goto out;
+			break;
 		}
-		referenced += page_referenced_one(page, vma,
-						  &mapcount, &failed);
+		referenced += page_referenced_one(page, vma, &mapcount);
 		if (!mapcount)
-			goto out;
+			break;
 	}
 
-	if (list_empty(&mapping->i_mmap_nonlinear))
-		WARN_ON(!failed);
-out:
 	spin_unlock(&mapping->i_mmap_lock);
 	return referenced;
 }

