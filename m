Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261463AbTIXQQj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Sep 2003 12:16:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261480AbTIXQQj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Sep 2003 12:16:39 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:4028 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261463AbTIXQQe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Sep 2003 12:16:34 -0400
Message-ID: <3F71C354.1020302@pobox.com>
Date: Wed, 24 Sep 2003 12:16:20 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
CC: trond.myklebust@fys.uio.no, steved@redhat.com
Subject: [PATCH v2] reduce NFS stack usage
Content-Type: multipart/mixed;
 boundary="------------090507060105030704010809"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090507060105030704010809
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

David Mansfield spotted a bug in a memset() call, in my initial patch.

Attached is an updated version.  The only change is 
s/sizeof(my_entry)/sizeof(*my_entry)/ in the memset.

	Jeff



--------------090507060105030704010809
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"


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
+	memset(my_entry, 0, sizeof(*my_entry));
 
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
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/



--------------090507060105030704010809--

