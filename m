Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266745AbUIMNop@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266745AbUIMNop (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 09:44:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266748AbUIMNop
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 09:44:45 -0400
Received: from wombat.indigo.net.au ([202.0.185.19]:782 "EHLO
	wombat.indigo.net.au") by vger.kernel.org with ESMTP
	id S266745AbUIMNoN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 09:44:13 -0400
Date: Mon, 13 Sep 2004 21:33:48 +0800 (WST)
From: raven@themaw.net
To: Andrew Morton <akpm@osdl.org>
cc: Jeff Moyer <jmoyer@redhat.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] autofs4 - allow map update recognition
Message-ID: <Pine.LNX.4.58.0409132124110.8810@donald.themaw.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=-98.6, required 8,
	NO_REAL_NAME, PATCH_UNIFIED_DIFF, RCVD_IN_ORBS,
	RCVD_IN_OSIRUSOFT_COM, USER_AGENT_PINE, USER_IN_WHITELIST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Andrew,

Having recently repaired autofs' ability to recognise updates to maps 
dynamically I found I needed to reintroduce the directory inode 
lookup method (I broke the update recognition several versions ago, oops).

This patch does this and applies cleanly against 2.6.9-rc1-mm4.

As far as I can tell from testing it doesn't introduce any backward 
incompatibilities.

Signed-off-by: Ian Kent <raven@themaw.net>

--- linux-2.6.7/fs/autofs4/root.c.orig	2004-08-05 12:56:26.578009776 -0400
+++ linux-2.6.7/fs/autofs4/root.c	2004-08-05 12:56:38.783154312 -0400
@@ -19,7 +19,6 @@
 #include <linux/smp_lock.h>
 #include "autofs_i.h"
 
-static struct dentry *autofs4_dir_lookup(struct inode *,struct dentry *, struct nameidata *);
 static int autofs4_dir_symlink(struct inode *,struct dentry *,const char *);
 static int autofs4_dir_unlink(struct inode *,struct dentry *);
 static int autofs4_dir_rmdir(struct inode *,struct dentry *);
@@ -29,7 +28,7 @@ static int autofs4_dir_open(struct inode
 static int autofs4_dir_close(struct inode *inode, struct file *file);
 static int autofs4_dir_readdir(struct file * filp, void * dirent, filldir_t filldir);
 static int autofs4_root_readdir(struct file * filp, void * dirent, filldir_t filldir);
-static struct dentry *autofs4_root_lookup(struct inode *,struct dentry *, struct nameidata *);
+static struct dentry *autofs4_lookup(struct inode *,struct dentry *, struct nameidata *);
 static int autofs4_dcache_readdir(struct file *, void *, filldir_t);
 
 struct file_operations autofs4_root_operations = {
@@ -48,7 +47,7 @@ struct file_operations autofs4_dir_opera
 };
 
 struct inode_operations autofs4_root_inode_operations = {
-	.lookup		= autofs4_root_lookup,
+	.lookup		= autofs4_lookup,
 	.unlink		= autofs4_dir_unlink,
 	.symlink	= autofs4_dir_symlink,
 	.mkdir		= autofs4_dir_mkdir,
@@ -56,7 +55,7 @@ struct inode_operations autofs4_root_ino
 };
 
 struct inode_operations autofs4_dir_inode_operations = {
-	.lookup		= autofs4_dir_lookup,
+	.lookup		= autofs4_lookup,
 	.unlink		= autofs4_dir_unlink,
 	.symlink	= autofs4_dir_symlink,
 	.mkdir		= autofs4_dir_mkdir,
@@ -439,23 +438,8 @@ static struct dentry_operations autofs4_
 	.d_release	= autofs4_dentry_release,
 };
 
-/* Lookups in non-root dirs never find anything - if it's there, it's
-   already in the dcache */
-static struct dentry *autofs4_dir_lookup(struct inode *dir, struct dentry *dentry, struct nameidata *nd)
-{
-#if 0
-	DPRINTK("ignoring lookup of %.*s/%.*s",
-		 dentry->d_parent->d_name.len, dentry->d_parent->d_name.name,
-		 dentry->d_name.len, dentry->d_name.name);
-#endif
-
-	dentry->d_fsdata = NULL;
-	d_add(dentry, NULL);
-	return NULL;
-}
-
 /* Lookups in the root directory */
-static struct dentry *autofs4_root_lookup(struct inode *dir, struct dentry *dentry, struct nameidata *nd)
+static struct dentry *autofs4_lookup(struct inode *dir, struct dentry *dentry, struct nameidata *nd)
 {
 	struct autofs_sb_info *sbi;
 	int oz_mode;
