Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268311AbUJSKAf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268311AbUJSKAf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 06:00:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268327AbUJSJ6Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 05:58:25 -0400
Received: from ppsw-2.csi.cam.ac.uk ([131.111.8.132]:20619 "EHLO
	ppsw-2.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S268139AbUJSJmi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 05:42:38 -0400
Date: Tue, 19 Oct 2004 10:42:31 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-ntfs-dev@lists.sourceforge.net
Subject: [PATCH 15/37] Re: [2.6-BK-URL] NTFS: 2.1.21 - Big update with race/bug
 fixes
In-Reply-To: <Pine.LNX.4.60.0410191041590.24986@hermes-1.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.60.0410191042200.24986@hermes-1.csi.cam.ac.uk>
References: <Pine.LNX.4.60.0410191017070.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191038250.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191038570.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191039140.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191039320.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191039510.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191040050.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191040220.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191040360.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191040490.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191041050.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191041180.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191041290.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191041420.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191041590.24986@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is patch 15/37 in the series.  It contains the following ChangeSet:

<aia21@cantab.net> (04/10/05 1.2022.1.1)
   NTFS: Add a helper function fs/ntfs/aops.c::mark_ntfs_record_dirty() which
         marks all buffers belonging to an ntfs record dirty, followed by
         marking the page the ntfs record is in dirty and also marking the vfs
         inode containing the ntfs record dirty (I_DIRTY_PAGES).
   
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
--- a/fs/ntfs/ChangeLog	2004-10-19 10:14:00 +01:00
+++ b/fs/ntfs/ChangeLog	2004-10-19 10:14:00 +01:00
@@ -47,6 +47,10 @@
 	- Implement fs/ntfs/runlist.c::ntfs_rl_truncate_nolock().
 	- Add MFT_RECORD_OLD as a copy of MFT_RECORD in fs/ntfs/layout.h and
 	  change MFT_RECORD to contain the NTFS 3.1+ specific fields.
+	- Add a helper function fs/ntfs/aops.c::mark_ntfs_record_dirty() which
+	  marks all buffers belonging to an ntfs record dirty, followed by
+	  marking the page the ntfs record is in dirty and also marking the vfs
+	  inode containing the ntfs record dirty (I_DIRTY_PAGES).
 
 2.1.20 - Fix two stupid bugs introduced in 2.1.18 release.
 
diff -Nru a/fs/ntfs/aops.c b/fs/ntfs/aops.c
--- a/fs/ntfs/aops.c	2004-10-19 10:14:00 +01:00
+++ b/fs/ntfs/aops.c	2004-10-19 10:14:00 +01:00
@@ -27,6 +27,7 @@
 #include <linux/swap.h>
 #include <linux/buffer_head.h>
 
+#include "aops.h"
 #include "ntfs.h"
 
 /**
@@ -2028,3 +2029,44 @@
 						   belonging to the page. */
 #endif /* NTFS_RW */
 };
+
+#ifdef NTFS_RW
+
+/**
+ * mark_ntfs_record_dirty - mark an ntfs record dirty
+ * @ni:		ntfs inode to which the ntfs record to be marked dirty belongs
+ * @page:	page containing the ntfs record to mark dirty
+ * @rec_start:	byte offset within @page at which the ntfs record begins
+ *
+ * If the ntfs record is the same size as the page cache page @page, set all
+ * buffers in the page dirty.  Otherwise, set only the buffers in which the
+ * ntfs record is located dirty.
+ *
+ * Also, set the page containing the ntfs record dirty, which also marks the
+ * vfs inode the ntfs record belongs to dirty (I_DIRTY_PAGES).
+ */
+void mark_ntfs_record_dirty(ntfs_inode *ni, struct page *page,
+		unsigned int rec_start) {
+	struct buffer_head *bh, *head;
+	unsigned int rec_end, bh_size, bh_start, bh_end;
+
+	BUG_ON(!page);
+	BUG_ON(!page_has_buffers(page));
+	if (ni->itype.index.block_size == PAGE_CACHE_SIZE) {
+		__set_page_dirty_buffers(page);
+		return;
+	}
+	rec_end = rec_start + ni->itype.index.block_size;
+	bh_size = ni->vol->sb->s_blocksize;
+	bh_start = 0;
+	bh = head = page_buffers(page);
+	do {
+		bh_end = bh_start + bh_size;
+		if ((bh_start >= rec_start) && (bh_end <= rec_end))
+			set_buffer_dirty(bh);
+		bh_start = bh_end;
+	} while ((bh = bh->b_this_page) != head);
+	__set_page_dirty_nobuffers(page);
+}
+
+#endif /* NTFS_RW */
diff -Nru a/fs/ntfs/aops.h b/fs/ntfs/aops.h
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/fs/ntfs/aops.h	2004-10-19 10:14:00 +01:00
@@ -0,0 +1,36 @@
+/**
+ * aops.h - Defines for NTFS kernel address space operations and page cache
+ *	    handling.  Part of the Linux-NTFS project.
+ *
+ * Copyright (c) 2001-2004 Anton Altaparmakov
+ * Copyright (c) 2002 Richard Russon
+ *
+ * This program/include file is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as published
+ * by the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program/include file is distributed in the hope that it will be
+ * useful, but WITHOUT ANY WARRANTY; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program (in the main directory of the Linux-NTFS
+ * distribution in the file COPYING); if not, write to the Free Software
+ * Foundation,Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#ifndef _LINUX_NTFS_AOPS_H
+#define _LINUX_NTFS_AOPS_H
+
+#ifdef NTFS_RW
+
+#include "inode.h"
+
+extern void mark_ntfs_record_dirty(ntfs_inode *ni, struct page *page,
+		unsigned int rec_start);
+
+#endif /* NTFS_RW */
+
+#endif /* _LINUX_NTFS_AOPS_H */
