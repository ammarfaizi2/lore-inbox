Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422647AbWF0WSK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422647AbWF0WSK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 18:18:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422648AbWF0WPQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 18:15:16 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:53418 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030472AbWF0WPB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 18:15:01 -0400
Subject: [PATCH 19/20] elevate writer count for custom 'struct file'
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, herbert@13thfloor.at, viro@ftp.linux.org.uk,
       serue@us.ibm.com, Dave Hansen <haveblue@us.ibm.com>
From: Dave Hansen <haveblue@us.ibm.com>
Date: Tue, 27 Jun 2006 15:14:56 -0700
References: <20060627221436.77CCB048@localhost.localdomain>
In-Reply-To: <20060627221436.77CCB048@localhost.localdomain>
Message-Id: <20060627221456.F6AD6304@localhost.localdomain>
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

diff -puN fs/hugetlbfs/inode.c~fix-__fput-rev2 fs/hugetlbfs/inode.c
--- lxc/fs/hugetlbfs/inode.c~fix-__fput-rev2	2006-06-27 10:40:35.000000000 -0700
+++ lxc-dave/fs/hugetlbfs/inode.c	2006-06-27 10:40:35.000000000 -0700
@@ -790,6 +790,8 @@ struct file *hugetlb_zero_setup(size_t s
 	file->f_mapping = inode->i_mapping;
 	file->f_op = &hugetlbfs_file_operations;
 	file->f_mode = FMODE_WRITE | FMODE_READ;
+	error = mnt_want_write(hugetlbfs_vfsmount);
+	WARN_ON(error);
 	return file;
 
 out_inode:
diff -puN mm/shmem.c~fix-__fput-rev2 mm/shmem.c
--- lxc/mm/shmem.c~fix-__fput-rev2	2006-06-27 10:40:35.000000000 -0700
+++ lxc-dave/mm/shmem.c	2006-06-27 10:40:35.000000000 -0700
@@ -2326,6 +2326,8 @@ struct file *shmem_file_setup(char *name
 	file->f_mapping = inode->i_mapping;
 	file->f_op = &shmem_file_operations;
 	file->f_mode = FMODE_WRITE | FMODE_READ;
+	error = mnt_want_write(shm_mnt);
+	WARN_ON(error);
 	return file;
 
 close_file:
diff -puN mm/tiny-shmem.c~fix-__fput-rev2 mm/tiny-shmem.c
--- lxc/mm/tiny-shmem.c~fix-__fput-rev2	2006-06-27 10:40:35.000000000 -0700
+++ lxc-dave/mm/tiny-shmem.c	2006-06-27 10:40:35.000000000 -0700
@@ -88,6 +88,8 @@ struct file *shmem_file_setup(char *name
 	file->f_mapping = inode->i_mapping;
 	file->f_op = &ramfs_file_operations;
 	file->f_mode = FMODE_WRITE | FMODE_READ;
+	error = mnt_want_write(shm_mnt);
+	WARN_ON(error);
 
 	/* notify everyone as to the change of file size */
 	error = do_truncate(dentry, size, 0, file);
diff -puN net/socket.c~fix-__fput-rev2 net/socket.c
--- lxc/net/socket.c~fix-__fput-rev2	2006-06-27 10:40:35.000000000 -0700
+++ lxc-dave/net/socket.c	2006-06-27 10:40:35.000000000 -0700
@@ -396,6 +396,7 @@ static int sock_attach_fd(struct socket 
 {
 	struct qstr this;
 	char name[32];
+	int error;
 
 	this.len = sprintf(name, "[%lu]", SOCK_INODE(sock)->i_ino);
 	this.name = name;
@@ -416,6 +417,8 @@ static int sock_attach_fd(struct socket 
 	file->f_flags = O_RDWR;
 	file->f_pos = 0;
 	file->private_data = sock;
+	error = mnt_want_write(sock_mnt);
+	WARN_ON(error);
 
 	return 0;
 }
_
