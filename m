Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261946AbVCAPlp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261946AbVCAPlp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 10:41:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261945AbVCAPj6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 10:39:58 -0500
Received: from locomotive.csh.rit.edu ([129.21.60.149]:56158 "EHLO
	locomotive.unixthugs.org") by vger.kernel.org with ESMTP
	id S261946AbVCAPhc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 10:37:32 -0500
Date: Tue, 1 Mar 2005 10:37:31 -0500
From: Jeffrey Mahoney <jeffm@suse.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Stephen Smalley <sds@epoch.ncsc.mil>, Chris Wright <chrisw@osdl.org>
Subject: [PATCH 4/4] reiserfs: change reiserfs to use S_PRIVATE
Message-ID: <20050301153731.GE18215@locomotive.unixthugs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Operating-System: Linux 2.6.5-7.111.19-smp (i686)
X-GPG-Fingerprint: A16F A946 6C24 81CC 99BB  85AF 2CF5 B197 2B93 0FB2
X-GPG-Key: http://www.csh.rit.edu/~jeffm/jeffm.gpg
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch changes reiserfs to use the VFS level private inode flags, and
eliminates the old reiserfs private inode flag.

Signed-off-by: Jeff Mahoney <jeffm@suse.com>

diff -ruNpX dontdiff linux-2.6.9.base/include/linux/reiserfs_xattr.h linux-2.6.9.private/include/linux/reiserfs_xattr.h
--- linux-2.6.9.base/include/linux/reiserfs_xattr.h	2004-11-30 16:03:42.000000000 -0500
+++ linux-2.6.9.private/include/linux/reiserfs_xattr.h	2004-12-07 14:23:43.266996840 -0500
@@ -31,7 +31,7 @@ struct reiserfs_xattr_handler {
 
 
 #ifdef CONFIG_REISERFS_FS_XATTR
-#define is_reiserfs_priv_object(inode) (REISERFS_I(inode)->i_flags & i_priv_object)
+#define is_reiserfs_priv_object(inode) IS_PRIVATE(inode)
 #define has_xattr_dir(inode) (REISERFS_I(inode)->i_flags & i_has_xattr_dir)
 ssize_t reiserfs_getxattr (struct dentry *dentry, const char *name,
 			   void *buffer, size_t size);
@@ -106,7 +106,7 @@ reiserfs_read_unlock_xattr_i(struct inod
 static inline void
 reiserfs_mark_inode_private(struct inode *inode)
 {
-    REISERFS_I(inode)->i_flags |= i_priv_object;
+    inode->i_flags |= S_PRIVATE;
 }
 
 #else

diff -ruNpX dontdiff linux-2.6.9.base/include/linux/reiserfs_fs_i.h linux-2.6.9.private/include/linux/reiserfs_fs_i.h
--- linux-2.6.9.base/include/linux/reiserfs_fs_i.h	2004-11-19 14:40:57.000000000 -0500
+++ linux-2.6.9.private/include/linux/reiserfs_fs_i.h	2004-12-07 14:25:40.259211320 -0500
@@ -23,9 +23,8 @@ typedef enum {
       space on crash with some files open, but unlinked. */
     i_link_saved_unlink_mask   =  0x0010,
     i_link_saved_truncate_mask =  0x0020,
-    i_priv_object              =  0x0080,
-    i_has_xattr_dir            =  0x0100,
-    i_data_log	               =  0x0200,
+    i_has_xattr_dir            =  0x0040,
+    i_data_log	               =  0x0080,
 } reiserfs_inode_flags;
 
 
-- 
Jeff Mahoney
SuSE Labs
