Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292589AbSCMHaE>; Wed, 13 Mar 2002 02:30:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292617AbSCMH35>; Wed, 13 Mar 2002 02:29:57 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:38738 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S292589AbSCMH3l>; Wed, 13 Mar 2002 02:29:41 -0500
Date: Wed, 13 Mar 2002 08:30:55 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@zip.com.au>
Cc: wli@holomorphy.com, wli@parcelfarce.linux.theplanet.co.uk,
        "Richard B. Johnson" <root@chaos.analogic.com>,
        linux-kernel@vger.kernel.org, riel@surriel.com, hch@infradead.org,
        phillips@bonn-fries.net
Subject: Re: 2.4.19pre2aa1
Message-ID: <20020313083055.D21589@dualathlon.random>
In-Reply-To: <20020312041958.C687@holomorphy.com> <20020312070645.X10413@dualathlon.random> <20020312112900.A14628@holomorphy.com> <20020312135605.P25226@dualathlon.random> <20020312141439.C14628@holomorphy.com> <20020312160430.W25226@dualathlon.random>, <20020312160430.W25226@dualathlon.random>; <20020312233117.E14628@holomorphy.com> <3C8E98B2.159FA546@zip.com.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="cWoXeonUoKmBZSoM"
Content-Disposition: inline
In-Reply-To: <3C8E98B2.159FA546@zip.com.au>
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 12, 2002 at 04:09:22PM -0800, Andrew Morton wrote:
> wli@holomorphy.com wrote:
> > 
> > Also, these changes to the hashing scheme were not separated out
> > from the rest of the VM patch, so the usual "break this up
> > into a separate patch please" applies.
> 
> FYI, I am doing that at present.  It look like Andrea's 10_vm-30
> patch will end up as twenty or thirty separate patches.  I won't
> be testing every darn patch individually - I'll batch them up into
> maybe four groups for testing and merging.
> 
> Andrea introduced some subtly changed buffer locking rules, and
> this causes ext3 to deadlock under heavy load.  Until we sort
> this out, I'm afraid that the -aa VM is not suitable for production
> use with ext3.
> 
> ext2 is OK and I *assume* it's OK with reiserfs.  The problem occurs
> when a filesystem performs:
> 
> 	lock_buffer(dirty_bh);
> 	allocate_something(GFP_NOFS);
> 
> without having locked the buffer's page.  sync_page_buffers()
> can perform a wait_on_buffer() against dirty_bh.  (I think.
> I'm not quite up-to-speed with the new buffer state bits yet).

The deadlock I fixed with BH_Pending_IO was only related to
write_some_buffers. What you found now is an additional deadlock that is
been fixed by further changes in mainline, alternative to the
BH_Pending_IO, but less restrictive.

The reason I kept using BH_Pending_IO is that without it the VM cannot
throttle correctly on locked buffers. With BH_launder the VM is only
able to throttle on buffers that the VM submitted by itself (and
incidentally it doesn't deadlock for you). So an excessive amount of
locked buffers submitted by bdflush/kupdate would lead the VM not to be
able to proper throttle. This is most important for the lowmem machines
where the amount of locked memory can be substantial thanks to the
fairly large I/O queues (mostly with more than on disk).

You can see the attached emails for historical reference.

Now, I think the best fix is to just drop the BH_Pending_IO and to add a
BH_launder similar mainline, but used in a completly different manner.
The way used by mainline is too permissive for those locked buffers just
submitted to the I/O layer.

In short I will set BH_launder in submit_bh, instead of
sync_page_buffers, this way I'll be sure if BH_launder is set I can
safely wait on the locked buffer because it's just visible to the I/O
layer and unplugging the queue will be enough to get it unlocked
eventually. BH_launder will be cleared in unlock_buffer as usual. That
is the _right_ usage of BH_launder, I simply weren't doing that because
I didn't noticed this further deadlock yet, I was only aware of the
write_some_buffers vs GFP_NOHIGHIO deadlock so far. In short this new
usage is the complemental information of my BH_Pending_IO. So now I can
wait if BH_Launder is set, while previously I couldn't wait if
BH_Pending_IO was set. But now the difference is that BH_Pending_IO
wasn't covering all the cases while BH_Launder used in my manner really
cover all the cases (the BH_launder in mainline doesn't cover all the
cases either, but the only downside is that it won't be able to write
throttle, while I could deadlock).

What do you think about this patch against 2.4.19pre3aa1?

Unless somebody finds anything wrong, I will release a new -aa tree and
vm-32 with it applied. I think it's the best approch to cure the
deadlock and to still be able to throttle on the locked buffers.

diff -urN ref/drivers/block/ll_rw_blk.c launder/drivers/block/ll_rw_blk.c
--- ref/drivers/block/ll_rw_blk.c	Wed Mar 13 08:24:07 2002
+++ launder/drivers/block/ll_rw_blk.c	Wed Mar 13 08:12:40 2002
@@ -1025,6 +1025,7 @@
 		BUG();
 
 	set_bit(BH_Req, &bh->b_state);
+	set_bit(BH_Launder, &bh->b_state);
 
 	/*
 	 * First step, 'identity mapping' - RAID or LVM might
diff -urN ref/fs/buffer.c launder/fs/buffer.c
--- ref/fs/buffer.c	Wed Mar 13 08:24:07 2002
+++ launder/fs/buffer.c	Wed Mar 13 08:26:02 2002
@@ -171,6 +171,7 @@
 		brelse(bh);
 		if (ret == 0) {
 			clear_bit(BH_Wait_IO, &bh->b_state);
+			clear_bit(BH_Launder, &bh->b_state);
 			smp_mb__after_clear_bit();
 			if (waitqueue_active(&bh->b_wait)) {
 				wake_up(&bh->b_wait);
@@ -184,6 +185,7 @@
 {
 	clear_bit(BH_Wait_IO, &bh->b_state);
 	clear_bit(BH_Lock, &bh->b_state);
+	clear_bit(BH_Launder, &bh->b_state);
 	smp_mb__after_clear_bit();
 	if (waitqueue_active(&bh->b_wait))
 		wake_up(&bh->b_wait);
@@ -238,7 +240,6 @@
 	do {
 		struct buffer_head * bh = *array++;
 		bh->b_end_io = end_buffer_io_sync;
-		clear_bit(BH_Pending_IO, &bh->b_state);
 		submit_bh(WRITE, bh);
 	} while (--count);
 }
@@ -278,7 +279,6 @@
 		if (atomic_set_buffer_clean(bh)) {
 			__refile_buffer(bh);
 			get_bh(bh);
-			set_bit(BH_Pending_IO, &bh->b_state);
 			array[count++] = bh;
 			if (count < NRSYNC)
 				continue;
@@ -2704,13 +2704,12 @@
 			continue;
 		}
 
-		if (unlikely(buffer_pending_IO(bh))) {
-			tryagain = 0;
-			continue;
-		}
-
 		/* Second time through we start actively writing out.. */
 		if (test_and_set_bit(BH_Lock, &bh->b_state)) {
+			if (unlikely(!buffer_launder(bh))) {
+				tryagain = 0;
+				continue;
+			}
 			wait_on_buffer(bh);
 			tryagain = 1;
 			continue;
diff -urN ref/include/linux/fs.h launder/include/linux/fs.h
--- ref/include/linux/fs.h	Wed Mar 13 08:24:11 2002
+++ launder/include/linux/fs.h	Wed Mar 13 08:23:59 2002
@@ -232,7 +232,7 @@
 	BH_New,		/* 1 if the buffer is new and not yet written out */
 	BH_Async,	/* 1 if the buffer is under end_buffer_io_async I/O */
 	BH_Wait_IO,	/* 1 if we should write out this buffer */
-	BH_Pending_IO,	/* 1 if the buffer is locked but not in the I/O queue yet */
+	BH_Launder,	/* 1 if we can throttle on this buffer */
 	BH_JBD,		/* 1 if it has an attached journal_head */
 	BH_Delay,	/* 1 if the buffer is delayed allocate */
 
@@ -295,7 +295,7 @@
 #define buffer_mapped(bh)	__buffer_state(bh,Mapped)
 #define buffer_new(bh)		__buffer_state(bh,New)
 #define buffer_async(bh)	__buffer_state(bh,Async)
-#define buffer_pending_IO(bh)	__buffer_state(bh,Pending_IO)
+#define buffer_launder(bh)	__buffer_state(bh,Launder)
 #define buffer_delay(bh)	__buffer_state(bh,Delay)
 
 #define bh_offset(bh)		((unsigned long)(bh)->b_data & ~PAGE_MASK)

Andrea

--cWoXeonUoKmBZSoM
Content-Type: message/rfc822
Content-Disposition: inline

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

--cWoXeonUoKmBZSoM--
