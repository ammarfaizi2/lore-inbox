Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317211AbSGNWzk>; Sun, 14 Jul 2002 18:55:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317215AbSGNWzj>; Sun, 14 Jul 2002 18:55:39 -0400
Received: from maroon.csi.cam.ac.uk ([131.111.8.2]:27823 "EHLO
	maroon.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S317211AbSGNWza>; Sun, 14 Jul 2002 18:55:30 -0400
Subject: [BK-PATCH-2.5] NTFS 2.0.20: Support non-resident directory index bitmaps, fix page leak in readdir
To: torvalds@transmeta.com (Linus Torvalds)
Date: Sun, 14 Jul 2002 23:58:21 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (Linux Kernel)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17TsJq-0001MU-00@storm.christs.cam.ac.uk>
From: Anton Altaparmakov <aia21@cantab.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please do a

	bk pull http://linux-ntfs.bkbits.net/ntfs-tng-2.5

Thanks! - This finishes the move to fake inodes for attribute i/o by
moving the directory index bitmaps to using fake inodes. Also, I found a
page leak which was present in certain cases at the end of directory
handling in ntfs_readdir().

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/, http://www-stu.christs.cam.ac.uk/~aia21/

===================================================================

This will update the following files:

 Documentation/filesystems/ntfs.txt |    6 +
 fs/ntfs/ChangeLog                  |   14 ++
 fs/ntfs/Makefile                   |    2 
 fs/ntfs/dir.c                      |  213 ++++++++++++++++++++-----------------
 fs/ntfs/inode.c                    |  107 ++++++++----------
 fs/ntfs/inode.h                    |   11 -
 fs/ntfs/super.c                    |    6 -
 7 files changed, 189 insertions(+), 170 deletions(-)

through these ChangeSets:

<aia21@cantab.net> (02/07/14 1.623)
   NTFS: 2.0.20 - Support non-resident directory index bitmaps, fix page leak in readdir.
   - Move the directory index bitmap to use an attribute inode instead of
     having special fields for it inside the ntfs inode structure. This
     means that the index bitmaps now use the page cache for i/o, too,
     and also as a side effect we get support for non-resident index
     bitmaps for free.
   - Simplify/cleanup error handling in fs/ntfs/dir.c::ntfs_readdir() and
     fix a page leak that manifested itself in some cases.
   - Add fs/ntfs/inode.c::ntfs_put_inode(), which we need to release the
     index bitmap inode on the final iput().


diff -Nru a/Documentation/filesystems/ntfs.txt b/Documentation/filesystems/ntfs.txt
--- a/Documentation/filesystems/ntfs.txt	Sun Jul 14 23:52:57 2002
+++ b/Documentation/filesystems/ntfs.txt	Sun Jul 14 23:52:57 2002
@@ -247,6 +247,12 @@
 
 Note, a technical ChangeLog aimed at kernel hackers is in fs/ntfs/ChangeLog.
 
+2.0.20:
+	- Support non-resident directory index bitmaps. This means we now cope
+	  with huge directories without problems.
+	- Fix a page leak that manifested itself in some cases when reading
+	  directory contents.
+	- Internal cleanups.
 2.0.19:
 	- Fix race condition and improvements in block i/o interface.
 	- Optimization when reading compressed files.
diff -Nru a/fs/ntfs/ChangeLog b/fs/ntfs/ChangeLog
--- a/fs/ntfs/ChangeLog	Sun Jul 14 23:52:57 2002
+++ b/fs/ntfs/ChangeLog	Sun Jul 14 23:52:57 2002
@@ -7,9 +7,19 @@
 	  truncate the visible i_size? Will the user just get -E2BIG (or
 	  whatever) on open()? Or will (s)he be able to open() but lseek() and
 	  read() will fail when s_maxbytes is reached? -> Investigate this.
-	- Implement/allow non-resident index bitmaps in dir.c::ntfs_readdir()
-	  and then also consider initialized_size w.r.t. the bitmaps, etc.
 	- Enable NFS exporting of NTFS.
+
+2.0.20 - Support non-resident directory index bitmaps, fix page leak in readdir.
+
+	- Move the directory index bitmap to use an attribute inode instead of
+	  having special fields for it inside the ntfs inode structure. This
+	  means that the index bitmaps now use the page cache for i/o, too,
+	  and also as a side effect we get support for non-resident index
+	  bitmaps for free.
+	- Simplify/cleanup error handling in fs/ntfs/dir.c::ntfs_readdir() and
+	  fix a page leak that manifested itself in some cases.
+	- Add fs/ntfs/inode.c::ntfs_put_inode(), which we need to release the
+	  index bitmap inode on the final iput().
 
 2.0.19 - Fix race condition, improvements, and optimizations in i/o interface.
 
diff -Nru a/fs/ntfs/Makefile b/fs/ntfs/Makefile
--- a/fs/ntfs/Makefile	Sun Jul 14 23:52:57 2002
+++ b/fs/ntfs/Makefile	Sun Jul 14 23:52:57 2002
@@ -5,7 +5,7 @@
 ntfs-objs := aops.o attrib.o compress.o debug.o dir.o file.o inode.o mft.o \
 	     mst.o namei.o super.o sysctl.o time.o unistr.o upcase.o
 
-EXTRA_CFLAGS = -DNTFS_VERSION=\"2.0.19\"
+EXTRA_CFLAGS = -DNTFS_VERSION=\"2.0.20\"
 
 ifeq ($(CONFIG_NTFS_DEBUG),y)
 EXTRA_CFLAGS += -DDEBUG
diff -Nru a/fs/ntfs/dir.c b/fs/ntfs/dir.c
--- a/fs/ntfs/dir.c	Sun Jul 14 23:52:57 2002
+++ b/fs/ntfs/dir.c	Sun Jul 14 23:52:57 2002
@@ -2,7 +2,7 @@
  * dir.c - NTFS kernel directory operations. Part of the Linux-NTFS project.
  *
  * Copyright (c) 2001,2002 Anton Altaparmakov.
- * Copyright (C) 2002 Richard Russon.
+ * Copyright (c) 2002 Richard Russon.
  *
  * This program/include file is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License as published
@@ -1052,8 +1052,8 @@
  */
 static int ntfs_readdir(struct file *filp, void *dirent, filldir_t filldir)
 {
-	s64 ia_pos, ia_start, prev_ia_pos;
-	struct inode *vdir = filp->f_dentry->d_inode;
+	s64 ia_pos, ia_start, prev_ia_pos, bmp_pos;
+	struct inode *bmp_vi, *vdir = filp->f_dentry->d_inode;
 	struct super_block *sb = vdir->i_sb;
 	ntfs_inode *ndir = NTFS_I(vdir);
 	ntfs_volume *vol = NTFS_SB(sb);
@@ -1061,10 +1061,10 @@
 	INDEX_ROOT *ir;
 	INDEX_ENTRY *ie;
 	INDEX_ALLOCATION *ia;
-	u8 *name;
-	int rc, err, ir_pos, bmp_pos;
-	struct address_space *ia_mapping;
-	struct page *page;
+	u8 *name = NULL;
+	int rc, err, ir_pos, cur_bmp_pos;
+	struct address_space *ia_mapping, *bmp_mapping;
+	struct page *bmp_page = NULL, *ia_page = NULL;
 	u8 *kaddr, *bmp, *index_end;
 	attr_search_context *ctx;
 
@@ -1093,17 +1093,20 @@
 			goto done;
 		filp->f_pos++;
 	}
+
 	/* Get hold of the mft record for the directory. */
 	m = map_mft_record(READ, ndir);
-	if (IS_ERR(m)) {
+	if (unlikely(IS_ERR(m))) {
 		err = PTR_ERR(m);
+		m = NULL;
+		ctx = NULL;
 		goto err_out;
 	}
 
 	ctx = get_attr_search_ctx(ndir, m);
-	if (!ctx) {
+	if (unlikely(!ctx)) {
 		err = -ENOMEM;
-		goto unm_err_out;
+		goto err_out;
 	}
 
 	/*
@@ -1112,9 +1115,9 @@
 	 */
 	name = (u8*)kmalloc(NTFS_MAX_NAME_LEN * NLS_MAX_CHARSET_SIZE + 1,
 			GFP_NOFS);
-	if (!name) {
+	if (unlikely(!name)) {
 		err = -ENOMEM;
-		goto put_unm_err_out;
+		goto err_out;
 	}
 	/* Are we jumping straight into the index allocation attribute? */
 	if (filp->f_pos >= vol->mft_record_size)
@@ -1122,12 +1125,11 @@
 	/* Get the offset into the index root attribute. */
 	ir_pos = (s64)filp->f_pos;
 	/* Find the index root attribute in the mft record. */
-	if (!lookup_attr(AT_INDEX_ROOT, I30, 4, CASE_SENSITIVE, 0, NULL, 0,
-			ctx)) {
+	if (unlikely(!lookup_attr(AT_INDEX_ROOT, I30, 4, CASE_SENSITIVE, 0,
+			NULL, 0, ctx))) {
 		ntfs_error(sb, "Index root attribute missing in directory "
 				"inode 0x%lx.", vdir->i_ino);
-		err = -EIO;
-		goto kf_unm_err_out;
+		goto err_out;
 	}
 	/* Get to the index root value (it's been verified in read_inode). */
 	ir = (INDEX_ROOT*)((u8*)ctx->attr +
@@ -1144,11 +1146,11 @@
 	for (;; ie = (INDEX_ENTRY*)((u8*)ie + le16_to_cpu(ie->_IEH(length)))) {
 		ntfs_debug("In index root, offset 0x%x.", (u8*)ie - (u8*)ir);
 		/* Bounds checks. */
-		if ((u8*)ie < (u8*)ctx->mrec || (u8*)ie +
+		if (unlikely((u8*)ie < (u8*)ctx->mrec || (u8*)ie +
 				sizeof(INDEX_ENTRY_HEADER) > index_end ||
 				(u8*)ie + le16_to_cpu(ie->_IEH(key_length)) >
-				index_end)
-			goto dir_err_out;
+				index_end))
+			goto err_out;
 		/* The last entry cannot contain a name. */
 		if (ie->_IEH(flags) & INDEX_ENTRY_END)
 			break;
@@ -1166,80 +1168,99 @@
 		goto EOD;
 	/* Advance f_pos to the beginning of the index allocation. */
 	filp->f_pos = vol->mft_record_size;
-	/* Reinitialize the search context. */
-	reinit_attr_search_ctx(ctx);
 skip_index_root:
-	if (NInoBmpNonResident(ndir)) {
-		/*
-		 * Read the page of the bitmap that contains the current index
-		 * block.
-		 */
-		// TODO: FIXME: Implement this!
-		ntfs_error(sb, "Index bitmap is non-resident, which is not "
-				"supported yet. Pretending that end of "
-				"directory has been reached.\n");
-		goto EOD;
-	} else {
-		/* Find the index bitmap attribute in the mft record. */
-		if (!lookup_attr(AT_BITMAP, I30, 4, CASE_SENSITIVE, 0, NULL, 0,
-				ctx)) {
-			ntfs_error(sb, "Index bitmap attribute missing in "
-					"directory inode 0x%lx.", vdir->i_ino);
-			err = -EIO;
-			goto kf_unm_err_out;
-		}
-		bmp = (u8*)ctx->attr +
-				le16_to_cpu(ctx->attr->_ARA(value_offset));
-	}
+	kaddr = NULL;
+	prev_ia_pos = -1LL;
 	/* Get the offset into the index allocation attribute. */
 	ia_pos = (s64)filp->f_pos - vol->mft_record_size;
 	ia_mapping = vdir->i_mapping;
-	/* If the index block is not in use find the next one that is. */
+	bmp_vi = ndir->_IDM(bmp_ino);
+	if (unlikely(!bmp_vi)) {
+		ntfs_debug("Inode %lu, regetting index bitmap.", vdir->i_ino);
+		bmp_vi = ntfs_attr_iget(vdir, AT_BITMAP, I30, 4);
+		if (unlikely(IS_ERR(bmp_vi))) {
+			ntfs_error(sb, "Failed to get bitmap attribute.");
+			err = PTR_ERR(bmp_vi);
+			goto err_out;
+		}
+		ndir->_IDM(bmp_ino) = bmp_vi;
+	}
+	bmp_mapping = bmp_vi->i_mapping;
+	/* Get the starting bitmap bit position and sanity check it. */
 	bmp_pos = ia_pos >> ndir->_IDM(index_block_size_bits);
-	page = NULL;
-	kaddr = NULL;
-	prev_ia_pos = -1LL;
-	if (bmp_pos >> 3 >= ndir->_IDM(bmp_size)) {
+	if (unlikely(bmp_pos >> 3 >= bmp_vi->i_size)) {
 		ntfs_error(sb, "Current index allocation position exceeds "
 				"index bitmap size.");
-		goto kf_unm_err_out;
+		goto err_out;
 	}
-	while (!(bmp[bmp_pos >> 3] & (1 << (bmp_pos & 7)))) {
+	/* Get the starting bit position in the current bitmap page. */
+	cur_bmp_pos = bmp_pos & ((PAGE_CACHE_SIZE * 8) - 1);
+	bmp_pos &= ~((PAGE_CACHE_SIZE * 8) - 1);
+get_next_bmp_page:
+	ntfs_debug("Reading bitmap with page index 0x%Lx, bit ofs 0x%Lx",
+			(long long)bmp_pos >> (3 + PAGE_CACHE_SHIFT),
+			(long long)bmp_pos & ((PAGE_CACHE_SIZE * 8) - 1));
+	bmp_page = ntfs_map_page(bmp_mapping,
+			bmp_pos >> (3 + PAGE_CACHE_SHIFT));
+	if (unlikely(IS_ERR(bmp_page))) {
+		ntfs_error(sb, "Reading index bitmap failed.");
+		err = PTR_ERR(bmp_page);
+		bmp_page = NULL;
+		goto err_out;
+	}
+	bmp = (u8*)page_address(bmp_page);
+	/* Find next index block in use. */
+	while (!(bmp[cur_bmp_pos >> 3] & (1 << (cur_bmp_pos & 7)))) {
 find_next_index_buffer:
-		bmp_pos++;
+		cur_bmp_pos++;
+		/*
+		 * If we have reached the end of the bitmap page, get the next
+		 * page, and put away the old one.
+		 */
+		if (unlikely((cur_bmp_pos >> 3) >= PAGE_CACHE_SIZE)) {
+			ntfs_unmap_page(bmp_page);
+			bmp_pos += PAGE_CACHE_SIZE * 8;
+			cur_bmp_pos = 0;
+			goto get_next_bmp_page;
+		}
 		/* If we have reached the end of the bitmap, we are done. */
-		if (bmp_pos >> 3 >= ndir->_IDM(bmp_size))
-			goto EOD;
-		ia_pos = (s64)bmp_pos << ndir->_IDM(index_block_size_bits);
+		if (unlikely(((bmp_pos + cur_bmp_pos) >> 3) >= vdir->i_size))
+			goto unm_EOD;
+		ia_pos = (bmp_pos + cur_bmp_pos) <<
+				ndir->_IDM(index_block_size_bits);
 	}
-	ntfs_debug("Handling index buffer 0x%x.", bmp_pos);
+	ntfs_debug("Handling index buffer 0x%Lx.",
+			(long long)bmp_pos + cur_bmp_pos);
 	/* If the current index buffer is in the same page we reuse the page. */
 	if ((prev_ia_pos & PAGE_CACHE_MASK) != (ia_pos & PAGE_CACHE_MASK)) {
 		prev_ia_pos = ia_pos;
-		if (page)
-			ntfs_unmap_page(page);
+		if (likely(ia_page != NULL))
+			ntfs_unmap_page(ia_page);
 		/*
 		 * Map the page cache page containing the current ia_pos,
 		 * reading it from disk if necessary.
 		 */
-		page = ntfs_map_page(ia_mapping, ia_pos >> PAGE_CACHE_SHIFT);
-		if (IS_ERR(page))
-			goto map_page_err_out;
-		kaddr = (u8*)page_address(page);
+		ia_page = ntfs_map_page(ia_mapping, ia_pos >> PAGE_CACHE_SHIFT);
+		if (unlikely(IS_ERR(ia_page))) {
+			ntfs_error(sb, "Reading index allocation data failed.");
+			err = PTR_ERR(ia_page);
+			ia_page = NULL;
+			goto err_out;
+		}
+		kaddr = (u8*)page_address(ia_page);
 	}
 	/* Get the current index buffer. */
 	ia = (INDEX_ALLOCATION*)(kaddr + (ia_pos & ~PAGE_CACHE_MASK &
 			~(s64)(ndir->_IDM(index_block_size) - 1)));
 	/* Bounds checks. */
-	if ((u8*)ia < kaddr || (u8*)ia > kaddr + PAGE_CACHE_SIZE) {
+	if (unlikely((u8*)ia < kaddr || (u8*)ia > kaddr + PAGE_CACHE_SIZE)) {
 		ntfs_error(sb, "Out of bounds check failed. Corrupt directory "
 				"inode 0x%lx or driver bug.", vdir->i_ino);
-		err = -EIO;
-		goto unm_dir_err_out;
+		goto err_out;
 	}
-	if (sle64_to_cpu(ia->index_block_vcn) != (ia_pos &
+	if (unlikely(sle64_to_cpu(ia->index_block_vcn) != (ia_pos &
 			~(s64)(ndir->_IDM(index_block_size) - 1)) >>
-			ndir->_IDM(index_vcn_size_bits)) {
+			ndir->_IDM(index_vcn_size_bits))) {
 		ntfs_error(sb, "Actual VCN (0x%Lx) of index buffer is "
 				"different from expected VCN (0x%Lx). "
 				"Directory inode 0x%lx is corrupt or driver "
@@ -1247,11 +1268,10 @@
 				(long long)sle64_to_cpu(ia->index_block_vcn),
 				(long long)ia_pos >>
 				ndir->_IDM(index_vcn_size_bits), vdir->i_ino);
-		err = -EIO;
-		goto unm_dir_err_out;
+		goto err_out;
 	}
-	if (le32_to_cpu(ia->index.allocated_size) + 0x18 !=
-			ndir->_IDM(index_block_size)) {
+	if (unlikely(le32_to_cpu(ia->index.allocated_size) + 0x18 !=
+			ndir->_IDM(index_block_size))) {
 		ntfs_error(sb, "Index buffer (VCN 0x%Lx) of directory inode "
 				"0x%lx has a size (%u) differing from the "
 				"directory specified size (%u). Directory "
@@ -1260,28 +1280,25 @@
 				ndir->_IDM(index_vcn_size_bits), vdir->i_ino,
 				le32_to_cpu(ia->index.allocated_size) + 0x18,
 				ndir->_IDM(index_block_size));
-		err = -EIO;
-		goto unm_dir_err_out;
+		goto err_out;
 	}
 	index_end = (u8*)ia + ndir->_IDM(index_block_size);
-	if (index_end > kaddr + PAGE_CACHE_SIZE) {
+	if (unlikely(index_end > kaddr + PAGE_CACHE_SIZE)) {
 		ntfs_error(sb, "Index buffer (VCN 0x%Lx) of directory inode "
 				"0x%lx crosses page boundary. Impossible! "
 				"Cannot access! This is probably a bug in the "
 				"driver.", (long long)ia_pos >>
 				ndir->_IDM(index_vcn_size_bits), vdir->i_ino);
-		err = -EIO;
-		goto unm_dir_err_out;
+		goto err_out;
 	}
 	ia_start = ia_pos & ~(s64)(ndir->_IDM(index_block_size) - 1);
 	index_end = (u8*)&ia->index + le32_to_cpu(ia->index.index_length);
-	if (index_end > (u8*)ia + ndir->_IDM(index_block_size)) {
+	if (unlikely(index_end > (u8*)ia + ndir->_IDM(index_block_size))) {
 		ntfs_error(sb, "Size of index buffer (VCN 0x%Lx) of directory "
 				"inode 0x%lx exceeds maximum size.",
 				(long long)ia_pos >>
 				ndir->_IDM(index_vcn_size_bits), vdir->i_ino);
-		err = -EIO;
-		goto unm_dir_err_out;
+		goto err_out;
 	}
 	/* The first index entry in this index buffer. */
 	ie = (INDEX_ENTRY*)((u8*)&ia->index +
@@ -1295,11 +1312,11 @@
 		ntfs_debug("In index allocation, offset 0x%Lx.",
 				(long long)ia_start + ((u8*)ie - (u8*)ia));
 		/* Bounds checks. */
-		if ((u8*)ie < (u8*)ia || (u8*)ie +
+		if (unlikely((u8*)ie < (u8*)ia || (u8*)ie +
 				sizeof(INDEX_ENTRY_HEADER) > index_end ||
 				(u8*)ie + le16_to_cpu(ie->_IEH(key_length)) >
-				index_end)
-			goto unm_dir_err_out;
+				index_end))
+			goto err_out;
 		/* The last entry cannot contain a name. */
 		if (ie->_IEH(flags) & INDEX_ENTRY_END)
 			break;
@@ -1310,11 +1327,16 @@
 		rc = ntfs_filldir(vol, filp, ndir, INDEX_TYPE_ALLOCATION, ia,
 				ie, name, dirent, filldir);
 		if (rc) {
-			ntfs_unmap_page(page);
+			ntfs_unmap_page(ia_page);
+			ntfs_unmap_page(bmp_page);
 			goto abort;
 		}
 	}
 	goto find_next_index_buffer;
+unm_EOD:
+	if (ia_page)
+		ntfs_unmap_page(ia_page);
+	ntfs_unmap_page(bmp_page);
 EOD:
 	/* We are finished, set f_pos to EOD. */
 	filp->f_pos = vdir->i_size + vol->mft_record_size;
@@ -1331,24 +1353,21 @@
 				rc, filp->f_pos);
 #endif
 	return 0;
-map_page_err_out:
-	ntfs_error(sb, "Reading index allocation data failed.");
-	err = PTR_ERR(page);
-kf_unm_err_out:
-	kfree(name);
-put_unm_err_out:
-	put_attr_search_ctx(ctx);
-unm_err_out:
-	unmap_mft_record(READ, ndir);
 err_out:
+	if (bmp_page)
+		ntfs_unmap_page(bmp_page);
+	if (ia_page)
+		ntfs_unmap_page(ia_page);
+	if (name)
+		kfree(name);
+	if (ctx)
+		put_attr_search_ctx(ctx);
+	if (m)
+		unmap_mft_record(READ, ndir);
+	if (!err)
+		err = -EIO;
 	ntfs_debug("Failed. Returning error code %i.", -err);
 	return err;
-unm_dir_err_out:
-	ntfs_unmap_page(page);
-dir_err_out:
-	ntfs_error(sb, "Corrupt directory. Aborting. You should run chkdsk.");
-	err = -EIO;
-	goto kf_unm_err_out;
 }
 
 struct file_operations ntfs_dir_ops = {
diff -Nru a/fs/ntfs/inode.c b/fs/ntfs/inode.c
--- a/fs/ntfs/inode.c	Sun Jul 14 23:52:57 2002
+++ b/fs/ntfs/inode.c	Sun Jul 14 23:52:57 2002
@@ -329,12 +329,9 @@
 	ni->attr_list_size = 0;
 	ni->attr_list = NULL;
 	init_run_list(&ni->attr_list_rl);
+	ni->_IDM(bmp_ino) = NULL;
 	ni->_IDM(index_block_size) = 0;
 	ni->_IDM(index_vcn_size) = 0;
-	ni->_IDM(bmp_size) = 0;
-	ni->_IDM(bmp_initialized_size) = 0;
-	ni->_IDM(bmp_allocated_size) = 0;
-	init_run_list(&ni->_IDM(bmp_rl));
 	ni->_IDM(index_block_size_bits) = 0;
 	ni->_IDM(index_vcn_size_bits) = 0;
 	init_MUTEX(&ni->extent_lock);
@@ -680,6 +677,8 @@
 	 * in ntfs_ino->attr_list and it is ntfs_ino->attr_list_size bytes.
 	 */
 	if (S_ISDIR(vi->i_mode)) {
+		struct inode *bvi;
+		ntfs_inode *bni;
 		INDEX_ROOT *ir;
 		char *ir_end, *index_end;
 
@@ -787,7 +786,8 @@
 
 		if (!(ir->index.flags & LARGE_INDEX)) {
 			/* No index allocation. */
-			vi->i_size = ni->initialized_size = 0;
+			vi->i_size = ni->initialized_size =
+					ni->allocated_size = 0;
 			goto skip_large_dir_stuff;
 		} /* LARGE_INDEX: Index allocation present. Setup state. */
 		NInoSetIndexAllocPresent(ni);
@@ -832,63 +832,31 @@
 				ctx->attr->_ANR(initialized_size));
 		ni->allocated_size = sle64_to_cpu(
 				ctx->attr->_ANR(allocated_size));
-		/* Find bitmap attribute. */
-		reinit_attr_search_ctx(ctx);
-		if (!lookup_attr(AT_BITMAP, I30, 4, CASE_SENSITIVE, 0, NULL, 0,
-				ctx)) {
-			ntfs_error(vi->i_sb, "$BITMAP attribute is not "
-					"present but it must be.");
+
+		/* Get the index bitmap attribute inode. */
+		bvi = ntfs_attr_iget(vi, AT_BITMAP, I30, 4);
+		if (unlikely(IS_ERR(bvi))) {
+			ntfs_error(vi->i_sb, "Failed to get bitmap attribute.");
+			err = PTR_ERR(bvi);
 			goto unm_err_out;
 		}
-		if (ctx->attr->flags & (ATTR_COMPRESSION_MASK |
-				ATTR_IS_ENCRYPTED | ATTR_IS_SPARSE)) {
+		ni->_IDM(bmp_ino) = bvi;
+		bni = NTFS_I(bvi);
+		if (NInoCompressed(bni) || NInoEncrypted(bni) ||
+				NInoSparse(bni)) {
 			ntfs_error(vi->i_sb, "$BITMAP attribute is compressed "
 					"and/or encrypted and/or sparse.");
 			goto unm_err_out;
 		}
-		if (ctx->attr->non_resident) {
-			NInoSetBmpNonResident(ni);
-			if (ctx->attr->_ANR(lowest_vcn)) {
-				ntfs_error(vi->i_sb, "First extent of $BITMAP "
-						"attribute has non zero "
-						"lowest_vcn. Inode is corrupt. "
-						"You should run chkdsk.");
-				goto unm_err_out;
-			}
-			ni->_IDM(bmp_size) = sle64_to_cpu(
-					ctx->attr->_ANR(data_size));
-			ni->_IDM(bmp_initialized_size) = sle64_to_cpu(
-					ctx->attr->_ANR(initialized_size));
-			ni->_IDM(bmp_allocated_size) = sle64_to_cpu(
-					ctx->attr->_ANR(allocated_size));
-			/*
-			 * Setup the run list. No need for locking as we have
-			 * exclusive access to the inode at this time.
-			 */
-			ni->_IDM(bmp_rl).rl = decompress_mapping_pairs(vol,
-					ctx->attr, NULL);
-			if (IS_ERR(ni->_IDM(bmp_rl).rl)) {
-				err = PTR_ERR(ni->_IDM(bmp_rl).rl);
-				ni->_IDM(bmp_rl).rl = NULL;
-				ntfs_error(vi->i_sb, "Mapping pairs "
-						"decompression failed with "
-						"error code %i.", -err);
-				goto unm_err_out;
-			}
-		} else
-			ni->_IDM(bmp_size) = ni->_IDM(bmp_initialized_size) =
-					ni->_IDM(bmp_allocated_size) =
-					le32_to_cpu(
-					ctx->attr->_ARA(value_length));
 		/* Consistency check bitmap size vs. index allocation size. */
-		if (ni->_IDM(bmp_size) << 3 < vi->i_size >>
-				ni->_IDM(index_block_size_bits)) {
-			ntfs_error(vi->i_sb, "$I30 bitmap too small (0x%Lx) "
+		if ((bvi->i_size << 3) < (vi->i_size >>
+				ni->_IDM(index_block_size_bits))) {
+			ntfs_error(vi->i_sb, "Index bitmap too small (0x%Lx) "
 					"for index allocation (0x%Lx).",
-					(long long)ni->_IDM(bmp_size) << 3,
-					vi->i_size);
+					bvi->i_size << 3, vi->i_size);
 			goto unm_err_out;
 		}
+
 skip_large_dir_stuff:
 		/* Everyone gets read and scan permissions. */
 		vi->i_mode |= S_IRUGO | S_IXUGO;
@@ -1271,7 +1239,7 @@
 						"will probably cause problems "
 						"when trying to access the "
 						"file. Please notify "
-						"linux-ntfs-dev@ lists.sf.net "
+						"linux-ntfs-dev@lists.sf.net "
 						"that you saw this message.");
 		}
 	}
@@ -1785,6 +1753,32 @@
 	return 0;
 }
 
+/**
+ * ntfs_put_inode - handler for when the inode reference count is decremented
+ * @vi:		vfs inode
+ *
+ * The VFS calls ntfs_put_inode() every time the inode reference count (i_count)
+ * is about to be decremented (but before the decrement itself.
+ *
+ * If the inode @vi is a directory with a single reference, we need to put the
+ * attribute inode for the directory index bitmap, if it is present, otherwise
+ * the directory inode would remain pinned for ever (or rather until umount()
+ * time.
+ */
+void ntfs_put_inode(struct inode *vi)
+{
+	if (S_ISDIR(vi->i_mode) && (atomic_read(&vi->i_count) == 2)) {
+		ntfs_inode *ni;
+
+		ni = NTFS_I(vi);
+		if (NInoIndexAllocPresent(ni) && ni->_IDM(bmp_ino)) {
+			iput(ni->_IDM(bmp_ino));
+			ni->_IDM(bmp_ino) = NULL;
+		}
+	}
+	return;
+}
+
 void __ntfs_clear_inode(ntfs_inode *ni)
 {
 	int err;
@@ -1866,12 +1860,7 @@
 
 	__ntfs_clear_inode(ni);
 
-	if (S_ISDIR(vi->i_mode)) {
-		down_write(&ni->_IDM(bmp_rl).lock);
-		if (ni->_IDM(bmp_rl).rl)
-			ntfs_free(ni->_IDM(bmp_rl).rl);
-		up_write(&ni->_IDM(bmp_rl).lock);
-	} else if (NInoAttr(ni)) {
+	if (NInoAttr(ni)) {
 		/* Release the base inode if we are holding it. */
 		if (ni->nr_extents == -1) {
 			iput(VFS_I(ni->_INE(base_ntfs_ino)));
diff -Nru a/fs/ntfs/inode.h b/fs/ntfs/inode.h
--- a/fs/ntfs/inode.h	Sun Jul 14 23:52:57 2002
+++ b/fs/ntfs/inode.h	Sun Jul 14 23:52:57 2002
@@ -92,14 +92,11 @@
 	run_list attr_list_rl;	/* Run list for the attribute list value. */
 	union {
 		struct { /* It is a directory or $MFT. */
+			struct inode *bmp_ino;	/* Attribute inode for the
+						   directory index $BITMAP. */
 			u32 index_block_size;	/* Size of an index block. */
 			u32 index_vcn_size;	/* Size of a vcn in this
 						   directory index. */
-			s64 bmp_size;		/* Size of the $I30 bitmap. */
-			s64 bmp_initialized_size; /* Copy from $I30 bitmap. */
-			s64 bmp_allocated_size;	/* Copy from $I30 bitmap. */
-			run_list bmp_rl;	/* Run list for the $I30 bitmap
-						   if it is non-resident. */
 			u8 index_block_size_bits; /* Log2 of the above. */
 			u8 index_vcn_size_bits;	/* Log2 of the above. */
 		} SN(idm);
@@ -165,7 +162,6 @@
 	NI_Sparse,		/* 1: Unnamed data attr is sparse (f).
 				   1: Create sparse files by default (d).
 				   1: Attribute is sparse (a). */
-	NI_BmpNonResident,	/* 1: $I30 bitmap attr is non resident (d). */
 } ntfs_inode_state_bits;
 
 /*
@@ -203,7 +199,6 @@
 NINO_FNS(Compressed)
 NINO_FNS(Encrypted)
 NINO_FNS(Sparse)
-NINO_FNS(BmpNonResident)
 
 /*
  * The full structure containing a ntfs_inode and a vfs struct inode. Used for
@@ -246,6 +241,8 @@
 extern void ntfs_read_inode_mount(struct inode *vi);
 
 extern void ntfs_dirty_inode(struct inode *vi);
+
+extern void ntfs_put_inode(struct inode *vi);
 
 extern int ntfs_show_options(struct seq_file *sf, struct vfsmount *mnt);
 
diff -Nru a/fs/ntfs/super.c b/fs/ntfs/super.c
--- a/fs/ntfs/super.c	Sun Jul 14 23:52:57 2002
+++ b/fs/ntfs/super.c	Sun Jul 14 23:52:57 2002
@@ -1263,10 +1263,8 @@
 	dirty_inode:	ntfs_dirty_inode,	/* VFS: Called from
 						   __mark_inode_dirty(). */
 	//write_inode:	NULL,		/* VFS: Write dirty inode to disk. */
-	//put_inode:	NULL,		/* VFS: Called whenever the reference
-	//				   count (i_count) of the inode is
-	//				   going to be decreased but before the
-	//				   actual decrease. */
+	put_inode:	ntfs_put_inode,	/* VFS: Called just before the inode
+					   reference count is decreased. */
 	//delete_inode:	NULL,		/* VFS: Delete inode from disk. Called
 	//				   when i_count becomes 0 and i_nlink is
 	//				   also 0. */

===================================================================

## Wrapped with gzip_uu ##


begin 664 bkpatch7276
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
%W\$Q````
`
end
