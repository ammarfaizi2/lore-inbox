Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261456AbSJQL6S>; Thu, 17 Oct 2002 07:58:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261401AbSJQL5G>; Thu, 17 Oct 2002 07:57:06 -0400
Received: from precia.cinet.co.jp ([210.166.75.133]:9344 "EHLO
	precia.cinet.co.jp") by vger.kernel.org with ESMTP
	id <S261403AbSJQLfF>; Thu, 17 Oct 2002 07:35:05 -0400
Date: Thu, 17 Oct 2002 20:40:13 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH][RFC] add support for PC-9800 architecture (20/26) serial #1
Message-ID: <20021017204013.A1265@precia.cinet.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is part 20/26 of patchset for add support NEC PC-9800 architecture,
against 2.5.43.

Summary:
 serial driver related modules.
  - change IO port address and IRQ number.
  - add new PNP device entry.
  - add register definition for new serial driver.

diffstat:
 drivers/serial/8250_cs.c    |    1 +
 drivers/serial/8250_pnp.c   |    7 +++++++
 drivers/serial/Config.in    |   10 ++++++++++
 drivers/serial/Makefile     |    6 +++++-
 include/asm-i386/serial.h   |   18 ++++++++++++++++++
 include/linux/serial.h      |   13 +++++++++++++
 include/linux/serialP.h     |    5 +++++
 include/linux/serial_core.h |    9 +++++++++
 include/linux/serial_reg.h  |   43 +++++++++++++++++++++++++++++++++++++++++++
 9 files changed, 111 insertions(+), 1 deletion(-)

patch:
diff -urN linux/drivers/serial/Config.in linux98/drivers/serial/Config.in
--- linux/drivers/serial/Config.in	Sat Oct 12 13:21:31 2002
+++ linux98/drivers/serial/Config.in	Sun Oct 13 19:44:24 2002
@@ -12,12 +12,22 @@
 dep_bool '  Console on 8250/16550 and compatible serial port (EXPERIMENTAL)' CONFIG_SERIAL_8250_CONSOLE $CONFIG_SERIAL_8250 $CONFIG_EXPERIMENTAL
 dep_tristate '  8250/16550 PCMCIA device support' CONFIG_SERIAL_8250_CS $CONFIG_PCMCIA $CONFIG_SERIAL_8250
 
+if [ "$CONFIG_PC9800" != "y" ]; then
 dep_mbool 'Extended 8250/16550 serial driver options' CONFIG_SERIAL_8250_EXTENDED $CONFIG_SERIAL_8250
 dep_bool '  Support more than 4 serial ports' CONFIG_SERIAL_8250_MANY_PORTS $CONFIG_SERIAL_8250_EXTENDED
 dep_bool '  Support for sharing serial interrupts' CONFIG_SERIAL_8250_SHARE_IRQ $CONFIG_SERIAL_8250_EXTENDED
 dep_bool '  Autodetect IRQ on standard ports (unsafe)' CONFIG_SERIAL_8250_DETECT_IRQ $CONFIG_SERIAL_8250_EXTENDED
 dep_bool '  Support special multiport boards' CONFIG_SERIAL_8250_MULTIPORT $CONFIG_SERIAL_8250_EXTENDED
 dep_bool '  Support RSA serial ports' CONFIG_SERIAL_8250_RSA $CONFIG_SERIAL_8250_EXTENDED
+else  # CONFIG_PC9800=y
+dep_mbool 'NEC PC-9801 primary serial port support (EXPERIMENTAL)' CONFIG_SERIAL_PC9800 $CONFIG_SERIAL_8250
+dep_bool '  Support MC16550II (EXPERIMENTAL)' CONFIG_MC16550II $CONFIG_SERIAL_PC9800
+if [ "$CONFIG_MC16550II" = "y" ]; then
+   comment '    MC16550II COM2, COM3 '
+   int '    MC16550II shared IRQ (3, 5, 6, 12)' CONFIG_MC16550II_IRQ 3
+   hex '    MC16550II base address (d0,d2,d4,d6,d8,da,dc,de)' CONFIG_MC16550II_BASE d2
+fi
+fi
 
 comment 'Non-8250 serial port support'
 
diff -urN linux/drivers/serial/Makefile linux98/drivers/serial/Makefile
--- linux/drivers/serial/Makefile	Wed Oct 16 13:20:41 2002
+++ linux98/drivers/serial/Makefile	Wed Oct 16 15:31:48 2002
@@ -4,14 +4,18 @@
 #  $Id: Makefile,v 1.8 2002/07/21 21:32:30 rmk Exp $
 #
 
-export-objs	:= core.o 8250.o suncore.o
+export-objs	:= core.o 8250.o suncore.o serial98.o
 
 serial-8250-y :=
 serial-8250-$(CONFIG_PCI) += 8250_pci.o
 serial-8250-$(CONFIG_ISAPNP) += 8250_pnp.o
 obj-$(CONFIG_SERIAL_CORE) += core.o
 obj-$(CONFIG_SERIAL_21285) += 21285.o
+ifneq ($(CONFIG_SERIAL_PC9800),y)
 obj-$(CONFIG_SERIAL_8250) += 8250.o $(serial-8250-y)
+else
+obj-$(CONFIG_SERIAL_8250) += serial98.o $(serial-8250-y)
+endif
 obj-$(CONFIG_SERIAL_8250_CS) += 8250_cs.o
 obj-$(CONFIG_SERIAL_8250_ACORN) += 8250_acorn.o
 obj-$(CONFIG_SERIAL_ANAKIN) += anakin.o
diff -urN linux/drivers/serial/8250_cs.c linux98/drivers/serial/8250_cs.c
--- linux/drivers/serial/8250_cs.c	Thu Jul 25 06:03:28 2002
+++ linux98/drivers/serial/8250_cs.c	Thu Jul 25 15:48:59 2002
@@ -307,6 +307,7 @@
 	serial.port = port;
 	serial.irq = irq;
 	serial.flags = ASYNC_SKIP_TEST | ASYNC_SHARE_IRQ;
+	serial.baud_base = 230400;
 	line = register_serial(&serial);
 	if (line < 0) {
 		printk(KERN_NOTICE "serial_cs: register_serial() at 0x%04lx,"
diff -urN linux/drivers/serial/8250_pnp.c linux98/drivers/serial/8250_pnp.c
--- linux/drivers/serial/8250_pnp.c	Sat Oct 12 13:21:04 2002
+++ linux98/drivers/serial/8250_pnp.c	Sun Oct 13 21:02:23 2002
@@ -187,6 +187,8 @@
 	{	"MVX00A1",		0	},
 	/* PC Rider K56 Phone System PnP */
 	{	"MVX00F2",		0	},
+	/* NEC 98NOTE SPEAKER PHONE FAX MODEM(33600bps) */
+	{	"nEC8241",		0	},
 	/* Pace 56 Voice Internal Plug & Play Modem */
 	{	"PMC2430",		0	},
 	/* Generic */
@@ -379,7 +381,12 @@
 			    ((port->min == 0x2f8) ||
 			     (port->min == 0x3f8) ||
 			     (port->min == 0x2e8) ||
+#ifndef CONFIG_PC9800
 			     (port->min == 0x3e8)))
+#else
+			     (port->min == 0x3e8) ||
+			     (port->min == 0x8b0)))
+#endif
 				return 0;
 	}
 
diff -urN linux/include/asm-i386/serial.h linux98/include/asm-i386/serial.h
--- linux/include/asm-i386/serial.h	Mon Apr 15 04:18:51 2002
+++ linux98/include/asm-i386/serial.h	Wed Apr 17 10:37:22 2002
@@ -50,14 +50,22 @@
 
 #define C_P(card,port) (((card)<<6|(port)<<3) + 1)
 
+#ifndef CONFIG_PC9800
 #define STD_SERIAL_PORT_DEFNS			\
 	/* UART CLK   PORT IRQ     FLAGS        */			\
 	{ 0, BASE_BAUD, 0x3F8, 4, STD_COM_FLAGS },	/* ttyS0 */	\
 	{ 0, BASE_BAUD, 0x2F8, 3, STD_COM_FLAGS },	/* ttyS1 */	\
 	{ 0, BASE_BAUD, 0x3E8, 4, STD_COM_FLAGS },	/* ttyS2 */	\
 	{ 0, BASE_BAUD, 0x2E8, 3, STD_COM4_FLAGS },	/* ttyS3 */
+#else
+#define STD_SERIAL_PORT_DEFNS			\
+	/* UART CLK   PORT IRQ     FLAGS        */			\
+	{ 0, BASE_BAUD, 0x30, 4, STD_COM_FLAGS },	/* ttyS0 */	\
+	{ 0, BASE_BAUD, 0x238, 5, STD_COM_FLAGS },	/* ttyS1 */
+#endif /* CONFIG_PC9800 */
 
 
+#ifndef CONFIG_PC9800
 #ifdef CONFIG_SERIAL_MANY_PORTS
 #define EXTRA_SERIAL_PORT_DEFNS			\
 	{ 0, BASE_BAUD, 0x1A0, 9, FOURPORT_FLAGS }, 	/* ttyS4 */	\
@@ -91,6 +99,16 @@
 #else
 #define EXTRA_SERIAL_PORT_DEFNS
 #endif
+#else /* CONFIG_PC9800 */
+#ifdef CONFIG_MC16550II
+#define EXTRA_SERIAL_PORT_DEFNS			\
+	/* MC16550II */				\
+	{ 0, BASE_BAUD*4, CONFIG_MC16550II_BASE, CONFIG_MC16550II_IRQ, STD_COM_FLAGS }, /* ttyS2 */	\
+	{ 0, BASE_BAUD*4, CONFIG_MC16550II_BASE+0x800, CONFIG_MC16550II_IRQ, STD_COM_FLAGS }, /* ttyS3 */
+#else
+#define EXTRA_SERIAL_PORT_DEFNS
+#endif
+#endif /* CONFIG_PC9800 */
 
 /* You can have up to four HUB6's in the system, but I've only
  * included two cards here for a total of twelve ports.
diff -urN linux/include/linux/serial.h linux98/include/linux/serial.h
--- linux/include/linux/serial.h	Mon Sep 16 11:18:23 2002
+++ linux98/include/linux/serial.h	Mon Sep 16 16:21:38 2002
@@ -10,6 +10,8 @@
 #ifndef _LINUX_SERIAL_H
 #define _LINUX_SERIAL_H
 
+#include <linux/config.h>
+
 #ifdef __KERNEL__
 #include <asm/page.h>
 
@@ -75,11 +77,22 @@
 #define PORT_16654	11
 #define PORT_16850	12
 #define PORT_RSA	13	/* RSA-DV II/S card */
+#ifndef CONFIG_PC9800
 #define PORT_MAX	13
+#else
+#define PORT_8251	14
+#define PORT_8251_19K	15
+#define PORT_8251_FIFO	16
+#define PORT_8251_VFAST	17
+#define PORT_MC16550II	18
+#define PORT_MAX	18
+#endif
 
 #define SERIAL_IO_PORT	0
 #define SERIAL_IO_HUB6	1
 #define SERIAL_IO_MEM	2
+#define SERIAL_IO_8251	3
+#define SERIAL_IO_MC16550II 4
 
 struct serial_uart_config {
 	char	*name;
diff -urN linux/include/linux/serialP.h linux98/include/linux/serialP.h
--- linux/include/linux/serialP.h	Tue Oct  8 10:56:20 2002
+++ linux98/include/linux/serialP.h	Tue Oct  8 11:01:42 2002
@@ -20,6 +20,7 @@
  */
 
 #include <linux/config.h>
+#include <linux/version.h>
 #include <linux/termios.h>
 #include <linux/workqueue.h>
 #include <linux/circ_buf.h>
@@ -75,6 +76,10 @@
 	int			MCR; 	/* Modem control register */
 	int			LCR; 	/* Line control register */
 	int			ACR;	 /* 16950 Additional Control Reg. */
+#ifdef CONFIG_PC9800
+	int			cmd8251;
+	int			msr8251;
+#endif
 	unsigned long		event;
 	unsigned long		last_active;
 	int			line;
diff -urN linux/include/linux/serial_core.h linux98/include/linux/serial_core.h
--- linux/include/linux/serial_core.h	Sun Aug 11 10:41:20 2002
+++ linux98/include/linux/serial_core.h	Wed Aug 21 16:26:45 2002
@@ -37,7 +37,16 @@
 #define PORT_16654	11
 #define PORT_16850	12
 #define PORT_RSA	13
+#ifndef CONFIG_PC9800
 #define PORT_MAX_8250	13	/* max port ID */
+#else
+#define PORT_8251	14
+#define PORT_8251_19K	15
+#define PORT_8251_FIFO	16
+#define PORT_8251_VFAST	17
+#define PORT_MC16550II	18
+#define PORT_MAX_8250	18	/* max port ID */
+#endif
 
 /*
  * ARM specific type numbers.  These are not currently guaranteed
diff -urN linux/include/linux/serial_reg.h linux98/include/linux/serial_reg.h
--- linux/include/linux/serial_reg.h	Wed May  2 08:05:00 2001
+++ linux98/include/linux/serial_reg.h	Fri Aug 17 22:15:12 2001
@@ -14,6 +14,8 @@
 #ifndef _LINUX_SERIAL_REG_H
 #define _LINUX_SERIAL_REG_H
 
+#include <linux/config.h>
+
 #define UART_RX		0	/* In:  Receive buffer (DLAB=0) */
 #define UART_TX		0	/* Out: Transmit buffer (DLAB=0) */
 #define UART_DLL	0	/* Out: Divisor Latch Low (DLAB=1) */
@@ -229,6 +231,47 @@
 #define UART_TRG_120	0x78
 #define UART_TRG_128	0x80
 
+#ifdef CONFIG_PC9800
+
+#define RX_8251F	0x130	/* In: Receive buffer */
+#define TX_8251F	0x130	/* Out: Transmit buffer */
+#define LSR_8251F	0x132	/* In: Line Status Register */
+#define MSR_8251F	0x134	/* In: Modem Status Register */
+#define IIR_8251F	0x136	/* In: Interrupt ID Register */
+#define FCR_8251F	0x138	/* I/O: FIFO Control Register */
+#define IER2_8251F	0x138	/* I/O: Interrupt Enable Register */
+#define VFAST_8251F	0x13a	/* I/O: VFAST mode Register */
+
+#define COMMAND_8251F	0x32	/* Out: 8251 Command Resister */
+#define IER1_8251F	0x35	/* I/O: Interrupt Enable Register */
+#define IER1_8251F_COUT	0x37	/* Out: Interrupt Enable Register */
+
+#define COMMAND_8251F_DUMMY 0	/* Dummy Command */
+#define COMMAND_8251F_RESET 0x40 /* Reset Command */
+
+#define VFAST_ENABLE	0x80	/* V.Fast mode Enable */
+
+/* Interrupt Reason */
+#define INTR_8251_TXRE	4
+#define INTR_8251_TXEE	2
+#define INTR_8251_RXRE	1
+/* I/O Port */
+#define PORT_8251_DATA	0
+#define PORT_8251_CMD	2
+#define PORT_8251_MOD	2
+#define PORT_8251_STS	2
+/* status in */
+#define STAT_8251_TXRDY	1
+#define STAT_8251_RXRDY	2
+#define STAT_8251_TXEMP	4
+#define STAT_8251_PER	8
+#define STAT_8251_OER	16
+#define STAT_8251_FER	32
+#define STAT_8251_BRK	64
+#define STAT_8251_DSR	128
+
+#endif /* CONFIG_PC9800 */
+
 /*
  * These definitions are for the RSA-DV II/S card, from
  *
