Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751054AbWBXQI4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751054AbWBXQI4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 11:08:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751062AbWBXQI4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 11:08:56 -0500
Received: from ppsw-9.csi.cam.ac.uk ([131.111.8.139]:18610 "EHLO
	ppsw-9.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S1751054AbWBXQIz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 11:08:55 -0500
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Date: Fri, 24 Feb 2006 16:08:50 +0000 (GMT)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net
Subject: [PATCH 3/5] NTFS: - Cope with attribute list attribute having invalid
 flags.
In-Reply-To: <Pine.LNX.4.64.0602241607280.2136@hermes-2.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.64.0602241608120.2136@hermes-2.csi.cam.ac.uk>
References: <Pine.LNX.4.64.0602241559150.2136@hermes-2.csi.cam.ac.uk>
 <Pine.LNX.4.64.0602241605210.2136@hermes-2.csi.cam.ac.uk>
 <Pine.LNX.4.64.0602241607280.2136@hermes-2.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

NTFS: - Cope with attribute list attribute having invalid flags.
	Windows copes with this and even chkdsk does not detect or fix this
	so we have to cope with it, too.  Thanks to Pawel Kot for reporting
	the problem.
      - Miscellaneous updates to layout.h.

Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

---

 fs/ntfs/ChangeLog |   28 +++++++++++++++++++---------
 fs/ntfs/inode.c   |   49 +++++++++++++++++++++++++++++++++++++++----------
 fs/ntfs/layout.h  |   25 ++++++++++++++++++-------
 3 files changed, 76 insertions(+), 26 deletions(-)

3672b638ec1d5b1020ea27986060b830f09c96c1
diff --git a/fs/ntfs/ChangeLog b/fs/ntfs/ChangeLog
index 02f4409..4a62201 100644
--- a/fs/ntfs/ChangeLog
+++ b/fs/ntfs/ChangeLog
@@ -1,9 +1,9 @@
 ToDo/Notes:
 	- Find and fix bugs.
 	- The only places in the kernel where a file is resized are
-	  ntfs_file_write*() and ntfs_truncate() for both of which i_sem is
+	  ntfs_file_write*() and ntfs_truncate() for both of which i_mutex is
 	  held.  Just have to be careful in read-/writepage and other helpers
-	  not running under i_sem that we play nice...  Also need to be careful
+	  not running under i_mutex that we play nice.  Also need to be careful
 	  with initialized_size extension in ntfs_file_write*() and writepage.
 	  UPDATE: The only things that need to be checked are the compressed
 	  write and the other attribute resize/write cases like index
@@ -19,6 +19,16 @@ ToDo/Notes:
 	- Enable the code for setting the NT4 compatibility flag when we start
 	  making NTFS 1.2 specific modifications.
 
+2.1.26 - Minor bug fixes and updates.
+
+	- We have struct kmem_cache now so use it instead of the typedef
+	  kmem_cache_t.  (Pekka Enberg)
+	- Miscellaneous updates to layout.h.
+	- Cope with attribute list attribute having invalid flags.  Windows
+	  copes with this and even chkdsk does not detect or fix this so we
+	  have to cope with it, too.  Thanks to Pawel Kot for reporting the
+	  problem.
+
 2.1.25 - (Almost) fully implement write(2) and truncate(2).
 
 	- Change ntfs_map_runlist_nolock(), ntfs_attr_find_vcn_nolock() and
@@ -373,7 +383,7 @@ ToDo/Notes:
 	  single one of them had an mst error.  (Thanks to Ken MacFerrin for
 	  the bug report.)
 	- Fix error handling in fs/ntfs/quota.c::ntfs_mark_quotas_out_of_date()
-	  where we failed to release i_sem on the $Quota/$Q attribute inode.
+	  where we failed to release i_mutex on the $Quota/$Q attribute inode.
 	- Fix bug in handling of bad inodes in fs/ntfs/namei.c::ntfs_lookup().
 	- Add mapping of unmapped buffers to all remaining code paths, i.e.
 	  fs/ntfs/aops.c::ntfs_write_mst_block(), mft.c::ntfs_sync_mft_mirror(),
@@ -874,7 +884,7 @@ ToDo/Notes:
 	  clusters. (Philipp Thomas)
 	- attrib.c::load_attribute_list(): Fix bug when initialized_size is a
 	  multiple of the block_size but not the cluster size. (Szabolcs
-	  Szakacsits <szaka@sienet.hu>)
+	  Szakacsits)
 
 2.1.2 - Important bug fixes aleviating the hangs in statfs.
 
@@ -884,7 +894,7 @@ ToDo/Notes:
 
 	- Add handling for initialized_size != data_size in compressed files.
 	- Reduce function local stack usage from 0x3d4 bytes to just noise in
-	  fs/ntfs/upcase.c. (Randy Dunlap <rdunlap@xenotime.net>)
+	  fs/ntfs/upcase.c. (Randy Dunlap)
 	- Remove compiler warnings for newer gcc.
 	- Pages are no longer kmapped by mm/filemap.c::generic_file_write()
 	  around calls to ->{prepare,commit}_write.  Adapt NTFS appropriately
@@ -1201,11 +1211,11 @@ ToDo/Notes:
 	  the kernel. We probably want a kernel generic init_address_space()
 	  function...
 	- Drop BKL from ntfs_readdir() after consultation with Al Viro. The
-	  only caller of ->readdir() is vfs_readdir() which holds i_sem during
-	  the call, and i_sem is sufficient protection against changes in the
-	  directory inode (including ->i_size).
+	  only caller of ->readdir() is vfs_readdir() which holds i_mutex
+	  during the call, and i_mutex is sufficient protection against changes
+	  in the directory inode (including ->i_size).
 	- Use generic_file_llseek() for directories (as opposed to
-	  default_llseek()) as this downs i_sem instead of the BKL which is
+	  default_llseek()) as this downs i_mutex instead of the BKL which is
 	  what we now need for exclusion against ->f_pos changes considering we
 	  no longer take the BKL in ntfs_readdir().
 
diff --git a/fs/ntfs/inode.c b/fs/ntfs/inode.c
index ea1bd3f..55263b7 100644
--- a/fs/ntfs/inode.c
+++ b/fs/ntfs/inode.c
@@ -677,13 +677,28 @@ static int ntfs_read_locked_inode(struct
 		ntfs_debug("Attribute list found in inode 0x%lx.", vi->i_ino);
 		NInoSetAttrList(ni);
 		a = ctx->attr;
-		if (a->flags & ATTR_IS_ENCRYPTED ||
-				a->flags & ATTR_COMPRESSION_MASK ||
-				a->flags & ATTR_IS_SPARSE) {
+		if (a->flags & ATTR_COMPRESSION_MASK) {
 			ntfs_error(vi->i_sb, "Attribute list attribute is "
-					"compressed/encrypted/sparse.");
+					"compressed.");
 			goto unm_err_out;
 		}
+		if (a->flags & ATTR_IS_ENCRYPTED ||
+				a->flags & ATTR_IS_SPARSE) {
+			if (a->non_resident) {
+				ntfs_error(vi->i_sb, "Non-resident attribute "
+						"list attribute is encrypted/"
+						"sparse.");
+				goto unm_err_out;
+			}
+			ntfs_warning(vi->i_sb, "Resident attribute list "
+					"attribute in inode 0x%lx is marked "
+					"encrypted/sparse which is not true.  "
+					"However, Windows allows this and "
+					"chkdsk does not detect or correct it "
+					"so we will just ignore the invalid "
+					"flags and pretend they are not set.",
+					vi->i_ino);
+		}
 		/* Now allocate memory for the attribute list. */
 		ni->attr_list_size = (u32)ntfs_attr_size(a);
 		ni->attr_list = ntfs_malloc_nofs(ni->attr_list_size);
@@ -1809,19 +1824,33 @@ int ntfs_read_inode_mount(struct inode *
 	} else /* if (!err) */ {
 		ATTR_LIST_ENTRY *al_entry, *next_al_entry;
 		u8 *al_end;
+		static const char *es = "  Not allowed.  $MFT is corrupt.  "
+				"You should run chkdsk.";
 
 		ntfs_debug("Attribute list attribute found in $MFT.");
 		NInoSetAttrList(ni);
 		a = ctx->attr;
-		if (a->flags & ATTR_IS_ENCRYPTED ||
-				a->flags & ATTR_COMPRESSION_MASK ||
-				a->flags & ATTR_IS_SPARSE) {
+		if (a->flags & ATTR_COMPRESSION_MASK) {
 			ntfs_error(sb, "Attribute list attribute is "
-					"compressed/encrypted/sparse. Not "
-					"allowed. $MFT is corrupt. You should "
-					"run chkdsk.");
+					"compressed.%s", es);
 			goto put_err_out;
 		}
+		if (a->flags & ATTR_IS_ENCRYPTED ||
+				a->flags & ATTR_IS_SPARSE) {
+			if (a->non_resident) {
+				ntfs_error(sb, "Non-resident attribute list "
+						"attribute is encrypted/"
+						"sparse.%s", es);
+				goto put_err_out;
+			}
+			ntfs_warning(sb, "Resident attribute list attribute "
+					"in $MFT system file is marked "
+					"encrypted/sparse which is not true.  "
+					"However, Windows allows this and "
+					"chkdsk does not detect or correct it "
+					"so we will just ignore the invalid "
+					"flags and pretend they are not set.");
+		}
 		/* Now allocate memory for the attribute list. */
 		ni->attr_list_size = (u32)ntfs_attr_size(a);
 		ni->attr_list = ntfs_malloc_nofs(ni->attr_list_size);
diff --git a/fs/ntfs/layout.h b/fs/ntfs/layout.h
index f5678d5..bb408d4 100644
--- a/fs/ntfs/layout.h
+++ b/fs/ntfs/layout.h
@@ -838,15 +838,19 @@ enum {
 	   F_A_DEVICE, F_A_DIRECTORY, F_A_SPARSE_FILE, F_A_REPARSE_POINT,
 	   F_A_COMPRESSED, and F_A_ENCRYPTED and preserves the rest.  This mask
 	   is used to to obtain all flags that are valid for setting. */
-
 	/*
-	 * The following flags are only present in the FILE_NAME attribute (in
+	 * The following flag is only present in the FILE_NAME attribute (in
 	 * the field file_attributes).
 	 */
 	FILE_ATTR_DUP_FILE_NAME_INDEX_PRESENT	= const_cpu_to_le32(0x10000000),
 	/* Note, this is a copy of the corresponding bit from the mft record,
 	   telling us whether this is a directory or not, i.e. whether it has
 	   an index root attribute or not. */
+	/*
+	 * The following flag is present both in the STANDARD_INFORMATION
+	 * attribute and in the FILE_NAME attribute (in the field
+	 * file_attributes).
+	 */
 	FILE_ATTR_DUP_VIEW_INDEX_PRESENT	= const_cpu_to_le32(0x20000000),
 	/* Note, this is a copy of the corresponding bit from the mft record,
 	   telling us whether this file has a view index present (eg. object id
@@ -1071,9 +1075,15 @@ typedef struct {
 					   modified. */
 /* 20*/	sle64 last_access_time;		/* Time this mft record was last
 					   accessed. */
-/* 28*/	sle64 allocated_size;		/* Byte size of allocated space for the
-					   data attribute. NOTE: Is a multiple
-					   of the cluster size. */
+/* 28*/	sle64 allocated_size;		/* Byte size of on-disk allocated space
+					   for the data attribute.  So for
+					   normal $DATA, this is the
+					   allocated_size from the unnamed
+					   $DATA attribute and for compressed
+					   and/or sparse $DATA, this is the
+					   compressed_size from the unnamed
+					   $DATA attribute.  NOTE: This is a
+					   multiple of the cluster size. */
 /* 30*/	sle64 data_size;		/* Byte size of actual data in data
 					   attribute. */
 /* 38*/	FILE_ATTR_FLAGS file_attributes;	/* Flags describing the file. */
@@ -1904,12 +1914,13 @@ enum {
 	VOLUME_DELETE_USN_UNDERWAY	= const_cpu_to_le16(0x0010),
 	VOLUME_REPAIR_OBJECT_ID		= const_cpu_to_le16(0x0020),
 
+	VOLUME_CHKDSK_UNDERWAY		= const_cpu_to_le16(0x4000),
 	VOLUME_MODIFIED_BY_CHKDSK	= const_cpu_to_le16(0x8000),
 
-	VOLUME_FLAGS_MASK		= const_cpu_to_le16(0x803f),
+	VOLUME_FLAGS_MASK		= const_cpu_to_le16(0xc03f),
 
 	/* To make our life easier when checking if we must mount read-only. */
-	VOLUME_MUST_MOUNT_RO_MASK	= const_cpu_to_le16(0x8027),
+	VOLUME_MUST_MOUNT_RO_MASK	= const_cpu_to_le16(0xc027),
 } __attribute__ ((__packed__));
 
 typedef le16 VOLUME_FLAGS;
-- 
1.2.3.g9821

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/
