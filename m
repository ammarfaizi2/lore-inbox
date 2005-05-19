Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261302AbVESX0Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261302AbVESX0Z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 19:26:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261332AbVESXYp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 19:24:45 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:52642 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261299AbVESW4P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 18:56:15 -0400
To: linux-kernel@vger.kernel.org
Subject: [CFR][PATCH] namei fixes (8/19)
Cc: akpm@osdl.org
Message-Id: <E1DYtwX-0007rg-7k@parcelfarce.linux.theplanet.co.uk>
From: Al Viro <viro@www.linux.org.uk>
Date: Thu, 19 May 2005 23:56:41 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(8/19)

In open_namei() we never use path.mnt or path.dentry after exit: or ok:.
Assignment of path.dentry in case of LAST_BIND is dead code and only
obfuscates already convoluted function; assignment of path.mnt after
__do_follow_link() can be moved down to the place where we set path.dentry.

Obviously equivalent transformations, just to clean the air a bit in that
region.

Signed-off-by: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
----
diff -urN RC12-rc4-7/fs/namei.c RC12-rc4-8/fs/namei.c
--- RC12-rc4-7/fs/namei.c	2005-05-19 16:39:35.831363809 -0400
+++ RC12-rc4-8/fs/namei.c	2005-05-19 16:39:36.950140877 -0400
@@ -1526,14 +1526,11 @@
 	if (error)
 		goto exit_dput;
 	error = __do_follow_link(&path, nd);
-	path.mnt = nd->mnt;
 	if (error)
 		return error;
 	nd->flags &= ~LOOKUP_PARENT;
-	if (nd->last_type == LAST_BIND) {
-		path.dentry = nd->dentry;
+	if (nd->last_type == LAST_BIND)
 		goto ok;
-	}
 	error = -EISDIR;
 	if (nd->last_type != LAST_NORM)
 		goto exit;
@@ -1549,6 +1546,7 @@
 	dir = nd->dentry;
 	down(&dir->d_inode->i_sem);
 	path.dentry = __lookup_hash(&nd->last, nd->dentry, nd);
+	path.mnt = nd->mnt;
 	putname(nd->last.name);
 	goto do_last;
 }
