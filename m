Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268043AbUJGUDg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268043AbUJGUDg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 16:03:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268042AbUJGUDP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 16:03:15 -0400
Received: from h-68-165-86-241.dllatx37.covad.net ([68.165.86.241]:7719 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S268029AbUJGT6W
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 15:58:22 -0400
Subject: [RFC][PATCH] TTY flip buffer SMP changes
From: Paul Fulghum <paulkf@microgate.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1097179099.1519.17.camel@deimos.microgate.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 07 Oct 2004 14:58:20 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In looking at the TTY flip buffer code, I noticed
some SMP synchronization problems. I made a post
earlier along these lines, but drew no response.

Below I investigate further and include a patch
for a possible fix which I have been testing
on an SMP machine with standard UARTs and
SyncLink serial adapters.

The patch (against 2.4.28-pre3)
is for comments and testing only.

The information below applies to 2.4 kernels
but most of it also applies to 2.6
The 2.6 code is being actively changed now
so I did not address it directly yet.

I hope to get responses along the lines of:

a) I'm wrong.
b) I'm right, the patch is wrong.
c) I'm right, the patch is right, but takes the wrong approach.
d) The patch merits further development.
e) Nobody is reporting problems, so don't mess with it.

Hopefully any such responses will be
accompanied by some explanation.

-- 
Paul Fulghum
paulkf@microgate.com

==========================
Changes to TTY Flip Buffer
==========================

The following changes to the tty flip buffer scheme
correct SMP locking problems.

---------------------------------
Current Flip Buffer (2.4 kernels)
---------------------------------

The flip buffer provides buffering between
tty devices and tty line disciplines for receive data.
Devices add data to the flip buffer in
any context, including hard IRQ.
Line disciplines consume data from the flip
buffer at soft IRQ or process context.

A flip buffer structure, defined in include/linux/tty.h,
is maintained for each tty device.

#define TTY_FLIPBUF_SIZE 512

struct tty_flip_buffer {
	struct tq_struct tqueue;
	struct semaphore pty_sem;
	char		*char_buf_ptr;
	unsigned char	*flag_buf_ptr;
	int		count;
	int		buf_num;
	unsigned char	char_buf[2*TTY_FLIPBUF_SIZE];
	char		flag_buf[2*TTY_FLIPBUF_SIZE];
	unsigned char	slop[4]; /* N.B. bug overwrites buffer by 1 */
};

This structure contains storage divided into two equal size buffers.
The buffers are numbered 0 (first half of char_buf/flag_buf)
and 1 (second half). The driver stores data to the buffer identified
by buf_num. The other buffer can be flushed to the line discipline.

The buffer is 'flipped' by toggling buf_num between 0 and 1.
When buf_num changes, char_buf_ptr and flag_buf_ptr
are set to the beginning of the buffer identified by buf_num,
and count is set to 0.

A device driver saves receive bytes at char_buf_ptr and
associated status bytes (parity, overflow etc.) at flag_buf_ptr.
The driver updates char_buf_ptr, flag_buf_ptr, and count
as data is added. This is usually done in hard IRQ context.
Some drivers use the helper function tty_insert_flip_char(),
include/linux/tty_flip.h, instead of accessing char_buf_ptr,
flag_buf_ptr, and count directly.

After adding data to the flip buffer, the driver schedules
the function identified by tqueue to flush
data to the line discipline receive_buf() method.
Drivers do this in four ways:

1. call tty_flip_buffer_push(), drivers/char/tty_io.c
2. call tty_schedule_flip, include/linux/tty_flip.h
3. call queue_task(&tty->flip.tqueue, &tq_timer)
4. call con_schedule_flip(), include/linux/kbd_kern.h

The first three methods are equivalent, using queue_task()
to run the flush routine in soft IRQ context via
the timer task queue. The last method uses schedule_task()
to run the flush routine in process context (kernel thread keventd).
Method 4 is used by the keyboard and console drivers.
Ideally, these methods should be combined into a single function.

The flush routine used by all drivers, with one exception, is
flush_to_ldisc(), drivers/char/tty_io.c
drivers/net/wan/8253x uses it's own flush routines
sab8253x_flush_to_ldisc() and sab8253x_flush_to_ldiscS().

Note:
Some drivers call the flush routine directly from
the receive handler while running in hard IRQ context.
This includes drivers/char/serial.c
This is incorrect behavior. The flush routine should
not be called in hard IRQ context.


TTY_DONT_FLIP
-------------
The tty flag TTY_DONT_FLIP causes the flush function
to reschedule for later if set. This bit is manipulated
by the N_TTY line discipline in read_chan(), drivers/char/n_tty.c.
This bit does not provide buffer protection or
synchronization for the line discipline since it is
not used in receive_buf() where driver data is injected
into the line discipline. N_TTY uses tty->read_lock
to protect the ldisc receive buffer.

The only effect of TTY_DONT_FLIP is to prevent sending
receive data to the line discipline while an
application reads receive data from the line discipline.
This may be useful to maximize the line discipline
free buffer space before sending more data to receive_buf().
If the flip buffer sends more data to receive_buf() than
the line discipline is ready for, then data is lost.


============================
Flaws in Current Flip Buffer
============================

There are two synchronization problems with the
flip buffer running on SMP machines:

---------
Problem 1
---------
A device driver receive handler can
run in parallel with the flush routine.

The driver can manipulate char_buf_ptr, flag_buf_ptr,
and count at the same time as the flush
routine flips buffers (manipulating the same members).

This is not a problem on uniprocessor systems
because the flush routine disables interrupts while
flipping buffers.

Fix
---
Prevent buffer flips while driver receive handler
accesses the buffer pointers and count.

Possible Fix 1
Change driver receive handlers to use a buffer access function
instead of directly accessing buffer pointers and count.
The access function implements a synchronization
mechanism with the flush routine.
This can provide a more intuitive interface between
drivers and the flip buffer and allows more
flexibility for future changes to the buffer implementation.

Possible Fix 2
Change driver receive handlers to use a common function,
such as tty_flip_buffer_push(), to schedule the flush routine.
Do buffer flips only during the scheduling call instead of in
the flush routine. This fix requires less intrusive changes
to the drivers.


---------
Problem 2
---------
Multiple instances of the flush routine can run in parallel.

No locks are held when flush_to_ldisc() calls the
line discipline receive_buf() method.
While receive_buf() runs, another instance of
flush_to_ldisc() can flip the buffers. In this case,
the driver can overwrite data in the buffer currently
being read by receive_buf().

Fix
---
Serialize the flush routine for eachd tty device instance.
This is easily done with a per device bit flag set and
checked on entry and cleared on exit. If the bit is already set
on entry, the flush is rescheduled to run later.


=================
Patch Description
=================

The following patch (against 2.4.28-pre3) implements fixes for the
SMP synchronization problems described above.
Possible fix 2 is used for problem 1.

The concepts of a write buffer and a read buffer are introduced.
The write buffer is identified by buf_num and is the buffer 
to which the driver adds data. (same as before patch)
The read buffer is identified by read_buf_num.
This is the buffer the flush routine reads from
to flush data to the line discipline.
The read and write buffers can be the same or different.
read_buf_num and buf_num start at 0 (read and write buffer are the same)

New members are added to the flip buffer structure:

struct tty_flip_buffer {
	struct tq_struct tqueue;
	struct semaphore pty_sem;
	spinlock_t      lock;
	char		*char_buf_ptr;
	unsigned char	*flag_buf_ptr;
	char		*char_read_ptr;
	unsigned char	*flag_read_ptr;
	int		count;
	int             push_count;
	int		buf_num;
	int             read_buf_num;
	atomic_t        read_count;
	unsigned long   flags;
	unsigned char	char_buf[2*TTY_FLIPBUF_SIZE];
	char		flag_buf[2*TTY_FLIPBUF_SIZE];
	unsigned char	slop[4]; /* N.B. bug overwrites buffer by 1 */
};

lock           This spinlock is held when flipping buffers.

flags          bit flags for flip buffer
               bit 0 - set on entry to flush routine, cleared on exit
                       used to serialize flush routine

push_count     Set to value of count when push routine called.
               Used to determine number of new bytes in
               write buffer since last push call.

read_buf_num   identifies current read buffer

read_count     The number of unread bytes in the read buffer that
               can be safely sent to the line discipline.

char_read_ptr  pointer to next unread data byte in read buffer

flag_read_ptr  pointer to next unread status byte in read buffer

tty_flip_buffer_push()
------------------------------
* flip write buffer when necessary
* increase read_count when new data added if read_buf_num == buf_num
* queue flush routine

flush_to_ldisc()
----------------
* flip read buffer when necessary
* flush unread data to line discipline receive_buf() method
* use line discipline receive_room() method to
  regulate the flow of data to receive_buf()
  This removes any benifit from the current use of
  TTY_DONT_FLIP so this flag is ignored.
* flush_to_ldisc() is serialized with flag in
  the flags member of the flip buffer structure.


This patch works with the standard UART driver and
any tty driver that already calls tty_flip_buffer_push().
A complete patch would modify all tty drivers to
call tty_flip_buffer_push().




diff -pur a/drivers/char/serial.c b/drivers/char/serial.c
--- a/drivers/char/serial.c	2004-02-18 07:36:31.000000000 -0600
+++ b/drivers/char/serial.c	2004-10-07 14:13:43.000000000 -0500
@@ -572,9 +572,20 @@ static _INLINE_ void receive_chars(struc
 	icount = &info->state->icount;
 	do {
 		if (tty->flip.count >= TTY_FLIPBUF_SIZE) {
-			tty->flip.tqueue.routine((void *) tty);
-			if (tty->flip.count >= TTY_FLIPBUF_SIZE)
+			tty_flip_buffer_push(tty);
+			if (tty->flip.count >= TTY_FLIPBUF_SIZE) {
+				/* no room in flip buffer, discard rx FIFO contents to clear IRQ
+				 * *FIXME* Hardware with auto flow control
+				 * would benefit from leaving the data in the FIFO and
+				 * disabling the rx IRQ until space becomes available.
+				 */
+				do {
+					serial_inp(info, UART_RX);
+					icount->overrun++;
+					*status = serial_inp(info, UART_LSR);
+				} while ((*status & UART_LSR_DR) && (max_count-- > 0));
 				return;		// if TTY_DONT_FLIP is set
+			}
 		}
 		ch = serial_inp(info, UART_RX);
 		*tty->flip.char_buf_ptr = ch;
diff -pur a/drivers/char/tty_io.c b/drivers/char/tty_io.c
--- a/drivers/char/tty_io.c	2004-04-14 08:05:29.000000000 -0500
+++ b/drivers/char/tty_io.c	2004-10-07 13:57:27.000000000 -0500
@@ -1939,37 +1939,64 @@ void do_SAK(struct tty_struct *tty)
 static void flush_to_ldisc(void *private_)
 {
 	struct tty_struct *tty = (struct tty_struct *) private_;
-	unsigned char	*cp;
-	char		*fp;
-	int		count;
+	struct tty_flip_buffer *flip = &tty->flip;
+	int read_count;
+	int count;
+	int offset;
 	unsigned long flags;
 
-	if (test_bit(TTY_DONT_FLIP, &tty->flags)) {
+	/* serialize flush processing */
+	if (test_and_set_bit(0, &flip->flags)) {
 		queue_task(&tty->flip.tqueue, &tq_timer);
 		return;
 	}
-	if (tty->flip.buf_num) {
-		cp = tty->flip.char_buf + TTY_FLIPBUF_SIZE;
-		fp = tty->flip.flag_buf + TTY_FLIPBUF_SIZE;
-		tty->flip.buf_num = 0;
-
-		save_flags(flags); cli();
-		tty->flip.char_buf_ptr = tty->flip.char_buf;
-		tty->flip.flag_buf_ptr = tty->flip.flag_buf;
-	} else {
-		cp = tty->flip.char_buf;
-		fp = tty->flip.flag_buf;
-		tty->flip.buf_num = 1;
-
-		save_flags(flags); cli();
-		tty->flip.char_buf_ptr = tty->flip.char_buf + TTY_FLIPBUF_SIZE;
-		tty->flip.flag_buf_ptr = tty->flip.flag_buf + TTY_FLIPBUF_SIZE;
-	}
-	count = tty->flip.count;
-	tty->flip.count = 0;
-	restore_flags(flags);
-	
-	tty->ldisc.receive_buf(tty, cp, fp, count);
+
+	for(;;) {
+		if ((read_count = atomic_read(&flip->read_count))) {
+			/* data available in read buffer */
+#if 0
+			/* this is not useful anymore as receive_room() is
+			 * used to regulate flow of data to ldisc
+			 */
+			if (test_bit(TTY_DONT_FLIP, &tty->flags)) {
+				queue_task(&tty->flip.tqueue, &tq_timer);
+				goto exit;
+			}
+#endif
+			/* send data to line discipline */
+			while((count = min(read_count, tty->ldisc.receive_room(tty)))) {
+				tty->ldisc.receive_buf(tty, flip->char_read_ptr, flip->flag_read_ptr, count);
+				flip->char_read_ptr += count;
+				flip->flag_read_ptr += count;
+				read_count -= count;
+				atomic_sub(count, &flip->read_count);
+			}
+			if (read_count) {
+				/* line discipline is busy, try again later */
+				queue_task(&tty->flip.tqueue, &tq_timer);
+				goto exit;
+			}
+		} else {
+			/* no data in read buffer */
+			spin_lock_irqsave(&flip->lock, flags);
+			if (flip->read_buf_num == flip->buf_num) {
+				/* other buffer not in use, done flushing */
+				spin_unlock_irqrestore(&flip->lock, flags);
+				goto exit;
+			}
+
+			/* flip read buffer */
+			flip->read_buf_num ^= 1;
+			offset = flip->read_buf_num ? TTY_FLIPBUF_SIZE : 0;
+			atomic_set(&flip->read_count, flip->push_count);
+			spin_unlock_irqrestore(&flip->lock, flags);
+
+			flip->char_read_ptr = flip->char_buf + offset;
+			flip->flag_read_ptr = flip->flag_buf + offset;
+		}
+	}
+exit:
+	clear_bit(0, &flip->flags);
 }
 
 /*
@@ -2017,12 +2044,70 @@ int tty_get_baud_rate(struct tty_struct 
 	return baud_table[i];
 }
 
+/**
+ * mark data in flip buffer as ready for line discipline
+ * and set flip buffer flush routine to run in soft IRQ context
+ *
+ * Can be called from any context including hard IRQ
+ */
 void tty_flip_buffer_push(struct tty_struct *tty)
 {
+	struct tty_flip_buffer *flip = &tty->flip;
+	int offset;
+	int new_count;
+	unsigned long flags;
+
+	spin_lock_irqsave(&flip->lock, flags);
+
+	new_count = flip->count - flip->push_count;
+	if (!new_count) {
+		/* no data added since last push */
+		spin_unlock_irqrestore(&flip->lock, flags);
+		return;
+	}
+	/* save count of bytes in write buffer when push called */
+	flip->push_count += new_count;
+
+	if (flip->read_buf_num == flip->buf_num) {
+		/* update count of unread data in read buffer */
+		atomic_add(new_count, &flip->read_count);
+
+		/* other buffer is unused, flip write buffer
+		 *
+		 * Deferring flip until buffer is half full
+		 * provides more total space for device to use
+		 * while waiting for flush routine to run.
+		 * (fill 1/2 buffer, flip, fill full buffer)
+		 *
+		 * Flipping immediately allows more space for
+		 * driver to use between calls to this function.
+		 * (full buffer available after push
+		 * instead of possible half buffer)
+		 */
+		if (flip->count >= TTY_FLIPBUF_SIZE/2) {
+			flip->buf_num ^= 1;
+			offset = flip->buf_num ? TTY_FLIPBUF_SIZE : 0;
+			flip->char_buf_ptr = flip->char_buf + offset;
+			flip->flag_buf_ptr = flip->flag_buf + offset;
+			flip->count = 0;
+			flip->push_count = 0;
+		}
+	}
+
+	spin_unlock_irqrestore(&flip->lock, flags);
+	
 	if (tty->low_latency)
 		flush_to_ldisc((void *) tty);
-	else
+	else {
+#if 0
+		/* original way is to run on next timer tick */
 		queue_task(&tty->flip.tqueue, &tq_timer);
+#else
+		/* use immediate task queue to run sooner */
+		queue_task(&tty->flip.tqueue, &tq_immediate);
+		mark_bh(IMMEDIATE_BH);
+#endif
+	}
 }
 
 /*
@@ -2036,6 +2121,10 @@ static void initialize_tty_struct(struct
 	tty->pgrp = -1;
 	tty->flip.char_buf_ptr = tty->flip.char_buf;
 	tty->flip.flag_buf_ptr = tty->flip.flag_buf;
+	tty->flip.char_read_ptr = tty->flip.char_buf;
+	tty->flip.flag_read_ptr = tty->flip.flag_buf;
+	spin_lock_init(&tty->flip.lock);
+	atomic_set(&tty->flip.read_count, 0);
 	tty->flip.tqueue.routine = flush_to_ldisc;
 	tty->flip.tqueue.data = tty;
 	init_MUTEX(&tty->flip.pty_sem);
diff -pur a/include/linux/kbd_kern.h b/include/linux/kbd_kern.h
--- a/include/linux/kbd_kern.h	2004-10-06 09:42:59.000000000 -0500
+++ b/include/linux/kbd_kern.h	2004-10-05 14:32:46.000000000 -0500
@@ -150,7 +150,7 @@ extern unsigned int keymap_count;
 
 static inline void con_schedule_flip(struct tty_struct *t)
 {
-	schedule_task(&t->flip.tqueue);
+	tty_flip_buffer_push(t);
 }
 
 #endif
diff -pur a/include/linux/tty_flip.h b/include/linux/tty_flip.h
--- a/include/linux/tty_flip.h	2001-07-26 15:57:42.000000000 -0500
+++ b/include/linux/tty_flip.h	2004-10-05 14:32:46.000000000 -0500
@@ -19,7 +19,7 @@ _INLINE_ void tty_insert_flip_char(struc
 
 _INLINE_ void tty_schedule_flip(struct tty_struct *tty)
 {
-	queue_task(&tty->flip.tqueue, &tq_timer);
+	tty_flip_buffer_push(tty);
 }
 
 #undef _INLINE_
diff -pur a/include/linux/tty.h b/include/linux/tty.h
--- a/include/linux/tty.h	2004-10-06 09:41:17.000000000 -0500
+++ b/include/linux/tty.h	2004-10-05 14:32:46.000000000 -0500
@@ -139,10 +139,17 @@ extern struct screen_info screen_info;
 struct tty_flip_buffer {
 	struct tq_struct tqueue;
 	struct semaphore pty_sem;
+	spinlock_t      lock;
 	char		*char_buf_ptr;
 	unsigned char	*flag_buf_ptr;
+	char		*char_read_ptr;
+	unsigned char	*flag_read_ptr;
 	int		count;
+	int             push_count;
 	int		buf_num;
+	int             read_buf_num;
+	atomic_t        read_count;
+	unsigned long   flags;
 	unsigned char	char_buf[2*TTY_FLIPBUF_SIZE];
 	char		flag_buf[2*TTY_FLIPBUF_SIZE];
 	unsigned char	slop[4]; /* N.B. bug overwrites buffer by 1 */


