Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317141AbSGHU5V>; Mon, 8 Jul 2002 16:57:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317142AbSGHU5U>; Mon, 8 Jul 2002 16:57:20 -0400
Received: from plum.csi.cam.ac.uk ([131.111.8.3]:46765 "EHLO
	plum.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S317141AbSGHU5L>; Mon, 8 Jul 2002 16:57:11 -0400
Subject: NTFS: 2.0.16 - Convert access to inode bitmap to attribute inode API
To: torvalds@transmeta.com (Linus Torvalds)
Date: Mon, 8 Jul 2002 21:59:51 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (Linux Kernel)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17Rfbr-0005yB-00@storm.christs.cam.ac.uk>
From: Anton Altaparmakov <aia21@cantab.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please do a

	bk pull http://linux-ntfs.bkbits.net/ntfs-tng-2.5

Thanks!

In addition to fixing two stupid buglets, this does a massive code
cleanup by removing the mftbmp access hacks and using the new
ntfs fake inode API introduced in the last patch.

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/, http://www-stu.christs.cam.ac.uk/~aia21/

===================================================================

This will update the following files:

 Documentation/filesystems/ntfs.txt |    4 
 fs/ntfs/ChangeLog                  |   15 +-
 fs/ntfs/Makefile                   |    2 
 fs/ntfs/aops.c                     |  198 ---------------------------
 fs/ntfs/inode.c                    |    2 
 fs/ntfs/inode.h                    |    2 
 fs/ntfs/ntfs.h                     |    1 
 fs/ntfs/super.c                    |  264 ++++++-------------------------------
 fs/ntfs/volume.h                   |    8 -
 9 files changed, 73 insertions(+), 423 deletions(-)

through these ChangeSets:

<aia21@cantab.net> (02/07/08 1.618)
   NTFS: 2.0.16 - Convert access to $MFT/$BITMAP to attribute inode API.
   - Fix a stupid bug introduced in 2.0.15 where we were unmapping the
     wrong inode in fs/ntfs/inode.c::ntfs_attr_iget().
   - Convert $MFT/$BITMAP access to attribute inode API and remove all
     remnants of the ugly mftbmp address space and operations hack. This
     means we finally have only one readpage function as well as only one
     async io completion handler. Yey! The mft bitmap is now just an
     attribute inode and is accessed from vol->mftbmp_ino just as if it
     were a normal file. Fake inodes rule. (-:

<aia21@cantab.net> (02/07/08 1.619)
   NTFS: Fix debugging check in fs/ntfs/aops.c::ntfs_read_block().


diff -Nru a/Documentation/filesystems/ntfs.txt b/Documentation/filesystems/ntfs.txt
--- a/Documentation/filesystems/ntfs.txt	Mon Jul  8 21:55:49 2002
+++ b/Documentation/filesystems/ntfs.txt	Mon Jul  8 21:55:49 2002
@@ -247,6 +247,10 @@
 
 Note, a technical ChangeLog aimed at kernel hackers is in fs/ntfs/ChangeLog.
 
+2.0.16:
+	- Fix stupid bug introduced in 2.0.15 in new attribute inode API.
+	- Big internal cleanup replacing the mftbmp access hacks by using the
+	  new attribute inode API instead.
 2.0.15:
 	- Bug fix in parsing of remount options.
 	- Internal changes implementing attribute (fake) inodes allowing all
diff -Nru a/fs/ntfs/ChangeLog b/fs/ntfs/ChangeLog
--- a/fs/ntfs/ChangeLog	Mon Jul  8 21:55:49 2002
+++ b/fs/ntfs/ChangeLog	Mon Jul  8 21:55:49 2002
@@ -17,15 +17,23 @@
 	- Consider if ntfs_file_read_compressed_block() shouldn't be coping
 	  with initialized_size < data_size. I don't think it can happen but
 	  it requires more careful consideration.
-	- CLEANUP: At the moment we have two copies of almost identical
-	  functions in aops.c, can merge them once fake inode address space
-	  based attribute i/o is further developed.
 	- CLEANUP: Modularising code in aops.c a bit, e.g. a-la get_block(),
 	  will be cleaner and make code reuse easier.
 	- Modify ntfs_read_locked_inode() to return an error code and update
 	  callers, i.e. ntfs_iget(), to pass that error code up instead of just
 	  using -EIO.
 	- Enable NFS exporting of NTFS.
+
+2.0.16 - Convert access to $MFT/$BITMAP to attribute inode API.
+
+	- Fix a stupid bug introduced in 2.0.15 where we were unmapping the
+	  wrong inode in fs/ntfs/inode.c::ntfs_attr_iget().
+	- Convert $MFT/$BITMAP access to attribute inode API and remove all
+	  remnants of the ugly mftbmp address space and operations hack. This
+	  means we finally have only one readpage function as well as only one
+	  async io completion handler. Yey! The mft bitmap is now just an
+	  attribute inode and is accessed from vol->mftbmp_ino just as if it
+	  were a normal file. Fake inodes rule. (-:
 
 2.0.15 - Fake inodes based attribute i/o via the pagecache, fixes and cleanups.
 
diff -Nru a/fs/ntfs/Makefile b/fs/ntfs/Makefile
--- a/fs/ntfs/Makefile	Mon Jul  8 21:55:49 2002
+++ b/fs/ntfs/Makefile	Mon Jul  8 21:55:49 2002
@@ -5,7 +5,7 @@
 ntfs-objs := aops.o attrib.o compress.o debug.o dir.o file.o inode.o mft.o \
 	     mst.o namei.o super.o sysctl.o time.o unistr.o upcase.o
 
-EXTRA_CFLAGS = -DNTFS_VERSION=\"2.0.15\"
+EXTRA_CFLAGS = -DNTFS_VERSION=\"2.0.16\"
 
 ifeq ($(CONFIG_NTFS_DEBUG),y)
 EXTRA_CFLAGS += -DDEBUG
diff -Nru a/fs/ntfs/aops.c b/fs/ntfs/aops.c
--- a/fs/ntfs/aops.c	Mon Jul  8 21:55:49 2002
+++ b/fs/ntfs/aops.c	Mon Jul  8 21:55:49 2002
@@ -392,207 +392,11 @@
 }
 
 /**
- * end_buffer_read_mftbmp_async -
- *
- * Async io completion handler for accessing mft bitmap. Adapted from
- * end_buffer_read_mst_async().
- */
-static void end_buffer_read_mftbmp_async(struct buffer_head *bh, int uptodate)
-{
-	static spinlock_t page_uptodate_lock = SPIN_LOCK_UNLOCKED;
-	unsigned long flags;
-	struct buffer_head *tmp;
-	struct page *page;
-
-	if (likely(uptodate))
-		set_buffer_uptodate(bh);
-	else
-		clear_buffer_uptodate(bh);
-
-	page = bh->b_page;
-
-	if (likely(uptodate)) {
-		s64 file_ofs;
-
-		/* Host is the ntfs volume. Our mft bitmap access kludge... */
-		ntfs_volume *vol = (ntfs_volume*)page->mapping->host;
-
-		file_ofs = (page->index << PAGE_CACHE_SHIFT) + bh_offset(bh);
-		if (file_ofs + bh->b_size > vol->mftbmp_initialized_size) {
-			char *addr;
-			int ofs = 0;
-
-			if (file_ofs < vol->mftbmp_initialized_size)
-				ofs = vol->mftbmp_initialized_size - file_ofs;
-			addr = kmap_atomic(page, KM_BIO_SRC_IRQ);
-			memset(addr + bh_offset(bh) + ofs, 0, bh->b_size - ofs);
-			flush_dcache_page(page);
-			kunmap_atomic(addr, KM_BIO_SRC_IRQ);
-		}
-	} else
-		SetPageError(page);
-
-	spin_lock_irqsave(&page_uptodate_lock, flags);
-	clear_buffer_async_read(bh);
-	unlock_buffer(bh);
-
-	tmp = bh->b_this_page;
-	while (tmp != bh) {
-		if (buffer_locked(tmp)) {
-			if (buffer_async_read(tmp))
-				goto still_busy;
-		} else if (!buffer_uptodate(tmp))
-			SetPageError(page);
-		tmp = tmp->b_this_page;
-	}
-
-	spin_unlock_irqrestore(&page_uptodate_lock, flags);
-	if (likely(!PageError(page)))
-		SetPageUptodate(page);
-	unlock_page(page);
-	return;
-still_busy:
-	spin_unlock_irqrestore(&page_uptodate_lock, flags);
-	return;
-}
-
-/**
- * ntfs_mftbmp_readpage -
- *
- * Readpage for accessing mft bitmap.
- */
-static int ntfs_mftbmp_readpage(ntfs_volume *vol, struct page *page)
-{
-	VCN vcn;
-	LCN lcn;
-	struct buffer_head *bh, *head, *arr[MAX_BUF_PER_PAGE];
-	sector_t iblock, lblock, zblock;
-	unsigned int blocksize, blocks, vcn_ofs;
-	int nr, i;
-	unsigned char blocksize_bits;
-
-	if (unlikely(!PageLocked(page)))
-		PAGE_BUG(page);
-
-	blocksize = vol->sb->s_blocksize;
-	blocksize_bits = vol->sb->s_blocksize_bits;
-
-	if (!page_has_buffers(page))
-		create_empty_buffers(page, blocksize, 0);
-	bh = head = page_buffers(page);
-	if (unlikely(!bh))
-		return -ENOMEM;
-
-	blocks = PAGE_CACHE_SIZE >> blocksize_bits;
-	iblock = page->index << (PAGE_CACHE_SHIFT - blocksize_bits);
-	lblock = (vol->mftbmp_allocated_size + blocksize - 1) >> blocksize_bits;
-	zblock = (vol->mftbmp_initialized_size + blocksize - 1) >>
-			blocksize_bits;
-
-	/* Loop through all the buffers in the page. */
-	nr = i = 0;
-	do {
-		if (unlikely(buffer_uptodate(bh)))
-			continue;
-		if (unlikely(buffer_mapped(bh))) {
-			arr[nr++] = bh;
-			continue;
-		}
-		bh->b_bdev = vol->sb->s_bdev;
-		/* Is the block within the allowed limits? */
-		if (iblock < lblock) {
-			/* Convert iblock into corresponding vcn and offset. */
-			vcn = (VCN)iblock << blocksize_bits >>
-					vol->cluster_size_bits;
-			vcn_ofs = ((VCN)iblock << blocksize_bits) &
-					vol->cluster_size_mask;
-			/* Convert the vcn to the corresponding lcn. */
-			down_read(&vol->mftbmp_rl.lock);
-			lcn = vcn_to_lcn(vol->mftbmp_rl.rl, vcn);
-			up_read(&vol->mftbmp_rl.lock);
-			/* Successful remap. */
-			if (lcn >= 0) {
-				/* Setup buffer head to correct block. */
-				bh->b_blocknr = ((lcn << vol->cluster_size_bits)
-						+ vcn_ofs) >> blocksize_bits;
-				set_buffer_mapped(bh);
-				/* Only read initialized data blocks. */
-				if (iblock < zblock) {
-					arr[nr++] = bh;
-					continue;
-				}
-				/* Fully non-initialized data block, zero it. */
-				goto handle_zblock;
-			}
-			if (lcn != LCN_HOLE) {
-				/* Hard error, zero out region. */
-				SetPageError(page);
-				ntfs_error(vol->sb, "vcn_to_lcn(vcn = 0x%Lx) "
-						"failed with error code "
-						"0x%Lx.", (long long)vcn,
-						(long long)-lcn);
-				// FIXME: Depending on vol->on_errors, do
-				// something.
-			}
-		}
-		/*
-		 * Either iblock was outside lblock limits or vcn_to_lcn()
-		 * returned error. Just zero that portion of the page and set
-		 * the buffer uptodate.
-		 */
-		bh->b_blocknr = -1UL;
-		clear_buffer_mapped(bh);
-handle_zblock:
-		memset(kmap(page) + i * blocksize, 0, blocksize);
-		flush_dcache_page(page);
-		kunmap(page);
-		set_buffer_uptodate(bh);
-	} while (i++, iblock++, (bh = bh->b_this_page) != head);
-
-	/* Check we have at least one buffer ready for i/o. */
-	if (nr) {
-		/* Lock the buffers. */
-		for (i = 0; i < nr; i++) {
-			struct buffer_head *tbh = arr[i];
-			lock_buffer(tbh);
-			tbh->b_end_io = end_buffer_read_mftbmp_async;
-			set_buffer_async_read(tbh);
-		}
-		/* Finally, start i/o on the buffers. */
-		for (i = 0; i < nr; i++)
-			submit_bh(READ, arr[i]);
-		return 0;
-	}
-	/* No i/o was scheduled on any of the buffers. */
-	if (likely(!PageError(page)))
-		SetPageUptodate(page);
-	else /* Signal synchronous i/o error. */
-		nr = -EIO;
-	unlock_page(page);
-	return nr;
-}
-
-/**
  * ntfs_aops - general address space operations for inodes and attributes
  */
 struct address_space_operations ntfs_aops = {
 	writepage:	NULL,			/* Write dirty page to disk. */
 	readpage:	ntfs_readpage,		/* Fill page with data. */
-	sync_page:	block_sync_page,	/* Currently, just unplugs the
-						   disk request queue. */
-	prepare_write:	NULL,			/* . */
-	commit_write:	NULL,			/* . */
-};
-
-typedef int readpage_t(struct file *, struct page *);
-
-/**
- * ntfs_mftbmp_aops - address space operations for accessing mftbmp
- */
-struct address_space_operations ntfs_mftbmp_aops = {
-	writepage:	NULL,			/* Write dirty page to disk. */
-	readpage:	(readpage_t*)ntfs_mftbmp_readpage, /* Fill page with
-							      data. */
 	sync_page:	block_sync_page,	/* Currently, just unplugs the
 						   disk request queue. */
 	prepare_write:	NULL,			/* . */
diff -Nru a/fs/ntfs/inode.c b/fs/ntfs/inode.c
--- a/fs/ntfs/inode.c	Mon Jul  8 21:55:49 2002
+++ b/fs/ntfs/inode.c	Mon Jul  8 21:55:49 2002
@@ -1316,7 +1316,7 @@
 	ni->nr_extents = -1;
 
 	put_attr_search_ctx(ctx);
-	unmap_mft_record(READ, ni);
+	unmap_mft_record(READ, base_ni);
 
 	ntfs_debug("Done.");
 	return 0;
diff -Nru a/fs/ntfs/inode.h b/fs/ntfs/inode.h
--- a/fs/ntfs/inode.h	Mon Jul  8 21:55:49 2002
+++ b/fs/ntfs/inode.h	Mon Jul  8 21:55:49 2002
@@ -232,6 +232,8 @@
 }
 
 extern struct inode *ntfs_iget(struct super_block *sb, unsigned long mft_no);
+extern struct inode *ntfs_attr_iget(struct inode *base_vi, ATTR_TYPES type,
+		uchar_t *name, u32 name_len);
 
 extern struct inode *ntfs_alloc_big_inode(struct super_block *sb);
 extern void ntfs_destroy_big_inode(struct inode *inode);
diff -Nru a/fs/ntfs/ntfs.h b/fs/ntfs/ntfs.h
--- a/fs/ntfs/ntfs.h	Mon Jul  8 21:55:49 2002
+++ b/fs/ntfs/ntfs.h	Mon Jul  8 21:55:49 2002
@@ -67,7 +67,6 @@
 
 extern struct address_space_operations ntfs_aops;
 extern struct address_space_operations ntfs_mft_aops;
-extern struct address_space_operations ntfs_mftbmp_aops;
 
 extern struct  file_operations ntfs_file_ops;
 extern struct inode_operations ntfs_file_inode_ops;
diff -Nru a/fs/ntfs/super.c b/fs/ntfs/super.c
--- a/fs/ntfs/super.c	Mon Jul  8 21:55:49 2002
+++ b/fs/ntfs/super.c	Mon Jul  8 21:55:49 2002
@@ -775,141 +775,20 @@
  */
 static BOOL load_system_files(ntfs_volume *vol)
 {
-	VCN next_vcn, last_vcn, highest_vcn;
 	struct super_block *sb = vol->sb;
 	struct inode *tmp_ino;
 	MFT_RECORD *m;
-	ATTR_RECORD *attr;
 	VOLUME_INFORMATION *vi;
 	attr_search_context *ctx;
-	run_list_element *rl;
 
 	ntfs_debug("Entering.");
-	/*
-	 * We have $MFT already (vol->mft_ino) but we need to setup access to
-	 * the $MFT/$BITMAP attribute.
-	 */
-	m = map_mft_record(READ, NTFS_I(vol->mft_ino));
-	if (IS_ERR(m)) {
-		ntfs_error(sb, "Failed to map $MFT.");
-		return FALSE;
-	}
-	if (!(ctx = get_attr_search_ctx(NTFS_I(vol->mft_ino), m))) {
-		ntfs_error(sb, "Failed to get attribute search context.");
-		goto unmap_err_out;
-	}
-	/* Load all attribute extents. */
-	attr = NULL;
-	rl = NULL;
-	next_vcn = last_vcn = highest_vcn = 0;
-	while (lookup_attr(AT_BITMAP, NULL, 0, 0, next_vcn, NULL, 0, ctx)) {
-		run_list_element *nrl;
-
-		/* Cache the current attribute extent. */
-		attr = ctx->attr;
-		/* $MFT/$BITMAP must be non-resident. */
-		if (!attr->non_resident) {
-			ntfs_error(sb, "$MFT/$BITMAP must be non-resident but "
-					"a resident extent was found. $MFT is "
-					"corrupt. Run chkdsk.");
-			goto put_err_out;
-		}
-		/* $MFT/$BITMAP must be uncompressed and unencrypted. */
-		if (attr->flags & ATTR_COMPRESSION_MASK ||
-				attr->flags & ATTR_IS_ENCRYPTED) {
-			ntfs_error(sb, "$MFT/$BITMAP must be uncompressed and "
-					"unencrypted but a compressed/"
-					"encrypted extent was found. $MFT is "
-					"corrupt. Run chkdsk.");
-			goto put_err_out;
-		}
-		/*
-		 * Decompress the mapping pairs array of this extent
-		 * and merge the result into the existing run list. Note we
-		 * don't need any locking at this stage as we are already
-		 * running exclusively as we are mount in progress task.
-		 */
-		nrl = decompress_mapping_pairs(vol, attr, rl);
-		if (IS_ERR(nrl)) {
-			ntfs_error(sb, "decompress_mapping_pairs() failed with "
-					"error code %ld. $MFT is corrupt.",
-					PTR_ERR(nrl));
-			goto put_err_out;
-		}
-		rl = nrl;
-
-		/* Are we in the first extent? */
-		if (!next_vcn) {
-			/* Get the last vcn in the $BITMAP attribute. */
-			last_vcn = sle64_to_cpu(attr->_ANR(allocated_size)) >>
-					vol->cluster_size_bits;
-			vol->mftbmp_size = sle64_to_cpu(attr->_ANR(data_size));
-			vol->mftbmp_initialized_size =
-					sle64_to_cpu(attr->_ANR(initialized_size));
-			vol->mftbmp_allocated_size =
-					sle64_to_cpu(attr->_ANR(allocated_size));
-			/* Consistency check. */
-			if (vol->mftbmp_size < (vol->nr_mft_records + 7) >> 3) {
-				ntfs_error(sb, "$MFT/$BITMAP is too short to "
-						"contain a complete mft "
-						"bitmap: impossible. $MFT is "
-						"corrupt. Run chkdsk.");
-				goto put_err_out;
-			}
-		}
 
-		/* Get the lowest vcn for the next extent. */
-		highest_vcn = sle64_to_cpu(attr->_ANR(highest_vcn));
-		next_vcn = highest_vcn + 1;
-
-		/* Only one extent or error, which we catch below. */
-		if (next_vcn <= 0)
-			break;
-
-		/* Avoid endless loops due to corruption. */
-		if (next_vcn < sle64_to_cpu(attr->_ANR(lowest_vcn))) {
-			ntfs_error(sb, "$MFT/$BITMAP has corrupt attribute "
-					"list attribute. Run chkdsk.");
-			goto put_err_out;
-		}
-
-	}
-	if (!attr) {
-		ntfs_error(sb, "Missing or invalid $BITMAP attribute in file "
-				"$MFT. $MFT is corrupt. Run chkdsk.");
-put_err_out:
-		put_attr_search_ctx(ctx);
-unmap_err_out:
-		unmap_mft_record(READ, NTFS_I(vol->mft_ino));
+	/* Get mft bitmap attribute inode. */
+	vol->mftbmp_ino = ntfs_attr_iget(vol->mft_ino, AT_BITMAP, NULL, 0);
+	if (IS_ERR(vol->mftbmp_ino)) {
+		ntfs_error(sb, "Failed to load $MFT/$BITMAP attribute.");
 		return FALSE;
 	}
-
-	/* We are finished with $MFT/$BITMAP. */
-	put_attr_search_ctx(ctx);
-	unmap_mft_record(READ, NTFS_I(vol->mft_ino));
-
-	/* Catch errors. */
-	if (highest_vcn && highest_vcn != last_vcn - 1) {
-		ntfs_error(sb, "Failed to load the complete run list for "
-				"$MFT/$BITMAP. Driver bug or corrupt $MFT. "
-				"Run chkdsk.");
-		ntfs_debug("highest_vcn = 0x%Lx, last_vcn - 1 = 0x%Lx",
-				(long long)highest_vcn,
-				(long long)last_vcn - 1);
-		return FALSE;;
-	}
-
-	/* Setup the run list and the address space in the volume structure. */
-	vol->mftbmp_rl.rl = rl;
-	vol->mftbmp_mapping.a_ops = &ntfs_mftbmp_aops;
-	
-	/*
-	 * Not inode data, set to volume. Our mft bitmap access kludge...
-	 * We can only pray this is not going to cause problems... If it does
-	 * cause problems we will need a fake inode for this.
-	 */
-	vol->mftbmp_mapping.host = (struct inode*)vol;
-
 	// FIXME: If mounting read-only, it would be ok to ignore errors when
 	// loading the mftbmp but we then need to make sure nobody remounts the
 	// volume read-write...
@@ -920,7 +799,7 @@
 		if (!IS_ERR(vol->mftmirr_ino))
 			iput(vol->mftmirr_ino);
 		ntfs_error(sb, "Failed to load $MFTMirr.");
-		return FALSE;
+		goto iput_mftbmp_err_out;
 	}
 	// FIXME: Compare mftmirr with mft and repair if appropriate and not
 	// a read-only mount.
@@ -955,7 +834,7 @@
 			iput(vol->vol_ino);
 volume_failed:
 		ntfs_error(sb, "Failed to load $Volume.");
-		goto iput_bmp_mirr_err_out;
+		goto iput_lcnbmp_err_out;
 	}
 	m = map_mft_record(READ, NTFS_I(vol->vol_ino));
 	if (IS_ERR(m)) {
@@ -1001,7 +880,7 @@
 		ntfs_error(sb, "Failed to load $LogFile.");
 		// FIMXE: We only want to empty the thing so pointless bailing
 		// out. Can recover/ignore.
-		goto iput_vol_bmp_mirr_err_out;
+		goto iput_vol_err_out;
 	}
 	// FIXME: Empty the logfile, but only if not read-only.
 	// FIXME: What happens if someone remounts rw? We need to empty the file
@@ -1016,7 +895,7 @@
 		if (!IS_ERR(tmp_ino))
 			iput(tmp_ino);
 		ntfs_error(sb, "Failed to load $AttrDef.");
-		goto iput_vol_bmp_mirr_err_out;
+		goto iput_vol_err_out;
 	}
 	// FIXME: Parse the attribute definitions.
 	iput(tmp_ino);
@@ -1026,7 +905,7 @@
 		if (!IS_ERR(vol->root_ino))
 			iput(vol->root_ino);
 		ntfs_error(sb, "Failed to load root directory.");
-		goto iput_vol_bmp_mirr_err_out;
+		goto iput_vol_err_out;
 	}
 	/* If on NTFS versions before 3.0, we are done. */
 	if (vol->major_ver < 3)
@@ -1038,7 +917,7 @@
 		if (!IS_ERR(vol->secure_ino))
 			iput(vol->secure_ino);
 		ntfs_error(sb, "Failed to load $Secure.");
-		goto iput_root_vol_bmp_mirr_err_out;
+		goto iput_root_err_out;
 	}
 	// FIXME: Initialize security.
 	/* Get the extended system files' directory inode. */
@@ -1047,7 +926,7 @@
 		if (!IS_ERR(tmp_ino))
 			iput(tmp_ino);
 		ntfs_error(sb, "Failed to load $Extend.");
-		goto iput_sec_root_vol_bmp_mirr_err_out;
+		goto iput_sec_err_out;
 	}
 	// FIXME: Do something. E.g. want to delete the $UsnJrnl if exists.
 	// Note we might be doing this at the wrong level; we might want to
@@ -1056,16 +935,18 @@
 	// for the files in $Extend directory.
 	iput(tmp_ino);
 	return TRUE;
-iput_sec_root_vol_bmp_mirr_err_out:
+iput_sec_err_out:
 	iput(vol->secure_ino);
-iput_root_vol_bmp_mirr_err_out:
+iput_root_err_out:
 	iput(vol->root_ino);
-iput_vol_bmp_mirr_err_out:
+iput_vol_err_out:
 	iput(vol->vol_ino);
-iput_bmp_mirr_err_out:
+iput_lcnbmp_err_out:
 	iput(vol->lcnbmp_ino);
 iput_mirr_err_out:
 	iput(vol->mftmirr_ino);
+iput_mftbmp_err_out:
+	iput(vol->mftbmp_ino);
 	return FALSE;
 }
 
@@ -1083,8 +964,10 @@
 	ntfs_volume *vol = NTFS_SB(vfs_sb);
 
 	ntfs_debug("Entering.");
+
 	iput(vol->vol_ino);
 	vol->vol_ino = NULL;
+
 	/* NTFS 3.0+ specific clean up. */
 	if (vol->major_ver >= 3) {
 		if (vol->secure_ino) {
@@ -1092,29 +975,26 @@
 			vol->secure_ino = NULL;
 		}
 	}
+
 	iput(vol->root_ino);
 	vol->root_ino = NULL;
+
 	down_write(&vol->lcnbmp_lock);
 	iput(vol->lcnbmp_ino);
 	vol->lcnbmp_ino = NULL;
 	up_write(&vol->lcnbmp_lock);
+
 	iput(vol->mftmirr_ino);
 	vol->mftmirr_ino = NULL;
-	iput(vol->mft_ino);
-	vol->mft_ino = NULL;
+
 	down_write(&vol->mftbmp_lock);
-	/*
-	 * Clean up mft bitmap address space. Ignore the _inode_ bit in the
-	 * name of the function... FIXME: This destroys dirty pages!!! (AIA)
-	 */
-	truncate_inode_pages(&vol->mftbmp_mapping, 0);
-	vol->mftbmp_mapping.a_ops = NULL;
-	vol->mftbmp_mapping.host = NULL;
+	iput(vol->mftbmp_ino);
+	vol->mftbmp_ino = NULL;
 	up_write(&vol->mftbmp_lock);
-	down_write(&vol->mftbmp_rl.lock);
-	ntfs_free(vol->mftbmp_rl.rl);
-	vol->mftbmp_rl.rl = NULL;
-	up_write(&vol->mftbmp_rl.lock);
+
+	iput(vol->mft_ino);
+	vol->mft_ino = NULL;
+
 	vol->upcase_len = 0;
 	/*
 	 * Decrease the number of mounts and destroy the global default upcase
@@ -1242,60 +1122,41 @@
 static unsigned long __get_nr_free_mft_records(ntfs_volume *vol)
 {
 	struct address_space *mapping;
-	filler_t *readpage;
 	struct page *page;
 	unsigned long index, max_index, nr_free = 0;
 	unsigned int max_size, i;
 	u32 *b;
 
-	ntfs_debug("Entering.");
-	/* Serialize accesses to the inode bitmap. */
-	mapping = &vol->mftbmp_mapping;
-	readpage = (filler_t*)mapping->a_ops->readpage;
+	mapping = vol->mftbmp_ino->i_mapping;
 	/*
-	 * Convert the number of bits into bytes rounded up, then convert into
-	 * multiples of PAGE_CACHE_SIZE.
+	 * Convert the number of bits into bytes rounded up to a multiple of 8
+	 * bytes, then convert into multiples of PAGE_CACHE_SIZE.
 	 */
-	max_index = (vol->nr_mft_records + 7) >> (3 + PAGE_CACHE_SHIFT);
+	max_index = (((vol->nr_mft_records + 7) >> 3) + 7) >> PAGE_CACHE_SHIFT;
 	/* Use multiples of 4 bytes. */
 	max_size = PAGE_CACHE_SIZE >> 2;
 	ntfs_debug("Reading $MFT/$BITMAP, max_index = 0x%lx, max_size = "
 			"0x%x.", max_index, max_size);
 	for (index = 0UL; index < max_index;) {
 handle_partial_page:
-		/*
-		 * Read the page from page cache, getting it from backing store
-		 * if necessary, and increment the use count.
-		 */
-		page = read_cache_page(mapping, index++, (filler_t*)readpage,
-				vol);
-		/* Ignore pages which errored synchronously. */
+		page = ntfs_map_page(mapping, index++);
 		if (IS_ERR(page)) {
-			ntfs_debug("Sync read_cache_page() error. Skipping "
-					"page (index 0x%lx).", index - 1);
+			ntfs_debug("ntfs_map_page() error. Skipping page "
+					"(index 0x%lx).", index - 1);
 			continue;
 		}
-		wait_on_page_locked(page);
-		if (!PageUptodate(page)) {
-			ntfs_debug("Async read_cache_page() error. Skipping "
-					"page (index 0x%lx).", index - 1);
-			/* Ignore pages which errored asynchronously. */
-			page_cache_release(page);
-			continue;
-		}
-		b = (u32*)kmap(page);
+		b = (u32*)page_address(page);
 		/* For each 4 bytes, add up the number of zero bits. */
-	  	for (i = 0; i < max_size; i++)
+		for (i = 0; i < max_size; i++)
 			nr_free += 32 - hweight32(b[i]);
-		kunmap(page);
-		page_cache_release(page);
+		ntfs_unmap_page(page);
 	}
 	if (index == max_index) {
 		/*
 		 * Get the multiples of 4 bytes in use in the final partial
 		 * page.
 		 */
-		max_size = ((((vol->nr_mft_records + 7) >> 3) &
+		max_size = ((((((vol->nr_mft_records + 7) >> 3) + 7) & ~7) &
 				~PAGE_CACHE_MASK) + 3) >> 2;
 		/* If there is a partial page go back and do it. */
 		if (max_size) {
@@ -1309,7 +1170,6 @@
 	}
 	ntfs_debug("Finished reading $MFT/$BITMAP, last index = 0x%lx",
 			index - 1);
-	ntfs_debug("Exiting.");
 	return nr_free;
 }
 
@@ -1355,6 +1215,7 @@
 		size = 0LL;
 	/* Free blocks avail to non-superuser, same as above on NTFS. */
 	sfs->f_bavail = sfs->f_bfree = size;
+	/* Serialize accesses to the inode bitmap. */
 	down_read(&vol->mftbmp_lock);
 	/* Total file nodes in file system (at this moment in time). */
 	sfs->f_files  = vol->mft_ino->i_size >> vol->mft_record_size_bits;
@@ -1459,6 +1320,8 @@
 	vol->sb = sb;
 	vol->upcase = NULL;
 	vol->mft_ino = NULL;
+	vol->mftbmp_ino = NULL;
+	init_rwsem(&vol->mftbmp_lock);
 	vol->mftmirr_ino = NULL;
 	vol->lcnbmp_ino = NULL;
 	init_rwsem(&vol->lcnbmp_lock);
@@ -1470,37 +1333,10 @@
 	vol->on_errors = 0;
 	vol->mft_zone_multiplier = 0;
 	vol->nls_map = NULL;
-	init_rwsem(&vol->mftbmp_lock);
-	init_run_list(&vol->mftbmp_rl);
-
-	/* Initialize the mftbmp address space mapping.  */
-	INIT_RADIX_TREE(&vol->mftbmp_mapping.page_tree, GFP_ATOMIC);
-	rwlock_init(&vol->mftbmp_mapping.page_lock);
-	INIT_LIST_HEAD(&vol->mftbmp_mapping.clean_pages);
-	INIT_LIST_HEAD(&vol->mftbmp_mapping.dirty_pages);
-	INIT_LIST_HEAD(&vol->mftbmp_mapping.locked_pages);
-	INIT_LIST_HEAD(&vol->mftbmp_mapping.io_pages);
-	vol->mftbmp_mapping.nrpages = 0;
-	vol->mftbmp_mapping.a_ops = NULL;
-	vol->mftbmp_mapping.host = NULL;
-	INIT_LIST_HEAD(&vol->mftbmp_mapping.i_mmap);
-	INIT_LIST_HEAD(&vol->mftbmp_mapping.i_mmap_shared);
-	spin_lock_init(&vol->mftbmp_mapping.i_shared_lock);
-	/*
-	 * private_lock and private_list are unused by ntfs.  But they
-	 * are available.
-	 */
-	spin_lock_init(&vol->mftbmp_mapping.private_lock);
-	INIT_LIST_HEAD(&vol->mftbmp_mapping.private_list);
-	vol->mftbmp_mapping.assoc_mapping = NULL;
-	vol->mftbmp_mapping.dirtied_when = 0;
-	vol->mftbmp_mapping.gfp_mask = GFP_HIGHUSER;
-	vol->mftbmp_mapping.backing_dev_info =
-			sb->s_bdev->bd_inode->i_mapping->backing_dev_info;
 
 	/*
 	 * Default is group and other don't have any access to files or
-	 * directories while owner has full access. Further files by default
+	 * directories while owner has full access. Further, files by default
 	 * are not executable but directories are of course browseable.
 	 */
 	vol->fmask = 0177;
@@ -1509,7 +1345,7 @@
 	/* Important to get the mount options dealt with now. */
 	if (!parse_options(vol, (char*)opt))
 		goto err_out_now;
-	
+
 	/* We are just a read-only fs at the moment. */
 	sb->s_flags |= MS_RDONLY | MS_NOATIME | MS_NODIRATIME;
 
@@ -1667,11 +1503,8 @@
 	vol->lcnbmp_ino = NULL;
 	iput(vol->mftmirr_ino);
 	vol->mftmirr_ino = NULL;
-	truncate_inode_pages(&vol->mftbmp_mapping, 0);
-	vol->mftbmp_mapping.a_ops = NULL;
-	vol->mftbmp_mapping.host = NULL;
-	ntfs_free(vol->mftbmp_rl.rl);
-	vol->mftbmp_rl.rl = NULL;
+	iput(vol->mftbmp_ino);
+	vol->mftbmp_ino = NULL;
 	vol->upcase_len = 0;
 	if (vol->upcase != default_upcase)
 		ntfs_free(vol->upcase);
@@ -1708,7 +1541,8 @@
 	 * inode we have ever called ntfs_iget()/iput() on, otherwise we A)
 	 * leak resources and B) a subsequent mount fails automatically due to
 	 * ntfs_iget() never calling down into our ntfs_read_locked_inode()
-	 * method again...
+	 * method again... FIXME: Do we need to do this twice now because of
+	 * attribute inodes? I think not, so leave as is for now... (AIA)
 	 */
 	if (invalidate_inodes(sb)) {
 		ntfs_error(sb, "Busy inodes left. This is most likely a NTFS "
diff -Nru a/fs/ntfs/volume.h b/fs/ntfs/volume.h
--- a/fs/ntfs/volume.h	Mon Jul  8 21:55:49 2002
+++ b/fs/ntfs/volume.h	Mon Jul  8 21:55:49 2002
@@ -75,15 +75,13 @@
 	LCN mft_zone_start;		/* First cluster of the mft zone. */
 	LCN mft_zone_end;		/* First cluster beyond the mft zone. */
 	struct inode *mft_ino;		/* The VFS inode of $MFT. */
+
+	struct inode *mftbmp_ino;	/* Attribute inode for $MFT/$BITMAP. */
 	struct rw_semaphore mftbmp_lock; /* Lock for serializing accesses to the
 					    mft record bitmap ($MFT/$BITMAP). */
 	unsigned long nr_mft_records;	/* Number of mft records == number of
 					   bits in mft bitmap. */
-	struct address_space mftbmp_mapping; /* Page cache for $MFT/$BITMAP. */
-	run_list mftbmp_rl;		/* Run list for $MFT/$BITMAP. */
-	s64 mftbmp_size;		/* Data size of $MFT/$BITMAP. */
-	s64 mftbmp_initialized_size;	/* Initialized size of $MFT/$BITMAP. */
-	s64 mftbmp_allocated_size;	/* Allocated size of $MFT/$BITMAP. */
+
 	struct inode *mftmirr_ino;	/* The VFS inode of $MFTMirr. */
 	struct inode *lcnbmp_ino;	/* The VFS inode of $Bitmap. */
 	struct rw_semaphore lcnbmp_lock; /* Lock for serializing accesses to the
diff -Nru a/fs/ntfs/ChangeLog b/fs/ntfs/ChangeLog
--- a/fs/ntfs/ChangeLog	Mon Jul  8 21:55:50 2002
+++ b/fs/ntfs/ChangeLog	Mon Jul  8 21:55:50 2002
@@ -28,6 +28,7 @@
 
 	- Fix a stupid bug introduced in 2.0.15 where we were unmapping the
 	  wrong inode in fs/ntfs/inode.c::ntfs_attr_iget().
+	- Fix debugging check in fs/ntfs/aops.c::ntfs_read_block().
 	- Convert $MFT/$BITMAP access to attribute inode API and remove all
 	  remnants of the ugly mftbmp address space and operations hack. This
 	  means we finally have only one readpage function as well as only one
diff -Nru a/fs/ntfs/aops.c b/fs/ntfs/aops.c
--- a/fs/ntfs/aops.c	Mon Jul  8 21:55:50 2002
+++ b/fs/ntfs/aops.c	Mon Jul  8 21:55:50 2002
@@ -186,7 +186,7 @@
 	zblock = (ni->initialized_size + blocksize - 1) >> blocksize_bits;
 
 #ifdef DEBUG
-	if (unlikely(!ni->run_list.rl && !ni->mft_no))
+	if (unlikely(!ni->run_list.rl && !ni->mft_no && !NInoAttr(ni)))
 		panic("NTFS: $MFT/$DATA run list has been unmapped! This is a "
 				"very serious bug! Cannot continue...");
 #endif

===================================================================

This BitKeeper patch contains the following changesets:
aia21@cantab.net|ChangeSet|20020708205531|11668
aia21@cantab.net|ChangeSet|20020708203230|11662
## Wrapped with gzip_uu ##


begin 664 bkpatch3341
M'XL(`%;\*3T``\U:>W/:2!+_&SY%KW<O!8G!,Z,W.>>6!#NA\EB7[5SM7J6*
M$M((=!82I4=LWU'WV:]G1K)!!ML0>^_B%".DGNZ>Z=>O1_P,PT&OD2?I=S?R
MLU_=?!HE<3=/W3B;\=SM>LEL\6[JQA-^QO,%(X3AGT$MC1CF@II$MQ8>]2EU
M=<I]PG3;U)L_P]>,I[V&&[J,XK</29;W&IX;Y^ZX&_,<;YTF"=XZ*++T($N]
M@SR>-/'NB9M[4_C.TZS7H%WMYDY^/>>]QNG1^Z^?^J?-YN$AW*@$AX?-I]5>
M:OWKK;9U!A:QJ:432A>4FH;1'`#MFM0&P@Z(=4!L8+2GL9Y&7A':(P3J_."5
M`QW2?`M/J_:[I@=?SH_/>L"ZI$M-Z,"[),:]S,'U/)YE*`]^^7Q\?O#+V^'Y
MY_Z)^.[F>1J.BYQ#&"<^A_[)L(M\.G`<7H$+65[,0Q_&Q02?YVGB%Q[W\5*)
M,.!RRE,.E^(_CD4\<^?S,)Y`/N7(!>`R3>))R1IG!=E!G..'O-'U>CWQ;21T
M&(43GK?:2G:E]HJRMVM8HS.XL0\IGR7?.;A1)&7CUQCW/(,D$/I`,8FN81;D
MX]D<7-]/!;=L[GI<3D[F/'7S,(DSF+K>11?.IV$F^<PX6D6L,0ACY'V-SU%*
M$N-5$G,4X_IS=X*/B]@3#,`5U%$DQHI*,G*SZ]B#,`&T[CSBDA9M[$<\[<(?
M_/HGE,F%AC`.<]Q)"#.(DTOX9Y&A"6/%H[9VH3J2J<U!TP1I,H/O2=1YHU8Z
M0K*2009A`&&N["+,Y2+W=.9&N+"(=^'8O2BY9I`6XDZKTVM^!'1RDS5/;B.N
MV=GR7[-)7-)\`V\_+BH/$!_=Z8(Z%B$4_S3B&,Z"H*-K"SOP;5WSN!D0:@3&
M^$X`U;E448E!8FGZPG`(94K<(/&*&<=Y8K,/Q#JSZRSGLW)J?I6O48'0A640
MDULD8-P<^V-MC0J/X'RKEL:8O2".96JKNZ"V]%,R6:>%N?`#,W!<BLKP0+,"
M??-&W#*J":7,,NBJ4#>99UUOG40F;KJZQ:C/3<W%S=\LL>12VWIJF[:Y*JZ,
M]37RJ+X8>[X6V*9GVC[Q'(MMEE>QJ0DT=4.O"?R,?BSLL4ZBM0BX1\<&-:CN
M$VU\-SG?95.3R$R'L'5+7.?-U%@XANFB,.KQ8#RV`N^A)=YQ9Q/3>\UO,,#1
M^=9*U.@BT$R#!SK%O74UR[[';6[XU$1JYAVOR0I,D&O-R/2%RTU.R)AHW"7,
MMIW-$BLV:]?XF,HK_%HC"Y645.5U5BJO8?0TNK'RLN>MO*)J^AS+Y41406_*
MO8OENJ>"IBQ[HG",QE'B78BZI_*L_=1Y]EDSC&&(#&,3F_PI&<;0#81<CJ/9
M$@$^G($%-'S"(G#7/;<H`@(Q$@=K$Y8VZ;=,JP-&9F]T6_VYW/;KW'<13`1)
M6J)&X8FR4/T&G?12_D?'.GG$;N_@KD.F.Z`WE>1>LZ%@YT.@$Z]B?KD>NB*+
MMZ&<QU-$:^!%B-Z*.:*T>>1Z)32]08$*4@J\E\'X&HJLPJX-V"0"KW#9KM^5
M/G@G.DJ7VS'\[GK8YO`K'4K7'$TE0DK,+3R*4NAH?YY+*1Q2\ZD[B]O!A0:,
M@(:.9&/^;'YK_FCK\ZURPA_K?1J[M#Z-I^A\&D_3^#2>J.]I_'C;TWB2KJ>Q
M3=.S31RN`&T5AU8=D-P7A\^<V3TY-4HF,@IEK7Z&*!QJ!&@5.KL!H.5T6F'O
M6C;="MEOMF$=V9M48X9F2F2O3&BL'N8PJZ?I]UF0/J<%Q6D8QHRPG^H]-MBO
M6M8N212S9W,H/HY^/S_MC]X=?^J_/X-#Z`P$KAW]_>CT;/C;E\-O>RJ_?MM;
M,9>R:LU8VX#`S;:J@4!J,4*UA6$S1J2E+',+2Q&TE&,^BZU.5086Z5;DKF2<
M)9CJ,#5)3R^SDEC,/@K'?(^U`R[#?"IGN%F6>"':VD=.RQ.J'-MJJY2'.?V>
M;(J3>8P1500!3U5T58+%I+++D!WZ!A=2N[V+`VF.@:PQ>@R;`C7NR:#W'1Q(
MB]:RI]XS-K=SSQ9[&_+8^L9-MB1/OJ44^VB,2C4TL(JUBC@*+WATW?HI#CMO
MTB(>16&6=],(7KP`>0_M/<+2)[Y^&<9)'^MF*P[;[?9*O)88I!:P6QW4;+9O
M_:`&0]8AUL+4B:Y"UG;^'Y*K,+""=BIH-Z)]N`O4/H(Z=MI@\G('=K*Y1I71
MU=B0J%)$,3J=EZ1^Z_2H/]B'L9OQ$=KU]1JS3M>:]9&'4P^9M3PI,IE%$?`P
MLC"88^BJG]6W,.NS'<,<7<T3Q,]K;2;/F.ZUV72G'E;3@37YE>@XL6E("R\O
M'>AE38W5A]*(W\-]Z)^?GX[._S@Y.I/ON?:;C4:!L"T=Y<C!G?%]*#0&XFH4
M\;AF='4$7K/Y-J?KFTU>.UTO:Z^I6Y8M+:ZS+6OO_[;R"A]0KP8V^(!:[RYA
M:PGTNVR5\IBS9I:MSE`WVZ5VAEK!5\HTJD*14FT+R^@.=!B6[.<PSE.\R?OA
M=E:\?=O87CZJMT0&]W:7ZUK+AS).:<6=W,T24'U@V4P-AAILP+H\L$T*3$,T
M;VN@-QL'+^$]6GEI_;4%=^'E0;-17]YA/856!.*I2%DC9<Q]^/+UTZ=]()B6
M)$89GHV.3D];-7[M-OP;TYKDR=,T25O9>!_VCEW<*5]X0I2X?LU+*C6[>\A[
M8-LF,*LY<)@F"J0:&HU)@I/#>9%7D8[<1TF1XPS'D%V-&I8I(R]>I:2$Z++J
MJG&9%M>Q0EB69S7>1\A*0O80H4X5H1R7"=,DR5<H#:(HY;A,F7%OE;"4+<<Z
M14]0F*50.=Z1IDBTDD2K2)8T5Q1&26%4%*L[VY,/,0,UUQBHA^Z"=^\XRFLQ
M27KT-WEE55>.?G-EEE=H+WDUP"L-Q8@[^LT=$RQQAS)\LDG6&K\7_BQVD5(=
MXT<PL'#\5F-1G[\R6<AGNHQ*R@PJV3!#NE9U2'A83RB=-^&H?/A:3C/E@IAA
M"?7AY4TJE86NF(VQ@<2$.!8]81BC)XRO<W&&E12QCR%5S&5^A5D1Y2'VB8+6
MEGPDW;Y@$V,/J7A*!A6I3+0G_?='HW?]=Q^.1F?#?QQUI4K*K=2(*[E"O7U^
MA6MIM=3&Q.D25LW@%5AM>/,&M/;-Y3+?#\/C<[E64YD*`:5T;'FJ6"8@`7]E
M!USNS3Y(F:]>M>5,2U>[9!EBE\H$(_NVUM[J_#;(O-.%LXM0F4"*V1.S&HV]
MEEH*N?I+=-7N[I5BH`.T%&2#(P39IE1Q+!:-J.QE6W`9E66H);XH>MM6>V6K
MY",.PULA3B*O(82_@MB\+/P7QV^X%#'!(6HECDH#4GF%_J7ZMYR=DK.C.%><
ME!4>:8@7\!_Q*?L-IOH-0P2:J!9G/`W=2'`L2Z"LU,+K5'U45416C2'51;'9
M'$6-,`Y1B\N,SUHOEHE$\RR7HUN:3.O4("K?J%$XJA^B^@A)0M3@<BI.`Y/+
M&+U^BE4W*,0YL]2O"\=%*LY3]F7=E2]R?!ZXZ,V";;D^-8K`-!&L&7C'E+ZS
M0V+`UD>R%*,*381(T\0'=^*&<;>+"@U__WS4@T$B3L]CKBJ<+S81@45^&7H*
MJHZYYQ:9"$W)I5:7L[_!4,R(+Y`XWX<,BR07)_`"=&3R]0HR$>):_6%_M<&O
MWNO7\.=V/QO8#$#K/QNH$*AAZE0=XM!MFD$-.L^#/LO6((G\M6_\!-+#R,4L
M&80<:<26+KT=E%9`+JTEQQ"H3OTX8@.JJ[9FET;2$JD>"\UJFW@K_;4(SWX-
IK@JEEW&3#,P!(D/T<5L5RIM?4<ICK*R8'1J::[(QKN*_PHSX,?TI````
`
end
