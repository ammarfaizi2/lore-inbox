Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030551AbWAGTN4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030551AbWAGTN4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 14:13:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030553AbWAGTMg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 14:12:36 -0500
Received: from smtp107.sbc.mail.re2.yahoo.com ([68.142.229.98]:31864 "HELO
	smtp107.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1030560AbWAGTIY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 14:08:24 -0500
Message-Id: <20060107172101.179731000.dtor_core@ameritech.net>
References: <20060107171559.593824000.dtor_core@ameritech.net>
Date: Sat, 07 Jan 2006 12:16:13 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Vojtech Pavlik <vojtech@suse.cz>
Subject: [PATCH 14/24] sparcspkr: register with driver core as a platfrom device
Content-Disposition: inline; filename=sparcspkr-platform-device.patch
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Input: sparcspkr - register with driver core as a platfrom device

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/misc/sparcspkr.c |  162 ++++++++++++++++++++++++++---------------
 1 files changed, 105 insertions(+), 57 deletions(-)

Index: work/drivers/input/misc/sparcspkr.c
===================================================================
--- work.orig/drivers/input/misc/sparcspkr.c
+++ work/drivers/input/misc/sparcspkr.c
@@ -9,6 +9,7 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/input.h>
+#include <linux/platform_device.h>
 
 #include <asm/io.h>
 #include <asm/ebus.h>
@@ -20,22 +21,10 @@ MODULE_AUTHOR("David S. Miller <davem@re
 MODULE_DESCRIPTION("Sparc Speaker beeper driver");
 MODULE_LICENSE("GPL");
 
+const char *beep_name;
 static unsigned long beep_iobase;
-static struct input_dev *sparcspkr_dev;
-
-DEFINE_SPINLOCK(beep_lock);
-
-static void __init init_sparcspkr_struct(void)
-{
-	sparcspkr_dev->evbit[0] = BIT(EV_SND);
-	sparcspkr_dev->sndbit[0] = BIT(SND_BELL) | BIT(SND_TONE);
-
-	sparcspkr_dev->phys = "sparc/input0";
-	sparcspkr_dev->id.bustype = BUS_ISA;
-	sparcspkr_dev->id.vendor = 0x001f;
-	sparcspkr_dev->id.product = 0x0001;
-	sparcspkr_dev->id.version = 0x0100;
-}
+static int (*beep_event)(struct input_dev *dev, unsigned int type, unsigned int code, int value);
+static DEFINE_SPINLOCK(beep_lock);
 
 static int ebus_spkr_event(struct input_dev *dev, unsigned int type, unsigned int code, int value)
 {
@@ -59,39 +48,16 @@ static int ebus_spkr_event(struct input_
 	/* EBUS speaker only has on/off state, the frequency does not
 	 * appear to be programmable.
 	 */
-	if (count) {
-		if (beep_iobase & 0x2UL)
-			outb(1, beep_iobase);
-		else
-			outl(1, beep_iobase);
-	} else {
-		if (beep_iobase & 0x2UL)
-			outb(0, beep_iobase);
-		else
-			outl(0, beep_iobase);
-	}
+	if (beep_iobase & 0x2UL)
+		outb(!!count, beep_iobase);
+	else
+		outl(!!count, beep_iobase);
 
 	spin_unlock_irqrestore(&beep_lock, flags);
 
 	return 0;
 }
 
-static int __init init_ebus_beep(struct linux_ebus_device *edev)
-{
-	beep_iobase = edev->resource[0].start;
-
-	sparcspkr_dev = input_allocate_device();
-	if (!sparcspkr_dev)
-		return -ENOMEM;
-
-	sparcspkr_dev->name = "Sparc EBUS Speaker";
-	sparcspkr_dev->event = ebus_spkr_event;
-
-	input_register_device(sparcspkr_dev);
-
-	return 0;
-}
-
 #ifdef CONFIG_SPARC64
 static int isa_spkr_event(struct input_dev *dev, unsigned int type, unsigned int code, int value)
 {
@@ -129,30 +95,103 @@ static int isa_spkr_event(struct input_d
 
 	return 0;
 }
+#endif
 
-static int __init init_isa_beep(struct sparc_isa_device *isa_dev)
+static int __devinit sparcspkr_probe(struct platform_device *dev)
 {
-	beep_iobase = isa_dev->resource.start;
+	struct input_dev *input_dev;
+	int error;
 
-	sparcspkr_dev = input_allocate_device();
-	if (!sparcspkr_dev)
+	input_dev = input_allocate_device();
+	if (!input_dev)
 		return -ENOMEM;
 
-	init_sparcspkr_struct();
+	input_dev->name = beep_name;
+	input_dev->phys = "sparc/input0";
+	input_dev->id.bustype = BUS_ISA;
+	input_dev->id.vendor = 0x001f;
+	input_dev->id.product = 0x0001;
+	input_dev->id.version = 0x0100;
+	input_dev->cdev.dev = &dev->dev;
+
+	input_dev->evbit[0] = BIT(EV_SND);
+	input_dev->sndbit[0] = BIT(SND_BELL) | BIT(SND_TONE);
+
+	input_dev->event = beep_event;
+
+	error = input_register_device(input_dev);
+	if (error) {
+		input_free_device(input_dev);
+		return error;
+	}
 
-	sparcspkr_dev->name = "Sparc ISA Speaker";
-	sparcspkr_dev->event = isa_spkr_event;
+	platform_set_drvdata(dev, input_dev);
 
-	input_register_device(sparcspkr_dev);
+	return 0;
+}
+
+static int __devexit sparcspkr_remove(struct platform_device *dev)
+{
+	struct input_dev *input_dev = platform_get_drvdata(dev);
+
+	input_unregister_device(input_dev);
+	platform_set_drvdata(dev, NULL);
+	/* turn off the speaker */
+	beep_event(NULL, EV_SND, SND_BELL, 0);
 
 	return 0;
 }
-#endif
+
+static void sparcspkr_shutdown(struct platform_device *dev)
+{
+	/* turn off the speaker */
+	beep_event(NULL, EV_SND, SND_BELL, 0);
+}
+
+static struct platform_driver sparcspkr_platform_driver = {
+	.driver		= {
+		.name	= "sparcspkr",
+		.owner	= THIS_MODULE,
+	},
+	.probe		= sparcspkr_probe,
+	.remove		= __devexit_p(sparcspkr_remove),
+	.shutdown	= sparcspkr_shutdown,
+};
+
+static struct platform_device *sparcspkr_platform_device;
+
+static int __init sparcspkr_drv_init(void)
+{
+	int error;
+
+	error = platform_driver_register(&sparcspkr_platform_driver);
+	if (error)
+		return error;
+
+	sparcspkr_platform_device = platform_device_alloc("sparcspkr", -1);
+	if (!sparcspkr_platform_device) {
+		error = -ENOMEM;
+		goto err_unregister_driver;
+	}
+
+	error = platform_device_add(sparcspkr_platform_device);
+	if (error)
+		goto err_free_device;
+
+	return 0;
+
+ err_free_device:
+	platform_device_put(sparcspkr_platform_device);
+ err_unregister_driver:
+	platform_driver_unregister(&sparcspkr_platform_driver);
+
+	return error;
+}
 
 static int __init sparcspkr_init(void)
 {
 	struct linux_ebus *ebus;
-	struct linux_ebus_device *edev = NULL;
+	struct linux_ebus_device *edev;
 #ifdef CONFIG_SPARC64
 	struct sparc_isa_bridge *isa_br;
 	struct sparc_isa_device *isa_dev;
@@ -160,8 +199,12 @@ static int __init sparcspkr_init(void)
 
 	for_each_ebus(ebus) {
 		for_each_ebusdev(edev, ebus) {
-			if (!strcmp(edev->prom_name, "beep"))
-				return init_ebus_beep(edev);
+			if (!strcmp(edev->prom_name, "beep")) {
+				beep_name = "Sparc EBUS Speaker";
+				beep_event = ebus_spkr_event;
+				beep_iobase = edev->resource[0].start;
+				return sparcspkr_drv_init();
+			}
 		}
 	}
 #ifdef CONFIG_SPARC64
@@ -170,8 +213,12 @@ static int __init sparcspkr_init(void)
 			/* A hack, the beep device's base lives in
 			 * the DMA isa node.
 			 */
-			if (!strcmp(isa_dev->prom_name, "dma"))
-				return init_isa_beep(isa_dev);
+			if (!strcmp(isa_dev->prom_name, "dma")) {
+				beep_name = "Sparc ISA Speaker";
+				beep_event = isa_spkr_event,
+				beep_iobase = isa_dev->resource.start;
+				return sparcspkr_drv_init();
+			}
 		}
 	}
 #endif
@@ -181,7 +228,8 @@ static int __init sparcspkr_init(void)
 
 static void __exit sparcspkr_exit(void)
 {
-	input_unregister_device(sparcspkr_dev);
+	platform_device_unregister(sparcspkr_platform_device);
+	platform_driver_unregister(&sparcspkr_platform_driver);
 }
 
 module_init(sparcspkr_init);

