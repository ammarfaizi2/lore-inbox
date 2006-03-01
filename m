Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932095AbWCAEmq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932095AbWCAEmq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 23:42:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932111AbWCAEmq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 23:42:46 -0500
Received: from ozlabs.org ([203.10.76.45]:12175 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S932095AbWCAEmp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 23:42:45 -0500
Date: Wed, 1 Mar 2006 15:41:59 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Andrew Morton <akpm@osdl.org>
Cc: William Lee Irwin <wli@holomorphy.com>, linux-kernel@vger.kernel.org
Subject: hugepage: Make {alloc,free}_huge_page() local
Message-ID: <20060301044158.GA15710@localhost.localdomain>
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

This applies on top of all my other hugepage patches in -mm.

Originally, mm/hugetlb.c just handled the hugepage physical allocation
path and its {alloc,free}_huge_page() functions were used from the
arch specific hugepage code.  These days those functions are only used
with mm/hugetlb.c itself.  Therefore, this patch makes them static and
removes their prototypes from hugetlb.h.  This requires a small
rearrangement of code in mm/hugetlb.c to avoid a forward declaration.

This patch causes no regressions on the libhugetlbfs testsuite (ppc64,
POWER5).

Signed-off-by: David Gibson <dwg@au1.ibm.com>

Index: working-2.6/include/linux/hugetlb.h
===================================================================
--- working-2.6.orig/include/linux/hugetlb.h	2006-03-01 15:34:04.000000000 +1100
+++ working-2.6/include/linux/hugetlb.h	2006-03-01 15:34:04.000000000 +1100
@@ -21,8 +21,6 @@ int hugetlb_prefault(struct address_spac
 int hugetlb_report_meminfo(char *);
 int hugetlb_report_node_meminfo(int, char *);
 unsigned long hugetlb_total_pages(void);
-struct page *alloc_huge_page(struct vm_area_struct *, unsigned long);
-void free_huge_page(struct page *);
 int hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 			unsigned long address, int write_access);
 
@@ -97,8 +95,6 @@ static inline unsigned long hugetlb_tota
 #define is_hugepage_only_range(mm, addr, len)	0
 #define hugetlb_free_pgd_range(tlb, addr, end, floor, ceiling) \
 						do { } while (0)
-#define alloc_huge_page(vma, addr)		({ NULL; })
-#define free_huge_page(p)			({ (void)(p); BUG(); })
 #define hugetlb_fault(mm, vma, addr, write)	({ BUG(); 0; })
 
 #define hugetlb_change_protection(vma, address, end, newprot)
Index: working-2.6/mm/hugetlb.c
===================================================================
--- working-2.6.orig/mm/hugetlb.c	2006-03-01 15:34:04.000000000 +1100
+++ working-2.6/mm/hugetlb.c	2006-03-01 15:37:55.000000000 +1100
@@ -87,6 +87,17 @@ static struct page *dequeue_huge_page(st
 	return page;
 }
 
+static void free_huge_page(struct page *page)
+{
+	BUG_ON(page_count(page));
+
+	INIT_LIST_HEAD(&page->lru);
+
+	spin_lock(&hugetlb_lock);
+	enqueue_huge_page(page);
+	spin_unlock(&hugetlb_lock);
+}
+
 static int alloc_fresh_huge_page(void)
 {
 	static int nid = 0;
@@ -106,18 +117,8 @@ static int alloc_fresh_huge_page(void)
 	return 0;
 }
 
-void free_huge_page(struct page *page)
-{
-	BUG_ON(page_count(page));
-
-	INIT_LIST_HEAD(&page->lru);
-
-	spin_lock(&hugetlb_lock);
-	enqueue_huge_page(page);
-	spin_unlock(&hugetlb_lock);
-}
-
-struct page *alloc_huge_page(struct vm_area_struct *vma, unsigned long addr)
+static struct page *alloc_huge_page(struct vm_area_struct *vma,
+				    unsigned long addr)
 {
 	struct inode *inode = vma->vm_file->f_dentry->d_inode;
 	struct page *page;

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
