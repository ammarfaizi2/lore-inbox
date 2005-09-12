Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932165AbVILTbq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932165AbVILTbq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 15:31:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932162AbVILTbq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 15:31:46 -0400
Received: from ppsw-7.csi.cam.ac.uk ([131.111.8.137]:48098 "EHLO
	ppsw-7.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S932165AbVILTbp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 15:31:45 -0400
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Date: Mon, 12 Sep 2005 20:31:42 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net
Subject: [1/2] NTFS: Change the mount options {u,f,d}mask to always parse
 the number as an octal
In-Reply-To: <Pine.LNX.4.60.0509122027430.4649@hermes-1.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.60.0509122030110.4649@hermes-1.csi.cam.ac.uk>
References: <Pine.LNX.4.60.0509122027430.4649@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

NTFS: Change the mount options {u,f,d}mask to always parse the number as
      an octal number to conform to how chmod(1) works, too.  Thanks to
      Giuseppe Bilotta and Horst von Brand for pointing out the errors of
      my ways.

Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

diff --git a/fs/ntfs/ChangeLog b/fs/ntfs/ChangeLog
--- a/fs/ntfs/ChangeLog
+++ b/fs/ntfs/ChangeLog
@@ -90,7 +90,11 @@ ToDo/Notes:
 	  in the first buffer head instead of a driver global spin lock to
 	  improve scalability.
 	- Minor fix to error handling and error message display in
-	  fs/ntfs/aops.c::ntfs_prepare_nonresident_write(). 
+	  fs/ntfs/aops.c::ntfs_prepare_nonresident_write().
+	- Change the mount options {u,f,d}mask to always parse the number as
+	  an octal number to conform to how chmod(1) works, too.  Thanks to
+	  Giuseppe Bilotta and Horst von Brand for pointing out the errors of
+	  my ways.
 
 2.1.23 - Implement extension of resident files and make writing safe as well as
 	 many bug fixes, cleanups, and enhancements...
diff --git a/fs/ntfs/super.c b/fs/ntfs/super.c
--- a/fs/ntfs/super.c
+++ b/fs/ntfs/super.c
@@ -126,6 +126,14 @@ static BOOL parse_options(ntfs_volume *v
 		if (*v)							\
 			goto needs_val;					\
 	}
+#define NTFS_GETOPT_OCTAL(option, variable)				\
+	if (!strcmp(p, option)) {					\
+		if (!v || !*v)						\
+			goto needs_arg;					\
+		variable = simple_strtoul(ov = v, &v, 8);		\
+		if (*v)							\
+			goto needs_val;					\
+	}
 #define NTFS_GETOPT_BOOL(option, variable)				\
 	if (!strcmp(p, option)) {					\
 		BOOL val;						\
@@ -157,9 +165,9 @@ static BOOL parse_options(ntfs_volume *v
 			*v++ = 0;
 		NTFS_GETOPT("uid", uid)
 		else NTFS_GETOPT("gid", gid)
-		else NTFS_GETOPT("umask", fmask = dmask)
-		else NTFS_GETOPT("fmask", fmask)
-		else NTFS_GETOPT("dmask", dmask)
+		else NTFS_GETOPT_OCTAL("umask", fmask = dmask)
+		else NTFS_GETOPT_OCTAL("fmask", fmask)
+		else NTFS_GETOPT_OCTAL("dmask", dmask)
 		else NTFS_GETOPT("mft_zone_multiplier", mft_zone_multiplier)
 		else NTFS_GETOPT_WITH_DEFAULT("sloppy", sloppy, TRUE)
 		else NTFS_GETOPT_BOOL("show_sys_files", show_sys_files)
