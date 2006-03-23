Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422636AbWCWR2q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422636AbWCWR2q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 12:28:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422637AbWCWR2q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 12:28:46 -0500
Received: from ppsw-9.csi.cam.ac.uk ([131.111.8.139]:33929 "EHLO
	ppsw-9.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S1422636AbWCWR2o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 12:28:44 -0500
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Date: Thu, 23 Mar 2006 17:28:28 +0000 (GMT)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net
Subject: [PATCH 11/14] NTFS: Add a missing call to flush_dcache_mft_record_page()
In-Reply-To: <Pine.LNX.4.64.0603231727040.18984@hermes-2.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.64.0603231727450.18984@hermes-2.csi.cam.ac.uk>
References: <Pine.LNX.4.64.0603231713430.18984@hermes-2.csi.cam.ac.uk>
 <Pine.LNX.4.64.0603231717460.18984@hermes-2.csi.cam.ac.uk>
 <Pine.LNX.4.64.0603231720130.18984@hermes-2.csi.cam.ac.uk>
 <Pine.LNX.4.64.0603231721240.18984@hermes-2.csi.cam.ac.uk>
 <Pine.LNX.4.64.0603231722330.18984@hermes-2.csi.cam.ac.uk>
 <Pine.LNX.4.64.0603231723320.18984@hermes-2.csi.cam.ac.uk>
 <Pine.LNX.4.64.0603231724200.18984@hermes-2.csi.cam.ac.uk>
 <Pine.LNX.4.64.0603231724570.18984@hermes-2.csi.cam.ac.uk>
 <Pine.LNX.4.64.0603231725420.18984@hermes-2.csi.cam.ac.uk>
 <Pine.LNX.4.64.0603231726250.18984@hermes-2.csi.cam.ac.uk>
 <Pine.LNX.4.64.0603231727040.18984@hermes-2.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

NTFS: Add a missing call to flush_dcache_mft_record_page() in
      fs/ntfs/inode.c::ntfs_write_inode().

Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

---

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

 fs/ntfs/ChangeLog |    2 ++
 fs/ntfs/inode.c   |    9 ++++++---
 2 files changed, 8 insertions(+), 3 deletions(-)

20fdcf1d543b1285ef8b1c1993a9221f2eda52dc
diff --git a/fs/ntfs/ChangeLog b/fs/ntfs/ChangeLog
index 5fb74e6..d200315 100644
--- a/fs/ntfs/ChangeLog
+++ b/fs/ntfs/ChangeLog
@@ -41,6 +41,8 @@ ToDo/Notes:
 	- Fix a bug in fs/ntfs/inode.c::ntfs_read_locked_index_inode() where we
 	  forgot to update a temporary variable so loading index inodes which
 	  have an index allocation attribute failed.
+	- Add a missing call to flush_dcache_mft_record_page() in
+	  fs/ntfs/inode.c::ntfs_write_inode().
 
 2.1.26 - Minor bug fixes and updates.
 
diff --git a/fs/ntfs/inode.c b/fs/ntfs/inode.c
index 5f4b23d..73791b2 100644
--- a/fs/ntfs/inode.c
+++ b/fs/ntfs/inode.c
@@ -3064,9 +3064,12 @@ int ntfs_write_inode(struct inode *vi, i
 	 * record will be cleaned and written out to disk below, i.e. before
 	 * this function returns.
 	 */
-	if (modified && !NInoTestSetDirty(ctx->ntfs_ino))
-		mark_ntfs_record_dirty(ctx->ntfs_ino->page,
-				ctx->ntfs_ino->page_ofs);
+	if (modified) {
+		flush_dcache_mft_record_page(ctx->ntfs_ino);
+		if (!NInoTestSetDirty(ctx->ntfs_ino)) {
+			mark_ntfs_record_dirty(ctx->ntfs_ino->page,
+					ctx->ntfs_ino->page_ofs);
+	}
 	ntfs_attr_put_search_ctx(ctx);
 	/* Now the access times are updated, write the base mft record. */
 	if (NInoDirty(ni))
-- 
1.2.3.g9821

