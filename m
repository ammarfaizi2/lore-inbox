Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268168AbUJSKKl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268168AbUJSKKl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 06:10:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268148AbUJSKGS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 06:06:18 -0400
Received: from ppsw-6.csi.cam.ac.uk ([131.111.8.136]:8649 "EHLO
	ppsw-6.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S268164AbUJSJoa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 05:44:30 -0400
Date: Tue, 19 Oct 2004 10:44:25 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-ntfs-dev@lists.sourceforge.net
Subject: [PATCH 23/37] Re: [2.6-BK-URL] NTFS: 2.1.21 - Big update with race/bug
 fixes
In-Reply-To: <Pine.LNX.4.60.0410191043500.24986@hermes-1.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.60.0410191044130.24986@hermes-1.csi.cam.ac.uk>
References: <Pine.LNX.4.60.0410191017070.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191040360.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191040490.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191041050.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191041180.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191041290.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191041420.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191041590.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191042200.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191042320.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191042440.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191042560.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191043100.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191043240.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191043370.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191043500.24986@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is patch 23/37 in the series.  It contains the following ChangeSet:

<aia21@cantab.net> (04/10/11 1.2041.1.1)
   NTFS: Modify fs/ntfs/mft.c::write_mft_record_nolock() so that it only
         writes the mft record if the buffers belonging to it are dirty.
         Otherwise we assume that it was written out by other means already.
   
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
--- a/fs/ntfs/ChangeLog	2004-10-19 10:14:29 +01:00
+++ b/fs/ntfs/ChangeLog	2004-10-19 10:14:29 +01:00
@@ -73,6 +73,9 @@
 	- Add fs/ntfs/mft.c::try_map_mft_record() which fails with -EALREADY if
 	  the mft record is already locked and otherwise behaves the same way
 	  as fs/ntfs/mft.c::map_mft_record().
+	- Modify fs/ntfs/mft.c::write_mft_record_nolock() so that it only
+	  writes the mft record if the buffers belonging to it are dirty.
+	  Otherwise we assume that it was written out by other means already.
 
 2.1.20 - Fix two stupid bugs introduced in 2.1.18 release.
 
diff -Nru a/fs/ntfs/mft.c b/fs/ntfs/mft.c
--- a/fs/ntfs/mft.c	2004-10-19 10:14:29 +01:00
+++ b/fs/ntfs/mft.c	2004-10-19 10:14:29 +01:00
@@ -678,6 +678,9 @@
  * ntfs inode @ni to backing store.  If the mft record @m has a counterpart in
  * the mft mirror, that is also updated.
  *
+ * We only write the mft record if the ntfs inode @ni is dirty and the buffers
+ * belonging to its mft record are dirty, too.
+ *
  * On success, clean the mft record and return 0.  On error, leave the mft
  * record dirty and return -errno.  The caller should call make_bad_inode() on
  * the base inode to ensure no more access happens to this inode.  We do not do
@@ -707,6 +710,7 @@
 	struct buffer_head *bh, *head;
 	unsigned int block_start, block_end, m_start, m_end;
 	int i_bhs, nr_bhs, err = 0;
+	BOOL rec_is_dirty = TRUE;
 
 	ntfs_debug("Entering for inode 0x%lx.", ni->mft_no);
 	BUG_ON(NInoAttr(ni));
@@ -739,29 +743,34 @@
 	do {
 		block_end = block_start + blocksize;
 		/* If the buffer is outside the mft record, skip it. */
-		if ((block_end <= m_start) || (block_start >= m_end))
-			continue;
-		if (!buffer_mapped(bh)) {
-			ntfs_error(vol->sb, "Writing mft records without "
-					"existing mapped buffers is not "
-					"implemented yet.  %s",
-					ntfs_please_email);
-			err = -EOPNOTSUPP;
+		if (block_end <= m_start)
 			continue;
-		}
-		if (!buffer_uptodate(bh)) {
-			ntfs_error(vol->sb, "Writing mft records without "
-					"existing uptodate buffers is not "
-					"implemented yet.  %s",
-					ntfs_please_email);
-			err = -EOPNOTSUPP;
+		if (unlikely(block_start >= m_end))
+			break;
+		/*
+		 * If the buffer is clean and it is the first buffer of the mft
+		 * record, it was written out by other means already so we are
+		 * done.  For safety we make sure all the other buffers are
+		 * clean also.  If it is clean but not the first buffer and the
+		 * first buffer was dirty it is a bug.
+		 */
+		if (!buffer_dirty(bh)) {
+			if (block_start == m_start)
+				rec_is_dirty = FALSE;
+			else
+				BUG_ON(rec_is_dirty);
 			continue;
 		}
+		BUG_ON(!rec_is_dirty);
+		BUG_ON(!buffer_mapped(bh));
+		BUG_ON(!buffer_uptodate(bh));
 		BUG_ON(!nr_bhs && (m_start != block_start));
 		BUG_ON(nr_bhs >= max_bhs);
 		bhs[nr_bhs++] = bh;
 		BUG_ON((nr_bhs >= max_bhs) && (m_end != block_end));
 	} while (block_start = block_end, (bh = bh->b_this_page) != head);
+	if (!rec_is_dirty)
+		goto done;
 	if (unlikely(err))
 		goto cleanup_out;
 	/* Apply the mst protection fixups. */
@@ -778,8 +787,7 @@
 		if (unlikely(test_set_buffer_locked(tbh)))
 			BUG();
 		BUG_ON(!buffer_uptodate(tbh));
-		if (buffer_dirty(tbh))
-			clear_buffer_dirty(tbh);
+		clear_buffer_dirty(tbh);
 		get_bh(tbh);
 		tbh->b_end_io = end_buffer_write_sync;
 		submit_bh(WRITE, tbh);
@@ -795,8 +803,8 @@
 		if (unlikely(!buffer_uptodate(tbh))) {
 			err = -EIO;
 			/*
-			 * Set the buffer uptodate so the page & buffer states
-			 * don't become out of sync.
+			 * Set the buffer uptodate so the page and buffer
+			 * states do not become out of sync.
 			 */
 			if (PageUptodate(page))
 				set_buffer_uptodate(tbh);
