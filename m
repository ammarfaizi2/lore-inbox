Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267984AbTBMG5S>; Thu, 13 Feb 2003 01:57:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267985AbTBMG5S>; Thu, 13 Feb 2003 01:57:18 -0500
Received: from packet.digeo.com ([12.110.80.53]:64897 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267984AbTBMG5O>;
	Thu, 13 Feb 2003 01:57:14 -0500
Date: Wed, 12 Feb 2003 23:07:10 -0800
From: Andrew Morton <akpm@digeo.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.60-BK reproducible oops, during LTP run
Message-Id: <20030212230710.35eb6a74.akpm@digeo.com>
In-Reply-To: <3E4AA154.7070307@pobox.com>
References: <3E4AA154.7070307@pobox.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 13 Feb 2003 07:06:58.0528 (UTC) FILETIME=[7FC3A600:01C2D32E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@pobox.com> wrote:
>
> I have reproduced the BUG in fs/buffer.c:2533 twice now.  Test 
> conditions exactly the same, fsx-linux in one window, LTP in another window.
> 

Thanks.  It's a long-standing but benign bogon which was exposed by recent
ext3 simplifications.   This needs lots of testing.



when ext3_writepage races with truncate, block_write_full_page() will see
that the page is outside i_size and will bale out with -EIO.  But
ext3_writepage() will ignore this and will proceed to add the buffers to the
transaction.

Later, kjournald tries to write them out and goes BUG() because those buffers
are not mapped to disk.

The fix is to not attach the buffers to the transaction in ext3_writepage()
if block_write_full_page() failed.

So far so good, but that page now has dirty, unmapped buffers (the buffers
were attached in a dirty state by ext3_writepage()).  So teach
block_write_full_page() to clean the buffers against the page if it is wholly
outside i_size.

(A simpler fix to all of this might be to just bale out of ext3_writepage()
if the page is outside i_size.  But that is racy against
block_write_full_page()'s subsequent execution of the same comparison).



 buffer.c     |    6 ++++++
 ext3/inode.c |   13 ++++++++++---
 2 files changed, 16 insertions(+), 3 deletions(-)

diff -puN fs/ext3/inode.c~ext3-eio-fix fs/ext3/inode.c
--- 25/fs/ext3/inode.c~ext3-eio-fix	2003-02-12 22:32:07.000000000 -0800
+++ 25-akpm/fs/ext3/inode.c	2003-02-12 22:48:40.000000000 -0800
@@ -1357,10 +1357,17 @@ static int ext3_writepage(struct page *p
 	handle = ext3_journal_current_handle();
 	lock_kernel();
 
-	/* And attach them to the current transaction */
+	/*
+	 * And attach them to the current transaction.  But only if 
+	 * block_write_full_page() succeeded.  Otherwise they are unmapped,
+	 * and generally junk.
+	 */
 	if (order_data) {
-		err = walk_page_buffers(handle, page_bufs,
-			0, PAGE_CACHE_SIZE, NULL, ext3_journal_dirty_data);
+		if (ret == 0) {
+			err = walk_page_buffers(handle, page_bufs,
+				0, PAGE_CACHE_SIZE, NULL,
+				ext3_journal_dirty_data);
+		}
 		walk_page_buffers(handle, page_bufs, 0,
 				PAGE_CACHE_SIZE, NULL, bput_one);
 		if (!ret)
diff -puN fs/buffer.c~ext3-eio-fix fs/buffer.c
--- 25/fs/buffer.c~ext3-eio-fix	2003-02-12 22:55:03.000000000 -0800
+++ 25-akpm/fs/buffer.c	2003-02-12 22:59:23.000000000 -0800
@@ -2502,6 +2502,12 @@ int block_write_full_page(struct page *p
 	/* Is the page fully outside i_size? (truncate in progress) */
 	offset = inode->i_size & (PAGE_CACHE_SIZE-1);
 	if (page->index >= end_index+1 || !offset) {
+		/*
+		 * The page may have dirty, unmapped buffers.  For example,
+		 * they may have been added in ext3_writepage().  Make them
+		 * freeable here, so the page does not leak.
+		 */
+		block_invalidatepage(page, 0);
 		unlock_page(page);
 		return -EIO;
 	}

_

