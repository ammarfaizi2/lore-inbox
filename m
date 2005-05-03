Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261693AbVECO0V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261693AbVECO0V (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 10:26:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261637AbVECOTM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 10:19:12 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:35206 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261585AbVECORX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 10:17:23 -0400
Subject: Re: Garbage on serial console after serial driver loads
From: David Woodhouse <dwmw2@infradead.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Phil Oester <kernel@linuxace.com>, linux-kernel@vger.kernel.org,
       trini@kernel.crashing.org
In-Reply-To: <20050328200243.C2222@flint.arm.linux.org.uk>
References: <20050328173652.GA31354@linuxace.com>
	 <20050328200243.C2222@flint.arm.linux.org.uk>
Content-Type: text/plain
Date: Tue, 03 May 2005 15:17:12 +0100
Message-Id: <1115129833.4446.23.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-1.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-03-28 at 20:02 +0100, Russell King wrote:
> Is this patch ok for you?

Not really; it's just a quick hack applied without any real
consideration of the problem. If we're messing up the baud rate when we
change the master clock, then just make it change the divisor
accordingly at the same time. We don't seem to store the active
parameters of the serial console anywhere useful; we can do it just by
reading back the divisor and multiplying by eight though...

Tom, does this also mean you don't need the 'ifndef ppc'?

--- linux/drivers/serial/8250.c~	2004-10-18 22:53:08.000000000 +0100
+++ linux/drivers/serial/8250.c	2005-05-03 13:54:39.394011032 +0100
@@ -567,13 +567,25 @@ static void autoconfig_16550a(struct uar
 
 		if ((status2 ^ status1) & UART_MCR_LOOP) {
 #ifndef CONFIG_PPC
+			unsigned short quot;
+
 			serial_outp(up, UART_LCR, 0xE0);
 			status1 = serial_in(up, 0x04); /* EXCR1 */
 			status1 &= ~0xB0; /* Disable LOCK, mask out PRESL[01] */
 			status1 |= 0x10;  /* 1.625 divisor for baud_base --> 921600 */
 			serial_outp(up, 0x04, status1);
-			serial_outp(up, UART_LCR, 0);
 			up->port.uartclk = 921600*16;
+			
+			/* Adjust the baud rate to match, in case we're
+			   already using the port */
+			quot = serial_inp(up, UART_DLM) << 8;
+			quot += serial_inp(up, UART_DLL);
+			quot <<= 3;
+			serial_outp(up, UART_DLL, quot & 0xff);
+			serial_outp(up, UART_DLM, quot >> 8);
+
+			serial_outp(up, UART_LCR, 0);
+
 #endif
 
 			up->port.type = PORT_NS16550A;


-- 
dwmw2

