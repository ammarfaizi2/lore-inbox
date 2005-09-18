Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932085AbVIROYk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932085AbVIROYk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Sep 2005 10:24:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932076AbVIROYK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Sep 2005 10:24:10 -0400
Received: from ppp-62-11-75-109.dialup.tiscali.it ([62.11.75.109]:37043 "EHLO
	zion.home.lan") by vger.kernel.org with ESMTP id S932083AbVIROXg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Sep 2005 10:23:36 -0400
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 10/12] HPPFS: don't open a file when it stays unused
Date: Sun, 18 Sep 2005 16:10:04 +0200
To: Antoine Martin <antoine@nagafix.co.uk>, Al Viro <viro@zeniv.linux.org.uk>
Cc: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net
Cc: LKML <linux-kernel@vger.kernel.org>
Message-Id: <20050918141004.31461.39445.stgit@zion.home.lan>
In-Reply-To: 200509181400.39120.blaisorblade@yahoo.it
References: 200509181400.39120.blaisorblade@yahoo.it
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

hppfs_follow_link() and hppfs_readlink() open the file but then doesn't use it,
apart for fput().

I assume that dropping this dentry_open doesn't remove any needed permission
checking.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 fs/hppfs/hppfs_kern.c |   12 ------------
 1 files changed, 0 insertions(+), 12 deletions(-)

diff --git a/fs/hppfs/hppfs_kern.c b/fs/hppfs/hppfs_kern.c
--- a/fs/hppfs/hppfs_kern.c
+++ b/fs/hppfs/hppfs_kern.c
@@ -745,15 +745,11 @@ static struct super_operations hppfs_sbo
 
 static int hppfs_readlink(struct dentry *dentry, char __user *buffer, int buflen)
 {
-	struct file *proc_file;
 	struct dentry *proc_dentry;
 	int (*readlink)(struct dentry *, char __user *, int);
 	int ret;
 
 	proc_dentry = HPPFS_I(dentry->d_inode)->proc_dentry;
-	proc_file = dentry_open(dget(proc_dentry), mntget(proc_submnt), O_RDONLY);
-	if (IS_ERR(proc_file))
-		return PTR_ERR(proc_file);
 
 	readlink = proc_dentry->d_inode->i_op->readlink;
 	if (readlink == NULL)
@@ -761,22 +757,16 @@ static int hppfs_readlink(struct dentry 
 	ret = (*readlink)(proc_dentry, buffer, buflen);
 	ret = proc_dentry->d_inode->i_op->readlink(proc_dentry, buffer, buflen);
 
-	fput(proc_file);
-
 	return ret;
 }
 
 static void* hppfs_follow_link(struct dentry *dentry, struct nameidata *nd)
 {
-	struct file *proc_file;
 	struct dentry *proc_dentry;
 	void * (*follow_link)(struct dentry *, struct nameidata *);
 	void *ret;
 
 	proc_dentry = HPPFS_I(dentry->d_inode)->proc_dentry;
-	proc_file = dentry_open(dget(proc_dentry), mntget(proc_submnt), O_RDONLY);
-	if (IS_ERR(proc_file))
-		return proc_file;
 
 	follow_link = proc_dentry->d_inode->i_op->follow_link;
 
@@ -788,8 +778,6 @@ static void* hppfs_follow_link(struct de
 
 	ret = follow_link(proc_dentry, nd);
 
-	fput(proc_file);
-
 	return ret;
 }
 

