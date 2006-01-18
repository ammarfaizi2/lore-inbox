Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030260AbWARGy7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030260AbWARGy7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 01:54:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030265AbWARGyj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 01:54:39 -0500
Received: from 203-59-65-76.dyn.iinet.net.au ([203.59.65.76]:55961 "EHLO
	eagle.themaw.net") by vger.kernel.org with ESMTP id S1751367AbWARGuk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 01:50:40 -0500
Date: Wed, 18 Jan 2006 14:48:57 +0800
Message-Id: <200601180648.k0I6mvAE005855@eagle.themaw.net>
From: Ian Kent <raven@themaw.net>
To: Andrew Morton <akpm@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-fsdevel@vger.kernel.org, autofs@linux.kernel.org
Title: [PATCH 8/13] autofs4 - remove update_atime unused function
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes the update of i_atime from autofs4 in favour of
having VFS update it. i_atime is never used for expire in autofs4.

Signed-off-by: Ian Kent <raven@themaw.net>


--- linux-2.6.15-mm3/fs/autofs4/root.c.remove-update_atime	2006-01-13 16:21:05.000000000 +0800
+++ linux-2.6.15-mm3/fs/autofs4/root.c	2006-01-13 16:27:09.000000000 +0800
@@ -84,24 +84,6 @@ static int autofs4_root_readdir(struct f
 	return dcache_readdir(file, dirent, filldir);
 }
 
-/* Update usage from here to top of tree, so that scan of
-   top-level directories will give a useful result */
-static void autofs4_update_usage(struct vfsmount *mnt, struct dentry *dentry)
-{
-	struct dentry *top = dentry->d_sb->s_root;
-
-	spin_lock(&dcache_lock);
-	for(; dentry != top; dentry = dentry->d_parent) {
-		struct autofs_info *ino = autofs4_dentry_ino(dentry);
-
-		if (ino) {
-			touch_atime(mnt, dentry);
-			ino->last_used = jiffies;
-		}
-	}
-	spin_unlock(&dcache_lock);
-}
-
 static int autofs4_dir_open(struct inode *inode, struct file *file)
 {
 	struct dentry *dentry = file->f_dentry;
@@ -246,10 +228,9 @@ out:
 	return dcache_readdir(file, dirent, filldir);
 }
 
-static int try_to_fill_dentry(struct vfsmount *mnt, struct dentry *dentry, int flags)
+static int try_to_fill_dentry(struct dentry *dentry, int flags)
 {
-	struct super_block *sb = mnt->mnt_sb;
-	struct autofs_sb_info *sbi = autofs4_sbi(sb);
+	struct autofs_sb_info *sbi = autofs4_sbi(dentry->d_sb);
 	struct autofs_info *ino = autofs4_dentry_ino(dentry);
 	int status = 0;
 
@@ -323,13 +304,6 @@ static int try_to_fill_dentry(struct vfs
 		}
 	}
 
-	/*
-	 * We don't update the usages for the autofs daemon itself, this
-	 * is necessary for recursive autofs mounts
-	 */
-	if (!autofs4_oz_mode(sbi))
-		autofs4_update_usage(mnt, dentry);
-
 	/* Initialize expiry counter after successful mount */
 	if (ino)
 		ino->last_used = jiffies;
@@ -357,7 +331,7 @@ static int autofs4_revalidate(struct den
 	/* Pending dentry */
 	if (autofs4_ispending(dentry)) {
 		if (!oz_mode)
-			status = try_to_fill_dentry(nd->mnt, dentry, flags);
+			status = try_to_fill_dentry(dentry, flags);
 		return status;
 	}
 
@@ -374,15 +348,11 @@ static int autofs4_revalidate(struct den
 			 dentry, dentry->d_name.len, dentry->d_name.name);
 		spin_unlock(&dcache_lock);
 		if (!oz_mode)
-			status = try_to_fill_dentry(nd->mnt, dentry, flags);
+			status = try_to_fill_dentry(dentry, flags);
 		return status;
 	}
 	spin_unlock(&dcache_lock);
 
-	/* Update the usage list */
-	if (!oz_mode)
-		autofs4_update_usage(nd->mnt, dentry);
-
 	return 1;
 }
 
