Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751370AbVLQHFP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751370AbVLQHFP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Dec 2005 02:05:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751371AbVLQHFO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Dec 2005 02:05:14 -0500
Received: from smtp101.sbc.mail.re2.yahoo.com ([68.142.229.104]:52140 "HELO
	smtp101.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1751365AbVLQHFN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Dec 2005 02:05:13 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: [PATCH] serial8250: convert to the new platform device interface
Date: Sat, 17 Dec 2005 02:05:07 -0500
User-Agent: KMail/1.8.3
Cc: LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512170205.07926.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Do not use platform_device_register_simple() as it is going away.
Also set up driver's owner to create link driver->module in sysfs. 

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/serial/8250.c |   30 ++++++++++++++++++++----------
 1 files changed, 20 insertions(+), 10 deletions(-)

Index: work/drivers/serial/8250.c
===================================================================
--- work.orig/drivers/serial/8250.c
+++ work/drivers/serial/8250.c
@@ -2466,6 +2466,7 @@ static struct platform_driver serial8250
 	.resume		= serial8250_resume,
 	.driver		= {
 		.name	= "serial8250",
+		.owner	= THIS_MODULE,
 	},
 };
 
@@ -2603,21 +2604,30 @@ static int __init serial8250_init(void)
 	if (ret)
 		goto out;
 
-	serial8250_isa_devs = platform_device_register_simple("serial8250",
-					 PLAT8250_DEV_LEGACY, NULL, 0);
-	if (IS_ERR(serial8250_isa_devs)) {
-		ret = PTR_ERR(serial8250_isa_devs);
-		goto unreg;
+	ret = platform_driver_register(&serial8250_isa_driver);
+	if (ret)
+		goto unreg_uart_drv;
+
+	serial8250_isa_devs = platform_device_alloc("serial8250",
+						    PLAT8250_DEV_LEGACY);
+	if (!serial8250_isa_devs) {
+		ret = -ENOMEM;
+		goto unreg_plat_drv;
 	}
 
+	ret = platform_device_add(serial8250_isa_devs);
+	if (ret)
+		goto put_dev;
+
 	serial8250_register_ports(&serial8250_reg, &serial8250_isa_devs->dev);
 
-	ret = platform_driver_register(&serial8250_isa_driver);
-	if (ret == 0)
-		goto out;
+	goto out;
 
-	platform_device_unregister(serial8250_isa_devs);
- unreg:
+ put_dev:
+	platform_device_put(serial8250_isa_devs);
+ unreg_plat_drv:
+	platform_driver_unregister(&serial8250_isa_driver);
+ unreg_uart_drv:
 	uart_unregister_driver(&serial8250_reg);
  out:
 	return ret;
