Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262413AbUKDVXK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262413AbUKDVXK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 16:23:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262380AbUKDVXJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 16:23:09 -0500
Received: from adsl-67-117-73-34.dsl.sntc01.pacbell.net ([67.117.73.34]:57101
	"EHLO muru.com") by vger.kernel.org with ESMTP id S262413AbUKDVWl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 16:22:41 -0500
Date: Thu, 4 Nov 2004 13:22:38 -0800
From: Tony Lindgren <tony@atomide.com>
To: linux-kernel@vger.kernel.org
Cc: rmk+lkml@arm.linux.org.uk
Subject: Re: [PATCH] Serial updates
Message-ID: <20041104212237.GL5075@atomide.com>
References: <20041031175114.B17342@flint.arm.linux.org.uk> <1099368552.29693.434.camel@gaston> <1099369226.29689.441.camel@gaston> <20041102224329.B10969@flint.arm.linux.org.uk> <20041102150112.2ce4831f.akpm@osdl.org> <20041102231703.D10969@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="k1lZvvs/B4yU6o8G"
Content-Disposition: inline
In-Reply-To: <20041102231703.D10969@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--k1lZvvs/B4yU6o8G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Russell King <rmk+lkml@arm.linux.org.uk> [041102 15:27]:
> 
> Ok, I'll send a pull request imminently.  For those who don't want to
> wait, latest patch against Linus' tree is at:
> 
>   http://www.arm.linux.org.uk/~rmk/misc/linus-serial.diff

I tried the current BK tree on omap, and the serial ports work with
the following patch.

However, on omap 1510, the change of interrupt return value in
serial8250_interrupt from IRQ_HANDLED to IRQ_RETVAL(handled) causes
a problem on the first RX interrupt. It looks like the IIR register is
not ready for reading right away, and at first shows that no interrupt
happened (UART_IIR_NO_INT stays high).

This is probably a hardware issue, but might trigger something
similar on other hardware as well.

Regards,

Tony

--k1lZvvs/B4yU6o8G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="patch-2.6.10-rc1-current-omap-serial"

--- linus/drivers/serial/8250.c	2004-11-03 09:50:58.000000000 -0800
+++ linux-omap-dev/drivers/serial/8250.c	2004-11-04 13:14:22.000000000 -0800
@@ -1692,6 +1693,17 @@
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
@@ -1742,6 +1754,11 @@
 	unsigned int size = 8 << up->port.regshift;
 	int ret = 0;
 
+#ifdef CONFIG_ARCH_OMAP
+	if (is_omap_port(up->port.membase))
+		size = 0x16 << up->port.regshift;
+#endif
+
 	switch (up->port.iotype) {
 	case UPIO_MEM:
 		if (!up->port.mapbase)
--- linus/include/linux/serial_reg.h	2004-10-25 10:33:36.000000000 -0700
+++ linux-omap-dev/include/linux/serial_reg.h	2004-11-01 14:52:36.000000000 -0800
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
 

--k1lZvvs/B4yU6o8G--
