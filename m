Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318159AbSGWR0U>; Tue, 23 Jul 2002 13:26:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318158AbSGWR0U>; Tue, 23 Jul 2002 13:26:20 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:25949 "EHLO
	mtvmime03.VERITAS.COM") by vger.kernel.org with ESMTP
	id <S318153AbSGWR0K>; Tue, 23 Jul 2002 13:26:10 -0400
Date: Tue, 23 Jul 2002 18:29:22 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Robert Love <rml@tech9.net>, David Mosberger <davidm@hpl.hp.com>,
       linux-kernel@vger.kernel.org
Subject: [PATCH] VM accounting 3/3 noreserve
In-Reply-To: <Pine.LNX.4.21.0207231823470.10982-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.21.0207231828180.10982-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Jul 2002, David Mosberger wrote:
> Is there a good reason why the MAP_NORESERVE flag is ignored when
> MAP_SHARED is specified?  (Hint: it's the call to vm_enough_memory()
> in shmem_file_setup() that's causing MAP_NORESERVE to be ignored.)

David's right, if we support mmap MAP_NORESERVE, we should support
it on shared anonymous objects: too bad that needs a few changes.
do_mmap_pgoff pass VM_ACCOUNT (or not) down to shmem_file_setup,
flag stored into shmem info, for use by shmem_delete_inode later.
Also removed a harmless but pointless call to shmem_truncate.

MAP_NORESERVE handling remains odd: doesn't have its own VM_flag,
so mprotect a private readonly MAP_NORESERVE mapping to writable
and the reservation is then made/checked (see vmacct2 patch).
I don't mind adding VM_NORESERVE to fix that later,
if MAP_NORESERVE users think it necessary: David?

Last of three patches, against 2.4.19-rc3-ac3 + vmacct1 + vmacct2.

diff -urN vmacct2/include/linux/mm.h vmacct3/include/linux/mm.h
--- vmacct2/include/linux/mm.h	Tue Jul 23 15:33:34 2002
+++ vmacct3/include/linux/mm.h	Tue Jul 23 16:26:16 2002
@@ -513,7 +513,7 @@
 
 extern int fail_writepage(struct page *);
 struct page * shmem_nopage(struct vm_area_struct * vma, unsigned long address, int unused);
-struct file *shmem_file_setup(char * name, loff_t size);
+struct file *shmem_file_setup(char * name, loff_t size, unsigned long flags);
 extern void shmem_lock(struct file * file, int lock);
 extern int shmem_zero_setup(struct vm_area_struct *);
 
diff -urN vmacct2/include/linux/shmem_fs.h vmacct3/include/linux/shmem_fs.h
--- vmacct2/include/linux/shmem_fs.h	Fri Dec 21 17:42:03 2001
+++ vmacct3/include/linux/shmem_fs.h	Tue Jul 23 16:26:16 2002
@@ -26,7 +26,7 @@
 	swp_entry_t		i_direct[SHMEM_NR_DIRECT]; /* for the first blocks */
 	void		      **i_indirect; /* indirect blocks */
 	unsigned long		swapped;
-	int			locked;     /* into memory */
+	unsigned long		flags;
 	struct list_head	list;
 	struct inode	       *inode;
 };
diff -urN vmacct2/ipc/shm.c vmacct3/ipc/shm.c
--- vmacct2/ipc/shm.c	Tue Jul 23 15:48:24 2002
+++ vmacct3/ipc/shm.c	Tue Jul 23 16:26:16 2002
@@ -194,7 +194,7 @@
 	if (!shp)
 		return -ENOMEM;
 	sprintf (name, "SYSV%08x", key);
-	file = shmem_file_setup(name, size);
+	file = shmem_file_setup(name, size, VM_ACCOUNT);
 	error = PTR_ERR(file);
 	if (IS_ERR(file))
 		goto no_file;
diff -urN vmacct2/mm/mmap.c vmacct3/mm/mmap.c
--- vmacct2/mm/mmap.c	Tue Jul 23 16:11:10 2002
+++ vmacct3/mm/mmap.c	Tue Jul 23 16:26:16 2002
@@ -585,7 +585,10 @@
 		return -ENOMEM;
 
 	if (!(flags & MAP_NORESERVE) || vm_accounts_strictly()) {
-		if ((vm_flags & (VM_SHARED|VM_WRITE)) == VM_WRITE) {
+		if (vm_flags & VM_SHARED) {
+			/* Check memory availability in shmem_file_setup? */
+			vm_flags |= VM_ACCOUNT;
+		} else if (vm_flags & VM_WRITE) {
 			/* Private writable mapping: check memory availability */
 			charged = len >> PAGE_SHIFT;
 			if (!vm_enough_memory(charged))
@@ -639,6 +642,14 @@
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
diff -urN vmacct2/mm/shmem.c vmacct3/mm/shmem.c
--- vmacct2/mm/shmem.c	Tue Jul 23 15:33:35 2002
+++ vmacct3/mm/shmem.c	Tue Jul 23 16:26:16 2002
@@ -389,12 +389,14 @@
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
@@ -504,7 +506,7 @@
 	index = page->index;
 	inode = mapping->host;
 	info = SHMEM_I(inode);
-	if (info->locked)
+	if (info->flags & VM_LOCKED)
 		return fail_writepage(page);
 getswap:
 	swap = get_swap_page();
@@ -711,9 +713,12 @@
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
@@ -755,6 +760,7 @@
 		inode->i_atime = inode->i_mtime = inode->i_ctime = CURRENT_TIME;
 		info = SHMEM_I(inode);
 		info->inode = inode;
+		info->flags = VM_ACCOUNT;
 		spin_lock_init (&info->lock);
 		sema_init (&info->sem, 1);
 		switch (mode & S_IFMT) {
@@ -1600,7 +1606,7 @@
  * @size: size to be set for the file
  *
  */
-struct file *shmem_file_setup(char * name, loff_t size)
+struct file *shmem_file_setup(char * name, loff_t size, unsigned long flags)
 {
 	int error;
 	struct file *file;
@@ -1611,7 +1617,7 @@
 	if (size > SHMEM_MAX_BYTES)
 		return ERR_PTR(-EINVAL);
 
-	if (!vm_enough_memory(VM_ACCT(size)))
+	if ((flags & VM_ACCOUNT) && !vm_enough_memory(VM_ACCT(size)))
 		return ERR_PTR(-ENOMEM);
 
 	error = -ENOMEM;
@@ -1633,14 +1639,14 @@
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
@@ -1648,7 +1654,8 @@
 put_dentry:
 	dput (dentry);
 put_memory:
-	vm_unacct_memory(VM_ACCT(size));
+	if (flags & VM_ACCOUNT)
+		vm_unacct_memory(VM_ACCT(size));
 	return ERR_PTR(error);	
 }
 
@@ -1662,7 +1669,7 @@
 	struct file *file;
 	loff_t size = vma->vm_end - vma->vm_start;
 	
-	file = shmem_file_setup("dev/zero", size);
+	file = shmem_file_setup("dev/zero", size, vma->vm_flags);
 	if (IS_ERR(file))
 		return PTR_ERR(file);
 

