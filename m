Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261460AbVB0QIf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261460AbVB0QIf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Feb 2005 11:08:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261455AbVB0QHf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Feb 2005 11:07:35 -0500
Received: from cantor.suse.de ([195.135.220.2]:28628 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261432AbVB0P44 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Feb 2005 10:56:56 -0500
Message-Id: <20050227152354.443703000@blunzn.suse.de>
References: <20050227152243.083308000@blunzn.suse.de>
Date: Sun, 27 Feb 2005 16:22:56 +0100
From: Andreas Gruenbacher <agruen@suse.de>
To: linux-kernel@vger.kernel.org, Neil Brown <neilb@cse.unsw.edu.au>,
       Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Olaf Kirch <okir@suse.de>, "Andries E. Brouwer" <Andries.Brouwer@cwi.nl>,
       Andrew Morton <akpm@osdl.org>
Subject: [patch 13/16] nfs mkdir cleanup
Content-Disposition: inline; filename=nfs-cleanup_mkdir.diff
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
@@ -540,28 +540,30 @@ nfs3_proc_symlink(struct inode *dir, str
 }
 
 static int
-nfs3_proc_mkdir(struct inode *dir, struct qstr *name, struct iattr *sattr,
-		struct nfs_fh *fhandle, struct nfs_fattr *fattr)
+nfs3_proc_mkdir(struct inode *dir, struct dentry *dentry, struct iattr *sattr)
 {
-	struct nfs_fattr	dir_attr;
+	struct nfs_fattr	fattr, dir_attr;
+	struct nfs_fh fh;
 	struct nfs3_mkdirargs	arg = {
 		.fh		= NFS_FH(dir),
-		.name		= name->name,
-		.len		= name->len,
+		.name		= dentry->d_name.name,
+		.len		= dentry->d_name.len,
 		.sattr		= sattr
 	};
 	struct nfs3_diropres	res = {
 		.dir_attr	= &dir_attr,
-		.fh		= fhandle,
-		.fattr		= fattr
+		.fh		= &fh,
+		.fattr		= &fattr
 	};
-	int			status;
+	int status;
 
-	dprintk("NFS call  mkdir %s\n", name->name);
+	dprintk("NFS call  mkdir %s\n", dentry->d_name.name);
 	dir_attr.valid = 0;
-	fattr->valid = 0;
+	fattr.valid = 0;
 	status = rpc_call(NFS_CLIENT(dir), NFS3PROC_MKDIR, &arg, &res, 0);
 	nfs_refresh_inode(dir, &dir_attr);
+	if (!status)
+		status = nfs_instantiate(dentry, &fh, &fattr);
 	dprintk("NFS reply mkdir: %d\n", status);
 	return status;
 }
Index: linux-2.6.11-rc5/fs/nfs/nfs4proc.c
===================================================================
--- linux-2.6.11-rc5.orig/fs/nfs/nfs4proc.c
+++ linux-2.6.11-rc5/fs/nfs/nfs4proc.c
@@ -1550,49 +1550,50 @@ static int nfs4_proc_symlink(struct inod
 	return err;
 }
 
-static int _nfs4_proc_mkdir(struct inode *dir, struct qstr *name,
-		struct iattr *sattr, struct nfs_fh *fhandle,
-		struct nfs_fattr *fattr)
+static int _nfs4_proc_mkdir(struct inode *dir, struct dentry *dentry,
+		struct iattr *sattr)
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
 		.ftype = NF4DIR,
 		.bitmask = server->attr_bitmask,
 	};
 	struct nfs4_create_res res = {
 		.server = server,
-		.fh = fhandle,
-		.fattr = fattr,
+		.fh = &fh,
+		.fattr = &fattr,
 	};
 	struct rpc_message msg = {
 		.rpc_proc = &nfs4_procedures[NFSPROC4_CLNT_CREATE],
 		.rpc_argp = &arg,
 		.rpc_resp = &res,
 	};
-	int			status;
+	int status;
 
-	fattr->valid = 0;
+	fattr.valid = 0;
 	
 	status = rpc_call_sync(NFS_CLIENT(dir), &msg, 0);
-	if (!status)
+	if (!status) {
 		update_changeattr(dir, &res.dir_cinfo);
+		status = nfs_instantiate(dentry, &fh, &fattr);
+	}
 	return status;
 }
 
-static int nfs4_proc_mkdir(struct inode *dir, struct qstr *name,
-		struct iattr *sattr, struct nfs_fh *fhandle,
-		struct nfs_fattr *fattr)
+static int nfs4_proc_mkdir(struct inode *dir, struct dentry *dentry,
+		struct iattr *sattr)
 {
 	struct nfs4_exception exception = { };
 	int err;
 	do {
 		err = nfs4_handle_exception(NFS_SERVER(dir),
-				_nfs4_proc_mkdir(dir, name, sattr,
-					fhandle, fattr),
+				_nfs4_proc_mkdir(dir, dentry, sattr),
 				&exception);
 	} while (exception.retry);
 	return err;
Index: linux-2.6.11-rc5/fs/nfs/proc.c
===================================================================
--- linux-2.6.11-rc5.orig/fs/nfs/proc.c
+++ linux-2.6.11-rc5/fs/nfs/proc.c
@@ -402,24 +402,27 @@ nfs_proc_symlink(struct inode *dir, stru
 }
 
 static int
-nfs_proc_mkdir(struct inode *dir, struct qstr *name, struct iattr *sattr,
-	       struct nfs_fh *fhandle, struct nfs_fattr *fattr)
+nfs_proc_mkdir(struct inode *dir, struct dentry *dentry, struct iattr *sattr)
 {
+	struct nfs_fh fh;
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
+		.fh		= &fh,
+		.fattr		= &fattr
 	};
 	int			status;
 
-	dprintk("NFS call  mkdir %s\n", name->name);
-	fattr->valid = 0;
+	dprintk("NFS call  mkdir %s\n", dentry->d_name.name);
+	fattr.valid = 0;
 	status = rpc_call(NFS_CLIENT(dir), NFSPROC_MKDIR, &arg, &res, 0);
+	if (!status)
+		status = nfs_instantiate(dentry, &fh, &fattr);
 	dprintk("NFS reply mkdir: %d\n", status);
 	return status;
 }
Index: linux-2.6.11-rc5/fs/nfs/dir.c
===================================================================
--- linux-2.6.11-rc5.orig/fs/nfs/dir.c
+++ linux-2.6.11-rc5/fs/nfs/dir.c
@@ -1102,9 +1102,7 @@ nfs_mknod(struct inode *dir, struct dent
 static int nfs_mkdir(struct inode *dir, struct dentry *dentry, int mode)
 {
 	struct iattr attr;
-	struct nfs_fattr fattr;
-	struct nfs_fh fhandle;
-	int error;
+	int status;
 
 	dfprintk(VFS, "NFS: mkdir(%s/%ld, %s\n", dir->i_sb->s_id,
 		dir->i_ino, dentry->d_name.name);
@@ -1123,15 +1121,12 @@ static int nfs_mkdir(struct inode *dir, 
 	d_drop(dentry);
 #endif
 	nfs_begin_data_update(dir);
-	error = NFS_PROTO(dir)->mkdir(dir, &dentry->d_name, &attr, &fhandle,
-					&fattr);
+	status = NFS_PROTO(dir)->mkdir(dir, dentry, &attr);
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
 
 static int nfs_rmdir(struct inode *dir, struct dentry *dentry)
Index: linux-2.6.11-rc5/include/linux/nfs_xdr.h
===================================================================
--- linux-2.6.11-rc5.orig/include/linux/nfs_xdr.h
+++ linux-2.6.11-rc5/include/linux/nfs_xdr.h
@@ -693,8 +693,7 @@ struct nfs_rpc_ops {
 	int	(*symlink) (struct inode *, struct qstr *, struct qstr *,
 			    struct iattr *, struct nfs_fh *,
 			    struct nfs_fattr *);
-	int	(*mkdir)   (struct inode *, struct qstr *, struct iattr *,
-			    struct nfs_fh *, struct nfs_fattr *);
+	int	(*mkdir)   (struct inode *, struct dentry *, struct iattr *);
 	int	(*rmdir)   (struct inode *, struct qstr *);
 	int	(*readdir) (struct dentry *, struct rpc_cred *,
 			    u64, struct page *, unsigned int, int);

--
Andreas Gruenbacher <agruen@suse.de>
SUSE Labs, SUSE LINUX PRODUCTS GMBH

