Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261284AbVESW6P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261284AbVESW6P (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 18:58:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261296AbVESW5W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 18:57:22 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:50082 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261284AbVESWzz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 18:55:55 -0400
To: linux-kernel@vger.kernel.org
Subject: [CFR][PATCH] namei fixes (4/19)
Cc: akpm@osdl.org
Message-Id: <E1DYtwD-0007r1-25@parcelfarce.linux.theplanet.co.uk>
From: Al Viro <viro@www.linux.org.uk>
Date: Thu, 19 May 2005 23:56:21 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(4/19)

path.mnt in open_namei() set to mirror nd->mnt.

nd->mnt is set in 3 places in that function - path_lookup() in the
beginning, __follow_down() loop after do_last: and __do_follow_link()
call after do_link:.

We set path.mnt to nd->mnt after path_lookup() and __do_follow_link().
In __follow_down() loop we use &path.mnt instead of &nd->mnt and set
nd->mnt to path.mnt immediately after that loop.

Obviously equivalent transformation.

Signed-off-by: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
----
diff -urN RC12-rc4-3/fs/namei.c RC12-rc4-4/fs/namei.c
--- RC12-rc4-3/fs/namei.c	2005-05-19 16:39:31.314263905 -0400
+++ RC12-rc4-4/fs/namei.c	2005-05-19 16:39:32.418043961 -0400
@@ -1442,6 +1442,7 @@
 	nd->flags &= ~LOOKUP_PARENT;
 	down(&dir->d_inode->i_sem);
 	path.dentry = __lookup_hash(&nd->last, nd->dentry, nd);
+	path.mnt = nd->mnt;
 
 do_last:
 	error = PTR_ERR(path.dentry);
@@ -1479,7 +1480,8 @@
 		error = -ELOOP;
 		if (flag & O_NOFOLLOW)
 			goto exit_dput;
-		while (__follow_down(&nd->mnt,&path.dentry) && d_mountpoint(path.dentry));
+		while (__follow_down(&path.mnt,&path.dentry) && d_mountpoint(path.dentry));
+		nd->mnt = path.mnt;
 	}
 	error = -ENOENT;
 	if (!path.dentry->d_inode)
@@ -1524,6 +1526,7 @@
 		goto exit_dput;
 	error = __do_follow_link(path.dentry, nd);
 	dput(path.dentry);
+	path.mnt = nd->mnt;
 	if (error)
 		return error;
 	nd->flags &= ~LOOKUP_PARENT;
