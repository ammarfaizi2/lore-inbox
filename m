Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261911AbUKJOx5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261911AbUKJOx5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 09:53:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261979AbUKJOxk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 09:53:40 -0500
Received: from ppsw-4.csi.cam.ac.uk ([131.111.8.134]:54488 "EHLO
	ppsw-4.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S261911AbUKJNpU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 08:45:20 -0500
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-ntfs-dev@lists.sourceforge.net
Subject: [PATCH 16/26] NTFS 2.1.22 - Bug and race fixes and improved error handling.
Message-Id: <E1CRsmf-0006Qj-0Q@imp.csi.cam.ac.uk>
Date: Wed, 10 Nov 2004 13:45:13 +0000
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is patch 16/26 in the series.  It contains the following ChangeSet:

<aia21@cantab.net> (04/11/03 1.2026.1.50)
   NTFS: Modify fs/ntfs/aops.c::mark_ntfs_record_dirty() so it allocates
         buffers for the page if they are not present and then marks the
         buffers belonging to the ntfs record dirty.  This causes the buffers
         to become busy and hence they are safe from removal until the page
         has been written out.
   
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
--- a/fs/ntfs/ChangeLog	2004-11-10 13:45:16 +00:00
+++ b/fs/ntfs/ChangeLog	2004-11-10 13:45:16 +00:00
@@ -61,6 +61,11 @@
 	  attribute was found.  (Thanks to Domen Puncer for the bug report.)
 	- Add MODULE_VERSION() to fs/ntfs/super.c.
 	- Make several functions and variables static.  (Adrian Bunk)
+	- Modify fs/ntfs/aops.c::mark_ntfs_record_dirty() so it allocates
+	  buffers for the page if they are not present and then marks the
+	  buffers belonging to the ntfs record dirty.  This causes the buffers
+	  to become busy and hence they are safe from removal until the page
+	  has been written out.
 
 2.1.21 - Fix some races and bugs, rewrite mft write code, add mft allocator.
 
diff -Nru a/fs/ntfs/aops.c b/fs/ntfs/aops.c
--- a/fs/ntfs/aops.c	2004-11-10 13:45:16 +00:00
+++ b/fs/ntfs/aops.c	2004-11-10 13:45:16 +00:00
@@ -2170,29 +2170,43 @@
  * @page:	page containing the ntfs record to mark dirty
  * @ofs:	byte offset within @page at which the ntfs record begins
  *
- * If the ntfs record is the same size as the page cache page @page, set all
- * buffers in the page dirty.  Otherwise, set only the buffers in which the
- * ntfs record is located dirty.
+ * Set the buffers and the page in which the ntfs record is located dirty.
  *
- * Also, set the page containing the ntfs record dirty, which also marks the
- * vfs inode the ntfs record belongs to dirty (I_DIRTY_PAGES).
+ * The latter also marks the vfs inode the ntfs record belongs to dirty
+ * (I_DIRTY_PAGES only).
+ *
+ * If the page does not have buffers, we create them and set them uptodate.
+ * The page may not be locked which is why we need to handle the buffers under
+ * the mapping->private_lock.  Once the buffers are marked dirty we no longer
+ * need the lock since try_to_free_buffers() does not free dirty buffers.
  */
 void mark_ntfs_record_dirty(struct page *page, const unsigned int ofs) {
-	ntfs_inode *ni;
-	struct buffer_head *bh, *head;
+	struct address_space *mapping = page->mapping;
+	ntfs_inode *ni = NTFS_I(mapping->host);
+	struct buffer_head *bh, *head, *buffers_to_free = NULL;
 	unsigned int end, bh_size, bh_ofs;
 
-	BUG_ON(!page);
-	BUG_ON(!page_has_buffers(page));
-	ni = NTFS_I(page->mapping->host);
-	BUG_ON(!ni);
-	if (ni->itype.index.block_size == PAGE_CACHE_SIZE) {
-		__set_page_dirty_buffers(page);
-		return;
-	}
+	BUG_ON(!PageUptodate(page));
 	end = ofs + ni->itype.index.block_size;
-	bh_size = ni->vol->sb->s_blocksize;
-	spin_lock(&page->mapping->private_lock);
+	bh_size = 1 << VFS_I(ni)->i_blkbits;
+	spin_lock(&mapping->private_lock);
+	if (unlikely(!page_has_buffers(page))) {
+		spin_unlock(&mapping->private_lock);
+		bh = head = alloc_page_buffers(page, bh_size, 1);
+		spin_lock(&mapping->private_lock);
+		if (likely(!page_has_buffers(page))) {
+			struct buffer_head *tail;
+
+			do {
+				set_buffer_uptodate(bh);
+				tail = bh;
+				bh = bh->b_this_page;
+			} while (bh);
+			tail->b_this_page = head;
+			attach_page_buffers(page, head);
+		} else
+			buffers_to_free = bh;
+	}
 	bh = head = page_buffers(page);
 	do {
 		bh_ofs = bh_offset(bh);
@@ -2202,8 +2216,15 @@
 			break;
 		set_buffer_dirty(bh);
 	} while ((bh = bh->b_this_page) != head);
-	spin_unlock(&page->mapping->private_lock);
+	spin_unlock(&mapping->private_lock);
 	__set_page_dirty_nobuffers(page);
+	if (unlikely(buffers_to_free)) {
+		do {
+			bh = buffers_to_free->b_this_page;
+			free_buffer_head(buffers_to_free);
+			buffers_to_free = bh;
+		} while (buffers_to_free);
+	}
 }
 
 #endif /* NTFS_RW */
