Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261867AbVD0SAx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261867AbVD0SAx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 14:00:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261857AbVD0SAK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 14:00:10 -0400
Received: from fire.osdl.org ([65.172.181.4]:20639 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261852AbVD0R5Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 13:57:24 -0400
Date: Wed, 27 Apr 2005 10:56:55 -0700
From: Andrew Morton <akpm@osdl.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: andrea@suse.de, linux-kernel@vger.kernel.org, mason@suse.com
Subject: Re: [patch] fix the 2nd buffer race properly
Message-Id: <20050427105655.5edc13ce.akpm@osdl.org>
In-Reply-To: <426F908C.2060804@yahoo.com.au>
References: <426F908C.2060804@yahoo.com.au>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <nickpiggin@yahoo.com.au> wrote:
>
> When running
>  	fsstress -v -d $DIR/tmp -n 1000 -p 1000 -l 2
>  on an ext2 filesystem with 1024 byte block size, on SMP i386 with 4096 byte
>  page size over loopback to an image file on a tmpfs filesystem, I would
>  very quickly hit
>  	BUG_ON(!buffer_async_write(bh));
>  in fs/buffer.c:end_buffer_async_write
> 
>  It seems that more than one request would be submitted for a given bh
>  at a time.
> 
>  What would happen is the following:
>  2 threads doing __mpage_writepages on the same page.
>  Thread 1 - lock the page first, and enter __block_write_full_page.
>  Thread 1 - (eg.) mark_buffer_async_write on the first 2 buffers.
>  Thread 1 - set page writeback, unlock page.
>  Thread 2 - lock page, wait on page writeback
>  Thread 1 - submit_bh on the first 2 buffers.
>  => both requests complete, none of the page buffers are async_write,
>     end_page_writeback is called.
>  Thread 2 - wakes up. enters __block_write_full_page.
>  Thread 2 - mark_buffer_async_write on (eg.) the last buffer
>  Thread 1 - finds the last buffer has async_write set, submit_bh on that.
>  Thread 2 - submit_bh on the last buffer.
>  => oops.

ah-hah.  Thanks.

There are two situations:

a) Thread 2 comes in and tries to write a buffer which thread1 didn't write:

   Yes, thread 1 will get confused and will try to write thread 2's buffer.

b) Thread 2 comes in and tries to write a buffer which thread 1 is
   writing.  (Say, the buffer was redirtied by
   munmap->__set_page_dirty_buffers, which doesn't lock the page or the
   buffers)

   Thread 2 will fail the test_set_buffer_locked() and will redirty the page.

That's all a bit too complex.   How's about this instead?

--- 25/fs/buffer.c~fix-race-in-block_write_full_page	2005-04-27 10:42:11.191956704 -0700
+++ 25-akpm/fs/buffer.c	2005-04-27 10:42:56.548061528 -0700
@@ -1837,7 +1837,6 @@ static int __block_write_full_page(struc
 	 */
 	BUG_ON(PageWriteback(page));
 	set_page_writeback(page);
-	unlock_page(page);
 
 	do {
 		struct buffer_head *next = bh->b_this_page;
@@ -1848,6 +1847,7 @@ static int __block_write_full_page(struc
 		put_bh(bh);
 		bh = next;
 	} while (bh != head);
+	unlock_page(page);
 
 	err = 0;
 done:
@@ -1901,7 +1901,6 @@ recover:
 	SetPageError(page);
 	BUG_ON(PageWriteback(page));
 	set_page_writeback(page);
-	unlock_page(page);
 	do {
 		struct buffer_head *next = bh->b_this_page;
 		if (buffer_async_write(bh)) {
@@ -1912,6 +1911,7 @@ recover:
 		put_bh(bh);
 		bh = next;
 	} while (bh != head);
+	unlock_page(page);
 	goto done;
 }
 
_

Aside: can the redirty_page_for_writepage() ever happen any more?  Can a
buffer against a locked page be locked by some other actor?  I guess so -
kjournald in ordered mode might be trying to write the buffer as well,
perhaps...

