Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265161AbUFVUHT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265161AbUFVUHT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 16:07:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265107AbUFVT2d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 15:28:33 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:12699 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265146AbUFVTX6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 15:23:58 -0400
To: torvalds@osdl.org
Subject: [PATCH] (1/9) symlink patchkit (against -bk current)
Cc: linux-kernel@vger.kernel.org
Message-Id: <E1Bcqs8-0003xN-Ee@www.linux.org.uk>
From: viro@www.linux.org.uk
Date: Tue, 22 Jun 2004 20:23:56 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

        infrastructure - helpers allowing ->follow_link() to leave
a pathname to be traversed by caller + corresponding code in callers.

diff -urN RC7-bk5-base/fs/namei.c RC7-bk5-core/fs/namei.c
--- RC7-bk5-base/fs/namei.c	Tue Jun 22 13:15:08 2004
+++ RC7-bk5-core/fs/namei.c	Tue Jun 22 15:13:10 2004
@@ -395,6 +395,8 @@
 	return result;
 }
 
+static inline int __vfs_follow_link(struct nameidata *, const char *);
+
 /*
  * This limits recursive symlink follows to 8, while
  * limiting consecutive symlinks to 40.
@@ -405,19 +407,30 @@
 static inline int do_follow_link(struct dentry *dentry, struct nameidata *nd)
 {
 	int err = -ELOOP;
-	if (current->link_count >= 5)
+	if (current->link_count >= MAX_NESTED_LINKS)
 		goto loop;
 	if (current->total_link_count >= 40)
 		goto loop;
+	BUG_ON(nd->depth >= MAX_NESTED_LINKS);
 	cond_resched();
 	err = security_inode_follow_link(dentry, nd);
 	if (err)
 		goto loop;
 	current->link_count++;
 	current->total_link_count++;
+	nd->depth++;
 	touch_atime(nd->mnt, dentry);
+	nd_set_link(nd, NULL);
 	err = dentry->d_inode->i_op->follow_link(dentry, nd);
+	if (!err) {
+		char *s = nd_get_link(nd);
+		if (s)
+			err = __vfs_follow_link(nd, s);
+		if (dentry->d_inode->i_op->put_link)
+			dentry->d_inode->i_op->put_link(dentry, nd);
+	}
 	current->link_count--;
+	nd->depth--;
 	return err;
 loop:
 	path_release(nd);
@@ -587,7 +600,7 @@
 		goto return_reval;
 
 	inode = nd->dentry->d_inode;
-	if (current->link_count)
+	if (nd->depth)
 		lookup_flags = LOOKUP_FOLLOW;
 
 	/* At this point we know we have a real path component. */
@@ -795,6 +808,7 @@
 		 */
 		nd_root.last_type = LAST_ROOT;
 		nd_root.flags = nd->flags;
+		nd_root.depth = 0;
 		memcpy(&nd_root.intent, &nd->intent, sizeof(nd_root.intent));
 		read_lock(&current->fs->lock);
 		nd_root.mnt = mntget(current->fs->rootmnt);
@@ -867,6 +881,7 @@
 
 	nd->last_type = LAST_ROOT; /* if there are only slashes... */
 	nd->flags = flags;
+	nd->depth = 0;
 
 	read_lock(&current->fs->lock);
 	if (*name=='/') {
@@ -1385,7 +1400,15 @@
 	if (error)
 		goto exit_dput;
 	touch_atime(nd->mnt, dentry);
+	nd_set_link(nd, NULL);
 	error = dentry->d_inode->i_op->follow_link(dentry, nd);
+	if (!error) {
+		char *s = nd_get_link(nd);
+		if (s)
+			error = __vfs_follow_link(nd, s);
+		if (dentry->d_inode->i_op->put_link)
+			dentry->d_inode->i_op->put_link(dentry, nd);
+	}
 	dput(dentry);
 	if (error)
 		return error;
@@ -2182,7 +2205,7 @@
 	}
 	res = link_path_walk(link, nd);
 out:
-	if (current->link_count || res || nd->last_type!=LAST_NORM)
+	if (nd->depth || res || nd->last_type!=LAST_NORM)
 		return res;
 	/*
 	 * If it is an iterative symlinks resolution in open_namei() we
diff -urN RC7-bk5-base/include/linux/fs.h RC7-bk5-core/include/linux/fs.h
--- RC7-bk5-base/include/linux/fs.h	Tue Jun 22 13:15:13 2004
+++ RC7-bk5-core/include/linux/fs.h	Tue Jun 22 15:13:10 2004
@@ -902,6 +902,7 @@
 			struct inode *, struct dentry *);
 	int (*readlink) (struct dentry *, char __user *,int);
 	int (*follow_link) (struct dentry *, struct nameidata *);
+	void (*put_link) (struct dentry *, struct nameidata *);
 	void (*truncate) (struct inode *);
 	int (*permission) (struct inode *, int, struct nameidata *);
 	int (*setattr) (struct dentry *, struct iattr *);
diff -urN RC7-bk5-base/include/linux/namei.h RC7-bk5-core/include/linux/namei.h
--- RC7-bk5-base/include/linux/namei.h	Mon Jul 28 11:01:24 2003
+++ RC7-bk5-core/include/linux/namei.h	Tue Jun 22 15:13:10 2004
@@ -10,12 +10,16 @@
 	int	create_mode;
 };
 
+enum { MAX_NESTED_LINKS = 5 };
+
 struct nameidata {
 	struct dentry	*dentry;
 	struct vfsmount *mnt;
 	struct qstr	last;
 	unsigned int	flags;
 	int		last_type;
+	unsigned	depth;
+	char *saved_names[MAX_NESTED_LINKS + 1];
 
 	/* Intent data */
 	union {
@@ -66,5 +70,15 @@
 
 extern struct dentry *lock_rename(struct dentry *, struct dentry *);
 extern void unlock_rename(struct dentry *, struct dentry *);
+
+static inline void nd_set_link(struct nameidata *nd, char *path)
+{
+	nd->saved_names[nd->depth] = path;
+}
+
+static inline char *nd_get_link(struct nameidata *nd)
+{
+	return nd->saved_names[nd->depth];
+}
 
 #endif /* _LINUX_NAMEI_H */
