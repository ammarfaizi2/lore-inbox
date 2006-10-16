Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422757AbWJPQa5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422757AbWJPQa5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 12:30:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422755AbWJPQ2h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 12:28:37 -0400
Received: from mail-gw3.sa.ew.hu ([212.108.200.82]:58266 "EHLO
	mail-gw3.sa.ew.hu") by vger.kernel.org with ESMTP id S1422749AbWJPQ20
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 12:28:26 -0400
Message-Id: <20061016162729.176738000@szeredi.hu>
References: <20061016162709.369579000@szeredi.hu>
User-Agent: quilt/0.45-1
Date: Mon, 16 Oct 2006 18:27:10 +0200
From: Miklos Szeredi <miklos@szeredi.hu>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [patch 01/12] fuse: fix hang on SMP
Content-Disposition: inline; filename=fuse_i_size_write_fix.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fuse didn't always call i_size_write() with i_mutex held which caused
rare hangs on SMP/32bit.  This bug has been present since fuse-2.2,
well before being merged into mainline.

The simplest solution is to protect i_size_write() with the
per-connection spinlock.  Using i_mutex for this purpose would require
some restructuring of the code and I'm not even sure it's always safe
to acquire i_mutex in all places i_size needs to be set.

Since most of vmtruncate is already duplicated for other reasons,
duplicate the remaining part as well, making all i_size_write() calls
internal to fuse.

Using i_size_write() was unnecessary in fuse_init_inode(), since this
function is only called on a newly created locked inode.

Reported by a few people over the years, but special thanks to Dana
Henriksen who was persistent enough in helping me debug it.

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>

---
Index: linux/fs/fuse/dir.c
===================================================================
--- linux.orig/fs/fuse/dir.c	2006-10-16 15:56:10.000000000 +0200
+++ linux/fs/fuse/dir.c	2006-10-16 16:06:11.000000000 +0200
@@ -935,14 +935,30 @@ static void iattr_to_fattr(struct iattr 
 	}
 }
 
+static void fuse_vmtruncate(struct inode *inode, loff_t offset)
+{
+	struct fuse_conn *fc = get_fuse_conn(inode);
+	int need_trunc;
+
+	spin_lock(&fc->lock);
+	need_trunc = inode->i_size > offset;
+	i_size_write(inode, offset);
+	spin_unlock(&fc->lock);
+
+	if (need_trunc) {
+		struct address_space *mapping = inode->i_mapping;
+		unmap_mapping_range(mapping, offset + PAGE_SIZE - 1, 0, 1);
+		truncate_inode_pages(mapping, offset);
+	}
+}
+
 /*
  * Set attributes, and at the same time refresh them.
  *
  * Truncation is slightly complicated, because the 'truncate' request
  * may fail, in which case we don't want to touch the mapping.
- * vmtruncate() doesn't allow for this case.  So do the rlimit
- * checking by hand and call vmtruncate() only after the file has
- * actually been truncated.
+ * vmtruncate() doesn't allow for this case, so do the rlimit checking
+ * and the actual truncation by hand.
  */
 static int fuse_setattr(struct dentry *entry, struct iattr *attr)
 {
@@ -993,12 +1009,8 @@ static int fuse_setattr(struct dentry *e
 			make_bad_inode(inode);
 			err = -EIO;
 		} else {
-			if (is_truncate) {
-				loff_t origsize = i_size_read(inode);
-				i_size_write(inode, outarg.attr.size);
-				if (origsize > outarg.attr.size)
-					vmtruncate(inode, outarg.attr.size);
-			}
+			if (is_truncate)
+				fuse_vmtruncate(inode, outarg.attr.size);
 			fuse_change_attributes(inode, &outarg.attr);
 			fi->i_time = time_to_jiffies(outarg.attr_valid,
 						     outarg.attr_valid_nsec);
Index: linux/fs/fuse/file.c
===================================================================
--- linux.orig/fs/fuse/file.c	2006-10-16 15:56:10.000000000 +0200
+++ linux/fs/fuse/file.c	2006-10-16 15:58:45.000000000 +0200
@@ -481,8 +481,10 @@ static int fuse_commit_write(struct file
 		err = -EIO;
 	if (!err) {
 		pos += count;
-		if (pos > i_size_read(inode))
+		spin_lock(&fc->lock);
+		if (pos > inode->i_size)
 			i_size_write(inode, pos);
+		spin_unlock(&fc->lock);
 
 		if (offset == 0 && to == PAGE_CACHE_SIZE) {
 			clear_page_dirty(page);
@@ -586,8 +588,12 @@ static ssize_t fuse_direct_io(struct fil
 	}
 	fuse_put_request(fc, req);
 	if (res > 0) {
-		if (write && pos > i_size_read(inode))
-			i_size_write(inode, pos);
+		if (write) {
+			spin_lock(&fc->lock);
+			if (pos > inode->i_size)
+				i_size_write(inode, pos);
+			spin_unlock(&fc->lock);
+		}
 		*ppos = pos;
 	}
 	fuse_invalidate_attr(inode);
Index: linux/fs/fuse/inode.c
===================================================================
--- linux.orig/fs/fuse/inode.c	2006-10-16 15:56:10.000000000 +0200
+++ linux/fs/fuse/inode.c	2006-10-16 15:57:12.000000000 +0200
@@ -109,6 +109,7 @@ static int fuse_remount_fs(struct super_
 
 void fuse_change_attributes(struct inode *inode, struct fuse_attr *attr)
 {
+	struct fuse_conn *fc = get_fuse_conn(inode);
 	if (S_ISREG(inode->i_mode) && i_size_read(inode) != attr->size)
 		invalidate_inode_pages(inode->i_mapping);
 
@@ -117,7 +118,9 @@ void fuse_change_attributes(struct inode
 	inode->i_nlink   = attr->nlink;
 	inode->i_uid     = attr->uid;
 	inode->i_gid     = attr->gid;
+	spin_lock(&fc->lock);
 	i_size_write(inode, attr->size);
+	spin_unlock(&fc->lock);
 	inode->i_blocks  = attr->blocks;
 	inode->i_atime.tv_sec   = attr->atime;
 	inode->i_atime.tv_nsec  = attr->atimensec;
@@ -130,7 +133,7 @@ void fuse_change_attributes(struct inode
 static void fuse_init_inode(struct inode *inode, struct fuse_attr *attr)
 {
 	inode->i_mode = attr->mode & S_IFMT;
-	i_size_write(inode, attr->size);
+	inode->i_size = attr->size;
 	if (S_ISREG(inode->i_mode)) {
 		fuse_init_common(inode);
 		fuse_init_file_inode(inode);

--
