Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268132AbUJSKAi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268132AbUJSKAi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 06:00:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268139AbUJSJ64
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 05:58:56 -0400
Received: from ppsw-4.csi.cam.ac.uk ([131.111.8.134]:28646 "EHLO
	ppsw-4.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S268142AbUJSJmp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 05:42:45 -0400
Date: Tue, 19 Oct 2004 10:42:43 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-ntfs-dev@lists.sourceforge.net
Subject: [PATCH 16/37] Re: [2.6-BK-URL] NTFS: 2.1.21 - Big update with race/bug
 fixes
In-Reply-To: <Pine.LNX.4.60.0410191042200.24986@hermes-1.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.60.0410191042320.24986@hermes-1.csi.cam.ac.uk>
References: <Pine.LNX.4.60.0410191017070.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191038250.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191038570.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191039140.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191039320.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191039510.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191040050.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191040220.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191040360.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191040490.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191041050.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191041180.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191041290.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191041420.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191041590.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191042200.24986@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is patch 16/37 in the series.  It contains the following ChangeSet:

<aia21@cantab.net> (04/10/05 1.2022.1.2)
   NTFS: Switch fs/ntfs/index.h::ntfs_index_entry_mark_dirty() to using the
         new helper fs/ntfs/aops.c::mark_ntfs_record_dirty() and remove the no
         longer needed fs/ntfs/index.[hc]::__ntfs_index_entry_mark_dirty().
   
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
--- a/fs/ntfs/ChangeLog	2004-10-19 10:14:04 +01:00
+++ b/fs/ntfs/ChangeLog	2004-10-19 10:14:04 +01:00
@@ -51,6 +51,9 @@
 	  marks all buffers belonging to an ntfs record dirty, followed by
 	  marking the page the ntfs record is in dirty and also marking the vfs
 	  inode containing the ntfs record dirty (I_DIRTY_PAGES).
+	- Switch fs/ntfs/index.h::ntfs_index_entry_mark_dirty() to using the
+	  new helper fs/ntfs/aops.c::mark_ntfs_record_dirty() and remove the no
+	  longer needed fs/ntfs/index.[hc]::__ntfs_index_entry_mark_dirty().
 
 2.1.20 - Fix two stupid bugs introduced in 2.1.18 release.
 
diff -Nru a/fs/ntfs/index.c b/fs/ntfs/index.c
--- a/fs/ntfs/index.c	2004-10-19 10:14:04 +01:00
+++ b/fs/ntfs/index.c	2004-10-19 10:14:04 +01:00
@@ -459,58 +459,3 @@
 	err = -EIO;
 	goto err_out;
 }
-
-#ifdef NTFS_RW
-
-/**
- * __ntfs_index_entry_mark_dirty - mark an index allocation entry dirty
- * @ictx:	ntfs index context describing the index entry
- *
- * NOTE: You want to use fs/ntfs/index.h::ntfs_index_entry_mark_dirty() instead!
- * 
- * Mark the index allocation entry described by the index entry context @ictx
- * dirty.
- *
- * The index entry must be in an index block belonging to the index allocation
- * attribute.  Mark the buffers belonging to the index record as well as the
- * page cache page the index block is in dirty.  This automatically marks the
- * VFS inode of the ntfs index inode to which the index entry belongs dirty,
- * too (I_DIRTY_PAGES) and this in turn ensures the page buffers, and hence the
- * dirty index block, will be written out to disk later.
- */
-void __ntfs_index_entry_mark_dirty(ntfs_index_context *ictx)
-{
-	ntfs_inode *ni;
-	struct page *page;
-	struct buffer_head *bh, *head;
-	unsigned int rec_start, rec_end, bh_size, bh_start, bh_end;
-
-	BUG_ON(ictx->is_in_root);
-	ni = ictx->idx_ni;
-	page = ictx->page;
-	BUG_ON(!page_has_buffers(page));
-	/*
-	 * If the index block is the same size as the page cache page, set all
-	 * the buffers in the page, as well as the page itself, dirty.
-	 */
-	if (ni->itype.index.block_size == PAGE_CACHE_SIZE) {
-		__set_page_dirty_buffers(page);
-		return;
-	}
-	/* Set only the buffers in which the index block is located dirty. */
-	rec_start = (unsigned int)((u8*)ictx->ia - (u8*)page_address(page));
-	rec_end = rec_start + ni->itype.index.block_size;
-	bh_size = ni->vol->sb->s_blocksize;
-	bh_start = 0;
-	bh = head = page_buffers(page);
-	do {
-		bh_end = bh_start + bh_size;
-		if ((bh_start >= rec_start) && (bh_end <= rec_end))
-			set_buffer_dirty(bh);
-		bh_start = bh_end;
-	} while ((bh = bh->b_this_page) != head);
-	/* Finally, set the page itself dirty, too. */
-	__set_page_dirty_nobuffers(page);
-}
-
-#endif /* NTFS_RW */
diff -Nru a/fs/ntfs/index.h b/fs/ntfs/index.h
--- a/fs/ntfs/index.h	2004-10-19 10:14:04 +01:00
+++ b/fs/ntfs/index.h	2004-10-19 10:14:04 +01:00
@@ -30,6 +30,7 @@
 #include "inode.h"
 #include "attrib.h"
 #include "mft.h"
+#include "aops.h"
 
 /**
  * @idx_ni:	index inode containing the @entry described by this context
@@ -115,8 +116,6 @@
 		flush_dcache_page(ictx->page);
 }
 
-extern void __ntfs_index_entry_mark_dirty(ntfs_index_context *ictx);
-
 /**
  * ntfs_index_entry_mark_dirty - mark an index entry dirty
  * @ictx:	ntfs index context describing the index entry
@@ -140,7 +139,8 @@
 	if (ictx->is_in_root)
 		mark_mft_record_dirty(ictx->actx->ntfs_ino);
 	else
-		__ntfs_index_entry_mark_dirty(ictx);
+		mark_ntfs_record_dirty(ictx->idx_ni, ictx->page,
+			(u8*)ictx->ia - (u8*)page_address(ictx->page));
 }
 
 #endif /* NTFS_RW */
