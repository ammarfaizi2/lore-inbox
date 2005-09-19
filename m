Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932632AbVISUiR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932632AbVISUiR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 16:38:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932630AbVISUiR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 16:38:17 -0400
Received: from smtp103.biz.mail.re2.yahoo.com ([68.142.229.217]:48542 "HELO
	smtp103.biz.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S932629AbVISUiQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 16:38:16 -0400
From: Pantelis Antoniou <pantelis@embeddedalley.com>
Reply-To: pantelis@embeddedalley.com
Organization: EASI
To: rmk+serial@arm.linux.org.uk
Subject: [PATCH] Au1x00 8250 uart support.
User-Agent: KMail/1.8
MIME-Version: 1.0
Cc: linux-kernel@vger.kernel.org, cw@f00f.org,
       Pete Popov <ppopov@embeddedalley.com>,
       Matt Porter <mporter@embeddedalley.com>
Date: Mon, 19 Sep 2005 23:40:10 +0300
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_qIyLDiKDjFcxUQc"
Message-Id: <200509192340.10450.pantelis@embeddedalley.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_qIyLDiKDjFcxUQc
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Russell,

The following patch enables the use of the Au1x00 AMD SoC UARTs
through the standard 8250 serial driver.

The Au1x00 UARTs are weird in the following two ways:

1) The registers are not present at the normal offsets, so
   a mapping function is used to transform them.

b) Modem status signals are not supported on all the members
   of the Au1x00 family, so the modem status change interrupts
   must not be enabled, or we die in an irq storm.

In order to not affect any standard 8250 parts, the code in
question is #ifdef'ed on CONFIG_SERIAL_8250_AU1X00. If you 
deem the readability of the code is more important you may
removed them, without any effect on the functionality.

I've also considered abstracting the register mapping to a
couple of extra fields on plat_serial8250_port, but wasn't
sure how that would go.

Please comment.

Pantelis

----

Signed-off-by: Pantelis Antoniou <pantelis@embeddedalley.ocm>

 drivers/serial/8250.c        |   63 ++++++++++++++++++++++++++++
 drivers/serial/8250.h        |    1
 drivers/serial/8250_au1x00.c |   95 
+++++++++++++++++++++++++++++++++++++++++++
 drivers/serial/Kconfig       |    8 +++
 drivers/serial/Makefile      |    1
 drivers/serial/serial_core.c |    1
 include/linux/serial_8250.h  |    1
 include/linux/serial_core.h  |    4 +
 8 files changed, 172 insertions(+), 2 deletions(-)


--Boundary-00=_qIyLDiKDjFcxUQc
Content-Type: text/plain;
  charset="us-ascii";
  name="8250au-2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="8250au-2.patch"

diff --git a/drivers/serial/8250.c b/drivers/serial/8250.c
--- a/drivers/serial/8250.c
+++ b/drivers/serial/8250.c
@@ -249,10 +249,42 @@ static const struct serial8250_config ua
 		.fcr		= UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_10,
 		.flags		= UART_CAP_FIFO | UART_CAP_UUE,
 	},
+	[PORT_AU1X00] = {
+		.name		= "Au1x00",
+		.fifo_size	= 16,
+		.tx_loadsz	= 16,
+		.fcr		= UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_10,
+		.flags		= UART_CAP_FIFO | UART_CAP_NOMSR,
+	},
+};
+
+#ifdef CONFIG_SERIAL_8250_AU1X00
+static const u8 au_io_in_map[] = {
+	[UART_RX]  = 0,
+	[UART_IER] = 2,
+	[UART_IIR] = 3,
+	[UART_LCR] = 5,
+	[UART_MCR] = 6,
+	[UART_LSR] = 7,
+	[UART_MSR] = 8,
 };
 
+static const u8 au_io_out_map[] = {
+	[UART_TX]  = 1,
+	[UART_IER] = 2,
+	[UART_FCR] = 4,
+	[UART_LCR] = 5,
+	[UART_MCR] = 6,
+};
+#endif
+
 static _INLINE_ unsigned int serial_in(struct uart_8250_port *up, int offset)
 {
+#ifdef CONFIG_SERIAL_8250_AU1X00
+	if (up->port.iotype == UPIO_AU)
+		offset = au_io_in_map[offset];
+#endif
+
 	offset <<= up->port.regshift;
 
 	switch (up->port.iotype) {
@@ -266,6 +298,11 @@ static _INLINE_ unsigned int serial_in(s
 	case UPIO_MEM32:
 		return readl(up->port.membase + offset);
 
+#ifdef CONFIG_SERIAL_8250_AU1X00
+	case UPIO_AU:
+		return __raw_readl(up->port.membase + offset);
+#endif
+
 	default:
 		return inb(up->port.iobase + offset);
 	}
@@ -274,6 +311,11 @@ static _INLINE_ unsigned int serial_in(s
 static _INLINE_ void
 serial_out(struct uart_8250_port *up, int offset, int value)
 {
+#ifdef CONFIG_SERIAL_8250_AU1X00
+	if (up->port.iotype == UPIO_AU)
+		offset = au_io_out_map[offset];
+#endif
+
 	offset <<= up->port.regshift;
 
 	switch (up->port.iotype) {
@@ -290,6 +332,12 @@ serial_out(struct uart_8250_port *up, in
 		writel(value, up->port.membase + offset);
 		break;
 
+#ifdef CONFIG_SERIAL_8250_AU1X00
+	case UPIO_AU:
+		__raw_writel(value, up->port.membase + offset);
+		break;
+#endif
+
 	default:
 		outb(value, up->port.iobase + offset);
 	}
@@ -910,6 +958,15 @@ static void autoconfig(struct uart_8250_
 		}
 	}
 #endif
+
+#ifdef CONFIG_SERIAL_8250_AU1X00
+	/* if access method is AU, it is a AU */
+	if (up->port.type == PORT_16550A && up->port.iotype == UPIO_AU) {
+		up->port.type = PORT_AU1X00;
+		up->capabilities |= UART_CAP_NOMSR;	/* to stop whine */
+	}
+#endif
+
 	serial_outp(up, UART_LCR, save_lcr);
 
 	if (up->capabilities != uart_config[up->port.type].flags) {
@@ -1057,6 +1114,10 @@ static void serial8250_enable_ms(struct 
 {
 	struct uart_8250_port *up = (struct uart_8250_port *)port;
 
+	/* no MSR capabilities */
+	if (up->capabilities & UART_CAP_NOMSR)
+		return;
+
 	up->ier |= UART_IER_MSI;
 	serial_out(up, UART_IER, up->ier);
 }
@@ -1774,7 +1835,7 @@ serial8250_set_termios(struct uart_port 
 	 * CTS flow control flag and modem status interrupts
 	 */
 	up->ier &= ~UART_IER_MSI;
-	if (UART_ENABLE_MS(&up->port, termios->c_cflag))
+	if (!(up->capabilities & UART_CAP_NOMSR) && UART_ENABLE_MS(&up->port, termios->c_cflag))
 		up->ier |= UART_IER_MSI;
 	if (up->capabilities & UART_CAP_UUE)
 		up->ier |= UART_IER_UUE | UART_IER_RTOIE;
diff --git a/drivers/serial/8250.h b/drivers/serial/8250.h
--- a/drivers/serial/8250.h
+++ b/drivers/serial/8250.h
@@ -46,6 +46,7 @@ struct serial8250_config {
 #define UART_CAP_SLEEP	(1 << 10)	/* UART has IER sleep */
 #define UART_CAP_AFE	(1 << 11)	/* MCR-based hw flow control */
 #define UART_CAP_UUE	(1 << 12)	/* UART needs IER bit 6 set (Xscale) */
+#define UART_CAP_NOMSR	(1 << 13)	/* UART has no modem status bits (Au1x00) */
 
 #define UART_BUG_QUOT	(1 << 0)	/* UART has buggy quot LSB */
 #define UART_BUG_TXEN	(1 << 1)	/* UART has buggy TX IIR status */
diff --git a/drivers/serial/8250_au1x00.c b/drivers/serial/8250_au1x00.c
new file mode 100644
--- /dev/null
+++ b/drivers/serial/8250_au1x00.c
@@ -0,0 +1,95 @@
+/*
+ * Serial Device Initialisation for Au1x00
+ *
+ * (C) Copyright Embedded Alley Solutions, Inc 2005
+ * Author: Pantelis Antoniou <pantelis@embeddedalley.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#include <linux/errno.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/ioport.h>
+#include <linux/module.h>
+#include <linux/serial_core.h>
+#include <linux/signal.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+
+#include <linux/serial_8250.h>
+
+#include <asm/mach-au1x00/au1000.h>
+
+#include "8250.h"
+
+#define PORT(_base, _irq)				\
+	{						\
+		.iobase		= _base,		\
+		.membase	= (void __iomem *)_base,\
+		.mapbase	= _base,		\
+		.irq		= _irq,			\
+		.uartclk	= 0,	/* filled */	\
+		.regshift	= 2,			\
+		.iotype		= UPIO_AU,		\
+		.flags		= UPF_SKIP_TEST | 	\
+				  UPF_IOREMAP,		\
+	}
+
+static struct plat_serial8250_port au1x00_data[] = {
+#if defined(CONFIG_SOC_AU1000)
+	PORT(UART0_ADDR, AU1000_UART0_INT),
+	PORT(UART1_ADDR, AU1000_UART1_INT),
+	PORT(UART2_ADDR, AU1000_UART2_INT),
+	PORT(UART3_ADDR, AU1000_UART3_INT),
+#elif defined(CONFIG_SOC_AU1500)
+	PORT(UART0_ADDR, AU1500_UART0_INT),
+	PORT(UART3_ADDR, AU1500_UART3_INT),
+#elif defined(CONFIG_SOC_AU1100)
+	PORT(UART0_ADDR, AU1100_UART0_INT),
+	PORT(UART1_ADDR, AU1100_UART1_INT),
+	PORT(UART2_ADDR, AU1100_UART2_INT),
+	PORT(UART3_ADDR, AU1100_UART3_INT),
+#elif defined(CONFIG_SOC_AU1550)
+	PORT(UART0_ADDR, AU1550_UART0_INT),
+	PORT(UART1_ADDR, AU1550_UART1_INT),
+	PORT(UART2_ADDR, AU1550_UART2_INT),
+	PORT(UART3_ADDR, AU1550_UART3_INT),
+#elif defined(CONFIG_SOC_AU1200)
+	PORT(UART0_ADDR, AU1200_UART0_INT),
+	PORT(UART1_ADDR, AU1200_UART1_INT),
+#endif
+	{ },
+};
+
+static struct platform_device au1x00_device = {
+	.name			= "serial8250",
+	.id			= PLAT8250_DEV_AU1X00,
+	.dev			= {
+		.platform_data	= au1x00_data,
+	},
+};
+
+static int __init au1x00_init(void)
+{
+	int i;
+	unsigned int uartclk;
+
+	/* get uart clock */
+	uartclk = get_au1x00_uart_baud_base() * 16;
+
+	/* fill up uartclk */
+	for (i = 0; au1x00_data[i].flags ; i++)
+		au1x00_data[i].uartclk = uartclk;
+
+	return platform_device_register(&au1x00_device);
+}
+
+module_init(au1x00_init);
+
+MODULE_AUTHOR("Pantelis Antoniou <pantelis@embeddedalley.com>");
+MODULE_DESCRIPTION("8250 serial probe module for Au1x000 cards");
+MODULE_LICENSE("GPL");
diff --git a/drivers/serial/Kconfig b/drivers/serial/Kconfig
--- a/drivers/serial/Kconfig
+++ b/drivers/serial/Kconfig
@@ -207,6 +207,14 @@ config SERIAL_8250_ACORN
 	  system, say Y to this option.  The driver can handle 1, 2, or 3 port
 	  cards.  If unsure, say N.
 
+config SERIAL_8250_AU1X00
+	tristate "AU1X00 serial port support"
+	depends on SOC_AU1X00 && SERIAL_8250
+	help
+	  If you have an Au1x00 board and want to use the serial port, say Y
+	  to this option.  The driver can handle 1 or 2 serial ports.
+	  If unsure, say N.
+
 comment "Non-8250 serial port support"
 
 config SERIAL_AMBA_PL010
diff --git a/drivers/serial/Makefile b/drivers/serial/Makefile
--- a/drivers/serial/Makefile
+++ b/drivers/serial/Makefile
@@ -22,6 +22,7 @@ obj-$(CONFIG_SERIAL_8250_ACCENT) += 8250
 obj-$(CONFIG_SERIAL_8250_BOCA) += 8250_boca.o
 obj-$(CONFIG_SERIAL_8250_HUB6) += 8250_hub6.o
 obj-$(CONFIG_SERIAL_8250_MCA) += 8250_mca.o
+obj-$(CONFIG_SERIAL_8250_AU1X00) += 8250_au1x00.o
 obj-$(CONFIG_SERIAL_AMBA_PL010) += amba-pl010.o
 obj-$(CONFIG_SERIAL_AMBA_PL011) += amba-pl011.o
 obj-$(CONFIG_SERIAL_CLPS711X) += clps711x.o
diff --git a/drivers/serial/serial_core.c b/drivers/serial/serial_core.c
--- a/drivers/serial/serial_core.c
+++ b/drivers/serial/serial_core.c
@@ -1960,6 +1960,7 @@ uart_report_port(struct uart_driver *drv
 		break;
 	case UPIO_MEM:
 	case UPIO_MEM32:
+	case UPIO_AU:
 		snprintf(address, sizeof(address),
 			 "MMIO 0x%lx", port->mapbase);
 		break;
diff --git a/include/linux/serial_8250.h b/include/linux/serial_8250.h
--- a/include/linux/serial_8250.h
+++ b/include/linux/serial_8250.h
@@ -42,6 +42,7 @@ enum {
 	PLAT8250_DEV_BOCA,
 	PLAT8250_DEV_HUB6,
 	PLAT8250_DEV_MCA,
+	PLAT8250_DEV_AU1X00,
 };
 
 /*
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -39,7 +39,8 @@
 #define PORT_RSA	13
 #define PORT_NS16550A	14
 #define PORT_XSCALE	15
-#define PORT_MAX_8250	15	/* max port ID */
+#define PORT_AU1X00	16
+#define PORT_MAX_8250	16	/* max port ID */
 
 /*
  * ARM specific type numbers.  These are not currently guaranteed
@@ -209,6 +210,7 @@ struct uart_port {
 #define UPIO_HUB6		(1)
 #define UPIO_MEM		(2)
 #define UPIO_MEM32		(3)
+#define UPIO_AU			(4)			/* Au1x00 type IO */
 
 	unsigned int		read_status_mask;	/* driver specific */
 	unsigned int		ignore_status_mask;	/* driver specific */

--Boundary-00=_qIyLDiKDjFcxUQc--
