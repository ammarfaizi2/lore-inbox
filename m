Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266286AbSKLIZ4>; Tue, 12 Nov 2002 03:25:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261593AbSKLIZF>; Tue, 12 Nov 2002 03:25:05 -0500
Received: from holomorphy.com ([66.224.33.161]:42681 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S266298AbSKLIYf>;
	Tue, 12 Nov 2002 03:24:35 -0500
To: linux-kernel@vger.kernel.org
Subject: [10/11] hugetlb: use radix trees instead of inodes
Message-Id: <E18BWPm-0005KO-00@holomorphy>
From: William Lee Irwin III <wli@holomorphy.com>
Date: Tue, 12 Nov 2002 00:28:54 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch, substitutes direct usage of radix trees for inodes, and
removes the reviled custom-allocated inodes.

 hugetlbpage.c |   80 ++++++++++++++++++++++++----------------------------------
 1 files changed, 34 insertions(+), 46 deletions(-)


diff -urpN htlb-2.5.47-9/arch/i386/mm/hugetlbpage.c htlb-2.5.47-10/arch/i386/mm/hugetlbpage.c
--- htlb-2.5.47-9/arch/i386/mm/hugetlbpage.c	2002-11-11 22:42:23.000000000 -0800
+++ htlb-2.5.47-10/arch/i386/mm/hugetlbpage.c	2002-11-11 23:10:20.000000000 -0800
@@ -30,7 +30,7 @@ static spinlock_t htlbpage_lock = SPIN_L
 #define MAX_ID 	32
 
 struct hugetlb_key {
-	struct inode *in;
+	struct radix_tree_root tree;
 	int key;
 	int busy;
 	uid_t uid;
@@ -84,44 +84,28 @@ struct hugetlb_key *alloc_key(int key, u
 			else if (!(flag & IPC_CREAT))
 				hugetlb_key = ERR_PTR(-ENOENT);
 			else {
-				struct inode *inode;
-				inode = kmalloc(sizeof(struct inode), GFP_ATOMIC);
-				if (!inode)
-					inode = ERR_PTR(-ENOMEM);
-				else {
-					int i;
-					for (i = 0; i < MAX_ID; ++i)
-						if (!htlbpagek[i].key)
-							break;
-					if (i == MAX_ID) {
-						kfree(inode);
-						hugetlb_key = ERR_PTR(-ENOMEM);
-					} else {
-						hugetlb_key = &htlbpagek[i];
-						inode_init_once(inode);
-						mark_key_busy(hugetlb_key);
-						inode->i_mapping = &inode->i_data;
-						inode->i_mapping->host = inode;
-						inode->i_ino = (unsigned long)key;
-						hugetlb_key->key = key;
-						hugetlb_key->in = inode;
-						inode->i_uid = current->fsuid;
-						inode->i_gid = current->fsgid;
-						inode->i_mode = prot;
-						inode->i_size = len;
-						hugetlb_key->uid = current->fsuid;
-						hugetlb_key->gid = current->fsgid;
-						hugetlb_key->mode = prot;
-						hugetlb_key->size = len;
-						*new = 1;
-					}
+				int i;
+				for (i = 0; i < MAX_ID; ++i)
+					if (!htlbpagek[i].key)
+						break;
+				if (i == MAX_ID) {
+					hugetlb_key = ERR_PTR(-ENOMEM);
+				} else {
+					hugetlb_key = &htlbpagek[i];
+					mark_key_busy(hugetlb_key);
+					hugetlb_key->key = key;
+					INIT_RADIX_TREE(&hugetlb_key->tree, GFP_ATOMIC);
+					hugetlb_key->uid = current->fsuid;
+					hugetlb_key->gid = current->fsgid;
+					hugetlb_key->mode = prot;
+					hugetlb_key->size = len;
+					*new = 1;
 				}
 			}
 		} else if (key_busy(hugetlb_key)) {
 			hugetlb_key = ERR_PTR(-EAGAIN);
 			spin_unlock(&htlbpage_lock);
 		} else if (check_size_prot(hugetlb_key, len, prot, flag) < 0) {
-			kfree(hugetlb_key->in);
 			hugetlb_key->key = 0;
 			hugetlb_key = ERR_PTR(-EINVAL);
 		} else
@@ -132,18 +116,16 @@ struct hugetlb_key *alloc_key(int key, u
 
 static void release_key(struct hugetlb_key *key)
 {
-	int i;
-	struct inode *inode = (struct inode *)key;;
-
+	unsigned long index;
 	spin_lock(&htlbpage_lock);
-	for(i = 0;i < MAX_ID; ++i)
-		if (htlbpagek[i].key != inode->i_ino)
+	for (index = 0; index < key->size; ++index) {
+		struct page *page = radix_tree_lookup(&key->tree, index);
+		if (!page)
 			continue;
-
-	BUG_ON(i >= MAX_ID);
-	htlbpagek[i].key = 0;
-	htlbpagek[i].in = NULL;
-	kfree(inode);
+		huge_page_release(page);
+	}
+	key->key = 0;
+	INIT_RADIX_TREE(&key->tree, GFP_ATOMIC);
 	spin_unlock(&htlbpage_lock);
 }
 
@@ -381,12 +363,18 @@ static int check_size_prot(struct hugetl
 
 struct page *key_find_page(struct hugetlb_key *key, unsigned long index)
 {
-	return find_get_page(key->in->i_mapping, index);
+	struct page *page = radix_tree_lookup(&key->tree, index);
+	if (page)
+		get_page(page);
+	return page;
 }
 
-void key_add_page(struct page *page, struct hugetlb_key *key, unsigned long index)
+int key_add_page(struct page *page, struct hugetlb_key *key, unsigned long index)
 {
-	add_to_page_cache(page, key->in->i_mapping, index);
+	int error = radix_tree_insert(&key->tree, index, page);
+	if (!error)
+		get_page(page);
+	return error;
 }
 
 static int prefault_key(struct hugetlb_key *key, struct vm_area_struct *vma)
