Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964924AbWBGEXB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964924AbWBGEXB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 23:23:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964970AbWBGEXB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 23:23:01 -0500
Received: from smtp108.sbc.mail.mud.yahoo.com ([68.142.198.207]:61317 "HELO
	smtp108.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S964924AbWBGEXA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 23:23:00 -0500
From: David Brownell <david-b@pacbell.net>
To: linux-kernel@vger.kernel.org, stephen@streetfiresound.com
Subject: [PATCH] pxa2xx_spi, board support for Lubbock
Date: Mon, 6 Feb 2006 20:22:51 -0800
User-Agent: KMail/1.7.1
Cc: dvrabel@arcom.com, Nicolas Pitre <nico@cam.org>
References: <43e80ec3.oEr+gtyMVtunRTyE%stephen@streetfiresound.com>
In-Reply-To: <43e80ec3.oEr+gtyMVtunRTyE%stephen@streetfiresound.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_bCC6Dasy8ZIAsOT"
Message-Id: <200602062022.51845.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_bCC6Dasy8ZIAsOT
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Building on Stephen's patch, here is board support for
one of the reference pxa25x development platforms.  To
use this you will want some ads7846 patches ... I think
they're now in Dmitry's input queue (or ask me).

This is against 2.6.16-rc2 ... now I get some tabletop
space back!  :)

- Dave


--Boundary-00=_bCC6Dasy8ZIAsOT
Content-Type: text/x-diff;
  charset="utf-8";
  name="lubbock-spi.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="lubbock-spi.patch"

Lubbock update for SPI support: declare the SSP controller and ADS7846 device.
This is only lightly tested, since my board doesn't populate J5 ... this seems
to behave for access to the temperature sensors, but there's no way to hook up
the touchscreen and use that.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>


--- lubbock.orig/arch/arm/mach-pxa/lubbock.c	2006-02-05 21:49:53.000000000 -0800
+++ lubbock/arch/arm/mach-pxa/lubbock.c	2006-02-05 22:29:05.000000000 -0800
@@ -22,6 +22,10 @@
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
 
+#include <linux/spi/spi.h>
+#include <linux/spi/ads7846.h>
+#include <asm/arch/pxa2xx_spi.h>
+
 #include <asm/setup.h>
 #include <asm/memory.h>
 #include <asm/mach-types.h>
@@ -196,6 +200,71 @@ static struct resource smc91x_resources[
 	},
 };
 
+/* ADS7846 is connected through SSP ... and if your board has J5 populated,
+ * you can select it to replace the ucb1400 by switching the touchscreen cable
+ * (to J5) and poking board registers (as done below).  Else it's only usable
+ * for the temperature sensors.
+ */
+static struct resource pxa_ssp_resources[] = {
+	[0] = {
+		.start	= __PREG(SSCR0_P(1)),
+		.end	= __PREG(SSCR0_P(1)) + 0x14,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= IRQ_SSP,
+		.end	= IRQ_SSP,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct pxa2xx_spi_master pxa_ssp_master_info = {
+	.ssp_type	= PXA25x_SSP,
+	.clock_enable	= CKEN3_SSP,
+	.num_chipselect	= 0,
+};
+
+static struct platform_device pxa_ssp = {
+	.name		= "pxa2xx-spi",
+	.id		= 1,
+	.resource	= pxa_ssp_resources,
+	.num_resources	= ARRAY_SIZE(pxa_ssp_resources),
+	.dev = {
+		.platform_data	= &pxa_ssp_master_info,
+	},
+}; 
+
+static struct ads7846_platform_data ads_info = {
+	.model			= 7846,
+	.vref_delay_usecs	= 100,		/* internal, no cap */
+
+	.x_plate_ohms		= 500,	/* GUESS! */
+	.y_plate_ohms		= 500,	/* GUESS! */
+};
+
+static void ads7846_cs(u32 command)
+{
+	static const unsigned	TS_nCS = 1 << 11;
+	lubbock_set_misc_wr(TS_nCS, (command == PXA2XX_CS_ASSERT) ? 0 : TS_nCS);
+}
+
+static struct pxa2xx_spi_chip ads_hw = {
+	.tx_threshold		= 1,
+	.rx_threshold		= 2,
+	.cs_control		= ads7846_cs,
+};
+
+static struct spi_board_info spi_board_info[] __initdata = { {
+	.modalias	= "ads7846",
+	.platform_data	= &ads_info,
+	.controller_data = &ads_hw,
+	.irq		= LUBBOCK_BB_IRQ,
+	.max_speed_hz	= 120000 /* max sample rate at 3V */ * 16,
+	.bus_num	= 1,
+	.chip_select	= 0,
+},
+};
+
 static struct platform_device smc91x_device = {
 	.name		= "smc91x",
 	.id		= -1,
@@ -272,6 +341,7 @@ static struct platform_device *devices[]
 	&smc91x_device,
 	&lubbock_flash_device[0],
 	&lubbock_flash_device[1],
+	&pxa_ssp,
 };
 
 static struct pxafb_mach_info sharp_lm8v31 __initdata = {
@@ -400,6 +470,8 @@ static void __init lubbock_init(void)
 	lubbock_flash_data[flashboot^1].name = "application-flash";
 	lubbock_flash_data[flashboot].name = "boot-rom";
 	(void) platform_add_devices(devices, ARRAY_SIZE(devices));
+
+	spi_register_board_info(spi_board_info, ARRAY_SIZE(spi_board_info));
 }
 
 static struct map_desc lubbock_io_desc[] __initdata = {
@@ -416,6 +488,11 @@ static void __init lubbock_map_io(void)
 	pxa_map_io();
 	iotable_init(lubbock_io_desc, ARRAY_SIZE(lubbock_io_desc));
 
+	/* SSP data pins */
+	pxa_gpio_mode(GPIO23_SCLK_MD);
+	pxa_gpio_mode(GPIO25_STXD_MD);
+	pxa_gpio_mode(GPIO26_SRXD_MD);
+
 	/* This enables the BTUART */
 	pxa_gpio_mode(GPIO42_BTRXD_MD);
 	pxa_gpio_mode(GPIO43_BTTXD_MD);

--Boundary-00=_bCC6Dasy8ZIAsOT--
