Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964917AbWBGDET@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964917AbWBGDET (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 22:04:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964918AbWBGDET
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 22:04:19 -0500
Received: from streetfiresound.liquidweb.com ([64.91.233.29]:15013 "EHLO
	host.streetfiresound.liquidweb.com") by vger.kernel.org with ESMTP
	id S964917AbWBGDES (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 22:04:18 -0500
Date: Mon, 06 Feb 2006 19:04:11 -0800
From: stephen@streetfiresound.com
To: greg@kroah.com
Cc: linux-kernel@vger.kernel.org, dvrabel@arcom.com, david-b@pacbell.net,
       stephen@streetfiresound.com
Subject: [PATCH] spi: Fix modular master driver remove and device
 suspend/remove
Message-ID: <43e80e2b.EZgObIkBxyg9Mb6O%stephen@streetfiresound.com>
User-Agent: nail 11.25 7/29/05
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - host.streetfiresound.liquidweb.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - streetfiresound.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephen Street <stephen@streetfiresound.com>

Fix two problems in the spi subsystem:

1) spi subsystem core dumps when modular spi master is unloaded.
2) spi subsystem core dumps when spi slave device is suspended/resumed and
   module slave driver is not loaded.

Signed-off-by: Stephen Street <stephen@streetfiresound.com>
Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
---

 spi.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

--- linux-2.6.16-rc2/drivers/spi/spi.c	2006-02-06 18:39:31.746537258 -0800
+++ linux-spi/drivers/spi/spi.c	2006-02-06 18:39:45.353334421 -0800
@@ -90,7 +90,7 @@ static int spi_suspend(struct device *de
 	int			value;
 	struct spi_driver	*drv = to_spi_driver(dev->driver);
 
-	if (!drv->suspend)
+	if (!drv || !drv->suspend)
 		return 0;
 
 	/* suspend will stop irqs and dma; no more i/o */
@@ -105,7 +105,7 @@ static int spi_resume(struct device *dev
 	int			value;
 	struct spi_driver	*drv = to_spi_driver(dev->driver);
 
-	if (!drv->resume)
+	if (!drv || !drv->resume)
 		return 0;
 
 	/* resume may restart the i/o queue */
@@ -449,7 +449,6 @@ void spi_unregister_master(struct spi_ma
 {
 	(void) device_for_each_child(master->cdev.dev, NULL, __unregister);
 	class_device_unregister(&master->cdev);
-	master->cdev.dev = NULL;
 }
 EXPORT_SYMBOL_GPL(spi_unregister_master);
 
