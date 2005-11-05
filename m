Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932183AbVKESUA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932183AbVKESUA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 13:20:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932179AbVKEST7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 13:19:59 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:32529 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932178AbVKESTV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 13:19:21 -0500
Date: Sat, 5 Nov 2005 18:19:15 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [DRIVER MODEL] Convert miscellaneous char drivers
Message-ID: <20051105181915.GR14419@flint.arm.linux.org.uk>
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

diff -u b/drivers/char/sonypi.c b/drivers/char/sonypi.c
--- b/drivers/char/sonypi.c
+++ b/drivers/char/sonypi.c
@@ -1168,7 +1168,7 @@
 #ifdef CONFIG_PM
 static int old_camera_power;
 
-static int sonypi_suspend(struct device *dev, pm_message_t state)
+static int sonypi_suspend(struct platform_device *dev, pm_message_t state)
 {
 	old_camera_power = sonypi_device.camera_power;
 	sonypi_disable();
@@ -1176,7 +1176,7 @@
 	return 0;
 }
 
-static int sonypi_resume(struct device *dev)
+static int sonypi_resume(struct platform_device *dev)
 {
 	sonypi_enable(old_camera_power);
 	return 0;
@@ -1183,7 +1183,7 @@
 }
 #endif
 
-static void sonypi_shutdown(struct device *dev)
+static void sonypi_shutdown(struct platform_device *dev)
 {
 	sonypi_disable();
 }
@@ -1188,14 +1188,15 @@
 	sonypi_disable();
 }
 
-static struct device_driver sonypi_driver = {
-	.name		= "sonypi",
-	.bus		= &platform_bus_type,
+static struct platform_driver sonypi_driver = {
 #ifdef CONFIG_PM
 	.suspend	= sonypi_suspend,
 	.resume		= sonypi_resume,
 #endif
 	.shutdown	= sonypi_shutdown,
+	.driver		= {
+		.name	= "sonypi",
+	},
 };
 
 static int __devinit sonypi_create_input_devices(void)
@@ -1455,20 +1456,20 @@
 	if (!dmi_check_system(sonypi_dmi_table))
 		return -ENODEV;
 
-	ret = driver_register(&sonypi_driver);
+	ret = platform_driver_register(&sonypi_driver);
 	if (ret)
 		return ret;
 
 	ret = sonypi_probe();
 	if (ret)
-		driver_unregister(&sonypi_driver);
+		platform_driver_unregister(&sonypi_driver);
 
 	return ret;
 }
 
 static void __exit sonypi_exit(void)
 {
-	driver_unregister(&sonypi_driver);
+	platform_driver_unregister(&sonypi_driver);
 	sonypi_remove();
 }
 
diff -u b/drivers/char/tb0219.c b/drivers/char/tb0219.c
--- b/drivers/char/tb0219.c
+++ b/drivers/char/tb0219.c
@@ -283,7 +283,7 @@
 	vr41xx_set_irq_level(TB0219_PCI_SLOT3_PIN, IRQ_LEVEL_LOW);
 }
 
-static int tb0219_probe(struct device *dev)
+static int tb0219_probe(struct platform_device *dev)
 {
 	int retval;
 
@@ -319,7 +319,7 @@
 	return 0;
 }
 
-static int tb0219_remove(struct device *dev)
+static int tb0219_remove(struct platform_device *dev)
 {
 	_machine_restart = old_machine_restart;
 
@@ -333,11 +333,12 @@ static int tb0219_remove(struct device *
 
 static struct platform_device *tb0219_platform_device;
 
-static struct device_driver tb0219_device_driver = {
-	.name		= "TB0219",
-	.bus		= &platform_bus_type,
+static struct platform_driver tb0219_device_driver = {
 	.probe		= tb0219_probe,
 	.remove		= tb0219_remove,
+	.driver		= {
+		.name	= "TB0219",
+	},
 };
 
 static int __devinit tanbac_tb0219_init(void)
@@ -348,7 +349,7 @@ static int __devinit tanbac_tb0219_init(
 	if (IS_ERR(tb0219_platform_device))
 		return PTR_ERR(tb0219_platform_device);
 
-	retval = driver_register(&tb0219_device_driver);
+	retval = platform_driver_register(&tb0219_device_driver);
 	if (retval < 0)
 		platform_device_unregister(tb0219_platform_device);
 
@@ -357,7 +358,7 @@ static int __devinit tanbac_tb0219_init(
 
 static void __devexit tanbac_tb0219_exit(void)
 {
-	driver_unregister(&tb0219_device_driver);
+	platform_driver_unregister(&tb0219_device_driver);
 
 	platform_device_unregister(tb0219_platform_device);
 }
diff -u b/drivers/char/vr41xx_giu.c b/drivers/char/vr41xx_giu.c
--- b/drivers/char/vr41xx_giu.c
+++ b/drivers/char/vr41xx_giu.c
@@ -613,7 +613,7 @@
 	.release	= gpio_release,
 };
 
-static int giu_probe(struct device *dev)
+static int giu_probe(struct platform_device *dev)
 {
 	unsigned long start, size, flags = 0;
 	unsigned int nr_pins = 0;
@@ -697,7 +697,7 @@
 	return cascade_irq(GIUINT_IRQ, giu_get_irq);
 }
 
-static int giu_remove(struct device *dev)
+static int giu_remove(struct platform_device *dev)
 {
 	iounmap(giu_base);
 
@@ -710,11 +710,12 @@ static int giu_remove(struct device *dev
 
 static struct platform_device *giu_platform_device;
 
-static struct device_driver giu_device_driver = {
-	.name		= "GIU",
-	.bus		= &platform_bus_type,
+static struct platform_driver giu_device_driver = {
 	.probe		= giu_probe,
 	.remove		= giu_remove,
+	.driver		= {
+		.name	= "GIU",
+	},
 };
 
 static int __devinit vr41xx_giu_init(void)
@@ -725,7 +726,7 @@ static int __devinit vr41xx_giu_init(voi
 	if (IS_ERR(giu_platform_device))
 		return PTR_ERR(giu_platform_device);
 
-	retval = driver_register(&giu_device_driver);
+	retval = platform_driver_register(&giu_device_driver);
 	if (retval < 0)
 		platform_device_unregister(giu_platform_device);
 
@@ -734,7 +735,7 @@ static int __devinit vr41xx_giu_init(voi
 
 static void __devexit vr41xx_giu_exit(void)
 {
-	driver_unregister(&giu_device_driver);
+	platform_driver_unregister(&giu_device_driver);
 
 	platform_device_unregister(giu_platform_device);
 }
diff -u b/drivers/char/vr41xx_rtc.c b/drivers/char/vr41xx_rtc.c
--- b/drivers/char/vr41xx_rtc.c
+++ b/drivers/char/vr41xx_rtc.c
@@ -560,13 +560,11 @@
 	.fops	= &rtc_fops,
 };
 
-static int rtc_probe(struct device *dev)
+static int rtc_probe(struct platform_device *pdev)
 {
-	struct platform_device *pdev;
 	unsigned int irq;
 	int retval;
 
-	pdev = to_platform_device(dev);
 	if (pdev->num_resources != 2)
 		return -EBUSY;
 
@@ -635,7 +633,7 @@
 	return 0;
 }
 
-static int rtc_remove(struct device *dev)
+static int rtc_remove(struct platform_device *dev)
 {
 	int retval;
 
@@ -655,11 +653,12 @@ static int rtc_remove(struct device *dev
 
 static struct platform_device *rtc_platform_device;
 
-static struct device_driver rtc_device_driver = {
-	.name		= rtc_name,
-	.bus		= &platform_bus_type,
+static struct platform_driver rtc_device_driver = {
 	.probe		= rtc_probe,
 	.remove		= rtc_remove,
+	.driver		= {
+		.name	= rtc_name,
+	},
 };
 
 static int __devinit vr41xx_rtc_init(void)
@@ -691,7 +690,7 @@ static int __devinit vr41xx_rtc_init(voi
 	if (IS_ERR(rtc_platform_device))
 		return PTR_ERR(rtc_platform_device);
 
-	retval = driver_register(&rtc_device_driver);
+	retval = platform_driver_register(&rtc_device_driver);
 	if (retval < 0)
 		platform_device_unregister(rtc_platform_device);
 
@@ -700,7 +699,7 @@ static int __devinit vr41xx_rtc_init(voi
 
 static void __devexit vr41xx_rtc_exit(void)
 {
-	driver_unregister(&rtc_device_driver);
+	platform_driver_unregister(&rtc_device_driver);
 
 	platform_device_unregister(rtc_platform_device);
 }
diff -u b/drivers/char/watchdog/mv64x60_wdt.c b/drivers/char/watchdog/mv64x60_wdt.c
--- b/drivers/char/watchdog/mv64x60_wdt.c
+++ b/drivers/char/watchdog/mv64x60_wdt.c
@@ -182,10 +182,9 @@
 	.fops = &mv64x60_wdt_fops,
 };
 
-static int __devinit mv64x60_wdt_probe(struct device *dev)
+static int __devinit mv64x60_wdt_probe(struct platform_device *dev)
 {
-	struct platform_device *pd = to_platform_device(dev);
-	struct mv64x60_wdt_pdata *pdata = pd->dev.platform_data;
+	struct mv64x60_wdt_pdata *pdata = dev->dev.platform_data;
 	int bus_clk = 133;
 
 	mv64x60_wdt_timeout = 10;
@@ -202,7 +201,7 @@
 	return misc_register(&mv64x60_wdt_miscdev);
 }
 
-static int __devexit mv64x60_wdt_remove(struct device *dev)
+static int __devexit mv64x60_wdt_remove(struct platform_device *dev)
 {
 	misc_deregister(&mv64x60_wdt_miscdev);
 
@@ -212,12 +211,13 @@ static int __devexit mv64x60_wdt_remove(
 	return 0;
 }
 
-static struct device_driver mv64x60_wdt_driver = {
-	.owner = THIS_MODULE,
-	.name = MV64x60_WDT_NAME,
-	.bus = &platform_bus_type,
+static struct platform_driver mv64x60_wdt_driver = {
 	.probe = mv64x60_wdt_probe,
 	.remove = __devexit_p(mv64x60_wdt_remove),
+	.driver = {
+		.owner = THIS_MODULE,
+		.name = MV64x60_WDT_NAME,
+	},
 };
 
 static struct platform_device *mv64x60_wdt_dev;
@@ -235,14 +235,14 @@ static int __init mv64x60_wdt_init(void)
 		goto out;
 	}
 
-	ret = driver_register(&mv64x60_wdt_driver);
+	ret = platform_driver_register(&mv64x60_wdt_driver);
       out:
 	return ret;
 }
 
 static void __exit mv64x60_wdt_exit(void)
 {
-	driver_unregister(&mv64x60_wdt_driver);
+	platform_driver_unregister(&mv64x60_wdt_driver);
 	platform_device_unregister(mv64x60_wdt_dev);
 }
 
diff -u b/drivers/char/watchdog/mpcore_wdt.c b/drivers/char/watchdog/mpcore_wdt.c
--- b/drivers/char/watchdog/mpcore_wdt.c
+++ b/drivers/char/watchdog/mpcore_wdt.c
@@ -139,7 +139,7 @@
  */
 static int mpcore_wdt_open(struct inode *inode, struct file *file)
 {
-	struct mpcore_wdt *wdt = dev_get_drvdata(&mpcore_wdt_dev->dev);
+	struct mpcore_wdt *wdt = platform_get_drvdata(mpcore_wdt_dev);
 
 	if (test_and_set_bit(0, &wdt->timer_alive))
 		return -EBUSY;
@@ -291,9 +291,9 @@
  *	System shutdown handler.  Turn off the watchdog if we're
  *	restarting or halting the system.
  */
-static void mpcore_wdt_shutdown(struct device *_dev)
+static void mpcore_wdt_shutdown(struct platform_device *dev)
 {
-	struct mpcore_wdt *wdt = dev_get_drvdata(_dev);
+	struct mpcore_wdt *wdt = platform_get_drvdata(dev);
 
 	if (system_state == SYSTEM_RESTART || system_state == SYSTEM_HALT)
 		mpcore_wdt_stop(wdt);
@@ -317,9 +317,8 @@
 	.fops		= &mpcore_wdt_fops,
 };
 
-static int __devinit mpcore_wdt_probe(struct device *_dev)
+static int __devinit mpcore_wdt_probe(struct platform_device *dev)
 {
-	struct platform_device *dev = to_platform_device(_dev);
 	struct mpcore_wdt *wdt;
 	struct resource *res;
 	int ret;
@@ -364,7 +363,7 @@
 	}
 
 	mpcore_wdt_stop(wdt);
-	dev_set_drvdata(&dev->dev, wdt);
+	platform_set_drvdata(&dev->dev, wdt);
 	mpcore_wdt_dev = dev;
 
 	return 0;
@@ -379,11 +378,11 @@
 	return ret;
 }
 
-static int __devexit mpcore_wdt_remove(struct device *dev)
+static int __devexit mpcore_wdt_remove(struct platform_device *dev)
 {
-	struct mpcore_wdt *wdt = dev_get_drvdata(dev);
+	struct mpcore_wdt *wdt = platform_get_drvdata(dev);
 
-	dev_set_drvdata(dev, NULL);
+	platform_set_drvdata(dev, NULL);
 
 	misc_deregister(&mpcore_wdt_miscdev);
 
@@ -395,13 +394,14 @@ static int __devexit mpcore_wdt_remove(s
 	return 0;
 }
 
-static struct device_driver mpcore_wdt_driver = {
-	.owner		= THIS_MODULE,
-	.name		= "mpcore_wdt",
-	.bus		= &platform_bus_type,
+static struct platform_driver mpcore_wdt_driver = {
 	.probe		= mpcore_wdt_probe,
 	.remove		= __devexit_p(mpcore_wdt_remove),
 	.shutdown	= mpcore_wdt_shutdown,
+	.driver		= {
+		.owner	= THIS_MODULE,
+		.name	= "mpcore_wdt",
+	},
 };
 
 static char banner[] __initdata = KERN_INFO "MPcore Watchdog Timer: 0.1. mpcore_noboot=%d mpcore_margin=%d sec (nowayout= %d)\n";
@@ -420,12 +420,12 @@ static int __init mpcore_wdt_init(void)
 
 	printk(banner, mpcore_noboot, mpcore_margin, nowayout);
 
-	return driver_register(&mpcore_wdt_driver);
+	return platform_driver_register(&mpcore_wdt_driver);
 }
 
 static void __exit mpcore_wdt_exit(void)
 {
-	driver_unregister(&mpcore_wdt_driver);
+	platform_driver_unregister(&mpcore_wdt_driver);
 }
 
 module_init(mpcore_wdt_init);

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
