Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270007AbTG3KRE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 06:17:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270009AbTG3KRE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 06:17:04 -0400
Received: from [212.209.10.215] ([212.209.10.215]:13983 "EHLO
	miranda.se.axis.com") by vger.kernel.org with ESMTP id S270007AbTG3KQ6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 06:16:58 -0400
From: Johan.Adolfsson@axis.com
Message-ID: <179001c35683$95ba1290$e2070d0a@pcjohana>
To: <linux-kernel@vger.kernel.org>
Subject: Safer flush_to_ldisc()
Date: Wed, 30 Jul 2003 12:16:04 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There is currently (and has always been it seems) a problem
with flush_to_ldisc().
The below diff is against 2.4.20 and contains some stuff made in 2.5,
as well, but the important thing is to set TTY_DONT_FLIP
while processing the flip buffer.
Otherwise, on slow systems or systems with high load and
fast flipping (high baudrates) a new flip might start before
the next flip has been processed, resulting in that characters
could be lost or perhaps arrive out of order.
A driver can write data to a flip buffer that really isn't processed yet.

At least that is what I think happens...
Does it make sense?

/Johan



--- linux/drivers/char/tty_io.c    2 Dec 2002 08:13:09 -0000       1.16
+++ linux/drivers/char/tty_io.c    30 Jul 2003 10:06:04 -0000
@@ -1910,24 +1910,23 @@ static void flush_to_ldisc(void *private
        int             count;
        unsigned long flags;

-       if (test_bit(TTY_DONT_FLIP, &tty->flags)) {
+       /* Have TTY_DONT_FLIP set while processing the flip buffer */
+       if (test_and_set_bit(TTY_DONT_FLIP, &tty->flags)) {
+               /* Already set, process later. */
                queue_task(&tty->flip.tqueue, &tq_timer);
                return;
        }
+       save_flags(flags); cli();
        if (tty->flip.buf_num) {
                cp = tty->flip.char_buf + TTY_FLIPBUF_SIZE;
                fp = tty->flip.flag_buf + TTY_FLIPBUF_SIZE;
-               tty->flip.buf_num = 0;
-
-               save_flags(flags); cli();
+               tty->flip.buf_num = 0;
                tty->flip.char_buf_ptr = tty->flip.char_buf;
                tty->flip.flag_buf_ptr = tty->flip.flag_buf;
        } else {
                cp = tty->flip.char_buf;
                fp = tty->flip.flag_buf;
-               tty->flip.buf_num = 1;
-
-               save_flags(flags); cli();
+               tty->flip.buf_num = 1;
                tty->flip.char_buf_ptr = tty->flip.char_buf +
TTY_FLIPBUF_SIZE;
                tty->flip.flag_buf_ptr = tty->flip.flag_buf +
TTY_FLIPBUF_SIZE;
        }
@@ -1936,6 +1935,7 @@ static void flush_to_ldisc(void *private
        restore_flags(flags);

        tty->ldisc.receive_buf(tty, cp, fp, count);
+       clear_bit(TTY_DONT_FLIP, &tty->flags);
 }

