Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161020AbWAGTdU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161020AbWAGTdU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 14:33:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161022AbWAGTcw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 14:32:52 -0500
Received: from smtp107.sbc.mail.re2.yahoo.com ([68.142.229.98]:50567 "HELO
	smtp107.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1161020AbWAGTcr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 14:32:47 -0500
Message-Id: <20060107172101.016590000.dtor_core@ameritech.net>
References: <20060107171559.593824000.dtor_core@ameritech.net>
Date: Sat, 07 Jan 2006 12:16:12 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Vojtech Pavlik <vojtech@suse.cz>
Subject: [PATCH 13/24] m68kspkr: register with driver core as a platfrom device
Content-Disposition: inline; filename=m68kspkr-platform-device.patch
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Input: m68kspkr - register with driver core as a platfrom device

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/misc/m68kspkr.c |  104 ++++++++++++++++++++++++++++++++++--------
 1 files changed, 86 insertions(+), 18 deletions(-)

Index: work/drivers/input/misc/m68kspkr.c
===================================================================
--- work.orig/drivers/input/misc/m68kspkr.c
+++ work/drivers/input/misc/m68kspkr.c
@@ -17,6 +17,7 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/input.h>
+#include <linux/platform_device.h>
 #include <asm/machdep.h>
 #include <asm/io.h>
 
@@ -24,7 +25,7 @@ MODULE_AUTHOR("Richard Zidlicky <rz@linu
 MODULE_DESCRIPTION("m68k beeper driver");
 MODULE_LICENSE("GPL");
 
-static struct input_dev *m68kspkr_dev;
+static struct platform_device *m68kspkr_platform_device;
 
 static int m68kspkr_event(struct input_dev *dev, unsigned int type, unsigned int code, int value)
 {
@@ -47,36 +48,103 @@ static int m68kspkr_event(struct input_d
 	return 0;
 }
 
+static int __devinit m68kspkr_probe(struct platform_device *dev)
+{
+	struct input_dev *input_dev;
+	int err;
+
+	input_dev = input_allocate_device();
+	if (!input_dev)
+		return -ENOMEM;
+
+	input_dev->name = "m68k beeper";
+	input_dev->phys = "m68k/generic";
+	input_dev->id.bustype = BUS_HOST;
+	input_dev->id.vendor  = 0x001f;
+	input_dev->id.product = 0x0001;
+	input_dev->id.version = 0x0100;
+	input_dev->cdev.dev = &dev->dev;
+
+	input_dev->evbit[0] = BIT(EV_SND);
+	input_dev->sndbit[0] = BIT(SND_BELL) | BIT(SND_TONE);
+	input_dev->event = m68kspkr_event;
+
+	err = input_register_device(input_dev);
+	if (err) {
+		input_free_device(input_dev);
+		return err;
+	}
+
+	platform_set_drvdata(dev, input_dev);
+
+	return 0;
+}
+
+static int __devexit m68kspkr_remove(struct platform_device *dev)
+{
+	struct input_dev *input_dev = platform_get_drvdata(dev);
+
+	input_unregister_device(input_dev);
+	platform_set_drvdata(dev, NULL);
+	/* turn off the speaker */
+	m68kspkr_event(NULL, EV_SND, SND_BELL, 0);
+
+	return 0;
+}
+
+static void m68kspkr_shutdown(struct platform_device *dev)
+{
+	/* turn off the speaker */
+	m68kspkr_event(NULL, EV_SND, SND_BELL, 0);
+}
+
+static struct platform_driver m68kspkr_platform_driver = {
+	.driver		= {
+		.name	= "m68kspkr",
+		.owner	= THIS_MODULE,
+	},
+	.probe		= m68kspkr_probe,
+	.remove		= __devexit_p(m68kspkr_remove),
+	.shutdown	= m68kspkr_shutdown,
+};
+
 static int __init m68kspkr_init(void)
 {
-        if (!mach_beep) {
+	int err;
+
+	if (!mach_beep) {
 		printk(KERN_INFO "m68kspkr: no lowlevel beep support\n");
 		return -ENODEV;
         }
 
-	m68kspkr_dev = input_allocate_device();
-	if (!m68kspkr_dev)
-		return -ENOMEM;
-
-	m68kspkr_dev->name = "m68k beeper";
-	m68kspkr_dev->phys = "m68k/generic";
-	m68kspkr_dev->id.bustype = BUS_HOST;
-	m68kspkr_dev->id.vendor = 0x001f;
-	m68kspkr_dev->id.product = 0x0001;
-	m68kspkr_dev->id.version = 0x0100;
-
-	m68kspkr_dev->evbit[0] = BIT(EV_SND);
-	m68kspkr_dev->sndbit[0] = BIT(SND_BELL) | BIT(SND_TONE);
-	m68kspkr_dev->event = m68kspkr_event;
+	err = platform_driver_register(&m68kspkr_platform_driver);
+	if (err)
+		return err;
+
+	m68kspkr_platform_device = platform_device_alloc("m68kspkr", -1);
+	if (!m68kspkr_platform_device) {
+		err = -ENOMEM;
+		goto err_unregister_driver;
+	}
 
-	input_register_device(m68kspkr_dev);
+	err = platform_device_add(m68kspkr_platform_device);
+	if (err)
+		goto err_free_device;
 
 	return 0;
+
+ err_free_device:
+	platform_device_put(m68kspkr_platform_device);
+ err_unregister_driver:
+	platform_driver_unregister(&m68kspkr_platform_driver);
+
+	return err;
 }
 
 static void __exit m68kspkr_exit(void)
 {
-        input_unregister_device(m68kspkr_dev);
+	platform_device_unregister(m68kspkr_platform_device);
+	platform_driver_unregister(&m68kspkr_platform_driver);
 }
 
 module_init(m68kspkr_init);

