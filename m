Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261703AbVC3BCI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261703AbVC3BCI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 20:02:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261704AbVC3BCH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 20:02:07 -0500
Received: from mail.renesas.com ([202.234.163.13]:12731 "EHLO
	mail02.idc.renesas.com") by vger.kernel.org with ESMTP
	id S261703AbVC3BAT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 20:00:19 -0500
Date: Wed, 30 Mar 2005 09:59:48 +0900 (JST)
Message-Id: <20050330.095948.412902706.takata.hirokazu@renesas.com>
To: rmk+lkml@arm.linux.org.uk
Cc: takata@linux-m32r.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.12-rc1-mm3] m32r: m32r_sio driver update (was Re:
 [PATCH] Re: Bitrotting serial drivers)
From: Hirokazu Takata <takata@linux-m32r.org>
In-Reply-To: <20050324121746.A4189@flint.arm.linux.org.uk>
References: <20050319172101.C23907@flint.arm.linux.org.uk>
	<20050324.191424.233669632.takata.hirokazu@renesas.com>
	<20050324121746.A4189@flint.arm.linux.org.uk>
X-Mailer: Mew version 3.3 on XEmacs 21.4.17 (Jumbo Shrimp)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, 

Here is an additional patch to update m32r_sio driver.
This patch is against 2.6.12-rc1-mm3.

m32r_sio driver updates:
- Move m32r_sio specific description from asm-m32r/serial.h to 
  driver/serial/m32r_sio.c.
- Remove __register_m32r_sio, register_m32r_sio and unregister_m32r_sio
  from driver/serial/m32r_sio.c.

Thank you.

From: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [PATCH] Re: Bitrotting serial drivers
Date: Thu, 24 Mar 2005 12:17:46 +0000
> On Thu, Mar 24, 2005 at 07:14:24PM +0900, Hirokazu Takata wrote:
> > diff -ruNp a/include/asm-m32r/serial.h b/include/asm-m32r/serial.h
> > --- a/include/asm-m32r/serial.h	2004-12-25 06:35:40.000000000 +0900
> > +++ b/include/asm-m32r/serial.h	2005-03-24 17:25:05.812651363 +0900
> 
> Can m32r accept PCMCIA cards?  If so, this may mean that 8250.c gets
> built, which will use this file to determine where it should look for
> built-in 8250 ports.
> 
> If this file is used to describe non-8250 compatible ports, you could
> end up with a nasty mess.  Therefore, I recommend that you do not use
> asm-m32r/serial.h to describe your SIO ports.
> 
> Instead, since these definitions are private to your own driver, you
> may consider moving them into the driver, or a header file closely
> associated with your driver in drivers/serial.


Signed-off-by: Hirokazu Takata <takata@linux-m32r.org>
---

 drivers/serial/m32r_sio.c |  131 ++++++++++------------------------------------
 include/asm-m32r/serial.h |   41 --------------
 2 files changed, 31 insertions(+), 141 deletions(-)


diff -ruNp a/include/asm-m32r/serial.h b/include/asm-m32r/serial.h
--- a/include/asm-m32r/serial.h	2005-03-29 21:47:12.912822762 +0900
+++ b/include/asm-m32r/serial.h	2005-03-29 18:15:37.000000000 +0900
@@ -1,47 +1,10 @@
 #ifndef _ASM_M32R_SERIAL_H
 #define _ASM_M32R_SERIAL_H
 
-/*
- * include/asm-m32r/serial.h
- */
+/* include/asm-m32r/serial.h */
 
 #include <linux/config.h>
-#include <asm/m32r.h>
 
-/*
- * This assumes you have a 1.8432 MHz clock for your UART.
- *
- * It'd be nice if someone built a serial card with a 24.576 MHz
- * clock, since the 16550A is capable of handling a top speed of 1.5
- * megabits/second; but this requires the faster clock.
- */
-#define BASE_BAUD ( 1843200 / 16 )
-
-/* Standard COM flags */
-#define STD_COM_FLAGS (ASYNC_BOOT_AUTOCONF | ASYNC_SKIP_TEST)
-
-/* Standard PORT definitions */
-#if defined(CONFIG_PLAT_USRV)
-
-#define STD_SERIAL_PORT_DEFNS						\
-       /* UART  CLK     PORT   IRQ            FLAGS */			\
-	{ 0, BASE_BAUD, 0x3F8, PLD_IRQ_UART0, STD_COM_FLAGS }, /* ttyS0 */ \
-	{ 0, BASE_BAUD, 0x2F8, PLD_IRQ_UART1, STD_COM_FLAGS }, /* ttyS1 */
-
-#else /* !CONFIG_PLAT_USRV */
-
-#if defined(CONFIG_SERIAL_M32R_PLDSIO)
-#define STD_SERIAL_PORT_DEFNS						\
-	{ 0, BASE_BAUD, ((unsigned long)PLD_ESIO0CR), PLD_IRQ_SIO0_RCV,	\
-	  STD_COM_FLAGS }, /* ttyS0 */
-#else
-#define STD_SERIAL_PORT_DEFNS						\
-	{ 0, BASE_BAUD, M32R_SIO_OFFSET, M32R_IRQ_SIO0_R,		\
-	  STD_COM_FLAGS }, /* ttyS0 */
-#endif
-
-#endif /* !CONFIG_PLAT_USRV */
-
-#define SERIAL_PORT_DFNS	STD_SERIAL_PORT_DEFNS
+#define BASE_BAUD	115200
 
 #endif  /* _ASM_M32R_SERIAL_H */
diff -ruNp a/drivers/serial/m32r_sio.c b/drivers/serial/m32r_sio.c
--- a/drivers/serial/m32r_sio.c	2005-03-29 21:47:12.924820913 +0900
+++ b/drivers/serial/m32r_sio.c	2005-03-29 21:56:38.001930365 +0900
@@ -54,13 +54,6 @@
 #include "m32r_sio_reg.h"
 
 /*
- * Configuration:
- *   share_irqs - whether we pass SA_SHIRQ to request_irq().  This option
- *                is unsafe when used on edge-triggered interrupts.
- */
-unsigned int share_irqs_sio = M32R_SIO_SHARE_IRQS;
-
-/*
  * Debugging.
  */
 #if 0
@@ -86,15 +79,36 @@ unsigned int share_irqs_sio = M32R_SIO_S
 
 #include <asm/serial.h>
 
+/* Standard COM flags */
+#define STD_COM_FLAGS (ASYNC_BOOT_AUTOCONF | ASYNC_SKIP_TEST)
+
 /*
  * SERIAL_PORT_DFNS tells us about built-in ports that have no
  * standard enumeration mechanism.   Platforms that can find all
  * serial ports via mechanisms like ACPI or PCI need not supply it.
  */
-#ifndef SERIAL_PORT_DFNS
-#define SERIAL_PORT_DFNS
+#undef SERIAL_PORT_DFNS
+#if defined(CONFIG_PLAT_USRV)
+
+#define SERIAL_PORT_DFNS						\
+       /* UART  CLK     PORT   IRQ            FLAGS */			\
+	{ 0, BASE_BAUD, 0x3F8, PLD_IRQ_UART0, STD_COM_FLAGS }, /* ttyS0 */ \
+	{ 0, BASE_BAUD, 0x2F8, PLD_IRQ_UART1, STD_COM_FLAGS }, /* ttyS1 */
+
+#else /* !CONFIG_PLAT_USRV */
+
+#if defined(CONFIG_SERIAL_M32R_PLDSIO)
+#define SERIAL_PORT_DFNS						\
+	{ 0, BASE_BAUD, ((unsigned long)PLD_ESIO0CR), PLD_IRQ_SIO0_RCV,	\
+	  STD_COM_FLAGS }, /* ttyS0 */
+#else
+#define SERIAL_PORT_DFNS						\
+	{ 0, BASE_BAUD, M32R_SIO_OFFSET, M32R_IRQ_SIO0_R,		\
+	  STD_COM_FLAGS }, /* ttyS0 */
 #endif
 
+#endif /* !CONFIG_PLAT_USRV */
+
 static struct old_serial_port old_serial_port[] = {
 	SERIAL_PORT_DFNS	/* defined in asm/serial.h */
 };
@@ -581,10 +595,7 @@ static void serial_unlink_irq_chain(stru
 }
 
 /*
- * This function is used to handle ports that do not have an
- * interrupt.  This doesn't work very well for 16450's, but gives
- * barely passable results for a 16550A.  (Although at the expense
- * of much CPU overhead).
+ * This function is used to handle ports that do not have an interrupt.
  */
 static void m32r_sio_timeout(unsigned long data)
 {
@@ -966,7 +977,7 @@ static struct uart_ops m32r_sio_pops = {
 
 static struct uart_sio_port m32r_sio_ports[UART_NR];
 
-static void __init m32r_sio_isa_init_ports(void)
+static void __init m32r_sio_init_ports(void)
 {
 	struct uart_sio_port *up;
 	static int first = 1;
@@ -986,8 +997,6 @@ static void __init m32r_sio_isa_init_por
 		up->port.iotype   = old_serial_port[i].io_type;
 		up->port.regshift = old_serial_port[i].iomem_reg_shift;
 		up->port.ops      = &m32r_sio_pops;
-		if (share_irqs_sio)
-			up->port.flags |= UPF_SHARE_IRQ;
 	}
 }
 
@@ -995,7 +1004,7 @@ static void __init m32r_sio_register_por
 {
 	int i;
 
-	m32r_sio_isa_init_ports();
+	m32r_sio_init_ports();
 
 	for (i = 0; i < UART_NR; i++) {
 		struct uart_sio_port *up = &m32r_sio_ports[i];
@@ -1129,7 +1138,7 @@ static int __init m32r_sio_console_init(
 {
 	sio_reset();
 	sio_init();
-	m32r_sio_isa_init_ports();
+	m32r_sio_init_ports();
 	register_console(&m32r_sio_console);
 	return 0;
 }
@@ -1151,81 +1160,6 @@ static struct uart_driver m32r_sio_reg =
 	.cons			= M32R_SIO_CONSOLE,
 };
 
-/*
- * register_serial and unregister_serial allows for 16x50 serial ports to be
- * configured at run-time, to support PCMCIA modems.
- */
-
-static int __register_m32r_sio(struct serial_struct *req, int line)
-{
-	struct uart_port port;
-
-	port.iobase   = req->port;
-	port.membase  = req->iomem_base;
-	port.irq      = req->irq;
-	port.uartclk  = req->baud_base * 16;
-	port.fifosize = req->xmit_fifo_size;
-	port.regshift = req->iomem_reg_shift;
-	port.iotype   = req->io_type;
-	port.flags    = req->flags | UPF_BOOT_AUTOCONF;
-	port.mapbase  = req->iomap_base;
-	port.line     = line;
-
-	if (share_irqs_sio)
-		port.flags |= UPF_SHARE_IRQ;
-
-	if (HIGH_BITS_OFFSET)
-		port.iobase |= (long) req->port_high << HIGH_BITS_OFFSET;
-
-	/*
-	 * If a clock rate wasn't specified by the low level
-	 * driver, then default to the standard clock rate.
-	 */
-	if (port.uartclk == 0)
-		port.uartclk = BASE_BAUD * 16;
-
-	return uart_register_port(&m32r_sio_reg, &port);
-}
-
-/**
- *	register_m32r_sio - configure a 16x50 serial port at runtime
- *	@req: request structure
- *
- *	Configure the serial port specified by the request. If the
- *	port exists and is in use an error is returned. If the port
- *	is not currently in the table it is added.
- *
- *	The port is then probed and if necessary the IRQ is autodetected
- *	If this fails an error is returned.
- *
- *	On success the port is ready to use and the line number is returned.
- */
-int register_m32r_sio(struct serial_struct *req)
-{
-	return __register_m32r_sio(req, -1);
-}
-
-int __init early_serial_setup(struct uart_port *port)
-{
-	m32r_sio_isa_init_ports();
- 	m32r_sio_ports[port->line].port = *port;
-	m32r_sio_ports[port->line].port.ops = &m32r_sio_pops;
-
-	return 0;
-}
-
-/**
- *	unregister_m32r_sio - remove a 16x50 serial port at runtime
- *	@line: serial line number
- *
- *	Remove one serial port.  This may be called from interrupt
- *	context.
- */
-void unregister_m32r_sio(int line)
-{
-	uart_unregister_port(&m32r_sio_reg, line);
-}
-
 /**
  *	m32r_sio_suspend_port - suspend one serial port
  *	@line: serial line number
@@ -1252,8 +1186,7 @@ static int __init m32r_sio_init(void)
 {
 	int ret, i;
 
-	printk(KERN_INFO "Serial: M32R SIO driver $Revision: 1.9 $ "
-		"IRQ sharing %sabled\n", share_irqs_sio ? "en" : "dis");
+	printk(KERN_INFO "Serial: M32R SIO driver $Revision: 1.11 $ ");
 
 	for (i = 0; i < NR_IRQS; i++)
 		spin_lock_init(&irq_lists[i].lock);
@@ -1278,14 +1211,8 @@ static void __exit m32r_sio_exit(void)
 module_init(m32r_sio_init);
 module_exit(m32r_sio_exit);
 
-EXPORT_SYMBOL(register_m32r_sio);
-EXPORT_SYMBOL(unregister_m32r_sio);
 EXPORT_SYMBOL(m32r_sio_suspend_port);
 EXPORT_SYMBOL(m32r_sio_resume_port);
 
 MODULE_LICENSE("GPL");
-MODULE_DESCRIPTION("Generic M32R SIO serial driver $Revision: 1.9 $");
-
-module_param(share_irqs_sio, bool, 0400);
-MODULE_PARM_DESC(share_irqs_sio, "Share IRQs with other non-M32R SIO devices"
-	" (unsafe)");
+MODULE_DESCRIPTION("Generic M32R SIO serial driver $Revision: 1.11 $");

--
Hirokazu Takata <takata@linux-m32r.org>
Linux/M32R Project:  http://www.linux-m32r.org/
