Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268327AbUJSLZr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268327AbUJSLZr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 07:25:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268235AbUJSJsy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 05:48:54 -0400
Received: from ppsw-3.csi.cam.ac.uk ([131.111.8.133]:10405 "EHLO
	ppsw-3.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S268127AbUJSJkw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 05:40:52 -0400
Date: Tue, 19 Oct 2004 10:40:47 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-ntfs-dev@lists.sourceforge.net
Subject: [PATCH 8/37] Re: [2.6-BK-URL] NTFS: 2.1.21 - Big update with race/bug
 fixes
In-Reply-To: <Pine.LNX.4.60.0410191040220.24986@hermes-1.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.60.0410191040360.24986@hermes-1.csi.cam.ac.uk>
References: <Pine.LNX.4.60.0410191017070.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191038250.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191038570.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191039140.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191039320.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191039510.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191040050.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191040220.24986@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is patch 8/37 in the series.  It contains the following ChangeSet:

<aia21@cantab.net> (04/09/30 1.2005.1.2)
   NTFS: - Add fs/ntfs/lcnalloc.h::ntfs_cluster_free_from_rl() which is a static
           inline wrapper for ntfs_cluster_free_from_rl_nolock() which takes the
           cluster bitmap lock for the duration of the call.
         - Make fs/ntfs/lcnalloc.c::ntfs_cluster_free_from_rl_nolock() not
           static and add a declaration for it to lcnalloc.h.
   
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
--- a/fs/ntfs/ChangeLog	2004-10-19 10:13:34 +01:00
+++ b/fs/ntfs/ChangeLog	2004-10-19 10:13:34 +01:00
@@ -34,6 +34,11 @@
 	- Add fs/ntfs/runlist.[hc]::ntfs_get_nr_significant_bytes(),
 	  ntfs_get_size_for_mapping_pairs(), ntfs_write_significant_bytes(),
 	  and ntfs_mapping_pairs_build(), adapted from libntfs.
+	- Make fs/ntfs/lcnalloc.c::ntfs_cluster_free_from_rl_nolock() not
+	  static, add a declaration for it to lcnalloc.h.
+	- Add fs/ntfs/lcnalloc.h::ntfs_cluster_free_from_rl() which is a static
+	  inline wrapper for ntfs_cluster_free_from_rl_nolock() which takes the
+	  cluster bitmap lock for the duration of the call.
 
 2.1.19 - Many cleanups, improvements, and a minor bug fix.
 
diff -Nru a/fs/ntfs/lcnalloc.c b/fs/ntfs/lcnalloc.c
--- a/fs/ntfs/lcnalloc.c	2004-10-19 10:13:34 +01:00
+++ b/fs/ntfs/lcnalloc.c	2004-10-19 10:13:34 +01:00
@@ -46,7 +46,7 @@
  * Locking: - The volume lcn bitmap must be locked for writing on entry and is
  *	      left locked on return.
  */
-static int ntfs_cluster_free_from_rl_nolock(ntfs_volume *vol,
+int ntfs_cluster_free_from_rl_nolock(ntfs_volume *vol,
 		const runlist_element *rl)
 {
 	struct inode *lcnbmp_vi = vol->lcnbmp_ino;
diff -Nru a/fs/ntfs/lcnalloc.h b/fs/ntfs/lcnalloc.h
--- a/fs/ntfs/lcnalloc.h	2004-10-19 10:13:34 +01:00
+++ b/fs/ntfs/lcnalloc.h	2004-10-19 10:13:34 +01:00
@@ -78,6 +78,34 @@
 	return __ntfs_cluster_free(vi, start_vcn, count, FALSE);
 }
 
+extern int ntfs_cluster_free_from_rl_nolock(ntfs_volume *vol,
+		const runlist_element *rl);
+
+/**
+ * ntfs_cluster_free_from_rl - free clusters from runlist
+ * @vol:	mounted ntfs volume on which to free the clusters
+ * @rl:		runlist describing the clusters to free
+ *
+ * Free all the clusters described by the runlist @rl on the volume @vol.  In
+ * the case of an error being returned, at least some of the clusters were not
+ * freed.
+ *
+ * Return 0 on success and -errno on error.
+ *
+ * Locking: This function takes the volume lcn bitmap lock for writing and
+ *	    modifies the bitmap contents.
+ */
+static inline int ntfs_cluster_free_from_rl(ntfs_volume *vol,
+		const runlist_element *rl)
+{
+	int ret;
+
+	down_write(&vol->lcnbmp_lock);
+	ret = ntfs_cluster_free_from_rl_nolock(vol, rl);
+	up_write(&vol->lcnbmp_lock);
+	return ret;
+}
+
 #endif /* NTFS_RW */
 
 #endif /* defined _LINUX_NTFS_LCNALLOC_H */
