Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030559AbWAGTNG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030559AbWAGTNG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 14:13:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030558AbWAGTMp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 14:12:45 -0500
Received: from smtp113.sbc.mail.re2.yahoo.com ([68.142.229.92]:16062 "HELO
	smtp113.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1030554AbWAGTIX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 14:08:23 -0500
Message-Id: <20060107172101.389344000.dtor_core@ameritech.net>
References: <20060107171559.593824000.dtor_core@ameritech.net>
Date: Sat, 07 Jan 2006 12:16:15 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Vojtech Pavlik <vojtech@suse.cz>
Subject: [PATCH 16/24] i8042: convert to the new platform device interface
Content-Disposition: inline; filename=i8042-convert-platform-intf.patch
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Input: i8042 - convert to the new platform device interface

Do not use platform_device_register_simple() as it is going away,
implement ->probe() and ->remove() functions so manual binding and
unbinding will work with this driver.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

Index: work/drivers/input/serio/i8042.c
===================================================================
--- work.orig/drivers/input/serio/i8042.c
+++ work/drivers/input/serio/i8042.c
@@ -572,7 +572,7 @@ static int i8042_enable_mux_ports(void)
  * LCS/Telegraphics.
  */
 
-static int __init i8042_check_mux(void)
+static int __devinit i8042_check_mux(void)
 {
 	unsigned char mux_version;
 
@@ -600,7 +600,7 @@ static int __init i8042_check_mux(void)
  * the presence of an AUX interface.
  */
 
-static int __init i8042_check_aux(void)
+static int __devinit i8042_check_aux(void)
 {
 	unsigned char param;
 	static int i8042_check_aux_cookie;
@@ -678,7 +678,7 @@ static int __init i8042_check_aux(void)
  * registers it, and reports to the user.
  */
 
-static int __init i8042_port_register(struct i8042_port *port)
+static int __devinit i8042_port_register(struct i8042_port *port)
 {
 	i8042_ctr &= ~port->disable;
 
@@ -956,7 +956,6 @@ static int i8042_resume(struct platform_
 	panic_blink = i8042_panic_blink;
 
 	return 0;
-
 }
 
 /*
@@ -969,16 +968,7 @@ static void i8042_shutdown(struct platfo
 	i8042_controller_cleanup();
 }
 
-static struct platform_driver i8042_driver = {
-	.suspend	= i8042_suspend,
-	.resume		= i8042_resume,
-	.shutdown	= i8042_shutdown,
-	.driver		= {
-		.name	= "i8042",
-	},
-};
-
-static int __init i8042_create_kbd_port(void)
+static int __devinit i8042_create_kbd_port(void)
 {
 	struct serio *serio;
 	struct i8042_port *port = &i8042_ports[I8042_KBD_PORT_NO];
@@ -1003,7 +993,7 @@ static int __init i8042_create_kbd_port(
 	return i8042_port_register(port);
 }
 
-static int __init i8042_create_aux_port(void)
+static int __devinit i8042_create_aux_port(void)
 {
 	struct serio *serio;
 	struct i8042_port *port = &i8042_ports[I8042_AUX_PORT_NO];
@@ -1028,7 +1018,7 @@ static int __init i8042_create_aux_port(
 	return i8042_port_register(port);
 }
 
-static int __init i8042_create_mux_port(int index)
+static int __devinit i8042_create_mux_port(int index)
 {
 	struct serio *serio;
 	struct i8042_port *port = &i8042_ports[I8042_MUX_PORT_NO + index];
@@ -1057,37 +1047,16 @@ static int __init i8042_create_mux_port(
 	return i8042_port_register(port);
 }
 
-static int __init i8042_init(void)
+static int __devinit i8042_probe(struct platform_device *dev)
 {
 	int i, have_ports = 0;
 	int err;
 
-	dbg_init();
-
 	init_timer(&i8042_timer);
 	i8042_timer.function = i8042_timer_func;
 
-	err = i8042_platform_init();
-	if (err)
-		return err;
-
-	i8042_ports[I8042_AUX_PORT_NO].irq = I8042_AUX_IRQ;
-	i8042_ports[I8042_KBD_PORT_NO].irq = I8042_KBD_IRQ;
-
-	if (i8042_controller_init()) {
-		err = -ENODEV;
-		goto err_platform_exit;
-	}
-
-	err = platform_driver_register(&i8042_driver);
-	if (err)
-		goto err_controller_cleanup;
-
-	i8042_platform_device = platform_device_register_simple("i8042", -1, NULL, 0);
-	if (IS_ERR(i8042_platform_device)) {
-		err = PTR_ERR(i8042_platform_device);
-		goto err_unregister_driver;
-	}
+	if (i8042_controller_init())
+		return -ENODEV;
 
 	if (!i8042_noaux && !i8042_check_aux()) {
 		if (!i8042_nomux && !i8042_check_mux()) {
@@ -1113,30 +1082,23 @@ static int __init i8042_init(void)
 
 	if (!have_ports) {
 		err = -ENODEV;
-		goto err_unregister_device;
+		goto err_controller_cleanup;
 	}
 
 	mod_timer(&i8042_timer, jiffies + I8042_POLL_PERIOD);
-
 	return 0;
 
  err_unregister_ports:
 	for (i = 0; i < I8042_NUM_PORTS; i++)
 		if (i8042_ports[i].serio)
 			serio_unregister_port(i8042_ports[i].serio);
- err_unregister_device:
-	platform_device_unregister(i8042_platform_device);
- err_unregister_driver:
-	platform_driver_unregister(&i8042_driver);
  err_controller_cleanup:
 	i8042_controller_cleanup();
- err_platform_exit:
-	i8042_platform_exit();
 
 	return err;
 }
 
-static void __exit i8042_exit(void)
+static int __devexit i8042_remove(struct platform_device *dev)
 {
 	int i;
 
@@ -1148,6 +1110,62 @@ static void __exit i8042_exit(void)
 
 	del_timer_sync(&i8042_timer);
 
+	return 0;
+}
+
+static struct platform_driver i8042_driver = {
+	.driver		= {
+		.name	= "i8042",
+		.owner	= THIS_MODULE,
+	},
+	.probe		= i8042_probe,
+	.remove		= __devexit_p(i8042_remove),
+	.suspend	= i8042_suspend,
+	.resume		= i8042_resume,
+	.shutdown	= i8042_shutdown,
+};
+
+static int __init i8042_init(void)
+{
+	int err;
+
+	dbg_init();
+
+	err = i8042_platform_init();
+	if (err)
+		return err;
+
+	i8042_ports[I8042_AUX_PORT_NO].irq = I8042_AUX_IRQ;
+	i8042_ports[I8042_KBD_PORT_NO].irq = I8042_KBD_IRQ;
+
+	err = platform_driver_register(&i8042_driver);
+	if (err)
+		goto err_platform_exit;
+
+	i8042_platform_device = platform_device_alloc("i8042", -1);
+	if (!i8042_platform_device) {
+		err = -ENOMEM;
+		goto err_unregister_driver;
+	}
+
+	err = platform_device_add(i8042_platform_device);
+	if (err)
+		goto err_free_device;
+
+	return 0;
+
+ err_free_device:
+	platform_device_put(i8042_platform_device);
+ err_unregister_driver:
+	platform_driver_unregister(&i8042_driver);
+ err_platform_exit:
+	i8042_platform_exit();
+
+	return err;
+}
+
+static void __exit i8042_exit(void)
+{
 	platform_device_unregister(i8042_platform_device);
 	platform_driver_unregister(&i8042_driver);
 

