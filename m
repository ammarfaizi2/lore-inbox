Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262191AbVBKOdt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262191AbVBKOdt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 09:33:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262236AbVBKOcv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 09:32:51 -0500
Received: from mo01.iij4u.or.jp ([210.130.0.20]:41199 "EHLO mo01.iij4u.or.jp")
	by vger.kernel.org with ESMTP id S262191AbVBKOcF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 09:32:05 -0500
Date: Fri, 11 Feb 2005 23:31:41 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: Andrew Morton <akpm@osdl.org>
Cc: yuasa@hh.iij4u.or.jp, linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6.11-rc3-mm2] serial: add the output interface control to
 VR41xx SIU driver
Message-Id: <20050211233141.5957828f.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the output interface control to VR41xx SIU driver.
And obsolete function for VR41xx SIU is removed.

Yoichi

Signed-off-by: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>

diff -urN -X dontdiff a-orig/arch/mips/vr41xx/casio-e55/setup.c a/arch/mips/vr41xx/casio-e55/setup.c
--- a-orig/arch/mips/vr41xx/casio-e55/setup.c	Thu Feb  3 10:55:35 2005
+++ a/arch/mips/vr41xx/casio-e55/setup.c	Fri Feb 11 01:22:01 2005
@@ -1,7 +1,7 @@
 /*
  *  setup.c, Setup for the CASIO CASSIOPEIA E-11/15/55/65.
  *
- *  Copyright (C) 2002-2004  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
+ *  Copyright (C) 2002-2005  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
@@ -17,7 +17,6 @@
  *  along with this program; if not, write to the Free Software
  *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
-#include <linux/config.h>
 #include <linux/ioport.h>
 
 #include <asm/io.h>
@@ -33,11 +32,6 @@
 	set_io_port_base(IO_PORT_BASE);
 	ioport_resource.start = IO_PORT_RESOURCE_START;
 	ioport_resource.end = IO_PORT_RESOURCE_END;
-
-#ifdef CONFIG_SERIAL_8250
-	vr41xx_select_siu_interface(SIU_RS232C, IRDA_NONE);
-	vr41xx_siu_init();
-#endif
 
 	return 0;
 }
diff -urN -X dontdiff a-orig/arch/mips/vr41xx/common/Makefile a/arch/mips/vr41xx/common/Makefile
--- a-orig/arch/mips/vr41xx/common/Makefile	Thu Feb 10 21:13:57 2005
+++ a/arch/mips/vr41xx/common/Makefile	Fri Feb 11 01:22:40 2005
@@ -3,7 +3,6 @@
 #
 
 obj-y				+= bcu.o cmu.o giu.o icu.o init.o int-handler.o ksyms.o pmu.o rtc.o
-obj-$(CONFIG_SERIAL_8250)	+= serial.o
 obj-$(CONFIG_VRC4173)		+= vrc4173.o
 
 EXTRA_AFLAGS := $(CFLAGS)
diff -urN -X dontdiff a-orig/arch/mips/vr41xx/common/serial.c a/arch/mips/vr41xx/common/serial.c
--- a-orig/arch/mips/vr41xx/common/serial.c	Thu Feb  3 10:55:39 2005
+++ a/arch/mips/vr41xx/common/serial.c	Thu Jan  1 09:00:00 1970
@@ -1,178 +0,0 @@
-/*
- *  serial.c, Serial Interface Unit routines for NEC VR4100 series.
- *
- *  Copyright (C) 2002  MontaVista Software Inc.
- *    Author: Yoichi Yuasa <yyuasa@mvista.com or source@mvista.com>
- *  Copyright (C) 2003-2004  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
- */
-/*
- * Changes:
- *  MontaVista Software Inc. <yyuasa@mvista.com> or <source@mvista.com>
- *  - New creation, NEC VR4122 and VR4131 are supported.
- *  - Added support for NEC VR4111 and VR4121.
- *
- *  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
- *  - Added support for NEC VR4133.
- */
-#include <linux/init.h>
-#include <linux/types.h>
-#include <linux/tty.h>
-#include <linux/serial.h>
-#include <linux/serial_core.h>
-#include <linux/smp.h>
-
-#include <asm/addrspace.h>
-#include <asm/cpu.h>
-#include <asm/io.h>
-#include <asm/vr41xx/vr41xx.h>
-
-#define SIUIRSEL_TYPE1		KSEG1ADDR(0x0c000008)
-#define SIUIRSEL_TYPE2		KSEG1ADDR(0x0f000808)
- #define USE_RS232C		0x00
- #define USE_IRDA		0x01
- #define SIU_USES_IRDA		0x00
- #define FIR_USES_IRDA		0x02
- #define IRDA_MODULE_SHARP	0x00
- #define IRDA_MODULE_TEMIC	0x04
- #define IRDA_MODULE_HP		0x08
- #define TMICTX			0x10
- #define TMICMODE		0x20
-
-#define SIU_BASE_TYPE1		0x0c000000UL	/* VR4111 and VR4121 */
-#define SIU_BASE_TYPE2		0x0f000800UL	/* VR4122, VR4131 and VR4133 */
-#define SIU_SIZE		0x8UL
-
-#define SIU_BASE_BAUD		1152000
-
-/* VR4122, VR4131 and VR4133 DSIU Registers */
-#define DSIU_BASE		0x0f000820UL
-#define DSIU_SIZE		0x8UL
-
-#define DSIU_BASE_BAUD		1152000
-
-int vr41xx_serial_ports = 0;
-
-void vr41xx_select_siu_interface(siu_interface_t interface,
-                                 irda_module_t module)
-{
-	uint16_t val = USE_RS232C;	/* Select RS-232C */
-
-	/* Select IrDA */
-	if (interface == SIU_IRDA) {
-		switch (module) {
-		case IRDA_SHARP:
-			val = IRDA_MODULE_SHARP;
-			break;
-		case IRDA_TEMIC:
-			val = IRDA_MODULE_TEMIC;
-			break;
-		case IRDA_HP:
-			val = IRDA_MODULE_HP;
-			break;
-		default:
-			printk(KERN_ERR "SIU: unknown IrDA module\n");
-			return;
-		}
-		val |= USE_IRDA | SIU_USES_IRDA;
-	}
-
-	switch (current_cpu_data.cputype) {
-	case CPU_VR4111:
-	case CPU_VR4121:
-		writew(val, SIUIRSEL_TYPE1);
-		break;
-	case CPU_VR4122:
-	case CPU_VR4131:
-	case CPU_VR4133:
-		writew(val, SIUIRSEL_TYPE2);
-		break;
-	default:
-		printk(KERN_ERR "SIU: unsupported CPU of NEC VR4100 series\n");
-		break;
-	}
-}
-
-void __init vr41xx_siu_init(void)
-{
-	struct uart_port port;
-
-	memset(&port, 0, sizeof(port));
-
-	port.line = vr41xx_serial_ports;
-	port.uartclk = SIU_BASE_BAUD * 16;
-	port.irq = SIU_IRQ;
-	port.flags = UPF_BOOT_AUTOCONF | UPF_SKIP_TEST;
-	switch (current_cpu_data.cputype) {
-	case CPU_VR4111:
-	case CPU_VR4121:
-		port.mapbase = SIU_BASE_TYPE1;
-		break;
-	case CPU_VR4122:
-	case CPU_VR4131:
-	case CPU_VR4133:
-		port.mapbase = SIU_BASE_TYPE2;
-		break;
-	default:
-		printk(KERN_ERR "SIU: unsupported CPU of NEC VR4100 series\n");
-		return;
-	}
-	port.regshift = 0;
-	port.iotype = UPIO_MEM;
-	port.membase = ioremap(port.mapbase, SIU_SIZE);
-	if (port.membase != NULL) {
-		if (early_serial_setup(&port) == 0) {
-			vr41xx_supply_clock(SIU_CLOCK);
-			vr41xx_serial_ports++;
-			return;
-		}
-	}
-
-	printk(KERN_ERR "SIU: setup failed!\n");
-}
-
-void __init vr41xx_dsiu_init(void)
-{
-	struct uart_port port;
-
-	if (current_cpu_data.cputype != CPU_VR4122 &&
-	    current_cpu_data.cputype != CPU_VR4131 &&
-	    current_cpu_data.cputype != CPU_VR4133) {
-		printk(KERN_ERR "DSIU: unsupported CPU of NEC VR4100 series\n");
-		return;
-	}
-
-	memset(&port, 0, sizeof(port));
-
-	port.line = vr41xx_serial_ports;
-	port.uartclk = DSIU_BASE_BAUD * 16;
-	port.irq = DSIU_IRQ;
-	port.flags = UPF_BOOT_AUTOCONF | UPF_SKIP_TEST;
-	port.mapbase = DSIU_BASE;
-	port.regshift = 0;
-	port.iotype = UPIO_MEM;
-	port.membase = ioremap(port.mapbase, DSIU_SIZE);
-	if (port.membase != NULL) {
-		if (early_serial_setup(&port) == 0) {
-			vr41xx_supply_clock(DSIU_CLOCK);
-			vr41xx_enable_dsiuint(DSIUINT_ALL);
-			vr41xx_serial_ports++;
-			return;
-		}
-	}
-
-	printk(KERN_ERR "DSIU: setup failed!\n");
-}
diff -urN -X dontdiff a-orig/arch/mips/vr41xx/ibm-workpad/setup.c a/arch/mips/vr41xx/ibm-workpad/setup.c
--- a-orig/arch/mips/vr41xx/ibm-workpad/setup.c	Thu Feb  3 10:57:05 2005
+++ a/arch/mips/vr41xx/ibm-workpad/setup.c	Fri Feb 11 01:22:02 2005
@@ -1,7 +1,7 @@
 /*
  *  setup.c, Setup for the IBM WorkPad z50.
  *
- *  Copyright (C) 2002-2004  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
+ *  Copyright (C) 2002-2005  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
@@ -17,7 +17,6 @@
  *  along with this program; if not, write to the Free Software
  *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
-#include <linux/config.h>
 #include <linux/ioport.h>
 
 #include <asm/io.h>
@@ -33,11 +32,6 @@
 	set_io_port_base(IO_PORT_BASE);
 	ioport_resource.start = IO_PORT_RESOURCE_START;
 	ioport_resource.end = IO_PORT_RESOURCE_END;
-
-#ifdef CONFIG_SERIAL_8250
-	vr41xx_select_siu_interface(SIU_RS232C, IRDA_NONE);
-	vr41xx_siu_init();
-#endif
 
 	return 0;
 }
diff -urN -X dontdiff a-orig/arch/mips/vr41xx/nec-cmbvr4133/setup.c a/arch/mips/vr41xx/nec-cmbvr4133/setup.c
--- a-orig/arch/mips/vr41xx/nec-cmbvr4133/setup.c	Thu Feb  3 10:57:04 2005
+++ a/arch/mips/vr41xx/nec-cmbvr4133/setup.c	Fri Feb 11 01:22:02 2005
@@ -16,7 +16,6 @@
  */
 #include <linux/config.h>
 #include <linux/init.h>
-#include <linux/console.h>
 #include <linux/ide.h>
 #include <linux/ioport.h>
 
@@ -55,15 +54,6 @@
 #define number_partitions (sizeof(cmbvr4133_mtd_parts)/sizeof(struct mtd_partition))
 #endif
 
-extern void (*late_time_init)(void);
-
-static void __init vr4133_serial_init(void)
-{
-	vr41xx_select_siu_interface(SIU_RS232C, IRDA_NONE);
-	vr41xx_siu_init();
-	vr41xx_dsiu_init();
-}
-
 extern void i8259_init(void);
 
 static int __init nec_cmbvr4133_setup(void)
@@ -77,8 +67,6 @@
 
 	mips_machgroup = MACH_GROUP_NEC_VR41XX;
 	mips_machtype = MACH_NEC_CMBVR4133;
-
-	late_time_init = vr4133_serial_init;
 
 #ifdef CONFIG_PCI
 #ifdef CONFIG_ROCKHOPPER
diff -urN -X dontdiff a-orig/arch/mips/vr41xx/tanbac-tb0226/setup.c a/arch/mips/vr41xx/tanbac-tb0226/setup.c
--- a-orig/arch/mips/vr41xx/tanbac-tb0226/setup.c	Thu Feb  3 10:55:23 2005
+++ a/arch/mips/vr41xx/tanbac-tb0226/setup.c	Fri Feb 11 01:22:02 2005
@@ -1,7 +1,7 @@
 /*
  *  setup.c, Setup for the TANBAC TB0226.
  *
- *  Copyright (C) 2002-2004  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
+ *  Copyright (C) 2002-2005  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
@@ -17,23 +17,8 @@
  *  along with this program; if not, write to the Free Software
  *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
-#include <linux/config.h>
-
-#include <asm/vr41xx/vr41xx.h>
 
 const char *get_system_type(void)
 {
 	return "TANBAC TB0226";
 }
-
-static int tanbac_tb0226_setup(void)
-{
-#ifdef CONFIG_SERIAL_8250
-	vr41xx_select_siu_interface(SIU_RS232C, IRDA_NONE);
-	vr41xx_siu_init();
-#endif
-
-	return 0;
-}
-
-early_initcall(tanbac_tb0226_setup);
diff -urN -X dontdiff a-orig/arch/mips/vr41xx/tanbac-tb0229/setup.c a/arch/mips/vr41xx/tanbac-tb0229/setup.c
--- a-orig/arch/mips/vr41xx/tanbac-tb0229/setup.c	Thu Feb  3 10:57:16 2005
+++ a/arch/mips/vr41xx/tanbac-tb0229/setup.c	Fri Feb 11 01:22:02 2005
@@ -1,7 +1,7 @@
 /*
  *  setup.c, Setup for the TANBAC TB0229 (VR4131DIMM)
  *
- *  Copyright (C) 2002-2004  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
+ *  Copyright (C) 2002-2005  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
  *
  *  Modified for TANBAC TB0229:
  *  Copyright (C) 2003  Megasolution Inc.  <matsu@megasolution.jp>
@@ -20,24 +20,8 @@
  *  along with this program; if not, write to the Free Software
  *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
-#include <linux/config.h>
-
-#include <asm/vr41xx/vr41xx.h>
 
 const char *get_system_type(void)
 {
 	return "TANBAC TB0229";
 }
-
-static int tanbac_tb0229_setup(void)
-{
-#ifdef CONFIG_SERIAL_8250
-	vr41xx_select_siu_interface(SIU_RS232C, IRDA_NONE);
-	vr41xx_siu_init();
-	vr41xx_dsiu_init();
-#endif
-
-	return 0;
-}
-
-early_initcall(tanbac_tb0229_setup);
diff -urN -X dontdiff a-orig/arch/mips/vr41xx/victor-mpc30x/setup.c a/arch/mips/vr41xx/victor-mpc30x/setup.c
--- a-orig/arch/mips/vr41xx/victor-mpc30x/setup.c	Thu Feb  3 10:56:22 2005
+++ a/arch/mips/vr41xx/victor-mpc30x/setup.c	Fri Feb 11 01:22:02 2005
@@ -1,7 +1,7 @@
 /*
  *  setup.c, Setup for the Victor MP-C303/304.
  *
- *  Copyright (C) 2002-2004  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
+ *  Copyright (C) 2002-2005  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
@@ -17,23 +17,8 @@
  *  along with this program; if not, write to the Free Software
  *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
-#include <linux/config.h>
-
-#include <asm/vr41xx/vr41xx.h>
 
 const char *get_system_type(void)
 {
 	return "Victor MP-C303/304";
 }
-
-static int victor_mpc30x_setup(void)
-{
-#ifdef CONFIG_SERIAL_8250
-	vr41xx_select_siu_interface(SIU_RS232C, IRDA_NONE);
-	vr41xx_siu_init();
-#endif
-
-	return 0;
-}
-
-early_initcall(victor_mpc30x_setup);
diff -urN -X dontdiff a-orig/arch/mips/vr41xx/zao-capcella/setup.c a/arch/mips/vr41xx/zao-capcella/setup.c
--- a-orig/arch/mips/vr41xx/zao-capcella/setup.c	Thu Feb  3 10:55:23 2005
+++ a/arch/mips/vr41xx/zao-capcella/setup.c	Fri Feb 11 01:22:02 2005
@@ -1,7 +1,7 @@
 /*
  *  setup.c, Setup for the ZAO Networks Capcella.
  *
- *  Copyright (C) 2002-2004  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
+ *  Copyright (C) 2002-2005  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
@@ -17,24 +17,8 @@
  *  along with this program; if not, write to the Free Software
  *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
-#include <linux/config.h>
-
-#include <asm/vr41xx/vr41xx.h>
 
 const char *get_system_type(void)
 {
 	return "ZAO Networks Capcella";
 }
-
-static int zao_capcella_setup(void)
-{
-#ifdef CONFIG_SERIAL_8250
-	vr41xx_select_siu_interface(SIU_RS232C, IRDA_NONE);
-	vr41xx_siu_init();
-	vr41xx_dsiu_init();
-#endif
-
-	return 0;
-}
-
-early_initcall(zao_capcella_setup);
diff -urN -X dontdiff a-orig/drivers/serial/vr41xx_siu.c a/drivers/serial/vr41xx_siu.c
--- a-orig/drivers/serial/vr41xx_siu.c	Thu Feb 10 21:16:01 2005
+++ a/drivers/serial/vr41xx_siu.c	Fri Feb 11 16:23:58 2005
@@ -32,7 +32,6 @@
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
-#include <linux/platform.h>
 #include <linux/serial.h>
 #include <linux/serial_core.h>
 #include <linux/serial_reg.h>
@@ -40,6 +39,7 @@
 #include <linux/tty_flip.h>
 
 #include <asm/io.h>
+#include <asm/vr41xx/siu.h>
 #include <asm/vr41xx/vr41xx.h>
 
 #define SIU_PORTS_MAX	2
@@ -50,21 +50,26 @@
 #define RX_MAX_COUNT	256
 #define TX_MAX_COUNT	15
 
+#define SIUIRSEL	0x08
+ #define TMICMODE	0x20
+ #define TMICTX		0x10
+ #define IRMSEL		0x0c
+ #define IRMSEL_HP	0x08
+ #define IRMSEL_TEMIC	0x04
+ #define IRMSEL_SHARP	0x00
+ #define IRUSESEL	0x02
+ #define SIRSEL		0x01
+
 struct siu_port {
 	unsigned int type;
 	unsigned int irq;
 	unsigned long start;
-	uint8_t flags;
 };
 
-#define SIU_HAS_IRDA_SUPPORT	0x01
-#define SIU_OUTPUT_IRDA		0x10
-
 static const struct siu_port siu_type1_ports[] = {
 	{	.type		= PORT_VR41XX_SIU,
 		.irq		= SIU_IRQ,
-		.start		= 0x0c000000UL,
-		.flags		= SIU_HAS_IRDA_SUPPORT,	},
+		.start		= 0x0c000000UL,		},
 };
 
 #define SIU_TYPE1_NR_PORTS	(sizeof(siu_type1_ports) / sizeof(struct siu_port))
@@ -72,8 +77,7 @@
 static const struct siu_port siu_type2_ports[] = {
 	{	.type		= PORT_VR41XX_SIU,
 		.irq		= SIU_IRQ,
-		.start		= 0x0f000800UL,
-		.flags		= SIU_HAS_IRDA_SUPPORT,	},
+		.start		= 0x0f000800UL,		},
 	{	.type		= PORT_VR41XX_DSIU,
 		.irq		= DSIU_IRQ,
 		.start		= 0x0f000820UL,		},
@@ -87,6 +91,84 @@
 #define siu_read(port, offset)		readb((port)->membase + (offset))
 #define siu_write(port, offset, value)	writeb((value), (port)->membase + (offset))
 
+void vr41xx_select_siu_interface(siu_interface_t interface)
+{
+	struct uart_port *port;
+	unsigned long flags;
+	uint8_t irsel;
+
+	port = &siu_uart_ports[0];
+
+	spin_lock_irqsave(&port->lock, flags);
+
+	irsel = siu_read(port, SIUIRSEL);
+	if (interface == SIU_INTERFACE_IRDA)
+		irsel |= SIRSEL;
+	else
+		irsel &= ~SIRSEL;
+	siu_write(port, SIUIRSEL, irsel);
+
+	spin_unlock_irqrestore(&port->lock, flags);
+}
+
+EXPORT_SYMBOL_GPL(vr41xx_select_siu_interface);
+
+void vr41xx_use_irda(irda_use_t use)
+{
+	struct uart_port *port;
+	unsigned long flags;
+	uint8_t irsel;
+
+	port = &siu_uart_ports[0];
+
+	spin_lock_irqsave(&port->lock, flags);
+
+	irsel = siu_read(port, SIUIRSEL);
+	if (use == FIR_USE_IRDA)
+		irsel |= IRUSESEL;
+	else
+		irsel &= ~IRUSESEL;
+	siu_write(port, SIUIRSEL, irsel);
+
+	spin_unlock_irqrestore(&port->lock, flags);
+}
+
+EXPORT_SYMBOL_GPL(vr41xx_use_irda);
+
+void vr41xx_select_irda_module(irda_module_t module, irda_speed_t speed)
+{
+	struct uart_port *port;
+	unsigned long flags;
+	uint8_t irsel;
+
+	port = &siu_uart_ports[0];
+
+	spin_lock_irqsave(&port->lock, flags);
+
+	irsel = siu_read(port, SIUIRSEL);
+	irsel &= ~(IRMSEL | TMICTX | TMICMODE);
+	switch (module) {
+	case SHARP_IRDA:
+		irsel |= IRMSEL_SHARP;
+		break;
+	case TEMIC_IRDA:
+		irsel |= IRMSEL_TEMIC | TMICMODE;
+		if (speed == IRDA_TX_4MBPS)
+			irsel |= TMICTX;
+		break;
+	case HP_IRDA:
+		irsel |= IRMSEL_HP;
+		break;
+	default:
+		break;
+	}
+	siu_write(port, SIUIRSEL, irsel);
+
+	spin_unlock_irqrestore(&port->lock, flags);
+}
+
+EXPORT_SYMBOL_GPL(vr41xx_select_irda_module);
+
 static inline void siu_clear_fifo(struct uart_port *port)
 {
 	siu_write(port, UART_FCR, UART_FCR_ENABLE_FIFO);
@@ -830,6 +912,8 @@
 		port->membase = (unsigned char __iomem *)KSEG1ADDR(port->mapbase);
 	}
 
+	vr41xx_select_siu_interface(SIU_INTERFACE_RS232C);
+
 	if (options != NULL)
 		uart_parse_options(options, &baud, &parity, &bits, &flow);
 
@@ -991,9 +1075,8 @@
 		return PTR_ERR(siu_platform_device);
 
 	retval = driver_register(&siu_device_driver);
-	if (retval < 0) {
+	if (retval < 0)
 		platform_device_unregister(siu_platform_device);
-	}
 
 	return retval;
 }
diff -urN -X dontdiff a-orig/include/asm-mips/vr41xx/siu.h a/include/asm-mips/vr41xx/siu.h
--- a-orig/include/asm-mips/vr41xx/siu.h	Thu Jan  1 09:00:00 1970
+++ a/include/asm-mips/vr41xx/siu.h	Fri Feb 11 01:22:02 2005
@@ -0,0 +1,50 @@
+/*
+ *  Include file for NEC VR4100 series Serial Interface Unit.
+ *
+ *  Copyright (C) 2005  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+#ifndef __NEC_VR41XX_SIU_H
+#define __NEC_VR41XX_SIU_H
+
+typedef enum {
+	SIU_INTERFACE_RS232C,
+	SIU_INTERFACE_IRDA,
+} siu_interface_t;
+
+extern void vr41xx_select_siu_interface(siu_interface_t interface);
+
+typedef enum {
+	SIU_USE_IRDA,
+	FIR_USE_IRDA,
+} irda_use_t;
+
+extern void vr41xx_use_irda(irda_use_t use);
+
+typedef enum {
+	SHARP_IRDA,
+	TEMIC_IRDA,
+	HP_IRDA,
+} irda_module_t;
+
+typedef enum {
+	IRDA_TX_1_5MBPS,
+	IRDA_TX_4MBPS,
+} irda_speed_t;
+
+extern void vr41xx_select_irda_module(irda_module_t module, irda_speed_t speed);
+
+#endif /* __NEC_VR41XX_SIU_H */
diff -urN -X dontdiff a-orig/include/asm-mips/vr41xx/vr41xx.h a/include/asm-mips/vr41xx/vr41xx.h
--- a-orig/include/asm-mips/vr41xx/vr41xx.h	Thu Feb 10 21:16:40 2005
+++ a/include/asm-mips/vr41xx/vr41xx.h	Fri Feb 11 01:22:02 2005
@@ -247,32 +247,6 @@
 };
 
 /*
- * Serial Interface Unit
- */
-
-/* SIU interfaces */
-typedef enum {
-	SIU_RS232C,
-	SIU_IRDA
-} siu_interface_t;
-
-/* IrDA interfaces */
-typedef enum {
-	IRDA_NONE,
-	IRDA_SHARP,
-	IRDA_TEMIC,
-	IRDA_HP
-} irda_module_t;
-
-extern void vr41xx_select_siu_interface(siu_interface_t interface,
-                                        irda_module_t module);
-
-/*
- * Debug Serial Interface Unit
- */
-extern void vr41xx_dsiu_init(void);
-
-/*
  * PCI Control Unit
  */
 #define PCI_MASTER_ADDRESS_MASK	0x7fffffffU


