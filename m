Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262110AbVCHU3y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262110AbVCHU3y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 15:29:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262119AbVCHU2R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 15:28:17 -0500
Received: from mailout06.sul.t-online.com ([194.25.134.19]:39085 "EHLO
	mailout06.sul.t-online.com") by vger.kernel.org with ESMTP
	id S262209AbVCHT7P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 14:59:15 -0500
Message-ID: <422E03B0.9090208@t-online.de>
Date: Tue, 08 Mar 2005 20:57:36 +0100
From: Michael Berger <mikeb1@t-online.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041020
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Modem connection problems with Kernel 2.6.11-bk1 + bk2
Content-Type: multipart/mixed;
 boundary="------------040504090308010801050205"
X-ID: E44R8EZprecge+qbD2atBDWPJPaYbMSlKhk92PrMmojfrOBYPIl-rq
X-TOI-MSGID: bb760116-8c17-45ff-b42b-e70d8ddb36e6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040504090308010801050205
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Michael Berger wrote:
 >Dear LKML
 >
 >Since Kernel Release 2.6.11-bk1 + bk2 it is not possible to connect in 
 >to the Internet via a modem connection.
 >
 >Following message is in my System Log:
 >
 >> Mar  6 19:02:08 Odin wvdial[3079]: stdin not read/write and $MODEM 
 >not set Mar  6 19:02:08 Odin pppd[3032]: Connect script failed
 >
 >
 >Kernel 2.6.11 works without any problems. Attached is my config file.
 >
 >Best regards,
 >
 >
 >-- Michael

-- snip->

Dear LKML

Reverting attached patch fixes my serial modem connection problem.

Best regards,


-- Michael


--------------040504090308010801050205
Content-Type: text/plain;
 name="b_drivers_serial_8250.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="b_drivers_serial_8250.c"

diff -Nru a/drivers/serial/8250.c b/drivers/serial/8250.c
--- a/drivers/serial/8250.c	2005-02-28 08:05:18 -08:00
+++ b/drivers/serial/8250.c	2005-01-24 08:00:57 -08:00
@@ -642,6 +642,7 @@
 static void autoconfig_16550a(struct uart_8250_port *up)
 {
 	unsigned char status1, status2;
+	unsigned int iersave;
 
 	up->port.type = PORT_16550A;
 	up->capabilities |= UART_CAP_FIFO;
@@ -736,6 +737,40 @@
 		up->capabilities |= UART_CAP_AFE | UART_CAP_SLEEP;
 		return;
 	}
+
+	/*
+	 * Try writing and reading the UART_IER_UUE bit (b6).
+	 * If it works, this is probably one of the Xscale platform's
+	 * internal UARTs.
+	 * We're going to explicitly set the UUE bit to 0 before
+	 * trying to write and read a 1 just to make sure it's not
+	 * already a 1 and maybe locked there before we even start start.
+	 */
+	iersave = serial_in(up, UART_IER);
+	serial_outp(up, UART_IER, iersave & ~UART_IER_UUE);
+	if (!(serial_in(up, UART_IER) & UART_IER_UUE)) {
+		/*
+		 * OK it's in a known zero state, try writing and reading
+		 * without disturbing the current state of the other bits.
+		 */
+		serial_outp(up, UART_IER, iersave | UART_IER_UUE);
+		if (serial_in(up, UART_IER) & UART_IER_UUE) {
+			/*
+			 * It's an Xscale.
+			 * We'll leave the UART_IER_UUE bit set to 1 (enabled).
+			 */
+			DEBUG_AUTOCONF("Xscale ");
+			up->port.type = PORT_XSCALE;
+			return;
+		}
+	} else {
+		/*
+		 * If we got here we couldn't force the IER_UUE bit to 0.
+		 * Log it and continue.
+		 */
+		DEBUG_AUTOCONF("Couldn't force IER_UUE to 0 ");
+	}
+	serial_outp(up, UART_IER, iersave);
 }
 
 /*

--------------040504090308010801050205--
