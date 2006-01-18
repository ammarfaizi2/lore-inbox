Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030276AbWARH1y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030276AbWARH1y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 02:27:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030286AbWARH1x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 02:27:53 -0500
Received: from 203-59-65-76.dyn.iinet.net.au ([203.59.65.76]:18117 "EHLO
	eagle.themaw.net") by vger.kernel.org with ESMTP id S1030276AbWARHYI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 02:24:08 -0500
Date: Wed, 18 Jan 2006 15:23:32 +0800
Message-Id: <200601180723.k0I7NWgh006169@eagle.themaw.net>
From: Ian Kent <raven@themaw.net>
To: Andrew Morton <akpm@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-fsdevel@vger.kernel.org, autofs@linux.kernel.org
Subject: [PATCH 7/13] autofs4 - expire mounts that hold no (extra) references only
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch alters the expire semantics that define how "busyness"
is determined. Currently a last_used counter is updated on every
revalidate from processes other than the mount owner process group.

This patch changes that so that an expire candidate is busy only if it
has a reference count greater than the expected minimum, such as
when there is an open file or working directory in use.

This method is the only way that busyness can be established for
direct mounts within the new implementation. For consistency the
expire semantic is made the same for all mounts.

A side effect of the patch is that mounts which remain mounted
unessessarily in the presence of some GUI programs that scan the
filesystem should now expire.

Signed-off-by: Ian Kent <raven@themaw.net>


--- linux-2.6.15-mm3/fs/autofs4/expire.c.expire-not-busy-only	2006-01-13 19:11:26.000000000 +0800
+++ linux-2.6.15-mm3/fs/autofs4/expire.c	2006-01-13 19:16:47.000000000 +0800
@@ -47,6 +47,7 @@ static inline int autofs4_can_expire(str
 /* Check a mount point for busyness */
 static int autofs4_mount_busy(struct vfsmount *mnt, struct dentry *dentry)
 {
+	struct dentry *top = dentry;
 	int status = 1;
 
 	DPRINTK("dentry %p %.*s",
@@ -62,9 +63,14 @@ static int autofs4_mount_busy(struct vfs
 	if (is_autofs4_dentry(dentry))
 		goto done;
 
-	/* The big question */
-	if (may_umount_tree(mnt) == 0)
-		status = 0;
+	/* Update the expiry counter if fs is busy */
+	if (may_umount_tree(mnt)) {
+		struct autofs_info *ino = autofs4_dentry_ino(top);
+		ino->last_used = jiffies;
+		goto done;
+	}
+
+	status = 0;
 done:
 	DPRINTK("returning = %d", status);
 	mntput(mnt);
@@ -101,7 +107,7 @@ static int autofs4_tree_busy(struct vfsm
 			     unsigned long timeout,
 			     int do_now)
 {
-	struct autofs_info *ino;
+	struct autofs_info *top_ino = autofs4_dentry_ino(top);
 	struct dentry *p;
 
 	DPRINTK("top %p %.*s",
@@ -127,14 +133,16 @@ static int autofs4_tree_busy(struct vfsm
 		 * Is someone visiting anywhere in the subtree ?
 		 * If there's no mount we need to check the usage
 		 * count for the autofs dentry.
+		 * If the fs is busy update the expiry counter.
 		 */
-		ino = autofs4_dentry_ino(p);
 		if (d_mountpoint(p)) {
 			if (autofs4_mount_busy(mnt, p)) {
+				top_ino->last_used = jiffies;
 				dput(p);
 				return 1;
 			}
 		} else {
+			struct autofs_info *ino = autofs4_dentry_ino(p);
 			unsigned int ino_count = atomic_read(&ino->count);
 
 			/* allow for dget above and top is already dgot */
@@ -144,6 +152,7 @@ static int autofs4_tree_busy(struct vfsm
 				ino_count++;
 
 			if (atomic_read(&p->d_count) > ino_count) {
+				top_ino->last_used = jiffies;
 				dput(p);
 				return 1;
 			}
@@ -183,14 +192,13 @@ static struct dentry *autofs4_check_leav
 		spin_unlock(&dcache_lock);
 
 		if (d_mountpoint(p)) {
-			/* Can we expire this guy */
-			if (!autofs4_can_expire(p, timeout, do_now))
+			/* Can we umount this guy */
+			if (autofs4_mount_busy(mnt, p))
 				goto cont;
 
-			/* Can we umount this guy */
-			if (!autofs4_mount_busy(mnt, p))
+			/* Can we expire this guy */
+			if (autofs4_can_expire(p, timeout, do_now))
 				return p;
-
 		}
 cont:
 		dput(p);
@@ -246,12 +254,12 @@ static struct dentry *autofs4_expire(str
 			DPRINTK("checking mountpoint %p %.*s",
 				dentry, (int)dentry->d_name.len, dentry->d_name.name);
 
-			/* Can we expire this guy */
-			if (!autofs4_can_expire(dentry, timeout, do_now))
+			/* Can we umount this guy */
+			if (autofs4_mount_busy(mnt, dentry)) {
 				goto next;
 
-			/* Can we umount this guy */
-			if (!autofs4_mount_busy(mnt, dentry)) {
+			/* Can we expire this guy */
+			if (autofs4_can_expire(dentry, timeout, do_now))
 				expired = dentry;
 				break;
 			}
--- linux-2.6.15-mm3/fs/autofs4/root.c.expire-not-busy-only	2006-01-13 19:11:26.000000000 +0800
+++ linux-2.6.15-mm3/fs/autofs4/root.c	2006-01-13 19:11:26.000000000 +0800
@@ -330,6 +330,10 @@ static int try_to_fill_dentry(struct vfs
 	if (!autofs4_oz_mode(sbi))
 		autofs4_update_usage(mnt, dentry);
 
+	/* Initialize expiry counter after successful mount */
+	if (ino)
+		ino->last_used = jiffies;
+
 	spin_lock(&dentry->d_lock);
 	dentry->d_flags &= ~DCACHE_AUTOFS_PENDING;
 	spin_unlock(&dentry->d_lock);
