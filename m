Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267306AbUIEWxn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267306AbUIEWxn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 18:53:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267325AbUIEWoW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 18:44:22 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:1416 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S267319AbUIEWlG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 18:41:06 -0400
Date: Sun, 5 Sep 2004 23:40:47 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@osdl.org>
cc: Brent Casavant <bcasavan@sgi.com>, Christoph Rohland <cr@sap.com>,
       <linux-kernel@vger.kernel.org>
Subject: [PATCH 4/7] shmem: no sbinfo for tmpfs mount?
In-Reply-To: <Pine.LNX.4.44.0409052331240.3218-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0409052340020.3218-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some might want a tmpfs mount with the improved scalability afforded by
omitting shmem superblock accounting; or some might just want to test it
in an externally-visible tmpfs mount instance.

Adopt the convention that mount option -o nr_blocks=0,nr_inodes=0 means
without resource limits, and hence no shmem_sb_info.  Not recommended
for general use, but no worse than ramfs.

Disallow remounting from unlimited to limited (no accounting has been
done so far, so no idea whether it's permissible), and from limited to
unlimited (because we'd need then to free the sbinfo, and visit each
inode to reset its i_blocks to 0: why bother?).

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

 Documentation/filesystems/tmpfs.txt |    6 +++
 mm/shmem.c                          |   60 ++++++++++++++++++++++++------------
 2 files changed, 47 insertions(+), 19 deletions(-)

--- shmem3/Documentation/filesystems/tmpfs.txt	2004-09-05 17:05:57.016864440 +0100
+++ shmem4/Documentation/filesystems/tmpfs.txt	2004-09-05 17:06:19.136501744 +0100
@@ -71,6 +71,12 @@ can be changed on remount.  The size par
 to limit this tmpfs instance to that percentage of your physical RAM:
 the default, when neither size nor nr_blocks is specified, is size=50%
 
+If both nr_blocks (or size) and nr_inodes are set to 0, neither blocks
+nor inodes will be limited in that instance.  It is generally unwise to
+mount with such options, since it allows any user with write access to
+use up all the memory on the machine; but enhances the scalability of
+that instance in a system with many cpus making intensive use of it.
+
 
 To specify the initial root directory you can use the following mount
 options:
--- shmem3/mm/shmem.c	2004-09-05 17:06:08.078182864 +0100
+++ shmem4/mm/shmem.c	2004-09-05 17:06:19.139501288 +0100
@@ -1528,13 +1528,16 @@ static int shmem_statfs(struct super_blo
 
 	buf->f_type = TMPFS_MAGIC;
 	buf->f_bsize = PAGE_CACHE_SIZE;
-	spin_lock(&sbinfo->stat_lock);
-	buf->f_blocks = sbinfo->max_blocks;
-	buf->f_bavail = buf->f_bfree = sbinfo->free_blocks;
-	buf->f_files = sbinfo->max_inodes;
-	buf->f_ffree = sbinfo->free_inodes;
-	spin_unlock(&sbinfo->stat_lock);
 	buf->f_namelen = NAME_MAX;
+	if (sbinfo) {
+		spin_lock(&sbinfo->stat_lock);
+		buf->f_blocks = sbinfo->max_blocks;
+		buf->f_bavail = buf->f_bfree = sbinfo->free_blocks;
+		buf->f_files = sbinfo->max_inodes;
+		buf->f_ffree = sbinfo->free_inodes;
+		spin_unlock(&sbinfo->stat_lock);
+	}
+	/* else leave those fields 0 like simple_statfs */
 	return 0;
 }
 
@@ -1591,13 +1594,15 @@ static int shmem_link(struct dentry *old
 	 * but each new link needs a new dentry, pinning lowmem, and
 	 * tmpfs dentries cannot be pruned until they are unlinked.
 	 */
-	spin_lock(&sbinfo->stat_lock);
-	if (!sbinfo->free_inodes) {
+	if (sbinfo) {
+		spin_lock(&sbinfo->stat_lock);
+		if (!sbinfo->free_inodes) {
+			spin_unlock(&sbinfo->stat_lock);
+			return -ENOSPC;
+		}
+		sbinfo->free_inodes--;
 		spin_unlock(&sbinfo->stat_lock);
-		return -ENOSPC;
 	}
-	sbinfo->free_inodes--;
-	spin_unlock(&sbinfo->stat_lock);
 
 	dir->i_size += BOGO_DIRENT_SIZE;
 	inode->i_ctime = dir->i_ctime = dir->i_mtime = CURRENT_TIME;
@@ -1614,9 +1619,11 @@ static int shmem_unlink(struct inode *di
 
 	if (inode->i_nlink > 1 && !S_ISDIR(inode->i_mode)) {
 		struct shmem_sb_info *sbinfo = SHMEM_SB(inode->i_sb);
-		spin_lock(&sbinfo->stat_lock);
-		sbinfo->free_inodes++;
-		spin_unlock(&sbinfo->stat_lock);
+		if (sbinfo) {
+			spin_lock(&sbinfo->stat_lock);
+			sbinfo->free_inodes++;
+			spin_unlock(&sbinfo->stat_lock);
+		}
 	}
 
 	dir->i_size -= BOGO_DIRENT_SIZE;
@@ -1827,11 +1834,21 @@ bad_val:
 static int shmem_remount_fs(struct super_block *sb, int *flags, char *data)
 {
 	struct shmem_sb_info *sbinfo = SHMEM_SB(sb);
-	unsigned long max_blocks = sbinfo->max_blocks;
-	unsigned long max_inodes = sbinfo->max_inodes;
+	unsigned long max_blocks = 0;
+	unsigned long max_inodes = 0;
 
+	if (sbinfo) {
+		max_blocks = sbinfo->max_blocks;
+		max_inodes = sbinfo->max_inodes;
+	}
 	if (shmem_parse_options(data, NULL, NULL, NULL, &max_blocks, &max_inodes))
 		return -EINVAL;
+	/* Keep it simple: disallow limited <-> unlimited remount */
+	if ((max_blocks || max_inodes) == !sbinfo)
+		return -EINVAL;
+	/* But allow the pointless unlimited -> unlimited remount */
+	if (!sbinfo)
+		return 0;
 	return shmem_set_size(sbinfo, max_blocks, max_inodes);
 }
 #endif
@@ -1853,22 +1870,27 @@ static int shmem_fill_super(struct super
 	int err = -ENOMEM;
 
 #ifdef CONFIG_TMPFS
+	unsigned long blocks = 0;
+	unsigned long inodes = 0;
+
 	/*
 	 * Per default we only allow half of the physical ram per
 	 * tmpfs instance, limiting inodes to one per page of lowmem;
 	 * but the internal instance is left unlimited.
 	 */
 	if (!(sb->s_flags & MS_NOUSER)) {
-		struct shmem_sb_info *sbinfo;
-		unsigned long blocks = totalram_pages / 2;
-		unsigned long inodes = totalram_pages - totalhigh_pages;
+		blocks = totalram_pages / 2;
+		inodes = totalram_pages - totalhigh_pages;
 		if (inodes > blocks)
 			inodes = blocks;
 
 		if (shmem_parse_options(data, &mode,
 					&uid, &gid, &blocks, &inodes))
 			return -EINVAL;
+	}
 
+	if (blocks || inodes) {
+		struct shmem_sb_info *sbinfo;
 		sbinfo = kmalloc(sizeof(struct shmem_sb_info), GFP_KERNEL);
 		if (!sbinfo)
 			return -ENOMEM;

