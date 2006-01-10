Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932074AbWAJHUl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932074AbWAJHUl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 02:20:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750988AbWAJHUL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 02:20:11 -0500
Received: from smtp105.sbc.mail.re2.yahoo.com ([68.142.229.100]:38272 "HELO
	smtp105.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1750990AbWAJHUH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 02:20:07 -0500
Message-Id: <20060110071650.846872000.dtor_core@ameritech.net>
References: <20060110070945.912712000.dtor_core@ameritech.net>
Date: Tue, 10 Jan 2006 02:09:49 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Vojtech Pavlik <vojtech@suse.cz>, LKML <linux-kernel@vger.kernel.org>,
       Paul Mundt <lethal@linux-sh.org>
Subject: [PATCH 4/5] Remove obsolete maple input drivers
Content-Disposition: inline; filename=maple-drivers-remove.patch
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Mundt <lethal@linux-sh.org>

Input: remove obsolete maple input drivers

These haven't worked in some time, and we've dropped support for the bus
from the SH tree until someone shows some interest in maintaining it.

Signed-off-by: Paul Mundt <lethal@linux-sh.org>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/mouse/maplemouse.c |  101 ---------------------------------------
 drivers/input/keyboard/Kconfig   |   10 ---
 drivers/input/keyboard/Makefile  |    1 
 drivers/input/mouse/Kconfig      |   10 ---
 drivers/input/mouse/Makefile     |    1 
 5 files changed, 123 deletions(-)

Index: work/drivers/input/keyboard/Kconfig
===================================================================
--- work.orig/drivers/input/keyboard/Kconfig
+++ work/drivers/input/keyboard/Kconfig
@@ -143,16 +143,6 @@ config KEYBOARD_SPITZ
 	  To compile this driver as a module, choose M here: the
 	  module will be called spitzkbd.
 
-config KEYBOARD_MAPLE
-	tristate "Maple bus keyboard"
-	depends on SH_DREAMCAST && MAPLE
-	help
-	  Say Y here if you have a DreamCast console running Linux and have
-	  a keyboard attached to its Maple bus.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called maple_keyb.
-
 config KEYBOARD_AMIGA
 	tristate "Amiga keyboard"
 	depends on AMIGA
Index: work/drivers/input/keyboard/Makefile
===================================================================
--- work.orig/drivers/input/keyboard/Makefile
+++ work/drivers/input/keyboard/Makefile
@@ -5,7 +5,6 @@
 # Each configuration option enables a list of files.
 
 obj-$(CONFIG_KEYBOARD_ATKBD)		+= atkbd.o
-obj-$(CONFIG_KEYBOARD_MAPLE)		+= maple_keyb.o
 obj-$(CONFIG_KEYBOARD_SUNKBD)		+= sunkbd.o
 obj-$(CONFIG_KEYBOARD_LKKBD)		+= lkkbd.o
 obj-$(CONFIG_KEYBOARD_XTKBD)		+= xtkbd.o
Index: work/drivers/input/mouse/Kconfig
===================================================================
--- work.orig/drivers/input/mouse/Kconfig
+++ work/drivers/input/mouse/Kconfig
@@ -86,16 +86,6 @@ config MOUSE_PC110PAD
 	  To compile this driver as a module, choose M here: the
 	  module will be called pc110pad.
 
-config MOUSE_MAPLE
-	tristate "Maple bus mouse"
-	depends on SH_DREAMCAST && MAPLE
-	help
-	  Say Y if you have a DreamCast console and a mouse attached to
-	  its Maple bus.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called maplemouse.
-
 config MOUSE_AMIGA
 	tristate "Amiga mouse"
 	depends on AMIGA
Index: work/drivers/input/mouse/Makefile
===================================================================
--- work.orig/drivers/input/mouse/Makefile
+++ work/drivers/input/mouse/Makefile
@@ -8,7 +8,6 @@ obj-$(CONFIG_MOUSE_AMIGA)	+= amimouse.o
 obj-$(CONFIG_MOUSE_RISCPC)	+= rpcmouse.o
 obj-$(CONFIG_MOUSE_INPORT)	+= inport.o
 obj-$(CONFIG_MOUSE_LOGIBM)	+= logibm.o
-obj-$(CONFIG_MOUSE_MAPLE)	+= maplemouse.o
 obj-$(CONFIG_MOUSE_PC110PAD)	+= pc110pad.o
 obj-$(CONFIG_MOUSE_PS2)		+= psmouse.o
 obj-$(CONFIG_MOUSE_SERIAL)	+= sermouse.o
Index: work/drivers/input/mouse/maplemouse.c
===================================================================
--- work.orig/drivers/input/mouse/maplemouse.c
+++ /dev/null
@@ -1,101 +0,0 @@
-/*
- *	$Id: maplemouse.c,v 1.2 2004/03/22 01:18:15 lethal Exp $
- *	SEGA Dreamcast mouse driver
- *	Based on drivers/usb/usbmouse.c
- */
-
-#include <linux/kernel.h>
-#include <linux/slab.h>
-#include <linux/input.h>
-#include <linux/module.h>
-#include <linux/init.h>
-#include <linux/timer.h>
-#include <linux/maple.h>
-
-MODULE_AUTHOR("YAEGASHI Takeshi <t@keshi.org>");
-MODULE_DESCRIPTION("SEGA Dreamcast mouse driver");
-
-static void dc_mouse_callback(struct mapleq *mq)
-{
-	int buttons, relx, rely, relz;
-	struct maple_device *mapledev = mq->dev;
-	struct input_dev *dev = mapledev->private_data;
-	unsigned char *res = mq->recvbuf;
-
-	buttons = ~res[8];
-	relx = *(unsigned short *)(res + 12) - 512;
-	rely = *(unsigned short *)(res + 14) - 512;
-	relz = *(unsigned short *)(res + 16) - 512;
-
-	input_report_key(dev, BTN_LEFT,   buttons & 4);
-	input_report_key(dev, BTN_MIDDLE, buttons & 9);
-	input_report_key(dev, BTN_RIGHT,  buttons & 2);
-	input_report_rel(dev, REL_X,      relx);
-	input_report_rel(dev, REL_Y,      rely);
-	input_report_rel(dev, REL_WHEEL,  relz);
-	input_sync(dev);
-}
-
-static int dc_mouse_connect(struct maple_device *dev)
-{
-	unsigned long data = be32_to_cpu(dev->devinfo.function_data[0]);
-	struct input_dev *input_dev;
-
-	dev->private_data = input_dev = input_allocate_device();
-	if (!input_dev)
-		return -ENOMEM;
-
-	dev->private_data = input_dev;
-
-	input_dev->evbit[0] = BIT(EV_KEY) | BIT(EV_REL);
-	input_dev->keybit[LONG(BTN_MOUSE)] = BIT(BTN_LEFT) | BIT(BTN_RIGHT) | BIT(BTN_MIDDLE);
-	input_dev->relbit[0] = BIT(REL_X) | BIT(REL_Y) | BIT(REL_WHEEL);
-
-	input_dev->name = dev->product_name;
-	input_dev->id.bustype = BUS_MAPLE;
-
-	input_register_device(input_dev);
-
-	maple_getcond_callback(dev, dc_mouse_callback, 1, MAPLE_FUNC_MOUSE);
-
-	return 0;
-}
-
-
-static void dc_mouse_disconnect(struct maple_device *dev)
-{
-	struct input_dev *input_dev = dev->private_data;
-
-	input_unregister_device(input_dev);
-}
-
-
-static struct maple_driver dc_mouse_driver = {
-	.function =	MAPLE_FUNC_MOUSE,
-	.name =		"Dreamcast mouse",
-	.connect =	dc_mouse_connect,
-	.disconnect =	dc_mouse_disconnect,
-};
-
-
-static int __init dc_mouse_init(void)
-{
-	maple_register_driver(&dc_mouse_driver);
-	return 0;
-}
-
-
-static void __exit dc_mouse_exit(void)
-{
-	maple_unregister_driver(&dc_mouse_driver);
-}
-
-
-module_init(dc_mouse_init);
-module_exit(dc_mouse_exit);
-
-/*
- * Local variables:
- * c-basic-offset: 8
- * End:
- */

