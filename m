Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932160AbVKESRb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932160AbVKESRb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 13:17:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932167AbVKESRb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 13:17:31 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:30993 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932171AbVKESR0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 13:17:26 -0500
Date: Sat, 5 Nov 2005 18:17:20 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [DRIVER MODEL] Convert MTD drivers
Message-ID: <20051105181720.GL14419@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>
References: <20051105181122.GD12228@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051105181122.GD12228@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Convert platform drivers to use struct platform_driver

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

diff -u b/drivers/mtd/maps/bast-flash.c b/drivers/mtd/maps/bast-flash.c
--- b/drivers/mtd/maps/bast-flash.c
+++ b/drivers/mtd/maps/bast-flash.c
@@ -63,11 +63,6 @@
 
 static const char *probes[] = { "RedBoot", "cmdlinepart", NULL };
 
-static struct bast_flash_info *to_bast_info(struct device *dev)
-{
-	return (struct bast_flash_info *)dev_get_drvdata(dev);
-}
-
 static void bast_flash_setrw(int to)
 {
 	unsigned int val;
@@ -87,11 +82,11 @@
 	local_irq_restore(flags);
 }
 
-static int bast_flash_remove(struct device *dev)
+static int bast_flash_remove(struct platform_device *pdev)
 {
-	struct bast_flash_info *info = to_bast_info(dev);
+	struct bast_flash_info *info = platform_get_drvdata(pdev);
 
-	dev_set_drvdata(dev, NULL);
+	platform_set_drvdata(pdev, NULL);
 
 	if (info == NULL) 
 		return 0;
@@ -117,9 +112,8 @@
 	return 0;
 }
 
-static int bast_flash_probe(struct device *dev)
+static int bast_flash_probe(struct platform_device *pdev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
 	struct bast_flash_info *info;
 	struct resource *res;
 	int err = 0;
@@ -132,13 +126,13 @@
 	}
 
 	memzero(info, sizeof(*info));
-	dev_set_drvdata(dev, info);
+	platform_set_drvdata(pdev, info);
 
 	res = pdev->resource;  /* assume that the flash has one resource */
 
 	info->map.phys = res->start;
 	info->map.size = res->end - res->start + 1;
-	info->map.name = dev->bus_id;	
+	info->map.name = pdev->dev.bus_id;	
 	info->map.bankwidth = 2;
 	
 	if (info->map.size > AREA_MAXSIZE)
@@ -200,26 +194,27 @@
 	/* fall through to exit error */
 
  exit_error:
-	bast_flash_remove(dev);
+	bast_flash_remove(pdev);
 	return err;
 }
 
-static struct device_driver bast_flash_driver = {
-	.name		= "bast-nor",
-	.bus		= &platform_bus_type,
+static struct platform_driver bast_flash_driver = {
 	.probe		= bast_flash_probe,
 	.remove		= bast_flash_remove,
+	.driver		= {
+		.name	= "bast-nor",
+	},
 };
 
 static int __init bast_flash_init(void)
 {
 	printk("BAST NOR-Flash Driver, (c) 2004 Simtec Electronics\n");
-	return driver_register(&bast_flash_driver);
+	return platform_driver_register(&bast_flash_driver);
 }
 
 static void __exit bast_flash_exit(void)
 {
-	driver_unregister(&bast_flash_driver);
+	platform_driver_unregister(&bast_flash_driver);
 }
 
 module_init(bast_flash_init);
diff -u b/drivers/mtd/maps/integrator-flash.c b/drivers/mtd/maps/integrator-flash.c
--- b/drivers/mtd/maps/integrator-flash.c
+++ b/drivers/mtd/maps/integrator-flash.c
@@ -67,9 +67,8 @@
 
 static const char *probes[] = { "cmdlinepart", "RedBoot", "afs", NULL };
 
-static int armflash_probe(struct device *_dev)
+static int armflash_probe(struct platform_device *dev)
 {
-	struct platform_device *dev = to_platform_device(_dev);
 	struct flash_platform_data *plat = dev->dev.platform_data;
 	struct resource *res = dev->resource;
 	unsigned int size = res->end - res->start + 1;
@@ -138,7 +137,7 @@
 	}
 
 	if (err == 0)
-		dev_set_drvdata(&dev->dev, info);
+		platform_set_drvdata(dev, info);
 
 	/*
 	 * If we got an error, free all resources.
@@ -164,12 +163,11 @@
 	return err;
 }
 
-static int armflash_remove(struct device *_dev)
+static int armflash_remove(struct platform_device *dev)
 {
-	struct platform_device *dev = to_platform_device(_dev);
-	struct armflash_info *info = dev_get_drvdata(&dev->dev);
+	struct armflash_info *info = platform_get_drvdata(dev);
 
-	dev_set_drvdata(&dev->dev, NULL);
+	platform_set_drvdata(dev, NULL);
 
 	if (info) {
 		if (info->mtd) {
@@ -192,21 +190,22 @@ static int armflash_remove(struct device
 	return 0;
 }
 
-static struct device_driver armflash_driver = {
-	.name		= "armflash",
-	.bus		= &platform_bus_type,
+static struct platform_driver armflash_driver = {
 	.probe		= armflash_probe,
 	.remove		= armflash_remove,
+	.driver		= {
+		.name	= "armflash",
+	},
 };
 
 static int __init armflash_init(void)
 {
-	return driver_register(&armflash_driver);
+	return platform_driver_register(&armflash_driver);
 }
 
 static void __exit armflash_exit(void)
 {
-	driver_unregister(&armflash_driver);
+	platform_driver_unregister(&armflash_driver);
 }
 
 module_init(armflash_init);
diff -u b/drivers/mtd/maps/ixp2000.c b/drivers/mtd/maps/ixp2000.c
--- b/drivers/mtd/maps/ixp2000.c
+++ b/drivers/mtd/maps/ixp2000.c
@@ -111,13 +111,12 @@
 }
 
 
-static int ixp2000_flash_remove(struct device *_dev)
+static int ixp2000_flash_remove(struct platform_device *dev)
 {
-	struct platform_device *dev = to_platform_device(_dev);
 	struct flash_platform_data *plat = dev->dev.platform_data;
-	struct ixp2000_flash_info *info = dev_get_drvdata(&dev->dev);
+	struct ixp2000_flash_info *info = platform_get_drvdata(dev);
 
-	dev_set_drvdata(&dev->dev, NULL);
+	platform_set_drvdata(dev, NULL);
 
 	if(!info)
 		return 0;
@@ -144,10 +143,9 @@
 }
 
 
-static int ixp2000_flash_probe(struct device *_dev)
+static int ixp2000_flash_probe(struct platform_device *dev)
 {
 	static const char *probes[] = { "RedBoot", "cmdlinepart", NULL };
-	struct platform_device *dev = to_platform_device(_dev);
 	struct ixp2000_flash_data *ixp_data = dev->dev.platform_data;
 	struct flash_platform_data *plat; 
 	struct ixp2000_flash_info *info;
@@ -178,7 +176,7 @@
 	}	
 	memzero(info, sizeof(struct ixp2000_flash_info));
 
-	dev_set_drvdata(&dev->dev, info);
+	platform_set_drvdata(dev, info);
 
 	/*
 	 * Tell the MTD layer we're not 1:1 mapped so that it does
@@ -249,7 +247,7 @@
 	return 0;
 
 Error:
-	ixp2000_flash_remove(_dev);
+	ixp2000_flash_remove(dev);
 	return err;
 }
 
@@ -253,21 +251,22 @@ Error:
 	return err;
 }
 
-static struct device_driver ixp2000_flash_driver = {
-	.name		= "IXP2000-Flash",
-	.bus		= &platform_bus_type,
+static struct platform_driver ixp2000_flash_driver = {
 	.probe		= &ixp2000_flash_probe,
 	.remove		= &ixp2000_flash_remove
+	.driver		= {
+		.name	= "IXP2000-Flash",
+	},
 };
 
 static int __init ixp2000_flash_init(void)
 {
-	return driver_register(&ixp2000_flash_driver);
+	return platform_driver_register(&ixp2000_flash_driver);
 }
 
 static void __exit ixp2000_flash_exit(void)
 {
-	driver_unregister(&ixp2000_flash_driver);
+	platform_driver_unregister(&ixp2000_flash_driver);
 }
 
 module_init(ixp2000_flash_init);
diff -u b/drivers/mtd/maps/ixp4xx.c b/drivers/mtd/maps/ixp4xx.c
--- b/drivers/mtd/maps/ixp4xx.c
+++ b/drivers/mtd/maps/ixp4xx.c
@@ -99,14 +99,13 @@
 
 static const char *probes[] = { "RedBoot", "cmdlinepart", NULL };
 
-static int ixp4xx_flash_remove(struct device *_dev)
+static int ixp4xx_flash_remove(struct platform_device *dev)
 {
-	struct platform_device *dev = to_platform_device(_dev);
 	struct flash_platform_data *plat = dev->dev.platform_data;
-	struct ixp4xx_flash_info *info = dev_get_drvdata(&dev->dev);
+	struct ixp4xx_flash_info *info = platform_get_drvdata(dev);
 	map_word d;
 
-	dev_set_drvdata(&dev->dev, NULL);
+	platform_set_drvdata(dev, NULL);
 
 	if(!info)
 		return 0;
@@ -141,9 +140,8 @@
 	return 0;
 }
 
-static int ixp4xx_flash_probe(struct device *_dev)
+static int ixp4xx_flash_probe(struct platform_device *dev)
 {
-	struct platform_device *dev = to_platform_device(_dev);
 	struct flash_platform_data *plat = dev->dev.platform_data;
 	struct ixp4xx_flash_info *info;
 	int err = -1;
@@ -164,7 +162,7 @@
 	}	
 	memzero(info, sizeof(struct ixp4xx_flash_info));
 
-	dev_set_drvdata(&dev->dev, info);
+	platform_set_drvdata(dev, info);
 
 	/* 
 	 * Enable flash write 
@@ -231,7 +229,7 @@
 	return 0;
 
 Error:
-	ixp4xx_flash_remove(_dev);
+	ixp4xx_flash_remove(dev);
 	return err;
 }
 
@@ -235,21 +233,22 @@ Error:
 	return err;
 }
 
-static struct device_driver ixp4xx_flash_driver = {
-	.name		= "IXP4XX-Flash",
-	.bus		= &platform_bus_type,
+static struct platform_driver ixp4xx_flash_driver = {
 	.probe		= ixp4xx_flash_probe,
 	.remove		= ixp4xx_flash_remove,
+	.driver		= {
+		.name	= "IXP4XX-Flash",
+	},
 };
 
 static int __init ixp4xx_flash_init(void)
 {
-	return driver_register(&ixp4xx_flash_driver);
+	return platform_driver_register(&ixp4xx_flash_driver);
 }
 
 static void __exit ixp4xx_flash_exit(void)
 {
-	driver_unregister(&ixp4xx_flash_driver);
+	platform_driver_unregister(&ixp4xx_flash_driver);
 }
 
 
diff -u b/drivers/mtd/maps/omap_nor.c b/drivers/mtd/maps/omap_nor.c
--- b/drivers/mtd/maps/omap_nor.c
+++ b/drivers/mtd/maps/omap_nor.c
@@ -70,11 +70,10 @@
 	}
 }
 
-static int __devinit omapflash_probe(struct device *dev)
+static int __devinit omapflash_probe(struct platform_device *pdev)
 {
 	int err;
 	struct omapflash_info *info;
-	struct platform_device *pdev = to_platform_device(dev);
 	struct flash_platform_data *pdata = pdev->dev.platform_data;
 	struct resource *res = pdev->resource;
 	unsigned long size = res->end - res->start + 1;
@@ -119,7 +118,7 @@
 #endif
 		add_mtd_device(info->mtd);
 
-	dev_set_drvdata(&pdev->dev, info);
+	platform_set_drvdata(pdev, info);
 
 	return 0;
 
@@ -133,12 +132,11 @@
 	return err;
 }
 
-static int __devexit omapflash_remove(struct device *dev)
+static int __devexit omapflash_remove(struct platform_device *pdev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct omapflash_info *info = dev_get_drvdata(&pdev->dev);
+	struct omapflash_info *info = platform_get_drvdata(pdev);
 
-	dev_set_drvdata(&pdev->dev, NULL);
+	platform_set_drvdata(pdev, NULL);
 
 	if (info) {
 		if (info->parts) {
@@ -155,21 +153,22 @@ static int __devexit omapflash_remove(st
 	return 0;
 }
 
-static struct device_driver omapflash_driver = {
-	.name	= "omapflash",
-	.bus	= &platform_bus_type,
+static struct platform_driver omapflash_driver = {
 	.probe	= omapflash_probe,
 	.remove	= __devexit_p(omapflash_remove),
+	.driver = {
+		.name	= "omapflash",
+	},
 };
 
 static int __init omapflash_init(void)
 {
-	return driver_register(&omapflash_driver);
+	return platform_driver_register(&omapflash_driver);
 }
 
 static void __exit omapflash_exit(void)
 {
-	driver_unregister(&omapflash_driver);
+	platform_driver_unregister(&omapflash_driver);
 }
 
 module_init(omapflash_init);
diff -u b/drivers/mtd/maps/plat-ram.c b/drivers/mtd/maps/plat-ram.c
--- b/drivers/mtd/maps/plat-ram.c
+++ b/drivers/mtd/maps/plat-ram.c
@@ -56,9 +56,9 @@
  * device private data to struct platram_info conversion
 */
 
-static inline struct platram_info *to_platram_info(struct device *dev)
+static inline struct platram_info *to_platram_info(struct platform_device *dev)
 {
-	return (struct platram_info *)dev_get_drvdata(dev);
+	return (struct platram_info *)platform_get_drvdata(dev);
 }
 
 /* platram_setrw
@@ -83,13 +83,13 @@
  * called to remove the device from the driver's control
 */
 
-static int platram_remove(struct device *dev)
+static int platram_remove(struct platform_device *pdev)
 {
-	struct platram_info *info = to_platram_info(dev);
+	struct platram_info *info = to_platram_info(pdev);
 
-	dev_set_drvdata(dev, NULL);
+	platform_set_drvdata(pdev, NULL);
 
-	dev_dbg(dev, "removing device\n");
+	dev_dbg(&pdev->dev, "removing device\n");
 
 	if (info == NULL) 
 		return 0;
@@ -130,9 +130,8 @@
  * driver is found.
 */
 
-static int platram_probe(struct device *dev)
+static int platram_probe(struct platform_device *pdev)
 {
-	struct platform_device *pd = to_platform_device(dev);
 	struct platdata_mtd_ram	*pdata;
 	struct platram_info *info;
 	struct resource *res;
@@ -140,13 +139,13 @@
 
 	dev_dbg(dev, "probe entered\n");
 	
-	if (dev->platform_data == NULL) {
+	if (pdev->dev.platform_data == NULL) {
 		dev_err(dev, "no platform data supplied\n");
 		err = -ENOENT;
 		goto exit_error;
 	}
 
-	pdata = dev->platform_data;
+	pdata = pdev->dev.platform_data;
 
 	info = kmalloc(sizeof(*info), GFP_KERNEL);
 	if (info == NULL) {
@@ -156,7 +155,7 @@
 	}
 
 	memset(info, 0, sizeof(*info));
-	dev_set_drvdata(dev, info);
+	platform_set_drvdata(pdev, info);
 
 	info->dev = dev;
 	info->pdata = pdata;
@@ -171,7 +170,7 @@
 		goto exit_free;
 	}
 
-	dev_dbg(dev, "got platform resource %p (0x%lx)\n", res, res->start);
+	dev_dbg(&pdev->dev, "got platform resource %p (0x%lx)\n", res, res->start);
 
 	/* setup map parameters */
 
@@ -182,7 +181,7 @@
 
 	/* register our usage of the memory area */
 
-	info->area = request_mem_region(res->start, info->map.size, pd->name);
+	info->area = request_mem_region(res->start, info->map.size, pdev->name);
 	if (info->area == NULL) {
 		dev_err(dev, "failed to request memory region\n");
 		err = -EIO;
@@ -241,11 +240,11 @@
 		err = -ENOMEM;
 	}
 	
-	dev_info(dev, "registered mtd device\n");
+	dev_info(&pdev->dev, "registered mtd device\n");
 	return err;
 
  exit_free:
-	platram_remove(dev);
+	platram_remove(pdev);
  exit_error:
 	return err;
 }
@@ -252,11 +251,12 @@ static int platram_probe(struct device *
 
 /* device driver info */
 
-static struct device_driver platram_driver = {
-	.name		= "mtd-ram",
-	.bus		= &platform_bus_type,
+static struct platform_driver platram_driver = {
 	.probe		= platram_probe,
 	.remove		= platram_remove,
+	.driver		= {
+		.name	= "mtd-ram",
+	},
 };
 
 /* module init/exit */
@@ -264,12 +264,12 @@ static struct device_driver platram_driv
 static int __init platram_init(void)
 {
 	printk("Generic platform RAM MTD, (c) 2004 Simtec Electronics\n");
-	return driver_register(&platram_driver);
+	return platform_driver_register(&platram_driver);
 }
 
 static void __exit platram_exit(void)
 {
-	driver_unregister(&platram_driver);
+	platform_driver_unregister(&platram_driver);
 }
 
 module_init(platram_init);

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
