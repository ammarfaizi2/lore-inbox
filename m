Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030348AbWJJXen@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030348AbWJJXen (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 19:34:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030680AbWJJXen
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 19:34:43 -0400
Received: from mga01.intel.com ([192.55.52.88]:1549 "EHLO mga01.intel.com")
	by vger.kernel.org with ESMTP id S1030348AbWJJXel (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 19:34:41 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,291,1157353200"; 
   d="scan'208"; a="144395969:sNHT19530714"
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Hugh Dickins'" <hugh@veritas.com>
Cc: "'David Gibson'" <david@gibson.dropbear.id.au>,
       "Andrew Morton" <akpm@osdl.org>, <linux-kernel@vger.kernel.org>
Subject: RE: Hugepage regression
Date: Tue, 10 Oct 2006 16:34:40 -0700
Message-ID: <000301c6ecc4$a83af8a0$cb34030a@amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
Thread-Index: AcbsoNunZiHMtnHETdC+/w8B4doNFgAIInpg
In-Reply-To: <Pine.LNX.4.64.0610101958270.21452@blonde.wat.veritas.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins wrote on Tuesday, October 10, 2006 12:18 PM
> Yes, I'd expect your i_mmap_lock to solve the problem: and since
> you're headed in that direction anyway, it makes most sense to use
> that solution rather than get into defining arrays, or sacrificing
> the lazy flush, or risking page_count races.
> 
> So please extract the __unmap_hugepage_range mods from your shared
> pagetable patch, and use that to fix the bug.


OK, here is a bug fix patch fixing earlier "bug fix" patch :-(


[patch] hugetlb: fix linked list corruption in unmap_hugepage_range

commit fe1668ae5bf0145014c71797febd9ad5670d5d05 causes kernel to oops with
libhugetlbfs test suite.  The problem is that hugetlb pages can be shared
by multiple mappings. Multiple threads can fight over page->lru in the unmap
path and bad things happen.  We now serialize __unmap_hugepage_range to void
concurrent linked list manipulation.  Such serialization is also needed for
shared page table page on hugetlb area. This patch will fixed the bug and
also serve as a prepatch for shared page table.


Signed-off-by: Ken Chen <kenneth.w.chen@intel.com>

--- ./fs/hugetlbfs/inode.c.orig	2006-10-05 10:25:20.000000000 -0700
+++ ./fs/hugetlbfs/inode.c	2006-10-10 14:27:48.000000000 -0700
@@ -293,7 +293,7 @@ hugetlb_vmtruncate_list(struct prio_tree
 		if (h_vm_pgoff >= h_pgoff)
 			v_offset = 0;
 
-		unmap_hugepage_range(vma,
+		__unmap_hugepage_range(vma,
 				vma->vm_start + v_offset, vma->vm_end);
 	}
 }
--- ./mm/hugetlb.c.orig	2006-10-05 10:25:21.000000000 -0700
+++ ./mm/hugetlb.c	2006-10-10 14:27:48.000000000 -0700
@@ -356,8 +356,8 @@ nomem:
 	return -ENOMEM;
 }
 
-void unmap_hugepage_range(struct vm_area_struct *vma, unsigned long start,
-			  unsigned long end)
+void __unmap_hugepage_range(struct vm_area_struct *vma, unsigned long start,
+			    unsigned long end)
 {
 	struct mm_struct *mm = vma->vm_mm;
 	unsigned long address;
@@ -398,6 +398,24 @@ void unmap_hugepage_range(struct vm_area
 	}
 }
 
+void unmap_hugepage_range(struct vm_area_struct *vma, unsigned long start,
+			  unsigned long end)
+{
+	/*
+	 * It is undesirable to test vma->vm_file as it should be non-null
+	 * for valid hugetlb area. However, vm_file will be NULL in the error
+	 * cleanup path of do_mmap_pgoff. When hugetlbfs ->mmap method fails,
+	 * do_mmap_pgoff() nullifies vma->vm_file before calling this function
+	 * to clean up. Since no pte has actually been setup, it is safe to
+	 * do nothing in this case.
+	 */
+	if (vma->vm_file) {
+		spin_lock(&vma->vm_file->f_mapping->i_mmap_lock);
+		__unmap_hugepage_range(vma, start, end);
+		spin_unlock(&vma->vm_file->f_mapping->i_mmap_lock);
+	}
+}
+
 static int hugetlb_cow(struct mm_struct *mm, struct vm_area_struct *vma,
 			unsigned long address, pte_t *ptep, pte_t pte)
 {
--- ./include/linux/hugetlb.h.orig	2006-10-05 10:25:21.000000000 -0700
+++ ./include/linux/hugetlb.h	2006-10-10 13:08:48.000000000 -0700
@@ -17,6 +17,7 @@ int hugetlb_sysctl_handler(struct ctl_ta
 int copy_hugetlb_page_range(struct mm_struct *, struct mm_struct *, struct vm_area_struct *);
 int follow_hugetlb_page(struct mm_struct *, struct vm_area_struct *, struct page **, struct vm_area_struct **, unsigned long *, int
*, int);
 void unmap_hugepage_range(struct vm_area_struct *, unsigned long, unsigned long);
+void __unmap_hugepage_range(struct vm_area_struct *, unsigned long, unsigned long);
 int hugetlb_prefault(struct address_space *, struct vm_area_struct *);
 int hugetlb_report_meminfo(char *);
 int hugetlb_report_node_meminfo(int, char *);



