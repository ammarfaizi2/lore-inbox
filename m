Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030396AbVKHXNX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030396AbVKHXNX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 18:13:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030401AbVKHXNX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 18:13:23 -0500
Received: from xproxy.gmail.com ([66.249.82.201]:14091 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030396AbVKHXNW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 18:13:22 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=mp8JLRRPxhuGQO2sw8O2YRg/XWkATATVXH9LqasLg1YvVmQl9upBClpsjwMpBVPHmbUAhZsafM1bJZ+ANv+t99dl6QW2ySfrUQUwLLQs1mq3qSXPlnXw5yRHXUfcEA9QXPNECYLyqM6mHNm3TUEgKlVy7IdgjU/bX0UJquKmL94=
Message-ID: <1e62d1370511081513p25f0c471y51a34cdcc8dc9e64@mail.gmail.com>
Date: Wed, 9 Nov 2005 04:13:22 +0500
From: Fawad Lateef <fawadlateef@gmail.com>
To: "ext3crypt@comcast.net" <ext3crypt@comcast.net>
Subject: Re: Guidance Please
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <110820051649.20930.4370D6FD0005672D000051C222007507849B9F979D0CCC9B980A@comcast.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <110820051649.20930.4370D6FD0005672D000051C222007507849B9F979D0CCC9B980A@comcast.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/8/05, ext3crypt@comcast.net <ext3crypt@comcast.net> wrote:
>
> My working assumptions are that submit_bh() sends an IO to the IO scheduler.
> The buffer_head that is passed to it gets mapped to a bio and submit_bio()
> then sends it forward to schedule the IO.
>

Yes, submit_bh sends request towards device for read/write !

<snip>

>
>
> I can only conclude that:
>
> submit_bh() does not initiate the block_IO; but I've read that it does so
> this is unlikely.
>

submit_bh will always send request for block_device instantly
(completion of request can be done later, but request will be sended
just after calling submit_bh)

> The block device driver somehow knows the address of the page that is mapped
> to the disk device and offset (or sector and size combination) then issues
> IO on the initial page address ot the one I sent in the buffer_head struct . . .
>

The bh (only) sent in submit_bh will always be used by block-device layer !

> Can someone point me in the right direction?  A simple "no it does not work
> that way" you need to look here, would be helpful. I've attached the source
> that I've modified see the __ext3_crypt_block_write_full_page().  Please
> ignore the prefix ext3_crypt on everything in the source, I'm using ext3 and
> needed a seperate branch to work modify without risking damage to ext3.
>

AFAIK you are doing the stuff/encryption at the right place, you code
might contain some bugs ... And why don't you just change the buffer
pointed by bh (original) just before calling submit_bh ? I don;t think
you need to allocate new one for you (and you might miss some-thing in
your own bh creation) ...

> The attachment is part of the fs/ext3-crypt/inode.c changes for writing.
>
>
> /* BEGIN ADDITIONS -- JGB

<code_snipped>

> static int __ext3_crypt_block_write_full_page(struct inode *inode,
>         struct page *page, get_block_t *get_block,
>         struct writeback_control *wbc)
> {
>         int err;
>         sector_t block;
>         sector_t last_block;
>         struct buffer_head *bh, *head;
>         struct buffer_head *bh_orig, *head_orig;
>         int nr_underway = 0;
>         struct page *tmp_page;
>
>         BUG_ON(!PageLocked(page));
>
>         last_block = (i_size_read(inode) - 1) >> inode->i_blkbits;
>
>         if (!page_has_buffers(page)) {
>                 create_empty_buffers(page, 1 << inode->i_blkbits,
>                                         (1 << BH_Dirty)|(1 << BH_Uptodate));
>         }
>
>         /*
>          * Be very careful.  We have no exclusion from __set_page_dirty_buffers
>          * here, and the (potentially unmapped) buffers may become dirty at
>          * any time.  If a buffer becomes dirty here after we've inspected it
>          * then we just miss that fact, and the page stays dirty.
>          *
>          * Buffers outside i_size may be dirtied by __set_page_dirty_buffers;
>          * handle that here by just cleaning them.
>          */
>
> // JGB -- Create a new page and copy the buffers to it to submit the copied
> //        buffers to bio.
>
>         // Allocate a page w/o starting FS IO in NORMAL ZONE
>         tmp_page = alloc_page(GFP_NOFS);
>         if (!tmp_page)
>                 {
>                 return -ENOMEM;
>                 }
>         // LOCK IT ?  -- mark clean to avoid flush? Uptodate?
>         // need to get_bh() for the new buffer_head. in copy_buffers too
>         lock_page(tmp_page);
>
>
>         __new_buffers(tmp_page, 1 << inode->i_blkbits,
>                 (1 << BH_Dirty)|(1 << BH_Uptodate));
>
>
>         __copy_buffers(tmp_page, page); // XOR ENCRYPT TOO
>
>
>         SetPageReferenced(tmp_page);
>         SetPageUptodate(tmp_page);
>         SetPageLRU(tmp_page);
>

I don't think you have to allocate and create a new bh for you, here !


> //      printk("\npage = %X\n",(unsigned int)page);
>         __dump_buffer_struct(page_buffers(page));
>
> //      printk("tmp_page = %X\n",(unsigned int)tmp_page);
>         __dump_buffer_struct(page_buffers(tmp_page));
>
> //      printk("P= %x  ;  T = %x\n",page->flags, tmp_page->flags);
>
>
>
>
>         block = page->index << (PAGE_CACHE_SHIFT - inode->i_blkbits);
>         //head = page_buffers(page);
>         head = page_buffers(tmp_page);
>         bh = head;
>         head_orig = page_buffers(page);
>         bh_orig = head;

The above line of code I think you want to be like ----- >>> bh_orig =
head_orig;   // not bh_orig = head;

>         /*
>          * Get all the dirty buffers mapped to disk addresses and
>          * handle any aliases from the underlying blockdev's mapping.
>          */
>         do {
>
>                 bh->b_state = bh_orig->b_state;
>                 bh->b_blocknr = bh_orig->b_blocknr;
>                 bh->b_bdev = bh_orig->b_bdev;
>                 bh->b_data = 0;
>
>
>                 if (block > last_block) {
>                         /*
>                          * mapped buffers outside i_size will occur, because
>                          * this page can be outside i_size when there is a
>                          * truncate in progress.
>                          */
>                         /*
>                          * The buffer was zeroed by block_write_full_page()
>                          */
>                         clear_buffer_dirty(bh);
>                         set_buffer_uptodate(bh);
>                 } else if (!buffer_mapped(bh) && buffer_dirty(bh)) {
>                         err = get_block(inode, block, bh, 1);
>                         if (err)
>                                 goto recover;
>                         if (buffer_new(bh)) {
>                                 /* blockdev mappings never come here */
>                                 clear_buffer_new(bh);
>                                 unmap_underlying_metadata(bh->b_bdev,
>                                                         bh->b_blocknr);
>                         }
>                 }
>                 bh = bh->b_this_page;
>                 bh_orig = bh_orig->b_this_page;
>                 block++;
>         } while (bh != head);
>
>         do {
>                 if (!buffer_mapped(bh))
>                         continue;
>                 /*
>                  * If it's a fully non-blocking write attempt and we cannot
>                  * lock the buffer then redirty the page.  Note that this can
>                  * potentially cause a busy-wait loop from pdflush and kswapd
>                  * activity, but those code paths have their own higher-level
>                  * throttling.
>                  */
>                 if (wbc->sync_mode != WB_SYNC_NONE || !wbc->nonblocking) {
>                         lock_buffer(bh);
>                 } else if (test_set_buffer_locked(bh)) {
>                         printk("Redirty page\n");
>                         redirty_page_for_writepage(wbc, tmp_page);
>                         continue;
>                 }
>                 if (test_clear_buffer_dirty(bh)) {
>                         mark_buffer_async_write(bh);
>                 } else {
>                         unlock_buffer(bh);
>                 }
>         } while ((bh = bh->b_this_page) != head);
>
>         /*
>          * The page and its buffers are protected by PageWriteback(), so we can
>          * drop the bh refcounts early.
>          */
>         BUG_ON(PageWriteback(page));
>         set_page_writeback(tmp_page);
>
>         do {
>                 struct buffer_head *next = bh->b_this_page;
>                 if (buffer_async_write(bh)) {
>                         submit_bh(WRITE, bh);
> //                      printk("BH = %X\n",(unsigned int)bh);
> //                      printk("Page = %X\n",(unsigned int)bh->b_page);
>                         printk("Buffer Page:\n");
>                         __dump_page_contents(bh->b_page);
>                         printk("Temp Page:\n");
>                         __dump_page_contents(tmp_page);
>                         printk("\n");
>                         nr_underway++;
>                 }
>                 bh = next;
>         } while (bh != head);
>         unlock_page(tmp_page);
>         unlock_page(page);
>
>         err = 0;
> done:
>         if (nr_underway == 0) {
>                 /*
>                  * The page was marked dirty, but the buffers were
>                  * clean.  Someone wrote them back by hand with
>                  * ll_rw_block/submit_bh.  A rare case.
>                  */
>                 int uptodate = 1;
>                 do {
>                         if (!buffer_uptodate(bh)) {
>                                 uptodate = 0;
>                                 break;
>                         }
>                         bh = bh->b_this_page;
>                 } while (bh != head);
>                 if (uptodate)
>                         {
>                         SetPageUptodate(page);
>                         SetPageUptodate(tmp_page);
>                         }
>                 end_page_writeback(tmp_page);
>                 /*
>                  * The page and buffer_heads can be released at any time from
>                  * here on.
>                  */
>                 wbc->pages_skipped++;   /* We didn't write this page */
>         }
>         return err;
>
> recover:
>         /*
>          * ENOSPC, or some other error.  We may already have added some
>          * blocks to the file, so we need to write these out to avoid
>          * exposing stale data.
>          * The page is currently locked and not marked for writeback
>          */
>         bh = head;
>         /* Recovery: lock and submit the mapped buffers */
>         do {
>                 if (buffer_mapped(bh) && buffer_dirty(bh)) {
>                         lock_buffer(bh);
>                         mark_buffer_async_write(bh);
>                 } else {
>                         /*
>                          * The buffer may have been set dirty during
>                          * attachment to a dirty page.
>                          */
>                         clear_buffer_dirty(bh);
>                 }
>         } while ((bh = bh->b_this_page) != head);
>         SetPageError(page);
>         BUG_ON(PageWriteback(page));
>         set_page_writeback(page);
>         unlock_page(page);
>         do {
>                 struct buffer_head *next = bh->b_this_page;
>                 if (buffer_async_write(bh)) {
>                         clear_buffer_dirty(bh);

Do your encryption here on the original bh->b_data or the bh->b_data
you are sending in submit_bh

>                         submit_bh(WRITE, bh);
>                         nr_underway++;
>                 }
>                 bh = next;
>         } while (bh != head);
>         goto done;
> }
>
>

I hope this will help !


--
Fawad Lateef
