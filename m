Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964968AbWARHXm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964968AbWARHXm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 02:23:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964969AbWARHXl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 02:23:41 -0500
Received: from 203-59-65-76.dyn.iinet.net.au ([203.59.65.76]:15301 "EHLO
	eagle.themaw.net") by vger.kernel.org with ESMTP id S964966AbWARHXh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 02:23:37 -0500
Date: Wed, 18 Jan 2006 15:23:01 +0800
Message-Id: <200601180723.k0I7N1VM006144@eagle.themaw.net>
From: Ian Kent <raven@themaw.net>
To: Andrew Morton <akpm@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-fsdevel@vger.kernel.org, autofs@linux.kernel.org
Subject: [PATCH 4/13] autofs4 - expire code readability cleanup
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch changes the names of the boolean functions autofs4_check_mount
and autofs4_check_tree to autofs4_mount_busy and autofs4_tree_busy
respectively and alters their return codes to suit in order to aid
code readabilty.

A couple of white space cleanups are included as well.

Signed-off-by: Ian Kent <raven@themaw.net>


--- linux-2.6.15-mm2/fs/autofs4/expire.c.expire-cleanup	2006-01-12 15:06:52.000000000 +0800
+++ linux-2.6.15-mm2/fs/autofs4/expire.c	2006-01-12 15:11:55.000000000 +0800
@@ -16,7 +16,7 @@
 
 static unsigned long now;
 
-/* Check if a dentry can be expired return 1 if it can else return 0 */
+/* Check if a dentry can be expired */
 static inline int autofs4_can_expire(struct dentry *dentry,
 					unsigned long timeout, int do_now)
 {
@@ -41,14 +41,13 @@ static inline int autofs4_can_expire(str
 		     attempts if expire fails the first time */
 		ino->last_used = now;
 	}
-
 	return 1;
 }
 
-/* Check a mount point for busyness return 1 if not busy, otherwise */
-static int autofs4_check_mount(struct vfsmount *mnt, struct dentry *dentry)
+/* Check a mount point for busyness */
+static int autofs4_mount_busy(struct vfsmount *mnt, struct dentry *dentry)
 {
-	int status = 0;
+	int status = 1;
 
 	DPRINTK("dentry %p %.*s",
 		dentry, (int)dentry->d_name.len, dentry->d_name.name);
@@ -65,7 +64,7 @@ static int autofs4_check_mount(struct vf
 
 	/* The big question */
 	if (may_umount_tree(mnt) == 0)
-		status = 1;
+		status = 0;
 done:
 	DPRINTK("returning = %d", status);
 	mntput(mnt);
@@ -75,30 +74,29 @@ done:
 
 /* Check a directory tree of mount points for busyness
  * The tree is not busy iff no mountpoints are busy
- * Return 1 if the tree is busy or 0 otherwise
  */
-static int autofs4_check_tree(struct vfsmount *mnt,
-	       		      struct dentry *top,
-			      unsigned long timeout,
-			      int do_now)
+static int autofs4_tree_busy(struct vfsmount *mnt,
+	       		     struct dentry *top,
+			     unsigned long timeout,
+			     int do_now)
 {
 	struct dentry *this_parent = top;
 	struct list_head *next;
 
-	DPRINTK("parent %p %.*s",
+	DPRINTK("top %p %.*s",
 		top, (int)top->d_name.len, top->d_name.name);
 
 	/* Negative dentry - give up */
 	if (!simple_positive(top))
-		return 0;
+		return 1;
 
 	/* Timeout of a tree mount is determined by its top dentry */
 	if (!autofs4_can_expire(top, timeout, do_now))
-		return 0;
+		return 1;
 
 	/* Is someone visiting anywhere in the tree ? */
 	if (may_umount_tree(mnt))
-		return 0;
+		return 1;
 
 	spin_lock(&dcache_lock);
 repeat:
@@ -126,9 +124,9 @@ resume:
 
 		if (d_mountpoint(dentry)) {
 			/* First busy => tree busy */
-			if (!autofs4_check_mount(mnt, dentry)) {
+			if (autofs4_mount_busy(mnt, dentry)) {
 				dput(dentry);
-				return 0;
+				return 1;
 			}
 		}
 
@@ -144,7 +142,7 @@ resume:
 	}
 	spin_unlock(&dcache_lock);
 
-	return 1;
+	return 0;
 }
 
 static struct dentry *autofs4_check_leaves(struct vfsmount *mnt,
@@ -188,7 +186,7 @@ resume:
 				goto cont;
 
 			/* Can we umount this guy */
-			if (autofs4_check_mount(mnt, dentry))
+			if (!autofs4_mount_busy(mnt, dentry))
 				return dentry;
 
 		}
@@ -241,7 +239,7 @@ static struct dentry *autofs4_expire(str
 		struct dentry *dentry = list_entry(next, struct dentry, d_u.d_child);
 
 		/* Negative dentry - give up */
-		if ( !simple_positive(dentry) ) {
+		if (!simple_positive(dentry)) {
 			next = next->next;
 			continue;
 		}
@@ -259,21 +257,21 @@ static struct dentry *autofs4_expire(str
 				goto next;
 
 			/* Can we umount this guy */
-			if (autofs4_check_mount(mnt, dentry)) {
+			if (!autofs4_mount_busy(mnt, dentry)) {
 				expired = dentry;
 				break;
 			}
 			goto next;
 		}
 
-		if ( simple_empty(dentry) )
+		if (simple_empty(dentry))
 			goto next;
 
 		/* Case 2: tree mount, expire iff entire tree is not busy */
 		if (!exp_leaves) {
 			/* Lock the tree as we must expire as a whole */
 			spin_lock(&sbi->fs_lock);
-			if (autofs4_check_tree(mnt, dentry, timeout, do_now)) {
+			if (!autofs4_tree_busy(mnt, dentry, timeout, do_now)) {
 				struct autofs_info *inf = autofs4_dentry_ino(dentry);
 
 				/* Set this flag early to catch sys_chdir and the like */
@@ -297,7 +295,7 @@ next:
 		next = next->next;
 	}
 
-	if ( expired ) {
+	if (expired) {
 		DPRINTK("returning %p %.*s",
 			expired, (int)expired->d_name.len, expired->d_name.name);
 		spin_lock(&dcache_lock);
@@ -352,16 +350,16 @@ int autofs4_expire_multi(struct super_bl
 		return -EFAULT;
 
 	if ((dentry = autofs4_expire(sb, mnt, sbi, do_now)) != NULL) {
-		struct autofs_info *de_info = autofs4_dentry_ino(dentry);
+		struct autofs_info *ino = autofs4_dentry_ino(dentry);
 
 		/* This is synchronous because it makes the daemon a
                    little easier */
-		de_info->flags |= AUTOFS_INF_EXPIRING;
+		ino->flags |= AUTOFS_INF_EXPIRING;
 		ret = autofs4_wait(sbi, dentry, NFY_EXPIRE);
-		de_info->flags &= ~AUTOFS_INF_EXPIRING;
+		ino->flags &= ~AUTOFS_INF_EXPIRING;
 		dput(dentry);
 	}
-		
+
 	return ret;
 }
 
