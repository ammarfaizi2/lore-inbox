Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030314AbWAKG7H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030314AbWAKG7H (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 01:59:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030269AbWAKG6r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 01:58:47 -0500
Received: from smtp113.sbc.mail.mud.yahoo.com ([68.142.198.212]:7609 "HELO
	smtp113.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1030297AbWAKG6l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 01:58:41 -0500
Message-Id: <20060111065751.899771000.dtor_core@ameritech.net>
References: <20060111064746.560312000.dtor_core@ameritech.net>
Date: Wed, 11 Jan 2006 01:47:49 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Russell King <rmk@arm.linux.org.uk>
Subject: [patch 3/6] mv64x600_wdt: convert to the new platform device interface
Content-Disposition: inline; filename=mv64x60_wdt-new-platform-intf.patch
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
 

