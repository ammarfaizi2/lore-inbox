Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310182AbSCLPd3>; Tue, 12 Mar 2002 10:33:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311239AbSCLPdT>; Tue, 12 Mar 2002 10:33:19 -0500
Received: from mons.uio.no ([129.240.130.14]:43965 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S310182AbSCLPdQ>;
	Tue, 12 Mar 2002 10:33:16 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15502.8115.180229.773426@charged.uio.no>
Date: Tue, 12 Mar 2002 16:33:07 +0100
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
        NFS maillist <nfs@lists.sourceforge.net>
Subject: [PATCH] Fix 2.4.19-pre3 NFS client file creation
X-Mailer: VM 6.92 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,

  The following patch fixes a bug in NFS file creation. Recently (not
sure exactly when), open_namei() was changed so that it expects
vfs_create() to always return a fully instantiated dentry for the new
file.

The following patch ensures this is done in the cases where the RPC
CREATE call does not return valid attributes/filehandles. This is
always the case for NFSv2, and can sometimes be the case for v3...

Cheers,
  Trond

diff -u --recursive --new-file linux-2.4.19-pre3/fs/nfs/dir.c linux-2.4.19-fix_create/fs/nfs/dir.c
--- linux-2.4.19-pre3/fs/nfs/dir.c	Tue Jun 12 20:15:08 2001
+++ linux-2.4.19-fix_create/fs/nfs/dir.c	Tue Mar 12 15:33:47 2002
@@ -621,6 +621,12 @@
 	struct inode *inode;
 	int error = -EACCES;
 
+	if (fhandle->size == 0 || !(fattr->valid & NFS_ATTR_FATTR)) {
+		struct inode *dir = dentry->d_parent->d_inode;
+		error = NFS_PROTO(dir)->lookup(dir, &dentry->d_name, fhandle, fattr);
+		if (error)
+			goto out_err;
+	}
 	inode = nfs_fhget(dentry, fhandle, fattr);
 	if (inode) {
 		d_instantiate(dentry, inode);
@@ -628,6 +634,9 @@
 		error = 0;
 	}
 	return error;
+out_err:
+	d_drop(dentry);
+	return error;
 }
 
 /*
@@ -658,9 +667,9 @@
 	nfs_zap_caches(dir);
 	error = NFS_PROTO(dir)->create(dir, &dentry->d_name,
 					 &attr, 0, &fhandle, &fattr);
-	if (!error && fhandle.size != 0)
+	if (!error)
 		error = nfs_instantiate(dentry, &fhandle, &fattr);
-	if (error || fhandle.size == 0)
+	else
 		d_drop(dentry);
 	return error;
 }
@@ -684,9 +693,9 @@
 	nfs_zap_caches(dir);
 	error = NFS_PROTO(dir)->mknod(dir, &dentry->d_name, &attr, rdev,
 					&fhandle, &fattr);
-	if (!error && fhandle.size != 0)
+	if (!error)
 		error = nfs_instantiate(dentry, &fhandle, &fattr);
-	if (error || fhandle.size == 0)
+	else
 		d_drop(dentry);
 	return error;
 }
@@ -719,9 +728,9 @@
 	nfs_zap_caches(dir);
 	error = NFS_PROTO(dir)->mkdir(dir, &dentry->d_name, &attr, &fhandle,
 					&fattr);
-	if (!error && fhandle.size != 0)
+	if (!error)
 		error = nfs_instantiate(dentry, &fhandle, &fattr);
-	if (error || fhandle.size == 0)
+	else
 		d_drop(dentry);
 	return error;
 }
@@ -926,7 +935,7 @@
 	nfs_zap_caches(dir);
 	error = NFS_PROTO(dir)->symlink(dir, &dentry->d_name, &qsymname,
 					  &attr, &sym_fh, &sym_attr);
-	if (!error && sym_fh.size != 0 && (sym_attr.valid & NFS_ATTR_FATTR)) {
+	if (!error) {
 		error = nfs_instantiate(dentry, &sym_fh, &sym_attr);
 	} else {
 		if (error == -EEXIST)
