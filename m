Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266719AbUBQWXN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 17:23:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266577AbUBQWVS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 17:21:18 -0500
Received: from fed1mtao01.cox.net ([68.6.19.244]:58331 "EHLO
	fed1mtao01.cox.net") by vger.kernel.org with ESMTP id S266654AbUBQWDJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 17:03:09 -0500
Date: Tue, 17 Feb 2004 15:03:05 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH][2/6] A different KGDB stub
Message-ID: <20040217220305.GC16881@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following is the 8250 driver for this KGDB stub.

 8250.c        |   39 ++++
 Makefile      |    2 
 kgdb_8250.c   |  500 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 serial_core.c |    4 
 4 files changed, 545 insertions(+)
--- linux-2.6.3-rc4/drivers/serial/8250.c	2004-02-17 09:50:45.000000000 -0700
+++ linux-2.6.3-rc4-kgdb/drivers/serial/8250.c	2004-02-17 11:33:48.330188840 -0700
@@ -1198,12 +1198,17 @@ static void serial8250_break_ctl(struct 
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
@@ -1869,6 +1874,10 @@ static void __init serial8250_register_p
 	for (i = 0; i < UART_NR; i++) {
 		struct uart_8250_port *up = &serial8250_ports[i];
 
+		if (up->port.irq == released_irq) {
+			continue;
+		}
+
 		up->port.line = i;
 		up->port.ops = &serial8250_pops;
 		init_timer(&up->timer);
@@ -2138,6 +2147,36 @@ void serial8250_resume_port(int line)
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
+		return 1;
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
--- linux-2.6.3-rc4/drivers/serial/Makefile	2004-02-17 09:52:32.000000000 -0700
+++ linux-2.6.3-rc4-kgdb/drivers/serial/Makefile	2004-02-17 11:34:01.824126266 -0700
@@ -32,3 +32,5 @@ obj-$(CONFIG_SERIAL_COLDFIRE) += mcfseri
 obj-$(CONFIG_V850E_UART) += v850e_uart.o
 obj-$(CONFIG_SERIAL98) += serial98.o
 obj-$(CONFIG_SERIAL_PMACZILOG) += pmac_zilog.o
+
+obj-$(CONFIG_KGDB_8250) += kgdb_8250.o
--- linux-2.6.3-rc4/drivers/serial/kgdb_8250.c	1969-12-31 17:00:00.000000000 -0700
+++ linux-2.6.3-rc4-kgdb/drivers/serial/kgdb_8250.c	2004-02-17 11:34:25.480757232 -0700
@@ -0,0 +1,500 @@
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
+#include <linux/spinlock.h>
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
+static int kgdb8250_buf_in_inx;
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
+ *
+ * Locking here is a bit of a problem.	We MUST not lock out communication
+ * if we are trying to talk to gdb about a kgdb entry.	ON the other hand
+ * we can loose chars in the console pass thru if we don't lock.  It is also
+ * possible that we could hold the lock or be waiting for it when kgdb
+ * NEEDS to talk.  Since kgdb locks down the world, it does not need locks.
+ * We do, of course have possible issues with interrupting a uart operation,
+ * but we will just depend on the uart status to help keep that straight.
+ */
+
+static spinlock_t uart_interrupt_lock = SPIN_LOCK_UNLOCKED;
+#ifdef CONFIG_SMP
+extern spinlock_t kgdb_spinlock;
+#endif
+
+int
+kgdb_get_debug_char(void)
+{
+	int retchr;
+	unsigned long flags;
+	local_irq_save(flags);
+#ifdef CONFIG_SMP
+	if (!spin_is_locked(&kgdb_spinlock)) {
+		spin_lock(&uart_interrupt_lock);
+	}
+#endif
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
+#ifdef CONFIG_SMP
+	if (!spin_is_locked(&kgdb_spinlock)) {
+		spin_unlock(&uart_interrupt_lock);
+	}
+#endif
+	local_irq_restore(flags);
+
+	return retchr;
+}
+
+/*
+ * This is the receiver interrupt routine for the GDB stub.
+ * It will receive a limited number of characters of input
+ * from the gdb  host machine and save them up in a buffer.
+ *
+ * When kgdb_get_debug_char() is called it
+ * draws characters out of the buffer until it is empty and
+ * then reads directly from the serial port.
+ *
+ * We do not attempt to write chars from the interrupt routine
+ * since the stubs do all of that via kgdb_put_debug_char() which
+ * writes one byte after waiting for the interface to become
+ * ready.
+ *
+ * The debug stubs like to run with interrupts disabled since,
+ * after all, they run as a consequence of a breakpoint in
+ * the kernel.
+ *
+ * Perhaps someone who knows more about the tty driver than I
+ * care to learn can make this work for any low level serial
+ * driver.
+ */
+static irqreturn_t
+kgdb8250_interrupt(int irq, void *dev_id, struct pt_regs *regs)
+{
+	int chr, iir;
+	unsigned long flags;
+
+	if (irq != gdb_async_info.line)
+		return IRQ_NONE;
+
+	/* If we get an interrupt, then KGDB is trying to connect. */
+	if (!kgdb_connected) {
+		kgdb_schedule_breakpoint();
+		return IRQ_HANDLED;
+	}
+
+	local_irq_save(flags);
+	spin_lock(&uart_interrupt_lock);
+
+	do {
+		chr = read_data_bfr();
+		iir = serial_inb(kgdb8250_port + (UART_IIR << reg_shift));
+		if (chr < 0)
+			continue;
+
+		/* Check whether gdb sent interrupt */
+		if (chr == 3) {
+			breakpoint();
+			continue;
+		}
+
+		if (atomic_read(&kgdb8250_buf_in_cnt) >= GDB_BUF_SIZE) {
+			/* buffer overflow, clear it */
+			kgdb8250_buf_in_inx = 0;
+			atomic_set(&kgdb8250_buf_in_cnt, 0);
+			kgdb8250_buf_out_inx = 0;
+			break;
+		}
+
+		kgdb8250_buf[kgdb8250_buf_in_inx++] = chr;
+		kgdb8250_buf_in_inx &= (GDB_BUF_SIZE - 1);
+		atomic_inc(&kgdb8250_buf_in_cnt);
+	} while (iir & UART_IIR_RDI);
+
+	spin_unlock(&uart_interrupt_lock);
+	local_irq_restore(flags);
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
+		    rs_table[KGDB_PORT].port;
+		gdb_async_info.line = gdb_async_info.state->irq =
+		    rs_table[KGDB_PORT].irq;
+		gdb_async_info.state->io_type = rs_table[KGDB_PORT].io_type;
+		reg_shift = rs_table[KGDB_PORT].iomem_reg_shift;
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
+	return 1;
+
+      errout:
+	printk("Invalid syntax for option kgdb8250=\n");
+	return 0;
+}
+
+__setup("kgdb8250=", kgdb8250_opt);
--- linux-2.6.3-rc4/drivers/serial/serial_core.c	2004-02-17 09:51:31.000000000 -0700
+++ linux-2.6.3-rc4-kgdb/drivers/serial/serial_core.c	2004-02-17 11:33:53.462024119 -0700
@@ -1214,6 +1214,10 @@ static void uart_close(struct tty_struct
 	struct uart_state *state = tty->driver_data;
 	struct uart_port *port;
 
+	if (!state)
+		return;
+	port = state->port;
+
 	BUG_ON(!kernel_locked());
 
 	if (!state || !state->port)

-- 
Tom Rini
http://gate.crashing.org/~trini/
