Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030181AbVIIJ2T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030181AbVIIJ2T (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 05:28:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030186AbVIIJ2S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 05:28:18 -0400
Received: from ppsw-0.csi.cam.ac.uk ([131.111.8.130]:15540 "EHLO
	ppsw-0.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S1030189AbVIIJ2Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 05:28:16 -0400
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Date: Fri, 9 Sep 2005 10:28:00 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net
Subject: [PATCH 16/25] NTFS: Truncate {a,c,m}time to the ntfs supported time
 granularity when
In-Reply-To: <Pine.LNX.4.60.0509090950100.11051@hermes-1.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.60.0509091027420.26845@hermes-1.csi.cam.ac.uk>
References: <Pine.LNX.4.60.0509090950100.11051@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH 16/25] NTFS: Truncate {a,c,m}time to the ntfs supported time granularity when
      updating the times in the inode in ntfs_setattr().

Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

---

 fs/ntfs/ChangeLog |    2 ++
 fs/ntfs/inode.c   |   12 +++++++-----
 2 files changed, 9 insertions(+), 5 deletions(-)

1c7d469d47668f4664b892a6cd1c452a0c02d710
diff --git a/fs/ntfs/ChangeLog b/fs/ntfs/ChangeLog
--- a/fs/ntfs/ChangeLog
+++ b/fs/ntfs/ChangeLog
@@ -73,6 +73,8 @@ ToDo/Notes:
 	- Fix cluster (de)allocators to work when the runlist is NULL and more
 	  importantly to take a locked runlist rather than them locking it
 	  which leads to lock reversal.
+	- Truncate {a,c,m}time to the ntfs supported time granularity when
+	  updating the times in the inode in ntfs_setattr().
 
 2.1.23 - Implement extension of resident files and make writing safe as well as
 	 many bug fixes, cleanups, and enhancements...
diff --git a/fs/ntfs/inode.c b/fs/ntfs/inode.c
--- a/fs/ntfs/inode.c
+++ b/fs/ntfs/inode.c
@@ -2430,16 +2430,18 @@ int ntfs_setattr(struct dentry *dentry, 
 			 * We skipped the truncate but must still update
 			 * timestamps.
 			 */
-			ia_valid |= ATTR_MTIME|ATTR_CTIME;
+			ia_valid |= ATTR_MTIME | ATTR_CTIME;
 		}
 	}
-
 	if (ia_valid & ATTR_ATIME)
-		vi->i_atime = attr->ia_atime;
+		vi->i_atime = timespec_trunc(attr->ia_atime,
+				vi->i_sb->s_time_gran);
 	if (ia_valid & ATTR_MTIME)
-		vi->i_mtime = attr->ia_mtime;
+		vi->i_mtime = timespec_trunc(attr->ia_mtime,
+				vi->i_sb->s_time_gran);
 	if (ia_valid & ATTR_CTIME)
-		vi->i_ctime = attr->ia_ctime;
+		vi->i_ctime = timespec_trunc(attr->ia_ctime,
+				vi->i_sb->s_time_gran);
 	mark_inode_dirty(vi);
 out:
 	return err;
