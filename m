Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261755AbUJ1TSl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261755AbUJ1TSl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 15:18:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261761AbUJ1TSl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 15:18:41 -0400
Received: from adsl-67-117-73-34.dsl.sntc01.pacbell.net ([67.117.73.34]:11538
	"EHLO muru.com") by vger.kernel.org with ESMTP id S261755AbUJ1TSd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 15:18:33 -0400
Date: Thu, 28 Oct 2004 12:18:27 -0700
From: Tony Lindgren <tony@atomide.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, rmk@arm.linux.org.uk
Subject: [PATCH] Serial 8250 OMAP support, take 2
Message-ID: <20041028191826.GG14884@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="tNQTSEo8WG/FKZ8E"
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--tNQTSEo8WG/FKZ8E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Andrew & Russell,

Here's an updated version of an earlier patch [1] to add OMAP support to
the serial 8250 driver.

The new patch has been updated to use early_serial_setup() instead of
register_serial(). This leaves out the earlier additional patch needed 
to serial_core.c [2], which caused a problem on PCI modems [3].

[1] http://lkml.org/lkml/2004/8/16/119
[2] http://lkml.org/lkml/2004/8/16/114
[3] http://bugme.osdl.org/show_bug.cgi?id=3312

Signed-off-by: Tony Lindgren <tony@atomide.com>

Regards,

Tony

--tNQTSEo8WG/FKZ8E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="patch-2.6.10-rc1-serial-8250-add-omap"

--- linus/drivers/serial/8250.c	2004-10-26 10:41:48.000000000 -0700
+++ linux-omap-dev/drivers/serial/8250.c	2004-10-28 11:46:53.000000000 -0700
@@ -260,6 +260,15 @@
 		.fcr		= UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_10,
 		.flags		= UART_CAP_FIFO,
 	},
+	[PORT_OMAP] = {
+		.name		= "OMAP",
+		.fifo_size	= 64,
+		.tx_loadsz	= 64,
+		.fcr		= UART_FCR_ENABLE_FIFO |
+				  UART_FCR7_T_TRIGGER_56 |
+				  UART_FCR7_R_TRIGGER_60,
+		.flags		= UART_CAP_FIFO,
+	},
 };
 
 static _INLINE_ unsigned int serial_in(struct uart_8250_port *up, int offset)
@@ -1370,6 +1379,28 @@
 		serial_outp(up, UART_LCR, 0);
 	}
 
+#ifdef CONFIG_ARCH_OMAP
+	if (up->port.type == PORT_OMAP) {
+                serial_outp(up, UART_OMAP_MDR1, 0x07); /* disable UART */
+                serial_outp(up, UART_LCR, 0xBF);       /* select EFR */
+                serial_outp(up, UART_EFR, UART_EFR_ECB);
+                serial_outp(up, UART_LCR, UART_LCR_DLAB); /* set DLAB */
+                serial_outp(up, UART_DLL, 0x00);
+                serial_outp(up, UART_DLM, 0x00);
+                serial_outp(up, UART_LCR, 0x00);       /* reset DLAB */
+                serial_outp(up, UART_OMAP_SCR, 0x08);
+                serial_outp(up, UART_FCR, 0x00);
+                serial_outp(up, UART_MCR, 0x40);       /* enable TCR/TLR */
+                serial_outp(up, UART_TI752_TCR, 0x0F);
+                serial_outp(up, UART_TI752_TLR, 0x00);
+                serial_outp(up, UART_MCR, 0x00);
+                serial_outp(up, UART_LCR, 0xBF);       /* select EFR */
+                serial_outp(up, UART_EFR, 0x00);
+                serial_outp(up, UART_LCR, 0x00);       /* reset DLAB */
+                serial_outp(up, UART_OMAP_MDR1, 0x00); /* enable UART */
+        }
+#endif
+
 #ifdef CONFIG_SERIAL_8250_RSA
 	/*
 	 * If this is an RSA port, see if we can kick it up to the
@@ -1689,6 +1720,17 @@
 		serial_outp(up, UART_EFR, efr);
 	}
 
+#ifdef CONFIG_ARCH_OMAP1510
+	/* Workaround is needed to enable 115200 baud on OMAP1510 */
+        if (up->port.type == PORT_OMAP && cpu_is_omap1510()) {
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
--- linus/include/linux/serial_core.h	2004-10-25 10:33:36.000000000 -0700
+++ linux-omap-dev/include/linux/serial_core.h	2004-10-18 09:20:25.000000000 -0700
@@ -37,7 +37,8 @@
 #define PORT_RSA	13
 #define PORT_NS16550A	14
 #define PORT_XSCALE	15
-#define PORT_MAX_8250	15	/* max port ID */
+#define PORT_OMAP	16
+#define PORT_MAX_8250	16	/* max port ID */
 
 /*
  * ARM specific type numbers.  These are not currently guaranteed
--- linus/include/linux/serial_reg.h	2004-10-25 10:33:36.000000000 -0700
+++ linux-omap-dev/include/linux/serial_reg.h	2004-10-28 11:50:15.000000000 -0700
@@ -79,6 +79,15 @@
 #define UART_FCR6_T_TRIGGER_8	0x10 /* Mask for transmit trigger set at 8 */
 #define UART_FCR6_T_TRIGGER_24  0x20 /* Mask for transmit trigger set at 24 */
 #define UART_FCR6_T_TRIGGER_30	0x30 /* Mask for transmit trigger set at 30 */
+/* 16C752 definitions */
+#define UART_FCR7_R_TRIGGER_8	0x00 /* Mask for receive trigger set at 8 */
+#define UART_FCR7_R_TRIGGER_16	0x40 /* Mask for receive trigger set at 16 */
+#define UART_FCR7_R_TRIGGER_56	0x80 /* Mask for receive trigger set at 56 */
+#define UART_FCR7_R_TRIGGER_60	0xC0 /* Mask for receive trigger set at 60 */
+#define UART_FCR7_T_TRIGGER_8	0x00 /* Mask for transmit trigger set at 8 */
+#define UART_FCR7_T_TRIGGER_16	0x10 /* Mask for transmit trigger set at 16 */
+#define UART_FCR7_T_TRIGGER_32	0x20 /* Mask for transmit trigger set at 32 */
+#define UART_FCR7_T_TRIGGER_56	0x30 /* Mask for transmit trigger set at 56 */
 #define UART_FCR7_64BYTE	0x20 /* Go into 64 byte mode (TI16C750) */
 
 #define UART_LCR	3	/* Out: Line Control Register */
@@ -307,5 +316,19 @@
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
 

--tNQTSEo8WG/FKZ8E--
