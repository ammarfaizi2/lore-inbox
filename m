Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946531AbWKAFm0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946531AbWKAFm0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 00:42:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946524AbWKAFlp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 00:41:45 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:35474 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1946530AbWKAFlh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 00:41:37 -0500
Message-Id: <20061101054119.573512000@sous-sol.org>
References: <20061101053340.305569000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Tue, 31 Oct 2006 21:34:14 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, Miklos Szeredi <miklos@szeredi.hu>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 34/61] fuse: fix hang on SMP
Content-Disposition: inline; filename=fuse-fix-hang-on-smp.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Miklos Szeredi <miklos@szeredi.hu>

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
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>

---
 fs/fuse/dir.c   |   30 +++++++++++++++++++++---------
 fs/fuse/file.c  |   12 +++++++++---
 fs/fuse/inode.c |    5 ++++-
 3 files changed, 34 insertions(+), 13 deletions(-)

--- linux-2.6.18.1.orig/fs/fuse/dir.c
+++ linux-2.6.18.1/fs/fuse/dir.c
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
--- linux-2.6.18.1.orig/fs/fuse/file.c
+++ linux-2.6.18.1/fs/fuse/file.c
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
--- linux-2.6.18.1.orig/fs/fuse/inode.c
+++ linux-2.6.18.1/fs/fuse/inode.c
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
 	inode->i_blksize = PAGE_CACHE_SIZE;
 	inode->i_blocks  = attr->blocks;
 	inode->i_atime.tv_sec   = attr->atime;
@@ -131,7 +134,7 @@ void fuse_change_attributes(struct inode
 static void fuse_init_inode(struct inode *inode, struct fuse_attr *attr)
 {
 	inode->i_mode = attr->mode & S_IFMT;
-	i_size_write(inode, attr->size);
+	inode->i_size = attr->size;
 	if (S_ISREG(inode->i_mode)) {
 		fuse_init_common(inode);
 		fuse_init_file_inode(inode);

--
