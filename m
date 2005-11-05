Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932166AbVKESRK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932166AbVKESRK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 13:17:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932160AbVKESRK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 13:17:10 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:30737 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932162AbVKESRH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 13:17:07 -0500
Date: Sat, 5 Nov 2005 18:17:02 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [DRIVER MODEL] Convert MMC drivers
Message-ID: <20051105181701.GK14419@flint.arm.linux.org.uk>
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

diff -u b/drivers/mmc/wbsd.c b/drivers/mmc/wbsd.c
--- b/drivers/mmc/wbsd.c
+++ b/drivers/mmc/wbsd.c
@@ -1932,14 +1932,14 @@
  * Non-PnP
  */
 
-static int __devinit wbsd_probe(struct device* dev)
+static int __devinit wbsd_probe(struct platform_device* dev)
 {
-	return wbsd_init(dev, io, irq, dma, 0);
+	return wbsd_init(&dev->dev, io, irq, dma, 0);
 }
 
-static int __devexit wbsd_remove(struct device* dev)
+static int __devexit wbsd_remove(struct platform_device* dev)
 {
-	wbsd_shutdown(dev, 0);
+	wbsd_shutdown(&dev->dev, 0);
 
 	return 0;
 }
@@ -1983,9 +1983,9 @@
 
 #ifdef CONFIG_PM
 
-static int wbsd_suspend(struct device *dev, pm_message_t state)
+static int wbsd_suspend(struct platform_device *dev, pm_message_t state)
 {
-	struct mmc_host *mmc = dev_get_drvdata(dev);
+	struct mmc_host *mmc = platform_get_drvdata(dev);
 	struct wbsd_host *host;
 	int ret;
 
@@ -2005,9 +2005,9 @@
 	return 0;
 }
 
-static int wbsd_resume(struct device *dev)
+static int wbsd_resume(struct platform_device *dev)
 {
-	struct mmc_host *mmc = dev_get_drvdata(dev);
+	struct mmc_host *mmc = platform_get_drvdata(dev);
 	struct wbsd_host *host;
 
 	if (!mmc)
@@ -2038,14 +2038,15 @@ static int wbsd_resume(struct device *de
 
 static struct platform_device *wbsd_device;
 
-static struct device_driver wbsd_driver = {
-	.name		= DRIVER_NAME,
-	.bus		= &platform_bus_type,
+static struct platform_driver wbsd_driver = {
 	.probe		= wbsd_probe,
 	.remove		= wbsd_remove,
 
 	.suspend	= wbsd_suspend,
 	.resume		= wbsd_resume,
+	.driver		= {
+		.name	= DRIVER_NAME,
+	},
 };
 
 #ifdef CONFIG_PNP
@@ -2085,7 +2086,7 @@ static int __init wbsd_drv_init(void)
 
 	if (nopnp)
 	{
-		result = driver_register(&wbsd_driver);
+		result = platform_driver_register(&wbsd_driver);
 		if (result < 0)
 			return result;
 
@@ -2111,7 +2112,7 @@ static void __exit wbsd_drv_exit(void)
 	{
 		platform_device_unregister(wbsd_device);
 
-		driver_unregister(&wbsd_driver);
+		platform_driver_unregister(&wbsd_driver);
 	}
 
 	DBG("unloaded\n");


-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
