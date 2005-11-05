Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932133AbVKESNF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932133AbVKESNF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 13:13:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932134AbVKESNF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 13:13:05 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:36113 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932133AbVKESND (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 13:13:03 -0500
Date: Sat, 5 Nov 2005 18:12:57 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [DRIVER MODEL] Convert arch/arm
Message-ID: <20051105181256.GB14419@flint.arm.linux.org.uk>
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

diff -u b/arch/arm/common/locomo.c b/arch/arm/common/locomo.c
--- b/arch/arm/common/locomo.c
+++ b/arch/arm/common/locomo.c
@@ -550,9 +550,9 @@
 	u16	LCM_SPIMD;
 };
 
-static int locomo_suspend(struct device *dev, pm_message_t state)
+static int locomo_suspend(struct platform_device *dev, pm_message_t state)
 {
-	struct locomo *lchip = dev_get_drvdata(dev);
+	struct locomo *lchip = platform_get_drvdata(dev);
 	struct locomo_save_data *save;
 	unsigned long flags;
 
@@ -560,7 +560,7 @@
 	if (!save)
 		return -ENOMEM;
 
-	dev->power.saved_state = (void *) save;
+	dev->dev.power.saved_state = (void *) save;
 
 	spin_lock_irqsave(&lchip->lock, flags);
 
@@ -594,14 +594,14 @@
 	return 0;
 }
 
-static int locomo_resume(struct device *dev)
+static int locomo_resume(struct platform_device *dev)
 {
-	struct locomo *lchip = dev_get_drvdata(dev);
+	struct locomo *lchip = platform_get_drvdata(dev);
 	struct locomo_save_data *save;
 	unsigned long r;
 	unsigned long flags;
 	
-	save = (struct locomo_save_data *) dev->power.saved_state;
+	save = (struct locomo_save_data *) dev->dev.power.saved_state;
 	if (!save)
 		return 0;
 
@@ -760,27 +760,26 @@
 	kfree(lchip);
 }
 
-static int locomo_probe(struct device *dev)
+static int locomo_probe(struct platform_device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
 	struct resource *mem;
 	int irq;
 
-	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	mem = platform_get_resource(dev, IORESOURCE_MEM, 0);
 	if (!mem)
 		return -EINVAL;
-	irq = platform_get_irq(pdev, 0);
+	irq = platform_get_irq(dev, 0);
 
-	return __locomo_probe(dev, mem, irq);
+	return __locomo_probe(&dev->dev, mem, irq);
 }
 
-static int locomo_remove(struct device *dev)
+static int locomo_remove(struct platform_device *dev)
 {
-	struct locomo *lchip = dev_get_drvdata(dev);
+	struct locomo *lchip = platform__get_drvdata(dev);
 
 	if (lchip) {
 		__locomo_remove(lchip);
-		dev_set_drvdata(dev, NULL);
+		platform_set_drvdata(dev, NULL);
 	}
 
 	return 0;
@@ -792,15 +791,16 @@
  *	the per-machine level, and then have this driver pick
  *	up the registered devices.
  */
-static struct device_driver locomo_device_driver = {
-	.name		= "locomo",
-	.bus		= &platform_bus_type,
+static struct platform_driver locomo_device_driver = {
 	.probe		= locomo_probe,
 	.remove		= locomo_remove,
 #ifdef CONFIG_PM
 	.suspend	= locomo_suspend,
 	.resume		= locomo_resume,
 #endif
+	.driver		= {
+		.name	= "locomo",
+	},
 };
 
 /*
@@ -1126,13 +1126,13 @@
 {
 	int ret = bus_register(&locomo_bus_type);
 	if (ret == 0)
-		driver_register(&locomo_device_driver);
+		platform_driver_register(&locomo_device_driver);
 	return ret;
 }
 
 static void __exit locomo_exit(void)
 {
-	driver_unregister(&locomo_device_driver);
+	platform_driver_unregister(&locomo_device_driver);
 	bus_unregister(&locomo_bus_type);
 }
 
diff -u b/arch/arm/common/sa1111.c b/arch/arm/common/sa1111.c
--- b/arch/arm/common/sa1111.c
+++ b/arch/arm/common/sa1111.c
@@ -801,9 +801,9 @@
 
 #ifdef CONFIG_PM
 
-static int sa1111_suspend(struct device *dev, pm_message_t state)
+static int sa1111_suspend(struct platform_device *dev, pm_message_t state)
 {
-	struct sa1111 *sachip = dev_get_drvdata(dev);
+	struct sa1111 *sachip = platform_get_drvdata(dev);
 	struct sa1111_save_data *save;
 	unsigned long flags;
 	unsigned int val;
@@ -812,7 +812,7 @@
 	save = kmalloc(sizeof(struct sa1111_save_data), GFP_KERNEL);
 	if (!save)
 		return -ENOMEM;
-	dev->power.saved_state = save;
+	dev->dev.power.saved_state = save;
 
 	spin_lock_irqsave(&sachip->lock, flags);
 
@@ -859,14 +859,14 @@
  *	restored by their respective drivers, and must be called
  *	via LDM after this function.
  */
-static int sa1111_resume(struct device *dev)
+static int sa1111_resume(struct platform_device *dev)
 {
-	struct sa1111 *sachip = dev_get_drvdata(dev);
+	struct sa1111 *sachip = platform_get_drvdata(dev);
 	struct sa1111_save_data *save;
 	unsigned long flags, id;
 	void __iomem *base;
 
-	save = (struct sa1111_save_data *)dev->power.saved_state;
+	save = (struct sa1111_save_data *)dev->dev.power.saved_state;
 	if (!save)
 		return 0;
 
@@ -879,7 +879,7 @@
 	id = sa1111_readl(sachip->base + SA1111_SKID);
 	if ((id & SKID_ID_MASK) != SKID_SA1111_ID) {
 		__sa1111_remove(sachip);
-		dev_set_drvdata(dev, NULL);
+		platform_set_drvdata(dev, NULL);
 		kfree(save);
 		return 0;
 	}
@@ -911,7 +911,7 @@
 
 	spin_unlock_irqrestore(&sachip->lock, flags);
 
-	dev->power.saved_state = NULL;
+	dev->dev.power.saved_state = NULL;
 	kfree(save);
 
 	return 0;
@@ -922,9 +922,8 @@
 #define sa1111_resume  NULL
 #endif
 
-static int sa1111_probe(struct device *dev)
+static int sa1111_probe(struct platform_device *pdev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
 	struct resource *mem;
 	int irq;
 
@@ -933,20 +932,20 @@
 		return -EINVAL;
 	irq = platform_get_irq(pdev, 0);
 
-	return __sa1111_probe(dev, mem, irq);
+	return __sa1111_probe(&pdev->dev, mem, irq);
 }
 
-static int sa1111_remove(struct device *dev)
+static int sa1111_remove(struct platform_device *pdev)
 {
-	struct sa1111 *sachip = dev_get_drvdata(dev);
+	struct sa1111 *sachip = platform_get_drvdata(pdev);
 
 	if (sachip) {
 		__sa1111_remove(sachip);
-		dev_set_drvdata(dev, NULL);
+		platform_set_drvdata(pdev, NULL);
 
 #ifdef CONFIG_PM
-		kfree(dev->power.saved_state);
-		dev->power.saved_state = NULL;
+		kfree(pdev->dev.power.saved_state);
+		pdev->dev.power.saved_state = NULL;
 #endif
 	}
 
@@ -962,13 +961,14 @@
  *	We also need to handle the SDRAM configuration for
  *	PXA250/SA1110 machine classes.
  */
-static struct device_driver sa1111_device_driver = {
-	.name		= "sa1111",
-	.bus		= &platform_bus_type,
+static struct platform_driver sa1111_device_driver = {
 	.probe		= sa1111_probe,
 	.remove		= sa1111_remove,
 	.suspend	= sa1111_suspend,
 	.resume		= sa1111_resume,
+	.driver		= {
+		.name	= "sa1111",
+	},
 };
 
 /*
@@ -1256,13 +1256,13 @@
 {
 	int ret = bus_register(&sa1111_bus_type);
 	if (ret == 0)
-		driver_register(&sa1111_device_driver);
+		platform_driver_register(&sa1111_device_driver);
 	return ret;
 }
 
 static void __exit sa1111_exit(void)
 {
-	driver_unregister(&sa1111_device_driver);
+	platform_driver_unregister(&sa1111_device_driver);
 	bus_unregister(&sa1111_bus_type);
 }
 
diff -u b/arch/arm/common/scoop.c b/arch/arm/common/scoop.c
--- b/arch/arm/common/scoop.c
+++ b/arch/arm/common/scoop.c
@@ -104,9 +104,9 @@
 }
 
 #ifdef CONFIG_PM
-static int scoop_suspend(struct device *dev, pm_message_t state)
+static int scoop_suspend(struct platform_device *dev, pm_message_t state)
 {
-	struct scoop_dev *sdev = dev_get_drvdata(dev);
+	struct scoop_dev *sdev = platform_get_drvdata(dev);
 
 	check_scoop_reg(sdev);
 	sdev->scoop_gpwr = SCOOP_REG(sdev->base, SCOOP_GPWR);
@@ -115,9 +115,9 @@
 	return 0;
 }
 
-static int scoop_resume(struct device *dev)
+static int scoop_resume(struct platform_device *dev)
 {
-	struct scoop_dev *sdev = dev_get_drvdata(dev);
+	struct scoop_dev *sdev = platform_get_drvdata(dev);
 
 	check_scoop_reg(sdev);
 	SCOOP_REG(sdev->base,SCOOP_GPWR) = sdev->scoop_gpwr;
@@ -129,11 +129,10 @@
 #define scoop_resume	NULL
 #endif
 
-int __init scoop_probe(struct device *dev)
+int __init scoop_probe(struct platform_device *pdev)
 {
 	struct scoop_dev *devptr;
 	struct scoop_config *inf;
-	struct platform_device *pdev = to_platform_device(dev);
 	struct resource *mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 
 	if (!mem)
@@ -147,7 +146,7 @@
 	memset(devptr, 0, sizeof(struct scoop_dev));
 	spin_lock_init(&devptr->scoop_lock);
 
-	inf = dev->platform_data;
+	inf = pdev->dev.platform_data;
 	devptr->base = ioremap(mem->start, mem->end - mem->start + 1);
 
 	if (!devptr->base) {
@@ -155,7 +154,7 @@
 		return -ENOMEM;
 	}
 
-	dev_set_drvdata(dev, devptr);
+	platform_set_drvdata(pdev, devptr);
 
 	printk("Sharp Scoop Device found at 0x%08x -> 0x%08x\n",(unsigned int)mem->start,(unsigned int)devptr->base);
 
@@ -170,29 +169,30 @@
 	return 0;
 }
 
-static int scoop_remove(struct device *dev)
+static int scoop_remove(struct platform_device *pdev)
 {
-	struct scoop_dev *sdev = dev_get_drvdata(dev);
+	struct scoop_dev *sdev = platform_get_drvdata(pdev);
 	if (sdev) {
 		iounmap(sdev->base);
 		kfree(sdev);
-		dev_set_drvdata(dev, NULL);
+		platform_set_drvdata(pdev, NULL);
 	}
 	return 0;
 }
 
-static struct device_driver scoop_driver = {
-	.name		= "sharp-scoop",
-	.bus		= &platform_bus_type,
+static struct platform_driver scoop_driver = {
 	.probe		= scoop_probe,
 	.remove 	= scoop_remove,
 	.suspend	= scoop_suspend,
 	.resume		= scoop_resume,
+	.driver		= {
+		.name	= "sharp-scoop",
+	},
 };
 
 int __init scoop_init(void)
 {
-	return driver_register(&scoop_driver);
+	return platform_driver_register(&scoop_driver);
 }
 
 subsys_initcall(scoop_init);
diff -u b/arch/arm/mach-pxa/corgi_ssp.c b/arch/arm/mach-pxa/corgi_ssp.c
--- b/arch/arm/mach-pxa/corgi_ssp.c
+++ b/arch/arm/mach-pxa/corgi_ssp.c
@@ -191,7 +191,7 @@
 	ssp_machinfo = machinfo;
 }
 
-static int __init corgi_ssp_probe(struct device *dev)
+static int __init corgi_ssp_probe(struct platform_device *dev)
 {
 	int ret;
 
@@ -216,7 +216,7 @@
 	return ret;
 }
 
-static int corgi_ssp_remove(struct device *dev)
+static int corgi_ssp_remove(struct platform_device *dev)
 {
 	ssp_exit(&corgi_ssp_dev);
 	return 0;
@@ -222,7 +222,7 @@
 	return 0;
 }
 
-static int corgi_ssp_suspend(struct device *dev, pm_message_t state)
+static int corgi_ssp_suspend(struct platform_device *dev, pm_message_t state)
 {
 	ssp_flush(&corgi_ssp_dev);
 	ssp_save_state(&corgi_ssp_dev,&corgi_ssp_state);
@@ -230,7 +230,7 @@
 	return 0;
 }
 
-static int corgi_ssp_resume(struct device *dev)
+static int corgi_ssp_resume(struct platform_device *dev)
 {
 	GPSR(ssp_machinfo->cs_lcdcon) = GPIO_bit(ssp_machinfo->cs_lcdcon);  /* High - Disable LCD Control/Timing Gen */
 	GPSR(ssp_machinfo->cs_max1111) = GPIO_bit(ssp_machinfo->cs_max1111); /* High - Disable MAX1111*/
@@ -241,18 +241,19 @@
 	return 0;
 }
 
-static struct device_driver corgissp_driver = {
-	.name		= "corgi-ssp",
-	.bus		= &platform_bus_type,
+static struct platform_driver corgissp_driver = {
 	.probe		= corgi_ssp_probe,
 	.remove		= corgi_ssp_remove,
 	.suspend	= corgi_ssp_suspend,
 	.resume		= corgi_ssp_resume,
+	.driver		= {
+		.name	= "corgi-ssp",
+	},
 };
 
 int __init corgi_ssp_init(void)
 {
-	return driver_register(&corgissp_driver);
+	return platform_driver_register(&corgissp_driver);
 }
 
 arch_initcall(corgi_ssp_init);
diff -u b/arch/arm/mach-sa1100/neponset.c b/arch/arm/mach-sa1100/neponset.c
--- b/arch/arm/mach-sa1100/neponset.c
+++ b/arch/arm/mach-sa1100/neponset.c
@@ -137,7 +137,7 @@
 	.get_mctrl	= neponset_get_mctrl,
 };
 
-static int neponset_probe(struct device *dev)
+static int neponset_probe(struct platform_device *dev)
 {
 	sa1100_register_uart_fns(&neponset_port_fns);
 
@@ -178,27 +178,27 @@
 /*
  * LDM power management.
  */
-static int neponset_suspend(struct device *dev, pm_message_t state)
+static int neponset_suspend(struct platform_device *dev, pm_message_t state)
 {
 	/*
 	 * Save state.
 	 */
-	if (!dev->power.saved_state)
-		dev->power.saved_state = kmalloc(sizeof(unsigned int), GFP_KERNEL);
-	if (!dev->power.saved_state)
+	if (!dev->dev.power.saved_state)
+		dev->dev.power.saved_state = kmalloc(sizeof(unsigned int), GFP_KERNEL);
+	if (!dev->dev.power.saved_state)
 		return -ENOMEM;
 
-	*(unsigned int *)dev->power.saved_state = NCR_0;
+	*(unsigned int *)dev->dev.power.saved_state = NCR_0;
 
 	return 0;
 }
 
-static int neponset_resume(struct device *dev)
+static int neponset_resume(struct platform_device *dev)
 {
-	if (dev->power.saved_state) {
-		NCR_0 = *(unsigned int *)dev->power.saved_state;
-		kfree(dev->power.saved_state);
-		dev->power.saved_state = NULL;
+	if (dev->dev.power.saved_state) {
+		NCR_0 = *(unsigned int *)dev->dev.power.saved_state;
+		kfree(dev->dev.power.saved_state);
+		dev->dev.power.saved_state = NULL;
 	}
 
 	return 0;
@@ -209,12 +209,13 @@
 #define neponset_resume  NULL
 #endif
 
-static struct device_driver neponset_device_driver = {
-	.name		= "neponset",
-	.bus		= &platform_bus_type,
+static struct platform_driver neponset_device_driver = {
 	.probe		= neponset_probe,
 	.suspend	= neponset_suspend,
 	.resume		= neponset_resume,
+	.driver		= {
+		.name	= "neponset",
+	},
 };
 
 static struct resource neponset_resources[] = {
@@ -293,7 +294,7 @@
 
 static int __init neponset_init(void)
 {
-	driver_register(&neponset_device_driver);
+	platform_driver_register(&neponset_device_driver);
 
 	/*
 	 * The Neponset is only present on the Assabet machine type.


-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
