Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932299AbWBXQKr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932299AbWBXQKr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 11:10:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932297AbWBXQKr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 11:10:47 -0500
Received: from ppsw-0.csi.cam.ac.uk ([131.111.8.130]:48793 "EHLO
	ppsw-0.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S932296AbWBXQKq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 11:10:46 -0500
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Date: Fri, 24 Feb 2006 16:10:40 +0000 (GMT)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net
Subject: [PATCH 5/5] NTFS: Do more detailed reporting of why we cannot mount
 read-write
In-Reply-To: <Pine.LNX.4.64.0602241608540.2136@hermes-2.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.64.0602241609430.2136@hermes-2.csi.cam.ac.uk>
References: <Pine.LNX.4.64.0602241559150.2136@hermes-2.csi.cam.ac.uk>
 <Pine.LNX.4.64.0602241605210.2136@hermes-2.csi.cam.ac.uk>
 <Pine.LNX.4.64.0602241607280.2136@hermes-2.csi.cam.ac.uk>
 <Pine.LNX.4.64.0602241608120.2136@hermes-2.csi.cam.ac.uk>
 <Pine.LNX.4.64.0602241608540.2136@hermes-2.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

NTFS: Do more detailed reporting of why we cannot mount read-write by
      special casing the VOLUME_MODIFIED_BY_CHKDSK flag.

Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

---

 Documentation/filesystems/ntfs.txt |    6 ++++++
 fs/ntfs/ChangeLog                  |    2 ++
 fs/ntfs/Makefile                   |    2 +-
 fs/ntfs/super.c                    |   34 +++++++++++++++++++++++++++-------
 fs/ntfs/upcase.c                   |   10 ++++------
 fs/ntfs/volume.h                   |   28 +++++++++++++---------------
 6 files changed, 53 insertions(+), 29 deletions(-)

1cf3109ffb26a6ea572fd02436bd10458b4b2187
diff --git a/Documentation/filesystems/ntfs.txt b/Documentation/filesystems/ntfs.txt
index 614de31..2511685 100644
--- a/Documentation/filesystems/ntfs.txt
+++ b/Documentation/filesystems/ntfs.txt
@@ -457,6 +457,12 @@ ChangeLog
 
 Note, a technical ChangeLog aimed at kernel hackers is in fs/ntfs/ChangeLog.
 
+2.1.26:
+	- Implement support for sector sizes above 512 bytes (up to the maximum
+	  supported by NTFS which is 4096 bytes).
+	- Enhance support for NTFS volumes which were supported by Windows but
+	  not by Linux due to invalid attribute list attribute flags.
+	- A few minor updates and bug fixes.
 2.1.25:
 	- Write support is now extended with write(2) being able to both
 	  overwrite existing file data and to extend files.  Also, if a write
diff --git a/fs/ntfs/ChangeLog b/fs/ntfs/ChangeLog
index e66b4ac..9d8ffa8 100644
--- a/fs/ntfs/ChangeLog
+++ b/fs/ntfs/ChangeLog
@@ -29,6 +29,8 @@ ToDo/Notes:
 	  kmem_cache_t.  (Pekka Enberg)
 	- Implement support for sector sizes above 512 bytes (up to the maximum
 	  supported by NTFS which is 4096 bytes).
+	- Do more detailed reporting of why we cannot mount read-write by
+	  special casing the VOLUME_MODIFIED_BY_CHKDSK flag.
 	- Miscellaneous updates to layout.h.
 	- Cope with attribute list attribute having invalid flags.  Windows
 	  copes with this and even chkdsk does not detect or fix this so we
diff --git a/fs/ntfs/Makefile b/fs/ntfs/Makefile
index d0d45d1..d95fac7 100644
--- a/fs/ntfs/Makefile
+++ b/fs/ntfs/Makefile
@@ -6,7 +6,7 @@ ntfs-objs := aops.o attrib.o collate.o c
 	     index.o inode.o mft.o mst.o namei.o runlist.o super.o sysctl.o \
 	     unistr.o upcase.o
 
-EXTRA_CFLAGS = -DNTFS_VERSION=\"2.1.25\"
+EXTRA_CFLAGS = -DNTFS_VERSION=\"2.1.26\"
 
 ifeq ($(CONFIG_NTFS_DEBUG),y)
 EXTRA_CFLAGS += -DDEBUG
diff --git a/fs/ntfs/super.c b/fs/ntfs/super.c
index 489f704..368a8ec 100644
--- a/fs/ntfs/super.c
+++ b/fs/ntfs/super.c
@@ -472,9 +472,16 @@ static int ntfs_remount(struct super_blo
 			ntfs_error(sb, "Volume is dirty and read-only%s", es);
 			return -EROFS;
 		}
+		if (vol->vol_flags & VOLUME_MODIFIED_BY_CHKDSK) {
+			ntfs_error(sb, "Volume has been modified by chkdsk "
+					"and is read-only%s", es);
+			return -EROFS;
+		}
 		if (vol->vol_flags & VOLUME_MUST_MOUNT_RO_MASK) {
-			ntfs_error(sb, "Volume has unsupported flags set and "
-					"is read-only%s", es);
+			ntfs_error(sb, "Volume has unsupported flags set "
+					"(0x%x) and is read-only%s",
+					(unsigned)le16_to_cpu(vol->vol_flags),
+					es);
 			return -EROFS;
 		}
 		if (ntfs_set_volume_flags(vol, VOLUME_IS_DIRTY)) {
@@ -1845,11 +1852,24 @@ get_ctx_vol_failed:
 	/* Make sure that no unsupported volume flags are set. */
 	if (vol->vol_flags & VOLUME_MUST_MOUNT_RO_MASK) {
 		static const char *es1a = "Volume is dirty";
-		static const char *es1b = "Volume has unsupported flags set";
-		static const char *es2 = ".  Run chkdsk and mount in Windows.";
-		const char *es1;
-		
-		es1 = vol->vol_flags & VOLUME_IS_DIRTY ? es1a : es1b;
+		static const char *es1b = "Volume has been modified by chkdsk";
+		static const char *es1c = "Volume has unsupported flags set";
+		static const char *es2a = ".  Run chkdsk and mount in Windows.";
+		static const char *es2b = ".  Mount in Windows.";
+		const char *es1, *es2;
+
+		es2 = es2a;
+		if (vol->vol_flags & VOLUME_IS_DIRTY)
+			es1 = es1a;
+		else if (vol->vol_flags & VOLUME_MODIFIED_BY_CHKDSK) {
+			es1 = es1b;
+			es2 = es2b;
+		} else {
+			es1 = es1c;
+			ntfs_warning(sb, "Unsupported volume flags 0x%x "
+					"encountered.",
+					(unsigned)le16_to_cpu(vol->vol_flags));
+		}
 		/* If a read-write mount, convert it to a read-only mount. */
 		if (!(sb->s_flags & MS_RDONLY)) {
 			if (!(vol->on_errors & (ON_ERRORS_REMOUNT_RO |
diff --git a/fs/ntfs/upcase.c b/fs/ntfs/upcase.c
index 879cdf1..9101807 100644
--- a/fs/ntfs/upcase.c
+++ b/fs/ntfs/upcase.c
@@ -3,10 +3,7 @@
  *	      Part of the Linux-NTFS project.
  *
  * Copyright (c) 2001 Richard Russon <ntfs@flatcap.org>
- * Copyright (c) 2001-2004 Anton Altaparmakov
- *
- * Modified for mkntfs inclusion 9 June 2001 by Anton Altaparmakov.
- * Modified for kernel inclusion 10 September 2001 by Anton Altparmakov.
+ * Copyright (c) 2001-2006 Anton Altaparmakov
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms of the GNU General Public License as published by the Free
@@ -75,12 +72,13 @@ ntfschar *generate_default_upcase(void)
 	if (!uc)
 		return uc;
 	memset(uc, 0, default_upcase_len * sizeof(ntfschar));
+	/* Generate the little endian Unicode upcase table used by ntfs. */
 	for (i = 0; i < default_upcase_len; i++)
 		uc[i] = cpu_to_le16(i);
 	for (r = 0; uc_run_table[r][0]; r++)
 		for (i = uc_run_table[r][0]; i < uc_run_table[r][1]; i++)
-			uc[i] = cpu_to_le16((le16_to_cpu(uc[i]) +
-					uc_run_table[r][2]));
+			uc[i] = cpu_to_le16(le16_to_cpu(uc[i]) +
+					uc_run_table[r][2]);
 	for (r = 0; uc_dup_table[r][0]; r++)
 		for (i = uc_dup_table[r][0]; i < uc_dup_table[r][1]; i += 2)
 			uc[i + 1] = cpu_to_le16(le16_to_cpu(uc[i + 1]) - 1);
diff --git a/fs/ntfs/volume.h b/fs/ntfs/volume.h
index 375cd20..406ab55 100644
--- a/fs/ntfs/volume.h
+++ b/fs/ntfs/volume.h
@@ -2,7 +2,7 @@
  * volume.h - Defines for volume structures in NTFS Linux kernel driver. Part
  *	      of the Linux-NTFS project.
  *
- * Copyright (c) 2001-2005 Anton Altaparmakov
+ * Copyright (c) 2001-2006 Anton Altaparmakov
  * Copyright (c) 2002 Richard Russon
  *
  * This program/include file is free software; you can redistribute it and/or
@@ -41,10 +41,8 @@ typedef struct {
 	 * structure has stabilized... (AIA)
 	 */
 	/* Device specifics. */
-	struct super_block *sb;		/* Pointer back to the super_block,
-					   so we don't have to get the offset
-					   every time. */
-	LCN nr_blocks;			/* Number of NTFS_BLOCK_SIZE bytes
+	struct super_block *sb;		/* Pointer back to the super_block. */
+	LCN nr_blocks;			/* Number of sb->s_blocksize bytes
 					   sized blocks on the device. */
 	/* Configuration provided by user at mount time. */
 	unsigned long flags;		/* Miscellaneous flags, see below. */
@@ -141,8 +139,8 @@ typedef enum {
 	NV_ShowSystemFiles,	/* 1: Return system files in ntfs_readdir(). */
 	NV_CaseSensitive,	/* 1: Treat file names as case sensitive and
 				      create filenames in the POSIX namespace.
-				      Otherwise be case insensitive and create
-				      file names in WIN32 namespace. */
+				      Otherwise be case insensitive but still
+				      create file names in POSIX namespace. */
 	NV_LogFileEmpty,	/* 1: $LogFile journal is empty. */
 	NV_QuotaOutOfDate,	/* 1: $Quota is out of date. */
 	NV_UsnJrnlStamped,	/* 1: $UsnJrnl has been stamped. */
@@ -153,7 +151,7 @@ typedef enum {
  * Macro tricks to expand the NVolFoo(), NVolSetFoo(), and NVolClearFoo()
  * functions.
  */
-#define NVOL_FNS(flag)					\
+#define DEFINE_NVOL_BIT_OPS(flag)					\
 static inline int NVol##flag(ntfs_volume *vol)		\
 {							\
 	return test_bit(NV_##flag, &(vol)->flags);	\
@@ -168,12 +166,12 @@ static inline void NVolClear##flag(ntfs_
 }
 
 /* Emit the ntfs volume bitops functions. */
-NVOL_FNS(Errors)
-NVOL_FNS(ShowSystemFiles)
-NVOL_FNS(CaseSensitive)
-NVOL_FNS(LogFileEmpty)
-NVOL_FNS(QuotaOutOfDate)
-NVOL_FNS(UsnJrnlStamped)
-NVOL_FNS(SparseEnabled)
+DEFINE_NVOL_BIT_OPS(Errors)
+DEFINE_NVOL_BIT_OPS(ShowSystemFiles)
+DEFINE_NVOL_BIT_OPS(CaseSensitive)
+DEFINE_NVOL_BIT_OPS(LogFileEmpty)
+DEFINE_NVOL_BIT_OPS(QuotaOutOfDate)
+DEFINE_NVOL_BIT_OPS(UsnJrnlStamped)
+DEFINE_NVOL_BIT_OPS(SparseEnabled)
 
 #endif /* _LINUX_NTFS_VOLUME_H */
-- 
1.2.3.g9821

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/
