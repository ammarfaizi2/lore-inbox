Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268229AbUJSJsz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268229AbUJSJsz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 05:48:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268203AbUJSJqK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 05:46:10 -0400
Received: from ppsw-8.csi.cam.ac.uk ([131.111.8.138]:11204 "EHLO
	ppsw-8.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S268120AbUJSJkF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 05:40:05 -0400
Date: Tue, 19 Oct 2004 10:40:02 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-ntfs-dev@lists.sourceforge.net
Subject: [PATCH 5/37] Re: [2.6-BK-URL] NTFS: 2.1.21 - Big update with race/bug
 fixes
In-Reply-To: <Pine.LNX.4.60.0410191039320.24986@hermes-1.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.60.0410191039510.24986@hermes-1.csi.cam.ac.uk>
References: <Pine.LNX.4.60.0410191017070.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191038250.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191038570.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191039140.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191039320.24986@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is patch 5/37 in the series.  It contains the following ChangeSet:

<aia21@cantab.net> (04/09/30 1.2004)
   NTFS: Forgot to lock the mft bitmap when clearing the bit in
         ntfs_extent_mft_record_free().
   
   Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/, http://www-stu.christs.cam.ac.uk/~aia21/

===================================================================

diff -Nru a/fs/ntfs/mft.c b/fs/ntfs/mft.c
--- a/fs/ntfs/mft.c	2004-10-19 10:13:23 +01:00
+++ b/fs/ntfs/mft.c	2004-10-19 10:13:23 +01:00
@@ -1210,7 +1210,9 @@
 	ntfs_clear_extent_inode(ni);
 
 	/* Clear the bit in the $MFT/$BITMAP corresponding to this record. */
+	down_write(&vol->mftbmp_lock);
 	err = ntfs_bitmap_clear_bit(vol->mftbmp_ino, mft_no);
+	up_write(&vol->mftbmp_lock);
 	if (unlikely(err)) {
 		/*
 		 * The extent inode is gone but we failed to deallocate it in
diff -Nru a/fs/ntfs/mft.h b/fs/ntfs/mft.h
--- a/fs/ntfs/mft.h	2004-10-19 10:13:23 +01:00
+++ b/fs/ntfs/mft.h	2004-10-19 10:13:23 +01:00
@@ -27,8 +27,6 @@
 
 #include "inode.h"
 
-extern int format_mft_record(ntfs_inode *ni, MFT_RECORD *m);
-
 extern MFT_RECORD *map_mft_record(ntfs_inode *ni);
 extern void unmap_mft_record(ntfs_inode *ni);
 
