Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932287AbWBXQKV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932287AbWBXQKV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 11:10:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932293AbWBXQKV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 11:10:21 -0500
Received: from ppsw-7.csi.cam.ac.uk ([131.111.8.137]:27090 "EHLO
	ppsw-7.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S932287AbWBXQKU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 11:10:20 -0500
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Date: Fri, 24 Feb 2006 16:09:40 +0000 (GMT)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net
Subject: [PATCH 4/5] NTFS: Implement support for sector sizes above 512 bytes.
In-Reply-To: <Pine.LNX.4.64.0602241608120.2136@hermes-2.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.64.0602241608540.2136@hermes-2.csi.cam.ac.uk>
References: <Pine.LNX.4.64.0602241559150.2136@hermes-2.csi.cam.ac.uk>
 <Pine.LNX.4.64.0602241605210.2136@hermes-2.csi.cam.ac.uk>
 <Pine.LNX.4.64.0602241607280.2136@hermes-2.csi.cam.ac.uk>
 <Pine.LNX.4.64.0602241608120.2136@hermes-2.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

NTFS: Implement support for sector sizes above 512 bytes (up to the maximum
      supported by NTFS which is 4096 bytes).

---

 fs/ntfs/ChangeLog |    6 ++
 fs/ntfs/aops.c    |   18 +++---
 fs/ntfs/file.c    |    8 +--
 fs/ntfs/mft.c     |    8 +--
 fs/ntfs/super.c   |  153 +++++++++++++++++++++++++++++++++++------------------
 5 files changed, 122 insertions(+), 71 deletions(-)

78af34f03d33d2ba179c9d35685860170b94a285
diff --git a/fs/ntfs/ChangeLog b/fs/ntfs/ChangeLog
index 4a62201..e66b4ac 100644
--- a/fs/ntfs/ChangeLog
+++ b/fs/ntfs/ChangeLog
@@ -21,8 +21,14 @@ ToDo/Notes:
 
 2.1.26 - Minor bug fixes and updates.
 
+	- Fix a potential overflow in file.c where a cast to s64 was missing in
+	  a left shift of a page index.
+	- The struct inode has had its i_sem semaphore changed to a mutex named
+	  i_mutex.
 	- We have struct kmem_cache now so use it instead of the typedef
 	  kmem_cache_t.  (Pekka Enberg)
+	- Implement support for sector sizes above 512 bytes (up to the maximum
+	  supported by NTFS which is 4096 bytes).
 	- Miscellaneous updates to layout.h.
 	- Cope with attribute list attribute having invalid flags.  Windows
 	  copes with this and even chkdsk does not detect or fix this so we
diff --git a/fs/ntfs/aops.c b/fs/ntfs/aops.c
index 1c0a431..7e361da 100644
--- a/fs/ntfs/aops.c
+++ b/fs/ntfs/aops.c
@@ -2,7 +2,7 @@
  * aops.c - NTFS kernel address space operations and page cache handling.
  *	    Part of the Linux-NTFS project.
  *
- * Copyright (c) 2001-2005 Anton Altaparmakov
+ * Copyright (c) 2001-2006 Anton Altaparmakov
  * Copyright (c) 2002 Richard Russon
  *
  * This program/include file is free software; you can redistribute it and/or
@@ -200,8 +200,8 @@ static int ntfs_read_block(struct page *
 	/* $MFT/$DATA must have its complete runlist in memory at all times. */
 	BUG_ON(!ni->runlist.rl && !ni->mft_no && !NInoAttr(ni));
 
-	blocksize_bits = VFS_I(ni)->i_blkbits;
-	blocksize = 1 << blocksize_bits;
+	blocksize = vol->sb->s_blocksize;
+	blocksize_bits = vol->sb->s_blocksize_bits;
 
 	if (!page_has_buffers(page)) {
 		create_empty_buffers(page, blocksize, 0);
@@ -569,10 +569,8 @@ static int ntfs_write_block(struct page 
 
 	BUG_ON(!NInoNonResident(ni));
 	BUG_ON(NInoMstProtected(ni));
-
-	blocksize_bits = vi->i_blkbits;
-	blocksize = 1 << blocksize_bits;
-
+	blocksize = vol->sb->s_blocksize;
+	blocksize_bits = vol->sb->s_blocksize_bits;
 	if (!page_has_buffers(page)) {
 		BUG_ON(!PageUptodate(page));
 		create_empty_buffers(page, blocksize,
@@ -949,8 +947,8 @@ static int ntfs_write_mst_block(struct p
 	 */
 	BUG_ON(!(is_mft || S_ISDIR(vi->i_mode) ||
 			(NInoAttr(ni) && ni->type == AT_INDEX_ALLOCATION)));
-	bh_size_bits = vi->i_blkbits;
-	bh_size = 1 << bh_size_bits;
+	bh_size = vol->sb->s_blocksize;
+	bh_size_bits = vol->sb->s_blocksize_bits;
 	max_bhs = PAGE_CACHE_SIZE / bh_size;
 	BUG_ON(!max_bhs);
 	BUG_ON(max_bhs > MAX_BUF_PER_PAGE);
@@ -1596,7 +1594,7 @@ void mark_ntfs_record_dirty(struct page 
 
 	BUG_ON(!PageUptodate(page));
 	end = ofs + ni->itype.index.block_size;
-	bh_size = 1 << VFS_I(ni)->i_blkbits;
+	bh_size = VFS_I(ni)->i_sb->s_blocksize;
 	spin_lock(&mapping->private_lock);
 	if (unlikely(!page_has_buffers(page))) {
 		spin_unlock(&mapping->private_lock);
diff --git a/fs/ntfs/file.c b/fs/ntfs/file.c
index 3a119a8..5027d3d 100644
--- a/fs/ntfs/file.c
+++ b/fs/ntfs/file.c
@@ -1,7 +1,7 @@
 /*
  * file.c - NTFS kernel file operations.  Part of the Linux-NTFS project.
  *
- * Copyright (c) 2001-2005 Anton Altaparmakov
+ * Copyright (c) 2001-2006 Anton Altaparmakov
  *
  * This program/include file is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License as published
@@ -529,8 +529,8 @@ static int ntfs_prepare_pages_for_non_re
 			"index 0x%lx, nr_pages 0x%x, pos 0x%llx, bytes 0x%zx.",
 			vi->i_ino, ni->type, pages[0]->index, nr_pages,
 			(long long)pos, bytes);
-	blocksize_bits = vi->i_blkbits;
-	blocksize = 1 << blocksize_bits;
+	blocksize = vol->sb->s_blocksize;
+	blocksize_bits = vol->sb->s_blocksize_bits;
 	u = 0;
 	do {
 		struct page *page = pages[u];
@@ -1525,7 +1525,7 @@ static inline int ntfs_commit_pages_afte
 
 	vi = pages[0]->mapping->host;
 	ni = NTFS_I(vi);
-	blocksize = 1 << vi->i_blkbits;
+	blocksize = vi->i_sb->s_blocksize;
 	end = pos + bytes;
 	u = 0;
 	do {
diff --git a/fs/ntfs/mft.c b/fs/ntfs/mft.c
index 0c65cbb..6499aaf 100644
--- a/fs/ntfs/mft.c
+++ b/fs/ntfs/mft.c
@@ -1,7 +1,7 @@
 /**
  * mft.c - NTFS kernel mft record operations. Part of the Linux-NTFS project.
  *
- * Copyright (c) 2001-2005 Anton Altaparmakov
+ * Copyright (c) 2001-2006 Anton Altaparmakov
  * Copyright (c) 2002 Richard Russon
  *
  * This program/include file is free software; you can redistribute it and/or
@@ -473,7 +473,7 @@ int ntfs_sync_mft_mirror(ntfs_volume *vo
 	runlist_element *rl;
 	unsigned int block_start, block_end, m_start, m_end, page_ofs;
 	int i_bhs, nr_bhs, err = 0;
-	unsigned char blocksize_bits = vol->mftmirr_ino->i_blkbits;
+	unsigned char blocksize_bits = vol->sb->s_blocksize_bits;
 
 	ntfs_debug("Entering for inode 0x%lx.", mft_no);
 	BUG_ON(!max_bhs);
@@ -672,8 +672,8 @@ int write_mft_record_nolock(ntfs_inode *
 {
 	ntfs_volume *vol = ni->vol;
 	struct page *page = ni->page;
-	unsigned char blocksize_bits = vol->mft_ino->i_blkbits;
-	unsigned int blocksize = 1 << blocksize_bits;
+	unsigned int blocksize = vol->sb->s_blocksize;
+	unsigned char blocksize_bits = vol->sb->s_blocksize_bits;
 	int max_bhs = vol->mft_record_size / blocksize;
 	struct buffer_head *bhs[max_bhs];
 	struct buffer_head *bh, *head;
diff --git a/fs/ntfs/super.c b/fs/ntfs/super.c
index e9c0d80..489f704 100644
--- a/fs/ntfs/super.c
+++ b/fs/ntfs/super.c
@@ -1,7 +1,7 @@
 /*
  * super.c - NTFS kernel super block handling. Part of the Linux-NTFS project.
  *
- * Copyright (c) 2001-2005 Anton Altaparmakov
+ * Copyright (c) 2001-2006 Anton Altaparmakov
  * Copyright (c) 2001,2002 Richard Russon
  *
  * This program/include file is free software; you can redistribute it and/or
@@ -22,6 +22,7 @@
 
 #include <linux/stddef.h>
 #include <linux/init.h>
+#include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/spinlock.h>
 #include <linux/blkdev.h>	/* For bdev_hardsect_size(). */
@@ -641,7 +642,7 @@ static struct buffer_head *read_ntfs_boo
 {
 	const char *read_err_str = "Unable to read %s boot sector.";
 	struct buffer_head *bh_primary, *bh_backup;
-	long nr_blocks = NTFS_SB(sb)->nr_blocks;
+	sector_t nr_blocks = NTFS_SB(sb)->nr_blocks;
 
 	/* Try to read primary boot sector. */
 	if ((bh_primary = sb_bread(sb, 0))) {
@@ -688,13 +689,18 @@ hotfix_primary_boot_sector:
 		/*
 		 * If we managed to read sector zero and the volume is not
 		 * read-only, copy the found, valid backup boot sector to the
-		 * primary boot sector.
+		 * primary boot sector.  Note we only copy the actual boot
+		 * sector structure, not the actual whole device sector as that
+		 * may be bigger and would potentially damage the $Boot system
+		 * file (FIXME: Would be nice to know if the backup boot sector
+		 * on a large sector device contains the whole boot loader or
+		 * just the first 512 bytes).
 		 */
 		if (!(sb->s_flags & MS_RDONLY)) {
 			ntfs_warning(sb, "Hot-fix: Recovering invalid primary "
 					"boot sector from backup copy.");
 			memcpy(bh_primary->b_data, bh_backup->b_data,
-					sb->s_blocksize);
+					NTFS_BLOCK_SIZE);
 			mark_buffer_dirty(bh_primary);
 			sync_dirty_buffer(bh_primary);
 			if (buffer_uptodate(bh_primary)) {
@@ -733,9 +739,13 @@ static BOOL parse_ntfs_boot_sector(ntfs_
 			vol->sector_size);
 	ntfs_debug("vol->sector_size_bits = %i (0x%x)", vol->sector_size_bits,
 			vol->sector_size_bits);
-	if (vol->sector_size != vol->sb->s_blocksize)
-		ntfs_warning(vol->sb, "The boot sector indicates a sector size "
-				"different from the device sector size.");
+	if (vol->sector_size < vol->sb->s_blocksize) {
+		ntfs_error(vol->sb, "Sector size (%i) is smaller than the "
+				"device block size (%lu).  This is not "
+				"supported.  Sorry.", vol->sector_size,
+				vol->sb->s_blocksize);
+		return FALSE;
+	}
 	ntfs_debug("sectors_per_cluster = 0x%x", b->bpb.sectors_per_cluster);
 	sectors_per_cluster_bits = ffs(b->bpb.sectors_per_cluster) - 1;
 	ntfs_debug("sectors_per_cluster_bits = 0x%x",
@@ -748,16 +758,11 @@ static BOOL parse_ntfs_boot_sector(ntfs_
 	ntfs_debug("vol->cluster_size = %i (0x%x)", vol->cluster_size,
 			vol->cluster_size);
 	ntfs_debug("vol->cluster_size_mask = 0x%x", vol->cluster_size_mask);
-	ntfs_debug("vol->cluster_size_bits = %i (0x%x)",
-			vol->cluster_size_bits, vol->cluster_size_bits);
-	if (vol->sector_size > vol->cluster_size) {
-		ntfs_error(vol->sb, "Sector sizes above the cluster size are "
-				"not supported.  Sorry.");
-		return FALSE;
-	}
-	if (vol->sb->s_blocksize > vol->cluster_size) {
-		ntfs_error(vol->sb, "Cluster sizes smaller than the device "
-				"sector size are not supported.  Sorry.");
+	ntfs_debug("vol->cluster_size_bits = %i", vol->cluster_size_bits);
+	if (vol->cluster_size < vol->sector_size) {
+		ntfs_error(vol->sb, "Cluster size (%i) is smaller than the "
+				"sector size (%i).  This is not supported.  "
+				"Sorry.", vol->cluster_size, vol->sector_size);
 		return FALSE;
 	}
 	clusters_per_mft_record = b->clusters_per_mft_record;
@@ -786,11 +791,18 @@ static BOOL parse_ntfs_boot_sector(ntfs_
 	 * we store $MFT/$DATA, the table of mft records in the page cache.
 	 */
 	if (vol->mft_record_size > PAGE_CACHE_SIZE) {
-		ntfs_error(vol->sb, "Mft record size %i (0x%x) exceeds the "
-				"page cache size on your system %lu (0x%lx).  "
+		ntfs_error(vol->sb, "Mft record size (%i) exceeds the "
+				"PAGE_CACHE_SIZE on your system (%lu).  "
 				"This is not supported.  Sorry.",
-				vol->mft_record_size, vol->mft_record_size,
-				PAGE_CACHE_SIZE, PAGE_CACHE_SIZE);
+				vol->mft_record_size, PAGE_CACHE_SIZE);
+		return FALSE;
+	}
+	/* We cannot support mft record sizes below the sector size. */
+	if (vol->mft_record_size < vol->sector_size) {
+		ntfs_error(vol->sb, "Mft record size (%i) is smaller than the "
+				"sector size (%i).  This is not supported.  "
+				"Sorry.", vol->mft_record_size,
+				vol->sector_size);
 		return FALSE;
 	}
 	clusters_per_index_record = b->clusters_per_index_record;
@@ -816,6 +828,14 @@ static BOOL parse_ntfs_boot_sector(ntfs_
 	ntfs_debug("vol->index_record_size_bits = %i (0x%x)",
 			vol->index_record_size_bits,
 			vol->index_record_size_bits);
+	/* We cannot support index record sizes below the sector size. */
+	if (vol->index_record_size < vol->sector_size) {
+		ntfs_error(vol->sb, "Index record size (%i) is smaller than "
+				"the sector size (%i).  This is not "
+				"supported.  Sorry.", vol->index_record_size,
+				vol->sector_size);
+		return FALSE;
+	}
 	/*
 	 * Get the size of the volume in clusters and check for 64-bit-ness.
 	 * Windows currently only uses 32 bits to save the clusters so we do
@@ -845,15 +865,18 @@ static BOOL parse_ntfs_boot_sector(ntfs_
 	}
 	ll = sle64_to_cpu(b->mft_lcn);
 	if (ll >= vol->nr_clusters) {
-		ntfs_error(vol->sb, "MFT LCN is beyond end of volume.  Weird.");
+		ntfs_error(vol->sb, "MFT LCN (%lli, 0x%llx) is beyond end of "
+				"volume.  Weird.", (unsigned long long)ll,
+				(unsigned long long)ll);
 		return FALSE;
 	}
 	vol->mft_lcn = ll;
 	ntfs_debug("vol->mft_lcn = 0x%llx", (long long)vol->mft_lcn);
 	ll = sle64_to_cpu(b->mftmirr_lcn);
 	if (ll >= vol->nr_clusters) {
-		ntfs_error(vol->sb, "MFTMirr LCN is beyond end of volume.  "
-				"Weird.");
+		ntfs_error(vol->sb, "MFTMirr LCN (%lli, 0x%llx) is beyond end "
+				"of volume.  Weird.", (unsigned long long)ll,
+				(unsigned long long)ll);
 		return FALSE;
 	}
 	vol->mftmirr_lcn = ll;
@@ -2685,7 +2708,7 @@ static int ntfs_fill_super(struct super_
 	ntfs_volume *vol;
 	struct buffer_head *bh;
 	struct inode *tmp_ino;
-	int result;
+	int blocksize, result;
 
 	ntfs_debug("Entering.");
 #ifndef NTFS_RW
@@ -2724,60 +2747,85 @@ static int ntfs_fill_super(struct super_
 	if (!parse_options(vol, (char*)opt))
 		goto err_out_now;
 
+	/* We support sector sizes up to the PAGE_CACHE_SIZE. */
+	if (bdev_hardsect_size(sb->s_bdev) > PAGE_CACHE_SIZE) {
+		if (!silent)
+			ntfs_error(sb, "Device has unsupported sector size "
+					"(%i).  The maximum supported sector "
+					"size on this architecture is %lu "
+					"bytes.",
+					bdev_hardsect_size(sb->s_bdev),
+					PAGE_CACHE_SIZE);
+		goto err_out_now;
+	}
 	/*
-	 * TODO: Fail safety check. In the future we should really be able to
-	 * cope with this being the case, but for now just bail out.
+	 * Setup the device access block size to NTFS_BLOCK_SIZE or the hard
+	 * sector size, whichever is bigger.
 	 */
-	if (bdev_hardsect_size(sb->s_bdev) > NTFS_BLOCK_SIZE) {
+	blocksize = sb_min_blocksize(sb, NTFS_BLOCK_SIZE);
+	if (blocksize < NTFS_BLOCK_SIZE) {
 		if (!silent)
-			ntfs_error(sb, "Device has unsupported hardsect_size.");
+			ntfs_error(sb, "Unable to set device block size.");
 		goto err_out_now;
 	}
-
-	/* Setup the device access block size to NTFS_BLOCK_SIZE. */
-	if (sb_set_blocksize(sb, NTFS_BLOCK_SIZE) != NTFS_BLOCK_SIZE) {
+	BUG_ON(blocksize != sb->s_blocksize);
+	ntfs_debug("Set device block size to %i bytes (block size bits %i).",
+			blocksize, sb->s_blocksize_bits);
+	/* Determine the size of the device in units of block_size bytes. */
+	if (!i_size_read(sb->s_bdev->bd_inode)) {
 		if (!silent)
-			ntfs_error(sb, "Unable to set block size.");
+			ntfs_error(sb, "Unable to determine device size.");
 		goto err_out_now;
 	}
-
-	/* Get the size of the device in units of NTFS_BLOCK_SIZE bytes. */
 	vol->nr_blocks = i_size_read(sb->s_bdev->bd_inode) >>
-			NTFS_BLOCK_SIZE_BITS;
-
+			sb->s_blocksize_bits;
 	/* Read the boot sector and return unlocked buffer head to it. */
 	if (!(bh = read_ntfs_boot_sector(sb, silent))) {
 		if (!silent)
 			ntfs_error(sb, "Not an NTFS volume.");
 		goto err_out_now;
 	}
-
 	/*
-	 * Extract the data from the boot sector and setup the ntfs super block
+	 * Extract the data from the boot sector and setup the ntfs volume
 	 * using it.
 	 */
 	result = parse_ntfs_boot_sector(vol, (NTFS_BOOT_SECTOR*)bh->b_data);
-
-	/* Initialize the cluster and mft allocators. */
-	ntfs_setup_allocators(vol);
-
 	brelse(bh);
-
 	if (!result) {
 		if (!silent)
 			ntfs_error(sb, "Unsupported NTFS filesystem.");
 		goto err_out_now;
 	}
-
 	/*
-	 * TODO: When we start coping with sector sizes different from
-	 * NTFS_BLOCK_SIZE, we now probably need to set the blocksize of the
-	 * device (probably to NTFS_BLOCK_SIZE).
-	 */
-
+	 * If the boot sector indicates a sector size bigger than the current
+	 * device block size, switch the device block size to the sector size.
+	 * TODO: It may be possible to support this case even when the set
+	 * below fails, we would just be breaking up the i/o for each sector
+	 * into multiple blocks for i/o purposes but otherwise it should just
+	 * work.  However it is safer to leave disabled until someone hits this
+	 * error message and then we can get them to try it without the setting
+	 * so we know for sure that it works.
+	 */
+	if (vol->sector_size > blocksize) {
+		blocksize = sb_set_blocksize(sb, vol->sector_size);
+		if (blocksize != vol->sector_size) {
+			if (!silent)
+				ntfs_error(sb, "Unable to set device block "
+						"size to sector size (%i).",
+						vol->sector_size);
+			goto err_out_now;
+		}
+		BUG_ON(blocksize != sb->s_blocksize);
+		vol->nr_blocks = i_size_read(sb->s_bdev->bd_inode) >>
+				sb->s_blocksize_bits;
+		ntfs_debug("Changed device block size to %i bytes (block size "
+				"bits %i) to match volume sector size.",
+				blocksize, sb->s_blocksize_bits);
+	}
+	/* Initialize the cluster and mft allocators. */
+	ntfs_setup_allocators(vol);
 	/* Setup remaining fields in the super block. */
 	sb->s_magic = NTFS_SB_MAGIC;
-
 	/*
 	 * Ntfs allows 63 bits for the file size, i.e. correct would be:
 	 *	sb->s_maxbytes = ~0ULL >> 1;
@@ -2787,9 +2835,8 @@ static int ntfs_fill_super(struct super_
 	 * without overflowing the index or to 2^63 - 1, whichever is smaller.
 	 */
 	sb->s_maxbytes = MAX_LFS_FILESIZE;
-
+	/* Ntfs measures time in 100ns intervals. */
 	sb->s_time_gran = 100;
-
 	/*
 	 * Now load the metadata required for the page cache and our address
 	 * space operations to function. We do this by setting up a specialised
-- 
1.2.3.g9821

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/
