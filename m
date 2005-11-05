Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932161AbVKESQ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932161AbVKESQ4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 13:16:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932160AbVKESQz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 13:16:55 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:38161 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932161AbVKESQx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 13:16:53 -0500
Date: Sat, 5 Nov 2005 18:16:47 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [DRIVER MODEL] Convert ARM Zaurus drivers
Message-ID: <20051105181646.GJ14419@flint.arm.linux.org.uk>
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

diff -u b/drivers/input/keyboard/corgikbd.c b/drivers/input/keyboard/corgikbd.c
--- b/drivers/input/keyboard/corgikbd.c
+++ b/drivers/input/keyboard/corgikbd.c
@@ -259,17 +259,17 @@
 }
 
 #ifdef CONFIG_PM
-static int corgikbd_suspend(struct device *dev, pm_message_t state)
+static int corgikbd_suspend(struct platform_device *dev, pm_message_t state)
 {
-	struct corgikbd *corgikbd = dev_get_drvdata(dev);
+	struct corgikbd *corgikbd = platform_get_drvdata(dev);
 	corgikbd->suspended = 1;
 
 	return 0;
 }
 
-static int corgikbd_resume(struct device *dev)
+static int corgikbd_resume(struct platform_device *dev)
 {
-	struct corgikbd *corgikbd = dev_get_drvdata(dev);
+	struct corgikbd *corgikbd = platform_get_drvdata(dev);
 
 	/* Upon resume, ignore the suspend key for a short while */
 	corgikbd->suspend_jiffies=jiffies;
@@ -282,7 +282,7 @@
 #define corgikbd_resume		NULL
 #endif
 
-static int __init corgikbd_probe(struct device *dev)
+static int __init corgikbd_probe(struct platform_device *pdev)
 {
 	struct corgikbd *corgikbd;
 	struct input_dev *input_dev;
@@ -296,7 +296,7 @@
 		return -ENOMEM;
 	}
 
-	dev_set_drvdata(dev, corgikbd);
+	platform_set_drvdata(pdev, corgikbd);
 
 	corgikbd->input = input_dev;
 	spin_lock_init(&corgikbd->lock);
@@ -321,7 +321,7 @@
 	input_dev->id.vendor = 0x0001;
 	input_dev->id.product = 0x0001;
 	input_dev->id.version = 0x0100;
-	input_dev->cdev.dev = dev;
+	input_dev->cdev.dev = &pdev->dev;
 	input_dev->private = corgikbd;
 
 	input_dev->evbit[0] = BIT(EV_KEY) | BIT(EV_REP) | BIT(EV_PWR) | BIT(EV_SW);
@@ -356,10 +356,10 @@
 	return 0;
 }
 
-static int corgikbd_remove(struct device *dev)
+static int corgikbd_remove(struct platform_device *pdev)
 {
 	int i;
-	struct corgikbd *corgikbd = dev_get_drvdata(dev);
+	struct corgikbd *corgikbd = platform_get_drvdata(pdev);
 
 	for (i = 0; i < CORGI_KEY_SENSE_NUM; i++)
 		free_irq(CORGI_IRQ_GPIO_KEY_SENSE(i), corgikbd);
@@ -374,23 +374,24 @@
 	return 0;
 }
 
-static struct device_driver corgikbd_driver = {
-	.name		= "corgi-keyboard",
-	.bus		= &platform_bus_type,
+static struct platform_driver corgikbd_driver = {
 	.probe		= corgikbd_probe,
 	.remove		= corgikbd_remove,
 	.suspend	= corgikbd_suspend,
 	.resume		= corgikbd_resume,
+	.driver		= {
+		.name	= "corgi-keyboard",
+	},
 };
 
 static int __devinit corgikbd_init(void)
 {
-	return driver_register(&corgikbd_driver);
+	return platform_driver_register(&corgikbd_driver);
 }
 
 static void __exit corgikbd_exit(void)
 {
-	driver_unregister(&corgikbd_driver);
+	platform_driver_unregister(&corgikbd_driver);
 }
 
 module_init(corgikbd_init);
diff -u b/drivers/input/keyboard/spitzkbd.c b/drivers/input/keyboard/spitzkbd.c
--- b/drivers/input/keyboard/spitzkbd.c
+++ b/drivers/input/keyboard/spitzkbd.c
@@ -309,10 +309,10 @@
 }
 
 #ifdef CONFIG_PM
-static int spitzkbd_suspend(struct device *dev, pm_message_t state)
+static int spitzkbd_suspend(struct platform_device *dev, pm_message_t state)
 {
 	int i;
-	struct spitzkbd *spitzkbd = dev_get_drvdata(dev);
+	struct spitzkbd *spitzkbd = platform_get_drvdata(dev);
 	spitzkbd->suspended = 1;
 
 	/* Set Strobe lines as inputs - *except* strobe line 0 leave this
@@ -323,10 +323,10 @@
 	return 0;
 }
 
-static int spitzkbd_resume(struct device *dev)
+static int spitzkbd_resume(struct platform_device *dev)
 {
 	int i;
-	struct spitzkbd *spitzkbd = dev_get_drvdata(dev);
+	struct spitzkbd *spitzkbd = platform_get_drvdata(dev);
 
 	for (i = 0; i < SPITZ_KEY_STROBE_NUM; i++)
 		pxa_gpio_mode(spitz_strobes[i] | GPIO_OUT | GPIO_DFLT_HIGH);
@@ -342,7 +342,7 @@
 #define spitzkbd_resume		NULL
 #endif
 
-static int __init spitzkbd_probe(struct device *dev)
+static int __init spitzkbd_probe(struct platform_device *dev)
 {
 	struct spitzkbd *spitzkbd;
 	struct input_dev *input_dev;
@@ -358,7 +358,7 @@
 		return -ENOMEM;
 	}
 
-	dev_set_drvdata(dev, spitzkbd);
+	platform_set_drvdata(dev, spitzkbd);
 	strcpy(spitzkbd->phys, "spitzkbd/input0");
 
 	spin_lock_init(&spitzkbd->lock);
@@ -380,7 +380,7 @@
 	input_dev->private = spitzkbd;
 	input_dev->name = "Spitz Keyboard";
 	input_dev->phys = spitzkbd->phys;
-	input_dev->cdev.dev = dev;
+	input_dev->cdev.dev = &dev->dev;
 
 	input_dev->id.bustype = BUS_HOST;
 	input_dev->id.vendor = 0x0001;
@@ -437,10 +437,10 @@
 	return 0;
 }
 
-static int spitzkbd_remove(struct device *dev)
+static int spitzkbd_remove(struct platform_device *dev)
 {
 	int i;
-	struct spitzkbd *spitzkbd = dev_get_drvdata(dev);
+	struct spitzkbd *spitzkbd = platform_get_drvdata(dev);
 
 	for (i = 0; i < SPITZ_KEY_SENSE_NUM; i++)
 		free_irq(IRQ_GPIO(spitz_senses[i]), spitzkbd);
@@ -460,23 +460,24 @@
 	return 0;
 }
 
-static struct device_driver spitzkbd_driver = {
-	.name		= "spitz-keyboard",
-	.bus		= &platform_bus_type,
+static struct platform_driver spitzkbd_driver = {
 	.probe		= spitzkbd_probe,
 	.remove		= spitzkbd_remove,
 	.suspend	= spitzkbd_suspend,
 	.resume		= spitzkbd_resume,
+	.driver		= {
+		.name	= "spitz-keyboard",
+	},
 };
 
 static int __devinit spitzkbd_init(void)
 {
-	return driver_register(&spitzkbd_driver);
+	return platform_driver_register(&spitzkbd_driver);
 }
 
 static void __exit spitzkbd_exit(void)
 {
-	driver_unregister(&spitzkbd_driver);
+	platform_driver_unregister(&spitzkbd_driver);
 }
 
 module_init(spitzkbd_init);
diff -u b/drivers/input/touchscreen/corgi_ts.c b/drivers/input/touchscreen/corgi_ts.c
--- b/drivers/input/touchscreen/corgi_ts.c
+++ b/drivers/input/touchscreen/corgi_ts.c
@@ -231,9 +231,9 @@
 }
 
 #ifdef CONFIG_PM
-static int corgits_suspend(struct device *dev, pm_message_t state)
+static int corgits_suspend(struct platform_device *dev, pm_message_t state)
 {
-	struct corgi_ts *corgi_ts = dev_get_drvdata(dev);
+	struct corgi_ts *corgi_ts = platform_get_drvdata(dev);
 
 	if (corgi_ts->pendown) {
 		del_timer_sync(&corgi_ts->timer);
@@ -248,9 +248,9 @@
 	return 0;
 }
 
-static int corgits_resume(struct device *dev)
+static int corgits_resume(struct platform_device *dev)
 {
-	struct corgi_ts *corgi_ts = dev_get_drvdata(dev);
+	struct corgi_ts *corgi_ts = platform_get_drvdata(dev);
 
 	corgi_ssp_ads7846_putget((4u << ADSCTRL_ADR_SH) | ADSCTRL_STS);
 	/* Enable Falling Edge */
@@ -264,10 +264,9 @@
 #define corgits_resume		NULL
 #endif
 
-static int __init corgits_probe(struct device *dev)
+static int __init corgits_probe(struct platform_device *pdev)
 {
 	struct corgi_ts *corgi_ts;
-	struct platform_device *pdev = to_platform_device(dev);
 	struct input_dev *input_dev;
 	int err = -ENOMEM;
 
@@ -276,9 +275,9 @@
	if (!corgi_ts || !input_dev)
 		goto fail;
 
-	dev_set_drvdata(dev, corgi_ts);
+	platform_set_drvdata(pdev, corgi_ts);
 
-	corgi_ts->machinfo = dev->platform_data;
+	corgi_ts->machinfo = pdev->dev.platform_data;
 	corgi_ts->irq_gpio = platform_get_irq(pdev, 0);
 
 	if (corgi_ts->irq_gpio < 0) {
@@ -298,7 +297,7 @@
 	input_dev->id.vendor = 0x0001;
 	input_dev->id.product = 0x0002;
 	input_dev->id.version = 0x0100;
-	input_dev->cdev.dev = dev;
+	input_dev->cdev.dev = &pdev->dev;
 	input_dev->private = corgi_ts;
 
 	input_dev->evbit[0] = BIT(EV_KEY) | BIT(EV_ABS);
@@ -339,9 +338,9 @@
 
 }
 
-static int corgits_remove(struct device *dev)
+static int corgits_remove(struct platform_device *pdev)
 {
-	struct corgi_ts *corgi_ts = dev_get_drvdata(dev);
+	struct corgi_ts *corgi_ts = platform_get_drvdata(pdev);
 
 	free_irq(corgi_ts->irq_gpio, NULL);
 	del_timer_sync(&corgi_ts->timer);
@@ -351,23 +350,24 @@
 	return 0;
 }
 
-static struct device_driver corgits_driver = {
-	.name		= "corgi-ts",
-	.bus		= &platform_bus_type,
+static struct platform_driver corgits_driver = {
 	.probe		= corgits_probe,
 	.remove		= corgits_remove,
 	.suspend	= corgits_suspend,
 	.resume		= corgits_resume,
+	.driver		= {
+		.name	= "corgi-ts",
+	},
 };
 
 static int __devinit corgits_init(void)
 {
-	return driver_register(&corgits_driver);
+	return platform_driver_register(&corgits_driver);
 }
 
 static void __exit corgits_exit(void)
 {
-	driver_unregister(&corgits_driver);
+	platform_driver_unregister(&corgits_driver);
 }
 
 module_init(corgits_init);
diff -u b/drivers/video/backlight/corgi_bl.c b/drivers/video/backlight/corgi_bl.c
--- b/drivers/video/backlight/corgi_bl.c
+++ b/drivers/video/backlight/corgi_bl.c
@@ -73,13 +73,13 @@
 }
 
 #ifdef CONFIG_PM
-static int corgibl_suspend(struct device *dev, pm_message_t state)
+static int corgibl_suspend(struct platform_device *dev, pm_message_t state)
 {
 	corgibl_blank(FB_BLANK_POWERDOWN);
 	return 0;
 }
 
-static int corgibl_resume(struct device *dev)
+static int corgibl_resume(struct platform_device *dev)
 {
 	corgibl_blank(FB_BLANK_UNBLANK);
 	return 0;
@@ -137,9 +137,9 @@
 
 static struct backlight_device *corgi_backlight_device;
 
-static int __init corgibl_probe(struct device *dev)
+static int __init corgibl_probe(struct platform_device *pdev)
 {
-	struct corgibl_machinfo *machinfo = dev->platform_data;
+	struct corgibl_machinfo *machinfo = pdev->dev.platform_data;
 
 	corgibl_data.max_brightness = machinfo->max_intensity;
 	corgibl_mach_set_intensity = machinfo->set_bl_intensity;
@@ -156,7 +156,7 @@
 	return 0;
 }
 
-static int corgibl_remove(struct device *dev)
+static int corgibl_remove(struct platform_device *dev)
 {
 	backlight_device_unregister(corgi_backlight_device);
 
@@ -166,23 +166,24 @@
 	return 0;
 }
 
-static struct device_driver corgibl_driver = {
-	.name		= "corgi-bl",
-	.bus		= &platform_bus_type,
+static struct platform_driver corgibl_driver = {
 	.probe		= corgibl_probe,
 	.remove		= corgibl_remove,
 	.suspend	= corgibl_suspend,
 	.resume		= corgibl_resume,
+	.driver		= {
+		.name	= "corgi-bl",
+	},
 };
 
 static int __init corgibl_init(void)
 {
-	return driver_register(&corgibl_driver);
+	return platform_driver_register(&corgibl_driver);
 }
 
 static void __exit corgibl_exit(void)
 {
- 	driver_unregister(&corgibl_driver);
+	platform_driver_unregister(&corgibl_driver);
 }
 
 module_init(corgibl_init);


-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
