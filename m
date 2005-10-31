Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751307AbVJaO3M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751307AbVJaO3M (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 09:29:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751303AbVJaO3L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 09:29:11 -0500
Received: from ppsw-0.csi.cam.ac.uk ([131.111.8.130]:12213 "EHLO
	ppsw-0.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S1751290AbVJaO3J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 09:29:09 -0500
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Date: Mon, 31 Oct 2005 14:29:02 +0000 (GMT)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net
Subject: [PATCH 6/17] NTFS: Fix ntfs_attr_make_non_resident() to update the
 vfs inode i_blocks
In-Reply-To: <Pine.LNX.4.64.0510311408160.27357@hermes-1.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.64.0510311428230.27357@hermes-1.csi.cam.ac.uk>
References: <Pine.LNX.4.64.0510311408160.27357@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

NTFS: Fix ntfs_attr_make_non_resident() to update the vfs inode i_blocks
      which is zero for a resident attribute but should no longer be zero
      once the attribute is non-resident as it then has real clusters
      allocated.

Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

---

 fs/ntfs/ChangeLog |    4 ++++
 fs/ntfs/attrib.c  |    4 +++-
 2 files changed, 7 insertions(+), 1 deletions(-)

applies-to: fc740f0fbc17edc8b855c27c02d074679a0f0f03
2a6fc4e1b0f7d2ec3711d5b1782fb30f78cca765
diff --git a/fs/ntfs/ChangeLog b/fs/ntfs/ChangeLog
index 60ba3c5..045beda 100644
--- a/fs/ntfs/ChangeLog
+++ b/fs/ntfs/ChangeLog
@@ -43,6 +43,10 @@ ToDo/Notes:
 	  reason we cannot simply read the size from the vfs inode i_size is
 	  that this is not necessarily uptodate.  This happens when
 	  ntfs_attr_make_non_resident() is called in the ->truncate call path.
+	- Fix ntfs_attr_make_non_resident() to update the vfs inode i_blocks
+	  which is zero for a resident attribute but should no longer be zero
+	  once the attribute is non-resident as it then has real clusters
+	  allocated.
 
 2.1.24 - Lots of bug fixes and support more clean journal states.
 
diff --git a/fs/ntfs/attrib.c b/fs/ntfs/attrib.c
index 380f70a..8821e2d 100644
--- a/fs/ntfs/attrib.c
+++ b/fs/ntfs/attrib.c
@@ -1719,7 +1719,9 @@ int ntfs_attr_make_non_resident(ntfs_ino
 				ffs(ni->itype.compressed.block_size) - 1;
 		ni->itype.compressed.block_clusters = 1U <<
 				a->data.non_resident.compression_unit;
-	}
+		vi->i_blocks = ni->itype.compressed.size >> 9;
+	} else
+		vi->i_blocks = ni->allocated_size >> 9;
 	write_unlock_irqrestore(&ni->size_lock, flags);
 	/*
 	 * This needs to be last since the address space operations ->readpage
---
0.99.9
