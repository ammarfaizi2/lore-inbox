Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751401AbWASR4b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751401AbWASR4b (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 12:56:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751403AbWASR4b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 12:56:31 -0500
Received: from webapps.arcom.com ([194.200.159.168]:43535 "EHLO
	webapps.arcom.com") by vger.kernel.org with ESMTP id S1751401AbWASR4a
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 12:56:30 -0500
Message-ID: <43CFD2CD.8090803@arcom.com>
Date: Thu, 19 Jan 2006 17:56:29 +0000
From: David Vrabel <dvrabel@arcom.com>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <gregkh@suse.de>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [patch 2/2] handle errors returned by platform_get_irq*()
References: <43BD534E.8050701@arcom.com> <20060105173717.GA11279@suse.de> <43BD5F5E.1070108@arcom.com> <20060105180815.GB13317@suse.de> <43CFD12F.2070900@cantab.net>
In-Reply-To: <43CFD12F.2070900@cantab.net>
Content-Type: multipart/mixed;
 boundary="------------050901090801050902040104"
X-OriginalArrivalTime: 19 Jan 2006 18:00:41.0093 (UTC) FILETIME=[42A65B50:01C61D22]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050901090801050902040104
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

platform_get_irq*() now returns on -ENXIO when the resource cannot be
found.  Ensure all users of platform_get_irq*() handle this error
appropriately.

Signed-off-by: David Vrabel <dvrabel@arcom.com>
-- 
David Vrabel, Design Engineer

Arcom, Clifton Road           Tel: +44 (0)1223 411200 ext. 3233
Cambridge CB1 7EA, UK         Web: http://www.arcom.com/

--------------050901090801050902040104
Content-Type: text/plain;
 name="platform_get_irq-fix-users-on-error"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="platform_get_irq-fix-users-on-error"

Index: linux-2.6-working/arch/arm/common/locomo.c
===================================================================
--- linux-2.6-working.orig/arch/arm/common/locomo.c	2006-01-18 11:05:44.000000000 +0000
+++ linux-2.6-working/arch/arm/common/locomo.c	2006-01-19 15:07:05.000000000 +0000
@@ -767,6 +767,8 @@
 	if (!mem)
 		return -EINVAL;
 	irq = platform_get_irq(dev, 0);
+	if (irq < 0)
+		return -ENXIO;
 
 	return __locomo_probe(&dev->dev, mem, irq);
 }
Index: linux-2.6-working/arch/arm/common/sa1111.c
===================================================================
--- linux-2.6-working.orig/arch/arm/common/sa1111.c	2006-01-18 11:05:44.000000000 +0000
+++ linux-2.6-working/arch/arm/common/sa1111.c	2006-01-19 15:07:32.000000000 +0000
@@ -943,6 +943,8 @@
 	if (!mem)
 		return -EINVAL;
 	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return -ENXIO;
 
 	return __sa1111_probe(&pdev->dev, mem, irq);
 }
Index: linux-2.6-working/drivers/char/s3c2410-rtc.c
===================================================================
--- linux-2.6-working.orig/drivers/char/s3c2410-rtc.c	2006-01-18 11:06:11.000000000 +0000
+++ linux-2.6-working/drivers/char/s3c2410-rtc.c	2006-01-19 14:54:26.000000000 +0000
@@ -448,13 +448,13 @@
 	/* find the IRQs */
 
 	s3c2410_rtc_tickno = platform_get_irq(pdev, 1);
-	if (s3c2410_rtc_tickno <= 0) {
+	if (s3c2410_rtc_tickno < 0) {
 		dev_err(&pdev->dev, "no irq for rtc tick\n");
 		return -ENOENT;
 	}
 
 	s3c2410_rtc_alarmno = platform_get_irq(pdev, 0);
-	if (s3c2410_rtc_alarmno <= 0) {
+	if (s3c2410_rtc_alarmno < 0) {
 		dev_err(&pdev->dev, "no irq for alarm\n");
 		return -ENOENT;
 	}
Index: linux-2.6-working/drivers/char/watchdog/mpcore_wdt.c
===================================================================
--- linux-2.6-working.orig/drivers/char/watchdog/mpcore_wdt.c	2006-01-03 08:46:52.000000000 +0000
+++ linux-2.6-working/drivers/char/watchdog/mpcore_wdt.c	2006-01-19 14:53:58.000000000 +0000
@@ -338,6 +338,10 @@
 
 	wdt->dev = &dev->dev;
 	wdt->irq = platform_get_irq(dev, 0);
+	if (wdt->irq < 0) {
+		ret = -ENXIO;
+		goto err_free;
+	}
 	wdt->base = ioremap(res->start, res->end - res->start + 1);
 	if (!wdt->base) {
 		ret = -ENOMEM;
Index: linux-2.6-working/drivers/i2c/busses/i2c-iop3xx.c
===================================================================
--- linux-2.6-working.orig/drivers/i2c/busses/i2c-iop3xx.c	2006-01-03 08:46:53.000000000 +0000
+++ linux-2.6-working/drivers/i2c/busses/i2c-iop3xx.c	2006-01-19 14:51:54.000000000 +0000
@@ -434,7 +434,7 @@
 iop3xx_i2c_probe(struct platform_device *pdev)
 {
 	struct resource *res;
-	int ret;
+	int ret, irq;
 	struct i2c_adapter *new_adapter;
 	struct i2c_algo_iop3xx_data *adapter_data;
 
@@ -470,7 +470,12 @@
 		goto release_region;
 	}
 
-	ret = request_irq(platform_get_irq(pdev, 0), iop3xx_i2c_irq_handler, 0,
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0) {
+		ret = -ENXIO;
+		goto unmap;
+	}
+	ret = request_irq(irq, iop3xx_i2c_irq_handler, 0,
 				pdev->name, adapter_data);
 
 	if (ret) {
Index: linux-2.6-working/drivers/i2c/busses/i2c-mpc.c
===================================================================
--- linux-2.6-working.orig/drivers/i2c/busses/i2c-mpc.c	2006-01-03 08:46:53.000000000 +0000
+++ linux-2.6-working/drivers/i2c/busses/i2c-mpc.c	2006-01-19 14:50:17.000000000 +0000
@@ -302,6 +302,10 @@
 	}
 
 	i2c->irq = platform_get_irq(pdev, 0);
+	if (i2c->irq < 0) {
+		result = -ENXIO;
+		goto fail_get_irq;
+	}
 	i2c->flags = pdata->device_flags;
 	init_waitqueue_head(&i2c->queue);
 
@@ -340,6 +344,7 @@
       fail_irq:
 	iounmap(i2c->base);
       fail_map:
+      fail_get_irq:
 	kfree(i2c);
 	return result;
 };
Index: linux-2.6-working/drivers/i2c/busses/i2c-mv64xxx.c
===================================================================
--- linux-2.6-working.orig/drivers/i2c/busses/i2c-mv64xxx.c	2006-01-18 11:06:12.000000000 +0000
+++ linux-2.6-working/drivers/i2c/busses/i2c-mv64xxx.c	2006-01-19 14:53:06.000000000 +0000
@@ -516,6 +516,10 @@
 	drv_data->freq_m = pdata->freq_m;
 	drv_data->freq_n = pdata->freq_n;
 	drv_data->irq = platform_get_irq(pd, 0);
+	if (drv_data->irq < 0) {
+		rc = -ENXIO;
+		goto exit_unmap_regs;
+	}
 	drv_data->adapter.id = I2C_HW_MV64XXX;
 	drv_data->adapter.algo = &mv64xxx_i2c_algo;
 	drv_data->adapter.owner = THIS_MODULE;
Index: linux-2.6-working/drivers/ide/mips/au1xxx-ide.c
===================================================================
--- linux-2.6-working.orig/drivers/ide/mips/au1xxx-ide.c	2006-01-03 08:46:53.000000000 +0000
+++ linux-2.6-working/drivers/ide/mips/au1xxx-ide.c	2006-01-19 15:04:45.000000000 +0000
@@ -674,6 +674,11 @@
 		ret = -ENODEV;
 		goto out;
 	}
+	if (ahwif->irq < 0) {
+		pr_debug("%s %d: no IRQ\n", DRV_NAME, pdev->id);
+		ret = -ENODEV;
+		goto out;
+	}
 
 	if (!request_mem_region (res->start, res->end-res->start, pdev->name)) {
 		pr_debug("%s: request_mem_region failed\n", DRV_NAME);
Index: linux-2.6-working/drivers/mmc/pxamci.c
===================================================================
--- linux-2.6-working.orig/drivers/mmc/pxamci.c	2006-01-03 08:46:53.000000000 +0000
+++ linux-2.6-working/drivers/mmc/pxamci.c	2006-01-19 15:05:29.000000000 +0000
@@ -437,7 +437,7 @@
 
 	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	irq = platform_get_irq(pdev, 0);
-	if (!r || irq == NO_IRQ)
+	if (!r || irq < 0)
 		return -ENXIO;
 
 	r = request_mem_region(r->start, SZ_4K, DRIVER_NAME);
Index: linux-2.6-working/drivers/net/arm/am79c961a.c
===================================================================
--- linux-2.6-working.orig/drivers/net/arm/am79c961a.c	2006-01-18 11:06:20.000000000 +0000
+++ linux-2.6-working/drivers/net/arm/am79c961a.c	2006-01-19 14:38:59.000000000 +0000
@@ -696,7 +696,9 @@
 	dev->base_addr = res->start;
 	dev->irq = platform_get_irq(pdev, 0);
 
-    	ret = -ENODEV;
+	ret = -ENODEV;
+	if (dev->irq < 0)
+		goto nodev;
 	if (!request_region(dev->base_addr, 0x18, dev->name))
 		goto nodev;
 
Index: linux-2.6-working/drivers/net/fs_enet/mac-fcc.c
===================================================================
--- linux-2.6-working.orig/drivers/net/fs_enet/mac-fcc.c	2006-01-03 08:46:53.000000000 +0000
+++ linux-2.6-working/drivers/net/fs_enet/mac-fcc.c	2006-01-19 14:45:36.000000000 +0000
@@ -118,6 +118,8 @@
 
 	/* Fill out IRQ field */
 	fep->interrupt = platform_get_irq(pdev, 0);
+	if (fep->interrupt < 0)
+		return -EINVAL;
 
 	/* Attach the memory for the FCC Parameter RAM */
 	r = platform_get_resource_byname(pdev, IORESOURCE_MEM, "fcc_pram");
Index: linux-2.6-working/drivers/net/fs_enet/mac-fec.c
===================================================================
--- linux-2.6-working.orig/drivers/net/fs_enet/mac-fec.c	2006-01-03 08:46:53.000000000 +0000
+++ linux-2.6-working/drivers/net/fs_enet/mac-fec.c	2006-01-19 14:46:30.000000000 +0000
@@ -144,6 +144,8 @@
 	
 	/* Fill out IRQ field */
 	fep->interrupt = platform_get_irq_byname(pdev,"interrupt");
+	if (fep->interrupt < 0)
+		return -EINVAL;
 	
 	r = platform_get_resource_byname(pdev, IORESOURCE_MEM, "regs");
 	fep->fec.fecp =(void*)r->start;
Index: linux-2.6-working/drivers/net/fs_enet/mac-scc.c
===================================================================
--- linux-2.6-working.orig/drivers/net/fs_enet/mac-scc.c	2006-01-03 08:46:53.000000000 +0000
+++ linux-2.6-working/drivers/net/fs_enet/mac-scc.c	2006-01-19 14:47:21.000000000 +0000
@@ -118,6 +118,8 @@
 
 	/* Fill out IRQ field */
 	fep->interrupt = platform_get_irq_byname(pdev, "interrupt");
+	if (fep->interrupt < 0)
+		return -EINVAL;
 
 	r = platform_get_resource_byname(pdev, IORESOURCE_MEM, "regs");
 	fep->scc.sccp = (void *)r->start;
Index: linux-2.6-working/drivers/net/gianfar.c
===================================================================
--- linux-2.6-working.orig/drivers/net/gianfar.c	2006-01-18 11:06:20.000000000 +0000
+++ linux-2.6-working/drivers/net/gianfar.c	2006-01-19 14:42:07.000000000 +0000
@@ -193,8 +193,12 @@
 		priv->interruptTransmit = platform_get_irq_byname(pdev, "tx");
 		priv->interruptReceive = platform_get_irq_byname(pdev, "rx");
 		priv->interruptError = platform_get_irq_byname(pdev, "error");
+		if (priv->interruptTransmit < 0 || priv->interruptReceive < 0 || priv->interruptError < 0)
+			goto regs_fail;
 	} else {
 		priv->interruptTransmit = platform_get_irq(pdev, 0);
+		if (priv->interruptTransmit < 0)
+			goto regs_fail;
 	}
 
 	/* get a pointer to the register memory */
Index: linux-2.6-working/drivers/net/smc91x.c
===================================================================
--- linux-2.6-working.orig/drivers/net/smc91x.c	2006-01-18 17:44:53.000000000 +0000
+++ linux-2.6-working/drivers/net/smc91x.c	2006-01-19 14:44:15.000000000 +0000
@@ -2221,6 +2221,10 @@
 
 	ndev->dma = (unsigned char)-1;
 	ndev->irq = platform_get_irq(pdev, 0);
+	if (ndev->irq < 0) {
+		ret = -ENODEV;
+		goto out_free_netdev;
+	}
 
 	ret = smc_request_attrib(pdev);
 	if (ret)
Index: linux-2.6-working/drivers/pcmcia/omap_cf.c
===================================================================
--- linux-2.6-working.orig/drivers/pcmcia/omap_cf.c	2006-01-03 08:46:53.000000000 +0000
+++ linux-2.6-working/drivers/pcmcia/omap_cf.c	2006-01-19 15:05:04.000000000 +0000
@@ -218,7 +218,7 @@
 
 	/* either CFLASH.IREQ (INT_1610_CF) or some GPIO */
 	irq = platform_get_irq(pdev, 0);
-	if (!irq)
+	if (irq < 0)
 		return -EINVAL;
 
 	cf = kcalloc(1, sizeof *cf, GFP_KERNEL);
Index: linux-2.6-working/drivers/serial/s3c2410.c
===================================================================
--- linux-2.6-working.orig/drivers/serial/s3c2410.c	2006-01-18 11:06:29.000000000 +0000
+++ linux-2.6-working/drivers/serial/s3c2410.c	2006-01-19 14:56:15.000000000 +0000
@@ -1062,6 +1062,8 @@
 	port->mapbase	= res->start;
 	port->membase	= S3C24XX_VA_UART + (res->start - S3C2410_PA_UART);
 	port->irq	= platform_get_irq(platdev, 0);
+	if (port->irq < 0)
+		port->irq = 0;
 
 	ourport->clk	= clk_get(&platdev->dev, "uart");
 
Index: linux-2.6-working/drivers/usb/host/ohci-omap.c
===================================================================
--- linux-2.6-working.orig/drivers/usb/host/ohci-omap.c	2006-01-18 11:06:31.000000000 +0000
+++ linux-2.6-working/drivers/usb/host/ohci-omap.c	2006-01-19 15:03:03.000000000 +0000
@@ -286,7 +286,7 @@
 int usb_hcd_omap_probe (const struct hc_driver *driver,
 			  struct platform_device *pdev)
 {
-	int retval;
+	int retval, irq;
 	struct usb_hcd *hcd = 0;
 	struct ohci_hcd *ohci;
 
@@ -329,7 +329,12 @@
 	if (retval < 0)
 		goto err2;
 
-	retval = usb_add_hcd(hcd, platform_get_irq(pdev, 0), SA_INTERRUPT);
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0) {
+		retval = -ENXIO;
+		goto err2;
+	}
+	retval = usb_add_hcd(hcd, irq, SA_INTERRUPT);
 	if (retval == 0)
 		return retval;
 
Index: linux-2.6-working/drivers/video/sa1100fb.c
===================================================================
--- linux-2.6-working.orig/drivers/video/sa1100fb.c	2006-01-18 11:06:35.000000000 +0000
+++ linux-2.6-working/drivers/video/sa1100fb.c	2006-01-19 13:37:12.000000000 +0000
@@ -1457,7 +1457,7 @@
 	int ret, irq;
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq <= 0)
+	if (irq < 0)
 		return -EINVAL;
 
 	if (!request_mem_region(0xb0100000, 0x10000, "LCD"))

--------------050901090801050902040104--
