Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262086AbTJMXH0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Oct 2003 19:07:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262092AbTJMXH0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Oct 2003 19:07:26 -0400
Received: from fw.osdl.org ([65.172.181.6]:45185 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262086AbTJMXHW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Oct 2003 19:07:22 -0400
Date: Mon, 13 Oct 2003 16:07:35 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ide write barrier support
Message-Id: <20031013160735.089df1fb.akpm@osdl.org>
In-Reply-To: <20031013140858.GU1107@suse.de>
References: <20031013140858.GU1107@suse.de>
X-Mailer: Sylpheed version 0.9.6 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe <axboe@suse.de> wrote:
>
> Hi,
> 
> Forward ported and tested today (with the dummy ext3 patch included),
> works for me. Some todo's left, but I thought I'd send it out to gauge
> interest. TODO:
> 
> - Detect write cache setting and only issue SYNC_CACHE if write cache is
>   enabled (not a biggy, all drives ship with it enabled)
> 
> - Toggle flush support on hdparm -W0/1
> 
> - Various small bits I can't remember right now
> 

> ...
> +		set_bit(BH_Ordered, &bh->b_state);

We have standard macros for generating standard buffer_head operations, so
this can become

	set_buffer_ordered(bh);

See appended patch.


> --- 1.40/fs/jbd/commit.c	Fri Aug  1 12:02:20 2003
> +++ edited/fs/jbd/commit.c	Mon Oct 13 10:17:28 2003
> @@ -474,7 +474,9 @@
>  				clear_buffer_dirty(bh);
>  				set_buffer_uptodate(bh);
>  				bh->b_end_io = journal_end_buffer_io_sync;
> +				set_bit(BH_Ordered, &bh->b_state);
>  				submit_bh(WRITE, bh);
> +				clear_bit(BH_Ordered, &bh->b_state);
>  			}
>  			cond_resched();

Why does the ordering go here?  I'd have thought that we only need to
enforce ordering around the commit block.

Touching the bh here after submitting it may be racy: may need to take an
extra ref against the bh to prevent it from disappearing.  I need to look
at it more closely.

> @@ -344,6 +348,8 @@
>  	unsigned long		seg_boundary_mask;
>  	unsigned int		dma_alignment;
>  
> +	unsigned short		ordered;
> +
>  	struct blk_queue_tag	*queue_tags;
>  
>  	atomic_t		refcnt;

shorts-in-structs worry me.  If the CPU implements a write-to-short as a
word-sized RMW and the compiler decides to align or pack the short into a
less-than-wored-sized storage space then a write-to-short could stomp on a
neighbouring member.

I doubt if it can happen, but if so, I'd be interested in knowing what guarantees it.

> ...
>  	unsigned vdma		: 1;	/* 1=doing PIO over DMA 0=doing normal DMA */
> +	unsigned doing_barrier	: 1;	/* state, 1=currently doing flush */

Similarly, I suspect that bitfields like this need locking.  If the CPU
implements a write-to-bitfield as a non-buslocked RMW it can stomp on
neighbouring bitfields in the same word.


 25-akpm/fs/buffer.c                 |    4 ++--
 25-akpm/fs/jbd/commit.c             |    4 ++--
 25-akpm/include/linux/buffer_head.h |    3 ++-
 3 files changed, 6 insertions(+), 5 deletions(-)

diff -puN fs/buffer.c~ide-write-barrier-support-tidies fs/buffer.c
--- 25/fs/buffer.c~ide-write-barrier-support-tidies	Mon Oct 13 15:53:56 2003
+++ 25-akpm/fs/buffer.c	Mon Oct 13 15:53:56 2003
@@ -2655,7 +2655,7 @@ int submit_bh(int rw, struct buffer_head
 	BUG_ON(!bh->b_end_io);
 
 	if (rw == WRITEBARRIER) {
-		set_bit(BH_Ordered, &bh->b_state);
+		set_buffer_ordered(bh);
 		rw = WRITE;
 	}
 
@@ -2666,7 +2666,7 @@ int submit_bh(int rw, struct buffer_head
 	if (rw == READ && buffer_dirty(bh))
 		buffer_error();
 
-	if (test_bit(BH_Ordered, &bh->b_state) && (rw == WRITE))
+	if (buffer_ordered(bh) && (rw == WRITE))
 		rw = WRITEBARRIER;
 
 	/* Only clear out a write error when rewriting */
diff -puN fs/jbd/commit.c~ide-write-barrier-support-tidies fs/jbd/commit.c
--- 25/fs/jbd/commit.c~ide-write-barrier-support-tidies	Mon Oct 13 15:53:56 2003
+++ 25-akpm/fs/jbd/commit.c	Mon Oct 13 15:53:56 2003
@@ -474,9 +474,9 @@ start_journal_io:
 				clear_buffer_dirty(bh);
 				set_buffer_uptodate(bh);
 				bh->b_end_io = journal_end_buffer_io_sync;
-				set_bit(BH_Ordered, &bh->b_state);
+				set_buffer_ordered(bh);
 				submit_bh(WRITE, bh);
-				clear_bit(BH_Ordered, &bh->b_state);
+				clear_buffer_ordered(bh)
 			}
 			cond_resched();
 
diff -puN include/linux/buffer_head.h~ide-write-barrier-support-tidies include/linux/buffer_head.h
--- 25/include/linux/buffer_head.h~ide-write-barrier-support-tidies	Mon Oct 13 15:53:56 2003
+++ 25-akpm/include/linux/buffer_head.h	Mon Oct 13 15:53:56 2003
@@ -118,7 +118,8 @@ BUFFER_FNS(Async_Read, async_read)
 BUFFER_FNS(Async_Write, async_write)
 BUFFER_FNS(Delay, delay)
 BUFFER_FNS(Boundary, boundary)
-BUFFER_FNS(Write_EIO,write_io_error)
+BUFFER_FNS(Write_EIO, write_io_error)
+BUFFER_FNS(Ordered, ordered)
 
 #define bh_offset(bh)		((unsigned long)(bh)->b_data & ~PAGE_MASK)
 #define touch_buffer(bh)	mark_page_accessed(bh->b_page)

_

