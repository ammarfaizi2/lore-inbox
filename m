Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751375AbVJGLQH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751375AbVJGLQH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 07:16:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751330AbVJGLQH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 07:16:07 -0400
Received: from 223-177.adsl.pool.ew.hu ([193.226.223.177]:35345 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S1751376AbVJGLQF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 07:16:05 -0400
To: akpm@osdl.org
CC: viro@ftp.linux.org.uk, trond.myklebust@fys.uio.no,
       linux-kernel@vger.kernel.org
Subject: [PATCH] don't invalidate non-directory mountpoints
Message-Id: <E1ENqAg-0004bJ-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 07 Oct 2005 13:13:50 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

d_invalidate allowed a non-directory mountpoint to be invalidated,
which is bad, since the mountpoint becomes unreachable.

I know it's racy wrt attaching/detaching mount, but AFAICS so is
everything else that unhashes the dentry.  This seems to be an
oversight when splitting out vfsmount_lock from dcache_lock.  To be
fixed.

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>
---

Index: linux/fs/dcache.c
===================================================================
--- linux.orig/fs/dcache.c	2005-10-04 13:59:57.000000000 +0200
+++ linux/fs/dcache.c	2005-10-07 12:59:11.000000000 +0200
@@ -350,7 +350,8 @@ int d_invalidate(struct dentry * dentry)
 	 */
 	spin_lock(&dentry->d_lock);
 	if (atomic_read(&dentry->d_count) > 1) {
-		if (dentry->d_inode && S_ISDIR(dentry->d_inode->i_mode)) {
+		if (dentry->d_inode && (S_ISDIR(dentry->d_inode->i_mode) ||
+					d_mountpoint(dentry))) {
 			spin_unlock(&dentry->d_lock);
 			spin_unlock(&dcache_lock);
 			return -EBUSY;
