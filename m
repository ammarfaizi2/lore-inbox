Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131940AbRBAXVz>; Thu, 1 Feb 2001 18:21:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131709AbRBAXVp>; Thu, 1 Feb 2001 18:21:45 -0500
Received: from [206.112.108.47] ([206.112.108.47]:6404 "EHLO
	mercury.illtel.denver.co.us") by vger.kernel.org with ESMTP
	id <S131940AbRBAXVc>; Thu, 1 Feb 2001 18:21:32 -0500
Date: Thu, 1 Feb 2001 15:20:29 -0800 (PST)
From: Alex Belits <abelits@phobos.illtel.denver.co.us>
To: linux-kernel@vger.kernel.org
cc: Linus Torvalds <torvalds@transmeta.com>
Subject: Serial device with very large buffer
Message-ID: <Pine.LNX.4.10.10101312301110.1478-100000@mercury>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  Greg Pomerantz <gmp@zebware.com> and I have found that Novatel Merlin
for Ricochet PCMCIA card, while looking like otherwise ordinary serial
PCMCIA device, has the receive buffer 576 bytes long. When regular serial
driver reads the arrived data, it often runs out of 512-bytes flip buffer
and discards the rest of the data with rather disastrous consequences for
whatever is expecting it.

  We made a fix that changes the behavior of the driver, so when it fills
the flip buffer while characters are still being read from uart, it flips
the buffer if it's possible or if it's impossible, finishes the loop
without reading the remaining characters.

The patch is:
---8<---
--- linux-2.4.1-orig/drivers/char/serial.c	Wed Dec  6 12:06:18 2000
+++ linux/drivers/char/serial.c	Thu Feb  1 13:14:05 2001
@@ -569,9 +569,16 @@
 
 	icount = &info->state->icount;
 	do {
+		/*
+		 * Check if flip buffer is full -- if it is, try to flip,
+		 * and if flipping got queued, return immediately
+		 */
+		if (tty->flip.count >= TTY_FLIPBUF_SIZE) {
+			tty->flip.tqueue.routine((void *) tty);
+			if (tty->flip.count >= TTY_FLIPBUF_SIZE)
+				return;
+		}
 		ch = serial_inp(info, UART_RX);
-		if (tty->flip.count >= TTY_FLIPBUF_SIZE)
-			goto ignore_char;
 		*tty->flip.char_buf_ptr = ch;
 		icount->rx++;
 		
--->8---

  I also propose to increase the size of flip buffer to 640 bytes (so the
flipping won't occur every time in the middle of the full buffer), however
I understand that it's a rather drastic change for such a simple goal, and
not everyone will agree that it's worth the trouble:

---8<---
--- linux-2.4.1-orig/include/linux/tty.h	Mon Jan 29 23:24:56 2001
+++ linux/include/linux/tty.h	Wed Jan 31 13:06:42 2001
@@ -134,7 +134,7 @@
  * located in the tty structure, and is used as a high speed interface
  * between the tty driver and the tty line discipline.
  */
-#define TTY_FLIPBUF_SIZE 512
+#define TTY_FLIPBUF_SIZE 640
 
 struct tty_flip_buffer {
 	struct tq_struct tqueue;
--->8---

-- 
Alex

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
