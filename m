Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261429AbVB0QSq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261429AbVB0QSq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Feb 2005 11:18:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261439AbVB0QSo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Feb 2005 11:18:44 -0500
Received: from ns.suse.de ([195.135.220.2]:30676 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261429AbVB0P45 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Feb 2005 10:56:57 -0500
Message-Id: <20050227152355.081130000@blunzn.suse.de>
References: <20050227152243.083308000@blunzn.suse.de>
Date: Sun, 27 Feb 2005 16:22:58 +0100
From: Andreas Gruenbacher <agruen@suse.de>
To: linux-kernel@vger.kernel.org, Neil Brown <neilb@cse.unsw.edu.au>,
       Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Olaf Kirch <okir@suse.de>, "Andries E. Brouwer" <Andries.Brouwer@cwi.nl>,
       Andrew Morton <akpm@osdl.org>
Subject: [patch 15/16] ACL umask handling workaround in nfs client
Content-Disposition: inline; filename=nfsacl-acl-umask-handling-workaround-in-nfs-client-2.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

NFSv3 has no concept of a umask on the server side: The client applies
the umask locally, and sends the effective permissions to the server.
This behavior is wrong when files are created in a directory that has a
default ACL.  In this case, the umask is supposed to be ignored, and
only the default ACL determines the file's effective permissions.

Usually its the server's task to conditionally apply the umask.  But
since the server knows nothing about the umask, we have to do it on the
client side.  This patch tries to fetch the parent directory's default
ACL before creating a new file, computes the appropriate create mode to
send to the server, and finally sets the new file's access and default
acl appropriately.

Many thanks to Buck Huppmann <buchk@pobox.com> for sending the initial
version of this patch, as well as for arguing why we need this change.

Signed-off-by: Andreas Gruenbacher <agruen@suse.de>
Acked-by: Olaf Kirch <okir@suse.de>

Index: linux-2.6.11-rc5/fs/nfs/nfs3proc.c
===================================================================
--- linux-2.6.11-rc5.orig/fs/nfs/nfs3proc.c
+++ linux-2.6.11-rc5/fs/nfs/nfs3proc.c
@@ -292,6 +292,38 @@ static int nfs3_proc_commit(struct nfs_w
 	return status;
 }
 
+static int nfs3_set_default_acl(struct inode *dir, struct inode *inode,
+				mode_t mode)
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
  * Create a regular file.
  * For now, we don't implement O_EXCL.
@@ -314,8 +346,12 @@ nfs3_proc_create(struct inode *dir, stru
 		.fh		= &fhandle,
 		.fattr		= &fattr
 	};
+	mode_t			mode;
 	int			status;
 
+	mode = sattr->ia_mode;
+	sattr->ia_mode &= ~current->fs->umask;
+
 	dprintk("NFS call  create %s\n", name->name);
 	arg.createmode = NFS3_CREATE_UNCHECKED;
 	if (flags & O_EXCL) {
@@ -350,7 +386,6 @@ again:
 
 exit:
 	dprintk("NFS reply create: %d\n", status);
-
 	if (status != 0)
 		goto out;
 	if (fhandle.size == 0 || !(fattr.valid & NFS_ATTR_FATTR)) {
@@ -384,9 +419,10 @@ exit:
 	if (status == 0) {
 		struct inode *inode;
 		inode = nfs_fhget(dir->i_sb, &fhandle, &fattr);
-		if (inode)
-			return inode;
 		status = -ENOMEM;
+		if (!inode)
+			goto out;
+		status = nfs3_set_default_acl(dir, inode, mode);
 	}
 out:
 	return ERR_PTR(status);
@@ -556,8 +592,12 @@ nfs3_proc_mkdir(struct inode *dir, struc
 		.fh		= &fh,
 		.fattr		= &fattr
 	};
+	mode_t mode;
 	int status;
 
+	mode = sattr->ia_mode;
+	sattr->ia_mode &= ~current->fs->umask;
+
 	dprintk("NFS call  mkdir %s\n", dentry->d_name.name);
 	dir_attr.valid = 0;
 	fattr.valid = 0;
@@ -566,6 +606,8 @@ nfs3_proc_mkdir(struct inode *dir, struc
 	if (!status)
 		status = nfs_instantiate(dentry, &fh, &fattr);
 	dprintk("NFS reply mkdir: %d\n", status);
+	if (!status)
+		status = nfs3_set_default_acl(dir, dentry->d_inode, mode);
 	return status;
 }
 
@@ -659,6 +701,7 @@ nfs3_proc_mknod(struct inode *dir, struc
 		.fh		= &fh,
 		.fattr		= &fattr
 	};
+	mode_t mode;
 	int status;
 
 	switch (sattr->ia_mode & S_IFMT) {
@@ -669,6 +712,9 @@ nfs3_proc_mknod(struct inode *dir, struc
 	default:	return -EINVAL;
 	}
 
+	mode = sattr->ia_mode;
+	sattr->ia_mode &= ~current->fs->umask;
+
 	dprintk("NFS call  mknod %s %u:%u\n", dentry->d_name.name,
 			MAJOR(rdev), MINOR(rdev));
 	dir_attr.valid = 0;
@@ -678,6 +724,8 @@ nfs3_proc_mknod(struct inode *dir, struc
 	if (!status)
 		status = nfs_instantiate(dentry, &fh, &fattr);
 	dprintk("NFS reply mknod: %d\n", status);
+	if (!status)
+		status = nfs3_set_default_acl(dir, dentry->d_inode, mode);
 	return status;
 }
 
Index: linux-2.6.11-rc5/fs/nfs/inode.c
===================================================================
--- linux-2.6.11-rc5.orig/fs/nfs/inode.c
+++ linux-2.6.11-rc5/fs/nfs/inode.c
@@ -485,6 +485,8 @@ nfs_fill_super(struct super_block *sb, s
 		server->client_acl = clnt;
 		/* Initially assume the nfsacl program is supported */
 		server->flags |= NFSACL;
+		/* The nfs client applies the umask itself when needed. */
+		sb->s_flags |= MS_POSIXACL;
 	}
 #endif
 	if (server->flags & NFS_MOUNT_VER3) {

--
Andreas Gruenbacher <agruen@suse.de>
SUSE Labs, SUSE LINUX PRODUCTS GMBH

