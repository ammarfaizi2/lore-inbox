Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965125AbVIIJX6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965125AbVIIJX6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 05:23:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965128AbVIIJX6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 05:23:58 -0400
Received: from ppsw-9.csi.cam.ac.uk ([131.111.8.139]:56972 "EHLO
	ppsw-9.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S965125AbVIIJX4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 05:23:56 -0400
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Date: Fri, 9 Sep 2005 10:23:53 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net
Subject: [PATCH 8/25] NTFS: Change ntfs_rl_truncate_nolock() to throw away
 the runlist if the new
In-Reply-To: <Pine.LNX.4.60.0509090950100.11051@hermes-1.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.60.0509091023280.26845@hermes-1.csi.cam.ac.uk>
References: <Pine.LNX.4.60.0509090950100.11051@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH 8/25] NTFS: Change ntfs_rl_truncate_nolock() to throw away the runlist if the new
      length is zero.

Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

---

 fs/ntfs/ChangeLog |    2 ++
 fs/ntfs/runlist.c |   14 +++++++++++++-
 2 files changed, 15 insertions(+), 1 deletions(-)

3ffc5a443824fcf426d8d35dc632acc4dd9fb6d1
diff --git a/fs/ntfs/ChangeLog b/fs/ntfs/ChangeLog
--- a/fs/ntfs/ChangeLog
+++ b/fs/ntfs/ChangeLog
@@ -51,6 +51,8 @@ ToDo/Notes:
 	- Report unrepresentable inodes during ntfs_readdir() as KERN_WARNING
 	  messages and include the inode number.  Thanks to Yura Pakhuchiy for
 	  pointing this out.
+	- Change ntfs_rl_truncate_nolock() to throw away the runlist if the new
+	  length is zero.
 
 2.1.23 - Implement extension of resident files and make writing safe as well as
 	 many bug fixes, cleanups, and enhancements...
diff --git a/fs/ntfs/runlist.c b/fs/ntfs/runlist.c
--- a/fs/ntfs/runlist.c
+++ b/fs/ntfs/runlist.c
@@ -1455,6 +1455,7 @@ err_out:
 
 /**
  * ntfs_rl_truncate_nolock - truncate a runlist starting at a specified vcn
+ * @vol:	ntfs volume (needed for error output)
  * @runlist:	runlist to truncate
  * @new_length:	the new length of the runlist in VCNs
  *
@@ -1462,12 +1463,16 @@ err_out:
  * holding the runlist elements to a length of @new_length VCNs.
  *
  * If @new_length lies within the runlist, the runlist elements with VCNs of
- * @new_length and above are discarded.
+ * @new_length and above are discarded.  As a special case if @new_length is
+ * zero, the runlist is discarded and set to NULL.
  *
  * If @new_length lies beyond the runlist, a sparse runlist element is added to
  * the end of the runlist @runlist or if the last runlist element is a sparse
  * one already, this is extended.
  *
+ * Note, no checking is done for unmapped runlist elements.  It is assumed that
+ * the caller has mapped any elements that need to be mapped already.
+ *
  * Return 0 on success and -errno on error.
  *
  * Locking: The caller must hold @runlist->lock for writing.
@@ -1482,6 +1487,13 @@ int ntfs_rl_truncate_nolock(const ntfs_v
 	BUG_ON(!runlist);
 	BUG_ON(new_length < 0);
 	rl = runlist->rl;
+	if (!new_length) {
+		ntfs_debug("Freeing runlist.");
+		runlist->rl = NULL;
+		if (rl)
+			ntfs_free(rl);
+		return 0;
+	}
 	if (unlikely(!rl)) {
 		/*
 		 * Create a runlist consisting of a sparse runlist element of
