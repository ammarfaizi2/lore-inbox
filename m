Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263664AbUEKV0r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263664AbUEKV0r (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 17:26:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263685AbUEKV0r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 17:26:47 -0400
Received: from yellow.csi.cam.ac.uk ([131.111.8.67]:52900 "EHLO
	yellow.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S263664AbUEKVXU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 17:23:20 -0400
Date: Tue, 11 May 2004 22:23:18 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: [2.6.6-bk] NTFS: 2.1.10 - Force read-only (re)mounting of volumes
 with unsupported volume flags.
Message-ID: <Pine.SOL.4.58.0405112221070.4261@yellow.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew, Hi Linus, please do a

	bk pull http://linux-ntfs.bkbits.net/ntfs

Thanks!  This enforces read-only mounting if the NTFS volume information
flags have any unsupported bits set and it completes the white space
cleanups.  From here on changes will be adding more advanced write code so
releases are likely to slow down again...

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/, http://www-stu.christs.cam.ac.uk/~aia21/

===================================================================

This will update the following files:

 Documentation/filesystems/ntfs.txt |    3 ++
 fs/ntfs/ChangeLog                  |   21 ++++++++++++++--
 fs/ntfs/Makefile                   |    4 +--
 fs/ntfs/attrib.h                   |    9 +++---
 fs/ntfs/debug.c                    |    9 +++---
 fs/ntfs/debug.h                    |    9 +++---
 fs/ntfs/dir.h                      |    9 +++---
 fs/ntfs/endian.h                   |    9 +++---
 fs/ntfs/file.c                     |    9 +++---
 fs/ntfs/layout.h                   |   48 +++++++++++++++++++------------------
 fs/ntfs/logfile.c                  |    2 -
 fs/ntfs/malloc.h                   |    2 -
 fs/ntfs/mft.c                      |    9 +++---
 fs/ntfs/mft.h                      |    4 ---
 fs/ntfs/mst.c                      |    2 -
 fs/ntfs/namei.c                    |    8 +++---
 fs/ntfs/ntfs.h                     |    5 +--
 fs/ntfs/super.c                    |   35 ++++++++++++++++++++++++++
 fs/ntfs/sysctl.c                   |   13 ++++------
 fs/ntfs/sysctl.h                   |   13 ++++------
 fs/ntfs/time.h                     |    2 -
 fs/ntfs/types.h                    |    2 -
 fs/ntfs/unistr.c                   |   22 +++++++---------
 fs/ntfs/volume.h                   |    4 +--
 24 files changed, 147 insertions(+), 106 deletions(-)

through these ChangeSets:

<aia21@cantab.net> (04/05/10 1.1613)
   NTFS: Cleanup whitespace (trailing space removal, etc).

<aia21@cantab.net> (04/05/11 1.1615)
   NTFS: 2.1.10 - Force read-only (re)mounting of volumes with unsupported flags.

===================================================================

A diff -urNp patch for the non-BK users:

diff -urNp -urNp /usr/src/linux-2.6.6-bk/Documentation/filesystems/ntfs.txt linux-2.6.6-bk-ntfs-2.1.10/Documentation/filesystems/ntfs.txt
--- /usr/src/linux-2.6.6-bk/Documentation/filesystems/ntfs.txt	2004-05-11 22:09:40.473107864 +0100
+++ linux-2.6.6-bk-ntfs-2.1.10/Documentation/filesystems/ntfs.txt	2004-05-11 22:12:25.610003240 +0100
@@ -273,6 +273,9 @@ ChangeLog

 Note, a technical ChangeLog aimed at kernel hackers is in fs/ntfs/ChangeLog.

+2.1.10:
+	- Force read-only (re)mounting of volumes with unsupported volume
+	  flags and various cleanups.
 2.1.9:
 	- Fix two bugs in handling of corner cases in the decompression engine.
 2.1.8:
diff -urNp -urNp /usr/src/linux-2.6.6-bk/fs/ntfs/attrib.h linux-2.6.6-bk-ntfs-2.1.10/fs/ntfs/attrib.h
--- /usr/src/linux-2.6.6-bk/fs/ntfs/attrib.h	2004-05-11 22:09:20.165195136 +0100
+++ linux-2.6.6-bk-ntfs-2.1.10/fs/ntfs/attrib.h	2004-05-11 22:12:19.179980752 +0100
@@ -2,7 +2,7 @@
  * attrib.h - Defines for attribute handling in NTFS Linux kernel driver.
  *	      Part of the Linux-NTFS project.
  *
- * Copyright (c) 2001-2003 Anton Altaparmakov
+ * Copyright (c) 2001-2004 Anton Altaparmakov
  * Copyright (c) 2002 Richard Russon
  *
  * This program/include file is free software; you can redistribute it and/or
@@ -10,13 +10,13 @@
  * by the Free Software Foundation; either version 2 of the License, or
  * (at your option) any later version.
  *
- * This program/include file is distributed in the hope that it will be
- * useful, but WITHOUT ANY WARRANTY; without even the implied warranty
+ * This program/include file is distributed in the hope that it will be
+ * useful, but WITHOUT ANY WARRANTY; without even the implied warranty
  * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
  *
  * You should have received a copy of the GNU General Public License
- * along with this program (in the main directory of the Linux-NTFS
+ * along with this program (in the main directory of the Linux-NTFS
  * distribution in the file COPYING); if not, write to the Free Software
  * Foundation,Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
@@ -103,4 +103,3 @@ extern attr_search_context *get_attr_sea
 extern void put_attr_search_ctx(attr_search_context *ctx);

 #endif /* _LINUX_NTFS_ATTRIB_H */
-
diff -urNp -urNp /usr/src/linux-2.6.6-bk/fs/ntfs/ChangeLog linux-2.6.6-bk-ntfs-2.1.10/fs/ntfs/ChangeLog
--- /usr/src/linux-2.6.6-bk/fs/ntfs/ChangeLog	2004-05-11 22:09:04.057643856 +0100
+++ linux-2.6.6-bk-ntfs-2.1.10/fs/ntfs/ChangeLog	2004-05-11 22:11:44.316280840 +0100
@@ -19,6 +19,24 @@ ToDo:
 	  sufficient for synchronisation here. We then just need to make sure
 	  ntfs_readpage/writepage/truncate interoperate properly with us.

+2.1.10 - Force read-only (re)mounting of volumes with unsupported volume flags.
+
+	- Finish off the white space cleanups (remove trailing spaces, etc).
+	- Clean up ntfs_fill_super() and ntfs_read_inode_mount() by removing
+	  the kludges around the first iget().  Instead of (re)setting ->s_op
+	  we have the $MFT inode set up by explicit new_inode() / set ->i_ino /
+	  insert_inode_hash() / call ntfs_read_inode_mount() directly.  This
+	  kills the need for second super_operations and allows to return error
+	  from ntfs_read_inode_mount() without resorting to ugly "poisoning"
+	  tricks.  (Al Viro)
+	- Force read-only (re)mounting if any of the following bits are set in
+	  the volume information flags:
+	  	VOLUME_IS_DIRTY, VOLUME_RESIZE_LOG_FILE,
+		VOLUME_UPGRADE_ON_MOUNT, VOLUME_DELETE_USN_UNDERWAY,
+		VOLUME_REPAIR_OBJECT_ID, VOLUME_MODIFIED_BY_CHKDSK
+	  To make this easier we define VOLUME_MUST_MOUNT_RO_MASK with all the
+	  above bits set so the test is made easy.
+
 2.1.9 - Fix two bugs in decompression engine.

 	- Fix a bug where we would not always detect that we have reached the
@@ -880,4 +898,3 @@ tng-0.0.0 - Initial version tag.
 	working nicely, too. Proof of inode metadata in the page cache and non-
 	resident file unnamed stream data in the page cache concepts is thus
 	complete.
-
diff -urNp -urNp /usr/src/linux-2.6.6-bk/fs/ntfs/debug.c linux-2.6.6-bk-ntfs-2.1.10/fs/ntfs/debug.c
--- /usr/src/linux-2.6.6-bk/fs/ntfs/debug.c	2004-05-11 22:12:11.988074088 +0100
+++ linux-2.6.6-bk-ntfs-2.1.10/fs/ntfs/debug.c	2004-05-11 22:12:49.992296568 +0100
@@ -1,20 +1,20 @@
 /*
  * debug.c - NTFS kernel debug support. Part of the Linux-NTFS project.
  *
- * Copyright (c) 2001,2002 Anton Altaparmakov.
+ * Copyright (c) 2001-2004 Anton Altaparmakov
  *
  * This program/include file is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License as published
  * by the Free Software Foundation; either version 2 of the License, or
  * (at your option) any later version.
  *
- * This program/include file is distributed in the hope that it will be
- * useful, but WITHOUT ANY WARRANTY; without even the implied warranty
+ * This program/include file is distributed in the hope that it will be
+ * useful, but WITHOUT ANY WARRANTY; without even the implied warranty
  * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
  *
  * You should have received a copy of the GNU General Public License
- * along with this program (in the main directory of the Linux-NTFS
+ * along with this program (in the main directory of the Linux-NTFS
  * distribution in the file COPYING); if not, write to the Free Software
  * Foundation,Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
@@ -172,4 +172,3 @@ void ntfs_debug_dump_runlist(const run_l
 }

 #endif
-
diff -urNp -urNp /usr/src/linux-2.6.6-bk/fs/ntfs/debug.h linux-2.6.6-bk-ntfs-2.1.10/fs/ntfs/debug.h
--- /usr/src/linux-2.6.6-bk/fs/ntfs/debug.h	2004-05-11 22:10:32.749160696 +0100
+++ linux-2.6.6-bk-ntfs-2.1.10/fs/ntfs/debug.h	2004-05-11 22:12:34.588638280 +0100
@@ -1,20 +1,20 @@
 /*
  * debug.h - NTFS kernel debug support. Part of the Linux-NTFS project.
  *
- * Copyright (c) 2001,2002 Anton Altaparmakov.
+ * Copyright (c) 2001-2004 Anton Altaparmakov
  *
  * This program/include file is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License as published
  * by the Free Software Foundation; either version 2 of the License, or
  * (at your option) any later version.
  *
- * This program/include file is distributed in the hope that it will be
- * useful, but WITHOUT ANY WARRANTY; without even the implied warranty
+ * This program/include file is distributed in the hope that it will be
+ * useful, but WITHOUT ANY WARRANTY; without even the implied warranty
  * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
  *
  * You should have received a copy of the GNU General Public License
- * along with this program (in the main directory of the Linux-NTFS
+ * along with this program (in the main directory of the Linux-NTFS
  * distribution in the file COPYING); if not, write to the Free Software
  * Foundation,Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
@@ -69,4 +69,3 @@ extern void __ntfs_error(const char *fun
 #define ntfs_error(sb, f, a...)		__ntfs_error(__FUNCTION__, sb, f, ##a)

 #endif /* _LINUX_NTFS_DEBUG_H */
-
diff -urNp -urNp /usr/src/linux-2.6.6-bk/fs/ntfs/dir.h linux-2.6.6-bk-ntfs-2.1.10/fs/ntfs/dir.h
--- /usr/src/linux-2.6.6-bk/fs/ntfs/dir.h	2004-05-11 22:10:21.242909912 +0100
+++ linux-2.6.6-bk-ntfs-2.1.10/fs/ntfs/dir.h	2004-05-11 22:12:33.731768544 +0100
@@ -2,20 +2,20 @@
  * dir.h - Defines for directory handling in NTFS Linux kernel driver. Part of
  *	   the Linux-NTFS project.
  *
- * Copyright (c) 2002 Anton Altaparmakov.
+ * Copyright (c) 2002-2004 Anton Altaparmakov
  *
  * This program/include file is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License as published
  * by the Free Software Foundation; either version 2 of the License, or
  * (at your option) any later version.
  *
- * This program/include file is distributed in the hope that it will be
- * useful, but WITHOUT ANY WARRANTY; without even the implied warranty
+ * This program/include file is distributed in the hope that it will be
+ * useful, but WITHOUT ANY WARRANTY; without even the implied warranty
  * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
  *
  * You should have received a copy of the GNU General Public License
- * along with this program (in the main directory of the Linux-NTFS
+ * along with this program (in the main directory of the Linux-NTFS
  * distribution in the file COPYING); if not, write to the Free Software
  * Foundation,Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
@@ -44,4 +44,3 @@ extern MFT_REF ntfs_lookup_inode_by_name
 		const uchar_t *uname, const int uname_len, ntfs_name **res);

 #endif /* _LINUX_NTFS_FS_DIR_H */
-
diff -urNp -urNp /usr/src/linux-2.6.6-bk/fs/ntfs/endian.h linux-2.6.6-bk-ntfs-2.1.10/fs/ntfs/endian.h
--- /usr/src/linux-2.6.6-bk/fs/ntfs/endian.h	2004-05-11 22:10:59.334119168 +0100
+++ linux-2.6.6-bk-ntfs-2.1.10/fs/ntfs/endian.h	2004-05-11 22:12:38.587030432 +0100
@@ -2,20 +2,20 @@
  * endian.h - Defines for endianness handling in NTFS Linux kernel driver.
  *	      Part of the Linux-NTFS project.
  *
- * Copyright (c) 2001 Anton Altaparmakov.
+ * Copyright (c) 2001-2004 Anton Altaparmakov
  *
  * This program/include file is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License as published
  * by the Free Software Foundation; either version 2 of the License, or
  * (at your option) any later version.
  *
- * This program/include file is distributed in the hope that it will be
- * useful, but WITHOUT ANY WARRANTY; without even the implied warranty
+ * This program/include file is distributed in the hope that it will be
+ * useful, but WITHOUT ANY WARRANTY; without even the implied warranty
  * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
  *
  * You should have received a copy of the GNU General Public License
- * along with this program (in the main directory of the Linux-NTFS
+ * along with this program (in the main directory of the Linux-NTFS
  * distribution in the file COPYING); if not, write to the Free Software
  * Foundation,Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
@@ -45,4 +45,3 @@
 #define cpu_to_sle64p(x)	((s64)__cpu_to_le64(*(s64*)(x)))

 #endif /* _LINUX_NTFS_ENDIAN_H */
-
diff -urNp -urNp /usr/src/linux-2.6.6-bk/fs/ntfs/file.c linux-2.6.6-bk-ntfs-2.1.10/fs/ntfs/file.c
--- /usr/src/linux-2.6.6-bk/fs/ntfs/file.c	2004-05-11 22:11:14.001889328 +0100
+++ linux-2.6.6-bk-ntfs-2.1.10/fs/ntfs/file.c	2004-05-11 22:12:41.173637208 +0100
@@ -1,20 +1,20 @@
 /*
  * file.c - NTFS kernel file operations. Part of the Linux-NTFS project.
  *
- * Copyright (c) 2001 Anton Altaparmakov.
+ * Copyright (c) 2001-2004 Anton Altaparmakov
  *
  * This program/include file is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License as published
  * by the Free Software Foundation; either version 2 of the License, or
  * (at your option) any later version.
  *
- * This program/include file is distributed in the hope that it will be
- * useful, but WITHOUT ANY WARRANTY; without even the implied warranty
+ * This program/include file is distributed in the hope that it will be
+ * useful, but WITHOUT ANY WARRANTY; without even the implied warranty
  * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
  *
  * You should have received a copy of the GNU General Public License
- * along with this program (in the main directory of the Linux-NTFS
+ * along with this program (in the main directory of the Linux-NTFS
  * distribution in the file COPYING); if not, write to the Free Software
  * Foundation,Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
@@ -73,4 +73,3 @@ struct inode_operations ntfs_file_inode_
 struct file_operations ntfs_empty_file_ops = {};

 struct inode_operations ntfs_empty_inode_ops = {};
-
diff -urNp -urNp /usr/src/linux-2.6.6-bk/fs/ntfs/layout.h linux-2.6.6-bk-ntfs-2.1.10/fs/ntfs/layout.h
--- /usr/src/linux-2.6.6-bk/fs/ntfs/layout.h	2004-05-11 22:09:42.100860408 +0100
+++ linux-2.6.6-bk-ntfs-2.1.10/fs/ntfs/layout.h	2004-05-11 22:12:26.747830264 +0100
@@ -1090,7 +1090,7 @@ typedef enum {					/* Identifier authori
 	SECURITY_NULL_RID		  = 0,	/* S-1-0 */
 	SECURITY_WORLD_RID		  = 0,	/* S-1-1 */
 	SECURITY_LOCAL_RID		  = 0,	/* S-1-2 */
-
+
 	SECURITY_CREATOR_OWNER_RID	  = 0,	/* S-1-3 */
 	SECURITY_CREATOR_GROUP_RID	  = 1,	/* S-1-3 */

@@ -1110,10 +1110,10 @@ typedef enum {					/* Identifier authori
 	SECURITY_AUTHENTICATED_USER_RID	  = 0xb,
 	SECURITY_RESTRICTED_CODE_RID	  = 0xc,
 	SECURITY_TERMINAL_SERVER_RID	  = 0xd,
-
+
 	SECURITY_LOGON_IDS_RID		  = 5,
 	SECURITY_LOGON_IDS_RID_COUNT	  = 3,
-
+
 	SECURITY_LOCAL_SYSTEM_RID	  = 0x12,

 	SECURITY_NT_NON_UNIQUE		  = 0x15,
@@ -1123,12 +1123,12 @@ typedef enum {					/* Identifier authori
 	/*
 	 * Well-known domain relative sub-authority values (RIDs).
 	 */
-
+
 	/* Users. */
 	DOMAIN_USER_RID_ADMIN		  = 0x1f4,
 	DOMAIN_USER_RID_GUEST		  = 0x1f5,
 	DOMAIN_USER_RID_KRBTGT		  = 0x1f6,
-
+
 	/* Groups. */
 	DOMAIN_GROUP_RID_ADMINS		  = 0x200,
 	DOMAIN_GROUP_RID_USERS		  = 0x201,
@@ -1145,12 +1145,12 @@ typedef enum {					/* Identifier authori
 	DOMAIN_ALIAS_RID_USERS		  = 0x221,
 	DOMAIN_ALIAS_RID_GUESTS		  = 0x222,
 	DOMAIN_ALIAS_RID_POWER_USERS	  = 0x223,
-
+
 	DOMAIN_ALIAS_RID_ACCOUNT_OPS	  = 0x224,
 	DOMAIN_ALIAS_RID_SYSTEM_OPS	  = 0x225,
 	DOMAIN_ALIAS_RID_PRINT_OPS	  = 0x226,
 	DOMAIN_ALIAS_RID_BACKUP_OPS	  = 0x227,
-
+
 	DOMAIN_ALIAS_RID_REPLICATOR	  = 0x228,
 	DOMAIN_ALIAS_RID_RAS_SERVERS	  = 0x229,
 	DOMAIN_ALIAS_RID_PREW2KCOMPACCESS = 0x22a,
@@ -1258,7 +1258,7 @@ typedef enum {

 	ACCESS_ALLOWED_COMPOUND_ACE_TYPE= 4,
 	ACCESS_MAX_MS_V3_ACE_TYPE	= 4,
-
+
 	/* The following are Win2k only. */
 	ACCESS_MIN_MS_OBJECT_ACE_TYPE	= 5,
 	ACCESS_ALLOWED_OBJECT_ACE_TYPE	= 5,
@@ -1325,33 +1325,33 @@ typedef enum {
 	 */

 	/* Specific rights for files and directories are as follows: */
-
+
 	/* Right to read data from the file. (FILE) */
 	FILE_READ_DATA			= const_cpu_to_le32(0x00000001),
 	/* Right to list contents of a directory. (DIRECTORY) */
 	FILE_LIST_DIRECTORY		= const_cpu_to_le32(0x00000001),
-
+
 	/* Right to write data to the file. (FILE) */
 	FILE_WRITE_DATA			= const_cpu_to_le32(0x00000002),
 	/* Right to create a file in the directory. (DIRECTORY) */
 	FILE_ADD_FILE			= const_cpu_to_le32(0x00000002),
-
+
 	/* Right to append data to the file. (FILE) */
 	FILE_APPEND_DATA		= const_cpu_to_le32(0x00000004),
 	/* Right to create a subdirectory. (DIRECTORY) */
 	FILE_ADD_SUBDIRECTORY		= const_cpu_to_le32(0x00000004),
-
+
 	/* Right to read extended attributes. (FILE/DIRECTORY) */
 	FILE_READ_EA			= const_cpu_to_le32(0x00000008),
-
+
 	/* Right to write extended attributes. (FILE/DIRECTORY) */
 	FILE_WRITE_EA			= const_cpu_to_le32(0x00000010),
-
+
 	/* Right to execute a file. (FILE) */
 	FILE_EXECUTE			= const_cpu_to_le32(0x00000020),
 	/* Right to traverse the directory. (DIRECTORY) */
 	FILE_TRAVERSE			= const_cpu_to_le32(0x00000020),
-
+
 	/*
 	 * Right to delete a directory and all the files it contains (its
 	 * children), even if the files are read-only. (DIRECTORY)
@@ -1360,10 +1360,10 @@ typedef enum {

 	/* Right to read file attributes. (FILE/DIRECTORY) */
 	FILE_READ_ATTRIBUTES		= const_cpu_to_le32(0x00000080),
-
+
 	/* Right to change file attributes. (FILE/DIRECTORY) */
 	FILE_WRITE_ATTRIBUTES		= const_cpu_to_le32(0x00000100),
-
+
 	/*
 	 * The standard rights (bits 16 to 23). Are independent of the type of
 	 * object being secured.
@@ -1396,15 +1396,15 @@ typedef enum {
 	 * The following STANDARD_RIGHTS_* are combinations of the above for
 	 * convenience and are defined by the Win32 API.
 	 */
-
+
 	/* These are currently defined to READ_CONTROL. */
 	STANDARD_RIGHTS_READ		= const_cpu_to_le32(0x00020000),
 	STANDARD_RIGHTS_WRITE		= const_cpu_to_le32(0x00020000),
 	STANDARD_RIGHTS_EXECUTE		= const_cpu_to_le32(0x00020000),
-
+
 	/* Combines DELETE, READ_CONTROL, WRITE_DAC, and WRITE_OWNER access. */
 	STANDARD_RIGHTS_REQUIRED	= const_cpu_to_le32(0x000f0000),
-
+
 	/*
 	 * Combines DELETE, READ_CONTROL, WRITE_DAC, WRITE_OWNER, and
 	 * SYNCHRONIZE access.
@@ -1790,6 +1790,9 @@ typedef enum {
 	VOLUME_REPAIR_OBJECT_ID		= const_cpu_to_le16(0x0020),
 	VOLUME_MODIFIED_BY_CHKDSK	= const_cpu_to_le16(0x8000),
 	VOLUME_FLAGS_MASK		= const_cpu_to_le16(0x803f),
+
+	/* To make our life easier when checking if we must mount read-only. */
+	VOLUME_MUST_MOUNT_RO_MASK	= const_cpu_to_le16(0x8037),
 } __attribute__ ((__packed__)) VOLUME_FLAGS;

 /*
@@ -1973,7 +1976,7 @@ typedef enum {

 	QUOTA_FLAG_USER_MASK		= const_cpu_to_le32(0x00000007),
 		/* Bit mask for user quota flags. */
-
+
 	/* These flags are only present in the quota defaults index entry,
 	   i.e. in the entry where owner_id = QUOTA_DEFAULTS_ID. */
 	QUOTA_FLAG_TRACKING_ENABLED	= const_cpu_to_le32(0x00000010),
@@ -2177,7 +2180,7 @@ typedef enum {
 	IO_REPARSE_TAG_IS_ALIAS		= const_cpu_to_le32(0x20000000),
 	IO_REPARSE_TAG_IS_HIGH_LATENCY	= const_cpu_to_le32(0x40000000),
 	IO_REPARSE_TAG_IS_MICROSOFT	= const_cpu_to_le32(0x80000000),
-
+
 	IO_REPARSE_TAG_RESERVED_ZERO	= const_cpu_to_le32(0x00000000),
 	IO_REPARSE_TAG_RESERVED_ONE	= const_cpu_to_le32(0x00000001),
 	IO_REPARSE_TAG_RESERVED_RANGE	= const_cpu_to_le32(0x00000001),
@@ -2280,4 +2283,3 @@ typedef struct {
 } __attribute__ ((__packed__)) LOGGED_UTILITY_STREAM, EFS_ATTR;

 #endif /* _LINUX_NTFS_LAYOUT_H */
-
diff -urNp -urNp /usr/src/linux-2.6.6-bk/fs/ntfs/logfile.c linux-2.6.6-bk-ntfs-2.1.10/fs/ntfs/logfile.c
--- /usr/src/linux-2.6.6-bk/fs/ntfs/logfile.c	2004-05-11 22:09:29.144830024 +0100
+++ linux-2.6.6-bk-ntfs-2.1.10/fs/ntfs/logfile.c	2004-05-11 22:12:20.066845928 +0100
@@ -1,7 +1,7 @@
 /*
  * logfile.c - NTFS kernel journal handling. Part of the Linux-NTFS project.
  *
- * Copyright (c) 2002-2004 Anton Altaparmakov.
+ * Copyright (c) 2002-2004 Anton Altaparmakov
  *
  * This program/include file is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License as published
diff -urNp -urNp /usr/src/linux-2.6.6-bk/fs/ntfs/Makefile linux-2.6.6-bk-ntfs-2.1.10/fs/ntfs/Makefile
--- /usr/src/linux-2.6.6-bk/fs/ntfs/Makefile	2004-05-11 22:09:52.590265776 +0100
+++ linux-2.6.6-bk-ntfs-2.1.10/fs/ntfs/Makefile	2004-05-11 22:12:28.320591168 +0100
@@ -5,7 +5,7 @@ obj-$(CONFIG_NTFS_FS) += ntfs.o
 ntfs-objs := aops.o attrib.o compress.o debug.o dir.o file.o inode.o logfile.o \
 	     mft.o mst.o namei.o super.o sysctl.o unistr.o upcase.o

-EXTRA_CFLAGS = -DNTFS_VERSION=\"2.1.9\"
+EXTRA_CFLAGS = -DNTFS_VERSION=\"2.1.10\"

 ifeq ($(CONFIG_NTFS_DEBUG),y)
 EXTRA_CFLAGS += -DDEBUG
diff -urNp -urNp /usr/src/linux-2.6.6-bk/fs/ntfs/malloc.h linux-2.6.6-bk-ntfs-2.1.10/fs/ntfs/malloc.h
--- /usr/src/linux-2.6.6-bk/fs/ntfs/malloc.h	2004-05-11 22:08:39.662352504 +0100
+++ linux-2.6.6-bk-ntfs-2.1.10/fs/ntfs/malloc.h	2004-05-11 22:11:26.030060768 +0100
@@ -1,7 +1,7 @@
 /*
  * malloc.h - NTFS kernel memory handling. Part of the Linux-NTFS project.
  *
- * Copyright (c) 2001-2004 Anton Altaparmakov.
+ * Copyright (c) 2001-2004 Anton Altaparmakov
  *
  * This program/include file is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License as published
diff -urNp -urNp /usr/src/linux-2.6.6-bk/fs/ntfs/mft.c linux-2.6.6-bk-ntfs-2.1.10/fs/ntfs/mft.c
--- /usr/src/linux-2.6.6-bk/fs/ntfs/mft.c	2004-05-11 22:10:20.616005216 +0100
+++ linux-2.6.6-bk-ntfs-2.1.10/fs/ntfs/mft.c	2004-05-11 22:12:33.623784960 +0100
@@ -1,7 +1,7 @@
 /**
  * mft.c - NTFS kernel mft record operations. Part of the Linux-NTFS project.
  *
- * Copyright (c) 2001-2003 Anton Altaparmakov
+ * Copyright (c) 2001-2004 Anton Altaparmakov
  * Copyright (c) 2002 Richard Russon
  *
  * This program/include file is free software; you can redistribute it and/or
@@ -9,13 +9,13 @@
  * by the Free Software Foundation; either version 2 of the License, or
  * (at your option) any later version.
  *
- * This program/include file is distributed in the hope that it will be
- * useful, but WITHOUT ANY WARRANTY; without even the implied warranty
+ * This program/include file is distributed in the hope that it will be
+ * useful, but WITHOUT ANY WARRANTY; without even the implied warranty
  * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
  *
  * You should have received a copy of the GNU General Public License
- * along with this program (in the main directory of the Linux-NTFS
+ * along with this program (in the main directory of the Linux-NTFS
  * distribution in the file COPYING); if not, write to the Free Software
  * Foundation,Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
@@ -429,4 +429,3 @@ unm_err_out:
 		ntfs_clear_extent_inode(ni);
 	return m;
 }
-
diff -urNp -urNp /usr/src/linux-2.6.6-bk/fs/ntfs/mft.h linux-2.6.6-bk-ntfs-2.1.10/fs/ntfs/mft.h
--- /usr/src/linux-2.6.6-bk/fs/ntfs/mft.h	2004-05-11 22:08:50.764664696 +0100
+++ linux-2.6.6-bk-ntfs-2.1.10/fs/ntfs/mft.h	2004-05-11 22:11:35.268656288 +0100
@@ -2,7 +2,7 @@
  * mft.h - Defines for mft record handling in NTFS Linux kernel driver.
  *	   Part of the Linux-NTFS project.
  *
- * Copyright (c) 2001-2004 Anton Altaparmakov.
+ * Copyright (c) 2001-2004 Anton Altaparmakov
  *
  * This program/include file is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License as published
@@ -28,8 +28,6 @@
 #include "inode.h"

 extern int format_mft_record(ntfs_inode *ni, MFT_RECORD *m);
-//extern int format_mft_record2(struct super_block *vfs_sb,
-//		const unsigned long inum, MFT_RECORD *m);

 extern MFT_RECORD *map_mft_record(ntfs_inode *ni);
 extern void unmap_mft_record(ntfs_inode *ni);
diff -urNp -urNp /usr/src/linux-2.6.6-bk/fs/ntfs/mst.c linux-2.6.6-bk-ntfs-2.1.10/fs/ntfs/mst.c
--- /usr/src/linux-2.6.6-bk/fs/ntfs/mst.c	2004-05-11 22:10:04.414468224 +0100
+++ linux-2.6.6-bk-ntfs-2.1.10/fs/ntfs/mst.c	2004-05-11 22:12:30.394275920 +0100
@@ -2,7 +2,7 @@
  * mst.c - NTFS multi sector transfer protection handling code. Part of the
  *	   Linux-NTFS project.
  *
- * Copyright (c) 2001-2004 Anton Altaparmakov.
+ * Copyright (c) 2001-2004 Anton Altaparmakov
  *
  * This program/include file is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License as published
diff -urNp -urNp /usr/src/linux-2.6.6-bk/fs/ntfs/namei.c linux-2.6.6-bk-ntfs-2.1.10/fs/ntfs/namei.c
--- /usr/src/linux-2.6.6-bk/fs/ntfs/namei.c	2004-05-11 22:10:50.467467104 +0100
+++ linux-2.6.6-bk-ntfs-2.1.10/fs/ntfs/namei.c	2004-05-11 22:12:36.923283360 +0100
@@ -1,6 +1,6 @@
 /*
  * namei.c - NTFS kernel directory inode operations. Part of the Linux-NTFS
- * 	     project.
+ *	     project.
  *
  * Copyright (c) 2001-2004 Anton Altaparmakov
  *
@@ -9,13 +9,13 @@
  * by the Free Software Foundation; either version 2 of the License, or
  * (at your option) any later version.
  *
- * This program/include file is distributed in the hope that it will be
- * useful, but WITHOUT ANY WARRANTY; without even the implied warranty
+ * This program/include file is distributed in the hope that it will be
+ * useful, but WITHOUT ANY WARRANTY; without even the implied warranty
  * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
  *
  * You should have received a copy of the GNU General Public License
- * along with this program (in the main directory of the Linux-NTFS
+ * along with this program (in the main directory of the Linux-NTFS
  * distribution in the file COPYING); if not, write to the Free Software
  * Foundation,Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
diff -urNp -urNp /usr/src/linux-2.6.6-bk/fs/ntfs/ntfs.h linux-2.6.6-bk-ntfs-2.1.10/fs/ntfs/ntfs.h
--- /usr/src/linux-2.6.6-bk/fs/ntfs/ntfs.h	2004-05-11 22:09:19.992221432 +0100
+++ linux-2.6.6-bk-ntfs-2.1.10/fs/ntfs/ntfs.h	2004-05-11 22:12:19.178980904 +0100
@@ -2,8 +2,8 @@
  * ntfs.h - Defines for NTFS Linux kernel driver. Part of the Linux-NTFS
  *	    project.
  *
- * Copyright (c) 2001-2004 Anton Altaparmakov.
- * Copyright (C) 2002 Richard Russon.
+ * Copyright (c) 2001-2004 Anton Altaparmakov
+ * Copyright (C) 2002 Richard Russon
  *
  * This program/include file is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License as published
@@ -202,4 +202,3 @@ extern int ntfs_ucstonls(const ntfs_volu
 extern uchar_t *generate_default_upcase(void);

 #endif /* _LINUX_NTFS_H */
-
diff -urNp -urNp /usr/src/linux-2.6.6-bk/fs/ntfs/super.c linux-2.6.6-bk-ntfs-2.1.10/fs/ntfs/super.c
--- /usr/src/linux-2.6.6-bk/fs/ntfs/super.c	2004-05-11 22:10:23.850513496 +0100
+++ linux-2.6.6-bk-ntfs-2.1.10/fs/ntfs/super.c	2004-05-11 22:12:34.312680232 +0100
@@ -314,7 +314,9 @@ static int ntfs_remount(struct super_blo
 #else /* ! NTFS_RW */
 	/*
 	 * For the read-write compiled driver, if we are remounting read-write,
-	 * make sure there aren't any volume errors and empty the lofgile.
+	 * make sure there are no volume errors and that no unsupported volume
+	 * flags are set.  Also, empty the logfile journal as it would become
+	 * stale as soon as something is written to the volume.
 	 */
 	if ((sb->s_flags & MS_RDONLY) && !(*flags & MS_RDONLY)) {
 		static const char *es = ".  Cannot remount read-write.";
@@ -324,6 +326,11 @@ static int ntfs_remount(struct super_blo
 					es);
 			return -EROFS;
 		}
+		if (vol->vol_flags & VOLUME_MUST_MOUNT_RO_MASK) {
+			ntfs_error(sb, "Volume has unsupported flags set and "
+					"is read-only%s", es);
+			return -EROFS;
+		}
 		if (!ntfs_empty_logfile(vol->logfile_ino)) {
 			ntfs_error(sb, "Failed to empty journal $LogFile%s",
 					es);
@@ -1133,6 +1140,31 @@ get_ctx_vol_failed:
 	printk(KERN_INFO "NTFS volume version %i.%i.\n", vol->major_ver,
 			vol->minor_ver);
 #ifdef NTFS_RW
+	/* Make sure that no unsupported volume flags are set. */
+	if (vol->vol_flags & VOLUME_MUST_MOUNT_RO_MASK) {
+		static const char *es1 = "Volume has unsupported flags set ";
+		static const char *es2 = ".  Run chkdsk and mount in Windows.";
+
+		/* If a read-write mount, convert it to a read-only mount. */
+		if (!(sb->s_flags & MS_RDONLY)) {
+			if (!(vol->on_errors & (ON_ERRORS_REMOUNT_RO |
+					ON_ERRORS_CONTINUE))) {
+				ntfs_error(sb, "%s and neither on_errors="
+						"continue nor on_errors="
+						"remount-ro was specified%s",
+						es1, es2);
+				goto iput_vol_err_out;
+			}
+			sb->s_flags |= MS_RDONLY | MS_NOATIME | MS_NODIRATIME;
+			ntfs_error(sb, "%s.  Mounting read-only%s", es1, es2);
+		} else
+			ntfs_warning(sb, "%s.  Will not be able to remount "
+					"read-write%s", es1, es2);
+		/*
+		 * Do not set NVolErrors() because ntfs_remount() re-checks the
+		 * flags which we need to do in case any flags have changed.
+		 */
+	}
 	/*
 	 * Get the inode for the logfile, check it and determine if the volume
 	 * was shutdown cleanly.
@@ -1240,6 +1272,7 @@ iput_logfile_err_out:
 #ifdef NTFS_RW
 	if (vol->logfile_ino)
 		iput(vol->logfile_ino);
+iput_vol_err_out:
 #endif /* NTFS_RW */
 	iput(vol->vol_ino);
 iput_lcnbmp_err_out:
diff -urNp -urNp /usr/src/linux-2.6.6-bk/fs/ntfs/sysctl.c linux-2.6.6-bk-ntfs-2.1.10/fs/ntfs/sysctl.c
--- /usr/src/linux-2.6.6-bk/fs/ntfs/sysctl.c	2004-05-11 22:08:34.976064928 +0100
+++ linux-2.6.6-bk-ntfs-2.1.10/fs/ntfs/sysctl.c	2004-05-11 22:11:20.138956352 +0100
@@ -1,22 +1,22 @@
 /*
  * sysctl.c - Code for sysctl handling in NTFS Linux kernel driver. Part of
  *	      the Linux-NTFS project. Adapted from the old NTFS driver,
- *	      Copyright (C) 1997 Martin von Löwis, Régis Duchesne.
+ *	      Copyright (C) 1997 Martin von Löwis, Régis Duchesne
  *
- * Copyright (c) 2002 Anton Altaparmakov.
+ * Copyright (c) 2002-2004 Anton Altaparmakov
  *
  * This program/include file is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License as published
  * by the Free Software Foundation; either version 2 of the License, or
  * (at your option) any later version.
  *
- * This program/include file is distributed in the hope that it will be
- * useful, but WITHOUT ANY WARRANTY; without even the implied warranty
+ * This program/include file is distributed in the hope that it will be
+ * useful, but WITHOUT ANY WARRANTY; without even the implied warranty
  * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
  *
  * You should have received a copy of the GNU General Public License
- * along with this program (in the main directory of the Linux-NTFS
+ * along with this program (in the main directory of the Linux-NTFS
  * distribution in the file COPYING); if not, write to the Free Software
  * Foundation,Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
@@ -37,7 +37,7 @@

 /* Definition of the ntfs sysctl. */
 static ctl_table ntfs_sysctls[] = {
-	{ FS_NTFS, "ntfs-debug", 		/* Binary and text IDs. */
+	{ FS_NTFS, "ntfs-debug",		/* Binary and text IDs. */
 	  &debug_msgs,sizeof(debug_msgs),	/* Data pointer and size. */
 	  0644,	NULL, &proc_dointvec },		/* Mode, child, proc handler. */
 	{ 0 }
@@ -83,4 +83,3 @@ int ntfs_sysctl(int add)

 #endif /* CONFIG_SYSCTL */
 #endif /* DEBUG */
-
diff -urNp -urNp /usr/src/linux-2.6.6-bk/fs/ntfs/sysctl.h linux-2.6.6-bk-ntfs-2.1.10/fs/ntfs/sysctl.h
--- /usr/src/linux-2.6.6-bk/fs/ntfs/sysctl.h	2004-05-11 22:09:20.222186472 +0100
+++ linux-2.6.6-bk-ntfs-2.1.10/fs/ntfs/sysctl.h	2004-05-11 22:12:19.180980600 +0100
@@ -1,22 +1,22 @@
 /*
  * sysctl.h - Defines for sysctl handling in NTFS Linux kernel driver. Part of
  *	      the Linux-NTFS project. Adapted from the old NTFS driver,
- *	      Copyright (C) 1997 Martin von Löwis, Régis Duchesne.
- *
- * Copyright (c) 2002 Anton Altaparmakov.
+ *	      Copyright (C) 1997 Martin von Löwis, Régis Duchesne
+ *
+ * Copyright (c) 2002-2004 Anton Altaparmakov
  *
  * This program/include file is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License as published
  * by the Free Software Foundation; either version 2 of the License, or
  * (at your option) any later version.
  *
- * This program/include file is distributed in the hope that it will be
- * useful, but WITHOUT ANY WARRANTY; without even the implied warranty
+ * This program/include file is distributed in the hope that it will be
+ * useful, but WITHOUT ANY WARRANTY; without even the implied warranty
  * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
  *
  * You should have received a copy of the GNU General Public License
- * along with this program (in the main directory of the Linux-NTFS
+ * along with this program (in the main directory of the Linux-NTFS
  * distribution in the file COPYING); if not, write to the Free Software
  * Foundation,Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
@@ -40,4 +40,3 @@ static inline int ntfs_sysctl(int add)

 #endif /* DEBUG && CONFIG_SYSCTL */
 #endif /* _LINUX_NTFS_SYSCTL_H */
-
diff -urNp -urNp /usr/src/linux-2.6.6-bk/fs/ntfs/time.h linux-2.6.6-bk-ntfs-2.1.10/fs/ntfs/time.h
--- /usr/src/linux-2.6.6-bk/fs/ntfs/time.h	2004-05-11 22:10:19.535169528 +0100
+++ linux-2.6.6-bk-ntfs-2.1.10/fs/ntfs/time.h	2004-05-11 22:12:33.377822352 +0100
@@ -1,7 +1,7 @@
 /*
  * time.h - NTFS time conversion functions.  Part of the Linux-NTFS project.
  *
- * Copyright (c) 2001-2004 Anton Altaparmakov.
+ * Copyright (c) 2001-2004 Anton Altaparmakov
  *
  * This program/include file is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License as published
diff -urNp -urNp /usr/src/linux-2.6.6-bk/fs/ntfs/types.h linux-2.6.6-bk-ntfs-2.1.10/fs/ntfs/types.h
--- /usr/src/linux-2.6.6-bk/fs/ntfs/types.h	2004-05-11 22:11:01.453796928 +0100
+++ linux-2.6.6-bk-ntfs-2.1.10/fs/ntfs/types.h	2004-05-11 22:12:39.574880256 +0100
@@ -2,7 +2,7 @@
  * types.h - Defines for NTFS Linux kernel driver specific types.
  *	     Part of the Linux-NTFS project.
  *
- * Copyright (c) 2001-2004 Anton Altaparmakov.
+ * Copyright (c) 2001-2004 Anton Altaparmakov
  *
  * This program/include file is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License as published
diff -urNp -urNp /usr/src/linux-2.6.6-bk/fs/ntfs/unistr.c linux-2.6.6-bk-ntfs-2.1.10/fs/ntfs/unistr.c
--- /usr/src/linux-2.6.6-bk/fs/ntfs/unistr.c	2004-05-11 22:10:22.428729640 +0100
+++ linux-2.6.6-bk-ntfs-2.1.10/fs/ntfs/unistr.c	2004-05-11 22:12:33.977731152 +0100
@@ -8,13 +8,13 @@
  * by the Free Software Foundation; either version 2 of the License, or
  * (at your option) any later version.
  *
- * This program/include file is distributed in the hope that it will be
- * useful, but WITHOUT ANY WARRANTY; without even the implied warranty
+ * This program/include file is distributed in the hope that it will be
+ * useful, but WITHOUT ANY WARRANTY; without even the implied warranty
  * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
  *
  * You should have received a copy of the GNU General Public License
- * along with this program (in the main directory of the Linux-NTFS
+ * along with this program (in the main directory of the Linux-NTFS
  * distribution in the file COPYING); if not, write to the Free Software
  * Foundation,Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
@@ -62,9 +62,8 @@ static const u8 legal_ansi_char_array[0x
  * the @upcase table is used to performa a case insensitive comparison.
  */
 BOOL ntfs_are_names_equal(const uchar_t *s1, size_t s1_len,
-		     const uchar_t *s2, size_t s2_len,
-		     const IGNORE_CASE_BOOL ic,
-		     const uchar_t *upcase, const u32 upcase_size)
+		const uchar_t *s2, size_t s2_len, const IGNORE_CASE_BOOL ic,
+		const uchar_t *upcase, const u32 upcase_size)
 {
 	if (s1_len != s2_len)
 		return FALSE;
@@ -78,12 +77,12 @@ BOOL ntfs_are_names_equal(const uchar_t
  * @name1:	first Unicode name to compare
  * @name2:	second Unicode name to compare
  * @err_val:	if @name1 contains an invalid character return this value
- * @ic:         either CASE_SENSITIVE or IGNORE_CASE
+ * @ic:		either CASE_SENSITIVE or IGNORE_CASE
  * @upcase:	upcase table (ignored if @ic is CASE_SENSITIVE)
  * @upcase_len:	upcase table size (ignored if @ic is CASE_SENSITIVE)
  *
  * ntfs_collate_names collates two Unicode names and returns:
- *
+ *
  *  -1 if the first name collates before the second one,
  *   0 if the names match,
  *   1 if the second name collates before the first one, or
@@ -138,7 +137,7 @@ int ntfs_collate_names(const uchar_t *na
  * Compare the first @n characters of the Unicode strings @s1 and @s2,
  * The strings in little endian format and appropriate le16_to_cpu()
  * conversion is performed on non-little endian machines.
- *
+ *
  * The function returns an integer less than, equal to, or greater than zero
  * if @s1 (or the first @n Unicode characters thereof) is found, respectively,
  * to be less than, to match, or be greater than @s2.
@@ -172,7 +171,7 @@ int ntfs_ucsncmp(const uchar_t *s1, cons
  * Compare the first @n characters of the Unicode strings @s1 and @s2,
  * ignoring case. The strings in little endian format and appropriate
  * le16_to_cpu() conversion is performed on non-little endian machines.
- *
+ *
  * Each character is uppercased using the @upcase table before the comparison.
  *
  * The function returns an integer less than, equal to, or greater than zero
@@ -180,7 +179,7 @@ int ntfs_ucsncmp(const uchar_t *s1, cons
  * to be less than, to match, or be greater than @s2.
  */
 int ntfs_ucsncasecmp(const uchar_t *s1, const uchar_t *s2, size_t n,
-		     const uchar_t *upcase, const u32 upcase_size)
+		const uchar_t *upcase, const u32 upcase_size)
 {
 	uchar_t c1, c2;
 	size_t i;
@@ -381,4 +380,3 @@ mem_err_out:
 	ntfs_error(vol->sb, "Failed to allocate name!");
 	return -ENOMEM;
 }
-
diff -urNp -urNp /usr/src/linux-2.6.6-bk/fs/ntfs/volume.h linux-2.6.6-bk-ntfs-2.1.10/fs/ntfs/volume.h
--- /usr/src/linux-2.6.6-bk/fs/ntfs/volume.h	2004-05-11 22:08:39.663352352 +0100
+++ linux-2.6.6-bk-ntfs-2.1.10/fs/ntfs/volume.h	2004-05-11 22:11:26.031060616 +0100
@@ -2,8 +2,8 @@
  * volume.h - Defines for volume structures in NTFS Linux kernel driver. Part
  *	      of the Linux-NTFS project.
  *
- * Copyright (c) 2001-2004 Anton Altaparmakov.
- * Copyright (c) 2002 Richard Russon.
+ * Copyright (c) 2001-2004 Anton Altaparmakov
+ * Copyright (c) 2002 Richard Russon
  *
  * This program/include file is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License as published

===================================================================

This BitKeeper patch contains the following changesets:
1.1615
## Wrapped with gzip_uu ##


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
5?6JQ."0SRS/<*&K^%T.:^>(4'

This BitKeeper patch contains the following changesets:
1.1613
## Wrapped with gzip_uu ##


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
M\='YZ>73ER^?HR3<V[Q\>1WJU%37+!E%]LAE(?-;"-1(.4-)K"G?)^%!KV?
M%+- I>3STQ?GPXOA+Z=HOKBI<A7B#96-I.&9\%*2_2@/E),^0_M1'BB[0T/[
ML?6-,L4;NVHU:MU8MMM-<KN7;6.2>^V+?=A<5\.;&^T(XFYD0V9^?Q:MG49W
M+-K*\,^6FX?MN7EM:*SX_ED!_%U\S>U60N"1$86+DG[QJ_7;&V/6PKT9WZMV
M5/E%/=<466'SG>_$79G!%U-1/.&R.<90?>>ND\M;?L5O*T%%GUT57_%3M+WN
MU#&0?J\"S/)+BJZIALKN.\\9W+Q>?^4>4N;P]W0Y/8Q4(*72L?=_UF+0R]P_
"

