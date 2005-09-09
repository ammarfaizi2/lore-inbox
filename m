Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030194AbVIIJbh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030194AbVIIJbh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 05:31:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030195AbVIIJbg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 05:31:36 -0400
Received: from ppsw-7.csi.cam.ac.uk ([131.111.8.137]:44000 "EHLO
	ppsw-7.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S1030194AbVIIJbe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 05:31:34 -0400
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Date: Fri, 9 Sep 2005 10:31:21 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net
Subject: [PATCH 24/25] NTFS: Improve scalability by changing the driver global
 spin lock in
In-Reply-To: <Pine.LNX.4.60.0509090950100.11051@hermes-1.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.60.0509091031000.26845@hermes-1.csi.cam.ac.uk>
References: <Pine.LNX.4.60.0509090950100.11051@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH 24/25] NTFS: Improve scalability by changing the driver global spin lock in
      fs/ntfs/aops.c::ntfs_end_buffer_async_read() to a bit spin lock
      in the first buffer head of a page.

Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

---

 fs/ntfs/ChangeLog |    3 +++
 fs/ntfs/aops.c    |   15 +++++++++------
 2 files changed, 12 insertions(+), 6 deletions(-)

e604635c8bea16f6177e6133eb3efbfb4a029ef6
diff --git a/fs/ntfs/ChangeLog b/fs/ntfs/ChangeLog
--- a/fs/ntfs/ChangeLog
+++ b/fs/ntfs/ChangeLog
@@ -86,6 +86,9 @@ ToDo/Notes:
 	- Fix fs/ntfs/aops.c::ntfs_{read,write}_block() to handle the case
 	  where a concurrent truncate has truncated the runlist under our feet.
 	- Fix page_has_buffers()/page_buffers() handling in fs/ntfs/aops.c.
+	- In fs/ntfs/aops.c::ntfs_end_buffer_async_read(), use a bit spin lock
+	  in the first buffer head instead of a driver global spin lock to
+	  improve scalability.
 
 2.1.23 - Implement extension of resident files and make writing safe as well as
 	 many bug fixes, cleanups, and enhancements...
diff --git a/fs/ntfs/aops.c b/fs/ntfs/aops.c
--- a/fs/ntfs/aops.c
+++ b/fs/ntfs/aops.c
@@ -55,9 +55,8 @@
  */
 static void ntfs_end_buffer_async_read(struct buffer_head *bh, int uptodate)
 {
-	static DEFINE_SPINLOCK(page_uptodate_lock);
 	unsigned long flags;
-	struct buffer_head *tmp;
+	struct buffer_head *first, *tmp;
 	struct page *page;
 	ntfs_inode *ni;
 	int page_uptodate = 1;
@@ -89,11 +88,13 @@ static void ntfs_end_buffer_async_read(s
 		}
 	} else {
 		clear_buffer_uptodate(bh);
+		SetPageError(page);
 		ntfs_error(ni->vol->sb, "Buffer I/O error, logical block %llu.",
 				(unsigned long long)bh->b_blocknr);
-		SetPageError(page);
 	}
-	spin_lock_irqsave(&page_uptodate_lock, flags);
+	first = page_buffers(page);
+	local_irq_save(flags);
+	bit_spin_lock(BH_Uptodate_Lock, &first->b_state);
 	clear_buffer_async_read(bh);
 	unlock_buffer(bh);
 	tmp = bh;
@@ -108,7 +109,8 @@ static void ntfs_end_buffer_async_read(s
 		}
 		tmp = tmp->b_this_page;
 	} while (tmp != bh);
-	spin_unlock_irqrestore(&page_uptodate_lock, flags);
+	bit_spin_unlock(BH_Uptodate_Lock, &first->b_state);
+	local_irq_restore(flags);
 	/*
 	 * If none of the buffers had errors then we can set the page uptodate,
 	 * but we first have to perform the post read mst fixups, if the
@@ -141,7 +143,8 @@ static void ntfs_end_buffer_async_read(s
 	unlock_page(page);
 	return;
 still_busy:
-	spin_unlock_irqrestore(&page_uptodate_lock, flags);
+	bit_spin_unlock(BH_Uptodate_Lock, &first->b_state);
+	local_irq_restore(flags);
 	return;
 }
 
