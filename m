Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318161AbSG2WCv>; Mon, 29 Jul 2002 18:02:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318164AbSG2WCv>; Mon, 29 Jul 2002 18:02:51 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:34288 "EHLO
	mtvmime01.veritas.com") by vger.kernel.org with ESMTP
	id <S318161AbSG2WCs>; Mon, 29 Jul 2002 18:02:48 -0400
Date: Mon, 29 Jul 2002 23:06:15 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Robert Love <rml@tech9.net>,
       Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org
Subject: [PATCH] vmacct2/9 SHMEM_MAX_BYTES overflow checking
In-Reply-To: <Pine.LNX.4.21.0207292257001.1184-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.21.0207292305070.1184-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

shmem_notify_change and shmem_file_write be careful about overflowingly
large loff_t before shifting it into unsigned long for vm_enough_memory.
Rename SHMEM_MAX_BLOCKS to SHMEM_MAX_INDEX (to avoid confusion with
512-byte blocks), define SHMEM_MAX_BYTES from it.

But 2.5 vmtruncate lacked the s_maxbytes error handling which
shmem_notify_change now expects: bring it in from the -dj tree.
shmem_file_write error handling needs a closer look later on.

--- vmacct1/mm/memory.c	Thu Jul 25 13:05:00 2002
+++ vmacct2/mm/memory.c	Mon Jul 29 19:23:46 2002
@@ -1096,23 +1096,20 @@
 
 do_expand:
 	limit = current->rlim[RLIMIT_FSIZE].rlim_cur;
-	if (limit != RLIM_INFINITY) {
-		if (inode->i_size >= limit) {
-			send_sig(SIGXFSZ, current, 0);
-			goto out;
-		}
-		if (offset > limit) {
-			send_sig(SIGXFSZ, current, 0);
-			offset = limit;
-		}
-	}
+	if (limit != RLIM_INFINITY && offset > limit)
+		goto out_sig;
+	if (offset > inode->i_sb->s_maxbytes)
+		goto out;
 	inode->i_size = offset;
 
 out_truncate:
 	if (inode->i_op && inode->i_op->truncate)
 		inode->i_op->truncate(inode);
-out:
 	return 0;
+out_sig:
+	send_sig(SIGXFSZ, current, 0);
+out:
+	return -EFBIG;
 }
 
 /* 
--- vmacct1/mm/shmem.c	Mon Jul 29 19:23:46 2002
+++ vmacct2/mm/shmem.c	Mon Jul 29 19:23:46 2002
@@ -37,6 +37,10 @@
 #define TMPFS_MAGIC	0x01021994
 
 #define ENTRIES_PER_PAGE (PAGE_CACHE_SIZE/sizeof(unsigned long))
+#define BLOCKS_PER_PAGE  (PAGE_CACHE_SIZE/512)
+
+#define SHMEM_MAX_INDEX  (SHMEM_NR_DIRECT + ENTRIES_PER_PAGE * (ENTRIES_PER_PAGE/2) * (ENTRIES_PER_PAGE+1))
+#define SHMEM_MAX_BYTES  ((unsigned long long)SHMEM_MAX_INDEX << PAGE_CACHE_SHIFT)
 
 #define VM_ACCT(size)    (((size) + PAGE_CACHE_SIZE - 1) >> PAGE_SHIFT)
 
@@ -58,8 +62,6 @@
 
 static struct page *shmem_getpage_locked(struct shmem_inode_info *, struct inode *, unsigned long);
 
-#define BLOCKS_PER_PAGE (PAGE_CACHE_SIZE/512)
-
 /*
  * shmem_recalc_inode - recalculate the size of an inode
  *
@@ -135,9 +137,6 @@
  * 	      	       +-> 48-51
  * 	      	       +-> 52-55
  */
-
-#define SHMEM_MAX_BLOCKS (SHMEM_NR_DIRECT + ENTRIES_PER_PAGE * ENTRIES_PER_PAGE/2*(ENTRIES_PER_PAGE+1))
-
 static swp_entry_t * shmem_swp_entry (struct shmem_inode_info *info, unsigned long index, unsigned long page) 
 {
 	unsigned long offset;
@@ -190,7 +189,7 @@
 	unsigned long page = 0;
 	swp_entry_t * res;
 
-	if (index >= SHMEM_MAX_BLOCKS)
+	if (index >= SHMEM_MAX_INDEX)
 		return ERR_PTR(-EFBIG);
 
 	if (info->next_index <= index)
@@ -365,14 +364,14 @@
 static int shmem_notify_change(struct dentry * dentry, struct iattr *attr)
 {
 	struct inode *inode = dentry->d_inode;
+	long change = 0;
 	int error;
 
-	if (attr->ia_valid & ATTR_SIZE) {
+	if ((attr->ia_valid & ATTR_SIZE) && (attr->ia_size <= SHMEM_MAX_BYTES)) {
 		/*
-	 	 * Account swap file usage based on new file size	
+	 	 * Account swap file usage based on new file size,
+		 * but just let vmtruncate fail on out-of-range sizes.
 	 	 */
-		long change;
-
 		change = VM_ACCT(attr->ia_size) - VM_ACCT(inode->i_size);
 		if (change > 0) {
 			if (!vm_enough_memory(change))
@@ -384,7 +383,8 @@
 	error = inode_change_ok(inode, attr);
 	if (!error)
 		error = inode_setattr(inode, attr);
-
+	if (error)
+		vm_unacct_memory(change);
 	return error;
 }
 
@@ -885,6 +885,8 @@
 	maxpos = inode->i_size;
 	if (pos + count > inode->i_size) {
 		maxpos = pos + count;
+		if (maxpos > SHMEM_MAX_BYTES)
+			maxpos = SHMEM_MAX_BYTES;
 		if (!vm_enough_memory(VM_ACCT(maxpos) - VM_ACCT(inode->i_size))) {
 			err = -ENOMEM;
 			goto out_nc;
@@ -1434,7 +1436,7 @@
 	sbinfo->free_blocks = blocks;
 	sbinfo->max_inodes = inodes;
 	sbinfo->free_inodes = inodes;
-	sb->s_maxbytes = (unsigned long long) SHMEM_MAX_BLOCKS << PAGE_CACHE_SHIFT;
+	sb->s_maxbytes = SHMEM_MAX_BYTES;
 	sb->s_blocksize = PAGE_CACHE_SIZE;
 	sb->s_blocksize_bits = PAGE_CACHE_SHIFT;
 	sb->s_magic = TMPFS_MAGIC;
@@ -1658,7 +1660,7 @@
 	struct dentry *dentry, *root;
 	struct qstr this;
 
-	if (size > (unsigned long long) SHMEM_MAX_BLOCKS << PAGE_CACHE_SHIFT)
+	if (size > SHMEM_MAX_BYTES)
 		return ERR_PTR(-EINVAL);
 
 	if (!vm_enough_memory(VM_ACCT(size)))

