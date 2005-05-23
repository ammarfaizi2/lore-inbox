Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261252AbVEWMIm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261252AbVEWMIm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 May 2005 08:08:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261249AbVEWMIm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 May 2005 08:08:42 -0400
Received: from rev.193.226.233.9.euroweb.hu ([193.226.233.9]:11268 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S261252AbVEWMIN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 May 2005 08:08:13 -0400
To: viro@www.linux.org.uk
CC: linux-kernel@vger.kernel.org, akpm@osdl.org
In-reply-to: <E1DYtvs-0007qF-U8@parcelfarce.linux.theplanet.co.uk> (message
	from Al Viro on Thu, 19 May 2005 23:56:00 +0100)
Subject: Re: [PATCHSET] namei fixes
References: <E1DYtvs-0007qF-U8@parcelfarce.linux.theplanet.co.uk>
Message-Id: <E1DaBij-0002QW-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 23 May 2005 14:07:45 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I reviewed the patchset (not the individual patches, rather the end
result), and it seems OK to me. 

It would be nice, if there was a comment about sharing the refcount
for path->mnt and nd->mnt, and how __follow_mount and __do_follow_link
deal with this.

Also, I think it would improve readability if the dealings with struct
path were extracted into separate functions.  Something like the
attached patch.

Miklos

Index: linux/fs/namei.c
===================================================================
--- linux.orig/fs/namei.c	2005-05-23 13:36:05.000000000 +0200
+++ linux/fs/namei.c	2005-05-23 13:47:21.000000000 +0200
@@ -522,6 +522,22 @@ static inline int __do_follow_link(struc
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
@@ -549,9 +565,7 @@ static inline int do_follow_link(struct 
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
@@ -810,13 +824,8 @@ static fastcall int __link_path_walk(con
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
@@ -856,13 +865,8 @@ last_component:
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
@@ -898,9 +902,7 @@ return_reval:
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
@@ -1504,11 +1506,7 @@ do_last:
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
@@ -1519,9 +1517,7 @@ ok:
 	return 0;
 
 exit_dput:
-	dput(path.dentry);
-	if (nd->mnt != path.mnt)
-		mntput(path.mnt);
+	dput_path(&path, nd);
 exit:
 	path_release(nd);
 	return error;

