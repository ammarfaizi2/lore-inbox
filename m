Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263606AbUJ3A6K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263606AbUJ3A6K (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 20:58:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263605AbUJ3Auj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 20:50:39 -0400
Received: from adsl-67-117-73-34.dsl.sntc01.pacbell.net ([67.117.73.34]:21769
	"EHLO muru.com") by vger.kernel.org with ESMTP id S263566AbUJ3Ash
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 20:48:37 -0400
Date: Fri, 29 Oct 2004 17:48:27 -0700
From: Tony Lindgren <tony@atomide.com>
To: linux-kernel@vger.kernel.org
Cc: rmk@arm.linux.org.uk, akpm@osdl.org
Subject: Re: [PATCH] Serial 8250 OMAP support, take 2
Message-ID: <20041030004826.GL3756@atomide.com>
References: <20041028191826.GG14884@atomide.com> <20041028203157.B11436@flint.arm.linux.org.uk> <20041028195445.GI14884@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="5p8PegU4iirBW1oA"
Content-Disposition: inline
In-Reply-To: <20041028195445.GI14884@atomide.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--5p8PegU4iirBW1oA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Tony Lindgren <tony@atomide.com> [041028 13:02]:
> * Russell King <rmk+lkml@arm.linux.org.uk> [041028 12:32]:
> > 
> > One of the things which previous changes have done is to move us away
> > from "port types" towards "capabilities" for serial ports, so things
> > like the FIFO, hardware flow control and so forth can be individually
> > controlled, rather than having to rely on a table of features.
> > 
> > So, it appears that OMAP ports are like a TI752 port, but with a couple
> > of extra features.  Can we use the existing TI75x feature support code
> > for these ports?
> 
> Well last time I checked at least the autoconfig failed. I can look into it
> a bit more.

OK, got it working by resetting the ports before calling
early_serial_setup(). The ports are now properly autodetected as PORT_16654,
and seem to be working :) The new patch is quite minimal, see below!

Hmm, I wonder if there would be some advantage if the ports were detected as
TI16750?

The omap specific reset function is basically:

omap_serial_outp(up, UART_OMAP_MDR1, 0x07); /* disable UART */
omap_serial_outp(up, UART_OMAP_MDR1, 0x00); /* enable UART */

Macro is_omap_port() is defined in the omap serial.h to check the port
address. Moving that to somewhere else would allow removing one ifdef.

The macro cpu_is_omap1510() is omap specific, so one ifdef is still needed.

> > Also, these ports seem to use extra address space which isn't covered by
> > a request_region/request_mem_region... that's something which should be
> > fixed.
> 
> OK, I'll change that.

This is fixed now too.

Tony

--5p8PegU4iirBW1oA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="patch-2.6.10-rc1-serial-8250-add-omap-take3"

--- linus/drivers/serial/8250.c	2004-10-26 10:41:48.000000000 -0700
+++ linux-omap-dev/drivers/serial/8250.c	2004-10-29 17:22:00.000000000 -0700
@@ -1689,6 +1689,17 @@
 		serial_outp(up, UART_EFR, efr);
 	}
 
+#ifdef CONFIG_ARCH_OMAP1510
+	/* Workaround to enable 115200 baud on OMAP1510 internal ports */
+	if (cpu_is_omap1510() && is_omap_port(up->port.membase)) {
+		if (baud == 115200) {
+			quot = 1;
+			serial_out(up, UART_OMAP_OSC_12M_SEL, 1);
+		} else
+			serial_out(up, UART_OMAP_OSC_12M_SEL, 0);
+        }
+#endif
+
 	if (up->capabilities & UART_NATSEMI) {
 		/* Switch to bank 2 not bank 1, to avoid resetting EXCR2 */
 		serial_outp(up, UART_LCR, 0xe0);
@@ -1742,6 +1753,11 @@
 	unsigned int size = 8 << up->port.regshift;
 	int ret = 0;
 
+#ifdef CONFIG_ARCH_OMAP
+	if (is_omap_port(up->port.membase))
+		size = 0x16 << up->port.regshift;
+#endif
+
 	switch (up->port.iotype) {
 	case UPIO_MEM:
 		if (up->port.mapbase) {
--- linus/include/linux/serial_reg.h	2004-10-25 10:33:36.000000000 -0700
+++ linux-omap-dev/include/linux/serial_reg.h	2004-10-29 14:13:01.000000000 -0700
@@ -307,5 +307,19 @@
 #define SERIAL_RSA_BAUD_BASE (921600)
 #define SERIAL_RSA_BAUD_BASE_LO (SERIAL_RSA_BAUD_BASE / 8)
 
+/*
+ * Extra serial register definitions for the internal UARTs 
+ * in TI OMAP processors.
+ */
+#define UART_OMAP_MDR1		0x08	/* Mode definition register */
+#define UART_OMAP_MDR2		0x09	/* Mode definition register 2 */
+#define UART_OMAP_SCR		0x10	/* Supplementary control register */
+#define UART_OMAP_SSR		0x11	/* Supplementary status register */
+#define UART_OMAP_EBLR		0x12	/* BOF length register */
+#define UART_OMAP_OSC_12M_SEL	0x13	/* OMAP1510 12MHz osc select */
+#define UART_OMAP_MVER		0x14	/* Module version register */
+#define UART_OMAP_SYSC		0x15	/* System configuration register */
+#define UART_OMAP_SYSS		0x16	/* System status register */
+
 #endif /* _LINUX_SERIAL_REG_H */
 

--5p8PegU4iirBW1oA--
