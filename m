Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261308AbVESXWW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261308AbVESXWW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 19:22:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261309AbVESXVR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 19:21:17 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:57506 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261308AbVESW4u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 18:56:50 -0400
To: linux-kernel@vger.kernel.org
Subject: [CFR][PATCH] namei fixes (15/19)
Cc: akpm@osdl.org
Message-Id: <E1DYtx6-0007tC-IF@parcelfarce.linux.theplanet.co.uk>
From: Al Viro <viro@www.linux.org.uk>
Date: Thu, 19 May 2005 23:57:16 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(15/19)

Getting rid of sloppy logics:

a) in do_follow_link() we have the wrong vfsmount dropped if our symlink
had been mounted on something.  Currently it worls only because we never
get such situation (modulo filesystem playing dirty tricks on us).  And
it obfuscates already convoluted logics...

b) same goes for open_namei().

c) in __link_path_walk() we have another "it should never happen" sloppiness -
out_dput: there does double-free on underlying vfsmount and leaks the covering
one if we hit it just after crossing a mountpoint.  Again, wrong vfsmount
getting dropped.

d) another too-early-mntput() race - in do_follow_mount() we need to postpone
conditional mntput(path->mnt) until after dput(path->dentry).  Again, this one
happens only in it-currently-never-happens-unless-some-fs-plays-dirty
scenario...

Signed-off-by: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
----
diff -urN RC12-rc4-14/fs/namei.c RC12-rc4-15/fs/namei.c
--- RC12-rc4-14/fs/namei.c	2005-05-19 16:39:43.660803683 -0400
+++ RC12-rc4-15/fs/namei.c	2005-05-19 16:39:44.743587923 -0400
@@ -544,15 +544,15 @@
 	current->total_link_count++;
 	nd->depth++;
 	if (path->mnt != nd->mnt)
-		mntput(nd->mnt);
+		mntput(path->mnt);
 	err = __do_follow_link(path, nd);
 	current->link_count--;
 	nd->depth--;
 	return err;
 loop:
-	if (path->mnt != nd->mnt)
-		mntput(nd->mnt);
 	dput(path->dentry);
+	if (path->mnt != nd->mnt)
+		mntput(path->mnt);
 	path_release(nd);
 	return err;
 }
@@ -906,7 +906,7 @@
 out_dput:
 		dput(next.dentry);
 		if (nd->mnt != next.mnt)
-			mntput(nd->mnt);
+			mntput(next.mnt);
 		break;
 	}
 	path_release(nd);
@@ -1551,8 +1551,7 @@
 	if (error)
 		goto exit_dput;
 	if (nd->mnt != path.mnt)
-		mntput(nd->mnt);
-	nd->mnt = path.mnt;
+		mntput(path.mnt);
 	error = __do_follow_link(&path, nd);
 	if (error)
 		return error;
