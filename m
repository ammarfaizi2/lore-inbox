Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932374AbVHWU1P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932374AbVHWU1P (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 16:27:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932376AbVHWU1P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 16:27:15 -0400
Received: from adsl-266.mirage.euroweb.hu ([193.226.239.10]:2058 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S932374AbVHWU1O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 16:27:14 -0400
To: akpm@osdl.org
CC: linux-kernel@vger.kernel.org, viro@parcelfarce.linux.theplanet.co.uk
In-reply-to: <E1E7fJu-0006EB-00@dorka.pomaz.szeredi.hu> (message from Miklos
	Szeredi on Tue, 23 Aug 2005 22:24:30 +0200)
Subject: [PATCH 2/8] namei cleanup
References: <E1E7fHs-0006DO-00@dorka.pomaz.szeredi.hu> <E1E7fJu-0006EB-00@dorka.pomaz.szeredi.hu>
Message-Id: <E1E7fMD-0006En-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 23 Aug 2005 22:26:53 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Extract common code into inline functions to make reading easier.

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>

Index: linux/fs/namei.c
===================================================================
--- linux.orig/fs/namei.c	2005-08-23 20:25:53.000000000 +0200
+++ linux/fs/namei.c	2005-08-23 21:00:02.000000000 +0200
@@ -525,6 +525,22 @@ static inline int __do_follow_link(struc
 	return error;
 }
 
+static inline void dput_path(struct path *path, struct nameidata *nd)
+{
+	dput(path->dentry);
+	if (path->mnt != nd->mnt)
+		mntput(path->mnt);
+}
+
+static inline void path_to_nameidata(struct path *path, struct nameidata *nd)
+{
+	dput(nd->dentry);
+	if (nd->mnt != path->mnt)
+		mntput(nd->mnt);
+	nd->mnt = path->mnt;
+	nd->dentry = path->dentry;
+}
+
 /*
  * This limits recursive symlink follows to 8, while
  * limiting consecutive symlinks to 40.
@@ -552,9 +568,7 @@ static inline int do_follow_link(struct 
 	nd->depth--;
 	return err;
 loop:
-	dput(path->dentry);
-	if (path->mnt != nd->mnt)
-		mntput(path->mnt);
+	dput_path(path, nd);
 	path_release(nd);
 	return err;
 }
@@ -813,13 +827,8 @@ static fastcall int __link_path_walk(con
 			err = -ENOTDIR; 
 			if (!inode->i_op)
 				break;
-		} else {
-			dput(nd->dentry);
-			if (nd->mnt != next.mnt)
-				mntput(nd->mnt);
-			nd->mnt = next.mnt;
-			nd->dentry = next.dentry;
-		}
+		} else
+			path_to_nameidata(&next, nd);
 		err = -ENOTDIR; 
 		if (!inode->i_op->lookup)
 			break;
@@ -859,13 +868,8 @@ last_component:
 			if (err)
 				goto return_err;
 			inode = nd->dentry->d_inode;
-		} else {
-			dput(nd->dentry);
-			if (nd->mnt != next.mnt)
-				mntput(nd->mnt);
-			nd->mnt = next.mnt;
-			nd->dentry = next.dentry;
-		}
+		} else
+			path_to_nameidata(&next, nd);
 		err = -ENOENT;
 		if (!inode)
 			break;
@@ -901,9 +905,7 @@ return_reval:
 return_base:
 		return 0;
 out_dput:
-		dput(next.dentry);
-		if (nd->mnt != next.mnt)
-			mntput(next.mnt);
+		dput_path(&next, nd);
 		break;
 	}
 	path_release(nd);
@@ -1505,11 +1507,7 @@ do_last:
 	if (path.dentry->d_inode->i_op && path.dentry->d_inode->i_op->follow_link)
 		goto do_link;
 
-	dput(nd->dentry);
-	nd->dentry = path.dentry;
-	if (nd->mnt != path.mnt)
-		mntput(nd->mnt);
-	nd->mnt = path.mnt;
+	path_to_nameidata(&path, nd);
 	error = -EISDIR;
 	if (path.dentry->d_inode && S_ISDIR(path.dentry->d_inode->i_mode))
 		goto exit;
@@ -1520,9 +1518,7 @@ ok:
 	return 0;
 
 exit_dput:
-	dput(path.dentry);
-	if (nd->mnt != path.mnt)
-		mntput(path.mnt);
+	dput_path(&path, nd);
 exit:
 	path_release(nd);
 	return error;
