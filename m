Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262637AbVA1SnT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262637AbVA1SnT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 13:43:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262108AbVA1SmP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 13:42:15 -0500
Received: from az33egw02.freescale.net ([192.88.158.103]:12232 "EHLO
	az33egw02.freescale.net") by vger.kernel.org with ESMTP
	id S261523AbVA1SfF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 13:35:05 -0500
Date: Fri, 28 Jan 2005 12:34:47 -0600 (CST)
From: Kumar Gala <galak@freescale.com>
X-X-Sender: galak@blarg.somerset.sps.mot.com
To: akpm@osdl.org
cc: linuxppc-embedded@ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] PPC32: Use platform device style initialization for 85xx
 serial8250 ports
Message-ID: <Pine.LNX.4.61.0501281231520.13023@blarg.somerset.sps.mot.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Converts the initialization of serial8250 ports on various 85xx parts from 
using the old ISA style to a platform device.

Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

---
diff -Nru a/arch/ppc/platforms/85xx/mpc8540_ads.c b/arch/ppc/platforms/85xx/mpc8540_ads.c
--- a/arch/ppc/platforms/85xx/mpc8540_ads.c	2005-01-28 12:26:45 -06:00
+++ b/arch/ppc/platforms/85xx/mpc8540_ads.c	2005-01-28 12:26:45 -06:00
@@ -147,10 +147,25 @@
 #ifdef CONFIG_SERIAL_TEXT_DEBUG
 	{
 		bd_t *binfo = (bd_t *) __res;
+		struct uart_port p;
 
 		/* Use the last TLB entry to map CCSRBAR to allow access to DUART regs */
 		settlbcam(NUM_TLBCAMS - 1, binfo->bi_immr_base,
 			  binfo->bi_immr_base, MPC85xx_CCSRBAR_SIZE, _PAGE_IO, 0);
+		
+		memset(&p, 0, sizeof (p));
+		p.iotype = SERIAL_IO_MEM;
+		p.membase = (void *) binfo->bi_immr_base + MPC85xx_UART0_OFFSET;
+		p.uartclk = binfo->bi_busfreq;
+		
+		gen550_init(0, &p);
+		
+		memset(&p, 0, sizeof (p));
+		p.iotype = SERIAL_IO_MEM;
+		p.membase = (void *) binfo->bi_immr_base + MPC85xx_UART1_OFFSET;
+		p.uartclk = binfo->bi_busfreq;
+		
+		gen550_init(1, &p);
 	}
 #endif
 
diff -Nru a/arch/ppc/platforms/85xx/mpc8540_ads.h b/arch/ppc/platforms/85xx/mpc8540_ads.h
--- a/arch/ppc/platforms/85xx/mpc8540_ads.h	2005-01-28 12:26:45 -06:00
+++ b/arch/ppc/platforms/85xx/mpc8540_ads.h	2005-01-28 12:26:45 -06:00
@@ -22,8 +22,4 @@
 #include <syslib/ppc85xx_setup.h>
 #include <platforms/85xx/mpc85xx_ads_common.h>
 
-#define SERIAL_PORT_DFNS	\
-	STD_UART_OP(0)		\
-	STD_UART_OP(1)
-
 #endif /* __MACH_MPC8540ADS_H__ */
diff -Nru a/arch/ppc/platforms/85xx/mpc85xx_cds_common.c b/arch/ppc/platforms/85xx/mpc85xx_cds_common.c
--- a/arch/ppc/platforms/85xx/mpc85xx_cds_common.c	2005-01-28 12:26:45 -06:00
+++ b/arch/ppc/platforms/85xx/mpc85xx_cds_common.c	2005-01-28 12:26:45 -06:00
@@ -396,11 +396,25 @@
 #ifdef CONFIG_SERIAL_TEXT_DEBUG
 	{
 		bd_t *binfo = (bd_t *) __res;
+		struct uart_port p;
 
 		/* Use the last TLB entry to map CCSRBAR to allow access to DUART regs */
 		settlbcam(NUM_TLBCAMS - 1, binfo->bi_immr_base,
-			binfo->bi_immr_base, MPC85xx_CCSRBAR_SIZE, _PAGE_IO, 0);
-
+			  binfo->bi_immr_base, MPC85xx_CCSRBAR_SIZE, _PAGE_IO, 0);
+		
+		memset(&p, 0, sizeof (p));
+		p.iotype = SERIAL_IO_MEM;
+		p.membase = (void *) binfo->bi_immr_base + MPC85xx_UART0_OFFSET;
+		p.uartclk = binfo->bi_busfreq;
+		
+		gen550_init(0, &p);
+		
+		memset(&p, 0, sizeof (p));
+		p.iotype = SERIAL_IO_MEM;
+		p.membase = (void *) binfo->bi_immr_base + MPC85xx_UART1_OFFSET;
+		p.uartclk = binfo->bi_busfreq;
+		
+		gen550_init(1, &p);
 	}
 #endif
 
diff -Nru a/arch/ppc/platforms/85xx/mpc85xx_cds_common.h b/arch/ppc/platforms/85xx/mpc85xx_cds_common.h
--- a/arch/ppc/platforms/85xx/mpc85xx_cds_common.h	2005-01-28 12:26:45 -06:00
+++ b/arch/ppc/platforms/85xx/mpc85xx_cds_common.h	2005-01-28 12:26:45 -06:00
@@ -73,8 +73,4 @@
 
 #define MPC85XX_PCI2_IO_SIZE         0x01000000
 
-#define SERIAL_PORT_DFNS		\
-	       STD_UART_OP(0)		\
-	       STD_UART_OP(1)
-
 #endif /* __MACH_MPC85XX_CDS_H__ */
diff -Nru a/arch/ppc/platforms/85xx/mpc85xx_devices.c b/arch/ppc/platforms/85xx/mpc85xx_devices.c
--- a/arch/ppc/platforms/85xx/mpc85xx_devices.c	2005-01-28 12:26:45 -06:00
+++ b/arch/ppc/platforms/85xx/mpc85xx_devices.c	2005-01-28 12:26:45 -06:00
@@ -16,6 +16,7 @@
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/device.h>
+#include <linux/serial_8250.h>
 #include <linux/fsl_devices.h>
 #include <asm/mpc85xx.h>
 #include <asm/irq.h>
@@ -47,6 +48,21 @@
 	.device_flags = FSL_I2C_DEV_SEPARATE_DFSRR,
 };
 
+static struct plat_serial8250_port serial_platform_data[] = {
+	[0] = {
+		.mapbase	= 0x4500,
+		.irq		= MPC85xx_IRQ_DUART,
+		.iotype		= UPIO_MEM,
+		.flags		= UPF_BOOT_AUTOCONF | UPF_SKIP_TEST | UPF_SHARE_IRQ,
+	},
+	[1] = {
+		.mapbase	= 0x4600,
+		.irq		= MPC85xx_IRQ_DUART,
+		.iotype		= UPIO_MEM,
+		.flags		= UPF_BOOT_AUTOCONF | UPF_SKIP_TEST | UPF_SHARE_IRQ,
+	},
+};
+
 struct platform_device ppc_sys_platform_devices[] = {
 	[MPC85xx_TSEC1] = {
 		.name = "fsl-gianfar",
@@ -222,6 +238,11 @@
 				.flags	= IORESOURCE_IRQ,
 			},
 		},
+	},
+	[MPC85xx_DUART] = {
+		.name = "serial8250",
+		.id	= 0,
+		.dev.platform_data = serial_platform_data,
 	},
 	[MPC85xx_PERFMON] = {
 		.name = "fsl-perfmon",
diff -Nru a/arch/ppc/platforms/85xx/mpc85xx_sys.c b/arch/ppc/platforms/85xx/mpc85xx_sys.c
--- a/arch/ppc/platforms/85xx/mpc85xx_sys.c	2005-01-28 12:26:45 -06:00
+++ b/arch/ppc/platforms/85xx/mpc85xx_sys.c	2005-01-28 12:26:45 -06:00
@@ -24,12 +24,12 @@
 		.ppc_sys_name	= "MPC8540",
 		.mask 		= 0xFFFF0000,
 		.value 		= 0x80300000,
-		.num_devices	= 9,
+		.num_devices	= 10,
 		.device_list	= (enum ppc_sys_devices[])
 		{
 			MPC85xx_TSEC1, MPC85xx_TSEC2, MPC85xx_FEC, MPC85xx_IIC1,
 			MPC85xx_DMA0, MPC85xx_DMA1, MPC85xx_DMA2, MPC85xx_DMA3,
-			MPC85xx_PERFMON,
+			MPC85xx_PERFMON, MPC85xx_DUART,
 		},
 	},
 	{
@@ -52,12 +52,12 @@
 		.ppc_sys_name	= "MPC8541",
 		.mask 		= 0xFFFF0000,
 		.value 		= 0x80720000,
-		.num_devices	= 12,
+		.num_devices	= 13,
 		.device_list	= (enum ppc_sys_devices[])
 		{
 			MPC85xx_TSEC1, MPC85xx_TSEC2, MPC85xx_IIC1,
 			MPC85xx_DMA0, MPC85xx_DMA1, MPC85xx_DMA2, MPC85xx_DMA3,
-			MPC85xx_PERFMON,
+			MPC85xx_PERFMON, MPC85xx_DUART,
 			MPC85xx_CPM_SPI, MPC85xx_CPM_I2C,
 			MPC85xx_CPM_FCC1, MPC85xx_CPM_FCC2,
 		},
@@ -66,12 +66,12 @@
 		.ppc_sys_name	= "MPC8541E",
 		.mask 		= 0xFFFF0000,
 		.value 		= 0x807A0000,
-		.num_devices	= 13,
+		.num_devices	= 14,
 		.device_list	= (enum ppc_sys_devices[])
 		{
 			MPC85xx_TSEC1, MPC85xx_TSEC2, MPC85xx_IIC1,
 			MPC85xx_DMA0, MPC85xx_DMA1, MPC85xx_DMA2, MPC85xx_DMA3,
-			MPC85xx_PERFMON, MPC85xx_SEC2,
+			MPC85xx_PERFMON, MPC85xx_DUART, MPC85xx_SEC2,
 			MPC85xx_CPM_SPI, MPC85xx_CPM_I2C,
 			MPC85xx_CPM_FCC1, MPC85xx_CPM_FCC2,
 		},
@@ -80,12 +80,12 @@
 		.ppc_sys_name	= "MPC8555",
 		.mask 		= 0xFFFF0000,
 		.value 		= 0x80710000,
-		.num_devices	= 19,
+		.num_devices	= 20,
 		.device_list	= (enum ppc_sys_devices[])
 		{
 			MPC85xx_TSEC1, MPC85xx_TSEC2, MPC85xx_IIC1,
 			MPC85xx_DMA0, MPC85xx_DMA1, MPC85xx_DMA2, MPC85xx_DMA3,
-			MPC85xx_PERFMON,
+			MPC85xx_PERFMON, MPC85xx_DUART,
 			MPC85xx_CPM_SPI, MPC85xx_CPM_I2C, MPC85xx_CPM_SCC1,
 			MPC85xx_CPM_SCC2, MPC85xx_CPM_SCC3,
 			MPC85xx_CPM_FCC1, MPC85xx_CPM_FCC2, MPC85xx_CPM_FCC3,
@@ -97,12 +97,12 @@
 		.ppc_sys_name	= "MPC8555E",
 		.mask 		= 0xFFFF0000,
 		.value 		= 0x80790000,
-		.num_devices	= 20,
+		.num_devices	= 21,
 		.device_list	= (enum ppc_sys_devices[])
 		{
 			MPC85xx_TSEC1, MPC85xx_TSEC2, MPC85xx_IIC1,
 			MPC85xx_DMA0, MPC85xx_DMA1, MPC85xx_DMA2, MPC85xx_DMA3,
-			MPC85xx_PERFMON, MPC85xx_SEC2,
+			MPC85xx_PERFMON, MPC85xx_DUART, MPC85xx_SEC2,
 			MPC85xx_CPM_SPI, MPC85xx_CPM_I2C, MPC85xx_CPM_SCC1,
 			MPC85xx_CPM_SCC2, MPC85xx_CPM_SCC3,
 			MPC85xx_CPM_FCC1, MPC85xx_CPM_FCC2, MPC85xx_CPM_FCC3,
diff -Nru a/arch/ppc/syslib/ppc85xx_setup.c b/arch/ppc/syslib/ppc85xx_setup.c
--- a/arch/ppc/syslib/ppc85xx_setup.c	2005-01-28 12:26:45 -06:00
+++ b/arch/ppc/syslib/ppc85xx_setup.c	2005-01-28 12:26:45 -06:00
@@ -21,12 +21,14 @@
 #include <linux/serial.h>
 #include <linux/tty.h>	/* for linux/serial_core.h */
 #include <linux/serial_core.h>
+#include <linux/serial_8250.h>
 
 #include <asm/prom.h>
 #include <asm/time.h>
 #include <asm/mpc85xx.h>
 #include <asm/immap_85xx.h>
 #include <asm/mmu.h>
+#include <asm/ppc_sys.h>
 #include <asm/kgdb.h>
 
 #include <syslib/ppc85xx_setup.h>
@@ -72,40 +74,39 @@
 void __init
 mpc85xx_early_serial_map(void)
 {
+#if defined(CONFIG_SERIAL_TEXT_DEBUG) || defined(CONFIG_KGDB)
 	struct uart_port serial_req;
+#endif
+	struct plat_serial8250_port *pdata;
 	bd_t *binfo = (bd_t *) __res;
-	phys_addr_t duart_paddr = binfo->bi_immr_base + MPC85xx_UART0_OFFSET;
+	pdata = (struct plat_serial8250_port *) ppc_sys_get_pdata(MPC85xx_DUART);
 
 	/* Setup serial port access */
+	pdata[0].uartclk = binfo->bi_busfreq;
+	pdata[0].mapbase += binfo->bi_immr_base;
+	pdata[0].membase = ioremap(pdata[0].mapbase, MPC85xx_UART0_SIZE);
+
+#if defined(CONFIG_SERIAL_TEXT_DEBUG) || defined(CONFIG_KGDB)
 	memset(&serial_req, 0, sizeof (serial_req));
-	serial_req.uartclk = binfo->bi_busfreq;
-	serial_req.line = 0;
-	serial_req.irq = MPC85xx_IRQ_DUART;
-	serial_req.flags = ASYNC_BOOT_AUTOCONF | ASYNC_SKIP_TEST;
 	serial_req.iotype = SERIAL_IO_MEM;
-	serial_req.membase = ioremap(duart_paddr, MPC85xx_UART0_SIZE);
-	serial_req.mapbase = duart_paddr;
+	serial_req.mapbase = pdata[0].mapbase;
+	serial_req.membase = pdata[0].membase;
 	serial_req.regshift = 0;
 
-#if defined(CONFIG_SERIAL_TEXT_DEBUG) || defined(CONFIG_KGDB)
 	gen550_init(0, &serial_req);
 #endif
 
-	if (early_serial_setup(&serial_req) != 0)
-		printk("Early serial init of port 0 failed\n");
-
-	/* Assume early_serial_setup() doesn't modify serial_req */
-	duart_paddr = binfo->bi_immr_base + MPC85xx_UART1_OFFSET;
-	serial_req.line = 1;
-	serial_req.mapbase = duart_paddr;
-	serial_req.membase = ioremap(duart_paddr, MPC85xx_UART1_SIZE);
+	pdata[1].uartclk = binfo->bi_busfreq;
+	pdata[1].mapbase += binfo->bi_immr_base;
+	pdata[1].membase = ioremap(pdata[1].mapbase, MPC85xx_UART0_SIZE);
 
 #if defined(CONFIG_SERIAL_TEXT_DEBUG) || defined(CONFIG_KGDB)
+	/* Assume gen550_init() doesn't modify serial_req */
+	serial_req.mapbase = pdata[1].mapbase;
+	serial_req.membase = pdata[1].membase;
+
 	gen550_init(1, &serial_req);
 #endif
-
-	if (early_serial_setup(&serial_req) != 0)
-		printk("Early serial init of port 1 failed\n");
 }
 #endif
 
diff -Nru a/arch/ppc/syslib/ppc85xx_setup.h b/arch/ppc/syslib/ppc85xx_setup.h
--- a/arch/ppc/syslib/ppc85xx_setup.h	2005-01-28 12:26:45 -06:00
+++ b/arch/ppc/syslib/ppc85xx_setup.h	2005-01-28 12:26:45 -06:00
@@ -43,9 +43,6 @@
 #define PCIX_STATUS	0x64
 
 /* Serial Config */
-#define MPC85XX_0_SERIAL                (CCSRBAR + 0x4500)
-#define MPC85XX_1_SERIAL                (CCSRBAR + 0x4600)
-
 #ifdef CONFIG_SERIAL_MANY_PORTS
 #define RS_TABLE_SIZE  64
 #else
@@ -55,12 +52,6 @@
 #ifndef BASE_BAUD
 #define BASE_BAUD 115200
 #endif
-
-#define STD_UART_OP(num)					\
-	{ 0, BASE_BAUD, num, MPC85xx_IRQ_DUART,			\
-		(ASYNC_BOOT_AUTOCONF | ASYNC_SKIP_TEST),	\
-		iomem_base: (u8 *)MPC85XX_##num##_SERIAL,	\
-		io_type: SERIAL_IO_MEM},
 
 /* Offset of CPM register space */
 #define CPM_MAP_ADDR	(CCSRBAR + MPC85xx_CPM_OFFSET)
