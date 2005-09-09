Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030182AbVIIJ0K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030182AbVIIJ0K (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 05:26:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030183AbVIIJ0J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 05:26:09 -0400
Received: from ppsw-9.csi.cam.ac.uk ([131.111.8.139]:64655 "EHLO
	ppsw-9.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S1030182AbVIIJ0G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 05:26:06 -0400
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Date: Fri, 9 Sep 2005 10:25:51 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net
Subject: [PATCH 11/25] NTFS: Remove bogus setting of PageError in
 ntfs_read_compressed_block().
In-Reply-To: <Pine.LNX.4.60.0509090950100.11051@hermes-1.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.60.0509091025300.26845@hermes-1.csi.cam.ac.uk>
References: <Pine.LNX.4.60.0509090950100.11051@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH 11/25] NTFS: Remove bogus setting of PageError in ntfs_read_compressed_block().

Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

---

 fs/ntfs/ChangeLog  |    1 +
 fs/ntfs/compress.c |    8 --------
 fs/ntfs/file.c     |    9 +++++++--
 3 files changed, 8 insertions(+), 10 deletions(-)

f25dfb5e44fa8641961780d681bc1871abcfb861
diff --git a/fs/ntfs/ChangeLog b/fs/ntfs/ChangeLog
--- a/fs/ntfs/ChangeLog
+++ b/fs/ntfs/ChangeLog
@@ -58,6 +58,7 @@ ToDo/Notes:
 	- Fix a bug in fs/ntfs/index.c::ntfs_index_lookup().  When the returned
 	  index entry is in the index root, we forgot to set the @ir pointer in
 	  the index context.  Thanks to Yura Pakhuchiy for finding this bug.
+	- Remove bogus setting of PageError in ntfs_read_compressed_block().
 
 2.1.23 - Implement extension of resident files and make writing safe as well as
 	 many bug fixes, cleanups, and enhancements...
diff --git a/fs/ntfs/compress.c b/fs/ntfs/compress.c
--- a/fs/ntfs/compress.c
+++ b/fs/ntfs/compress.c
@@ -539,7 +539,6 @@ int ntfs_read_compressed_block(struct pa
 	if (unlikely(!pages || !bhs)) {
 		kfree(bhs);
 		kfree(pages);
-		SetPageError(page);
 		unlock_page(page);
 		ntfs_error(vol->sb, "Failed to allocate internal buffers.");
 		return -ENOMEM;
@@ -871,9 +870,6 @@ lock_retry_remap:
 			for (; prev_cur_page < cur_page; prev_cur_page++) {
 				page = pages[prev_cur_page];
 				if (page) {
-					if (prev_cur_page == xpage &&
-							!xpage_done)
-						SetPageError(page);
 					flush_dcache_page(page);
 					kunmap(page);
 					unlock_page(page);
@@ -904,8 +900,6 @@ lock_retry_remap:
 					"Terminating them with extreme "
 					"prejudice.  Inode 0x%lx, page index "
 					"0x%lx.", ni->mft_no, page->index);
-			if (cur_page == xpage && !xpage_done)
-				SetPageError(page);
 			flush_dcache_page(page);
 			kunmap(page);
 			unlock_page(page);
@@ -953,8 +947,6 @@ err_out:
 	for (i = cur_page; i < max_page; i++) {
 		page = pages[i];
 		if (page) {
-			if (i == xpage && !xpage_done)
-				SetPageError(page);
 			flush_dcache_page(page);
 			kunmap(page);
 			unlock_page(page);
diff --git a/fs/ntfs/file.c b/fs/ntfs/file.c
--- a/fs/ntfs/file.c
+++ b/fs/ntfs/file.c
@@ -1,7 +1,7 @@
 /*
- * file.c - NTFS kernel file operations. Part of the Linux-NTFS project.
+ * file.c - NTFS kernel file operations.  Part of the Linux-NTFS project.
  *
- * Copyright (c) 2001-2004 Anton Altaparmakov
+ * Copyright (c) 2001-2005 Anton Altaparmakov
  *
  * This program/include file is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License as published
@@ -94,6 +94,11 @@ static int ntfs_file_fsync(struct file *
 	if (!datasync || !NInoNonResident(NTFS_I(vi)))
 		ret = ntfs_write_inode(vi, 1);
 	write_inode_now(vi, !datasync);
+	/*
+	 * NOTE: If we were to use mapping->private_list (see ext2 and
+	 * fs/buffer.c) for dirty blocks then we could optimize the below to be
+	 * sync_mapping_buffers(vi->i_mapping).
+	 */
 	err = sync_blockdev(vi->i_sb->s_bdev);
 	if (unlikely(err && !ret))
 		ret = err;
