Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264831AbTF3OcM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jun 2003 10:32:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265075AbTF3O3k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jun 2003 10:29:40 -0400
Received: from pat.uio.no ([129.240.130.16]:26274 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S264831AbTF3OXp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jun 2003 10:23:45 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16128.19273.934755.845484@charged.uio.no>
Date: Mon, 30 Jun 2003 16:38:01 +0200
To: Linux FSdevel <linux-fsdevel@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       NFS maillist <nfs@lists.sourceforge.net>
Subject: [PATCH 4/4] Optimize NFS open() calls by means of 'intents'...
X-Mailer: VM 7.07 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning.
X-UiO-MailScanner: No virus found
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  - Make use of the open intents to improve close-to-open
    cache consistency. Only force data cache revalidation when
    we're doing an open().

  - Add true exclusive create to NFSv3.

  - Optimize away the redundant ->lookup() to check for an
    existing file when we know that we're doing NFSv3 exclusive
    create.

  - Optimize away all ->permission() checks other than those for
    path traversal, open(), and sys_access().

diff -u --recursive --new-file linux-2.5.73-06-permission/fs/nfs/dir.c linux-2.5.73-07-nfsopt/fs/nfs/dir.c
--- linux-2.5.73-06-permission/fs/nfs/dir.c	2003-06-30 08:49:25.000000000 +0200
+++ linux-2.5.73-07-nfsopt/fs/nfs/dir.c	2003-06-30 16:19:26.000000000 +0200
@@ -78,13 +78,9 @@
 static int
 nfs_opendir(struct inode *inode, struct file *filp)
 {
-	struct nfs_server *server = NFS_SERVER(inode);
 	int res = 0;
 
 	lock_kernel();
-	/* Do cto revalidation */
-	if (!(server->flags & NFS_MOUNT_NOCTO))
-		res = __nfs_revalidate_inode(server, inode);
 	/* Call generic open code in order to cache credentials */
 	if (!res)
 		res = nfs_open(inode, filp);
@@ -485,9 +481,13 @@
 }
 
 static inline
-int nfs_lookup_verify_inode(struct inode *inode)
+int nfs_lookup_verify_inode(struct inode *inode, int isopen)
 {
-	return nfs_revalidate_inode(NFS_SERVER(inode), inode);
+	struct nfs_server *server = NFS_SERVER(inode);
+
+	if (isopen && !(server->flags & NFS_MOUNT_NOCTO))
+		return __nfs_revalidate_inode(server, inode);
+	return nfs_revalidate_inode(server, inode);
 }
 
 /*
@@ -497,8 +497,17 @@
  * If parent mtime has changed, we revalidate, else we wait for a
  * period corresponding to the parent's attribute cache timeout value.
  */
-static inline int nfs_neg_need_reval(struct inode *dir, struct dentry *dentry)
+static inline
+int nfs_neg_need_reval(struct inode *dir, struct dentry *dentry,
+		       struct nameidata *nd)
 {
+	int ndflags = 0;
+
+	if (nd)
+		ndflags = nd->flags;
+	/* Don't revalidate a negative dentry if we're creating a new file */
+	if ((ndflags & LOOKUP_CREATE) && !(ndflags & LOOKUP_CONTINUE))
+		return 0;
 	if (!nfs_check_verifier(dir, dentry))
 		return 1;
 	return time_after(jiffies, dentry->d_time + NFS_ATTRTIMEO(dir));
@@ -523,14 +532,18 @@
 	int error;
 	struct nfs_fh fhandle;
 	struct nfs_fattr fattr;
+	int isopen = 0;
 
 	parent = dget_parent(dentry);
 	lock_kernel();
 	dir = parent->d_inode;
 	inode = dentry->d_inode;
 
+	if (nd && !(nd->flags & LOOKUP_CONTINUE) && (nd->flags & LOOKUP_OPEN))
+		isopen = 1;
+
 	if (!inode) {
-		if (nfs_neg_need_reval(dir, dentry))
+		if (nfs_neg_need_reval(dir, dentry, nd))
 			goto out_bad;
 		goto out_valid;
 	}
@@ -543,7 +556,7 @@
 
 	/* Force a full look up iff the parent directory has changed */
 	if (nfs_check_verifier(dir, dentry)) {
-		if (nfs_lookup_verify_inode(inode))
+		if (nfs_lookup_verify_inode(inode, isopen))
 			goto out_bad;
 		goto out_valid;
 	}
@@ -552,7 +565,7 @@
 	if (!error) {
 		if (memcmp(NFS_FH(inode), &fhandle, sizeof(struct nfs_fh))!= 0)
 			goto out_bad;
-		if (nfs_lookup_verify_inode(inode))
+		if (nfs_lookup_verify_inode(inode, isopen))
 			goto out_bad;
 		goto out_valid_renew;
 	}
@@ -630,6 +643,16 @@
 	.d_iput		= nfs_dentry_iput,
 };
 
+static inline
+int nfs_is_exclusive_create(struct inode *dir, struct nameidata *nd)
+{
+	if (NFS_PROTO(dir)->version == 2)
+		return 0;
+	if (!nd || (nd->flags & LOOKUP_CONTINUE) || !(nd->flags & LOOKUP_CREATE))
+		return 0;
+	return (nd->u.open.flags & O_EXCL) != 0;
+}
+
 static struct dentry *nfs_lookup(struct inode *dir, struct dentry * dentry, struct nameidata *nd)
 {
 	struct inode *inode = NULL;
@@ -647,6 +670,10 @@
 	error = -ENOMEM;
 	dentry->d_op = &nfs_dentry_operations;
 
+	/* If we're doing an exclusive create, optimize away the lookup */
+	if (nfs_is_exclusive_create(dir, nd))
+		return NULL;
+
 	lock_kernel();
 	error = nfs_cached_lookup(dir, dentry, &fhandle, &fattr);
 	if (!error) {
@@ -794,6 +821,7 @@
 	struct nfs_fattr fattr;
 	struct nfs_fh fhandle;
 	int error;
+	int flags = 0;
 
 	dfprintk(VFS, "NFS: create(%s/%ld, %s\n", dir->i_sb->s_id, 
 		dir->i_ino, dentry->d_name.name);
@@ -801,6 +829,9 @@
 	attr.ia_mode = mode;
 	attr.ia_valid = ATTR_MODE;
 
+	if (nd && (nd->flags & LOOKUP_CREATE))
+		flags = nd->u.open.flags & O_EXCL;
+
 	/*
 	 * The 0 argument passed into the create function should one day
 	 * contain the O_EXCL flag if requested. This allows NFSv3 to
@@ -810,7 +841,7 @@
 	lock_kernel();
 	nfs_zap_caches(dir);
 	error = NFS_PROTO(dir)->create(dir, &dentry->d_name,
-					 &attr, 0, &fhandle, &fattr);
+					 &attr, flags, &fhandle, &fattr);
 	if (!error)
 		error = nfs_instantiate(dentry, &fhandle, &fattr);
 	else
@@ -1247,6 +1278,13 @@
 	int mode = inode->i_mode;
 	int res;
 
+	/* Are we checking permissions on anything other than lookup? */
+	if (!(mask & MAY_EXEC)) {
+		/* We only need to check permissions on file open() and access() */
+		if (!nd || !(nd->flags & (LOOKUP_OPEN|LOOKUP_ACCESS)))
+			return 0;
+	}
+
 	if (mask & MAY_WRITE) {
 		/*
 		 *
diff -u --recursive --new-file linux-2.5.73-06-permission/fs/nfs/file.c linux-2.5.73-07-nfsopt/fs/nfs/file.c
--- linux-2.5.73-06-permission/fs/nfs/file.c	2003-05-07 12:34:41.000000000 +0200
+++ linux-2.5.73-07-nfsopt/fs/nfs/file.c	2003-06-30 08:49:50.000000000 +0200
@@ -82,9 +82,6 @@
 	/* Do NFSv4 open() call */
 	if ((open = server->rpc_ops->file_open) != NULL)
 		res = open(inode, filp);
-	/* Do cto revalidation */
-	else if (!(server->flags & NFS_MOUNT_NOCTO))
-		res = __nfs_revalidate_inode(server, inode);
 	/* Call generic open code in order to cache credentials */
 	if (!res)
 		res = nfs_open(inode, filp);
