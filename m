Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269352AbUJSKKj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269352AbUJSKKj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 06:10:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269360AbUJSKHb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 06:07:31 -0400
Received: from ppsw-5.csi.cam.ac.uk ([131.111.8.135]:12518 "EHLO
	ppsw-5.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S268168AbUJSJo6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 05:44:58 -0400
Date: Tue, 19 Oct 2004 10:44:54 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-ntfs-dev@lists.sourceforge.net
Subject: [PATCH 25/37] Re: [2.6-BK-URL] NTFS: 2.1.21 - Big update with race/bug
 fixes
In-Reply-To: <Pine.LNX.4.60.0410191044280.24986@hermes-1.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.60.0410191044420.24986@hermes-1.csi.cam.ac.uk>
References: <Pine.LNX.4.60.0410191017070.24986@hermes-1.csi.cam.ac.uk>
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
 <Pine.LNX.4.60.0410191044130.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191044280.24986@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is patch 25/37 in the series.  It contains the following ChangeSet:

<aia21@cantab.net> (04/10/12 1.2041.1.3)
   NTFS: Map the page instead of using page_address() before writing to it in
         fs/ntfs/aops.c::ntfs_mft_writepage().
   
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
--- a/fs/ntfs/ChangeLog	2004-10-19 10:14:36 +01:00
+++ b/fs/ntfs/ChangeLog	2004-10-19 10:14:36 +01:00
@@ -80,6 +80,8 @@
 	  the bug check from fs/ntfs/aops.c::ntfs_write_mst_block().  It is in
 	  fact required to write outside initialized size when preparing to
 	  extend the initialized size.
+	- Map the page instead of using page_address() before writing to it in
+	  fs/ntfs/aops.c::ntfs_mft_writepage().
 
 2.1.20 - Fix two stupid bugs introduced in 2.1.18 release.
 
diff -Nru a/fs/ntfs/aops.c b/fs/ntfs/aops.c
--- a/fs/ntfs/aops.c	2004-10-19 10:14:36 +01:00
+++ b/fs/ntfs/aops.c	2004-10-19 10:14:36 +01:00
@@ -917,7 +917,7 @@
 	if (!nr_bhs)
 		goto done;
 	/* Apply the mst protection fixups. */
-	kaddr = page_address(page);
+	kaddr = kmap(page);
 	for (i = 0; i < nr_bhs; i++) {
 		if (!(i % bhs_per_rec)) {
 			err = pre_write_mst_fixup((NTFS_RECORD*)(kaddr +
@@ -974,6 +974,7 @@
 					bh_offset(bhs[i])));
 	}
 	flush_dcache_page(page);
+	kunmap(page);
 	if (unlikely(err)) {
 		/* I/O error during writing.  This is really bad! */
 		ntfs_error(vol->sb, "I/O error while writing ntfs record "
@@ -996,6 +997,7 @@
 			post_write_mst_fixup((NTFS_RECORD*)(kaddr +
 					bh_offset(bhs[i])));
 	}
+	kunmap(page);
 cleanup_out:
 	/* Clean the buffers. */
 	for (i = 0; i < nr_bhs; i++)
