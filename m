Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261240AbVDDOGi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261240AbVDDOGi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 10:06:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261241AbVDDOGi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 10:06:38 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:8200 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261240AbVDDOGW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 10:06:22 -0400
Date: Mon, 4 Apr 2005 15:06:17 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Kars de Jong <jongk@linux-m68k.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [RESEND 1] 8250_hp300: unuse register_serial/unregister_serial
Message-ID: <20050404150617.A12975@flint.arm.linux.org.uk>
Mail-Followup-To: Kars de Jong <jongk@linux-m68k.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
References: <20050404094934.A32454@flint.arm.linux.org.uk> <Pine.LNX.4.62.0504041051390.14107@numbat.sonytel.be> <1112622212.5662.7.camel@kars.perseus.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1112622212.5662.7.camel@kars.perseus.home>; from jongk@linux-m68k.org on Mon, Apr 04, 2005 at 03:43:32PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 04, 2005 at 03:43:32PM +0200, Kars de Jong wrote:
> Sorry, I've been busy the past few days (getting married and stuff), I
> did look at the patch but didn't get around to send a reply.

Congrats.

> I needed the following extra changes, after that it compiles and works
> on my HP300:
> 
> Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
> ttyS0 at MMIO 0x690011 (irq = 5) is a 16550A
> ttyS1 at MMIO 0x41c040 (irq = 0) is a 16550
> ttyS2 at MMIO 0x41c060 (irq = 0) is a 16550

Thanks for testing.  I've incorporated your changes.  One question - do
you need linux/serial.h included in there?

I attach the updated patch.

diff -up -x BitKeeper -x ChangeSet -x SCCS -x _xlk -x *.orig -x *.rej orig/drivers/serial/8250_hp300.c linux/drivers/serial/8250_hp300.c
--- orig/drivers/serial/8250_hp300.c	Mon Nov 15 09:16:28 2004
+++ linux/drivers/serial/8250_hp300.c	Mon Apr  4 15:03:31 2005
@@ -9,15 +9,14 @@
 #include <linux/init.h>
 #include <linux/string.h>
 #include <linux/kernel.h>
-#include <linux/tty.h>
-#include <linux/serial.h>
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
@@ -163,7 +162,7 @@ int __init hp300_setup_serial_console(vo
 static int __devinit hpdca_init_one(struct dio_dev *d,
                                 const struct dio_device_id *ent)
 {
-	struct serial_struct serial_req;
+	struct uart_port port;
 	int line;
 
 #ifdef CONFIG_SERIAL_8250_CONSOLE
@@ -172,21 +171,22 @@ static int __devinit hpdca_init_one(stru
 		return 0;
 	}
 #endif
-	memset(&serial_req, 0, sizeof(struct serial_struct));
+	memset(&port, 0, sizeof(struct uart_port));
 
 	/* Memory mapped I/O */
-	serial_req.io_type = SERIAL_IO_MEM;
-	serial_req.flags = UPF_SKIP_TEST | UPF_SHARE_IRQ | UPF_BOOT_AUTOCONF;
-	serial_req.irq = d->ipl;
-	serial_req.baud_base = HPDCA_BAUD_BASE;
-	serial_req.iomap_base = (d->resource.start + UART_OFFSET);
-	serial_req.iomem_base = (char *)(serial_req.iomap_base + DIO_VIRADDRBASE);
-	serial_req.iomem_reg_shift = 1;
-	line = register_serial(&serial_req);
+	port.iotype = UPIO_MEM;
+	port.flags = UPF_SKIP_TEST | UPF_SHARE_IRQ | UPF_BOOT_AUTOCONF;
+	port.irq = d->ipl;
+	port.uartclk = HPDCA_BAUD_BASE * 16;
+	port.mapbase = (d->resource.start + UART_OFFSET);
+	port.membase = (char *)(port.mapbase + DIO_VIRADDRBASE);
+	port.regshift = 1;
+	port.dev = &d->dev;
+	line = serial8250_register_port(&port);
 
 	if (line < 0) {
 		printk(KERN_NOTICE "8250_hp300: register_serial() DCA scode %d"
-		       " irq %d failed\n", d->scode, serial_req.irq);
+		       " irq %d failed\n", d->scode, port.irq);
 		return -ENOMEM;
 	}
 
@@ -209,7 +209,7 @@ static int __init hp300_8250_init(void)
 #ifdef CONFIG_HPAPCI
 	int line;
 	unsigned long base;
-	struct serial_struct serial_req;
+	struct uart_port uport;
 	struct hp300_port *port;
 	int i;
 #endif
@@ -251,25 +251,25 @@ static int __init hp300_8250_init(void)
 		if (!port)
 			return -ENOMEM;
 
-		memset(&serial_req, 0, sizeof(struct serial_struct));
+		memset(&uport, 0, sizeof(struct uart_port));
 
 		base = (FRODO_BASE + FRODO_APCI_OFFSET(i));
 
 		/* Memory mapped I/O */
-		serial_req.io_type = SERIAL_IO_MEM;
-		serial_req.flags = UPF_SKIP_TEST | UPF_SHARE_IRQ | UPF_BOOT_AUTOCONF;
+		uport.iotype = UPIO_MEM;
+		uport.flags = UPF_SKIP_TEST | UPF_SHARE_IRQ | UPF_BOOT_AUTOCONF;
 		/* XXX - no interrupt support yet */
-		serial_req.irq = 0;
-		serial_req.baud_base = HPAPCI_BAUD_BASE;
-		serial_req.iomap_base = base;
-		serial_req.iomem_base = (char *)(serial_req.iomap_base + DIO_VIRADDRBASE);
-		serial_req.iomem_reg_shift = 2;
+		uport.irq = 0;
+		uport.uartclk = HPAPCI_BAUD_BASE * 16;
+		uport.mapbase = base;
+		uport.membase = (char *)(base + DIO_VIRADDRBASE);
+		uport.regshift = 2;
 
-		line = register_serial(&serial_req);
+		line = serial8250_register_port(&uport);
 
 		if (line < 0) {
 			printk(KERN_NOTICE "8250_hp300: register_serial() APCI %d"
-			       " irq %d failed\n", i, serial_req.irq);
+			       " irq %d failed\n", i, uport.irq);
 			kfree(port);
 			continue;
 		}
@@ -299,7 +299,7 @@ static void __devexit hpdca_remove_one(s
 		/* Disable board-interrupts */
 		out_8(d->resource.start + DIO_VIRADDRBASE + DCA_IC, 0);
 	}
-	unregister_serial(line);
+	serial8250_unregister_port(line);
 }
 #endif
 
@@ -309,7 +309,7 @@ static void __exit hp300_8250_exit(void)
 	struct hp300_port *port, *to_free;
 
 	for (port = hp300_ports; port; ) {
-		unregister_serial(port->line);
+		serial8250_unregister_port(port->line);
 		to_free = port;
 		port = port->next;
 		kfree(to_free);


-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
