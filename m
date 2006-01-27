Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751587AbWA0Wua@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751587AbWA0Wua (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 17:50:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751585AbWA0Wua
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 17:50:30 -0500
Received: from smtp3.pp.htv.fi ([213.243.153.36]:7632 "EHLO smtp3.pp.htv.fi")
	by vger.kernel.org with ESMTP id S1751586AbWA0Wu3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 17:50:29 -0500
Date: Sat, 28 Jan 2006 00:50:24 +0200
From: Paul Mundt <lethal@linux-sh.org>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/11] sh: SH4-202 microdev updates.
Message-ID: <20060127225024.GB30816@linux-sh.org>
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

A few trivial updates for the microdev board support code:

	- Update for __IO_PREFIX changes.
	- Consolidate headers into a single microdev.h.
	- Update the microdev_defconfig.
	- Add init values for the S1D13806 used by s1d13xxxfb.

Signed-off-by: Paul Mundt <lethal@linux-sh.org>

---

 arch/sh/boards/superh/microdev/io.c    |  192 +++++++--------
 arch/sh/boards/superh/microdev/irq.c   |    2 
 arch/sh/boards/superh/microdev/setup.c |  168 ++++++++++++-
 arch/sh/configs/microdev_defconfig     |  410 ++++++++++++++++++++------------
 include/asm-sh/microdev.h              |   80 ++++++
 include/asm-sh/microdev/io.h           |   53 ----
 include/asm-sh/microdev/irq.h          |   72 ------
 7 files changed, 583 insertions(+), 394 deletions(-)
 create mode 100644 include/asm-sh/microdev.h
 delete mode 100644 include/asm-sh/microdev/io.h
 delete mode 100644 include/asm-sh/microdev/irq.h

4b4cde7ece5afa9d186ede183d2d865d1cd10758
diff --git a/arch/sh/boards/superh/microdev/io.c b/arch/sh/boards/superh/microdev/io.c
index fe83b2c..1ed7f88 100644
--- a/arch/sh/boards/superh/microdev/io.c
+++ b/arch/sh/boards/superh/microdev/io.c
@@ -16,7 +16,7 @@
 #include <linux/pci.h>
 #include <linux/wait.h>
 #include <asm/io.h>
-#include <asm/mach/io.h>
+#include <asm/microdev.h>
 
 	/*
 	 *	we need to have a 'safe' address to re-direct all I/O requests
@@ -52,8 +52,90 @@
 #define	IO_ISP1161_PHYS		0xa7700000ul	/* Physical address of Philips ISP1161x USB chip */
 #define	IO_SUPERIO_PHYS		0xa7800000ul	/* Physical address of SMSC FDC37C93xAPM SuperIO chip */
 
-#define PORT2ADDR(x) (microdev_isa_port2addr(x))
+/*
+ * map I/O ports to memory-mapped addresses
+ */
+static unsigned long microdev_isa_port2addr(unsigned long offset)
+{
+	unsigned long result;
+
+	if ((offset >= IO_LAN91C111_BASE) &&
+	    (offset <  IO_LAN91C111_BASE + IO_LAN91C111_EXTENT)) {
+			/*
+			 *	SMSC LAN91C111 Ethernet chip
+			 */
+		result = IO_LAN91C111_PHYS + offset - IO_LAN91C111_BASE;
+	} else if ((offset >= IO_SUPERIO_BASE) &&
+		   (offset <  IO_SUPERIO_BASE + IO_SUPERIO_EXTENT)) {
+			/*
+			 *	SMSC FDC37C93xAPM SuperIO chip
+			 *
+			 *	Configuration Registers
+			 */
+		result = IO_SUPERIO_PHYS + (offset << 1);
+#if 0
+	} else if (offset == KBD_DATA_REG || offset == KBD_CNTL_REG ||
+		   offset == KBD_STATUS_REG) {
+			/*
+			 *	SMSC FDC37C93xAPM SuperIO chip
+			 *
+			 *	PS/2 Keyboard + Mouse (ports 0x60 and 0x64).
+			 */
+	        result = IO_SUPERIO_PHYS + (offset << 1);
+#endif
+	} else if (((offset >= IO_IDE1_BASE) &&
+		    (offset <  IO_IDE1_BASE + IO_IDE_EXTENT)) ||
+		    (offset == IO_IDE1_MISC)) {
+			/*
+			 *	SMSC FDC37C93xAPM SuperIO chip
+			 *
+			 *	IDE #1
+			 */
+	        result = IO_SUPERIO_PHYS + (offset << 1);
+	} else if (((offset >= IO_IDE2_BASE) &&
+		    (offset <  IO_IDE2_BASE + IO_IDE_EXTENT)) ||
+		    (offset == IO_IDE2_MISC)) {
+			/*
+			 *	SMSC FDC37C93xAPM SuperIO chip
+			 *
+			 *	IDE #2
+			 */
+	        result = IO_SUPERIO_PHYS + (offset << 1);
+	} else if ((offset >= IO_SERIAL1_BASE) &&
+		   (offset <  IO_SERIAL1_BASE + IO_SERIAL_EXTENT)) {
+			/*
+			 *	SMSC FDC37C93xAPM SuperIO chip
+			 *
+			 *	Serial #1
+			 */
+		result = IO_SUPERIO_PHYS + (offset << 1);
+	} else if ((offset >= IO_SERIAL2_BASE) &&
+		   (offset <  IO_SERIAL2_BASE + IO_SERIAL_EXTENT)) {
+			/*
+			 *	SMSC FDC37C93xAPM SuperIO chip
+			 *
+			 *	Serial #2
+			 */
+		result = IO_SUPERIO_PHYS + (offset << 1);
+	} else if ((offset >= IO_ISP1161_BASE) &&
+		   (offset < IO_ISP1161_BASE + IO_ISP1161_EXTENT)) {
+			/*
+			 *	Philips USB ISP1161x chip
+			 */
+		result = IO_ISP1161_PHYS + offset - IO_ISP1161_BASE;
+	} else {
+			/*
+			 *	safe default.
+			 */
+		printk("Warning: unexpected port in %s( offset = 0x%lx )\n",
+		       __FUNCTION__, offset);
+		result = PVR;
+	}
+
+	return result;
+}
 
+#define PORT2ADDR(x) (microdev_isa_port2addr(x))
 
 static inline void delay(void)
 {
@@ -94,6 +176,17 @@ unsigned int microdev_inl(unsigned long 
 	return *(volatile unsigned int*)PORT2ADDR(port);
 }
 
+void microdev_outw(unsigned short b, unsigned long port)
+{
+#ifdef CONFIG_PCI
+	if (port >= PCIBIOS_MIN_IO) {
+		microdev_pci_outw(b, port);
+		return;
+	}
+#endif
+	*(volatile unsigned short*)PORT2ADDR(port) = b;
+}
+
 void microdev_outb(unsigned char b, unsigned long port)
 {
 #ifdef CONFIG_PCI
@@ -158,17 +251,6 @@ void microdev_outb(unsigned char b, unsi
 	}
 }
 
-void microdev_outw(unsigned short b, unsigned long port)
-{
-#ifdef CONFIG_PCI
-	if (port >= PCIBIOS_MIN_IO) {
-		microdev_pci_outw(b, port);
-		return;
-	}
-#endif
-	*(volatile unsigned short*)PORT2ADDR(port) = b;
-}
-
 void microdev_outl(unsigned int b, unsigned long port)
 {
 #ifdef CONFIG_PCI
@@ -284,87 +366,3 @@ void microdev_outsl(unsigned long port, 
 	while (count--)
 		*port_addr = *buf++;
 }
-
-/*
- * map I/O ports to memory-mapped addresses
- */
-unsigned long microdev_isa_port2addr(unsigned long offset)
-{
-	unsigned long result;
-
-	if ((offset >= IO_LAN91C111_BASE) &&
-	    (offset <  IO_LAN91C111_BASE + IO_LAN91C111_EXTENT)) {
-			/*
-			 *	SMSC LAN91C111 Ethernet chip
-			 */
-		result = IO_LAN91C111_PHYS + offset - IO_LAN91C111_BASE;
-	} else if ((offset >= IO_SUPERIO_BASE) &&
-		   (offset <  IO_SUPERIO_BASE + IO_SUPERIO_EXTENT)) {
-			/*
-			 *	SMSC FDC37C93xAPM SuperIO chip
-			 *
-			 *	Configuration Registers
-			 */
-		result = IO_SUPERIO_PHYS + (offset << 1);
-#if 0
-	} else if (offset == KBD_DATA_REG || offset == KBD_CNTL_REG ||
-		   offset == KBD_STATUS_REG) {
-			/*
-			 *	SMSC FDC37C93xAPM SuperIO chip
-			 *
-			 *	PS/2 Keyboard + Mouse (ports 0x60 and 0x64).
-			 */
-	        result = IO_SUPERIO_PHYS + (offset << 1);
-#endif
-	} else if (((offset >= IO_IDE1_BASE) &&
-		    (offset <  IO_IDE1_BASE + IO_IDE_EXTENT)) ||
-		    (offset == IO_IDE1_MISC)) {
-			/*
-			 *	SMSC FDC37C93xAPM SuperIO chip
-			 *
-			 *	IDE #1
-			 */
-	        result = IO_SUPERIO_PHYS + (offset << 1);
-	} else if (((offset >= IO_IDE2_BASE) &&
-		    (offset <  IO_IDE2_BASE + IO_IDE_EXTENT)) ||
-		    (offset == IO_IDE2_MISC)) {
-			/*
-			 *	SMSC FDC37C93xAPM SuperIO chip
-			 *
-			 *	IDE #2
-			 */
-	        result = IO_SUPERIO_PHYS + (offset << 1);
-	} else if ((offset >= IO_SERIAL1_BASE) &&
-		   (offset <  IO_SERIAL1_BASE + IO_SERIAL_EXTENT)) {
-			/*
-			 *	SMSC FDC37C93xAPM SuperIO chip
-			 *
-			 *	Serial #1
-			 */
-		result = IO_SUPERIO_PHYS + (offset << 1);
-	} else if ((offset >= IO_SERIAL2_BASE) &&
-		   (offset <  IO_SERIAL2_BASE + IO_SERIAL_EXTENT)) {
-			/*
-			 *	SMSC FDC37C93xAPM SuperIO chip
-			 *
-			 *	Serial #2
-			 */
-		result = IO_SUPERIO_PHYS + (offset << 1);
-	} else if ((offset >= IO_ISP1161_BASE) &&
-		   (offset < IO_ISP1161_BASE + IO_ISP1161_EXTENT)) {
-			/*
-			 *	Philips USB ISP1161x chip
-			 */
-		result = IO_ISP1161_PHYS + offset - IO_ISP1161_BASE;
-	} else {
-			/*
-			 *	safe default.
-			 */
-		printk("Warning: unexpected port in %s( offset = 0x%lx )\n",
-		       __FUNCTION__, offset);
-		result = PVR;
-	}
-
-	return result;
-}
-
diff --git a/arch/sh/boards/superh/microdev/irq.c b/arch/sh/boards/superh/microdev/irq.c
index 1395c1e..efcbd86 100644
--- a/arch/sh/boards/superh/microdev/irq.c
+++ b/arch/sh/boards/superh/microdev/irq.c
@@ -15,7 +15,7 @@
 
 #include <asm/system.h>
 #include <asm/io.h>
-#include <asm/mach/irq.h>
+#include <asm/microdev.h>
 
 #define NUM_EXTERNAL_IRQS 16	/* IRL0 .. IRL15 */
 
diff --git a/arch/sh/boards/superh/microdev/setup.c b/arch/sh/boards/superh/microdev/setup.c
index 1c1d65f..bf0b381 100644
--- a/arch/sh/boards/superh/microdev/setup.c
+++ b/arch/sh/boards/superh/microdev/setup.c
@@ -3,7 +3,7 @@
  *
  * Copyright (C) 2003 Sean McGoogan (Sean.McGoogan@superh.com)
  * Copyright (C) 2003, 2004 SuperH, Inc.
- * Copyright (C) 2004 Paul Mundt
+ * Copyright (C) 2004, 2005 Paul Mundt
  *
  * SuperH SH4-202 MicroDev board support.
  *
@@ -15,11 +15,10 @@
 #include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/ioport.h>
+#include <video/s1d13xxxfb.h>
+#include <asm/microdev.h>
 #include <asm/io.h>
-#include <asm/mach/irq.h>
-#include <asm/mach/io.h>
 #include <asm/machvec.h>
-#include <asm/machvec_init.h>
 
 extern void microdev_heartbeat(void);
 
@@ -51,8 +50,6 @@ struct sh_machine_vector mv_sh4202_micro
 	.mv_outsw		= microdev_outsw,
 	.mv_outsl		= microdev_outsl,
 
-	.mv_isa_port2addr	= microdev_isa_port2addr,
-
 	.mv_init_irq		= init_microdev_irq,
 
 #ifdef CONFIG_HEARTBEAT
@@ -142,16 +139,161 @@ static struct platform_device smc91x_dev
 	.resource	= smc91x_resources,
 };
 
-static int __init smc91x_setup(void)
+#ifdef CONFIG_FB_S1D13XXX
+static struct s1d13xxxfb_regval s1d13806_initregs[] = {
+	{ S1DREG_MISC,			0x00 },
+	{ S1DREG_COM_DISP_MODE,		0x00 },
+	{ S1DREG_GPIO_CNF0,		0x00 },
+	{ S1DREG_GPIO_CNF1,		0x00 },
+	{ S1DREG_GPIO_CTL0,		0x00 },
+	{ S1DREG_GPIO_CTL1,		0x00 },
+	{ S1DREG_CLK_CNF,		0x02 },
+	{ S1DREG_LCD_CLK_CNF,		0x01 },
+	{ S1DREG_CRT_CLK_CNF,		0x03 },
+	{ S1DREG_MPLUG_CLK_CNF,		0x03 },
+	{ S1DREG_CPU2MEM_WST_SEL,	0x02 },
+	{ S1DREG_SDRAM_REF_RATE,	0x03 },
+	{ S1DREG_SDRAM_TC0,		0x00 },
+	{ S1DREG_SDRAM_TC1,		0x01 },
+	{ S1DREG_MEM_CNF,		0x80 },
+	{ S1DREG_PANEL_TYPE,		0x25 },
+	{ S1DREG_MOD_RATE,		0x00 },
+	{ S1DREG_LCD_DISP_HWIDTH,	0x63 },
+	{ S1DREG_LCD_NDISP_HPER,	0x1e },
+	{ S1DREG_TFT_FPLINE_START,	0x06 },
+	{ S1DREG_TFT_FPLINE_PWIDTH,	0x03 },
+	{ S1DREG_LCD_DISP_VHEIGHT0,	0x57 },
+	{ S1DREG_LCD_DISP_VHEIGHT1,	0x02 },
+	{ S1DREG_LCD_NDISP_VPER,	0x00 },
+	{ S1DREG_TFT_FPFRAME_START,	0x0a },
+	{ S1DREG_TFT_FPFRAME_PWIDTH,	0x81 },
+	{ S1DREG_LCD_DISP_MODE,		0x03 },
+	{ S1DREG_LCD_MISC,		0x00 },
+	{ S1DREG_LCD_DISP_START0,	0x00 },
+	{ S1DREG_LCD_DISP_START1,	0x00 },
+	{ S1DREG_LCD_DISP_START2,	0x00 },
+	{ S1DREG_LCD_MEM_OFF0,		0x90 },
+	{ S1DREG_LCD_MEM_OFF1,		0x01 },
+	{ S1DREG_LCD_PIX_PAN,		0x00 },
+	{ S1DREG_LCD_DISP_FIFO_HTC,	0x00 },
+	{ S1DREG_LCD_DISP_FIFO_LTC,	0x00 },
+	{ S1DREG_CRT_DISP_HWIDTH,	0x63 },
+	{ S1DREG_CRT_NDISP_HPER,	0x1f },
+	{ S1DREG_CRT_HRTC_START,	0x04 },
+	{ S1DREG_CRT_HRTC_PWIDTH,	0x8f },
+	{ S1DREG_CRT_DISP_VHEIGHT0,	0x57 },
+	{ S1DREG_CRT_DISP_VHEIGHT1,	0x02 },
+	{ S1DREG_CRT_NDISP_VPER,	0x1b },
+	{ S1DREG_CRT_VRTC_START,	0x00 },
+	{ S1DREG_CRT_VRTC_PWIDTH,	0x83 },
+	{ S1DREG_TV_OUT_CTL,		0x10 },
+	{ S1DREG_CRT_DISP_MODE,		0x05 },
+	{ S1DREG_CRT_DISP_START0,	0x00 },
+	{ S1DREG_CRT_DISP_START1,	0x00 },
+	{ S1DREG_CRT_DISP_START2,	0x00 },
+	{ S1DREG_CRT_MEM_OFF0,		0x20 },
+	{ S1DREG_CRT_MEM_OFF1,		0x03 },
+	{ S1DREG_CRT_PIX_PAN,		0x00 },
+	{ S1DREG_CRT_DISP_FIFO_HTC,	0x00 },
+	{ S1DREG_CRT_DISP_FIFO_LTC,	0x00 },
+	{ S1DREG_LCD_CUR_CTL,		0x00 },
+	{ S1DREG_LCD_CUR_START,		0x01 },
+	{ S1DREG_LCD_CUR_XPOS0,		0x00 },
+	{ S1DREG_LCD_CUR_XPOS1,		0x00 },
+	{ S1DREG_LCD_CUR_YPOS0,		0x00 },
+	{ S1DREG_LCD_CUR_YPOS1,		0x00 },
+	{ S1DREG_LCD_CUR_BCTL0,		0x00 },
+	{ S1DREG_LCD_CUR_GCTL0,		0x00 },
+	{ S1DREG_LCD_CUR_RCTL0,		0x00 },
+	{ S1DREG_LCD_CUR_BCTL1,		0x1f },
+	{ S1DREG_LCD_CUR_GCTL1,		0x3f },
+	{ S1DREG_LCD_CUR_RCTL1,		0x1f },
+	{ S1DREG_LCD_CUR_FIFO_HTC,	0x00 },
+	{ S1DREG_CRT_CUR_CTL,		0x00 },
+	{ S1DREG_CRT_CUR_START,		0x01 },
+	{ S1DREG_CRT_CUR_XPOS0,		0x00 },
+	{ S1DREG_CRT_CUR_XPOS1,		0x00 },
+	{ S1DREG_CRT_CUR_YPOS0,		0x00 },
+	{ S1DREG_CRT_CUR_YPOS1,		0x00 },
+	{ S1DREG_CRT_CUR_BCTL0,		0x00 },
+	{ S1DREG_CRT_CUR_GCTL0,		0x00 },
+	{ S1DREG_CRT_CUR_RCTL0,		0x00 },
+	{ S1DREG_CRT_CUR_BCTL1,		0x1f },
+	{ S1DREG_CRT_CUR_GCTL1,		0x3f },
+	{ S1DREG_CRT_CUR_RCTL1,		0x1f },
+	{ S1DREG_CRT_CUR_FIFO_HTC,	0x00 },
+	{ S1DREG_BBLT_CTL0,		0x00 },
+	{ S1DREG_BBLT_CTL1,		0x00 },
+	{ S1DREG_BBLT_CC_EXP,		0x00 },
+	{ S1DREG_BBLT_OP,		0x00 },
+	{ S1DREG_BBLT_SRC_START0,	0x00 },
+	{ S1DREG_BBLT_SRC_START1,	0x00 },
+	{ S1DREG_BBLT_SRC_START2,	0x00 },
+	{ S1DREG_BBLT_DST_START0,	0x00 },
+	{ S1DREG_BBLT_DST_START1,	0x00 },
+	{ S1DREG_BBLT_DST_START2,	0x00 },
+	{ S1DREG_BBLT_MEM_OFF0,		0x00 },
+	{ S1DREG_BBLT_MEM_OFF1,		0x00 },
+	{ S1DREG_BBLT_WIDTH0,		0x00 },
+	{ S1DREG_BBLT_WIDTH1,		0x00 },
+	{ S1DREG_BBLT_HEIGHT0,		0x00 },
+	{ S1DREG_BBLT_HEIGHT1,		0x00 },
+	{ S1DREG_BBLT_BGC0,		0x00 },
+	{ S1DREG_BBLT_BGC1,		0x00 },
+	{ S1DREG_BBLT_FGC0,		0x00 },
+	{ S1DREG_BBLT_FGC1,		0x00 },
+	{ S1DREG_LKUP_MODE,		0x00 },
+	{ S1DREG_LKUP_ADDR,		0x00 },
+	{ S1DREG_PS_CNF,		0x10 },
+	{ S1DREG_PS_STATUS,		0x00 },
+	{ S1DREG_CPU2MEM_WDOGT,		0x00 },
+	{ S1DREG_COM_DISP_MODE,		0x02 },
+};
+
+static struct s1d13xxxfb_pdata s1d13806_platform_data = {
+	.initregs	= s1d13806_initregs,
+	.initregssize	= ARRAY_SIZE(s1d13806_initregs),
+};
+
+static struct resource s1d13806_resources[] = {
+	[0] = {
+		.start		= 0x07200000,
+		.end		= 0x07200000 + 0x00200000 - 1,
+		.flags		= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start		= 0x07000000,
+		.end		= 0x07000000 + 0x00200000 - 1,
+		.flags		= IORESOURCE_MEM,
+	},
+};
+
+static struct platform_device s1d13806_device = {
+	.name		= "s1d13806fb",
+	.id		= -1,
+	.num_resources	= ARRAY_SIZE(s1d13806_resources),
+	.resource	= s1d13806_resources,
+
+	.dev = {
+		.platform_data	= &s1d13806_platform_data,
+	},
+};
+#endif
+
+static struct platform_device *microdev_devices[] __initdata = {
+	&smc91x_device,
+#ifdef CONFIG_FB_S1D13XXX
+	&s1d13806_device,
+#endif
+};
+
+static int __init microdev_devices_setup(void)
 {
-	return platform_device_register(&smc91x_device);
+	return platform_add_devices(microdev_devices, ARRAY_SIZE(microdev_devices));
 }
 
-__initcall(smc91x_setup);
+__initcall(microdev_devices_setup);
 
-	/*
-	 * Initialize the board
-	 */
 void __init platform_setup(void)
 {
 	int * const fpgaRevisionRegister = (int*)(MICRODEV_FPGA_GP_BASE + 0x8ul);
@@ -256,7 +398,7 @@ static int __init smsc_superio_setup(voi
 		/* enable the appropriate GPIO pins for IDE functionality:
 		 * bit[0]   In/Out		1==input;  0==output
 		 * bit[1]   Polarity		1==invert; 0==no invert
-		 * bit[2]   Int Enb #1		1==Enable Combined IRQ #1; 0==disable
+		 * bit[2]   Int Enb #1		1==Enable Combined IRQ #1; 0==disable 
 		 * bit[3:4] Function Select	00==original; 01==Alternate Function #1
 		 */
 	SMSC_WRITE_INDEXED(0x00, 0xc2);	/* GP42 = nIDE1_OE */
diff --git a/arch/sh/configs/microdev_defconfig b/arch/sh/configs/microdev_defconfig
index a3bd280..ab3db76 100644
--- a/arch/sh/configs/microdev_defconfig
+++ b/arch/sh/configs/microdev_defconfig
@@ -1,10 +1,9 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.11-sh
-# Wed Mar  2 15:09:41 2005
+# Linux kernel version: 2.6.16-rc1
+# Fri Jan 27 19:43:20 2006
 #
 CONFIG_SUPERH=y
-CONFIG_UID16=y
 CONFIG_RWSEM_GENERIC_SPINLOCK=y
 CONFIG_GENERIC_HARDIRQS=y
 CONFIG_GENERIC_IRQ_PROBE=y
@@ -17,11 +16,13 @@ CONFIG_EXPERIMENTAL=y
 CONFIG_CLEAN_COMPILE=y
 CONFIG_BROKEN_ON_SMP=y
 CONFIG_LOCK_KERNEL=y
+CONFIG_INIT_ENV_ARG_LIMIT=32
 
 #
 # General setup
 #
 CONFIG_LOCALVERSION=""
+CONFIG_LOCALVERSION_AUTO=y
 CONFIG_SWAP=y
 # CONFIG_SYSVIPC is not set
 # CONFIG_POSIX_MQUEUE is not set
@@ -29,22 +30,29 @@ CONFIG_BSD_PROCESS_ACCT=y
 # CONFIG_BSD_PROCESS_ACCT_V3 is not set
 CONFIG_SYSCTL=y
 # CONFIG_AUDIT is not set
-CONFIG_LOG_BUF_SHIFT=14
-CONFIG_HOTPLUG=y
-CONFIG_KOBJECT_UEVENT=y
 # CONFIG_IKCONFIG is not set
+CONFIG_INITRAMFS_SOURCE=""
+CONFIG_UID16=y
+# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
 CONFIG_EMBEDDED=y
 CONFIG_KALLSYMS=y
 # CONFIG_KALLSYMS_EXTRA_PASS is not set
+CONFIG_HOTPLUG=y
+CONFIG_PRINTK=y
+CONFIG_BUG=y
+CONFIG_ELF_CORE=y
+CONFIG_BASE_FULL=y
 CONFIG_FUTEX=y
 CONFIG_EPOLL=y
-# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
 CONFIG_SHMEM=y
 CONFIG_CC_ALIGN_FUNCTIONS=0
 CONFIG_CC_ALIGN_LABELS=0
 CONFIG_CC_ALIGN_LOOPS=0
 CONFIG_CC_ALIGN_JUMPS=0
+CONFIG_SLAB=y
 # CONFIG_TINY_SHMEM is not set
+CONFIG_BASE_SMALL=0
+# CONFIG_SLOB is not set
 
 #
 # Loadable module support
@@ -52,6 +60,24 @@ CONFIG_CC_ALIGN_JUMPS=0
 # CONFIG_MODULES is not set
 
 #
+# Block layer
+#
+# CONFIG_LBD is not set
+
+#
+# IO Schedulers
+#
+CONFIG_IOSCHED_NOOP=y
+CONFIG_IOSCHED_AS=y
+CONFIG_IOSCHED_DEADLINE=y
+CONFIG_IOSCHED_CFQ=y
+CONFIG_DEFAULT_AS=y
+# CONFIG_DEFAULT_DEADLINE is not set
+# CONFIG_DEFAULT_CFQ is not set
+# CONFIG_DEFAULT_NOOP is not set
+CONFIG_DEFAULT_IOSCHED="anticipatory"
+
+#
 # System type
 #
 # CONFIG_SH_SOLUTION_ENGINE is not set
@@ -61,9 +87,7 @@ CONFIG_CC_ALIGN_JUMPS=0
 # CONFIG_SH_7751_SYSTEMH is not set
 # CONFIG_SH_STB1_HARP is not set
 # CONFIG_SH_STB1_OVERDRIVE is not set
-# CONFIG_SH_HP620 is not set
-# CONFIG_SH_HP680 is not set
-# CONFIG_SH_HP690 is not set
+# CONFIG_SH_HP6XX is not set
 # CONFIG_SH_CQREEK is not set
 # CONFIG_SH_DMIDA is not set
 # CONFIG_SH_EC3104 is not set
@@ -78,45 +102,94 @@ CONFIG_CC_ALIGN_JUMPS=0
 # CONFIG_SH_SECUREEDGE5410 is not set
 # CONFIG_SH_HS7751RVOIP is not set
 # CONFIG_SH_RTS7751R2D is not set
+# CONFIG_SH_R7780RP is not set
 # CONFIG_SH_EDOSK7705 is not set
 CONFIG_SH_SH4202_MICRODEV=y
+# CONFIG_SH_LANDISK is not set
+# CONFIG_SH_TITAN is not set
 # CONFIG_SH_UNKNOWN is not set
-# CONFIG_CPU_SH2 is not set
-# CONFIG_CPU_SH3 is not set
+
+#
+# Processor selection
+#
 CONFIG_CPU_SH4=y
+
+#
+# SH-2 Processor Support
+#
 # CONFIG_CPU_SUBTYPE_SH7604 is not set
+
+#
+# SH-3 Processor Support
+#
 # CONFIG_CPU_SUBTYPE_SH7300 is not set
 # CONFIG_CPU_SUBTYPE_SH7705 is not set
 # CONFIG_CPU_SUBTYPE_SH7707 is not set
 # CONFIG_CPU_SUBTYPE_SH7708 is not set
 # CONFIG_CPU_SUBTYPE_SH7709 is not set
+
+#
+# SH-4 Processor Support
+#
 # CONFIG_CPU_SUBTYPE_SH7750 is not set
+# CONFIG_CPU_SUBTYPE_SH7091 is not set
+# CONFIG_CPU_SUBTYPE_SH7750R is not set
+# CONFIG_CPU_SUBTYPE_SH7750S is not set
 # CONFIG_CPU_SUBTYPE_SH7751 is not set
+# CONFIG_CPU_SUBTYPE_SH7751R is not set
 # CONFIG_CPU_SUBTYPE_SH7760 is not set
-# CONFIG_CPU_SUBTYPE_SH73180 is not set
+CONFIG_CPU_SUBTYPE_SH4_202=y
+
+#
+# ST40 Processor Support
+#
 # CONFIG_CPU_SUBTYPE_ST40STB1 is not set
 # CONFIG_CPU_SUBTYPE_ST40GX1 is not set
-CONFIG_CPU_SUBTYPE_SH4_202=y
+
+#
+# SH-4A Processor Support
+#
+# CONFIG_CPU_SUBTYPE_SH73180 is not set
+# CONFIG_CPU_SUBTYPE_SH7770 is not set
+# CONFIG_CPU_SUBTYPE_SH7780 is not set
+
+#
+# Memory management options
+#
 CONFIG_MMU=y
-CONFIG_CMDLINE_BOOL=y
-CONFIG_CMDLINE="console=ttySC0,115200"
+CONFIG_SELECT_MEMORY_MODEL=y
+CONFIG_FLATMEM_MANUAL=y
+# CONFIG_DISCONTIGMEM_MANUAL is not set
+# CONFIG_SPARSEMEM_MANUAL is not set
+CONFIG_FLATMEM=y
+CONFIG_FLAT_NODE_MEM_MAP=y
+# CONFIG_SPARSEMEM_STATIC is not set
+CONFIG_SPLIT_PTLOCK_CPUS=4
+
+#
+# Cache configuration
+#
+# CONFIG_SH_DIRECT_MAPPED is not set
+# CONFIG_SH_WRITETHROUGH is not set
+# CONFIG_SH_OCRAM is not set
 CONFIG_MEMORY_START=0x08000000
 CONFIG_MEMORY_SIZE=0x04000000
-CONFIG_MEMORY_SET=y
-# CONFIG_MEMORY_OVERRIDE is not set
+
+#
+# Processor features
+#
+CONFIG_CPU_LITTLE_ENDIAN=y
 CONFIG_SH_RTC=y
 CONFIG_SH_FPU=y
-CONFIG_ZERO_PAGE_OFFSET=0x00001000
-CONFIG_BOOT_LINK_OFFSET=0x00800000
-CONFIG_CPU_LITTLE_ENDIAN=y
-CONFIG_PREEMPT=y
-# CONFIG_UBC_WAKEUP is not set
-# CONFIG_SH_WRITETHROUGH is not set
-# CONFIG_SH_OCRAM is not set
 # CONFIG_SH_STORE_QUEUES is not set
-# CONFIG_SMP is not set
-CONFIG_SH_PCLK_CALC=y
-CONFIG_SH_PCLK_FREQ=65986048
+CONFIG_CPU_HAS_INTEVT=y
+CONFIG_CPU_HAS_SR_RB=y
+
+#
+# Timer support
+#
+CONFIG_SH_TMU=y
+CONFIG_SH_PCLK_FREQ=66000000
 
 #
 # CPU Frequency scaling
@@ -137,20 +210,31 @@ CONFIG_NR_ONCHIP_DMA_CHANNELS=4
 CONFIG_HEARTBEAT=y
 
 #
-# Bus options (PCI, PCMCIA, EISA, MCA, ISA)
+# Kernel features
 #
-CONFIG_ISA=y
-# CONFIG_PCI is not set
+# CONFIG_KEXEC is not set
+CONFIG_PREEMPT=y
+# CONFIG_SMP is not set
 
 #
-# PCCARD (PCMCIA/CardBus) support
+# Boot options
 #
-# CONFIG_PCCARD is not set
+CONFIG_ZERO_PAGE_OFFSET=0x00001000
+CONFIG_BOOT_LINK_OFFSET=0x00800000
+# CONFIG_UBC_WAKEUP is not set
+CONFIG_CMDLINE_BOOL=y
+CONFIG_CMDLINE="console=ttySC0,115200"
 
 #
-# PC-card bridges
+# Bus options
 #
-CONFIG_PCMCIA_PROBE=y
+# CONFIG_SUPERHYWAY is not set
+# CONFIG_PCI is not set
+
+#
+# PCCARD (PCMCIA/CardBus) support
+#
+# CONFIG_PCCARD is not set
 
 #
 # PCI Hotplug Support
@@ -164,9 +248,79 @@ CONFIG_BINFMT_ELF=y
 # CONFIG_BINFMT_MISC is not set
 
 #
-# SH initrd options
+# Networking
+#
+CONFIG_NET=y
+
+#
+# Networking options
+#
+# CONFIG_PACKET is not set
+# CONFIG_UNIX is not set
+# CONFIG_NET_KEY is not set
+CONFIG_INET=y
+# CONFIG_IP_MULTICAST is not set
+# CONFIG_IP_ADVANCED_ROUTER is not set
+CONFIG_IP_FIB_HASH=y
+CONFIG_IP_PNP=y
+CONFIG_IP_PNP_DHCP=y
+# CONFIG_IP_PNP_BOOTP is not set
+# CONFIG_IP_PNP_RARP is not set
+# CONFIG_NET_IPIP is not set
+# CONFIG_NET_IPGRE is not set
+# CONFIG_ARPD is not set
+# CONFIG_SYN_COOKIES is not set
+# CONFIG_INET_AH is not set
+# CONFIG_INET_ESP is not set
+# CONFIG_INET_IPCOMP is not set
+# CONFIG_INET_TUNNEL is not set
+CONFIG_INET_DIAG=y
+CONFIG_INET_TCP_DIAG=y
+# CONFIG_TCP_CONG_ADVANCED is not set
+CONFIG_TCP_CONG_BIC=y
+# CONFIG_IPV6 is not set
+# CONFIG_NETFILTER is not set
+
+#
+# DCCP Configuration (EXPERIMENTAL)
+#
+# CONFIG_IP_DCCP is not set
+
+#
+# SCTP Configuration (EXPERIMENTAL)
 #
-# CONFIG_EMBEDDED_RAMDISK is not set
+# CONFIG_IP_SCTP is not set
+
+#
+# TIPC Configuration (EXPERIMENTAL)
+#
+# CONFIG_TIPC is not set
+# CONFIG_ATM is not set
+# CONFIG_BRIDGE is not set
+# CONFIG_VLAN_8021Q is not set
+# CONFIG_DECNET is not set
+# CONFIG_LLC2 is not set
+# CONFIG_IPX is not set
+# CONFIG_ATALK is not set
+# CONFIG_X25 is not set
+# CONFIG_LAPB is not set
+# CONFIG_NET_DIVERT is not set
+# CONFIG_ECONET is not set
+# CONFIG_WAN_ROUTER is not set
+
+#
+# QoS and/or fair queueing
+#
+# CONFIG_NET_SCHED is not set
+
+#
+# Network testing
+#
+# CONFIG_NET_PKTGEN is not set
+# CONFIG_HAMRADIO is not set
+# CONFIG_IRDA is not set
+# CONFIG_BT is not set
+# CONFIG_IEEE80211 is not set
 
 #
 # Device Drivers
@@ -180,6 +334,11 @@ CONFIG_PREVENT_FIRMWARE_BUILD=y
 # CONFIG_FW_LOADER is not set
 
 #
+# Connector - unified userspace <-> kernelspace linker
+#
+# CONFIG_CONNECTOR is not set
+
+#
 # Memory Technology Devices (MTD)
 #
 # CONFIG_MTD is not set
@@ -192,13 +351,10 @@ CONFIG_PREVENT_FIRMWARE_BUILD=y
 #
 # Plug and Play support
 #
-# CONFIG_PNP is not set
 
 #
 # Block devices
 #
-# CONFIG_BLK_DEV_FD is not set
-# CONFIG_BLK_DEV_XD is not set
 # CONFIG_BLK_DEV_COW_COMMON is not set
 # CONFIG_BLK_DEV_LOOP is not set
 # CONFIG_BLK_DEV_NBD is not set
@@ -206,17 +362,7 @@ CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_COUNT=16
 CONFIG_BLK_DEV_RAM_SIZE=4096
 CONFIG_BLK_DEV_INITRD=y
-CONFIG_INITRAMFS_SOURCE=""
-# CONFIG_LBD is not set
 # CONFIG_CDROM_PKTCDVD is not set
-
-#
-# IO Schedulers
-#
-CONFIG_IOSCHED_NOOP=y
-CONFIG_IOSCHED_AS=y
-CONFIG_IOSCHED_DEADLINE=y
-CONFIG_IOSCHED_CFQ=y
 # CONFIG_ATA_OVER_ETH is not set
 
 #
@@ -241,9 +387,7 @@ CONFIG_BLK_DEV_IDECD=y
 # IDE chipset support/bugfixes
 #
 CONFIG_IDE_GENERIC=y
-CONFIG_IDE_SH=y
 # CONFIG_IDE_ARM is not set
-# CONFIG_IDE_CHIPSETS is not set
 # CONFIG_BLK_DEV_IDEDMA is not set
 # CONFIG_IDEDMA_AUTO is not set
 # CONFIG_BLK_DEV_HD is not set
@@ -251,14 +395,10 @@ CONFIG_IDE_SH=y
 #
 # SCSI device support
 #
+# CONFIG_RAID_ATTRS is not set
 # CONFIG_SCSI is not set
 
 #
-# Old CD-ROM drivers (not SCSI, not IDE)
-#
-# CONFIG_CD_NO_IDESCSI is not set
-
-#
 # Multi-device support (RAID and LVM)
 #
 # CONFIG_MD is not set
@@ -266,6 +406,7 @@ CONFIG_IDE_SH=y
 #
 # Fusion MPT device support
 #
+# CONFIG_FUSION is not set
 
 #
 # IEEE 1394 (FireWire) support
@@ -276,69 +417,8 @@ CONFIG_IDE_SH=y
 #
 
 #
-# Networking support
-#
-CONFIG_NET=y
-
-#
-# Networking options
-#
-# CONFIG_PACKET is not set
-# CONFIG_NETLINK_DEV is not set
-# CONFIG_UNIX is not set
-# CONFIG_NET_KEY is not set
-CONFIG_INET=y
-# CONFIG_IP_MULTICAST is not set
-# CONFIG_IP_ADVANCED_ROUTER is not set
-CONFIG_IP_PNP=y
-CONFIG_IP_PNP_DHCP=y
-# CONFIG_IP_PNP_BOOTP is not set
-# CONFIG_IP_PNP_RARP is not set
-# CONFIG_NET_IPIP is not set
-# CONFIG_NET_IPGRE is not set
-# CONFIG_ARPD is not set
-# CONFIG_SYN_COOKIES is not set
-# CONFIG_INET_AH is not set
-# CONFIG_INET_ESP is not set
-# CONFIG_INET_IPCOMP is not set
-# CONFIG_INET_TUNNEL is not set
-CONFIG_IP_TCPDIAG=y
-# CONFIG_IP_TCPDIAG_IPV6 is not set
-# CONFIG_IPV6 is not set
-# CONFIG_NETFILTER is not set
-
-#
-# SCTP Configuration (EXPERIMENTAL)
-#
-# CONFIG_IP_SCTP is not set
-# CONFIG_ATM is not set
-# CONFIG_BRIDGE is not set
-# CONFIG_VLAN_8021Q is not set
-# CONFIG_DECNET is not set
-# CONFIG_LLC2 is not set
-# CONFIG_IPX is not set
-# CONFIG_ATALK is not set
-# CONFIG_X25 is not set
-# CONFIG_LAPB is not set
-# CONFIG_NET_DIVERT is not set
-# CONFIG_ECONET is not set
-# CONFIG_WAN_ROUTER is not set
-
-#
-# QoS and/or fair queueing
-#
-# CONFIG_NET_SCHED is not set
-# CONFIG_NET_CLS_ROUTE is not set
-
-#
-# Network testing
+# Network device support
 #
-# CONFIG_NET_PKTGEN is not set
-# CONFIG_NETPOLL is not set
-# CONFIG_NET_POLL_CONTROLLER is not set
-# CONFIG_HAMRADIO is not set
-# CONFIG_IRDA is not set
-# CONFIG_BT is not set
 CONFIG_NETDEVICES=y
 # CONFIG_DUMMY is not set
 # CONFIG_BONDING is not set
@@ -346,9 +426,9 @@ CONFIG_NETDEVICES=y
 # CONFIG_TUN is not set
 
 #
-# ARCnet devices
+# PHY device support
 #
-# CONFIG_ARCNET is not set
+# CONFIG_PHYLIB is not set
 
 #
 # Ethernet (10 or 100Mbit)
@@ -356,17 +436,7 @@ CONFIG_NETDEVICES=y
 CONFIG_NET_ETHERNET=y
 CONFIG_MII=y
 # CONFIG_STNIC is not set
-# CONFIG_NET_VENDOR_3COM is not set
-# CONFIG_LANCE is not set
-# CONFIG_NET_VENDOR_SMC is not set
 CONFIG_SMC91X=y
-# CONFIG_NET_VENDOR_RACAL is not set
-# CONFIG_AT1700 is not set
-# CONFIG_DEPCA is not set
-# CONFIG_HP100 is not set
-# CONFIG_NET_ISA is not set
-# CONFIG_NET_PCI is not set
-# CONFIG_NET_POCKET is not set
 
 #
 # Ethernet (1000 Mbit)
@@ -379,7 +449,6 @@ CONFIG_SMC91X=y
 #
 # Token Ring devices
 #
-# CONFIG_TR is not set
 
 #
 # Wireless LAN (non-hamradio)
@@ -394,6 +463,8 @@ CONFIG_SMC91X=y
 # CONFIG_SLIP is not set
 # CONFIG_SHAPER is not set
 # CONFIG_NETCONSOLE is not set
+# CONFIG_NETPOLL is not set
+# CONFIG_NET_POLL_CONTROLLER is not set
 
 #
 # ISDN subsystem
@@ -411,20 +482,10 @@ CONFIG_SMC91X=y
 # CONFIG_INPUT is not set
 
 #
-# Userland interfaces
-#
-
-#
-# Input I/O drivers
+# Hardware I/O ports
 #
-# CONFIG_GAMEPORT is not set
-CONFIG_SOUND_GAMEPORT=y
 # CONFIG_SERIO is not set
-# CONFIG_SERIO_I8042 is not set
-
-#
-# Input Device Drivers
-#
+# CONFIG_GAMEPORT is not set
 
 #
 # Character devices
@@ -464,24 +525,46 @@ CONFIG_RTC=y
 #
 # Ftape, the floppy tape device driver
 #
-# CONFIG_DRM is not set
 # CONFIG_RAW_DRIVER is not set
 
 #
+# TPM devices
+#
+# CONFIG_TCG_TPM is not set
+# CONFIG_TELCLOCK is not set
+
+#
 # I2C support
 #
 # CONFIG_I2C is not set
 
 #
+# SPI support
+#
+# CONFIG_SPI is not set
+# CONFIG_SPI_MASTER is not set
+
+#
 # Dallas's 1-wire bus
 #
 # CONFIG_W1 is not set
 
 #
+# Hardware Monitoring support
+#
+CONFIG_HWMON=y
+# CONFIG_HWMON_VID is not set
+# CONFIG_HWMON_DEBUG_CHIP is not set
+
+#
 # Misc devices
 #
 
 #
+# Multimedia Capabilities Port drivers
+#
+
+#
 # Multimedia devices
 #
 # CONFIG_VIDEO_DEV is not set
@@ -508,7 +591,7 @@ CONFIG_RTC=y
 # CONFIG_USB_ARCH_HAS_OHCI is not set
 
 #
-# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support' may also be needed; see USB_STORAGE Help for more information
+# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support'
 #
 
 #
@@ -524,13 +607,21 @@ CONFIG_RTC=y
 #
 # InfiniBand support
 #
-# CONFIG_INFINIBAND is not set
+
+#
+# SN Devices
+#
+
+#
+# EDAC - error detection and reporting (RAS)
+#
 
 #
 # File systems
 #
 CONFIG_EXT2_FS=y
 # CONFIG_EXT2_FS_XATTR is not set
+# CONFIG_EXT2_FS_XIP is not set
 CONFIG_EXT3_FS=y
 CONFIG_EXT3_FS_XATTR=y
 # CONFIG_EXT3_FS_POSIX_ACL is not set
@@ -540,17 +631,17 @@ CONFIG_JBD=y
 CONFIG_FS_MBCACHE=y
 # CONFIG_REISERFS_FS is not set
 # CONFIG_JFS_FS is not set
-
-#
-# XFS support
-#
+# CONFIG_FS_POSIX_ACL is not set
 # CONFIG_XFS_FS is not set
+# CONFIG_OCFS2_FS is not set
 # CONFIG_MINIX_FS is not set
 # CONFIG_ROMFS_FS is not set
+CONFIG_INOTIFY=y
 # CONFIG_QUOTA is not set
 CONFIG_DNOTIFY=y
 # CONFIG_AUTOFS_FS is not set
 # CONFIG_AUTOFS4_FS is not set
+# CONFIG_FUSE_FS is not set
 
 #
 # CD-ROM/DVD Filesystems
@@ -574,16 +665,12 @@ CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
 CONFIG_PROC_FS=y
 CONFIG_PROC_KCORE=y
 CONFIG_SYSFS=y
-CONFIG_DEVFS_FS=y
-CONFIG_DEVFS_MOUNT=y
-# CONFIG_DEVFS_DEBUG is not set
-CONFIG_DEVPTS_FS_XATTR=y
-# CONFIG_DEVPTS_FS_SECURITY is not set
 CONFIG_TMPFS=y
-# CONFIG_TMPFS_XATTR is not set
 # CONFIG_HUGETLBFS is not set
 # CONFIG_HUGETLB_PAGE is not set
 CONFIG_RAMFS=y
+# CONFIG_RELAYFS_FS is not set
+# CONFIG_CONFIGFS_FS is not set
 
 #
 # Miscellaneous filesystems
@@ -607,12 +694,14 @@ CONFIG_RAMFS=y
 #
 CONFIG_NFS_FS=y
 CONFIG_NFS_V3=y
+# CONFIG_NFS_V3_ACL is not set
 CONFIG_NFS_V4=y
 # CONFIG_NFS_DIRECTIO is not set
 # CONFIG_NFSD is not set
 CONFIG_ROOT_NFS=y
 CONFIG_LOCKD=y
 CONFIG_LOCKD_V4=y
+CONFIG_NFS_COMMON=y
 CONFIG_SUNRPC=y
 CONFIG_SUNRPC_GSS=y
 CONFIG_RPCSEC_GSS_KRB5=y
@@ -622,6 +711,7 @@ CONFIG_RPCSEC_GSS_KRB5=y
 # CONFIG_NCP_FS is not set
 # CONFIG_CODA_FS is not set
 # CONFIG_AFS_FS is not set
+# CONFIG_9P_FS is not set
 
 #
 # Partition Types
@@ -681,8 +771,10 @@ CONFIG_NLS_DEFAULT="iso8859-1"
 #
 # Kernel hacking
 #
+# CONFIG_PRINTK_TIME is not set
+# CONFIG_MAGIC_SYSRQ is not set
 # CONFIG_DEBUG_KERNEL is not set
-CONFIG_DEBUG_PREEMPT=y
+CONFIG_LOG_BUF_SHIFT=14
 # CONFIG_FRAME_POINTER is not set
 # CONFIG_SH_STANDARD_BIOS is not set
 # CONFIG_EARLY_SCIF_CONSOLE is not set
@@ -706,6 +798,7 @@ CONFIG_CRYPTO_MD5=y
 # CONFIG_CRYPTO_SHA256 is not set
 # CONFIG_CRYPTO_SHA512 is not set
 # CONFIG_CRYPTO_WP512 is not set
+# CONFIG_CRYPTO_TGR192 is not set
 CONFIG_CRYPTO_DES=y
 # CONFIG_CRYPTO_BLOWFISH is not set
 # CONFIG_CRYPTO_TWOFISH is not set
@@ -730,5 +823,6 @@ CONFIG_CRYPTO_DES=y
 # Library routines
 #
 # CONFIG_CRC_CCITT is not set
+# CONFIG_CRC16 is not set
 CONFIG_CRC32=y
 # CONFIG_LIBCRC32C is not set
diff --git a/include/asm-sh/microdev.h b/include/asm-sh/microdev.h
new file mode 100644
index 0000000..018332a
--- /dev/null
+++ b/include/asm-sh/microdev.h
@@ -0,0 +1,80 @@
+/*
+ * linux/include/asm-sh/microdev.h
+ *
+ * Copyright (C) 2003 Sean McGoogan (Sean.McGoogan@superh.com)
+ *
+ * Definitions for the SuperH SH4-202 MicroDev board.
+ *
+ * May be copied or modified under the terms of the GNU General Public
+ * License.  See linux/COPYING for more information.
+ */
+#ifndef __ASM_SH_MICRODEV_H
+#define __ASM_SH_MICRODEV_H
+
+extern void init_microdev_irq(void);
+extern void microdev_print_fpga_intc_status(void);
+
+/*
+ * The following are useful macros for manipulating the interrupt
+ * controller (INTC) on the CPU-board FPGA.  should be noted that there
+ * is an INTC on the FPGA, and a seperate INTC on the SH4-202 core -
+ * these are two different things, both of which need to be prorammed to
+ * correctly route - unfortunately, they have the same name and
+ * abbreviations!
+ */
+#define	MICRODEV_FPGA_INTC_BASE		0xa6110000ul				/* INTC base address on CPU-board FPGA */
+#define	MICRODEV_FPGA_INTENB_REG	(MICRODEV_FPGA_INTC_BASE+0ul)		/* Interrupt Enable Register on INTC on CPU-board FPGA */
+#define	MICRODEV_FPGA_INTDSB_REG	(MICRODEV_FPGA_INTC_BASE+8ul)		/* Interrupt Disable Register on INTC on CPU-board FPGA */
+#define	MICRODEV_FPGA_INTC_MASK(n)	(1ul<<(n))				/* Interupt mask to enable/disable INTC in CPU-board FPGA */
+#define	MICRODEV_FPGA_INTPRI_REG(n)	(MICRODEV_FPGA_INTC_BASE+0x10+((n)/8)*8)/* Interrupt Priority Register on INTC on CPU-board FPGA */
+#define	MICRODEV_FPGA_INTPRI_LEVEL(n,x)	((x)<<(((n)%8)*4))			/* MICRODEV_FPGA_INTPRI_LEVEL(int_number, int_level) */
+#define	MICRODEV_FPGA_INTPRI_MASK(n)	(MICRODEV_FPGA_INTPRI_LEVEL((n),0xful))	/* Interrupt Priority Mask on INTC on CPU-board FPGA */
+#define	MICRODEV_FPGA_INTSRC_REG	(MICRODEV_FPGA_INTC_BASE+0x30ul)	/* Interrupt Source Register on INTC on CPU-board FPGA */
+#define	MICRODEV_FPGA_INTREQ_REG	(MICRODEV_FPGA_INTC_BASE+0x38ul)	/* Interrupt Request Register on INTC on CPU-board FPGA */
+
+
+/*
+ * The following are the IRQ numbers for the Linux Kernel for external
+ * interrupts.  i.e. the numbers seen by 'cat /proc/interrupt'.
+ */
+#define MICRODEV_LINUX_IRQ_KEYBOARD	 1	/* SuperIO Keyboard */
+#define MICRODEV_LINUX_IRQ_SERIAL1	 2	/* SuperIO Serial #1 */
+#define MICRODEV_LINUX_IRQ_ETHERNET	 3	/* on-board Ethnernet */
+#define MICRODEV_LINUX_IRQ_SERIAL2	 4	/* SuperIO Serial #2 */
+#define MICRODEV_LINUX_IRQ_USB_HC	 7	/* on-board USB HC */
+#define MICRODEV_LINUX_IRQ_MOUSE	12	/* SuperIO PS/2 Mouse */
+#define MICRODEV_LINUX_IRQ_IDE2		13	/* SuperIO IDE #2 */
+#define MICRODEV_LINUX_IRQ_IDE1		14	/* SuperIO IDE #1 */
+
+/*
+ * The following are the IRQ numbers for the INTC on the FPGA for
+ * external interrupts.  i.e. the bits in the INTC registers in the
+ * FPGA.
+ */
+#define MICRODEV_FPGA_IRQ_KEYBOARD	 1	/* SuperIO Keyboard */
+#define MICRODEV_FPGA_IRQ_SERIAL1	 3	/* SuperIO Serial #1 */
+#define MICRODEV_FPGA_IRQ_SERIAL2	 4	/* SuperIO Serial #2 */
+#define MICRODEV_FPGA_IRQ_MOUSE		12	/* SuperIO PS/2 Mouse */
+#define MICRODEV_FPGA_IRQ_IDE1		14	/* SuperIO IDE #1 */
+#define MICRODEV_FPGA_IRQ_IDE2		15	/* SuperIO IDE #2 */
+#define MICRODEV_FPGA_IRQ_USB_HC	16	/* on-board USB HC */
+#define MICRODEV_FPGA_IRQ_ETHERNET	18	/* on-board Ethnernet */
+
+#define MICRODEV_IRQ_PCI_INTA		 8
+#define MICRODEV_IRQ_PCI_INTB		 9
+#define MICRODEV_IRQ_PCI_INTC		10
+#define MICRODEV_IRQ_PCI_INTD		11
+
+#define __IO_PREFIX microdev
+#include <asm/io_generic.h>
+
+#if defined(CONFIG_PCI)
+unsigned char  microdev_pci_inb(unsigned long port);
+unsigned short microdev_pci_inw(unsigned long port);
+unsigned long  microdev_pci_inl(unsigned long port);
+void           microdev_pci_outb(unsigned char  data, unsigned long port);
+void           microdev_pci_outw(unsigned short data, unsigned long port);
+void           microdev_pci_outl(unsigned long  data, unsigned long port);
+#endif
+
+#endif /* __ASM_SH_MICRODEV_H */
diff --git a/include/asm-sh/microdev/io.h b/include/asm-sh/microdev/io.h
deleted file mode 100644
index f2ca4ac..0000000
--- a/include/asm-sh/microdev/io.h
+++ /dev/null
@@ -1,53 +0,0 @@
-/*
- * linux/include/asm-sh/io_microdev.h
- *
- * Copyright (C) 2003 Sean McGoogan (Sean.McGoogan@superh.com)
- *
- * IO functions for the SuperH SH4-202 MicroDev board.
- *
- * May be copied or modified under the terms of the GNU General Public
- * License.  See linux/COPYING for more information.
- *
- */
-
-
-#ifndef _ASM_SH_IO_MICRODEV_H
-#define _ASM_SH_IO_MICRODEV_H
-
-extern unsigned long microdev_isa_port2addr(unsigned long offset);
-
-extern unsigned char microdev_inb(unsigned long port);
-extern unsigned short microdev_inw(unsigned long port);
-extern unsigned int microdev_inl(unsigned long port);
-
-extern void microdev_outb(unsigned char value, unsigned long port);
-extern void microdev_outw(unsigned short value, unsigned long port);
-extern void microdev_outl(unsigned int value, unsigned long port);
-
-extern unsigned char microdev_inb_p(unsigned long port);
-extern unsigned short microdev_inw_p(unsigned long port);
-extern unsigned int microdev_inl_p(unsigned long port);
-
-extern void microdev_outb_p(unsigned char value, unsigned long port);
-extern void microdev_outw_p(unsigned short value, unsigned long port);
-extern void microdev_outl_p(unsigned int value, unsigned long port);
-
-extern void microdev_insb(unsigned long port, void *addr, unsigned long count);
-extern void microdev_insw(unsigned long port, void *addr, unsigned long count);
-extern void microdev_insl(unsigned long port, void *addr, unsigned long count);
-
-extern void microdev_outsb(unsigned long port, const void *addr, unsigned long count);
-extern void microdev_outsw(unsigned long port, const void *addr, unsigned long count);
-extern void microdev_outsl(unsigned long port, const void *addr, unsigned long count);
-
-#if defined(CONFIG_PCI)
-extern unsigned char  microdev_pci_inb(unsigned long port);
-extern unsigned short microdev_pci_inw(unsigned long port);
-extern unsigned long  microdev_pci_inl(unsigned long port);
-extern void           microdev_pci_outb(unsigned char  data, unsigned long port);
-extern void           microdev_pci_outw(unsigned short data, unsigned long port);
-extern void           microdev_pci_outl(unsigned long  data, unsigned long port);
-#endif
-
-#endif /* _ASM_SH_IO_MICRODEV_H */
-
diff --git a/include/asm-sh/microdev/irq.h b/include/asm-sh/microdev/irq.h
deleted file mode 100644
index 47f6f77..0000000
--- a/include/asm-sh/microdev/irq.h
+++ /dev/null
@@ -1,72 +0,0 @@
-/*
- * linux/include/asm-sh/irq_microdev.h
- *
- * Copyright (C) 2003 Sean McGoogan (Sean.McGoogan@superh.com)
- *
- * IRQ functions for the SuperH SH4-202 MicroDev board.
- *
- * May be copied or modified under the terms of the GNU General Public
- * License.  See linux/COPYING for more information.
- *
- */
-
-
-#ifndef _ASM_SH_IRQ_MICRODEV_H
-#define _ASM_SH_IRQ_MICRODEV_H
-
-extern void init_microdev_irq(void);
-extern void microdev_print_fpga_intc_status(void);
-
-
-	/*
-	 *	The following are useful macros for manipulating the
-	 *	interrupt controller (INTC) on the CPU-board FPGA.
-	 *	It should be noted that there is an INTC on the FPGA,
-	 *	and a seperate INTC on the SH4-202 core - these are
-	 *	two different things, both of which need to be prorammed
-	 *	to correctly route - unfortunately, they have the
-	 *	same name and abbreviations!
-	 */
-#define	MICRODEV_FPGA_INTC_BASE		0xa6110000ul				/* INTC base address on CPU-board FPGA */
-#define	MICRODEV_FPGA_INTENB_REG	(MICRODEV_FPGA_INTC_BASE+0ul)		/* Interrupt Enable Register on INTC on CPU-board FPGA */
-#define	MICRODEV_FPGA_INTDSB_REG	(MICRODEV_FPGA_INTC_BASE+8ul)		/* Interrupt Disable Register on INTC on CPU-board FPGA */
-#define	MICRODEV_FPGA_INTC_MASK(n)	(1ul<<(n))				/* Interupt mask to enable/disable INTC in CPU-board FPGA */
-#define	MICRODEV_FPGA_INTPRI_REG(n)	(MICRODEV_FPGA_INTC_BASE+0x10+((n)/8)*8)/* Interrupt Priority Register on INTC on CPU-board FPGA */
-#define	MICRODEV_FPGA_INTPRI_LEVEL(n,x)	((x)<<(((n)%8)*4))			/* MICRODEV_FPGA_INTPRI_LEVEL(int_number, int_level) */
-#define	MICRODEV_FPGA_INTPRI_MASK(n)	(MICRODEV_FPGA_INTPRI_LEVEL((n),0xful))	/* Interrupt Priority Mask on INTC on CPU-board FPGA */
-#define	MICRODEV_FPGA_INTSRC_REG	(MICRODEV_FPGA_INTC_BASE+0x30ul)	/* Interrupt Source Register on INTC on CPU-board FPGA */
-#define	MICRODEV_FPGA_INTREQ_REG	(MICRODEV_FPGA_INTC_BASE+0x38ul)	/* Interrupt Request Register on INTC on CPU-board FPGA */
-
-
-	/*
-	 *	The following are the IRQ numbers for the Linux Kernel for external interrupts.
-	 *	i.e. the numbers seen by 'cat /proc/interrupt'.
-	 */
-#define MICRODEV_LINUX_IRQ_KEYBOARD	 1	/* SuperIO Keyboard */
-#define MICRODEV_LINUX_IRQ_SERIAL1	 2	/* SuperIO Serial #1 */
-#define MICRODEV_LINUX_IRQ_ETHERNET	 3	/* on-board Ethnernet */
-#define MICRODEV_LINUX_IRQ_SERIAL2	 4	/* SuperIO Serial #2 */
-#define MICRODEV_LINUX_IRQ_USB_HC	 7	/* on-board USB HC */
-#define MICRODEV_LINUX_IRQ_MOUSE	12	/* SuperIO PS/2 Mouse */
-#define MICRODEV_LINUX_IRQ_IDE2		13	/* SuperIO IDE #2 */
-#define MICRODEV_LINUX_IRQ_IDE1		14	/* SuperIO IDE #1 */
-
-	/*
-	 *	The following are the IRQ numbers for the INTC on the FPGA for external interrupts.
-	 *	i.e. the bits in the INTC registers in the FPGA.
-	 */
-#define MICRODEV_FPGA_IRQ_KEYBOARD	 1	/* SuperIO Keyboard */
-#define MICRODEV_FPGA_IRQ_SERIAL1	 3	/* SuperIO Serial #1 */
-#define MICRODEV_FPGA_IRQ_SERIAL2	 4	/* SuperIO Serial #2 */
-#define MICRODEV_FPGA_IRQ_MOUSE		12	/* SuperIO PS/2 Mouse */
-#define MICRODEV_FPGA_IRQ_IDE1		14	/* SuperIO IDE #1 */
-#define MICRODEV_FPGA_IRQ_IDE2		15	/* SuperIO IDE #2 */
-#define MICRODEV_FPGA_IRQ_USB_HC	16	/* on-board USB HC */
-#define MICRODEV_FPGA_IRQ_ETHERNET	18	/* on-board Ethnernet */
-
-#define MICRODEV_IRQ_PCI_INTA		 8
-#define MICRODEV_IRQ_PCI_INTB		 9
-#define MICRODEV_IRQ_PCI_INTC		10
-#define MICRODEV_IRQ_PCI_INTD		11
-
-#endif /* _ASM_SH_IRQ_MICRODEV_H */
