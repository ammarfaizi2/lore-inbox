Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030311AbWAKG7K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030311AbWAKG7K (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 01:59:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030299AbWAKG6q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 01:58:46 -0500
Received: from smtp110.sbc.mail.mud.yahoo.com ([68.142.198.209]:55695 "HELO
	smtp110.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1030269AbWAKG6l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 01:58:41 -0500
Message-Id: <20060111065751.786305000.dtor_core@ameritech.net>
References: <20060111064746.560312000.dtor_core@ameritech.net>
Date: Wed, 11 Jan 2006 01:47:48 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Russell King <rmk@arm.linux.org.uk>
Subject: [patch 2/6] vr41xx: convert to the new platform device interface
Content-Disposition: inline; filename=vr41xx-new-platform-intf.patch
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

vr41xx: convert to the new platform device interface

The patch does the following for v441xx seris drivers:

 - stop using platform_device_register_simple() as it is going away
 - mark ->probe() and ->remove() methods as __devinit and __devexit
   respectively
 - initialize "owner" field in driver structure so there is a link
   from /sys/modules to the driver
 - mark *_init() and *_exit() functions as __init and __exit

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/char/vr41xx_giu.c   |   19 +++++++++++++------
 drivers/char/vr41xx_rtc.c   |   30 ++++++++++++++++++++----------
 drivers/serial/vr41xx_siu.c |   24 +++++++++++++++---------
 3 files changed, 48 insertions(+), 25 deletions(-)

Index: work/drivers/char/vr41xx_rtc.c
===================================================================
--- work.orig/drivers/char/vr41xx_rtc.c
+++ work/drivers/char/vr41xx_rtc.c
@@ -558,7 +558,7 @@ static struct miscdevice rtc_miscdevice 
 	.fops	= &rtc_fops,
 };
 
-static int rtc_probe(struct platform_device *pdev)
+static int __devinit rtc_probe(struct platform_device *pdev)
 {
 	unsigned int irq;
 	int retval;
@@ -631,7 +631,7 @@ static int rtc_probe(struct platform_dev
 	return 0;
 }
 
-static int rtc_remove(struct platform_device *dev)
+static int __devexit rtc_remove(struct platform_device *dev)
 {
 	int retval;
 
@@ -653,13 +653,14 @@ static struct platform_device *rtc_platf
 
 static struct platform_driver rtc_device_driver = {
 	.probe		= rtc_probe,
-	.remove		= rtc_remove,
+	.remove		= __devexit_p(rtc_remove),
 	.driver		= {
 		.name	= rtc_name,
+		.owner	= THIS_MODULE,
 	},
 };
 
-static int __devinit vr41xx_rtc_init(void)
+static int __init vr41xx_rtc_init(void)
 {
 	int retval;
 
@@ -684,10 +685,20 @@ static int __devinit vr41xx_rtc_init(voi
 		break;
 	}
 
-	rtc_platform_device = platform_device_register_simple("RTC", -1,
-			      rtc_resource, ARRAY_SIZE(rtc_resource));
-	if (IS_ERR(rtc_platform_device))
-		return PTR_ERR(rtc_platform_device);
+	rtc_platform_device = platform_device_alloc("RTC", -1);
+	if (!rtc_platform_device)
+		return -ENOMEM;
+
+	retval = platform_device_add_resources(rtc_platform_device,
+				rtc_resource, ARRAY_SIZE(rtc_resource));
+
+	if (retval == 0)
+		retval = platform_device_add(rtc_platform_device);
+
+	if (retval < 0) {
+		platform_device_put(rtc_platform_device);
+		return retval;
+	}
 
 	retval = platform_driver_register(&rtc_device_driver);
 	if (retval < 0)
@@ -696,10 +707,9 @@ static int __devinit vr41xx_rtc_init(voi
 	return retval;
 }
 
-static void __devexit vr41xx_rtc_exit(void)
+static void __exit vr41xx_rtc_exit(void)
 {
 	platform_driver_unregister(&rtc_device_driver);
-
 	platform_device_unregister(rtc_platform_device);
 }
 
Index: work/drivers/char/vr41xx_giu.c
===================================================================
--- work.orig/drivers/char/vr41xx_giu.c
+++ work/drivers/char/vr41xx_giu.c
@@ -613,7 +613,7 @@ static struct file_operations gpio_fops 
 	.release	= gpio_release,
 };
 
-static int giu_probe(struct platform_device *dev)
+static int __devinit giu_probe(struct platform_device *dev)
 {
 	unsigned long start, size, flags = 0;
 	unsigned int nr_pins = 0;
@@ -697,7 +697,7 @@ static int giu_probe(struct platform_dev
 	return cascade_irq(GIUINT_IRQ, giu_get_irq);
 }
 
-static int giu_remove(struct platform_device *dev)
+static int __devexit giu_remove(struct platform_device *dev)
 {
 	iounmap(giu_base);
 
@@ -712,9 +712,10 @@ static struct platform_device *giu_platf
 
 static struct platform_driver giu_device_driver = {
 	.probe		= giu_probe,
-	.remove		= giu_remove,
+	.remove		= __devexit_p(giu_remove),
 	.driver		= {
 		.name	= "GIU",
+		.owner	= THIS_MODULE,
 	},
 };
 
@@ -722,9 +723,15 @@ static int __init vr41xx_giu_init(void)
 {
 	int retval;
 
-	giu_platform_device = platform_device_register_simple("GIU", -1, NULL, 0);
-	if (IS_ERR(giu_platform_device))
-		return PTR_ERR(giu_platform_device);
+	giu_platform_device = platform_device_alloc("GIU", -1);
+	if (!giu_platform_device)
+		return -ENOMEM;
+
+	retval = platform_device_add(giu_platform_device);
+	if (retval < 0) {
+		platform_device_put(giu_platform_device);
+		return retval;
+	}
 
 	retval = platform_driver_register(&giu_device_driver);
 	if (retval < 0)
Index: work/drivers/serial/vr41xx_siu.c
===================================================================
--- work.orig/drivers/serial/vr41xx_siu.c
+++ work/drivers/serial/vr41xx_siu.c
@@ -919,7 +919,7 @@ static struct uart_driver siu_uart_drive
 	.cons		= SERIAL_VR41XX_CONSOLE,
 };
 
-static int siu_probe(struct platform_device *dev)
+static int __devinit siu_probe(struct platform_device *dev)
 {
 	struct uart_port *port;
 	int num, i, retval;
@@ -953,7 +953,7 @@ static int siu_probe(struct platform_dev
 	return 0;
 }
 
-static int siu_remove(struct platform_device *dev)
+static int __devexit siu_remove(struct platform_device *dev)
 {
 	struct uart_port *port;
 	int i;
@@ -1006,21 +1006,28 @@ static struct platform_device *siu_platf
 
 static struct platform_driver siu_device_driver = {
 	.probe		= siu_probe,
-	.remove		= siu_remove,
+	.remove		= __devexit_p(siu_remove),
 	.suspend	= siu_suspend,
 	.resume		= siu_resume,
 	.driver		= {
 		.name	= "SIU",
+		.owner	= THIS_MODULE,
 	},
 };
 
-static int __devinit vr41xx_siu_init(void)
+static int __init vr41xx_siu_init(void)
 {
 	int retval;
 
-	siu_platform_device = platform_device_register_simple("SIU", -1, NULL, 0);
-	if (IS_ERR(siu_platform_device))
-		return PTR_ERR(siu_platform_device);
+	siu_platform_device = platform_device_alloc("SIU", -1);
+	if (!siu_platform_device)
+		return -ENOMEM;
+
+	retval = platform_device_add(siu_platform_device);
+	if (retval < 0) {
+		platform_device_put(siu_platform_device);
+		return retval;
+	}
 
 	retval = platform_driver_register(&siu_device_driver);
 	if (retval < 0)
@@ -1029,10 +1036,9 @@ static int __devinit vr41xx_siu_init(voi
 	return retval;
 }
 
-static void __devexit vr41xx_siu_exit(void)
+static void __exit vr41xx_siu_exit(void)
 {
 	platform_driver_unregister(&siu_device_driver);
-
 	platform_device_unregister(siu_platform_device);
 }
 

