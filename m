Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266316AbSKLIZz>; Tue, 12 Nov 2002 03:25:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266295AbSKLIYs>; Tue, 12 Nov 2002 03:24:48 -0500
Received: from holomorphy.com ([66.224.33.161]:41657 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S266296AbSKLIYe>;
	Tue, 12 Nov 2002 03:24:34 -0500
To: linux-kernel@vger.kernel.org
Subject: [5/11] hugetlb: embed busy flag in key structure
Message-Id: <E18BWPl-0005KE-00@holomorphy>
From: William Lee Irwin III <wli@holomorphy.com>
Date: Tue, 12 Nov 2002 00:28:53 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This replaces the usage of inode->i_writecount as a flag marking keys
busy with a boolean flag field in struct htlbpagekey, and removes the
last dependency of alloc_shared_hugetlb_pages() on struct inode.


 hugetlbpage.c |   43 ++++++++++++++++++++++++++++++++++++++++---
 1 files changed, 40 insertions(+), 3 deletions(-)


diff -urpN htlb-2.5.47-4/arch/i386/mm/hugetlbpage.c htlb-2.5.47-5/arch/i386/mm/hugetlbpage.c
--- htlb-2.5.47-4/arch/i386/mm/hugetlbpage.c	2002-11-11 21:30:36.000000000 -0800
+++ htlb-2.5.47-5/arch/i386/mm/hugetlbpage.c	2002-11-11 21:49:53.000000000 -0800
@@ -31,10 +31,47 @@ static spinlock_t htlbpage_lock = SPIN_L
 static struct htlbpagekey {
 	struct inode *in;
 	int key;
+	int busy;
 } htlbpagek[MAX_ID];
 
 struct hugetlb_key;
 
+static void mark_key_busy(struct hugetlb_key *hugetlb_key)
+{
+	struct inode *inode = (struct inode *)hugetlb_key;
+	int i, key = inode->i_ino;
+
+	for (i = 0; i < MAX_ID; ++i)
+		if (htlbpagek[i].key != key)
+			continue;
+	BUG_ON(i >= MAX_ID);
+	htlbpagek[i].busy = 1;
+}
+
+static void clear_key_busy(struct hugetlb_key *hugetlb_key)
+{
+	struct inode *inode = (struct inode *)hugetlb_key;
+	int i, key = inode->i_ino;
+
+	for (i = 0; i < MAX_ID; ++i)
+		if (htlbpagek[i].key != key)
+			continue;
+	BUG_ON(i >= MAX_ID);
+	htlbpagek[i].busy = 0;
+}
+
+static int key_busy(struct hugetlb_key *hugetlb_key)
+{
+	struct inode *inode = (struct inode *)hugetlb_key;
+	int i, key = inode->i_ino;
+
+	for (i = 0; i < MAX_ID; ++i)
+		if (htlbpagek[i].key != key)
+			continue;
+	BUG_ON(i >= MAX_ID);
+	return htlbpagek[i].busy;
+}
+
 static struct inode *find_key_inode(int key)
 {
 	int i;
@@ -76,7 +113,7 @@ struct hugetlb_key *alloc_key(int key, u
 						inode = ERR_PTR(-ENOMEM);
 					} else {
 						inode_init_once(inode);
-						atomic_inc(&inode->i_writecount);
+						mark_key_busy((struct hugetlb_key *)inode);
 						inode->i_mapping = &inode->i_data;
 						inode->i_mapping->host = inode;
 						inode->i_ino = (unsigned long)key;
@@ -90,7 +127,7 @@ struct hugetlb_key *alloc_key(int key, u
 					}
 				}
 			}
-		} else if (atomic_read(&inode->i_writecount)) {
+		} else if (key_busy((struct hugetlb_key *)inode)) {
 			inode = ERR_PTR(-EAGAIN);
 			spin_unlock(&htlbpage_lock);
 		} else if (check_size_prot(inode, len, prot, flag) < 0)
@@ -392,7 +429,7 @@ static int alloc_shared_hugetlb_pages(in
 	vma->vm_ops = &hugetlb_vm_ops;
 	spin_unlock(&mm->page_table_lock);
 	spin_lock(&htlbpage_lock);
-	atomic_set(&inode->i_writecount, 0);
+	clear_key_busy((struct hugetlb_key *)inode);
 	spin_unlock(&htlbpage_lock);
 	return retval;
 out:
