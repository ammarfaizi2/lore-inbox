Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261644AbVFFTtJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261644AbVFFTtJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 15:49:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261647AbVFFTtJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 15:49:09 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:21380 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261644AbVFFTp4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 15:45:56 -0400
Date: Mon, 6 Jun 2005 20:46:54 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: Christoph Rohland <cr@sap.com>, Brent Casavant <bcasavan@sgi.com>,
       Robin Holt <holt@sgi.com>, "Adam J. Richter" <adam@yggdrasil.com>,
       linux-kernel@vger.kernel.org
Subject: [PATCH] shmem: restore superblock info
Message-ID: <Pine.LNX.4.61.0506062043470.5000@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-OriginalArrivalTime: 06 Jun 2005 19:45:54.0863 (UTC) 
    FILETIME=[5A2DF3F0:01C56AD0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

To improve shmem scalability, we allowed tmpfs instances which don't need
their blocks or inodes limited not to count them, and not to allocate any
sbinfo.  Which was okay when the only use for the sbinfo was accounting
blocks and inodes; but since then a couple of unrelated projects extending
tmpfs want to store other data in the sbinfo.  Whether either extension
reaches mainline is beside the point: I'm guilty of a bad design decision,
and should restore sbinfo to make any such future extensions easier.

So, once again allocate a shmem_sb_info for every shmem/tmpfs instance,
and now let max_blocks 0 indicate unlimited blocks, and max_inodes 0 
unlimited inodes.  Brent Casavant verified (many months ago) that this
does not perceptibly impact the scalability (since the unlimited sbinfo
cacheline is repeatedly accessed but only once dirtied).

And merge shmem_set_size into its sole caller shmem_remount_fs.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

 Documentation/filesystems/tmpfs.txt |    6 -
 mm/shmem.c                          |  143 +++++++++++++++++-------------------
 2 files changed, 73 insertions(+), 76 deletions(-)

--- 2.6.12-rc6/Documentation/filesystems/tmpfs.txt	2004-10-18 22:55:53.000000000 +0100
+++ linux/Documentation/filesystems/tmpfs.txt	2005-06-04 20:41:55.000000000 +0100
@@ -71,8 +71,8 @@ can be changed on remount.  The size par
 to limit this tmpfs instance to that percentage of your physical RAM:
 the default, when neither size nor nr_blocks is specified, is size=50%
 
-If both nr_blocks (or size) and nr_inodes are set to 0, neither blocks
-nor inodes will be limited in that instance.  It is generally unwise to
+If nr_blocks=0 (or size=0), blocks will not be limited in that instance;
+if nr_inodes=0, inodes will not be limited.  It is generally unwise to
 mount with such options, since it allows any user with write access to
 use up all the memory on the machine; but enhances the scalability of
 that instance in a system with many cpus making intensive use of it.
@@ -97,4 +97,4 @@ RAM/SWAP in 10240 inodes and it is only 
 Author:
    Christoph Rohland <cr@sap.com>, 1.12.01
 Updated:
-   Hugh Dickins <hugh@veritas.com>, 01 September 2004
+   Hugh Dickins <hugh@veritas.com>, 13 March 2005
--- 2.6.12-rc6/mm/shmem.c	2005-05-25 18:09:21.000000000 +0100
+++ linux/mm/shmem.c	2005-06-04 20:41:55.000000000 +0100
@@ -6,8 +6,8 @@
  *		 2000-2001 Christoph Rohland
  *		 2000-2001 SAP AG
  *		 2002 Red Hat Inc.
- * Copyright (C) 2002-2004 Hugh Dickins.
- * Copyright (C) 2002-2004 VERITAS Software Corporation.
+ * Copyright (C) 2002-2005 Hugh Dickins.
+ * Copyright (C) 2002-2005 VERITAS Software Corporation.
  * Copyright (C) 2004 Andi Kleen, SuSE Labs
  *
  * Extended attribute support for tmpfs:
@@ -194,7 +194,7 @@ static DEFINE_SPINLOCK(shmem_swaplist_lo
 static void shmem_free_blocks(struct inode *inode, long pages)
 {
 	struct shmem_sb_info *sbinfo = SHMEM_SB(inode->i_sb);
-	if (sbinfo) {
+	if (sbinfo->max_blocks) {
 		spin_lock(&sbinfo->stat_lock);
 		sbinfo->free_blocks += pages;
 		inode->i_blocks -= pages*BLOCKS_PER_PAGE;
@@ -357,7 +357,7 @@ static swp_entry_t *shmem_swp_alloc(stru
 		 * page (and perhaps indirect index pages) yet to allocate:
 		 * a waste to allocate index if we cannot allocate data.
 		 */
-		if (sbinfo) {
+		if (sbinfo->max_blocks) {
 			spin_lock(&sbinfo->stat_lock);
 			if (sbinfo->free_blocks <= 1) {
 				spin_unlock(&sbinfo->stat_lock);
@@ -677,8 +677,8 @@ static void shmem_delete_inode(struct in
 			spin_unlock(&shmem_swaplist_lock);
 		}
 	}
-	if (sbinfo) {
-		BUG_ON(inode->i_blocks);
+	BUG_ON(inode->i_blocks);
+	if (sbinfo->max_inodes) {
 		spin_lock(&sbinfo->stat_lock);
 		sbinfo->free_inodes++;
 		spin_unlock(&sbinfo->stat_lock);
@@ -1080,7 +1080,7 @@ repeat:
 	} else {
 		shmem_swp_unmap(entry);
 		sbinfo = SHMEM_SB(inode->i_sb);
-		if (sbinfo) {
+		if (sbinfo->max_blocks) {
 			spin_lock(&sbinfo->stat_lock);
 			if (sbinfo->free_blocks == 0 ||
 			    shmem_acct_block(info->flags)) {
@@ -1269,7 +1269,7 @@ shmem_get_inode(struct super_block *sb, 
 	struct shmem_inode_info *info;
 	struct shmem_sb_info *sbinfo = SHMEM_SB(sb);
 
-	if (sbinfo) {
+	if (sbinfo->max_inodes) {
 		spin_lock(&sbinfo->stat_lock);
 		if (!sbinfo->free_inodes) {
 			spin_unlock(&sbinfo->stat_lock);
@@ -1319,7 +1319,7 @@ shmem_get_inode(struct super_block *sb, 
 			mpol_shared_policy_init(&info->policy);
 			break;
 		}
-	} else if (sbinfo) {
+	} else if (sbinfo->max_inodes) {
 		spin_lock(&sbinfo->stat_lock);
 		sbinfo->free_inodes++;
 		spin_unlock(&sbinfo->stat_lock);
@@ -1328,31 +1328,6 @@ shmem_get_inode(struct super_block *sb, 
 }
 
 #ifdef CONFIG_TMPFS
-
-static int shmem_set_size(struct shmem_sb_info *sbinfo,
-			  unsigned long max_blocks, unsigned long max_inodes)
-{
-	int error;
-	unsigned long blocks, inodes;
-
-	spin_lock(&sbinfo->stat_lock);
-	blocks = sbinfo->max_blocks - sbinfo->free_blocks;
-	inodes = sbinfo->max_inodes - sbinfo->free_inodes;
-	error = -EINVAL;
-	if (max_blocks < blocks)
-		goto out;
-	if (max_inodes < inodes)
-		goto out;
-	error = 0;
-	sbinfo->max_blocks  = max_blocks;
-	sbinfo->free_blocks = max_blocks - blocks;
-	sbinfo->max_inodes  = max_inodes;
-	sbinfo->free_inodes = max_inodes - inodes;
-out:
-	spin_unlock(&sbinfo->stat_lock);
-	return error;
-}
-
 static struct inode_operations shmem_symlink_inode_operations;
 static struct inode_operations shmem_symlink_inline_operations;
 
@@ -1607,15 +1582,17 @@ static int shmem_statfs(struct super_blo
 	buf->f_type = TMPFS_MAGIC;
 	buf->f_bsize = PAGE_CACHE_SIZE;
 	buf->f_namelen = NAME_MAX;
-	if (sbinfo) {
-		spin_lock(&sbinfo->stat_lock);
+	spin_lock(&sbinfo->stat_lock);
+	if (sbinfo->max_blocks) {
 		buf->f_blocks = sbinfo->max_blocks;
 		buf->f_bavail = buf->f_bfree = sbinfo->free_blocks;
+	}
+	if (sbinfo->max_inodes) {
 		buf->f_files = sbinfo->max_inodes;
 		buf->f_ffree = sbinfo->free_inodes;
-		spin_unlock(&sbinfo->stat_lock);
 	}
 	/* else leave those fields 0 like simple_statfs */
+	spin_unlock(&sbinfo->stat_lock);
 	return 0;
 }
 
@@ -1672,7 +1649,7 @@ static int shmem_link(struct dentry *old
 	 * but each new link needs a new dentry, pinning lowmem, and
 	 * tmpfs dentries cannot be pruned until they are unlinked.
 	 */
-	if (sbinfo) {
+	if (sbinfo->max_inodes) {
 		spin_lock(&sbinfo->stat_lock);
 		if (!sbinfo->free_inodes) {
 			spin_unlock(&sbinfo->stat_lock);
@@ -1697,7 +1674,7 @@ static int shmem_unlink(struct inode *di
 
 	if (inode->i_nlink > 1 && !S_ISDIR(inode->i_mode)) {
 		struct shmem_sb_info *sbinfo = SHMEM_SB(inode->i_sb);
-		if (sbinfo) {
+		if (sbinfo->max_inodes) {
 			spin_lock(&sbinfo->stat_lock);
 			sbinfo->free_inodes++;
 			spin_unlock(&sbinfo->stat_lock);
@@ -1921,22 +1898,42 @@ bad_val:
 static int shmem_remount_fs(struct super_block *sb, int *flags, char *data)
 {
 	struct shmem_sb_info *sbinfo = SHMEM_SB(sb);
-	unsigned long max_blocks = 0;
-	unsigned long max_inodes = 0;
+	unsigned long max_blocks = sbinfo->max_blocks;
+	unsigned long max_inodes = sbinfo->max_inodes;
+	unsigned long blocks;
+	unsigned long inodes;
+	int error = -EINVAL;
 
-	if (sbinfo) {
-		max_blocks = sbinfo->max_blocks;
-		max_inodes = sbinfo->max_inodes;
-	}
-	if (shmem_parse_options(data, NULL, NULL, NULL, &max_blocks, &max_inodes))
-		return -EINVAL;
-	/* Keep it simple: disallow limited <-> unlimited remount */
-	if ((max_blocks || max_inodes) == !sbinfo)
-		return -EINVAL;
-	/* But allow the pointless unlimited -> unlimited remount */
-	if (!sbinfo)
-		return 0;
-	return shmem_set_size(sbinfo, max_blocks, max_inodes);
+	if (shmem_parse_options(data, NULL, NULL, NULL,
+				&max_blocks, &max_inodes))
+		return error;
+
+	spin_lock(&sbinfo->stat_lock);
+	blocks = sbinfo->max_blocks - sbinfo->free_blocks;
+	inodes = sbinfo->max_inodes - sbinfo->free_inodes;
+	if (max_blocks < blocks)
+		goto out;
+	if (max_inodes < inodes)
+		goto out;
+	/*
+	 * Those tests also disallow limited->unlimited while any are in
+	 * use, so i_blocks will always be zero when max_blocks is zero;
+	 * but we must separately disallow unlimited->limited, because
+	 * in that case we have no record of how much is already in use.
+	 */
+	if (max_blocks && !sbinfo->max_blocks)
+		goto out;
+	if (max_inodes && !sbinfo->max_inodes)
+		goto out;
+
+	error = 0;
+	sbinfo->max_blocks  = max_blocks;
+	sbinfo->free_blocks = max_blocks - blocks;
+	sbinfo->max_inodes  = max_inodes;
+	sbinfo->free_inodes = max_inodes - inodes;
+out:
+	spin_unlock(&sbinfo->stat_lock);
+	return error;
 }
 #endif
 
@@ -1961,11 +1958,11 @@ static int shmem_fill_super(struct super
 	uid_t uid = current->fsuid;
 	gid_t gid = current->fsgid;
 	int err = -ENOMEM;
-
-#ifdef CONFIG_TMPFS
+	struct shmem_sb_info *sbinfo;
 	unsigned long blocks = 0;
 	unsigned long inodes = 0;
 
+#ifdef CONFIG_TMPFS
 	/*
 	 * Per default we only allow half of the physical ram per
 	 * tmpfs instance, limiting inodes to one per page of lowmem;
@@ -1976,34 +1973,34 @@ static int shmem_fill_super(struct super
 		inodes = totalram_pages - totalhigh_pages;
 		if (inodes > blocks)
 			inodes = blocks;
-
-		if (shmem_parse_options(data, &mode,
-					&uid, &gid, &blocks, &inodes))
+		if (shmem_parse_options(data, &mode, &uid, &gid,
+					&blocks, &inodes))
 			return -EINVAL;
 	}
-
-	if (blocks || inodes) {
-		struct shmem_sb_info *sbinfo;
-		sbinfo = kmalloc(sizeof(struct shmem_sb_info), GFP_KERNEL);
-		if (!sbinfo)
-			return -ENOMEM;
-		sb->s_fs_info = sbinfo;
-		spin_lock_init(&sbinfo->stat_lock);
-		sbinfo->max_blocks = blocks;
-		sbinfo->free_blocks = blocks;
-		sbinfo->max_inodes = inodes;
-		sbinfo->free_inodes = inodes;
-	}
-	sb->s_xattr = shmem_xattr_handlers;
 #else
 	sb->s_flags |= MS_NOUSER;
 #endif
 
+	/* Round up to L1_CACHE_BYTES to resist false sharing */
+	sbinfo = kmalloc(max((int)sizeof(struct shmem_sb_info),
+				L1_CACHE_BYTES), GFP_KERNEL);
+	if (!sbinfo)
+		return -ENOMEM;
+
+	spin_lock_init(&sbinfo->stat_lock);
+	sbinfo->max_blocks = blocks;
+	sbinfo->free_blocks = blocks;
+	sbinfo->max_inodes = inodes;
+	sbinfo->free_inodes = inodes;
+
+	sb->s_fs_info = sbinfo;
 	sb->s_maxbytes = SHMEM_MAX_BYTES;
 	sb->s_blocksize = PAGE_CACHE_SIZE;
 	sb->s_blocksize_bits = PAGE_CACHE_SHIFT;
 	sb->s_magic = TMPFS_MAGIC;
 	sb->s_op = &shmem_ops;
+	sb->s_xattr = shmem_xattr_handlers;
+
 	inode = shmem_get_inode(sb, S_IFDIR | mode, 0);
 	if (!inode)
 		goto failed;
