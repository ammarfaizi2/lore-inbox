Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261222AbVEADbA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261222AbVEADbA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Apr 2005 23:31:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261520AbVEADa7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Apr 2005 23:30:59 -0400
Received: from smtp206.mail.sc5.yahoo.com ([216.136.129.96]:60265 "HELO
	smtp206.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261222AbVEADag (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Apr 2005 23:30:36 -0400
Message-ID: <42744D58.7090408@yahoo.com.au>
Date: Sun, 01 May 2005 13:30:32 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, Andrea Arcangeli <andrea@suse.de>,
       Chris Mason <mason@suse.com>, Linus Torvalds <torvalds@osdl.org>
Subject: [patch] alternative fix for VFS race (was Re: 2.6.12-rc3-mm2)
References: <20050430164303.6538f47c.akpm@osdl.org>
In-Reply-To: <20050430164303.6538f47c.akpm@osdl.org>
Content-Type: multipart/mixed;
 boundary="------------050207030303030607040900"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050207030303030607040900
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc3/2.6.12-rc3-mm2/
> 

http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc3/2.6.12-rc3-mm2/broken-out/fix-race-in-block_write_full_page.patch

While this patch does fix the problem, I would like to propose the
following attached patch instead, which is a minimal fix for the
specific race identified.

I have the following concerns about extending the lock page coverage:
Extending lock_page coverage 1) doesn't appear to protect from any other
races; 2) doesn't seem to be how the rest of the kernel submits asynch
writes; 3) isn't how this path used to do locking; and 4) can hold the
page lock for a long time while a request slot and memory is allocated.

What's more, if there *is* a good reason to extend lock page coverage,
then that should probably be sumbmitted as a seperate changeset on top
of this minimal patch, with a seperate rationale. It would help future
work on this code identify why the locking is the way it is.


Thanks,
Nick

-- 
SUSE Labs, Novell Inc.

--------------050207030303030607040900
Content-Type: text/plain;
 name="__block_write_full_page-bug.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="__block_write_full_page-bug.patch"

When running
	fsstress -v -d $DIR/tmp -n 1000 -p 1000 -l 2
on an ext2 filesystem with 1024 byte block size, on SMP i386 with 4096 byte
page size over loopback to an image file on a tmpfs filesystem, I would
very quickly hit
	BUG_ON(!buffer_async_write(bh));
in fs/buffer.c:end_buffer_async_write

It seems that more than one request would be submitted for a given bh
at a time.

What would happen is the following:
2 threads doing __mpage_writepages on the same page.
Thread 1 - lock the page first, and enter __block_write_full_page.
Thread 1 - (eg.) mark_buffer_async_write on the first 2 buffers.
Thread 1 - set page writeback, unlock page.
Thread 2 - lock page, wait on page writeback
Thread 1 - submit_bh on the first 2 buffers.
=> both requests complete, none of the page buffers are async_write,
   end_page_writeback is called.
Thread 2 - wakes up. enters __block_write_full_page.
Thread 2 - mark_buffer_async_write on (eg.) the last buffer
Thread 1 - finds the last buffer has async_write set, submit_bh on that.
Thread 2 - submit_bh on the last buffer.
=> oops.

So change __block_write_full_page to explicitly keep track of the last
bh we need to issue, so we don't touch anything after issuing the last
request.

Signed-off-by: Nick Piggin <nickpiggin@yahoo.com.au>

Index: linux-2.6/fs/buffer.c
===================================================================
--- linux-2.6.orig/fs/buffer.c	2005-04-27 22:43:05.000000000 +1000
+++ linux-2.6/fs/buffer.c	2005-05-01 12:44:08.000000000 +1000
@@ -1750,7 +1750,7 @@ static int __block_write_full_page(struc
 	int err;
 	sector_t block;
 	sector_t last_block;
-	struct buffer_head *bh, *head;
+	struct buffer_head *bh, *head, *last_bh = NULL;
 	int nr_underway = 0;
 
 	BUG_ON(!PageLocked(page));
@@ -1808,7 +1808,6 @@ static int __block_write_full_page(struc
 	} while (bh != head);
 
 	do {
-		get_bh(bh);
 		if (!buffer_mapped(bh))
 			continue;
 		/*
@@ -1826,6 +1825,8 @@ static int __block_write_full_page(struc
 		}
 		if (test_clear_buffer_dirty(bh)) {
 			mark_buffer_async_write(bh);
+			get_bh(bh);
+			last_bh = bh;
 		} else {
 			unlock_buffer(bh);
 		}
@@ -1844,10 +1845,13 @@ static int __block_write_full_page(struc
 		if (buffer_async_write(bh)) {
 			submit_bh(WRITE, bh);
 			nr_underway++;
+			put_bh(bh);
+			if (bh == last_bh)
+				break;
 		}
-		put_bh(bh);
 		bh = next;
 	} while (bh != head);
+	bh = head;
 
 	err = 0;
 done:
@@ -1886,10 +1890,11 @@ recover:
 	bh = head;
 	/* Recovery: lock and submit the mapped buffers */
 	do {
-		get_bh(bh);
 		if (buffer_mapped(bh) && buffer_dirty(bh)) {
 			lock_buffer(bh);
 			mark_buffer_async_write(bh);
+			get_bh(bh);
+			last_bh = bh;
 		} else {
 			/*
 			 * The buffer may have been set dirty during
@@ -1908,10 +1913,13 @@ recover:
 			clear_buffer_dirty(bh);
 			submit_bh(WRITE, bh);
 			nr_underway++;
+			put_bh(bh);
+			if (bh == last_bh)
+				break;
 		}
-		put_bh(bh);
 		bh = next;
 	} while (bh != head);
+	bh = head;
 	goto done;
 }
 

--------------050207030303030607040900--

