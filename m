Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268146AbUJSLEb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268146AbUJSLEb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 07:04:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268533AbUJSKDu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 06:03:50 -0400
Received: from ppsw-8.csi.cam.ac.uk ([131.111.8.138]:20681 "EHLO
	ppsw-8.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S268146AbUJSJna (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 05:43:30 -0400
Date: Tue, 19 Oct 2004 10:43:22 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-ntfs-dev@lists.sourceforge.net
Subject: [PATCH 19/37] Re: [2.6-BK-URL] NTFS: 2.1.21 - Big update with race/bug
 fixes
In-Reply-To: <Pine.LNX.4.60.0410191042560.24986@hermes-1.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.60.0410191043100.24986@hermes-1.csi.cam.ac.uk>
References: <Pine.LNX.4.60.0410191017070.24986@hermes-1.csi.cam.ac.uk>
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
 <Pine.LNX.4.60.0410191042320.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191042440.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191042560.24986@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is patch 19/37 in the series.  It contains the following ChangeSet:

<aia21@cantab.net> (04/10/07 1.2031)
   NTFS: - Modify fs/ntfs/mft.c::__mark_mft_record_dirty() to use the helper
           mark_ntfs_record_dirty() which also changes the behaviour in that we
           now set the buffers belonging to the mft record dirty as well as the
           page itself.
         - Update fs/ntfs/mft.c::write_mft_record_nolock() and sync_mft_mirror()
           to cope with the fact that there now are dirty buffers in mft pages.
   
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
--- a/fs/ntfs/ChangeLog	2004-10-19 10:14:15 +01:00
+++ b/fs/ntfs/ChangeLog	2004-10-19 10:14:15 +01:00
@@ -59,6 +59,12 @@
 	- Move the typedefs for runlist_element and runlist from types.h to
 	  runlist.h and fix resulting include errors.
 	- Remove unused {__,}format_mft_record() from fs/ntfs/mft.c.
+	- Modify fs/ntfs/mft.c::__mark_mft_record_dirty() to use the helper
+	  mark_ntfs_record_dirty() which also changes the behaviour in that we
+	  now set the buffers belonging to the mft record dirty as well as the
+	  page itself.
+	- Update fs/ntfs/mft.c::write_mft_record_nolock() and sync_mft_mirror()
+	  to cope with the fact that there now are dirty buffers in mft pages.
 
 2.1.20 - Fix two stupid bugs introduced in 2.1.18 release.
 
diff -Nru a/fs/ntfs/mft.c b/fs/ntfs/mft.c
--- a/fs/ntfs/mft.c	2004-10-19 10:14:15 +01:00
+++ b/fs/ntfs/mft.c	2004-10-19 10:14:15 +01:00
@@ -407,19 +407,11 @@
  */
 void __mark_mft_record_dirty(ntfs_inode *ni)
 {
-	struct page *page = ni->page;
 	ntfs_inode *base_ni;
 
 	ntfs_debug("Entering for inode 0x%lx.", ni->mft_no);
-	BUG_ON(!page);
 	BUG_ON(NInoAttr(ni));
-
-	/*
-	 * Set the page containing the mft record dirty.  This also marks the
-	 * $MFT inode dirty (I_DIRTY_PAGES).
-	 */
-	__set_page_dirty_nobuffers(page);
-
+	mark_ntfs_record_dirty(ni, ni->page, ni->page_ofs);
 	/* Determine the base vfs inode and mark it dirty, too. */
 	down(&ni->extent_lock);
 	if (likely(ni->nr_extents >= 0))
@@ -541,20 +533,9 @@
 	m_end = m_start + vol->mft_record_size;
 	do {
 		block_end = block_start + blocksize;
-		/*
-		 * If the buffer is outside the mft record, just skip it,
-		 * clearing it if it is dirty to make sure it is not written
-		 * out.  It should never be marked dirty but better be safe.
-		 */
-		if ((block_end <= m_start) || (block_start >= m_end)) {
-			if (buffer_dirty(bh)) {
-				ntfs_warning(vol->sb, "Clearing dirty mft "
-						"record page buffer.  %s",
-						ntfs_please_email);
-				clear_buffer_dirty(bh);
-			}
+		/* If the buffer is outside the mft record, skip it. */
+		if ((block_end <= m_start) || (block_start >= m_end))
 			continue;
-		}
 		if (!buffer_mapped(bh)) {
 			ntfs_error(vol->sb, "Writing mft mirror records "
 					"without existing mapped buffers is "
@@ -706,20 +687,9 @@
 	m_end = m_start + vol->mft_record_size;
 	do {
 		block_end = block_start + blocksize;
-		/*
-		 * If the buffer is outside the mft record, just skip it,
-		 * clearing it if it is dirty to make sure it is not written
-		 * out.  It should never be marked dirty but better be safe.
-		 */
-		if ((block_end <= m_start) || (block_start >= m_end)) {
-			if (buffer_dirty(bh)) {
-				ntfs_warning(vol->sb, "Clearing dirty mft "
-						"record page buffer.  %s",
-						ntfs_please_email);
-				clear_buffer_dirty(bh);
-			}
+		/* If the buffer is outside the mft record, skip it. */
+		if ((block_end <= m_start) || (block_start >= m_end))
 			continue;
-		}
 		if (!buffer_mapped(bh)) {
 			ntfs_error(vol->sb, "Writing mft records without "
 					"existing mapped buffers is not "
