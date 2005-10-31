Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751290AbVJaOdA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751290AbVJaOdA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 09:33:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751332AbVJaOc7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 09:32:59 -0500
Received: from ppsw-0.csi.cam.ac.uk ([131.111.8.130]:31683 "EHLO
	ppsw-0.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S1751290AbVJaOc6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 09:32:58 -0500
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Date: Mon, 31 Oct 2005 14:32:54 +0000 (GMT)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net
Subject: [PATCH 10/17] NTFS: In attrib.c::ntfs_attr_set() call
 balance_dirty_pages_ratelimited()
In-Reply-To: <Pine.LNX.4.64.0510311408160.27357@hermes-1.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.64.0510311432160.27357@hermes-1.csi.cam.ac.uk>
References: <Pine.LNX.4.64.0510311408160.27357@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

NTFS: In attrib.c::ntfs_attr_set() call balance_dirty_pages_ratelimited()
      and cond_resched() in the main loop as we could be dirtying a lot of
      pages and this ensures we play nice with the VM and the system as a
      whole.

Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

---

 fs/ntfs/ChangeLog |    4 ++++
 fs/ntfs/attrib.c  |    4 ++++
 fs/ntfs/malloc.h  |    3 +--
 3 files changed, 9 insertions(+), 2 deletions(-)

applies-to: f2378e8d2fbef7fc215a25acf2042b8965109e5e
29b8990513b077dc388b0756acd31465e5c21441
diff --git a/fs/ntfs/ChangeLog b/fs/ntfs/ChangeLog
index 9f4674a..3b8ff23 100644
--- a/fs/ntfs/ChangeLog
+++ b/fs/ntfs/ChangeLog
@@ -57,6 +57,10 @@ ToDo/Notes:
 	  uncompressed and unencrypted files are supported.  Also, there is
 	  only very limited support for highly fragmented files (the ones whose
 	  $DATA attribute is split into multiple attribute extents).
+	- In attrib.c::ntfs_attr_set() call balance_dirty_pages_ratelimited()
+	  and cond_resched() in the main loop as we could be dirtying a lot of
+	  pages and this ensures we play nice with the VM and the system as a
+	  whole.
 
 2.1.24 - Lots of bug fixes and support more clean journal states.
 
diff --git a/fs/ntfs/attrib.c b/fs/ntfs/attrib.c
index bc25e88..338e471 100644
--- a/fs/ntfs/attrib.c
+++ b/fs/ntfs/attrib.c
@@ -21,7 +21,9 @@
  */
 
 #include <linux/buffer_head.h>
+#include <linux/sched.h>
 #include <linux/swap.h>
+#include <linux/writeback.h>
 
 #include "attrib.h"
 #include "debug.h"
@@ -2590,6 +2592,8 @@ int ntfs_attr_set(ntfs_inode *ni, const 
 		/* Finally unlock and release the page. */
 		unlock_page(page);
 		page_cache_release(page);
+		balance_dirty_pages_ratelimited(mapping);
+		cond_resched();
 	}
 	/* If there is a last partial page, need to do it the slow way. */
 	if (end_ofs) {
diff --git a/fs/ntfs/malloc.h b/fs/ntfs/malloc.h
index 590887b..e38e402 100644
--- a/fs/ntfs/malloc.h
+++ b/fs/ntfs/malloc.h
@@ -39,8 +39,7 @@
  * If there was insufficient memory to complete the request, return NULL.
  * Depending on @gfp_mask the allocation may be guaranteed to succeed.
  */
-static inline void *__ntfs_malloc(unsigned long size,
-		gfp_t gfp_mask)
+static inline void *__ntfs_malloc(unsigned long size, gfp_t gfp_mask)
 {
 	if (likely(size <= PAGE_SIZE)) {
 		BUG_ON(!size);
---
0.99.9
