Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261857AbUKJNpM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261857AbUKJNpM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 08:45:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261909AbUKJNpM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 08:45:12 -0500
Received: from ppsw-5.csi.cam.ac.uk ([131.111.8.135]:21889 "EHLO
	ppsw-5.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S261857AbUKJNoY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 08:44:24 -0500
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-ntfs-dev@lists.sourceforge.net
Subject: [PATCH 2/26] NTFS 2.1.22 - Bug and race fixes and improved error handling.
Message-Id: <E1CRslk-0006MW-SV@imp.csi.cam.ac.uk>
Date: Wed, 10 Nov 2004 13:44:16 +0000
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is patch 2/26 in the series.  It contains the following ChangeSet:

<aia21@cantab.net> (04/10/21 1.2000.1.13)
   NTFS: Improve error handling in fs/ntfs/inode.c::ntfs_truncate().
   
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
--- a/fs/ntfs/ChangeLog	2004-11-10 13:44:20 +00:00
+++ b/fs/ntfs/ChangeLog	2004-11-10 13:44:20 +00:00
@@ -21,6 +21,10 @@
 	- Enable the code for setting the NT4 compatibility flag when we start
 	  making NTFS 1.2 specific modifications.
 
+2.1.22-WIP
+
+	- Improve error handling in fs/ntfs/inode.c::ntfs_truncate().
+
 2.1.21 - Fix some races and bugs, rewrite mft write code, add mft allocator.
 
 	- Implement extent mft record deallocation
diff -Nru a/fs/ntfs/Makefile b/fs/ntfs/Makefile
--- a/fs/ntfs/Makefile	2004-11-10 13:44:20 +00:00
+++ b/fs/ntfs/Makefile	2004-11-10 13:44:20 +00:00
@@ -6,7 +6,7 @@
 	     index.o inode.o mft.o mst.o namei.o runlist.o super.o sysctl.o \
 	     unistr.o upcase.o
 
-EXTRA_CFLAGS = -DNTFS_VERSION=\"2.1.21\"
+EXTRA_CFLAGS = -DNTFS_VERSION=\"2.1.22-WIP\"
 
 ifeq ($(CONFIG_NTFS_DEBUG),y)
 EXTRA_CFLAGS += -DDEBUG
diff -Nru a/fs/ntfs/inode.c b/fs/ntfs/inode.c
--- a/fs/ntfs/inode.c	2004-11-10 13:44:20 +00:00
+++ b/fs/ntfs/inode.c	2004-11-10 13:44:20 +00:00
@@ -2272,58 +2272,67 @@
 void ntfs_truncate(struct inode *vi)
 {
 	ntfs_inode *ni = NTFS_I(vi);
+	ntfs_volume *vol = ni->vol;
 	ntfs_attr_search_ctx *ctx;
 	MFT_RECORD *m;
+	const char *te = "  Leaving file length out of sync with i_size.";
 	int err;
 
+	ntfs_debug("Entering for inode 0x%lx.", vi->i_ino);
 	BUG_ON(NInoAttr(ni));
 	BUG_ON(ni->nr_extents < 0);
 	m = map_mft_record(ni);
 	if (IS_ERR(m)) {
+		err = PTR_ERR(m);
 		ntfs_error(vi->i_sb, "Failed to map mft record for inode 0x%lx "
-				"(error code %ld).", vi->i_ino, PTR_ERR(m));
-		if (PTR_ERR(m) != ENOMEM)
-			make_bad_inode(vi);
-		return;
+				"(error code %d).%s", vi->i_ino, err, te);
+		ctx = NULL;
+		m = NULL;
+		goto err_out;
 	}
 	ctx = ntfs_attr_get_search_ctx(ni, m);
 	if (unlikely(!ctx)) {
-		ntfs_error(vi->i_sb, "Failed to allocate a search context: "
-				"Not enough memory");
-		// FIXME: We can't report an error code upstream.  So what do
-		// we do?!?  make_bad_inode() seems a bit harsh...
-		unmap_mft_record(ni);
-		return;
+		ntfs_error(vi->i_sb, "Failed to allocate a search context for "
+				"inode 0x%lx (not enough memory).%s",
+				vi->i_ino, te);
+		err = -ENOMEM;
+		goto err_out;
 	}
 	err = ntfs_attr_lookup(ni->type, ni->name, ni->name_len,
 			CASE_SENSITIVE, 0, NULL, 0, ctx);
 	if (unlikely(err)) {
-		if (err == -ENOENT) {
+		if (err == -ENOENT)
 			ntfs_error(vi->i_sb, "Open attribute is missing from "
 					"mft record.  Inode 0x%lx is corrupt.  "
 					"Run chkdsk.", vi->i_ino);
-			make_bad_inode(vi);
-		} else {
+		else
 			ntfs_error(vi->i_sb, "Failed to lookup attribute in "
 					"inode 0x%lx (error code %d).",
 					vi->i_ino, err);
-			// FIXME: We can't report an error code upstream.  So
-			// what do we do?!?  make_bad_inode() seems a bit
-			// harsh...
-		}
-		goto out;
+		goto err_out;
 	}
 	/* If the size has not changed there is nothing to do. */
 	if (ntfs_attr_size(ctx->attr) == i_size_read(vi))
-		goto out;
+		goto done;
 	// TODO: Implement the truncate...
 	ntfs_error(vi->i_sb, "Inode size has changed but this is not "
 			"implemented yet.  Resetting inode size to old value. "
 			" This is most likely a bug in the ntfs driver!");
 	i_size_write(vi, ntfs_attr_size(ctx->attr)); 
-out:
+done:
 	ntfs_attr_put_search_ctx(ctx);
 	unmap_mft_record(ni);
+	ntfs_debug("Done.");
+	return;
+err_out:
+	if (err != -ENOMEM) {
+		NVolSetErrors(vol);
+		make_bad_inode(vi);
+	}
+	if (ctx)
+		ntfs_attr_put_search_ctx(ctx);
+	if (m)
+		unmap_mft_record(ni);
 	return;
 }
 
