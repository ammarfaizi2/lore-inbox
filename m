Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318084AbSG2WL4>; Mon, 29 Jul 2002 18:11:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318138AbSG2WL4>; Mon, 29 Jul 2002 18:11:56 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:5467 "EHLO
	mtvmime02.veritas.com") by vger.kernel.org with ESMTP
	id <S318084AbSG2WL3>; Mon, 29 Jul 2002 18:11:29 -0400
Date: Mon, 29 Jul 2002 23:14:55 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Robert Love <rml@tech9.net>,
       Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org
Subject: [PATCH] vmacct8/9 shmem_file_setup when MAP_NORESERVE
In-Reply-To: <Pine.LNX.4.21.0207292257001.1184-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.21.0207292313330.1184-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tangential to VM overcommit strict accounting,
On Fri, 12 Jul 2002, David Mosberger wrote to LKML:
> Is there a good reason why the MAP_NORESERVE flag is ignored when
> MAP_SHARED is specified?  (Hint: it's the call to vm_enough_memory()
> in shmem_file_setup() that's causing MAP_NORESERVE to be ignored.)

He's right, if we support mmap MAP_NORESERVE, we should support
it on shared anonymous objects: too bad that needs a few changes.
do_mmap_pgoff pass VM_ACCOUNT (or not) down to shmem_file_setup,
flag stored into shmem info, for use by shmem_delete_inode later.
Also removed a harmless but pointless call to shmem_truncate.

--- vmacct7/include/linux/mm.h	Mon Jul 29 11:48:04 2002
+++ vmacct8/include/linux/mm.h	Mon Jul 29 19:23:46 2002
@@ -331,7 +331,7 @@
 
 extern int fail_writepage(struct page *);
 struct page * shmem_nopage(struct vm_area_struct * vma, unsigned long address, int unused);
-struct file *shmem_file_setup(char * name, loff_t size);
+struct file *shmem_file_setup(char * name, loff_t size, unsigned long flags);
 extern void shmem_lock(struct file * file, int lock);
 extern int shmem_zero_setup(struct vm_area_struct *);
 
--- vmacct7/include/linux/shmem_fs.h	Thu Jul 25 13:04:59 2002
+++ vmacct8/include/linux/shmem_fs.h	Mon Jul 29 19:23:46 2002
@@ -16,7 +16,7 @@
 	swp_entry_t		i_direct[SHMEM_NR_DIRECT]; /* for the first blocks */
 	void		      **i_indirect; /* indirect blocks */
 	unsigned long		swapped;
-	int			locked;     /* into memory */
+	unsigned long		flags;
 	struct list_head	list;
 	struct inode		vfs_inode;
 };
--- vmacct7/ipc/shm.c	Mon Jul 29 11:48:04 2002
+++ vmacct8/ipc/shm.c	Mon Jul 29 19:23:46 2002
@@ -186,7 +186,7 @@
 	shp->shm_flags = (shmflg & S_IRWXUGO);
 
 	sprintf (name, "SYSV%08x", key);
-	file = shmem_file_setup(name, size);
+	file = shmem_file_setup(name, size, VM_ACCOUNT);
 	error = PTR_ERR(file);
 	if (IS_ERR(file))
 		goto no_file;
--- vmacct7/mm/mmap.c	Mon Jul 29 19:23:46 2002
+++ vmacct8/mm/mmap.c	Mon Jul 29 19:23:46 2002
@@ -528,7 +528,10 @@
 		return -ENOMEM;
 
 	if (!(flags & MAP_NORESERVE) || sysctl_overcommit_memory > 1) {
-		if ((vm_flags & (VM_SHARED|VM_WRITE)) == VM_WRITE) {
+		if (vm_flags & VM_SHARED) {
+			/* Check memory availability in shmem_file_setup? */
+			vm_flags |= VM_ACCOUNT;
+		} else if (vm_flags & VM_WRITE) {
 			/* Private writable mapping: check memory availability */
 			charged = len >> PAGE_SHIFT;
 			if (!vm_enough_memory(charged))
@@ -582,6 +585,14 @@
 		if (error)
 			goto free_vma;
 	}
+
+	/* We set VM_ACCOUNT in a shared mapping's vm_flags, to inform
+	 * shmem_zero_setup (perhaps called through /dev/zero's ->mmap)
+	 * that memory reservation must be checked; but that reservation
+	 * belongs to shared memory object, not to vma: so now clear it.
+	 */
+	if ((vm_flags & (VM_SHARED|VM_ACCOUNT)) == (VM_SHARED|VM_ACCOUNT))
+		vma->vm_flags &= ~VM_ACCOUNT;
 
 	/* Can addr have changed??
 	 *
--- vmacct7/mm/shmem.c	Mon Jul 29 19:23:46 2002
+++ vmacct8/mm/shmem.c	Mon Jul 29 19:23:46 2002
@@ -392,12 +392,14 @@
 static void shmem_delete_inode(struct inode * inode)
 {
 	struct shmem_sb_info *sbinfo = SHMEM_SB(inode->i_sb);
+	struct shmem_inode_info *info = SHMEM_I(inode);
 
 	if (inode->i_op->truncate == shmem_truncate) {
-		spin_lock (&shmem_ilock);
-		list_del (&SHMEM_I(inode)->list);
-		spin_unlock (&shmem_ilock);
-		vm_unacct_memory(VM_ACCT(inode->i_size));
+		spin_lock(&shmem_ilock);
+		list_del(&info->list);
+		spin_unlock(&shmem_ilock);
+		if (info->flags & VM_ACCOUNT)
+			vm_unacct_memory(VM_ACCT(inode->i_size));
 		inode->i_size = 0;
 		shmem_truncate (inode);
 	}
@@ -526,7 +528,7 @@
 	index = page->index;
 	inode = mapping->host;
 	info = SHMEM_I(inode);
-	if (info->locked)
+	if (info->flags & VM_LOCKED)
 		return fail_writepage(page);
 	swap = get_swap_page();
 	if (!swap.val)
@@ -743,9 +745,12 @@
 	struct inode * inode = file->f_dentry->d_inode;
 	struct shmem_inode_info * info = SHMEM_I(inode);
 
-	down(&info->sem);
-	info->locked = lock;
-	up(&info->sem);
+	spin_lock(&info->lock);
+	if (lock)
+		info->flags |= VM_LOCKED;
+	else
+		info->flags &= ~VM_LOCKED;
+	spin_unlock(&info->lock);
 }
 
 static int shmem_mmap(struct file * file, struct vm_area_struct * vma)
@@ -792,7 +797,7 @@
 		memset (info->i_direct, 0, sizeof(info->i_direct));
 		info->i_indirect = NULL;
 		info->swapped = 0;
-		info->locked = 0;
+		info->flags = VM_ACCOUNT;
 		switch (mode & S_IFMT) {
 		default:
 			init_special_inode(inode, mode, dev);
@@ -1652,7 +1657,7 @@
  * @size: size to be set for the file
  *
  */
-struct file *shmem_file_setup(char * name, loff_t size)
+struct file *shmem_file_setup(char * name, loff_t size, unsigned long flags)
 {
 	int error;
 	struct file *file;
@@ -1663,7 +1668,7 @@
 	if (size > SHMEM_MAX_BYTES)
 		return ERR_PTR(-EINVAL);
 
-	if (!vm_enough_memory(VM_ACCT(size)))
+	if ((flags & VM_ACCOUNT) && !vm_enough_memory(VM_ACCT(size)))
 		return ERR_PTR(-ENOMEM);
 
 	error = -ENOMEM;
@@ -1685,14 +1690,14 @@
 	if (!inode) 
 		goto close_file;
 
+	SHMEM_I(inode)->flags &= flags;
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
@@ -1700,7 +1705,8 @@
 put_dentry:
 	dput (dentry);
 put_memory:
-	vm_unacct_memory(VM_ACCT(size));
+	if (flags & VM_ACCOUNT)
+		vm_unacct_memory(VM_ACCT(size));
 	return ERR_PTR(error);	
 }
 
@@ -1714,7 +1720,7 @@
 	struct file *file;
 	loff_t size = vma->vm_end - vma->vm_start;
 	
-	file = shmem_file_setup("dev/zero", size);
+	file = shmem_file_setup("dev/zero", size, vma->vm_flags);
 	if (IS_ERR(file))
 		return PTR_ERR(file);
 

