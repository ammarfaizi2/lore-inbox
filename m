Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268978AbUIXQkh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268978AbUIXQkh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 12:40:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268911AbUIXQhO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 12:37:14 -0400
Received: from ppsw-5.csi.cam.ac.uk ([131.111.8.135]:25515 "EHLO
	ppsw-5.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S268900AbUIXQP7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 12:15:59 -0400
Date: Fri, 24 Sep 2004 17:15:50 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
cc: viro@parcelfarce.linux.theplanet.co.uk, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net
Subject: [PATCH 10/10] Re: [2.6-BK-URL] NTFS: 2.1.19 sparse annotation,
 cleanups and a bugfix
In-Reply-To: <Pine.LNX.4.60.0409241714520.19983@hermes-1.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.60.0409241715170.19983@hermes-1.csi.cam.ac.uk>
References: <Pine.LNX.4.60.0409241707370.19983@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0409241711400.19983@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0409241712320.19983@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0409241712490.19983@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0409241713070.19983@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0409241713220.19983@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0409241713380.19983@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0409241713540.19983@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0409241714190.19983@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0409241714520.19983@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is patch 10/10 in the series.  It contains the following ChangeSet:

<aia21@cantab.net> (04/09/24 1.1956)
   NTFS: Fix a stupid bug where I forgot to actually do the attribute lookup
         and then went and used the looked up attribute...  Ooops.
   
   Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/, http://www-stu.christs.cam.ac.uk/~aia21/

===================================================================

diff -Nru a/fs/ntfs/inode.c b/fs/ntfs/inode.c
--- a/fs/ntfs/inode.c	2004-09-24 17:06:34 +01:00
+++ b/fs/ntfs/inode.c	2004-09-24 17:06:34 +01:00
@@ -2287,6 +2287,7 @@
 	ntfs_inode *ni = NTFS_I(vi);
 	ntfs_attr_search_ctx *ctx;
 	MFT_RECORD *m;
+	int err;
 
 	m = map_mft_record(ni);
 	if (IS_ERR(m)) {
@@ -2303,6 +2304,24 @@
 		// FIXME: We can't report an error code upstream.  So what do
 		// we do?!?  make_bad_inode() seems a bit harsh...
 		unmap_mft_record(ni);
+		return;
+	}
+	err = ntfs_attr_lookup(ni->type, ni->name, ni->name_len,
+			CASE_SENSITIVE, 0, NULL, 0, ctx);
+	if (unlikely(err)) {
+		if (err == -ENOENT) {
+			ntfs_error(vi->i_sb, "Open attribute is missing from "
+					"mft record.  Inode 0x%lx is corrupt.  "
+					"Run chkdsk.", vi->i_ino);
+			make_bad_inode(vi);
+		} else {
+			ntfs_error(vi->i_sb, "Failed to lookup attribute in "
+					"inode 0x%lx (error code %d).",
+					vi->i_ino, err);
+			// FIXME: We can't report an error code upstream.  So
+			// what do we do?!?  make_bad_inode() seems a bit
+			// harsh...
+		}
 		goto out;
 	}
 	/* If the size has not changed there is nothing to do. */
