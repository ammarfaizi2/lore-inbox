Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261489AbVGGNW7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261489AbVGGNW7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 09:22:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261476AbVGGNUo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 09:20:44 -0400
Received: from webapps.arcom.com ([194.200.159.168]:13321 "EHLO
	webapps.arcom.com") by vger.kernel.org with ESMTP id S261462AbVGGNUZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 09:20:25 -0400
Message-ID: <42CD2C16.1070308@arcom.com>
Date: Thu, 07 Jul 2005 14:20:22 +0100
From: David Vrabel <dvrabel@arcom.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Russell King <rmk+lkml@arm.linux.org.uk>
CC: Alex Williamson <alex.williamson@hp.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: serial: 8250 fails to detect Exar XR16L2551 correctly
References: <42CA96FC.9000708@arcom.com> <20050706195740.A28758@flint.arm.linux.org.uk>
In-Reply-To: <20050706195740.A28758@flint.arm.linux.org.uk>
Content-Type: multipart/mixed;
 boundary="------------090208030900070308080608"
X-OriginalArrivalTime: 07 Jul 2005 13:30:56.0515 (UTC) FILETIME=[1AECBD30:01C582F8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090208030900070308080608
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Russell King wrote:
> On Tue, Jul 05, 2005 at 03:19:40PM +0100, David Vrabel wrote:
> 
>>The 8250 serial driver detects the Exar XR16L2551 as a 16550A.  The
>>XR16L2551 has an EFR register and sleep capabilities (UART_CAP_FIFO |
>>UART_CAP_EFR | UART_CAP_SLEEP).  However, broken_efr() thinks it's a
>>buggy Exar ST16C255x.
>>
>>...
>>
>>Also, the initial IER test was failing (after a soft reboot) with the
>>XR16L2551 part since the sleep mode bit was set but was read-only.  It
>>seems sensible to make this test only look at the lower 4 bits.
> 
> ... or maybe this can be used to test for the buggy version.

I've redid the patch and added a check for this.  Alex, could you test
this version, please.

>>Index: linux-2.6-working/drivers/serial/8250.c
>>===================================================================
>>--- linux-2.6-working.orig/drivers/serial/8250.c	2005-07-04 13:43:13.000000000 +0100
>>+++ linux-2.6-working/drivers/serial/8250.c	2005-07-05 15:08:05.000000000 +0100
>>@@ -249,6 +249,14 @@
>> 		.fcr		= UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_10,
>> 		.flags		= UART_CAP_FIFO | UART_CAP_UUE,
>> 	},
>>+	[PORT_XR16550] = {
>>+		.name		= "XR16550",
>>+		.fifo_size	= 16,
>>+		.tx_loadsz	= 16,
>>+		.fcr		= UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_01 |
>>+				  UART_FCR_T_TRIG_00,
> 
> 
> The docs I've just pulled of Exar's site imply that the XR16L2551
> doesn't have a transmit trigger threshold, so UART_FCR_T_TRIG_00
> shouldn't be specified here.  Also, is there a reason for restricting
> the RX trigger level to 4 instead of 8 bytes?

That's a cut-n-paste mistake.  It should be like the 16550A.

David Vrabel
-- 
David Vrabel, Design Engineer

Arcom, Clifton Road           Tel: +44 (0)1223 411200 ext. 3233
Cambridge CB1 7EA, UK         Web: http://www.arcom.com/

--------------090208030900070308080608
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
--- linux-2.6-working.orig/drivers/serial/8250.c	2005-07-06 16:24:21.000000000 +0100
+++ linux-2.6-working/drivers/serial/8250.c	2005-07-07 14:11:50.000000000 +0100
@@ -249,6 +249,13 @@
 		.fcr		= UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_10,
 		.flags		= UART_CAP_FIFO | UART_CAP_UUE,
 	},
+	[PORT_XR16550] = {
+		.name		= "XR16550",
+		.fifo_size	= 16,
+		.tx_loadsz	= 16,
+		.fcr		= UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_10,
+		.flags		= UART_CAP_FIFO | UART_CAP_EFR | UART_CAP_SLEEP,
+	},
 };
 
 static _INLINE_ unsigned int serial_in(struct uart_8250_port *up, int offset)
@@ -573,6 +580,26 @@
 		up->port.type = PORT_16850;
 		return;
 	}
+	/* The Exar XR16L255x has an DVID of 0x02. This will misdetect the
+	 * Exar ST16C255x (A2 revision) which has registers like the XR16L255x
+	 * but doesn't have a working sleep mode.  See also
+	 * http://www.exar.com/info.php?pdf=dan180_oct2004.pdf */
+	if (id2 == 0x02) {
+		unsigned int ier;
+
+		up->port.type = PORT_XR16550;
+
+		/* If we can't set the sleep mode bit then it may be a buggy
+		 * ST16C255x. FIXME: This test is currently unverified. */
+		serial_out(up, UART_IER, UART_IERX_SLEEP);
+		ier = serial_in(up, UART_IER);
+		serial_out(up, UART_IER, 0);
+		if ((ier & UART_IERX_SLEEP) != UART_IERX_SLEEP) {
+			up->capabilities &= ~(UART_CAP_EFR | UART_CAP_SLEEP);
+			up->port.type = PORT_16550A;
+		}
+		return;
+	}
 
 	/*
 	 * It wasn't an XR16C850.
@@ -585,7 +612,7 @@
 	 */
 	if (size_fifo(up) == 64)
 		up->port.type = PORT_16654;
-	else
+	else if(size_fifo(up) == 32)
 		up->port.type = PORT_16650V2;
 }
 
@@ -611,19 +638,6 @@
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
@@ -661,7 +675,7 @@
 	 * (other ST16C650V2 UARTs, TI16C752A, etc)
 	 */
 	serial_outp(up, UART_LCR, 0xBF);
-	if (serial_in(up, UART_EFR) == 0 && !broken_efr(up)) {
+	if (serial_in(up, UART_EFR) == 0) {
 		DEBUG_AUTOCONF("EFRv2 ");
 		autoconfig_has_efr(up);
 		return;
@@ -828,7 +842,7 @@
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
--- linux-2.6-working.orig/include/linux/serial_core.h	2005-07-06 16:24:21.000000000 +0100
+++ linux-2.6-working/include/linux/serial_core.h	2005-07-07 14:11:35.000000000 +0100
@@ -39,7 +39,8 @@
 #define PORT_RSA	13
 #define PORT_NS16550A	14
 #define PORT_XSCALE	15
-#define PORT_MAX_8250	15	/* max port ID */
+#define PORT_XR16550	16
+#define PORT_MAX_8250	16	/* max port ID */
 
 /*
  * ARM specific type numbers.  These are not currently guaranteed

--------------090208030900070308080608--
