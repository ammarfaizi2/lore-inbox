Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261169AbVBVQsS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261169AbVBVQsS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 11:48:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261161AbVBVQsC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 11:48:02 -0500
Received: from cantor.suse.de ([195.135.220.2]:7647 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261163AbVBVQrZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 11:47:25 -0500
Subject: Re: [patch 12/13] ACL umask handling workaround in nfs client
From: Andreas Gruenbacher <agruen@suse.de>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Neil Brown <neilb@cse.unsw.edu.au>, Olaf Kirch <okir@suse.de>,
       "Andries E. Brouwer" <Andries.Brouwer@cwi.nl>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <1108490682.10073.57.camel@lade.trondhjem.org>
References: <20050122203326.402087000@blunzn.suse.de>
	 <20050122203620.108564000@blunzn.suse.de>
	 <1108490682.10073.57.camel@lade.trondhjem.org>
Content-Type: multipart/mixed; boundary="=-Zg/10rPGZToCDIoqJMb3"
Organization: SUSE Labs
Message-Id: <1109090843.6102.443.camel@winden.suse.de>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 22 Feb 2005 17:47:24 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Zg/10rPGZToCDIoqJMb3
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, 2005-02-15 at 19:04, Trond Myklebust wrote:
> lau den 22.01.2005 Klokka 21:34 (+0100) skreiv Andreas Gruenbacher:
> > vanlig tekstdokument vedlegg (patches.suse)
> > NFSv3 has no concept of a umask on the server side: The client applies
> > the umask locally, and sends the effective permissions to the server.
> > This behavior is wrong when files are created in a directory that has
> > a default ACL. In this case, the umask is supposed to be ignored, and
> > only the default ACL determines the file's effective permissions.
> > 
> > Usually its the server's task to conditionally apply the umask. But
> > since the server knows nothing about the umask, we have to do it on the
> > client side. This patch tries to fetch the parent directory's default
> > ACL before creating a new file, computes the appropriate create mode to
> > send to the server, and finally sets the new file's access and default
> > acl appropriately.
> 
> Firstly, this sort of code belongs in the NFSv3-specific code. POSIX
> acls have no business whatsoever in the generic NFS code.

See attached patch.

NOTE:

  During testing I noticed that without
  nfsacl-cache-acls-on-the-nfs-client-side.patch, no directories or
  devices can be created. It's probably a problem with
  nfs_set_default_acl(). I'll have to debug this tomorrow.

> Secondly, what is the point of doing all this *after* you have created
> the file with the wrong permissions? How are you avoiding races?

Well, everything but the umask is always correct; that is guaranteed by
the server. The initial create sets permissions that may be more
restrictive than necessary, and then the SETACL RPC sets up the final,
correct permissions. I don't believe that a race-free solution is
possible.

Cheers,
-- 
Andreas Gruenbacher <agruen@suse.de>
SUSE Labs, SUSE LINUX GMBH

--=-Zg/10rPGZToCDIoqJMb3
Content-Disposition: attachment; filename=nfsacl-acl-umask-handling-workaround-in-nfs-client-fix2.patch
Content-Type: text/x-patch; name=nfsacl-acl-umask-handling-workaround-in-nfs-client-fix2.patch; charset=utf-8
Content-Transfer-Encoding: 7bit

Index: linux-2.6.11-rc3/fs/nfs/dir.c
===================================================================
--- linux-2.6.11-rc3.orig/fs/nfs/dir.c
+++ linux-2.6.11-rc3/fs/nfs/dir.c
@@ -42,12 +42,15 @@ static int nfs_opendir(struct inode *, s
 static int nfs_readdir(struct file *, void *, filldir_t);
 static struct dentry *nfs_lookup(struct inode *, struct dentry *, struct nameidata *);
 static int nfs_create(struct inode *, struct dentry *, int, struct nameidata *);
+static int nfs3_create(struct inode *, struct dentry *, int, struct nameidata *);
 static int nfs_mkdir(struct inode *, struct dentry *, int);
+static int nfs3_mkdir(struct inode *, struct dentry *, int);
 static int nfs_rmdir(struct inode *, struct dentry *);
 static int nfs_unlink(struct inode *, struct dentry *);
 static int nfs_symlink(struct inode *, struct dentry *, const char *);
 static int nfs_link(struct dentry *, struct inode *, struct dentry *);
 static int nfs_mknod(struct inode *, struct dentry *, int, dev_t);
+static int nfs3_mknod(struct inode *, struct dentry *, int, dev_t);
 static int nfs_rename(struct inode *, struct dentry *,
 		      struct inode *, struct dentry *);
 static int nfs_fsync_dir(struct file *, struct dentry *, int);
@@ -77,14 +80,14 @@ struct inode_operations nfs_dir_inode_op
 
 #ifdef CONFIG_NFS_V3
 struct inode_operations nfs3_dir_inode_operations = {
-	.create		= nfs_create,
+	.create		= nfs3_create,
 	.lookup		= nfs_lookup,
 	.link		= nfs_link,
 	.unlink		= nfs_unlink,
 	.symlink	= nfs_symlink,
-	.mkdir		= nfs_mkdir,
+	.mkdir		= nfs3_mkdir,
 	.rmdir		= nfs_rmdir,
-	.mknod		= nfs_mknod,
+	.mknod		= nfs3_mknod,
 	.rename		= nfs_rename,
 	.permission	= nfs_permission,
 	.getattr	= nfs_getattr,
@@ -994,16 +997,14 @@ out_err:
 	return error;
 }
 
-static int nfs_set_default_acl(struct inode *dir, struct inode *inode,
-			       mode_t mode)
+#ifdef CONFIG_NFS_V3
+static int nfs3_set_default_acl(struct inode *dir, struct inode *inode,
+				mode_t mode)
 {
 #ifdef CONFIG_NFS_ACL
 	struct posix_acl *dfacl, *acl;
 	int error = 0;
 
-	if (NFS_PROTO(inode)->version != 3 ||
-	    !NFS_PROTO(dir)->getacl || !NFS_PROTO(inode)->setacls)
-		return 0;
 	dfacl = NFS_PROTO(dir)->getacl(dir, ACL_TYPE_DEFAULT);
 	if (IS_ERR(dfacl)) {
 		error = PTR_ERR(dfacl);
@@ -1028,6 +1029,7 @@ out:
 	return 0;
 #endif
 }
+#endif
 
 /*
  * Following a failed create operation, we drop the dentry rather
@@ -1060,7 +1062,7 @@ static int nfs_create(struct inode *dir,
 		d_instantiate(dentry, inode);
 		nfs_renew_times(dentry);
 		nfs_set_verifier(dentry, nfs_save_change_attribute(dir));
-		error = nfs_set_default_acl(dir, inode, mode);
+		error = 0;
 	} else {
 		error = PTR_ERR(inode);
 		d_drop(dentry);
@@ -1069,6 +1071,22 @@ static int nfs_create(struct inode *dir,
 	return error;
 }
 
+#ifdef CONFIG_NFS_V3
+static int nfs3_create(struct inode *dir, struct dentry *dentry, int mode,
+		       struct nameidata *nd)
+{
+	int error;
+
+	lock_kernel();
+	error = nfs_create(dir, dentry, mode, nd);
+	if (!error)
+		error = nfs3_set_default_acl(dir, dentry->d_inode, mode);
+	unlock_kernel();
+
+	return error;
+}
+#endif
+
 /*
  * See comments for nfs_proc_create regarding failed operations.
  */
@@ -1098,9 +1116,21 @@ nfs_mknod(struct inode *dir, struct dent
 		error = nfs_instantiate(dentry, &fhandle, &fattr);
 	else
 		d_drop(dentry);
+	unlock_kernel();
+	return error;
+}
+
+static int nfs3_mknod(struct inode *dir, struct dentry *dentry, int mode,
+		      dev_t rdev)
+{
+	int error;
+
+	lock_kernel();
+	error = nfs_mknod(dir, dentry, mode, rdev);
 	if (!error)
-		error = nfs_set_default_acl(dir, dentry->d_inode, mode);
+		error = nfs3_set_default_acl(dir, dentry->d_inode, mode);
 	unlock_kernel();
+
 	return error;
 }
 
@@ -1138,9 +1168,20 @@ static int nfs_mkdir(struct inode *dir, 
 		error = nfs_instantiate(dentry, &fhandle, &fattr);
 	else
 		d_drop(dentry);
+	unlock_kernel();
+	return error;
+}
+
+static int nfs3_mkdir(struct inode *dir, struct dentry *dentry, int mode)
+{
+	int error;
+
+	lock_kernel();
+	error = nfs_mkdir(dir, dentry, mode);
 	if (!error)
-		error = nfs_set_default_acl(dir, dentry->d_inode, mode);
+		error = nfs3_set_default_acl(dir, dentry->d_inode, mode);
 	unlock_kernel();
+
 	return error;
 }
 

--=-Zg/10rPGZToCDIoqJMb3--

