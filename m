Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268920AbUIXQSF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268920AbUIXQSF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 12:18:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268915AbUIXQRf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 12:17:35 -0400
Received: from ppsw-5.csi.cam.ac.uk ([131.111.8.135]:61864 "EHLO
	ppsw-5.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S268831AbUIXQN5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 12:13:57 -0400
Date: Fri, 24 Sep 2004 17:13:53 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
cc: viro@parcelfarce.linux.theplanet.co.uk, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net
Subject: [PATCH 6/10] Re: [2.6-BK-URL] NTFS: 2.1.19 sparse annotation, cleanups
 and a bugfix
In-Reply-To: <Pine.LNX.4.60.0409241713220.19983@hermes-1.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.60.0409241713380.19983@hermes-1.csi.cam.ac.uk>
References: <Pine.LNX.4.60.0409241707370.19983@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0409241711400.19983@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0409241712320.19983@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0409241712490.19983@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0409241713070.19983@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0409241713220.19983@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is patch 6/10 in the series.  It contains the following ChangeSet:

<aia21@cantab.net> (04/09/24 1.1952.1.1)
   NTFS: Begin of sparse annotations: new data types and endianness conversion.
   
   - Add le{16,32,64} as well as sle{16,32,64} data types to fs/ntfs/types.h.
   - Change ntfschar to be le16 instead of u16 in fs/ntfs/types.h.
   - Add le versions of VCN, LCN, and LSN called leVCN, leLCN, and leLSN,
     respectively, to fs/ntfs/types.h.
   - Update endianness conversion macros in fs/ntfs/endian.h to use the
     new types as appropriate.
   - Do proper type casting when using sle64_to_cpup() in fs/ntfs/dir.c
     and index.c.
   
   Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/, http://www-stu.christs.cam.ac.uk/~aia21/

===================================================================

diff -Nru a/fs/ntfs/ChangeLog b/fs/ntfs/ChangeLog
--- a/fs/ntfs/ChangeLog	2004-09-24 17:06:20 +01:00
+++ b/fs/ntfs/ChangeLog	2004-09-24 17:06:20 +01:00
@@ -34,6 +34,15 @@
 	- Update ->truncate (fs/ntfs/inode.c::ntfs_truncate()) to check if the
 	  inode size has changed and to only output an error if so.
 	- Rename fs/ntfs/attrib.h::attribute_value_length() to ntfs_attr_size().
+	- Add le{16,32,64} as well as sle{16,32,64} data types to
+	  fs/ntfs/types.h.
+	- Change ntfschar to be le16 instead of u16 in fs/ntfs/types.h.
+	- Add le versions of VCN, LCN, and LSN called leVCN, leLCN, and leLSN,
+	  respectively, to fs/ntfs/types.h.
+	- Update endianness conversion macros in fs/ntfs/endian.h to use the
+	  new types as appropriate.
+	- Do proper type casting when using sle64_to_cpup() in fs/ntfs/dir.c
+	  and index.c.
 
 2.1.18 - Fix scheduling latencies at mount time as well as an endianness bug.
 
diff -Nru a/fs/ntfs/dir.c b/fs/ntfs/dir.c
--- a/fs/ntfs/dir.c	2004-09-24 17:06:20 +01:00
+++ b/fs/ntfs/dir.c	2004-09-24 17:06:20 +01:00
@@ -299,7 +299,7 @@
 		goto err_out;
 	}
 	/* Get the starting vcn of the index_block holding the child node. */
-	vcn = sle64_to_cpup((u8*)ie + le16_to_cpu(ie->length) - 8);
+	vcn = sle64_to_cpup((sle64*)((u8*)ie + le16_to_cpu(ie->length) - 8));
 	ia_mapping = VFS_I(dir_ni)->i_mapping;
 	/*
 	 * We are done with the index root and the mft record. Release them,
@@ -551,7 +551,8 @@
 		}
 		/* Child node present, descend into it. */
 		old_vcn = vcn;
-		vcn = sle64_to_cpup((u8*)ie + le16_to_cpu(ie->length) - 8);
+		vcn = sle64_to_cpup((sle64*)((u8*)ie +
+				le16_to_cpu(ie->length) - 8));
 		if (vcn >= 0) {
 			/* If vcn is in the same page cache page as old_vcn we
 			 * recycle the mapped page. */
diff -Nru a/fs/ntfs/endian.h b/fs/ntfs/endian.h
--- a/fs/ntfs/endian.h	2004-09-24 17:06:20 +01:00
+++ b/fs/ntfs/endian.h	2004-09-24 17:06:20 +01:00
@@ -24,24 +24,70 @@
 #define _LINUX_NTFS_ENDIAN_H
 
 #include <asm/byteorder.h>
+#include "types.h"
 
 /*
- * Signed endianness conversion defines.
+ * Signed endianness conversion functions.
  */
-#define sle16_to_cpu(x)		((s16)__le16_to_cpu((s16)(x)))
-#define sle32_to_cpu(x)		((s32)__le32_to_cpu((s32)(x)))
-#define sle64_to_cpu(x)		((s64)__le64_to_cpu((s64)(x)))
-
-#define sle16_to_cpup(x)	((s16)__le16_to_cpu(*(s16*)(x)))
-#define sle32_to_cpup(x)	((s32)__le32_to_cpu(*(s32*)(x)))
-#define sle64_to_cpup(x)	((s64)__le64_to_cpu(*(s64*)(x)))
-
-#define cpu_to_sle16(x)		((s16)__cpu_to_le16((s16)(x)))
-#define cpu_to_sle32(x)		((s32)__cpu_to_le32((s32)(x)))
-#define cpu_to_sle64(x)		((s64)__cpu_to_le64((s64)(x)))
-
-#define cpu_to_sle16p(x)	((s16)__cpu_to_le16(*(s16*)(x)))
-#define cpu_to_sle32p(x)	((s32)__cpu_to_le32(*(s32*)(x)))
-#define cpu_to_sle64p(x)	((s64)__cpu_to_le64(*(s64*)(x)))
+
+static inline s16 sle16_to_cpu(sle16 x)
+{
+	return le16_to_cpu((__force le16)x);
+}
+
+static inline s32 sle32_to_cpu(sle32 x)
+{
+	return le32_to_cpu((__force le32)x);
+}
+
+static inline s64 sle64_to_cpu(sle64 x)
+{
+	return le64_to_cpu((__force le64)x);
+}
+
+static inline s16 sle16_to_cpup(sle16 *x)
+{
+	return le16_to_cpu(*(__force le16*)x);
+}
+
+static inline s32 sle32_to_cpup(sle32 *x)
+{
+	return le32_to_cpu(*(__force le32*)x);
+}
+
+static inline s64 sle64_to_cpup(sle64 *x)
+{
+	return le64_to_cpu(*(__force le64*)x);
+}
+
+static inline sle16 cpu_to_sle16(s16 x)
+{
+	return (__force sle16)cpu_to_le16(x);
+}
+
+static inline sle32 cpu_to_sle32(s32 x)
+{
+	return (__force sle32)cpu_to_le32(x);
+}
+
+static inline sle64 cpu_to_sle64(s64 x)
+{
+	return (__force sle64)cpu_to_le64(x);
+}
+
+static inline sle16 cpu_to_sle16p(s16 *x)
+{
+	return (__force sle16)cpu_to_le16(*x);
+}
+
+static inline sle32 cpu_to_sle32p(s32 *x)
+{
+	return (__force sle32)cpu_to_le32(*x);
+}
+
+static inline sle64 cpu_to_sle64p(s64 *x)
+{
+	return (__force sle64)cpu_to_le64(*x);
+}
 
 #endif /* _LINUX_NTFS_ENDIAN_H */
diff -Nru a/fs/ntfs/index.c b/fs/ntfs/index.c
--- a/fs/ntfs/index.c	2004-09-24 17:06:20 +01:00
+++ b/fs/ntfs/index.c	2004-09-24 17:06:20 +01:00
@@ -265,7 +265,7 @@
 		goto err_out;
 	}
 	/* Get the starting vcn of the index_block holding the child node. */
-	vcn = sle64_to_cpup((u8*)ie + le16_to_cpu(ie->length) - 8);
+	vcn = sle64_to_cpup((sle64*)((u8*)ie + le16_to_cpu(ie->length) - 8));
 	ia_mapping = VFS_I(idx_ni)->i_mapping;
 	/*
 	 * We are done with the index root and the mft record.  Release them,
@@ -427,7 +427,7 @@
 	}
 	/* Child node present, descend into it. */
 	old_vcn = vcn;
-	vcn = sle64_to_cpup((u8*)ie + le16_to_cpu(ie->length) - 8);
+	vcn = sle64_to_cpup((sle64*)((u8*)ie + le16_to_cpu(ie->length) - 8));
 	if (vcn >= 0) {
 		/*
 		 * If vcn is in the same page cache page as old_vcn we recycle
diff -Nru a/fs/ntfs/types.h b/fs/ntfs/types.h
--- a/fs/ntfs/types.h	2004-09-24 17:06:20 +01:00
+++ b/fs/ntfs/types.h	2004-09-24 17:06:20 +01:00
@@ -23,8 +23,17 @@
 #ifndef _LINUX_NTFS_TYPES_H
 #define _LINUX_NTFS_TYPES_H
 
+#include <linux/types.h>
+
+typedef __le16 le16;
+typedef __le32 le32;
+typedef __le64 le64;
+typedef __u16 __bitwise sle16;
+typedef __u32 __bitwise sle32;
+typedef __u64 __bitwise sle64;
+
 /* 2-byte Unicode character type. */
-typedef u16 ntfschar;
+typedef le16 ntfschar;
 #define UCHAR_T_SIZE_BITS 1
 
 /*
@@ -32,7 +41,9 @@
  * and VCN, to allow for type checking and better code readability.
  */
 typedef s64 VCN;
+typedef sle64 leVCN;
 typedef s64 LCN;
+typedef sle64 leLCN;
 
 /*
  * The NTFS journal $LogFile uses log sequence numbers which are signed 64-bit
@@ -40,6 +51,7 @@
  * code readability.
  */
 typedef s64 LSN;
+typedef sle64 leLSN;
 
 /**
  * runlist_element - in memory vcn to lcn mapping array element
