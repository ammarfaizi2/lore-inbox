Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262999AbVCJXzr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262999AbVCJXzr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 18:55:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263448AbVCJXxV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 18:53:21 -0500
Received: from nacho.zianet.com ([216.234.192.105]:33295 "HELO
	nacho.zianet.com") by vger.kernel.org with SMTP id S262818AbVCJXsU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 18:48:20 -0500
From: Steven Cole <elenstev@mesatop.com>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: Someting's busted with serial in 2.6.11 latest
Date: Thu, 10 Mar 2005 16:45:19 -0700
User-Agent: KMail/1.6.1
Cc: Stephen Hemminger <shemminger@osdl.org>, linux-kernel@vger.kernel.org,
       linux-serial@vger.kernel.org
References: <20050309155049.4e7cb1f4@dxpl.pdx.osdl.net> <4230CCCB.6030909@mesatop.com> <20050310225939.G1044@flint.arm.linux.org.uk>
In-Reply-To: <20050310225939.G1044@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_QwNMCCQyPrysDan"
Message-Id: <200503101645.23566.elenstev@mesatop.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_QwNMCCQyPrysDan
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Thursday 10 March 2005 03:59 pm, Russell King wrote:
> On Thu, Mar 10, 2005 at 03:40:11PM -0700, Steven Cole wrote:
> > I'll test current bk tonight, but I don't see any recent fix to
> > drivers/serial/8250.c when browsing linux.bkbits.net/linux-2.6.
> 
> Ok, so Stephen's bug is already fixed.  After testing the latest bk, if
> you find your bug isn't resolved, please try to isolate the change by
> applying this patch.  If this doesn't resolve it, then your change of
> behaviour hasn't been caused by changes to 8250.c, but must be down to
> some other part of the kernel.
> 
> ===== linux-2.6-rmk/drivers/serial/8250.c 1.97 vs 1.95 =====
> --- 1.97/drivers/serial/8250.c	2005-03-08 10:04:55 +00:00
> +++ 1.95/drivers/serial/8250.c	2005-02-28 16:05:18 +00:00
> @@ -642,7 +642,6 @@
>  static void autoconfig_16550a(struct uart_8250_port *up)
>  {
>  	unsigned char status1, status2;
> -	unsigned int iersave;
>  
>  	up->port.type = PORT_16550A;
>  	up->capabilities |= UART_CAP_FIFO;
> @@ -729,7 +728,6 @@
>  	serial_outp(up, UART_FCR, UART_FCR_ENABLE_FIFO | UART_FCR7_64BYTE);
>  	status2 = serial_in(up, UART_IIR) >> 5;
>  	serial_outp(up, UART_FCR, UART_FCR_ENABLE_FIFO);
> -	serial_outp(up, UART_LCR, 0);
>  
>  	DEBUG_AUTOCONF("iir1=%d iir2=%d ", status1, status2);
>  
> @@ -738,40 +736,6 @@
>  		up->capabilities |= UART_CAP_AFE | UART_CAP_SLEEP;
>  		return;
>  	}
> -
> -	/*
> -	 * Try writing and reading the UART_IER_UUE bit (b6).
> -	 * If it works, this is probably one of the Xscale platform's
> -	 * internal UARTs.
> -	 * We're going to explicitly set the UUE bit to 0 before
> -	 * trying to write and read a 1 just to make sure it's not
> -	 * already a 1 and maybe locked there before we even start start.
> -	 */
> -	iersave = serial_in(up, UART_IER);
> -	serial_outp(up, UART_IER, iersave & ~UART_IER_UUE);
> -	if (!(serial_in(up, UART_IER) & UART_IER_UUE)) {
> -		/*
> -		 * OK it's in a known zero state, try writing and reading
> -		 * without disturbing the current state of the other bits.
> -		 */
> -		serial_outp(up, UART_IER, iersave | UART_IER_UUE);
> -		if (serial_in(up, UART_IER) & UART_IER_UUE) {
> -			/*
> -			 * It's an Xscale.
> -			 * We'll leave the UART_IER_UUE bit set to 1 (enabled).
> -			 */
> -			DEBUG_AUTOCONF("Xscale ");
> -			up->port.type = PORT_XSCALE;
> -			return;
> -		}
> -	} else {
> -		/*
> -		 * If we got here we couldn't force the IER_UUE bit to 0.
> -		 * Log it and continue.
> -		 */
> -		DEBUG_AUTOCONF("Couldn't force IER_UUE to 0 ");
> -	}
> -	serial_outp(up, UART_IER, iersave);
>  }
>  
>  /*
> 
> 
I am currently doing a bk pull from linux.bkbits.net/linux-2.6, and can test the above 
patch if dialup via a serial modem breaks again, but I think I already know the answer.

I first noticed this _after_ the last one-line change to drivers/serial/8250.c.
Last night, after establishing that 2.6.11-bk1 was the earliest kernel to have the problem,
and reverting the Xscale patch fixed it, I tried with last night's bk-current.
It also failed as previously described, and worked with the Xscale patch reverted.

Here is a snippet from dmesg from my current kernel (with Xscale reverted) working
on dialup.via serial modem.

[   43.034336] serio: i8042 AUX port at 0x60,0x64 irq 12
[   43.034520] serio: i8042 KBD port at 0x60,0x64 irq 1
[   43.034616] Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
[   43.034924] ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[   43.038087] pnp: Device 00:01.00 activated.
[   43.038329] ttyS1 at I/O 0x2f8 (irq = 10) is a 16550A

For completeness, here is the patch I applied with patch -p1 -R:

Steven

--Boundary-00=_QwNMCCQyPrysDan
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="revert-me.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="revert-me.patch"

diff -Nru a/drivers/serial/8250.c b/drivers/serial/8250.c
--- a/drivers/serial/8250.c	2005-02-28 08:05:18 -08:00
+++ b/drivers/serial/8250.c	2005-01-24 08:00:57 -08:00
@@ -642,6 +642,7 @@
 static void autoconfig_16550a(struct uart_8250_port *up)
 {
 	unsigned char status1, status2;
+	unsigned int iersave;
 
 	up->port.type = PORT_16550A;
 	up->capabilities |= UART_CAP_FIFO;
@@ -736,6 +737,40 @@
 		up->capabilities |= UART_CAP_AFE | UART_CAP_SLEEP;
 		return;
 	}
+
+	/*
+	 * Try writing and reading the UART_IER_UUE bit (b6).
+	 * If it works, this is probably one of the Xscale platform's
+	 * internal UARTs.
+	 * We're going to explicitly set the UUE bit to 0 before
+	 * trying to write and read a 1 just to make sure it's not
+	 * already a 1 and maybe locked there before we even start start.
+	 */
+	iersave = serial_in(up, UART_IER);
+	serial_outp(up, UART_IER, iersave & ~UART_IER_UUE);
+	if (!(serial_in(up, UART_IER) & UART_IER_UUE)) {
+		/*
+		 * OK it's in a known zero state, try writing and reading
+		 * without disturbing the current state of the other bits.
+		 */
+		serial_outp(up, UART_IER, iersave | UART_IER_UUE);
+		if (serial_in(up, UART_IER) & UART_IER_UUE) {
+			/*
+			 * It's an Xscale.
+			 * We'll leave the UART_IER_UUE bit set to 1 (enabled).
+			 */
+			DEBUG_AUTOCONF("Xscale ");
+			up->port.type = PORT_XSCALE;
+			return;
+		}
+	} else {
+		/*
+		 * If we got here we couldn't force the IER_UUE bit to 0.
+		 * Log it and continue.
+		 */
+		DEBUG_AUTOCONF("Couldn't force IER_UUE to 0 ");
+	}
+	serial_outp(up, UART_IER, iersave);
 }
 
 /*

--Boundary-00=_QwNMCCQyPrysDan--
