Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263364AbUJ2Oci@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263364AbUJ2Oci (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 10:32:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263360AbUJ2Oam
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 10:30:42 -0400
Received: from ppsw-2.csi.cam.ac.uk ([131.111.8.132]:12447 "EHLO
	ppsw-2.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S263352AbUJ2O2r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 10:28:47 -0400
Date: Fri, 29 Oct 2004 15:28:37 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: RFC: Changes to fs/buffer.c?
Message-ID: <Pine.LNX.4.60.0410291516580.19494@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew, hi Linus,

I would like to use create_buffers() and __set_page_buffers() in ntfs but 
both are static functions in fs/buffer.c.  Is it ok to export 
create_buffers() and to make __set_page_buffers() static inline and move 
it to include/linux/buffer.h?  In other words, is the below patch 
acceptable?

If you are curious why I need these, it is because 
mark_ntfs_record_dirty() needs to create buffers if they are not present 
so that it can set only some of them dirty and create_empty_buffers() sets 
all buffers dirty which is not useful.  Also create_empty_buffers() relies 
on the page being locked which is not necessarily the case when 
mark_ntfs_record_dirty() is called.  This allows me to only mark parts of 
a page as dirty which means ->writepage() does not need to write the whole 
page but only the dirty ntfs records in the page.  The function I am 
talking about is at the end of this email if you want to see it.

Thanks a lot in advance.

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

--- ntfs-2.6-devel/include/linux/buffer_head.h.old	2004-10-29 14:38:11.543109318 +0100
+++ ntfs-2.6-devel/include/linux/buffer_head.h	2004-10-29 14:38:48.718192623 +0100
@@ -10,6 +10,7 @@
 #include <linux/types.h>
 #include <linux/fs.h>
 #include <linux/linkage.h>
+#include <linux/pagemap.h>
 #include <linux/wait.h>
 #include <asm/atomic.h>
 
@@ -136,6 +137,8 @@ void init_buffer(struct buffer_head *, b
 void set_bh_page(struct buffer_head *bh,
 		struct page *page, unsigned long offset);
 int try_to_free_buffers(struct page *);
+struct buffer_head *create_buffers(struct page *page, unsigned long size,
+		int retry);
 void create_empty_buffers(struct page *, unsigned long,
 			unsigned long b_state);
 void end_buffer_read_sync(struct buffer_head *bh, int uptodate);
@@ -205,6 +208,14 @@ int nobh_truncate_page(struct address_sp
  * inline definitions
  */
 
+static inline void __set_page_buffers(struct page *page,
+		struct buffer_head *head)
+{
+	page_cache_get(page);
+	SetPagePrivate(page);
+	page->private = (unsigned long)head;
+}
+
 static inline void get_bh(struct buffer_head *bh)
 {
         atomic_inc(&bh->b_count);
--- ntfs-2.6-devel/fs/buffer.c.old	2004-10-29 12:50:57.271105103 +0100
+++ ntfs-2.6-devel/fs/buffer.c	2004-10-29 14:35:29.254207332 +0100
@@ -91,14 +91,6 @@ void __wait_on_buffer(struct buffer_head
 }
 
 static void
-__set_page_buffers(struct page *page, struct buffer_head *head)
-{
-	page_cache_get(page);
-	SetPagePrivate(page);
-	page->private = (unsigned long)head;
-}
-
-static void
 __clear_page_buffers(struct page *page)
 {
 	ClearPagePrivate(page);
@@ -1013,8 +1005,8 @@ int remove_inode_buffers(struct inode *i
  * The retry flag is used to differentiate async IO (paging, swapping)
  * which may not fail from ordinary buffer allocations.
  */
-static struct buffer_head *
-create_buffers(struct page * page, unsigned long size, int retry)
+struct buffer_head *create_buffers(struct page *page, unsigned long size,
+		int retry)
 {
 	struct buffer_head *bh, *head;
 	long offset;
@@ -1072,6 +1064,7 @@ no_grow:
 	free_more_memory();
 	goto try_again;
 }
+EXPORT_SYMBOL(create_buffers);
 
 static inline void
 link_dev_buffers(struct page *page, struct buffer_head *head)


------------- this is mark_ntfs_record_dirty() --------------

/**
 * mark_ntfs_record_dirty - mark an ntfs record dirty
 * @page:	page containing the ntfs record to mark dirty
 * @ofs:	byte offset within @page at which the ntfs record begins
 *
 * Set the buffers and the page in which the ntfs record is located dirty.
 *
 * The latter also marks the vfs inode the ntfs record belongs to dirty
 * (I_DIRTY_PAGES only).
 *
 * If the page does not have buffers, we create them and set them uptodate.
 * The page may not be locked which is why we need to handle the buffers under
 * the mapping->private_lock.  Once the buffers are marked dirty we no longer
 * need the lock since try_to_free_buffers() does not free dirty buffers.
 */
void mark_ntfs_record_dirty(struct page *page, const unsigned int ofs) {
	struct address_space *mapping = page->mapping;
	ntfs_inode *ni = NTFS_I(mapping->host);
	struct buffer_head *bh, *head, *buffers_to_free = NULL;
	unsigned int end, bh_size, bh_ofs;

	BUG_ON(!PageUptodate(page));
	end = ofs + ni->itype.index.block_size;
	bh_size = 1 << VFS_I(ni)->i_blkbits;
	spin_lock(&mapping->private_lock);
	if (unlikely(!page_has_buffers(page))) {
		spin_unlock(&mapping->private_lock);
		bh = head = create_buffers(page, bh_size, 1);
		spin_lock(&mapping->private_lock);
		if (likely(!page_has_buffers(page))) {
			struct buffer_head *tail;

			do {
				set_buffer_uptodate(bh);
				tail = bh;
				bh = bh->b_this_page;
			} while (bh);
			tail->b_this_page = head;
			__set_page_buffers(page, head);
		} else
			buffers_to_free = bh;
	}
	bh = head = page_buffers(page);
	do {
		bh_ofs = bh_offset(bh);
		if (bh_ofs + bh_size <= ofs)
			continue;
		if (unlikely(bh_ofs >= end))
			break;
		set_buffer_dirty(bh);
	} while ((bh = bh->b_this_page) != head);
	spin_unlock(&mapping->private_lock);
	__set_page_dirty_nobuffers(page);
	if (unlikely(buffers_to_free)) {
		do {
			bh = buffers_to_free->b_this_page;
			free_buffer_head(buffers_to_free);
			buffers_to_free = bh;
		} while (buffers_to_free);
	}
}
