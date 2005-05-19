Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261297AbVESW6P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261297AbVESW6P (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 18:58:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261284AbVESW51
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 18:57:27 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:50594 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261297AbVESW4A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 18:56:00 -0400
To: linux-kernel@vger.kernel.org
Subject: [CFR][PATCH] namei fixes (5/19)
Cc: akpm@osdl.org
Message-Id: <E1DYtwI-0007rD-43@parcelfarce.linux.theplanet.co.uk>
From: Al Viro <viro@www.linux.org.uk>
Date: Thu, 19 May 2005 23:56:26 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(5/19)

fix for too early mntput() in open_namei() - we pin path.mnt down for the
duration of __do_follow_link().  Otherwise we could get the fs where our
symlink lived unmounted while we were in __do_follow_link().  That would
end up with dentry of symlink staying pinned down through the fs shutdown.

Signed-off-by: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
----
diff -urN RC12-rc4-4/fs/namei.c RC12-rc4-5/fs/namei.c
--- RC12-rc4-4/fs/namei.c	2005-05-19 16:39:32.418043961 -0400
+++ RC12-rc4-5/fs/namei.c	2005-05-19 16:39:33.566815053 -0400
@@ -1524,8 +1524,10 @@
 	error = security_inode_follow_link(path.dentry, nd);
 	if (error)
 		goto exit_dput;
+	mntget(path.mnt);
 	error = __do_follow_link(path.dentry, nd);
 	dput(path.dentry);
+	mntput(path.mnt);
 	path.mnt = nd->mnt;
 	if (error)
 		return error;
