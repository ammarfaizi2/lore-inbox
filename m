Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262392AbVAJS1a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262392AbVAJS1a (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 13:27:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262404AbVAJSZF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 13:25:05 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:52175 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S262407AbVAJSHv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 13:07:51 -0500
Subject: [PATCH 3/6] 2.4.19-rc1 nfs_lookup stack reduction patch
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1105378550.4000.132.camel@dyn318077bld.beaverton.ibm.com>
References: <1105378550.4000.132.camel@dyn318077bld.beaverton.ibm.com>
Content-Type: multipart/mixed; boundary="=-jTGeYO5zJT+ZPg43roAX"
Organization: 
Message-Id: <1105378818.4000.140.camel@dyn318077bld.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 10 Jan 2005 09:40:19 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-jTGeYO5zJT+ZPg43roAX
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



--=-jTGeYO5zJT+ZPg43roAX
Content-Disposition: attachment; filename=nfs_lookup.patch
Content-Type: text/plain; name=nfs_lookup.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

Signed-off-by: Badari Pulavarty <pbadari@us.ibm.com>
--- linux-2.4.29-rc1.org/fs/nfs/dir.c	2005-01-07 07:39:06.000000000 -0800
+++ linux-2.4.29-rc1/fs/nfs/dir.c	2005-01-10 00:15:56.000000000 -0800
@@ -580,8 +580,8 @@ static struct dentry *nfs_lookup(struct 
 {
 	struct inode *inode;
 	int error;
-	struct nfs_fh fhandle;
-	struct nfs_fattr fattr;
+	struct nfs_fh *fhandle;
+	struct nfs_fattr *fattr;
 
 	dfprintk(VFS, "NFS: lookup(%s/%s)\n",
 		dentry->d_parent->d_name.name, dentry->d_name.name);
@@ -591,15 +591,22 @@ static struct dentry *nfs_lookup(struct 
 		goto out;
 
 	error = -ENOMEM;
+	fhandle = kmalloc(sizeof(struct nfs_fh), GFP_KERNEL);
+	if (!fhandle)
+		goto out;
+	fattr = kmalloc(sizeof(struct nfs_fattr), GFP_KERNEL);
+	if (!fattr)
+		goto free_fhandle;
+
 	dentry->d_op = &nfs_dentry_operations;
 
-	error = NFS_PROTO(dir)->lookup(dir, &dentry->d_name, &fhandle, &fattr);
+	error = NFS_PROTO(dir)->lookup(dir, &dentry->d_name, fhandle, fattr);
 	inode = NULL;
 	if (error == -ENOENT)
 		goto no_entry;
 	if (!error) {
 		error = -EACCES;
-		inode = nfs_fhget(dentry, &fhandle, &fattr);
+		inode = nfs_fhget(dentry, fhandle, fattr);
 		if (inode) {
 	    no_entry:
 			d_add(dentry, inode);
@@ -607,6 +614,9 @@ static struct dentry *nfs_lookup(struct 
 		}
 		nfs_renew_times(dentry);
 	}
+	kfree(fattr);
+free_fhandle:
+	kfree(fhandle);
 out:
 	return ERR_PTR(error);
 }

--=-jTGeYO5zJT+ZPg43roAX--

