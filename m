Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315218AbSF3PFn>; Sun, 30 Jun 2002 11:05:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315222AbSF3PFm>; Sun, 30 Jun 2002 11:05:42 -0400
Received: from mole.bio.cam.ac.uk ([131.111.36.9]:32274 "EHLO
	mole.bio.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S315218AbSF3PFd>; Sun, 30 Jun 2002 11:05:33 -0400
Subject: [BK-PATCH-2.5] NTFS: 2.0.12 - Initial cleanup of address space operations following 2.0.11 changes.
To: torvalds@transmeta.com (Linus Torvalds)
Date: Sun, 30 Jun 2002 16:07:20 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (Linux Kernel)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17OgIK-0003v8-00@storm.christs.cam.ac.uk>
From: Anton Altaparmakov <aia21@cantab.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please do a

	bk pull http://linux-ntfs.bkbits.net/ntfs-tng-2.5

As noted in previous post, the above url also contains ntfs 2.0.13...

Thanks!

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/, http://www-stu.christs.cam.ac.uk/~aia21/

This will update the following files:

 Documentation/filesystems/ntfs.txt |    3 
 fs/ntfs/ChangeLog                  |   24 +-
 fs/ntfs/Makefile                   |    2 
 fs/ntfs/aops.c                     |  412 ++++++++++---------------------------
 fs/ntfs/mft.c                      |    2 
 5 files changed, 139 insertions(+), 304 deletions(-)

through these ChangeSets:

<aia21@cantab.net> (02/06/26 1.603.1.2)
   NTFS: 2.0.12 - Initial cleanup of address space operations following 2.0.11 changes.
   - Merge fs/ntfs/aops.c::end_buffer_read_mst_async() and
     fs/ntfs/aops.c::end_buffer_read_file_async() into one function
     fs/ntfs/aops.c::end_buffer_read_attr_async() using NInoMstProtected()
     to determine whether to apply mst fixups or not.
   - Above change allows merging fs/ntfs/aops.c::ntfs_file_read_block()
     and fs/ntfs/aops.c::ntfs_mst_readpage() into one function
     fs/ntfs/aops.c::ntfs_attr_read_block(). Also, create a tiny wrapper
     fs/ntfs/aops.c::ntfs_mst_readpage() to transform the parameters from
     the VFS readpage function prototype to the ntfs_attr_read_block()
     function prototype.


diff -Nru a/Documentation/filesystems/ntfs.txt b/Documentation/filesystems/ntfs.txt
--- a/Documentation/filesystems/ntfs.txt	Sun Jun 30 13:42:23 2002
+++ b/Documentation/filesystems/ntfs.txt	Sun Jun 30 13:42:23 2002
@@ -247,6 +247,9 @@
 
 Note, a technical ChangeLog aimed at kernel hackers is in fs/ntfs/ChangeLog.
 
+2.0.12:
+	- Internal cleanups in address space operations made possible by the
+	  changes introduced in the previous release.
 2.0.11:
 	- Internal updates and cleanups introducing the first step towards
 	  fake inode based attribute i/o.
diff -Nru a/fs/ntfs/ChangeLog b/fs/ntfs/ChangeLog
--- a/fs/ntfs/ChangeLog	Sun Jun 30 13:42:23 2002
+++ b/fs/ntfs/ChangeLog	Sun Jun 30 13:42:23 2002
@@ -6,7 +6,7 @@
 	  user open()s a file with i_size > s_maxbytes? Should read_inode()
 	  truncate the visible i_size? Will the user just get -E2BIG (or
 	  whatever) on open()? Or will (s)he be able to open() but lseek() and
-	  read() will fail when s_maxbytes is reached? -> Investigate this!
+	  read() will fail when s_maxbytes is reached? -> Investigate this.
 	- Implement/allow non-resident index bitmaps in dir.c::ntfs_readdir()
 	  and then also consider initialized_size w.r.t. the bitmaps, etc.
 	- vcn_to_lcn() should somehow return the correct pointer within the
@@ -17,13 +17,27 @@
 	- Consider if ntfs_file_read_compressed_block() shouldn't be coping
 	  with initialized_size < data_size. I don't think it can happen but
 	  it requires more careful consideration.
-	- CLEANUP: Modularise and reuse code in aops.c. At the moment we have
-	  several copies of almost identicall functions and the functions are
-	  quite big. Modularising them a bit, e.g. a-la get_block(), will make
-	  them cleaner and make code reuse easier.
+	- CLEANUP: At the moment we have two copies of almost identical
+	  functions in aops.c, can merge them once fake inode address space
+	  based attribute i/o is further developed.
+	- CLEANUP: Modularising code in aops.c a bit, e.g. a-la get_block(),
+	  will be cleaner and make code reuse easier.
 	- Enable NFS exporting of NTFS.
 	- Use iget5_locked() and friends instead of conventional iget().
 	- Use fake inodes for address space i/o.
+
+2.0.12 - Initial cleanup of address space operations following 2.0.11 changes.
+
+	- Merge fs/ntfs/aops.c::end_buffer_read_mst_async() and
+	  fs/ntfs/aops.c::end_buffer_read_file_async() into one function
+	  fs/ntfs/aops.c::end_buffer_read_attr_async() using NInoMstProtected()
+	  to determine whether to apply mst fixups or not.
+	- Above change allows merging fs/ntfs/aops.c::ntfs_file_read_block()
+	  and fs/ntfs/aops.c::ntfs_mst_readpage() into one function
+	  fs/ntfs/aops.c::ntfs_attr_read_block(). Also, create a tiny wrapper
+	  fs/ntfs/aops.c::ntfs_mst_readpage() to transform the parameters from
+	  the VFS readpage function prototype to the ntfs_attr_read_block()
+	  function prototype.
 
 2.0.11 - Initial preparations for fake inode based attribute i/o.
 
diff -Nru a/fs/ntfs/Makefile b/fs/ntfs/Makefile
--- a/fs/ntfs/Makefile	Sun Jun 30 13:42:23 2002
+++ b/fs/ntfs/Makefile	Sun Jun 30 13:42:23 2002
@@ -5,7 +5,7 @@
 ntfs-objs := aops.o attrib.o compress.o debug.o dir.o file.o inode.o mft.o \
 	     mst.o namei.o super.o sysctl.o time.o unistr.o upcase.o
 
-EXTRA_CFLAGS = -DNTFS_VERSION=\"2.0.11\"
+EXTRA_CFLAGS = -DNTFS_VERSION=\"2.0.12\"
 
 ifeq ($(CONFIG_NTFS_DEBUG),y)
 EXTRA_CFLAGS += -DDEBUG
diff -Nru a/fs/ntfs/aops.c b/fs/ntfs/aops.c
--- a/fs/ntfs/aops.c	Sun Jun 30 13:42:23 2002
+++ b/fs/ntfs/aops.c	Sun Jun 30 13:42:23 2002
@@ -3,7 +3,7 @@
  * 	    Part of the Linux-NTFS project.
  *
  * Copyright (c) 2001,2002 Anton Altaparmakov.
- * Copyright (C) 2002 Richard Russon.
+ * Copyright (c) 2002 Richard Russon.
  *
  * This program/include file is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License as published
@@ -30,31 +30,43 @@
 #include "ntfs.h"
 
 /**
- * end_buffer_read_file_async -
+ * end_buffer_read_attr_async - async io completion for reading attributes
+ * @bh:		buffer head on which io is completed
+ * @uptodate:	whether @bh is now uptodate or not
  *
- * Async io completion handler for accessing files. Adapted from
- * end_buffer_read_mst_async().
+ * Asynchronous I/O completion handler for reading pages belonging to the
+ * attribute address space of an inode. The inodes can either be files or
+ * directories or they can be fake inodes describing some attribute.
+ *
+ * If NInoMstProtected(), perform the post read mst fixups when all IO on the
+ * page has been completed and mark the page uptodate or set the error bit on
+ * the page. To determine the size of the records that need fixing up, we cheat
+ * a little bit by setting the index_block_size in ntfs_inode to the ntfs
+ * record size, and index_block_size_bits, to the log(base 2) of the ntfs
+ * record size.
  */
-static void end_buffer_read_file_async(struct buffer_head *bh, int uptodate)
+static void end_buffer_read_attr_async(struct buffer_head *bh, int uptodate)
 {
 	static spinlock_t page_uptodate_lock = SPIN_LOCK_UNLOCKED;
 	unsigned long flags;
 	struct buffer_head *tmp;
 	struct page *page;
+	ntfs_inode *ni;
 
-	if (uptodate)
+	if (likely(uptodate))
 		set_buffer_uptodate(bh);
 	else
 		clear_buffer_uptodate(bh);
 
 	page = bh->b_page;
 
+	ni = NTFS_I(page->mapping->host);
+
 	if (likely(uptodate)) {
 		s64 file_ofs;
 
-		ntfs_inode *ni = NTFS_I(page->mapping->host);
-
 		file_ofs = (page->index << PAGE_CACHE_SHIFT) + bh_offset(bh);
+		/* Check for the current buffer head overflowing. */
 		if (file_ofs + bh->b_size > ni->initialized_size) {
 			char *addr;
 			int ofs = 0;
@@ -82,10 +94,47 @@
 			SetPageError(page);
 		tmp = tmp->b_this_page;
 	}
-
 	spin_unlock_irqrestore(&page_uptodate_lock, flags);
-	if (!PageError(page))
-		SetPageUptodate(page);
+	/*
+	 * If none of the buffers had errors then we can set the page uptodate,
+	 * but we first have to perform the post read mst fixups, if the
+	 * attribute is mst protected, i.e. if NInoMstProteced(ni) is true.
+	 */
+	if (!NInoMstProtected(ni)) {
+		if (likely(!PageError(page)))
+			SetPageUptodate(page);
+		unlock_page(page);
+		return;
+	} else {
+		char *addr;
+		unsigned int i, recs, nr_err;
+		u32 rec_size;
+
+		rec_size = ni->_IDM(index_block_size);
+		recs = PAGE_CACHE_SIZE / rec_size;
+		addr = kmap_atomic(page, KM_BIO_SRC_IRQ);
+		for (i = nr_err = 0; i < recs; i++) {
+			if (likely(!post_read_mst_fixup((NTFS_RECORD*)(addr +
+					i * rec_size), rec_size)))
+				continue;
+			nr_err++;
+			ntfs_error(ni->vol->sb, "post_read_mst_fixup() failed, "
+					"corrupt %s record 0x%Lx. Run chkdsk.",
+					ni->mft_no ? "index" : "mft",
+					(long long)(((s64)page->index <<
+					PAGE_CACHE_SHIFT >>
+					ni->_IDM(index_block_size_bits)) + i));
+		}
+		flush_dcache_page(page);
+		kunmap_atomic(addr, KM_BIO_SRC_IRQ);
+		if (likely(!nr_err && recs))
+			SetPageUptodate(page);
+		else {
+			ntfs_error(ni->vol->sb, "Setting page error, index "
+					"0x%lx.", page->index);
+			SetPageError(page);
+		}
+	}
 	unlock_page(page);
 	return;
 still_busy:
@@ -94,11 +143,20 @@
 }
 
 /**
- * ntfs_file_read_block -
+ * ntfs_attr_read_block - fill a @page of an address space with data
+ * @page:	page cache page to fill with data
  *
- * NTFS version of block_read_full_page(). Adapted from ntfs_mst_readpage().
+ * Fill the page @page of the address space belonging to the @page->host inode.
+ * We read each buffer asynchronously and when all buffers are read in, our io
+ * completion handler end_buffer_read_attr_async(), if required, automatically
+ * applies the mst fixups to the page before finally marking it uptodate and
+ * unlocking it.
+ *
+ * Return 0 on success and -errno on error.
+ *
+ * Contains an adapted version of fs/buffer.c::block_read_full_page().
  */
-static int ntfs_file_read_block(struct page *page)
+static int ntfs_attr_read_block(struct page *page)
 {
 	VCN vcn;
 	LCN lcn;
@@ -119,7 +177,7 @@
 	if (!page_has_buffers(page))
 		create_empty_buffers(page, blocksize, 0);
 	bh = head = page_buffers(page);
-	if (!bh)
+	if (unlikely(!bh))
 		return -ENOMEM;
 
 	blocks = PAGE_CACHE_SIZE >> blocksize_bits;
@@ -128,11 +186,9 @@
 	zblock = (ni->initialized_size + blocksize - 1) >> blocksize_bits;
 
 #ifdef DEBUG
-	if (unlikely(!ni->mft_no)) {
-		ntfs_error(vol->sb, "NTFS: Attempt to access $MFT! This is a "
-				"very serious bug! Denying access...");
-		return -EACCES;
-	}
+	if (unlikely(!ni->run_list.rl && !ni->mft_no))
+		panic("NTFS: $MFT/$DATA run list has been unmapped! This is a "
+				"very serious bug! Cannot continue...");
 #endif
 
 	/* Loop through all the buffers in the page. */
@@ -211,7 +267,7 @@
 		for (i = 0; i < nr; i++) {
 			struct buffer_head *tbh = arr[i];
 			lock_buffer(tbh);
-			tbh->b_end_io = end_buffer_read_file_async;
+			tbh->b_end_io = end_buffer_read_attr_async;
 			set_buffer_async_read(tbh);
 		}
 		/* Finally, start i/o on the buffers. */
@@ -220,7 +276,7 @@
 		return 0;
 	}
 	/* No i/o was scheduled on any of the buffers. */
-	if (!PageError(page))
+	if (likely(!PageError(page)))
 		SetPageUptodate(page);
 	else /* Signal synchronous i/o error. */
 		nr = -EIO;
@@ -234,17 +290,17 @@
  * @page:	page cache page to fill with data
  *
  * For non-resident attributes, ntfs_file_readpage() fills the @page of the open
- * file @file by calling the generic block_read_full_page() function provided by
- * the kernel which in turn invokes our ntfs_file_get_block() callback in order
- * to create and read in the buffers associated with the page asynchronously.
+ * file @file by calling the ntfs version of the generic block_read_full_page()
+ * function provided by the kernel, ntfs_attr_read_block(), which in turn
+ * creates and reads in the buffers associated with the page asynchronously.
  *
  * For resident attributes, OTOH, ntfs_file_readpage() fills @page by copying
  * the data from the mft record (which at this stage is most likely in memory)
- * and fills the remainder with zeroes. Thus, in this case I/O is synchronous,
+ * and fills the remainder with zeroes. Thus, in this case, I/O is synchronous,
  * as even if the mft record is not cached at this point in time, we need to
  * wait for it to be read in before we can do the copy.
  *
- * Return zero on success or -errno on error.
+ * Return 0 on success or -errno on error.
  */
 static int ntfs_file_readpage(struct file *file, struct page *page)
 {
@@ -256,43 +312,43 @@
 	u32 attr_len;
 	int err = 0;
 
-	if (!PageLocked(page))
+	if (unlikely(!PageLocked(page)))
 		PAGE_BUG(page);
 
 	ni = NTFS_I(page->mapping->host);
 
 	/* Is the unnamed $DATA attribute resident? */
-	if (test_bit(NI_NonResident, &ni->state)) {
+	if (NInoNonResident(ni)) {
 		/* Attribute is not resident. */
 
 		/* If the file is encrypted, we deny access, just like NT4. */
-		if (test_bit(NI_Encrypted, &ni->state)) {
+		if (NInoEncrypted(ni)) {
 			err = -EACCES;
 			goto unl_err_out;
 		}
 		/* Compressed data stream. Handled in compress.c. */
-		if (test_bit(NI_Compressed, &ni->state))
+		if (NInoCompressed(ni))
 			return ntfs_file_read_compressed_block(page);
 		/* Normal data stream. */
-		return ntfs_file_read_block(page);
+		return ntfs_attr_read_block(page);
 	}
 	/* Attribute is resident, implying it is not compressed or encrypted. */
 
 	/* Map, pin and lock the mft record for reading. */
 	mrec = map_mft_record(READ, ni);
-	if (IS_ERR(mrec)) {
+	if (unlikely(IS_ERR(mrec))) {
 		err = PTR_ERR(mrec);
 		goto unl_err_out;
 	}
 
 	ctx = get_attr_search_ctx(ni, mrec);
-	if (!ctx) {
+	if (unlikely(!ctx)) {
 		err = -ENOMEM;
 		goto unm_unl_err_out;
 	}
 
 	/* Find the data attribute in the mft record. */
-	if (!lookup_attr(AT_DATA, NULL, 0, 0, 0, NULL, 0, ctx)) {
+	if (unlikely(!lookup_attr(AT_DATA, NULL, 0, 0, 0, NULL, 0, ctx))) {
 		err = -ENOENT;
 		goto put_unm_unl_err_out;
 	}
@@ -331,6 +387,25 @@
 }
 
 /**
+ * ntfs_mst_readpage - fill a @page of the mft or a directory with data
+ * @file:	open file/directory to which the @page belongs or NULL
+ * @page:	page cache page to fill with data
+ *
+ * Readpage method for the VFS address space operations of directory inodes
+ * and the $MFT/$DATA attribute.
+ *
+ * We just call ntfs_attr_read_block() here, in fact we only need this wrapper
+ * because of the difference in function parameters.
+ */
+int ntfs_mst_readpage(struct file *file, struct page *page)
+{
+	if (unlikely(!PageLocked(page)))
+		PAGE_BUG(page);
+
+	return ntfs_attr_read_block(page);
+}
+
+/**
  * end_buffer_read_mftbmp_async -
  *
  * Async io completion handler for accessing mft bitmap. Adapted from
@@ -343,7 +418,7 @@
 	struct buffer_head *tmp;
 	struct page *page;
 
-	if (uptodate)
+	if (likely(uptodate))
 		set_buffer_uptodate(bh);
 	else
 		clear_buffer_uptodate(bh);
@@ -386,7 +461,7 @@
 	}
 
 	spin_unlock_irqrestore(&page_uptodate_lock, flags);
-	if (!PageError(page))
+	if (likely(!PageError(page)))
 		SetPageUptodate(page);
 	unlock_page(page);
 	return;
@@ -410,7 +485,7 @@
 	int nr, i;
 	unsigned char blocksize_bits;
 
-	if (!PageLocked(page))
+	if (unlikely(!PageLocked(page)))
 		PAGE_BUG(page);
 
 	blocksize = vol->sb->s_blocksize;
@@ -419,7 +494,7 @@
 	if (!page_has_buffers(page))
 		create_empty_buffers(page, blocksize, 0);
 	bh = head = page_buffers(page);
-	if (!bh)
+	if (unlikely(!bh))
 		return -ENOMEM;
 
 	blocks = PAGE_CACHE_SIZE >> blocksize_bits;
@@ -503,264 +578,7 @@
 		return 0;
 	}
 	/* No i/o was scheduled on any of the buffers. */
-	if (!PageError(page))
-		SetPageUptodate(page);
-	else /* Signal synchronous i/o error. */
-		nr = -EIO;
-	unlock_page(page);
-	return nr;
-}
-
-/**
- * end_buffer_read_mst_async - async io completion for reading index records
- * @bh:		buffer head on which io is completed
- * @uptodate:	whether @bh is now uptodate or not
- *
- * Asynchronous I/O completion handler for reading pages belonging to the
- * index allocation attribute address space of directory inodes.
- *
- * Perform the post read mst fixups when all IO on the page has been completed
- * and marks the page uptodate or sets the error bit on the page.
- *
- * Adapted from fs/buffer.c.
- *
- * NOTE: We use this function as async io completion handler for reading pages
- * belonging to the mft data attribute address space, too as this saves
- * duplicating an almost identical function. We do this by cheating a little
- * bit in setting the index_block_size in the mft ntfs_inode to the mft record
- * size of the volume (vol->mft_record_size), and index_block_size_bits to
- * mft_record_size_bits, respectively.
- */
-static void end_buffer_read_mst_async(struct buffer_head *bh, int uptodate)
-{
-	static spinlock_t page_uptodate_lock = SPIN_LOCK_UNLOCKED;
-	unsigned long flags;
-	struct buffer_head *tmp;
-	struct page *page;
-	ntfs_inode *ni;
-
-	if (uptodate)
-		set_buffer_uptodate(bh);
-	else
-		clear_buffer_uptodate(bh);
-
-	page = bh->b_page;
-
-	ni = NTFS_I(page->mapping->host);
-
-	if (likely(uptodate)) {
-		s64 file_ofs;
-
-		file_ofs = (page->index << PAGE_CACHE_SHIFT) + bh_offset(bh);
-		/* Check for the current buffer head overflowing. */
-		if (file_ofs + bh->b_size > ni->initialized_size) {
-			char *addr;
-			int ofs = 0;
-
-			if (file_ofs < ni->initialized_size)
-				ofs = ni->initialized_size - file_ofs;
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
-	/*
-	 * If none of the buffers had errors then we can set the page uptodate,
-	 * but we first have to perform the post read mst fixups.
-	 */
-	if (!PageError(page)) {
-		char *addr;
-		unsigned int i, recs, nr_err = 0;
-		u32 rec_size;
-
-		rec_size = ni->_IDM(index_block_size);
-		recs = PAGE_CACHE_SIZE / rec_size;
-		addr = kmap_atomic(page, KM_BIO_SRC_IRQ);
-		for (i = 0; i < recs; i++) {
-			if (!post_read_mst_fixup((NTFS_RECORD*)(addr +
-					i * rec_size), rec_size))
-				continue;
-			nr_err++;
-			ntfs_error(ni->vol->sb, "post_read_mst_fixup() failed, "
-					"corrupt %s record 0x%Lx. Run chkdsk.",
-					ni->mft_no ? "index" : "mft",
-					(long long)((page->index <<
-					PAGE_CACHE_SHIFT >>
-					ni->_IDM(index_block_size_bits)) + i));
-		}
-		flush_dcache_page(page);
-		kunmap_atomic(addr, KM_BIO_SRC_IRQ);
-		if (likely(!nr_err && recs))
-			SetPageUptodate(page);
-		else {
-			ntfs_error(ni->vol->sb, "Setting page error, index "
-					"0x%lx.", page->index);
-			SetPageError(page);
-		}
-	}
-	unlock_page(page);
-	return;
-still_busy:
-	spin_unlock_irqrestore(&page_uptodate_lock, flags);
-	return;
-}
-
-/**
- * ntfs_mst_readpage - fill a @page of the mft or a directory with data
- * @file:	open file/directory to which the page @page belongs or NULL
- * @page:	page cache page to fill with data
- *
- * Readpage method for the VFS address space operations.
- *
- * Fill the page @page of the $MFT or the open directory @dir. We read each
- * buffer asynchronously and when all buffers are read in our io completion
- * handler end_buffer_read_mst_async() automatically applies the mst fixups to
- * the page before finally marking it uptodate and unlocking it.
- *
- * Contains an adapted version of fs/buffer.c::block_read_full_page().
- */
-int ntfs_mst_readpage(struct file *dir, struct page *page)
-{
-	VCN vcn;
-	LCN lcn;
-	ntfs_inode *ni;
-	ntfs_volume *vol;
-	struct buffer_head *bh, *head, *arr[MAX_BUF_PER_PAGE];
-	sector_t iblock, lblock, zblock;
-	unsigned int blocksize, blocks, vcn_ofs;
-	int i, nr;
-	unsigned char blocksize_bits;
-
-	if (!PageLocked(page))
-		PAGE_BUG(page);
-
-	ni = NTFS_I(page->mapping->host);
-	vol = ni->vol;
-
-	blocksize_bits = VFS_I(ni)->i_blkbits;
-	blocksize = 1 << blocksize_bits;
-
-	if (!page_has_buffers(page))
-		create_empty_buffers(page, blocksize, 0);
-	bh = head = page_buffers(page);
-	if (!bh)
-		return -ENOMEM;
-
-	blocks = PAGE_CACHE_SIZE >> blocksize_bits;
-	iblock = page->index << (PAGE_CACHE_SHIFT - blocksize_bits);
-	lblock = (ni->allocated_size + blocksize - 1) >> blocksize_bits;
-	zblock = (ni->initialized_size + blocksize - 1) >> blocksize_bits;
-
-#ifdef DEBUG
-	if (unlikely(!ni->run_list.rl && !ni->mft_no))
-		panic("NTFS: $MFT/$DATA run list has been unmapped! This is a "
-				"very serious bug! Cannot continue...");
-#endif
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
-			BOOL is_retry = FALSE;
-
-			/* Convert iblock into corresponding vcn and offset. */
-			vcn = (VCN)iblock << blocksize_bits >>
-					vol->cluster_size_bits;
-			vcn_ofs = ((VCN)iblock << blocksize_bits) &
-					vol->cluster_size_mask;
-retry_remap:
-			/* Convert the vcn to the corresponding lcn. */
-			down_read(&ni->run_list.lock);
-			lcn = vcn_to_lcn(ni->run_list.rl, vcn);
-			up_read(&ni->run_list.lock);
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
-			/* It is a hole, need to zero it. */
-			if (lcn == LCN_HOLE)
-				goto handle_hole;
-			/* If first try and run list unmapped, map and retry. */
-			if (!is_retry && lcn == LCN_RL_NOT_MAPPED) {
-				is_retry = TRUE;
-				if (!map_run_list(ni, vcn))
-					goto retry_remap;
-			}
-			/* Hard error, zero out region. */
-			SetPageError(page);
-			ntfs_error(vol->sb, "vcn_to_lcn(vcn = 0x%Lx) failed "
-					"with error code 0x%Lx%s.",
-					(long long)vcn, (long long)-lcn,
-					is_retry ? " even after retrying" : "");
-			// FIXME: Depending on vol->on_errors, do something.
-		}
-		/*
-		 * Either iblock was outside lblock limits or vcn_to_lcn()
-		 * returned error. Just zero that portion of the page and set
-		 * the buffer uptodate.
-		 */
-handle_hole:
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
-			tbh->b_end_io = end_buffer_read_mst_async;
-			set_buffer_async_read(tbh);
-		}
-		/* Finally, start i/o on the buffers. */
-		for (i = 0; i < nr; i++)
-			submit_bh(READ, arr[i]);
-		return 0;
-	}
-	/* No i/o was scheduled on any of the buffers. */
-	if (!PageError(page))
+	if (likely(!PageError(page)))
 		SetPageUptodate(page);
 	else /* Signal synchronous i/o error. */
 		nr = -EIO;
diff -Nru a/fs/ntfs/mft.c b/fs/ntfs/mft.c
--- a/fs/ntfs/mft.c	Sun Jun 30 13:42:23 2002
+++ b/fs/ntfs/mft.c	Sun Jun 30 13:42:23 2002
@@ -102,7 +102,7 @@
  * ntfs_mft_aops - address space operations for access to $MFT
  *
  * Address space operations for access to $MFT. This allows us to simply use
- * read_cache_page() in map_mft_record().
+ * ntfs_map_page() in map_mft_record_page().
  */
 struct address_space_operations ntfs_mft_aops = {
 	writepage:	NULL,			/* Write dirty page to disk. */

===================================================================

This BitKeeper patch contains the following changesets:
aia21@cantab.net|ChangeSet|20020630123723|51720
aia21@cantab.net|ChangeSet|20020630122953|51720
aia21@cantab.net|ChangeSet|20020626113015|50155
## Wrapped with gzip_uu ##


begin 664 bkpatch13430
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
6,S:130^M=LLP=8<K_P$K'!H<:2X`````
`
end
