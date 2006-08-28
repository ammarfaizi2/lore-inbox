Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932119AbWH1Uxk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932119AbWH1Uxk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 16:53:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932122AbWH1Uxk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 16:53:40 -0400
Received: from rhlx01.fht-esslingen.de ([129.143.116.10]:7332 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id S932121AbWH1Uxj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 16:53:39 -0400
Date: Mon, 28 Aug 2006 22:53:38 +0200
From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
To: Andrew Morton <akpm@osdl.org>
Cc: viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org
Subject: [PATCH -mm] fs/namei.c: replace multiple current->fs by shortcut variable
Message-ID: <20060828205338.GA19064@rhlx01.fht-esslingen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-Priority: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Replace current->fs by fs helper variable to reduce some indirection overhead
and (at least at the moment, before the current_thread_info() %gs PDA
improvement is available) get rid of more costly current references.
Reduces fs/namei.o from 37786 to 37082 Bytes (704 Bytes saved).

Compile-tested and run-tested on 2.6.18-rc4-mm3.


Signed-off-by: Andreas Mohr <andi@lisas.de>

--- linux-2.6.18-rc4-mm3.orig/fs/namei.c	2006-09-04 23:38:48.000000000 +0200
+++ linux-2.6.18-rc4-mm3/fs/namei.c	2006-09-05 22:22:47.000000000 +0200
@@ -518,18 +518,19 @@
 static __always_inline int
 walk_init_root(const char *name, struct nameidata *nd)
 {
-	read_lock(&current->fs->lock);
-	if (current->fs->altroot && !(nd->flags & LOOKUP_NOALT)) {
-		nd->mnt = mntget(current->fs->altrootmnt);
-		nd->dentry = dget(current->fs->altroot);
-		read_unlock(&current->fs->lock);
+	struct fs_struct *fs = current->fs;
+	read_lock(&fs->lock);
+	if (fs->altroot && !(nd->flags & LOOKUP_NOALT)) {
+		nd->mnt = mntget(fs->altrootmnt);
+		nd->dentry = dget(fs->altroot);
+		read_unlock(&fs->lock);
 		if (__emul_lookup_dentry(name,nd))
 			return 0;
-		read_lock(&current->fs->lock);
+		read_lock(&fs->lock);
 	}
-	nd->mnt = mntget(current->fs->rootmnt);
-	nd->dentry = dget(current->fs->root);
-	read_unlock(&current->fs->lock);
+	nd->mnt = mntget(fs->rootmnt);
+	nd->dentry = dget(fs->root);
+	read_unlock(&fs->lock);
 	return 1;
 }
 
@@ -724,17 +725,18 @@
 
 static __always_inline void follow_dotdot(struct nameidata *nd)
 {
+	struct fs_struct *fs = current->fs;
 	while(1) {
 		struct vfsmount *parent;
 		struct dentry *old = nd->dentry;
 
-                read_lock(&current->fs->lock);
-		if (nd->dentry == current->fs->root &&
-		    nd->mnt == current->fs->rootmnt) {
-                        read_unlock(&current->fs->lock);
+                read_lock(&fs->lock);
+		if (nd->dentry == fs->root &&
+		    nd->mnt == fs->rootmnt) {
+                        read_unlock(&fs->lock);
 			break;
 		}
-                read_unlock(&current->fs->lock);
+                read_unlock(&fs->lock);
 		spin_lock(&dcache_lock);
 		if (nd->dentry != nd->mnt->mnt_root) {
 			nd->dentry = dget(nd->dentry->d_parent);
@@ -1042,15 +1044,16 @@
 		struct vfsmount *old_mnt = nd->mnt;
 		struct qstr last = nd->last;
 		int last_type = nd->last_type;
+		struct fs_struct *fs = current->fs;
 		/*
 		 * NAME was not found in alternate root or it's a directory.  Try to find
 		 * it in the normal root:
 		 */
 		nd->last_type = LAST_ROOT;
-		read_lock(&current->fs->lock);
-		nd->mnt = mntget(current->fs->rootmnt);
-		nd->dentry = dget(current->fs->root);
-		read_unlock(&current->fs->lock);
+		read_lock(&fs->lock);
+		nd->mnt = mntget(fs->rootmnt);
+		nd->dentry = dget(fs->root);
+		read_unlock(&fs->lock);
 		if (path_walk(name, nd) == 0) {
 			if (nd->dentry->d_inode) {
 				dput(old_dentry);
@@ -1074,6 +1077,7 @@
 	struct vfsmount *mnt = NULL, *oldmnt;
 	struct dentry *dentry = NULL, *olddentry;
 	int err;
+	struct fs_struct *fs = current->fs;
 
 	if (!emul)
 		goto set_it;
@@ -1083,12 +1087,12 @@
 		dentry = nd.dentry;
 	}
 set_it:
-	write_lock(&current->fs->lock);
-	oldmnt = current->fs->altrootmnt;
-	olddentry = current->fs->altroot;
-	current->fs->altrootmnt = mnt;
-	current->fs->altroot = dentry;
-	write_unlock(&current->fs->lock);
+	write_lock(&fs->lock);
+	oldmnt = fs->altrootmnt;
+	olddentry = fs->altroot;
+	fs->altrootmnt = mnt;
+	fs->altroot = dentry;
+	write_unlock(&fs->lock);
 	if (olddentry) {
 		dput(olddentry);
 		mntput(oldmnt);
@@ -1102,29 +1106,30 @@
 	int retval = 0;
 	int fput_needed;
 	struct file *file;
+	struct fs_struct *fs = current->fs;
 
 	nd->last_type = LAST_ROOT; /* if there are only slashes... */
 	nd->flags = flags;
 	nd->depth = 0;
 
 	if (*name=='/') {
-		read_lock(&current->fs->lock);
-		if (current->fs->altroot && !(nd->flags & LOOKUP_NOALT)) {
-			nd->mnt = mntget(current->fs->altrootmnt);
-			nd->dentry = dget(current->fs->altroot);
-			read_unlock(&current->fs->lock);
+		read_lock(&fs->lock);
+		if (fs->altroot && !(nd->flags & LOOKUP_NOALT)) {
+			nd->mnt = mntget(fs->altrootmnt);
+			nd->dentry = dget(fs->altroot);
+			read_unlock(&fs->lock);
 			if (__emul_lookup_dentry(name,nd))
 				goto out; /* found in altroot */
-			read_lock(&current->fs->lock);
+			read_lock(&fs->lock);
 		}
-		nd->mnt = mntget(current->fs->rootmnt);
-		nd->dentry = dget(current->fs->root);
-		read_unlock(&current->fs->lock);
+		nd->mnt = mntget(fs->rootmnt);
+		nd->dentry = dget(fs->root);
+		read_unlock(&fs->lock);
 	} else if (dfd == AT_FDCWD) {
-		read_lock(&current->fs->lock);
-		nd->mnt = mntget(current->fs->pwdmnt);
-		nd->dentry = dget(current->fs->pwd);
-		read_unlock(&current->fs->lock);
+		read_lock(&fs->lock);
+		nd->mnt = mntget(fs->pwdmnt);
+		nd->dentry = dget(fs->pwd);
+		read_unlock(&fs->lock);
 	} else {
 		struct dentry *dentry;
 
