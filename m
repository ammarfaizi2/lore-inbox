Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266296AbSKLIZz>; Tue, 12 Nov 2002 03:25:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266286AbSKLIY7>; Tue, 12 Nov 2002 03:24:59 -0500
Received: from holomorphy.com ([66.224.33.161]:42169 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S266297AbSKLIYe>;
	Tue, 12 Nov 2002 03:24:34 -0500
To: linux-kernel@vger.kernel.org
Subject: [9/11] hugetlb: move inode attributes into hugetlb_key
Message-Id: <E18BWPl-0005KM-00@holomorphy>
From: William Lee Irwin III <wli@holomorphy.com>
Date: Tue, 12 Nov 2002 00:28:53 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch moves uid/gid/mode/size fields used in struct inode and the
checks on them into key management code and structures.

 hugetlbpage.c |   20 ++++++++++++++------
 1 files changed, 14 insertions(+), 6 deletions(-)


diff -urpN htlb-2.5.47-8/arch/i386/mm/hugetlbpage.c htlb-2.5.47-9/arch/i386/mm/hugetlbpage.c
--- htlb-2.5.47-8/arch/i386/mm/hugetlbpage.c	2002-11-11 22:32:00.000000000 -0800
+++ htlb-2.5.47-9/arch/i386/mm/hugetlbpage.c	2002-11-11 22:42:23.000000000 -0800
@@ -33,6 +33,10 @@ struct hugetlb_key {
 	struct inode *in;
 	int key;
 	int busy;
+	uid_t uid;
+	gid_t gid;
+	umode_t mode;
+	loff_t size;
 };
 
 static struct hugetlb_key htlbpagek[MAX_ID];
@@ -63,7 +67,7 @@ static struct hugetlb_key *find_key(int 
 	return NULL;
 }
 
-static int check_size_prot(struct inode *inode, unsigned long len, int prot, int flag);
+static int check_size_prot(struct hugetlb_key *key, unsigned long len, int prot, int flag);
 /*
  * Call without htlbpage_lock, returns with htlbpage_lock held.
  */
@@ -105,6 +109,10 @@ struct hugetlb_key *alloc_key(int key, u
 						inode->i_gid = current->fsgid;
 						inode->i_mode = prot;
 						inode->i_size = len;
+						hugetlb_key->uid = current->fsuid;
+						hugetlb_key->gid = current->fsgid;
+						hugetlb_key->mode = prot;
+						hugetlb_key->size = len;
 						*new = 1;
 					}
 				}
@@ -112,7 +120,7 @@ struct hugetlb_key *alloc_key(int key, u
 		} else if (key_busy(hugetlb_key)) {
 			hugetlb_key = ERR_PTR(-EAGAIN);
 			spin_unlock(&htlbpage_lock);
-		} else if (check_size_prot(hugetlb_key->in, len, prot, flag) < 0) {
+		} else if (check_size_prot(hugetlb_key, len, prot, flag) < 0) {
 			kfree(hugetlb_key->in);
 			hugetlb_key->key = 0;
 			hugetlb_key = ERR_PTR(-EINVAL);
@@ -360,13 +368,13 @@ void zap_hugepage_range(struct vm_area_s
 	spin_unlock(&mm->page_table_lock);
 }
 
-static int check_size_prot(struct inode *inode, unsigned long len, int prot, int flag)
+static int check_size_prot(struct hugetlb_key *key, unsigned long len, int prot, int flag)
 {
-	if (inode->i_uid != current->fsuid)
+	if (key->uid != current->fsuid)
 		return -1;
-	if (inode->i_gid != current->fsgid)
+	if (key->gid != current->fsgid)
 		return -1;
-	if (inode->i_size != len)
+	if (key->size != len)
 		return -1;
 	return 0;
 }
