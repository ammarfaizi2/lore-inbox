Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268149AbUJSKFX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268149AbUJSKFX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 06:05:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268716AbUJSKEF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 06:04:05 -0400
Received: from ppsw-6.csi.cam.ac.uk ([131.111.8.136]:712 "EHLO
	ppsw-6.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S268148AbUJSJnl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 05:43:41 -0400
Date: Tue, 19 Oct 2004 10:43:35 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-ntfs-dev@lists.sourceforge.net
Subject: [PATCH 20/37] Re: [2.6-BK-URL] NTFS: 2.1.21 - Big update with race/bug
 fixes
In-Reply-To: <Pine.LNX.4.60.0410191043100.24986@hermes-1.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.60.0410191043240.24986@hermes-1.csi.cam.ac.uk>
References: <Pine.LNX.4.60.0410191017070.24986@hermes-1.csi.cam.ac.uk>
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
 <Pine.LNX.4.60.0410191043100.24986@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is patch 20/37 in the series.  It contains the following ChangeSet:

<aia21@cantab.net> (04/10/10 1.2032.1.1)
   NTFS: Update fs/ntfs/inode.c::ntfs_write_inode() to also use the helper
         mark_ntfs_record_dirty() and thus to set the buffers belonging to the
         mft record dirty as well as the page itself.
   
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
--- a/fs/ntfs/ChangeLog	2004-10-19 10:14:18 +01:00
+++ b/fs/ntfs/ChangeLog	2004-10-19 10:14:18 +01:00
@@ -65,6 +65,9 @@
 	  page itself.
 	- Update fs/ntfs/mft.c::write_mft_record_nolock() and sync_mft_mirror()
 	  to cope with the fact that there now are dirty buffers in mft pages.
+	- Update fs/ntfs/inode.c::ntfs_write_inode() to also use the helper
+	  mark_ntfs_record_dirty() and thus to set the buffers belonging to the
+	  mft record dirty as well as the page itself.
 
 2.1.20 - Fix two stupid bugs introduced in 2.1.18 release.
 
diff -Nru a/fs/ntfs/inode.c b/fs/ntfs/inode.c
--- a/fs/ntfs/inode.c	2004-10-19 10:14:18 +01:00
+++ b/fs/ntfs/inode.c	2004-10-19 10:14:18 +01:00
@@ -2271,7 +2271,7 @@
  * ntfs_truncate - called when the i_size of an ntfs inode is changed
  * @vi:		inode for which the i_size was changed
  *
- * We don't support i_size changes yet.
+ * We do not support i_size changes yet.
  *
  * The kernel guarantees that @vi is a regular file (S_ISREG() is true) and
  * that the change is allowed.
@@ -2505,9 +2505,16 @@
 	 * dirty, since we are going to write this mft record below in any case
 	 * and the base mft record may actually not have been modified so it
 	 * might not need to be written out.
+	 * NOTE: It is not a problem when the inode for $MFT itself is being
+	 * written out as mark_ntfs_record_dirty() will only set I_DIRTY_PAGES
+	 * on the $MFT inode and hence ntfs_write_inode() will not be
+	 * re-invoked because of it which in turn is ok since the dirtied mft
+	 * record will be cleaned and written out to disk below, i.e. before
+	 * this function returns.
 	 */
 	if (modified && !NInoTestSetDirty(ctx->ntfs_ino))
-		__set_page_dirty_nobuffers(ctx->ntfs_ino->page);
+		mark_ntfs_record_dirty(ctx->ntfs_ino, ctx->ntfs_ino->page,
+				ctx->ntfs_ino->page_ofs);
 	ntfs_attr_put_search_ctx(ctx);
 	/* Now the access times are updated, write the base mft record. */
 	if (NInoDirty(ni))
