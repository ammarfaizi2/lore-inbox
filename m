Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266295AbSKLIZz>; Tue, 12 Nov 2002 03:25:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266296AbSKLIY4>; Tue, 12 Nov 2002 03:24:56 -0500
Received: from holomorphy.com ([66.224.33.161]:40377 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S266286AbSKLIYe>;
	Tue, 12 Nov 2002 03:24:34 -0500
To: linux-kernel@vger.kernel.org
Subject: [2/11] hugetlb: wrap set_new_inode() with alloc_key()
Message-Id: <E18BWPl-0005K8-00@holomorphy>
From: William Lee Irwin III <wli@holomorphy.com>
Date: Tue, 12 Nov 2002 00:28:53 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A first step toward removing inodes from key management:

Put set_new_inode() and the inode allocation loop into an alloc_key(),
and introduce a new opaque type "struct hugetlb_key".

 hugetlbpage.c |  122 ++++++++++++++++++++++++++++++----------------------------
 1 files changed, 64 insertions(+), 58 deletions(-)


diff -urpN htlb-2.5.47-1/arch/i386/mm/hugetlbpage.c htlb-2.5.47-2/arch/i386/mm/hugetlbpage.c
--- htlb-2.5.47-1/arch/i386/mm/hugetlbpage.c	2002-11-11 19:44:26.000000000 -0800
+++ htlb-2.5.47-2/arch/i386/mm/hugetlbpage.c	2002-11-11 21:08:00.000000000 -0800
@@ -13,6 +13,7 @@
 #include <linux/smp_lock.h>
 #include <linux/slab.h>
 #include <linux/module.h>
+#include <linux/err.h>
 #include <asm/mman.h>
 #include <asm/pgalloc.h>
 #include <asm/tlb.h>
@@ -32,6 +33,8 @@ static struct htlbpagekey {
 	int key;
 } htlbpagek[MAX_ID];
 
+struct hugetlb_key;
+
 static struct inode *find_key_inode(int key)
 {
 	int i;
@@ -43,6 +46,61 @@ static struct inode *find_key_inode(int 
 	return NULL;
 }
 
+static int check_size_prot(struct inode *inode, unsigned long len, int prot, int flag);
+/*
+ * Call without htlbpage_lock, returns with htlbpage_lock held.
+ */
+struct hugetlb_key *alloc_key(int key, unsigned long len, int prot, int flag, int *new)
+{
+	struct inode *inode;
+
+	do {
+		spin_lock(&htlbpage_lock);
+		inode = find_key_inode(key);
+		if (!inode) {
+			if (!capable(CAP_SYS_ADMIN) || !in_group_p(0))
+				inode = ERR_PTR(-EPERM);
+			else if (!(flag & IPC_CREAT))
+				inode = ERR_PTR(-ENOENT);
+			else {
+				inode = kmalloc(sizeof(struct inode), GFP_ATOMIC);
+				if (!inode)
+					inode = ERR_PTR(-ENOMEM);
+				else {
+					int i;
+					for (i = 0; i < MAX_ID; ++i)
+						if (!htlbpagek[i].key)
+							break;
+					if (i == MAX_ID) {
+						kfree(inode);
+						inode = ERR_PTR(-ENOMEM);
+					} else {
+						inode_init_once(inode);
+						atomic_inc(&inode->i_writecount);
+						inode->i_mapping = &inode->i_data;
+						inode->i_mapping->host = inode;
+						inode->i_ino = (unsigned long)key;
+						htlbpagek[i].key = key;
+						htlbpagek[i].in = inode;
+						inode->i_uid = current->fsuid;
+						inode->i_gid = current->fsgid;
+						inode->i_mode = prot;
+						inode->i_size = len;
+						*new = 1;
+					}
+				}
+			}
+		} else if (atomic_read(&inode->i_writecount)) {
+			inode = ERR_PTR(-EAGAIN);
+			spin_unlock(&htlbpage_lock);
+		} else if (check_size_prot(inode, len, prot, flag) < 0)
+			inode = ERR_PTR(-EINVAL);
+		else
+			*new = 0;
+	} while (inode == ERR_PTR(-EAGAIN));
+	return (struct hugetlb_key *)inode;
+}
+
 static struct page *alloc_hugetlb_page(void)
 {
 	int i;
@@ -264,36 +322,6 @@ void zap_hugepage_range(struct vm_area_s
 	spin_unlock(&mm->page_table_lock);
 }
 
-static struct inode *set_new_inode(unsigned long len, int prot, int flag, int key)
-{
-	struct inode *inode;
-	int i;
-
-	for (i = 0; i < MAX_ID; i++) {
-		if (htlbpagek[i].key == 0)
-			break;
-	}
-	if (i == MAX_ID)
-		return NULL;
-	inode = kmalloc(sizeof (struct inode), GFP_ATOMIC);
-	if (inode == NULL)
-		return NULL;
-
-	inode_init_once(inode);
-	atomic_inc(&inode->i_writecount);
-	inode->i_mapping = &inode->i_data;
-	inode->i_mapping->host = inode;
-	inode->i_ino = (unsigned long)key;
-
-	htlbpagek[i].key = key;
-	htlbpagek[i].in = inode;
-	inode->i_uid = current->fsuid;
-	inode->i_gid = current->fsgid;
-	inode->i_mode = prot;
-	inode->i_size = len;
-	return inode;
-}
-
 static int check_size_prot(struct inode *inode, unsigned long len, int prot, int flag)
 {
 	if (inode->i_uid != current->fsuid)
@@ -315,36 +343,14 @@ static int alloc_shared_hugetlb_pages(in
 	int retval = -ENOMEM;
 	int newalloc = 0;
 
-try_again:
-	spin_lock(&htlbpage_lock);
+	inode = (struct inode *)alloc_key(key, len, prot, flag, &newalloc);
+	if (IS_ERR(inode)) {
+		retval = PTR_ERR(inode);
+		spin_unlock(&htlbpage_lock);
+		goto out_err;
+	} else
+		spin_unlock(&htlbpage_lock);
 
-	inode = find_key_inode(key);
-	if (inode == NULL) {
-		if (!capable(CAP_SYS_ADMIN)) {
-			if (!in_group_p(0)) {
-				retval = -EPERM;
-				goto out_err;
-			}
-		}
-		if (!(flag & IPC_CREAT)) {
-			retval = -ENOENT;
-			goto out_err;
-		}
-		inode = set_new_inode(len, prot, flag, key);
-		if (inode == NULL)
-			goto out_err;
-		newalloc = 1;
-	} else {
-		if (check_size_prot(inode, len, prot, flag) < 0) {
-			retval = -EINVAL;
-			goto out_err;
-		}
-		else if (atomic_read(&inode->i_writecount)) {
-			spin_unlock(&htlbpage_lock);
-			goto try_again;
-		}
-	}
-	spin_unlock(&htlbpage_lock);
 	mapping = inode->i_mapping;
 
 	addr = do_mmap_pgoff(NULL, addr, len, (unsigned long) prot,
