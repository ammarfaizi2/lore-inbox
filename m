Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268729AbUJSKFX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268729AbUJSKFX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 06:05:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268149AbUJSKEq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 06:04:46 -0400
Received: from ppsw-3.csi.cam.ac.uk ([131.111.8.133]:59818 "EHLO
	ppsw-3.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S268159AbUJSJoR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 05:44:17 -0400
Date: Tue, 19 Oct 2004 10:44:10 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-ntfs-dev@lists.sourceforge.net
Subject: [PATCH 22/37] Re: [2.6-BK-URL] NTFS: 2.1.21 - Big update with race/bug
 fixes
In-Reply-To: <Pine.LNX.4.60.0410191043370.24986@hermes-1.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.60.0410191043500.24986@hermes-1.csi.cam.ac.uk>
References: <Pine.LNX.4.60.0410191017070.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191040220.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191040360.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191040490.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191041050.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191041180.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191041290.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191041420.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191041590.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191042200.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191042320.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191042440.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191042560.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191043100.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191043240.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191043370.24986@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is patch 22/37 in the series.  It contains the following ChangeSet:

<aia21@cantab.net> (04/10/11 1.2041)
   NTFS: Add fs/ntfs/mft.c::try_map_mft_record() which fails with -EALREADY if
         the mft record is already locked and otherwise behaves the same way
         as fs/ntfs/mft.c::map_mft_record().
   
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
--- a/fs/ntfs/ChangeLog	2004-10-19 10:14:25 +01:00
+++ b/fs/ntfs/ChangeLog	2004-10-19 10:14:25 +01:00
@@ -70,6 +70,9 @@
 	  mft record dirty as well as the page itself.
 	- Fix compiler warnings on x86-64 in fs/ntfs/dir.c.  (Randy Dunlap,
 	  slightly modified by me)
+	- Add fs/ntfs/mft.c::try_map_mft_record() which fails with -EALREADY if
+	  the mft record is already locked and otherwise behaves the same way
+	  as fs/ntfs/mft.c::map_mft_record().
 
 2.1.20 - Fix two stupid bugs introduced in 2.1.18 release.
 
diff -Nru a/fs/ntfs/mft.c b/fs/ntfs/mft.c
--- a/fs/ntfs/mft.c	2004-10-19 10:14:25 +01:00
+++ b/fs/ntfs/mft.c	2004-10-19 10:14:25 +01:00
@@ -115,6 +115,57 @@
 }
 
 /**
+ * try_map_mft_record - attempt to map, pin and lock an mft record
+ * @ni:		ntfs inode whose MFT record to map
+ *
+ * First, attempt to take the mrec_lock semaphore.  If the semaphore is already
+ * taken by someone else, return the error code -EALREADY.  Otherwise continue
+ * as described below.
+ *
+ * The page of the record is mapped using map_mft_record_page() before being
+ * returned to the caller.
+ *
+ * This in turn uses ntfs_map_page() to get the page containing the wanted mft
+ * record (it in turn calls read_cache_page() which reads it in from disk if
+ * necessary, increments the use count on the page so that it cannot disappear
+ * under us and returns a reference to the page cache page).
+ *
+ * The mft record is now ours and we return a pointer to it.  You need to check
+ * the returned pointer with IS_ERR() and if that is true, PTR_ERR() will return
+ * the error code.
+ *
+ * For further details see the description of map_mft_record() below.
+ */
+MFT_RECORD *try_map_mft_record(ntfs_inode *ni)
+{
+	MFT_RECORD *m;
+
+	ntfs_debug("Entering for mft_no 0x%lx.", ni->mft_no);
+
+	/* Make sure the ntfs inode doesn't go away. */
+	atomic_inc(&ni->count);
+
+	/*
+	 * Serialize access to this mft record.  If someone else is already
+	 * holding the lock, abort instead of waiting for the lock.
+	 */
+	if (unlikely(down_trylock(&ni->mrec_lock))) {
+		ntfs_debug("Mft record is already locked, aborting.");
+		atomic_dec(&ni->count);
+		return ERR_PTR(-EALREADY);
+	}
+
+	m = map_mft_record_page(ni);
+	if (likely(!IS_ERR(m)))
+		return m;
+
+	up(&ni->mrec_lock);
+	atomic_dec(&ni->count);
+	ntfs_error(ni->vol->sb, "Failed with error code %lu.", -PTR_ERR(m));
+	return m;
+}
+
+/**
  * map_mft_record - map, pin and lock an mft record
  * @ni:		ntfs inode whose MFT record to map
  *
diff -Nru a/fs/ntfs/mft.h b/fs/ntfs/mft.h
--- a/fs/ntfs/mft.h	2004-10-19 10:14:25 +01:00
+++ b/fs/ntfs/mft.h	2004-10-19 10:14:25 +01:00
@@ -29,6 +29,7 @@
 
 #include "inode.h"
 
+extern MFT_RECORD *try_map_mft_record(ntfs_inode *ni);
 extern MFT_RECORD *map_mft_record(ntfs_inode *ni);
 extern void unmap_mft_record(ntfs_inode *ni);
 
