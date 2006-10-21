Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992877AbWJUHQq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992877AbWJUHQq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Oct 2006 03:16:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992871AbWJUHOy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Oct 2006 03:14:54 -0400
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:28551 "EHLO
	filer.fsl.cs.sunysb.edu") by vger.kernel.org with ESMTP
	id S2992865AbWJUHOj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Oct 2006 03:14:39 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 15 of 23] mm: change uses of f_{dentry,vfsmnt} to use f_path
Message-Id: <bf54fa27ee54d7c87316.1161411460@thor.fsl.cs.sunysb.edu>
In-Reply-To: <patchbomb.1161411445@thor.fsl.cs.sunysb.edu>
Date: Sat, 21 Oct 2006 02:17:40 -0400
From: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>
To: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, akpm@osdl.org, torvalds@osdl.org,
       viro@ftp.linux.org.uk, hch@infradead.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>

This patch changes all the uses of f_{dentry,vfsmnt} to f_path.{dentry,mnt}
in linux/mm/.

Signed-off-by: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>

---

6 files changed, 21 insertions(+), 21 deletions(-)
mm/fadvise.c     |    2 +-
mm/filemap.c     |    2 +-
mm/filemap_xip.c |    2 +-
mm/mmap.c        |   10 +++++-----
mm/shmem.c       |   20 ++++++++++----------
mm/swapfile.c    |    6 +++---

diff --git a/mm/fadvise.c b/mm/fadvise.c
--- a/mm/fadvise.c
+++ b/mm/fadvise.c
@@ -38,7 +38,7 @@ asmlinkage long sys_fadvise64_64(int fd,
 	if (!file)
 		return -EBADF;
 
-	if (S_ISFIFO(file->f_dentry->d_inode->i_mode)) {
+	if (S_ISFIFO(file->f_path.dentry->d_inode->i_mode)) {
 		ret = -ESPIPE;
 		goto out;
 	}
diff --git a/mm/filemap.c b/mm/filemap.c
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2267,7 +2267,7 @@ __generic_file_aio_write_nolock(struct k
 	if (count == 0)
 		goto out;
 
-	err = remove_suid(file->f_dentry);
+	err = remove_suid(file->f_path.dentry);
 	if (err)
 		goto out;
 
diff --git a/mm/filemap_xip.c b/mm/filemap_xip.c
--- a/mm/filemap_xip.c
+++ b/mm/filemap_xip.c
@@ -379,7 +379,7 @@ xip_file_write(struct file *filp, const 
 	if (count == 0)
 		goto out_backing;
 
-	ret = remove_suid(filp->f_dentry);
+	ret = remove_suid(filp->f_path.dentry);
 	if (ret)
 		goto out_backing;
 
diff --git a/mm/mmap.c b/mm/mmap.c
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -188,7 +188,7 @@ static void __remove_shared_vm_struct(st
 		struct file *file, struct address_space *mapping)
 {
 	if (vma->vm_flags & VM_DENYWRITE)
-		atomic_inc(&file->f_dentry->d_inode->i_writecount);
+		atomic_inc(&file->f_path.dentry->d_inode->i_writecount);
 	if (vma->vm_flags & VM_SHARED)
 		mapping->i_mmap_writable--;
 
@@ -399,7 +399,7 @@ static inline void __vma_link_file(struc
 		struct address_space *mapping = file->f_mapping;
 
 		if (vma->vm_flags & VM_DENYWRITE)
-			atomic_dec(&file->f_dentry->d_inode->i_writecount);
+			atomic_dec(&file->f_path.dentry->d_inode->i_writecount);
 		if (vma->vm_flags & VM_SHARED)
 			mapping->i_mmap_writable++;
 
@@ -907,7 +907,7 @@ unsigned long do_mmap_pgoff(struct file 
 	 *  mounted, in which case we dont add PROT_EXEC.)
 	 */
 	if ((prot & PROT_READ) && (current->personality & READ_IMPLIES_EXEC))
-		if (!(file && (file->f_vfsmnt->mnt_flags & MNT_NOEXEC)))
+		if (!(file && (file->f_path.mnt->mnt_flags & MNT_NOEXEC)))
 			prot |= PROT_EXEC;
 
 	if (!len)
@@ -960,7 +960,7 @@ unsigned long do_mmap_pgoff(struct file 
 			return -EAGAIN;
 	}
 
-	inode = file ? file->f_dentry->d_inode : NULL;
+	inode = file ? file->f_path.dentry->d_inode : NULL;
 
 	if (file) {
 		switch (flags & MAP_TYPE) {
@@ -989,7 +989,7 @@ unsigned long do_mmap_pgoff(struct file 
 		case MAP_PRIVATE:
 			if (!(file->f_mode & FMODE_READ))
 				return -EACCES;
-			if (file->f_vfsmnt->mnt_flags & MNT_NOEXEC) {
+			if (file->f_path.mnt->mnt_flags & MNT_NOEXEC) {
 				if (vm_flags & VM_EXEC)
 					return -EPERM;
 				vm_flags &= ~VM_MAYEXEC;
diff --git a/mm/shmem.c b/mm/shmem.c
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1225,7 +1225,7 @@ failed:
 
 struct page *shmem_nopage(struct vm_area_struct *vma, unsigned long address, int *type)
 {
-	struct inode *inode = vma->vm_file->f_dentry->d_inode;
+	struct inode *inode = vma->vm_file->f_path.dentry->d_inode;
 	struct page *page = NULL;
 	unsigned long idx;
 	int error;
@@ -1248,7 +1248,7 @@ static int shmem_populate(struct vm_area
 	unsigned long addr, unsigned long len,
 	pgprot_t prot, unsigned long pgoff, int nonblock)
 {
-	struct inode *inode = vma->vm_file->f_dentry->d_inode;
+	struct inode *inode = vma->vm_file->f_path.dentry->d_inode;
 	struct mm_struct *mm = vma->vm_mm;
 	enum sgp_type sgp = nonblock? SGP_QUICK: SGP_CACHE;
 	unsigned long size;
@@ -1293,14 +1293,14 @@ static int shmem_populate(struct vm_area
 #ifdef CONFIG_NUMA
 int shmem_set_policy(struct vm_area_struct *vma, struct mempolicy *new)
 {
-	struct inode *i = vma->vm_file->f_dentry->d_inode;
+	struct inode *i = vma->vm_file->f_path.dentry->d_inode;
 	return mpol_set_shared_policy(&SHMEM_I(i)->policy, vma, new);
 }
 
 struct mempolicy *
 shmem_get_policy(struct vm_area_struct *vma, unsigned long addr)
 {
-	struct inode *i = vma->vm_file->f_dentry->d_inode;
+	struct inode *i = vma->vm_file->f_path.dentry->d_inode;
 	unsigned long idx;
 
 	idx = ((addr - vma->vm_start) >> PAGE_SHIFT) + vma->vm_pgoff;
@@ -1310,7 +1310,7 @@ shmem_get_policy(struct vm_area_struct *
 
 int shmem_lock(struct file *file, int lock, struct user_struct *user)
 {
-	struct inode *inode = file->f_dentry->d_inode;
+	struct inode *inode = file->f_path.dentry->d_inode;
 	struct shmem_inode_info *info = SHMEM_I(inode);
 	int retval = -ENOMEM;
 
@@ -1422,7 +1422,7 @@ static ssize_t
 static ssize_t
 shmem_file_write(struct file *file, const char __user *buf, size_t count, loff_t *ppos)
 {
-	struct inode	*inode = file->f_dentry->d_inode;
+	struct inode	*inode = file->f_path.dentry->d_inode;
 	loff_t		pos;
 	unsigned long	written;
 	ssize_t		err;
@@ -1442,7 +1442,7 @@ shmem_file_write(struct file *file, cons
 	if (err || !count)
 		goto out;
 
-	err = remove_suid(file->f_dentry);
+	err = remove_suid(file->f_path.dentry);
 	if (err)
 		goto out;
 
@@ -1524,7 +1524,7 @@ out:
 
 static void do_shmem_file_read(struct file *filp, loff_t *ppos, read_descriptor_t *desc, read_actor_t actor)
 {
-	struct inode *inode = filp->f_dentry->d_inode;
+	struct inode *inode = filp->f_path.dentry->d_inode;
 	struct address_space *mapping = inode->i_mapping;
 	unsigned long index, offset;
 
@@ -2493,8 +2493,8 @@ struct file *shmem_file_setup(char *name
 	d_instantiate(dentry, inode);
 	inode->i_size = size;
 	inode->i_nlink = 0;	/* It is unlinked */
-	file->f_vfsmnt = mntget(shm_mnt);
-	file->f_dentry = dentry;
+	file->f_path.mnt = mntget(shm_mnt);
+	file->f_path.dentry = dentry;
 	file->f_mapping = inode->i_mapping;
 	file->f_op = &shmem_file_operations;
 	file->f_mode = FMODE_WRITE | FMODE_READ;
diff --git a/mm/swapfile.c b/mm/swapfile.c
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -447,7 +447,7 @@ int swap_type_of(dev_t device)
 			spin_unlock(&swap_lock);
 			return i;
 		}
-		inode = swap_info[i].swap_file->f_dentry->d_inode;
+		inode = swap_info[i].swap_file->f_path.dentry->d_inode;
 		if (S_ISBLK(inode->i_mode) &&
 		    device == MKDEV(imajor(inode), iminor(inode))) {
 			spin_unlock(&swap_lock);
@@ -1314,10 +1314,10 @@ static int swap_show(struct seq_file *sw
 		seq_puts(swap, "Filename\t\t\t\tType\t\tSize\tUsed\tPriority\n");
 
 	file = ptr->swap_file;
-	len = seq_path(swap, file->f_vfsmnt, file->f_dentry, " \t\n\\");
+	len = seq_path(swap, file->f_path.mnt, file->f_path.dentry, " \t\n\\");
 	seq_printf(swap, "%*s%s\t%u\t%u\t%d\n",
 		       len < 40 ? 40 - len : 1, " ",
-		       S_ISBLK(file->f_dentry->d_inode->i_mode) ?
+		       S_ISBLK(file->f_path.dentry->d_inode->i_mode) ?
 				"partition" : "file\t",
 		       ptr->pages << (PAGE_SHIFT - 10),
 		       ptr->inuse_pages << (PAGE_SHIFT - 10),


