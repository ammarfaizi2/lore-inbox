Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262741AbVAVU6f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262741AbVAVU6f (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jan 2005 15:58:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262740AbVAVU6U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jan 2005 15:58:20 -0500
Received: from mail.suse.de ([195.135.220.2]:50384 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262741AbVAVUeb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jan 2005 15:34:31 -0500
Message-Id: <20050122203620.108564000@blunzn.suse.de>
References: <20050122203326.402087000@blunzn.suse.de>
Date: Sat, 22 Jan 2005 21:34:12 +0100
From: Andreas Gruenbacher <agruen@suse.de>
To: linux-kernel@vger.kernel.org, Neil Brown <neilb@cse.unsw.edu.au>,
       Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Olaf Kirch <okir@suse.de>, "Andries E. Brouwer" <Andries.Brouwer@cwi.nl>,
       Buck Huppmann <buchk@pobox.com>, Andrew Morton <akpm@osdl.org>
Subject: [patch 12/13] ACL umask handling workaround in nfs client
Content-Disposition: inline; filename=patches.suse/nfsacl-umask.diff
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

NFSv3 has no concept of a umask on the server side: The client applies
the umask locally, and sends the effective permissions to the server.
This behavior is wrong when files are created in a directory that has
a default ACL. In this case, the umask is supposed to be ignored, and
only the default ACL determines the file's effective permissions.

Usually its the server's task to conditionally apply the umask. But
since the server knows nothing about the umask, we have to do it on the
client side. This patch tries to fetch the parent directory's default
ACL before creating a new file, computes the appropriate create mode to
send to the server, and finally sets the new file's access and default
acl appropriately.

Many thanks to Buck Huppmann <buchk@pobox.com> for sending the initial
version of this patch, as well as for arguing why we need this change.

Signed-off-by: Andreas Gruenbacher <agruen@suse.de>
Acked-by: Olaf Kirch <okir@suse.de>

Index: linux-2.6.11-rc2/fs/nfs/dir.c
===================================================================
--- linux-2.6.11-rc2.orig/fs/nfs/dir.c
+++ linux-2.6.11-rc2/fs/nfs/dir.c
@@ -31,6 +31,7 @@
 #include <linux/pagemap.h>
 #include <linux/smp_lock.h>
 #include <linux/namei.h>
+#include <linux/posix_acl.h>
 
 #include "delegation.h"
 
@@ -976,6 +977,38 @@ out_err:
 	return error;
 }
 
+static int nfs_set_default_acl(struct inode *dir, struct inode *inode,
+			       mode_t mode)
+{
+#ifdef CONFIG_NFS_ACL
+	struct posix_acl *dfacl, *acl;
+	int error = 0;
+
+	dfacl = NFS_PROTO(dir)->getacl(dir, ACL_TYPE_DEFAULT);
+	if (IS_ERR(dfacl)) {
+		error = PTR_ERR(dfacl);
+		return (error == -EOPNOTSUPP) ? 0 : error;
+	}
+	if (!dfacl)
+		return 0;
+	acl = posix_acl_clone(dfacl, GFP_KERNEL);
+	error = -ENOMEM;
+	if (!acl)
+		goto out;
+	error = posix_acl_create_masq(acl, &mode);
+	if (error < 0)
+		goto out;
+	error = NFS_PROTO(inode)->setacls(inode, acl, S_ISDIR(inode->i_mode) ?
+						      dfacl : NULL);
+out:
+	posix_acl_release(acl);
+	posix_acl_release(dfacl);
+	return error;
+#else
+	return 0;
+#endif
+}
+
 /*
  * Following a failed create operation, we drop the dentry rather
  * than retain a negative dentry. This avoids a problem in the event
@@ -993,7 +1026,7 @@ static int nfs_create(struct inode *dir,
 	dfprintk(VFS, "NFS: create(%s/%ld, %s\n", dir->i_sb->s_id, 
 		dir->i_ino, dentry->d_name.name);
 
-	attr.ia_mode = mode;
+	attr.ia_mode = mode & ~current->fs->umask;
 	attr.ia_valid = ATTR_MODE;
 
 	if (nd && (nd->flags & LOOKUP_CREATE))
@@ -1007,7 +1040,7 @@ static int nfs_create(struct inode *dir,
 		d_instantiate(dentry, inode);
 		nfs_renew_times(dentry);
 		nfs_set_verifier(dentry, nfs_save_change_attribute(dir));
-		error = 0;
+		error = nfs_set_default_acl(dir, inode, mode);
 	} else {
 		error = PTR_ERR(inode);
 		d_drop(dentry);
@@ -1033,7 +1066,7 @@ nfs_mknod(struct inode *dir, struct dent
 	if (!new_valid_dev(rdev))
 		return -EINVAL;
 
-	attr.ia_mode = mode;
+	attr.ia_mode = mode & ~current->fs->umask;
 	attr.ia_valid = ATTR_MODE;
 
 	lock_kernel();
@@ -1045,6 +1078,8 @@ nfs_mknod(struct inode *dir, struct dent
 		error = nfs_instantiate(dentry, &fhandle, &fattr);
 	else
 		d_drop(dentry);
+	if (!error)
+		error = nfs_set_default_acl(dir, dentry->d_inode, mode);
 	unlock_kernel();
 	return error;
 }
@@ -1063,7 +1098,7 @@ static int nfs_mkdir(struct inode *dir, 
 		dir->i_ino, dentry->d_name.name);
 
 	attr.ia_valid = ATTR_MODE;
-	attr.ia_mode = mode | S_IFDIR;
+	attr.ia_mode = (mode & ~current->fs->umask) | S_IFDIR;
 
 	lock_kernel();
 #if 0
@@ -1083,6 +1118,8 @@ static int nfs_mkdir(struct inode *dir, 
 		error = nfs_instantiate(dentry, &fhandle, &fattr);
 	else
 		d_drop(dentry);
+	if (!error)
+		error = nfs_set_default_acl(dir, dentry->d_inode, mode);
 	unlock_kernel();
 	return error;
 }
Index: linux-2.6.11-rc2/fs/nfs/inode.c
===================================================================
--- linux-2.6.11-rc2.orig/fs/nfs/inode.c
+++ linux-2.6.11-rc2/fs/nfs/inode.c
@@ -1494,6 +1494,8 @@ static struct super_block *nfs_get_sb(st
 		return ERR_PTR(error);
 	}
 	s->s_flags |= MS_ACTIVE;
+	/* The nfs client applies the umask itself when needed. */
+	s->s_flags |= MS_POSIXACL;
 	return s;
 }
 

--
Andreas Gruenbacher <agruen@suse.de>
SUSE Labs, SUSE LINUX PRODUCTS GMBH

