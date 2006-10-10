Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964971AbWJJS0K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964971AbWJJS0K (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 14:26:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965060AbWJJS0K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 14:26:10 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:45972 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S964971AbWJJS0I
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 14:26:08 -0400
Subject: [RFC] v2 - [PATCH] filesystem helpers for custom 'struct file's
To: linux-kernel@vger.kernel.org
Cc: hch@infradead.org, Dave Hansen <haveblue@us.ibm.com>
From: Dave Hansen <haveblue@us.ibm.com>
Date: Tue, 10 Oct 2006 11:24:29 -0700
Message-Id: <20061010182428.9A9C5285@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Some filesystems forego the vfs and may_open() and create their
own 'struct file's.

This patch creates a couple of helper functions which can be
used by these filesystems, and will provide a unified place
which the r/o bind mount code may patch.

Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
---

 lxc-dave/include/linux/file.h |    8 ++++
 lxc-dave/fs/file_table.c      |   30 +++++++++++++++
 lxc-dave/fs/hugetlbfs/inode.c |   22 ++++-------
 lxc-dave/mm/shmem.c           |   22 ++++-------
 lxc-dave/mm/tiny-shmem.c      |   24 ++++--------
 lxc-dave/net/socket.c         |   82 +++++++++++++++++-------------------------
 6 files changed, 99 insertions(+), 89 deletions(-)

diff -puN include/linux/file.h~B0-helpers-for-custom-struct_files include/linux/file.h
--- lxc/include/linux/file.h~B0-helpers-for-custom-struct_files	2006-10-10 10:54:31.000000000 -0700
+++ lxc-dave/include/linux/file.h	2006-10-10 10:55:14.000000000 -0700
@@ -67,6 +67,14 @@ struct files_struct {
 extern void FASTCALL(__fput(struct file *));
 extern void FASTCALL(fput(struct file *));
 
+struct file_operations;
+struct vfsmount;
+struct dentry;
+extern int init_file(struct file *, struct vfsmount *, struct dentry *dentry,
+		mode_t mode, const struct file_operations *fop);
+extern struct file *alloc_file(struct vfsmount *, struct dentry *dentry,
+		mode_t mode, const struct file_operations *fop);
+
 static inline void fput_light(struct file *file, int fput_needed)
 {
 	if (unlikely(fput_needed))
diff -puN fs/file_table.c~B0-helpers-for-custom-struct_files fs/file_table.c
--- lxc/fs/file_table.c~B0-helpers-for-custom-struct_files	2006-10-10 10:54:31.000000000 -0700
+++ lxc-dave/fs/file_table.c	2006-10-10 10:55:14.000000000 -0700
@@ -140,6 +140,36 @@ fail:
 
 EXPORT_SYMBOL(get_empty_filp);
 
+struct file *alloc_file(struct vfsmount *mnt,  struct dentry *dentry,
+		mode_t mode, const struct file_operations *fop)
+{
+	struct file *file;
+
+	file = get_empty_filp();
+	if (!file)
+		return NULL;
+
+	init_file(file, mnt, dentry, mode, fop);
+	return file;
+}
+
+EXPORT_SYMBOL(alloc_file);
+
+int init_file(struct file *file, struct vfsmount *mnt,
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
+EXPORT_SYMBOL(init_file);
+
 void fastcall fput(struct file *file)
 {
 	if (atomic_dec_and_test(&file->f_count))
diff -puN fs/hugetlbfs/inode.c~B0-helpers-for-custom-struct_files fs/hugetlbfs/inode.c
--- lxc/fs/hugetlbfs/inode.c~B0-helpers-for-custom-struct_files	2006-10-10 10:54:31.000000000 -0700
+++ lxc-dave/fs/hugetlbfs/inode.c	2006-10-10 10:55:14.000000000 -0700
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
+	file = alloc_file(hugetlbfs_vfsmount, dentry,
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
--- lxc/mm/shmem.c~B0-helpers-for-custom-struct_files	2006-10-10 10:54:31.000000000 -0700
+++ lxc-dave/mm/shmem.c	2006-10-10 10:55:14.000000000 -0700
@@ -2464,29 +2464,25 @@ struct file *shmem_file_setup(char *name
 	if (!dentry)
 		goto put_memory;
 
-	error = -ENFILE;
-	file = get_empty_filp();
-	if (!file)
-		goto put_dentry;
-
 	error = -ENOSPC;
 	inode = shmem_get_inode(root->d_sb, S_IFREG | S_IRWXUGO, 0);
 	if (!inode)
-		goto close_file;
+		goto put_dentry;
+
+	error = -ENFILE;
+	file = alloc_file(shm_mnt, dentry, FMODE_WRITE | FMODE_READ,
+				&shmem_file_operations);
+	if (!file)
+		goto put_inode;
 
 	SHMEM_I(inode)->flags = flags & VM_ACCOUNT;
 	d_instantiate(dentry, inode);
 	inode->i_size = size;
 	inode->i_nlink = 0;	/* It is unlinked */
-	file->f_vfsmnt = mntget(shm_mnt);
-	file->f_dentry = dentry;
-	file->f_mapping = inode->i_mapping;
-	file->f_op = &shmem_file_operations;
-	file->f_mode = FMODE_WRITE | FMODE_READ;
 	return file;
 
-close_file:
-	put_filp(file);
+put_inode:
+	iput(inode);
 put_dentry:
 	dput(dentry);
 put_memory:
diff -puN mm/tiny-shmem.c~B0-helpers-for-custom-struct_files mm/tiny-shmem.c
--- lxc/mm/tiny-shmem.c~B0-helpers-for-custom-struct_files	2006-10-10 10:54:31.000000000 -0700
+++ lxc-dave/mm/tiny-shmem.c	2006-10-10 10:55:14.000000000 -0700
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
+	file = alloc_file(shm_mnt, dentry, FMODE_WRITE | FMODE_READ,
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
--- lxc/net/socket.c~B0-helpers-for-custom-struct_files	2006-10-10 10:54:31.000000000 -0700
+++ lxc-dave/net/socket.c	2006-10-10 10:55:14.000000000 -0700
@@ -330,26 +330,10 @@ static struct dentry_operations sockfs_d
  *	but we take care of internal coherence yet.
  */
 
-static int sock_alloc_fd(struct file **filep)
-{
-	int fd;
-
-	fd = get_unused_fd();
-	if (likely(fd >= 0)) {
-		struct file *file = get_empty_filp();
-
-		*filep = file;
-		if (unlikely(!file)) {
-			put_unused_fd(fd);
-			return -ENFILE;
-		}
-	} else
-		*filep = NULL;
-	return fd;
-}
-
-static int sock_attach_fd(struct socket *sock, struct file *file)
+struct file *sock_alloc_file(struct socket *sock)
 {
+	struct file *file;
+	struct dentry *dentry;
 	struct qstr this;
 	char name[32];
 
@@ -357,40 +341,39 @@ static int sock_attach_fd(struct socket 
 	this.name = name;
 	this.hash = SOCK_INODE(sock)->i_ino;
 
-	file->f_dentry = d_alloc(sock_mnt->mnt_sb->s_root, &this);
-	if (unlikely(!file->f_dentry))
-		return -ENOMEM;
-
-	file->f_dentry->d_op = &sockfs_dentry_operations;
-	d_add(file->f_dentry, SOCK_INODE(sock));
-	file->f_vfsmnt = mntget(sock_mnt);
-	file->f_mapping = file->f_dentry->d_inode->i_mapping;
-
+	dentry = d_alloc(sock_mnt->mnt_sb->s_root, &this);
+	if (unlikely(!dentry))
+		return ERR_PTR(-ENOMEM);
+
+	dentry->d_op = &sockfs_dentry_operations;
+	d_add(dentry, SOCK_INODE(sock));
+	file = alloc_file(sock_mnt, dentry, FMODE_READ | FMODE_WRITE,
+			&socket_file_ops);
+	if (!file) {
+		dput(dentry);
+		return ERR_PTR(-ENOMEM);
+	}
+	SOCK_INODE(sock)->i_fop = &socket_file_ops;
 	sock->file = file;
-	file->f_op = SOCK_INODE(sock)->i_fop = &socket_file_ops;
-	file->f_mode = FMODE_READ | FMODE_WRITE;
 	file->f_flags = O_RDWR;
 	file->f_pos = 0;
 	file->private_data = sock;
 
-	return 0;
+	return file;
 }
 
 int sock_map_fd(struct socket *sock)
 {
 	struct file *newfile;
-	int fd = sock_alloc_fd(&newfile);
+	int fd = get_unused_fd();
 
-	if (likely(fd >= 0)) {
-		int err = sock_attach_fd(sock, newfile);
+	newfile = sock_alloc_file(sock);
 
-		if (unlikely(err < 0)) {
-			put_filp(newfile);
-			put_unused_fd(fd);
-			return err;
-		}
-		fd_install(fd, newfile);
+	if (IS_ERR(newfile)) {
+		put_unused_fd(fd);
+		return PTR_ERR(newfile);
 	}
+	fd_install(fd, newfile);
 	return fd;
 }
 
@@ -1355,35 +1338,37 @@ asmlinkage long sys_accept(int fd, struc
 	 */
 	__module_get(newsock->ops->owner);
 
-	newfd = sock_alloc_fd(&newfile);
+	newfd = get_unused_fd();
 	if (unlikely(newfd < 0)) {
 		err = newfd;
 		sock_release(newsock);
 		goto out_put;
 	}
 
-	err = sock_attach_fd(newsock, newfile);
-	if (err < 0)
+	newfile = sock_alloc_file(newsock);
+	if (IS_ERR(newfile)) {
+		err = PTR_ERR(newfile);
 		goto out_fd;
+	}
 
 	err = security_socket_accept(sock, newsock);
 	if (err)
-		goto out_fd;
+		goto out_file;
 
 	err = sock->ops->accept(sock, newsock, sock->file->f_flags);
 	if (err < 0)
-		goto out_fd;
+		goto out_file;
 
 	if (upeer_sockaddr) {
 		if (newsock->ops->getname(newsock, (struct sockaddr *)address,
 					  &len, 2) < 0) {
 			err = -ECONNABORTED;
-			goto out_fd;
+			goto out_file;
 		}
 		err = move_addr_to_user(address, len, upeer_sockaddr,
 					upeer_addrlen);
 		if (err < 0)
-			goto out_fd;
+			goto out_file;
 	}
 
 	/* File flags are not inherited via accept() unlike another OSes. */
@@ -1397,8 +1382,9 @@ out_put:
 	fput_light(sock->file, fput_needed);
 out:
 	return err;
-out_fd:
+out_file:
 	fput(newfile);
+out_fd:
 	put_unused_fd(newfd);
 	goto out_put;
 }
_
