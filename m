Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030197AbVIIJ3o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030197AbVIIJ3o (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 05:29:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030199AbVIIJ3n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 05:29:43 -0400
Received: from ppsw-7.csi.cam.ac.uk ([131.111.8.137]:21981 "EHLO
	ppsw-7.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S1030197AbVIIJ3m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 05:29:42 -0400
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Date: Fri, 9 Sep 2005 10:29:28 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net
Subject: [PATCH 20/25] NTFS: Optimize fs/ntfs/aops.c::ntfs_write_block() by
 extending the page
In-Reply-To: <Pine.LNX.4.60.0509090950100.11051@hermes-1.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.60.0509091029080.26845@hermes-1.csi.cam.ac.uk>
References: <Pine.LNX.4.60.0509090950100.11051@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH 20/25] NTFS: Optimize fs/ntfs/aops.c::ntfs_write_block() by extending the page
      lock protection over the buffer submission for i/o which allows the
      removal of the get_bh()/put_bh() pairs for each buffer.

Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

---

 fs/ntfs/ChangeLog |    3 +++
 fs/ntfs/aops.c    |   13 +++----------
 2 files changed, 6 insertions(+), 10 deletions(-)

54b02eb01c0172294e43e2b54d6815f65637c111
diff --git a/fs/ntfs/ChangeLog b/fs/ntfs/ChangeLog
--- a/fs/ntfs/ChangeLog
+++ b/fs/ntfs/ChangeLog
@@ -81,6 +81,9 @@ ToDo/Notes:
 	  only zeroes.
 	- Fixup handling of sparse, compressed, and encrypted attributes in
 	  fs/ntfs/aops.c::ntfs_writepage().
+	- Optimize fs/ntfs/aops.c::ntfs_write_block() by extending the page
+	  lock protection over the buffer submission for i/o which allows the
+	  removal of the get_bh()/put_bh() pairs for each buffer.
 
 2.1.23 - Implement extension of resident files and make writing safe as well as
 	 many bug fixes, cleanups, and enhancements...
diff --git a/fs/ntfs/aops.c b/fs/ntfs/aops.c
--- a/fs/ntfs/aops.c
+++ b/fs/ntfs/aops.c
@@ -735,7 +735,7 @@ lock_retry_remap:
 	/* For the error case, need to reset bh to the beginning. */
 	bh = head;
 
-	/* Just an optimization, so ->readpage() isn't called later. */
+	/* Just an optimization, so ->readpage() is not called later. */
 	if (unlikely(!PageUptodate(page))) {
 		int uptodate = 1;
 		do {
@@ -751,7 +751,6 @@ lock_retry_remap:
 
 	/* Setup all mapped, dirty buffers for async write i/o. */
 	do {
-		get_bh(bh);
 		if (buffer_mapped(bh) && buffer_dirty(bh)) {
 			lock_buffer(bh);
 			if (test_clear_buffer_dirty(bh)) {
@@ -789,14 +788,8 @@ lock_retry_remap:
 
 	BUG_ON(PageWriteback(page));
 	set_page_writeback(page);	/* Keeps try_to_free_buffers() away. */
-	unlock_page(page);
 
-	/*
-	 * Submit the prepared buffers for i/o. Note the page is unlocked,
-	 * and the async write i/o completion handler can end_page_writeback()
-	 * at any time after the *first* submit_bh(). So the buffers can then
-	 * disappear...
-	 */
+	/* Submit the prepared buffers for i/o. */
 	need_end_writeback = TRUE;
 	do {
 		struct buffer_head *next = bh->b_this_page;
@@ -804,9 +797,9 @@ lock_retry_remap:
 			submit_bh(WRITE, bh);
 			need_end_writeback = FALSE;
 		}
-		put_bh(bh);
 		bh = next;
 	} while (bh != head);
+	unlock_page(page);
 
 	/* If no i/o was started, need to end_page_writeback(). */
 	if (unlikely(need_end_writeback))
