Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751377AbWARGwE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751377AbWARGwE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 01:52:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964790AbWARGvP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 01:51:15 -0500
Received: from 203-59-65-76.dyn.iinet.net.au ([203.59.65.76]:60569 "EHLO
	eagle.themaw.net") by vger.kernel.org with ESMTP id S1751381AbWARGvH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 01:51:07 -0500
Date: Wed, 18 Jan 2006 14:48:50 +0800
Message-Id: <200601180648.k0I6moiW005845@eagle.themaw.net>
From: Ian Kent <raven@themaw.net>
To: Andrew Morton <akpm@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-fsdevel@vger.kernel.org, autofs@linux.kernel.org
Title: [PATCH 6/13] autofs4 - fix false negative return from expire
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the case where an expire returns busy on a tree
mount when it is in fact not busy. This case was overlooked when
the patch to prevent the expiring away of "scaffolding" directories
for tree mounts was applied.

The problem arises when a tree of mounts is a member of a map
with other keys. The current logic will not expire the tree if
any other mount in the map is busy. The solution is to maintain
a "minimum" use count for each autofs dentry and compare this
to the actual dentry usage count during expire.

Signed-off-by: Ian Kent <raven@themaw.net>


--- linux-2.6.15-mm3/fs/autofs4/inode.c.expire-tree-false-negative	2006-01-13 16:05:10.000000000 +0800
+++ linux-2.6.15-mm3/fs/autofs4/inode.c	2006-01-13 16:17:08.000000000 +0800
@@ -46,6 +46,7 @@ struct autofs_info *autofs4_init_ino(str
 	ino->size = 0;
 
 	ino->last_used = jiffies;
+	atomic_set(&ino->count, 0);
 
 	ino->sbi = sbi;
 
@@ -64,10 +65,19 @@ struct autofs_info *autofs4_init_ino(str
 
 void autofs4_free_ino(struct autofs_info *ino)
 {
+	struct autofs_info *p_ino;
+
 	if (ino->dentry) {
 		ino->dentry->d_fsdata = NULL;
-		if (ino->dentry->d_inode)
+		if (ino->dentry->d_inode) {
+			struct dentry *parent = ino->dentry->d_parent;
+			if (atomic_dec_and_test(&ino->count)) {
+				p_ino = autofs4_dentry_ino(parent);
+				if (p_ino && parent != ino->dentry)
+					atomic_dec(&p_ino->count);
+			}
 			dput(ino->dentry);
+		}
 		ino->dentry = NULL;
 	}
 	if (ino->free)
--- linux-2.6.15-mm3/fs/autofs4/root.c.expire-tree-false-negative	2006-01-13 16:13:33.000000000 +0800
+++ linux-2.6.15-mm3/fs/autofs4/root.c	2006-01-13 16:17:08.000000000 +0800
@@ -490,6 +490,7 @@ static int autofs4_dir_symlink(struct in
 {
 	struct autofs_sb_info *sbi = autofs4_sbi(dir->i_sb);
 	struct autofs_info *ino = autofs4_dentry_ino(dentry);
+	struct autofs_info *p_ino;
 	struct inode *inode;
 	char *cp;
 
@@ -523,6 +524,10 @@ static int autofs4_dir_symlink(struct in
 
 	dentry->d_fsdata = ino;
 	ino->dentry = dget(dentry);
+	atomic_inc(&ino->count);
+	p_ino = autofs4_dentry_ino(dentry->d_parent);
+	if (p_ino && dentry->d_parent != dentry)
+		atomic_inc(&p_ino->count);
 	ino->inode = inode;
 
 	dir->i_mtime = CURRENT_TIME;
@@ -549,11 +554,17 @@ static int autofs4_dir_unlink(struct ino
 {
 	struct autofs_sb_info *sbi = autofs4_sbi(dir->i_sb);
 	struct autofs_info *ino = autofs4_dentry_ino(dentry);
+	struct autofs_info *p_ino;
 	
 	/* This allows root to remove symlinks */
 	if ( !autofs4_oz_mode(sbi) && !capable(CAP_SYS_ADMIN) )
 		return -EACCES;
 
+	if (atomic_dec_and_test(&ino->count)) {
+		p_ino = autofs4_dentry_ino(dentry->d_parent);
+		if (p_ino && dentry->d_parent != dentry)
+			atomic_dec(&p_ino->count);
+	}
 	dput(ino->dentry);
 
 	dentry->d_inode->i_size = 0;
@@ -570,6 +581,7 @@ static int autofs4_dir_rmdir(struct inod
 {
 	struct autofs_sb_info *sbi = autofs4_sbi(dir->i_sb);
 	struct autofs_info *ino = autofs4_dentry_ino(dentry);
+	struct autofs_info *p_ino;
 	
 	if (!autofs4_oz_mode(sbi))
 		return -EACCES;
@@ -584,8 +596,12 @@ static int autofs4_dir_rmdir(struct inod
 	spin_unlock(&dentry->d_lock);
 	spin_unlock(&dcache_lock);
 
+	if (atomic_dec_and_test(&ino->count)) {
+		p_ino = autofs4_dentry_ino(dentry->d_parent);
+		if (p_ino && dentry->d_parent != dentry)
+			atomic_dec(&p_ino->count);
+	}
 	dput(ino->dentry);
-
 	dentry->d_inode->i_size = 0;
 	dentry->d_inode->i_nlink = 0;
 
@@ -599,6 +615,7 @@ static int autofs4_dir_mkdir(struct inod
 {
 	struct autofs_sb_info *sbi = autofs4_sbi(dir->i_sb);
 	struct autofs_info *ino = autofs4_dentry_ino(dentry);
+	struct autofs_info *p_ino;
 	struct inode *inode;
 
 	if ( !autofs4_oz_mode(sbi) )
@@ -621,6 +638,10 @@ static int autofs4_dir_mkdir(struct inod
 
 	dentry->d_fsdata = ino;
 	ino->dentry = dget(dentry);
+	atomic_inc(&ino->count);
+	p_ino = autofs4_dentry_ino(dentry->d_parent);
+	if (p_ino && dentry->d_parent != dentry)
+		atomic_inc(&p_ino->count);
 	ino->inode = inode;
 	dir->i_nlink++;
 	dir->i_mtime = CURRENT_TIME;
--- linux-2.6.15-mm3/fs/autofs4/autofs_i.h.expire-tree-false-negative	2006-01-13 16:13:33.000000000 +0800
+++ linux-2.6.15-mm3/fs/autofs4/autofs_i.h	2006-01-13 16:17:08.000000000 +0800
@@ -54,6 +54,7 @@ struct autofs_info {
 
 	struct autofs_sb_info *sbi;
 	unsigned long last_used;
+	atomic_t count;
 
 	mode_t	mode;
 	size_t	size;
--- linux-2.6.15-mm3/fs/autofs4/expire.c.expire-tree-false-negative	2006-01-13 16:16:14.000000000 +0800
+++ linux-2.6.15-mm3/fs/autofs4/expire.c	2006-01-13 16:19:37.000000000 +0800
@@ -101,6 +101,7 @@ static int autofs4_tree_busy(struct vfsm
 			     unsigned long timeout,
 			     int do_now)
 {
+	struct autofs_info *ino;
 	struct dentry *p;
 
 	DPRINTK("top %p %.*s",
@@ -110,14 +111,6 @@ static int autofs4_tree_busy(struct vfsm
 	if (!simple_positive(top))
 		return 1;
 
-	/* Timeout of a tree mount is determined by its top dentry */
-	if (!autofs4_can_expire(top, timeout, do_now))
-		return 1;
-
-	/* Is someone visiting anywhere in the tree ? */
-	if (may_umount_tree(mnt))
-		return 1;
-
 	spin_lock(&dcache_lock);
 	for (p = top; p; p = next_dentry(p, top)) {
 		/* Negative dentry - give up */
@@ -130,17 +123,40 @@ static int autofs4_tree_busy(struct vfsm
 		p = dget(p);
 		spin_unlock(&dcache_lock);
 
+		/*
+		 * Is someone visiting anywhere in the subtree ?
+		 * If there's no mount we need to check the usage
+		 * count for the autofs dentry.
+		 */
+		ino = autofs4_dentry_ino(p);
 		if (d_mountpoint(p)) {
-			/* First busy => tree busy */
 			if (autofs4_mount_busy(mnt, p)) {
 				dput(p);
 				return 1;
 			}
+		} else {
+			unsigned int ino_count = atomic_read(&ino->count);
+
+			/* allow for dget above and top is already dgot */
+			if (p == top)
+				ino_count += 2;
+			else
+				ino_count++;
+
+			if (atomic_read(&p->d_count) > ino_count) {
+				dput(p);
+				return 1;
+			}
 		}
 		dput(p);
 		spin_lock(&dcache_lock);
 	}
 	spin_unlock(&dcache_lock);
+
+	/* Timeout of a tree mount is ultimately determined by its top dentry */
+	if (!autofs4_can_expire(top, timeout, do_now))
+		return 1;
+
 	return 0;
 }
 
