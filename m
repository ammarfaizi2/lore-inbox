Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261400AbSJ1RfA>; Mon, 28 Oct 2002 12:35:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261432AbSJ1ReI>; Mon, 28 Oct 2002 12:34:08 -0500
Received: from gateway.cinet.co.jp ([210.166.75.129]:61199 "EHLO
	precia.cinet.co.jp") by vger.kernel.org with ESMTP
	id <S261400AbSJ1RXs>; Mon, 28 Oct 2002 12:23:48 -0500
Date: Tue, 29 Oct 2002 02:30:08 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCHSET 10/23] add support for PC-9800 architecture (input)
Message-ID: <20021029023008.A2277@precia.cinet.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a part 10/23 of patchset for add support NEC PC-9800 architecture,
against 2.5.44.

Summary:
 input modules
  - add new driver for PC-9800 standard keyboard and mouse.
  - add few changes for PC-9800 hardware spec.

diffstat:
 drivers/char/keyboard.c          |    4 
 drivers/input/keyboard/98kbd.c   |  356 +++++++++++++++++++++++++++++++++++++++
 drivers/input/keyboard/Config.in |    4 
 drivers/input/keyboard/Makefile  |    1 
 drivers/input/misc/pcspkr.c      |   24 ++
 drivers/input/mouse/98busmouse.c |  201 ++++++++++++++++++++++
 drivers/input/mouse/Config.in    |    3 
 drivers/input/mouse/Makefile     |    1 
 drivers/input/serio/98kbd-io.c   |  181 +++++++++++++++++++
 drivers/input/serio/Config.in    |    3 
 drivers/input/serio/Makefile     |    1 
 include/linux/kbd_kern.h         |    5 
 include/linux/keyboard.h         |    1 
 include/linux/serio.h            |    1 
 14 files changed, 784 insertions(+), 2 deletions(-)

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
+++ linux98/drivers/input/keyboard/98kbd.c	Sun Oct 27 07:45:43 2002
@@ -0,0 +1,356 @@
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
+#define KBD98_KEY_JIS_EMUL	254
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
+			if (kbd98->jis[i].emul[kbd98->shift].shift != kbd98->shift && press) {
+				input_report_key(&kbd98->dev, KEY_RIGHTSHIFT, !(kbd98->shift));
+			}
+
+			input_report_key(&kbd98->dev, keycode, press);
+			if (kbd98->jis[i].emul[kbd98->shift].shift != kbd98->shift && !press) {
+				input_report_key(&kbd98->dev, KEY_RIGHTSHIFT, kbd98->shift);
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
diff -urN linux/drivers/input/mouse/98busmouse.c linux98/drivers/input/mouse/98busmouse.c
--- linux/drivers/input/mouse/98busmouse.c	Thu Jan  1 09:00:00 1970
+++ linux98/drivers/input/mouse/98busmouse.c	Sat Oct 26 18:36:15 2002
@@ -0,0 +1,201 @@
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
+#include <asm/io.h>
+#include <asm/irq.h>
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/delay.h>
+#include <linux/ioport.h>
+#include <linux/init.h>
+#include <linux/input.h>
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
diff -urN linux/drivers/input/mouse/Config.in linux98/drivers/input/mouse/Config.in
--- linux/drivers/input/mouse/Config.in	Sat Oct 19 13:02:28 2002
+++ linux98/drivers/input/mouse/Config.in	Thu Oct 24 16:59:32 2002
@@ -22,3 +22,6 @@
 if [ "$CONFIG_ARCH_ACORN" = "y" ]; then
    dep_tristate '  Acorn RiscPC mouse' CONFIG_MOUSE_ACORN $CONFIG_INPUT $CONFIG_INPUT_MOUSE
 fi
+if [ "$CONFIG_PC9800" = "y" ]; then
+   dep_tristate '  NEC PC-9801 busmouse' CONFIG_BUSMOUSE_PC9800 $CONFIG_INPUT $CONFIG_INPUT_MOUSE $CONFIG_ISA
+fi
diff -urN linux/drivers/input/mouse/Makefile linux98/drivers/input/mouse/Makefile
--- linux/drivers/input/mouse/Makefile	Sat Oct 19 13:01:17 2002
+++ linux98/drivers/input/mouse/Makefile	Thu Oct 24 17:00:51 2002
@@ -12,6 +12,7 @@
 obj-$(CONFIG_MOUSE_PC110PAD)	+= pc110pad.o
 obj-$(CONFIG_MOUSE_PS2)		+= psmouse.o
 obj-$(CONFIG_MOUSE_SERIAL)	+= sermouse.o
+obj-$(CONFIG_BUSMOUSE_PC9800)	+= 98busmouse.o
 
 # The global Rules.make.
 
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
--- linux/drivers/input/serio/Makefile	Sat Oct 19 13:01:09 2002
+++ linux98/drivers/input/serio/Makefile	Thu Oct 24 15:50:55 2002
@@ -17,6 +17,7 @@
 obj-$(CONFIG_SERIO_SA1111)	+= sa1111ps2.o
 obj-$(CONFIG_SERIO_AMBAKMI)	+= ambakmi.o
 obj-$(CONFIG_SERIO_Q40KBD)	+= q40kbd.o
+obj-$(CONFIG_SERIO_98KBD)	+= 98kbd-io.o
 
 # The global Rules.make.
 
diff -urN linux/drivers/input/serio/98kbd-io.c linux98/drivers/input/serio/98kbd-io.c
--- linux/drivers/input/serio/98kbd-io.c	Thu Jan  1 09:00:00 1970
+++ linux98/drivers/input/serio/98kbd-io.c	Thu Oct 24 16:29:57 2002
@@ -0,0 +1,181 @@
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
+#include <asm/io.h>
+
+#include <linux/delay.h>
+#include <linux/module.h>
+#include <linux/ioport.h>
+#include <linux/config.h>
+#include <linux/init.h>
+#include <linux/serio.h>
+#include <linux/sched.h>
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
+#ifdef CONFIG_VT
+	kbd_pt_regs = regs;
+#endif
+
+	spin_lock_irqsave(&kbd98io_lock, flags);
+
+	data = inb(KBD98_DATA_REG);
+	spin_unlock_irqrestore(&kbd98io_lock, flags);
+	serio_interrupt(&kbd98_port, data, 0);
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
diff -urN linux/include/linux/serio.h linux98/include/linux/serio.h
--- linux/include/linux/serio.h	Sat Oct 19 13:01:58 2002
+++ linux98/include/linux/serio.h	Thu Oct 24 09:39:09 2002
@@ -97,6 +97,7 @@
 #define SERIO_8042	0x01000000UL
 #define SERIO_RS232	0x02000000UL
 #define SERIO_HIL_MLC	0x03000000UL
+#define SERIO_PC9800	0x04000000UL
 
 #define SERIO_PROTO	0xFFUL
 #define SERIO_MSC	0x01
