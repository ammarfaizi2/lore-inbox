Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030186AbVIIJ27@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030186AbVIIJ27 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 05:28:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030198AbVIIJ27
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 05:28:59 -0400
Received: from ppsw-0.csi.cam.ac.uk ([131.111.8.130]:52405 "EHLO
	ppsw-0.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S1030186AbVIIJ25 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 05:28:57 -0400
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Date: Fri, 9 Sep 2005 10:28:45 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net
Subject: [PATCH 18/25] NTFS: Make ntfs_write_block() not instantiate sparse
 blocks if they are zero.
In-Reply-To: <Pine.LNX.4.60.0509090950100.11051@hermes-1.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.60.0509091028290.26845@hermes-1.csi.cam.ac.uk>
References: <Pine.LNX.4.60.0509090950100.11051@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH 18/25] NTFS: Make ntfs_write_block() not instantiate sparse blocks if they are zero.

Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

---

 fs/ntfs/ChangeLog |    2 ++
 fs/ntfs/aops.c    |   21 +++++++++++++++++++++
 2 files changed, 23 insertions(+), 0 deletions(-)

8dcdebafb848415eae25924b00c4f0b9ec907da0
diff --git a/fs/ntfs/ChangeLog b/fs/ntfs/ChangeLog
--- a/fs/ntfs/ChangeLog
+++ b/fs/ntfs/ChangeLog
@@ -77,6 +77,8 @@ ToDo/Notes:
 	  updating the times in the inode in ntfs_setattr().
 	- Fixup handling of sparse, compressed, and encrypted attributes in
 	  fs/ntfs/inode.c::ntfs_read_locked_{,attr_,index_}inode().
+	- Make ntfs_write_block() not instantiate sparse blocks if they contain
+	  only zeroes.
 
 2.1.23 - Implement extension of resident files and make writing safe as well as
 	 many bug fixes, cleanups, and enhancements...
diff --git a/fs/ntfs/aops.c b/fs/ntfs/aops.c
--- a/fs/ntfs/aops.c
+++ b/fs/ntfs/aops.c
@@ -670,6 +670,27 @@ lock_retry_remap:
 		}
 		/* It is a hole, need to instantiate it. */
 		if (lcn == LCN_HOLE) {
+			u8 *kaddr;
+			unsigned long *bpos, *bend;
+
+			/* Check if the buffer is zero. */
+			kaddr = kmap_atomic(page, KM_USER0);
+			bpos = (unsigned long *)(kaddr + bh_offset(bh));
+			bend = (unsigned long *)((u8*)bpos + blocksize);
+			do {
+				if (unlikely(*bpos))
+					break;
+			} while (likely(++bpos < bend));
+			kunmap_atomic(kaddr, KM_USER0);
+			if (bpos == bend) {
+				/*
+				 * Buffer is zero and sparse, no need to write
+				 * it.
+				 */
+				bh->b_blocknr = -1;
+				clear_buffer_dirty(bh);
+				continue;
+			}
 			// TODO: Instantiate the hole.
 			// clear_buffer_new(bh);
 			// unmap_underlying_metadata(bh->b_bdev, bh->b_blocknr);
