Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262345AbVAOTTh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262345AbVAOTTh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jan 2005 14:19:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262315AbVAOTTe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jan 2005 14:19:34 -0500
Received: from adsl-298.mirage.euroweb.hu ([193.226.239.42]:1683 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S262345AbVAOTTW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jan 2005 14:19:22 -0500
To: viro@parcelfarce.linux.theplanet.co.uk
CC: marcelo.tosatti@cyclades.com, linux-kernel@vger.kernel.org
Subject: Can't unmount bad inode
Message-Id: <E1CptRq-0003ze-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Sat, 15 Jan 2005 20:18:58 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When the root of a mount is a bad inode, it can't be unmounted.
Comment above bad_follow_link is also out of sync with code.  What
about just removing the follow_link method from bad_inode_ops
(untested patch attached)?

Same problem exists on 2.4.

Miklos

--- linux-2.6.10/fs/bad_inode.c.orig	2005-01-15 20:01:21.000000000 +0100
+++ linux-2.6.10/fs/bad_inode.c	2005-01-15 20:02:01.000000000 +0100
@@ -15,17 +15,6 @@
 #include <linux/smp_lock.h>
 #include <linux/namei.h>
 
-/*
- * The follow_link operation is special: it must behave as a no-op
- * so that a bad root inode can at least be unmounted. To do this
- * we must dput() the base and return the dentry with a dget().
- */
-static int bad_follow_link(struct dentry *dent, struct nameidata *nd)
-{
-	nd_set_link(nd, ERR_PTR(-EIO));
-	return 0;
-}
-
 static int return_EIO(void)
 {
 	return -EIO;
@@ -70,7 +59,6 @@ struct inode_operations bad_inode_ops =
 	.mknod		= EIO_ERROR,
 	.rename		= EIO_ERROR,
 	.readlink	= EIO_ERROR,
-	.follow_link	= bad_follow_link,
 	.truncate	= EIO_ERROR,
 	.permission	= EIO_ERROR,
 	.getattr	= EIO_ERROR,

