Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267264AbTBLN53>; Wed, 12 Feb 2003 08:57:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267271AbTBLN53>; Wed, 12 Feb 2003 08:57:29 -0500
Received: from chii.cinet.co.jp ([61.197.228.217]:40064 "EHLO
	yuzuki.cinet.co.jp") by vger.kernel.org with ESMTP
	id <S267264AbTBLN5Q>; Wed, 12 Feb 2003 08:57:16 -0500
Date: Wed, 12 Feb 2003 23:05:53 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCHSET] PC-9800 subarch. support for 2.5.60 (21/34) input
Message-ID: <20030212140553.GV1551@yuzuki.cinet.co.jp>
References: <20030212131737.GA1551@yuzuki.cinet.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030212131737.GA1551@yuzuki.cinet.co.jp>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is patchset to support NEC PC-9800 subarchitecture
against 2.5.60 (21/34).

Beep driver and keyboard support files.
This patch is already posted by Vojetch. Thanks!

- Osamu Tomita

diff -Nru linux/drivers/input/misc/98spkr.c linux98/drivers/input/misc/98spkr.c
--- linux/drivers/input/misc/98spkr.c	1970-01-01 09:00:00.000000000 +0900
+++ linux98/drivers/input/misc/98spkr.c	2002-11-16 13:05:59.000000000 +0900
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
diff -Nru linux/drivers/input/misc/Kconfig linux98/drivers/input/misc/Kconfig
--- linux/drivers/input/misc/Kconfig	2002-11-11 12:28:11.000000000 +0900
+++ linux98/drivers/input/misc/Kconfig	2002-11-16 13:08:21.000000000 +0900
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
diff -Nru linux/drivers/input/misc/Makefile linux98/drivers/input/misc/Makefile
--- linux/drivers/input/misc/Makefile	2002-12-10 11:46:11.000000000 +0900
+++ linux98/drivers/input/misc/Makefile	2002-12-16 16:00:39.000000000 +0900
@@ -7,5 +7,6 @@
 obj-$(CONFIG_INPUT_SPARCSPKR)		+= sparcspkr.o
 obj-$(CONFIG_INPUT_PCSPKR)		+= pcspkr.o
 obj-$(CONFIG_INPUT_M68K_BEEP)		+= m68kspkr.o
+obj-$(CONFIG_INPUT_98SPKR)		+= 98spkr.o
 obj-$(CONFIG_INPUT_UINPUT)		+= uinput.o
 obj-$(CONFIG_INPUT_GSC)			+= gsc_ps2.o
diff -Nru linux/drivers/char/keyboard.c linux98/drivers/char/keyboard.c
--- linux/drivers/char/keyboard.c	2002-12-10 11:45:54.000000000 +0900
+++ linux98/drivers/char/keyboard.c	2002-12-16 16:00:39.000000000 +0900
@@ -57,7 +57,11 @@
  * Some laptops take the 789uiojklm,. keys as number pad when NumLock is on.
  * This seems a good reason to start with NumLock off.
  */
+#ifndef CONFIG_X86_PC9800
 #define KBD_DEFLEDS 0
+#else
+#define KBD_DEFLEDS (1 << VC_NUMLOCK)
+#endif
 #endif
 
 #ifndef KBD_DEFLOCK
diff -Nru linux/include/linux/kbd_kern.h linux98/include/linux/kbd_kern.h
--- linux/include/linux/kbd_kern.h	2002-10-19 13:02:28.000000000 +0900
+++ linux98/include/linux/kbd_kern.h	2002-10-27 10:23:23.000000000 +0900
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
diff -Nru linux/include/linux/keyboard.h linux98/include/linux/keyboard.h
--- linux/include/linux/keyboard.h	2002-10-19 13:01:13.000000000 +0900
+++ linux98/include/linux/keyboard.h	2002-10-21 15:59:48.000000000 +0900
@@ -9,6 +9,7 @@
 #define KG_ALT		3
 #define KG_ALTGR	1
 #define KG_SHIFTL	4
+#define KG_KANASHIFT	4
 #define KG_SHIFTR	5
 #define KG_CTRLL	6
 #define KG_CTRLR	7
