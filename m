Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261433AbVB0QNa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261433AbVB0QNa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Feb 2005 11:13:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261432AbVB0QK0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Feb 2005 11:10:26 -0500
Received: from mail-ex.suse.de ([195.135.220.2]:28884 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261433AbVB0P44 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Feb 2005 10:56:56 -0500
Message-Id: <20050227152353.833100000@blunzn.suse.de>
References: <20050227152243.083308000@blunzn.suse.de>
Date: Sun, 27 Feb 2005 16:22:55 +0100
From: Andreas Gruenbacher <agruen@suse.de>
To: linux-kernel@vger.kernel.org, Neil Brown <neilb@cse.unsw.edu.au>,
       Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Olaf Kirch <okir@suse.de>, "Andries E. Brouwer" <Andries.Brouwer@cwi.nl>,
       Andrew Morton <akpm@osdl.org>
Subject: [patch 12/16] nfs mknod cleanup
Content-Disposition: inline; filename=nfs-cleanup_mknod.diff
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust <trond.myklebust@fys.uio.no> wrote:

[...] How about if we change the interfaces for NFS_PROTO()->mknod(), and
mkdir, so that they take a dentry argument instead of the struct qstr,
and then have them instantiate the dentry? The appended (untested) patch
tries to do this for mknod()...

Signed-off-by: Andreas Gruenbacher <agruen@suse.de>

Index: linux-2.6.11-rc5/fs/nfs/nfs3proc.c
===================================================================
--- linux-2.6.11-rc5.orig/fs/nfs/nfs3proc.c
+++ linux-2.6.11-rc5/fs/nfs/nfs3proc.c
@@ -639,23 +639,24 @@ nfs3_proc_readdir(struct dentry *dentry,
 }
 
 static int
-nfs3_proc_mknod(struct inode *dir, struct qstr *name, struct iattr *sattr,
-		dev_t rdev, struct nfs_fh *fh, struct nfs_fattr *fattr)
+nfs3_proc_mknod(struct inode *dir, struct dentry *dentry, struct iattr *sattr,
+		dev_t rdev)
 {
-	struct nfs_fattr	dir_attr;
+	struct nfs_fh fh;
+	struct nfs_fattr fattr, dir_attr;
 	struct nfs3_mknodargs	arg = {
 		.fh		= NFS_FH(dir),
-		.name		= name->name,
-		.len		= name->len,
+		.name		= dentry->d_name.name,
+		.len		= dentry->d_name.len,
 		.sattr		= sattr,
 		.rdev		= rdev
 	};
 	struct nfs3_diropres	res = {
 		.dir_attr	= &dir_attr,
-		.fh		= fh,
-		.fattr		= fattr
+		.fh		= &fh,
+		.fattr		= &fattr
 	};
-	int			status;
+	int status;
 
 	switch (sattr->ia_mode & S_IFMT) {
 	case S_IFBLK:	arg.type = NF3BLK;  break;
@@ -665,12 +666,14 @@ nfs3_proc_mknod(struct inode *dir, struc
 	default:	return -EINVAL;
 	}
 
-	dprintk("NFS call  mknod %s %u:%u\n", name->name,
+	dprintk("NFS call  mknod %s %u:%u\n", dentry->d_name.name,
 			MAJOR(rdev), MINOR(rdev));
 	dir_attr.valid = 0;
-	fattr->valid = 0;
+	fattr.valid = 0;
 	status = rpc_call(NFS_CLIENT(dir), NFS3PROC_MKNOD, &arg, &res, 0);
 	nfs_refresh_inode(dir, &dir_attr);
+	if (!status)
+		status = nfs_instantiate(dentry, &fh, &fattr);
 	dprintk("NFS reply mknod: %d\n", status);
 	return status;
 }
Index: linux-2.6.11-rc5/fs/nfs/nfs4proc.c
===================================================================
--- linux-2.6.11-rc5.orig/fs/nfs/nfs4proc.c
+++ linux-2.6.11-rc5/fs/nfs/nfs4proc.c
@@ -1641,22 +1641,23 @@ static int nfs4_proc_readdir(struct dent
 	return err;
 }
 
-static int _nfs4_proc_mknod(struct inode *dir, struct qstr *name,
-		struct iattr *sattr, dev_t rdev, struct nfs_fh *fh,
-		struct nfs_fattr *fattr)
+static int _nfs4_proc_mknod(struct inode *dir, struct dentry *dentry,
+		struct iattr *sattr, dev_t rdev)
 {
 	struct nfs_server *server = NFS_SERVER(dir);
+	struct nfs_fh fh;
+	struct nfs_fattr fattr;
 	struct nfs4_create_arg arg = {
 		.dir_fh = NFS_FH(dir),
 		.server = server,
-		.name = name,
+		.name = &dentry->d_name,
 		.attrs = sattr,
 		.bitmask = server->attr_bitmask,
 	};
 	struct nfs4_create_res res = {
 		.server = server,
-		.fh = fh,
-		.fattr = fattr,
+		.fh = &fh,
+		.fattr = &fattr,
 	};
 	struct rpc_message msg = {
 		.rpc_proc = &nfs4_procedures[NFSPROC4_CLNT_CREATE],
@@ -1666,7 +1667,7 @@ static int _nfs4_proc_mknod(struct inode
 	int			status;
 	int                     mode = sattr->ia_mode;
 
-	fattr->valid = 0;
+	fattr.valid = 0;
 
 	BUG_ON(!(sattr->ia_valid & ATTR_MODE));
 	BUG_ON(!S_ISFIFO(mode) && !S_ISBLK(mode) && !S_ISCHR(mode) && !S_ISSOCK(mode));
@@ -1688,19 +1689,19 @@ static int _nfs4_proc_mknod(struct inode
 	status = rpc_call_sync(NFS_CLIENT(dir), &msg, 0);
 	if (!status)
 		update_changeattr(dir, &res.dir_cinfo);
+	if (!status)
+		status = nfs_instantiate(dentry, &fh, &fattr);
 	return status;
 }
 
-static int nfs4_proc_mknod(struct inode *dir, struct qstr *name,
-		struct iattr *sattr, dev_t rdev, struct nfs_fh *fh,
-		struct nfs_fattr *fattr)
+static int nfs4_proc_mknod(struct inode *dir, struct dentry *dentry,
+		struct iattr *sattr, dev_t rdev)
 {
 	struct nfs4_exception exception = { };
 	int err;
 	do {
 		err = nfs4_handle_exception(NFS_SERVER(dir),
-				_nfs4_proc_mknod(dir, name, sattr, rdev,
-					fh, fattr),
+				_nfs4_proc_mknod(dir, dentry, sattr, rdev),
 				&exception);
 	} while (exception.retry);
 	return err;
Index: linux-2.6.11-rc5/fs/nfs/proc.c
===================================================================
--- linux-2.6.11-rc5.orig/fs/nfs/proc.c
+++ linux-2.6.11-rc5/fs/nfs/proc.c
@@ -248,22 +248,24 @@ nfs_proc_create(struct inode *dir, struc
  * In NFSv2, mknod is grafted onto the create call.
  */
 static int
-nfs_proc_mknod(struct inode *dir, struct qstr *name, struct iattr *sattr,
-	       dev_t rdev, struct nfs_fh *fhandle, struct nfs_fattr *fattr)
+nfs_proc_mknod(struct inode *dir, struct dentry *dentry, struct iattr *sattr,
+	       dev_t rdev)
 {
+	struct nfs_fh fhandle;
+	struct nfs_fattr fattr;
 	struct nfs_createargs	arg = {
 		.fh		= NFS_FH(dir),
-		.name		= name->name,
-		.len		= name->len,
+		.name		= dentry->d_name.name,
+		.len		= dentry->d_name.len,
 		.sattr		= sattr
 	};
 	struct nfs_diropok	res = {
-		.fh		= fhandle,
-		.fattr		= fattr
+		.fh		= &fhandle,
+		.fattr		= &fattr
 	};
-	int			status, mode;
+	int status, mode;
 
-	dprintk("NFS call  mknod %s\n", name->name);
+	dprintk("NFS call  mknod %s\n", dentry->d_name.name);
 
 	mode = sattr->ia_mode;
 	if (S_ISFIFO(mode)) {
@@ -274,14 +276,16 @@ nfs_proc_mknod(struct inode *dir, struct
 		sattr->ia_size = new_encode_dev(rdev);/* get out your barf bag */
 	}
 
-	fattr->valid = 0;
+	fattr.valid = 0;
 	status = rpc_call(NFS_CLIENT(dir), NFSPROC_CREATE, &arg, &res, 0);
 
 	if (status == -EINVAL && S_ISFIFO(mode)) {
 		sattr->ia_mode = mode;
-		fattr->valid = 0;
+		fattr.valid = 0;
 		status = rpc_call(NFS_CLIENT(dir), NFSPROC_CREATE, &arg, &res, 0);
 	}
+	if (!status)
+		status = nfs_instantiate(dentry, &fhandle, &fattr);
 	dprintk("NFS reply mknod: %d\n", status);
 	return status;
 }
Index: linux-2.6.11-rc5/fs/nfs/dir.c
===================================================================
--- linux-2.6.11-rc5.orig/fs/nfs/dir.c
+++ linux-2.6.11-rc5/fs/nfs/dir.c
@@ -988,7 +988,7 @@ int nfs_cached_lookup(struct inode *dir,
 /*
  * Code common to create, mkdir, and mknod.
  */
-static int nfs_instantiate(struct dentry *dentry, struct nfs_fh *fhandle,
+int nfs_instantiate(struct dentry *dentry, struct nfs_fh *fhandle,
 				struct nfs_fattr *fattr)
 {
 	struct inode *inode;
@@ -1075,9 +1075,7 @@ static int
 nfs_mknod(struct inode *dir, struct dentry *dentry, int mode, dev_t rdev)
 {
 	struct iattr attr;
-	struct nfs_fattr fattr;
-	struct nfs_fh fhandle;
-	int error;
+	int status;
 
 	dfprintk(VFS, "NFS: mknod(%s/%ld, %s\n", dir->i_sb->s_id,
 		dir->i_ino, dentry->d_name.name);
@@ -1090,15 +1088,12 @@ nfs_mknod(struct inode *dir, struct dent
 
 	lock_kernel();
 	nfs_begin_data_update(dir);
-	error = NFS_PROTO(dir)->mknod(dir, &dentry->d_name, &attr, rdev,
-					&fhandle, &fattr);
+	status = NFS_PROTO(dir)->mknod(dir, dentry, &attr, rdev);
 	nfs_end_data_update(dir);
-	if (!error)
-		error = nfs_instantiate(dentry, &fhandle, &fattr);
-	else
+	if (status)
 		d_drop(dentry);
 	unlock_kernel();
-	return error;
+	return status;
 }
 
 /*
Index: linux-2.6.11-rc5/include/linux/nfs_xdr.h
===================================================================
--- linux-2.6.11-rc5.orig/include/linux/nfs_xdr.h
+++ linux-2.6.11-rc5/include/linux/nfs_xdr.h
@@ -698,8 +698,8 @@ struct nfs_rpc_ops {
 	int	(*rmdir)   (struct inode *, struct qstr *);
 	int	(*readdir) (struct dentry *, struct rpc_cred *,
 			    u64, struct page *, unsigned int, int);
-	int	(*mknod)   (struct inode *, struct qstr *, struct iattr *,
-			    dev_t, struct nfs_fh *, struct nfs_fattr *);
+	int	(*mknod)   (struct inode *, struct dentry *, struct iattr *,
+			    dev_t);
 	int	(*statfs)  (struct nfs_server *, struct nfs_fh *,
 			    struct nfs_fsstat *);
 	int	(*fsinfo)  (struct nfs_server *, struct nfs_fh *,
Index: linux-2.6.11-rc5/include/linux/nfs_fs.h
===================================================================
--- linux-2.6.11-rc5.orig/include/linux/nfs_fs.h
+++ linux-2.6.11-rc5/include/linux/nfs_fs.h
@@ -349,6 +349,8 @@ extern struct inode_operations nfs_dir_i
 extern struct file_operations nfs_dir_operations;
 extern struct dentry_operations nfs_dentry_operations;
 
+extern int nfs_instantiate(struct dentry *dentry, struct nfs_fh *fh, struct nfs_fattr *fattr);
+
 /*
  * linux/fs/nfs/symlink.c
  */

--
Andreas Gruenbacher <agruen@suse.de>
SUSE Labs, SUSE LINUX PRODUCTS GMBH

