Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932353AbVIJWeR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932353AbVIJWeR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 18:34:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932348AbVIJWeM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 18:34:12 -0400
Received: from styx.suse.cz ([82.119.242.94]:32420 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S932354AbVIJWdv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 18:33:51 -0400
Subject: [PATCH 6/26] i8042 - clean up initialization code; abort if we
In-Reply-To: <11263916513180@midnight.ucw.cz>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Sun, 11 Sep 2005 00:34:12 +0200
Message-Id: <11263916524159@midnight.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: torvalds@osdl.org, dtor_core@ameritech.net, linux-kernel@vger.kernel.org,
       vojtech@suse.cz
Content-Transfer-Encoding: 7BIT
From: Vojtech Pavlik <vojtech@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: [PATCH] Input: i8042 - clean up initialization code; abort if we
From: Dmitry Torokhov <dtor_core@ameritech.net>
Date: 1125816087 -0500
       can't create all ports.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

---

 drivers/input/serio/i8042.c |  174 ++++++++++++++++++++++++-------------------
 1 files changed, 98 insertions(+), 76 deletions(-)

0854e52d86080c1043bc8988daef2ebda4775f64
diff --git a/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.c
--- a/drivers/input/serio/i8042.c
+++ b/drivers/input/serio/i8042.c
@@ -338,10 +338,10 @@ static int i8042_open(struct serio *seri
 
 	return 0;
 
-activate_fail:
+ activate_fail:
 	free_irq(port->irq, i8042_request_irq_cookie);
 
-irq_fail:
+ irq_fail:
 	serio_unregister_port_delayed(serio);
 
 	return -1;
@@ -485,7 +485,7 @@ static irqreturn_t i8042_interrupt(int i
 		serio_interrupt(port->serio, data, dfl, regs);
 
 	ret = 1;
-out:
+ out:
 	return IRQ_RETVAL(ret);
 }
 
@@ -552,7 +552,7 @@ static int i8042_enable_mux_ports(void)
  * Enable all muxed ports.
  */
 
-	for (i = 0; i < 4; i++) {
+	for (i = 0; i < I8042_NUM_MUX_PORTS; i++) {
 		i8042_command(&param, I8042_CMD_MUX_PFX + i);
 		i8042_command(&param, I8042_CMD_AUX_ENABLE);
 	}
@@ -682,7 +682,7 @@ static int __init i8042_port_register(st
 		kfree(port->serio);
 		port->serio = NULL;
 		i8042_ctr |= port->disable;
-		return -1;
+		return -EIO;
 	}
 
 	printk(KERN_INFO "serio: i8042 %s port at %#lx,%#lx irq %d\n",
@@ -977,80 +977,83 @@ static struct device_driver i8042_driver
 	.shutdown	= i8042_shutdown,
 };
 
-static void __init i8042_create_kbd_port(void)
+static int __init i8042_create_kbd_port(void)
 {
 	struct serio *serio;
 	struct i8042_port *port = &i8042_ports[I8042_KBD_PORT_NO];
 
-	serio = kmalloc(sizeof(struct serio), GFP_KERNEL);
-	if (serio) {
-		memset(serio, 0, sizeof(struct serio));
-		serio->id.type		= i8042_direct ? SERIO_8042 : SERIO_8042_XL;
-		serio->write		= i8042_dumbkbd ? NULL : i8042_kbd_write;
-		serio->open		= i8042_open;
-		serio->close		= i8042_close;
-		serio->start		= i8042_start;
-		serio->stop		= i8042_stop;
-		serio->port_data	= port;
-		serio->dev.parent	= &i8042_platform_device->dev;
-		strlcpy(serio->name, "i8042 Kbd Port", sizeof(serio->name));
-		strlcpy(serio->phys, I8042_KBD_PHYS_DESC, sizeof(serio->phys));
+	serio = kcalloc(1, sizeof(struct serio), GFP_KERNEL);
+	if (!serio)
+		return -ENOMEM;
+
+	serio->id.type		= i8042_direct ? SERIO_8042 : SERIO_8042_XL;
+	serio->write		= i8042_dumbkbd ? NULL : i8042_kbd_write;
+	serio->open		= i8042_open;
+	serio->close		= i8042_close;
+	serio->start		= i8042_start;
+	serio->stop		= i8042_stop;
+	serio->port_data	= port;
+	serio->dev.parent	= &i8042_platform_device->dev;
+	strlcpy(serio->name, "i8042 Kbd Port", sizeof(serio->name));
+	strlcpy(serio->phys, I8042_KBD_PHYS_DESC, sizeof(serio->phys));
 
-		port->serio = serio;
-		i8042_port_register(port);
-	}
+	port->serio = serio;
+
+	return i8042_port_register(port);
 }
 
-static void __init i8042_create_aux_port(void)
+static int __init i8042_create_aux_port(void)
 {
 	struct serio *serio;
 	struct i8042_port *port = &i8042_ports[I8042_AUX_PORT_NO];
 
-	serio = kmalloc(sizeof(struct serio), GFP_KERNEL);
-	if (serio) {
-		memset(serio, 0, sizeof(struct serio));
-		serio->id.type		= SERIO_8042;
-		serio->write		= i8042_aux_write;
-		serio->open		= i8042_open;
-		serio->close		= i8042_close;
-		serio->start		= i8042_start;
-		serio->stop		= i8042_stop;
-		serio->port_data	= port;
-		serio->dev.parent	= &i8042_platform_device->dev;
-		strlcpy(serio->name, "i8042 Aux Port", sizeof(serio->name));
-		strlcpy(serio->phys, I8042_AUX_PHYS_DESC, sizeof(serio->phys));
+	serio = kcalloc(1, sizeof(struct serio), GFP_KERNEL);
+	if (!serio)
+		return -ENOMEM;
+
+	serio->id.type		= SERIO_8042;
+	serio->write		= i8042_aux_write;
+	serio->open		= i8042_open;
+	serio->close		= i8042_close;
+	serio->start		= i8042_start;
+	serio->stop		= i8042_stop;
+	serio->port_data	= port;
+	serio->dev.parent	= &i8042_platform_device->dev;
+	strlcpy(serio->name, "i8042 Aux Port", sizeof(serio->name));
+	strlcpy(serio->phys, I8042_AUX_PHYS_DESC, sizeof(serio->phys));
 
-		port->serio = serio;
-		i8042_port_register(port);
-	}
+	port->serio = serio;
+
+	return i8042_port_register(port);
 }
 
-static void __init i8042_create_mux_port(int index)
+static int __init i8042_create_mux_port(int index)
 {
 	struct serio *serio;
 	struct i8042_port *port = &i8042_ports[I8042_MUX_PORT_NO + index];
 
-	serio = kmalloc(sizeof(struct serio), GFP_KERNEL);
-	if (serio) {
-		memset(serio, 0, sizeof(struct serio));
-		serio->id.type		= SERIO_8042;
-		serio->write		= i8042_aux_write;
-		serio->open		= i8042_open;
-		serio->close		= i8042_close;
-		serio->start		= i8042_start;
-		serio->stop		= i8042_stop;
-		serio->port_data	= port;
-		serio->dev.parent	= &i8042_platform_device->dev;
-		snprintf(serio->name, sizeof(serio->name), "i8042 Aux-%d Port", index);
-		snprintf(serio->phys, sizeof(serio->phys), I8042_MUX_PHYS_DESC, index + 1);
-
-		*port = i8042_ports[I8042_AUX_PORT_NO];
-		port->exists = 0;
-		snprintf(port->name, sizeof(port->name), "AUX%d", index);
-		port->mux = index;
-		port->serio = serio;
-		i8042_port_register(port);
-	}
+	serio = kcalloc(1, sizeof(struct serio), GFP_KERNEL);
+	if (!serio)
+		return -ENOMEM;
+
+	serio->id.type		= SERIO_8042;
+	serio->write		= i8042_aux_write;
+	serio->open		= i8042_open;
+	serio->close		= i8042_close;
+	serio->start		= i8042_start;
+	serio->stop		= i8042_stop;
+	serio->port_data	= port;
+	serio->dev.parent	= &i8042_platform_device->dev;
+	snprintf(serio->name, sizeof(serio->name), "i8042 Aux-%d Port", index);
+	snprintf(serio->phys, sizeof(serio->phys), I8042_MUX_PHYS_DESC, index + 1);
+
+	*port = i8042_ports[I8042_AUX_PORT_NO];
+	port->exists = 0;
+	snprintf(port->name, sizeof(port->name), "AUX%d", index);
+	port->mux = index;
+	port->serio = serio;
+
+	return i8042_port_register(port);
 }
 
 static int __init i8042_init(void)
@@ -1070,36 +1073,55 @@ static int __init i8042_init(void)
 	i8042_ports[I8042_KBD_PORT_NO].irq = I8042_KBD_IRQ;
 
 	if (i8042_controller_init()) {
-		i8042_platform_exit();
-		return -ENODEV;
+		err = -ENODEV;
+		goto err_platform_exit;
 	}
 
 	err = driver_register(&i8042_driver);
-	if (err) {
-		i8042_platform_exit();
-		return err;
-	}
+	if (err)
+		goto err_controller_cleanup;
 
 	i8042_platform_device = platform_device_register_simple("i8042", -1, NULL, 0);
 	if (IS_ERR(i8042_platform_device)) {
-		driver_unregister(&i8042_driver);
-		i8042_platform_exit();
-		return PTR_ERR(i8042_platform_device);
+		err = PTR_ERR(i8042_platform_device);
+		goto err_unregister_driver;
 	}
 
 	if (!i8042_noaux && !i8042_check_aux()) {
-		if (!i8042_nomux && !i8042_check_mux())
-			for (i = 0; i < I8042_NUM_MUX_PORTS; i++)
-				i8042_create_mux_port(i);
-		else
-			i8042_create_aux_port();
+		if (!i8042_nomux && !i8042_check_mux()) {
+			for (i = 0; i < I8042_NUM_MUX_PORTS; i++) {
+				err = i8042_create_mux_port(i);
+				if (err)
+					goto err_unregister_ports;
+			}
+		} else {
+			err = i8042_create_aux_port();
+			if (err)
+				goto err_unregister_ports;
+		}
 	}
 
-	i8042_create_kbd_port();
+	err = i8042_create_kbd_port();
+	if (err)
+		goto err_unregister_ports;
 
 	mod_timer(&i8042_timer, jiffies + I8042_POLL_PERIOD);
 
 	return 0;
+
+ err_unregister_ports:
+	for (i = 0; i < I8042_NUM_PORTS; i++)
+		if (i8042_ports[i].serio)
+			serio_unregister_port(i8042_ports[i].serio);
+	platform_device_unregister(i8042_platform_device);
+ err_unregister_driver:
+	driver_unregister(&i8042_driver);
+ err_controller_cleanup:
+	i8042_controller_cleanup();
+ err_platform_exit:
+	i8042_platform_exit();
+
+	return err;
 }
 
 static void __exit i8042_exit(void)

