Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131100AbQLEEue>; Mon, 4 Dec 2000 23:50:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131150AbQLEEuZ>; Mon, 4 Dec 2000 23:50:25 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:24315 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S131100AbQLEEuV>;
	Mon, 4 Dec 2000 23:50:21 -0500
Date: Mon, 4 Dec 2000 23:19:51 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Andrew Morton <andrewm@uow.edu.au>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] inode dirty blocks
In-Reply-To: <Pine.LNX.4.10.10012041945470.860-100000@penguin.transmeta.com>
Message-ID: <Pine.GSO.4.21.0012042305250.7166-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 4 Dec 2000, Linus Torvalds wrote:

> I just wanted to be clear on the purpose of the patches. The bforget() one
> looks like "taking care of the details", but not like a bug-fix. Agreed?

Agreed - invalidate_inode_buffers() seems to be doing the right thing,
so previous objections do not apply.
 
> > We can survive without them (modulo patch to clear_inode()), but...
> 
> The "patch to clean-inode" is the one I already did from sct? Or are we
> talking about another issue?

No, the same one. I missed the invalidate_inode_buffers() bit.

> > BTW, there is another reason why we want to have separate function
> > for freeing the stuff: we may want to mark them clean. If they are
> > already under IO it will do nothing, but if they are merely dirty...
> 
> Yes. Make it so. In the meantime, does everybody agree that pre5 fixes the
> bugs, even though it still has these discussion items left?

With respect to dirty blocks - hopefully yes.
							Cheers,
								Al
PS: bforget patch (with mark_buffer_clean() added) follows. And yes, it's
optimization and not a bug-fix.

diff -urN rc12-pre5/fs/buffer.c rc12-pre5-dirty_blocks/fs/buffer.c
--- rc12-pre5/fs/buffer.c	Tue Dec  5 02:03:14 2000
+++ rc12-pre5-dirty_blocks/fs/buffer.c	Tue Dec  5 02:40:16 2000
@@ -1164,6 +1164,32 @@
 }
 
 /*
+ * Call it when you are going to free the block. The difference between
+ * that and bforget() is that we remove the thing from inode queue
+ * unconditionally and mark it clean.
+ */
+void bforget_inode(struct buffer_head * buf)
+{
+	mark_buffer_clean(buf);
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
@@ -1460,6 +1486,9 @@
 		clear_bit(BH_Mapped, &bh->b_state);
 		clear_bit(BH_Req, &bh->b_state);
 		clear_bit(BH_New, &bh->b_state);
+		spin_lock(&lru_list_lock);
+		remove_inode_queue(bh);
+		spin_unlock(&lru_list_lock);
 	}
 }
 
diff -urN rc12-pre5/fs/ext2/inode.c rc12-pre5-dirty_blocks/fs/ext2/inode.c
--- rc12-pre5/fs/ext2/inode.c	Tue Dec  5 02:03:14 2000
+++ rc12-pre5-dirty_blocks/fs/ext2/inode.c	Tue Dec  5 02:37:59 2000
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
diff -urN rc12-pre5/include/linux/fs.h rc12-pre5-dirty_blocks/include/linux/fs.h
--- rc12-pre5/include/linux/fs.h	Tue Dec  5 02:03:19 2000
+++ rc12-pre5-dirty_blocks/include/linux/fs.h	Tue Dec  5 02:37:59 2000
@@ -1201,6 +1201,7 @@
 		__brelse(buf);
 }
 extern void __bforget(struct buffer_head *);
+extern void bforget_inode(struct buffer_head *);
 static inline void bforget(struct buffer_head *buf)
 {
 	if (buf)
diff -urN rc12-pre5/kernel/ksyms.c rc12-pre5-dirty_blocks/kernel/ksyms.c
--- rc12-pre5/kernel/ksyms.c	Tue Dec  5 02:03:20 2000
+++ rc12-pre5-dirty_blocks/kernel/ksyms.c	Tue Dec  5 02:38:00 2000
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
