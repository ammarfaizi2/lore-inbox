Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261659AbTKLWFM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Nov 2003 17:05:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261640AbTKLWFM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Nov 2003 17:05:12 -0500
Received: from arc-relay3.arc.nasa.gov ([128.102.31.196]:13614 "EHLO
	arc-relay3.arc.nasa.gov") by vger.kernel.org with ESMTP
	id S261659AbTKLWFD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Nov 2003 17:05:03 -0500
From: Dan Christian <Daniel.A.Christian@NASA.gov>
Reply-To: dChristian@mail.arc.nasa.gov
Organization: NASA Ames Research Center
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 16654 UART drops transmit characters
Date: Wed, 12 Nov 2003 14:05:01 -0800
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_N6qs/Wd7zU41xsX"
Message-Id: <200311121405.01631.Daniel.A.Christian@NASA.gov>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_N6qs/Wd7zU41xsX
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

A 16654 UART (with 64 byte FIFO and hardware flow control) can drop 
characters on TRANSMIT if hardware flow control is used.  

No UART should ever lose data on transmit, so I consider this a major 
bug.  The bug only shows up if you write chunks of data >64 bytes.

Enclosed is a patch that fixes the problem.  I have tested it under 
2.4.20.  It also applies cleanly under 2.4.22.

This has been reported before, but apparently the patch never made it 
into the Linux kernel.  Ed Vance (edv) at MacroLink developed this fix.  
Part of it fixed some bad code for supporting the buggy Elan 
interrupts.  That part got fixed and is not in the attached patch.  
Other than that, I just updated Ed's patch to apply cleanly against 
current kernels.

-Dan Christian

--Boundary-00=_N6qs/Wd7zU41xsX
Content-Type: text/x-diff;
  charset="us-ascii";
  name="patch_elan4"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="patch_elan4"

--- linux-2.4.20-20.7/drivers/char/serial.c.orig	Mon Aug 18 11:33:18 2003
+++ linux-2.4.20-20.7/drivers/char/serial.c	Wed Nov 12 11:27:31 2003
@@ -797,6 +797,23 @@
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
@@ -919,9 +936,7 @@
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

--Boundary-00=_N6qs/Wd7zU41xsX--
