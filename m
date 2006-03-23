Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932223AbWCWR0s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932223AbWCWR0s (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 12:26:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932421AbWCWR0r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 12:26:47 -0500
Received: from ppsw-7.csi.cam.ac.uk ([131.111.8.137]:21443 "EHLO
	ppsw-7.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S932223AbWCWR0q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 12:26:46 -0500
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Date: Thu, 23 Mar 2006 17:26:23 +0000 (GMT)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net
Subject: [PATCH 08/14] NTFS: Limit name length in fs/ntfs/unistr.c::ntfs_nlstoucs()
 to maximum allowed by NTFS
In-Reply-To: <Pine.LNX.4.64.0603231724570.18984@hermes-2.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.64.0603231725420.18984@hermes-2.csi.cam.ac.uk>
References: <Pine.LNX.4.64.0603231713430.18984@hermes-2.csi.cam.ac.uk>
 <Pine.LNX.4.64.0603231717460.18984@hermes-2.csi.cam.ac.uk>
 <Pine.LNX.4.64.0603231720130.18984@hermes-2.csi.cam.ac.uk>
 <Pine.LNX.4.64.0603231721240.18984@hermes-2.csi.cam.ac.uk>
 <Pine.LNX.4.64.0603231722330.18984@hermes-2.csi.cam.ac.uk>
 <Pine.LNX.4.64.0603231723320.18984@hermes-2.csi.cam.ac.uk>
 <Pine.LNX.4.64.0603231724200.18984@hermes-2.csi.cam.ac.uk>
 <Pine.LNX.4.64.0603231724570.18984@hermes-2.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

NTFS: Limit name length in fs/ntfs/unistr.c::ntfs_nlstoucs() to maximum
      allowed by NTFS, i.e. 255 Unicode characters, not including the
      terminating NULL (which is not stored on disk).

Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

---

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

 fs/ntfs/ChangeLog |    3 +++
 fs/ntfs/unistr.c  |   51 ++++++++++++++++++++++++++++++++-------------------
 2 files changed, 35 insertions(+), 19 deletions(-)

d4faf636d6f8d8940174e38317161eb08a7a57ec
diff --git a/fs/ntfs/ChangeLog b/fs/ntfs/ChangeLog
index 13e70d4..41d0381 100644
--- a/fs/ntfs/ChangeLog
+++ b/fs/ntfs/ChangeLog
@@ -34,6 +34,9 @@ ToDo/Notes:
 	- Add support for sparse files which have a compression unit of 0.
 	- Remove all the make_bad_inode() calls.  This should only be called
 	  from read inode and new inode code paths.
+	- Limit name length in fs/ntfs/unistr.c::ntfs_nlstoucs() to maximum
+	  allowed by NTFS, i.e. 255 Unicode characters, not including the
+	  terminating NULL (which is not stored on disk).
 
 2.1.26 - Minor bug fixes and updates.
 
diff --git a/fs/ntfs/unistr.c b/fs/ntfs/unistr.c
index 0ea887f..b123c0f 100644
--- a/fs/ntfs/unistr.c
+++ b/fs/ntfs/unistr.c
@@ -1,7 +1,7 @@
 /*
  * unistr.c - NTFS Unicode string handling. Part of the Linux-NTFS project.
  *
- * Copyright (c) 2001-2005 Anton Altaparmakov
+ * Copyright (c) 2001-2006 Anton Altaparmakov
  *
  * This program/include file is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License as published
@@ -19,6 +19,8 @@
  * Foundation,Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 
+#include <linux/slab.h>
+
 #include "types.h"
 #include "debug.h"
 #include "ntfs.h"
@@ -242,7 +244,7 @@ int ntfs_file_compare_values(FILE_NAME_A
  * map dictates, into a little endian, 2-byte Unicode string.
  *
  * This function allocates the string and the caller is responsible for
- * calling kmem_cache_free(ntfs_name_cache, @outs); when finished with it.
+ * calling kmem_cache_free(ntfs_name_cache, *@outs); when finished with it.
  *
  * On success the function returns the number of Unicode characters written to
  * the output string *@outs (>= 0), not counting the terminating Unicode NULL
@@ -262,37 +264,48 @@ int ntfs_nlstoucs(const ntfs_volume *vol
 	wchar_t wc;
 	int i, o, wc_len;
 
-	/* We don't trust outside sources. */
-	if (ins) {
+	/* We do not trust outside sources. */
+	if (likely(ins)) {
 		ucs = kmem_cache_alloc(ntfs_name_cache, SLAB_NOFS);
-		if (ucs) {
+		if (likely(ucs)) {
 			for (i = o = 0; i < ins_len; i += wc_len) {
 				wc_len = nls->char2uni(ins + i, ins_len - i,
 						&wc);
-				if (wc_len >= 0) {
-					if (wc) {
+				if (likely(wc_len >= 0 &&
+						o < NTFS_MAX_NAME_LEN)) {
+					if (likely(wc)) {
 						ucs[o++] = cpu_to_le16(wc);
 						continue;
-					} /* else (!wc) */
+					} /* else if (!wc) */
 					break;
-				} /* else (wc_len < 0) */
-				goto conversion_err;
+				} /* else if (wc_len < 0 ||
+						o >= NTFS_MAX_NAME_LEN) */
+				goto name_err;
 			}
 			ucs[o] = 0;
 			*outs = ucs;
 			return o;
-		} /* else (!ucs) */
-		ntfs_error(vol->sb, "Failed to allocate name from "
-				"ntfs_name_cache!");
+		} /* else if (!ucs) */
+		ntfs_error(vol->sb, "Failed to allocate buffer for converted "
+				"name from ntfs_name_cache.");
 		return -ENOMEM;
-	} /* else (!ins) */
-	ntfs_error(NULL, "Received NULL pointer.");
+	} /* else if (!ins) */
+	ntfs_error(vol->sb, "Received NULL pointer.");
 	return -EINVAL;
-conversion_err:
-	ntfs_error(vol->sb, "Name using character set %s contains characters "
-			"that cannot be converted to Unicode.", nls->charset);
+name_err:
 	kmem_cache_free(ntfs_name_cache, ucs);
-	return -EILSEQ;
+	if (wc_len < 0) {
+		ntfs_error(vol->sb, "Name using character set %s contains "
+				"characters that cannot be converted to "
+				"Unicode.", nls->charset);
+		i = -EILSEQ;
+	} else /* if (o >= NTFS_MAX_NAME_LEN) */ {
+		ntfs_error(vol->sb, "Name is too long (maximum length for a "
+				"name on NTFS is %d Unicode characters.",
+				NTFS_MAX_NAME_LEN);
+		i = -ENAMETOOLONG;
+	}
+	return i;
 }
 
 /**
-- 
1.2.3.g9821

