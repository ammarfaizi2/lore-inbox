Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422641AbWJFL5H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422641AbWJFL5H (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 07:57:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422636AbWJFL5H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 07:57:07 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:9639 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1422643AbWJFL5F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 07:57:05 -0400
Date: Fri, 6 Oct 2006 13:57:20 +0200
From: Jan Kara <jack@suse.cz>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
Subject: [PATCH 3/3] Fix IO error reporting on fsync()
Message-ID: <20061006115720.GF14533@atrey.karlin.mff.cuni.cz>
References: <20061006114947.GC14533@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061006114947.GC14533@atrey.karlin.mff.cuni.cz>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When IO error happens on metadata buffer, buffer is freed from memory
and later fsync() is called, filesystems like ext2 fail to report EIO.
We solve the problem by introducing fake buffer head in the list of
metadata buffers attached to an address_space and a special buffer flag
meaning that some metadata buffer had an IO error. When buffer with
IO error or the new metadata IO error flag is being removed from memory,
previous buffer in the metadata list is marked with the metadata IO error
flag. Hence the information about IO error is retained in memory (at least
in the fake buffer in the beginning of the list) and fsync() can check it.

Signed-off-by: Jan Kara <jack@suse.cz>

diff -rupX /home/jack/.kerndiffexclude linux-2.6.18-2-buffer_headers/fs/buffer.c linux-2.6.18-3-fsync_fix/fs/buffer.c
--- linux-2.6.18-2-buffer_headers/fs/buffer.c	2006-10-06 13:05:29.000000000 +0200
+++ linux-2.6.18-3-fsync_fix/fs/buffer.c	2006-10-06 13:14:21.000000000 +0200
@@ -663,26 +663,26 @@ EXPORT_SYMBOL(mark_buffer_async_write);
  *
  * The functions mark_buffer_inode_dirty(), fsync_inode_buffers(),
  * inode_has_buffers() and invalidate_inode_buffers() are provided for the
- * management of a list of dependent buffers at ->i_mapping->private_list.
+ * management of a list of dependent buffers at ->i_mapping.metadata_buffers.
  *
- * Locking is a little subtle: try_to_free_buffers() will remove buffers
- * from their controlling inode's queue when they are being freed.  But
- * try_to_free_buffers() will be operating against the *blockdev* mapping
- * at the time, not against the S_ISREG file which depends on those buffers.
- * So the locking for private_list is via the private_lock in the address_space
- * which backs the buffers.  Which is different from the address_space 
- * against which the buffers are listed.  So for a particular address_space,
- * mapping->private_lock does *not* protect mapping->private_list!  In fact,
- * mapping->private_list will always be protected by the backing blockdev's
- * ->private_lock.
+ * Locking is a little subtle: try_to_free_buffers() will remove buffers from
+ * their controlling inode's queue when they are being freed.  But
+ * try_to_free_buffers() will be operating against the *blockdev* mapping at
+ * the time, not against the S_ISREG file which depends on those buffers.  So
+ * the locking for metadata_buffers is via the private_lock in the
+ * address_space which backs the buffers.  Which is different from the
+ * address_space against which the buffers are listed.  So for a particular
+ * address_space, mapping->private_lock does *not* protect
+ * mapping.metadata_buffers! In fact, mapping.metadata_buffers will always be
+ * protected by the backing blockdev's ->private_lock.
  *
  * Which introduces a requirement: all buffers on an address_space's
- * ->private_list must be from the same address_space: the blockdev's.
+ * metadata_buffers must be from the same address_space: the blockdev's.
  *
- * address_spaces which do not place buffers at ->private_list via these
- * utility functions are free to use private_lock and private_list for
- * whatever they want.  The only requirement is that list_empty(private_list)
- * be true at clear_inode() time.
+ * address_spaces which do not place buffers at metadata_buffers via these
+ * utility functions are free to use private_lock and metadata_buffers for
+ * whatever they want.  The only requirement is that
+ * list_empty(metadata_buffers) be true at clear_inode() time.
  *
  * FIXME: clear_inode should not call invalidate_inode_buffers().  The
  * filesystems should do that.  invalidate_inode_buffers() should just go
@@ -713,7 +713,7 @@ static inline void __remove_assoc_queue(
 
 int inode_has_buffers(struct inode *inode)
 {
-	return !list_empty(&inode->i_data.private_list);
+	return !list_empty(&inode->i_data.metadata_buffers.b_assoc_buffers);
 }
 
 /*
@@ -756,7 +756,7 @@ repeat:
  *                        buffers
  * @mapping: the mapping which wants those buffers written
  *
- * Starts I/O against the buffers at mapping->private_list, and waits upon
+ * Starts I/O against the buffers at mapping->metadata_buffers, and waits upon
  * that I/O.
  *
  * Basically, this is a convenience function for fsync().
@@ -767,11 +767,11 @@ int sync_mapping_buffers(struct address_
 {
 	struct address_space *buffer_mapping = mapping->assoc_mapping;
 
-	if (buffer_mapping == NULL || list_empty(&mapping->private_list))
+	if (buffer_mapping == NULL)
 		return 0;
 
 	return fsync_buffers_list(&buffer_mapping->private_lock,
-					&mapping->private_list);
+				&mapping->metadata_buffers.b_assoc_buffers);
 }
 EXPORT_SYMBOL(sync_mapping_buffers);
 
@@ -806,7 +806,7 @@ void mark_buffer_dirty_inode(struct buff
 	if (list_empty(&bh->b_assoc_buffers)) {
 		spin_lock(&buffer_mapping->private_lock);
 		list_move_tail(&bh->b_assoc_buffers,
-				&mapping->private_list);
+				&mapping->metadata_buffers.b_assoc_buffers);
 		spin_unlock(&buffer_mapping->private_lock);
 	}
 }
@@ -898,9 +898,18 @@ static int fsync_buffers_list(spinlock_t
 	INIT_LIST_HEAD(&tmp);
 
 	spin_lock(lock);
+	/* Was there IO error on some already evicted buffer? */
+	if (buffer_file_io_error(BH_ENTRY(list))) {
+		clear_buffer_file_io_error(BH_ENTRY(list));
+		err = -EIO;
+	}
 	while (!list_empty(list)) {
 		bh = BH_ENTRY(list->next);
-		list_del_init(&bh->b_assoc_buffers);
+		__remove_assoc_queue(bh);
+		if (buffer_write_io_error(bh) || buffer_file_io_error(bh)) {
+			clear_buffer_file_io_error(BH_ENTRY(list));
+			err = -EIO;
+		}
 		if (buffer_dirty(bh) || buffer_locked(bh)) {
 			list_add(&bh->b_assoc_buffers, &tmp);
 			if (buffer_dirty(bh)) {
@@ -952,7 +961,8 @@ void invalidate_inode_buffers(struct ino
 {
 	if (inode_has_buffers(inode)) {
 		struct address_space *mapping = &inode->i_data;
-		struct list_head *list = &mapping->private_list;
+		struct list_head *list =
+			&mapping->metadata_buffers.b_assoc_buffers;
 		struct address_space *buffer_mapping = mapping->assoc_mapping;
 
 		spin_lock(&buffer_mapping->private_lock);
@@ -974,7 +984,8 @@ int remove_inode_buffers(struct inode *i
 
 	if (inode_has_buffers(inode)) {
 		struct address_space *mapping = &inode->i_data;
-		struct list_head *list = &mapping->private_list;
+		struct list_head *list =
+			&mapping->metadata_buffers.b_assoc_buffers;
 		struct address_space *buffer_mapping = mapping->assoc_mapping;
 
 		spin_lock(&buffer_mapping->private_lock);
@@ -2947,11 +2958,14 @@ drop_buffers(struct page *page, struct b
 {
 	struct buffer_head *head = page_buffers(page);
 	struct buffer_head *bh;
+	int ioerror = 0;
 
 	bh = head;
 	do {
 		if (buffer_write_io_error(bh) && page->mapping)
 			set_bit(AS_EIO, &page->mapping->flags);
+		if (buffer_write_io_error(bh) || buffer_file_io_error(bh))
+			ioerror = 1;
 		if (buffer_busy(bh))
 			goto failed;
 		bh = bh->b_this_page;
@@ -2960,8 +2974,14 @@ drop_buffers(struct page *page, struct b
 	do {
 		struct buffer_head *next = bh->b_this_page;
 
-		if (!list_empty(&bh->b_assoc_buffers))
+		if (!list_empty(&bh->b_assoc_buffers)) {
+			if (ioerror) {
+				struct buffer_head *prev = BH_ENTRY(bh->
+					b_assoc_buffers.prev);
+				set_buffer_file_io_error(prev);
+			}
 			__remove_assoc_queue(bh);
+		}
 		bh = next;
 	} while (bh != head);
 	*buffers_to_free = head;
diff -rupX /home/jack/.kerndiffexclude linux-2.6.18-2-buffer_headers/fs/fs-writeback.c linux-2.6.18-3-fsync_fix/fs/fs-writeback.c
--- linux-2.6.18-2-buffer_headers/fs/fs-writeback.c	2006-09-27 13:08:35.000000000 +0200
+++ linux-2.6.18-3-fsync_fix/fs/fs-writeback.c	2006-10-06 13:14:21.000000000 +0200
@@ -613,7 +613,7 @@ EXPORT_SYMBOL(sync_inode);
  * written and waited upon.
  *
  *    OSYNC_DATA:     i_mapping's dirty data
- *    OSYNC_METADATA: the buffers at i_mapping->private_list
+ *    OSYNC_METADATA: the buffers at i_mapping->metadata_buffers
  *    OSYNC_INODE:    the inode itself
  */
 
diff -rupX /home/jack/.kerndiffexclude linux-2.6.18-2-buffer_headers/fs/inode.c linux-2.6.18-3-fsync_fix/fs/inode.c
--- linux-2.6.18-2-buffer_headers/fs/inode.c	2006-09-27 13:08:38.000000000 +0200
+++ linux-2.6.18-3-fsync_fix/fs/inode.c	2006-10-06 13:14:21.000000000 +0200
@@ -196,7 +196,7 @@ void inode_init_once(struct inode *inode
 	INIT_RADIX_TREE(&inode->i_data.page_tree, GFP_ATOMIC);
 	rwlock_init(&inode->i_data.tree_lock);
 	spin_lock_init(&inode->i_data.i_mmap_lock);
-	INIT_LIST_HEAD(&inode->i_data.private_list);
+ 	INIT_LIST_HEAD(&inode->i_data.metadata_buffers.b_assoc_buffers);
 	spin_lock_init(&inode->i_data.private_lock);
 	INIT_RAW_PRIO_TREE_ROOT(&inode->i_data.i_mmap);
 	INIT_LIST_HEAD(&inode->i_data.i_mmap_nonlinear);
@@ -408,7 +408,7 @@ static int can_unuse(struct inode *inode
  * inode is still freeable, proceed.  The right inode is found 99.9% of the
  * time in testing on a 4-way.
  *
- * If the inode has metadata buffers attached to mapping->private_list then
+ * If the inode has metadata buffers attached to mapping->metadata_buffers then
  * try to remove them.
  */
 static void prune_icache(int nr_to_scan)
diff -rupX /home/jack/.kerndiffexclude linux-2.6.18-2-buffer_headers/include/linux/buffer_head_struct.h linux-2.6.18-3-fsync_fix/include/linux/buffer_head_struct.h
--- linux-2.6.18-2-buffer_headers/include/linux/buffer_head_struct.h	2006-10-06 13:26:42.000000000 +0200
+++ linux-2.6.18-3-fsync_fix/include/linux/buffer_head_struct.h	2006-10-06 13:27:10.000000000 +0200
@@ -30,6 +30,7 @@ enum bh_state_bits {
 	BH_Write_EIO,	/* I/O error on write */
 	BH_Ordered,	/* ordered write */
 	BH_Eopnotsupp,	/* operation not supported (barrier) */
+	BH_File_EIO,	/* Some other buffer in the file had IO error */
 
 	BH_PrivateStart,/* not a state bit, but the first bit available
 			 * for private allocation by other entities
@@ -120,6 +121,7 @@ BUFFER_FNS(Boundary, boundary)
 BUFFER_FNS(Write_EIO, write_io_error)
 BUFFER_FNS(Ordered, ordered)
 BUFFER_FNS(Eopnotsupp, eopnotsupp)
+BUFFER_FNS(File_EIO, file_io_error)
 
 #define bh_offset(bh)		((unsigned long)(bh)->b_data & ~PAGE_MASK)
 #define touch_buffer(bh)	mark_page_accessed(bh->b_page)
diff -rupX /home/jack/.kerndiffexclude linux-2.6.18-2-buffer_headers/include/linux/fs.h linux-2.6.18-3-fsync_fix/include/linux/fs.h
--- linux-2.6.18-2-buffer_headers/include/linux/fs.h	2006-10-06 13:09:38.000000000 +0200
+++ linux-2.6.18-3-fsync_fix/include/linux/fs.h	2006-10-06 13:14:21.000000000 +0200
@@ -400,8 +400,10 @@ struct address_space {
 	unsigned long		flags;		/* error bits/gfp mask */
 	struct backing_dev_info *backing_dev_info; /* device readahead, etc */
 	spinlock_t		private_lock;	/* for use by the address_space */
-	struct list_head	private_list;	/* ditto */
-	struct address_space	*assoc_mapping;	/* ditto */
+	/* Fake buffer head in the list of metadata buffers belonging to block
+	   device address space */
+	struct buffer_head	metadata_buffers;	
+	struct address_space	*assoc_mapping;	/* for use by the address_space */
 } __attribute__((aligned(sizeof(long))));
 	/*
 	 * On most architectures that alignment is already the case; but
