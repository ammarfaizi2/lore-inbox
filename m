Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261206AbVBVRoo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261206AbVBVRoo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 12:44:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261175AbVBVRon
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 12:44:43 -0500
Received: from pat.uio.no ([129.240.130.16]:39891 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S261203AbVBVRnZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 12:43:25 -0500
Subject: Re: [patch 12/13] ACL umask handling workaround in nfs client
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Andreas Gruenbacher <agruen@suse.de>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Neil Brown <neilb@cse.unsw.edu.au>, Olaf Kirch <okir@suse.de>,
       "Andries E. Brouwer" <Andries.Brouwer@cwi.nl>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <1109090843.6102.443.camel@winden.suse.de>
References: <20050122203326.402087000@blunzn.suse.de>
	 <20050122203620.108564000@blunzn.suse.de>
	 <1108490682.10073.57.camel@lade.trondhjem.org>
	 <1109090843.6102.443.camel@winden.suse.de>
Content-Type: multipart/mixed; boundary="=-fcfpxL0xCQpWBmv6MSrx"
Date: Tue, 22 Feb 2005 12:43:16 -0500
Message-Id: <1109094196.18411.23.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning
X-UiO-MailScanner: No virus found
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.396, required 12,
	autolearn=disabled, AWL 1.60, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-fcfpxL0xCQpWBmv6MSrx
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

ty den 22.02.2005 Klokka 17:47 (+0100) skreiv Andreas Gruenbacher:

> See attached patch.
> 

It would be very nice if we could rather hide the calls to
nfs_set_default_acl() inside nfs3_proc_create(), nfs3_proc_mknod() and
nfs3_proc-mkdir(). Besides avoiding the need for the wrapper functions,
that also means that all calls to ->mknod(), ->mkdir() and ->create()
are guaranteed to do the right thing.

How about if we change the interfaces for NFS_PROTO()->mknod(), and
mkdir, so that they take a dentry argument instead of the struct qstr,
and then have them instantiate the dentry? The appended (untested) patch
tries to do this for mknod()...
(This is a cleanup we have pretty much already done for ->create() BTW)

> Well, everything but the umask is always correct; that is guaranteed by
> the server. The initial create sets permissions that may be more
> restrictive than necessary, and then the SETACL RPC sets up the final,
> correct permissions. I don't believe that a race-free solution is
> possible.

If the permissions are guaranteed always to be more restrictive, then
that's OK (in fact the NFS protocol mandates that we do something
similar when it comes to O_EXCL opens).
I just wanted to be sure this was indeed the case.

Cheers,
  Trond

-- 
Trond Myklebust <trond.myklebust@fys.uio.no>

--=-fcfpxL0xCQpWBmv6MSrx
Content-Disposition: inline; filename=linux-2.6.11-cleanup_mknod.dif
Content-Type: text/plain; name=linux-2.6.11-cleanup_mknod.dif; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

 fs/nfs/dir.c            |   20 +++++++++-----------
 fs/nfs/nfs3proc.c       |   23 +++++++++++++----------
 fs/nfs/nfs4proc.c       |   25 +++++++++++++------------
 fs/nfs/proc.c           |   24 ++++++++++++++----------
 include/linux/nfs_fs.h  |    2 ++
 include/linux/nfs_xdr.h |    4 ++--
 6 files changed, 53 insertions(+), 45 deletions(-)

Index: linux-2.6.11-rc4/fs/nfs/nfs3proc.c
===================================================================
--- linux-2.6.11-rc4.orig/fs/nfs/nfs3proc.c
+++ linux-2.6.11-rc4/fs/nfs/nfs3proc.c
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
+		.len		= dentry->name.len,
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
+	if (status == 0)
+		status = nfs_instantiate(dentry, &fh, &fattr);
 	dprintk("NFS reply mknod: %d\n", status);
 	return status;
 }
Index: linux-2.6.11-rc4/fs/nfs/nfs4proc.c
===================================================================
--- linux-2.6.11-rc4.orig/fs/nfs/nfs4proc.c
+++ linux-2.6.11-rc4/fs/nfs/nfs4proc.c
@@ -1630,22 +1630,23 @@ static int nfs4_proc_readdir(struct dent
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
@@ -1655,7 +1656,7 @@ static int _nfs4_proc_mknod(struct inode
 	int			status;
 	int                     mode = sattr->ia_mode;
 
-	fattr->valid = 0;
+	fattr.valid = 0;
 
 	BUG_ON(!(sattr->ia_valid & ATTR_MODE));
 	BUG_ON(!S_ISFIFO(mode) && !S_ISBLK(mode) && !S_ISCHR(mode) && !S_ISSOCK(mode));
@@ -1677,19 +1678,19 @@ static int _nfs4_proc_mknod(struct inode
 	status = rpc_call_sync(NFS_CLIENT(dir), &msg, 0);
 	if (!status)
 		update_changeattr(dir, &res.dir_cinfo);
+	if (status == 0)
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
Index: linux-2.6.11-rc4/fs/nfs/proc.c
===================================================================
--- linux-2.6.11-rc4.orig/fs/nfs/proc.c
+++ linux-2.6.11-rc4/fs/nfs/proc.c
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
+	if (status == 0)
+		status = nfs_instantiate(dentry, &fhandle, &fattr);
 	dprintk("NFS reply mknod: %d\n", status);
 	return status;
 }
Index: linux-2.6.11-rc4/fs/nfs/dir.c
===================================================================
--- linux-2.6.11-rc4.orig/fs/nfs/dir.c
+++ linux-2.6.11-rc4/fs/nfs/dir.c
@@ -938,7 +938,7 @@ static struct dentry *nfs_readdir_lookup
 /*
  * Code common to create, mkdir, and mknod.
  */
-static int nfs_instantiate(struct dentry *dentry, struct nfs_fh *fhandle,
+int nfs_instantiate(struct dentry *dentry, struct nfs_fh *fhandle,
 				struct nfs_fattr *fattr)
 {
 	struct inode *inode;
@@ -1019,9 +1019,7 @@ static int
 nfs_mknod(struct inode *dir, struct dentry *dentry, int mode, dev_t rdev)
 {
 	struct iattr attr;
-	struct nfs_fattr fattr;
-	struct nfs_fh fhandle;
-	int error;
+	int status;
 
 	dfprintk(VFS, "NFS: mknod(%s/%ld, %s\n", dir->i_sb->s_id,
 		dir->i_ino, dentry->d_name.name);
@@ -1034,15 +1032,15 @@ nfs_mknod(struct inode *dir, struct dent
 
 	lock_kernel();
 	nfs_begin_data_update(dir);
-	error = NFS_PROTO(dir)->mknod(dir, &dentry->d_name, &attr, rdev,
-					&fhandle, &fattr);
+	status = NFS_PROTO(dir)->mknod(dir, dentry, &attr, rdev);
 	nfs_end_data_update(dir);
-	if (!error)
-		error = nfs_instantiate(dentry, &fhandle, &fattr);
-	else
-		d_drop(dentry);
 	unlock_kernel();
-	return error;
+	if (status != 0)
+		goto out_err;
+	return 0;
+out_err:
+	d_drop(dentry);
+	return status;
 }
 
 /*
Index: linux-2.6.11-rc4/include/linux/nfs_xdr.h
===================================================================
--- linux-2.6.11-rc4.orig/include/linux/nfs_xdr.h
+++ linux-2.6.11-rc4/include/linux/nfs_xdr.h
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
Index: linux-2.6.11-rc4/include/linux/nfs_fs.h
===================================================================
--- linux-2.6.11-rc4.orig/include/linux/nfs_fs.h
+++ linux-2.6.11-rc4/include/linux/nfs_fs.h
@@ -345,6 +345,8 @@ extern struct inode_operations nfs_dir_i
 extern struct file_operations nfs_dir_operations;
 extern struct dentry_operations nfs_dentry_operations;
 
+extern int nfs_instantiate(struct dentry *dentry, struct nfs_fh *fh, struct nfs_fattr *fattr);
+
 /*
  * linux/fs/nfs/symlink.c
  */

--=-fcfpxL0xCQpWBmv6MSrx--

