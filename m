Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262033AbTHaQWy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 12:22:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262347AbTHaQWy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 12:22:54 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:11418 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S262033AbTHaQWv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 12:22:51 -0400
Date: Sun, 31 Aug 2003 12:22:08 -0400
From: Chris Heath <chris@heathens.co.nz>
To: Ralf.Hildebrandt@charite.de
Subject: Re: Re:Re: Linux 2.6.0-test4
Cc: linux-kernel@vger.kernel.org
In-Reply-To: 20030830145900.GB6862@charite.de
Message-Id: <20030831120605.08D6.CHRIS@heathens.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.06.02
X-Antirelay: Good relay from local net1 127.0.0.1/32
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Aug 27 18:53:41 hummus2 kernel: atkbd.c: Unknown key (set 2, scancode 0x9d, on isa0060/serio0) pressed.
> Aug 27 19:15:14 hummus2 kernel: atkbd.c: Unknown key (set 2, scancode 0xb9, on isa0060/serio0) pressed.
> Aug 27 19:42:50 hummus2 kernel: atkbd.c: Unknown key (set 2, scancode 0x9d, on isa0060/serio0) pressed.
> Aug 28 10:14:14 hummus2 kernel: atkbd.c: Unknown key (set 2, scancode 0x9d, on isa0060/serio0) pressed.
> 
> Basically, CTRL was stuck. Even when I switched to X11.

Well, this completely baffles me.  I thought X11 maintains its own
keydown array.

Anyway, I've included a patch that should hopefully give us better
debugging information.  When you get an unknown key error, it will also
dump the last 16 bytes that were sent from the keyboard.  Be careful
with this one.  If you post any errors to the list, make sure it doesn't
contain any sensitive passwords. :-)

Chris


--- a/drivers/input/serio/i8042.c	2003-08-09 11:58:10.000000000 -0400
+++ b/drivers/input/serio/i8042.c	2003-08-31 10:16:55.000000000 -0400
@@ -62,6 +62,7 @@
 static unsigned char i8042_last_release;
 static unsigned char i8042_mux_open;
 struct timer_list i8042_timer;
+unsigned char i8042_history[16];
 
 /*
  * Shared IRQ's require a device pointer, but this driver doesn't support
@@ -334,6 +335,14 @@
 static char i8042_mux_short[4][16];
 static char i8042_mux_phys[4][32];
 
+void dump_i8042_history(void) {
+	int i;
+	printk(KERN_WARNING "i8042 history: ");
+	for (i=0; i<sizeof(i8042_history); i++)
+		printk("%02x ", i8042_history[i]);
+	printk("\n");
+}
+
 /*
  * i8042_interrupt() is the most important function in this driver -
  * it handles the interrupts from the i8042, and sends incoming bytes
@@ -405,6 +414,8 @@
 			continue;
 		}
 
+		memmove(i8042_history, &i8042_history[1], sizeof(i8042_history)-1);
+		i8042_history[sizeof(i8042_history)-1] = data;
 		if (data > 0x7f) {
 			unsigned char index = (data & 0x7f) | (i8042_last_e0 << 7);
 			/* work around hardware that doubles key releases */
--- a/drivers/input/keyboard/atkbd.c	2003-06-22 18:45:06.000000000 -0400
+++ b/drivers/input/keyboard/atkbd.c	2003-08-31 10:11:51.000000000 -0400
@@ -131,6 +131,7 @@
  * atkbd_interrupt(). Here takes place processing of data received from
  * the keyboard into events.
  */
+void dump_i8042_history(void);
 
 static irqreturn_t atkbd_interrupt(struct serio *serio, unsigned char data,
 			unsigned int flags, struct pt_regs *regs)
@@ -193,6 +194,7 @@
 		case ATKBD_KEY_UNKNOWN:
 			printk(KERN_WARNING "atkbd.c: Unknown key (set %d, scancode %#x, on %s) %s.\n",
 				atkbd->set, code, serio->phys, atkbd->release ? "released" : "pressed");
+			dump_i8042_history();
 			break;
 		default:
 			input_regs(&atkbd->dev, regs);

