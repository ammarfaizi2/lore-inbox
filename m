Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266438AbSLOMeA>; Sun, 15 Dec 2002 07:34:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266456AbSLOMeA>; Sun, 15 Dec 2002 07:34:00 -0500
Received: from precia.cinet.co.jp ([210.166.75.133]:26753 "EHLO
	precia.cinet.co.jp") by vger.kernel.org with ESMTP
	id <S266438AbSLOMd6>; Sun, 15 Dec 2002 07:33:58 -0500
Message-ID: <3DFC7800.CBF33D16@cinet.co.jp>
Date: Sun, 15 Dec 2002 21:39:28 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
X-Mailer: Mozilla 4.8C-ja  [ja/Vine] (X11; U; Linux 2.5.50-ac1-pc98smp i686)
X-Accept-Language: ja
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCHSET] PC-9800 addtional for 2.5.50-ac1 (13/21)
References: <3DFC50E9.656B96D0@cinet.co.jp>
Content-Type: multipart/mixed;
 boundary="------------997DC6B7FEA664808308B83F"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------997DC6B7FEA664808308B83F
Content-Type: text/plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit

NEC PC-9800 subarchitecture support patch for 2.5.50-ac1 (13/21)
This patch contains PC speaker driver for PC98 and changes for 
support japanese "KANA" characters. Japanese keybord has KANA
shift key and KANA LED.

diffstat:
 drivers/char/keyboard.c     |    4 +
 drivers/input/misc/98spkr.c |   95 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/input/misc/Kconfig  |    4 +
 drivers/input/misc/Makefile |    1 
 include/linux/kbd_kern.h    |    5 +-
 include/linux/keyboard.h    |    1 
 6 files changed, 108 insertions(+), 2 deletions(-)

Regards,
Osamu Tomita
--------------997DC6B7FEA664808308B83F
Content-Type: text/plain; charset=iso-2022-jp;
 name="input.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="input.patch"

diff -urN linux/drivers/input/misc/98spkr.c linux98/drivers/input/misc/98spkr.c
--- linux/drivers/input/misc/98spkr.c	Thu Jan  1 09:00:00 1970
+++ linux98/drivers/input/misc/98spkr.c	Sat Nov 16 13:05:59 2002
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
diff -urN linux/drivers/input/misc/Kconfig linux98/drivers/input/misc/Kconfig
--- linux/drivers/input/misc/Kconfig	Mon Nov 11 12:28:11 2002
+++ linux98/drivers/input/misc/Kconfig	Sat Nov 16 13:08:21 2002
@@ -44,6 +44,10 @@
 	tristate "M68k Beeper support"
 	depends on M68K && INPUT && INPUT_MISC
 
+config INPUT_98SPKR
+	tristate "PC-9800 Speaker support"
+	depends on PC9800 && INPUT && INPUT_MISC
+
 config INPUT_UINPUT
 	tristate "User level driver support"
 	depends on INPUT && INPUT_MISC
diff -urN linux/drivers/input/misc/Makefile linux98/drivers/input/misc/Makefile
--- linux/drivers/input/misc/Makefile	Mon Nov 11 12:28:18 2002
+++ linux98/drivers/input/misc/Makefile	Sat Nov 16 13:09:03 2002
@@ -7,6 +7,7 @@
 obj-$(CONFIG_INPUT_SPARCSPKR)		+= sparcspkr.o
 obj-$(CONFIG_INPUT_PCSPKR)		+= pcspkr.o
 obj-$(CONFIG_INPUT_M68K_BEEP)		+= m68kspkr.o
+obj-$(CONFIG_INPUT_98SPKR)		+= 98spkr.o
 obj-$(CONFIG_INPUT_UINPUT)		+= uinput.o
 
 # The global Rules.make.
diff -urN linux/drivers/char/keyboard.c linux98/drivers/char/keyboard.c
--- linux/drivers/char/keyboard.c	Sat Oct 19 13:01:49 2002
+++ linux98/drivers/char/keyboard.c	Sun Oct 27 09:12:29 2002
@@ -58,7 +58,11 @@
  * Some laptops take the 789uiojklm,. keys as number pad when NumLock is on.
  * This seems a good reason to start with NumLock off.
  */
+#ifndef CONFIG_PC9800
 #define KBD_DEFLEDS 0
+#else
+#define KBD_DEFLEDS (1 << VC_NUMLOCK)
+#endif
 #endif
 
 #ifndef KBD_DEFLOCK
diff -urN linux/include/linux/kbd_kern.h linux98/include/linux/kbd_kern.h
--- linux/include/linux/kbd_kern.h	Sat Oct 19 13:02:28 2002
+++ linux98/include/linux/kbd_kern.h	Sun Oct 27 10:23:23 2002
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
diff -urN linux/include/linux/keyboard.h linux98/include/linux/keyboard.h
--- linux/include/linux/keyboard.h	Sat Oct 19 13:01:13 2002
+++ linux98/include/linux/keyboard.h	Mon Oct 21 15:59:48 2002
@@ -9,6 +9,7 @@
 #define KG_ALT		3
 #define KG_ALTGR	1
 #define KG_SHIFTL	4
+#define KG_KANASHIFT	4
 #define KG_SHIFTR	5
 #define KG_CTRLL	6
 #define KG_CTRLR	7

--------------997DC6B7FEA664808308B83F--

