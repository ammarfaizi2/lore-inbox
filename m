Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932261AbVJKSb6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932261AbVJKSb6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 14:31:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932267AbVJKSb6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 14:31:58 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:19584 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S932261AbVJKSb5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 14:31:57 -0400
Subject: [PATCH 1/3] hugetlb: Remove get_user_pages optimization
From: Adam Litke <agl@us.ibm.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       David Gibson <david@gibson.dropbear.id.au>, ak@suse.de,
       hugh@veritas.com, agl@us.ibm.com
In-Reply-To: <1129055057.22182.8.camel@localhost.localdomain>
References: <1129055057.22182.8.camel@localhost.localdomain>
Content-Type: text/plain
Organization: IBM
Date: Tue, 11 Oct 2005 13:31:51 -0500
Message-Id: <1129055511.22182.11.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Version 2 (Mon, 3 Oct 2005)
* Removed follow_hugetlb_page since get_user_pages() was the only caller.

Initial Post (Thu, 18 Aug 2005)

In preparation for hugetlb demand faulting, remove this get_user_pages()
optimization.  Since huge pages will no longer be prefaulted, we can't assume
that the huge ptes are established and hence, calling follow_hugetlb_page() is
not valid.

With the follow_hugetlb_page() call removed, the normal code path will be
triggered.  follow_page() will either use follow_huge_addr() or
follow_huge_pmd() to check for a previously faulted "page" to return.  When
this fails (ie. with demand faults), __handle_mm_fault() gets called which
invokes the hugetlb_fault() handler to instantiate the huge page.

This patch doesn't make a lot of sense by itself, but I've broken it out to
facilitate discussion on this specific element of the demand fault changes.
While coding this up, I referenced previous discussion on this topic starting
at http://lkml.org/lkml/2004/4/13/176 , which contains more opinions about the
correctness of this approach.

Signed-off-by: Adam Litke <agl@us.ibm.com>

---
 hugetlb.c |   54 ------------------------------------------------------
 memory.c  |    5 -----
 2 files changed, 59 deletions(-)
diff -upN reference/mm/hugetlb.c current/mm/hugetlb.c
--- reference/mm/hugetlb.c
+++ current/mm/hugetlb.c
@@ -392,57 +392,3 @@ out:
 	spin_unlock(&mm->page_table_lock);
 	return ret;
 }
-
-int follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
-			struct page **pages, struct vm_area_struct **vmas,
-			unsigned long *position, int *length, int i)
-{
-	unsigned long vpfn, vaddr = *position;
-	int remainder = *length;
-
-	BUG_ON(!is_vm_hugetlb_page(vma));
-
-	vpfn = vaddr/PAGE_SIZE;
-	spin_lock(&mm->page_table_lock);
-	while (vaddr < vma->vm_end && remainder) {
-
-		if (pages) {
-			pte_t *pte;
-			struct page *page;
-
-			/* Some archs (sparc64, sh*) have multiple
-			 * pte_ts to each hugepage.  We have to make
-			 * sure we get the first, for the page
-			 * indexing below to work. */
-			pte = huge_pte_offset(mm, vaddr & HPAGE_MASK);
-
-			/* the hugetlb file might have been truncated */
-			if (!pte || pte_none(*pte)) {
-				remainder = 0;
-				if (!i)
-					i = -EFAULT;
-				break;
-			}
-
-			page = &pte_page(*pte)[vpfn % (HPAGE_SIZE/PAGE_SIZE)];
-
-			WARN_ON(!PageCompound(page));
-
-			get_page(page);
-			pages[i] = page;
-		}
-
-		if (vmas)
-			vmas[i] = vma;
-
-		vaddr += PAGE_SIZE;
-		++vpfn;
-		--remainder;
-		++i;
-	}
-	spin_unlock(&mm->page_table_lock);
-	*length = remainder;
-	*position = vaddr;
-
-	return i;
-}
diff -upN reference/mm/memory.c current/mm/memory.c
--- reference/mm/memory.c
+++ current/mm/memory.c
@@ -971,11 +971,6 @@ int get_user_pages(struct task_struct *t
 				|| !(flags & vma->vm_flags))
 			return i ? : -EFAULT;
 
-		if (is_vm_hugetlb_page(vma)) {
-			i = follow_hugetlb_page(mm, vma, pages, vmas,
-						&start, &len, i);
-			continue;
-		}
 		spin_lock(&mm->page_table_lock);
 		do {
 			int write_access = write;

-- 
Adam Litke - (agl at us.ibm.com)
IBM Linux Technology Center

