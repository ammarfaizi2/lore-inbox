Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261383AbSJQLrM>; Thu, 17 Oct 2002 07:47:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261437AbSJQLrI>; Thu, 17 Oct 2002 07:47:08 -0400
Received: from precia.cinet.co.jp ([210.166.75.133]:4992 "EHLO
	precia.cinet.co.jp") by vger.kernel.org with ESMTP
	id <S261383AbSJQLev>; Thu, 17 Oct 2002 07:34:51 -0400
Date: Thu, 17 Oct 2002 20:40:02 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH][RFC] add support for PC-9800 architecture (11/26) input
Message-ID: <20021017204002.A1211@precia.cinet.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is part 11/26 of patchset for add support NEC PC-9800 architecture,
against 2.5.43.

Summary:
 input modules
  - add new driver for PC-9800 standard keyboard and mouse.

 input.h changes are temporally hack.
 I'll remove this hack using propery keycode.
 To do this, I need "kbd" utility that can make keymap even if keycode > 127.

diffstat:
 drivers/input/keyboard/98kbd.c   |  359 +++++++++++++++++++++++++++++++++++++++
 drivers/input/keyboard/Config.in |    4 
 drivers/input/keyboard/Makefile  |    1 
 drivers/input/misc/pcspkr.c      |   24 ++
 drivers/input/mouse/Config.in    |    7 
 drivers/input/mouse/logibm.c     |   48 +++++
 drivers/input/serio/Config.in    |    3 
 drivers/input/serio/Makefile     |    1 
 drivers/input/serio/i8042-98.c   |  346 +++++++++++++++++++++++++++++++++++++
 drivers/input/serio/i8042-98io.h |   74 ++++++++
 drivers/input/serio/i8042.h      |    2 
 include/linux/input.h            |   21 ++
 12 files changed, 890 insertions(+)

patch:
diff -urN linux/drivers/input/keyboard/Config.in linux98/drivers/input/keyboard/Config.in
--- linux/drivers/input/keyboard/Config.in	Sat Oct 12 13:22:45 2002
+++ linux98/drivers/input/keyboard/Config.in	Sun Oct 13 11:29:55 2002
@@ -9,6 +9,10 @@
 dep_tristate '  XT Keyboard support' CONFIG_KEYBOARD_XTKBD $CONFIG_INPUT $CONFIG_INPUT_KEYBOARD $CONFIG_SERIO
 dep_tristate '  Newton keyboard' CONFIG_KEYBOARD_NEWTON $CONFIG_INPUT $CONFIG_INPUT_KEYBOARD $CONFIG_SERIO
 
+if [ "$CONFIG_PC9800" = "y" ]; then
+   dep_tristate '  NEC PC-9801 keyboard support' CONFIG_KEYBOARD_98KBD $CONFIG_INPUT $CONFIG_INPUT_KEYBOARD $CONFIG_SERIO
+fi
+
 if [ "$CONFIG_SH_DREAMCAST" = "y" ]; then
    dep_tristate '  Maple bus keyboard support' CONFIG_KEYBOARD_MAPLE $CONFIG_INPUT $CONFIG_INPUT_KEYBOARD $CONFIG_MAPLE
 fi
diff -urN linux/drivers/input/keyboard/Makefile linux98/drivers/input/keyboard/Makefile
--- linux/drivers/input/keyboard/Makefile	Sat Oct 12 13:21:42 2002
+++ linux98/drivers/input/keyboard/Makefile	Sun Oct 13 11:27:15 2002
@@ -10,6 +10,7 @@
 obj-$(CONFIG_KEYBOARD_XTKBD)		+= xtkbd.o
 obj-$(CONFIG_KEYBOARD_AMIGA)		+= amikbd.o
 obj-$(CONFIG_KEYBOARD_NEWTON)		+= newtonkbd.o
+obj-$(CONFIG_KEYBOARD_98KBD)		+= 98kbd.o
 
 # The global Rules.make.
 
diff -urN linux/drivers/input/keyboard/98kbd.c linux98/drivers/input/keyboard/98kbd.c
--- linux/drivers/input/keyboard/98kbd.c	Thu Jan  1 09:00:00 1970
+++ linux98/drivers/input/keyboard/98kbd.c	Sun Oct 13 12:25:32 2002
@@ -0,0 +1,359 @@
+/*
+ * NEC PC-9801/9821 keyboard driver
+ *
+ * Copyright (c) 1999-2002 Vojtech Pavlik
+ * Modify for NEC PC-9801 by Osamu Tomita <tomita@cinet.co.jp>
+ */
+
+/*
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ */
+
+#include <linux/delay.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/interrupt.h>
+#include <linux/init.h>
+#include <linux/input.h>
+#include <linux/serio.h>
+#include <linux/workqueue.h>
+
+#include <asm/io.h>
+#include <asm/pc9800.h>
+
+MODULE_AUTHOR("Osamu Tomita <tomita@cinet.co.jp>");
+MODULE_DESCRIPTION("NEC PC-9801 keyboard driver");
+MODULE_LICENSE("GPL");
+
+/*
+ * Scancode to keycode tables. These are just the default setting, and
+ * are loadable via an userland utility.
+ */
+
+#if 0	/* Waiting for kbd utility support keycode > 127 */
+static unsigned char atkbd_set2_keycode[512] = {
+	  1,  2,  3,  4,  5,  6,  7,  8,  9, 10, 11, 12, 13, 43, 14, 15,
+	 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 30, 31, 32,
+	 33, 34, 35, 36, 37, 38, 39, 40, 84, 44, 45, 46, 47, 48, 49, 50,
+	 51, 52, 53,181, 57,184,109,104,110,111,103,105,106,108,102,107,
+	 74, 98, 71, 72, 73, 55, 75, 76, 77, 78, 79, 80, 81,117, 82,124,
+	 83,185, 87, 88, 85, 89, 90,  0,  0,  0,  0,  0,  0,  0,102,  0,
+	 99,133, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68,  0,  0,  0,  0,
+	 42, 58,190, 56, 29
+#else
+static unsigned char atkbd_set2_keycode[512] = {
+	  0,  1,  2,  3,  4,  5,  6,  7,  8,  9, 10, 11, 12, 13, 14, 15,
+	 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31,
+	 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47,
+	 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63,
+	 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79,
+	 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95,
+	 96, 97, 98, 99,100,101,102,103,104,105,106,107,108,109,110,111,
+	112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127
+};
+#endif
+
+#define ATKBD_CMD_SETEXKEY	0x1095	/* Enable/Disable Windows, Appli key */
+#define ATKBD_CMD_SETRATE	0x109c	/* Set typematic rate */
+#define ATKBD_CMD_SETLEDS	0x109d	/* Set keyboard leds */
+#define ATKBD_CMD_GETLEDS	0x119d	/* Get keyboard leds */
+#define ATKBD_CMD_GETID		0x019f
+
+#define ATKBD_RET_ACK		0xfa
+#define ATKBD_RET_NAK		0xfc	/* Command NACK, send the cmd again */
+
+#define ATKBD_KEY_UNKNOWN	  0
+#define ATKBD_KEY_BAT		251
+#define ATKBD_KEY_EMUL0		252
+#define ATKBD_KEY_EMUL1		253
+#define ATKBD_KEY_RELEASE	254
+#define ATKBD_KEY_NULL		255
+
+/*
+ * The atkbd control structure
+ */
+
+struct atkbd {
+	unsigned char keycode[512];
+	struct input_dev dev;
+	struct serio *serio;
+	char name[64];
+	char phys[32];
+	unsigned char cmdbuf[4];
+	unsigned char cmdcnt;
+	unsigned char set;
+	unsigned char oldset;
+	unsigned char release;
+	signed char ack;
+	unsigned char emul;
+	unsigned short id;
+	unsigned char write;
+};
+
+/*
+ * atkbd_interrupt(). Here takes place processing of data received from
+ * the keyboard into events.
+ */
+
+static void atkbd_interrupt(struct serio *serio, unsigned char data, unsigned int flags)
+{
+	struct atkbd *atkbd = serio->private;
+	int code = data;
+
+#ifdef ATKBD_DEBUG
+	printk(KERN_DEBUG "atkbd.c: Received %02x flags %02x\n", data, flags);
+#endif
+
+	switch (code) {
+		case ATKBD_RET_ACK:
+			atkbd->ack = 1;
+			return;
+		case ATKBD_RET_NAK:
+			atkbd->ack = -1;
+			return;
+	}
+
+	if (atkbd->cmdcnt) {
+		atkbd->cmdbuf[--atkbd->cmdcnt] = code;
+		return;
+	}
+
+	atkbd->release = (code & 0x80) ? 1 : 0;
+	code &= 0x7f;
+
+	switch (atkbd->keycode[code]) {
+		case ATKBD_KEY_NULL:
+			break;
+#if 0
+		case ATKBD_KEY_UNKNOWN:
+			printk(KERN_WARNING "98kbd.c: Unknown key (set %d, scancode %#x, on %s) %s.\n",
+				atkbd->set, code, serio->phys, atkbd->release ? "released" : "pressed");
+			break;
+#endif
+		default:
+			input_report_key(&atkbd->dev, atkbd->keycode[code], !atkbd->release);
+			input_sync(&atkbd->dev);
+	}
+		
+	atkbd->release = 0;
+}
+
+/*
+ * atkbd_sendbyte() sends a byte to the keyboard, and waits for
+ * acknowledge. It doesn't handle resends according to the keyboard
+ * protocol specs, because if these are needed, the keyboard needs
+ * replacement anyway, and they only make a mess in the protocol.
+ */
+
+static int atkbd_sendbyte(struct atkbd *atkbd, unsigned char byte)
+{
+	int timeout = 10000; /* 100 msec */
+	atkbd->ack = 0;
+
+#ifdef ATKBD_DEBUG
+	printk(KERN_DEBUG "atkbd.c: Sent: %02x\n", byte);
+#endif
+	if (serio_write(atkbd->serio, byte))
+		return -1;
+
+	while (!atkbd->ack && timeout--) udelay(10);
+
+	return -(atkbd->ack <= 0);
+}
+
+/*
+ * atkbd_command() sends a command, and its parameters to the keyboard,
+ * then waits for the response and puts it in the param array.
+ */
+
+static int atkbd_command(struct atkbd *atkbd, unsigned char *param, int command)
+{
+	int timeout = 50000; /* 500 msec */
+	int send = (command >> 12) & 0xf;
+	int receive = (command >> 8) & 0xf;
+	int i;
+
+	atkbd->cmdcnt = receive;
+	
+	if (command & 0xff)
+		if (atkbd_sendbyte(atkbd, command & 0xff))
+			return (atkbd->cmdcnt = 0) - 1;
+
+	for (i = 0; i < send; i++)
+		if (atkbd_sendbyte(atkbd, param[i]))
+			return (atkbd->cmdcnt = 0) - 1;
+
+	while (atkbd->cmdcnt && timeout--) udelay(10);
+
+	if (param)
+		for (i = 0; i < receive; i++)
+			param[i] = atkbd->cmdbuf[(receive - 1) - i];
+
+	if (atkbd->cmdcnt) 
+		return (atkbd->cmdcnt = 0) - 1;
+
+	return 0;
+}
+
+/*
+ * Event callback from the input module. Events that change the state of
+ * the hardware are processed here.
+ */
+
+static int atkbd_event(struct input_dev *dev, unsigned int type, unsigned int code, int value)
+{
+	struct atkbd *atkbd = dev->private;
+	char param[2];
+
+	if (!atkbd->write)
+		return -1;
+
+	switch (type) {
+
+		case EV_LED:
+
+			if (__PC9800SCA_TEST_BIT(0x481, 3)) {
+				/* 98note with Num Lock key */
+				/* keep Num Lock status     */
+				*param = 0x60;
+				if (atkbd_command(atkbd, param,
+							ATKBD_CMD_GETLEDS))
+					printk(KERN_DEBUG
+						"atkbd: Get keyboard LED"
+						" status Error\n");
+
+				*param &= 1;
+			} else {
+				/* desktop PC-9801 */
+				*param = 1;	/* Allways set Num Lock */
+			}
+
+			*param |= 0x70
+			       | (test_bit(LED_CAPSL,   dev->led) ? 4 : 0)
+			       | (test_bit(LED_KANA,    dev->led) ? 8 : 0);
+		        atkbd_command(atkbd, param, ATKBD_CMD_SETLEDS);
+
+			return 0;
+	}
+
+	return -1;
+}
+
+/*
+ * atkbd_cleanup() restores the keyboard state so that BIOS is happy after a
+ * reboot.
+ */
+
+static void atkbd_cleanup(struct serio *serio)
+{
+}
+
+/*
+ * atkbd_disconnect() closes and frees.
+ */
+
+static void atkbd_disconnect(struct serio *serio)
+{
+	struct atkbd *atkbd = serio->private;
+	input_unregister_device(&atkbd->dev);
+	serio_close(serio);
+	kfree(atkbd);
+}
+
+/*
+ * atkbd_connect() is called when the serio module finds and interface
+ * that isn't handled yet by an appropriate device driver. We check if
+ * there is an AT keyboard out there and if yes, we register ourselves
+ * to the input module.
+ */
+
+static void atkbd_connect(struct serio *serio, struct serio_dev *dev)
+{
+	struct atkbd *atkbd;
+	int i;
+
+	if ((serio->type & SERIO_TYPE) != SERIO_8042 &&
+		(((serio->type & SERIO_TYPE) != SERIO_RS232) || (serio->type & SERIO_PROTO) != SERIO_PS2SER))
+		        return;
+
+	if (!(atkbd = kmalloc(sizeof(struct atkbd), GFP_KERNEL)))
+		return;
+
+	memset(atkbd, 0, sizeof(struct atkbd));
+
+	if ((serio->type & SERIO_TYPE) == SERIO_8042 && serio->write)
+		atkbd->write = 1;
+
+	if (atkbd->write) {
+		atkbd->dev.evbit[0] = BIT(EV_KEY) | BIT(EV_LED) | BIT(EV_REP);
+		atkbd->dev.ledbit[0] = BIT(LED_NUML) | BIT(LED_CAPSL) | BIT(LED_SCROLLL) | BIT(LED_KANA);
+	} else  atkbd->dev.evbit[0] = BIT(EV_KEY) | BIT(EV_REP);
+
+	atkbd->serio = serio;
+
+	init_input_dev(&atkbd->dev);
+
+	atkbd->dev.keycode = atkbd->keycode;
+	atkbd->dev.keycodesize = sizeof(unsigned char);
+	atkbd->dev.keycodemax = ARRAY_SIZE(atkbd_set2_keycode);
+	atkbd->dev.event = atkbd_event;
+	atkbd->dev.private = atkbd;
+
+	serio->private = atkbd;
+
+	if (serio_open(serio, dev)) {
+		kfree(atkbd);
+		return;
+	}
+
+	atkbd->set = 2;
+	atkbd->id = 0x9800;
+	sprintf(atkbd->name, "NEC PC-9801 keyboard");
+
+	sprintf(atkbd->phys, "%s/input0", serio->phys);
+
+	memcpy(atkbd->keycode, atkbd_set2_keycode, sizeof(atkbd->keycode));
+
+	atkbd->dev.name = atkbd->name;
+	atkbd->dev.phys = atkbd->phys;
+	atkbd->dev.id.bustype = BUS_I8042;
+	atkbd->dev.id.vendor = 0x0001;
+	atkbd->dev.id.product = atkbd->set;
+	atkbd->dev.id.version = atkbd->id;
+
+	for (i = 0; i < 512; i++)
+#if 0
+		if (atkbd->keycode[i] && atkbd->keycode[i] <= 250)
+#else
+		if (atkbd->keycode[i] <= 250)
+#endif
+			set_bit(atkbd->keycode[i], atkbd->dev.keybit);
+
+	input_register_device(&atkbd->dev);
+
+	printk(KERN_INFO "input: %s on %s\n", atkbd->name, serio->phys);
+}
+
+
+static struct serio_dev atkbd_dev = {
+	.interrupt =	atkbd_interrupt,
+	.connect =	atkbd_connect,
+	.disconnect =	atkbd_disconnect,
+	.cleanup =	atkbd_cleanup,
+};
+
+int __init pc98kbd_init(void)
+{
+	serio_register_device(&atkbd_dev);
+	return 0;
+}
+
+void __exit pc98kbd_exit(void)
+{
+	serio_unregister_device(&atkbd_dev);
+}
+
+module_init(pc98kbd_init);
+module_exit(pc98kbd_exit);
diff -urN linux/drivers/input/misc/pcspkr.c linux98/drivers/input/misc/pcspkr.c
--- linux/drivers/input/misc/pcspkr.c	Mon Sep 16 11:18:31 2002
+++ linux98/drivers/input/misc/pcspkr.c	Mon Sep 16 16:04:05 2002
@@ -12,6 +12,7 @@
  * the Free Software Foundation
  */
 
+#include <linux/config.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/init.h>
@@ -23,7 +24,11 @@
 MODULE_LICENSE("GPL");
 
 static char pcspkr_name[] = "PC Speaker";
+#ifndef CONFIG_PC9800
 static char pcspkr_phys[] = "isa0061/input0";
+#else
+static char pcspkr_phys[] = "isa3fdb/input0";
+#endif
 static struct input_dev pcspkr_dev;
 
 spinlock_t i8253_beep_lock = SPIN_LOCK_UNLOCKED;
@@ -43,11 +48,16 @@
 	} 
 
 	if (value > 20 && value < 32767)
+#ifndef CONFIG_PC9800
 		count = 1193182 / value;
+#else
+		count = CLOCK_TICK_RATE / value;
+#endif
 	
 	spin_lock_irqsave(&i8253_beep_lock, flags);
 
 	if (count) {
+#ifndef CONFIG_PC9800
 		/* enable counter 2 */
 		outb_p(inb_p(0x61) | 3, 0x61);
 		/* set command for counter 2, 2 byte write */
@@ -55,9 +65,23 @@
 		/* select desired HZ */
 		outb_p(count & 0xff, 0x42);
 		outb((count >> 8) & 0xff, 0x42);
+#else /* CONFIG_PC9800 */
+		outb(0x76, 0x3fdf);
+		outb(0, 0x5f);
+		outb(count & 0xff, 0x3fdb);
+		outb(0, 0x5f);
+		outb((count >> 8) & 0xff, 0x3fdb);
+		/* beep on */
+		outb(6, 0x37);
+#endif /* !CONFIG_PC9800 */
 	} else {
 		/* disable counter 2 */
+#ifndef CONFIG_PC9800
 		outb(inb_p(0x61) & 0xFC, 0x61);
+#else
+		/* beep off */
+		outb(7, 0x37);
+#endif
 	}
 
 	spin_unlock_irqrestore(&i8253_beep_lock, flags);
diff -urN linux/drivers/input/mouse/Config.in linux98/drivers/input/mouse/Config.in
--- linux/drivers/input/mouse/Config.in	Wed Jul 17 08:49:29 2002
+++ linux98/drivers/input/mouse/Config.in	Fri Jul 19 14:52:11 2002
@@ -7,6 +7,12 @@
 dep_tristate '  PS/2 mouse' CONFIG_MOUSE_PS2 $CONFIG_INPUT $CONFIG_INPUT_MOUSE $CONFIG_SERIO
 dep_tristate '  Serial mouse' CONFIG_MOUSE_SERIAL $CONFIG_INPUT $CONFIG_INPUT_MOUSE $CONFIG_SERIO
 
+if [ "$CONFIG_PC9800" = "y" ]; then
+   dep_tristate '  NEC PC-9801 busmouse' CONFIG_MOUSE_LOGIBM $CONFIG_INPUT $CONFIG_INPUT_MOUSE $CONFIG_ISA
+   if [ "$CONFIG_MOUSE_LOGIBM" != "n" ]; then
+      define_bool CONFIG_LOGIBUSMOUSE_PC9800 y
+   fi
+else
 dep_tristate '  InPort/MS/ATIXL busmouse' CONFIG_MOUSE_INPORT $CONFIG_INPUT $CONFIG_INPUT_MOUSE $CONFIG_ISA
 if [ "$CONFIG_MOUSE_INPORT" != "n" ]; then
    bool '  ATI XL variant' CONFIG_MOUSE_ATIXL
@@ -22,3 +28,4 @@
 if [ "$CONFIG_ARCH_ACORN" = "y" ]; then
    dep_tristate '  Acorn RiscPC mouse' CONFIG_MOUSE_ACORN $CONFIG_INPUT $CONFIG_INPUT_MOUSE
 fi
+fi
diff -urN linux/drivers/input/mouse/logibm.c linux98/drivers/input/mouse/logibm.c
--- linux/drivers/input/mouse/logibm.c	Sat Oct 12 13:22:08 2002
+++ linux98/drivers/input/mouse/logibm.c	Sat Oct 12 17:40:15 2002
@@ -38,6 +38,7 @@
 #include <asm/io.h>
 #include <asm/irq.h>
 
+#include <linux/config.h>
 #include <linux/module.h>
 #include <linux/delay.h>
 #include <linux/ioport.h>
@@ -48,6 +49,7 @@
 MODULE_DESCRIPTION("Logitech busmouse driver");
 MODULE_LICENSE("GPL");
 
+#ifndef CONFIG_LOGIBUSMOUSE_PC9800
 #define	LOGIBM_BASE		0x23c
 #define	LOGIBM_EXTENT		4
 
@@ -55,6 +57,15 @@
 #define	LOGIBM_SIGNATURE_PORT	LOGIBM_BASE + 1
 #define	LOGIBM_CONTROL_PORT	LOGIBM_BASE + 2
 #define	LOGIBM_CONFIG_PORT	LOGIBM_BASE + 3
+#else /* CONFIG_LOGIBUSMOUSE_PC9800 */
+#define	LOGIBM_BASE		0x7fd9
+#define	LOGIBM_DATA_PORT	LOGIBM_BASE + 0
+/*	LOGIBM_SIGNATURE_PORT	does not exist */
+#define	LOGIBM_CONTROL_PORT	LOGIBM_BASE + 4
+/*	LOGIBM_INTERRUPT_PORT	does not exist */
+#define	LOGIBM_CONFIG_PORT	LOGIBM_BASE + 6
+#define	LOGIBM_EXTENT		(-7)
+#endif /* !CONFIG_LOGIBUSMOUSE_PC9800 */
 
 #define	LOGIBM_ENABLE_IRQ	0x00
 #define	LOGIBM_DISABLE_IRQ	0x10
@@ -63,11 +74,24 @@
 #define	LOGIBM_READ_Y_LOW	0xc0
 #define	LOGIBM_READ_Y_HIGH	0xe0
 
+#ifndef CONFIG_LOGIBUSMOUSE_PC9800
 #define LOGIBM_DEFAULT_MODE	0x90
 #define LOGIBM_CONFIG_BYTE	0x91
 #define LOGIBM_SIGNATURE_BYTE	0xa5
+#else /* CONFIG_LOGIBUSMOUSE_PC9800 */
+#define LOGIBM_DEFAULT_MODE	0x93
+/*	LOGIBM_CONFIG_BYTE	is not used */
+/*	LOGIBM_SIGNATURE_BYTE	is not used */
+
+#define LOGIBM_TIMER_PORT	0xbfdb
+#define LOGIBM_DEFAULT_TIMER_VAL	0x00
+#endif /* !CONFIG_LOGIBUSMOUSE_PC9800 */
 
+#ifndef CONFIG_LOGIBUSMOUSE_PC9800
 #define LOGIBM_IRQ		5
+#else
+#define LOGIBM_IRQ		13
+#endif
 
 MODULE_PARM(logibm_irq, "i");
 
@@ -104,7 +128,11 @@
 	.open	= logibm_open,
 	.close	= logibm_close,
 	.name	= "Logitech bus mouse",
+#ifndef CONFIG_LOGIBUSMOUSE_PC9800
 	.phys	= "isa023c/input0",
+#else
+	.phys	= "isa7fd9/input0",
+#endif
 	.id	= {
 		.bustype = BUS_ISA,
 		.vendor  = 0x0003,
@@ -157,6 +185,18 @@
 		return -EBUSY;
 	}
 
+#ifdef CONFIG_LOGIBUSMOUSE_PC9800
+	if (!request_region(LOGIBM_TIMER_PORT, 1, "logibm")) {
+		printk(KERN_ERR "logibm.c: Can't allocate ports at %#x\n", LOGIBM_TIMER_PORT);
+		return -EBUSY;
+	}
+#endif
+
+#ifndef CONFIG_LOGIBUSMOUSE_PC9800
+	/* For PC-9800,  necessary I/O ports are already reserved by
+	   arch/i386/kernel/setup.c since mouse interface ALWAYS
+	   exist on PC-9800.  */
+
 	outb(LOGIBM_CONFIG_BYTE, LOGIBM_CONFIG_PORT);
 	outb(LOGIBM_SIGNATURE_BYTE, LOGIBM_SIGNATURE_PORT);
 	udelay(100);
@@ -166,10 +206,15 @@
 		printk(KERN_ERR "logibm.c: Didn't find Logitech busmouse at %#x\n", LOGIBM_BASE);
 		return -ENODEV;
 	}
+#endif /* CONFIG_LOGIBUSMOUSE_PC9800 */
 
 	outb(LOGIBM_DEFAULT_MODE, LOGIBM_CONFIG_PORT);
 	outb(LOGIBM_DISABLE_IRQ, LOGIBM_CONTROL_PORT);
 
+#ifdef CONFIG_LOGIBUSMOUSE_PC9800
+	outb(LOGIBM_DEFAULT_TIMER_VAL, LOGIBM_TIMER_PORT);
+#endif
+
 	input_register_device(&logibm_dev);
 	
 	printk(KERN_INFO "input: Logitech bus mouse at %#x irq %d\n", LOGIBM_BASE, logibm_irq);
@@ -181,6 +226,9 @@
 {
 	input_unregister_device(&logibm_dev);
 	release_region(LOGIBM_BASE, LOGIBM_EXTENT);
+#ifdef CONFIG_LOGIBUSMOUSE_PC9800
+	release_region(LOGIBM_TIMER_PORT, 1);
+#endif
 }
 
 module_init(logibm_init);
diff -urN linux/drivers/input/serio/Config.in linux98/drivers/input/serio/Config.in
--- linux/drivers/input/serio/Config.in	Sat Oct 12 13:22:11 2002
+++ linux98/drivers/input/serio/Config.in	Sun Oct 13 12:59:05 2002
@@ -21,3 +21,6 @@
 if [ "$CONFIG_SA1111" = "y" ]; then
    dep_tristate '  Intel SA1111 keyboard controller' CONFIG_SERIO_SA1111 $CONFIG_SERIO
 fi
+if [ "$CONFIG_PC9800" = "y" ]; then
+   dep_tristate '  NEC PC-9801 keyboard controller' CONFIG_SERIO_98KBD $CONFIG_SERIO
+fi
diff -urN linux/drivers/input/serio/Makefile linux98/drivers/input/serio/Makefile
--- linux/drivers/input/serio/Makefile	Sat Oct 12 13:21:30 2002
+++ linux98/drivers/input/serio/Makefile	Sun Oct 13 12:59:59 2002
@@ -17,6 +17,7 @@
 obj-$(CONFIG_SERIO_SA1111)	+= sa1111ps2.o
 obj-$(CONFIG_SERIO_AMBAKMI)	+= ambakmi.o
 obj-$(CONFIG_SERIO_Q40KBD)	+= q40kbd.o
+obj-$(CONFIG_SERIO_98KBD)	+= i8042-98.o
 
 # The global Rules.make.
 
diff -urN linux/drivers/input/serio/i8042-98.c linux98/drivers/input/serio/i8042-98.c
--- linux/drivers/input/serio/i8042-98.c	Thu Jan  1 09:00:00 1970
+++ linux98/drivers/input/serio/i8042-98.c	Thu Oct 17 16:54:05 2002
@@ -0,0 +1,346 @@
+/*
+ *  NEC PC-9801 keyboard controller driver for Linux
+ *
+ *  Copyright (c) 1999-2002 Vojtech Pavlik
+ *  Modify for NEC PC-9801 by Osamu Tomita <tomita@cinet.co.jp>
+ */
+
+/*
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ */
+
+#include <asm/io.h>
+
+#include <linux/delay.h>
+#include <linux/module.h>
+#include <linux/ioport.h>
+#include <linux/config.h>
+#include <linux/reboot.h>
+#include <linux/init.h>
+#include <linux/serio.h>
+#include <linux/sched.h>
+
+MODULE_AUTHOR("Osamu Tomita <tomita@cinet.co.jp>");
+MODULE_DESCRIPTION("NEC PC-9801 keyboard controller driver");
+MODULE_LICENSE("GPL");
+
+#undef DEBUG
+#include "i8042.h"
+
+spinlock_t i8042_lock = SPIN_LOCK_UNLOCKED;
+
+struct i8042_values {
+	int irq;
+	unsigned char disable;
+	unsigned char irqen;
+	unsigned char exists;
+	signed char mux;
+	unsigned char *name;
+	unsigned char *phys;
+};
+
+static struct serio i8042_kbd_port;
+static unsigned char i8042_initial_ctr;
+static unsigned char i8042_ctr;
+
+extern struct pt_regs *kbd_pt_regs;
+
+static void i8042_interrupt(int irq, void *dev_id, struct pt_regs *regs);
+
+/*
+ * The i8042_wait_read() and i8042_wait_write functions wait for the i8042 to
+ * be ready for reading values from it / writing values to it.
+ */
+
+#if 0
+static int i8042_wait_read(void)
+{
+	outb_p(0x00, 0x5f);
+	outb_p(0x00, 0x5f);
+	outb_p(0x00, 0x5f);
+	outb_p(0x00, 0x5f);
+	outb_p(0x00, 0x5f);
+	outb_p(0x00, 0x5f);
+	outb_p(0x00, 0x5f);
+	return 0;
+}
+#endif
+
+static int i8042_wait_write(void)
+{
+	outb_p(0x00, 0x5f);
+	outb_p(0x00, 0x5f);
+	outb_p(0x00, 0x5f);
+	outb_p(0x00, 0x5f);
+	outb_p(0x00, 0x5f);
+	outb_p(0x00, 0x5f);
+	outb_p(0x00, 0x5f);
+	return 0;
+}
+
+/*
+ * i8042_flush() flushes all data that may be in the keyboard and mouse buffers
+ * of the i8042 down the toilet.
+ */
+
+static int i8042_flush(void)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&i8042_lock, flags);
+
+	while (i8042_read_status() & 0x02) /* RxRDY */
+		i8042_read_data();
+
+	if (i8042_read_status() & 0x38)
+		printk("i8042-98: Keyboard error!\n");
+
+	spin_unlock_irqrestore(&i8042_lock, flags);
+
+	return 0;
+}
+
+/*
+ * i8042_kbd_write() sends a byte out through the keyboard interface.
+ */
+
+static int i8042_kbd_write(struct serio *port, unsigned char c)
+{
+	unsigned long flags;
+	int retval = 0;
+
+	spin_lock_irqsave(&i8042_lock, flags);
+
+	if(!(retval = i8042_wait_write())) {
+		dbg("%02x -> i8042-98 (kbd-data)", c);
+		i8042_write_data(c);
+	}
+
+	spin_unlock_irqrestore(&i8042_lock, flags);
+
+	return retval;
+}
+
+/*
+ * i8042_open() is called when a port is open by the higher layer.
+ * It allocates the interrupt and enables in in the chip.
+ */
+
+static int i8042_open(struct serio *port)
+{
+	struct i8042_values *values = port->driver;
+
+	i8042_flush();
+
+	if (request_irq(values->irq, i8042_interrupt, 0, "i8042-98", NULL)) {
+		printk(KERN_ERR "i8042-98.c: Can't get irq %d for %s, unregistering the port.\n", values->irq, values->name);
+		values->exists = 0;
+		serio_unregister_port(port);
+		return -1;
+	}
+
+	i8042_ctr |= values->irqen;
+
+	return 0;
+}
+
+/*
+ * i8042_close() frees the interrupt, so that it can possibly be used
+ * by another driver. We never know - if the user doesn't have a mouse,
+ * the BIOS could have used the AUX interupt for PCI.
+ */
+
+static void i8042_close(struct serio *port)
+{
+	struct i8042_values *values = port->driver;
+
+	i8042_ctr &= ~values->irqen;
+
+	free_irq(values->irq, NULL);
+
+	i8042_flush();
+}
+
+/*
+ * Structures for registering the devices in the serio.c module.
+ */
+
+static struct i8042_values i8042_kbd_values = {
+	.irqen =	I8042_CTR_KBDINT,
+	.disable =	I8042_CTR_KBDDIS,
+	.name =		"KBD",
+	.mux =		-1,
+};
+
+static struct serio i8042_kbd_port =
+{
+	.type =		SERIO_8042,
+	.write =	i8042_kbd_write,
+	.open =		i8042_open,
+	.close =	i8042_close,
+	.driver =	&i8042_kbd_values,
+	.name =		"PC-9801 Kbd Port",
+	.phys =		I8042_KBD_PHYS_DESC,
+};
+
+/*
+ * i8042_interrupt() is the most important function in this driver -
+ * it handles the interrupts from the i8042, and sends incoming bytes
+ * to the upper layers.
+ */
+
+static void i8042_interrupt(int irq, void *dev_id, struct pt_regs *regs)
+{
+	unsigned long flags;
+	unsigned char data;
+
+#ifdef CONFIG_VT
+	kbd_pt_regs = regs;
+#endif
+
+	spin_lock_irqsave(&i8042_lock, flags);
+
+	data = i8042_read_data();
+	spin_unlock_irqrestore(&i8042_lock, flags);
+	serio_interrupt(&i8042_kbd_port, data, 0);
+
+}
+
+/*
+ * i8042_controller init initializes the i8042 controller, and,
+ * most importantly, sets it into non-xlated mode if that's
+ * desired.
+ */
+	
+static int __init i8042_controller_init(void)
+{
+
+/*
+ * Test the i8042. We need to know if it thinks it's working correctly
+ * before doing anything else.
+ */
+
+	i8042_flush();
+
+	i8042_initial_ctr = i8042_ctr;
+
+/*
+ * Disable the keyboard interface and interrupt. 
+ */
+
+	i8042_ctr |= I8042_CTR_KBDDIS;
+	i8042_ctr &= ~I8042_CTR_KBDINT;
+
+/*
+ * Set nontranslated mode for the kbd interface if requested by an option.
+ * After this the kbd interface becomes a simple serial in/out, like the aux
+ * interface is. We don't do this by default, since it can confuse notebook
+ * BIOSes.
+ */
+
+	i8042_ctr &= ~I8042_CTR_XLATE;	/* i8042_direct = 1; */
+
+	return 0;
+}
+
+/*
+ * Here we try to reset everything back to a state in which the BIOS will be
+ * able to talk to the hardware when rebooting.
+ */
+
+void i8042_controller_cleanup(void)
+{
+	i8042_flush();
+
+/*
+ * Reset anything that is connected to the ports.
+ */
+
+	if (i8042_kbd_values.exists)
+		serio_cleanup(&i8042_kbd_port);
+
+/*
+ * Restore the original control register setting.
+ */
+
+	i8042_ctr = i8042_initial_ctr;
+
+}
+
+/*
+ * i8042_port_register() marks the device as existing,
+ * registers it, and reports to the user.
+ */
+
+static int __init i8042_port_register(struct i8042_values *values, struct serio *port)
+{
+	values->exists = 1;
+
+	i8042_ctr &= ~values->disable;
+
+	serio_register_port(port);
+
+	printk(KERN_INFO "serio: i8042-98 %s port at %#lx,%#lx irq %d\n",
+	       values->name,
+	       (unsigned long) I8042_DATA_REG,
+	       (unsigned long) I8042_COMMAND_REG,
+	       values->irq);
+
+	return 0;
+}
+
+/*
+ * We need to reset the 8042 back to original mode on system shutdown,
+ * because otherwise BIOSes will be confused.
+ */
+
+static int i8042_notify_sys(struct notifier_block *this, unsigned long code,
+        		    void *unused)
+{
+        if (code==SYS_DOWN || code==SYS_HALT) 
+        	i8042_controller_cleanup();
+        return NOTIFY_DONE;
+}
+
+static struct notifier_block i8042_notifier=
+{
+        i8042_notify_sys,
+        NULL,
+        0
+};
+
+int __init i8042_98init(void)
+{
+	dbg_init();
+
+	if (i8042_platform_init())
+		return -EBUSY;
+
+	i8042_kbd_values.irq = I8042_KBD_IRQ;
+
+	if (i8042_controller_init())
+		return -ENODEV;
+
+	i8042_port_register(&i8042_kbd_values, &i8042_kbd_port);
+
+	register_reboot_notifier(&i8042_notifier);
+
+	return 0;
+}
+
+void __exit i8042_98exit(void)
+{
+	unregister_reboot_notifier(&i8042_notifier);
+
+	i8042_controller_cleanup();
+	
+	if (i8042_kbd_values.exists)
+		serio_unregister_port(&i8042_kbd_port);
+
+	i8042_platform_exit();
+}
+
+module_init(i8042_98init);
+module_exit(i8042_98exit);
diff -urN linux/drivers/input/serio/i8042-98io.h linux98/drivers/input/serio/i8042-98io.h
--- linux/drivers/input/serio/i8042-98io.h	Thu Jan  1 09:00:00 1970
+++ linux98/drivers/input/serio/i8042-98io.h	Sun Oct 13 13:21:58 2002
@@ -0,0 +1,74 @@
+#ifndef _I8042_IO_H
+#define _I8042_IO_H
+
+/*
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by 
+ * the Free Software Foundation.
+ */
+
+/*
+ * Names.
+ */
+
+#define I8042_KBD_PHYS_DESC "isa0041/serio0"
+#define I8042_AUX_PHYS_DESC "isa0041/serio1"
+#define I8042_MUX_PHYS_DESC "isa0041/serio%d"
+
+/*
+ * IRQs.
+ */
+
+#define I8042_KBD_IRQ	1
+#define I8042_AUX_IRQ	0	/* nothing */
+
+/*
+ * Register numbers.
+ */
+
+#define I8042_COMMAND_REG	0x43	
+#define I8042_STATUS_REG	0x43	
+#define I8042_DATA_REG		0x41
+
+static inline int i8042_read_data(void)
+{
+	return inb(I8042_DATA_REG);
+}
+
+static inline int i8042_read_status(void)
+{
+	return inb(I8042_STATUS_REG);
+}
+
+static inline void i8042_write_data(int val)
+{
+	outb(0, 0x5f);			/* wait */
+	outb(0x17, I8042_COMMAND_REG);	/* enable send command */
+	outb(0, 0x5f);			/* wait */
+	outb(val, I8042_DATA_REG);
+	outb(0, 0x5f);			/* wait */
+	outb(0x16, I8042_COMMAND_REG);	/* disable send command */
+	outb(0, 0x5f);			/* wait */
+	return;
+}
+
+static inline void i8042_write_command(int val)
+{
+	outb(val, I8042_COMMAND_REG);
+	return;
+}
+
+static inline int i8042_platform_init(void)
+{
+/*
+ * On ix86 platforms touching the i8042 data register region can do really
+ * bad things. Because of this the region is always reserved on ix86 boxes.
+ */
+	return 0;
+}
+
+static inline void i8042_platform_exit(void)
+{
+}
+
+#endif /* _I8042_IO_H */
diff -urN linux/drivers/input/serio/i8042.h linux98/drivers/input/serio/i8042.h
--- linux/drivers/input/serio/i8042.h	Sat Oct 12 13:22:17 2002
+++ linux98/drivers/input/serio/i8042.h	Sun Oct 13 13:30:09 2002
@@ -17,6 +17,8 @@
 #include "i8042-ppcio.h"
 #elif defined(CONFIG_SPARC32) || defined(CONFIG_SPARC64)
 #include "i8042-sparcio.h"
+#elif defined(CONFIG_PC9800)
+#include "i8042-98io.h"
 #else
 #include "i8042-io.h"
 #endif
diff -urN linux/include/linux/input.h linux98/include/linux/input.h
--- linux/include/linux/input.h	Sat Oct 12 13:22:06 2002
+++ linux98/include/linux/input.h	Sat Oct 12 14:18:54 2002
@@ -9,6 +9,7 @@
  * the Free Software Foundation.
  */
 
+#include <linux/config.h>
 #ifdef __KERNEL__
 #include <linux/time.h>
 #include <linux/list.h>
@@ -134,7 +135,11 @@
 #define KEY_LEFTBRACE		26
 #define KEY_RIGHTBRACE		27
 #define KEY_ENTER		28
+#ifndef CONFIG_PC9800
 #define KEY_LEFTCTRL		29
+#else
+#define KEY_LEFTCTRL		116
+#endif
 #define KEY_A			30
 #define KEY_S			31
 #define KEY_D			32
@@ -147,7 +152,11 @@
 #define KEY_SEMICOLON		39
 #define KEY_APOSTROPHE		40
 #define KEY_GRAVE		41
+#ifndef CONFIG_PC9800
 #define KEY_LEFTSHIFT		42
+#else
+#define KEY_LEFTSHIFT		112
+#endif
 #define KEY_BACKSLASH		43
 #define KEY_Z			44
 #define KEY_X			45
@@ -161,9 +170,17 @@
 #define KEY_SLASH		53
 #define KEY_RIGHTSHIFT		54
 #define KEY_KPASTERISK		55
+#ifndef CONFIG_PC9800
 #define KEY_LEFTALT		56
+#else
+#define KEY_LEFTALT		115
+#endif
 #define KEY_SPACE		57
+#ifndef CONFIG_PC9800
 #define KEY_CAPSLOCK		58
+#else
+#define KEY_CAPSLOCK		113
+#endif
 #define KEY_F1			59
 #define KEY_F2			60
 #define KEY_F3			61
@@ -204,7 +221,11 @@
 #define KEY_KPENTER		96
 #define KEY_RIGHTCTRL		97
 #define KEY_KPSLASH		98
+#ifndef CONFIG_PC9800
 #define KEY_SYSRQ		99
+#else
+#define KEY_SYSRQ		96
+#endif
 #define KEY_RIGHTALT		100
 #define KEY_LINEFEED		101
 #define KEY_HOME		102
