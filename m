Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261460AbVCXNUZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261460AbVCXNUZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 08:20:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262449AbVCXNUY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 08:20:24 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:27402 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261460AbVCXNUD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 08:20:03 -0500
Date: Thu, 24 Mar 2005 13:19:57 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: jongk@linux-m68k.org, geert@linux-m68k.org
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: 8250_hp300: unuse register_serial/unregister_serial
Message-ID: <20050324131956.B4189@flint.arm.linux.org.uk>
Mail-Followup-To: jongk@linux-m68k.org, geert@linux-m68k.org,
	Linux Kernel List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kars, Geert,

Here's a patch which converts 8250_hp300 to use serial8250_register_port
and serial8250_unregister_port, rather than register_serial/
unregister_serial.

The 8250-variants allow you to associate the struct device with the port,
allowing sysfs to indicate which device owns which serial port.  Plus, we
stop using a potentially obsolete (and functionally inferior) function.

This patch is untested; please test, and send bug fixes.

Note: if you need power management, that should come via your device
driver, calling serial8250_suspend_port() / serial8250_resume_port()
as appropriate.

Thanks.

diff -up -x BitKeeper -x ChangeSet -x SCCS -x _xlk -x *.orig -x *.rej orig/drivers/serial/8250_hp300.c linux/drivers/serial/8250_hp300.c
--- orig/drivers/serial/8250_hp300.c	Thu Mar 24 12:26:42 2005
+++ linux/drivers/serial/8250_hp300.c	Thu Mar 24 13:12:33 2005
@@ -163,7 +163,7 @@ int __init hp300_setup_serial_console(vo
 static int __devinit hpdca_init_one(struct dio_dev *d,
                                 const struct dio_device_id *ent)
 {
-	struct serial_struct serial_req;
+	struct uart_port port;
 	int line;
 
 #ifdef CONFIG_SERIAL_8250_CONSOLE
@@ -172,17 +172,18 @@ static int __devinit hpdca_init_one(stru
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
+	port.membase = (char *)(serial_req.iomap_base + DIO_VIRADDRBASE);
+	port.regshift = 1;
+	port.dev = &d->dev;
+	line = serial8250_register_port(&port);
 
 	if (line < 0) {
 		printk(KERN_NOTICE "8250_hp300: register_serial() DCA scode %d"
@@ -209,7 +210,7 @@ static int __init hp300_8250_init(void)
 #ifdef CONFIG_HPAPCI
 	int line;
 	unsigned long base;
-	struct serial_struct serial_req;
+	struct uart_port uport;
 	struct hp300_port *port;
 	int i;
 #endif
@@ -251,25 +252,25 @@ static int __init hp300_8250_init(void)
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
+		uport.baud_base = HPAPCI_BAUD_BASE * 16;
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
@@ -299,7 +300,7 @@ static void __devexit hpdca_remove_one(s
 		/* Disable board-interrupts */
 		out_8(d->resource.start + DIO_VIRADDRBASE + DCA_IC, 0);
 	}
-	unregister_serial(line);
+	serial8250_unregister_port(line);
 }
 #endif
 
@@ -309,7 +310,7 @@ static void __exit hp300_8250_exit(void)
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
