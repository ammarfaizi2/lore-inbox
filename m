Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932110AbWIAPrS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932110AbWIAPrS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 11:47:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751670AbWIAPrS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 11:47:18 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:25519 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751667AbWIAPrQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 11:47:16 -0400
Subject: [RFC][PATCH] set_page_buffer_dirty should skip unmapped buffers
From: Badari Pulavarty <pbadari@us.ibm.com>
To: sct@redhat.com, akpm@osdl.org
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>,
       lkml <linux-kernel@vger.kernel.org>, ext4 <linux-ext4@vger.kernel.org>
Content-Type: text/plain
Date: Fri, 01 Sep 2006 08:50:29 -0700
Message-Id: <1157125829.30578.6.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

I have been running into following bug while running fsx
tests on 1k (ext3) filesystem all the time. 

----------- [cut here ] --------- [please bite here ] ---------
Kernel BUG at fs/buffer.c:2791
invalid opcode: 0000 [1] SMP

Its complaining about BUG_ON(!buffer_mapped(bh)).

It was hard to track it down, needed lots of debug - but here 
is the problem & fix.  Since the fix is in __set_page_buffer_dirty()
code - I am wondering how it would effect others :(

With this fix fsx tests ran for more than 16 hours (and still
running).

Please let me know, what you think.

Thanks,
Badari 

Patch to fix: Kernel BUG at fs/buffer.c:2791
on 1k (2k) filesystems while running fsx.

journal_commit_transaction collects lots of dirty buffer from
and does a single ll_rw_block() to write them out. ll_rw_block()
locks the buffer and checks to see if they are dirty and submits
them for IO.

In the mean while, journal_unmap_buffers() as part of
truncate can unmap the buffer and throw it away. Since its
a 1k (2k) filesystem - each page (4k) will have more than
one buffer_head attached to the page and and we can't free 
up buffer_heads attached to the page (if we are not
invalidating the whole page).

Now, any call to set_page_dirty() (like msync_interval)
could end up setting all the buffer heads attached to
this page again dirty, including the ones those got
cleaned up :(

If ll_rw_block() runs now and sees the dirty bit it does
submit_bh() on those buffer_heads and triggers the assert.

Fix is to check if the buffer is mapped before setting its
dirty bit in __set_page_dirty_buffers().

Signed-off-by: Badari Pulavarty <pbadari@us.ibm.com>
---
 fs/buffer.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

Index: linux-2.6.18-rc5/fs/buffer.c
===================================================================
--- linux-2.6.18-rc5.orig/fs/buffer.c	2006-09-01 08:20:51.000000000 -0700
+++ linux-2.6.18-rc5/fs/buffer.c	2006-09-01 08:41:01.000000000 -0700
@@ -846,7 +846,13 @@ int __set_page_dirty_buffers(struct page
 		struct buffer_head *bh = head;
 
 		do {
-			set_buffer_dirty(bh);
+			/*
+			 * Its possible that, not all buffers attached to
+			 * this page are mapped (cleaned up by truncate).
+			 * If so, skip them.
+			 */
+			if (buffer_mapped(bh))
+				set_buffer_dirty(bh);
 			bh = bh->b_this_page;
 		} while (bh != head);
 	}


