Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264098AbUJAQIs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264098AbUJAQIs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 12:08:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264530AbUJAQIr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 12:08:47 -0400
Received: from h-68-165-86-241.dllatx37.covad.net ([68.165.86.241]:1853 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S264098AbUJAQGj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 12:06:39 -0400
Subject: Re: Serial driver hangs
From: Paul Fulghum <paulkf@microgate.com>
To: Roland =?ISO-8859-1?Q?Ca=DFebohm?= 
	<roland.cassebohm@VisionSystems.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Russell King <rmk+lkml@arm.linux.org.uk>
In-Reply-To: <200410011722.28877.roland.cassebohm@visionsystems.de>
References: <200409281734.38781.roland.cassebohm@visionsystems.de>
	 <1096575030.19487.50.camel@localhost.localdomain>
	 <1096579503.1938.166.camel@deimos.microgate.com>
	 <200410011722.28877.roland.cassebohm@visionsystems.de>
Content-Type: text/plain; charset=UTF-8
Message-Id: <1096646788.2757.13.camel@deimos.microgate.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 01 Oct 2004 11:06:28 -0500
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-10-01 at 10:22, Roland Caßebohm wrote:
> Yes, I think you are right, if the system is to slow to fetch 
> the data fast enough the buffer will be sometime full. And if 
> it would be possible to use the second flip buffer then, this 
> buffer would be full too sometime.
> It would just take a little longer till data got lost. But if 
> I want that I could just make the buffers larger.
> 
> ...
> 
> I have just tested it, but unfortunately I've got a very bad 
> result. :-( In my test case (2 port with 921600 baud) I get 
> very much data loss.

Roland:

Can I impose on you to try the following patches?

The differences here are:
* don't call flush_to_ldisc() directly from ISR
* flush_to_ldisc() keeps flushing flip buffers until empty

These patches are for testing purposes only
and not intended for general use.
I would like to see how your high speed setup reacts.

Thanks in advance.

-- 
Paul Fulghum
paulkf@microgate.com

--- a/drivers/char/serial.c	2004-09-30 15:25:17.000000000 -0500
+++ b/drivers/char/serial.c	2004-10-01 10:42:33.000000000 -0500
@@ -572,9 +572,17 @@ static _INLINE_ void receive_chars(struc
 	icount = &info->state->icount;
 	do {
 		if (tty->flip.count >= TTY_FLIPBUF_SIZE) {
-			tty->flip.tqueue.routine((void *) tty);
-			if (tty->flip.count >= TTY_FLIPBUF_SIZE)
-				return;		// if TTY_DONT_FLIP is set
+			/* no room in flip buffer, discard rx FIFO contents to clear IRQ
+			 * *FIXME* Hardware with auto flow control
+			 * would benefit from leaving the data in the FIFO and
+			 * disabling the rx IRQ until space becomes available.
+			 */
+			do {
+				serial_inp(info, UART_RX);
+				icount->overrun++;
+				*status = serial_inp(info, UART_LSR);
+			} while ((*status & UART_LSR_DR) && (max_count-- > 0));
+			return;		// if TTY_DONT_FLIP is set
 		}
 		ch = serial_inp(info, UART_RX);
 		*tty->flip.char_buf_ptr = ch;
--- a/drivers/char/tty_io.c	2004-04-14 08:05:29.000000000 -0500
+++ b/drivers/char/tty_io.c	2004-10-01 10:49:45.000000000 -0500
@@ -1944,32 +1944,34 @@ static void flush_to_ldisc(void *private
 	int		count;
 	unsigned long flags;
 
-	if (test_bit(TTY_DONT_FLIP, &tty->flags)) {
-		queue_task(&tty->flip.tqueue, &tq_timer);
-		return;
-	}
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
+	while(tty->flip.count) {
+		if (test_bit(TTY_DONT_FLIP, &tty->flags)) {
+			queue_task(&tty->flip.tqueue, &tq_timer);
+			return;
+		}
+		if (tty->flip.buf_num) {
+			cp = tty->flip.char_buf + TTY_FLIPBUF_SIZE;
+			fp = tty->flip.flag_buf + TTY_FLIPBUF_SIZE;
+			tty->flip.buf_num = 0;
+
+			save_flags(flags); cli();
+			tty->flip.char_buf_ptr = tty->flip.char_buf;
+			tty->flip.flag_buf_ptr = tty->flip.flag_buf;
+		} else {
+			cp = tty->flip.char_buf;
+			fp = tty->flip.flag_buf;
+			tty->flip.buf_num = 1;
+
+			save_flags(flags); cli();
+			tty->flip.char_buf_ptr = tty->flip.char_buf + TTY_FLIPBUF_SIZE;
+			tty->flip.flag_buf_ptr = tty->flip.flag_buf + TTY_FLIPBUF_SIZE;
+		}
+		count = tty->flip.count;
+		tty->flip.count = 0;
+		restore_flags(flags);
 	
-	tty->ldisc.receive_buf(tty, cp, fp, count);
+		tty->ldisc.receive_buf(tty, cp, fp, count);
+	}
 }
 
 /*


