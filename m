Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318030AbSFSV4z>; Wed, 19 Jun 2002 17:56:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318033AbSFSV4y>; Wed, 19 Jun 2002 17:56:54 -0400
Received: from mole.bio.cam.ac.uk ([131.111.36.9]:49469 "EHLO
	mole.bio.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S318030AbSFSV4p>; Wed, 19 Jun 2002 17:56:45 -0400
Subject: [2.5BK-PATCH] NTFS 2.0.10: Limit inodes to 2^32 - 1
To: torvalds@transmeta.com (Linus Torvalds)
Date: Wed, 19 Jun 2002 22:56:45 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (Linux Kernel)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17KnRV-0000lL-00@storm.christs.cam.ac.uk>
From: Anton Altaparmakov <aia21@cantab.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please do a

	bk pull http://linux-ntfs.bkbits.net/ntfs-tng-2.5

Thanks! - The below included patch is incremental to the previous one. 
Patch is quite big but is just a pretty trivial move from "s64" to
"unsigned long" for ntfs inode numbers in line with the statement found
on the Microsoft web site that there are a maximum of 2^32 - 1 inodes
allowed on an NTFS volume.

Both previous and this patch have been tested and work fine for me.

If anyone is interested, the URL is:

	http://www.microsoft.com/hwdev/tech/storage/ntfs-preinstallP.asp

This update is thanks to the air controller strikes in France which caused
my flight to be cancelled today. /-;

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/, http://www-stu.christs.cam.ac.uk/~aia21/

This will update the following files:

 Documentation/filesystems/ntfs.txt |    4 +
 fs/ntfs/ChangeLog                  |   11 +++
 fs/ntfs/Makefile                   |    2 
 fs/ntfs/attrib.c                   |    3 
 fs/ntfs/compress.c                 |    4 -
 fs/ntfs/dir.c                      |  128 +++++++++++++++----------------------
 fs/ntfs/dir.h                      |    4 -
 fs/ntfs/inode.c                    |   31 +++++---
 fs/ntfs/inode.h                    |    2 
 fs/ntfs/layout.h                   |    4 -
 fs/ntfs/mft.c                      |   16 +---
 fs/ntfs/namei.c                    |   14 +---
 fs/ntfs/super.c                    |   14 +---
 fs/ntfs/volume.h                   |    4 -
 14 files changed, 115 insertions(+), 126 deletions(-)

through these ChangeSets:

<aia21@cantab.net> (02/06/19 1.550)
   NTFS: 2.0.10 - There can only be 2^32 - 1 inodes on an NTFS volume.
   - Add check at mount time to verify that the number of inodes on the
     volume does not exceed 2^32 - 1, which is the maximum allowed for
     NTFS according to Microsoft.
   - Change mft_no member of ntfs_inode structure to be unsigned long.
     Update all users. This makes ntfs_inode->mft_no just a copy of struct
     inode->i_ino. But we can't just always use struct inode->i_ino and
     remove mft_no because extent inodes do not have an attached struct
     inode.


diff -Nru a/Documentation/filesystems/ntfs.txt b/Documentation/filesystems/ntfs.txt
--- a/Documentation/filesystems/ntfs.txt	Wed Jun 19 22:14:11 2002
+++ b/Documentation/filesystems/ntfs.txt	Wed Jun 19 22:14:11 2002
@@ -247,6 +247,10 @@
 
 Note, a technical ChangeLog aimed at kernel hackers is in fs/ntfs/ChangeLog.
 
+2.0.10:
+	- Microsoft says that the maximum number of inodes is 2^32 - 1. Update
+	  the driver accordingly to only use 32-bits to store inode numbers on
+	  32-bit architectures. This improves the speed of the driver a little.
 2.0.9:
 	- Change decompression engine to use a single buffer. This should not
 	  affect performance except perhaps on the most heavy i/o on SMP
diff -Nru a/fs/ntfs/ChangeLog b/fs/ntfs/ChangeLog
--- a/fs/ntfs/ChangeLog	Wed Jun 19 22:14:11 2002
+++ b/fs/ntfs/ChangeLog	Wed Jun 19 22:14:11 2002
@@ -23,6 +23,17 @@
 	  them cleaner and make code reuse easier.
 	- Want to use dummy inodes for address space i/o.
 
+2.0.10 - There can only be 2^32 - 1 inodes on an NTFS volume.
+
+	- Add check at mount time to verify that the number of inodes on the
+	  volume does not exceed 2^32 - 1, which is the maximum allowed for
+	  NTFS according to Microsoft.
+	- Change mft_no member of ntfs_inode structure to be unsigned long.
+	  Update all users. This makes ntfs_inode->mft_no just a copy of struct
+	  inode->i_ino. But we can't just always use struct inode->i_ino and
+	  remove mft_no because extent inodes do not have an attached struct
+	  inode.
+
 2.0.9 - Decompression engine now uses a single buffer and other cleanups.
 
 	- Change decompression engine to use a single buffer protected by a
diff -Nru a/fs/ntfs/Makefile b/fs/ntfs/Makefile
--- a/fs/ntfs/Makefile	Wed Jun 19 22:14:11 2002
+++ b/fs/ntfs/Makefile	Wed Jun 19 22:14:11 2002
@@ -5,7 +5,7 @@
 ntfs-objs := aops.o attrib.o compress.o debug.o dir.o file.o inode.o mft.o \
 	     mst.o namei.o super.o sysctl.o time.o unistr.o upcase.o
 
-EXTRA_CFLAGS = -DNTFS_VERSION=\"2.0.9\"
+EXTRA_CFLAGS = -DNTFS_VERSION=\"2.0.10\"
 
 ifeq ($(CONFIG_NTFS_DEBUG),y)
 EXTRA_CFLAGS += -DDEBUG
diff -Nru a/fs/ntfs/attrib.c b/fs/ntfs/attrib.c
--- a/fs/ntfs/attrib.c	Wed Jun 19 22:14:11 2002
+++ b/fs/ntfs/attrib.c	Wed Jun 19 22:14:11 2002
@@ -1243,8 +1243,7 @@
 
 	ni = ctx->ntfs_ino;
 	base_ni = ctx->base_ntfs_ino;
-	ntfs_debug("Entering for inode 0x%Lx, type 0x%x.",
-			(unsigned long long)ni->mft_no, type);
+	ntfs_debug("Entering for inode 0x%lx, type 0x%x.", ni->mft_no, type);
 	if (!base_ni) {
 		/* First call happens with the base mft record. */
 		base_ni = ctx->base_ntfs_ino = ctx->ntfs_ino;
diff -Nru a/fs/ntfs/compress.c b/fs/ntfs/compress.c
--- a/fs/ntfs/compress.c	Wed Jun 19 22:14:11 2002
+++ b/fs/ntfs/compress.c	Wed Jun 19 22:14:11 2002
@@ -748,9 +748,9 @@
 		 */
 		if (err) {
 			ntfs_error(vol->sb, "ntfs_decompress() failed in inode "
-					"0x%Lx with error code %i. Skipping "
+					"0x%lx with error code %i. Skipping "
 					"this compression block.\n",
-					(unsigned long long)ni->mft_no, -err);
+					ni->mft_no, -err);
 			/* Release the unfinished pages. */
 			for (; prev_cur_page < cur_page; prev_cur_page++) {
 				page = pages[prev_cur_page];
diff -Nru a/fs/ntfs/dir.c b/fs/ntfs/dir.c
--- a/fs/ntfs/dir.c	Wed Jun 19 22:14:11 2002
+++ b/fs/ntfs/dir.c	Wed Jun 19 22:14:11 2002
@@ -64,7 +64,7 @@
  * work but we don't care for how quickly one can access them. This also fixes
  * the dcache aliasing issues.
  */
-u64 ntfs_lookup_inode_by_name(ntfs_inode *dir_ni, const uchar_t *uname,
+MFT_REF ntfs_lookup_inode_by_name(ntfs_inode *dir_ni, const uchar_t *uname,
 		const int uname_len, ntfs_name **res)
 {
 	ntfs_volume *vol = dir_ni->vol;
@@ -98,8 +98,7 @@
 	if (!lookup_attr(AT_INDEX_ROOT, I30, 4, CASE_SENSITIVE, 0, NULL, 0,
 			ctx)) {
 		ntfs_error(sb, "Index root attribute missing in directory "
-				"inode 0x%Lx.",
-				(unsigned long long)dir_ni->mft_no);
+				"inode 0x%lx.", dir_ni->mft_no);
 		err = -EIO;
 		goto put_unm_err_out;
 	}
@@ -278,9 +277,8 @@
 	/* Consistency check: Verify that an index allocation exists. */
 	if (!NInoIndexAllocPresent(dir_ni)) {
 		ntfs_error(sb, "No index allocation attribute but index entry "
-				"requires one. Directory inode 0x%Lx is "
-				"corrupt or driver bug.",
-				(unsigned long long)dir_ni->mft_no);
+				"requires one. Directory inode 0x%lx is "
+				"corrupt or driver bug.", dir_ni->mft_no);
 		err = -EIO;
 		goto put_unm_err_out;
 	}
@@ -308,30 +306,27 @@
 	/* Bounds checks. */
 	if ((u8*)ia < kaddr || (u8*)ia > kaddr + PAGE_CACHE_SIZE) {
 		ntfs_error(sb, "Out of bounds check failed. Corrupt directory "
-				"inode 0x%Lx or driver bug.",
-				(unsigned long long)dir_ni->mft_no);
+				"inode 0x%lx or driver bug.", dir_ni->mft_no);
 		err = -EIO;
 		goto unm_unm_err_out;
 	}
 	if (sle64_to_cpu(ia->index_block_vcn) != vcn) {
 		ntfs_error(sb, "Actual VCN (0x%Lx) of index buffer is "
 				"different from expected VCN (0x%Lx). "
-				"Directory inode 0x%Lx is corrupt or driver "
+				"Directory inode 0x%lx is corrupt or driver "
 				"bug.",
 				(long long)sle64_to_cpu(ia->index_block_vcn),
-				(long long)vcn,
-				(unsigned long long)dir_ni->mft_no);
+				(long long)vcn, dir_ni->mft_no);
 		err = -EIO;
 		goto unm_unm_err_out;
 	}
 	if (le32_to_cpu(ia->index.allocated_size) + 0x18 !=
 			dir_ni->_IDM(index_block_size)) {
 		ntfs_error(sb, "Index buffer (VCN 0x%Lx) of directory inode "
-				"0x%Lx has a size (%u) differing from the "
+				"0x%lx has a size (%u) differing from the "
 				"directory specified size (%u). Directory "
 				"inode is corrupt or driver bug.",
-				(long long)vcn,
-				(unsigned long long)dir_ni->mft_no,
+				(long long)vcn, dir_ni->mft_no,
 				le32_to_cpu(ia->index.allocated_size) + 0x18,
 				dir_ni->_IDM(index_block_size));
 		err = -EIO;
@@ -340,19 +335,17 @@
 	index_end = (u8*)ia + dir_ni->_IDM(index_block_size);
 	if (index_end > kaddr + PAGE_CACHE_SIZE) {
 		ntfs_error(sb, "Index buffer (VCN 0x%Lx) of directory inode "
-				"0x%Lx crosses page boundary. Impossible! "
+				"0x%lx crosses page boundary. Impossible! "
 				"Cannot access! This is probably a bug in the "
-				"driver.", (long long)vcn,
-				(unsigned long long)dir_ni->mft_no);
+				"driver.", (long long)vcn, dir_ni->mft_no);
 		err = -EIO;
 		goto unm_unm_err_out;
 	}
 	index_end = (u8*)&ia->index + le32_to_cpu(ia->index.index_length);
 	if (index_end > (u8*)ia + dir_ni->_IDM(index_block_size)) {
 		ntfs_error(sb, "Size of index buffer (VCN 0x%Lx) of directory "
-				"inode 0x%Lx exceeds maximum size.",
-				(long long)vcn,
-				(unsigned long long)dir_ni->mft_no);
+				"inode 0x%lx exceeds maximum size.",
+				(long long)vcn, dir_ni->mft_no);
 		err = -EIO;
 		goto unm_unm_err_out;
 	}
@@ -371,8 +364,8 @@
 				(u8*)ie + le16_to_cpu(ie->_IEH(key_length)) >
 				index_end) {
 			ntfs_error(sb, "Index entry out of bounds in "
-					"directory inode 0x%Lx.",
-					(unsigned long long)dir_ni->mft_no);
+					"directory inode 0x%lx.",
+					dir_ni->mft_no);
 			err = -EIO;
 			goto unm_unm_err_out;
 		}
@@ -523,8 +516,8 @@
 	if (ie->_IEH(flags) & INDEX_ENTRY_NODE) {
 		if ((ia->index.flags & NODE_MASK) == LEAF_NODE) {
 			ntfs_error(sb, "Index entry with child node found in "
-					"a leaf node in directory inode 0x%Lx.",
-					(unsigned long long)dir_ni->mft_no);
+					"a leaf node in directory inode 0x%lx.",
+					dir_ni->mft_no);
 			err = -EIO;
 			goto unm_unm_err_out;
 		}
@@ -544,7 +537,7 @@
 			goto descend_into_child_node;
 		}
 		ntfs_error(sb, "Negative child node vcn in directory inode "
-				"0x%Lx.", (unsigned long long)dir_ni->mft_no);
+				"0x%lx.", dir_ni->mft_no);
 		err = -EIO;
 		goto unm_unm_err_out;
 	}
@@ -643,8 +636,7 @@
 	if (!lookup_attr(AT_INDEX_ROOT, I30, 4, CASE_SENSITIVE, 0, NULL, 0,
 			ctx)) {
 		ntfs_error(sb, "Index root attribute missing in directory "
-				"inode 0x%Lx.",
-				(unsigned long long)dir_ni->mft_no);
+				"inode 0x%lx.", dir_ni->mft_no);
 		err = -EIO;
 		goto put_unm_err_out;
 	}
@@ -750,9 +742,8 @@
 	/* Consistency check: Verify that an index allocation exists. */
 	if (!NInoIndexAllocPresent(dir_ni)) {
 		ntfs_error(sb, "No index allocation attribute but index entry "
-				"requires one. Directory inode 0x%Lx is "
-				"corrupt or driver bug.",
-				(unsigned long long)dir_ni->mft_no);
+				"requires one. Directory inode 0x%lx is "
+				"corrupt or driver bug.", dir_ni->mft_no);
 		err = -EIO;
 		goto put_unm_err_out;
 	}
@@ -780,30 +771,27 @@
 	/* Bounds checks. */
 	if ((u8*)ia < kaddr || (u8*)ia > kaddr + PAGE_CACHE_SIZE) {
 		ntfs_error(sb, "Out of bounds check failed. Corrupt directory "
-				"inode 0x%Lx or driver bug.",
-				(unsigned long long)dir_ni->mft_no);
+				"inode 0x%lx or driver bug.", dir_ni->mft_no);
 		err = -EIO;
 		goto unm_unm_err_out;
 	}
 	if (sle64_to_cpu(ia->index_block_vcn) != vcn) {
 		ntfs_error(sb, "Actual VCN (0x%Lx) of index buffer is "
 				"different from expected VCN (0x%Lx). "
-				"Directory inode 0x%Lx is corrupt or driver "
+				"Directory inode 0x%lx is corrupt or driver "
 				"bug.",
 				(long long)sle64_to_cpu(ia->index_block_vcn),
-				(long long)vcn,
-				(unsigned long long)dir_ni->mft_no);
+				(long long)vcn, dir_ni->mft_no);
 		err = -EIO;
 		goto unm_unm_err_out;
 	}
 	if (le32_to_cpu(ia->index.allocated_size) + 0x18 !=
 			dir_ni->_IDM(index_block_size)) {
 		ntfs_error(sb, "Index buffer (VCN 0x%Lx) of directory inode "
-				"0x%Lx has a size (%u) differing from the "
+				"0x%lx has a size (%u) differing from the "
 				"directory specified size (%u). Directory "
 				"inode is corrupt or driver bug.",
-				(long long)vcn,
-				(unsigned long long)dir_ni->mft_no,
+				(long long)vcn, dir_ni->mft_no,
 				le32_to_cpu(ia->index.allocated_size) + 0x18,
 				dir_ni->_IDM(index_block_size));
 		err = -EIO;
@@ -812,19 +800,17 @@
 	index_end = (u8*)ia + dir_ni->_IDM(index_block_size);
 	if (index_end > kaddr + PAGE_CACHE_SIZE) {
 		ntfs_error(sb, "Index buffer (VCN 0x%Lx) of directory inode "
-				"0x%Lx crosses page boundary. Impossible! "
+				"0x%lx crosses page boundary. Impossible! "
 				"Cannot access! This is probably a bug in the "
-				"driver.", (long long)vcn,
-				(unsigned long long)dir_ni->mft_no);
+				"driver.", (long long)vcn, dir_ni->mft_no);
 		err = -EIO;
 		goto unm_unm_err_out;
 	}
 	index_end = (u8*)&ia->index + le32_to_cpu(ia->index.index_length);
 	if (index_end > (u8*)ia + dir_ni->_IDM(index_block_size)) {
 		ntfs_error(sb, "Size of index buffer (VCN 0x%Lx) of directory "
-				"inode 0x%Lx exceeds maximum size.",
-				(long long)vcn,
-				(unsigned long long)dir_ni->mft_no);
+				"inode 0x%lx exceeds maximum size.",
+				(long long)vcn, dir_ni->mft_no);
 		err = -EIO;
 		goto unm_unm_err_out;
 	}
@@ -843,8 +829,8 @@
 				(u8*)ie + le16_to_cpu(ie->_IEH(key_length)) >
 				index_end) {
 			ntfs_error(sb, "Index entry out of bounds in "
-					"directory inode 0x%Lx.",
-					(unsigned long long)dir_ni->mft_no);
+					"directory inode 0x%lx.",
+					dir_ni->mft_no);
 			err = -EIO;
 			goto unm_unm_err_out;
 		}
@@ -928,8 +914,8 @@
 	if (ie->_IEH(flags) & INDEX_ENTRY_NODE) {
 		if ((ia->index.flags & NODE_MASK) == LEAF_NODE) {
 			ntfs_error(sb, "Index entry with child node found in "
-					"a leaf node in directory inode 0x%Lx.",
-					(unsigned long long)dir_ni->mft_no);
+					"a leaf node in directory inode 0x%lx.",
+					dir_ni->mft_no);
 			err = -EIO;
 			goto unm_unm_err_out;
 		}
@@ -949,7 +935,7 @@
 			goto descend_into_child_node;
 		}
 		ntfs_error(sb, "Negative child node vcn in directory inode "
-				"0x%Lx.", (unsigned long long)dir_ni->mft_no);
+				"0x%lx.", dir_ni->mft_no);
 		err = -EIO;
 		goto unm_unm_err_out;
 	}
@@ -1044,12 +1030,11 @@
 	else
 		dt_type = DT_REG;
 	ntfs_debug("Calling filldir for %s with len %i, f_pos 0x%Lx, inode "
-			"0x%Lx, DT_%s.", name, name_len, filp->f_pos,
-			(unsigned long long)MREF_LE(ie->_IIF(indexed_file)),
+			"0x%lx, DT_%s.", name, name_len, filp->f_pos,
+			MREF_LE(ie->_IIF(indexed_file)),
 			dt_type == DT_DIR ? "DIR" : "REG");
 	return filldir(dirent, name, name_len, filp->f_pos,
-			(unsigned long)MREF_LE(ie->_IIF(indexed_file)),
-			dt_type);
+			MREF_LE(ie->_IIF(indexed_file)), dt_type);
 }
 
 /*
@@ -1083,8 +1068,8 @@
 	u8 *kaddr, *bmp, *index_end;
 	attr_search_context *ctx;
 
-	ntfs_debug("Entering for inode 0x%Lx, f_pos 0x%Lx.",
-			(unsigned long long)ndir->mft_no, filp->f_pos);
+	ntfs_debug("Entering for inode 0x%lx, f_pos 0x%Lx.",
+			vdir->i_ino, filp->f_pos);
 	rc = err = 0;
 	/* Are we at end of dir yet? */
 	if (filp->f_pos >= vdir->i_size + vol->mft_record_size)
@@ -1092,8 +1077,7 @@
 	/* Emulate . and .. for all directories. */
 	if (!filp->f_pos) {
 		ntfs_debug("Calling filldir for . with len 1, f_pos 0x0, "
-				"inode 0x%Lx, DT_DIR.",
-				(unsigned long long)ndir->mft_no);
+				"inode 0x%lx, DT_DIR.", vdir->i_ino);
 		rc = filldir(dirent, ".", 1, filp->f_pos, vdir->i_ino, DT_DIR);
 		if (rc)
 			goto done;
@@ -1141,8 +1125,7 @@
 	if (!lookup_attr(AT_INDEX_ROOT, I30, 4, CASE_SENSITIVE, 0, NULL, 0,
 			ctx)) {
 		ntfs_error(sb, "Index root attribute missing in directory "
-				"inode 0x%Lx.",
-				(unsigned long long)ndir->mft_no);
+				"inode 0x%lx.", vdir->i_ino);
 		err = -EIO;
 		goto kf_unm_err_out;
 	}
@@ -1201,8 +1184,7 @@
 		if (!lookup_attr(AT_BITMAP, I30, 4, CASE_SENSITIVE, 0, NULL, 0,
 				ctx)) {
 			ntfs_error(sb, "Index bitmap attribute missing in "
-					"directory inode 0x%Lx.",
-					(unsigned long long)ndir->mft_no);
+					"directory inode 0x%lx.", vdir->i_ino);
 			err = -EIO;
 			goto kf_unm_err_out;
 		}
@@ -1251,8 +1233,7 @@
 	/* Bounds checks. */
 	if ((u8*)ia < kaddr || (u8*)ia > kaddr + PAGE_CACHE_SIZE) {
 		ntfs_error(sb, "Out of bounds check failed. Corrupt directory "
-				"inode 0x%Lx or driver bug.",
-				(unsigned long long)ndir->mft_no);
+				"inode 0x%lx or driver bug.", vdir->i_ino);
 		err = -EIO;
 		goto unm_dir_err_out;
 	}
@@ -1261,23 +1242,22 @@
 			ndir->_IDM(index_vcn_size_bits)) {
 		ntfs_error(sb, "Actual VCN (0x%Lx) of index buffer is "
 				"different from expected VCN (0x%Lx). "
-				"Directory inode 0x%Lx is corrupt or driver "
+				"Directory inode 0x%lx is corrupt or driver "
 				"bug. ",
 				(long long)sle64_to_cpu(ia->index_block_vcn),
 				(long long)ia_pos >>
-				ndir->_IDM(index_vcn_size_bits),
-				(unsigned long long)ndir->mft_no);
+				ndir->_IDM(index_vcn_size_bits), vdir->i_ino);
 		err = -EIO;
 		goto unm_dir_err_out;
 	}
 	if (le32_to_cpu(ia->index.allocated_size) + 0x18 !=
 			ndir->_IDM(index_block_size)) {
 		ntfs_error(sb, "Index buffer (VCN 0x%Lx) of directory inode "
-				"0x%Lx has a size (%u) differing from the "
+				"0x%lx has a size (%u) differing from the "
 				"directory specified size (%u). Directory "
 				"inode is corrupt or driver bug.",
-				(long long)ia_pos >> ndir->_IDM(index_vcn_size_bits),
-				(unsigned long long)ndir->mft_no,
+				(long long)ia_pos >>
+				ndir->_IDM(index_vcn_size_bits), vdir->i_ino,
 				le32_to_cpu(ia->index.allocated_size) + 0x18,
 				ndir->_IDM(index_block_size));
 		err = -EIO;
@@ -1286,11 +1266,10 @@
 	index_end = (u8*)ia + ndir->_IDM(index_block_size);
 	if (index_end > kaddr + PAGE_CACHE_SIZE) {
 		ntfs_error(sb, "Index buffer (VCN 0x%Lx) of directory inode "
-				"0x%Lx crosses page boundary. Impossible! "
+				"0x%lx crosses page boundary. Impossible! "
 				"Cannot access! This is probably a bug in the "
 				"driver.", (long long)ia_pos >>
-				ndir->_IDM(index_vcn_size_bits),
-				(unsigned long long)ndir->mft_no);
+				ndir->_IDM(index_vcn_size_bits), vdir->i_ino);
 		err = -EIO;
 		goto unm_dir_err_out;
 	}
@@ -1298,10 +1277,9 @@
 	index_end = (u8*)&ia->index + le32_to_cpu(ia->index.index_length);
 	if (index_end > (u8*)ia + ndir->_IDM(index_block_size)) {
 		ntfs_error(sb, "Size of index buffer (VCN 0x%Lx) of directory "
-				"inode 0x%Lx exceeds maximum size.",
+				"inode 0x%lx exceeds maximum size.",
 				(long long)ia_pos >>
-				ndir->_IDM(index_vcn_size_bits),
-				(unsigned long long)ndir->mft_no);
+				ndir->_IDM(index_vcn_size_bits), vdir->i_ino);
 		err = -EIO;
 		goto unm_dir_err_out;
 	}
diff -Nru a/fs/ntfs/dir.h b/fs/ntfs/dir.h
--- a/fs/ntfs/dir.h	Wed Jun 19 22:14:11 2002
+++ b/fs/ntfs/dir.h	Wed Jun 19 22:14:11 2002
@@ -40,8 +40,8 @@
 /* The little endian Unicode string $I30 as a global constant. */
 extern const uchar_t I30[5];
 
-extern u64 ntfs_lookup_inode_by_name(ntfs_inode *dir_ni, const uchar_t *uname,
-		const int uname_len, ntfs_name **res);
+extern MFT_REF ntfs_lookup_inode_by_name(ntfs_inode *dir_ni,
+		const uchar_t *uname, const int uname_len, ntfs_name **res);
 
 #endif /* _LINUX_NTFS_FS_DIR_H */
 
diff -Nru a/fs/ntfs/inode.c b/fs/ntfs/inode.c
--- a/fs/ntfs/inode.c	Wed Jun 19 22:14:11 2002
+++ b/fs/ntfs/inode.c	Wed Jun 19 22:14:11 2002
@@ -357,8 +357,7 @@
 	if (lookup_attr(AT_ATTRIBUTE_LIST, NULL, 0, 0, 0, NULL, 0, ctx)) {
 		if (vi->i_ino == FILE_MFT)
 			goto skip_attr_list_load;
-		ntfs_debug("Attribute list found in inode %li (0x%lx).",
-				vi->i_ino, vi->i_ino);
+		ntfs_debug("Attribute list found in inode 0x%lx.", vi->i_ino);
 		ni->state |= 1 << NI_AttrList;
 		if (ctx->attr->flags & ATTR_IS_ENCRYPTED ||
 				ctx->attr->flags & ATTR_COMPRESSION_MASK) {
@@ -805,8 +804,8 @@
 ec_unm_err_out:
 	unmap_mft_record(READ, ni);
 err_out:
-	ntfs_error(vi->i_sb, "Failed with error code %i. Marking inode "
-			"%li (0x%lx) as bad.", -err, vi->i_ino, vi->i_ino);
+	ntfs_error(vi->i_sb, "Failed with error code %i. Marking inode 0x%lx "
+			"as bad.", -err, vi->i_ino);
 	make_bad_inode(vi);
 	return;
 }
@@ -857,7 +856,7 @@
 	ntfs_init_big_inode(vi);
 	ni = NTFS_I(vi);
 	if (vi->i_ino != FILE_MFT) {
-		ntfs_error(sb, "Called for inode %ld but only inode %d "
+		ntfs_error(sb, "Called for inode 0x%lx but only inode %d "
 				"allowed.", vi->i_ino, FILE_MFT);
 		goto err_out;
 	}
@@ -1034,7 +1033,7 @@
 			if (al_entry->lowest_vcn)
 				goto em_put_err_out;
 			/* First entry has to be in the base mft record. */
-			if (MREF_LE(al_entry->mft_reference) != ni->mft_no) {
+			if (MREF_LE(al_entry->mft_reference) != vi->i_ino) {
 				/* MFT references do not match, logic fails. */
 				ntfs_error(sb, "BUG: The first $DATA extent "
 						"of $MFT is not in the base "
@@ -1096,6 +1095,8 @@
 
 		/* Are we in the first extent? */
 		if (!next_vcn) {
+			u64 ll;
+
 			if (attr->_ANR(lowest_vcn)) {
 				ntfs_error(sb, "First extent of $DATA "
 						"attribute has non zero "
@@ -1113,8 +1114,16 @@
 			ni->allocated_size = sle64_to_cpu(
 					attr->_ANR(allocated_size));
 			/* Set the number of mft records. */
-			vol->_VMM(nr_mft_records) = vi->i_size >>
-					vol->mft_record_size_bits;
+			ll = vi->i_size >> vol->mft_record_size_bits;
+			/*
+			 * Verify the number of mft records does not exceed
+			 * 2^32 - 1.
+			 */
+			if (ll >= (1ULL << 32)) {
+				ntfs_error(sb, "$MFT is too big! Aborting.");
+				goto put_err_out;
+			}
+			vol->_VMM(nr_mft_records) = ll;
 			/*
 			 * We have got the first extent of the run_list for
 			 * $MFT which means it is now relatively safe to call
@@ -1255,8 +1264,7 @@
  */
 int ntfs_commit_inode(ntfs_inode *ni)
 {
-	ntfs_debug("Entering for inode 0x%Lx.",
-			(unsigned long long)ni->mft_no);
+	ntfs_debug("Entering for inode 0x%lx.", ni->mft_no);
 	NInoClearDirty(ni);
 	return 0;
 }
@@ -1265,8 +1273,7 @@
 {
 	int err;
 
-	ntfs_debug("Entering for inode 0x%Lx.",
-			(unsigned long long)ni->mft_no);
+	ntfs_debug("Entering for inode 0x%lx.", ni->mft_no);
 	if (NInoDirty(ni)) {
 		err = ntfs_commit_inode(ni);
 		if (err) {
diff -Nru a/fs/ntfs/inode.h b/fs/ntfs/inode.h
--- a/fs/ntfs/inode.h	Wed Jun 19 22:14:11 2002
+++ b/fs/ntfs/inode.h	Wed Jun 19 22:14:11 2002
@@ -39,7 +39,7 @@
 	s64 allocated_size;	/* Copy from $DATA/$INDEX_ALLOCATION. */
 	unsigned long state;	/* NTFS specific flags describing this inode.
 				   See fs/ntfs/ntfs.h:ntfs_inode_state_bits. */
-	u64 mft_no;		/* Mft record number (inode number). */
+	unsigned long mft_no;	/* Number of the mft record / inode. */
 	u16 seq_no;		/* Sequence number of the mft record. */
 	atomic_t count;		/* Inode reference count for book keeping. */
 	ntfs_volume *vol;	/* Pointer to the ntfs volume of this inode. */
diff -Nru a/fs/ntfs/layout.h b/fs/ntfs/layout.h
--- a/fs/ntfs/layout.h	Wed Jun 19 22:14:11 2002
+++ b/fs/ntfs/layout.h	Wed Jun 19 22:14:11 2002
@@ -278,9 +278,9 @@
 
 typedef u64 MFT_REF;
 
-#define MREF(x)		((u64)((x) & MFT_REF_MASK_CPU))
+#define MREF(x)		((unsigned long)((x) & MFT_REF_MASK_CPU))
 #define MSEQNO(x)	((u16)(((x) >> 48) & 0xffff))
-#define MREF_LE(x)	((u64)(le64_to_cpu(x) & MFT_REF_MASK_CPU))
+#define MREF_LE(x)	((unsigned long)(le64_to_cpu(x) & MFT_REF_MASK_CPU))
 #define MSEQNO_LE(x)	((u16)((le64_to_cpu(x) >> 48) & 0xffff))
 
 #define IS_ERR_MREF(x)	(((x) & 0x0000800000000000ULL) ? 1 : 0)
diff -Nru a/fs/ntfs/mft.c b/fs/ntfs/mft.c
--- a/fs/ntfs/mft.c	Wed Jun 19 22:14:11 2002
+++ b/fs/ntfs/mft.c	Wed Jun 19 22:14:11 2002
@@ -240,8 +240,7 @@
  *
  * The mft record is now ours and we return a pointer to it. You need to check
  * the returned pointer with IS_ERR() and if that is true, PTR_ERR() will return
- * the error code. The following error codes are defined:
- * 	TODO: Fill in the possible error codes.
+ * the error code.
  *
  * NOTE: Caller is responsible for setting the mft record dirty before calling
  * unmap_mft_record(). This is obviously only necessary if the caller really
@@ -254,8 +253,7 @@
 {
 	MFT_RECORD *m;
 
-	ntfs_debug("Entering for i_ino 0x%Lx, mapping for %s.",
-			(unsigned long long)ni->mft_no,
+	ntfs_debug("Entering for mft_no 0x%lx, mapping for %s.", ni->mft_no,
 			rw == READ ? "READ" : "WRITE");
 
 	/* Make sure the ntfs inode doesn't go away. */
@@ -318,8 +316,7 @@
 
 	BUG_ON(!atomic_read(&ni->mft_count) || !page);
 
-	ntfs_debug("Entering for mft_no 0x%Lx, unmapping from %s.",
-			(unsigned long long)ni->mft_no,
+	ntfs_debug("Entering for mft_no 0x%lx, unmapping from %s.", ni->mft_no,
 			rw == READ ? "READ" : "WRITE");
 
 	/* Only release the actual page mapping if this is the last one. */
@@ -369,13 +366,12 @@
 	ntfs_inode *ni = NULL;
 	ntfs_inode **extent_nis = NULL;
 	int i;
-	u64 mft_no = MREF_LE(mref);
+	unsigned long mft_no = MREF_LE(mref);
 	u16 seq_no = MSEQNO_LE(mref);
 	BOOL destroy_ni = FALSE;
 
-	ntfs_debug("Mapping extent mft record 0x%Lx (base mft record 0x%Lx).",
-			(unsigned long long)mft_no,
-			(unsigned long long)base_ni->mft_no);
+	ntfs_debug("Mapping extent mft record 0x%lx (base mft record 0x%lx).",
+			mft_no, base_ni->mft_no);
 	/* Make sure the base ntfs inode doesn't go away. */
 	atomic_inc(&base_ni->count);
 	/*
diff -Nru a/fs/ntfs/namei.c b/fs/ntfs/namei.c
--- a/fs/ntfs/namei.c	Wed Jun 19 22:14:11 2002
+++ b/fs/ntfs/namei.c	Wed Jun 19 22:14:11 2002
@@ -93,7 +93,7 @@
 	struct inode *dent_inode;
 	uchar_t *uname;
 	ntfs_name *name = NULL;
-	u64 mref;
+	MFT_REF mref;
 	unsigned long dent_ino;
 	int uname_len;
 
@@ -110,7 +110,7 @@
 			&name);
 	kmem_cache_free(ntfs_name_cache, uname);
 	if (!IS_ERR_MREF(mref)) {
-		dent_ino = (unsigned long)MREF(mref);
+		dent_ino = MREF(mref);
 		ntfs_debug("Found inode 0x%lx. Calling iget.", dent_ino);
 		dent_inode = iget(vol->sb, dent_ino);
 		if (dent_inode) {
@@ -130,17 +130,15 @@
 				goto handle_name;
 			}
 			ntfs_error(vol->sb, "Found stale reference to inode "
-					"0x%Lx (reference sequence number = "
+					"0x%lx (reference sequence number = "
 					"0x%x, inode sequence number = 0x%x, "
 					"returning -EACCES. Run chkdsk.",
-					(unsigned long long)MREF(mref),
-					MSEQNO(mref),
+					dent_ino, MSEQNO(mref),
 					NTFS_I(dent_inode)->seq_no);
 			iput(dent_inode);
 		} else
-			ntfs_error(vol->sb, "iget(0x%Lx) failed, returning "
-					"-EACCES.",
-					(unsigned long long)MREF(mref));
+			ntfs_error(vol->sb, "iget(0x%lx) failed, returning "
+					"-EACCES.", dent_ino);
 		if (name)
 			kfree(name);
 		return ERR_PTR(-EACCES);
diff -Nru a/fs/ntfs/super.c b/fs/ntfs/super.c
--- a/fs/ntfs/super.c	Wed Jun 19 22:14:11 2002
+++ b/fs/ntfs/super.c	Wed Jun 19 22:14:11 2002
@@ -1236,14 +1236,13 @@
  * Errors are ignored and we just return the number of free inodes we have
  * found. This means we return an underestimate on error.
  */
-s64 get_nr_free_mft_records(ntfs_volume *vol)
+unsigned long get_nr_free_mft_records(ntfs_volume *vol)
 {
 	struct address_space *mapping;
 	filler_t *readpage;
 	struct page *page;
-	unsigned long index, max_index;
+	unsigned long index, max_index, nr_free = 0;
 	unsigned int max_size, i;
-	s64 nr_free = 0LL;
 	u32 *b;
 
 	ntfs_debug("Entering.");
@@ -1285,7 +1284,7 @@
 		b = (u32*)kmap(page);
 		/* For each 4 bytes, add up the number of zero bits. */
 	  	for (i = 0; i < max_size; i++)
-			nr_free += (s64)(32 - hweight32(b[i]));
+			nr_free += 32 - hweight32(b[i]);
 		kunmap(page);
 		page_cache_release(page);
 	}
@@ -1300,7 +1299,7 @@
 		if (max_size) {
 			/* Compensate for out of bounds zero bits. */
 			if ((i = vol->_VMM(nr_mft_records) & 31))
-				nr_free -= (s64)(32 - i);
+				nr_free -= 32 - i;
 			ntfs_debug("Handling partial page, max_size = 0x%x",
 					max_size);
 			goto handle_partial_page;
@@ -1358,10 +1357,7 @@
 	/* Total file nodes in file system (at this moment in time). */
 	sfs->f_files  = vol->mft_ino->i_size >> vol->mft_record_size_bits;
 	/* Free file nodes in fs (based on current total count). */
-	size	      = get_nr_free_mft_records(vol);
-	if (size < 0LL)
-		size = 0LL;
-	sfs->f_ffree = size;
+	sfs->f_ffree = get_nr_free_mft_records(vol);
 	/*
 	 * File system id. This is extremely *nix flavour dependent and even
 	 * within Linux itself all fs do their own thing. I interpret this to
diff -Nru a/fs/ntfs/volume.h b/fs/ntfs/volume.h
--- a/fs/ntfs/volume.h	Wed Jun 19 22:14:11 2002
+++ b/fs/ntfs/volume.h	Wed Jun 19 22:14:11 2002
@@ -105,8 +105,8 @@
 	struct rw_semaphore mftbmp_lock; /* Lock for serializing accesses to the
 					    mft record bitmap ($MFT/$BITMAP). */
 	union {
-		s64 nr_mft_records;	/* Number of records in the mft. */
-		s64 nr_mft_bits;	/* Number of bits in mft bitmap. */
+		unsigned long nr_mft_records; /* Number of mft records. */
+		unsigned long nr_mft_bits; /* Number of bits in mft bitmap. */
 	} SN(vmm);
 	struct address_space mftbmp_mapping; /* Page cache for $MFT/$BITMAP. */
 	run_list mftbmp_rl;		/* Run list for $MFT/$BITMAP. */

