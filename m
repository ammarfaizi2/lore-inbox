Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268224AbUIGPWA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268224AbUIGPWA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 11:22:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268305AbUIGPSx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 11:18:53 -0400
Received: from verein.lst.de ([213.95.11.210]:65178 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S268206AbUIGPQM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 11:16:12 -0400
Date: Tue, 7 Sep 2004 17:16:06 +0200
From: Christoph Hellwig <hch@lst.de>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] missing static in buffer.c
Message-ID: <20040907151606.GD9577@lst.de>
Mail-Followup-To: Christoph Hellwig <hch>, akpm@osdl.org,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The exports were for reiserfs in 2.4, but reiserfs doesn't need them
anymore.


--- 1.255/fs/buffer.c	2004-08-27 08:31:38 +02:00
+++ edited/fs/buffer.c	2004-09-07 15:34:59 +02:00
@@ -39,6 +39,7 @@
 #include <linux/cpu.h>
 #include <asm/bitops.h>
 
+static int fsync_buffers_list(spinlock_t *lock, struct list_head *list);
 static void invalidate_bh_lrus(void);
 
 #define BH_ENTRY(list) list_entry((list), struct buffer_head, b_assoc_buffers)
@@ -725,12 +726,11 @@
  * PageLocked prevents anyone from starting writeback of a page which is
  * under read I/O (PageWriteback is only ever set against a locked page).
  */
-void mark_buffer_async_read(struct buffer_head *bh)
+static void mark_buffer_async_read(struct buffer_head *bh)
 {
 	bh->b_end_io = end_buffer_async_read;
 	set_buffer_async_read(bh);
 }
-EXPORT_SYMBOL(mark_buffer_async_read);
 
 void mark_buffer_async_write(struct buffer_head *bh)
 {
@@ -789,14 +789,6 @@
  * b_inode back.
  */
 
-void buffer_insert_list(spinlock_t *lock,
-		struct buffer_head *bh, struct list_head *list)
-{
-	spin_lock(lock);
-	list_move_tail(&bh->b_assoc_buffers, list);
-	spin_unlock(lock);
-}
-
 /*
  * The buffer's backing address_space's private_lock must be held
  */
@@ -899,9 +891,13 @@
 		if (mapping->assoc_mapping != buffer_mapping)
 			BUG();
 	}
-	if (list_empty(&bh->b_assoc_buffers))
-		buffer_insert_list(&buffer_mapping->private_lock,
-				bh, &mapping->private_list);
+	if (list_empty(&bh->b_assoc_buffers)) {
+		spin_lock(&buffer_mapping->private_lock);
+		list_move_tail(&bh->b_assoc_buffers,
+				&mapping->private_list);
+		spin_lock(&buffer_mapping->private_lock);
+}
+
 }
 EXPORT_SYMBOL(mark_buffer_dirty_inode);
 
@@ -982,7 +978,7 @@
  * the osync code to catch these locked, dirty buffers without requeuing
  * any newly dirty buffers for write.
  */
-int fsync_buffers_list(spinlock_t *lock, struct list_head *list)
+static int fsync_buffers_list(spinlock_t *lock, struct list_head *list)
 {
 	struct buffer_head *bh;
 	struct list_head tmp;
@@ -3153,14 +3149,12 @@
 EXPORT_SYMBOL(block_sync_page);
 EXPORT_SYMBOL(block_truncate_page);
 EXPORT_SYMBOL(block_write_full_page);
-EXPORT_SYMBOL(buffer_insert_list);
 EXPORT_SYMBOL(cont_prepare_write);
 EXPORT_SYMBOL(end_buffer_async_write);
 EXPORT_SYMBOL(end_buffer_read_sync);
 EXPORT_SYMBOL(end_buffer_write_sync);
 EXPORT_SYMBOL(file_fsync);
 EXPORT_SYMBOL(fsync_bdev);
-EXPORT_SYMBOL(fsync_buffers_list);
 EXPORT_SYMBOL(generic_block_bmap);
 EXPORT_SYMBOL(generic_commit_write);
 EXPORT_SYMBOL(generic_cont_expand);
--- 1.56/include/linux/buffer_head.h	2004-08-27 08:31:38 +02:00
+++ edited/include/linux/buffer_head.h	2004-09-07 14:34:55 +02:00
@@ -143,17 +143,13 @@
 void end_buffer_async_write(struct buffer_head *bh, int uptodate);
 
 /* Things to do with buffers at mapping->private_list */
-void buffer_insert_list(spinlock_t *lock,
-			struct buffer_head *, struct list_head *);
 void mark_buffer_dirty_inode(struct buffer_head *bh, struct inode *inode);
 int inode_has_buffers(struct inode *);
 void invalidate_inode_buffers(struct inode *);
 int remove_inode_buffers(struct inode *inode);
-int fsync_buffers_list(spinlock_t *lock, struct list_head *);
 int sync_mapping_buffers(struct address_space *mapping);
 void unmap_underlying_metadata(struct block_device *bdev, sector_t block);
 
-void mark_buffer_async_read(struct buffer_head *bh);
 void mark_buffer_async_write(struct buffer_head *bh);
 void invalidate_bdev(struct block_device *, int);
 int sync_blockdev(struct block_device *bdev);
