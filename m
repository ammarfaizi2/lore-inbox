Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267325AbUIEWxo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267325AbUIEWxo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 18:53:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267311AbUIEWnx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 18:43:53 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:62336 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S267330AbUIEWjL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 18:39:11 -0400
Date: Sun, 5 Sep 2004 23:38:58 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@osdl.org>
cc: Brent Casavant <bcasavan@sgi.com>, Christoph Rohland <cr@sap.com>,
       Keith Mannthey <kmannth@us.ibm.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/7] shmem: inodes and links need lowmem
In-Reply-To: <Pine.LNX.4.44.0409052331240.3218-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0409052336420.3218-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Mannthey's Bugzilla #3268 drew attention to how tmpfs inodes and
dentries and long names and radix-tree nodes pin lowmem.  Assuming about
1k of lowmem per inode, we need to lower the default nr_inodes limit on
machines with significant highmem.

Be conservative, but more generous than in the original patch to Keith:
limit to number of lowmem pages, which works out around 200,000 on i386.
Easily overridden by giving the nr_inodes= mount option: those who want
to sail closer to the rocks should be allowed to do so.

Notice how tmpfs dentries cannot be reclaimed in the way that disk-based
dentries can: so even hard links need to be costed.  They are cheaper
than inodes, but easier all round to charge the same.  This way, the
limit for hard links is equally visible through "df -i": but expect
occasional bugreports that tmpfs links are being treated like this.

Would have been simpler just to move the free_inodes accounting from
shmem_delete_inode to shmem_unlink; but that would lose the charge on
unlinked but open files.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

 Documentation/filesystems/tmpfs.txt |    6 ++++--
 mm/shmem.c                          |   28 ++++++++++++++++++++++++++--
 2 files changed, 30 insertions(+), 4 deletions(-)

--- shmem1/Documentation/filesystems/tmpfs.txt	2003-04-07 18:33:21.000000000 +0100
+++ shmem2/Documentation/filesystems/tmpfs.txt	2004-09-05 17:05:57.016864440 +0100
@@ -62,7 +62,9 @@ size:      The limit of allocated bytes 
            since the OOM handler will not be able to free that memory.
 nr_blocks: The same as size, but in blocks of PAGE_CACHE_SIZE.
 nr_inodes: The maximum number of inodes for this instance. The default
-           is half of the number of your physical RAM pages.
+           is half of the number of your physical RAM pages, or (on a
+           a machine with highmem) the number of lowmem RAM pages,
+           whichever is the lower.
 
 These parameters accept a suffix k, m or g for kilo, mega and giga and
 can be changed on remount.  The size parameter also accepts a suffix %
@@ -89,4 +91,4 @@ RAM/SWAP in 10240 inodes and it is only 
 Author:
    Christoph Rohland <cr@sap.com>, 1.12.01
 Updated:
-   Hugh Dickins <hugh@veritas.com>, 01 April 2003
+   Hugh Dickins <hugh@veritas.com>, 01 September 2004
--- shmem1/mm/shmem.c	2004-09-05 17:05:45.869559088 +0100
+++ shmem2/mm/shmem.c	2004-09-05 17:05:57.019863984 +0100
@@ -1567,6 +1567,20 @@ static int shmem_create(struct inode *di
 static int shmem_link(struct dentry *old_dentry, struct inode *dir, struct dentry *dentry)
 {
 	struct inode *inode = old_dentry->d_inode;
+	struct shmem_sb_info *sbinfo = SHMEM_SB(inode->i_sb);
+
+	/*
+	 * No ordinary (disk based) filesystem counts links as inodes;
+	 * but each new link needs a new dentry, pinning lowmem, and
+	 * tmpfs dentries cannot be pruned until they are unlinked.
+	 */
+	spin_lock(&sbinfo->stat_lock);
+	if (!sbinfo->free_inodes) {
+		spin_unlock(&sbinfo->stat_lock);
+		return -ENOSPC;
+	}
+	sbinfo->free_inodes--;
+	spin_unlock(&sbinfo->stat_lock);
 
 	dir->i_size += BOGO_DIRENT_SIZE;
 	inode->i_ctime = dir->i_ctime = dir->i_mtime = CURRENT_TIME;
@@ -1581,6 +1595,13 @@ static int shmem_unlink(struct inode *di
 {
 	struct inode *inode = dentry->d_inode;
 
+	if (inode->i_nlink > 1 && !S_ISDIR(inode->i_mode)) {
+		struct shmem_sb_info *sbinfo = SHMEM_SB(inode->i_sb);
+		spin_lock(&sbinfo->stat_lock);
+		sbinfo->free_inodes++;
+		spin_unlock(&sbinfo->stat_lock);
+	}
+
 	dir->i_size -= BOGO_DIRENT_SIZE;
 	inode->i_ctime = dir->i_ctime = dir->i_mtime = CURRENT_TIME;
 	inode->i_nlink--;
@@ -1818,9 +1839,12 @@ static int shmem_fill_super(struct super
 
 	/*
 	 * Per default we only allow half of the physical ram per
-	 * tmpfs instance
+	 * tmpfs instance, limiting inodes to one per page of lowmem.
 	 */
-	blocks = inodes = totalram_pages / 2;
+	blocks = totalram_pages / 2;
+	inodes = totalram_pages - totalhigh_pages;
+	if (inodes > blocks)
+		inodes = blocks;
 
 #ifdef CONFIG_TMPFS
 	if (shmem_parse_options(data, &mode, &uid, &gid, &blocks, &inodes)) {

