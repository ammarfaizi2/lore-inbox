Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030548AbWAGTNI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030548AbWAGTNI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 14:13:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030563AbWAGTMj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 14:12:39 -0500
Received: from smtp110.sbc.mail.re2.yahoo.com ([68.142.229.95]:14253 "HELO
	smtp110.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1030558AbWAGTIX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 14:08:23 -0500
Message-Id: <20060107172101.625487000.dtor_core@ameritech.net>
References: <20060107171559.593824000.dtor_core@ameritech.net>
Date: Sat, 07 Jan 2006 12:16:17 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Vojtech Pavlik <vojtech@suse.cz>
Subject: [PATCH 18/24] maceps2: convert to the new platform device interface
Content-Disposition: inline; filename=maceps2-convert-platform-intf.patch
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Input: maceps2 - convert to the new platform device interface

Do not use platform_device_register_simple() as it is going away,
implement ->probe() and ->remove() functions so manual binding and
unbinding will work with this driver.


Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/serio/maceps2.c |   68 ++++++++++++++++++++++++++++++++----------
 1 files changed, 52 insertions(+), 16 deletions(-)

Index: work/drivers/input/serio/maceps2.c
===================================================================
--- work.orig/drivers/input/serio/maceps2.c
+++ work/drivers/input/serio/maceps2.c
@@ -118,13 +118,12 @@ static void maceps2_close(struct serio *
 }
 
 
-static struct serio * __init maceps2_allocate_port(int idx)
+static struct serio * __devinit maceps2_allocate_port(int idx)
 {
 	struct serio *serio;
 
-	serio = kmalloc(sizeof(struct serio), GFP_KERNEL);
+	serio = kzalloc(sizeof(struct serio), GFP_KERNEL);
 	if (serio) {
-		memset(serio, 0, sizeof(struct serio));
 		serio->id.type		= SERIO_8042;
 		serio->write		= maceps2_write;
 		serio->open		= maceps2_open;
@@ -138,24 +137,13 @@ static struct serio * __init maceps2_all
 	return serio;
 }
 
-
-static int __init maceps2_init(void)
+static int __devinit maceps2_probe(struct platform_device *dev)
 {
-	maceps2_device = platform_device_register_simple("maceps2", -1, NULL, 0);
-	if (IS_ERR(maceps2_device))
-		return PTR_ERR(maceps2_device);
-
-	port_data[0].port = &mace->perif.ps2.keyb;
-	port_data[0].irq  = MACEISA_KEYB_IRQ;
-	port_data[1].port = &mace->perif.ps2.mouse;
-	port_data[1].irq  = MACEISA_MOUSE_IRQ;
-
 	maceps2_port[0] = maceps2_allocate_port(0);
 	maceps2_port[1] = maceps2_allocate_port(1);
 	if (!maceps2_port[0] || !maceps2_port[1]) {
 		kfree(maceps2_port[0]);
 		kfree(maceps2_port[1]);
-		platform_device_unregister(maceps2_device);
 		return -ENOMEM;
 	}
 
@@ -165,11 +153,59 @@ static int __init maceps2_init(void)
 	return 0;
 }
 
-static void __exit maceps2_exit(void)
+static int __devexit maceps2_remove(struct platform_device *dev)
 {
 	serio_unregister_port(maceps2_port[0]);
 	serio_unregister_port(maceps2_port[1]);
+
+	return 0;
+}
+
+static struct platform_driver maceps2_driver = {
+	.driver		= {
+		.name	= "maceps2",
+		.owner	= THIS_MODULE,
+	},
+	.probe		= maceps2_probe,
+	.remove		= __devexit_p(maceps2_remove),
+};
+
+static int __init maceps2_init(void)
+{
+	int error;
+
+	error = platform_driver_register(&maceps2_driver);
+	if (error)
+		return error;
+
+	maceps2_device = platform_device_alloc("maceps2", -1);
+	if (!maceps2_device) {
+		error = -ENOMEM;
+		goto err_unregister_driver;
+	}
+
+	port_data[0].port = &mace->perif.ps2.keyb;
+	port_data[0].irq  = MACEISA_KEYB_IRQ;
+	port_data[1].port = &mace->perif.ps2.mouse;
+	port_data[1].irq  = MACEISA_MOUSE_IRQ;
+
+	error = platform_device_add(maceps2_device);
+	if (error)
+		goto err_free_device;
+
+	return 0;
+
+ err_free_device:
+	platform_device_put(maceps2_device);
+ err_unregister_driver:
+	platform_driver_unregister(&maceps2_driver);
+	return error;
+}
+
+static void __exit maceps2_exit(void)
+{
 	platform_device_unregister(maceps2_device);
+	platform_driver_unregister(&maceps2_driver);
 }
 
 module_init(maceps2_init);

