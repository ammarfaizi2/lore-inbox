Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263003AbUHWLCg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263003AbUHWLCg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 07:02:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263664AbUHWLBN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 07:01:13 -0400
Received: from ppsw-5.csi.cam.ac.uk ([131.111.8.135]:41127 "EHLO
	ppsw-5.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S267735AbUHWKeT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 06:34:19 -0400
Date: Mon, 23 Aug 2004 11:34:15 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH 20/20] Re: [2.6-BK-URL] NTFS 2.1.17 release
In-Reply-To: <Pine.LNX.4.60.0408231133390.24220@hermes-1.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.60.0408231133560.24220@hermes-1.csi.cam.ac.uk>
References: <Pine.LNX.4.60.0408231055290.24220@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0408231129530.24220@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0408231130090.24220@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0408231130240.24220@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0408231130380.24220@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0408231130510.24220@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0408231131070.24220@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0408231131200.24220@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0408231131390.24220@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0408231131520.24220@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0408231132080.24220@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0408231132240.24220@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0408231132500.24220@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0408231133060.24220@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0408231133210.24220@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0408231133390.24220@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is patch 20/20 in the series.  It contains the following ChangeSet:

<aia21@cantab.net> (04/08/18 1.1826)
   NTFS: 2.1.17 - Fix bugs in mount time error code paths.
   
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
--- a/Documentation/filesystems/ntfs.txt	2004-08-18 20:50:51 +01:00
+++ b/Documentation/filesystems/ntfs.txt	2004-08-18 20:50:51 +01:00
@@ -30,7 +30,7 @@
 support.
 
 For fault tolerance and raid support (i.e. volume and stripe sets), you can
-use the kernel's Software RAID / MD driver. See section "Using Software RAID
+use the kernel's Software RAID / MD driver.  See section "Using Software RAID
 with NTFS" for details.
 
 
@@ -64,14 +64,18 @@
 	time find . -type f -exec md5sum "{}" \;
   run three times in sequence with each driver (after a reboot) on a 1.4GiB
   NTFS partition, showed the new driver to be 20% faster in total time elapsed
-  (from 9:43 minutes on average down to 7:53). The time spent in user space
+  (from 9:43 minutes on average down to 7:53).  The time spent in user space
   was unchanged but the time spent in the kernel was decreased by a factor of
   2.5 (from 85 CPU seconds down to 33).
-- The driver does not support short file names in general. For backwards
+- The driver does not support short file names in general.  For backwards
   compatibility, we implement access to files using their short file names if
-  they exist. The driver will not create short file names however, and a rename
-  will discard any existing short file name.
+  they exist.  The driver will not create short file names however, and a
+  rename will discard any existing short file name.
 - The new driver supports exporting of mounted NTFS volumes via NFS.
+- The new driver supports async io (aio).
+- The new driver supports fsync(2), fdatasync(2), and msync(2).
+- The new driver supports readv(2) and writev(2).
+- The new driver supports access time updates (including mtime and ctime).
 
 
 Supported mount options
@@ -273,6 +277,8 @@
 
 Note, a technical ChangeLog aimed at kernel hackers is in fs/ntfs/ChangeLog.
 
+2.1.17:
+	- Fix bugs in mount time error code paths.
 2.1.16:
 	- Implement access time updates (including mtime and ctime).
 	- Implement fsync(2), fdatasync(2), and msync(2) system calls.
diff -Nru a/fs/ntfs/ChangeLog b/fs/ntfs/ChangeLog
--- a/fs/ntfs/ChangeLog	2004-08-18 20:50:51 +01:00
+++ b/fs/ntfs/ChangeLog	2004-08-18 20:50:51 +01:00
@@ -21,7 +21,7 @@
 	- Enable the code for setting the NT4 compatibility flag when we start
 	  making NTFS 1.2 specific modifications.
 
-2.1.17 - WIP.
+2.1.17 - Fix bugs in mount time error code paths and other updates.
 
 	- Implement bitmap modification code (fs/ntfs/bitmap.[hc]).  This
 	  includes functions to set/clear a single bit or a run of bits.
diff -Nru a/fs/ntfs/Makefile b/fs/ntfs/Makefile
--- a/fs/ntfs/Makefile	2004-08-18 20:50:51 +01:00
+++ b/fs/ntfs/Makefile	2004-08-18 20:50:51 +01:00
@@ -6,7 +6,7 @@
 	     index.o inode.o mft.o mst.o namei.o super.o sysctl.o unistr.o \
 	     upcase.o
 
-EXTRA_CFLAGS = -DNTFS_VERSION=\"2.1.17-WIP\"
+EXTRA_CFLAGS = -DNTFS_VERSION=\"2.1.17\"
 
 ifeq ($(CONFIG_NTFS_DEBUG),y)
 EXTRA_CFLAGS += -DDEBUG
