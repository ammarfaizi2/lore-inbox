Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932113AbVIZNcc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932113AbVIZNcc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 09:32:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932125AbVIZNcc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 09:32:32 -0400
Received: from ppsw-9.csi.cam.ac.uk ([131.111.8.139]:28907 "EHLO
	ppsw-9.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S932113AbVIZNcb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 09:32:31 -0400
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Date: Mon, 26 Sep 2005 14:32:15 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net
Subject: [PATCH 1/4] NTFS: Fix sparse warnings that have crept in over time.
In-Reply-To: <Pine.LNX.4.60.0509261427520.32257@hermes-1.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.60.0509261431270.32257@hermes-1.csi.cam.ac.uk>
References: <Pine.LNX.4.60.0509261427520.32257@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

NTFS: Fix sparse warnings that have crept in over time.

Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

---

 fs/ntfs/ChangeLog |    4 ++++
 fs/ntfs/layout.h  |    7 ++++---
 fs/ntfs/logfile.h |    2 +-
 3 files changed, 9 insertions(+), 4 deletions(-)

91fbc6edfa7086b5fcdb74ea82ab747104541f1f
diff --git a/fs/ntfs/ChangeLog b/fs/ntfs/ChangeLog
--- a/fs/ntfs/ChangeLog
+++ b/fs/ntfs/ChangeLog
@@ -22,6 +22,10 @@ ToDo/Notes:
 	- Enable the code for setting the NT4 compatibility flag when we start
 	  making NTFS 1.2 specific modifications.
 
+2.1.25-WIP
+
+	- Fix sparse warnings that have crept in over time.
+
 2.1.24 - Lots of bug fixes and support more clean journal states.
 
 	- Support journals ($LogFile) which have been modified by chkdsk.  This
diff --git a/fs/ntfs/layout.h b/fs/ntfs/layout.h
--- a/fs/ntfs/layout.h
+++ b/fs/ntfs/layout.h
@@ -317,12 +317,13 @@ typedef u64 MFT_REF;
 typedef le64 leMFT_REF;
 
 #define MK_MREF(m, s)	((MFT_REF)(((MFT_REF)(s) << 48) |		\
-					((MFT_REF)(m) & MFT_REF_MASK_CPU)))
+					((MFT_REF)(m) & (u64)MFT_REF_MASK_CPU)))
 #define MK_LE_MREF(m, s) cpu_to_le64(MK_MREF(m, s))
 
-#define MREF(x)		((unsigned long)((x) & MFT_REF_MASK_CPU))
+#define MREF(x)		((unsigned long)((x) & (u64)MFT_REF_MASK_CPU))
 #define MSEQNO(x)	((u16)(((x) >> 48) & 0xffff))
-#define MREF_LE(x)	((unsigned long)(le64_to_cpu(x) & MFT_REF_MASK_CPU))
+#define MREF_LE(x)	((unsigned long)(le64_to_cpu(x) &		\
+					(u64)MFT_REF_MASK_CPU))
 #define MSEQNO_LE(x)	((u16)((le64_to_cpu(x) >> 48) & 0xffff))
 
 #define IS_ERR_MREF(x)	(((x) & 0x0000800000000000ULL) ? 1 : 0)
diff --git a/fs/ntfs/logfile.h b/fs/ntfs/logfile.h
--- a/fs/ntfs/logfile.h
+++ b/fs/ntfs/logfile.h
@@ -113,7 +113,7 @@ typedef struct {
  */
 enum {
 	RESTART_VOLUME_IS_CLEAN	= const_cpu_to_le16(0x0002),
-	RESTART_SPACE_FILLER	= 0xffff, /* gcc: Force enum bit width to 16. */
+	RESTART_SPACE_FILLER	= const_cpu_to_le16(0xffff), /* gcc: Force enum bit width to 16. */
 } __attribute__ ((__packed__));
 
 typedef le16 RESTART_AREA_FLAGS;
