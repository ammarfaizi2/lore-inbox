Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261228AbVDDNno@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261228AbVDDNno (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 09:43:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261232AbVDDNno
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 09:43:44 -0400
Received: from smtpq2.home.nl ([213.51.128.197]:5776 "EHLO smtpq2.home.nl")
	by vger.kernel.org with ESMTP id S261228AbVDDNnj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 09:43:39 -0400
Subject: Re: [RESEND 1] 8250_hp300: unuse register_serial/unregister_serial
From: Kars de Jong <jongk@linux-m68k.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Russell King <rmk@arm.linux.org.uk>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.62.0504041051390.14107@numbat.sonytel.be>
References: <20050404094934.A32454@flint.arm.linux.org.uk>
	 <Pine.LNX.4.62.0504041051390.14107@numbat.sonytel.be>
Content-Type: text/plain
Date: Mon, 04 Apr 2005 15:43:32 +0200
Message-Id: <1112622212.5662.7.camel@kars.perseus.home>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
Content-Transfer-Encoding: 7bit
X-AtHome-MailScanner-Information: Please contact support@home.nl for more information
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-04-04 at 10:52 +0200, Geert Uytterhoeven wrote:
> 	Hi Russell,
> 
> On Mon, 4 Apr 2005, Russell King wrote:
> > ----- Forwarded message from Russell King <rmk@arm.linux.org.uk> -----
> > 
> > Date:	Thu, 24 Mar 2005 13:19:57 +0000
> > From:	Russell King <rmk@arm.linux.org.uk>
> > To:	jongk@linux-m68k.org, geert@linux-m68k.org
> > Cc:	Linux Kernel List <linux-kernel@vger.kernel.org>
> > Subject: 8250_hp300: unuse register_serial/unregister_serial
> > 
> > Kars, Geert,
> > 
> > Here's a patch which converts 8250_hp300 to use serial8250_register_port
> > and serial8250_unregister_port, rather than register_serial/
> > unregister_serial.
> > 
> > The 8250-variants allow you to associate the struct device with the port,
> > allowing sysfs to indicate which device owns which serial port.  Plus, we
> > stop using a potentially obsolete (and functionally inferior) function.
> > 
> > This patch is untested; please test, and send bug fixes.
> > 
> > Note: if you need power management, that should come via your device
> > driver, calling serial8250_suspend_port() / serial8250_resume_port()
> > as appropriate.
> 
> For me it's OK. But I don't have an HP9000/300 to test. Kars?

Sorry, I've been busy the past few days (getting married and stuff), I
did look at the patch but didn't get around to send a reply.

I needed the following extra changes, after that it compiles and works
on my HP300:

Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
ttyS0 at MMIO 0x690011 (irq = 5) is a 16550A
ttyS1 at MMIO 0x41c040 (irq = 0) is a 16550
ttyS2 at MMIO 0x41c060 (irq = 0) is a 16550


Kind regards,

Kars.

--- linux-2.6-m68k-hp/drivers/serial/8250_hp300.c	2005-04-04 15:38:13.448568529 +0200
+++ linux-2.6-m68k-hp/drivers/serial/8250_hp300.c.new	2005-04-04 15:11:27.000000000 +0200
@@ -9,15 +9,15 @@
 #include <linux/init.h>
 #include <linux/string.h>
 #include <linux/kernel.h>
-#include <linux/tty.h>
 #include <linux/serial.h>
-#include <linux/serialP.h>
 #include <linux/serial_core.h>
 #include <linux/delay.h>
 #include <linux/dio.h>
 #include <linux/console.h>
 #include <asm/io.h>
 
+#include "8250.h"
+
 #if !defined(CONFIG_HPDCA) && !defined(CONFIG_HPAPCI)
 #warning CONFIG_8250 defined but neither CONFIG_HPDCA nor CONFIG_HPAPCI defined, are you sure?
 #endif
@@ -180,14 +180,14 @@
 	port.irq = d->ipl;
 	port.uartclk = HPDCA_BAUD_BASE * 16;
 	port.mapbase = (d->resource.start + UART_OFFSET);
-	port.membase = (char *)(serial_req.iomap_base + DIO_VIRADDRBASE);
+	port.membase = (char *)(port.mapbase + DIO_VIRADDRBASE);
 	port.regshift = 1;
 	port.dev = &d->dev;
 	line = serial8250_register_port(&port);
 
 	if (line < 0) {
 		printk(KERN_NOTICE "8250_hp300: register_serial() DCA scode %d"
-		       " irq %d failed\n", d->scode, serial_req.irq);
+		       " irq %d failed\n", d->scode, port.irq);
 		return -ENOMEM;
 	}
 
@@ -261,7 +261,7 @@
 		uport.flags = UPF_SKIP_TEST | UPF_SHARE_IRQ | UPF_BOOT_AUTOCONF;
 		/* XXX - no interrupt support yet */
 		uport.irq = 0;
-		uport.baud_base = HPAPCI_BAUD_BASE * 16;
+		uport.uartclk = HPAPCI_BAUD_BASE * 16;
 		uport.mapbase = base;
 		uport.membase = (char *)(base + DIO_VIRADDRBASE);
 		uport.regshift = 2;


