Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751645AbWITPgv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751645AbWITPgv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 11:36:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751649AbWITPgv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 11:36:51 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:7900 "EHLO e36.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751645AbWITPgu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 11:36:50 -0400
Subject: [RFC][PATCH] filesystem helpers for custom 'struct file's
To: linux-kernel@vger.kernel.org
Cc: hch@infradead.org, Dave Hansen <haveblue@us.ibm.com>
From: Dave Hansen <haveblue@us.ibm.com>
Date: Wed, 20 Sep 2006 08:36:38 -0700
Message-Id: <20060920153638.3EB3BE3C@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Some filesystems forego the vfs and may_open() and create their
own 'struct file's.

This patch creates a couple of helper functions which can be
used by these filesystems, and will provide a unified place
which the r/o bind mount code may patch.

Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
---

 lxc-dave/include/linux/file.h |    8 ++++++++
 lxc-dave/fs/file_table.c      |   30 ++++++++++++++++++++++++++++++
 lxc-dave/fs/hugetlbfs/inode.c |   22 +++++++++-------------
 lxc-dave/mm/shmem.c           |    7 ++-----
 lxc-dave/mm/tiny-shmem.c      |   24 +++++++++---------------
 lxc-dave/net/socket.c         |   17 ++++++++---------
 6 files changed, 66 insertions(+), 42 deletions(-)

diff -puN include/linux/file.h~B0-helpers-for-custom-struct_files include/linux/file.h
--- lxc/include/linux/file.h~B0-helpers-for-custom-struct_files	2006-09-19 10:36:47.000000000 -0700
+++ lxc-dave/include/linux/file.h	2006-09-19 10:36:57.000000000 -0700
@@ -67,6 +67,14 @@ struct files_struct {
 extern void FASTCALL(__fput(struct file *));
 extern void FASTCALL(fput(struct file *));
 
+struct file_operations;
+struct vfsmount;
+struct dentry;
+extern int f_init(struct file *, struct vfsmount *, struct dentry *dentry,
+		mode_t mode, const struct file_operations *fop);
+extern struct file *f_alloc(struct vfsmount *, struct dentry *dentry,
+		mode_t mode, const struct file_operations *fop);
+
 static inline void fput_light(struct file *file, int fput_needed)
 {
 	if (unlikely(fput_needed))
diff -puN fs/file_table.c~B0-helpers-for-custom-struct_files fs/file_table.c
--- lxc/fs/file_table.c~B0-helpers-for-custom-struct_files	2006-09-19 10:36:47.000000000 -0700
+++ lxc-dave/fs/file_table.c	2006-09-19 10:36:57.000000000 -0700
@@ -140,6 +140,36 @@ fail:
 
 EXPORT_SYMBOL(get_empty_filp);
 
+struct file *f_alloc(struct vfsmount *mnt,  struct dentry *dentry,
+		mode_t mode, const struct file_operations *fop)
+{
+	struct file *file;
+
+	file = get_empty_filp();
+	if (!file)
+		return NULL;
+
+	f_init(file, mnt, dentry, mode, fop);
+	return file;
+}
+
+EXPORT_SYMBOL(f_alloc);
+
+int f_init(struct file *file, struct vfsmount *mnt,
+	   struct dentry *dentry, mode_t mode,
+	   const struct file_operations *fop)
+{
+	int error = 0;
+	file->f_vfsmnt = mntget(mnt);
+	file->f_dentry = dentry;
+	file->f_mapping = dentry->d_inode->i_mapping;
+	file->f_mode = mode;
+	file->f_op = fop;
+	return error;
+}
+
+EXPORT_SYMBOL(f_init);
+
 void fastcall fput(struct file *file)
 {
 	if (atomic_dec_and_test(&file->f_count))
diff -puN fs/hugetlbfs/inode.c~B0-helpers-for-custom-struct_files fs/hugetlbfs/inode.c
--- lxc/fs/hugetlbfs/inode.c~B0-helpers-for-custom-struct_files	2006-09-19 10:36:47.000000000 -0700
+++ lxc-dave/fs/hugetlbfs/inode.c	2006-09-19 10:36:57.000000000 -0700
@@ -764,16 +764,11 @@ struct file *hugetlb_zero_setup(size_t s
 	if (!dentry)
 		goto out_shm_unlock;
 
-	error = -ENFILE;
-	file = get_empty_filp();
-	if (!file)
-		goto out_dentry;
-
 	error = -ENOSPC;
 	inode = hugetlbfs_get_inode(root->d_sb, current->fsuid,
 				current->fsgid, S_IFREG | S_IRWXUGO, 0);
 	if (!inode)
-		goto out_file;
+		goto out_dentry;
 
 	error = -ENOMEM;
 	if (hugetlb_reserve_pages(inode, 0, size >> HPAGE_SHIFT))
@@ -782,17 +777,18 @@ struct file *hugetlb_zero_setup(size_t s
 	d_instantiate(dentry, inode);
 	inode->i_size = size;
 	inode->i_nlink = 0;
-	file->f_vfsmnt = mntget(hugetlbfs_vfsmount);
-	file->f_dentry = dentry;
-	file->f_mapping = inode->i_mapping;
-	file->f_op = &hugetlbfs_file_operations;
-	file->f_mode = FMODE_WRITE | FMODE_READ;
+
+	error = -ENFILE;
+	file = f_alloc(hugetlbfs_vfsmount, dentry,
+			FMODE_WRITE | FMODE_READ,
+			&hugetlbfs_file_operations);
+	if (!file)
+		goto out_inode;
+
 	return file;
 
 out_inode:
 	iput(inode);
-out_file:
-	put_filp(file);
 out_dentry:
 	dput(dentry);
 out_shm_unlock:
diff -puN mm/shmem.c~B0-helpers-for-custom-struct_files mm/shmem.c
--- lxc/mm/shmem.c~B0-helpers-for-custom-struct_files	2006-09-19 10:36:47.000000000 -0700
+++ lxc-dave/mm/shmem.c	2006-09-19 10:36:57.000000000 -0700
@@ -2411,11 +2411,8 @@ struct file *shmem_file_setup(char *name
 	d_instantiate(dentry, inode);
 	inode->i_size = size;
 	inode->i_nlink = 0;	/* It is unlinked */
-	file->f_vfsmnt = mntget(shm_mnt);
-	file->f_dentry = dentry;
-	file->f_mapping = inode->i_mapping;
-	file->f_op = &shmem_file_operations;
-	file->f_mode = FMODE_WRITE | FMODE_READ;
+	f_init(file, shm_mnt, dentry, FMODE_WRITE | FMODE_READ,
+			&shmem_file_operations);
 	return file;
 
 close_file:
diff -puN mm/tiny-shmem.c~B0-helpers-for-custom-struct_files mm/tiny-shmem.c
--- lxc/mm/tiny-shmem.c~B0-helpers-for-custom-struct_files	2006-09-19 10:36:47.000000000 -0700
+++ lxc-dave/mm/tiny-shmem.c	2006-09-19 10:36:57.000000000 -0700
@@ -66,24 +66,19 @@ struct file *shmem_file_setup(char *name
 	if (!dentry)
 		goto put_memory;
 
-	error = -ENFILE;
-	file = get_empty_filp();
-	if (!file)
-		goto put_dentry;
-
 	error = -ENOSPC;
 	inode = ramfs_get_inode(root->d_sb, S_IFREG | S_IRWXUGO, 0);
 	if (!inode)
-		goto close_file;
+		goto put_dentry;
 
 	d_instantiate(dentry, inode);
-	inode->i_nlink = 0;	/* It is unlinked */
+	error = -ENFILE;
+	file = f_alloc(shm_mnt, dentry, FMODE_WRITE | FMODE_READ,
+			&ramfs_file_operations);
+	if (!file)
+		goto put_inode;
 
-	file->f_vfsmnt = mntget(shm_mnt);
-	file->f_dentry = dentry;
-	file->f_mapping = inode->i_mapping;
-	file->f_op = &ramfs_file_operations;
-	file->f_mode = FMODE_WRITE | FMODE_READ;
+	inode->i_nlink = 0;	/* It is unlinked */
 
 	/* notify everyone as to the change of file size */
 	error = do_truncate(dentry, size, 0, file);
@@ -91,9 +86,8 @@ struct file *shmem_file_setup(char *name
 		goto close_file;
 
 	return file;
-
-close_file:
-	put_filp(file);
+put_inode:
+	iput(inode);
 put_dentry:
 	dput(dentry);
 put_memory:
diff -puN net/socket.c~B0-helpers-for-custom-struct_files net/socket.c
--- lxc/net/socket.c~B0-helpers-for-custom-struct_files	2006-09-19 10:36:47.000000000 -0700
+++ lxc-dave/net/socket.c	2006-09-19 10:36:57.000000000 -0700
@@ -349,6 +349,7 @@ static int sock_alloc_fd(struct file **f
 
 static int sock_attach_fd(struct socket *sock, struct file *file)
 {
+	struct dentry *dentry;
 	struct qstr this;
 	char name[32];
 
@@ -356,18 +357,16 @@ static int sock_attach_fd(struct socket 
 	this.name = name;
 	this.hash = SOCK_INODE(sock)->i_ino;
 
-	file->f_dentry = d_alloc(sock_mnt->mnt_sb->s_root, &this);
-	if (unlikely(!file->f_dentry))
+	dentry = d_alloc(sock_mnt->mnt_sb->s_root, &this);
+	if (unlikely(!dentry))
 		return -ENOMEM;
 
-	file->f_dentry->d_op = &sockfs_dentry_operations;
-	d_add(file->f_dentry, SOCK_INODE(sock));
-	file->f_vfsmnt = mntget(sock_mnt);
-	file->f_mapping = file->f_dentry->d_inode->i_mapping;
-
+	dentry->d_op = &sockfs_dentry_operations;
+	d_add(dentry, SOCK_INODE(sock));
+	f_init(file, sock_mnt, dentry, FMODE_READ | FMODE_WRITE,
+			&socket_file_ops);
+	SOCK_INODE(sock)->i_fop = &socket_file_ops;
 	sock->file = file;
-	file->f_op = SOCK_INODE(sock)->i_fop = &socket_file_ops;
-	file->f_mode = FMODE_READ | FMODE_WRITE;
 	file->f_flags = O_RDWR;
 	file->f_pos = 0;
 	file->private_data = sock;
_
