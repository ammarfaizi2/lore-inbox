Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263269AbTIVTNs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 15:13:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263270AbTIVTNs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 15:13:48 -0400
Received: from havoc.gtf.org ([63.247.75.124]:21420 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S263269AbTIVTNm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 15:13:42 -0400
Date: Mon, 22 Sep 2003 15:13:41 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: linux-kernel@vger.kernel.org
Cc: trond.myklebust@fys.uio.no
Subject: [PATCH] reduce NFS stack usage
Message-ID: <20030922191338.GA32608@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

struct nfs_entry, nfs_readdir_descriptor_t, struct nfs_fh, and struct
nfs_fattr are all not-small and shouldn't be placed on the stack
if we can help it.  This was noticed in a "do_IRQ stack overflow"
oops trace, by examining the stack pointer deltas.

This patch does the obvious -- uses kmalloc.

Patch against 2.4.23-preXX, but should apply to 2.6.0-test as well.

Untested, unreviewed...  enjoy.



===== fs/nfs/dir.c 1.12 vs edited =====
--- 1.12/fs/nfs/dir.c	Tue Oct 15 00:59:27 2002
+++ edited/fs/nfs/dir.c	Mon Sep 22 15:08:27 2003
@@ -349,14 +349,25 @@
 {
 	struct dentry	*dentry = filp->f_dentry;
 	struct inode	*inode = dentry->d_inode;
-	nfs_readdir_descriptor_t my_desc,
-			*desc = &my_desc;
-	struct nfs_entry my_entry;
+	nfs_readdir_descriptor_t *desc;
+	struct nfs_entry *my_entry;
 	long		res;
+	int		rc = -EINVAL;
+	void		*mem;
+
+	mem = kmalloc(sizeof(struct nfs_entry) +
+		      sizeof(nfs_readdir_descriptor_t), GFP_KERNEL);
+	if (!mem)
+		return -ENOMEM;
+
+	my_entry = mem;
+	desc = mem + sizeof(struct nfs_entry);
 
 	res = nfs_revalidate(dentry);
-	if (res < 0)
-		return res;
+	if (res < 0) {
+		rc = (int) res;
+		goto out;
+	}
 
 	/*
 	 * filp->f_pos points to the file offset in the page cache.
@@ -365,11 +376,11 @@
 	 * itself.
 	 */
 	memset(desc, 0, sizeof(*desc));
-	memset(&my_entry, 0, sizeof(my_entry));
+	memset(my_entry, 0, sizeof(my_entry));
 
 	desc->file = filp;
 	desc->target = filp->f_pos;
-	desc->entry = &my_entry;
+	desc->entry = my_entry;
 	desc->decode = NFS_PROTO(inode)->decode_dirent;
 
 	while(!desc->entry->eof) {
@@ -393,11 +404,16 @@
 			break;
 		}
 	}
+
 	if (desc->error < 0)
-		return desc->error;
-	if (res < 0)
-		return res;
-	return 0;
+		rc = desc->error;
+	else if (res < 0)
+		rc = res;
+	/* fall through */
+
+out:
+	kfree(mem);
+	return rc;
 }
 
 /*
@@ -476,13 +492,22 @@
 	struct inode *dir;
 	struct inode *inode;
 	int error;
-	struct nfs_fh fhandle;
-	struct nfs_fattr fattr;
+	struct nfs_fh *fhandle;
+	struct nfs_fattr *fattr;
+	void *mem;
+	int rc = 0;
 
 	lock_kernel();
 	dir = dentry->d_parent->d_inode;
 	inode = dentry->d_inode;
 
+	mem = kmalloc(sizeof(struct nfs_fh) + sizeof(struct nfs_fattr),
+		      GFP_KERNEL);
+	if (!mem)
+		goto out_bad;
+	fhandle = mem;
+	fattr = mem + sizeof(struct nfs_fh);
+
 	if (!inode) {
 		if (nfs_neg_need_reval(dir, dentry))
 			goto out_bad;
@@ -505,18 +530,19 @@
 	if (NFS_STALE(inode))
 		goto out_bad;
 
-	error = NFS_PROTO(dir)->lookup(dir, &dentry->d_name, &fhandle, &fattr);
+	error = NFS_PROTO(dir)->lookup(dir, &dentry->d_name, fhandle, fattr);
 	if (error)
 		goto out_bad;
-	if (memcmp(NFS_FH(inode), &fhandle, sizeof(struct nfs_fh))!= 0)
+	if (memcmp(NFS_FH(inode), fhandle, sizeof(struct nfs_fh))!= 0)
 		goto out_bad;
-	if ((error = nfs_refresh_inode(inode, &fattr)) != 0)
+	if ((error = nfs_refresh_inode(inode, fattr)) != 0)
 		goto out_bad;
 
 	nfs_renew_times(dentry);
  out_valid:
-	unlock_kernel();
-	return 1;
+ 	rc = 1;
+	goto out;
+
  out_bad:
 	NFS_CACHEINV(dir);
 	if (inode && S_ISDIR(inode->i_mode)) {
@@ -528,8 +554,14 @@
 		shrink_dcache_parent(dentry);
 	}
 	d_drop(dentry);
+	rc = 0;
+	/* fall through */
+
+out:
 	unlock_kernel();
-	return 0;
+	if (mem)
+		kfree(mem);
+	return rc;
 }
 
 /*
