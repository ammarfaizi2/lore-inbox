Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263356AbVCJXFv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263356AbVCJXFv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 18:05:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263364AbVCJXCz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 18:02:55 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:29704 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262362AbVCJW7v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 17:59:51 -0500
Date: Thu, 10 Mar 2005 22:59:40 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Steven Cole <elenstev@mesatop.com>
Cc: Stephen Hemminger <shemminger@osdl.org>, linux-kernel@vger.kernel.org,
       linux-serial@vger.kernel.org
Subject: Re: Someting's busted with serial in 2.6.11 latest
Message-ID: <20050310225939.G1044@flint.arm.linux.org.uk>
Mail-Followup-To: Steven Cole <elenstev@mesatop.com>,
	Stephen Hemminger <shemminger@osdl.org>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
References: <20050309155049.4e7cb1f4@dxpl.pdx.osdl.net> <20050310195326.A1044@flint.arm.linux.org.uk> <4230CCCB.6030909@mesatop.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <4230CCCB.6030909@mesatop.com>; from elenstev@mesatop.com on Thu, Mar 10, 2005 at 03:40:11PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 10, 2005 at 03:40:11PM -0700, Steven Cole wrote:
> I'll test current bk tonight, but I don't see any recent fix to
> drivers/serial/8250.c when browsing linux.bkbits.net/linux-2.6.

Ok, so Stephen's bug is already fixed.  After testing the latest bk, if
you find your bug isn't resolved, please try to isolate the change by
applying this patch.  If this doesn't resolve it, then your change of
behaviour hasn't been caused by changes to 8250.c, but must be down to
some other part of the kernel.

===== linux-2.6-rmk/drivers/serial/8250.c 1.97 vs 1.95 =====
--- 1.97/drivers/serial/8250.c	2005-03-08 10:04:55 +00:00
+++ 1.95/drivers/serial/8250.c	2005-02-28 16:05:18 +00:00
@@ -642,7 +642,6 @@
 static void autoconfig_16550a(struct uart_8250_port *up)
 {
 	unsigned char status1, status2;
-	unsigned int iersave;
 
 	up->port.type = PORT_16550A;
 	up->capabilities |= UART_CAP_FIFO;
@@ -729,7 +728,6 @@
 	serial_outp(up, UART_FCR, UART_FCR_ENABLE_FIFO | UART_FCR7_64BYTE);
 	status2 = serial_in(up, UART_IIR) >> 5;
 	serial_outp(up, UART_FCR, UART_FCR_ENABLE_FIFO);
-	serial_outp(up, UART_LCR, 0);
 
 	DEBUG_AUTOCONF("iir1=%d iir2=%d ", status1, status2);
 
@@ -738,40 +736,6 @@
 		up->capabilities |= UART_CAP_AFE | UART_CAP_SLEEP;
 		return;
 	}
-
-	/*
-	 * Try writing and reading the UART_IER_UUE bit (b6).
-	 * If it works, this is probably one of the Xscale platform's
-	 * internal UARTs.
-	 * We're going to explicitly set the UUE bit to 0 before
-	 * trying to write and read a 1 just to make sure it's not
-	 * already a 1 and maybe locked there before we even start start.
-	 */
-	iersave = serial_in(up, UART_IER);
-	serial_outp(up, UART_IER, iersave & ~UART_IER_UUE);
-	if (!(serial_in(up, UART_IER) & UART_IER_UUE)) {
-		/*
-		 * OK it's in a known zero state, try writing and reading
-		 * without disturbing the current state of the other bits.
-		 */
-		serial_outp(up, UART_IER, iersave | UART_IER_UUE);
-		if (serial_in(up, UART_IER) & UART_IER_UUE) {
-			/*
-			 * It's an Xscale.
-			 * We'll leave the UART_IER_UUE bit set to 1 (enabled).
-			 */
-			DEBUG_AUTOCONF("Xscale ");
-			up->port.type = PORT_XSCALE;
-			return;
-		}
-	} else {
-		/*
-		 * If we got here we couldn't force the IER_UUE bit to 0.
-		 * Log it and continue.
-		 */
-		DEBUG_AUTOCONF("Couldn't force IER_UUE to 0 ");
-	}
-	serial_outp(up, UART_IER, iersave);
 }
 
 /*


-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
