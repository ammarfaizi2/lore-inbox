Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264257AbTFUNq3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jun 2003 09:46:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263837AbTFUNii
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jun 2003 09:38:38 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:23458 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S263944AbTFUNiC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jun 2003 09:38:02 -0400
Subject: [PATCH 11/11] input: Make GC_PSX_DELAY lower and configurable
In-Reply-To: <10562035174020@twilight.ucw.cz>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Sat, 21 Jun 2003 15:51:57 +0200
Message-Id: <10562035172209@twilight.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Vojtech Pavlik <vojtech@ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/input

===================================================================

ChangeSet@1.1369, 2003-06-21 04:49:07-07:00, vojtech@kernel.bkbits.net
  input: make GC_PSX_DELAY lower (25 usec instead of 60), to burn less
         CPU time while reading PSX pads, and make it a module parameter also,
         for devices which would need the huge value of 60.


 gamecon.c |   18 +++++++++++++-----
 1 files changed, 13 insertions(+), 5 deletions(-)

===================================================================

diff -Nru a/drivers/input/joystick/gamecon.c b/drivers/input/joystick/gamecon.c
--- a/drivers/input/joystick/gamecon.c	Sat Jun 21 15:26:06 2003
+++ b/drivers/input/joystick/gamecon.c	Sat Jun 21 15:26:06 2003
@@ -46,6 +46,7 @@
 MODULE_PARM(gc, "2-6i");
 MODULE_PARM(gc_2,"2-6i");
 MODULE_PARM(gc_3,"2-6i");
+MODULE_PARM(gc_psx_delay, "i");
 
 #define GC_SNES		1
 #define GC_NES		2
@@ -213,7 +214,7 @@
  *	
  */
 
-#define GC_PSX_DELAY	60		/* 60 usec */
+#define GC_PSX_DELAY	25		/* 25 usec */
 #define GC_PSX_LENGTH	8		/* talk to the controller in bytes */
 
 #define GC_PSX_MOUSE	1		/* Mouse */
@@ -230,6 +231,7 @@
 #define GC_PSX_ID(x)	((x) >> 4)	/* High nibble is device type */
 #define GC_PSX_LEN(x)	((x) & 0xf)	/* Low nibble is length in words */
 
+static int gc_psx_delay = GC_PSX_DELAY;
 static short gc_psx_abs[] = { ABS_X, ABS_Y, ABS_RX, ABS_RY, ABS_HAT0X, ABS_HAT0Y };
 static short gc_psx_btn[] = { BTN_TL, BTN_TR, BTN_TL2, BTN_TR2, BTN_A, BTN_B, BTN_X, BTN_Y,
 				BTN_START, BTN_SELECT, BTN_THUMBL, BTN_THUMBR };
@@ -246,10 +248,10 @@
 	for (i = 0; i < 8; i++, b >>= 1) {
 		cmd = (b & 1) ? GC_PSX_COMMAND : 0;
 		parport_write_data(gc->pd->port, cmd | GC_PSX_POWER);
-		udelay(GC_PSX_DELAY);
+		udelay(gc_psx_delay);
 		data |= ((parport_read_status(gc->pd->port) ^ 0x80) & gc->pads[GC_PSX]) ? (1 << i) : 0;
 		parport_write_data(gc->pd->port, cmd | GC_PSX_CLOCK | GC_PSX_POWER);
-		udelay(GC_PSX_DELAY);
+		udelay(gc_psx_delay);
 	}
 	return data;
 }
@@ -265,9 +267,9 @@
 	unsigned long flags;
 
 	parport_write_data(gc->pd->port, GC_PSX_CLOCK | GC_PSX_SELECT | GC_PSX_POWER);	/* Select pad */
-	udelay(GC_PSX_DELAY * 2);
+	udelay(gc_psx_delay * 2);
 	parport_write_data(gc->pd->port, GC_PSX_CLOCK | GC_PSX_POWER);			/* Deselect, begin command */
-	udelay(GC_PSX_DELAY * 2);
+	udelay(gc_psx_delay * 2);
 
 	local_irq_save(flags);
 
@@ -649,9 +651,15 @@
 	for (i = 0; i <= ints[0] && i < 6; i++) gc_3[i] = ints[i + 1];
 	return 1;
 }
+static int __init gc_psx_setup(char *str)
+{
+        get_option(&str, &gc_psx_delay);
+        return 1;
+}
 __setup("gc=", gc_setup);
 __setup("gc_2=", gc_setup_2);
 __setup("gc_3=", gc_setup_3);
+__setup("gc_psx_delay=", gc_psx_setup);
 #endif
 
 int __init gc_init(void)

