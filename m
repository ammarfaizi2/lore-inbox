Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267447AbTANE3R>; Mon, 13 Jan 2003 23:29:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267452AbTANE3Q>; Mon, 13 Jan 2003 23:29:16 -0500
Received: from TYO201.gate.nec.co.jp ([210.143.35.51]:55168 "EHLO
	TYO201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id <S267447AbTANE3N>; Mon, 13 Jan 2003 23:29:13 -0500
To: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH]  Update v850 nb85e_uart serial driver to set baud min/max
Cc: linux-kernel@vger.kernel.org
Reply-To: Miles Bader <miles@gnu.org>
Message-Id: <20030114043757.C08673715@mcspd15.ucom.lsi.nec.co.jp>
Date: Tue, 14 Jan 2003 13:37:57 +0900 (JST)
From: miles@lsi.nec.co.jp (Miles Bader)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -ruN -X../cludes linux-2.5.57-uc0.orig/drivers/serial/nb85e_uart.c linux-2.5.57-uc0/drivers/serial/nb85e_uart.c
--- linux-2.5.57-uc0.orig/drivers/serial/nb85e_uart.c	2003-01-14 10:24:24.000000000 +0900
+++ linux-2.5.57-uc0/drivers/serial/nb85e_uart.c	2003-01-14 13:24:12.000000000 +0900
@@ -1,8 +1,8 @@
 /*
  * drivers/serial/nb85e_uart.c -- Serial I/O using V850E/NB85E on-chip UART
  *
- *  Copyright (C) 2001,02  NEC Corporation
- *  Copyright (C) 2001,02  Miles Bader <miles@gnu.org>
+ *  Copyright (C) 2001,02,03  NEC Corporation
+ *  Copyright (C) 2001,02,03  Miles Bader <miles@gnu.org>
  *
  * This file is subject to the terms and conditions of the GNU General
  * Public License.  See the file COPYING in the main directory of this
@@ -31,6 +31,9 @@
 #define NB85E_UART_INIT_CFLAGS	(B115200 | CS8 | CREAD)
 #endif
 
+/* XXX This should be in a header file.  */
+#define NB85E_UART_BRGC_MIN	8
+
 /* A string used for prefixing printed descriptions; since the same UART
    macro is actually used on other chips than the V850E/NB85E.  This must
    be a constant string.  */
@@ -39,6 +42,29 @@
 #endif
 
 
+/* Helper functions for doing baud-rate/frequency calculations.  */
+
+/* Calculate the minimum value for CKSR on this processor.  */
+static inline unsigned cksr_min (void)
+{
+	int min = 0;
+	unsigned freq = NB85E_UART_BASE_FREQ;
+	while (freq > NB85E_UART_CKSR_MAX_FREQ) {
+		freq >>= 1;
+		min++;
+	}
+	return min;
+}
+
+/* Minimum baud rate possible.  */
+#define min_baud() \
+   ((NB85E_UART_BASE_FREQ >> NB85E_UART_CKSR_MAX) / (2 * 255) + 1)
+
+/* Maximum baud rate possible.  The error is quite high at max, though.  */
+#define max_baud() \
+   ((NB85E_UART_BASE_FREQ >> cksr_min()) / (2 * NB85E_UART_BRGC_MIN))
+
+
 /* Low-level UART functions.  */
 
 /* These masks define which control bits affect TX/RX modes, respectively.  */
@@ -60,7 +86,7 @@
    modes' bits in CFLAGS, and a baud-rate of BAUD.  */
 void nb85e_uart_configure (unsigned chan, unsigned cflags, unsigned baud)
 {
-	int cksr_min, flags;
+	int flags;
 	unsigned new_config = 0; /* What we'll write to the control reg. */
 	unsigned new_clk_divlog2; /* New baud-rate generate clock divider. */
 	unsigned new_brgen_count; /* New counter max for baud-rate generator.*/
@@ -68,14 +94,12 @@
 	unsigned old_config, old_clk_divlog2, old_brgen_count;
 
 	/* Calculate new baud-rate generator config values.  */
-	cksr_min = 0;
-	while ((NB85E_UART_BASE_FREQ >> cksr_min) > NB85E_UART_CKSR_MAX_FREQ)
-		cksr_min++;
+
 	/* Calculate the log2 clock divider and baud-rate counter values
 	   (note that the UART divides the resulting clock by 2, so
 	   multiply BAUD by 2 here to compensate).  */
 	calc_counter_params (NB85E_UART_BASE_FREQ, baud * 2,
-			     cksr_min, NB85E_UART_CKSR_MAX, 8/*bits*/,
+			     cksr_min(), NB85E_UART_CKSR_MAX, 8/*bits*/,
 			     &new_clk_divlog2, &new_brgen_count);
 
 	/* Figure out new configuration of control register.  */
@@ -443,10 +467,18 @@
 nb85e_uart_set_termios (struct uart_port *port, struct termios *termios,
 		        struct termios *old)
 {
-	/* FIXME: Which termios flags does this driver support? --rmk */
+	unsigned cflags = termios->c_cflag;
 
-	nb85e_uart_configure (port->line, termios->c_cflags,
-			uart_get_baud_rate(port, termios));
+	/* Restrict flags to legal values.  */
+	if ((cflags & CSIZE) != CS7 && (cflags & CSIZE) != CS8)
+		/* The new value of CSIZE is invalid, use the old value.  */
+		cflags = (cflags & ~CSIZE) | (old->c_cflag & CSIZE);
+
+	termios->c_cflag = cflags;
+
+	nb85e_uart_configure (port->line, cflags,
+			      uart_get_baud_rate (port, termios, old,
+						  min_baud(), max_baud()));
 }
 
 static const char *nb85e_uart_type (struct uart_port *port)
@@ -519,7 +551,6 @@
 		unsigned chan;
 
 		for (chan = 0; chan < NB85E_UART_NUM_CHANNELS; chan++) {
-			int cksr_min;
 			struct uart_port *port = &nb85e_uart_ports[chan];
 			
 			memset (port, 0, sizeof *port);
@@ -550,15 +581,13 @@
 			   the framework will puke during its internal
 			   calculations, and force the baud rate to be 9600.
 			   To be accurate though, just repeat the calculation
-			   we use when actually setting the speed.  */
-			cksr_min = 0;
-			while ((NB85E_UART_BASE_FREQ >> cksr_min)
-			       > NB85E_UART_CKSR_MAX_FREQ)
-				cksr_min++;
-			/* The `* 8' means `* 16 / 2':  16 to account for for
+			   we use when actually setting the speed.
+
+			   The `* 8' means `* 16 / 2':  16 to account for for
 			   the serial framework's built-in bias, and 2 because
 			   there's an additional / 2 in the hardware.  */
-			port->uartclk = (NB85E_UART_BASE_FREQ >> cksr_min) * 8;
+			port->uartclk =
+				(NB85E_UART_BASE_FREQ >> cksr_min()) * 8;
 
 			uart_add_one_port (&nb85e_uart_driver, port);
 		}
