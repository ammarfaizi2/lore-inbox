Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932162AbVILTdP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932162AbVILTdP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 15:33:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932169AbVILTdP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 15:33:15 -0400
Received: from ppsw-9.csi.cam.ac.uk ([131.111.8.139]:37787 "EHLO
	ppsw-9.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S932162AbVILTdO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 15:33:14 -0400
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Date: Mon, 12 Sep 2005 20:33:12 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net
Subject: [2/2] NTFS: Mask out __GFP_HIGHMEM when doing kmalloc() in
 __ntfs_malloc()
In-Reply-To: <Pine.LNX.4.60.0509122027430.4649@hermes-1.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.60.0509122031530.4649@hermes-1.csi.cam.ac.uk>
References: <Pine.LNX.4.60.0509122027430.4649@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

NTFS: Mask out __GFP_HIGHMEM when doing kmalloc() in __ntfs_malloc() as it
      otherwise causes a BUG().

Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

diff --git a/fs/ntfs/ChangeLog b/fs/ntfs/ChangeLog
--- a/fs/ntfs/ChangeLog
+++ b/fs/ntfs/ChangeLog
@@ -34,9 +34,6 @@ ToDo/Notes:
 	  journals with two different restart pages.  We sanity check both and
 	  either use the only sane one or the more recent one of the two in the
 	  case that both are valid.
-	- Modify fs/ntfs/malloc.h::ntfs_malloc_nofs() to do the kmalloc() based
-	  allocations with __GFP_HIGHMEM, analogous to how the vmalloc() based
-	  allocations are done.
 	- Add fs/ntfs/malloc.h::ntfs_malloc_nofs_nofail() which is analogous to
 	  ntfs_malloc_nofs() but it performs allocations with __GFP_NOFAIL and
 	  hence cannot fail.
diff --git a/fs/ntfs/malloc.h b/fs/ntfs/malloc.h
--- a/fs/ntfs/malloc.h
+++ b/fs/ntfs/malloc.h
@@ -45,7 +45,7 @@ static inline void *__ntfs_malloc(unsign
 	if (likely(size <= PAGE_SIZE)) {
 		BUG_ON(!size);
 		/* kmalloc() has per-CPU caches so is faster for now. */
-		return kmalloc(PAGE_SIZE, gfp_mask);
+		return kmalloc(PAGE_SIZE, gfp_mask & ~__GFP_HIGHMEM);
 		/* return (void *)__get_free_page(gfp_mask); */
 	}
 	if (likely(size >> PAGE_SHIFT < num_physpages))
