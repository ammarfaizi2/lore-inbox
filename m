Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264655AbTIDEKm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 00:10:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264658AbTIDEKm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 00:10:42 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:49376 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S264655AbTIDEKS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 00:10:18 -0400
Date: Thu, 04 Sep 2003 00:09:21 -0400
From: Chris Heath <chris@heathens.co.nz>
To: aebr@win.tue.nl
Subject: Re: keyboard - was: Re: Linux 2.6.0-test4
Cc: linux-kernel@vger.kernel.org, vojtech@ucw.cz,
       Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
In-Reply-To: 20030902234133.A1627@pclin040.win.tue.nl
Message-Id: <20030903235647.C765.CHRIS@heathens.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.06.02
X-Antirelay: Good relay from local net1 127.0.0.1/32
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Right now, my CTRL key is totally "stuck" on the fbconsole. I can't
> > release it, not even by switching between the consoles and/or X11.
> > 
> > > > atkbd.c: Unknown key (set 2, scancode 0x9c, on isa0060/serio0) pressed.
> > > > i8042 history: e0 d0 1c 9c 2e ae 10 90 e0 50 e0 d0 e0 d0 1c 9c
> 
> Well, that shows that this particular problem was solved, but there are
> more problems. No doubt we'll understand everything eventually.

Quite right.  When we get a repeated key release, say e0 d0 e0 d0, we
were ignoring the last d0, whereas actually we should have ignored the
second e0 too.  As you can imagine, this caused stuck CTRL keys among
other things.

> > But now I don't get any messages like the one below (yes, the special
> > code generating this output is still active...)

Since then, Ralf has reported to me in a private email that he got the
following (rather troubling) error:

Sep  2 14:43:51 hummus2 kernel: atkbd.c: Unknown key (set 2, scancode 0xb2, on isa0060/serio0) pressed.
Sep  2 14:43:51 hummus2 kernel: i8042 history: e0 48 e0 c8 22 a2 13 93 93 17 97 32 31 b2 b1 b2

So it seems it is occasionally possible to have a repeated key release
(b2) with another key release (b1) in between.  Ouch!

The patch below is supposed to solve both these problems.  It makes some 
assumptions, which I have listed below.  (It probably wouldn't be hard to 
remove any of these assumptions, but I don't feel like hacking this
code any more than I have to.)

1. I assume it is OK to defer processing the code e0 until the following
byte arrives.  Are there any keyboards out there with e0 in the keyboard
ID?  This could break the atkbd probe for such keyboards.  (The
alternative would be to pass the repeated key releases through to atkbd,
and let that layer remove the duplicates.)

2. The event that appears between two repeated key releases is always a
key release and not a key press.

3. There will only be at most one key event in between two repeated key 
releases.

Chris


--- linux-2.6.0-test4-bk5/drivers/input/serio/i8042.c	2003-08-09 11:58:10.000000000 -0400
+++ linux-2.6.0-test4-cdh1/drivers/input/serio/i8042.c	2003-09-03 22:30:52.000000000 -0400
@@ -59,7 +59,7 @@
 static unsigned char i8042_initial_ctr;
 static unsigned char i8042_ctr;
 static unsigned char i8042_last_e0;
-static unsigned char i8042_last_release;
+static unsigned char i8042_last_release[2];
 static unsigned char i8042_mux_open;
 struct timer_list i8042_timer;
 
@@ -343,7 +343,7 @@
 static irqreturn_t i8042_interrupt(int irq, void *dev_id, struct pt_regs *regs)
 {
 	unsigned long flags;
-	unsigned char str, data;
+	unsigned char str, data, index;
 	unsigned int dfl;
 	struct {
 		int data;
@@ -405,30 +405,39 @@
 			continue;
 		}
 
+		index = (data & 0x7f) | (i8042_last_e0 << 7);
+
+		/* work around hardware that doubles key releases */
+		if (data > 0x7f && (index == i8042_last_release[0]
+				|| index == i8042_last_release[1])) {
+			dbg("i8042 skipped double release (%d)\n", index);
+			i8042_last_e0 = 0;
+			continue;
+		}
+
+		if (i8042_last_e0)
+			serio_interrupt(&i8042_kbd_port, 0xe0, dfl, regs);
 		if (data > 0x7f) {
-			unsigned char index = (data & 0x7f) | (i8042_last_e0 << 7);
-			/* work around hardware that doubles key releases */
-			if (index == i8042_last_release) {
-				dbg("i8042 skipped double release (%d)\n", index);
-				i8042_last_e0 = 0;
-				continue;
-			}
 			if (index == 0xaa || index == 0xb6)
 				set_bit(index, i8042_unxlate_seen);
 			if (test_and_clear_bit(index, i8042_unxlate_seen)) {
 				serio_interrupt(&i8042_kbd_port, 0xf0, dfl, regs);
 				data = i8042_unxlate_table[data & 0x7f];
-				i8042_last_release = index;
+				i8042_last_release[1] = i8042_last_release[0];
+				i8042_last_release[0] = index;
 			}
 		} else {
-			set_bit(data | (i8042_last_e0 << 7), i8042_unxlate_seen);
+			set_bit(index, i8042_unxlate_seen);
 			data = i8042_unxlate_table[data];
-			i8042_last_release = 0;
+			i8042_last_release[1] = 0;
+			i8042_last_release[0] = 0;
 		}
 
 		i8042_last_e0 = (data == 0xe0);
 
-		serio_interrupt(&i8042_kbd_port, data, dfl, regs);
+		/* defer sending e0 in case it's part of a double key release */
+		if (!i8042_last_e0)
+			serio_interrupt(&i8042_kbd_port, data, dfl, regs);
 	}
 
 	/* FIXME - was it really ours? */

