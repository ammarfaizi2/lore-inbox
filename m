Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267041AbTBLKzc>; Wed, 12 Feb 2003 05:55:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267035AbTBLKzc>; Wed, 12 Feb 2003 05:55:32 -0500
Received: from twilight.ucw.cz ([195.39.74.230]:20873 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S267041AbTBLKxn>;
	Wed, 12 Feb 2003 05:53:43 -0500
Date: Wed, 12 Feb 2003 12:03:21 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [patch] input: Support for NEC PC-9800 beeper and support for Kana Lock [6/14]
Message-ID: <20030212120321.E1563@ucw.cz>
References: <20030212115954.A1268@ucw.cz> <20030212120038.A1563@ucw.cz> <20030212120119.B1563@ucw.cz> <20030212120154.C1563@ucw.cz> <20030212120242.D1563@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030212120242.D1563@ucw.cz>; from vojtech@suse.cz on Wed, Feb 12, 2003 at 12:02:42PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/input

===================================================================

ChangeSet@1.1009, 2003-02-12 10:49:26+01:00, tomita@cinet.co.jp
  input: Support for NEC PC-9800 beeper and support for Kana Lock LED.


 drivers/char/keyboard.c     |   12 ++---
 drivers/input/misc/98spkr.c |   95 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/input/misc/Kconfig  |    4 +
 drivers/input/misc/Makefile |    1 
 include/linux/kbd_kern.h    |    5 +-
 include/linux/keyboard.h    |    1 
 6 files changed, 110 insertions(+), 8 deletions(-)

===================================================================

diff -Nru a/drivers/char/keyboard.c b/drivers/char/keyboard.c
--- a/drivers/char/keyboard.c	Wed Feb 12 11:57:03 2003
+++ b/drivers/char/keyboard.c	Wed Feb 12 11:57:03 2003
@@ -48,21 +48,21 @@
  * Exported functions/variables
  */
 
-#ifndef KBD_DEFMODE
 #define KBD_DEFMODE ((1 << VC_REPEAT) | (1 << VC_META))
-#endif
 
-#ifndef KBD_DEFLEDS
 /*
  * Some laptops take the 789uiojklm,. keys as number pad when NumLock is on.
- * This seems a good reason to start with NumLock off.
+ * This seems a good reason to start with NumLock off. On PC9800 however there
+ * is no NumLock key and everyone expects the keypad to be used for numbers.
  */
+
+#ifdef CONFIG_X86_PC9800
+#define KBD_DEFLEDS (1 << VC_NUMLOCK)
+#else
 #define KBD_DEFLEDS 0
 #endif
 
-#ifndef KBD_DEFLOCK
 #define KBD_DEFLOCK 0
-#endif
 
 void compute_shiftstate(void);
 
diff -Nru a/drivers/input/misc/98spkr.c b/drivers/input/misc/98spkr.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/drivers/input/misc/98spkr.c	Wed Feb 12 11:57:03 2003
@@ -0,0 +1,95 @@
+/*
+ *  PC-9800 Speaker beeper driver for Linux
+ *
+ *  Copyright (c) 2002 Osamu Tomita
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
+MODULE_AUTHOR("Osamu Tomita <tomita@cinet.co.jp>");
+MODULE_DESCRIPTION("PC-9800 Speaker beeper driver");
+MODULE_LICENSE("GPL");
+
+static char spkr98_name[] = "PC-9801 Speaker";
+static char spkr98_phys[] = "isa3fdb/input0";
+static struct input_dev spkr98_dev;
+
+spinlock_t i8253_beep_lock = SPIN_LOCK_UNLOCKED;
+
+static int spkr98_event(struct input_dev *dev, unsigned int type, unsigned int code, int value)
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
+		count = CLOCK_TICK_RATE / value;
+	
+	spin_lock_irqsave(&i8253_beep_lock, flags);
+
+	if (count) {
+		outb(0x76, 0x3fdf);
+		outb(0, 0x5f);
+		outb(count & 0xff, 0x3fdb);
+		outb(0, 0x5f);
+		outb((count >> 8) & 0xff, 0x3fdb);
+		/* beep on */
+		outb(6, 0x37);
+	} else {
+		/* beep off */
+		outb(7, 0x37);
+	}
+
+	spin_unlock_irqrestore(&i8253_beep_lock, flags);
+
+	return 0;
+}
+
+static int __init spkr98_init(void)
+{
+	spkr98_dev.evbit[0] = BIT(EV_SND);
+	spkr98_dev.sndbit[0] = BIT(SND_BELL) | BIT(SND_TONE);
+	spkr98_dev.event = spkr98_event;
+
+	spkr98_dev.name = spkr98_name;
+	spkr98_dev.phys = spkr98_phys;
+	spkr98_dev.id.bustype = BUS_ISA;
+	spkr98_dev.id.vendor = 0x001f;
+	spkr98_dev.id.product = 0x0001;
+	spkr98_dev.id.version = 0x0100;
+
+	input_register_device(&spkr98_dev);
+
+        printk(KERN_INFO "input: %s\n", spkr98_name);
+
+	return 0;
+}
+
+static void __exit spkr98_exit(void)
+{
+        input_unregister_device(&spkr98_dev);
+}
+
+module_init(spkr98_init);
+module_exit(spkr98_exit);
diff -Nru a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
--- a/drivers/input/misc/Kconfig	Wed Feb 12 11:57:03 2003
+++ b/drivers/input/misc/Kconfig	Wed Feb 12 11:57:03 2003
@@ -44,6 +44,10 @@
 	tristate "M68k Beeper support"
 	depends on M68K && INPUT && INPUT_MISC
 
+config INPUT_98SPKR
+	tristate "PC-9800 Speaker support"
+	depends on X86_PC9800 && INPUT && INPUT_MISC
+
 config INPUT_UINPUT
 	tristate "User level driver support"
 	depends on INPUT && INPUT_MISC
diff -Nru a/drivers/input/misc/Makefile b/drivers/input/misc/Makefile
--- a/drivers/input/misc/Makefile	Wed Feb 12 11:57:03 2003
+++ b/drivers/input/misc/Makefile	Wed Feb 12 11:57:03 2003
@@ -7,5 +7,6 @@
 obj-$(CONFIG_INPUT_SPARCSPKR)		+= sparcspkr.o
 obj-$(CONFIG_INPUT_PCSPKR)		+= pcspkr.o
 obj-$(CONFIG_INPUT_M68K_BEEP)		+= m68kspkr.o
+obj-$(CONFIG_INPUT_98SPKR)		+= 98spkr.o
 obj-$(CONFIG_INPUT_UINPUT)		+= uinput.o
 obj-$(CONFIG_INPUT_GSC)			+= gsc_ps2.o
diff -Nru a/include/linux/kbd_kern.h b/include/linux/kbd_kern.h
--- a/include/linux/kbd_kern.h	Wed Feb 12 11:57:03 2003
+++ b/include/linux/kbd_kern.h	Wed Feb 12 11:57:03 2003
@@ -43,11 +43,12 @@
 #define LED_SHOW_IOCTL 1        /* only change leds upon ioctl */
 #define LED_SHOW_MEM 2          /* `heartbeat': peek into memory */
 
-	unsigned char ledflagstate:3;	/* flags, not lights */
-	unsigned char default_ledflagstate:3;
+	unsigned char ledflagstate:4;	/* flags, not lights */
+	unsigned char default_ledflagstate:4;
 #define VC_SCROLLOCK	0	/* scroll-lock mode */
 #define VC_NUMLOCK	1	/* numeric lock mode */
 #define VC_CAPSLOCK	2	/* capslock mode */
+#define VC_KANALOCK	3	/* kanalock mode */
 
 	unsigned char kbdmode:2;	/* one 2-bit value */
 #define VC_XLATE	0	/* translate keycodes using keymap */
diff -Nru a/include/linux/keyboard.h b/include/linux/keyboard.h
--- a/include/linux/keyboard.h	Wed Feb 12 11:57:03 2003
+++ b/include/linux/keyboard.h	Wed Feb 12 11:57:03 2003
@@ -9,6 +9,7 @@
 #define KG_ALT		3
 #define KG_ALTGR	1
 #define KG_SHIFTL	4
+#define KG_KANASHIFT	4
 #define KG_SHIFTR	5
 #define KG_CTRLL	6
 #define KG_CTRLR	7
