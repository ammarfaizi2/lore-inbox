Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268218AbUJSJsy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268218AbUJSJsy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 05:48:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268229AbUJSJrh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 05:47:37 -0400
Received: from ppsw-4.csi.cam.ac.uk ([131.111.8.134]:37859 "EHLO
	ppsw-4.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S268126AbUJSJkj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 05:40:39 -0400
Date: Tue, 19 Oct 2004 10:40:34 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-ntfs-dev@lists.sourceforge.net
Subject: [PATCH 7/37] Re: [2.6-BK-URL] NTFS: 2.1.21 - Big update with race/bug
 fixes
In-Reply-To: <Pine.LNX.4.60.0410191040050.24986@hermes-1.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.60.0410191040220.24986@hermes-1.csi.cam.ac.uk>
References: <Pine.LNX.4.60.0410191017070.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191038250.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191038570.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191039140.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191039320.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191039510.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191040050.24986@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is patch 7/37 in the series.  It contains the following ChangeSet:

<aia21@cantab.net> (04/09/30 1.2005.1.1)
   NTFS: Rename ntfs_merge_runlists() to ntfs_runlists_merge().
   
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
--- a/fs/ntfs/ChangeLog	2004-10-19 10:13:30 +01:00
+++ b/fs/ntfs/ChangeLog	2004-10-19 10:13:30 +01:00
@@ -29,7 +29,8 @@
 	- Add vol->mft_data_pos and initialize it at mount time.
 	- Rename init_runlist() to ntfs_init_runlist(), ntfs_vcn_to_lcn() to
 	  ntfs_rl_vcn_to_lcn(), decompress_mapping_pairs() to
-	  ntfs_mapping_pairs_decompress() and adapt all callers.
+	  ntfs_mapping_pairs_decompress(), ntfs_merge_runlists() to
+	  ntfs_runlists_merge() and adapt all callers.
 	- Add fs/ntfs/runlist.[hc]::ntfs_get_nr_significant_bytes(),
 	  ntfs_get_size_for_mapping_pairs(), ntfs_write_significant_bytes(),
 	  and ntfs_mapping_pairs_build(), adapted from libntfs.
diff -Nru a/fs/ntfs/inode.c b/fs/ntfs/inode.c
--- a/fs/ntfs/inode.c	2004-10-19 10:13:30 +01:00
+++ b/fs/ntfs/inode.c	2004-10-19 10:13:30 +01:00
@@ -1673,7 +1673,7 @@
  * We solve these problems by starting with the $DATA attribute before anything
  * else and iterating using ntfs_attr_lookup($DATA) over all extents.  As each
  * extent is found, we ntfs_mapping_pairs_decompress() including the implied
- * ntfs_merge_runlists().  Each step of the iteration necessarily provides
+ * ntfs_runlists_merge().  Each step of the iteration necessarily provides
  * sufficient information for the next step to complete.
  *
  * This should work but there are two possible pit falls (see inline comments
diff -Nru a/fs/ntfs/runlist.c b/fs/ntfs/runlist.c
--- a/fs/ntfs/runlist.c	2004-10-19 10:13:30 +01:00
+++ b/fs/ntfs/runlist.c	2004-10-19 10:13:30 +01:00
@@ -449,7 +449,7 @@
 }
 
 /**
- * ntfs_merge_runlists - merge two runlists into one
+ * ntfs_runlists_merge - merge two runlists into one
  * @drl:	original runlist to be worked on
  * @srl:	new runlist to be merged into @drl
  *
@@ -482,7 +482,7 @@
  *	-EINVAL	- Invalid parameters were passed in.
  *	-ERANGE	- The runlists overlap and cannot be merged.
  */
-runlist_element *ntfs_merge_runlists(runlist_element *drl,
+runlist_element *ntfs_runlists_merge(runlist_element *drl,
 		runlist_element *srl)
 {
 	int di, si;		/* Current index into @[ds]rl. */
@@ -915,7 +915,7 @@
 		return rl;
 	}
 	/* Now combine the new and old runlists checking for overlaps. */
-	old_rl = ntfs_merge_runlists(old_rl, rl);
+	old_rl = ntfs_runlists_merge(old_rl, rl);
 	if (likely(!IS_ERR(old_rl)))
 		return old_rl;
 	ntfs_free(rl);
diff -Nru a/fs/ntfs/runlist.h b/fs/ntfs/runlist.h
--- a/fs/ntfs/runlist.h	2004-10-19 10:13:30 +01:00
+++ b/fs/ntfs/runlist.h	2004-10-19 10:13:30 +01:00
@@ -40,6 +40,9 @@
 	LCN_ENOENT		= -3,
 } LCN_SPECIAL_VALUES;
 
+extern runlist_element *ntfs_runlists_merge(runlist_element *drl,
+		runlist_element *srl);
+
 extern runlist_element *ntfs_mapping_pairs_decompress(const ntfs_volume *vol,
 		const ATTR_RECORD *attr, runlist_element *old_rl);
 
