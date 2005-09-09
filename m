Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030193AbVIIJbK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030193AbVIIJbK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 05:31:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030192AbVIIJbK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 05:31:10 -0400
Received: from ppsw-9.csi.cam.ac.uk ([131.111.8.139]:32152 "EHLO
	ppsw-9.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S1030195AbVIIJbE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 05:31:04 -0400
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Date: Fri, 9 Sep 2005 10:30:55 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net
Subject: [PATCH 23/25] NTFS: Fix page_has_buffers()/page_buffers() handling
 in fs/ntfs/aops.c.
In-Reply-To: <Pine.LNX.4.60.0509090950100.11051@hermes-1.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.60.0509091030310.26845@hermes-1.csi.cam.ac.uk>
References: <Pine.LNX.4.60.0509090950100.11051@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH 23/25] NTFS: Fix page_has_buffers()/page_buffers() handling in fs/ntfs/aops.c.

Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

---

 fs/ntfs/ChangeLog |    1 +
 fs/ntfs/aops.c    |   38 +++++++++++++++++++++-----------------
 2 files changed, 22 insertions(+), 17 deletions(-)

a01ac532b519dc0e0b4d8bc4e12373e4e4cd1b1a
diff --git a/fs/ntfs/ChangeLog b/fs/ntfs/ChangeLog
--- a/fs/ntfs/ChangeLog
+++ b/fs/ntfs/ChangeLog
@@ -85,6 +85,7 @@ ToDo/Notes:
 	  removal of the get_bh()/put_bh() pairs for each buffer.
 	- Fix fs/ntfs/aops.c::ntfs_{read,write}_block() to handle the case
 	  where a concurrent truncate has truncated the runlist under our feet.
+	- Fix page_has_buffers()/page_buffers() handling in fs/ntfs/aops.c.
 
 2.1.23 - Implement extension of resident files and make writing safe as well as
 	 many bug fixes, cleanups, and enhancements...
diff --git a/fs/ntfs/aops.c b/fs/ntfs/aops.c
--- a/fs/ntfs/aops.c
+++ b/fs/ntfs/aops.c
@@ -185,13 +185,15 @@ static int ntfs_read_block(struct page *
 	blocksize_bits = VFS_I(ni)->i_blkbits;
 	blocksize = 1 << blocksize_bits;
 
-	if (!page_has_buffers(page))
+	if (!page_has_buffers(page)) {
 		create_empty_buffers(page, blocksize, 0);
-	bh = head = page_buffers(page);
-	if (unlikely(!bh)) {
-		unlock_page(page);
-		return -ENOMEM;
+		if (unlikely(!page_has_buffers(page))) {
+			unlock_page(page);
+			return -ENOMEM;
+		}
 	}
+	bh = head = page_buffers(page);
+	BUG_ON(!bh);
 
 	iblock = (s64)page->index << (PAGE_CACHE_SHIFT - blocksize_bits);
 	read_lock_irqsave(&ni->size_lock, flags);
@@ -530,19 +532,21 @@ static int ntfs_write_block(struct page 
 		BUG_ON(!PageUptodate(page));
 		create_empty_buffers(page, blocksize,
 				(1 << BH_Uptodate) | (1 << BH_Dirty));
+		if (unlikely(!page_has_buffers(page))) {
+			ntfs_warning(vol->sb, "Error allocating page "
+					"buffers.  Redirtying page so we try "
+					"again later.");
+			/*
+			 * Put the page back on mapping->dirty_pages, but leave
+			 * its buffers' dirty state as-is.
+			 */
+			redirty_page_for_writepage(wbc, page);
+			unlock_page(page);
+			return 0;
+		}
 	}
 	bh = head = page_buffers(page);
-	if (unlikely(!bh)) {
-		ntfs_warning(vol->sb, "Error allocating page buffers. "
-				"Redirtying page so we try again later.");
-		/*
-		 * Put the page back on mapping->dirty_pages, but leave its
-		 * buffer's dirty state as-is.
-		 */
-		redirty_page_for_writepage(wbc, page);
-		unlock_page(page);
-		return 0;
-	}
+	BUG_ON(!bh);
 
 	/* NOTE: Different naming scheme to ntfs_read_block()! */
 
@@ -910,7 +914,6 @@ static int ntfs_write_mst_block(struct p
 	sync = (wbc->sync_mode == WB_SYNC_ALL);
 
 	/* Make sure we have mapped buffers. */
-	BUG_ON(!page_has_buffers(page));
 	bh = head = page_buffers(page);
 	BUG_ON(!bh);
 
@@ -2397,6 +2400,7 @@ void mark_ntfs_record_dirty(struct page 
 			buffers_to_free = bh;
 	}
 	bh = head = page_buffers(page);
+	BUG_ON(!bh);
 	do {
 		bh_ofs = bh_offset(bh);
 		if (bh_ofs + bh_size <= ofs)
