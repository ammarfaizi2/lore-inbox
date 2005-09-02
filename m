Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030665AbVIBDnh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030665AbVIBDnh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 23:43:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030666AbVIBDnh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 23:43:37 -0400
Received: from pat.uio.no ([129.240.130.16]:13734 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1030665AbVIBDnh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 23:43:37 -0400
Subject: Re: Change in NFS client behavior
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Andrew Morton <akpm@osdl.org>
Cc: Rob Sims <lkml-z@robsims.com>, linux-kernel@vger.kernel.org
In-Reply-To: <1125617897.7627.14.camel@lade.trondhjem.org>
References: <20050831145545.GA8426@robsims.com>
	 <1125617897.7627.14.camel@lade.trondhjem.org>
Content-Type: multipart/mixed; boundary="=-/LQ4IpXDYh5ZbtQAcFMl"
Date: Thu, 01 Sep 2005 23:43:17 -0400
Message-Id: <1125632597.8635.9.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
X-UiO-Spam-info: not spam, SpamAssassin (score=-4.813, required 12,
	autolearn=disabled, FORGED_RCVD_HELO 0.05, RCVD_IN_SORBS_DUL 0.14,
	UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-/LQ4IpXDYh5ZbtQAcFMl
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

to den 01.09.2005 Klokka 19:38 (-0400) skreiv Trond Myklebust:
> This is a consequence of 2.6 NFS clients optimising away unnecessary
> truncate calls. Whereas this is correct behaviour for truncate(), it
> appears to be incorrect for open(O_TRUNC).
> 
> In fact, local filesystems like xfs and ext3 appear to have the opposite
> problem: they change ctime if you call ftruncate(0) on the zero-length
> file, as the attached test shows.

Rob,

Could you please check if the following patch fixes NFS (and also the
local filesystems) for you?

Cheers,
  Trond


--=-/LQ4IpXDYh5ZbtQAcFMl
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
 nfs/inode.c |    5 -----
 open.c      |   12 ++++++++++--
 2 files changed, 10 insertions(+), 7 deletions(-)

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
@@ -211,6 +211,14 @@ int do_truncate(struct dentry *dentry, l
 	return err;
 }
 
+static inline int do_posix_truncate(struct dentry *dentry, loff_t length)
+{
+	/* In SuS/Posix lore, truncate to the current file size is a no-op */
+	if (length == i_size_read(dentry->d_inode))
+		return 0;
+	return do_truncate(dentry, length);
+}
+
 static inline long do_sys_truncate(const char __user * path, loff_t length)
 {
 	struct nameidata nd;
@@ -261,7 +269,7 @@ static inline long do_sys_truncate(const
 	error = locks_verify_truncate(inode, NULL, length);
 	if (!error) {
 		DQUOT_INIT(inode);
-		error = do_truncate(nd.dentry, length);
+		error = do_posix_truncate(nd.dentry, length);
 	}
 	put_write_access(inode);
 
@@ -313,7 +321,7 @@ static inline long do_sys_ftruncate(unsi
 
 	error = locks_verify_truncate(inode, file, length);
 	if (!error)
-		error = do_truncate(dentry, length);
+		error = do_posix_truncate(dentry, length);
 out_putf:
 	fput(file);
 out:

--=-/LQ4IpXDYh5ZbtQAcFMl--

