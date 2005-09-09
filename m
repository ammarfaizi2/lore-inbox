Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965120AbVIIJWE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965120AbVIIJWE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 05:22:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965121AbVIIJWE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 05:22:04 -0400
Received: from ppsw-7.csi.cam.ac.uk ([131.111.8.137]:39888 "EHLO
	ppsw-7.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S965120AbVIIJWD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 05:22:03 -0400
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Date: Fri, 9 Sep 2005 10:22:00 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net
Subject: [PATCH 4/25] NTFS: Fix two nasty runlist merging bugs that had gone
 unnoticed so far.
In-Reply-To: <Pine.LNX.4.60.0509090950100.11051@hermes-1.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.60.0509091021200.26845@hermes-1.csi.cam.ac.uk>
References: <Pine.LNX.4.60.0509090950100.11051@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH 4/25] NTFS: Fix two nasty runlist merging bugs that had gone unnoticed
so far.  Thanks to Stefano Picerno for the bug report.

Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

---

 fs/ntfs/ChangeLog |    2 ++
 fs/ntfs/runlist.c |    5 +++--
 2 files changed, 5 insertions(+), 2 deletions(-)

84d6ebe63f50b6efd8be252b58a207132157c60f
diff --git a/fs/ntfs/ChangeLog b/fs/ntfs/ChangeLog
--- a/fs/ntfs/ChangeLog
+++ b/fs/ntfs/ChangeLog
@@ -43,6 +43,8 @@ ToDo/Notes:
 	- Use ntfs_malloc_nofs_nofail() in the two critical regions in
 	  fs/ntfs/runlist.c::ntfs_runlists_merge().  This means we no longer
 	  need to panic() if the allocation fails as it now cannot fail.
+	- Fix two nasty runlist merging bugs that had gone unnoticed so far.
+	  Thanks to Stefano Picerno for the bug report.
 
 2.1.23 - Implement extension of resident files and make writing safe as well as
 	 many bug fixes, cleanups, and enhancements...
diff --git a/fs/ntfs/runlist.c b/fs/ntfs/runlist.c
--- a/fs/ntfs/runlist.c
+++ b/fs/ntfs/runlist.c
@@ -542,6 +542,7 @@ runlist_element *ntfs_runlists_merge(run
 			/* Scan to the end of the source runlist. */
 			for (dend = 0; likely(drl[dend].length); dend++)
 				;
+			dend++;
 			drl = ntfs_rl_realloc(drl, dend, dend + 1);
 			if (IS_ERR(drl))
 				return drl;
@@ -611,8 +612,8 @@ runlist_element *ntfs_runlists_merge(run
 		 ((drl[dins].vcn + drl[dins].length) <=      /* End of hole   */
 		  (srl[send - 1].vcn + srl[send - 1].length)));
 
-	/* Or we'll lose an end marker */
-	if (start && finish && (drl[dins].length == 0))
+	/* Or we will lose an end marker. */
+	if (finish && !drl[dins].length)
 		ss++;
 	if (marker && (drl[dins].vcn + drl[dins].length > srl[send - 1].vcn))
 		finish = FALSE;
