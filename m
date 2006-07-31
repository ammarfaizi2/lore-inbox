Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932348AbWGaOdM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932348AbWGaOdM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 10:33:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932363AbWGaOdM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 10:33:12 -0400
Received: from smtp107.sbc.mail.mud.yahoo.com ([68.142.198.206]:53336 "HELO
	smtp107.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932348AbWGaOdM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 10:33:12 -0400
From: David Brownell <david-b@pacbell.net>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: [patch 2.6.18-rc3] build fixes:  omap-rng
Date: Mon, 31 Jul 2006 07:24:44 -0700
User-Agent: KMail/1.7.1
Cc: Michael Buesch <mb@bu3sch.de>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_sKhzEOBQvWhyxFv"
Message-Id: <200607310724.44928.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_sKhzEOBQvWhyxFv
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

The linux-omap tree has the old version, which doesn't have these
build errors but doesn't use the new RNG framework code ... note
that this driver seems new to 2.6.18 kernels.




--Boundary-00=_sKhzEOBQvWhyxFv
Content-Type: text/x-diff;
  charset="us-ascii";
  name="omap-rng.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="omap-rng.patch"

Seems like the omap-rng driver in the main tree predates the switch
from <asm/hardware/clock.h> to <linux/clk.h> ... now it builds OK.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>


Index: o26/drivers/char/hw_random/omap-rng.c
===================================================================
--- o26.orig/drivers/char/hw_random/omap-rng.c	2006-07-30 22:08:58.000000000 -0700
+++ o26/drivers/char/hw_random/omap-rng.c	2006-07-31 04:38:58.000000000 -0700
@@ -25,12 +25,12 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/random.h>
+#include <linux/clk.h>
 #include <linux/err.h>
-#include <linux/device.h>
+#include <linux/platform_device.h>
 #include <linux/hw_random.h>
 
 #include <asm/io.h>
-#include <asm/hardware/clock.h>
 
 #define RNG_OUT_REG		0x00		/* Output register */
 #define RNG_STAT_REG		0x04		/* Status register
@@ -52,7 +52,7 @@
 
 static void __iomem *rng_base;
 static struct clk *rng_ick;
-static struct device *rng_dev;
+static struct platform_device *rng_dev;
 
 static u32 omap_rng_read_reg(int reg)
 {
@@ -83,9 +83,8 @@ static struct hwrng omap_rng_ops = {
 	.data_read	= omap_rng_data_read,
 };
 
-static int __init omap_rng_probe(struct device *dev)
+static int __init omap_rng_probe(struct platform_device *pdev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
 	struct resource *res, *mem;
 	int ret;
 
@@ -95,16 +94,14 @@ static int __init omap_rng_probe(struct 
 	 */
 	BUG_ON(rng_dev);
 
-    	if (cpu_is_omap24xx()) {
+	if (cpu_is_omap24xx()) {
 		rng_ick = clk_get(NULL, "rng_ick");
 		if (IS_ERR(rng_ick)) {
-			dev_err(dev, "Could not get rng_ick\n");
+			dev_err(&pdev->dev, "Could not get rng_ick\n");
 			ret = PTR_ERR(rng_ick);
 			return ret;
-		}
-		else {
-			clk_use(rng_ick);
-		}
+		} else
+			clk_enable(rng_ick);
 	}
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -117,7 +114,7 @@ static int __init omap_rng_probe(struct 
 	if (mem == NULL)
 		return -EBUSY;
 
-	dev_set_drvdata(dev, mem);
+	dev_set_drvdata(&pdev->dev, mem);
 	rng_base = (u32 __iomem *)io_p2v(res->start);
 
 	ret = hwrng_register(&omap_rng_ops);
@@ -127,25 +124,25 @@ static int __init omap_rng_probe(struct 
 		return ret;
 	}
 
-	dev_info(dev, "OMAP Random Number Generator ver. %02x\n",
+	dev_info(&pdev->dev, "OMAP Random Number Generator ver. %02x\n",
 		omap_rng_read_reg(RNG_REV_REG));
 	omap_rng_write_reg(RNG_MASK_REG, 0x1);
 
-	rng_dev = dev;
+	rng_dev = pdev;
 
 	return 0;
 }
 
-static int __exit omap_rng_remove(struct device *dev)
+static int __exit omap_rng_remove(struct platform_device *pdev)
 {
-	struct resource *mem = dev_get_drvdata(dev);
+	struct resource *mem = dev_get_drvdata(&pdev->dev);
 
 	hwrng_unregister(&omap_rng_ops);
 
 	omap_rng_write_reg(RNG_MASK_REG, 0x0);
 
 	if (cpu_is_omap24xx()) {
-		clk_unuse(rng_ick);
+		clk_disable(rng_ick);
 		clk_put(rng_ick);
 	}
 
@@ -157,18 +154,16 @@ static int __exit omap_rng_remove(struct
 
 #ifdef CONFIG_PM
 
-static int omap_rng_suspend(struct device *dev, pm_message_t message, u32 level)
+static int omap_rng_suspend(struct platform_device *pdev, pm_message_t message)
 {
 	omap_rng_write_reg(RNG_MASK_REG, 0x0);
-
 	return 0;
 }
 
-static int omap_rng_resume(struct device *dev, pm_message_t message, u32 level)
+static int omap_rng_resume(struct platform_device *pdev)
 {
 	omap_rng_write_reg(RNG_MASK_REG, 0x1);
-
-	return 1;
+	return 0;
 }
 
 #else
@@ -179,9 +174,11 @@ static int omap_rng_resume(struct device
 #endif
 
 
-static struct device_driver omap_rng_driver = {
-	.name		= "omap_rng",
-	.bus		= &platform_bus_type,
+static struct platform_driver omap_rng_driver = {
+	.driver = {
+		.name		= "omap_rng",
+		.owner		= THIS_MODULE,
+	},
 	.probe		= omap_rng_probe,
 	.remove		= __exit_p(omap_rng_remove),
 	.suspend	= omap_rng_suspend,
@@ -193,12 +190,12 @@ static int __init omap_rng_init(void)
 	if (!cpu_is_omap16xx() && !cpu_is_omap24xx())
 		return -ENODEV;
 
-	return driver_register(&omap_rng_driver);
+	return platform_driver_register(&omap_rng_driver);
 }
 
 static void __exit omap_rng_exit(void)
 {
-	driver_unregister(&omap_rng_driver);
+	platform_driver_unregister(&omap_rng_driver);
 }
 
 module_init(omap_rng_init);

--Boundary-00=_sKhzEOBQvWhyxFv--
