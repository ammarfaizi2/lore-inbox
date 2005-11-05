Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932142AbVKESQH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932142AbVKESQH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 13:16:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932148AbVKESQH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 13:16:07 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:37649 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932142AbVKESQE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 13:16:04 -0500
Date: Sat, 5 Nov 2005 18:15:59 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [DRIVER MODEL] Convert ARM IMX drivers
Message-ID: <20051105181558.GH14419@flint.arm.linux.org.uk>
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

diff -u b/drivers/serial/imx.c b/drivers/serial/imx.c
--- b/drivers/serial/imx.c
+++ b/drivers/serial/imx.c
@@ -921,9 +921,9 @@
 	.cons           = IMX_CONSOLE,
 };
 
-static int serial_imx_suspend(struct device *_dev, pm_message_t state)
+static int serial_imx_suspend(struct platform_device *dev, pm_message_t state)
 {
-        struct imx_port *sport = dev_get_drvdata(_dev);
+        struct imx_port *sport = platform_get_drvdata(dev);
 
         if (sport)
                 uart_suspend_port(&imx_reg, &sport->port);
@@ -931,9 +931,9 @@
         return 0;
 }
 
-static int serial_imx_resume(struct device *_dev)
+static int serial_imx_resume(struct platform_device *dev)
 {
-        struct imx_port *sport = dev_get_drvdata(_dev);
+        struct imx_port *sport = platform_get_drvdata(dev);
 
         if (sport)
                 uart_resume_port(&imx_reg, &sport->port);
@@ -941,21 +941,19 @@
         return 0;
 }
 
-static int serial_imx_probe(struct device *_dev)
+static int serial_imx_probe(struct platform_device *dev)
 {
-	struct platform_device *dev = to_platform_device(_dev);
-
-	imx_ports[dev->id].port.dev = _dev;
+	imx_ports[dev->id].port.dev = &dev->dev;
 	uart_add_one_port(&imx_reg, &imx_ports[dev->id].port);
-	dev_set_drvdata(_dev, &imx_ports[dev->id]);
+	platform_set_drvdata(dev, &imx_ports[dev->id]);
 	return 0;
 }
 
-static int serial_imx_remove(struct device *_dev)
+static int serial_imx_remove(struct platform_device *dev)
 {
-	struct imx_port *sport = dev_get_drvdata(_dev);
+	struct imx_port *sport = platform_get_drvdata(dev);
 
-	dev_set_drvdata(_dev, NULL);
+	platform_set_drvdata(dev, NULL);
 
 	if (sport)
 		uart_remove_one_port(&imx_reg, &sport->port);
@@ -963,14 +961,15 @@
 	return 0;
 }
 
-static struct device_driver serial_imx_driver = {
-        .name           = "imx-uart",
-        .bus            = &platform_bus_type,
+static struct platform_driver serial_imx_driver = {
         .probe          = serial_imx_probe,
         .remove         = serial_imx_remove,
 
 	.suspend	= serial_imx_suspend,
 	.resume		= serial_imx_resume,
+	.driver		= {
+	        .name	= "imx-uart",
+	},
 };
 
 static int __init imx_serial_init(void)
@@ -985,7 +984,7 @@
 	if (ret)
 		return ret;
 
-	ret = driver_register(&serial_imx_driver);
+	ret = platform_driver_register(&serial_imx_driver);
 	if (ret != 0)
 		uart_unregister_driver(&imx_reg);
 
diff -u b/drivers/video/imxfb.c b/drivers/video/imxfb.c
--- b/drivers/video/imxfb.c
+++ b/drivers/video/imxfb.c
@@ -424,18 +424,18 @@
  * Power management hooks.  Note that we won't be called from IRQ context,
  * unlike the blank functions above, so we may sleep.
  */
-static int imxfb_suspend(struct device *dev, pm_message_t state)
+static int imxfb_suspend(struct platform_device *dev, pm_message_t state)
 {
-	struct imxfb_info *fbi = dev_get_drvdata(dev);
+	struct imxfb_info *fbi = platform_get_drvdata(dev);
 	pr_debug("%s\n",__FUNCTION__);
 
 	imxfb_disable_controller(fbi);
 	return 0;
 }
 
-static int imxfb_resume(struct device *dev)
+static int imxfb_resume(struct platform_device *dev)
 {
-	struct imxfb_info *fbi = dev_get_drvdata(dev);
+	struct imxfb_info *fbi = platform_get_drvdata(dev);
 	pr_debug("%s\n",__FUNCTION__);
 
 	imxfb_enable_controller(fbi);
@@ -539,9 +539,8 @@
 	return fbi->map_cpu ? 0 : -ENOMEM;
 }
 
-static int __init imxfb_probe(struct device *dev)
+static int __init imxfb_probe(struct platform_device *pdev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
 	struct imxfb_info *fbi;
 	struct fb_info *info;
 	struct imxfb_mach_info *inf;
@@ -554,21 +553,21 @@
 	if(!res)
 		return -ENODEV;
 
-	inf = dev->platform_data;
+	inf = pdev->dev.platform_data;
 	if(!inf) {
 		dev_err(dev,"No platform_data available\n");
 		return -ENOMEM;
 	}
 
-	info = framebuffer_alloc(sizeof(struct imxfb_info), dev);
+	info = framebuffer_alloc(sizeof(struct imxfb_info), &pdev->dev);
 	if(!info)
 		return -ENOMEM;
 
 	fbi = info->par;
 
-	dev_set_drvdata(dev, info);
+	platform_set_drvdata(pdev, info);
 
-	ret = imxfb_init_fbinfo(dev);
+	ret = imxfb_init_fbinfo(&pdev->dev);
 	if( ret < 0 )
 		goto failed_init;
 
@@ -622,22 +621,21 @@
 	fb_dealloc_cmap(&info->cmap);
 failed_cmap:
 	if (!inf->fixed_screen_cpu)
-		dma_free_writecombine(dev,fbi->map_size,fbi->map_cpu,
+		dma_free_writecombine(&pdev->dev,fbi->map_size,fbi->map_cpu,
 		           fbi->map_dma);
 failed_map:
 	kfree(info->pseudo_palette);
 failed_regs:
 	release_mem_region(res->start, res->end - res->start);
 failed_init:
-	dev_set_drvdata(dev, NULL);
+	platform_set_drvdata(pdev, NULL);
 	framebuffer_release(info);
 	return ret;
 }
 
-static int imxfb_remove(struct device *dev)
+static int imxfb_remove(struct platform_device *pdev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct fb_info *info = dev_get_drvdata(dev);
+	struct fb_info *info = platform_get_drvdata(pdev);
 	struct imxfb_info *fbi = info->par;
 	struct resource *res;
 
@@ -652,14 +650,14 @@
 	framebuffer_release(info);
 
 	release_mem_region(res->start, res->end - res->start + 1);
-	dev_set_drvdata(dev, NULL);
+	platform_set_drvdata(pdev, NULL);
 
 	return 0;
 }
 
-void  imxfb_shutdown(struct device * dev)
+void  imxfb_shutdown(struct platform_device * dev)
 {
-	struct fb_info *info = dev_get_drvdata(dev);
+	struct fb_info *info = platform_get_drvdata(dev);
 	struct imxfb_info *fbi = info->par;
 	imxfb_disable_controller(fbi);
 }
@@ -664,24 +662,25 @@
 	imxfb_disable_controller(fbi);
 }
 
-static struct device_driver imxfb_driver = {
-	.name		= "imx-fb",
-	.bus		= &platform_bus_type,
+static struct platform_driver imxfb_driver = {
 	.probe		= imxfb_probe,
 	.suspend	= imxfb_suspend,
 	.resume		= imxfb_resume,
 	.remove		= imxfb_remove,
 	.shutdown	= imxfb_shutdown,
+	.driver		= {
+		.name	= "imx-fb",
+	},
 };
 
 int __init imxfb_init(void)
 {
-	return driver_register(&imxfb_driver);
+	return platform_driver_register(&imxfb_driver);
 }
 
 static void __exit imxfb_cleanup(void)
 {
-	driver_unregister(&imxfb_driver);
+	platform_driver_unregister(&imxfb_driver);
 }
 
 module_init(imxfb_init);

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
