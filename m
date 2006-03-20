Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030547AbWCTWJi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030547AbWCTWJi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 17:09:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030550AbWCTWBk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 17:01:40 -0500
Received: from mail.kroah.org ([69.55.234.183]:65209 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1030547AbWCTWBT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 17:01:19 -0500
Cc: David Vrabel <dvrabel@arcom.com>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 05/23] handle errors returned by platform_get_irq*()
In-Reply-To: <11428920383013-git-send-email-gregkh@suse.de>
X-Mailer: git-send-email
Date: Mon, 20 Mar 2006 14:00:38 -0800
Message-Id: <11428920383977-git-send-email-gregkh@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg Kroah-Hartman <gregkh@suse.de>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg Kroah-Hartman <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

platform_get_irq*() now returns on -ENXIO when the resource cannot be
found.  Ensure all users of platform_get_irq*() handle this error
appropriately.

Signed-off-by: David Vrabel <dvrabel@arcom.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---

 arch/arm/common/locomo.c           |    2 ++
 arch/arm/common/sa1111.c           |    2 ++
 drivers/char/s3c2410-rtc.c         |    4 ++--
 drivers/char/watchdog/mpcore_wdt.c |    4 ++++
 drivers/i2c/busses/i2c-iop3xx.c    |    9 +++++++--
 drivers/i2c/busses/i2c-mpc.c       |    5 +++++
 drivers/i2c/busses/i2c-mv64xxx.c   |    4 ++++
 drivers/ide/mips/au1xxx-ide.c      |    5 +++++
 drivers/mmc/pxamci.c               |    2 +-
 drivers/net/arm/am79c961a.c        |    4 +++-
 drivers/net/fs_enet/mac-fcc.c      |    2 ++
 drivers/net/fs_enet/mac-fec.c      |    2 ++
 drivers/net/fs_enet/mac-scc.c      |    2 ++
 drivers/net/gianfar.c              |    4 ++++
 drivers/net/smc91x.c               |    4 ++++
 drivers/pcmcia/omap_cf.c           |    2 +-
 drivers/serial/s3c2410.c           |    2 ++
 drivers/usb/host/ohci-omap.c       |    9 +++++++--
 drivers/video/sa1100fb.c           |    2 +-
 19 files changed, 60 insertions(+), 10 deletions(-)

489447380a2921ec0e9154f773c44ab3167ede4b
diff --git a/arch/arm/common/locomo.c b/arch/arm/common/locomo.c
index d31b1cb..2360940 100644
--- a/arch/arm/common/locomo.c
+++ b/arch/arm/common/locomo.c
@@ -788,6 +788,8 @@ static int locomo_probe(struct platform_
 	if (!mem)
 		return -EINVAL;
 	irq = platform_get_irq(dev, 0);
+	if (irq < 0)
+		return -ENXIO;
 
 	return __locomo_probe(&dev->dev, mem, irq);
 }
diff --git a/arch/arm/common/sa1111.c b/arch/arm/common/sa1111.c
index 1475089..93352f6 100644
--- a/arch/arm/common/sa1111.c
+++ b/arch/arm/common/sa1111.c
@@ -943,6 +943,8 @@ static int sa1111_probe(struct platform_
 	if (!mem)
 		return -EINVAL;
 	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return -ENXIO;
 
 	return __sa1111_probe(&pdev->dev, mem, irq);
 }
diff --git a/drivers/char/s3c2410-rtc.c b/drivers/char/s3c2410-rtc.c
index 2e30865..b0038b1 100644
--- a/drivers/char/s3c2410-rtc.c
+++ b/drivers/char/s3c2410-rtc.c
@@ -448,13 +448,13 @@ static int s3c2410_rtc_probe(struct plat
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
diff --git a/drivers/char/watchdog/mpcore_wdt.c b/drivers/char/watchdog/mpcore_wdt.c
index b4d8434..2c2c517 100644
--- a/drivers/char/watchdog/mpcore_wdt.c
+++ b/drivers/char/watchdog/mpcore_wdt.c
@@ -338,6 +338,10 @@ static int __devinit mpcore_wdt_probe(st
 
 	wdt->dev = &dev->dev;
 	wdt->irq = platform_get_irq(dev, 0);
+	if (wdt->irq < 0) {
+		ret = -ENXIO;
+		goto err_free;
+	}
 	wdt->base = ioremap(res->start, res->end - res->start + 1);
 	if (!wdt->base) {
 		ret = -ENOMEM;
diff --git a/drivers/i2c/busses/i2c-iop3xx.c b/drivers/i2c/busses/i2c-iop3xx.c
index 1414851..d00a02f 100644
--- a/drivers/i2c/busses/i2c-iop3xx.c
+++ b/drivers/i2c/busses/i2c-iop3xx.c
@@ -434,7 +434,7 @@ static int 
 iop3xx_i2c_probe(struct platform_device *pdev)
 {
 	struct resource *res;
-	int ret;
+	int ret, irq;
 	struct i2c_adapter *new_adapter;
 	struct i2c_algo_iop3xx_data *adapter_data;
 
@@ -470,7 +470,12 @@ iop3xx_i2c_probe(struct platform_device 
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
diff --git a/drivers/i2c/busses/i2c-mpc.c b/drivers/i2c/busses/i2c-mpc.c
index 5ccd338..2721e4c 100644
--- a/drivers/i2c/busses/i2c-mpc.c
+++ b/drivers/i2c/busses/i2c-mpc.c
@@ -302,6 +302,10 @@ static int fsl_i2c_probe(struct platform
 	}
 
 	i2c->irq = platform_get_irq(pdev, 0);
+	if (i2c->irq < 0) {
+		result = -ENXIO;
+		goto fail_get_irq;
+	}
 	i2c->flags = pdata->device_flags;
 	init_waitqueue_head(&i2c->queue);
 
@@ -340,6 +344,7 @@ static int fsl_i2c_probe(struct platform
       fail_irq:
 	iounmap(i2c->base);
       fail_map:
+      fail_get_irq:
 	kfree(i2c);
 	return result;
 };
diff --git a/drivers/i2c/busses/i2c-mv64xxx.c b/drivers/i2c/busses/i2c-mv64xxx.c
index 22781d8..ac5cde1 100644
--- a/drivers/i2c/busses/i2c-mv64xxx.c
+++ b/drivers/i2c/busses/i2c-mv64xxx.c
@@ -516,6 +516,10 @@ mv64xxx_i2c_probe(struct platform_device
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
diff --git a/drivers/ide/mips/au1xxx-ide.c b/drivers/ide/mips/au1xxx-ide.c
index 32431dc..71f27e9 100644
--- a/drivers/ide/mips/au1xxx-ide.c
+++ b/drivers/ide/mips/au1xxx-ide.c
@@ -674,6 +674,11 @@ static int au_ide_probe(struct device *d
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
diff --git a/drivers/mmc/pxamci.c b/drivers/mmc/pxamci.c
index 285d7d0..c32fad1 100644
--- a/drivers/mmc/pxamci.c
+++ b/drivers/mmc/pxamci.c
@@ -438,7 +438,7 @@ static int pxamci_probe(struct platform_
 
 	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	irq = platform_get_irq(pdev, 0);
-	if (!r || irq == NO_IRQ)
+	if (!r || irq < 0)
 		return -ENXIO;
 
 	r = request_mem_region(r->start, SZ_4K, DRIVER_NAME);
diff --git a/drivers/net/arm/am79c961a.c b/drivers/net/arm/am79c961a.c
index 53e3afc..09d5c3f 100644
--- a/drivers/net/arm/am79c961a.c
+++ b/drivers/net/arm/am79c961a.c
@@ -696,7 +696,9 @@ static int __init am79c961_probe(struct 
 	dev->base_addr = res->start;
 	dev->irq = platform_get_irq(pdev, 0);
 
-    	ret = -ENODEV;
+	ret = -ENODEV;
+	if (dev->irq < 0)
+		goto nodev;
 	if (!request_region(dev->base_addr, 0x18, dev->name))
 		goto nodev;
 
diff --git a/drivers/net/fs_enet/mac-fcc.c b/drivers/net/fs_enet/mac-fcc.c
index e67b1d0..95e2bb8 100644
--- a/drivers/net/fs_enet/mac-fcc.c
+++ b/drivers/net/fs_enet/mac-fcc.c
@@ -118,6 +118,8 @@ static int do_pd_setup(struct fs_enet_pr
 
 	/* Fill out IRQ field */
 	fep->interrupt = platform_get_irq(pdev, 0);
+	if (fep->interrupt < 0)
+		return -EINVAL;
 
 	/* Attach the memory for the FCC Parameter RAM */
 	r = platform_get_resource_byname(pdev, IORESOURCE_MEM, "fcc_pram");
diff --git a/drivers/net/fs_enet/mac-fec.c b/drivers/net/fs_enet/mac-fec.c
index 2e8f444..3dad69d 100644
--- a/drivers/net/fs_enet/mac-fec.c
+++ b/drivers/net/fs_enet/mac-fec.c
@@ -144,6 +144,8 @@ static int do_pd_setup(struct fs_enet_pr
 	
 	/* Fill out IRQ field */
 	fep->interrupt = platform_get_irq_byname(pdev,"interrupt");
+	if (fep->interrupt < 0)
+		return -EINVAL;
 	
 	r = platform_get_resource_byname(pdev, IORESOURCE_MEM, "regs");
 	fep->fec.fecp =(void*)r->start;
diff --git a/drivers/net/fs_enet/mac-scc.c b/drivers/net/fs_enet/mac-scc.c
index a3897fd..a772b28 100644
--- a/drivers/net/fs_enet/mac-scc.c
+++ b/drivers/net/fs_enet/mac-scc.c
@@ -118,6 +118,8 @@ static int do_pd_setup(struct fs_enet_pr
 
 	/* Fill out IRQ field */
 	fep->interrupt = platform_get_irq_byname(pdev, "interrupt");
+	if (fep->interrupt < 0)
+		return -EINVAL;
 
 	r = platform_get_resource_byname(pdev, IORESOURCE_MEM, "regs");
 	fep->scc.sccp = (void *)r->start;
diff --git a/drivers/net/gianfar.c b/drivers/net/gianfar.c
index 0e8e3fc..771e25d 100644
--- a/drivers/net/gianfar.c
+++ b/drivers/net/gianfar.c
@@ -193,8 +193,12 @@ static int gfar_probe(struct platform_de
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
diff --git a/drivers/net/smc91x.c b/drivers/net/smc91x.c
index 7ec0812..75e9b3b 100644
--- a/drivers/net/smc91x.c
+++ b/drivers/net/smc91x.c
@@ -2221,6 +2221,10 @@ static int smc_drv_probe(struct platform
 
 	ndev->dma = (unsigned char)-1;
 	ndev->irq = platform_get_irq(pdev, 0);
+	if (ndev->irq < 0) {
+		ret = -ENODEV;
+		goto out_free_netdev;
+	}
 
 	ret = smc_request_attrib(pdev);
 	if (ret)
diff --git a/drivers/pcmcia/omap_cf.c b/drivers/pcmcia/omap_cf.c
index 47b5ade..2c23d75 100644
--- a/drivers/pcmcia/omap_cf.c
+++ b/drivers/pcmcia/omap_cf.c
@@ -218,7 +218,7 @@ static int __init omap_cf_probe(struct d
 
 	/* either CFLASH.IREQ (INT_1610_CF) or some GPIO */
 	irq = platform_get_irq(pdev, 0);
-	if (!irq)
+	if (irq < 0)
 		return -EINVAL;
 
 	cf = kcalloc(1, sizeof *cf, GFP_KERNEL);
diff --git a/drivers/serial/s3c2410.c b/drivers/serial/s3c2410.c
index 7410e09..00d7c0a 100644
--- a/drivers/serial/s3c2410.c
+++ b/drivers/serial/s3c2410.c
@@ -1066,6 +1066,8 @@ static int s3c24xx_serial_init_port(stru
 	port->mapbase	= res->start;
 	port->membase	= S3C24XX_VA_UART + (res->start - S3C24XX_PA_UART);
 	port->irq	= platform_get_irq(platdev, 0);
+	if (port->irq < 0)
+		port->irq = 0;
 
 	ourport->clk	= clk_get(&platdev->dev, "uart");
 
diff --git a/drivers/usb/host/ohci-omap.c b/drivers/usb/host/ohci-omap.c
index 3785b3f..ca19abe 100644
--- a/drivers/usb/host/ohci-omap.c
+++ b/drivers/usb/host/ohci-omap.c
@@ -286,7 +286,7 @@ void usb_hcd_omap_remove (struct usb_hcd
 int usb_hcd_omap_probe (const struct hc_driver *driver,
 			  struct platform_device *pdev)
 {
-	int retval;
+	int retval, irq;
 	struct usb_hcd *hcd = 0;
 	struct ohci_hcd *ohci;
 
@@ -329,7 +329,12 @@ int usb_hcd_omap_probe (const struct hc_
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
 
diff --git a/drivers/video/sa1100fb.c b/drivers/video/sa1100fb.c
index 8a893ce..d9831fd 100644
--- a/drivers/video/sa1100fb.c
+++ b/drivers/video/sa1100fb.c
@@ -1457,7 +1457,7 @@ static int __init sa1100fb_probe(struct 
 	int ret, irq;
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq <= 0)
+	if (irq < 0)
 		return -EINVAL;
 
 	if (!request_mem_region(0xb0100000, 0x10000, "LCD"))
-- 
1.2.4


