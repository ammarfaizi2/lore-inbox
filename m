Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751431AbVKAXYG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751431AbVKAXYG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 18:24:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751428AbVKAXYG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 18:24:06 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:20151 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751429AbVKAXYF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 18:24:05 -0500
Date: Wed, 2 Nov 2005 00:23:17 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@osdl.org>, rpurdie@rpsys.net, lenz@cs.wisc.edu,
       kernel list <linux-kernel@vger.kernel.org>,
       Russell King <rmk@arm.linux.org.uk>
Subject: [patch] collie: enable serial and pcmcia support
Message-ID: <20051101232317.GA27355@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Enable pcmcia and serial support on sharp zaurus sl-5500.

Signed-off-by: Pavel Machek <pavel@suse.cz>

---
commit 8ab89cd19ec120410f6d259348d4ce8a5848fd7f
tree 905227facbe1ef86f6ac5459a7ce0a0538ee3fd0
parent dc507abbd6658927bdef7a521c4aa16c511ec62f
author <pavel@amd.(none)> Wed, 02 Nov 2005 00:22:38 +0100
committer <pavel@amd.(none)> Wed, 02 Nov 2005 00:22:38 +0100

 arch/arm/mach-sa1100/collie.c |   97 ++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 95 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-sa1100/collie.c b/arch/arm/mach-sa1100/collie.c
--- a/arch/arm/mach-sa1100/collie.c
+++ b/arch/arm/mach-sa1100/collie.c
@@ -11,7 +11,7 @@
  * published by the Free Software Foundation.
  *
  * ChangeLog:
- *  03-06-2004 John Lenz <jelenz@wisc.edu>
+ *  03-06-2004 John Lenz <lenz@cs.wisc.edu>
  *  06-04-2002 Chris Larson <kergoth@digitalnemesis.net>
  *  04-16-2001 Lineo Japan,Inc. ...
  */
@@ -40,6 +40,7 @@
 #include <asm/hardware/scoop.h>
 #include <asm/mach/sharpsl_param.h>
 #include <asm/hardware/locomo.h>
+#include <asm/arch/mcp.h>
 
 #include "generic.h"
 
@@ -66,6 +67,88 @@ struct platform_device colliescoop_devic
 	.resource	= collie_scoop_resources,
 };
 
+static struct scoop_pcmcia_dev collie_pcmcia_scoop[] = {
+{
+       .dev        = &colliescoop_device.dev,
+       .irq        = COLLIE_IRQ_GPIO_CF_IRQ,
+       .cd_irq     = COLLIE_IRQ_GPIO_CF_CD,
+       .cd_irq_str = "PCMCIA0 CD",
+},
+};
+
+static struct mcp_plat_data collie_mcp_data = {
+	.mccr0          = MCCR0_ADM,
+	.sclk_rate      = 11981000,
+};
+
+#ifdef CONFIG_SHARP_LOCOMO
+/*
+ * low-level UART features.
+ */
+static struct locomo_dev *uart_dev = NULL;
+
+static void collie_uart_set_mctrl(struct uart_port *port, u_int mctrl)
+{
+ 	if (!uart_dev) return;
+	
+ 	if (mctrl & TIOCM_RTS)
+		locomo_gpio_write(uart_dev, LOCOMO_GPIO_RTS, 0);
+ 	else
+		locomo_gpio_write(uart_dev, LOCOMO_GPIO_RTS, 1);
+	
+ 	if (mctrl & TIOCM_DTR)
+		locomo_gpio_write(uart_dev, LOCOMO_GPIO_DTR, 0);
+ 	else
+		locomo_gpio_write(uart_dev, LOCOMO_GPIO_DTR, 1);
+}
+ 
+static u_int collie_uart_get_mctrl(struct uart_port *port)
+{
+	int ret = TIOCM_CD;
+	unsigned int r;
+	if (!uart_dev) return ret;
+
+	r = locomo_gpio_read_output(uart_dev, LOCOMO_GPIO_CTS & LOCOMO_GPIO_DSR);
+	if (r & LOCOMO_GPIO_CTS)
+		ret |= TIOCM_CTS;
+	if (r & LOCOMO_GPIO_DSR)
+		ret |= TIOCM_DSR;
+
+	return ret;
+}
+
+static struct sa1100_port_fns collie_port_fns __initdata = {
+	.set_mctrl	= collie_uart_set_mctrl,
+	.get_mctrl	= collie_uart_get_mctrl,
+};
+
+static int collie_uart_probe(struct locomo_dev *dev)
+{
+	uart_dev = dev;
+	return 0;
+}
+
+static int collie_uart_remove(struct locomo_dev *dev)
+{
+	uart_dev = NULL;
+	return 0;
+}
+
+static struct locomo_driver collie_uart_driver = {
+	.drv = {
+		.name = "collie_uart",
+	},
+	.devid	= LOCOMO_DEVID_UART,
+	.probe	= collie_uart_probe,
+	.remove	= collie_uart_remove,
+}; 
+
+static int __init collie_uart_init(void) {
+	return locomo_driver_register(&collie_uart_driver);
+}
+device_initcall(collie_uart_init);
+
+#endif
 
 static struct resource locomo_resources[] = {
 	[0] = {
@@ -119,7 +202,7 @@ static void collie_set_vpp(int vpp)
 }
 
 static struct flash_platform_data collie_flash_data = {
-	.map_name	= "cfi_probe",
+	.map_name	= "sharp",
 	.set_vpp	= collie_set_vpp,
 	.parts		= collie_partitions,
 	.nr_parts	= ARRAY_SIZE(collie_partitions),
@@ -159,6 +242,9 @@ static void __init collie_init(void)
 	GPDR |= GPIO_32_768kHz;
 	TUCR  = TUCR_32_768kHz;
 
+	scoop_num = 1;
+	scoop_devs = &collie_pcmcia_scoop[0];
+
 	ret = platform_add_devices(devices, ARRAY_SIZE(devices));
 	if (ret) {
 		printk(KERN_WARNING "collie: Unable to register LoCoMo device\n");
@@ -166,6 +252,7 @@ static void __init collie_init(void)
 
 	sa11x0_set_flash_data(&collie_flash_data, collie_flash_resources,
 			      ARRAY_SIZE(collie_flash_resources));
+	sa11x0_set_mcp_data(&collie_mcp_data);
 
 	sharpsl_save_param();
 }
@@ -188,6 +275,12 @@ static void __init collie_map_io(void)
 {
 	sa1100_map_io();
 	iotable_init(collie_io_desc, ARRAY_SIZE(collie_io_desc));
+
+#ifdef CONFIG_SHARP_LOCOMO
+	sa1100_register_uart_fns(&collie_port_fns);
+#endif
+	sa1100_register_uart(0, 3);
+	sa1100_register_uart(1, 1);
 }
 
 MACHINE_START(COLLIE, "Sharp-Collie")

-- 
Thanks, Sharp!
