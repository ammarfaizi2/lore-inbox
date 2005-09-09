Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030200AbVIIJ3O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030200AbVIIJ3O (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 05:29:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030197AbVIIJ3O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 05:29:14 -0400
Received: from ppsw-1.csi.cam.ac.uk ([131.111.8.131]:4047 "EHLO
	ppsw-1.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S1030198AbVIIJ3J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 05:29:09 -0400
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Date: Fri, 9 Sep 2005 10:29:04 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net
Subject: [PATCH 19/25] NTFS: Fixup handling of sparse, compressed, and
 encrypted attributes in
In-Reply-To: <Pine.LNX.4.60.0509090950100.11051@hermes-1.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.60.0509091028470.26845@hermes-1.csi.cam.ac.uk>
References: <Pine.LNX.4.60.0509090950100.11051@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH 19/25] NTFS: Fixup handling of sparse, compressed, and encrypted attributes in
      fs/ntfs/aops.c::ntfs_writepage().

Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

---

 fs/ntfs/ChangeLog |    2 +
 fs/ntfs/aops.c    |  104 ++++++++++++++++++++++++-----------------------------
 2 files changed, 49 insertions(+), 57 deletions(-)

bd45fdd209ca49c5010ac9af469c41ae6dd3f145
diff --git a/fs/ntfs/ChangeLog b/fs/ntfs/ChangeLog
--- a/fs/ntfs/ChangeLog
+++ b/fs/ntfs/ChangeLog
@@ -79,6 +79,8 @@ ToDo/Notes:
 	  fs/ntfs/inode.c::ntfs_read_locked_{,attr_,index_}inode().
 	- Make ntfs_write_block() not instantiate sparse blocks if they contain
 	  only zeroes.
+	- Fixup handling of sparse, compressed, and encrypted attributes in
+	  fs/ntfs/aops.c::ntfs_writepage().
 
 2.1.23 - Implement extension of resident files and make writing safe as well as
 	 many bug fixes, cleanups, and enhancements...
diff --git a/fs/ntfs/aops.c b/fs/ntfs/aops.c
--- a/fs/ntfs/aops.c
+++ b/fs/ntfs/aops.c
@@ -1301,38 +1301,42 @@ retry_writepage:
 		ntfs_debug("Write outside i_size - truncated?");
 		return 0;
 	}
+	/*
+	 * Only $DATA attributes can be encrypted and only unnamed $DATA
+	 * attributes can be compressed.  Index root can have the flags set but
+	 * this means to create compressed/encrypted files, not that the
+	 * attribute is compressed/encrypted.
+	 */
+	if (ni->type != AT_INDEX_ROOT) {
+		/* If file is encrypted, deny access, just like NT4. */
+		if (NInoEncrypted(ni)) {
+			unlock_page(page);
+			BUG_ON(ni->type != AT_DATA);
+			ntfs_debug("Denying write access to encrypted "
+					"file.");
+			return -EACCES;
+		}
+		/* Compressed data streams are handled in compress.c. */
+		if (NInoNonResident(ni) && NInoCompressed(ni)) {
+			BUG_ON(ni->type != AT_DATA);
+			BUG_ON(ni->name_len);
+			// TODO: Implement and replace this with
+			// return ntfs_write_compressed_block(page);
+			unlock_page(page);
+			ntfs_error(vi->i_sb, "Writing to compressed files is "
+					"not supported yet.  Sorry.");
+			return -EOPNOTSUPP;
+		}
+		// TODO: Implement and remove this check.
+		if (NInoNonResident(ni) && NInoSparse(ni)) {
+			unlock_page(page);
+			ntfs_error(vi->i_sb, "Writing to sparse files is not "
+					"supported yet.  Sorry.");
+			return -EOPNOTSUPP;
+		}
+	}
 	/* NInoNonResident() == NInoIndexAllocPresent() */
 	if (NInoNonResident(ni)) {
-		/*
-		 * Only unnamed $DATA attributes can be compressed, encrypted,
-		 * and/or sparse.
-		 */
-		if (ni->type == AT_DATA && !ni->name_len) {
-			/* If file is encrypted, deny access, just like NT4. */
-			if (NInoEncrypted(ni)) {
-				unlock_page(page);
-				ntfs_debug("Denying write access to encrypted "
-						"file.");
-				return -EACCES;
-			}
-			/* Compressed data streams are handled in compress.c. */
-			if (NInoCompressed(ni)) {
-				// TODO: Implement and replace this check with
-				// return ntfs_write_compressed_block(page);
-				unlock_page(page);
-				ntfs_error(vi->i_sb, "Writing to compressed "
-						"files is not supported yet. "
-						"Sorry.");
-				return -EOPNOTSUPP;
-			}
-			// TODO: Implement and remove this check.
-			if (NInoSparse(ni)) {
-				unlock_page(page);
-				ntfs_error(vi->i_sb, "Writing to sparse files "
-						"is not supported yet. Sorry.");
-				return -EOPNOTSUPP;
-			}
-		}
 		/* We have to zero every time due to mmap-at-end-of-file. */
 		if (page->index >= (i_size >> PAGE_CACHE_SHIFT)) {
 			/* The page straddles i_size. */
@@ -1345,14 +1349,16 @@ retry_writepage:
 		/* Handle mst protected attributes. */
 		if (NInoMstProtected(ni))
 			return ntfs_write_mst_block(page, wbc);
-		/* Normal data stream. */
+		/* Normal, non-resident data stream. */
 		return ntfs_write_block(page, wbc);
 	}
 	/*
-	 * Attribute is resident, implying it is not compressed, encrypted,
-	 * sparse, or mst protected.  This also means the attribute is smaller
-	 * than an mft record and hence smaller than a page, so can simply
-	 * return error on any pages with index above 0.
+	 * Attribute is resident, implying it is not compressed, encrypted, or
+	 * mst protected.  This also means the attribute is smaller than an mft
+	 * record and hence smaller than a page, so can simply return error on
+	 * any pages with index above 0.  Note the attribute can actually be
+	 * marked compressed but if it is resident the actual data is not
+	 * compressed so we are ok to ignore the compressed flag here.
 	 */
 	BUG_ON(page_has_buffers(page));
 	BUG_ON(!PageUptodate(page));
@@ -1401,30 +1407,14 @@ retry_writepage:
 	BUG_ON(PageWriteback(page));
 	set_page_writeback(page);
 	unlock_page(page);
-
 	/*
-	 * Here, we don't need to zero the out of bounds area everytime because
-	 * the below memcpy() already takes care of the mmap-at-end-of-file
-	 * requirements. If the file is converted to a non-resident one, then
-	 * the code path use is switched to the non-resident one where the
-	 * zeroing happens on each ntfs_writepage() invocation.
-	 *
-	 * The above also applies nicely when i_size is decreased.
-	 *
-	 * When i_size is increased, the memory between the old and new i_size
-	 * _must_ be zeroed (or overwritten with new data). Otherwise we will
-	 * expose data to userspace/disk which should never have been exposed.
-	 *
-	 * FIXME: Ensure that i_size increases do the zeroing/overwriting and
-	 * if we cannot guarantee that, then enable the zeroing below.  If the
-	 * zeroing below is enabled, we MUST move the unlock_page() from above
-	 * to after the kunmap_atomic(), i.e. just before the
-	 * end_page_writeback().
-	 * UPDATE: ntfs_prepare/commit_write() do the zeroing on i_size
-	 * increases for resident attributes so those are ok.
-	 * TODO: ntfs_truncate(), others?
+	 * Here, we do not need to zero the out of bounds area everytime
+	 * because the below memcpy() already takes care of the
+	 * mmap-at-end-of-file requirements.  If the file is converted to a
+	 * non-resident one, then the code path use is switched to the
+	 * non-resident one where the zeroing happens on each ntfs_writepage()
+	 * invocation.
 	 */
-
 	attr_len = le32_to_cpu(ctx->attr->data.resident.value_length);
 	i_size = i_size_read(vi);
 	if (unlikely(attr_len > i_size)) {
