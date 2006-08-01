Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750807AbWHAX6h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750807AbWHAX6h (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 19:58:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750789AbWHAXxV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 19:53:21 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:36789 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750798AbWHAXxD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 19:53:03 -0400
Subject: [PATCH 27/28] elevate writer count for custom 'struct file'
To: linux-kernel@vger.kernel.org
Cc: viro@ftp.linux.org.uk, herbert@13thfloor.at, hch@infradead.org,
       Dave Hansen <haveblue@us.ibm.com>
From: Dave Hansen <haveblue@us.ibm.com>
Date: Tue, 01 Aug 2006 16:53:00 -0700
References: <20060801235240.82ADCA42@localhost.localdomain>
In-Reply-To: <20060801235240.82ADCA42@localhost.localdomain>
Message-Id: <20060801235300.321FABDD@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Some filesystems forego the vfs and may_open() and create their
own 'struct file's.  Any of these users which set the write flag
on the file will cause an extra mnt_drop_write() on __fput(),
thus dropping the reference count too low.

These users tend to have artifical in-kernel vfsmounts which
aren't really exposed to userspace and can't be remounted, but
this patch is included for completeness and so that the warnings
don't trip over these cases.

Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
---

 lxc-dave/fs/hugetlbfs/inode.c |    2 ++
 lxc-dave/mm/shmem.c           |    2 ++
 lxc-dave/mm/tiny-shmem.c      |    2 ++
 lxc-dave/net/socket.c         |    3 +++
 4 files changed, 9 insertions(+)

diff -puN fs/hugetlbfs/inode.c~C-elevate-writer-count-for-custom-struct_file fs/hugetlbfs/inode.c
--- lxc/fs/hugetlbfs/inode.c~C-elevate-writer-count-for-custom-struct_file	2006-08-01 16:35:07.000000000 -0700
+++ lxc-dave/fs/hugetlbfs/inode.c	2006-08-01 16:35:33.000000000 -0700
@@ -787,6 +787,8 @@ struct file *hugetlb_zero_setup(size_t s
 	file->f_mapping = inode->i_mapping;
 	file->f_op = &hugetlbfs_file_operations;
 	file->f_mode = FMODE_WRITE | FMODE_READ;
+	error = mnt_want_write(hugetlbfs_vfsmount);
+	WARN_ON(error);
 	return file;
 
 out_inode:
diff -puN mm/shmem.c~C-elevate-writer-count-for-custom-struct_file mm/shmem.c
--- lxc/mm/shmem.c~C-elevate-writer-count-for-custom-struct_file	2006-08-01 16:35:15.000000000 -0700
+++ lxc-dave/mm/shmem.c	2006-08-01 16:35:33.000000000 -0700
@@ -2322,6 +2322,8 @@ struct file *shmem_file_setup(char *name
 	file->f_mapping = inode->i_mapping;
 	file->f_op = &shmem_file_operations;
 	file->f_mode = FMODE_WRITE | FMODE_READ;
+	error = mnt_want_write(shm_mnt);
+	WARN_ON(error);
 	return file;
 
 close_file:
diff -puN mm/tiny-shmem.c~C-elevate-writer-count-for-custom-struct_file mm/tiny-shmem.c
--- lxc/mm/tiny-shmem.c~C-elevate-writer-count-for-custom-struct_file	2006-08-01 16:35:07.000000000 -0700
+++ lxc-dave/mm/tiny-shmem.c	2006-08-01 16:35:33.000000000 -0700
@@ -84,6 +84,8 @@ struct file *shmem_file_setup(char *name
 	file->f_mapping = inode->i_mapping;
 	file->f_op = &ramfs_file_operations;
 	file->f_mode = FMODE_WRITE | FMODE_READ;
+	error = mnt_want_write(shm_mnt);
+	WARN_ON(error);
 
 	/* notify everyone as to the change of file size */
 	error = do_truncate(dentry, size, 0, file);
diff -puN net/socket.c~C-elevate-writer-count-for-custom-struct_file net/socket.c
--- lxc/net/socket.c~C-elevate-writer-count-for-custom-struct_file	2006-08-01 16:35:07.000000000 -0700
+++ lxc-dave/net/socket.c	2006-08-01 16:35:33.000000000 -0700
@@ -389,6 +389,7 @@ static int sock_attach_fd(struct socket 
 {
 	struct qstr this;
 	char name[32];
+	int error;
 
 	this.len = sprintf(name, "[%lu]", SOCK_INODE(sock)->i_ino);
 	this.name = name;
@@ -409,6 +410,8 @@ static int sock_attach_fd(struct socket 
 	file->f_flags = O_RDWR;
 	file->f_pos = 0;
 	file->private_data = sock;
+	error = mnt_want_write(sock_mnt);
+	WARN_ON(error);
 
 	return 0;
 }
_
