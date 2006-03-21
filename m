Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965015AbWCUEPu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965015AbWCUEPu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 23:15:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965018AbWCUEPu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 23:15:50 -0500
Received: from tek-gate.raphnet.net ([206.248.136.62]:5582 "EHLO
	daevas.nihilisme.ca") by vger.kernel.org with ESMTP id S965015AbWCUEPt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 23:15:49 -0500
Date: Mon, 20 Mar 2006 23:02:48 -0500
From: Raphael Assenat <raph@raphnet.net>
To: Pavlik Vojtech <vojtech@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Adds SNES mouse support to gamecon
Message-ID: <20060321040248.GL17348@aramis.lan.raphnet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds SNES mouse support to the gamecon joystick driver and
corresponding documentation to joystick-parport.txt

SNES gamepads and mice share the same type of interface so they both can be
connected to the parallel port using a simple interface. Adding mouse
support to a gamepad driver may sound funny at first, but doing so in
this case makes it possible to connect and SNES gamepads and mice at the
same time, on the same port.

This patch applies to today's (Mar 20, 2006) Linus git kernel at 
rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git

Signed-off-by: Raphael Assenat <raph@raphnet.net>
---

diff --git a/Documentation/input/joystick-parport.txt b/Documentation/input/joystick-parport.txt
index 88a011c..fa7bf93 100644
--- a/Documentation/input/joystick-parport.txt
+++ b/Documentation/input/joystick-parport.txt
@@ -36,12 +36,12 @@ with them.
 
   All NES and SNES use the same synchronous serial protocol, clocked from
 the computer's side (and thus timing insensitive). To allow up to 5 NES
-and/or SNES gamepads connected to the parallel port at once, the output
-lines of the parallel port are shared, while one of 5 available input lines
-is assigned to each gamepad.
+and/or SNES gamepads and/or SNES mice connected to the parallel port at once, 
+the output lines of the parallel port are shared, while one of 5 available 
+input lines is assigned to each gamepad.
 
   This protocol is handled by the gamecon.c driver, so that's the one
-you'll use for NES and SNES gamepads.
+you'll use for NES, SNES gamepads and SNES mice.
 
   The main problem with PC parallel ports is that they don't have +5V power
 source on any of their pins. So, if you want a reliable source of power
@@ -106,7 +106,7 @@ A, Turbo B, Select and Start, and is con
 either a NES or NES clone and will work with this connection. SNES gamepads
 also use 5 wires, but have more buttons. They will work as well, of course.
 
-Pinout for NES gamepads                 Pinout for SNES gamepads
+Pinout for NES gamepads                 Pinout for SNES gamepads and mice
 
 	   +----> Power                   +-----------------------\
 	   |                            7 | o  o  o  o |  x  x  o  | 1
@@ -454,6 +454,7 @@ uses the following kernel/module command
 	  6  | N64 pad
 	  7  | Sony PSX controller
 	  8  | Sony PSX DDR controller
+	  9  | SNES mouse
 
   The exact type of the PSX controller type is autoprobed when used so
 hot swapping should work (but is not recomended).
diff --git a/drivers/input/joystick/gamecon.c b/drivers/input/joystick/gamecon.c
index 900587a..53610ca 100644
--- a/drivers/input/joystick/gamecon.c
+++ b/drivers/input/joystick/gamecon.c
@@ -7,6 +7,7 @@
  *  Based on the work of:
  *	Andree Borrmann		John Dahlstrom
  *	David Kuder		Nathan Hand
+ *	Raphael Assenat
  */
 
 /*
@@ -72,8 +73,9 @@ __obsolete_setup("gc_3=");
 #define GC_N64		6
 #define GC_PSX		7
 #define GC_DDR		8
+#define GC_SNESMOUSE	9
 
-#define GC_MAX		8
+#define GC_MAX		9
 
 #define GC_REFRESH_TIME	HZ/100
 
@@ -93,7 +95,7 @@ static int gc_status_bit[] = { 0x40, 0x8
 
 static char *gc_names[] = { NULL, "SNES pad", "NES pad", "NES FourPort", "Multisystem joystick",
 				"Multisystem 2-button joystick", "N64 controller", "PSX controller",
-				"PSX DDR controller" };
+				"PSX DDR controller", "SNES mouse" };
 /*
  * N64 support.
  */
@@ -205,9 +207,12 @@ static void gc_n64_process_packet(struct
  * NES/SNES support.
  */
 
-#define GC_NES_DELAY	6	/* Delay between bits - 6us */
-#define GC_NES_LENGTH	8	/* The NES pads use 8 bits of data */
-#define GC_SNES_LENGTH	12	/* The SNES true length is 16, but the last 4 bits are unused */
+#define GC_NES_DELAY		6	/* Delay between bits - 6us */
+#define GC_NES_LENGTH		8	/* The NES pads use 8 bits of data */
+#define GC_SNES_LENGTH		12	/* The SNES true length is 16, but the 
+					   last 4 bits are unused */
+#define GC_SNESMOUSE_LENGTH	32	/* The SNES mouse uses 32 bits, the first
+					   16 bits are equivalent to a gamepad */
 
 #define GC_NES_POWER	0xfc
 #define GC_NES_CLOCK	0x01
@@ -242,11 +247,16 @@ static void gc_nes_read_packet(struct gc
 
 static void gc_nes_process_packet(struct gc *gc)
 {
-	unsigned char data[GC_SNES_LENGTH];
+	unsigned char data[GC_SNESMOUSE_LENGTH];
 	struct input_dev *dev;
-	int i, j, s;
+	int i, j, s, len;
+	char x_rel, y_rel;
 
-	gc_nes_read_packet(gc, gc->pads[GC_SNES] ? GC_SNES_LENGTH : GC_NES_LENGTH, data);
+	len = gc->pads[GC_SNES] ? GC_SNES_LENGTH : GC_NES_LENGTH;
+	if (gc->pads[GC_SNESMOUSE])
+		len = GC_SNESMOUSE_LENGTH;
+	
+	gc_nes_read_packet(gc, len, data);
 
 	for (i = 0; i < GC_MAX_DEVICES; i++) {
 
@@ -269,6 +279,52 @@ static void gc_nes_process_packet(struct
 			for (j = 0; j < 8; j++)
 				input_report_key(dev, gc_snes_btn[j], s & data[gc_snes_bytes[j]]);
 
+		if (s & gc->pads[GC_SNESMOUSE]) {
+			/* The 4 unused bits from SNES 
+			 * controllers appear to be ID bits.
+			 * I use them to make sure a mouse and not a
+			 * gamepad is connected. This is important since 
+			 * my SNES gamepad sends 1's for bits 16-31, which 
+			 * cause the mouse pointer to quickly move to the 
+			 * upper left corner of the screen.
+			 */
+			if (	!(s & data[12]) &&
+				!(s & data[13]) &&
+				!(s & data[14]) &&
+				(s & data[15]))
+			{
+				input_report_key(dev, BTN_LEFT, s & data[9]);
+				input_report_key(dev, BTN_RIGHT, s & data[8]);
+				
+				x_rel = 0;
+				y_rel = 0;
+				for (j=0; j<7; j++) {
+					x_rel <<= 1;
+					if (data[25+j] & s)
+						x_rel |= 1;
+					
+					y_rel <<= 1;
+					if (data[17+j] & s)
+						y_rel |= 1;
+				}
+
+				if (x_rel) {
+					if (data[24] & s) 
+						x_rel = -x_rel;
+
+					input_report_rel(dev, REL_X, x_rel);
+				}
+			
+				if (y_rel) {
+					if (data[16] & s)
+						y_rel = -y_rel;
+				
+					input_report_rel(dev, REL_Y, y_rel);
+				}
+			}
+		}
+			
+		
 		input_sync(dev);
 	}
 }
@@ -524,10 +580,10 @@ static void gc_timer(unsigned long priva
 		gc_n64_process_packet(gc);
 
 /*
- * NES and SNES pads
+ * NES and SNES pads or mouse
  */
 
-	if (gc->pads[GC_NES] || gc->pads[GC_SNES])
+	if (gc->pads[GC_NES] || gc->pads[GC_SNES] || gc->pads[GC_SNESMOUSE])
 		gc_nes_process_packet(gc);
 
 /*
@@ -609,11 +665,16 @@ static int __init gc_setup_pad(struct gc
 	input_dev->open = gc_open;
 	input_dev->close = gc_close;
 
-	input_dev->evbit[0] = BIT(EV_KEY) | BIT(EV_ABS);
-
-	for (i = 0; i < 2; i++)
-		input_set_abs_params(input_dev, ABS_X + i, -1, 1, 0, 0);
-
+	if (pad_type != GC_SNESMOUSE)
+	{
+		input_dev->evbit[0] = BIT(EV_KEY) | BIT(EV_ABS);
+
+		for (i = 0; i < 2; i++)
+			input_set_abs_params(input_dev, ABS_X + i, -1, 1, 0, 0);
+	}
+	else
+		input_dev->evbit[0] = BIT(EV_KEY) | BIT(EV_REL);
+		
 	gc->pads[0] |= gc_status_bit[idx];
 	gc->pads[pad_type] |= gc_status_bit[idx];
 
@@ -630,6 +691,13 @@ static int __init gc_setup_pad(struct gc
 
 			break;
 
+		case GC_SNESMOUSE:
+			set_bit(BTN_LEFT, input_dev->keybit);
+			set_bit(BTN_RIGHT, input_dev->keybit);
+			set_bit(REL_X, input_dev->relbit);
+			set_bit(REL_Y, input_dev->relbit);
+			break;
+			
 		case GC_SNES:
 			for (i = 4; i < 8; i++)
 				set_bit(gc_snes_btn[i], input_dev->keybit);
