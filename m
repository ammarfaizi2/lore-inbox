Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268126AbUJSK07@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268126AbUJSK07 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 06:26:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268117AbUJSK0X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 06:26:23 -0400
Received: from ppsw-5.csi.cam.ac.uk ([131.111.8.135]:31722 "EHLO
	ppsw-5.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S268126AbUJSJr5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 05:47:57 -0400
Date: Tue, 19 Oct 2004 10:47:49 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-ntfs-dev@lists.sourceforge.net
Subject: [PATCH 36/37] Re: [2.6-BK-URL] NTFS: 2.1.21 - Big update with race/bug
 fixes
In-Reply-To: <Pine.LNX.4.60.0410191047120.24986@hermes-1.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.60.0410191047360.24986@hermes-1.csi.cam.ac.uk>
References: <Pine.LNX.4.60.0410191017070.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191043370.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191043500.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191044130.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191044280.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191044420.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191044560.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191045100.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191045250.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191045410.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191046000.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191046160.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191046300.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191046440.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191046580.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191047120.24986@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is patch 36/37 in the series.  It contains the following ChangeSet:

<aia21@cantab.net> (04/10/17 1.2059)
   NTFS: 2.1.21 release
   
   Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/, http://www-stu.christs.cam.ac.uk/~aia21/

===================================================================

diff -Nru a/Documentation/filesystems/ntfs.txt b/Documentation/filesystems/ntfs.txt
--- a/Documentation/filesystems/ntfs.txt	2004-10-19 10:15:17 +01:00
+++ b/Documentation/filesystems/ntfs.txt	2004-10-19 10:15:17 +01:00
@@ -277,6 +277,10 @@
 
 Note, a technical ChangeLog aimed at kernel hackers is in fs/ntfs/ChangeLog.
 
+2.1.21:
+	- Fix several race conditions and various other bugs.
+	- Many internal cleanups, code reorganization, optimizations, and mft
+	  and index record writing code rewritten to fit in with the changes.
 2.1.20:
 	- Fix two stupid bugs introduced in 2.1.18 release.
 2.1.19:
diff -Nru a/fs/ntfs/ChangeLog b/fs/ntfs/ChangeLog
--- a/fs/ntfs/ChangeLog	2004-10-19 10:15:17 +01:00
+++ b/fs/ntfs/ChangeLog	2004-10-19 10:15:17 +01:00
@@ -21,7 +21,7 @@
 	- Enable the code for setting the NT4 compatibility flag when we start
 	  making NTFS 1.2 specific modifications.
 
-2.1.21-WIP
+2.1.21 - Fix some races and bugs, rewrite mft write code, add mft allocator.
 
 	- Implement extent mft record deallocation
 	  fs/ntfs/mft.c::ntfs_extent_mft_record_free().
@@ -115,7 +115,7 @@
 	  fs/ntfs/inode.c::ntfs_clear_big_inode().  (Thanks to Christoph
 	  Hellwig for spotting this.)
 	- Fix race condition in fs/ntfs/inode.c::ntfs_put_inode() by taking the
-	  inode semaphore around the code thst sets ni->itype.index.bmp_ino to
+	  inode semaphore around the code that sets ni->itype.index.bmp_ino to
 	  NULL and reorganize the code to optimize it a bit.  (Thanks to
 	  Christoph Hellwig for spotting this.)
 	- Modify fs/ntfs/aops.c::mark_ntfs_record_dirty() to no longer take the
diff -Nru a/fs/ntfs/Makefile b/fs/ntfs/Makefile
--- a/fs/ntfs/Makefile	2004-10-19 10:15:17 +01:00
+++ b/fs/ntfs/Makefile	2004-10-19 10:15:17 +01:00
@@ -6,7 +6,7 @@
 	     index.o inode.o mft.o mst.o namei.o runlist.o super.o sysctl.o \
 	     unistr.o upcase.o
 
-EXTRA_CFLAGS = -DNTFS_VERSION=\"2.1.21-WIP\"
+EXTRA_CFLAGS = -DNTFS_VERSION=\"2.1.21\"
 
 ifeq ($(CONFIG_NTFS_DEBUG),y)
 EXTRA_CFLAGS += -DDEBUG
