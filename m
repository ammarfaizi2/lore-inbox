Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261316AbVESW6O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261316AbVESW6O (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 18:58:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261297AbVESW5i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 18:57:38 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:51106 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261300AbVESW4F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 18:56:05 -0400
To: linux-kernel@vger.kernel.org
Subject: [CFR][PATCH] namei fixes (6/19)
Cc: akpm@osdl.org
Message-Id: <E1DYtwN-0007rL-5L@parcelfarce.linux.theplanet.co.uk>
From: Al Viro <viro@www.linux.org.uk>
Date: Thu, 19 May 2005 23:56:31 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(6/19)

mntget(path->mnt) in do_follow_link() moved down to right before the
__do_follow_link() call and rigth after loop: resp.

dput()+mntput() on non-ELOOP branch moved up to right after __do_follow_link()
call.

resulting
loop:
	mntget(path->mnt);
	path_release(nd);
	dput(path->mnt);
	mntput(path->mnt);
replaced with equivalent
	dput(path->mnt);
	path_release(nd);

Equivalent transformations - the reason why we have that mntget() is
that __do_follow_link() can drop a reference to nd->mnt and that's what
holds path->mnt.  So that call can happen at any point prior to
__do_follow_link() touching nd->mnt.  The rest is obvious.

NOTE: current tree relies on symlinks *never* being mounted on anything.
It's not hard to get rid of that assumption (actually, that will come for
free later in the series).  For now we are just not making the situation
worse than it is.

Signed-off-by: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
----
diff -urN RC12-rc4-5/fs/namei.c RC12-rc4-6/fs/namei.c
--- RC12-rc4-5/fs/namei.c	2005-05-19 16:39:33.566815053 -0400
+++ RC12-rc4-6/fs/namei.c	2005-05-19 16:39:34.668595507 -0400
@@ -526,7 +526,6 @@
 static inline int do_follow_link(struct path *path, struct nameidata *nd)
 {
 	int err = -ELOOP;
-	mntget(path->mnt);
 	if (current->link_count >= MAX_NESTED_LINKS)
 		goto loop;
 	if (current->total_link_count >= 40)
@@ -539,16 +538,16 @@
 	current->link_count++;
 	current->total_link_count++;
 	nd->depth++;
+	mntget(path->mnt);
 	err = __do_follow_link(path->dentry, nd);
-	current->link_count--;
-	nd->depth--;
 	dput(path->dentry);
 	mntput(path->mnt);
+	current->link_count--;
+	nd->depth--;
 	return err;
 loop:
-	path_release(nd);
 	dput(path->dentry);
-	mntput(path->mnt);
+	path_release(nd);
 	return err;
 }
 
