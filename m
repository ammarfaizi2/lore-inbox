Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293126AbSB1Je2>; Thu, 28 Feb 2002 04:34:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293206AbSB1JcS>; Thu, 28 Feb 2002 04:32:18 -0500
Received: from bs1.dnx.de ([213.252.143.130]:15261 "EHLO bs1.dnx.de")
	by vger.kernel.org with ESMTP id <S293101AbSB1JaD>;
	Thu, 28 Feb 2002 04:30:03 -0500
Date: Thu, 28 Feb 2002 10:29:17 +0100 (CET)
From: Robert Schwebel <robert@schwebel.de>
X-X-Sender: <robert@callisto.local>
Reply-To: <robert@schwebel.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Dave Jones <davej@suse.de>, Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Serial driver patch for AMD Elans
Message-ID: <Pine.LNX.4.33.0202281024380.2458-100000@callisto.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Below you'll find the part of the AMD Elan patch which deals with a bug in
the processor-integrated serial interface.

The code was discussed with Theodore Ts'o and Russell King - tytso wanted
to send it to Marcelo afterwards, but nothing happened so far, so here's
the patch, against 2.4.18.

Thx,
Robert
--
 +--------------------------------------------------------+
 | Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de |
 | Pengutronix - Linux Solutions for Science and Industry |
 |   Braunschweiger Str. 79,  31134 Hildesheim, Germany   |
 |    Phone: +49-5121-28619-0 |  Fax: +49-5121-28619-4    |
 +--------------------------------------------------------+

diff -urN -X kernel-patches/dontdiff linux-2.4.18/drivers/char/serial.c linux-2.4.18-elan/drivers/char/serial.c
--- linux-2.4.18/drivers/char/serial.c	Mon Feb 25 20:37:57 2002
+++ linux-2.4.18-elan/drivers/char/serial.c	Tue Feb 26 09:58:39 2002
@@ -57,6 +57,11 @@
  * 10/00: add in optional software flow control for serial console.
  *	  Kanoj Sarcar <kanoj@sgi.com>  (Modified by Theodore Ts'o)
  *
+ * 02/02: Fix for AMD Elan bug in transmit irq routine, by
+ *        Christer Weinigel <wingel@hog.ctrl-c.liu.se>,
+ *        Robert Schwebel <robert@schwebel.de>,
+ *        Juergen Beisert <jbeisert@eurodsn.de>,
+ *        Theodore Ts'o <tytso@mit.edu>
  */

 static char *serial_version = "5.05c";
@@ -801,7 +806,7 @@
  */
 static void rs_interrupt(int irq, void *dev_id, struct pt_regs * regs)
 {
-	int status;
+	int status, iir;
 	struct async_struct * info;
 	int pass_counter = 0;
 	struct async_struct *end_mark = 0;
@@ -826,7 +831,7 @@

 	do {
 		if (!info->tty ||
-		    (serial_in(info, UART_IIR) & UART_IIR_NO_INT)) {
+		    ((iir=serial_in(info, UART_IIR)) & UART_IIR_NO_INT)) {
 			if (!end_mark)
 				end_mark = info;
 			goto next;
@@ -845,7 +850,9 @@
 		if (status & UART_LSR_DR)
 			receive_chars(info, &status, regs);
 		check_modem_status(info);
-		if (status & UART_LSR_THRE)
+		if ((status & UART_LSR_THRE) ||
+			/* for buggy ELAN processors */
+			((iir & UART_IIR_ID) == UART_IIR_THRI))
 			transmit_chars(info, 0);

 	next:
@@ -879,7 +886,7 @@
  */
 static void rs_interrupt_single(int irq, void *dev_id, struct pt_regs * regs)
 {
-	int status;
+	int status, iir;
 	int pass_counter = 0;
 	struct async_struct * info;
 #ifdef CONFIG_SERIAL_MULTIPORT
@@ -901,6 +908,7 @@
 		first_multi = inb(multi->port_monitor);
 #endif

+	iir = serial_in(info, UART_IIR);
 	do {
 		status = serial_inp(info, UART_LSR);
 #ifdef SERIAL_DEBUG_INTR
@@ -909,18 +917,21 @@
 		if (status & UART_LSR_DR)
 			receive_chars(info, &status, regs);
 		check_modem_status(info);
-		if (status & UART_LSR_THRE)
+		if ((status & UART_LSR_THRE) ||
+		    /* For buggy ELAN processors */
+		    ((iir & UART_IIR_ID) == UART_IIR_THRI))
 			transmit_chars(info, 0);
 		if (pass_counter++ > RS_ISR_PASS_LIMIT) {
-#if 0
+#if SERIAL_DEBUG_INTR
 			printk("rs_single loop break.\n");
 #endif
 			break;
 		}
+		iir = serial_in(info, UART_IIR);
 #ifdef SERIAL_DEBUG_INTR
-		printk("IIR = %x...", serial_in(info, UART_IIR));
+		printk("IIR = %x...", iir);
 #endif
-	} while (!(serial_in(info, UART_IIR) & UART_IIR_NO_INT));
+	} while ((iir & UART_IIR_NO_INT) == 0);
 	info->last_active = jiffies;
 #ifdef CONFIG_SERIAL_MULTIPORT
 	if (multi->port_monitor)


