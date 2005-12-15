Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964949AbVLOGqZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964949AbVLOGqZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 01:46:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965154AbVLOGqZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 01:46:25 -0500
Received: from smtp101.sbc.mail.re2.yahoo.com ([68.142.229.104]:7012 "HELO
	smtp101.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S964949AbVLOGqY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 01:46:24 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] vr41xx: convert to the new platform device interface
Date: Thu, 15 Dec 2005 01:46:20 -0500
User-Agent: KMail/1.8.3
Cc: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>,
       Russell King <rmk+lkml@arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512150146.21103.dtor_core@ameritech.net>
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

 drivers/char/vr41xx_giu.c   |   24 +++++++++++++++---------
 drivers/char/vr41xx_rtc.c   |   29 ++++++++++++++++++++---------
 drivers/serial/vr41xx_siu.c |   24 +++++++++++++++---------
 3 files changed, 50 insertions(+), 27 deletions(-)

Index: work/drivers/char/vr41xx_rtc.c
===================================================================
--- work.orig/drivers/char/vr41xx_rtc.c
+++ work/drivers/char/vr41xx_rtc.c
@@ -560,7 +560,7 @@ static struct miscdevice rtc_miscdevice 
 	.fops	= &rtc_fops,
 };
 
-static int rtc_probe(struct platform_device *pdev)
+static int __devinit rtc_probe(struct platform_device *pdev)
 {
 	unsigned int irq;
 	int retval;
@@ -633,7 +633,7 @@ static int rtc_probe(struct platform_dev
 	return 0;
 }
 
-static int rtc_remove(struct platform_device *dev)
+static int __devexit rtc_remove(struct platform_device *dev)
 {
 	int retval;
 
@@ -655,13 +655,14 @@ static struct platform_device *rtc_platf
 
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
 
@@ -686,9 +687,20 @@ static int __devinit vr41xx_rtc_init(voi
 		break;
 	}
 
-	rtc_platform_device = platform_device_register_simple("RTC", -1, rtc_resource, RTC_NUM_RESOURCES);
-	if (IS_ERR(rtc_platform_device))
-		return PTR_ERR(rtc_platform_device);
+	rtc_platform_device = platform_device_alloc("RTC", -1);
+	if (!rtc_platform_device)
+		return -ENOMEM;
+
+	retval = platform_device_add_resources(rtc_platform_device,
+					rtc_resource, RTC_NUM_RESOURCES);
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
@@ -697,10 +709,9 @@ static int __devinit vr41xx_rtc_init(voi
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
 
@@ -712,19 +712,26 @@ static struct platform_device *giu_platf
 
 static struct platform_driver giu_device_driver = {
 	.probe		= giu_probe,
-	.remove		= giu_remove,
+	.remove		= __devexit_p(giu_remove),
 	.driver		= {
 		.name	= "GIU",
+		.owner	= THIS_MODULE,
 	},
 };
 
-static int __devinit vr41xx_giu_init(void)
+static int __init vr41xx_giu_init(void)
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
@@ -733,10 +740,9 @@ static int __devinit vr41xx_giu_init(voi
 	return retval;
 }
 
-static void __devexit vr41xx_giu_exit(void)
+static void __exit vr41xx_giu_exit(void)
 {
 	platform_driver_unregister(&giu_device_driver);
-
 	platform_device_unregister(giu_platform_device);
 }
 
Index: work/drivers/serial/vr41xx_siu.c
===================================================================
--- work.orig/drivers/serial/vr41xx_siu.c
+++ work/drivers/serial/vr41xx_siu.c
@@ -924,7 +924,7 @@ static struct uart_driver siu_uart_drive
 	.cons		= SERIAL_VR41XX_CONSOLE,
 };
 
-static int siu_probe(struct platform_device *dev)
+static int __devinit siu_probe(struct platform_device *dev)
 {
 	struct uart_port *port;
 	int num, i, retval;
@@ -958,7 +958,7 @@ static int siu_probe(struct platform_dev
 	return 0;
 }
 
-static int siu_remove(struct platform_device *dev)
+static int __devexit siu_remove(struct platform_device *dev)
 {
 	struct uart_port *port;
 	int i;
@@ -1011,21 +1011,28 @@ static struct platform_device *siu_platf
 
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
@@ -1034,10 +1041,9 @@ static int __devinit vr41xx_siu_init(voi
 	return retval;
 }
 
-static void __devexit vr41xx_siu_exit(void)
+static void __exit vr41xx_siu_exit(void)
 {
 	platform_driver_unregister(&siu_device_driver);
-
 	platform_device_unregister(siu_platform_device);
 }
 
