Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135456AbRDRW4g>; Wed, 18 Apr 2001 18:56:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135457AbRDRW42>; Wed, 18 Apr 2001 18:56:28 -0400
Received: from roc-24-169-102-121.rochester.rr.com ([24.169.102.121]:5137 "EHLO
	roc-24-169-102-121.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S135456AbRDRW4N>; Wed, 18 Apr 2001 18:56:13 -0400
Date: Wed, 18 Apr 2001 18:56:06 -0400
From: Chris Mason <mason@suse.com>
To: viro@math.psu.edu, alan@redhat.com
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] ac only, allow reiserfs files > 4GB
Message-ID: <352590000.987634566@tiny>
X-Mailer: Mulberry/2.0.8 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch should set s_maxbytes correctly for reiserfs in the
ac kernels, and adds a reiserfs_setattr call to catch expanding
truncates past the MAX_NON_LFS limit for old format files.

reiserfs_get_block already catches file writes and such for
this case.

It also adds a generic_inode_setattr call, mostly because I
didn't want to copy/maintain that hunk of code in reiserfs.

Testing has been light, I'll beat on it more this evening.

patch against 2.4.3-ac7.

-chris

diff -Nru a/fs/attr.c b/fs/attr.c
--- a/fs/attr.c	Wed Apr 18 18:33:44 2001
+++ b/fs/attr.c	Wed Apr 18 18:33:44 2001
@@ -111,6 +111,21 @@
 	return dn_mask;
 }
 
+int generic_inode_setattr(struct inode *inode, struct iattr * attr) {
+	int error  ;
+	unsigned int ia_valid = attr->ia_valid;
+
+	error = inode_change_ok(inode, attr);
+	if (!error) {
+		if ((ia_valid & ATTR_UID && attr->ia_uid != inode->i_uid) ||
+		    (ia_valid & ATTR_GID && attr->ia_gid != inode->i_gid))
+			error = DQUOT_TRANSFER(inode, attr) ? -EDQUOT : 0;
+		if (!error)
+			error = inode_setattr(inode, attr);
+	}
+	return error ;
+}
+
 int notify_change(struct dentry * dentry, struct iattr * attr)
 {
 	struct inode *inode = dentry->d_inode;
@@ -131,14 +146,7 @@
 	if (inode->i_op && inode->i_op->setattr) 
 		error = inode->i_op->setattr(dentry, attr);
 	else {
-		error = inode_change_ok(inode, attr);
-		if (!error) {
-			if ((ia_valid & ATTR_UID && attr->ia_uid != inode->i_uid) ||
-			    (ia_valid & ATTR_GID && attr->ia_gid != inode->i_gid))
-				error = DQUOT_TRANSFER(inode, attr) ? -EDQUOT : 0;
-			if (!error)
-				error = inode_setattr(inode, attr);
-		}
+		error = generic_inode_setattr(inode, attr) ;
 	}
 	unlock_kernel();
 	if (!error) {
diff -Nru a/fs/reiserfs/file.c b/fs/reiserfs/file.c
--- a/fs/reiserfs/file.c	Wed Apr 18 18:33:44 2001
+++ b/fs/reiserfs/file.c	Wed Apr 18 18:33:44 2001
@@ -106,6 +106,18 @@
   return ( n_err < 0 ) ? -EIO : 0;
 }
 
+static int reiserfs_setattr(struct dentry *dentry, struct iattr *attr) {
+    struct inode *inode = dentry->d_inode ;
+    if (attr->ia_valid & ATTR_SIZE) {
+	/* version 2 items will be caught by the s_maxbytes check
+	** done for us in vmtruncate
+	*/
+        if (inode_items_version(inode) == ITEM_VERSION_1 && 
+	    attr->ia_size > MAX_NON_LFS)
+            return -EFBIG ;
+    }
+    return generic_inode_setattr(inode, attr) ;
+}
 
 struct file_operations reiserfs_file_operations = {
     read:	generic_file_read,
@@ -119,6 +131,7 @@
 
 struct  inode_operations reiserfs_file_inode_operations = {
     truncate:	reiserfs_vfs_truncate_file,
+    setattr:    reiserfs_setattr,
 };
 
 
diff -Nru a/fs/reiserfs/super.c b/fs/reiserfs/super.c
--- a/fs/reiserfs/super.c	Wed Apr 18 18:33:44 2001
+++ b/fs/reiserfs/super.c	Wed Apr 18 18:33:44 2001
@@ -412,7 +412,7 @@
     SB_BUFFER_WITH_SB (s) = bh;
     SB_DISK_SUPER_BLOCK (s) = rs;
     s->s_op = &reiserfs_sops;
-    s->s_maxbytes = MAX_NON_LFS;
+    s->s_maxbytes = MAX_NON_LFS; /* old format is always limited at 2GB */
     return 0;
 }
 #endif
@@ -493,7 +493,11 @@
     SB_BUFFER_WITH_SB (s) = bh;
     SB_DISK_SUPER_BLOCK (s) = rs;
     s->s_op = &reiserfs_sops;
-    s->s_maxbytes = 0xFFFFFFFF;	/* 4Gig */
+
+    /* new format is limited by the 32 bit wide i_blocks field, want to
+    ** be one full block below that.
+    */
+    s->s_maxbytes = (512LL << 32) - s->s_blocksize ;
     return 0;
 }
 
diff -Nru a/include/linux/fs.h b/include/linux/fs.h
--- a/include/linux/fs.h	Wed Apr 18 18:33:44 2001
+++ b/include/linux/fs.h	Wed Apr 18 18:33:44 2001
@@ -1359,6 +1359,7 @@
 
 extern int inode_change_ok(struct inode *, struct iattr *);
 extern int inode_setattr(struct inode *, struct iattr *);
+extern int generic_inode_setattr(struct inode *, struct iattr *);
 
 /*
  * Common dentry functions for inclusion in the VFS
diff -Nru a/kernel/ksyms.c b/kernel/ksyms.c
--- a/kernel/ksyms.c	Wed Apr 18 18:33:44 2001
+++ b/kernel/ksyms.c	Wed Apr 18 18:33:44 2001
@@ -180,6 +180,7 @@
 EXPORT_SYMBOL(permission);
 EXPORT_SYMBOL(vfs_permission);
 EXPORT_SYMBOL(inode_setattr);
+EXPORT_SYMBOL(generic_inode_setattr);
 EXPORT_SYMBOL(inode_change_ok);
 EXPORT_SYMBOL(write_inode_now);
 EXPORT_SYMBOL(notify_change);

