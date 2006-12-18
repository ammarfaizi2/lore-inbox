Return-Path: <linux-kernel-owner+w=401wt.eu-S1753753AbWLRKbp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753753AbWLRKbp (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 05:31:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753748AbWLRKbp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 05:31:45 -0500
Received: from 87-194-8-8.bethere.co.uk ([87.194.8.8]:55503 "EHLO
	aeryn.fluff.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753759AbWLRKbo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 05:31:44 -0500
Date: Mon, 18 Dec 2006 10:31:32 +0000
From: Ben Dooks <ben-linux@fluff.org>
To: wim@iguana.be, linux-kernel@vger.kernel.org
Subject: [PATCH] watchdog: cleanup s3c2410_wdt probe and release
Message-ID: <20061218103132.GA10691@home.fluff.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="IJpNTDwzlM2Ie8A6"
Content-Disposition: inline
X-Disclaimer: I speak for me, myself, and the other one of me.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--IJpNTDwzlM2Ie8A6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Cleanup the s3c2410_wdt driver's exit point by
using labels instead of multiple returns. Also
remove the checks for the resources having been
allocate in the exit, as we will now either have
fully allocated or not allocated the resources
at-all.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>

diff -urpN -X ../dontdiff linux-2.6.20-rc1/drivers/char/watchdog/s3c2410_wdt.c linux-2.6.20-rc1-fix2/drivers/char/watchdog/s3c2410_wdt.c
--- linux-2.6.20-rc1/drivers/char/watchdog/s3c2410_wdt.c	2006-11-29 21:57:37.000000000 +0000
+++ linux-2.6.20-rc1-fix2/drivers/char/watchdog/s3c2410_wdt.c	2006-12-18 10:26:55.000000000 +0000
@@ -366,13 +366,15 @@ static int s3c2410wdt_probe(struct platf
 	wdt_mem = request_mem_region(res->start, size, pdev->name);
 	if (wdt_mem == NULL) {
 		printk(KERN_INFO PFX "failed to get memory region\n");
-		return -ENOENT;
+		ret = -ENOENT;
+		goto err_req;
 	}
 
 	wdt_base = ioremap(res->start, size);
 	if (wdt_base == 0) {
 		printk(KERN_INFO PFX "failed to ioremap() region\n");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto err_req;
 	}
 
 	DBG("probe: mapped wdt_base=%p\n", wdt_base);
@@ -380,22 +382,21 @@ static int s3c2410wdt_probe(struct platf
 	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
 	if (res == NULL) {
 		printk(KERN_INFO PFX "failed to get irq resource\n");
-		iounmap(wdt_base);
-		return -ENOENT;
+		ret = -ENOENT;
+		goto err_map;
 	}
 
 	ret = request_irq(res->start, s3c2410wdt_irq, 0, pdev->name, pdev);
 	if (ret != 0) {
 		printk(KERN_INFO PFX "failed to install irq (%d)\n", ret);
-		iounmap(wdt_base);
-		return ret;
+		goto err_map;
 	}
 
 	wdt_clock = clk_get(&pdev->dev, "watchdog");
 	if (wdt_clock == NULL) {
 		printk(KERN_INFO PFX "failed to find watchdog clock source\n");
-		iounmap(wdt_base);
-		return -ENOENT;
+		ret =  -ENOENT;
+		goto err_irq;
 	}
 
 	clk_enable(wdt_clock);
@@ -418,8 +419,7 @@ static int s3c2410wdt_probe(struct platf
 	if (ret) {
 		printk (KERN_ERR PFX "cannot register miscdev on minor=%d (%d)\n",
 			WATCHDOG_MINOR, ret);
-		iounmap(wdt_base);
-		return ret;
+		goto err_clk;
 	}
 
 	if (tmr_atboot && started == 0) {
@@ -434,26 +434,36 @@ static int s3c2410wdt_probe(struct platf
 	}
 
 	return 0;
+
+ err_clk:
+	clk_disable(wdt_clock);
+	clk_put(wdt_clock);
+	
+ err_irq:
+	free_irq(wdt_irq->start, pdev);
+
+ err_map:
+	iounmap(wdt_base);
+
+ err_req:
+	release_resource(wdt_mem);
+	kfree(wdt_mem);
+
+	return ret;
 }
 
 static int s3c2410wdt_remove(struct platform_device *dev)
 {
-	if (wdt_mem != NULL) {
-		release_resource(wdt_mem);
-		kfree(wdt_mem);
-		wdt_mem = NULL;
-	}
-
-	if (wdt_irq != NULL) {
-		free_irq(wdt_irq->start, dev);
-		wdt_irq = NULL;
-	}
-
-	if (wdt_clock != NULL) {
-		clk_disable(wdt_clock);
-		clk_put(wdt_clock);
-		wdt_clock = NULL;
-	}
+	release_resource(wdt_mem);
+	kfree(wdt_mem);
+	wdt_mem = NULL;
+	
+	free_irq(wdt_irq->start, dev);
+	wdt_irq = NULL;
+
+	clk_disable(wdt_clock);
+	clk_put(wdt_clock);
+	wdt_clock = NULL;
 
 	iounmap(wdt_base);
 	misc_deregister(&s3c2410wdt_miscdev);

--IJpNTDwzlM2Ie8A6
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="2620-rc1-s3c24xx-watchdog-balance.patch"

diff -urpN -X ../dontdiff linux-2.6.20-rc1/drivers/char/watchdog/s3c2410_wdt.c linux-2.6.20-rc1-fix2/drivers/char/watchdog/s3c2410_wdt.c
--- linux-2.6.20-rc1/drivers/char/watchdog/s3c2410_wdt.c	2006-11-29 21:57:37.000000000 +0000
+++ linux-2.6.20-rc1-fix2/drivers/char/watchdog/s3c2410_wdt.c	2006-12-18 10:26:55.000000000 +0000
@@ -366,13 +366,15 @@ static int s3c2410wdt_probe(struct platf
 	wdt_mem = request_mem_region(res->start, size, pdev->name);
 	if (wdt_mem == NULL) {
 		printk(KERN_INFO PFX "failed to get memory region\n");
-		return -ENOENT;
+		ret = -ENOENT;
+		goto err_req;
 	}
 
 	wdt_base = ioremap(res->start, size);
 	if (wdt_base == 0) {
 		printk(KERN_INFO PFX "failed to ioremap() region\n");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto err_req;
 	}
 
 	DBG("probe: mapped wdt_base=%p\n", wdt_base);
@@ -380,22 +382,21 @@ static int s3c2410wdt_probe(struct platf
 	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
 	if (res == NULL) {
 		printk(KERN_INFO PFX "failed to get irq resource\n");
-		iounmap(wdt_base);
-		return -ENOENT;
+		ret = -ENOENT;
+		goto err_map;
 	}
 
 	ret = request_irq(res->start, s3c2410wdt_irq, 0, pdev->name, pdev);
 	if (ret != 0) {
 		printk(KERN_INFO PFX "failed to install irq (%d)\n", ret);
-		iounmap(wdt_base);
-		return ret;
+		goto err_map;
 	}
 
 	wdt_clock = clk_get(&pdev->dev, "watchdog");
 	if (wdt_clock == NULL) {
 		printk(KERN_INFO PFX "failed to find watchdog clock source\n");
-		iounmap(wdt_base);
-		return -ENOENT;
+		ret =  -ENOENT;
+		goto err_irq;
 	}
 
 	clk_enable(wdt_clock);
@@ -418,8 +419,7 @@ static int s3c2410wdt_probe(struct platf
 	if (ret) {
 		printk (KERN_ERR PFX "cannot register miscdev on minor=%d (%d)\n",
 			WATCHDOG_MINOR, ret);
-		iounmap(wdt_base);
-		return ret;
+		goto err_clk;
 	}
 
 	if (tmr_atboot && started == 0) {
@@ -434,26 +434,36 @@ static int s3c2410wdt_probe(struct platf
 	}
 
 	return 0;
+
+ err_clk:
+	clk_disable(wdt_clock);
+	clk_put(wdt_clock);
+	
+ err_irq:
+	free_irq(wdt_irq->start, pdev);
+
+ err_map:
+	iounmap(wdt_base);
+
+ err_req:
+	release_resource(wdt_mem);
+	kfree(wdt_mem);
+
+	return ret;
 }
 
 static int s3c2410wdt_remove(struct platform_device *dev)
 {
-	if (wdt_mem != NULL) {
-		release_resource(wdt_mem);
-		kfree(wdt_mem);
-		wdt_mem = NULL;
-	}
-
-	if (wdt_irq != NULL) {
-		free_irq(wdt_irq->start, dev);
-		wdt_irq = NULL;
-	}
-
-	if (wdt_clock != NULL) {
-		clk_disable(wdt_clock);
-		clk_put(wdt_clock);
-		wdt_clock = NULL;
-	}
+	release_resource(wdt_mem);
+	kfree(wdt_mem);
+	wdt_mem = NULL;
+	
+	free_irq(wdt_irq->start, dev);
+	wdt_irq = NULL;
+
+	clk_disable(wdt_clock);
+	clk_put(wdt_clock);
+	wdt_clock = NULL;
 
 	iounmap(wdt_base);
 	misc_deregister(&s3c2410wdt_miscdev);

--IJpNTDwzlM2Ie8A6--
