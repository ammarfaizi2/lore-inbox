Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268120AbUJSK10@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268120AbUJSK10 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 06:27:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268156AbUJSK1H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 06:27:07 -0400
Received: from ppsw-5.csi.cam.ac.uk ([131.111.8.135]:63719 "EHLO
	ppsw-5.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S268120AbUJSJqR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 05:46:17 -0400
Date: Tue, 19 Oct 2004 10:46:12 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-ntfs-dev@lists.sourceforge.net
Subject: [PATCH 30/37] Re: [2.6-BK-URL] NTFS: 2.1.21 - Big update with race/bug
 fixes
In-Reply-To: <Pine.LNX.4.60.0410191045410.24986@hermes-1.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.60.0410191046000.24986@hermes-1.csi.cam.ac.uk>
References: <Pine.LNX.4.60.0410191017070.24986@hermes-1.csi.cam.ac.uk>
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
 <Pine.LNX.4.60.0410191045410.24986@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is patch 30/37 in the series.  It contains the following ChangeSet:

<aia21@cantab.net> (04/10/15 1.2047.1.2)
   NTFS: Modify fs/ntfs/mft.c::write_mft_record_nolock() and
         fs/ntfs/aops.c::ntfs_write_mst_block() to only check the dirty state
         of the first buffer in a record and to take this as the ntfs record
         dirty state.  We cannot look at the dirty state for subsequent
         buffers because we might be racing with
         fs/ntfs/aops.c::mark_ntfs_record_dirty().
   
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
--- a/fs/ntfs/ChangeLog	2004-10-19 10:14:55 +01:00
+++ b/fs/ntfs/ChangeLog	2004-10-19 10:14:55 +01:00
@@ -122,6 +122,12 @@
 	  ntfs inode as a parameter as this is confusing and misleading and the
 	  needed ntfs inode is available via NTFS_I(page->mapping->host).
 	  Adapt all callers to this change.
+	- Modify fs/ntfs/mft.c::write_mft_record_nolock() and
+	  fs/ntfs/aops.c::ntfs_write_mst_block() to only check the dirty state
+	  of the first buffer in a record and to take this as the ntfs record
+	  dirty state.  We cannot look at the dirty state for subsequent
+	  buffers because we might be racing with
+	  fs/ntfs/aops.c::mark_ntfs_record_dirty().
 
 2.1.20 - Fix two stupid bugs introduced in 2.1.18 release.
 
diff -Nru a/fs/ntfs/aops.c b/fs/ntfs/aops.c
--- a/fs/ntfs/aops.c	2004-10-19 10:14:55 +01:00
+++ b/fs/ntfs/aops.c	2004-10-19 10:14:55 +01:00
@@ -868,23 +868,24 @@
 			clear_buffer_dirty(bh);
 			continue;
 		}
-		if (rec_block == block) {
+		if (likely(block < rec_block)) {
+			/*
+			 * This block is not the first one in the record.  We
+			 * ignore the buffer's dirty state because we could
+			 * have raced with a parallel mark_ntfs_record_dirty().
+			 */
+			if (!rec_is_dirty)
+				continue;
+		} else /* if (block == rec_block) */ {
+			BUG_ON(block > rec_block);
 			/* This block is the first one in the record. */
 			rec_block += bhs_per_rec;
 			if (!buffer_dirty(bh)) {
-				/* Clean buffers are not written out. */
+				/* Clean records are not written out. */
 				rec_is_dirty = FALSE;
 				continue;
 			}
 			rec_is_dirty = TRUE;
-		} else {
-			/* This block is not the first one in the record. */
-			if (!buffer_dirty(bh)) {
-				/* Clean buffers are not written out. */
-				BUG_ON(rec_is_dirty);
-				continue;
-			}
-			BUG_ON(!rec_is_dirty);
 		}
 		BUG_ON(!buffer_mapped(bh));
 		BUG_ON(!buffer_uptodate(bh));
@@ -973,10 +974,8 @@
 			continue;
 		if (unlikely(test_set_buffer_locked(tbh)))
 			BUG();
-		if (unlikely(!test_clear_buffer_dirty(tbh))) {
-			unlock_buffer(tbh);
-			continue;
-		}
+		/* The buffer dirty state is now irrelevant, just clean it. */
+		clear_buffer_dirty(tbh);
 		BUG_ON(!buffer_uptodate(tbh));
 		BUG_ON(!buffer_mapped(tbh));
 		get_bh(tbh);
diff -Nru a/fs/ntfs/mft.c b/fs/ntfs/mft.c
--- a/fs/ntfs/mft.c	2004-10-19 10:14:55 +01:00
+++ b/fs/ntfs/mft.c	2004-10-19 10:14:55 +01:00
@@ -572,8 +572,10 @@
  * ntfs inode @ni to backing store.  If the mft record @m has a counterpart in
  * the mft mirror, that is also updated.
  *
- * We only write the mft record if the ntfs inode @ni is dirty and the buffers
- * belonging to its mft record are dirty, too.
+ * We only write the mft record if the ntfs inode @ni is dirty and the first
+ * buffer belonging to its mft record is dirty, too.  We ignore the dirty state
+ * of subsequent buffers because we could have raced with
+ * fs/ntfs/aops.c::mark_ntfs_record_dirty().
  *
  * On success, clean the mft record and return 0.  On error, leave the mft
  * record dirty and return -errno.  The caller should call make_bad_inode() on
@@ -632,21 +634,23 @@
 			continue;
 		if (unlikely(block_start >= m_end))
 			break;
-		/*
-		 * If the buffer is clean and it is the first buffer of the mft
-		 * record, it was written out by other means already so we are
-		 * done.  For safety we make sure all the other buffers are
-		 * clean also.  If it is clean but not the first buffer and the
-		 * first buffer was dirty it is a bug.
-		 */
-		if (!buffer_dirty(bh)) {
-			if (block_start == m_start)
+		if (block_start == m_start) {
+			/* This block is the first one in the record. */
+			if (!buffer_dirty(bh)) {
+				/* Clean records are not written out. */
 				rec_is_dirty = FALSE;
-			else
-				BUG_ON(rec_is_dirty);
-			continue;
+				continue;
+			}
+			rec_is_dirty = TRUE;
+		} else {
+			/*
+			 * This block is not the first one in the record.  We
+			 * ignore the buffer's dirty state because we could
+			 * have raced with a parallel mark_ntfs_record_dirty().
+			 */
+			if (!rec_is_dirty)
+				continue;
 		}
-		BUG_ON(!rec_is_dirty);
 		BUG_ON(!buffer_mapped(bh));
 		BUG_ON(!buffer_uptodate(bh));
 		BUG_ON(!nr_bhs && (m_start != block_start));
