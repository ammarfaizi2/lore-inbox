Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318156AbSG2WBe>; Mon, 29 Jul 2002 18:01:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318159AbSG2WBd>; Mon, 29 Jul 2002 18:01:33 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:63713 "EHLO
	mtvmime03.VERITAS.COM") by vger.kernel.org with ESMTP
	id <S318156AbSG2WBb>; Mon, 29 Jul 2002 18:01:31 -0400
Date: Mon, 29 Jul 2002 23:04:58 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Robert Love <rml@tech9.net>,
       Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org
Subject: [PATCH] vmacct1/9 shmem_file_write rounding VM_ACCT
In-Reply-To: <Pine.LNX.4.21.0207292257001.1184-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.21.0207292303470.1184-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Repeated overnight kernel builds in tmpfs showed insane Committed_AS
by morning.  The main bug was that shmem_file_write was passing
(newsize-oldsize)>>PAGE_SHIFT to vm_enough_memory, but it has to be
((newsize>>PAGE_SHIFT)-(oldsize>>PAGE_SHIFT)) - imagine 1k writes.

But actually, if we're going to do strict accounting, then we should
round up to next page not down - use VM_ACCT macro throughout (needs
unusual mix of PAGE_CACHE_SIZE with PAGE_SHIFT); and must count one
page for a long symlink.

--- 2.5.29-1.523/mm/shmem.c	Mon Jul 29 11:48:04 2002
+++ vmacct1/mm/shmem.c	Mon Jul 29 19:23:46 2002
@@ -38,6 +38,8 @@
 
 #define ENTRIES_PER_PAGE (PAGE_CACHE_SIZE/sizeof(unsigned long))
 
+#define VM_ACCT(size)    (((size) + PAGE_CACHE_SIZE - 1) >> PAGE_SHIFT)
+
 static inline struct shmem_sb_info *SHMEM_SB(struct super_block *sb)
 {
 	return sb->u.generic_sbp;
@@ -371,10 +373,8 @@
 	 	 */
 		long change;
 
-		change = ((attr->ia_size + PAGE_SIZE - 1) >> PAGE_SHIFT) -
-			((inode->i_size + PAGE_SIZE - 1 ) >> PAGE_SHIFT);
-
-		if (attr->ia_size > inode->i_size) {
+		change = VM_ACCT(attr->ia_size) - VM_ACCT(inode->i_size);
+		if (change > 0) {
 			if (!vm_enough_memory(change))
 				return -ENOMEM;
 		} else
@@ -393,13 +393,12 @@
 {
 	struct shmem_sb_info *sbinfo = SHMEM_SB(inode->i_sb);
 
-	vm_unacct_memory((inode->i_size) >> PAGE_SHIFT);
-
-	inode->i_size = 0;
-	if (inode->i_op->truncate == shmem_truncate){ 
+	if (inode->i_op->truncate == shmem_truncate) {
 		spin_lock (&shmem_ilock);
 		list_del (&SHMEM_I(inode)->list);
 		spin_unlock (&shmem_ilock);
+		vm_unacct_memory(VM_ACCT(inode->i_size));
+		inode->i_size = 0;
 		shmem_truncate (inode);
 	}
 	spin_lock (&sbinfo->stat_lock);
@@ -886,7 +885,7 @@
 	maxpos = inode->i_size;
 	if (pos + count > inode->i_size) {
 		maxpos = pos + count;
-		if (!vm_enough_memory((maxpos - inode->i_size) >> PAGE_SHIFT)) {
+		if (!vm_enough_memory(VM_ACCT(maxpos) - VM_ACCT(inode->i_size))) {
 			err = -ENOMEM;
 			goto out_nc;
 		}
@@ -983,7 +982,7 @@
 out:
 	/* Short writes give back address space */
 	if (inode->i_size != maxpos)
-		vm_unacct_memory((maxpos - inode->i_size) >> PAGE_SHIFT);
+		vm_unacct_memory(VM_ACCT(maxpos) - VM_ACCT(inode->i_size));
 out_nc:
 	up(&inode->i_sem);
 	return err;
@@ -1238,10 +1237,15 @@
 		memcpy(info, symname, len);
 		inode->i_op = &shmem_symlink_inline_operations;
 	} else {
+		if (!vm_enough_memory(VM_ACCT(1))) {
+			iput(inode);
+			return -ENOMEM;
+		}
 		down(&info->sem);
 		page = shmem_getpage_locked(info, inode, 0);
 		if (IS_ERR(page)) {
 			up(&info->sem);
+			vm_unacct_memory(VM_ACCT(1));
 			iput(inode);
 			return PTR_ERR(page);
 		}
@@ -1648,7 +1652,7 @@
  */
 struct file *shmem_file_setup(char * name, loff_t size)
 {
-	int error = -ENOMEM;
+	int error;
 	struct file *file;
 	struct inode * inode;
 	struct dentry *dentry, *root;
@@ -1657,9 +1661,10 @@
 	if (size > (unsigned long long) SHMEM_MAX_BLOCKS << PAGE_CACHE_SHIFT)
 		return ERR_PTR(-EINVAL);
 
-	if (!vm_enough_memory((size) >> PAGE_CACHE_SHIFT))
+	if (!vm_enough_memory(VM_ACCT(size)))
 		return ERR_PTR(-ENOMEM);
 
+	error = -ENOMEM;
 	this.name = name;
 	this.len = strlen(name);
 	this.hash = 0; /* will go */
@@ -1693,9 +1698,10 @@
 put_dentry:
 	dput (dentry);
 put_memory:
-	vm_unacct_memory((size) >> PAGE_CACHE_SHIFT);
+	vm_unacct_memory(VM_ACCT(size));
 	return ERR_PTR(error);	
 }
+
 /*
  * shmem_zero_setup - setup a shared anonymous mapping
  *

