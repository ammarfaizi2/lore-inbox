Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262916AbUDULcN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262916AbUDULcN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 07:32:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264548AbUDULcN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 07:32:13 -0400
Received: from mx1.redhat.com ([66.187.233.31]:26512 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262916AbUDULcG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 07:32:06 -0400
Message-ID: <40865BA8.4030308@RedHat.com>
Date: Wed, 21 Apr 2004 07:31:52 -0400
From: Steve Dickson <SteveD@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Trond Myklebust <trond.myklebust@fys.uio.no>
CC: Linux NFS Mailing List <nfs@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: [NFS] [PATCH] Make V4 mounts return the correct errno to mount command
Content-Type: multipart/mixed;
 boundary="------------060503010902030608070808"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060503010902030608070808
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hey Trond,

Attached is a patch that changes nfs_sb_init() to returned correct
errno (when nfs_get_root() fails), instead of returning a static
errno of -EINVAL.  By returning the correct errno, it allows
the mount command to print the correct error message.
For example,  currently when you try to mount a v4 fs that
is not exported on the server you get:

    Lucky# mount -v -t nfs4  harryp:/home /mnt/harryp
    mount: wrong fs type, bad option, bad superblock on harryp:/home,
           or too many mounted file systems

With this patch, error message becomes:

    Lucky# mount -v -t nfs4  harryp:/home /mnt/harryp
    mount: special device harryp:/home does not exist

Now that the mount command correctly decipher the errror
I also changed two hard coded printk into dprintks to cut
down on the number of messages (from 4 to 2) that are logged
for this type of error.

SteveD.


--------------060503010902030608070808
Content-Type: text/plain;
 name="linux-2.6.5-mounterrors.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linux-2.6.5-mounterrors.patch"

--- linux-2.6.5/fs/nfs/inode.c.orig	2004-04-20 04:21:05.000000000 -0400
+++ linux-2.6.5/fs/nfs/inode.c	2004-04-20 21:37:34.599579224 -0400
@@ -237,7 +237,7 @@ nfs_get_root(struct super_block *sb, str
 
 	error = server->rpc_ops->getroot(server, rootfh, fsinfo);
 	if (error < 0) {
-		printk(KERN_NOTICE "nfs_get_root: getattr error = %d\n", -error);
+		dprintk("nfs_get_root: getattr error = %d\n", -error);
 		return ERR_PTR(error);
 	}
 
@@ -262,6 +262,7 @@ nfs_sb_init(struct super_block *sb, rpc_
 	struct nfs_pathconf pathinfo = {
 			.fattr = &fattr,
 	};
+	int no_root_error = 0;
 
 	/* We probably want something more informative here */
 	snprintf(sb->s_id, sizeof(sb->s_id), "%x:%x", MAJOR(sb->s_dev), MINOR(sb->s_dev));
@@ -272,12 +273,15 @@ nfs_sb_init(struct super_block *sb, rpc_
 
 	root_inode = nfs_get_root(sb, &server->fh, &fsinfo);
 	/* Did getting the root inode fail? */
-	if (IS_ERR(root_inode))
+	if (IS_ERR(root_inode)) {
+		no_root_error = PTR_ERR(root_inode);
 		goto out_no_root;
+	}
 	sb->s_root = d_alloc_root(root_inode);
-	if (!sb->s_root)
+	if (!sb->s_root) {
+		no_root_error = -ENOMEM;
 		goto out_no_root;
-
+	}
 	sb->s_root->d_op = server->rpc_ops->dentry_ops;
 
 	/* Get some general file system info */
@@ -337,10 +341,10 @@ nfs_sb_init(struct super_block *sb, rpc_
 	return 0;
 	/* Yargs. It didn't work out. */
 out_no_root:
-	printk("nfs_read_super: get root inode failed\n");
+	dprintk("nfs_sb_init: get root inode failed: errno %d\n", -no_root_error);
 	if (!IS_ERR(root_inode))
 		iput(root_inode);
-	return -EINVAL;
+	return no_root_error;
 }
 
 /*

--------------060503010902030608070808--
