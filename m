Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319119AbSHMW5O>; Tue, 13 Aug 2002 18:57:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319081AbSHMW4l>; Tue, 13 Aug 2002 18:56:41 -0400
Received: from berzerk.gpcc.itd.umich.edu ([141.211.2.162]:33421 "EHLO
	berzerk.gpcc.itd.umich.edu") by vger.kernel.org with ESMTP
	id <S319101AbSHMWzA>; Tue, 13 Aug 2002 18:55:00 -0400
Date: Tue, 13 Aug 2002 18:58:49 -0400 (EDT)
From: "Kendrick M. Smith" <kmsmith@umich.edu>
X-X-Sender: kmsmith@rastan.gpcc.itd.umich.edu
To: linux-kernel@vger.kernel.org, <nfs@lists.sourceforge.net>
Subject: patch 07/38: CLIENT: change inode to dentry in ->setattr() nfs_rpc_op
Message-ID: <Pine.SOL.4.44.0208131858300.25942-100000@rastan.gpcc.itd.umich.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch changes the interface of the ->setattr() nfs_rpc_op
so that its first argument is a dentry instead of an inode.

[Explanation: The dentry is required because in NFSv4, we may
 need to OPEN the file before doing the SETATTR.  (This is
 required if the file size is changed as part of the setattr.)
 Opening the file requires making use of the containing
 directory's inode.]

--- old/include/linux/nfs_xdr.h	Mon Jul 29 22:54:08 2002
+++ new/include/linux/nfs_xdr.h	Mon Jul 29 13:50:30 2002
@@ -296,7 +296,7 @@ struct nfs_rpc_ops {
 	int	(*getroot) (struct nfs_server *, struct nfs_fh *,
 			    struct nfs_fattr *);
 	int	(*getattr) (struct inode *, struct nfs_fattr *);
-	int	(*setattr) (struct inode *, struct nfs_fattr *,
+	int	(*setattr) (struct dentry *, struct nfs_fattr *,
 			    struct iattr *);
 	int	(*lookup)  (struct inode *, struct qstr *,
 			    struct nfs_fh *, struct nfs_fattr *);
--- old/fs/nfs/inode.c	Wed Jul 24 16:03:30 2002
+++ new/fs/nfs/inode.c	Mon Jul 29 14:49:53 2002
@@ -768,7 +768,7 @@ printk("nfs_setattr: revalidate failed,
 	if (error)
 		goto out;

-	error = NFS_PROTO(inode)->setattr(inode, &fattr, attr);
+	error = NFS_PROTO(inode)->setattr(dentry, &fattr, attr);
 	if (error)
 		goto out;
 	/*
--- old/fs/nfs/proc.c	Mon Jul 29 22:54:08 2002
+++ new/fs/nfs/proc.c	Mon Jul 29 14:11:48 2002
@@ -78,9 +78,10 @@ nfs_proc_getattr(struct inode *inode, st
 }

 static int
-nfs_proc_setattr(struct inode *inode, struct nfs_fattr *fattr,
+nfs_proc_setattr(struct dentry *dentry, struct nfs_fattr *fattr,
 		 struct iattr *sattr)
 {
+	struct inode *inode = dentry->d_inode;
 	struct nfs_sattrargs	arg = {
 		fh:	NFS_FH(inode),
 		sattr:	sattr
--- old/fs/nfs/nfs3proc.c	Mon Jul 29 22:54:08 2002
+++ new/fs/nfs/nfs3proc.c	Mon Jul 29 14:11:56 2002
@@ -86,9 +86,10 @@ nfs3_proc_getattr(struct inode *inode, s
 }

 static int
-nfs3_proc_setattr(struct inode *inode, struct nfs_fattr *fattr,
+nfs3_proc_setattr(struct dentry *dentry, struct nfs_fattr *fattr,
 			struct iattr *sattr)
 {
+	struct inode *inode = dentry->d_inode;
 	struct nfs3_sattrargs	arg = {
 		fh:		NFS_FH(inode),
 		sattr:		sattr,

