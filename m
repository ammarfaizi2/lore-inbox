Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266314AbSKLIZv>; Tue, 12 Nov 2002 03:25:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266310AbSKLIZV>; Tue, 12 Nov 2002 03:25:21 -0500
Received: from holomorphy.com ([66.224.33.161]:40889 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S266316AbSKLIYf>;
	Tue, 12 Nov 2002 03:24:35 -0500
To: linux-kernel@vger.kernel.org
Subject: [4/11] hugetlb: wrap hugetlb_prefault with prefault_key()
Message-Id: <E18BWPl-0005KC-00@holomorphy>
From: William Lee Irwin III <wli@holomorphy.com>
Date: Tue, 12 Nov 2002 00:28:53 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This wraps hugetlb_prefault() with prefault_key() in order to isolate the
dependency on inodes for prefaulting the hugetlb vma.

 hugetlbpage.c |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)


diff -urpN htlb-2.5.47-3/arch/i386/mm/hugetlbpage.c htlb-2.5.47-4/arch/i386/mm/hugetlbpage.c
--- htlb-2.5.47-3/arch/i386/mm/hugetlbpage.c	2002-11-11 21:23:55.000000000 -0800
+++ htlb-2.5.47-4/arch/i386/mm/hugetlbpage.c	2002-11-11 21:30:36.000000000 -0800
@@ -350,12 +350,18 @@ static int check_size_prot(struct inode 
 	return 0;
 }
 
+static int prefault_key(struct hugetlb_key *key, struct vm_area_struct *vma)
+{
+	struct inode *inode = (struct inode *)key;
+
+	return hugetlb_prefault(inode->i_mapping, vma);
+}
+
 static int alloc_shared_hugetlb_pages(int key, unsigned long addr, unsigned long len, int prot, int flag)
 {
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma;
 	struct inode *inode;
-	struct address_space *mapping;
 	int retval = -ENOMEM;
 	int newalloc = 0;
 
@@ -367,8 +373,6 @@ static int alloc_shared_hugetlb_pages(in
 	} else
 		spin_unlock(&htlbpage_lock);
 
-	mapping = inode->i_mapping;
-
 	addr = do_mmap_pgoff(NULL, addr, len, (unsigned long) prot,
 			MAP_NORESERVE|MAP_FIXED|MAP_PRIVATE|MAP_ANONYMOUS, 0);
 	if (IS_ERR((void *) addr))
@@ -380,7 +384,7 @@ static int alloc_shared_hugetlb_pages(in
 		goto freeinode;
 	}
 
-	retval = hugetlb_prefault(mapping, vma);
+	retval = prefault_key((struct hugetlb_key *)inode, vma);
 	if (retval)
 		goto out;
 
