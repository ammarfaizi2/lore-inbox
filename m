Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965124AbVIIJXn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965124AbVIIJXn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 05:23:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965126AbVIIJXn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 05:23:43 -0400
Received: from ppsw-1.csi.cam.ac.uk ([131.111.8.131]:28614 "EHLO
	ppsw-1.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S965124AbVIIJXm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 05:23:42 -0400
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Date: Fri, 9 Sep 2005 10:23:26 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net
Subject: [PATCH 7/25] NTFS: Report unrepresentable inodes during ntfs_readdir()
 as KERN_WARNING
In-Reply-To: <Pine.LNX.4.60.0509090950100.11051@hermes-1.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.60.0509091023000.26845@hermes-1.csi.cam.ac.uk>
References: <Pine.LNX.4.60.0509090950100.11051@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH 7/25] NTFS: Report unrepresentable inodes during ntfs_readdir() as KERN_WARNING
      messages and include the inode number.  Thanks to Yura Pakhuchiy for
      pointing this out.

Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

---

 fs/ntfs/ChangeLog |    3 +++
 fs/ntfs/dir.c     |    3 ++-
 fs/ntfs/unistr.c  |    3 ++-
 3 files changed, 7 insertions(+), 2 deletions(-)

f94ad38e68e1623660fdbb063d0c580ba6661c29
diff --git a/fs/ntfs/ChangeLog b/fs/ntfs/ChangeLog
--- a/fs/ntfs/ChangeLog
+++ b/fs/ntfs/ChangeLog
@@ -48,6 +48,9 @@ ToDo/Notes:
 	- Remove two bogus BUG_ON()s from fs/ntfs/mft.c.
 	- Fix handling of valid but empty mapping pairs array in
 	  fs/ntfs/runlist.c::ntfs_mapping_pairs_decompress().
+	- Report unrepresentable inodes during ntfs_readdir() as KERN_WARNING
+	  messages and include the inode number.  Thanks to Yura Pakhuchiy for
+	  pointing this out.
 
 2.1.23 - Implement extension of resident files and make writing safe as well as
 	 many bug fixes, cleanups, and enhancements...
diff --git a/fs/ntfs/dir.c b/fs/ntfs/dir.c
--- a/fs/ntfs/dir.c
+++ b/fs/ntfs/dir.c
@@ -1051,7 +1051,8 @@ static inline int ntfs_filldir(ntfs_volu
 			ie->key.file_name.file_name_length, &name,
 			NTFS_MAX_NAME_LEN * NLS_MAX_CHARSET_SIZE + 1);
 	if (name_len <= 0) {
-		ntfs_debug("Skipping unrepresentable file.");
+		ntfs_warning(vol->sb, "Skipping unrepresentable inode 0x%llx.",
+				(long long)MREF_LE(ie->data.dir.indexed_file));
 		return 0;
 	}
 	if (ie->key.file_name.file_attributes &
diff --git a/fs/ntfs/unistr.c b/fs/ntfs/unistr.c
--- a/fs/ntfs/unistr.c
+++ b/fs/ntfs/unistr.c
@@ -372,7 +372,8 @@ retry:			wc = nls->uni2char(le16_to_cpu(
 	return -EINVAL;
 conversion_err:
 	ntfs_error(vol->sb, "Unicode name contains characters that cannot be "
-			"converted to character set %s.", nls->charset);
+			"converted to character set %s.  You might want to "
+			"try to use the mount option nls=utf8.", nls->charset);
 	if (ns != *outs)
 		kfree(ns);
 	if (wc != -ENAMETOOLONG)
