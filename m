Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262470AbVGFWQH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262470AbVGFWQH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 18:16:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262462AbVGFUJ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 16:09:27 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:49421 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262463AbVGFS5q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 14:57:46 -0400
Date: Wed, 6 Jul 2005 19:57:40 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: David Vrabel <dvrabel@arcom.com>, Alex Williamson <alex.williamson@hp.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: serial: 8250 fails to detect Exar XR16L2551 correctly
Message-ID: <20050706195740.A28758@flint.arm.linux.org.uk>
Mail-Followup-To: David Vrabel <dvrabel@arcom.com>,
	Alex Williamson <alex.williamson@hp.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <42CA96FC.9000708@arcom.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="5mCyUwZo2JvN/JJP"
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <42CA96FC.9000708@arcom.com>; from dvrabel@arcom.com on Tue, Jul 05, 2005 at 03:19:40PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--5mCyUwZo2JvN/JJP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 05, 2005 at 03:19:40PM +0100, David Vrabel wrote:
> The 8250 serial driver detects the Exar XR16L2551 as a 16550A.  The
> XR16L2551 has an EFR register and sleep capabilities (UART_CAP_FIFO |
> UART_CAP_EFR | UART_CAP_SLEEP).  However, broken_efr() thinks it's a
> buggy Exar ST16C255x.

Grumble!

> Any suggestion on how to differentiate between the two parts?  Exar have
> made the ST16C255x with the same registers as the XR16L255x...

If they're 100% identical in terms of the registers, then it's probably
impossible to differentiate between the two.

> Perhaps it's okay for the ST16C255x to be detected as something with
> UART_CAP_EFR | UART_CAP_SLEEP even if it doesn't work? i.e., by removing
> broken_efr().

I don't know - maybe Alex Williamson can try your patch out.

> Also, the initial IER test was failing (after a soft reboot) with the
> XR16L2551 part since the sleep mode bit was set but was read-only.  It
> seems sensible to make this test only look at the lower 4 bits.

... or maybe this can be used to test for the buggy version.

> Index: linux-2.6-working/drivers/serial/8250.c
> ===================================================================
> --- linux-2.6-working.orig/drivers/serial/8250.c	2005-07-04 13:43:13.000000000 +0100
> +++ linux-2.6-working/drivers/serial/8250.c	2005-07-05 15:08:05.000000000 +0100
> @@ -249,6 +249,14 @@
>  		.fcr		= UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_10,
>  		.flags		= UART_CAP_FIFO | UART_CAP_UUE,
>  	},
> +	[PORT_XR16550] = {
> +		.name		= "XR16550",
> +		.fifo_size	= 16,
> +		.tx_loadsz	= 16,
> +		.fcr		= UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_01 |
> +				  UART_FCR_T_TRIG_00,

The docs I've just pulled of Exar's site imply that the XR16L2551
doesn't have a transmit trigger threshold, so UART_FCR_T_TRIG_00
shouldn't be specified here.  Also, is there a reason for restricting
the RX trigger level to 4 instead of 8 bytes?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core

--5mCyUwZo2JvN/JJP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=serial-XR16550

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

--5mCyUwZo2JvN/JJP--
