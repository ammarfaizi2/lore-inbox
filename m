Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317659AbSGOVgv>; Mon, 15 Jul 2002 17:36:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317657AbSGOVgv>; Mon, 15 Jul 2002 17:36:51 -0400
Received: from plum.csi.cam.ac.uk ([131.111.8.3]:62608 "EHLO
	plum.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S317659AbSGOVga>; Mon, 15 Jul 2002 17:36:30 -0400
Subject: [BK-PATCH-2.5] NTFS: 2.0.21 - Refuse to work with too large files/directories/volumes
To: torvalds@transmeta.com (Linus Torvalds)
Date: Mon, 15 Jul 2002 22:39:24 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (Linux Kernel)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17UDYy-00052S-00@storm.christs.cam.ac.uk>
From: Anton Altaparmakov <aia21@cantab.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please do a

	bk pull http://linux-ntfs.bkbits.net/ntfs-tng-2.5

Thanks! This adds all necessary checks to ntfs to avoid problems with too
large devices, files, and directories.

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/, http://www-stu.christs.cam.ac.uk/~aia21/

===================================================================

This will update the following files:

 Documentation/filesystems/ntfs.txt |    5 +++++
 fs/ntfs/ChangeLog                  |   19 ++++++++++++-------
 fs/ntfs/Makefile                   |    2 +-
 fs/ntfs/dir.c                      |   26 ++++++++++++++++++++++++++
 fs/ntfs/file.c                     |   35 +++++++++++++++++++++++++++++++----
 fs/ntfs/super.c                    |   18 ++++++++++++++++--
 6 files changed, 91 insertions(+), 14 deletions(-)

through these ChangeSets:

<aia21@cantab.net> (02/07/15 1.640)
   NTFS: 2.0.21 - Check for, and refuse to work with too large files/directories/volumes.
   - Limit volume size at mount time to 2TiB on architectures where
     unsigned long is 32-bits (fs/ntfs/super.c::parse_ntfs_boot_sector()).
     This is the most we can do without overflowing the 32-bit limit of
     the block device size imposed on us by sb_bread() and sb_getblk()
     for the time being.
   - Limit file/directory size at open() time to 16TiB on architectures
     where unsigned long is 32-bits (fs/ntfs/file.c::ntfs_file_open() and
     fs/ntfs/dir.c::ntfs_dir_open()). This is the most we can do without
     overflowing the page cache page index.


diff -Nru a/Documentation/filesystems/ntfs.txt b/Documentation/filesystems/ntfs.txt
--- a/Documentation/filesystems/ntfs.txt	Mon Jul 15 22:25:26 2002
+++ b/Documentation/filesystems/ntfs.txt	Mon Jul 15 22:25:26 2002
@@ -247,6 +247,11 @@
 
 Note, a technical ChangeLog aimed at kernel hackers is in fs/ntfs/ChangeLog.
 
+2.0.21:
+	These only affect 32-bit architectures:
+	- Check for, and refuse to mount too large volumes (maximum is 2TiB).
+	- Check for, and refuse to open too large files and directories
+	  (maximum is 16TiB).
 2.0.20:
 	- Support non-resident directory index bitmaps. This means we now cope
 	  with huge directories without problems.
diff -Nru a/fs/ntfs/ChangeLog b/fs/ntfs/ChangeLog
--- a/fs/ntfs/ChangeLog	Mon Jul 15 22:25:26 2002
+++ b/fs/ntfs/ChangeLog	Mon Jul 15 22:25:26 2002
@@ -1,13 +1,18 @@
 ToDo:
 	- Find and fix bugs.
-	- W.r.t. s_maxbytes still need to be careful on reading/truncating as
-	  there are dragons lurking in the details, e.g. read_inode() currently
-	  does no checks for file size wrt s_maxbytes. So what happens when a
-	  user open()s a file with i_size > s_maxbytes? Should read_inode()
-	  truncate the visible i_size? Will the user just get -E2BIG (or
-	  whatever) on open()? Or will (s)he be able to open() but lseek() and
-	  read() will fail when s_maxbytes is reached? -> Investigate this.
 	- Enable NFS exporting of NTFS.
+
+2.0.21 - Check for, and refuse to work with too large files/directories/volumes.
+
+	- Limit volume size at mount time to 2TiB on architectures where
+	  unsigned long is 32-bits (fs/ntfs/super.c::parse_ntfs_boot_sector()).
+	  This is the most we can do without overflowing the 32-bit limit of
+	  the block device size imposed on us by sb_bread() and sb_getblk()
+	  for the time being.
+	- Limit file/directory size at open() time to 16TiB on architectures
+	  where unsigned long is 32-bits (fs/ntfs/file.c::ntfs_file_open() and
+	  fs/ntfs/dir.c::ntfs_dir_open()). This is the most we can do without
+	  overflowing the page cache page index.
 
 2.0.20 - Support non-resident directory index bitmaps, fix page leak in readdir.
 
diff -Nru a/fs/ntfs/Makefile b/fs/ntfs/Makefile
--- a/fs/ntfs/Makefile	Mon Jul 15 22:25:26 2002
+++ b/fs/ntfs/Makefile	Mon Jul 15 22:25:26 2002
@@ -5,7 +5,7 @@
 ntfs-objs := aops.o attrib.o compress.o debug.o dir.o file.o inode.o mft.o \
 	     mst.o namei.o super.o sysctl.o time.o unistr.o upcase.o
 
-EXTRA_CFLAGS = -DNTFS_VERSION=\"2.0.20\"
+EXTRA_CFLAGS = -DNTFS_VERSION=\"2.0.21\"
 
 ifeq ($(CONFIG_NTFS_DEBUG),y)
 EXTRA_CFLAGS += -DDEBUG
diff -Nru a/fs/ntfs/dir.c b/fs/ntfs/dir.c
--- a/fs/ntfs/dir.c	Mon Jul 15 22:25:26 2002
+++ b/fs/ntfs/dir.c	Mon Jul 15 22:25:26 2002
@@ -1370,9 +1370,35 @@
 	return err;
 }
 
+/**
+ * ntfs_dir_open - called when an inode is about to be opened
+ * @vi:		inode to be opened
+ * @filp:	file structure describing the inode
+ *
+ * Limit directory size to the page cache limit on architectures where unsigned
+ * long is 32-bits. This is the most we can do for now without overflowing the
+ * page cache page index. Doing it this way means we don't run into problems
+ * because of existing too large directories. It would be better to allow the
+ * user to read the accessible part of the directory but I doubt very much
+ * anyone is going to hit this check on a 32-bit architecture, so there is no
+ * point in adding the extra complexity required to support this.
+ *
+ * On 64-bit architectures, the check is hopefully optimized away by the
+ * compiler.
+ */
+static int ntfs_dir_open(struct inode *vi, struct file *filp)
+{
+	if (sizeof(unsigned long) < 8) {
+		if (vi->i_size > MAX_LFS_FILESIZE)
+			return -EFBIG;
+	}
+	return 0;
+}
+
 struct file_operations ntfs_dir_ops = {
 	llseek:		generic_file_llseek,	/* Seek inside directory. */
 	read:		generic_read_dir,	/* Return -EISDIR. */
 	readdir:	ntfs_readdir,		/* Read directory contents. */
+	open:		ntfs_dir_open,		/* Open directory. */
 };
 
diff -Nru a/fs/ntfs/file.c b/fs/ntfs/file.c
--- a/fs/ntfs/file.c	Mon Jul 15 22:25:26 2002
+++ b/fs/ntfs/file.c	Mon Jul 15 22:25:26 2002
@@ -21,11 +21,38 @@
 
 #include "ntfs.h"
 
+/**
+ * ntfs_file_open - called when an inode is about to be opened
+ * @vi:		inode to be opened
+ * @filp:	file structure describing the inode
+ *
+ * Limit file size to the page cache limit on architectures where unsigned long
+ * is 32-bits. This is the most we can do for now without overflowing the page
+ * cache page index. Doing it this way means we don't run into problems because
+ * of existing too large files. It would be better to allow the user to read
+ * the beginning of the file but I doubt very much anyone is going to hit this
+ * check on a 32-bit architecture, so there is no point in adding the extra
+ * complexity required to support this.
+ *
+ * On 64-bit architectures, the check is hopefully optimized away by the
+ * compiler.
+ *
+ * After the check passes, just call generic_file_open() to do its work.
+ */
+static int ntfs_file_open(struct inode *vi, struct file *filp)
+{
+	if (sizeof(unsigned long) < 8) {
+		if (vi->i_size > MAX_LFS_FILESIZE)
+			return -EFBIG;
+	}
+	return generic_file_open(vi, filp);
+}
+
 struct file_operations ntfs_file_ops = {
-	llseek:			generic_file_llseek,	/* Seek inside file. */
-	read:			generic_file_read,	/* Read from file. */
-	mmap:			generic_file_mmap,	/* Mmap file. */
-	open:			generic_file_open,	/* Open file. */
+	llseek:		generic_file_llseek,	/* Seek inside file. */
+	read:		generic_file_read,	/* Read from file. */
+	mmap:		generic_file_mmap,	/* Mmap file. */
+	open:		ntfs_file_open,		/* Open file. */
 };
 
 struct inode_operations ntfs_file_inode_ops = {};
diff -Nru a/fs/ntfs/super.c b/fs/ntfs/super.c
--- a/fs/ntfs/super.c	Mon Jul 15 22:25:26 2002
+++ b/fs/ntfs/super.c	Mon Jul 15 22:25:26 2002
@@ -2,7 +2,7 @@
  * super.c - NTFS kernel super block handling. Part of the Linux-NTFS project.
  *
  * Copyright (c) 2001,2002 Anton Altaparmakov.
- * Copyright (C) 2001,2002 Richard Russon.
+ * Copyright (c) 2001,2002 Richard Russon.
  *
  * This program/include file is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License as published
@@ -413,7 +413,7 @@
 }
 
 /**
- * read_boot_sector - read the NTFS boot sector of a device
+ * read_ntfs_boot_sector - read the NTFS boot sector of a device
  * @sb:		super block of device to read the boot sector from
  * @silent:	if true, suppress all output
  *
@@ -613,6 +613,20 @@
 	}
 	vol->nr_clusters = ll;
 	ntfs_debug("vol->nr_clusters = 0x%Lx", (long long)vol->nr_clusters);
+	/*
+	 * On an architecture where unsigned long is 32-bits, we restrict the
+	 * volume size to 2TiB (2^41). On a 64-bit architecture, the compiler
+	 * will hopefully optimize the whole check away.
+	 */
+	if (sizeof(unsigned long) < 8) {
+		if ((ll << vol->cluster_size_bits) >= (1ULL << 41)) {
+			ntfs_error(vol->sb, "Volume size (%LuTiB) is too large "
+					"for this architecture. Maximim "
+					"supported is 2TiB. Sorry.",
+					ll >> (40 - vol->cluster_size_bits));
+			return FALSE;
+		}
+	}
 	ll = sle64_to_cpu(b->mft_lcn);
 	if (ll >= vol->nr_clusters) {
 		ntfs_error(vol->sb, "MFT LCN is beyond end of volume. Weird.");

===================================================================

This BitKeeper patch contains the following changesets:
aia21@cantab.net|ChangeSet|20020715212258|05591
## Wrapped with gzip_uu ##


begin 664 bkpatch2487
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
%+?X@````
`
end
