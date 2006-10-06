Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751303AbWJFEzV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751303AbWJFEzV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 00:55:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750996AbWJFEzV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 00:55:21 -0400
Received: from mail01.verismonetworks.com ([164.164.99.228]:50613 "EHLO
	mail01.verismonetworks.com") by vger.kernel.org with ESMTP
	id S1751800AbWJFEzS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 00:55:18 -0400
Subject: [PATCH 5/5] ioremap balanced with iounmap for
	drivers/char/watchdog/s3c2410_wdt.c
From: Amol Lad <amol@verismonetworks.com>
To: linux kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Date: Fri, 06 Oct 2006 10:27:07 +0530
Message-Id: <1160110627.19143.88.camel@amol.verismonetworks.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Amol Lad <amol@verismonetworks.com>
---
 s3c2410_wdt.c |    5 +++++
 1 files changed, 5 insertions(+)
---
diff -uprN -X linux-2.6.19-rc1-orig/Documentation/dontdiff linux-2.6.19-rc1-orig/drivers/char/watchdog/s3c2410_wdt.c linux-2.6.19-rc1/drivers/char/watchdog/s3c2410_wdt.c
--- linux-2.6.19-rc1-orig/drivers/char/watchdog/s3c2410_wdt.c	2006-10-05 14:00:43.000000000 +0530
+++ linux-2.6.19-rc1/drivers/char/watchdog/s3c2410_wdt.c	2006-10-05 14:50:00.000000000 +0530
@@ -381,18 +381,21 @@ static int s3c2410wdt_probe(struct platf
 	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
 	if (res == NULL) {
 		printk(KERN_INFO PFX "failed to get irq resource\n");
+		iounmap(wdt_base);
 		return -ENOENT;
 	}
 
 	ret = request_irq(res->start, s3c2410wdt_irq, 0, pdev->name, pdev);
 	if (ret != 0) {
 		printk(KERN_INFO PFX "failed to install irq (%d)\n", ret);
+		iounmap(wdt_base);
 		return ret;
 	}
 
 	wdt_clock = clk_get(&pdev->dev, "watchdog");
 	if (wdt_clock == NULL) {
 		printk(KERN_INFO PFX "failed to find watchdog clock source\n");
+		iounmap(wdt_base);
 		return -ENOENT;
 	}
 
@@ -416,6 +419,7 @@ static int s3c2410wdt_probe(struct platf
 	if (ret) {
 		printk (KERN_ERR PFX "cannot register miscdev on minor=%d (%d)\n",
 			WATCHDOG_MINOR, ret);
+		iounmap(wdt_base);
 		return ret;
 	}
 
@@ -452,6 +456,7 @@ static int s3c2410wdt_remove(struct plat
 		wdt_clock = NULL;
 	}
 
+	iounmap(wdt_base);
 	misc_deregister(&s3c2410wdt_miscdev);
 	return 0;
 }


