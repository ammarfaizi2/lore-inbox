Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261184AbUHWK6E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261184AbUHWK6E (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 06:58:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261875AbUHWK5m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 06:57:42 -0400
Received: from ppsw-3.csi.cam.ac.uk ([131.111.8.133]:6349 "EHLO
	ppsw-3.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S267695AbUHWKdL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 06:33:11 -0400
Date: Mon, 23 Aug 2004 11:33:02 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH 16/20] Re: [2.6-BK-URL] NTFS 2.1.17 release
In-Reply-To: <Pine.LNX.4.60.0408231132240.24220@hermes-1.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.60.0408231132500.24220@hermes-1.csi.cam.ac.uk>
References: <Pine.LNX.4.60.0408231055290.24220@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0408231128020.24220@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0408231128550.24220@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0408231129180.24220@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0408231129370.24220@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0408231129530.24220@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0408231130090.24220@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0408231130240.24220@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0408231130380.24220@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0408231130510.24220@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0408231131070.24220@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0408231131200.24220@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0408231131390.24220@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0408231131520.24220@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0408231132080.24220@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0408231132240.24220@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is patch 16/20 in the series.  It contains the following ChangeSet:

<aia21@cantab.net> (04/08/17 1.1822)
   NTFS: Fix fs/ntfs/lcnalloc.c::ntfs_cluster_alloc() to use LCN_RL_NOT_MAPPED
   rather than LCN_ENOENT as runlist terminator.  Also, make it not create a
   LCN_RL_NOT_MAPPED element at the beginning.
   
   Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/, http://www-stu.christs.cam.ac.uk/~aia21/

===================================================================

diff -Nru a/fs/ntfs/lcnalloc.c b/fs/ntfs/lcnalloc.c
--- a/fs/ntfs/lcnalloc.c	2004-08-18 20:50:37 +01:00
+++ b/fs/ntfs/lcnalloc.c	2004-08-18 20:50:37 +01:00
@@ -167,16 +167,9 @@
 		rl = ntfs_malloc_nofs(PAGE_SIZE);
 		if (!rl)
 			return ERR_PTR(-ENOMEM);
-		rlpos = 0;
-		if (start_vcn) {
-			rl[0].vcn = 0;
-			rl[0].lcn = LCN_RL_NOT_MAPPED;
-			rl[0].length = start_vcn;
-			rlpos++;
-		}
-		rl[rlpos].vcn = start_vcn;
-		rl[rlpos].lcn = LCN_ENOENT;
-		rl[rlpos].length = 0;
+		rl[0].vcn = start_vcn;
+		rl[0].lcn = LCN_RL_NOT_MAPPED;
+		rl[0].length = 0;
 		return rl;
 	}
 	/* Take the lcnbmp lock for writing. */
@@ -405,14 +398,7 @@
 				} else {
 					ntfs_debug("Adding new run, is first "
 							"run.");
-					rl[rlpos].vcn = 0;
-					if (start_vcn) {
-						rl[rlpos].lcn =
-							LCN_RL_NOT_MAPPED;
-						rl[rlpos].length = start_vcn;
-						rlpos++;
-						rl[rlpos].vcn = start_vcn;
-					}
+					rl[rlpos].vcn = start_vcn;
 				}
 				rl[rlpos].lcn = prev_lcn = lcn + bmp_pos;
 				rl[rlpos].length = prev_run_len = 1;
@@ -746,7 +732,7 @@
 	/* Add runlist terminator element. */
 	if (likely(rl)) {
 		rl[rlpos].vcn = rl[rlpos - 1].vcn + rl[rlpos - 1].length;
-		rl[rlpos].lcn = LCN_ENOENT;
+		rl[rlpos].lcn = LCN_RL_NOT_MAPPED;
 		rl[rlpos].length = 0;
 	}
 	if (likely(page && !IS_ERR(page))) {
