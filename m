Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932220AbWHETwU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932220AbWHETwU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Aug 2006 15:52:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932258AbWHETwU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Aug 2006 15:52:20 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:1799 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932220AbWHETwT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Aug 2006 15:52:19 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:mime-version:content-type:message-id;
        b=PDneA/GPsEbglPVN7k4xuHtGIb3olul2FetUrf9BNvu2oCapYlKKhh1/rFZI+fSDFGAAEN+onYeGn3Par/JSg5kDQ5hwxeih6IjRJZ5vZamnTH6aTGvlngYdb6cr5p2iAETHT9ggq0iOSX0E86bL/+OEq8cdRU4DavuzJp0/wmQ=
From: Marek =?iso-8859-2?q?Va=B9ut?= <marek.vasut@gmail.com>
To: dtor_core@ameritech.net, linux-kernel@vger.kernel.org
Subject: [PATCH] Stowaway 2.6.17.1
Date: Sat, 5 Aug 2006 21:52:05 +0200
User-Agent: KMail/1.9.1
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_lbP1EeC16bA9qZm"
Message-Id: <200608052152.05840.marek.vasut@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_lbP1EeC16bA9qZm
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,
this patch adds support for stowaway and stowaway compatible (eg. dicota=20
inutPDA) serial keyboards. I made it on kernel 2.6.16, but it applies clean=
ly=20
on 2.6.17.1 too. I tested it on palm zire71 and friend reported me that it=
=20
works on palm tungsten T3.

I appologize, I=B4m not subscribed to LKML.

Best regards
Marek Vasut

--Boundary-00=_lbP1EeC16bA9qZm
Content-Type: text/x-diff;
  charset="us-ascii";
  name="patch-2.6-stowaway.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="patch-2.6-stowaway.patch"

diff -Naur drivers-old/input/keyboard/Kconfig drivers/input/keyboard/Kconfig
--- drivers-old/input/keyboard/Kconfig	2006-06-30 14:50:54.000000000 +0200
+++ drivers/input/keyboard/Kconfig	2006-08-05 20:09:56.000000000 +0200
@@ -121,6 +121,17 @@
 	  To compile this driver as a module, choose M here: the
 	  module will be called newtonkbd.
 
+config KEYBOARD_STOWAWAY
+	tristate "Stowaway keyboard"
+	select SERIO
+	help
+	  Say Y here if you have a Stowaway keyboard on a serial port.
+	  Stowaway compatible keyboards like Dicota Input-PDA keyboard
+	  are also supported by this driver.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called stowaway.
+
 config KEYBOARD_CORGI
 	tristate "Corgi keyboard"
 	depends on PXA_SHARPSL
diff -Naur drivers-old/input/keyboard/Makefile drivers/input/keyboard/Makefile
--- drivers-old/input/keyboard/Makefile	2006-06-30 14:50:54.000000000 +0200
+++ drivers/input/keyboard/Makefile	2006-08-05 20:23:34.000000000 +0200
@@ -11,6 +11,7 @@
 obj-$(CONFIG_KEYBOARD_AMIGA)		+= amikbd.o
 obj-$(CONFIG_KEYBOARD_LOCOMO)		+= locomokbd.o
 obj-$(CONFIG_KEYBOARD_NEWTON)		+= newtonkbd.o
+obj-$(CONFIG_KEYBOARD_STOWAWAY)		+= stowaway.o
 obj-$(CONFIG_KEYBOARD_CORGI)		+= corgikbd.o
 obj-$(CONFIG_KEYBOARD_SPITZ)		+= spitzkbd.o
 obj-$(CONFIG_KEYBOARD_HIL)		+= hil_kbd.o
diff -Naur drivers-old/input/keyboard/stowaway.c drivers/input/keyboard/stowaway.c
--- drivers-old/input/keyboard/stowaway.c	1970-01-01 01:00:00.000000000 +0100
+++ drivers/input/keyboard/stowaway.c	2006-08-05 20:09:50.000000000 +0200
@@ -0,0 +1,188 @@
+/*
+ * Stowaway keyboard driver for Linux
+ */
+
+/*
+ *  Copyright (c) 2006 Marek Vasut
+ *
+ *  Based on Newton keyboard driver for Linux
+ *  by Justin Cormack
+ */
+
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ *
+ * Should you need to contact me, the author, you can do so either by
+ * e-mail - mail your message to <j.cormack@doc.ic.ac.uk>, or by paper mail:
+ * Justin Cormack, 68 Dartmouth Park Road, London NW5 1SN, UK.
+ */
+
+#include <linux/slab.h>
+#include <linux/module.h>
+#include <linux/input.h>
+#include <linux/init.h>
+#include <linux/serio.h>
+
+#define DRIVER_DESC	"Stowaway keyboard driver"
+
+MODULE_AUTHOR("Marek Vasut <marek.vasut@gmail.com>");
+MODULE_DESCRIPTION(DRIVER_DESC);
+MODULE_LICENSE("GPL");
+
+#define SKBD_KEY	0x7f
+#define SKBD_PRESS	0x80
+
+static unsigned char skbd_keycode[128] = {
+	KEY_1, KEY_2, KEY_3, KEY_Z, KEY_4, KEY_5, KEY_6, KEY_7,
+	0, KEY_Q, KEY_W, KEY_E, KEY_R, KEY_T, KEY_Y, KEY_GRAVE,
+	KEY_X, KEY_A, KEY_S, KEY_D, KEY_F, KEY_G, KEY_H, KEY_SPACE, 
+	KEY_CAPSLOCK, KEY_TAB, KEY_LEFTCTRL, 0, 0, 0, 0, 0,
+        0, 0, 0, KEY_LEFTALT, 0, 0, 0, 0,
+	0, 0, 0, 0, KEY_C, KEY_V, KEY_B, KEY_N,
+        KEY_MINUS, KEY_EQUAL, KEY_BACKSPACE, KEY_HOME, KEY_8, KEY_9, KEY_0, KEY_ESC,
+	KEY_LEFTBRACE, KEY_RIGHTBRACE, KEY_BACKSLASH, KEY_END, KEY_U, KEY_I, KEY_O, KEY_P,
+        KEY_APOSTROPHE, KEY_ENTER, KEY_PAGEUP,0, KEY_J, KEY_K, KEY_L, KEY_SEMICOLON,
+	KEY_SLASH, KEY_UP, KEY_PAGEDOWN, 0,KEY_M, KEY_COMMA, KEY_DOT, KEY_INSERT,
+        KEY_DELETE, KEY_LEFT, KEY_DOWN, KEY_RIGHT,  0, 0, 0,
+	KEY_LEFTSHIFT, KEY_RIGHTSHIFT, 0, 0, 0, 0, 0,
+        0, 0, 0, 0, 0, 0, 0, 0,
+	0, 0, 0, 0, 0, 0, 0, 0,
+        0, KEY_F1, KEY_F2, KEY_F3, KEY_F4, KEY_F5, KEY_F6, KEY_F7,
+	KEY_F8, KEY_F9, KEY_F10, KEY_F11, KEY_F12, 0, 0, 0
+};
+
+struct skbd {
+	unsigned char keycode[128];
+	struct input_dev *dev;
+	struct serio *serio;
+	char phys[32];
+};
+
+static irqreturn_t skbd_interrupt(struct serio *serio,
+		unsigned char data, unsigned int flags, struct pt_regs *regs)
+{
+	struct skbd *skbd = serio_get_drvdata(serio);
+	/* check if this is keypress */
+	if (data < 0x80) {
+	/* invalid scan codes are probably the init sequence, so we ignore them */
+	    if (skbd->keycode[data & SKBD_KEY]) {
+		    input_regs(skbd->dev, regs);
+		    input_report_key(skbd->dev, skbd->keycode[data & SKBD_KEY], 1);
+		    input_sync(skbd->dev);
+	    }
+	    else if (data == 0xe7) /* end of init sequence */
+		    printk(KERN_INFO "input: %s on %s\n", skbd->dev->name, serio->phys);
+	} else {
+		    input_report_key(skbd->dev, skbd->keycode[data & SKBD_KEY], 0);
+	}
+	return IRQ_HANDLED;
+
+}
+
+static int skbd_connect(struct serio *serio, struct serio_driver *drv)
+{
+	struct skbd *skbd;
+	struct input_dev *input_dev;
+	int err = -ENOMEM;
+	int i;
+
+	skbd = kzalloc(sizeof(struct skbd), GFP_KERNEL);
+	input_dev = input_allocate_device();
+	if (!skbd || !input_dev)
+		goto fail;
+
+	skbd->serio = serio;
+	skbd->dev = input_dev;
+	sprintf(skbd->phys, "%s/input0", serio->phys);
+	memcpy(skbd->keycode, skbd_keycode, sizeof(skbd->keycode));
+
+	input_dev->name = "Stowaway Keyboard";
+	input_dev->phys = skbd->phys;
+	input_dev->id.bustype = BUS_RS232;
+	input_dev->id.vendor = SERIO_STOWAWAY;
+	input_dev->id.product = 0x0001;
+	input_dev->id.version = 0x0100;
+	input_dev->cdev.dev = &serio->dev;
+	input_dev->private = skbd;
+
+	input_dev->evbit[0] = BIT(EV_KEY) | BIT(EV_REP);
+	input_dev->keycode = skbd->keycode;
+	input_dev->keycodesize = sizeof(unsigned char);
+	input_dev->keycodemax = ARRAY_SIZE(skbd_keycode);
+	for (i = 0; i < 128; i++)
+		set_bit(skbd->keycode[i], input_dev->keybit);
+	clear_bit(0, input_dev->keybit);
+
+	serio_set_drvdata(serio, skbd);
+
+	err = serio_open(serio, drv);
+	if (err)
+		goto fail;
+
+	input_register_device(skbd->dev);
+	return 0;
+
+ fail:	serio_set_drvdata(serio, NULL);
+	input_free_device(input_dev);
+	kfree(skbd);
+	return err;
+}
+
+static void skbd_disconnect(struct serio *serio)
+{
+	struct skbd *skbd = serio_get_drvdata(serio);
+
+	serio_close(serio);
+	serio_set_drvdata(serio, NULL);
+	input_unregister_device(skbd->dev);
+	kfree(skbd);
+}
+
+static struct serio_device_id skbd_serio_ids[] = {
+	{
+		.type	= SERIO_RS232,
+		.proto	= SERIO_STOWAWAY,
+		.id	= SERIO_ANY,
+		.extra	= SERIO_ANY,
+	},
+	{ 0 }
+};
+
+MODULE_DEVICE_TABLE(serio, skbd_serio_ids);
+
+static struct serio_driver skbd_drv = {
+	.driver		= {
+		.name	= "stowaway",
+	},
+	.description	= DRIVER_DESC,
+	.id_table	= skbd_serio_ids,
+	.interrupt	= skbd_interrupt,
+	.connect	= skbd_connect,
+	.disconnect	= skbd_disconnect,
+};
+
+static int __init skbd_init(void)
+{
+	serio_register_driver(&skbd_drv);
+	return 0;
+}
+
+static void __exit skbd_exit(void)
+{
+	serio_unregister_driver(&skbd_drv);
+}
+
+module_init(skbd_init);
+module_exit(skbd_exit);

--Boundary-00=_lbP1EeC16bA9qZm
Content-Type: text/plain;
  charset="us-ascii";
  name="README"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="README"

This adds stowaway and compatible serial keyboard support. Marek Vasut marek.vasut@gmail.com
--Boundary-00=_lbP1EeC16bA9qZm--
