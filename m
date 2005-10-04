Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964814AbVJDPhA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964814AbVJDPhA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 11:37:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964813AbVJDPg7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 11:36:59 -0400
Received: from ppsw-1.csi.cam.ac.uk ([131.111.8.131]:5085 "EHLO
	ppsw-1.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S964810AbVJDPg6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 11:36:58 -0400
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Date: Tue, 4 Oct 2005 16:36:55 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net
Subject: [PATCH 1/2] NTFS: Fix a stupid bug in __ntfs_bitmap_set_bits_in_run()
In-Reply-To: <Pine.LNX.4.60.0510041634180.28800@hermes-1.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.60.0510041636181.28800@hermes-1.csi.cam.ac.uk>
References: <Pine.LNX.4.60.0510041634180.28800@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

NTFS: Fix a stupid bug in __ntfs_bitmap_set_bits_in_run() which caused the
      count to become negative and hence we had a wild memset() scribbling
      all over the system's ram.

Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

---

 fs/ntfs/ChangeLog |    3 +++
 fs/ntfs/bitmap.c  |    5 +++--
 2 files changed, 6 insertions(+), 2 deletions(-)

18efefa9355119b4f6d9b73b074ebbf9882c37c3
diff --git a/fs/ntfs/ChangeLog b/fs/ntfs/ChangeLog
--- a/fs/ntfs/ChangeLog
+++ b/fs/ntfs/ChangeLog
@@ -102,6 +102,9 @@ ToDo/Notes:
 	  inode instead of a vfs inode as parameter.
 	- Fix the definition of the CHKD ntfs record magic.  It had an off by
 	  two error causing it to be CHKB instead of CHKD.
+	- Fix a stupid bug in __ntfs_bitmap_set_bits_in_run() which caused the
+	  count to become negative and hence we had a wild memset() scribbling
+	  all over the system's ram.
 
 2.1.23 - Implement extension of resident files and make writing safe as well as
 	 many bug fixes, cleanups, and enhancements...
diff --git a/fs/ntfs/bitmap.c b/fs/ntfs/bitmap.c
--- a/fs/ntfs/bitmap.c
+++ b/fs/ntfs/bitmap.c
@@ -1,7 +1,7 @@
 /*
  * bitmap.c - NTFS kernel bitmap handling.  Part of the Linux-NTFS project.
  *
- * Copyright (c) 2004 Anton Altaparmakov
+ * Copyright (c) 2004-2005 Anton Altaparmakov
  *
  * This program/include file is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License as published
@@ -90,7 +90,8 @@ int __ntfs_bitmap_set_bits_in_run(struct
 	/* If the first byte is partial, modify the appropriate bits in it. */
 	if (bit) {
 		u8 *byte = kaddr + pos;
-		while ((bit & 7) && cnt--) {
+		while ((bit & 7) && cnt) {
+			cnt--;
 			if (value)
 				*byte |= 1 << bit++;
 			else
