Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264635AbRFUR7D>; Thu, 21 Jun 2001 13:59:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265077AbRFUR6x>; Thu, 21 Jun 2001 13:58:53 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:25887 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S264635AbRFUR6h>; Thu, 21 Jun 2001 13:58:37 -0400
Date: Thu, 21 Jun 2001 19:58:33 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Stefan.Bader@de.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: correction: fs/buffer.c underlocking async pages
Message-ID: <20010621195833.A707@athlon.random>
In-Reply-To: <20010621173833.L29084@athlon.random> <Pine.LNX.4.33.0106210955180.1260-100000@penguin.transmeta.com> <20010621191522.B28327@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010621191522.B28327@athlon.random>; from andrea@suse.de on Thu, Jun 21, 2001 at 07:15:22PM +0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2001 at 07:15:22PM +0200, Andrea Arcangeli wrote:
> On Thu, Jun 21, 2001 at 09:56:04AM -0700, Linus Torvalds wrote:
>  What's the problem with the existing code, and why do people want to add a
> > (unnecessary) new bit?
> 
> there's no problem with the existing code, what I understood is that
> they cannot overwrite the ->b_end_io callback in the lowlevel blkdev
> layer or the page will be unlocked too early.

I rediffed it a bit so the buffer_async and buffer_locked check can get
merged in a single asm instruction by gcc and cleaned up the
set_buffer_async_io logic a bit inside buffer.c:

--- bh-async/fs/buffer.c.~1~	Thu Jun 21 08:03:49 2001
+++ bh-async/fs/buffer.c	Thu Jun 21 18:13:46 2001
@@ -806,11 +806,12 @@
 	 * that unlock the page..
 	 */
 	spin_lock_irqsave(&page_uptodate_lock, flags);
+	mark_buffer_async(bh, 0);
 	unlock_buffer(bh);
 	atomic_dec(&bh->b_count);
 	tmp = bh->b_this_page;
 	while (tmp != bh) {
-		if (tmp->b_end_io == end_buffer_io_async && buffer_locked(tmp))
+		if (buffer_async(tmp) && buffer_locked(tmp))
 			goto still_busy;
 		tmp = tmp->b_this_page;
 	}
@@ -840,8 +841,9 @@
 	return;
 }
 
-void set_buffer_async_io(struct buffer_head *bh) {
+inline void set_buffer_async_io(struct buffer_head *bh) {
     bh->b_end_io = end_buffer_io_async ;
+    mark_buffer_async(bh, 1);
 }
 
 /*
@@ -1531,7 +1533,7 @@
 	/* Stage 2: lock the buffers, mark them clean */
 	do {
 		lock_buffer(bh);
-		bh->b_end_io = end_buffer_io_async;
+		set_buffer_async_io(bh);
 		atomic_inc(&bh->b_count);
 		set_bit(BH_Uptodate, &bh->b_state);
 		clear_bit(BH_Dirty, &bh->b_state);
@@ -1732,7 +1734,7 @@
 	for (i = 0; i < nr; i++) {
 		struct buffer_head * bh = arr[i];
 		lock_buffer(bh);
-		bh->b_end_io = end_buffer_io_async;
+		set_buffer_async_io(bh);
 		atomic_inc(&bh->b_count);
 	}
 
@@ -2178,7 +2180,7 @@
 		lock_buffer(bh);
 		bh->b_blocknr = *(b++);
 		set_bit(BH_Mapped, &bh->b_state);
-		bh->b_end_io = end_buffer_io_async;
+		set_buffer_async_io(bh);
 		atomic_inc(&bh->b_count);
 		bh = bh->b_this_page;
 	} while (bh != head);
--- bh-async/include/linux/fs.h.~1~	Thu Jun 21 08:03:56 2001
+++ bh-async/include/linux/fs.h	Thu Jun 21 18:10:38 2001
@@ -215,6 +215,7 @@
 	BH_Mapped,	/* 1 if the buffer has a disk mapping */
 	BH_New,		/* 1 if the buffer is new and not yet written out */
 	BH_Protected,	/* 1 if the buffer is protected */
+	BH_Async,	/* 1 if the buffer is under end_buffer_io_async I/O */
 
 	BH_PrivateStart,/* not a state bit, but the first bit available
 			 * for private allocation by other entities
@@ -275,6 +276,7 @@
 #define buffer_mapped(bh)	__buffer_state(bh,Mapped)
 #define buffer_new(bh)		__buffer_state(bh,New)
 #define buffer_protected(bh)	__buffer_state(bh,Protected)
+#define buffer_async(bh)	__buffer_state(bh,Async)
 
 #define bh_offset(bh)		((unsigned long)(bh)->b_data & ~PAGE_MASK)
 
@@ -1109,6 +1111,14 @@
 extern void FASTCALL(mark_buffer_dirty(struct buffer_head *bh));
 
 #define atomic_set_buffer_dirty(bh) test_and_set_bit(BH_Dirty, &(bh)->b_state)
+
+static inline void mark_buffer_async(struct buffer_head * bh, int on)
+{
+	if (on)
+		set_bit(BH_Async, &bh->b_state);
+	else
+		clear_bit(BH_Async, &bh->b_state);
+}
 
 /*
  * If an error happens during the make_request, this function


This way looks more robust to me.

However I want to add a very fat warning about not allocating a new bh:
never assume b_private and b_end_io and possibly otheres weren't remapped
by another logical layer before you or the stacking will break badly, we
want everything to remains transparent so we can stack multiple layers
one on the top of the other.

Andrea
