Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266310AbSKLIZw>; Tue, 12 Nov 2002 03:25:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266318AbSKLIYo>; Tue, 12 Nov 2002 03:24:44 -0500
Received: from holomorphy.com ([66.224.33.161]:41401 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S266295AbSKLIYe>;
	Tue, 12 Nov 2002 03:24:34 -0500
To: linux-kernel@vger.kernel.org
Subject: [7/11] hugetlb: substitute hugetlb_key for struct inode
Message-Id: <E18BWPl-0005KI-00@holomorphy>
From: William Lee Irwin III <wli@holomorphy.com>
Date: Tue, 12 Nov 2002 00:28:53 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This removes many direct usages of struct inode within the key
manipulation API in exchange for passing references to the key
structure itself.

 hugetlbpage.c |   78 ++++++++++++++++++++++------------------------------------
 1 files changed, 30 insertions(+), 48 deletions(-)


diff -urpN htlb-2.5.47-6/arch/i386/mm/hugetlbpage.c htlb-2.5.47-7/arch/i386/mm/hugetlbpage.c
--- htlb-2.5.47-6/arch/i386/mm/hugetlbpage.c	2002-11-11 21:55:12.000000000 -0800
+++ htlb-2.5.47-7/arch/i386/mm/hugetlbpage.c	2002-11-11 22:21:49.000000000 -0800
@@ -28,57 +28,37 @@ static LIST_HEAD(htlbpage_freelist);
 static spinlock_t htlbpage_lock = SPIN_LOCK_UNLOCKED;
 
 #define MAX_ID 	32
-static struct htlbpagekey {
+
+struct hugetlb_key {
 	struct inode *in;
 	int key;
 	int busy;
-} htlbpagek[MAX_ID];
+};
 
-struct hugetlb_key;
+static struct hugetlb_key htlbpagek[MAX_ID];
 
 static void mark_key_busy(struct hugetlb_key *hugetlb_key)
 {
-	struct inode *inode = (struct inode *)hugetlb_key;
-	int i, key = inode->i_ino;
-
-	for (i = 0; i < MAX_ID; ++i)
-		if (htlbpagek[i].key != key)
-			continue;
-	BUG_ON(i >= MAX_ID);
-	htlbpagek[i].busy = 1;
+	hugetlb_key->busy = 1;
 }
 
 static void clear_key_busy(struct hugetlb_key *hugetlb_key)
 {
-	struct inode *inode = (struct inode *)hugetlb_key;
-	int i, key = inode->i_ino;
-
-	for (i = 0; i < MAX_ID; ++i)
-		if (htlbpagek[i].key != key)
-			continue;
-	BUG_ON(i >= MAX_ID);
-	htlbpagek[i].busy = 0;
+	hugetlb_key->busy = 0;
 }
 
 static int key_busy(struct hugetlb_key *hugetlb_key)
 {
-	struct inode *inode = (struct inode *)hugetlb_key;
-	int i, key = inode->i_ino;
-
-	for (i = 0; i < MAX_ID; ++i)
-		if (htlbpagek[i].key != key)
-			continue;
-	BUG_ON(i >= MAX_ID);
-	return htlbpagek[i].busy;
+	return hugetlb_key->busy;
 }
 
-static struct inode *find_key_inode(int key)
+static struct hugetlb_key *find_key(int key)
 {
 	int i;
 
 	for (i = 0; i < MAX_ID; i++) {
 		if (htlbpagek[i].key == key)
-			return (htlbpagek[i].in);
+			return &htlbpagek[i];
 	}
 	return NULL;
 }
@@ -89,17 +69,18 @@ static int check_size_prot(struct inode 
  */
 struct hugetlb_key *alloc_key(int key, unsigned long len, int prot, int flag, int *new)
 {
-	struct inode *inode;
+	struct hugetlb_key *hugetlb_key;
 
 	do {
 		spin_lock(&htlbpage_lock);
-		inode = find_key_inode(key);
-		if (!inode) {
+		hugetlb_key = find_key(key);
+		if (!hugetlb_key) {
 			if (!capable(CAP_SYS_ADMIN) || !in_group_p(0))
-				inode = ERR_PTR(-EPERM);
+				hugetlb_key = ERR_PTR(-EPERM);
 			else if (!(flag & IPC_CREAT))
-				inode = ERR_PTR(-ENOENT);
+				hugetlb_key = ERR_PTR(-ENOENT);
 			else {
+				struct inode *inode;
 				inode = kmalloc(sizeof(struct inode), GFP_ATOMIC);
 				if (!inode)
 					inode = ERR_PTR(-ENOMEM);
@@ -110,15 +91,16 @@ struct hugetlb_key *alloc_key(int key, u
 							break;
 					if (i == MAX_ID) {
 						kfree(inode);
-						inode = ERR_PTR(-ENOMEM);
+						hugetlb_key = ERR_PTR(-ENOMEM);
 					} else {
+						hugetlb_key = &htlbpagek[i];
 						inode_init_once(inode);
-						mark_key_busy((struct hugetlb_key *)inode);
+						mark_key_busy(hugetlb_key);
 						inode->i_mapping = &inode->i_data;
 						inode->i_mapping->host = inode;
 						inode->i_ino = (unsigned long)key;
-						htlbpagek[i].key = key;
-						htlbpagek[i].in = inode;
+						hugetlb_key->key = key;
+						hugetlb_key->in = inode;
 						inode->i_uid = current->fsuid;
 						inode->i_gid = current->fsgid;
 						inode->i_mode = prot;
@@ -127,15 +109,17 @@ struct hugetlb_key *alloc_key(int key, u
 					}
 				}
 			}
-		} else if (key_busy((struct hugetlb_key *)inode)) {
-			inode = ERR_PTR(-EAGAIN);
+		} else if (key_busy(hugetlb_key)) {
+			hugetlb_key = ERR_PTR(-EAGAIN);
 			spin_unlock(&htlbpage_lock);
-		} else if (check_size_prot(inode, len, prot, flag) < 0)
-			inode = ERR_PTR(-EINVAL);
-		else
+		} else if (check_size_prot(hugetlb_key->in, len, prot, flag) < 0) {
+			kfree(hugetlb_key->in);
+			hugetlb_key->key = 0;
+			hugetlb_key = ERR_PTR(-EINVAL);
+		} else
 			*new = 0;
-	} while (inode == ERR_PTR(-EAGAIN));
-	return (struct hugetlb_key *)inode;
+	} while (hugetlb_key == ERR_PTR(-EAGAIN));
+	return hugetlb_key;
 }
 
 static void release_key(struct hugetlb_key *key)
@@ -389,9 +373,7 @@ static int check_size_prot(struct inode 
 
 static int prefault_key(struct hugetlb_key *key, struct vm_area_struct *vma)
 {
-	struct inode *inode = (struct inode *)key;
-
-	return hugetlb_prefault(inode->i_mapping, vma);
+	return hugetlb_prefault(key->in->i_mapping, vma);
 }
 
 static int alloc_shared_hugetlb_pages(int key, unsigned long addr, unsigned long len, int prot, int flag)
