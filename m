Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263989AbUDNIqK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 04:46:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263990AbUDNIqJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 04:46:09 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:30597 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263989AbUDNIpg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 04:45:36 -0400
Message-ID: <407CFA21.5020209@pobox.com>
Date: Wed, 14 Apr 2004 04:45:21 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] conditionalize some boring buffer_head checks
References: <407CEB91.1080503@pobox.com>	<20040414005832.083de325.akpm@osdl.org>	<20040414010240.0e9f4115.akpm@osdl.org>	<407CF201.408@pobox.com> <20040414011653.22c690d9.akpm@osdl.org>
In-Reply-To: <20040414011653.22c690d9.akpm@osdl.org>
Content-Type: multipart/mixed;
 boundary="------------040907090406060803040704"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040907090406060803040704
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Andrew Morton wrote:
> Jeff Garzik <jgarzik@pobox.com> wrote:
> 
>>I would rather not kill the code in submit_bh() outright, just disable 
>> it for non-filesystem developers.
> 
> 
> submit_bh() is a slowpath ;) The one in mark_buffer_dirty() will be called

Ah, indeed.


> more often, possibly others.  Kill!

Overkill?  (attached)  I didn't mess with the BUG_ON's in submit_bh this 
time, just buffer_error() stuff.

	Jeff



--------------040907090406060803040704
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

===== fs/buffer.c 1.237 vs edited =====
--- 1.237/fs/buffer.c	Wed Apr 14 03:18:09 2004
+++ edited/fs/buffer.c	Wed Apr 14 04:32:02 2004
@@ -51,25 +51,6 @@
 	wait_queue_head_t wqh;
 } ____cacheline_aligned_in_smp bh_wait_queue_heads[1<<BH_WAIT_TABLE_ORDER];
 
-/*
- * Debug/devel support stuff
- */
-
-void __buffer_error(char *file, int line)
-{
-	static int enough;
-
-	if (enough > 10)
-		return;
-	enough++;
-	printk("buffer layer error at %s:%d\n", file, line);
-#ifndef CONFIG_KALLSYMS
-	printk("Pass this trace through ksymoops for reporting\n");
-#endif
-	dump_stack();
-}
-EXPORT_SYMBOL(__buffer_error);
-
 inline void
 init_buffer(struct buffer_head *bh, bh_end_io_t *handler, void *private)
 {
@@ -99,17 +80,6 @@
 
 void fastcall unlock_buffer(struct buffer_head *bh)
 {
-	/*
-	 * unlock_buffer against a zero-count bh is a bug, if the page
-	 * is not locked.  Because then nothing protects the buffer's
-	 * waitqueue, which is used here. (Well.  Other locked buffers
-	 * against the page will pin it.  But complain anyway).
-	 */
-	if (atomic_read(&bh->b_count) == 0 &&
-			!PageLocked(bh->b_page) &&
-			!PageWriteback(bh->b_page))
-		buffer_error();
-
 	clear_buffer_locked(bh);
 	smp_mb__after_clear_bit();
 	wake_up_buffer(bh);
@@ -125,10 +95,6 @@
 	wait_queue_head_t *wqh = bh_waitq_head(bh);
 	DEFINE_WAIT(wait);
 
-	if (atomic_read(&bh->b_count) == 0 &&
-			(!bh->b_page || !PageLocked(bh->b_page)))
-		buffer_error();
-
 	do {
 		prepare_to_wait(wqh, &wait, TASK_UNINTERRUPTIBLE);
 		if (buffer_locked(bh)) {
@@ -146,8 +112,6 @@
 static void
 __set_page_buffers(struct page *page, struct buffer_head *head)
 {
-	if (page_has_buffers(page))
-		buffer_error();
 	page_cache_get(page);
 	SetPagePrivate(page);
 	page->private = (unsigned long)head;
@@ -433,7 +397,8 @@
 		}
 		bh = bh->b_this_page;
 	} while (bh != head);
-	buffer_error();
+
+	BUG();
 	printk("block=%llu, b_blocknr=%llu\n",
 		(unsigned long long)block, (unsigned long long)bh->b_blocknr);
 	printk("b_state=0x%08lx, b_size=%u\n", bh->b_state, bh->b_size);
@@ -847,10 +812,7 @@
 		struct buffer_head *bh = head;
 
 		do {
-			if (buffer_uptodate(bh))
-				set_buffer_dirty(bh);
-			else
-				buffer_error();
+			set_buffer_dirty(bh);
 			bh = bh->b_this_page;
 		} while (bh != head);
 	}
@@ -1151,7 +1113,7 @@
 	return page;
 
 failed:
-	buffer_error();
+	BUG();
 	unlock_page(page);
 	page_cache_release(page);
 	return NULL;
@@ -1247,8 +1209,6 @@
  */
 void fastcall mark_buffer_dirty(struct buffer_head *bh)
 {
-	if (!buffer_uptodate(bh))
-		buffer_error();
 	if (!buffer_dirty(bh) && !test_set_buffer_dirty(bh))
 		__set_page_dirty_nobuffers(bh->b_page);
 }
@@ -1267,7 +1227,7 @@
 		return;
 	}
 	printk(KERN_ERR "VFS: brelse: Trying to free free buffer\n");
-	buffer_error();		/* For the stack backtrace */
+	BUG();
 }
 
 /*
@@ -1294,8 +1254,6 @@
 		unlock_buffer(bh);
 		return bh;
 	} else {
-		if (buffer_dirty(bh))
-			buffer_error();
 		get_bh(bh);
 		bh->b_end_io = end_buffer_read_sync;
 		submit_bh(READ, bh);
@@ -1737,8 +1695,6 @@
 	last_block = (i_size_read(inode) - 1) >> inode->i_blkbits;
 
 	if (!page_has_buffers(page)) {
-		if (!PageUptodate(page))
-			buffer_error();
 		create_empty_buffers(page, 1 << inode->i_blkbits,
 					(1 << BH_Dirty)|(1 << BH_Uptodate));
 	}
@@ -1777,8 +1733,6 @@
 			clear_buffer_dirty(bh);
 			set_buffer_uptodate(bh);
 		} else if (!buffer_mapped(bh) && buffer_dirty(bh)) {
-			if (buffer_new(bh))
-				buffer_error();
 			err = get_block(inode, block, bh, 1);
 			if (err)
 				goto recover;
@@ -1811,8 +1765,6 @@
 			continue;
 		}
 		if (test_clear_buffer_dirty(bh)) {
-			if (!buffer_uptodate(bh))
-				buffer_error();
 			mark_buffer_async_write(bh);
 		} else {
 			unlock_buffer(bh);
@@ -1942,8 +1894,6 @@
 				unmap_underlying_metadata(bh->b_bdev,
 							bh->b_blocknr);
 				if (PageUptodate(page)) {
-					if (!buffer_mapped(bh))
-						buffer_error();
 					set_buffer_uptodate(bh);
 					continue;
 				}
@@ -2001,8 +1951,6 @@
 			void *kaddr;
 
 			clear_buffer_new(bh);
-			if (buffer_uptodate(bh))
-				buffer_error();
 			kaddr = kmap_atomic(page, KM_USER0);
 			memset(kaddr+block_start, 0, bh->b_size);
 			kunmap_atomic(kaddr, KM_USER0);
@@ -2068,8 +2016,6 @@
 
 	if (!PageLocked(page))
 		PAGE_BUG(page);
-	if (PageUptodate(page))
-		buffer_error();
 	blocksize = 1 << inode->i_blkbits;
 	if (!page_has_buffers(page))
 		create_empty_buffers(page, blocksize, 0);
@@ -2692,13 +2638,6 @@
 	BUG_ON(!buffer_mapped(bh));
 	BUG_ON(!bh->b_end_io);
 
-	if ((rw == READ || rw == READA) && buffer_uptodate(bh))
-		buffer_error();
-	if (rw == WRITE && !buffer_uptodate(bh))
-		buffer_error();
-	if (rw == READ && buffer_dirty(bh))
-		buffer_error();
-
 	/* Only clear out a write error when rewriting */
 	if (test_set_buffer_req(bh) && rw == WRITE)
 		clear_buffer_write_io_error(bh);
@@ -2798,21 +2737,6 @@
 }
 
 /*
- * Sanity checks for try_to_free_buffers.
- */
-static void check_ttfb_buffer(struct page *page, struct buffer_head *bh)
-{
-	if (!buffer_uptodate(bh) && !buffer_req(bh)) {
-		if (PageUptodate(page) && page->mapping
-			&& buffer_mapped(bh)	/* discard_buffer */
-			&& S_ISBLK(page->mapping->host->i_mode))
-		{
-			buffer_error();
-		}
-	}
-}
-
-/*
  * try_to_free_buffers() checks if all the buffers on this particular page
  * are unused, and releases them if so.
  *
@@ -2847,7 +2771,6 @@
 
 	bh = head;
 	do {
-		check_ttfb_buffer(page, bh);
 		if (buffer_write_io_error(bh))
 			set_bit(AS_EIO, &page->mapping->flags);
 		if (buffer_busy(bh))
@@ -2856,9 +2779,6 @@
 			was_uptodate = 0;
 		bh = bh->b_this_page;
 	} while (bh != head);
-
-	if (!was_uptodate && PageUptodate(page) && !PageError(page))
-		buffer_error();
 
 	do {
 		struct buffer_head *next = bh->b_this_page;
===== fs/mpage.c 1.54 vs edited =====
--- 1.54/fs/mpage.c	Mon Apr 12 13:54:41 2004
+++ edited/fs/mpage.c	Wed Apr 14 04:33:06 2004
@@ -485,8 +485,7 @@
 			break;
 		block_in_file++;
 	}
-	if (page_block == 0)
-		buffer_error();
+	BUG_ON(page_block == 0);
 
 	first_unmapped = page_block;
 
===== fs/ext3/inode.c 1.90 vs edited =====
--- 1.90/fs/ext3/inode.c	Tue Jan 20 20:58:53 2004
+++ edited/fs/ext3/inode.c	Wed Apr 14 04:33:34 2004
@@ -1358,8 +1358,6 @@
 	}
 
 	if (!page_has_buffers(page)) {
-		if (!PageUptodate(page))
-			buffer_error();
 		create_empty_buffers(page, inode->i_sb->s_blocksize,
 				(1 << BH_Dirty)|(1 << BH_Uptodate));
 	}
===== fs/ntfs/aops.c 1.96 vs edited =====
--- 1.96/fs/ntfs/aops.c	Mon Apr 12 13:54:35 2004
+++ edited/fs/ntfs/aops.c	Wed Apr 14 04:33:30 2004
@@ -1340,8 +1340,6 @@
 			void *kaddr;
 
 			clear_buffer_new(bh);
-			if (buffer_uptodate(bh))
-				buffer_error();
 			kaddr = kmap_atomic(page, KM_USER0);
 			memset(kaddr + block_start, 0, bh->b_size);
 			kunmap_atomic(kaddr, KM_USER0);
===== fs/reiserfs/inode.c 1.97 vs edited =====
--- 1.97/fs/reiserfs/inode.c	Mon Apr 12 13:54:58 2004
+++ edited/fs/reiserfs/inode.c	Wed Apr 14 04:33:23 2004
@@ -1925,7 +1925,6 @@
     th.t_trans_id = 0;
 
     if (!buffer_uptodate(bh_result)) {
-        buffer_error();
 	return -EIO;
     }
 
@@ -2057,8 +2056,6 @@
      * in the BH_Uptodate is just a sanity check.
      */
     if (!page_has_buffers(page)) {
-	if (!PageUptodate(page))
-	    buffer_error();
 	create_empty_buffers(page, inode->i_sb->s_blocksize, 
 	                    (1 << BH_Dirty) | (1 << BH_Uptodate));
     }
@@ -2120,8 +2117,6 @@
 	    }
 	}
 	if (test_clear_buffer_dirty(bh)) {
-	    if (!buffer_uptodate(bh))
-		buffer_error();
 	    mark_buffer_async_write(bh);
 	} else {
 	    unlock_buffer(bh);
===== include/linux/buffer_head.h 1.47 vs edited =====
--- 1.47/include/linux/buffer_head.h	Wed Apr 14 03:18:09 2004
+++ edited/include/linux/buffer_head.h	Wed Apr 14 04:32:14 2004
@@ -62,13 +62,6 @@
 };
 
 /*
- * Debug
- */
-
-void __buffer_error(char *file, int line);
-#define buffer_error() __buffer_error(__FILE__, __LINE__)
-
-/*
  * macro tricks to expand the set_buffer_foo(), clear_buffer_foo()
  * and buffer_foo() functions.
  */

--------------040907090406060803040704--

