Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268915AbUIXQSG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268915AbUIXQSG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 12:18:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268907AbUIXQQs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 12:16:48 -0400
Received: from ppsw-6.csi.cam.ac.uk ([131.111.8.136]:38857 "EHLO
	ppsw-6.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S268851AbUIXQNk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 12:13:40 -0400
Date: Fri, 24 Sep 2004 17:13:36 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
cc: viro@parcelfarce.linux.theplanet.co.uk, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net
Subject: [PATCH 5/10] Re: [2.6-BK-URL] NTFS: 2.1.19 sparse annotation, cleanups
 and a bugfix
In-Reply-To: <Pine.LNX.4.60.0409241713070.19983@hermes-1.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.60.0409241713220.19983@hermes-1.csi.cam.ac.uk>
References: <Pine.LNX.4.60.0409241707370.19983@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0409241711400.19983@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0409241712320.19983@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0409241712490.19983@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0409241713070.19983@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is patch 5/10 in the series.  It contains the following ChangeSet:

<aia21@cantab.net> (04/09/23 1.1952)
   NTFS: - Update ->truncate (fs/ntfs/inode.c::ntfs_truncate()) to check if the
           inode size has changed and to only output an error if so.
         - Rename fs/ntfs/attrib.h::attribute_value_length() to ntfs_attr_size().
   
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
--- a/fs/ntfs/ChangeLog	2004-09-24 17:06:16 +01:00
+++ b/fs/ntfs/ChangeLog	2004-09-24 17:06:16 +01:00
@@ -31,6 +31,9 @@
 	- Get rid of the ugly transparent union in fs/ntfs/dir.c::ntfs_readdir()
 	  and ntfs_filldir() as per suggestion from Al Viro.
 	- Change '\0' and L'\0' to simply 0 as per advice from Linus Torvalds.
+	- Update ->truncate (fs/ntfs/inode.c::ntfs_truncate()) to check if the
+	  inode size has changed and to only output an error if so.
+	- Rename fs/ntfs/attrib.h::attribute_value_length() to ntfs_attr_size().
 
 2.1.18 - Fix scheduling latencies at mount time as well as an endianness bug.
 
diff -Nru a/fs/ntfs/attrib.h b/fs/ntfs/attrib.h
--- a/fs/ntfs/attrib.h	2004-09-24 17:06:16 +01:00
+++ b/fs/ntfs/attrib.h	2004-09-24 17:06:16 +01:00
@@ -89,7 +89,7 @@
 extern int load_attribute_list(ntfs_volume *vol, runlist *rl, u8 *al_start,
 		const s64 size, const s64 initialized_size);
 
-static inline s64 attribute_value_length(const ATTR_RECORD *a)
+static inline s64 ntfs_attr_size(const ATTR_RECORD *a)
 {
 	if (!a->non_resident)
 		return (s64)le32_to_cpu(a->data.resident.value_length);
diff -Nru a/fs/ntfs/inode.c b/fs/ntfs/inode.c
--- a/fs/ntfs/inode.c	2004-09-24 17:06:16 +01:00
+++ b/fs/ntfs/inode.c	2004-09-24 17:06:16 +01:00
@@ -680,7 +680,7 @@
 			goto unm_err_out;
 		}
 		/* Now allocate memory for the attribute list. */
-		ni->attr_list_size = (u32)attribute_value_length(ctx->attr);
+		ni->attr_list_size = (u32)ntfs_attr_size(ctx->attr);
 		ni->attr_list = ntfs_malloc_nofs(ni->attr_list_size);
 		if (!ni->attr_list) {
 			ntfs_error(vi->i_sb, "Not enough memory to allocate "
@@ -1794,7 +1794,7 @@
 			goto put_err_out;
 		}
 		/* Now allocate memory for the attribute list. */
-		ni->attr_list_size = (u32)attribute_value_length(ctx->attr);
+		ni->attr_list_size = (u32)ntfs_attr_size(ctx->attr);
 		ni->attr_list = ntfs_malloc_nofs(ni->attr_list_size);
 		if (!ni->attr_list) {
 			ntfs_error(sb, "Not enough memory to allocate buffer "
@@ -2284,12 +2284,38 @@
  */
 void ntfs_truncate(struct inode *vi)
 {
-	// TODO: Implement...
-	ntfs_warning(vi->i_sb, "Eeek: i_size may have changed!  If you see "
-			"this right after a message from "
-			"ntfs_prepare_{,nonresident_}write() then just ignore "
-			"it.  Otherwise it is bad news.");
-	// TODO: reset i_size now!
+	ntfs_inode *ni = NTFS_I(vi);
+	ntfs_attr_search_ctx *ctx;
+	MFT_RECORD *m;
+
+	m = map_mft_record(ni);
+	if (IS_ERR(m)) {
+		ntfs_error(vi->i_sb, "Failed to map mft record for inode 0x%lx "
+				"(error code %ld).", vi->i_ino, PTR_ERR(m));
+		if (PTR_ERR(m) != ENOMEM)
+			make_bad_inode(vi);
+		return;
+	}
+	ctx = ntfs_attr_get_search_ctx(ni, m);
+	if (unlikely(!ctx)) {
+		ntfs_error(vi->i_sb, "Failed to allocate a search context: "
+				"Not enough memory");
+		// FIXME: We can't report an error code upstream.  So what do
+		// we do?!?  make_bad_inode() seems a bit harsh...
+		unmap_mft_record(ni);
+		goto out;
+	}
+	/* If the size has not changed there is nothing to do. */
+	if (ntfs_attr_size(ctx->attr) == i_size_read(vi))
+		goto out;
+	// TODO: Implement the truncate...
+	ntfs_error(vi->i_sb, "Inode size has changed but this is not "
+			"implemented yet.  Resetting inode size to old value. "
+			" This is most likely a bug in the ntfs driver!");
+	i_size_write(vi, ntfs_attr_size(ctx->attr)); 
+out:
+	ntfs_attr_put_search_ctx(ctx);
+	unmap_mft_record(ni);
 	return;
 }
 
