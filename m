Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261945AbVCAPlq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261945AbVCAPlq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 10:41:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261944AbVCAPjm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 10:39:42 -0500
Received: from locomotive.csh.rit.edu ([129.21.60.149]:55390 "EHLO
	locomotive.unixthugs.org") by vger.kernel.org with ESMTP
	id S261945AbVCAPh1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 10:37:27 -0500
Date: Tue, 1 Mar 2005 10:37:27 -0500
From: Jeffrey Mahoney <jeffm@suse.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Stephen Smalley <sds@epoch.ncsc.mil>, Chris Wright <chrisw@osdl.org>
Subject: [PATCH 3/4] reiserfs: private inode abstracted to static inline
Message-ID: <20050301153727.GD18215@locomotive.unixthugs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Operating-System: Linux 2.6.5-7.111.19-smp (i686)
X-GPG-Fingerprint: A16F A946 6C24 81CC 99BB  85AF 2CF5 B197 2B93 0FB2
X-GPG-Key: http://www.csh.rit.edu/~jeffm/jeffm.gpg
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch moves the assignment of i_priv_object to a static inline. This
is in preparation for selinux support in reiserfs.

Signed-off-by: Jeff Mahoney <jeffm@suse.com>

diff -ruNpX dontdiff linux-2.6.9/fs/reiserfs/inode.c linux-2.6.9.base/fs/reiserfs/inode.c
--- linux-2.6.9/fs/reiserfs/inode.c	2004-11-19 14:40:53.000000000 -0500
+++ linux-2.6.9.base/fs/reiserfs/inode.c	2004-11-30 16:03:42.000000000 -0500
@@ -1804,6 +1804,8 @@ int reiserfs_new_inode (struct reiserfs_
     } else if (inode->i_sb->s_flags & MS_POSIXACL) {
 	reiserfs_warning (inode->i_sb, "ACLs aren't enabled in the fs, "
 			  "but vfs thinks they are!");
+    } else if (is_reiserfs_priv_object (dir)) {
+	reiserfs_mark_inode_private (inode);
     }
 
     insert_inode_hash (inode);
diff -ruNpX dontdiff linux-2.6.9/fs/reiserfs/namei.c linux-2.6.9.base/fs/reiserfs/namei.c
--- linux-2.6.9/fs/reiserfs/namei.c	2004-08-14 01:37:14.000000000 -0400
+++ linux-2.6.9.base/fs/reiserfs/namei.c	2004-11-30 16:03:42.000000000 -0500
@@ -352,7 +352,7 @@ static struct dentry * reiserfs_lookup (
 
 	/* Propogate the priv_object flag so we know we're in the priv tree */
 	if (is_reiserfs_priv_object (dir))
-	    REISERFS_I(inode)->i_flags |= i_priv_object;
+	    reiserfs_mark_inode_private (inode);
     }
     reiserfs_write_unlock(dir->i_sb);
     if ( retval == IO_ERROR ) {
diff -ruNpX dontdiff linux-2.6.9/fs/reiserfs/xattr_acl.c linux-2.6.9.base/fs/reiserfs/xattr_acl.c
--- linux-2.6.9/fs/reiserfs/xattr_acl.c	2004-11-19 14:40:53.000000000 -0500
+++ linux-2.6.9.base/fs/reiserfs/xattr_acl.c	2004-11-30 16:03:42.000000000 -0500
@@ -337,7 +337,7 @@ reiserfs_inherit_default_acl (struct ino
      * would be useless since permissions are ignored, and a pain because
      * it introduces locking cycles */
     if (is_reiserfs_priv_object (dir)) {
-        REISERFS_I(inode)->i_flags |= i_priv_object;
+        reiserfs_mark_inode_private (inode);
         goto apply_umask;
     }
 
diff -ruNpX dontdiff linux-2.6.9/fs/reiserfs/xattr.c linux-2.6.9.base/fs/reiserfs/xattr.c
--- linux-2.6.9/fs/reiserfs/xattr.c	2004-11-19 14:40:53.000000000 -0500
+++ linux-2.6.9.base/fs/reiserfs/xattr.c	2004-12-07 13:54:17.336459088 -0500
@@ -181,8 +181,6 @@ open_xa_dir (const struct inode *inode, 
             dput (xadir);
             return ERR_PTR (-ENODATA);
         }
-        /* Newly created object.. Need to mark it private */
-        REISERFS_I(xadir->d_inode)->i_flags |= i_priv_object;
     }
 
     dput (xaroot);
@@ -230,8 +228,6 @@ get_xa_file_dentry (const struct inode *
             dput (xafile);
             goto out;
         }
-        /* Newly created object.. Need to mark it private */
-        REISERFS_I(xafile->d_inode)->i_flags |= i_priv_object;
     }
 
 out:
@@ -1316,7 +1312,7 @@ reiserfs_xattr_init (struct super_block 
 
       if (!err && dentry) {
           s->s_root->d_op = &xattr_lookup_poison_ops;
-          REISERFS_I(dentry->d_inode)->i_flags |= i_priv_object;
+          reiserfs_mark_inode_private (dentry->d_inode);
           REISERFS_SB(s)->priv_root = dentry;
       } else if (!(mount_flags & MS_RDONLY)) { /* xattrs are unavailable */
           /* If we're read-only it just means that the dir hasn't been
diff -ruNpX dontdiff linux-2.6.9/include/linux/reiserfs_xattr.h linux-2.6.9.base/include/linux/reiserfs_xattr.h
--- linux-2.6.9/include/linux/reiserfs_xattr.h	2004-08-14 01:38:11.000000000 -0400
+++ linux-2.6.9.base/include/linux/reiserfs_xattr.h	2004-11-30 16:03:42.000000000 -0500
@@ -103,6 +103,12 @@ reiserfs_read_unlock_xattr_i(struct inod
     up_read (&REISERFS_I(inode)->xattr_sem);
 }
 
+static inline void
+reiserfs_mark_inode_private(struct inode *inode)
+{
+    REISERFS_I(inode)->i_flags |= i_priv_object;
+}
+
 #else
 
 #define is_reiserfs_priv_object(inode) 0
-- 
Jeff Mahoney
SuSE Labs
