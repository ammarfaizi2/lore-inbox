Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291215AbSAaSUv>; Thu, 31 Jan 2002 13:20:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291216AbSAaSUk>; Thu, 31 Jan 2002 13:20:40 -0500
Received: from www.transvirtual.com ([206.14.214.140]:19471 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S291215AbSAaSU1>; Thu, 31 Jan 2002 13:20:27 -0500
Date: Thu, 31 Jan 2002 10:19:46 -0800 (PST)
From: James Simmons <jsimmons@transvirtual.com>
To: linux-m68k@lists.linux-m68k.org
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Q40 input api support.
Message-ID: <Pine.LNX.4.10.10201311009140.23385-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch ports q40 PS/2 controller support over to the input api. Please
try it out. It is against the latest dave jones tree.

   . ---
   |o_o |
   |:_/ |   Give Micro$oft the Bird!!!!
  //   \ \  Use Linux!!!!
 (|     | )
 /'_   _/`\
 ___)=(___/

diff -urN -X /home/jsimmons/dontdiff linux-2.5.2-dj7/drivers/input/serio/Config.in linux/drivers/input/serio/Config.in
--- linux-2.5.2-dj7/drivers/input/serio/Config.in	Tue Jan 29 17:36:39 2002
+++ linux/drivers/input/serio/Config.in	Thu Jan 31 11:06:02 2002
@@ -7,6 +7,7 @@
 dep_tristate '  i8042 PC Keyboard controller' CONFIG_SERIO_I8042 $CONFIG_SERIO $CONFIG_ISA
 dep_tristate '  Serial port line discipline' CONFIG_SERIO_SERPORT $CONFIG_SERIO 
 dep_tristate '  ct82c710 Aux port controller' CONFIG_SERIO_CT82C710 $CONFIG_SERIO $CONFIG_ISA
+dep_tristate '  Q40 keyboard controller' CONFIG_SERIO_Q40KBD $CONFIG_SERIO
 dep_tristate '  Parallel port keyboard adapter' CONFIG_SERIO_PARKBD $CONFIG_SERIO $CONFIG_PARPORT
 
 if [ "$CONFIG_ARCH_ACORN" = "y" ]; then
diff -urN -X /home/jsimmons/dontdiff linux-2.5.2-dj7/drivers/input/serio/Makefile linux/drivers/input/serio/Makefile
--- linux-2.5.2-dj7/drivers/input/serio/Makefile	Tue Jan 29 17:36:39 2002
+++ linux/drivers/input/serio/Makefile	Thu Jan 31 10:49:53 2002
@@ -18,6 +18,7 @@
 obj-$(CONFIG_SERIO_SERPORT)	+= serport.o
 obj-$(CONFIG_SERIO_CT82C710)	+= ct82c710.o
 obj-$(CONFIG_SERIO_RPCKBD)	+= rpckbd.o
+obj-$(CONFIG_SERIO_Q40KBD)	+= q40kbd.o
 
 # The global Rules.make.
 
diff -urN -X /home/jsimmons/dontdiff linux-2.5.2-dj7/drivers/input/serio/q40kbd.c linux/drivers/input/serio/q40kbd.c
--- linux-2.5.2-dj7/drivers/input/serio/q40kbd.c	Wed Dec 31 16:00:00 1969
+++ linux/drivers/input/serio/q40kbd.c	Thu Jan 31 10:41:56 2002
@@ -0,0 +1,104 @@
+/*
+ * $Id: q40kbd.c,v 1.9 2002/01/23 06:20:52 jsimmons Exp $
+ *
+ *  Copyright (c) 2000-2001 Vojtech Pavlik
+ *
+ *  Based on the work of:
+ *	unknown author
+ */
+
+/*
+ * Q40 PS/2 keyboard controller driver for Linux/m68k
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
+#include <linux/serio.h>
+
+#include <asm/keyboard.h>
+#include <asm/bitops.h>
+#include <asm/io.h>
+#include <asm/uaccess.h>
+#include <asm/q40_master.h>
+#include <asm/irq.h>
+#include <asm/q40ints.h>
+
+MODULE_AUTHOR("Vojtech Pavlik <vojtech@ucw.cz>");
+MODULE_DESCRIPTION("Q40 PS/2 keyboard controller driver");
+MODULE_LICENSE("GPL");
+
+static inline void q40kbd_write(unsigned char val)
+{
+	/* FIXME! We need a way how to write to the keyboard! */
+}
+
+static struct serio q40kbd_port =
+{
+	type:   SERIO_8042,
+	write:  q40kbd_write,
+	name:	"Q40 PS/2 kbd port",
+	phys:	"isa0060/serio0",
+};
+
+static void q40kbd_interrupt(int irq, void *dev_id, struct pt_regs *regs)
+{
+	unsigned long flags;
+
+	if (IRQ_KEYB_MASK & master_inb(INTERRUPT_REG))
+		if (q40kbd_port.dev)
+                         q40kbd_port.dev->interrupt(&q40kbd_port, master_inb(KEYCODE_REG), 0);
+
+	master_outb(-1, KEYBOARD_UNLOCK_REG);
+}
+
+void __init q40kbd_init(void)
+{
+	int maxread = 100;
+
+	/* Get the keyboard controller registers (incomplete decode) */
+	request_region(0x60, 16, "q40kbd");
+
+	/* allocate the IRQ */
+	request_irq(Q40_IRQ_KEYBOARD, keyboard_interrupt, 0, "q40kbd", NULL);
+
+	/* flush any pending input. */
+	while (maxread-- && (IRQ_KEYB_MASK & master_inb(INTERRUPT_REG)))
+		master_inb(KEYCODE_REG);
+	
+	/* off we go */
+	master_outb(-1,KEYBOARD_UNLOCK_REG);
+	master_outb(1,KEY_IRQ_ENABLE_REG);
+
+	register_serio_port(&q40kbd_port);
+	printk(KERN_INFO "serio: Q40 PS/2 kbd port irq %d\n", Q40_IRQ_KEYBOARD);
+}
+
+void __exit q40kbd_exit(void)
+{
+	unregister_serio_port(&q40kbd_port);
+	free_irq(Q40_IRQ_KEYBOARD, NULL);
+	release_region(0x60, 16);	
+}
+
+module_init(q40kbd_init);
+module_exit(q40kbd_exit);

