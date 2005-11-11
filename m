Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932234AbVKKIgF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932234AbVKKIgF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 03:36:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932237AbVKKIgE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 03:36:04 -0500
Received: from i121.durables.org ([64.81.244.121]:5838 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S932234AbVKKIgD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 03:36:03 -0500
Date: Fri, 11 Nov 2005 02:35:49 -0600
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
X-PatchBomber: http://selenic.com/scripts/mailpatches
In-Reply-To: <2.282480653@selenic.com>
Message-Id: <3.282480653@selenic.com>
Subject: [PATCH 2/15] misc: Uninline some namei.c functions
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

uninline various namei.c functions

add/remove: 4/0 grow/shrink: 0/13 up/down: 1077/-3632 (-2555)
function                                     old     new   delta
do_follow_link                                 -     398    +398
follow_dotdot                                  -     380    +380
may_delete                                     -     249    +249
may_create                                     -      50     +50
vfs_follow_link                              411     410      -1
sys_mknod                                    372     371      -1
page_getlink                                 176     175      -1
vfs_create                                   166     149     -17
vfs_symlink                                  140     118     -22
vfs_mknod                                    200     178     -22
vfs_mkdir                                    148     126     -22
vfs_link                                     250     227     -23
vfs_rmdir                                    331     163    -168
vfs_unlink                                   309     131    -178
open_namei                                  1683    1258    -425
vfs_rename                                   988     495    -493
__link_path_walk                            3744    1485   -2259

Signed-off-by: Matt Mackall <mpm@selenic.com>

Index: 2.6.14-misc/fs/namei.c
===================================================================
--- 2.6.14-misc.orig/fs/namei.c	2005-11-01 10:54:33.000000000 -0800
+++ 2.6.14-misc/fs/namei.c	2005-11-09 11:19:35.000000000 -0800
@@ -471,7 +471,7 @@ walk_init_root(const char *name, struct 
 	return 1;
 }
 
-static inline int __vfs_follow_link(struct nameidata *nd, const char *link)
+int vfs_follow_link(struct nameidata *nd, const char *link)
 {
 	int res = 0;
 	char *name;
@@ -528,7 +528,7 @@ static inline int __do_follow_link(struc
 		char *s = nd_get_link(nd);
 		error = 0;
 		if (s)
-			error = __vfs_follow_link(nd, s);
+			error = vfs_follow_link(nd, s);
 		if (dentry->d_inode->i_op->put_link)
 			dentry->d_inode->i_op->put_link(dentry, nd, cookie);
 	}
@@ -561,7 +561,7 @@ static inline void path_to_nameidata(str
  * Without that kind of total limit, nasty chains of consecutive
  * symlinks can cause almost arbitrarily long lookups. 
  */
-static inline int do_follow_link(struct path *path, struct nameidata *nd)
+static int do_follow_link(struct path *path, struct nameidata *nd)
 {
 	int err = -ELOOP;
 	if (current->link_count >= MAX_NESTED_LINKS)
@@ -657,7 +657,7 @@ int follow_down(struct vfsmount **mnt, s
 	return 0;
 }
 
-static inline void follow_dotdot(struct nameidata *nd)
+static void follow_dotdot(struct nameidata *nd)
 {
 	while(1) {
 		struct vfsmount *parent;
@@ -1261,7 +1261,7 @@ static inline int check_sticky(struct in
  * 10. We don't allow removal of NFS sillyrenamed files; it's handled by
  *     nfs_async_unlink().
  */
-static inline int may_delete(struct inode *dir,struct dentry *victim,int isdir)
+static int may_delete(struct inode *dir,struct dentry *victim,int isdir)
 {
 	int error;
 
@@ -1300,7 +1300,7 @@ static inline int may_delete(struct inod
  *  3. We should have write and exec permissions on dir
  *  4. We can't do it if dir is immutable (done in permission())
  */
-static inline int may_create(struct inode *dir, struct dentry *child,
+static int may_create(struct inode *dir, struct dentry *child,
 			     struct nameidata *nd)
 {
 	if (child->d_inode)
@@ -2415,11 +2415,6 @@ int generic_readlink(struct dentry *dent
 	return PTR_ERR(cookie);
 }
 
-int vfs_follow_link(struct nameidata *nd, const char *link)
-{
-	return __vfs_follow_link(nd, link);
-}
-
 /* get the link contents into pagecache */
 static char *page_getlink(struct dentry * dentry, struct page **ppage)
 {
