Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751101AbVH2QJs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751101AbVH2QJs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 12:09:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751253AbVH2QJs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 12:09:48 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:22995 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1751101AbVH2QJj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 12:09:39 -0400
Subject: [patch 04/16] I/O driver for 8250-compatible UARTs
Date: Mon, 29 Aug 2005 09:09:37 -0700
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, trini@kernel.crashing.org,
       rmk@arm.linux.org.uk
From: Tom Rini <trini@kernel.crashing.org>
Message-Id: <resend.4.2982005.trini@kernel.crashing.org>
In-Reply-To: <resend.3.2982005.trini@kernel.crashing.org>
References: <resend.3.2982005.trini@kernel.crashing.org> <1.2982005.trini@kernel.crashing.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


CC: Russell King <rmk@arm.linux.org.uk>
This is the I/O driver for any 8250-compatible UARTs.  This also adds some
small hooks into the normal serial core so that we can take away the uart and
make sure only KGDB is trying to use it.  We also make sure that if KGDB_8250
is enabled, SERIAL_8250_NR_UARTS is set to the default of 4.  This is so that
if we can always depend on that constant in the 8250 driver for giving our
table a size.  To make it easier (or in some cases, possible) to free up ports
on a shared irq system, we add a line member to plat_serial8250_port.

Since the last time this was submitted, I believe that all of the objections
that Russell King noted have been fixed.

---

 linux-2.6.13-trini/drivers/serial/8250.c       |   21 
 linux-2.6.13-trini/drivers/serial/8250.h       |    1 
 linux-2.6.13-trini/drivers/serial/Kconfig      |    2 
 linux-2.6.13-trini/drivers/serial/Makefile     |    1 
 linux-2.6.13-trini/drivers/serial/kgdb_8250.c  |  594 +++++++++++++++++++++
 linux-2.6.13-trini/include/linux/kgdb.h        |    3 
 linux-2.6.13-trini/include/linux/serial_8250.h |    1 
 linux-2.6.13-trini/lib/Kconfig.debug           |   92 +++
 8 files changed, 712 insertions(+), 3 deletions(-)

diff -puN drivers/serial/8250.c~8250 drivers/serial/8250.c
--- linux-2.6.13/drivers/serial/8250.c~8250	2005-08-15 07:53:39.000000000 -0700
+++ linux-2.6.13-trini/drivers/serial/8250.c	2005-08-15 07:53:39.000000000 -0700
@@ -2516,6 +2516,27 @@ void serial8250_unregister_port(int line
 }
 EXPORT_SYMBOL(serial8250_unregister_port);
 
+/**
+ *	serial8250_unregister_by_port - remove a 16x50 serial port
+ *	at runtime.
+ *	@port: A &struct uart_port that describes the port to remove.
+ *
+ *	Remove one serial port.  This may not be called from interrupt
+ *	context.  We hand the port back to the our control.
+ */
+void serial8250_unregister_by_port(struct uart_port *port)
+{
+	struct uart_8250_port *uart;
+
+	down(&serial_sem);
+	uart = serial8250_find_match_or_unused(port);
+	up(&serial_sem);
+
+	if (uart)
+		serial8250_unregister_port(uart->port.line);
+}
+EXPORT_SYMBOL(serial8250_unregister_by_port);
+
 static int __init serial8250_init(void)
 {
 	int ret, i;
diff -puN drivers/serial/8250.h~8250 drivers/serial/8250.h
--- linux-2.6.13/drivers/serial/8250.h~8250	2005-08-15 07:53:39.000000000 -0700
+++ linux-2.6.13-trini/drivers/serial/8250.h	2005-08-15 07:53:39.000000000 -0700
@@ -19,6 +19,7 @@
 
 int serial8250_register_port(struct uart_port *);
 void serial8250_unregister_port(int line);
+void serial8250_unregister_by_port(struct uart_port *port);
 void serial8250_suspend_port(int line);
 void serial8250_resume_port(int line);
 
diff -puN drivers/serial/Kconfig~8250 drivers/serial/Kconfig
--- linux-2.6.13/drivers/serial/Kconfig~8250	2005-08-15 07:53:39.000000000 -0700
+++ linux-2.6.13-trini/drivers/serial/Kconfig	2005-08-15 07:53:39.000000000 -0700
@@ -87,7 +87,7 @@ config SERIAL_8250_ACPI
 
 config SERIAL_8250_NR_UARTS
 	int "Maximum number of 8250/16550 serial ports"
-	depends on SERIAL_8250
+	depends on SERIAL_8250 || KGDB_8250
 	default "4"
 	help
 	  Set this to the number of serial ports you want the driver
diff -puN /dev/null drivers/serial/kgdb_8250.c
--- /dev/null	2005-08-15 07:19:53.144310000 -0700
+++ linux-2.6.13-trini/drivers/serial/kgdb_8250.c	2005-08-16 14:57:32.000000000 -0700
@@ -0,0 +1,594 @@
+/*
+ * 8250 interface for kgdb.
+ *
+ * This is a merging of many different drivers, and all of the people have
+ * had an impact in some form or another:
+ *
+ * 2004-2005 (c) MontaVista Software, Inc.
+ * 2005 (c) Wind River Systems, Inc.
+ *
+ * Amit Kale <amitkale@emsyssoft.com>, David Grothe <dave@gcom.com>,
+ * Scott Foehner <sfoehner@engr.sgi.com>, George Anzinger <george@mvista.com>,
+ * Robert Walsh <rjwalsh@durables.org>, wangdi <wangdi@clusterfs.com>,
+ * San Mehat, Tom Rini <trini@mvista.com>,
+ * Jason Wessel <jason.wessel@windriver.com>
+ */
+
+#include <linux/config.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/kgdb.h>
+#include <linux/interrupt.h>
+#include <linux/tty.h>
+#include <linux/serial.h>
+#include <linux/serial_reg.h>
+#include <linux/serialP.h>
+#include <linux/ioport.h>
+
+#include <asm/io.h>
+#include <asm/serial.h>		/* For BASE_BAUD and SERIAL_PORT_DFNS */
+
+#include "8250.h"
+
+#define GDB_BUF_SIZE	512	/* power of 2, please */
+
+MODULE_DESCRIPTION("KGDB driver for the 8250");
+MODULE_LICENSE("GPL");
+/* These will conflict with early_param otherwise. */
+#ifdef CONFIG_KGDB_8250_MODULE
+static char config[256];
+module_param_string(kgdb8250, config, 256, 0);
+MODULE_PARM_DESC(kgdb8250, " kgdb8250=<port number>,<baud rate>\n");
+static struct kgdb_io local_kgdb_io_ops;
+#endif				/* CONFIG_KGDB_8250_MODULE */
+
+/* Speed of the UART. */
+#if defined(CONFIG_KGDB_9600BAUD)
+static int kgdb8250_baud = 9600;
+#elif defined(CONFIG_KGDB_19200BAUD)
+static int kgdb8250_baud = 19200;
+#elif defined(CONFIG_KGDB_38400BAUD)
+static int kgdb8250_baud = 38400;
+#elif defined(CONFIG_KGDB_57600BAUD)
+static int kgdb8250_baud = 57600;
+#else
+static int kgdb8250_baud = 115200;	/* Start with this if not given */
+#endif
+
+/* Index of the UART, matches ttySX naming. */
+#if defined(CONFIG_KGDB_PORT_1)
+static int kgdb8250_ttyS = 1;
+#elif defined(CONFIG_KGDB_PORT_2)
+static int kgdb8250_ttyS = 2;
+#elif defined(CONFIG_KGDB_PORT_3)
+static int kgdb8250_ttyS = 3;
+#else
+static int kgdb8250_ttyS = 0;	/* Start with this if not given */
+#endif
+
+/* Flag for if we need to call request_mem_region */
+static int kgdb8250_needs_request_mem_region;
+
+static char kgdb8250_buf[GDB_BUF_SIZE];
+static atomic_t kgdb8250_buf_in_cnt;
+static int kgdb8250_buf_out_inx;
+
+/* Old-style serial definitions, if existant, and a counter. */
+static int old_rs_table_copied;
+static struct serial_state __initdata old_rs_table[] = {
+#ifdef SERIAL_PORT_DFNS
+	SERIAL_PORT_DFNS
+#endif
+};
+
+/* Our internal table of UARTS. */
+#define UART_NR	CONFIG_SERIAL_8250_NR_UARTS
+static struct uart_port kgdb8250_ports[UART_NR] = {
+#ifndef CONFIG_KGDB_SIMPLE_SERIAL
+	{
+#if defined(CONFIG_KGDB_IRQ) && defined(CONFIG_KGDB_PORT)
+		.irq = CONFIG_KGDB_IRQ,
+		.iobase = CONFIG_KGDB_PORT,
+		.iotype = UPIO_PORT,
+#elif CONFIG_KGDB_IOMEMBASE
+		.membase = (unsigned char *)CONFIG_KGDB_IOMEMBASE,
+		.iotype = UPIO_MEM,
+#endif
+	 },
+#endif
+};
+
+/* Macros to easily get what we want from kgdb8250_ports[kgdb8250_ttyS] */
+#define CURRENTPORT		kgdb8250_ports[kgdb8250_ttyS]
+#define KGDB8250_IRQ		CURRENTPORT.irq
+#define KGDB8250_REG_SHIFT	CURRENTPORT.regshift
+
+/* Base of the UART. */
+static void *kgdb8250_addr;
+
+/* Forward declarations. */
+static int kgdb8250_init(void);
+static int kgdb_init_io(void);
+static int __init kgdb8250_opt(char *str);
+static void __init kgdb8250_hookup_irq(void);
+
+/*
+ * Wait until the interface can accept a char, then write it.
+ */
+static void kgdb_put_debug_char(u8 chr)
+{
+	while (!(ioread8(kgdb8250_addr + (UART_LSR << KGDB8250_REG_SHIFT)) &
+		 UART_LSR_THRE)) ;
+
+	iowrite8(chr, kgdb8250_addr + (UART_TX << KGDB8250_REG_SHIFT));
+}
+
+/*
+ * Get a byte from the hardware data buffer and return it
+ */
+static int read_data_bfr(void)
+{
+	char it = ioread8(kgdb8250_addr + (UART_LSR << KGDB8250_REG_SHIFT));
+
+	if (it & UART_LSR_DR)
+		return ioread8(kgdb8250_addr +
+				  (UART_RX << KGDB8250_REG_SHIFT));
+
+	/*
+	 * If we have a framing error assume somebody messed with
+	 * our uart.  Reprogram it and send '-' both ways...
+	 */
+	if (it & 0xc) {
+		kgdb8250_init();
+		kgdb_put_debug_char('-');
+		return '-';
+	}
+
+	return -1;
+}
+
+/*
+ * Get a char if available, return -1 if nothing available.
+ * Empty the receive buffer first, then look at the interface hardware.
+ */
+
+static int kgdb_get_debug_char(void)
+{
+	int retchr;
+
+	/* intr routine has q'd chars */
+	if (atomic_read(&kgdb8250_buf_in_cnt) != 0) {
+		retchr = kgdb8250_buf[kgdb8250_buf_out_inx++];
+		kgdb8250_buf_out_inx &= (GDB_BUF_SIZE - 1);
+		atomic_dec(&kgdb8250_buf_in_cnt);
+		return retchr;
+	}
+
+	do {
+		retchr = read_data_bfr();
+	} while (retchr < 0);
+
+	return retchr;
+}
+
+/*
+ * This is the receiver interrupt routine for the GDB stub.
+ * All that we need to do is verify that the interrupt happened on the
+ * line we're in charge of.  If this is true, schedule a breakpoint and
+ * return.
+ */
+static irqreturn_t
+kgdb8250_interrupt(int irq, void *dev_id, struct pt_regs *regs)
+{
+	char iir;
+
+	if (irq != KGDB8250_IRQ)
+		return IRQ_NONE;
+	/*
+	 * If  there is some other CPU in KGDB then this is a
+	 * spurious interrupt. so return without even checking a byte
+	 */
+	if (atomic_read(&debugger_active))
+		return IRQ_NONE;
+
+	iir = ioread8(kgdb8250_addr + (UART_IIR << KGDB8250_REG_SHIFT));
+	if (iir & UART_IIR_RDI) {
+		if (kgdb_io_ops.init != kgdb_init_io) {
+			/* Throw away the data if another I/O routine
+			 * is active.
+			 */
+			char it = ioread8(kgdb8250_addr +
+					     (UART_LSR << KGDB8250_REG_SHIFT));
+			if (it & UART_LSR_DR)
+				ioread8(kgdb8250_addr +
+					   (UART_RX << KGDB8250_REG_SHIFT));
+		} else
+			breakpoint();
+	}
+
+	return IRQ_HANDLED;
+}
+
+/*
+ *  Returns:
+ *	0 on success, 1 on failure.
+ */
+static int kgdb8250_init(void)
+{
+	unsigned cval;
+	int bits = 8;
+	int parity = 'n';
+	int cflag = CREAD | HUPCL | CLOCAL;
+	char ier = UART_IER_RDI;
+	unsigned int base_baud;
+
+	base_baud = CURRENTPORT.uartclk ? CURRENTPORT.uartclk / 16 : BASE_BAUD;
+
+	/*
+	 *      Now construct a cflag setting.
+	 */
+	switch (kgdb8250_baud) {
+	case 1200:
+		cflag |= B1200;
+		break;
+	case 2400:
+		cflag |= B2400;
+		break;
+	case 4800:
+		cflag |= B4800;
+		break;
+	case 19200:
+		cflag |= B19200;
+		break;
+	case 38400:
+		cflag |= B38400;
+		break;
+	case 57600:
+		cflag |= B57600;
+		break;
+	case 115200:
+		cflag |= B115200;
+		break;
+	default:
+		kgdb8250_baud = 9600;
+		/* Fall through */
+	case 9600:
+		cflag |= B9600;
+		break;
+	}
+	switch (bits) {
+	case 7:
+		cflag |= CS7;
+		break;
+	default:
+	case 8:
+		cflag |= CS8;
+		break;
+	}
+	switch (parity) {
+	case 'o':
+	case 'O':
+		cflag |= PARODD;
+		break;
+	case 'e':
+	case 'E':
+		cflag |= PARENB;
+		break;
+	}
+
+	/*
+	 *      Divisor, bytesize and parity
+	 *
+	 */
+
+	cval = cflag & (CSIZE | CSTOPB);
+	cval >>= 4;
+	if (cflag & PARENB)
+		cval |= UART_LCR_PARITY;
+	if (!(cflag & PARODD))
+		cval |= UART_LCR_EPAR;
+
+	/* Disable UART interrupts, set DTR and RTS high and set speed. */
+	cval = 0x3;
+#if defined(CONFIG_ARCH_OMAP1510)
+	/* Workaround to enable 115200 baud on OMAP1510 internal ports */
+	if (cpu_is_omap1510() && is_omap_port((void *)kgdb8250_addr)) {
+		if (kgdb8250_baud == 115200) {
+			base_baud = 1;
+			kgdb8250_baud = 1;
+			iowrite8(1, kgdb8250_addr +
+				    (UART_OMAP_OSC_12M_SEL <<
+				     KGDB8250_REG_SHIFT));
+		} else {
+			iowrite8(0, kgdb8250_addr +
+				    (UART_OMAP_OSC_12M_SEL <<
+				     KGDB8250_REG_SHIFT));
+		}
+	}
+#endif
+	/* set DLAB */
+	iowrite8(cval | UART_LCR_DLAB, kgdb8250_addr +
+		    (UART_LCR << KGDB8250_REG_SHIFT));
+	/* LS */
+	iowrite8(base_baud / kgdb8250_baud & 0xff, kgdb8250_addr +
+		    (UART_DLL << KGDB8250_REG_SHIFT));
+	/* MS  */
+	iowrite8(base_baud / kgdb8250_baud >> 8, kgdb8250_addr +
+		    (UART_DLM << KGDB8250_REG_SHIFT));
+	/* reset DLAB */
+	iowrite8(cval, kgdb8250_addr + (UART_LCR << KGDB8250_REG_SHIFT));
+
+	/*
+	 * XScale-specific bits that need to be set
+	 */
+	if (CURRENTPORT.type == PORT_XSCALE)
+		ier |= UART_IER_UUE | UART_IER_RTOIE;
+
+	/* turn on interrupts */
+	iowrite8(ier, kgdb8250_addr + (UART_IER << KGDB8250_REG_SHIFT));
+	iowrite8(UART_MCR_OUT2 | UART_MCR_DTR | UART_MCR_RTS,
+		    kgdb8250_addr + (UART_MCR << KGDB8250_REG_SHIFT));
+
+	/*
+	 *      If we read 0xff from the LSR, there is no UART here.
+	 */
+	if (ioread8(kgdb8250_addr + (UART_LSR << KGDB8250_REG_SHIFT)) ==
+	    0xff)
+		return -1;
+	return 0;
+}
+
+/*
+ * Copy the old serial_state table to our uart_port table if we haven't
+ * had values specifically configured in.  We need to make sure this only
+ * happens once.
+ */
+static void __init kgdb8250_copy_rs_table(void)
+{
+#ifdef CONFIG_KGDB_SIMPLE_SERIAL
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(old_rs_table); i++) {
+		kgdb8250_ports[i].iobase = old_rs_table[i].port;
+		kgdb8250_ports[i].irq = irq_canonicalize(old_rs_table[i].irq);
+		kgdb8250_ports[i].uartclk = old_rs_table[i].baud_base * 16;
+		kgdb8250_ports[i].membase = old_rs_table[i].iomem_base;
+		kgdb8250_ports[i].iotype = old_rs_table[i].io_type;
+		kgdb8250_ports[i].regshift = old_rs_table[i].iomem_reg_shift;
+		kgdb8250_ports[i].line = i;
+	}
+#endif
+
+	old_rs_table_copied = 1;
+}
+
+/*
+ * Perform static initalization tasks which we need to always do,
+ * even if KGDB isn't going to be invoked immediately.
+ */
+static int kgdb8250_local_init(void)
+{
+	if (old_rs_table_copied == 0)
+		kgdb8250_copy_rs_table();
+
+	switch (CURRENTPORT.iotype) {
+	case UPIO_MEM:
+		if (CURRENTPORT.mapbase)
+			kgdb8250_needs_request_mem_region = 1;
+		if (CURRENTPORT.flags & UPF_IOREMAP) {
+			CURRENTPORT.membase = ioport_map(CURRENTPORT.mapbase,
+						      8 << KGDB8250_REG_SHIFT);
+			if (!CURRENTPORT.membase)
+				return 1;	/* Failed. */
+		}
+		kgdb8250_addr = CURRENTPORT.membase;
+		break;
+	case UPIO_PORT:
+	default:
+		kgdb8250_addr = ioport_map(CURRENTPORT.iobase,
+				8 << KGDB8250_REG_SHIFT);
+		if (!kgdb8250_addr)
+			return 1;	/* Failed. */
+	}
+
+	return 0;
+}
+
+static int kgdb_init_io(void)
+{
+#ifdef CONFIG_KGDB_8250_MODULE
+	if (strlen(config)) {
+		if (kgdb8250_opt(config))
+			return -EINVAL;
+	} else {
+		printk(KERN_ERR "kgdb8250: argument error, usage: "
+		       "kgdb8250=<port number>,<baud rate>");
+#ifdef CONFIG_IA64
+		printk(",<irq>,<iomem base>");
+#endif
+		printk("\n");
+		return -EINVAL;
+	}
+#endif				/* CONFIG_KGDB_8250_MODULE */
+
+	if (kgdb8250_local_init()) {
+		printk(KERN_ERR "kgdb8250: local init failed\n");
+		return -EIO;
+	}
+
+	if (kgdb8250_init() == -1) {
+		printk(KERN_ERR "kgdb8250: init failed\n");
+		return -EIO;
+	}
+#ifdef CONFIG_KGDB_8250_MODULE
+	/* Attach the kgdb irq. When this is built into the kernel, it
+	 * is called as a part of late_init sequence.
+	 */
+	kgdb8250_hookup_irq();
+	if (kgdb_register_io_module(&local_kgdb_io_ops))
+		return -EINVAL;
+
+	printk(KERN_INFO "kgdb8250: debugging enabled\n");
+#endif				/* CONFIG_KGD_8250_MODULE */
+
+	return 0;
+}
+
+/*
+ * Hookup our IRQ line.  We will already have been initialized at
+ * this point.
+ */
+static void __init kgdb8250_hookup_irq(void)
+{
+#if defined(CONFIG_SERIAL_8250) || defined (CONFIG_SERIAL_8250_MODULE)
+	/* Take the port away from the main driver. */
+	serial8250_unregister_by_port(&CURRENTPORT);
+
+	/* Now reinit the port as the above has disabled things. */
+	kgdb8250_init();
+#endif
+	/* We may need to call request_mem_region() first. */
+	if (kgdb8250_needs_request_mem_region)
+		request_mem_region(CURRENTPORT.mapbase,
+				   8 << KGDB8250_REG_SHIFT, "kgdb");
+	if (request_irq(KGDB8250_IRQ, kgdb8250_interrupt, SA_SHIRQ,
+		    "GDB-stub", &CURRENTPORT) < 0)
+		printk(KERN_ERR "KGDB failed to request the serial IRQ (%d)\n",
+				KGDB8250_IRQ);
+}
+
+#ifdef CONFIG_KGDB_8250_MODULE
+/* If it is a module the kgdb_io_ops should be a static which
+ * is passed to the KGDB I/O initialization
+ */
+static
+struct kgdb_io local_kgdb_io_ops = {
+#else				/* ! CONFIG_KGDB_8250_MODULE */
+struct kgdb_io kgdb_io_ops = {
+#endif				/* ! CONFIG_KGD_8250_MODULE */
+	.read_char = kgdb_get_debug_char,
+	.write_char = kgdb_put_debug_char,
+	.init = kgdb_init_io,
+	.late_init = kgdb8250_hookup_irq,
+	.pre_exception = NULL,
+	.post_exception = NULL
+};
+
+/**
+ * 	kgdb8250_get_ttyS - Return the index of the UART used by kgdb,
+ *	matches ttySX naming.
+ */
+int kgdb8250_get_ttyS(void)
+{
+	return kgdb8250_ttyS;
+}
+
+/**
+ * 	kgdb8250_add_port - Define a serial port for use with KGDB
+ * 	@i: The index of the port being added
+ * 	@serial_req: The &struct uart_port describing the port
+ *
+ * 	On platforms where we must register the serial device
+ * 	dynamically, this is the best option if a platform also normally
+ * 	calls early_serial_setup().
+ */
+void kgdb8250_add_port(int i, struct uart_port *serial_req)
+{
+	/* Copy the old table in if needed. */
+	if (old_rs_table_copied == 0)
+		kgdb8250_copy_rs_table();
+
+	/* Copy the whole thing over. */
+	memcpy(&kgdb8250_ports[i], serial_req, sizeof(struct uart_port));
+}
+
+/**
+ * 	kgdb8250_add_platform_port - Define a serial port for use with KGDB
+ * 	@i: The index of the port being added
+ * 	@p: The &struct plat_serial8250_port describing the port
+ *
+ * 	On platforms where we must register the serial device
+ * 	dynamically, this is the best option if a platform normally
+ * 	handles uart setup with an array of &struct plat_serial8250_port.
+ */
+void kgdb8250_add_platform_port(int i, struct plat_serial8250_port *p)
+{
+	/* Copy the old table in if needed. */
+	if (old_rs_table_copied == 0)
+		kgdb8250_copy_rs_table();
+
+	kgdb8250_ports[i].iobase = p->iobase;
+	kgdb8250_ports[i].membase = p->membase;
+	kgdb8250_ports[i].irq = p->irq;
+	kgdb8250_ports[i].uartclk = p->uartclk;
+	kgdb8250_ports[i].regshift = p->regshift;
+	kgdb8250_ports[i].iotype = p->iotype;
+	kgdb8250_ports[i].flags = p->flags;
+	kgdb8250_ports[i].mapbase = p->mapbase;
+	kgdb8250_ports[i].line = p->line;
+}
+
+/*
+ * Syntax for this cmdline option is "kgdb8250=ttyno,baudrate"
+ * with ",irq,iomembase" tacked on the end on IA64.
+ */
+static int __init kgdb8250_opt(char *str)
+{
+	if (*str < '0' || *str > '3')
+		goto errout;
+	kgdb8250_ttyS = *str - '0';
+	str++;
+	if (*str != ',')
+		goto errout;
+	str++;
+	kgdb8250_baud = simple_strtoul(str, &str, 10);
+	if (kgdb8250_baud != 9600 && kgdb8250_baud != 19200 &&
+	    kgdb8250_baud != 38400 && kgdb8250_baud != 57600 &&
+	    kgdb8250_baud != 115200)
+		goto errout;
+
+#ifdef CONFIG_IA64
+	if (*str == ',') {
+		str++;
+		KGDB8250_IRQ = simple_strtoul(str, &str, 10);
+		if (*str == ',') {
+			str++;
+			CURRENTPORT.iotype = SERIAL_IO_MEM;
+			CURRENTPORT.membase =
+			    (unsigned char *)simple_strtoul(str, &str, 0);
+		}
+	}
+#endif
+
+	return 0;
+
+      errout:
+	printk(KERN_ERR "Invalid syntax for option kgdb8250=\n");
+	return 1;
+}
+
+#ifdef CONFIG_KGDB_8250_MODULE
+static void cleanup_kgdb8250(void)
+{
+	kgdb_unregister_io_module(&local_kgdb_io_ops);
+
+	/* Clean up the irq and memory */
+	free_irq(KGDB8250_IRQ, &CURRENTPORT);
+
+	if (kgdb8250_needs_request_mem_region)
+		release_mem_region(CURRENTPORT.mapbase,
+				   8 << KGDB8250_REG_SHIFT);
+	/* Hook up the serial port back to what it was previously
+	 * hooked up to.
+	 */
+#if defined(CONFIG_SERIAL_8250) || defined(CONFIG_SERIAL_8250_MODULE)
+	/* Give the port back to the 8250 driver. */
+	serial8250_register_port(&CURRENTPORT);
+#endif
+}
+
+module_init(kgdb_init_io);
+module_exit(cleanup_kgdb8250);
+#else				/* ! CONFIG_KGDB_8250_MODULE */
+early_param("kgdb8250", kgdb8250_opt);
+#endif				/* ! CONFIG_KGDB_8250_MODULE */
diff -puN drivers/serial/Makefile~8250 drivers/serial/Makefile
--- linux-2.6.13/drivers/serial/Makefile~8250	2005-08-15 07:53:39.000000000 -0700
+++ linux-2.6.13-trini/drivers/serial/Makefile	2005-08-15 07:53:39.000000000 -0700
@@ -57,3 +57,4 @@ obj-$(CONFIG_SERIAL_JSM) += jsm/
 obj-$(CONFIG_SERIAL_TXX9) += serial_txx9.o
 obj-$(CONFIG_SERIAL_VR41XX) += vr41xx_siu.o
 obj-$(CONFIG_SERIAL_SGI_IOC4) += ioc4_serial.o
+obj-$(CONFIG_KGDB_8250) += kgdb_8250.o
diff -puN include/linux/kgdb.h~8250 include/linux/kgdb.h
--- linux-2.6.13/include/linux/kgdb.h~8250	2005-08-15 07:53:39.000000000 -0700
+++ linux-2.6.13-trini/include/linux/kgdb.h	2005-08-16 14:57:32.000000000 -0700
@@ -224,7 +224,7 @@ typedef unsigned char threadref[8];
  */
 struct kgdb_io {
 	int (*read_char) (void);
-	void (*write_char) (int);
+	void (*write_char) (u8);
 	void (*flush) (void);
 	int (*init) (void);
 	void (*late_init) (void);
@@ -241,6 +241,7 @@ extern void kgdb_unregister_io_module(st
 
 extern void kgdb8250_add_port(int i, struct uart_port *serial_req);
 extern void kgdb8250_add_platform_port(int i, struct plat_serial8250_port *serial_req);
+extern int kgdb8250_get_ttyS(void);
 
 extern int kgdb_hex2long(char **ptr, long *long_val);
 extern char *kgdb_mem2hex(char *mem, char *buf, int count);
diff -puN include/linux/serial_8250.h~8250 include/linux/serial_8250.h
--- linux-2.6.13/include/linux/serial_8250.h~8250	2005-08-15 07:53:39.000000000 -0700
+++ linux-2.6.13-trini/include/linux/serial_8250.h	2005-08-15 07:53:39.000000000 -0700
@@ -24,6 +24,7 @@ struct plat_serial8250_port {
 	unsigned char	iotype;		/* UPIO_* */
 	unsigned char	hub6;
 	unsigned int	flags;		/* UPF_* flags */
+	unsigned int	line;		/* logical line number */
 };
 
 #endif
diff -puN lib/Kconfig.debug~8250 lib/Kconfig.debug
--- linux-2.6.13/lib/Kconfig.debug~8250	2005-08-15 07:53:39.000000000 -0700
+++ linux-2.6.13-trini/lib/Kconfig.debug	2005-08-16 15:13:22.000000000 -0700
@@ -188,7 +188,7 @@ config KGDB_CONSOLE
 choice
 	prompt "Method for KGDB communication"
 	depends on KGDB
-	default KGDB_ONLY_MODULES
+	default KGDB_8250_NOMODULE
 	default KGDB_MPSC if SERIAL_MPSC
 	help
 	  There are a number of different ways in which you can communicate
@@ -206,6 +206,14 @@ config KGDB_ONLY_MODULES
 	  Use only kernel modules to configure KGDB I/O after the
 	  kernel is booted.
 
+config KGDB_8250_NOMODULE
+	bool "KGDB: On generic serial port (8250)"
+	select KGDB_8250
+	help
+	  Uses generic serial port (8250) to communicate with the host
+	  GDB.  This is independent of the normal (SERIAL_8250) driver
+	  for this chipset.
+
 config KGDB_MPSC
 	bool "KGDB on MV64x60 MPSC"
 	depends on SERIAL_MPSC
@@ -213,4 +221,86 @@ config KGDB_MPSC
 	  Uses a Marvell GT64260B or MV64x60 Multi-Purpose Serial
 	  Controller (MPSC) channel. Note that the GT64260A is not
 	  supported.
+
 endchoice
+
+config KGDB_8250
+	tristate "KGDB: On generic serial port (8250)" if !KGDB_8250_NOMODULE
+	depends on m && KGDB_ONLY_MODULES
+	help
+	  Uses generic serial port (8250) to communicate with the host
+	  GDB.  This is independent of the normal (SERIAL_8250) driver
+	  for this chipset.
+
+config KGDB_SIMPLE_SERIAL
+	bool "Simple selection of KGDB serial port"
+	depends on KGDB_8250
+	default y
+	help
+	  If you say Y here, you will only have to pick the baud rate
+	  and serial port (ttyS) that you wish to use for KGDB.  If you
+	  say N, you will have provide the I/O port and IRQ number.  Note
+	  that if your serial ports are iomapped, such as on ia64, then
+	  you must say Y here.  If in doubt, say Y.
+
+choice
+    	prompt "Debug serial port BAUD"
+	depends on KGDB_8250
+	default KGDB_115200BAUD
+	help
+	  gdb and the kernel stub need to agree on the baud rate to be
+	  used.  Standard rates from 9600 to 115200 are allowed, and this
+	  may be overridden via the commandline.
+
+config KGDB_9600BAUD
+	bool "9600"
+
+config KGDB_19200BAUD
+	bool "19200"
+
+config KGDB_38400BAUD
+	bool "38400"
+
+config KGDB_57600BAUD
+	bool "57600"
+
+config KGDB_115200BAUD
+	bool "115200"
+endchoice
+
+choice
+	prompt "Serial port for KGDB"
+	depends on KGDB_SIMPLE_SERIAL
+	default KGDB_PORT_0
+
+config KGDB_PORT_0
+	bool "Primary serial port"
+
+config KGDB_PORT_1
+	bool "First serial port"
+
+config KGDB_PORT_2
+	bool "Second serial port"
+
+config KGDB_PORT_3
+	bool "Third serial port"
+endchoice
+
+config KGDB_PORT
+	hex "hex I/O port address of the debug serial port"
+	depends on !KGDB_SIMPLE_SERIAL && KGDB_8250 && !IA64
+	default 3f8
+	help
+	  This is the unmapped (and on platforms with 1:1 mapping
+	  this is typically, but not always the same as the mapped)
+	  address of the serial port.  The stanards on your architecture
+	  may be found in include/asm-$(ARCH)/serial.h.
+
+config KGDB_IRQ
+	int "IRQ of the debug serial port"
+	depends on !KGDB_SIMPLE_SERIAL && KGDB_8250 && !IA64
+	default 4
+	help
+	  This is the IRQ for the debug port.  This must be known so that
+	  KGDB can interrupt the running system (either for a new
+	  connection or when in gdb and control-C is issued).
_
