Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267310AbUIEWiE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267310AbUIEWiE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 18:38:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267330AbUIEWhz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 18:37:55 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:65401 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S267319AbUIEWgm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 18:36:42 -0400
Date: Sun, 5 Sep 2004 23:36:30 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@osdl.org>
cc: Brent Casavant <bcasavan@sgi.com>, Christoph Rohland <cr@sap.com>,
       <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/7] shmem: don't SLAB_HWCACHE_ALIGN
Message-ID: <Pine.LNX.4.44.0409052331240.3218-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton recently removed SLAB_HWCACHE_ALIGN from the fs inode caches, now
do the same for tmpfs inode cache: fits 9 per page where 7 before.

Was saying SLAB_RECLAIM_ACCOUNT too, but that's wrong: tmpfs inodes are
not reclaimed under pressure; and hugetlbfs had copied that too.

Rearrange shmem_inode_info fields so those most likely to be needed are
most likely to be in the same cacheline as the spinlock guarding them.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

 fs/hugetlbfs/inode.c     |    3 +--
 include/linux/shmem_fs.h |   14 +++++++-------
 mm/shmem.c               |    3 +--
 3 files changed, 9 insertions(+), 11 deletions(-)

--- 2.6.9-rc1-bk12/fs/hugetlbfs/inode.c	2004-09-05 12:58:34.000000000 +0100
+++ shmem1/fs/hugetlbfs/inode.c	2004-09-05 17:05:45.865559696 +0100
@@ -800,8 +800,7 @@ static int __init init_hugetlbfs_fs(void
 
 	hugetlbfs_inode_cachep = kmem_cache_create("hugetlbfs_inode_cache",
 					sizeof(struct hugetlbfs_inode_info),
-					0, SLAB_RECLAIM_ACCOUNT,
-					init_once, NULL);
+					0, 0, init_once, NULL);
 	if (hugetlbfs_inode_cachep == NULL)
 		return -ENOMEM;
 
--- 2.6.9-rc1-bk12/include/linux/shmem_fs.h	2004-06-16 06:20:44.000000000 +0100
+++ shmem1/include/linux/shmem_fs.h	2004-09-05 17:05:45.867559392 +0100
@@ -10,14 +10,14 @@
 
 struct shmem_inode_info {
 	spinlock_t		lock;
-	unsigned long		next_index;
-	swp_entry_t		i_direct[SHMEM_NR_DIRECT]; /* for the first blocks */
-	struct page	       *i_indirect; /* indirect blocks */
-	unsigned long		alloced;    /* data pages allocated to file */
-	unsigned long		swapped;    /* subtotal assigned to swap */
 	unsigned long		flags;
-	struct shared_policy     policy;
-	struct list_head	list;
+	unsigned long		alloced;	/* data pages alloced to file */
+	unsigned long		swapped;	/* subtotal assigned to swap */
+	unsigned long		next_index;	/* highest alloced index + 1 */
+	struct shared_policy	policy;		/* NUMA memory alloc policy */
+	struct page		*i_indirect;	/* top indirect blocks page */
+	swp_entry_t		i_direct[SHMEM_NR_DIRECT]; /* first blocks */
+	struct list_head	list;		/* chain of all shmem inodes */
 	struct inode		vfs_inode;
 };
 
--- 2.6.9-rc1-bk12/mm/shmem.c	2004-09-05 12:58:41.000000000 +0100
+++ shmem1/mm/shmem.c	2004-09-05 17:05:45.869559088 +0100
@@ -1897,8 +1897,7 @@ static int init_inodecache(void)
 {
 	shmem_inode_cachep = kmem_cache_create("shmem_inode_cache",
 				sizeof(struct shmem_inode_info),
-				0, SLAB_HWCACHE_ALIGN|SLAB_RECLAIM_ACCOUNT,
-				init_once, NULL);
+				0, 0, init_once, NULL);
 	if (shmem_inode_cachep == NULL)
 		return -ENOMEM;
 	return 0;

