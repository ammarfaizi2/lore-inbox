Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265051AbUIVM2w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265051AbUIVM2w (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 08:28:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264917AbUIVMYj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 08:24:39 -0400
Received: from ppsw-5.csi.cam.ac.uk ([131.111.8.135]:35976 "EHLO
	ppsw-5.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S265029AbUIVMRz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 08:17:55 -0400
Date: Wed, 22 Sep 2004 13:17:48 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net
Subject: [PATCH 7/7] Re: [2.6-BK-URL] NTFS 2.1.18 release
In-Reply-To: <Pine.LNX.4.60.0409221316480.505@hermes-1.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.60.0409221317250.505@hermes-1.csi.cam.ac.uk>
References: <Pine.LNX.4.60.0409221308540.505@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0409221314250.505@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0409221315251.505@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0409221315460.505@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0409221316040.505@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0409221316230.505@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0409221316480.505@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is patch 7/7 in the series.  It contains the following ChangeSet:

<aia21@cantab.net> (04/09/22 1.1942.1.2)
   NTFS: 2.1.18 release
   
   - Minor cleanup of fs/ntfs/inode.c::ntfs_init_locked_inode().
   - Bump version number and update Documentation/filesystems/ntfs.txt
   
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
--- a/Documentation/filesystems/ntfs.txt	2004-09-22 13:02:55 +01:00
+++ b/Documentation/filesystems/ntfs.txt	2004-09-22 13:02:55 +01:00
@@ -277,6 +277,10 @@
 
 Note, a technical ChangeLog aimed at kernel hackers is in fs/ntfs/ChangeLog.
 
+2.1.18:
+	- Fix scheduling latencies at mount time.  (Ingo Molnar)
+	- Fix endianness bug in a little traversed portion of the attribute
+	  lookup code.
 2.1.17:
 	- Fix bugs in mount time error code paths.
 2.1.16:
diff -Nru a/fs/ntfs/ChangeLog b/fs/ntfs/ChangeLog
--- a/fs/ntfs/ChangeLog	2004-09-22 13:02:55 +01:00
+++ b/fs/ntfs/ChangeLog	2004-09-22 13:02:55 +01:00
@@ -21,7 +21,7 @@
 	- Enable the code for setting the NT4 compatibility flag when we start
 	  making NTFS 1.2 specific modifications.
 
-2.1.18-WIP
+2.1.18 - Fix scheduling latencies at mount time as well as an endianness bug.
 
 	- Remove vol->nr_mft_records as it was pretty meaningless and optimize
 	  the calculation of total/free inodes as used by statfs().
@@ -54,6 +54,7 @@
 	  anywhere other than attrib.c.  Update ntfs_attr_lookup() and all
 	  callers of ntfs_{external,}attr_{find,lookup}() for the new return
 	  values.
+	- Minor cleanup of fs/ntfs/inode.c::ntfs_init_locked_inode().
 
 2.1.17 - Fix bugs in mount time error code paths and other updates.
 
diff -Nru a/fs/ntfs/Makefile b/fs/ntfs/Makefile
--- a/fs/ntfs/Makefile	2004-09-22 13:02:55 +01:00
+++ b/fs/ntfs/Makefile	2004-09-22 13:02:55 +01:00
@@ -6,7 +6,7 @@
 	     index.o inode.o mft.o mst.o namei.o super.o sysctl.o unistr.o \
 	     upcase.o
 
-EXTRA_CFLAGS = -DNTFS_VERSION=\"2.1.18-WIP\"
+EXTRA_CFLAGS = -DNTFS_VERSION=\"2.1.18\"
 
 ifeq ($(CONFIG_NTFS_DEBUG),y)
 EXTRA_CFLAGS += -DDEBUG
diff -Nru a/fs/ntfs/inode.c b/fs/ntfs/inode.c
--- a/fs/ntfs/inode.c	2004-09-22 13:02:55 +01:00
+++ b/fs/ntfs/inode.c	2004-09-22 13:02:55 +01:00
@@ -105,8 +105,11 @@
 	ni->name_len = na->name_len;
 
 	/* If initializing a normal inode, we are done. */
-	if (likely(na->type == AT_UNUSED))
+	if (likely(na->type == AT_UNUSED)) {
+		BUG_ON(na->name);
+		BUG_ON(na->name_len);
 		return 0;
+	}
 
 	/* It is a fake inode. */
 	NInoSetAttr(ni);
@@ -118,15 +121,16 @@
 	 * thus the fraction of named attributes with name != I30 is actually
 	 * absolutely tiny.
 	 */
-	if (na->name && na->name_len && na->name != I30) {
+	if (na->name_len && na->name != I30) {
 		unsigned int i;
 
+		BUG_ON(!na->name);
 		i = na->name_len * sizeof(ntfschar);
 		ni->name = (ntfschar*)kmalloc(i + sizeof(ntfschar), GFP_ATOMIC);
 		if (!ni->name)
 			return -ENOMEM;
 		memcpy(ni->name, na->name, i);
-		ni->name[i] = cpu_to_le16('\0');
+		ni->name[i] = cpu_to_le16(L'\0');
 	}
 	return 0;
 }
