Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261886AbVAYKxy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261886AbVAYKxy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 05:53:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261887AbVAYKxx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 05:53:53 -0500
Received: from ppsw-0.csi.cam.ac.uk ([131.111.8.130]:39051 "EHLO
	ppsw-0.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S261886AbVAYKwo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 05:52:44 -0500
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-ntfs-dev@lists.sourceforge.net
Subject: [PATCH 1/1] NTFS: Fix a potential DoS by rate limiting printk().
Message-Id: <E1CtOJA-0003sV-8D@imp.csi.cam.ac.uk>
Date: Tue, 25 Jan 2005 10:52:28 +0000
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is patch 1/1 in the series.  It contains the following ChangeSet:

<aia21@cantab.net> (05/01/25 1.1983.6.1)
   NTFS: Add printk rate limiting for ntfs_warning() and ntfs_error() when
         compiled without debug.  This avoids a possible denial of service
         attack.  Thanks to Carl-Daniel Hailfinger from SuSE for pointing this
         out.

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/, http://www-stu.christs.cam.ac.uk/~aia21/

===================================================================

diff -Nru a/fs/ntfs/ChangeLog b/fs/ntfs/ChangeLog
--- a/fs/ntfs/ChangeLog	2005-01-25 10:50:37 +00:00
+++ b/fs/ntfs/ChangeLog	2005-01-25 10:50:37 +00:00
@@ -25,6 +25,13 @@
 	- Enable the code for setting the NT4 compatibility flag when we start
 	  making NTFS 1.2 specific modifications.
 
+2.1.23-WIP
+
+	- Add printk rate limiting for ntfs_warning() and ntfs_error() when
+	  compiled without debug.  This avoids a possible denial of service
+	  attack.  Thanks to Carl-Daniel Hailfinger from SuSE for pointing this
+	  out.
+
 2.1.22 - Many bug and race fixes and error handling improvements.
 
 	- Improve error handling in fs/ntfs/inode.c::ntfs_truncate().
diff -Nru a/fs/ntfs/debug.c b/fs/ntfs/debug.c
--- a/fs/ntfs/debug.c	2005-01-25 10:50:37 +00:00
+++ b/fs/ntfs/debug.c	2005-01-25 10:50:37 +00:00
@@ -53,6 +53,10 @@
 	va_list args;
 	int flen = 0;
 
+#ifndef DEBUG
+	if (!printk_ratelimit())
+		return;
+#endif
 	if (function)
 		flen = strlen(function);
 	spin_lock(&err_buf_lock);
@@ -93,6 +97,10 @@
 	va_list args;
 	int flen = 0;
 
+#ifndef DEBUG
+	if (!printk_ratelimit())
+		return;
+#endif
 	if (function)
 		flen = strlen(function);
 	spin_lock(&err_buf_lock);
