Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131651AbRCSXTt>; Mon, 19 Mar 2001 18:19:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131665AbRCSXTc>; Mon, 19 Mar 2001 18:19:32 -0500
Received: from roc-24-169-102-121.rochester.rr.com ([24.169.102.121]:45574
	"EHLO roc-24-169-102-121.rochester.rr.com") by vger.kernel.org
	with ESMTP id <S131651AbRCSXTP>; Mon, 19 Mar 2001 18:19:15 -0500
Date: Mon, 19 Mar 2001 18:18:26 -0500
From: Chris Mason <mason@suse.com>
To: linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
Subject: [PATCH] reiserfs tail bugs
Message-ID: <127790000.985043906@tiny>
X-Mailer: Mulberry/2.0.6b4 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello everyone,

This patch should close out the last known tail bug in my
queue.  If you've still got small reiserfs files with the wrong
data in them, please start shouting.  

The patch isn't very big, but changes some sensitive areas, 
so I'm looking for more success reports on non-critical data 
before inclusion anywhere else.

Short version: mozilla's elf-dynstr-gc could segfault if stripping
a small lib with tails turned on.  You hit the bug when you
pack the tail, mmap & modify tail bytes, and truncate to some size
still inside the tail.  Patch is below.

Long version:

1) _get_block_create_0 should not read the tail off disk when 
the buffer is already up to date.  The tail code maps tail 
buffers in the page cache to block 0.  In some cases, 
_get_block_create_0 gets called on an unmapped, up to date page 
buffer,  with more recent data than the stuff in buffer cache.

2) Due to tail padding, direct items might have more bytes than 
the file actually holds.  In odd corruption cases, there might 
be more direct bytes than there are bytes in the file.  When the
truncate code reads the tail in, i_size can be smaller than the 
direct item.

In other words, _get_block_create_0 might not want to read the 
entire direct item off disk.  New code added to make sure we don't 
copy bytes past the end of the file into the page.

3) reiserfs_vfs_truncate file would zero the truncated bytes for 
partial blocks in the page only when truncating from an indirect item.  
It needs to zero the page for direct items too (to make sure the padded 
bytes are zero).

4) flush_dcache_page added to _get_block_create_0.

5) buffers in the page cache are now marked up to date by
reiserfs_write_full_page as it maps/flushes them.

Patch against 2.4.3-pre3 (should be fine on pre4 too).

-chris

--- linux.1/fs/reiserfs/inode.c	Sat Mar 17 14:13:34 2001
+++ linux/fs/reiserfs/inode.c	Mon Mar 19 01:29:08 2001
@@ -304,6 +304,7 @@
     char * p = NULL;
     int chars;
     int ret ;
+    int done = 0 ;
     unsigned long offset ;
 
     // prepare the key to look for the 'block'-th block of file
@@ -355,6 +356,14 @@
 	return -ENOENT;
     }
 
+    /* if we've got a direct item, and the buffer was uptodate,
+    ** we don't want to pull data off disk again.  skip to the
+    ** end, where we map the buffer and return
+    */
+    if (buffer_uptodate(bh_result)) {
+        goto finished ;
+    }
+
     // read file tail into part of page
     offset = (cpu_key_k_offset(&key) - 1) & (PAGE_CACHE_SIZE - 1) ;
     fs_gen = get_generation(inode->i_sb) ;
@@ -375,8 +384,24 @@
 	if (!is_direct_le_ih (ih)) {
 	    BUG ();
         }
-	chars = le16_to_cpu (ih->ih_item_len) - path.pos_in_item;
+	/* make sure we don't read more bytes than actually exist in
+	** the file.  This can happen in odd cases where i_size isn't
+	** correct, and when direct item padding results in a few 
+	** extra bytes at the end of the direct item
+	*/
+        if ((le_ih_k_offset(ih) + path.pos_in_item) > inode->i_size)
+	    break ;
+	if ((le_ih_k_offset(ih) - 1 + ih_item_len(ih)) > inode->i_size) {
+	    chars = inode->i_size - (le_ih_k_offset(ih) - 1) - path.pos_in_item;
+	    done = 1 ;
+	} else {
+	    chars = le16_to_cpu (ih->ih_item_len) - path.pos_in_item;
+	}
 	memcpy (p, B_I_PITEM (bh, ih) + path.pos_in_item, chars);
+
+	if (done) 
+	    break ;
+
 	p += chars;
 
 	if (PATH_LAST_POSITION (&path) != (B_NR_ITEMS (bh) - 1))
@@ -395,16 +420,14 @@
 	ih = get_ih (&path);
     } while (1);
 
+finished:
     pathrelse (&path);
-    
-    // FIXME: b_blocknr == 0 here. but b_data contains correct data
-    // from tail. ll_rw_block will skip uptodate buffers
     bh_result->b_blocknr = 0 ;
     bh_result->b_dev = inode->i_dev;
     mark_buffer_uptodate (bh_result, 1);
     bh_result->b_state |= (1UL << BH_Mapped);
+    flush_dcache_page(bh_result->b_page) ;
     kunmap(bh_result->b_page) ;
-
     return 0;
 }
 
@@ -1567,8 +1590,9 @@
     /* so, if page != NULL, we have a buffer head for the offset at 
     ** the end of the file. if the bh is mapped, and bh->b_blocknr != 0, 
     ** then we have an unformatted node.  Otherwise, we have a direct item, 
-    ** and no zeroing is required.  We zero after the truncate, because the 
-    ** truncate might pack the item anyway (it will unmap bh if it packs).
+    ** and no zeroing is required on disk.  We zero after the truncate, 
+    ** because the truncate might pack the item anyway 
+    ** (it will unmap bh if it packs).
     */
     prevent_flush_page_lock(page, p_s_inode) ;
     journal_begin(&th, p_s_inode->i_sb,  JOURNAL_PER_BALANCE_CNT * 2 ) ;
@@ -1578,7 +1602,7 @@
     journal_end(&th, p_s_inode->i_sb,  JOURNAL_PER_BALANCE_CNT * 2 ) ;
     allow_flush_page_lock(page, p_s_inode) ;
 
-    if (page && buffer_mapped(bh) && bh->b_blocknr != 0) {
+    if (page) {
         length = offset & (blocksize - 1) ;
 	/* if we are not on a block boundary */
 	if (length) {
@@ -1586,14 +1610,14 @@
 	    memset((char *)kmap(page) + offset, 0, length) ;   
 	    flush_dcache_page(page) ;
 	    kunmap(page) ;
-	    mark_buffer_dirty(bh) ;
+	    if (buffer_mapped(bh) && bh->b_blocknr != 0) {
+	        mark_buffer_dirty(bh) ;
+	    }
 	}
-    } 
-
-    if (page) {
 	UnlockPage(page) ;
 	page_cache_release(page) ;
     }
+
     return ;
 }
 
@@ -1646,6 +1670,7 @@
 	    goto out ;
 	}
 	set_block_dev_mapped(bh_result, le32_to_cpu(item[pos_in_item]), inode);
+	mark_buffer_uptodate(bh_result, 1);
     } else if (is_direct_le_ih(ih)) {
         char *p ; 
         p = page_address(bh_result->b_page) ;
@@ -1665,6 +1690,7 @@
 	journal_mark_dirty(&th, inode->i_sb, bh) ;
 	bytes_copied += copy_size ;
 	set_block_dev_mapped(bh_result, 0, inode);
+	mark_buffer_uptodate(bh_result, 1);
 
 	/* are there still bytes left? */
         if (bytes_copied < bh_result->b_size && 

