Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932141AbVLPHEa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932141AbVLPHEa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 02:04:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932142AbVLPHEa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 02:04:30 -0500
Received: from smtp107.sbc.mail.re2.yahoo.com ([68.142.229.98]:60842 "HELO
	smtp107.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S932141AbVLPHE3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 02:04:29 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] mv64x600_wdt: convert to the new platform device interface
Date: Fri, 16 Dec 2005 02:04:27 -0500
User-Agent: KMail/1.8.3
Cc: Russell King <rmk+lkml@arm.linux.org.uk>,
       James Chapman <jchapman@katalix.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512160204.27718.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mv64x600_wdt: convert to the new platform device interface

Do not use platform_device_register_simple() as it is going away.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/char/watchdog/mv64x60_wdt.c |   20 +++++++++++++++-----
 1 files changed, 15 insertions(+), 5 deletions(-)

Index: work/drivers/char/watchdog/mv64x60_wdt.c
===================================================================
--- work.orig/drivers/char/watchdog/mv64x60_wdt.c
+++ work/drivers/char/watchdog/mv64x60_wdt.c
@@ -228,15 +228,25 @@ static int __init mv64x60_wdt_init(void)
 
 	printk(KERN_INFO "MV64x60 watchdog driver\n");
 
-	mv64x60_wdt_dev = platform_device_register_simple(MV64x60_WDT_NAME,
-							  -1, NULL, 0);
-	if (IS_ERR(mv64x60_wdt_dev)) {
-		ret = PTR_ERR(mv64x60_wdt_dev);
+	mv64x60_wdt_dev = platform_device_alloc(MV64x60_WDT_NAME, -1);
+	if (!mv64x60_wdt_dev) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	ret = platform_device_add(mv64x60_wdt_dev);
+	if (ret) {
+		platform_device_put(mv64x60_wdt_dev);
 		goto out;
 	}
 
 	ret = platform_driver_register(&mv64x60_wdt_driver);
-      out:
+	if (ret) {
+		platform_device_unregister(mv64x60_wdt_dev);
+		goto out;
+	}
+
+ out:
 	return ret;
 }
 
