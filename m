Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262549AbVG2J6d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262549AbVG2J6d (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 05:58:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261948AbVG2J42
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 05:56:28 -0400
Received: from tim.rpsys.net ([194.106.48.114]:6080 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S262554AbVG2Jr1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 05:47:27 -0400
Subject: [patch 7/8] w100fb: Update corgi platform code to match new driver
From: Richard Purdie <rpurdie@rpsys.net>
To: akpm@osdl.org
Cc: adaplas@pol.net, linux-fbdev-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Fri, 29 Jul 2005 10:47:04 +0100
Message-Id: <1122630424.7747.98.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch moves the platform specific Sharp SL-C7x0 LCD code from 
the w100fb driver into a more appropriate place and updates the Corgi
code to match the new w100fb driver.

It also updates the corgi touchscreen code to match the new 
simplified interface available from w100fb.

Signed-off-by: Richard Purdie <rpurdie@rpsys.net>

Index: linux-2.6.12/arch/arm/mach-pxa/Makefile
===================================================================
--- linux-2.6.12.orig/arch/arm/mach-pxa/Makefile	2005-07-28 16:30:52.000000000 +0100
+++ linux-2.6.12/arch/arm/mach-pxa/Makefile	2005-07-28 16:31:07.000000000 +0100
@@ -11,7 +11,7 @@
 obj-$(CONFIG_ARCH_LUBBOCK) += lubbock.o
 obj-$(CONFIG_MACH_MAINSTONE) += mainstone.o
 obj-$(CONFIG_ARCH_PXA_IDP) += idp.o
-obj-$(CONFIG_PXA_SHARP_C7xx)	+= corgi.o corgi_ssp.o ssp.o
+obj-$(CONFIG_PXA_SHARP_C7xx)	+= corgi.o corgi_ssp.o corgi_lcd.o ssp.o
 obj-$(CONFIG_MACH_POODLE)	+= poodle.o
 
 # Support for blinky lights
Index: linux-2.6.12/arch/arm/mach-pxa/corgi.c
===================================================================
--- linux-2.6.12.orig/arch/arm/mach-pxa/corgi.c	2005-07-28 16:30:52.000000000 +0100
+++ linux-2.6.12/arch/arm/mach-pxa/corgi.c	2005-07-28 16:31:07.000000000 +0100
@@ -39,7 +39,6 @@
 
 #include <asm/mach/sharpsl_param.h>
 #include <asm/hardware/scoop.h>
-#include <video/w100fb.h>
 
 #include "generic.h"
 
@@ -78,7 +77,7 @@
  * also use scoop functions and this makes the power up/down order
  * work correctly.
  */
-static struct platform_device corgissp_device = {
+struct platform_device corgissp_device = {
 	.name		= "corgi-ssp",
 	.dev		= {
  		.parent = &corgiscoop_device.dev,
@@ -88,35 +87,6 @@
 
 
 /*
- * Corgi w100 Frame Buffer Device
- */
-static struct w100fb_mach_info corgi_fb_info = {
-	.w100fb_ssp_send 	= corgi_ssp_lcdtg_send,
-	.comadj 			= -1,
-	.phadadj 			= -1,
-};
-
-static struct resource corgi_fb_resources[] = {
-	[0] = {
-		.start		= 0x08000000,
-		.end		= 0x08ffffff,
-		.flags		= IORESOURCE_MEM,
-	},
-};
-
-static struct platform_device corgifb_device = {
-	.name		= "w100fb",
-	.id		= -1,
-	.dev		= {
- 		.platform_data	= &corgi_fb_info,
- 		.parent = &corgissp_device.dev,
-	},
-	.num_resources	= ARRAY_SIZE(corgi_fb_resources),
-	.resource	= corgi_fb_resources,
-};
-
-
-/*
  * Corgi Backlight Device
  */
 static struct platform_device corgibl_device = {
@@ -234,9 +204,6 @@
 
 static void __init corgi_init(void)
 {
-	corgi_fb_info.comadj=sharpsl_param.comadj;
-	corgi_fb_info.phadadj=sharpsl_param.phadadj;
-
 	pxa_gpio_mode(CORGI_GPIO_USB_PULLUP | GPIO_OUT);
  	pxa_set_udc_info(&udc_info);
 	pxa_set_mci_info(&corgi_mci_platform_data);
Index: linux-2.6.12/arch/arm/mach-pxa/corgi_lcd.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.12/arch/arm/mach-pxa/corgi_lcd.c	2005-07-28 16:31:07.000000000 +0100
@@ -0,0 +1,394 @@
+/*
+ * linux/drivers/video/w100fb.c
+ *
+ * Corgi LCD Specific Code for ATI Imageon w100 (Wallaby)
+ *
+ * Copyright (C) 2005 Richard Purdie
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#include <linux/delay.h>
+#include <linux/kernel.h>
+#include <linux/device.h>
+#include <asm/arch/corgi.h>
+#include <asm/mach/sharpsl_param.h> 
+#include <video/w100fb.h>
+
+#define RESCTL_ADRS     0x00
+#define PHACTRL_ADRS	0x01
+#define DUTYCTRL_ADRS	0x02
+#define POWERREG0_ADRS	0x03
+#define POWERREG1_ADRS	0x04
+#define GPOR3_ADRS		0x05
+#define PICTRL_ADRS     0x06
+#define POLCTRL_ADRS    0x07
+
+#define RESCTL_QVGA     0x01
+#define RESCTL_VGA      0x00
+
+#define POWER1_VW_ON    0x01  /* VW Supply FET ON */
+#define POWER1_GVSS_ON  0x02  /* GVSS(-8V) Power Supply ON */
+#define POWER1_VDD_ON   0x04  /* VDD(8V),SVSS(-4V) Power Supply ON */
+
+#define POWER1_VW_OFF   0x00  /* VW Supply FET OFF */
+#define POWER1_GVSS_OFF 0x00  /* GVSS(-8V) Power Supply OFF */
+#define POWER1_VDD_OFF  0x00  /* VDD(8V),SVSS(-4V) Power Supply OFF */
+
+#define POWER0_COM_DCLK 0x01  /* COM Voltage DC Bias DAC Serial Data Clock */
+#define POWER0_COM_DOUT 0x02  /* COM Voltage DC Bias DAC Serial Data Out */
+#define POWER0_DAC_ON   0x04  /* DAC Power Supply ON */
+#define POWER0_COM_ON   0x08  /* COM Powewr Supply ON */
+#define POWER0_VCC5_ON  0x10  /* VCC5 Power Supply ON */
+
+#define POWER0_DAC_OFF  0x00  /* DAC Power Supply OFF */
+#define POWER0_COM_OFF  0x00  /* COM Powewr Supply OFF */
+#define POWER0_VCC5_OFF 0x00  /* VCC5 Power Supply OFF */
+
+#define PICTRL_INIT_STATE      0x01
+#define PICTRL_INIOFF          0x02
+#define PICTRL_POWER_DOWN      0x04
+#define PICTRL_COM_SIGNAL_OFF  0x08
+#define PICTRL_DAC_SIGNAL_OFF  0x10
+
+#define POLCTRL_SYNC_POL_FALL  0x01
+#define POLCTRL_EN_POL_FALL    0x02
+#define POLCTRL_DATA_POL_FALL  0x04
+#define POLCTRL_SYNC_ACT_H     0x08
+#define POLCTRL_EN_ACT_L       0x10
+
+#define POLCTRL_SYNC_POL_RISE  0x00
+#define POLCTRL_EN_POL_RISE    0x00
+#define POLCTRL_DATA_POL_RISE  0x00
+#define POLCTRL_SYNC_ACT_L     0x00
+#define POLCTRL_EN_ACT_H       0x00
+
+#define PHACTRL_PHASE_MANUAL   0x01
+#define DEFAULT_PHAD_QVGA     (9)
+#define DEFAULT_COMADJ        (125)
+
+/*
+ * This is only a psuedo I2C interface. We can't use the standard kernel
+ * routines as the interface is write only. We just assume the data is acked...
+ */
+static void lcdtg_ssp_i2c_send(uint8_t data)
+{
+	corgi_ssp_lcdtg_send(POWERREG0_ADRS, data);
+	udelay(10);
+}
+
+static void lcdtg_i2c_send_bit(uint8_t data)
+{
+	lcdtg_ssp_i2c_send(data);
+	lcdtg_ssp_i2c_send(data | POWER0_COM_DCLK);
+	lcdtg_ssp_i2c_send(data);
+}
+
+static void lcdtg_i2c_send_start(uint8_t base)
+{
+	lcdtg_ssp_i2c_send(base | POWER0_COM_DCLK | POWER0_COM_DOUT);
+	lcdtg_ssp_i2c_send(base | POWER0_COM_DCLK);
+	lcdtg_ssp_i2c_send(base);
+}
+
+static void lcdtg_i2c_send_stop(uint8_t base)
+{
+	lcdtg_ssp_i2c_send(base);
+	lcdtg_ssp_i2c_send(base | POWER0_COM_DCLK);
+	lcdtg_ssp_i2c_send(base | POWER0_COM_DCLK | POWER0_COM_DOUT);
+}
+
+static void lcdtg_i2c_send_byte(uint8_t base, uint8_t data)
+{
+	int i;
+	for (i = 0; i < 8; i++) {
+		if (data & 0x80)
+			lcdtg_i2c_send_bit(base | POWER0_COM_DOUT);
+		else
+			lcdtg_i2c_send_bit(base);
+		data <<= 1;
+	}
+}
+
+static void lcdtg_i2c_wait_ack(uint8_t base)
+{
+	lcdtg_i2c_send_bit(base);
+}
+
+static void lcdtg_set_common_voltage(uint8_t base_data, uint8_t data)
+{
+	/* Set Common Voltage to M62332FP via I2C */
+	lcdtg_i2c_send_start(base_data);
+	lcdtg_i2c_send_byte(base_data, 0x9c);
+	lcdtg_i2c_wait_ack(base_data);
+	lcdtg_i2c_send_byte(base_data, 0x00);
+	lcdtg_i2c_wait_ack(base_data);
+	lcdtg_i2c_send_byte(base_data, data);
+	lcdtg_i2c_wait_ack(base_data);
+	lcdtg_i2c_send_stop(base_data);
+}
+
+/* Set Phase Adjuct */
+static void lcdtg_set_phadadj(struct w100fb_par *par)
+{
+	int adj;
+	switch(par->xres) {
+		case 480:
+		case 640:
+			/* Setting for VGA */
+			adj = sharpsl_param.phadadj;
+			if (adj < 0) {
+				adj = PHACTRL_PHASE_MANUAL;
+			} else {
+				adj = ((adj & 0x0f) << 1) | PHACTRL_PHASE_MANUAL;
+			}
+			break;
+		case 240:
+		case 320:
+		default:
+			/* Setting for QVGA */
+			adj = (DEFAULT_PHAD_QVGA << 1) | PHACTRL_PHASE_MANUAL;
+			break;
+	}
+	
+	corgi_ssp_lcdtg_send(PHACTRL_ADRS, adj);
+}
+
+static int lcd_inited;
+
+static void lcdtg_hw_init(struct w100fb_par *par)
+{
+	if (!lcd_inited) {
+		int comadj;
+
+		/* Initialize Internal Logic & Port */
+		corgi_ssp_lcdtg_send(PICTRL_ADRS, PICTRL_POWER_DOWN | PICTRL_INIOFF | PICTRL_INIT_STATE
+	  			| PICTRL_COM_SIGNAL_OFF | PICTRL_DAC_SIGNAL_OFF);
+
+		corgi_ssp_lcdtg_send(POWERREG0_ADRS, POWER0_COM_DCLK | POWER0_COM_DOUT | POWER0_DAC_OFF 
+				| POWER0_COM_OFF | POWER0_VCC5_OFF);
+
+		corgi_ssp_lcdtg_send(POWERREG1_ADRS, POWER1_VW_OFF | POWER1_GVSS_OFF | POWER1_VDD_OFF);
+
+		/* VDD(+8V), SVSS(-4V) ON */
+		corgi_ssp_lcdtg_send(POWERREG1_ADRS, POWER1_VW_OFF | POWER1_GVSS_OFF | POWER1_VDD_ON); 
+		mdelay(3);
+
+		/* DAC ON */
+		corgi_ssp_lcdtg_send(POWERREG0_ADRS, POWER0_COM_DCLK | POWER0_COM_DOUT | POWER0_DAC_ON
+				| POWER0_COM_OFF | POWER0_VCC5_OFF);
+
+		/* INIB = H, INI = L  */
+		/* PICTL[0] = H , PICTL[1] = PICTL[2] = PICTL[4] = L */
+		corgi_ssp_lcdtg_send(PICTRL_ADRS, PICTRL_INIT_STATE | PICTRL_COM_SIGNAL_OFF);
+
+		/* Set Common Voltage */
+		comadj = sharpsl_param.comadj;
+		if (comadj < 0) 
+			comadj = DEFAULT_COMADJ;
+		lcdtg_set_common_voltage((POWER0_DAC_ON | POWER0_COM_OFF | POWER0_VCC5_OFF), comadj);
+
+		/* VCC5 ON, DAC ON */
+		corgi_ssp_lcdtg_send(POWERREG0_ADRS, POWER0_COM_DCLK | POWER0_COM_DOUT | POWER0_DAC_ON |
+				POWER0_COM_OFF | POWER0_VCC5_ON); 
+
+		/* GVSS(-8V) ON, VDD ON */
+		corgi_ssp_lcdtg_send(POWERREG1_ADRS, POWER1_VW_OFF | POWER1_GVSS_ON | POWER1_VDD_ON);
+		mdelay(2);
+
+		/* COM SIGNAL ON (PICTL[3] = L) */
+		corgi_ssp_lcdtg_send(PICTRL_ADRS, PICTRL_INIT_STATE);
+
+		/* COM ON, DAC ON, VCC5_ON */
+		corgi_ssp_lcdtg_send(POWERREG0_ADRS, POWER0_COM_DCLK | POWER0_COM_DOUT | POWER0_DAC_ON
+				| POWER0_COM_ON | POWER0_VCC5_ON);
+
+		/* VW ON, GVSS ON, VDD ON */
+		corgi_ssp_lcdtg_send(POWERREG1_ADRS, POWER1_VW_ON | POWER1_GVSS_ON | POWER1_VDD_ON);
+
+		/* Signals output enable */
+		corgi_ssp_lcdtg_send(PICTRL_ADRS, 0);
+
+		/* Set Phase Adjuct */
+		lcdtg_set_phadadj(par);
+
+		/* Initialize for Input Signals from ATI */
+		corgi_ssp_lcdtg_send(POLCTRL_ADRS, POLCTRL_SYNC_POL_RISE | POLCTRL_EN_POL_RISE 
+				| POLCTRL_DATA_POL_RISE | POLCTRL_SYNC_ACT_L | POLCTRL_EN_ACT_H);
+		udelay(1000);
+		
+		lcd_inited=1;
+	} else {
+		lcdtg_set_phadadj(par);
+	}
+	
+	switch(par->xres) {
+		case 480:
+		case 640:
+			/* Set Lcd Resolution (VGA) */
+			corgi_ssp_lcdtg_send(RESCTL_ADRS, RESCTL_VGA);
+			break;
+		case 240:
+		case 320:	
+		default:
+			/* Set Lcd Resolution (QVGA) */
+			corgi_ssp_lcdtg_send(RESCTL_ADRS, RESCTL_QVGA);
+			break;
+	}
+}
+
+static void lcdtg_suspend(struct w100fb_par *par)
+{
+	/* 60Hz x 2 frame = 16.7msec x 2 = 33.4 msec */
+	mdelay(34);
+
+	/* (1)VW OFF */
+	corgi_ssp_lcdtg_send(POWERREG1_ADRS, POWER1_VW_OFF | POWER1_GVSS_ON | POWER1_VDD_ON);
+
+	/* (2)COM OFF */
+	corgi_ssp_lcdtg_send(PICTRL_ADRS, PICTRL_COM_SIGNAL_OFF);
+	corgi_ssp_lcdtg_send(POWERREG0_ADRS, POWER0_DAC_ON | POWER0_COM_OFF | POWER0_VCC5_ON);
+
+	/* (3)Set Common Voltage Bias 0V */
+	lcdtg_set_common_voltage(POWER0_DAC_ON | POWER0_COM_OFF | POWER0_VCC5_ON, 0);
+
+	/* (4)GVSS OFF */
+	corgi_ssp_lcdtg_send(POWERREG1_ADRS, POWER1_VW_OFF | POWER1_GVSS_OFF | POWER1_VDD_ON);
+
+	/* (5)VCC5 OFF */
+	corgi_ssp_lcdtg_send(POWERREG0_ADRS, POWER0_DAC_ON | POWER0_COM_OFF | POWER0_VCC5_OFF);
+
+	/* (6)Set PDWN, INIOFF, DACOFF */
+	corgi_ssp_lcdtg_send(PICTRL_ADRS, PICTRL_INIOFF | PICTRL_DAC_SIGNAL_OFF |
+			PICTRL_POWER_DOWN | PICTRL_COM_SIGNAL_OFF);
+
+	/* (7)DAC OFF */
+	corgi_ssp_lcdtg_send(POWERREG0_ADRS, POWER0_DAC_OFF | POWER0_COM_OFF | POWER0_VCC5_OFF);
+
+	/* (8)VDD OFF */
+	corgi_ssp_lcdtg_send(POWERREG1_ADRS, POWER1_VW_OFF | POWER1_GVSS_OFF | POWER1_VDD_OFF);
+	
+	lcd_inited = 0;
+}
+
+static struct w100_tg_info corgi_lcdtg_info = {
+	.change=lcdtg_hw_init,
+	.suspend=lcdtg_suspend,
+	.resume=lcdtg_hw_init,
+};
+
+/*
+ * Corgi w100 Frame Buffer Device
+ */
+
+static struct w100_mem_info corgi_fb_mem = {
+	.ext_cntl          = 0x00040003,
+	.sdram_mode_reg    = 0x00650021,
+	.ext_timing_cntl   = 0x10002a4a,
+	.io_cntl           = 0x7ff87012,
+	.size              = 0x1fffff,
+};
+
+static struct w100_gen_regs corgi_fb_regs = {
+	.lcd_format    = 0x00000003,
+	.lcdd_cntl1    = 0x01CC0000,
+	.lcdd_cntl2    = 0x0003FFFF,
+	.genlcd_cntl1  = 0x00FFFF0D,
+	.genlcd_cntl2  = 0x003F3003,
+	.genlcd_cntl3  = 0x000102aa,
+};
+	
+static struct w100_gpio_regs corgi_fb_gpio = {	
+	.init_data1   = 0x000000bf,
+	.init_data2   = 0x00000000,
+	.gpio_dir1    = 0x00000000,
+	.gpio_oe1     = 0x03c0feff,
+	.gpio_dir2    = 0x00000000,
+	.gpio_oe2     = 0x00000000,
+};
+
+static struct w100_mode corgi_fb_modes[] = {
+{
+	.xres            = 480,
+	.yres            = 640,
+	.left_margin     = 0x56,
+	.right_margin    = 0x55,
+	.upper_margin    = 0x03,
+	.lower_margin    = 0x00,
+	.crtc_ss         = 0x82360056,
+	.crtc_ls         = 0xA0280000,
+	.crtc_gs         = 0x80280028,
+	.crtc_vpos_gs    = 0x02830002,
+	.crtc_rev        = 0x00400008,
+	.crtc_dclk       = 0xA0000000,
+	.crtc_gclk       = 0x8015010F,
+	.crtc_goe        = 0x80100110,
+	.crtc_ps1_active = 0x41060010,
+	.pll_freq        = 75,
+	.fast_pll_freq   = 100,
+	.sysclk_src      = CLK_SRC_PLL,
+	.sysclk_divider  = 0,
+	.pixclk_src      = CLK_SRC_PLL,
+	.pixclk_divider  = 2,
+	.pixclk_divider_rotated = 6,
+},{
+	.xres            = 240,
+	.yres            = 320,
+	.left_margin     = 0x27,
+	.right_margin    = 0x2e,
+	.upper_margin    = 0x01,
+	.lower_margin    = 0x00,
+	.crtc_ss         = 0x81170027,
+	.crtc_ls         = 0xA0140000,
+	.crtc_gs         = 0xC0140014,
+	.crtc_vpos_gs    = 0x00010141,
+	.crtc_rev        = 0x00400008,
+	.crtc_dclk       = 0xA0000000,
+	.crtc_gclk       = 0x8015010F,
+	.crtc_goe        = 0x80100110,
+	.crtc_ps1_active = 0x41060010,
+	.pll_freq        = 0,
+	.fast_pll_freq   = 0,
+	.sysclk_src      = CLK_SRC_XTAL,
+	.sysclk_divider  = 0,
+	.pixclk_src      = CLK_SRC_XTAL,
+	.pixclk_divider  = 1,
+	.pixclk_divider_rotated = 1,	
+},
+
+};
+
+static struct w100fb_mach_info corgi_fb_info = {
+	.tg         = &corgi_lcdtg_info,
+	.init_mode  = INIT_MODE_ROTATED,
+	.mem        = &corgi_fb_mem,
+	.regs       = &corgi_fb_regs,
+	.modelist   = &corgi_fb_modes[0],
+	.num_modes  = 2,
+	.gpio       = &corgi_fb_gpio,
+	.xtal_freq  = 12500000,
+	.xtal_dbl   = 0,
+};
+
+static struct resource corgi_fb_resources[] = {
+	[0] = {
+		.start   = 0x08000000,
+		.end     = 0x08ffffff,
+		.flags   = IORESOURCE_MEM,
+	},
+};
+
+struct platform_device corgifb_device = {
+	.name           = "w100fb",
+	.id             = -1,
+	.num_resources	= ARRAY_SIZE(corgi_fb_resources),
+	.resource	= corgi_fb_resources,
+	.dev            = {
+ 		.platform_data = &corgi_fb_info,
+ 		.parent = &corgissp_device.dev,
+	},
+
+};
Index: linux-2.6.12/drivers/input/touchscreen/corgi_ts.c
===================================================================
--- linux-2.6.12.orig/drivers/input/touchscreen/corgi_ts.c	2005-07-28 16:30:52.000000000 +0100
+++ linux-2.6.12/drivers/input/touchscreen/corgi_ts.c	2005-07-28 16:31:07.000000000 +0100
@@ -56,9 +56,6 @@
 #define PMNC_GET(x)	asm volatile ("mrc p14, 0, %0, C0, C0, 0" : "=r"(x))
 #define PMNC_SET(x)	asm volatile ("mcr p14, 0, %0, C0, C0, 0" : : "r"(x))
 
-#define WAIT_HS_400_VGA		7013U	// 17.615us
-#define WAIT_HS_400_QVGA	16622U	// 41.750us
-
 
 /* ADS7846 Touch Screen Controller bit definitions */
 #define ADSCTRL_PD0		(1u << 0)	/* PD0 */
@@ -69,32 +66,17 @@
 #define ADSCTRL_STS		(1u << 7)	/* Start Bit */
 
 /* External Functions */
-extern int w100fb_get_xres(void);
-extern int w100fb_get_blanking(void);
-extern int w100fb_get_fastsysclk(void);
+extern unsigned long w100fb_get_hsynclen(struct device *dev);
 extern unsigned int get_clk_frequency_khz(int info);
 
 static unsigned long calc_waittime(void)
 {
-	int w100fb_xres = w100fb_get_xres();
-	unsigned int waittime = 0;
+	unsigned long hsync_len = w100fb_get_hsynclen(&corgifb_device.dev);
 
-	if (w100fb_get_blanking())
+	if (hsync_len) 
+		return get_clk_frequency_khz(0)*1000/hsync_len;
+	else
 		return 0;
-
-	if (w100fb_xres == 480 || w100fb_xres == 640) {
-		waittime = WAIT_HS_400_VGA * get_clk_frequency_khz(0) / 398131U;
-
-		if (w100fb_get_fastsysclk() == 100)
-			waittime = waittime * 75 / 100;
-
-		if (w100fb_xres == 640)
-			waittime *= 3;
-
-		return waittime;
-	}
-
-	return WAIT_HS_400_QVGA * get_clk_frequency_khz(0) / 398131U;
 }
 
 static int sync_receive_data_send_cmd(int doRecive, int doSend, unsigned int address, unsigned long wait_time)
Index: linux-2.6.12/include/asm-arm/arch-pxa/corgi.h
===================================================================
--- linux-2.6.12.orig/include/asm-arm/arch-pxa/corgi.h	2005-07-28 16:30:52.000000000 +0100
+++ linux-2.6.12/include/asm-arm/arch-pxa/corgi.h	2005-07-28 16:31:07.000000000 +0100
@@ -103,18 +103,20 @@
  * Shared data structures
  */
 extern struct platform_device corgiscoop_device;
+extern struct platform_device corgissp_device;
+extern struct platform_device corgifb_device;
 
 /*
  * External Functions
  */
 extern unsigned long corgi_ssp_ads7846_putget(unsigned long);
 extern unsigned long corgi_ssp_ads7846_get(void);
-extern void corgi_ssp_ads7846_put(ulong data);
+extern void corgi_ssp_ads7846_put(unsigned long data);
 extern void corgi_ssp_ads7846_lock(void);
 extern void corgi_ssp_ads7846_unlock(void);
-extern void corgi_ssp_lcdtg_send (u8 adrs, u8 data);
+extern void corgi_ssp_lcdtg_send (unsigned char adrs, unsigned char data);
 extern void corgi_ssp_blduty_set(int duty);
-extern int corgi_ssp_max1111_get(ulong data);
+extern int corgi_ssp_max1111_get(unsigned long data);
 
 #endif /* __ASM_ARCH_CORGI_H  */
 


