Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965152AbWJJMP2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965152AbWJJMP2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 08:15:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965137AbWJJMP1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 08:15:27 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:15001 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S965152AbWJJMPY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 08:15:24 -0400
Date: Tue, 10 Oct 2006 14:15:04 +0200
From: Jan Kara <jack@suse.cz>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
Subject: [PATCH 2/2] Fix IO error reporting on fsync() (2nd try)
Message-ID: <20061010121504.GI23622@atrey.karlin.mff.cuni.cz>
References: <20061010121250.GG23622@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061010121250.GG23622@atrey.karlin.mff.cuni.cz>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When IO error happens on metadata buffer, buffer is freed from memory and later
fsync() is called, filesystems like ext2 fail to report EIO.  We solve the
problem by introdusing a pointer to associated address space to buffer_head.
When buffer is removed from a list of metadata buffers associated with an
address space, IO error is transferred from the buffer to the address space,
so that fsync can later report it.

Signed-off-by: Jan Kara <jack@suse.cz>

diff -rupX /home/jack/.kerndiffexclude linux-2.6.18-1-mark_error_buffer/fs/buffer.c linux-2.6.18-2-fsync_bh_fix/fs/buffer.c
--- linux-2.6.18-1-mark_error_buffer/fs/buffer.c	2006-10-06 13:05:29.000000000 +0200
+++ linux-2.6.18-2-fsync_bh_fix/fs/buffer.c	2006-10-10 17:00:04.000000000 +0200
@@ -709,6 +709,10 @@ EXPORT_SYMBOL(mark_buffer_async_write);
 static inline void __remove_assoc_queue(struct buffer_head *bh)
 {
 	list_del_init(&bh->b_assoc_buffers);
+	WARN_ON(!bh->b_assoc_map);
+	if (buffer_write_io_error(bh))
+		set_bit(AS_EIO, &bh->b_assoc_map->flags);
+	bh->b_assoc_map = NULL;
 }
 
 int inode_has_buffers(struct inode *inode)
@@ -807,6 +811,7 @@ void mark_buffer_dirty_inode(struct buff
 		spin_lock(&buffer_mapping->private_lock);
 		list_move_tail(&bh->b_assoc_buffers,
 				&mapping->private_list);
+		bh->b_assoc_map = mapping;
 		spin_unlock(&buffer_mapping->private_lock);
 	}
 }
@@ -900,7 +905,7 @@ static int fsync_buffers_list(spinlock_t
 	spin_lock(lock);
 	while (!list_empty(list)) {
 		bh = BH_ENTRY(list->next);
-		list_del_init(&bh->b_assoc_buffers);
+		__remove_assoc_queue(bh);
 		if (buffer_dirty(bh) || buffer_locked(bh)) {
 			list_add(&bh->b_assoc_buffers, &tmp);
 			if (buffer_dirty(bh)) {
@@ -921,7 +926,7 @@ static int fsync_buffers_list(spinlock_t
 
 	while (!list_empty(&tmp)) {
 		bh = BH_ENTRY(tmp.prev);
-		__remove_assoc_queue(bh);
+		list_del_init(&bh->b_assoc_buffers);
 		get_bh(bh);
 		spin_unlock(lock);
 		wait_on_buffer(bh);
@@ -1285,6 +1290,7 @@ void __bforget(struct buffer_head *bh)
 
 		spin_lock(&buffer_mapping->private_lock);
 		list_del_init(&bh->b_assoc_buffers);
+		bh->b_assoc_map = NULL;
 		spin_unlock(&buffer_mapping->private_lock);
 	}
 	__brelse(bh);
diff -rupX /home/jack/.kerndiffexclude linux-2.6.18-1-mark_error_buffer/include/linux/buffer_head.h linux-2.6.18-2-fsync_bh_fix/include/linux/buffer_head.h
--- linux-2.6.18-1-mark_error_buffer/include/linux/buffer_head.h	2006-09-27 13:09:04.000000000 +0200
+++ linux-2.6.18-2-fsync_bh_fix/include/linux/buffer_head.h	2006-10-10 15:37:46.000000000 +0200
@@ -67,6 +67,8 @@ struct buffer_head {
 	bh_end_io_t *b_end_io;		/* I/O completion */
  	void *b_private;		/* reserved for b_end_io */
 	struct list_head b_assoc_buffers; /* associated with another mapping */
+	struct address_space *b_assoc_map;	/* mapping this buffer is
+						   associated with */
 	atomic_t b_count;		/* users using this buffer_head */
 };

-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs
