Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268383AbUJSJzd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268383AbUJSJzd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 05:55:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268231AbUJSJuI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 05:50:08 -0400
Received: from ppsw-5.csi.cam.ac.uk ([131.111.8.135]:7649 "EHLO
	ppsw-5.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S268100AbUJSJlM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 05:41:12 -0400
Date: Tue, 19 Oct 2004 10:41:03 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-ntfs-dev@lists.sourceforge.net
Subject: [PATCH 9/37] Re: [2.6-BK-URL] NTFS: 2.1.21 - Big update with race/bug
 fixes
In-Reply-To: <Pine.LNX.4.60.0410191040360.24986@hermes-1.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.60.0410191040490.24986@hermes-1.csi.cam.ac.uk>
References: <Pine.LNX.4.60.0410191017070.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191038250.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191038570.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191039140.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191039320.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191039510.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191040050.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191040220.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191040360.24986@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is patch 9/37 in the series.  It contains the following ChangeSet:

<aia21@cantab.net> (04/09/30 1.2005.1.3)
   NTFS: Add fs/ntfs/attrib.[hc]::ntfs_attr_record_resize().
   
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
--- a/fs/ntfs/ChangeLog	2004-10-19 10:13:38 +01:00
+++ b/fs/ntfs/ChangeLog	2004-10-19 10:13:38 +01:00
@@ -35,10 +35,11 @@
 	  ntfs_get_size_for_mapping_pairs(), ntfs_write_significant_bytes(),
 	  and ntfs_mapping_pairs_build(), adapted from libntfs.
 	- Make fs/ntfs/lcnalloc.c::ntfs_cluster_free_from_rl_nolock() not
-	  static, add a declaration for it to lcnalloc.h.
+	  static and add a declaration for it to lcnalloc.h.
 	- Add fs/ntfs/lcnalloc.h::ntfs_cluster_free_from_rl() which is a static
 	  inline wrapper for ntfs_cluster_free_from_rl_nolock() which takes the
 	  cluster bitmap lock for the duration of the call.
+	- Add fs/ntfs/attrib.[hc]::ntfs_attr_record_resize().
 
 2.1.19 - Many cleanups, improvements, and a minor bug fix.
 
diff -Nru a/fs/ntfs/attrib.c b/fs/ntfs/attrib.c
--- a/fs/ntfs/attrib.c	2004-10-19 10:13:38 +01:00
+++ b/fs/ntfs/attrib.c	2004-10-19 10:13:38 +01:00
@@ -942,3 +942,47 @@
 	kmem_cache_free(ntfs_attr_ctx_cache, ctx);
 	return;
 }
+
+/**
+ * ntfs_attr_record_resize - resize an attribute record
+ * @m:		mft record containing attribute record
+ * @a:		attribute record to resize
+ * @new_size:	new size in bytes to which to resize the attribute record @a
+ *
+ * Resize the attribute record @a, i.e. the resident part of the attribute, in
+ * the mft record @m to @new_size bytes.
+ *
+ * Return 0 on success and -errno on error.  The following error codes are
+ * defined:
+ *	-ENOSPC	- Not enough space in the mft record @m to perform the resize.
+ *
+ * Note: On error, no modifications have been performed whatsoever.
+ *
+ * Warning: If you make a record smaller without having copied all the data you
+ *	    are interested in the data may be overwritten.
+ */
+int ntfs_attr_record_resize(MFT_RECORD *m, ATTR_RECORD *a, u32 new_size)
+{
+	ntfs_debug("Entering for new_size %u.", new_size);
+	/* Align to 8 bytes if it is not already done. */
+	if (new_size & 7)
+		new_size = (new_size + 7) & ~7;
+	/* If the actual attribute length has changed, move things around. */
+	if (new_size != le32_to_cpu(a->length)) {
+		u32 new_muse = le32_to_cpu(m->bytes_in_use) -
+				le32_to_cpu(a->length) + new_size;
+		/* Not enough space in this mft record. */
+		if (new_muse > le32_to_cpu(m->bytes_allocated))
+			return -ENOSPC;
+		/* Move attributes following @a to their new location. */
+		memmove((u8*)a + new_size, (u8*)a + le32_to_cpu(a->length),
+				le32_to_cpu(m->bytes_in_use) - ((u8*)a -
+				(u8*)m) - le32_to_cpu(a->length));
+		/* Adjust @m to reflect the change in used space. */
+		m->bytes_in_use = cpu_to_le32(new_muse);
+		/* Adjust @a to reflect the new size. */
+		if (new_size >= offsetof(ATTR_REC, length) + sizeof(a->length))
+			a->length = cpu_to_le32(new_size);
+	}
+	return 0;
+}
diff -Nru a/fs/ntfs/attrib.h b/fs/ntfs/attrib.h
--- a/fs/ntfs/attrib.h	2004-10-19 10:13:38 +01:00
+++ b/fs/ntfs/attrib.h	2004-10-19 10:13:38 +01:00
@@ -84,4 +84,6 @@
 		MFT_RECORD *mrec);
 extern void ntfs_attr_put_search_ctx(ntfs_attr_search_ctx *ctx);
 
+extern int ntfs_attr_record_resize(MFT_RECORD *m, ATTR_RECORD *a, u32 new_size);
+
 #endif /* _LINUX_NTFS_ATTRIB_H */
