Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271038AbTGVWXF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jul 2003 18:23:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271039AbTGVWXF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jul 2003 18:23:05 -0400
Received: from sccrmhc12.comcast.net ([204.127.202.56]:6575 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S271038AbTGVWXC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jul 2003 18:23:02 -0400
Date: Tue, 22 Jul 2003 18:37:47 -0400
From: Chris Heath <chris@heathens.co.nz>
To: vojtech@suse.cz
Subject: [PATCH][2.6] Fix for Toshiba laptop keyboards
Cc: linux-kernel@vger.kernel.org
Message-Id: <20030722182817.9F8A.CHRIS@heathens.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.06.02
X-Antirelay: Good relay from local net1 127.0.0.1/32
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a patch that fixes the problem we've seen on Toshiba laptop
keyboards.

It has been tested on my regular keyboard, and Ralf Hildebrandt has
confirmed that it fixes the problem on his Toshiba.

Chris


--- a/drivers/input/serio/i8042.c	2003-06-01 09:56:28.000000000 -0400
+++ b/drivers/input/serio/i8042.c	2003-07-21 22:19:53.000000000 -0400
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

