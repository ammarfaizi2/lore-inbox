Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261927AbUKJNrL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261927AbUKJNrL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 08:47:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261922AbUKJNpu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 08:45:50 -0500
Received: from ppsw-5.csi.cam.ac.uk ([131.111.8.135]:45185 "EHLO
	ppsw-5.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S261887AbUKJNoo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 08:44:44 -0500
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-ntfs-dev@lists.sourceforge.net
Subject: [PATCH 7/26] NTFS 2.1.22 - Bug and race fixes and improved error handling.
Message-Id: <E1CRsm4-0006Nv-Vu@imp.csi.cam.ac.uk>
Date: Wed, 10 Nov 2004 13:44:36 +0000
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is patch 7/26 in the series.  It contains the following ChangeSet:

<aia21@cantab.net> (04/10/25 1.2026.1.23)
   NTFS: In fs/ntfs/aops.c::mark_ntfs_record_dirty(), take the
         mapping->private_lock around the dirtying of the buffer heads
         analagous to the way it is done in __set_page_dirty_buffers().
   
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
--- a/fs/ntfs/ChangeLog	2004-11-10 13:44:40 +00:00
+++ b/fs/ntfs/ChangeLog	2004-11-10 13:44:40 +00:00
@@ -35,6 +35,9 @@
 	  ntfs_attr_size_bounds_check(), ntfs_attr_can_be_non_resident(), and
 	  ntfs_attr_can_be_resident(), which in turn use the new private helper
 	  ntfs_attr_find_in_attrdef().
+	- In fs/ntfs/aops.c::mark_ntfs_record_dirty(), take the
+	  mapping->private_lock around the dirtying of the buffer heads
+	  analagous to the way it is done in __set_page_dirty_buffers().
 
 2.1.21 - Fix some races and bugs, rewrite mft write code, add mft allocator.
 
diff -Nru a/fs/ntfs/aops.c b/fs/ntfs/aops.c
--- a/fs/ntfs/aops.c	2004-11-10 13:44:40 +00:00
+++ b/fs/ntfs/aops.c	2004-11-10 13:44:40 +00:00
@@ -2158,6 +2158,7 @@
 	}
 	end = ofs + ni->itype.index.block_size;
 	bh_size = ni->vol->sb->s_blocksize;
+	spin_lock(&page->mapping->private_lock);
 	bh = head = page_buffers(page);
 	do {
 		bh_ofs = bh_offset(bh);
@@ -2167,6 +2168,7 @@
 			break;
 		set_buffer_dirty(bh);
 	} while ((bh = bh->b_this_page) != head);
+	spin_unlock(&page->mapping->private_lock);
 	__set_page_dirty_nobuffers(page);
 }
 
