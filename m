Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273703AbRI0WNv>; Thu, 27 Sep 2001 18:13:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273975AbRI0WNm>; Thu, 27 Sep 2001 18:13:42 -0400
Received: from [195.223.140.107] ([195.223.140.107]:22011 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S273703AbRI0WNd>;
	Thu, 27 Sep 2001 18:13:33 -0400
Date: Fri, 28 Sep 2001 00:13:21 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Robert Macaulay <robert_macaulay@dell.com>
Cc: Rik van Riel <riel@conectiva.com.br>,
        Craig Kulesa <ckulesa@as.arizona.edu>, linux-kernel@vger.kernel.org,
        Bob Matthews <bmatthews@redhat.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: highmem deadlock fix [was Re: VM in 2.4.10(+tweaks) vs. 2.4.9-ac14/15(+stuff)]
Message-ID: <20010928001321.L14277@athlon.random>
In-Reply-To: <20010926164935.J27945@athlon.random> <Pine.LNX.4.33.0109261310340.23259-100000@ping.us.dell.com> <20010926203651.Q27945@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010926203651.Q27945@athlon.random>; from andrea@suse.de on Wed, Sep 26, 2001 at 08:36:51PM +0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2001 at 08:36:51PM +0200, Andrea Arcangeli wrote:
> On Wed, Sep 26, 2001 at 01:17:29PM -0500, Robert Macaulay wrote:
> > We've tried the 2.4.10 with vmtweaks2 on out machine with 8GB RAM. It was 
> > looking good for a while, until it just stopped. Here is what was 
> > happening on the machine.
> > 
> > I was ftping files into the box at a rate of about 8MB/sec. This continued 
> > until all the RAM was in the  cache column. This was earlier in the 
> > included vmstat output. The I started a dd if=/dev/sde of=/dev/null in a 
> > new window.
> > 
> > All was looking good until it just stopped. I captured the vmstat below. 
> > vmstat continued running for about 1 minute, then it died too. What other 
> > info can I provide?
> 
> the best/first info in this case would be sysrq+T along with the system.map.

Ok, both your trace and Bob's trace show the problem clearly. thanks
to both for the helpful feedback btw.

The deadlock happens because of a collision between write_some_buffers()
and the GFP_NOHIGHIO logic. The deadlock was not introduced in the vm
rewrite but it was introduced with the nohighio logic.

The problem is that we are locking a couple of buffers, and later - after
they're all locked - we start writing them via write_locked_buffers.

The deadlock happens in the middle of write_locked_buffers when we hit
an highmem buffer, so while allocating with GFP_NOHIGHIO we end doing
sync_page_buffers on any page that isn't highmem, but that incidentally is one of the
other next buffers in the array that we previously locked in
write_some_buffers but that aren't in the I/O queue yet (so we'll wait
forever since they depends on us to be written).

Robert just confirmed that dropping the NOHIGHIO logic fixes the
problem.

So the fix is either:

1) to drop the NOHIGHIO logic like my test patch did
2) or to keep track of what buffers we must not wait while releasing
   ram

I'll try approch 2) in the below untested patch (the nohighio logic make
sense so I'd prefer not to drop it), Robert and Bob, can you give it a
spin on the highmem boxes and check if it helps?

I suggest to test it on top of 2.4.10+vm-tweaks-2.

--- 2.4.10aa2/fs/buffer.c.~1~	Wed Sep 26 18:45:29 2001
+++ 2.4.10aa2/fs/buffer.c	Fri Sep 28 00:04:44 2001
@@ -194,6 +194,7 @@
 		struct buffer_head * bh = *array++;
 		bh->b_end_io = end_buffer_io_sync;
 		submit_bh(WRITE, bh);
+		clear_bit(BH_Pending_IO, &bh->b_state);
 	} while (--count);
 }
 
@@ -225,6 +226,7 @@
 		if (atomic_set_buffer_clean(bh)) {
 			__refile_buffer(bh);
 			get_bh(bh);
+			set_bit(BH_Pending_IO, &bh->b_state);
 			array[count++] = bh;
 			if (count < NRSYNC)
 				continue;
@@ -2519,7 +2521,9 @@
 	int tryagain = 1;
 
 	do {
-		if (buffer_dirty(p) || buffer_locked(p)) {
+		if (unlikely(buffer_pending_IO(p)))
+			tryagain = 0;
+		else if (buffer_dirty(p) || buffer_locked(p)) {
 			if (test_and_set_bit(BH_Wait_IO, &p->b_state)) {
 				if (buffer_dirty(p)) {
 					ll_rw_block(WRITE, 1, &p);
--- 2.4.10aa2/include/linux/fs.h.~1~	Wed Sep 26 18:51:25 2001
+++ 2.4.10aa2/include/linux/fs.h	Fri Sep 28 00:01:54 2001
@@ -217,6 +217,7 @@
 	BH_New,		/* 1 if the buffer is new and not yet written out */
 	BH_Async,	/* 1 if the buffer is under end_buffer_io_async I/O */
 	BH_Wait_IO,	/* 1 if we should throttle on this buffer */
+	BH_Pending_IO,	/* 1 if the buffer is locked but not in the I/O queue yet */
 
 	BH_PrivateStart,/* not a state bit, but the first bit available
 			 * for private allocation by other entities
@@ -277,6 +278,7 @@
 #define buffer_mapped(bh)	__buffer_state(bh,Mapped)
 #define buffer_new(bh)		__buffer_state(bh,New)
 #define buffer_async(bh)	__buffer_state(bh,Async)
+#define buffer_pending_IO(bh)	__buffer_state(bh,Pending_IO)
 
 #define bh_offset(bh)		((unsigned long)(bh)->b_data & ~PAGE_MASK)
 

Thanks,
Andrea
