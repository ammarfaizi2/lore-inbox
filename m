Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261943AbUKJOlN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261943AbUKJOlN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 09:41:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261932AbUKJN7q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 08:59:46 -0500
Received: from ppsw-0.csi.cam.ac.uk ([131.111.8.130]:61826 "EHLO
	ppsw-0.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S261926AbUKJNp7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 08:45:59 -0500
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-ntfs-dev@lists.sourceforge.net
Subject: [PATCH 24/26] NTFS 2.1.22 - Bug and race fixes and improved error handling.
Message-Id: <E1CRsnA-0006Sy-IU@imp.csi.cam.ac.uk>
Date: Wed, 10 Nov 2004 13:45:44 +0000
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is patch 24/26 in the series.  It contains the following ChangeSet:

<aia21@cantab.net> (04/11/09 1.2026.1.64)
   NTFS: - Fix creation of buffers in fs/ntfs/mft.c::ntfs_sync_mft_mirror().
           Cannot just call fs/ntfs/aops.c::mark_ntfs_record_dirty() since
           this also marks the page dirty so we create the buffers by hand
           and set them uptodate.
         - Revert the removal of the page uptodate check from
           fs/ntfs/aops.c::mark_ntfs_record_dirty() as it is no longer called
           from fs/ntfs/mft.c::ntfs_sync_mft_mirror().
   
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
--- a/fs/ntfs/ChangeLog	2004-11-10 13:45:48 +00:00
+++ b/fs/ntfs/ChangeLog	2004-11-10 13:45:48 +00:00
@@ -89,9 +89,6 @@
 	  and write_mft_record_nolock().  From now on we require that the
 	  complete runlist for the mft mirror is always mapped into memory.
 	- Add creation of buffers to fs/ntfs/mft.c::ntfs_sync_mft_mirror().
-	- Do not check for the page being uptodate in mark_ntfs_record_dirty()
-	  as we now call this after marking the page not uptodate during mft
-	  mirror synchronisation (fs/ntfs/mft.c::ntfs_sync_mft_mirror()).
 	- Improve error handling in fs/ntfs/aops.c::ntfs_{read,write}_block().
 
 2.1.21 - Fix some races and bugs, rewrite mft write code, add mft allocator.
diff -Nru a/fs/ntfs/aops.c b/fs/ntfs/aops.c
--- a/fs/ntfs/aops.c	2004-11-10 13:45:48 +00:00
+++ b/fs/ntfs/aops.c	2004-11-10 13:45:48 +00:00
@@ -819,6 +819,12 @@
 	BUG_ON(!NInoNonResident(ni));
 	BUG_ON(!NInoMstProtected(ni));
 	is_mft = (S_ISREG(vi->i_mode) && !vi->i_ino);
+	/*
+	 * NOTE: ntfs_write_mst_block() would be called for $MFTMirr if a page
+	 * in its page cache were to be marked dirty.  However this should
+	 * never happen with the current driver and considering we do not
+	 * handle this case here we do want to BUG(), at least for now.
+	 */
 	BUG_ON(!(is_mft || S_ISDIR(vi->i_mode) ||
 			(NInoAttr(ni) && ni->type == AT_INDEX_ALLOCATION)));
 	BUG_ON(!max_bhs);
@@ -2282,6 +2288,7 @@
 	struct buffer_head *bh, *head, *buffers_to_free = NULL;
 	unsigned int end, bh_size, bh_ofs;
 
+	BUG_ON(!PageUptodate(page));
 	end = ofs + ni->itype.index.block_size;
 	bh_size = 1 << VFS_I(ni)->i_blkbits;
 	spin_lock(&mapping->private_lock);
diff -Nru a/fs/ntfs/mft.c b/fs/ntfs/mft.c
--- a/fs/ntfs/mft.c	2004-11-10 13:45:48 +00:00
+++ b/fs/ntfs/mft.c	2004-11-10 13:45:48 +00:00
@@ -497,12 +497,20 @@
 	kmirr = page_address(page) + page_ofs;
 	/* Copy the mst protected mft record to the mirror. */
 	memcpy(kmirr, m, vol->mft_record_size);
-	/*
-	 * Create buffers if not present and mark the ones belonging to the mft
-	 * mirror record dirty.
-	 */
-	mark_ntfs_record_dirty(page, page_ofs);
-	BUG_ON(!page_has_buffers(page));
+	/* Create uptodate buffers if not present. */
+	if (unlikely(!page_has_buffers(page))) {
+		struct buffer_head *tail;
+
+		bh = head = alloc_page_buffers(page, blocksize, 1);
+		do {
+			set_buffer_uptodate(bh);
+			tail = bh;
+			bh = bh->b_this_page;
+		} while (bh);
+		tail->b_this_page = head;
+		attach_page_buffers(page, head);
+		BUG_ON(!page_has_buffers(page));
+	}
 	bh = head = page_buffers(page);
 	BUG_ON(!bh);
 	rl = NULL;
