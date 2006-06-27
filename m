Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422670AbWF0WTv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422670AbWF0WTv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 18:19:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422667AbWF0WTt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 18:19:49 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:25784 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030451AbWF0WOx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 18:14:53 -0400
Subject: [PATCH 07/20] elevate mount count for extended attributes
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, herbert@13thfloor.at, viro@ftp.linux.org.uk,
       serue@us.ibm.com, Dave Hansen <haveblue@us.ibm.com>
From: Dave Hansen <haveblue@us.ibm.com>
Date: Tue, 27 Jun 2006 15:14:46 -0700
References: <20060627221436.77CCB048@localhost.localdomain>
In-Reply-To: <20060627221436.77CCB048@localhost.localdomain>
Message-Id: <20060627221446.77788715@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This basically audits the callers of xattr_permission(), which
calls permission() and can perform writes to the filesystem.

Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
---

 lxc-dave/fs/nfsd/nfs4proc.c |    7 ++++++-
 lxc-dave/fs/xattr.c         |   14 ++++++++++++++
 2 files changed, 20 insertions(+), 1 deletion(-)

diff -puN fs/nfsd/nfs4proc.c~C-xattr fs/nfsd/nfs4proc.c
--- lxc/fs/nfsd/nfs4proc.c~C-xattr	2006-06-27 10:40:28.000000000 -0700
+++ lxc-dave/fs/nfsd/nfs4proc.c	2006-06-27 10:40:28.000000000 -0700
@@ -604,13 +604,18 @@ nfsd4_setattr(struct svc_rqst *rqstp, st
 			return status;
 		}
 	}
+	status = mnt_want_write(current_fh->fh_export->ex_mnt);
+	if (status)
+		return status;
 	status = nfs_ok;
 	if (setattr->sa_acl != NULL)
 		status = nfsd4_set_nfs4_acl(rqstp, current_fh, setattr->sa_acl);
 	if (status)
-		return status;
+		goto out;
 	status = nfsd_setattr(rqstp, current_fh, &setattr->sa_iattr,
 				0, (time_t)0);
+out:
+	mnt_drop_write(current_fh->fh_export->ex_mnt);
 	return status;
 }
 
diff -puN fs/xattr.c~C-xattr fs/xattr.c
--- lxc/fs/xattr.c~C-xattr	2006-06-27 10:40:28.000000000 -0700
+++ lxc-dave/fs/xattr.c	2006-06-27 10:40:28.000000000 -0700
@@ -12,6 +12,7 @@
 #include <linux/smp_lock.h>
 #include <linux/file.h>
 #include <linux/xattr.h>
+#include <linux/mount.h>
 #include <linux/namei.h>
 #include <linux/security.h>
 #include <linux/syscalls.h>
@@ -210,7 +211,11 @@ sys_setxattr(char __user *path, char __u
 	error = user_path_walk(path, &nd);
 	if (error)
 		return error;
+	error = mnt_want_write(nd.mnt);
+	if (error)
+		return error;
 	error = setxattr(nd.dentry, name, value, size, flags);
+	mnt_drop_write(nd.mnt);
 	path_release(&nd);
 	return error;
 }
@@ -225,7 +230,11 @@ sys_lsetxattr(char __user *path, char __
 	error = user_path_walk_link(path, &nd);
 	if (error)
 		return error;
+	error = mnt_want_write(nd.mnt);
+	if (error)
+		return error;
 	error = setxattr(nd.dentry, name, value, size, flags);
+	mnt_drop_write(nd.mnt);
 	path_release(&nd);
 	return error;
 }
@@ -241,9 +250,14 @@ sys_fsetxattr(int fd, char __user *name,
 	f = fget(fd);
 	if (!f)
 		return error;
+	error = mnt_want_write(f->f_vfsmnt);
+	if (error)
+		goto out_fput;
 	dentry = f->f_dentry;
 	audit_inode(NULL, dentry->d_inode);
 	error = setxattr(dentry, name, value, size, flags);
+	mnt_drop_write(f->f_vfsmnt);
+out_fput:
 	fput(f);
 	return error;
 }
_
