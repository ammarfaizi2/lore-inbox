Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030544AbWAGTNz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030544AbWAGTNz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 14:13:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030551AbWAGTMi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 14:12:38 -0500
Received: from smtp111.sbc.mail.re2.yahoo.com ([68.142.229.94]:39058 "HELO
	smtp111.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1030563AbWAGTIY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 14:08:24 -0500
Message-Id: <20060107172101.507295000.dtor_core@ameritech.net>
References: <20060107171559.593824000.dtor_core@ameritech.net>
Date: Sat, 07 Jan 2006 12:16:16 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Vojtech Pavlik <vojtech@suse.cz>
Subject: [PATCH 17/24] ct82c710: convert to the new platform device interface
Content-Disposition: inline; filename=ct82c710-convert-platform-intf.patch
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Input: ct82c710 - convert to the new platform device interface

Do not use platform_device_register_simple() as it is going away,
implement ->probe() and ->remove() functions so manual binding and
unbinding will work with this driver.


Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/serio/ct82c710.c |   89 +++++++++++++++++++++++++++++------------
 1 files changed, 63 insertions(+), 26 deletions(-)

Index: work/drivers/input/serio/ct82c710.c
===================================================================
--- work.orig/drivers/input/serio/ct82c710.c
+++ work/drivers/input/serio/ct82c710.c
@@ -154,7 +154,7 @@ static int ct82c710_write(struct serio *
  * See if we can find a 82C710 device. Read mouse address.
  */
 
-static int __init ct82c710_probe(void)
+static int __init ct82c710_detect(void)
 {
 	outb_p(0x55, 0x2fa);				/* Any value except 9, ff or 36 */
 	outb_p(0xaa, 0x3fa);				/* Inverse of 55 */
@@ -163,7 +163,7 @@ static int __init ct82c710_probe(void)
 	outb_p(0x1b, 0x2fa);				/* Inverse of e4 */
 	outb_p(0x0f, 0x390);				/* Write index */
 	if (inb_p(0x391) != 0xe4)			/* Config address found? */
-		return -1;				/* No: no 82C710 here */
+		return -ENODEV;				/* No: no 82C710 here */
 
 	outb_p(0x0d, 0x390);				/* Write index */
 	ct82c710_iores.start = inb_p(0x391) << 2;	/* Get mouse I/O address */
@@ -175,51 +175,88 @@ static int __init ct82c710_probe(void)
 	return 0;
 }
 
-static struct serio * __init ct82c710_allocate_port(void)
+static int __devinit ct82c710_probe(struct platform_device *dev)
 {
-	struct serio *serio;
+	ct82c710_port = kzalloc(sizeof(struct serio), GFP_KERNEL);
+	if (!ct82c710_port)
+		return -ENOMEM;
 
-	serio = kmalloc(sizeof(struct serio), GFP_KERNEL);
-	if (serio) {
-		memset(serio, 0, sizeof(struct serio));
-		serio->id.type = SERIO_8042;
-		serio->open = ct82c710_open;
-		serio->close = ct82c710_close;
-		serio->write = ct82c710_write;
-		serio->dev.parent = &ct82c710_device->dev;
-		strlcpy(serio->name, "C&T 82c710 mouse port", sizeof(serio->name));
-		snprintf(serio->phys, sizeof(serio->phys), "isa%04lx/serio0", CT82C710_DATA);
-	}
+	ct82c710_port->id.type = SERIO_8042;
+	ct82c710_port->dev.parent = &dev->dev;
+	ct82c710_port->open = ct82c710_open;
+	ct82c710_port->close = ct82c710_close;
+	ct82c710_port->write = ct82c710_write;
+	strlcpy(ct82c710_port->name, "C&T 82c710 mouse port",
+		sizeof(ct82c710_port->name));
+	snprintf(ct82c710_port->phys, sizeof(ct82c710_port->phys),
+		 "isa%04lx/serio0", CT82C710_DATA);
 
-	return serio;
+	serio_register_port(ct82c710_port);
+
+	return 0;
 }
 
-static int __init ct82c710_init(void)
+static int __devexit ct82c710_remove(struct platform_device *dev)
 {
-	if (ct82c710_probe())
-		return -ENODEV;
+	serio_unregister_port(ct82c710_port);
+
+	return 0;
+}
 
-	ct82c710_device = platform_device_register_simple("ct82c710", -1, &ct82c710_iores, 1);
-	if (IS_ERR(ct82c710_device))
-		return PTR_ERR(ct82c710_device);
+static struct platform_driver ct82c710_driver = {
+	.driver		= {
+		.name	= "ct82c710",
+		.owner	= THIS_MODULE,
+	},
+	.probe		= ct82c710_probe,
+	.remove		= __devexit_p(ct82c710_remove),
+};
 
-	if (!(ct82c710_port = ct82c710_allocate_port())) {
-		platform_device_unregister(ct82c710_device);
-		return -ENOMEM;
+
+static int __init ct82c710_init(void)
+{
+	int error;
+
+	error = ct82c710_detect();
+	if (error)
+		return error;
+
+	error = platform_driver_register(&ct82c710_driver);
+	if (error)
+		return error;
+
+	ct82c710_device = platform_device_alloc("ct82c710", -1);
+	if (!ct82c710_device) {
+		error = -ENOMEM;
+		goto err_unregister_driver;
 	}
 
+	error = platform_device_add_resources(ct82c710_device, &ct82c710_iores, 1);
+	if (error)
+		goto err_free_device;
+
+	error = platform_device_add(ct82c710_device);
+	if (error)
+		goto err_free_device;
+
 	serio_register_port(ct82c710_port);
 
 	printk(KERN_INFO "serio: C&T 82c710 mouse port at %#lx irq %d\n",
 		CT82C710_DATA, CT82C710_IRQ);
 
 	return 0;
+
+ err_free_device:
+	platform_device_put(ct82c710_device);
+ err_unregister_driver:
+	platform_driver_unregister(&ct82c710_driver);
+	return error;
 }
 
 static void __exit ct82c710_exit(void)
 {
-	serio_unregister_port(ct82c710_port);
 	platform_device_unregister(ct82c710_device);
+	platform_driver_unregister(&ct82c710_driver);
 }
 
 module_init(ct82c710_init);

