Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261875AbUHWK6E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261875AbUHWK6E (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 06:58:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261375AbUHWK5F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 06:57:05 -0400
Received: from ppsw-8.csi.cam.ac.uk ([131.111.8.138]:52616 "EHLO
	ppsw-8.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S267690AbUHWKcy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 06:32:54 -0400
Date: Mon, 23 Aug 2004 11:32:46 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH 15/20] Re: [2.6-BK-URL] NTFS 2.1.17 release
In-Reply-To: <Pine.LNX.4.60.0408231132080.24220@hermes-1.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.60.0408231132240.24220@hermes-1.csi.cam.ac.uk>
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
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is patch 15/20 in the series.  It contains the following ChangeSet:

<aia21@cantab.net> (04/08/17 1.1821)
   NTFS: Minor update to fs/ntfs/bitmap.c to only perform rollback if at
   least one bit has actually been changed.
   
   Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/, http://www-stu.christs.cam.ac.uk/~aia21/

===================================================================

diff -Nru a/fs/ntfs/bitmap.c b/fs/ntfs/bitmap.c
--- a/fs/ntfs/bitmap.c	2004-08-18 20:50:34 +01:00
+++ b/fs/ntfs/bitmap.c	2004-08-18 20:50:34 +01:00
@@ -115,7 +115,7 @@
 		len += pos;
 
 	/* If we are not in the last page, deal with all subsequent pages. */
-	while (end_index > index) {
+	while (index < end_index) {
 		BUG_ON(cnt <= 0);
 
 		/* Update @index and get the next page. */
@@ -168,8 +168,11 @@
 	 */
 	if (is_rollback)
 		return PTR_ERR(page);
-	pos = __ntfs_bitmap_set_bits_in_run(vi, start_bit, count - cnt,
-			value ? 0 : 1, TRUE);
+	if (count != cnt)
+		pos = __ntfs_bitmap_set_bits_in_run(vi, start_bit, count - cnt,
+				value ? 0 : 1, TRUE);
+	else
+		pos = 0;
 	if (!pos) {
 		/* Rollback was successful. */
 		ntfs_error(vi->i_sb, "Failed to map subsequent page (error "
