Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261303AbVESX7U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261303AbVESX7U (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 19:59:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261294AbVESXUl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 19:20:41 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:59042 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261310AbVESW5B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 18:57:01 -0400
To: linux-kernel@vger.kernel.org
Subject: [CFR][PATCH] namei fixes (17/19)
Cc: akpm@osdl.org
Message-Id: <E1DYtxG-0007td-Kx@parcelfarce.linux.theplanet.co.uk>
From: Al Viro <viro@www.linux.org.uk>
Date: Thu, 19 May 2005 23:57:26 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(17/19)

follow_mount() made void, reordered dput()/mntput() in it.

follow_dotdot() switched from struct vfmount ** + struct dentry ** to
struct nameidata *; callers updated.

Equivalent transformation + fix for too-early-mntput() race.

Signed-off-by: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
----
diff -urN RC12-rc4-16/fs/namei.c RC12-rc4-17/fs/namei.c
--- RC12-rc4-16/fs/namei.c	2005-05-19 16:39:45.837369971 -0400
+++ RC12-rc4-17/fs/namei.c	2005-05-19 16:39:46.911156004 -0400
@@ -596,20 +596,17 @@
 	return res;
 }
 
-static int follow_mount(struct vfsmount **mnt, struct dentry **dentry)
+static void follow_mount(struct vfsmount **mnt, struct dentry **dentry)
 {
-	int res = 0;
 	while (d_mountpoint(*dentry)) {
 		struct vfsmount *mounted = lookup_mnt(*mnt, *dentry);
 		if (!mounted)
 			break;
+		dput(*dentry);
 		mntput(*mnt);
 		*mnt = mounted;
-		dput(*dentry);
 		*dentry = dget(mounted->mnt_root);
-		res = 1;
 	}
-	return res;
 }
 
 /* no need for dcache_lock, as serialization is taken care in
@@ -630,41 +627,41 @@
 	return 0;
 }
 
-static inline void follow_dotdot(struct vfsmount **mnt, struct dentry **dentry)
+static inline void follow_dotdot(struct nameidata *nd)
 {
 	while(1) {
 		struct vfsmount *parent;
-		struct dentry *old = *dentry;
+		struct dentry *old = nd->dentry;
 
                 read_lock(&current->fs->lock);
-		if (*dentry == current->fs->root &&
-		    *mnt == current->fs->rootmnt) {
+		if (nd->dentry == current->fs->root &&
+		    nd->mnt == current->fs->rootmnt) {
                         read_unlock(&current->fs->lock);
 			break;
 		}
                 read_unlock(&current->fs->lock);
 		spin_lock(&dcache_lock);
-		if (*dentry != (*mnt)->mnt_root) {
-			*dentry = dget((*dentry)->d_parent);
+		if (nd->dentry != nd->mnt->mnt_root) {
+			nd->dentry = dget(nd->dentry->d_parent);
 			spin_unlock(&dcache_lock);
 			dput(old);
 			break;
 		}
 		spin_unlock(&dcache_lock);
 		spin_lock(&vfsmount_lock);
-		parent = (*mnt)->mnt_parent;
-		if (parent == *mnt) {
+		parent = nd->mnt->mnt_parent;
+		if (parent == nd->mnt) {
 			spin_unlock(&vfsmount_lock);
 			break;
 		}
 		mntget(parent);
-		*dentry = dget((*mnt)->mnt_mountpoint);
+		nd->dentry = dget(nd->mnt->mnt_mountpoint);
 		spin_unlock(&vfsmount_lock);
 		dput(old);
-		mntput(*mnt);
-		*mnt = parent;
+		mntput(nd->mnt);
+		nd->mnt = parent;
 	}
-	follow_mount(mnt, dentry);
+	follow_mount(&nd->mnt, &nd->dentry);
 }
 
 /*
@@ -772,7 +769,7 @@
 			case 2:	
 				if (this.name[1] != '.')
 					break;
-				follow_dotdot(&nd->mnt, &nd->dentry);
+				follow_dotdot(nd);
 				inode = nd->dentry->d_inode;
 				/* fallthrough */
 			case 1:
@@ -839,7 +836,7 @@
 			case 2:	
 				if (this.name[1] != '.')
 					break;
-				follow_dotdot(&nd->mnt, &nd->dentry);
+				follow_dotdot(nd);
 				inode = nd->dentry->d_inode;
 				/* fallthrough */
 			case 1:
