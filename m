Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932148AbVKESQf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932148AbVKESQf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 13:16:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932164AbVKESQe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 13:16:34 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:37905 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932160AbVKESQc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 13:16:32 -0500
Date: Sat, 5 Nov 2005 18:16:26 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [DRIVER MODEL] Convert ARM OMAP drivers
Message-ID: <20051105181626.GI14419@flint.arm.linux.org.uk>
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

diff --git a/drivers/i2c/chips/isp1301_omap.c b/drivers/i2c/chips/isp1301_omap.c
--- a/drivers/i2c/chips/isp1301_omap.c
+++ b/drivers/i2c/chips/isp1301_omap.c
@@ -873,26 +873,27 @@ static int otg_init(struct isp1301 *isp)
 	return 0;
 }
 
-static int otg_probe(struct device *dev)
+static int otg_probe(struct platform_device *dev)
 {
 	// struct omap_usb_config *config = dev->platform_data;
 
-	otg_dev = to_platform_device(dev);
+	otg_dev = dev;
 	return 0;
 }
 
-static int otg_remove(struct device *dev)
+static int otg_remove(struct platform_device *dev)
 {
 	otg_dev = 0;
 	return 0;
 }
 
-struct device_driver omap_otg_driver = {
-	.owner		= THIS_MODULE,
-	.name		= "omap_otg",
-	.bus		= &platform_bus_type,
+struct platform_driver omap_otg_driver = {
 	.probe		= otg_probe,
-	.remove		= otg_remove,	
+	.remove		= otg_remove,
+	.driver		= {
+		.owner	= THIS_MODULE,
+		.name	= "omap_otg",
+	},
 };
 
 static int otg_bind(struct isp1301 *isp)
@@ -902,7 +903,7 @@ static int otg_bind(struct isp1301 *isp)
 	if (otg_dev)
 		return -EBUSY;
 
-	status = driver_register(&omap_otg_driver);
+	status = platform_driver_register(&omap_otg_driver);
 	if (status < 0)
 		return status;
 
@@ -913,7 +914,7 @@ static int otg_bind(struct isp1301 *isp)
 		status = -ENODEV;
 
 	if (status < 0)
-		driver_unregister(&omap_otg_driver);
+		platform_driver_unregister(&omap_otg_driver);
 	return status;
 }
 
diff -u b/drivers/usb/gadget/omap_udc.c b/drivers/usb/gadget/omap_udc.c
--- b/drivers/usb/gadget/omap_udc.c
+++ b/drivers/usb/gadget/omap_udc.c
@@ -2707,18 +2707,17 @@
 	return 0;
 }
 
-static int __init omap_udc_probe(struct device *dev)
+static int __init omap_udc_probe(struct platform_device *pdev)
 {
-	struct platform_device	*odev = to_platform_device(dev);
 	int			status = -ENODEV;
 	int			hmc;
 	struct otg_transceiver	*xceiv = NULL;
 	const char		*type = NULL;
-	struct omap_usb_config	*config = dev->platform_data;
+	struct omap_usb_config	*config = pdev->dev.platform_data;
 
 	/* NOTE:  "knows" the order of the resources! */
-	if (!request_mem_region(odev->resource[0].start, 
-			odev->resource[0].end - odev->resource[0].start + 1,
+	if (!request_mem_region(pdev->resource[0].start, 
+			pdev->resource[0].end - pdev->resource[0].start + 1,
 			driver_name)) {
 		DBG("request_mem_region failed\n");
 		return -EBUSY;
@@ -2803,7 +2802,7 @@
 	INFO("hmc mode %d, %s transceiver\n", hmc, type);
 
 	/* a "gadget" abstracts/virtualizes the controller */
-	status = omap_udc_setup(odev, xceiv);
+	status = omap_udc_setup(pdev, xceiv);
 	if (status) {
 		goto cleanup0;
 	}
@@ -2821,28 +2820,28 @@
 		udc->clr_halt = UDC_RESET_EP;
 
 	/* USB general purpose IRQ:  ep0, state changes, dma, etc */
-	status = request_irq(odev->resource[1].start, omap_udc_irq,
+	status = request_irq(pdev->resource[1].start, omap_udc_irq,
 			SA_SAMPLE_RANDOM, driver_name, udc);
 	if (status != 0) {
 		ERR( "can't get irq %ld, err %d\n",
-			odev->resource[1].start, status);
+			pdev->resource[1].start, status);
 		goto cleanup1;
 	}
 
 	/* USB "non-iso" IRQ (PIO for all but ep0) */
-	status = request_irq(odev->resource[2].start, omap_udc_pio_irq,
+	status = request_irq(pdev->resource[2].start, omap_udc_pio_irq,
 			SA_SAMPLE_RANDOM, "omap_udc pio", udc);
 	if (status != 0) {
 		ERR( "can't get irq %ld, err %d\n",
-			odev->resource[2].start, status);
+			pdev->resource[2].start, status);
 		goto cleanup2;
 	}
 #ifdef	USE_ISO
-	status = request_irq(odev->resource[3].start, omap_udc_iso_irq,
+	status = request_irq(pdev->resource[3].start, omap_udc_iso_irq,
 			SA_INTERRUPT, "omap_udc iso", udc);
 	if (status != 0) {
 		ERR("can't get irq %ld, err %d\n",
-			odev->resource[3].start, status);
+			pdev->resource[3].start, status);
 		goto cleanup3;
 	}
 #endif
@@ -2853,11 +2852,11 @@
 
 #ifdef	USE_ISO
 cleanup3:
-	free_irq(odev->resource[2].start, udc);
+	free_irq(pdev->resource[2].start, udc);
 #endif
 
 cleanup2:
-	free_irq(odev->resource[1].start, udc);
+	free_irq(pdev->resource[1].start, udc);
 
 cleanup1:
 	kfree (udc);
@@ -2866,14 +2865,13 @@
 cleanup0:
 	if (xceiv)
 		put_device(xceiv->dev);
-	release_mem_region(odev->resource[0].start,
-			odev->resource[0].end - odev->resource[0].start + 1);
+	release_mem_region(pdev->resource[0].start,
+			pdev->resource[0].end - pdev->resource[0].start + 1);
 	return status;
 }
 
-static int __exit omap_udc_remove(struct device *dev)
+static int __exit omap_udc_remove(struct platform_device *pdev)
 {
-	struct platform_device	*odev = to_platform_device(dev);
 	DECLARE_COMPLETION(done);
 
 	if (!udc)
@@ -2891,13 +2889,13 @@
 	remove_proc_file();
 
 #ifdef	USE_ISO
-	free_irq(odev->resource[3].start, udc);
+	free_irq(pdev->resource[3].start, udc);
 #endif
-	free_irq(odev->resource[2].start, udc);
-	free_irq(odev->resource[1].start, udc);
+	free_irq(pdev->resource[2].start, udc);
+	free_irq(pdev->resource[1].start, udc);
 
-	release_mem_region(odev->resource[0].start,
-			odev->resource[0].end - odev->resource[0].start + 1);
+	release_mem_region(pdev->resource[0].start,
+			pdev->resource[0].end - pdev->resource[0].start + 1);
 
 	device_unregister(&udc->gadget.dev);
 	wait_for_completion(&done);
@@ -2915,7 +2913,7 @@
  * may involve talking to an external transceiver (e.g. isp1301).
  */
 
-static int omap_udc_suspend(struct device *dev, pm_message_t message)
+static int omap_udc_suspend(struct platform_device *dev, pm_message_t message)
 {
 	u32	devstat;
 
@@ -2935,7 +2933,7 @@
 	return 0;
 }
 
-static int omap_udc_resume(struct device *dev)
+static int omap_udc_resume(struct platform_device *dev)
 {
 	DBG("resume + wakeup/SRP\n");
 	omap_pullup(&udc->gadget, 1);
@@ -2947,14 +2945,15 @@
 
 /*-------------------------------------------------------------------------*/
 
-static struct device_driver udc_driver = {
-	.name		= (char *) driver_name,
-	.owner		= THIS_MODULE,
-	.bus		= &platform_bus_type,
+static struct platform_driver udc_driver = {
 	.probe		= omap_udc_probe,
 	.remove		= __exit_p(omap_udc_remove),
 	.suspend	= omap_udc_suspend,
 	.resume		= omap_udc_resume,
+	.driver		= {
+		.owner	= THIS_MODULE,
+		.name	= (char *) driver_name,
+	},
 };
 
 static int __init udc_init(void)
@@ -2965,13 +2964,13 @@
 #endif
 		"%s\n", driver_desc,
 		use_dma ?  " (dma)" : "");
-	return driver_register(&udc_driver);
+	return platform_driver_register(&udc_driver);
 }
 module_init(udc_init);
 
 static void __exit udc_exit(void)
 {
-	driver_unregister(&udc_driver);
+	platform_driver_unregister(&udc_driver);
 }
 module_exit(udc_exit);
 
diff -u b/drivers/usb/host/ohci-omap.c b/drivers/usb/host/ohci-omap.c
--- b/drivers/usb/host/ohci-omap.c
+++ b/drivers/usb/host/ohci-omap.c
@@ -433,24 +433,22 @@
 
 /*-------------------------------------------------------------------------*/
 
-static int ohci_hcd_omap_drv_probe(struct device *dev)
+static int ohci_hcd_omap_drv_probe(struct platform_device *dev)
 {
-	return usb_hcd_omap_probe(&ohci_omap_hc_driver,
-				to_platform_device(dev));
+	return usb_hcd_omap_probe(&ohci_omap_hc_driver, dev);
 }
 
-static int ohci_hcd_omap_drv_remove(struct device *dev)
+static int ohci_hcd_omap_drv_remove(struct platform_device *dev)
 {
-	struct platform_device	*pdev = to_platform_device(dev);
-	struct usb_hcd		*hcd = dev_get_drvdata(dev);
+	struct usb_hcd		*hcd = platform_get_drvdata(dev);
 	struct ohci_hcd		*ohci = hcd_to_ohci (hcd);
 
-	usb_hcd_omap_remove(hcd, pdev);
+	usb_hcd_omap_remove(hcd, dev);
 	if (ohci->transceiver) {
 		(void) otg_set_host(ohci->transceiver, 0);
 		put_device(ohci->transceiver->dev);
 	}
-	dev_set_drvdata(dev, NULL);
+	platform_set_drvdata(dev, NULL);
 
 	return 0;
 }
@@ -459,9 +457,9 @@
 
 #ifdef	CONFIG_PM
 
-static int ohci_omap_suspend(struct device *dev, pm_message_t message)
+static int ohci_omap_suspend(struct platform_device *dev, pm_message_t message)
 {
-	struct ohci_hcd	*ohci = hcd_to_ohci(dev_get_drvdata(dev));
+	struct ohci_hcd	*ohci = hcd_to_ohci(platform_get_drvdata(dev));
 
 	if (time_before(jiffies, ohci->next_statechange))
 		msleep(5);
@@ -473,9 +471,9 @@
 	return 0;
 }
 
-static int ohci_omap_resume(struct device *dev)
+static int ohci_omap_resume(struct platform_device *dev)
 {
-	struct ohci_hcd	*ohci = hcd_to_ohci(dev_get_drvdata(dev));
+	struct ohci_hcd	*ohci = hcd_to_ohci(platform_get_drvdata(dev));
 
 	if (time_before(jiffies, ohci->next_statechange))
 		msleep(5);
@@ -494,16 +492,17 @@
 /*
  * Driver definition to register with the OMAP bus
  */
-static struct device_driver ohci_hcd_omap_driver = {
-	.name		= "ohci",
-	.owner		= THIS_MODULE,
-	.bus		= &platform_bus_type,
+static struct platform_driver ohci_hcd_omap_driver = {
 	.probe		= ohci_hcd_omap_drv_probe,
 	.remove		= ohci_hcd_omap_drv_remove,
 #ifdef	CONFIG_PM
 	.suspend	= ohci_omap_suspend,
 	.resume		= ohci_omap_resume,
 #endif
+	.driver		= {
+		.owner	= THIS_MODULE,
+		.name	= "ohci",
+	},
 };
 
 static int __init ohci_hcd_omap_init (void)
@@ -515,12 +514,12 @@
 	pr_debug("%s: block sizes: ed %Zd td %Zd\n", hcd_name,
 		sizeof (struct ed), sizeof (struct td));
 
-	return driver_register(&ohci_hcd_omap_driver);
+	return platform_driver_register(&ohci_hcd_omap_driver);
 }
 
 static void __exit ohci_hcd_omap_cleanup (void)
 {
-	driver_unregister(&ohci_hcd_omap_driver);
+	platform_driver_unregister(&ohci_hcd_omap_driver);
 }
 
 module_init (ohci_hcd_omap_init);


-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
