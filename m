Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262270AbVFIFMA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262270AbVFIFMA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 01:12:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262271AbVFIFMA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 01:12:00 -0400
Received: from de01egw01.freescale.net ([192.88.165.102]:29101 "EHLO
	de01egw01.freescale.net") by vger.kernel.org with ESMTP
	id S262270AbVFIFLq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 01:11:46 -0400
Date: Thu, 9 Jun 2005 00:11:26 -0500 (CDT)
From: Kumar Gala <galak@freescale.com>
X-X-Sender: galak@nylon.am.freescale.net
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org,
       linuxppc-embedded <linuxppc-embedded@ozlabs.org>, msm@freescale.com
Subject: [PATCH] ppc32: Add support for MPC8245 8250 serial ports on Sandpoint
Message-ID: <Pine.LNX.4.61.0506090010260.21964@nylon.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Added platform device initialization for the two 8250 style UARTs
that exist on the MPC8245.  Additionally, updated the Sandpoint
code to enable one of these UARTs if an MPC8245 is connected to
it.

Signed-off-by: Matt McClintock <msm@freescale.com>
Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

---
commit 55d8b4cb4e140c5070b49dbda9798ae41901f8f9
tree 5cd65f7fffed04ddca7788510b1d24ba0a5e5a70
parent a50a1bad037d7c6621ce360310ae810e7bc822c7
author Matt McClintock <msm@freescale.com> Thu, 09 Jun 2005 00:08:26 -0500
committer Kumar K. Gala <kumar.gala@freescale.com> Thu, 09 Jun 2005 00:08:26 -0500

 arch/ppc/platforms/sandpoint.c  |   20 ++++++++++++++++++++
 arch/ppc/syslib/mpc10x_common.c |   20 ++++++++++++++++++++
 2 files changed, 40 insertions(+), 0 deletions(-)

diff --git a/arch/ppc/platforms/sandpoint.c b/arch/ppc/platforms/sandpoint.c
--- a/arch/ppc/platforms/sandpoint.c
+++ b/arch/ppc/platforms/sandpoint.c
@@ -81,6 +81,7 @@
 #include <linux/serial.h>
 #include <linux/tty.h>	/* for linux/serial_core.h */
 #include <linux/serial_core.h>
+#include <linux/serial_8250.h>
 
 #include <asm/system.h>
 #include <asm/pgtable.h>
@@ -99,6 +100,7 @@
 #include <asm/mpc10x.h>
 #include <asm/pci-bridge.h>
 #include <asm/kgdb.h>
+#include <asm/ppc_sys.h>
 
 #include "sandpoint.h"
 
@@ -304,6 +306,24 @@ sandpoint_setup_arch(void)
 
 	/* Lookup PCI host bridges */
 	sandpoint_find_bridges();
+
+	if (strncmp (cur_ppc_sys_spec->ppc_sys_name, "8245", 4) == 0)
+	{
+		bd_t *bp = (bd_t *)__res;
+		struct plat_serial8250_port *pdata;
+		pdata = (struct plat_serial8250_port *) ppc_sys_get_pdata(MPC10X_DUART);
+
+		if (pdata)
+		{
+			pdata[0].uartclk = bp->bi_busfreq;
+			pdata[0].membase = ioremap(pdata[0].mapbase, 0x100);
+
+			/* this disables the 2nd serial port on the DUART
+			 * since the sandpoint does not have it connected */
+			pdata[1].uartclk = 0;
+			pdata[1].irq = 0;
+			pdata[1].mapbase = 0;
+		}
 
 	printk(KERN_INFO "Motorola SPS Sandpoint Test Platform\n");
 	printk(KERN_INFO "Port by MontaVista Software, Inc. (source@mvista.com)\n");
diff --git a/arch/ppc/syslib/mpc10x_common.c b/arch/ppc/syslib/mpc10x_common.c
--- a/arch/ppc/syslib/mpc10x_common.c
+++ b/arch/ppc/syslib/mpc10x_common.c
@@ -44,10 +44,12 @@
 #define MPC10X_I2C_IRQ (EPIC_IRQ_BASE + NUM_8259_INTERRUPTS)
 #define MPC10X_DMA0_IRQ (EPIC_IRQ_BASE + 1 + NUM_8259_INTERRUPTS)
 #define MPC10X_DMA1_IRQ (EPIC_IRQ_BASE + 2 + NUM_8259_INTERRUPTS)
+#define MPC10X_UART0_IRQ (EPIC_IRQ_BASE + 4 + NUM_8259_INTERRUPTS)
 #else
 #define MPC10X_I2C_IRQ -1
 #define MPC10X_DMA0_IRQ -1
 #define MPC10X_DMA1_IRQ -1
+#define MPC10X_UART0_IRQ -1
 #endif
 
 static struct fsl_i2c_platform_data mpc10x_i2c_pdata = {
@@ -55,6 +57,16 @@ static struct fsl_i2c_platform_data mpc1
 };
 
 static struct plat_serial8250_port serial_platform_data[] = {
+	[0] = {
+		.mapbase	= 0x4500,
+		.iotype		= UPIO_MEM,
+		.flags		= UPF_BOOT_AUTOCONF | UPF_SKIP_TEST,
+	},
+	[1] = {
+		.mapbase	= 0x4600,
+		.iotype		= UPIO_MEM,
+		.flags		= UPF_BOOT_AUTOCONF | UPF_SKIP_TEST,
+	},
 	{ },
 };
 
@@ -399,6 +411,12 @@ mpc10x_bridge_init(struct pci_controller
 	ppc_sys_platform_devices[MPC10X_DMA1].resource[1].start = MPC10X_DMA1_IRQ;
 	ppc_sys_platform_devices[MPC10X_DMA1].resource[1].end = MPC10X_DMA1_IRQ;
 
+	serial_platform_data[0].mapbase += phys_eumb_base;
+	serial_platform_data[0].irq = MPC10X_UART0_IRQ;
+
+	serial_platform_data[1].mapbase += phys_eumb_base;
+	serial_platform_data[1].irq = MPC10X_UART0_IRQ + 1;
+
 	/*
 	 * 8240 erratum 26, 8241/8245 erratum 29, 107 erratum 23: speculative
 	 * PCI reads may return stale data so turn off.
@@ -597,6 +615,8 @@ void __init mpc10x_set_openpic(void)
 	openpic_set_sources(EPIC_IRQ_BASE, 3, OpenPIC_Addr + 0x11020);
 	/* Skip reserved space and map Message Unit Interrupt (I2O) */
 	openpic_set_sources(EPIC_IRQ_BASE + 3, 1, OpenPIC_Addr + 0x110C0);
+	/* Skip reserved space and map Serial Interupts */
+	openpic_set_sources(EPIC_IRQ_BASE + 4, 2, OpenPIC_Addr + 0x11120);
 
 	openpic_init(NUM_8259_INTERRUPTS);
 }
