Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130882AbQLDGc3>; Mon, 4 Dec 2000 01:32:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131048AbQLDGcU>; Mon, 4 Dec 2000 01:32:20 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:39135 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S130882AbQLDGcE>;
	Mon, 4 Dec 2000 01:32:04 -0500
Date: Mon, 4 Dec 2000 01:01:36 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] inode dirty blocks  Re: test12-pre4
In-Reply-To: <Pine.LNX.4.10.10012031828170.22914-100000@penguin.transmeta.com>
Message-ID: <Pine.GSO.4.21.0012040054400.5055-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 3 Dec 2000, Linus Torvalds wrote:

> 
> Synching up with Alan and various other stuff. The most important one
> being the fix to the inode dirty block list.

It doesn't solve the problem. If you unlink a file with dirty metadata
you have a nice chance to hit the BUG() in inode.c:83. I hope that patch
below closes all remaining holes. See analysis in previous posting
(basically, bforget() is not enough when we free the block; bh should
be removed from the inode's list regardless of the ->b_count).
							Cheers,
								Al

diff -urN rc12-pre4/fs/buffer.c rc12-pre4-dirty_blocks/fs/buffer.c
--- rc12-pre4/fs/buffer.c	Mon Dec  4 01:01:43 2000
+++ rc12-pre4-dirty_blocks/fs/buffer.c	Mon Dec  4 01:11:42 2000
@@ -1164,6 +1164,31 @@
 }
 
 /*
+ * Call it when you are going to free the block. The difference between
+ * that and bforget() is that we remove the thing from inode queue
+ * unconditionally.
+ */
+void bforget_inode(struct buffer_head * buf)
+{
+	/* grab the lru lock here to block bdflush. */
+	spin_lock(&lru_list_lock);
+	write_lock(&hash_table_lock);
+	remove_inode_queue(buf);
+	if (!atomic_dec_and_test(&buf->b_count) || buffer_locked(buf))
+		goto in_use;
+	__hash_unlink(buf);
+	write_unlock(&hash_table_lock);
+	__remove_from_lru_list(buf, buf->b_list);
+	spin_unlock(&lru_list_lock);
+	put_last_free(buf);
+	return;
+
+ in_use:
+	write_unlock(&hash_table_lock);
+	spin_unlock(&lru_list_lock);
+}
+
+/*
  * bread() reads a specified block and returns the buffer that contains
  * it. It returns NULL if the block was unreadable.
  */
@@ -1460,6 +1485,9 @@
 		clear_bit(BH_Mapped, &bh->b_state);
 		clear_bit(BH_Req, &bh->b_state);
 		clear_bit(BH_New, &bh->b_state);
+		spin_lock(&lru_list_lock);
+		remove_inode_queue(bh);
+		spin_unlock(&lru_list_lock);
 	}
 }
 
diff -urN rc12-pre4/fs/ext2/inode.c rc12-pre4-dirty_blocks/fs/ext2/inode.c
--- rc12-pre4/fs/ext2/inode.c	Mon Dec  4 01:01:43 2000
+++ rc12-pre4-dirty_blocks/fs/ext2/inode.c	Mon Dec  4 01:13:10 2000
@@ -416,7 +416,7 @@
 
 	/* Allocation failed, free what we already allocated */
 	for (i = 1; i < n; i++)
-		bforget(branch[i].bh);
+		bforget_inode(branch[i].bh);
 	for (i = 0; i < n; i++)
 		ext2_free_blocks(inode, le32_to_cpu(branch[i].key), 1);
 	return err;
@@ -484,7 +484,7 @@
 
 changed:
 	for (i = 1; i < num; i++)
-		bforget(where[i].bh);
+		bforget_inode(where[i].bh);
 	for (i = 0; i < num; i++)
 		ext2_free_blocks(inode, le32_to_cpu(where[i].key), 1);
 	return -EAGAIN;
@@ -854,7 +854,7 @@
 					   (u32*)bh->b_data,
 					   (u32*)bh->b_data + addr_per_block,
 					   depth);
-			bforget(bh);
+			bforget_inode(bh);
 			/* Writer: ->i_blocks */
 			inode->i_blocks -= inode->i_sb->s_blocksize / 512;
 			/* Writer: end */
diff -urN rc12-pre4/include/linux/fs.h rc12-pre4-dirty_blocks/include/linux/fs.h
--- rc12-pre4/include/linux/fs.h	Mon Dec  4 01:01:47 2000
+++ rc12-pre4-dirty_blocks/include/linux/fs.h	Mon Dec  4 01:12:03 2000
@@ -1201,6 +1201,7 @@
 		__brelse(buf);
 }
 extern void __bforget(struct buffer_head *);
+extern void bforget_inode(struct buffer_head *);
 static inline void bforget(struct buffer_head *buf)
 {
 	if (buf)
diff -urN rc12-pre4/kernel/ksyms.c rc12-pre4-dirty_blocks/kernel/ksyms.c
--- rc12-pre4/kernel/ksyms.c	Mon Dec  4 01:01:49 2000
+++ rc12-pre4-dirty_blocks/kernel/ksyms.c	Mon Dec  4 01:12:19 2000
@@ -188,6 +188,7 @@
 EXPORT_SYMBOL(breada);
 EXPORT_SYMBOL(__brelse);
 EXPORT_SYMBOL(__bforget);
+EXPORT_SYMBOL(bforget_inode);
 EXPORT_SYMBOL(ll_rw_block);
 EXPORT_SYMBOL(__wait_on_buffer);
 EXPORT_SYMBOL(___wait_on_page);

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
