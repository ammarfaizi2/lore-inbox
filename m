Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264676AbTFQMAU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 08:00:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264680AbTFQMAU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 08:00:20 -0400
Received: from 216-239-45-4.google.com ([216.239.45.4]:32246 "EHLO
	216-239-45-4.google.com") by vger.kernel.org with ESMTP
	id S264676AbTFQMAP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 08:00:15 -0400
Date: Tue, 17 Jun 2003 05:14:09 -0700
From: Frank Cusack <fcusack@fcusack.com>
To: torvalds@transmeta.com
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] nfs_unlink() again, and trivial nfs_fhget
Message-ID: <20030617051408.A17974@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The first one didn't make it into 2.5.71/72, but is necessary. :-)
The second one removes a redundant assignment.

/fc

diff -urp linux-2.5.72/fs/namei.c linux-2.5.72-silly/fs/namei.c
--- linux-2.5.72/fs/namei.c	Mon Jun 16 21:19:57 2003
+++ linux-2.5.72-silly/fs/namei.c	Tue Jun 17 05:09:04 2003
@@ -985,6 +985,8 @@ static inline int check_sticky(struct in
  *  7. If we were asked to remove a directory and victim isn't one - ENOTDIR.
  *  8. If we were asked to remove a non-directory and victim isn't one - EISDIR.
  *  9. We can't remove a root or mountpoint.
+ * 10. We don't allow removal of NFS sillyrenamed files; it's handled by
+ *     nfs_async_unlink().
  */
 static inline int may_delete(struct inode *dir,struct dentry *victim, int isdir)
 {
@@ -1008,6 +1010,8 @@ static inline int may_delete(struct inod
 		return -EISDIR;
 	if (IS_DEADDIR(dir))
 		return -ENOENT;
+	if (victim->d_flags & DCACHE_NFSFS_RENAMED)
+		return -EBUSY;
 	return 0;
 }
 
diff -urp linux-2.5.72/fs/nfs/inode.c linux-2.5.72-silly/fs/nfs/inode.c
--- linux-2.5.72/fs/nfs/inode.c	Mon Jun 16 21:20:20 2003
+++ linux-2.5.72-silly/fs/nfs/inode.c	Tue Jun 17 05:03:19 2003
@@ -715,7 +715,6 @@ __nfs_fhget(struct super_block *sb, stru
 		if (fattr->valid & NFS_ATTR_FATTR_V4)
 			nfsi->change_attr = fattr->change_attr;
 		inode->i_size = nfs_size_to_loff_t(fattr->size);
-		inode->i_mode = fattr->mode;
 		inode->i_nlink = fattr->nlink;
 		inode->i_uid = fattr->uid;
 		inode->i_gid = fattr->gid;
