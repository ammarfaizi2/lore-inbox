Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265377AbRGJC4t>; Mon, 9 Jul 2001 22:56:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265385AbRGJC4j>; Mon, 9 Jul 2001 22:56:39 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:35176 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S265377AbRGJC4c>; Mon, 9 Jul 2001 22:56:32 -0400
Date: Tue, 10 Jul 2001 04:56:17 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Rik van Riel <riel@conectiva.com.br>, Mike Galbraith <mikeg@wen-online.de>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Alexander Viro <viro@math.psu.edu>, Alan Cox <alan@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: VM in 2.4.7-pre hurts...
Message-ID: <20010710045617.J1594@athlon.random>
In-Reply-To: <Pine.LNX.4.33.0107081227020.7044-100000@penguin.transmeta.com> <Pine.LNX.4.33.0107081949290.18364-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0107081949290.18364-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Sun, Jul 08, 2001 at 07:59:01PM -0700
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 08, 2001 at 07:59:01PM -0700, Linus Torvalds wrote:
> 
> On Sun, 8 Jul 2001, Linus Torvalds wrote:
> >
> > Anyway, having looked at the buffer case, I htink I found a potentially
> > nasty bug: "unlock_buffer()" with a buffer count of zero.
> 
> [ Basic problem: write-completion race with the code that does
>   "try_to_free_buffers" ]
> 
> Suggested fix:
>  - every b_end_io() function should decrement the buffer count as the
>    _last_ thing it does to the buffer.
>  - every bh IO submitter would have to increment the bh count before
>    submitting it for IO.

it seems to me there's a bit of overkill in the pre4 fix. First of all
such race obviously couldn't happen with the async_io and kiobuf
handlers, the former because the page stays locked so the bh cannot go
away with the locked page, the latter because the bh are private not
visible at all to the vm. Playing with the b_count for those two cases
are just wasted cycles.

Secondly even for the sync_io handler we shouldn't need to get_bh before
submitting the I/O. Once we get the bh locked we're just fine. As far I
can see all we need is to pin the bh around unlock_buffer in the I/O
completion handler which is simpler and equally efficient (possibly more
efficient in SMP where we won't risk to bh_put in a cpu different than
the bh_get, but probably the cacheline ping pong wouldn't change much
since we must do the lock/unlock on the b_state anyways).

Also somebody should explain me why end_buffer_write exists in first
place, it is just wasted memory and icache.

This is the way I would have fixed the smp race against pre3. Can you
see anything that isn't fixed by the below patch and that is fixed by
pre4? Unless somebody can see something I will drop some of the
unnecessary get_bh/put_bh from pre5.

--- bh-fix/drivers/block/ll_rw_blk.c.~1~	Tue Jul 10 04:33:57 2001
+++ bh-fix/drivers/block/ll_rw_blk.c	Tue Jul 10 04:49:11 2001
@@ -963,10 +963,12 @@
 /*
  * Default IO end handler, used by "ll_rw_block()".
  */
-static void end_buffer_io_sync(struct buffer_head *bh, int uptodate)
+void end_buffer_io_sync(struct buffer_head *bh, int uptodate)
 {
 	mark_buffer_uptodate(bh, uptodate);
+	atomic_inc(&bh->b_count);
 	unlock_buffer(bh);
+	atomic_dec(&bh->b_count);
 }
 
 /**
--- bh-fix/fs/buffer.c.~1~	Wed Jul  4 04:03:46 2001
+++ bh-fix/fs/buffer.c	Tue Jul 10 04:50:15 2001
@@ -161,13 +161,6 @@
 	atomic_dec(&bh->b_count);
 }
 
-/* End-of-write handler.. Just mark it up-to-date and unlock the buffer. */
-static void end_buffer_write(struct buffer_head *bh, int uptodate)
-{
-	mark_buffer_uptodate(bh, uptodate);
-	unlock_buffer(bh);
-}
-
 /*
  * The buffers have been marked clean and locked.  Just submit the dang
  * things.. 
@@ -182,7 +175,7 @@
 	atomic_inc(&wait->b_count);
 	do {
 		struct buffer_head * bh = *array++;
-		bh->b_end_io = end_buffer_write;
+		bh->b_end_io = end_buffer_io_sync;
 		submit_bh(WRITE, bh);
 	} while (--count);
 	wait_on_buffer(wait);
--- bh-fix/include/linux/fs.h.~1~	Mon Jul  9 20:25:17 2001
+++ bh-fix/include/linux/fs.h	Tue Jul 10 04:50:05 2001
@@ -1061,6 +1061,7 @@
 
 /* reiserfs_writepage needs this */
 extern void set_buffer_async_io(struct buffer_head *bh) ;
+extern void end_buffer_io_sync(struct buffer_head *, int);
 
 #define BUF_CLEAN	0
 #define BUF_LOCKED	1	/* Buffers scheduled for write */

Andrea
