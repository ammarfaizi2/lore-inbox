Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261181AbULJUqV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261181AbULJUqV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Dec 2004 15:46:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261167AbULJUqV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Dec 2004 15:46:21 -0500
Received: from mail.suse.de ([195.135.220.2]:25780 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261189AbULJUqB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Dec 2004 15:46:01 -0500
Subject: [PATCH] __getblk_slow can loop forever when pages are partially
	mapped
From: Chris Mason <mason@suse.com>
To: linux-kernel@vger.kernel.org, akpm@osdl.org
Content-Type: text/plain
Date: Fri, 10 Dec 2004 15:48:48 -0500
Message-Id: <1102711728.4957.159.camel@watt.suse.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When a block device is accessed via read/write, it is possible
for some of the buffers on a page to be mapped and others not.  __getblk
and friends assume this can't happen, and can end up looping forever
when pages have some unmapped buffers.  Picture:

lseek(/dev/xxx, 2048, SEEK_SET)
write(/dev/xxx, 2048 bytes)

Assuming the block size is 1k, page 0 has 4 buffers, two are mapped
by __block_prepare_write and two are not.  Next, another process
triggers getblk(/dev/xxx, blocknr = 0);

__getblk_slow will loop forever.  __find_get_block fails because
the buffer isn't mapped.  grow_dev_page does nothing because
there are buffers on the page with the correct size.  
madhav@veritas.com and others at Veritas tracked this down.

The fix below has two parts.  First, it changes __find_get_block
to avoid the buffer_error warnings when it finds unmapped buffers
on the page.  

Second, it changes grow_dev_page to map the buffers on the page
by calling init_page_buffers.  init_page_buffers is changed so
we don't stomp on uptodate bits for the buffers

Index: linux.mm/fs/buffer.c
===================================================================
--- linux.mm.orig/fs/buffer.c	2004-12-10 09:44:34.000000000 -0500
+++ linux.mm/fs/buffer.c	2004-12-10 11:22:23.000000000 -0500
@@ -426,6 +426,7 @@ __find_get_block_slow(struct block_devic
 	struct buffer_head *bh;
 	struct buffer_head *head;
 	struct page *page;
+	int all_mapped = 1;
 
 	index = block >> (PAGE_CACHE_SHIFT - bd_inode->i_blkbits);
 	page = find_get_page(bd_mapping, index);
@@ -443,14 +444,23 @@ __find_get_block_slow(struct block_devic
 			get_bh(bh);
 			goto out_unlock;
 		}
+		if (!buffer_mapped(bh))
+			all_mapped = 0;
 		bh = bh->b_this_page;
 	} while (bh != head);
 
-	printk("__find_get_block_slow() failed. "
-		"block=%llu, b_blocknr=%llu\n",
-		(unsigned long long)block, (unsigned long long)bh->b_blocknr);
-	printk("b_state=0x%08lx, b_size=%u\n", bh->b_state, bh->b_size);
-	printk("device blocksize: %d\n", 1 << bd_inode->i_blkbits);
+	/* we might be here because some of the buffers on this page are 
+	 * not mapped.  This is due to various races between
+	 * file io on the block device and getblk.  It gets dealt with
+	 * elsewhere, don't buffer_error if we had some unmapped buffers
+	 */
+	if (all_mapped) {
+		printk("__find_get_block_slow() failed. "
+			"block=%llu, b_blocknr=%llu\n",
+			(unsigned long long)block, (unsigned long long)bh->b_blocknr);
+		printk("b_state=0x%08lx, b_size=%u\n", bh->b_state, bh->b_size);
+		printk("device blocksize: %d\n", 1 << bd_inode->i_blkbits);
+	}
 out_unlock:
 	spin_unlock(&bd_mapping->private_lock);
 	page_cache_release(page);
@@ -1098,18 +1108,16 @@ init_page_buffers(struct page *page, str
 {
 	struct buffer_head *head = page_buffers(page);
 	struct buffer_head *bh = head;
-	unsigned int b_state;
-
-	b_state = 1 << BH_Mapped;
-	if (PageUptodate(page))
-		b_state |= 1 << BH_Uptodate;
+	int uptodate = PageUptodate(page);
 
 	do {
-		if (!(bh->b_state & (1 << BH_Mapped))) {
+		if (!buffer_mapped(bh)) {
 			init_buffer(bh, NULL, NULL);
 			bh->b_bdev = bdev;
 			bh->b_blocknr = block;
-			bh->b_state = b_state;
+			if (uptodate)
+				set_buffer_uptodate(bh);
+			set_buffer_mapped(bh);
 		}
 		block++;
 		bh = bh->b_this_page;
@@ -1138,8 +1146,10 @@ grow_dev_page(struct block_device *bdev,
 
 	if (page_has_buffers(page)) {
 		bh = page_buffers(page);
-		if (bh->b_size == size)
+		if (bh->b_size == size) {
+			init_page_buffers(page, bdev, block, size);
 			return page;
+		}
 		if (!try_to_free_buffers(page))
 			goto failed;
 	}


