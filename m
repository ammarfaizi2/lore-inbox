Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268182AbUJSKQ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268182AbUJSKQ3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 06:16:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269381AbUJSKPb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 06:15:31 -0400
Received: from ppsw-4.csi.cam.ac.uk ([131.111.8.134]:65258 "EHLO
	ppsw-4.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S268185AbUJSJpm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 05:45:42 -0400
Date: Tue, 19 Oct 2004 10:45:38 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-ntfs-dev@lists.sourceforge.net
Subject: [PATCH 28/37] Re: [2.6-BK-URL] NTFS: 2.1.21 - Big update with race/bug
 fixes
In-Reply-To: <Pine.LNX.4.60.0410191045100.24986@hermes-1.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.60.0410191045250.24986@hermes-1.csi.cam.ac.uk>
References: <Pine.LNX.4.60.0410191017070.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191041420.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191041590.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191042200.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191042320.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191042440.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191042560.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191043100.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191043240.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191043370.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191043500.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191044130.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191044280.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191044420.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191044560.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191045100.24986@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is patch 28/37 in the series.  It contains the following ChangeSet:

<aia21@cantab.net> (04/10/14 1.2047)
   NTFS: - Fix two race conditions in fs/ntfs/inode.c::ntfs_put_inode().
   
   - Fix race condition in fs/ntfs/inode.c::ntfs_put_inode() by moving the
     index inode bitmap inode release code from there to
     fs/ntfs/inode.c::ntfs_clear_big_inode().  (Thanks to Christoph
     Hellwig for spotting this.)
   - Fix race condition in fs/ntfs/inode.c::ntfs_put_inode() by taking the
     inode semaphore around the code thst sets ni->itype.index.bmp_ino to
     NULL and reorganize the code to optimize it a bit.  (Thanks to
     Christoph Hellwig for spotting this.)
   
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
--- a/fs/ntfs/ChangeLog	2004-10-19 10:14:47 +01:00
+++ b/fs/ntfs/ChangeLog	2004-10-19 10:14:47 +01:00
@@ -110,6 +110,14 @@
 	- Fix callers of fs/ntfs/aops.c::mark_ntfs_record_dirty() to call it
 	  with the ntfs inode which contains the page rather than the ntfs
 	  inode the mft record of which is in the page.
+	- Fix race condition in fs/ntfs/inode.c::ntfs_put_inode() by moving the
+	  index inode bitmap inode release code from there to
+	  fs/ntfs/inode.c::ntfs_clear_big_inode().  (Thanks to Christoph
+	  Hellwig for spotting this.)
+	- Fix race condition in fs/ntfs/inode.c::ntfs_put_inode() by taking the
+	  inode semaphore around the code thst sets ni->itype.index.bmp_ino to
+	  NULL and reorganize the code to optimize it a bit.  (Thanks to
+	  Christoph Hellwig for spotting this.)
 
 2.1.20 - Fix two stupid bugs introduced in 2.1.18 release.
 
diff -Nru a/fs/ntfs/inode.c b/fs/ntfs/inode.c
--- a/fs/ntfs/inode.c	2004-10-19 10:14:47 +01:00
+++ b/fs/ntfs/inode.c	2004-10-19 10:14:47 +01:00
@@ -2095,37 +2095,24 @@
  * dropped, we need to put the attribute inode for the directory index bitmap,
  * if it is present, otherwise the directory inode would remain pinned for
  * ever.
- *
- * If the inode @vi is an index inode with only one reference which is being
- * dropped, we need to put the attribute inode for the index bitmap, if it is
- * present, otherwise the index inode would disappear and the attribute inode
- * for the index bitmap would no longer be referenced from anywhere and thus it
- * would remain pinned for ever.
  */
 void ntfs_put_inode(struct inode *vi)
 {
-	ntfs_inode *ni;
-
-	if (S_ISDIR(vi->i_mode)) {
-		if (atomic_read(&vi->i_count) == 2) {
-			ni = NTFS_I(vi);
-			if (NInoIndexAllocPresent(ni) &&
-					ni->itype.index.bmp_ino) {
-				iput(ni->itype.index.bmp_ino);
-				ni->itype.index.bmp_ino = NULL;
+	if (S_ISDIR(vi->i_mode) && atomic_read(&vi->i_count) == 2) {
+		ntfs_inode *ni = NTFS_I(vi);
+		if (NInoIndexAllocPresent(ni)) {
+			struct inode *bvi = NULL;
+			down(&vi->i_sem);
+			if (atomic_read(&vi->i_count) == 2) {
+				bvi = ni->itype.index.bmp_ino;
+				if (bvi)
+					ni->itype.index.bmp_ino = NULL;
 			}
+			up(&vi->i_sem);
+			if (bvi)
+				iput(bvi);
 		}
-		return;
-	}
-	if (atomic_read(&vi->i_count) != 1)
-		return;
-	ni = NTFS_I(vi);
-	if (NInoAttr(ni) && (ni->type == AT_INDEX_ALLOCATION) &&
-			NInoIndexAllocPresent(ni) && ni->itype.index.bmp_ino) {
-		iput(ni->itype.index.bmp_ino);
-		ni->itype.index.bmp_ino = NULL;
 	}
-	return;
 }
 
 void __ntfs_clear_inode(ntfs_inode *ni)
@@ -2193,6 +2180,18 @@
 {
 	ntfs_inode *ni = NTFS_I(vi);
 
+	/*
+	 * If the inode @vi is an index inode we need to put the attribute
+	 * inode for the index bitmap, if it is present, otherwise the index
+	 * inode would disappear and the attribute inode for the index bitmap
+	 * would no longer be referenced from anywhere and thus it would remain
+	 * pinned for ever.
+	 */
+	if (NInoAttr(ni) && (ni->type == AT_INDEX_ALLOCATION) &&
+			NInoIndexAllocPresent(ni) && ni->itype.index.bmp_ino) {
+		iput(ni->itype.index.bmp_ino);
+		ni->itype.index.bmp_ino = NULL;
+	}
 #ifdef NTFS_RW
 	if (NInoDirty(ni)) {
 		BOOL was_bad = (is_bad_inode(vi));
