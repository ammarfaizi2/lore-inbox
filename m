Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263083AbVCXKTX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263083AbVCXKTX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 05:19:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263089AbVCXKTX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 05:19:23 -0500
Received: from mail.renesas.com ([202.234.163.13]:24731 "EHLO
	mail03.idc.renesas.com") by vger.kernel.org with ESMTP
	id S263083AbVCXKOa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 05:14:30 -0500
Date: Thu, 24 Mar 2005 19:14:24 +0900 (JST)
Message-Id: <20050324.191424.233669632.takata.hirokazu@renesas.com>
To: rmk+lkml@arm.linux.org.uk
Cc: takata@linux-m32r.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Re: Bitrotting serial drivers
From: Hirokazu Takata <takata@linux-m32r.org>
In-Reply-To: <20050319172101.C23907@flint.arm.linux.org.uk>
References: <20050319172101.C23907@flint.arm.linux.org.uk>
X-Mailer: Mew version 3.3 on XEmacs 21.4.17 (Jumbo Shrimp)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 

I made a patch to update m32r_sio driver.

Compile checked and tested on a M32700UT eva board with SMP kernel.
It looks working...

Could you please accept the following patch?

Thanks,
-- Takata


From: Russell King <rmk+lkml@arm.linux.org.uk>
Date: Sat, 19 Mar 2005 17:21:01 +0000
> m32r_sio
> --------
> 
> Maintainer: Hirokazu Takata
> 
> Please clean up the m32r_sio driver, removing whatever bits of code
> aren't absolutely necessary.
> 
> Specifically, I'd like to see the following addressed:
> 
> - the usage of SERIAL_IO_HUB6
>   (this driver doesn't support hub6 cards)
> - SERIAL_IO_* should be UPIO_*
> - __register_m32r_sio, register_m32r_sio, unregister_m32r_sio,
>   m32r_sio_get_irq_map
>   (this driver doesn't support PCMCIA cards, all of which are based on
>    8250-compatible devices.)

  __register_m32r_sio, register_m32r_sio, unregister_m32r_sio are
  still remained.  I'm going to take a look them after.

> - early_serial_setup
>   (should we really have the function name duplicated across different
>    hardware drivers?)
> 

Signed-off-by: Hirokazu Takata <takata@linux-m32r.org>
---

 drivers/serial/m32r_sio.c     |  156 ++++++++--------------------------
 drivers/serial/m32r_sio.h     |    1 
 drivers/serial/m32r_sio_reg.h |  190 ------------------------------------------
 include/asm-m32r/serial.h     |  142 ++++---------------------------
 include/linux/serial_core.h   |    3 
 5 files changed, 59 insertions(+), 433 deletions(-)


diff -ruNp a/include/linux/serial_core.h b/include/linux/serial_core.h
--- a/include/linux/serial_core.h	2005-03-24 14:02:31.000000000 +0900
+++ b/include/linux/serial_core.h	2005-03-24 14:50:23.000000000 +0900
@@ -113,6 +113,9 @@
 /* Samsung S3C2400 SoC */
 #define PORT_S3C2400	67
 
+/* M32R SIO */
+#define PORT_M32R_SIO	68
+
 #ifdef __KERNEL__
 
 #include <linux/config.h>
diff -ruNp a/include/asm-m32r/serial.h b/include/asm-m32r/serial.h
--- a/include/asm-m32r/serial.h	2004-12-25 06:35:40.000000000 +0900
+++ b/include/asm-m32r/serial.h	2005-03-24 17:25:05.812651363 +0900
@@ -1,10 +1,6 @@
 #ifndef _ASM_M32R_SERIAL_H
 #define _ASM_M32R_SERIAL_H
 
-/* $Id$ */
-
-/* orig : i386 2.4.18 */
-
 /*
  * include/asm-m32r/serial.h
  */
@@ -21,131 +17,31 @@
  */
 #define BASE_BAUD ( 1843200 / 16 )
 
-/* Standard COM flags (except for COM4, because of the 8514 problem) */
-#ifdef CONFIG_SERIAL_DETECT_IRQ
-#define STD_COM_FLAGS (ASYNC_BOOT_AUTOCONF | ASYNC_SKIP_TEST | ASYNC_AUTO_IRQ)
-#define STD_COM4_FLAGS (ASYNC_BOOT_AUTOCONF | ASYNC_AUTO_IRQ)
-#else
+/* Standard COM flags */
 #define STD_COM_FLAGS (ASYNC_BOOT_AUTOCONF | ASYNC_SKIP_TEST)
-#define STD_COM4_FLAGS ASYNC_BOOT_AUTOCONF
-#endif
-
-#ifdef CONFIG_SERIAL_MANY_PORTS
-#define FOURPORT_FLAGS ASYNC_FOURPORT
-#define ACCENT_FLAGS 0
-#define BOCA_FLAGS 0
-#define HUB6_FLAGS 0
-#define RS_TABLE_SIZE	64
-#else
-#define RS_TABLE_SIZE
-#endif
-
-#define MCA_COM_FLAGS	(STD_COM_FLAGS|ASYNC_BOOT_ONLYMCA)
-
-/*
- * The following define the access methods for the HUB6 card. All
- * access is through two ports for all 24 possible chips. The card is
- * selected through the high 2 bits, the port on that card with the
- * "middle" 3 bits, and the register on that port with the bottom
- * 3 bits.
- *
- * While the access port and interrupt is configurable, the default
- * port locations are 0x302 for the port control register, and 0x303
- * for the data read/write register. Normally, the interrupt is at irq3
- * but can be anything from 3 to 7 inclusive. Note that using 3 will
- * require disabling com2.
- */
 
-#define C_P(card,port) (((card)<<6|(port)<<3) + 1)
+/* Standard PORT definitions */
+#if defined(CONFIG_PLAT_USRV)
 
-#define STD_SERIAL_PORT_DEFNS			\
-	/* UART CLK   PORT IRQ     FLAGS        */			\
-	{ 0, BASE_BAUD, 0x3F8, 4, STD_COM_FLAGS },	/* ttyS0 */	\
-	{ 0, BASE_BAUD, 0x2F8, 3, STD_COM_FLAGS },	/* ttyS1 */	\
-	{ 0, BASE_BAUD, 0x3E8, 4, STD_COM_FLAGS },	/* ttyS2 */	\
-	{ 0, BASE_BAUD, 0x2E8, 3, STD_COM4_FLAGS },	/* ttyS3 */
-
-
-#ifdef CONFIG_SERIAL_MANY_PORTS
-#define EXTRA_SERIAL_PORT_DEFNS			\
-	{ 0, BASE_BAUD, 0x1A0, 9, FOURPORT_FLAGS }, 	/* ttyS4 */	\
-	{ 0, BASE_BAUD, 0x1A8, 9, FOURPORT_FLAGS },	/* ttyS5 */	\
-	{ 0, BASE_BAUD, 0x1B0, 9, FOURPORT_FLAGS },	/* ttyS6 */	\
-	{ 0, BASE_BAUD, 0x1B8, 9, FOURPORT_FLAGS },	/* ttyS7 */	\
-	{ 0, BASE_BAUD, 0x2A0, 5, FOURPORT_FLAGS },	/* ttyS8 */	\
-	{ 0, BASE_BAUD, 0x2A8, 5, FOURPORT_FLAGS },	/* ttyS9 */	\
-	{ 0, BASE_BAUD, 0x2B0, 5, FOURPORT_FLAGS },	/* ttyS10 */	\
-	{ 0, BASE_BAUD, 0x2B8, 5, FOURPORT_FLAGS },	/* ttyS11 */	\
-	{ 0, BASE_BAUD, 0x330, 4, ACCENT_FLAGS },	/* ttyS12 */	\
-	{ 0, BASE_BAUD, 0x338, 4, ACCENT_FLAGS },	/* ttyS13 */	\
-	{ 0, BASE_BAUD, 0x000, 0, 0 },	/* ttyS14 (spare) */		\
-	{ 0, BASE_BAUD, 0x000, 0, 0 },	/* ttyS15 (spare) */		\
-	{ 0, BASE_BAUD, 0x100, 12, BOCA_FLAGS },	/* ttyS16 */	\
-	{ 0, BASE_BAUD, 0x108, 12, BOCA_FLAGS },	/* ttyS17 */	\
-	{ 0, BASE_BAUD, 0x110, 12, BOCA_FLAGS },	/* ttyS18 */	\
-	{ 0, BASE_BAUD, 0x118, 12, BOCA_FLAGS },	/* ttyS19 */	\
-	{ 0, BASE_BAUD, 0x120, 12, BOCA_FLAGS },	/* ttyS20 */	\
-	{ 0, BASE_BAUD, 0x128, 12, BOCA_FLAGS },	/* ttyS21 */	\
-	{ 0, BASE_BAUD, 0x130, 12, BOCA_FLAGS },	/* ttyS22 */	\
-	{ 0, BASE_BAUD, 0x138, 12, BOCA_FLAGS },	/* ttyS23 */	\
-	{ 0, BASE_BAUD, 0x140, 12, BOCA_FLAGS },	/* ttyS24 */	\
-	{ 0, BASE_BAUD, 0x148, 12, BOCA_FLAGS },	/* ttyS25 */	\
-	{ 0, BASE_BAUD, 0x150, 12, BOCA_FLAGS },	/* ttyS26 */	\
-	{ 0, BASE_BAUD, 0x158, 12, BOCA_FLAGS },	/* ttyS27 */	\
-	{ 0, BASE_BAUD, 0x160, 12, BOCA_FLAGS },	/* ttyS28 */	\
-	{ 0, BASE_BAUD, 0x168, 12, BOCA_FLAGS },	/* ttyS29 */	\
-	{ 0, BASE_BAUD, 0x170, 12, BOCA_FLAGS },	/* ttyS30 */	\
-	{ 0, BASE_BAUD, 0x178, 12, BOCA_FLAGS },	/* ttyS31 */
+#define STD_SERIAL_PORT_DEFNS						\
+       /* UART  CLK     PORT   IRQ            FLAGS */			\
+	{ 0, BASE_BAUD, 0x3F8, PLD_IRQ_UART0, STD_COM_FLAGS }, /* ttyS0 */ \
+	{ 0, BASE_BAUD, 0x2F8, PLD_IRQ_UART1, STD_COM_FLAGS }, /* ttyS1 */
+
+#else /* !CONFIG_PLAT_USRV */
+
+#if defined(CONFIG_SERIAL_M32R_PLDSIO)
+#define STD_SERIAL_PORT_DEFNS						\
+	{ 0, BASE_BAUD, ((unsigned long)PLD_ESIO0CR), PLD_IRQ_SIO0_RCV,	\
+	  STD_COM_FLAGS }, /* ttyS0 */
 #else
-#define EXTRA_SERIAL_PORT_DEFNS
+#define STD_SERIAL_PORT_DEFNS						\
+	{ 0, BASE_BAUD, M32R_SIO_OFFSET, M32R_IRQ_SIO0_R,		\
+	  STD_COM_FLAGS }, /* ttyS0 */
 #endif
 
-/* You can have up to four HUB6's in the system, but I've only
- * included two cards here for a total of twelve ports.
- */
-#if (defined(CONFIG_HUB6) && defined(CONFIG_SERIAL_MANY_PORTS))
-#define HUB6_SERIAL_PORT_DFNS		\
-	{ 0, BASE_BAUD, 0x302, 3, HUB6_FLAGS, C_P(0,0) },  /* ttyS32 */	\
-	{ 0, BASE_BAUD, 0x302, 3, HUB6_FLAGS, C_P(0,1) },  /* ttyS33 */	\
-	{ 0, BASE_BAUD, 0x302, 3, HUB6_FLAGS, C_P(0,2) },  /* ttyS34 */	\
-	{ 0, BASE_BAUD, 0x302, 3, HUB6_FLAGS, C_P(0,3) },  /* ttyS35 */	\
-	{ 0, BASE_BAUD, 0x302, 3, HUB6_FLAGS, C_P(0,4) },  /* ttyS36 */	\
-	{ 0, BASE_BAUD, 0x302, 3, HUB6_FLAGS, C_P(0,5) },  /* ttyS37 */	\
-	{ 0, BASE_BAUD, 0x302, 3, HUB6_FLAGS, C_P(1,0) },  /* ttyS38 */	\
-	{ 0, BASE_BAUD, 0x302, 3, HUB6_FLAGS, C_P(1,1) },  /* ttyS39 */	\
-	{ 0, BASE_BAUD, 0x302, 3, HUB6_FLAGS, C_P(1,2) },  /* ttyS40 */	\
-	{ 0, BASE_BAUD, 0x302, 3, HUB6_FLAGS, C_P(1,3) },  /* ttyS41 */	\
-	{ 0, BASE_BAUD, 0x302, 3, HUB6_FLAGS, C_P(1,4) },  /* ttyS42 */	\
-	{ 0, BASE_BAUD, 0x302, 3, HUB6_FLAGS, C_P(1,5) },  /* ttyS43 */
-#else
-#define HUB6_SERIAL_PORT_DFNS
-#endif
-
-#ifdef CONFIG_MCA
-#define MCA_SERIAL_PORT_DFNS			\
-	{ 0, BASE_BAUD, 0x3220, 3, MCA_COM_FLAGS },	\
-	{ 0, BASE_BAUD, 0x3228, 3, MCA_COM_FLAGS },	\
-	{ 0, BASE_BAUD, 0x4220, 3, MCA_COM_FLAGS },	\
-	{ 0, BASE_BAUD, 0x4228, 3, MCA_COM_FLAGS },	\
-	{ 0, BASE_BAUD, 0x5220, 3, MCA_COM_FLAGS },	\
-	{ 0, BASE_BAUD, 0x5228, 3, MCA_COM_FLAGS },
-#else
-#define MCA_SERIAL_PORT_DFNS
-#endif
+#endif /* !CONFIG_PLAT_USRV */
 
-#ifndef CONFIG_PLAT_USRV
-#define SERIAL_PORT_DFNS		\
-	STD_SERIAL_PORT_DEFNS		\
-	EXTRA_SERIAL_PORT_DEFNS		\
-	HUB6_SERIAL_PORT_DFNS		\
-	MCA_SERIAL_PORT_DFNS
-
-#else	/* CONFIG_PLAT_USRV */
-
-#define SERIAL_PORT_DFNS		\
-	/* UART CLK   PORT IRQ     FLAGS        */			\
-	{ 0, BASE_BAUD, 0x3F8, PLD_IRQ_UART0, STD_COM_FLAGS },	/* ttyS0 */	\
-	{ 0, BASE_BAUD, 0x2F8, PLD_IRQ_UART1, STD_COM_FLAGS },	/* ttyS1 */
-#endif	/* CONFIG_PLAT_USRV */
+#define SERIAL_PORT_DFNS	STD_SERIAL_PORT_DEFNS
 
 #endif  /* _ASM_M32R_SERIAL_H */
diff -ruNp a/drivers/serial/m32r_sio.c b/drivers/serial/m32r_sio.c
--- a/drivers/serial/m32r_sio.c	2005-03-24 13:40:18.000000000 +0900
+++ b/drivers/serial/m32r_sio.c	2005-03-24 17:37:23.362805402 +0900
@@ -26,6 +26,11 @@
  *  serial.c driver, and is currently the preferred form.
  */
 #include <linux/config.h>
+
+#if defined(CONFIG_SERIAL_M32R_SIO_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ)
+#define SUPPORT_SYSRQ
+#endif
+
 #include <linux/module.h>
 #include <linux/tty.h>
 #include <linux/ioport.h>
@@ -40,12 +45,8 @@
 #include <asm/io.h>
 #include <asm/irq.h>
 
-#if defined(CONFIG_SERIAL_M32R_SIO_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ)
-#define SUPPORT_SYSRQ
-#endif
-
-#define PORT_SIO	1
-#define PORT_MAX_SIO	1
+#define PORT_M32R_BASE	PORT_M32R_SIO
+#define PORT_INDEX(x)	(x - PORT_M32R_BASE + 1)
 #define BAUD_RATE	115200
 
 #include <linux/serial_core.h>
@@ -83,44 +84,20 @@ unsigned int share_irqs_sio = M32R_SIO_S
  */
 #define is_real_interrupt(irq)	((irq) != 0)
 
-/*
- * This converts from our new CONFIG_ symbols to the symbols
- * that asm/serial.h expects.  You _NEED_ to comment out the
- * linux/config.h include contained inside asm/serial.h for
- * this to work.
- */
-#undef CONFIG_SERIAL_MANY_PORTS
-#undef CONFIG_SERIAL_DETECT_IRQ
-#undef CONFIG_SERIAL_MULTIPORT
-#undef CONFIG_HUB6
-
-#ifdef CONFIG_SERIAL_M32R_SIO_DETECT_IRQ
-#define CONFIG_SERIAL_DETECT_IRQ 1
-#endif
-#ifdef CONFIG_SERIAL_M32R_SIO_MULTIPORT
-#define CONFIG_SERIAL_MULTIPORT 1
-#endif
-#ifdef CONFIG_SERIAL_M32R_SIO_MANY_PORTS
-#define CONFIG_SERIAL_MANY_PORTS 1
-#endif
+#include <asm/serial.h>
 
 /*
- * HUB6 is always on.  This will be removed once the header
- * files have been cleaned.
+ * SERIAL_PORT_DFNS tells us about built-in ports that have no
+ * standard enumeration mechanism.   Platforms that can find all
+ * serial ports via mechanisms like ACPI or PCI need not supply it.
  */
-#define CONFIG_HUB6 1
-
-#include <asm/serial.h>
+#ifndef SERIAL_PORT_DFNS
+#define SERIAL_PORT_DFNS
+#endif
 
-#ifdef CONFIG_SERIAL_M32R_PLDSIO
 static struct old_serial_port old_serial_port[] = {
-	{ 0, BASE_BAUD, ((unsigned long)PLD_ESIO0CR), PLD_IRQ_SIO0_RCV, STD_COM_FLAGS },
+	SERIAL_PORT_DFNS	/* defined in asm/serial.h */
 };
-#else
-static struct old_serial_port old_serial_port[] = {
-	{ 0, BASE_BAUD, M32R_SIO_OFFSET, M32R_IRQ_SIO0_R, STD_COM_FLAGS },
-};
-#endif
 
 #define UART_NR	ARRAY_SIZE(old_serial_port)
 
@@ -153,9 +130,17 @@ static struct irq_info irq_lists[NR_IRQS
 /*
  * Here we define the default xmit fifo size used for each type of UART.
  */
-static const struct serial_uart_config uart_config[PORT_MAX_SIO+1] = {
-	{ "unknown",	1,	0 },
-	{ "M32RSIO",	1,	0 }
+static const struct serial_uart_config uart_config[] = {
+	[PORT_UNKNOWN] = {
+		.name			= "unknown",
+		.dfl_xmit_fifo_size	= 1,
+		.flags			= 0,
+	},
+	[PORT_INDEX(PORT_M32R_SIO)] = {
+		.name			= "M32RSIO",
+		.dfl_xmit_fifo_size	= 1,
+		.flags			= 0,
+	},
 };
 
 #ifdef CONFIG_SERIAL_M32R_PLDSIO
@@ -460,7 +445,6 @@ static inline void m32r_sio_handle_port(
 
 	if (status & 0x04)
 		receive_chars(up, &status, regs);
-	// check_modem_status(up);
 	if (status & 0x01)
 		transmit_chars(up);
 }
@@ -842,13 +826,12 @@ m32r_sio_request_std_resource(struct uar
 	int ret = 0;
 
 	switch (up->port.iotype) {
-	case SERIAL_IO_MEM:
+	case UPIO_MEM:
 		if (up->port.mapbase) {
 #ifdef CONFIG_SERIAL_M32R_PLDSIO
 			*res = request_mem_region(up->port.mapbase, size, "serial");
 #else
 			start = up->port.mapbase;
-			start += UART_RSA_BASE << up->port.regshift;
 			*res = request_mem_region(start, size, "serial");
 #endif
 			if (!*res)
@@ -856,8 +839,7 @@ m32r_sio_request_std_resource(struct uar
 		}
 		break;
 
-	case SERIAL_IO_HUB6:
-	case SERIAL_IO_PORT:
+	case UPIO_PORT:
 		*res = request_region(up->port.iobase, size, "serial");
 		if (!*res)
 			ret = -EBUSY;
@@ -866,55 +848,15 @@ m32r_sio_request_std_resource(struct uar
 	return ret;
 }
 
-static int
-m32r_sio_request_rsa_resource(struct uart_sio_port *up, struct resource **res)
-{
-	unsigned int size = 8 << up->port.regshift;
-	unsigned long start;
-	int ret = 0;
-
-	switch (up->port.iotype) {
-	case SERIAL_IO_MEM:
-		if (up->port.mapbase) {
-			start = up->port.mapbase;
-			start += UART_RSA_BASE << up->port.regshift;
-#ifdef CONFIG_SERIAL_M32R_PLDSIO
-			*res = request_mem_region(start, size, "serial-rsa");
-#else
-			*res = request_mem_region(up->port.mapbase, size, "serial-rsa");
-#endif
-			if (!*res)
-				ret = -EBUSY;
-		}
-		break;
-
-	case SERIAL_IO_HUB6:
-	case SERIAL_IO_PORT:
-		start = up->port.iobase;
-		start += UART_RSA_BASE << up->port.regshift;
-		*res = request_region(up->port.iobase, size, "serial-rsa");
-		if (!*res)
-			ret = -EBUSY;
-		break;
-	}
-
-	return ret;
-}
-
 static void m32r_sio_release_port(struct uart_port *port)
 {
 	struct uart_sio_port *up = (struct uart_sio_port *)port;
 	unsigned long start, offset = 0, size = 0;
 
-	if (up->port.type == PORT_RSA) {
-		offset = UART_RSA_BASE << up->port.regshift;
-		size = 8;
-	}
-
 	size <<= up->port.regshift;
 
 	switch (up->port.iotype) {
-	case SERIAL_IO_MEM:
+	case UPIO_MEM:
 		if (up->port.mapbase) {
 			/*
 			 * Unmap the area.
@@ -930,8 +872,7 @@ static void m32r_sio_release_port(struct
 		}
 		break;
 
-	case SERIAL_IO_HUB6:
-	case SERIAL_IO_PORT:
+	case UPIO_PORT:
 		start = up->port.iobase;
 
 		if (size)
@@ -947,14 +888,9 @@ static void m32r_sio_release_port(struct
 static int m32r_sio_request_port(struct uart_port *port)
 {
 	struct uart_sio_port *up = (struct uart_sio_port *)port;
-	struct resource *res = NULL, *res_rsa = NULL;
+	struct resource *res = NULL;
 	int ret = 0;
 
-	if (up->port.type == PORT_RSA){
-		ret = m32r_sio_request_rsa_resource(up, &res_rsa);
-		if (ret < 0)
-			return ret;
-	}
 	ret = m32r_sio_request_std_resource(up, &res);
 
 	/*
@@ -969,11 +905,10 @@ static int m32r_sio_request_port(struct 
 	}
 
 	if (ret < 0) {
-		if (res_rsa)
-			release_resource(res_rsa);
 		if (res)
 			release_resource(res);
 	}
+
 	return ret;
 }
 
@@ -983,7 +918,7 @@ static void m32r_sio_config_port(struct 
 
 	spin_lock_irqsave(&up->port.lock, flags);
 
-	up->port.type = PORT_SIO;
+	up->port.type = (PORT_M32R_SIO - PORT_M32R_BASE + 1);
 	up->port.fifosize = uart_config[up->port.type].dfl_xmit_fifo_size;
 
 	spin_unlock_irqrestore(&up->port.lock, flags);
@@ -994,8 +929,7 @@ m32r_sio_verify_port(struct uart_port *p
 {
 	if (ser->irq >= NR_IRQS || ser->irq < 0 ||
 	    ser->baud_base < 9600 || ser->type < PORT_UNKNOWN ||
-	    ser->type > PORT_MAX_SIO || ser->type == PORT_CIRRUS ||
-	    ser->type == PORT_STARTECH)
+	    ser->type >= ARRAY_SIZE(uart_config))
 		return -EINVAL;
 	return 0;
 }
@@ -1048,7 +982,6 @@ static void __init m32r_sio_isa_init_por
 		up->port.irq      = irq_canonicalize(old_serial_port[i].irq);
 		up->port.uartclk  = old_serial_port[i].baud_base * 16;
 		up->port.flags    = old_serial_port[i].flags;
-		up->port.hub6     = old_serial_port[i].hub6;
 		up->port.membase  = old_serial_port[i].iomem_base;
 		up->port.iotype   = old_serial_port[i].io_type;
 		up->port.regshift = old_serial_port[i].iomem_reg_shift;
@@ -1255,7 +1188,7 @@ static int __register_m32r_sio(struct se
 }
 
 /**
- *	register_serial - configure a 16x50 serial port at runtime
+ *	register_m32r_sio - configure a 16x50 serial port at runtime
  *	@req: request structure
  *
  *	Configure the serial port specified by the request. If the
@@ -1272,7 +1205,7 @@ int register_m32r_sio(struct serial_stru
 	return __register_m32r_sio(req, -1);
 }
 
-int __init early_m32r_sio_setup(struct uart_port *port)
+int __init early_serial_setup(struct uart_port *port)
 {
 	m32r_sio_isa_init_ports();
  	m32r_sio_ports[port->line].port = *port;
@@ -1282,7 +1215,7 @@ int __init early_m32r_sio_setup(struct u
 }
 
 /**
- *	unregister_serial - remove a 16x50 serial port at runtime
+ *	unregister_m32r_sio - remove a 16x50 serial port at runtime
  *	@line: serial line number
  *
  *	Remove one serial port.  This may be called from interrupt
@@ -1293,20 +1226,6 @@ void unregister_m32r_sio(int line)
 	uart_unregister_port(&m32r_sio_reg, line);
 }
 
-/*
- * This is for ISAPNP only.
- */
-void m32r_sio_get_irq_map(unsigned int *map)
-{
-	int i;
-
-	for (i = 0; i < UART_NR; i++) {
-		if (m32r_sio_ports[i].port.type != PORT_UNKNOWN &&
-		    m32r_sio_ports[i].port.irq < 16)
-			*map |= 1 << m32r_sio_ports[i].port.irq;
-	}
-}
-
 /**
  *	m32r_sio_suspend_port - suspend one serial port
  *	@line: serial line number
@@ -1361,7 +1280,6 @@ module_exit(m32r_sio_exit);
 
 EXPORT_SYMBOL(register_m32r_sio);
 EXPORT_SYMBOL(unregister_m32r_sio);
-EXPORT_SYMBOL(m32r_sio_get_irq_map);
 EXPORT_SYMBOL(m32r_sio_suspend_port);
 EXPORT_SYMBOL(m32r_sio_resume_port);
 
diff -ruNp a/drivers/serial/m32r_sio.h b/drivers/serial/m32r_sio.h
--- a/drivers/serial/m32r_sio.h	2004-12-25 06:34:45.000000000 +0900
+++ b/drivers/serial/m32r_sio.h	2005-03-24 17:26:05.369897419 +0900
@@ -36,7 +36,6 @@ struct old_serial_port {
 	unsigned int port;
 	unsigned int irq;
 	unsigned int flags;
-	unsigned char hub6;
 	unsigned char io_type;
 	unsigned char *iomem_base;
 	unsigned short iomem_reg_shift;
diff -ruNp a/drivers/serial/m32r_sio_reg.h b/drivers/serial/m32r_sio_reg.h
--- a/drivers/serial/m32r_sio_reg.h	2004-12-25 06:34:30.000000000 +0900
+++ b/drivers/serial/m32r_sio_reg.h	2005-03-24 17:46:08.994486238 +0900
@@ -104,31 +104,6 @@
 #define UART_EMPTY	(UART_LSR_TEMT | UART_LSR_THRE)
 
 /*
- * These are the definitions for the FIFO Control Register
- * (16650 only)
- */
-#define UART_FCR_ENABLE_FIFO	0x01 /* Enable the FIFO */
-#define UART_FCR_CLEAR_RCVR	0x02 /* Clear the RCVR FIFO */
-#define UART_FCR_CLEAR_XMIT	0x04 /* Clear the XMIT FIFO */
-#define UART_FCR_DMA_SELECT	0x08 /* For DMA applications */
-#define UART_FCR_TRIGGER_MASK	0xC0 /* Mask for the FIFO trigger range */
-#define UART_FCR_TRIGGER_1	0x00 /* Mask for trigger set at 1 */
-#define UART_FCR_TRIGGER_4	0x40 /* Mask for trigger set at 4 */
-#define UART_FCR_TRIGGER_8	0x80 /* Mask for trigger set at 8 */
-#define UART_FCR_TRIGGER_14	0xC0 /* Mask for trigger set at 14 */
-/* 16650 redefinitions */
-#define UART_FCR6_R_TRIGGER_8	0x00 /* Mask for receive trigger set at 1 */
-#define UART_FCR6_R_TRIGGER_16	0x40 /* Mask for receive trigger set at 4 */
-#define UART_FCR6_R_TRIGGER_24  0x80 /* Mask for receive trigger set at 8 */
-#define UART_FCR6_R_TRIGGER_28	0xC0 /* Mask for receive trigger set at 14 */
-#define UART_FCR6_T_TRIGGER_16	0x00 /* Mask for transmit trigger set at 16 */
-#define UART_FCR6_T_TRIGGER_8	0x10 /* Mask for transmit trigger set at 8 */
-#define UART_FCR6_T_TRIGGER_24  0x20 /* Mask for transmit trigger set at 24 */
-#define UART_FCR6_T_TRIGGER_30	0x30 /* Mask for transmit trigger set at 30 */
-/* TI 16750 definitions */
-#define UART_FCR7_64BYTE	0x20 /* Go into 64 byte mode */
-
-/*
  * These are the definitions for the Line Control Register
  *
  * Note: if the word length is 5 bits (UART_LCR_WLEN5), then setting
@@ -174,170 +149,5 @@
 #define UART_IER_RLSI	0x08	/* Enable receiver line status interrupt */
 #define UART_IER_THRI	0x03	/* Enable Transmitter holding register int. */
 #define UART_IER_RDI	0x04	/* Enable receiver data interrupt */
-/*
- * Sleep mode for ST16650 and TI16750.
- * Note that for 16650, EFR-bit 4 must be selected as well.
- */
-#define UART_IERX_SLEEP  0x10	/* Enable sleep mode */
-
-/*
- * These are the definitions for the Modem Control Register
- */
-#define UART_MCR_LOOP	0x10	/* Enable loopback test mode */
-#define UART_MCR_OUT2	0x08	/* Out2 complement */
-#define UART_MCR_OUT1	0x04	/* Out1 complement */
-#define UART_MCR_RTS	0x02	/* RTS complement */
-#define UART_MCR_DTR	0x01	/* DTR complement */
-
-/*
- * These are the definitions for the Modem Status Register
- */
-#define UART_MSR_DCD	0x80	/* Data Carrier Detect */
-#define UART_MSR_RI	0x40	/* Ring Indicator */
-#define UART_MSR_DSR	0x20	/* Data Set Ready */
-#define UART_MSR_CTS	0x10	/* Clear to Send */
-#define UART_MSR_DDCD	0x08	/* Delta DCD */
-#define UART_MSR_TERI	0x04	/* Trailing edge ring indicator */
-#define UART_MSR_DDSR	0x02	/* Delta DSR */
-#define UART_MSR_DCTS	0x01	/* Delta CTS */
-#define UART_MSR_ANY_DELTA 0x0F	/* Any of the delta bits! */
-
-/*
- * These are the definitions for the Extended Features Register
- * (StarTech 16C660 only, when DLAB=1)
- */
-#define UART_EFR_CTS	0x80	/* CTS flow control */
-#define UART_EFR_RTS	0x40	/* RTS flow control */
-#define UART_EFR_SCD	0x20	/* Special character detect */
-#define UART_EFR_ECB	0x10	/* Enhanced control bit */
-/*
- * the low four bits control software flow control
- */
-
-/*
- * These register definitions are for the 16C950
- */
-#define UART_ASR	0x01	/* Additional Status Register */
-#define UART_RFL	0x03	/* Receiver FIFO level */
-#define UART_TFL 	0x04	/* Transmitter FIFO level */
-#define UART_ICR	0x05	/* Index Control Register */
-
-/* The 16950 ICR registers */
-#define UART_ACR	0x00	/* Additional Control Register */
-#define UART_CPR	0x01	/* Clock Prescalar Register */
-#define UART_TCR	0x02	/* Times Clock Register */
-#define UART_CKS	0x03	/* Clock Select Register */
-#define UART_TTL	0x04	/* Transmitter Interrupt Trigger Level */
-#define UART_RTL	0x05	/* Receiver Interrupt Trigger Level */
-#define UART_FCL	0x06	/* Flow Control Level Lower */
-#define UART_FCH	0x07	/* Flow Control Level Higher */
-#define UART_ID1	0x08	/* ID #1 */
-#define UART_ID2	0x09	/* ID #2 */
-#define UART_ID3	0x0A	/* ID #3 */
-#define UART_REV	0x0B	/* Revision */
-#define UART_CSR	0x0C	/* Channel Software Reset */
-#define UART_NMR	0x0D	/* Nine-bit Mode Register */
-#define UART_CTR	0xFF
-
-/*
- * The 16C950 Additional Control Reigster
- */
-#define UART_ACR_RXDIS	0x01	/* Receiver disable */
-#define UART_ACR_TXDIS	0x02	/* Receiver disable */
-#define UART_ACR_DSRFC	0x04	/* DSR Flow Control */
-#define UART_ACR_TLENB	0x20	/* 950 trigger levels enable */
-#define UART_ACR_ICRRD	0x40	/* ICR Read enable */
-#define UART_ACR_ASREN	0x80	/* Additional status enable */
-
-/*
- * These are the definitions for the Feature Control Register
- * (XR16C85x only, when LCR=bf; doubles with the Interrupt Enable
- * Register, UART register #1)
- */
-#define UART_FCTR_RTS_NODELAY	0x00  /* RTS flow control delay */
-#define UART_FCTR_RTS_4DELAY	0x01
-#define UART_FCTR_RTS_6DELAY	0x02
-#define UART_FCTR_RTS_8DELAY	0x03
-#define UART_FCTR_IRDA	0x04  /* IrDa data encode select */
-#define UART_FCTR_TX_INT	0x08  /* Tx interrupt type select */
-#define UART_FCTR_TRGA	0x00  /* Tx/Rx 550 trigger table select */
-#define UART_FCTR_TRGB	0x10  /* Tx/Rx 650 trigger table select */
-#define UART_FCTR_TRGC	0x20  /* Tx/Rx 654 trigger table select */
-#define UART_FCTR_TRGD	0x30  /* Tx/Rx 850 programmable trigger select */
-#define UART_FCTR_SCR_SWAP	0x40  /* Scratch pad register swap */
-#define UART_FCTR_RX	0x00  /* Programmable trigger mode select */
-#define UART_FCTR_TX	0x80  /* Programmable trigger mode select */
-
-/*
- * These are the definitions for the Enhanced Mode Select Register
- * (XR16C85x only, when LCR=bf and FCTR bit 6=1; doubles with the
- * Scratch register, UART register #7)
- */
-#define UART_EMSR_FIFO_COUNT	0x01  /* Rx/Tx select */
-#define UART_EMSR_ALT_COUNT	0x02  /* Alternating count select */
-
-/*
- * These are the definitions for the Programmable Trigger
- * Register (XR16C85x only, when LCR=bf; doubles with the UART RX/TX
- * register, UART register #0)
- */
-#define UART_TRG_1	0x01
-#define UART_TRG_4	0x04
-#define UART_TRG_8	0x08
-#define UART_TRG_16	0x10
-#define UART_TRG_32	0x20
-#define UART_TRG_64	0x40
-#define UART_TRG_96	0x60
-#define UART_TRG_120	0x78
-#define UART_TRG_128	0x80
-
-/*
- * These definitions are for the RSA-DV II/S card, from
- *
- * Kiyokazu SUTO <suto@ks-and-ks.ne.jp>
- */
-
-#define UART_RSA_BASE (-8)
-
-#define UART_RSA_MSR ((UART_RSA_BASE) + 0) /* I/O: Mode Select Register */
-
-#define UART_RSA_MSR_SWAP (1 << 0) /* Swap low/high 8 bytes in I/O port addr */
-#define UART_RSA_MSR_FIFO (1 << 2) /* Enable the external FIFO */
-#define UART_RSA_MSR_FLOW (1 << 3) /* Enable the auto RTS/CTS flow control */
-#define UART_RSA_MSR_ITYP (1 << 4) /* Level (1) / Edge triger (0) */
-
-#define UART_RSA_IER ((UART_RSA_BASE) + 1) /* I/O: Interrupt Enable Register */
-
-#define UART_RSA_IER_Rx_FIFO_H (1 << 0) /* Enable Rx FIFO half full int. */
-#define UART_RSA_IER_Tx_FIFO_H (1 << 1) /* Enable Tx FIFO half full int. */
-#define UART_RSA_IER_Tx_FIFO_E (1 << 2) /* Enable Tx FIFO empty int. */
-#define UART_RSA_IER_Rx_TOUT (1 << 3) /* Enable char receive timeout int */
-#define UART_RSA_IER_TIMER (1 << 4) /* Enable timer interrupt */
-
-#define UART_RSA_SRR ((UART_RSA_BASE) + 2) /* IN: Status Read Register */
-
-#define UART_RSA_SRR_Tx_FIFO_NEMP (1 << 0) /* Tx FIFO is not empty (1) */
-#define UART_RSA_SRR_Tx_FIFO_NHFL (1 << 1) /* Tx FIFO is not half full (1) */
-#define UART_RSA_SRR_Tx_FIFO_NFUL (1 << 2) /* Tx FIFO is not full (1) */
-#define UART_RSA_SRR_Rx_FIFO_NEMP (1 << 3) /* Rx FIFO is not empty (1) */
-#define UART_RSA_SRR_Rx_FIFO_NHFL (1 << 4) /* Rx FIFO is not half full (1) */
-#define UART_RSA_SRR_Rx_FIFO_NFUL (1 << 5) /* Rx FIFO is not full (1) */
-#define UART_RSA_SRR_Rx_TOUT (1 << 6) /* Character reception timeout occurred (1) */
-#define UART_RSA_SRR_TIMER (1 << 7) /* Timer interrupt occurred */
-
-#define UART_RSA_FRR ((UART_RSA_BASE) + 2) /* OUT: FIFO Reset Register */
-
-#define UART_RSA_TIVSR ((UART_RSA_BASE) + 3) /* I/O: Timer Interval Value Set Register */
-
-#define UART_RSA_TCR ((UART_RSA_BASE) + 4) /* OUT: Timer Control Register */
-
-#define UART_RSA_TCR_SWITCH (1 << 0) /* Timer on */
-
-/*
- * The RSA DSV/II board has two fixed clock frequencies.  One is the
- * standard rate, and the other is 8 times faster.
- */
-#define SERIAL_RSA_BAUD_BASE (921600)
-#define SERIAL_RSA_BAUD_BASE_LO (SERIAL_RSA_BAUD_BASE / 8)
 
 #endif /* _M32R_SIO_REG_H */

--
Hirokazu Takata <takata@linux-m32r.org>
Linux/M32R Project:  http://www.linux-m32r.org/
