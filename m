Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316776AbSFQGwB>; Mon, 17 Jun 2002 02:52:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316804AbSFQGt1>; Mon, 17 Jun 2002 02:49:27 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:20238 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S316777AbSFQGsB>;
	Mon, 17 Jun 2002 02:48:01 -0400
Message-ID: <3D0D8710.32F05879@zip.com.au>
Date: Sun, 16 Jun 2002 23:52:00 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [patch 7/19] mark_buffer_dirty_inode() speedup
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



buffer_insert_list() is showing up on Anton's graphs.  It'll be via
ext2's mark_buffer_dirty_inode() against indirect blocks.  If the
buffer is already on an inode queue, we know that it is on the correct
inode's queue so we don't need to re-add it.



--- 2.5.22/fs/buffer.c~mark_buffer_dirty_inode-speedup	Sun Jun 16 22:50:18 2002
+++ 2.5.22-akpm/fs/buffer.c	Sun Jun 16 23:22:47 2002
@@ -856,8 +856,9 @@ void mark_buffer_dirty_inode(struct buff
 		if (mapping->assoc_mapping != buffer_mapping)
 			BUG();
 	}
-	buffer_insert_list(&buffer_mapping->private_lock,
-			bh, &mapping->private_list);
+	if (list_empty(&bh->b_assoc_buffers))
+		buffer_insert_list(&buffer_mapping->private_lock,
+				bh, &mapping->private_list);
 }
 EXPORT_SYMBOL(mark_buffer_dirty_inode);
 
@@ -1243,10 +1244,17 @@ void __brelse(struct buffer_head * buf)
  * bforget() is like brelse(), except it discards any
  * potentially dirty data.
  */
-void __bforget(struct buffer_head * buf)
+void __bforget(struct buffer_head *bh)
 {
-	clear_buffer_dirty(buf);
-	__brelse(buf);
+	clear_buffer_dirty(bh);
+	if (!list_empty(&bh->b_assoc_buffers)) {
+		struct address_space *buffer_mapping = bh->b_page->mapping;
+
+		spin_lock(&buffer_mapping->private_lock);
+		list_del_init(&bh->b_assoc_buffers);
+		spin_unlock(&buffer_mapping->private_lock);
+	}
+	__brelse(bh);
 }
 
 /**

-
