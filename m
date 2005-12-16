Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932158AbVLPHAY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932158AbVLPHAY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 02:00:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932160AbVLPHAX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 02:00:23 -0500
Received: from smtp101.sbc.mail.re2.yahoo.com ([68.142.229.104]:53943 "HELO
	smtp101.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S932158AbVLPHAX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 02:00:23 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH/RFT] tb0219: convert to the new platform device interface
Date: Fri, 16 Dec 2005 02:00:20 -0500
User-Agent: KMail/1.8.3
Cc: Russell King <rmk+lkml@arm.linux.org.uk>,
       Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512160200.21031.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

tb0219: convert to the new platform device interface

Do not use platform_device_register_simple() as it is going away.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/char/tb0219.c |   24 +++++++++++++++---------
 1 files changed, 15 insertions(+), 9 deletions(-)

Index: work/drivers/char/tb0219.c
===================================================================
--- work.orig/drivers/char/tb0219.c
+++ work/drivers/char/tb0219.c
@@ -283,7 +283,7 @@ static void tb0219_pci_irq_init(void)
 	vr41xx_set_irq_level(TB0219_PCI_SLOT3_PIN, IRQ_LEVEL_LOW);
 }
 
-static int tb0219_probe(struct platform_device *dev)
+static int __devinit tb0219_probe(struct platform_device *dev)
 {
 	int retval;
 
@@ -319,7 +319,7 @@ static int tb0219_probe(struct platform_
 	return 0;
 }
 
-static int tb0219_remove(struct platform_device *dev)
+static int __devexit tb0219_remove(struct platform_device *dev)
 {
 	_machine_restart = old_machine_restart;
 
@@ -335,19 +335,26 @@ static struct platform_device *tb0219_pl
 
 static struct platform_driver tb0219_device_driver = {
 	.probe		= tb0219_probe,
-	.remove		= tb0219_remove,
+	.remove		= __devexit_p(tb0219_remove),
 	.driver		= {
 		.name	= "TB0219",
+		.owner	= THIS_MODULE,
 	},
 };
 
-static int __devinit tanbac_tb0219_init(void)
+static int __init tanbac_tb0219_init(void)
 {
 	int retval;
 
-	tb0219_platform_device = platform_device_register_simple("TB0219", -1, NULL, 0);
-	if (IS_ERR(tb0219_platform_device))
-		return PTR_ERR(tb0219_platform_device);
+	tb0219_platform_device = platform_device_alloc("TB0219", -1);
+	if (!tb0219_platform_device)
+		return -ENOMEM;
+
+	retval = platform_device_add(tb0219_platform_device);
+	if (retval < 0) {
+		platform_device_put(tb0219_platform_device);
+		return retval;
+	}
 
 	retval = platform_driver_register(&tb0219_device_driver);
 	if (retval < 0)
@@ -356,10 +363,9 @@ static int __devinit tanbac_tb0219_init(
 	return retval;
 }
 
-static void __devexit tanbac_tb0219_exit(void)
+static void __exit tanbac_tb0219_exit(void)
 {
 	platform_driver_unregister(&tb0219_device_driver);
-
 	platform_device_unregister(tb0219_platform_device);
 }
 
