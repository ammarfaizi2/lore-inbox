Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267238AbTBQOgr>; Mon, 17 Feb 2003 09:36:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267083AbTBQOF3>; Mon, 17 Feb 2003 09:05:29 -0500
Received: from chii.cinet.co.jp ([61.197.228.217]:25728 "EHLO
	yuzuki.cinet.co.jp") by vger.kernel.org with ESMTP
	id <S267097AbTBQOEC>; Mon, 17 Feb 2003 09:04:02 -0500
Date: Mon, 17 Feb 2003 23:12:23 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCHSET] PC-9800 subarch. support for 2.5.61 (14/26) input
Message-ID: <20030217141223.GN4799@yuzuki.cinet.co.jp>
References: <20030217134333.GA4734@yuzuki.cinet.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030217134333.GA4734@yuzuki.cinet.co.jp>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is patchset to support NEC PC-9800 subarchitecture
against 2.5.61 (14/26).

Drivers for PC98 standard keyboard/mouse.

diff -Nru linux/drivers/input/keyboard/98kbd.c linux98/drivers/input/keyboard/98kbd.c
--- linux/drivers/input/keyboard/98kbd.c	1970-01-01 09:00:00.000000000 +0900
+++ linux98/drivers/input/keyboard/98kbd.c	2002-11-15 15:57:45.000000000 +0000
@@ -0,0 +1,379 @@
+/*
+ *  drivers/input/keyboard/98kbd.c
+ *
+ *  PC-9801 keyboard driver for Linux
+ *
+ *    Based on atkbd.c and xtkbd.c written by Vojtech Pavlik
+ *
+ *  Copyright (c) 2002 Osamu Tomita
+ *  Copyright (c) 1999-2001 Vojtech Pavlik
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
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ * 
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ * 
+ */
+
+#include <linux/delay.h>
+#include <linux/slab.h>
+#include <linux/module.h>
+#include <linux/input.h>
+#include <linux/init.h>
+#include <linux/serio.h>
+
+#include <asm/io.h>
+#include <asm/pc9800.h>
+
+MODULE_AUTHOR("Osamu Tomita <tomita@cinet.co.jp>");
+MODULE_DESCRIPTION("PC-9801 keyboard driver");
+MODULE_LICENSE("GPL");
+
+#define KBD98_KEY	0x7f
+#define KBD98_RELEASE	0x80
+
+static unsigned char kbd98_keycode[256] = {	 
+	  1,  2,  3,  4,  5,  6,  7,  8,  9, 10, 11, 12, 13, 43, 14, 15,
+	 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 41, 26, 28, 30, 31, 32,
+	 33, 34, 35, 36, 37, 38, 39, 40, 27, 44, 45, 46, 47, 48, 49, 50,
+	 51, 52, 53, 12, 57,184,109,104,110,111,103,105,106,108,102,107,
+	 74, 98, 71, 72, 73, 55, 75, 76, 77, 78, 79, 80, 81,117, 82,124,
+	 83,185, 87, 88, 85, 89, 90,  0,  0,  0,  0,  0,  0,  0,102,  0,
+	 99,133, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68,  0,  0,  0,  0,
+	 54, 58, 42, 56, 29
+};
+
+struct jis_kbd_conv {
+	unsigned char scancode;
+	struct {
+		unsigned char shift;
+		unsigned char keycode;
+	} emul[2];
+};
+
+static struct jis_kbd_conv kbd98_jis[] = {
+	{0x02, {{0,   3}, {1,  40}}},
+	{0x06, {{0,   7}, {1,   8}}},
+	{0x07, {{0,   8}, {0,  40}}},
+	{0x08, {{0,   9}, {1,  10}}},
+	{0x09, {{0,  10}, {1,  11}}},
+	{0x0a, {{0,  11}, {1, 255}}},
+	{0x0b, {{0,  12}, {0,  13}}},
+	{0x0c, {{1,   7}, {0,  41}}},
+	{0x1a, {{1,   3}, {1,  41}}},
+	{0x26, {{0,  39}, {1,  13}}},
+	{0x27, {{1,  39}, {1,   9}}},
+	{0x33, {{0, 255}, {1,  12}}},
+	{0xff, {{0, 255}, {1, 255}}}	/* terminater */
+};
+
+#define KBD98_CMD_SETEXKEY	0x1095	/* Enable/Disable Windows, Appli key */
+#define KBD98_CMD_SETRATE	0x109c	/* Set typematic rate */
+#define KBD98_CMD_SETLEDS	0x109d	/* Set keyboard leds */
+#define KBD98_CMD_GETLEDS	0x119d	/* Get keyboard leds */
+#define KBD98_CMD_GETID		0x019f
+
+#define KBD98_RET_ACK		0xfa
+#define KBD98_RET_NAK		0xfc	/* Command NACK, send the cmd again */
+
+#define KBD98_KEY_JIS_EMUL	253
+#define KBD98_KEY_UNKNOWN	254
+#define KBD98_KEY_NULL		255
+
+static char *kbd98_name = "PC-9801 Keyboard";
+
+struct kbd98 {
+	unsigned char keycode[256];
+	struct input_dev dev;
+	struct serio *serio;
+	char phys[32];
+	unsigned char cmdbuf[4];
+	unsigned char cmdcnt;
+	signed char ack;
+	unsigned char shift;
+	struct {
+		unsigned char scancode;
+		unsigned char keycode;
+	} emul;
+	struct jis_kbd_conv jis[16];
+};
+
+void kbd98_interrupt(struct serio *serio, unsigned char data, unsigned int flags)
+{
+	struct kbd98 *kbd98 = serio->private;
+	unsigned char scancode, keycode;
+	int press, i;
+
+	switch (data) {
+		case KBD98_RET_ACK:
+			kbd98->ack = 1;
+			return;
+		case KBD98_RET_NAK:
+			kbd98->ack = -1;
+			return;
+	}
+
+	if (kbd98->cmdcnt) {
+		kbd98->cmdbuf[--kbd98->cmdcnt] = data;
+		return;
+	}
+
+	scancode = data & KBD98_KEY;
+	keycode = kbd98->keycode[scancode];
+	press = !(data & KBD98_RELEASE);
+	if (kbd98->emul.scancode != KBD98_KEY_UNKNOWN
+	    && scancode != kbd98->emul.scancode) {
+		input_report_key(&kbd98->dev, kbd98->emul.keycode, 0);
+		kbd98->emul.scancode = KBD98_KEY_UNKNOWN;
+	}
+
+	if (keycode == KEY_RIGHTSHIFT)
+		kbd98->shift = press;
+
+	switch (keycode) {
+		case KEY_2:
+		case KEY_6:
+		case KEY_7:
+		case KEY_8:
+		case KEY_9:
+		case KEY_0:
+		case KEY_MINUS:
+		case KEY_EQUAL:
+		case KEY_GRAVE:
+		case KEY_SEMICOLON:
+		case KEY_APOSTROPHE:
+			/* emulation: JIS keyboard to US101 keyboard */
+			i = 0;
+			while (kbd98->jis[i].scancode != 0xff) {
+				if (scancode == kbd98->jis[i].scancode)
+					break;
+				i ++;
+			}
+
+			keycode = kbd98->jis[i].emul[kbd98->shift].keycode;
+			if (keycode == KBD98_KEY_NULL)
+				return;
+
+			if (press) {
+				kbd98->emul.scancode = scancode;
+				kbd98->emul.keycode = keycode;
+				if (kbd98->jis[i].emul[kbd98->shift].shift
+								!= kbd98->shift)
+					input_report_key(&kbd98->dev,
+							KEY_RIGHTSHIFT,
+							!(kbd98->shift));
+			}
+
+			input_report_key(&kbd98->dev, keycode, press);
+			if (!press) {
+				if (kbd98->jis[i].emul[kbd98->shift].shift
+								!= kbd98->shift)
+					input_report_key(&kbd98->dev,
+							KEY_RIGHTSHIFT,
+							kbd98->shift);
+				kbd98->emul.scancode = KBD98_KEY_UNKNOWN;
+			}
+
+			input_sync(&kbd98->dev);
+			return;
+
+		case KBD98_KEY_NULL:
+			return;
+
+		case 0:
+			printk(KERN_WARNING "kbd98.c: Unknown key (scancode %#x) %s.\n",
+				data & KBD98_KEY, data & KBD98_RELEASE ? "released" : "pressed");
+			return;
+
+		default:
+			input_report_key(&kbd98->dev, keycode, press);
+			input_sync(&kbd98->dev);
+		}
+}
+
+/*
+ * kbd98_sendbyte() sends a byte to the keyboard, and waits for
+ * acknowledge. It doesn't handle resends according to the keyboard
+ * protocol specs, because if these are needed, the keyboard needs
+ * replacement anyway, and they only make a mess in the protocol.
+ */
+
+static int kbd98_sendbyte(struct kbd98 *kbd98, unsigned char byte)
+{
+	int timeout = 10000; /* 100 msec */
+	kbd98->ack = 0;
+
+	if (serio_write(kbd98->serio, byte))
+		return -1;
+
+	while (!kbd98->ack && timeout--) udelay(10);
+
+	return -(kbd98->ack <= 0);
+}
+
+/*
+ * kbd98_command() sends a command, and its parameters to the keyboard,
+ * then waits for the response and puts it in the param array.
+ */
+
+static int kbd98_command(struct kbd98 *kbd98, unsigned char *param, int command)
+{
+	int timeout = 50000; /* 500 msec */
+	int send = (command >> 12) & 0xf;
+	int receive = (command >> 8) & 0xf;
+	int i;
+
+	kbd98->cmdcnt = receive;
+	
+	if (command & 0xff)
+		if (kbd98_sendbyte(kbd98, command & 0xff))
+			return (kbd98->cmdcnt = 0) - 1;
+
+	for (i = 0; i < send; i++)
+		if (kbd98_sendbyte(kbd98, param[i]))
+			return (kbd98->cmdcnt = 0) - 1;
+
+	while (kbd98->cmdcnt && timeout--) udelay(10);
+
+	if (param)
+		for (i = 0; i < receive; i++)
+			param[i] = kbd98->cmdbuf[(receive - 1) - i];
+
+	if (kbd98->cmdcnt) 
+		return (kbd98->cmdcnt = 0) - 1;
+
+	return 0;
+}
+
+/*
+ * Event callback from the input module. Events that change the state of
+ * the hardware are processed here.
+ */
+
+static int kbd98_event(struct input_dev *dev, unsigned int type, unsigned int code, int value)
+{
+	struct kbd98 *kbd98 = dev->private;
+	char param[2];
+
+	switch (type) {
+
+		case EV_LED:
+
+			if (__PC9800SCA_TEST_BIT(0x481, 3)) {
+				/* 98note with Num Lock key */
+				/* keep Num Lock status     */
+				*param = 0x60;
+				if (kbd98_command(kbd98, param,
+							KBD98_CMD_GETLEDS))
+					printk(KERN_DEBUG
+						"kbd98: Get keyboard LED"
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
+		        kbd98_command(kbd98, param, KBD98_CMD_SETLEDS);
+
+			return 0;
+	}
+
+	return -1;
+}
+
+void kbd98_connect(struct serio *serio, struct serio_dev *dev)
+{
+	struct kbd98 *kbd98;
+	int i;
+
+	if ((serio->type & SERIO_TYPE) != SERIO_PC9800)
+		return;
+
+	if (!(kbd98 = kmalloc(sizeof(struct kbd98), GFP_KERNEL)))
+		return;
+
+	memset(kbd98, 0, sizeof(struct kbd98));
+	kbd98->emul.scancode = KBD98_KEY_UNKNOWN;
+	
+	kbd98->dev.evbit[0] = BIT(EV_KEY) | BIT(EV_LED) | BIT(EV_REP);
+	kbd98->dev.ledbit[0] = BIT(LED_NUML) | BIT(LED_CAPSL) | BIT(LED_KANA);
+
+	kbd98->serio = serio;
+
+	init_input_dev(&kbd98->dev);
+	kbd98->dev.keycode = kbd98->keycode;
+	kbd98->dev.keycodesize = sizeof(unsigned char);
+	kbd98->dev.keycodemax = ARRAY_SIZE(kbd98_keycode);
+	kbd98->dev.event = kbd98_event;
+	kbd98->dev.private = kbd98;
+
+	serio->private = kbd98;
+
+	if (serio_open(serio, dev)) {
+		kfree(kbd98);
+		return;
+	}
+
+	memcpy(kbd98->jis, kbd98_jis, sizeof(kbd98_jis));
+	memcpy(kbd98->keycode, kbd98_keycode, sizeof(kbd98->keycode));
+	for (i = 0; i < 255; i++)
+		set_bit(kbd98->keycode[i], kbd98->dev.keybit);
+	clear_bit(0, kbd98->dev.keybit);
+
+	sprintf(kbd98->phys, "%s/input0", serio->phys);
+
+	kbd98->dev.name = kbd98_name;
+	kbd98->dev.phys = kbd98->phys;
+	kbd98->dev.id.bustype = BUS_XTKBD;
+	kbd98->dev.id.vendor = 0x0002;
+	kbd98->dev.id.product = 0x0001;
+	kbd98->dev.id.version = 0x0100;
+
+	input_register_device(&kbd98->dev);
+
+	printk(KERN_INFO "input: %s on %s\n", kbd98_name, serio->phys);
+}
+
+void kbd98_disconnect(struct serio *serio)
+{
+	struct kbd98 *kbd98 = serio->private;
+	input_unregister_device(&kbd98->dev);
+	serio_close(serio);
+	kfree(kbd98);
+}
+
+struct serio_dev kbd98_dev = {
+	.interrupt =	kbd98_interrupt,
+	.connect =	kbd98_connect,
+	.disconnect =	kbd98_disconnect
+};
+
+int __init kbd98_init(void)
+{
+	serio_register_device(&kbd98_dev);
+	return 0;
+}
+
+void __exit kbd98_exit(void)
+{
+	serio_unregister_device(&kbd98_dev);
+}
+
+module_init(kbd98_init);
+module_exit(kbd98_exit);
diff -Nru linux-2.5.61/drivers/input/keyboard/Kconfig linux98-2.5.61/drivers/input/keyboard/Kconfig
--- linux-2.5.61/drivers/input/keyboard/Kconfig	2003-02-15 08:52:39.000000000 +0900
+++ linux98-2.5.61/drivers/input/keyboard/Kconfig	2003-02-16 17:19:03.000000000 +0900
@@ -90,3 +90,15 @@
 	  The module will be called amikbd. If you want to compile it as a
 	  module, say M here and read <file:Documentation/modules.txt>.
 
+config KEYBOARD_98KBD
+	tristate "NEC PC-9800 Keyboard support"
+	depends on X86_PC9800 && INPUT && INPUT_KEYBOARD && SERIO
+	help
+	  Say Y here if you want to use the NEC PC-9801/PC-9821 keyboard (or
+	  compatible) on your system. 
+
+	  This driver is also available as a module ( = code which can be
+	  inserted in and removed from the running kernel whenever you want).
+	  The module will be called xtkbd.o. If you want to compile it as a
+	  module, say M here and read <file:Documentation/modules.txt>.
+
diff -Nru linux-2.5.52/drivers/input/keyboard/Makefile linux98-2.5.52/drivers/input/keyboard/Makefile
--- linux-2.5.52/drivers/input/keyboard/Makefile	2002-12-16 11:07:54.000000000 +0900
+++ linux98-2.5.52/drivers/input/keyboard/Makefile	2002-12-16 21:28:54.000000000 +0900
@@ -10,3 +10,4 @@
 obj-$(CONFIG_KEYBOARD_XTKBD)		+= xtkbd.o
 obj-$(CONFIG_KEYBOARD_AMIGA)		+= amikbd.o
 obj-$(CONFIG_KEYBOARD_NEWTON)		+= newtonkbd.o
+obj-$(CONFIG_KEYBOARD_98KBD)		+= 98kbd.o
diff -Nru linux/drivers/input/mouse/98busmouse.c linux98/drivers/input/mouse/98busmouse.c
--- linux/drivers/input/mouse/98busmouse.c	1970-01-01 09:00:00.000000000 +0900
+++ linux98/drivers/input/mouse/98busmouse.c	2003-02-16 17:19:03.000000000 +0900
@@ -0,0 +1,202 @@
+/*
+ *
+ *  Copyright (c) 2002 Osamu Tomita
+ *
+ *  Based on the work of:
+ *	James Banks		Matthew Dillon
+ *	David Giller		Nathan Laredo
+ *	Linus Torvalds		Johan Myreen
+ *	Cliff Matthews		Philip Blundell
+ *	Russell King		Vojtech Pavlik
+ */
+
+/*
+ * NEC PC-9801 Bus Mouse Driver for Linux
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
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ * 
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ * 
+ */
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/delay.h>
+#include <linux/ioport.h>
+#include <linux/init.h>
+#include <linux/input.h>
+#include <linux/interrupt.h>
+
+#include <asm/io.h>
+#include <asm/irq.h>
+
+MODULE_AUTHOR("Osamu Tomita <tomita@cinet.co.jp>");
+MODULE_DESCRIPTION("PC-9801 busmouse driver");
+MODULE_LICENSE("GPL");
+
+#define	PC98BM_BASE		0x7fd9
+#define	PC98BM_DATA_PORT	PC98BM_BASE + 0
+/*	PC98BM_SIGNATURE_PORT	does not exist */
+#define	PC98BM_CONTROL_PORT	PC98BM_BASE + 4
+/*	PC98BM_INTERRUPT_PORT	does not exist */
+#define	PC98BM_CONFIG_PORT	PC98BM_BASE + 6
+
+#define	PC98BM_ENABLE_IRQ	0x00
+#define	PC98BM_DISABLE_IRQ	0x10
+#define	PC98BM_READ_X_LOW	0x80
+#define	PC98BM_READ_X_HIGH	0xa0
+#define	PC98BM_READ_Y_LOW	0xc0
+#define	PC98BM_READ_Y_HIGH	0xe0
+
+#define PC98BM_DEFAULT_MODE	0x93
+/*	PC98BM_CONFIG_BYTE	is not used */
+/*	PC98BM_SIGNATURE_BYTE	is not used */
+
+#define PC98BM_TIMER_PORT	0xbfdb
+#define PC98BM_DEFAULT_TIMER_VAL	0x00
+
+#define PC98BM_IRQ		13
+
+MODULE_PARM(pc98bm_irq, "i");
+
+static int pc98bm_irq = PC98BM_IRQ;
+static int pc98bm_used = 0;
+
+static void pc98bm_interrupt(int irq, void *dev_id, struct pt_regs *regs);
+
+static int pc98bm_open(struct input_dev *dev)
+{
+	if (pc98bm_used++)
+		return 0;
+	if (request_irq(pc98bm_irq, pc98bm_interrupt, 0, "98busmouse", NULL)) {
+		pc98bm_used--;
+		printk(KERN_ERR "98busmouse.c: Can't allocate irq %d\n", pc98bm_irq);
+		return -EBUSY;
+	}
+	outb(PC98BM_ENABLE_IRQ, PC98BM_CONTROL_PORT);
+	return 0;
+}
+
+static void pc98bm_close(struct input_dev *dev)
+{
+	if (--pc98bm_used)
+		return;
+	outb(PC98BM_DISABLE_IRQ, PC98BM_CONTROL_PORT);
+	free_irq(pc98bm_irq, NULL);
+}
+
+static struct input_dev pc98bm_dev = {
+	.evbit	= { BIT(EV_KEY) | BIT(EV_REL) },
+	.keybit = { [LONG(BTN_LEFT)] = BIT(BTN_LEFT) | BIT(BTN_MIDDLE) | BIT(BTN_RIGHT) },
+	.relbit	= { BIT(REL_X) | BIT(REL_Y) },
+	.open	= pc98bm_open,
+	.close	= pc98bm_close,
+	.name	= "PC-9801 bus mouse",
+	.phys	= "isa7fd9/input0",
+	.id	= {
+		.bustype = BUS_ISA,
+		.vendor  = 0x0004,
+		.product = 0x0001,
+		.version = 0x0100,
+	},
+};
+
+static void pc98bm_interrupt(int irq, void *dev_id, struct pt_regs *regs)
+{
+	char dx, dy;
+	unsigned char buttons;
+
+	outb(PC98BM_READ_X_LOW, PC98BM_CONTROL_PORT);
+	dx = (inb(PC98BM_DATA_PORT) & 0xf);
+	outb(PC98BM_READ_X_HIGH, PC98BM_CONTROL_PORT);
+	dx |= (inb(PC98BM_DATA_PORT) & 0xf) << 4;
+	outb(PC98BM_READ_Y_LOW, PC98BM_CONTROL_PORT);
+	dy = (inb(PC98BM_DATA_PORT) & 0xf);
+	outb(PC98BM_READ_Y_HIGH, PC98BM_CONTROL_PORT);
+	buttons = inb(PC98BM_DATA_PORT);
+	dy |= (buttons & 0xf) << 4;
+	buttons = ~buttons >> 5;
+
+	input_report_rel(&pc98bm_dev, REL_X, dx);
+	input_report_rel(&pc98bm_dev, REL_Y, dy);
+	input_report_key(&pc98bm_dev, BTN_RIGHT,  buttons & 1);
+	input_report_key(&pc98bm_dev, BTN_MIDDLE, buttons & 2);
+	input_report_key(&pc98bm_dev, BTN_LEFT,   buttons & 4);
+	input_sync(&pc98bm_dev);
+
+	outb(PC98BM_ENABLE_IRQ, PC98BM_CONTROL_PORT);
+}
+
+#ifndef MODULE
+static int __init pc98bm_setup(char *str)
+{
+        int ints[4];
+        str = get_options(str, ARRAY_SIZE(ints), ints);
+        if (ints[0] > 0) pc98bm_irq = ints[1];
+        return 1;
+}
+__setup("pc98bm_irq=", pc98bm_setup);
+#endif
+
+static int __init pc98bm_init(void)
+{
+	int i;
+
+	for (i = 0; i <= 6; i += 2) {
+		if (!request_region(PC98BM_BASE + i, 1, "98busmouse")) {
+			printk(KERN_ERR "98busmouse.c: Can't allocate ports at %#x\n", PC98BM_BASE + i);
+			while (i > 0) {
+				i -= 2;
+				release_region(PC98BM_BASE + i, 1);
+			}
+
+			return -EBUSY;
+		}
+
+	}
+
+	if (!request_region(PC98BM_TIMER_PORT, 1, "98busmouse")) {
+		printk(KERN_ERR "98busmouse.c: Can't allocate ports at %#x\n", PC98BM_TIMER_PORT);
+		for (i = 0; i <= 6; i += 2)
+			release_region(PC98BM_BASE + i, 1);
+
+		return -EBUSY;
+	}
+
+	outb(PC98BM_DEFAULT_MODE, PC98BM_CONFIG_PORT);
+	outb(PC98BM_DISABLE_IRQ, PC98BM_CONTROL_PORT);
+
+	outb(PC98BM_DEFAULT_TIMER_VAL, PC98BM_TIMER_PORT);
+
+	input_register_device(&pc98bm_dev);
+	
+	printk(KERN_INFO "input: PC-9801 bus mouse at %#x irq %d\n", PC98BM_BASE, pc98bm_irq);
+
+	return 0;
+}
+
+static void __exit pc98bm_exit(void)
+{
+	int i;
+
+	input_unregister_device(&pc98bm_dev);
+	for (i = 0; i <= 6; i += 2)
+		release_region(PC98BM_BASE + i, 1);
+
+	release_region(PC98BM_TIMER_PORT, 1);
+}
+
+module_init(pc98bm_init);
+module_exit(pc98bm_exit);
diff -Nru linux-2.5.60/drivers/input/mouse/Kconfig linux98-2.5.60/drivers/input/mouse/Kconfig
--- linux-2.5.60/drivers/input/mouse/Kconfig	2003-02-11 03:38:50.000000000 +0900
+++ linux98-2.5.60/drivers/input/mouse/Kconfig	2003-02-16 17:19:03.000000000 +0900
@@ -121,3 +121,15 @@
 	  The module will be called rpcmouse. If you want to compile it as a
 	  module, say M here and read <file.:Documentation/modules.txt>.
 
+config MOUSE_PC9800
+	tristate "NEC PC-9800 busmouse"
+	depends on X86_PC9800 && INPUT && INPUT_MOUSE && ISA
+	help
+	  Say Y here if you have NEC PC-9801/PC-9821 computer and want its
+	  native mouse supported.
+
+	  This driver is also available as a module ( = code which can be
+	  inserted in and removed from the running kernel whenever you want).
+	  The module will be called logibm.o. If you want to compile it as a
+	  module, say M here and read <file.:Documentation/modules.txt>.
+
diff -Nru linux-2.5.52/drivers/input/mouse/Makefile linux98-2.5.52/drivers/input/mouse/Makefile
--- linux-2.5.52/drivers/input/mouse/Makefile	2002-12-16 11:07:49.000000000 +0900
+++ linux98-2.5.52/drivers/input/mouse/Makefile	2002-12-16 21:34:16.000000000 +0900
@@ -10,5 +10,6 @@
 obj-$(CONFIG_MOUSE_LOGIBM)	+= logibm.o
 obj-$(CONFIG_MOUSE_MAPLE)	+= maplemouse.o
 obj-$(CONFIG_MOUSE_PC110PAD)	+= pc110pad.o
+obj-$(CONFIG_MOUSE_PC9800)	+= 98busmouse.o
 obj-$(CONFIG_MOUSE_PS2)		+= psmouse.o
 obj-$(CONFIG_MOUSE_SERIAL)	+= sermouse.o
diff -Nru linux-2.5.61/drivers/input/serio/98kbd-io.c linux98-2.5.61/drivers/input/serio/98kbd-io.c
--- linux-2.5.61/drivers/input/serio/98kbd-io.c	1970-01-01 09:00:00.000000000 +0900
+++ linux98-2.5.61/drivers/input/serio/98kbd-io.c	2003-02-16 17:19:03.000000000 +0900
@@ -0,0 +1,178 @@
+/*
+ *  NEC PC-9801 keyboard controller driver for Linux
+ *
+ *  Copyright (c) 1999-2002 Osamu Tomita <tomita@cinet.co.jp>
+ *    Based on i8042.c written by Vojtech Pavlik
+ */
+
+/*
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ */
+
+#include <linux/config.h>
+#include <linux/delay.h>
+#include <linux/module.h>
+#include <linux/interrupt.h>
+#include <linux/ioport.h>
+#include <linux/init.h>
+#include <linux/serio.h>
+#include <linux/sched.h>
+
+#include <asm/io.h>
+
+MODULE_AUTHOR("Osamu Tomita <tomita@cinet.co.jp>");
+MODULE_DESCRIPTION("NEC PC-9801 keyboard controller driver");
+MODULE_LICENSE("GPL");
+
+/*
+ * Names.
+ */
+
+#define KBD98_PHYS_DESC "isa0041/serio0"
+
+/*
+ * IRQs.
+ */
+
+#define KBD98_IRQ	1
+
+/*
+ * Register numbers.
+ */
+
+#define KBD98_COMMAND_REG	0x43	
+#define KBD98_STATUS_REG	0x43	
+#define KBD98_DATA_REG		0x41
+
+spinlock_t kbd98io_lock = SPIN_LOCK_UNLOCKED;
+
+static struct serio kbd98_port;
+extern struct pt_regs *kbd_pt_regs;
+
+static void kbd98io_interrupt(int irq, void *dev_id, struct pt_regs *regs);
+
+/*
+ * kbd98_flush() flushes all data that may be in the keyboard buffers
+ */
+
+static int kbd98_flush(void)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&kbd98io_lock, flags);
+
+	while (inb(KBD98_STATUS_REG) & 0x02) /* RxRDY */
+		inb(KBD98_DATA_REG);
+
+	if (inb(KBD98_STATUS_REG) & 0x38)
+		printk("98kbd-io: Keyboard error!\n");
+
+	spin_unlock_irqrestore(&kbd98io_lock, flags);
+
+	return 0;
+}
+
+/*
+ * kbd98_write() sends a byte out through the keyboard interface.
+ */
+
+static int kbd98_write(struct serio *port, unsigned char c)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&kbd98io_lock, flags);
+
+	outb(0, 0x5f);			/* wait */
+	outb(0x17, KBD98_COMMAND_REG);	/* enable send command */
+	outb(0, 0x5f);			/* wait */
+	outb(c, KBD98_DATA_REG);
+	outb(0, 0x5f);			/* wait */
+	outb(0x16, KBD98_COMMAND_REG);	/* disable send command */
+	outb(0, 0x5f);			/* wait */
+
+	spin_unlock_irqrestore(&kbd98io_lock, flags);
+
+	return 0;
+}
+
+/*
+ * kbd98_open() is called when a port is open by the higher layer.
+ * It allocates the interrupt and enables in in the chip.
+ */
+
+static int kbd98_open(struct serio *port)
+{
+	kbd98_flush();
+
+	if (request_irq(KBD98_IRQ, kbd98io_interrupt, 0, "kbd98", NULL)) {
+		printk(KERN_ERR "98kbd-io.c: Can't get irq %d for %s, unregistering the port.\n", KBD98_IRQ, "KBD");
+		serio_unregister_port(port);
+		return -1;
+	}
+
+	return 0;
+}
+
+static void kbd98_close(struct serio *port)
+{
+	free_irq(KBD98_IRQ, NULL);
+
+	kbd98_flush();
+}
+
+/*
+ * Structures for registering the devices in the serio.c module.
+ */
+
+static struct serio kbd98_port =
+{
+	.type =		SERIO_PC9800,
+	.write =	kbd98_write,
+	.open =		kbd98_open,
+	.close =	kbd98_close,
+	.driver =	NULL,
+	.name =		"PC-9801 Kbd Port",
+	.phys =		KBD98_PHYS_DESC,
+};
+
+/*
+ * kbd98io_interrupt() is the most important function in this driver -
+ * it handles the interrupts from keyboard, and sends incoming bytes
+ * to the upper layers.
+ */
+
+static void kbd98io_interrupt(int irq, void *dev_id, struct pt_regs *regs)
+{
+	unsigned long flags;
+	unsigned char data;
+
+	spin_lock_irqsave(&kbd98io_lock, flags);
+
+	data = inb(KBD98_DATA_REG);
+	spin_unlock_irqrestore(&kbd98io_lock, flags);
+	serio_interrupt(&kbd98_port, data, 0, regs);
+
+}
+
+int __init kbd98io_init(void)
+{
+	serio_register_port(&kbd98_port);
+
+	printk(KERN_INFO "serio: PC-9801 %s port at %#lx,%#lx irq %d\n",
+	       "KBD",
+	       (unsigned long) KBD98_DATA_REG,
+	       (unsigned long) KBD98_COMMAND_REG,
+	       KBD98_IRQ);
+
+	return 0;
+}
+
+void __exit kbd98io_exit(void)
+{
+	serio_unregister_port(&kbd98_port);
+}
+
+module_init(kbd98io_init);
+module_exit(kbd98io_exit);
diff -Nru linux-2.5.61/drivers/input/serio/Kconfig linux98-2.5.61/drivers/input/serio/Kconfig
--- linux-2.5.61/drivers/input/serio/Kconfig	2003-02-15 08:51:47.000000000 +0900
+++ linux98-2.5.61/drivers/input/serio/Kconfig	2003-02-16 17:19:03.000000000 +0900
@@ -107,3 +107,15 @@
 	tristate "Intel SA1111 keyboard controller"
 	depends on SA1111 && SERIO
 
+config SERIO_98KBD
+	tristate "NEC PC-9800 keyboard controller"
+	depends on X86_PC9800 && SERIO
+	help
+	  Say Y here if you have the NEC PC-9801/PC-9821 and want to use its
+	  standard keyboard connected to its keyboard controller.
+
+	  This driver is also available as a module ( = code which can be
+	  inserted in and removed from the running kernel whenever you want).
+	  The module will be called rpckbd.o. If you want to compile it as a
+	  module, say M here and read <file:Documentation/modules.txt>.
+
diff -Nru linux-2.5.60/drivers/input/serio/Makefile linux98-2.5.60/drivers/input/serio/Makefile
--- linux-2.5.60/drivers/input/serio/Makefile	2003-02-11 03:37:57.000000000 +0900
+++ linux98-2.5.60/drivers/input/serio/Makefile	2003-02-11 09:47:18.000000000 +0900
@@ -13,3 +13,4 @@
 obj-$(CONFIG_SERIO_SA1111)	+= sa1111ps2.o
 obj-$(CONFIG_SERIO_AMBAKMI)	+= ambakmi.o
 obj-$(CONFIG_SERIO_Q40KBD)	+= q40kbd.o
+obj-$(CONFIG_SERIO_98KBD)	+= 98kbd-io.o
