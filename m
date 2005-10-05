Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030228AbVJEQkX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030228AbVJEQkX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 12:40:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030230AbVJEQkX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 12:40:23 -0400
Received: from amdext4.amd.com ([163.181.251.6]:18397 "EHLO amdext4.amd.com")
	by vger.kernel.org with ESMTP id S1030228AbVJEQkW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 12:40:22 -0400
X-Server-Uuid: 5FC0E2DF-CD44-48CD-883A-0ED95B391E89
Date: Wed, 5 Oct 2005 10:57:52 -0600
From: "Jordan Crouse" <jordan.crouse@amd.com>
To: linux-kernel@vger.kernel.org
cc: info-linux@ldcmail.amd.com
Subject: [PATCH 3/5] AMD Geode GX/LX support V2
Message-ID: <20051005165752.GC24950@cosmic.amd.com>
References: <20051005164626.GA25189@cosmic.amd.com>
MIME-Version: 1.0
In-Reply-To: <20051005164626.GA25189@cosmic.amd.com>
User-Agent: Mutt/1.5.11
X-WSS-ID: 6F5ADE7A07G1826653-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

No changes to this patch from the previous version, but included to
keep from confusing anybody.

The 5535 has a muxed serial port that can either be used to drive GPIO pins
or a second 16550 UART.  This code enables that UART via a command line
option.
This is most often used with a dongle attached to the VGA port to provide a
a serial port on boards with no dedicated serial goesouta. Please apply
against linux-2.6.13-rc2-mm2.

Index: linux-2.6.14-rc2-mm2/drivers/serial/Kconfig
===================================================================
--- linux-2.6.14-rc2-mm2.orig/drivers/serial/Kconfig
+++ linux-2.6.14-rc2-mm2/drivers/serial/Kconfig
@@ -608,6 +608,17 @@ config SERIAL_AU1X00_CONSOLE
 	  If you have an Alchemy AU1X00 processor (MIPS based) and you want
 	  to use a console on a serial port, say Y.  Otherwise, say N.
 
+config SERIAL_GEODE_UART2
+	bool "Enable AMD CS5535 UART2 as a serial port"
+	depends on MGEODE_LX
+	default y
+	select SERIAL_CORE
+	help
+	  Select this to allow the user to select the secondary CS5535 UART
+	  as a 16550 serial port instead of the default DDC interface. The
+	  UART2 can be selected by specifying geodeuart2 on the command
+	  line.
+
 config SERIAL_CORE
 	tristate
 
Index: linux-2.6.14-rc2-mm2/drivers/serial/Makefile
===================================================================
--- linux-2.6.14-rc2-mm2.orig/drivers/serial/Makefile
+++ linux-2.6.14-rc2-mm2/drivers/serial/Makefile
@@ -56,3 +56,4 @@ obj-$(CONFIG_SERIAL_JSM) += jsm/
 obj-$(CONFIG_SERIAL_TXX9) += serial_txx9.o
 obj-$(CONFIG_SERIAL_VR41XX) += vr41xx_siu.o
 obj-$(CONFIG_SERIAL_SGI_IOC4) += ioc4_serial.o
+obj-$(CONFIG_SERIAL_GEODE_UART2) += cs5535_uart.o
Index: linux-2.6.14-rc2-mm2/drivers/serial/cs5535_uart.c
===================================================================
--- /dev/null
+++ linux-2.6.14-rc2-mm2/drivers/serial/cs5535_uart.c
@@ -0,0 +1,83 @@
+/*
+ * Copyright (c) 2004-2005 Advanced Micro Devices, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *
+ * The full GNU General Public License is included in this distribution in the
+ * file called COPYING
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <asm/msr.h>
+#include <asm/io.h>
+
+/* The CS5535 companion chip has two UARTs.  This code enables the second
+   UART so other devices can use it.  We do it here so we can expose the
+   port early enough for serial debugging
+*/
+
+/* Note - this does not check to see if the CS5535 actually exists */
+
+#define LO(b)  (((1 << b) << 16) | 0x0000)
+#define HI(b)  ((0x0000 << 16) | (1 << b))
+
+static u32 outtab[16] __initdata =
+{
+	0x00,HI(4), 0x04,HI(4), 0x08,HI(4),
+	0x0c,LO(4), 0x10,HI(4), 0x14,LO(4),
+	0x18,LO(4), 0x1C,LO(4)
+};
+
+static u32 intab[16] __initdata = {
+	0x20,HI(3), 0x24,LO(3), 0x28,LO(3),
+	0x2C,LO(3), 0x34,HI(3), 0x38,LO(3),
+     0x40,LO(3), 0x44,LO(3)
+};
+
+static int __init init_cs5535_uart2(char *str)
+{
+	u32 lo = 0, hi = 0;
+	u32 base; u32 i;
+
+	/* Enable UART2 instead of DDC */
+
+	rdmsr(0x51400014, lo, hi);
+	lo &= 0xFF8FFFFF;
+	lo |= 0x00500000;   /* 0x2F8 ttyS1 */
+	wrmsr(0x51400014, lo, hi);
+
+	/* Set up the UART registers */
+	wrmsr(0x5140003E, 0x12, 0x00);
+
+	rdmsr(0x5140000C, lo, hi);
+	base = (u32)(lo & 0xFF00);
+
+	/* Enable the GPIO pins (in and out) */
+
+	for(i = 0; i < 16; i += 2) {
+		outl(outtab[i + 1], base + outtab[i]);
+		outl(intab[i + 1], base + intab[i]);
+	}
+
+	/* Enable the IRQ */
+
+	rdmsr(0x51400021,lo,hi);
+	lo &= 0x0FFFFFFF;
+	lo |= 0x30000000; /* IRQ 3 */
+	wrmsr(0x51400021,lo,hi);
+}
+
+__setup("geodeuart2", init_cs5535_uart2);

