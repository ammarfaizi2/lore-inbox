Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261597AbUJ2TEC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261597AbUJ2TEC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 15:04:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261478AbUJ2TEB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 15:04:01 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:58842 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S263487AbUJ2Sds (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 14:33:48 -0400
Subject: [patch 4/8] 8250 uart driver for KGDB
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, trini@kernel.crashing.org,
       rmk@arm.linux.org.uk
From: Tom Rini <trini@kernel.crashing.org>
Message-Id: <4.29102004.trini@kernel.crashing.org>
In-Reply-To: <3.29102004.trini@kernel.crashing.org>
References: <3.29102004.trini@kernel.crashing.org> <1.29102004.trini@kernel.crashing.org>
Date: Fri, 29 Oct 2004 11:33:42 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Cc: Russell King <rmk@arm.linux.org.uk>
This adds an 8250 uart driver for KGDB and adds a hook into 8250.c to
unregister a port based on the IRQ, serial8250_release_irq().  We use
serial8250_unregister_port() to do the real work here, however.  Note
that we can't use unregister_port in kgdb_8250.c since we don't know
what the 'port' is, in 8250 terms, only the IRQ.  The other change is
that we have SERIAL_8250_NR_UARTS always be defined if KGDB_8250.

---

 linux-2.6.10-rc1-trini/drivers/serial/8250.c        |   39 +
 linux-2.6.10-rc1-trini/drivers/serial/Kconfig       |    4 
 linux-2.6.10-rc1-trini/drivers/serial/Makefile      |    1 
 linux-2.6.10-rc1-trini/drivers/serial/kgdb_8250.c   |  477 ++++++++++++++++++++
 linux-2.6.10-rc1-trini/drivers/serial/serial_core.c |    6 
 linux-2.6.10-rc1-trini/lib/Kconfig.debug            |  101 ++++
 6 files changed, 625 insertions(+), 3 deletions(-)

diff -puN drivers/serial/8250.c~8250 drivers/serial/8250.c
--- linux-2.6.10-rc1/drivers/serial/8250.c~8250	2004-10-29 11:26:44.964330757 -0700
+++ linux-2.6.10-rc1-trini/drivers/serial/8250.c	2004-10-29 11:26:44.977327706 -0700
@@ -1348,12 +1348,17 @@ static void serial8250_break_ctl(struct 
 	spin_unlock_irqrestore(&up->port.lock, flags);
 }
 
+static int released_irq = -1;
+
 static int serial8250_startup(struct uart_port *port)
 {
 	struct uart_8250_port *up = (struct uart_8250_port *)port;
 	unsigned long flags;
 	int retval;
 
+	if (up->port.irq == released_irq)
+		return -EBUSY;
+
 	up->capabilities = uart_config[up->port.type].flags;
 	up->mcr = 0;
 
@@ -1990,6 +1995,9 @@ serial8250_register_ports(struct uart_dr
 	for (i = 0; i < UART_NR; i++) {
 		struct uart_8250_port *up = &serial8250_ports[i];
 
+		if (up->port.irq == released_irq)
+			continue;
+
 		up->port.line = i;
 		up->port.ops = &serial8250_pops;
 		up->port.dev = dev;
@@ -2327,6 +2335,9 @@ int serial8250_register_port(struct uart
 	struct uart_8250_port *uart;
 	int ret = -ENOSPC;
 
+	if (port->line == released_irq)
+		return -EBUSY;
+
 	down(&serial_sem);
 
 	uart = serial8250_find_match_or_unused(port);
@@ -2376,6 +2387,34 @@ void serial8250_unregister_port(int line
 }
 EXPORT_SYMBOL(serial8250_unregister_port);
 
+/**
+ *	serial8250_release_irq - remove a 16x50 serial port at runtime based
+ *	on IRQ
+ *	@irq: IRQ number
+ *
+ *	Remove one serial port.  This may not be called from interrupt
+ *	context.  This is called when the caller know the IRQ of the
+ *	port they want, but not where it is in our table.  This allows
+ *	for one port, based on IRQ, to be permanently released from us.
+ */
+
+int serial8250_release_irq(int irq)
+{
+        struct uart_8250_port *up;
+	int ttyS;
+
+	if (released_irq != -1)
+		return -EBUSY;
+
+	released_irq = irq;
+	for (ttyS = 0; ttyS < UART_NR; ttyS++){
+		up =  &serial8250_ports[ttyS];
+		if (up->port.irq == irq && (irq_lists + irq)->head)
+			serial8250_unregister_port(up->port.line);
+        }
+	return 0;
+}
+
 static int __init serial8250_init(void)
 {
 	int ret, i;
diff -puN drivers/serial/Kconfig~8250 drivers/serial/Kconfig
--- linux-2.6.10-rc1/drivers/serial/Kconfig~8250	2004-10-29 11:26:44.966330288 -0700
+++ linux-2.6.10-rc1-trini/drivers/serial/Kconfig	2004-10-29 11:26:44.978327471 -0700
@@ -86,8 +86,8 @@ config SERIAL_8250_ACPI
 	  namespace, say Y here.  If unsure, say N.
 
 config SERIAL_8250_NR_UARTS
-	int "Maximum number of non-legacy 8250/16550 serial ports"
-	depends on SERIAL_8250
+	int "Maximum number of non-legacy 8250/16550 serial ports" if SERIAL_8250
+	depends on SERIAL_8250 || KGDB_8250
 	default "4"
 	---help---
 	  Set this to the number of non-legacy serial ports you want
diff -puN drivers/serial/Makefile~8250 drivers/serial/Makefile
--- linux-2.6.10-rc1/drivers/serial/Makefile~8250	2004-10-29 11:26:44.967330053 -0700
+++ linux-2.6.10-rc1-trini/drivers/serial/Makefile	2004-10-29 11:26:44.978327471 -0700
@@ -42,3 +42,4 @@ obj-$(CONFIG_SERIAL_SGI_L1_CONSOLE) += s
 obj-$(CONFIG_SERIAL_CPM) += cpm_uart/
 obj-$(CONFIG_SERIAL_MPC52xx) += mpc52xx_uart.o
 obj-$(CONFIG_SERIAL_M32R_SIO) += m32r_sio.o
+obj-$(CONFIG_KGDB_8250) += kgdb_8250.o
diff -puN /dev/null drivers/serial/kgdb_8250.c
--- /dev/null	2004-10-25 00:35:20.587727328 -0700
+++ linux-2.6.10-rc1-trini/drivers/serial/kgdb_8250.c	2004-10-29 11:26:44.979327236 -0700
@@ -0,0 +1,477 @@
+/*
+ * 8250 interface for kgdb.
+ *
+ * This is a merging of many different drivers, and all of the people have
+ * had an impact in some form or another:
+ *
+ * Amit Kale <amitkale@emsyssoft.com>, David Grothe <dave@gcom.com>,
+ * Scott Foehner <sfoehner@engr.sgi.com>, George Anzinger <george@mvista.com>,
+ * Robert Walsh <rjwalsh@durables.org>, wangdi <wangdi@clusterfs.com>,
+ * San Mehat, Tom Rini <trini@mvista.com>
+ */
+
+#include <linux/config.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/kgdb.h>
+#include <linux/interrupt.h>
+#include <linux/tty.h>
+#include <linux/serial.h>
+#include <linux/serial_core.h>
+#include <linux/serial_reg.h>
+#include <linux/serialP.h>
+#include <linux/ioport.h>
+
+#include <asm/io.h>
+#include <asm/serial.h>		/* For BASE_BAUD and SERIAL_PORT_DFNS */
+
+#define GDB_BUF_SIZE	512	/* power of 2, please */
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
+#if defined(CONFIG_KGDB_TTYS1)
+static int kgdb8250_ttyS = 1;
+#elif defined(CONFIG_KGDB_TTYS2)
+static int kgdb8250_ttyS = 2;
+#elif defined(CONFIG_KGDB_TTYS3)
+static int kgdb8250_ttyS = 3;
+#else
+static int kgdb8250_ttyS = 0;		/* Start with this if not given */
+#endif
+
+static char kgdb8250_buf[GDB_BUF_SIZE];
+static atomic_t kgdb8250_buf_in_cnt;
+static int kgdb8250_buf_out_inx;
+
+/* Old-style serial definitions, if existant, and a counter. */
+static int old_rs_table_copied;
+static struct serial_state old_rs_table[] = {
+#ifdef SERIAL_PORT_DFNS
+	SERIAL_PORT_DFNS
+#endif
+};
+
+/* Our internal table of UARTS. */
+#define UART_NR	(ARRAY_SIZE(old_rs_table) + CONFIG_SERIAL_8250_NR_UARTS)
+static struct uart_port kgdb8250_ports[UART_NR] = {
+#ifndef CONFIG_KGDB_SIMPLE_SERIAL
+	{
+#if defined(CONFIG_KGDB_IRQ) && defined(CONFIG_KGDB_PORT)
+		.irq		= CONFIG_KGDB_IRQ,
+		.iobase		= CONFIG_KGDB_PORT,
+		.iotype		= UPIO_PORT,
+#endif
+#ifdef CONFIG_KGDB_IOMEMBASE
+		.membase	= (unsigned char *)CONFIG_KGDB_IOMEMBASE,
+		.iotype		= UPIO_MEM,
+#endif
+	},
+#endif
+};
+
+/* Macros to easily get what we want from kgdb8250_ports[kgdb8250_ttyS] */
+#define CURRENTPORT		kgdb8250_ports[kgdb8250_ttyS]
+#define KGDB8250_IRQ		CURRENTPORT.irq
+#define KGDB8250_REG_SHIFT	CURRENTPORT.regshift
+
+/* Base of the UART. */
+static unsigned long kgdb8250_addr;
+/* Pointers for I/O. */
+static void (*serial_outb) (unsigned char val, unsigned long addr);
+static unsigned long (*serial_inb) (unsigned long addr);
+
+/* Forward declarations. */
+static int kgdb8250_init(void);
+extern int serial8250_release_irq(int irq);
+
+extern atomic_t debugger_active;
+
+static unsigned long
+direct_inb(unsigned long addr)
+{
+	return readb((void *)addr);
+}
+
+static void
+direct_outb(unsigned char val, unsigned long addr)
+{
+	writeb(val, (void *)addr);
+}
+
+static unsigned long
+io_inb(unsigned long port)
+{
+	return inb(port);
+}
+
+static void
+io_outb(unsigned char val, unsigned long port)
+{
+	outb(val, port);
+}
+
+/*
+ * Wait until the interface can accept a char, then write it.
+ */
+static void
+kgdb_put_debug_char(int chr)
+{
+	while (!(serial_inb(kgdb8250_addr + (UART_LSR << KGDB8250_REG_SHIFT)) &
+		UART_LSR_THRE))
+		;
+
+	serial_outb(chr, kgdb8250_addr + (UART_TX << KGDB8250_REG_SHIFT));
+}
+
+/*
+ * Get a byte from the hardware data buffer and return it
+ */
+static int
+read_data_bfr(void)
+{
+	char it = serial_inb(kgdb8250_addr + (UART_LSR << KGDB8250_REG_SHIFT));
+
+	if (it & UART_LSR_DR)
+		return serial_inb(kgdb8250_addr +
+				(UART_RX << KGDB8250_REG_SHIFT));
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
+static int
+kgdb_get_debug_char(void)
+{
+	int retchr;
+	unsigned long flags;
+	local_irq_save(flags);
+
+	/* intr routine has q'd chars */
+	if (atomic_read(&kgdb8250_buf_in_cnt) != 0) {
+		retchr = kgdb8250_buf[kgdb8250_buf_out_inx++];
+		kgdb8250_buf_out_inx &= (GDB_BUF_SIZE - 1);
+		atomic_dec(&kgdb8250_buf_in_cnt);
+		goto out;
+	}
+
+	do {
+		retchr = read_data_bfr();
+	} while (retchr < 0);
+
+out:
+	local_irq_restore(flags);
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
+        /*
+         * If  there is some other CPU in KGDB then this is a
+         * spurious interrupt. so return without even checking a byte
+         */
+        if (atomic_read(&debugger_active))
+               return IRQ_NONE;
+
+	iir = serial_inb(kgdb8250_addr + (UART_IIR << KGDB8250_REG_SHIFT));
+	if (iir & UART_IIR_RDI)
+		kgdb_schedule_breakpoint();
+
+	return IRQ_HANDLED;
+}
+
+/*
+ *  Returns:
+ *	0 on success, 1 on failure.
+ */
+static int
+kgdb8250_init(void)
+{
+	unsigned cval;
+	int bits = 8;
+	int parity = 'n';
+	int cflag = CREAD | HUPCL | CLOCAL;
+	char ier = UART_IER_RDI;
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
+	/* set DLAB */
+	serial_outb(cval | UART_LCR_DLAB, kgdb8250_addr +
+			(UART_LCR << KGDB8250_REG_SHIFT));
+	/* LS */
+	serial_outb(BASE_BAUD / kgdb8250_baud & 0xff, kgdb8250_addr +
+			(UART_DLL << KGDB8250_REG_SHIFT));
+	/* MS  */
+	serial_outb(BASE_BAUD / kgdb8250_baud >> 8, kgdb8250_addr +
+			(UART_DLM << KGDB8250_REG_SHIFT));
+	/* reset DLAB */
+	serial_outb(cval, kgdb8250_addr + (UART_LCR << KGDB8250_REG_SHIFT));
+
+	/*
+	 * XScale-specific bits that need to be set
+	 */
+	if (CURRENTPORT.type == PORT_XSCALE)
+		ier |= UART_IER_UUE | UART_IER_RTOIE;
+
+	/* turn on interrupts */
+	serial_outb(ier, kgdb8250_addr + (UART_IER << KGDB8250_REG_SHIFT));
+	serial_outb(UART_MCR_OUT2 | UART_MCR_DTR | UART_MCR_RTS,
+		    kgdb8250_addr + (UART_MCR << KGDB8250_REG_SHIFT));
+
+	/*
+	 *      If we read 0xff from the LSR, there is no UART here.
+	 */
+	if (serial_inb(kgdb8250_addr + (UART_LSR << KGDB8250_REG_SHIFT)) ==
+			0xff)
+		return -1;
+	return 0;
+}
+
+/*
+ * Copy the old serial_state table to our uart_port table if we haven't
+ * had values specifically configured in.  We need to make sure this only
+ * happens once.
+ */
+static void
+kgdb8250_copy_rs_table(void)
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
+static int
+kgdb8250_local_init(void)
+{
+	if (old_rs_table_copied == 0)
+		kgdb8250_copy_rs_table();
+
+	switch (CURRENTPORT.iotype) {
+	case UPIO_MEM:
+		if (CURRENTPORT.mapbase) {
+			if (!request_mem_region(CURRENTPORT.mapbase,
+						8 << KGDB8250_REG_SHIFT,
+						"kgdb"))
+				return 1;	/* Failed. */
+		}
+		if (CURRENTPORT.flags & UPF_IOREMAP) {
+			CURRENTPORT.membase = ioremap(CURRENTPORT.mapbase,
+					8 << KGDB8250_REG_SHIFT);
+			if (!CURRENTPORT.membase)
+				return 1;	/* Failed. */
+		}
+		kgdb8250_addr = (unsigned long)CURRENTPORT.membase;
+		serial_outb = direct_outb;
+		serial_inb = direct_inb;
+		break;
+	case UPIO_PORT:
+	default:
+		kgdb8250_addr = CURRENTPORT.iobase;
+		serial_outb = io_outb;
+		serial_inb = io_inb;
+	}
+
+	return 0;
+}
+
+static int
+kgdb_init_io(void)
+{
+	if (kgdb8250_local_init())
+		return -1;
+
+#ifdef CONFIG_SERIAL_8250
+	if (serial8250_release_irq(KGDB8250_IRQ))
+		return -1;
+#endif
+
+	if (kgdb8250_init() == -1)
+		return -1;
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
+	request_irq(KGDB8250_IRQ, kgdb8250_interrupt, SA_SHIRQ,
+			"GDB-stub", &CURRENTPORT);
+}
+
+struct kgdb_io kgdb_io_ops = {
+	.read_char = kgdb_get_debug_char,
+	.write_char = kgdb_put_debug_char,
+	.init = kgdb_init_io,
+	.late_init = kgdb8250_hookup_irq,
+};
+
+void
+kgdb8250_add_port(int i, struct uart_port *serial_req)
+{
+	/* Copy the old table in if needed. */
+	if (old_rs_table_copied == 0)
+		kgdb8250_copy_rs_table();
+
+	/* Copy the whole thing over. */
+	memcpy(&kgdb8250_ports[i], serial_req, sizeof(struct uart_port));
+}
+
+/*
+ * Syntax for this cmdline option is "kgdb8250=ttyno,baudrate"
+ * with ",irq,iomembase" tacked on the end on IA64.
+ */
+static int __init
+kgdb8250_opt(char *str)
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
+				(unsigned char *)simple_strtoul(str, &str, 0);
+		}
+	}
+#endif
+
+	return 0;
+
+errout:
+	printk(KERN_ERR "Invalid syntax for option kgdb8250=\n");
+	return 1;
+}
+early_param("kgdb8250", kgdb8250_opt);
diff -puN drivers/serial/serial_core.c~8250 drivers/serial/serial_core.c
--- linux-2.6.10-rc1/drivers/serial/serial_core.c~8250	2004-10-29 11:26:44.970329349 -0700
+++ linux-2.6.10-rc1-trini/drivers/serial/serial_core.c	2004-10-29 11:26:44.981326767 -0700
@@ -903,7 +903,11 @@ uart_tiocmset(struct tty_struct *tty, st
 static void uart_break_ctl(struct tty_struct *tty, int break_state)
 {
 	struct uart_state *state = tty->driver_data;
-	struct uart_port *port = state->port;
+	struct uart_port *port;
+
+	if (!state)
+		return;
+	port = state->port;
 
 	BUG_ON(!kernel_locked());
 
diff -puN lib/Kconfig.debug~8250 lib/Kconfig.debug
--- linux-2.6.10-rc1/lib/Kconfig.debug~8250	2004-10-29 11:26:44.972328879 -0700
+++ linux-2.6.10-rc1-trini/lib/Kconfig.debug	2004-10-29 11:32:57.089929849 -0700
@@ -124,3 +124,104 @@ config KGDB
 	  Documentation of kernel debugger available at
 	  http://kgdb.sourceforge.net
 	  This is only useful for kernel hackers. If unsure, say N.
+
+choice
+	prompt "Method for KGDB communication"
+	depends on KGDB
+	default KGDB_8250
+	help
+	  There are a number of different ways in which you can communicate
+	  with KGDB.  The oldest is using a serial driver.  A newer method
+	  is to use UDP packets and a special network driver.
+
+config KGDB_8250
+	bool "KGDB: On generic serial port (8250)"
+	help
+	  Uses generic serial port (8250) for kgdb. This is independent of the
+	  option 9250/16550 and compatible serial port.
+
+endchoice
+
+config KGDB_SIMPLE_SERIAL
+	bool "Simple selection of KGDB serial port"
+	depends on KGDB_8250
+	help
+	  If you say Y here, you will only have to pick the baud rate
+	  and serial port (ttyS) that you wish to use for KGDB.  If you
+	  say N, you will have provide the I/O port and IRQ number.  Note
+	  that if your serial ports are iomapped, then you must say Y here.
+	  If in doubt, say Y.
+
+choice
+	depends on KGDB_8250
+    	prompt "Debug serial port BAUD"
+	default KGDB_115200BAUD
+	help
+	  Gdb and the kernel stub need to agree on the baud rate to be
+	  used.  Some systems (x86 family at this writing) allow this to
+	  be configured.
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
+	default KGDB_TTYS0
+
+config KGDB_TTYS0
+	bool "ttyS0"
+
+config KGDB_TTYS1
+	bool "ttyS1"
+
+config KGDB_TTYS2
+	bool "ttyS2"
+
+config KGDB_TTYS3
+	bool "ttyS3"
+
+endchoice
+
+config KGDB_IOMEMBASE
+	hex "hex MMIO address of the debug serial port"
+	depends on !KGDB_SIMPLE_SERIAL && IA64
+	help
+	  Some systems (IA64) don't access ports through legacy I/O port
+	  space.  Instead an MMIO address is used to access the UART.
+	  There aren't any standard addresses on most system.  The value
+	  is platform dependent.
+
+config KGDB_PORT
+	hex "hex I/O port address of the debug serial port"
+	depends on !KGDB_SIMPLE_SERIAL && KGDB_8250 && !IA64
+	default  3f8
+	help
+	  Some systems (x86 family at this writing) allow the port
+	  address to be configured.  The number entered is assumed to be
+	  hex, don't put 0x in front of it.  The standard address are:
+	  COM1 3f8 , irq 4 and COM2 2f8 irq 3.  Setserial /dev/ttySx
+	  will tell you what you have.  It is good to test the serial
+	  connection with a live system before trying to debug.
+
+config KGDB_IRQ
+	int "IRQ of the debug serial port"
+	depends on !KGDB_SIMPLE_SERIAL && KGDB_8250 && !IA64
+	default 4
+	help
+	  This is the irq for the debug port.  If everything is working
+	  correctly and the kernel has interrupts on a control C to the
+	  port should cause a break into the kernel debug stub.
_
