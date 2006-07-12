Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932425AbWGLSUK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932425AbWGLSUK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 14:20:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932383AbWGLSRp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 14:17:45 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:58290 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932382AbWGLSRb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 14:17:31 -0400
Subject: [RFC][PATCH 22/27] sys_mknodat(): elevate write count for vfs_mknod/create()
To: viro@ftp.linux.org.uk
Cc: serue@us.ibm.com, linux-kernel@vger.kernel.org,
       Dave Hansen <haveblue@us.ibm.com>
From: Dave Hansen <haveblue@us.ibm.com>
Date: Wed, 12 Jul 2006 11:17:25 -0700
References: <20060712181709.5C1A4353@localhost.localdomain>
In-Reply-To: <20060712181709.5C1A4353@localhost.localdomain>
Message-Id: <20060712181725.C28CC70F@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This takes care of all of the direct callers of vfs_mknod().
Since a few of these cases also handle normal file creation
as well, this also covers some calls to vfs_create().

Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
---

 lxc-dave/fs/namei.c         |   12 ++++++++++++
 lxc-dave/fs/nfsd/vfs.c      |    4 ++++
 lxc-dave/net/unix/af_unix.c |    4 ++++
 3 files changed, 20 insertions(+)

diff -puN fs/namei.c~C-elevate-writers-vfs_mknod-try2 fs/namei.c
--- lxc/fs/namei.c~C-elevate-writers-vfs_mknod-try2	2006-07-12 11:09:34.000000000 -0700
+++ lxc-dave/fs/namei.c	2006-07-12 11:09:39.000000000 -0700
@@ -1879,14 +1879,26 @@ asmlinkage long sys_mknodat(int dfd, con
 	if (!IS_ERR(dentry)) {
 		switch (mode & S_IFMT) {
 		case 0: case S_IFREG:
+			error = mnt_want_write(nd.mnt);
+			if (error)
+				break;
 			error = vfs_create(nd.dentry->d_inode,dentry,mode,&nd);
+			mnt_drop_write(nd.mnt);
 			break;
 		case S_IFCHR: case S_IFBLK:
+			error = mnt_want_write(nd.mnt);
+			if (error)
+				break;
 			error = vfs_mknod(nd.dentry->d_inode,dentry,mode,
 					new_decode_dev(dev));
+			mnt_drop_write(nd.mnt);
 			break;
 		case S_IFIFO: case S_IFSOCK:
+			error = mnt_want_write(nd.mnt);
+			if (error)
+				break;
 			error = vfs_mknod(nd.dentry->d_inode,dentry,mode,0);
+			mnt_drop_write(nd.mnt);
 			break;
 		case S_IFDIR:
 			error = -EPERM;
diff -puN fs/nfsd/vfs.c~C-elevate-writers-vfs_mknod-try2 fs/nfsd/vfs.c
--- lxc/fs/nfsd/vfs.c~C-elevate-writers-vfs_mknod-try2	2006-07-12 11:09:34.000000000 -0700
+++ lxc-dave/fs/nfsd/vfs.c	2006-07-12 11:09:39.000000000 -0700
@@ -1155,6 +1155,9 @@ nfsd_create(struct svc_rqst *rqstp, stru
 	/*
 	 * Get the dir op function pointer.
 	 */
+	err = mnt_want_write(fhp->fh_export->ex_mnt);
+	if (err)
+		goto out_nfserr;
 	err = nfserr_perm;
 	switch (type) {
 	case S_IFREG:
@@ -1173,6 +1176,7 @@ nfsd_create(struct svc_rqst *rqstp, stru
 	        printk("nfsd: bad file type %o in nfsd_create\n", type);
 		err = -EINVAL;
 	}
+	mnt_drop_write(fhp->fh_export->ex_mnt);
 	if (err < 0)
 		goto out_nfserr;
 
diff -puN net/unix/af_unix.c~C-elevate-writers-vfs_mknod-try2 net/unix/af_unix.c
--- lxc/net/unix/af_unix.c~C-elevate-writers-vfs_mknod-try2	2006-07-12 11:09:33.000000000 -0700
+++ lxc-dave/net/unix/af_unix.c	2006-07-12 11:09:39.000000000 -0700
@@ -822,7 +822,11 @@ static int unix_bind(struct socket *sock
 		 */
 		mode = S_IFSOCK |
 		       (SOCK_INODE(sock)->i_mode & ~current->fs->umask);
+		err = mnt_want_write(nd.mnt);
+		if (err)
+			goto out_mknod_dput;
 		err = vfs_mknod(nd.dentry->d_inode, dentry, mode, 0);
+		mnt_drop_write(nd.mnt);
 		if (err)
 			goto out_mknod_dput;
 		mutex_unlock(&nd.dentry->d_inode->i_mutex);
_
