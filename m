Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261695AbUKOUp3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261695AbUKOUp3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 15:45:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261698AbUKOUnr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 15:43:47 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:2031 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261695AbUKOUld (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 15:41:33 -0500
Date: Mon, 15 Nov 2004 20:41:12 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@osdl.org>
cc: Andrea Arcangeli <andrea@novell.com>, Andi Kleen <ak@suse.de>,
       Christoph Rohland <cr@sap.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] tmpfs symlink corrupts mempolicy
Message-ID: <Pine.LNX.4.44.0411152037340.4131-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea discovered that short symlinks on tmpfs, stored within the inode
itself, overwrote the NUMA mempolicy field which shmem_destroy_inode
expected to find there.  His fix was good, but Hugh changed it around a
little, to match existing shmem.c practice (now mpol_init in cases which
might allocate a page, mpol_free in shmem_truncate_inode), and allow for
possibility that mpol_init for a long symlink might one day do something
which really needs mpol_free.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

Thanks a lot for working that out, Andrea: is this version okay with you?
I've not studied the mempolicy.c part of the patch you posted, which
seemed to be an entirely separate (and less urgent) patch,
better reviewed by Andi.

--- 2.6.10-rc2/mm/shmem.c	2004-11-15 16:21:24.000000000 +0000
+++ linux/mm/shmem.c	2004-11-15 19:08:58.366829456 +0000
@@ -672,6 +672,7 @@ static void shmem_delete_inode(struct in
 		shmem_unacct_size(info->flags, inode->i_size);
 		inode->i_size = 0;
 		shmem_truncate(inode);
+		mpol_free_shared_policy(&info->policy);
 		if (!list_empty(&info->swaplist)) {
 			spin_lock(&shmem_swaplist_lock);
 			list_del_init(&info->swaplist);
@@ -1292,7 +1293,6 @@ shmem_get_inode(struct super_block *sb, 
 		info = SHMEM_I(inode);
 		memset(info, 0, (char *)inode - (char *)info);
 		spin_lock_init(&info->lock);
- 		mpol_shared_policy_init(&info->policy);
 		INIT_LIST_HEAD(&info->swaplist);
 
 		switch (mode & S_IFMT) {
@@ -1303,6 +1303,7 @@ shmem_get_inode(struct super_block *sb, 
 		case S_IFREG:
 			inode->i_op = &shmem_inode_operations;
 			inode->i_fop = &shmem_file_operations;
+ 			mpol_shared_policy_init(&info->policy);
 			break;
 		case S_IFDIR:
 			inode->i_nlink++;
@@ -1766,12 +1767,13 @@ static int shmem_symlink(struct inode *d
 		memcpy(info, symname, len);
 		inode->i_op = &shmem_symlink_inline_operations;
 	} else {
+		inode->i_op = &shmem_symlink_inode_operations;
+ 		mpol_shared_policy_init(&info->policy);
 		error = shmem_getpage(inode, 0, &page, SGP_WRITE, NULL);
 		if (error) {
 			iput(inode);
 			return error;
 		}
-		inode->i_op = &shmem_symlink_inode_operations;
 		kaddr = kmap_atomic(page, KM_USER0);
 		memcpy(kaddr, symname, len);
 		kunmap_atomic(kaddr, KM_USER0);
@@ -2026,7 +2028,6 @@ static struct inode *shmem_alloc_inode(s
 
 static void shmem_destroy_inode(struct inode *inode)
 {
-	mpol_free_shared_policy(&SHMEM_I(inode)->policy);
 	kmem_cache_free(shmem_inode_cachep, SHMEM_I(inode));
 }
 

