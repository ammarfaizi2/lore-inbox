Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262522AbVAPOJK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262522AbVAPOJK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 09:09:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262521AbVAPOHu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 09:07:50 -0500
Received: from out012pub.verizon.net ([206.46.170.137]:35234 "EHLO
	out012.verizon.net") by vger.kernel.org with ESMTP id S262516AbVAPNxr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 08:53:47 -0500
From: James Nelson <james4765@cwazy.co.uk>
To: linux-kernel@vger.kernel.org, kernel-janitors@lists.osdl.org
Cc: akpm@osdl.org, James Nelson <james4765@cwazy.co.uk>
Message-Id: <20050116135345.30109.2401.51604@localhost.localdomain>
In-Reply-To: <20050116135223.30109.26479.55757@localhost.localdomain>
References: <20050116135223.30109.26479.55757@localhost.localdomain>
Subject: [PATCH 12/13] serial_tx3912: remove cli()/sti() in drivers/char/serial_tx3912.c
X-Authentication-Info: Submitted using SMTP AUTH at out012.verizon.net from [209.158.220.243] at Sun, 16 Jan 2005 07:53:45 -0600
Date: Sun, 16 Jan 2005 07:53:45 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: James Nelson <james4765@gmail.com>

diff -urN --exclude='*~' linux-2.6.11-rc1-mm1-original/drivers/char/serial_tx3912.c linux-2.6.11-rc1-mm1/drivers/char/serial_tx3912.c
--- linux-2.6.11-rc1-mm1-original/drivers/char/serial_tx3912.c	2004-12-24 16:34:57.000000000 -0500
+++ linux-2.6.11-rc1-mm1/drivers/char/serial_tx3912.c	2005-01-16 07:32:19.514527630 -0500
@@ -222,7 +222,7 @@
 	unsigned long flags;
 	unsigned long ints;
 
-	save_and_cli(flags);
+	local_irq_save(flags);
 
 	port = (struct rs_port *)dev_id;
 	rs_dprintk (TX3912_UART_DEBUG_INTERRUPTS, "rs_interrupt (port %p, shift %d)...", port, intshift);
@@ -241,10 +241,8 @@
 		 INTTYPE(UART_PARITYERR_INT) |
 		 INTTYPE(UART_RX_INT)) << intshift);
 
-	if (!port || !port->gs.tty) {
-		restore_flags(flags);
-		return;
-	}
+	if (!port || !port->gs.tty) 
+		goto out;
 
 	/* RX Receiver Holding Register Overrun */
 	if (ints & INTTYPE(UART_RXOVERRUN_INT)) {
@@ -275,7 +273,7 @@
 		receive_char_pio(port);
 	}
 
-	restore_flags(flags);
+out:	local_irq_restore(flags);
 
 	rs_dprintk (TX3912_UART_DEBUG_INTERRUPTS, "end.\n");
 }
@@ -288,7 +286,7 @@
 	unsigned long flags;
 	unsigned long ints;
 
-	save_and_cli(flags);
+	local_irq_save(flags);
 
 	port = (struct rs_port *)dev_id;
 	rs_dprintk (TX3912_UART_DEBUG_INTERRUPTS, "rs_interrupt (port %p, shift %d)...", port, intshift);
@@ -296,10 +294,8 @@
 	/* Get the interrrupts we have enabled */
 	int2status = IntStatus2 & IntEnable2;
 
-	if (!port || !port->gs.tty) {
-		restore_flags(flags);
-		return;
-	}
+	if (!port || !port->gs.tty)
+		goto out;
 
 	/* Get interrupts in easy to use form */
 	ints = int2status >> intshift;
@@ -324,7 +320,7 @@
 	check_modem_status();
 	*/
 
-	restore_flags(flags);
+out:	local_irq_restore(flags);
 
 	rs_dprintk (TX3912_UART_DEBUG_INTERRUPTS, "end.\n");
 }
@@ -352,7 +348,7 @@
 	struct rs_port *port = ptr; 
 	unsigned long flags;
 
-	save_and_cli(flags);
+	local_irq_save(flags);
         port->gs.flags &= ~GS_TX_INTEN;
 
 	IntEnable2 &= ~((INTTYPE(UART_TX_INT) |
@@ -363,7 +359,7 @@
 			INTTYPE(UART_EMPTY_INT) |
 			INTTYPE(UART_TXOVERRUN_INT)) << port->intshift;
 
-	restore_flags(flags);
+	local_irq_restore(flags);
 }
 
 static void rs_enable_tx_interrupts (void * ptr) 
@@ -371,7 +367,7 @@
 	struct rs_port *port = ptr; 
 	unsigned long flags;
 
-	save_and_cli(flags);
+	local_irq_save(flags);
 
 	IntClear2 = (INTTYPE(UART_TX_INT) |
 			INTTYPE(UART_EMPTY_INT) |
@@ -384,7 +380,7 @@
 	/* Send a char to start TX interrupts happening */
 	transmit_char_pio(port);
 
-	restore_flags(flags);
+	local_irq_restore(flags);
 }
 
 static void rs_disable_rx_interrupts (void * ptr) 
@@ -392,7 +388,7 @@
 	struct rs_port *port = ptr;
 	unsigned long flags;
 
-	save_and_cli(flags);
+	local_irq_save(flags);
 
 	IntEnable2 &= ~((INTTYPE(UART_RX_INT) |
 			 INTTYPE(UART_RXOVERRUN_INT) |
@@ -406,7 +402,7 @@
 			 INTTYPE(UART_BREAK_INT) |
 			 INTTYPE(UART_PARITYERR_INT)) << port->intshift;
 
-	restore_flags(flags);
+	local_irq_restore(flags);
 }
 
 static void rs_enable_rx_interrupts (void * ptr) 
@@ -414,7 +410,7 @@
 	struct rs_port *port = ptr;
 	unsigned long flags;
 
-	save_and_cli(flags);
+	local_irq_save(flags);
 
 	IntEnable2 |= (INTTYPE(UART_RX_INT) |
 			 INTTYPE(UART_RXOVERRUN_INT) |
@@ -433,7 +429,7 @@
 			 INTTYPE(UART_BREAK_INT) |
 			 INTTYPE(UART_PARITYERR_INT)) << port->intshift;
 
-	restore_flags(flags);
+	local_irq_restore(flags);
 }
 
 
