Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030184AbVIIJ1O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030184AbVIIJ1O (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 05:27:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030186AbVIIJ1N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 05:27:13 -0400
Received: from ppsw-9.csi.cam.ac.uk ([131.111.8.139]:61841 "EHLO
	ppsw-9.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S1030185AbVIIJ1L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 05:27:11 -0400
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Date: Fri, 9 Sep 2005 10:27:06 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net
Subject: [PATCH 14/25] NTFS: Fix handling of sparse attributes in
 ntfs_attr_make_non_resident().
In-Reply-To: <Pine.LNX.4.60.0509090950100.11051@hermes-1.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.60.0509091026470.26845@hermes-1.csi.cam.ac.uk>
References: <Pine.LNX.4.60.0509090950100.11051@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH 14/25] NTFS: Fix handling of sparse attributes in ntfs_attr_make_non_resident().
      Also, add BUG() checks to ntfs_attr_make_non_resident() and
      ntfs_attr_set() to ensure that these functions are never called
      for compressed or encrypted attributes.

Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

---

 fs/ntfs/ChangeLog |    4 ++++
 fs/ntfs/attrib.c  |   53 ++++++++++++++++++++++++++++++++++++-----------------
 2 files changed, 40 insertions(+), 17 deletions(-)

807c453de7c5487d2e5eece76bafdea8f39d249e
diff --git a/fs/ntfs/ChangeLog b/fs/ntfs/ChangeLog
--- a/fs/ntfs/ChangeLog
+++ b/fs/ntfs/ChangeLog
@@ -66,6 +66,10 @@ ToDo/Notes:
 	  return LCN_ENOENT when there is no runlist and the allocated size is
 	  zero.
 	- Fix load_attribute_list() to handle the case of a NULL runlist.
+	- Fix handling of sparse attributes in ntfs_attr_make_non_resident().
+	- Add BUG() checks to ntfs_attr_make_non_resident() and ntfs_attr_set()
+	  to ensure that these functions are never called for compressed or
+	  encrypted attributes.
 
 2.1.23 - Implement extension of resident files and make writing safe as well as
 	 many bug fixes, cleanups, and enhancements...
diff --git a/fs/ntfs/attrib.c b/fs/ntfs/attrib.c
--- a/fs/ntfs/attrib.c
+++ b/fs/ntfs/attrib.c
@@ -1372,6 +1372,12 @@ int ntfs_attr_make_non_resident(ntfs_ino
 		return err;
 	}
 	/*
+	 * FIXME: Compressed and encrypted attributes are not supported when
+	 * writing and we should never have gotten here for them.
+	 */
+	BUG_ON(NInoCompressed(ni));
+	BUG_ON(NInoEncrypted(ni));
+	/*
 	 * The size needs to be aligned to a cluster boundary for allocation
 	 * purposes.
 	 */
@@ -1447,10 +1453,15 @@ int ntfs_attr_make_non_resident(ntfs_ino
 	BUG_ON(a->non_resident);
 	/*
 	 * Calculate new offsets for the name and the mapping pairs array.
-	 * We assume the attribute is not compressed or sparse.
 	 */
-	name_ofs = (offsetof(ATTR_REC,
-			data.non_resident.compressed_size) + 7) & ~7;
+	if (NInoSparse(ni) || NInoCompressed(ni))
+		name_ofs = (offsetof(ATTR_REC,
+				data.non_resident.compressed_size) +
+				sizeof(a->data.non_resident.compressed_size) +
+				7) & ~7;
+	else
+		name_ofs = (offsetof(ATTR_REC,
+				data.non_resident.compressed_size) + 7) & ~7;
 	mp_ofs = (name_ofs + a->name_length * sizeof(ntfschar) + 7) & ~7;
 	/*
 	 * Determine the size of the resident part of the now non-resident
@@ -1489,24 +1500,23 @@ int ntfs_attr_make_non_resident(ntfs_ino
 		memmove((u8*)a + name_ofs, (u8*)a + le16_to_cpu(a->name_offset),
 				a->name_length * sizeof(ntfschar));
 	a->name_offset = cpu_to_le16(name_ofs);
-	/*
-	 * FIXME: For now just clear all of these as we do not support them
-	 * when writing.
-	 */
-	a->flags &= cpu_to_le16(0xffff & ~le16_to_cpu(ATTR_IS_SPARSE |
-			ATTR_IS_ENCRYPTED | ATTR_COMPRESSION_MASK));
 	/* Setup the fields specific to non-resident attributes. */
 	a->data.non_resident.lowest_vcn = 0;
 	a->data.non_resident.highest_vcn = cpu_to_sle64((new_size - 1) >>
 			vol->cluster_size_bits);
 	a->data.non_resident.mapping_pairs_offset = cpu_to_le16(mp_ofs);
-	a->data.non_resident.compression_unit = 0;
 	memset(&a->data.non_resident.reserved, 0,
 			sizeof(a->data.non_resident.reserved));
 	a->data.non_resident.allocated_size = cpu_to_sle64(new_size);
 	a->data.non_resident.data_size =
 			a->data.non_resident.initialized_size =
 			cpu_to_sle64(attr_size);
+	if (NInoSparse(ni) || NInoCompressed(ni)) {
+		a->data.non_resident.compression_unit = 4;
+		a->data.non_resident.compressed_size =
+				a->data.non_resident.allocated_size;
+	} else
+		a->data.non_resident.compression_unit = 0;
 	/* Generate the mapping pairs array into the attribute record. */
 	err = ntfs_mapping_pairs_build(vol, (u8*)a + mp_ofs,
 			arec_size - mp_ofs, rl, 0, -1, NULL);
@@ -1516,16 +1526,19 @@ int ntfs_attr_make_non_resident(ntfs_ino
 		goto undo_err_out;
 	}
 	/* Setup the in-memory attribute structure to be non-resident. */
-	/*
-	 * FIXME: For now just clear all of these as we do not support them
-	 * when writing.
-	 */
-	NInoClearSparse(ni);
-	NInoClearEncrypted(ni);
-	NInoClearCompressed(ni);
 	ni->runlist.rl = rl;
 	write_lock_irqsave(&ni->size_lock, flags);
 	ni->allocated_size = new_size;
+	if (NInoSparse(ni) || NInoCompressed(ni)) {
+		ni->itype.compressed.size = ni->allocated_size;
+		ni->itype.compressed.block_size = 1U <<
+				(a->data.non_resident.compression_unit +
+				vol->cluster_size_bits);
+		ni->itype.compressed.block_size_bits =
+				ffs(ni->itype.compressed.block_size) - 1;
+		ni->itype.compressed.block_clusters = 1U <<
+				a->data.non_resident.compression_unit;
+	}
 	write_unlock_irqrestore(&ni->size_lock, flags);
 	/*
 	 * This needs to be last since the address space operations ->readpage
@@ -1673,6 +1686,12 @@ int ntfs_attr_set(ntfs_inode *ni, const 
 	BUG_ON(cnt < 0);
 	if (!cnt)
 		goto done;
+	/*
+	 * FIXME: Compressed and encrypted attributes are not supported when
+	 * writing and we should never have gotten here for them.
+	 */
+	BUG_ON(NInoCompressed(ni));
+	BUG_ON(NInoEncrypted(ni));
 	mapping = VFS_I(ni)->i_mapping;
 	/* Work out the starting index and page offset. */
 	idx = ofs >> PAGE_CACHE_SHIFT;
