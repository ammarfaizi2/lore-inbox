Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S143434AbRELA3F>; Fri, 11 May 2001 20:29:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S143431AbRELA1d>; Fri, 11 May 2001 20:27:33 -0400
Received: from mailhost.nmt.edu ([129.138.4.52]:17937 "EHLO mailhost.nmt.edu")
	by vger.kernel.org with ESMTP id <S143427AbRELA1Z>;
	Fri, 11 May 2001 20:27:25 -0400
Date: Fri, 11 May 2001 18:27:23 -0600
From: Val Henson <val@nmt.edu>
To: Theodore Tso <tytso@valinux.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] drivers/char/serial.c bug in ST16C654 detection
Message-ID: <20010511182723.M18959@boardwalk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Favorite-Color: Polka dot
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes a bug in the autoconfig_startech_uarts function in
serial.c.  The problem is that 0's are written to the baud rate
registers in order to detect an XR16C850 or XR16C854.  This makes the
Exar ST16C654 go kablooey.  Saving and restoring the baud rate
registers after the test fixes it.

I'm assuming that the XR16C85[04] detection works as is and doesn't
need the original baud rate restored.  If I'm wrong, I'll rewrite the
patch.

-VAL

--- linux-2.4.5-pre1/drivers/char/serial.c	Thu Apr 19 00:26:34 2001
+++ linux/drivers/char/serial.c	Sat May 12 05:19:26 2001
@@ -3507,7 +3507,7 @@
 				      struct serial_state *state,
 				      unsigned long flags)
 {
-	unsigned char scratch, scratch2, scratch3;
+	unsigned char scratch, scratch2, scratch3, scratch4;
 
 	/*
 	 * First we check to see if it's an Oxford Semiconductor UART.
@@ -3551,17 +3551,32 @@
 	 * XR16C854.
 	 * 
 	 */
+
+	/* Save the DLL and DLM */
+
 	serial_outp(info, UART_LCR, UART_LCR_DLAB);
+	scratch3 = serial_inp(info, UART_DLL);
+	scratch4 = serial_inp(info, UART_DLM);
+
 	serial_outp(info, UART_DLL, 0);
 	serial_outp(info, UART_DLM, 0);
-	state->revision = serial_inp(info, UART_DLL);
+	scratch2 = serial_inp(info, UART_DLL);
 	scratch = serial_inp(info, UART_DLM);
 	serial_outp(info, UART_LCR, 0);
+
 	if (scratch == 0x10 || scratch == 0x14) {
+		if (scratch == 0x10)
+			state->revision = scratch2;
 		state->type = PORT_16850;
 		return;
 	}
 
+	/* Restore the DLL and DLM */
+
+	serial_outp(info, UART_LCR, UART_LCR_DLAB);
+	serial_outp(info, UART_DLL, scratch3);
+	serial_outp(info, UART_DLM, scratch4);
+	serial_outp(info, UART_LCR, 0);
 	/*
 	 * We distinguish between the '654 and the '650 by counting
 	 * how many bytes are in the FIFO.  I'm using this for now,

