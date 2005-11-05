Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932159AbVKESPw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932159AbVKESPw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 13:15:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932148AbVKESPw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 13:15:52 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:37393 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932160AbVKESPu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 13:15:50 -0500
Date: Sat, 5 Nov 2005 18:15:40 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [DRIVER MODEL] Convert ARM PXA drivers
Message-ID: <20051105181539.GG14419@flint.arm.linux.org.uk>
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

diff -u b/drivers/mmc/pxamci.c b/drivers/mmc/pxamci.c
--- b/drivers/mmc/pxamci.c
+++ b/drivers/mmc/pxamci.c
@@ -428,9 +428,8 @@
 	return IRQ_HANDLED;
 }
 
-static int pxamci_probe(struct device *dev)
+static int pxamci_probe(struct platform_device *pdev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
 	struct mmc_host *mmc;
 	struct pxamci_host *host = NULL;
 	struct resource *r;
@@ -445,7 +444,7 @@
 	if (!r)
 		return -EBUSY;
 
-	mmc = mmc_alloc_host(sizeof(struct pxamci_host), dev);
+	mmc = mmc_alloc_host(sizeof(struct pxamci_host), &pdev->dev);
 	if (!mmc) {
 		ret = -ENOMEM;
 		goto out;
@@ -474,7 +473,7 @@
 			 host->pdata->ocr_mask :
 			 MMC_VDD_32_33|MMC_VDD_33_34;
 
-	host->sg_cpu = dma_alloc_coherent(dev, PAGE_SIZE, &host->sg_dma, GFP_KERNEL);
+	host->sg_cpu = dma_alloc_coherent(&pdev->dev, PAGE_SIZE, &host->sg_dma, GFP_KERNEL);
 	if (!host->sg_cpu) {
 		ret = -ENOMEM;
 		goto out;
@@ -511,10 +510,10 @@
 	if (ret)
 		goto out;
 
-	dev_set_drvdata(dev, mmc);
+	platform_set_drvdata(pdev, mmc);
 
 	if (host->pdata && host->pdata->init)
-		host->pdata->init(dev, pxamci_detect_irq, mmc);
+		host->pdata->init(&pdev->dev, pxamci_detect_irq, mmc);
 
 	mmc_add_host(mmc);
 
@@ -527,7 +526,7 @@
 		if (host->base)
 			iounmap(host->base);
 		if (host->sg_cpu)
-			dma_free_coherent(dev, PAGE_SIZE, host->sg_cpu, host->sg_dma);
+			dma_free_coherent(&pdev->dev, PAGE_SIZE, host->sg_cpu, host->sg_dma);
 	}
 	if (mmc)
 		mmc_free_host(mmc);
@@ -535,17 +534,17 @@
 	return ret;
 }
 
-static int pxamci_remove(struct device *dev)
+static int pxamci_remove(struct platform_device *pdev)
 {
-	struct mmc_host *mmc = dev_get_drvdata(dev);
+	struct mmc_host *mmc = platform_get_drvdata(pdev);
 
-	dev_set_drvdata(dev, NULL);
+	platform_set_drvdata(pdev, NULL);
 
 	if (mmc) {
 		struct pxamci_host *host = mmc_priv(mmc);
 
 		if (host->pdata && host->pdata->exit)
-			host->pdata->exit(dev, mmc);
+			host->pdata->exit(&pdev->dev, mmc);
 
 		mmc_remove_host(mmc);
 
@@ -560,7 +559,7 @@
 		free_irq(host->irq, host);
 		pxa_free_dma(host->dma);
 		iounmap(host->base);
-		dma_free_coherent(dev, PAGE_SIZE, host->sg_cpu, host->sg_dma);
+		dma_free_coherent(&pdev->dev, PAGE_SIZE, host->sg_cpu, host->sg_dma);
 
 		release_resource(host->res);
 
@@ -570,9 +569,9 @@
 }
 
 #ifdef CONFIG_PM
-static int pxamci_suspend(struct device *dev, pm_message_t state)
+static int pxamci_suspend(struct platform_device *dev, pm_message_t state)
 {
-	struct mmc_host *mmc = dev_get_drvdata(dev);
+	struct mmc_host *mmc = platform_get_drvdata(dev);
 	int ret = 0;
 
 	if (mmc)
@@ -581,9 +580,9 @@
 	return ret;
 }
 
-static int pxamci_resume(struct device *dev)
+static int pxamci_resume(struct platform_device *dev)
 {
-	struct mmc_host *mmc = dev_get_drvdata(dev);
+	struct mmc_host *mmc = platform_get_drvdata(dev);
 	int ret = 0;
 
 	if (mmc)
@@ -596,23 +595,24 @@
 #define pxamci_resume	NULL
 #endif
 
-static struct device_driver pxamci_driver = {
-	.name		= DRIVER_NAME,
-	.bus		= &platform_bus_type,
+static struct platform_driver pxamci_driver = {
 	.probe		= pxamci_probe,
 	.remove		= pxamci_remove,
 	.suspend	= pxamci_suspend,
 	.resume		= pxamci_resume,
+	.driver		= {
+		.name	= DRIVER_NAME,
+	},
 };
 
 static int __init pxamci_init(void)
 {
-	return driver_register(&pxamci_driver);
+	return platform_driver_register(&pxamci_driver);
 }
 
 static void __exit pxamci_exit(void)
 {
-	driver_unregister(&pxamci_driver);
+	platform_driver_unregister(&pxamci_driver);
 }
 
 module_init(pxamci_init);
diff -u b/drivers/usb/gadget/pxa2xx_udc.c b/drivers/usb/gadget/pxa2xx_udc.c
--- b/drivers/usb/gadget/pxa2xx_udc.c
+++ b/drivers/usb/gadget/pxa2xx_udc.c
@@ -2433,7 +2433,7 @@
 /*
  * 	probe - binds to the platform device
  */
-static int __init pxa2xx_udc_probe(struct device *_dev)
+static int __init pxa2xx_udc_probe(struct platform_device *pdev)
 {
 	struct pxa2xx_udc *dev = &memory;
 	int retval, out_dma = 1;
@@ -2496,19 +2496,19 @@
 #endif
 
 	/* other non-static parts of init */
-	dev->dev = _dev;
-	dev->mach = _dev->platform_data;
+	dev->dev = &pdev->dev;
+	dev->mach = pdev->dev.platform_data;
 
 	init_timer(&dev->timer);
 	dev->timer.function = udc_watchdog;
 	dev->timer.data = (unsigned long) dev;
 
 	device_initialize(&dev->gadget.dev);
-	dev->gadget.dev.parent = _dev;
-	dev->gadget.dev.dma_mask = _dev->dma_mask;
+	dev->gadget.dev.parent = &pdev->dev;
+	dev->gadget.dev.dma_mask = pdev->dev.dma_mask;
 
 	the_controller = dev;
-	dev_set_drvdata(_dev, dev);
+	platform_set_drvdata(pdev, dev);
 
 	udc_disable(dev);
 	udc_reinit(dev);
@@ -2560,7 +2560,7 @@
 	return 0;
 }
 
-static void pxa2xx_udc_shutdown(struct device *_dev)
+static void pxa2xx_udc_shutdown(struct platform_device *_dev)
 {
 	pullup_off();
 }
@@ -2565,9 +2565,9 @@
 	pullup_off();
 }
 
-static int __exit pxa2xx_udc_remove(struct device *_dev)
+static int __exit pxa2xx_udc_remove(struct platform_device *pdev)
 {
-	struct pxa2xx_udc *dev = dev_get_drvdata(_dev);
+	struct pxa2xx_udc *dev = platform_get_drvdata(pdev);
 
 	udc_disable(dev);
 	remove_proc_files();
@@ -2581,7 +2581,7 @@
 		free_irq(LUBBOCK_USB_DISC_IRQ, dev);
 		free_irq(LUBBOCK_USB_IRQ, dev);
 	}
-	dev_set_drvdata(_dev, NULL);
+	platform_set_drvdata(pdev, NULL);
 	the_controller = NULL;
 	return 0;
 }
@@ -2602,9 +2602,9 @@
  * VBUS IRQs should probably be ignored so that the PXA device just acts
  * "dead" to USB hosts until system resume.
  */
-static int pxa2xx_udc_suspend(struct device *dev, pm_message_t state)
+static int pxa2xx_udc_suspend(struct platform_device *dev, pm_message_t state)
 {
-	struct pxa2xx_udc	*udc = dev_get_drvdata(dev);
+	struct pxa2xx_udc	*udc = platform_get_drvdata(dev);
 
 	if (!udc->mach->udc_command)
 		WARN("USB host won't detect disconnect!\n");
@@ -2613,9 +2613,9 @@
 	return 0;
 }
 
-static int pxa2xx_udc_resume(struct device *dev)
+static int pxa2xx_udc_resume(struct platform_device *dev)
 {
-	struct pxa2xx_udc	*udc = dev_get_drvdata(dev);
+	struct pxa2xx_udc	*udc = platform_get_drvdata(dev);
 
 	pullup(udc, 1);
 
@@ -2629,27 +2629,28 @@
 
 /*-------------------------------------------------------------------------*/
 
-static struct device_driver udc_driver = {
-	.name		= "pxa2xx-udc",
-	.owner		= THIS_MODULE,
-	.bus		= &platform_bus_type,
+static struct platform_driver udc_driver = {
 	.probe		= pxa2xx_udc_probe,
 	.shutdown	= pxa2xx_udc_shutdown,
 	.remove		= __exit_p(pxa2xx_udc_remove),
 	.suspend	= pxa2xx_udc_suspend,
 	.resume		= pxa2xx_udc_resume,
+	.driver		= {
+		.owner	= THIS_MODULE,
+		.name	= "pxa2xx-udc",
+	},
 };
 
 static int __init udc_init(void)
 {
 	printk(KERN_INFO "%s: version %s\n", driver_name, DRIVER_VERSION);
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
 
diff -u b/drivers/usb/host/ohci-pxa27x.c b/drivers/usb/host/ohci-pxa27x.c
--- b/drivers/usb/host/ohci-pxa27x.c
+++ b/drivers/usb/host/ohci-pxa27x.c
@@ -290,9 +290,8 @@
 
 /*-------------------------------------------------------------------------*/
 
-static int ohci_hcd_pxa27x_drv_probe(struct device *dev)
+static int ohci_hcd_pxa27x_drv_probe(struct platform_device *pdev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
 	int ret;
 
 	pr_debug ("In ohci_hcd_pxa27x_drv_probe");
@@ -304,41 +303,39 @@
 	return ret;
 }
 
-static int ohci_hcd_pxa27x_drv_remove(struct device *dev)
+static int ohci_hcd_pxa27x_drv_remove(struct platform_device *pdev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct usb_hcd *hcd = dev_get_drvdata(dev);
+	struct usb_hcd *hcd = platform_get_drvdata(pdev);
 
 	usb_hcd_pxa27x_remove(hcd, pdev);
 	return 0;
 }
 
-static int ohci_hcd_pxa27x_drv_suspend(struct device *dev, pm_message_t state)
+static int ohci_hcd_pxa27x_drv_suspend(struct platform_device *dev, pm_message_t state)
 {
-//	struct platform_device *pdev = to_platform_device(dev);
-//	struct usb_hcd *hcd = dev_get_drvdata(dev);
+//	struct usb_hcd *hcd = platform_get_drvdata(dev);
 	printk("%s: not implemented yet\n", __FUNCTION__);
 
 	return 0;
 }
 
-static int ohci_hcd_pxa27x_drv_resume(struct device *dev)
+static int ohci_hcd_pxa27x_drv_resume(struct platform_device *dev)
 {
-//	struct platform_device *pdev = to_platform_device(dev);
-//	struct usb_hcd *hcd = dev_get_drvdata(dev);
+//	struct usb_hcd *hcd = platform_get_drvdata(dev);
 	printk("%s: not implemented yet\n", __FUNCTION__);
 
 	return 0;
 }
 
 
-static struct device_driver ohci_hcd_pxa27x_driver = {
-	.name		= "pxa27x-ohci",
-	.bus		= &platform_bus_type,
+static struct platform_driver ohci_hcd_pxa27x_driver = {
 	.probe		= ohci_hcd_pxa27x_drv_probe,
 	.remove		= ohci_hcd_pxa27x_drv_remove,
 	.suspend	= ohci_hcd_pxa27x_drv_suspend, 
-	.resume		= ohci_hcd_pxa27x_drv_resume, 
+	.resume		= ohci_hcd_pxa27x_drv_resume,
+	.driver		= {
+		.name	= "pxa27x-ohci",
+	},
 };
 
 static int __init ohci_hcd_pxa27x_init (void)
@@ -347,12 +344,12 @@ static int __init ohci_hcd_pxa27x_init (
 	pr_debug ("block sizes: ed %d td %d\n",
 		sizeof (struct ed), sizeof (struct td));
 
-	return driver_register(&ohci_hcd_pxa27x_driver);
+	return platform_driver_register(&ohci_hcd_pxa27x_driver);
 }
 
 static void __exit ohci_hcd_pxa27x_cleanup (void)
 {
-	driver_unregister(&ohci_hcd_pxa27x_driver);
+	platform_driver_unregister(&ohci_hcd_pxa27x_driver);
 }
 
 module_init (ohci_hcd_pxa27x_init);
diff -u b/drivers/video/pxafb.c b/drivers/video/pxafb.c
--- b/drivers/video/pxafb.c
+++ b/drivers/video/pxafb.c
@@ -981,17 +981,17 @@
  * Power management hooks.  Note that we won't be called from IRQ context,
  * unlike the blank functions above, so we may sleep.
  */
-static int pxafb_suspend(struct device *dev, pm_message_t state)
+static int pxafb_suspend(struct platform_device *dev, pm_message_t state)
 {
-	struct pxafb_info *fbi = dev_get_drvdata(dev);
+	struct pxafb_info *fbi = platform_get_drvdata(dev);
 
 	set_ctrlr_state(fbi, C_DISABLE_PM);
 	return 0;
 }
 
-static int pxafb_resume(struct device *dev)
+static int pxafb_resume(struct platform_device *dev)
 {
-	struct pxafb_info *fbi = dev_get_drvdata(dev);
+	struct pxafb_info *fbi = platform_get_drvdata(dev);
 
 	set_ctrlr_state(fbi, C_ENABLE_PM);
 	return 0;
@@ -1269,7 +1269,7 @@
 }
 #endif
 
-int __init pxafb_probe(struct device *dev)
+int __init pxafb_probe(struct platform_device *dev)
 {
 	struct pxafb_info *fbi;
 	struct pxafb_mach_info *inf;
@@ -1277,14 +1277,14 @@
 
 	dev_dbg(dev, "pxafb_probe\n");
 
-	inf = dev->platform_data;
+	inf = dev->dev.platform_data;
 	ret = -ENOMEM;
 	fbi = NULL;
 	if (!inf)
 		goto failed;
 
 #ifdef CONFIG_FB_PXA_PARAMETERS
-	ret = pxafb_parse_options(dev, g_options);
+	ret = pxafb_parse_options(&dev->dev, g_options);
 	if (ret < 0)
 		goto failed;
 #endif
@@ -1294,28 +1294,28 @@
 	 * a warning is given. */
 
         if (inf->lccr0 & LCCR0_INVALID_CONFIG_MASK)
-                dev_warn(dev, "machine LCCR0 setting contains illegal bits: %08x\n",
+                dev_warn(&dev->dev, "machine LCCR0 setting contains illegal bits: %08x\n",
                         inf->lccr0 & LCCR0_INVALID_CONFIG_MASK);
         if (inf->lccr3 & LCCR3_INVALID_CONFIG_MASK)
-                dev_warn(dev, "machine LCCR3 setting contains illegal bits: %08x\n",
+                dev_warn(&dev->dev, "machine LCCR3 setting contains illegal bits: %08x\n",
                         inf->lccr3 & LCCR3_INVALID_CONFIG_MASK);
         if (inf->lccr0 & LCCR0_DPD &&
 	    ((inf->lccr0 & LCCR0_PAS) != LCCR0_Pas ||
 	     (inf->lccr0 & LCCR0_SDS) != LCCR0_Sngl ||
 	     (inf->lccr0 & LCCR0_CMS) != LCCR0_Mono))
-                dev_warn(dev, "Double Pixel Data (DPD) mode is only valid in passive mono"
+                dev_warn(&dev->dev, "Double Pixel Data (DPD) mode is only valid in passive mono"
 			 " single panel mode\n");
         if ((inf->lccr0 & LCCR0_PAS) == LCCR0_Act &&
 	    (inf->lccr0 & LCCR0_SDS) == LCCR0_Dual)
-                dev_warn(dev, "Dual panel only valid in passive mode\n");
+                dev_warn(&dev->dev, "Dual panel only valid in passive mode\n");
         if ((inf->lccr0 & LCCR0_PAS) == LCCR0_Pas &&
              (inf->upper_margin || inf->lower_margin))
-                dev_warn(dev, "Upper and lower margins must be 0 in passive mode\n");
+                dev_warn(&dev->dev, "Upper and lower margins must be 0 in passive mode\n");
 #endif
 
-	dev_dbg(dev, "got a %dx%dx%d LCD\n",inf->xres, inf->yres, inf->bpp);
+	dev_dbg(&dev->dev, "got a %dx%dx%d LCD\n",inf->xres, inf->yres, inf->bpp);
 	if (inf->xres == 0 || inf->yres == 0 || inf->bpp == 0) {
-		dev_err(dev, "Invalid resolution or bit depth\n");
+		dev_err(&dev->dev, "Invalid resolution or bit depth\n");
 		ret = -EINVAL;
 		goto failed;
 	}
@@ -1321,9 +1321,9 @@
 	}
 	pxafb_backlight_power = inf->pxafb_backlight_power;
 	pxafb_lcd_power = inf->pxafb_lcd_power;
-	fbi = pxafb_init_fbinfo(dev);
+	fbi = pxafb_init_fbinfo(&dev->dev);
 	if (!fbi) {
-		dev_err(dev, "Failed to initialize framebuffer device\n");
+		dev_err(&dev->dev, "Failed to initialize framebuffer device\n");
 		ret = -ENOMEM; // only reason for pxafb_init_fbinfo to fail is kmalloc
 		goto failed;
 	}
@@ -1331,14 +1331,14 @@
 	/* Initialize video memory */
 	ret = pxafb_map_video_memory(fbi);
 	if (ret) {
-		dev_err(dev, "Failed to allocate video RAM: %d\n", ret);
+		dev_err(&dev->dev, "Failed to allocate video RAM: %d\n", ret);
 		ret = -ENOMEM;
 		goto failed;
 	}
 
 	ret = request_irq(IRQ_LCD, pxafb_handle_irq, SA_INTERRUPT, "LCD", fbi);
 	if (ret) {
-		dev_err(dev, "request_irq failed: %d\n", ret);
+		dev_err(&dev->dev, "request_irq failed: %d\n", ret);
 		ret = -EBUSY;
 		goto failed;
 	}
@@ -1350,11 +1350,11 @@
 	pxafb_check_var(&fbi->fb.var, &fbi->fb);
 	pxafb_set_par(&fbi->fb);
 
-	dev_set_drvdata(dev, fbi);
+	platform_set_drvdata(dev, fbi);
 
 	ret = register_framebuffer(&fbi->fb);
 	if (ret < 0) {
-		dev_err(dev, "Failed to register framebuffer device: %d\n", ret);
+		dev_err(&dev->dev, "Failed to register framebuffer device: %d\n", ret);
 		goto failed;
 	}
 
@@ -1377,19 +1377,20 @@
 	return 0;
 
 failed:
-	dev_set_drvdata(dev, NULL);
+	platform_set_drvdata(dev, NULL);
 	kfree(fbi);
 	return ret;
 }
 
-static struct device_driver pxafb_driver = {
-	.name		= "pxa2xx-fb",
-	.bus		= &platform_bus_type,
+static struct platform_driver pxafb_driver = {
 	.probe		= pxafb_probe,
 #ifdef CONFIG_PM
 	.suspend	= pxafb_suspend,
 	.resume		= pxafb_resume,
 #endif
+	.driver		= {
+		.name	= "pxa2xx-fb",
+	},
 };
 
 #ifndef MODULE
@@ -1416,7 +1417,7 @@
 		return -ENODEV;
 	pxafb_setup(option);
 #endif
-	return driver_register(&pxafb_driver);
+	return platform_driver_register(&pxafb_driver);
 }
 
 module_init(pxafb_init);
diff -u b/sound/arm/pxa2xx-ac97.c b/sound/arm/pxa2xx-ac97.c
--- b/sound/arm/pxa2xx-ac97.c
+++ b/sound/arm/pxa2xx-ac97.c
@@ -275,9 +275,9 @@
 	return 0;
 }
 
-static int pxa2xx_ac97_suspend(struct device *_dev, pm_message_t state)
+static int pxa2xx_ac97_suspend(struct platform_device *dev, pm_message_t state)
 {
-	snd_card_t *card = dev_get_drvdata(_dev);
+	snd_card_t *card = platform_get_drvdata(dev);
 	int ret = 0;
 
 	if (card)
@@ -286,9 +286,9 @@
 	return ret;
 }
 
-static int pxa2xx_ac97_resume(struct device *_dev)
+static int pxa2xx_ac97_resume(struct platform_device *dev)
 {
-	snd_card_t *card = dev_get_drvdata(_dev);
+	snd_card_t *card = platform_get_drvdata(dev);
 	int ret = 0;
 
 	if (card)
@@ -302,7 +302,7 @@
 #define pxa2xx_ac97_resume	NULL
 #endif
 
-static int pxa2xx_ac97_probe(struct device *dev)
+static int pxa2xx_ac97_probe(struct platform_device *dev)
 {
 	snd_card_t *card;
 	ac97_bus_t *ac97_bus;
@@ -315,8 +315,8 @@
 	if (!card)
 		goto err;
 
-	card->dev = dev;
-	strncpy(card->driver, dev->driver->name, sizeof(card->driver));
+	card->dev = &dev->dev;
+	strncpy(card->driver, dev->dev.driver->name, sizeof(card->driver));
 
 	ret = pxa2xx_pcm_new(card, &pxa2xx_ac97_pcm_client, &pxa2xx_ac97_pcm);
 	if (ret)
@@ -347,13 +347,13 @@
 	snprintf(card->shortname, sizeof(card->shortname),
 		 "%s", snd_ac97_get_short_name(pxa2xx_ac97_ac97));
 	snprintf(card->longname, sizeof(card->longname),
-		 "%s (%s)", dev->driver->name, card->mixername);
+		 "%s (%s)", dev->dev.driver->name, card->mixername);
 
 	snd_card_set_pm_callback(card, pxa2xx_ac97_do_suspend,
 				 pxa2xx_ac97_do_resume, NULL);
 	ret = snd_card_register(card);
 	if (ret == 0) {
-		dev_set_drvdata(dev, card);
+		platform_set_drvdata(dev, card);
 		return 0;
 	}
 
@@ -368,13 +368,13 @@
 	return ret;
 }
 
-static int pxa2xx_ac97_remove(struct device *dev)
+static int pxa2xx_ac97_remove(struct platform_device *dev)
 {
-	snd_card_t *card = dev_get_drvdata(dev);
+	snd_card_t *card = platform_get_drvdata(dev);
 
 	if (card) {
 		snd_card_free(card);
-		dev_set_drvdata(dev, NULL);
+		platform_set_drvdata(dev, NULL);
 		GCR |= GCR_ACLINK_OFF;
 		free_irq(IRQ_AC97, NULL);
 		pxa_set_cken(CKEN2_AC97, 0);
@@ -383,23 +383,24 @@
 	return 0;
 }
 
-static struct device_driver pxa2xx_ac97_driver = {
-	.name		= "pxa2xx-ac97",
-	.bus		= &platform_bus_type,
+static struct platform_driver pxa2xx_ac97_driver = {
 	.probe		= pxa2xx_ac97_probe,
 	.remove		= pxa2xx_ac97_remove,
 	.suspend	= pxa2xx_ac97_suspend,
 	.resume		= pxa2xx_ac97_resume,
+	.driver		= {
+		.name	= "pxa2xx-ac97",
+	},
 };
 
 static int __init pxa2xx_ac97_init(void)
 {
-	return driver_register(&pxa2xx_ac97_driver);
+	return platform_driver_register(&pxa2xx_ac97_driver);
 }
 
 static void __exit pxa2xx_ac97_exit(void)
 {
-	driver_unregister(&pxa2xx_ac97_driver);
+	platform_driver_unregister(&pxa2xx_ac97_driver);
 }
 
 module_init(pxa2xx_ac97_init);


-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
