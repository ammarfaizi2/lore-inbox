Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262422AbTKVROk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Nov 2003 12:14:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262446AbTKVROC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Nov 2003 12:14:02 -0500
Received: from gprs147-100.eurotel.cz ([160.218.147.100]:61824 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S262422AbTKVRNO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Nov 2003 12:13:14 -0500
Date: Sat, 22 Nov 2003 17:18:01 +0100
From: Pavel Machek <pavel@ucw.cz>
To: vojtech@ucw.cz, kernel list <linux-kernel@vger.kernel.org>
Subject: suspend/resume support for inputs
Message-ID: <20031122161801.GA293@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This is patch that actually looks okay to me. _connect is split into
hw-dependend and independent parts. Could you apply it?

							Pavel

--- clean/drivers/input/keyboard/atkbd.c	2003-10-26 13:08:37.000000000 +0100
+++ linux/drivers/input/keyboard/atkbd.c	2003-11-22 17:08:30.000000000 +0100
@@ -582,6 +582,37 @@
 	kfree(atkbd);
 }
 
+int atkbd_hwinit(struct atkbd *atkbd)
+{
+	if (atkbd->write) {
+		if (atkbd_probe(atkbd)) {
+			return -EIO;
+		}
+		
+		atkbd->set = atkbd_set_3(atkbd);
+		atkbd_enable(atkbd);
+
+	} else {
+		atkbd->set = 2;
+		atkbd->id = 0xab00;
+	}
+
+	if (atkbd->set == 4) {
+		atkbd->dev.ledbit[0] |= BIT(LED_COMPOSE) | BIT(LED_SUSPEND) | BIT(LED_SLEEP) | BIT(LED_MUTE) | BIT(LED_MISC);
+		sprintf(atkbd->name, "AT Set 2 Extended keyboard");
+	} else
+		sprintf(atkbd->name, "AT %s Set %d keyboard",
+			atkbd->translated ? "Translated" : "Raw", atkbd->set);
+	return 0;
+}
+
+static void atkbd_resume(struct serio *serio)
+{
+	struct atkbd *atkbd = serio->private;
+	if (atkbd_hwinit(atkbd))
+		printk(KERN_ERR "Ouch, keyboard no longer there after resume?\n");
+}
+
 /*
  * atkbd_connect() is called when the serio module finds and interface
  * that isn't handled yet by an appropriate device driver. We check if
@@ -641,29 +672,11 @@
 		return;
 	}
 
-	if (atkbd->write) {
-
-		if (atkbd_probe(atkbd)) {
-			serio_close(serio);
-			kfree(atkbd);
-			return;
-		}
-		
-		atkbd->set = atkbd_set_3(atkbd);
-		atkbd_enable(atkbd);
-
-	} else {
-		atkbd->set = 2;
-		atkbd->id = 0xab00;
+	if (atkbd_hwinit(atkbd)) {
+		serio_close(serio);
+		kfree(atkbd);
+		return;
 	}
-
-	if (atkbd->set == 4) {
-		atkbd->dev.ledbit[0] |= BIT(LED_COMPOSE) | BIT(LED_SUSPEND) | BIT(LED_SLEEP) | BIT(LED_MUTE) | BIT(LED_MISC);
-		sprintf(atkbd->name, "AT Set 2 Extended keyboard");
-	} else
-		sprintf(atkbd->name, "AT %s Set %d keyboard",
-			atkbd->translated ? "Translated" : "Raw", atkbd->set);
-
 	sprintf(atkbd->phys, "%s/input0", serio->phys);
 
 	if (atkbd->set == 3)
@@ -688,10 +701,11 @@
 }
 
 
-static struct serio_dev atkbd_dev = {
+struct serio_dev atkbd_dev = {
 	.interrupt =	atkbd_interrupt,
 	.connect =	atkbd_connect,
 	.disconnect =	atkbd_disconnect,
+	.resume =	atkbd_resume,
 	.cleanup =	atkbd_cleanup,
 };
 
--- clean/drivers/input/serio/i8042.c	2003-09-28 22:05:48.000000000 +0200
+++ linux/drivers/input/serio/i8042.c	2003-11-22 16:56:05.000000000 +0100
@@ -18,6 +18,7 @@
 #include <linux/reboot.h>
 #include <linux/init.h>
 #include <linux/serio.h>
+#include <linux/sysdev.h>
 
 #include <asm/io.h>
 
@@ -398,18 +399,15 @@
  * desired.
  */
 	
-static int __init i8042_controller_init(void)
+static int i8042_controller_init(void)
 {
-
 /*
  * Test the i8042. We need to know if it thinks it's working correctly
  * before doing anything else.
  */
 
 	i8042_flush();
-
 	if (i8042_reset) {
-
 		unsigned char param;
 
 		if (i8042_command(&param, I8042_CMD_CTL_TEST)) {
@@ -783,6 +781,32 @@
 	values->mux = index;
 }
 
+static int i8042_resume_port(struct serio *port)
+{
+	struct serio_dev *dev = port->dev;
+	if (dev && dev->resume)
+		dev->resume(port);
+}
+
+static int i8042_resume(struct sys_device *dev)
+{
+	if (i8042_controller_init())
+		printk(KERN_ERR "i8042: resume failed\n");
+	i8042_resume_port(&i8042_aux_port);
+	i8042_resume_port(&i8042_kbd_port);
+	return 0;
+}
+
+static struct sysdev_class kbc_sysclass = {
+	set_kset_name("i8042"),
+	.resume = i8042_resume,
+};
+
+static struct sys_device device_i8042 = {
+	.id	= 0,
+	.cls	= &kbc_sysclass,
+};
+
 int __init i8042_init(void)
 {
 	int i;
@@ -819,6 +843,14 @@
 
 	register_reboot_notifier(&i8042_notifier);
 
+	{
+		int error = sysdev_class_register(&kbc_sysclass);
+		if (!error)
+			error = sys_device_register(&device_i8042);
+		if (error)
+			printk(KERN_CRIT "Unable to register i8042 to driver model\n");
+	}
+
 	return 0;
 }
 

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]








