Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272559AbTG1BHa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 21:07:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272557AbTG1ADr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 20:03:47 -0400
Received: from zeus.kernel.org ([204.152.189.113]:31477 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S272736AbTG0W6o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 18:58:44 -0400
Date: Sun, 27 Jul 2003 21:29:34 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200307272029.h6RKTYEd029859@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: PATCH: work around tosh keyboards
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


These produce double ups sometimes
(Chris Heath)

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.0-test2/drivers/input/serio/i8042.c linux-2.6.0-test2-ac1/drivers/input/serio/i8042.c
--- linux-2.6.0-test2/drivers/input/serio/i8042.c	2003-07-10 21:04:55.000000000 +0100
+++ linux-2.6.0-test2-ac1/drivers/input/serio/i8042.c	2003-07-23 15:37:45.000000000 +0100
@@ -59,6 +59,7 @@
 static unsigned char i8042_initial_ctr;
 static unsigned char i8042_ctr;
 static unsigned char i8042_last_e0;
+static unsigned char i8042_last_release;
 static unsigned char i8042_mux_open;
 struct timer_list i8042_timer;
 
@@ -406,15 +407,22 @@
 
 		if (data > 0x7f) {
 			unsigned char index = (data & 0x7f) | (i8042_last_e0 << 7);
+			/* work around hardware that doubles key releases */
+			if (index == i8042_last_release) {
+				dbg("i8042 skipped double release (%d)\n", index);
+				continue;
+			}
 			if (index == 0xaa || index == 0xb6)
 				set_bit(index, i8042_unxlate_seen);
 			if (test_and_clear_bit(index, i8042_unxlate_seen)) {
 				serio_interrupt(&i8042_kbd_port, 0xf0, dfl, regs);
 				data = i8042_unxlate_table[data & 0x7f];
+				i8042_last_release = index;
 			}
 		} else {
 			set_bit(data | (i8042_last_e0 << 7), i8042_unxlate_seen);
 			data = i8042_unxlate_table[data];
+			i8042_last_release = 0;
 		}
 
 		i8042_last_e0 = (data == 0xe0);
