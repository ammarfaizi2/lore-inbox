Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266298AbSKLIZ4>; Tue, 12 Nov 2002 03:25:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266307AbSKLIZM>; Tue, 12 Nov 2002 03:25:12 -0500
Received: from holomorphy.com ([66.224.33.161]:40121 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S266308AbSKLIYf>;
	Tue, 12 Nov 2002 03:24:35 -0500
To: linux-kernel@vger.kernel.org
Subject: [3/11] hugetlb: wrap release path with release_key()
Message-Id: <E18BWPl-0005KA-00@holomorphy>
From: William Lee Irwin III <wli@holomorphy.com>
Date: Tue, 12 Nov 2002 00:28:53 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This wraps the release path in alloc_shared_hugetlb_pages() with a
release_key() function that handles the release.

 hugetlbpage.c |   31 ++++++++++++++++++++-----------
 1 files changed, 20 insertions(+), 11 deletions(-)


diff -urpN htlb-2.5.47-2/arch/i386/mm/hugetlbpage.c htlb-2.5.47-3/arch/i386/mm/hugetlbpage.c
--- htlb-2.5.47-2/arch/i386/mm/hugetlbpage.c	2002-11-11 21:08:00.000000000 -0800
+++ htlb-2.5.47-3/arch/i386/mm/hugetlbpage.c	2002-11-11 21:23:55.000000000 -0800
@@ -101,6 +101,23 @@ struct hugetlb_key *alloc_key(int key, u
 	return (struct hugetlb_key *)inode;
 }
 
+static void release_key(struct hugetlb_key *key)
+{
+	int i;
+	struct inode *inode = (struct inode *)key;;
+
+	spin_lock(&htlbpage_lock);
+	for(i = 0;i < MAX_ID; ++i)
+		if (htlbpagek[i].key != inode->i_ino)
+			continue;
+
+	BUG_ON(i >= MAX_ID);
+	htlbpagek[i].key = 0;
+	htlbpagek[i].in = NULL;
+	kfree(inode);
+	spin_unlock(&htlbpage_lock);
+}
+
 static struct page *alloc_hugetlb_page(void)
 {
 	int i;
@@ -339,7 +356,6 @@ static int alloc_shared_hugetlb_pages(in
 	struct vm_area_struct *vma;
 	struct inode *inode;
 	struct address_space *mapping;
-	int idx;
 	int retval = -ENOMEM;
 	int newalloc = 0;
 
@@ -390,16 +406,9 @@ out:
 	return retval;
 out_err: spin_unlock(&htlbpage_lock);
 freeinode:
-	 if (newalloc) {
-		 for(idx=0;idx<MAX_ID;idx++)
-			 if (htlbpagek[idx].key == inode->i_ino) {
-				 htlbpagek[idx].key = 0;
-				 htlbpagek[idx].in = NULL;
-				 break;
-			 }
-		 kfree(inode);
-	 }
-	 return retval;
+	if (newalloc)
+		release_key((struct hugetlb_key *)inode);
+	return retval;
 }
 
 int hugetlb_prefault(struct address_space *mapping, struct vm_area_struct *vma)
