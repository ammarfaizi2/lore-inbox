Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422650AbWA0Wzg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422650AbWA0Wzg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 17:55:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422647AbWA0Wzf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 17:55:35 -0500
Received: from smtp3.pp.htv.fi ([213.243.153.36]:32720 "EHLO smtp3.pp.htv.fi")
	by vger.kernel.org with ESMTP id S1422661AbWA0WxW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 17:53:22 -0500
Date: Sat, 28 Jan 2006 00:53:19 +0200
From: Paul Mundt <lethal@linux-sh.org>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 8/11] sh: sh-sci clock framework updates.
Message-ID: <20060127225319.GI30816@linux-sh.org>
Mail-Followup-To: Paul Mundt <lethal@linux-sh.org>, akpm@osdl.org,
	linux-kernel@vger.kernel.org
References: <20060127224919.GA30816@linux-sh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060127224919.GA30816@linux-sh.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A couple of updates for the sh-sci serial driver:

	- Update for clock framework on sh.
	- Fix a compile error introduced by some h8300 changes.
	- Add SH7770/SH7780 subtype support.

Signed-off-by: Paul Mundt <lethal@linux-sh.org>

---

 drivers/serial/sh-sci.c |  225 +++++++++++++++++++++++++++++++++---------------
 drivers/serial/sh-sci.h |  114 ++++++++++++++----------
 2 files changed, 223 insertions(+), 116 deletions(-)

da11fe2659737503709e2159a596224b08e002b8
diff --git a/drivers/serial/sh-sci.c b/drivers/serial/sh-sci.c
index a9e0707..12f87d2 100644
--- a/drivers/serial/sh-sci.c
+++ b/drivers/serial/sh-sci.c
@@ -42,6 +42,7 @@
 #include <linux/delay.h>
 #include <linux/console.h>
 #include <linux/bitops.h>
+#include <linux/generic_serial.h>
 
 #ifdef CONFIG_CPU_FREQ
 #include <linux/notifier.h>
@@ -53,7 +54,9 @@
 #include <asm/irq.h>
 #include <asm/uaccess.h>
 
-#include <linux/generic_serial.h>
+#if defined(CONFIG_SUPERH) && !defined(CONFIG_SUPERH64)
+#include <asm/clock.h>
+#endif
 
 #ifdef CONFIG_SH_STANDARD_BIOS
 #include <asm/sh_bios.h>
@@ -86,9 +89,11 @@ static void sci_stop_rx(struct uart_port
 static int sci_request_irq(struct sci_port *port);
 static void sci_free_irq(struct sci_port *port);
 
-static struct sci_port sci_ports[SCI_NPORTS];
+static struct sci_port sci_ports[];
 static struct uart_driver sci_uart_driver;
 
+#define SCI_NPORTS sci_uart_driver.nr
+
 #if defined(CONFIG_SH_STANDARD_BIOS) || defined(CONFIG_SH_KGDB)
 
 static void handle_error(struct uart_port *port)
@@ -168,7 +173,7 @@ static void put_string(struct sci_port *
 	int usegdb=0;
 
 #ifdef CONFIG_SH_STANDARD_BIOS
-    	/* This call only does a trap the first time it is
+	/* This call only does a trap the first time it is
 	 * called, and so is safe to do here unconditionally
 	 */
 	usegdb |= sh_bios_in_gdb_mode();
@@ -324,47 +329,46 @@ static void sci_init_pins_sci(struct uar
 	/* tx mark output*/
 	H8300_SCI_DR(ch) |= h8300_sci_pins[ch].tx;
 }
-#else
-static void sci_init_pins_sci(struct uart_port *port, unsigned int cflag)
-{
-}
 #endif
 #endif
 
 #if defined(SCIF_ONLY) || defined(SCI_AND_SCIF)
-#if defined(CONFIG_CPU_SH3)
-/* For SH7705, SH7707, SH7709, SH7709A, SH7729, SH7300*/
+#if defined(CONFIG_CPU_SUBTYPE_SH7300)
+/* SH7300 doesn't use RTS/CTS */
+static void sci_init_pins_scif(struct uart_port *port, unsigned int cflag)
+{
+	sci_out(port, SCFCR, 0);
+}
+#elif defined(CONFIG_CPU_SH3)
+/* For SH7705, SH7707, SH7709, SH7709A, SH7729 */
 static void sci_init_pins_scif(struct uart_port *port, unsigned int cflag)
 {
 	unsigned int fcr_val = 0;
-#if !defined(CONFIG_CPU_SUBTYPE_SH7300) /* SH7300 doesn't use RTS/CTS */
-	{
-		unsigned short data;
+	unsigned short data;
+
+	/* We need to set SCPCR to enable RTS/CTS */
+	data = ctrl_inw(SCPCR);
+	/* Clear out SCP7MD1,0, SCP6MD1,0, SCP4MD1,0*/
+	ctrl_outw(data & 0x0fcf, SCPCR);
 
-		/* We need to set SCPCR to enable RTS/CTS */
-		data = ctrl_inw(SCPCR);
-		/* Clear out SCP7MD1,0, SCP6MD1,0, SCP4MD1,0*/
-		ctrl_outw(data&0x0fcf, SCPCR);
-	}
 	if (cflag & CRTSCTS)
 		fcr_val |= SCFCR_MCE;
 	else {
-		unsigned short data;
-
 		/* We need to set SCPCR to enable RTS/CTS */
 		data = ctrl_inw(SCPCR);
 		/* Clear out SCP7MD1,0, SCP4MD1,0,
 		   Set SCP6MD1,0 = {01} (output)  */
-		ctrl_outw((data&0x0fcf)|0x1000, SCPCR);
+		ctrl_outw((data & 0x0fcf) | 0x1000, SCPCR);
 
 		data = ctrl_inb(SCPDR);
 		/* Set /RTS2 (bit6) = 0 */
-		ctrl_outb(data&0xbf, SCPDR);
+		ctrl_outb(data & 0xbf, SCPDR);
 	}
-#endif
+
 	sci_out(port, SCFCR, fcr_val);
 }
 
+#if defined(CONFIG_CPU_SUBTYPE_SH7707) || defined(CONFIG_CPU_SUBTYPE_SH7709)
 static void sci_init_pins_irda(struct uart_port *port, unsigned int cflag)
 {
 	unsigned int fcr_val = 0;
@@ -374,7 +378,7 @@ static void sci_init_pins_irda(struct ua
 
 	sci_out(port, SCFCR, fcr_val);
 }
-
+#endif
 #else
 
 /* For SH7750 */
@@ -385,7 +389,11 @@ static void sci_init_pins_scif(struct ua
 	if (cflag & CRTSCTS) {
 		fcr_val |= SCFCR_MCE;
 	} else {
+#ifdef CONFIG_CPU_SUBTYPE_SH7780
+		ctrl_outw(0x0080, SCSPTR0); /* Set RTS = 1 */
+#else
 		ctrl_outw(0x0080, SCSPTR2); /* Set RTS = 1 */
+#endif
 	}
 	sci_out(port, SCFCR, fcr_val);
 }
@@ -422,7 +430,11 @@ static void sci_transmit_chars(struct ua
 
 #if !defined(SCI_ONLY)
 	if (port->type == PORT_SCIF) {
+#if defined(CONFIG_CPU_SUBTYPE_SH7760) || defined(CONFIG_CPU_SUBTYPE_SH7780)
+		txroom = SCIF_TXROOM_MAX - (sci_in(port, SCTFDR) & 0x7f);
+#else
 		txroom = SCIF_TXROOM_MAX - (sci_in(port, SCFDR)>>8);
+#endif
 	} else {
 		txroom = (sci_in(port, SCxSR) & SCI_TDRE)?1:0;
 	}
@@ -491,7 +503,11 @@ static inline void sci_receive_chars(str
 	while (1) {
 #if !defined(SCI_ONLY)
 		if (port->type == PORT_SCIF) {
+#if defined(CONFIG_CPU_SUBTYPE_SH7760) || defined(CONFIG_CPU_SUBTYPE_SH7780)
+			count = sci_in(port, SCRFDR) & 0x7f;
+#else
 			count = sci_in(port, SCFDR)&SCIF_RFDC_MASK ;
+#endif
 		} else {
 			count = (sci_in(port, SCxSR)&SCxSR_RDxF(port))?1:0;
 		}
@@ -652,7 +668,7 @@ static inline int sci_handle_breaks(stru
 	struct tty_struct *tty = port->info->tty;
 	struct sci_port *s = &sci_ports[port->line];
 
-	if (!s->break_flag && status & SCxSR_BRK(port))
+	if (!s->break_flag && status & SCxSR_BRK(port)) {
 #if defined(CONFIG_CPU_SH3)
 		/* Debounce break */
 		s->break_flag = 1;
@@ -783,6 +799,7 @@ static int sci_notifier(struct notifier_
 	    (phase == CPUFREQ_RESUMECHANGE)){
 		for (i = 0; i < SCI_NPORTS; i++) {
 			struct uart_port *port = &sci_ports[i].port;
+			struct clk *clk;
 
 			/*
 			 * Update the uartclk per-port if frequency has
@@ -795,7 +812,9 @@ static int sci_notifier(struct notifier_
 			 *
 			 * Clean this up later..
 			 */
-			port->uartclk = current_cpu_data.module_clock * 16;
+			clk = clk_get("module_clk");
+			port->uartclk = clk_get_rate(clk) * 16;
+			clk_put(clk);
 		}
 
 		printk("%s: got a postchange notification for cpu %d (old %d, new %d)\n",
@@ -1008,15 +1027,20 @@ static void sci_set_termios(struct uart_
 	sci_out(port, SCSMR, smr_val);
 
 	switch (baud) {
-		case 0:		t = -1;		break;
-		case 2400:	t = BPS_2400;	break;
-		case 4800:	t = BPS_4800;	break;
-		case 9600:	t = BPS_9600;	break;
-		case 19200:	t = BPS_19200;	break;
-		case 38400:	t = BPS_38400;	break;
-		case 57600:	t = BPS_57600;	break;
-		case 115200:	t = BPS_115200;	break;
-		default:	t = SCBRR_VALUE(baud); break;
+		case 0:
+			t = -1;
+			break;
+		default:
+		{
+#if defined(CONFIG_SUPERH) && !defined(CONFIG_SUPERH64)
+			struct clk *clk = clk_get("module_clk");
+			t = SCBRR_VALUE(baud, clk_get_rate(clk));
+			clk_put(clk);
+#else
+			t = SCBRR_VALUE(baud);
+#endif
+		}
+			break;
 	}
 
 	if (t > 0) {
@@ -1030,7 +1054,9 @@ static void sci_set_termios(struct uart_
 		udelay((1000000+(baud-1)) / baud); /* Wait one bit interval */
 	}
 
-	s->init_pins(port, termios->c_cflag);
+	if (likely(s->init_pins))
+		s->init_pins(port, termios->c_cflag);
+
 	sci_out(port, SCSCR, SCSCR_INIT(port));
 
 	if ((termios->c_cflag & CREAD) != 0)
@@ -1107,7 +1133,7 @@ static struct uart_ops sci_uart_ops = {
 	.verify_port	= sci_verify_port,
 };
 
-static struct sci_port sci_ports[SCI_NPORTS] = {
+static struct sci_port sci_ports[] = {
 #if defined(CONFIG_CPU_SUBTYPE_SH7708)
 	{
 		.port	= {
@@ -1121,7 +1147,6 @@ static struct sci_port sci_ports[SCI_NPO
 		},
 		.type		= PORT_SCI,
 		.irqs		= SCI_IRQS,
-		.init_pins	= sci_init_pins_sci,
 	},
 #elif defined(CONFIG_CPU_SUBTYPE_SH7705)
 	{
@@ -1165,7 +1190,6 @@ static struct sci_port sci_ports[SCI_NPO
 		},
 		.type		= PORT_SCI,
 		.irqs		= SCI_IRQS,
-		.init_pins	= sci_init_pins_sci,
 	},
 	{
 		.port	= {
@@ -1225,7 +1249,7 @@ static struct sci_port sci_ports[SCI_NPO
 		.irqs		= SH73180_SCIF_IRQS,
 		.init_pins	= sci_init_pins_scif,
 	},
-#elif defined(CONFIG_SH_RTS7751R2D)
+#elif defined(CONFIG_CPU_SUBTYPE_SH4_202)
 	{
 		.port	= {
 			.membase	= (void *)0xffe80000,
@@ -1253,7 +1277,6 @@ static struct sci_port sci_ports[SCI_NPO
 		},
 		.type		= PORT_SCI,
 		.irqs		= SCI_IRQS,
-		.init_pins	= sci_init_pins_sci,
 	},
 	{
 		.port	= {
@@ -1312,21 +1335,6 @@ static struct sci_port sci_ports[SCI_NPO
 		.irqs		= SH7760_SCIF2_IRQS,
 		.init_pins	= sci_init_pins_scif,
 	},
-#elif defined(CONFIG_CPU_SUBTYPE_SH4_202)
-	{
-		.port	= {
-			.membase	= (void *)0xffe80000,
-			.mapbase	= 0xffe80000,
-			.iotype		= SERIAL_IO_MEM,
-			.irq		= 43,
-			.ops		= &sci_uart_ops,
-			.flags		= ASYNC_BOOT_AUTOCONF,
-			.line		= 0,
-		},
-		.type		= PORT_SCIF,
-		.irqs		= SH4_SCIF_IRQS,
-		.init_pins	= sci_init_pins_scif,
-	},
 #elif defined(CONFIG_CPU_SUBTYPE_ST40STB1)
 	{
 		.port	= {
@@ -1455,6 +1463,78 @@ static struct sci_port sci_ports[SCI_NPO
 		.irqs		= H8S_SCI_IRQS2,
 		.init_pins	= sci_init_pins_sci,
 	},
+#elif defined(CONFIG_CPU_SUBTYPE_SH7770)
+	{
+		.port   = {
+			.membase	= (void *)0xff923000,
+			.mapbase	= 0xff923000,
+			.iotype		= SERIAL_IO_MEM,
+			.irq		= 61,
+			.ops		= &sci_uart_ops,
+			.flags		= ASYNC_BOOT_AUTOCONF,
+			.line		= 0,
+		},
+		.type		= PORT_SCIF,
+		.irqs		= SH7770_SCIF0_IRQS,
+		.init_pins	= sci_init_pins_scif,
+	},
+	{
+		.port   = {
+			.membase	= (void *)0xff924000,
+			.mapbase	= 0xff924000,
+			.iotype		= SERIAL_IO_MEM,
+			.irq		= 62,
+			.ops		= &sci_uart_ops,
+			.flags		= ASYNC_BOOT_AUTOCONF,
+			.line		= 1,
+		},
+		.type		= PORT_SCIF,
+		.irqs		= SH7770_SCIF1_IRQS,
+		.init_pins	= sci_init_pins_scif,
+	},
+	{
+		.port   = {
+			.membase	= (void *)0xff925000,
+			.mapbase	= 0xff925000,
+			.iotype		= SERIAL_IO_MEM,
+			.irq		= 63,
+			.ops		= &sci_uart_ops,
+			.flags		= ASYNC_BOOT_AUTOCONF,
+			.line		= 2,
+		},
+		.type		= PORT_SCIF,
+		.irqs		= SH7770_SCIF2_IRQS,
+		.init_pins	= sci_init_pins_scif,
+	},
+#elif defined(CONFIG_CPU_SUBTYPE_SH7780)
+	{
+		.port   = {
+			.membase	= (void *)0xffe00000,
+			.mapbase	= 0xffe00000,
+			.iotype		= SERIAL_IO_MEM,
+			.irq		= 43,
+			.ops		= &sci_uart_ops,
+			.flags		= ASYNC_BOOT_AUTOCONF,
+			.line		= 0,
+		},
+		.type		= PORT_SCIF,
+		.irqs		= SH7780_SCIF0_IRQS,
+		.init_pins	= sci_init_pins_scif,
+	},
+	{
+		.port   = {
+			.membase	= (void *)0xffe10000,
+			.mapbase	= 0xffe10000,
+			.iotype		= SERIAL_IO_MEM,
+			.irq		= 79,
+			.ops		= &sci_uart_ops,
+			.flags		= ASYNC_BOOT_AUTOCONF,
+			.line		= 1,
+		},
+		.type		= PORT_SCIF,
+		.irqs		= SH7780_SCIF1_IRQS,
+		.init_pins	= sci_init_pins_scif,
+	},
 #else
 #error "CPU subtype not defined"
 #endif
@@ -1480,9 +1560,6 @@ static int __init serial_console_setup(s
 	int flow = 'n';
 	int ret;
 
-	if (co->index >= SCI_NPORTS)
-		co->index = 0;
-
 	serial_console_port = &sci_ports[co->index];
 	port = &serial_console_port->port;
 	port->type = serial_console_port->type;
@@ -1496,14 +1573,21 @@ static int __init serial_console_setup(s
 	 * We need to set the initial uartclk here, since otherwise it will
 	 * only ever be setup at sci_init() time.
 	 */
-#if !defined(__H8300H__) && !defined(__H8300S__)
-	port->uartclk = current_cpu_data.module_clock * 16;
-#else
+#if defined(__H8300H__) || defined(__H8300S__)
 	port->uartclk = CONFIG_CPU_CLOCK;
-#endif
+
 #if defined(__H8300S__)
 	h8300_sci_enable(port, sci_enable);
 #endif
+#elif defined(CONFIG_SUPERH64)
+	port->uartclk = current_cpu_info.module_clock * 16;
+#else
+	{
+		struct clk *clk = clk_get("module_clk");
+		port->uartclk = clk_get_rate(clk) * 16;
+		clk_put(clk);
+	}
+#endif
 	if (options)
 		uart_parse_options(options, &baud, &parity, &bits, &flow);
 
@@ -1566,7 +1653,7 @@ int __init kgdb_console_setup(struct con
 	int parity = 'n';
 	int flow = 'n';
 
-	if (co->index >= SCI_NPORTS || co->index != kgdb_portnum)
+	if (co->index != kgdb_portnum)
 		co->index = kgdb_portnum;
 
 	if (options)
@@ -1606,7 +1693,7 @@ console_initcall(kgdb_console_init);
 #elif defined(CONFIG_SERIAL_SH_SCI_CONSOLE)
 #define SCI_CONSOLE	&serial_console
 #else
-#define SCI_CONSOLE 	0
+#define SCI_CONSOLE	0
 #endif
 
 static char banner[] __initdata =
@@ -1621,7 +1708,6 @@ static struct uart_driver sci_uart_drive
 	.dev_name	= "ttySC",
 	.major		= SCI_MAJOR,
 	.minor		= SCI_MINOR_START,
-	.nr		= SCI_NPORTS,
 	.cons		= SCI_CONSOLE,
 };
 
@@ -1631,15 +1717,21 @@ static int __init sci_init(void)
 
 	printk("%s", banner);
 
+	sci_uart_driver.nr = ARRAY_SIZE(sci_ports);
+
 	ret = uart_register_driver(&sci_uart_driver);
 	if (ret == 0) {
 		for (chan = 0; chan < SCI_NPORTS; chan++) {
 			struct sci_port *sciport = &sci_ports[chan];
 
-#if !defined(__H8300H__) && !defined(__H8300S__)
-			sciport->port.uartclk = (current_cpu_data.module_clock * 16);
-#else
+#if defined(__H8300H__) || defined(__H8300S__)
 			sciport->port.uartclk = CONFIG_CPU_CLOCK;
+#elif defined(CONFIG_SUPERH64)
+			sciport->port.uartclk = current_cpu_info.module_clock * 16;
+#else
+			struct clk *clk = clk_get("module_clk");
+			sciport->port.uartclk = clk_get_rate(clk) * 16;
+			clk_put(clk);
 #endif
 			uart_add_one_port(&sci_uart_driver, &sciport->port);
 			sciport->break_timer.data = (unsigned long)sciport;
diff --git a/drivers/serial/sh-sci.h b/drivers/serial/sh-sci.h
index 2892169..1f14bb4 100644
--- a/drivers/serial/sh-sci.h
+++ b/drivers/serial/sh-sci.h
@@ -46,14 +46,17 @@
 #define H8S_SCI_IRQS1 {92, 93, 94,   0 }
 #define H8S_SCI_IRQS2 {96, 97, 98,   0 }
 #define SH5_SCIF_IRQS {39, 40, 42,   0 }
+#define	SH7770_SCIF0_IRQS {61, 61, 61, 61 }
+#define	SH7770_SCIF1_IRQS {62, 62, 62, 62 }
+#define	SH7770_SCIF2_IRQS {63, 63, 63, 63 }
+#define	SH7780_SCIF0_IRQS {40, 41, 43, 42 }
+#define	SH7780_SCIF1_IRQS {76, 77, 79, 78 }
 
 #if defined(CONFIG_CPU_SUBTYPE_SH7708)
-# define SCI_NPORTS 1
 # define SCSPTR 0xffffff7c /* 8 bit */
 # define SCSCR_INIT(port)          0x30 /* TIE=0,RIE=0,TE=1,RE=1 */
 # define SCI_ONLY
 #elif defined(CONFIG_CPU_SUBTYPE_SH7707) || defined(CONFIG_CPU_SUBTYPE_SH7709)
-# define SCI_NPORTS 3
 # define SCPCR  0xA4000116 /* 16 bit SCI and SCIF */
 # define SCPDR  0xA4000136 /* 8  bit SCI and SCIF */
 # define SCSCR_INIT(port)          0x30 /* TIE=0,RIE=0,TE=1,RE=1 */
@@ -61,9 +64,8 @@
 #elif defined(CONFIG_CPU_SUBTYPE_SH7705)
 # define SCIF0		0xA4400000
 # define SCIF2		0xA4410000
-# define SCSMR_Ir 	0xA44A0000
-# define IRDA_SCIF 	SCIF0
-# define SCI_NPORTS 2
+# define SCSMR_Ir	0xA44A0000
+# define IRDA_SCIF	SCIF0
 # define SCPCR 0xA4000116
 # define SCPDR 0xA4000136
 
@@ -74,14 +76,11 @@
 # define SCSCR_INIT(port) (port->mapbase == SCIF2) ? 0xF3 : 0xF0
 # define SCIF_ONLY
 #elif defined(CONFIG_SH_RTS7751R2D)
-# define SCI_NPORTS 1
-# define SCSPTR1 0xffe0001c /* 8  bit SCI */
 # define SCSPTR2 0xFFE80020 /* 16 bit SCIF */
 # define SCIF_ORER 0x0001   /* overrun error bit */
 # define SCSCR_INIT(port) 0x3a /* TIE=0,RIE=0,TE=1,RE=1,REIE=1 */
 # define SCIF_ONLY
 #elif defined(CONFIG_CPU_SUBTYPE_SH7750) || defined(CONFIG_CPU_SUBTYPE_SH7751)
-# define SCI_NPORTS 2
 # define SCSPTR1 0xffe0001c /* 8  bit SCI */
 # define SCSPTR2 0xFFE80020 /* 16 bit SCIF */
 # define SCIF_ORER 0x0001   /* overrun error bit */
@@ -90,34 +89,29 @@
 	0x38 /* TIE=0,RIE=0,TE=1,RE=1,REIE=1 */ )
 # define SCI_AND_SCIF
 #elif defined(CONFIG_CPU_SUBTYPE_SH7760)
-# define SCI_NPORTS 3
-# define SCSPTR0 0xfe600000 /* 16 bit SCIF */
-# define SCSPTR1 0xfe610000 /* 16 bit SCIF */
-# define SCSPTR2 0xfe620000 /* 16 bit SCIF */
+# define SCSPTR0 0xfe600024 /* 16 bit SCIF */
+# define SCSPTR1 0xfe610024 /* 16 bit SCIF */
+# define SCSPTR2 0xfe620024 /* 16 bit SCIF */
 # define SCIF_ORER 0x0001  /* overrun error bit */
 # define SCSCR_INIT(port)          0x38 /* TIE=0,RIE=0,TE=1,RE=1,REIE=1 */
 # define SCIF_ONLY
 #elif defined(CONFIG_CPU_SUBTYPE_SH7300)
-# define SCI_NPORTS 1
 # define SCPCR  0xA4050116        /* 16 bit SCIF */
 # define SCPDR  0xA4050136        /* 16 bit SCIF */
 # define SCSCR_INIT(port)  0x0030 /* TIE=0,RIE=0,TE=1,RE=1 */
 # define SCIF_ONLY
 #elif defined(CONFIG_CPU_SUBTYPE_SH73180)
-# define SCI_NPORTS 1
 # define SCPDR  0xA4050138        /* 16 bit SCIF */
 # define SCSPTR2 SCPDR
 # define SCIF_ORER 0x0001   /* overrun error bit */
 # define SCSCR_INIT(port)  0x0038 /* TIE=0,RIE=0,TE=1,RE=1 */
 # define SCIF_ONLY
 #elif defined(CONFIG_CPU_SUBTYPE_SH4_202)
-# define SCI_NPORTS 1
 # define SCSPTR2 0xffe80020 /* 16 bit SCIF */
 # define SCIF_ORER 0x0001   /* overrun error bit */
 # define SCSCR_INIT(port) 0x38 /* TIE=0,RIE=0,TE=1,RE=1,REIE=1 */
 # define SCIF_ONLY
 #elif defined(CONFIG_CPU_SUBTYPE_ST40STB1)
-# define SCI_NPORTS 2
 # define SCSPTR1 0xffe00020 /* 16 bit SCIF */
 # define SCSPTR2 0xffe80020 /* 16 bit SCIF */
 # define SCIF_ORER 0x0001   /* overrun error bit */
@@ -129,26 +123,32 @@
 # define SCIF_ADDR_SH5     PHYS_PERIPHERAL_BLOCK+SCIF_BASE_ADDR
 # define SCIF_PTR2_OFFS    0x0000020
 # define SCIF_LSR2_OFFS    0x0000024
-# define SCI_NPORTS 1
-# define SCI_INIT { \
-  { {}, PORT_SCIF, 0, \
-     SH5_SCIF_IRQS, sci_init_pins_scif }  \
-}
 # define SCSPTR2           ((port->mapbase)+SCIF_PTR2_OFFS) /* 16 bit SCIF */
 # define SCLSR2            ((port->mapbase)+SCIF_LSR2_OFFS) /* 16 bit SCIF */
 # define SCSCR_INIT(port)  0x38                           /* TIE=0,RIE=0,
 							     TE=1,RE=1,REIE=1 */
 # define SCIF_ONLY
 #elif defined(CONFIG_H83007) || defined(CONFIG_H83068)
-# define SCI_NPORTS 3
 # define SCSCR_INIT(port)          0x30 /* TIE=0,RIE=0,TE=1,RE=1 */
 # define SCI_ONLY
 # define H8300_SCI_DR(ch) *(volatile char *)(P1DR + h8300_sci_pins[ch].port)
 #elif defined(CONFIG_H8S2678)
-# define SCI_NPORTS 3
 # define SCSCR_INIT(port)          0x30 /* TIE=0,RIE=0,TE=1,RE=1 */
 # define SCI_ONLY
 # define H8300_SCI_DR(ch) *(volatile char *)(P1DR + h8300_sci_pins[ch].port)
+#elif defined(CONFIG_CPU_SUBTYPE_SH7770)
+# define SCSPTR0 0xff923020 /* 16 bit SCIF */
+# define SCSPTR1 0xff924020 /* 16 bit SCIF */
+# define SCSPTR2 0xff925020 /* 16 bit SCIF */
+# define SCIF_ORER 0x0001  /* overrun error bit */
+# define SCSCR_INIT(port)	0x3c /* TIE=0,RIE=0,TE=1,RE=1,REIE=1,cke=2 */
+# define SCIF_ONLY
+#elif defined(CONFIG_CPU_SUBTYPE_SH7780)
+# define SCSPTR0	0xffe00024	/* 16 bit SCIF */
+# define SCSPTR1	0xffe10024	/* 16 bit SCIF */
+# define SCIF_OPER	0x0001		/* Overrun error bit */
+# define SCSCR_INIT(port)	0x3a	/* TIE=0,RIE=0,TE=1,RE=1,REIE=1 */
+# define SCIF_ONLY
 #else
 # error CPU subtype not defined
 #endif
@@ -158,7 +158,7 @@
 #define SCI_CTRL_FLAGS_RIE  0x40 /* all */
 #define SCI_CTRL_FLAGS_TE   0x20 /* all */
 #define SCI_CTRL_FLAGS_RE   0x10 /* all */
-#if defined(CONFIG_CPU_SUBTYPE_SH7750) || defined(CONFIG_CPU_SUBTYPE_SH7751)
+#if defined(CONFIG_CPU_SUBTYPE_SH7750) || defined(CONFIG_CPU_SUBTYPE_SH7751) || defined(CONFIG_CPU_SUBTYPE_SH7780)
 #define SCI_CTRL_FLAGS_REIE 0x08 /* 7750 SCIF */
 #else
 #define SCI_CTRL_FLAGS_REIE 0
@@ -213,7 +213,7 @@
 # define SCxSR_RDxF_CLEAR(port)		0xbc
 # define SCxSR_ERROR_CLEAR(port)	0xc4
 # define SCxSR_TDxE_CLEAR(port)		0x78
-# define SCxSR_BREAK_CLEAR(port)   	0xc4
+# define SCxSR_BREAK_CLEAR(port)	0xc4
 #elif defined(SCIF_ONLY)
 # define SCxSR_TEND(port)		SCIF_TEND
 # define SCxSR_ERRORS(port)		SCIF_ERRORS
@@ -237,7 +237,7 @@
 # define SCxSR_RDxF_CLEAR(port)		0x00fc
 # define SCxSR_ERROR_CLEAR(port)	0x0073
 # define SCxSR_TDxE_CLEAR(port)		0x00df
-# define SCxSR_BREAK_CLEAR(port)   	0x00e3
+# define SCxSR_BREAK_CLEAR(port)	0x00e3
 #endif
 #else
 # define SCxSR_TEND(port)	 (((port)->type == PORT_SCI) ? SCI_TEND   : SCIF_TEND)
@@ -285,14 +285,14 @@ struct sci_port {
 
 #define SCI_IN(size, offset)					\
   unsigned int addr = port->mapbase + (offset);			\
-  if ((size) == 8) { 						\
+  if ((size) == 8) {						\
     return ctrl_inb(addr);					\
-  } else {					 		\
+  } else {							\
     return ctrl_inw(addr);					\
   }
 #define SCI_OUT(size, offset, value)				\
   unsigned int addr = port->mapbase + (offset);			\
-  if ((size) == 8) { 						\
+  if ((size) == 8) {						\
     ctrl_outb(value, addr);					\
   } else {							\
     ctrl_outw(value, addr);					\
@@ -301,10 +301,10 @@ struct sci_port {
 #define CPU_SCIx_FNS(name, sci_offset, sci_size, scif_offset, scif_size)\
   static inline unsigned int sci_##name##_in(struct uart_port *port)	\
   {									\
-    if (port->type == PORT_SCI) { 					\
+    if (port->type == PORT_SCI) {					\
       SCI_IN(sci_size, sci_offset)					\
     } else {								\
-      SCI_IN(scif_size, scif_offset);		 			\
+      SCI_IN(scif_size, scif_offset);					\
     }									\
   }									\
   static inline void sci_##name##_out(struct uart_port *port, unsigned int value) \
@@ -319,7 +319,7 @@ struct sci_port {
 #define CPU_SCIF_FNS(name, scif_offset, scif_size)				\
   static inline unsigned int sci_##name##_in(struct uart_port *port)	\
   {									\
-    SCI_IN(scif_size, scif_offset);		 			\
+    SCI_IN(scif_size, scif_offset);					\
   }									\
   static inline void sci_##name##_out(struct uart_port *port, unsigned int value) \
   {									\
@@ -329,7 +329,7 @@ struct sci_port {
 #define CPU_SCI_FNS(name, sci_offset, sci_size)				\
   static inline unsigned int sci_##name##_in(struct uart_port* port)	\
   {									\
-    SCI_IN(sci_size, sci_offset);		 			\
+    SCI_IN(sci_size, sci_offset);					\
   }									\
   static inline void sci_##name##_out(struct uart_port* port, unsigned int value) \
   {									\
@@ -385,10 +385,17 @@ SCIx_FNS(SCxTDR, 0x06,  8, 0x0c,  8, 0x0
 SCIx_FNS(SCxSR,  0x08,  8, 0x10,  8, 0x08, 16, 0x10, 16, 0x04,  8)
 SCIx_FNS(SCxRDR, 0x0a,  8, 0x14,  8, 0x0A,  8, 0x14,  8, 0x05,  8)
 SCIF_FNS(SCFCR,                      0x0c,  8, 0x18, 16)
+#if defined(CONFIG_CPU_SUBTYPE_SH7760) || defined(CONFIG_CPU_SUBTYPE_SH7780)
+SCIF_FNS(SCTFDR,		     0x0e, 16, 0x1C, 16)
+SCIF_FNS(SCRFDR,		     0x0e, 16, 0x20, 16)
+SCIF_FNS(SCSPTR,			0,  0, 0x24, 16)
+SCIF_FNS(SCLSR,				0,  0, 0x28, 16)
+#else
 SCIF_FNS(SCFDR,                      0x0e, 16, 0x1C, 16)
 SCIF_FNS(SCSPTR,                        0,  0, 0x20, 16)
 SCIF_FNS(SCLSR,                         0,  0, 0x24, 16)
 #endif
+#endif
 #define sci_in(port, reg) sci_##reg##_in(port)
 #define sci_out(port, reg, value) sci_##reg##_out(port, value)
 
@@ -518,6 +525,24 @@ static inline int sci_rxd_in(struct uart
 	int ch = (port->mapbase - SMR0) >> 3;
 	return (H8300_SCI_DR(ch) & h8300_sci_pins[ch].rx) ? 1 : 0;
 }
+#elif defined(CONFIG_CPU_SUBTYPE_SH7770)
+static inline int sci_rxd_in(struct uart_port *port)
+{
+	if (port->mapbase == 0xff923000)
+		return ctrl_inw(SCSPTR0) & 0x0001 ? 1 : 0; /* SCIF */
+	if (port->mapbase == 0xff924000)
+		return ctrl_inw(SCSPTR1) & 0x0001 ? 1 : 0; /* SCIF */
+	if (port->mapbase == 0xff925000)
+		return ctrl_inw(SCSPTR2) & 0x0001 ? 1 : 0; /* SCIF */
+}
+#elif defined(CONFIG_CPU_SUBTYPE_SH7780)
+static inline int sci_rxd_in(struct uart_port *port)
+{
+	if (port->mapbase == 0xffe00000)
+		return ctrl_inw(SCSPTR0) & 0x0001 ? 1 : 0; /* SCIF */
+	if (port->mapbase == 0xffe10000)
+		return ctrl_inw(SCSPTR1) & 0x0001 ? 1 : 0; /* SCIF */
+}
 #endif
 
 /*
@@ -552,22 +577,15 @@ static inline int sci_rxd_in(struct uart
  * -- Mitch Davis - 15 Jul 2000
  */
 
-#define PCLK           (current_cpu_data.module_clock)
-
-#if defined(CONFIG_CPU_SUBTYPE_SH7300)
-#define SCBRR_VALUE(bps) ((PCLK+16*bps)/(16*bps)-1)
+#if defined(CONFIG_CPU_SUBTYPE_SH7300) || defined(CONFIG_CPU_SUBTYPE_SH7780)
+#define SCBRR_VALUE(bps, clk) ((clk+16*bps)/(16*bps)-1)
 #elif defined(CONFIG_CPU_SUBTYPE_SH7705)
-#define SCBRR_VALUE(bps) (((PCLK*2)+16*bps)/(32*bps)-1)
-#elif !defined(__H8300H__) && !defined(__H8300S__)
-#define SCBRR_VALUE(bps) ((PCLK+16*bps)/(32*bps)-1)
-#else
+#define SCBRR_VALUE(bps, clk) (((clk*2)+16*bps)/(32*bps)-1)
+#elif defined(__H8300H__) || defined(__H8300S__)
 #define SCBRR_VALUE(bps) (((CONFIG_CPU_CLOCK*1000/32)/bps)-1)
+#elif defined(CONFIG_SUPERH64)
+#define SCBRR_VALUE(bps) ((current_cpu_data.module_clock+16*bps)/(32*bps)-1)
+#else /* Generic SH */
+#define SCBRR_VALUE(bps, clk) ((clk+16*bps)/(32*bps)-1)
 #endif
-#define BPS_2400       SCBRR_VALUE(2400)
-#define BPS_4800       SCBRR_VALUE(4800)
-#define BPS_9600       SCBRR_VALUE(9600)
-#define BPS_19200      SCBRR_VALUE(19200)
-#define BPS_38400      SCBRR_VALUE(38400)
-#define BPS_57600      SCBRR_VALUE(57600)
-#define BPS_115200     SCBRR_VALUE(115200)
 
