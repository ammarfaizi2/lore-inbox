Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030671AbVIBET1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030671AbVIBET1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 00:19:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030673AbVIBET1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 00:19:27 -0400
Received: from pat.uio.no ([129.240.130.16]:32965 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1030671AbVIBET1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 00:19:27 -0400
Subject: Re: Change in NFS client behavior
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Andrew Morton <akpm@osdl.org>
Cc: lkml-z@robsims.com, linux-kernel@vger.kernel.org
In-Reply-To: <1125634523.8635.16.camel@lade.trondhjem.org>
References: <20050831145545.GA8426@robsims.com>
	 <1125617897.7627.14.camel@lade.trondhjem.org>
	 <1125632597.8635.9.camel@lade.trondhjem.org>
	 <20050901204520.58f07230.akpm@osdl.org>
	 <1125633145.8635.11.camel@lade.trondhjem.org>
	 <20050901210755.607f3e4d.akpm@osdl.org>
	 <1125634523.8635.16.camel@lade.trondhjem.org>
Content-Type: multipart/mixed; boundary="=-DP1cUQ8V9FhW+0yiWTA1"
Date: Fri, 02 Sep 2005 00:19:07 -0400
Message-Id: <1125634747.8635.17.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
X-UiO-Spam-info: not spam, SpamAssassin (score=-2.644, required 12,
	autolearn=disabled, AWL 2.17, FORGED_RCVD_HELO 0.05,
	RCVD_IN_SORBS_DUL 0.14, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-DP1cUQ8V9FhW+0yiWTA1
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

fr den 02.09.2005 Klokka 00:15 (-0400) skreiv Trond Myklebust:

> Sure. The other problem is that the test is made before the i_sem is
> grabbed. OK, so how about the appended patch instead?

Doh!

Trond

--=-DP1cUQ8V9FhW+0yiWTA1
Content-Disposition: inline; filename=linux-2.6.13-37-fix_create_truncate.dif
Content-Type: text/plain; name=linux-2.6.13-37-fix_create_truncate.dif; charset=UTF-8
Content-Transfer-Encoding: 7bit

VFS/NFS: Fix up behaviour w.r.t. truncate() and open(O_TRUNC)

 POSIX and the SUSv3 specify that open(O_TRUNC) should always bump ctime/mtime
 whereas truncate() should only do so if the file size actually changes.

 Fix the behaviour of NFS, which currently is broken w.r.t. open(), and fix
 the VFS truncate() so that it no enforces the POSIX rules.

 Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>
---
 attr.c      |   14 +++-----------
 nfs/inode.c |    5 -----
 open.c      |   25 +++++++++++++++++++++++--
 3 files changed, 26 insertions(+), 18 deletions(-)

Index: linux-2.6.13/fs/nfs/inode.c
===================================================================
--- linux-2.6.13.orig/fs/nfs/inode.c
+++ linux-2.6.13/fs/nfs/inode.c
@@ -833,11 +833,6 @@ nfs_setattr(struct dentry *dentry, struc
 	struct nfs_fattr fattr;
 	int error;
 
-	if (attr->ia_valid & ATTR_SIZE) {
-		if (!S_ISREG(inode->i_mode) || attr->ia_size == i_size_read(inode))
-			attr->ia_valid &= ~ATTR_SIZE;
-	}
-
 	/* Optimization: if the end result is no change, don't RPC */
 	attr->ia_valid &= NFS_VALID_ATTRS;
 	if (attr->ia_valid == 0)
Index: linux-2.6.13/fs/open.c
===================================================================
--- linux-2.6.13.orig/fs/open.c
+++ linux-2.6.13/fs/open.c
@@ -206,11 +206,32 @@ int do_truncate(struct dentry *dentry, l
 	newattrs.ia_valid = ATTR_SIZE | ATTR_CTIME;
 
 	down(&dentry->d_inode->i_sem);
+	/* This should be used for open(O_TRUNC) and functions that need to
+	 * set mtime/ctime whether or not the size changes
+	 */
+	if (length == i_size_read(dentry->d_inode))
+		newattrs.ia_valid &= ~ATTR_SIZE;
 	err = notify_change(dentry, &newattrs);
 	up(&dentry->d_inode->i_sem);
 	return err;
 }
 
+static int do_posix_truncate(struct dentry *dentry, loff_t length)
+{
+	int err = 0;
+	struct iattr newattrs;
+
+	newattrs.ia_size = length;
+	newattrs.ia_valid = ATTR_SIZE;
+
+	down(&dentry->d_inode->i_sem);
+	/* In SuS/Posix lore, truncate to the current file size is a no-op */
+	if (length != i_size_read(dentry->d_inode))
+		err = notify_change(dentry, &newattrs);
+	up(&dentry->d_inode->i_sem);
+	return err;
+}
+
 static inline long do_sys_truncate(const char __user * path, loff_t length)
 {
 	struct nameidata nd;
@@ -261,7 +282,7 @@ static inline long do_sys_truncate(const
 	error = locks_verify_truncate(inode, NULL, length);
 	if (!error) {
 		DQUOT_INIT(inode);
-		error = do_truncate(nd.dentry, length);
+		error = do_posix_truncate(nd.dentry, length);
 	}
 	put_write_access(inode);
 
@@ -313,7 +334,7 @@ static inline long do_sys_ftruncate(unsi
 
 	error = locks_verify_truncate(inode, file, length);
 	if (!error)
-		error = do_truncate(dentry, length);
+		error = do_posix_truncate(dentry, length);
 out_putf:
 	fput(file);
 out:
Index: linux-2.6.13/fs/attr.c
===================================================================
--- linux-2.6.13.orig/fs/attr.c
+++ linux-2.6.13/fs/attr.c
@@ -70,17 +70,9 @@ int inode_setattr(struct inode * inode, 
 	int error = 0;
 
 	if (ia_valid & ATTR_SIZE) {
-		if (attr->ia_size != i_size_read(inode)) {
-			error = vmtruncate(inode, attr->ia_size);
-			if (error || (ia_valid == ATTR_SIZE))
-				goto out;
-		} else {
-			/*
-			 * We skipped the truncate but must still update
-			 * timestamps
-			 */
-			ia_valid |= ATTR_MTIME|ATTR_CTIME;
-		}
+		error = vmtruncate(inode, attr->ia_size);
+		if (error || (ia_valid == ATTR_SIZE))
+			goto out;
 	}
 
 	if (ia_valid & ATTR_UID)

--=-DP1cUQ8V9FhW+0yiWTA1--

