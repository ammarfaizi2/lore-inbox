Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932150AbVKESP0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932150AbVKESP0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 13:15:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932160AbVKESP0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 13:15:26 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:37137 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932150AbVKESPX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 13:15:23 -0500
Date: Sat, 5 Nov 2005 18:15:15 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [DRIVER MODEL] Convert ARM SA1100 drivers
Message-ID: <20051105181515.GF14419@flint.arm.linux.org.uk>
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

diff -u b/drivers/mfd/mcp-sa11x0.c b/drivers/mfd/mcp-sa11x0.c
--- b/drivers/mfd/mcp-sa11x0.c
+++ b/drivers/mfd/mcp-sa11x0.c
@@ -138,9 +138,8 @@
 	.disable		= mcp_sa11x0_disable,
 };
 
-static int mcp_sa11x0_probe(struct device *dev)
+static int mcp_sa11x0_probe(struct platform_device *pdev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
	struct mcp_plat_data *data = pdev->dev.platform_data;
 	struct mcp *mcp;
 	int ret;
@@ -165,7 +164,7 @@
 	mcp->dma_telco_rd	= DMA_Ser4MCP1Rd;
 	mcp->dma_telco_wr	= DMA_Ser4MCP1Wr;
 
-	dev_set_drvdata(dev, mcp);
+	platform_set_drvdata(pdev, mcp);
 
 	if (machine_is_assabet()) {
 		ASSABET_BCR_set(ASSABET_BCR_CODEC_RST);
@@ -202,17 +201,17 @@
 
  release:
 	release_mem_region(0x80060000, 0x60);
-	dev_set_drvdata(dev, NULL);
+	platform_set_drvdata(pdev, NULL);
 
  out:
 	return ret;
 }
 
-static int mcp_sa11x0_remove(struct device *dev)
+static int mcp_sa11x0_remove(struct platform_device *dev)
 {
-	struct mcp *mcp = dev_get_drvdata(dev);
+	struct mcp *mcp = platform_get_drvdata(dev);
 
-	dev_set_drvdata(dev, NULL);
+	platform_set_drvdata(dev, NULL);
 	mcp_host_unregister(mcp);
 	release_mem_region(0x80060000, 0x60);
 
@@ -219,9 +218,9 @@
 	return 0;
 }
 
-static int mcp_sa11x0_suspend(struct device *dev, pm_message_t state)
+static int mcp_sa11x0_suspend(struct platform_device *dev, pm_message_t state)
 {
-	struct mcp *mcp = dev_get_drvdata(dev);
+	struct mcp *mcp = platform_get_drvdata(dev);
 
 	priv(mcp)->mccr0 = Ser4MCCR0;
 	priv(mcp)->mccr1 = Ser4MCCR1;
@@ -230,9 +229,9 @@
 	return 0;
 }
 
-static int mcp_sa11x0_resume(struct device *dev)
+static int mcp_sa11x0_resume(struct platform_device *dev)
 {
-	struct mcp *mcp = dev_get_drvdata(dev);
+	struct mcp *mcp = platform_get_drvdata(dev);
 
 	Ser4MCCR1 = priv(mcp)->mccr1;
 	Ser4MCCR0 = priv(mcp)->mccr0;
@@ -243,13 +242,14 @@
 /*
  * The driver for the SA11x0 MCP port.
  */
-static struct device_driver mcp_sa11x0_driver = {
-	.name		= "sa11x0-mcp",
-	.bus		= &platform_bus_type,
+static struct platform_driver mcp_sa11x0_driver = {
 	.probe		= mcp_sa11x0_probe,
 	.remove		= mcp_sa11x0_remove,
 	.suspend	= mcp_sa11x0_suspend,
 	.resume		= mcp_sa11x0_resume,
+	.driver		= {
+		.name	= "sa11x0-mcp",
+	},
 };
 
 /*
@@ -257,12 +257,12 @@
  */
 static int __init mcp_sa11x0_init(void)
 {
-	return driver_register(&mcp_sa11x0_driver);
+	return platform_driver_register(&mcp_sa11x0_driver);
 }
 
 static void __exit mcp_sa11x0_exit(void)
 {
-	driver_unregister(&mcp_sa11x0_driver);
+	platform_driver_unregister(&mcp_sa11x0_driver);
 }
 
 module_init(mcp_sa11x0_init);
diff -u b/drivers/mtd/maps/sa1100-flash.c b/drivers/mtd/maps/sa1100-flash.c
--- b/drivers/mtd/maps/sa1100-flash.c
+++ b/drivers/mtd/maps/sa1100-flash.c
@@ -357,9 +357,8 @@
 
 static const char *part_probes[] = { "cmdlinepart", "RedBoot", NULL };
 
-static int __init sa1100_mtd_probe(struct device *dev)
+static int __init sa1100_mtd_probe(struct platform_device *pdev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
 	struct flash_platform_data *plat = pdev->dev.platform_data;
 	struct mtd_partition *parts;
 	const char *part_type = NULL;
@@ -403,19 +402,19 @@
 
 	info->nr_parts = nr_parts;
 
-	dev_set_drvdata(dev, info);
+	platform_set_drvdata(pdev, info);
 	err = 0;
 
  out:
 	return err;
 }
 
-static int __exit sa1100_mtd_remove(struct device *dev)
+static int __exit sa1100_mtd_remove(struct platform_device *pdev)
 {
-	struct sa_info *info = dev_get_drvdata(dev);
+	struct sa_info *info = platform_get_drvdata(pdev);
 	struct flash_platform_data *plat = dev->platform_data;
 
-	dev_set_drvdata(dev, NULL);
+	platform_set_drvdata(pdev, NULL);
 	sa1100_destroy(info, plat);
 
 	return 0;
@@ -422,9 +421,9 @@
 }
 
 #ifdef CONFIG_PM
-static int sa1100_mtd_suspend(struct device *dev, pm_message_t state)
+static int sa1100_mtd_suspend(struct platform_device *dev, pm_message_t state)
 {
-	struct sa_info *info = dev_get_drvdata(dev);
+	struct sa_info *info = platform_get_drvdata(dev);
 	int ret = 0;
 
 	if (info)
@@ -433,9 +432,9 @@
 	return ret;
 }
 
-static int sa1100_mtd_resume(struct device *dev)
+static int sa1100_mtd_resume(struct platform_device *dev)
 {
-	struct sa_info *info = dev_get_drvdata(dev);
+	struct sa_info *info = platform_get_drvdata(dev);
 	if (info)
 		info->mtd->resume(info->mtd);
 	return 0;
@@ -453,24 +452,25 @@
 #define sa1100_mtd_shutdown NULL
 #endif
 
-static struct device_driver sa1100_mtd_driver = {
-	.name		= "flash",
-	.bus		= &platform_bus_type,
+static struct platform_driver sa1100_mtd_driver = {
 	.probe		= sa1100_mtd_probe,
 	.remove		= __exit_p(sa1100_mtd_remove),
 	.suspend	= sa1100_mtd_suspend,
 	.resume		= sa1100_mtd_resume,
 	.shutdown	= sa1100_mtd_shutdown,
+	.driver		= {
+		.name	= "flash",
+	},
 };
 
 static int __init sa1100_mtd_init(void)
 {
-	return driver_register(&sa1100_mtd_driver);
+	return platform_driver_register(&sa1100_mtd_driver);
 }
 
 static void __exit sa1100_mtd_exit(void)
 {
-	driver_unregister(&sa1100_mtd_driver);
+	platform_driver_unregister(&sa1100_mtd_driver);
 }
 
 module_init(sa1100_mtd_init);
diff -u b/drivers/net/irda/sa1100_ir.c b/drivers/net/irda/sa1100_ir.c
--- b/drivers/net/irda/sa1100_ir.c
+++ b/drivers/net/irda/sa1100_ir.c
@@ -291,9 +291,9 @@
 /*
  * Suspend the IrDA interface.
  */
-static int sa1100_irda_suspend(struct device *_dev, pm_message_t state)
+static int sa1100_irda_suspend(struct platform_device *pdev, pm_message_t state)
 {
-	struct net_device *dev = dev_get_drvdata(_dev);
+	struct net_device *dev = platform_get_drvdata(pdev);
 	struct sa1100_irda *si;
 
 	if (!dev)
@@ -316,9 +316,9 @@
 /*
  * Resume the IrDA interface.
  */
-static int sa1100_irda_resume(struct device *_dev)
+static int sa1100_irda_resume(struct platform_device *pdev)
 {
-	struct net_device *dev = dev_get_drvdata(_dev);
+	struct net_device *dev = platform_get_drvdata(pdev);
 	struct sa1100_irda *si;
 
 	if (!dev)
@@ -886,9 +886,8 @@
 	return io->head ? 0 : -ENOMEM;
 }
 
-static int sa1100_irda_probe(struct device *_dev)
+static int sa1100_irda_probe(struct platform_device *pdev)
 {
-	struct platform_device *pdev = to_platform_device(_dev);
 	struct net_device *dev;
 	struct sa1100_irda *si;
 	unsigned int baudrate_mask;
@@ -967,7 +966,7 @@
 
 	err = register_netdev(dev);
 	if (err == 0)
-		dev_set_drvdata(&pdev->dev, dev);
+		platform_set_drvdata(pdev, dev);
 
 	if (err) {
  err_mem_5:
@@ -985,9 +984,9 @@
 	return err;
 }
 
-static int sa1100_irda_remove(struct device *_dev)
+static int sa1100_irda_remove(struct platform_device *pdev)
 {
-	struct net_device *dev = dev_get_drvdata(_dev);
+	struct net_device *dev = platform_get_drvdata(pdev);
 
 	if (dev) {
 		struct sa1100_irda *si = dev->priv;
@@ -1004,13 +1003,14 @@
 	return 0;
 }
 
-static struct device_driver sa1100ir_driver = {
-	.name		= "sa11x0-ir",
-	.bus		= &platform_bus_type,
+static struct platform_driver sa1100ir_driver = {
 	.probe		= sa1100_irda_probe,
 	.remove		= sa1100_irda_remove,
 	.suspend	= sa1100_irda_suspend,
 	.resume		= sa1100_irda_resume,
+	.driver		= {
+		.name	= "sa11x0-ir",
+	},
 };
 
 static int __init sa1100_irda_init(void)
@@ -1023,12 +1023,12 @@
 	if (power_level > 3)
 		power_level = 3;
 
-	return driver_register(&sa1100ir_driver);
+	return platform_driver_register(&sa1100ir_driver);
 }
 
 static void __exit sa1100_irda_exit(void)
 {
-	driver_unregister(&sa1100ir_driver);
+	platform_driver_unregister(&sa1100ir_driver);
 }
 
 module_init(sa1100_irda_init);
diff -u b/drivers/serial/sa1100.c b/drivers/serial/sa1100.c
--- b/drivers/serial/sa1100.c
+++ b/drivers/serial/sa1100.c
@@ -834,9 +834,9 @@
 	.cons			= SA1100_CONSOLE,
 };
 
-static int sa1100_serial_suspend(struct device *_dev, pm_message_t state)
+static int sa1100_serial_suspend(struct platform_device *dev, pm_message_t state)
 {
-	struct sa1100_port *sport = dev_get_drvdata(_dev);
+	struct sa1100_port *sport = platform_get_drvdata(dev);
 
 	if (sport)
 		uart_suspend_port(&sa1100_reg, &sport->port);
@@ -844,9 +844,9 @@
 	return 0;
 }
 
-static int sa1100_serial_resume(struct device *_dev)
+static int sa1100_serial_resume(struct platform_device *dev)
 {
-	struct sa1100_port *sport = dev_get_drvdata(_dev);
+	struct sa1100_port *sport = platform_get_drvdata(dev);
 
 	if (sport)
 		uart_resume_port(&sa1100_reg, &sport->port);
@@ -854,9 +854,8 @@
 	return 0;
 }
 
-static int sa1100_serial_probe(struct device *_dev)
+static int sa1100_serial_probe(struct platform_device *dev)
 {
-	struct platform_device *dev = to_platform_device(_dev);
 	struct resource *res = dev->resource;
 	int i;
 
@@ -869,9 +868,9 @@
 			if (sa1100_ports[i].port.mapbase != res->start)
 				continue;
 
-			sa1100_ports[i].port.dev = _dev;
+			sa1100_ports[i].port.dev = &dev->dev;
 			uart_add_one_port(&sa1100_reg, &sa1100_ports[i].port);
-			dev_set_drvdata(_dev, &sa1100_ports[i]);
+			platform_set_drvdata(dev, &sa1100_ports[i]);
 			break;
 		}
 	}
@@ -879,11 +878,11 @@
 	return 0;
 }
 
-static int sa1100_serial_remove(struct device *_dev)
+static int sa1100_serial_remove(struct platform_device *pdev)
 {
-	struct sa1100_port *sport = dev_get_drvdata(_dev);
+	struct sa1100_port *sport = platform_get_drvdata(pdev);
 
-	dev_set_drvdata(_dev, NULL);
+	platform_set_drvdata(pdev, NULL);
 
 	if (sport)
 		uart_remove_one_port(&sa1100_reg, &sport->port);
@@ -891,13 +890,14 @@
 	return 0;
 }
 
-static struct device_driver sa11x0_serial_driver = {
-	.name		= "sa11x0-uart",
-	.bus		= &platform_bus_type,
+static struct platform_driver sa11x0_serial_driver = {
 	.probe		= sa1100_serial_probe,
 	.remove		= sa1100_serial_remove,
 	.suspend	= sa1100_serial_suspend,
 	.resume		= sa1100_serial_resume,
+	.driver		= {
+		.name	= "sa11x0-uart",
+	},
 };
 
 static int __init sa1100_serial_init(void)
@@ -910,7 +910,7 @@
 
 	ret = uart_register_driver(&sa1100_reg);
 	if (ret == 0) {
-		ret = driver_register(&sa11x0_serial_driver);
+		ret = platform_driver_register(&sa11x0_serial_driver);
 		if (ret)
 			uart_unregister_driver(&sa1100_reg);
 	}
@@ -919,7 +919,7 @@
 
 static void __exit sa1100_serial_exit(void)
 {
-	driver_unregister(&sa11x0_serial_driver);
+	platform_driver_unregister(&sa11x0_serial_driver);
 	uart_unregister_driver(&sa1100_reg);
 }
 
diff -u b/drivers/video/sa1100fb.c b/drivers/video/sa1100fb.c
--- b/drivers/video/sa1100fb.c
+++ b/drivers/video/sa1100fb.c
@@ -1309,17 +1309,17 @@
  * Power management hooks.  Note that we won't be called from IRQ context,
  * unlike the blank functions above, so we may sleep.
  */
-static int sa1100fb_suspend(struct device *dev, pm_message_t state)
+static int sa1100fb_suspend(struct platform_device *dev, pm_message_t state)
 {
-	struct sa1100fb_info *fbi = dev_get_drvdata(dev);
+	struct sa1100fb_info *fbi = platform_get_drvdata(dev);
 
 	set_ctrlr_state(fbi, C_DISABLE_PM);
 	return 0;
 }
 
-static int sa1100fb_resume(struct device *dev)
+static int sa1100fb_resume(struct platform_device *dev)
 {
-	struct sa1100fb_info *fbi = dev_get_drvdata(dev);
+	struct sa1100fb_info *fbi = platform_get_drvdata(dev);
 
 	set_ctrlr_state(fbi, C_ENABLE_PM);
 	return 0;
@@ -1453,7 +1453,7 @@
 	return fbi;
 }
 
-static int __init sa1100fb_probe(struct device *dev)
+static int __init sa1100fb_probe(struct platform_device *pdev)
 {
 	struct sa1100fb_info *fbi;
 	int ret;
@@ -1461,7 +1461,7 @@
 	if (!request_mem_region(0xb0100000, 0x10000, "LCD"))
 		return -EBUSY;
 
-	fbi = sa1100fb_init_fbinfo(dev);
+	fbi = sa1100fb_init_fbinfo(&pdev->dev);
 	ret = -ENOMEM;
 	if (!fbi)
 		goto failed;
@@ -1489,7 +1489,7 @@
 	 */
 	sa1100fb_check_var(&fbi->fb.var, &fbi->fb);
 
-	dev_set_drvdata(dev, fbi);
+	platform_set_drvdata(pdev, fbi);
 
 	ret = register_framebuffer(&fbi->fb);
 	if (ret < 0)
@@ -1506,18 +1506,19 @@
 	return 0;
 
 failed:
-	dev_set_drvdata(dev, NULL);
+	platform_set_drvdata(pdev, NULL);
 	kfree(fbi);
 	release_mem_region(0xb0100000, 0x10000);
 	return ret;
 }
 
-static struct device_driver sa1100fb_driver = {
-	.name		= "sa11x0-fb",
-	.bus		= &platform_bus_type,
+static struct platform_driver sa1100fb_driver = {
 	.probe		= sa1100fb_probe,
 	.suspend	= sa1100fb_suspend,
 	.resume		= sa1100fb_resume,
+	.driver		= {
+		.name	= "sa11x0-fb",
+	},
 };
 
 int __init sa1100fb_init(void)
@@ -1525,7 +1526,7 @@
 	if (fb_get_options("sa1100fb", NULL))
 		return -ENODEV;
 
-	return driver_register(&sa1100fb_driver);
+	return platform_driver_register(&sa1100fb_driver);
 }
 
 int __init sa1100fb_setup(char *options)


-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
