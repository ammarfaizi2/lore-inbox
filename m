Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261605AbUC3Xb6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 18:31:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261671AbUC3Xb6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 18:31:58 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:18172 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261605AbUC3XbU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 18:31:20 -0500
Date: Wed, 31 Mar 2004 00:31:12 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@osdl.org>
cc: "Kevin P. Fleming" <kpfleming@backtobasicsmgmt.com>,
       Christoph Rohland <cr@sap.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] huge sparse tmpfs files
Message-ID: <Pine.LNX.4.44.0403310027360.24104-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kevin P. Fleming pointed out (sorry, two months ago) that the 2.6
tmpfs does not allow writing huge sparse files.  This is an unintended
side-effect of the strict memory commit changes: which should make no
difference unless strict commit is chosen, but in fact had this effect.

The solution is to treat the tmpfs files (of variable size) and the
shmem objects (of fixed size) differently: sounds nasty but works
out well.  The shmem objects follow the VM preallocation convention
as before, but the tmpfs files revert to allocation on demand as a
filesystem would.  If there's not enough memory to write to a tmpfs
hole, it is reported as -ENOSPC rather than -ENOMEM, so the mmap
writer gets SIGBUS rather than everyone else getting OOM-killed.

--- 2.6.5-rc3/mm/shmem.c	2004-03-30 13:04:19.470542056 +0100
+++ linux/mm/shmem.c	2004-03-30 14:39:14.432776200 +0100
@@ -123,6 +123,42 @@ static inline struct shmem_sb_info *SHME
 	return sb->s_fs_info;
 }
 
+/*
+ * shmem_file_setup pre-accounts the whole fixed size of a VM object,
+ * for shared memory and for shared anonymous (/dev/zero) mappings
+ * (unless MAP_NORESERVE and sysctl_overcommit_memory <= 1),
+ * consistent with the pre-accounting of private mappings ...
+ */
+static inline int shmem_acct_size(unsigned long flags, loff_t size)
+{
+	return (flags & VM_ACCOUNT)?
+		security_vm_enough_memory(VM_ACCT(size)): 0;
+}
+
+static inline void shmem_unacct_size(unsigned long flags, loff_t size)
+{
+	if (flags & VM_ACCOUNT)
+		vm_unacct_memory(VM_ACCT(size));
+}
+
+/*
+ * ... whereas tmpfs objects are accounted incrementally as
+ * pages are allocated, in order to allow huge sparse files.
+ * shmem_getpage reports shmem_acct_block failure as -ENOSPC not -ENOMEM,
+ * so that a failure on a sparse tmpfs mapping will give SIGBUS not OOM.
+ */
+static inline int shmem_acct_block(unsigned long flags)
+{
+	return (flags & VM_ACCOUNT)?
+		0: security_vm_enough_memory(VM_ACCT(PAGE_CACHE_SIZE));
+}
+
+static inline void shmem_unacct_blocks(unsigned long flags, long pages)
+{
+	if (!(flags & VM_ACCOUNT))
+		vm_unacct_memory(pages * VM_ACCT(PAGE_CACHE_SIZE));
+}
+
 static struct super_operations shmem_ops;
 static struct address_space_operations shmem_aops;
 static struct file_operations shmem_file_operations;
@@ -173,6 +209,7 @@ static void shmem_recalc_inode(struct in
 		sbinfo->free_blocks += freed;
 		inode->i_blocks -= freed*BLOCKS_PER_PAGE;
 		spin_unlock(&sbinfo->stat_lock);
+		shmem_unacct_blocks(info->flags, freed);
 	}
 }
 
@@ -456,7 +493,7 @@ static void shmem_truncate(struct inode 
 			shmem_dir_unmap(dir);
 			if (empty) {
 				shmem_dir_free(empty);
-				info->alloced++;
+				shmem_free_block(inode);
 			}
 			empty = subdir;
 			cond_resched_lock(&info->lock);
@@ -479,19 +516,19 @@ static void shmem_truncate(struct inode 
 		else if (subdir) {
 			*dir = NULL;
 			shmem_dir_free(subdir);
-			info->alloced++;
+			shmem_free_block(inode);
 		}
 	}
 done1:
 	shmem_dir_unmap(dir-1);
 	if (empty) {
 		shmem_dir_free(empty);
-		info->alloced++;
+		shmem_free_block(inode);
 	}
 	if (info->next_index <= SHMEM_NR_DIRECT) {
 		shmem_dir_free(info->i_indirect);
 		info->i_indirect = NULL;
-		info->alloced++;
+		shmem_free_block(inode);
 	}
 done2:
 	BUG_ON(info->swapped > info->next_index);
@@ -516,20 +553,10 @@ static int shmem_notify_change(struct de
 {
 	struct inode *inode = dentry->d_inode;
 	struct page *page = NULL;
-	long change = 0;
 	int error;
 
-	if ((attr->ia_valid & ATTR_SIZE) && (attr->ia_size <= SHMEM_MAX_BYTES)) {
-		/*
-	 	 * Account swap file usage based on new file size,
-		 * but just let vmtruncate fail on out-of-range sizes.
-	 	 */
-		change = VM_ACCT(attr->ia_size) - VM_ACCT(inode->i_size);
-		if (change > 0) {
-			if (security_vm_enough_memory(change))
-				return -ENOMEM;
-		} else if (attr->ia_size < inode->i_size) {
-			vm_unacct_memory(-change);
+	if (attr->ia_valid & ATTR_SIZE) {
+		if (attr->ia_size < inode->i_size) {
 			/*
 			 * If truncating down to a partial page, then
 			 * if that page is already allocated, hold it
@@ -563,8 +590,6 @@ static int shmem_notify_change(struct de
 		error = inode_setattr(inode, attr);
 	if (page)
 		page_cache_release(page);
-	if (error)
-		vm_unacct_memory(change);
 	return error;
 }
 
@@ -577,8 +602,7 @@ static void shmem_delete_inode(struct in
 		spin_lock(&shmem_ilock);
 		list_del(&info->list);
 		spin_unlock(&shmem_ilock);
-		if (info->flags & VM_ACCOUNT)
-			vm_unacct_memory(VM_ACCT(inode->i_size));
+		shmem_unacct_size(info->flags, inode->i_size);
 		inode->i_size = 0;
 		shmem_truncate(inode);
 	}
@@ -909,7 +933,7 @@ repeat:
 		shmem_swp_unmap(entry);
 		sbinfo = SHMEM_SB(inode->i_sb);
 		spin_lock(&sbinfo->stat_lock);
-		if (sbinfo->free_blocks == 0) {
+		if (sbinfo->free_blocks == 0 || shmem_acct_block(info->flags)) {
 			spin_unlock(&sbinfo->stat_lock);
 			spin_unlock(&info->lock);
 			error = -ENOSPC;
@@ -923,6 +947,7 @@ repeat:
 			spin_unlock(&info->lock);
 			filepage = page_cache_alloc(mapping);
 			if (!filepage) {
+				shmem_unacct_blocks(info->flags, 1);
 				shmem_free_block(inode);
 				error = -ENOMEM;
 				goto failed;
@@ -940,6 +965,7 @@ repeat:
 					filepage, mapping, idx, GFP_ATOMIC)) {
 				spin_unlock(&info->lock);
 				page_cache_release(filepage);
+				shmem_unacct_blocks(info->flags, 1);
 				shmem_free_block(inode);
 				filepage = NULL;
 				if (error)
@@ -1094,7 +1120,6 @@ shmem_get_inode(struct super_block *sb, 
 		info = SHMEM_I(inode);
 		memset(info, 0, (char *)inode - (char *)info);
 		spin_lock_init(&info->lock);
-		info->flags = VM_ACCOUNT;
 		switch (mode & S_IFMT) {
 		default:
 			init_special_inode(inode, mode, dev);
@@ -1167,7 +1192,6 @@ shmem_file_write(struct file *file, cons
 	loff_t		pos;
 	unsigned long	written;
 	int		err;
-	loff_t		maxpos;
 
 	if ((ssize_t) count < 0)
 		return -EINVAL;
@@ -1184,15 +1208,6 @@ shmem_file_write(struct file *file, cons
 	if (err || !count)
 		goto out;
 
-	maxpos = inode->i_size;
-	if (maxpos < pos + count) {
-		maxpos = pos + count;
-		if (security_vm_enough_memory(VM_ACCT(maxpos) - VM_ACCT(inode->i_size))) {
-			err = -ENOMEM;
-			goto out;
-		}
-	}
-
 	err = remove_suid(file->f_dentry);
 	if (err)
 		goto out;
@@ -1267,10 +1282,6 @@ shmem_file_write(struct file *file, cons
 	*ppos = pos;
 	if (written)
 		err = written;
-
-	/* Short writes give back address space */
-	if (inode->i_size != maxpos)
-		vm_unacct_memory(VM_ACCT(maxpos) - VM_ACCT(inode->i_size));
 out:
 	up(&inode->i_sem);
 	return err;
@@ -1551,13 +1562,8 @@ static int shmem_symlink(struct inode *d
 		memcpy(info, symname, len);
 		inode->i_op = &shmem_symlink_inline_operations;
 	} else {
-		if (security_vm_enough_memory(VM_ACCT(1))) {
-			iput(inode);
-			return -ENOMEM;
-		}
 		error = shmem_getpage(inode, 0, &page, SGP_WRITE, NULL);
 		if (error) {
-			vm_unacct_memory(VM_ACCT(1));
 			iput(inode);
 			return error;
 		}
@@ -1947,7 +1953,7 @@ struct file *shmem_file_setup(char *name
 	if (size > SHMEM_MAX_BYTES)
 		return ERR_PTR(-EINVAL);
 
-	if ((flags & VM_ACCOUNT) && security_vm_enough_memory(VM_ACCT(size)))
+	if (shmem_acct_size(flags, size))
 		return ERR_PTR(-ENOMEM);
 
 	error = -ENOMEM;
@@ -1969,7 +1975,7 @@ struct file *shmem_file_setup(char *name
 	if (!inode)
 		goto close_file;
 
-	SHMEM_I(inode)->flags &= flags;
+	SHMEM_I(inode)->flags = flags & VM_ACCOUNT;
 	d_instantiate(dentry, inode);
 	inode->i_size = size;
 	inode->i_nlink = 0;	/* It is unlinked */
@@ -1985,8 +1991,7 @@ close_file:
 put_dentry:
 	dput(dentry);
 put_memory:
-	if (flags & VM_ACCOUNT)
-		vm_unacct_memory(VM_ACCT(size));
+	shmem_unacct_size(flags, size);
 	return ERR_PTR(error);
 }
 

