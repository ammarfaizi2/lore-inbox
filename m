Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262054AbTELJt2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 05:49:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262050AbTELJtW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 05:49:22 -0400
Received: from amsfep12-int.chello.nl ([213.46.243.18]:58425 "EHLO
	amsfep12-int.chello.nl") by vger.kernel.org with ESMTP
	id S262056AbTELJpO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 05:45:14 -0400
Date: Mon, 12 May 2003 11:54:42 +0200
Message-Id: <200305120954.h4C9sgW4001039@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] M68k IRQ API updates [15/20]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

M68k input drivers: Update to the new irq API (from Roman Zippel and me) [15/20]

--- linux-2.5.69/drivers/input/joystick/amijoy.c	Sun Feb 16 12:16:23 2003
+++ linux-m68k-2.5.69/drivers/input/joystick/amijoy.c	Fri May  9 10:21:31 2003
@@ -52,7 +52,7 @@
 
 static char *amijoy_name = "Amiga joystick";
 
-static void amijoy_interrupt(int irq, void *dummy, struct pt_regs *fp)
+static irqreturn_t amijoy_interrupt(int irq, void *dummy, struct pt_regs *fp)
 {
 	int i, data = 0, button = 0;
 
@@ -74,6 +74,7 @@
 
 			input_sync(amijoy_dev + i);
 		}
+	return IRQ_HANDLED;
 }
 
 static int amijoy_open(struct input_dev *dev)
--- linux-2.5.69/drivers/input/keyboard/amikbd.c	Sun Apr 20 12:28:34 2003
+++ linux-m68k-2.5.69/drivers/input/keyboard/amikbd.c	Fri May  9 10:21:31 2003
@@ -71,7 +71,7 @@
 static char *amikbd_name = "Amiga keyboard";
 static char *amikbd_phys = "amikbd/input0";
 
-static void amikbd_interrupt(int irq, void *dummy, struct pt_regs *fp)
+static irqreturn_t amikbd_interrupt(int irq, void *dummy, struct pt_regs *fp)
 {
 	unsigned char scancode, down;
 
@@ -93,16 +93,14 @@
 			input_report_key(&amikbd_dev, scancode, 1);
 			input_report_key(&amikbd_dev, scancode, 0);
 			input_sync(&amikbd_dev);
-			return;
+		} else {
+			input_report_key(&amikbd_dev, scancode, down);
+			input_sync(&amikbd_dev);
 		}
+	} else				/* scancodes >= 0x78 are error codes */
+		printk(amikbd_messages[scancode - 0x78]);
 
-		input_report_key(&amikbd_dev, scancode, down);
-		input_sync(&amikbd_dev);
-
-		return;
-	}
-
-	printk(amikbd_messages[scancode - 0x78]);	/* scancodes >= 0x78 are error codes */
+	return IRQ_HANDLED;
 }
 
 static int __init amikbd_init(void)
--- linux-2.5.69/drivers/input/mouse/amimouse.c	Sun Feb 16 12:16:23 2003
+++ linux-m68k-2.5.69/drivers/input/mouse/amimouse.c	Tue May  6 13:50:50 2003
@@ -40,7 +40,7 @@
 static char *amimouse_name = "Amiga mouse";
 static char *amimouse_phys = "amimouse/input0";
 
-static void amimouse_interrupt(int irq, void *dummy, struct pt_regs *fp)
+static irqreturn_t amimouse_interrupt(int irq, void *dummy, struct pt_regs *fp)
 {
 	unsigned short joy0dat, potgor;
 	int nx, ny, dx, dy;
@@ -73,6 +73,8 @@
 	input_report_key(&amimouse_dev, BTN_RIGHT,  potgor & 0x0400);
 
 	input_sync(&amimouse_dev);
+
+	return IRQ_HANDLED;
 }
 
 static int amimouse_open(struct input_dev *dev)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
