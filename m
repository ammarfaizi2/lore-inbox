Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750700AbWB1EAc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750700AbWB1EAc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 23:00:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750732AbWB1EAc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 23:00:32 -0500
Received: from ozlabs.org ([203.10.76.45]:24247 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1750700AbWB1EAb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 23:00:31 -0500
Date: Tue, 28 Feb 2006 14:59:52 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Andrew Morton <akpm@osdl.org>
Cc: William Lee Irwin <wli@holomorphy.com>, linux-kernel@vger.kernel.org
Subject: hugepage: Small fixes to hugepage clear/copy path
Message-ID: <20060228035952.GD2570@localhost.localdomain>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Andrew Morton <akpm@osdl.org>,
	William Lee Irwin <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch moves the loops used in mm/hugetlb.c to clear and copy
hugepages to their own functions for clarity.  As we do so, we add
some checks of need_resched - we are, after all copying megabytes of
memory here.  We also add might_sleep() accordingly.  We generally
dropped locks around the clear and copy, already but not everyone has
PREEMPT enabled, so we should still be checking explicitly.

For this to work, we need to remove the clear_huge_page() from
alloc_huge_page(), which is called with the page_table_lock held in
the COW path.  We move the clear_huge_page() to just after the
alloc_huge_page() in the hugepage no-page path.  In the COW path, the
new page is about to be copied over, so clearing it was just a waste
of time anyway.  So as a side effect we also fix the fact that we held
the page_table_lock for far too long in this path by calling
alloc_huge_page() under it.

This patch applies on top of 'hugepage-allocator-cleanup.patch' and
'enable-mprotect-on-huge-pages.patch' from -mm.  It causes no
regressions on the libhugetlbfs testsuite (ppc64, POWER5).

Signed-off-by: David Gibson <dwg@au1.ibm.com>

Index: working-2.6/mm/hugetlb.c
===================================================================
--- working-2.6.orig/mm/hugetlb.c	2006-02-28 11:40:17.000000000 +1100
+++ working-2.6/mm/hugetlb.c	2006-02-28 11:50:29.000000000 +1100
@@ -26,6 +26,32 @@ static struct list_head hugepage_freelis
 static unsigned int nr_huge_pages_node[MAX_NUMNODES];
 static unsigned int free_huge_pages_node[MAX_NUMNODES];
 
+static void clear_huge_page(struct page *page, unsigned long addr)
+{
+	int i;
+
+	might_sleep();
+	for (i = 0; i < (HPAGE_SIZE/PAGE_SIZE); i++) {
+		if (need_resched())
+			schedule();
+
+		clear_user_highpage(page + i, addr);
+	}
+}
+
+static void copy_huge_page(struct page *dst, struct page *src,
+			   unsigned long addr)
+{
+	int i;
+
+	might_sleep();
+	for (i = 0; i < HPAGE_SIZE/PAGE_SIZE; i++) {
+		if (need_resched())
+			schedule();
+		copy_user_highpage(dst + i, src + i, addr + i*PAGE_SIZE);
+	}
+}
+
 /*
  * Protects updates to hugepage_freelists, nr_huge_pages, and free_huge_pages
  */
@@ -97,7 +123,6 @@ void free_huge_page(struct page *page)
 struct page *alloc_huge_page(struct vm_area_struct *vma, unsigned long addr)
 {
 	struct page *page;
-	int i;
 
 	spin_lock(&hugetlb_lock);
 	page = dequeue_huge_page(vma, addr);
@@ -107,8 +132,6 @@ struct page *alloc_huge_page(struct vm_a
 	}
 	spin_unlock(&hugetlb_lock);
 	set_page_count(page, 1);
-	for (i = 0; i < (HPAGE_SIZE/PAGE_SIZE); ++i)
-		clear_user_highpage(&page[i], addr);
 	return page;
 }
 
@@ -366,7 +389,7 @@ static int hugetlb_cow(struct mm_struct 
 			unsigned long address, pte_t *ptep, pte_t pte)
 {
 	struct page *old_page, *new_page;
-	int i, avoidcopy;
+	int avoidcopy;
 
 	old_page = pte_page(pte);
 
@@ -387,9 +410,7 @@ static int hugetlb_cow(struct mm_struct 
 	}
 
 	spin_unlock(&mm->page_table_lock);
-	for (i = 0; i < HPAGE_SIZE/PAGE_SIZE; i++)
-		copy_user_highpage(new_page + i, old_page + i,
-				   address + i*PAGE_SIZE);
+	copy_huge_page(new_page, old_page, address);
 	spin_lock(&mm->page_table_lock);
 
 	ptep = huge_pte_offset(mm, address & HPAGE_MASK);
@@ -434,6 +455,7 @@ retry:
 			ret = VM_FAULT_OOM;
 			goto out;
 		}
+		clear_huge_page(page, address);
 
 		if (vma->vm_flags & VM_SHARED) {
 			int err;

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
