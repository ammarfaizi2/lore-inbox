Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266235AbRF3SGs>; Sat, 30 Jun 2001 14:06:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266236AbRF3SGj>; Sat, 30 Jun 2001 14:06:39 -0400
Received: from sgi.SGI.COM ([192.48.153.1]:12851 "EHLO sgi.com")
	by vger.kernel.org with ESMTP id <S266235AbRF3SGS>;
	Sat, 30 Jun 2001 14:06:18 -0400
Message-Id: <200106301807.f5UI7g503277@jen.americas.sgi.com>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: Steve Lord <lord@sgi.com>, Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Bounce buffer deadlock 
In-Reply-To: Message from Marcelo Tosatti <marcelo@conectiva.com.br> 
   of "Sat, 30 Jun 2001 13:07:20 -0300." <Pine.LNX.4.21.0106301303250.3227-100000@freak.distro.conectiva> 
Date: Sat, 30 Jun 2001 13:07:42 -0500
From: Steve Lord <lord@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Yes. 2.4.6-pre8 fixes that (not sure if its up already). 

It is up.

> 
> > If the fix is to avoid page_launder in these cases then the number of
> > occurrences when an alloc_pages fails will go up. 
> 
> > I was attempting to come up with a way of making try_to_free_buffers
> > fail on buffers which are being processed in the generic_make_request
> > path by marking them, the problem is there is no single place to reset
> > the state of a buffer so that try_to_free_buffers will wait for it.
> > Doing it after the end of the loop in generic_make_request is race
> > prone to say the least.
> 
> I really want to fix things like this in 2.5. (ie not avoid the deadlock
> by completly avoiding physical IO, but avoid the deadlock by avoiding
> physical IO on the "device" which is doing the allocation)
> 
> Could you send me your code ? No problem if it does not work at all :)
> 

Well, the basic idea is simple, but I suspect the implementation might
rapidly become historical in 2.5. Basically I added a new buffer state bit,
although BH_Req looks like it could be cannibalized, no one appears to check
for it (is it really dead code?). 

Using a flag to skip buffers in try_to_free_buffers is easy:


===========================================================================
Index: linux/fs/buffer.c
===========================================================================

--- /usr/tmp/TmpDir.3237-0/linux/fs/buffer.c_1.68	Sat Jun 30 12:56:29 2001
+++ linux/fs/buffer.c	Sat Jun 30 12:57:52 2001
@@ -2365,7 +2365,7 @@
 /*
  * Can the buffer be thrown out?
  */
-#define BUFFER_BUSY_BITS	((1<<BH_Dirty) | (1<<BH_Lock) | (1<<BH_Protected))
+#define BUFFER_BUSY_BITS	((1<<BH_Dirty) | (1<<BH_Lock) | (1<<BH_Protected) | (1<<BH_Clamped))
 #define buffer_busy(bh)		(atomic_read(&(bh)->b_count) | ((bh)->b_state & BUFFER_BUSY_BITS))
 
 /*
@@ -2430,7 +2430,11 @@
 	spin_unlock(&free_list[index].lock);
 	write_unlock(&hash_table_lock);
 	spin_unlock(&lru_list_lock);
-	if (wait) {
+	/* Buffers in the middle of generic_make_request processing cannot
+	 * be waited for, they may be allocating memory right now and be
+	 * locked by this thread.
+	 */
+	if (wait && !buffer_clamped(tmp)) {
 		sync_page_buffers(bh, wait);
 		/* We waited synchronously, so we can free the buffers. */
 		if (wait > 1 && !loop) {

===========================================================================
Index: linux/include/linux/fs.h
===========================================================================

--- /usr/tmp/TmpDir.3237-0/linux/include/linux/fs.h_1.99	Sat Jun 30 12:56:29 2001
+++ linux/include/linux/fs.h	Sat Jun 30 07:05:37 2001
@@ -224,6 +224,8 @@
 	BH_Mapped,	/* 1 if the buffer has a disk mapping */
 	BH_New,		/* 1 if the buffer is new and not yet written out */
 	BH_Protected,	/* 1 if the buffer is protected */
+	BH_Clamped,	/* 1 if the buffer cannot be reclaimed
+			 * in it's current state */
 	BH_Delay,	/* 1 if the buffer is delayed allocate */
 
 	BH_PrivateStart,/* not a state bit, but the first bit available
@@ -286,6 +288,7 @@
 #define buffer_mapped(bh)	__buffer_state(bh,Mapped)
 #define buffer_new(bh)		__buffer_state(bh,New)
 #define buffer_protected(bh)	__buffer_state(bh,Protected)
+#define buffer_clamped(bh)	__buffer_state(bh,Clamped)
 #define buffer_delay(bh)	__buffer_state(bh,Delay)
 
 #define bh_offset(bh)		((unsigned long)(bh)->b_data & ~PAGE_MASK)


The tricky part which I had not worked out how to do yet is to manage the
clearing of a state bit in all the correct places. You would have to set it
when the buffer got locked when I/O was about to start, it becomes clearable
after the last memory allocation during the I/O submission process. I do
not like the approach because there are so many ways a buffer can go
once you get into generic_make_request. At first I thought I could just
explicitly set and clear a flag around memory allocations like the bounce
buffer path. However, that can lead to AB BA deadlocks between multiple
threads submitting I/O requests. At this point I started to think I was
going to build an unmaintainable rats nest and decided I had not got
the correct answer.

I am not sure that an approach which avoids a specific device will fly either,
all the I/O can be on one device, and what does device mean when it comes
to md/lvm and request remapping?

Steve


