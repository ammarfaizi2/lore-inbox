Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318008AbSIOJhn>; Sun, 15 Sep 2002 05:37:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318013AbSIOJhm>; Sun, 15 Sep 2002 05:37:42 -0400
Received: from [143.127.3.97] ([143.127.3.97]:3342 "EHLO mtvmime03.VERITAS.COM")
	by vger.kernel.org with ESMTP id <S318008AbSIOJhk>;
	Sun, 15 Sep 2002 05:37:40 -0400
Date: Sun, 15 Sep 2002 10:43:15 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: Christoph Rohland <cr@sap.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] tmpfs 5/5 closer to 2.5/ac
In-Reply-To: <Pine.LNX.4.44.0209151033190.10490-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0209151041480.10490-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

No functional change, but reduce source divergence with a few
definitions and line movements from the 2.5 and -ac trees,
and cutting out a pointless call to shmem_truncate as in 2.5.

--- tmpfs4/mm/shmem.c	Sat Sep 14 18:21:23 2002
+++ tmpfs5/mm/shmem.c	Sat Sep 14 18:21:23 2002
@@ -34,6 +34,11 @@
 #define TMPFS_MAGIC	0x01021994
 
 #define ENTRIES_PER_PAGE (PAGE_CACHE_SIZE/sizeof(unsigned long))
+#define BLOCKS_PER_PAGE  (PAGE_CACHE_SIZE/512)
+
+#define SHMEM_MAX_INDEX  (SHMEM_NR_DIRECT + ENTRIES_PER_PAGE * (ENTRIES_PER_PAGE/2) * (ENTRIES_PER_PAGE+1))
+#define SHMEM_MAX_BYTES  ((unsigned long long)SHMEM_MAX_INDEX << PAGE_CACHE_SHIFT)
+#define VM_ACCT(size)    (((size) + PAGE_CACHE_SIZE - 1) >> PAGE_SHIFT)
 
 /* Pretend that each entry is of this size in directory's i_size */
 #define BOGO_DIRENT_SIZE 20
@@ -53,8 +58,6 @@
 
 static struct page *shmem_getpage_locked(struct shmem_inode_info *, struct inode *, unsigned long);
 
-#define BLOCKS_PER_PAGE (PAGE_CACHE_SIZE/512)
-
 /*
  * shmem_recalc_inode - recalculate the size of an inode
  *
@@ -130,9 +133,6 @@
  * 	      	       +-> 48-51
  * 	      	       +-> 52-55
  */
-
-#define SHMEM_MAX_BLOCKS (SHMEM_NR_DIRECT + ENTRIES_PER_PAGE * ENTRIES_PER_PAGE/2*(ENTRIES_PER_PAGE+1))
-
 static swp_entry_t * shmem_swp_entry (struct shmem_inode_info *info, unsigned long index, unsigned long page) 
 {
 	unsigned long offset;
@@ -185,7 +185,7 @@
 	unsigned long page = 0;
 	swp_entry_t * res;
 
-	if (index >= SHMEM_MAX_BLOCKS)
+	if (index >= SHMEM_MAX_INDEX)
 		return ERR_PTR(-EFBIG);
 
 	if (info->next_index <= index)
@@ -361,11 +361,11 @@
 {
 	struct shmem_sb_info *sbinfo = SHMEM_SB(inode->i_sb);
 
-	inode->i_size = 0;
-	if (inode->i_op->truncate == shmem_truncate){ 
+	if (inode->i_op->truncate == shmem_truncate) {
 		spin_lock (&shmem_ilock);
 		list_del (&SHMEM_I(inode)->list);
 		spin_unlock (&shmem_ilock);
+		inode->i_size = 0;
 		shmem_truncate (inode);
 	}
 	spin_lock (&sbinfo->stat_lock);
@@ -1360,7 +1360,7 @@
 	sbinfo->free_blocks = blocks;
 	sbinfo->max_inodes = inodes;
 	sbinfo->free_inodes = inodes;
-	sb->s_maxbytes = (unsigned long long) SHMEM_MAX_BLOCKS << PAGE_CACHE_SHIFT;
+	sb->s_maxbytes = SHMEM_MAX_BYTES;
 	sb->s_blocksize = PAGE_CACHE_SIZE;
 	sb->s_blocksize_bits = PAGE_CACHE_SHIFT;
 	sb->s_magic = TMPFS_MAGIC;
@@ -1494,10 +1494,10 @@
 	struct qstr this;
 	int vm_enough_memory(long pages);
 
-	if (size > (unsigned long long) SHMEM_MAX_BLOCKS << PAGE_CACHE_SHIFT)
+	if (size > SHMEM_MAX_BYTES)
 		return ERR_PTR(-EINVAL);
 
-	if (!vm_enough_memory((size) >> PAGE_CACHE_SHIFT))
+	if (!vm_enough_memory(VM_ACCT(size)))
 		return ERR_PTR(-ENOMEM);
 
 	this.name = name;
@@ -1519,13 +1519,12 @@
 		goto close_file;
 
 	d_instantiate(dentry, inode);
-	dentry->d_inode->i_size = size;
-	shmem_truncate(inode);
+	inode->i_size = size;
+	inode->i_nlink = 0;	/* It is unlinked */
 	file->f_vfsmnt = mntget(shm_mnt);
 	file->f_dentry = dentry;
 	file->f_op = &shmem_file_operations;
 	file->f_mode = FMODE_WRITE | FMODE_READ;
-	inode->i_nlink = 0;	/* It is unlinked */
 	return(file);
 
 close_file:
@@ -1534,6 +1533,7 @@
 	dput (dentry);
 	return ERR_PTR(error);	
 }
+
 /*
  * shmem_zero_setup - setup a shared anonymous mapping
  *

