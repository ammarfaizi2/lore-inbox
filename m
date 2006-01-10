Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751064AbWAJLtP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751064AbWAJLtP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 06:49:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751074AbWAJLtP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 06:49:15 -0500
Received: from rtsoft3.corbina.net ([85.21.88.6]:52781 "EHLO
	buildserver.ru.mvista.com") by vger.kernel.org with ESMTP
	id S1751061AbWAJLtP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 06:49:15 -0500
Subject: [PATCH] spi: add bus methods instead of driver's ones
From: dmitry pervushin <dpervushin@ru.mvista.com>
Reply-To: dpervushin@ru.mvista.com
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: spi-devel-general@lists.sourceforge.net
Content-Type: text/plain
Organization: montavista
Date: Tue, 10 Jan 2006 14:47:07 +0300
Message-Id: <1136893627.4780.9.camel@diimka-laptop>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below replaces probe/remove/shutdown functions in device_driver structure by corresponding methods of spi_bus_type.

Signed-off-by: dmitry pervushin <dpervushin@ru.mvista.com>
Index: linux-2.6.15.y/drivers/spi/spi.c
===================================================================
--- linux-2.6.15.y.orig/drivers/spi/spi.c
+++ linux-2.6.15.y/drivers/spi/spi.c
@@ -125,42 +125,40 @@ struct bus_type spi_bus_type = {
 	.dev_attrs	= spi_dev_attrs,
 	.match		= spi_match_device,
 	.uevent		= spi_uevent,
+	.probe		= spi_bus_probe,
+	.remove		= spi_bus_remove,
+	.shutdown	= spi_bus_shutdown,
 	.suspend	= spi_suspend,
 	.resume		= spi_resume,
 };
 EXPORT_SYMBOL_GPL(spi_bus_type);
 
 
-static int spi_drv_probe(struct device *dev)
+static int spi_bus_probe(struct device *dev)
 {
 	const struct spi_driver		*sdrv = to_spi_driver(dev->driver);
 
-	return sdrv->probe(to_spi_device(dev));
+	return sdrv->probe ? sdrv->probe(to_spi_device(dev)) : -ENODEV;
 }
 
-static int spi_drv_remove(struct device *dev)
+static int spi_bus_remove(struct device *dev)
 {
 	const struct spi_driver		*sdrv = to_spi_driver(dev->driver);
 
-	return sdrv->remove(to_spi_device(dev));
+	return sdrv->remove ? sdrv->remove(to_spi_device(dev)) : -EFAULT;
 }
 
-static void spi_drv_shutdown(struct device *dev)
+static void spi_bus_shutdown(struct device *dev)
 {
 	const struct spi_driver		*sdrv = to_spi_driver(dev->driver);
 
-	sdrv->shutdown(to_spi_device(dev));
+	if (sdrv->shutdown)
+		sdrv->shutdown(to_spi_device(dev));
 }
 
 int spi_register_driver(struct spi_driver *sdrv)
 {
 	sdrv->driver.bus = &spi_bus_type;
-	if (sdrv->probe)
-		sdrv->driver.probe = spi_drv_probe;
-	if (sdrv->remove)
-		sdrv->driver.remove = spi_drv_remove;
-	if (sdrv->shutdown)
-		sdrv->driver.shutdown = spi_drv_shutdown;
 	return driver_register(&sdrv->driver);
 }
 EXPORT_SYMBOL_GPL(spi_register_driver);


