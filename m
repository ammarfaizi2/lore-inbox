Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932535AbVHaV5d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932535AbVHaV5d (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 17:57:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932536AbVHaV5d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 17:57:33 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:32642 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S932535AbVHaV5d
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 17:57:33 -0400
From: Tom Zanussi <zanussi@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17174.10097.194063.644921@tut.ibm.com>
Date: Wed, 31 Aug 2005 16:56:01 -0500
To: akpm@osdl.org
Cc: nathans@sgi.com, axboe@suse.de, linux-kernel@vger.kernel.org
Subject: [-mm patch] relayfs: relayfs_remove fix
X-Mailer: VM 7.19 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes relayfs_remove use simple_rmdir for removing
directories instead of simple_unlink.  Thanks to Nathan Scott for the
original patch.

Andrew, please apply.

Thanks,

Tom

Signed-off-by: Tom Zanussi <zanussi@us.ibm.com>

diff -urpN -X dontdiff linux-2.6.13-rc6-mm2/fs/relayfs/inode.c linux-2.6.13-rc6-mm2-cur/fs/relayfs/inode.c
--- linux-2.6.13-rc6-mm2/fs/relayfs/inode.c	2005-08-25 18:21:31.000000000 -0500
+++ linux-2.6.13-rc6-mm2-cur/fs/relayfs/inode.c	2005-08-31 17:11:12.000000000 -0500
@@ -189,26 +189,39 @@ struct dentry *relayfs_create_dir(const 
 /**
  *	relayfs_remove - remove a file or directory in the relay filesystem
  *	@dentry: file or directory dentry
+ *
+ *	Returns 0 if successful, negative otherwise.
  */
 int relayfs_remove(struct dentry *dentry)
 {
-	struct dentry *parent = dentry->d_parent;
+	struct dentry *parent;
+	int error = 0;
+
+	if (!dentry)
+		return -EINVAL;
+	parent = dentry->d_parent;
 	if (!parent)
 		return -EINVAL;
 
 	parent = dget(parent);
 	down(&parent->d_inode->i_sem);
 	if (dentry->d_inode) {
-		simple_unlink(parent->d_inode, dentry);
-		d_delete(dentry);
+		if (S_ISDIR(dentry->d_inode->i_mode))
+			error = simple_rmdir(parent->d_inode, dentry);
+		else
+			error = simple_unlink(parent->d_inode, dentry);
+		if (!error)
+			d_delete(dentry);
 	}
-	dput(dentry);
+	if (!error)
+		dput(dentry);
 	up(&parent->d_inode->i_sem);
 	dput(parent);
 
-	simple_release_fs(&relayfs_mount, &relayfs_mount_count);
+	if (!error)
+		simple_release_fs(&relayfs_mount, &relayfs_mount_count);
 
-	return 0;
+	return error;
 }
 
 /**
@@ -219,9 +232,6 @@ int relayfs_remove(struct dentry *dentry
  */
 int relayfs_remove_dir(struct dentry *dentry)
 {
-	if (!dentry)
-		return -EINVAL;
-
 	return relayfs_remove(dentry);
 }
 


