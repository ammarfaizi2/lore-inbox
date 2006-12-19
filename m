Return-Path: <linux-kernel-owner+w=401wt.eu-S932690AbWLSIwi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932690AbWLSIwi (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 03:52:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932685AbWLSIwi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 03:52:38 -0500
Received: from wx-out-0506.google.com ([66.249.82.232]:17341 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932691AbWLSIwh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 03:52:37 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mail-followup-to:mime-version:content-type:content-disposition:user-agent;
        b=WsvBqCv7gqmtJBpAZwXLcE8jeh2fsB+y2QdRs+yOFIDOJrK0wYPA7mUfpDUpeF2A2yMlz8dhbhnTO06tA/HdlNrEHxkvtan7YHvm3Glz85kyCR45Mnb13VlqXiI9CAgHJ0VMUtTx+h6IshLsgfDPkwR1r7AS/FFfYlWKwG+AeT8=
Date: Tue, 19 Dec 2006 17:51:44 +0900
From: Akinobu Mita <akinobu.mita@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Wim Van Sebroeck <wim@iguana.be>, Ben Dooks <ben@simtec.co.uk>,
       Dimitry Andric <dimitry.andric@tomtom.com>
Subject: [PATCH] watchdog: fix clk_get() error check
Message-ID: <20061219085144.GI4049@APFDCB5C>
Mail-Followup-To: Akinobu Mita <akinobu.mita@gmail.com>,
	linux-kernel@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>,
	Ben Dooks <ben@simtec.co.uk>,
	Dimitry Andric <dimitry.andric@tomtom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The return value of clk_get() should be checked by IS_ERR().

Cc: Wim Van Sebroeck <wim@iguana.be>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>

---
 drivers/char/watchdog/pnx4008_wdt.c |    3 ++-
 drivers/char/watchdog/s3c2410_wdt.c |    4 ++--
 2 files changed, 4 insertions(+), 3 deletions(-)

Index: 2.6-mm/drivers/char/watchdog/pnx4008_wdt.c
===================================================================
--- 2.6-mm.orig/drivers/char/watchdog/pnx4008_wdt.c
+++ 2.6-mm/drivers/char/watchdog/pnx4008_wdt.c
@@ -283,7 +283,8 @@ static int pnx4008_wdt_probe(struct plat
 	wdt_base = (void __iomem *)IO_ADDRESS(res->start);
 
 	wdt_clk = clk_get(&pdev->dev, "wdt_ck");
-	if (!wdt_clk) {
+	if (IS_ERR(wdt_clk)) {
+		ret = PTR_ERR(wdt_clk);
 		release_resource(wdt_mem);
 		kfree(wdt_mem);
 		goto out;
Index: 2.6-mm/drivers/char/watchdog/s3c2410_wdt.c
===================================================================
--- 2.6-mm.orig/drivers/char/watchdog/s3c2410_wdt.c
+++ 2.6-mm/drivers/char/watchdog/s3c2410_wdt.c
@@ -392,10 +392,10 @@ static int s3c2410wdt_probe(struct platf
 	}
 
 	wdt_clock = clk_get(&pdev->dev, "watchdog");
-	if (wdt_clock == NULL) {
+	if (IS_ERR(wdt_clock)) {
 		printk(KERN_INFO PFX "failed to find watchdog clock source\n");
 		iounmap(wdt_base);
-		return -ENOENT;
+		return PTR_ERR(wdt_clock);
 	}
 
 	clk_enable(wdt_clock);
