Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261312AbVBGU32@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261312AbVBGU32 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 15:29:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261296AbVBGU2s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 15:28:48 -0500
Received: from mail.aknet.ru ([217.67.122.194]:19721 "EHLO mail.aknet.ru")
	by vger.kernel.org with ESMTP id S261312AbVBGU1Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 15:27:24 -0500
Message-ID: <4207CFED.8020509@aknet.ru>
Date: Mon, 07 Feb 2005 23:30:37 +0300
From: Stas Sergeev <stsp@aknet.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041020
X-Accept-Language: ru, en-us, en
MIME-Version: 1.0
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: lockup when accessing serial port (and fix)
Content-Type: multipart/mixed;
 boundary="------------060009030602020707020109"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060009030602020707020109
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello.

When I am trying to use the serial
port, I am getting the machine lockup.
This started to happen sometime in a
2.6.9 era I think, and is not fixed
in the latest 2.6.11 pre's.
The bug looks trivial, unless I am
missing something. "port.lock" is
acquired in serial8250_interrupt()
and later in uart_start(), and that's
where the system is dead.
The calltrace is as follows:

serial8250_interrupt->!spin_lock(port.lock)!->serial8250_handle_port->
receive_chars->tty_flip_buffer_push->flush_to_ldisc->n_tty_receive_buf->
uart_flush_chars->uart_start->!spin_lock(port.lock)!->deadlock:(

Attached is a quick works-for-me fix
that just releases the lock at one
point. Can someone please have a look
into it and see if the other ser drivers
needs the same (or another) treatment?
Well, I can understand that the legacy
ser ports may not be too popular these
days, but then it is a local DoS, so it
may still be worth having a look.
I'll very much appreciate if the serial
port is to work again. I am still using
it, really! :)


--------------060009030602020707020109
Content-Type: text/x-patch;
 name="ser_lock.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ser_lock.diff"

--- linux-2.6.10/drivers/serial/au1x00_uart.c	2004-12-31 10:16:15.000000000 +0300
+++ linux-2.6.10/drivers/serial/au1x00_uart.c	2005-02-07 15:42:42.000000000 +0300
@@ -320,7 +320,9 @@
 	ignore_char:
 		*status = serial_inp(up, UART_LSR);
 	} while ((*status & UART_LSR_DR) && (max_count-- > 0));
+	spin_unlock(&up->port.lock);
 	tty_flip_buffer_push(tty);
+	spin_lock(&up->port.lock);
 }
 
 static _INLINE_ void transmit_chars(struct uart_8250_port *up)
--- linux-2.6.10/drivers/serial/8250.c	2005-02-07 13:47:57.000000000 +0300
+++ linux-2.6.10/drivers/serial/8250.c	2005-02-07 15:43:47.000000000 +0300
@@ -1059,7 +1059,9 @@
 	ignore_char:
 		lsr = serial_inp(up, UART_LSR);
 	} while ((lsr & UART_LSR_DR) && (max_count-- > 0));
+	spin_unlock(&up->port.lock);
 	tty_flip_buffer_push(tty);
+	spin_lock(&up->port.lock);
 	*status = lsr;
 }
 

--------------060009030602020707020109--
