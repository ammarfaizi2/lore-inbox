Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267324AbUIEWna@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267324AbUIEWna (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 18:43:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267311AbUIEWn3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 18:43:29 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:41093 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S267334AbUIEWkH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 18:40:07 -0400
Date: Sun, 5 Sep 2004 23:39:54 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@osdl.org>
cc: Brent Casavant <bcasavan@sgi.com>, Christoph Rohland <cr@sap.com>,
       <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/7] shmem: no sbinfo for shm mount
In-Reply-To: <Pine.LNX.4.44.0409052331240.3218-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0409052339100.3218-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

SGI investigations have shown a dramatic contrast in scalability between
anonymous memory and shmem objects.  Processes building distinct shmem
objects in parallel hit heavy contention on shmem superblock stat_lock.
Across 256 cpus an intensive test runs 300 times slower than anonymous.

Jack Steiner has observed that all the shmem superblock free_blocks and
free_inodes accounting is redundant in the case of the internal mount
used for SysV shared memory and for shared writable /dev/zero objects
(the cases which most concern them): it specifically declines to limit.

Based upon Brent Casavant's SHMEM_NOSBINFO patch, this instead just
removes the shmem_sb_info structure from the internal kernel mount,
testing where necessary for null sbinfo pointer.  shmem_set_size
moved within CONFIG_TMPFS, its arg named "sbinfo" as elsewhere.

This brings shmem object scalability up to that of anonymous memory,
in the case where distinct processes are building (faulting to allocate)
distinct objects.  It significantly improves parallel building of a
shared shmem object (that test runs 14 times faster across 256 cpus),
but other issues remain in that case: to be addressed in later batches.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

 mm/shmem.c |  164 ++++++++++++++++++++++++++++++++-----------------------------
 1 files changed, 88 insertions(+), 76 deletions(-)

--- shmem2/mm/shmem.c	2004-09-05 17:05:57.019863984 +0100
+++ shmem3/mm/shmem.c	2004-09-05 17:06:08.078182864 +0100
@@ -185,10 +185,12 @@ static spinlock_t shmem_ilock = SPIN_LOC
 static void shmem_free_block(struct inode *inode)
 {
 	struct shmem_sb_info *sbinfo = SHMEM_SB(inode->i_sb);
-	spin_lock(&sbinfo->stat_lock);
-	sbinfo->free_blocks++;
-	inode->i_blocks -= BLOCKS_PER_PAGE;
-	spin_unlock(&sbinfo->stat_lock);
+	if (sbinfo) {
+		spin_lock(&sbinfo->stat_lock);
+		sbinfo->free_blocks++;
+		inode->i_blocks -= BLOCKS_PER_PAGE;
+		spin_unlock(&sbinfo->stat_lock);
+	}
 }
 
 /*
@@ -213,11 +215,13 @@ static void shmem_recalc_inode(struct in
 	if (freed > 0) {
 		struct shmem_sb_info *sbinfo = SHMEM_SB(inode->i_sb);
 		info->alloced -= freed;
-		spin_lock(&sbinfo->stat_lock);
-		sbinfo->free_blocks += freed;
-		inode->i_blocks -= freed*BLOCKS_PER_PAGE;
-		spin_unlock(&sbinfo->stat_lock);
 		shmem_unacct_blocks(info->flags, freed);
+		if (sbinfo) {
+			spin_lock(&sbinfo->stat_lock);
+			sbinfo->free_blocks += freed;
+			inode->i_blocks -= freed*BLOCKS_PER_PAGE;
+			spin_unlock(&sbinfo->stat_lock);
+		}
 	}
 }
 
@@ -350,14 +354,16 @@ static swp_entry_t *shmem_swp_alloc(stru
 		 * page (and perhaps indirect index pages) yet to allocate:
 		 * a waste to allocate index if we cannot allocate data.
 		 */
-		spin_lock(&sbinfo->stat_lock);
-		if (sbinfo->free_blocks <= 1) {
+		if (sbinfo) {
+			spin_lock(&sbinfo->stat_lock);
+			if (sbinfo->free_blocks <= 1) {
+				spin_unlock(&sbinfo->stat_lock);
+				return ERR_PTR(-ENOSPC);
+			}
+			sbinfo->free_blocks--;
+			inode->i_blocks += BLOCKS_PER_PAGE;
 			spin_unlock(&sbinfo->stat_lock);
-			return ERR_PTR(-ENOSPC);
 		}
-		sbinfo->free_blocks--;
-		inode->i_blocks += BLOCKS_PER_PAGE;
-		spin_unlock(&sbinfo->stat_lock);
 
 		spin_unlock(&info->lock);
 		page = shmem_dir_alloc(mapping_gfp_mask(inode->i_mapping));
@@ -605,10 +611,12 @@ static void shmem_delete_inode(struct in
 		inode->i_size = 0;
 		shmem_truncate(inode);
 	}
-	BUG_ON(inode->i_blocks);
-	spin_lock(&sbinfo->stat_lock);
-	sbinfo->free_inodes++;
-	spin_unlock(&sbinfo->stat_lock);
+	if (sbinfo) {
+		BUG_ON(inode->i_blocks);
+		spin_lock(&sbinfo->stat_lock);
+		sbinfo->free_inodes++;
+		spin_unlock(&sbinfo->stat_lock);
+	}
 	clear_inode(inode);
 }
 
@@ -1001,16 +1009,23 @@ repeat:
 	} else {
 		shmem_swp_unmap(entry);
 		sbinfo = SHMEM_SB(inode->i_sb);
-		spin_lock(&sbinfo->stat_lock);
-		if (sbinfo->free_blocks == 0 || shmem_acct_block(info->flags)) {
+		if (sbinfo) {
+			spin_lock(&sbinfo->stat_lock);
+			if (sbinfo->free_blocks == 0 ||
+			    shmem_acct_block(info->flags)) {
+				spin_unlock(&sbinfo->stat_lock);
+				spin_unlock(&info->lock);
+				error = -ENOSPC;
+				goto failed;
+			}
+			sbinfo->free_blocks--;
+			inode->i_blocks += BLOCKS_PER_PAGE;
 			spin_unlock(&sbinfo->stat_lock);
+		} else if (shmem_acct_block(info->flags)) {
 			spin_unlock(&info->lock);
 			error = -ENOSPC;
 			goto failed;
 		}
-		sbinfo->free_blocks--;
-		inode->i_blocks += BLOCKS_PER_PAGE;
-		spin_unlock(&sbinfo->stat_lock);
 
 		if (!filepage) {
 			spin_unlock(&info->lock);
@@ -1187,13 +1202,15 @@ shmem_get_inode(struct super_block *sb, 
 	struct shmem_inode_info *info;
 	struct shmem_sb_info *sbinfo = SHMEM_SB(sb);
 
-	spin_lock(&sbinfo->stat_lock);
-	if (!sbinfo->free_inodes) {
+	if (sbinfo) {
+		spin_lock(&sbinfo->stat_lock);
+		if (!sbinfo->free_inodes) {
+			spin_unlock(&sbinfo->stat_lock);
+			return NULL;
+		}
+		sbinfo->free_inodes--;
 		spin_unlock(&sbinfo->stat_lock);
-		return NULL;
 	}
-	sbinfo->free_inodes--;
-	spin_unlock(&sbinfo->stat_lock);
 
 	inode = new_inode(sb);
 	if (inode) {
@@ -1234,32 +1251,32 @@ shmem_get_inode(struct super_block *sb, 
 	return inode;
 }
 
-static int shmem_set_size(struct shmem_sb_info *info,
+#ifdef CONFIG_TMPFS
+
+static int shmem_set_size(struct shmem_sb_info *sbinfo,
 			  unsigned long max_blocks, unsigned long max_inodes)
 {
 	int error;
 	unsigned long blocks, inodes;
 
-	spin_lock(&info->stat_lock);
-	blocks = info->max_blocks - info->free_blocks;
-	inodes = info->max_inodes - info->free_inodes;
+	spin_lock(&sbinfo->stat_lock);
+	blocks = sbinfo->max_blocks - sbinfo->free_blocks;
+	inodes = sbinfo->max_inodes - sbinfo->free_inodes;
 	error = -EINVAL;
 	if (max_blocks < blocks)
 		goto out;
 	if (max_inodes < inodes)
 		goto out;
 	error = 0;
-	info->max_blocks  = max_blocks;
-	info->free_blocks = max_blocks - blocks;
-	info->max_inodes  = max_inodes;
-	info->free_inodes = max_inodes - inodes;
+	sbinfo->max_blocks  = max_blocks;
+	sbinfo->free_blocks = max_blocks - blocks;
+	sbinfo->max_inodes  = max_inodes;
+	sbinfo->free_inodes = max_inodes - inodes;
 out:
-	spin_unlock(&info->stat_lock);
+	spin_unlock(&sbinfo->stat_lock);
 	return error;
 }
 
-#ifdef CONFIG_TMPFS
-
 static struct inode_operations shmem_symlink_inode_operations;
 static struct inode_operations shmem_symlink_inline_operations;
 
@@ -1819,47 +1836,51 @@ static int shmem_remount_fs(struct super
 }
 #endif
 
+static void shmem_put_super(struct super_block *sb)
+{
+	kfree(sb->s_fs_info);
+	sb->s_fs_info = NULL;
+}
+
 static int shmem_fill_super(struct super_block *sb,
 			    void *data, int silent)
 {
 	struct inode *inode;
 	struct dentry *root;
-	unsigned long blocks, inodes;
 	int mode   = S_IRWXUGO | S_ISVTX;
 	uid_t uid = current->fsuid;
 	gid_t gid = current->fsgid;
-	struct shmem_sb_info *sbinfo;
 	int err = -ENOMEM;
 
-	sbinfo = kmalloc(sizeof(struct shmem_sb_info), GFP_KERNEL);
-	if (!sbinfo)
-		return -ENOMEM;
-	sb->s_fs_info = sbinfo;
-	memset(sbinfo, 0, sizeof(struct shmem_sb_info));
-
+#ifdef CONFIG_TMPFS
 	/*
 	 * Per default we only allow half of the physical ram per
-	 * tmpfs instance, limiting inodes to one per page of lowmem.
+	 * tmpfs instance, limiting inodes to one per page of lowmem;
+	 * but the internal instance is left unlimited.
 	 */
-	blocks = totalram_pages / 2;
-	inodes = totalram_pages - totalhigh_pages;
-	if (inodes > blocks)
-		inodes = blocks;
-
-#ifdef CONFIG_TMPFS
-	if (shmem_parse_options(data, &mode, &uid, &gid, &blocks, &inodes)) {
-		err = -EINVAL;
-		goto failed;
+	if (!(sb->s_flags & MS_NOUSER)) {
+		struct shmem_sb_info *sbinfo;
+		unsigned long blocks = totalram_pages / 2;
+		unsigned long inodes = totalram_pages - totalhigh_pages;
+		if (inodes > blocks)
+			inodes = blocks;
+
+		if (shmem_parse_options(data, &mode,
+					&uid, &gid, &blocks, &inodes))
+			return -EINVAL;
+
+		sbinfo = kmalloc(sizeof(struct shmem_sb_info), GFP_KERNEL);
+		if (!sbinfo)
+			return -ENOMEM;
+		sb->s_fs_info = sbinfo;
+		spin_lock_init(&sbinfo->stat_lock);
+		sbinfo->max_blocks = blocks;
+		sbinfo->free_blocks = blocks;
+		sbinfo->max_inodes = inodes;
+		sbinfo->free_inodes = inodes;
 	}
-#else
-	sb->s_flags |= MS_NOUSER;
 #endif
 
-	spin_lock_init(&sbinfo->stat_lock);
-	sbinfo->max_blocks = blocks;
-	sbinfo->free_blocks = blocks;
-	sbinfo->max_inodes = inodes;
-	sbinfo->free_inodes = inodes;
 	sb->s_maxbytes = SHMEM_MAX_BYTES;
 	sb->s_blocksize = PAGE_CACHE_SIZE;
 	sb->s_blocksize_bits = PAGE_CACHE_SHIFT;
@@ -1879,17 +1900,10 @@ static int shmem_fill_super(struct super
 failed_iput:
 	iput(inode);
 failed:
-	kfree(sbinfo);
-	sb->s_fs_info = NULL;
+	shmem_put_super(sb);
 	return err;
 }
 
-static void shmem_put_super(struct super_block *sb)
-{
-	kfree(sb->s_fs_info);
-	sb->s_fs_info = NULL;
-}
-
 static kmem_cache_t *shmem_inode_cachep;
 
 static struct inode *shmem_alloc_inode(struct super_block *sb)
@@ -2023,15 +2037,13 @@ static int __init init_tmpfs(void)
 #ifdef CONFIG_TMPFS
 	devfs_mk_dir("shm");
 #endif
-	shm_mnt = kern_mount(&tmpfs_fs_type);
+	shm_mnt = do_kern_mount(tmpfs_fs_type.name, MS_NOUSER,
+				tmpfs_fs_type.name, NULL);
 	if (IS_ERR(shm_mnt)) {
 		error = PTR_ERR(shm_mnt);
 		printk(KERN_ERR "Could not kern_mount tmpfs\n");
 		goto out1;
 	}
-
-	/* The internal instance should not do size checking */
-	shmem_set_size(SHMEM_SB(shm_mnt->mnt_sb), ULONG_MAX, ULONG_MAX);
 	return 0;
 
 out1:

