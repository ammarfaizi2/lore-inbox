Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265533AbSKFCYn>; Tue, 5 Nov 2002 21:24:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265537AbSKFCYn>; Tue, 5 Nov 2002 21:24:43 -0500
Received: from holomorphy.com ([66.224.33.161]:63899 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S265533AbSKFCYk>;
	Tue, 5 Nov 2002 21:24:40 -0500
To: linux-kernel@vger.kernel.org
Subject: [2/7] hugetlb: fix zap_hugetlb_resources()
Message-Id: <E189Fwj-0002YK-00@holomorphy>
From: William Lee Irwin III <wli@holomorphy.com>
Date: Tue, 05 Nov 2002 18:29:33 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch eliminates zap_hugetlb_resources, along with its usages.
This actually fixes bugs, as zap_hugetlb_resources was itself buggy.

 hugetlbpage.c |   11 ++---------
 1 files changed, 2 insertions(+), 9 deletions(-)


diff -urpN numaq-2.5.46/arch/i386/mm/hugetlbpage.c hugetlbfs-2.5.46/arch/i386/mm/hugetlbpage.c
--- numaq-2.5.46/arch/i386/mm/hugetlbpage.c	2002-11-04 14:30:50.000000000 -0800
+++ hugetlbfs-2.5.46/arch/i386/mm/hugetlbpage.c	2002-11-05 11:00:42.000000000 -0800
@@ -23,8 +23,6 @@ struct list_head htlbpage_freelist;
 spinlock_t htlbpage_lock = SPIN_LOCK_UNLOCKED;
 extern long htlbpagemem;
 
-void zap_hugetlb_resources(struct vm_area_struct *);
-
 #define MAX_ID 	32
 struct htlbpagekey {
 	struct inode *in;
@@ -143,7 +141,7 @@ int make_hugetlb_pages_present(unsigned 
 out_error:		/* Error case, remove the partial lp_resources. */
 	if (addr > vma->vm_start) {
 		vma->vm_end = addr;
-		zap_hugetlb_resources(vma);
+		zap_hugepage_range(vma, vma->vm_start, vma->vm_end - vma->vm_start);
 		vma->vm_end = end;
 	}
 	spin_unlock(&mm->page_table_lock);
@@ -263,11 +261,6 @@ void zap_hugepage_range(struct vm_area_s
 	spin_unlock(&mm->page_table_lock);
 }
 
-void zap_hugetlb_resources(struct vm_area_struct *vma)
-{
-	zap_hugepage_range(vma, vma->vm_start, vma->vm_end);
-}
-
 static void unlink_vma(struct vm_area_struct *mpnt)
 {
 	struct mm_struct *mm = current->mm;
@@ -397,7 +390,7 @@ out:
 		unsigned long raddr;
 		raddr = vma->vm_end;
 		vma->vm_end = addr;
-		zap_hugetlb_resources(vma);
+		zap_hugepage_range(vma, vma->vm_start, vma->vm_end - vma->vm_start);
 		vma->vm_end = raddr;
 	}
 	spin_unlock(&mm->page_table_lock);
