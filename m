Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265001AbUGBVPy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265001AbUGBVPy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 17:15:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265038AbUGBVPy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 17:15:54 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:13986 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S265001AbUGBVM0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 17:12:26 -0400
Date: Fri, 2 Jul 2004 14:12:19 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH][PPC32] Redwood[56] support for smc91x Ethernet driver
Message-ID: <20040702141219.A24135@home.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch for linux-2.5 enables the Redwood 5 and Redwood 6 platforms
to use the smc91x ethernet driver.

Signed-off-by: Dale Farnsworth <dale@farnsworth.org>
Signed-off-by: Matt Porter <mporter@kernel.crashing.org>

 redwood5.c |   34 +++++++++++++++++++++++++++++++++-
 redwood5.h |    1 +
 redwood6.c |   34 ++++++++++++++++++++++++++++++++++
 redwood6.h |    1 +
 4 files changed, 69 insertions(+), 1 deletion(-)

diff -Nru a/arch/ppc/platforms/4xx/redwood5.c b/arch/ppc/platforms/4xx/redwood5.c
--- a/arch/ppc/platforms/4xx/redwood5.c	2004-06-23 06:50:11 -07:00
+++ b/arch/ppc/platforms/4xx/redwood5.c	2004-06-23 06:50:11 -07:00
@@ -14,9 +14,41 @@
 #include <linux/config.h>
 #include <linux/init.h>
 #include <linux/pagemap.h>
+#include <linux/device.h>
+#include <linux/ioport.h>
 #include <asm/io.h>
 #include <asm/machdep.h>
 
+static struct resource smc91x_resources[] = {
+	[0] = {
+		.start	= SMC91111_BASE_ADDR,
+		.end	= SMC91111_BASE_ADDR + SMC91111_REG_SIZE - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= SMC91111_IRQ,
+		.end	= SMC91111_IRQ,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device smc91x_device = {
+	.name		= "smc91x",
+	.id		= 0,
+	.num_resources	= ARRAY_SIZE(smc91x_resources),
+	.resource	= smc91x_resources,
+};
+
+static struct platform_device *redwood5_devs[] __initdata = {
+	&smc91x_device,
+};
+
+static int __init
+redwood5_platform_add_devices(void)
+{
+	return platform_add_devices(redwood5_devs, ARRAY_SIZE(redwood5_devs));
+}
+
 void __init
 redwood5_setup_arch(void)
 {
@@ -44,7 +76,7 @@
 
 	printk("\n");
 #endif
-
+	device_initcall(redwood5_platform_add_devices);
 }
 
 void __init
diff -Nru a/arch/ppc/platforms/4xx/redwood5.h b/arch/ppc/platforms/4xx/redwood5.h
--- a/arch/ppc/platforms/4xx/redwood5.h	2004-06-23 06:50:11 -07:00
+++ b/arch/ppc/platforms/4xx/redwood5.h	2004-06-23 06:50:11 -07:00
@@ -34,6 +34,7 @@
 
 
 #define SMC91111_BASE_ADDR	0xf2000300
+#define SMC91111_REG_SIZE	16
 #define SMC91111_IRQ		28
 
 #ifdef MAX_HWIFS
diff -Nru a/arch/ppc/platforms/4xx/redwood6.c b/arch/ppc/platforms/4xx/redwood6.c
--- a/arch/ppc/platforms/4xx/redwood6.c	2004-06-23 06:50:11 -07:00
+++ b/arch/ppc/platforms/4xx/redwood6.c	2004-06-23 06:50:11 -07:00
@@ -12,6 +12,8 @@
 #include <linux/config.h>
 #include <linux/init.h>
 #include <linux/pagemap.h>
+#include <linux/device.h>
+#include <linux/ioport.h>
 #include <asm/io.h>
 #include <asm/ppc4xx_pic.h>
 #include <linux/delay.h>
@@ -57,6 +59,36 @@
 	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* 31: Ext Int 6 */
 };
 
+static struct resource smc91x_resources[] = {
+	[0] = {
+		.start	= SMC91111_BASE_ADDR,
+		.end	= SMC91111_BASE_ADDR + SMC91111_REG_SIZE - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= SMC91111_IRQ,
+		.end	= SMC91111_IRQ,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device smc91x_device = {
+	.name		= "smc91x",
+	.id		= 0,
+	.num_resources	= ARRAY_SIZE(smc91x_resources),
+	.resource	= smc91x_resources,
+};
+
+static struct platform_device *redwood6_devs[] __initdata = {
+	&smc91x_device,
+};
+
+static int __init
+redwood6_platform_add_devices(void)
+{
+	return platform_add_devices(redwood6_devs, ARRAY_SIZE(redwood6_devs));
+}
+
 
 void __init
 redwood6_setup_arch(void)
@@ -119,6 +151,8 @@
 	printk(KERN_INFO "IBM Redwood6 (STBx25XX) Platform\n");
 	printk(KERN_INFO
 	       "Port by MontaVista Software, Inc. (source@mvista.com)\n");
+
+	device_initcall(redwood6_platform_add_devices);
 }
 
 void __init
diff -Nru a/arch/ppc/platforms/4xx/redwood6.h b/arch/ppc/platforms/4xx/redwood6.h
--- a/arch/ppc/platforms/4xx/redwood6.h	2004-06-23 06:50:11 -07:00
+++ b/arch/ppc/platforms/4xx/redwood6.h	2004-06-23 06:50:11 -07:00
@@ -33,6 +33,7 @@
 #endif				/* !__ASSEMBLY__ */
 
 #define SMC91111_BASE_ADDR	0xf2030300
+#define SMC91111_REG_SIZE	16
 #define SMC91111_IRQ		27
 #define IDE_XLINUX_MUX_BASE        0xf2040000
 #define IDE_DMA_ADDR	0xfce00000

