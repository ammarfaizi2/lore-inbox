Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132993AbRDYXM6>; Wed, 25 Apr 2001 19:12:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133004AbRDYXMt>; Wed, 25 Apr 2001 19:12:49 -0400
Received: from roc-24-169-102-121.rochester.rr.com ([24.169.102.121]:35598
	"EHLO roc-24-169-102-121.rochester.rr.com") by vger.kernel.org
	with ESMTP id <S132993AbRDYXMl>; Wed, 25 Apr 2001 19:12:41 -0400
Date: Wed, 25 Apr 2001 19:12:12 -0400
From: Chris Mason <mason@suse.com>
To: reiserfs-list@namesys.com, linux-kernel@vger.kernel.org
Subject: [PATCH] reiserfs lfs fix for 2.4.4-pre5 and above
Message-ID: <494520000.988240332@tiny>
X-Mailer: Mulberry/2.0.8 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello everyone,

2.4.4-pre5 started honoring the s_maxbytes field, so reiserfs needs a 
patch to allow files > 4GB on 3.6.x format filesystems.

If you work with large files on reiserfs and are willing to try
the prerelease kernels (non-production), please give this a try, 
it works for me but I'd like a few confirmations before I send to Linus.

This also prevents someone from using truncate to expand an old 
format file past the 2GB mark.

-chris

diff -Nru a/fs/reiserfs/file.c b/fs/reiserfs/file.c
--- a/fs/reiserfs/file.c	Tue Apr 24 13:37:21 2001
+++ b/fs/reiserfs/file.c	Tue Apr 24 13:37:21 2001
@@ -106,6 +106,24 @@
   return ( n_err < 0 ) ? -EIO : 0;
 }
 
+static int reiserfs_setattr(struct dentry *dentry, struct iattr *attr) {
+    struct inode *inode = dentry->d_inode ;
+    int error ;
+    if (attr->ia_valid & ATTR_SIZE) {
+	/* version 2 items will be caught by the s_maxbytes check
+	** done for us in vmtruncate
+	*/
+        if (inode_items_version(inode) == ITEM_VERSION_1 && 
+	    attr->ia_size > MAX_NON_LFS)
+            return -EFBIG ;
+    }
+
+    error = inode_change_ok(inode, attr) ;
+    if (!error)
+        inode_setattr(inode, attr) ;
+
+    return error ;
+}
 
 struct file_operations reiserfs_file_operations = {
     read:	generic_file_read,
@@ -119,6 +137,7 @@
 
 struct  inode_operations reiserfs_file_inode_operations = {
     truncate:	reiserfs_vfs_truncate_file,
+    setattr:    reiserfs_setattr,
 };
 
 
diff -Nru a/fs/reiserfs/super.c b/fs/reiserfs/super.c
--- a/fs/reiserfs/super.c	Tue Apr 24 13:37:21 2001
+++ b/fs/reiserfs/super.c	Tue Apr 24 13:37:21 2001
@@ -492,7 +492,11 @@
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
 


