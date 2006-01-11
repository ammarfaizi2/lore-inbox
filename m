Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1160994AbWAKG7K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1160994AbWAKG7K (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 01:59:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030283AbWAKG6p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 01:58:45 -0500
Received: from smtp109.sbc.mail.mud.yahoo.com ([68.142.198.208]:44168 "HELO
	smtp109.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1030299AbWAKG6l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 01:58:41 -0500
Message-Id: <20060111065752.245711000.dtor_core@ameritech.net>
References: <20060111064746.560312000.dtor_core@ameritech.net>
Date: Wed, 11 Jan 2006 01:47:52 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Russell King <rmk@arm.linux.org.uk>
Subject: [patch 6/6] serial8250: convert to the new platform device interface
Content-Disposition: inline; filename=8250-new-platform-intf.patch
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

serial8250: convert to the new platform device interface

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
@@ -2453,6 +2453,7 @@ static struct platform_driver serial8250
 	.resume		= serial8250_resume,
 	.driver		= {
 		.name	= "serial8250",
+		.owner	= THIS_MODULE,
 	},
 };
 
@@ -2593,21 +2594,30 @@ static int __init serial8250_init(void)
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

