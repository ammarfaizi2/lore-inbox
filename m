Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268892AbUIXQPC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268892AbUIXQPC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 12:15:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268900AbUIXQO5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 12:14:57 -0400
Received: from ppsw-5.csi.cam.ac.uk ([131.111.8.135]:48807 "EHLO
	ppsw-5.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S268892AbUIXQNM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 12:13:12 -0400
Date: Fri, 24 Sep 2004 17:13:04 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
cc: viro@parcelfarce.linux.theplanet.co.uk, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net
Subject: [PATCH 3/10] Re: [2.6-BK-URL] NTFS: 2.1.19 sparse annotation, cleanups
 and a bugfix
In-Reply-To: <Pine.LNX.4.60.0409241712320.19983@hermes-1.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.60.0409241712490.19983@hermes-1.csi.cam.ac.uk>
References: <Pine.LNX.4.60.0409241707370.19983@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0409241711400.19983@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0409241712320.19983@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is patch 3/10 in the series.  It contains the following ChangeSet:

<aia21@cantab.net> (04/09/22 1.1949)
   NTFS: Improve the previous transparent union removal.
   
   Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/, http://www-stu.christs.cam.ac.uk/~aia21/

===================================================================

diff -Nru a/fs/ntfs/dir.c b/fs/ntfs/dir.c
--- a/fs/ntfs/dir.c	2004-09-24 17:06:09 +01:00
+++ b/fs/ntfs/dir.c	2004-09-24 17:06:09 +01:00
@@ -1013,9 +1013,8 @@
  * Convert the Unicode @name to the loaded NLS and pass it to the @filldir
  * callback.
  *
- * If @index_type is INDEX_TYPE_ALLOCATION, @ia_page is the locked page
- * containing the index allocation block containing the index entry @ie.
- * Otherwise, @ia_page is NULL.
+ * If @ia_page is not NULL it is the locked page containing the index
+ * allocation block containing the index entry @ie.
  *
  * Note, we drop (and then reacquire) the page lock on @ia_page across the
  * @filldir() call otherwise we would deadlock with NFSd when it calls ->lookup
@@ -1023,7 +1022,7 @@
  * retake the lock if we are returning a non-zero value as ntfs_readdir()
  * would need to drop the lock immediately anyway.
  */
-static inline int ntfs_filldir(ntfs_volume *vol, loff_t *fpos,
+static inline int ntfs_filldir(ntfs_volume *vol, loff_t fpos,
 		ntfs_inode *ndir, struct page *ia_page, INDEX_ENTRY *ie,
 		u8 *name, void *dirent, filldir_t filldir)
 {
@@ -1066,9 +1065,9 @@
 	if (ia_page)
 		unlock_page(ia_page);
 	ntfs_debug("Calling filldir for %s with len %i, fpos 0x%llx, inode "
-			"0x%lx, DT_%s.", name, name_len, *fpos, mref,
+			"0x%lx, DT_%s.", name, name_len, fpos, mref,
 			dt_type == DT_DIR ? "DIR" : "REG");
-	rc = filldir(dirent, name, name_len, *fpos, mref, dt_type);
+	rc = filldir(dirent, name, name_len, fpos, mref, dt_type);
 	/* Relock the page but not if we are aborting ->readdir. */
 	if (!rc && ia_page)
 		lock_page(ia_page);
@@ -1226,7 +1225,7 @@
 		/* Advance the position even if going to skip the entry. */
 		fpos = (u8*)ie - (u8*)ir;
 		/* Submit the name to the filldir callback. */
-		rc = ntfs_filldir(vol, &fpos, ndir, NULL, ie, name, dirent,
+		rc = ntfs_filldir(vol, fpos, ndir, NULL, ie, name, dirent,
 				filldir);
 		if (rc) {
 			kfree(ir);
@@ -1412,7 +1411,7 @@
 		 * before returning, unless a non-zero value is returned in
 		 * which case the page is left unlocked.
 		 */
-		rc = ntfs_filldir(vol, &fpos, ndir, ia_page, ie, name, dirent,
+		rc = ntfs_filldir(vol, fpos, ndir, ia_page, ie, name, dirent,
 				filldir);
 		if (rc) {
 			/* @ia_page is already unlocked in this case. */
