Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965114AbWFTHWe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965114AbWFTHWe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 03:22:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965115AbWFTHWe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 03:22:34 -0400
Received: from ppsw-1.csi.cam.ac.uk ([131.111.8.131]:19147 "EHLO
	ppsw-1.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S965114AbWFTHWc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 03:22:32 -0400
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Date: Tue, 20 Jun 2006 08:22:28 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net,
       pwtng@yahoo.com
Subject: [2.6 PATCH] NTFS: Critical bug fix (affects MIPS and possibly others).
Message-ID: <Pine.LNX.4.64.0606200815220.5213@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus/Andrew,

Please apply the below patch.  It fixes a crash in NTFS on architectures 
where flush_dcache_page() is a real function.  I never noticed this as all 
my testing is done on i386 where flush_dcache_page() is NULL.

Many thanks to Pauline Ng for the detailed bug report and analysis!

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer, http://www.linux-ntfs.org/

---
[NTFS] Fix critical bug in ntfs_flush_dcache_pages().

Many thanks to Pauline Ng for the detailed bug report and analysis!

Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

diff --git a/fs/ntfs/file.c b/fs/ntfs/file.c
index c63a83e..36e1e13 100644
--- a/fs/ntfs/file.c
+++ b/fs/ntfs/file.c
@@ -1484,14 +1484,15 @@ static inline void ntfs_flush_dcache_pag
 		unsigned nr_pages)
 {
 	BUG_ON(!nr_pages);
+	/*
+	 * Warning: Do not do the decrement at the same time as the call to
+	 * flush_dcache_page() because it is a NULL macro on i386 and hence the
+	 * decrement never happens so the loop never terminates.
+	 */
 	do {
-		/*
-		 * Warning: Do not do the decrement at the same time as the
-		 * call because flush_dcache_page() is a NULL macro on i386
-		 * and hence the decrement never happens.
-		 */
+		--nr_pages;
 		flush_dcache_page(pages[nr_pages]);
-	} while (--nr_pages > 0);
+	} while (nr_pages > 0);
 }
 
 /**
