Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262433AbUCHJqq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 04:46:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262430AbUCHJqq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 04:46:46 -0500
Received: from svr44.ehostpros.com ([66.98.192.92]:42715 "EHLO
	svr44.ehostpros.com") by vger.kernel.org with ESMTP id S262433AbUCHJkF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 04:40:05 -0500
From: "Amit S. Kale" <amitkale@emsyssoft.com>
Organization: EmSysSoft
To: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: kgdb for mainline kernel: 8250 [patch 3/3]
Date: Mon, 8 Mar 2004 15:06:10 +0530
User-Agent: KMail/1.5
Cc: Tom Rini <trini@kernel.crashing.org>, George Anzinger <george@mvista.com>,
       Pavel Machek <pavel@ucw.cz>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_K6DTArP8zKL58Pq"
Message-Id: <200403081506.10926.amitkale@emsyssoft.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - svr44.ehostpros.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - emsyssoft.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_K6DTArP8zKL58Pq
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-Amit
--Boundary-00=_K6DTArP8zKL58Pq
Content-Type: text/x-diff;
  charset="us-ascii";
  name="8250.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="8250.patch"

Index: linux-2.6.4-rc2-bk3-kgdb/drivers/serial/8250.c
===================================================================
--- linux-2.6.4-rc2-bk3-kgdb.orig/drivers/serial/8250.c	2004-03-08 14:30:02.328600712 +0530
+++ linux-2.6.4-rc2-bk3-kgdb/drivers/serial/8250.c	2004-03-08 14:31:56.551236232 +0530
@@ -1198,12 +1198,17 @@
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
 
 	if (up->port.type == PORT_16C950) {
@@ -1869,6 +1874,10 @@
 	for (i = 0; i < UART_NR; i++) {
 		struct uart_8250_port *up = &serial8250_ports[i];
 
+		if (up->port.irq == released_irq) {
+			continue;
+		}
+
 		up->port.line = i;
 		up->port.ops = &serial8250_pops;
 		init_timer(&up->timer);
@@ -2138,6 +2147,36 @@
 	uart_resume_port(&serial8250_reg, &serial8250_ports[line].port);
 }
 
+/*
+ * Find all the ports using the given irq and shut them down.
+ * Result should be that the irq will be released.
+ * At most one irq can be released this way.
+ * Once an irq is released, any attempts to initialize a port with that irq
+ * will fail with EBUSY.
+ */
+
+int serial8250_release_irq(int irq)
+{
+        struct uart_8250_port *up;
+	int ttyS;
+
+	if (released_irq != -1) {
+		return -EBUSY;
+	}
+	released_irq = irq;
+	for (ttyS = 0; ttyS < UART_NR; ttyS++){
+		up =  &serial8250_ports[ttyS];
+		if (up->port.irq == irq && (irq_lists + irq)->head) {
+#ifdef CONFIG_DEBUG_SPINLOCK   /* ugly business... */
+			if(up->port.lock.magic != SPINLOCK_MAGIC)
+				spin_lock_init(&up->port.lock);
+#endif
+			serial8250_shutdown(&up->port);
+		}
+        }
+	return 0;
+}
+
 static int __init serial8250_init(void)
 {
 	int ret, i;
Index: linux-2.6.4-rc2-bk3-kgdb/drivers/serial/Makefile
===================================================================
--- linux-2.6.4-rc2-bk3-kgdb.orig/drivers/serial/Makefile	2004-03-08 14:30:02.349597520 +0530
+++ linux-2.6.4-rc2-bk3-kgdb/drivers/serial/Makefile	2004-03-08 14:31:56.551236232 +0530
@@ -32,3 +32,5 @@
 obj-$(CONFIG_V850E_UART) += v850e_uart.o
 obj-$(CONFIG_SERIAL98) += serial98.o
 obj-$(CONFIG_SERIAL_PMACZILOG) += pmac_zilog.o
+
+obj-$(CONFIG_KGDB_8250) += kgdb_8250.o
Index: linux-2.6.4-rc2-bk3-kgdb/drivers/serial/kgdb_8250.c
===================================================================
--- linux-2.6.4-rc2-bk3-kgdb.orig/drivers/serial/kgdb_8250.c	2003-01-30 15:54:37.000000000 +0530
+++ linux-2.6.4-rc2-bk3-kgdb/drivers/serial/kgdb_8250.c	2004-03-08 14:31:56.552236080 +0530
@@ -0,0 +1,434 @@
+/*
+ * 8250 interface for kgdb.
+ *
+ * This is a merging of many different drivers, and all of the people have
+ * had an impact in some form or another:
+ *
+ * Amit Kale <amitkale@emsyssoft.com>
+ * David Grothe <dave@gcom.com>
+ * Scott Foehner <sfoehner@engr.sgi.com>
+ * George Anzinger <george@mvista.com>
+ * Robert Walsh <rjwalsh@durables.org>
+ * wangdi <wangdi@clusterfs.com>
+ * San Mehat
+ * Tom Rini <trini@mvista.com>
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
+
+#include <asm/io.h>
+#include <asm/serial.h>		/* For BASE_BAUD and SERIAL_PORT_DFNS */
+
+#define GDB_BUF_SIZE	512	/* power of 2, please */
+
+#if defined(CONFIG_KGDB_9600BAUD)
+#define SERIAL_BAUD 9600
+#elif defined(CONFIG_KGDB_19200BAUD)
+#define SERIAL_BAUD 19200
+#elif defined(CONFIG_KGDB_38400BAUD)
+#define SERIAL_BAUD 38400
+#elif defined(CONFIG_KGDB_57600BAUD)
+#define SERIAL_BAUD 57600
+#elif defined(CONFIG_KGDB_115200BAUD)
+#define SERIAL_BAUD 115200
+#else
+#define SERIAL_BAUD 115200	/* Start with this if not given */
+#endif
+
+#if defined(CONFIG_KGDB_TTYS0)
+#define KGDB_PORT 0
+#elif defined(CONFIG_KGDB_TTYS1)
+#define KGDB_PORT 1
+#elif defined(CONFIG_KGDB_TTYS2)
+#define KGDB_PORT 2
+#elif defined(CONFIG_KGDB_TTYS3)
+#define KGDB_PORT 3
+#else
+#define KGDB_PORT 0		/* Start with this if not given */
+#endif
+
+int kgdb8250_baud = SERIAL_BAUD;
+int kgdb8250_ttyS = KGDB_PORT;
+
+static char kgdb8250_buf[GDB_BUF_SIZE];
+static atomic_t kgdb8250_buf_in_cnt;
+static int kgdb8250_buf_out_inx;
+
+/* Determine serial information. */
+static struct serial_state state = {
+	.magic = SSTATE_MAGIC,
+	.baud_base = BASE_BAUD,
+	.custom_divisor = BASE_BAUD / SERIAL_BAUD,
+};
+
+static struct async_struct gdb_async_info = {
+	.magic = SERIAL_MAGIC,
+	.state = &state,
+	.tty = (struct tty_struct *) &state,
+};
+
+/* Space between registers. */
+static int reg_shift;
+
+/* Not all arches define this. */
+#ifndef SERIAL_PORT_DFNS
+#define SERIAL_PORT_DFNS
+#endif
+static struct serial_state rs_table[] = {
+	SERIAL_PORT_DFNS	/* defined in <asm/serial.h> */
+};
+
+/* Do we need to look in the rs_table? */
+static int serial_from_rs_table = 0;
+
+static void (*serial_outb) (unsigned char val, unsigned long addr);
+static unsigned long (*serial_inb) (unsigned long addr);
+
+int serial8250_release_irq(int irq);
+
+static int kgdb8250_init(void);
+static unsigned long kgdb8250_port;
+
+static int initialized = -1;
+
+static unsigned long
+direct_inb(unsigned long addr)
+{
+	return readb(addr);
+}
+
+static void
+direct_outb(unsigned char val, unsigned long addr)
+{
+	writeb(val, addr);
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
+void
+kgdb_put_debug_char(int chr)
+{
+	while (!(serial_inb(kgdb8250_port + (UART_LSR << reg_shift)) &
+		UART_LSR_THRE))
+		;
+
+	serial_outb(chr, kgdb8250_port + (UART_TX << reg_shift));
+}
+
+/*
+ * Get a byte from the hardware data buffer and return it
+ */
+static int
+read_data_bfr(void)
+{
+	char it = serial_inb(kgdb8250_port + (UART_LSR << reg_shift));
+
+	if (it & UART_LSR_DR)
+		return serial_inb(kgdb8250_port + (UART_RX << reg_shift));
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
+int
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
+	if (irq != gdb_async_info.line)
+		return IRQ_NONE;
+
+	iir = serial_inb(kgdb8250_port + (UART_IIR << reg_shift));
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
+	/*
+	 *      Disable UART interrupts, set DTR and RTS high
+	 *      and set speed.
+	 */
+	cval = 0x3;
+	/* set DLAB */
+	serial_outb(cval | UART_LCR_DLAB, kgdb8250_port +
+			(UART_LCR << reg_shift));
+	/* LS */
+	serial_outb(gdb_async_info.state->custom_divisor & 0xff,
+			kgdb8250_port + (UART_DLL << reg_shift));
+	/* MS  */
+	serial_outb(gdb_async_info.state->custom_divisor >> 8,
+			kgdb8250_port + (UART_DLM << reg_shift));
+	/* reset DLAB */
+	serial_outb(cval, kgdb8250_port + (UART_LCR << reg_shift));
+	/* turn on interrupts */
+	serial_outb(UART_IER_RDI, kgdb8250_port + (UART_IER << reg_shift));
+	serial_outb(UART_MCR_OUT2 | UART_MCR_DTR | UART_MCR_RTS,
+		    kgdb8250_port + (UART_MCR << reg_shift));
+
+	/*
+	 *      If we read 0xff from the LSR, there is no UART here.
+	 */
+	if (serial_inb(kgdb8250_port + (UART_LSR << reg_shift)) == 0xff)
+		return -1;
+	return 0;
+}
+
+int
+kgdb_hook_io(void)
+{
+	int retval;
+
+	/* Setup any serial port information we may need to */
+#ifdef CONFIG_KGDB_SIMPLE_SERIAL
+	/* We must look in the rs_table[]. */
+	serial_from_rs_table = 1;
+#endif
+	/* If the user has overriden our definitions, or if we've only
+	 * been told the ttyS to use, look at rs_table. */
+	if (serial_from_rs_table) {
+		/* The user has selected one of ttyS[0-3], which we pull
+		 * from rs_table[].  If this doesn't exist, user error. */
+		gdb_async_info.port = gdb_async_info.state->port =
+		    rs_table[kgdb8250_ttyS].port;
+		gdb_async_info.line = gdb_async_info.state->irq =
+		    rs_table[kgdb8250_ttyS].irq;
+		gdb_async_info.state->io_type = rs_table[kgdb8250_ttyS].io_type;
+		reg_shift = rs_table[kgdb8250_ttyS].iomem_reg_shift;
+	}
+
+	switch (gdb_async_info.state->io_type) {
+	case SERIAL_IO_MEM:
+		kgdb8250_port = (unsigned long)
+		    rs_table[kgdb8250_ttyS].iomem_base;
+		serial_outb = direct_outb;
+		serial_inb = direct_inb;
+		break;
+	case SERIAL_IO_PORT:
+	default:
+		kgdb8250_port = rs_table[kgdb8250_ttyS].port;
+		serial_outb = io_outb;
+		serial_inb = io_inb;
+	}
+
+#ifndef CONFIG_KGDB_SIMPLE_SERIAL
+	/* The user has provided the IRQ and I/O location. */
+	kgdb8250_port = gdb_async_info.port = gdb_async_info.state->port =
+		CONFIG_KGDB_PORT;
+	gdb_async_info.line = gdb_async_info.state->irq = CONFIG_KGDB_IRQ;
+#endif
+
+#ifdef CONFIG_SERIAL_8250
+	if (serial8250_release_irq(gdb_async_info.line))
+		return -1;
+#endif
+
+	if (kgdb8250_init() == -1)
+		return -1;
+
+	retval = request_irq(gdb_async_info.line, kgdb8250_interrupt,
+			     SA_INTERRUPT, "GDB-stub", NULL);
+	if (retval == 0)
+		initialized = 1;
+	else
+		initialized = 0;
+
+	return 0;
+}
+
+struct kgdb_serial kgdb8250_serial_driver = {
+	.read_char = kgdb_get_debug_char,
+	.write_char = kgdb_put_debug_char,
+	.hook = kgdb_hook_io,
+};
+
+void
+kgdb8250_add_port(int i, struct uart_port *serial_req)
+{
+	rs_table[i].io_type = serial_req->iotype;
+	rs_table[i].port = serial_req->line;
+	rs_table[i].irq = serial_req->irq;
+	rs_table[i].iomem_base = serial_req->membase;
+	rs_table[i].iomem_reg_shift = serial_req->regshift;
+
+	/* We will want to look in the rs_table now. */
+	serial_from_rs_table = 1;
+}
+
+/*
+ * Syntax for this cmdline option is
+ * kgdb8250=ttyno,baudrate
+ */
+
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
+	kgdb8250_baud = simple_strtoul(str, NULL, 10);
+	if (kgdb8250_baud != 9600 && kgdb8250_baud != 19200 &&
+	    kgdb8250_baud != 38400 && kgdb8250_baud != 57600 &&
+	    kgdb8250_baud != 115200)
+		goto errout;
+
+	/* Make the baud rate change happen. */
+	gdb_async_info.state->custom_divisor = BASE_BAUD / kgdb8250_baud;
+
+	kgdb_serial = &kgdb8250_serial_driver;
+
+	return 1;
+
+      errout:
+	printk("Invalid syntax for option kgdb8250=\n");
+	return 0;
+}
+
+__setup("kgdb8250=", kgdb8250_opt);
Index: linux-2.6.4-rc2-bk3-kgdb/drivers/serial/serial_core.c
===================================================================
--- linux-2.6.4-rc2-bk3-kgdb.orig/drivers/serial/serial_core.c	2004-03-08 14:30:02.332600104 +0530
+++ linux-2.6.4-rc2-bk3-kgdb/drivers/serial/serial_core.c	2004-03-08 14:31:56.554235776 +0530
@@ -917,7 +917,11 @@
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
 
Index: linux-2.6.4-rc2-bk3-kgdb/kernel/Kconfig.kgdb
===================================================================
--- linux-2.6.4-rc2-bk3-kgdb.orig/kernel/Kconfig.kgdb	2004-03-08 14:31:42.820323648 +0530
+++ linux-2.6.4-rc2-bk3-kgdb/kernel/Kconfig.kgdb	2004-03-08 14:31:56.554235776 +0530
@@ -11,3 +11,104 @@
 	  Documentation of kernel debugger available at
 	  http://kgdb.sourceforge.net
 	  This is only useful for kernel hackers. If unsure, say N.
+
+choice
+	prompt "Method for KGDB communication"
+	depends on KGDB
+	default PPC_SIMPLE_SERIAL if PPC32 && (8xx || 8260)
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
+config PPC_SIMPLE_SERIAL 
+	bool "KGDB: On any serial port"
+	depends on PPC32
+	help
+	  Use a very simple, and not necessarily feature complete serial
+	  driver.  This is the only serial option currently for MPC8xx or
+	  MPC82xx based ports that do not offer an 8250-style UART.
+
+endchoice
+
+config KGDB_SIMPLE_SERIAL
+	bool "Simple selection of KGDB serial port"
+	depends on KGDB_8250 || PPC_SIMPLE_SERIAL
+	help
+	  If you say Y here, you will only have to pick the baud rate
+	  and serial port (ttyS) that you wish to use for KGDB.  If you
+	  say N, you will have provide the I/O port and IRQ number.  Note
+	  that if your serial ports are iomapped, then you must say Y here.
+	  If in doubt, say Y.
+
+choice
+	depends on KGDB_8250 || PPC_SIMPLE_SERIAL
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
+config KGDB_PORT
+	hex "hex I/O port address of the debug serial port"
+	depends on !KGDB_SIMPLE_SERIAL && (KGDB_8250 || PPC_SIMPLE_SERIAL)
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
+	depends on !KGDB_SIMPLE_SERIAL && (KGDB_8250 || PPC_SIMPLE_SERIAL)
+	default 4
+	help
+	  This is the irq for the debug port.  If everything is working
+	  correctly and the kernel has interrupts on a control C to the
+	  port should cause a break into the kernel debug stub.

--Boundary-00=_K6DTArP8zKL58Pq--

