Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261310AbULWVio@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261310AbULWVio (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Dec 2004 16:38:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261311AbULWVio
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Dec 2004 16:38:44 -0500
Received: from 10fwd.cistron-office.nl ([62.216.29.197]:44758 "EHLO
	smtp.cistron-office.nl") by vger.kernel.org with ESMTP
	id S261310AbULWVib (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Dec 2004 16:38:31 -0500
From: "Miquel van Smoorenburg" <miquels@cistron.net>
To: mason@suse.com
Subject: Re: [PATCH] __getblk_slow can loop forever when pages are partially mapped
X-Newsgroups: lists.linux.kernel
In-Reply-To: <1102711728.4957.159.camel@watt.suse.com>
Organization: Cistron Group
Cc: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <E1Chaf0-0006Fv-00@subspace.cistron-office.nl>
Date: Thu, 23 Dec 2004 22:38:14 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <1102711728.4957.159.camel@watt.suse.com> you write:
>When a block device is accessed via read/write, it is possible
>for some of the buffers on a page to be mapped and others not.  __getblk
>and friends assume this can't happen, and can end up looping forever
>when pages have some unmapped buffers.
>
>The fix below has two parts.  First, it changes __find_get_block
>to avoid the buffer_error warnings when it finds unmapped buffers
>on the page.  
>
>Second, it changes grow_dev_page to map the buffers on the page
>by calling init_page_buffers.  init_page_buffers is changed so
>we don't stomp on uptodate bits for the buffers

I just upgraded a server with a 2.4.22 kernel and blocksize 1K ext2
filesystems to 2.6.10-rc3. Before I rebooted, I did a
"tune2fs -j /dev/hda1" (etc) to move from ext2 to ext3 on /,
/usr, /var and /home.

When the new kernel was supposed to mount the root
filesystem, it kept on spewing the message

Blocksize 1024
__getblk_slow failed

I booted back to 2.4.22, applied the patch below, booted to
2.6.10-rc3 + patch, and now it's running just fine.

I don't see anything like the patch below in 2.6.10-rc3-bk16 yet ?




>Index: linux.mm/fs/buffer.c
>===================================================================
>--- linux.mm.orig/fs/buffer.c	2004-12-10 09:44:34.000000000 -0500
>+++ linux.mm/fs/buffer.c	2004-12-10 11:22:23.000000000 -0500
>@@ -426,6 +426,7 @@ __find_get_block_slow(struct block_devic
> 	struct buffer_head *bh;
> 	struct buffer_head *head;
> 	struct page *page;
>+	int all_mapped = 1;
> 
> 	index = block >> (PAGE_CACHE_SHIFT - bd_inode->i_blkbits);
> 	page = find_get_page(bd_mapping, index);
>@@ -443,14 +444,23 @@ __find_get_block_slow(struct block_devic
> 			get_bh(bh);
> 			goto out_unlock;
> 		}
>+		if (!buffer_mapped(bh))
>+			all_mapped = 0;
> 		bh = bh->b_this_page;
> 	} while (bh != head);
> 
>-	printk("__find_get_block_slow() failed. "
>-		"block=%llu, b_blocknr=%llu\n",
>-		(unsigned long long)block, (unsigned long long)bh->b_blocknr);
>-	printk("b_state=0x%08lx, b_size=%u\n", bh->b_state, bh->b_size);
>-	printk("device blocksize: %d\n", 1 << bd_inode->i_blkbits);
>+	/* we might be here because some of the buffers on this page are 
>+	 * not mapped.  This is due to various races between
>+	 * file io on the block device and getblk.  It gets dealt with
>+	 * elsewhere, don't buffer_error if we had some unmapped buffers
>+	 */
>+	if (all_mapped) {
>+		printk("__find_get_block_slow() failed. "
>+			"block=%llu, b_blocknr=%llu\n",
>+			(unsigned long long)block, (unsigned long long)bh->b_blocknr);
>+		printk("b_state=0x%08lx, b_size=%u\n", bh->b_state, bh->b_size);
>+		printk("device blocksize: %d\n", 1 << bd_inode->i_blkbits);
>+	}
> out_unlock:
> 	spin_unlock(&bd_mapping->private_lock);
> 	page_cache_release(page);
>@@ -1098,18 +1108,16 @@ init_page_buffers(struct page *page, str
> {
> 	struct buffer_head *head = page_buffers(page);
> 	struct buffer_head *bh = head;
>-	unsigned int b_state;
>-
>-	b_state = 1 << BH_Mapped;
>-	if (PageUptodate(page))
>-		b_state |= 1 << BH_Uptodate;
>+	int uptodate = PageUptodate(page);
> 
> 	do {
>-		if (!(bh->b_state & (1 << BH_Mapped))) {
>+		if (!buffer_mapped(bh)) {
> 			init_buffer(bh, NULL, NULL);
> 			bh->b_bdev = bdev;
> 			bh->b_blocknr = block;
>-			bh->b_state = b_state;
>+			if (uptodate)
>+				set_buffer_uptodate(bh);
>+			set_buffer_mapped(bh);
> 		}
> 		block++;
> 		bh = bh->b_this_page;
>@@ -1138,8 +1146,10 @@ grow_dev_page(struct block_device *bdev,
> 
> 	if (page_has_buffers(page)) {
> 		bh = page_buffers(page);
>-		if (bh->b_size == size)
>+		if (bh->b_size == size) {
>+			init_page_buffers(page, bdev, block, size);
> 			return page;
>+		}
> 		if (!try_to_free_buffers(page))
> 			goto failed;
> 	}
>
>
