Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751336AbVJaOcP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751336AbVJaOcP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 09:32:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751290AbVJaOcP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 09:32:15 -0500
Received: from ppsw-7.csi.cam.ac.uk ([131.111.8.137]:61849 "EHLO
	ppsw-7.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S1751336AbVJaOcN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 09:32:13 -0500
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Date: Mon, 31 Oct 2005 14:32:07 +0000 (GMT)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net
Subject: [PATCH 9/17] NTFS: Enable ATTR_SIZE attribute changes in ntfs_setattr().
In-Reply-To: <Pine.LNX.4.64.0510311408160.27357@hermes-1.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.64.0510311431350.27357@hermes-1.csi.cam.ac.uk>
References: <Pine.LNX.4.64.0510311408160.27357@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

NTFS: Enable ATTR_SIZE attribute changes in ntfs_setattr().  This completes
      the initial implementation of file truncation.  Now both open(2)ing
      a file with the O_TRUNC flag and the {,f}truncate(2) system calls
      will resize a file appropriately.  The limitations are that only
      uncompressed and unencrypted files are supported.  Also, there is
      only very limited support for highly fragmented files (the ones whose
      $DATA attribute is split into multiple attribute extents).

Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

---

 fs/ntfs/ChangeLog |    7 +++++++
 fs/ntfs/inode.c   |   23 +++++++++++++++--------
 2 files changed, 22 insertions(+), 8 deletions(-)

applies-to: d0282b4667e3fcedc893802bd54c90c9e12b2dc7
e9438250b635f7832e99a8c8d2e394dd1522ce65
diff --git a/fs/ntfs/ChangeLog b/fs/ntfs/ChangeLog
index 70ad4be..9f4674a 100644
--- a/fs/ntfs/ChangeLog
+++ b/fs/ntfs/ChangeLog
@@ -50,6 +50,13 @@ ToDo/Notes:
 	  but not the initialized size can be extended, too.
 	- Implement fs/ntfs/inode.[hc]::ntfs_truncate().  It only supports
 	  uncompressed and unencrypted files.
+	- Enable ATTR_SIZE attribute changes in ntfs_setattr().  This completes
+	  the initial implementation of file truncation.  Now both open(2)ing
+	  a file with the O_TRUNC flag and the {,f}truncate(2) system calls
+	  will resize a file appropriately.  The limitations are that only
+	  uncompressed and unencrypted files are supported.  Also, there is
+	  only very limited support for highly fragmented files (the ones whose
+	  $DATA attribute is split into multiple attribute extents).
 
 2.1.24 - Lots of bug fixes and support more clean journal states.
 
diff --git a/fs/ntfs/inode.c b/fs/ntfs/inode.c
index a168234..b24f4c4 100644
--- a/fs/ntfs/inode.c
+++ b/fs/ntfs/inode.c
@@ -2845,8 +2845,7 @@ int ntfs_setattr(struct dentry *dentry, 
 
 	err = inode_change_ok(vi, attr);
 	if (err)
-		return err;
-
+		goto out;
 	/* We do not support NTFS ACLs yet. */
 	if (ia_valid & (ATTR_UID | ATTR_GID | ATTR_MODE)) {
 		ntfs_warning(vi->i_sb, "Changes in user/group/mode are not "
@@ -2854,14 +2853,22 @@ int ntfs_setattr(struct dentry *dentry, 
 		err = -EOPNOTSUPP;
 		goto out;
 	}
-
 	if (ia_valid & ATTR_SIZE) {
 		if (attr->ia_size != i_size_read(vi)) {
-			ntfs_warning(vi->i_sb, "Changes in inode size are not "
-					"supported yet, ignoring.");
-			err = -EOPNOTSUPP;
-			// TODO: Implement...
-			// err = vmtruncate(vi, attr->ia_size);
+			ntfs_inode *ni = NTFS_I(vi);
+			/*
+			 * FIXME: For now we do not support resizing of
+			 * compressed or encrypted files yet.
+			 */
+			if (NInoCompressed(ni) || NInoEncrypted(ni)) {
+				ntfs_warning(vi->i_sb, "Changes in inode size "
+						"are not supported yet for "
+						"%s files, ignoring.",
+						NInoCompressed(ni) ?
+						"compressed" : "encrypted");
+				err = -EOPNOTSUPP;
+			} else
+				err = vmtruncate(vi, attr->ia_size);
 			if (err || ia_valid == ATTR_SIZE)
 				goto out;
 		} else {
---
0.99.9
