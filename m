Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135630AbRAJOmP>; Wed, 10 Jan 2001 09:42:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135645AbRAJOlz>; Wed, 10 Jan 2001 09:41:55 -0500
Received: from notes.equinox.com ([63.80.92.4]:63504 "EHLO notes.EQUINOX.COM")
	by vger.kernel.org with ESMTP id <S135630AbRAJOlX>;
	Wed, 10 Jan 2001 09:41:23 -0500
Subject: [PROBLEM]: race condition in tty subsystem
To: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.1 July 16, 1999
Message-ID: <OF01C762C6.08046809-ON852569D0.004CD3AB@EQUINOX.COM>
From: MStraub@equinox.com
Date: Wed, 10 Jan 2001 09:39:55 -0500
X-MIMETrack: Serialize by Router on notes.EQUINOX.COM/EQNX(Release 5.0.5 |September 22, 2000) at
 01/10/2001 09:40:02 AM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This should be directed to the maintainer of the tty (serial)
subsystem, but I couldn't find who this is.


 I'm seeing a race condition in the tty subsystem, canonical mode
processing, on multiprocessors.
Serial ports will get into a state, where a read on the port will
never block even though O_NONBLOCK is
not set.   If there is no data for the port, (i.e. the majority of the
time), a read will immediately return
with 0.  I think this is incorrect.

The version of the kernel that I'm running is 2.4.0-test11.  I've also
seen it in 2.2 kernels.  The module in
question, drivers/char/n_tty.c, is unchanged in the final version of
2.4.0.

This problem occurs fairly frequently on a dual-processor Itanium
(Lion B2).  I've seen it also occur
on dual-processor x86 systems, but much less frequently (don't know
why).

To get into a bit more detail ....

When the serial port is in this state, the tty->canon_data field is
always non-zero.  This indicates that
there is a canonical "chunk".  However, there is no data to process.
This is what causes the read_chan
routine in n_tty.c to immediately return with 0 data.  The port stays
this way until closed.

The problem, to me, is that the code that puts data into a tty's queue
and increments tty->canon_data
(n_tty_receive_char in n_tty.c) does not do this atomically.  The code
that pulls data off the tty's queue and
decrements tty->canon_data (read_chan in n_tty.c) can occur at the
same time on a multiprocessor and
possibly cause canon_data to be inconsistent.

I have a test program that demonstrates this if the maintainer is
interested.

Here is the patch that I used to fix it ----

--- linux/drivers/char/n_tty.c     Mon Jul 31 13:14:07 2000
+++ linux/drivers/char/n_tty.c-fix Wed Jan 10 07:46:43 2001
@@ -102,6 +102,15 @@
     spin_unlock_irqrestore(&tty->read_lock, flags);
 }

+static inline void put_tty_queue_nolock(unsigned char c, struct
tty_struct *tty)
+{
+    if (tty->read_cnt < N_TTY_BUF_SIZE) {
+         tty->read_buf[tty->read_head] = c;
+         tty->read_head = (tty->read_head + 1) & (N_TTY_BUF_SIZE-1);
+         tty->read_cnt++;
+    }
+}
+
 /*
  * Check whether to call the driver.unthrottle function.
  * We test the TTY_THROTTLED bit first so that it always
@@ -499,6 +508,8 @@

 static inline void n_tty_receive_char(struct tty_struct *tty,
unsigned char c)
 {
+    unsigned long flags;
+
     if (tty->raw) {
          put_tty_queue(c, tty);
          return;
@@ -651,10 +662,12 @@
                    put_tty_queue(c, tty);

          handle_newline:
+              spin_lock_irqsave(&tty->read_lock, flags);
               set_bit(tty->read_head, &tty->read_flags);
-              put_tty_queue(c, tty);
+              put_tty_queue_nolock(c, tty);
               tty->canon_head = tty->read_head;
               tty->canon_data++;
+              spin_unlock_irqrestore(&tty->read_lock, flags);
               kill_fasync(&tty->fasync, SIGIO, POLL_IN);
               if (waitqueue_active(&tty->read_wait))
                    wake_up_interruptible(&tty->read_wait);

Thanks,
Mike Straub

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
