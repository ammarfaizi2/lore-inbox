Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261898AbUKJOAD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261898AbUKJOAD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 09:00:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261905AbUKJN7X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 08:59:23 -0500
Received: from ppsw-3.csi.cam.ac.uk ([131.111.8.133]:17634 "EHLO
	ppsw-3.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S261928AbUKJNqB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 08:46:01 -0500
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-ntfs-dev@lists.sourceforge.net
Subject: [PATCH 26/26] NTFS 2.1.22 - Bug and race fixes and improved error handling.
Message-Id: <E1CRsnI-0006TW-Dr@imp.csi.cam.ac.uk>
Date: Wed, 10 Nov 2004 13:45:52 +0000
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is patch 26/26 in the series.  It contains the following ChangeSet:

<aia21@cantab.net> (04/11/10 1.2026.1.66)
   NTFS: 2.1.22 - Many bug and race fixes and error handling improvements.
   
   - Cleanup fs/ntfs/aops.c::ntfs_{read,write}page() since we know that a
     resident attribute will be smaller than a page which makes the code
     simpler.  Also make the code more tolerant to concurrent ->truncate.
   
   Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/, http://www-stu.christs.cam.ac.uk/~aia21/

===================================================================

diff -Nru a/Documentation/filesystems/ntfs.txt b/Documentation/filesystems/ntfs.txt
--- a/Documentation/filesystems/ntfs.txt	2004-11-10 13:45:56 +00:00
+++ b/Documentation/filesystems/ntfs.txt	2004-11-10 13:45:56 +00:00
@@ -432,6 +432,9 @@
 
 Note, a technical ChangeLog aimed at kernel hackers is in fs/ntfs/ChangeLog.
 
+2.1.22:
+	- Improve handling of ntfs volumes with errors.
+	- Fix various bugs and race conditions.
 2.1.21:
 	- Fix several race conditions and various other bugs.
 	- Many internal cleanups, code reorganization, optimizations, and mft
diff -Nru a/fs/ntfs/ChangeLog b/fs/ntfs/ChangeLog
--- a/fs/ntfs/ChangeLog	2004-11-10 13:45:56 +00:00
+++ b/fs/ntfs/ChangeLog	2004-11-10 13:45:56 +00:00
@@ -25,7 +25,7 @@
 	- Enable the code for setting the NT4 compatibility flag when we start
 	  making NTFS 1.2 specific modifications.
 
-2.1.22-WIP
+2.1.22 - Many bug and race fixes and error handling improvements.
 
 	- Improve error handling in fs/ntfs/inode.c::ntfs_truncate().
 	- Change fs/ntfs/inode.c::ntfs_truncate() to return an error code
@@ -85,6 +85,9 @@
 	  complete runlist for the mft mirror is always mapped into memory.
 	- Add creation of buffers to fs/ntfs/mft.c::ntfs_sync_mft_mirror().
 	- Improve error handling in fs/ntfs/aops.c::ntfs_{read,write}_block().
+	- Cleanup fs/ntfs/aops.c::ntfs_{read,write}page() since we know that a
+	  resident attribute will be smaller than a page which makes the code
+	  simpler.  Also make the code more tolerant to concurrent ->truncate.
 
 2.1.21 - Fix some races and bugs, rewrite mft write code, add mft allocator.
 
diff -Nru a/fs/ntfs/Makefile b/fs/ntfs/Makefile
--- a/fs/ntfs/Makefile	2004-11-10 13:45:56 +00:00
+++ b/fs/ntfs/Makefile	2004-11-10 13:45:56 +00:00
@@ -6,7 +6,7 @@
 	     index.o inode.o mft.o mst.o namei.o runlist.o super.o sysctl.o \
 	     unistr.o upcase.o
 
-EXTRA_CFLAGS = -DNTFS_VERSION=\"2.1.22-WIP\"
+EXTRA_CFLAGS = -DNTFS_VERSION=\"2.1.22\"
 
 ifeq ($(CONFIG_NTFS_DEBUG),y)
 EXTRA_CFLAGS += -DDEBUG
diff -Nru a/fs/ntfs/aops.c b/fs/ntfs/aops.c
--- a/fs/ntfs/aops.c	2004-11-10 13:45:56 +00:00
+++ b/fs/ntfs/aops.c	2004-11-10 13:45:56 +00:00
@@ -341,7 +341,7 @@
  */
 static int ntfs_readpage(struct file *file, struct page *page)
 {
-	s64 attr_pos;
+	loff_t i_size;
 	ntfs_inode *ni, *base_ni;
 	u8 *kaddr;
 	ntfs_attr_search_ctx *ctx;
@@ -350,7 +350,6 @@
 	int err = 0;
 
 	BUG_ON(!PageLocked(page));
-
 	/*
 	 * This can potentially happen because we clear PageUptodate() during
 	 * ntfs_writepage() of MstProtected() attributes.
@@ -359,7 +358,6 @@
 		unlock_page(page);
 		return 0;
 	}
-
 	ni = NTFS_I(page->mapping->host);
 
 	/* NInoNonResident() == NInoIndexAllocPresent() */
@@ -381,12 +379,23 @@
 		/* Normal data stream. */
 		return ntfs_read_block(page);
 	}
-	/* Attribute is resident, implying it is not compressed or encrypted. */
+	/*
+	 * Attribute is resident, implying it is not compressed or encrypted.
+	 * This also means the attribute is smaller than an mft record and
+	 * hence smaller than a page, so can simply zero out any pages with
+	 * index above 0.  We can also do this if the file size is 0.
+	 */
+	if (unlikely(page->index > 0 || !i_size_read(VFS_I(ni)))) {
+		kaddr = kmap_atomic(page, KM_USER0);
+		memset(kaddr, 0, PAGE_CACHE_SIZE);
+		flush_dcache_page(page);
+		kunmap_atomic(kaddr, KM_USER0);
+		goto done;
+	}
 	if (!NInoAttr(ni))
 		base_ni = ni;
 	else
 		base_ni = ni->ext.base_ntfs_ino;
-
 	/* Map, pin, and lock the mft record. */
 	mrec = map_mft_record(base_ni);
 	if (IS_ERR(mrec)) {
@@ -402,35 +411,25 @@
 			CASE_SENSITIVE, 0, NULL, 0, ctx);
 	if (unlikely(err))
 		goto put_unm_err_out;
-
-	/* Starting position of the page within the attribute value. */
-	attr_pos = page->index << PAGE_CACHE_SHIFT;
-
-	/* The total length of the attribute value. */
 	attr_len = le32_to_cpu(ctx->attr->data.resident.value_length);
-
+	i_size = i_size_read(VFS_I(ni));
+	if (unlikely(attr_len > i_size))
+		attr_len = i_size;
 	kaddr = kmap_atomic(page, KM_USER0);
-	/* Copy over in bounds data, zeroing the remainder of the page. */
-	if (attr_pos < attr_len) {
-		u32 bytes = attr_len - attr_pos;
-		if (bytes > PAGE_CACHE_SIZE)
-			bytes = PAGE_CACHE_SIZE;
-		else if (bytes < PAGE_CACHE_SIZE)
-			memset(kaddr + bytes, 0, PAGE_CACHE_SIZE - bytes);
-		/* Copy the data to the page. */
-		memcpy(kaddr, attr_pos + (char*)ctx->attr +
-				le16_to_cpu(
-				ctx->attr->data.resident.value_offset), bytes);
-	} else
-		memset(kaddr, 0, PAGE_CACHE_SIZE);
+	/* Copy the data to the page. */
+	memcpy(kaddr, (u8*)ctx->attr +
+			le16_to_cpu(ctx->attr->data.resident.value_offset),
+			attr_len);
+	/* Zero the remainder of the page. */
+	memset(kaddr + attr_len, 0, PAGE_CACHE_SIZE - attr_len);
 	flush_dcache_page(page);
 	kunmap_atomic(kaddr, KM_USER0);
-
-	SetPageUptodate(page);
 put_unm_err_out:
 	ntfs_attr_put_search_ctx(ctx);
 unm_err_out:
 	unmap_mft_record(base_ni);
+done:
+	SetPageUptodate(page);
 err_out:
 	unlock_page(page);
 	return err;
@@ -1223,21 +1222,22 @@
  */
 static int ntfs_writepage(struct page *page, struct writeback_control *wbc)
 {
-	s64 attr_pos;
+	loff_t i_size;
 	struct inode *vi;
 	ntfs_inode *ni, *base_ni;
 	char *kaddr;
 	ntfs_attr_search_ctx *ctx;
 	MFT_RECORD *m;
-	u32 attr_len, bytes;
+	u32 attr_len;
 	int err;
 
 	BUG_ON(!PageLocked(page));
 
 	vi = page->mapping->host;
+	i_size = i_size_read(vi);
 
 	/* Is the page fully outside i_size? (truncate in progress) */
-	if (unlikely(page->index >= (vi->i_size + PAGE_CACHE_SIZE - 1) >>
+	if (unlikely(page->index >= (i_size + PAGE_CACHE_SIZE - 1) >>
 			PAGE_CACHE_SHIFT)) {
 		/*
 		 * The page may have dirty, unmapped buffers.  Make them
@@ -1248,7 +1248,6 @@
 		ntfs_debug("Write outside i_size - truncated?");
 		return 0;
 	}
-
 	ni = NTFS_I(vi);
 
 	/* NInoNonResident() == NInoIndexAllocPresent() */
@@ -1284,9 +1283,9 @@
 			}
 		}
 		/* We have to zero every time due to mmap-at-end-of-file. */
-		if (page->index >= (vi->i_size >> PAGE_CACHE_SHIFT)) {
+		if (page->index >= (i_size >> PAGE_CACHE_SHIFT)) {
 			/* The page straddles i_size. */
-			unsigned int ofs = vi->i_size & ~PAGE_CACHE_MASK;
+			unsigned int ofs = i_size & ~PAGE_CACHE_MASK;
 			kaddr = kmap_atomic(page, KM_USER0);
 			memset(kaddr + ofs, 0, PAGE_CACHE_SIZE - ofs);
 			flush_dcache_page(page);
@@ -1300,16 +1299,25 @@
 	}
 	/*
 	 * Attribute is resident, implying it is not compressed, encrypted,
-	 * sparse, or mst protected.
+	 * sparse, or mst protected.  This also means the attribute is smaller
+	 * than an mft record and hence smaller than a page, so can simply
+	 * return error on any pages with index above 0.
 	 */
 	BUG_ON(page_has_buffers(page));
 	BUG_ON(!PageUptodate(page));
-
+	if (unlikely(page->index > 0)) {
+		ntfs_error(vi->i_sb, "BUG()! page->index (0x%lx) > 0.  "
+				"Aborting write.", page->index);
+		BUG_ON(PageWriteback(page));
+		set_page_writeback(page);
+		unlock_page(page);
+		end_page_writeback(page);
+		return -EIO;
+	}
 	if (!NInoAttr(ni))
 		base_ni = ni;
 	else
 		base_ni = ni->ext.base_ntfs_ino;
-
 	/* Map, pin, and lock the mft record. */
 	m = map_mft_record(base_ni);
 	if (IS_ERR(m)) {
@@ -1327,32 +1335,6 @@
 			CASE_SENSITIVE, 0, NULL, 0, ctx);
 	if (unlikely(err))
 		goto err_out;
-
-	/* Starting position of the page within the attribute value. */
-	attr_pos = page->index << PAGE_CACHE_SHIFT;
-
-	/* The total length of the attribute value. */
-	attr_len = le32_to_cpu(ctx->attr->data.resident.value_length);
-
-	if (unlikely(vi->i_size != attr_len)) {
-		ntfs_error(vi->i_sb, "BUG()! i_size (0x%llx) doesn't match "
-				"attr_len (0x%x). Aborting write.", vi->i_size,
-				attr_len);
-		err = -EIO;
-		goto err_out;
-	}
-	if (unlikely(attr_pos >= attr_len)) {
-		ntfs_error(vi->i_sb, "BUG()! attr_pos (0x%llx) > attr_len "
-				"(0x%x). Aborting write.",
-				(unsigned long long)attr_pos, attr_len);
-		err = -EIO;
-		goto err_out;
-	}
-
-	bytes = attr_len - attr_pos;
-	if (unlikely(bytes > PAGE_CACHE_SIZE))
-		bytes = PAGE_CACHE_SIZE;
-
 	/*
 	 * Keep the VM happy.  This must be done otherwise the radix-tree tag
 	 * PAGECACHE_TAG_DIRTY remains set even though the page is clean.
@@ -1384,26 +1366,30 @@
 	 * TODO: ntfs_truncate(), others?
 	 */
 
+	attr_len = le32_to_cpu(ctx->attr->data.resident.value_length);
+	i_size = i_size_read(VFS_I(ni));
 	kaddr = kmap_atomic(page, KM_USER0);
+	if (unlikely(attr_len > i_size)) {
+		/* Zero out of bounds area in the mft record. */
+		memset((u8*)ctx->attr + le16_to_cpu(
+				ctx->attr->data.resident.value_offset) +
+				i_size, 0, attr_len - i_size);
+		attr_len = i_size;
+	}
 	/* Copy the data from the page to the mft record. */
-	memcpy((u8*)ctx->attr + le16_to_cpu(
-			ctx->attr->data.resident.value_offset) + attr_pos,
-			kaddr, bytes);
+	memcpy((u8*)ctx->attr +
+			le16_to_cpu(ctx->attr->data.resident.value_offset),
+			kaddr, attr_len);
 	flush_dcache_mft_record_page(ctx->ntfs_ino);
-#if 0
-	/* Zero out of bounds area. */
-	if (likely(bytes < PAGE_CACHE_SIZE)) {
-		memset(kaddr + bytes, 0, PAGE_CACHE_SIZE - bytes);
-		flush_dcache_page(page);
-	}
-#endif
+	/* Zero out of bounds area in the page cache page. */
+	memset(kaddr + attr_len, 0, PAGE_CACHE_SIZE - attr_len);
+	flush_dcache_page(page);
 	kunmap_atomic(kaddr, KM_USER0);
 
 	end_page_writeback(page);
 
 	/* Mark the mft record dirty, so it gets written back. */
 	mark_mft_record_dirty(ctx->ntfs_ino);
-
 	ntfs_attr_put_search_ctx(ctx);
 	unmap_mft_record(base_ni);
 	return 0;
@@ -1413,13 +1399,13 @@
 				"page so we try again later.");
 		/*
 		 * Put the page back on mapping->dirty_pages, but leave its
-		 * buffer's dirty state as-is.
+		 * buffers' dirty state as-is.
 		 */
 		redirty_page_for_writepage(wbc, page);
 		err = 0;
 	} else {
 		ntfs_error(vi->i_sb, "Resident attribute write failed with "
-				"error %i. Setting page error flag.", -err);
+				"error %i.  Setting page error flag.", err);
 		SetPageError(page);
 	}
 	unlock_page(page);
