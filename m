Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291432AbSAaXtr>; Thu, 31 Jan 2002 18:49:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291434AbSAaXtl>; Thu, 31 Jan 2002 18:49:41 -0500
Received: from www.transvirtual.com ([206.14.214.140]:28178 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S291432AbSAaXt0>; Thu, 31 Jan 2002 18:49:26 -0500
Date: Thu, 31 Jan 2002 15:48:42 -0800 (PST)
From: James Simmons <jsimmons@transvirtual.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Linux/m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] amiga keyboard input II
In-Reply-To: <Pine.LNX.4.10.10201311512340.23385-100000@www.transvirtual.com>
Message-ID: <Pine.LNX.4.10.10201311544430.5906-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Here is the second patch with much improvements I got from this list.
Anyone want to try it out? You need to enable input support and Keyboard
Interface. Then go down and select Amiga keyboard. This is against the
Dave Jones tree.

   . ---
   |o_o |
   |:_/ |   Give Micro$oft the Bird!!!!
  //   \ \  Use Linux!!!!
 (|     | )
 /'_   _/`\
 ___)=(___/

diff -urN -X /home/jsimmons/dontdiff linux-2.5.2-dj7/drivers/input/keyboard/Config.in linux/drivers/input/keyboard/Config.in
--- linux-2.5.2-dj7/drivers/input/keyboard/Config.in	Tue Jan 29 17:36:39 2002
+++ linux/drivers/input/keyboard/Config.in	Thu Jan 31 16:38:00 2002
@@ -12,3 +12,7 @@
 if [ "$CONFIG_SH_DREAMCAST" = "y" ]; then
    dep_tristate '  Maple bus keyboard support' CONFIG_KEYBOARD_MAPLE $CONFIG_INPUT $CONFIG_INPUT_KEYBOARD $CONFIG_MAPLE
 fi
+
+if [ "$CONFIG_AMIGA" = "y" ]; then
+   dep_tristate '  Amiga keyboard' CONFIG_KEYBOARD_AMIKBD $CONFIG_INPUT $CONFIG_INPUT_KEYBOARD
+fi
diff -urN -X /home/jsimmons/dontdiff linux-2.5.2-dj7/drivers/input/keyboard/Makefile linux/drivers/input/keyboard/Makefile
--- linux-2.5.2-dj7/drivers/input/keyboard/Makefile	Tue Jan 29 17:36:39 2002
+++ linux/drivers/input/keyboard/Makefile	Thu Jan 31 16:38:00 2002
@@ -13,6 +13,7 @@
 obj-$(CONFIG_KEYBOARD_PS2SERKBD)	+= ps2serkbd.o
 obj-$(CONFIG_KEYBOARD_SUNKBD)		+= sunkbd.o
 obj-$(CONFIG_KEYBOARD_XTKBD)		+= xtkbd.o
+obj-$(CONFIG_KEYBOARD_AMIGA)		+= amikbd.o
 
 # The global Rules.make.
 
diff -urN -X /home/jsimmons/dontdiff linux-2.5.2-dj7/drivers/input/keyboard/amikbd.c linux/drivers/input/keyboard/amikbd.c
--- linux-2.5.2-dj7/drivers/input/keyboard/amikbd.c	Wed Dec 31 16:00:00 1969
+++ linux/drivers/input/keyboard/amikbd.c	Thu Jan 31 16:38:27 2002
@@ -0,0 +1,140 @@
+/*
+ * $Id: amikbd.c,v 1.11 2002/01/31 23:05:28 jsimmons Exp $
+ *
+ *  Copyright (c) 2000-2001 Vojtech Pavlik
+ *
+ *  Based on the work of:
+ *	Hamish Macdonald
+ */
+
+/*
+ * Amiga keyboard driver for Linux/m68k
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
+ * Should you need to contact me, the author, you can do so either by
+ * e-mail - mail your message to <vojtech@ucw.cz>, or by paper mail:
+ * Vojtech Pavlik, Simunkova 1594, Prague 8, 182 00 Czech Republic
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/input.h>
+
+#include <asm/amigaints.h>
+#include <asm/amigahw.h>
+#include <asm/irq.h>
+
+MODULE_AUTHOR("Vojtech Pavlik <vojtech@ucw.cz>");
+MODULE_DESCRIPTION("Amiga keyboard driver");
+MODULE_LICENSE("GPL");
+
+static unsigned char amikbd_keycode[0x78] = {
+	 41,  2,  3,  4,  5,  6,  7,  8,  9, 10, 11, 12, 13, 43,  0, 82,
+	 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27,  0, 79, 80, 81,
+	 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40,  0,  0, 75, 76, 77,
+	  0, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53,  0, 83, 71, 72, 73,
+	 57, 14, 15, 96, 28,  1,111,  0,  0,  0, 74,  0,103,108,106,105,
+	 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 98, 55, 78, 87,
+	 42, 54, 58, 29, 56,100
+}
+
+static char *amikbd_messages[] = {
+	KERN_ALERT "amikbd: Ctrl-Amiga-Amiga reset warning!!\n",
+	KERN_WARNING "amikbd: keyboard lost sync\n",
+	KERN_WARNING "amikbd: keyboard buffer overflow\n",
+	KERN_WARNING "amikbd: keyboard controller failure\n",
+	KERN_ERR "amikbd: keyboard selftest failure\n",
+	KERN_INFO "amikbd: initiate power-up key stream\n",
+	KERN_INFO "amikbd: terminate power-up key stream\n",
+	KERN_WARNING "amikbd: keyboard interrupt\n"
+};
+
+static struct input_dev amikbd_dev;
+
+static char *amikbd_name = "Amiga keyboard";
+static char *amikbd_phys = "amikbd/input0";
+
+static void amikbd_interrupt(int irq, void *dummy, struct pt_regs *fp)
+{
+	unsigned char scancode, down;
+
+	scancode = ~ciaa.sdr;		/* get and invert scancode (keyboard is active low) */
+	ciaa.cra |= 0x40;		/* switch SP pin to output for handshake */
+	udelay(85);			/* wait until 85 us have expired */
+	ciaa.cra &= ~0x40;		/* switch CIA serial port to input mode */
+
+	scancode = scancode >> 1;	/* lowest bit is release bit */
+	down = scancode & 1;
+
+	if (scancode < 0x78) {		/* scancodes < 0x78 are keys */
+
+		scancode = amikbd_keycode[scancode];
+	
+		if (scancode == KEY_CAPS) {	/* CapsLock is a toggle switch key on Amiga */
+			input_report_key(&amikbd_dev, scancode, 1);
+			input_report_key(&amikbd_dev, scancode, 0);
+			return;
+		}
+		
+		input_report_key(&amikbd_dev, scancode, down);
+
+		return;
+	}
+
+	printk(amikbd_messages[scancode - 0x78]);	/* scancodes >= 0x78 are error codes */
+}
+
+static int __init amikbd_init(void)
+{
+	int i;
+
+	if (!AMIGAHW_PRESENT(AMI_KEYBOARD))
+		return -EIO;
+
+	amikbd_dev.evbit[0] = BIT(EV_KEY) | BIT(EV_REP);	
+	amikbd_dev.keycode = amikbd_keycode;
+	
+ 	for (i = 0; i < 0x78; i++)
+		if (amikbd_keycode[i])
+			set_bit(amikbd_keycode[i], amikbd_dev.keybit);
+
+	ciaa.cra &= ~0x41;	 /* serial data in, turn off TA */
+	request_irq(IRQ_AMIGA_CIAA_SP, amikbd_interrupt, 0, "amikbd", NULL);
+
+	amikbd_dev.name = amikbd_name;
+	amikbd_dev.phys = amikbd_phys;
+	amikbd_dev.idbus = BUS_AMIGA;
+	amikbd_dev.idvendor = 0x0001;
+	amikbd_dev.idproduct = 0x0001;
+	amikbd_dev.idversion = 0x0100;
+
+	input_register_device(&amikbd_dev);
+
+	printk(KERN_INFO "input: %s\n", amikbd_name);
+
+	return 0;
+}
+
+static void __exit amikbd_exit(void)
+{
+	input_unregister_device(&amikbd_dev);
+	free_irq(IRQ_AMIGA_CIAA_SP, amikbd_interrupt);
+}
+
+module_init(amikbd_init);
+module_exit(amikbd_exit);

