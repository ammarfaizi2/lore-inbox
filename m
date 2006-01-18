Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932318AbWARGvJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932318AbWARGvJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 01:51:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751363AbWARGup
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 01:50:45 -0500
Received: from 203-59-65-76.dyn.iinet.net.au ([203.59.65.76]:55449 "EHLO
	eagle.themaw.net") by vger.kernel.org with ESMTP id S1751356AbWARGuk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 01:50:40 -0500
Date: Wed, 18 Jan 2006 14:49:11 +0800
Message-Id: <200601180649.k0I6nBH8005876@eagle.themaw.net>
From: Ian Kent <raven@themaw.net>
To: Andrew Morton <akpm@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-fsdevel@vger.kernel.org, autofs@linux.kernel.org
Title: [PATCH 12/13] autofs4 - change may_umount* functions to boolean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch changes the functions may_umount and may_umount_tree
to boolean functions to aid code readability.

Signed-off-by: Ian Kent <raven@themaw.net>


--- linux-2.6.15-mm4/fs/namespace.c.may_umount-to-boolean	2006-01-15 16:06:59.000000000 +0800
+++ linux-2.6.15-mm4/fs/namespace.c	2006-01-15 16:08:36.000000000 +0800
@@ -421,9 +421,9 @@ int may_umount_tree(struct vfsmount *mnt
 	spin_unlock(&vfsmount_lock);
 
 	if (actual_refs > minimum_refs)
-		return -EBUSY;
+		return 0;
 
-	return 0;
+	return 1;
 }
 
 EXPORT_SYMBOL(may_umount_tree);
@@ -443,10 +443,10 @@ EXPORT_SYMBOL(may_umount_tree);
  */
 int may_umount(struct vfsmount *mnt)
 {
-	int ret = 0;
+	int ret = 1;
 	spin_lock(&vfsmount_lock);
 	if (propagate_mount_busy(mnt, 2))
-		ret = -EBUSY;
+		ret = 0;
 	spin_unlock(&vfsmount_lock);
 	return ret;
 }
--- linux-2.6.15-mm4/fs/autofs4/root.c.may_umount-to-boolean	2006-01-15 16:10:22.000000000 +0800
+++ linux-2.6.15-mm4/fs/autofs4/root.c	2006-01-15 16:11:35.000000000 +0800
@@ -699,7 +699,7 @@ static inline int autofs4_ask_umount(str
 {
 	int status = 0;
 
-	if (may_umount(mnt) == 0)
+	if (may_umount(mnt))
 		status = 1;
 
 	DPRINTK("returning %d", status);
--- linux-2.6.15-mm4/fs/autofs4/expire.c.may_umount-to-boolean	2006-01-15 16:10:34.000000000 +0800
+++ linux-2.6.15-mm4/fs/autofs4/expire.c	2006-01-15 16:10:54.000000000 +0800
@@ -64,7 +64,7 @@ static int autofs4_mount_busy(struct vfs
 		goto done;
 
 	/* Update the expiry counter if fs is busy */
-	if (may_umount_tree(mnt)) {
+	if (!may_umount_tree(mnt)) {
 		struct autofs_info *ino = autofs4_dentry_ino(top);
 		ino->last_used = jiffies;
 		goto done;
--- linux-2.6.15-mm4/fs/autofs/dirhash.c.may_umount-to-boolean	2006-01-15 16:09:08.000000000 +0800
+++ linux-2.6.15-mm4/fs/autofs/dirhash.c	2006-01-15 16:09:46.000000000 +0800
@@ -92,7 +92,7 @@ struct autofs_dir_ent *autofs_expire(str
 			;
 		dput(dentry);
 
-		if ( may_umount(mnt) == 0 ) {
+		if ( may_umount(mnt) ) {
 			mntput(mnt);
 			DPRINTK(("autofs: signaling expire on %s\n", ent->name));
 			return ent; /* Expirable! */
