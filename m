Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317371AbSHYNWX>; Sun, 25 Aug 2002 09:22:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317373AbSHYNWX>; Sun, 25 Aug 2002 09:22:23 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:18592 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S317371AbSHYNWD>;
	Sun, 25 Aug 2002 09:22:03 -0400
Date: Sun, 25 Aug 2002 15:25:57 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [patch] (re)implement setkeycode/getkeycode/kd_mksound/kbd_setrate via the input core
Message-ID: <20020825152557.A26662@ucw.cz>
References: <20020820153813.A13034@ucw.cz> <20020821191034.A6014@ucw.cz> <20020821191227.B6014@ucw.cz> <20020821223222.A19016@ucw.cz> <20020822110918.A25229@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020822110918.A25229@ucw.cz>; from vojtech@suse.cz on Thu, Aug 22, 2002 at 11:09:18AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.
'bk pull bk://linux-input.bkbits.net/linux-input' should work as well.

===================================================================

ChangeSet@1.514, 2002-08-25 15:21:22+02:00, vojtech@suse.cz
  This (re)implements getkeycode/setkeycode, kbd_rate and kd_mksound
  as functions interfacing to the input core. PC-Speaker handling is
  moved to a separate file. Uinput is moved to a input/misc directory.


===================================================================

 b/drivers/char/keyboard.c            |  126 ++++++++++-
 b/drivers/char/vt.c                  |   72 ------
 b/drivers/input/Config.help          |    9 
 b/drivers/input/Config.in            |    2 
 b/drivers/input/Makefile             |    2 
 b/drivers/input/input.c              |    5 
 b/drivers/input/keyboard/amikbd.c    |    2 
 b/drivers/input/keyboard/atkbd.c     |    2 
 b/drivers/input/keyboard/newtonkbd.c |    2 
 b/drivers/input/keyboard/sunkbd.c    |    3 
 b/drivers/input/keyboard/xtkbd.c     |    2 
 b/drivers/input/misc/Config.help     |   28 ++
 b/drivers/input/misc/Config.in       |    8 
 b/drivers/input/misc/Makefile        |   12 +
 b/drivers/input/misc/pcspkr.c        |   94 ++++++++
 b/drivers/input/misc/uinput.c        |  385 +++++++++++++++++++++++++++++++++++
 b/include/linux/input.h              |    1 
 b/include/linux/vt_kern.h            |    4 
 drivers/input/uinput.c               |  385 -----------------------------------
 19 files changed, 655 insertions(+), 489 deletions(-)

===================================================================

diff -Nru a/drivers/char/keyboard.c b/drivers/char/keyboard.c
--- a/drivers/char/keyboard.c	Sun Aug 25 15:21:40 2002
+++ b/drivers/char/keyboard.c	Sun Aug 25 15:21:40 2002
@@ -80,7 +80,7 @@
 static fn_handler_fn *fn_handler[] = { FN_HANDLERS };
 
 /*
- * Variables/functions exported for vt_ioctl.c
+ * Variables exported for vt_ioctl.c
  */
 
 /* maximum values each key_handler can handle */
@@ -98,21 +98,7 @@
 int spawnpid, spawnsig;
 
 /*
- * Translation of scancodes to keycodes.
- */
-
-int getkeycode(unsigned int scancode)
-{
-	return 0; /* FIXME */
-}
-
-int setkeycode(unsigned int scancode, unsigned int keycode)
-{
-	return 0; /* FIXME */
-}
-
-/*
- * Variables/function exported for vt.c
+ * Variables exported for vt.c
  */
 
 int shift_state = 0;
@@ -137,6 +123,114 @@
 	unsigned int mask;
 	unsigned char valid:1;
 } ledptrs[3];
+
+/*
+ * Translation of scancodes to keycodes. We set them on only the first attached
+ * keyboard - for per-keyboard setting, /dev/input/event is more useful.
+ */
+int getkeycode(unsigned int scancode)
+{
+	struct input_handle *handle;
+	unsigned int keycode;
+
+	for (handle = kbd_handler.handle; handle; handle = handle->hnext) 
+		if (handle->dev->keycodesize) break;
+
+	if (!handle->dev->keycodesize)
+		return -ENODEV;
+
+	switch (handle->dev->keycodesize) {
+		case 1: keycode = *(u8*)(handle->dev->keycode + scancode); break;
+		case 2: keycode = *(u16*)(handle->dev->keycode + scancode * 2); break;
+		case 4: keycode = *(u32*)(handle->dev->keycode + scancode * 4); break;
+		default: return -EINVAL;
+	}
+
+	return keycode;
+}
+
+int setkeycode(unsigned int scancode, unsigned int keycode)
+{
+	struct input_handle *handle;
+
+	for (handle = kbd_handler.handle; handle; handle = handle->hnext) 
+		if (handle->dev->keycodesize) break;
+
+	if (!handle->dev->keycodesize)
+		return -ENODEV;
+
+	switch (handle->dev->keycodesize) {
+		case 1: *(u8*)(handle->dev->keycode + scancode) = keycode; break;
+		case 2: *(u16*)(handle->dev->keycode + scancode * 2) = keycode; break;
+		case 4: *(u32*)(handle->dev->keycode + scancode * 4) = keycode; break;
+	}
+	
+	return 0;
+}
+
+/*
+ * Making beeps and bells. 
+ */
+static void kd_nosound(unsigned long ignored)
+{
+	struct input_handle *handle;
+
+	for (handle = kbd_handler.handle; handle; handle = handle->hnext)
+		if (test_bit(EV_SND, handle->dev->evbit)) {
+			if (test_bit(SND_TONE, handle->dev->sndbit))
+				input_event(handle->dev, EV_SND, SND_TONE, 0);
+			if (test_bit(SND_BELL, handle->dev->sndbit))
+				input_event(handle->dev, EV_SND, SND_BELL, 0);
+		}
+}
+
+static struct timer_list kd_mksound_timer = { function: kd_nosound };
+
+void kd_mksound(unsigned int hz, unsigned int ticks)
+{
+	struct input_handle *handle;
+
+	del_timer(&kd_mksound_timer);
+
+	if (hz) {
+		for (handle = kbd_handler.handle; handle; handle = handle->hnext)
+			if (test_bit(EV_SND, handle->dev->evbit)) {
+				if (test_bit(SND_TONE, handle->dev->sndbit)) {
+					input_event(handle->dev, EV_SND, SND_TONE, hz);
+					break;
+				}
+				if (test_bit(SND_BELL, handle->dev->sndbit)) {
+					input_event(handle->dev, EV_SND, SND_BELL, 1);
+					break;
+				}
+			}
+		if (ticks)
+			mod_timer(&kd_mksound_timer, jiffies + ticks);
+	} else
+		kd_nosound(0);
+}
+
+/*
+ * Setting the keyboard rate.
+ */
+int kbd_rate(struct kbd_repeat *rep)
+{
+	struct input_handle *handle;
+
+	if (rep->rate < 0 || rep->delay < 0)
+		return -EINVAL;
+
+	for (handle = kbd_handler.handle; handle; handle = handle->hnext)
+		if (test_bit(EV_REP, handle->dev->evbit)) {
+			if (rep->rate > HZ) rep->rate = HZ;
+			handle->dev->rep[REP_PERIOD] = rep->rate ? (HZ / rep->rate) : 0;
+			handle->dev->rep[REP_DELAY] = rep->delay * HZ / 1000;
+			if (handle->dev->rep[REP_DELAY] < handle->dev->rep[REP_PERIOD])
+				handle->dev->rep[REP_DELAY] = handle->dev->rep[REP_PERIOD];
+		}
+	
+	return 0;
+}
 
 /*
  * Helper Functions.
diff -Nru a/drivers/char/vt.c b/drivers/char/vt.c
--- a/drivers/char/vt.c	Sun Aug 25 15:21:40 2002
+++ b/drivers/char/vt.c	Sun Aug 25 15:21:40 2002
@@ -75,78 +75,6 @@
 #define GPLAST 0x3df
 #define GPNUM (GPLAST - GPFIRST + 1)
 
-/*
- * Generates sound of some frequency for some number of clock ticks
- *
- * If freq is 0, will turn off sound, else will turn it on for that time.
- * If msec is 0, will return immediately, else will sleep for msec time, then
- * turn sound off.
- *
- * We also return immediately, which is what was implied within the X
- * comments - KDMKTONE doesn't put the process to sleep.
- */
-
-#if defined(__i386__) || defined(__alpha__) || defined(__powerpc__) \
-    || (defined(__mips__) && defined(CONFIG_ISA)) \
-    || (defined(__arm__) && defined(CONFIG_HOST_FOOTBRIDGE)) \
-    || defined(__x86_64__)
-
-static void
-kd_nosound(unsigned long ignored)
-{
-	/* disable counter 2 */
-	outb(inb_p(0x61)&0xFC, 0x61);
-	return;
-}
-
-void
-_kd_mksound(unsigned int hz, unsigned int ticks)
-{
-	static struct timer_list sound_timer = { function: kd_nosound };
-	unsigned int count = 0;
-	unsigned long flags;
-
-	if (hz > 20 && hz < 32767)
-		count = 1193180 / hz;
-	
-	local_irq_save(flags); // FIXME: is this safe?
-	del_timer(&sound_timer);
-	if (count) {
-		/* enable counter 2 */
-		outb_p(inb_p(0x61)|3, 0x61);
-		/* set command for counter 2, 2 byte write */
-		outb_p(0xB6, 0x43);
-		/* select desired HZ */
-		outb_p(count & 0xff, 0x42);
-		outb((count >> 8) & 0xff, 0x42);
-
-		if (ticks) {
-			sound_timer.expires = jiffies+ticks;
-			add_timer(&sound_timer);
-		}
-	} else
-		kd_nosound(0);
-	local_irq_restore(flags);
-	return;
-}
-
-#else
-
-void
-_kd_mksound(unsigned int hz, unsigned int ticks)
-{
-}
-
-#endif
-
-int _kbd_rate(struct kbd_repeat *rep)
-{
-	return -EINVAL;
-}
-
-void (*kd_mksound)(unsigned int hz, unsigned int ticks) = _kd_mksound;
-int (*kbd_rate)(struct kbd_repeat *rep) = _kbd_rate;
-
 #define i (tmp.kb_index)
 #define s (tmp.kb_table)
 #define v (tmp.kb_value)
diff -Nru a/drivers/input/Config.help b/drivers/input/Config.help
--- a/drivers/input/Config.help	Sun Aug 25 15:21:40 2002
+++ b/drivers/input/Config.help	Sun Aug 25 15:21:40 2002
@@ -88,12 +88,3 @@
   inserted in and removed from the running kernel whenever you want).
   The module will be called joydev.o. If you want to compile it as a
   module, say M here and read <file:Documentation/modules.txt>.
-
-CONFIG_INPUT_UINPUT
-  Say Y here if you want to support user level drivers for input
-  subsystem accessible under char device 10:223 - /dev/input/uinput.
-
-  This driver is also available as a module ( = code which can be
-  inserted in and removed from the running kernel whenever you want).
-  The module will be called uinput.o.  If you want to compile it as a
-  module, say M here and read <file:Documentation/modules.txt>.	    
diff -Nru a/drivers/input/Config.in b/drivers/input/Config.in
--- a/drivers/input/Config.in	Sun Aug 25 15:21:40 2002
+++ b/drivers/input/Config.in	Sun Aug 25 15:21:40 2002
@@ -22,7 +22,6 @@
 fi
 dep_tristate '  Event interface' CONFIG_INPUT_EVDEV $CONFIG_INPUT
 dep_tristate '  Event debugging' CONFIG_INPUT_EVBUG $CONFIG_INPUT
-dep_tristate '  User level driver support' CONFIG_INPUT_UINPUT $CONFIG_INPUT $CONFIG_EXPERIMENTAL
 
 comment 'Input I/O drivers'
 source drivers/input/gameport/Config.in
@@ -34,6 +33,7 @@
    source drivers/input/mouse/Config.in
    source drivers/input/joystick/Config.in
    source drivers/input/touchscreen/Config.in
+   source drivers/input/misc/Config.in
 fi
 
 endmenu
diff -Nru a/drivers/input/Makefile b/drivers/input/Makefile
--- a/drivers/input/Makefile	Sun Aug 25 15:21:40 2002
+++ b/drivers/input/Makefile	Sun Aug 25 15:21:40 2002
@@ -15,12 +15,12 @@
 obj-$(CONFIG_INPUT_TSDEV)	+= tsdev.o
 obj-$(CONFIG_INPUT_POWER)	+= power.o
 obj-$(CONFIG_INPUT_EVBUG)	+= evbug.o
-obj-$(CONFIG_INPUT_UINPUT)	+= uinput.o
 
 obj-$(CONFIG_INPUT_KEYBOARD)	+= keyboard/
 obj-$(CONFIG_INPUT_MOUSE)	+= mouse/
 obj-$(CONFIG_INPUT_JOYSTICK)	+= joystick/
 obj-$(CONFIG_INPUT_TOUCHSCREEN)	+= touchscreen/
+obj-$(CONFIG_INPUT_MISC)	+= misc/
 
 # The global Rules.make.
 
diff -Nru a/drivers/input/input.c b/drivers/input/input.c
--- a/drivers/input/input.c	Sun Aug 25 15:21:40 2002
+++ b/drivers/input/input.c	Sun Aug 25 15:21:40 2002
@@ -105,7 +105,7 @@
 
 			change_bit(code, dev->key);
 
-			if (test_bit(EV_REP, dev->evbit) && value) {
+			if (test_bit(EV_REP, dev->evbit) && dev->rep[REP_PERIOD] && value) {
 				dev->repeat_key = code;
 				mod_timer(&dev->timer, jiffies + dev->rep[REP_DELAY]);
 			}
@@ -165,10 +165,9 @@
 
 		case EV_SND:
 	
-			if (code > SND_MAX || !test_bit(code, dev->sndbit) || !!test_bit(code, dev->snd) == value)
+			if (code > SND_MAX || !test_bit(code, dev->sndbit))
 				return;
 
-			change_bit(code, dev->snd);
 			if (dev->event) dev->event(dev, type, code, value);	
 	
 			break;
diff -Nru a/drivers/input/keyboard/amikbd.c b/drivers/input/keyboard/amikbd.c
--- a/drivers/input/keyboard/amikbd.c	Sun Aug 25 15:21:40 2002
+++ b/drivers/input/keyboard/amikbd.c	Sun Aug 25 15:21:40 2002
@@ -114,6 +114,8 @@
 
 	amikbd_dev.evbit[0] = BIT(EV_KEY) | BIT(EV_REP);
 	amikbd_dev.keycode = amikbd_keycode;
+	amikbd_dev.keycodesize = sizeof(unsigned char);
+	amikbd_dev.keycodemax = ARRAY_SIZE(amikbd_keycode);
 
 	for (i = 0; i < 0x78; i++)
 		if (amikbd_keycode[i])
diff -Nru a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
--- a/drivers/input/keyboard/atkbd.c	Sun Aug 25 15:21:40 2002
+++ b/drivers/input/keyboard/atkbd.c	Sun Aug 25 15:21:40 2002
@@ -470,6 +470,8 @@
 	atkbd->serio = serio;
 
 	atkbd->dev.keycode = atkbd->keycode;
+	atkbd->dev.keycodesize = sizeof(unsigned char);
+	atkbd->dev.keycodemax = ARRAY_SIZE(atkbd_set2_keycode);
 	atkbd->dev.event = atkbd_event;
 	atkbd->dev.private = atkbd;
 
diff -Nru a/drivers/input/keyboard/newtonkbd.c b/drivers/input/keyboard/newtonkbd.c
--- a/drivers/input/keyboard/newtonkbd.c	Sun Aug 25 15:21:40 2002
+++ b/drivers/input/keyboard/newtonkbd.c	Sun Aug 25 15:21:40 2002
@@ -94,6 +94,8 @@
 	nkbd->serio = serio;
 
 	nkbd->dev.keycode = nkbd->keycode;
+	nkbd->dev.keycodesize = sizeof(unsigned char);
+	nkbd->dev.keycodemax = ARRAY_SIZE(nkbd_keycode);
 	nkbd->dev.private = nkbd;
 
 	serio->private = nkbd;
diff -Nru a/drivers/input/keyboard/sunkbd.c b/drivers/input/keyboard/sunkbd.c
--- a/drivers/input/keyboard/sunkbd.c	Sun Aug 25 15:21:40 2002
+++ b/drivers/input/keyboard/sunkbd.c	Sun Aug 25 15:21:40 2002
@@ -245,6 +245,9 @@
 	sunkbd->tq.data = sunkbd;
 
 	sunkbd->dev.keycode = sunkbd->keycode;
+	sunkbd->dev.keycodesize = sizeof(unsigned char);
+	sunkbd->dev.keycodemax = ARRAY_SIZE(sunkbd_keycode);
+
 	sunkbd->dev.event = sunkbd_event;
 	sunkbd->dev.private = sunkbd;
 
diff -Nru a/drivers/input/keyboard/xtkbd.c b/drivers/input/keyboard/xtkbd.c
--- a/drivers/input/keyboard/xtkbd.c	Sun Aug 25 15:21:40 2002
+++ b/drivers/input/keyboard/xtkbd.c	Sun Aug 25 15:21:40 2002
@@ -101,6 +101,8 @@
 	xtkbd->serio = serio;
 
 	xtkbd->dev.keycode = xtkbd->keycode;
+	xtkbd->dev.keycodesize = sizeof(unsigned char);
+	xtkbd->dev.keycodemax = ARRAY_SIZE(xtkbd_keycode);
 	xtkbd->dev.private = xtkbd;
 
 	serio->private = xtkbd;
diff -Nru a/drivers/input/misc/Config.help b/drivers/input/misc/Config.help
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/drivers/input/misc/Config.help	Sun Aug 25 15:21:40 2002
@@ -0,0 +1,28 @@
+CONFIG_INPUT_MISC
+
+  Say Y here, and a list of miscellaneous input drivers will be displayed.
+  Everything that didn't fit into the other categories is here. This option
+  doesn't affect the kernel.
+
+  If unsure, say Y.
+
+CONFIG_INPUT_PCSPKR
+  Say Y here if you want the standard PC Speaker to be used for
+  bells and whistles.
+
+  If unsure, say Y.
+
+  This driver is also available as a module ( = code which can be
+  inserted in and removed from the running kernel whenever you want).
+  The module will be called pcspkr.o. If you want to compile it as a
+  module, say M here and read <file:Documentation/modules.txt>.
+
+
+CONFIG_INPUT_UINPUT
+  Say Y here if you want to support user level drivers for input
+  subsystem accessible under char device 10:223 - /dev/input/uinput.
+
+  This driver is also available as a module ( = code which can be
+  inserted in and removed from the running kernel whenever you want).
+  The module will be called uinput.o.  If you want to compile it as a
+  module, say M here and read <file:Documentation/modules.txt>.	    
diff -Nru a/drivers/input/misc/Config.in b/drivers/input/misc/Config.in
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/drivers/input/misc/Config.in	Sun Aug 25 15:21:40 2002
@@ -0,0 +1,8 @@
+#
+# Input misc drivers configuration
+#
+
+bool 'Misc' CONFIG_INPUT_MISC
+
+dep_tristate '  PC Speaker support' CONFIG_INPUT_PCSPKR $CONFIG_INPUT $CONFIG_INPUT_MISC
+dep_tristate '  User level driver support' CONFIG_INPUT_UINPUT $CONFIG_INPUT $CONFIG_INPUT_MISC
diff -Nru a/drivers/input/misc/Makefile b/drivers/input/misc/Makefile
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/drivers/input/misc/Makefile	Sun Aug 25 15:21:40 2002
@@ -0,0 +1,12 @@
+#
+# Makefile for the input misc drivers.
+#
+
+# Each configuration option enables a list of files.
+
+obj-$(CONFIG_INPUT_PCSPKR)		+= pcspkr.o
+obj-$(CONFIG_INPUT_UINPUT)		+= uinput.o
+
+# The global Rules.make.
+
+include $(TOPDIR)/Rules.make
diff -Nru a/drivers/input/misc/pcspkr.c b/drivers/input/misc/pcspkr.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/drivers/input/misc/pcspkr.c	Sun Aug 25 15:21:40 2002
@@ -0,0 +1,94 @@
+/*
+ *  PC Speaker beeper driver for Linux
+ *
+ *  Copyright (c) 2002 Vojtech Pavlik
+ *  Copyright (c) 1992 Orest Zborowski
+ *
+ */
+
+/*
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/input.h>
+#include <asm/io.h>
+
+MODULE_AUTHOR("Vojtech Pavlik <vojtech@ucw.cz>");
+MODULE_DESCRIPTION("PC Speaker beeper driver");
+MODULE_LICENSE("GPL");
+
+static char *pcspkr_name = "PC Speaker";
+static char *pcspkr_phys = "isa0061/input0";
+static struct input_dev pcspkr_dev;
+
+spinlock_t i8253_beep_lock = SPIN_LOCK_UNLOCKED;
+
+static int pcspkr_event(struct input_dev *dev, unsigned int type, unsigned int code, int value)
+{
+	unsigned int count = 0;
+	unsigned long flags;
+
+	if (type != EV_SND)
+		return -1;
+
+	switch (code) {
+		case SND_BELL: if (value) value = 1000;
+		case SND_TONE: break;
+		default: return -1;
+	} 
+
+	if (value > 20 && value < 32767)
+		count = 1193182 / value;
+	
+	spin_lock_irqsave(&i8253_beep_lock, flags);
+
+	if (count) {
+		/* enable counter 2 */
+		outb_p(inb_p(0x61) | 3, 0x61);
+		/* set command for counter 2, 2 byte write */
+		outb_p(0xB6, 0x43);
+		/* select desired HZ */
+		outb_p(count & 0xff, 0x42);
+		outb((count >> 8) & 0xff, 0x42);
+	} else {
+		/* disable counter 2 */
+		outb(inb_p(0x61) & 0xFC, 0x61);
+	}
+
+	spin_unlock_irqrestore(&i8253_beep_lock, flags);
+
+	return 0;
+}
+
+static int __init pcspkr_init(void)
+{
+	pcspkr_dev.evbit[0] = BIT(EV_SND);
+	pcspkr_dev.sndbit[0] = BIT(SND_BELL) | BIT(SND_TONE);
+	pcspkr_dev.event = pcspkr_event;
+
+	pcspkr_dev.name = pcspkr_name;
+	pcspkr_dev.phys = pcspkr_phys;
+	pcspkr_dev.id.bustype = BUS_ISA;
+	pcspkr_dev.id.vendor = 0x001f;
+	pcspkr_dev.id.product = 0x0001;
+	pcspkr_dev.id.version = 0x0100;
+
+	input_register_device(&pcspkr_dev);
+
+        printk(KERN_INFO "input: %s\n", pcspkr_name);
+
+	return 0;
+}
+
+static void __exit pcspkr_exit(void)
+{
+        input_unregister_device(&pcspkr_dev);
+}
+
+module_init(pcspkr_init);
+module_exit(pcspkr_exit);
diff -Nru a/drivers/input/misc/uinput.c b/drivers/input/misc/uinput.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/drivers/input/misc/uinput.c	Sun Aug 25 15:21:40 2002
@@ -0,0 +1,385 @@
+/*
+ *  User level driver support for input subsystem
+ *
+ * Heavily based on evdev.c by Vojtech Pavlik
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ *
+ * Author: Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>
+ * 
+ * Changes/Revisions:
+ *	0.1	20/06/2002
+ *		- first public version
+ */
+#include <linux/poll.h>
+#include <linux/slab.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/input.h>
+#include <linux/smp_lock.h>
+#include <linux/fs.h>
+#include <linux/miscdevice.h>
+#include <linux/uinput.h>
+
+static int uinput_dev_open(struct input_dev *dev)
+{
+	return 0;
+}
+
+static void uinput_dev_close(struct input_dev *dev)
+{
+
+}
+
+static int uinput_dev_event(struct input_dev *dev, unsigned int type, unsigned int code, int value)
+{
+	struct uinput_device	*udev;
+
+	udev = (struct uinput_device *)dev->private;
+
+	udev->head = (udev->head + 1) & 0xF;
+	udev->buff[udev->head].type = type;
+	udev->buff[udev->head].code = code;
+	udev->buff[udev->head].value = value;
+	do_gettimeofday(&udev->buff[udev->head].time);
+
+	wake_up_interruptible(&udev->waitq);
+
+	return 0;
+}
+
+static int uinput_dev_upload_effect(struct input_dev *dev, struct ff_effect *effect)
+{
+	return 0;
+}
+
+static int uinput_dev_erase_effect(struct input_dev *dev, int effect_id)
+{
+	return 0;
+}					
+
+static int uinput_create_device(struct uinput_device *udev)
+{
+	if (!udev->dev->name) {
+		printk(KERN_DEBUG "%s: write device info first\n", UINPUT_NAME);
+		return -EINVAL;
+	}
+
+	udev->dev->open = uinput_dev_open;
+	udev->dev->close = uinput_dev_close;
+	udev->dev->event = uinput_dev_event;
+	udev->dev->upload_effect = uinput_dev_upload_effect;
+	udev->dev->erase_effect = uinput_dev_erase_effect;
+
+	init_waitqueue_head(&(udev->waitq));
+
+	input_register_device(udev->dev);
+
+	udev->state |= UIST_CREATED;
+
+	return 0;
+}
+
+static int uinput_destroy_device(struct uinput_device *udev)
+{
+	if (!(udev->state & UIST_CREATED)) {
+		printk(KERN_WARNING "%s: create the device first\n", UINPUT_NAME);
+		return -EINVAL;
+	}
+
+	input_unregister_device(udev->dev);
+
+	clear_bit(UIST_CREATED, &(udev->state));
+
+	return 0;
+}
+
+static int uinput_open(struct inode *inode, struct file *file)
+{
+	struct uinput_device	*newdev;
+	struct input_dev	*newinput;
+
+	MOD_INC_USE_COUNT;
+
+	newdev = kmalloc(sizeof(struct uinput_device), GFP_KERNEL);
+	if (!newdev)
+		goto error;
+	memset(newdev, 0, sizeof(struct uinput_device));
+
+	newinput = kmalloc(sizeof(struct input_dev), GFP_KERNEL);
+	if (!newinput)
+		goto cleanup;
+	memset(newinput, 0, sizeof(struct input_dev));
+
+	newdev->dev = newinput;
+	
+	file->private_data = newdev;
+
+	return 0;
+cleanup:
+	kfree(newdev);
+error:
+	MOD_DEC_USE_COUNT;
+	return -ENOMEM;
+}
+
+static int uinput_alloc_device(struct file *file, const char *buffer, size_t count)
+{
+	struct uinput_user_dev	user_dev;
+	struct input_dev	*dev;
+	struct uinput_device	*udev;
+	int			size,
+				retval;
+
+	retval = count;
+
+	if (copy_from_user(&user_dev, buffer, sizeof(struct uinput_user_dev))) {
+		retval = -EFAULT;
+		goto exit;
+	}
+
+	udev = (struct uinput_device *)file->private_data;
+	dev = udev->dev;
+
+	size = strnlen(user_dev.name, UINPUT_MAX_NAME_SIZE);
+	dev->name = kmalloc(size + 1, GFP_KERNEL);
+	if (!dev->name) {
+		retval = -ENOMEM;
+		goto exit;
+	}
+
+	strncpy(dev->name, user_dev.name, size);
+	dev->name[size] = '\0';
+	dev->id.bustype	= user_dev.id.bustype;
+	dev->id.vendor	= user_dev.id.vendor;
+	dev->id.product	= user_dev.id.product;
+	dev->id.version	= user_dev.id.version;
+	dev->ff_effects_max = user_dev.ff_effects_max;
+
+	size = sizeof(unsigned long) * NBITS(ABS_MAX + 1);
+	memcpy(dev->absmax, user_dev.absmax, size);
+	memcpy(dev->absmin, user_dev.absmin, size);
+	memcpy(dev->absfuzz, user_dev.absfuzz, size);
+	memcpy(dev->absflat, user_dev.absflat, size);
+
+	/* check if absmin/absmax/absfuzz/absflat are filled as
+	 * told in Documentation/input/input-programming.txt */
+	if (test_bit(EV_ABS, dev->evbit)) {
+		unsigned int cnt;
+		for (cnt = 1; cnt < ABS_MAX; cnt++)
+			if (test_bit(cnt, dev->absbit) &&
+					(!dev->absmin[cnt] ||
+					 !dev->absmax[cnt] ||
+					 !dev->absfuzz[cnt] ||
+					 !dev->absflat[cnt])) {
+				printk(KERN_DEBUG "%s: set abs fields "
+					"first\n", UINPUT_NAME);
+				retval = -EINVAL;
+				goto free_name;
+			}
+	}
+
+exit:
+	return retval;
+free_name:
+	kfree(dev->name);
+	goto exit;
+}
+
+static int uinput_write(struct file *file, const char *buffer, size_t count, loff_t *ppos)
+{
+	struct uinput_device	*udev = file->private_data;
+	
+
+	if (udev->state & UIST_CREATED) {
+		struct input_event	ev;
+
+		if (copy_from_user(&ev, buffer, sizeof(struct input_event)))
+			return -EFAULT;
+		input_event(udev->dev, ev.type, ev.code, ev.value);
+	}
+	else
+		count = uinput_alloc_device(file, buffer, count);
+
+	return count;
+}
+
+static ssize_t uinput_read(struct file *file, char *buffer, size_t count, loff_t *ppos)
+{
+	struct uinput_device	*udev;
+	int retval = 0;
+	DECLARE_WAITQUEUE(waitq, current);
+
+	udev = (struct uinput_device *)file->private_data;
+
+	if (udev->head == udev->tail) {
+		add_wait_queue(&udev->waitq, &waitq);
+		current->state = TASK_INTERRUPTIBLE;
+
+		while (udev->head == udev->tail) {
+			if (!(udev->state & UIST_CREATED)) {
+				retval = -ENODEV;
+				break;
+			}
+			if (file->f_flags & O_NONBLOCK) {
+				retval = -EAGAIN;
+				break;
+			}
+			if (signal_pending(current)) {
+				retval = -ERESTARTSYS;
+				break;
+			}
+			schedule();
+		}
+		current->state = TASK_RUNNING;
+		remove_wait_queue(&udev->waitq, &waitq);
+	}
+
+	if (retval)
+		return retval;
+
+	while (udev->head != udev->tail && retval + sizeof(struct uinput_device) <= count) {
+		if (copy_to_user(buffer + retval, &(udev->buff[udev->tail]),
+		    sizeof(struct input_event)))
+			return -EFAULT;
+		udev->tail = (udev->tail + 1)%(UINPUT_BUFFER_SIZE - 1);
+		retval += sizeof(struct input_event);
+	}
+
+	return retval;
+}
+
+static unsigned int uinput_poll(struct file *file, poll_table *wait)
+{
+        struct uinput_device *udev = file->private_data;
+
+	poll_wait(file, &udev->waitq, wait);
+
+	if (udev->head != udev->tail)
+		return POLLIN | POLLRDNORM;
+
+	return 0;			
+}
+
+static int uinput_burn_device(struct uinput_device *udev)
+{
+	if (udev->state & UIST_CREATED)
+		uinput_destroy_device(udev);
+
+	kfree(udev->dev);
+	kfree(udev);
+
+	return 0;
+}
+
+static int uinput_close(struct inode *inode, struct file *file)
+{
+	int	retval;
+
+	retval = uinput_burn_device((struct uinput_device *)file->private_data);
+	MOD_DEC_USE_COUNT;
+	return retval;
+}
+
+static int uinput_ioctl(struct inode *inode, struct file *file, unsigned int cmd, unsigned long arg)
+{
+	int			retval = 0;
+	struct uinput_device	*udev;
+
+	udev = (struct uinput_device *)file->private_data;
+
+	if (cmd >= UI_SET_EVBIT && (udev->state & UIST_CREATED))
+		return -EINVAL;
+
+	switch (cmd) {
+		case UI_DEV_CREATE:
+			retval = uinput_create_device(udev);
+
+			break;
+		case UI_DEV_DESTROY:
+			retval = uinput_destroy_device(udev);
+
+			break;
+		case UI_SET_EVBIT:
+			set_bit(arg, udev->dev->evbit);
+
+		break;
+		case UI_SET_KEYBIT:
+			set_bit(arg, udev->dev->keybit);
+
+		break;
+		case UI_SET_RELBIT:
+			set_bit(arg, udev->dev->relbit);
+
+		break;
+		case UI_SET_ABSBIT:
+			set_bit(arg, udev->dev->absbit);
+
+		break;
+		case UI_SET_MSCBIT:
+			set_bit(arg, udev->dev->mscbit);
+
+		break;
+		case UI_SET_LEDBIT:
+			set_bit(arg, udev->dev->ledbit);
+
+		break;
+		case UI_SET_SNDBIT:
+			set_bit(arg, udev->dev->sndbit);
+
+		break;
+		case UI_SET_FFBIT:
+			set_bit(arg, udev->dev->ffbit);
+
+		break;
+		default:
+			retval = -EFAULT;
+	}
+	return retval;
+}
+
+struct file_operations uinput_fops = {
+	.owner =	THIS_MODULE,
+	.open =		uinput_open,
+	.release =	uinput_close,
+	.read =		uinput_read,
+	.write =	uinput_write,
+	.poll =		uinput_poll,
+	.ioctl =	uinput_ioctl,
+};
+
+static struct miscdevice uinput_misc = {
+	.fops =		&uinput_fops,
+	.minor =	UINPUT_MINOR,
+	.name =		UINPUT_NAME,
+};
+
+static int __init uinput_init(void)
+{
+	return misc_register(&uinput_misc);
+}
+
+static void __exit uinput_exit(void)
+{
+	misc_deregister(&uinput_misc);
+}
+
+MODULE_AUTHOR("Aristeu Sergio Rozanski Filho");
+MODULE_DESCRIPTION("User level driver support for input subsystem");
+MODULE_LICENSE("GPL");
+
+module_init(uinput_init);
+module_exit(uinput_exit);
+
diff -Nru a/drivers/input/uinput.c b/drivers/input/uinput.c
--- a/drivers/input/uinput.c	Sun Aug 25 15:21:40 2002
+++ /dev/null	Wed Dec 31 16:00:00 1969
@@ -1,385 +0,0 @@
-/*
- *  User level driver support for input subsystem
- *
- * Heavily based on evdev.c by Vojtech Pavlik
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
- *
- * Author: Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>
- * 
- * Changes/Revisions:
- *	0.1	20/06/2002
- *		- first public version
- */
-#include <linux/poll.h>
-#include <linux/slab.h>
-#include <linux/module.h>
-#include <linux/init.h>
-#include <linux/input.h>
-#include <linux/smp_lock.h>
-#include <linux/fs.h>
-#include <linux/miscdevice.h>
-#include <linux/uinput.h>
-
-static int uinput_dev_open(struct input_dev *dev)
-{
-	return 0;
-}
-
-static void uinput_dev_close(struct input_dev *dev)
-{
-
-}
-
-static int uinput_dev_event(struct input_dev *dev, unsigned int type, unsigned int code, int value)
-{
-	struct uinput_device	*udev;
-
-	udev = (struct uinput_device *)dev->private;
-
-	udev->head = (udev->head + 1) & 0xF;
-	udev->buff[udev->head].type = type;
-	udev->buff[udev->head].code = code;
-	udev->buff[udev->head].value = value;
-	do_gettimeofday(&udev->buff[udev->head].time);
-
-	wake_up_interruptible(&udev->waitq);
-
-	return 0;
-}
-
-static int uinput_dev_upload_effect(struct input_dev *dev, struct ff_effect *effect)
-{
-	return 0;
-}
-
-static int uinput_dev_erase_effect(struct input_dev *dev, int effect_id)
-{
-	return 0;
-}					
-
-static int uinput_create_device(struct uinput_device *udev)
-{
-	if (!udev->dev->name) {
-		printk(KERN_DEBUG "%s: write device info first\n", UINPUT_NAME);
-		return -EINVAL;
-	}
-
-	udev->dev->open = uinput_dev_open;
-	udev->dev->close = uinput_dev_close;
-	udev->dev->event = uinput_dev_event;
-	udev->dev->upload_effect = uinput_dev_upload_effect;
-	udev->dev->erase_effect = uinput_dev_erase_effect;
-
-	init_waitqueue_head(&(udev->waitq));
-
-	input_register_device(udev->dev);
-
-	udev->state |= UIST_CREATED;
-
-	return 0;
-}
-
-static int uinput_destroy_device(struct uinput_device *udev)
-{
-	if (!(udev->state & UIST_CREATED)) {
-		printk(KERN_WARNING "%s: create the device first\n", UINPUT_NAME);
-		return -EINVAL;
-	}
-
-	input_unregister_device(udev->dev);
-
-	clear_bit(UIST_CREATED, &(udev->state));
-
-	return 0;
-}
-
-static int uinput_open(struct inode *inode, struct file *file)
-{
-	struct uinput_device	*newdev;
-	struct input_dev	*newinput;
-
-	MOD_INC_USE_COUNT;
-
-	newdev = kmalloc(sizeof(struct uinput_device), GFP_KERNEL);
-	if (!newdev)
-		goto error;
-	memset(newdev, 0, sizeof(struct uinput_device));
-
-	newinput = kmalloc(sizeof(struct input_dev), GFP_KERNEL);
-	if (!newinput)
-		goto cleanup;
-	memset(newinput, 0, sizeof(struct input_dev));
-
-	newdev->dev = newinput;
-	
-	file->private_data = newdev;
-
-	return 0;
-cleanup:
-	kfree(newdev);
-error:
-	MOD_DEC_USE_COUNT;
-	return -ENOMEM;
-}
-
-static int uinput_alloc_device(struct file *file, const char *buffer, size_t count)
-{
-	struct uinput_user_dev	user_dev;
-	struct input_dev	*dev;
-	struct uinput_device	*udev;
-	int			size,
-				retval;
-
-	retval = count;
-
-	if (copy_from_user(&user_dev, buffer, sizeof(struct uinput_user_dev))) {
-		retval = -EFAULT;
-		goto exit;
-	}
-
-	udev = (struct uinput_device *)file->private_data;
-	dev = udev->dev;
-
-	size = strnlen(user_dev.name, UINPUT_MAX_NAME_SIZE);
-	dev->name = kmalloc(size + 1, GFP_KERNEL);
-	if (!dev->name) {
-		retval = -ENOMEM;
-		goto exit;
-	}
-
-	strncpy(dev->name, user_dev.name, size);
-	dev->name[size] = '\0';
-	dev->id.bustype	= user_dev.id.bustype;
-	dev->id.vendor	= user_dev.id.vendor;
-	dev->id.product	= user_dev.id.product;
-	dev->id.version	= user_dev.id.version;
-	dev->ff_effects_max = user_dev.ff_effects_max;
-
-	size = sizeof(unsigned long) * NBITS(ABS_MAX + 1);
-	memcpy(dev->absmax, user_dev.absmax, size);
-	memcpy(dev->absmin, user_dev.absmin, size);
-	memcpy(dev->absfuzz, user_dev.absfuzz, size);
-	memcpy(dev->absflat, user_dev.absflat, size);
-
-	/* check if absmin/absmax/absfuzz/absflat are filled as
-	 * told in Documentation/input/input-programming.txt */
-	if (test_bit(EV_ABS, dev->evbit)) {
-		unsigned int cnt;
-		for (cnt = 1; cnt < ABS_MAX; cnt++)
-			if (test_bit(cnt, dev->absbit) &&
-					(!dev->absmin[cnt] ||
-					 !dev->absmax[cnt] ||
-					 !dev->absfuzz[cnt] ||
-					 !dev->absflat[cnt])) {
-				printk(KERN_DEBUG "%s: set abs fields "
-					"first\n", UINPUT_NAME);
-				retval = -EINVAL;
-				goto free_name;
-			}
-	}
-
-exit:
-	return retval;
-free_name:
-	kfree(dev->name);
-	goto exit;
-}
-
-static int uinput_write(struct file *file, const char *buffer, size_t count, loff_t *ppos)
-{
-	struct uinput_device	*udev = file->private_data;
-	
-
-	if (udev->state & UIST_CREATED) {
-		struct input_event	ev;
-
-		if (copy_from_user(&ev, buffer, sizeof(struct input_event)))
-			return -EFAULT;
-		input_event(udev->dev, ev.type, ev.code, ev.value);
-	}
-	else
-		count = uinput_alloc_device(file, buffer, count);
-
-	return count;
-}
-
-static ssize_t uinput_read(struct file *file, char *buffer, size_t count, loff_t *ppos)
-{
-	struct uinput_device	*udev;
-	int retval = 0;
-	DECLARE_WAITQUEUE(waitq, current);
-
-	udev = (struct uinput_device *)file->private_data;
-
-	if (udev->head == udev->tail) {
-		add_wait_queue(&udev->waitq, &waitq);
-		current->state = TASK_INTERRUPTIBLE;
-
-		while (udev->head == udev->tail) {
-			if (!(udev->state & UIST_CREATED)) {
-				retval = -ENODEV;
-				break;
-			}
-			if (file->f_flags & O_NONBLOCK) {
-				retval = -EAGAIN;
-				break;
-			}
-			if (signal_pending(current)) {
-				retval = -ERESTARTSYS;
-				break;
-			}
-			schedule();
-		}
-		current->state = TASK_RUNNING;
-		remove_wait_queue(&udev->waitq, &waitq);
-	}
-
-	if (retval)
-		return retval;
-
-	while (udev->head != udev->tail && retval + sizeof(struct uinput_device) <= count) {
-		if (copy_to_user(buffer + retval, &(udev->buff[udev->tail]),
-		    sizeof(struct input_event)))
-			return -EFAULT;
-		udev->tail = (udev->tail + 1)%(UINPUT_BUFFER_SIZE - 1);
-		retval += sizeof(struct input_event);
-	}
-
-	return retval;
-}
-
-static unsigned int uinput_poll(struct file *file, poll_table *wait)
-{
-        struct uinput_device *udev = file->private_data;
-
-	poll_wait(file, &udev->waitq, wait);
-
-	if (udev->head != udev->tail)
-		return POLLIN | POLLRDNORM;
-
-	return 0;			
-}
-
-static int uinput_burn_device(struct uinput_device *udev)
-{
-	if (udev->state & UIST_CREATED)
-		uinput_destroy_device(udev);
-
-	kfree(udev->dev);
-	kfree(udev);
-
-	return 0;
-}
-
-static int uinput_close(struct inode *inode, struct file *file)
-{
-	int	retval;
-
-	retval = uinput_burn_device((struct uinput_device *)file->private_data);
-	MOD_DEC_USE_COUNT;
-	return retval;
-}
-
-static int uinput_ioctl(struct inode *inode, struct file *file, unsigned int cmd, unsigned long arg)
-{
-	int			retval = 0;
-	struct uinput_device	*udev;
-
-	udev = (struct uinput_device *)file->private_data;
-
-	if (cmd >= UI_SET_EVBIT && (udev->state & UIST_CREATED))
-		return -EINVAL;
-
-	switch (cmd) {
-		case UI_DEV_CREATE:
-			retval = uinput_create_device(udev);
-
-			break;
-		case UI_DEV_DESTROY:
-			retval = uinput_destroy_device(udev);
-
-			break;
-		case UI_SET_EVBIT:
-			set_bit(arg, udev->dev->evbit);
-
-		break;
-		case UI_SET_KEYBIT:
-			set_bit(arg, udev->dev->keybit);
-
-		break;
-		case UI_SET_RELBIT:
-			set_bit(arg, udev->dev->relbit);
-
-		break;
-		case UI_SET_ABSBIT:
-			set_bit(arg, udev->dev->absbit);
-
-		break;
-		case UI_SET_MSCBIT:
-			set_bit(arg, udev->dev->mscbit);
-
-		break;
-		case UI_SET_LEDBIT:
-			set_bit(arg, udev->dev->ledbit);
-
-		break;
-		case UI_SET_SNDBIT:
-			set_bit(arg, udev->dev->sndbit);
-
-		break;
-		case UI_SET_FFBIT:
-			set_bit(arg, udev->dev->ffbit);
-
-		break;
-		default:
-			retval = -EFAULT;
-	}
-	return retval;
-}
-
-struct file_operations uinput_fops = {
-	.owner =	THIS_MODULE,
-	.open =		uinput_open,
-	.release =	uinput_close,
-	.read =		uinput_read,
-	.write =	uinput_write,
-	.poll =		uinput_poll,
-	.ioctl =	uinput_ioctl,
-};
-
-static struct miscdevice uinput_misc = {
-	.fops =		&uinput_fops,
-	.minor =	UINPUT_MINOR,
-	.name =		UINPUT_NAME,
-};
-
-static int __init uinput_init(void)
-{
-	return misc_register(&uinput_misc);
-}
-
-static void __exit uinput_exit(void)
-{
-	misc_deregister(&uinput_misc);
-}
-
-MODULE_AUTHOR("Aristeu Sergio Rozanski Filho");
-MODULE_DESCRIPTION("User level driver support for input subsystem");
-MODULE_LICENSE("GPL");
-
-module_init(uinput_init);
-module_exit(uinput_exit);
-
diff -Nru a/include/linux/input.h b/include/linux/input.h
--- a/include/linux/input.h	Sun Aug 25 15:21:40 2002
+++ b/include/linux/input.h	Sun Aug 25 15:21:40 2002
@@ -570,6 +570,7 @@
 
 #define SND_CLICK		0x00
 #define SND_BELL		0x01
+#define SND_TONE		0x02
 #define SND_MAX			0x07
 
 /*
diff -Nru a/include/linux/vt_kern.h b/include/linux/vt_kern.h
--- a/include/linux/vt_kern.h	Sun Aug 25 15:21:40 2002
+++ b/include/linux/vt_kern.h	Sun Aug 25 15:21:40 2002
@@ -32,8 +32,8 @@
 	wait_queue_head_t paste_wait;
 } *vt_cons[MAX_NR_CONSOLES];
 
-extern void (*kd_mksound)(unsigned int hz, unsigned int ticks);
-extern int (*kbd_rate)(struct kbd_repeat *rep);
+extern void kd_mksound(unsigned int hz, unsigned int ticks);
+extern int kbd_rate(struct kbd_repeat *rep);
 
 /* console.c */
 

===================================================================

This BitKeeper patch contains the following changesets:
+
## Wrapped with gzip_uu ##


begin 664 bkpatch26655
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
+VO\![J0JRSI3````
`
end
-- 
Vojtech Pavlik
SuSE Labs
