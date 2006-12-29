Return-Path: <linux-kernel-owner+w=401wt.eu-S1753130AbWL2XYt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753130AbWL2XYt (ORCPT <rfc822;w@1wt.eu>);
	Fri, 29 Dec 2006 18:24:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755066AbWL2XYs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Dec 2006 18:24:48 -0500
Received: from rgminet02.oracle.com ([148.87.113.119]:34579 "EHLO
	rgminet02.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753046AbWL2XYr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Dec 2006 18:24:47 -0500
Date: Fri, 29 Dec 2006 15:18:16 -0800
From: Mark Fasheh <mark.fasheh@oracle.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, ocfs2-devel@oss.oracle.com,
       linux-kernel@vger.kernel.org
Subject: [git patches] ocfs2 fixes
Message-ID: <20061229231816.GS6831@ca-server1.us.oracle.com>
Reply-To: Mark Fasheh <mark.fasheh@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Oracle Corporation
User-Agent: Mutt/1.5.11
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,
 	Here are some 2.6.20 fixes for ocfs2. The patch by Zhen Wei isn't
really a fix, but a very small amount of support for a feature which is
mostly implemented in ocfs2-tools. Considering it's just a single attribute
export via configfs, I'd say it's pretty safe to merge.

Please pull from 'upstream-linus' branch of
git://git.kernel.org/pub/scm/linux/kernel/git/mfasheh/ocfs2.git upstream-linus

to receive the following updates:

 fs/ocfs2/aops.c              |   24 +++++++++++++++++-------
 fs/ocfs2/cluster/heartbeat.c |   17 +++++++++++++++++
 fs/ocfs2/dlmglue.c           |   10 +++++++++-
 fs/ocfs2/file.c              |   13 +++++++++++--
 4 files changed, 54 insertions(+), 10 deletions(-)

Mark Fasheh:
      ocfs2: don't print error in ocfs2_permission()
      ocfs2: Allow direct I/O read past end of file
      ocfs2: ignore NULL vfsmnt in ocfs2_should_update_atime()
      ocfs2: always unmap in ocfs2_data_convert_worker()

Zhen Wei:
      ocfs2: export heartbeat thread pid via configfs

diff --git a/fs/ocfs2/aops.c b/fs/ocfs2/aops.c
index ef6cd30..93628b0 100644
--- a/fs/ocfs2/aops.c
+++ b/fs/ocfs2/aops.c
@@ -540,8 +540,7 @@ static int ocfs2_direct_IO_get_blocks(st
 				     struct buffer_head *bh_result, int create)
 {
 	int ret;
-	u64 vbo_max; /* file offset, max_blocks from iblock */
-	u64 p_blkno;
+	u64 p_blkno, inode_blocks;
 	int contig_blocks;
 	unsigned char blocksize_bits = inode->i_sb->s_blocksize_bits;
 	unsigned long max_blocks = bh_result->b_size >> inode->i_blkbits;
@@ -550,12 +549,23 @@ static int ocfs2_direct_IO_get_blocks(st
 	 * nicely aligned and of the right size, so there's no need
 	 * for us to check any of that. */
 
-	vbo_max = ((u64)iblock + max_blocks) << blocksize_bits;
-
 	spin_lock(&OCFS2_I(inode)->ip_lock);
-	if ((iblock + max_blocks) >
-	    ocfs2_clusters_to_blocks(inode->i_sb,
-				     OCFS2_I(inode)->ip_clusters)) {
+	inode_blocks = ocfs2_clusters_to_blocks(inode->i_sb,
+						OCFS2_I(inode)->ip_clusters);
+
+	/*
+	 * For a read which begins past the end of file, we return a hole.
+	 */
+	if (!create && (iblock >= inode_blocks)) {
+		spin_unlock(&OCFS2_I(inode)->ip_lock);
+		ret = 0;
+		goto bail;
+	}
+
+	/*
+	 * Any write past EOF is not allowed because we'd be extending.
+	 */
+	if (create && (iblock + max_blocks) > inode_blocks) {
 		spin_unlock(&OCFS2_I(inode)->ip_lock);
 		ret = -EIO;
 		goto bail;
diff --git a/fs/ocfs2/cluster/heartbeat.c b/fs/ocfs2/cluster/heartbeat.c
index a25ef5a..277ca67 100644
--- a/fs/ocfs2/cluster/heartbeat.c
+++ b/fs/ocfs2/cluster/heartbeat.c
@@ -1447,6 +1447,15 @@ out:
 	return ret;
 }
 
+static ssize_t o2hb_region_pid_read(struct o2hb_region *reg,
+                                      char *page)
+{
+	if (!reg->hr_task)
+		return 0;
+
+	return sprintf(page, "%u\n", reg->hr_task->pid);
+}
+
 struct o2hb_region_attribute {
 	struct configfs_attribute attr;
 	ssize_t (*show)(struct o2hb_region *, char *);
@@ -1485,11 +1494,19 @@ static struct o2hb_region_attribute o2hb
 	.store	= o2hb_region_dev_write,
 };
 
+static struct o2hb_region_attribute o2hb_region_attr_pid = {
+       .attr   = { .ca_owner = THIS_MODULE,
+                   .ca_name = "pid",
+                   .ca_mode = S_IRUGO | S_IRUSR },
+       .show   = o2hb_region_pid_read,
+};
+
 static struct configfs_attribute *o2hb_region_attrs[] = {
 	&o2hb_region_attr_block_bytes.attr,
 	&o2hb_region_attr_start_block.attr,
 	&o2hb_region_attr_blocks.attr,
 	&o2hb_region_attr_dev.attr,
+	&o2hb_region_attr_pid.attr,
 	NULL,
 };
 
diff --git a/fs/ocfs2/dlmglue.c b/fs/ocfs2/dlmglue.c
index e622013..e335541 100644
--- a/fs/ocfs2/dlmglue.c
+++ b/fs/ocfs2/dlmglue.c
@@ -2718,6 +2718,15 @@ static int ocfs2_data_convert_worker(str
        	inode = ocfs2_lock_res_inode(lockres);
 	mapping = inode->i_mapping;
 
+	/*
+	 * We need this before the filemap_fdatawrite() so that it can
+	 * transfer the dirty bit from the PTE to the
+	 * page. Unfortunately this means that even for EX->PR
+	 * downconverts, we'll lose our mappings and have to build
+	 * them up again.
+	 */
+	unmap_mapping_range(mapping, 0, 0, 0);
+
 	if (filemap_fdatawrite(mapping)) {
 		mlog(ML_ERROR, "Could not sync inode %llu for downconvert!",
 		     (unsigned long long)OCFS2_I(inode)->ip_blkno);
@@ -2725,7 +2734,6 @@ static int ocfs2_data_convert_worker(str
 	sync_mapping_buffers(mapping);
 	if (blocking == LKM_EXMODE) {
 		truncate_inode_pages(mapping, 0);
-		unmap_mapping_range(mapping, 0, 0, 0);
 	} else {
 		/* We only need to wait on the I/O if we're not also
 		 * truncating pages because truncate_inode_pages waits
diff --git a/fs/ocfs2/file.c b/fs/ocfs2/file.c
index 9fd590b..10953a5 100644
--- a/fs/ocfs2/file.c
+++ b/fs/ocfs2/file.c
@@ -149,6 +149,17 @@ int ocfs2_should_update_atime(struct ino
 	    ((inode->i_sb->s_flags & MS_NODIRATIME) && S_ISDIR(inode->i_mode)))
 		return 0;
 
+	/*
+	 * We can be called with no vfsmnt structure - NFSD will
+	 * sometimes do this.
+	 *
+	 * Note that our action here is different than touch_atime() -
+	 * if we can't tell whether this is a noatime mount, then we
+	 * don't know whether to trust the value of s_atime_quantum.
+	 */
+	if (vfsmnt == NULL)
+		return 0;
+
 	if ((vfsmnt->mnt_flags & MNT_NOATIME) ||
 	    ((vfsmnt->mnt_flags & MNT_NODIRATIME) && S_ISDIR(inode->i_mode)))
 		return 0;
@@ -966,8 +977,6 @@ int ocfs2_permission(struct inode *inode
 	}
 
 	ret = generic_permission(inode, mask, NULL);
-	if (ret)
-		mlog_errno(ret);
 
 	ocfs2_meta_unlock(inode, 0);
 out:
