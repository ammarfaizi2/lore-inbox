Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261830AbVGEOe5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261830AbVGEOe5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 10:34:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261863AbVGEOdK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 10:33:10 -0400
Received: from webapps.arcom.com ([194.200.159.168]:27149 "EHLO
	webapps.arcom.com") by vger.kernel.org with ESMTP id S261830AbVGEOTm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 10:19:42 -0400
Message-ID: <42CA96FC.9000708@arcom.com>
Date: Tue, 05 Jul 2005 15:19:40 +0100
From: David Vrabel <dvrabel@arcom.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: rmk+serial@arm.linux.org.uk
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: serial: 8250 fails to detect Exar XR16L2551 correctly
Content-Type: multipart/mixed;
 boundary="------------070508090102050304080704"
X-OriginalArrivalTime: 05 Jul 2005 14:30:10.0359 (UTC) FILETIME=[0C5ACC70:01C5816E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070508090102050304080704
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi,

The 8250 serial driver detects the Exar XR16L2551 as a 16550A.  The
XR16L2551 has an EFR register and sleep capabilities (UART_CAP_FIFO |
UART_CAP_EFR | UART_CAP_SLEEP).  However, broken_efr() thinks it's a
buggy Exar ST16C255x.

Any suggestion on how to differentiate between the two parts?  Exar have
made the ST16C255x with the same registers as the XR16L255x...

Perhaps it's okay for the ST16C255x to be detected as something with
UART_CAP_EFR | UART_CAP_SLEEP even if it doesn't work? i.e., by removing
broken_efr().

Also, the initial IER test was failing (after a soft reboot) with the
XR16L2551 part since the sleep mode bit was set but was read-only.  It
seems sensible to make this test only look at the lower 4 bits.

David Vrabel
-- 
David Vrabel, Design Engineer

Arcom, Clifton Road           Tel: +44 (0)1223 411200 ext. 3233
Cambridge CB1 7EA, UK         Web: http://www.arcom.com/

--------------070508090102050304080704
Content-Type: text/plain;
 name="serial-XR16550"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="serial-XR16550"

%state
pending
%patch
Index: linux-2.6-working/drivers/serial/8250.c
===================================================================
--- linux-2.6-working.orig/drivers/serial/8250.c	2005-07-04 13:43:13.000000000 +0100
+++ linux-2.6-working/drivers/serial/8250.c	2005-07-05 15:08:05.000000000 +0100
@@ -249,6 +249,14 @@
 		.fcr		= UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_10,
 		.flags		= UART_CAP_FIFO | UART_CAP_UUE,
 	},
+	[PORT_XR16550] = {
+		.name		= "XR16550",
+		.fifo_size	= 16,
+		.tx_loadsz	= 16,
+		.fcr		= UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_01 |
+				  UART_FCR_T_TRIG_00,
+		.flags		= UART_CAP_FIFO | UART_CAP_EFR | UART_CAP_SLEEP,
+	},
 };
 
 static _INLINE_ unsigned int serial_in(struct uart_8250_port *up, int offset)
@@ -573,6 +581,15 @@
 		up->port.type = PORT_16850;
 		return;
 	}
+	/* The Exar XR16L255x has an DVID of 0x02. This will misdetect the
+	 * Exar ST16C255x (A2 revision) which has registers like the XR16L255x
+	 * but doesn't have a working sleep mode.  However, it's safe to claim
+	 * sleep capabilities even if they don't work. See also
+	 * http://www.exar.com/info.php?pdf=dan180_oct2004.pdf */
+	if (id2 == 0x02) {
+		up->port.type = PORT_XR16550;
+		return;
+	}
 
 	/*
 	 * It wasn't an XR16C850.
@@ -585,7 +602,7 @@
 	 */
 	if (size_fifo(up) == 64)
 		up->port.type = PORT_16654;
-	else
+	else if(size_fifo(up) == 32)
 		up->port.type = PORT_16650V2;
 }
 
@@ -611,19 +628,6 @@
 		up->port.type = PORT_16450;
 }
 
-static int broken_efr(struct uart_8250_port *up)
-{
-	/*
-	 * Exar ST16C2550 "A2" devices incorrectly detect as
-	 * having an EFR, and report an ID of 0x0201.  See
-	 * http://www.exar.com/info.php?pdf=dan180_oct2004.pdf
-	 */
-	if (autoconfig_read_divisor_id(up) == 0x0201 && size_fifo(up) == 16)
-		return 1;
-
-	return 0;
-}
-
 /*
  * We know that the chip has FIFOs.  Does it have an EFR?  The
  * EFR is located in the same register position as the IIR and
@@ -661,7 +665,7 @@
 	 * (other ST16C650V2 UARTs, TI16C752A, etc)
 	 */
 	serial_outp(up, UART_LCR, 0xBF);
-	if (serial_in(up, UART_EFR) == 0 && !broken_efr(up)) {
+	if (serial_in(up, UART_EFR) == 0) {
 		DEBUG_AUTOCONF("EFRv2 ");
 		autoconfig_has_efr(up);
 		return;
@@ -828,7 +832,7 @@
 #endif
 		scratch3 = serial_inp(up, UART_IER);
 		serial_outp(up, UART_IER, scratch);
-		if (scratch2 != 0 || scratch3 != 0x0F) {
+		if ((scratch2 & 0x0f) != 0 || (scratch3 & 0x0f) != 0x0F) {
 			/*
 			 * We failed; there's nothing here
 			 */
Index: linux-2.6-working/include/linux/serial_core.h
===================================================================
--- linux-2.6-working.orig/include/linux/serial_core.h	2005-07-04 13:43:13.000000000 +0100
+++ linux-2.6-working/include/linux/serial_core.h	2005-07-05 15:07:58.000000000 +0100
@@ -39,7 +39,8 @@
 #define PORT_RSA	13
 #define PORT_NS16550A	14
 #define PORT_XSCALE	15
-#define PORT_MAX_8250	15	/* max port ID */
+#define PORT_XR16550	16
+#define PORT_MAX_8250	16	/* max port ID */
 
 /*
  * ARM specific type numbers.  These are not currently guaranteed

--------------070508090102050304080704--
