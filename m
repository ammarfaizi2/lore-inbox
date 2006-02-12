Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751008AbWBLNkn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751008AbWBLNkn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 08:40:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750746AbWBLNkn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 08:40:43 -0500
Received: from 203-59-200-129.dyn.iinet.net.au ([203.59.200.129]:27098 "EHLO
	eagle.themaw.net") by vger.kernel.org with ESMTP id S1750745AbWBLNkk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 08:40:40 -0500
Date: Sun, 12 Feb 2006 21:40:22 +0800
Message-Id: <200602121340.k1CDeM12019289@eagle.themaw.net>
From: Ian Kent <raven@themaw.net>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: linux-fsdevel@vger.kernel.org, autofs@linux.kernel.org
Subject: [RFC:PATCH 3/4] autofs4 - add v5 expire logic
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds expire logic for autofs direct mounts.

--- linux-2.6.16-rc2-mm1/fs/autofs4/expire.c.v5-expire	2006-02-09 20:10:11.000000000 +0800
+++ linux-2.6.16-rc2-mm1/fs/autofs4/expire.c	2006-02-09 20:36:28.000000000 +0800
@@ -4,7 +4,7 @@
  *
  *  Copyright 1997-1998 Transmeta Corporation -- All Rights Reserved
  *  Copyright 1999-2000 Jeremy Fitzhardinge <jeremy@goop.org>
- *  Copyright 2001-2003 Ian Kent <raven@themaw.net>
+ *  Copyright 2001-2006 Ian Kent <raven@themaw.net>
  *
  * This file is part of the Linux kernel and is made available under
  * the terms of the GNU General Public License, version 2, or at your
@@ -99,6 +99,39 @@ static struct dentry *next_dentry(struct
 	return list_entry(next, struct dentry, d_u.d_child);
 }
 
+/*
+ * Check a direct mount point for busyness.
+ * Direct mounts have similar expiry semantics to tree mounts.
+ * The tree is not busy iff no mountpoints are busy and there are no
+ * autofs submounts.
+ */
+static int autofs4_direct_busy(struct vfsmount *mnt,
+				struct dentry *top,
+				unsigned long timeout,
+				int do_now)
+{
+	DPRINTK("top %p %.*s",
+		top, (int) top->d_name.len, top->d_name.name);
+
+	/* Not a mountpoint - give up */
+	if (!d_mountpoint(top))
+		return 1;
+
+	/* If it's busy update the expiry counters */
+	if (!may_umount_tree(mnt)) {
+		struct autofs_info *ino = autofs4_dentry_ino(top);
+		if (ino)
+			ino->last_used = jiffies;
+		return 1;
+	}
+
+	/* Timeout of a direct mount is determined by its top dentry */
+	if (!autofs4_can_expire(top, timeout, do_now))
+		return 1;
+
+	return 0;
+}
+
 /* Check a directory tree of mount points for busyness
  * The tree is not busy iff no mountpoints are busy
  */
@@ -208,16 +241,48 @@ cont:
 	return NULL;
 }
 
+/* Check if we can expire a direct mount (possibly a tree) */
+static struct dentry *autofs4_expire_direct(struct super_block *sb,
+					    struct vfsmount *mnt,
+					    struct autofs_sb_info *sbi,
+					    int how)
+{
+	unsigned long timeout;
+	struct dentry *root = dget(sb->s_root);
+	int do_now = how & AUTOFS_EXP_IMMEDIATE;
+
+	if (!sbi->exp_timeout || !root)
+		return NULL;
+
+	now = jiffies;
+	timeout = sbi->exp_timeout;
+
+	/* Lock the tree as we must expire as a whole */
+	spin_lock(&sbi->fs_lock);
+	if (!autofs4_direct_busy(mnt, root, timeout, do_now)) {
+		struct autofs_info *ino = autofs4_dentry_ino(root);
+
+		/* Set this flag early to catch sys_chdir and the like */
+		ino->flags |= AUTOFS_INF_EXPIRING;
+		spin_unlock(&sbi->fs_lock);
+		return root;
+	}
+	spin_unlock(&sbi->fs_lock);
+	dput(root);
+
+	return NULL;
+}
+
 /*
  * Find an eligible tree to time-out
  * A tree is eligible if :-
  *  - it is unused by any user process
  *  - it has been unused for exp_timeout time
  */
-static struct dentry *autofs4_expire(struct super_block *sb,
-				     struct vfsmount *mnt,
-				     struct autofs_sb_info *sbi,
-				     int how)
+static struct dentry *autofs4_expire_indirect(struct super_block *sb,
+					      struct vfsmount *mnt,
+					      struct autofs_sb_info *sbi,
+					      int how)
 {
 	unsigned long timeout;
 	struct dentry *root = sb->s_root;
@@ -249,7 +314,12 @@ static struct dentry *autofs4_expire(str
 		dentry = dget(dentry);
 		spin_unlock(&dcache_lock);
 
-		/* Case 1: indirect mount or top level direct mount */
+		/*
+		 * Case 1: (i) indirect mount or top level pseudo direct mount
+		 *	   (autofs-4.1).
+		 *	   (ii) indirect mount with offset mount, check the "/"
+		 *	   offset (autofs-5.0+).
+		 */
 		if (d_mountpoint(dentry)) {
 			DPRINTK("checking mountpoint %p %.*s",
 				dentry, (int)dentry->d_name.len, dentry->d_name.name);
@@ -283,7 +353,10 @@ static struct dentry *autofs4_expire(str
 				break;
 			}
 			spin_unlock(&sbi->fs_lock);
-		/* Case 3: direct mount, expire individual leaves */
+		/*
+		 * Case 3: pseudo direct mount, expire individual leaves
+		 *	   (autofs-4.1).
+		 */
 		} else {
 			expired = autofs4_check_leaves(mnt, dentry, timeout, do_now);
 			if (expired) {
@@ -325,7 +398,7 @@ int autofs4_expire_run(struct super_bloc
 	pkt.hdr.proto_version = sbi->version;
 	pkt.hdr.type = autofs_ptype_expire;
 
-	if ((dentry = autofs4_expire(sb, mnt, sbi, 0)) == NULL)
+	if ((dentry = autofs4_expire_indirect(sb, mnt, sbi, 0)) == NULL)
 		return -EAGAIN;
 
 	pkt.len = dentry->d_name.len;
@@ -351,7 +424,12 @@ int autofs4_expire_multi(struct super_bl
 	if (arg && get_user(do_now, arg))
 		return -EFAULT;
 
-	if ((dentry = autofs4_expire(sb, mnt, sbi, do_now)) != NULL) {
+	if (sbi->type & AUTOFS_TYP_DIRECT)
+		dentry = autofs4_expire_direct(sb, mnt, sbi, do_now);
+	else
+		dentry = autofs4_expire_indirect(sb, mnt, sbi, do_now);
+
+	if (dentry) {
 		struct autofs_info *ino = autofs4_dentry_ino(dentry);
 
 		/* This is synchronous because it makes the daemon a
