Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269360AbUJSKKk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269360AbUJSKKk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 06:10:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268168AbUJSKHr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 06:07:47 -0400
Received: from ppsw-5.csi.cam.ac.uk ([131.111.8.135]:38374 "EHLO
	ppsw-5.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S268175AbUJSJpO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 05:45:14 -0400
Date: Tue, 19 Oct 2004 10:45:08 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-ntfs-dev@lists.sourceforge.net
Subject: [PATCH 26/37] Re: [2.6-BK-URL] NTFS: 2.1.21 - Big update with race/bug
 fixes
In-Reply-To: <Pine.LNX.4.60.0410191044420.24986@hermes-1.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.60.0410191044560.24986@hermes-1.csi.cam.ac.uk>
References: <Pine.LNX.4.60.0410191017070.24986@hermes-1.csi.cam.ac.uk>
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
 <Pine.LNX.4.60.0410191044130.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191044280.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191044420.24986@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is patch 26/37 in the series.  It contains the following ChangeSet:

<aia21@cantab.net> (04/10/12 1.2041.1.4)
   NTFS: Provide exclusion between opening an inode / mapping an mft record
         and accessing the mft record in fs/ntfs/mft.c::ntfs_mft_writepage()
         by setting the page not uptodate throughout ntfs_mft_writepage().
   
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
--- a/fs/ntfs/ChangeLog	2004-10-19 10:14:40 +01:00
+++ b/fs/ntfs/ChangeLog	2004-10-19 10:14:40 +01:00
@@ -82,6 +82,9 @@
 	  extend the initialized size.
 	- Map the page instead of using page_address() before writing to it in
 	  fs/ntfs/aops.c::ntfs_mft_writepage().
+	- Provide exclusion between opening an inode / mapping an mft record
+	  and accessing the mft record in fs/ntfs/mft.c::ntfs_mft_writepage()
+	  by setting the page not uptodate throughout ntfs_mft_writepage().
 
 2.1.20 - Fix two stupid bugs introduced in 2.1.18 release.
 
diff -Nru a/fs/ntfs/mft.c b/fs/ntfs/mft.c
--- a/fs/ntfs/mft.c	2004-10-19 10:14:40 +01:00
+++ b/fs/ntfs/mft.c	2004-10-19 10:14:40 +01:00
@@ -724,18 +724,9 @@
 	 */
 	if (!NInoTestClearDirty(ni))
 		goto done;
-	/* Make sure we have mapped buffers. */
-	if (!page_has_buffers(page)) {
-no_buffers_err_out:
-		ntfs_error(vol->sb, "Writing mft records without existing "
-				"buffers is not implemented yet.  %s",
-				ntfs_please_email);
-		err = -EOPNOTSUPP;
-		goto err_out;
-	}
+	BUG_ON(!page_has_buffers(page));
 	bh = head = page_buffers(page);
-	if (!bh)
-		goto no_buffers_err_out;
+	BUG_ON(!bh);
 	nr_bhs = 0;
 	block_start = 0;
 	m_start = ni->page_ofs;
@@ -892,6 +883,12 @@
 	ntfs_debug("Entering for %i inodes starting at 0x%lx.", nr, mft_no);
 	/* Iterate over the mft records in the page looking for a dirty one. */
 	maddr = (u8*)kmap(page);
+	/*
+	 * Clear the page uptodate flag.  This will cause anyone trying to get
+	 * hold of the page to block on the page lock in read_cache_page().
+	 */
+	BUG_ON(!PageUptodate(page));
+	ClearPageUptodate(page);
 	for (i = 0; i < nr; ++i, ++mft_no, maddr += vol->mft_record_size) {
 		struct inode *vi;
 		ntfs_inode *ni, *eni;
@@ -1034,6 +1031,7 @@
 		up(&ni->extent_lock);
 		iput(vi);
 	}
+	SetPageUptodate(page);
 	kunmap(page);
 	/* If a dirty mft record was found, redirty the page. */
 	if (is_dirty) {
