Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964813AbVJDPiA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964813AbVJDPiA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 11:38:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964817AbVJDPiA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 11:38:00 -0400
Received: from ppsw-9.csi.cam.ac.uk ([131.111.8.139]:19364 "EHLO
	ppsw-9.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S964813AbVJDPh7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 11:37:59 -0400
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Date: Tue, 4 Oct 2005 16:37:39 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net
Subject: [PATCH 2/2] NTFS: Fix a 64-bitness bug where a left-shift could
 overflow a 32-bit variable
In-Reply-To: <Pine.LNX.4.60.0510041634180.28800@hermes-1.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.60.0510041637020.28800@hermes-1.csi.cam.ac.uk>
References: <Pine.LNX.4.60.0510041634180.28800@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

NTFS: Fix a 64-bitness bug where a left-shift could overflow a 32-bit variable
      which we now cast to 64-bit first (fs/ntfs/mft.c::map_mft_record_page().

Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

---

 fs/ntfs/layout.h |    2 +-
 fs/ntfs/mft.c    |    3 ++-
 fs/ntfs/unistr.c |    2 +-
 3 files changed, 4 insertions(+), 3 deletions(-)

c394e458b69632902d65f9e2f39df79314f72908
diff --git a/fs/ntfs/layout.h b/fs/ntfs/layout.h
--- a/fs/ntfs/layout.h
+++ b/fs/ntfs/layout.h
@@ -309,7 +309,7 @@ typedef le16 MFT_RECORD_FLAGS;
  * Note: The _LE versions will return a CPU endian formatted value!
  */
 #define MFT_REF_MASK_CPU 0x0000ffffffffffffULL
-#define MFT_REF_MASK_LE const_cpu_to_le64(0x0000ffffffffffffULL)
+#define MFT_REF_MASK_LE const_cpu_to_le64(MFT_REF_MASK_CPU)
 
 typedef u64 MFT_REF;
 typedef le64 leMFT_REF;
diff --git a/fs/ntfs/mft.c b/fs/ntfs/mft.c
--- a/fs/ntfs/mft.c
+++ b/fs/ntfs/mft.c
@@ -58,7 +58,8 @@ static inline MFT_RECORD *map_mft_record
 	 * overflowing the unsigned long, but I don't think we would ever get
 	 * here if the volume was that big...
 	 */
-	index = ni->mft_no << vol->mft_record_size_bits >> PAGE_CACHE_SHIFT;
+	index = (u64)ni->mft_no << vol->mft_record_size_bits >>
+			PAGE_CACHE_SHIFT;
 	ofs = (ni->mft_no << vol->mft_record_size_bits) & ~PAGE_CACHE_MASK;
 
 	i_size = i_size_read(mft_vi);
diff --git a/fs/ntfs/unistr.c b/fs/ntfs/unistr.c
--- a/fs/ntfs/unistr.c
+++ b/fs/ntfs/unistr.c
@@ -1,7 +1,7 @@
 /*
  * unistr.c - NTFS Unicode string handling. Part of the Linux-NTFS project.
  *
- * Copyright (c) 2001-2004 Anton Altaparmakov
+ * Copyright (c) 2001-2005 Anton Altaparmakov
  *
  * This program/include file is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License as published
