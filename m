Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318076AbSGMAgK>; Fri, 12 Jul 2002 20:36:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318077AbSGMAgJ>; Fri, 12 Jul 2002 20:36:09 -0400
Received: from purple.csi.cam.ac.uk ([131.111.8.4]:62399 "EHLO
	purple.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S318076AbSGMAgC>; Fri, 12 Jul 2002 20:36:02 -0400
Subject: [BK-PATCH-2.5] NTFS: 2.0.19 Fix race condition, improvements, and optimizations in i/o interface
To: torvalds@transmeta.com (Linus Torvalds)
Date: Sat, 13 Jul 2002 01:38:51 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (Linux Kernel)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17TAvz-00053B-00@storm.christs.cam.ac.uk>
From: Anton Altaparmakov <aia21@cantab.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please do a

	bk pull http://linux-ntfs.bkbits.net/ntfs-tng-2.5

Thanks! - This completes the work on the ntfs (read) address space
operations. Now hopefully race free, bug free, and uptodate with
current kernel core.

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/, http://www-stu.christs.cam.ac.uk/~aia21/

===================================================================

This will update the following files:

 Documentation/filesystems/ntfs.txt |    3 +
 fs/ntfs/ChangeLog                  |   20 +++++++---
 fs/ntfs/Makefile                   |    2 -
 fs/ntfs/aops.c                     |   71 +++++++++++++++++++++----------------
 fs/ntfs/compress.c                 |   40 +++++++++++++++-----
 fs/ntfs/inode.c                    |   22 ++++-------
 fs/ntfs/ntfs.h                     |    2 -
 7 files changed, 101 insertions(+), 59 deletions(-)

through these ChangeSets:

<aia21@cantab.net> (02/07/13 1.622)
   NTFS: 2.0.19 - Fix race condition, improvements, and optimizations in i/o interface.
   - Apply block optimization added to fs/ntfs/aops.c::ntfs_read_block()
     to fs/ntfs/compress.c::ntfs_file_read_compressed_block() as well.
   - Drop the "file" from ntfs_file_read_compressed_block().
   - Rename fs/ntfs/aops.c::ntfs_enb_buffer_read_async() to
     ntfs_end_buffer_async_read() (more like the fs/buffer.c counterpart).
   - Update ntfs_end_buffer_async_read() with the improved logic from
     its updated counterpart fs/buffer.c::end_buffer_async_read(). Apply
     further logic improvements to better determine when we set PageError.
   - Update submission of buffers in fs/ntfs/aops.c::ntfs_read_block() to
     check for the buffers being uptodate first in line with the updated
     fs/buffer.c::block_read_full_page(). This plugs a small race
     condition.


diff -Nru a/Documentation/filesystems/ntfs.txt b/Documentation/filesystems/ntfs.txt
--- a/Documentation/filesystems/ntfs.txt	Sat Jul 13 01:30:36 2002
+++ b/Documentation/filesystems/ntfs.txt	Sat Jul 13 01:30:36 2002
@@ -247,6 +247,9 @@
 
 Note, a technical ChangeLog aimed at kernel hackers is in fs/ntfs/ChangeLog.
 
+2.0.19:
+	- Fix race condition and improvements in block i/o interface.
+	- Optimization when reading compressed files.
 2.0.18:
 	- Fix race condition in reading of compressed files.
 2.0.17:
diff -Nru a/fs/ntfs/ChangeLog b/fs/ntfs/ChangeLog
--- a/fs/ntfs/ChangeLog	Sat Jul 13 01:30:36 2002
+++ b/fs/ntfs/ChangeLog	Sat Jul 13 01:30:36 2002
@@ -9,12 +9,22 @@
 	  read() will fail when s_maxbytes is reached? -> Investigate this.
 	- Implement/allow non-resident index bitmaps in dir.c::ntfs_readdir()
 	  and then also consider initialized_size w.r.t. the bitmaps, etc.
-	- Consider if ntfs_file_read_compressed_block() shouldn't be coping
-	  with initialized_size < data_size. I don't think it can happen but
-	  it requires more careful consideration.
 	- Enable NFS exporting of NTFS.
-	- Apply block resolution optimization from aops.c::ntfs_read_block() to
-	  compress.c::ntfs_file_read_compressed_block() as well.
+
+2.0.19 - Fix race condition, improvements, and optimizations in i/o interface.
+
+	- Apply block optimization added to fs/ntfs/aops.c::ntfs_read_block()
+	  to fs/ntfs/compress.c::ntfs_file_read_compressed_block() as well.
+	- Drop the "file" from ntfs_file_read_compressed_block().
+	- Rename fs/ntfs/aops.c::ntfs_enb_buffer_read_async() to
+	  ntfs_end_buffer_async_read() (more like the fs/buffer.c counterpart).
+	- Update ntfs_end_buffer_async_read() with the improved logic from
+	  its updated counterpart fs/buffer.c::end_buffer_async_read(). Apply
+	  further logic improvements to better determine when we set PageError.
+	- Update submission of buffers in fs/ntfs/aops.c::ntfs_read_block() to
+	  check for the buffers being uptodate first in line with the updated
+	  fs/buffer.c::block_read_full_page(). This plugs a small race
+	  condition.
 
 2.0.18 - Fix race condition in reading of compressed files.
 
diff -Nru a/fs/ntfs/Makefile b/fs/ntfs/Makefile
--- a/fs/ntfs/Makefile	Sat Jul 13 01:30:36 2002
+++ b/fs/ntfs/Makefile	Sat Jul 13 01:30:36 2002
@@ -5,7 +5,7 @@
 ntfs-objs := aops.o attrib.o compress.o debug.o dir.o file.o inode.o mft.o \
 	     mst.o namei.o super.o sysctl.o time.o unistr.o upcase.o
 
-EXTRA_CFLAGS = -DNTFS_VERSION=\"2.0.18\"
+EXTRA_CFLAGS = -DNTFS_VERSION=\"2.0.19\"
 
 ifeq ($(CONFIG_NTFS_DEBUG),y)
 EXTRA_CFLAGS += -DDEBUG
diff -Nru a/fs/ntfs/aops.c b/fs/ntfs/aops.c
--- a/fs/ntfs/aops.c	Sat Jul 13 01:30:36 2002
+++ b/fs/ntfs/aops.c	Sat Jul 13 01:30:36 2002
@@ -30,7 +30,7 @@
 #include "ntfs.h"
 
 /**
- * ntfs_end_buffer_read_async - async io completion for reading attributes
+ * ntfs_end_buffer_async_read - async io completion for reading attributes
  * @bh:		buffer head on which io is completed
  * @uptodate:	whether @bh is now uptodate or not
  *
@@ -45,26 +45,23 @@
  * record size, and index_block_size_bits, to the log(base 2) of the ntfs
  * record size.
  */
-static void ntfs_end_buffer_read_async(struct buffer_head *bh, int uptodate)
+static void ntfs_end_buffer_async_read(struct buffer_head *bh, int uptodate)
 {
 	static spinlock_t page_uptodate_lock = SPIN_LOCK_UNLOCKED;
 	unsigned long flags;
 	struct buffer_head *tmp;
 	struct page *page;
 	ntfs_inode *ni;
-
-	if (likely(uptodate))
-		set_buffer_uptodate(bh);
-	else
-		clear_buffer_uptodate(bh);
+	int page_uptodate = 1;
 
 	page = bh->b_page;
-
 	ni = NTFS_I(page->mapping->host);
 
 	if (likely(uptodate)) {
 		s64 file_ofs;
 
+		set_buffer_uptodate(bh);
+
 		file_ofs = (page->index << PAGE_CACHE_SHIFT) + bh_offset(bh);
 		/* Check for the current buffer head overflowing. */
 		if (file_ofs + bh->b_size > ni->initialized_size) {
@@ -78,22 +75,28 @@
 			flush_dcache_page(page);
 			kunmap_atomic(addr, KM_BIO_SRC_IRQ);
 		}
-	} else
+	} else {
+		clear_buffer_uptodate(bh);
+		ntfs_error(ni->vol->sb, "Buffer I/O error, logical block %Lu.",
+				(unsigned long long)bh->b_blocknr);
 		SetPageError(page);
+	}
 
 	spin_lock_irqsave(&page_uptodate_lock, flags);
 	clear_buffer_async_read(bh);
 	unlock_buffer(bh);
-
-	tmp = bh->b_this_page;
-	while (tmp != bh) {
-		if (buffer_locked(tmp)) {
-			if (buffer_async_read(tmp))
+	tmp = bh;
+	do {
+		if (!buffer_uptodate(tmp))
+			page_uptodate = 0;
+		if (buffer_async_read(tmp)) {
+			if (likely(buffer_locked(tmp)))
 				goto still_busy;
-		} else if (!buffer_uptodate(tmp))
-			SetPageError(page);
+			/* Async buffers must be locked. */
+			BUG();
+		}
 		tmp = tmp->b_this_page;
-	}
+	} while (tmp != bh);
 	spin_unlock_irqrestore(&page_uptodate_lock, flags);
 	/*
 	 * If none of the buffers had errors then we can set the page uptodate,
@@ -101,7 +104,7 @@
 	 * attribute is mst protected, i.e. if NInoMstProteced(ni) is true.
 	 */
 	if (!NInoMstProtected(ni)) {
-		if (likely(!PageError(page)))
+		if (likely(page_uptodate && !PageError(page)))
 			SetPageUptodate(page);
 		unlock_page(page);
 		return;
@@ -127,12 +130,15 @@
 		}
 		flush_dcache_page(page);
 		kunmap_atomic(addr, KM_BIO_SRC_IRQ);
-		if (likely(!nr_err && recs))
-			SetPageUptodate(page);
-		else {
-			ntfs_error(ni->vol->sb, "Setting page error, index "
-					"0x%lx.", page->index);
-			SetPageError(page);
+		if (likely(!PageError(page))) {
+			if (likely(!nr_err && recs)) {
+				if (likely(page_uptodate))
+					SetPageUptodate(page);
+			} else {
+				ntfs_error(ni->vol->sb, "Setting page error, "
+						"index 0x%lx.", page->index);
+				SetPageError(page);
+			}
 		}
 	}
 	unlock_page(page);
@@ -282,16 +288,23 @@
 
 	/* Check we have at least one buffer ready for i/o. */
 	if (nr) {
+		struct buffer_head *tbh;
+
 		/* Lock the buffers. */
 		for (i = 0; i < nr; i++) {
-			struct buffer_head *tbh = arr[i];
+			tbh = arr[i];
 			lock_buffer(tbh);
-			tbh->b_end_io = ntfs_end_buffer_read_async;
+			tbh->b_end_io = ntfs_end_buffer_async_read;
 			set_buffer_async_read(tbh);
 		}
 		/* Finally, start i/o on the buffers. */
-		for (i = 0; i < nr; i++)
-			submit_bh(READ, arr[i]);
+		for (i = 0; i < nr; i++) {
+			tbh = arr[i];
+			if (likely(!buffer_uptodate(tbh)))
+				submit_bh(READ, tbh);
+			else
+				ntfs_end_buffer_async_read(tbh, 1);
+		}
 		return 0;
 	}
 	/* No i/o was scheduled on any of the buffers. */
@@ -349,7 +362,7 @@
 			}
 			/* Compressed data streams are handled in compress.c. */
 			if (NInoCompressed(ni))
-				return ntfs_file_read_compressed_block(page);
+				return ntfs_read_compressed_block(page);
 		}
 		/* Normal data stream. */
 		return ntfs_read_block(page);
diff -Nru a/fs/ntfs/compress.c b/fs/ntfs/compress.c
--- a/fs/ntfs/compress.c	Sat Jul 13 01:30:36 2002
+++ b/fs/ntfs/compress.c	Sat Jul 13 01:30:36 2002
@@ -386,7 +386,7 @@
 }
 
 /**
- * ntfs_file_read_compressed_block - read a compressed block into the page cache
+ * ntfs_read_compressed_block - read a compressed block into the page cache
  * @page:	locked page in the compression block(s) we need to read
  *
  * When we are called the page has already been verified to be locked and the
@@ -418,14 +418,15 @@
  * initialized_size is less than data_size. This should be safe because of the
  * nature of the compression algorithm used. Just in case we check and output
  * an error message in read inode if the two sizes are not equal for a
- * compressed file.
+ * compressed file. (AIA)
  */
-int ntfs_file_read_compressed_block(struct page *page)
+int ntfs_read_compressed_block(struct page *page)
 {
 	struct address_space *mapping = page->mapping;
 	ntfs_inode *ni = NTFS_I(mapping->host);
 	ntfs_volume *vol = ni->vol;
 	struct super_block *sb = vol->sb;
+	run_list_element *rl;
 	unsigned long block_size = sb->s_blocksize;
 	unsigned char block_size_bits = sb->s_blocksize_bits;
 	u8 *cb, *cb_pos, *cb_end;
@@ -532,14 +533,23 @@
 	nr_bhs = 0;
 
 	/* Read all cb buffer heads one cluster at a time. */
+	rl = NULL;
 	for (vcn = start_vcn, start_vcn += cb_clusters; vcn < start_vcn;
 			vcn++) {
 		BOOL is_retry = FALSE;
-retry_remap:
-		/* Find lcn of vcn and convert it into blocks. */
-		down_read(&ni->run_list.lock);
-		lcn = vcn_to_lcn(ni->run_list.rl, vcn);
-		up_read(&ni->run_list.lock);
+
+		if (!rl) {
+lock_retry_remap:
+			down_read(&ni->run_list.lock);
+			rl = ni->run_list.rl;
+		}
+		if (likely(rl != NULL)) {
+			/* Seek to element containing target vcn. */
+			while (rl->length && rl[1].vcn <= vcn)
+				rl++;
+			lcn = vcn_to_lcn(rl, vcn);
+		} else
+			lcn = (LCN)LCN_RL_NOT_MAPPED;
 		ntfs_debug("Reading vcn = 0x%Lx, lcn = 0x%Lx.",
 				(long long)vcn, (long long)lcn);
 		if (lcn < 0) {
@@ -552,9 +562,13 @@
 			if (is_retry || lcn != LCN_RL_NOT_MAPPED)
 				goto rl_err;
 			is_retry = TRUE;
-			/* Map run list of current extent and retry. */
+			/*
+			 * Attempt to map run list, dropping lock for the
+			 * duration.
+			 */
+			up_read(&ni->run_list.lock);
 			if (!map_run_list(ni, vcn))
-				goto retry_remap;
+				goto lock_retry_remap;
 			goto map_rl_err;
 		}
 		block = lcn << vol->cluster_size_bits >> block_size_bits;
@@ -568,6 +582,10 @@
 		} while (++block < max_block);
 	}
 
+	/* Release the lock if we took it. */
+	if (rl)
+		up_read(&ni->run_list.lock);
+
 	/* Setup and initiate io on all buffer heads. */
 	for (i = 0; i < nr_bhs; i++) {
 		struct buffer_head *tbh = bhs[i];
@@ -828,11 +846,13 @@
 	goto err_out;
 
 rl_err:
+	up_read(&ni->run_list.lock);
 	ntfs_error(vol->sb, "vcn_to_lcn() failed. Cannot read compression "
 			"block.");
 	goto err_out;
 
 getblk_err:
+	up_read(&ni->run_list.lock);
 	ntfs_error(vol->sb, "getblk() failed. Cannot read compression block.");
 
 err_out:
diff -Nru a/fs/ntfs/inode.c b/fs/ntfs/inode.c
--- a/fs/ntfs/inode.c	Sat Jul 13 01:30:36 2002
+++ b/fs/ntfs/inode.c	Sat Jul 13 01:30:36 2002
@@ -1007,19 +1007,15 @@
 				ni->_ICF(compressed_size) = sle64_to_cpu(
 					ctx->attr->_ANR(compressed_size));
 				if (vi->i_size != ni->initialized_size)
-					ntfs_warning(vi->i_sb, "Compressed "
-							"file with data_size "
-							"unequal to "
-							"initialized size "
-							"found. This will "
-							"probably cause "
-							"problems when trying "
-							"to access the file. "
-							"Please notify "
-							"linux-ntfs-dev@"
-							"lists.sf.net that you"
-							"saw this message."
-							"Thanks!");
+					ntfs_warning(vi->i_sb, "BUG: Found "
+						"compressed file with "
+						"data_size not equal to "
+						"initialized_size. This will "
+						"probably cause problems when "
+						"trying to access the file. "
+						"Please notify linux-ntfs-dev@"
+						"lists.sf.net that you saw "
+						"this message. Thanks!");
 			}
 		} else { /* Resident attribute. */
 			/*
diff -Nru a/fs/ntfs/ntfs.h b/fs/ntfs/ntfs.h
--- a/fs/ntfs/ntfs.h	Sat Jul 13 01:30:36 2002
+++ b/fs/ntfs/ntfs.h	Sat Jul 13 01:30:36 2002
@@ -158,7 +158,7 @@
 /* Declarations of functions and global variables. */
 
 /* From fs/ntfs/compress.c */
-extern int ntfs_file_read_compressed_block(struct page *page);
+extern int ntfs_read_compressed_block(struct page *page);
 
 /* From fs/ntfs/super.c */
 #define default_upcase_len 0x10000

===================================================================

This BitKeeper patch contains the following changesets:
+
## Wrapped with gzip_uu ##


begin 664 bkpatch21421
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
@T,@G+[4OYW\W))]-%.7XN!N:78,[5/\/D!Y`?HDD````
`
end
