Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265249AbSJaRun>; Thu, 31 Oct 2002 12:50:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265251AbSJaRun>; Thu, 31 Oct 2002 12:50:43 -0500
Received: from adsl-67-120-62-187.dsl.lsan03.pacbell.net ([67.120.62.187]:18956
	"EHLO exchange.macrolink.com") by vger.kernel.org with ESMTP
	id <S265249AbSJaRuX>; Thu, 31 Oct 2002 12:50:23 -0500
Message-ID: <11E89240C407D311958800A0C9ACF7D1A33C8A@EXCHANGE>
From: Ed Vance <EdV@macrolink.com>
To: "'linux-serial'" <linux-serial@vger.kernel.org>,
       "'linux-kernel'" <linux-kernel@vger.kernel.org>
Cc: "'Marcelo Tosatti'" <marcelo@conectiva.com.br>
Subject: [PATCH] 2.4.20-rc1 16654 UART drops xmit data
Date: Thu, 31 Oct 2002 09:56:48 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix for dropped xmit data on 16654 UART. 

serial.c 2.4.20-rc1

This trivial patch limits execution of the Elan work-around code to 
UARTs detected as type 8250, 16450, 16550 and 16550A. During transmit,
the Exar 16C654 UART frequently has leftover THRI status visible in 
its IIR register when the THRE status is not present in the LSR 
register and a transmit interrupt is not pending. This interacts with 
the Elan LSR timing work-around to cause serial driver to write more 
data to a 16C654 UART before the UART is ready to take it. 

---------------------------------------------------------------- 
Ed Vance              edv (at) macrolink (dot) com
Macrolink, Inc.       1500 N. Kellogg Dr  Anaheim, CA  92807
----------------------------------------------------------------

diff -urN -X dontdiff.txt linux-2.4.20-rc1/drivers/char/serial.c
linux-654fix/drivers/char/serial.c
--- linux-2.4.20-rc1/drivers/char/serial.c	Mon Oct 28 12:19:17 2002
+++ linux-654fix/drivers/char/serial.c	Wed Oct 30 10:12:00 2002
@@ -792,6 +792,23 @@
 	}
 }
 
+/*
+ * Returns != 0 (true) if UART is ready for more transmit data.
+ * This function contains a work-around for a silicon bug in the UARTs 
+ * of the AMD Elan microcontroller. The LSR THRE bit is set late and 
+ * may be missed by the interrupt routine, so an IIR THRI status is also
+ * treated as an LSR THRE status. This causes xmit data loss on 16C654 
+ * UARTs (and perhaps others) so the work-around is applied only to 
+ * ports detected as generic UART types 8250, 16450, 16550 and 16550A. 
+ */
+static _INLINE_ int uart_transmit_ready(struct async_struct *info,
+					int status, int iir)
+{
+	return (status & UART_LSR_THRE) || 
+	       ((info->state->type <= PORT_16550A) &&
+	        ((iir & UART_IIR_ID) == UART_IIR_THRI));
+}
+
 #ifdef CONFIG_SERIAL_SHARE_IRQ
 /*
  * This is the serial driver's generic interrupt routine
@@ -842,9 +859,7 @@
 		if (status & UART_LSR_DR)
 			receive_chars(info, &status, regs);
 		check_modem_status(info);
-		if ((status & UART_LSR_THRE) ||
-			/* for buggy ELAN processors */
-			((iir & UART_IIR_ID) == UART_IIR_THRI))
+		if (uart_transmit_ready(info, status, iir))
 			transmit_chars(info, 0);
 
 	next:
@@ -909,9 +924,7 @@
 		if (status & UART_LSR_DR)
 			receive_chars(info, &status, regs);
 		check_modem_status(info);
-		if ((status & UART_LSR_THRE) ||
-		    /* For buggy ELAN processors */
-		    ((iir & UART_IIR_ID) == UART_IIR_THRI))
+		if (uart_transmit_ready(info, status, iir))
 			transmit_chars(info, 0);
 		if (pass_counter++ > RS_ISR_PASS_LIMIT) {
 #if SERIAL_DEBUG_INTR
