Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315214AbSF3PCM>; Sun, 30 Jun 2002 11:02:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315218AbSF3PCL>; Sun, 30 Jun 2002 11:02:11 -0400
Received: from mole.bio.cam.ac.uk ([131.111.36.9]:29202 "EHLO
	mole.bio.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S315214AbSF3PCE>; Sun, 30 Jun 2002 11:02:04 -0400
Subject: [BK-PATCH-2.5] NTFS: 2.0.11 - Initial preparations for fake inode based attribute i/o.
To: torvalds@transmeta.com (Linus Torvalds)
Date: Sun, 30 Jun 2002 16:04:27 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (Linux Kernel)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17OgFX-0003uv-00@storm.christs.cam.ac.uk>
From: Anton Altaparmakov <aia21@cantab.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please do a

	bk pull http://linux-ntfs.bkbits.net/ntfs-tng-2.5

Thanks!

Note the above repository also contains NTFS 2.0.12 and 2.0.13 which I am
also sending as incremental patches in a minute... Patches are all tested
and work fine in my testing.

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/, http://www-stu.christs.cam.ac.uk/~aia21/

This will update the following files:

 Documentation/filesystems/ntfs.txt |    3 
 fs/ntfs/ChangeLog                  |   34 ++++++++-
 fs/ntfs/Makefile                   |    2 
 fs/ntfs/dir.c                      |    2 
 fs/ntfs/dir.h                      |    2 
 fs/ntfs/inode.c                    |  133 +++++++++++++++++++++++++------------
 fs/ntfs/inode.h                    |  129 +++++++++++++++++++++++++++++++----
 fs/ntfs/mft.c                      |   12 +--
 fs/ntfs/ntfs.h                     |   35 ---------
 fs/ntfs/super.c                    |    9 +-
 10 files changed, 252 insertions(+), 109 deletions(-)

through these ChangeSets:

<aia21@cantab.net> (02/06/25 1.603.1.1)
   NTFS: 2.0.11 - Initial preparations for fake inode based attribute i/o.
   - Move definition of ntfs_inode_state_bits to fs/ntfs/inode.h and
     do some macro magic (adapted from include/linux/buffer_head.h) to
     expand all the helper functions NInoFoo(), NInoSetFoo(), and
     NInoClearFoo().
   - Add new flag to ntfs_inode_state_bits: NI_Sparse.
   - Add new fields to ntfs_inode structure to allow use of fake inodes
     for attribute i/o: type, name, name_len. Also add new state bits:
     NI_Attr, which, if set, indicates the inode is a fake inode, and
     NI_MstProtected, which, if set, indicates the attribute uses multi
     sector transfer protection, i.e. fixups need to be applied after
     reads and before/after writes.
   - Rename fs/ntfs/inode.c::ntfs_{new,clear,destroy}_inode() to
     ntfs_{new,clear,destroy}_extent_inode() and update callers.
   - Use ntfs_clear_extent_inode() in fs/ntfs/inode.c::__ntfs_clear_inode()
     instead of ntfs_destroy_extent_inode().
   - Cleanup memory deallocations in {__,}ntfs_clear_{,big_}inode().
   - Make all operations on ntfs inode state bits use the NIno* functions.
   - Set up the new ntfs inode fields and state bits in
     fs/ntfs/inode.c::ntfs_read_inode() and add appropriate cleanup of
     allocated memory to __ntfs_clear_inode().
   - Cleanup ntfs_inode structure a bit for better ordering of elements
     w.r.t. their size to allow better packing of the structure in memory.


diff -Nru a/Documentation/filesystems/ntfs.txt b/Documentation/filesystems/ntfs.txt
--- a/Documentation/filesystems/ntfs.txt	Sun Jun 30 13:16:02 2002
+++ b/Documentation/filesystems/ntfs.txt	Sun Jun 30 13:16:02 2002
@@ -247,6 +247,9 @@
 
 Note, a technical ChangeLog aimed at kernel hackers is in fs/ntfs/ChangeLog.
 
+2.0.11:
+	- Internal updates and cleanups introducing the first step towards
+	  fake inode based attribute i/o.
 2.0.10:
 	- Microsoft says that the maximum number of inodes is 2^32 - 1. Update
 	  the driver accordingly to only use 32-bits to store inode numbers on
diff -Nru a/fs/ntfs/ChangeLog b/fs/ntfs/ChangeLog
--- a/fs/ntfs/ChangeLog	Sun Jun 30 13:16:02 2002
+++ b/fs/ntfs/ChangeLog	Sun Jun 30 13:16:02 2002
@@ -21,7 +21,34 @@
 	  several copies of almost identicall functions and the functions are
 	  quite big. Modularising them a bit, e.g. a-la get_block(), will make
 	  them cleaner and make code reuse easier.
-	- Want to use dummy inodes for address space i/o.
+	- Enable NFS exporting of NTFS.
+	- Use iget5_locked() and friends instead of conventional iget().
+	- Use fake inodes for address space i/o.
+
+2.0.11 - Initial preparations for fake inode based attribute i/o.
+
+	- Move definition of ntfs_inode_state_bits to fs/ntfs/inode.h and
+	  do some macro magic (adapted from include/linux/buffer_head.h) to
+	  expand all the helper functions NInoFoo(), NInoSetFoo(), and
+	  NInoClearFoo().
+	- Add new flag to ntfs_inode_state_bits: NI_Sparse.
+	- Add new fields to ntfs_inode structure to allow use of fake inodes
+	  for attribute i/o: type, name, name_len. Also add new state bits:
+	  NI_Attr, which, if set, indicates the inode is a fake inode, and
+	  NI_MstProtected, which, if set, indicates the attribute uses multi
+	  sector transfer protection, i.e. fixups need to be applied after
+	  reads and before/after writes.
+	- Rename fs/ntfs/inode.c::ntfs_{new,clear,destroy}_inode() to
+	  ntfs_{new,clear,destroy}_extent_inode() and update callers.
+	- Use ntfs_clear_extent_inode() in fs/ntfs/inode.c::__ntfs_clear_inode()
+	  instead of ntfs_destroy_extent_inode().
+	- Cleanup memory deallocations in {__,}ntfs_clear_{,big_}inode().
+	- Make all operations on ntfs inode state bits use the NIno* functions.
+	- Set up the new ntfs inode fields and state bits in
+	  fs/ntfs/inode.c::ntfs_read_inode() and add appropriate cleanup of
+	  allocated memory to __ntfs_clear_inode().
+	- Cleanup ntfs_inode structure a bit for better ordering of elements
+	  w.r.t. their size to allow better packing of the structure in memory.
 
 2.0.10 - There can only be 2^32 - 1 inodes on an NTFS volume.
 
@@ -38,7 +65,10 @@
 
 	- Change decompression engine to use a single buffer protected by a
 	  spin lock instead of per-CPU buffers. (Rusty Russell)
-	- Switch to using the new KM_BIO_SRC_IRQ for atomic kmaps. (Andrew
+	- Do not update cb_pos when handling a partial final page during
+	  decompression of a sparse compression block, as the value is later
+	  reset without being read/used. (Rusty Russell)
+	- Switch to using the new KM_BIO_SRC_IRQ for atomic kmap()s. (Andrew
 	  Morton)
 	- Change buffer size in ntfs_readdir()/ntfs_filldir() to use
 	  NLS_MAX_CHARSET_SIZE which makes the buffers almost 1kiB each but
diff -Nru a/fs/ntfs/Makefile b/fs/ntfs/Makefile
--- a/fs/ntfs/Makefile	Sun Jun 30 13:16:02 2002
+++ b/fs/ntfs/Makefile	Sun Jun 30 13:16:02 2002
@@ -5,7 +5,7 @@
 ntfs-objs := aops.o attrib.o compress.o debug.o dir.o file.o inode.o mft.o \
 	     mst.o namei.o super.o sysctl.o time.o unistr.o upcase.o
 
-EXTRA_CFLAGS = -DNTFS_VERSION=\"2.0.10\"
+EXTRA_CFLAGS = -DNTFS_VERSION=\"2.0.11\"
 
 ifeq ($(CONFIG_NTFS_DEBUG),y)
 EXTRA_CFLAGS += -DDEBUG
diff -Nru a/fs/ntfs/dir.c b/fs/ntfs/dir.c
--- a/fs/ntfs/dir.c	Sun Jun 30 13:16:02 2002
+++ b/fs/ntfs/dir.c	Sun Jun 30 13:16:02 2002
@@ -27,7 +27,7 @@
 /**
  * The little endian Unicode string $I30 as a global constant.
  */
-const uchar_t I30[5] = { const_cpu_to_le16('$'), const_cpu_to_le16('I'),
+uchar_t I30[5] = { const_cpu_to_le16('$'), const_cpu_to_le16('I'),
 		const_cpu_to_le16('3'),	const_cpu_to_le16('0'),
 		const_cpu_to_le16(0) };
 
diff -Nru a/fs/ntfs/dir.h b/fs/ntfs/dir.h
--- a/fs/ntfs/dir.h	Sun Jun 30 13:16:02 2002
+++ b/fs/ntfs/dir.h	Sun Jun 30 13:16:02 2002
@@ -38,7 +38,7 @@
 } __attribute__ ((__packed__)) ntfs_name;
 
 /* The little endian Unicode string $I30 as a global constant. */
-extern const uchar_t I30[5];
+extern uchar_t I30[5];
 
 extern MFT_REF ntfs_lookup_inode_by_name(ntfs_inode *dir_ni,
 		const uchar_t *uname, const int uname_len, ntfs_name **res);
diff -Nru a/fs/ntfs/inode.c b/fs/ntfs/inode.c
--- a/fs/ntfs/inode.c	Sun Jun 30 13:16:02 2002
+++ b/fs/ntfs/inode.c	Sun Jun 30 13:16:02 2002
@@ -49,7 +49,7 @@
 	kmem_cache_free(ntfs_big_inode_cache, NTFS_I(inode));
 }
 
-ntfs_inode *ntfs_alloc_inode(void)
+ntfs_inode *ntfs_alloc_extent_inode(void)
 {
 	ntfs_inode *ni = (ntfs_inode *)kmem_cache_alloc(ntfs_inode_cache,
 			SLAB_NOFS);
@@ -59,7 +59,7 @@
 	return ni;
 }
 
-void ntfs_destroy_inode(ntfs_inode *ni)
+void ntfs_destroy_extent_inode(ntfs_inode *ni)
 {
 	ntfs_debug("Entering.");
 	BUG_ON(atomic_read(&ni->mft_count) || !atomic_dec_and_test(&ni->count));
@@ -102,9 +102,9 @@
 	return;
 }
 
-ntfs_inode *ntfs_new_inode(struct super_block *sb)
+ntfs_inode *ntfs_new_extent_inode(struct super_block *sb)
 {
-	ntfs_inode *ni = ntfs_alloc_inode();
+	ntfs_inode *ni = ntfs_alloc_extent_inode();
 
 	ntfs_debug("Entering.");
 	if (ni)
@@ -239,7 +239,8 @@
 
 	/*
 	 * Initialize the ntfs specific part of @vi special casing
-	 * FILE_MFT which we need to do at mount time.
+	 * FILE_MFT which we need to do at mount time. This also sets
+	 * ni->mft_no to vi->i_ino.
 	 */
 	if (vi->i_ino != FILE_MFT)
 		ntfs_init_big_inode(vi);
@@ -358,13 +359,14 @@
 		if (vi->i_ino == FILE_MFT)
 			goto skip_attr_list_load;
 		ntfs_debug("Attribute list found in inode 0x%lx.", vi->i_ino);
-		ni->state |= 1 << NI_AttrList;
+		NInoSetAttrList(ni);
 		if (ctx->attr->flags & ATTR_IS_ENCRYPTED ||
-				ctx->attr->flags & ATTR_COMPRESSION_MASK) {
+				ctx->attr->flags & ATTR_COMPRESSION_MASK ||
+				ctx->attr->flags & ATTR_IS_SPARSE) {
 			ntfs_error(vi->i_sb, "Attribute list attribute is "
-					"compressed/encrypted. Not allowed. "
-					"Corrupt inode. You should run "
-					"chkdsk.");
+					"compressed/encrypted/sparse. Not "
+					"allowed. Corrupt inode. You should "
+					"run chkdsk.");
 			goto put_unm_err_out;
 		}
 		/* Now allocate memory for the attribute list. */
@@ -377,7 +379,7 @@
 			goto ec_put_unm_err_out;
 		}
 		if (ctx->attr->non_resident) {
-			ni->state |= 1 << NI_AttrListNonResident;
+			NInoSetAttrListNonResident(ni);
 			if (ctx->attr->_ANR(lowest_vcn)) {
 				ntfs_error(vi->i_sb, "Attribute list has non "
 						"zero lowest_vcn. Inode is "
@@ -459,7 +461,7 @@
 		 * encrypted.
 		 */
 		if (ctx->attr->flags & ATTR_COMPRESSION_MASK)
-			ni->state |= 1 << NI_Compressed;
+			NInoSetCompressed(ni);
 		if (ctx->attr->flags & ATTR_IS_ENCRYPTED) {
 			if (ctx->attr->flags & ATTR_COMPRESSION_MASK) {
 				ntfs_error(vi->i_sb, "Found encrypted and "
@@ -467,8 +469,10 @@
 						"allowed.");
 				goto put_unm_err_out;
 			}
-			ni->state |= 1 << NI_Encrypted;
+			NInoSetEncrypted(ni);
 		}
+		if (ctx->attr->flags & ATTR_IS_SPARSE)
+			NInoSetSparse(ni);
 		ir = (INDEX_ROOT*)((char*)ctx->attr +
 				le16_to_cpu(ctx->attr->_ARA(value_offset)));
 		ir_end = (char*)ir + le32_to_cpu(ctx->attr->_ARA(value_length));
@@ -530,12 +534,19 @@
 			ni->_IDM(index_vcn_size) = vol->sector_size;
 			ni->_IDM(index_vcn_size_bits) = vol->sector_size_bits;
 		}
+
+		/* Setup the index allocation attribute, even if not present. */
+		NInoSetMstProtected(ni);
+		ni->type = AT_INDEX_ALLOCATION;
+		ni->name = I30;
+		ni->name_len = 4;
+
 		if (!(ir->index.flags & LARGE_INDEX)) {
 			/* No index allocation. */
 			vi->i_size = ni->initialized_size = 0;
 			goto skip_large_dir_stuff;
 		} /* LARGE_INDEX: Index allocation present. Setup state. */
-		ni->state |= 1 << NI_NonResident;
+		NInoSetIndexAllocPresent(ni);
 		/* Find index allocation attribute. */
 		reinit_attr_search_ctx(ctx);
 		if (!lookup_attr(AT_INDEX_ALLOCATION, I30, 4, CASE_SENSITIVE,
@@ -555,6 +566,11 @@
 					"is encrypted.");
 			goto put_unm_err_out;
 		}
+		if (ctx->attr->flags & ATTR_IS_SPARSE) {
+			ntfs_error(vi->i_sb, "$INDEX_ALLOCATION attribute "
+					"is sparse.");
+			goto put_unm_err_out;
+		}
 		if (ctx->attr->flags & ATTR_COMPRESSION_MASK) {
 			ntfs_error(vi->i_sb, "$INDEX_ALLOCATION attribute "
 					"is compressed.");
@@ -581,13 +597,13 @@
 			goto put_unm_err_out;
 		}
 		if (ctx->attr->flags & (ATTR_COMPRESSION_MASK |
-				ATTR_IS_ENCRYPTED)) {
+				ATTR_IS_ENCRYPTED | ATTR_IS_SPARSE)) {
 			ntfs_error(vi->i_sb, "$BITMAP attribute is compressed "
-					"and/or encrypted.");
+					"and/or encrypted and/or sparse.");
 			goto put_unm_err_out;
 		}
 		if (ctx->attr->non_resident) {
-			ni->state |= 1 << NI_BmpNonResident;
+			NInoSetBmpNonResident(ni);
 			if (ctx->attr->_ANR(lowest_vcn)) {
 				ntfs_error(vi->i_sb, "First extent of $BITMAP "
 						"attribute has non zero "
@@ -647,6 +663,12 @@
 	} else {
 		/* It is a file: find first extent of unnamed data attribute. */
 		reinit_attr_search_ctx(ctx);
+
+		/* Setup the data attribute, even if not present. */
+		ni->type = AT_DATA;
+		ni->name = NULL;
+		ni->name_len = 0;
+
 		if (!lookup_attr(AT_DATA, NULL, 0, 0, 0, NULL, 0, ctx)) {
 			vi->i_size = ni->initialized_size =
 					ni->allocated_size = 0LL;
@@ -675,9 +697,9 @@
 		}
 		/* Setup the state. */
 		if (ctx->attr->non_resident) {
-			ni->state |= 1 << NI_NonResident;
+			NInoSetNonResident(ni);
 			if (ctx->attr->flags & ATTR_COMPRESSION_MASK) {
-				ni->state |= 1 << NI_Compressed;
+				NInoSetCompressed(ni);
 				if (vol->cluster_size > 4096) {
 					ntfs_error(vi->i_sb, "Found "
 						"compressed data but "
@@ -707,8 +729,9 @@
 					goto ec_put_unm_err_out;
 				}
 				ni->_ICF(compression_block_size) = 1U << (
-					       ctx->attr->_ANR(compression_unit)
-						+ vol->cluster_size_bits);
+						ctx->attr->_ANR(
+						compression_unit) +
+						vol->cluster_size_bits);
 				ni->_ICF(compression_block_size_bits) = ffs(
 					ni->_ICF(compression_block_size)) - 1;
 			}
@@ -718,8 +741,10 @@
 							"and compressed data.");
 					goto put_unm_err_out;
 				}
-				ni->state |= 1 << NI_Encrypted;
+				NInoSetEncrypted(ni);
 			}
+			if (ctx->attr->flags & ATTR_IS_SPARSE)
+				NInoSetSparse(ni);
 			if (ctx->attr->_ANR(lowest_vcn)) {
 				ntfs_error(vi->i_sb, "First extent of $DATA "
 						"attribute has non zero "
@@ -861,6 +886,13 @@
 		goto err_out;
 	}
 
+	/* Setup the data attribute. It is special as it is mst protected. */
+	NInoSetNonResident(ni);
+	NInoSetMstProtected(ni);
+	ni->type = AT_DATA;
+	ni->name = NULL;
+	ni->name_len = 0;
+
 	/*
 	 * This sets up our little cheat allowing us to reuse the async io
 	 * completion handler for directories.
@@ -930,13 +962,14 @@
 		u8 *al_end;
 
 		ntfs_debug("Attribute list attribute found in $MFT.");
-		ni->state |= 1 << NI_AttrList;
+		NInoSetAttrList(ni);
 		if (ctx->attr->flags & ATTR_IS_ENCRYPTED ||
-				ctx->attr->flags & ATTR_COMPRESSION_MASK) {
+				ctx->attr->flags & ATTR_COMPRESSION_MASK ||
+				ctx->attr->flags & ATTR_IS_SPARSE) {
 			ntfs_error(sb, "Attribute list attribute is "
-					"compressed/encrypted. Not allowed. "
-					"$MFT is corrupt. You should run "
-					"chkdsk.");
+					"compressed/encrypted/sparse. Not "
+					"allowed. $MFT is corrupt. You should "
+					"run chkdsk.");
 			goto put_err_out;
 		}
 		/* Now allocate memory for the attribute list. */
@@ -948,7 +981,7 @@
 			goto put_err_out;
 		}
 		if (ctx->attr->non_resident) {
-			ni->state |= 1 << NI_AttrListNonResident;
+			NInoSetAttrListNonResident(ni);
 			if (ctx->attr->_ANR(lowest_vcn)) {
 				ntfs_error(sb, "Attribute list has non zero "
 						"lowest_vcn. $MFT is corrupt. "
@@ -1071,11 +1104,13 @@
 		}
 		/* $MFT must be uncompressed and unencrypted. */
 		if (attr->flags & ATTR_COMPRESSION_MASK ||
-				attr->flags & ATTR_IS_ENCRYPTED) {
-			ntfs_error(sb, "$MFT must be uncompressed and "
-					"unencrypted but a compressed/"
-					"encrypted extent was found. "
-					"$MFT is corrupt. Run chkdsk.");
+				attr->flags & ATTR_IS_ENCRYPTED ||
+				attr->flags & ATTR_IS_SPARSE) {
+			ntfs_error(sb, "$MFT must be uncompressed, "
+					"non-sparse, and unencrypted but a "
+					"compressed/sparse/encrypted extent "
+					"was found. $MFT is corrupt. Run "
+					"chkdsk.");
 			goto put_err_out;
 		}
 		/*
@@ -1296,29 +1331,42 @@
 
 		// FIXME: Handle dirty case for each extent inode!
 		for (i = 0; i < ni->nr_extents; i++)
-			ntfs_destroy_inode(ni->_INE(extent_ntfs_inos)[i]);
+			ntfs_clear_extent_inode(ni->_INE(extent_ntfs_inos)[i]);
 		kfree(ni->_INE(extent_ntfs_inos));
 	}
 	/* Free all alocated memory. */
 	down_write(&ni->run_list.lock);
-	ntfs_free(ni->run_list.rl);
-	ni->run_list.rl = NULL;
+	if (ni->run_list.rl) {
+		ntfs_free(ni->run_list.rl);
+		ni->run_list.rl = NULL;
+	}
 	up_write(&ni->run_list.lock);
 
-	ntfs_free(ni->attr_list);
+	if (ni->attr_list) {
+		ntfs_free(ni->attr_list);
+		ni->attr_list = NULL;
+	}
 
 	down_write(&ni->attr_list_rl.lock);
-	ntfs_free(ni->attr_list_rl.rl);
-	ni->attr_list_rl.rl = NULL;
+	if (ni->attr_list_rl.rl) {
+		ntfs_free(ni->attr_list_rl.rl);
+		ni->attr_list_rl.rl = NULL;
+	}
 	up_write(&ni->attr_list_rl.lock);
+
+	if (ni->name_len && ni->name != I30) {
+		/* Catch bugs... */
+		BUG_ON(!ni->name);
+		kfree(ni->name);
+	}
 }
 
-void ntfs_clear_inode(ntfs_inode *ni)
+void ntfs_clear_extent_inode(ntfs_inode *ni)
 {
 	__ntfs_clear_inode(ni);
 
 	/* Bye, bye... */
-	ntfs_destroy_inode(ni);
+	ntfs_destroy_extent_inode(ni);
 }
 
 /**
@@ -1339,7 +1387,8 @@
 
 	if (S_ISDIR(vi->i_mode)) {
 		down_write(&ni->_IDM(bmp_rl).lock);
-		ntfs_free(ni->_IDM(bmp_rl).rl);
+		if (ni->_IDM(bmp_rl).rl)
+			ntfs_free(ni->_IDM(bmp_rl).rl);
 		up_write(&ni->_IDM(bmp_rl).lock);
 	}
 	return;
diff -Nru a/fs/ntfs/inode.h b/fs/ntfs/inode.h
--- a/fs/ntfs/inode.h	Sun Jun 30 13:16:02 2002
+++ b/fs/ntfs/inode.h	Sun Jun 30 13:16:02 2002
@@ -3,7 +3,7 @@
  *	     the Linux-NTFS project.
  *
  * Copyright (c) 2001,2002 Anton Altaparmakov.
- * Copyright (C) 2002 Richard Russon.
+ * Copyright (c) 2002 Richard Russon.
  *
  * This program/include file is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License as published
@@ -26,6 +26,7 @@
 
 #include <linux/seq_file.h>
 
+#include "layout.h"
 #include "volume.h"
 
 typedef struct _ntfs_inode ntfs_inode;
@@ -38,21 +39,39 @@
 	s64 initialized_size;	/* Copy from $DATA/$INDEX_ALLOCATION. */
 	s64 allocated_size;	/* Copy from $DATA/$INDEX_ALLOCATION. */
 	unsigned long state;	/* NTFS specific flags describing this inode.
-				   See fs/ntfs/ntfs.h:ntfs_inode_state_bits. */
+				   See ntfs_inode_state_bits below. */
 	unsigned long mft_no;	/* Number of the mft record / inode. */
 	u16 seq_no;		/* Sequence number of the mft record. */
 	atomic_t count;		/* Inode reference count for book keeping. */
 	ntfs_volume *vol;	/* Pointer to the ntfs volume of this inode. */
+	/*
+	 * If NInoAttr() is true, the below fields describe the attribute which
+	 * this fake inode belongs to. The actual inode of this attribute is
+	 * pointed to by base_ntfs_ino and nr_extents is always set to -1 (see
+	 * below). For real inodes, we also set the type (AT_DATA for files and
+	 * AT_INDEX_ALLOCATION for directories), with the name = NULL and
+	 * name_len = 0 for files and name = I30 (global constant) and
+	 * name_len = 4 for directories.
+	 */
+	ATTR_TYPES type;	/* Attribute type of this fake inode. */
+	uchar_t *name;		/* Attribute name of this fake inode. */
+	u32 name_len;		/* Attribute name length of this fake inode. */
 	run_list run_list;	/* If state has the NI_NonResident bit set,
 				   the run list of the unnamed data attribute
 				   (if a file) or of the index allocation
-				   attribute (directory). If run_list.rl is
-				   NULL, the run list has not been read in or
-				   has been unmapped. If NI_NonResident is
-				   clear, the unnamed data attribute is
-				   resident (file) or there is no $I30 index
-				   allocation attribute (directory). In that
-				   case run_list.rl is always NULL.*/
+				   attribute (directory) or of the attribute
+				   described by the fake inode (if NInoAttr()).
+				   If run_list.rl is NULL, the run list has not
+				   been read in yet or has been unmapped. If
+				   NI_NonResident is clear, the attribute is
+				   resident (file and fake inode) or there is
+				   no $I30 index allocation attribute
+				   (small directory). In the latter case
+				   run_list.rl is always NULL.*/
+	/*
+	 * The following fields are only valid for real inodes and extent
+	 * inodes.
+	 */
 	struct rw_semaphore mrec_lock;	/* Lock for serializing access to the
 				   mft record belonging to this inode. */
 	atomic_t mft_count;	/* Mapping reference count for book keeping. */
@@ -74,17 +93,18 @@
 	union {
 		struct { /* It is a directory or $MFT. */
 			u32 index_block_size;	/* Size of an index block. */
-			u8 index_block_size_bits; /* Log2 of the above. */
 			u32 index_vcn_size;	/* Size of a vcn in this
 						   directory index. */
-			u8 index_vcn_size_bits;	/* Log2 of the above. */
 			s64 bmp_size;		/* Size of the $I30 bitmap. */
 			s64 bmp_initialized_size; /* Copy from $I30 bitmap. */
 			s64 bmp_allocated_size;	/* Copy from $I30 bitmap. */
 			run_list bmp_rl;	/* Run list for the $I30 bitmap
 						   if it is non-resident. */
+			u8 index_block_size_bits; /* Log2 of the above. */
+			u8 index_vcn_size_bits;	/* Log2 of the above. */
 		} SN(idm);
-		struct { /* It is a compressed file. */
+		struct { /* It is a compressed file or fake inode. */
+			s64 compressed_size;		/* Copy from $DATA. */
 			u32 compression_block_size;     /* Size of a compression
 						           block (cb). */
 			u8 compression_block_size_bits; /* Log2 of the size of
@@ -92,13 +112,13 @@
 			u8 compression_block_clusters;  /* Number of clusters
 							   per compression
 							   block. */
-			s64 compressed_size;		/* Copy from $DATA. */
 		} SN(icf);
 	} SN(idc);
 	struct semaphore extent_lock;	/* Lock for accessing/modifying the
 					   below . */
 	s32 nr_extents;	/* For a base mft record, the number of attached extent
-			   inodes (0 if none), for extent records this is -1. */
+			   inodes (0 if none), for extent records and for fake
+			   inodes describing an attribute this is -1. */
 	union {		/* This union is only used if nr_extents != 0. */
 		ntfs_inode **extent_ntfs_inos;	/* For nr_extents > 0, array of
 						   the ntfs inodes of the extent
@@ -107,7 +127,9 @@
 						   been loaded. */
 		ntfs_inode *base_ntfs_ino;	/* For nr_extents == -1, the
 						   ntfs inode of the base mft
-						   record. */
+						   record. For fake inodes, the
+						   real (base) inode to which
+						   the attribute belongs. */
 	} SN(ine);
 };
 
@@ -115,6 +137,79 @@
 #define _ICF(X)  SC(idc.icf,X)
 #define _INE(X)  SC(ine,X)
 
+/*
+ * Defined bits for the state field in the ntfs_inode structure.
+ * (f) = files only, (d) = directories only, (a) = attributes/fake inodes only
+ */
+typedef enum {
+	NI_Dirty,		/* 1: Mft record needs to be written to disk. */
+	NI_AttrList,		/* 1: Mft record contains an attribute list. */
+	NI_AttrListNonResident,	/* 1: Attribute list is non-resident. Implies
+				      NI_AttrList is set. */
+
+	NI_Attr,		/* 1: Fake inode for attribute i/o.
+				   0: Real inode or extent inode. */
+
+	NI_MstProtected,	/* 1: Attribute is protected by MST fixups.
+				   0: Attribute is not protected by fixups. */
+	NI_NonResident,		/* 1: Unnamed data attr is non-resident (f).
+				   1: Attribute is non-resident (a). */
+	NI_IndexAllocPresent = NI_NonResident,	/* 1: $I30 index alloc attr is
+						   present (d). */
+	NI_Compressed,		/* 1: Unnamed data attr is compressed (f).
+				   1: Create compressed files by default (d).
+				   1: Attribute is compressed (a). */
+	NI_Encrypted,		/* 1: Unnamed data attr is encrypted (f).
+				   1: Create encrypted files by default (d).
+				   1: Attribute is encrypted (a). */
+	NI_Sparse,		/* 1: Unnamed data attr is sparse (f).
+				   1: Create sparse files by default (d).
+				   1: Attribute is sparse (a). */
+	NI_BmpNonResident,	/* 1: $I30 bitmap attr is non resident (d). */
+} ntfs_inode_state_bits;
+
+/*
+ * NOTE: We should be adding dirty mft records to a list somewhere and they
+ * should be independent of the (ntfs/vfs) inode structure so that an inode can
+ * be removed but the record can be left dirty for syncing later.
+ */
+
+/*
+ * Macro tricks to expand the NInoFoo(), NInoSetFoo(), and NInoClearFoo()
+ * functions.
+ */
+#define NINO_FNS(flag)					\
+static inline int NIno##flag(ntfs_inode *ni)		\
+{							\
+	return test_bit(NI_##flag, &(ni)->state);	\
+}							\
+static inline void NInoSet##flag(ntfs_inode *ni)	\
+{							\
+	set_bit(NI_##flag, &(ni)->state);		\
+}							\
+static inline void NInoClear##flag(ntfs_inode *ni)	\
+{							\
+	clear_bit(NI_##flag, &(ni)->state);		\
+}
+
+/* Emit the ntfs inode bitops functions. */
+NINO_FNS(Dirty)
+NINO_FNS(AttrList)
+NINO_FNS(AttrListNonResident)
+NINO_FNS(Attr)
+NINO_FNS(MstProtected)
+NINO_FNS(NonResident)
+NINO_FNS(IndexAllocPresent)
+NINO_FNS(Compressed)
+NINO_FNS(Encrypted)
+NINO_FNS(Sparse)
+NINO_FNS(BmpNonResident)
+
+/*
+ * The full structure containing a ntfs_inode and a vfs struct inode. Used for
+ * all real and fake inodes but not for extent inodes which lack the vfs struct
+ * inode.
+ */
 typedef struct {
 	ntfs_inode ntfs_inode;
 	struct inode vfs_inode;		/* The vfs inode structure. */
@@ -140,8 +235,8 @@
 extern void ntfs_destroy_big_inode(struct inode *inode);
 extern void ntfs_clear_big_inode(struct inode *vi);
 
-extern ntfs_inode *ntfs_new_inode(struct super_block *sb);
-extern void ntfs_clear_inode(ntfs_inode *ni);
+extern ntfs_inode *ntfs_new_extent_inode(struct super_block *sb);
+extern void ntfs_clear_extent_inode(ntfs_inode *ni);
 
 extern void ntfs_read_inode(struct inode *vi);
 extern void ntfs_read_inode_mount(struct inode *vi);
diff -Nru a/fs/ntfs/mft.c b/fs/ntfs/mft.c
--- a/fs/ntfs/mft.c	Sun Jun 30 13:16:02 2002
+++ b/fs/ntfs/mft.c	Sun Jun 30 13:16:02 2002
@@ -334,9 +334,9 @@
 
 	/*
 	 * If pure ntfs_inode, i.e. no vfs inode attached, we leave it to
-	 * ntfs_clear_inode() in the extent inode case, and to the caller in
-	 * the non-extent, yet pure ntfs inode case, to do the actual tear
-	 * down of all structures and freeing of all allocated memory.
+	 * ntfs_clear_extent_inode() in the extent inode case, and to the
+	 * caller in the non-extent, yet pure ntfs inode case, to do the actual
+	 * tear down of all structures and freeing of all allocated memory.
 	 */
 	return;
 }
@@ -417,7 +417,7 @@
 		return m;
 	}
 	/* Record wasn't there. Get a new ntfs inode and initialize it. */
-	ni = ntfs_new_inode(base_ni->vol->sb);
+	ni = ntfs_new_extent_inode(base_ni->vol->sb);
 	if (!ni) {
 		up(&base_ni->extent_lock);
 		atomic_dec(&base_ni->count);
@@ -433,7 +433,7 @@
 	if (IS_ERR(m)) {
 		up(&base_ni->extent_lock);
 		atomic_dec(&base_ni->count);
-		ntfs_clear_inode(ni);
+		ntfs_clear_extent_inode(ni);
 		goto map_err_out;
 	}
 	/* Verify the sequence number. */
@@ -479,7 +479,7 @@
 	 * release it or we will leak memory.
 	 */
 	if (destroy_ni)
-		ntfs_clear_inode(ni);
+		ntfs_clear_extent_inode(ni);
 	return m;
 }
 
diff -Nru a/fs/ntfs/ntfs.h b/fs/ntfs/ntfs.h
--- a/fs/ntfs/ntfs.h	Sun Jun 30 13:16:02 2002
+++ b/fs/ntfs/ntfs.h	Sun Jun 30 13:16:02 2002
@@ -53,41 +53,6 @@
 	NTFS_MAX_NAME_LEN	= 255,
 } NTFS_CONSTANTS;
 
-/*
- * Defined bits for the state field in the ntfs_inode structure.
- * (f) = files only, (d) = directories only
- */
-typedef enum {
-	NI_Dirty,		/* 1: Mft record needs to be written to disk. */
-	NI_AttrList,		/* 1: Mft record contains an attribute list. */
-	NI_AttrListNonResident,	/* 1: Attribute list is non-resident. Implies
-				      NI_AttrList is set. */
-	NI_NonResident,		/* 1: Unnamed data attr is non-resident (f).
-				   1: $I30 index alloc attr is present (d). */
-	NI_Compressed,		/* 1: Unnamed data attr is compressed (f).
-				   1: Create compressed files by default (d). */
-	NI_Encrypted,		/* 1: Unnamed data attr is encrypted (f).
-				   1: Create encrypted files by default (d). */
-	NI_BmpNonResident,	/* 1: $I30 bitmap attr is non resident (d). */
-} ntfs_inode_state_bits;
-
-/*
- * NOTE: We should be adding dirty mft records to a list somewhere and they
- * should be independent of the (ntfs/vfs) inode structure so that an inode can
- * be removed but the record can be left dirty for syncing later.
- */
-
-#define NInoDirty(n_ino)	  test_bit(NI_Dirty, &(n_ino)->state)
-#define NInoSetDirty(n_ino)	  set_bit(NI_Dirty, &(n_ino)->state)
-#define NInoClearDirty(n_ino)	  clear_bit(NI_Dirty, &(n_ino)->state)
-
-#define NInoAttrList(n_ino)	  test_bit(NI_AttrList, &(n_ino)->state)
-#define NInoNonResident(n_ino)	  test_bit(NI_NonResident, &(n_ino)->state)
-#define NInoIndexAllocPresent(n_ino) test_bit(NI_NonResident, &(n_ino)->state)
-#define NInoCompressed(n_ino)	  test_bit(NI_Compressed, &(n_ino)->state)
-#define NInoEncrypted(n_ino)	  test_bit(NI_Encrypted, &(n_ino)->state)
-#define NInoBmpNonResident(n_ino) test_bit(NI_BmpNonResident, &(n_ino)->state)
-
 /* Global variables. */
 
 /* Slab caches (from super.c). */
diff -Nru a/fs/ntfs/super.c b/fs/ntfs/super.c
--- a/fs/ntfs/super.c	Sun Jun 30 13:16:02 2002
+++ b/fs/ntfs/super.c	Sun Jun 30 13:16:02 2002
@@ -1709,10 +1709,11 @@
 	}
 #undef OGIN
 	/*
-	 * This is needed to get ntfs_clear_inode() called for each inode we
-	 * have ever called iget()/iput() on, otherwise we A) leak resources
-	 * and B) a subsequent mount fails automatically due to iget() never
-	 * calling down into our ntfs_read_inode{_mount}() methods again...
+	 * This is needed to get ntfs_clear_extent_inode() called for each
+	 * inode we have ever called iget()/iput() on, otherwise we A) leak
+	 * resources and B) a subsequent mount fails automatically due to
+	 * iget() never calling down into our ntfs_read_inode{_mount}() methods
+	 * again...
 	 */
 	if (invalidate_inodes(sb)) {
 		ntfs_error(sb, "Busy inodes left. This is most likely a NTFS "

===================================================================

This BitKeeper patch contains the following changesets:
aia21@cantab.net|ChangeSet|20020630121516|51714
aia21@cantab.net|ChangeSet|20020625181324|50149
## Wrapped with gzip_uu ##


begin 664 bkpatch12641
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
K>!GE2?ZIM)$KRX;J.REOB[\VYTZY>Y4LY^_<OC]0)WV]]4^70?$M&D\`````
`
end
