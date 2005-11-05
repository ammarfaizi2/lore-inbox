Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932139AbVKESOz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932139AbVKESOz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 13:14:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932142AbVKESOz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 13:14:55 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:36881 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932139AbVKESOx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 13:14:53 -0500
Date: Sat, 5 Nov 2005 18:14:46 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [DRIVER MODEL] Convert ARM s3c2410 drivers
Message-ID: <20051105181446.GE14419@flint.arm.linux.org.uk>
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

diff --git a/drivers/char/s3c2410-rtc.c b/drivers/char/s3c2410-rtc.c
--- a/drivers/char/s3c2410-rtc.c
+++ b/drivers/char/s3c2410-rtc.c
@@ -382,7 +382,7 @@ static struct rtc_ops s3c2410_rtcops = {
 	.proc	        = s3c2410_rtc_proc,
 };
 
-static void s3c2410_rtc_enable(struct device *dev, int en)
+static void s3c2410_rtc_enable(struct platform_device *pdev, int en)
 {
 	unsigned int tmp;
 
@@ -399,21 +399,21 @@ static void s3c2410_rtc_enable(struct de
 		/* re-enable the device, and check it is ok */
 
 		if ((readb(S3C2410_RTCCON) & S3C2410_RTCCON_RTCEN) == 0){
-			dev_info(dev, "rtc disabled, re-enabling\n");
+			dev_info(&pdev->dev, "rtc disabled, re-enabling\n");
 
 			tmp = readb(S3C2410_RTCCON);
 			writeb(tmp | S3C2410_RTCCON_RTCEN , S3C2410_RTCCON);
 		}
 
 		if ((readb(S3C2410_RTCCON) & S3C2410_RTCCON_CNTSEL)){
-			dev_info(dev, "removing S3C2410_RTCCON_CNTSEL\n");
+			dev_info(&pdev->dev, "removing S3C2410_RTCCON_CNTSEL\n");
 
 			tmp = readb(S3C2410_RTCCON);
 			writeb(tmp& ~S3C2410_RTCCON_CNTSEL , S3C2410_RTCCON);
 		}
 
 		if ((readb(S3C2410_RTCCON) & S3C2410_RTCCON_CLKRST)){
-			dev_info(dev, "removing S3C2410_RTCCON_CLKRST\n");
+			dev_info(&pdev->dev, "removing S3C2410_RTCCON_CLKRST\n");
 
 			tmp = readb(S3C2410_RTCCON);
 			writeb(tmp & ~S3C2410_RTCCON_CLKRST, S3C2410_RTCCON);
@@ -421,7 +421,7 @@ static void s3c2410_rtc_enable(struct de
 	}
 }
 
-static int s3c2410_rtc_remove(struct device *dev)
+static int s3c2410_rtc_remove(struct platform_device *dev)
 {
 	unregister_rtc(&s3c2410_rtcops);
 
@@ -438,25 +438,24 @@ static int s3c2410_rtc_remove(struct dev
 	return 0;
 }
 
-static int s3c2410_rtc_probe(struct device *dev)
+static int s3c2410_rtc_probe(struct platform_device *pdev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
 	struct resource *res;
 	int ret;
 
-	pr_debug("%s: probe=%p, device=%p\n", __FUNCTION__, pdev, dev);
+	pr_debug("%s: probe=%p\n", __FUNCTION__, pdev);
 
 	/* find the IRQs */
 
 	s3c2410_rtc_tickno = platform_get_irq(pdev, 1);
 	if (s3c2410_rtc_tickno <= 0) {
-		dev_err(dev, "no irq for rtc tick\n");
+		dev_err(&pdev->dev, "no irq for rtc tick\n");
 		return -ENOENT;
 	}
 
 	s3c2410_rtc_alarmno = platform_get_irq(pdev, 0);
 	if (s3c2410_rtc_alarmno <= 0) {
-		dev_err(dev, "no irq for alarm\n");
+		dev_err(&pdev->dev, "no irq for alarm\n");
 		return -ENOENT;
 	}
 
@@ -467,7 +466,7 @@ static int s3c2410_rtc_probe(struct devi
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (res == NULL) {
-		dev_err(dev, "failed to get memory region resource\n");
+		dev_err(&pdev->dev, "failed to get memory region resource\n");
 		return -ENOENT;
 	}
 
@@ -475,14 +474,14 @@ static int s3c2410_rtc_probe(struct devi
 				     pdev->name);
 
 	if (s3c2410_rtc_mem == NULL) {
-		dev_err(dev, "failed to reserve memory region\n");
+		dev_err(&pdev->dev, "failed to reserve memory region\n");
 		ret = -ENOENT;
 		goto exit_err;
 	}
 
 	s3c2410_rtc_base = ioremap(res->start, res->end - res->start + 1);
 	if (s3c2410_rtc_base == NULL) {
-		dev_err(dev, "failed ioremap()\n");
+		dev_err(&pdev->dev, "failed ioremap()\n");
 		ret = -EINVAL;
 		goto exit_err;
 	}
@@ -494,7 +493,7 @@ static int s3c2410_rtc_probe(struct devi
 
 	/* check to see if everything is setup correctly */
 
-	s3c2410_rtc_enable(dev, 1);
+	s3c2410_rtc_enable(pdev, 1);
 
  	pr_debug("s3c2410_rtc: RTCCON=%02x\n", readb(S3C2410_RTCCON));
 
@@ -506,7 +505,7 @@ static int s3c2410_rtc_probe(struct devi
 	return 0;
 
  exit_err:
-	dev_err(dev, "error %d during initialisation\n", ret);
+	dev_err(&pdev->dev, "error %d during initialisation\n", ret);
 
 	return ret;
 }
@@ -519,7 +518,7 @@ static struct timespec s3c2410_rtc_delta
 
 static int ticnt_save;
 
-static int s3c2410_rtc_suspend(struct device *dev, pm_message_t state)
+static int s3c2410_rtc_suspend(struct platform_device *pdev, pm_message_t state)
 {
 	struct rtc_time tm;
 	struct timespec time;
@@ -535,19 +534,19 @@
 	s3c2410_rtc_gettime(&tm);
 	rtc_tm_to_time(&tm, &time.tv_sec);
 	save_time_delta(&s3c2410_rtc_delta, &time);
-	s3c2410_rtc_enable(dev, 0);
+	s3c2410_rtc_enable(pdev, 0);
 
 	return 0;
 }
 
-static int s3c2410_rtc_resume(struct device *dev)
+static int s3c2410_rtc_resume(struct platform_device *pdev)
 {
 	struct rtc_time tm;
 	struct timespec time;
 
 	time.tv_nsec = 0;
 
-	s3c2410_rtc_enable(dev, 1);
+	s3c2410_rtc_enable(pdev, 1);
 	s3c2410_rtc_gettime(&tm);
 	rtc_tm_to_time(&tm, &time.tv_sec);
 	restore_time_delta(&s3c2410_rtc_delta, &time);
@@ -560,14 +559,15 @@ static int s3c2410_rtc_resume(struct dev
 #define s3c2410_rtc_resume  NULL
 #endif
 
-static struct device_driver s3c2410_rtcdrv = {
-	.name		= "s3c2410-rtc",
-	.owner		= THIS_MODULE,
-	.bus		= &platform_bus_type,
+static struct platform_driver s3c2410_rtcdrv = {
 	.probe		= s3c2410_rtc_probe,
 	.remove		= s3c2410_rtc_remove,
 	.suspend	= s3c2410_rtc_suspend,
 	.resume		= s3c2410_rtc_resume,
+	.driver		= {
+		.name	= "s3c2410-rtc",
+		.owner	= THIS_MODULE,
+	},
 };
 
 static char __initdata banner[] = "S3C2410 RTC, (c) 2004 Simtec Electronics\n";
@@ -575,12 +575,12 @@ static char __initdata banner[] = "S3C24
 static int __init s3c2410_rtc_init(void)
 {
 	printk(banner);
-	return driver_register(&s3c2410_rtcdrv);
+	return platform_driver_register(&s3c2410_rtcdrv);
 }
 
 static void __exit s3c2410_rtc_exit(void)
 {
-	driver_unregister(&s3c2410_rtcdrv);
+	platform_driver_unregister(&s3c2410_rtcdrv);
 }
 
 module_init(s3c2410_rtc_init);
diff --git a/drivers/char/watchdog/s3c2410_wdt.c b/drivers/char/watchdog/s3c2410_wdt.c
--- a/drivers/char/watchdog/s3c2410_wdt.c
+++ b/drivers/char/watchdog/s3c2410_wdt.c
@@ -347,15 +347,14 @@ static irqreturn_t s3c2410wdt_irq(int ir
 }
 /* device interface */
 
-static int s3c2410wdt_probe(struct device *dev)
+static int s3c2410wdt_probe(struct platform_device *pdev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
 	struct resource *res;
 	int started = 0;
 	int ret;
 	int size;
 
-	DBG("%s: probe=%p, device=%p\n", __FUNCTION__, pdev, dev);
+	DBG("%s: probe=%p\n", __FUNCTION__, pdev);
 
 	/* get the memory region for the watchdog timer */
 
@@ -386,13 +385,13 @@ static int s3c2410wdt_probe(struct devic
 		return -ENOENT;
 	}
 
-	ret = request_irq(res->start, s3c2410wdt_irq, 0, pdev->name, dev);
+	ret = request_irq(res->start, s3c2410wdt_irq, 0, pdev->name, pdev);
 	if (ret != 0) {
 		printk(KERN_INFO PFX "failed to install irq (%d)\n", ret);
 		return ret;
 	}
 
-	wdt_clock = clk_get(dev, "watchdog");
+	wdt_clock = clk_get(&pdev->dev, "watchdog");
 	if (wdt_clock == NULL) {
 		printk(KERN_INFO PFX "failed to find watchdog clock source\n");
 		return -ENOENT;
@@ -430,7 +429,7 @@ static int s3c2410wdt_probe(struct devic
 	return 0;
 }
 
-static int s3c2410wdt_remove(struct device *dev)
+static int s3c2410wdt_remove(struct platform_device *dev)
 {
 	if (wdt_mem != NULL) {
 		release_resource(wdt_mem);
@@ -454,7 +453,7 @@ static int s3c2410wdt_remove(struct devi
 	return 0;
 }
 
-static void s3c2410wdt_shutdown(struct device *dev)
+static void s3c2410wdt_shutdown(struct platform_device *dev)
 {
 	s3c2410wdt_stop();	
 }
@@ -464,7 +463,7 @@ static void s3c2410wdt_shutdown(struct d
 static unsigned long wtcon_save;
 static unsigned long wtdat_save;
 
-static int s3c2410wdt_suspend(struct device *dev, pm_message_t state)
+static int s3c2410wdt_suspend(struct platform_device *dev, pm_message_t state)
 {
 	/* Save watchdog state, and turn it off. */
 	wtcon_save = readl(wdt_base + S3C2410_WTCON);
@@ -476,7 +475,7 @@ 
 	return 0;
 }
 
-static int s3c2410wdt_resume(struct device *dev)
+static int s3c2410wdt_resume(struct platform_device *dev)
 {
 	/* Restore watchdog state. */
 
@@ -496,15 +495,16 @@ static int s3c2410wdt_resume(struct devi
 #endif /* CONFIG_PM */
 
 
-static struct device_driver s3c2410wdt_driver = {
-	.owner		= THIS_MODULE,
-	.name		= "s3c2410-wdt",
-	.bus		= &platform_bus_type,
+static struct platform_driver s3c2410wdt_driver = {
 	.probe		= s3c2410wdt_probe,
 	.remove		= s3c2410wdt_remove,
 	.shutdown	= s3c2410wdt_shutdown,
 	.suspend	= s3c2410wdt_suspend,
 	.resume		= s3c2410wdt_resume,
+	.driver		= {
+		.owner	= THIS_MODULE,
+		.name	= "s3c2410-wdt",
+	},
 };
 
 
@@ -513,12 +513,12 @@ static char banner[] __initdata = KERN_I
 static int __init watchdog_init(void)
 {
 	printk(banner);
-	return driver_register(&s3c2410wdt_driver);
+	return platform_driver_register(&s3c2410wdt_driver);
 }
 
 static void __exit watchdog_exit(void)
 {
-	driver_unregister(&s3c2410wdt_driver);
+	platform_driver_unregister(&s3c2410wdt_driver);
 }
 
 module_init(watchdog_init);
diff --git a/drivers/i2c/busses/i2c-s3c2410.c b/drivers/i2c/busses/i2c-s3c2410.c
--- a/drivers/i2c/busses/i2c-s3c2410.c
+++ b/drivers/i2c/busses/i2c-s3c2410.c
@@ -760,24 +760,23 @@ static void s3c24xx_i2c_free(struct s3c2
  * called by the bus driver when a suitable device is found
 */
 
-static int s3c24xx_i2c_probe(struct device *dev)
+static int s3c24xx_i2c_probe(struct platform_device *pdev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
 	struct s3c24xx_i2c *i2c = &s3c24xx_i2c;
 	struct resource *res;
 	int ret;
 
 	/* find the clock and enable it */
 
-	i2c->dev = dev;
-	i2c->clk = clk_get(dev, "i2c");
+	i2c->dev = &pdev->dev;
+	i2c->clk = clk_get(&pdev->dev, "i2c");
 	if (IS_ERR(i2c->clk)) {
-		dev_err(dev, "cannot get clock\n");
+		dev_err(&pdev->dev, "cannot get clock\n");
 		ret = -ENOENT;
 		goto out;
 	}
 
-	dev_dbg(dev, "clock source %p\n", i2c->clk);
+	dev_dbg(&pdev->dev, "clock source %p\n", i2c->clk);
 
 	clk_use(i2c->clk);
 	clk_enable(i2c->clk);
@@ -786,7 +785,7 @@ static int s3c24xx_i2c_probe(struct devi
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (res == NULL) {
-		dev_err(dev, "cannot find IO resource\n");
+		dev_err(&pdev->dev, "cannot find IO resource\n");
 		ret = -ENOENT;
 		goto out;
 	}
@@ -795,7 +794,7 @@ static int s3c24xx_i2c_probe(struct devi
 					 pdev->name);
 
 	if (i2c->ioarea == NULL) {
-		dev_err(dev, "cannot request IO\n");
+		dev_err(&pdev->dev, "cannot request IO\n");
 		ret = -ENXIO;
 		goto out;
 	}
@@ -803,17 +802,17 @@ static int s3c24xx_i2c_probe(struct devi
 	i2c->regs = ioremap(res->start, (res->end-res->start)+1);
 
 	if (i2c->regs == NULL) {
-		dev_err(dev, "cannot map IO\n");
+		dev_err(&pdev->dev, "cannot map IO\n");
 		ret = -ENXIO;
 		goto out;
 	}
 
-	dev_dbg(dev, "registers %p (%p, %p)\n", i2c->regs, i2c->ioarea, res);
+	dev_dbg(&pdev->dev, "registers %p (%p, %p)\n", i2c->regs, i2c->ioarea, res);
 
 	/* setup info block for the i2c core */
 
 	i2c->adap.algo_data = i2c;
-	i2c->adap.dev.parent = dev;
+	i2c->adap.dev.parent = &pdev->dev;
 
 	/* initialise the i2c controller */
 
@@ -827,7 +826,7 @@ static int s3c24xx_i2c_probe(struct devi
 
 	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
 	if (res == NULL) {
-		dev_err(dev, "cannot find IRQ\n");
+		dev_err(&pdev->dev, "cannot find IRQ\n");
 		ret = -ENOENT;
 		goto out;
 	}
@@ -836,23 +835,23 @@ static int s3c24xx_i2c_probe(struct devi
 			  pdev->name, i2c);
 
 	if (ret != 0) {
-		dev_err(dev, "cannot claim IRQ\n");
+		dev_err(&pdev->dev, "cannot claim IRQ\n");
 		goto out;
 	}
 
 	i2c->irq = res;
 		
-	dev_dbg(dev, "irq resource %p (%ld)\n", res, res->start);
+	dev_dbg(&pdev->dev, "irq resource %p (%ld)\n", res, res->start);
 
 	ret = i2c_add_adapter(&i2c->adap);
 	if (ret < 0) {
-		dev_err(dev, "failed to add bus to i2c core\n");
+		dev_err(&pdev->dev, "failed to add bus to i2c core\n");
 		goto out;
 	}
 
-	dev_set_drvdata(dev, i2c);
+	platform_set_drvdata(pdev, i2c);
 
-	dev_info(dev, "%s: S3C I2C adapter\n", i2c->adap.dev.bus_id);
+	dev_info(&pdev->dev, "%s: S3C I2C adapter\n", i2c->adap.dev.bus_id);
 
  out:
 	if (ret < 0)
@@ -866,22 +865,22 @@ static int s3c24xx_i2c_probe(struct devi
  * called when device is removed from the bus
 */
 
-static int s3c24xx_i2c_remove(struct device *dev)
+static int s3c24xx_i2c_remove(struct platform_device *pdev)
 {
-	struct s3c24xx_i2c *i2c = dev_get_drvdata(dev);
+	struct s3c24xx_i2c *i2c = platform_get_drvdata(pdev);
 	
 	if (i2c != NULL) {
 		s3c24xx_i2c_free(i2c);
-		dev_set_drvdata(dev, NULL);
+		platform_set_drvdata(pdev, NULL);
 	}
 
 	return 0;
 }
 
 #ifdef CONFIG_PM
-static int s3c24xx_i2c_resume(struct device *dev)
+static int s3c24xx_i2c_resume(struct platform_device *dev)
 {
-	struct s3c24xx_i2c *i2c = dev_get_drvdata(dev);
+	struct s3c24xx_i2c *i2c = platform_get_drvdata(dev);
 
 	if (i2c != NULL)
 		s3c24xx_i2c_init(i2c);
@@ -895,42 +894,44 @@ static int s3c24xx_i2c_resume(struct dev
 
 /* device driver for platform bus bits */
 
-static struct device_driver s3c2410_i2c_driver = {
-	.owner		= THIS_MODULE,
-	.name		= "s3c2410-i2c",
-	.bus		= &platform_bus_type,
+static struct platform_driver s3c2410_i2c_driver = {
 	.probe		= s3c24xx_i2c_probe,
 	.remove		= s3c24xx_i2c_remove,
 	.resume		= s3c24xx_i2c_resume,
+	.driver		= {
+		.owner	= THIS_MODULE,
+		.name	= "s3c2410-i2c",
+	},
 };
 
-static struct device_driver s3c2440_i2c_driver = {
-	.owner		= THIS_MODULE,
-	.name		= "s3c2440-i2c",
-	.bus		= &platform_bus_type,
+static struct platform_driver s3c2440_i2c_driver = {
 	.probe		= s3c24xx_i2c_probe,
 	.remove		= s3c24xx_i2c_remove,
 	.resume		= s3c24xx_i2c_resume,
+	.driver		= {
+		.owner	= THIS_MODULE,
+		.name	= "s3c2440-i2c",
+	},
 };
 
 static int __init i2c_adap_s3c_init(void)
 {
 	int ret;
 
-	ret = driver_register(&s3c2410_i2c_driver);
+	ret = platform_driver_register(&s3c2410_i2c_driver);
 	if (ret == 0) {
-		ret = driver_register(&s3c2440_i2c_driver);
+		ret = platform_driver_register(&s3c2440_i2c_driver);
 		if (ret)
-			driver_unregister(&s3c2410_i2c_driver);
+			platform_driver_unregister(&s3c2410_i2c_driver);
 	}
 
 	return ret;
 }
 
 static void __exit i2c_adap_s3c_exit(void)
 {
-	driver_unregister(&s3c2410_i2c_driver);
-	driver_unregister(&s3c2440_i2c_driver);
+	platform_driver_unregister(&s3c2410_i2c_driver);
+	platform_driver_unregister(&s3c2440_i2c_driver);
 }
 
 module_init(i2c_adap_s3c_init);
diff --git a/drivers/mtd/nand/s3c2410.c b/drivers/mtd/nand/s3c2410.c
--- a/drivers/mtd/nand/s3c2410.c
+++ b/drivers/mtd/nand/s3c2410.c
@@ -124,14 +124,14 @@ static struct s3c2410_nand_info *s3c2410
 	return s3c2410_nand_mtd_toours(mtd)->info;
 }
 
-static struct s3c2410_nand_info *to_nand_info(struct device *dev)
+static struct s3c2410_nand_info *to_nand_info(struct platform_device *dev)
 {
-	return dev_get_drvdata(dev);
+	return platform_get_drvdata(dev);
 }
 
-static struct s3c2410_platform_nand *to_nand_plat(struct device *dev)
+static struct s3c2410_platform_nand *to_nand_plat(struct platform_device *dev)
 {
-	return dev->platform_data;
+	return dev->dev.platform_data;
 }
 
 /* timing calculations */
@@ -164,9 +164,9 @@ static int s3c2410_nand_calc_rate(int wa
 /* controller setup */
 
 static int s3c2410_nand_inithw(struct s3c2410_nand_info *info, 
-			       struct device *dev)
+			       struct platform_device *pdev)
 {
-	struct s3c2410_platform_nand *plat = to_nand_plat(dev);
+	struct s3c2410_platform_nand *plat = to_nand_plat(pdev);
 	unsigned int tacls, twrph0, twrph1;
 	unsigned long clkrate = clk_get_rate(info->clk);
 	unsigned long cfg;
@@ -427,11 +427,11 @@ static void s3c2410_nand_write_buf(struc
 
 /* device management functions */
 
-static int s3c2410_nand_remove(struct device *dev)
+static int s3c2410_nand_remove(struct platform_device *pdev)
 {
-	struct s3c2410_nand_info *info = to_nand_info(dev);
+	struct s3c2410_nand_info *info = to_nand_info(pdev);
 
-	dev_set_drvdata(dev, NULL);
+	platform_set_drvdata(pdev, NULL);
 
 	if (info == NULL) 
 		return 0;
@@ -559,10 +559,9 @@ static void s3c2410_nand_init_chip(struc
  * nand layer to look for devices
 */
 
-static int s3c24xx_nand_probe(struct device *dev, int is_s3c2440)
+static int s3c24xx_nand_probe(struct platform_device *pdev, int is_s3c2440)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct s3c2410_platform_nand *plat = to_nand_plat(dev);
+	struct s3c2410_platform_nand *plat = to_nand_plat(pdev);
 	struct s3c2410_nand_info *info;
 	struct s3c2410_nand_mtd *nmtd;
 	struct s3c2410_nand_set *sets;
@@ -572,7 +571,7 @@ static int s3c24xx_nand_probe(struct dev
 	int nr_sets;
 	int setno;
 
-	pr_debug("s3c2410_nand_probe(%p)\n", dev);
+	pr_debug("s3c2410_nand_probe(%p)\n", pdev);
 
 	info = kmalloc(sizeof(*info), GFP_KERNEL);
 	if (info == NULL) {
@@ -582,14 +581,14 @@ static int s3c24xx_nand_probe(struct dev
 	}
 
 	memzero(info, sizeof(*info));
-	dev_set_drvdata(dev, info);
+	platform_set_drvdata(pdev, info);
 
 	spin_lock_init(&info->controller.lock);
 	init_waitqueue_head(&info->controller.wq);
 
 	/* get the clock source and enable it */
 
-	info->clk = clk_get(dev, "nand");
+	info->clk = clk_get(&pdev->dev, "nand");
 	if (IS_ERR(info->clk)) {
 		printk(KERN_ERR PFX "failed to get clock");
 		err = -ENOENT;
@@ -613,7 +612,7 @@ static int s3c24xx_nand_probe(struct dev
 		goto exit_error;
 	}
 
-	info->device     = dev;
+	info->device     = &pdev->dev;
 	info->platform   = plat;
 	info->regs       = ioremap(res->start, size);
 	info->is_s3c2440 = is_s3c2440;
@@ -628,7 +627,7 @@ static int s3c24xx_nand_probe(struct dev
 
 	/* initialise the hardware */
 
-	err = s3c2410_nand_inithw(info, dev);
+	err = s3c2410_nand_inithw(info, pdev);
 	if (err != 0)
 		goto exit_error;
 
@@ -674,7 +673,7 @@ static int s3c24xx_nand_probe(struct dev
 	return 0;
 
  exit_error:
-	s3c2410_nand_remove(dev);
+	s3c2410_nand_remove(pdev);
 
 	if (err == 0)
 		err = -EINVAL;
@@ -683,42 +682,44 @@ static int s3c24xx_nand_probe(struct dev
 
 /* driver device registration */
 
-static int s3c2410_nand_probe(struct device *dev)
+static int s3c2410_nand_probe(struct platform_device *dev)
 {
 	return s3c24xx_nand_probe(dev, 0);
 }
 
-static int s3c2440_nand_probe(struct device *dev)
+static int s3c2440_nand_probe(struct platform_device *dev)
 {
 	return s3c24xx_nand_probe(dev, 1);
 }
 
-static struct device_driver s3c2410_nand_driver = {
-	.name		= "s3c2410-nand",
-	.bus		= &platform_bus_type,
+static struct platform_driver s3c2410_nand_driver = {
 	.probe		= s3c2410_nand_probe,
 	.remove		= s3c2410_nand_remove,
+	.driver		= {
+		.name	= "s3c2410-nand",
+	},
 };
 
-static struct device_driver s3c2440_nand_driver = {
-	.name		= "s3c2440-nand",
-	.bus		= &platform_bus_type,
+static struct platform_driver s3c2440_nand_driver = {
 	.probe		= s3c2440_nand_probe,
 	.remove		= s3c2410_nand_remove,
+	.driver		= {
+		.name	= "s3c2440-nand",
+	},
 };
 
 static int __init s3c2410_nand_init(void)
 {
 	printk("S3C24XX NAND Driver, (c) 2004 Simtec Electronics\n");
 
-	driver_register(&s3c2440_nand_driver);
-	return driver_register(&s3c2410_nand_driver);
+	platform_driver_register(&s3c2440_nand_driver);
+	return platform_driver_register(&s3c2410_nand_driver);
 }
 
 static void __exit s3c2410_nand_exit(void)
 {
-	driver_unregister(&s3c2440_nand_driver);
-	driver_unregister(&s3c2410_nand_driver);
+	platform_driver_unregister(&s3c2440_nand_driver);
+	platform_driver_unregister(&s3c2410_nand_driver);
 }
 
 module_init(s3c2410_nand_init);
diff -u b/drivers/serial/s3c2410.c b/drivers/serial/s3c2410.c
--- b/drivers/serial/s3c2410.c
+++ b/drivers/serial/s3c2410.c
@@ -1092,14 +1092,13 @@
 
 static int probe_index = 0;
 
-static int s3c24xx_serial_probe(struct device *_dev,
+static int s3c24xx_serial_probe(struct platform_device *dev,
 				struct s3c24xx_uart_info *info)
 {
 	struct s3c24xx_uart_port *ourport;
-	struct platform_device *dev = to_platform_device(_dev);
 	int ret;
 
-	dbg("s3c24xx_serial_probe(%p, %p) %d\n", _dev, info, probe_index);
+	dbg("s3c24xx_serial_probe(%p, %p) %d\n", dev, info, probe_index);
 
 	ourport = &s3c24xx_serial_ports[probe_index];
 	probe_index++;
@@ -1112,7 +1111,7 @@
 
 	dbg("%s: adding port\n", __FUNCTION__);
 	uart_add_one_port(&s3c24xx_uart_drv, &ourport->port);
-	dev_set_drvdata(_dev, &ourport->port);
+	platform_set_drvdata(dev, &ourport->port);
 
 	return 0;
 
@@ -1120,9 +1119,9 @@
 	return ret;
 }
 
-static int s3c24xx_serial_remove(struct device *_dev)
+static int s3c24xx_serial_remove(struct platform_device *dev)
 {
-	struct uart_port *port = s3c24xx_dev_to_port(_dev);
+	struct uart_port *port = s3c24xx_dev_to_port(&dev->dev);
 
 	if (port)
 		uart_remove_one_port(&s3c24xx_uart_drv, port);
@@ -1134,9 +1133,9 @@
 
 #ifdef CONFIG_PM
 
-static int s3c24xx_serial_suspend(struct device *dev, pm_message_t state)
+static int s3c24xx_serial_suspend(struct platform_device *dev, pm_message_t state)
 {
-	struct uart_port *port = s3c24xx_dev_to_port(dev);
+	struct uart_port *port = s3c24xx_dev_to_port(&dev->dev);
 
 	if (port)
 		uart_suspend_port(&s3c24xx_uart_drv, port);
@@ -1144,9 +1143,9 @@
 	return 0;
 }
 
-static int s3c24xx_serial_resume(struct device *dev)
+static int s3c24xx_serial_resume(struct platform_device *dev)
 {
-	struct uart_port *port = s3c24xx_dev_to_port(dev);
+	struct uart_port *port = s3c24xx_dev_to_port(&dev->dev);
 	struct s3c24xx_uart_port *ourport = to_ourport(port);
 
 	if (port) {
@@ -1165,11 +1164,11 @@
 #define s3c24xx_serial_resume  NULL
 #endif
 
-static int s3c24xx_serial_init(struct device_driver *drv,
+static int s3c24xx_serial_init(struct platform_driver *drv,
 			       struct s3c24xx_uart_info *info)
 {
 	dbg("s3c24xx_serial_init(%p,%p)\n", drv, info);
-	return driver_register(drv);
+	return platform_driver_register(drv);
 }
 
 
@@ -1228,19 +1227,20 @@
 	.reset_port	= s3c2400_serial_resetport,
 };
 
-static int s3c2400_serial_probe(struct device *dev)
+static int s3c2400_serial_probe(struct platform_device *dev)
 {
 	return s3c24xx_serial_probe(dev, &s3c2400_uart_inf);
 }
 
-static struct device_driver s3c2400_serial_drv = {
-	.name		= "s3c2400-uart",
-	.owner		= THIS_MODULE,
-	.bus		= &platform_bus_type,
+static struct platform_driver s3c2400_serial_drv = {
 	.probe		= s3c2400_serial_probe,
 	.remove		= s3c24xx_serial_remove,
 	.suspend	= s3c24xx_serial_suspend,
 	.resume		= s3c24xx_serial_resume,
+	.driver		= {
+		.name	= "s3c2400-uart",
+		.owner	= THIS_MODULE,
+	},
 };
 
 static inline int s3c2400_serial_init(void)
@@ -1250,7 +1250,7 @@
 
 static inline void s3c2400_serial_exit(void)
 {
-	driver_unregister(&s3c2400_serial_drv);
+	platform_driver_unregister(&s3c2400_serial_drv);
 }
 
 #define s3c2400_uart_inf_at &s3c2400_uart_inf
@@ -1332,19 +1332,20 @@
 
 /* device management */
 
-static int s3c2410_serial_probe(struct device *dev)
+static int s3c2410_serial_probe(struct platform_device *dev)
 {
 	return s3c24xx_serial_probe(dev, &s3c2410_uart_inf);
 }
 
-static struct device_driver s3c2410_serial_drv = {
-	.name		= "s3c2410-uart",
-	.owner		= THIS_MODULE,
-	.bus		= &platform_bus_type,
+static struct platform_driver s3c2410_serial_drv = {
 	.probe		= s3c2410_serial_probe,
 	.remove		= s3c24xx_serial_remove,
 	.suspend	= s3c24xx_serial_suspend,
 	.resume		= s3c24xx_serial_resume,
+	.driver		= {
+		.name	= "s3c2410-uart",
+		.owner	= THIS_MODULE,
+	},
 };
 
 static inline int s3c2410_serial_init(void)
@@ -1354,7 +1355,7 @@
 
 static inline void s3c2410_serial_exit(void)
 {
-	driver_unregister(&s3c2410_serial_drv);
+	platform_driver_unregister(&s3c2410_serial_drv);
 }
 
 #define s3c2410_uart_inf_at &s3c2410_uart_inf
@@ -1493,20 +1494,21 @@
 
 /* device management */
 
-static int s3c2440_serial_probe(struct device *dev)
+static int s3c2440_serial_probe(struct platform_device *dev)
 {
 	dbg("s3c2440_serial_probe: dev=%p\n", dev);
 	return s3c24xx_serial_probe(dev, &s3c2440_uart_inf);
 }
 
-static struct device_driver s3c2440_serial_drv = {
-	.name		= "s3c2440-uart",
-	.owner		= THIS_MODULE,
-	.bus		= &platform_bus_type,
+static struct platform_driver s3c2440_serial_drv = {
 	.probe		= s3c2440_serial_probe,
 	.remove		= s3c24xx_serial_remove,
 	.suspend	= s3c24xx_serial_suspend,
 	.resume		= s3c24xx_serial_resume,
+	.driver		= {
+		.name	= "s3c2440-uart",
+		.owner	= THIS_MODULE,
+	},
 };
 
 
@@ -1517,7 +1519,7 @@
 
 static inline void s3c2440_serial_exit(void)
 {
-	driver_unregister(&s3c2440_serial_drv);
+	platform_driver_unregister(&s3c2440_serial_drv);
 }
 
 #define s3c2440_uart_inf_at &s3c2440_uart_inf
diff -u b/drivers/usb/host/ohci-s3c2410.c b/drivers/usb/host/ohci-s3c2410.c
--- b/drivers/usb/host/ohci-s3c2410.c
+++ b/drivers/usb/host/ohci-s3c2410.c
@@ -459,16 +459,14 @@
 
 /* device driver */
 
-static int ohci_hcd_s3c2410_drv_probe(struct device *dev)
+static int ohci_hcd_s3c2410_drv_probe(struct platform_device *pdev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
 	return usb_hcd_s3c2410_probe(&ohci_s3c2410_hc_driver, pdev);
 }
 
-static int ohci_hcd_s3c2410_drv_remove(struct device *dev)
+static int ohci_hcd_s3c2410_drv_remove(struct platform_device *pdev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct usb_hcd *hcd = dev_get_drvdata(dev);
+	struct usb_hcd *hcd = platform_get_drvdata(pdev);
 
 	usb_hcd_s3c2410_remove(hcd, pdev);
 	return 0;
@@ -474,24 +472,25 @@ static int ohci_hcd_s3c2410_drv_remove(s
 	return 0;
 }
 
-static struct device_driver ohci_hcd_s3c2410_driver = {
-	.name		= "s3c2410-ohci",
-	.owner		= THIS_MODULE,
-	.bus		= &platform_bus_type,
+static struct platform_driver ohci_hcd_s3c2410_driver = {
 	.probe		= ohci_hcd_s3c2410_drv_probe,
 	.remove		= ohci_hcd_s3c2410_drv_remove,
 	/*.suspend	= ohci_hcd_s3c2410_drv_suspend, */
 	/*.resume	= ohci_hcd_s3c2410_drv_resume, */
+	.driver		= {
+		.owner	= THIS_MODULE,
+		.name	= "s3c2410-ohci",
+	},
 };
 
 static int __init ohci_hcd_s3c2410_init (void)
 {
-	return driver_register(&ohci_hcd_s3c2410_driver);
+	return platform_driver_register(&ohci_hcd_s3c2410_driver);
 }
 
 static void __exit ohci_hcd_s3c2410_cleanup (void)
 {
-	driver_unregister(&ohci_hcd_s3c2410_driver);
+	platform_driver_unregister(&ohci_hcd_s3c2410_driver);
 }
 
 module_init (ohci_hcd_s3c2410_init);
diff -u b/drivers/video/s3c2410fb.c b/drivers/video/s3c2410fb.c
--- b/drivers/video/s3c2410fb.c
+++ b/drivers/video/s3c2410fb.c
@@ -635,19 +635,18 @@ static irqreturn_t s3c2410fb_irq(int irq
 
 static char driver_name[]="s3c2410fb";
 
-int __init s3c2410fb_probe(struct device *dev)
+int __init s3c2410fb_probe(struct platform_device *pdev)
 {
 	struct s3c2410fb_info *info;
 	struct fb_info	   *fbinfo;
-	struct platform_device *pdev = to_platform_device(dev);
 	struct s3c2410fb_hw *mregs;
 	int ret;
 	int irq;
 	int i;
 
-	mach_info = dev->platform_data;
+	mach_info = pdev->dev.platform_data;
 	if (mach_info == NULL) {
-		dev_err(dev,"no platform data for lcd, cannot attach\n");
+		dev_err(&pdev->dev,"no platform data for lcd, cannot attach\n");
 		return -EINVAL;
 	}
 
@@ -655,11 +654,11 @@ int __init s3c2410fb_probe(struct device
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(dev, "no irq for device\n");
+		dev_err(&pdev->dev, "no irq for device\n");
 		return -ENOENT;
 	}
 
-	fbinfo = framebuffer_alloc(sizeof(struct s3c2410fb_info), dev);
+	fbinfo = framebuffer_alloc(sizeof(struct s3c2410fb_info), &pdev->dev);
 	if (!fbinfo) {
 		return -ENOMEM;
 	}
@@ -667,7 +666,7 @@
 
 	info = fbinfo->par;
 	info->fb = fbinfo;
-	dev_set_drvdata(dev, fbinfo);
+	platform_set_drvdata(pdev, fbinfo);
 
 	s3c2410fb_init_registers(info);
 
@@ -677,7 +676,7 @@
 
 	memcpy(&info->regs, &mach_info->regs, sizeof(info->regs));
 
-	info->mach_info		    = dev->platform_data;
+	info->mach_info		    = pdev->dev.platform_data;
 
 	fbinfo->fix.type	    = FB_TYPE_PACKED_PIXELS;
 	fbinfo->fix.type_aux	    = 0;
@@ -736,7 +735,7 @@ int __init s3c2410fb_probe(struct device
 
 	ret = request_irq(irq, s3c2410fb_irq, SA_INTERRUPT, pdev->name, info);
 	if (ret) {
-		dev_err(dev, "cannot get irq %d - err %d\n", irq, ret);
+		dev_err(&pdev->dev, "cannot get irq %d - err %d\n", irq, ret);
 		ret = -EBUSY;
 		goto release_mem;
 	}
@@ -774,7 +773,7 @@
 	}
 
 	/* create device files */
-	device_create_file(dev, &dev_attr_debug);
+	device_create_file(&pdev->dev, &dev_attr_debug);
 
 	printk(KERN_INFO "fb%d: %s frame buffer device\n",
 		fbinfo->node, fbinfo->fix.id);
@@ -817,10 +816,9 @@
 /*
  *  Cleanup
  */
-static int s3c2410fb_remove(struct device *dev)
+static int s3c2410fb_remove(struct platform_device *pdev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct fb_info	   *fbinfo = dev_get_drvdata(dev);
+	struct fb_info	   *fbinfo = platform_get_drvdata(pdev);
 	struct s3c2410fb_info *info = fbinfo->par;
 	int irq;
 
@@ -848,9 +846,9 @@
 
 /* suspend and resume support for the lcd controller */
 
-static int s3c2410fb_suspend(struct device *dev, pm_message_t state)
+static int s3c2410fb_suspend(struct platform_device *dev, pm_message_t state)
 {
-	struct fb_info	   *fbinfo = dev_get_drvdata(dev);
+	struct fb_info	   *fbinfo = platform_get_drvdata(dev);
 	struct s3c2410fb_info *info = fbinfo->par;
 
 	s3c2410fb_stop_lcd();
@@ -865,9 +863,9 @@
 	return 0;
 }
 
-static int s3c2410fb_resume(struct device *dev)
+static int s3c2410fb_resume(struct platform_device *dev)
 {
-	struct fb_info	   *fbinfo = dev_get_drvdata(dev);
+	struct fb_info	   *fbinfo = platform_get_drvdata(dev);
 	struct s3c2410fb_info *info = fbinfo->par;
 
 	clk_enable(info->clk);
@@ -883,23 +881,24 @@ static int s3c2410fb_resume(struct devic
 #define s3c2410fb_resume  NULL
 #endif
 
-static struct device_driver s3c2410fb_driver = {
-	.name		= "s3c2410-lcd",
-	.bus		= &platform_bus_type,
+static struct platform_driver s3c2410fb_driver = {
 	.probe		= s3c2410fb_probe,
+	.remove		= s3c2410fb_remove,
 	.suspend	= s3c2410fb_suspend,
 	.resume		= s3c2410fb_resume,
-	.remove		= s3c2410fb_remove
+	.driver		= {
+		.name	= "s3c2410-lcd",
+	},
 };
 
 int __devinit s3c2410fb_init(void)
 {
-	return driver_register(&s3c2410fb_driver);
+	return platform_driver_register(&s3c2410fb_driver);
 }
 
 static void __exit s3c2410fb_cleanup(void)
 {
-	driver_unregister(&s3c2410fb_driver);
+	platform_driver_unregister(&s3c2410fb_driver);
 }
 
 

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
