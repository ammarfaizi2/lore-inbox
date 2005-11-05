Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932174AbVKEST6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932174AbVKEST6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 13:19:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932186AbVKEST5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 13:19:57 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:32785 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932181AbVKESTi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 13:19:38 -0500
Date: Sat, 5 Nov 2005 18:19:32 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [DRIVER MODEL] Convert video drivers
Message-ID: <20051105181932.GS14419@flint.arm.linux.org.uk>
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

diff -u b/drivers/video/s1d13xxxfb.c b/drivers/video/s1d13xxxfb.c
--- b/drivers/video/s1d13xxxfb.c
+++ b/drivers/video/s1d13xxxfb.c
@@ -504,10 +504,9 @@
 
 
 static int
-s1d13xxxfb_remove(struct device *dev)
+s1d13xxxfb_remove(struct platform_device *pdev)
 {
-	struct fb_info *info = dev_get_drvdata(dev);
-	struct platform_device *pdev = to_platform_device(dev);
+	struct fb_info *info = platform_get_drvdata(pdev);
 	struct s1d13xxxfb_par *par = NULL;
 
 	if (info) {
@@ -535,9 +534,8 @@
 }
 
 static int __devinit
-s1d13xxxfb_probe(struct device *dev)
+s1d13xxxfb_probe(struct platform_device *pdev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
 	struct s1d13xxxfb_par *default_par;
 	struct fb_info *info;
 	struct s1d13xxxfb_pdata *pdata = NULL;
@@ -549,8 +547,8 @@
 	printk(KERN_INFO "Epson S1D13XXX FB Driver\n");
 
 	/* enable platform-dependent hardware glue, if any */
-	if (dev->platform_data)
-		pdata = dev->platform_data;
+	if (pdev->dev.platform_data)
+		pdata = pdev->dev.platform_data;
 
 	if (pdata && pdata->platform_init_video)
 		pdata->platform_init_video();
@@ -573,14 +571,14 @@
 
 	if (!request_mem_region(pdev->resource[0].start,
 		pdev->resource[0].end - pdev->resource[0].start +1, "s1d13xxxfb mem")) {
-		dev_dbg(dev, "request_mem_region failed\n");
+		dev_dbg(&pdev->dev, "request_mem_region failed\n");
 		ret = -EBUSY;
 		goto bail;
 	}
 
 	if (!request_mem_region(pdev->resource[1].start,
 		pdev->resource[1].end - pdev->resource[1].start +1, "s1d13xxxfb regs")) {
-		dev_dbg(dev, "request_mem_region failed\n");
+		dev_dbg(&pdev->dev, "request_mem_region failed\n");
 		ret = -EBUSY;
 		goto bail;
 	}
@@ -641,7 +639,7 @@
 		goto bail;
 	}
 
-	dev_set_drvdata(&pdev->dev, info);
+	platform_set_drvdata(pdev, info);
 
 	printk(KERN_INFO "fb%d: %s frame buffer device\n",
 	       info->node, info->fix.id);
@@ -649,15 +647,15 @@
 	return 0;
 
 bail:
-	s1d13xxxfb_remove(dev);
+	s1d13xxxfb_remove(pdev);
 	return ret;
 
 }
 
 #ifdef CONFIG_PM
-static int s1d13xxxfb_suspend(struct device *dev, pm_message_t state)
+static int s1d13xxxfb_suspend(struct platform_device *dev, pm_message_t state)
 {
-	struct fb_info *info = dev_get_drvdata(dev);
+	struct fb_info *info = platform_get_drvdata(dev);
 	struct s1d13xxxfb_par *s1dfb = info->par;
 	struct s1d13xxxfb_pdata *pdata = NULL;
 
@@ -665,8 +663,8 @@
 	lcd_enable(s1dfb, 0);
 	crt_enable(s1dfb, 0);
 
-	if (dev->platform_data)
-		pdata = dev->platform_data;
+	if (dev->dev.platform_data)
+		pdata = dev->dev.platform_data;
 
 #if 0
 	if (!s1dfb->disp_save)
@@ -702,9 +700,9 @@
 		return 0;
 }
 
-static int s1d13xxxfb_resume(struct device *dev)
+static int s1d13xxxfb_resume(struct platform_device *dev)
 {
-	struct fb_info *info = dev_get_drvdata(dev);
+	struct fb_info *info = platform_get_drvdata(dev);
 	struct s1d13xxxfb_par *s1dfb = info->par;
 	struct s1d13xxxfb_pdata *pdata = NULL;
 
@@ -715,8 +713,8 @@
 	while ((s1d13xxxfb_readreg(s1dfb, S1DREG_PS_STATUS) & 0x01))
 		udelay(10);
 
-	if (dev->platform_data)
-		pdata = dev->platform_data;
+	if (dev->dev.platform_data)
+		pdata = dev->dev.platform_data;
 
 	if (s1dfb->regs_save) {
 		/* will write RO regs, *should* get away with it :) */
@@ -742,15 +740,16 @@
 }
 #endif /* CONFIG_PM */
 
-static struct device_driver s1d13xxxfb_driver = {
-	.name		= S1D_DEVICENAME,
-	.bus		= &platform_bus_type,
+static struct platform_driver s1d13xxxfb_driver = {
 	.probe		= s1d13xxxfb_probe,
 	.remove		= s1d13xxxfb_remove,
 #ifdef CONFIG_PM
 	.suspend	= s1d13xxxfb_suspend,
 	.resume		= s1d13xxxfb_resume
 #endif
+	.driver		= {
+		.name	= S1D_DEVICENAME,
+	},
 };
 
 
@@ -760,14 +759,14 @@
 	if (fb_get_options("s1d13xxxfb", NULL))
 		return -ENODEV;
 
-	return driver_register(&s1d13xxxfb_driver);
+	return platform_driver_register(&s1d13xxxfb_driver);
 }
 
 
 static void __exit
 s1d13xxxfb_exit(void)
 {
-	driver_unregister(&s1d13xxxfb_driver);
+	platform_driver_unregister(&s1d13xxxfb_driver);
 }
 
 module_init(s1d13xxxfb_init);
diff -u b/drivers/video/w100fb.c b/drivers/video/w100fb.c
--- b/drivers/video/w100fb.c
+++ b/drivers/video/w100fb.c
@@ -438,9 +438,9 @@
 	}
 }
 
-static int w100fb_suspend(struct device *dev, pm_message_t state)
+static int w100fb_suspend(struct platform_device *dev, pm_message_t state)
 {
-	struct fb_info *info = dev_get_drvdata(dev);
+	struct fb_info *info = platform_get_drvdata(dev);
 	struct w100fb_par *par=info->par;
 	struct w100_tg_info *tg = par->mach->tg;
 
@@ -453,9 +453,9 @@
 	return 0;
 }
 
-static int w100fb_resume(struct device *dev)
+static int w100fb_resume(struct platform_device *dev)
 {
-	struct fb_info *info = dev_get_drvdata(dev);
+	struct fb_info *info = platform_get_drvdata(dev);
 	struct w100fb_par *par=info->par;
 	struct w100_tg_info *tg = par->mach->tg;
 
@@ -474,13 +474,12 @@
 #endif
 
 
-int __init w100fb_probe(struct device *dev)
+int __init w100fb_probe(struct platform_device *pdev)
 {
 	int err = -EIO;
 	struct w100fb_mach_info *inf;
 	struct fb_info *info = NULL;
 	struct w100fb_par *par;
-	struct platform_device *pdev = to_platform_device(dev);
 	struct resource *mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	unsigned int chip_id;
 
@@ -523,9 +522,9 @@
 	}
 
 	par = info->par;
-	dev_set_drvdata(dev, info);
+	platform_set_drvdata(pdev, info);
 
-	inf = dev->platform_data;
+	inf = pdev->dev.platform_data;
 	par->chip_id = chip_id;
 	par->mach = inf;
 	par->fastpll_mode = 0;
@@ -601,10 +600,10 @@
 		goto out;
 	}
 
-	device_create_file(dev, &dev_attr_fastpllclk);
-	device_create_file(dev, &dev_attr_reg_read);
-	device_create_file(dev, &dev_attr_reg_write);
-	device_create_file(dev, &dev_attr_flip);
+	device_create_file(&pdev->dev, &dev_attr_fastpllclk);
+	device_create_file(&pdev->dev, &dev_attr_reg_read);
+	device_create_file(&pdev->dev, &dev_attr_reg_write);
+	device_create_file(&pdev->dev, &dev_attr_flip);
 
 	printk(KERN_INFO "fb%d: %s frame buffer device\n", info->node, info->fix.id);
 	return 0;
@@ -623,15 +622,15 @@
 }
 
 
-static int w100fb_remove(struct device *dev)
+static int w100fb_remove(struct platform_device *pdev)
 {
-	struct fb_info *info = dev_get_drvdata(dev);
+	struct fb_info *info = platform_get_drvdata(pdev);
 	struct w100fb_par *par=info->par;
 
-	device_remove_file(dev, &dev_attr_fastpllclk);
-	device_remove_file(dev, &dev_attr_reg_read);
-	device_remove_file(dev, &dev_attr_reg_write);
-	device_remove_file(dev, &dev_attr_flip);
+	device_remove_file(&pdev->dev, &dev_attr_fastpllclk);
+	device_remove_file(&pdev->dev, &dev_attr_reg_read);
+	device_remove_file(&pdev->dev, &dev_attr_reg_write);
+	device_remove_file(&pdev->dev, &dev_attr_flip);
 
 	unregister_framebuffer(info);
 
@@ -1449,23 +1448,24 @@
 	writel(0x00000002, remapped_regs + mmGEN_INT_STATUS);
 }
 
-static struct device_driver w100fb_driver = {
-	.name		= "w100fb",
-	.bus		= &platform_bus_type,
+static struct platform_driver w100fb_driver = {
 	.probe		= w100fb_probe,
 	.remove		= w100fb_remove,
 	.suspend	= w100fb_suspend,
 	.resume		= w100fb_resume,
+	.driver		= {
+		.name	= "w100fb",
+	},
 };
 
 int __devinit w100fb_init(void)
 {
-	return driver_register(&w100fb_driver);
+	return platform_driver_register(&w100fb_driver);
 }
 
 void __exit w100fb_cleanup(void)
 {
- 	driver_unregister(&w100fb_driver);
+	platform_driver_unregister(&w100fb_driver);
 }
 
 module_init(w100fb_init);
diff -u b/drivers/video/acornfb.c b/drivers/video/acornfb.c
--- b/drivers/video/acornfb.c
+++ b/drivers/video/acornfb.c
@@ -1280,7 +1280,7 @@
 	printk("acornfb: freed %dK memory\n", mb_freed);
 }
 
-static int __init acornfb_probe(struct device *dev)
+static int __init acornfb_probe(struct platform_device *dev)
 {
 	unsigned long size;
 	u_int h_sync, v_sync;
@@ -1293,7 +1293,7 @@
 
 	acornfb_init_fbinfo();
 
-	current_par.dev = dev;
+	current_par.dev = &dev->dev;
 
 	if (current_par.montype == -1)
 		current_par.montype = acornfb_detect_monitortype();
@@ -1454,15 +1454,16 @@
 	return 0;
 }
 
-static struct device_driver acornfb_driver = {
-	.name	= "acornfb",
-	.bus	= &platform_bus_type,
+static struct platform_driver acornfb_driver = {
 	.probe	= acornfb_probe,
+	.driver	= {
+		.name	= "acornfb",
+	},
 };
 
 static int __init acornfb_init(void)
 {
-	return driver_register(&acornfb_driver);
+	return platform_driver_register(&acornfb_driver);
 }
 
 module_init(acornfb_init);
diff -u b/drivers/video/arcfb.c b/drivers/video/arcfb.c
--- b/drivers/video/arcfb.c
+++ b/drivers/video/arcfb.c
@@ -515,9 +515,8 @@
 	.fb_ioctl 	= arcfb_ioctl,
 };
 
-static int __init arcfb_probe(struct device *device)
+static int __init arcfb_probe(struct platform_device *dev)
 {
-	struct platform_device *dev = to_platform_device(device);
 	struct fb_info *info;
 	int retval = -ENOMEM;
 	int videomemorysize;
@@ -560,7 +559,7 @@
 	retval = register_framebuffer(info);
 	if (retval < 0)
 		goto err1;
-	dev_set_drvdata(&dev->dev, info);
+	platform_set_drvdata(dev, info);
 	if (irq) {
 		par->irq = irq;
 		if (request_irq(par->irq, &arcfb_interrupt, SA_SHIRQ,
@@ -601,9 +600,9 @@
 	return retval;
 }
 
-static int arcfb_remove(struct device *device)
+static int arcfb_remove(struct platform_device *dev)
 {
-	struct fb_info *info = dev_get_drvdata(device);
+	struct fb_info *info = platform_get_drvdata(dev);
 
 	if (info) {
 		unregister_framebuffer(info);
@@ -613,11 +612,12 @@
 	return 0;
 }
 
-static struct device_driver arcfb_driver = {
-	.name	= "arcfb",
-	.bus	= &platform_bus_type,
+static struct platform_driver arcfb_driver = {
 	.probe	= arcfb_probe,
 	.remove = arcfb_remove,
+	.driver	= {
+		.name	= "arcfb",
+	},
 };
 
 static struct platform_device *arcfb_device;
@@ -629,7 +630,7 @@
 	if (!arcfb_enable)
 		return -ENXIO;
 
-	ret = driver_register(&arcfb_driver);
+	ret = platform_driver_register(&arcfb_driver);
 	if (!ret) {
 		arcfb_device = platform_device_alloc("arcfb", 0);
 		if (arcfb_device) {
@@ -639,7 +639,7 @@
 		}
 		if (ret) {
 			platform_device_put(arcfb_device);
-			driver_unregister(&arcfb_driver);
+			platform_driver_unregister(&arcfb_driver);
 		}
 	}
 	return ret;
@@ -649,7 +649,7 @@
 static void __exit arcfb_exit(void)
 {
 	platform_device_unregister(arcfb_device);
-	driver_unregister(&arcfb_driver);
+	platform_driver_unregister(&arcfb_driver);
 }
 
 module_param(num_cols, ulong, 0);
diff -u b/drivers/video/dnfb.c b/drivers/video/dnfb.c
--- b/drivers/video/dnfb.c
+++ b/drivers/video/dnfb.c
@@ -228,9 +228,8 @@
  * Initialization
  */
 
-static int __devinit dnfb_probe(struct device *device)
+static int __devinit dnfb_probe(struct platform_device *dev)
 {
-	struct platform_device *dev = to_platform_device(device);
 	struct fb_info *info;
 	int err = 0;
 
@@ -258,7 +257,7 @@
 		framebuffer_release(info);
 		return err;
 	}
-	dev_set_drvdata(&dev->dev, info);
+	platform_set_drvdata(dev, info);
 
 	/* now we have registered we can safely setup the hardware */
 	out_8(AP_CONTROL_3A, RESET_CREG);
@@ -272,10 +271,11 @@
 	return err;
 }
 
-static struct device_driver dnfb_driver = {
-	.name	= "dnfb",
-	.bus	= &platform_bus_type,
+static struct platform_driver dnfb_driver = {
 	.probe	= dnfb_probe,
+	.driver	= {
+		.name	= "dnfb",
+	},
 };
 
 static struct platform_device dnfb_device = {
@@ -289,12 +289,12 @@
 	if (fb_get_options("dnfb", NULL))
 		return -ENODEV;
 
-	ret = driver_register(&dnfb_driver);
+	ret = platform_driver_register(&dnfb_driver);
 
 	if (!ret) {
 		ret = platform_device_register(&dnfb_device);
 		if (ret)
-			driver_unregister(&dnfb_driver);
+			platform_driver_unregister(&dnfb_driver);
 	}
 	return ret;
 }
diff -u b/drivers/video/epson1355fb.c b/drivers/video/epson1355fb.c
--- b/drivers/video/epson1355fb.c
+++ b/drivers/video/epson1355fb.c
@@ -610,9 +610,9 @@
 {
 }
 
-static int epson1355fb_remove(struct device *device)
+static int epson1355fb_remove(struct platform_device *dev)
 {
-	struct fb_info *info = dev_get_drvdata(device);
+	struct fb_info *info = platform_get_drvdata(dev);
 	struct epson1355_par *par = info->par;
 
 	backlight_enable(0);
@@ -633,9 +633,8 @@
 	return 0;
 }
 
-int __init epson1355fb_probe(struct device *device)
+int __init epson1355fb_probe(struct platform_device *dev)
 {
-	struct platform_device *dev = to_platform_device(device);
 	struct epson1355_par *default_par;
 	struct fb_info *info;
 	u8 revision;
@@ -714,7 +713,7 @@
 	/*
 	 * Our driver data.
 	 */
-	dev_set_drvdata(&dev->dev, info);
+	platform_set_drvdata(dev, info);
 
 	printk(KERN_INFO "fb%d: %s frame buffer device\n",
 	       info->node, info->fix.id);
@@ -722,15 +721,16 @@
 	return 0;
 
       bail:
-	epson1355fb_remove(device);
+	epson1355fb_remove(dev);
 	return rc;
 }
 
-static struct device_driver epson1355fb_driver = {
-	.name	= "epson1355fb",
-	.bus	= &platform_bus_type,
+static struct platform_driver epson1355fb_driver = {
 	.probe	= epson1355fb_probe,
 	.remove	= epson1355fb_remove,
+	.driver	= {
+		.name	= "epson1355fb",
+	},
 };
 
 static struct platform_device epson1355fb_device = {
@@ -748,11 +748,11 @@
 	if (fb_get_options("epson1355fb", NULL))
 		return -ENODEV;
 
-	ret = driver_register(&epson1355fb_driver);
+	ret = platform_driver_register(&epson1355fb_driver);
 	if (!ret) {
 		ret = platform_device_register(&epson1355fb_device);
 		if (ret)
-			driver_unregister(&epson1355fb_driver);
+			platform_driver_unregister(&epson1355fb_driver);
 	}
 	return ret;
 }
@@ -763,7 +763,7 @@
 static void __exit epson1355fb_exit(void)
 {
 	platform_device_unregister(&epson1355fb_device);
-	driver_unregister(&epson1355fb_driver);
+	platform_driver_unregister(&epson1355fb_driver);
 }
 
 /* ------------------------------------------------------------------------- */
diff -u b/drivers/video/gbefb.c b/drivers/video/gbefb.c
--- b/drivers/video/gbefb.c
+++ b/drivers/video/gbefb.c
@@ -1106,12 +1106,11 @@
 	return 0;
 }
 
-static int __init gbefb_probe(struct device *dev)
+static int __init gbefb_probe(struct platform_device *p_dev)
 {
 	int i, ret = 0;
 	struct fb_info *info;
 	struct gbefb_par *par;
-	struct platform_device *p_dev = to_platform_device(dev);
 #ifndef MODULE
 	char *options = NULL;
 #endif
@@ -1205,8 +1204,8 @@
 		goto out_gbe_unmap;
 	}
 
-	dev_set_drvdata(&p_dev->dev, info);
-	gbefb_create_sysfs(dev);
+	platform_set_drvdata(p_dev, info);
+	gbefb_create_sysfs(&p_dev->dev);
 
 	printk(KERN_INFO "fb%d: %s rev %d @ 0x%08x using %dkB memory\n",
 	       info->node, info->fix.id, gbe_revision, (unsigned) GBE_BASE,
@@ -1232,10 +1231,9 @@
 	return ret;
 }
 
-static int __devexit gbefb_remove(struct device* dev)
+static int __devexit gbefb_remove(struct platform_device* p_dev)
 {
-	struct platform_device *p_dev = to_platform_device(dev);
-	struct fb_info *info = dev_get_drvdata(&p_dev->dev);
+	struct fb_info *info = platform_get_drvdata(p_dev);
 
 	unregister_framebuffer(info);
 	gbe_turn_off();
@@ -1253,11 +1251,12 @@
 	return 0;
 }
 
-static struct device_driver gbefb_driver = {
-	.name = "gbefb",
-	.bus = &platform_bus_type,
+static struct platform_driver gbefb_driver = {
 	.probe = gbefb_probe,
 	.remove = __devexit_p(gbefb_remove),
+	.driver	= {
+		.name = "gbefb",
+	},
 };
 
 static struct platform_device *gbefb_device;
@@ -1264,7 +1263,7 @@
 
 int __init gbefb_init(void)
 {
-	int ret = driver_register(&gbefb_driver);
+	int ret = platform_driver_register(&gbefb_driver);
 	if (!ret) {
 		gbefb_device = platform_device_alloc("gbefb", 0);
 		if (gbefb_device) {
@@ -1274,16 +1273,16 @@
 		}
 		if (ret) {
 			platform_device_put(gbefb_device);
-			driver_unregister(&gbefb_driver);
+			platform_driver_unregister(&gbefb_driver);
 		}
 	}
 	return ret;
 }
 
 void __exit gbefb_exit(void)
 {
 	platform_device_unregister(gbefb_device);
-	driver_unregister(&gbefb_driver);
+	platform_driver_unregister(&gbefb_driver);
 }
 
 module_init(gbefb_init);
diff -u b/drivers/video/q40fb.c b/drivers/video/q40fb.c
--- b/drivers/video/q40fb.c
+++ b/drivers/video/q40fb.c
@@ -87,9 +87,8 @@
 	.fb_cursor	= soft_cursor,
 };
 
-static int __init q40fb_probe(struct device *device)
+static int __init q40fb_probe(struct platform_device *dev)
 {
-	struct platform_device *dev = to_platform_device(device);
 	struct fb_info *info;
 
 	if (!MACH_IS_Q40)
@@ -129,10 +128,11 @@
 	return 0;
 }
 
-static struct device_driver q40fb_driver = {
-	.name	= "q40fb",
-	.bus	= &platform_bus_type,
+static struct platform_driver q40fb_driver = {
 	.probe	= q40fb_probe,
+	.driver	= {
+		.name	= "q40fb",
+	},
 };
 
 static struct platform_device q40fb_device = {
@@ -146,12 +146,12 @@
 	if (fb_get_options("q40fb", NULL))
 		return -ENODEV;
 
-	ret = driver_register(&q40fb_driver);
+	ret = platform_driver_register(&q40fb_driver);
 
 	if (!ret) {
 		ret = platform_device_register(&q40fb_device);
 		if (ret)
-			driver_unregister(&q40fb_driver);
+			platform_driver_unregister(&q40fb_driver);
 	}
 	return ret;
 }
diff -u b/drivers/video/sgivwfb.c b/drivers/video/sgivwfb.c
--- b/drivers/video/sgivwfb.c
+++ b/drivers/video/sgivwfb.c
@@ -751,9 +751,8 @@
 /*
  *  Initialisation
  */
-static int __init sgivwfb_probe(struct device *device)
+static int __init sgivwfb_probe(struct platform_device *dev)
 {
-	struct platform_device *dev = to_platform_device(device);
 	struct sgivw_par *par;
 	struct fb_info *info;
 	char *monitor;
@@ -814,7 +813,7 @@
 		goto fail_register_framebuffer;
 	}
 
-	dev_set_drvdata(&dev->dev, info);
+	platform_set_drvdata(dev, info);
 
 	printk(KERN_INFO "fb%d: SGI DBE frame buffer device, using %ldK of video memory at %#lx\n",      
 		info->node, sgivwfb_mem_size >> 10, sgivwfb_mem_phys);
@@ -832,9 +831,9 @@
 	return -ENXIO;
 }
 
-static int sgivwfb_remove(struct device *device)
+static int sgivwfb_remove(struct platform_device *dev)
 {
-	struct fb_info *info = dev_get_drvdata(device);
+	struct fb_info *info = platform_get_drvdata(dev);
 
 	if (info) {
 		struct sgivw_par *par = info->par;
@@ -848,11 +847,12 @@
 	return 0;
 }
 
-static struct device_driver sgivwfb_driver = {
-	.name	= "sgivwfb",
-	.bus	= &platform_bus_type,
+static struct platform_driver sgivwfb_driver = {
 	.probe	= sgivwfb_probe,
 	.remove	= sgivwfb_remove,
+	.driver	= {
+		.name	= "sgivwfb",
+	},
 };
 
 static struct platform_device *sgivwfb_device;
@@ -868,15 +868,15 @@
 		return -ENODEV;
 	sgivwfb_setup(option);
 #endif
-	ret = driver_register(&sgivwfb_driver);
+	ret = platform_driver_register(&sgivwfb_driver);
 	if (!ret) {
 		sgivwfb_device = platform_device_alloc("sgivwfb", 0);
 		if (sgivwfb_device) {
 			ret = platform_device_add(sgivwfb_device);
 		} else
 			ret = -ENOMEM;
 		if (ret) {
-			driver_unregister(&sgivwfb_driver);
+			platform_driver_unregister(&sgivwfb_driver);
 			platform_device_put(sgivwfb_device);
 		}
 	}
@@ -891,7 +891,7 @@
 static void __exit sgivwfb_exit(void)
 {
 	platform_device_unregister(sgivwfb_device);
-	driver_unregister(&sgivwfb_driver);
+	platform_driver_unregister(&sgivwfb_driver);
 }
 
 module_exit(sgivwfb_exit);
diff -u b/drivers/video/vesafb.c b/drivers/video/vesafb.c
--- b/drivers/video/vesafb.c
+++ b/drivers/video/vesafb.c
@@ -252,9 +252,8 @@
 	return 0;
 }
 
-static int __init vesafb_probe(struct device *device)
+static int __init vesafb_probe(struct platform_device *dev)
 {
-	struct platform_device *dev = to_platform_device(device);
 	struct fb_info *info;
 	int i, err;
 	unsigned int size_vmode;
@@ -487,10 +486,11 @@
 	return err;
 }
 
-static struct device_driver vesafb_driver = {
-	.name	= "vesafb",
-	.bus	= &platform_bus_type,
+static struct platform_driver vesafb_driver = {
 	.probe	= vesafb_probe,
+	.driver	= {
+		.name	= "vesafb",
+	},
 };
 
 static struct platform_device vesafb_device = {
@@ -505,12 +505,12 @@
 	/* ignore error return of fb_get_options */
 	fb_get_options("vesafb", &option);
 	vesafb_setup(option);
-	ret = driver_register(&vesafb_driver);
+	ret = platform_driver_register(&vesafb_driver);
 
 	if (!ret) {
 		ret = platform_device_register(&vesafb_device);
 		if (ret)
-			driver_unregister(&vesafb_driver);
+			platform_driver_unregister(&vesafb_driver);
 	}
 	return ret;
 }
diff -u b/drivers/video/vfb.c b/drivers/video/vfb.c
--- b/drivers/video/vfb.c
+++ b/drivers/video/vfb.c
@@ -404,9 +404,8 @@
 	// This is called when the reference count goes to zero.
 }
 
-static int __init vfb_probe(struct device *device)
+static int __init vfb_probe(struct platform_device *dev)
 {
-	struct platform_device *dev = to_platform_device(device);
 	struct fb_info *info;
 	int retval = -ENOMEM;
 
@@ -448,7 +447,7 @@
 	retval = register_framebuffer(info);
 	if (retval < 0)
 		goto err2;
-	dev_set_drvdata(&dev->dev, info);
+	platform_set_drvdata(dev, info);
 
 	printk(KERN_INFO
 	       "fb%d: Virtual frame buffer device, using %ldK of video memory\n",
@@ -463,9 +462,9 @@
 	return retval;
 }
 
-static int vfb_remove(struct device *device)
+static int vfb_remove(struct platform_device *dev)
 {
-	struct fb_info *info = dev_get_drvdata(device);
+	struct fb_info *info = platform_get_drvdata(dev);
 
 	if (info) {
 		unregister_framebuffer(info);
@@ -475,11 +474,12 @@
 	return 0;
 }
 
-static struct device_driver vfb_driver = {
-	.name	= "vfb",
-	.bus	= &platform_bus_type,
+static struct platform_driver vfb_driver = {
 	.probe	= vfb_probe,
 	.remove = vfb_remove,
+	.driver = {
+		.name	= "vfb",
+	},
 };
 
 static struct platform_device vfb_device = {
@@ -505,12 +505,12 @@
 	if (!vfb_enable)
 		return -ENXIO;
 
-	ret = driver_register(&vfb_driver);
+	ret = platform_driver_register(&vfb_driver);
 
 	if (!ret) {
 		ret = platform_device_register(&vfb_device);
 		if (ret)
-			driver_unregister(&vfb_driver);
+			platform_driver_unregister(&vfb_driver);
 	}
 	return ret;
 }
@@ -521,7 +521,7 @@
 static void __exit vfb_exit(void)
 {
 	platform_device_unregister(&vfb_device);
-	driver_unregister(&vfb_driver);
+	platform_driver_unregister(&vfb_driver);
 }
 
 module_exit(vfb_exit);


-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
