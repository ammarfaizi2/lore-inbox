Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269402AbUJSKQ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269402AbUJSKQ2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 06:16:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268185AbUJSKQD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 06:16:03 -0400
Received: from ppsw-6.csi.cam.ac.uk ([131.111.8.136]:8907 "EHLO
	ppsw-6.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S268199AbUJSJp7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 05:45:59 -0400
Date: Tue, 19 Oct 2004 10:45:56 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-ntfs-dev@lists.sourceforge.net
Subject: [PATCH 29/37] Re: [2.6-BK-URL] NTFS: 2.1.21 - Big update with race/bug
 fixes
In-Reply-To: <Pine.LNX.4.60.0410191045250.24986@hermes-1.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.60.0410191045410.24986@hermes-1.csi.cam.ac.uk>
References: <Pine.LNX.4.60.0410191017070.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191041590.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191042200.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191042320.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191042440.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191042560.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191043100.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191043240.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191043370.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191043500.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191044130.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191044280.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191044420.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191044560.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191045100.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191045250.24986@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is patch 29/37 in the series.  It contains the following ChangeSet:

<aia21@cantab.net> (04/10/15 1.2047.1.1)
   NTFS: Modify fs/ntfs/aops.c::mark_ntfs_record_dirty() to no longer take the
         ntfs inode as a parameter as this is confusing and misleading and the
         ntfs inode is available via NTFS_I(page->mapping->host).
         Adapt all callers to this change.
   
   Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/, http://www-stu.christs.cam.ac.uk/~aia21/

===================================================================

diff -Nru a/fs/ntfs/ChangeLog b/fs/ntfs/ChangeLog
--- a/fs/ntfs/ChangeLog	2004-10-19 10:14:51 +01:00
+++ b/fs/ntfs/ChangeLog	2004-10-19 10:14:51 +01:00
@@ -118,6 +118,10 @@
 	  inode semaphore around the code thst sets ni->itype.index.bmp_ino to
 	  NULL and reorganize the code to optimize it a bit.  (Thanks to
 	  Christoph Hellwig for spotting this.)
+	- Modify fs/ntfs/aops.c::mark_ntfs_record_dirty() to no longer take the
+	  ntfs inode as a parameter as this is confusing and misleading and the
+	  needed ntfs inode is available via NTFS_I(page->mapping->host).
+	  Adapt all callers to this change.
 
 2.1.20 - Fix two stupid bugs introduced in 2.1.18 release.
 
diff -Nru a/fs/ntfs/aops.c b/fs/ntfs/aops.c
--- a/fs/ntfs/aops.c	2004-10-19 10:14:51 +01:00
+++ b/fs/ntfs/aops.c	2004-10-19 10:14:51 +01:00
@@ -2132,9 +2132,8 @@
 
 /**
  * mark_ntfs_record_dirty - mark an ntfs record dirty
- * @ni:		ntfs inode containing the ntfs record to be marked dirty
  * @page:	page containing the ntfs record to mark dirty
- * @rec_start:	byte offset within @page at which the ntfs record begins
+ * @ofs:	byte offset within @page at which the ntfs record begins
  *
  * If the ntfs record is the same size as the page cache page @page, set all
  * buffers in the page dirty.  Otherwise, set only the buffers in which the
@@ -2143,26 +2142,29 @@
  * Also, set the page containing the ntfs record dirty, which also marks the
  * vfs inode the ntfs record belongs to dirty (I_DIRTY_PAGES).
  */
-void mark_ntfs_record_dirty(ntfs_inode *ni, struct page *page,
-		unsigned int rec_start) {
+void mark_ntfs_record_dirty(struct page *page, const unsigned int ofs) {
+	ntfs_inode *ni;
 	struct buffer_head *bh, *head;
-	unsigned int rec_end, bh_size, bh_start, bh_end;
+	unsigned int end, bh_size, bh_ofs;
 
 	BUG_ON(!page);
 	BUG_ON(!page_has_buffers(page));
+	ni = NTFS_I(page->mapping->host);
+	BUG_ON(!ni);
 	if (ni->itype.index.block_size == PAGE_CACHE_SIZE) {
 		__set_page_dirty_buffers(page);
 		return;
 	}
-	rec_end = rec_start + ni->itype.index.block_size;
+	end = ofs + ni->itype.index.block_size;
 	bh_size = ni->vol->sb->s_blocksize;
-	bh_start = 0;
 	bh = head = page_buffers(page);
 	do {
-		bh_end = bh_start + bh_size;
-		if ((bh_start >= rec_start) && (bh_end <= rec_end))
-			set_buffer_dirty(bh);
-		bh_start = bh_end;
+		bh_ofs = bh_offset(bh);
+		if (bh_ofs + bh_size <= ofs)
+			continue;
+		if (unlikely(bh_ofs >= end))
+			break;
+		set_buffer_dirty(bh);
 	} while ((bh = bh->b_this_page) != head);
 	__set_page_dirty_nobuffers(page);
 }
diff -Nru a/fs/ntfs/aops.h b/fs/ntfs/aops.h
--- a/fs/ntfs/aops.h	2004-10-19 10:14:51 +01:00
+++ b/fs/ntfs/aops.h	2004-10-19 10:14:51 +01:00
@@ -95,8 +95,7 @@
 
 #ifdef NTFS_RW
 
-extern void mark_ntfs_record_dirty(ntfs_inode *ni, struct page *page,
-		unsigned int rec_start);
+extern void mark_ntfs_record_dirty(struct page *page, const unsigned int ofs);
 
 #endif /* NTFS_RW */
 
diff -Nru a/fs/ntfs/index.h b/fs/ntfs/index.h
--- a/fs/ntfs/index.h	2004-10-19 10:14:51 +01:00
+++ b/fs/ntfs/index.h	2004-10-19 10:14:51 +01:00
@@ -139,8 +139,8 @@
 	if (ictx->is_in_root)
 		mark_mft_record_dirty(ictx->actx->ntfs_ino);
 	else
-		mark_ntfs_record_dirty(ictx->idx_ni, ictx->page,
-			(u8*)ictx->ia - (u8*)page_address(ictx->page));
+		mark_ntfs_record_dirty(ictx->page,
+				(u8*)ictx->ia - (u8*)page_address(ictx->page));
 }
 
 #endif /* NTFS_RW */
diff -Nru a/fs/ntfs/inode.c b/fs/ntfs/inode.c
--- a/fs/ntfs/inode.c	2004-10-19 10:14:51 +01:00
+++ b/fs/ntfs/inode.c	2004-10-19 10:14:51 +01:00
@@ -2513,8 +2513,8 @@
 	 * this function returns.
 	 */
 	if (modified && !NInoTestSetDirty(ctx->ntfs_ino))
-		mark_ntfs_record_dirty(NTFS_I(ni->vol->mft_ino),
-				ctx->ntfs_ino->page, ctx->ntfs_ino->page_ofs);
+		mark_ntfs_record_dirty(ctx->ntfs_ino->page,
+				ctx->ntfs_ino->page_ofs);
 	ntfs_attr_put_search_ctx(ctx);
 	/* Now the access times are updated, write the base mft record. */
 	if (NInoDirty(ni))
diff -Nru a/fs/ntfs/mft.c b/fs/ntfs/mft.c
--- a/fs/ntfs/mft.c	2004-10-19 10:14:51 +01:00
+++ b/fs/ntfs/mft.c	2004-10-19 10:14:51 +01:00
@@ -380,8 +380,7 @@
 
 	ntfs_debug("Entering for inode 0x%lx.", ni->mft_no);
 	BUG_ON(NInoAttr(ni));
-	mark_ntfs_record_dirty(NTFS_I(ni->vol->mft_ino), ni->page,
-			ni->page_ofs);
+	mark_ntfs_record_dirty(ni->page, ni->page_ofs);
 	/* Determine the base vfs inode and mark it dirty, too. */
 	down(&ni->extent_lock);
 	if (likely(ni->nr_extents >= 0))
